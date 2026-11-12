# Shared code for the combined-exposure models: input preparation, CR2 inference, BH FDR, VIF and output tables; sourced by both H5_combined_* scripts.

COMBINED_FILE_PREFIX <- paste0("H5_combined_", COMBINED_VARIANT)
COMBINED_RESULTS_ROOT <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results")
OUT_DIR <- file.path(COMBINED_RESULTS_ROOT, COMBINED_FILE_PREFIX)
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
COMBINED_OUTCOMES <- combined_study_spec$physiological_outcome_names
COMBINED_PHASE_SUM_COLS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")

# Left/right sensor pairs averaged row-wise.
COMBINED_AVERAGE_SOURCES <- list(
  atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
  lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))

# Fixed terms of an Eq quote without the _bout_z / _phase_z suffix.
combined_fixed_terms <- function(equation) {
  labels <- attr(terms(as.formula(equation[[2L]])), "term.labels")
  gsub("_(phase|bout)_z", "", gsub("`", "", labels, fixed = TRUE))}

# Study rows with sensor averages, HRV availability and the SVF endpoint carry-forward.
combined_read_input <- function() {
  raw_df <- read.csv(RAW_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE)
  for (name in names(COMBINED_AVERAGE_SOURCES)) raw_df[[name]] <- rowMeans(raw_df[, COMBINED_AVERAGE_SOURCES[[name]]], na.rm = TRUE)
  raw_df <- raw_df[raw_df$ParticipantID %in% combined_study_spec$participants & raw_df$PhaseID %in% combined_study_spec$phases, , drop = FALSE]
  available <- tolower(as.character(raw_df$empatica_hrv_fd_5min_available)) %in% c("true", "1")
  for (name in attr(COMBINED_OUTCOMES, "empatica_hrv_fd_window")) raw_df[[name]][!available] <- NA_real_
  # A missing last SVF value of a bout takes the previous value when that row is 10 s earlier.
  stamp <- as.POSIXct(raw_df$Datetime, tz = "UTC")
  bout_order <- order(raw_df$ParticipantID, raw_df$PhaseID, stamp)
  for (rows in split(bout_order, paste(raw_df$ParticipantID, raw_df$PhaseID)[bout_order])) {
    if (length(rows) < 2L) next
    last <- rows[length(rows)]
    previous <- rows[length(rows) - 1L]
    gap <- as.numeric(difftime(stamp[last], stamp[previous], units = "secs"))
    if (!is.finite(raw_df$SVF[last]) && is.finite(raw_df$SVF[previous]) && is.finite(gap) && gap == 10)
      raw_df$SVF[last] <- raw_df$SVF[previous]}
  raw_df}

# Generalised VIF per term with car::vif; the three phase columns are one term, scored as GVIF^(1/Df).
# The response is a dummy: VIF depends only on the predictors.
combined_vif <- function(X) {
  terms <- ifelse(startsWith(colnames(X), "PhaseSum"), "PhaseID", colnames(X))
  d <- data.frame(response = sin(seq_len(nrow(X))) + cos(seq_len(nrow(X)) * sqrt(2)))
  for (term in unique(terms)) d[[term]] <- if (sum(terms == term) == 1L) X[, terms == term] else I(X[, terms == term])
  gvif <- car::vif(stats::lm(response ~ ., data = d))
  setNames(gvif[, "GVIF"]^(1 / gvif[, "Df"]), rownames(gvif))}

combined_vif_row <- function(equation_id, outcome, X) {
  vif <- combined_vif(X)
  data.frame(equation_id = equation_id, outcome = outcome, terms = paste(colnames(X), collapse = " + "),
    max_vif = max(vif), worst_term = names(vif)[which.max(vif)], n = nrow(X), stringsAsFactors = FALSE)}

# Per equation: the heart-rate design and the worst outcome, merged into the table shared by both grains.
combined_write_vif <- function(vif) {
  hr <- vif[vif$outcome == "empatica_heart_rate", ]
  worst <- vif[order(-vif$max_vif), ]
  worst <- worst[match(hr$equation_id, worst$equation_id), ]
  grain <- data.frame(equation_id = hr$equation_id, terms = hr$terms, max_vif_heart_rate = round(hr$max_vif, 2),
    worst_term_heart_rate = hr$worst_term, n_design_rows_hr = hr$n, max_vif_worst_outcome = round(worst$max_vif, 2),
    worst_outcome = worst$outcome)
  names(grain)[-1] <- paste0(names(grain)[-1], "_", COMBINED_VARIANT)
  path <- file.path(COMBINED_RESULTS_ROOT, "H5_combined_gvif_summary_both_grains.csv")
  if (file.exists(path)) {
    old <- read.csv(path, check.names = FALSE, stringsAsFactors = FALSE)
    old <- old[, !grepl(paste0("_", COMBINED_VARIANT, "$"), names(old)) & names(old) != "terms", drop = FALSE]
    grain <- merge(old, grain, by = "equation_id")}
  write.csv(grain, path, row.names = FALSE)}

# BikeU deviation and the planned phase contrasts as rows of contrast weights on the fixed effects.
combined_contrast_matrix <- function(coef_names, planned = FALSE) {
  weights <- rbind(PhaseSumBikeU = c(0, 0, 0, 1))
  # Equal weighting of the two modes or environments, not observed row frequencies.
  if (planned) weights <- rbind(weights, Urban_minus_Green = c(-.5, .5, -.5, .5), Urban_minus_Green_Walk = c(-1, 1, 0, 0),
    Urban_minus_Green_Bike = c(0, 0, -1, 1), Bike_minus_Walk = c(-.5, -.5, .5, .5), Mode_by_Environment = c(1, -1, -1, 1))
  L <- matrix(0, nrow(weights), length(coef_names), dimnames = list(rownames(weights), coef_names))
  L[, COMBINED_PHASE_SUM_COLS] <- weights %*% paper3_phase_sum_design(c("WalkG", "WalkU", "BikeG", "BikeU"))
  L}

# CR2 / Satterthwaite coefficients and contrasts for one fit.
combined_cr2 <- function(fit, cluster, planned = FALSE) {
  V <- clubSandwich::vcovCR(fit, cluster = cluster, type = "CR2")
  coefs <- clubSandwich::conf_int(fit, vcov = V, test = "Satterthwaite", p_values = TRUE)
  L <- combined_contrast_matrix(names(nlme::fixef(fit)), planned)
  contrasts <- clubSandwich::linear_contrast(fit, vcov = V, contrasts = L, test = "Satterthwaite", p_values = TRUE)
  as_rows <- function(x, estimate) data.frame(estimate = estimate, se = x$SE, df = x$df, ci_low = x$CI_L, ci_high = x$CI_U,
    p_value = x$p_val, low_df_flag = is.finite(x$df) & x$df < 4)
  list(coefficients = rbind(as_rows(coefs, coefs$beta), as_rows(contrasts[1L, ], contrasts$Est[1L])),
    contrasts = if (planned) cbind(contrast = rownames(L)[-1L], as_rows(contrasts[-1L, ], contrasts$Est[-1L])))}

# BH per term (or contrast) within equation across outcomes, or within Eq8 model family.
combined_fdr <- function(results, family, bh_m = length(COMBINED_OUTCOMES)) {
  results$q <- NA_real_
  tested <- is.finite(results$p_value)
  for (key in unique(family[tested])) {
    rows <- which(family == key & tested)
    m <- if (length(bh_m) == 1L && is.na(bh_m)) length(rows) else bh_m
    results$q[rows] <- p.adjust(results$p_value[rows], "BH", n = m)}
  results$inference_status <- ifelse(tested, "Tested", "Not estimable: model covariance or coefficient inference unavailable")
  results}

combined_phase_term_labels <- function(term) sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", term)

# Clear this script's earlier outputs, write the new tables and finalize the folder.
combined_write_tables <- function(tables) {
  unlink(grep("supplementary_blocks", list.files(OUT_DIR, full.names = TRUE), value = TRUE, invert = TRUE))
  for (name in names(tables)) write.csv(tables[[name]], file.path(OUT_DIR, paste0(COMBINED_FILE_PREFIX, "_", name, ".csv")), row.names = FALSE)
  p3_finalize_directory(OUT_DIR)}

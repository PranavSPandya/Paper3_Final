# H4 core engine: exposure preparation, fitting, reports and dispatch; sourced by the Analysis_combined_* entry scripts.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing Analysis_combined_core.R (source scripts/statistical_analysis/Analysis_combined_timeseries.R).", call. = FALSE)}
if (!exists("h4_study_spec", envir = .GlobalEnv, inherits = FALSE)) {
  stop("h4_study_spec must be set before sourcing Analysis_combined_core.R.", call. = FALSE)}
h4_study_spec <- paper3_ensure_outcome_normalization(h4_study_spec, PROJECT_ROOT)
if (is.null(h4_study_spec$all_physiological_outcomes)) {
  h4_study_spec$all_physiological_outcomes <- h4_study_spec$physiological_outcome_names}
h4_study_spec$empatica_hrv_fd_window_outcomes <- attr(h4_study_spec$physiological_outcome_names, "empatica_hrv_fd_window")
# Data prep metadata; outcome_transform holds report labels from the normalization CSV.
h4_study_spec$outcome_transform <- setNames(
  ifelse(h4_study_spec$all_physiological_outcomes %in% h4_study_spec$natural_log_outcome_names, "natural log", "native"),
  h4_study_spec$all_physiological_outcomes)
# bilateral_sources: left/right sensor columns row-averaged to atmo_pm2.5_avg and lys_lux_avg.
h4_study_spec$bilateral_sources <- list(
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"))

# Output folders: results/Analysis_combined_timeseries/ or results/Analysis_combined_phaseavg/ (H4_ANALYSIS_MODE, default timeseries).
H4_VARIANT <- if (identical(get0("H4_ANALYSIS_MODE", ifnotfound = "timeseries"), "phaseavg")) "phaseavg" else "timeseries"
H4_FILE_PREFIX <- paste0("Analysis_combined_", H4_VARIANT)
h4_file <- function(filename) sub("^H4_", paste0(H4_FILE_PREFIX, "_"), filename)
h4_run_info_path <- function(dir = OUT_DIR) p3_run_provenance_path(dir)  # run_info is kept in cache/run_provenance
h4_model_outputs_locked <- function(dir = OUT_DIR) {
  file.exists(h4_run_info_path(dir)) || file.exists(p3_run_info_path(dir)) ||  # provenance copy or older published run_info
    file.exists(file.path(dir, h4_file("H4_run_complete.csv")))}
# Only files in H4_KEEP_FILES are saved; other detail tables go to a temp folder unless PAPER3_WRITE_DETAILS=1.
H4_WRITE_DETAILS <- identical(Sys.getenv("PAPER3_WRITE_DETAILS", unset = ""), "1")
H4_KEEP_FILES <- h4_file(if (H4_VARIANT == "phaseavg") {
  c("H4_Heat_Noise_Exposures.csv", "H4_phase_contrasts.csv", "H4_run_complete.csv")
} else {
  c("H4_fit_records.rds", "H4_hypothesis.csv", "H4_Report.md", "H4_run_complete.csv")
})
H4_DETAIL_DIR <- file.path(tempdir(), paste0(H4_FILE_PREFIX, "_details"))
# Remove ad-hoc VIF files from the results folder before publishing.
h4_auxiliary_result_name_pattern <- paste(
  c("_gvif_summary\\.csv$", "_eq1_mrt_vif_drop_scenarios\\.csv$", "_eq[0-9]+_vif_drop[^/]*\\.csv$",
    "_gvif_counterfactuals\\.csv$", "_sun_gvi_vif_.*\\.csv$"),
  collapse = "|")
h4_prune_auxiliary_results <- function(dir) {
  if (!dir.exists(dir)) return(invisible(character()))
  names_only <- list.files(dir)
  aux <- names_only[grepl(h4_auxiliary_result_name_pattern, names_only, ignore.case = TRUE)]
  if (length(aux)) {
    removed <- file.remove(file.path(dir, aux))
    cat("[Output] Removed", sum(removed), "auxiliary diagnostic file(s) outside the publish limit\n")}
  invisible(aux)}
h4_path <- function(dir, filename) {
  if (H4_WRITE_DETAILS || filename %in% H4_KEEP_FILES) return(file.path(dir, filename))
  dir.create(H4_DETAIL_DIR, recursive = TRUE, showWarnings = FALSE)
  file.path(H4_DETAIL_DIR, filename)}
H4_RESULTS_ROOT <- file.path(PROJECT_ROOT, "output/statistical_analysis/results")
RESULT_DIR <- file.path(H4_RESULTS_ROOT, H4_FILE_PREFIX)
OUT_DIR <- RESULT_DIR
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

# 1. Configuration (domains, column lists)
H4_DOMAINS <- list(
  Acoustic = "ucm_SND_dBA",
  Thermal = c("ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_WIND_AWS"),
  Index = c("ucm_HUMIDEX", "ucm_PET", "ucm_UTCI", "ucm_OPT"),
  Radiation = c("ucm_MRT", "ucm_SUN_Gh", "SVF"),
  Pollution = c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg"),
  Light = c("lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg"),
  Greenery = "gvi_50m")
H4_FLOW_DOMAIN_ORDER <- c("Thermal", "Index", "Acoustic", "Radiation", "Pollution", "Light", "Greenery")
H4_STEP4_THERMAL_CATEGORIES <- c("Thermal", "Index")
average_sources <- list(
  atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
  atmo_pm2.5_avg = h4_study_spec$bilateral_sources$atmo_pm2.5_avg,
  atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
  lys_lux_avg = h4_study_spec$bilateral_sources$lys_lux_avg,
  lys_medi_avg = c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi"),
  lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))
h4_apply_average_sources <- function(raw_df, vars = names(average_sources), missing_only = TRUE) {
  use <- if (missing_only) intersect(vars, setdiff(names(average_sources), names(raw_df))) else intersect(vars, names(average_sources))
  for (local_values in use) raw_df[[local_values]] <- rowMeans(raw_df[, average_sources[[local_values]], drop = FALSE], na.rm = TRUE)
  raw_df}
H4_PHASE_SUM_COLS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
# UTCI in Eq1, Eq6 and Eq7; Eq6-7 change the PM size.
h4_equation_table <- data.frame(
  equation_number = 1:7,
  heat_predictor_label = c("UTCI", "AIR_T_mid + AIR_RH + WIND_AWS", "MRT", "HUMIDEX", "PET", "UTCI", "UTCI"),
  particulate_matter_column = c(rep("atmo_pm2.5_avg", 5), "atmo_pm1_avg", "atmo_pm10_avg"),
  equation_role = c("primary", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity",
    "pm_size_sensitivity", "pm_size_sensitivity"),
  stringsAsFactors = FALSE)

# The merged file uses _Hz names, the entry scripts use *_hz / 31.25Hz names.
h4_normalize_merged_schema_names <- function(df) {
  renames <- c(
    spectral_centroid_Hz = "spectral_centroid_hz",
    dominant_frequency_Hz = "dominant_frequency_hz",
    spectral_rolloff85_Hz = "spectral_rolloff85_hz",
    octave_proportion_31_5_Hz = "octave_proportion_31.25Hz",
    octave_proportion_63_0_Hz = "octave_proportion_62.5Hz",
    octave_proportion_125_0_Hz = "octave_proportion_125Hz",
    octave_proportion_250_0_Hz = "octave_proportion_250Hz",
    octave_proportion_500_0_Hz = "octave_proportion_500Hz",
    octave_proportion_1000_0_Hz = "octave_proportion_1000Hz",
    octave_proportion_2000_0_Hz = "octave_proportion_2000Hz",
    octave_proportion_4000_0_Hz = "octave_proportion_4000Hz",
    octave_proportion_8000_0_Hz = "octave_proportion_8000Hz")
  for (from in names(renames)) {
    to <- unname(renames[[from]])
    if (!from %in% names(df)) next
    if (to %in% names(df) && !identical(from, to)) {
      stop("Column rename conflict: ", from, " and ", to, " both present.", call. = FALSE)}
    names(df)[names(df) == from] <- to}
  df}

h4_read_merged_analysis_data <- function() {
  h4_normalize_merged_schema_names(read.csv(RAW_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE))}

h4_equation_term_order <- function(eq_id) {
  if (!exists("H4_EQUATION_FIXED", envir = .GlobalEnv, inherits = FALSE)) {
    stop("H4_EQUATION_FIXED not defined; source scripts/statistical_analysis/Analysis_combined_timeseries.R first.", call. = FALSE)}
  get("H4_EQUATION_FIXED", envir = .GlobalEnv)[[as.character(eq_id)]]}

# Fixed-effect order parsed from the entry script's Eq1-7 formulas.
h4_fixed_terms_from_lme_quote <- function(lme_quote) {
  fml <- as.formula(lme_quote[[2L]])
  gsub("_(phase|bout)_z", "", gsub("`", "", attr(terms(fml), "term.labels"), fixed = TRUE))}
H4_EQUATION_FIXED <- setNames(lapply(list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7), h4_fixed_terms_from_lme_quote), as.character(1:7))
# No heat x sound interactions in any equation; Eq2 uses mid-height air temperature without MRT.
MRT_SOUND_INTERACTION <- c("ucm_MRT:ucm_SND_dBA", "ucm_SND_dBA:ucm_MRT")
stopifnot(
  !any(unlist(H4_EQUATION_FIXED) %in% MRT_SOUND_INTERACTION),
  !any(grepl(":", unlist(H4_EQUATION_FIXED), fixed = TRUE)),
  any(grepl("^ucm_AIR_T_mid", H4_EQUATION_FIXED[["2"]], fixed = FALSE)),
  !any(grepl("^ucm_MRT$", H4_EQUATION_FIXED[["2"]], fixed = FALSE)),
  any(grepl("^ucm_MRT$", H4_EQUATION_FIXED[["3"]], fixed = FALSE)),
  !any(grepl("^gvi_50m$", H4_EQUATION_FIXED[["3"]], fixed = FALSE)),
  !any(grepl("^ucm_AIR_T_mid", H4_EQUATION_FIXED[["3"]], fixed = FALSE)),
  !any(grepl("^ucm_UTCI$", H4_EQUATION_FIXED[["3"]], fixed = FALSE)))
if (H4_VARIANT == "phaseavg") {
  stopifnot(
    any(grepl("^SVF$", H4_EQUATION_FIXED[["2"]], fixed = FALSE)),
    !any(grepl("^ucm_SND_dBA$", H4_EQUATION_FIXED[["2"]], fixed = FALSE)))
} else {
  stopifnot(!any(grepl("ucm_AIR_temp", unlist(H4_EQUATION_FIXED), fixed = TRUE)))}

h4_equation_thermal_label <- function(row) {
  pm_short <- c(atmo_pm2.5_avg = "PM2.5", atmo_pm1_avg = "PM1", atmo_pm10_avg = "PM10")[row$particulate_matter_column]
  stopifnot(length(pm_short) == 1L, !is.na(pm_short))
  paste0("Eq", row$equation_number, ": heat = ", row$heat_predictor_label, ", PM = ", unname(pm_short))}

h4_sound_interaction_terms <- function(terms_order) {
  terms_order[grepl(":", terms_order, fixed = TRUE) & grepl("ucm_SND_dBA", terms_order, fixed = TRUE)]}

# Domain order (Thermal -> Greenery), then phases and sound interactions.
h4_domain_var_sequence <- function() unlist(H4_DOMAINS[H4_FLOW_DOMAIN_ORDER], use.names = FALSE)

h4_order_mains_by_flow_domain <- function(main_names) {
  main_names <- unique(as.character(main_names))
  seq <- h4_domain_var_sequence()
  main_names[order(match(main_names, seq), na.last = TRUE)]}

# Pre-interaction design columns: heat (equation order), sound after first heat main, then other covariates by domain.
h4_design_main_column_order <- function(heat_vars, env_covars) {
  heat_vars <- unique(as.character(heat_vars))
  env_covars <- unique(as.character(env_covars))
  snd <- intersect("ucm_SND_dBA", env_covars)
  rest <- h4_order_mains_by_flow_domain(setdiff(env_covars, c(heat_vars, snd)))
  if (length(heat_vars) && length(snd)) c(heat_vars[1L], snd, heat_vars[-1L], rest) else c(heat_vars, snd, rest)}

# 2. Shared helpers

h4_spell_term <- function(term) {
  pretty <- c(ucm_SND_dBA = "sound", SND_dBA = "sound", gvi_50m = "GVI", Clearness_Index = "clearness (excluded in Step 2 as derived)",
    lys_lux_avg = "lux", lys_kelvin_avg = "colour temperature", ucm_SUN_Gh = "global solar radiation", ucm_WIND_AWS = "apparent wind",
    ucm_AIR_T_mid = "air temperature (mid)", ucm_AIR_temp = "air temperature", ucm_AIR_RH = "humidity",
    ucm_MRT = "mean radiant temperature", ucm_HUMIDEX = "HUMIDEX", ucm_PET = "PET", ucm_UTCI = "UTCI",
    atmo_pm1_avg = "PM1", atmo_pm2.5_avg = "PM2.5", atmo_pm10_avg = "PM10",
    setNames(paste("Phase:", c("WalkG", "WalkU", "BikeG", "BikeU"), "vs mean of phases"), paste0("PhaseSum", c("WalkG", "WalkU", "BikeG", "BikeU"))))
  parts <- strsplit(term, ":", fixed = TRUE)[[1]]
  parts <- ifelse(parts %in% names(pretty), pretty[parts], parts)
  if (length(parts) > 1L) paste0("(", parts[1], " x ", parts[2], ")") else parts}

# 3. Design VIF

# VIF score per term = GVIF^(1/df) (Fox & Monette 1992), e.g. Df=1 with R^2 = 0.75 scores 4, PhaseID (Df=3) with GVIF 8 scores 2.
h4_vif_per_term <- function(X) {
  # car::vif on the design only; each PhaseID span is one term and the score is GVIF^(1/df).
  X <- as.matrix(X)
  if (!ncol(X)) return(setNames(numeric(), character()))
  nms <- colnames(X)
  groups <- nms
  groups[startsWith(nms, "PhaseSum")] <- "PhaseID"
  ix <- grepl(":PhaseSum", nms, fixed = TRUE)
  groups[ix] <- paste0(sub(":PhaseSum.*$", "", nms[ix]), ":PhaseID")
  terms <- unique(groups)
  dfs <- vapply(terms, function(g) sum(groups == g), integer(1))
  if (any(dfs[grepl("PhaseID$", terms)] != 3L)) stop("Incomplete PhaseID contrast block")
  gvif <- rep(Inf, length(terms))
  if (all(is.finite(X)) && nrow(X) > ncol(X) + 1L && qr(cbind(1, X))$rank == ncol(X) + 1L) {
    if (length(terms) == 1L) gvif[] <- 1 else {
      # A dummy response is enough for lm because the residual scale cancels.
      d <- data.frame(.h4_response = sin(seq_len(nrow(X))) + cos(seq_len(nrow(X)) * sqrt(2)))
      for (local_index in seq_along(terms)) {
        block <- X[, groups == terms[local_index], drop = FALSE]
        d[[paste0("T", local_index)]] <- if (ncol(block) == 1L) block[, 1L] else I(block)}
      result <- car::vif(stats::lm(.h4_response ~ ., data = d))
      keys <- paste0("T", seq_along(terms))
      gvif <- if (is.matrix(result)) result[keys, "GVIF"] else result[keys]}
  }
  score <- setNames(as.numeric(gvif)^(1 / dfs), terms)
  attr(score, "gvif_table") <- data.frame(term = terms, GVIF = as.numeric(gvif), Df = dfs,
    GVIF_root = as.numeric(gvif)^(1 / (2 * dfs)), VIF_equivalent = as.numeric(score))
  score}


h4_run_gvif_diagnostic <- function(prep, design_outcome = "empatica_heart_rate", vif_threshold = h4_study_spec$variance_inflation_factor_limit) {
  # Local bindings from the Step 4 preparation.
  raw_df <- prep$raw_df
  centered <- prep$centered
  catalog <- prep$catalog
  make_design <- prep$make_design
  thermal <- prep$thermal
  if (!design_outcome %in% names(raw_df)) stop("GVIF design outcome not in data: ", design_outcome)
  term_rows <- eq_rows <- list()
  for (local_index in seq_len(nrow(catalog))) {
    eq <- catalog[local_index, ]
    ok <- h4_complete_rows(raw_df, design_outcome, eq$equation_id)
    z <- centered[ok, , drop = FALSE]
    phase_vec <- raw_df$PhaseID[ok]
    n_rows <- nrow(z)
    design <- make_design(z, thermal[[eq$heat_form]], phase_vec, test = eq$test,
      terms_order = h4_equation_term_order(eq$equation_id))
    vv <- h4_vif_per_term(design)
    gt <- attr(vv, "gvif_table")
    phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
    mx <- max(vv, na.rm = TRUE)
    id_cols <- data.frame(equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block, test = eq$test,
      design_outcome = design_outcome, n_design_rows = n_rows, stringsAsFactors = FALSE)
    term_rows[[local_index]] <- data.frame(id_cols, grouped_term = gt$term, GVIF = gt$GVIF, Df = gt$Df, GVIF_root = gt$GVIF_root,
      VIF_equivalent = gt$VIF_equivalent, flag_vif_gt_threshold = gt$Df == 1L & (gt$VIF_equivalent >= vif_threshold | !is.finite(gt$VIF_equivalent)),
      stringsAsFactors = FALSE, row.names = NULL)
    eq_rows[[local_index]] <- data.frame(id_cols, max_vif_equivalent = mx, worst_grouped_term = names(vv)[which.max(vv)],
      phase_GVIF = phase_gt$GVIF, phase_Df = phase_gt$Df, phase_GVIF_root = phase_gt$GVIF_root,
      phase_vif_equivalent = phase_gt$VIF_equivalent, rank = qr(cbind(1, design))$rank, expected_rank = ncol(design) + 1L,
      full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L, stringsAsFactors = FALSE, row.names = NULL)}
  term_df <- do.call(rbind, term_rows)
  by_equation <- do.call(rbind, eq_rows)
  md_path <- h4_path(OUT_DIR, h4_file("H4_gvif_diagnostic.md"))
  md <- c("# H4 design-only GVIF / VIF diagnostic", "", sprintf("Reference complete-case outcome: **%s** (n = %d). Other outcomes use different row sets; see `%s`.", design_outcome, n_rows, h4_file("H4_design_redundancy_by_outcome.csv")),
    "", "## PhaseID vs single continuous predictors", "", "PhaseID enters as **three** sum-to-zero contrasts (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit).",
    "In `car::vif`, that span is one **Df = 3** term with a generalized VIF (GVIF).",
    paste0("- **GVIF^(1/(2*Df))** is what `car::vif` prints for multi-df terms (Fox & Monette 1992; [car::vif](https://rdrr.io/cran/car/man/vif.html))."),
    "- **VIF_equivalent = GVIF^(1/Df)** is the square of that root; we compare **VIF_equivalent** to ", vif_threshold, " for the PhaseID block.",
    "- Continuous **Df = 1** columns use ordinary VIF (= VIF_equivalent). Values above the threshold are **flagged only**; no predictor is dropped.",
    "", "## Equation summaries (heart rate complete cases)", "", "| Eq | Heat form | Block | n | Max VIF-equiv | Worst term | Phase GVIF | Phase VIF-equiv |",
    "|----|-----------|-------|---|---------------|------------|------------|-----------------|",
    with(by_equation, sprintf("| %d | %s | %s | %d | %.3f | %s | %.3f | %.3f |", equation_id, heat_form, block, n_design_rows,
      max_vif_equivalent, worst_grouped_term, phase_GVIF, phase_vif_equivalent)), "", sprintf("Generated UTC: %s", format(Sys.time(), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")))
  csv_path <- h4_path(OUT_DIR, h4_file("H4_gvif_diagnostic.csv"))
  dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
  utils::write.csv(term_df, csv_path, row.names = FALSE, na = "")
  writeLines(md, md_path)
  list(terms = term_df, by_equation = by_equation, paths = c(csv = csv_path, md = md_path))}

# 4. Reports

h4_archive <- function(paths) {
  paths <- unique(paths[file.exists(paths)])
  if (!length(paths)) return(invisible())
  root <- normalizePath(PROJECT_ROOT, winslash = "/", mustWork = TRUE)
  files <- unique(unlist(lapply(paths, function(path) {
    if (dir.exists(path)) list.files(path, recursive = TRUE, full.names = TRUE, all.files = TRUE, no.. = TRUE) else path
  }), use.names = FALSE))
  files <- files[!file.info(files)$isdir]
  if (!length(files)) return(invisible())
  source <- normalizePath(files, winslash = "/", mustWork = TRUE)
  if (any(!startsWith(source, paste0(root, "/")))) stop("Cannot archive files outside Paper3_Final.")
  archived <- file.path(root, "archive", substring(source, nchar(root) + 2L))
  extension <- tools::file_ext(archived)
  stem <- ifelse(nzchar(extension), substr(archived, 1L, nchar(archived) - nchar(extension) - 1L), archived)
  archived <- paste0(stem, "_", format(Sys.time(), "%Y%m%d_%H%M%S"), ifelse(nzchar(extension), paste0(".", extension), ""))
  if (any(file.exists(archived))) stop("Archive destination already exists; refusing to overwrite.")
  for (local_index in seq_along(files)) {
    dir.create(dirname(archived[local_index]), recursive = TRUE, showWarnings = FALSE)
    if (!file.rename(files[local_index], archived[local_index])) stop("Could not archive: ", files[local_index])}
  for (path in paths[dir.exists(paths)]) unlink(path, recursive = TRUE)
  cat(sprintf("Archived %d file(s) under %s\n", length(files), file.path(root, "archive")))}

h4_write_results <- function(step5_result) {
  res_obj <- if (!is.null(step5_result$h4)) step5_result$h4 else step5_result
  if (is.null(res_obj) || is.null(res_obj$coef) || !nrow(res_obj$coef))
    stop("H4 fitting incomplete; refusing to publish final report")
  if (!identical(unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH))), H4_START_MD5)) stop("Script or input changed; refusing final publication")
  res_dir <- RESULT_DIR
  md <- OUT_DIR; rd <- function(file_name) read.csv(h4_path(md, h4_file(file_name)), stringsAsFactors = FALSE, check.names = FALSE)
  manifest_path <- file.path(md, h4_file("H4_run_complete.csv"))
  recorded_sources <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))
  if (!file.exists(manifest_path)) stop("Missing ", h4_file("H4_run_complete.csv"), "; run Step 5 before publishing")
  man <- read.csv(manifest_path, stringsAsFactors = FALSE)
  if (!identical(recorded_sources, unname(unlist(man[1L, c("code_md5", "input_md5")], use.names = FALSE))))
    stop("Fitted bundle sources no longer match; refusing report publication")
  dir.create(res_dir, recursive = TRUE, showWarnings = FALSE)
  co <- rd("H4_coefficients.csv")
  st <- rd("H4_fit_status.csv")
  if (nrow(co)) {
  st$model_note <- trimws(paste(ifelse(st$residual_structure == "independent_fallback", "independent-residual fallback (no q);", ""),
    ifelse(st$boundary_variance %in% TRUE, "boundary random-effect variance;", ""), ifelse(st$high_ar1_flag %in% TRUE, "AR(1) rho > 0.95;", ""), ifelse(st$residual_structure == "ARMA20", "ARMA(2,0) (AR(1) rho > 0.95);", "")))
  local_key <- match(paste(co$equation, co$outcome), paste(st$heat_form, st$outcome))
  co$n <- st$n[local_key]; co$model_note <- st$model_note[local_key]
  co$analysis_role <- "H4.1: within-bout empatica/eyetracker association (10 s windows)"
  co$independent_unit <- "participant cluster; repeated 10-second windows"
  co$p_method <- "participant-cluster CR2 / Satterthwaite"
  co$q_note <- ifelse(co$inference_status == "Tested", co$FDR_scope, co$inference_status)
  co$q_note[st$high_ar1_flag[local_key] %in% TRUE] <- "excluded: unresolved high-AR1 covariance after attempted repair"
  co$q_note[co$low_df_flag %in% TRUE] <- trimws(paste(co$q_note[co$low_df_flag %in% TRUE], "low df (<4); interpret with caution"))
  reportable <- !co$term_type %in% "intercept"
  heat_table <- co[reportable, ]
  write.csv(heat_table, h4_path(res_dir, h4_file("H4_Heat_Noise_Exposures.csv")), row.names = FALSE, na = "NA")
  if (H4_WRITE_DETAILS) write.csv(heat_table, h4_path(res_dir, h4_file("H4_Covariates_and_Phases.csv")), row.names = FALSE, na = "NA")}
  n_tab <- if (nrow(st)) unique(st[, c("outcome", "n", "n_participants")][st$equation_id == 1, ]) else data.frame()
  h41_md <- c("## Physiological sensor models (10-second time series)",
    "Outcomes: 26 empatica + eyetracker columns (see h4_study_spec$physiological_outcome_names). Nested (1 | ParticipantID / PhaseID) with AR(1) within bout.",
    if (nrow(n_tab)) sprintf("Sample sizes (Eq 1): see %s and %d-%d rows per outcome.", if (H4_WRITE_DETAILS) h4_file("H4_hypothesis_readme.txt") else "the readme section below", min(n_tab$n), max(n_tab$n)) else "")
  rep_md <- c("# H4 results report", "", h41_md, "",
    "## Files",
    if (H4_WRITE_DETAILS) sprintf("- %s / %s: H4.1 only", h4_file("H4_Heat_Noise_Exposures.csv"), h4_file("H4_Covariates_and_Phases.csv")) else
      sprintf("- Saved in results/%s/: %s (all non-intercept fixed effects, H4.1, with the fit status of each outcome x model); run information (manifest, file MD5 checksums, column dictionary) in output/statistical_analysis/cache/run_provenance/%s, not in the results folder; %s (Step 5 resume checkpoint); this report.",
        basename(RESULT_DIR), h4_file("H4_hypothesis.csv"), basename(h4_run_info_path(md)), h4_file("H4_fit_records.rds")),
    if (H4_WRITE_DETAILS) sprintf("- Working fits in results/%s/", basename(RESULT_DIR)) else
      "- Not saved by default (rerun with PAPER3_WRITE_DETAILS=1 to write them): coefficients, Heat_Noise_Exposures, Covariates_and_Phases, phase_contrasts, covariance and lag-60 sensitivity, GVIF and design-redundancy diagnostics, hypothesis_readme, session_info. Detail file names mentioned below refer to that mode.", "",
    if (file.exists(h4_path(md, h4_file("H4_hypothesis_readme.txt")))) readLines(h4_path(md, h4_file("H4_hypothesis_readme.txt"))) else character(),
    if (file.exists(h4_path(md, h4_file("H4_gvif_diagnostic.md")))) c("", readLines(h4_path(md, h4_file("H4_gvif_diagnostic.md")))) else character())
  writeLines(rep_md, h4_path(res_dir, h4_file("H4_Report.md")))
  result_files <- h4_path(res_dir, h4_file("H4_Report.md"))
  for (nm in h4_file(c("H4_Covariates_and_Phases.csv", "H4_Heat_Noise_Exposures.csv")))
    if (file.exists(h4_path(res_dir, nm))) result_files <- c(result_files, h4_path(res_dir, nm))
  stopifnot(all(file.exists(result_files)))
  result_files <- result_files[!startsWith(result_files, H4_DETAIL_DIR)]  # manifest lists only files saved in the results folder
  add <- if (nrow(man)) man[rep(1L, length(result_files)), , drop = FALSE] else
    data.frame(file = character(length(result_files)), md5 = character(length(result_files)), code_md5 = recorded_sources[1L],
      input_md5 = recorded_sources[2L], spec_md5 = NA_character_,
      completed_utc = character(length(result_files)), run_complete = logical(length(result_files)), run_scope = character(length(result_files)),
      stringsAsFactors = FALSE)
  add$file <- normalizePath(result_files, winslash = "/", mustWork = TRUE); add$md5 <- unname(tools::md5sum(result_files))
  completed <- rbind(man[!startsWith(man$file, "../") & !basename(man$file) %in% basename(result_files), , drop = FALSE], add)
  if (!identical(unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH))), recorded_sources)) stop("Sources changed during publication; completion marker remains false")
  completed$completed_utc <- format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ")
  completed$run_complete <- TRUE
  completed$run_scope <- "FULL"
  write.csv(completed, file.path(md, h4_file("H4_run_complete.csv")), row.names = FALSE)
  h4_prune_auxiliary_results(md)
  # Final names, fit status and run_info (output layer in Paper3_common.R).
  if (exists("p3_finalize_directory", mode = "function")) p3_finalize_directory(md)
  cat("[Results] Wrote", length(result_files), "files to", res_dir, "\n")}

# 5. Exposures, contrasts, fitter and sensitivities

h4_phase_design <- function(phase) {
  phase <- factor(as.character(phase), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  if (anyNA(phase)) stop("Unknown or missing H4 PhaseID")
  design <- stats::model.matrix(~ phase, contrasts.arg = list(phase = stats::contr.sum(4L)))[, -1L, drop = FALSE]
  colnames(design) <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
  design}

# Derived BikeU deviation under contr.sum(4): -(WalkG + WalkU + BikeG), with CR2 SE and HTZ df/p.
h4_bikeu_contrast <- function(fit, cluster) {
  V <- clubSandwich::vcovCR(fit, cluster = cluster, type = "CR2")
  L <- matrix(0, 1L, length(nlme::fixef(fit)), dimnames = list(NULL, names(nlme::fixef(fit))))
  L[1L, H4_PHASE_SUM_COLS] <- -1
  test <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
  list(estimate = as.numeric(L %*% nlme::fixef(fit)), se = sqrt(as.numeric(L %*% V %*% t(L))),
    df = as.numeric(test$df_denom), p = as.numeric(test$p_val))}

h4_phase_contrast_weights <- function() {
  # Equal weighting of the two modes/environments, not observed row frequencies.
  local_weights <- rbind(Urban_minus_Green = c(-.5, .5, -.5, .5), Urban_minus_Green_Walk = c(-1, 1, 0, 0), Urban_minus_Green_Bike = c(0, 0, -1, 1),
             Bike_minus_Walk = c(-.5, -.5, .5, .5), Mode_by_Environment = c(1, -1, -1, 1))
  local_weights %*% h4_phase_design(c("WalkG", "WalkU", "BikeG", "BikeU"))}

h4_phase_contrasts <- function(fit, cluster) {
  beta <- nlme::fixef(fit)
  weights <- h4_phase_contrast_weights()
  V <- clubSandwich::vcovCR(fit, cluster = cluster, type = "CR2")
  do.call(rbind, lapply(seq_len(nrow(weights)), function(local_index) {
    L <- matrix(0, 1L, length(beta), dimnames = list(NULL, names(beta)))
    stopifnot(all(colnames(weights) %in% names(beta)))
    L[1L, colnames(weights)] <- weights[local_index, ]
    test <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
    estimate <- as.numeric(L %*% beta)
    se <- sqrt(as.numeric(L %*% V %*% t(L)))
    df <- as.numeric(test$df_denom)
    if (!is.finite(df) || df <= 0 || !is.finite(se)) stop("Invalid phase-contrast CR2 inference")
    data.frame(contrast = rownames(weights)[local_index], estimate = estimate, se = se, df = df, low_df_flag = df < 4,
               ci_low = estimate - stats::qt(.975, df) * se, ci_high = estimate + stats::qt(.975, df) * se, p_value = as.numeric(test$p_val), stringsAsFactors = FALSE)
  }))}

h4_phase_mean_init_coefficient_frame <- function(equation_id, outcome, design_columns, has_phase, fixed_term_labels) {
  terms_out <- c(ifelse(design_columns == "(Intercept)", "Intercept", design_columns), if (has_phase) "PhaseSumBikeU")
  heat_predictors <- intersect(fixed_term_labels, c("ucm_UTCI", "ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_MRT", "ucm_HUMIDEX", "ucm_PET"))
  term_type <- ifelse(terms_out == "Intercept", "intercept",
    ifelse(startsWith(terms_out, "PhaseSum"), "phase (study design)",
      ifelse(terms_out %in% "ucm_SND_dBA", "sound exposure",
        ifelse(terms_out %in% heat_predictors | grepl(":", terms_out, fixed = TRUE), "thermal exposure", "covariate"))))
  data.frame(equation_id = equation_id, equation = h4_equation_thermal_label(h4_equation_table[equation_id, ]),
    outcome = outcome, term = terms_out, term_type = term_type,
    Beta = NA_real_, SE = NA_real_, df = NA_real_, ci_low = NA_real_, ci_high = NA_real_, p = NA_real_, stringsAsFactors = FALSE)}

h4_phase_mean_results <- function(equation_id, outcome, fixed, phase, design, fit, note) {
  # Keep coefficient labels stable for the reporting code.
  columns <- gsub("_phase_z", "", colnames(design), fixed = TRUE)
  full_rank <- qr(design)$rank == ncol(design)
  has_phase <- all(H4_PHASE_SUM_COLS %in% columns)
  fixed_labels <- gsub("_phase_z", "", attr(terms(fixed), "term.labels"), fixed = TRUE)
  result <- h4_phase_mean_init_coefficient_frame(equation_id, outcome, columns, has_phase, fixed_labels)
  success <- FALSE
  boundary <- NA
  phase_comparisons <- NULL
  if (!is.null(fit)) {
    robust <- tryCatch(withCallingHandlers(
      clubSandwich::coef_test(fit, vcov = "CR2", cluster = phase$ParticipantID, test = "Satterthwaite"),
      warning = function(warning_condition) note <<- c(note, conditionMessage(warning_condition)),
      error = function(local_error) { note <<- c(note, paste("CR2:", conditionMessage(local_error))); NULL }))
    if (!is.null(robust)) {
      index <- match(ifelse(result$term == "Intercept", "(Intercept)", result$term), gsub("_phase_z", "", rownames(robust), fixed = TRUE))
      result$Beta <- robust$beta[index]
      result$SE <- robust$SE[index]
      result$df <- robust$df_Satt[index]
      result$p <- 2 * pt(-abs(result$Beta / result$SE), result$df)
      result$ci_low <- result$Beta - qt(.975, result$df) * result$SE
      result$ci_high <- result$Beta + qt(.975, result$df) * result$SE
      success <- all(is.finite(robust$beta))
      if (has_phase) tryCatch({
        bikeu <- h4_bikeu_contrast(fit, phase$ParticipantID)
        row <- which(result$term == "PhaseSumBikeU")
        result$Beta[row] <- bikeu$estimate
        result$SE[row] <- bikeu$se
        result$df[row] <- bikeu$df
        result$p[row] <- bikeu$p
        result$ci_low[row] <- result$Beta[row] - qt(.975, result$df[row]) * result$SE[row]
        result$ci_high[row] <- result$Beta[row] + qt(.975, result$df[row]) * result$SE[row]
      }, error = function(local_error) note <<- c(note, paste("BikeU contrast:", conditionMessage(local_error))))
      boundary <- as.numeric(nlme::VarCorr(fit)[1L, "Variance"]) < 1e-6 * sigma(fit)^2
      if (has_phase) phase_comparisons <- tryCatch(h4_phase_contrasts(fit, phase$ParticipantID),
        error = function(local_error) { note <<- c(note, paste("Phase contrasts:", conditionMessage(local_error))); NULL })}
  }
  result$low_df_flag <- is.finite(result$df) & result$df < 4
  result$transformation <- if (outcome %in% h4_study_spec$natural_log_outcome_names) "natural log before phase averaging" else "native"
  result$n <- nrow(phase)
  result$n_participants <- nlevels(phase$ParticipantID)
  status <- data.frame(equation_id = equation_id, outcome = outcome, success = success,
    n = nrow(phase), n_participants = nlevels(phase$ParticipantID),
    min_epochs_per_phase = if (nrow(phase)) min(phase$epochs) else 0,
    max_epochs_per_phase = if (nrow(phase)) max(phase$epochs) else 0,
    coefficients = ncol(design), full_rank = full_rank, boundary_variance = boundary,
    condition_index = kappa(design, exact = TRUE),
    note = if (length(note)) paste(unique(note), collapse = "; ") else "Completed")
  if (!is.null(phase_comparisons)) {
    phase_comparisons$equation_id <- equation_id
    phase_comparisons$outcome <- outcome}
  coverage <- phase[, c("ParticipantID", "PhaseID", "epochs")]
  coverage$equation_id <- equation_id
  coverage$outcome <- outcome
  list(coefficients = result, status = status, contrasts = phase_comparisons, coverage = coverage)}

h4_prepare_bout_exposures <- function(raw_df, selected) {
  bout_id <- paste(raw_df$ParticipantID, raw_df$PhaseID, sep = "::")
  centered <- raw_x <- as.matrix(raw_df[, selected, drop = FALSE])
  storage.mode(centered) <- storage.mode(raw_x) <- "double"
  for (other_index in seq_len(ncol(raw_x))) {
    x <- raw_x[, other_index]
    finite <- is.finite(x)
    bout_mean <- ave(ifelse(finite, x, NA_real_), raw_df$ParticipantID, raw_df$PhaseID,
      FUN = function(local_values) mean(local_values, na.rm = TRUE))
    deviation <- x - bout_mean
    shared_sd <- sd(deviation[is.finite(deviation)])
    centered[, other_index] <- if (is.finite(shared_sd) && shared_sd > 0) deviation / shared_sd else deviation}
  # Use the exact 60 s predecessor within the bout (row offsets break when timestamps have gaps).
  stamp <- as.numeric(as.POSIXct(raw_df$Datetime, tz = "UTC"))
  time_keys <- paste(bout_id, stamp, sep = "::")
  if (any(!is.finite(stamp)) || anyDuplicated(time_keys)) stop("Invalid/duplicate timestamps in exposure preparation")
  lag_index <- match(paste(bout_id, stamp - 60, sep = "::"), time_keys)
  centered_lag60 <- centered
  centered_lag60[] <- NA_real_
  has_lag <- !is.na(lag_index)
  centered_lag60[has_lag, ] <- centered[lag_index[has_lag], , drop = FALSE]
  list(centered = centered, centered_lag60 = centered_lag60)}

h4_prepare_bout_design <- function(raw_df, selected, nonthermal, thermal) {
  exposure_data <- h4_prepare_bout_exposures(raw_df, selected)
  centered <- exposure_data$centered
  centered_lag60 <- exposure_data$centered_lag60
  make_design <- function(z, vars, phase, test = "Noise", terms_order = NULL) {
    if (nrow(z) != length(phase)) stop("PhaseID/design row mismatch")
    env_covars <- setdiff(nonthermal, setdiff(H4_DOMAINS$Pollution, attr(vars, "pm")))
    if (!is.null(terms_order)) {
      ix_in_order <- terms_order[grepl(":", terms_order, fixed = TRUE)]
      mains_needed <- setdiff(terms_order, c(intersect(H4_PHASE_SUM_COLS, terms_order), ix_in_order))
      # Use only the terms given in the equations (e.g. no MRT outside Eq2).
      env_covars <- setdiff(mains_needed, vars)}
    design_mains <- h4_design_main_column_order(vars, env_covars)
    x <- cbind(z[, design_mains, drop = FALSE], h4_phase_design(phase))
    stopifnot(sum(H4_DOMAINS$Pollution %in% colnames(x)) == 1L, !anyDuplicated(colnames(x)))
    if (test != "Noise") {
      if (!is.null(terms_order)) {
        stopifnot(setequal(colnames(x), terms_order))
        return(x[, terms_order, drop = FALSE])}
      return(x)}
    ix_terms <- h4_sound_interaction_terms(terms_order)
    if (length(ix_terms)) {
      sound <- vapply(ix_terms, function(term) {
        parts <- strsplit(term, ":", fixed = TRUE)[[1L]]
        z[, parts[1L]] * z[, parts[2L]]
      }, numeric(nrow(z)))
      sound <- matrix(sound, nrow = nrow(z), ncol = length(ix_terms), dimnames = list(NULL, ix_terms))
      x <- cbind(x, sound)}
    if (!is.null(terms_order)) {
      stopifnot(setequal(colnames(x), terms_order))
      x <- x[, terms_order, drop = FALSE]}
    x}
  catalog <- h4_equation_catalog(thermal, h4_equation_table)
  # Phase-average models check their own model matrix in h4_phase_model_data.
  if (exists("H4_EQUATION_FIXED", envir = .GlobalEnv, inherits = FALSE) && H4_VARIANT != "phaseavg") {
    fixed <- get("H4_EQUATION_FIXED", envir = .GlobalEnv)
    for (index in seq_len(nrow(h4_equation_table))) {
      heat_label <- names(thermal)[index]
      vars <- thermal[[heat_label]]
      formula_cols <- fixed[[as.character(h4_equation_table$equation_number[index])]]
      fitted_cols <- colnames(make_design(centered[1L, , drop = FALSE], vars, "WalkG", terms_order = formula_cols))
      stopifnot(identical(fitted_cols, formula_cols))}
  }
  list(raw_df = raw_df, nonthermal = nonthermal, thermal = thermal, selected = selected,
       centered = centered, centered_lag60 = centered_lag60, make_design = make_design, catalog = catalog,
       agreed_common = character(0))}

h4_step4_exposure_prep <- function(raw_df) {
  raw_df <- h4_apply_average_sources(raw_df, c("lys_lux_avg", "lys_kelvin_avg", "lys_medi_avg"))
  raw_df <- raw_df[raw_df$ParticipantID %in% h4_study_spec$participants & raw_df$PhaseID %in% h4_study_spec$phases, , drop = FALSE]
  if (!"empatica_hrv_fd_5min_available" %in% names(raw_df)) stop("Missing HRV availability flag")
  available <- tolower(as.character(raw_df$empatica_hrv_fd_5min_available)) %in% c("true", "1")
  for (local_values in h4_study_spec$empatica_hrv_fd_window_outcomes) raw_df[[local_values]][!available] <- NA_real_
  # One-step endpoint approximation; no gap filling and no crossing of bout boundaries.
  bout_order <- order(raw_df$ParticipantID, raw_df$PhaseID, as.POSIXct(raw_df$Datetime, tz = "UTC"))
  bout_sorted <- paste(raw_df$ParticipantID, raw_df$PhaseID)[bout_order]
  raw_df$SVF_endpoint_carried <- FALSE
  for (ix in split(bout_order, bout_sorted)) {
    if (length(ix) < 2L) next
    last <- tail(ix, 1L); previous <- tail(ix, 2L)[1L]
    gap <- as.numeric(difftime(as.POSIXct(raw_df$Datetime[last], tz = "UTC"), as.POSIXct(raw_df$Datetime[previous], tz = "UTC"), units = "secs"))
    if (!is.finite(raw_df$SVF[last]) && is.finite(raw_df$SVF[previous]) && is.finite(gap) && gap == 10) {
      raw_df$SVF[last] <- raw_df$SVF[previous]
      raw_df$SVF_endpoint_carried[last] <- TRUE}
  }
  # Centered columns are the Eq1-7 terms; covariates are the terms outside the Thermal and Index domains, sorted by name.
  formula_vars <- setdiff(unique(unlist(H4_EQUATION_FIXED, use.names = FALSE)), H4_PHASE_SUM_COLS)
  if (!all(formula_vars %in% names(raw_df))) stop("Missing Eq1-7 measurements: ", paste(setdiff(formula_vars, names(raw_df)), collapse = ", "))
  nonthermal <- sort(intersect(formula_vars, unlist(H4_DOMAINS[setdiff(names(H4_DOMAINS), H4_STEP4_THERMAL_CATEGORIES)], use.names = FALSE)))
  base_heat <- list(`AIR_T_mid + AIR_RH + WIND_AWS` = c("ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_WIND_AWS"),
    `AIR_T_mid + AIR_RH + WIND_AWS + MRT` = c("ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_MRT"),
    MRT = "ucm_MRT", HUMIDEX = "ucm_HUMIDEX", PET = "ucm_PET", UTCI = "ucm_UTCI")
  pm <- intersect(H4_DOMAINS$Pollution, nonthermal)
  if (length(pm) != 3L || !all(c("ucm_MRT", "ucm_SND_dBA") %in% nonthermal)) stop("Step 4 requires three PM alternatives, MRT and sound")
  # h4_equation_table: UTCI + PM2.5 is primary; heat-form sensitivities use PM2.5, PM1/PM10 are size sensitivities on UTCI.
  stopifnot(nrow(h4_equation_table) == 7L, identical(h4_equation_table$equation_number, 1:7),
            all(h4_equation_table$heat_predictor_label %in% names(base_heat)), all(h4_equation_table$particulate_matter_column %in% pm),
            sum(h4_equation_table$equation_role == "primary") == 1L, !any(h4_equation_table$equation_role == "sound_sensitivity"))
  thermal <- list()
  for (local_index in seq_len(nrow(h4_equation_table))) {
    vars <- base_heat[[h4_equation_table$heat_predictor_label[local_index]]]
    attr(vars, "pm") <- h4_equation_table$particulate_matter_column[local_index]
    thermal[[h4_equation_thermal_label(h4_equation_table[local_index, , drop = FALSE])]] <- vars}
  selected <- unique(c(nonthermal, unlist(thermal, use.names = FALSE)))
  if (!setequal(selected, formula_vars)) stop("Centered columns differ from the Eq1-7 terms")
  h4_prepare_bout_design(raw_df, selected, nonthermal, thermal)}

h4_equation_catalog <- function(thermal, h4_equation_table) {
  stopifnot(nrow(h4_equation_table) == 7L, length(thermal) == 7L)
  for (local_index in seq_len(nrow(h4_equation_table))) {
    stopifnot(identical(names(thermal)[local_index], h4_equation_thermal_label(h4_equation_table[local_index, , drop = FALSE])))}
  out <- do.call(rbind, lapply(seq_len(nrow(h4_equation_table)), function(id) {
    vars <- thermal[[id]]
    data.frame(equation_id = h4_equation_table$equation_number[id], heat_form = names(thermal)[id],
      pm_representation = attr(vars, "pm"), role = h4_equation_table$equation_role[id],
      primary = h4_equation_table$equation_role[id] == "primary", block = "heat_plus_sound_additive", test = "Noise",  # no heat x sound interaction in Eq1-7
      terms = paste(vapply(h4_equation_term_order(h4_equation_table$equation_number[id]), h4_spell_term, character(1)), collapse = " + "),
      heat_role = if (length(vars) > 1L) "Air temperature + RH + apparent wind" else paste(h4_equation_table$heat_predictor_label[id], "only"),
      fitted = FALSE, stringsAsFactors = FALSE)
  }))
  stopifnot(nrow(out) == 7L, identical(out$equation_id, 1:7), sum(out$primary) == 1L, out$primary[1],
            out$role[1] == "primary", !any(out$role == "sound_sensitivity"), !anyDuplicated(out$terms),
            out$pm_representation[1:5] == "atmo_pm2.5_avg",
            out$pm_representation[6:7] == c("atmo_pm1_avg", "atmo_pm10_avg"))
  out$analysis_role <- ifelse(out$primary, "pre-specified primary (UTCI + PM2.5)",
    ifelse(out$role == "heat_sensitivity", "heat-form sensitivity (PM2.5)", "PM size sensitivity (UTCI heat form)"))
  out}

# 6. H4.1 REML fit, CR2 inference and BH FDR

h4_env_int <- function(name, default = NA_integer_) {
  raw <- Sys.getenv(name, unset = "")
  if (!nzchar(raw)) return(default)
  local_values <- suppressWarnings(as.integer(raw))
  if (is.na(local_values)) stop("Environment variable ", name, " must be an integer, got: ", raw, call. = FALSE)
  local_values}

# Slice of Step 5 jobs (1-based); H4_JOB_END or H4_MAX_JOBS optional.
h4_step5_job_slice <- function(jobs) {
  n <- length(jobs)
  start <- h4_env_int("H4_JOB_START", 1L)
  end <- h4_env_int("H4_JOB_END", NA_integer_)
  max_jobs <- h4_env_int("H4_MAX_JOBS", NA_integer_)
  if (is.na(end) && !is.na(max_jobs)) end <- start + max_jobs - 1L
  if (is.na(end)) end <- n
  start <- max(1L, min(start, n))
  end <- max(start, min(end, n))
  list(
    jobs = jobs[start:end],
    indices = seq.int(start, end),
    start = start,
    end = end,
    total = n)}

h4_step5_load_records <- function(path, n_jobs) {
  empty <- vector("list", n_jobs)
  if (!file.exists(path)) return(empty)
  x <- tryCatch(readRDS(path), error = function(local_error) NULL)
  if (is.null(x)) return(empty)
  if (is.list(x) && identical(x$format, "step5_checkpoint") && is.list(x$records)) {
    rec <- x$records
    if (length(rec) == n_jobs) return(rec)
    if (length(rec) < n_jobs) return(c(rec, vector("list", n_jobs - length(rec))))
    return(rec[seq_len(n_jobs)])}
  empty}

h4_step5_write_checkpoint <- function(records, fingerprints, h4_model_dir) {
  path <- h4_path(h4_model_dir, h4_file("H4_fit_records.rds"))
  payload <- list(
    format = "step5_checkpoint",
    records = records,
    fingerprints = fingerprints,
    updated_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ"))
  saveRDS(payload, path, version = 2L)
  status_parts <- lapply(records, function(r) if (is.null(r)) NULL else r$status)
  status_parts <- Filter(Negate(is.null), status_parts)
  if (length(status_parts)) {
    status_df <- do.call(rbind, status_parts)
    utils::write.csv(status_df, h4_path(h4_model_dir, h4_file("H4_fit_status.csv")),
      row.names = FALSE, na = "NA")}
  n_done <- sum(!vapply(records, is.null, logical(1L)))
  cat(sprintf("[Step 5 checkpoint] %d/%d jobs saved -> %s\n", n_done, length(records), path))
  invisible(n_done)}

h4_complete_rows <- function(raw_df, outcome, equation_id, natural_log_outcomes = h4_study_spec$natural_log_outcome_names) {
  predictors <- unique(unlist(strsplit(h4_equation_term_order(equation_id), ":", fixed = TRUE)))
  predictors <- setdiff(predictors, H4_PHASE_SUM_COLS)
  values <- as.matrix(raw_df[, c(predictors, outcome), drop = FALSE])
  storage.mode(values) <- "double"
  ok <- rowSums(!is.finite(values)) == 0L
  if (outcome %in% natural_log_outcomes) ok <- ok & raw_df[[outcome]] > 0
  ok}

h4_fit_begin <- function(raw_df = NULL) {
  suppressPackageStartupMessages({
    library(nlme)
    library(clubSandwich)
  })
  if (is.null(raw_df)) {
    raw_df <- h4_read_merged_analysis_data()
    # Rebuild the averaged sensor columns (Atmotube PM, LYS) that are not stored in the raw CSV.
    raw_df <- h4_apply_average_sources(raw_df)}
  h4_model_dir <- OUT_DIR
  dir.create(h4_model_dir, recursive = TRUE, showWarnings = FALSE)
  job_start_env <- h4_env_int("H4_JOB_START", 1L)
  continue_checkpoint <- job_start_env > 1L || identical(Sys.getenv("H4_APPEND_BATCH", unset = ""), "1")
  if (!continue_checkpoint) {
  old_items <- list.files(h4_model_dir, pattern = paste0("^", H4_FILE_PREFIX, "_(coefficients|covariance_sensitivity|design_redundancy_by_outcome|equations|fit_records|fit_status|gvif_diagnostic|hypothesis|phase_contrasts|run_complete|session_info|lag60_sensitivity)"))
  h4_archive(file.path(h4_model_dir, old_items))
  } else {
    cat(sprintf("[Step 5] Continuing checkpoint (H4_JOB_START=%d or H4_APPEND_BATCH=1); fit_records/fit_status not archived.\n", job_start_env))}
  spec_rds <- tempfile(fileext = ".rds")
  saveRDS(h4_study_spec, spec_rds, version = 2L, compress = FALSE)
  # spec_md5 changes only when the analysis spec changes.
  fingerprints <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, spec_rds)))
  if (!identical(fingerprints[1:2], H4_START_MD5)) stop("Script or input changed since startup; no models run from inconsistent sources")
  names(fingerprints) <- c("code_md5", "input_md5", "spec_md5")
  unlink(spec_rds)
  list(raw_df = raw_df, h4_model_dir = h4_model_dir, fingerprints = fingerprints)}

h4_fit_queue <- function(fit_one_outcome, prep, preflight_df, fingerprints, h4_model_dir, outcomes, fit_equation_ids) {
  catalog <- prep$catalog
  nonthermal <- prep$nonthermal
  agreed_common <- prep$agreed_common
  raw_df <- prep$raw_df
  cat(sprintf("[Step 5] Fitting %d equations across %d outcomes serially...\n", length(fit_equation_ids), length(outcomes)))
  jobs <- unlist(lapply(outcomes, function(y) lapply(fit_equation_ids, function(eid) list(outcome = y, equation_id = eid))), recursive = FALSE)
  stopifnot(length(jobs) == length(outcomes) * length(fit_equation_ids))
  slice <- h4_step5_job_slice(jobs)
  ck_path <- h4_path(h4_model_dir, h4_file("H4_fit_records.rds"))
  records <- h4_step5_load_records(ck_path, length(jobs))
  publish_only <- identical(Sys.getenv("H4_PUBLISH_ONLY", unset = ""), "1")
  if (publish_only && file.exists(ck_path)) {
    xck <- tryCatch(readRDS(ck_path), error = function(local_error) NULL)
    if (!is.null(xck$fingerprints)) {
      fingerprints <- xck$fingerprints
      cat("[Step 5] H4_PUBLISH_ONLY=1: using fingerprints stored in fit_records checkpoint.\n")}
  }
  n_done_pre <- sum(!vapply(records, is.null, logical(1L)))
  if (publish_only && n_done_pre < length(jobs)) {
    stop(sprintf("H4_PUBLISH_ONLY=1 but checkpoint has only %d/%d jobs.", n_done_pre, length(jobs)), call. = FALSE)}
  cat(sprintf("[Step 5] Job queue: %d total; this run jobs %d-%d (%d jobs).\n",
              slice$total, slice$start, slice$end, length(slice$jobs)))
  cat("[Step 5] Serial fits; checkpoint after each job in this slice.\n")
  if (publish_only && n_done_pre == length(jobs)) {
    cat("[Step 5] H4_PUBLISH_ONLY=1: skipping fit loop; publishing completed checkpoint.\n")}
  for (local_key in seq_along(slice$jobs)) {
    if (publish_only && n_done_pre == length(jobs)) break
    job <- slice$jobs[[local_key]]
    job_idx <- slice$indices[local_key]
    cat(sprintf("[Step 5 job %d/%d] START outcome=%s equation_id=%d\n",
                job_idx, slice$total, job$outcome, job$equation_id))
    t0 <- proc.time()[3L]
    res <- tryCatch(
      fit_one_outcome(job),
      error = function(local_error) {
        cat(sprintf("[Step 5 job %d/%d] ERROR outcome=%s equation_id=%d: %s\n",
                    job_idx, slice$total, job$outcome, job$equation_id, conditionMessage(local_error)))
        stop(local_error)})
    cat(sprintf("[Step 5 job %d/%d] DONE outcome=%s equation_id=%d (%.1fs)\n",
                job_idx, slice$total, job$outcome, job$equation_id, proc.time()[3L] - t0))
    records[[job_idx]] <- res
    h4_step5_write_checkpoint(records, fingerprints, h4_model_dir)}
  n_done <- sum(!vapply(records, is.null, logical(1L)))
  if (n_done < length(jobs)) {
    cat(sprintf("[Step 5] Partial: %d/%d jobs complete. Next batch: set H4_JOB_START=%d (or H4_MAX_JOBS=N).\n",
                n_done, length(jobs), slice$end + 1L))
    return(invisible(list(records = records, complete = FALSE, n_done = n_done)))}
  fit_results <- records
  attr(fit_results, "fingerprints") <- fingerprints
  h4_step5_write_checkpoint(records, fingerprints, h4_model_dir)
  published <- h4_publish_fits(fit_results, fingerprints, h4_model_dir, outcomes, fit_equation_ids,
    catalog, nonthermal, agreed_common, preflight_df, raw_df)
  # The report writer uses the published coefficients and the checkpoint metadata.
  invisible(list(records = fit_results, complete = TRUE, h4 = published))}

# Fit each declared equation for one outcome; publication is handled separately.
h4_fit_equations <- function(fit_equation_ids, y, catalog, thermal, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, transformation,
    raw_df, agreed_common, fit_lme, nested, fitted_model) {
  coef_rows <- contrast_rows <- status_rows <- sens_rows <- lag_rows <- list()
  status_row <- function(success, converged, structure, note, residual_sd = NA_real_, ar1_rho = NA_real_,
                         lag1_normalized = NA_real_, n_adjacent = 0L, residual_skew = NA_real_, residual_excess_kurtosis = NA_real_,
                         boundary_variance = NA, high_ar1_flag = NA, min_cr2_df = NA_real_, min_cr2_df_heat = NA_real_)
    data.frame(equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y,
      success = success, n = nrow(model_data), n_participants = nlevels(model_data$ParticipantID),
      transformation = transformation, converged = converged, residual_structure = structure, residual_sd = residual_sd,
      ar1_rho = ar1_rho, lag1_normalized = lag1_normalized, n_adjacent = n_adjacent,
      residual_skew = residual_skew, residual_excess_kurtosis = residual_excess_kurtosis,
      boundary_variance = boundary_variance, high_ar1_flag = high_ar1_flag, min_cr2_df = min_cr2_df, min_cr2_df_heat = min_cr2_df_heat,
      participant_ids = paste(sort(unique(as.character(model_data$ParticipantID))), collapse = ";"),
      n_available_outcome = sum(is.finite(raw_df[[y]])), n_removed = nrow(raw_df) - nrow(model_data),
      note = note, stringsAsFactors = FALSE)
  coef_frame <- function(term, est, se, df, p = 2 * pt(-abs(est / se), df), note = "")
    data.frame(equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y, term = term, estimate = est, se = se, df = df,
      residual_structure = attempt$residual_structure, ci_low = est - qt(0.975, df) * se, ci_high = est + qt(0.975, df) * se,
      t_stat = est / se, p_value = p, q_value = NA_real_, low_df_flag = is.finite(df) & df < 4, term_note = note, stringsAsFactors = FALSE)
  for (eq_id in fit_equation_ids) {
    eq_row <- catalog[catalog$equation_id == eq_id, ]
    heat_representation <- eq_row$heat_form
    blk <- eq_row$block
    original_terms <- fitted_model$original_terms
    safe_terms <- fitted_model$safe_terms
    model_data <- fitted_model$data
    fml <- fitted_model$formula
    attempt <- fitted_model$attempt
    fit <- attempt$fit
    if (is.null(fit)) {
      status_rows[[length(status_rows) + 1]] <- status_row(FALSE, FALSE, "not_fitted",
        paste("AR1 and independent-residual fits failed:", attempt$note))
      next}
    cr2_messages <- character()
    robust <- tryCatch(withCallingHandlers({
      result <- clubSandwich::coef_test(fit, vcov = "CR2", cluster = model_data$ParticipantID, test = "Satterthwaite")
      if (!isTRUE(all.equal(as.numeric(result$beta), as.numeric(nlme::fixef(fit)), tolerance = 1e-8)))
        stop("CR2 coefficient order does not match fixed effects")
      result
    }, warning = function(warning_condition) cr2_messages <<- c(cr2_messages, conditionMessage(warning_condition))),
      error = function(local_error) { cr2_messages <<- c(cr2_messages, conditionMessage(local_error)); NULL })
    if (is.null(robust)) {
      status_rows[[length(status_rows) + 1]] <- status_row(FALSE, TRUE, attempt$residual_structure,
        paste("CR2 estimation failed:", attempt$note, paste(cr2_messages, collapse = "; ")))
      next}
    normalized_residuals <- tryCatch(residuals(fit, level = 2, type = "normalized"), error = function(local_error) NULL)
    grp <- interaction(model_data$ParticipantID, model_data$PhaseID, drop = TRUE)
    adj <- which(as.character(grp[-1]) == as.character(grp[-length(grp)]) & abs(diff(model_data$Time10) - 1) < 1e-6)
    lag1 <- if (!is.null(normalized_residuals) && length(adj) > 2) stats::cor(normalized_residuals[adj], normalized_residuals[adj + 1L]) else NA_real_
    rho <- tryCatch(unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(local_error) NA_real_)
    if (length(rho) != 1L) rho <- NA_real_
    centered_normalized_residuals <- if (!is.null(normalized_residuals)) normalized_residuals - mean(normalized_residuals) else NULL
    rms <- if (!is.null(centered_normalized_residuals)) sqrt(mean(centered_normalized_residuals^2)) else NA_real_
    skew <- if (!is.null(centered_normalized_residuals) && rms > 0) mean((centered_normalized_residuals / rms)^3) else NA_real_
    kurt <- if (!is.null(centered_normalized_residuals) && rms > 0) mean((centered_normalized_residuals / rms)^4) - 3 else NA_real_
    variance_text <- nlme::VarCorr(fit)[, "Variance"]
    random_var <- as.numeric(variance_text[grepl("^[0-9.+eE-]+$", variance_text)])
    boundary <- any(random_var[is.finite(random_var)] < 1e-6 * sigma(fit)^2)
    high_ar1 <- is.finite(rho) & rho > 0.95
    # low_df_flag: CR2/Satterthwaite df < 4 (Tipton 2015; Pustejovsky & Tipton 2018); flagged, not dropped.
    coefficient_results <- coef_frame(c("Intercept", original_terms), robust$beta, robust$SE, robust$df_Satt)
    # Under contr.sum(4) the fourth phase deviation is exactly PhaseSumBikeU = -(WalkG + WalkU + BikeG).
    phase_cols <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
    if (all(phase_cols %in% original_terms)) {
      bikeu <- tryCatch(c(h4_bikeu_contrast(fit, model_data$ParticipantID), list(NULL)),
        error = function(local_error) list(NA_real_, NA_real_, NA_real_, NA_real_, paste("BikeU contrast failed:", conditionMessage(local_error))))
      pos <- match("PhaseSumBikeG", coefficient_results$term)
      coefficient_results <- rbind(coefficient_results[seq_len(pos), ], coef_frame("PhaseSumBikeU", bikeu[[1]], bikeu[[2]], bikeu[[3]], bikeu[[4]],
        paste(c("Derived contrast: BikeU = -(WalkG + WalkU + BikeG)", bikeu[[5]]), collapse = "; ")),
        coefficient_results[-seq_len(pos), ])
      rownames(coefficient_results) <- NULL}
    coefficient_results$term_category <- "Nonthermal_Covariate"
    coefficient_results$term_category[coefficient_results$term == "Intercept"] <- "Intercept"
    coefficient_results$term_category[startsWith(coefficient_results$term, "Phase")] <- "Phase_Condition"
    heat_terms <- unique(c(thermal[[heat_representation]], intersect(original_terms, "ucm_MRT")))
    coefficient_results$term_category[coefficient_results$term %in% heat_terms] <- "Heat_Main_Effect"
    sound_ix <- grepl(":", coefficient_results$term, fixed = TRUE) & grepl("ucm_SND_dBA", coefficient_results$term, fixed = TRUE)
    coefficient_results$term_category[sound_ix] <- "Thermal_x_Sound"
    coefficient_results$term_category[grepl(":PhaseSum", coefficient_results$term, fixed = TRUE)] <- "Thermal_x_Phase"
    # Candidate terms are specified before outcome fits; no significance-based or PCA selection.
    coefficient_results$selection_status <- ifelse(coefficient_results$term == "Intercept", "intercept",
      ifelse(coefficient_results$term_category == "Nonthermal_Covariate" & !(coefficient_results$term %in% agreed_common),
             "retained_candidate", "specified_term"))
    coef_non_int <- coefficient_results[coefficient_results$term != "Intercept", ]
    min_df <- if (nrow(coef_non_int) > 0) min(coef_non_int$df, na.rm = TRUE) else NA_real_
    heat_only <- coef_non_int[coef_non_int$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound", "Thermal_x_Phase"), ]
    min_df_heat <- if (nrow(heat_only) > 0) min(heat_only$df, na.rm = TRUE) else NA_real_
    status_rows[[length(status_rows) + 1]] <- status_row(TRUE, TRUE, attempt$residual_structure,
      paste(if (identical(attempt$residual_structure, "independent_fallback")) "INDEPENDENT-RESIDUAL FALLBACK (not equivalent to AR1)" else paste(attempt$residual_structure, "fit completed"),
            attempt$note, paste(cr2_messages, collapse = "; "), sep = "; "),
      residual_sd = sigma(fit), ar1_rho = rho, lag1_normalized = lag1, n_adjacent = length(adj),
      residual_skew = skew, residual_excess_kurtosis = kurt, boundary_variance = boundary, high_ar1_flag = high_ar1,
      min_cr2_df = min_df, min_cr2_df_heat = min_df_heat)
    coef_rows[[length(coef_rows) + 1]] <- coefficient_results
    contrast_messages <- character()
    phase_tests <- tryCatch(withCallingHandlers(h4_phase_contrasts(fit, model_data$ParticipantID),
      warning = function(warning_condition) contrast_messages <<- c(contrast_messages, conditionMessage(warning_condition))),
      error = function(local_error) { contrast_messages <<- c(contrast_messages, conditionMessage(local_error)); NULL })
    if (is.null(phase_tests)) phase_tests <- data.frame(contrast = rownames(h4_phase_contrast_weights()), estimate = NA_real_,
      se = NA_real_, df = NA_real_, low_df_flag = NA, ci_low = NA_real_, ci_high = NA_real_, p_value = NA_real_)
    contrast_rows[[length(contrast_rows) + 1L]] <- cbind(phase_tests, outcome = y, residual_structure = attempt$residual_structure,
      equation_id = eq_id, note = paste(contrast_messages, collapse = "; "), stringsAsFactors = FALSE)
    sens_part <- h4_sensitivity_rows(coefficient_results, attempt, boundary, high_ar1, fit_lme, fml, model_data,
      original_terms, safe_terms, nested, eq_id, heat_representation, blk, y)
    if (!is.null(sens_part)) sens_rows[[length(sens_rows) + 1L]] <- sens_part

    lag_part <- h4_lag60_rows(coefficient_results, attempt, fit_lme, fml, nested, make_design,
      centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
      eq_row, original_terms, safe_terms, eq_id, y)
    if (!is.null(lag_part)) lag_rows[[length(lag_rows) + 1L]] <- lag_part}

  list(
    coef = if (length(coef_rows)) do.call(rbind, coef_rows) else NULL,
    status = if (length(status_rows)) do.call(rbind, status_rows) else NULL,
    contrasts = if (length(contrast_rows)) do.call(rbind, contrast_rows) else NULL,
    sensitivity = if (length(sens_rows)) do.call(rbind, sens_rows) else NULL,
    lag60 = if (length(lag_rows)) do.call(rbind, lag_rows) else NULL)}

h4_coefficient_fdr <- function(results, equation, term, p, eligible, outcomes) {
  tested <- term != "Intercept" & term != "(Intercept)"
  available <- eligible & is.finite(p)
  results$q <- results$q_equation <- NA_real_
  for (key in unique(paste(equation, term))) {
    rows <- which(paste(equation, term) == key & tested & available)
    if (length(rows)) results$q[rows] <- p.adjust(p[rows], "BH", n = length(outcomes))}
  for (eq in unique(equation)) {
    rows <- which(equation == eq & tested & available)
    planned <- length(unique(term[equation == eq & tested])) * length(outcomes)
    if (length(rows)) results$q_equation[rows] <- p.adjust(p[rows], "BH", n = planned)}
  results$inference_status <- ifelse(!available, "Not estimable: model covariance or coefficient inference unavailable",
    ifelse(!tested, "Not applicable: intercept is not an exposure or phase contrast", "Tested"))
  results$FDR_scope <- ifelse(tested, sprintf("BH per term within equation across %d planned outcomes; q_equation covers all non-intercept terms within equation", length(outcomes)),
    "Not applicable: intercept")
  results$FDR_significant <- ifelse(is.finite(results$q), ifelse(results$q < .05, "TRUE", "FALSE"),
    ifelse(tested, "Not estimable", "Not applicable"))
  results$FDR_equation_significant <- ifelse(is.finite(results$q_equation), ifelse(results$q_equation < .05, "TRUE", "FALSE"),
    ifelse(tested, "Not estimable", "Not applicable"))
  results}

h4_write_phase_results <- function(results, coefficients, status, report, prepared) {
  model_dir <- OUT_DIR
  dir.create(model_dir, recursive = TRUE, showWarnings = FALSE)
  old <- list.files(RESULT_DIR, full.names = TRUE)
  h4_archive(old[file.exists(old) & !dir.exists(old)])
  write_table <- function(data, path) write.csv(data, path, row.names = FALSE, na = "NA")
  coverage <- do.call(rbind, lapply(results, `[[`, "coverage"))
  names(coverage)[names(coverage) == "epochs"] <- "N_valid_epochs"
  bout_rows <- table(paste(prepared$raw_df$ParticipantID, prepared$raw_df$PhaseID, sep = "::"))
  coverage$N_expected_epochs <- as.integer(bout_rows[paste(coverage$ParticipantID, coverage$PhaseID, sep = "::")])  # bout's own row count
  coverage$Coverage_pct <- 100 * coverage$N_valid_epochs / coverage$N_expected_epochs
  write_table(coverage, h4_path(OUT_DIR, h4_file("H4_Phase_Coverage.csv")))
  status$heat_form <- prepared$catalog$heat_form[match(status$equation_id, prepared$catalog$equation_id)]
  status$residual_structure <- "phase_random_intercept"
  index <- match(paste(coefficients$equation_id, coefficients$outcome), paste(status$equation_id, status$outcome))
  coefficients$residual_structure <- "phase_random_intercept"
  coefficients$covariance_robust <- "Not applicable: no temporal covariance comparison"
  coefficients$model_note <- paste(status$note[index],
    ifelse(status$boundary_variance[index], "Boundary random-intercept variance;", ""))
  coefficients$analysis_role <- "Exploratory VIF-screened phase-mean models; participant-cluster inference"
  coefficients$independent_unit <- "Participant cluster; repeated phase means"
  coefficients$p_method <- "participant-cluster CR2 / Satterthwaite"
  reportable <- !coefficients$term_type %in% "intercept"
  write_table(coefficients[reportable, ], h4_path(RESULT_DIR, h4_file("H4_Heat_Noise_Exposures.csv")))
  if (H4_WRITE_DETAILS) write_table(coefficients[reportable, ], h4_path(RESULT_DIR, h4_file("H4_Covariates_and_Phases.csv")))
  catalog <- prepared$catalog
  catalog$analysis_role <- paste("Phase-mean sensitivity:", catalog$analysis_role)
  catalog$attempted <- vapply(catalog$equation_id, function(id) sum(status$equation_id == id), integer(1))
  catalog$succeeded <- vapply(catalog$equation_id, function(id) sum(status$success[status$equation_id == id]), integer(1))
  catalog$failed <- catalog$attempted - catalog$succeeded
  catalog$fitted <- catalog$succeeded > 0
  catalog$random <- "~1|ParticipantID"
  catalog$correlation <- "None: one phase mean per participant-phase"
  comparisons <- do.call(rbind, lapply(results, `[[`, "contrasts"))
  grid <- expand.grid(outcome = h4_study_spec$all_physiological_outcomes, equation_id = h4_equation_table$equation_number,
    contrast = rownames(h4_phase_contrast_weights()), stringsAsFactors = FALSE)
  if (is.null(comparisons)) {
    comparisons <- grid
    comparisons$p_value <- NA_real_
  } else comparisons <- merge(grid, comparisons, by = c("outcome", "equation_id", "contrast"), all.x = TRUE)
  comparisons <- h4_coefficient_fdr(comparisons, comparisons$equation_id, comparisons$contrast,
    comparisons$p_value, is.finite(comparisons$p_value), h4_study_spec$all_physiological_outcomes)
  phase_included <- vapply(h4_equation_table$equation_number, function(id)
    all(H4_PHASE_SUM_COLS %in% h4_equation_term_order(id)), logical(1))
  no_phase <- !phase_included[match(comparisons$equation_id, h4_equation_table$equation_number)]
  comparisons$inference_status[no_phase] <- "Not applicable: phase adjustment not included in the retained model"
  comparisons$FDR_significant[no_phase] <- comparisons$FDR_equation_significant[no_phase] <- "Not applicable"
  comparisons$FDR_scope[no_phase] <- "Not applicable: no phase contrasts fitted"
  report <- c(report, sprintf("Separate exploratory phase contrasts: %d per-contrast q<.05 and %d equation-wide contrast q<.05; these are phase comparisons, not heat/sound exposure findings.",
    sum(comparisons$q < .05, na.rm = TRUE), sum(comparisons$q_equation < .05, na.rm = TRUE)))
  design <- status
  design$passes_check <- design$full_rank
  design$diagnostic <- "Phase-mean design; participant-centered phase exposures"
  bundle <- list(H4_coefficients.csv = coefficients, H4_fit_status.csv = status,
    H4_equations.csv = catalog, H4_phase_contrasts.csv = comparisons,
    H4_design_redundancy_by_outcome.csv = design)
  names(bundle) <- h4_file(names(bundle))
  for (name in names(bundle)) if (is.data.frame(bundle[[name]])) write_table(bundle[[name]], h4_path(model_dir, name)) else
    writeLines(bundle[[name]], h4_path(model_dir, name))
  design_lines <- vapply(h4_equation_table$equation_number, function(id) sprintf("Eq%d: %d-%d phase observations; full rank %s.",
    id, min(status$n[status$equation_id == id]), max(status$n[status$equation_id == id]),
    if (all(status$full_rank[status$equation_id == id])) "yes" else "no"), character(1))
  saveRDS(results, h4_path(model_dir, h4_file("H4_fit_records.rds")))
  writeLines(c(report, "", design_lines), h4_path(RESULT_DIR, h4_file("H4_Report.md")))
  paths <- list.files(RESULT_DIR, recursive = TRUE, full.names = TRUE)
  paths <- paths[!dir.exists(paths) & basename(paths) != h4_file("H4_run_complete.csv")]
  manifest <- data.frame(file = normalizePath(paths, winslash = "/"), md5 = unname(tools::md5sum(paths)),
    code_md5 = unname(tools::md5sum(file.path(SCRIPT_DIR, "Analysis_combined_phaseavg.R"))),
    equation_code_md5 = unname(tools::md5sum(file.path(SCRIPT_DIR, "Analysis_combined_timeseries.R"))),
    core_md5 = unname(tools::md5sum(file.path(SCRIPT_DIR, "library", "Analysis_combined_core.R"))), input_md5 = unname(tools::md5sum(RAW_DATA_PATH)),
    completed_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ"), run_complete = TRUE, run_scope = "PHASE_AVERAGE")
  write_table(manifest, file.path(model_dir, h4_file("H4_run_complete.csv")))
  cat("Phase-average output package:", RESULT_DIR, "\n", nrow(manifest), "tracked artifacts plus completion manifest\n")}

h4_phase_publish_results <- function(results, prepared) {
  coefficients <- do.call(rbind, lapply(results, `[[`, "coefficients"))
  status <- do.call(rbind, lapply(results, `[[`, "status"))
  coefficients <- h4_coefficient_fdr(coefficients, coefficients$equation_id, coefficients$term,
    coefficients$p, is.finite(coefficients$p), h4_study_spec$all_physiological_outcomes)
  failed <- !is.finite(coefficients$p)
  index <- match(paste(coefficients$equation_id, coefficients$outcome), paste(status$equation_id, status$outcome))
  coefficients$inference_status[failed] <- ifelse(status$note[index[failed]] == "Completed",
    "Not estimable: CR2 p-value or degrees of freedom unavailable", paste("Not estimable:", status$note[index[failed]]))
  coefficients$term <- sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", coefficients$term)
  report <- c("# H4 phase-average sensitivity", "",
    "These exploratory models use the seven explicit phase-average formulas in Analysis_combined_phaseavg.R. Each includes sum-to-zero phase adjustment; solar irradiance and GVI are omitted from this variant.",
    "The declared formulas are fixed across all 26 outcomes. Outcome-specific phase-mean design rank and VIF are reported; VIF flags do not automatically remove variables.",
    "All seven equations include the three sum-to-zero phase contrasts and a participant random intercept.",
    "The same matched eight-minute input as Analysis_combined_timeseries.R is averaged over each participant-phase; this does not change to the full-duration input. Participant random intercept, REML, participant-cluster CR2/Satterthwaite inference; no temporal AR(1).",
    "Epoch eligibility uses each original complete equation, preserving the screening comparison sample. SVF endpoint carry-forward follows H4 time-series preparation. Each model averages predictors and outcome over identical observed epochs.",
    "Natural-log outcomes (HRV, EDA tonic) are logged before averaging. Exposures are centered within participant across phase means and scaled by pooled SD before forming interactions.",
    "These are phase-mean associations, not within-bout fluctuations. Interactions are products of phase means, not means of epoch interaction products.",
    "q: BH across 26 planned outcomes per term/equation. q_equation: BH across all non-intercept terms and outcomes within equation. No correction across equations.",
    "Boundary variance, low df, missing phases and warnings remain visible; no automatic variable removal or uncorrelated fallback.", "",
    sprintf("Models with estimates: %d/%d; low-df coefficient rows: %d.",
      sum(status$success), nrow(status), sum(coefficients$low_df_flag)),
    sprintf("Per-term q<.05: %d; equation-wide q<.05: %d. Counts include exploratory adjustment/phase terms.",
      sum(coefficients$q < .05, na.rm = TRUE), sum(coefficients$q_equation < .05, na.rm = TRUE)))
  h4_write_phase_results(results, coefficients, status, report, prepared)
  invisible(NULL)}

h4_publish_fits <- function(fit_results, fingerprints, h4_model_dir, outcomes, fit_equation_ids,
    catalog, nonthermal, agreed_common, preflight_df, raw_df) {
  coef_all <- do.call(rbind, lapply(fit_results, `[[`, "coef"))
  status_all <- do.call(rbind, lapply(fit_results, `[[`, "status"))
  stopifnot(nrow(status_all) == length(outcomes) * length(fit_equation_ids),
            !anyDuplicated(status_all[, c("outcome", "equation_id")]))
  if (is.null(coef_all) || !nrow(coef_all)) stop("All fits failed; existing published outputs preserved")
  contrast_all <- do.call(rbind, lapply(fit_results, `[[`, "contrasts"))
  contrast_grid <- expand.grid(outcome = outcomes, equation_id = fit_equation_ids,
                              contrast = rownames(h4_phase_contrast_weights()), stringsAsFactors = FALSE)
  if (is.null(contrast_all)) stop("No phase-contrast records returned")
  stopifnot(!anyDuplicated(contrast_all[, c("outcome", "equation_id", "contrast")]))
  contrast_all <- merge(contrast_grid, contrast_all, by = c("outcome", "equation_id", "contrast"), all.x = TRUE)
  contrast_all$note[is.na(contrast_all$note)] <- paste0("Model failed; contrast not estimable (see ", h4_file("H4_fit_status.csv"), ")")
  # Phase contrasts have their own declared per-contrast/outcome correction, separate from exposure tests.
  contrast_all$fdr_note <- "BH per contrast within equation across planned outcomes; exploratory phase comparison"
  contrast_all$q_value <- NA_real_
  sens_all <- do.call(rbind, lapply(fit_results, `[[`, "sensitivity"))
  lag_all <- do.call(rbind, lapply(fit_results, `[[`, "lag60"))
  if (!is.null(lag_all)) {
    # Separate exploratory family: BH per equation x term across outcomes; never merged into the primary q.
    lag_all$q_lag60 <- NA_real_
    for (local_key in unique(paste(lag_all$equation_id, lag_all$term))) {
      idx <- which(paste(lag_all$equation_id, lag_all$term) == local_key & lag_all$inference_eligible & is.finite(lag_all$p_value))
      if (length(idx)) lag_all$q_lag60[idx] <- p.adjust(lag_all$p_value[idx], "BH", n = length(outcomes))}
    lag_all$FDR_significant <- ifelse(is.finite(lag_all$q_lag60), ifelse(lag_all$q_lag60 < .05, "TRUE", "FALSE"), "Not estimable")
    lag_all$FDR_scope <- "Exploratory lag sensitivity: BH per term/equation across planned outcomes"
    lag_all$inference_status <- ifelse(is.finite(lag_all$q_lag60), "Tested", paste("Not estimable:", lag_all$note))
    utils::write.csv(lag_all, h4_path(h4_model_dir, h4_file("H4_lag60_sensitivity.csv")), row.names = FALSE, na = "NA")}
  if (is.null(sens_all)) stop("No covariance sensitivity records returned")
  # Report every non-intercept term; failed inference is marked unavailable.
  primary_cats <- c("Heat_Main_Effect", "Thermal_x_Sound")
  is_sound <- coef_all$term %in% "ucm_SND_dBA"
  coef_all$term_category[is_sound] <- "Sound_Main_Effect"
  status_index <- match(paste(coef_all$equation_id, coef_all$outcome), paste(status_all$equation_id, status_all$outcome))
  stopifnot(!anyNA(status_index))
  unresolved_ar1 <- status_all$high_ar1_flag[status_index] %in% TRUE
  is_correlated_fit <- coef_all$residual_structure %in% c("AR1", "ARMA20") & !unresolved_ar1
  contrast_status <- match(paste(contrast_all$equation_id, contrast_all$outcome), paste(status_all$equation_id, status_all$outcome))
  contrast_eligible <- status_all$residual_structure[contrast_status] %in% c("AR1", "ARMA20") &
    !(status_all$high_ar1_flag[contrast_status] %in% TRUE)
  contrast_fdr <- h4_coefficient_fdr(data.frame(row = seq_len(nrow(contrast_all))), contrast_all$equation_id,
    contrast_all$contrast, contrast_all$p_value, contrast_eligible, outcomes)
  contrast_all$q_value <- contrast_fdr$q
  contrast_all$FDR_significant <- contrast_fdr$FDR_significant
  contrast_all$inference_status <- contrast_fdr$inference_status
  contrast_all$p_value[!contrast_eligible] <- NA_real_
  alternate_fdr <- h4_coefficient_fdr(data.frame(row = seq_len(nrow(sens_all))),
    paste(sens_all$equation_id, sens_all$sensitivity_specification), sens_all$term,
    sens_all$alt_p_value, sens_all$sensitivity_status == "success", outcomes)
  sens_all$alt_q <- alternate_fdr$q
  sens_all$alt_FDR_significant <- alternate_fdr$FDR_significant
  sens_all$alt_inference_status <- ifelse(sens_all$sensitivity_status == "success", alternate_fdr$inference_status,
    paste("Not estimable:", sens_all$sensitivity_status))
  sens_all$alt_FDR_scope <- "Exploratory covariance sensitivity: BH per equation, covariance specification and term across planned outcomes"
  m_term <- length(outcomes)
  fdr <- h4_coefficient_fdr(data.frame(row = seq_len(nrow(coef_all))), coef_all$equation_id,
    coef_all$term, coef_all$p_value, is_correlated_fit, outcomes)
  coef_all$q_term <- fdr$q
  coef_all$q_equation <- fdr$q_equation
  coef_all$fdr_family <- ifelse(is.finite(fdr$q), "per_term_within_equation", fdr$inference_status)

  st <- split(status_all$success, factor(status_all$equation_id, levels = catalog$equation_id))
  catalog$attempted <- unname(lengths(st))
  catalog$succeeded <- unname(vapply(st, sum, integer(1)))
  catalog$failed <- catalog$attempted - catalog$succeeded
  catalog$fitted <- catalog$succeeded > 0L
  catalog[c("code_md5", "input_md5")] <- as.list(fingerprints[c("code_md5", "input_md5")])
  status_all[names(fingerprints)] <- as.list(fingerprints)
  sens_all[names(fingerprints)] <- as.list(fingerprints)
  # covariance_robust = FALSE if an alternative estimate leaves the primary 95% CI, the CIs don't overlap or the sign flips.
  coef_all <- h4_merge_covariance_sensitivity(coef_all, sens_all)
  # Both correction scopes are explicit; sensitivity equations remain separate analyses.
  is_thermal <- coef_all$term_category %in% c(primary_cats, "Thermal_x_Phase")
  coef_out <- data.frame(equation = coef_all$heat_form, outcome = coef_all$outcome,
    term = sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", coef_all$term),
    term_type = ifelse(coef_all$term == "Intercept", "intercept", ifelse(startsWith(coef_all$term, "PhaseSum"), "phase (study design)",
      ifelse(is_thermal, "thermal exposure", ifelse(is_sound, "sound exposure", "covariate")))),
    Beta = coef_all$estimate, SE = coef_all$se, ci_low = coef_all$ci_low, ci_high = coef_all$ci_high, p = ifelse(is_correlated_fit, coef_all$p_value, NA_real_),
    df = coef_all$df, low_df_flag = coef_all$low_df_flag,
    q = fdr$q, q_equation = fdr$q_equation, FDR_significant = fdr$FDR_significant,
    FDR_equation_significant = fdr$FDR_equation_significant, FDR_scope = fdr$FDR_scope,
    inference_status = fdr$inference_status,
    covariance_robust = coef_all$covariance_robust, residual_structure = coef_all$residual_structure, stringsAsFactors = FALSE)
  hypo_df <- coef_out[!coef_out$term_type %in% "intercept", ]
  postsel <- setdiff(nonthermal, agreed_common)
  readme_lines <- h4_readme_lines(status_all, coef_all, catalog, preflight_df, raw_df, postsel, fingerprints)
  m_primary_txt <- sprintf("m = %d per term", as.integer(m_term))
  pkgs <- c("nlme", "clubSandwich", "car")
  session_lines <- c(capture.output(utils::sessionInfo()), "", paste0(pkgs, " ", vapply(pkgs, function(package_name)
    tryCatch(as.character(utils::packageVersion(package_name)), error = function(local_error) "not installed"), character(1))))
  bundle <- list(
    H4_equations.csv = catalog,
    H4_fit_status.csv = status_all,
    H4_coefficients.csv = coef_out,
    H4_hypothesis.csv = hypo_df,
    H4_phase_contrasts.csv = setNames(contrast_all, sub("^estimate$", "Beta", sub("^q_value$", "q", names(contrast_all)))),
    H4_covariance_sensitivity.csv = sens_all,
    H4_hypothesis_readme.txt = readme_lines,
    H4_session_info.txt = session_lines)
  names(bundle) <- h4_file(names(bundle))
  # Publish in sequence; the completion manifest is invalidated first.
  manifest_path <- file.path(h4_model_dir, h4_file("H4_run_complete.csv"))
  live_pair <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))
  stored_pair <- unname(fingerprints[c("code_md5", "input_md5")])
  if (!identical(live_pair, stored_pair)) {
    publish_only <- identical(Sys.getenv("H4_PUBLISH_ONLY", unset = ""), "1")
    if (publish_only && identical(live_pair[2L], stored_pair[2L])) {
      warning("H4 script fingerprint differs from checkpoint; input unchanged, publishing from checkpoint.", call. = FALSE)
    } else {
    stop("Script or input changed during fitting; checkpoint retained, inconsistent results not published")}
  }
  if (file.exists(manifest_path) && !file.remove(manifest_path)) stop("Cannot invalidate old completion manifest")
  for (nm in names(bundle)) {
    target_path <- h4_path(h4_model_dir, nm)
    if (is.data.frame(bundle[[nm]])) write.csv(bundle[[nm]], target_path, row.names = FALSE, na = "NA") else writeLines(bundle[[nm]], target_path)}
  extra_files <- h4_file(c("H4_fit_records.rds", "H4_gvif_diagnostic.csv", "H4_gvif_diagnostic.md",
                   "H4_design_redundancy_by_outcome.csv", "H4_covariance_sensitivity.csv", "H4_lag60_sensitivity.csv", "H4_session_info.txt"))
  man_files <- unique(c(names(bundle), extra_files[file.exists(file.path(h4_model_dir, extra_files))]))
  man_files <- man_files[file.exists(file.path(h4_model_dir, man_files))]  # only files saved in the results folder
  write.csv(data.frame(file = man_files, md5 = unname(tools::md5sum(file.path(h4_model_dir, man_files))), as.list(fingerprints),
    completed_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ"), run_complete = FALSE,
    run_scope = "FULL", stringsAsFactors = FALSE), manifest_path, row.names = FALSE)
  cat(sprintf("[Step 5] Bundle published to %s. Total fitted models: %d, Succeeded: %d, Failed: %d\n",
              h4_model_dir, nrow(status_all), sum(status_all$success), sum(!status_all$success)))
  cat(sprintf("[H4.1] Fixed-effect coefficient rows: %d, p < 0.05: %d, q < 0.05: %d (per-term BH; %s)\n",
              nrow(hypo_df), sum(hypo_df$p < 0.05, na.rm = TRUE), sum(hypo_df$q < 0.05, na.rm = TRUE), m_primary_txt))
  invisible(list(catalog = catalog, status = status_all, coef = coef_all, hypothesis = hypo_df))}

# Design check before fitting: a rank-deficient design stops the fit (no predictor removal).
h4_design_preflight <- function(raw_df, centered, selected, catalog, thermal, make_design, fit_equation_ids, outcomes, natural_log_outcomes) {
  preflight <- list()
  for (check_y in outcomes) {
    for (check_eid in fit_equation_ids) {
      valid <- h4_complete_rows(raw_df, check_y, check_eid, natural_log_outcomes)
      check_z <- centered[valid, , drop = FALSE]
      check_phase <- raw_df$PhaseID[valid]
      check_eq <- catalog[catalog$equation_id == check_eid, ]
      check_x <- make_design(check_z, thermal[[check_eq$heat_form]], check_phase, test = check_eq$test,
        terms_order = h4_equation_term_order(check_eid))
      vv <- h4_vif_per_term(check_x)
      gt <- attr(vv, "gvif_table")
      phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
      if (!nrow(phase_gt)) phase_gt <- data.frame(GVIF = NA_real_, Df = 3L, GVIF_root = NA_real_, VIF_equivalent = NA_real_)
      exposure_terms <- intersect(colnames(check_x), selected)
      cells <- interaction(raw_df$ParticipantID[valid], check_phase, drop = TRUE)
      within_share <- vapply(exposure_terms, function(local_values) {
        x <- check_x[, local_values]
        total <- sum((x - mean(x))^2)
        if (total <= 0) return(NA_real_)
        sum((x - ave(x, cells, FUN = mean))^2) / total
      }, numeric(1))
      rr <- qr(cbind(Intercept = 1, check_x))$rank
      sigmas <- apply(check_x, 2L, stats::sd)
      singular <- svd(sweep(sweep(check_x, 2L, colMeans(check_x), "-"), 2L, ifelse(is.finite(sigmas) & sigmas > 0, sigmas, 1), "/"), nu = 0L, nv = 0L)$d
      mx <- max(vv)
      preflight[[length(preflight) + 1L]] <- data.frame(equation_id = check_eid, heat_form = check_eq$heat_form, block = check_eq$block,
        outcome = check_y, n = nrow(check_x), rank = rr, expected_rank = ncol(check_x) + 1L, full_rank = rr == ncol(check_x) + 1L,
        max_vif = mx, worst_term = names(vv)[which.max(vv)], diagnostic = "Design-only GVIF^(1/Df); ordinary VIF for Df=1",
        phase_df = phase_gt$Df, phase_gvif = phase_gt$GVIF, phase_gvif_root = phase_gt$GVIF_root, phase_vif_equivalent = phase_gt$VIF_equivalent,
        term_vif_equivalents = paste(names(vv), signif(vv, 6), sep = "=", collapse = ";"),
        within_participant_phase_variation_share = paste(names(within_share), signif(within_share, 6), sep = "=", collapse = ";"),
        high_vif_terms = paste(names(vv)[!is.finite(vv) | vv >= h4_study_spec$variance_inflation_factor_limit], collapse = ";"),
        condition_index = if (!length(singular) || min(singular) <= 1e-10) Inf else max(singular) / min(singular),
        passes_check = rr == ncol(check_x) + 1L, vif_flag = is.finite(mx) && mx >= h4_study_spec$variance_inflation_factor_limit, stringsAsFactors = FALSE)}
  }
  do.call(rbind, preflight)}

h4_sensitivity_rows <- function(coefficient_results, attempt, boundary, high_ar1, fit_lme, fml, model_data,
    original_terms, safe_terms, nested, eq_id, heat_representation, blk, y) {
  sens_rows <- list()
  # Both covariance checks use the same fitting and coefficient-comparison code.
  target_idx <- which(coefficient_results$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound"))
  sensitivity_specs <- list()
  if (isTRUE(boundary)) sensitivity_specs$boundary <- list(
    flag = "boundary_variance", name = "random_intercept_participant_only_AR1",
    random = ~ 1 | ParticipantID, correlation = attempt$corfun())
  # Every AR1 fit gets an independent-residual comparison, including rho <= 0.95.
  if (isTRUE(high_ar1) || attempt$residual_structure %in% c("AR1", "ARMA20")) sensitivity_specs$independent <- list(
    flag = if (isTRUE(high_ar1)) "high_ar1" else "routine_independent_refit",
    name = "independent_residuals_nested_random_CR2",
    random = nested, correlation = NULL)
  if (length(target_idx)) for (specification in sensitivity_specs) {
    sensitivity_messages <- character()
    alt_fit <- fit_lme(fml, model_data, specification$random, specification$correlation, function(opt, kind, msg)
      sensitivity_messages <<- c(sensitivity_messages, if (kind == "error") paste0(opt, ": ", msg) else msg))
    alt_robust <- if (!is.null(alt_fit)) {
      tryCatch(clubSandwich::coef_test(alt_fit, vcov = "CR2", cluster = model_data$ParticipantID, test = "Satterthwaite"),
               error = function(local_error) { sensitivity_messages <<- c(sensitivity_messages, paste("CR2:", conditionMessage(local_error))); NULL })
    } else NULL
    for (i_t in target_idx) {
      t_name <- coefficient_results$term[i_t]
      p_est <- coefficient_results$estimate[i_t]
      alt_idx <- integer(0)
      local_key <- match(t_name, original_terms)
      if (!is.null(alt_robust) && !is.na(local_key)) {
        rn_match <- which(rownames(alt_robust) == safe_terms[local_key])
        if (length(rn_match) == 1L) alt_idx <- rn_match else if (local_key + 1L <= nrow(alt_robust)) alt_idx <- local_key + 1L}
      a_est <- a_se <- a_df <- a_cil <- a_cih <- a_pval <- NA_real_
      status_txt <- if (is.null(alt_fit)) paste("fit_failed:", paste(sensitivity_messages, collapse = "; ")) else "cr2_failed"
      if (length(alt_idx) == 1L) {
        a_est <- as.numeric(alt_robust$beta[alt_idx])
        a_se <- as.numeric(alt_robust$SE[alt_idx])
        a_df <- as.numeric(alt_robust$df_Satt[alt_idx])
        a_cil <- a_est - qt(0.975, a_df) * a_se
        a_cih <- a_est + qt(0.975, a_df) * a_se
        a_pval <- as.numeric(alt_robust[["p_Satt"]][alt_idx])
        status_txt <- "success"}
      sens_rows[[length(sens_rows) + 1L]] <- data.frame(
        equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y,
        diagnostic_flag = specification$flag,
        sensitivity_specification = specification$name,
        term = t_name, term_category = coefficient_results$term_category[i_t],
        primary_estimate = p_est, primary_se = coefficient_results$se[i_t], primary_df = coefficient_results$df[i_t],
        primary_ci_low = coefficient_results$ci_low[i_t], primary_ci_high = coefficient_results$ci_high[i_t], primary_p_value = coefficient_results$p_value[i_t],
        alt_estimate = a_est, alt_se = a_se, alt_df = a_df,
        alt_ci_low = a_cil, alt_ci_high = a_cih, alt_p_value = a_pval,
        estimate_diff = a_est - p_est, estimate_rel_diff_pct = if (is.finite(a_est) && abs(p_est) > 1e-12) 100 * (a_est - p_est) / abs(p_est) else NA_real_,
        ci_overlap = if (is.finite(a_est)) (coefficient_results$ci_low[i_t] <= a_cih) && (a_cil <= coefficient_results$ci_high[i_t]) else NA,
        sensitivity_status = status_txt, stringsAsFactors = FALSE)}
  }
  if (length(sens_rows)) do.call(rbind, sens_rows) else NULL}

h4_lag60_rows <- function(coefficient_results, attempt, fit_lme, fml, nested, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
    eq_row, original_terms, safe_terms, eq_id, y) {
  heat_vars <- thermal[[heat_representation]]
  # Lag the heat terms; include MRT only when the formula uses it (Eq2).
  lagged_vars <- unique(c(heat_vars, intersect(c("ucm_MRT"), original_terms)))
  lag_ok <- rowSums(!is.finite(lagged_exposures[, lagged_vars, drop = FALSE])) == 0L
  if (!any(lag_ok)) return(NULL)
  current_exposures <- centered_exposures[lag_ok, , drop = FALSE]
  lag_exposures <- current_exposures
  lag_exposures[, lagged_vars] <- lagged_exposures[lag_ok, lagged_vars, drop = FALSE]
  fit_comparison <- function(exposures) {
    design <- make_design(exposures, heat_vars, outcome_rows$PhaseID[lag_ok], test = eq_row$test,
      terms_order = h4_equation_term_order(eq_id))
    stopifnot(identical(colnames(design), original_terms))
    colnames(design) <- safe_terms
    data <- cbind(outcome_rows[lag_ok, , drop = FALSE], Y = outcome_values[lag_ok], as.data.frame(design))
    data <- data[order(data$ParticipantID, data$PhaseID, data$Time10), ]
    messages <- character()
    fit <- fit_lme(fml, data, nested, attempt$corfun(), function(opt, kind, msg)
      messages <<- c(messages, paste(opt, kind, msg)))
    robust <- if (!is.null(fit)) tryCatch(withCallingHandlers(
      clubSandwich::coef_test(fit, vcov = "CR2", cluster = data$ParticipantID, test = "Satterthwaite"),
      warning = function(warning_condition) messages <<- c(messages, conditionMessage(warning_condition))),
      error = function(local_error) { messages <<- c(messages, conditionMessage(local_error)); NULL }) else NULL
    rho <- if (!is.null(fit) && identical(attempt$residual_structure, "AR1"))
      as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE)) else NA_real_
    eligible <- !is.null(robust) && attempt$residual_structure %in% c("AR1", "ARMA20") &&
      !(length(rho) == 1L && is.finite(rho) && rho > .95)
    list(data = data, robust = robust, eligible = eligible, note = paste(messages, collapse = "; "))}
  current <- fit_comparison(current_exposures)
  lagged <- fit_comparison(lag_exposures)
  stopifnot(identical(current$data[, c("ParticipantID", "PhaseID", "Time10", "Y")],
                      lagged$data[, c("ParticipantID", "PhaseID", "Time10", "Y")]))
  term_result <- function(result, term) {
    index <- if (!is.null(result$robust)) match(term, rownames(result$robust)) else NA_integer_
    if (is.na(index)) return(c(estimate = NA, se = NA, df = NA, ci_low = NA, ci_high = NA, p = NA))
    estimate <- result$robust$beta[index]; se <- result$robust$SE[index]; df <- result$robust$df_Satt[index]
    c(estimate = estimate, se = se, df = df, ci_low = estimate - qt(.975, df) * se,
      ci_high = estimate + qt(.975, df) * se,
      p = if (result$eligible) result$robust$p_Satt[index] else NA_real_)}
  rows <- lapply(which(coefficient_results$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound")), function(local_index) {
    term <- coefficient_results$term[local_index]
    safe_term <- safe_terms[match(term, original_terms)]
    lag_result <- term_result(lagged, safe_term); current_result <- term_result(current, safe_term)
    data.frame(equation_id = eq_id, heat_form = heat_representation, outcome = y, term = term,
      term_category = coefficient_results$term_category[local_index], residual_structure = attempt$residual_structure,
      n = nrow(lagged$data), estimate = lag_result["estimate"], se = lag_result["se"], df = lag_result["df"],
      ci_low = lag_result["ci_low"], ci_high = lag_result["ci_high"], p_value = lag_result["p"],
      inference_eligible = lagged$eligible,
      same_sample_current_estimate = current_result["estimate"], same_sample_current_se = current_result["se"],
      same_sample_current_df = current_result["df"], same_sample_current_ci_low = current_result["ci_low"],
      same_sample_current_ci_high = current_result["ci_high"], same_sample_current_p = current_result["p"],
      same_sample_current_inference_eligible = current$eligible,
      note = paste("Current:", current$note, "Lagged:", lagged$note), row.names = NULL, stringsAsFactors = FALSE)
  })
  if (length(rows)) do.call(rbind, rows) else NULL}

# covariance_robust = FALSE if an alternative estimate leaves the primary 95% CI, the CIs don't overlap or the sign flips.
h4_merge_covariance_sensitivity <- function(coef_all, sens_all) {
  coef_all$covariance_robust <- NA; coef_all$alt_estimate <- NA_real_; coef_all$alt_ci_low <- NA_real_
  coef_all$alt_ci_high <- NA_real_; coef_all$alt_structure <- NA_character_
  sens_ok <- sens_all[sens_all$sensitivity_status == "success" & is.finite(sens_all$alt_estimate), , drop = FALSE]
  if (nrow(sens_ok)) {
    sens_ok$fails <- with(sens_ok, alt_estimate < primary_ci_low | alt_estimate > primary_ci_high |
                            !(ci_overlap %in% TRUE) | sign(alt_estimate) != sign(primary_estimate))
    key_s <- paste(sens_ok$equation_id, sens_ok$outcome, sens_ok$term)
    key_c <- paste(coef_all$equation_id, coef_all$outcome, coef_all$term)
    has <- key_c %in% key_s
    coef_all$covariance_robust[has] <- !vapply(key_c[has], function(local_key) any(sens_ok$fails[key_s == local_key]), logical(1))
    pick <- sens_ok[order(sens_ok$sensitivity_specification != "independent_residuals_nested_random_CR2"), , drop = FALSE]
    other_index <- match(key_c, paste(pick$equation_id, pick$outcome, pick$term))
    coef_all$alt_estimate <- pick$alt_estimate[other_index]; coef_all$alt_ci_low <- pick$alt_ci_low[other_index]
    coef_all$alt_ci_high <- pick$alt_ci_high[other_index]; coef_all$alt_structure <- pick$sensitivity_specification[other_index]}
  fb_rows <- coef_all$residual_structure %in% "independent_fallback"
  coef_all$covariance_robust[fb_rows] <- NA; coef_all$alt_estimate[fb_rows] <- NA_real_
  coef_all$alt_ci_low[fb_rows] <- NA_real_; coef_all$alt_ci_high[fb_rows] <- NA_real_; coef_all$alt_structure[fb_rows] <- NA_character_
  coef_all}

h4_readme_lines <- function(status_all, coef_all, catalog, preflight_df, raw_df, postsel, fingerprints) {
  primary_cats <- c("Heat_Main_Effect", "Thermal_x_Sound")
  status_index <- match(paste(coef_all$equation_id, coef_all$outcome), paste(status_all$equation_id, status_all$outcome))
  stopifnot(!anyNA(status_index))
  n_rows_fit <- status_all$n[status_all$success]
  n_text <- if (length(n_rows_fit)) sprintf("%d-%d rows per outcome-equation (median %d)", min(n_rows_fit), max(n_rows_fit), as.integer(stats::median(n_rows_fit))) else "no successful fits"
  vif_max <- suppressWarnings(max(preflight_df$max_vif[is.finite(preflight_df$max_vif)]))
  vif_txt <- if (is.finite(vif_max)) sprintf("max grouped VIF-equiv = %.2f; %d design(s) >= %s", vif_max, sum(preflight_df$vif_flag, na.rm = TRUE), h4_study_spec$variance_inflation_factor_limit) else "VIF not computed"
  np_rng <- range(status_all$n_participants[status_all$success], na.rm = TRUE)
  hits <- coef_all[coef_all$term_category %in% primary_cats & is.finite(coef_all$q_term) & coef_all$q_term < 0.05, , drop = FALSE]
  hits_txt <- if (nrow(hits)) sprintf("%d thermal q<0.05 row(s); see H4_coefficients.csv", nrow(hits)) else "none (no q < 0.05)"
  eq_ids <- paste(catalog$equation_id, collapse = ", ")
  c(
    "H4.1 Physiological Sensor Time-Series Models",
    "Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md",
    sprintf("Equations (catalog ids): %s - primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.", eq_ids),
    sprintf("Sample: 10 s windows; %s; %d outcomes; participants %d-%d per model.", n_text, length(unique(status_all$outcome)), np_rng[1], np_rng[2]),
    sprintf("Design VIF (threshold %s): %s. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.", h4_study_spec$variance_inflation_factor_limit, vif_txt),
    sprintf("Fits: %d/%d successful outcome-equation models. All non-intercept coefficients have BH q across planned outcomes per term/equation, plus q_equation across all non-intercept terms/outcomes within equation. Intercepts and invalid inference have explicit status text. Equations are not pooled into one correction family.", sum(status_all$success), nrow(status_all)),
    sprintf("SVF endpoint carry-forward rows: %d.", sum(raw_df$SVF_endpoint_carried)),
    sprintf("Covariates retained after Step 4: %s.", if (length(postsel)) paste(postsel, collapse = ", ") else "none"),
    sprintf("Thermal q<0.05: %s. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).", hits_txt),
    sprintf("All non-intercept coefficients: %d per-term q<0.05 and %d equation-wide q<0.05. These include exploratory adjustment/phase effects and repeated sensitivity specifications, not independent H4 discoveries.",
      sum(coef_all$q_term < .05, na.rm = TRUE), sum(coef_all$q_equation < .05, na.rm = TRUE)),
    sprintf("Sound main effects: %d per-term q<0.05. Sound interactions: %d. Phase contrasts and other adjustments are fully reported in the coefficient tables.",
      sum(coef_all$q_term[coef_all$term_category == "Sound_Main_Effect"] < .05, na.rm = TRUE),
      sum(coef_all$q_term[coef_all$term_category == "Thermal_x_Sound"] < .05, na.rm = TRUE)),
    sprintf("Generated: %s UTC | code_md5 %s | input_md5 %s | spec_md5 %s",
            format(Sys.time(), tz = "UTC", format = "%Y-%m-%d %H:%M:%S"),
            fingerprints["code_md5"], fingerprints["input_md5"], fingerprints["spec_md5"]))}

# 7. Pipeline: h4_run_full_pipeline, h4_dispatch_run

h4_run_models <- function(raw_df) {
  prep <- h4_step4_exposure_prep(raw_df)
  step5_result <- h4_fit(raw_df, prep = prep)
  h4_write_results(step5_result)
  invisible(step5_result)}

# Full-run input: archive earlier result files, then load the merged input.
h4_load_input <- function() {
  h4_archive(file.path(RESULT_DIR, h4_file(c("H4_Heat_Noise_Exposures.csv", "H4_Covariates_and_Phases.csv", "H4_Report.md"))))
  input_data <- h4_read_merged_analysis_data()
  analysis_keys <- do.call(paste, c(input_data[c("ParticipantID", "PhaseID", "Datetime")], sep = "::"))
  if (anyDuplicated(analysis_keys)) stop("Duplicate merge keys in analysis input.")
  input_data$ParticipantID <- as.character(input_data$ParticipantID)
  input_data$PhaseID <- as.character(input_data$PhaseID)
  input_data <- input_data[input_data$ParticipantID %in% h4_study_spec$participants, ]
  input_data$ParticipantID <- factor(input_data$ParticipantID, levels = h4_study_spec$participants)
  h4_apply_average_sources(input_data, missing_only = FALSE)}

h4_run_full_pipeline <- function() {
  h4_run_models(h4_load_input())
  cat("H4 multivariate full pipeline completed successfully.\n")
  invisible()}

# Optional flags: H4_GVIF_ONLY, H4_STEP5_ONLY (fit without archiving), H4_PUBLISH_ONLY; otherwise the full pipeline.
h4_dispatch_run <- function() {
  if (identical(Sys.getenv("H4_GVIF_ONLY"), "1")) {
    if (h4_model_outputs_locked())
      stop("A completed model bundle exists; rerun Step 5 instead of rewriting GVIF files after hashing.")
    raw_df <- h4_read_merged_analysis_data()
    raw_df <- h4_apply_average_sources(raw_df)
    out <- h4_run_gvif_diagnostic(h4_step4_exposure_prep(raw_df))
    cat("Wrote GVIF diagnostic:", out$paths["csv"], "\n")
    return(invisible())}
  if (identical(Sys.getenv("H4_STEP5_ONLY"), "1")) {
    raw_df <- h4_read_merged_analysis_data()
    raw_df <- h4_apply_average_sources(raw_df)
    h4_run_models(raw_df)
    cat("H4 multivariate Step 5 execution completed successfully.\n")
    return(invisible())}
  h4_run_full_pipeline()}

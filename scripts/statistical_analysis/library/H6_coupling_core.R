# H6_coupling_core.R — prespecified within-person coupling LMMs (phase means or 10 s epochs).
# Sourced by H6_stress_composite_phaseavg.R and H6_stress_composite_timeseries.R after H6_SPEC is set.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H6_coupling_core.R.", call. = FALSE)}
if (!exists("H6_SPEC", envir = .GlobalEnv, inherits = FALSE)) {
  stop("H6_SPEC must be set before sourcing H6_coupling_core.R.", call. = FALSE)}

RESULTS_ROOT <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results")
OUT_DIR <- file.path(RESULTS_ROOT, H6_SPEC$results_subdir)
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

PARTICIPANTS <- H6_SPEC$participants
CORE_PHASES <- H6_SPEC$phases
MATCHED_CAP_SEC <- H6_SPEC$matched_cap_sec
RAW_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
GRAIN <- H6_SPEC$analysis_grain
ENTRY_SCRIPT <- H6_SPEC$entry_script
FILE_PREFIX <- H6_SPEC$file_prefix

mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)

safe_write_csv <- function(data, path) {
  tryCatch(write.csv(data, path, row.names = FALSE, na = ""), error = function(local_error) {
    warning("Could not write ", path, ": ", conditionMessage(local_error))
  })}

h6_pair_mean_columns <- function(input_data) {
  safe_pair_mean <- function(data, left, right) {
    if (!all(c(left, right) %in% names(data))) return(rep(NA_real_, nrow(data)))
    z <- rowMeans(cbind(as.numeric(data[[left]]), as.numeric(data[[right]])), na.rm = TRUE)
    z[is.nan(z)] <- NA_real_
    z}
  pair_map <- list(
    atmo_pm1.0_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
    atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
    lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))
  for (nm in names(pair_map)) input_data[[nm]] <- do.call(safe_pair_mean, c(list(input_data), pair_map[[nm]]))
  input_data}

h6_wpz <- function(x, pid) {
  fn <- get0("PAPER3_OUTCOME_WITHIN_PERSON_Z", envir = .GlobalEnv, ifnotfound = paper3_within_person_z)
  fn(x, pid)}

h6_oriented_wpz <- function(x, pid, stress_direction, transform_fn = NULL, col = NULL) {
  if (is.function(transform_fn) && !is.null(col)) x <- transform_fn(x, col)
  as.numeric(stress_direction) * h6_wpz(x, pid)}

h6_composite_rowmean <- function(mat) {
  if (is.null(mat) || ncol(mat) == 0) return(rep(NA_real_, nrow(mat)))
  rowMeans(as.matrix(mat), na.rm = TRUE)}

h6_load_matched_route <- function() {
  if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
  input_data <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
  input_data <- h6_pair_mean_columns(input_data)
  input_data$ParticipantID <- as.character(input_data$ParticipantID)
  input_data$PhaseID <- as.character(input_data$PhaseID)
  route <- input_data[input_data$ParticipantID %in% PARTICIPANTS & input_data$PhaseID %in% CORE_PHASES, ]
  route$Datetime <- as.POSIXct(route$Datetime, tz = "UTC")
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]
  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
    FUN = function(x) x - min(x, na.rm = TRUE))
  durations <- aggregate(time_in_phase_sec ~ ParticipantID + PhaseID, route, max, na.rm = TRUE)
  phase_durations_wide <- reshape(durations, idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
  names(phase_durations_wide) <- sub("time_in_phase_sec\\.", "", names(phase_durations_wide))
  for (nm in CORE_PHASES) if (!nm %in% names(phase_durations_wide)) phase_durations_wide[[nm]] <- NA_real_
  phase_durations_wide$Common_cap <- pmin(
    phase_durations_wide$BikeU, phase_durations_wide$BikeG,
    phase_durations_wide$WalkU, phase_durations_wide$WalkG,
    MATCHED_CAP_SEC, na.rm = FALSE)
  route <- merge(route, phase_durations_wide[c("ParticipantID", "Common_cap")], by = "ParticipantID", all.x = TRUE, sort = FALSE)
  route <- route[!is.na(route$Common_cap) & route$time_in_phase_sec <= route$Common_cap, ]
  route$ParticipantID <- factor(route$ParticipantID, levels = PARTICIPANTS)
  route$PhaseID <- factor(route$PhaseID, levels = CORE_PHASES)
  route$time_10s_step <- round(route$time_in_phase_sec / 10)
  route}

h6_build_analysis_frame <- function(route) {
  tf <- get0("PAPER3_APPLY_CSV_TRANSFORM", envir = .GlobalEnv, ifnotfound = NULL)
  physio_cols <- H6_SPEC$physio_outcomes
  transform_physio <- H6_SPEC$physiological_outcome_names %||% physio_cols
  eye_const <- H6_SPEC$transparent_eye_constituents
  env_single <- H6_SPEC$env_index_constituents
  psych_cols <- H6_SPEC$psych_outcomes
  morph <- H6_SPEC$restorative_constituents

  need_raw <- unique(c(
    unlist(lapply(env_single, `[[`, "column")),
    morph, physio_cols, names(eye_const), psych_cols))
  need_raw <- intersect(need_raw, names(route))

  if (GRAIN == "phaseavg") {
    base <- aggregate(route[need_raw], by = route[c("ParticipantID", "PhaseID")], FUN = mean_na)
  } else {
    base <- route[c("ParticipantID", "PhaseID", "time_10s_step", need_raw)]}
  pid <- base$ParticipantID

  # Prespecified environmental load indices (WPZ, stress-oriented).
  for (nm in names(env_single)) {
    spec <- env_single[[nm]]
    base[[paste0("idx_", nm)]] <- h6_oriented_wpz(base[[spec$column]], pid, spec$stress_direction)}
  morph_wpz <- list()
  for (col in morph) {
    dir <- H6_SPEC$morphology_stress_direction[[col]]
    morph_wpz[[col]] <- h6_oriented_wpz(base[[col]], pid, dir)}
  base$idx_restorative_stress <- h6_composite_rowmean(as.data.frame(morph_wpz))

  # Physio outcomes (transform then WPZ).
  for (col in physio_cols) {
    x <- base[[col]]
    if (is.function(tf)) x <- tf(x, col)
    base[[paste0("out_", col)]] <- h6_wpz(x, pid)}

  # Transparent ocular stress index.
  eye_mat <- list()
  for (cn in names(eye_const)) {
    if (!cn %in% names(base)) next
    x <- base[[cn]]
    if (cn %in% transform_physio && is.function(tf)) x <- tf(x, cn)
    eye_mat[[cn]] <- as.numeric(eye_const[[cn]]) * h6_wpz(x, pid)}
  base$out_transparent_ocular <- h6_composite_rowmean(as.data.frame(eye_mat))

  for (col in psych_cols) {
    if (!col %in% names(base)) next
    base[[paste0("psy_", col)]] <- h6_wpz(base[[col]], pid)}

  base}

h6_fit_lmm_row <- function(dat, y_col, fixed_rhs, timeseries = FALSE) {
  req <- unique(c(y_col, unlist(strsplit(fixed_rhs, " + ", fixed = TRUE)), "ParticipantID", "PhaseID"))
  if (timeseries) req <- c(req, "time_10s_step")
  req <- intersect(req, names(dat))
  analysis_data <- dat[complete.cases(dat[req]), req, drop = FALSE]
  n_obs <- nrow(analysis_data)
  n_pid <- length(unique(analysis_data$ParticipantID))
  min_rows <- if (timeseries) 120L else 20L
  if (n_obs < min_rows || n_pid < 8L) {
    return(list(status = "NOT_FIT_INSUFFICIENT_DATA", n_obs = n_obs, n_pid = n_pid))}
  if (!is.finite(sd(analysis_data[[y_col]], na.rm = TRUE)) || sd(analysis_data[[y_col]], na.rm = TRUE) == 0) {
    return(list(status = "NOT_FIT_ZERO_VARIANCE", n_obs = n_obs, n_pid = n_pid))}
  form <- as.formula(paste(y_col, "~", fixed_rhs))
  analysis_data$ParticipantID <- factor(analysis_data$ParticipantID)
  analysis_data$PhaseID <- factor(analysis_data$PhaseID, levels = CORE_PHASES)
  fit <- tryCatch({
    if (timeseries) {
      analysis_data <- analysis_data[order(analysis_data$ParticipantID, analysis_data$PhaseID, analysis_data$time_10s_step), ]
      ar1_form <- nlme::corAR1(form = ~time_10s_step | ParticipantID / PhaseID)
      fit_ts <- function(cor, opt, primary = FALSE) {
        ctrl <- if (primary) {
          nlme::lmeControl(opt = opt, maxIter = 300, msMaxIter = 300, returnObject = TRUE)
        } else {
          nlme::lmeControl(opt = opt, maxIter = 150, msMaxIter = 200, returnObject = TRUE)}
        tryCatch(
          nlme::lme(form, data = analysis_data, random = ~1 | ParticipantID, correlation = cor,
            method = "REML", control = ctrl),
          error = function(local_error) NULL)}
      out <- fit_ts(ar1_form, "optim", TRUE)
      if (is.null(out)) out <- fit_ts(nlme::corAR1(0.2, form = ~time_10s_step | ParticipantID / PhaseID), "nlminb", FALSE)
      if (is.null(out)) out <- fit_ts(nlme::corAR1(0.2, form = ~time_10s_step | ParticipantID / PhaseID), "optim", FALSE)
      if (is.null(out)) {
        out <- tryCatch(
          nlme::lme(form, data = analysis_data, random = ~1 | ParticipantID / PhaseID, method = "REML",
            control = nlme::lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = TRUE)),
          error = function(local_error) NULL)}
      out
    } else {
      nlme::lme(
        form, data = analysis_data, random = ~1 | ParticipantID, method = "REML",
        control = nlme::lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = TRUE))}
  }, error = function(local_error) NULL)
  if (is.null(fit)) return(list(status = "FAILED_CONVERGENCE", n_obs = n_obs, n_pid = n_pid))
  tt <- summary(fit)$tTable
  list(status = "FIT", n_obs = n_obs, n_pid = n_pid, fit = fit, tTable = tt)}

h6_extract_term <- function(fit_obj, term) {
  if (is.null(fit_obj$fit) || !term %in% rownames(fit_obj$tTable)) {
    return(list(
      estimate = NA_real_, std_error = NA_real_, df = NA_real_,
      statistic = NA_real_, p_value = NA_real_))}
  cf <- fit_obj$tTable[term, , drop = FALSE]
  list(
    estimate = cf[1, "Value"],
    std_error = cf[1, "Std.Error"],
    df = cf[1, "DF"],
    statistic = cf[1, "t-value"],
    p_value = cf[1, "p-value"])}

h6_apply_fdr <- function(tbl, family_col = "analysis_family") {
  if (!nrow(tbl)) return(tbl)
  tbl$q_FDR <- NA_real_
  for (fam in unique(tbl[[family_col]])) {
    index <- which(tbl[[family_col]] == fam & tbl$fit_status == "FIT" & is.finite(tbl$p_value))
    if (length(index)) tbl$q_FDR[index] <- p.adjust(tbl$p_value[index], method = "BH")}
  tbl$FDR_significant <- !is.na(tbl$q_FDR) & tbl$q_FDR < H6_SPEC$fdr_alpha
  tbl}

h6_purge_stale_outputs <- function() {
  if (!dir.exists(OUT_DIR)) return(invisible(NULL))
  keep <- c(
    paste0(FILE_PREFIX, "_coupling_env_physio.csv"),
    paste0(FILE_PREFIX, "_coupling_psych_physio.csv"),
    paste0(FILE_PREFIX, "_prespecified_grid.csv"),
    paste0(FILE_PREFIX, "_run_manifest.csv"),
    paste0(FILE_PREFIX, "_run_info.csv"),
    paste0(basename(OUT_DIR), "_run_info.csv"))
  stale_pat <- paste0(
    "^(H6_coupling_|H6_pairwise_rmcorr|H6_composite_definitions|",
    "H6_participant_phase_composites|H6_epoch_composites|H6_run_manifest)[.]csv$")
  for (path in list.files(OUT_DIR, full.names = TRUE)) {
    bn <- basename(path)
    if (bn %in% keep) next
    if (grepl("\\.csv$", bn, ignore.case = TRUE) &&
        (grepl(stale_pat, bn, ignore.case = TRUE) || !grepl(paste0("^", FILE_PREFIX, "_"), bn))) {
      unlink(path)}
  }
  invisible(NULL)}

h6_coupling_run <- function() {
  cat(sprintf("[H6 coupling / %s] Loading matched 8-min data...\n", GRAIN))
  h6_purge_stale_outputs()
  route <- h6_load_matched_route()
  dat <- h6_build_analysis_frame(route)

  env_idx <- H6_SPEC$env_index_names
  phys_y_cols <- c(
    stats::setNames(paste0("out_", H6_SPEC$physio_outcomes), H6_SPEC$physio_outcomes),
    transparent_ocular = "out_transparent_ocular")

  rows_a <- list()
  for (y_id in names(phys_y_cols)) {
    y_col <- phys_y_cols[[y_id]]
    for (x_id in env_idx) {
      x_col <- paste0("idx_", x_id)
      rhs <- paste(x_col, "PhaseID", sep = " + ")
      fit <- h6_fit_lmm_row(dat, y_col, rhs, timeseries = GRAIN == "timeseries")
      ex <- h6_extract_term(fit, x_col)
      rows_a[[length(rows_a) + 1L]] <- data.frame(
        hypothesis = "H6",
        analysis_family = "H6_A_env_physio",
        analysis_grain = GRAIN,
        outcome = y_id,
        term = x_id,
        env_index = x_id,
        psych_construct = NA_character_,
        fit_status = fit$status,
        model_formula = sprintf(
          "lme(%s ~ %s + PhaseID, random = ~1 | ParticipantID%s)",
          y_col, x_col,
          if (GRAIN == "timeseries") ", corAR1(~ time_10s_step | ParticipantID/PhaseID)" else ""
        ),
        n_observations = fit$n_obs %||% NA_integer_,
        n_participants = fit$n_pid %||% NA_integer_,
        estimate = ex$estimate,
        std_error = ex$std_error,
        df = ex$df,
        statistic = ex$statistic,
        p_value = ex$p_value,
        stringsAsFactors = FALSE)}
  }
  tbl_a <- h6_apply_fdr(do.call(rbind, rows_a))

  rows_b <- list()
  for (y_id in names(phys_y_cols)) {
    y_col <- phys_y_cols[[y_id]]
    for (p_col in H6_SPEC$psych_outcomes) {
      psy_col <- paste0("psy_", p_col)
      rhs <- paste(psy_col, "idx_thermal_load", "idx_acoustic_load", "PhaseID", sep = " + ")
      fit <- h6_fit_lmm_row(dat, y_col, rhs, timeseries = GRAIN == "timeseries")
      ex <- h6_extract_term(fit, psy_col)
      rows_b[[length(rows_b) + 1L]] <- data.frame(
        hypothesis = "H6",
        analysis_family = "H6_B_psych_physio_given_env",
        analysis_grain = GRAIN,
        outcome = y_id,
        term = p_col,
        env_index = NA_character_,
        psych_construct = p_col,
        fit_status = fit$status,
        model_formula = sprintf(
          "lme(%s ~ %s + idx_thermal_load + idx_acoustic_load + PhaseID, random = ~1 | ParticipantID%s)",
          y_col, psy_col,
          if (GRAIN == "timeseries") ", corAR1(~ time_10s_step | ParticipantID/PhaseID)" else ""
        ),
        n_observations = fit$n_obs %||% NA_integer_,
        n_participants = fit$n_pid %||% NA_integer_,
        estimate = ex$estimate,
        std_error = ex$std_error,
        df = ex$df,
        statistic = ex$statistic,
        p_value = ex$p_value,
        stringsAsFactors = FALSE)}
  }
  tbl_b <- h6_apply_fdr(do.call(rbind, rows_b))

  grid <- rbind(
    tbl_a[, c("analysis_family", "outcome", "term")],
    tbl_b[, c("analysis_family", "outcome", "term")])
  names(grid)[3] <- "predictor"
  safe_write_csv(grid, file.path(OUT_DIR, paste0(FILE_PREFIX, "_prespecified_grid.csv")))
  safe_write_csv(tbl_a, file.path(OUT_DIR, paste0(FILE_PREFIX, "_coupling_env_physio.csv")))
  safe_write_csv(tbl_b, file.path(OUT_DIR, paste0(FILE_PREFIX, "_coupling_psych_physio.csv")))

  manifest <- data.frame(
    Metric = c(
      "analysis_grain", "entry_script", "n_env_physio_tests", "n_psych_physio_tests",
      "H6_A_FDR_significant", "H6_B_FDR_significant"
    ),
    Value = c(
      GRAIN, ENTRY_SCRIPT,
      nrow(tbl_a), nrow(tbl_b),
      sum(tbl_a$FDR_significant %in% TRUE, na.rm = TRUE),
      sum(tbl_b$FDR_significant %in% TRUE, na.rm = TRUE)
    ),
    stringsAsFactors = FALSE)
  safe_write_csv(manifest, file.path(OUT_DIR, paste0(FILE_PREFIX, "_run_manifest.csv")))

  cat(sprintf(
    "[H6 coupling / %s] Done. H6-A: %d/%d FDR q<%.2f; H6-B: %d/%d FDR q<%.2f.\nOutputs: %s\n",
    GRAIN,
    sum(tbl_a$FDR_significant %in% TRUE, na.rm = TRUE), sum(tbl_a$fit_status == "FIT"),
    H6_SPEC$fdr_alpha,
    sum(tbl_b$FDR_significant %in% TRUE, na.rm = TRUE), sum(tbl_b$fit_status == "FIT"),
    H6_SPEC$fdr_alpha,
    OUT_DIR))
  invisible(list(env_physio = tbl_a, psych_physio = tbl_b))}

`%||%` <- function(first_values, second_values) if (!is.null(first_values)) first_values else second_values

# H5 engine: prespecified within-person coupling LMMs (phase means or 10 s epochs); sourced by the H5_stress_composite_* scripts.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H5_coupling_core.R.", call. = FALSE)}

# Prespecified H5 design; grain is "phaseavg" (phase means) or "timeseries" (10 s epochs).
h5_stress_composite_spec <- function(grain) {
  prefix <- paste0("H5_stress_composite_", grain)
  spec <- list(
    analysis_grain = grain,
    results_subdir = prefix,
    entry_script = paste0(prefix, ".R"),
    file_prefix = prefix,
    participants = PAPER3_PARTICIPANTS,
    phases = PAPER3_CORE_PHASES,
    matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
    physiological_outcome_names = paper3_physiological_outcomes(),
    physio_outcomes = c("empatica_eda_tonic", "empatica_hrv_td_rmssd"),
    env_index_names = c("thermal_load", "acoustic_load", "restorative_stress"),
    env_index_constituents = list(
      thermal_load = list(column = "ucm_UTCI", stress_direction = 1L),
      acoustic_load = list(column = "ucm_SND_dBA", stress_direction = 1L)),
    restorative_constituents = c("SVF", "TVF", "gvi_50m"),
    morphology_stress_direction = c(SVF = -1L, TVF = -1L, gvi_50m = -1L),
    transparent_eye_constituents = list(
      eyetracker_fixation_rate = 1L,
      eyetracker_fixation_duration_s = -1L,
      eyetracker_pupil_diameter_avg = 1L,
      eyetracker_blink_duration_s = 1L),
    # Psychological constructs (incl. STAI "tense" and acoustic comfort); the run stops if a column is missing.
    psych_outcomes = c(
      "questionnaire_prs11_fascination_mean_1_5",
      "questionnaire_stai_tense_1_5",
      "questionnaire_acoustic_comfort_1_5"),
    fdr_alpha = 0.05)
  paper3_attach_outcome_normalization(spec, PROJECT_ROOT)}

# Run globals read by the functions below.
h5_stress_composite_setup <- function(grain) {
  spec <- h5_stress_composite_spec(grain)
  results_root <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results")
  list2env(list(
    H5_SPEC = spec,
    OUTCOME_TRANSFORMS_CSV = spec$outcome_transforms_csv,
    RESULTS_ROOT = results_root,
    OUT_DIR = file.path(results_root, spec$results_subdir),
    PARTICIPANTS = spec$participants,
    CORE_PHASES = spec$phases,
    MATCHED_CAP_SEC = spec$matched_cap_sec,
    RAW_PATH = paper3_merged_8min_path(PROJECT_ROOT),
    GRAIN = spec$analysis_grain,
    ENTRY_SCRIPT = spec$entry_script,
    FILE_PREFIX = spec$file_prefix), envir = .GlobalEnv)
  dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)}

# Entry point of both H5 scripts: fits and writes the coupling tables for one grain.
h5_stress_composite_run <- function(grain) {
  h5_stress_composite_setup(grain)
  if (grain == "phaseavg") cat("Running H5 prespecified coupling LMMs (phase means)...\n")
  else cat("Running H5 prespecified coupling LMMs (10 s epochs, AR(1))...\n")
  h5_coupling_run()}

safe_write_csv <- function(data, path) {
  tryCatch(write.csv(data, path, row.names = FALSE, na = ""), error = function(local_error) {
    warning("Could not write ", path, ": ", conditionMessage(local_error))
  })}

h5_wpz <- function(x, pid) {
  fn <- get0("PAPER3_OUTCOME_WITHIN_PERSON_Z", envir = .GlobalEnv, ifnotfound = paper3_within_person_z)
  fn(x, pid)}

h5_oriented_wpz <- function(x, pid, stress_direction, transform_fn = NULL, col = NULL) {
  if (is.function(transform_fn) && !is.null(col)) x <- transform_fn(x, col)
  as.numeric(stress_direction) * h5_wpz(x, pid)}

h5_composite_rowmean <- function(mat) {
  if (is.null(mat) || ncol(mat) == 0) return(rep(NA_real_, nrow(mat)))
  rowMeans(as.matrix(mat), na.rm = TRUE)}

h5_load_matched_route <- function() {
  if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
  input_data <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
  input_data <- paper3_add_pair_means(input_data, list(
    atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
    atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
    lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin")))
  input_data$ParticipantID <- as.character(input_data$ParticipantID)
  input_data$PhaseID <- as.character(input_data$PhaseID)
  route <- input_data[input_data$ParticipantID %in% PARTICIPANTS & input_data$PhaseID %in% CORE_PHASES, ]
  route$Datetime <- as.POSIXct(route$Datetime, tz = "UTC")
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]
  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
    FUN = function(x) x - min(x, na.rm = TRUE))
  route <- paper3_merge_common_cap(route, CORE_PHASES, MATCHED_CAP_SEC)
  route <- route[!is.na(route$Common_cap) & route$time_in_phase_sec <= route$Common_cap, ]
  route$ParticipantID <- factor(route$ParticipantID, levels = PARTICIPANTS)
  route$PhaseID <- factor(route$PhaseID, levels = CORE_PHASES)
  route$time_10s_step <- round(route$time_in_phase_sec / 10)
  route}

h5_build_analysis_frame <- function(route) {
  tf <- get0("PAPER3_APPLY_CSV_TRANSFORM", envir = .GlobalEnv, ifnotfound = NULL)
  physio_cols <- H5_SPEC$physio_outcomes
  transform_physio <- H5_SPEC$physiological_outcome_names %||% physio_cols
  eye_const <- H5_SPEC$transparent_eye_constituents
  env_single <- H5_SPEC$env_index_constituents
  psych_cols <- H5_SPEC$psych_outcomes
  morph <- H5_SPEC$restorative_constituents

  need_raw <- unique(c(
    unlist(lapply(env_single, `[[`, "column")),
    morph, physio_cols, names(eye_const), psych_cols))
  missing_raw <- setdiff(need_raw, names(route))
  if (length(missing_raw)) {
    stop("H5 coupling: H5_SPEC column(s) not in the merged input: ", paste(missing_raw, collapse = ", "), call. = FALSE)}

  # Transform the 10 s rows before phase averaging, so phase means are means of transformed values.
  transform_cols <- unique(c(physio_cols, intersect(names(eye_const), transform_physio)))
  if (is.function(tf)) for (col in transform_cols) route[[col]] <- tf(route[[col]], col)

  if (GRAIN == "phaseavg") {
    base <- aggregate(route[need_raw], by = route[c("ParticipantID", "PhaseID")], FUN = mean_na)
  } else {
    base <- route[c("ParticipantID", "PhaseID", "time_10s_step", need_raw)]}
  pid <- base$ParticipantID

  # Prespecified environmental load indices (WPZ, stress-oriented).
  for (nm in names(env_single)) {
    spec <- env_single[[nm]]
    base[[paste0("idx_", nm)]] <- h5_oriented_wpz(base[[spec$column]], pid, spec$stress_direction)}
  morph_wpz <- list()
  for (col in morph) {
    dir <- H5_SPEC$morphology_stress_direction[[col]]
    morph_wpz[[col]] <- h5_oriented_wpz(base[[col]], pid, dir)}
  base$idx_restorative_stress <- h5_composite_rowmean(as.data.frame(morph_wpz))

  # Physio outcomes (already transformed on 10 s rows above; WPZ here).
  for (col in physio_cols) {
    base[[paste0("out_", col)]] <- h5_wpz(base[[col]], pid)}

  # Transparent ocular stress index.
  eye_mat <- list()
  for (cn in names(eye_const)) {
    eye_mat[[cn]] <- as.numeric(eye_const[[cn]]) * h5_wpz(base[[cn]], pid)}
  base$out_transparent_ocular <- h5_composite_rowmean(as.data.frame(eye_mat))

  for (col in psych_cols) {
    base[[paste0("psy_", col)]] <- h5_wpz(base[[col]], pid)}

  base}

h5_fit_lmm_row <- function(dat, y_col, fixed_rhs, timeseries = FALSE) {
  req <- unique(c(y_col, unlist(strsplit(fixed_rhs, " + ", fixed = TRUE)), "ParticipantID", "PhaseID"))
  if (timeseries) req <- c(req, "time_10s_step")
  missing_vars <- setdiff(req, names(dat))
  if (length(missing_vars)) {
    stop("H5 coupling: model variable(s) missing from the analysis frame: ", paste(missing_vars, collapse = ", "),
      " (", y_col, " ~ ", fixed_rhs, ")", call. = FALSE)}
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
  # returnObject = FALSE: a fit that does not converge errors and is never reported as FIT.
  structure <- NA_character_
  fit <- tryCatch({
    if (timeseries) {
      analysis_data <- analysis_data[order(analysis_data$ParticipantID, analysis_data$PhaseID, analysis_data$time_10s_step), ]
      ar1_form <- nlme::corAR1(form = ~time_10s_step | ParticipantID / PhaseID)
      fit_ts <- function(cor, opt, primary = FALSE) {
        ctrl <- if (primary) {
          nlme::lmeControl(opt = opt, maxIter = 300, msMaxIter = 300, returnObject = FALSE)
        } else {
          nlme::lmeControl(opt = opt, maxIter = 150, msMaxIter = 200, returnObject = FALSE)}
        tryCatch(
          nlme::lme(form, data = analysis_data, random = ~1 | ParticipantID, correlation = cor,
            method = "REML", control = ctrl),
          error = function(local_error) NULL)}
      out <- fit_ts(ar1_form, "optim", TRUE)
      if (is.null(out)) out <- fit_ts(nlme::corAR1(0.2, form = ~time_10s_step | ParticipantID / PhaseID), "nlminb", FALSE)
      if (is.null(out)) out <- fit_ts(nlme::corAR1(0.2, form = ~time_10s_step | ParticipantID / PhaseID), "optim", FALSE)
      if (!is.null(out)) structure <- "AR1"
      if (is.null(out)) {
        out <- tryCatch(
          nlme::lme(form, data = analysis_data, random = ~1 | ParticipantID / PhaseID, method = "REML",
            control = nlme::lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = FALSE)),
          error = function(local_error) NULL)
        if (!is.null(out)) structure <- "NESTED_RE_NO_AR1_FALLBACK"}
      out
    } else {
      structure <- "INDEPENDENT_PHASE_MEANS"
      nlme::lme(
        form, data = analysis_data, random = ~1 | ParticipantID, method = "REML",
        control = nlme::lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = FALSE))}
  }, error = function(local_error) NULL)
  if (is.null(fit)) return(list(status = "FAILED_CONVERGENCE", n_obs = n_obs, n_pid = n_pid))
  tt <- summary(fit)$tTable
  rho <- if (!is.null(fit$modelStruct$corStruct)) {
    as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE))[1L]} else NA_real_
  list(status = "FIT", n_obs = n_obs, n_pid = n_pid, fit = fit, tTable = tt,
    residual_structure = structure, ar1_rho = rho)}

# Formula string of the model that was actually fitted (planned formula when not fitted).
h5_model_formula <- function(y_col, rhs_text, fit_obj) {
  structure <- fit_obj$residual_structure %||% NA_character_
  re_txt <- if (identical(structure, "NESTED_RE_NO_AR1_FALLBACK")) {
    "random = ~1 | ParticipantID/PhaseID; no AR1 (all AR1 fits failed)"
  } else if (identical(structure, "AR1") || (is.na(structure) && GRAIN == "timeseries")) {
    "random = ~1 | ParticipantID, correlation = corAR1(~ time_10s_step | ParticipantID/PhaseID)"
  } else {
    "random = ~1 | ParticipantID"}
  sprintf("lme(%s ~ %s, %s)", y_col, rhs_text, re_txt)}

h5_extract_term <- function(fit_obj, term) {
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

h5_apply_fdr <- function(tbl, family_col = "analysis_family") {
  if (!nrow(tbl)) return(tbl)
  tbl$q_FDR <- NA_real_
  for (fam in unique(tbl[[family_col]])) {
    index <- which(tbl[[family_col]] == fam & tbl$fit_status == "FIT" & is.finite(tbl$p_value))
    if (length(index)) tbl$q_FDR[index] <- p.adjust(tbl$p_value[index], method = "BH")}
  tbl$FDR_significant <- !is.na(tbl$q_FDR) & tbl$q_FDR < H5_SPEC$fdr_alpha
  tbl$fdr_note <- ifelse(is.na(tbl$q_FDR),
    paste0("No q: not in BH family because the model was not fitted (fit_status=", tbl$fit_status, ")"), "")
  tbl}

h5_purge_stale_outputs <- function() {
  if (!dir.exists(OUT_DIR)) return(invisible(NULL))
  keep <- c(
    paste0(FILE_PREFIX, "_coupling_env_physio.csv"),
    paste0(FILE_PREFIX, "_coupling_psych_physio.csv"),
    paste0(FILE_PREFIX, "_prespecified_grid.csv"),
    paste0(FILE_PREFIX, "_run_manifest.csv"),
    paste0(FILE_PREFIX, "_run_info.csv"),
    paste0(basename(OUT_DIR), "_run_info.csv"))
  stale_pat <- paste0(
    "^(H5_coupling_|H5_pairwise_rmcorr|H5_composite_definitions|",
    "H5_participant_phase_composites|H5_epoch_composites|H5_run_manifest)[.]csv$")
  for (path in list.files(OUT_DIR, full.names = TRUE)) {
    bn <- basename(path)
    if (bn %in% keep) next
    if (grepl("\\.csv$", bn, ignore.case = TRUE) &&
        (grepl(stale_pat, bn, ignore.case = TRUE) || !grepl(paste0("^", FILE_PREFIX, "_"), bn))) {
      unlink(path)}
  }
  invisible(NULL)}

h5_coupling_run <- function() {
  cat(sprintf("[H5 coupling / %s] Loading matched 8-min data...\n", GRAIN))
  h5_purge_stale_outputs()
  route <- h5_load_matched_route()
  dat <- h5_build_analysis_frame(route)

  env_idx <- H5_SPEC$env_index_names
  phys_y_cols <- c(
    stats::setNames(paste0("out_", H5_SPEC$physio_outcomes), H5_SPEC$physio_outcomes),
    transparent_ocular = "out_transparent_ocular")

  rows_a <- list()
  for (y_id in names(phys_y_cols)) {
    y_col <- phys_y_cols[[y_id]]
    for (x_id in env_idx) {
      x_col <- paste0("idx_", x_id)
      rhs <- paste(x_col, "PhaseID", sep = " + ")
      fit <- h5_fit_lmm_row(dat, y_col, rhs, timeseries = GRAIN == "timeseries")
      ex <- h5_extract_term(fit, x_col)
      rows_a[[length(rows_a) + 1L]] <- data.frame(
        hypothesis = "H5",
        analysis_family = "H5_A_env_physio",
        analysis_grain = GRAIN,
        outcome = y_id,
        term = x_id,
        env_index = x_id,
        psych_construct = NA_character_,
        fit_status = fit$status,
        residual_structure = fit$residual_structure %||% NA_character_,
        ar1_rho = fit$ar1_rho %||% NA_real_,
        model_formula = h5_model_formula(y_col, rhs, fit),
        n_observations = fit$n_obs %||% NA_integer_,
        n_participants = fit$n_pid %||% NA_integer_,
        estimate = ex$estimate,
        std_error = ex$std_error,
        df = ex$df,
        statistic = ex$statistic,
        p_value = ex$p_value,
        stringsAsFactors = FALSE)}
  }
  tbl_a <- h5_apply_fdr(do.call(rbind, rows_a))

  rows_b <- list()
  for (y_id in names(phys_y_cols)) {
    y_col <- phys_y_cols[[y_id]]
    for (p_col in H5_SPEC$psych_outcomes) {
      psy_col <- paste0("psy_", p_col)
      rhs <- paste(psy_col, "idx_thermal_load", "idx_acoustic_load", "PhaseID", sep = " + ")
      fit <- h5_fit_lmm_row(dat, y_col, rhs, timeseries = GRAIN == "timeseries")
      ex <- h5_extract_term(fit, psy_col)
      rows_b[[length(rows_b) + 1L]] <- data.frame(
        hypothesis = "H5",
        analysis_family = "H5_B_psych_physio_given_env",
        analysis_grain = GRAIN,
        outcome = y_id,
        term = p_col,
        env_index = NA_character_,
        psych_construct = p_col,
        fit_status = fit$status,
        residual_structure = fit$residual_structure %||% NA_character_,
        ar1_rho = fit$ar1_rho %||% NA_real_,
        model_formula = h5_model_formula(y_col, rhs, fit),
        n_observations = fit$n_obs %||% NA_integer_,
        n_participants = fit$n_pid %||% NA_integer_,
        estimate = ex$estimate,
        std_error = ex$std_error,
        df = ex$df,
        statistic = ex$statistic,
        p_value = ex$p_value,
        stringsAsFactors = FALSE)}
  }
  tbl_b <- h5_apply_fdr(do.call(rbind, rows_b))

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
      "H5_A_FDR_significant", "H5_B_FDR_significant"),
    Value = c(
      GRAIN, ENTRY_SCRIPT,
      nrow(tbl_a), nrow(tbl_b),
      sum(tbl_a$FDR_significant %in% TRUE, na.rm = TRUE),
      sum(tbl_b$FDR_significant %in% TRUE, na.rm = TRUE)),
    stringsAsFactors = FALSE)
  safe_write_csv(manifest, file.path(OUT_DIR, paste0(FILE_PREFIX, "_run_manifest.csv")))

  cat(sprintf(
    "[H5 coupling / %s] Done. H5-A: %d/%d FDR q<%.2f; H5-B: %d/%d FDR q<%.2f.\nOutputs: %s\n",
    GRAIN,
    sum(tbl_a$FDR_significant %in% TRUE, na.rm = TRUE), sum(tbl_a$fit_status == "FIT"),
    H5_SPEC$fdr_alpha,
    sum(tbl_b$FDR_significant %in% TRUE, na.rm = TRUE), sum(tbl_b$fit_status == "FIT"),
    H5_SPEC$fdr_alpha,
    OUT_DIR))
  invisible(list(env_physio = tbl_a, psych_physio = tbl_b))}

`%||%` <- function(x, y) if (!is.null(x)) x else y

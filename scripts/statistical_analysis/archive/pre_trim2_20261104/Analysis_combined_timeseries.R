# H4 time-series LME models (Eq1-7) plus two exploratory blocks (lagged differences, sound-source adjusted); engine in library/Analysis_combined_core.R.
# Output: results/Analysis_combined_timeseries/ (the exploratory blocks run only with --supplementary-only).
source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(required_packages = c("car", "nlme", "clubSandwich"))
PROJECT_ROOT <- resolve_project_root()
# Step 5: serial fits; optional batches via H4_JOB_START / H4_JOB_END or H4_MAX_JOBS (26 outcomes x 7 equations = 182 jobs).
H4_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/Analysis_combined_timeseries.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))

# Cohort, phases and the 26 physiological outcomes; the equation table and term checks are in the core.
h4_study_spec <- paper3_h4_study_spec(PROJECT_ROOT)
OUTCOME_TRANSFORMS_CSV <- h4_study_spec$outcome_transforms_csv

# Eq1 is the main model; Eq2-7 swap the heat or PM term. Y is not centered, *_bout_z predictors are.

# Eq1 primary: UTCI + sound (additive), random intercept per person and phase, AR(1) within the bout.
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI_bout_z + ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail))

# Eq2: air temperature, humidity and wind + sound (additive, no MRT)
Eq2 <- quote(nlme::lme(
  Y ~ ucm_AIR_T_mid_bout_z + ucm_SND_dBA_bout_z + ucm_AIR_RH_bout_z + ucm_WIND_AWS_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail))

# Eq3: MRT + sound + PM2.5 + light + route phase contrasts (additive; no interactions)
Eq3 <- quote(nlme::lme(
  Y ~ ucm_MRT_bout_z + ucm_SND_dBA_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail))

# Eq4: HUMIDEX + sound (additive effects)
Eq4 <- quote(nlme::lme(
  Y ~ ucm_HUMIDEX_bout_z + ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail))

# Eq5: PET + sound (additive effects)
Eq5 <- quote(nlme::lme(
  Y ~ ucm_PET_bout_z + ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail))

# Eq6: Eq1 with PM1
Eq6 <- quote(nlme::lme(
  Y ~ ucm_UTCI_bout_z + ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm1_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail))

# Eq7: Eq1 with PM10
Eq7 <- quote(nlme::lme(
  Y ~ ucm_UTCI_bout_z + ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm10_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail))

h4_bout_fitters <- function() {
  templates <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7)
  model_template <- templates[[1L]]
  for (eq_id in 2:7) {
    other_template <- templates[[eq_id]]
    stopifnot(identical(model_template$random, other_template$random),
              identical(model_template$correlation, other_template$correlation),
              identical(model_template$method, other_template$method),
              identical(model_template$na.action, other_template$na.action))}
  nested <- eval(model_template$random)
  ar1 <- function() eval(model_template$correlation)
  # Refit with ARMA(2,0) per bout when AR(1) rho > 0.95, otherwise keep AR(1).
  arma2 <- function() nlme::corARMA(c(0.5, 0.2), form = ~ Time10 | ParticipantID / PhaseID, p = 2, q = 0)
  # REML fit trying each optimizer in turn; warnings and errors are logged.
  fit_lme <- function(fml, fd, random, correlation, log, opts = c("nlminb", "optim")) {
    for (opt in opts) {
      fit <- tryCatch(withCallingHandlers(
        nlme::lme(
          fixed = fml,
          data = fd,
          random = random,
          correlation = correlation,
          method = eval(model_template$method),
          na.action = eval(model_template$na.action),
          control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = opt)),
        warning = function(warning_condition) log(opt, "warning", conditionMessage(warning_condition))),
        error = function(local_error) { log(opt, "error", conditionMessage(local_error)); NULL })
      if (!is.null(fit)) return(fit)}
    NULL}
  # Try both AR1 optimizers before the independent-residual fallback.
  do_fit_with_fallback <- function(fml, fd) {
    messages <- character()
    logger <- function(label) function(opt, kind, msg) messages <<- c(messages, sprintf("%s %s: %s", if (is.null(label)) opt else label, kind, msg))
    fit <- fit_lme(fml, fd, nested, ar1(), logger(NULL))
    structure <- "AR1"
    corfun <- ar1
    if (!is.null(fit)) {
      rho <- tryCatch(unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(local_error) NA_real_)
      if (length(rho) == 1L && is.finite(rho) && rho > 0.95) {
        fit2 <- fit_lme(fml, fd, nested, arma2(), logger("ARMA(2,0)"))
        if (is.null(fit2)) messages <- c(messages, sprintf("AR(1) rho = %.4f > 0.95 but ARMA(2,0) failed; AR(1) kept", rho)) else {
          fit <- fit2; structure <- "ARMA20"; corfun <- arma2
          messages <- c(messages, sprintf("ARMA(2,0) used: AR(1) rho = %.4f > 0.95", rho))}
      }
    }
    if (is.null(fit)) {
      fit <- fit_lme(fml, fd, nested, NULL, logger("uncorrelated"), opts = "nlminb")
      structure <- "independent_fallback"
      corfun <- function() NULL
      if (!is.null(fit)) messages <- c(messages, "Fallback: AR(1) failed; fitted independent residual covariance (sensitivity-only fit)")}
    list(fit = fit, note = paste(messages, collapse = "; "), residual_structure = if (is.null(fit)) "not_fitted" else structure, corfun = corfun)}

  list(nested = nested, fit_lme = fit_lme, do_fit_with_fallback = do_fit_with_fallback)}

# Whole-bout centering happens before outcome filtering; scaling is not redone on filtered rows.
h4_fit <- function(raw_df = NULL, prep = NULL) {
  setup <- h4_fit_begin(raw_df)
  raw_df <- setup$raw_df
  h4_model_dir <- setup$h4_model_dir
  fingerprints <- setup$fingerprints
  if (is.null(prep)) prep <- h4_step4_exposure_prep(raw_df)
  # Local bindings from the Step 4 preparation.
  raw_df <- prep$raw_df
  thermal <- prep$thermal
  selected <- prep$selected
  centered <- prep$centered
  centered_lag60 <- prep$centered_lag60
  make_design <- prep$make_design
  catalog <- prep$catalog
  stopifnot(nrow(catalog) == 7L, identical(catalog$equation_id, 1:7))

  outcomes <- h4_study_spec$all_physiological_outcomes
  natural_log_outcomes <- h4_study_spec$natural_log_outcome_names
  gvif_diag <- h4_run_gvif_diagnostic(prep)
  cat("[Step 5] GVIF diagnostic (design outcome empatica_heart_rate):", gvif_diag$paths["csv"], "\n")
  fitters <- h4_bout_fitters()
  nested <- fitters$nested
  fit_lme <- fitters$fit_lme
  do_fit_with_fallback <- fitters$do_fit_with_fallback

  fit_equation_ids <- catalog$equation_id
  # Redundancy check before fitting; a rank-deficient design stops the fit.
  preflight_df <- h4_design_preflight(raw_df, centered, selected, catalog, thermal, make_design, fit_equation_ids, outcomes, natural_log_outcomes)
  preflight_csv <- h4_path(h4_model_dir, h4_file("H4_design_redundancy_by_outcome.csv"))
  utils::write.csv(preflight_df, preflight_csv, row.names = FALSE, na = "")
  if (any(!preflight_df$passes_check)) stop(sprintf("Step 5 rank-deficiency blocked fitting for %d outcome-equation designs. Review %s; GVIF/VIF flags alone do not remove predictors.",
    sum(!preflight_df$passes_check), preflight_csv), call. = FALSE)
  fit_one_outcome <- function(job) {
    y <- job$outcome
    equation_id <- eq_id <- job$equation_id
    outcome_matrix <- as.matrix(raw_df[, c(selected, y), drop = FALSE])
    storage.mode(outcome_matrix) <- "double"
    predictors <- unique(unlist(strsplit(H4_EQUATION_FIXED[[equation_id]], ":", fixed = TRUE)))
    predictors <- setdiff(predictors, H4_PHASE_SUM_COLS)
    values <- as.matrix(raw_df[, c(predictors, y), drop = FALSE])
    storage.mode(values) <- "double"
    ok <- rowSums(!is.finite(values)) == 0L
    if (y %in% natural_log_outcomes) ok <- ok & raw_df[[y]] > 0
    outcome_rows <- raw_df[ok, c("ParticipantID", "PhaseID", "Datetime"), drop = FALSE]
    outcome_rows$ParticipantID <- factor(outcome_rows$ParticipantID)
    outcome_rows$PhaseID <- factor(outcome_rows$PhaseID, levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
    stamp <- as.numeric(as.POSIXct(outcome_rows$Datetime, tz = "UTC"))
    bout <- interaction(outcome_rows$ParticipantID, outcome_rows$PhaseID, drop = TRUE)
    outcome_rows$Time10 <- as.integer(round((stamp - ave(stamp, bout, FUN = min)) / 10))
    if (any(!is.finite(stamp)) || anyDuplicated(outcome_rows[, c("ParticipantID", "PhaseID", "Time10")]))
      stop("Invalid/duplicate timestamps for outcome: ", y)
    centered_exposures <- centered[ok, , drop = FALSE]
    lagged_exposures <- centered_lag60[ok, , drop = FALSE]
    outcome_values <- outcome_matrix[ok, y]
    if (y %in% natural_log_outcomes) {
      keep <- is.finite(outcome_values) & outcome_values > 0
      outcome_rows <- outcome_rows[keep, , drop = FALSE]
      centered_exposures <- centered_exposures[keep, , drop = FALSE]
      lagged_exposures <- lagged_exposures[keep, , drop = FALSE]
      outcome_values <- outcome_values[keep]}
    outcome_values <- PAPER3_APPLY_CSV_TRANSFORM(outcome_values, y)
    eq_row <- prep$catalog[prep$catalog$equation_id == eq_id, ]
    design <- prep$make_design(centered_exposures, prep$thermal[[eq_row$heat_form]], outcome_rows$PhaseID,
      test = eq_row$test, terms_order = h4_equation_term_order(eq_id))
    original_terms <- colnames(design)
    processed_terms <- vapply(strsplit(original_terms, ":", fixed = TRUE), function(parts) {
      paste(ifelse(startsWith(parts, "PhaseSum"), parts, paste0(parts, "_bout_z")), collapse = ":")
    }, character(1))
    safe_terms <- make.names(processed_terms, unique = TRUE)
    colnames(design) <- safe_terms
    model_data <- cbind(outcome_rows, stats::setNames(list(outcome_values), "Y"), as.data.frame(design))
    model_data <- model_data[order(model_data$ParticipantID, model_data$PhaseID, model_data$Time10), ]
      # Run the REML/AR1 fitter below (with the ARMA/independent fallbacks).
    attempt <- do_fit_with_fallback(reformulate(safe_terms, response = "Y"), model_data)
    h4_fit_equations(eq_id, y, prep$catalog, prep$thermal, prep$make_design,
      centered_exposures, lagged_exposures, outcome_rows, outcome_values,
      h4_study_spec$outcome_transform[[y]], raw_df, prep$agreed_common,
      fit_lme, nested,
      fitted_model = list(original_terms = original_terms, safe_terms = safe_terms,
        data = model_data, formula = reformulate(safe_terms, response = "Y"), attempt = attempt))}
  h4_fit_queue(fit_one_outcome, prep, preflight_df, fingerprints, h4_model_dir, outcomes, fit_equation_ids)}

# ---- Workflow ----
run_h4 <- function() {
  # Load the core engine after the spec and Eq1-7 are defined.
  source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
  cat("==============================================================================\n")
  cat("Running H4: Multivariate Models of Noise Amplification on Thermal Discomfort\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(h4_study_spec$participants), paste(h4_study_spec$participants, collapse = ", ")))
  cat(sprintf("Outcomes     (%d): %d empatica + %d eyetracker (physiological vector)\n",
              length(h4_study_spec$all_physiological_outcomes), 13L, 13L))
  cat(sprintf("Equations    (%d): 1 Primary, 4 Heat, 2 PM\n\n", nrow(h4_equation_table)))

  h4_dispatch_run()}

# Shared input step of the two exploratory blocks: needed columns as numbers, lys_lux_avg, core routes, parsed and sorted Datetime.
h4_read_block_data <- function(input_path, block_columns, block_label) {
  needed <- c("ParticipantID", "PhaseID", "Datetime", "atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux", block_columns)
  header <- names(utils::read.csv(input_path, nrows = 0, check.names = FALSE))
  miss <- setdiff(needed, header)
  if (length(miss)) stop(block_label, " block: absent input columns: ", paste(miss, collapse = ", "))
  raw <- utils::read.csv(input_path, check.names = FALSE,
    colClasses = ifelse(header %in% needed, "character", "NULL"), na.strings = c("", "NA", "NaN", "null"))
  for (nm in needed[-(1:3)]) raw[[nm]] <- suppressWarnings(as.numeric(raw[[nm]]))
  # Same light definition as H4: mean of available LYS1/LYS2 readings; both missing stays NA.
  raw$lys_lux_avg <- rowMeans(raw[, c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")], na.rm = TRUE)
  raw$lys_lux_avg[!is.finite(raw$lys_lux_avg)] <- NA_real_
  analysis_data <- raw[raw$ParticipantID %in% h4_study_spec$participants & raw$PhaseID %in% h4_study_spec$phases, , drop = FALSE]
  analysis_data$Datetime <- as.POSIXct(analysis_data$Datetime, tz = "UTC", tryFormats = c("%Y-%m-%d %H:%M:%OS", "%Y-%m-%dT%H:%M:%OS",
    "%Y-%m-%d %H:%M:%OS%z", "%Y-%m-%dT%H:%M:%OS%z"))
  if (!nrow(analysis_data) || anyNA(analysis_data$Datetime)) stop(block_label, " block: empty core routes or unparseable Datetime")
  analysis_data[order(analysis_data$ParticipantID, analysis_data$PhaseID, analysis_data$Datetime), , drop = FALSE]}

# ---- Lagged-difference block (exploratory extension of H4) ----
h4_lagdiff_run <- function(input_path = RAW_DATA_PATH) {  # results are written by h4_supplementary_run()
  pairs <- list(c("lys_lux_avg", "eyetracker_pupil_diameter_avg"),
                c("ucm_MRT", "empatica_skin_temperature"),
                c("ucm_SND_dBA", "empatica_eda_phasic"))
  lags <- c(0L, 10L, 30L, 60L)
  analysis_data <- h4_read_block_data(input_path, c("eyetracker_pupil_diameter_avg", "ucm_MRT", "empatica_skin_temperature",
    "ucm_SND_dBA", "empatica_eda_phasic"), "Lagged-difference")
  if (anyDuplicated(analysis_data[, c("ParticipantID", "PhaseID", "Datetime")])) stop("Duplicate participant/phase/time keys")
  groups <- split(analysis_data, interaction(analysis_data$ParticipantID, analysis_data$PhaseID, drop = TRUE), drop = TRUE)
  if (any(vapply(groups, function(x) as.numeric(max(x$Datetime) - min(x$Datetime), units = "secs") > 480.01, logical(1))))
    stop("Data exceed first matched 8 minutes")
  lag_subject <- list(); lag_results <- list()
  for (pair in pairs) {
    exposure <- pair[1]; outcome <- pair[2]
    for (lag in lags) {
      obs <- list()
      for (x in groups) {
        sec <- as.numeric(difftime(x$Datetime, x$Datetime[1], units = "secs"))
        step <- as.integer(round(sec / 10))
        if (any(abs(sec - 10 * step) > 1.2) || anyDuplicated(step))
          stop("Unexpected time-grid mismatch: ", x$ParticipantID[1], "/ ", x$PhaseID[1])
        ids_y_prev <- match(step - 1L, step)
        ids_x <- match(step - as.integer(lag / 10), step)
        ids_x_prev <- match(step - as.integer(lag / 10) - 1L, step)
        Y <- x[[outcome]]; X <- x[[exposure]]
        dy <- Y - Y[ids_y_prev]
        dx <- X[ids_x] - X[ids_x_prev]
        ok <- is.finite(dy) & is.finite(dx)
        if (sum(ok)) obs[[length(obs) + 1L]] <- data.frame(ParticipantID = x$ParticipantID[1], dy = dy[ok], dx = dx[ok])}
      if (!length(obs)) next
      allobs <- do.call(rbind, obs)
      rows <- list()
      for (id in unique(allobs$ParticipantID)) {
        sub <- allobs[allobs$ParticipantID == id, ]
        rv <- if (nrow(sub) >= 20L && sd(sub$dx) > 1e-10 && sd(sub$dy) > 1e-10) cor(sub$dx, sub$dy) else NA_real_
        rows[[length(rows) + 1L]] <- data.frame(Exposure = exposure, Outcome = outcome, Lag_s = lag,
          ParticipantID = id, N_10s_changes = nrow(sub), r = rv)}
      person_r <- do.call(rbind, rows); lag_subject[[length(lag_subject) + 1L]] <- person_r
      z <- atanh(pmax(-.999, pmin(.999, person_r$r[is.finite(person_r$r)])))
      tt <- paper3_signflip_mean(z)
      lag_results[[length(lag_results) + 1L]] <- data.frame(Exposure = exposure, Outcome = outcome, Lag_s = lag,
        N_Participants = tt$N, mean_r = if (is.finite(tt$estimate)) tanh(tt$estimate) else NA_real_,
        ci_low = if (is.finite(tt$ci_low)) tanh(tt$ci_low) else NA_real_,
        ci_high = if (is.finite(tt$ci_high)) tanh(tt$ci_high) else NA_real_, p = tt$p,
        N_Changes = sum(person_r$N_10s_changes[is.finite(person_r$r)]))}
  }
  res <- do.call(rbind, lag_results)
  res$q <- NA_real_; ok <- is.finite(res$p); res$q[ok] <- p.adjust(res$p[ok], method = "BH")
  cat("Lagged-difference block finished.\n")
  print(res[, c("Exposure", "Outcome", "Lag_s", "N_Participants", "mean_r", "ci_low", "ci_high", "p", "q")])
  # Per-person Pearson r of exact 10 s first differences, Fisher z, sign-flip test, BH across the 12 rows.
  invisible(list(results = res, participants = do.call(rbind, lag_subject)))}

h4_sourceadj_run <- function(input_path = RAW_DATA_PATH) {  # results are written by h4_supplementary_run()
  # Per person: lm(y ~ source + dBA + UTCI + lux) on 10 s rows centred within phase and standardised within person.
  source_terms <- c("vehicle_proportion", "rural_natural_proportion")
  source_outcomes <- c("empatica_eda_tonic", "eyetracker_fixation_rate")
  participants <- h4_study_spec$participants
  analysis_data <- h4_read_block_data(input_path, c("ucm_SND_dBA", "ucm_UTCI", source_terms, source_outcomes), "Sound-source-adjusted")
  source_subject <- list(); source_results <- list()
  for (source in source_terms) for (outcome in source_outcomes) {
    predictors <- c(source, "ucm_SND_dBA", "ucm_UTCI", "lys_lux_avg")
    tmp_results <- list()
    for (id in participants) {
      person_rows <- analysis_data[analysis_data$ParticipantID == id, c("ParticipantID", "PhaseID", predictors, outcome), drop = FALSE]
      person_rows <- person_rows[complete.cases(person_rows), , drop = FALSE]
      if (nrow(person_rows) < 60L || length(unique(person_rows$PhaseID)) < 2L) next
      rename <- c("source", "dba", "utci", "lux", "y")
      names(person_rows)[match(c(predictors, outcome), names(person_rows))] <- rename
      for (nm in rename) {
        person_rows[[nm]] <- person_rows[[nm]] - ave(person_rows[[nm]], person_rows$PhaseID, FUN = mean)
        sd_x <- sd(person_rows[[nm]])
        if (is.finite(sd_x) && sd_x > 1e-10) person_rows[[nm]] <- person_rows[[nm]] / sd_x else person_rows[[nm]] <- NA_real_}
      person_rows <- person_rows[complete.cases(person_rows), , drop = FALSE]
      if (nrow(person_rows) < 60L) next
      fit <- lm(y ~ source + dba + utci + lux, data = person_rows)
      if (fit$rank != 5L) next
      aux <- lm(source ~ dba + utci + lux, data = person_rows)
      vif <- 1 / (1 - summary(aux)$r.squared)
      if (!is.finite(vif) || vif >= 5) next
      beta <- unname(coef(fit)["source"])
      if (!is.finite(beta)) next
      tmp_results[[length(tmp_results) + 1L]] <- data.frame(Source = source, Outcome = outcome, ParticipantID = id,
        N_10s = nrow(person_rows), Beta_SD = beta, source_VIF = vif)}
    person_slopes <- if (length(tmp_results)) do.call(rbind, tmp_results) else data.frame()
    if (nrow(person_slopes)) source_subject[[length(source_subject) + 1L]] <- person_slopes
    tt <- paper3_signflip_mean(if (nrow(person_slopes)) person_slopes$Beta_SD else numeric())
    source_results[[length(source_results) + 1L]] <- data.frame(Source = source, Outcome = outcome, N_Participants = tt$N,
      mean_beta_SD = tt$estimate, ci_low = tt$ci_low, ci_high = tt$ci_high, p = tt$p,
      N_10s = if (nrow(person_slopes)) sum(person_slopes$N_10s) else 0L)}
  res <- do.call(rbind, source_results)
  res$q <- NA_real_; ok <- is.finite(res$p); res$q[ok] <- p.adjust(res$p[ok], method = "BH")
  cat("Sound-source-adjusted block finished.\n")
  print(res)
  # Sign-flip test on the mean participant slope (>= 6 people), t-interval, BH across the 4 rows.
  invisible(list(results = res, participants = if (length(source_subject)) do.call(rbind, source_subject) else data.frame()))}

# Run both exploratory blocks into one table in the script's results folder (BH within each block).
h4_supplementary_run <- function(input_path = RAW_DATA_PATH,
    out_dir = file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "Analysis_combined_timeseries")) {
  lag <- h4_lagdiff_run(input_path)
  src <- h4_sourceadj_run(input_path)
  input_md5 <- unname(tools::md5sum(input_path)); script_md5 <- unname(tools::md5sum(H4_SCRIPT_PATH))
  not_tested <- function(p) ifelse(is.finite(p), "Tested", "Not tested: fewer than 6 participants with a valid per-person value (no p, so not in the BH family)")
  lr <- lag$results; sr <- src$results
  combined <- rbind(
    data.frame(table = "lagged_difference", model_label = sprintf("lagged_difference_lag%ds", lr$Lag_s),
      outcome = lr$Outcome, term = lr$Exposure, estimate = lr$mean_r, ci_low = lr$ci_low, ci_high = lr$ci_high,
      p = lr$p, q = lr$q, n_participants = lr$N_Participants, n_observations = lr$N_Changes,
      normalization = "mean within-person Pearson r of exact 10 s first differences (raw units)",
      statistic_test = "exact two-sided sign-flip test across participants (Fisher z)",
      inference_status = not_tested(lr$p), stringsAsFactors = FALSE),
    data.frame(table = "sound_source_adjusted", model_label = "sound_source_adjusted",
      outcome = sr$Outcome, term = sr$Source, estimate = sr$mean_beta_SD, ci_low = sr$ci_low, ci_high = sr$ci_high,
      p = sr$p, q = sr$q, n_participants = sr$N_Participants, n_observations = sr$N_10s,
      normalization = "mean within-person standardized slope (SD units), adjusted for dBA, UTCI and lux",
      statistic_test = "exact two-sided sign-flip test across participants",
      inference_status = not_tested(sr$p), stringsAsFactors = FALSE))
  combined$input_md5 <- input_md5; combined$script_md5 <- script_md5
  combined$generated <- format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z")
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
  utils::write.csv(combined, file.path(out_dir, "Analysis_combined_timeseries_supplementary_blocks.csv"), row.names = FALSE, na = "")
  if (identical(Sys.getenv("PAPER3_WRITE_DETAILS", unset = ""), "1")) {
    utils::write.csv(lag$participants, file.path(out_dir, "Analysis_combined_timeseries_lagdiff_participant_correlations.csv"), row.names = FALSE)
    utils::write.csv(src$participants, file.path(out_dir, "Analysis_combined_timeseries_sourceadj_participant_slopes.csv"), row.names = FALSE)}
  cat("Supplementary blocks written to:", out_dir, "\n")
  invisible(combined)}

if (sys.nframe() == 0L) {
  h4_cli_args <- commandArgs(trailingOnly = TRUE)
  if (any(c("--supplementary-only", "--sourceadj-only", "--lagdiff-only") %in% h4_cli_args)) {
    h4_supplementary_run()  # both blocks, one table
    p3_finalize_directory(file.path(resolve_project_root(), "output", "statistical_analysis", "results", "Analysis_combined_timeseries"))
  } else {
    run_h4()}
}

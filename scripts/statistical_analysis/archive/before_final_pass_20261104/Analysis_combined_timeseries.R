# H4 time-series LME models (Eq1-7) plus two exploratory blocks (lagged differences, sound-source adjusted); shared code in library/Analysis_combined_core.R.
# Output: results/Analysis_combined_timeseries/ (the exploratory blocks run only with --supplementary-only).
source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(required_packages = c("car", "nlme", "clubSandwich"))
PROJECT_ROOT <- resolve_project_root()
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
h4_study_spec <- paper3_h4_study_spec(PROJECT_ROOT)
H4_VARIANT <- "timeseries"

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

# REML fit trying nlminb then optim; ARMA(2,0) refit when AR(1) rho > 0.95; independent residuals when AR(1) fails.
h4_fit_bout_model <- function(fml, model_data) {
  fit_lme <- function(correlation, optimizers = c("nlminb", "optim")) {
    for (optimizer in optimizers) {
      fit <- tryCatch(nlme::lme(fixed = fml, data = model_data, random = ~ 1 | ParticipantID / PhaseID,
        correlation = correlation, method = "REML", na.action = na.fail,
        control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = optimizer)),
        error = function(e) NULL)
      if (!is.null(fit)) return(fit)}
    NULL}
  fit <- fit_lme(nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID))
  if (is.null(fit)) return(list(fit = fit_lme(NULL, "nlminb"), residual_structure = "independent_fallback"))
  rho <- unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE))
  if (is.finite(rho) && rho > 0.95) {
    arma <- fit_lme(nlme::corARMA(c(0.5, 0.2), form = ~ Time10 | ParticipantID / PhaseID, p = 2, q = 0))
    if (!is.null(arma)) return(list(fit = arma, residual_structure = "ARMA20"))}
  list(fit = fit, residual_structure = "AR1")}

# Exposures centred within each bout and scaled by one pooled SD per variable, before outcome filtering.
h4_bout_centre <- function(raw_df, vars) {
  sapply(vars, function(v) {
    x <- as.numeric(raw_df[[v]])
    deviation <- x - ave(ifelse(is.finite(x), x, NA_real_), raw_df$ParticipantID, raw_df$PhaseID,
      FUN = function(z) mean(z, na.rm = TRUE))
    pooled_sd <- sd(deviation[is.finite(deviation)])
    if (is.finite(pooled_sd) && pooled_sd > 0) deviation / pooled_sd else deviation})}

h4_fit_timeseries <- function() {
  raw_df <- h4_read_input()
  raw_df$ParticipantID <- factor(raw_df$ParticipantID, levels = h4_study_spec$participants)
  equations <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7)
  fixed_terms <- lapply(equations, h4_fixed_terms)
  centered <- h4_bout_centre(raw_df, setdiff(unique(unlist(fixed_terms)), H4_PHASE_SUM_COLS))
  coefficients <- vif <- list()
  for (y in H4_OUTCOMES) {
    message(format(Sys.time(), "%H:%M:%S "), y)
    for (eq_id in seq_along(equations)) {
      fixed <- fixed_terms[[eq_id]]
      exposures <- setdiff(fixed, H4_PHASE_SUM_COLS)
      ok <- rowSums(!is.finite(as.matrix(raw_df[, c(exposures, y)]))) == 0L
      if (y %in% h4_study_spec$natural_log_outcome_names) ok <- ok & raw_df[[y]] > 0
      rows <- raw_df[ok, c("ParticipantID", "PhaseID", "Datetime")]
      rows$ParticipantID <- factor(rows$ParticipantID)
      rows$PhaseID <- factor(rows$PhaseID, levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
      stamp <- as.numeric(as.POSIXct(rows$Datetime, tz = "UTC"))
      rows$Time10 <- as.integer(round((stamp - ave(stamp, rows$ParticipantID, rows$PhaseID, FUN = min)) / 10))
      design <- cbind(centered[ok, exposures, drop = FALSE], paper3_phase_sum_design(rows$PhaseID))[, fixed]
      vif[[length(vif) + 1L]] <- h4_vif_row(eq_id, y, design)
      colnames(design) <- make.names(ifelse(startsWith(fixed, "PhaseSum"), fixed, paste0(fixed, "_bout_z")), unique = TRUE)
      y_values <- paper3_apply_csv_transform(as.numeric(raw_df[[y]][ok]), y, h4_study_spec$outcome_transforms_csv)
      model_data <- cbind(rows, Y = y_values, as.data.frame(design))
      model_data <- model_data[order(model_data$ParticipantID, model_data$PhaseID, model_data$Time10), ]
      attempt <- h4_fit_bout_model(reformulate(colnames(design), response = "Y"), model_data)
      fit <- attempt$fit
      if (is.null(fit)) next
      rho <- tryCatch(unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)
      if (length(rho) != 1L) rho <- NA_real_
      variance <- nlme::VarCorr(fit)[, "Variance"]
      variance <- as.numeric(variance[grepl("^[0-9.+eE-]+$", variance)])
      results <- data.frame(equation_id = eq_id, block = "heat_plus_sound_additive", outcome = y,
        term = c("Intercept", fixed, "PhaseSumBikeU"), h4_cr2(fit, model_data$ParticipantID)$coefficients,
        residual_structure = attempt$residual_structure, n = nrow(model_data), n_participants = nlevels(model_data$ParticipantID),
        transformation = if (y %in% h4_study_spec$natural_log_outcome_names) "natural log" else "native",
        boundary_variance = any(variance[is.finite(variance)] < 1e-6 * sigma(fit)^2), high_ar1_flag = is.finite(rho) && rho > 0.95)
      # Only AR(1) or ARMA(2,0) fits without an unresolved rho > 0.95 are tested.
      if (!attempt$residual_structure %in% c("AR1", "ARMA20") || results$high_ar1_flag[1]) results$p_value <- NA_real_
      coefficients[[length(coefficients) + 1L]] <- results[-1L, ]}
  }
  hypothesis <- do.call(rbind, coefficients)
  hypothesis <- h4_fdr(hypothesis, paste(hypothesis$equation_id, hypothesis$term))
  hypothesis$term <- h4_phase_term_labels(hypothesis$term)
  h4_write_vif(do.call(rbind, vif))
  h4_write_tables(list(hypothesis = hypothesis))
  message("Hypothesis rows: ", nrow(hypothesis), ", q < .05: ", sum(hypothesis$q < .05, na.rm = TRUE))}

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
  analysis_data[order(analysis_data$ParticipantID, analysis_data$PhaseID, analysis_data$Datetime), , drop = FALSE]}

# ---- Lagged-difference block (exploratory extension of H4) ----
h4_lagdiff_run <- function(input_path = RAW_DATA_PATH) {  # results are written by h4_supplementary_run()
  pairs <- list(c("lys_lux_avg", "eyetracker_pupil_diameter_avg"),
                c("ucm_MRT", "empatica_skin_temperature"),
                c("ucm_SND_dBA", "empatica_eda_phasic"))
  lags <- c(0L, 10L, 30L, 60L)
  analysis_data <- h4_read_block_data(input_path, c("eyetracker_pupil_diameter_avg", "ucm_MRT", "empatica_skin_temperature",
    "ucm_SND_dBA", "empatica_eda_phasic"), "Lagged-difference")
  groups <- split(analysis_data, interaction(analysis_data$ParticipantID, analysis_data$PhaseID, drop = TRUE), drop = TRUE)
  lag_subject <- list(); lag_results <- list()
  for (pair in pairs) {
    exposure <- pair[1]; outcome <- pair[2]
    for (lag in lags) {
      obs <- list()
      for (x in groups) {
        sec <- as.numeric(difftime(x$Datetime, x$Datetime[1], units = "secs"))
        step <- as.integer(round(sec / 10))
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
  # Sign-flip test on the mean participant slope (>= 6 people), t-interval, BH across the 4 rows.
  invisible(list(results = res, participants = if (length(source_subject)) do.call(rbind, source_subject) else data.frame()))}

# Run both exploratory blocks into one table in the script's results folder (BH within each block).
h4_supplementary_run <- function(input_path = RAW_DATA_PATH,
    out_dir = file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "Analysis_combined_timeseries")) {
  lag <- h4_lagdiff_run(input_path)
  src <- h4_sourceadj_run(input_path)
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
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
  utils::write.csv(combined, file.path(out_dir, "Analysis_combined_timeseries_supplementary_blocks.csv"), row.names = FALSE, na = "")
  invisible(combined)}

if (sys.nframe() == 0L) {
  source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
  if (any(c("--supplementary-only", "--sourceadj-only", "--lagdiff-only") %in% commandArgs(trailingOnly = TRUE))) {
    h4_supplementary_run()
    p3_finalize_directory(OUT_DIR)
  } else {
    h4_fit_timeseries()}
}

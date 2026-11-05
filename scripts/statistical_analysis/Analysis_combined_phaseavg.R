# Combined-exposure LME models (Eq1-7) on participant x phase means; shared code in library/Analysis_combined_core.R.
# Output: results/Analysis_combined_phaseavg/
source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(required_packages = c("car", "nlme", "clubSandwich"))
PROJECT_ROOT <- resolve_project_root()
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
combined_study_spec <- paper3_combined_study_spec(PROJECT_ROOT)
COMBINED_VARIANT <- "phaseavg"

# Eq1 is the main model; Eq2-7 swap the heat or PM term. Y is the transformed outcome (not centred); *_phase_z predictors are centred.
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI_phase_z + ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)))

# Eq2: air T, RH, wind + SVF (additive, no MRT; sound, irradiance and GVI left out at phase level)
Eq2 <- quote(nlme::lme(
  Y ~ ucm_AIR_T_mid_phase_z + ucm_AIR_RH_phase_z + ucm_WIND_AWS_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)))

# Eq3: MRT plus sound, PM2.5, light, green view and route contrasts.
# ucm_SUN_Gh and SVF are omitted because MRT is already a radiation term.
Eq3 <- quote(nlme::lme(
  Y ~ ucm_MRT_phase_z + ucm_SND_dBA_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + gvi_50m_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)))

# Eq4: HUMIDEX + sound (additive effects)
Eq4 <- quote(nlme::lme(
  Y ~ ucm_HUMIDEX_phase_z + ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)))

# Eq5: PET + sound (additive effects)
Eq5 <- quote(nlme::lme(
  Y ~ ucm_PET_phase_z + ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)))

# Eq6: Eq1 with PM1
Eq6 <- quote(nlme::lme(
  Y ~ ucm_UTCI_phase_z + ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm1_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)))

# Eq7: Eq1 with PM10
Eq7 <- quote(nlme::lme(
  Y ~ ucm_UTCI_phase_z + ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm10_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)))

# Exposures are centred within participant across the phase means and scaled by one pooled SD per variable.
combined_fit_phaseavg <- function() {
  raw_df <- combined_read_input()
  equations <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7)
  coefficients <- contrasts <- vif <- list()

  for (equation_id in seq_along(equations)) for (outcome in COMBINED_OUTCOMES) {
    fixed <- as.formula(equations[[equation_id]][[2L]])
    exposures <- setdiff(combined_fixed_terms(equations[[equation_id]]), COMBINED_PHASE_SUM_COLS)
    data <- raw_df[, c("ParticipantID", "PhaseID", exposures, outcome)]
    data$Y <- paper3_apply_csv_transform(data[[outcome]], outcome, combined_study_spec$outcome_transforms_csv)
    # Predictor means and transformed Y use the same complete epochs.
    data <- data[rowSums(!is.finite(as.matrix(data[, c(exposures, "Y")]))) == 0, ]
    model_data <- aggregate(data[, c(exposures, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
    model_data <- model_data[order(model_data$ParticipantID, model_data$PhaseID), ]
    model_data$ParticipantID <- factor(model_data$ParticipantID)
    for (variable in exposures) {
      centered <- model_data[[variable]] - ave(model_data[[variable]], model_data$ParticipantID, FUN = mean)
      pooled_sd <- sd(centered)
      model_data[[paste0(variable, "_phase_z")]] <- if (is.finite(pooled_sd) && pooled_sd > 0) centered / pooled_sd else centered}
    model_data[, COMBINED_PHASE_SUM_COLS] <- paper3_phase_sum_design(model_data$PhaseID)
    design <- model.matrix(fixed, model_data)[, -1L]
    colnames(design) <- gsub("_phase_z", "", colnames(design), fixed = TRUE)
    vif[[length(vif) + 1L]] <- combined_vif_row(equation_id, outcome, design)
    fit <- nlme::lme(fixed = fixed, data = model_data, random = ~ 1 | ParticipantID, method = "REML", na.action = na.fail,
      control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE))
    cr2 <- combined_cr2(fit, model_data$ParticipantID, planned = TRUE)
    coefficients[[length(coefficients) + 1L]] <- data.frame(equation_id = equation_id, outcome = outcome,
      term = c(colnames(design), "PhaseSumBikeU"), cr2$coefficients[-1L, ],
      transformation = if (outcome %in% combined_study_spec$natural_log_outcome_names) "natural log before phase averaging" else "native",
      n = nrow(model_data), n_participants = nlevels(model_data$ParticipantID))
    contrasts[[length(contrasts) + 1L]] <- data.frame(equation_id = equation_id, outcome = outcome, cr2$contrasts)}

  coefficients <- do.call(rbind, coefficients)
  coefficients <- combined_fdr(coefficients, paste(coefficients$equation_id, coefficients$term))
  coefficients$term <- combined_phase_term_labels(coefficients$term)
  contrasts <- do.call(rbind, contrasts)
  contrasts <- contrasts[order(contrasts$outcome, contrasts$equation_id, contrasts$contrast), ]
  contrasts <- combined_fdr(contrasts, paste(contrasts$equation_id, contrasts$contrast))
  combined_write_vif(do.call(rbind, vif))
  combined_write_tables(list(Heat_Noise_Exposures = coefficients, phase_contrasts = contrasts))
  message("Coefficient rows: ", nrow(coefficients), ", q < .05: ", sum(coefficients$q < .05, na.rm = TRUE))}

if (sys.nframe() == 0L) {
  source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
  combined_fit_phaseavg()}

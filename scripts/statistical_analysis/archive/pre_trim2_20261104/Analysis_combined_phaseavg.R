# H4 phase-average LME models (Eq1-7); shared fitting and reporting in library/Analysis_combined_core.R.
# Output: results/Analysis_combined_phaseavg/
source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(required_packages = c("car", "nlme", "clubSandwich"))
PROJECT_ROOT <- resolve_project_root()
# Step 5: serial fits; optional batches via H4_JOB_START / H4_JOB_END or H4_MAX_JOBS.
H4_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/Analysis_combined_phaseavg.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))

# Cohort, phases and the 26 physiological outcomes; the equation table and term checks are in the core.
h4_study_spec <- paper3_h4_study_spec(PROJECT_ROOT)
OUTCOME_TRANSFORMS_CSV <- h4_study_spec$outcome_transforms_csv

# Eq1 is the main model; Eq2-7 swap the heat or PM term. Y is not centered, *_phase_z predictors are.

# Eq1 primary: UTCI + sound (additive). Y = PAPER3_APPLY_CSV_TRANSFORM(x), not centered.
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

# Eq3: MRT + sound + PM2.5 + light + route phase contrasts (additive; no interactions)
Eq3 <- quote(nlme::lme(
  Y ~ ucm_MRT_phase_z + ucm_SND_dBA_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
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

# One run per outcome and equation. One shared SD, e.g. means A=(10,14), B=(20,26) -> deviations (-2,2,-3,3), SD = sqrt(26/3).
h4_fit_phaseavg <- function(raw_data, equation_ids = 1:7,
    outcomes = h4_study_spec$all_physiological_outcomes) {
  equations <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7)
  results <- list()
  for (equation_id in equation_ids) for (outcome in outcomes) {
    fixed <- as.formula(equations[[equation_id]][[2L]])
    eligibility <- setdiff(h4_fixed_terms_from_lme_quote(equations[[equation_id]]), H4_PHASE_SUM_COLS)
    data <- raw_data[, c("ParticipantID", "PhaseID", eligibility, outcome)]
    data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[outcome]], outcome)
    valid <- rowSums(!is.finite(as.matrix(data[, c(eligibility, "Y")]))) == 0
    data <- data[valid, ]
    # Predictor means and transformed Y use the same eligible epochs.
    model_data <- aggregate(data[, c(eligibility, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
    epochs <- aggregate(data$Y, data[, c("ParticipantID", "PhaseID")], length)
    names(epochs)[3L] <- "epochs"
    model_data <- merge(model_data, epochs, by = c("ParticipantID", "PhaseID"))
    model_data$ParticipantID <- factor(model_data$ParticipantID)
    for (variable in eligibility) {
      phase_mean <- model_data[[variable]]
      person_mean <- ave(phase_mean, model_data$ParticipantID, FUN = mean)
      centered <- phase_mean - person_mean
      shared_sd <- sd(centered) # sample SD over all centered phase cells
      model_data[[paste0(variable, "_phase_z")]] <-
        if (is.finite(shared_sd) && shared_sd > 0) centered / shared_sd else centered}
    model_data[, H4_PHASE_SUM_COLS] <- h4_phase_design(model_data$PhaseID)
    # '*' builds standardized main effects and their products after centering/scaling.
    design <- model.matrix(fixed, model_data)
    note <- character()
    fit <- NULL
    if (qr(design)$rank < ncol(design) || nrow(model_data) <= ncol(design)) {
      note <- "Rank-deficient design or no residual degrees of freedom"
    } else {
      fit <- tryCatch(withCallingHandlers(
        nlme::lme(fixed = fixed, data = model_data, random = ~ 1 | ParticipantID,
          method = "REML", na.action = na.fail,
          control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)),
        warning = function(warning_condition) note <<- c(note, conditionMessage(warning_condition)),
        error = function(local_error) { note <<- c(note, conditionMessage(local_error)); NULL }))}
    result <- h4_phase_mean_results(equation_id, outcome, fixed, model_data, design, fit, note)
    # Design diagnostic only; nothing is dropped.
    result$status$max_vif_equivalent <- max(h4_vif_per_term(design[, colnames(design) != "(Intercept)", drop = FALSE]))
    results[[length(results) + 1L]] <- result}
  results}

# ---- Workflow ----
run_h4_phaseavg <- function() {
  # Load the core engine after the spec and Eq1-7 are defined.
  H4_ANALYSIS_MODE <<- "phaseavg"  # results go to results/Analysis_combined_phaseavg/
  source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
  rm("H4_ANALYSIS_MODE", envir = .GlobalEnv)
  cat("==============================================================================\n")
  cat("Running H4: Phase-average sensitivity (exploratory multivariate LME)\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(h4_study_spec$participants), paste(h4_study_spec$participants, collapse = ", ")))
  cat(sprintf("Outcomes     (%d): %d empatica + %d eyetracker (physiological vector)\n",
              length(h4_study_spec$all_physiological_outcomes), 13L, 13L))
  cat(sprintf("Equations    (%d): 1 Primary, 4 Heat, 2 PM\n\n", nrow(h4_equation_table)))

  raw <- h4_read_merged_analysis_data()
  raw <- h4_apply_average_sources(raw)
  prepared <- h4_step4_exposure_prep(raw)
  prepared$catalog$primary <- FALSE
  prepared$catalog$analysis_role <- "Exploratory phase-average sensitivity"
  prepared$catalog$heat_role[prepared$catalog$equation_id == 2L] <- "Air temperature + RH + apparent wind (no MRT)"
  results <- h4_fit_phaseavg(prepared$raw_df)
  h4_phase_publish_results(results, prepared)}

if (sys.nframe() == 0L) run_h4_phaseavg()

# Tidy final CSV presentation after all calculations.
if (sys.nframe() == 0L) p3_finalize_directory(file.path(resolve_project_root(), "output", "statistical_analysis", "results", "Analysis_combined_phaseavg"))

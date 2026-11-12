# H4 phase-average LME — explicit preparation and equations; shared audits/reporting in Analysis_combined_core.R
if (!exists("PAPER3_PARTICIPANTS", inherits = FALSE)) {
  .entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (!length(.entry)) {
    .trail <- commandArgs(trailingOnly = TRUE)
    if (length(.trail) && file.exists(.trail[1])) .entry <- .trail[1]
  }
  if (!length(.entry)) {
    .source_files <- vapply(sys.frames(), function(frame) {
      if (is.null(frame$ofile)) "" else as.character(frame$ofile)[1L]
    }, character(1))
    .entry <- tail(.source_files[nzchar(.source_files)], 1L)
  }
  if (length(.entry)) {
    source(file.path(dirname(normalizePath(.entry[1], mustWork = FALSE)), "library", "Paper3_common.R"), local = FALSE)
  } else if (file.exists(file.path("library", "Paper3_common.R"))) {
    source(file.path("library", "Paper3_common.R"), local = FALSE)
  }
}
paper3_source_statistical_common_if_needed()
paper3_statistical_bootstrap(
  required_packages = c("ggplot2", "gridExtra", "car", "nlme", "clubSandwich"),
  load_packages = c("ggplot2", "gridExtra"),
  h4_pdf_null = TRUE
)
PROJECT_ROOT <- resolve_project_root()
# Step 5: serial fits (H4_PARALLEL_WORKERS=1). Optional batches via H4_JOB_START / H4_JOB_END or H4_MAX_JOBS.
Sys.setenv(H4_PARALLEL_WORKERS = "1")
H4_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/Analysis_combined_phaseavg.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))

# Cohort, phase and outcome specification (26 physiological outcomes via paper3_physiological_outcomes()).
h4_study_spec <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = c("BikeU", "BikeG", "WalkU", "WalkG"),
  physiological_outcome_names = paper3_physiological_outcomes(),
  variance_inflation_factor_limit = 10,
  expected_epoch_count = 49L
)

h4_study_spec <- paper3_attach_outcome_normalization(h4_study_spec, PROJECT_ROOT)
NORMALIZATION_CSV_PATH <- h4_study_spec$normalization_csv_path
OUTCOME_TRANSFORMS_CSV <- h4_study_spec$outcome_transforms_csv
PAPER3_APPLY_CSV_TRANSFORM <- function(x, column_name) {
  paper3_apply_csv_transform(x, column_name, OUTCOME_TRANSFORMS_CSV)
}


# Eq1 is the model. Eq2–6 change the heat or PM term. Y is not centered. Predictors ending in _phase_z are.

# UTCI in rows 1, 5–6: Eq1 primary; Eqs 5–6 PM size on UTCI.
h4_equation_table <- data.frame(
  equation_number = 1:6,
  heat_predictor_label = c("UTCI", "AIR_T_mid + AIR_RH + WIND_AWS", "HUMIDEX", "PET", "UTCI", "UTCI"),
  particulate_matter_column = c(rep("atmo_pm2.5_avg", 4), "atmo_pm1_avg", "atmo_pm10_avg"),
  equation_role = c("primary", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity",
    "pm_size_sensitivity", "pm_size_sensitivity"),
  stringsAsFactors = FALSE
)

# Eq1 primary: UTCI x sound
# Y <- PAPER3_APPLY_CSV_TRANSFORM(x, column_name); phase mean of Y is not centered.
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI_phase_z * ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq2: air temperature, humidity, wind, MRT, each x sound
Eq2 <- quote(nlme::lme(
  Y ~ ucm_AIR_T_mid_phase_z * ucm_SND_dBA_phase_z + ucm_AIR_RH_phase_z * ucm_SND_dBA_phase_z + ucm_WIND_AWS_phase_z * ucm_SND_dBA_phase_z + ucm_MRT_phase_z * ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq3: HUMIDEX x sound
Eq3 <- quote(nlme::lme(
  Y ~ ucm_HUMIDEX_phase_z * ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq4: PET x sound
Eq4 <- quote(nlme::lme(
  Y ~ ucm_PET_phase_z * ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq5: Eq1 with PM1
Eq5 <- quote(nlme::lme(
  Y ~ ucm_UTCI_phase_z * ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm1_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq6: Eq1 with PM10
Eq6 <- quote(nlme::lme(
  Y ~ ucm_UTCI_phase_z * ucm_SND_dBA_phase_z + SVF_phase_z + atmo_pm10_avg_phase_z + lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

H4_REFERENCE_MODELS <- local({
  statements <- parse(file.path(SCRIPT_DIR, "Analysis_combined_timeseries.R"))
  # Shared exposure diagnostics reuse these exact definitions without executing the time-series runner.
  diagnostic_defs <- Filter(function(statement) {
    is.call(statement) && identical(statement[[1L]], as.name("<-")) &&
      is.symbol(statement[[2L]]) && as.character(statement[[2L]]) %in%
        c("h4_prepare_bout_exposures", "h4_prepare_bout_design")
  }, statements)
  stopifnot(length(diagnostic_defs) == 2L)
  for (statement in diagnostic_defs) eval(statement, envir = .GlobalEnv)
  eq_assigns <- Filter(function(statement) {
    is.call(statement) && identical(statement[[1L]], as.name("<-")) &&
      is.symbol(statement[[2L]]) && as.character(statement[[2L]]) %in% paste0("Eq", 1:6)
  }, statements)
  setNames(lapply(eq_assigns, function(statement) {
    model <- eval(statement[[3L]])
    model[[2L]] <- as.formula(gsub("_bout_z", "", paste(deparse(model[[2L]]), collapse = " ")))
    model
  }), as.character(1:6))
})

# One executed sequence per outcome/equation; the six formulas above supply the fixed effects.
# Example: phase means A=(10,14), B=(20,26) give deviations (-2,2,-3,3).
# The ONE shared sample SD is sqrt(26/3)=2.9439, not a separate SD for each participant.
h4_fit_phaseavg <- function(raw_data, equation_ids = 1:6,
    outcomes = h4_study_spec$all_physiological_outcomes) {
  equations <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6)
  results <- list()
  for (equation_id in equation_ids) for (outcome in outcomes) {
    fixed <- as.formula(equations[[equation_id]][[2L]])
    reference <- H4_REFERENCE_MODELS[[equation_id]][[2L]]
    eligibility <- setdiff(all.vars(reference), c("Y", H4_PHASE_SUM_COLS))
    data <- raw_data[, c("ParticipantID", "PhaseID", eligibility, outcome)]
    data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[outcome]], outcome)
    valid <- rowSums(!is.finite(as.matrix(data[, c(eligibility, "Y")]))) == 0
    data <- data[valid, ]
    # All predictor means and transformed Y use exactly the same eligible epochs.
    model_data <- aggregate(data[, c(eligibility, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
    epochs <- aggregate(data$Y, data[, c("ParticipantID", "PhaseID")], length)
    names(epochs)[3L] <- "epochs"
    model_data <- merge(model_data, epochs, by = c("ParticipantID", "PhaseID"))
    model_data$ParticipantID <- factor(model_data$ParticipantID)
    for (variable in eligibility) {
      phase_mean <- model_data[[variable]]
      person_mean <- ave(phase_mean, model_data$ParticipantID, FUN = mean)
      centered <- phase_mean - person_mean
      shared_sd <- sd(centered) # sample SD over ALL available centered phase cells (N - 1)
      model_data[[paste0(variable, "_phase_z")]] <-
        if (is.finite(shared_sd) && shared_sd > 0) centered / shared_sd else centered
    }
    model_data[, H4_PHASE_SUM_COLS] <- h4_phase_design(model_data$PhaseID)
    # '*' constructs standardized main effects and their products AFTER centering/scaling.
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
        warning = function(w) note <<- c(note, conditionMessage(w)),
        error = function(e) { note <<- c(note, conditionMessage(e)); NULL }))
    }
    result <- h4_phase_mean_results(equation_id, outcome, fixed, model_data, design, fit, note)
    # Design-only diagnostic; no predictor is dropped and no model fit is changed.
    result$status$max_vif_equivalent <- max(h4_vif_per_term(design[, colnames(design) != "(Intercept)", drop = FALSE]))
    results[[length(results) + 1L]] <- result
  }
  results
}

# Pipeline validation: fixed-effect order parsed from the six formulas above (not edited separately).
h4_fixed_terms_from_lme_quote <- function(lme_quote) {
  fml <- as.formula(lme_quote[[2L]])
  gsub("_(phase|bout)_z", "", gsub("`", "", attr(terms(fml), "term.labels"), fixed = TRUE))
}
H4_EQUATION_FIXED <- list(
  `1` = h4_fixed_terms_from_lme_quote(Eq1),
  `2` = h4_fixed_terms_from_lme_quote(Eq2),
  `3` = h4_fixed_terms_from_lme_quote(Eq3),
  `4` = h4_fixed_terms_from_lme_quote(Eq4),
  `5` = h4_fixed_terms_from_lme_quote(Eq5),
  `6` = h4_fixed_terms_from_lme_quote(Eq6)
)

# ==============================================================================
# WORKFLOW
# ==============================================================================
run_h4_phaseavg <- function() {
  # Load audit/fit engine after h4_study_spec, Eq1–6, and H4_REFERENCE_MODELS are defined.
  H4_ANALYSIS_MODE <<- "phaseavg"  # core writes to results/Analysis_combined_phaseavg/ with Analysis_combined_phaseavg_* file names
  source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
  rm("H4_ANALYSIS_MODE", envir = .GlobalEnv)
  cat("==============================================================================\n")
  cat("Running H4: Phase-average sensitivity (exploratory multivariate LME)\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(h4_study_spec$participants), paste(h4_study_spec$participants, collapse = ", ")))
  cat(sprintf("Outcomes     (%d): %d empatica + %d eyetracker (physiological vector)\n",
              length(h4_study_spec$all_physiological_outcomes), 13L, 13L))
  cat(sprintf("Equations    (%d): 1 Primary, 3 Heat, 2 PM\n\n", nrow(h4_equation_table)))

  shared_audit_dir <- file.path(H4_RESULTS_ROOT, "Analysis_combined_timeseries")
  raw <- h4_read_merged_analysis_data()
  raw <- h4_apply_average_sources(raw)
  audit <- read.csv(file.path(shared_audit_dir, "Analysis_combined_timeseries_Multivariate_Filtration_Results.csv"), check.names = FALSE)
  prepared <- h4_step4_exposure_prep(audit, raw)
  prepared$catalog$primary <- FALSE
  prepared$catalog$analysis_role <- "Exploratory phase-average sensitivity"
  prepared$catalog$heat_role[prepared$catalog$equation_id == 2L] <- "Air temperature + RH + apparent wind + MRT interactions with sound"
  results <- h4_fit_phaseavg(prepared$raw_df)
  h4_phase_publish_results(results, prepared, audit, shared_audit_dir)
}

if (sys.nframe() == 0L) run_h4_phaseavg()

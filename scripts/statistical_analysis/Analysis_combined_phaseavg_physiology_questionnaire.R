# Phase-mean Eq1-7 with a questionnaire item as Y and one physiological channel added on the right-hand side.
# One channel per model (the full sensor battery, not a hand-picked subset). Eq8 is not used.
# Output: results/Analysis_combined_phaseavg_physiology_questionnaire/
# Benjamini-Hochberg is one family over every coefficient row from this script, not split by equation.
source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "Analysis_combined_phaseavg.R"), local = FALSE)
source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
COMBINED_VARIANT <- "phaseavg_physiology_questionnaire"
COMBINED_FILE_PREFIX <- paste0("Analysis_combined_", COMBINED_VARIANT)
OUT_DIR <- file.path(COMBINED_RESULTS_ROOT, COMBINED_FILE_PREFIX)
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

physiology_questionnaire_fit <- function() {
  raw_df <- combined_read_input()
  equations <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7)
  physio <- combined_study_spec$physiological_outcome_names
  coefficients <- list()
  for (equation_id in seq_along(equations)) {
    exposures <- setdiff(combined_fixed_terms(equations[[equation_id]]), COMBINED_PHASE_SUM_COLS)
    for (q_out in paper3_psych_questionnaire_outcomes()) for (bio in physio) {
      data <- raw_df[, c("ParticipantID", "PhaseID", exposures, bio, q_out)]
      data$Y <- as.numeric(data[[q_out]])
      data[[bio]] <- paper3_apply_csv_transform(data[[bio]], bio, combined_study_spec$outcome_transforms_csv)
      data <- data[rowSums(!is.finite(as.matrix(data[, c(exposures, bio, "Y")]))) == 0, ]
      model_data <- aggregate(data[, c(exposures, bio, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
      model_data <- model_data[order(model_data$ParticipantID, model_data$PhaseID), ]
      model_data$ParticipantID <- factor(model_data$ParticipantID)
      predictors <- c(exposures, bio)
      singular <- FALSE
      for (variable in predictors) {
        centered <- model_data[[variable]] - ave(model_data[[variable]], model_data$ParticipantID, FUN = mean)
        pooled_sd <- sd(centered)
        if (!is.finite(pooled_sd) || pooled_sd == 0) singular <- TRUE
        model_data[[paste0(variable, "_phase_z")]] <- if (!singular && pooled_sd > 0) centered / pooled_sd else centered}
      if (singular || nrow(model_data) < 8L || nlevels(model_data$ParticipantID) < 8L) next
      model_data[, COMBINED_PHASE_SUM_COLS] <- paper3_phase_sum_design(model_data$PhaseID)
      fixed <- as.formula(paste("Y ~", paste(c(paste0(predictors, "_phase_z"), COMBINED_PHASE_SUM_COLS), collapse = " + ")))
      fit <- tryCatch(nlme::lme(fixed = fixed, data = model_data, random = ~ 1 | ParticipantID, method = "REML", na.action = na.fail,
        control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)), error = function(e) NULL)
      if (is.null(fit)) next
      cr2 <- tryCatch(combined_cr2(fit, model_data$ParticipantID, planned = FALSE), error = function(e) NULL)
      if (is.null(cr2)) next
      design <- model.matrix(fixed, model_data)[, -1L]
      colnames(design) <- gsub("_phase_z", "", colnames(design), fixed = TRUE)
      coefficients[[length(coefficients) + 1L]] <- data.frame(
        equation_id = equation_id, outcome = q_out,
        physiological_predictor = bio, block = bio,
        term = c(colnames(design), "PhaseSumBikeU"), cr2$coefficients[-1L, ],
        transformation = "questionnaire native Likert; physiological predictor uses the normalization CSV before phase averaging",
        n = nrow(model_data), n_participants = nlevels(model_data$ParticipantID))}}
  coefficients <- do.call(rbind, coefficients)
  tested <- is.finite(coefficients$p_value)
  coefficients$q <- NA_real_
  coefficients$q[tested] <- p.adjust(coefficients$p_value[tested], method = "BH")
  coefficients$inference_status <- ifelse(tested, "Tested", "Not estimable: model covariance or coefficient inference unavailable")
  coefficients$fdr_family <- "one BH family over every coefficient in this script"
  coefficients$term <- combined_phase_term_labels(coefficients$term)
  combined_write_tables(list(coefficients = coefficients))
  message("Models with coefficients: ", length(unique(paste(coefficients$equation_id, coefficients$outcome, coefficients$physiological_predictor))),
    "; coefficient rows: ", nrow(coefficients), "; q < .05: ", sum(coefficients$q < .05, na.rm = TRUE))}

if (sys.nframe() == 0L) physiology_questionnaire_fit()

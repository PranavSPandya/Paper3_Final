# Phase-mean sensitivity using all seven equations defined in H4_multivariate.R.
# Participant random intercept; no temporal AR(1) with one observation per phase.
script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
SCRIPT_DIR <- if (length(script_arg)) dirname(normalizePath(script_arg[1])) else
  if (basename(getwd()) == "scripts") getwd() else file.path(getwd(), "scripts")
source(file.path(SCRIPT_DIR, "H4_multivariate.R"))
H4_ANALYSIS_MODE <- "phaseavg"
source(file.path(SCRIPT_DIR, "H4_core.R"))
rm(H4_ANALYSIS_MODE)
PHASE_OUTPUT_DIR <- RESULT_DIR
SHARED_AUDIT_DIR <- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results/timeseries/_work")

fit_h4_phase_mean <- function(equation_id, outcome, raw_data) {
  fixed <- as.formula(get(paste0("Eq", equation_id))[[2L]])
  exposures <- setdiff(all.vars(fixed), c("Y", "PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG"))
  data <- raw_data[, c("ParticipantID", "PhaseID", exposures, outcome)]
  data$Y <- data[[outcome]]
  if (outcome %in% hrv_log_outcomes()) {
    data$Y[!is.finite(data$Y) | data$Y <= 0] <- NA_real_
    data$Y <- log(data$Y)
  }
  valid <- rowSums(!is.finite(as.matrix(data[, c(exposures, "Y")]))) == 0
  data <- data[valid, ]
  # Use identical observed epochs for the outcome and all predictors in each model.
  phase <- aggregate(data[, c(exposures, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
  epochs <- aggregate(data$Y, data[, c("ParticipantID", "PhaseID")], length)
  names(epochs)[3L] <- "epochs"
  phase <- merge(phase, epochs, by = c("ParticipantID", "PhaseID"))
  phase$ParticipantID <- factor(phase$ParticipantID)
  for (variable in exposures) {
    centered <- phase[[variable]] - ave(phase[[variable]], phase$ParticipantID, FUN = mean)
    spread <- sd(centered)
    phase[[variable]] <- if (is.finite(spread) && spread > 0) centered / spread else centered
  }
  contrasts <- contr.sum(4L)
  rownames(contrasts) <- c("WalkG", "WalkU", "BikeG", "BikeU")
  phase[, c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")] <- contrasts[as.character(phase$PhaseID), ]
  design <- model.matrix(fixed, phase)
  columns <- colnames(design)
  full_rank <- qr(design)$rank == ncol(design)
  vif <- h4_vif_per_term(design[, columns != "(Intercept)", drop = FALSE])
  result <- data.frame(equation_id = equation_id, equation = h4_equation_thermal_label(equation_spec[equation_id, ]), outcome = outcome,
    term = c(ifelse(columns == "(Intercept)", "Intercept", columns), "PhaseSumBikeU"), Beta = NA_real_, SE = NA_real_,
    df = NA_real_, ci_low = NA_real_, ci_high = NA_real_, p = NA_real_)
  heat <- setdiff(unlist(strsplit(h4_sound_interaction_terms(attr(terms(fixed), "term.labels")), ":", fixed = TRUE)), "ucm_SND_dBA")
  result$term_type <- ifelse(result$term == "Intercept", "intercept", ifelse(startsWith(result$term, "PhaseSum"), "phase (study design)",
    ifelse(result$term %in% c("ucm_SND_dBA", H4_EQ2_SOUND_MAIN_TERMS), "sound exposure",
      ifelse(result$term %in% heat | grepl(":", result$term), "thermal exposure", "covariate"))))
  note <- character()
  success <- FALSE
  boundary <- NA
  phase_comparisons <- NULL
  fit <- NULL
  if (!full_rank || nrow(phase) <= ncol(design)) {
    note <- "Rank-deficient design or no residual degrees of freedom"
  } else {
    fit <- tryCatch(withCallingHandlers(
      nlme::lme(fixed, data = phase, random = ~ 1 | ParticipantID,
        method = "REML", na.action = na.fail,
        control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)),
      warning = function(w) note <<- c(note, conditionMessage(w))),
      error = function(e) { note <<- c(note, conditionMessage(e)); NULL })
  }
  if (!is.null(fit)) {
    robust <- tryCatch(withCallingHandlers(
      clubSandwich::coef_test(fit, vcov = "CR2", cluster = phase$ParticipantID, test = "Satterthwaite"),
      warning = function(w) note <<- c(note, conditionMessage(w))),
      error = function(e) { note <<- c(note, paste("CR2:", conditionMessage(e))); NULL })
    if (!is.null(robust)) {
      index <- match(ifelse(result$term == "Intercept", "(Intercept)", result$term), rownames(robust))
      result$Beta <- robust$beta[index]
      result$SE <- robust$SE[index]
      result$df <- robust$df_Satt[index]
      result$p <- 2 * pt(-abs(result$Beta / result$SE), result$df)
      result$ci_low <- result$Beta - qt(.975, result$df) * result$SE
      result$ci_high <- result$Beta + qt(.975, result$df) * result$SE
      success <- all(is.finite(robust$beta))
      tryCatch({
        variance <- clubSandwich::vcovCR(fit, cluster = phase$ParticipantID, type = "CR2")
        weights <- matrix(0, 1L, length(nlme::fixef(fit)), dimnames = list(NULL, names(nlme::fixef(fit))))
        weights[1L, c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")] <- -1
        test <- clubSandwich::Wald_test(fit, constraints = weights, vcov = variance, test = "HTZ")
        row <- which(result$term == "PhaseSumBikeU")
        result$Beta[row] <- as.numeric(weights %*% nlme::fixef(fit))
        result$SE[row] <- sqrt(as.numeric(weights %*% variance %*% t(weights)))
        result$df[row] <- as.numeric(test$df_denom)
        result$p[row] <- as.numeric(test$p_val)
        result$ci_low[row] <- result$Beta[row] - qt(.975, result$df[row]) * result$SE[row]
        result$ci_high[row] <- result$Beta[row] + qt(.975, result$df[row]) * result$SE[row]
      }, error = function(e) note <<- c(note, paste("BikeU contrast:", conditionMessage(e))))
      boundary <- as.numeric(nlme::VarCorr(fit)[1L, "Variance"]) < 1e-6 * sigma(fit)^2
      phase_comparisons <- tryCatch(h4_phase_contrasts(fit, phase$ParticipantID),
        error = function(e) { note <<- c(note, paste("Phase contrasts:", conditionMessage(e))); NULL })
    }
  }
  result$low_df_flag <- is.finite(result$df) & result$df < 4
  result$transformation <- if (outcome %in% hrv_log_outcomes()) "natural log before phase averaging" else "native"
  result$n <- nrow(phase)
  result$n_participants <- nlevels(phase$ParticipantID)
  status <- data.frame(equation_id = equation_id, outcome = outcome, success = success,
    n = nrow(phase), n_participants = nlevels(phase$ParticipantID),
    min_epochs_per_phase = if (nrow(phase)) min(phase$epochs) else 0,
    max_epochs_per_phase = if (nrow(phase)) max(phase$epochs) else 0,
    coefficients = ncol(design), full_rank = full_rank, max_VIF = max(vif),
    high_VIF = max(vif) >= H4_SPEC$vif_threshold, boundary_variance = boundary,
    worst_term = names(vif)[which.max(vif)], condition_index = kappa(design, exact = TRUE),
    term_vif_equivalents = paste(names(vif), signif(vif, 6), sep = "=", collapse = ";"),
    note = if (length(note)) paste(unique(note), collapse = "; ") else "Completed")
  if (!is.null(phase_comparisons)) {
    phase_comparisons$equation_id <- equation_id
    phase_comparisons$outcome <- outcome
  }
  vif_table <- attr(vif, "gvif_table")
  vif_table$equation_id <- equation_id
  vif_table$outcome <- outcome
  coverage <- phase[, c("ParticipantID", "PhaseID", "epochs")]
  coverage$equation_id <- equation_id
  coverage$outcome <- outcome
  list(coefficients = result, status = status, contrasts = phase_comparisons,
    vif = vif_table, coverage = coverage)
}

run_h4_phaseavg <- function() {
  raw <- read.csv(RAW_DATA_PATH, check.names = FALSE)
  for (variable in setdiff(names(average_sources), names(raw)))
    raw[[variable]] <- rowMeans(raw[, average_sources[[variable]], drop = FALSE], na.rm = TRUE)
  audit <- read.csv(file.path(SHARED_AUDIT_DIR, "H4_Multivariate_Filtration_Results.csv"), check.names = FALSE)
  prepared <- h4_step4_exposure_prep(audit, raw)
  results <- list()
  for (equation_id in equation_spec$equation_id) {
    for (outcome in H4_SPEC$all_outcomes)
      results[[length(results) + 1L]] <- fit_h4_phase_mean(equation_id, outcome, prepared$raw_df)
    cat(sprintf("Phase means: equation %d/%d complete\n", equation_id, nrow(equation_spec)))
  }
  coefficients <- do.call(rbind, lapply(results, `[[`, "coefficients"))
  status <- do.call(rbind, lapply(results, `[[`, "status"))
  coefficients <- h4_coefficient_fdr(coefficients, coefficients$equation_id, coefficients$term,
    coefficients$p, is.finite(coefficients$p), H4_SPEC$all_outcomes)
  failed <- !is.finite(coefficients$p)
  index <- match(paste(coefficients$equation_id, coefficients$outcome), paste(status$equation_id, status$outcome))
  coefficients$inference_status[failed] <- ifelse(status$note[index[failed]] == "Completed",
    "Not estimable: CR2 p-value or degrees of freedom unavailable", paste("Not estimable:", status$note[index[failed]]))
  coefficients$term <- sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", coefficients$term)
  report <- c("# H4 phase-average sensitivity", "",
    "All seven fixed-effect equations are read directly from H4_multivariate.R. No terms are selected using these results.",
    "The same matched eight-minute input as H4_multivariate.R is averaged over each participant-phase; this does not change to the full-duration input. Participant random intercept, REML, participant-cluster CR2/Satterthwaite inference; no temporal AR(1).",
    "Epoch eligibility and SVF endpoint carry-forward follow H4 time-series preparation. Each model averages predictors and outcome over identical observed epochs.",
    "Natural-log HRV outcomes are logged before averaging. Exposures are centered within participant across phase means and scaled by pooled SD before forming interactions.",
    "These are phase-mean associations, not within-bout fluctuations. Interactions are products of phase means, not means of epoch interaction products.",
    "q: BH across 26 planned outcomes per term/equation. q_equation: BH across all non-intercept terms and outcomes within equation. No correction across equations.",
    "High VIF, boundary variance, low df, missing phases and warnings remain visible; no automatic variable removal or uncorrelated fallback.", "",
    sprintf("Models with estimates: %d/%d; high-VIF designs: %d; low-df coefficient rows: %d.",
      sum(status$success), nrow(status), sum(status$high_VIF), sum(coefficients$low_df_flag)),
    sprintf("Per-term q<.05: %d; equation-wide q<.05: %d. Counts include exploratory adjustment/phase terms.",
      sum(coefficients$q < .05, na.rm = TRUE), sum(coefficients$q_equation < .05, na.rm = TRUE)))
  h4_write_phase_results(results, coefficients, status, report, audit, prepared, SHARED_AUDIT_DIR)
}

if (sys.nframe() == 0L) run_h4_phaseavg()

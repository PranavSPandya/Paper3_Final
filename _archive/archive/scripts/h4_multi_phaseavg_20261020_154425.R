# H4 phase-average LME sensitivity (engine: H4_core.R)
suppressPackageStartupMessages({
  library(ggplot2)
  library(gridExtra)
})

required_packages <- c("ggplot2", "gridExtra", "car", "nlme", "clubSandwich")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)
grDevices::pdf(file = NULL)

script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
SCRIPT_DIR <- if (length(script_arg)) {
  dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE))
} else {
  wd <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
  if (basename(wd) == "scripts") wd else file.path(wd, "scripts")
}
source(file.path(SCRIPT_DIR, "Paper3_common.R"), local = FALSE)

PROJECT_ROOT <- resolve_project_root()
H4_SCRIPT_PATH <- if (length(script_arg) && file.exists(script_arg[1])) script_arg[1] else file.path(PROJECT_ROOT, "scripts/h4_multi_phaseavg.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))

# Cohort, phase and outcome specification
# physiological: 26 fitted outcomes (indices 1-13 empatica, 14-26 eyetracker).
# Slice examples: empatica only [1:13]; eyetracker only [14:26]; HRV log-transform subset = attr(..., "hrv_log").
H4_SPEC <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = c("BikeU", "BikeG", "WalkU", "WalkG"),
  outcomes = list(physiological = paper3_physiological_outcomes()),
  vif_threshold = 5,
  expected_epochs = 49L,
  # Eq 2 (sound sensitivity) is in the design/VIF catalog; Step 5 fits it when TRUE (default).
  fit_sound_sensitivity = TRUE
)

stopifnot(length(H4_SPEC$outcomes$physiological) == 26L)
H4_SPEC$all_outcomes <- H4_SPEC$outcomes$physiological
H4_SPEC$h4_1_outcomes <- H4_SPEC$all_outcomes

hrv_log_outcomes <- function() attr(H4_SPEC$outcomes$physiological, "hrv_log")
hrv_fd_outcomes <- function() attr(H4_SPEC$outcomes$physiological, "hrv_fd")

# Data-prep metadata (outcome_transform, bilateral_sources) is set in H4_core.R when sourced.


# ==============================================================================
# SEVEN EXPLICIT PHASE-AVERAGE LME MODELS (PRIMARY & SENSITIVITY)
# ==============================================================================

# Family-wise PCA sound mains for Eq 2 (Sound_screening_pca_vif.md); Eq 1 structure unchanged.
# ucm_SND_dBA stays in heat × sound; MRT × sound is Eq 3 only; these five are additional mains only.
H4_EQ2_SOUND_MAIN_TERMS <- c(
  "vehicle_prop", "freq_prop_20_125", "wind_prop", "spectral_centroid_hz", "mechanisms_prop"
)

# UTCI in rows 1–2, 6–7: Eq1 primary; Eq2 sound sensitivity on UTCI+PM2.5; Eqs 6–7 PM size on UTCI.
equation_spec <- data.frame(
  equation_id = 1:7,
  heat_key = c("UTCI", "UTCI", "AIR_T_mid + AIR_RH + WIND_AWS", "HUMIDEX", "PET", "UTCI", "UTCI"),
  pm = c("atmo_pm2.5_avg", "atmo_pm2.5_avg", rep("atmo_pm2.5_avg", 3), "atmo_pm1_avg", "atmo_pm10_avg"),
  role = c("primary", "sound_sensitivity", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity",
    "pm_size_sensitivity", "pm_size_sensitivity"),
  stringsAsFactors = FALSE
)

# One mean per participant-phase; participant random intercept.
# No temporal AR(1) with one observation per phase.
# Eq 1 (Primary Model): UTCI * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq 2 (Sound sensitivity): Eq 1 + five family-wise PCA-screened sound mains (traffic, low-freq band, wind, spectral centroid, mechanisms)
Eq2 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + vehicle_prop + freq_prop_20_125 + wind_prop + spectral_centroid_hz + mechanisms_prop + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq 3 (Heat sensitivity — mid air temp, RH, wind): AIR_T_mid * Sound + RH * Sound + wind * Sound + MRT * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq3 <- quote(nlme::lme(
  Y ~ ucm_AIR_T_mid * ucm_SND_dBA + ucm_AIR_RH * ucm_SND_dBA + ucm_WIND_AWS * ucm_SND_dBA + ucm_MRT * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq 4 (Heat sensitivity — HUMIDEX): HUMIDEX * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq4 <- quote(nlme::lme(
  Y ~ ucm_HUMIDEX * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq 5 (Heat sensitivity — PET): PET * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq5 <- quote(nlme::lme(
  Y ~ ucm_PET * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq 6 (PM size sensitivity — PM1): UTCI * Sound + solar irradiance + SVF (sky view) + PM1 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq6 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm1_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Eq 7 (PM size sensitivity — PM10): UTCI * Sound + solar irradiance + SVF (sky view) + PM10 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq7 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm10_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID,
  method = "REML",
  na.action = na.fail,
  control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)
))

# Pipeline validation: fixed-effect order parsed from the seven formulas above (not edited separately).
h4_fixed_terms_from_lme_quote <- function(lme_quote) {
  fml <- as.formula(lme_quote[[2L]])
  gsub("`", "", attr(terms(fml), "term.labels"), fixed = TRUE)
}
H4_EQUATION_FIXED <- list(
  `1` = h4_fixed_terms_from_lme_quote(Eq1),
  `2` = h4_fixed_terms_from_lme_quote(Eq2),
  `3` = h4_fixed_terms_from_lme_quote(Eq3),
  `4` = h4_fixed_terms_from_lme_quote(Eq4),
  `5` = h4_fixed_terms_from_lme_quote(Eq5),
  `6` = h4_fixed_terms_from_lme_quote(Eq6),
  `7` = h4_fixed_terms_from_lme_quote(Eq7)
)
stopifnot(identical(H4_EQ2_SOUND_MAIN_TERMS, setdiff(H4_EQUATION_FIXED[["2"]], H4_EQUATION_FIXED[["1"]])))
# MRT × SND_dBA interaction is Eq 3 only; Eq 3 heat air term is mid-height temperature.
stopifnot(
  identical(
    vapply(H4_EQUATION_FIXED, function(terms) any(terms %in% c("ucm_MRT:ucm_SND_dBA", "ucm_SND_dBA:ucm_MRT")), logical(1)),
    c(`1` = FALSE, `2` = FALSE, `3` = TRUE, `4` = FALSE, `5` = FALSE, `6` = FALSE, `7` = FALSE)
  ),
  any(grepl("^ucm_AIR_T_mid", H4_EQUATION_FIXED[["3"]], fixed = FALSE)),
  !any(grepl("ucm_AIR_temp", unlist(H4_EQUATION_FIXED), fixed = TRUE))
)

# Phase means, participant-cluster inference and model diagnostics
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
      eval(get(paste0("Eq", equation_id)), envir = list(model_data = phase)),
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

# ==============================================================================
# WORKFLOW
# ==============================================================================
run_h4_phaseavg <- function() {
  H4_ANALYSIS_MODE <<- "phaseavg"
  source(file.path(SCRIPT_DIR, "H4_core.R"), local = FALSE)
  rm("H4_ANALYSIS_MODE", envir = .GlobalEnv)
  PHASE_OUTPUT_DIR <<- RESULT_DIR
  SHARED_AUDIT_DIR <<- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results/timeseries")
  cat("Running H4: Phase-average sensitivity\n")
  cat(sprintf("Participants (%d): %s\n", length(H4_SPEC$participants), paste(H4_SPEC$participants, collapse = ", ")))
  cat(sprintf("Outcomes (%d); equations (%d)\n\n", length(H4_SPEC$all_outcomes), nrow(equation_spec)))
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
    "All seven fixed-effect equations match H4_multivariate.R. No terms are selected using these results.",
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

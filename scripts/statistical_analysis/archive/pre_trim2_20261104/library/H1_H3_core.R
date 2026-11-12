# H1-H3 engine: load, fit, FDR and CSV outputs; sourced by H1_H3_phaseavg.R and H1_H3_timeseries.R.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H1_H3_core.R (source scripts/statistical_analysis/H1_H3_phaseavg.R).", call. = FALSE)
}
for (spec_name in c("study_wide_spec", "h1_hypothesis_spec", "h2_hypothesis_spec", "h3_hypothesis_spec")) {
  if (!exists(spec_name, envir = .GlobalEnv, inherits = FALSE))
    stop(spec_name, " must be set before sourcing H1_H3_core.R.", call. = FALSE)
}
PAPER3_TIME_SERIES_ENGINE <- isTRUE(get0("PAPER3_TIME_SERIES_ENGINE", envir = .GlobalEnv, ifnotfound = FALSE))
stopifnot(identical(h1_hypothesis_spec$physiological_outcome_names, h3_hypothesis_spec$physiological_outcome_names),
          identical(h1_hypothesis_spec$physiological_outcome_names, h2_hypothesis_spec$physiological_outcome_names))

# End-of-phase questionnaire items (H2 rmcorr; H1/H3 questionnaire contrasts).
h2_hypothesis_spec$psychological_outcomes <- c(
  # Comfort / affect (single items)
  "questionnaire_current_comfort_1_7",
  "questionnaire_space_familiarity_1_5",
  "questionnaire_pleasantness_1_5",
  # Environmental comfort (five dimensions, no overall mean)
  "questionnaire_thermal_comfort_1_5",
  "questionnaire_acoustic_comfort_1_5",
  "questionnaire_visual_comfort_1_5",
  "questionnaire_air_quality_comfort_1_5",
  "questionnaire_odor_comfort_1_5",
  # STAI-6 items (higher = more anxiety; the overall mean is left out)
  "questionnaire_stai_calm_rev_1_5",
  "questionnaire_stai_tense_1_5",
  "questionnaire_stai_upset_1_5",
  "questionnaire_stai_relaxed_rev_1_5",
  "questionnaire_stai_content_rev_1_5",
  "questionnaire_stai_worried_1_5",
  # PRS-11 (four subscales; no total mean)
  "questionnaire_prs11_fascination_mean_1_5",
  "questionnaire_prs11_being_away_mean_1_5",
  "questionnaire_prs11_coherence_mean_1_5",
  "questionnaire_prs11_scope_mean_1_5")

# Input paths and outputs
RAW_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
if (basename(RAW_PATH) != "merged_all_11participants_8min.csv") {
  stop("H1_H3_phaseavg.R must use merged_all_11participants_8min.csv only.")
}
# Output: results/H1_H3_phaseavg/, or results/H1_H3_timeseries/ for the time-series engine.
RESULTS_ROOT <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results")
OUT_DIR <- if (PAPER3_TIME_SERIES_ENGINE) {
  file.path(RESULTS_ROOT, "H1_H3_timeseries")
} else {
  Sys.getenv("PAPER3_OUT_DIR", file.path(RESULTS_ROOT, "H1_H3_phaseavg"))
}
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
pa_out_path <- function(prefix, filename) file.path(OUT_DIR, paste0(prefix, "_", filename))

PARTICIPANTS <- study_wide_spec$participants
CORE_PHASES <- study_wide_spec$phases
MATCHED_CAP_SEC <- study_wide_spec$matched_cap_sec
h1_contrasts <- h1_hypothesis_spec$contrasts
h3_contrasts <- h3_hypothesis_spec$contrasts
study_wide_spec <- paper3_ensure_outcome_normalization(study_wide_spec, PROJECT_ROOT)
physio_groups <- paper3_physiological_outcome_groups(study_wide_spec$physiological_outcome_names)
OUTCOMES <- list(
  Psychological = h2_hypothesis_spec$psychological_outcomes,
  Physiological_Autonomic = physio_groups$empatica,
  Physiological_Ocular = physio_groups$eyetracker)
outcome_group_map <- setNames(
  rep(names(OUTCOMES), vapply(OUTCOMES, length, integer(1))),
  unlist(OUTCOMES, use.names = FALSE))
# Units of the raw participant-phase means (from column-name suffixes and labels); H2 uses ln units for the HRV_LOG outcomes.
OUTCOME_UNITS <- c(
  questionnaire_current_comfort_1_7 = "rating scale points (1-7)",
  questionnaire_space_familiarity_1_5 = "rating scale points (1-5)",
  questionnaire_pleasantness_1_5 = "rating scale points (1-5)",
  questionnaire_thermal_comfort_1_5 = "rating scale points (1-5)",
  questionnaire_acoustic_comfort_1_5 = "rating scale points (1-5)",
  questionnaire_visual_comfort_1_5 = "rating scale points (1-5)",
  questionnaire_air_quality_comfort_1_5 = "rating scale points (1-5)",
  questionnaire_odor_comfort_1_5 = "rating scale points (1-5)",
  questionnaire_stai_calm_rev_1_5 = "rating scale points (1-5; oriented)",
  questionnaire_stai_tense_1_5 = "rating scale points (1-5)",
  questionnaire_stai_upset_1_5 = "rating scale points (1-5)",
  questionnaire_stai_relaxed_rev_1_5 = "rating scale points (1-5; oriented)",
  questionnaire_stai_content_rev_1_5 = "rating scale points (1-5; oriented)",
  questionnaire_stai_worried_1_5 = "rating scale points (1-5)",
  questionnaire_prs11_fascination_mean_1_5 = "rating scale points (subscale mean, 1-5)",
  questionnaire_prs11_being_away_mean_1_5 = "rating scale points (subscale mean, 1-5)",
  questionnaire_prs11_coherence_mean_1_5 = "rating scale points (subscale mean, 1-5)",
  questionnaire_prs11_scope_mean_1_5 = "rating scale points (subscale mean, 1-5)",
  empatica_heart_rate = "bpm", empatica_eda_tonic = "uS (microsiemens)",
  empatica_eda_phasic = "uS (microsiemens)", empatica_skin_temperature = "degC", empatica_hrv_td_sdnn = "ms",
  empatica_hrv_td_rmssd = "ms", empatica_hrv_fd_lf = "ms^2", empatica_hrv_fd_hf = "ms^2",
  empatica_hrv_fd_lf_hf_ratio = "unitless (ratio)", empatica_hrv_fd_lfnu = "normalized units (n.u.)", empatica_hrv_fd_hfnu = "normalized units (n.u.)",
  empatica_hrv_fd_vlf = "ms^2", empatica_hrv_fd_total_power = "ms^2", eyetracker_pupil_diameter_avg = "mm",
  eyetracker_pupil_change_rate = "not specified in source data", eyetracker_blink_duration_s = "s", eyetracker_fixation_duration_s = "s",
  eyetracker_fixation_rate = "per s", eyetracker_saccade_duration_s = "s", eyetracker_saccade_amplitude = "deg",
  eyetracker_saccade_peak_velocity = "deg/s", eyetracker_gaze_velocity = "deg/s", eyetracker_gaze_dispersion = "not specified in source data",
  eyetracker_gaze_centrality = "not specified in source data", eyetracker_distance_from_center = "px", eyetracker_eyelid_aperture_avg = "mm")
H2_LOG_UNITS <- c(empatica_hrv_td_sdnn = "ln(ms)", empatica_hrv_td_rmssd = "ln(ms)", empatica_hrv_fd_lf = "ln(ms^2)",
                  empatica_hrv_fd_hf = "ln(ms^2)", empatica_hrv_fd_lf_hf_ratio = "ln(ratio), unitless",
                  empatica_hrv_fd_vlf = "ln(ms^2)", empatica_hrv_fd_total_power = "ln(ms^2)", empatica_eda_tonic = "ln(uS)")
units_of <- function(values) unname(ifelse(!is.na(OUTCOME_UNITS[values]), OUTCOME_UNITS[values], "not specified in source data"))

wald_ci95 <- function(beta, se, df) {
  out <- c(low = NA_real_, high = NA_real_)
  if (!is.finite(beta) || !is.finite(se) || !is.finite(df) || se < 0 || df <= 0) return(out)
  q <- qt(0.975, df)
  c(low = beta - q * se, high = beta + q * se)
}

infer_ci95_from_summary_row <- function(row, estimate_col = "estimate") {
  est <- if (estimate_col %in% names(row)) row[[estimate_col]] else row[["Value"]]
  se <- row[["SE"]]
  if (is.null(se) && "Std.Error" %in% names(row)) se <- row[["Std.Error"]]
  df <- row[["df"]]
  if (is.null(df) && "DF" %in% names(row)) df <- row[["DF"]]
  if ("lower.CL" %in% names(row) && is.finite(row[["lower.CL"]]))
    return(c(low = row[["lower.CL"]], high = row[["upper.CL"]]))
  if ("asymp.LCL" %in% names(row) && is.finite(row[["asymp.LCL"]]))
    return(c(low = row[["asymp.LCL"]], high = row[["asymp.UCL"]]))
  wald_ci95(est, se, df)
}

# 2. Helper functions
safe_rbind <- function(x) if (length(x) > 0) do.call(rbind, x) else data.frame()

safe_write_csv <- function(data, path) {
  ok <- tryCatch({ write.csv(data, path, row.names = FALSE, na = ""); TRUE }, error = function(local_error) {
    warning(sprintf("File locked by Excel or another process: %s. Attempting fallback...", path)); FALSE })
  if (!ok) tryCatch(write.csv(data, sub("\\.csv$", "_latest.csv", path), row.names = FALSE, na = ""), error = function(local_error) NULL)
}

# Temporal sensitivity companion: rows with BH-FDR q < 0.05 on the primary 10 s fixed-effect term (FDR_significant).
write_temporal_sensitivity_fdr_subset <- function(table, path_without_suffix) {
  if (is.null(table) || nrow(table) == 0 || !"FDR_significant" %in% names(table)) return(invisible(NULL))
  fdr_only <- table[table$FDR_significant %in% TRUE, , drop = FALSE]
  safe_write_csv(fdr_only, paste0(path_without_suffix, "_FDR.csv"))
  invisible(fdr_only)
}

# By default only the combined files are saved; PAPER3_WRITE_DETAILS=1 also writes the per-hypothesis files.
H1_H3_WRITE_DETAILS <- identical(Sys.getenv("PAPER3_WRITE_DETAILS", unset = ""), "1")
h1_h3_bind_fill <- function(tables, label_col = NULL, labels = NULL) {
  parts <- list()
  for (index in seq_along(tables)) {
    t <- tables[[index]]
    if (is.null(t) || !is.data.frame(t) || !nrow(t)) next
    if (!is.null(label_col)) {
      lab <- stats::setNames(data.frame(rep(labels[[index]], nrow(t)), stringsAsFactors = FALSE), label_col)
      t <- cbind(lab, t)
    }
    parts[[length(parts) + 1L]] <- t}
  if (!length(parts)) return(data.frame())
  cols <- unique(unlist(lapply(parts, names)))
  do.call(rbind, lapply(parts, function(t) {
    for (cc in setdiff(cols, names(t))) t[[cc]] <- NA
    t[, cols, drop = FALSE]
  }))
}

audit_row <- function(analysis, condition, outcome, predictor, status, n_rows, n_participants, warn = "", err = "")
  data.frame(Analysis = analysis, Condition = condition, Outcome = outcome, Predictor = predictor, Status = status,
             N_rows = n_rows, N_participants = n_participants, Temporal_Rho_Not_Used = NA_real_, Warning = warn, Error = err,
             stringsAsFactors = FALSE)

fit_phase_lmm <- function(model_call, data) {
  model_call[[2L]][[2L]] <- as.name("outcome_z")
  model_call$data <- quote(data)
  model_call$na.action <- quote(na.omit)
  model_call$control <- quote(lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = TRUE))
  tryCatch(
    eval(model_call),
    error = function(local_error) NULL)
}

model_data_ok <- function(data, outcome, min_rows, min_participants) {
  if (!outcome %in% names(data)) return(FALSE)
  x <- data[[outcome]]
  nrow(data) >= min_rows && length(unique(data$ParticipantID)) >= min_participants &&
    is.finite(sd(x, na.rm = TRUE)) && sd(x, na.rm = TRUE) != 0}

within_person_z <- get0("PAPER3_OUTCOME_WITHIN_PERSON_Z", envir = .GlobalEnv, ifnotfound = paper3_within_person_z)

# H1/H3 effect size: paired SMD (Bonett 2008) via statpsych::ci.stdmean.ps on participant-phase means; p/q come from the LMM.
paired_smd <- function(analysis_data, outcome, ref, comp) {
  na3 <- c(g = NA_real_, low = NA_real_, high = NA_real_)
  if (!outcome %in% names(analysis_data)) return(na3)
  paired_data <- merge(analysis_data[ref, c("ParticipantID", outcome)], analysis_data[comp, c("ParticipantID", outcome)],
             by = "ParticipantID", suffixes = c(".ref", ".comp"))
  x <- as.numeric(paired_data[[2]]); y <- as.numeric(paired_data[[3]])
  ok <- is.finite(x) & is.finite(y); x <- x[ok]; y <- y[ok]
  if (length(x) < 4 || sd(x) == 0 || sd(y) == 0) return(na3)
  ci <- statpsych::ci.stdmean.ps(0.05, mean(y), mean(x), sd(y), sd(x), cor(x, y), length(x))
  c(g = ci[1, "adj Estimate"], low = ci[1, "LL"], high = ci[1, "UL"])
}

# Sensitivity check: exact sign-flip test on the paired differences of the values the LMM uses (the LMM p/q stay the main result).
signflip_paired <- function(analysis_data, value_col, ref, comp, beta) {
  out <- c(p = NA_real_, n = 0, frac = NA_real_)
  if (!value_col %in% names(analysis_data)) return(out)
  paired_data <- merge(analysis_data[ref, c("ParticipantID", value_col)], analysis_data[comp, c("ParticipantID", value_col)],
             by = "ParticipantID", suffixes = c(".ref", ".comp"))
  x <- as.numeric(paired_data[[2]]); y <- as.numeric(paired_data[[3]])
  ok <- is.finite(x) & is.finite(y); diff <- y[ok] - x[ok]; n <- length(diff)
  out["n"] <- n
  if (n > 0 && is.finite(beta)) out["frac"] <- mean(sign(diff) == sign(beta))
  if (n >= 2 && any(diff != 0)) {
    sign_matrix <- as.matrix(expand.grid(rep(list(c(-1, 1)), n)))   # all 2^n sign vectors; last row = observed (all +1)
    t_perm <- abs(drop(sign_matrix %*% diff)) / n
    out["p"] <- mean(t_perm >= t_perm[nrow(sign_matrix)] - 1e-12)
  }
  out}

extract_phase_lmm_contrasts <- function(fit, analysis_data, outcome, family_set, value_col) {
  contrast_rows <- rbind(h1_contrasts, h3_contrasts)
  lv <- levels(analysis_data$PhaseID)
  wvec <- function(plus, minus) { w <- setNames(rep(0, length(lv)), lv); w[plus] <- 1; w[minus] <- -1; unname(w) }
  em <- emmeans(fit, ~ PhaseID)
  cm <- setNames(lapply(seq_len(nrow(contrast_rows)), function(index)
    wvec(contrast_rows$Comparison_PhaseID[index], contrast_rows$Reference_PhaseID[index])), contrast_rows$Contrast)
  cc <- as.data.frame(summary(contrast(em, method = cm), infer = c(TRUE, TRUE)))
  # Difference of differences across the 2x2 layout: (BikeG - BikeU) - (WalkG - WalkU)
  ii <- as.data.frame(summary(contrast(em, method = list(DiD = wvec(c("BikeG", "WalkU"), c("BikeU", "WalkG")))),
                              infer = c(TRUE, TRUE)))
  int_txt <- sprintf("(BikeG - BikeU) - (WalkG - WalkU) = %.3f, t(%d) = %.2f, p = %.4f",
                     ii$estimate, round(ii$df), ii$t.ratio, ii$p.value)
  do.call(rbind, lapply(seq_len(nrow(contrast_rows)), function(index) {
    key <- contrast_rows[index, ]
    ref <- analysis_data$PhaseID == key$Reference_PhaseID; comp <- analysis_data$PhaseID == key$Comparison_PhaseID
    es <- paired_smd(analysis_data, outcome, ref, comp)
    est <- cc$estimate[index]
    beta_ci <- infer_ci95_from_summary_row(cc[index, , drop = FALSE])
    sf <- signflip_paired(analysis_data, "outcome_z", ref, comp, est)   # same response as the model (outcome_z)
    data.frame(
      Hypothesis = key$Hypothesis, Sub_Hypothesis = key$Sub_Hypothesis, Contrast = key$Contrast,
      Reference_PhaseID = key$Reference_PhaseID, Comparison_PhaseID = key$Comparison_PhaseID,
      Outcome = outcome,
      Beta = est, SE = cc$SE[index], df = cc$df[index], t_ratio = cc$t.ratio[index], p_value = cc$p.value[index],
      Beta_CI95_low = unname(beta_ci["low"]), Beta_CI95_high = unname(beta_ci["high"]),
      Reference_Mean_raw = mean(analysis_data[[outcome]][ref], na.rm = TRUE),
      Comparison_Mean_raw = mean(analysis_data[[outcome]][comp], na.rm = TRUE),
      N_Participants = length(intersect(analysis_data$ParticipantID[ref], analysis_data$ParticipantID[comp])),
      SMD_paired_Bonett = unname(es["g"]), SMD_CI95_low = unname(es["low"]), SMD_CI95_high = unname(es["high"]),
      Model_Formula = sprintf("lme(%s ~ PhaseID, random = ~1 | ParticipantID); Beta = %s - %s",
                              value_col, key$Comparison_PhaseID, key$Reference_PhaseID),
      Interaction_Test = int_txt,
      Normalization = if (startsWith(value_col, "within_person_z__")) "Sensitivity: within-person z-score over the 4 PhaseIDs (after notebook transform)" else "Primary: analysis units (notebook transform), random intercept",
      Family_Set = family_set, Contrast_ID = key$Contrast,
      SignFlip_p = unname(sf["p"]), N_Complete_Pairs = as.integer(sf["n"]), Fraction_In_Effect_Direction = unname(sf["frac"]),
      stringsAsFactors = FALSE)
  }))
}

adjust_by_family <- function(tab, family_size_map) {
  if (nrow(tab) == 0) return(tab)
  tab$Correction_Family <- paste(tab$Hypothesis, tab$Family_Set, tab$Contrast_ID, tab$Normalization, sep = "__")
  tab$q_FDR <- NA_real_
  tab$Family_Size <- NA_integer_
  if ("SignFlip_p" %in% names(tab)) tab$SignFlip_q <- NA_real_
  for (fam in unique(tab$Correction_Family)) {
    idx <- which(tab$Correction_Family == fam)
    fs <- as.character(tab$Family_Set[idx[1]])
    planned_n <- max(if (fs %in% names(family_size_map)) as.integer(family_size_map[[fs]]) else 0L, sum(!is.na(tab$p_value[idx])))
    tab$q_FDR[idx] <- p.adjust(tab$p_value[idx], method = "BH", n = planned_n)
    tab$Family_Size[idx] <- planned_n
    if ("SignFlip_p" %in% names(tab)) tab$SignFlip_q[idx] <- p.adjust(tab$SignFlip_p[idx], method = "BH", n = planned_n)   # same family and n as q_FDR
  }
  tab$FDR_significant <- !is.na(tab$q_FDR) & tab$q_FDR < 0.05
  tab}

# Fits with a fixed-effect SE above 10 on the z scale are unusable; they are reported but not tested.
H1_H3_DEGENERATE_SE_LIMIT <- 10
H1_H3_DEGENERATE_NOTE <- "degenerate fit (fixed-effect SE > 10 on the within-person z scale)"
h1_h3_degenerate_fit <- function(t_table) {
  if (is.null(t_table) || !"Std.Error" %in% colnames(t_table)) return(FALSE)
  se <- t_table[, "Std.Error"]
  any(!is.finite(se)) || any(se > H1_H3_DEGENERATE_SE_LIMIT)}

# Outcome-only 10 s / 60 s AR(1) temporal models (shared by H1_H3_phaseavg.R and H1_H3_timeseries.R).
fit_ar1_with_fallback <- function(epoch_data, step_variable) {
  model_10s <- get0("TimeSeries_Temporal_AR1_10s_LMM", envir = .GlobalEnv, ifnotfound = NULL)
  model_60s <- get0("TimeSeries_Temporal_AR1_60s_LMM", envir = .GlobalEnv, ifnotfound = NULL)
  model_call <- if (step_variable == "time_10s_step") {
    if (!is.null(model_10s)) model_10s else H1_Temporal_AR1_10s_LMM
  } else {
    if (!is.null(model_60s)) model_60s else H1_Temporal_AR1_60s_LMM}
  ar1_formula <- formula(eval(model_call$correlation))
  fit_one <- function(optimizer, is_primary) {
    control_settings <- if (is_primary) lmeControl(opt = "optim", maxIter = 200, msMaxIter = 200, returnObject = TRUE) else
      lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = optimizer)
    ar1_correlation <- if (is_primary) corAR1(form = ar1_formula) else corAR1(value = 0.2, form = ar1_formula)
    model_call[[2L]][[2L]] <- as.name("outcome_z")
    model_call$data <- quote(epoch_data)
    model_call$correlation <- quote(ar1_correlation)
    model_call$na.action <- quote(na.omit)
    model_call$control <- quote(control_settings)
    tryCatch(eval(model_call), error = function(local_error) NULL)
  }
  fitted_model <- fit_one("optim", TRUE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "optim (primary)"))
  fitted_model <- fit_one("nlminb", FALSE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "nlminb (fallback, as in Analysis_combined_timeseries.R)"))
  fitted_model <- fit_one("optim", FALSE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "optim (fallback, as in Analysis_combined_timeseries.R)"))
  list(fit = NULL, method = "none (not converged)")
}

ar1_rho <- function(fit) if (is.null(fit)) NA_real_ else tryCatch(as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(local_error) NA_real_)

time_series_result_row <- function(outcome, term_name, formula_template, t_table, column_map, ...) {
  has_term <- !is.null(t_table) && term_name %in% rownames(t_table)
  estimates <- setNames(lapply(column_map, function(column_name) if (has_term) t_table[term_name, column_name] else NA_real_), names(column_map))
  data.frame(Outcome_Group = outcome_group_map[outcome], Outcome = outcome,
             Term = term_name, Model_Formula = sprintf(formula_template, outcome), ..., estimates, stringsAsFactors = FALSE)
}

attach_phase_sum_columns <- function(epoch_data) {
  phase_design_function <- get0("paper3_phase_sum_design", envir = .GlobalEnv, ifnotfound = NULL)
  phase_sum_columns <- get0("TIME_SERIES_PHASE_SUM_COLUMNS", envir = .GlobalEnv, ifnotfound = NULL)
  if (is.null(phase_design_function) || is.null(phase_sum_columns)) return(epoch_data)
  phase_design <- phase_design_function(epoch_data$PhaseID)
  epoch_data[phase_sum_columns] <- phase_design
  if ("time_10s_step" %in% names(epoch_data)) epoch_data$time_10s_step_integer <- as.integer(epoch_data$time_10s_step)
  epoch_data$PhaseID <- factor(as.character(epoch_data$PhaseID), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  epoch_data}

# Linear combinations of the contr.sum(4) columns so Beta = Comparison - Reference (BikeU = -1,-1,-1).
h1_h3_sum_contrast_specs <- function() {
  list(
    list(Hypothesis = "H1", Sub_Hypothesis = "H1.1", Contrast = "BikeU_BikeG",
         Reference_PhaseID = "BikeU", Comparison_PhaseID = "BikeG",
         w = c(PhaseSumWalkG = 1, PhaseSumWalkU = 1, PhaseSumBikeG = 2)),
    list(Hypothesis = "H1", Sub_Hypothesis = "H1.2", Contrast = "WalkU_WalkG",
         Reference_PhaseID = "WalkU", Comparison_PhaseID = "WalkG",
         w = c(PhaseSumWalkG = 1, PhaseSumWalkU = -1, PhaseSumBikeG = 0)),
    list(Hypothesis = "H3", Sub_Hypothesis = "H3.1", Contrast = "BikeU_WalkU",
         Reference_PhaseID = "BikeU", Comparison_PhaseID = "WalkU",
         w = c(PhaseSumWalkG = 1, PhaseSumWalkU = 2, PhaseSumBikeG = 1)),
    list(Hypothesis = "H3", Sub_Hypothesis = "H3.2", Contrast = "BikeG_WalkG",
         Reference_PhaseID = "BikeG", Comparison_PhaseID = "WalkG",
         w = c(PhaseSumWalkG = 1, PhaseSumWalkU = 0, PhaseSumBikeG = -1)))
}

h1_h3_apply_sum_contrast <- function(fit, spec, effect = c("phase_level", "phase_slope")) {
  effect <- match.arg(effect)
  tt <- summary(fit)$tTable
  cn <- rownames(tt)
  suffix <- if (effect == "phase_slope") ":time_min" else ""
  L <- rep(0, length(cn))
  names(L) <- cn
  for (nm in names(spec$w)) {
    term <- paste0(nm, suffix)
    if (!term %in% cn) return(NULL)
    L[term] <- spec$w[[nm]]}
  V <- tryCatch(vcov(fit), error = function(local_error) NULL)
  if (is.null(V)) return(NULL)
  beta <- sum(L * tt[, "Value"])
  se <- sqrt(as.numeric(t(L) %*% V %*% L))
  df <- min(tt[, "DF"], na.rm = TRUE)
  t_ratio <- if (is.finite(se) && se > 0) beta / se else NA_real_
  p_value <- if (is.finite(t_ratio) && is.finite(df)) 2 * pt(-abs(t_ratio), df) else NA_real_
  data.frame(
    Hypothesis = spec$Hypothesis, Sub_Hypothesis = spec$Sub_Hypothesis, Contrast = spec$Contrast,
    Reference_PhaseID = spec$Reference_PhaseID, Comparison_PhaseID = spec$Comparison_PhaseID,
    Effect = effect, Beta = beta, SE = se, df = df, t_ratio = t_ratio, p_value = p_value,
    stringsAsFactors = FALSE)
}

h1_h3_fit_temporal_ar1 <- function(route_epoch_data, sensor_outcomes, model_audit) {
  temporal_results_list <- list()
  temporal_sens_list <- list()
  planned_contrast_list <- list()
  route_epoch_data$time_10s_step <- round(route_epoch_data$time_in_phase_sec / 10)
  route_epoch_data$PhaseID <- factor(route_epoch_data$PhaseID, levels = CORE_PHASES)
  use_phase_sum_coding <- !is.null(get0("TIME_SERIES_PHASE_SUM_COLUMNS", envir = .GlobalEnv, ifnotfound = NULL))
  time_step_key <- paste(route_epoch_data$ParticipantID, route_epoch_data$PhaseID, route_epoch_data$time_10s_step)
  if (anyDuplicated(time_step_key)) stop("Temporal AR(1): ", sum(duplicated(time_step_key)),
    " duplicate participant/phase/10-s steps; fix the epoch grid upstream instead of dropping rows.")
  phase_sum_columns <- get0("TIME_SERIES_PHASE_SUM_COLUMNS", envir = .GlobalEnv, ifnotfound = character(0))
  if (use_phase_sum_coding) {
    formula_template_10s <- paste0("lme(within_person_z__%s ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min, random = ~1 | ParticipantID/PhaseID, ",
                  "corAR1(value=0.2, ~ time_10s_step_integer | ParticipantID/PhaseID)); BikeU implicit (contr.sum); ",
                  "time_min centred at the mean analysed time, so phase terms are differences at mid-bout")
    formula_template_60s <- paste0("lme(mean within_person_z__%s per 60-s epoch ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min, random = ~1 | ParticipantID/PhaseID, ",
                  "corAR1(value=0.2, ~ time_60s_step | ParticipantID/PhaseID)); BikeU implicit (contr.sum); time_min centred as in the 10 s model")
    fixed_effect_terms <- paste0("(", paste(phase_sum_columns, collapse = " + "), ") * time_min")
  } else {
    formula_template_10s <- "lme(within_person_z__%s ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_10s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU"
    formula_template_60s <- "lme(mean within_person_z__%s per 60-s epoch ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_60s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU"
    fixed_effect_terms <- "PhaseID * time_min"}

  for (outcome in sensor_outcomes) {
    z_column <- paste0("within_person_z__", outcome)
    required_columns <- c("ParticipantID", "PhaseID", "time_min", "time_10s_step", z_column)
    complete_rows <- complete.cases(route_epoch_data[, required_columns, drop = FALSE])
    n_na_excluded <- sum(!complete_rows)
    epoch_data <- route_epoch_data[complete_rows, , drop = FALSE]
    epoch_data$outcome_z <- epoch_data[[z_column]]
    # Centre time_min so the phase terms are differences at the mean analysed time, not at bout start.
    if (use_phase_sum_coding) epoch_data$time_min <- epoch_data$time_min - mean(epoch_data$time_min)
    epoch_data <- attach_phase_sum_columns(epoch_data)
    epoch_data <- epoch_data[order(epoch_data$ParticipantID, epoch_data$PhaseID, epoch_data$time_10s_step), ]
    excluded_epochs_note <- sprintf("NA epochs excluded: %d of %d", n_na_excluded, nrow(route_epoch_data))
    n_participants <- length(unique(epoch_data$ParticipantID))
    if (!model_data_ok(epoch_data, "outcome_z", 100, 8)) {
      model_audit[[length(model_audit) + 1]] <- audit_row("Temporal_AR1", "Primary_10s_matched_8min", outcome, fixed_effect_terms,
        "NOT_FIT_INSUFFICIENT_DATA", nrow(epoch_data), n_participants, warn = paste("Insufficient time-series rows;", excluded_epochs_note))
      next}
    fit_result_10s <- fit_ar1_with_fallback(epoch_data, "time_10s_step")
    if (use_phase_sum_coding) {
      design_matrix <- model.matrix(as.formula(paste("~", fixed_effect_terms)), data = epoch_data)
      all_terms <- colnames(design_matrix)[-1L]
    } else {
      all_terms <- colnames(model.matrix(~ PhaseID * time_min, data = epoch_data))[-1]}

    epoch_data_60s <- epoch_data
    epoch_data_60s$time_60s_step <- floor(epoch_data_60s$time_10s_step / 6)
    epoch_data_60s <- aggregate(cbind(outcome_z, time_min) ~ ParticipantID + PhaseID + time_60s_step, data = epoch_data_60s, FUN = mean)
    if (use_phase_sum_coding) {
      epoch_data_60s <- attach_phase_sum_columns(epoch_data_60s)
    } else {
      epoch_data_60s$PhaseID <- factor(epoch_data_60s$PhaseID, levels = CORE_PHASES)
    }
    epoch_data_60s <- epoch_data_60s[order(epoch_data_60s$ParticipantID, epoch_data_60s$PhaseID, epoch_data_60s$time_60s_step), ]
    fit_result_60s <- fit_ar1_with_fallback(epoch_data_60s, "time_60s_step")
    t_table_60s <- if (!is.null(fit_result_60s$fit)) summary(fit_result_60s$fit)$tTable
    status_60s <- if (is.null(fit_result_60s$fit)) "FAILED_CONVERGENCE" else if (h1_h3_degenerate_fit(t_table_60s)) "DEGENERATE_FIT" else "FIT"
    if (status_60s == "DEGENERATE_FIT") t_table_60s[, "p-value"] <- NA_real_
    for (term_name in all_terms) temporal_sens_list[[length(temporal_sens_list) + 1]] <- cbind(
      time_series_result_row(outcome, term_name, formula_template_60s, t_table_60s, c(Beta_60s = "Value", SE_60s = "Std.Error", statistic_60s = "t-value", df_60s = "DF", p_value_60s = "p-value")),
      AR1_phi_60s = ar1_rho(fit_result_60s$fit), Fit_Method_60s = fit_result_60s$method, Status_60s = status_60s, N_epochs_60s = nrow(epoch_data_60s), n_participants_60s = length(unique(epoch_data_60s$ParticipantID)), stringsAsFactors = FALSE)

    status <- if (is.null(fit_result_10s$fit)) "FAILED_CONVERGENCE" else
      if (h1_h3_degenerate_fit(summary(fit_result_10s$fit)$tTable)) "DEGENERATE_FIT" else "FIT"
    model_audit[[length(model_audit) + 1]] <- audit_row("Temporal_AR1", "Primary_10s_matched_8min", outcome, "PhaseID*time_min", status,
      nrow(epoch_data), n_participants, warn = if (status == "FIT") paste0(excluded_epochs_note, "; fit method: ", fit_result_10s$method) else excluded_epochs_note,
      err = if (status == "FIT") "" else if (status == "DEGENERATE_FIT") H1_H3_DEGENERATE_NOTE else "AR(1) model failed to converge (optim, nlminb and optim fallbacks)")
    t_table_10s <- if (status != "FAILED_CONVERGENCE") summary(fit_result_10s$fit)$tTable
    # Degenerate fits are reported (estimates, SE) but not tested: p left blank and excluded from BH.
    if (status == "DEGENERATE_FIT") t_table_10s[, "p-value"] <- NA_real_
    terms <- if (status != "FAILED_CONVERGENCE") setdiff(rownames(t_table_10s), "(Intercept)") else all_terms
    if (status %in% c("FIT", "DEGENERATE_FIT") && use_phase_sum_coding) {
      for (spec in h1_h3_sum_contrast_specs()) {
        for (effect in c("phase_level", "phase_slope")) {
          row <- h1_h3_apply_sum_contrast(fit_result_10s$fit, spec, effect)
          if (!is.null(row)) {
            row$Outcome <- outcome
            row$Status <- status
            if (status == "DEGENERATE_FIT") row$p_value <- NA_real_
            planned_contrast_list[[length(planned_contrast_list) + 1L]] <- row}
        }
      }
    }
    for (term_name in terms) temporal_results_list[[length(temporal_results_list) + 1]] <- cbind(
      time_series_result_row(outcome, term_name, formula_template_10s, t_table_10s, c(Beta = "Value", SE = "Std.Error", t_stat = "t-value", df = "DF", p_value = "p-value"),
             Normalization = "Within-Person Z-score", Duration = "Matched_start_8min"),
      AR1_phi = ar1_rho(fit_result_10s$fit), N_epochs = nrow(epoch_data), N_participants = n_participants, Fit_Method = fit_result_10s$method, Status = status, stringsAsFactors = FALSE)
  }

  temporal_table <- safe_rbind(temporal_results_list)
  temporal_family_size <- length(sensor_outcomes)
  if (nrow(temporal_table) > 0) {
    temporal_table$Family_Size <- temporal_family_size
    temporal_table$q_FDR <- ave(temporal_table$p_value, temporal_table$Term, FUN = function(p) p.adjust(p, method = "BH", n = temporal_family_size))
    temporal_table$FDR_significant <- !is.na(temporal_table$q_FDR) & temporal_table$q_FDR < 0.05
    temporal_table$Stability_Flag <- ifelse(temporal_table$Status == "FAILED_CONVERGENCE", "not converged: no p, not in BH family",
      ifelse(temporal_table$Status == "DEGENERATE_FIT", paste0(H1_H3_DEGENERATE_NOTE, ": no p, not in BH family"),
      ifelse(!is.na(temporal_table$AR1_phi) & temporal_table$AR1_phi > 0.95, "rho > 0.95, interpret cautiously", "")))
    tci <- t(vapply(seq_len(nrow(temporal_table)), function(index) {
      wald_ci95(temporal_table$Beta[index], temporal_table$SE[index], temporal_table$df[index])
    }, numeric(2)))
    temporal_table$Beta_CI95_low <- tci[, 1L]
    temporal_table$Beta_CI95_high <- tci[, 2L]
  }
  temporal_sens_table <- safe_rbind(temporal_sens_list)
  if (nrow(temporal_sens_table) > 0) {
    temporal_sens_table$Family_Size <- temporal_family_size
    temporal_sens_table$q_FDR_60s <- ave(temporal_sens_table$p_value_60s, temporal_sens_table$Term, FUN = function(p) p.adjust(p, method = "BH", n = temporal_family_size))
    temporal_sens_table$FDR_significant_60s <- !is.na(temporal_sens_table$q_FDR_60s) & temporal_sens_table$q_FDR_60s < 0.05
    if ("Beta_60s" %in% names(temporal_sens_table) && "SE_60s" %in% names(temporal_sens_table)) {
      df60 <- if ("df_60s" %in% names(temporal_sens_table)) temporal_sens_table$df_60s else rep(NA_real_, nrow(temporal_sens_table))
      tci60 <- t(vapply(seq_len(nrow(temporal_sens_table)), function(index) {
        wald_ci95(temporal_sens_table$Beta_60s[index], temporal_sens_table$SE_60s[index], df60[index])
      }, numeric(2)))
      temporal_sens_table$Beta_CI95_60s_low <- tci60[, 1L]
      temporal_sens_table$Beta_CI95_60s_high <- tci60[, 2L]}
    primary_columns <- temporal_table[, intersect(c("Outcome", "Term", "Beta", "SE", "df", "Beta_CI95_low", "Beta_CI95_high",
      "p_value", "q_FDR", "FDR_significant", "AR1_phi", "Fit_Method", "Stability_Flag"), names(temporal_table))]
    temporal_sens_table <- merge(primary_columns, temporal_sens_table, by = c("Outcome", "Term"), all = TRUE, sort = FALSE)
    temporal_sens_table$Same_Sign_As_Primary <- sign(temporal_sens_table$Beta) == sign(temporal_sens_table$Beta_60s)
    temporal_sens_table$Primary_Holds_In_60s <- temporal_sens_table$FDR_significant %in% TRUE &
      temporal_sens_table$FDR_significant_60s %in% TRUE & temporal_sens_table$Same_Sign_As_Primary %in% TRUE}
  planned_contrasts <- safe_rbind(planned_contrast_list)
  if (nrow(planned_contrasts) > 0 && "p_value" %in% names(planned_contrasts)) {
    planned_contrasts$q_FDR <- ave(planned_contrasts$p_value, planned_contrasts$Hypothesis, planned_contrasts$Effect,
      FUN = function(p) p.adjust(p, method = "BH"))
    planned_contrasts$Effect_Note <- ifelse(planned_contrasts$Status == "DEGENERATE_FIT",
      paste0(H1_H3_DEGENERATE_NOTE, ": no p, not in BH family"),
      ifelse(planned_contrasts$Effect == "phase_level", "phase difference at the mean analysed time (time_min centred)",
        "difference in per-minute slope"))
  }
  list(temporal_table = temporal_table, temporal_sens_table = temporal_sens_table,
       model_audit = model_audit, planned_contrasts = planned_contrasts)
}

h1_h3_load_route_data <- function() {
  if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
  local_input_data <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
  local_input_data$ParticipantID <- as.character(local_input_data$ParticipantID)
  local_input_data$PhaseID <- as.character(local_input_data$PhaseID)

  missing_participants <- setdiff(PARTICIPANTS, unique(local_input_data$ParticipantID))
  if (length(missing_participants) > 0) stop("Verified 11-participant input is incomplete. Missing: ", paste(missing_participants, collapse = ", "))
  phase_grid <- expand.grid(ParticipantID = PARTICIPANTS, PhaseID = CORE_PHASES, stringsAsFactors = FALSE)
  present_key <- with(local_input_data[local_input_data$ParticipantID %in% PARTICIPANTS & local_input_data$PhaseID %in% CORE_PHASES, ], paste(ParticipantID, PhaseID, sep = "::"))
  missing_cells <- phase_grid[!paste(phase_grid$ParticipantID, phase_grid$PhaseID, sep = "::") %in% present_key, , drop = FALSE]
  if (nrow(missing_cells) > 0) stop("Core within-subject design is incomplete; missing participant-phase cells: ",
    paste(paste(missing_cells$ParticipantID, missing_cells$PhaseID, sep = "/"), collapse = ", "))
  core_time_key <- paste(local_input_data$ParticipantID, local_input_data$PhaseID, local_input_data$Datetime, sep = "::")
  core_idx <- local_input_data$ParticipantID %in% PARTICIPANTS & local_input_data$PhaseID %in% c(CORE_PHASES, "Tram")
  if (anyDuplicated(core_time_key[core_idx])) stop("Duplicate ParticipantID/PhaseID/Datetime keys detected in active/Tram data.")

  pair_map <- list(
    atmo_pm1.0_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
    atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
    atmo_temperature_avg = c("atmo_lys_atmotube_left__atmotube_temperature", "atmo_lys_atmotube_right__atmotube_temperature"),
    atmo_humidity_avg = c("atmo_lys_atmotube_left__atmotube_humidity", "atmo_lys_atmotube_right__atmotube_humidity"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
    lys_rgbb_avg = c("atmo_lys_LYS1__lys_rgbb", "atmo_lys_LYS2__lys_rgbb"),
    lys_rgbg_avg = c("atmo_lys_LYS1__lys_rgbg", "atmo_lys_LYS2__lys_rgbg"),
    lys_rgbr_avg = c("atmo_lys_LYS1__lys_rgbr", "atmo_lys_LYS2__lys_rgbr"),
    lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"),
    lys_medi_avg = c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi"))
  local_input_data <- paper3_add_pair_means(local_input_data, pair_map)

  # Declared outcomes must exist in the merged input; a missing column stops the run (no silent intersect).
  declared_sensor <- c(OUTCOMES$Physiological_Autonomic, OUTCOMES$Physiological_Ocular)
  missing_declared <- setdiff(c(declared_sensor, OUTCOMES$Psychological), names(local_input_data))
  if (length(missing_declared)) stop("Declared H1-H3 outcome column(s) not in the merged input: ", paste(missing_declared, collapse = ", "), call. = FALSE)
  sensor_outcomes <- declared_sensor
  psych_outcomes <- OUTCOMES$Psychological

  route <- local_input_data[local_input_data$ParticipantID %in% PARTICIPANTS & local_input_data$PhaseID %in% CORE_PHASES, ]
  route$Datetime <- as.POSIXct(route$Datetime, tz = "UTC")
  if (anyNA(route$Datetime)) stop("Unparseable Datetime values found in core route data.")
  phase_span <- aggregate(as.numeric(route$Datetime), by = route[c("ParticipantID", "PhaseID")], FUN = function(x) max(x) - min(x))
  bad <- phase_span[phase_span$x > MATCHED_CAP_SEC, ]
  if (nrow(bad)) stop("Input is not the matched 8-min file; phases longer than 480 s: ", paste(bad$ParticipantID, bad$PhaseID, bad$x, sep = "/", collapse = ", "))
  route$ParticipantID <- factor(route$ParticipantID, levels = PARTICIPANTS)
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]

  csv_transform_fn <- get0("PAPER3_APPLY_CSV_TRANSFORM", envir = .GlobalEnv, ifnotfound = NULL)
  csv_table <- study_wide_spec$outcome_transforms_csv
  for (outcome in intersect(sensor_outcomes, names(route))) {
    route[[outcome]] <- if (is.function(csv_transform_fn)) {
      csv_transform_fn(route[[outcome]], outcome)
    } else {
      paper3_apply_csv_transform(route[[outcome]], outcome, csv_table)
    }
  }

  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID, FUN = function(x) x - min(x, na.rm = TRUE))
  route$time_min <- route$time_in_phase_sec / 60

  route <- paper3_merge_common_cap(route, CORE_PHASES, MATCHED_CAP_SEC)
  route$matched_cap_sec <- route$Common_cap
  # Within-person z on the analysed (matched-cap) rows only; other rows get NA.
  in_cap <- !is.na(route$matched_cap_sec) & route$time_in_phase_sec <= route$matched_cap_sec
  for (outcome in unique(c(intersect(sensor_outcomes, names(route)), intersect(psych_outcomes, names(route))))) {
    z <- rep(NA_real_, nrow(route))
    z[in_cap] <- within_person_z(route[[outcome]][in_cap], route$ParticipantID[in_cap])
    route[[paste0("within_person_z__", outcome)]] <- z
  }

  d_cond <- route[!is.na(route$matched_cap_sec) & route$time_in_phase_sec <= route$matched_cap_sec, ]

  list(df = local_input_data, route = route, d_cond = d_cond, cname = "Primary: Matched duration <=8 min",
       sensor_outcomes = sensor_outcomes, psych_outcomes = psych_outcomes)
}

h1_to_h3_pipeline_run <- function() {
  # 3. Data loading and feature engineering
  cat("[1/6] Loading and formatting dataset...\n")
  prep <- h1_h3_load_route_data()
  local_input_data <- prep$df
  d_cond <- prep$d_cond
  cname <- prep$cname
  sensor_outcomes <- prep$sensor_outcomes
  psych_outcomes <- prep$psych_outcomes
  cat("   Input:", RAW_PATH, "\n")
  cat("   Rows/columns:", nrow(local_input_data), "/", ncol(local_input_data), "| Participants:", length(intersect(PARTICIPANTS, unique(local_input_data$ParticipantID))),
      "of", length(PARTICIPANTS), "| Indoor rows:", sum(local_input_data$PhaseID == "Indoor", na.rm = TRUE), "\n")

  # 4. H1 and H3 models (26 physiological outcomes)
  cat("[2/6] Fitting H1 and H3 models across the 26 physiological outcomes (questionnaires: separate FDR family, step 3b)...\n")
  phase_lmm_rows <- list(); model_audit <- list()

  # Participant-phase means: one row per participant x phase (N = 44); questionnaires are constant within a phase.
  all_phase_vars <- intersect(unique(c(sensor_outcomes, psych_outcomes, paste0("within_person_z__", sensor_outcomes), paste0("within_person_z__", psych_outcomes))), names(d_cond))
  phase_df <- aggregate(d_cond[all_phase_vars], by = d_cond[c("ParticipantID", "PhaseID")], FUN = mean_na)
  phase_df$ParticipantID <- factor(phase_df$ParticipantID, levels = PARTICIPANTS)
  phase_df$PhaseID <- factor(phase_df$PhaseID, levels = CORE_PHASES)

  for (family_set in c("Primary", "Sensitivity_WPZ"))
  for (outcome in intersect(sensor_outcomes, names(d_cond))) {   # physio only; questionnaires belong to H2
    value_col <- if (family_set == "Primary") outcome else paste0("within_person_z__", outcome)
    analysis <- paste0("H1_and_H3_phase_mean_", family_set)
    analysis_data <- phase_df[complete.cases(phase_df[, c(value_col, "PhaseID", "ParticipantID")]), ]
    analysis_data$outcome_z <- analysis_data[[value_col]]
    n_pid <- length(unique(analysis_data$ParticipantID))
    model_call <- if (family_set == "Primary") H1_PhaseMean_Primary_LMM else H1_PhaseMean_Sensitivity_WPZ_LMM
    fit <- if (model_data_ok(analysis_data, "outcome_z", 24, 8)) fit_phase_lmm(model_call, analysis_data)
    status <- if (!model_data_ok(analysis_data, "outcome_z", 24, 8)) "NOT_FIT_INSUFFICIENT_DATA" else if (is.null(fit)) "FAILED_CONVERGENCE" else "FIT"
    model_audit[[length(model_audit) + 1]] <- audit_row(analysis, cname, outcome, "PhaseID", status, nrow(analysis_data), n_pid,
      warn = if (status == "NOT_FIT_INSUFFICIENT_DATA") "Fewer than 24 bouts or 8 participants" else "",
      err = if (status == "FAILED_CONVERGENCE") "nlme::lme failed to converge" else "")
    if (status == "FIT") phase_lmm_rows[[length(phase_lmm_rows) + 1]] <- extract_phase_lmm_contrasts(fit, analysis_data, outcome, family_set, value_col)
  }

  phase_lmm_table <- adjust_by_family(safe_rbind(phase_lmm_rows), c(Primary = length(sensor_outcomes), Sensitivity_WPZ = length(sensor_outcomes)))

  # 4D. Time-series mixed models with AR(1)
  cat("[2b/6] Fitting 10-second temporal time-series LMMs with AR(1) autocorrelation...\n")
  temporal_fit <- h1_h3_fit_temporal_ar1(d_cond, sensor_outcomes, model_audit)
  temporal_table <- temporal_fit$temporal_table
  temporal_sens_table <- temporal_fit$temporal_sens_table
  model_audit <- temporal_fit$model_audit

  # 5. H2: rmcorr (Bakdash & Marusich 2017) on participant-phase means, 18 questionnaires x 26 outcomes, one BH family.
  cat("[3/6] Evaluating H2 psychophysiological concurrence models...\n")
  h2_physio_outcomes <- intersect(sensor_outcomes, names(local_input_data))
  h2_psych_outcomes  <- intersect(psych_outcomes, names(local_input_data))
  h2_results_list <- list()
  rm_src <- d_cond[c("ParticipantID", "PhaseID", h2_psych_outcomes, h2_physio_outcomes)]
  rm_ph <- aggregate(rm_src[c(h2_psych_outcomes, h2_physio_outcomes)], by = rm_src[c("ParticipantID", "PhaseID")], FUN = mean_na)
  for (psych_var in h2_psych_outcomes) for (phys_var in h2_physio_outcomes) {
    x <- rm_ph[complete.cases(rm_ph[c(psych_var, phys_var)]), c("ParticipantID", psych_var, phys_var)]
    x <- x[x$ParticipantID %in% names(which(table(x$ParticipantID) >= 2)), , drop = FALSE]
    names(x) <- c("ParticipantID", "psych", "phys")
    x$ParticipantID <- droplevels(factor(x$ParticipantID))
    n_pid <- nlevels(x$ParticipantID)
    if (nrow(x) < 20 || n_pid < 8 || sd(x$phys) == 0) {
      model_audit[[length(model_audit) + 1]] <- audit_row("H2_rmcorr", cname, psych_var, phys_var, "NOT_FIT_INSUFFICIENT_DATA", nrow(x), n_pid,
                                                          warn = "Fewer than 20 bouts or 8 participants")
      next}
    h2_call <- H2_rmcorr
    h2_call[[2L]] <- do.call("substitute", list(h2_call[[2L]], list(
      psychological = as.name("psych"), physiological = as.name("phys"))))
    h2_call$data <- quote(x)
    f_rm <- eval(h2_call)
    cf <- summary(f_rm)$coefficients["phys", ]
    dfr <- f_rm$df.residual
    t_val <- cf[["t value"]]
    r_rm <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + dfr))
    z_ci <- atanh(r_rm) + c(-1, 1) * qnorm(0.975) / sqrt(dfr - 1)   # Fisher-z CI (Bakdash & Marusich 2017)
    model_audit[[length(model_audit) + 1]] <- audit_row("H2_rmcorr", cname, psych_var, phys_var, "FIT", nrow(x), n_pid)
    h2_results_list[[length(h2_results_list) + 1]] <- data.frame(
      Psychological_Measure = psych_var, Physiological_Measure = phys_var,
      Model_Formula = sprintf("rmcorr: lm(%s ~ ParticipantID + %s), Bakdash & Marusich 2017", psych_var, phys_var),
      Beta = cf[["Estimate"]], SE = cf[["Std. Error"]], CI95_low = tanh(z_ci[1]), CI95_high = tanh(z_ci[2]), t_stat = t_val, df = dfr,
      p_value = cf[["Pr(>|t|)"]], Partial_r_Within = r_rm, N_PhaseBouts = nrow(x), N_Participants = n_pid, stringsAsFactors = FALSE)
  }

  h2_table <- safe_rbind(h2_results_list)
  rownames(h2_table) <- NULL
  if (nrow(h2_table) > 0) {
    h2_table$q_FDR <- p.adjust(h2_table$p_value, method = "BH")
    h2_table$FDR_significant <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05
    h2_table$Method_Note <- paste("rmcorr estimates one common within-person slope across the 4 mobility conditions",
      "(Bakdash & Marusich 2017); association includes condition-driven co-variation of psychological and",
      "physiological measures; direction is not uniquely interpretable for context-dependent measures.")}
  # 5a. Restoration concordance: Spearman of Green-minus-Urban delta PRS vs each delta, per mode, one BH family of 6 tests.
  concord_psych <- "questionnaire_prs11_fascination_mean_1_5"
  concord_vars <- c("eyetracker_fixation_rate", "eyetracker_fixation_duration_s", "empatica_eda_tonic")
  concord_delta <- function(paired, column) {
    if (all(paste0(column, c("_U", "_G")) %in% names(paired))) paired[[paste0(column, "_G")]] - paired[[paste0(column, "_U")]] else rep(NA_real_, nrow(paired))
  }
  concord_rows <- list()
  for (concord_mode in c("Bike", "Walk")) {
    concord_U <- phase_df[phase_df$PhaseID == paste0(concord_mode, "U"), , drop = FALSE]
    concord_G <- phase_df[phase_df$PhaseID == paste0(concord_mode, "G"), , drop = FALSE]
    concord_pairs <- merge(concord_U, concord_G, by = "ParticipantID", suffixes = c("_U", "_G"))
    for (concord_var in concord_vars) {
      psych_delta <- concord_delta(concord_pairs, concord_psych)
      outcome_delta <- concord_delta(concord_pairs, concord_var)
      ok <- is.finite(psych_delta) & is.finite(outcome_delta); n_ok <- sum(ok)
      rho <- pval <- NA_real_
      if (n_ok >= 7L && sd(psych_delta[ok]) > 0 && sd(outcome_delta[ok]) > 0) {
        z <- suppressWarnings(cor.test(psych_delta[ok], outcome_delta[ok], method = "spearman", exact = FALSE))
        rho <- unname(z$estimate); pval <- z$p.value}
      concord_rows[[length(concord_rows) + 1L]] <- data.frame(Mode = concord_mode, Psych = "delta_PRS", Outcome = paste0("delta_", concord_var),
        Units = unname(ifelse(!is.na(H2_LOG_UNITS[concord_var]), H2_LOG_UNITS[concord_var], units_of(concord_var))), N = n_ok, rho = rho, p = pval, stringsAsFactors = FALSE)
    }
  }
  concord_table <- safe_rbind(concord_rows)
  concord_table$q <- NA_real_
  concord_ok <- is.finite(concord_table$p)
  concord_table$q[concord_ok] <- p.adjust(concord_table$p[concord_ok], method = "BH", n = 6)

  # 5b. H1/H3 questionnaire contrasts: same phase-mean LMM and Bonett SMD, own BH family per hypothesis x set x contrast.
  cat("[3b/6] Fitting H1 and H3 questionnaire contrasts (separate BH-FDR family)...\n")
  quest_lmm_rows <- list()
  for (family_set in c("Primary", "Sensitivity_WPZ"))
  for (outcome in intersect(psych_outcomes, names(d_cond))) {
    value_col <- if (family_set == "Primary") outcome else paste0("within_person_z__", outcome)
    analysis <- paste0("H1_and_H3_questionnaire_phase_mean_", family_set)
    analysis_data <- phase_df[complete.cases(phase_df[, c(value_col, "PhaseID", "ParticipantID")]), ]
    analysis_data$outcome_z <- analysis_data[[value_col]]
    n_pid <- length(unique(analysis_data$ParticipantID))
    model_call <- if (family_set == "Primary") H1_PhaseMean_Primary_LMM else H1_PhaseMean_Sensitivity_WPZ_LMM
    fit <- if (model_data_ok(analysis_data, "outcome_z", 24, 8)) fit_phase_lmm(model_call, analysis_data)
    status <- if (!model_data_ok(analysis_data, "outcome_z", 24, 8)) "NOT_FIT_INSUFFICIENT_DATA" else if (is.null(fit)) "FAILED_CONVERGENCE" else "FIT"
    model_audit[[length(model_audit) + 1]] <- audit_row(analysis, cname, outcome, "PhaseID", status, nrow(analysis_data), n_pid,
      warn = if (status == "NOT_FIT_INSUFFICIENT_DATA") "Fewer than 24 bouts or 8 participants" else "",
      err = if (status == "FAILED_CONVERGENCE") "nlme::lme failed to converge" else "")
    if (status == "FIT") quest_lmm_rows[[length(quest_lmm_rows) + 1]] <- extract_phase_lmm_contrasts(fit, analysis_data, outcome, family_set, value_col)
  }
  quest_lmm_raw <- safe_rbind(quest_lmm_rows)
  # Questionnaires are not transformed, so only the Normalization label changes.
  if (nrow(quest_lmm_raw) > 0) quest_lmm_raw$Normalization <- ifelse(quest_lmm_raw$Family_Set == "Primary",
    "Primary: raw questionnaire scale (no transform), random intercept",
    "Sensitivity: within-person z-score over the 4 PhaseIDs (raw questionnaire scale, no transform)")
  quest_lmm_table <- adjust_by_family(quest_lmm_raw, c(Primary = length(psych_outcomes), Sensitivity_WPZ = length(psych_outcomes)))
  if (nrow(quest_lmm_table) > 0) quest_lmm_table$Outcome_Family <- "questionnaire"

  # 7. Write CSV tables
  cat("[5/6] Writing corrected, auditable outputs...\n")

  phase_lmm_out <- phase_lmm_table
  phase_lmm_out$Units <- units_of(phase_lmm_out$Outcome)
  phase_lmm_cols <- c("Hypothesis", "Sub_Hypothesis", "Contrast", "Reference_PhaseID", "Comparison_PhaseID",
                "Outcome", "Units",
                "Beta", "SE", "df", "Beta_CI95_low", "Beta_CI95_high", "t_ratio", "p_value", "q_FDR", "FDR_significant", "Family_Size",
                "SMD_paired_Bonett", "SMD_CI95_low", "SMD_CI95_high",
                "Reference_Mean_raw", "Comparison_Mean_raw", "N_Participants",
                "Model_Formula", "Interaction_Test", "Normalization",
                "SignFlip_p", "SignFlip_q", "N_Complete_Pairs", "Fraction_In_Effect_Direction")   # sign-flip sensitivity columns, last
  phase_lmm_clean_table <- phase_lmm_out[, intersect(phase_lmm_cols, names(phase_lmm_out)), drop = FALSE]

  # Questionnaire contrasts (separate BH-FDR family; written to H1_/H3_Questionnaire_Contrasts.csv, not to H1_/H3_Contrasts.csv)
  quest_lmm_out <- quest_lmm_table
  if (nrow(quest_lmm_out) > 0) quest_lmm_out$Units <- units_of(quest_lmm_out$Outcome)
  quest_lmm_cols <- append(phase_lmm_cols, "Outcome_Family", after = match("Outcome", phase_lmm_cols))
  quest_lmm_clean_table <- quest_lmm_out[, intersect(quest_lmm_cols, names(quest_lmm_out)), drop = FALSE]

  h2_table$Questionnaire       <- h2_table$Psychological_Measure
  h2_table$Physio              <- h2_table$Physiological_Measure
  h2_table$Physio_Units        <- unname(ifelse(!is.na(H2_LOG_UNITS[h2_table$Physio]), H2_LOG_UNITS[h2_table$Physio], units_of(h2_table$Physio)))
  h2_cols <- c("Questionnaire", "Physio", "Physio_Units", "Partial_r_Within", "CI95_low", "CI95_high", "Beta", "SE", "t_stat", "df",
               "p_value", "q_FDR", "FDR_significant", "N_PhaseBouts", "N_Participants", "Model_Formula", "Method_Note")
  h2_clean_table <- h2_table[, intersect(h2_cols, names(h2_table)), drop = FALSE]
  names(h2_clean_table)[names(h2_clean_table) == "Partial_r_Within"] <- "r_rmcorr"

  # Per-hypothesis files; H1 and H3 share the same temporal tables, H2 has its own file.
  model_audit_df <- safe_rbind(model_audit)
  if (H1_H3_WRITE_DETAILS) {
  for (hyp in c("H1", "H3")) {
    safe_write_csv(phase_lmm_clean_table[phase_lmm_clean_table$Hypothesis == hyp, , drop = FALSE], pa_out_path(hyp, "Contrasts.csv"))
    safe_write_csv(quest_lmm_clean_table[quest_lmm_clean_table$Hypothesis == hyp, , drop = FALSE], pa_out_path(hyp, "Questionnaire_Contrasts.csv"))
    safe_write_csv(temporal_table, pa_out_path(hyp, "Temporal_TimeSeries_AR1.csv"))
    sens_path <- pa_out_path(hyp, "Temporal_AR1_Sensitivity.csv")
    safe_write_csv(temporal_sens_table, sens_path)
    write_temporal_sensitivity_fdr_subset(temporal_sens_table, sub("\\.csv$", "", sens_path))
  }
  safe_write_csv(h2_clean_table, pa_out_path("H2", "Physio_Psycho_Concordance.csv"))
  safe_write_csv(concord_table, pa_out_path("H2", "Restoration_Concordance_DeltaPRS.csv"))
  safe_write_csv(model_audit_df, pa_out_path("H1_to_H3", "Model_Audit.csv"))
  }
  # Combined files: H1 + H3 contrasts, H2 concordance and the shared temporal AR(1) tables.
  safe_write_csv(h1_h3_bind_fill(list(phase_lmm_clean_table, quest_lmm_clean_table), "Outcome_Type",
    c("Physiological", "Questionnaire")), pa_out_path("H1_H3", "Contrasts.csv"))
  safe_write_csv(h1_h3_bind_fill(list(h2_clean_table, concord_table), "Test",
    c("H2_rmcorr_physio_psycho", "H2_restoration_deltaPRS_spearman")), pa_out_path("H2", "Concordance.csv"))
  temporal_combined <- h1_h3_bind_fill(list(temporal_table, temporal_sens_table), "Analysis",
    c("10s main", "60s sensitivity"))
  if (nrow(temporal_combined)) temporal_combined <- data.frame(Hypothesis = "H1 and H3 (shared PhaseID model)",
    temporal_combined, check.names = FALSE, stringsAsFactors = FALSE)
  safe_write_csv(temporal_combined, pa_out_path("H1_H3", "Temporal_AR1.csv"))

  cat("   H1 and H3 contrasts:", nrow(phase_lmm_clean_table), "rows | H2 pairs:", nrow(h2_clean_table), "rows\n")
  cat("   H1 and H3 questionnaire contrasts (separate BH-FDR family):", nrow(quest_lmm_clean_table), "rows\n")
  cat(sprintf("   Model Audit Logged: %d total attempted models (%d fits, %d non-fits/skips logged)\n",
              nrow(model_audit_df), sum(model_audit_df$Status == "FIT"),
              sum(model_audit_df$Status != "FIT")))
  cat("\nSUCCESS: H1 and H3 pipeline finished (H2 included). H4: scripts/statistical_analysis/Analysis_combined_timeseries.R.\n")
}

tag_hypothesis_rows <- function(result_table, hypothesis_id) {
  if (nrow(result_table) == 0) return(result_table)
  result_table$Hypothesis <- hypothesis_id
  result_table$Analysis_Entry <- paste0(hypothesis_id, "_time_series")
  result_table}

time_series_output_path <- function(filename) {
  file.path(OUT_DIR, paste0(time_series_run_spec$hypothesis_label, "_", filename))
}

h1_h3_time_series_dispatch_run <- function() {
  if (!exists("time_series_run_spec", envir = .GlobalEnv, inherits = FALSE)) {
    stop("time_series_run_spec must be set before h1_h3_time_series_dispatch_run().", call. = FALSE)
  }
  stopifnot(is.character(time_series_run_spec$hypothesis_label), length(time_series_run_spec$hypothesis_label) == 1L)
  hypothesis_id <- match.arg(time_series_run_spec$hypothesis_label, c("H1", "H2", "H3"))
  for (model_name in c("TimeSeries_Temporal_AR1_10s_LMM", "TimeSeries_Temporal_AR1_60s_LMM")) {
    if (!exists(model_name, envir = .GlobalEnv, inherits = FALSE)) {
      stop(model_name, " must be defined in the entry script before dispatch.", call. = FALSE)
    }
  }

  n_outcomes <- length(study_wide_spec$physiological_outcome_names)
  cat("==============================================================================\n")
  cat(sprintf("Running %s time series: outcome-only 10 s AR(1) LMMs (engine: H1_H3_core.R)\n", hypothesis_id))
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(study_wide_spec$participants), paste(study_wide_spec$participants, collapse = ", ")))
  cat(sprintf("Outcomes (%d): physiological 10 s series (within-person z); no environmental predictors\n\n", n_outcomes))

  cat("[1/3] Loading matched 8-min epoch data...\n")
  route_data_bundle <- h1_h3_load_route_data()
  condition_data <- route_data_bundle$d_cond
  physiological_outcomes <- route_data_bundle$sensor_outcomes
  model_audit <- list()

  # H1-H3 share the same AR(1) model, so it is fitted once per session and published once.
  temporal_key <- paste(c(deparse(TimeSeries_Temporal_AR1_10s_LMM), deparse(TimeSeries_Temporal_AR1_60s_LMM),
    RAW_PATH, unname(tools::md5sum(RAW_PATH)), physiological_outcomes), collapse = "|")
  temporal_cache <- get0(".H1_H3_TEMPORAL_FIT_CACHE", envir = .GlobalEnv, ifnotfound = NULL)
  temporal_shared_with <- NA_character_
  if (!is.null(temporal_cache) && identical(temporal_cache$key, temporal_key)) {
    cat(sprintf("[2/3] Reusing the 10 s / 60 s AR(1) fits from %s (identical model; not refitted or republished)...\n", temporal_cache$hypothesis_id))
    temporal_fit <- temporal_cache$fit
    temporal_shared_with <- temporal_cache$hypothesis_id
    temporal_table <- NULL
    temporal_sens_table <- NULL
  } else {
    cat("[2/3] Fitting 10 s / 60 s AR(1) temporal LMMs...\n")
    temporal_fit <- h1_h3_fit_temporal_ar1(condition_data, physiological_outcomes, model_audit)
    assign(".H1_H3_TEMPORAL_FIT_CACHE", list(key = temporal_key, fit = temporal_fit, hypothesis_id = hypothesis_id), envir = .GlobalEnv)
    temporal_table <- tag_hypothesis_rows(temporal_fit$temporal_table, hypothesis_id)
    temporal_sens_table <- tag_hypothesis_rows(temporal_fit$temporal_sens_table, hypothesis_id)
    model_audit <- temporal_fit$model_audit}

  cat("[3/3] Collecting outputs (per-hypothesis files only with PAPER3_WRITE_DETAILS=1)...\n")
  if (H1_H3_WRITE_DETAILS) safe_write_csv(temporal_table, time_series_output_path("Temporal_TimeSeries_AR1_10s.csv"))
  pc <- temporal_fit$planned_contrasts
  pc_hypothesis <- NULL
  if (!is.null(pc) && nrow(pc) > 0) {
    pc <- pc[pc$Hypothesis == hypothesis_id, , drop = FALSE]
    if (nrow(pc) > 0) {
      pc_hypothesis <- pc
      if (H1_H3_WRITE_DETAILS) safe_write_csv(pc, time_series_output_path("Planned_Phase_Contrasts.csv"))
    }
  }
  if (H1_H3_WRITE_DETAILS) safe_write_csv(temporal_sens_table, time_series_output_path("Temporal_AR1_Sensitivity_60s.csv"))
  model_audit_df <- safe_rbind(model_audit)
  if (H1_H3_WRITE_DETAILS) safe_write_csv(model_audit_df, time_series_output_path("Model_Audit.csv"))

  cat(sprintf("\nSUCCESS: %s time series finished. Outputs: %s\n", hypothesis_id, OUT_DIR))
  invisible(list(hypothesis_id = hypothesis_id, temporal_table = temporal_table, temporal_sens_table = temporal_sens_table,
    temporal_shared_with = temporal_shared_with,
    planned_contrasts = pc_hypothesis, model_audit = model_audit_df))
}

# Combined time-series files: 10 s and 60 s AR(1) tables, planned contrasts and model audit (stacked, nothing recomputed).
h1_h3_write_time_series_combined <- function(results) {
  results <- Filter(Negate(is.null), results)
  ids <- vapply(results, function(r) r$hypothesis_id, character(1))
  # One published copy of the shared AR(1) model, labelled with every hypothesis that uses it.
  shared_label <- function(table) {
    if (is.null(table) || !nrow(table)) return(table)
    reused <- vapply(results, function(r) !is.null(r$temporal_shared_with) && !is.na(r$temporal_shared_with), logical(1))
    users <- unique(c(table$Hypothesis, ids[reused]))
    users <- users[!is.na(users)]
    if (length(users) > 1L) {
      table$Hypothesis <- paste(sort(users), collapse = "/")
      table$Analysis_Entry <- paste0(paste(sort(users), collapse = "_"), "_time_series_shared_model")}
    table}
  safe_write_csv(shared_label(h1_h3_bind_fill(lapply(results, `[[`, "temporal_table"))), file.path(OUT_DIR, "H1_H3_Temporal_AR1_10s.csv"))
  safe_write_csv(shared_label(h1_h3_bind_fill(lapply(results, `[[`, "temporal_sens_table"))), file.path(OUT_DIR, "H1_H3_Temporal_AR1_Sensitivity_60s.csv"))
  # Planned H1/H3 phase contrasts from the 10 s model.
  old_combined <- file.path(OUT_DIR, "H1_H3_Planned_Contrasts_and_H2_Concordance.csv")
  if (file.exists(old_combined)) {
    archive_dir <- file.path(dirname(OUT_DIR), "archive", "superseded_20261103", basename(OUT_DIR))
    dir.create(archive_dir, recursive = TRUE, showWarnings = FALSE)
    if (file.copy(old_combined, archive_dir, overwrite = FALSE, copy.date = TRUE) || file.exists(file.path(archive_dir, basename(old_combined))))
      file.remove(old_combined)}
  safe_write_csv(h1_h3_bind_fill(lapply(results, `[[`, "planned_contrasts"), "Table", rep("Planned_Phase_Contrasts", length(results))),
    file.path(OUT_DIR, "H1_H3_Planned_Contrasts_10s.csv"))
  audits <- lapply(results, function(r) if (is.data.frame(r$model_audit) && nrow(r$model_audit))
    data.frame(Hypothesis = r$hypothesis_id, r$model_audit, check.names = FALSE, stringsAsFactors = FALSE) else NULL)
  write.csv(h1_h3_bind_fill(audits, "Record_Type", rep("Model_Audit", length(audits))),
    file.path(OUT_DIR, "H1_H3_Run_Manifest.csv"), row.names = FALSE, na = "")
  cat(sprintf("Combined time-series files for %s written to %s\n", paste(ids, collapse = ", "), OUT_DIR))
  invisible(NULL)
}

h1_h3_phase_sum_design <- function(phase) {
  phase <- factor(as.character(phase), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  if (anyNA(phase)) stop("Unknown or missing PhaseID for sum-to-zero contrasts")
  design <- stats::model.matrix(~ phase, contrasts.arg = list(phase = stats::contr.sum(4L)))[, -1L, drop = FALSE]
  colnames(design) <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
  design}

h1_h3_install_time_series_globals <- function() {
  assign("TIME_SERIES_PHASE_SUM_COLUMNS", c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG"), envir = .GlobalEnv)
  if (!exists("paper3_phase_sum_design", envir = .GlobalEnv, inherits = FALSE)) {
    assign("paper3_phase_sum_design", h1_h3_phase_sum_design, envir = .GlobalEnv)
  }
}

h1_h3_prepare_time_series_hypothesis <- function(hypothesis_id) {
  hypothesis_id <- match.arg(hypothesis_id, c("H1", "H2", "H3"))
  assign("time_series_run_spec", list(hypothesis_label = hypothesis_id), envir = .GlobalEnv)
  # H2 has no time-series test; its rmcorr is published by H1_H3_phaseavg.R.
}

h1_h3_clear_temporal_cache <- function() {
  if (exists(".H1_H3_TEMPORAL_FIT_CACHE", envir = .GlobalEnv, inherits = FALSE)) rm(".H1_H3_TEMPORAL_FIT_CACHE", envir = .GlobalEnv)}

h1_h3_run_one_time_series <- function(hypothesis_id, write_combined = TRUE) {
  if (isTRUE(write_combined)) h1_h3_clear_temporal_cache()  # single-hypothesis run: always fit and publish
  h1_h3_prepare_time_series_hypothesis(hypothesis_id)
  res <- h1_h3_time_series_dispatch_run()
  if (isTRUE(write_combined)) h1_h3_write_time_series_combined(list(res))
  invisible(res)
}

h1_h3_run_all_time_series <- function(hypotheses = c("H1", "H2", "H3")) {
  cat("==============================================================================\n")
  cat("Running H1–H3 time series (outcome-only 10 s AR(1); engine per hypothesis)\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(study_wide_spec$participants), paste(study_wide_spec$participants, collapse = ", ")))
  cat(sprintf("Outcomes     (%d): 13 empatica + 13 eyetracker (physiological vector)\n", length(study_wide_spec$physiological_outcome_names)))
  cat(sprintf("H1 contrasts: %s | H3 contrasts: %s\n\n",
              paste(h1_hypothesis_spec$contrasts$Contrast, collapse = ", "),
              paste(h3_hypothesis_spec$contrasts$Contrast, collapse = ", ")))
  all_results <- list()
  h1_h3_clear_temporal_cache()  # fit once per run_all call, reuse across H1/H2/H3
  for (hypothesis_id in hypotheses) {
    cat(sprintf("--- %s ---\n", hypothesis_id))
    all_results[[hypothesis_id]] <- h1_h3_run_one_time_series(hypothesis_id, write_combined = FALSE)
  }
  h1_h3_write_time_series_combined(all_results)
  cat("\nSUCCESS: H1–H3 time series dispatch finished.\n")
}

h1_h3_time_series_dispatch_from_env <- function() {
  time_series_hypothesis_arg <- Sys.getenv("PAPER3_TIME_SERIES_HYPOTHESIS", "")
  if (nzchar(time_series_hypothesis_arg)) h1_h3_run_one_time_series(time_series_hypothesis_arg) else h1_h3_run_all_time_series()
}

# H1_H3_core.R — load, fit, FDR, figures, and CSV outputs; sourced by H1_H3_phaseavg.R and H1_H3_timeseries.R.
# study_wide_spec, hypothesis specs, and explicit model quotes live in those meeting scripts.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H1_H3_core.R (source scripts/statistical_analysis/H1_H3_phaseavg.R).", call. = FALSE)
}
for (spec_name in c("study_wide_spec", "h1_hypothesis_spec", "h2_hypothesis_spec", "h3_hypothesis_spec")) {
  if (!exists(spec_name, envir = .GlobalEnv, inherits = FALSE))
    stop(spec_name, " must be set before sourcing H1_H3_core.R.", call. = FALSE)
}
PAPER3_TIME_SERIES_ENGINE <- isTRUE(get0("PAPER3_TIME_SERIES_ENGINE", envir = .GlobalEnv, ifnotfound = FALSE))
if (!PAPER3_TIME_SERIES_ENGINE) {
  stopifnot(identical(h1_hypothesis_spec$physiological_outcome_names, h3_hypothesis_spec$physiological_outcome_names),
            identical(h1_hypothesis_spec$physiological_outcome_names, h2_hypothesis_spec$physiological_outcome_names))
  for (model_suffix in c("PhaseMean_Primary_LMM", "PhaseMean_Sensitivity_WPZ_LMM",
                         "Temporal_AR1_10s_LMM", "Temporal_AR1_60s_LMM")) {
    stopifnot(identical(get(paste0("H1_", model_suffix)), get(paste0("H3_", model_suffix))))
  }
} else {
  stopifnot(identical(h1_hypothesis_spec$physiological_outcome_names, h3_hypothesis_spec$physiological_outcome_names),
            identical(h1_hypothesis_spec$physiological_outcome_names, h2_hypothesis_spec$physiological_outcome_names))
}

# --- input paths and outputs (not part of meeting spec) ---
script_arg_h1 <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
H1_TO_H3_SCRIPT_PATH <- if (length(script_arg_h1) && file.exists(script_arg_h1[1])) {
  script_arg_h1[1]
} else {
  file.path(PROJECT_ROOT, "scripts/statistical_analysis/H1_H3_phaseavg.R")
}
RAW_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
if (basename(RAW_PATH) != "merged_all_11participants_8min.csv") {
  stop("H1_H3_phaseavg.R must use merged_all_11participants_8min.csv only.")
}
KEY_PATH <- file.path(PROJECT_ROOT, "output", "key.csv")
# Phase-average run: results/H1_H3_phaseavg/ (H1_/H2_/H3_ and H1_to_H3_ run-level files).
# Time-series engine: OUT_DIR = results/H1_H3_timeseries/ (PAPER3_TIME_SERIES_ENGINE).
RESULTS_ROOT <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results")
OUT_DIR <- if (PAPER3_TIME_SERIES_ENGINE) {
  file.path(RESULTS_ROOT, "H1_H3_timeseries")
} else {
  Sys.getenv("PAPER3_OUT_DIR", file.path(RESULTS_ROOT, "H1_H3_phaseavg"))
}
MAKE_FIGURES <- Sys.getenv("PAPER3_MAKE_FIGURES", "TRUE") == "TRUE"
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
pa_out_path <- function(prefix, filename) file.path(OUT_DIR, paste0(prefix, "_", filename))

PARTICIPANTS <- study_wide_spec$participants
CORE_PHASES <- study_wide_spec$phases
MATCHED_CAP_SEC <- study_wide_spec$matched_cap_sec
h1_contrasts <- h1_hypothesis_spec$contrasts
h3_contrasts <- h3_hypothesis_spec$contrasts
study_wide_spec <- paper3_ensure_outcome_normalization(study_wide_spec, PROJECT_ROOT)
physio_groups <- paper3_physiological_outcome_groups(study_wide_spec$physiological_outcome_names)
NATURAL_LOG_OUTCOMES <- study_wide_spec$natural_log_outcome_names
OUTCOMES <- list(
  Psychological = h2_hypothesis_spec$psychological_outcomes,
  Physiological_Autonomic = physio_groups$empatica,
  Physiological_Ocular = physio_groups$eyetracker
)
all_outcomes <- c(h2_hypothesis_spec$psychological_outcomes, h1_hypothesis_spec$physiological_outcome_names)
outcome_group_map <- setNames(
  rep(names(OUTCOMES), vapply(OUTCOMES, length, integer(1))),
  unlist(OUTCOMES, use.names = FALSE)
)
SCRIPT_PATH <- H1_TO_H3_SCRIPT_PATH

clean_labels <- c(
  "questionnaire_current_comfort_1_7"   = "Survey: General Comfort (1-7)",
  "questionnaire_pleasantness_1_5"      = "Survey: Pleasantness (1-5)",
  "questionnaire_stai6_mean_1_5"        = "Survey: State Anxiety (STAI-6)",
  "questionnaire_prs11_total_mean_1_5"  = "Survey: Restorativeness (PRS-11)",
  "empatica_heart_rate"                 = "Empatica: Heart Rate (bpm)",
  "empatica_eda_tonic"                  = "Empatica: EDA Tonic Level (SCL)",
  "empatica_eda_phasic"                 = "Empatica: EDA Phasic (SCR)",
  "empatica_skin_temperature"           = "Empatica: Skin Temperature (°C)",
  "empatica_hrv_td_sdnn"                = "Empatica: HRV (SDNN, ms)",
  "empatica_hrv_td_rmssd"               = "Empatica: HRV (RMSSD, ms)",
  "empatica_hrv_fd_lf"                  = "Empatica: HRV LF Power (ms²)",
  "empatica_hrv_fd_hf"                  = "Empatica: HRV HF Power (ms²)",
  "empatica_hrv_fd_lf_hf_ratio"         = "Empatica: HRV LF/HF Ratio",
  "empatica_hrv_fd_lfnu"                = "Empatica: HRV LF (nu)",
  "empatica_hrv_fd_hfnu"                = "Empatica: HRV HF (nu)",
  "empatica_hrv_fd_vlf"                 = "Empatica: HRV VLF Power (ms²)",
  "empatica_hrv_fd_total_power"         = "Empatica: HRV Total Power (ms²)",
  "eyetracker_pupil_diameter_avg"       = "Eyetracker: Pupil Diameter (mm)",
  "eyetracker_pupil_change_rate"        = "Eyetracker: Pupil Change Rate",
  "eyetracker_blink_duration_s"         = "Eyetracker: Blink Duration (s)",
  "eyetracker_fixation_duration_s"      = "Eyetracker: Fixation Duration (s)",
  "eyetracker_fixation_rate"            = "Eyetracker: Fixation Rate (/s)",
  "eyetracker_saccade_duration_s"       = "Eyetracker: Saccade Duration (s)",
  "eyetracker_saccade_amplitude"        = "Eyetracker: Saccade Amplitude (°)",
  "eyetracker_saccade_peak_velocity"    = "Eyetracker: Saccade Peak Velocity (°/s)",
  "eyetracker_gaze_velocity"            = "Eyetracker: Gaze Velocity (°/s)",
  "eyetracker_gaze_dispersion"          = "Eyetracker: Gaze Dispersion",
  "eyetracker_gaze_centrality"          = "Eyetracker: Gaze Centrality",
  "eyetracker_distance_from_center"     = "Eyetracker: Gaze Distance from Center (px)",
  "eyetracker_eyelid_aperture_avg"      = "Eyetracker: Eyelid Aperture (mm)")



# Units of the raw participant-phase means (from column-name suffixes and labels); H2 uses ln units for the HRV_LOG outcomes.
OUTCOME_UNITS <- c(
  questionnaire_current_comfort_1_7 = "rating scale points (1-7)", questionnaire_pleasantness_1_5 = "rating scale points (1-5)", questionnaire_stai6_mean_1_5 = "rating scale points (mean item score, 1-5)",
  questionnaire_prs11_total_mean_1_5 = "rating scale points (mean item score, 1-5)", empatica_heart_rate = "bpm", empatica_eda_tonic = "uS (microsiemens)",
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
units_of <- function(v) unname(ifelse(!is.na(OUTCOME_UNITS[v]), OUTCOME_UNITS[v], "not specified in source data"))

# Plain words for "higher"/"lower" per physiological measure (H2 Direction sentence)
DIRECTION_WORDS <- list(
  empatica_heart_rate              = c("faster", "slower"),
  empatica_skin_temperature        = c("warmer", "cooler"),
  eyetracker_pupil_diameter_avg    = c("larger", "smaller"),
  eyetracker_blink_duration_s      = c("longer", "shorter"),
  eyetracker_fixation_duration_s   = c("longer", "shorter"),
  eyetracker_saccade_duration_s    = c("longer", "shorter"),
  eyetracker_saccade_amplitude     = c("larger", "smaller"),
  eyetracker_saccade_peak_velocity = c("faster", "slower"),
  eyetracker_gaze_velocity         = c("faster", "slower"),
  eyetracker_eyelid_aperture_avg   = c("wider", "narrower"),
  eyetracker_distance_from_center  = c("farther from centre", "closer to centre"))
dir_word <- function(v, up) vapply(seq_along(v), function(i) {
  w <- DIRECTION_WORDS[[v[i]]]; if (is.null(w)) w <- c("higher", "lower"); if (isTRUE(up[i])) w[1] else w[2] }, character(1))

# Method citations (verified 2026-10-11 via live search; local PDFs in Paper3_Github/Experiment papers/H1 to H4/)
CITE_LMM   <- "Pinheiro JC, Bates DM (2000) Mixed-Effects Models in S and S-PLUS. Springer, New York. doi:10.1007/b98882 (R package nlme)"
CITE_EMM   <- "Lenth R (2023) emmeans: Estimated Marginal Means, aka Least-Squares Means. R package version 1.8.4-1. https://CRAN.R-project.org/package=emmeans"
CITE_FDR   <- "Benjamini Y, Hochberg Y (1995) J R Stat Soc B 57(1):289-300. doi:10.1111/j.2517-6161.1995.tb02031.x"
CITE_WPZ   <- "Ben-Shakhar G (1985) Standardization within individuals: a simple method to neutralize individual differences in skin conductance. Psychophysiology 22(3):292-299. doi:10.1111/j.1469-8986.1985.tb01603.x"
CITE_SMD   <- "Bonett DG (2008) Confidence intervals for standardized linear contrasts of means. Psychol Methods 13(2):99-109. doi:10.1037/1082-989X.13.2.99 (R package statpsych::ci.stdmean.ps)"
CITE_RMC   <- "Bakdash JZ, Marusich LR (2017) Repeated Measures Correlation. Front Psychol 8:456. doi:10.3389/fpsyg.2017.00456"

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

# 2. Reusable Helper Functions -------------------------------------------------
label_of <- function(v) ifelse(!is.na(clean_labels[v]), clean_labels[v], v)
mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)
safe_rbind <- function(x) if (length(x) > 0) do.call(rbind, x) else data.frame()

safe_write_csv <- function(data, path) {
  ok <- tryCatch({ write.csv(data, path, row.names = FALSE, na = ""); TRUE }, error = function(e) {
    warning(sprintf("File locked by Excel or another process: %s. Attempting fallback...", path)); FALSE })
  if (!ok) tryCatch(write.csv(data, sub("\\.csv$", "_latest.csv", path), row.names = FALSE, na = ""), error = function(e) NULL)
}

# Temporal sensitivity companion: rows with BH-FDR q < 0.05 on the primary 10 s fixed-effect term (FDR_significant).
write_temporal_sensitivity_fdr_subset <- function(table, path_without_suffix) {
  if (is.null(table) || nrow(table) == 0 || !"FDR_significant" %in% names(table)) return(invisible(NULL))
  fdr_only <- table[table$FDR_significant %in% TRUE, , drop = FALSE]
  safe_write_csv(fdr_only, paste0(path_without_suffix, "_FDR.csv"))
  invisible(fdr_only)
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
    error = function(e) NULL
  )
}

model_data_ok <- function(data, outcome, min_rows, min_participants) {
  if (!outcome %in% names(data)) return(FALSE)
  x <- data[[outcome]]
  nrow(data) >= min_rows && length(unique(data$ParticipantID)) >= min_participants &&
    is.finite(sd(x, na.rm = TRUE)) && sd(x, na.rm = TRUE) != 0
}

within_person_z <- get0("PAPER3_OUTCOME_WITHIN_PERSON_Z", envir = .GlobalEnv, ifnotfound = paper3_within_person_z)

# H1 and H3 effect size: paired standardized mean difference (Bonett 2008, Psychol Methods 13:99-109) via
# statpsych::ci.stdmean.ps (sqrt((SD1^2 + SD2^2)/2) standardizer), bias-adjusted estimate with 95% CI, on participant-phase
# means in analysis units. Within-person z-scores are not used (person-standardisation shrinks the SD). p/q come from the LMM.
# Transforms: PAPER3_APPLY_CSV_TRANSFORM (or CSV via study_wide_spec$outcome_transforms_csv).
paired_smd <- function(d, outcome, ref, comp) {
  na3 <- c(g = NA_real_, low = NA_real_, high = NA_real_)
  if (!outcome %in% names(d)) return(na3)
  m <- merge(d[ref, c("ParticipantID", outcome)], d[comp, c("ParticipantID", outcome)],
             by = "ParticipantID", suffixes = c(".ref", ".comp"))
  x <- as.numeric(m[[2]]); y <- as.numeric(m[[3]])
  ok <- is.finite(x) & is.finite(y); x <- x[ok]; y <- y[ok]
  if (length(x) < 4 || sd(x) == 0 || sd(y) == 0) return(na3)
  ci <- statpsych::ci.stdmean.ps(0.05, mean(y), mean(x), sd(y), sd(x), cor(x, y), length(x))
  c(g = ci[1, "adj Estimate"], low = ci[1, "LL"], high = ci[1, "UL"])
}

extract_phase_lmm_contrasts <- function(fit, d, outcome, family_set, value_col) {
  contrast_rows <- rbind(h1_contrasts, h3_contrasts)
  lv <- levels(d$PhaseID)
  wvec <- function(plus, minus) { w <- setNames(rep(0, length(lv)), lv); w[plus] <- 1; w[minus] <- -1; unname(w) }
  em <- emmeans(fit, ~ PhaseID)
  cm <- setNames(lapply(seq_len(nrow(contrast_rows)), function(i)
    wvec(contrast_rows$Comparison_PhaseID[i], contrast_rows$Reference_PhaseID[i])), contrast_rows$Contrast)
  cc <- as.data.frame(summary(contrast(em, method = cm), infer = c(TRUE, TRUE)))
  # Difference of differences across the 2x2 layout: (BikeG - BikeU) - (WalkG - WalkU)
  ii <- as.data.frame(summary(contrast(em, method = list(DiD = wvec(c("BikeG", "WalkU"), c("BikeU", "WalkG")))),
                              infer = c(TRUE, TRUE)))
  int_txt <- sprintf("(BikeG - BikeU) - (WalkG - WalkU) = %.3f, t(%d) = %.2f, p = %.4f",
                     ii$estimate, round(ii$df), ii$t.ratio, ii$p.value)
  do.call(rbind, lapply(seq_len(nrow(contrast_rows)), function(i) {
    k <- contrast_rows[i, ]
    ref <- d$PhaseID == k$Reference_PhaseID; comp <- d$PhaseID == k$Comparison_PhaseID
    es <- paired_smd(d, outcome, ref, comp)
    est <- cc$estimate[i]
    beta_ci <- infer_ci95_from_summary_row(cc[i, , drop = FALSE])
    data.frame(
      Hypothesis = k$Hypothesis, Sub_Hypothesis = k$Sub_Hypothesis, Contrast = k$Contrast,
      Reference_PhaseID = k$Reference_PhaseID, Comparison_PhaseID = k$Comparison_PhaseID,
      Outcome = outcome,
      Direction = if (is.finite(est)) sprintf("%s is %s in %s than in %s", outcome,
                    ifelse(est > 0, "higher", "lower"), k$Comparison_PhaseID, k$Reference_PhaseID) else NA_character_,
      Beta = est, SE = cc$SE[i], df = cc$df[i], t_ratio = cc$t.ratio[i], p_value = cc$p.value[i],
      Beta_CI95_low = unname(beta_ci["low"]), Beta_CI95_high = unname(beta_ci["high"]),
      Reference_Mean_raw = mean(d[[outcome]][ref], na.rm = TRUE),
      Comparison_Mean_raw = mean(d[[outcome]][comp], na.rm = TRUE),
      N_Participants = length(intersect(d$ParticipantID[ref], d$ParticipantID[comp])),
      SMD_paired_Bonett = unname(es["g"]), SMD_CI95_low = unname(es["low"]), SMD_CI95_high = unname(es["high"]),
      Model_Formula = sprintf("lme(%s ~ PhaseID, random = ~1 | ParticipantID); Beta = %s - %s",
                              value_col, k$Comparison_PhaseID, k$Reference_PhaseID),
      Interaction_Test = int_txt,
      Normalization = if (startsWith(value_col, "within_person_z__")) "Sensitivity: within-person z-score over the 4 PhaseIDs (after notebook transform)" else "Primary: analysis units (notebook transform), random intercept",
      Family_Set = family_set, Contrast_ID = k$Contrast,
      stringsAsFactors = FALSE)
  }))
}

adjust_by_family <- function(tab, family_size_map) {
  if (nrow(tab) == 0) return(tab)
  tab$Correction_Family <- paste(tab$Hypothesis, tab$Family_Set, tab$Contrast_ID, tab$Normalization, sep = "__")
  tab$q_FDR <- NA_real_
  tab$Family_Size <- NA_integer_
  for (fam in unique(tab$Correction_Family)) {
    idx <- which(tab$Correction_Family == fam)
    fs <- as.character(tab$Family_Set[idx[1]])
    planned_n <- max(if (fs %in% names(family_size_map)) as.integer(family_size_map[[fs]]) else 0L, sum(!is.na(tab$p_value[idx])))
    tab$q_FDR[idx] <- p.adjust(tab$p_value[idx], method = "BH", n = planned_n)
    tab$Family_Size[idx] <- planned_n
  }
  tab$FDR_significant <- !is.na(tab$q_FDR) & tab$q_FDR < 0.05
  tab
}

# Outcome-only 10 s / 60 s AR(1) temporal models (shared by H1_H3_phaseavg.R and H1_H3_timeseries.R).
fit_ar1_with_fallback <- function(epoch_data, step_variable) {
  model_10s <- get0("TimeSeries_Temporal_AR1_10s_LMM", envir = .GlobalEnv, ifnotfound = NULL)
  model_60s <- get0("TimeSeries_Temporal_AR1_60s_LMM", envir = .GlobalEnv, ifnotfound = NULL)
  model_call <- if (step_variable == "time_10s_step") {
    if (!is.null(model_10s)) model_10s else H1_Temporal_AR1_10s_LMM
  } else {
    if (!is.null(model_60s)) model_60s else H1_Temporal_AR1_60s_LMM
  }
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
    tryCatch(eval(model_call), error = function(e) NULL)
  }
  fitted_model <- fit_one("optim", TRUE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "optim (primary)"))
  fitted_model <- fit_one("nlminb", FALSE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "nlminb (fallback, as in H4_timeseries.R)"))
  fitted_model <- fit_one("optim", FALSE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "optim (fallback, as in H4_timeseries.R)"))
  list(fit = NULL, method = "none (not converged)")
}

ar1_rho <- function(fit) if (is.null(fit)) NA_real_ else tryCatch(as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)

time_series_result_row <- function(outcome, term_name, formula_template, t_table, column_map, ...) {
  has_term <- !is.null(t_table) && term_name %in% rownames(t_table)
  estimates <- setNames(lapply(column_map, function(column_name) if (has_term) t_table[term_name, column_name] else NA_real_), names(column_map))
  data.frame(Outcome_Group = outcome_group_map[outcome], Outcome = outcome, Clean_Outcome = ifelse(!is.na(clean_labels[outcome]), clean_labels[outcome], outcome),
             Term = term_name, Model_Formula = sprintf(formula_template, outcome), ..., estimates, stringsAsFactors = FALSE)
}

TEMPORAL_PHASE_SHORT <- c(BikeU = "BikeU", WalkU = "WalkU", BikeG = "BikeG", WalkG = "WalkG")

temporal_observed_wpz <- function(outcome, beta) {
  if (!is.finite(beta)) return("not estimated")
  if (abs(beta) < 1e-8) return("flat")
  dir_word(outcome, beta > 0)
}

temporal_beta_sign_word <- function(beta) {
  if (!is.finite(beta)) return("n/a")
  if (beta > 0) "Beta>0" else if (beta < 0) "Beta<0" else "Beta~0"
}

h1_h3_enrich_temporal_grid_columns <- function(table, term_col = "Term") {
  if (is.null(table) || !nrow(table) || !term_col %in% names(table)) return(table)
  terms <- table[[term_col]]
  display_fn <- get0("paper3_grid_term_display", mode = "function")
  is_grid_fn <- get0("paper3_is_grid_lmm_term", mode = "function")
  is_grid <- if (is.function(is_grid_fn)) vapply(terms, is_grid_fn, logical(1L)) else grepl("^grid_f", terms)
  table$term_category <- ifelse(is_grid, "corridor grid", "phase/time")
  table$Term_display <- if (is.function(display_fn)) vapply(terms, display_fn, character(1L)) else terms
  table
}

h1_h3_temporal_term_statement <- function(outcome, term, beta, use_phase_sum_coding, epoch_grid = c("10s", "60s")) {
  epoch_grid <- match.arg(epoch_grid)
  grid <- if (epoch_grid == "60s") "60s" else "10s"
  obs <- temporal_observed_wpz(outcome, beta)
  sign_w <- temporal_beta_sign_word(beta)
  short_out <- gsub("^Empatica: |^Eyetracker: ", "", label_of(outcome))
  is_grid_fn <- get0("paper3_is_grid_lmm_term", mode = "function")
  if (is.function(is_grid_fn) && is_grid_fn(term)) {
    cell <- if (is.function(get0("paper3_grid_term_display", mode = "function"))) paper3_grid_term_display(term) else sub("^grid_f", "", term)
    return(sprintf("Row: %s AR(1) WPZ offset vs reference corridor grid cell (%s); observed: %s %s (%s).",
      grid, cell, short_out, obs, sign_w))
  }
  if (grepl("^grid_f", term)) {
    cell <- sub("^grid_f", "", term)
    return(sprintf("Row: %s AR(1) WPZ offset vs reference corridor grid cell (%s); observed: %s %s (%s).",
      grid, cell, short_out, obs, sign_w))
  }
  if (use_phase_sum_coding) {
    if (identical(term, "time_min")) {
      return(sprintf("Row: %s AR(1) common WPZ slope per minute; observed: %s %s (%s).", grid, short_out, obs, sign_w))
    }
    if (grepl(":time_min", term, fixed = TRUE)) {
      ph <- sub(":time_min", "", term, fixed = TRUE)
      return(sprintf("Row: %s AR(1) extra WPZ slope/min for %s; observed: %s %s (%s).", grid, ph, short_out, obs, sign_w))
    }
    return(sprintf("Row: %s AR(1) WPZ level for %s (sum coding); observed: %s %s (%s).", grid, term, short_out, obs, sign_w))
  }
  if (identical(term, "time_min")) {
    return(sprintf("Row: %s AR(1) WPZ slope/min in BikeU; observed: %s %s over bout (%s).", grid, short_out, obs, sign_w))
  }
  if (grepl("^PhaseID", term) && !grepl(":", term, fixed = TRUE)) {
    ph <- sub("^PhaseID", "", term)
    ph <- if (ph %in% names(TEMPORAL_PHASE_SHORT)) TEMPORAL_PHASE_SHORT[[ph]] else ph
    return(sprintf("Row: %s AR(1) WPZ at bout start, %s vs BikeU; observed: %s %s (%s).", grid, ph, short_out, obs, sign_w))
  }
  if (grepl(":", term, fixed = TRUE)) {
    ph <- sub("^PhaseID", "", strsplit(term, ":", fixed = TRUE)[[1]][1])
    ph <- if (ph %in% names(TEMPORAL_PHASE_SHORT)) TEMPORAL_PHASE_SHORT[[ph]] else ph
    return(sprintf("Row: %s AR(1) extra WPZ slope/min, %s vs BikeU; observed: %s %s (%s).", grid, ph, short_out, obs, sign_w))
  }
  sprintf("Row: %s AR(1) term %s; observed: %s %s (%s).", grid, term, short_out, obs, sign_w)
}

attach_temporal_statements <- function(table, beta_col, statement_col, use_phase_sum_coding, epoch_grid) {
  if (is.null(table) || nrow(table) == 0 || !beta_col %in% names(table)) return(table)
  beta_vec <- table[[beta_col]]
  table[[statement_col]] <- mapply(
    h1_h3_temporal_term_statement,
    table$Outcome, table$Term, beta_vec,
    MoreArgs = list(use_phase_sum_coding = use_phase_sum_coding, epoch_grid = epoch_grid),
    SIMPLIFY = TRUE, USE.NAMES = FALSE
  )
  table
}

attach_phase_sum_columns <- function(epoch_data) {
  phase_design_function <- get0("paper3_phase_sum_design", envir = .GlobalEnv, ifnotfound = NULL)
  phase_sum_columns <- get0("TIME_SERIES_PHASE_SUM_COLUMNS", envir = .GlobalEnv, ifnotfound = NULL)
  if (is.null(phase_design_function) || is.null(phase_sum_columns)) return(epoch_data)
  phase_design <- phase_design_function(epoch_data$PhaseID)
  epoch_data[phase_sum_columns] <- phase_design
  if ("time_10s_step" %in% names(epoch_data)) epoch_data$time_10s_step_integer <- as.integer(epoch_data$time_10s_step)
  epoch_data$PhaseID <- factor(as.character(epoch_data$PhaseID), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  epoch_data
}

# Linear combos of contr.sum(4) columns (levels WalkG, WalkU, BikeG, BikeU; BikeU = -1,-1,-1)
# so Beta matches phase-average estimands: Comparison - Reference.
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
         w = c(PhaseSumWalkG = 1, PhaseSumWalkU = 0, PhaseSumBikeG = -1))
  )
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
    L[term] <- spec$w[[nm]]
  }
  V <- tryCatch(vcov(fit), error = function(e) NULL)
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
    stringsAsFactors = FALSE
  )
}

h1_h3_fit_temporal_ar1 <- function(route, CONDITIONS, sensor_outcomes, model_audit) {
  temporal_results_list <- list()
  temporal_sens_list <- list()
  planned_contrast_list <- list()
  route_epoch_data <- CONDITIONS[[1]]
  route_epoch_data$time_10s_step <- round(route_epoch_data$time_in_phase_sec / 10)
  route_epoch_data$PhaseID <- factor(route_epoch_data$PhaseID, levels = CORE_PHASES)
  use_phase_sum_coding <- !is.null(get0("TIME_SERIES_PHASE_SUM_COLUMNS", envir = .GlobalEnv, ifnotfound = NULL))
  time_step_key <- paste(route_epoch_data$ParticipantID, route_epoch_data$PhaseID, route_epoch_data$time_10s_step)
  if (anyDuplicated(time_step_key)) stop("Temporal AR(1): ", sum(duplicated(time_step_key)),
    " duplicate participant/phase/10-s steps; fix the epoch grid upstream instead of dropping rows.")
  phase_sum_columns <- get0("TIME_SERIES_PHASE_SUM_COLUMNS", envir = .GlobalEnv, ifnotfound = character(0))
  if (use_phase_sum_coding) {
    formula_template_10s <- paste0("lme(within_person_z__%s ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min + grid_f, random = ~1 | ParticipantID/PhaseID, ",
                  "corAR1(value=0.2, ~ time_10s_step_integer | ParticipantID/PhaseID)); BikeU implicit (contr.sum)")
    formula_template_60s <- paste0("lme(mean within_person_z__%s per 60-s epoch ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min + grid_f, random = ~1 | ParticipantID/PhaseID, ",
                  "corAR1(value=0.2, ~ time_60s_step | ParticipantID/PhaseID)); BikeU implicit (contr.sum)")
    fixed_effect_terms <- paste0("(", paste(phase_sum_columns, collapse = " + "), ") * time_min + grid_f")
  } else {
    formula_template_10s <- "lme(within_person_z__%s ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_10s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU"
    formula_template_60s <- "lme(mean within_person_z__%s per 60-s epoch ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_60s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU"
    fixed_effect_terms <- "PhaseID * time_min"
  }

  for (outcome in sensor_outcomes) {
    z_column <- paste0("within_person_z__", outcome)
    required_columns <- c("ParticipantID", "PhaseID", "time_min", "time_10s_step", z_column)
    complete_rows <- complete.cases(route_epoch_data[, required_columns, drop = FALSE])
    n_na_excluded <- sum(!complete_rows)
    epoch_data <- route_epoch_data[complete_rows, , drop = FALSE]
    epoch_data$outcome_z <- epoch_data[[z_column]]
    epoch_data <- attach_phase_sum_columns(epoch_data)
    if (!"grid_f" %in% names(epoch_data) && exists("paper3_attach_grid_factor", mode = "function")) {
      epoch_data <- paper3_attach_grid_factor(epoch_data)
    }
    if ("grid_f" %in% names(epoch_data)) epoch_data <- epoch_data[!is.na(epoch_data$grid_f), , drop = FALSE]
    epoch_data <- epoch_data[order(epoch_data$ParticipantID, epoch_data$PhaseID, epoch_data$time_10s_step), ]
    excluded_epochs_note <- sprintf("NA epochs excluded: %d of %d", n_na_excluded, nrow(route_epoch_data))
    n_participants <- length(unique(epoch_data$ParticipantID))
    if (!model_data_ok(epoch_data, "outcome_z", 100, 8)) {
      model_audit[[length(model_audit) + 1]] <- audit_row("Temporal_AR1", "Primary_10s_matched_8min", outcome, fixed_effect_terms,
        "NOT_FIT_INSUFFICIENT_DATA", nrow(epoch_data), n_participants, warn = paste("Insufficient time-series rows;", excluded_epochs_note))
      next
    }
    fit_result_10s <- fit_ar1_with_fallback(epoch_data, "time_10s_step")
    if (use_phase_sum_coding) {
      design_matrix <- model.matrix(as.formula(paste("~", fixed_effect_terms)), data = epoch_data)
      all_terms <- colnames(design_matrix)[-1L]
    } else {
      all_terms <- colnames(model.matrix(~ PhaseID * time_min, data = epoch_data))[-1]
    }

    epoch_data_60s <- epoch_data
    epoch_data_60s$time_60s_step <- floor(epoch_data_60s$time_10s_step / 6)
    grid_60s <- aggregate(grid_label ~ ParticipantID + PhaseID + time_60s_step, data = epoch_data_60s,
      FUN = if (exists("paper3_mode_grid_label", mode = "function")) paper3_mode_grid_label else function(x) {
        x <- x[!is.na(x)]; if (!length(x)) NA_character_ else names(sort(table(x), decreasing = TRUE))[1L]
      })
    epoch_data_60s <- aggregate(cbind(outcome_z, time_min) ~ ParticipantID + PhaseID + time_60s_step, data = epoch_data_60s, FUN = mean)
    epoch_data_60s <- merge(epoch_data_60s, grid_60s, by = c("ParticipantID", "PhaseID", "time_60s_step"), all.x = TRUE, sort = FALSE)
    if (use_phase_sum_coding) {
      epoch_data_60s <- attach_phase_sum_columns(epoch_data_60s)
    } else {
      epoch_data_60s$PhaseID <- factor(epoch_data_60s$PhaseID, levels = CORE_PHASES)
    }
    if (exists("paper3_attach_grid_factor", mode = "function")) {
      epoch_data_60s <- paper3_attach_grid_factor(epoch_data_60s)
      epoch_data_60s <- epoch_data_60s[!is.na(epoch_data_60s$grid_f), , drop = FALSE]
    }
    epoch_data_60s <- epoch_data_60s[order(epoch_data_60s$ParticipantID, epoch_data_60s$PhaseID, epoch_data_60s$time_60s_step), ]
    fit_result_60s <- fit_ar1_with_fallback(epoch_data_60s, "time_60s_step")
    t_table_60s <- if (!is.null(fit_result_60s$fit)) summary(fit_result_60s$fit)$tTable
    for (term_name in all_terms) temporal_sens_list[[length(temporal_sens_list) + 1]] <- cbind(
      time_series_result_row(outcome, term_name, formula_template_60s, t_table_60s, c(Beta_60s = "Value", SE_60s = "Std.Error", p_value_60s = "p-value")),
      AR1_phi_60s = ar1_rho(fit_result_60s$fit), Fit_Method_60s = fit_result_60s$method, N_epochs_60s = nrow(epoch_data_60s), stringsAsFactors = FALSE)

    status <- if (is.null(fit_result_10s$fit)) "FAILED_CONVERGENCE" else "FIT"
    model_audit[[length(model_audit) + 1]] <- audit_row("Temporal_AR1", "Primary_10s_matched_8min", outcome, "PhaseID*time_min", status,
      nrow(epoch_data), n_participants, warn = if (status == "FIT") paste0(excluded_epochs_note, "; fit method: ", fit_result_10s$method) else excluded_epochs_note,
      err = if (status == "FIT") "" else "AR(1) model failed to converge (optim, nlminb and optim fallbacks)")
    t_table_10s <- if (status == "FIT") summary(fit_result_10s$fit)$tTable
    terms <- if (status == "FIT") setdiff(rownames(t_table_10s), "(Intercept)") else all_terms
    if (status == "FIT" && use_phase_sum_coding) {
      for (spec in h1_h3_sum_contrast_specs()) {
        for (effect in c("phase_level", "phase_slope")) {
          row <- h1_h3_apply_sum_contrast(fit_result_10s$fit, spec, effect)
          if (!is.null(row)) {
            row$Outcome <- outcome
            planned_contrast_list[[length(planned_contrast_list) + 1L]] <- row
          }
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
    temporal_table$Stability_Flag <- ifelse(temporal_table$Status != "FIT", "not converged",
      ifelse(!is.na(temporal_table$AR1_phi) & temporal_table$AR1_phi > 0.95, "rho > 0.95, interpret cautiously", ""))
    tci <- t(vapply(seq_len(nrow(temporal_table)), function(i) {
      wald_ci95(temporal_table$Beta[i], temporal_table$SE[i], temporal_table$df[i])
    }, numeric(2)))
    temporal_table$Beta_CI95_low <- tci[, 1L]
    temporal_table$Beta_CI95_high <- tci[, 2L]
    temporal_table <- attach_temporal_statements(temporal_table, "Beta", "Statement", use_phase_sum_coding, "10s")
    temporal_table <- h1_h3_enrich_temporal_grid_columns(temporal_table)
  }
  temporal_sens_table <- safe_rbind(temporal_sens_list)
  if (nrow(temporal_sens_table) > 0) {
    temporal_sens_table <- attach_temporal_statements(temporal_sens_table, "Beta_60s", "Statement_60s", use_phase_sum_coding, "60s")
    temporal_sens_table <- h1_h3_enrich_temporal_grid_columns(temporal_sens_table, term_col = "Term")
    temporal_sens_table$Family_Size <- temporal_family_size
    temporal_sens_table$q_FDR_60s <- ave(temporal_sens_table$p_value_60s, temporal_sens_table$Term, FUN = function(p) p.adjust(p, method = "BH", n = temporal_family_size))
    temporal_sens_table$FDR_significant_60s <- !is.na(temporal_sens_table$q_FDR_60s) & temporal_sens_table$q_FDR_60s < 0.05
    if ("Beta_60s" %in% names(temporal_sens_table) && "SE_60s" %in% names(temporal_sens_table)) {
      df60 <- if ("df" %in% names(temporal_sens_table)) temporal_sens_table$df else rep(NA_real_, nrow(temporal_sens_table))
      tci60 <- t(vapply(seq_len(nrow(temporal_sens_table)), function(i) {
        wald_ci95(temporal_sens_table$Beta_60s[i], temporal_sens_table$SE_60s[i], df60[i])
      }, numeric(2)))
      temporal_sens_table$Beta_CI95_60s_low <- tci60[, 1L]
      temporal_sens_table$Beta_CI95_60s_high <- tci60[, 2L]
    }
    primary_columns <- temporal_table[, intersect(c("Outcome", "Term", "Beta", "SE", "df", "Beta_CI95_low", "Beta_CI95_high",
      "Statement", "p_value", "q_FDR", "FDR_significant", "AR1_phi", "Fit_Method", "Stability_Flag"), names(temporal_table))]
    temporal_sens_table <- merge(primary_columns, temporal_sens_table, by = c("Outcome", "Term"), all = TRUE, sort = FALSE)
    temporal_sens_table$Same_Sign_As_Primary <- sign(temporal_sens_table$Beta) == sign(temporal_sens_table$Beta_60s)
    temporal_sens_table$Primary_Holds_In_60s <- temporal_sens_table$FDR_significant %in% TRUE &
      temporal_sens_table$FDR_significant_60s %in% TRUE & temporal_sens_table$Same_Sign_As_Primary %in% TRUE
  }
  planned_contrasts <- safe_rbind(planned_contrast_list)
  if (nrow(planned_contrasts) > 0 && "p_value" %in% names(planned_contrasts)) {
    planned_contrasts$q_FDR <- ave(planned_contrasts$p_value, planned_contrasts$Hypothesis, planned_contrasts$Effect,
      FUN = function(p) p.adjust(p, method = "BH"))
  }
  list(temporal_table = temporal_table, temporal_sens_table = temporal_sens_table,
       model_audit = model_audit, planned_contrasts = planned_contrasts)
}

h1_h3_load_route_data <- function() {
  if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
  df <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
  df$ParticipantID <- as.character(df$ParticipantID)
  df$PhaseID <- as.character(df$PhaseID)

  missing_participants <- setdiff(PARTICIPANTS, unique(df$ParticipantID))
  if (length(missing_participants) > 0) stop("Verified 11-participant input is incomplete. Missing: ", paste(missing_participants, collapse = ", "))
  phase_grid <- expand.grid(ParticipantID = PARTICIPANTS, PhaseID = CORE_PHASES, stringsAsFactors = FALSE)
  present_key <- with(df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ], paste(ParticipantID, PhaseID, sep = "::"))
  missing_cells <- phase_grid[!paste(phase_grid$ParticipantID, phase_grid$PhaseID, sep = "::") %in% present_key, , drop = FALSE]
  if (nrow(missing_cells) > 0) stop("Core within-subject design is incomplete; missing participant-phase cells: ",
    paste(paste(missing_cells$ParticipantID, missing_cells$PhaseID, sep = "/"), collapse = ", "))
  core_time_key <- paste(df$ParticipantID, df$PhaseID, df$Datetime, sep = "::")
  core_idx <- df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% c(CORE_PHASES, "Tram")
  if (anyDuplicated(core_time_key[core_idx])) stop("Duplicate ParticipantID/PhaseID/Datetime keys detected in active/Tram data.")

  safe_pair_mean <- function(data, left, right) {
    if (!all(c(left, right) %in% names(data))) return(rep(NA_real_, nrow(data)))
    z <- rowMeans(cbind(as.numeric(data[[left]]), as.numeric(data[[right]])), na.rm = TRUE)
    z[is.nan(z)] <- NA_real_
    z
  }
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
    lys_medi_avg = c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi")
  )
  for (nm in names(pair_map)) df[[nm]] <- do.call(safe_pair_mean, c(list(df), pair_map[[nm]]))

  sensor_outcomes <- intersect(c(OUTCOMES$Physiological_Autonomic, OUTCOMES$Physiological_Ocular), names(df))
  psych_outcomes <- intersect(OUTCOMES$Psychological, names(df))
  if (length(sensor_outcomes) == 0) stop("No declared physiological/ocular outcome columns are available after schema harmonization.")

  route <- df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ]
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
  for (v in intersect(sensor_outcomes, names(route))) {
    route[[v]] <- if (is.function(csv_transform_fn)) {
      csv_transform_fn(route[[v]], v)
    } else {
      paper3_apply_csv_transform(route[[v]], v, csv_table)
    }
    route[[paste0("within_person_z__", v)]] <- within_person_z(route[[v]], route$ParticipantID)
  }
  for (v in intersect(psych_outcomes, names(route))) {
    route[[paste0("within_person_z__", v)]] <- within_person_z(route[[v]], route$ParticipantID)
  }

  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID, FUN = function(x) x - min(x, na.rm = TRUE))
  route$time_min <- route$time_in_phase_sec / 60

  if (!exists("paper3_merge_corridor_grid_columns", mode = "function")) {
    cg_path <- file.path(paper3_statistical_library_dir(), "Paper3_corridor_grid.R")
    if (file.exists(cg_path)) source(cg_path, local = FALSE)
  }
  if (exists("paper3_merge_corridor_grid_columns", mode = "function")) {
    route <- paper3_merge_corridor_grid_columns(route, PROJECT_ROOT)
    df <- paper3_merge_corridor_grid_columns(df, PROJECT_ROOT)
  }

  durations <- aggregate(time_in_phase_sec ~ ParticipantID + PhaseID, route, max, na.rm = TRUE)
  phase_durations_wide <- reshape(durations, idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
  names(phase_durations_wide) <- sub("time_in_phase_sec\\.", "", names(phase_durations_wide))
  for (nm in CORE_PHASES) if (!nm %in% names(phase_durations_wide)) phase_durations_wide[[nm]] <- NA_real_
  phase_durations_wide$Common_cap <- pmin(phase_durations_wide$BikeU, phase_durations_wide$BikeG, phase_durations_wide$WalkU, phase_durations_wide$WalkG, MATCHED_CAP_SEC, na.rm = FALSE)
  route <- merge(route, phase_durations_wide[c("ParticipantID", "Common_cap")], by = "ParticipantID", all.x = TRUE, sort = FALSE)
  route$matched_cap_sec <- route$Common_cap

  CONDITIONS <- list("Primary: Matched duration <=8 min" = route[!is.na(route$matched_cap_sec) & route$time_in_phase_sec <= route$matched_cap_sec, ])
  cname <- names(CONDITIONS)[1]
  d_cond <- CONDITIONS[[1]]

  list(df = df, route = route, d_cond = d_cond, CONDITIONS = CONDITIONS, cname = cname,
       sensor_outcomes = sensor_outcomes, psych_outcomes = psych_outcomes)
}


h1_to_h3_pipeline_run <- function() {
  # 3. Data Loading & Feature Engineering ----------------------------------------
  cat("[1/6] Loading and formatting dataset...\n")
  prep <- h1_h3_load_route_data()
  df <- prep$df
  route <- prep$route
  d_cond <- prep$d_cond
  CONDITIONS <- prep$CONDITIONS
  cname <- prep$cname
  sensor_outcomes <- prep$sensor_outcomes
  psych_outcomes <- prep$psych_outcomes
  cat("   Input:", RAW_PATH, "\n")
  cat("   Rows/columns:", nrow(df), "/", ncol(df), "| Participants:", length(intersect(PARTICIPANTS, unique(df$ParticipantID))),
      "of", length(PARTICIPANTS), "| Indoor rows:", sum(df$PhaseID == "Indoor", na.rm = TRUE), "\n")

  um_cols <- intersect(c("sound_prop_urban_manmade_positive", "sound_prop_urban_manmade_neutral", "sound_prop_urban_manmade_negative"), names(df))
  if (!"sound_prop_urban_manmade" %in% names(df) && length(um_cols) > 0) df$sound_prop_urban_manmade <- rowSums(df[, um_cols, drop = FALSE], na.rm = TRUE)
  if ("atmo_lys_LYS1__lys_lux" %in% names(df) && !"lys_lux_participant" %in% names(df)) df$lys_lux_participant <- as.numeric(df[["atmo_lys_LYS1__lys_lux"]])
  if (length(psych_outcomes) == 0) warning("No declared psychological outcome columns are available.")

  # 4. H1 & H3 Inferential Models (26 physiological outcomes) ----------------------
  cat("[2/6] Fitting H1 and H3 models across the 26 physiological outcomes (questionnaires are H2 only)...\n")
  phase_lmm_rows <- list(); model_audit <- list()

  for (outcome in setdiff(all_outcomes, names(df)))
    model_audit[[length(model_audit) + 1]] <- audit_row("Input_schema", "All", outcome, "NA", "NOT_AVAILABLE_IN_INPUT", 0, 0,
                                                        err = "Declared outcome absent from input dataset.")

  # Participant-phase means: one row per participant x phase (N = 44); questionnaires are constant within a phase.
  all_phase_vars <- intersect(unique(c(sensor_outcomes, psych_outcomes, paste0("within_person_z__", sensor_outcomes), paste0("within_person_z__", psych_outcomes))), names(d_cond))
  phase_df <- aggregate(d_cond[all_phase_vars], by = d_cond[c("ParticipantID", "PhaseID")], FUN = mean_na)
  phase_df$ParticipantID <- factor(phase_df$ParticipantID, levels = PARTICIPANTS)
  phase_df$PhaseID <- factor(phase_df$PhaseID, levels = CORE_PHASES)

  for (family_set in c("Primary", "Sensitivity_WPZ"))
  for (outcome in intersect(sensor_outcomes, names(d_cond))) {   # physio only; questionnaires belong to H2
    value_col <- if (family_set == "Primary") outcome else paste0("within_person_z__", outcome)
    analysis <- paste0("H1_and_H3_phase_mean_", family_set)
    if (!value_col %in% names(phase_df)) {
      model_audit[[length(model_audit) + 1]] <- audit_row(analysis, cname, outcome, "PhaseID", "NOT_FIT_MISSING_COLUMN", 0, 0,
                                                          err = paste(value_col, "column missing"))
      next
    }
    d <- phase_df[complete.cases(phase_df[, c(value_col, "PhaseID", "ParticipantID")]), ]
    d$outcome_z <- d[[value_col]]
    n_pid <- length(unique(d$ParticipantID))
    model_call <- if (family_set == "Primary") H1_PhaseMean_Primary_LMM else H1_PhaseMean_Sensitivity_WPZ_LMM
    fit <- if (model_data_ok(d, "outcome_z", 24, 8)) fit_phase_lmm(model_call, d)
    status <- if (!model_data_ok(d, "outcome_z", 24, 8)) "NOT_FIT_INSUFFICIENT_DATA" else if (is.null(fit)) "FAILED_CONVERGENCE" else "FIT"
    model_audit[[length(model_audit) + 1]] <- audit_row(analysis, cname, outcome, "PhaseID", status, nrow(d), n_pid,
      warn = if (status == "NOT_FIT_INSUFFICIENT_DATA") "Fewer than 24 bouts or 8 participants" else "",
      err = if (status == "FAILED_CONVERGENCE") "nlme::lme failed to converge" else "")
    if (status == "FIT") phase_lmm_rows[[length(phase_lmm_rows) + 1]] <- extract_phase_lmm_contrasts(fit, d, outcome, family_set, value_col)
  }

  phase_lmm_table <- adjust_by_family(safe_rbind(phase_lmm_rows), c(Primary = length(sensor_outcomes), Sensitivity_WPZ = length(sensor_outcomes)))

  # 4D. Temporal Time-Series Mixed Models with AR(1) Autocorrelation -------------
  cat("[2b/6] Fitting 10-second temporal time-series LMMs with AR(1) autocorrelation...\n")
  temporal_fit <- h1_h3_fit_temporal_ar1(route, CONDITIONS, sensor_outcomes, model_audit)
  temporal_table <- temporal_fit$temporal_table
  temporal_sens_table <- temporal_fit$temporal_sens_table
  model_audit <- temporal_fit$model_audit

  # 5. H2: within-person rmcorr (Bakdash & Marusich 2017, Front Psychol 8:456) across the 4 core phases ----------------
  # rmcorr = lm(psych ~ factor(ParticipantID) + physio): one common within-person slope, df = N - k - 1. Inputs are
  # participant-phase means (ln(x) already applied to the natural-log outcomes). 4 questionnaires x 26 outcomes, one BH-FDR family.
  cat("[3/6] Evaluating H2 psychophysiological concurrence models...\n")
  h2_physio_outcomes <- intersect(sensor_outcomes, names(df))
  h2_psych_outcomes  <- intersect(psych_outcomes, names(df))
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
      next
    }
    h2_call <- H2_rmcorr
    h2_call[[2L]] <- do.call("substitute", list(h2_call[[2L]], list(
      psychological = as.name("psych"), physiological = as.name("phys")
    )))
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
      Raw_Direction = sprintf("Higher %s is associated with %s %s", label_of(phys_var), ifelse(r_rm >= 0, "higher", "lower"), label_of(psych_var)),
      Beta = cf[["Estimate"]], SE = cf[["Std. Error"]], CI95_low = tanh(z_ci[1]), CI95_high = tanh(z_ci[2]), t_stat = t_val, df = dfr,
      p_value = cf[["Pr(>|t|)"]], Partial_r_Within = r_rm, N_PhaseBouts = nrow(x), N_Participants = n_pid, stringsAsFactors = FALSE)
  }

  # Literature expectation per physiological measure: sign of the association with positive states (NA = no expected direction)
  LIT <- as.data.frame(do.call(rbind, list(
    c("empatica_heart_rate", "-1", "Established", "Van Doren et al. (2021) Biol Psychol; Ulrich et al. (1991) J Environ Psychol", "Heart rate decreases during positive/restorative states reflecting reduced cardiovascular strain"),
    c("empatica_eda_tonic", "-1", "Established", "Boucsein (2012) Electrodermal Activity; Ulrich et al. (1991) J Environ Psychol", "Tonic skin conductance level (SCL) decreases with reduced sympathetic arousal"),
    c("empatica_eda_phasic", "-1", "Established", "Boucsein (2012) Electrodermal Activity; Dawson et al. (2017) Cambridge Handb Psychophysiol", "Phasic skin conductance responses (SCR) decrease with lower acute sympathetic reactivity"),
    c("empatica_hrv_td_rmssd", "1", "Established", "Laborde et al. (2017) Front Psychol; Shaffer & Ginsberg (2017) Front Public Health", "RMSSD increases reflecting greater parasympathetic/vagal tone and autonomic recovery"),
    c("empatica_hrv_td_sdnn", "1", "Moderate/Cautious", "Shaffer & Ginsberg (2017) Front Public Health; Task Force ESC/NASPE (1996) Circulation", "SDNN reflects overall autonomic variability, generally higher with lower stress"),
    c("empatica_hrv_fd_hf", "1", "Established", "Laborde et al. (2017) Front Psychol; Task Force ESC/NASPE (1996) Circulation", "High-frequency HRV reflects parasympathetic vagal modulation and increases during calm/restorative states"),
    c("empatica_hrv_fd_lf_hf_ratio", "NA", "Context-dependent", "Billman GE (2013) The LF/HF ratio does not accurately measure cardiac sympatho-vagal balance. Front Physiol 4:26. doi:10.3389/fphys.2013.00026", "LF/HF ratio is often read as sympathetic/vagal balance, but this reading is disputed (Billman 2013); no expected direction is assumed"),
    c("empatica_hrv_fd_lfnu", "-1", "Moderate/Cautious", "Task Force ESC/NASPE (1996) Circulation", "Normalized LF reflects sympathetic dominance; decreases in restorative conditions"),
    c("empatica_hrv_fd_hfnu", "1", "Moderate/Cautious", "Task Force ESC/NASPE (1996) Circulation", "Normalized HF reflects parasympathetic vagal tone; increases in restorative conditions"),
    c("empatica_hrv_fd_lf", "NA", "Context-dependent", "Shaffer & Ginsberg (2017) Front Public Health", "LF power reflects mixed sympathetic, parasympathetic, and baroreflex activity"),
    c("empatica_hrv_fd_vlf", "NA", "Context-dependent", "Shaffer & Ginsberg (2017) Front Public Health", "VLF power reflects thermoregulatory, renin-angiotensin, and slow endocrine mechanisms"),
    c("empatica_hrv_fd_total_power", "1", "Moderate/Cautious", "Task Force ESC/NASPE (1996) Circulation", "Total spectral power reflects overall autonomic capacity"),
    c("empatica_skin_temperature", "NA", "Context-dependent", "Romanovsky (2014) Handb Clin Neurol; Charkoudian (2010) Auton Neurosci", "Skin temperature reflects environmental thermal exchange, convective airflow, and vasomotor tone"),
    c("eyetracker_pupil_diameter_avg", "NA", "Context-dependent", "Cuve et al. (2023) Psychophysiology; Mathot (2018) Front Integr Neurosci", "Pupil diameter is heavily dominated by ambient retinal illuminance and cognitive visual exploration"),
    c("eyetracker_pupil_change_rate", "NA", "Context-dependent", "Cuve et al. (2023) Psychophysiology", "Pupil change rate reflects rapid light transitions and active visual processing across outdoor environments"),
    c("eyetracker_blink_duration_s", "NA", "Context-dependent", "Schleicher et al. (2008) Ergonomics; Bentivoglio et al. (1997) Mov Disord", "Blink duration is modulated by ambient airflow, fatigue, visual attention, and emotional valence"),
    c("eyetracker_fixation_duration_s", "NA", "Context-dependent", "Rayner (1998) Psychol Bull; Berto et al. (2008) J Environ Psychol", "Fixation duration depends on scene complexity, visual task demands, and restorative soft fascination"),
    c("eyetracker_fixation_rate", "NA", "Context-dependent", "Rayner (1998) Psychol Bull", "Fixation rate varies with navigation scanning density and movement velocity"),
    c("eyetracker_saccade_duration_s", "NA", "Context-dependent", "Rayner (1998) Psychol Bull", "Saccade kinematics are task- and navigation-driven in active mobility"),
    c("eyetracker_saccade_amplitude", "NA", "Context-dependent", "Rayner (1998) Psychol Bull; Franconeri et al. (2013) Trends Cogn Sci", "Saccade amplitude reflects spatial extent of visual scanning in urban vs green environments"),
    c("eyetracker_saccade_peak_velocity", "NA", "Context-dependent", "Rayner (1998) Psychol Bull", "Saccade peak velocity is constrained by the main sequence and motor exploration requirements"),
    c("eyetracker_gaze_velocity", "NA", "Context-dependent", "Rayner (1998) Psychol Bull", "Overall gaze velocity reflects active physical mobility speed and environmental hazard tracking"),
    c("eyetracker_gaze_dispersion", "NA", "Context-dependent", "Valtchanov & Ellard (2015) J Environ Psychol", "Visual dispersion reflects visual exploratory breadth vs concentrated forward path tracking"),
    c("eyetracker_distance_from_center", "NA", "Context-dependent", "Tatler (2007) J Vis", "Central visual bias vs peripheral exploration depends on forward travel mode and route obstacles"),
    c("eyetracker_gaze_centrality", "NA", "Context-dependent", "Tatler (2007) J Vis", "Forward gaze concentration is heavily governed by cycling vs walking navigation constraints"),
    c("eyetracker_eyelid_aperture_avg", "NA", "Context-dependent", "Stern et al. (1994) Psychophysiology", "Eyelid aperture is directly influenced by solar glare, wind speed, and alertness")
  )), stringsAsFactors = FALSE)
  names(LIT) <- c("outcome", "pos_exp_sign", "interpretability", "citation", "note")
  LIT$pos_exp_sign <- suppressWarnings(as.numeric(LIT$pos_exp_sign))

  h2_table <- safe_rbind(h2_results_list)
  rownames(h2_table) <- NULL
  if (nrow(h2_table) > 0) {
    h2_table$q_FDR <- p.adjust(h2_table$p_value, method = "BH")
    h2_table$FDR_significant <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05
    k <- match(h2_table$Physiological_Measure, LIT$outcome)
    interp_cat <- ifelse(is.na(k), "Unclassified", LIT$interpretability[k])
    exp_sign <- ifelse(grepl("stai", h2_table$Psychological_Measure, ignore.case = TRUE), -1, 1) * LIT$pos_exp_sign[k]
    sig <- h2_table$FDR_significant
    h2_table$Result <- ifelse(sig, h2_table$Raw_Direction, "No FDR-significant concurrence")
    h2_table$Literature_Expected_Direction <- ifelse(is.na(exp_sign), "Context-dependent", ifelse(exp_sign > 0, "Positive (+)", "Negative (-)"))
    h2_table$Literature_Interpretability <- interp_cat
    h2_table$Literature_Citation <- ifelse(is.na(k), "", LIT$citation[k])
    h2_table$H2_Interpretation <- ifelse(!sig, "No evidence of concurrence (q_FDR >= 0.05)",
      ifelse(interp_cat == "Context-dependent" | is.na(exp_sign), "Significant concurrence; direction not uniquely interpretable",
        ifelse(sign(h2_table$Partial_r_Within) == exp_sign, "Literature-consistent concurrence", "Opposite to literature-expected direction")))
    h2_table$Method_Note <- paste("rmcorr estimates one common within-person slope across the 4 mobility conditions",
      "(Bakdash & Marusich 2017); association includes condition-driven co-variation of psychological and",
      "physiological measures; direction is not uniquely interpretable for context-dependent measures.")
    h2_table$Raw_Direction <- NULL
  }


  # 7. Write Dedicated CSV Tables ------------------------------------------------
  cat("[5/6] Writing corrected, auditable outputs...\n")

  meaning_of <- function(v) unname(LIT$note[match(v, LIT$outcome)])

  phase_lmm_out <- phase_lmm_table
  phase_lmm_out$Outcome_Label   <- label_of(phase_lmm_out$Outcome)
  phase_lmm_out$Outcome_Meaning <- meaning_of(phase_lmm_out$Outcome)
  phase_lmm_out$Units           <- units_of(phase_lmm_out$Outcome)
  phase_lmm_out$How_To_Read <- sprintf("Beta > 0: %s higher in %s than %s; < 0: lower. Beta_CI95_* = 95%% CI on the LMM contrast (emmeans); SMD_CI95_* = Bonett 95%% CI on paired SMD. Beta units: Primary rows = Units (ln(Units) for the 7 HRV outcomes and EDA tonic, notebook transform); Sensitivity_WPZ rows = within-person SD.",
                                 phase_lmm_out$Outcome, phase_lmm_out$Comparison_PhaseID, phase_lmm_out$Reference_PhaseID)
  phase_lmm_out$Method_Citation <- paste(CITE_WPZ, CITE_LMM, CITE_EMM, CITE_FDR, CITE_SMD, sep = " | ")
  phase_lmm_cols <- c("Hypothesis", "Sub_Hypothesis", "Contrast", "Reference_PhaseID", "Comparison_PhaseID",
                "Outcome", "Outcome_Label", "Units", "Outcome_Meaning", "Direction", "How_To_Read",
                "Beta", "SE", "df", "Beta_CI95_low", "Beta_CI95_high", "t_ratio", "p_value", "q_FDR", "FDR_significant", "Family_Size",
                "SMD_paired_Bonett", "SMD_CI95_low", "SMD_CI95_high",
                "Reference_Mean_raw", "Comparison_Mean_raw", "N_Participants",
                "Model_Formula", "Interaction_Test", "Normalization", "Method_Citation")
  phase_lmm_clean_table <- phase_lmm_out[, intersect(phase_lmm_cols, names(phase_lmm_out)), drop = FALSE]

  h2_table$Questionnaire       <- h2_table$Psychological_Measure
  h2_table$Physio              <- h2_table$Physiological_Measure
  h2_table$Physio_Label        <- label_of(h2_table$Physio)
  h2_table$Questionnaire_Label <- label_of(h2_table$Questionnaire)
  h2_table$Physio_Meaning      <- meaning_of(h2_table$Physio)
  pos_sign <- LIT$pos_exp_sign[match(h2_table$Physio, LIT$outcome)]
  h2_table$Literature_Expected_Direction_Anxiety <- ifelse(is.na(pos_sign), "Context-dependent", ifelse(pos_sign > 0, "Lower (-) with higher anxiety", "Higher (+) with higher anxiety"))
  h2_table$Physio_Units        <- unname(ifelse(!is.na(H2_LOG_UNITS[h2_table$Physio]), H2_LOG_UNITS[h2_table$Physio], units_of(h2_table$Physio)))
  h2_table$Direction <- sprintf("Within the same participant, in PhaseIDs where %s was rated higher, %s was %s (r = %.2f)",
                                h2_table$Questionnaire, h2_table$Physio,
                                dir_word(h2_table$Physio, h2_table$Partial_r_Within >= 0), h2_table$Partial_r_Within)
  h2_table$How_To_Read <- "r > 0: both go up together across the participant's own PhaseIDs; r < 0: one goes up as the other goes down. CI95_low/CI95_high are for r. Beta: change in Questionnaire (its own units) per 1 Physio_Units of Physio, within the same participant, from the same lm; SE is its standard error; p_value is the same for r and Beta."
  h2_table$Method_Citation <- paste(CITE_RMC, CITE_FDR, sep = " | ")
  h2_cols <- c("Questionnaire", "Questionnaire_Label", "Physio", "Physio_Label", "Physio_Units", "Physio_Meaning",
               "Direction", "How_To_Read", "Partial_r_Within", "CI95_low", "CI95_high", "Beta", "SE", "t_stat", "df",
               "p_value", "q_FDR", "FDR_significant", "N_PhaseBouts", "N_Participants",
               "Model_Formula", "Literature_Expected_Direction", "Literature_Expected_Direction_Anxiety", "Literature_Interpretability",
               "Literature_Citation", "H2_Interpretation", "Method_Note", "Method_Citation")
  h2_clean_table <- h2_table[, intersect(h2_cols, names(h2_table)), drop = FALSE]
  names(h2_clean_table)[names(h2_clean_table) == "Partial_r_Within"] <- "r_rmcorr"

  # Per-hypothesis files: H1_/H3_ contrasts split by Hypothesis; H1 and H3 share identical temporal AR(1) shells,
  # so the same temporal tables are written under both prefixes; H2 is its own file.
  for (hyp in c("H1", "H3")) {
    safe_write_csv(phase_lmm_clean_table[phase_lmm_clean_table$Hypothesis == hyp, , drop = FALSE], pa_out_path(hyp, "Contrasts.csv"))
    safe_write_csv(temporal_table, pa_out_path(hyp, "Temporal_TimeSeries_AR1.csv"))
    sens_path <- pa_out_path(hyp, "Temporal_AR1_Sensitivity.csv")
    safe_write_csv(temporal_sens_table, sens_path)
    write_temporal_sensitivity_fdr_subset(temporal_sens_table, sub("\\.csv$", "", sens_path))
  }
  safe_write_csv(h2_clean_table, pa_out_path("H2", "Physio_Psycho_Concordance.csv"))
  model_audit_df <- safe_rbind(model_audit)
  safe_write_csv(model_audit_df, pa_out_path("H1_to_H3", "Model_Audit.csv"))

  # 8. Forest Plots -------------------------------------------------------------
  if (MAKE_FIGURES) {
    cat("[6/6] Rendering primary forest plots...\n")
  
    # H1 & H3 forest plot: paired SMD (Bonett 2008) per PhaseID contrast
    plot_df <- phase_lmm_out[phase_lmm_out$Family_Set == "Primary" & is.finite(phase_lmm_out$SMD_paired_Bonett), , drop = FALSE]
    if (nrow(plot_df) > 0) {
      plot_df$Panel <- sprintf("%s %s: %s minus %s", plot_df$Hypothesis, plot_df$Sub_Hypothesis,
                               plot_df$Comparison_PhaseID, plot_df$Reference_PhaseID)
      plot_df$Label <- sprintf("%.2f%s", plot_df$SMD_paired_Bonett, ifelse(!is.na(plot_df$q_FDR) & plot_df$q_FDR < 0.05, "*", ""))
      p_forest <- ggplot(plot_df, aes(x = SMD_paired_Bonett, y = Outcome)) +
        geom_vline(xintercept = 0, linetype = "dashed", linewidth = 0.6) +
        geom_errorbar(aes(xmin = SMD_CI95_low, xmax = SMD_CI95_high), orientation = "y", width = 0.3, linewidth = 0.7) +
        geom_point(size = 2.2) +
        geom_text(aes(label = Label), vjust = -0.7, size = 2.4) +
        facet_wrap(~ Panel, ncol = 4, scales = "free_x") +
        labs(title = "H1 and H3: paired standardized mean difference per PhaseID contrast",
             subtitle = "Positive = higher in the second PhaseID. Bonett (2008) 95% CI on participant-phase means (ln for HRV and EDA tonic). * BH-FDR q < 0.05 from primary lme(outcome ~ PhaseID).",
             x = "Paired standardized mean difference (Bonett 2008)", y = "") +
        theme_minimal(base_size = 9)
      ggsave(pa_out_path("H1_to_H3", "Statistical_Results_ForestPlot.jpg"), plot = p_forest,
             width = 16, height = 10, dpi = 300, device = "jpeg")
    }

  } else {
    cat("[6/6] Figures disabled; statistical outputs only.\n")
  }

  # 9. Run Manifest --------------------------------------------------------------
  script_path <- normalizePath(SCRIPT_PATH, winslash = "/", mustWork = FALSE)

  manifest <- data.frame(
    Script = script_path,
    Script_MD5 = tryCatch(unname(tools::md5sum(script_path)), error = function(e) NA_character_),
    Input_File = RAW_PATH,
    Key_File = ifelse(file.exists(KEY_PATH), KEY_PATH, NA_character_),
    Input_Schema = "Prefixed validated schema",
    Input_MD5 = tryCatch(unname(tools::md5sum(RAW_PATH)), error = function(e) NA_character_),
    Input_Rows = nrow(df),
    Input_Columns = ncol(df),
    Input_Indoor_Rows = sum(df$PhaseID == "Indoor", na.rm = TRUE),
    Input_Tram_Rows = sum(df$PhaseID == "Tram", na.rm = TRUE),
    Available_Declared_Outcomes = length(intersect(all_outcomes, names(df))),
    Missing_Declared_Outcomes = paste(setdiff(all_outcomes, names(df)), collapse = ","),
    Common_Duration_Min_Sec = if (any(is.finite(route$matched_cap_sec))) min(route$matched_cap_sec, na.rm = TRUE) else NA_real_,
    Common_Duration_Max_Sec = if (any(is.finite(route$matched_cap_sec))) max(route$matched_cap_sec, na.rm = TRUE) else NA_real_,
    Primary_Sensor_Model = "lme(<outcome> ~ PhaseID, random = ~1 | ParticipantID), REML, participant-phase means in analysis units (notebook transform: ln(x) for 7 HRV outcomes and EDA tonic), matched first 8 min; 26 physiological outcomes",
    Sensitivity_Sensor_Model = "Same model on within-person z-scores (within_person_z__, computed after the notebook transform); separate BH-FDR family (Family_Set = Sensitivity_WPZ)",
    Matched_Duration_Sensitivity = "Participant-specific common duration across BikeU/BikeG/WalkU/WalkG, capped at 8 minutes from phase start",
    Normalization = "Primary: analysis units (output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_all_parameters.csv transforms) + participant random intercept. Sensitivity and temporal AR(1): within-person z over the 4 core routes (after transform); no Indoor/Tram reference",
    H2_Method = "Within-person rmcorr across 4 core phases (Bakdash & Marusich 2017); 4 questionnaires x 26 physiological outcomes = 104 pairs; one BH-FDR family",
    Temporal_Method = "10-s AR(1) LMM on within-person z outcomes, matched first 8 min",
    Multiple_Testing = "Benjamini-Hochberg FDR (q < 0.05) within declared hypothesis families",
    N_Participants = length(PARTICIPANTS),
    N_Declared_Outcomes = length(all_outcomes),
    Completed_At = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
    H1_Primary_Significant_FDR = sum(phase_lmm_table$Hypothesis == "H1" & phase_lmm_table$Family_Set == "Primary" & phase_lmm_table$FDR_significant),
    H1_Sensitivity_WPZ_Significant_FDR = sum(phase_lmm_table$Hypothesis == "H1" & phase_lmm_table$Family_Set == "Sensitivity_WPZ" & phase_lmm_table$FDR_significant),
    H3_Sensitivity_WPZ_Significant_FDR = sum(phase_lmm_table$Hypothesis == "H3" & phase_lmm_table$Family_Set == "Sensitivity_WPZ" & phase_lmm_table$FDR_significant),
    H3_Primary_Significant_FDR = sum(phase_lmm_table$Hypothesis == "H3" & phase_lmm_table$Family_Set == "Primary" & phase_lmm_table$FDR_significant),
    H2_Significant_FDR = sum(h2_table$FDR_significant),
    Total_Attempted_Models_Audited = nrow(model_audit_df),
    Failed_or_Unstable_Models = sum(grepl("NOT_FIT|FAILED_CONVERGENCE|UNSTABLE", model_audit_df$Status)),
    stringsAsFactors = FALSE
  )
  write.csv(manifest, pa_out_path("H1_to_H3", "Run_Manifest.csv"), row.names = FALSE, na = "")

  cat("   H1 and H3 contrasts:", nrow(phase_lmm_clean_table), "rows | H2 pairs:", nrow(h2_clean_table), "rows\n")
  cat(sprintf("   Model Audit Logged: %d total attempted models (%d fits, %d non-fits/skips logged)\n",
              nrow(model_audit_df), sum(model_audit_df$Status == "FIT"),
              sum(model_audit_df$Status != "FIT")))
  cat("\nSUCCESS: H1 and H3 pipeline finished (H2 included). H4: scripts/statistical_analysis/H4_timeseries.R.\n")
}

tag_hypothesis_rows <- function(result_table, hypothesis_id) {
  if (nrow(result_table) == 0) return(result_table)
  result_table$Hypothesis <- hypothesis_id
  result_table$Analysis_Entry <- paste0(hypothesis_id, "_time_series")
  result_table
}

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
      stop(model_name, " must be defined in the meeting script before dispatch.", call. = FALSE)
    }
  }
  if (!exists("TIME_SERIES_SCRIPT_PATH", envir = .GlobalEnv, inherits = FALSE)) {
    assign("TIME_SERIES_SCRIPT_PATH", file.path(PROJECT_ROOT, "scripts/statistical_analysis/H1_H3_timeseries.R"), envir = .GlobalEnv)
  }

  n_outcomes <- length(study_wide_spec$physiological_outcome_names)
  cat("==============================================================================\n")
  cat(sprintf("Running %s time series: outcome-only 10 s AR(1) LMMs (engine: H1_H3_core.R)\n", hypothesis_id))
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(study_wide_spec$participants), paste(study_wide_spec$participants, collapse = ", ")))
  cat(sprintf("Outcomes (%d): physiological 10 s series (within-person z); no environmental predictors\n\n", n_outcomes))

  cat("[1/3] Loading matched 8-min epoch data...\n")
  route_data_bundle <- h1_h3_load_route_data()
  input_data <- route_data_bundle$df
  route_data <- route_data_bundle$route
  conditions <- route_data_bundle$CONDITIONS
  condition_name <- route_data_bundle$cname
  condition_data <- route_data_bundle$d_cond
  physiological_outcomes <- route_data_bundle$sensor_outcomes
  psychological_outcomes <- route_data_bundle$psych_outcomes
  model_audit <- list()

  cat("[2/3] Fitting 10 s / 60 s AR(1) temporal LMMs...\n")
  temporal_fit <- h1_h3_fit_temporal_ar1(route_data, conditions, physiological_outcomes, model_audit)
  temporal_table <- tag_hypothesis_rows(temporal_fit$temporal_table, hypothesis_id)
  temporal_sens_table <- tag_hypothesis_rows(temporal_fit$temporal_sens_table, hypothesis_id)
  model_audit <- temporal_fit$model_audit

  secondary_table <- NULL
  if (exists("time_series_secondary_fit", envir = .GlobalEnv, inherits = FALSE)) {
    cat("[2b/3] Running hypothesis-specific secondary fit from meeting script...\n")
    secondary_result <- get("time_series_secondary_fit", envir = .GlobalEnv)(list(
      hypothesis = hypothesis_id, input_data = input_data, condition_data = condition_data, condition_name = condition_name,
      physiological_outcomes = physiological_outcomes, psychological_outcomes = psychological_outcomes,
      model_audit = model_audit, OUT_DIR = OUT_DIR
    ))
    if (is.list(secondary_result)) {
      if (!is.null(secondary_result$model_audit)) model_audit <- secondary_result$model_audit
      secondary_table <- secondary_result$table
    }
  }

  cat("[3/3] Writing CSV outputs...\n")
  if (exists("paper3_write_epoch_grid_coverage", mode = "function")) {
    paper3_write_epoch_grid_coverage(condition_data,
      file.path(OUT_DIR, "H1_H3_timeseries_epoch_grid_coverage.csv"))
  }
  safe_write_csv(temporal_table, time_series_output_path("Temporal_TimeSeries_AR1_10s.csv"))
  pc <- temporal_fit$planned_contrasts
  if (!is.null(pc) && nrow(pc) > 0) {
    pc <- pc[pc$Hypothesis == hypothesis_id, , drop = FALSE]
    if (nrow(pc) > 0) safe_write_csv(pc, time_series_output_path("Planned_Phase_Contrasts.csv"))
  }
  safe_write_csv(temporal_sens_table, time_series_output_path("Temporal_AR1_Sensitivity_60s.csv"))
  if (!is.null(secondary_table) && nrow(secondary_table) > 0) {
    secondary_csv_name <- get0("TIME_SERIES_SECONDARY_CSV", envir = .GlobalEnv, ifnotfound = "Secondary_Fit.csv")
    safe_write_csv(secondary_table, time_series_output_path(secondary_csv_name))
  }
  model_audit_df <- safe_rbind(model_audit)
  safe_write_csv(model_audit_df, time_series_output_path("Model_Audit.csv"))

  manifest <- data.frame(
    Script = normalizePath(TIME_SERIES_SCRIPT_PATH, winslash = "/", mustWork = FALSE),
    Engine = "scripts/statistical_analysis/library/H1_H3_core.R",
    Hypothesis = hypothesis_id,
    Input_File = RAW_PATH,
    Output_Directory = OUT_DIR,
    N_Physiological_Outcomes = length(physiological_outcomes),
    N_Temporal_Rows = nrow(temporal_table),
    N_Secondary_Rows = if (is.null(secondary_table)) 0L else nrow(secondary_table),
    Completed_At = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
    stringsAsFactors = FALSE
  )
  manifest_extra <- get0("TIME_SERIES_MANIFEST_EXTRA", envir = .GlobalEnv, ifnotfound = NULL)
  if (!is.null(manifest_extra)) {
    manifest <- cbind(manifest, as.data.frame(as.list(manifest_extra), stringsAsFactors = FALSE))
  }
  write.csv(manifest, time_series_output_path("Run_Manifest.csv"), row.names = FALSE, na = "")

  cat(sprintf("\nSUCCESS: %s time series finished. Outputs: %s\n", hypothesis_id, OUT_DIR))
  invisible(list(temporal_table = temporal_table, temporal_sens_table = temporal_sens_table, secondary = secondary_table))
}

h1_h3_phase_sum_design <- function(phase) {
  phase <- factor(as.character(phase), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  if (anyNA(phase)) stop("Unknown or missing PhaseID for sum-to-zero contrasts")
  design <- stats::model.matrix(~ phase, contrasts.arg = list(phase = stats::contr.sum(4L)))[, -1L, drop = FALSE]
  colnames(design) <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
  design
}

h1_h3_install_time_series_globals <- function() {
  assign("TIME_SERIES_PHASE_SUM_COLUMNS", c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG"), envir = .GlobalEnv)
  if (!exists("paper3_phase_sum_design", envir = .GlobalEnv, inherits = FALSE)) {
    assign("paper3_phase_sum_design", h1_h3_phase_sum_design, envir = .GlobalEnv)
  }
}

h1_h3_clear_time_series_secondary_hook <- function() {
  if (exists("time_series_secondary_fit", envir = .GlobalEnv, inherits = FALSE)) {
    rm("time_series_secondary_fit", envir = .GlobalEnv)
  }
}

h1_h3_assign_time_series_active_models <- function(hypothesis_id) {
  hypothesis_id <- match.arg(hypothesis_id, c("H1", "H2", "H3"))
  assign("TimeSeries_Temporal_AR1_10s_LMM", get(paste0(hypothesis_id, "_TimeSeries_Temporal_AR1_10s_LMM"), envir = .GlobalEnv), envir = .GlobalEnv)
  assign("TimeSeries_Temporal_AR1_60s_LMM", get(paste0(hypothesis_id, "_TimeSeries_Temporal_AR1_60s_LMM"), envir = .GlobalEnv), envir = .GlobalEnv)
}

h1_h3_time_series_secondary_rmcorr <- function(context) {
  model_audit <- context$model_audit
  condition_name <- context$condition_name
  condition_data <- context$condition_data
  input_data <- context$input_data
  physiological_outcomes <- context$physiological_outcomes
  psychological_outcomes <- context$psychological_outcomes
  h2_physio_outcomes <- intersect(physiological_outcomes, names(input_data))
  h2_psych_outcomes <- intersect(psychological_outcomes, names(input_data))
  h2_results_list <- list()
  participant_phase_source <- condition_data[c("ParticipantID", "PhaseID", h2_psych_outcomes, h2_physio_outcomes)]
  participant_phase_means <- aggregate(participant_phase_source[c(h2_psych_outcomes, h2_physio_outcomes)], by = participant_phase_source[c("ParticipantID", "PhaseID")], FUN = mean_na)
  for (psychological_measure in h2_psych_outcomes) for (physiological_measure in h2_physio_outcomes) {
    pair_data <- participant_phase_means[complete.cases(participant_phase_means[c(psychological_measure, physiological_measure)]), c("ParticipantID", psychological_measure, physiological_measure)]
    pair_data <- pair_data[pair_data$ParticipantID %in% names(which(table(pair_data$ParticipantID) >= 2)), , drop = FALSE]
    names(pair_data) <- c("ParticipantID", "psychological_value", "physiological_value")
    pair_data$ParticipantID <- droplevels(factor(pair_data$ParticipantID))
    n_participants <- nlevels(pair_data$ParticipantID)
    if (nrow(pair_data) < 20 || n_participants < 8 || sd(pair_data$physiological_value) == 0) {
      model_audit[[length(model_audit) + 1]] <- audit_row("H2_rmcorr", condition_name, psychological_measure, physiological_measure, "NOT_FIT_INSUFFICIENT_DATA", nrow(pair_data), n_participants,
        warn = "Fewer than 20 bouts or 8 participants")
      next
    }
    h2_call <- H2_rmcorr
    h2_call[[2L]] <- do.call("substitute", list(h2_call[[2L]], list(
      psychological = as.name("psychological_value"),
      physiological = as.name("physiological_value")
    )))
    h2_call$data <- quote(pair_data)
    rmcorr_fit <- eval(h2_call)
    physiological_coefficients <- summary(rmcorr_fit)$coefficients["physiological_value", ]
    residual_df <- rmcorr_fit$df.residual
    t_value <- physiological_coefficients[["t value"]]
    rmcorr_r <- sign(t_value) * sqrt(t_value^2 / (t_value^2 + residual_df))
    fisher_z_ci <- atanh(rmcorr_r) + c(-1, 1) * qnorm(0.975) / sqrt(residual_df - 1)
    model_audit[[length(model_audit) + 1]] <- audit_row("H2_rmcorr", condition_name, psychological_measure, physiological_measure, "FIT", nrow(pair_data), n_participants)
    h2_results_list[[length(h2_results_list) + 1]] <- data.frame(
      Hypothesis = "H2", Analysis_Entry = "H2_time_series",
      Psychological_Measure = psychological_measure, Physiological_Measure = physiological_measure,
      Model_Formula = sprintf("rmcorr: lm(%s ~ ParticipantID + %s), Bakdash & Marusich 2017", psychological_measure, physiological_measure),
      Beta = physiological_coefficients[["Estimate"]], SE = physiological_coefficients[["Std. Error"]], CI95_low = tanh(fisher_z_ci[1]), CI95_high = tanh(fisher_z_ci[2]),
      t_stat = t_value, df = residual_df, p_value = physiological_coefficients[["Pr(>|t|)"]], Partial_r_Within = rmcorr_r,
      N_PhaseBouts = nrow(pair_data), N_Participants = n_participants, stringsAsFactors = FALSE)
  }
  h2_table <- safe_rbind(h2_results_list)
  if (nrow(h2_table) > 0) {
    h2_table$q_FDR <- p.adjust(h2_table$p_value, method = "BH")
    h2_table$FDR_significant <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05
  }
  list(table = h2_table, model_audit = model_audit)
}

h1_h3_prepare_time_series_hypothesis <- function(hypothesis_id) {
  hypothesis_id <- match.arg(hypothesis_id, c("H1", "H2", "H3"))
  h1_h3_clear_time_series_secondary_hook()
  h1_h3_assign_time_series_active_models(hypothesis_id)
  assign("time_series_run_spec", list(hypothesis_label = hypothesis_id), envir = .GlobalEnv)
  manifest_extra <- list(
    PhaseID_Coding = "contr.sum(4): PhaseSumWalkG, PhaseSumWalkU, PhaseSumBikeG; BikeU implicit",
    Corridor_Grid = "additive grid_f (corridor buffer seg_idx); FDR BH by Term across outcomes — grid_f levels are separate Term values"
  )
  if (hypothesis_id == "H1") {
    manifest_extra$Planned_Phase_Contrasts <- paste(h1_hypothesis_spec$contrasts$Contrast, collapse = ", ")
  } else if (hypothesis_id == "H3") {
    manifest_extra$Planned_Phase_Contrasts <- paste(h3_hypothesis_spec$contrasts$Contrast, collapse = ", ")
  }
  assign("TIME_SERIES_MANIFEST_EXTRA", manifest_extra, envir = .GlobalEnv)
  if (hypothesis_id == "H2") {
    assign("TIME_SERIES_SECONDARY_CSV", "Physio_Psycho_Concordance.csv", envir = .GlobalEnv)
    assign("time_series_secondary_fit", h1_h3_time_series_secondary_rmcorr, envir = .GlobalEnv)
  }
}

h1_h3_run_one_time_series <- function(hypothesis_id) {
  h1_h3_prepare_time_series_hypothesis(hypothesis_id)
  h1_h3_time_series_dispatch_run()
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
  for (hypothesis_id in hypotheses) {
    cat(sprintf("--- %s ---\n", hypothesis_id))
    h1_h3_run_one_time_series(hypothesis_id)
  }
  cat("\nSUCCESS: H1–H3 time series dispatch finished.\n")
}

h1_h3_time_series_dispatch_from_env <- function() {
  time_series_hypothesis_arg <- Sys.getenv("PAPER3_TIME_SERIES_HYPOTHESIS", "")
  if (nzchar(time_series_hypothesis_arg)) h1_h3_run_one_time_series(time_series_hypothesis_arg) else h1_h3_run_all_time_series()
}

h1_h3_time_series_autostart <- function(run_all_fn, run_one_fn) {
  stopifnot(is.function(run_all_fn), is.function(run_one_fn))
  time_series_dispatch_from_cli_or_ide <- function() {
    time_series_hypothesis_arg <- Sys.getenv("PAPER3_TIME_SERIES_HYPOTHESIS", "")
    if (nzchar(time_series_hypothesis_arg)) run_one_fn(time_series_hypothesis_arg) else run_all_fn()
  }
  if (interactive() && sys.nframe() > 0L) {
    on.exit({
      .time_series_autorun_lock <- ".__paper3_h1_h3_time_series_autorun_lock__"
      if (!exists(.time_series_autorun_lock, envir = .GlobalEnv, inherits = FALSE)) {
        assign(.time_series_autorun_lock, TRUE, envir = .GlobalEnv)
        on.exit(rm(list = .time_series_autorun_lock, envir = .GlobalEnv), add = TRUE)
        time_series_hypothesis_arg <- Sys.getenv("PAPER3_TIME_SERIES_HYPOTHESIS", "")
        if (nzchar(time_series_hypothesis_arg)) {
          run_one_fn(time_series_hypothesis_arg)
        } else {
          run_all_fn()
        }
      }
    }, add = TRUE)
  }
  if (sys.nframe() == 0L || interactive()) {
    if (!(interactive() && sys.nframe() > 0L)) {
      .time_series_autorun_lock <- ".__paper3_h1_h3_time_series_autorun_lock__"
      if (!exists(.time_series_autorun_lock, envir = .GlobalEnv, inherits = FALSE)) {
        assign(.time_series_autorun_lock, TRUE, envir = .GlobalEnv)
        on.exit(rm(list = .time_series_autorun_lock, envir = .GlobalEnv), add = TRUE)
        time_series_dispatch_from_cli_or_ide()
      }
    }
  }
}

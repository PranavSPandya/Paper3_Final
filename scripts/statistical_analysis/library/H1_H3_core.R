# Shared code for H1-H3: phase-mean contrasts, H2 rmcorr and temporal AR(1) models; sourced by H1_H3_phaseavg.R and H1_H3_timeseries.R.

# End-of-phase questionnaire items (H2 rmcorr; H1/H3 questionnaire contrasts).
PSYCH_OUTCOMES <- c(
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

SENSOR_OUTCOMES <- study_wide_spec$physiological_outcome_names
CORE_PHASES <- study_wide_spec$phases
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
# Units of the raw participant-phase means; H2_LOG_UNITS gives the units of the log-transformed outcomes.
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

ci95 <- function(estimate, se, df) list(estimate - qt(0.975, df) * se, estimate + qt(0.975, df) * se)

fit_phase_lmm <- function(model_call, data) {
  model_call[[2L]][[2L]] <- as.name("model_y")
  model_call$data <- quote(data)
  model_call$na.action <- quote(na.omit)
  model_call$control <- quote(lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = TRUE))
  tryCatch(eval(model_call), error = function(local_error) NULL)}

# Enough rows, participants and variation to fit (sparse questionnaire items fail this).
model_data_ok <- function(data, min_rows, min_participants) {
  nrow(data) >= min_rows && length(unique(data$ParticipantID)) >= min_participants &&
    is.finite(sd(data$model_y)) && sd(data$model_y) != 0}

# H1/H3 effect size: paired SMD (Bonett 2008) via statpsych::ci.stdmean.ps on participant-phase means; p/q come from the LMM.
paired_smd <- function(analysis_data, outcome, ref, comp) {
  na3 <- c(g = NA_real_, low = NA_real_, high = NA_real_)
  paired_data <- merge(analysis_data[ref, c("ParticipantID", outcome)], analysis_data[comp, c("ParticipantID", outcome)],
             by = "ParticipantID", suffixes = c(".ref", ".comp"))
  x <- as.numeric(paired_data[[2]]); y <- as.numeric(paired_data[[3]])
  ok <- is.finite(x) & is.finite(y); x <- x[ok]; y <- y[ok]
  if (length(x) < 4 || sd(x) == 0 || sd(y) == 0) return(na3)
  ci <- statpsych::ci.stdmean.ps(0.05, mean(y), mean(x), sd(y), sd(x), cor(x, y), length(x))
  c(g = ci[1, "adj Estimate"], low = ci[1, "LL"], high = ci[1, "UL"])}

# Planned H1/H3 contrasts from one phase-mean LMM, plus the descriptive difference of differences.
extract_phase_lmm_contrasts <- function(fit, analysis_data, outcome, family_set, normalization) {
  contrast_rows <- rbind(planned_h1_h3$h1, planned_h1_h3$h3)
  lv <- levels(analysis_data$PhaseID)
  wvec <- function(plus, minus) { w <- setNames(rep(0, length(lv)), lv); w[plus] <- 1; w[minus] <- -1; unname(w) }
  em <- emmeans(fit, ~ PhaseID)
  cm <- setNames(lapply(seq_len(nrow(contrast_rows)), function(index)
    wvec(contrast_rows$Comparison_PhaseID[index], contrast_rows$Reference_PhaseID[index])), contrast_rows$Contrast)
  did <- list(DiD = wvec(c("BikeG", "WalkU"), c("BikeU", "WalkG")))
  cc <- rbind(as.data.frame(summary(contrast(em, method = cm), infer = c(TRUE, TRUE))),
    as.data.frame(summary(contrast(em, method = did), infer = c(TRUE, TRUE))))
  ids <- analysis_data$ParticipantID
  n_pairs <- vapply(seq_len(nrow(contrast_rows)), function(index) length(intersect(ids[analysis_data$PhaseID == contrast_rows$Reference_PhaseID[index]],
    ids[analysis_data$PhaseID == contrast_rows$Comparison_PhaseID[index]])), integer(1))
  smd <- t(vapply(seq_len(nrow(contrast_rows)), function(index) paired_smd(analysis_data, outcome,
    analysis_data$PhaseID == contrast_rows$Reference_PhaseID[index], analysis_data$PhaseID == contrast_rows$Comparison_PhaseID[index]), numeric(3)))
  data.frame(
    Hypothesis = c(contrast_rows$Hypothesis, "H3 descriptive DiD"), Contrast = c(contrast_rows$Contrast, "(BikeG - BikeU) - (WalkG - WalkU)"),
    Reference_PhaseID = c(contrast_rows$Reference_PhaseID, NA), Comparison_PhaseID = c(contrast_rows$Comparison_PhaseID, NA),
    Outcome = outcome, Units = units_of(outcome), Beta = cc$estimate, SE = cc$SE, df = cc$df, t_ratio = cc$t.ratio, p_value = cc$p.value,
    Beta_CI95_low = cc$lower.CL, Beta_CI95_high = cc$upper.CL, N_Participants = c(n_pairs, length(unique(ids))),
    SMD_paired_Bonett = c(smd[, "g"], NA), SMD_CI95_low = c(smd[, "low"], NA), SMD_CI95_high = c(smd[, "high"], NA),
    Normalization = normalization, Family_Set = family_set, N_Complete_Pairs = c(n_pairs, NA),
    Effect_Note = c(rep(NA, nrow(contrast_rows)), "descriptive difference of differences, not FDR-adjusted"), stringsAsFactors = FALSE)}

# Phase-mean LMMs for one outcome set (Primary and within-person z), BH within hypothesis x set x contrast x normalization.
fit_phase_contrasts <- function(phase_df, outcomes, normalization) {
  rows <- list()
  for (family_set in c("Primary", "Sensitivity_WPZ")) for (outcome in outcomes) {
    value_col <- if (family_set == "Primary") outcome else paste0("within_person_z__", outcome)
    analysis_data <- phase_df[complete.cases(phase_df[, c(value_col, "PhaseID", "ParticipantID")]), ]
    analysis_data$model_y <- analysis_data[[value_col]]
    if (!model_data_ok(analysis_data, 24, 8)) next
    fit <- fit_phase_lmm(if (family_set == "Primary") H1_PhaseMean_Primary_LMM else H1_PhaseMean_Sensitivity_WPZ_LMM, analysis_data)
    if (!is.null(fit)) rows[[length(rows) + 1L]] <- extract_phase_lmm_contrasts(fit, analysis_data, outcome, family_set, normalization[[family_set]])}
  tab <- do.call(rbind, rows)
  planned <- tab$Hypothesis %in% c("H1", "H3")
  key <- paste(tab$Hypothesis, tab$Family_Set, tab$Contrast, tab$Normalization)
  tab$q_FDR <- ifelse(planned, ave(tab$p_value, key, FUN = function(p) p.adjust(p, method = "BH", n = length(outcomes))), NA_real_)
  tab$Family_Size <- ifelse(planned, length(outcomes), NA_integer_)
  rbind(tab[planned, ], tab[!planned, ])}

# Fits with a fixed-effect SE above 10 on the z scale are unusable; they are reported but not tested.
H1_H3_DEGENERATE_NOTE <- "degenerate fit (fixed-effect SE > 10 on the within-person z scale)"
h1_h3_degenerate_fit <- function(t_table) {
  se <- t_table[, "Std.Error"]
  any(!is.finite(se)) || any(se > 10)}

# Outcome-only AR(1) model: optim first, nlminb as the fallback.
fit_ar1_with_fallback <- function(epoch_data, model_call) {
  ar1_formula <- formula(eval(model_call$correlation))
  fit_one <- function(optimizer, is_primary) {
    control_settings <- if (is_primary) lmeControl(opt = "optim", maxIter = 200, msMaxIter = 200, returnObject = TRUE) else
      lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = optimizer)
    ar1_correlation <- if (is_primary) corAR1(form = ar1_formula) else corAR1(value = 0.2, form = ar1_formula)
    model_call[[2L]][[2L]] <- as.name("model_y")
    model_call$data <- quote(epoch_data)
    model_call$correlation <- quote(ar1_correlation)
    model_call$na.action <- quote(na.omit)
    model_call$control <- quote(control_settings)
    tryCatch(eval(model_call), error = function(local_error) NULL)}
  fitted_model <- fit_one("optim", TRUE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "optim (primary)"))
  fitted_model <- fit_one("nlminb", FALSE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "nlminb (fallback)"))
  list(fit = NULL, method = "none (not converged)")}

ar1_rho <- function(fit) if (is.null(fit)) NA_real_ else tryCatch(as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(local_error) NA_real_)

# One fit's rows: every non-intercept term with the selected tTable columns (NA when the fit failed).
term_rows <- function(outcome, terms, t_table, column_map) {
  values <- lapply(column_map, function(column_name) if (is.null(t_table)) NA_real_ else t_table[terms, column_name])
  data.frame(Outcome = outcome, Term = terms, values, stringsAsFactors = FALSE)}

attach_phase_sum_columns <- function(epoch_data) {
  epoch_data[c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")] <- paper3_phase_sum_design(epoch_data$PhaseID)
  if ("time_10s_step" %in% names(epoch_data)) epoch_data$time_10s_step_integer <- as.integer(epoch_data$time_10s_step)
  epoch_data$PhaseID <- factor(as.character(epoch_data$PhaseID), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  epoch_data}

# Weights on the contr.sum(4) columns so Beta = Comparison - Reference (BikeU = -1,-1,-1).
H1_H3_SUM_CONTRASTS <- data.frame(Hypothesis = c("H1", "H1", "H3", "H3"), Sub_Hypothesis = c("H1.1", "H1.2", "H3.1", "H3.2"),
  Contrast = c("BikeU_BikeG", "WalkU_WalkG", "BikeU_WalkU", "BikeG_WalkG"), Reference_PhaseID = c("BikeU", "WalkU", "BikeU", "BikeG"),
  Comparison_PhaseID = c("BikeG", "WalkG", "WalkU", "WalkG"), PhaseSumWalkG = c(1, 1, 1, 1), PhaseSumWalkU = c(1, -1, 2, 0),
  PhaseSumBikeG = c(2, 0, 1, -1), stringsAsFactors = FALSE)

h1_h3_sum_contrasts <- function(fit, outcome, status) {
  tt <- summary(fit)$tTable
  V <- vcov(fit)
  rows <- list()
  for (index in seq_len(nrow(H1_H3_SUM_CONTRASTS))) for (effect in c("phase_level", "phase_slope")) {
    spec <- H1_H3_SUM_CONTRASTS[index, ]
    L <- setNames(rep(0, nrow(tt)), rownames(tt))
    suffix <- if (effect == "phase_slope") ":time_min" else ""
    for (column in c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")) L[paste0(column, suffix)] <- spec[[column]]
    beta <- sum(L * tt[, "Value"])
    se <- sqrt(as.numeric(t(L) %*% V %*% L))
    df <- min(tt[, "DF"], na.rm = TRUE)
    t_ratio <- beta / se
    rows[[length(rows) + 1L]] <- data.frame(spec[1:5], Effect = effect, Beta = beta, SE = se, df = df, t_ratio = t_ratio,
      p_value = if (status == "DEGENERATE_FIT") NA_real_ else 2 * pt(-abs(t_ratio), df), Outcome = outcome, Status = status)}
  do.call(rbind, rows)}

# 10 s AR(1) models per sensor outcome, the 60 s sensitivity refit and, with sum coding, the planned phase contrasts.
h1_h3_fit_temporal_ar1 <- function(route_epoch_data) {
  temporal_rows <- sensitivity_rows <- planned_rows <- list()
  use_phase_sum_coding <- "PhaseSumWalkG" %in% all.vars(Temporal_AR1_10s_LMM[[2L]])
  route_epoch_data$time_10s_step <- round(route_epoch_data$time_in_phase_sec / 10)
  route_epoch_data$PhaseID <- factor(route_epoch_data$PhaseID, levels = CORE_PHASES)
  for (outcome in SENSOR_OUTCOMES) {
    z_column <- paste0("within_person_z__", outcome)
    epoch_data <- route_epoch_data[complete.cases(route_epoch_data[, c("ParticipantID", "PhaseID", "time_min", "time_10s_step", z_column)]), ]
    epoch_data$model_y <- epoch_data[[z_column]]
    # Centre time_min so the phase terms are differences at the mean analysed time, not at bout start.
    if (use_phase_sum_coding) {
      epoch_data$time_min <- epoch_data$time_min - mean(epoch_data$time_min)
      epoch_data <- attach_phase_sum_columns(epoch_data)}
    epoch_data <- epoch_data[order(epoch_data$ParticipantID, epoch_data$PhaseID, epoch_data$time_10s_step), ]
    if (!model_data_ok(epoch_data, 100, 8)) next
    fit_10s <- fit_ar1_with_fallback(epoch_data, Temporal_AR1_10s_LMM)
    all_terms <- colnames(model.matrix(as.formula(paste("~", if (use_phase_sum_coding)
      "(PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min" else "PhaseID * time_min")), data = epoch_data))[-1L]

    epoch_data_60s <- epoch_data
    epoch_data_60s$time_60s_step <- floor(epoch_data_60s$time_10s_step / 6)
    epoch_data_60s <- aggregate(cbind(model_y, time_min) ~ ParticipantID + PhaseID + time_60s_step, data = epoch_data_60s, FUN = mean)
    if (use_phase_sum_coding) epoch_data_60s <- attach_phase_sum_columns(epoch_data_60s) else
      epoch_data_60s$PhaseID <- factor(epoch_data_60s$PhaseID, levels = CORE_PHASES)
    epoch_data_60s <- epoch_data_60s[order(epoch_data_60s$ParticipantID, epoch_data_60s$PhaseID, epoch_data_60s$time_60s_step), ]
    fit_60s <- fit_ar1_with_fallback(epoch_data_60s, Temporal_AR1_60s_LMM)
    t_table_60s <- if (!is.null(fit_60s$fit)) summary(fit_60s$fit)$tTable
    if (!is.null(t_table_60s) && h1_h3_degenerate_fit(t_table_60s)) t_table_60s[, "p-value"] <- NA_real_
    sensitivity_rows[[length(sensitivity_rows) + 1L]] <- data.frame(
      term_rows(outcome, all_terms, t_table_60s, c(Beta_60s = "Value", SE_60s = "Std.Error", statistic_60s = "t-value", df_60s = "DF", p_value_60s = "p-value")),
      AR1_phi_60s = ar1_rho(fit_60s$fit), Fit_Method_60s = fit_60s$method, N_epochs_60s = nrow(epoch_data_60s),
      n_participants_60s = length(unique(epoch_data_60s$ParticipantID)))

    t_table_10s <- if (!is.null(fit_10s$fit)) summary(fit_10s$fit)$tTable
    status <- if (is.null(t_table_10s)) "FAILED_CONVERGENCE" else if (h1_h3_degenerate_fit(t_table_10s)) "DEGENERATE_FIT" else "FIT"
    # Degenerate fits are reported (estimates, SE) but not tested: p left blank and excluded from BH.
    if (status == "DEGENERATE_FIT") t_table_10s[, "p-value"] <- NA_real_
    if (status != "FAILED_CONVERGENCE" && use_phase_sum_coding) planned_rows[[length(planned_rows) + 1L]] <- h1_h3_sum_contrasts(fit_10s$fit, outcome, status)
    terms <- if (status != "FAILED_CONVERGENCE") setdiff(rownames(t_table_10s), "(Intercept)") else all_terms
    temporal_rows[[length(temporal_rows) + 1L]] <- data.frame(
      term_rows(outcome, terms, t_table_10s, c(Beta = "Value", SE = "Std.Error", t_stat = "t-value", df = "DF", p_value = "p-value")),
      Normalization = "Within-Person Z-score", Duration = "Matched_start_8min", AR1_phi = ar1_rho(fit_10s$fit),
      N_epochs = nrow(epoch_data), N_participants = length(unique(epoch_data$ParticipantID)), Status = status)}

  family_size <- length(SENSOR_OUTCOMES)
  temporal <- do.call(rbind, temporal_rows)
  temporal$Family_Size <- family_size
  temporal$q_FDR <- ave(temporal$p_value, temporal$Term, FUN = function(p) p.adjust(p, method = "BH", n = family_size))
  temporal$Stability_Flag <- ifelse(temporal$Status == "FAILED_CONVERGENCE", "not converged: no p, not in BH family",
    ifelse(temporal$Status == "DEGENERATE_FIT", paste0(H1_H3_DEGENERATE_NOTE, ": no p, not in BH family"),
    ifelse(!is.na(temporal$AR1_phi) & temporal$AR1_phi > 0.95, "rho > 0.95, interpret cautiously", "")))
  temporal[c("Beta_CI95_low", "Beta_CI95_high")] <- ci95(temporal$Beta, temporal$SE, temporal$df)
  sensitivity <- do.call(rbind, sensitivity_rows)
  sensitivity$Family_Size <- family_size
  sensitivity$q_FDR_60s <- ave(sensitivity$p_value_60s, sensitivity$Term, FUN = function(p) p.adjust(p, method = "BH", n = family_size))
  sensitivity[c("Beta_CI95_60s_low", "Beta_CI95_60s_high")] <- ci95(sensitivity$Beta_60s, sensitivity$SE_60s, sensitivity$df_60s)
  # The 10 s estimates sit beside the 60 s ones in the sensitivity table.
  primary <- temporal[c("Outcome", "Term", "Beta", "SE", "df", "Beta_CI95_low", "Beta_CI95_high", "p_value", "q_FDR", "Stability_Flag")]
  sensitivity <- merge(primary, sensitivity, by = c("Outcome", "Term"), all = TRUE, sort = FALSE)
  planned <- do.call(rbind, planned_rows)
  if (!is.null(planned)) {
    planned$q_FDR <- ave(planned$p_value, planned$Hypothesis, planned$Effect, FUN = function(p) p.adjust(p, method = "BH"))
    planned$Effect_Note <- ifelse(planned$Status == "DEGENERATE_FIT", paste0(H1_H3_DEGENERATE_NOTE, ": no p, not in BH family"),
      ifelse(planned$Effect == "phase_level", "phase difference at the mean analysed time (time_min centred)", "difference in per-minute slope"))}
  list(temporal = temporal, sensitivity = sensitivity, planned = planned)}

# Matched 8-min route rows with transformed outcomes and within-person z columns.
h1_h3_load_route_data <- function() {
  route <- read.csv(paper3_merged_8min_path(PROJECT_ROOT), check.names = FALSE, stringsAsFactors = FALSE)
  route <- route[route$ParticipantID %in% study_wide_spec$participants & route$PhaseID %in% CORE_PHASES, ]
  route$Datetime <- as.POSIXct(route$Datetime, tz = "UTC")
  route$ParticipantID <- factor(route$ParticipantID, levels = study_wide_spec$participants)
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]
  for (outcome in SENSOR_OUTCOMES) route[[outcome]] <- paper3_apply_csv_transform(route[[outcome]], outcome, study_wide_spec$outcome_transforms_csv)
  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID, FUN = function(x) x - min(x, na.rm = TRUE))
  route$time_min <- route$time_in_phase_sec / 60
  route <- paper3_merge_common_cap(route, CORE_PHASES, study_wide_spec$matched_cap_sec)
  # Within-person z on the analysed (matched-cap) rows only.
  route <- route[!is.na(route$Common_cap) & route$time_in_phase_sec <= route$Common_cap, ]
  for (outcome in c(SENSOR_OUTCOMES, PSYCH_OUTCOMES))
    route[[paste0("within_person_z__", outcome)]] <- paper3_within_person_z(route[[outcome]], route$ParticipantID)
  route}

h1_h3_write <- function(tables) {
  for (name in names(tables)) write.csv(tables[[name]], file.path(OUT_DIR, name), row.names = FALSE)
  p3_finalize_directory(OUT_DIR)}

# Time-series run: the 10 s / 60 s AR(1) tables and the planned 10 s phase contrasts.
h1_h3_run_timeseries <- function() {
  temporal <- h1_h3_fit_temporal_ar1(h1_h3_load_route_data())
  label <- function(table) data.frame(Hypothesis = "H1/H3", Analysis_Entry = "H1_H3_time_series_shared_model", table)
  planned <- temporal$planned[order(temporal$planned$Hypothesis != "H1"), ]
  h1_h3_write(list(H1_H3_Temporal_AR1_10s.csv = label(temporal$temporal), H1_H3_Temporal_AR1_Sensitivity_60s.csv = label(temporal$sensitivity),
    H1_H3_Planned_Contrasts_10s.csv = data.frame(Table = "Planned_Phase_Contrasts", planned)))}

# Phase-average run: H1/H3 contrasts, H2 concordance and the temporal AR(1) tables.
h1_h3_run_phaseavg <- function() {
  route <- h1_h3_load_route_data()
  # Participant-phase means: one row per participant x phase (N = 44); questionnaires are constant within a phase.
  phase_vars <- unique(c(SENSOR_OUTCOMES, PSYCH_OUTCOMES, paste0("within_person_z__", SENSOR_OUTCOMES), paste0("within_person_z__", PSYCH_OUTCOMES)))
  phase_df <- aggregate(route[phase_vars], by = route[c("ParticipantID", "PhaseID")], FUN = mean_na)
  phase_df$ParticipantID <- factor(phase_df$ParticipantID, levels = study_wide_spec$participants)
  phase_df$PhaseID <- factor(phase_df$PhaseID, levels = CORE_PHASES)
  physio <- fit_phase_contrasts(phase_df, SENSOR_OUTCOMES, c(Primary = "Primary: transformed outcome (normalization CSV), random intercept",
    Sensitivity_WPZ = "Sensitivity: within-person z-score over the 4 phases (after the normalization-CSV transform)"))
  quest <- fit_phase_contrasts(phase_df, PSYCH_OUTCOMES, c(Primary = "Primary: raw questionnaire scale (no transform), random intercept",
    Sensitivity_WPZ = "Sensitivity: within-person z-score over the 4 phases (raw questionnaire scale, no transform)"))
  planned <- function(table) table[table$Hypothesis %in% c("H1", "H3"), ]
  contrasts <- data.table::rbindlist(list(Physiological = planned(physio), Questionnaire = planned(quest),
    Physiological = physio[!physio$Hypothesis %in% c("H1", "H3"), ], Questionnaire = quest[!quest$Hypothesis %in% c("H1", "H3"), ]),
    fill = TRUE, idcol = "Outcome_Type")

  # H2: rmcorr (Bakdash & Marusich 2017) on participant-phase means, 18 questionnaires x 26 outcomes, one BH family.
  h2_rows <- list()
  h2_means <- aggregate(route[c(PSYCH_OUTCOMES, SENSOR_OUTCOMES)], by = route[c("ParticipantID", "PhaseID")], FUN = mean_na)
  for (psych_var in PSYCH_OUTCOMES) for (phys_var in SENSOR_OUTCOMES) {
    x <- h2_means[complete.cases(h2_means[c(psych_var, phys_var)]), c("ParticipantID", psych_var, phys_var)]
    x <- x[x$ParticipantID %in% names(which(table(x$ParticipantID) >= 2)), , drop = FALSE]
    names(x) <- c("ParticipantID", "psych", "phys")
    x$ParticipantID <- droplevels(factor(x$ParticipantID))
    n_pid <- nlevels(x$ParticipantID)
    if (nrow(x) < 20 || n_pid < 8 || sd(x$phys) == 0) next
    h2_call <- H2_rmcorr
    h2_call[[2L]] <- do.call("substitute", list(h2_call[[2L]], list(psychological = as.name("psych"), physiological = as.name("phys"))))
    h2_call$data <- quote(x)
    f_rm <- eval(h2_call)
    cf <- summary(f_rm)$coefficients["phys", ]
    dfr <- f_rm$df.residual
    t_val <- cf[["t value"]]
    r_rm <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + dfr))
    z_ci <- atanh(r_rm) + c(-1, 1) * qnorm(0.975) / sqrt(dfr - 1)   # Fisher-z CI (Bakdash & Marusich 2017)
    h2_rows[[length(h2_rows) + 1L]] <- data.frame(Questionnaire = psych_var, Physio = phys_var,
      Physio_Units = unname(ifelse(!is.na(H2_LOG_UNITS[phys_var]), H2_LOG_UNITS[phys_var], units_of(phys_var))),
      r_rmcorr = r_rm, CI95_low = tanh(z_ci[1]), CI95_high = tanh(z_ci[2]), Beta = cf[["Estimate"]], SE = cf[["Std. Error"]],
      t_stat = t_val, df = dfr, p_value = cf[["Pr(>|t|)"]], N_PhaseBouts = nrow(x), N_Participants = n_pid, stringsAsFactors = FALSE)}
  h2 <- do.call(rbind, h2_rows)
  h2$q_FDR <- p.adjust(h2$p_value, method = "BH")

  # Restoration concordance: Spearman of Green-minus-Urban delta PRS vs each delta, per mode, one BH family of 6 tests.
  concord_vars <- c("eyetracker_fixation_rate", "eyetracker_fixation_duration_s", "empatica_eda_tonic")
  concord_rows <- list()
  for (concord_mode in c("Bike", "Walk")) {
    pairs <- merge(phase_df[phase_df$PhaseID == paste0(concord_mode, "U"), ], phase_df[phase_df$PhaseID == paste0(concord_mode, "G"), ],
      by = "ParticipantID", suffixes = c("_U", "_G"))
    psych_delta <- pairs$questionnaire_prs11_fascination_mean_1_5_G - pairs$questionnaire_prs11_fascination_mean_1_5_U
    for (concord_var in concord_vars) {
      outcome_delta <- pairs[[paste0(concord_var, "_G")]] - pairs[[paste0(concord_var, "_U")]]
      ok <- is.finite(psych_delta) & is.finite(outcome_delta)
      rho <- p_value <- NA_real_
      if (sum(ok) >= 7L && sd(psych_delta[ok]) > 0 && sd(outcome_delta[ok]) > 0) {
        z <- suppressWarnings(cor.test(psych_delta[ok], outcome_delta[ok], method = "spearman", exact = FALSE))
        rho <- unname(z$estimate); p_value <- z$p.value}
      concord_rows[[length(concord_rows) + 1L]] <- data.frame(Mode = concord_mode, Psych = "delta_PRS", Outcome = paste0("delta_", concord_var),
        Units = unname(ifelse(!is.na(H2_LOG_UNITS[concord_var]), H2_LOG_UNITS[concord_var], units_of(concord_var))), N = sum(ok), rho = rho, p = p_value)}}
  concord <- do.call(rbind, concord_rows)
  concord$q <- NA_real_
  tested <- is.finite(concord$p)
  concord$q[tested] <- p.adjust(concord$p[tested], method = "BH", n = 6)

  temporal <- h1_h3_fit_temporal_ar1(route)
  temporal_combined <- data.table::rbindlist(list(`10s main` = temporal$temporal, `60s sensitivity` = temporal$sensitivity), fill = TRUE, idcol = "Analysis")
  h1_h3_write(list(H1_H3_Contrasts.csv = contrasts,
    H2_Concordance.csv = data.table::rbindlist(list(H2_rmcorr_physio_psycho = h2, H2_restoration_deltaPRS_spearman = concord), fill = TRUE, idcol = "Test"),
    H1_H3_Temporal_AR1.csv = data.frame(Hypothesis = "H1 and H3 (shared PhaseID model)", temporal_combined, check.names = FALSE)))}

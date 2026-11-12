# H4_sound_literature_helpers.R — shared utilities for H4_sound_literature_tests.R
# Field evidence set (2026-11-02): outdoor/naturalistic sources replace the six climate-chamber
# templates (Jo 2019, Yousefinezhad 2026, Dehghan 2017, Molaeifar 2020, Tohidi 2025, Abbasi 2020),
# which are archived under scripts/statistical_analysis/_archive/ (tier lab_precedent_archived).
# Anchors Rodrigues 2026 (trip LMM) and Kraus 2013 (piecewise Leq) are unchanged.

benjamini_hochberg <- function(p) {
  q <- rep(NA_real_, length(p))
  finite_p <- is.finite(p)
  q[finite_p] <- p.adjust(p[finite_p], 'BH')
  q}
z_score <- function(x) (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
mean_energy_level_db <- function(level_db) 10 * log10(mean(10^(level_db / 10), na.rm = TRUE))
rbind_nested_frames <- function(nested) {
  do.call(rbind, unlist(unlist(nested, recursive = FALSE), recursive = FALSE))}
outcome_transform_label <- function(transforms, outcome_name) {
  transforms$transformation_in_models[match(outcome_name, transforms$column_name)]}
paired_t_from_columns <- function(mat, col_a, col_b, min_n = 3L) {
  n <- nrow(mat)
  diff <- mat[, col_a] - mat[, col_b]
  stats <- list(n = n, mean_a = NA, mean_b = NA, mean_diff = NA, t = NA, df = NA, p = NA, ci = c(NA, NA))
  if (n >= min_n && is.finite(sd(diff)) && sd(diff) > 0) {
    tt <- t.test(mat[, col_a], mat[, col_b], paired = TRUE)
    stats$mean_a <- mean(mat[, col_a])
    stats$mean_b <- mean(mat[, col_b])
    stats$mean_diff <- unname(tt$estimate)
    stats$t <- unname(tt$statistic)
    stats$df <- unname(tt$parameter)
    stats$p <- tt$p.value
    stats$ci <- tt$conf.int}
  stats}
extract_lm_anova_term <- function(model_formula, data, term_name) {
  anova_table <- anova(lm(model_formula, data = data))
  row_names <- trimws(rownames(anova_table))
  if (!any(row_names == term_name)) return(c(NA, NA))
  c(anova_table[row_names == term_name, 'F value'], anova_table[row_names == term_name, 'Pr(>F)'])}
fdr_catalog_row <- function(paper, test, outcome, est, p, q) {
  data.frame(
    paper = paper, test = test, outcome = outcome, estimate = est, p = p, q_BH = q,
    sig_p05 = is.finite(p) & p < 0.05, survives_FDR_q05 = is.finite(q) & q < 0.05)}
significance_summary_row <- function(paper, test, p, q, outcome_labels) {
  finite_p <- is.finite(p)
  data.frame(
    paper = paper, sound_test = test, n_tests = sum(finite_p), n_p_lt_05 = sum(finite_p & p < 0.05),
    n_q_lt_05 = sum(finite_p & is.finite(q) & q < 0.05),
    significant_p = paste(outcome_labels[finite_p & p < 0.05], collapse = '; '),
    surviving_FDR = paste(outcome_labels[finite_p & is.finite(q) & q < 0.05], collapse = '; '))}

# Cardiovascular outcomes matching the Moshammer 2019 ambulatory ECG endpoints (BP unavailable).
H4_CARDIOVASCULAR_OUTCOMES <- c(
  'empatica_heart_rate', 'empatica_hrv_td_sdnn', 'empatica_hrv_td_rmssd',
  'empatica_hrv_fd_lf', 'empatica_hrv_fd_hf', 'empatica_hrv_fd_lf_hf_ratio',
  'empatica_hrv_fd_lfnu', 'empatica_hrv_fd_hfnu')

# One row per participant x phase bout with measured-exposure summaries (energy-mean Leq, thermal,
# activity, end-of-phase perception items) and transformed outcome means. Shared by the Moshammer,
# Jin block. Rodrigues keeps its own trip_summaries below.
build_phase_frame <- function(epochs, outcomes, participant_phase_bout) {
  phase_frame <- do.call(rbind, lapply(split(seq_len(nrow(epochs)), participant_phase_bout), function(bout_row_indices) {
    frame_row <- data.frame(
      ParticipantID = epochs$ParticipantID[bout_row_indices[1]], PhaseID = epochs$PhaseID[bout_row_indices[1]],
      Leq = mean_energy_level_db(epochs$ucm_SND_dBA[bout_row_indices]),
      dba_mean = mean(epochs$ucm_SND_dBA[bout_row_indices], na.rm = TRUE),
      air_temp_mean = mean(epochs$ucm_AIR_temp[bout_row_indices], na.rm = TRUE),
      utci_mean = mean(epochs$ucm_UTCI[bout_row_indices], na.rm = TRUE),
      rh_mean = mean(epochs$ucm_AIR_RH[bout_row_indices], na.rm = TRUE),
      met_mean = mean(epochs$empatica__met[bout_row_indices], na.rm = TRUE),
      loud_epoch_fraction = mean(epochs$ucm_SND_dBA[bout_row_indices] >= 65, na.rm = TRUE),
      n_epochs = length(bout_row_indices))
    for (questionnaire_column in c('questionnaire_thermal_comfort_1_5', 'questionnaire_environmental_comfort_mean_1_5')) {
      questionnaire_values <- suppressWarnings(as.numeric(epochs[[questionnaire_column]][bout_row_indices]))
      questionnaire_values <- questionnaire_values[is.finite(questionnaire_values)]
      frame_row[[questionnaire_column]] <- if (length(questionnaire_values)) questionnaire_values[1] else NA_real_}
    for (outcome_name in outcomes) {
      frame_row[[paste0(outcome_name, '__tr')]] <-
        mean(epochs[[paste0(outcome_name, '__tr')]][bout_row_indices], na.rm = TRUE)}
    frame_row
  }))
  for (column_name in names(phase_frame)[-(1:2)]) phase_frame[[column_name]][!is.finite(phase_frame[[column_name]])] <- NA_real_
  phase_frame$Leq_per5 <- (phase_frame$Leq - 65) / 5
  phase_frame}

lme_coefficient_row <- function(mixed_model_fit, term_name) {
  coefficient_table <- summary(mixed_model_fit)$tTable
  if (!term_name %in% rownames(coefficient_table)) return(c(beta = NA, se = NA, df = NA, t = NA, p = NA))
  c(
    beta = coefficient_table[term_name, 'Value'], se = coefficient_table[term_name, 'Std.Error'],
    df = coefficient_table[term_name, 'DF'], t = coefficient_table[term_name, 't-value'],
    p = coefficient_table[term_name, 'p-value'])}

# --- Moshammer et al. (2019) block (a): temperature-adjusted phase-level LMM -------------------
# outcome_tr ~ Leq_per5 + met_mean (+ air_temp_mean) + (1 | ParticipantID), REML; per-5 dB slope
# reported with and without the temperature term (the source's key robustness claim).
moshammer_lmm_rows <- function(phase_frame, outcome_name, lme_optim_control) {
  outcome_column <- paste0(outcome_name, '__tr')
  spec_terms <- list(no_temperature_term = character(0), temperature_adjusted = 'air_temp_mean')
  do.call(rbind, lapply(names(spec_terms), function(spec_label) {
    rhs_terms <- c('Leq_per5', 'met_mean', spec_terms[[spec_label]])
    modeling_data <- phase_frame[complete.cases(phase_frame[c(outcome_column, rhs_terms)]), ]
    result_row <- data.frame(
      outcome = outcome_name, spec = spec_label, formula = paste(outcome_column, '~', paste(rhs_terms, collapse = ' + '), '+ (1 | ParticipantID)'),
      n_obs = nrow(modeling_data), n_participants = length(unique(modeling_data$ParticipantID)),
      beta_per5dB = NA, se = NA, df = NA, t = NA, p = NA, beta_air_temp = NA, p_air_temp = NA, note = '')
    if (nrow(modeling_data) >= 12 && length(unique(modeling_data$ParticipantID)) >= 4) {
      mixed_model_fit <- tryCatch(
        lme(as.formula(paste(outcome_column, '~', paste(rhs_terms, collapse = ' + '))),
          data = modeling_data, random = ~ 1 | ParticipantID, method = 'REML', control = lme_optim_control),
        error = function(local_error) local_error)
      if (inherits(mixed_model_fit, 'error')) {
        result_row$note <- conditionMessage(mixed_model_fit)
      } else {
        result_row[c('beta_per5dB', 'se', 'df', 't', 'p')] <- as.list(lme_coefficient_row(mixed_model_fit, 'Leq_per5'))
        if (length(spec_terms[[spec_label]])) {
          temp_coefficients <- lme_coefficient_row(mixed_model_fit, 'air_temp_mean')
          result_row$beta_air_temp <- unname(temp_coefficients['beta'])
          result_row$p_air_temp <- unname(temp_coefficients['p'])}}
    } else result_row$note <- 'insufficient complete phase cells'
    result_row
  }))}

# --- Moshammer et al. (2019) block (b): road-vs-park analogue ----------------------------------
# Paired WalkG - WalkU phase-mean contrast (park vs road walk), reported unadjusted (paired t) and
# adjusted for the between-phase difference in mean air temperature (lm(diff ~ dtemp) intercept).
moshammer_roadpark_row <- function(phase_frame, outcome_name) {
  outcome_column <- paste0(outcome_name, '__tr')
  walk_rows <- phase_frame[phase_frame$PhaseID %in% c('WalkG', 'WalkU'), ]
  paired_wide <- merge(
    walk_rows[walk_rows$PhaseID == 'WalkG', c('ParticipantID', outcome_column, 'air_temp_mean')],
    walk_rows[walk_rows$PhaseID == 'WalkU', c('ParticipantID', outcome_column, 'air_temp_mean')],
    by = 'ParticipantID', suffixes = c('_G', '_U'))
  outcome_g <- paste0(outcome_column, '_G'); outcome_u <- paste0(outcome_column, '_U')
  paired_wide <- paired_wide[is.finite(paired_wide[[outcome_g]]) & is.finite(paired_wide[[outcome_u]]), ]
  result_row <- data.frame(
    outcome = outcome_name, n_pairs = nrow(paired_wide),
    mean_WalkG = NA, mean_WalkU = NA, mean_diff = NA, ci_low = NA, ci_high = NA, t = NA, df = NA,
    p_paired_unadjusted = NA, beta_dtemp = NA, p_dtemp = NA, p_contrast_temp_adjusted = NA,
    adjusted_difference = NA_real_, adjusted_std_error = NA_real_, adjusted_df = NA_real_,
    adjusted_ci_lower = NA_real_, adjusted_ci_upper = NA_real_, note = '')
  paired_test <- paired_t_from_columns(paired_wide, outcome_g, outcome_u)
  if (is.finite(paired_test$p)) {
    result_row[c('mean_WalkG', 'mean_WalkU', 'mean_diff', 'ci_low', 'ci_high', 't', 'df', 'p_paired_unadjusted')] <-
      list(paired_test$mean_a, paired_test$mean_b, paired_test$mean_diff, paired_test$ci[1], paired_test$ci[2],
        paired_test$t, paired_test$df, paired_test$p)}
  delta_outcome <- paired_wide[[outcome_g]] - paired_wide[[outcome_u]]
  delta_temp <- paired_wide$air_temp_mean_G - paired_wide$air_temp_mean_U
  if (nrow(paired_wide) >= 4 && is.finite(sd(delta_temp)) && sd(delta_temp) > 0 && is.finite(sd(delta_outcome)) && sd(delta_outcome) > 0) {
    adjustment_fit <- lm(delta_outcome ~ delta_temp)
    adjustment_table <- summary(adjustment_fit)$coefficients
    result_row$beta_dtemp <- adjustment_table['delta_temp', 'Estimate']
    result_row$p_dtemp <- adjustment_table['delta_temp', 'Pr(>|t|)']
    result_row$p_contrast_temp_adjusted <- adjustment_table['(Intercept)', 'Pr(>|t|)']
    result_row$adjusted_difference <- adjustment_table['(Intercept)', 'Estimate']
    result_row$adjusted_std_error <- adjustment_table['(Intercept)', 'Std. Error']
    result_row$adjusted_df <- df.residual(adjustment_fit)
    adjusted_interval <- confint(adjustment_fit, '(Intercept)')
    result_row$adjusted_ci_lower <- adjusted_interval[1]
    result_row$adjusted_ci_upper <- adjusted_interval[2]
    if (min(delta_temp, na.rm = TRUE) > 0 || max(delta_temp, na.rm = TRUE) < 0)
      result_row$note <- 'Adjusted intercept at zero temperature difference extrapolates beyond observed paired temperature differences'
  } else result_row$note <- 'temperature adjustment not estimable (constant delta temp or delta outcome)'
  result_row}


# --- Jin, Jin & Kang (2020) perception family ---------------------------------------------------
# End-of-phase perception items (one value per participant x phase; NOT part of the 26-outcome
# physio families) ~ dBA bin x UTCI bin participant-blocked ANOVA, mirroring the source's measured
# LAeq x temperature design and its temperature x noise interaction question.
run_jin_perception_block <- function(phase_frame) {
  perception_outcomes <- c(
    thermal_comfort = 'questionnaire_thermal_comfort_1_5',
    environmental_comfort = 'questionnaire_environmental_comfort_mean_1_5')
  jin_rows <- list()
  jin_cell_rows <- list()
  for (perception_label in names(perception_outcomes)) {
    questionnaire_column <- perception_outcomes[[perception_label]]
    modeling_data <- phase_frame[is.finite(phase_frame[[questionnaire_column]]) & is.finite(phase_frame$Leq) & is.finite(phase_frame$utci_mean), ]
    modeling_data$y <- modeling_data[[questionnaire_column]]
    modeling_data$factor_participant <- factor(modeling_data$ParticipantID)
    modeling_data$factor_dba <- factor(ifelse(modeling_data$Leq >= 65, 'Loud_geq65', 'Quiet_lt65'), levels = c('Quiet_lt65', 'Loud_geq65'))
    modeling_data$factor_utci <- factor(ifelse(modeling_data$utci_mean > 26, 'Hot_gt26', 'Cool_leq26'), levels = c('Cool_leq26', 'Hot_gt26'))
    cell_table <- as.data.frame(table(modeling_data$factor_dba, modeling_data$factor_utci))
    names(cell_table) <- c('dba_bin', 'utci_bin', 'n_phase_cells')
    jin_cell_rows[[perception_label]] <- cbind(perception_outcome = perception_label, cell_table)
    result_row <- data.frame(
      perception_outcome = perception_label, questionnaire_column = questionnaire_column,
      n_phase_cells = nrow(modeling_data), n_participants = length(unique(modeling_data$ParticipantID)),
      mean_loud = mean(modeling_data$y[modeling_data$factor_dba == 'Loud_geq65']),
      mean_quiet = mean(modeling_data$y[modeling_data$factor_dba == 'Quiet_lt65']),
      F_dba = NA, p_dba = NA, F_utci = NA, p_utci = NA, F_dba_x_utci = NA, p_dba_x_utci = NA, note = '')
    if (length(unique(modeling_data$factor_dba)) > 1 && length(unique(modeling_data$factor_utci)) > 1) {
      result_row[c('F_dba', 'p_dba')] <- as.list(extract_lm_anova_term(y ~ factor_participant + factor_utci + factor_dba, modeling_data, 'factor_dba'))
      result_row[c('F_utci', 'p_utci')] <- as.list(extract_lm_anova_term(y ~ factor_participant + factor_dba + factor_utci, modeling_data, 'factor_utci'))
      result_row[c('F_dba_x_utci', 'p_dba_x_utci')] <- as.list(extract_lm_anova_term(y ~ factor_participant + factor_dba * factor_utci, modeling_data, 'factor_dba:factor_utci'))
    } else result_row$note <- 'degenerate bins: only one level observed for a factor'
    jin_rows[[perception_label]] <- result_row}
  list(
    jin_results = do.call(rbind, jin_rows),
    jin_cell_counts = do.call(rbind, jin_cell_rows))}

# --- Rodrigues et al. (2026) anchor: trip-level mixed models (unchanged) -----------------------
build_trip_summaries <- function(epochs, outcomes, participant_phase_bout) {
  trip_summaries <- do.call(rbind, lapply(split(seq_len(nrow(epochs)), participant_phase_bout), function(bout_row_indices) {
    bout_dba <- epochs$ucm_SND_dBA[bout_row_indices]
    bout_air_temp <- epochs$ucm_AIR_temp[bout_row_indices]
    trip_row <- data.frame(
      ParticipantID = epochs$ParticipantID[bout_row_indices[1]], PhaseID = epochs$PhaseID[bout_row_indices[1]],
      noise_mean = mean(bout_dba, na.rm = TRUE), noise_max = max(bout_dba, na.rm = TRUE), noise_sd = sd(bout_dba, na.rm = TRUE),
      temp_mean = mean(bout_air_temp, na.rm = TRUE), temp_max = max(bout_air_temp, na.rm = TRUE), temp_sd = sd(bout_air_temp, na.rm = TRUE))
    for (outcome_name in outcomes) {
      bout_outcome <- epochs[[paste0(outcome_name, '__tr')]][bout_row_indices]
      trip_row[[paste0(outcome_name, '__mean')]] <- mean(bout_outcome, na.rm = TRUE)
      trip_row[[paste0(outcome_name, '__sd')]] <- sd(bout_outcome, na.rm = TRUE)}
    trip_row
  }))
  for (local_column_name in names(trip_summaries)[-(1:2)]) trip_summaries[[local_column_name]][!is.finite(trip_summaries[[local_column_name]])] <- NA_real_
  trip_summaries}
rodrigues_lme_rows <- function(trip_summaries, lme_optim_control, covariate_block, outcome_aggregation, outcome_name, trip_outcome_column, z_scored_terms) {
  mixed_model_fit <- tryCatch(
    lme(as.formula(paste0('`', trip_outcome_column, '` ~ ', paste(z_scored_terms, collapse = ' + '))),
      data = trip_summaries, random = ~ 1 | ParticipantID, method = 'REML', na.action = na.omit, control = lme_optim_control),
    error = function(local_error) local_error)
  base <- data.frame(
    block = covariate_block, outcome_summary = outcome_aggregation, outcome = outcome_name, term = z_scored_terms,
    beta = NA, se = NA, z = NA, p = NA, n_obs = NA, note = '')
  if (inherits(mixed_model_fit, 'error')) {
    base$note <- conditionMessage(mixed_model_fit)
    return(base)}
  coefficient_table <- summary(mixed_model_fit)$tTable[z_scored_terms, , drop = FALSE]
  base$beta <- coefficient_table[, 'Value']
  base$se <- coefficient_table[, 'Std.Error']
  base$z <- coefficient_table[, 'Value'] / coefficient_table[, 'Std.Error']
  base$p <- 2 * pnorm(-abs(base$z))
  base$n_obs <- nobs(mixed_model_fit)
  base}
run_rodrigues_models <- function(trip_summaries, outcomes, lme_optim_control) {
  covariate_blocks <- list(Noise = c('noise_mean', 'noise_max', 'noise_sd'), Temperature = c('temp_mean', 'temp_max', 'temp_sd'))
  for (local_column_name in unlist(covariate_blocks)) trip_summaries[[paste0(local_column_name, '_z')]] <- z_score(trip_summaries[[local_column_name]])
  rodrigues_results <- rbind_nested_frames(lapply(names(covariate_blocks), function(covariate_block) {
    lapply(c('mean', 'sd'), function(outcome_aggregation) {
      lapply(outcomes, function(outcome_name) {
        rodrigues_lme_rows(
          trip_summaries, lme_optim_control, covariate_block, outcome_aggregation, outcome_name,
          paste0(outcome_name, '__', outcome_aggregation), paste0(covariate_blocks[[covariate_block]], '_z'))
      })
    })
  }))
  rownames(rodrigues_results) <- NULL
  rodrigues_results}

# --- Kraus et al. (2013) anchor: phase-level Leq piecewise mixed models (unchanged) ------------
trend_formula_fragment <- function(variable_name, form_name) {
  switch(
    form_name, linear = variable_name, poly2 = sprintf('poly(%s, 2)', variable_name),
    poly3 = sprintf('poly(%s, 3)', variable_name), poly4 = sprintf('poly(%s, 4)', variable_name),
    pspline = sprintf("s(%s, bs = 'ps', k = 6)", variable_name))}
fit_kraus_mixed_model <- function(rhs_terms, modeling_data, lme_optim_control, method = 'ML') {
  model_formula <- as.formula(paste('Yk ~', paste(rhs_terms, collapse = ' + ')))
  if (any(grepl('^s\\(', rhs_terms))) {
    gam_fit <- tryCatch(gamm(model_formula, random = list(ParticipantID = ~ 1), data = modeling_data, method = method, control = lme_optim_control), error = function(local_error) local_error)
    if (inherits(gam_fit, 'error')) return(gam_fit)
    gam_fit$aic <- AIC(gam_fit$lme)
    gam_fit
  } else {
    lme_fit <- tryCatch(lme(model_formula, data = modeling_data, random = ~ 1 | ParticipantID, method = method, control = lme_optim_control), error = function(local_error) local_error)
    if (inherits(lme_fit, 'error')) return(lme_fit)
    list(lme = lme_fit, gam = NULL, aic = AIC(lme_fit))}
}
model_aic_or_inf <- function(model_fit) if (inherits(model_fit, 'error')) Inf else model_fit$aic
run_kraus_block <- function(epochs, lme_optim_control) {
  kraus_outcome_columns <- c(
    HR = 'empatica_heart_rate', SDNN = 'empatica_hrv_td_sdnn', LFnu = 'empatica_hrv_fd_lfnu',
    HFnu = 'empatica_hrv_fd_hfnu', LF_HF = 'empatica_hrv_fd_lf_hf_ratio')
  trend_form_candidates <- c('linear', 'poly2', 'poly3', 'poly4', 'pspline')
  epochs$Min <- 0L
  phase_group_keys <- epochs[c('ParticipantID', 'PhaseID', 'Min')]
  kraus_phase_summaries <- aggregate(epochs[c(kraus_outcome_columns, 'empatica__met', 'ucm_AIR_temp', 'ucm_AIR_RH')], phase_group_keys, function(x) mean(x, na.rm = TRUE))
  kraus_phase_summaries$Leq <- aggregate(epochs$ucm_SND_dBA, phase_group_keys, mean_energy_level_db)$x
  kraus_phase_summaries$clock_h <- aggregate(as.numeric(format(epochs$Datetime, '%H')) + as.numeric(format(epochs$Datetime, '%M')) / 60, phase_group_keys, mean)$x
  kraus_phase_summaries$day_index <- aggregate(as.numeric(as.Date(epochs$Datetime)), phase_group_keys, mean)$x
  kraus_phase_summaries$day_index <- kraus_phase_summaries$day_index - min(kraus_phase_summaries$day_index)
  kraus_phase_summaries <- kraus_phase_summaries[order(kraus_phase_summaries$ParticipantID, kraus_phase_summaries$PhaseID, kraus_phase_summaries$Min), ]
  for (local_column_name in names(kraus_phase_summaries)[-(1:3)]) kraus_phase_summaries[[local_column_name]][!is.finite(kraus_phase_summaries[[local_column_name]])] <- NA_real_
  kraus_phase_summaries$L_below65_per5 <- (pmin(kraus_phase_summaries$Leq, 65) - 65) / 5
  kraus_phase_summaries$L_above65_per5 <- (pmax(kraus_phase_summaries$Leq, 65) - 65) / 5
  kraus_phase_summaries$HR_cov <- kraus_phase_summaries$empatica_heart_rate
  kraus_results <- list()
  kraus_model_selection <- list()
  for (outcome_label in names(kraus_outcome_columns)) {
    outcome_column <- kraus_outcome_columns[[outcome_label]]
    raw_outcome <- kraus_phase_summaries[[outcome_column]]
    use_log_outcome <- outcome_label != 'HR'
    modeling_data <- kraus_phase_summaries
    modeling_data$Yk <- if (use_log_outcome) log(raw_outcome) else raw_outcome
    modeling_data$Yk[!is.finite(modeling_data$Yk)] <- NA
    sound_and_activity_terms <- c('L_below65_per5', 'L_above65_per5', 'empatica__met', if (outcome_label != 'HR') 'HR_cov')
    trend_covariates <- c('clock_h', if (length(unique(modeling_data$day_index[is.finite(modeling_data$Yk)])) >= 2) 'day_index')
    aic_candidate_confounders <- c('ucm_AIR_temp', 'ucm_AIR_RH')
    modeling_data <- modeling_data[complete.cases(modeling_data[c('Yk', sound_and_activity_terms, trend_covariates, aic_candidate_confounders)]), ]
    trend_form_by_covariate <- setNames(rep('linear', length(trend_covariates)), trend_covariates)
    for (trend_variable in trend_covariates) {
      aic_by_form <- sapply(trend_form_candidates, function(form_name) {
        trial_forms <- trend_form_by_covariate
        trial_forms[trend_variable] <- form_name
        model_aic_or_inf(fit_kraus_mixed_model(c(sound_and_activity_terms, mapply(trend_formula_fragment, names(trial_forms), trial_forms)), modeling_data, lme_optim_control))
      })
      trend_form_by_covariate[trend_variable] <- names(which.min(aic_by_form))}
    confounders_kept <- character(0)
    best_aic <- model_aic_or_inf(fit_kraus_mixed_model(c(sound_and_activity_terms, mapply(trend_formula_fragment, names(trend_form_by_covariate), trend_form_by_covariate)), modeling_data, lme_optim_control))
    repeat {
      aic_if_added <- sapply(setdiff(aic_candidate_confounders, confounders_kept), function(confounder_name) {
        model_aic_or_inf(fit_kraus_mixed_model(c(sound_and_activity_terms, mapply(trend_formula_fragment, names(trend_form_by_covariate), trend_form_by_covariate), confounders_kept, confounder_name), modeling_data, lme_optim_control))
      })
      if (!length(aic_if_added) || min(aic_if_added) >= best_aic) break
      confounders_kept <- c(confounders_kept, names(which.min(aic_if_added)))
      best_aic <- min(aic_if_added)}
    final_rhs <- c(sound_and_activity_terms, mapply(trend_formula_fragment, names(trend_form_by_covariate), trend_form_by_covariate), confounders_kept)
    selected_model <- fit_kraus_mixed_model(final_rhs, modeling_data, lme_optim_control, method = 'REML')
    kraus_model_selection[[outcome_label]] <- data.frame(
      outcome = outcome_column, label = outcome_label,
      trend_forms = paste(names(trend_form_by_covariate), trend_form_by_covariate, sep = '=', collapse = '; '),
      confounders_kept_by_AIC = paste(confounders_kept, collapse = '; '),
      formula = paste('Yk ~', paste(final_rhs, collapse = ' + ')), n_obs = nrow(modeling_data))
    sound_terms <- c('L_below65_per5', 'L_above65_per5')
    if (inherits(selected_model, 'error')) {
      kraus_results[[outcome_label]] <- data.frame(
        outcome = outcome_column, label = outcome_label, log_outcome = use_log_outcome, term = sound_terms,
        beta = NA, se = NA, df = NA, t = NA, p = NA, pct_change_per5dB = NA, n_obs = nrow(modeling_data), note = conditionMessage(selected_model))
      next}
    coefficient_table <- summary(selected_model$lme)$tTable
    term_row_names <- sapply(sound_terms, function(term_name) grep(paste0('(^|\\.)', term_name, '$'), rownames(coefficient_table), value = TRUE)[1])
    kraus_results[[outcome_label]] <- data.frame(
      outcome = outcome_column, label = outcome_label, log_outcome = use_log_outcome, term = sound_terms,
      beta = coefficient_table[term_row_names, 'Value'], se = coefficient_table[term_row_names, 'Std.Error'],
      df = coefficient_table[term_row_names, 'DF'], t = coefficient_table[term_row_names, 't-value'], p = coefficient_table[term_row_names, 'p-value'],
      pct_change_per5dB = if (use_log_outcome) 100 * (exp(coefficient_table[term_row_names, 'Value']) - 1) else NA,
      n_obs = nrow(modeling_data), note = '')}
  list(
    kraus_results = do.call(rbind, kraus_results),
    kraus_model_selection = do.call(rbind, kraus_model_selection))}

# --- FDR catalog, reporting gates and significance summary (field evidence set) -----------------
finalize_fdr_reporting <- function(all_tests_fdr) {
  rownames(all_tests_fdr) <- NULL
  all_tests_fdr$reporting_eligible <- TRUE
  all_tests_fdr$reporting_note <- 'Field adaptation; see METHODS_NOTES.md'
  all_tests_fdr$method_validation_status <- 'source_test_adapted_to_field_data'
  song_rows <- all_tests_fdr$paper == 'Song2014'
  all_tests_fdr$reporting_note[song_rows] <-
    'Family-size sensitivity of the Moshammer WalkG-WalkU contrast: SDNN and RMSSD only, chosen because they had raw p < 0.05 on the temperature-adjusted contrast in the eight-outcome screen. Source used a one-sided unadjusted paired t and did not measure sound level. Not an independent confirmatory test.'
  perception_rows <- all_tests_fdr$paper == 'Jin2020_perception'
  all_tests_fdr$reporting_note[perception_rows] <-
    'Perception family on end-of-phase questionnaire items (44 phase cells); separate from the 26-outcome physio families; participant-blocked ANOVA'
  review_pending_papers <- all_tests_fdr$paper %in% c('Rodrigues 2026', 'Kraus 2013')
  all_tests_fdr$reporting_note[all_tests_fdr$paper == 'Rodrigues 2026'] <-
    'Trip-level participant-intercept mixed models; z-scored noise terms; REML Wald p'
  all_tests_fdr$reporting_note[all_tests_fdr$paper == 'Kraus 2013'] <-
    'Phase summaries of overlapping 5-min HRV windows; no lag'
  all_tests_fdr$reporting_eligible[review_pending_papers] <- FALSE
  all_tests_fdr$method_validation_status[review_pending_papers] <- ifelse(
    all_tests_fdr$paper[review_pending_papers] == 'Rodrigues 2026',
    'source_code_and_small_sample_inference_review_pending', 'phase_summary_adaptation_window_and_model_review_pending')
  all_tests_fdr$reporting_note[review_pending_papers] <- paste(
    all_tests_fdr$reporting_note[review_pending_papers], all_tests_fdr$method_validation_status[review_pending_papers], sep = '; ')
  all_tests_fdr$reporting_eligible <- all_tests_fdr$reporting_eligible & is.finite(all_tests_fdr$p)
  all_tests_fdr$reportable_sig_p05 <- all_tests_fdr$sig_p05 & all_tests_fdr$reporting_eligible
  all_tests_fdr$reportable_FDR_q05 <- all_tests_fdr$survives_FDR_q05 & all_tests_fdr$reporting_eligible
  all_tests_fdr}

build_fdr_catalog <- function(moshammer_lmm_results, moshammer_roadpark_results, jin_results, rodrigues_results, kraus_results, song_primary_results) {
  jin_term_rows <- function(term_label, f_column, p_column, q_column) {
    fdr_catalog_row('Jin2020_perception', paste('participant-blocked ANOVA', term_label), jin_results$perception_outcome,
      jin_results[[f_column]], jin_results[[p_column]], jin_results[[q_column]])}
  rbind(
    fdr_catalog_row('Moshammer2019', paste('phase LMM Leq slope per 5 dB', moshammer_lmm_results$spec),
      moshammer_lmm_results$outcome, moshammer_lmm_results$beta_per5dB, moshammer_lmm_results$p, moshammer_lmm_results$q_BH),
    fdr_catalog_row('Moshammer2019', 'paired WalkG-WalkU phase means (unadjusted)',
      moshammer_roadpark_results$outcome, moshammer_roadpark_results$mean_diff,
      moshammer_roadpark_results$p_paired_unadjusted, moshammer_roadpark_results$q_BH_unadjusted),
    fdr_catalog_row('Moshammer2019', 'paired WalkG-WalkU adjusted for delta air temperature',
      moshammer_roadpark_results$outcome, moshammer_roadpark_results$adjusted_difference,
      moshammer_roadpark_results$p_contrast_temp_adjusted, moshammer_roadpark_results$q_BH_adjusted),
    fdr_catalog_row('Song2014', 'paired WalkG-WalkU phase means (unadjusted)',
      song_primary_results$outcome, song_primary_results$mean_diff,
      song_primary_results$p_paired_unadjusted, song_primary_results$q_BH_unadjusted),
    fdr_catalog_row('Song2014', 'paired WalkG-WalkU adjusted for delta air temperature',
      song_primary_results$outcome, song_primary_results$adjusted_difference,
      song_primary_results$p_contrast_temp_adjusted, song_primary_results$q_BH_adjusted),
    jin_term_rows('dBA bin main effect', 'F_dba', 'p_dba', 'q_BH_dba'),
    jin_term_rows('UTCI bin main effect (context, not a sound term)', 'F_utci', 'p_utci', 'q_BH_utci'),
    jin_term_rows('dBA x UTCI interaction', 'F_dba_x_utci', 'p_dba_x_utci', 'q_BH_interaction'),
    {
      rodrigues_noise <- rodrigues_results[rodrigues_results$block == 'Noise', , drop = FALSE]
      fdr_catalog_row('Rodrigues 2026', paste(rodrigues_noise$block, 'block trip', rodrigues_noise$outcome_summary, rodrigues_noise$term),
        rodrigues_noise$outcome, rodrigues_noise$beta, rodrigues_noise$p, rodrigues_noise$q_BH_26_per_term)
    },
    fdr_catalog_row('Kraus 2013', kraus_results$term, kraus_results$label, kraus_results$beta, kraus_results$p, kraus_results$q_BH_5_per_term))}

build_significance_summary <- function(moshammer_lmm_results, moshammer_roadpark_results, jin_results, rodrigues_results, kraus_results, song_primary_results) {
  rodrigues_noise_results <- rodrigues_results[rodrigues_results$block == 'Noise', ]
  moshammer_lmm_summary <- do.call(rbind, lapply(split(moshammer_lmm_results, moshammer_lmm_results$spec), function(spec_rows) {
    significance_summary_row('Moshammer2019', paste('phase LMM Leq slope per 5 dB', spec_rows$spec[1]),
      spec_rows$p, spec_rows$q_BH, spec_rows$outcome)}))
  jin_summary <- rbind(
    significance_summary_row('Jin2020_perception', 'dBA bin main effect', jin_results$p_dba, jin_results$q_BH_dba, jin_results$perception_outcome),
    significance_summary_row('Jin2020_perception', 'dBA x UTCI interaction', jin_results$p_dba_x_utci, jin_results$q_BH_interaction, jin_results$perception_outcome))
  summary <- rbind(
    moshammer_lmm_summary,
    significance_summary_row('Moshammer2019', 'paired WalkG-WalkU phase means (unadjusted)',
      moshammer_roadpark_results$p_paired_unadjusted, moshammer_roadpark_results$q_BH_unadjusted, moshammer_roadpark_results$outcome),
    significance_summary_row('Moshammer2019', 'paired WalkG-WalkU adjusted for delta air temperature',
      moshammer_roadpark_results$p_contrast_temp_adjusted, moshammer_roadpark_results$q_BH_adjusted, moshammer_roadpark_results$outcome),
    significance_summary_row('Song2014', 'paired WalkG-WalkU phase means (unadjusted)',
      song_primary_results$p_paired_unadjusted, song_primary_results$q_BH_unadjusted, song_primary_results$outcome),
    significance_summary_row('Song2014', 'paired WalkG-WalkU adjusted for delta air temperature',
      song_primary_results$p_contrast_temp_adjusted, song_primary_results$q_BH_adjusted, song_primary_results$outcome),
    jin_summary,
    do.call(rbind, lapply(split(rodrigues_noise_results, paste(rodrigues_noise_results$outcome_summary, rodrigues_noise_results$term)), function(noise_term_rows) {
      significance_summary_row('Rodrigues 2026', paste('trip', noise_term_rows$outcome_summary[1], noise_term_rows$term[1]), noise_term_rows$p, noise_term_rows$q_BH_26_per_term, noise_term_rows$outcome)
    })),
    do.call(rbind, lapply(split(kraus_results, kraus_results$term), function(kraus_term_rows) {
      significance_summary_row('Kraus 2013', kraus_term_rows$term[1], kraus_term_rows$p, kraus_term_rows$q_BH_5_per_term, kraus_term_rows$label)
    })))
  summary$reporting_status <- ifelse(
    summary$paper %in% c('Rodrigues 2026', 'Kraus 2013'),
    'REVIEW PENDING: raw counts are not approved reporting claims',
    ifelse(summary$paper == 'Jin2020_perception', 'Perception family (questionnaire), not physio',
      ifelse(summary$paper == 'Song2014', 'Family-size sensitivity: SDNN and RMSSD only; outcomes chosen from the Moshammer screen', 'Field adaptation')))
  summary}

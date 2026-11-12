# H4_sound_literature_helpers.R — shared utilities for H4_sound_literature_tests.R

benjamini_hochberg <- function(p) {
  q <- rep(NA_real_, length(p))
  finite_p <- is.finite(p)
  q[finite_p] <- p.adjust(p[finite_p], 'BH')
  q}
z_score <- function(x) (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
mean_energy_level_db <- function(level_db) 10 * log10(mean(10^(level_db / 10), na.rm = TRUE))
snap_to_nearest_level <- function(values, levels) levels[apply(abs(outer(values, levels, '-')), 1, which.min)]
rbind_nested_frames <- function(nested) {
  do.call(rbind, unlist(unlist(nested, recursive = FALSE), recursive = FALSE))}
assign_observational_2x2 <- function(utci, dba, labels) {
  out <- rep(NA_character_, length(utci))
  ok <- is.finite(utci) & is.finite(dba)
  out[ok] <- labels[1L + (utci[ok] > 26) + 2L * (dba[ok] >= 65)]
  out}
outcome_transform_label <- function(transforms, outcome_name) {
  transforms$transformation_in_models[match(outcome_name, transforms$column_name)]}
participant_means_by_levels <- function(epochs, outcome_name, group, levels, min_epochs = 3L) {
  y <- epochs[[paste0(outcome_name, '__tr')]]
  ok <- is.finite(y) & !is.na(group)
  by <- list(epochs$ParticipantID[ok], factor(group[ok], levels))
  counts <- tapply(y[ok], by, length)
  means <- tapply(y[ok], by, mean)
  complete <- rownames(counts)[apply(counts, 1, function(c) all(is.finite(c) & c >= min_epochs))]
  means[complete, , drop = FALSE]}
extract_lm_anova_term <- function(model_formula, data, term_name) {
  anova_table <- anova(lm(model_formula, data = data))
  row_names <- trimws(rownames(anova_table))
  if (!any(row_names == term_name)) return(c(NA, NA))
  c(anova_table[row_names == term_name, 'F value'], anova_table[row_names == term_name, 'Pr(>F)'])}
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
paired_t_outcome_rows <- function(outcomes, row_fn) do.call(rbind, lapply(outcomes, row_fn))
paired_t_hot_loud_vs_cool_quiet_row <- function(epochs, outcome_name, group, exposure_levels) {
  participant_cell_means <- participant_means_by_levels(epochs, outcome_name, group, exposure_levels)
  row <- data.frame(
    outcome = outcome_name, n_participants = nrow(participant_cell_means),
    mean_HotLoud = NA, mean_CoolQuiet = NA, mean_diff = NA, t = NA, df = NA, p_paired_t = NA)
  pt <- paired_t_from_columns(participant_cell_means, 'Hot+Loud', 'Cool+Quiet')
  if (is.finite(pt$p)) {
    row[c('mean_HotLoud', 'mean_CoolQuiet', 'mean_diff', 't', 'df', 'p_paired_t')] <-
      list(pt$mean_a, pt$mean_b, pt$mean_diff, pt$t, pt$df, pt$p)}
  row}
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
four_condition_wilcox_posthoc <- function(outcome_name, participant_condition_means, condition_levels, n_participants, p_global) {
  condition_pair_indices <- combn(condition_levels, 2)
  do.call(rbind, lapply(seq_len(ncol(condition_pair_indices)), function(pair_index) {
    condition_a <- condition_pair_indices[1, pair_index]
    condition_b <- condition_pair_indices[2, pair_index]
    wilcox_result <- suppressWarnings(wilcox.test(
      participant_condition_means[, condition_b], participant_condition_means[, condition_a], paired = TRUE, exact = FALSE))
    data.frame(
      outcome = outcome_name, comparison = paste(condition_b, 'vs', condition_a), n_participants = n_participants,
      median_diff = median(participant_condition_means[, condition_b] - participant_condition_means[, condition_a]),
      V = unname(wilcox_result$statistic), p_wilcoxon = wilcox_result$p.value,
      posthoc_reported_by_paper_rule = is.finite(p_global) && p_global < 0.05)
  }))}
four_condition_outcome <- function(epochs, transforms, outcome_name, condition_levels) {
  participant_condition_means <- participant_means_by_levels(epochs, outcome_name, epochs$Condition, condition_levels)
  n_participants <- nrow(participant_condition_means)
  row <- data.frame(
    outcome = outcome_name, transform = outcome_transform_label(transforms, outcome_name), n_participants = n_participants,
    participants = paste(rownames(participant_condition_means), collapse = ';'),
    mean_Control = NA, mean_Heat = NA, mean_Noise = NA, mean_HeatNoise = NA,
    shapiro_min_p = NA, mauchly_p = NA, gg_epsilon = NA, F = NA, df1 = NA, df2 = NA,
    p_rmanova = NA, p_rmanova_GG = NA, friedman_chisq = NA, p_friedman = NA, test_used = NA, p_global = NA)
  posthoc <- NULL
  if (n_participants >= 4) {
    row[c('mean_Control', 'mean_Heat', 'mean_Noise', 'mean_HeatNoise')] <- as.list(colMeans(participant_condition_means))
    shapiro_p_by_condition <- apply(participant_condition_means, 2, function(values) {
      if (length(unique(values)) > 2) shapiro.test(values)$p.value else NA
    })
    row$shapiro_min_p <- min(shapiro_p_by_condition, na.rm = TRUE)
    long_format_rmanova <- data.frame(
      y = as.vector(participant_condition_means), pid = factor(rep(rownames(participant_condition_means), 4)),
      cond = factor(rep(condition_levels, each = n_participants), condition_levels))
    rmanova_error_stratum <- summary(aov(y ~ cond + Error(pid / cond), data = long_format_rmanova))[['Error: pid:cond']][[1]]
    f_value <- rmanova_error_stratum[['F value']][1]
    df1 <- rmanova_error_stratum[['Df']][1]
    df2 <- rmanova_error_stratum[['Df']][2]
    condition_covariance <- cov(participant_condition_means %*% contr.poly(4))
    gg_epsilon <- sum(diag(condition_covariance))^2 / (3 * sum(condition_covariance^2))
    mauchly_p_value <- tryCatch(mauchly.test(lm(participant_condition_means ~ 1), X = ~1)$p.value, error = function(local_error) NA)
    p_rmanova <- pf(f_value, df1, df2, lower.tail = FALSE)
    p_rmanova_gg <- pf(f_value, df1 * gg_epsilon, df2 * gg_epsilon, lower.tail = FALSE)
    friedman_result <- friedman.test(participant_condition_means)
    outcomes_look_normal <- is.finite(row$shapiro_min_p) && row$shapiro_min_p >= 0.05
    use_greenhouse_geisser <- is.finite(mauchly_p_value) && mauchly_p_value < 0.05
    row[c('mauchly_p', 'gg_epsilon', 'F', 'df1', 'df2', 'p_rmanova', 'p_rmanova_GG', 'friedman_chisq', 'p_friedman')] <-
      list(mauchly_p_value, gg_epsilon, f_value, df1, df2, p_rmanova, p_rmanova_gg, unname(friedman_result$statistic), friedman_result$p.value)
    row$test_used <- if (outcomes_look_normal) if (use_greenhouse_geisser) 'RM-ANOVA (Greenhouse-Geisser)' else 'RM-ANOVA' else 'Friedman'
    row$p_global <- if (outcomes_look_normal) if (use_greenhouse_geisser) p_rmanova_gg else p_rmanova else friedman_result$p.value
    posthoc <- four_condition_wilcox_posthoc(outcome_name, participant_condition_means, condition_levels, n_participants, row$p_global)}
  list(row = row, posthoc = posthoc)}
run_four_condition_block <- function(epochs, transforms, outcomes, condition_levels) {
  fc_by_outcome <- lapply(outcomes, four_condition_outcome, epochs = epochs, transforms = transforms, condition_levels = condition_levels)
  list(
    condition_results = do.call(rbind, lapply(fc_by_outcome, `[[`, 'row')),
    condition_posthoc_results = do.call(rbind, lapply(fc_by_outcome, `[[`, 'posthoc')))}
run_factorial_designs <- function(epochs, outcomes, factorial_designs, valid_temp_and_dba) {
  factorial_result_rows <- list()
  factorial_cell_rows <- list()
  for (design_name in names(factorial_designs)) {
    design_levels <- factorial_designs[[design_name]]
    snapped_temp <- rep(NA, nrow(epochs))
    snapped_noise <- rep(NA, nrow(epochs))
    snapped_temp[valid_temp_and_dba] <- snap_to_nearest_level(epochs$ucm_AIR_temp[valid_temp_and_dba], design_levels$T)
    snapped_noise[valid_temp_and_dba] <- snap_to_nearest_level(epochs$ucm_SND_dBA[valid_temp_and_dba], design_levels$N)
    for (outcome_name in outcomes) {
      y <- epochs[[paste0(outcome_name, '__tr')]]
      analysis_rows <- valid_temp_and_dba & is.finite(y)
      cell_aggregate <- aggregate(
        y[analysis_rows],
        list(pid = epochs$ParticipantID[analysis_rows], Temp = snapped_temp[analysis_rows], Noise = snapped_noise[analysis_rows]),
        function(values) c(m = mean(values), n = length(values)))
      participant_cell_means <- data.frame(cell_aggregate[1:3], y = cell_aggregate$x[, 'm'], n = cell_aggregate$x[, 'n'])
      participant_cell_means <- participant_cell_means[participant_cell_means$n >= 3, ]
      factorial_cell_rows[[paste(design_name, outcome_name)]] <- cbind(design = design_name, outcome = outcome_name, participant_cell_means)
      factorial_result_row <- data.frame(
        design = design_name, outcome = outcome_name, n_cell_means = nrow(participant_cell_means),
        n_participants = length(unique(participant_cell_means$pid)),
        n_cells_filled = nrow(unique(participant_cell_means[c('Temp', 'Noise')])),
        F_Temp = NA, p_Temp = NA, F_Noise = NA, p_Noise = NA, F_TempxNoise = NA, p_TempxNoise = NA)
      if (length(unique(participant_cell_means$Temp)) > 1 && length(unique(participant_cell_means$Noise)) > 1) {
        participant_cell_means$factor_participant <- factor(participant_cell_means$pid)
        participant_cell_means$factor_temp <- factor(participant_cell_means$Temp)
        participant_cell_means$factor_noise <- factor(participant_cell_means$Noise)
        factorial_result_row[c('F_Temp', 'p_Temp')] <- as.list(extract_lm_anova_term(y ~ factor_participant + factor_noise + factor_temp, participant_cell_means, 'factor_temp'))
        factorial_result_row[c('F_Noise', 'p_Noise')] <- as.list(extract_lm_anova_term(y ~ factor_participant + factor_temp + factor_noise, participant_cell_means, 'factor_noise'))
        factorial_result_row[c('F_TempxNoise', 'p_TempxNoise')] <- as.list(extract_lm_anova_term(y ~ factor_participant + factor_temp * factor_noise, participant_cell_means, 'factor_temp:factor_noise'))}
      factorial_result_rows[[paste(design_name, outcome_name)]] <- factorial_result_row}
  }
  list(
    factorial_results = do.call(rbind, factorial_result_rows),
    factorial_cell_means = do.call(rbind, factorial_cell_rows))}
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
finalize_fdr_reporting <- function(all_tests_fdr, condition_results, condition_posthoc_results) {
  all_tests_fdr$statistic_test <- NA_character_
  omnibus_rows <- all_tests_fdr$test == 'global 4-condition test'
  selected_omnibus_test <- condition_results$test_used[match(all_tests_fdr$outcome[omnibus_rows], condition_results$outcome)]
  all_tests_fdr$statistic_test[omnibus_rows] <- ifelse(selected_omnibus_test == 'Friedman', 'Friedman test', paste0('f-test (', selected_omnibus_test, ')'))
  rownames(all_tests_fdr) <- NULL
  all_tests_fdr$reporting_eligible <- TRUE
  all_tests_fdr$reporting_note <- 'Field adaptation; see METHODS_NOTES.md'
  posthoc_row_indices <- which(all_tests_fdr$paper == 'Yousefinezhad 2026' & startsWith(all_tests_fdr$test, 'Wilcoxon '))
  stopifnot(length(posthoc_row_indices) == nrow(condition_posthoc_results))
  all_tests_fdr$reporting_eligible[posthoc_row_indices] <- condition_posthoc_results$posthoc_reported_by_paper_rule %in% TRUE
  all_tests_fdr$reporting_note[posthoc_row_indices] <- ifelse(
    all_tests_fdr$reporting_eligible[posthoc_row_indices], 'Omnibus p<0.05 gate passed', 'Omnibus gate did not pass: do not claim post-hoc significance')
  all_tests_fdr$reporting_note[all_tests_fdr$paper %in% c('Tohidi2025', 'Abbasi2020')] <- 'Participant-blocked linear-model ANOVA; additive main-effect tests and full-model interaction test'
  all_tests_fdr$reporting_note[all_tests_fdr$paper == 'Kraus 2013'] <- 'Phase summaries of overlapping 5-min HRV windows; no lag'
  all_tests_fdr$method_validation_status <- 'source_test_adapted_to_field_data'
  review_pending_papers <- all_tests_fdr$paper %in% c('Tohidi2025', 'Abbasi2020', 'Rodrigues 2026', 'Kraus 2013')
  all_tests_fdr$reporting_eligible[review_pending_papers] <- FALSE
  all_tests_fdr$method_validation_status[review_pending_papers] <- ifelse(
    all_tests_fdr$paper[review_pending_papers] %in% c('Tohidi2025', 'Abbasi2020'), 'full_source_methods_pending',
    ifelse(all_tests_fdr$paper[review_pending_papers] == 'Rodrigues 2026', 'source_code_and_small_sample_inference_review_pending', 'phase_summary_adaptation_window_and_model_review_pending'))
  all_tests_fdr$reporting_note[review_pending_papers] <- paste(all_tests_fdr$reporting_note[review_pending_papers], all_tests_fdr$method_validation_status[review_pending_papers], sep = '; ')
  all_tests_fdr$reporting_eligible <- all_tests_fdr$reporting_eligible & is.finite(all_tests_fdr$p)
  all_tests_fdr$reportable_sig_p05 <- all_tests_fdr$sig_p05 & all_tests_fdr$reporting_eligible
  all_tests_fdr$reportable_FDR_q05 <- all_tests_fdr$survives_FDR_q05 & all_tests_fdr$reporting_eligible
  all_tests_fdr}
build_significance_summary <- function(jo_results, condition_results, condition_posthoc_results, hot_loud_paired_results, factorial_results, rodrigues_results, kraus_results) {
  rodrigues_noise_results <- rodrigues_results[rodrigues_results$block == 'Noise', ]
  summary <- rbind(
    significance_summary_row('Jo 2019', 'paired one-sided t (green vs urban)', jo_results$p_one_sided_Jo, jo_results$q_BH_one_sided_Jo_6, paste(jo_results$mode, jo_results$outcome)),
    significance_summary_row('Yousefinezhad 2026', 'global 4-condition test', condition_results$p_global, condition_results$q_BH_global_26, condition_results$outcome),
    do.call(rbind, lapply(unique(condition_posthoc_results$comparison), function(comparison_label) {
      posthoc_subset <- condition_posthoc_results[condition_posthoc_results$comparison == comparison_label, ]
      significance_summary_row('Yousefinezhad 2026', paste('Wilcoxon', comparison_label),
        ifelse(posthoc_subset$posthoc_reported_by_paper_rule, posthoc_subset$p_wilcoxon, NA_real_),
        ifelse(posthoc_subset$posthoc_reported_by_paper_rule, posthoc_subset$q_BH_26_per_comparison, NA_real_), posthoc_subset$outcome)
    })),
    significance_summary_row('Dehghan 2017', 'Friedman 4 conditions', condition_results$p_friedman, condition_results$q_friedman_26, condition_results$outcome),
    significance_summary_row('Molaeifar 2020', 'paired t Hot+Loud vs Cool+Quiet', hot_loud_paired_results$p_paired_t, hot_loud_paired_results$q_BH_26, hot_loud_paired_results$outcome),
    do.call(rbind, lapply(unique(factorial_results$design), function(design_label) {
      design_subset <- factorial_results[factorial_results$design == design_label, ]
      rbind(
        significance_summary_row(design_label, 'two-way ANOVA noise main effect', design_subset$p_Noise, design_subset$q_Noise_26, design_subset$outcome),
        significance_summary_row(design_label, 'two-way ANOVA temperature x noise', design_subset$p_TempxNoise, design_subset$q_TempxNoise_26, design_subset$outcome))
    })),
    do.call(rbind, lapply(split(rodrigues_noise_results, paste(rodrigues_noise_results$outcome_summary, rodrigues_noise_results$term)), function(noise_term_rows) {
      significance_summary_row('Rodrigues 2026', paste('trip', noise_term_rows$outcome_summary[1], noise_term_rows$term[1]), noise_term_rows$p, noise_term_rows$q_BH_26_per_term, noise_term_rows$outcome)
    })),
    do.call(rbind, lapply(split(kraus_results, kraus_results$term), function(kraus_term_rows) {
      significance_summary_row('Kraus 2013', kraus_term_rows$term[1], kraus_term_rows$p, kraus_term_rows$q_BH_5_per_term, kraus_term_rows$label)
    })))
  summary$reporting_status <- ifelse(
    summary$paper %in% c('Tohidi2025', 'Abbasi2020', 'Rodrigues 2026', 'Kraus 2013'),
    'REVIEW PENDING: raw counts are not approved reporting claims',
    ifelse(startsWith(summary$sound_test, 'Wilcoxon'), 'Post-hoc: counted only when omnibus p < 0.05', 'Field adaptation'))
  summary}
build_fdr_catalog <- function(jo_results, condition_results, condition_posthoc_results, hot_loud_paired_results, factorial_results, rodrigues_results, kraus_results) {
  rbind(
    fdr_catalog_row('Jo 2019', 'paired one-sided t', paste(jo_results$mode, jo_results$outcome), NA, jo_results$p_one_sided_Jo, jo_results$q_BH_one_sided_Jo_6),
    fdr_catalog_row('Yousefinezhad 2026', 'global 4-condition test', condition_results$outcome, NA, condition_results$p_global, condition_results$q_BH_global_26),
    fdr_catalog_row('Yousefinezhad 2026', paste('Wilcoxon', condition_posthoc_results$comparison), condition_posthoc_results$outcome, NA, condition_posthoc_results$p_wilcoxon, condition_posthoc_results$q_BH_26_per_comparison),
    fdr_catalog_row('Dehghan 2017', 'Friedman 4 conditions', condition_results$outcome, NA, condition_results$p_friedman, condition_results$q_friedman_26),
    fdr_catalog_row('Molaeifar 2020', 'paired t Hot+Loud vs Cool+Quiet', hot_loud_paired_results$outcome, hot_loud_paired_results$mean_diff, hot_loud_paired_results$p_paired_t, hot_loud_paired_results$q_BH_26),
    fdr_catalog_row(factorial_results$design, 'two-way ANOVA temperature main effect', factorial_results$outcome, factorial_results$F_Temp, factorial_results$p_Temp, factorial_results$q_Temp_26),
    fdr_catalog_row(factorial_results$design, 'two-way ANOVA noise main effect', factorial_results$outcome, factorial_results$F_Noise, factorial_results$p_Noise, factorial_results$q_Noise_26),
    fdr_catalog_row(factorial_results$design, 'two-way ANOVA temperature x noise', factorial_results$outcome, factorial_results$F_TempxNoise, factorial_results$p_TempxNoise, factorial_results$q_TempxNoise_26),
    fdr_catalog_row('Rodrigues 2026', paste(rodrigues_results$block, 'block trip', rodrigues_results$outcome_summary, rodrigues_results$term), rodrigues_results$outcome, rodrigues_results$beta, rodrigues_results$p, rodrigues_results$q_BH_26_per_term),
    fdr_catalog_row('Kraus 2013', kraus_results$term, kraus_results$label, kraus_results$beta, kraus_results$p, kraus_results$q_BH_5_per_term))}

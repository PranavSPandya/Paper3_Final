#!/usr/bin/env Rscript
# Paper 3: post-hoc participant-level robustness for H1, H2, H3, H4 and H5 (Phaseavg).
# Sensitivity only. Not a preregistered confirmatory test.
# Does not choose participants, outcomes or models from significance.
# Primary mixed-model / rmcorr / literature folders are not overwritten.
#
# Run from the repository root:
#   Rscript scripts/statistical_analysis/H1_H5_robustness.R
# Optional: PAPER3_KR=0 Rscript scripts/statistical_analysis/H1_H5_robustness.R
# Output: output/statistical_analysis/results/Robustness_check/

args <- grep('^--file=', commandArgs(FALSE), value = TRUE)
if (!length(args)) stop('Run as Rscript scripts/statistical_analysis/H1_H5_robustness.R')
entry_dir <- dirname(normalizePath(sub('^--file=', '', args[1L]), mustWork = TRUE))
common_path <- file.path(entry_dir, 'library', 'Paper3_common.R')
if (!file.exists(common_path)) stop('Missing adjacent library/Paper3_common.R: ', common_path)
source(common_path, local = FALSE)
PROJECT_ROOT <- resolve_project_root()

needed <- c('nlme', 'emmeans', 'clubSandwich', 'mgcv')
missing_packages <- needed[!vapply(needed, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop('Install required R packages: ', paste(missing_packages, collapse = ', '))
use_sat <- requireNamespace('lmerTest', quietly = TRUE) && requireNamespace('lme4', quietly = TRUE)
use_kr <- use_sat && requireNamespace('pbkrtest', quietly = TRUE) && Sys.getenv('PAPER3_KR', '1') != '0'

phys <- paper3_physiological_outcomes()
psych <- paper3_psych_questionnaire_outcomes()
phases <- PAPER3_CORE_PHASES
participants <- PAPER3_PARTICIPANTS
spec <- paper3_attach_outcome_normalization(list(
  participants = participants, phases = phases, matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = phys), PROJECT_ROOT)
contrast_specs <- do.call(rbind, paper3_h1_h3_planned_contrast_tables())
rownames(contrast_specs) <- NULL
stopifnot(nrow(contrast_specs) == 4L, length(phys) == 26L, length(psych) == 18L,
          length(participants) == 11L, !anyDuplicated(c(phys, psych)))

PAIR_MAP <- list(
  atmo_pm1_avg = c('atmo_lys_atmotube_left__atmotube_pm1', 'atmo_lys_atmotube_right__atmotube_pm1'),
  atmo_pm2.5_avg = c('atmo_lys_atmotube_left__atmotube_pm2.5', 'atmo_lys_atmotube_right__atmotube_pm2.5'),
  atmo_pm10_avg = c('atmo_lys_atmotube_left__atmotube_pm10', 'atmo_lys_atmotube_right__atmotube_pm10'),
  lys_lux_avg = c('atmo_lys_LYS1__lys_lux', 'atmo_lys_LYS2__lys_lux'),
  lys_kelvin_avg = c('atmo_lys_LYS1__lys_kelvin', 'atmo_lys_LYS2__lys_kelvin'))
ENV_ARITH <- c('ucm_UTCI', 'ucm_AIR_T_mid', 'ucm_AIR_RH', 'ucm_WIND_AWS', 'ucm_MRT', 'ucm_HUMIDEX',
               'ucm_PET', 'SVF', 'gvi_50m', 'ucm_SUN_Gh', 'lys_lux_avg', 'lys_kelvin_avg',
               'atmo_pm1_avg', 'atmo_pm2.5_avg', 'atmo_pm10_avg')
ENV_DB <- 'ucm_SND_dBA'
h5_expressions <- parse(file.path(entry_dir, 'H5_combined_phaseavg.R'))
h5_fixed <- list()
for (expression in h5_expressions) {
  if (is.call(expression) && identical(expression[[1L]], as.name('<-')) &&
      grepl('^Eq[1-7]$', as.character(expression[[2L]]))) {
    equation <- eval(expression[[3L]])
    h5_fixed[[as.character(expression[[2L]])]] <- as.formula(equation[[2L]])
  }
}
stopifnot(length(h5_fixed) == 7L)
H5_EXPOSURES <- list(unadjusted = unique(sub('_phase_z$', '',
  unlist(lapply(h5_fixed, function(fixed) setdiff(attr(terms(fixed), 'term.labels'),
    c('PhaseSumWalkG', 'PhaseSumWalkU', 'PhaseSumBikeG')))))))


raw_path <- paper3_merged_8min_path(PROJECT_ROOT)
route <- read.csv(raw_path, check.names = FALSE, stringsAsFactors = FALSE)
route <- paper3_add_pair_means(route, PAIR_MAP)
required_cols <- unique(c('ParticipantID', 'PhaseID', 'Datetime', phys, psych, ENV_ARITH, ENV_DB))
missing_cols <- setdiff(required_cols, names(route))
if (length(missing_cols)) stop('Missing expected input columns: ', paste(missing_cols, collapse = ', '))
route <- route[route$ParticipantID %in% participants & route$PhaseID %in% phases, , drop = FALSE]
if (!nrow(route)) stop('No selected participant/phase rows in merged input')
route$Datetime <- as.POSIXct(route$Datetime, tz = 'UTC')
if (anyNA(route$Datetime)) stop('Unparseable Datetime in selected rows')
route$ParticipantID <- factor(route$ParticipantID, levels = participants)
route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), , drop = FALSE]
if ('empatica_hrv_fd_5min_available' %in% names(route)) {
  available <- tolower(as.character(route$empatica_hrv_fd_5min_available)) %in% c('true', '1')
  for (outcome in attr(phys, 'empatica_hrv_fd_window')) route[[outcome]][!available] <- NA_real_
}
for (outcome in phys) route[[outcome]] <- paper3_apply_csv_transform(
  route[[outcome]], outcome, spec$outcome_transforms_csv)
route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
  FUN = function(x) x - min(x, na.rm = TRUE))
route$time_min <- route$time_in_phase_sec / 60
route <- paper3_merge_common_cap(route, phases, spec$matched_cap_sec)
route <- route[!is.na(route$Common_cap) &
               route$time_in_phase_sec <= route$Common_cap, , drop = FALSE]
if (!nrow(route)) stop('No rows remain after matched-cap filter')

energy_mean_db <- function(x) {
  x <- x[is.finite(x)]
  if (!length(x)) return(NA_real_)
  10 * log10(mean(10^(x / 10)))
}

agg_mean <- function(columns, data = route) {
  aggregate(data[columns], by = data[c('ParticipantID', 'PhaseID')], FUN = mean_na)
}
phase_df <- agg_mean(c(phys, psych, ENV_ARITH))
dba_energy <- aggregate(route[[ENV_DB]], by = route[c('ParticipantID', 'PhaseID')], FUN = energy_mean_db)
names(dba_energy)[3] <- 'ucm_SND_dBA_energy'
dba_arith <- aggregate(route[[ENV_DB]], by = route[c('ParticipantID', 'PhaseID')], FUN = mean_na)
names(dba_arith)[3] <- 'ucm_SND_dBA'
phase_df <- merge(phase_df, dba_energy, by = c('ParticipantID', 'PhaseID'), all.x = TRUE, sort = FALSE)
phase_df <- merge(phase_df, dba_arith, by = c('ParticipantID', 'PhaseID'), all.x = TRUE, sort = FALSE)
phase_df$ParticipantID <- factor(phase_df$ParticipantID, levels = participants)
phase_df$PhaseID <- factor(phase_df$PhaseID, levels = phases)
if (anyDuplicated(phase_df[c('ParticipantID', 'PhaseID')])) stop('Duplicate participant-phase cells')
for (outcome in c(phys, psych)) {
  phase_df[[paste0('within_person_z__', outcome)]] <-
    paper3_within_person_z(phase_df[[outcome]], phase_df$ParticipantID)
}

# Moshammer window: energy-mean dBA in first 5 min; arithmetic mean of transformed outcome in minutes 5-8.
mos_exp <- route[route$time_in_phase_sec < 300, , drop = FALSE]
mos_out <- route[route$time_in_phase_sec >= 300, , drop = FALSE]
mos_n_exp <- aggregate(mos_exp$time_in_phase_sec, mos_exp[c('ParticipantID', 'PhaseID')], length)
names(mos_n_exp)[3] <- 'n_exp'
mos_n_out <- aggregate(mos_out$time_in_phase_sec, mos_out[c('ParticipantID', 'PhaseID')], length)
names(mos_n_out)[3] <- 'n_out'
mos_dba <- aggregate(mos_exp[[ENV_DB]], mos_exp[c('ParticipantID', 'PhaseID')], energy_mean_db)
names(mos_dba)[3] <- 'mos_dba'
mos_y <- aggregate(mos_out[phys], mos_out[c('ParticipantID', 'PhaseID')], FUN = mean_na)
mos_df <- merge(merge(merge(mos_dba, mos_y, by = c('ParticipantID', 'PhaseID'), all = TRUE),
  mos_n_exp, by = c('ParticipantID', 'PhaseID'), all = TRUE),
  mos_n_out, by = c('ParticipantID', 'PhaseID'), all = TRUE)
mos_df$window_ok <- !is.na(mos_df$n_exp) & !is.na(mos_df$n_out) &
  mos_df$n_exp >= 20L & mos_df$n_out >= 12L
mos_df$ParticipantID <- factor(mos_df$ParticipantID, levels = participants)

hot_loud <- is.finite(phase_df$ucm_SND_dBA_energy) & phase_df$ucm_SND_dBA_energy > 65 &
  is.finite(phase_df$ucm_UTCI) & phase_df$ucm_UTCI > 26

make_signs <- local({
  cache <- new.env(parent = emptyenv())
  function(n) {
    key <- as.character(n)
    if (!exists(key, envir = cache, inherits = FALSE)) {
      if (n < 1L || n > 16L) stop('Exact sign-flip limited to 1..16 pairs')
      x <- as.matrix(expand.grid(rep(list(c(-1, 1)), n)))
      assign(key, x, envir = cache)
    }
    get(key, envir = cache)
  }
})
exact_signflip_p <- function(d) {
  n <- length(d)
  if (n < 3L) return(NA_real_)
  sums <- as.vector(make_signs(n) %*% d)
  observed <- abs(sum(d))
  mean(abs(sums) >= observed - 1e-10 * max(1, observed))
}

paired_stats <- function(d) {
  d <- d[is.finite(d)]
  n <- length(d)
  result <- list(n = n, mean = if (n) mean(d) else NA_real_, sd = if (n > 1L) sd(d) else NA_real_,
    df = if (n > 1L) n - 1L else NA_integer_,
    ci_low = NA_real_, ci_high = NA_real_, p_t = NA_real_,
    p_signflip = NA_real_, p_wilcoxon = NA_real_, dz = NA_real_,
    status = 'INSUFFICIENT_PAIRS')
  if (n < 3L) return(result)
  result$p_signflip <- exact_signflip_p(d)
  result$p_wilcoxon <- tryCatch(suppressWarnings(
    wilcox.test(d, mu = 0, exact = FALSE, correct = TRUE)$p.value), error = function(e) NA_real_)
  if (sd(d) <= sqrt(.Machine$double.eps)) {
    result$status <- 'NEAR_CONSTANT_DIFFERENCES_T_UNDEFINED'
    return(result)
  }
  tt <- t.test(d, mu = 0, conf.level = 0.95)
  result$ci_low <- unname(tt$conf.int[1L]); result$ci_high <- unname(tt$conf.int[2L])
  result$p_t <- unname(tt$p.value)
  result$dz <- mean(d) / sd(d)
  result$status <- 'FIT'
  result
}

bootstrap_ci <- function(d, B = 1999L) {
  d <- d[is.finite(d)]; n <- length(d)
  if (n < 3L) return(c(low = NA_real_, high = NA_real_))
  ix <- matrix(sample.int(n, n * B, replace = TRUE), nrow = n, ncol = B)
  means <- colMeans(matrix(d[ix], nrow = n, ncol = B))
  unname(quantile(means, c(.025, .975), na.rm = TRUE, names = FALSE))
}

person_slope <- function(y, x) {
  ok <- is.finite(y) & is.finite(x)
  if (sum(ok) < 2L || sd(x[ok]) <= sqrt(.Machine$double.eps)) return(NA_real_)
  unname(coef(lm(y[ok] ~ x[ok]))[2L])
}
person_r <- function(y, x) {
  ok <- is.finite(y) & is.finite(x)
  if (sum(ok) < 3L || sd(x[ok]) <= sqrt(.Machine$double.eps) || sd(y[ok]) <= sqrt(.Machine$double.eps))
    return(NA_real_)
  unname(cor(y[ok], x[ok]))
}
fisher_z <- function(r) ifelse(is.finite(r), atanh(pmax(-0.999, pmin(0.999, r))), NA_real_)

get_pairs <- function(variable, ref_phase, comp_phase, data = phase_df) {
  all <- data.frame(ParticipantID = participants, stringsAsFactors = FALSE)
  a <- data[data$PhaseID == ref_phase, c('ParticipantID', variable), drop = FALSE]
  b <- data[data$PhaseID == comp_phase, c('ParticipantID', variable), drop = FALSE]
  names(a) <- c('ParticipantID', 'ReferenceValue')
  names(b) <- c('ParticipantID', 'ComparisonValue')
  a$ParticipantID <- as.character(a$ParticipantID)
  b$ParticipantID <- as.character(b$ParticipantID)
  x <- merge(merge(all, a, by = 'ParticipantID', all.x = TRUE, sort = FALSE),
    b, by = 'ParticipantID', all.x = TRUE, sort = FALSE)
  x <- x[match(participants, x$ParticipantID), , drop = FALSE]
  x$Difference <- x$ComparisonValue - x$ReferenceValue
  x$IncludedInTest <- is.finite(x$Difference)
  rownames(x) <- NULL
  x
}

extract_emm <- function(fit, ref_phase, comp_phase, model_type) {
  if (is.null(fit)) return(data.frame(model = model_type, estimate = NA_real_, se = NA_real_,
    df = NA_real_, p = NA_real_, ci_low = NA_real_, ci_high = NA_real_, status = 'MODEL_NOT_FIT'))
  tryCatch({
    opts <- if (model_type == 'lmer_KR') list(lmer.df = 'kenward-roger') else
      if (model_type == 'lmer_Satterthwaite') list(lmer.df = 'satterthwaite') else list()
    em <- do.call(emmeans::emmeans, c(list(object = fit, specs = ~ PhaseID), opts))
    lev <- em@levels$PhaseID
    weights <- setNames(rep(0, length(lev)), lev)
    weights[comp_phase] <- 1; weights[ref_phase] <- -1
    result <- as.data.frame(summary(emmeans::contrast(em, method = list(paired = unname(weights))),
      infer = c(TRUE, TRUE)))
    data.frame(model = model_type, estimate = result$estimate[1], se = result$SE[1],
      df = result$df[1], p = result$p.value[1], ci_low = result$lower.CL[1],
      ci_high = result$upper.CL[1], status = 'FIT')
  }, error = function(e) data.frame(model = model_type, estimate = NA_real_, se = NA_real_,
    df = NA_real_, p = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
    status = paste0('ERROR: ', conditionMessage(e))))
}

fit_models <- function(outcome_col) {
  data <- phase_df[is.finite(phase_df[[outcome_col]]), c('ParticipantID', 'PhaseID', outcome_col), drop = FALSE]
  names(data)[3] <- 'model_y'
  data <- droplevels(data)
  if (nrow(data) < 24L || length(unique(data$ParticipantID)) < 8L ||
      length(unique(data$PhaseID)) != 4L || sd(data$model_y) <= 0) {
    return(list(nlme = NULL, lmer = NULL, n = nrow(data), participants = length(unique(data$ParticipantID)),
                nlme_status = 'NOT_ENOUGH_DATA', lmer_status = 'NOT_ENOUGH_DATA',
                data = data, warnings = character()))
  }
  fit_warnings <- character()
  base <- tryCatch(withCallingHandlers(nlme::lme(model_y ~ PhaseID, random = ~ 1 | ParticipantID,
      data = data, method = 'REML', na.action = na.omit,
      control = nlme::lmeControl(opt = 'optim', maxIter = 300, msMaxIter = 300,
                                 returnObject = FALSE)),
      warning = function(w) { fit_warnings <<- c(fit_warnings, conditionMessage(w)); invokeRestart('muffleWarning') }),
      error = function(e) NULL)
  lt <- NULL; lt_status <- if (!use_sat) 'OPTIONAL_PACKAGE_NOT_INSTALLED' else 'FAILED'
  if (use_sat) {
    lt <- tryCatch(withCallingHandlers(lmerTest::lmer(model_y ~ PhaseID + (1 | ParticipantID),
      data = data, REML = TRUE),
      warning = function(w) { fit_warnings <<- c(fit_warnings, conditionMessage(w)); invokeRestart('muffleWarning') }),
      error = function(e) NULL)
    if (!is.null(lt)) lt_status <- if (lme4::isSingular(lt, tol = 1e-4)) 'SINGULAR_FIT' else 'FIT'
  }
  list(nlme = base, lmer = lt, n = nrow(data), participants = length(unique(data$ParticipantID)),
       nlme_status = if (is.null(base)) 'FAILED' else 'FIT', lmer_status = lt_status,
       data = data, warnings = unique(fit_warnings))
}

min_detectable_dz <- function(n, target_power = 0.80) {
  if (n < 3L) return(NA_real_)
  pow <- function(d) power.t.test(n = n, delta = d, sd = 1, sig.level = .05,
                                   type = 'paired', alternative = 'two.sided')$power
  tryCatch(uniroot(function(d) pow(d) - target_power, lower = .00001, upper = 5)$root,
           error = function(e) NA_real_)
}

summary_rows <- list(); pair_rows <- list(); loo_rows <- list(); model_rows <- list(); assumption_rows <- list()
index <- 0L

record_person_values <- function(meta, values, extra_pair = NULL) {
  index <<- index + 1L
  id <- sprintf('RB%04d', index)
  meta$TestID <- id
  meta <- meta[c('TestID', setdiff(names(meta), 'TestID'))]
  d_all <- as.numeric(values)
  if (length(d_all) != length(participants)) stop('Person-level vector must match the 11-person cohort')
  included <- is.finite(d_all)
  d <- d_all[included]
  stat <- paired_stats(d)
  boot <- bootstrap_ci(d)
  pairs <- data.frame(ParticipantID = participants, PersonValue = d_all,
                      IncludedInTest = included, stringsAsFactors = FALSE)
  if (!is.null(extra_pair)) {
    extra_pair <- extra_pair[match(participants, extra_pair$ParticipantID), , drop = FALSE]
    for (nm in setdiff(names(extra_pair), c('ParticipantID', names(pairs)))) pairs[[nm]] <- extra_pair[[nm]]
  }
  for (col in names(meta)) pairs[[col]] <- meta[[col]]
  pair_rows[[index]] <<- pairs
  loo_stats <- list()
  pids <- participants[included]
  if (length(d)) for (j in seq_along(d)) {
    sub <- paired_stats(d[-j])
    loo_stats[[j]] <- data.frame(TestID = id, RemovedParticipant = pids[j],
      N_Remaining = sub$n, Mean_Without = sub$mean, P_t_Without = sub$p_t,
      CI95_Low_Without = sub$ci_low, CI95_High_Without = sub$ci_high,
      Status = sub$status)
  }
  if (length(loo_stats)) loo_rows[[index]] <<- do.call(rbind, loo_stats)
  lmeans <- if (length(loo_stats)) vapply(loo_stats, function(z) z$Mean_Without, numeric(1)) else numeric()
  loo_sign_change <- if (length(lmeans) && is.finite(stat$mean) && stat$mean != 0)
    any(sign(lmeans) != sign(stat$mean), na.rm = TRUE) else NA
  summary_rows[[index]] <<- cbind(meta, data.frame(
    N_Pairs = stat$n, N_MissingPairs = length(participants) - stat$n,
    MeanDifference = stat$mean, SD_Difference = stat$sd, Paired_dz = stat$dz,
    Paired_t_df = stat$df, CI95_Low_Paired_t = stat$ci_low, CI95_High_Paired_t = stat$ci_high,
    P_Paired_t = stat$p_t, P_Exact_Signflip = stat$p_signflip,
    P_Wilcoxon_Approx = stat$p_wilcoxon,
    Bootstrap_Percentile_CI95_Low = boot[1], Bootstrap_Percentile_CI95_High = boot[2],
    LOO_MinMean = if (length(lmeans)) min(lmeans) else NA_real_,
    LOO_MaxMean = if (length(lmeans)) max(lmeans) else NA_real_,
    LOO_AnySignChange = loo_sign_change,
    LOO_MaxAbsChange = if (length(lmeans)) max(abs(lmeans - stat$mean)) else NA_real_,
    Status = stat$status, stringsAsFactors = FALSE))
  invisible(id)
}

rbind_fill <- function(lst) {
  lst <- lst[!vapply(lst, is.null, logical(1))]
  if (!length(lst)) return(NULL)
  cols <- unique(unlist(lapply(lst, names)))
  lst <- lapply(lst, function(x) {
    for (nm in setdiff(cols, names(x))) x[[nm]] <- if (is.logical(x[[1]])) NA else NA
    x[cols]
  })
  do.call(rbind, lst)
}

# Descriptive residual screens only: flags prompt review; they never remove data
# or change a model/FDR result. No Shapiro-Wilk accept/reject rule is used.
lmm_diagnostic_rows <- function(fit, data, hypothesis, analysis, model_id, outcome,
                                outcome_type = '', warnings = character()) {
  base <- data.frame(hypothesis=hypothesis, analysis=analysis, model_id=model_id,
    outcome=outcome, predictor='', comparison='', method='descriptive_diagnostic',
    omitted_participant='', estimate=NA_real_, std_error=NA_real_, df=NA_real_,
    ci_lower=NA_real_, ci_upper=NA_real_, p_value=NA_real_,
    n_participants=length(unique(data$ParticipantID)), n_observations=nrow(data),
    status='', note='', statistic_test='', test_statistic=NA_real_,
    outcome_type=outcome_type, stringsAsFactors=FALSE)
  if (is.null(fit)) {
    base$status <- 'MODEL_NOT_FIT'
    base$statistic_test <- 'fit_status'
    base$note <- paste(c('Residual screens unavailable because the model did not fit.', warnings), collapse=' | ')
    return(base)
  }
  residual <- tryCatch(as.numeric(resid(fit, type='normalized')), error=function(e) numeric())
  fitted_value <- tryCatch(as.numeric(fitted(fit, level=1)), error=function(e) numeric())
  if (length(residual) != nrow(data) || length(fitted_value) != nrow(data)) {
    base$status <- 'DIAGNOSTIC_EXTRACTION_FAILED'
    base$statistic_test <- 'residual_vector_alignment'
    base$note <- 'Could not align normalized residuals and fitted values to complete phase cells.'
    return(base)
  }
  spread_correlation <- suppressWarnings(cor(abs(residual), fitted_value, use='complete.obs'))
  max_abs_residual <- max(abs(residual), na.rm=TRUE)
  residual_sd <- tapply(residual, droplevels(data$PhaseID), sd, na.rm=TRUE)
  residual_sd <- residual_sd[is.finite(residual_sd) & residual_sd > 0]
  phase_sd_ratio <- if (length(residual_sd) >= 2L) max(residual_sd)/min(residual_sd) else NA_real_
  metrics <- data.frame(
    statistic_test=c('abs_residual_fitted_correlation','max_abs_normalized_residual','phase_residual_sd_ratio'),
    test_statistic=c(abs(spread_correlation), max_abs_residual, phase_sd_ratio),
    status=c(if (is.finite(spread_correlation) && abs(spread_correlation) > .20) 'REVIEW_FLAG' else 'NO_HEURISTIC_FLAG',
      if (is.finite(max_abs_residual) && max_abs_residual > 3) 'REVIEW_FLAG' else 'NO_HEURISTIC_FLAG',
      if (is.finite(phase_sd_ratio) && phase_sd_ratio > 2) 'REVIEW_FLAG' else 'NO_HEURISTIC_FLAG'),
    stringsAsFactors=FALSE)
  result <- base[rep(1L,nrow(metrics)),,drop=FALSE]
  result$statistic_test <- metrics$statistic_test
  result$test_statistic <- metrics$test_statistic
  result$status <- metrics$status
  result$note <- c(
    'Informal screen from the flowchart: |cor(abs(normalized residual), fitted)| > 0.20. Review a residual-versus-fitted plot; this is not a formal test or rejection rule.',
    'Flag if any |normalized residual| > 3; inspect the observation and its data/model context without automatic exclusion.',
    'Flag if the largest/smallest phase-specific residual SD exceeds 2; descriptive variance screen, not a formal test.')
  if (length(warnings)) result$note <- paste(result$note, 'Fit warning(s):', paste(unique(warnings),collapse='; '))
  result
}

set.seed(20261106L)

# ---- H1 and H3: paired phase-mean differences (original audit, all outcomes) ----
for (outcome_type in c('Physiological', 'Questionnaire')) {
  outcomes <- if (outcome_type == 'Physiological') phys else psych
  for (scale in c('Primary', 'Sensitivity_WPZ')) {
    for (outcome in outcomes) {
      outcome_col <- if (scale == 'Primary') outcome else paste0('within_person_z__', outcome)
      fits <- fit_models(outcome_col)
      if (scale == 'Primary') assumption_rows[[length(assumption_rows) + 1L]] <-
        lmm_diagnostic_rows(fits$nlme, fits$data, 'H1_H3', 'phaseavg_assumption_diagnostics',
          'phase_mean_random_intercept', outcome, outcome_type, fits$warnings)
      for (k in seq_len(nrow(contrast_specs))) {
        spec_row <- contrast_specs[k, , drop = FALSE]
        ref <- spec_row$Reference_PhaseID; comp <- spec_row$Comparison_PhaseID
        pairs <- get_pairs(outcome_col, ref, comp)
        meta <- data.frame(Hypothesis = spec_row$Hypothesis,
          Sub_Hypothesis = spec_row$Sub_Hypothesis, Contrast = paste(comp, '-', ref),
          Reference_PhaseID = ref, Comparison_PhaseID = comp,
          Outcome_Type = outcome_type, Outcome = outcome, Predictor = 'PhaseID',
          Scale = scale, ValueType = 'paired_difference', stringsAsFactors = FALSE)
        id <- record_person_values(meta, pairs$Difference, extra_pair = pairs)
        model_rows[[length(model_rows) + 1L]] <- cbind(data.frame(TestID = id, meta, stringsAsFactors = FALSE),
          data.frame(Model_N_PhaseCells = fits$n, Model_N_Participants = fits$participants,
                     Model_Status = fits$nlme_status),
          extract_emm(fits$nlme, ref, comp, 'nlme_REML_original'))
        for (method in c('lmer_Satterthwaite', 'lmer_KR')) {
          available <- if (method == 'lmer_Satterthwaite') use_sat else use_kr
          z <- if (available) extract_emm(fits$lmer, ref, comp, method) else
            extract_emm(NULL, ref, comp, method)
          if (!available) z$status <- 'OPTIONAL_PACKAGE_UNAVAILABLE_OR_DISABLED'
          if (available && fits$lmer_status == 'SINGULAR_FIT') z$status <- 'SINGULAR_FIT__INTERPRET_CAUTION'
          model_rows[[length(model_rows) + 1L]] <- cbind(data.frame(TestID = id, meta, stringsAsFactors = FALSE),
            data.frame(Model_N_PhaseCells = fits$n, Model_N_Participants = fits$participants,
                       Model_Status = fits$lmer_status), z)
        }
      }
    }
  }
}

# ---- H2: person-level Fisher z of psych vs physio across the four phase means ----
for (psych_var in psych) for (phys_var in phys) {
  z_by_person <- vapply(participants, function(pid) {
    rows <- phase_df$ParticipantID == pid
    fisher_z(person_r(phase_df[[psych_var]][rows], phase_df[[phys_var]][rows]))
  }, numeric(1))
  extra <- data.frame(ParticipantID = participants,
    PersonR = vapply(participants, function(pid) {
      rows <- phase_df$ParticipantID == pid
      person_r(phase_df[[psych_var]][rows], phase_df[[phys_var]][rows])
    }, numeric(1)), stringsAsFactors = FALSE)
  record_person_values(data.frame(
    Hypothesis = 'H2', Sub_Hypothesis = 'H2_rmcorr_person_Fisher_z', Contrast = 'within_person',
    Reference_PhaseID = NA_character_, Comparison_PhaseID = NA_character_,
    Outcome_Type = 'Questionnaire_x_Physiological', Outcome = psych_var, Predictor = phys_var,
    Scale = 'Primary', ValueType = 'fisher_z_of_person_r', stringsAsFactors = FALSE),
    z_by_person, extra_pair = extra)
}

# Actual restoration concordance is checked in the model-matched extension.

# ---- H4: person-level slopes of outcome on energy-mean dBA (and Moshammer windows / hot-loud subset) ----
h4_quest <- c('questionnaire_thermal_comfort_1_5', 'questionnaire_acoustic_comfort_1_5',
              'questionnaire_current_comfort_1_7')
h4_targets <- list(
  Physiological = phys,
  Questionnaire = h4_quest)
for (outcome_type in names(h4_targets)) {
  for (outcome in h4_targets[[outcome_type]]) {
    slopes <- vapply(participants, function(pid) {
      rows <- phase_df$ParticipantID == pid
      person_slope(phase_df[[outcome]][rows], phase_df$ucm_SND_dBA_energy[rows])
    }, numeric(1))
    record_person_values(data.frame(
      Hypothesis = 'H4', Sub_Hypothesis = 'H4_dBA_person_slope', Contrast = 'within_person',
      Reference_PhaseID = NA_character_, Comparison_PhaseID = NA_character_,
      Outcome_Type = outcome_type, Outcome = outcome, Predictor = 'ucm_SND_dBA_energy',
      Scale = 'AllPhases', ValueType = 'person_slope', stringsAsFactors = FALSE), slopes)

    slopes_hl <- vapply(participants, function(pid) {
      rows <- phase_df$ParticipantID == pid & hot_loud
      person_slope(phase_df[[outcome]][rows], phase_df$ucm_SND_dBA_energy[rows])
    }, numeric(1))
    record_person_values(data.frame(
      Hypothesis = 'H4', Sub_Hypothesis = 'H4_dBA_person_slope', Contrast = 'within_person',
      Reference_PhaseID = NA_character_, Comparison_PhaseID = NA_character_,
      Outcome_Type = outcome_type, Outcome = outcome, Predictor = 'ucm_SND_dBA_energy',
      Scale = 'HotLoud_dBA65_UTCI26', ValueType = 'person_slope', stringsAsFactors = FALSE), slopes_hl)
  }
}

for (outcome in phys) {
  slopes <- vapply(participants, function(pid) {
    rows <- mos_df$ParticipantID == pid & mos_df$window_ok
    person_slope(mos_df[[outcome]][rows], mos_df$mos_dba[rows])
  }, numeric(1))
  record_person_values(data.frame(
    Hypothesis = 'H4', Sub_Hypothesis = 'H4_Moshammer_window_person_slope', Contrast = 'within_person',
    Reference_PhaseID = NA_character_, Comparison_PhaseID = NA_character_,
    Outcome_Type = 'Physiological', Outcome = outcome, Predictor = 'mos_dba_first5min',
    Scale = 'Moshammer_first5_vs_last3', ValueType = 'person_slope', stringsAsFactors = FALSE), slopes)
}

# Rodrigues temperature analogue: thermal vote on UTCI
utci_slopes <- vapply(participants, function(pid) {
  rows <- phase_df$ParticipantID == pid
  person_slope(phase_df$questionnaire_thermal_comfort_1_5[rows], phase_df$ucm_UTCI[rows])
}, numeric(1))
record_person_values(data.frame(
  Hypothesis = 'H4', Sub_Hypothesis = 'H4_thermal_vote_on_UTCI', Contrast = 'within_person',
  Reference_PhaseID = NA_character_, Comparison_PhaseID = NA_character_,
  Outcome_Type = 'Questionnaire', Outcome = 'questionnaire_thermal_comfort_1_5', Predictor = 'ucm_UTCI',
  Scale = 'AllPhases', ValueType = 'person_slope', stringsAsFactors = FALSE), utci_slopes)

# ---- H5: person-level slopes matching combined-exposure Eq1-7 phase-mean predictors ----
for (eq in names(H5_EXPOSURES)) {
  for (exposure in H5_EXPOSURES[[eq]]) {
    xcol <- if (exposure == 'ucm_SND_dBA') 'ucm_SND_dBA' else exposure
    for (outcome in phys) {
      slopes <- vapply(participants, function(pid) {
        rows <- phase_df$ParticipantID == pid
        person_slope(phase_df[[outcome]][rows], phase_df[[xcol]][rows])
      }, numeric(1))
      record_person_values(data.frame(
        Hypothesis = 'H5', Sub_Hypothesis = paste0('H5_', eq), Contrast = 'within_person',
        Reference_PhaseID = NA_character_, Comparison_PhaseID = NA_character_,
        Outcome_Type = 'Physiological', Outcome = outcome, Predictor = xcol,
        Scale = 'Phaseavg', ValueType = 'person_slope', stringsAsFactors = FALSE), slopes)
    }
  }
}

summary_table <- do.call(rbind, summary_rows)
pairs_table <- rbind_fill(pair_rows)
loo_table <- do.call(rbind, loo_rows)
models_table <- do.call(rbind, model_rows)

# BH families: H1/H3 as original (contrast x outcome type x scale);
# H2 rmcorr = 468 pairs; H2 concordance = 3 outcome deltas per mode;
# H4 = predictor x scale x outcome type; H5 = equation x predictor.
summary_table$FamilyID <- ifelse(summary_table$Hypothesis %in% c('H1', 'H3'),
  paste(summary_table$Hypothesis, summary_table$Contrast, summary_table$Outcome_Type, summary_table$Scale, sep = '__'),
  ifelse(summary_table$Hypothesis == 'H2' & summary_table$Scale == 'Primary',
    'H2__rmcorr_person_Fisher_z',
    ifelse(summary_table$Hypothesis == 'H2',
      paste(summary_table$Sub_Hypothesis, sep = ''),
      paste(summary_table$Hypothesis, summary_table$Sub_Hypothesis, summary_table$Predictor,
            summary_table$Outcome_Type, summary_table$Scale, sep = '__'))))
family_n <- as.integer(ave(seq_len(nrow(summary_table)), summary_table$FamilyID, FUN = length))
summary_table$FamilySize <- family_n
summary_table$Q_Paired_t <- NA_real_
summary_table$Q_Signflip <- NA_real_
summary_table$Q_Wilcoxon <- NA_real_
for (family in unique(summary_table$FamilyID)) {
  ii <- which(summary_table$FamilyID == family)
  n_family <- unique(summary_table$FamilySize[ii])
  if (length(n_family) != 1L || length(ii) != n_family) stop('Unexpected family size: ', family)
  summary_table$Q_Paired_t[ii] <- p.adjust(summary_table$P_Paired_t[ii], method = 'BH', n = length(ii))
  summary_table$Q_Signflip[ii] <- p.adjust(summary_table$P_Exact_Signflip[ii], method = 'BH', n = length(ii))
  summary_table$Q_Wilcoxon[ii] <- p.adjust(summary_table$P_Wilcoxon_Approx[ii], method = 'BH', n = length(ii))
}
summary_table$Paired_t_FDR05 <- ifelse(is.na(summary_table$Q_Paired_t), NA, summary_table$Q_Paired_t < .05)
summary_table$Signflip_FDR05 <- ifelse(is.na(summary_table$Q_Signflip), NA, summary_table$Q_Signflip < .05)

pairs_table$Observed <- as.integer(pairs_table$IncludedInTest)
coverage <- aggregate(Observed ~ Hypothesis + Contrast + Outcome_Type + Outcome + Predictor + Scale + ValueType,
  data = pairs_table, FUN = sum)
names(coverage)[ncol(coverage)] <- 'N_CompletePairs'
coverage$N_ExpectedPairs <- length(participants)
coverage$N_MissingPairs <- coverage$N_ExpectedPairs - coverage$N_CompletePairs
power_table <- data.frame(N_CompletePairs = sort(unique(summary_table$N_Pairs)))
power_table$MDE_Cohen_dz_80pct_power <- vapply(power_table$N_CompletePairs, min_detectable_dz, numeric(1))
power_table$TwoSidedAlpha <- .05
power_table$Notes <- 'Sensitivity for an unadjusted paired t-test only; not post-hoc observed power or BH-corrected power'

hit_count <- do.call(rbind, lapply(split(summary_table, summary_table$FamilyID), function(x) {
  data.frame(
    Hypothesis = x$Hypothesis[1], FamilyID = x$FamilyID[1], Scale = x$Scale[1],
    Outcome_Type = x$Outcome_Type[1], Predictor = paste(unique(x$Predictor), collapse = '|'),
    N_Tests = nrow(x), N_Paired_t_FDR05 = sum(x$Paired_t_FDR05, na.rm = TRUE),
    N_Signflip_FDR05 = sum(x$Signflip_FDR05, na.rm = TRUE),
    N_Both_FDR05 = sum(x$Paired_t_FDR05 & x$Signflip_FDR05, na.rm = TRUE),
    N_Complete_11 = sum(x$N_Pairs == 11L),
    Median_N_Pairs = median(x$N_Pairs), stringsAsFactors = FALSE)
}))
hit_count <- hit_count[order(hit_count$Hypothesis, hit_count$FamilyID), ]
rownames(hit_count) <- NULL

# Exact model-matched checks run in independent workers and checkpoint safely.
source(file.path(entry_dir, 'library', 'Paper3_robustness_models.R'), local = FALSE)
cache_dir <- file.path(PROJECT_ROOT, 'temp', 'robustness_check')
dir.create(cache_dir, recursive = TRUE, showWarnings = FALSE)
fingerprint_paths <- c(raw_path, spec$normalization_csv_path,
  file.path(PROJECT_ROOT, "output/empatica_files/01_empatica_rri_native.csv"),
  normalizePath(sub('^--file=', '', args[1L])),
  file.path(entry_dir, c('H5_combined_phaseavg.R', 'H4_sound_literature_test.R', 'H1_H3_phaseavg.R')),
  list.files(file.path(entry_dir, 'library'), pattern='[.]R$', full.names = TRUE))
fingerprint <- tools::md5sum(fingerprint_paths)
primary_dirs <- file.path(PROJECT_ROOT, 'output/statistical_analysis/results',
  c('H1_H3_phaseavg', 'H1_H3_timeseries', 'H4_sound_literature_test', 'H5_combined_phaseavg', 'H5_combined_timeseries'))
primary_files <- unlist(lapply(primary_dirs,list.files,full.names=TRUE,recursive=TRUE))
primary_hashes <- tools::md5sum(primary_files)
run_extended <- function(task, root, phase_data, cohort, physiology, questionnaires, kr, cache, fingerprint) {
  source(file.path(root, 'scripts/statistical_analysis/library/Paper3_common.R'), local = FALSE)
  source(file.path(root, 'scripts/statistical_analysis/library/Paper3_robustness_models.R'), local = FALSE)
  settings <- list(KR=kr,H2_draws=1999L,R_version=R.version.string,
    packages=vapply(c('nlme','clubSandwich','lme4','lmerTest','pbkrtest','mgcv'),
      function(package)if(requireNamespace(package,quietly=TRUE))as.character(packageVersion(package)) else 'UNAVAILABLE',character(1)))
  path <- file.path(cache,paste0(task,'.rds'))
  if(file.exists(path)) {
    previous <- readRDS(path)
    # This revision adds diagnostics/warning capture only; preserve completed
    # model-check caches when every data, model-helper and package fingerprint matches.
    old_fit_fingerprint <- previous$fingerprint[!grepl('H1_H5_robustness[.]R$',names(previous$fingerprint))]
    new_fit_fingerprint <- fingerprint[!grepl('H1_H5_robustness[.]R$',names(fingerprint))]
    if(identical(old_fit_fingerprint,new_fit_fingerprint) && identical(previous$settings,settings))return(previous$data)
  }
  message('Starting model-matched ',task)
  data <- switch(task,H2=robustness_h2(phase_data,physiology,questionnaires,cohort),
    H4=robustness_h4(root,cohort),H5=robustness_h5(root,cohort,physiology,kr))
  saveRDS(list(fingerprint=fingerprint,settings=settings,data=data),path)
  data
}
workers <- max(1L,min(3L,as.integer(Sys.getenv('PAPER3_ROBUSTNESS_WORKERS','1'))))
if(workers==1L) {
  model_checks <- lapply(c('H2','H4','H5'),run_extended,root=PROJECT_ROOT,
    phase_data=phase_df,cohort=participants,physiology=phys,questionnaires=psych,
    kr=use_kr,cache=cache_dir,fingerprint=fingerprint)
} else {
  cluster <- parallel::makePSOCKcluster(workers,outfile=file.path(cache_dir,'workers.log'))
  model_checks <- tryCatch(parallel::parLapply(cluster,c('H2','H4','H5'),run_extended,
    root=PROJECT_ROOT,phase_data=phase_df,cohort=participants,physiology=phys,questionnaires=psych,
    kr=use_kr,cache=cache_dir,fingerprint=fingerprint),finally=parallel::stopCluster(cluster))
}

model_checks <- robustness_bind(model_checks)
# Small-sample alternatives for H1/H3: same fixed effects, random intercept and contrasts.
original_models <- data.frame(hypothesis=models_table$Hypothesis,analysis='original_phase_contrast',
  model_id=models_table$Scale,outcome=models_table$Outcome,predictor='PhaseID',comparison=models_table$Contrast,
  method=models_table$model,omitted_participant='',estimate=models_table$estimate,std_error=models_table$se,
  df=models_table$df,ci_lower=models_table$ci_low,ci_upper=models_table$ci_high,p_value=models_table$p,
  n_participants=models_table$Model_N_Participants,n_observations=models_table$Model_N_PhaseCells,
  status=models_table$status,note=paste('outcome_type=',models_table$Outcome_Type,sep=''))
original_models <- robustness_adjust(original_models,
  paste(original_models$hypothesis,original_models$model_id,original_models$comparison,
    original_models$method,models_table$Outcome_Type))
model_checks <- robustness_bind(list(original_models,model_checks))
source(file.path(entry_dir, 'library', 'Paper3_robustness_small_sample.R'), local = FALSE)
model_checks <- robustness_bind(list(model_checks,robustness_h4_additional(PROJECT_ROOT,participants)))
model_checks <- robustness_bind(list(model_checks,
  robustness_jackknife_h4(model_checks),robustness_jin_cluster(PROJECT_ROOT,participants),
  robustness_h1_h3_models(pairs_table,participants),robustness_h1_h3_models(pairs_table,participants,full_only=TRUE)))

# Add model-matched residual screens for all full-cohort H5 phase-mean LMMs.
h5_diag_environment <- new.env(parent=.GlobalEnv)
h5_diag_environment$PROJECT_ROOT <- PROJECT_ROOT
h5_diag_environment$RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
h5_diag_environment$combined_study_spec <- paper3_combined_study_spec(PROJECT_ROOT)
h5_diag_environment$COMBINED_VARIANT <- 'phaseavg'
h5_diag_entry <- file.path(entry_dir,'H5_combined_phaseavg.R')
for (expression in parse(h5_diag_entry)) if (is.call(expression) && identical(expression[[1L]],as.name('<-')) &&
    grepl('^Eq[1-7]$',as.character(expression[[2L]]))) eval(expression,h5_diag_environment)
source(file.path(entry_dir,'library','H5_combined_core.R'),local=h5_diag_environment)
h5_diag_raw <- h5_diag_environment$combined_read_input()
h5_diagnostics <- vector('list',length=length(phys)*7L); h5_diagnostic_index <- 0L
for (equation_id in 1:7) for (outcome in phys) {
  equation <- h5_diag_environment[[paste0('Eq',equation_id)]]
  fixed <- as.formula(equation[[2L]])
  exposures <- setdiff(h5_diag_environment$combined_fixed_terms(equation),h5_diag_environment$COMBINED_PHASE_SUM_COLS)
  selected <- h5_diag_raw[,c('ParticipantID','PhaseID',exposures,outcome),drop=FALSE]
  selected$Y <- paper3_apply_csv_transform(selected[[outcome]],outcome,
    h5_diag_environment$combined_study_spec$outcome_transforms_csv)
  selected <- selected[rowSums(!is.finite(as.matrix(selected[,c(exposures,'Y'),drop=FALSE])))==0,,drop=FALSE]
  cell <- aggregate(selected[,c(exposures,'Y'),drop=FALSE],selected[,c('ParticipantID','PhaseID'),drop=FALSE],mean)
  cell <- cell[order(cell$ParticipantID,cell$PhaseID),,drop=FALSE]
  cell$ParticipantID <- factor(cell$ParticipantID); cell$PhaseID <- factor(cell$PhaseID)
  for (variable in exposures) {
    centered <- cell[[variable]]-ave(cell[[variable]],cell$ParticipantID,FUN=mean)
    scale <- sd(centered)
    cell[[paste0(variable,'_phase_z')]] <- if (is.finite(scale)&&scale>0) centered/scale else centered
  }
  cell[,h5_diag_environment$COMBINED_PHASE_SUM_COLS] <- paper3_phase_sum_design(cell$PhaseID)
  design <- model.matrix(fixed,cell); warnings <- character()
  fit <- if (qr(design)$rank==ncol(design)) tryCatch(withCallingHandlers(
    nlme::lme(fixed,data=cell,random=~1|ParticipantID,method='REML',na.action=na.fail,
      control=nlme::lmeControl(maxIter=100,msMaxIter=150,returnObject=FALSE)),
    warning=function(w){warnings<<-c(warnings,conditionMessage(w));invokeRestart('muffleWarning')}),
    error=function(e)NULL) else NULL
  h5_diagnostic_index <- h5_diagnostic_index+1L
  h5_diagnostics[[h5_diagnostic_index]] <- lmm_diagnostic_rows(fit,cell,'H5',
    'phaseavg_assumption_diagnostics',paste0('Eq',equation_id),outcome,'Physiological',unique(warnings))
  if (h5_diagnostic_index %% 26L == 0L) message('H5 residual diagnostic models: ',h5_diagnostic_index,'/182')
}
model_checks <- robustness_bind(list(model_checks,robustness_bind(assumption_rows),robustness_bind(h5_diagnostics)))
review_notes <- data.frame(
  hypothesis=c('H1_H3','H1_H3','H4'),
  analysis='model_form_review',
  model_id=c('phase_mean_questionnaire_LMM','EDA_tonic_transform','source_specific_methods'),
  outcome=c('questionnaire_current_comfort_1_7','empatica_eda_tonic',''),
  predictor='',comparison='',method='review_required',omitted_participant='',
  estimate=NA_real_,std_error=NA_real_,df=NA_real_,ci_lower=NA_real_,ci_upper=NA_real_,p_value=NA_real_,
  n_participants=NA_integer_,n_observations=NA_integer_,status=c('REVIEW_REQUIRED','SENSITIVITY_NOT_RUN','METHOD_SPECIFIC_REVIEW'),
  note=c('Alain questioned treating this single 1–7 item as Gaussian. This robustness run does not fit an ordinal mixed model; justify the approximation or add a prespecified ordinal sensitivity before claiming this outcome is assumption-checked.',
    'The current normalization register uses natural log for tonic EDA; Alain suggested square root. This run records the discrepancy but does not refit a square-root sensitivity, so transformation robustness remains open.',
    'H4 combines different source-specific tests/models. The generic Gaussian-LMM residual flags are not valid for every H4 method; check assumptions by source method rather than treating this field as a pass.'),
  statistic_test='analysis_scope_note',test_statistic=NA_real_,stringsAsFactors=FALSE)
model_checks <- robustness_bind(list(model_checks,review_notes))

# Check that full-cohort model-matched fits reproduce saved primary coefficients.
reference_checks <- list()
compare_reference <- function(current, reference, current_key, reference_key, current_effect='estimate', reference_effect='estimate') {
  matched <- match(current_key,reference_key)
  delta <- abs(current[[current_effect]]-reference[[reference_effect]][matched])
  p_delta <- abs(current$p_value-reference$p_value[matched])
  data.frame(n_checked=nrow(current),n_matched=sum(!is.na(matched)),
    max_effect_difference=if(any(is.finite(delta)))max(delta,na.rm=TRUE) else NA_real_,
    max_p_difference=if(any(is.finite(p_delta)))max(p_delta,na.rm=TRUE) else NA_real_)
}
key <- function(table)paste(table$model_id,table$outcome,table$predictor,sep=' | ')
h5_reference <- read.csv(file.path(PROJECT_ROOT,'output/statistical_analysis/results/H5_combined_phaseavg/H5_combined_phaseavg_Heat_Noise_Exposures.csv'))
h5_current <- model_checks[model_checks$hypothesis=='H5' & model_checks$method=='CR2_Satterthwaite' &
  model_checks$omitted_participant=='' & !startsWith(model_checks$predictor,'PhaseSum'),]
reference_checks$H5 <- compare_reference(h5_current,h5_reference,key(h5_current),key(h5_reference))
h2_reference <- read.csv(file.path(PROJECT_ROOT,'output/statistical_analysis/results/H1_H3_phaseavg/H2_Concordance.csv'))
h2_reference <- h2_reference[h2_reference$statistic_test=='t-test (within-participant correlation)',]
h2_current <- model_checks[model_checks$hypothesis=='H2' & model_checks$method=='original_rmcorr',]
reference_checks$H2 <- compare_reference(h2_current,h2_reference,paste(h2_current$outcome,h2_current$predictor),
  paste(h2_reference$outcome,h2_reference$predictor),reference_effect='correlation')
stopifnot(reference_checks$H5$n_checked==reference_checks$H5$n_matched,
  reference_checks$H5$max_effect_difference<1e-7,reference_checks$H5$max_p_difference<1e-7,
  reference_checks$H2$n_checked==reference_checks$H2$n_matched,
  reference_checks$H2$max_effect_difference<1e-7,reference_checks$H2$max_p_difference<1e-7)

# Never change a primary table or the source input while validating robustness.
stopifnot(identical(unname(primary_hashes),unname(tools::md5sum(primary_files))),
          identical(unname(fingerprint),unname(tools::md5sum(fingerprint_paths))))

out <- file.path(PROJECT_ROOT, 'output', 'statistical_analysis', 'results', 'Robustness_check')
dir.create(out, recursive = TRUE, showWarnings = FALSE)
md5_input <- unname(tools::md5sum(raw_path))
md5_normalization <- unname(tools::md5sum(spec$normalization_csv_path))
n_hot <- sum(hot_loud)
manifest <- c(
  'Paper3 H1-H5 robustness audit — POST-HOC sensitivity, not preregistered.',
  paste('RunUTC:', format(Sys.time(), tz = 'UTC', usetz = TRUE)),
  paste('Input:', normalizePath(raw_path)), paste('InputMD5:', md5_input),
  paste('NormalizationMD5:', md5_normalization),
  paste('Participants:', paste(participants, collapse = ', ')),
  paste('ParticipantCount:', length(participants)),
  paste('PhaseCells:', nrow(phase_df)),
  paste('HotLoudPhaseCells_dBA65_UTCI26:', n_hot),
  paste('MatchedCapSeconds:', spec$matched_cap_sec),
  paste('PhysiologicalOutcomes:', length(phys)),
  paste('QuestionnaireOutcomes:', length(psych)),
  'H1/H3: paired differences of phase means; four planned contrasts; Primary and WPZ.',
  'H2: Fisher z of the per-person Pearson r of questionnaire vs physiology across 4 phase means (n>=3 phases); BH over 468 pairs.',
  'H2 restoration concordance: actual Spearman association of paired deltas, six-test family, in model_checks.csv.',
  'H4: per-person slope of outcome on energy-mean dBA (all 4 phases and dBA>65 & UTCI>26 subset); Moshammer first-5 vs last-3 window; thermal vote on UTCI.',
  'H5 complementary slopes: each distinct outcome-exposure pair once; unadjusted, not the seven adjusted equations. Model-matched equations are in model_checks.csv.',
  'All tests use the 11 participants as the unit. No participant, outcome or significance filter.',
  'Paired t: two-sided, participant values, df=n_pairs-1.',
  'Exact sign-flip: two-sided mean statistic, enumerated 2^n signs.',
  'LOO: every included participant deleted once; descriptive only.',
  'Bootstrap: 1999 subject-resampling draws, percentile CI; fixed seed 20261106.',
  'Primary nlme / rmcorr / H4 literature / H5 combined mixed models are unchanged.',
  'H4 extra sensitivity: participant jackknife t approximation on coefficients; participant-blocked Jin ANOVA with CR2/HTZ. Original source tests remain separate.',
  'Descriptive phaseavg residual flags are added for full-cohort H1/H3 and H5 Gaussian mixed models. Thresholds are review heuristics only; they do not reject models, remove rows, or change q-values.',
  'No Shapiro-Wilk p-value is used. H2 and H4 use different model structures and do not receive a generic Gaussian-LMM residual screen.',
  'Open Alain points recorded in model_checks: ordinal model suitability for current_comfort_1_7 and square-root tonic-EDA transformation sensitivity remain unresolved.',
  'No sample-size or robustness-pass rule guarantees validity. Singular fits, undefined inference, low df and sparse designs are retained as diagnostic flags.',
  paste('lmerTest_Satterthwaite_Available:', use_sat),
  paste('KenwardRoger_AvailableAndEnabled:', use_kr),
  paste('R_Version:', R.version.string), paste('OutputFolder:', out))
# A run_info table holds the smaller audit tables and provenance; five published files total.
metadata <- data.frame(section='manifest',key=seq_along(manifest),value=manifest)
pack_info <- function(table,section){
  rows <- lapply(seq_len(nrow(table)),function(index)data.frame(section=section,row=index,
    key=names(table),value=as.character(table[index,])))
  robustness_bind(rows)
}
diagnostic_rows_published <- model_checks[model_checks$analysis=='phaseavg_assumption_diagnostics',,drop=FALSE]
diagnostic_counts <- if(nrow(diagnostic_rows_published)) aggregate(
  rep(1L,nrow(diagnostic_rows_published)),
  by=list(Hypothesis=diagnostic_rows_published$hypothesis,Diagnostic=diagnostic_rows_published$statistic_test,
          Status=diagnostic_rows_published$status),FUN=sum) else
  data.frame(Hypothesis=character(),Diagnostic=character(),Status=character(),x=integer())
names(diagnostic_counts)[ncol(diagnostic_counts)] <- 'N_Models'
metadata <- robustness_bind(list(metadata,pack_info(coverage,'coverage'),pack_info(power_table,'power_sensitivity'),
  pack_info(hit_count,'complementary_test_counts'),pack_info(phase_df[c('ParticipantID','PhaseID','ucm_SND_dBA_energy','ucm_UTCI')],'phase_inventory'),
  pack_info(diagnostic_counts,'phaseavg_diagnostic_flag_counts'),
  pack_info(robustness_bind(reference_checks),'primary_reproduction'),
  data.frame(section='primary_output_md5',key=names(primary_hashes),value=unname(primary_hashes)),
  data.frame(section='source_md5',key=names(fingerprint),value=unname(fingerprint))))
staging <- tempfile('publish_',tmpdir=cache_dir);dir.create(staging)
published <- list(all_person_level_tests.csv=summary_table,all_participant_values.csv=pairs_table,
  all_leave_one_out.csv=loo_table,model_checks.csv=model_checks,run_info.csv=metadata)
for(name in names(published))write.csv(published[[name]],file.path(staging,name),row.names=FALSE,na='')
hash_rows <- data.frame(section='output_md5',key=setdiff(names(published),'run_info.csv'),
  value=unname(tools::md5sum(file.path(staging,setdiff(names(published),'run_info.csv')))))
published$run_info.csv <- robustness_bind(list(published$run_info.csv,hash_rows))
write.csv(published$run_info.csv,file.path(staging,'run_info.csv'),row.names=FALSE,na='')
for(name in names(published)) {
  checked <- read.csv(file.path(staging,name),check.names=FALSE)
  stopifnot(nrow(checked)==nrow(published[[name]]))
}
# Retire only the specifically named generated predecessor files after replacement files are ready.
predecessors <- c('H1_H3_model_degrees_of_freedom_comparison.csv','pair_coverage.csv',
 'prospective_power_sensitivity.csv','hit_count_summary.csv','phase_cell_inventory.csv','analysis_manifest.txt',
 'Table_robustness_summary.csv') # 2026-11-12: summary table is rebuilt by the block at the end
for(name in names(published))stopifnot(file.copy(file.path(staging,name),file.path(out,name),overwrite=TRUE))
unlink(file.path(out,predecessors))
stopifnot(length(list.files(out))==5L)
message('Published five checked files; primary output hashes unchanged.')

cat('\nH1-H5 robustness audit complete.\n')
cat('Output:', out, '\n')
cat('Person-level tests:', nrow(summary_table), '\n')
cat('H1/H3 Primary paired-t FDR hits:',
    sum(summary_table$Hypothesis %in% c('H1', 'H3') & summary_table$Scale == 'Primary' &
          summary_table$Paired_t_FDR05, na.rm = TRUE), '\n')
cat('H2 rmcorr Fisher-z FDR hits (paired t / sign-flip):',
    sum(summary_table$FamilyID == 'H2__rmcorr_person_Fisher_z' & summary_table$Paired_t_FDR05, na.rm = TRUE), '/',
    sum(summary_table$FamilyID == 'H2__rmcorr_person_Fisher_z' & summary_table$Signflip_FDR05, na.rm = TRUE), '\n')
cat('H4 all-phase dBA slope FDR hits (physio paired t):',
    sum(summary_table$Hypothesis == 'H4' & summary_table$Scale == 'AllPhases' &
          summary_table$Outcome_Type == 'Physiological' & summary_table$Predictor == 'ucm_SND_dBA_energy' &
          summary_table$Paired_t_FDR05, na.rm = TRUE), '\n')
cat('H5 Phaseavg slope FDR hits (paired t):',
    sum(summary_table$Hypothesis == 'H5' & summary_table$Paired_t_FDR05, na.rm = TRUE), '\n')
cat('Hot-loud phase cells:', n_hot, 'of', nrow(phase_df), '\n')
cat('Primary mixed-model folders were not modified.\n')

# Robustness summary table (added 2026-11-12)
# Post hoc summary of FDR-significant primary results (q_value < 0.05) for H1/H3 phase
# contrasts (Primary scale) and H5 phase-mean coefficients. Reads ONLY saved outputs:
#   Robustness_check/model_checks.csv, Robustness_check/all_person_level_tests.csv,
#   H1_H3_phaseavg/H1_H3_Contrasts.csv, H5_combined_phaseavg/H5_combined_phaseavg_Heat_Noise_Exposures.csv
# Writes ONE file: Robustness_check/Table_robustness_summary.csv. H2 and H4 are not included.
# Run only this block (no model refits), from the project root:
#   Rscript -e "f <- 'scripts/statistical_analysis/H1_H5_robustness.R'; x <- parse(f, keep.source = TRUE); s <- grep('^# Robustness summary table [(]added 2026-11-12[)]', readLines(f)); for (e in x[vapply(attr(x, 'srcref'), function(r) r[1L] > s, logical(1))]) eval(e, globalenv())"
paper3_robustness_summary_table <- function(root) {
  res <- file.path(root, 'output', 'statistical_analysis', 'results')
  rob <- file.path(res, 'Robustness_check')
  checks <- read.csv(file.path(rob, 'model_checks.csv'), stringsAsFactors = FALSE)
  checks$omitted_participant[is.na(checks$omitted_participant)] <- ''
  for (column in c('estimate', 'p_value', 'q_value')) checks[[column]] <- suppressWarnings(as.numeric(checks[[column]]))
  person <- read.csv(file.path(rob, 'all_person_level_tests.csv'), stringsAsFactors = FALSE)
  h13 <- read.csv(file.path(res, 'H1_H3_phaseavg', 'H1_H3_Contrasts.csv'), stringsAsFactors = FALSE)
  h5 <- read.csv(file.path(res, 'H5_combined_phaseavg', 'H5_combined_phaseavg_Heat_Noise_Exposures.csv'),
                 stringsAsFactors = FALSE)
  # Leave-one-participant-out summary for the hit rows of one family.
  loo_summary <- function(hits, deletions, key_hits, key_deletions, n_cohort) {
    out <- data.frame(same_sign = logical(nrow(hits)), p05 = logical(nrow(hits)),
                      pct_min = NA_real_, pct_max = NA_real_)
    for (i in seq_len(nrow(hits))) {
      d <- deletions[key_deletions == key_hits[i], , drop = FALSE]
      ok <- nrow(d) == n_cohort && all(d$status == 'FIT') && all(is.finite(d$estimate))
      ratio <- 100 * d$estimate / hits$estimate[i]
      out$same_sign[i] <- ok && all(sign(d$estimate) == sign(hits$estimate[i]))
      out$p05[i] <- ok && all(is.finite(d$p_value) & d$p_value < 0.05)
      if (nrow(d)) { out$pct_min[i] <- min(ratio); out$pct_max[i] <- max(ratio) }
    }
    out
  }
  lookup <- function(table, key_table, key, column) table[[column]][match(key, key_table)]
  rows <- list()
  # ---- H1/H3: Primary scale, four planned contrasts (physiological + questionnaire outcomes) ----
  h13 <- h13[grepl('^hypothesis=H[13];', h13$context) & startsWith(h13$scale, 'normalization=Primary'), ]
  h13$hypothesis <- sub('^hypothesis=(H[13]);.*$', '\\1', h13$context)
  pc <- checks[checks$analysis == 'original_phase_contrast' & checks$model_id == 'Primary', ]
  key_pc <- paste(pc$hypothesis, pc$comparison, pc$outcome)
  person <- person[person$Hypothesis %in% c('H1', 'H3') & person$Scale == 'Primary', ]
  key_person <- paste(person$Hypothesis, person$Contrast, person$Outcome)
  families <- data.frame(
    family = c('H1 cycling (BikeG - BikeU)', 'H1 walking (WalkG - WalkU)',
               'H3 urban (WalkU - BikeU)', 'H3 green (WalkG - BikeG)'),
    hypothesis = c('H1', 'H1', 'H3', 'H3'),
    comparison = c('BikeG - BikeU', 'WalkG - WalkU', 'WalkU - BikeU', 'WalkG - BikeG'),
    stringsAsFactors = FALSE)
  for (k in seq_len(nrow(families))) {
    fam <- h13[h13$hypothesis == families$hypothesis[k] & h13$comparison == families$comparison[k], ]
    hits <- fam[is.finite(fam$q_value) & fam$q_value < 0.05, ]
    key <- paste(hits$hypothesis, hits$comparison, hits$outcome)
    alt_p <- function(method) {
      sub <- pc[pc$method == method & pc$omitted_participant == '', ]
      lookup(sub, paste(sub$hypothesis, sub$comparison, sub$outcome), key, 'p_value')
    }
    cr2 <- pc[pc$method == 'CR2_Satterthwaite_phase_contrast' & pc$omitted_participant == '', ]
    cr2_q <- lookup(cr2, paste(cr2$hypothesis, cr2$comparison, cr2$outcome), key, 'q_value')
    boot_low <- lookup(person, key_person, key, 'Bootstrap_Percentile_CI95_Low')
    boot_high <- lookup(person, key_person, key, 'Bootstrap_Percentile_CI95_High')
    alternatives <- cbind(alt_p('lmer_KR'), alt_p('lmer_Satterthwaite'),
      alt_p('CR2_Satterthwaite_phase_contrast'), lookup(person, key_person, key, 'P_Paired_t'),
      lookup(person, key_person, key, 'P_Exact_Signflip'), lookup(person, key_person, key, 'P_Wilcoxon_Approx'))
    all_alt <- apply(alternatives, 1L, function(p) all(is.finite(p) & p < 0.05)) &
      is.finite(boot_low) & is.finite(boot_high) & (boot_low > 0 | boot_high < 0)
    deletions <- pc[pc$method == 'original_nlme_participant_deletion', ]
    loo <- loo_summary(hits, deletions, key, paste(deletions$hypothesis, deletions$comparison, deletions$outcome), 11L)
    rows[[length(rows) + 1L]] <- data.frame(family = families$family[k],
      n_tests = nrow(fam), n_fdr_hits_primary = nrow(hits),
      n_same_sign_all_loo = sum(loo$same_sign), n_p05_all_loo = sum(loo$p05),
      n_p05_all_alternatives = sum(all_alt), n_cr2_q05 = sum(is.finite(cr2_q) & cr2_q < 0.05),
      loo_estimate_pct_min = if (nrow(hits)) min(loo$pct_min) else NA_real_,
      loo_estimate_pct_max = if (nrow(hits)) max(loo$pct_max) else NA_real_,
      alternatives_used = 'Kenward-Roger; Satterthwaite; CR2-Satterthwaite; paired t; exact sign-flip; Wilcoxon (normal approx.); bootstrap CI excludes 0',
      n_cr2_df_below_4 = NA_integer_, stringsAsFactors = FALSE)
  }
  # ---- H5: phase-mean adjusted equations (primary inference CR2-Satterthwaite) ----
  h5$model_id <- as.character(h5$model_id)
  h5c <- checks[checks$hypothesis == 'H5' & checks$analysis == 'original_adjusted_equation', ]
  h5c$model_id <- as.character(h5c$model_id)
  # Robustness rows name the estimated phase terms PhaseSumX; the primary file names them 'Phase: X vs mean of phases'.
  phase_term <- startsWith(h5c$predictor, 'PhaseSum')
  h5c$predictor[phase_term] <- paste0('Phase: ', sub('^PhaseSum', '', h5c$predictor[phase_term]), ' vs mean of phases')
  key_h5c <- paste(h5c$model_id, h5c$outcome, h5c$predictor)
  for (term_type in c('exposure', 'phase')) {
    is_phase <- startsWith(h5$predictor, 'Phase: ')
    fam <- h5[if (term_type == 'phase') is_phase else !is_phase, ]
    hits <- fam[is.finite(fam$q_value) & fam$q_value < 0.05, ]
    key <- paste(hits$model_id, hits$outcome, hits$predictor)
    kr <- h5c$method == 'Kenward_Roger'
    kr_p <- h5c$p_value[kr][match(key, key_h5c[kr])]
    deletion <- h5c$method == 'CR2_Satterthwaite' & h5c$omitted_participant != ''
    loo <- loo_summary(hits, h5c[deletion, ], key, key_h5c[deletion], 11L)
    rows[[length(rows) + 1L]] <- data.frame(
      family = if (term_type == 'phase') 'H5 phase terms (phase vs mean of phases)' else 'H5 exposure terms',
      n_tests = nrow(fam), n_fdr_hits_primary = nrow(hits),
      n_same_sign_all_loo = sum(loo$same_sign), n_p05_all_loo = sum(loo$p05),
      n_p05_all_alternatives = sum(is.finite(kr_p) & kr_p < 0.05), n_cr2_q05 = NA_integer_,
      loo_estimate_pct_min = if (nrow(hits)) min(loo$pct_min) else NA_real_,
      loo_estimate_pct_max = if (nrow(hits)) max(loo$pct_max) else NA_real_,
      alternatives_used = 'Kenward-Roger',
      n_cr2_df_below_4 = sum(is.finite(hits$df) & hits$df < 4), stringsAsFactors = FALSE)
  }
  table <- do.call(rbind, rows)
  table$loo_estimate_pct_min <- round(table$loo_estimate_pct_min, 1)
  table$loo_estimate_pct_max <- round(table$loo_estimate_pct_max, 1)
  path <- file.path(rob, 'Table_robustness_summary.csv')
  write.csv(table, path, row.names = FALSE, na = '')
  message('Wrote ', path)
  invisible(table)
}
paper3_robustness_summary_table(if (exists('PROJECT_ROOT')) PROJECT_ROOT else getwd())

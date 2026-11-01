# H4_Sound_exactliterature.R
# Heat / sound vs physiology using the statistical methods of published physiology studies,
# applied to our data with OUR OWN coefficients (no published coefficients are reused).
# Run once: Rscript scripts/statistical_analysis/H4_Sound_exactliterature.R
# Output: output/statistical_analysis/results/H4_Sound_exactliterature/ (new folder; stops if it exists).
# No other H4 output is read or written. Input: output/merged_all_11participants_8min.csv.
#
# A  Jo H, Song C, Ikei H, Enomoto S, Kobayashi H, Miyazaki Y (2019). Physiological and psychological
#    effects of forest and urban sounds using high-resolution sound sources. Int J Environ Res Public
#    Health 16(15):2649. doi:10.3390/ijerph16152649. Sec 2.6: paired t-tests on each person's average
#    per condition (forest vs city sound), one-sided (nature relaxes), HR raw, ln(HF), ln(LF/HF), p<0.05,
#    no multiplicity correction.
#    Our copy: per-participant phase means, WalkG vs WalkU and BikeG vs BikeU.
# B  Yousefinezhad R, Jamchi N, Amrolahi M, Samaei SE et al. (2026). Impact of thermal-acoustic exposure
#    on human performance of healthy adults. Sci Rep 16:10173. doi:10.1038/s41598-026-41251-6.
#    Four within-subject conditions (control, heat, noise, heat+noise); repeated-measures ANOVA with
#    sphericity check and Greenhouse-Geisser correction; Friedman test when Shapiro-Wilk normality fails;
#    post hoc pairwise Wilcoxon signed-rank tests when the global test is significant (alpha 0.05).
#    Our copy: 10 s epochs classed heat = UTCI > 26 C (UTCI moderate heat stress), noise = LAeq >= 65 dB(A);
#    per-participant condition means; participants need >= 3 epochs in every condition.
# C  Rodrigues AL, da Conceicao MSA, Ramusga RAL, Lima Azevedo C, Morgado P (2026). The influence of urban
#    context on emotions and bodily responses during walking. J Urban Health 103:344-356.
#    doi:10.1007/s11524-025-01051-1. H2: trip-level mean/min/max/SD summaries, predictors standardized,
#    thematic blocks (Noise, Temperature) in SEPARATE linear mixed models with a participant random
#    intercept (statsmodels MixedLM: REML, Wald z p-values); retained if p < 0.05 and |beta| > 0.1.
#    Our copy: trip = participant x phase (44); Noise block = mean, min, max, SD of ucm_SND_dBA;
#    Temperature block = max, mean, min of air temperature ucm_AIR_temp (they used daily air temperature).
# D  Kraus U, Schneider A, Breitner S et al. (2013). Individual daytime noise exposure during routine
#    activities and heart rate variability in adults: a repeated measures study. Environ Health Perspect
#    121(5):607-612. doi:10.1289/ehp.1205606. Additive mixed models, random participant effect
#    (compound symmetry), lagged outcome, log outcomes except HR, HRV adjusted for HR, physical activity
#    and time trends forced in, Leq piecewise linear with cut-off 65 dB(A), effects per 5 dB(A).
#    Our copy: 60 s epochs (8 per phase; their 5-min segments and 0-15 min Leq lags do not fit in 8-min
#    phases, so lagged Leq terms are omitted); Leq = energetic mean of 10 s LAeq.
# E  Group-proposed combined form (not from a single paper): Y ~ UTCI_z * dBA_z + Env + Mode +
#    (1|participant) on participant x phase means.
# FDR: every paper's own p is reported unchanged. q_BH is OUR addition (none of these papers used FDR).

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run with Rscript on this file')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
source(file.path(dirname(.entry), 'library', 'Paper3_common.R'), local = FALSE)
if (!requireNamespace('nlme', quietly = TRUE)) stop('Required package missing: nlme')

root <- resolve_project_root()
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_Sound_exactliterature')
if (dir.exists(outdir)) stop('Output folder already exists; this script is run once: ', outdir)
started <- Sys.time()
outcomes <- paper3_physiological_outcomes()
transforms <- paper3_read_outcome_transforms_csv(outcomes, root)
input <- paper3_merged_8min_path(root)
d <- read.csv(input, check.names = FALSE)
d <- d[d$ParticipantID %in% PAPER3_PARTICIPANTS & d$PhaseID %in% PAPER3_CORE_PHASES, , drop = FALSE]
d$Datetime <- as.POSIXct(d$Datetime, tz = 'UTC')
stopifnot(!anyNA(d$Datetime), !anyDuplicated(d[c('ParticipantID', 'PhaseID', 'Datetime')]))
d <- d[order(d$ParticipantID, d$PhaseID, d$Datetime), ]
available <- tolower(as.character(d$empatica_hrv_fd_5min_available)) %in% c('true', '1')
for (v in attr(outcomes, 'empatica_hrv_fd_window')) d[[v]][!available] <- NA_real_
bout <- interaction(d$ParticipantID, d$PhaseID, drop = TRUE)
stopifnot(length(unique(d$ParticipantID)) == 11L, nlevels(bout) == 44L)
d$Time10 <- as.integer(round((as.numeric(d$Datetime) - ave(as.numeric(d$Datetime), bout, FUN = min)) / 10))
for (o in outcomes) d[[paste0(o, '__tr')]] <- paper3_apply_csv_transform(d[[o]], o, transforms)
d$Env <- ifelse(substr(d$PhaseID, 5, 5) == 'G', 'Green', 'Urban')
d$Mode <- substr(d$PhaseID, 1, 4)
bh <- function(p) { q <- rep(NA_real_, length(p)); ok <- is.finite(p); q[ok] <- p.adjust(p[ok], 'BH'); q }
zg <- function(x) (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
energetic <- function(L) 10 * log10(mean(10^(L / 10), na.rm = TRUE))
fit_lme <- function(fml, data) tryCatch(nlme::lme(fml, data = data, random = ~ 1 | ParticipantID,
  method = 'REML', na.action = na.omit, control = nlme::lmeControl(opt = 'optim')), error = function(e) e)
coef_rows <- function(fit, terms, z_p = FALSE) {
  tt <- summary(fit)$tTable
  do.call(rbind, lapply(terms, function(tm) {
    if (!tm %in% rownames(tt)) return(data.frame(term = tm, beta = NA, se = NA, df = NA, stat = NA, p = NA))
    b <- tt[tm, 'Value']; se <- tt[tm, 'Std.Error']
    p <- if (z_p) 2 * pnorm(-abs(b / se)) else tt[tm, 'p-value']
    data.frame(term = tm, beta = b, se = se, df = tt[tm, 'DF'], stat = b / se, p = p)
  }))
}

# ---- A: Jo et al. 2019 ----
jo_dir <- c(empatica_heart_rate = 'less', empatica_hrv_fd_hf = 'greater', empatica_hrv_fd_lf_hf_ratio = 'less')
pm <- aggregate(d[paste0(outcomes, '__tr')], d[c('ParticipantID', 'PhaseID')], function(x) mean(x, na.rm = TRUE))
A <- do.call(rbind, lapply(c('Walk', 'Bike'), function(m) do.call(rbind, lapply(outcomes, function(o) {
  g <- pm[pm$PhaseID == paste0(m, 'G'), c('ParticipantID', paste0(o, '__tr'))]
  u <- pm[pm$PhaseID == paste0(m, 'U'), c('ParticipantID', paste0(o, '__tr'))]
  x <- merge(g, u, by = 'ParticipantID'); x <- x[is.finite(x[[2]]) & is.finite(x[[3]]), ]
  res <- data.frame(mode = m, contrast = paste0(m, 'G_minus_', m, 'U'), outcome = o,
    transform = transforms$transformation_in_models[match(o, transforms$column_name)], n_pairs = nrow(x),
    mean_green = NA, mean_urban = NA, mean_diff = NA, ci_low = NA, ci_high = NA, t = NA, df = NA,
    p_two_sided = NA, jo_one_sided_direction = if (o %in% names(jo_dir)) paste('Green', ifelse(jo_dir[[o]] == 'less', '<', '>'), 'Urban') else 'not in Jo et al.',
    p_one_sided_Jo = NA)
  if (nrow(x) >= 3) {
    tt <- t.test(x[[2]], x[[3]], paired = TRUE)
    res[c('mean_green', 'mean_urban', 'mean_diff', 'ci_low', 'ci_high', 't', 'df', 'p_two_sided')] <-
      list(mean(x[[2]]), mean(x[[3]]), unname(tt$estimate), tt$conf.int[1], tt$conf.int[2], unname(tt$statistic), unname(tt$parameter), tt$p.value)
    if (o %in% names(jo_dir)) res$p_one_sided_Jo <- t.test(x[[2]], x[[3]], paired = TRUE, alternative = jo_dir[[o]])$p.value
  }
  res
}))))
A$q_BH_two_sided_52 <- bh(A$p_two_sided)
A$q_BH_one_sided_Jo_6 <- bh(A$p_one_sided_Jo)

# ---- B: Yousefinezhad et al. 2026 ----
cond_levels <- c('Control', 'Heat', 'Noise', 'Heat+Noise')
ok <- is.finite(d$ucm_UTCI) & is.finite(d$ucm_SND_dBA)
d$Condition <- NA_character_
d$Condition[ok] <- cond_levels[1 + (d$ucm_UTCI[ok] > 26) + 2 * (d$ucm_SND_dBA[ok] >= 65)]
B_n <- as.data.frame.matrix(table(d$ParticipantID, factor(d$Condition, cond_levels)))
B <- list(); Bp <- list()
for (o in outcomes) {
  y <- d[[paste0(o, '__tr')]]; keep <- is.finite(y) & !is.na(d$Condition)
  cnt <- tapply(y[keep], list(d$ParticipantID[keep], factor(d$Condition[keep], cond_levels)), length)
  mn <- tapply(y[keep], list(d$ParticipantID[keep], factor(d$Condition[keep], cond_levels)), mean)
  full <- rownames(cnt)[apply(cnt, 1, function(r) all(is.finite(r) & r >= 3))]
  Y <- mn[full, , drop = FALSE]; n <- nrow(Y)
  row <- data.frame(outcome = o, transform = transforms$transformation_in_models[match(o, transforms$column_name)],
    n_participants = n, participants = paste(full, collapse = ';'),
    mean_Control = NA, mean_Heat = NA, mean_Noise = NA, mean_HeatNoise = NA,
    shapiro_min_p = NA, mauchly_p = NA, gg_epsilon = NA, F = NA, df1 = NA, df2 = NA,
    p_rmanova = NA, p_rmanova_GG = NA, friedman_chisq = NA, p_friedman = NA, test_used = NA, p_global = NA)
  if (n >= 4) {
    row[c('mean_Control', 'mean_Heat', 'mean_Noise', 'mean_HeatNoise')] <- as.list(colMeans(Y))
    sw <- apply(Y, 2, function(v) if (length(unique(v)) > 2) shapiro.test(v)$p.value else NA)
    row$shapiro_min_p <- min(sw, na.rm = TRUE)
    long <- data.frame(y = as.vector(Y), pid = factor(rep(rownames(Y), 4)), cond = factor(rep(cond_levels, each = n), cond_levels))
    av <- summary(aov(y ~ cond + Error(pid / cond), data = long))[['Error: pid:cond']][[1]]
    Fv <- av[['F value']][1]; df1 <- av[['Df']][1]; df2 <- av[['Df']][2]
    C <- contr.poly(4); S <- cov(Y %*% C); eps <- sum(diag(S))^2 / (3 * sum(S^2))
    mp <- tryCatch(mauchly.test(lm(Y ~ 1), X = ~1)$p.value, error = function(e) NA)
    p_raw <- pf(Fv, df1, df2, lower.tail = FALSE); p_gg <- pf(Fv, df1 * eps, df2 * eps, lower.tail = FALSE)
    fr <- friedman.test(Y)
    normal <- is.finite(row$shapiro_min_p) && row$shapiro_min_p >= 0.05
    use_gg <- is.finite(mp) && mp < 0.05
    row[c('mauchly_p', 'gg_epsilon', 'F', 'df1', 'df2', 'p_rmanova', 'p_rmanova_GG', 'friedman_chisq', 'p_friedman')] <-
      list(mp, eps, Fv, df1, df2, p_raw, p_gg, unname(fr$statistic), fr$p.value)
    row$test_used <- if (normal) (if (use_gg) 'RM-ANOVA (Greenhouse-Geisser)' else 'RM-ANOVA') else 'Friedman'
    row$p_global <- if (normal) (if (use_gg) p_gg else p_raw) else fr$p.value
    pairs <- combn(cond_levels, 2)
    Bp[[o]] <- do.call(rbind, lapply(seq_len(ncol(pairs)), function(k) {
      a <- pairs[1, k]; b <- pairs[2, k]; w <- suppressWarnings(wilcox.test(Y[, b], Y[, a], paired = TRUE, exact = FALSE))
      data.frame(outcome = o, comparison = paste(b, 'vs', a), n_participants = n, median_diff = median(Y[, b] - Y[, a]),
        V = unname(w$statistic), p_wilcoxon = w$p.value, posthoc_reported_by_paper_rule = is.finite(row$p_global) && row$p_global < 0.05)
    }))
  }
  B[[o]] <- row
}
B <- do.call(rbind, B); B$q_BH_global_26 <- bh(B$p_global)
Bp <- do.call(rbind, Bp)

# ---- C: Rodrigues et al. 2026 ----
trip <- do.call(rbind, lapply(split(seq_len(nrow(d)), interaction(d$ParticipantID, d$PhaseID, drop = TRUE)), function(ix) {
  s <- d$ucm_SND_dBA[ix]; t <- d$ucm_AIR_temp[ix]
  out <- data.frame(ParticipantID = d$ParticipantID[ix[1]], PhaseID = d$PhaseID[ix[1]],
    noise_mean = mean(s, na.rm = TRUE), noise_min = min(s, na.rm = TRUE), noise_max = max(s, na.rm = TRUE), noise_sd = sd(s, na.rm = TRUE),
    temp_max = max(t, na.rm = TRUE), temp_mean = mean(t, na.rm = TRUE), temp_min = min(t, na.rm = TRUE),
    utci_mean = mean(d$ucm_UTCI[ix], na.rm = TRUE), dba_mean = mean(s, na.rm = TRUE),
    Env = d$Env[ix[1]], Mode = d$Mode[ix[1]])
  for (o in outcomes) out[[o]] <- mean(d[[paste0(o, '__tr')]][ix], na.rm = TRUE)
  out
}))
for (o in outcomes) trip[[o]][!is.finite(trip[[o]])] <- NA_real_
blocks <- list(Noise = c('noise_mean', 'noise_min', 'noise_max', 'noise_sd'), Temperature = c('temp_max', 'temp_mean', 'temp_min'))
for (v in unlist(blocks)) trip[[paste0(v, '_z')]] <- zg(trip[[v]])
C <- do.call(rbind, lapply(names(blocks), function(bk) do.call(rbind, lapply(outcomes, function(o) {
  tz <- paste0(blocks[[bk]], '_z'); fit <- fit_lme(as.formula(paste(o, '~', paste(tz, collapse = ' + '))), trip)
  if (inherits(fit, 'error')) return(data.frame(block = bk, outcome = o, term = tz, beta = NA, se = NA, df = NA, stat = NA, p = NA, n_obs = NA, note = conditionMessage(fit)))
  cbind(block = bk, outcome = o, coef_rows(fit, tz, z_p = TRUE), n_obs = nobs(fit), note = '')
}))))
C$retained_Rodrigues_rule <- is.finite(C$p) & C$p < 0.05 & abs(C$beta) > 0.1
C$q_BH_26_per_term <- ave(C$p, C$block, C$term, FUN = bh)

# ---- D: Kraus et al. 2013 ----
d$Min <- d$Time10 %/% 6L
ep_keys <- d[c('ParticipantID', 'PhaseID', 'Min')]
ep <- aggregate(d[c(outcomes, 'empatica_vector_magnitude')], ep_keys, function(x) mean(x, na.rm = TRUE))
ep$Leq <- aggregate(d$ucm_SND_dBA, ep_keys, energetic)$x
ep$clock_h <- aggregate(as.numeric(format(d$Datetime, '%H')) + as.numeric(format(d$Datetime, '%M')) / 60, ep_keys, mean)$x
ep$day_index <- aggregate(as.numeric(as.Date(d$Datetime)), ep_keys, mean)$x
ep$day_index <- ep$day_index - min(ep$day_index)
ep <- ep[order(ep$ParticipantID, ep$PhaseID, ep$Min), ]
for (v in c(outcomes, 'empatica_vector_magnitude')) ep[[v]][!is.finite(ep[[v]])] <- NA_real_
ep$L_below65_per5 <- (pmin(ep$Leq, 65) - 65) / 5
ep$L_above65_per5 <- (pmax(ep$Leq, 65) - 65) / 5
ep$HR_cov <- ep$empatica_heart_rate
prev <- function(x) { k <- paste(ep$ParticipantID, ep$PhaseID, ep$Min); x[match(paste(ep$ParticipantID, ep$PhaseID, ep$Min - 1L), k)] }
D <- do.call(rbind, lapply(outcomes, function(o) {
  x <- ep[[o]]; logged <- o != 'empatica_heart_rate' && all(x[is.finite(x)] > 0)
  ep$Yk <- if (logged) log(x) else x; ep$Yk_lag <- prev(ep$Yk)
  rhs <- c('Yk_lag', 'L_below65_per5', 'L_above65_per5', 'empatica_vector_magnitude', 'Min', 'clock_h', 'day_index')
  if (grepl('^empatica_hrv', o)) rhs <- c(rhs, 'HR_cov')
  if (length(unique(ep$day_index[is.finite(ep$Yk)])) < 2) rhs <- setdiff(rhs, 'day_index')
  fit <- fit_lme(as.formula(paste('Yk ~', paste(rhs, collapse = ' + '))), ep)
  terms <- c('L_below65_per5', 'L_above65_per5')
  if (inherits(fit, 'error')) return(data.frame(outcome = o, log_outcome = logged, term = terms, beta = NA, se = NA, df = NA, stat = NA, p = NA, pct_change_per5dB = NA, n_obs = NA, note = conditionMessage(fit)))
  r <- cbind(outcome = o, log_outcome = logged, coef_rows(fit, terms))
  r$pct_change_per5dB <- if (logged) 100 * (exp(r$beta) - 1) else NA
  r$n_obs <- nobs(fit); r$note <- ''; r
}))
D$q_BH_26_per_term <- ave(D$p, D$term, FUN = bh)

# ---- E: group-proposed combined form ----
trip$UTCI_z <- zg(trip$utci_mean); trip$dBA_z <- zg(trip$dba_mean)
trip$Env <- factor(trip$Env, c('Urban', 'Green')); trip$Mode <- factor(trip$Mode, c('Bike', 'Walk'))
E_terms <- c('UTCI_z', 'dBA_z', 'UTCI_z:dBA_z', 'EnvGreen', 'ModeWalk')
E <- do.call(rbind, lapply(outcomes, function(o) {
  fit <- fit_lme(as.formula(paste(o, '~ UTCI_z * dBA_z + Env + Mode')), trip)
  if (inherits(fit, 'error')) return(data.frame(outcome = o, term = E_terms, beta = NA, se = NA, df = NA, stat = NA, p = NA, n_obs = NA, note = conditionMessage(fit)))
  cbind(outcome = o, coef_rows(fit, E_terms), n_obs = nobs(fit), note = '')
}))
E$q_BH_26_per_term <- ave(E$p, E$term, FUN = bh)

# ---- write ----
dir.create(outdir, recursive = TRUE)
w <- function(x, f) write.csv(x, file.path(outdir, f), row.names = FALSE, na = '')
w(A, 'A_Jo2019_paired_ttests.csv')
w(B, 'B_Yousefinezhad2026_RMANOVA.csv'); w(Bp, 'B_Yousefinezhad2026_posthoc_wilcoxon.csv')
w(cbind(ParticipantID = rownames(B_n), B_n), 'B_Yousefinezhad2026_epochs_per_condition.csv')
w(C, 'C_Rodrigues2026_noise_temperature_blocks.csv')
w(D, 'D_Kraus2013_piecewise_65dBA.csv')
w(E, 'E_group_UTCIxdBA_mixed.csv')
cnt <- function(p) sum(is.finite(p) & p < 0.05)
S <- rbind(
  data.frame(analysis = 'A Jo 2019', test = 'Green vs Urban, two-sided (52 tests)', n_tests = sum(is.finite(A$p_two_sided)), n_p_lt_05 = cnt(A$p_two_sided), n_q_lt_05 = cnt(A$q_BH_two_sided_52)),
  data.frame(analysis = 'A Jo 2019', test = 'Jo one-sided HR, ln HF, ln LF/HF (6 tests)', n_tests = sum(is.finite(A$p_one_sided_Jo)), n_p_lt_05 = cnt(A$p_one_sided_Jo), n_q_lt_05 = cnt(A$q_BH_one_sided_Jo_6)),
  data.frame(analysis = 'B Yousefinezhad 2026', test = 'global 4-condition test', n_tests = sum(is.finite(B$p_global)), n_p_lt_05 = cnt(B$p_global), n_q_lt_05 = cnt(B$q_BH_global_26)),
  do.call(rbind, lapply(split(C, paste(C$block, C$term)), function(x) data.frame(analysis = 'C Rodrigues 2026', test = paste(x$block[1], x$term[1]), n_tests = sum(is.finite(x$p)), n_p_lt_05 = cnt(x$p), n_q_lt_05 = cnt(x$q_BH_26_per_term)))),
  do.call(rbind, lapply(split(D, D$term), function(x) data.frame(analysis = 'D Kraus 2013', test = x$term[1], n_tests = sum(is.finite(x$p)), n_p_lt_05 = cnt(x$p), n_q_lt_05 = cnt(x$q_BH_26_per_term)))),
  do.call(rbind, lapply(split(E, E$term), function(x) data.frame(analysis = 'E group form', test = x$term[1], n_tests = sum(is.finite(x$p)), n_p_lt_05 = cnt(x$p), n_q_lt_05 = cnt(x$q_BH_26_per_term)))))
w(S, 'FDR_summary.csv')
md5 <- function(f) unname(tools::md5sum(f))
w(data.frame(started = format(started, '%Y-%m-%d %H:%M:%S %Z'), completed = format(Sys.time(), '%Y-%m-%d %H:%M:%S %Z'),
  script = .entry, script_md5 = md5(.entry), common_md5 = md5(file.path(dirname(.entry), 'library', 'Paper3_common.R')),
  input = input, input_md5 = md5(input), normalization_md5 = md5(paper3_normalization_csv_path(root)),
  R = R.version.string, nlme = as.character(packageVersion('nlme'))), 'run_manifest.csv')
writeLines(c('H4_Sound_exactliterature: published physiology methods applied to our data with our own coefficients.',
  'See the header of scripts/statistical_analysis/H4_Sound_exactliterature.R for each citation and every adaptation.',
  'Outcome transforms: project normalization CSV (ln for HF, LF/HF etc., HR raw, as in Jo et al.), except D (Kraus rule: log all positive outcomes except HR).',
  'Each paper\'s own p is reported unchanged; q_BH columns are our addition (no paper used FDR).',
  'A compares whole green vs urban routes (heat, light, air also differ), so it cannot isolate sound.',
  'B cut points: heat UTCI > 26 C, noise LAeq >= 65 dB(A), on 10 s epochs pooled over phases; >= 3 epochs per condition required.',
  'C uses air temperature (ucm_AIR_temp), as Rodrigues used daily air temperature; p values are Wald z as in statsmodels MixedLM.',
  'D uses 60 s epochs; Leq lags (0-15 min) omitted because phases last 8 min; random intercept = compound symmetry.',
  'E is not from one paper; it is the form proposed in the group discussion.'), file.path(outdir, 'README.txt'))
cat('SUCCESS', format(Sys.time()), outdir, '\n')

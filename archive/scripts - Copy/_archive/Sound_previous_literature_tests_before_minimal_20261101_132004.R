# Sound_previous_literature_tests.R
# One script that applies each previous paper's own statistical test to the Paper 3 field data
# (merged_all_11participants_8min.csv, 11 participants, 4 core phases). Our data, their test approach.
# Each paper's own p is reported as the paper would. q = Benjamini-Hochberg FDR added by us, per test
# family across outcomes (26 outcomes; 5 for Kraus), sound terms only.
#
# 1 Jo et al. 2019: paired one-sided t-tests (green vs urban) on HR, ln HF, ln LF/HF.
# 2 Yousefinezhad et al. 2026: 4 conditions (Control, Heat, Noise, Heat+Noise), RM-ANOVA (Mauchly, GG) or
#   Friedman when not normal, Wilcoxon signed-rank post hoc. Heat = UTCI > 26 C, Noise = dBA >= 65
#   (their WBGT 30.62 C + 75 dBA give no epochs in this data).
# 3 Dehghan et al. 2017: Friedman test across the same 4 conditions.
# 4 Molaeifar et al. 2020: paired t-test, Hot+Loud vs reference Cool+Quiet (same cut-offs).
# 5 Tohidi et al. 2025: two-way ANOVA, air temperature 20/25/30 C x noise 55/65/75/85 dBA (nearest level).
# 6 Abbasi et al. 2020: two-way ANOVA, air temperature 22/26/30 C x noise 55/75 dBA (nearest level).
# 7 Rodrigues et al. 2026: trip-level mixed model, Noise block (mean, max, SD of dBA, z-scored), outcomes
#   trip mean and SD, REML, Wald z; Temperature block fitted separately (reported, not sound).
# 8 Kraus et al. 2013: 60 s epochs, Leq piecewise at 65 dBA per 5 dB, lagged outcome, MET activity,
#   HR adjustment for HRV, log outcomes except HR, trend form and confounders chosen by AIC; outcomes
#   HR, SDNN, LFnu, HFnu, LF/HF.
# Not testable with this data: Li 2025 (hypertension), Chen 2007 (hearing threshold), Bidel 2022 (EMG),
#   Jafari 2021 (cortisol, blood pressure), He 2025 (90 dB), Molaeifar 95 dB levels.
# Output: output/Sound_previous_literature_tests/ (stops if it exists). Includes BH-FDR q for every test (9_FDR_all_tests_p_and_q.csv).
# Run: Rscript scripts/Sound_previous_literature_tests.R  (from the project root)

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run with Rscript on this file')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
.common <- file.path(dirname(.entry), 'statistical_analysis', 'library', 'Paper3_common.R')
source(.common, local = FALSE)
for (pk in c('nlme', 'mgcv')) if (!requireNamespace(pk, quietly = TRUE)) stop('Required package missing: ', pk)
suppressPackageStartupMessages({ library(nlme); library(mgcv) })
root <- resolve_project_root()
outdir <- file.path(root, 'output', 'Sound_previous_literature_tests')
if (dir.exists(outdir)) stop('Output folder already exists: ', outdir)
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

ctl <- nlme::lmeControl(opt = "optim")

# ==== 1 Jo 2019 ====
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

# ==== 2 Yousefinezhad 2026 (and 3 Dehghan 2017 Friedman = p_friedman) ====
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

# ==== 4 Molaeifar 2020 paired t ====
cells <- c('Cool+Quiet', 'Hot+Quiet', 'Cool+Loud', 'Hot+Loud')
ok <- is.finite(d$ucm_UTCI) & is.finite(d$ucm_SND_dBA)
d$cell <- NA_character_; d$cell[ok] <- cells[1 + (d$ucm_UTCI[ok] > 26) + 2 * (d$ucm_SND_dBA[ok] >= 65)]
epochs_per_cell <- as.data.frame.matrix(table(d$ParticipantID, factor(d$cell, cells)))
cellmeans <- function(o) {
  y <- d[[paste0(o, '__tr')]]; k <- is.finite(y) & !is.na(d$cell)
  cnt <- tapply(y[k], list(d$ParticipantID[k], factor(d$cell[k], cells)), length)
  mn <- tapply(y[k], list(d$ParticipantID[k], factor(d$cell[k], cells)), mean)
  full <- rownames(cnt)[apply(cnt, 1, function(r) all(is.finite(r) & r >= 3))]
  mn[full, , drop = FALSE]
}
PT <- do.call(rbind, lapply(outcomes, function(o) {
  Y <- cellmeans(o); n <- nrow(Y)
  r <- data.frame(outcome = o, n_participants = n, mean_HotLoud = NA, mean_CoolQuiet = NA, mean_diff = NA, t = NA, df = NA, p_paired_t = NA)
  if (n >= 3) { tt <- t.test(Y[, 'Hot+Loud'], Y[, 'Cool+Quiet'], paired = TRUE)
    r[c('mean_HotLoud', 'mean_CoolQuiet', 'mean_diff', 't', 'df', 'p_paired_t')] <- list(mean(Y[, 'Hot+Loud']), mean(Y[, 'Cool+Quiet']), unname(tt$estimate), unname(tt$statistic), unname(tt$parameter), tt$p.value) }
  r }))
PT$q_BH_26 <- bh(PT$p_paired_t)

# ==== 5 Tohidi 2025 and 6 Abbasi 2020 two-way ANOVA ====
nearest <- function(x, lv) lv[apply(abs(outer(x, lv, '-')), 1, which.min)]
designs <- list(Tohidi2025 = list(T = c(20, 25, 30), N = c(55, 65, 75, 85)), Abbasi2020 = list(T = c(22, 26, 30), N = c(55, 75)))
ok <- is.finite(d$ucm_AIR_temp) & is.finite(d$ucm_SND_dBA)
R <- list(); CM <- list()
for (nm in names(designs)) {
  lv <- designs[[nm]]; Tl <- rep(NA, nrow(d)); Nl <- rep(NA, nrow(d))
  Tl[ok] <- nearest(d$ucm_AIR_temp[ok], lv$T); Nl[ok] <- nearest(d$ucm_SND_dBA[ok], lv$N)
  for (o in outcomes) {
    y <- d[[paste0(o, '__tr')]]; k <- ok & is.finite(y)
    g <- aggregate(y[k], list(pid = d$ParticipantID[k], Temp = Tl[k], Noise = Nl[k]), function(v) c(m = mean(v), n = length(v)))
    g <- data.frame(g[1:3], y = g$x[, 'm'], n = g$x[, 'n']); g <- g[g$n >= 3, ]
    CM[[paste(nm, o)]] <- cbind(design = nm, outcome = o, g)
    row <- data.frame(design = nm, outcome = o, n_cell_means = nrow(g), n_participants = length(unique(g$pid)),
      n_cells_filled = nrow(unique(g[c('Temp', 'Noise')])), F_Temp = NA, p_Temp = NA, F_Noise = NA, p_Noise = NA, F_TempxNoise = NA, p_TempxNoise = NA)
    if (length(unique(g$Temp)) > 1 && length(unique(g$Noise)) > 1) {
      a <- summary(aov(y ~ factor(Temp) * factor(Noise), data = g))[[1]]; rn <- trimws(rownames(a))
      f <- function(t) c(a[rn == t, 'F value'], a[rn == t, 'Pr(>F)'])
      row[c('F_Temp', 'p_Temp')] <- as.list(f('factor(Temp)')); row[c('F_Noise', 'p_Noise')] <- as.list(f('factor(Noise)'))
      if (any(rn == 'factor(Temp):factor(Noise)')) row[c('F_TempxNoise', 'p_TempxNoise')] <- as.list(f('factor(Temp):factor(Noise)'))
    }
    R[[paste(nm, o)]] <- row
  }
}
AN <- do.call(rbind, R); ANcm <- do.call(rbind, CM); rm(R, CM)
AN$q_Temp_26 <- ave(AN$p_Temp, AN$design, FUN = bh); AN$q_Noise_26 <- ave(AN$p_Noise, AN$design, FUN = bh); AN$q_TempxNoise_26 <- ave(AN$p_TempxNoise, AN$design, FUN = bh)

# ==== 7 Rodrigues 2026 ====
trip <- do.call(rbind, lapply(split(seq_len(nrow(d)), bout), function(ix) {
  s <- d$ucm_SND_dBA[ix]; t <- d$ucm_AIR_temp[ix]
  out <- data.frame(ParticipantID = d$ParticipantID[ix[1]], PhaseID = d$PhaseID[ix[1]],
    noise_mean = mean(s, na.rm = TRUE), noise_max = max(s, na.rm = TRUE), noise_sd = sd(s, na.rm = TRUE),
    temp_mean = mean(t, na.rm = TRUE), temp_max = max(t, na.rm = TRUE), temp_sd = sd(t, na.rm = TRUE))
  for (o in outcomes) { y <- d[[paste0(o, '__tr')]][ix]
    out[[paste0(o, '__mean')]] <- mean(y, na.rm = TRUE); out[[paste0(o, '__sd')]] <- sd(y, na.rm = TRUE) }
  out
}))
for (v in names(trip)[-(1:2)]) trip[[v]][!is.finite(trip[[v]])] <- NA_real_
blocks <- list(Noise = c('noise_mean', 'noise_max', 'noise_sd'), Temperature = c('temp_mean', 'temp_max', 'temp_sd'))
for (v in unlist(blocks)) trip[[paste0(v, '_z')]] <- zg(trip[[v]])
C <- list()
for (bk in names(blocks)) for (st in c('mean', 'sd')) for (o in outcomes) {
  yv <- paste0(o, '__', st); tz <- paste0(blocks[[bk]], '_z')
  fit <- tryCatch(lme(as.formula(paste0('`', yv, '` ~ ', paste(tz, collapse = ' + '))), data = trip,
    random = ~ 1 | ParticipantID, method = 'REML', na.action = na.omit, control = ctl), error = function(e) e)
  if (inherits(fit, 'error')) { C[[length(C) + 1]] <- data.frame(block = bk, outcome_summary = st, outcome = o, term = tz,
    beta = NA, se = NA, z = NA, p = NA, n_obs = NA, note = conditionMessage(fit)); next }
  tt <- summary(fit)$tTable[tz, , drop = FALSE]
  C[[length(C) + 1]] <- data.frame(block = bk, outcome_summary = st, outcome = o, term = tz, beta = tt[, 'Value'],
    se = tt[, 'Std.Error'], z = tt[, 'Value'] / tt[, 'Std.Error'], p = 2 * pnorm(-abs(tt[, 'Value'] / tt[, 'Std.Error'])),
    n_obs = nobs(fit), note = '')
}
C <- do.call(rbind, C); rownames(C) <- NULL
C$retained_Rodrigues_rule <- is.finite(C$p) & C$p < 0.05 & abs(C$beta) > 0.1
C$q_BH_26_per_term <- ave(C$p, C$block, C$outcome_summary, C$term, FUN = bh)

# ==== 8 Kraus 2013 ====
kraus <- c(HR = 'empatica_heart_rate', SDNN = 'empatica_hrv_td_sdnn', LFnu = 'empatica_hrv_fd_lfnu',
  HFnu = 'empatica_hrv_fd_hfnu', LF_HF = 'empatica_hrv_fd_lf_hf_ratio')
d$Min <- d$Time10 %/% 6L
k <- d[c('ParticipantID', 'PhaseID', 'Min')]
ep <- aggregate(d[c(kraus, 'empatica__met', 'ucm_AIR_temp', 'ucm_AIR_RH')], k, function(x) mean(x, na.rm = TRUE))
ep$Leq <- aggregate(d$ucm_SND_dBA, k, energetic)$x
ep$clock_h <- aggregate(as.numeric(format(d$Datetime, '%H')) + as.numeric(format(d$Datetime, '%M')) / 60, k, mean)$x
ep$day_index <- aggregate(as.numeric(as.Date(d$Datetime)), k, mean)$x; ep$day_index <- ep$day_index - min(ep$day_index)
ep <- ep[order(ep$ParticipantID, ep$PhaseID, ep$Min), ]
for (v in names(ep)[-(1:3)]) ep[[v]][!is.finite(ep[[v]])] <- NA_real_
ep$L_below65_per5 <- (pmin(ep$Leq, 65) - 65) / 5; ep$L_above65_per5 <- (pmax(ep$Leq, 65) - 65) / 5
ep$HR_cov <- ep$empatica_heart_rate
key <- paste(ep$ParticipantID, ep$PhaseID, ep$Min); key_prev <- paste(ep$ParticipantID, ep$PhaseID, ep$Min - 1L)
trend_forms <- c('linear', 'poly2', 'poly3', 'poly4', 'pspline')
tr <- function(v, f) switch(f, linear = v, poly2 = sprintf('poly(%s, 2)', v), poly3 = sprintf('poly(%s, 3)', v),
  poly4 = sprintf('poly(%s, 4)', v), pspline = sprintf("s(%s, bs = 'ps', k = 6)", v))
fit_model <- function(rhs, data, method = 'ML') {
  f <- as.formula(paste('Yk ~', paste(rhs, collapse = ' + ')))
  if (any(grepl('^s\\(', rhs))) {
    g <- tryCatch(gamm(f, random = list(ParticipantID = ~ 1), data = data, method = method, control = ctl), error = function(e) e)
    if (inherits(g, 'error')) return(g); g$aic <- AIC(g$lme); g
  } else {
    m <- tryCatch(lme(f, data = data, random = ~ 1 | ParticipantID, method = method, control = ctl), error = function(e) e)
    if (inherits(m, 'error')) return(m); list(lme = m, gam = NULL, aic = AIC(m))
  }
}
aicv <- function(m) if (inherits(m, 'error')) Inf else m$aic
D <- list(); sel <- list()
for (nm in names(kraus)) {
  o <- kraus[[nm]]; x <- ep[[o]]; logged <- nm != 'HR'
  dd <- ep; dd$Yk <- if (logged) log(x) else x; dd$Yk[!is.finite(dd$Yk)] <- NA; dd$Yk_lag <- dd$Yk[match(key_prev, key)]
  base <- c('Yk_lag', 'L_below65_per5', 'L_above65_per5', 'empatica__met', if (nm != 'HR') 'HR_cov')
  trendv <- c('clock_h', if (length(unique(dd$day_index[is.finite(dd$Yk)])) >= 2) 'day_index')
  cand <- c('ucm_AIR_temp', 'ucm_AIR_RH')
  dd <- dd[complete.cases(dd[c('Yk', base, trendv, cand)]), ]   # one sample for all AIC comparisons
  form <- setNames(rep('linear', length(trendv)), trendv)
  for (v in trendv) { a <- sapply(trend_forms, function(f) { ff <- form; ff[v] <- f
    aicv(fit_model(c(base, mapply(tr, names(ff), ff)), dd)) }); form[v] <- names(which.min(a)) }
  conf <- character(0); best <- aicv(fit_model(c(base, mapply(tr, names(form), form)), dd))
  repeat { a <- sapply(setdiff(cand, conf), function(cv) aicv(fit_model(c(base, mapply(tr, names(form), form), conf, cv), dd)))
    if (!length(a) || min(a) >= best) break; conf <- c(conf, names(which.min(a))); best <- min(a) }
  rhs <- c(base, mapply(tr, names(form), form), conf)
  fm <- fit_model(rhs, dd, method = if (any(form == 'pspline')) 'REML' else 'REML')
  sel[[nm]] <- data.frame(outcome = o, label = nm, trend_forms = paste(names(form), form, sep = '=', collapse = '; '),
    confounders_kept_by_AIC = paste(conf, collapse = '; '), formula = paste('Yk ~', paste(rhs, collapse = ' + ')), n_obs = nrow(dd))
  terms <- c('L_below65_per5', 'L_above65_per5')
  if (inherits(fm, 'error')) { D[[nm]] <- data.frame(outcome = o, label = nm, log_outcome = logged, term = terms, beta = NA, se = NA, df = NA, t = NA, p = NA, pct_change_per5dB = NA, n_obs = nrow(dd), note = conditionMessage(fm)); next }
  tt <- summary(fm$lme)$tTable
  rn <- sapply(terms, function(t) grep(paste0('(^|\\.)', t, '$'), rownames(tt), value = TRUE)[1])
  D[[nm]] <- data.frame(outcome = o, label = nm, log_outcome = logged, term = terms, beta = tt[rn, 'Value'], se = tt[rn, 'Std.Error'],
    df = tt[rn, 'DF'], t = tt[rn, 't-value'], p = tt[rn, 'p-value'],
    pct_change_per5dB = if (logged) 100 * (exp(tt[rn, 'Value']) - 1) else NA, n_obs = nrow(dd), note = '')
}
D <- do.call(rbind, D); rownames(D) <- NULL; sel <- do.call(rbind, sel)
D$q_BH_5_per_term <- ave(D$p, D$term, FUN = bh)

# ==== 9 FDR (Benjamini-Hochberg) ====
# BH-FDR within each test family: one family = one paper's test over its set of outcomes.
Bp$q_BH_26_per_comparison <- ave(Bp$p_wilcoxon, Bp$comparison, FUN = bh)
B$q_friedman_26 <- bh(B$p_friedman)
fam <- function(paper, test, outcome, est, p, q) data.frame(paper = paper, test = test, outcome = outcome, estimate = est, p = p, q_BH = q,
  sig_p05 = is.finite(p) & p < 0.05, survives_FDR_q05 = is.finite(q) & q < 0.05)
FDR <- rbind(
  fam('Jo 2019', 'paired one-sided t', paste(A$mode, A$outcome), NA, A$p_one_sided_Jo, A$q_BH_one_sided_Jo_6),
  fam('Yousefinezhad 2026', 'global 4-condition test', B$outcome, NA, B$p_global, B$q_BH_global_26),
  fam('Yousefinezhad 2026', paste('Wilcoxon', Bp$comparison), Bp$outcome, NA, Bp$p_wilcoxon, Bp$q_BH_26_per_comparison),
  fam('Dehghan 2017', 'Friedman 4 conditions', B$outcome, NA, B$p_friedman, B$q_friedman_26),
  fam('Molaeifar 2020', 'paired t Hot+Loud vs Cool+Quiet', PT$outcome, PT$mean_diff, PT$p_paired_t, PT$q_BH_26),
  fam(AN$design, 'two-way ANOVA temperature main effect', AN$outcome, AN$F_Temp, AN$p_Temp, AN$q_Temp_26),
  fam(AN$design, 'two-way ANOVA noise main effect', AN$outcome, AN$F_Noise, AN$p_Noise, AN$q_Noise_26),
  fam(AN$design, 'two-way ANOVA temperature x noise', AN$outcome, AN$F_TempxNoise, AN$p_TempxNoise, AN$q_TempxNoise_26),
  fam('Rodrigues 2026', paste(C$block, 'block trip', C$outcome_summary, C$term), C$outcome, C$beta, C$p, C$q_BH_26_per_term),
  fam('Kraus 2013', D$term, D$label, D$beta, D$p, D$q_BH_5_per_term))
rownames(FDR) <- NULL

# ==== write ====
dir.create(outdir, recursive = TRUE)
w <- function(x, f) write.csv(x, file.path(outdir, f), row.names = FALSE, na = '')
w(A, '1_Jo2019_paired_ttests.csv')
w(B, '2_Yousefinezhad2026_RMANOVA_Friedman.csv'); w(Bp, '2_Yousefinezhad2026_posthoc_wilcoxon.csv')
w(cbind(ParticipantID = rownames(B_n), B_n), '2_Yousefinezhad2026_epochs_per_condition.csv')
w(PT, '4_Molaeifar2020_paired_t_HotLoud_vs_CoolQuiet.csv')
w(AN, '5_6_Tohidi2025_Abbasi2020_twoway_ANOVA.csv'); w(ANcm, '5_6_cell_means.csv')
w(C, '7_Rodrigues2026_mixed_model.csv'); w(D, '8_Kraus2013_mixed_model.csv'); w(sel, '8_Kraus2013_AIC_selection.csv')
row <- function(paper, test, p, q, o) { k <- is.finite(p)
  data.frame(paper = paper, sound_test = test, n_tests = sum(k), n_p_lt_05 = sum(k & p < 0.05), n_q_lt_05 = sum(k & is.finite(q) & q < 0.05),
    significant_p = paste(o[k & p < 0.05], collapse = '; '), surviving_FDR = paste(o[k & is.finite(q) & q < 0.05], collapse = '; ')) }
Cn <- C[C$block == 'Noise', ]
S <- rbind(
  row('Jo 2019', 'paired one-sided t (green vs urban)', A$p_one_sided_Jo, A$q_BH_one_sided_Jo_6, paste(A$mode, A$outcome)),
  row('Yousefinezhad 2026', 'global 4-condition test', B$p_global, B$q_BH_global_26, B$outcome),
  do.call(rbind, lapply(unique(Bp$comparison), function(cm) { x <- Bp[Bp$comparison == cm, ]; row('Yousefinezhad 2026', paste('Wilcoxon', cm), x$p_wilcoxon, x$q_BH_26_per_comparison, x$outcome) })),
  row('Dehghan 2017', 'Friedman 4 conditions', B$p_friedman, B$q_friedman_26, B$outcome),
  row('Molaeifar 2020', 'paired t Hot+Loud vs Cool+Quiet', PT$p_paired_t, PT$q_BH_26, PT$outcome),
  do.call(rbind, lapply(unique(AN$design), function(ds) { x <- AN[AN$design == ds, ]; rbind(
    row(ds, 'two-way ANOVA noise main effect', x$p_Noise, x$q_Noise_26, x$outcome),
    row(ds, 'two-way ANOVA temperature x noise', x$p_TempxNoise, x$q_TempxNoise_26, x$outcome)) })),
  do.call(rbind, lapply(split(Cn, paste(Cn$outcome_summary, Cn$term)), function(x) row('Rodrigues 2026', paste('trip', x$outcome_summary[1], x$term[1]), x$p, x$q_BH_26_per_term, x$outcome))),
  do.call(rbind, lapply(split(D, D$term), function(x) row('Kraus 2013', x$term[1], x$p, x$q_BH_5_per_term, x$label))))
w(S, 'SUMMARY_sound_tests_p_and_FDR.csv'); w(FDR, '9_FDR_all_tests_p_and_q.csv')
md5 <- function(f) unname(tools::md5sum(f))
w(data.frame(started = format(started), completed = format(Sys.time()), script = .entry, script_md5 = md5(.entry),
  common_md5 = md5(.common), input = input, input_md5 = md5(input), R = R.version.string,
  nlme = as.character(packageVersion('nlme')), mgcv = as.character(packageVersion('mgcv'))), 'run_manifest.csv')
cat('SUCCESS', format(Sys.time()), outdir, '\n')

# H4_Sound_exactliterature_C_tempadj.R
# Follow-up to H4_Sound_exactliterature.R, analysis C only. Rodrigues et al. (2026, J Urban Health,
# doi:10.1007/s11524-025-01051-1, Methods) state that daily maximum and minimum temperature and precipitation
# 'were included as covariates to account for weather effects'. Here the Noise block is refitted with the
# phase's max and min air temperature (ucm_AIR_temp, z-scored) as covariates. Precipitation: not measured,
# omitted. Output: output/statistical_analysis/results/H4_Sound_exactliterature_C_tempadj/ (new; stops if it exists).
# The header below is copied from the parent script for the shared citations.
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
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_Sound_exactliterature_C_tempadj')
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
blocks <- list(Noise = c('noise_mean', 'noise_min', 'noise_max', 'noise_sd'))
for (v in c('temp_max', 'temp_min')) trip[[paste0(v, '_z')]] <- zg(trip[[v]])
for (v in unlist(blocks)) trip[[paste0(v, '_z')]] <- zg(trip[[v]])
C <- do.call(rbind, lapply(names(blocks), function(bk) do.call(rbind, lapply(outcomes, function(o) {
  tz <- paste0(blocks[[bk]], '_z'); cov <- if (bk == 'Noise') c('temp_max_z', 'temp_min_z') else character(0)
  fit <- fit_lme(as.formula(paste(o, '~', paste(c(tz, cov), collapse = ' + '))), trip)
  if (inherits(fit, 'error')) return(data.frame(block = bk, outcome = o, term = tz, beta = NA, se = NA, df = NA, stat = NA, p = NA, n_obs = NA, note = conditionMessage(fit)))
  cbind(block = bk, outcome = o, coef_rows(fit, tz, z_p = TRUE), n_obs = nobs(fit), note = '')
}))))
C$retained_Rodrigues_rule <- is.finite(C$p) & C$p < 0.05 & abs(C$beta) > 0.1
C$q_BH_26_per_term <- ave(C$p, C$block, C$term, FUN = bh)


dir.create(outdir, recursive = TRUE)
C$covariates <- 'temp_max_z + temp_min_z'
write.csv(C, file.path(outdir, 'C_Rodrigues2026_noise_block_tempadj.csv'), row.names = FALSE, na = '')
cnt <- function(p) sum(is.finite(p) & p < 0.05)
S <- do.call(rbind, lapply(split(C, C$term), function(x) data.frame(analysis = 'C Rodrigues 2026, Noise block + temp max/min covariates', term = x$term[1], n_tests = sum(is.finite(x$p)), n_p_lt_05 = cnt(x$p), n_q_lt_05 = cnt(x$q_BH_26_per_term), n_retained_Rodrigues_rule = sum(x$retained_Rodrigues_rule))))
write.csv(S, file.path(outdir, 'FDR_summary_C_tempadj.csv'), row.names = FALSE, na = '')
md5 <- function(f) unname(tools::md5sum(f))
write.csv(data.frame(started = format(started, '%Y-%m-%d %H:%M:%S %Z'), completed = format(Sys.time(), '%Y-%m-%d %H:%M:%S %Z'),
  script = .entry, script_md5 = md5(.entry), common_md5 = md5(file.path(dirname(.entry), 'library', 'Paper3_common.R')),
  input = input, input_md5 = md5(input), normalization_md5 = md5(paper3_normalization_csv_path(root)),
  R = R.version.string, nlme = as.character(packageVersion('nlme'))), file.path(outdir, 'run_manifest.csv'), row.names = FALSE)
cat('SUCCESS', format(Sys.time()), outdir, '\n')

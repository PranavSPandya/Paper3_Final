# H4_sound_literature_helpers.R - static function lists for H4_sound_literature_test.R
# v3 (2026-11-03): every sound-dependent block also accepts one of the 23 alternative sound descriptors of
# test_H4_othersound.R in place of ucm_SND_dBA (argument `sound`; see H4_SOUND).
# v4 (2026-11-03): Moshammer on preceding 5-min Leq and outcome in remainder of 8-min bout (15-min paper
# periods not feasible per bout); Kraus on 5-min intervals, Leq lag 0 only (lags 5-10 / 10-15 min not
# feasible in 8 min); lagged outcome omitted when no prior 5-min interval exists within the bout.
# Exact-method rewrite (2026-11-03). Each paper block is one list of static functions
# (H4_MOSHAMMER, H4_JIN, H4_SONG, H4_RODRIGUES, H4_KRAUS); H4_UTIL and H4_REPORT are shared.
# Every block fits the source paper's own model on raw outcomes unless the paper itself transformed
# them. Data limitations are recorded in METHODS_NOTES.md by H4_REPORT$methods_notes().

# --- Shared utilities --------------------------------------------------------------------------
# Sound variables: ucm_SND_dBA is the primary exposure; the alternatives are the category and spectral
# columns of test_H4_othersound.R (SOUND_CATEGORY_COLUMNS, SOUND_SPECTRAL_COLUMNS), as named in the merged CSV.
H4_SOUND <- list(
  primary = list(column = 'ucm_SND_dBA', is_db = TRUE, family = 'sound_level_reference'),
  category = c('wind_proportion', 'rural_natural_proportion', 'vehicle_proportion', 'urban_manmade_neutral_proportion',
    'urban_manmade_positive_proportion', 'urban_manmade_negative_proportion', 'mechanisms_proportion', 'unidentify_proportion'),
  spectral = c('dominant_frequency_Hz', 'spectral_centroid_Hz', 'spectral_rolloff85_Hz', 'freq_proportion_20_to_200Hz',
    'freq_proportion_200_to_2000Hz', 'freq_proportion_2000_to_20000Hz', 'octave_proportion_31_5_Hz', 'octave_proportion_63_0_Hz',
    'octave_proportion_125_0_Hz', 'octave_proportion_250_0_Hz', 'octave_proportion_500_0_Hz', 'octave_proportion_1000_0_Hz',
    'octave_proportion_2000_0_Hz', 'octave_proportion_4000_0_Hz', 'octave_proportion_8000_0_Hz'),
  alternatives = function(available_columns) {
    out <- list()
    for (family in c('category', 'spectral')) for (column in intersect(H4_SOUND[[family]], available_columns))
      out[[column]] <- list(column = column, is_db = FALSE, family = paste0('sound_', family, if (family == 'category') '_proportion' else '_descriptor'))
    out}
)

H4_UTIL <- list(
  # dB levels are averaged on the energy scale; other descriptors arithmetically (as test_H4_othersound.R).
  sound_mean = function(x, is_db) if (is_db) H4_UTIL$energy_mean_db(x) else H4_UTIL$finite_mean(x),
  bh = function(p) {
    q <- rep(NA_real_, length(p)); finite_p <- is.finite(p)
    q[finite_p] <- p.adjust(p[finite_p], 'BH')
    q},
  energy_mean_db = function(level_db) {
    level_db <- level_db[is.finite(level_db)]
    if (!length(level_db)) return(NA_real_)
    10 * log10(mean(10^(level_db / 10)))},
  finite_mean = function(x) { x <- x[is.finite(x)]; if (length(x)) mean(x) else NA_real_ },
  finite_sd = function(x) { x <- x[is.finite(x)]; if (length(x) > 1) sd(x) else NA_real_ },
  finite_max = function(x) { x <- x[is.finite(x)]; if (length(x)) max(x) else NA_real_ },
  finite_min = function(x) { x <- x[is.finite(x)]; if (length(x)) min(x) else NA_real_ },
  first_finite = function(x) { x <- suppressWarnings(as.numeric(x)); x <- x[is.finite(x)]; if (length(x)) x[1] else NA_real_ },
  parse_utc = function(x) {
    x <- as.character(x); x[!nzchar(x) | is.na(x)] <- NA_character_
    as.POSIXct(x, tz = 'UTC', format = '%Y-%m-%d %H:%M:%S')},
  bouts = function(epochs) split(seq_len(nrow(epochs)), interaction(epochs$ParticipantID, epochs$PhaseID, drop = TRUE)),
  lme_fixed_rows = function(fit, terms) {
    tt <- summary(fit)$tTable
    rows <- lapply(terms, function(term_name) {
      if (!term_name %in% rownames(tt)) return(c(beta = NA, se = NA, df = NA, t = NA, p_t = NA))
      c(beta = tt[term_name, 'Value'], se = tt[term_name, 'Std.Error'], df = tt[term_name, 'DF'],
        t = tt[term_name, 't-value'], p_t = tt[term_name, 'p-value'])})
    out <- as.data.frame(do.call(rbind, rows)); out$term <- terms; out}
)

# --- Moshammer et al. (2019): random-effects GLS (Stata xtreg, re; default Swamy-Arora) ---------
# Paper: "Cardiovascular markers were assessed every 15 min separately and applied to a random effects
# GLS regression. Exposures in the preceding 15 min (noise and dust) served as independent variables.
# The temperature was included in the models as a confounder." Table A2: "Unadjusted effect estimates
# (p-value): change in cardiovascular parameters per ... dB". Appendix: "Controlling for temperature ...
# For consistency reasons, only unadjusted results are shown."
H4_MOSHAMMER <- list(
  outcomes = c(
    RR_distance_ms = 'derived_rr_ms', SDNN_ms = 'empatica_hrv_td_sdnn', RMSSD_ms = 'empatica_hrv_td_rmssd',
    VLF_power = 'empatica_hrv_fd_vlf', LF_power = 'empatica_hrv_fd_lf', HF_power = 'empatica_hrv_fd_hf'),
  # Paper: 15-min periods with noise from the preceding 15 min. An 8-min bout cannot contain two full
  # 15-min windows; we use the first 5 min for exposure and the remainder (5-8 min) for outcomes.
  exposure_seconds = 300,
  phase_sets = list('all phases' = c('BikeG', 'BikeU', 'WalkG', 'WalkU'), 'walking phases (paper setting)' = c('WalkG', 'WalkU')),
  specs = list(
    'Table A2 unadjusted (noise only)' = 'noise_leq_prev_db',
    'Methods: temperature as confounder' = c('noise_leq_prev_db', 'air_temp_c')),
  # Outcome in the post-exposure window regressed on the energy-mean Leq of the first 5 min and, in the
  # adjusted model, mean air temperature in the outcome window. Each window needs >= 2/3 valid 10-s rows.
  period_frame = function(epochs, sound = H4_SOUND$primary) {
    epochs$derived_rr_ms <- ifelse(is.finite(epochs$empatica_heart_rate) & epochs$empatica_heart_rate > 0, 60000 / epochs$empatica_heart_rate, NA_real_)
    exp_sec <- H4_MOSHAMMER$exposure_seconds
    exp_need <- (2 / 3) * (exp_sec / 10)
    do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      b <- epochs[rows, ]
      secs <- as.numeric(difftime(b$Datetime, min(b$Datetime), units = 'secs'))
      exp_r <- secs < exp_sec; out_r <- secs >= exp_sec
      if (!any(out_r)) return(NULL)
      out_need <- (2 / 3) * sum(out_r)
      dba_exp <- b[[sound$column]][exp_r]
      noise_leq_prev_db <- if (sum(is.finite(dba_exp)) >= exp_need) H4_UTIL$sound_mean(dba_exp, sound$is_db) else NA_real_
      out <- data.frame(ParticipantID = b$ParticipantID[1], PhaseID = b$PhaseID[1],
        noise_leq_prev_db = noise_leq_prev_db, air_temp_c = H4_UTIL$finite_mean(b$ucm_AIR_temp[out_r]))
      for (column_name in unique(H4_MOSHAMMER$outcomes)) {
        v <- b[[column_name]][out_r]
        out[[column_name]] <- if (sum(is.finite(v)) >= out_need) H4_UTIL$finite_mean(v) else NA_real_}
      out}))},
  # Stata [XT] xtreg Methods and formulas, xtreg re (default sigma_u estimator):
  # sigma_e^2 = SSR_within / (N - n - K + 1); sigma_u^2 = max{0, SSR_b/(n - K) - sigma_e^2 / T_harmonic};
  # theta_i = 1 - sqrt(sigma_e^2 / (T_i sigma_u^2 + sigma_e^2)); OLS of y* on x* and (1 - theta_i);
  # conventional VCE; z statistics with normal p values. K counts columns of X including the constant.
  xtreg_re = function(y, X, id) {
    keep <- is.finite(y) & apply(X, 1, function(r) all(is.finite(r)))
    y <- y[keep]; X <- X[keep, , drop = FALSE]; id <- as.character(id[keep])
    N <- length(y); groups <- unique(id); n <- length(groups); K <- ncol(X) + 1L
    Ti <- as.numeric(table(id)[id]); group_mean <- function(v) ave(v, id, FUN = mean)
    if (N < K + 2 || n <= K) return(NULL)
    yw <- y - group_mean(y) + mean(y); Xw <- X - apply(X, 2, group_mean) + matrix(colMeans(X), N, ncol(X), byrow = TRUE)
    within_fit <- lm.fit(cbind(1, Xw), yw)
    if (within_fit$rank < K) return(NULL)
    sigma_e2 <- sum(within_fit$residuals^2) / (N - n - K + 1)
    yb <- tapply(y, id, mean)[groups]; Xb <- apply(X, 2, function(v) tapply(v, id, mean)[groups])
    if (is.null(dim(Xb))) Xb <- matrix(Xb, ncol = ncol(X))
    between_fit <- lm.fit(cbind(1, Xb), yb)
    T_harmonic <- n / sum(1 / as.numeric(table(id)))
    sigma_u2 <- max(0, sum(between_fit$residuals^2) / (n - K) - sigma_e2 / T_harmonic)
    theta <- 1 - sqrt(sigma_e2 / (Ti * sigma_u2 + sigma_e2))
    ys <- y - theta * group_mean(y); Xs <- cbind(`(Intercept)` = 1 - theta, X - theta * apply(X, 2, group_mean))
    gls_fit <- lm.fit(Xs, ys)
    s2 <- sum(gls_fit$residuals^2) / (N - K)
    vcov <- s2 * solve(crossprod(Xs))
    beta <- gls_fit$coefficients; se <- sqrt(diag(vcov)); z <- beta / se
    data.frame(term = colnames(Xs), beta = beta, se = se, z = z, p = 2 * pnorm(-abs(z)),
      ci_low = beta - qnorm(0.975) * se, ci_high = beta + qnorm(0.975) * se,
      n_obs = N, n_participants = n, sigma_u = sqrt(sigma_u2), sigma_e = sqrt(sigma_e2),
      theta_min = min(theta), theta_max = max(theta), row.names = NULL)},
  run = function(epochs, sound = H4_SOUND$primary) {
    frame <- H4_MOSHAMMER$period_frame(epochs, sound)
    unit <- if (sound$is_db) 'per 1 dB(A)' else paste('per 1 unit of', sound$column)
    rows <- list()
    for (set_label in names(H4_MOSHAMMER$phase_sets)) for (outcome_label in names(H4_MOSHAMMER$outcomes)) for (spec_label in names(H4_MOSHAMMER$specs)) {
      d <- frame[frame$PhaseID %in% H4_MOSHAMMER$phase_sets[[set_label]], ]
      column_name <- H4_MOSHAMMER$outcomes[[outcome_label]]; regressors <- H4_MOSHAMMER$specs[[spec_label]]
      fit <- H4_MOSHAMMER$xtreg_re(d[[column_name]], as.matrix(d[regressors]), d$ParticipantID)
      noise_row <- if (is.null(fit)) NULL else fit[fit$term == 'noise_leq_prev_db', ]
      rows[[length(rows) + 1L]] <- data.frame(
        paper = 'Moshammer 2019', test = paste0('random-effects GLS ', if (sound$is_db) 'per dB, preceding 5-min Leq, outcome 5-8 min, ' else 'per unit, preceding 5-min mean, outcome 5-8 min, ', set_label, ', ', spec_label), outcome = outcome_label,
        source_column = column_name, term = paste('sound of the first 5 min (preceding exposure window)', unit),
        estimate = if (is.null(fit)) NA else noise_row$beta, se = if (is.null(fit)) NA else noise_row$se,
        ci_low = if (is.null(fit)) NA else noise_row$ci_low, ci_high = if (is.null(fit)) NA else noise_row$ci_high,
        statistic = if (is.null(fit)) NA else noise_row$z, df = NA,
        p = if (is.null(fit)) NA else noise_row$p,
        n_observations = if (is.null(fit)) NA else noise_row$n_obs, n_participants = if (is.null(fit)) NA else noise_row$n_participants,
        statistic_test = 'Wald z-test (random-effects GLS, Stata xtreg re formulas)',
        paper_rule = 'p < 0.05 (Table A2 bold)', paper_rule_met = if (is.null(fit)) NA else noise_row$p < 0.05,
        transformation = 'raw (no transformation)', term_units = unit,
        model_id = paste(column_name, '[5-8 min outcome] ~', paste(regressors, collapse = ' + '), '| xtreg re by ParticipantID'),
        model_details = if (is.null(fit)) 'not estimable' else sprintf('one row per phase: exposure=first 5 min, outcome=remainder of 8-min bout; n=%d; sigma_u=%.6g; sigma_e=%.6g; theta=%.4f-%.4f; 15-min paper periods not feasible in 8 min',
          noise_row$n_obs, noise_row$sigma_u, noise_row$sigma_e, noise_row$theta_min, noise_row$theta_max))}
    list(results = do.call(rbind, rows), frame = frame)}
)

# --- Jin, Jin & Kang (2020): two-way ANOVA LAeq level x UTCI stress category ---------------------
# Paper: LAeq "divided into four levels by a unit of 5 dB: 55~60 dB(A), 60~65 dB(A), 65~70 dB(A), and
# 70~75 dB(A)"; UTCI "divided into four levels corresponding to four different stress categories"
# (Table 3/4; summer: no thermal stress, moderate, strong, very strong heat stress); "The analysis of
# variance (ANOVA) ... main effect ... and ... interaction of UTCI and LAeq", analysed by season.
H4_JIN <- list(
  laeq_breaks = c(55, 60, 65, 70, 75),
  laeq_labels = c('55-60 dB(A)', '60-65 dB(A)', '65-70 dB(A)', '70-75 dB(A)'),
  utci_breaks = c(9, 26, 32, 38, 46),
  utci_labels = c('No thermal stress (9-26 C)', 'Moderate heat stress (26-32 C)', 'Strong heat stress (32-38 C)', 'Very strong heat stress (38-46 C)'),
  outcomes = c(TCV_thermal_comfort = 'questionnaire_thermal_comfort_1_5', OCV_overall_comfort = 'questionnaire_current_comfort_1_7'),
  cell_frame = function(epochs, sound = H4_SOUND$primary) {
    cells <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      out <- data.frame(ParticipantID = epochs$ParticipantID[rows[1]], PhaseID = epochs$PhaseID[rows[1]],
        laeq_db = H4_UTIL$sound_mean(epochs[[sound$column]][rows], sound$is_db), utci_c = H4_UTIL$finite_mean(epochs$ucm_UTCI[rows]))
      for (column_name in H4_JIN$outcomes) out[[column_name]] <- H4_UTIL$first_finite(epochs[[column_name]][rows])
      out$utci_category <- cut(out$utci_c, H4_JIN$utci_breaks, H4_JIN$utci_labels, right = FALSE)
      out}))
    # dBA: the paper's 5-dB LAeq levels. Other descriptors have no paper bins: quartiles of the 44 phase means (Q1-Q4).
    cells$laeq_level <- if (sound$is_db) cut(cells$laeq_db, H4_JIN$laeq_breaks, H4_JIN$laeq_labels, right = FALSE) else {
      br <- unique(quantile(cells$laeq_db, c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE))
      if (length(br) < 3) factor(rep(NA, nrow(cells))) else cut(cells$laeq_db, br, paste0('Q', seq_len(length(br) - 1)), include.lowest = TRUE)}
    cells},
  # Two-way ANOVA by model comparison. The paper does not state its SS type. With empty cells (here
  # several LAeq x UTCI combinations) Type III marginal hypotheses are not uniquely defined, so main
  # effects are tested Type II (each adjusted for the other main effect) and the interaction against the
  # additive model (identical under Type II and Type III).
  anova_type2 = function(y, a, b) {
    a <- droplevels(a); b <- droplevels(b)
    labels <- c('LAeq level', 'UTCI category', 'LAeq x UTCI')
    if (nlevels(a) < 2 || nlevels(b) < 2) return(NULL)
    rss <- function(X) { q <- qr(X); list(rss = sum(qr.resid(q, y)^2), rank = q$rank) }
    full <- rss(model.matrix(~ a * b)); additive <- rss(model.matrix(~ a + b))
    only_b <- rss(model.matrix(~ b)); only_a <- rss(model.matrix(~ a))
    df_res_full <- length(y) - full$rank; df_res_add <- length(y) - additive$rank
    one <- function(label, reduced, larger, df_res) {
      df_term <- larger$rank - reduced$rank
      if (df_term < 1 || df_res < 1) return(data.frame(effect = label, df_term = df_term, df_resid = df_res, F = NA, p = NA))
      F_value <- ((reduced$rss - larger$rss) / df_term) / (larger$rss / df_res)
      data.frame(effect = label, df_term = df_term, df_resid = df_res, F = F_value, p = pf(F_value, df_term, df_res, lower.tail = FALSE))}
    rbind(one(labels[1], only_b, additive, df_res_add), one(labels[2], only_a, additive, df_res_add),
      one(labels[3], additive, full, df_res_full))},
  run = function(epochs, sound = H4_SOUND$primary) {
    cells <- H4_JIN$cell_frame(epochs, sound)
    counts <- as.data.frame(table(laeq_level = cells$laeq_level, utci_category = cells$utci_category, useNA = 'no'))
    names(counts)[3] <- 'n_phase_cells'
    rows <- list()
    for (outcome_label in names(H4_JIN$outcomes)) {
      column_name <- H4_JIN$outcomes[[outcome_label]]
      use <- is.finite(cells[[column_name]]) & !is.na(cells$laeq_level) & !is.na(cells$utci_category)
      d <- cells[use, ]
      observed <- table(droplevels(d$laeq_level), droplevels(d$utci_category))
      empty_cells <- sum(observed == 0); small_cells <- sum(observed > 0 & observed < 3)
      tab <- H4_JIN$anova_type2(d[[column_name]], d$laeq_level, d$utci_category)
      note <- sprintf(paste0('%d of 44 phase cells inside the ', if (sound$is_db) 'paper LAeq/UTCI ranges' else 'UTCI ranges (sound level = quartile of phase means)', '; %d observed LAeq levels x %d UTCI categories; %d empty and %d cells with n<3 among observed levels'),
        nrow(d), nlevels(droplevels(d$laeq_level)), nlevels(droplevels(d$utci_category)), empty_cells, small_cells)
      if (is.null(tab)) tab <- data.frame(effect = c('LAeq level', 'UTCI category', 'LAeq x UTCI'), df_term = NA, df_resid = NA, F = NA, p = NA)
      for (k in seq_len(nrow(tab))) rows[[length(rows) + 1L]] <- data.frame(
        paper = 'Jin 2020', test = paste('two-way ANOVA,', tab$effect[k]), outcome = outcome_label,
        source_column = column_name, term = tab$effect[k], estimate = NA, se = NA, ci_low = NA, ci_high = NA,
        statistic = tab$F[k], df = if (is.na(tab$df_term[k])) NA else paste0(tab$df_term[k], ', ', tab$df_resid[k]),
        p = tab$p[k], n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
        statistic_test = if (k < 3) 'f-test (two-way ANOVA main effect, Type II SS, no participant block)' else 'f-test (two-way ANOVA interaction vs additive model, no participant block)',
        paper_rule = 'p < 0.05', paper_rule_met = if (is.finite(tab$p[k])) tab$p[k] < 0.05 else NA,
        transformation = 'raw questionnaire score', term_units = 'factor levels as in the paper',
        model_id = paste(column_name, '~ LAeq_level * UTCI_category'), model_details = note)}
    list(results = do.call(rbind, rows), cells = cells, counts = counts)}
)

# --- Song et al. (2013 winter; 2014 spring): one-sided paired t, park vs city walk ---------------
# 2014: "The heart rate and HRV data were collected at 1-minute intervals ... and the 15-minute average
# was compared between sites"; "we used natural logarithmic transformed values"; "A paired t-test was
# used to compare the mean physiological parameters between the two walking sites"; "P < 0.05 (one
# sided) was considered statistically significant". Outcomes: heart rate, ln(HF), ln(LF/HF).
H4_SONG <- list(
  outcomes = list(
    heart_rate_bpm = list(column = 'empatica_heart_rate', log = FALSE, alternative = 'less'),
    ln_HF = list(column = 'empatica_hrv_fd_hf', log = TRUE, alternative = 'greater'),
    ln_LF_HF = list(column = 'empatica_hrv_fd_lf_hf_ratio', log = TRUE, alternative = 'less')),
  bout_value = function(values, times, log_values) {
    minute <- floor(as.numeric(difftime(times, min(times), units = 'secs')) / 60)
    minute_means <- tapply(values, minute, H4_UTIL$finite_mean)
    if (log_values) minute_means <- ifelse(is.finite(minute_means) & minute_means > 0, log(minute_means), NA)
    H4_UTIL$finite_mean(minute_means)},
  run = function(epochs) {
    walk <- epochs[epochs$PhaseID %in% c('WalkG', 'WalkU'), , drop = FALSE]
    rows <- list()
    for (outcome_label in names(H4_SONG$outcomes)) {
      spec <- H4_SONG$outcomes[[outcome_label]]
      bout_values <- do.call(rbind, lapply(H4_UTIL$bouts(walk), function(r) data.frame(
        ParticipantID = walk$ParticipantID[r[1]], PhaseID = walk$PhaseID[r[1]],
        value = H4_SONG$bout_value(walk[[spec$column]][r], walk$Datetime[r], spec$log))))
      wide <- merge(bout_values[bout_values$PhaseID == 'WalkG', c('ParticipantID', 'value')],
        bout_values[bout_values$PhaseID == 'WalkU', c('ParticipantID', 'value')], by = 'ParticipantID', suffixes = c('_park', '_city'))
      wide <- wide[is.finite(wide$value_park) & is.finite(wide$value_city), ]
      tt <- if (nrow(wide) >= 3) t.test(wide$value_park, wide$value_city, paired = TRUE, alternative = spec$alternative) else NULL
      rows[[length(rows) + 1L]] <- data.frame(
        paper = 'Song 2013/2014', test = 'one-sided paired t-test, park (WalkG) vs city (WalkU)', outcome = outcome_label,
        source_column = spec$column, term = paste0('WalkG - WalkU (H1: ', spec$alternative, ' than 0)'),
        estimate = if (is.null(tt)) NA else unname(tt$estimate), se = if (is.null(tt)) NA else unname(tt$stderr),
        ci_low = if (is.null(tt)) NA else tt$conf.int[1], ci_high = if (is.null(tt)) NA else tt$conf.int[2],
        statistic = if (is.null(tt)) NA else unname(tt$statistic), df = if (is.null(tt)) NA else unname(tt$parameter),
        p = if (is.null(tt)) NA else tt$p.value, n_observations = 2L * nrow(wide), n_participants = nrow(wide),
        statistic_test = 'one-sided paired t-test',
        paper_rule = 'P < 0.05 (one sided)', paper_rule_met = if (is.null(tt)) NA else tt$p.value < 0.05,
        transformation = if (spec$log) 'natural log of 1-min values, then bout mean' else 'raw, mean of 1-min values',
        term_units = 'park minus city', model_id = paste('t.test(park, city, paired = TRUE, alternative =', spec$alternative, ')'),
        model_details = sprintf('mean park=%.6g; mean city=%.6g', mean(wide$value_park), mean(wide$value_city)))}
    list(results = do.call(rbind, rows))}
)

# --- Rodrigues et al. (2026): 7.Model_H2.py (Zenodo 10.5281/zenodo.16092878) -------------------
# blocks = {"Noise": ["NOISE_max", "NOISE_std"], "Temperature": ["Temp_max", "Temp_mean"], ...};
# df[predictors].fillna(0); StandardScaler(); smf.mixedlm(var ~ predictors, groups = INDIVID).fit();
# retained if round(p, 4) < 0.05 and abs(round(beta, 4)) > 0.1.
H4_RODRIGUES <- list(
  blocks = list(Noise = c('NOISE_max', 'NOISE_std'), Temperature = c('Temp_max', 'Temp_mean')),
  unavailable_blocks = c(
    Infrastructure = 'Mapillary_Utility_Pole, Mapillary_Traffic_Light, Mapillary_Curb, Mapillary_Building, Mapillary_Manhole, Mapillary_Pole, Mapillary_Road',
    'Functional POIs' = 'OSM_poi_transportation, OSM_poi_amenity, OSM_public_services, OSM_poi_shop',
    'Mapillary Visuals' = 'Mapillary_Car, Mapillary_Person, Mapillary_Fence'),
  # Dependent variables in their code order; only those with a measured counterpart in our data.
  outcomes = list(
    'IBI/HRV' = c(STD_bpm = 'empatica_heart_rate:STD', STD_LF_HF_ratio = 'empatica_hrv_fd_lf_hf_ratio:STD', STD_RMSSD = 'empatica_hrv_td_rmssd:STD',
      MAX_bpm = 'empatica_heart_rate:MAX', MAX_LF_HF_ratio = 'empatica_hrv_fd_lf_hf_ratio:MAX', MAX_RMSSD = 'empatica_hrv_td_rmssd:MAX',
      MEAN_bpm = 'empatica_heart_rate:MEAN', MEAN_LF_HF_ratio = 'empatica_hrv_fd_lf_hf_ratio:MEAN', MEAN_RMSSD = 'empatica_hrv_td_rmssd:MEAN',
      MIN_bpm = 'empatica_heart_rate:MIN', MIN_LF_HF_ratio = 'empatica_hrv_fd_lf_hf_ratio:MIN', MIN_RMSSD = 'empatica_hrv_td_rmssd:MIN'),
    'Skin Temperature' = c(STD_Values = 'empatica_skin_temperature:STD', MAX_Values = 'empatica_skin_temperature:MAX', MIN_Values = 'empatica_skin_temperature:MIN')),
  unavailable_outcomes = 'EDA SCR amplitude and rise-time features (9 variables) and pNN50 (STD/MAX/MEAN/MIN): not in the merged dataset',
  standard_scaler = function(x) { x[!is.finite(x)] <- 0; (x - mean(x)) / sqrt(mean((x - mean(x))^2)) },
  trip_frame = function(epochs, sound = H4_SOUND$primary) {
    walk <- epochs[epochs$PhaseID %in% c('WalkG', 'WalkU'), , drop = FALSE]
    summary_fun <- list(STD = H4_UTIL$finite_sd, MAX = H4_UTIL$finite_max, MEAN = H4_UTIL$finite_mean, MIN = H4_UTIL$finite_min)
    do.call(rbind, lapply(H4_UTIL$bouts(walk), function(rows) {
      out <- data.frame(ParticipantID = walk$ParticipantID[rows[1]], PhaseID = walk$PhaseID[rows[1]],
        NOISE_max = H4_UTIL$finite_max(walk[[sound$column]][rows]), NOISE_std = H4_UTIL$finite_sd(walk[[sound$column]][rows]),
        Temp_max = H4_UTIL$finite_max(walk$ucm_AIR_temp[rows]), Temp_mean = H4_UTIL$finite_mean(walk$ucm_AIR_temp[rows]))
      for (system in names(H4_RODRIGUES$outcomes)) for (name in names(H4_RODRIGUES$outcomes[[system]])) {
        parts <- strsplit(H4_RODRIGUES$outcomes[[system]][[name]], ':')[[1]]
        out[[name]] <- summary_fun[[parts[2]]](walk[[parts[1]]][rows])}
      out}))},
  run = function(epochs, lme_control, sound = H4_SOUND$primary) {
    trips <- H4_RODRIGUES$trip_frame(epochs, sound)
    rows <- list()
    # The Temperature block does not involve sound, so it is fitted only in the primary (dBA) run.
    blocks <- if (sound$is_db) names(H4_RODRIGUES$blocks) else 'Noise'
    for (system in names(H4_RODRIGUES$outcomes)) for (block in blocks) {
      predictors <- H4_RODRIGUES$blocks[[block]]
      for (predictor in predictors) trips[[predictor]] <- H4_RODRIGUES$standard_scaler(trips[[predictor]])
      for (name in names(H4_RODRIGUES$outcomes[[system]])) {
        d <- trips[is.finite(trips[[name]]), ]
        fit <- tryCatch(lme(as.formula(paste(name, '~', paste(predictors, collapse = ' + '))), data = d,
          random = ~ 1 | ParticipantID, method = 'REML', control = lme_control), error = function(e) e)
        for (predictor in predictors) {
          coef_row <- if (inherits(fit, 'error')) data.frame(beta = NA, se = NA) else H4_UTIL$lme_fixed_rows(fit, predictor)
          z <- coef_row$beta / coef_row$se; p <- 2 * pnorm(-abs(z))
          rule <- is.finite(p) & round(p, 4) < 0.05 & abs(round(coef_row$beta, 4)) > 0.1
          rows[[length(rows) + 1L]] <- data.frame(
            paper = 'Rodrigues 2026', test = paste(block, 'block (7.Model_H2.py):', predictor), outcome = name,
            source_column = H4_RODRIGUES$outcomes[[system]][[name]], term = paste0(predictor, ' (StandardScaler z)'),
            estimate = coef_row$beta, se = coef_row$se, ci_low = coef_row$beta - qnorm(0.975) * coef_row$se,
            ci_high = coef_row$beta + qnorm(0.975) * coef_row$se, statistic = z, df = NA, p = p,
            n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
            statistic_test = 'Wald z-test (REML mixed model, random participant intercept)',
            paper_rule = 'round(p,4) < 0.05 and |round(beta,4)| > 0.1', paper_rule_met = rule,
            transformation = 'raw trip summary (no transformation)', term_units = 'per 1 SD (population SD, StandardScaler)',
            model_id = paste(name, '~', paste(predictors, collapse = ' + '), '+ (1 | ParticipantID)'),
            model_details = paste0('system=', system, if (block == 'Temperature') '; exposure=temperature block (not a sound term; fitted because the authors fit it)' else '', if (inherits(fit, 'error')) paste('; fit error:', conditionMessage(fit)) else ''))}}}
    list(results = do.call(rbind, rows), trips = trips)}
)

# --- Kraus et al. (2013): additive mixed models on 5-min intervals --------------------------------
# Paper: "additive mixed models with a random participant effect ... compound symmetry covariance
# structure and included the lagged outcome"; "Except for HR, all outcome variables were log-transformed";
# "confounders that minimized Akaike's information criterion. Long-term and daily time trend were forced
# into all models, along with physical activity. Trend variables were modeled as untransformed linear
# variables or, using penalized splines or polynomials (up to 4 degrees)"; "Weekday and season were
# evaluated as potential confounders"; "all HRV parameter models were adjusted for HR"; "Leq lagged in
# 5-min intervals up to 15 min"; "piecewise linear term with a cut-off point at 65 dB(A) ... 5-dB(A)
# increase". Outcomes: HR, SDNN, LF power (normalized units), HF power (normalized units), LF:HF ratio
# (RMSSD not reported). Activity categories: 3) very light to light exertion (e.g. slow walking),
# 4) moderate exertion (e.g. biking).
H4_KRAUS <- list(
  outcomes = c(HR = 'empatica_heart_rate', SDNN = 'empatica_hrv_td_sdnn', LF_nu = 'empatica_hrv_fd_lfnu',
    HF_nu = 'empatica_hrv_fd_hfnu', LF_HF = 'empatica_hrv_fd_lf_hf_ratio'),
  trend_forms = c('linear', 'poly2', 'poly3', 'poly4', 'pspline'),
  # Paper: 5-min intervals, Leq lags 0-5, 5-10, 10-15 min. In an 8-min bout only the first 5-min
  # interval is complete; lags beyond 0 min are not estimable. Lagged outcome requires a prior 5-min
  # interval within the bout (absent here), so Y_prev is omitted with that limitation documented.
  interval_seconds = 300,
  fd_outcomes = c('LF_nu', 'HF_nu', 'LF_HF'),
  lags = 0L,
  trend_term = function(variable_name, form_name) switch(form_name, linear = variable_name,
    poly2 = sprintf('poly(%s, 2)', variable_name), poly3 = sprintf('poly(%s, 3)', variable_name),
    poly4 = sprintf('poly(%s, 4)', variable_name), pspline = sprintf("s(%s, bs = 'ps', k = 6)", variable_name)),
  interval_frame = function(epochs, sound = H4_SOUND$primary) {
    step <- H4_KRAUS$interval_seconds; need <- (2 / 3) * (step / 10)
    do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      b <- epochs[rows, ]
      k <- floor(as.numeric(difftime(b$Datetime, min(b$Datetime), units = 'secs')) / step) + 1L
      per <- do.call(rbind, lapply(sort(unique(k)), function(j) {
        r <- k == j; dba <- b[[sound$column]][r]; mid <- b$Datetime[r][ceiling(sum(r) / 2)]
        out <- data.frame(ParticipantID = b$ParticipantID[1], PhaseID = b$PhaseID[1], interval = j,
          Leq = if (sum(is.finite(dba)) >= need) H4_UTIL$sound_mean(dba, sound$is_db) else NA_real_)
        for (label in setdiff(names(H4_KRAUS$outcomes), H4_KRAUS$fd_outcomes)) {
          v <- b[[H4_KRAUS$outcomes[[label]]]][r]
          out[[label]] <- if (sum(is.finite(v)) >= need) H4_UTIL$finite_mean(v) else NA_real_}
        # Frequency-domain values are themselves 5-min window estimates and exist only on rows whose
        # window is complete (about 14-15 of the 30 rows in 0-5 min), so the 2/3-row rule cannot apply.
        # Use the dataset's 5-min window that starts inside this interval and ends within one 10-s epoch
        # of its end (the dataset's windows sit on a 10-s grid offset by one epoch from the bout start),
        # latest such window, with the paper's >= 300 beats rule for frequency-domain values.
        t0 <- min(b$Datetime[r]); t1 <- t0 + step + 10
        inside <- which(r & b$hrv_window_available & is.finite(b$hrv_seg_start) & is.finite(b$hrv_seg_end) &
          b$hrv_seg_start >= t0 & b$hrv_seg_end <= t1)
        w <- if (length(inside)) inside[which.max(as.numeric(b$hrv_seg_end[inside]))] else NA_integer_
        beats <- if (is.na(w)) NA_real_ else suppressWarnings(as.numeric(b$empatica_hrv_fd_5min_valid_rri_count[w]))
        for (label in H4_KRAUS$fd_outcomes) out[[label]] <- if (!is.na(w) && is.finite(beats) && beats >= 300) b[[H4_KRAUS$outcomes[[label]]]][w] else NA_real_
        out$daily_time_h <- as.numeric(format(mid, '%H')) + as.numeric(format(mid, '%M')) / 60 + as.numeric(format(mid, '%S')) / 3600
        out$study_day <- as.numeric(as.Date(mid)); out$weekday <- weekdays(as.Date(mid))
        out}))
      for (lag in 1:max(H4_KRAUS$lags, 0L)) if (lag > 0) per[[paste0('Leq_lag', lag)]] <- per$Leq[match(per$interval - lag, per$interval)]
      per$Leq_lag0 <- per$Leq
      if (max(H4_KRAUS$lags, 0L) >= 1L) for (label in names(H4_KRAUS$outcomes)) per[[paste0(label, '_prev')]] <- per[[label]][match(per$interval - 1L, per$interval)]
      per$activity_category <- ifelse(grepl('^Walk', b$PhaseID[1]), '3 very light to light exertion (slow walking)', '4 moderate exertion (biking)')
      per[per$interval == 1L, ]}))},
  fit = function(rhs_terms, d, lme_control, method) {
    model_formula <- as.formula(paste('Yk ~', paste(rhs_terms, collapse = ' + ')))
    cs <- corCompSymm(form = ~ 1 | ParticipantID)
    if (any(grepl('^s\\(', rhs_terms))) {
      g <- tryCatch(gamm(model_formula, random = list(ParticipantID = ~ 1), correlation = cs, data = d, method = method, control = lme_control), error = function(e) e)
      if (inherits(g, 'error')) return(g)
      list(lme = g$lme, aic = AIC(g$lme))
    } else {
      m <- tryCatch(lme(model_formula, random = ~ 1 | ParticipantID, correlation = cs, data = d, method = method, control = lme_control), error = function(e) e)
      if (inherits(m, 'error')) return(m)
      list(lme = m, aic = AIC(m))}},
  aic = function(fit) if (inherits(fit, 'error')) Inf else fit$aic,
  log_or_raw = function(label, x) if (label == 'HR') x else ifelse(is.finite(x) & x > 0, log(x), NA),
  run = function(epochs, lme_control, sound = H4_SOUND$primary) {
    intervals <- H4_KRAUS$interval_frame(epochs, sound)
    # dBA: knot 65 dB(A), slope per 5 dB (paper). Other descriptors: knot = median and slope per 1 SD of the
    # descriptor's 5-min interval values (pooled over all intervals used).
    knot <- if (sound$is_db) 65 else stats::median(intervals$Leq_lag0, na.rm = TRUE)
    step <- if (sound$is_db) 5 else stats::sd(intervals$Leq_lag0, na.rm = TRUE)
    intervals$study_day <- intervals$study_day - min(intervals$study_day, na.rm = TRUE)
    for (lag in H4_KRAUS$lags) {
      leq <- intervals[[paste0('Leq_lag', lag)]]
      intervals[[paste0('L', lag, '_below65_per5')]] <- (pmin(leq, knot) - knot) / step
      intervals[[paste0('L', lag, '_above65_per5')]] <- (pmax(leq, knot) - knot) / step}
    intervals$activity_category <- factor(intervals$activity_category)
    intervals$weekday <- factor(intervals$weekday)
    intervals$HR_cov <- intervals$HR
    all_lag_terms <- unlist(lapply(H4_KRAUS$lags, function(lag) paste0('L', lag, c('_below65_per5', '_above65_per5'))))
    rows <- list(); selection <- list()
    for (label in names(H4_KRAUS$outcomes)) {
      d <- intervals
      d$Yk <- H4_KRAUS$log_or_raw(label, d[[label]])
      use_lagged_outcome <- max(H4_KRAUS$lags, 0L) >= 1L && any(is.finite(d[[paste0(label, '_prev')]]))
      if (use_lagged_outcome) {
        d$Y_prev <- H4_KRAUS$log_or_raw(label, d[[paste0(label, '_prev')]])
        base_forced <- c('Y_prev', 'activity_category', if (label != 'HR') 'HR_cov')
      } else {
        d$Y_prev <- NA_real_
        base_forced <- c('activity_category', if (label != 'HR') 'HR_cov')
      }
      trends <- c(long_term = 'study_day', daily = 'daily_time_h')
      d <- d[complete.cases(d[c('Yk', base_forced, all_lag_terms, trends, 'weekday')]), ]
      trend_terms <- function(f) unname(mapply(H4_KRAUS$trend_term, names(f), f))
      # Trend forms and weekday chosen by AIC (ML) on the lag-0 model; the same confounder set is used for every lag.
      forced0 <- c('L0_below65_per5', 'L0_above65_per5', base_forced)
      forms <- setNames(rep('linear', length(trends)), trends)
      for (trend in trends) {
        aic_by_form <- sapply(H4_KRAUS$trend_forms, function(form_name) {
          trial <- forms; trial[trend] <- form_name
          H4_KRAUS$aic(H4_KRAUS$fit(c(forced0, trend_terms(trial)), d, lme_control, 'ML'))})
        forms[trend] <- names(which.min(aic_by_form))}
      base_aic <- H4_KRAUS$aic(H4_KRAUS$fit(c(forced0, trend_terms(forms)), d, lme_control, 'ML'))
      weekday_aic <- if (nlevels(droplevels(d$weekday)) > 1) H4_KRAUS$aic(H4_KRAUS$fit(c(forced0, trend_terms(forms), 'weekday'), d, lme_control, 'ML')) else Inf
      kept <- if (weekday_aic < base_aic) 'weekday' else character(0)
      lag_note <- if (use_lagged_outcome) '' else '; lagged outcome omitted (no prior 5-min interval within 8-min bout)'
      selection[[label]] <- sprintf('trend forms: %s; AIC(ML) base=%.3f, +weekday=%s -> weekday %s; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout%s; n=%d 5-min intervals (interval 1 per phase)',
        paste(names(forms), forms, sep = '=', collapse = ', '), base_aic,
        if (is.finite(weekday_aic)) sprintf('%.3f', weekday_aic) else 'not estimable (weekday aliased with participant/day trend)',
        if (length(kept)) 'kept' else 'not kept', lag_note, nrow(d))
      for (lag in H4_KRAUS$lags) {
        lag_terms <- paste0('L', lag, c('_below65_per5', '_above65_per5'))
        final_terms <- c(lag_terms, base_forced, trend_terms(forms), kept)
        final <- H4_KRAUS$fit(final_terms, d, lme_control, 'REML')
        cs_rho <- if (inherits(final, 'error')) NA else as.numeric(coef(final$lme$modelStruct$corStruct, unconstrained = FALSE))
        for (term_name in lag_terms) {
          r <- if (inherits(final, 'error')) data.frame(beta = NA, se = NA, df = NA, t = NA, p_t = NA) else {
            tt <- summary(final$lme)$tTable; hit <- grep(paste0('^X?', term_name, '$'), rownames(tt), value = TRUE)[1]
            data.frame(beta = tt[hit, 'Value'], se = tt[hit, 'Std.Error'], df = tt[hit, 'DF'], t = tt[hit, 't-value'], p_t = tt[hit, 'p-value'])}
          ci <- r$beta + c(-1, 1) * qt(0.975, r$df) * r$se
          scale_pct <- function(x) if (label == 'HR') 100 * x / mean(d$HR) else 100 * (exp(x) - 1)
          rows[[length(rows) + 1L]] <- data.frame(
            paper = 'Kraus 2013',
            test = if (sound$is_db) sprintf('additive mixed model, 5-min intervals, Leq lag 0 (0-5 min), 5-dB increase %s', if (grepl('below', term_name)) '< 65 dB(A)' else '>= 65 dB(A)') else
              sprintf('additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase %s median knot', if (grepl('below', term_name)) 'below' else 'at/above'),
            outcome = label, source_column = H4_KRAUS$outcomes[[label]], term = term_name,
            estimate = scale_pct(r$beta), se = NA, ci_low = scale_pct(ci[1]), ci_high = scale_pct(ci[2]), statistic = r$t, df = r$df, p = r$p_t,
            n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
            statistic_test = 't-test (mixed-model coefficient)',
            paper_rule = '95% CI excludes 0 (p < 0.05)', paper_rule_met = if (is.finite(r$p_t)) r$p_t < 0.05 else NA,
            transformation = if (label == 'HR') 'raw HR; estimate = 100*beta/mean(HR)' else 'natural log; estimate = 100*(exp(beta)-1)',
            term_units = if (sound$is_db) 'percent change per 5 dB(A)' else sprintf('percent change per 1 SD (%.4g) of %s; knot = median %.4g', step, sound$column, knot),
            model_id = paste('Yk ~', paste(final_terms, collapse = ' + '), '| random ~1|ParticipantID, corCompSymm'),
            model_details = sprintf('beta=%.6g; se(beta)=%.6g; %s; corCompSymm rho=%.4g%s', r$beta, r$se, selection[[label]], cs_rho,
              if (inherits(final, 'error')) paste('; fit error:', conditionMessage(final)) else ''))}}}
    list(results = do.call(rbind, rows), intervals = intervals, selection = selection, knot = knot, step = step)}
)

# --- Catalog, summary and METHODS_NOTES -----------------------------------------------------------
H4_REPORT <- list(
  # Rows without a p value (fit failed or no data) are not results: they are removed from the results
  # CSV and listed in METHODS_NOTES with the reason (attribute 'not_estimable').
  catalog = function(...) {
    results <- do.call(rbind, list(...)); rownames(results) <- NULL
    dropped <- results[!is.finite(results$p), c('paper', 'test', 'outcome', 'n_observations', 'model_details'), drop = FALSE]
    results <- results[is.finite(results$p), , drop = FALSE]; rownames(results) <- NULL
    results$q_BH <- ave(results$p, paste(results$paper, results$test), FUN = H4_UTIL$bh)
    results$sig_p05 <- is.finite(results$p) & results$p < 0.05
    results$survives_FDR_q05 <- is.finite(results$q_BH) & results$q_BH < 0.05
    results$inference_status <- paste0('paper decision rule [', results$paper_rule, ']: ',
      ifelse(is.na(results$paper_rule_met), 'not estimable', ifelse(results$paper_rule_met, 'MET', 'not met')),
      '; q_BH is an extra column (BH within paper x test x sound variable), not the paper rule')
    results$reporting_note <- results$model_details
    attr(results, 'not_estimable') <- dropped
    results},
  not_estimable_notes = function(dropped) {
    if (!nrow(dropped)) return(c('', '## Not estimable', '- None: every planned test returned a p value.'))
    reason <- ifelse(grepl('fit error', dropped$model_details), sub('^.*fit error: ', 'fit error: ', dropped$model_details), 'not estimable')
    reason <- trimws(gsub('[[:space:]]+', ' ', sub('[[:space:]]*message =[[:space:]]*$', '', reason)))
    reason <- sub(';.*$', '', reason)
    groups <- unique(data.frame(paper = dropped$paper, test = dropped$test, outcome = dropped$outcome, n = dropped$n_observations, reason = reason))
    c('', '## Not estimable (removed from the results CSV; no p value, so no q value)',
      sprintf('- %d planned tests returned no p value:', nrow(dropped)),
      sprintf('  - %s | %s | %s | n=%s | %s', groups$paper, groups$test, groups$outcome, groups$n, groups$reason))},
  summary = function(results) {
    do.call(rbind, lapply(split(results, factor(paste(results$paper, results$test), levels = unique(paste(results$paper, results$test)))), function(r) {
      fin <- is.finite(r$p)
      data.frame(sound_variable = r$sound_variable[1], paper = r$paper[1], test = r$test[1], paper_decision_rule = r$paper_rule[1], n_tests = sum(fin),
        n_paper_rule_met = sum(r$paper_rule_met %in% TRUE), outcomes_paper_rule_met = paste(r$outcome[r$paper_rule_met %in% TRUE], collapse = '; '),
        n_p_lt_05 = sum(fin & r$p < 0.05), n_q_lt_05 = sum(fin & is.finite(r$q_BH) & r$q_BH < 0.05),
        surviving_FDR = paste(r$outcome[fin & is.finite(r$q_BH) & r$q_BH < 0.05], collapse = '; '))}))},
  methods_notes = function(jin_counts, jin_cells, kraus_selection, kraus_intervals, moshammer_frame) {
    count_lines <- apply(jin_counts, 1, function(r) sprintf('  - %s | %s: n = %s', r[['laeq_level']], r[['utci_category']], r[['n_phase_cells']]))
    out_of_range <- sum(is.na(jin_cells$laeq_level) | is.na(jin_cells$utci_category))
    c('# H4 sound literature tests - exact-method rewrite (2026-11-03)',
      'Each block fits the source paper\'s own model. Where the 8-min / 11-participant data cannot support a step, the closest literal step is used and the limitation is listed here. q_BH (Benjamini-Hochberg within paper x test) is an extra column; each paper\'s own decision rule is reported separately (inference_note).',
      '',
      '## Moshammer et al. 2019 (random-effects GLS, Stata xtreg re)',
      '- Implemented: outcome in a sub-period ~ noise Leq (energy mean) of the PRECEDING sub-period per 1 dB(A) (Table A2, unadjusted) and + mean air temperature of the outcome sub-period (Methods: temperature as confounder); Stata default Swamy-Arora variance components, GLS transform, conventional VCE, z tests. Raw outcomes, no activity term, no centring.',
      '- Window mapping: the paper uses consecutive 15-min periods with noise from the preceding 15 min; that cannot be fit within one 8-min bout. Here: energy-mean Leq of the first 5 min as exposure and phase-mean outcomes over the remainder (5-8 min), one row per phase (up to 44 rows). A window needs >= 2/3 valid 10-s rows. Fitted on all four phases and, separately, on walking phases only.',
      '- The paper models no autocorrelation beyond the participant random effect; none is added here. Outcome and exposure windows are non-overlapping but serial correlation within a participant may remain; standard errors may be optimistic.',
      '- Dust: personal PM2.5 exists (Atmotube), but Table A2 reports single-exposure models, so PM is not added to the noise model.',
      '- Temperature: the paper used a stationary meteorological station; here the mobile air temperature (ucm_AIR_temp).',
      '- Outcomes: RR distance (derived row-wise as 60000 / empatica_heart_rate), SDNN, RMSSD, VLF, LF and HF power. TINN and blood pressure are not in the dataset.',
      '',
      '## Jin, Jin & Kang 2020 (two-way ANOVA)',
      '- Implemented: two-way ANOVA LAeq level x UTCI category with interaction, no participant block. The paper does not state its SS type; because several LAeq x UTCI cells are empty, Type III marginal hypotheses are not uniquely defined, so main effects are Type II (each adjusted for the other main effect) and the interaction is tested against the additive model (the same F under Type II and Type III).',
      '- Levels exactly as the paper: LAeq 55-60, 60-65, 65-70, 70-75 dB(A); UTCI summer stress categories 9-26, 26-32, 32-38, 38-46 C (one summer season, campaign 3 July to 27 August 2025, analysed with the paper\'s summer bins).',
      sprintf('- %d of 44 phase cells fall outside the paper\'s LAeq (55-75 dB(A)) or UTCI (9-46 C) ranges and are excluded, not reassigned.', out_of_range),
      '- Outcomes: TCV analogue = questionnaire_thermal_comfort_1_5 (5-point; paper 7-point); OCV analogue = questionnaire_current_comfort_1_7 (General Comfort, 7-point). TSV, subjective loudness and acoustic comfort were not collected. Paper unit = independent respondents; here 44 phase cells from 11 participants (repeated measures, not modelled, as instructed: no block).',
      '- Cell counts (phase cells with phase LAeq and UTCI inside the ranges):', count_lines,
      '- Empty or small cells are reported as they are; levels are not collapsed.',
      '',
      '## Song et al. 2013 (winter) / 2014 (spring) (one-sided paired t-test)',
      '- Source: J Physiol Anthropol 32:18 and 33:8 (open access; PDFs saved in Experiment papers/H4 Sound literature test/).',
      '- Implemented: heart rate, ln(HF), ln(LF/HF); 1-min values averaged over the walk; one-sided paired t-test park (WalkG) vs city (WalkU), P < 0.05 one-sided. Direction as in the papers: HR lower, ln(HF) higher, ln(LF/HF) lower in the park.',
      '- Limitations: walks are 8 min, not 15 min; 1-min HRV values are means of the dataset\'s 10-s rows of 5-min-window estimates (MemCalc beat-to-beat analysis not available); Song is a park-vs-city setting contrast, not a sound-level test.',
      '',
      '## Rodrigues et al. 2026 (7.Model_H2.py)',
      '- Implemented: Noise block [NOISE_max, NOISE_std] and Temperature block [Temp_max, Temp_mean], each in its own model; predictors fillna(0) then StandardScaler (population SD); REML mixed model with participant intercept; Wald z p; retention rule round(p,4) < 0.05 and |round(beta,4)| > 0.1.',
      '- Outcomes (their code order): STD/MAX/MEAN/MIN of bpm, LF_HF_ratio, RMSSD and STD/MAX/MIN of skin temperature, raw (no transformation), over walking trips (WalkG, WalkU; 22 trips).',
      paste('- Not available:', H4_RODRIGUES$unavailable_outcomes, '; blocks Infrastructure, Functional POIs and Mapillary Visuals (Mapillary/OSM features not in the dataset).'),
      '- Exposure source differs: their NOISE from the Lisbon Lden map along the route and Temp from the IPMA daily station; here personal dBA and mobile air temperature per trip.',
      '',
      '## Kraus et al. 2013 (additive mixed models)',
      '- Implemented: outcomes HR, SDNN, LF (normalized units), HF (normalized units) and LF:HF; log except HR; lagged outcome (previous interval); piecewise Leq at 65 dB(A) per 5 dB; categorical physical activity (walk = 3 very light to light exertion, bike = 4 moderate exertion); HR adjustment for HRV models; long-term and daily time trends forced in, each linear, polynomial 2-4 or penalized spline by AIC; weekday tested by AIC; random participant intercept plus compound symmetry (nlme corCompSymm).',
      '- Window mapping: the paper\'s non-overlapping 5-min intervals with Leq lags 0-5, 5-10 and 10-15 min. An 8-min bout yields one complete 5-min interval (0-5 min); only lag 0 is estimable. Lags 5-10 and 10-15 min require longer bouts and are not run. Lagged outcome (previous interval) is omitted because there is no prior 5-min interval within the bout. Validity: >= 2/3 valid 10-s rows per 5-min interval for Leq, HR and SDNN. LF_nu, HF_nu and LF_HF are themselves 5-min window estimates present only on rows whose window is complete (about half the rows of 0-5 min), so instead of the row rule they take the dataset\'s 5-min window that starts in the interval and ends within one 10-s epoch of its end (windows sit on a 10-s grid offset by one epoch), requiring >= 300 valid beats as in the paper.',
      '- Autocorrelation: compound symmetry and participant random effect as in the paper; without a lagged outcome term, autocorrelation structure differs from the published model.',
      '- Trend forms and weekday are selected by AIC (ML) on the lag-0 model and reused for each lag. AIC for spline candidates comes from the mgcv::gamm mixed-model representation (lme object, ML).',
      '- Season is one summer (campaign 3 July to 27 August 2025), not a within-campaign season contrast; weekday is constant within each participant (one session each).',
      '- Effect scale as the paper: percent change in the outcome mean per 5 dB(A) (HR: 100*beta/mean HR).',
      '- AIC selection per outcome:', paste0('  - ', names(kraus_selection), ': ', unlist(kraus_selection)),
      sprintf('- Kraus 5-min intervals built: %d (interval 1 of %d phases).', nrow(kraus_intervals), length(unique(paste(kraus_intervals$ParticipantID, kraus_intervals$PhaseID)))),
      '',
      '## Data source',
      '- All blocks use the 10-s time-series rows of output/merged_all_11participants_8min.csv (the same input as Analysis_combined_timeseries.R). Song 1-min means and Rodrigues trip MEAN/STD/MAX/MIN are computed from those 10-s rows; Jin uses all 44 phases.')}
)

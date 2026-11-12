# H4_sound_literature_helpers_test2.R - static function lists for H4_sound_literature_tests_test2.R
# Exact-method rewrite (2026-11-03). Each paper block is one list of static functions
# (H4_MOSHAMMER, H4_JIN, H4_SONG, H4_RODRIGUES, H4_KRAUS); H4_UTIL and H4_REPORT are shared.
# Every block fits the source paper's own model on raw outcomes unless the paper itself transformed
# them. Data limitations are recorded in METHODS_NOTES.md by H4_REPORT$methods_notes().

# --- Shared utilities --------------------------------------------------------------------------
H4_UTIL <- list(
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
  phases = c('WalkG', 'WalkU'),
  specs = list(
    'Table A2 unadjusted (noise only)' = 'noise_leq_db',
    'Methods: temperature as confounder' = c('noise_leq_db', 'air_temp_c')),
  # One measurement period per walking bout: noise Leq (energy mean) and HRV over the same period.
  period_frame = function(epochs) {
    walk <- epochs[epochs$PhaseID %in% H4_MOSHAMMER$phases, , drop = FALSE]
    walk$derived_rr_ms <- ifelse(is.finite(walk$empatica_heart_rate) & walk$empatica_heart_rate > 0, 60000 / walk$empatica_heart_rate, NA_real_)
    do.call(rbind, lapply(H4_UTIL$bouts(walk), function(rows) {
      out <- data.frame(ParticipantID = walk$ParticipantID[rows[1]], PhaseID = walk$PhaseID[rows[1]],
        noise_leq_db = H4_UTIL$energy_mean_db(walk$ucm_SND_dBA[rows]),
        air_temp_c = H4_UTIL$finite_mean(walk$ucm_AIR_temp[rows]), n_rows = length(rows))
      for (column_name in unique(H4_MOSHAMMER$outcomes)) out[[column_name]] <- H4_UTIL$finite_mean(walk[[column_name]][rows])
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
  run = function(epochs) {
    frame <- H4_MOSHAMMER$period_frame(epochs)
    rows <- list()
    for (outcome_label in names(H4_MOSHAMMER$outcomes)) for (spec_label in names(H4_MOSHAMMER$specs)) {
      column_name <- H4_MOSHAMMER$outcomes[[outcome_label]]; regressors <- H4_MOSHAMMER$specs[[spec_label]]
      fit <- H4_MOSHAMMER$xtreg_re(frame[[column_name]], as.matrix(frame[regressors]), frame$ParticipantID)
      noise_row <- if (is.null(fit)) NULL else fit[fit$term == 'noise_leq_db', ]
      rows[[length(rows) + 1L]] <- data.frame(
        paper = 'Moshammer 2019', test = paste('random-effects GLS per dB,', spec_label), outcome = outcome_label,
        source_column = column_name, term = 'noise Leq per 1 dB(A)',
        estimate = if (is.null(fit)) NA else noise_row$beta, se = if (is.null(fit)) NA else noise_row$se,
        ci_low = if (is.null(fit)) NA else noise_row$ci_low, ci_high = if (is.null(fit)) NA else noise_row$ci_high,
        statistic = if (is.null(fit)) NA else noise_row$z, df = NA,
        p = if (is.null(fit)) NA else noise_row$p,
        n_observations = if (is.null(fit)) NA else noise_row$n_obs, n_participants = if (is.null(fit)) NA else noise_row$n_participants,
        statistic_test = 'Wald z-test (random-effects GLS, Stata xtreg re formulas)',
        paper_rule = 'p < 0.05 (Table A2 bold)', paper_rule_met = if (is.null(fit)) NA else noise_row$p < 0.05,
        transformation = 'raw (no transformation)', term_units = 'per 1 dB(A)',
        model_id = paste(column_name, '~', paste(regressors, collapse = ' + '), '| xtreg re by ParticipantID'),
        model_details = if (is.null(fit)) 'not estimable' else sprintf('sigma_u=%.6g; sigma_e=%.6g; theta=%.4f-%.4f',
          noise_row$sigma_u, noise_row$sigma_e, noise_row$theta_min, noise_row$theta_max))}
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
  cell_frame = function(epochs) {
    do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      out <- data.frame(ParticipantID = epochs$ParticipantID[rows[1]], PhaseID = epochs$PhaseID[rows[1]],
        laeq_db = H4_UTIL$energy_mean_db(epochs$ucm_SND_dBA[rows]), utci_c = H4_UTIL$finite_mean(epochs$ucm_UTCI[rows]))
      for (column_name in H4_JIN$outcomes) out[[column_name]] <- H4_UTIL$first_finite(epochs[[column_name]][rows])
      out$laeq_level <- cut(out$laeq_db, H4_JIN$laeq_breaks, H4_JIN$laeq_labels, right = FALSE)
      out$utci_category <- cut(out$utci_c, H4_JIN$utci_breaks, H4_JIN$utci_labels, right = FALSE)
      out}))},
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
  run = function(epochs) {
    cells <- H4_JIN$cell_frame(epochs)
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
      note <- sprintf('%d of 44 phase cells inside the paper LAeq/UTCI ranges; %d observed LAeq levels x %d UTCI categories; %d empty and %d cells with n<3 among observed levels',
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
  trip_frame = function(epochs) {
    walk <- epochs[epochs$PhaseID %in% c('WalkG', 'WalkU'), , drop = FALSE]
    summary_fun <- list(STD = H4_UTIL$finite_sd, MAX = H4_UTIL$finite_max, MEAN = H4_UTIL$finite_mean, MIN = H4_UTIL$finite_min)
    do.call(rbind, lapply(H4_UTIL$bouts(walk), function(rows) {
      out <- data.frame(ParticipantID = walk$ParticipantID[rows[1]], PhaseID = walk$PhaseID[rows[1]],
        NOISE_max = H4_UTIL$finite_max(walk$ucm_SND_dBA[rows]), NOISE_std = H4_UTIL$finite_sd(walk$ucm_SND_dBA[rows]),
        Temp_max = H4_UTIL$finite_max(walk$ucm_AIR_temp[rows]), Temp_mean = H4_UTIL$finite_mean(walk$ucm_AIR_temp[rows]))
      for (system in names(H4_RODRIGUES$outcomes)) for (name in names(H4_RODRIGUES$outcomes[[system]])) {
        parts <- strsplit(H4_RODRIGUES$outcomes[[system]][[name]], ':')[[1]]
        out[[name]] <- summary_fun[[parts[2]]](walk[[parts[1]]][rows])}
      out}))},
  run = function(epochs, lme_control) {
    trips <- H4_RODRIGUES$trip_frame(epochs)
    rows <- list()
    for (system in names(H4_RODRIGUES$outcomes)) for (block in names(H4_RODRIGUES$blocks)) {
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
  trend_term = function(variable_name, form_name) switch(form_name, linear = variable_name,
    poly2 = sprintf('poly(%s, 2)', variable_name), poly3 = sprintf('poly(%s, 3)', variable_name),
    poly4 = sprintf('poly(%s, 4)', variable_name), pspline = sprintf("s(%s, bs = 'ps', k = 6)", variable_name)),
  # One complete 5-min interval per bout: the last dataset HRV window lying fully inside the bout.
  interval_frame = function(epochs) {
    do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      b <- epochs[rows, ]; bout_start <- min(b$Datetime); bout_end <- max(b$Datetime)
      ok <- b$hrv_window_available & is.finite(b$hrv_seg_start) & is.finite(b$hrv_seg_end) &
        b$hrv_seg_start >= bout_start & b$hrv_seg_end <= bout_end
      out <- data.frame(ParticipantID = b$ParticipantID[1], PhaseID = b$PhaseID[1], window_start = NA_character_, window_end = NA_character_)
      if (!any(ok)) return(out)
      w <- which(ok)[which.max(as.numeric(b$hrv_seg_end[ok]))]
      in_window <- b$Datetime >= b$hrv_seg_start[w] & b$Datetime < b$hrv_seg_end[w]
      beats <- suppressWarnings(as.numeric(b$empatica_hrv_fd_5min_valid_rri_count[w]))
      dba <- b$ucm_SND_dBA[in_window]
      out$window_start <- format(b$hrv_seg_start[w]); out$window_end <- format(b$hrv_seg_end[w]); out$beats <- beats
      out$Leq <- if (sum(is.finite(dba)) >= (2 / 3) * 30) H4_UTIL$energy_mean_db(dba) else NA_real_
      out$HR <- if (is.finite(beats) && beats >= 200) H4_UTIL$finite_mean(b$empatica_heart_rate[in_window]) else NA_real_
      out$SDNN <- if (is.finite(beats) && beats >= 200) H4_UTIL$finite_mean(b$empatica_hrv_td_sdnn[in_window]) else NA_real_
      for (label in c('LF_nu', 'HF_nu', 'LF_HF')) out[[label]] <- if (is.finite(beats) && beats >= 300) b[[H4_KRAUS$outcomes[[label]]]][w] else NA_real_
      mid <- b$hrv_seg_start[w] + as.numeric(difftime(b$hrv_seg_end[w], b$hrv_seg_start[w], units = 'secs')) / 2
      out$daily_time_h <- as.numeric(format(mid, '%H')) + as.numeric(format(mid, '%M')) / 60 + as.numeric(format(mid, '%S')) / 3600
      out$study_day <- as.numeric(as.Date(mid))
      out$weekday <- weekdays(as.Date(mid))
      out$activity_category <- ifelse(grepl('^Walk', b$PhaseID[1]), '3 very light to light exertion (slow walking)', '4 moderate exertion (biking)')
      out}))},
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
  run = function(epochs, lme_control) {
    intervals <- H4_KRAUS$interval_frame(epochs)
    intervals$study_day <- intervals$study_day - min(intervals$study_day, na.rm = TRUE)
    intervals$L_below65_per5 <- (pmin(intervals$Leq, 65) - 65) / 5
    intervals$L_above65_per5 <- (pmax(intervals$Leq, 65) - 65) / 5
    intervals$activity_category <- factor(intervals$activity_category)
    intervals$weekday <- factor(intervals$weekday)
    intervals$HR_cov <- intervals$HR
    rows <- list(); selection <- list()
    for (label in names(H4_KRAUS$outcomes)) {
      d <- intervals
      d$Yk <- if (label == 'HR') d$HR else ifelse(is.finite(d[[label]]) & d[[label]] > 0, log(d[[label]]), NA)
      forced <- c('L_below65_per5', 'L_above65_per5', 'activity_category', if (label != 'HR') 'HR_cov')
      trends <- c(long_term = 'study_day', daily = 'daily_time_h')
      d <- d[complete.cases(d[c('Yk', forced, trends, 'weekday')]), ]
      forms <- setNames(rep('linear', length(trends)), trends)
      trend_terms <- function(f) unname(mapply(H4_KRAUS$trend_term, names(f), f))
      for (trend in trends) {
        aic_by_form <- sapply(H4_KRAUS$trend_forms, function(form_name) {
          trial <- forms; trial[trend] <- form_name
          H4_KRAUS$aic(H4_KRAUS$fit(c(forced, trend_terms(trial)), d, lme_control, 'ML'))})
        forms[trend] <- names(which.min(aic_by_form))}
      base_aic <- H4_KRAUS$aic(H4_KRAUS$fit(c(forced, trend_terms(forms)), d, lme_control, 'ML'))
      weekday_aic <- if (nlevels(droplevels(d$weekday)) > 1) H4_KRAUS$aic(H4_KRAUS$fit(c(forced, trend_terms(forms), 'weekday'), d, lme_control, 'ML')) else Inf
      kept <- if (weekday_aic < base_aic) 'weekday' else character(0)
      final_terms <- c(forced, trend_terms(forms), kept)
      final <- H4_KRAUS$fit(final_terms, d, lme_control, 'REML')
      selection[[label]] <- sprintf('trend forms: %s; AIC(ML) base=%.3f, +weekday=%s -> weekday %s; season: single season (August), not evaluable',
        paste(names(forms), forms, sep = '=', collapse = ', '), base_aic, if (is.finite(weekday_aic)) sprintf('%.3f', weekday_aic) else 'not estimable (weekday aliased with participant/day trend)', if (length(kept)) 'kept' else 'not kept')
      cs_rho <- if (inherits(final, 'error')) NA else as.numeric(coef(final$lme$modelStruct$corStruct, unconstrained = FALSE))
      for (term_name in c('L_below65_per5', 'L_above65_per5')) {
        r <- if (inherits(final, 'error')) data.frame(beta = NA, se = NA, df = NA, t = NA, p_t = NA) else {
          tt <- summary(final$lme)$tTable; hit <- grep(paste0('^X?', term_name, '$'), rownames(tt), value = TRUE)[1]
          data.frame(beta = tt[hit, 'Value'], se = tt[hit, 'Std.Error'], df = tt[hit, 'DF'], t = tt[hit, 't-value'], p_t = tt[hit, 'p-value'])}
        pct <- if (label == 'HR') 100 * r$beta / mean(d$HR) else 100 * (exp(r$beta) - 1)
        pct_low <- if (label == 'HR') 100 * (r$beta - qt(0.975, r$df) * r$se) / mean(d$HR) else 100 * (exp(r$beta - qt(0.975, r$df) * r$se) - 1)
        pct_high <- if (label == 'HR') 100 * (r$beta + qt(0.975, r$df) * r$se) / mean(d$HR) else 100 * (exp(r$beta + qt(0.975, r$df) * r$se) - 1)
        rows[[length(rows) + 1L]] <- data.frame(
          paper = 'Kraus 2013', test = paste('additive mixed model, 5-dB increase in Leq', if (term_name == 'L_below65_per5') '< 65 dB(A)' else '>= 65 dB(A)'),
          outcome = label, source_column = H4_KRAUS$outcomes[[label]], term = term_name,
          estimate = pct, se = NA, ci_low = pct_low, ci_high = pct_high, statistic = r$t, df = r$df, p = r$p_t,
          n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
          statistic_test = 't-test (mixed-model coefficient)',
          paper_rule = '95% CI excludes 0 (p < 0.05)', paper_rule_met = if (is.finite(r$p_t)) r$p_t < 0.05 else NA,
          transformation = if (label == 'HR') 'raw HR; estimate = 100*beta/mean(HR)' else 'natural log; estimate = 100*(exp(beta)-1)',
          term_units = 'percent change per 5 dB(A)',
          model_id = paste('Yk ~', paste(final_terms, collapse = ' + '), '| random ~1|ParticipantID, corCompSymm'),
          model_details = sprintf('beta=%.6g; se(beta)=%.6g; %s; corCompSymm rho=%.4g%s', r$beta, r$se, selection[[label]], cs_rho,
            if (inherits(final, 'error')) paste('; fit error:', conditionMessage(final)) else ''))}}
    list(results = do.call(rbind, rows), intervals = intervals, selection = selection)}
)

# --- Catalog, summary and METHODS_NOTES -----------------------------------------------------------
H4_REPORT <- list(
  catalog = function(...) {
    results <- do.call(rbind, list(...)); rownames(results) <- NULL
    results$q_BH <- ave(results$p, paste(results$paper, results$test), FUN = H4_UTIL$bh)
    results$sig_p05 <- is.finite(results$p) & results$p < 0.05
    results$survives_FDR_q05 <- is.finite(results$q_BH) & results$q_BH < 0.05
    results$inference_status <- paste0('paper decision rule [', results$paper_rule, ']: ',
      ifelse(is.na(results$paper_rule_met), 'not estimable', ifelse(results$paper_rule_met, 'MET', 'not met')),
      '; q_BH is an extra column (BH within paper x test), not the paper rule')
    results$reporting_note <- results$model_details
    results},
  summary = function(results) {
    do.call(rbind, lapply(split(results, factor(paste(results$paper, results$test), levels = unique(paste(results$paper, results$test)))), function(r) {
      fin <- is.finite(r$p)
      data.frame(paper = r$paper[1], test = r$test[1], paper_decision_rule = r$paper_rule[1], n_tests = sum(fin),
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
      '- Implemented: outcome ~ noise Leq per 1 dB(A) (Table A2, unadjusted) and outcome ~ noise + air temperature (Methods: temperature as confounder); Stata default Swamy-Arora variance components, GLS transform, conventional VCE, z tests. Raw outcomes, no activity term, no centring.',
      '- Walking bouts only (WalkG, WalkU; 22 periods, 11 participants), because all source exposures were walks.',
      '- "Preceding 15 min": the paper averages noise over each 15-min period and reads ECG over that same period (Figure 3 caption). Here one period = one 8-min walking bout (noise Leq and HRV over the same bout). Periods are not 15 min, and only one period per bout exists, so the paper\'s separate after-15/30/45/60-min models reduce to one model.',
      '- Dust: personal PM2.5 exists (Atmotube), but Table A2 reports single-exposure models ("Unadjusted effect estimates"), so PM is not added to the noise model. PM-only models are air-pollution tests and are out of the H4 sound scope.',
      '- Temperature: the paper used a stationary meteorological station; here the mobile air temperature (ucm_AIR_temp) bout mean.',
      '- Outcomes available: RR distance (derived row-wise as 60000 / empatica_heart_rate, then bout mean), SDNN, RMSSD, VLF, LF and HF power. TINN and blood pressure are not in the dataset. HRV values are bout means of the dataset\'s 5-min-window estimates (frequency-domain values masked where the 5-min window is unavailable), not Kubios over the full period.',
      '',
      '## Jin, Jin & Kang 2020 (two-way ANOVA)',
      '- Implemented: two-way ANOVA LAeq level x UTCI category with interaction, no participant block. The paper does not state its SS type; because several LAeq x UTCI cells are empty, Type III marginal hypotheses are not uniquely defined, so main effects are Type II (each adjusted for the other main effect) and the interaction is tested against the additive model (the same F under Type II and Type III).',
      '- Levels exactly as the paper: LAeq 55-60, 60-65, 65-70, 70-75 dB(A); UTCI summer stress categories 9-26, 26-32, 32-38, 38-46 C (single season: all sessions in August 2025, analysed as the paper\'s summer).',
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
      '- Implemented: outcomes HR, SDNN, LF (normalized units), HF (normalized units) and LF:HF; log except HR; piecewise Leq at 65 dB(A) per 5 dB; categorical physical activity (walk = 3 very light to light exertion, bike = 4 moderate exertion, the paper\'s own category examples); HR adjustment for HRV models; long-term and daily time trends forced in, each modelled as linear, polynomial 2-4 or penalized spline chosen by AIC; weekday tested by AIC; random participant intercept plus compound-symmetry correlation (nlme corCompSymm).',
      '- One 5-min interval per bout: the last dataset 5-min HRV window lying fully inside the bout; HR and SDNN averaged over that window (>= 200 beats), frequency-domain values from that window (>= 300 beats), Leq from >= 2/3 valid 10-s values.',
      '- Not supportable: lagged outcome and Leq lags 0-5, 5-10 and 10-15 min. An 8-min bout holds one complete 5-min interval; the preceding 3 min fall below the paper\'s 2/3 availability rule; adjacent bouts are 12-40 min apart and in another mode. Season is constant (August 2025). Weekday is constant within each participant (one session each).',
      '- With one session per participant, compound symmetry within participant duplicates the random intercept (rho near 0); it is kept because the paper specifies both.',
      '- AIC for penalized-spline candidates is taken from the mixed-model representation fitted by mgcv::gamm (its lme object, ML); polynomial and linear candidates from nlme::lme (ML).',
      '- Effect scale as the paper: percent change in the outcome mean per 5 dB(A) (HR: 100*beta/mean HR).',
      '- AIC selection per outcome:', paste0('  - ', names(kraus_selection), ': ', unlist(kraus_selection)),
      sprintf('- Kraus intervals with a complete 5-min window: %d of 44 bouts.', sum(!is.na(kraus_intervals$window_start))))}
)

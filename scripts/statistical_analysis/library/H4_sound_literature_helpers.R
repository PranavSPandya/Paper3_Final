# Helpers for H4_sound_literature_test.R: one function list per paper (H4_MOSHAMMER, H4_JIN, H4_BIEL, H4_RODRIGUES, H4_KORPILO, H4_KRAUS, H4_PIGLIAUTILE, H4_CHIUCCHIU) plus H4_UTIL, H4_AL, H4_REPORT, H4_PRIMARY;
# outdoor blocks h4_outdoor_phase_cells, h4_scopus_outdoor_tests, h4_additional_outdoor_tests (§3 Cureau/Chen and Scopus-listed papers).
# Source-inspired tests and explicit adaptations; data limitations go to METHODS_NOTES.md. Song et al. (2013, 2014) is not fitted: no sound level and no thermal term in the source.
# Literature search + partial porting narrative: documents/H4_papers_screened_final.md §0.6; Paper 3 H4 primary rows: §0.3 via H4_PRIMARY$subset().

# Shared utilities; ucm_SND_dBA is the main sound exposure, the alternatives are the category and spectral columns.
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
    out},
  attach_encodings = function(epochs) {
    epochs$sound_corridor_urban <- ifelse(epochs$PhaseID %in% c('WalkU', 'BikeU'), 1,
      ifelse(epochs$PhaseID %in% c('WalkG', 'BikeG'), 0, NA_real_))
    if (all(c('vehicle_proportion', 'rural_natural_proportion') %in% names(epochs)))
      # Two-minority head-to-head, not 8-class majority: urban_manmade_positive dominates the recordings.
      epochs$sound_yamnet_majority_traffic <- as.numeric(epochs$vehicle_proportion > epochs$rural_natural_proportion)
    epochs},
  four_ways = function(available_columns) {
    out <- list()
    if ('sound_corridor_urban' %in% available_columns)
      out$sound_corridor_urban <- list(column = 'sound_corridor_urban', is_db = FALSE, family = 'sound_corridor', binary = TRUE)
    if ('sound_yamnet_majority_traffic' %in% available_columns)
      out$sound_yamnet_majority_traffic <- list(column = 'sound_yamnet_majority_traffic', is_db = FALSE, family = 'sound_yamnet_vehicle_vs_rural', binary = TRUE)
    for (column in intersect(H4_SOUND$category, available_columns))
      out[[column]] <- list(column = column, is_db = FALSE, family = 'sound_category_proportion')
    out})

H4_UTIL <- list(
  # dB levels are averaged on the energy scale, other descriptors arithmetically.
  sound_mean = function(x, is_db) if (is_db) H4_UTIL$energy_mean_db(x) else H4_UTIL$finite_mean(x),
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
    out <- as.data.frame(do.call(rbind, rows)); out$term <- terms; out})

# Moshammer et al. (2019): random-effects GLS (Stata xtreg, re), unadjusted and temperature-adjusted
H4_MOSHAMMER <- list(
  outcomes = c(
    RR_distance_ms = 'derived_rr_ms', SDNN_ms = 'empatica_hrv_td_sdnn', RMSSD_ms = 'empatica_hrv_td_rmssd',
    LF_power = 'empatica_hrv_fd_lf', HF_power = 'empatica_hrv_fd_hf'),
  # The paper uses 15-min periods; here the first 5 min are the exposure and 5-8 min the outcome.
  exposure_seconds = 300,
  phase_sets = list('all phases' = c('BikeG', 'BikeU', 'WalkG', 'WalkU'), 'walking phases (paper setting)' = c('WalkG', 'WalkU')),
  specs = list(
    'Table A2 unadjusted (noise only)' = 'noise_leq_prev_db',
    'Methods: temperature as confounder' = c('noise_leq_prev_db', 'air_temp_c')),
  # Native beat-to-beat intervals from the Empatica build (01_empatica_build.py).
  rri_file = 'output/empatica_files/01_empatica_rri_native.csv',
  read_rri = function() {
    path <- file.path(resolve_project_root(), H4_MOSHAMMER$rri_file)
    if (!file.exists(path)) stop('Moshammer LF/HF: native RRI file not found: ', path)
    rri <- read.csv(path)
    rri$peak_time <- as.POSIXct(rri$peak_time, tz = 'UTC', format = '%Y-%m-%d %H:%M:%OS')
    split(rri[c('peak_time', 'rri_ms')], rri$ParticipantID)},
  # Artifact rule of the build: drop beats more than 0.45 s from the centred 11-beat median.
  rri_keep = function(v) {
    if (length(v) < 5) return(rep(TRUE, length(v)))
    ref <- vapply(seq_along(v), function(i) median(v[max(1L, i - 5L):min(length(v), i + 5L)]), 0)
    abs(v - ref) <= 450},
  # NeuroKit2 hrv_frequency as in the build: 4 Hz quadratic spline, Welch (Hann, half-length segments), LF 0.04-0.15 Hz, HF 0.15-0.40 Hz.
  lf_hf = function(peak_time, rri_ms, start, end) {
    w_in <- peak_time >= start & peak_time < end
    n_raw <- sum(w_in); t <- peak_time[w_in]; v <- rri_ms[w_in]
    ok <- is.finite(v) & v >= 250 & v <= 2500; t <- t[ok]; v <- v[ok]
    keep <- H4_MOSHAMMER$rri_keep(v); t <- t[keep]; v <- v[keep]; n <- length(v)
    if (!n_raw || n < 40 || 100 * (n_raw - n) / n_raw > 25) return(c(lf = NA_real_, hf = NA_real_, sdnn = NA_real_, rmssd = NA_real_, rr_mean = NA_real_, n_beats = n))
    x <- as.numeric(difftime(t, t[1], units = 'secs'))
    knots <- c(rep(x[1], 3), ((x[-1] + x[-n]) / 2)[2:(n - 2)], rep(x[n], 3))
    grid <- seq(0, by = 0.25, length.out = ceiling((x[n] + 0.25) / 0.25))
    y <- rep(v[n], length(grid)); inside <- grid <= x[n]
    y[inside] <- splines::splineDesign(knots, grid[inside], ord = 3) %*% solve(splines::splineDesign(knots, x, ord = 3), v)
    y <- y - mean(y); N <- length(y)
    min_f <- 2 * 4 / (N / 2); nseg <- trunc(2 / min_f * 4); if (nseg > N / 2) nseg <- trunc(N / 2)
    win <- 0.5 - 0.5 * cos(2 * pi * (seq_len(nseg) - 1) / nseg); nfft <- 2 * nseg; half <- nfft / 2 + 1
    seg <- seq(1, N - nseg + 1, by = nseg - nseg %/% 2)
    psd <- rowMeans(vapply(seg, function(s) Mod(fft(c(y[s:(s + nseg - 1)] * win, numeric(nfft - nseg)))[1:half])^2, numeric(half)))
    psd <- psd / (4 * sum(win^2)); psd[2:(half - 1)] <- 2 * psd[2:(half - 1)]; f <- (seq_len(half) - 1) * 4 / nfft
    band <- function(lo, hi) {
      i <- f >= min_f & f <= 0.5 & f >= lo & f < hi
      p <- if (sum(i) > 1) sum(diff(f[i]) * (psd[i][-1] + psd[i][-sum(i)]) / 2) else 0
      if (p == 0) NA_real_ else p}
    c(lf = band(0.04, 0.15), hf = band(0.15, 0.4),
      sdnn = sd(v), rmssd = sqrt(mean(diff(v)^2)), rr_mean = mean(v),
      n_beats = n)},
  # Outcome window on the first-5-min Leq (+ air temperature); rows need >= 2/3 of expected rows. LF/HF, SDNN, RMSSD, and mean RR all come from raw beats in the 5-8 min window.
  period_frame = function(epochs, sound = H4_SOUND$primary) {
    exp_sec <- H4_MOSHAMMER$exposure_seconds
    exp_need <- (2 / 3) * (exp_sec / 10)
    cap_sec <- get0('PAPER3_MATCHED_CAP_SEC', ifnotfound = 480)
    rri <- H4_MOSHAMMER$read_rri()
    do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      b <- epochs[rows, ]
      secs <- as.numeric(difftime(b$Datetime, min(b$Datetime), units = 'secs'))
      exp_r <- secs < exp_sec; out_r <- secs >= exp_sec
      if (!any(out_r)) return(NULL)
      dba_exp <- b[[sound$column]][exp_r]
      noise_leq_prev_db <- if (sum(is.finite(dba_exp)) >= exp_need) H4_UTIL$sound_mean(dba_exp, sound$is_db) else NA_real_
      out <- data.frame(ParticipantID = b$ParticipantID[1], PhaseID = b$PhaseID[1],
        noise_leq_prev_db = noise_leq_prev_db, air_temp_c = H4_UTIL$finite_mean(b$ucm_AIR_temp[out_r]))
      # 10 s rows are epoch starts, so the matched bout ends at the first row + 480 s.
      # LF/HF, SDNN, RMSSD, and mean RR are all computed from raw beats in the 5-8 min outcome window.
      beats <- rri[[as.character(b$ParticipantID[1])]]
      t0 <- min(b$Datetime) + exp_sec; t1 <- min(min(b$Datetime) + cap_sec, max(b$Datetime) + 10)
      p <- if (is.null(beats)) c(lf = NA_real_, hf = NA_real_, sdnn = NA_real_, rmssd = NA_real_, rr_mean = NA_real_, n_beats = 0) else H4_MOSHAMMER$lf_hf(beats$peak_time, beats$rri_ms, t0, t1)
      out$empatica_hrv_fd_lf <- p[['lf']]; out$empatica_hrv_fd_hf <- p[['hf']]; out$n_beats_lf_hf <- p[['n_beats']]
      out$empatica_hrv_td_sdnn <- p[['sdnn']]; out$empatica_hrv_td_rmssd <- p[['rmssd']]; out$derived_rr_ms <- p[['rr_mean']]
      out}))},
  # Stata xtreg re (Swamy-Arora): theta_i = 1 - sqrt(sigma_e^2 / (T_i sigma_u^2 + sigma_e^2)), then OLS on the quasi-demeaned data.
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
    list(results = do.call(rbind, rows))})

# Jin, Jin & Kang (2020): two-way ANOVA of 5-dB LAeq levels x summer UTCI stress categories
H4_JIN <- list(
  # Quartiles of the 44 phase means, so a quiet or cool bout is not dropped. Physical source categories are not reproduced by these quantiles.
  laeq_breaks = c(55, 60, 65, 70, 75),
  laeq_labels = c('55-60 dB(A)', '60-65 dB(A)', '65-70 dB(A)', '70-75 dB(A)'),
  utci_breaks = c(9, 26, 32, 38, 46),
  utci_labels = c('No thermal stress (9-26 C)', 'Moderate heat stress (26-32 C)', 'Strong heat stress (32-38 C)', 'Very strong heat stress (38-46 C)'),
  outcomes = c(
    TCV_thermal_comfort = 'questionnaire_thermal_comfort_1_5',
    ACV_acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
    OCV_overall_comfort = 'questionnaire_current_comfort_1_7'),
  cell_frame = function(epochs, sound = H4_SOUND$primary) {
    cells <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      out <- data.frame(ParticipantID = epochs$ParticipantID[rows[1]], PhaseID = epochs$PhaseID[rows[1]],
        laeq_db = H4_UTIL$sound_mean(epochs[[sound$column]][rows], sound$is_db), utci_c = H4_UTIL$finite_mean(epochs$ucm_UTCI[rows]))
      for (column_name in H4_JIN$outcomes) out[[column_name]] <- H4_UTIL$first_finite(epochs[[column_name]][rows])
      out$utci_category <- NA
      out}))
    quartile_cut <- function(x, prefix) {
      br <- unique(quantile(x, c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE))
      if (length(br) < 3) return(factor(rep(NA, length(x))))
      cut(x, br, paste0(prefix, seq_len(length(br) - 1)), include.lowest = TRUE)}
    n_sound <- length(unique(round(cells$laeq_db, 10)[is.finite(cells$laeq_db)]))
    cells$laeq_level <- if (n_sound <= 2)
      factor(cells$laeq_db) else quartile_cut(cells$laeq_db, 'Q')
    cells$utci_category <- quartile_cut(cells$utci_c, 'T')
    cells},
  # Type II main effects and interaction vs the additive model, all against the full model's residual mean square (as car::Anova type 2).
  anova_type2 = function(y, a, b, participant = NULL) {
    a <- droplevels(a); b <- droplevels(b)
    labels <- c('LAeq level', 'UTCI category', 'LAeq x UTCI')
    if (nlevels(a) < 2 || nlevels(b) < 2) return(NULL)
    rss <- function(X) { q <- qr(X); list(rss = sum(qr.resid(q, y)^2), rank = q$rank) }
    if (is.null(participant)) participant <- factor(rep('one block', length(y)))
    participant <- factor(participant)
    block <- if (nlevels(participant) > 1L) model.matrix(~ participant) else matrix(1, length(y), 1L)
    design <- function(formula) cbind(block, model.matrix(formula)[, -1, drop = FALSE])
    full <- rss(design(~ a * b)); additive <- rss(design(~ a + b))
    only_b <- rss(design(~ b)); only_a <- rss(design(~ a))
    df_res_full <- length(y) - full$rank
    one <- function(label, reduced, larger) {
      df_term <- larger$rank - reduced$rank
      if (df_term < 1 || df_res_full < 1) return(data.frame(effect = label, df_term = df_term, df_resid = df_res_full, F = NA, p = NA))
      F_value <- ((reduced$rss - larger$rss) / df_term) / (full$rss / df_res_full)
      data.frame(effect = label, df_term = df_term, df_resid = df_res_full, F = F_value, p = pf(F_value, df_term, df_res_full, lower.tail = FALSE))}
    rbind(one(labels[1], only_b, additive), one(labels[2], only_a, additive),
      one(labels[3], additive, full))},
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
      tab <- H4_JIN$anova_type2(d[[column_name]], d$laeq_level, d$utci_category, d$ParticipantID)
      note <- sprintf('%d phase cells in this run (quartiles of phase means, not source 5 dB / UTCI stress bins); %d sound x %d UTCI quartiles; %d empty and %d cells with n<3',
        nrow(d), nlevels(droplevels(d$laeq_level)), nlevels(droplevels(d$utci_category)), empty_cells, small_cells)
      if (is.null(tab)) tab <- data.frame(effect = c('LAeq level', 'UTCI category', 'LAeq x UTCI'), df_term = NA, df_resid = NA, F = NA, p = NA)
      for (k in seq_len(nrow(tab))) rows[[length(rows) + 1L]] <- data.frame(
        paper = 'Jin 2020', test = paste('participant-blocked two-way ANOVA,', tab$effect[k]), outcome = outcome_label,
        source_column = column_name, term = tab$effect[k], estimate = NA, se = NA, ci_low = NA, ci_high = NA,
        statistic = tab$F[k], df = if (is.na(tab$df_term[k])) NA else paste0(tab$df_term[k], ', ', tab$df_resid[k]),
        p = tab$p[k], n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
        statistic_test = if (k < 3) 'f-test (two-way ANOVA main effect, Type II SS, participant fixed block)' else 'f-test (two-way ANOVA interaction vs additive model, participant fixed block)',
        paper_rule = 'p < 0.05', paper_rule_met = if (is.finite(tab$p[k])) tab$p[k] < 0.05 else NA,
        transformation = 'raw questionnaire score', term_units = 'our sound/UTCI quantile factors; not source physical categories',
        model_id = paste(column_name, '~ ParticipantID + LAeq_level * UTCI_category'), model_details = note)}
    list(results = do.call(rbind, rows), cells = cells, counts = counts)})

# Biel et al. 2020, Scientific Reports 10:16703: acute cardiovascular effects of air pollutants and noise.
# 30-min mean personal noise -> HRV at the end of the interval, linear term for mean air temperature,
# RH/caffeine/alcohol as potential confounders (kept if they change the coefficient by >= 10%); random subject intercepts.
# Here: one 8-min phase cell per participant x phase; energy-mean dBA per IQR; ln for LF, HF and LF:HF as in the paper.
H4_BIEL <- list(
  outcomes = list(
    HR = list(column = 'empatica_heart_rate', log = FALSE),
    SDNN = list(column = 'empatica_hrv_td_sdnn', log = FALSE),
    RMSSD = list(column = 'empatica_hrv_td_rmssd', log = FALSE),
    LF_power = list(column = 'empatica_hrv_fd_lf', log = TRUE),
    HF_power = list(column = 'empatica_hrv_fd_hf', log = TRUE),
    LF_HF_ratio = list(column = 'empatica_hrv_fd_lf_hf_ratio', log = TRUE)),
  phase_frame = function(epochs, sound = H4_SOUND$primary) {
    do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      out <- data.frame(ParticipantID = epochs$ParticipantID[rows[1]], PhaseID = epochs$PhaseID[rows[1]],
        noise = H4_UTIL$sound_mean(epochs[[sound$column]][rows], sound$is_db),
        air_temp_c = H4_UTIL$finite_mean(epochs$ucm_AIR_temp[rows]),
        air_rh = H4_UTIL$finite_mean(epochs$ucm_AIR_RH[rows]))
      for (name in names(H4_BIEL$outcomes)) out[[name]] <- H4_UTIL$finite_mean(epochs[[H4_BIEL$outcomes[[name]]$column]][rows])
      out}))},
  run = function(epochs, lme_control, sound = H4_SOUND$primary) {
    cells <- H4_BIEL$phase_frame(epochs, sound)
    noise_iqr <- IQR(cells$noise, na.rm = TRUE)
    rows <- list()
    for (name in names(H4_BIEL$outcomes)) {
      spec <- H4_BIEL$outcomes[[name]]
      d <- cells[is.finite(cells[[name]]) & is.finite(cells$noise) & is.finite(cells$air_temp_c), , drop = FALSE]
      if (spec$log) d <- d[d[[name]] > 0, , drop = FALSE]
      if (spec$log) d[[name]] <- log(d[[name]])
      fit <- tryCatch(lme(as.formula(paste(name, '~ noise + air_temp_c')), data = d,
        random = ~ 1 | ParticipantID, method = 'REML', control = lme_control), error = function(e) e)
      # Their confounder rule: RH kept only if it changes the coefficient of interest by >= 10%.
      kept_rh <- FALSE
      if (!inherits(fit, 'error')) {
        beta0 <- H4_UTIL$lme_fixed_rows(fit, 'noise')$beta
        fit_rh <- tryCatch(lme(as.formula(paste(name, '~ noise + air_temp_c + air_rh')), data = d,
          random = ~ 1 | ParticipantID, method = 'REML', control = lme_control), error = function(e) e)
        if (!inherits(fit_rh, 'error')) {
          beta_rh <- H4_UTIL$lme_fixed_rows(fit_rh, 'noise')$beta
          if (is.finite(beta0) && is.finite(beta_rh) && abs(beta_rh - beta0) >= 0.10 * abs(beta0)) { fit <- fit_rh; kept_rh <- TRUE }}}
      coef_row <- if (inherits(fit, 'error')) data.frame(beta = NA, se = NA, df = NA, t = NA, p_t = NA) else H4_UTIL$lme_fixed_rows(fit, 'noise')
      beta_iqr <- coef_row$beta * noise_iqr; se_iqr <- coef_row$se * noise_iqr
      tcrit <- if (is.finite(coef_row$df)) qt(0.975, coef_row$df) else NA_real_
      rows[[length(rows) + 1L]] <- data.frame(
        paper = 'Biel 2020', test = 'concurrent personal-noise LMM (per IQR), air temperature term', outcome = name,
        source_column = spec$column, term = paste0('noise (phase mean of ', sound$column, ', per IQR)'),
        estimate = beta_iqr, se = se_iqr, ci_low = beta_iqr - tcrit * se_iqr, ci_high = beta_iqr + tcrit * se_iqr,
        statistic = coef_row$t, df = coef_row$df, p = coef_row$p_t,
        n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
        statistic_test = 't-test (REML LMM, random participant intercept)',
        paper_rule = 'p < 0.05 (LMM Wald)', paper_rule_met = is.finite(coef_row$p_t) && coef_row$p_t < 0.05,
        transformation = paste0(if (spec$log) 'natural log of the phase mean' else 'raw phase mean',
          '; noise scaled per IQR of the phase means', if (is.finite(noise_iqr)) sprintf(' (IQR = %.4g)' , noise_iqr) else ''),
        term_units = paste0('per 1 IQR', if (is.finite(noise_iqr)) sprintf(' (%.4g)', noise_iqr) else '',
          ' of phase-mean ', sound$column, '; outcome on the modelled scale'),
        model_id = paste(name, '~ noise + air_temp_c', if (kept_rh) ' + air_rh' else '', '+ (1 | ParticipantID)'),
        model_details = paste0('8-min phase cells, not 30-min windows; random intercept only (their 30-min models add slopes and AR(1));',
          ' RH kept by their >=10% coefficient-change rule: ', kept_rh,
          '; caffeine and alcohol not recorded; frequency-domain outcomes are means of the 5-min window estimates'))}
    list(results = do.call(rbind, rows))})

# Biel et al. (2020), repeated-window specification: the source models consecutive short exposure windows within a person
# with random subject intercepts and slopes plus a first-order autoregressive error. Here each 8-min bout is cut into
# consecutive 2-min windows (>= 60% of the expected 10-s rows), each window gets its own energy-mean dBA and air temperature,
# and the model adds corCAR1() within participant using elapsed 2-min units. This is the same design question at the repeated-observation grain.
H4_BIEL_REPEATED <- list(
  outcomes = list(
    HR = list(column = 'empatica_heart_rate', log = FALSE),
    SDNN = list(column = 'empatica_hrv_td_sdnn', log = FALSE),
    RMSSD = list(column = 'empatica_hrv_td_rmssd', log = FALSE),
    LF_power = list(column = 'empatica_hrv_fd_lf', log = TRUE),
    HF_power = list(column = 'empatica_hrv_fd_hf', log = TRUE),
    LF_HF_ratio = list(column = 'empatica_hrv_fd_lf_hf_ratio', log = TRUE)),
  window_seconds = 120,
  # Consecutive windows inside each bout, with the window index used as the AR(1) time variable.
  window_frame = function(epochs, sound = H4_SOUND$primary) {
    out <- list()
    for (rows in H4_UTIL$bouts(epochs)) {
      bout <- epochs[rows, , drop = FALSE]
      secs <- as.numeric(difftime(bout$Datetime, min(bout$Datetime), units = 'secs'))
      idx <- floor(secs / H4_BIEL_REPEATED$window_seconds)
      need <- (2 / 3) * (H4_BIEL_REPEATED$window_seconds / 10)
      for (k in sort(unique(idx))) {
        in_win <- idx == k & is.finite(secs)
        if (sum(in_win) < need) next
        w <- data.frame(ParticipantID = bout$ParticipantID[in_win][1], PhaseID = bout$PhaseID[in_win][1],
          window_start = min(bout$Datetime[in_win]),
          noise = H4_UTIL$sound_mean(bout[[sound$column]][in_win], sound$is_db),
          air_temp_c = H4_UTIL$finite_mean(bout$ucm_AIR_temp[in_win]))
        for (name in names(H4_BIEL_REPEATED$outcomes))
          w[[name]] <- H4_UTIL$finite_mean(bout[[H4_BIEL_REPEATED$outcomes[[name]]$column]][in_win])
        out[[length(out) + 1L]] <- w}}
    frame <- do.call(rbind, out)
    # corAR1 needs one strictly increasing clock per participant; phases share window numbers, so use real start times.
    frame <- frame[order(frame$ParticipantID, frame$window_start), , drop = FALSE]
    frame$window_index <- (as.numeric(frame$window_start) - stats::ave(as.numeric(frame$window_start), frame$ParticipantID, FUN = min)) / 120
    frame},
  run = function(epochs, lme_control, sound = H4_SOUND$primary) {
    cells <- H4_BIEL_REPEATED$window_frame(epochs, sound)
    noise_iqr <- IQR(cells$noise, na.rm = TRUE)
    rows <- list()
    for (name in names(H4_BIEL_REPEATED$outcomes)) {
      spec <- H4_BIEL_REPEATED$outcomes[[name]]
      d <- cells[is.finite(cells[[name]]) & is.finite(cells$noise) & is.finite(cells$air_temp_c), , drop = FALSE]
      if (spec$log) d <- d[d[[name]] > 0, , drop = FALSE]
      if (spec$log) d[[name]] <- log(d[[name]])
      d <- d[order(d$ParticipantID, d$window_index), , drop = FALSE]
      fit <- tryCatch(lme(as.formula(paste(name, '~ noise + air_temp_c')), data = d,
        random = ~ 1 | ParticipantID, correlation = nlme::corCAR1(form = ~ window_index | ParticipantID),
        method = 'REML', control = lme_control), error = function(e) e)
      rho <- if (inherits(fit, 'error')) NA_real_ else {
        cf <- tryCatch(as.numeric(nlme::coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_); cf[1]}
      coef_row <- if (inherits(fit, 'error')) data.frame(beta = NA, se = NA, df = NA, t = NA, p_t = NA) else H4_UTIL$lme_fixed_rows(fit, 'noise')
      beta_iqr <- coef_row$beta * noise_iqr; se_iqr <- coef_row$se * noise_iqr
      tcrit <- if (is.finite(coef_row$df)) qt(0.975, coef_row$df) else NA_real_
      rows[[length(rows) + 1L]] <- data.frame(
        paper = 'Biel 2020', test = 'repeated 2-min window LMM with AR(1) (per IQR), air temperature term', outcome = name,
        source_column = spec$column, term = paste0('noise (2-min window mean of ', sound$column, ', per IQR)'),
        estimate = beta_iqr, se = se_iqr, ci_low = beta_iqr - tcrit * se_iqr, ci_high = beta_iqr + tcrit * se_iqr,
        statistic = coef_row$t, df = coef_row$df, p = coef_row$p_t,
        n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
        statistic_test = 't-test (REML LMM, random participant intercept, continuous-time AR(1) errors)',
        paper_rule = 'p < 0.05 (LMM Wald)', paper_rule_met = is.finite(coef_row$p_t) && coef_row$p_t < 0.05,
        transformation = paste0(if (spec$log) 'natural log of the window mean' else 'raw window mean',
          '; noise scaled per IQR of the window means', if (is.finite(noise_iqr)) sprintf(' (IQR = %.4g)', noise_iqr) else ''),
        term_units = paste0('per 1 IQR', if (is.finite(noise_iqr)) sprintf(' (%.4g)', noise_iqr) else '',
          ' of 2-min window-mean ', sound$column, '; outcome on the modelled scale'),
        model_id = paste(name, '~ noise + air_temp_c + (1 | ParticipantID) + corCAR1'),
        model_details = paste0('consecutive 2-min windows inside the 8-min bout (source: consecutive 30-min windows); continuous AR(1) uses actual elapsed time in 2-min units, including between-bout gaps;',
          ' AR(1) rho = ', if (is.finite(rho)) sprintf('%.3f', rho) else 'not estimable',
          '; random slope not fitted in this adaptation (at most four windows per bout); caffeine and alcohol not recorded'))}
    list(results = do.call(rbind, rows))})

# Rodrigues et al. (2026): 7.Model_H2.py blocks, fillna(0) + StandardScaler, MixedLM; kept if round(p,4) < 0.05 and |round(beta,4)| > 0.1
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
    list(results = do.call(rbind, rows), trips = trips)})

# Korpilo et al. 2024, Urban Forestry & Urban Greening 95:128286: stress recovery in neighbourhood nature.
# Beta-logit GLMM on an EDA index with NDSI, temperature and relative humidity as covariates.
# Here: Gaussian LMM on ln phase-mean tonic EDA with an NDSI analogue from the merged frequency-band proportions.
H4_KORPILO <- list(
  eda_column = 'empatica_eda_tonic',
  ndsi_epoch = function(anthro, bio) { s <- anthro + bio; ifelse(is.finite(s) & s > 0, (bio - anthro) / s, NA_real_) },
  phase_frame = function(epochs, sound = NULL) {
    do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      eda_mean <- H4_UTIL$finite_mean(epochs$empatica_eda_tonic[rows])
      sound_x <- if (is.null(sound)) H4_UTIL$finite_mean(H4_KORPILO$ndsi_epoch(epochs$freq_proportion_200_to_2000Hz[rows], epochs$freq_proportion_2000_to_20000Hz[rows]))
        else H4_UTIL$sound_mean(epochs[[sound$column]][rows], sound$is_db)
      data.frame(ParticipantID = epochs$ParticipantID[rows[1]], PhaseID = epochs$PhaseID[rows[1]],
        eda_ln = if (is.finite(eda_mean) && eda_mean > 0) log(eda_mean) else NA_real_,
        sound_x = sound_x,
        air_temp_c = H4_UTIL$finite_mean(epochs$ucm_AIR_temp[rows]),
        air_rh = H4_UTIL$finite_mean(epochs$ucm_AIR_RH[rows]))}))},
  run = function(epochs, lme_control, sound = NULL) {
    cells <- H4_KORPILO$phase_frame(epochs, sound)
    d <- cells[is.finite(cells$eda_ln) & is.finite(cells$sound_x) & is.finite(cells$air_temp_c) & is.finite(cells$air_rh), , drop = FALSE]
    fit <- tryCatch(lme(eda_ln ~ sound_x + air_temp_c + air_rh + PhaseID, data = d,
      random = ~ 1 | ParticipantID, method = 'REML', control = lme_control), error = function(e) e)
    coef_row <- if (inherits(fit, 'error')) data.frame(beta = NA, se = NA, df = NA, t = NA, p_t = NA) else H4_UTIL$lme_fixed_rows(fit, 'sound_x')
    tcrit <- if (is.finite(coef_row$df)) qt(0.975, coef_row$df) else NA_real_
    sound_name <- if (is.null(sound)) 'NDSI analogue' else sound$column
    results <- data.frame(
      paper = 'Korpilo 2024', test = paste0('EDA level GLMM analogue (', sound_name, ' + temperature + RH + phase)'), outcome = 'ln tonic EDA',
      source_column = 'empatica_eda_tonic (phase mean, natural log)',
      term = sound_name,
      estimate = coef_row$beta, se = coef_row$se,
      ci_low = coef_row$beta - tcrit * coef_row$se, ci_high = coef_row$beta + tcrit * coef_row$se,
      statistic = coef_row$t, df = coef_row$df, p = coef_row$p_t,
      n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
      statistic_test = 't-test (REML LMM, random participant intercept)',
      paper_rule = 'p < 0.05 (GLMM Wald)', paper_rule_met = is.finite(coef_row$p_t) && coef_row$p_t < 0.05,
      transformation = 'natural log of the phase-mean tonic EDA (uS)',
      term_units = if (is.null(sound)) 'per 1 unit of NDSI (from -1 anthrophonic to +1 biophonic)' else paste('per 1 unit of', sound_name),
      model_id = paste('eda_ln ~ sound_x + air_temp_c + air_rh + PhaseID + (1 | ParticipantID); sound_x =', sound_name),
      model_details = paste0('Source: beta-logit GLMM on a normalised EDA index with respondent, group and order random effects;',
        ' this campaign has no group or stop-order structure and tonic EDA in uS, so a Gaussian LMM on ln tonic EDA with a participant intercept is fitted. ',
        if (is.null(sound)) 'NDSI analogue = (freq_proportion_2000_to_20000Hz - freq_proportion_200_to_2000Hz) / (their sum), phase mean of the 10-s rows.'
        else paste('Sound encoding', sound_name, 'replaces NDSI in the same LMM (four-way sound encodings).'),
        if (inherits(fit, 'error')) paste(' Fit error:', conditionMessage(fit)) else ''))
    list(results = results, cells = cells)})

# Kraus et al. (2013): additive mixed models on 5-min intervals, piecewise Leq at 65 dB(A), log outcomes except HR
H4_KRAUS <- list(
  outcomes = c(HR = 'empatica_heart_rate', SDNN = 'empatica_hrv_td_sdnn', LF_power = 'empatica_hrv_fd_lf',
    HF_power = 'empatica_hrv_fd_hf', LF_HF = 'empatica_hrv_fd_lf_hf_ratio'),
  trend_forms = c('linear', 'poly2', 'poly3', 'poly4', 'pspline'),
  # Only lag 0 fits in an 8-min bout and there is no prior interval, so the lagged outcome is left out.
  interval_seconds = 300,
  fd_outcomes = c('LF_power', 'HF_power', 'LF_HF'),
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
        # Frequency-domain values: use the dataset's 5-min window ending at this interval's end (>= 300 beats).
        t0 <- min(b$Datetime[r]); t1 <- t0 + step + 10
        inside <- which(r & b$hrv_window_available & is.finite(b$hrv_seg_start) & is.finite(b$hrv_seg_end) &
          b$hrv_seg_start >= t0 & b$hrv_seg_end <= t1)
        w <- if (length(inside)) inside[which.max(as.numeric(b$hrv_seg_end[inside]))] else NA_integer_
        beats <- if (is.na(w)) NA_real_ else suppressWarnings(as.numeric(b$empatica_hrv_fd_5min_valid_rri_count[w]))
        for (label in H4_KRAUS$fd_outcomes) out[[label]] <- if (!is.na(w) && is.finite(beats) && beats >= 300) b[[H4_KRAUS$outcomes[[label]]]][w] else NA_real_
        out$daily_time_h <- as.numeric(format(mid, '%H')) + as.numeric(format(mid, '%M')) / 60 + as.numeric(format(mid, '%S')) / 3600
        out$study_day <- as.numeric(as.Date(mid)); out$weekday <- weekdays(as.Date(mid))
        out}))
      for (lag in setdiff(H4_KRAUS$lags, 0L)) per[[paste0('Leq_lag', lag)]] <- per$Leq[match(per$interval - lag, per$interval)]
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
    # dBA: knot at 65 dB(A), slope per 5 dB; other descriptors: knot at the median, slope per 1 SD.
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
        base_forced <- c('activity_category', if (label != 'HR') 'HR_cov')}
      trends <- c(long_term = 'study_day', daily = 'daily_time_h')
      d <- d[complete.cases(d[c('Yk', base_forced, all_lag_terms, trends, 'weekday')]), ]
      trend_terms <- function(f) unname(mapply(H4_KRAUS$trend_term, names(f), f))
      # Trend forms and weekday chosen by AIC (ML) on the lag-0 model, then used for every lag.
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
    list(results = do.call(rbind, rows), intervals = intervals, selection = selection, knot = knot, step = step)})

# Shared bout labels for Pigliautile 2021 and Chiucchiù 2026 (same NEXT.ROOM protocol, different statistics).
# Thermal: cooler vs warmer than that person's own mean air temperature (C0 ~21 C then C1 ~23 C analogue).
# Soundscape is tested three ways at phase means: (1) vehicle vs rural_natural share (not 8-class majority);
# (2) corridor / phaseavg: WalkG and BikeG = nature, WalkU and BikeU = traffic;
# (3) continuous phase-mean YAMNet class proportions (all eight category columns).
# No 65 dB or 26 C drop. Headphones, assigned 21/23 C, the eight ISO soundscape descriptors, and Big Five are not in this campaign.
H4_AL <- list(
  votes = c(
    acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
    pleasantness = 'questionnaire_pleasantness_1_5',
    thermal_comfort = 'questionnaire_thermal_comfort_1_5',
    visual_comfort = 'questionnaire_visual_comfort_1_5',
    air_quality_comfort = 'questionnaire_air_quality_comfort_1_5'),
  physio = c(
    heart_rate = 'empatica_heart_rate',
    tonic_eda = 'empatica_eda_tonic',
    skin_temperature = 'empatica_skin_temperature'),
  bout_frame = function(epochs) {
    nature_col <- if ('rural_natural_proportion' %in% names(epochs)) 'rural_natural_proportion' else NA_character_
    traffic_col <- if ('vehicle_proportion' %in% names(epochs)) 'vehicle_proportion' else NA_character_
    cells <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
      out <- data.frame(ParticipantID = epochs$ParticipantID[rows[1]], PhaseID = epochs$PhaseID[rows[1]],
        air_temp_c = H4_UTIL$finite_mean(epochs$ucm_AIR_temp[rows]),
        nature_share = if (is.na(nature_col)) NA_real_ else H4_UTIL$finite_mean(epochs[[nature_col]][rows]),
        traffic_share = if (is.na(traffic_col)) NA_real_ else H4_UTIL$finite_mean(epochs[[traffic_col]][rows]),
        heart_rate = H4_UTIL$finite_mean(epochs$empatica_heart_rate[rows]),
        tonic_eda = H4_UTIL$finite_mean(epochs$empatica_eda_tonic[rows]),
        skin_temperature = H4_UTIL$finite_mean(epochs$empatica_skin_temperature[rows]),
        ucm_SND_dBA = H4_UTIL$energy_mean_db(epochs$ucm_SND_dBA[rows]))
      for (col in intersect(H4_SOUND$category, names(epochs))) out[[col]] <- H4_UTIL$finite_mean(epochs[[col]][rows])
      for (name in names(H4_AL$votes)) out[[name]] <- H4_UTIL$first_finite(epochs[[H4_AL$votes[[name]]]][rows])
      out}))
    cells$person_mean_t <- ave(cells$air_temp_c, cells$ParticipantID, FUN = function(x) mean(x, na.rm = TRUE))
    cells$thermal <- factor(ifelse(cells$air_temp_c > cells$person_mean_t, 'warmer', 'cooler'), levels = c('cooler', 'warmer'))
    cells$soundscape_yamnet <- factor(ifelse(cells$traffic_share > cells$nature_share, 'traffic', 'nature'), levels = c('nature', 'traffic'))
    corridor <- ifelse(cells$PhaseID %in% c('WalkG', 'BikeG'), 'nature', ifelse(cells$PhaseID %in% c('WalkU', 'BikeU'), 'traffic', NA_character_))
    cells$soundscape_corridor <- factor(corridor, levels = c('nature', 'traffic'))
    cells},
  schemes = list(
    yamnet = list(col = 'soundscape_yamnet', tag = 'YAMNet vehicle vs rural_natural',
      sound_variable = 'YAMNet vehicle vs rural_natural (phase mean; not 8-class majority)',
      details = 'traffic if phase-mean vehicle_proportion > rural_natural_proportion; urban_manmade_positive is not the base'),
    corridor = list(col = 'soundscape_corridor', tag = 'green vs urban corridor',
      sound_variable = 'green vs urban corridor (WalkG/BikeG vs WalkU/BikeU)',
      details = 'WalkG and BikeG = nature; WalkU and BikeU = traffic; Tram excluded')),
  proportion_cols = function(cells) intersect(H4_SOUND$category, names(cells)),
  attach_sound = function(row, sound_variable) { row$sound_variable <- sound_variable; row },
  person_pair = function(cells, y_col, by = 'thermal', a = 'cooler', b = 'warmer', subset = NULL) {
    if (is.null(subset)) subset <- rep(TRUE, nrow(cells))
    d <- cells[subset & is.finite(cells[[y_col]]) & !is.na(cells[[by]]), , drop = FALSE]
    ids <- unique(as.character(d$ParticipantID))
    v_a <- v_b <- numeric(0); pid <- character(0)
    for (id in ids) {
      s <- d[as.character(d$ParticipantID) == id, , drop = FALSE]
      ya <- H4_UTIL$finite_mean(s[[y_col]][as.character(s[[by]]) == a])
      yb <- H4_UTIL$finite_mean(s[[y_col]][as.character(s[[by]]) == b])
      if (is.finite(ya) && is.finite(yb)) { v_a <- c(v_a, ya); v_b <- c(v_b, yb); pid <- c(pid, id) }
    }
    list(a = v_a, b = v_b, n = length(v_a), ids = pid)},
  paired_t_row = function(pair, paper, test, outcome, source_column, term, term_units, model_id, details_prefix) {
    n <- pair$n
    empty <- data.frame(
      paper = paper, test = test, outcome = outcome, source_column = source_column, term = term,
      estimate = NA_real_, se = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
      statistic = NA_real_, df = NA_real_, p = NA_real_,
      n_observations = n, n_participants = n,
      statistic_test = 'paired t-test (person means)',
      paper_rule = 'p < 0.05', paper_rule_met = NA,
      transformation = 'raw', term_units = term_units, model_id = model_id,
      model_details = paste0(details_prefix, '; not estimable (need >= 3 people with both levels)'))
    if (n < 3) return(empty)
    diff <- pair$b - pair$a
    if (!any(diff != 0)) {
      empty$estimate <- 0
      empty$se <- 0
      empty$ci_low <- 0
      empty$ci_high <- 0
      empty$statistic <- 0
      empty$df <- n - 1
      empty$p <- 1
      empty$paper_rule_met <- FALSE
      empty$model_details <- paste0(details_prefix, sprintf('; n_pairs=%d [%s]; all paired diffs are 0', n, paste(pair$ids, collapse = ',')))
      return(empty)
    }
    tt <- tryCatch(stats::t.test(pair$b, pair$a, paired = TRUE), error = function(e) e)
    if (inherits(tt, 'error') || !is.finite(tt$p.value)) {
      empty$model_details <- paste0(details_prefix, '; fit error: ', if (inherits(tt, 'error')) conditionMessage(tt) else 'non-finite p')
      return(empty)
    }
    se <- stats::sd(diff) / sqrt(n)
    d_cohen <- if (stats::sd(diff) > 0) mean(diff) / stats::sd(diff) else NA_real_
    data.frame(
      paper = paper, test = test, outcome = outcome, source_column = source_column, term = term,
      estimate = unname(tt$estimate), se = se, ci_low = unname(tt$conf.int[1]), ci_high = unname(tt$conf.int[2]),
      statistic = unname(tt$statistic), df = unname(tt$parameter), p = unname(tt$p.value),
      n_observations = n, n_participants = n,
      statistic_test = 'paired t-test (person means)',
      paper_rule = 'p < 0.05', paper_rule_met = is.finite(tt$p.value) && tt$p.value < 0.05,
      transformation = 'raw', term_units = term_units, model_id = model_id,
      model_details = sprintf('%s; n_pairs=%d [%s]; Cohen d=%.3g (mean of paired diffs / SD of paired diffs)',
        details_prefix, n, paste(pair$ids, collapse = ','), d_cohen))},
  spearman_row = function(x, y, paper, test, outcome, source_column, term, model_id, details_prefix, n_participants, participant_ids) {
    stopifnot(length(participant_ids) == length(x), length(x) == length(y))
    valid <- is.finite(x) & is.finite(y) & !is.na(participant_ids)
    ids <- unique(as.character(participant_ids[valid]))
    x_mean <- vapply(ids, function(id) mean(x[valid & participant_ids == id]), 0.0)
    y_mean <- vapply(ids, function(id) mean(y[valid & participant_ids == id]), 0.0)
    x <- unname(x_mean); y <- unname(y_mean); n_participants <- length(ids)
    test <- gsub('phase mean', 'participant mean', test, fixed = TRUE)
    model_id <- paste(model_id, '[one paired mean per participant]')
    details_prefix <- paste(details_prefix, '; adapted Spearman on participant means: between-person association, not pooled phase association')
    ok <- is.finite(x) & is.finite(y)
    n <- sum(ok)
    empty <- data.frame(
      paper = paper, test = test, outcome = outcome, source_column = source_column, term = term,
      estimate = NA_real_, se = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
      statistic = NA_real_, df = NA_real_, p = NA_real_,
      n_observations = n, n_participants = n_participants,
      statistic_test = 'Spearman rank correlation (independent participant means)',
      paper_rule = 'p < 0.05', paper_rule_met = NA,
      transformation = 'raw questionnaire score', term_units = 'Spearman rho',
      model_id = model_id, model_details = paste0(details_prefix, '; not estimable'))
    if (n < 4) return(empty)
    ct <- tryCatch(stats::cor.test(x[ok], y[ok], method = 'spearman', exact = FALSE), error = function(e) e)
    if (inherits(ct, 'error')) {
      empty$model_details <- paste0(details_prefix, '; fit error: ', conditionMessage(ct))
      return(empty)
    }
    data.frame(
      paper = paper, test = test, outcome = outcome, source_column = source_column, term = term,
      estimate = unname(ct$estimate), se = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
      statistic = unname(ct$statistic), df = NA_real_, p = unname(ct$p.value),
      n_observations = n, n_participants = n_participants,
      statistic_test = 'Spearman rank correlation (independent participant means)',
      paper_rule = 'p < 0.05', paper_rule_met = is.finite(ct$p.value) && ct$p.value < 0.05,
      transformation = 'raw questionnaire score', term_units = 'Spearman rho',
      model_id = model_id, model_details = sprintf('%s; n=%d independent participant means', details_prefix, n))})

# Pigliautile et al. 2021 (CISBAT / J. Phys. Conf. Ser. 2042 012136): means at C0 vs C1, and woodland vs busy street at each temperature.
# The source reports those plots; it does not fit an LMM. Here: paired t on person means.
H4_PIGLIAUTILE <- list(
  run = function(epochs) {
    cells <- H4_AL$bout_frame(epochs)
    rows <- list()
    no_sound <- 'warmer vs cooler (no sound-source label)'
    for (name in c('thermal_comfort', 'visual_comfort', 'acoustic_comfort', 'air_quality_comfort')) {
      pair <- H4_AL$person_pair(cells, name, by = 'thermal', a = 'cooler', b = 'warmer')
      rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$paired_t_row(pair, 'Pigliautile 2021',
        'paired C0 vs C1 analogue, comfort votes', name, H4_AL$votes[[name]],
        'warmer minus cooler', 'vote points (warmer minus cooler person mean)',
        paste(name, 'warmer - cooler | paired t by ParticipantID'),
        'Fig 3a analogue; all bouts; no 65 dB or 26 C drop; thermal contrast only'), no_sound)
    }
    for (scheme in H4_AL$schemes) {
      sound_col <- scheme$col
      for (name in c('pleasantness', 'acoustic_comfort')) {
        pair <- H4_AL$person_pair(cells, name, by = sound_col, a = 'nature', b = 'traffic')
        rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$paired_t_row(pair, 'Pigliautile 2021',
          paste0('nature vs traffic, phase mean (', scheme$tag, ')'),
          name, H4_AL$votes[[name]],
          'traffic minus nature', 'vote points (traffic minus nature person mean)',
          paste(name, 'traffic - nature |', scheme$tag),
          sprintf('phase-mean analogue of #2 woodlands vs #7 busy street; %s', scheme$details)), scheme$sound_variable)
      }
      for (thermal_level in c('cooler', 'warmer')) {
        for (name in c('pleasantness', 'acoustic_comfort')) {
          pair <- H4_AL$person_pair(cells, name, by = sound_col, a = 'nature', b = 'traffic', subset = cells$thermal == thermal_level)
          rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$paired_t_row(pair, 'Pigliautile 2021',
            paste0('nature vs traffic at ', thermal_level, ' (Fig 3b analogue, ', scheme$tag, ')'),
            name, H4_AL$votes[[name]],
            'traffic minus nature', 'vote points (traffic minus nature person mean)',
            paste(name, 'traffic - nature |', thermal_level, '|', scheme$tag),
            sprintf('Fig 3b analogue at %s; %s; eight ISO soundscape descriptors not collected', thermal_level, scheme$details)), scheme$sound_variable)
        }
      }
    }
    n_people <- length(unique(cells$ParticipantID))
    continuous_cols <- c('ucm_SND_dBA', H4_AL$proportion_cols(cells))
    for (col in continuous_cols) {
      for (name in c('pleasantness', 'acoustic_comfort')) {
        # Full-session vote/sound correlations are canonical Chiucchiu rows.
        # Keep only the distinct thermal-stratum questions in this block.
        for (thermal_level in c('cooler', 'warmer')) {
          use <- cells$thermal == thermal_level
          rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$spearman_row(cells[[name]][use], cells[[col]][use], 'Pigliautile 2021',
            paste0('Spearman vote vs ', col, ' at ', thermal_level), name,
            paste(H4_AL$votes[[name]], col, sep = ', '),
            'Spearman rho', paste('spearman(', name, ',', col, ') |', thermal_level),
            sprintf('Fig 3b analogue at %s with the continuous share or dBA, not a majority cut', thermal_level),
            length(unique(as.character(cells$ParticipantID[use]))), cells$ParticipantID[use]), col)
        }
      }
    }
    list(results = do.call(rbind, rows), cells = cells)})

# Chiucchiù, Gnecco, Pigliautile & Pisello 2026 (Building and Environment 290:114140): paired t C0 vs C1 on Empatica, Spearman across domains, C0 vs C1 deltas per soundscape.
# Personality (IPIP-NEO-120 k-means) is not recorded and is not fitted. Not an LMM.
H4_CHIUCCHIU <- list(
  run = function(epochs) {
    cells <- H4_AL$bout_frame(epochs)
    n_people <- length(unique(cells$ParticipantID))
    no_sound <- 'warmer vs cooler (no sound-source label)'
    rows <- list()
    for (name in names(H4_AL$physio)) {
      pair <- H4_AL$person_pair(cells, name, by = 'thermal', a = 'cooler', b = 'warmer')
      rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$paired_t_row(pair, 'Chiucchiù 2026',
        'paired C0 vs C1 analogue, physiology', name, H4_AL$physio[[name]],
        'warmer minus cooler', 'person-mean phase value (warmer minus cooler)',
        paste(name, 'warmer - cooler | paired t by ParticipantID'),
        'source: paired t-test plus Cohen d on mean EDAt, HR and ST at C0 vs C1; no 65 dB or 26 C drop'), no_sound)
    }
    pair_tsv <- H4_AL$person_pair(cells, 'thermal_comfort', by = 'thermal', a = 'cooler', b = 'warmer')
    rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$paired_t_row(pair_tsv, 'Chiucchiù 2026',
      'paired C0 vs C1 analogue, subjective thermal (source TSV)', 'thermal_comfort', H4_AL$votes[['thermal_comfort']],
      'warmer minus cooler', 'vote points (warmer minus cooler person mean)',
      'thermal_comfort warmer - cooler | paired t by ParticipantID',
      'source paired C0 vs C1 on thermal sensation; outcome = domain thermal comfort (§2)'), no_sound)
    rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$spearman_row(cells$thermal_comfort, cells$acoustic_comfort, 'Chiucchiù 2026',
      'Spearman thermal vs acoustic votes', 'thermal_comfort vs acoustic_comfort',
      'questionnaire_thermal_comfort_1_5, questionnaire_acoustic_comfort_1_5',
      'Spearman rho', 'spearman(thermal_comfort, acoustic_comfort) on independent participant means',
      'source: Spearman among perceptual domains, particularly thermal and acoustic; personality correlations not fitted', n_people, cells$ParticipantID), no_sound)
    rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$spearman_row(cells$thermal_comfort, cells$pleasantness, 'Chiucchiù 2026',
      'Spearman thermal vs acoustic votes', 'thermal_comfort vs pleasantness',
      'questionnaire_thermal_comfort_1_5, questionnaire_pleasantness_1_5',
      'Spearman rho', 'spearman(thermal_comfort, pleasantness) on independent participant means',
      'pleasantness is the closest collected analogue of the ISO pleasant descriptor', n_people, cells$ParticipantID), no_sound)
    for (scheme in H4_AL$schemes) {
      sound_col <- scheme$col
      for (sc in c('nature', 'traffic')) {
        for (name in c('pleasantness', 'acoustic_comfort')) {
          pair <- H4_AL$person_pair(cells, name, by = 'thermal', a = 'cooler', b = 'warmer', subset = as.character(cells[[sound_col]]) == sc)
          rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$paired_t_row(pair, 'Chiucchiù 2026',
            paste0('paired C0 vs C1 analogue within ', sc, ' (Table 5 analogue, ', scheme$tag, ')'),
            name, H4_AL$votes[[name]],
            'warmer minus cooler', 'vote points (warmer minus cooler person mean)',
            paste(name, 'warmer - cooler |', sc, '|', scheme$tag),
            sprintf('Table 5 / Fig 7 analogue; C0 vs C1 on %s bouts only; %s; eight ISO descriptors not collected; Big Five not recorded', sc, scheme$details)), scheme$sound_variable)
        }
      }
    }
    continuous_cols <- c('ucm_SND_dBA', H4_AL$proportion_cols(cells))
    for (col in continuous_cols) {
      for (name in c('thermal_comfort', 'pleasantness', 'acoustic_comfort')) {
        rows[[length(rows) + 1L]] <- H4_AL$attach_sound(H4_AL$spearman_row(cells[[name]], cells[[col]], 'Chiucchiù 2026',
          paste0('Spearman vote vs ', col, ', phase mean'), name,
          paste(H4_AL$votes[[name]], col, sep = ', '),
          'Spearman rho', paste('spearman(', name, ',', col, ') on participant means'),
          'continuous YAMNet class share or dBA; not a majority label; personality not fitted; one paired mean per participant across walks', n_people, cells$ParticipantID), col)
      }
    }
    list(results = do.call(rbind, rows), cells = cells)})

# Catalog, summary, and not-estimable notes (METHODS_NOTES are assembled in H4_sound_literature_test.R)
H4_REPORT <- list(
  # Rows without a p value are dropped from the results and listed in METHODS_NOTES.
  catalog = function(...) {
    results <- do.call(rbind, list(...)); rownames(results) <- NULL
    dropped <- results[!is.finite(results$p), c('paper', 'test', 'outcome', 'n_observations', 'model_details'), drop = FALSE]
    results <- results[is.finite(results$p), , drop = FALSE]; rownames(results) <- NULL
    results$sound_variable[results$paper == 'Rodrigues 2026' & grepl('^Temperature block', results$test)] <- 'temperature-only (no sound term)'
    results$sound_variable[results$paper == 'Cureau 2022'] <- 'comfort-domain association (no measured sound predictor)'
    results$sound_variable[grepl('^Spearman thermal vs acoustic', results$test)] <- 'comfort-domain association (no measured sound predictor)'
    results$sig_p05 <- is.finite(results$p) & results$p < 0.05
    results$paper_rule[results$paper == 'Pigliautile 2021'] <- 'analysis-added p < 0.05; source comparison descriptive'
    results$paper_rule[results$paper == 'Korpilo 2024'] <- 'analysis p < 0.05; source model selection alpha 0.10'
    results$inference_status <- paste0('analysis decision rule [', results$paper_rule, ']: ',
      ifelse(is.na(results$paper_rule_met), 'not estimable', ifelse(results$paper_rule_met, 'MET', 'not met')))
    results$reporting_note <- results$model_details
    attr(results, 'not_estimable') <- dropped
    results},
  not_estimable_notes = function(dropped) {
    if (!nrow(dropped)) return(c('', '## Not estimable', '- None: every planned test returned a p value.'))
    reason <- ifelse(grepl('fit error', dropped$model_details), sub('^.*fit error: ', 'fit error: ', dropped$model_details), 'not estimable')
    reason <- trimws(gsub('[[:space:]]+', ' ', sub('[[:space:]]*message =[[:space:]]*$', '', reason)))
    reason <- sub(';.*$', '', reason)
    groups <- unique(data.frame(paper = dropped$paper, test = dropped$test, outcome = dropped$outcome, n = dropped$n_observations, reason = reason))
    c('', '## Not estimable (removed from the results CSV; no finite p value)',
      sprintf('- %d planned tests returned no p value:', nrow(dropped)),
      sprintf('  - %s | %s | %s | n=%s | %s', groups$paper, groups$test, groups$outcome, groups$n, groups$reason))},
  summary = function(results) {
    do.call(rbind, lapply(split(results, factor(paste(results$paper, results$test), levels = unique(paste(results$paper, results$test)))), function(r) {
      fin <- is.finite(r$p)
      data.frame(sound_variable = r$sound_variable[1], paper = r$paper[1], test = r$test[1], paper_decision_rule = r$paper_rule[1], n_tests = sum(fin),
        n_paper_rule_met = sum(r$paper_rule_met %in% TRUE), outcomes_paper_rule_met = paste(r$outcome[r$paper_rule_met %in% TRUE], collapse = '; '),
        n_p_lt_05 = sum(fin & r$p < 0.05))}))})

# Pre-specified paired green vs urban walk (documents/H4_papers_screened_final.md §0.7).
# Literature analogues: Song park vs city; Moshammer park vs road; Pigliautile nature vs traffic route.
H4_ROUTE <- list(
  run = function(cells_walk) {
    if (!nrow(cells_walk)) return(NULL)
    cells <- cells_walk[cells_walk$PhaseID %in% c('WalkG', 'WalkU'), , drop = FALSE]
    cells$route <- as.character(cells$PhaseID)
    comfort <- list(
      thermal_comfort = 'questionnaire_thermal_comfort_1_5',
      acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
      overall_comfort = 'questionnaire_current_comfort_1_7',
      visual_comfort = 'questionnaire_visual_comfort_1_5')
    prefix <- paste(
      'Pre-specified route contrast A1 (section 0.7). WalkG = green corridor; WalkU = urban corridor.',
      'One comfort vote per bout. Analogue families: Song park vs city walk; Moshammer park vs road;',
      'Pigliautile nature vs traffic. Co-exposure shift (dBA and UTCI rise together on WalkU);',
      'not a sound x thermal interaction test.')
    rows <- list()
    add <- function(pair, outcome, source_column, label) {
      rows[[length(rows) + 1L]] <<- H4_AL$attach_sound(
        H4_AL$paired_t_row(pair, 'Paper 3 H4 (route contrast)',
          'paired WalkU minus WalkG | end-of-phase vote', outcome, source_column,
          'WalkU minus WalkG', 'paired difference in vote points (positive = higher score on WalkU)',
          paste(label, 'WalkU - WalkG | paired t by ParticipantID'), prefix),
        'route contrast (WalkG vs WalkU); exposure not isolated')
    }
    for (oname in names(comfort)) {
      if (!oname %in% names(cells)) next
      pair <- H4_AL$person_pair(cells, oname, by = 'route', a = 'WalkG', b = 'WalkU')
      add(pair, oname, comfort[[oname]], oname)
    }
    for (col in c('dba', 'utci')) {
      if (!col %in% names(cells)) next
      pair <- H4_AL$person_pair(cells, col, by = 'route', a = 'WalkG', b = 'WalkU')
      add(pair, col, col, paste0('exposure ', col))
    }
    if (!length(rows)) return(NULL)
    do.call(rbind, rows)
  },
  methods_notes = function(route) {
    c('', '## Paper 3 H4 route contrast (layer A1; paired WalkU minus WalkG)',
      '- Pre-specified in documents/H4_papers_screened_final.md section 0.7.',
      '- Literature analogues (partial port, not full replication): Song; Moshammer park vs road; Pigliautile route nature vs traffic.',
      sprintf('- Rows in H4_route_contrast_results.csv: %d', nrow(route)),
      if (nrow(route)) sprintf('- Paper-rule MET: %d / %d', sum(route$paper_rule_met %in% TRUE), nrow(route)) else '- No rows',
      '',
      '### Route contrast rows',
      if (nrow(route)) apply(route, 1, function(r) sprintf(
        '- %s | %s | estimate=%.4g | p=%.4g | %s', r[['outcome']], r[['term']],
        as.numeric(r[['estimate']]), as.numeric(r[['p']]),
        ifelse(isTRUE(r[['paper_rule_met']]), 'MET', 'not met'))) else '- (none)')
  })

# Pre-specified Paper 3 H4 interaction estimands (documents/H4_papers_screened_final.md §0.3–0.6).
H4_PRIMARY <- list(
  guide = 'documents/H4_papers_screened_final.md section 0.3',
  mask = function(catalog) {
    if (!nrow(catalog)) return(logical(0))
    with(catalog,
      (paper == 'Jin 2020' & sound_variable == 'ucm_SND_dBA' & term == 'LAeq x UTCI' &
          grepl('source-spaced sound bands', test, fixed = TRUE)) |
        (paper == 'Chen 2023 (adapted)' & sound_variable == 'dba' & term == 'utci_z:dba_z' & outcome == 'thermal_comfort') |
        (paper == 'Wu 2025' & sound_variable == 'dba' & term == 'loud60:utci_z' & grepl('dBA>=60', test, fixed = TRUE)) |
        (paper == 'Mohammadzadeh 2023' & sound_variable == 'dba' & term == 'utci_z:sound_z') |
        (paper == 'Li 2025' & sound_variable == 'dba' & term == 'utci:dba' & grepl('interaction LMM', test, fixed = TRUE)) |
        (paper == 'Zhen 2025' & sound_variable == 'dba' & term == 'utci:dba' & outcome == 'thermal_comfort'))
  },
  subset = function(catalog) {
    keep <- H4_PRIMARY$mask(catalog)
    out <- catalog[keep, , drop = FALSE]
    order_specs <- data.frame(
      paper = c('Jin 2020', 'Jin 2020', 'Jin 2020', 'Chen 2023 (adapted)', 'Wu 2025',
        'Mohammadzadeh 2023', 'Li 2025', 'Li 2025', 'Li 2025', 'Zhen 2025'),
      outcome = c('thermal_comfort', 'acoustic_comfort', 'overall_comfort', 'thermal_comfort', 'thermal_comfort',
        'acoustic_comfort', 'thermal_comfort', 'acoustic_comfort', 'overall_comfort', 'thermal_comfort'),
      term = c(rep('LAeq x UTCI', 3), 'utci_z:dba_z', 'loud60:utci_z', 'utci_z:sound_z',
        rep('utci:dba', 3), 'utci:dba'),
      stringsAsFactors = FALSE)
    keys <- paste(out$paper, out$outcome, out$term, sep = '\t')
    rank_keys <- paste(order_specs$paper, order_specs$outcome, order_specs$term, sep = '\t')
    out$primary_estimand_order <- match(keys, rank_keys)
    out[order(out$primary_estimand_order, out$paper, out$outcome), , drop = FALSE]
  },
  methods_notes = function(primary) {
    c('', '## Paper 3 H4 primary estimands (layer A; partial literature port, not full study replication)',
      '- Guide: documents/H4_papers_screened_final.md section 0.3, 0.6.',
      '- Literature search: Scopus title/abstract/keywords therm* AND outdoor AND sound* (see scripts/_scopus_export_text.txt).',
      '- Each included source: closest feasible test family only; omitted source analyses listed in screened guide section 3 item 10.',
      sprintf('- Primary interaction rows in this run: %d (expect 10 if all estimable).', nrow(primary)),
      if (nrow(primary)) sprintf('- Paper-rule MET: %d / %d', sum(primary$paper_rule_met %in% TRUE), nrow(primary)) else
        '- Paper-rule MET: 0 / 0 (no rows matched filters — check H4_PRIMARY$mask).',
      '',
      '### Primary rows (pre-specified interactions on comfort votes)',
      if (nrow(primary)) apply(primary, 1, function(r) sprintf(
        '- #%s %s | %s | %s | p=%.4g | %s', r[['primary_estimand_order']],
        r[['paper']], r[['outcome']], r[['term']], as.numeric(r[['p']]),
        ifelse(isTRUE(r[['paper_rule_met']]), 'MET', 'not met'))) else '- (none)')
  })

# -----------------------------------------------------------------------------
# Outdoor comfort replications (formerly H4_scopus_outdoor_methods.R and
# H4_additional_outdoor_methods.R; archived under library/archive/merged_into_helpers_20261109/).
# -----------------------------------------------------------------------------

h4_outdoor_phase_cells <- function(epochs) {
  ratings <- c(
    thermal_comfort = 'questionnaire_thermal_comfort_1_5',
    acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
    visual_comfort = 'questionnaire_visual_comfort_1_5',
    overall_comfort = 'questionnaire_current_comfort_1_7')
  prs <- c(
    prs_fascination = 'questionnaire_prs11_fascination_mean_1_5',
    prs_being_away = 'questionnaire_prs11_being_away_mean_1_5',
    prs_coherence = 'questionnaire_prs11_coherence_mean_1_5',
    prs_scope = 'questionnaire_prs11_scope_mean_1_5')
  cells <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
    frame <- data.frame(
      ParticipantID = as.character(epochs$ParticipantID[rows[1]]),
      PhaseID = as.character(epochs$PhaseID[rows[1]]),
      utci = H4_UTIL$finite_mean(epochs$ucm_UTCI[rows]),
      pet = H4_UTIL$finite_mean(epochs$ucm_PET[rows]),
      rh = H4_UTIL$finite_mean(epochs$ucm_AIR_RH[rows]),
      air_temp_c = H4_UTIL$finite_mean(epochs$ucm_AIR_temp[rows]),
      dba = H4_UTIL$energy_mean_db(epochs$ucm_SND_dBA[rows]),
      sound_corridor_urban = H4_UTIL$finite_mean(if ('sound_corridor_urban' %in% names(epochs)) epochs$sound_corridor_urban[rows] else NA_real_),
      sound_yamnet_majority_traffic = H4_UTIL$finite_mean(if ('sound_yamnet_majority_traffic' %in% names(epochs)) epochs$sound_yamnet_majority_traffic[rows] else NA_real_),
      nature = H4_UTIL$finite_mean(if ('rural_natural_proportion' %in% names(epochs)) epochs$rural_natural_proportion[rows] else NA_real_),
      wind_aws = if ('ucm_WIND_AWS' %in% names(epochs)) H4_UTIL$finite_mean(epochs$ucm_WIND_AWS[rows]) else NA_real_,
      hr = H4_UTIL$finite_mean(epochs$empatica_heart_rate[rows]),
      sdnn = H4_UTIL$finite_mean(epochs$empatica_hrv_td_sdnn[rows]),
      rmssd = H4_UTIL$finite_mean(epochs$empatica_hrv_td_rmssd[rows]))
    for (col in intersect(H4_SOUND$category, names(epochs))) frame[[col]] <- H4_UTIL$finite_mean(epochs[[col]][rows])
    props <- vapply(intersect(H4_SOUND$category, names(epochs)), function(col) frame[[col]], NA_real_)
    props <- props[is.finite(props) & props >= 0]
    frame$soundscape_diversity <- if (length(props) && sum(props) > 0) {
      p <- props / sum(props); p <- p[p > 0]; -sum(p * log(p))
    } else NA_real_
    for (name in names(ratings)) frame[[name]] <- H4_UTIL$finite_mean(epochs[[ratings[[name]]]][rows])
    for (name in names(prs)) frame[[name]] <- H4_UTIL$finite_mean(epochs[[prs[[name]]]][rows])
    frame$prs_mean <- rowMeans(frame[names(prs)], na.rm = TRUE)
    frame
  }))
  attr(cells, 'ratings') <- ratings
  attr(cells, 'prs') <- prs
  cells
}

h4_phase_lmm_rows <- function(data, formula, terms, paper, test_prefix, outcome, source_column, sound_variable, note) {
  data$ParticipantID <- factor(data$ParticipantID)
  fit <- tryCatch(
    nlme::lme(formula, data = data, random = ~ 1 | ParticipantID, method = 'REML', na.action = na.fail,
      control = nlme::lmeControl(opt = 'optim', returnObject = FALSE)),
    error = function(e) e)
  empty <- setNames(rep(NA_real_, 5), c('Value', 'Std.Error', 'DF', 't-value', 'p-value'))
  rows <- lapply(terms, function(term) {
    coefficient <- if (!inherits(fit, 'error') && term %in% rownames(summary(fit)$tTable)) summary(fit)$tTable[term, ] else empty
    critical <- if (is.finite(coefficient[['DF']])) qt(0.975, coefficient[['DF']]) else NA_real_
    data.frame(
      paper = paper, test = paste(test_prefix, term), outcome = outcome, source_column = source_column, term = term,
      estimate = unname(coefficient[['Value']]), se = unname(coefficient[['Std.Error']]),
      ci_low = unname(coefficient[['Value']] - critical * coefficient[['Std.Error']]),
      ci_high = unname(coefficient[['Value']] + critical * coefficient[['Std.Error']]),
      statistic = unname(coefficient[['t-value']]), df = unname(coefficient[['DF']]), p = unname(coefficient[['p-value']]),
      n_observations = nrow(data), n_participants = nlevels(data$ParticipantID),
      statistic_test = 't-test (REML LMM, random participant intercept)',
      paper_rule = 'p < 0.05', paper_rule_met = is.finite(coefficient[['p-value']]) && coefficient[['p-value']] < 0.05,
      transformation = 'raw questionnaire score', term_units = 'see model_details',
      model_id = paste(deparse(formula), collapse = ' '),
      model_details = paste(note, if (inherits(fit, 'error')) conditionMessage(fit) else ''),
      sound_variable = sound_variable)
  })
  do.call(rbind, rows)
}

h4_kruskal_row <- function(y, group, paper, test, outcome, source_column, sound_variable, note) {
  d <- data.frame(y = y, g = group)
  d <- d[is.finite(d$y) & !is.na(d$g), , drop = FALSE]
  d$g <- droplevels(factor(d$g))
  if (nrow(d) < 3L || nlevels(d$g) < 2L) {
    return(data.frame(
      paper = paper, test = test, outcome = outcome, source_column = source_column, term = 'factor levels',
      estimate = NA_real_, se = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
      statistic = NA_real_, df = NA_real_, p = NA_real_,
      n_observations = nrow(d), n_participants = NA_integer_,
      statistic_test = 'Kruskal-Wallis H-test',
      paper_rule = 'p < 0.05', paper_rule_met = NA,
      transformation = 'phase mean', term_units = 'H statistic',
      model_id = paste(outcome, '~ group (Kruskal-Wallis)'),
      model_details = paste(note, 'not estimable (fewer than two groups or n < 3).'),
      sound_variable = sound_variable))
  }
  fit <- tryCatch(stats::kruskal.test(y ~ g, data = d), error = function(e) e)
  data.frame(
    paper = paper, test = test, outcome = outcome, source_column = source_column, term = 'factor levels',
    estimate = NA_real_, se = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
    statistic = if (inherits(fit, 'error')) NA_real_ else unname(fit$statistic),
    df = if (inherits(fit, 'error')) NA_real_ else unname(fit$parameter),
    p = if (inherits(fit, 'error')) NA_real_ else fit$p.value,
    n_observations = nrow(d), n_participants = NA_integer_,
    statistic_test = 'Kruskal-Wallis H-test',
    paper_rule = 'p < 0.05', paper_rule_met = is.finite(fit$p.value) && fit$p.value < 0.05,
    transformation = 'phase mean', term_units = 'H statistic',
    model_id = paste(outcome, '~ group (Kruskal-Wallis)'),
    model_details = paste(note, if (inherits(fit, 'error')) conditionMessage(fit) else ''),
    sound_variable = sound_variable)
}

h4_pearson_row <- function(x, y, paper, test, outcome, predictor, source_column, sound_variable, note, n_participants = NA_integer_) {
  ok <- is.finite(x) & is.finite(y)
  n <- sum(ok)
  empty <- data.frame(
    paper = paper, test = test, outcome = outcome, source_column = source_column, term = predictor,
    estimate = NA_real_, se = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
    statistic = NA_real_, df = NA_real_, p = NA_real_,
    n_observations = n, n_participants = n_participants,
    statistic_test = 'Pearson correlation (two-sided)',
    paper_rule = 'p < 0.05', paper_rule_met = NA,
    transformation = 'raw / phase mean', term_units = 'Pearson r',
    model_id = paste('cor.test(', outcome, ',', predictor, ')'),
    model_details = paste(note, 'not estimable.'),
    sound_variable = sound_variable)
  if (n < 3L || stats::sd(x[ok]) == 0 || stats::sd(y[ok]) == 0) return(empty)
  fit <- tryCatch(stats::cor.test(x[ok], y[ok], method = 'pearson'), error = function(e) e)
  if (inherits(fit, 'error')) {
    empty$model_details <- paste(note, conditionMessage(fit))
    return(empty)
  }
  data.frame(
    paper = paper, test = test, outcome = outcome, source_column = source_column, term = predictor,
    estimate = unname(fit$estimate), se = NA_real_,
    ci_low = if (!is.null(fit$conf.int)) unname(fit$conf.int[1]) else NA_real_,
    ci_high = if (!is.null(fit$conf.int)) unname(fit$conf.int[2]) else NA_real_,
    statistic = unname(fit$statistic), df = unname(fit$parameter), p = unname(fit$p.value),
    n_observations = n, n_participants = n_participants,
    statistic_test = 'Pearson correlation (two-sided)',
    paper_rule = 'p < 0.05', paper_rule_met = is.finite(fit$p.value) && fit$p.value < 0.05,
    transformation = 'raw / phase mean', term_units = 'Pearson r',
    model_id = paste('cor.test(', outcome, ',', predictor, ')'),
    model_details = note,
    sound_variable = sound_variable)
}

h4_scopus_outdoor_tests <- function(epochs, papers = c('Qin', 'Mohammadzadeh', 'Gao', 'Wu', 'Xu', 'Zhen', 'ZhangSciRep', 'ZhangBSim', 'Tang', 'Peng', 'Simsek')) {
  ratings <- c(
    thermal_comfort = 'questionnaire_thermal_comfort_1_5',
    acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
    overall_comfort = 'questionnaire_current_comfort_1_7')
  prs <- c(
    prs_fascination = 'questionnaire_prs11_fascination_mean_1_5',
    prs_being_away = 'questionnaire_prs11_being_away_mean_1_5',
    prs_coherence = 'questionnaire_prs11_coherence_mean_1_5',
    prs_scope = 'questionnaire_prs11_scope_mean_1_5')
  cells <- h4_outdoor_phase_cells(epochs)
  sound_cols <- intersect(c('dba', 'sound_corridor_urban', 'sound_yamnet_majority_traffic', H4_SOUND$category), names(cells))
  results <- list(); index <- 0L
  add <- function(row) { index <<- index + 1L; results[[index]] <<- row }
  lmm_terms <- function(data, formula, terms, paper, test_prefix, outcome, source_column, sound_variable, note) {
    add(h4_phase_lmm_rows(data, formula, terms, paper, test_prefix, outcome, source_column, sound_variable, note))
  }

  test_Qin <- function() {
    # Qin 2024: TCV ~ sound x humidity. Not UTCI x dBA (that is Jin/Chen).
    for (sound_col in sound_cols) {
      data <- cells[complete.cases(cells[, c('thermal_comfort', sound_col, 'rh')]), ]
      if (nrow(data) < 8L || length(unique(data[[sound_col]])) < 2L) next
      data$sound_z <- as.numeric(scale(data[[sound_col]]))
      data$rh_z <- as.numeric(scale(data$rh))
      lmm_terms(data, thermal_comfort ~ sound_z * rh_z, c('sound_z', 'rh_z', 'sound_z:rh_z'),
        'Qin 2024', paste('TC ~ sound x RH |', sound_col), 'thermal_comfort', ratings[['thermal_comfort']], sound_col,
        'Adapted from Qin humidity-stratified sound effects on TCV/TSV (§2 subjective thermal = thermal_comfort). Four-way sound encoding replaces LAeq bins. Summer only.')
    }
  }

  test_Mohammadzadeh <- function() {
    # Mohammadzadeh 2023: acoustic comfort as outcome of thermal (reverse arrow).
    data <- cells[complete.cases(cells[, c('acoustic_comfort', 'utci')]), ]
    data$utci_z <- as.numeric(scale(data$utci))
    lmm_terms(data, acoustic_comfort ~ utci_z, 'utci_z',
      'Mohammadzadeh 2023', 'AC ~ UTCI', 'acoustic_comfort', ratings[['acoustic_comfort']], 'temperature-only (thermal to acoustic)',
      'Source Pearson/regression of TSV, TCV, PET onto acoustic quality/loudness. Subjective thermal = thermal_comfort; AC ~ zUTCI is the thermal-to-acoustic analogue.')
    data <- cells[complete.cases(cells[, c('acoustic_comfort', 'thermal_comfort')]), ]
    lmm_terms(data, acoustic_comfort ~ thermal_comfort, 'thermal_comfort',
      'Mohammadzadeh 2023', 'AC ~ TC', 'acoustic_comfort', ratings[['acoustic_comfort']], 'comfort-domain association (no measured sound predictor)',
      'Source TCV-acoustic correlations. Vote-to-vote, not measured dBA.')
    for (sound_col in intersect('dba', sound_cols)) {
      data <- cells[complete.cases(cells[, c('acoustic_comfort', 'utci', sound_col)]), ]
      if (nrow(data) < 8L || length(unique(data[[sound_col]])) < 2L) next
      data$utci_z <- as.numeric(scale(data$utci))
      data$sound_z <- as.numeric(scale(data[[sound_col]]))
      lmm_terms(data, acoustic_comfort ~ utci_z * sound_z, c('utci_z', 'sound_z', 'utci_z:sound_z'),
        'Mohammadzadeh 2023', paste('AC ~ UTCI x sound |', sound_col), 'acoustic_comfort', ratings[['acoustic_comfort']], sound_col,
        'Thermal-to-acoustic claim with measured sound as moderator. AC is the outcome. Only the dBA specification is added here; alternative-encoding AC interactions are already fitted by Chen and are not duplicated.')
    }
  }

  test_Gao <- function() {
    # Gao & Zhu 2025: restoration ~ thermal x acoustic. PRS-11 subscales stand in for ROS.
    prs_outcomes <- c(prs, prs_mean = 'prs_mean')
    prs_sources <- c(prs, prs_mean = 'mean of four PRS-11 subscale means')
    for (sound_col in sound_cols) for (outcome in names(prs_outcomes)) {
      needed <- c(outcome, 'utci', sound_col)
      data <- cells[complete.cases(cells[, needed]), ]
      if (nrow(data) < 8L || length(unique(data[[sound_col]])) < 2L) next
      data$utci_z <- as.numeric(scale(data$utci))
      data$sound_z <- as.numeric(scale(data[[sound_col]]))
      data$Y <- data[[outcome]]
      lmm_terms(data, Y ~ utci_z * sound_z, c('utci_z', 'sound_z', 'utci_z:sound_z'),
        'Gao 2025', paste('PRS ~ UTCI x sound |', sound_col), outcome, prs_sources[[outcome]], sound_col,
        'Source ROS two-way ANOVA / weighted regression of restoration on UTCI and LAeq. PRS-11 subscale means replace ROS. Not a thermal-comfort test.')
    }
    gao_cells <- cells[complete.cases(cells[, c('prs_mean', 'utci', 'dba', 'ParticipantID')]), ]
    gao_cells$laeq_level <- if (length(unique(round(gao_cells$dba, 10))) <= 2) factor(gao_cells$dba) else {
      br <- unique(quantile(gao_cells$dba, c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE))
      cut(gao_cells$dba, br, include.lowest = TRUE)
    }
    gao_cells$utci_category <- {
      br <- unique(quantile(gao_cells$utci, c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE))
      cut(gao_cells$utci, br, include.lowest = TRUE)
    }
    for (outcome in names(prs_outcomes)) {
      use <- is.finite(gao_cells[[outcome]]) & !is.na(gao_cells$laeq_level) & !is.na(gao_cells$utci_category)
      d <- gao_cells[use, ]
      tab <- H4_JIN$anova_type2(d[[outcome]], d$laeq_level, d$utci_category, d$ParticipantID)
      if (is.null(tab)) next
      for (k in seq_len(nrow(tab))) add(data.frame(
        paper = 'Gao 2025', test = paste('participant-blocked two-way ANOVA on PRS,', tab$effect[k]),
        outcome = outcome, source_column = prs_sources[[outcome]], term = tab$effect[k],
        estimate = NA_real_, se = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
        statistic = tab$F[k], df = if (is.na(tab$df_term[k])) NA else paste0(tab$df_term[k], ', ', tab$df_resid[k]),
        p = tab$p[k], n_observations = nrow(d), n_participants = length(unique(d$ParticipantID)),
        statistic_test = if (k < 3) 'f-test (two-way ANOVA main effect, Type II SS, participant fixed block)' else 'f-test (two-way ANOVA interaction vs additive model, participant fixed block)',
        paper_rule = 'p < 0.05', paper_rule_met = is.finite(tab$p[k]) && tab$p[k] < 0.05,
        transformation = 'raw PRS-11 subscale / mean', term_units = 'our sound/UTCI quantile factors; not source LAeq bands',
        model_id = paste(outcome, '~ ParticipantID + LAeq_level * UTCI_category'),
        model_details = 'Gao two-way ANOVA of restoration on thermal x acoustic categories. Quartiles replace 5 dB LAeq / UTCI stress bins. ROS replaced by PRS-11.',
        sound_variable = 'dba'))
    }
  }

  test_Wu <- function() {
    # Wu 2025: OCV ~ UTCI + LAeq; LAeq >= 60 dB on thermal comfort.
    for (sound_col in sound_cols) {
      data <- cells[complete.cases(cells[, c('overall_comfort', 'utci', sound_col)]), ]
      if (nrow(data) < 8L || length(unique(data[[sound_col]])) < 2L) next
      data$utci_z <- as.numeric(scale(data$utci))
      data$sound_z <- as.numeric(scale(data[[sound_col]]))
      lmm_terms(data, overall_comfort ~ utci_z + sound_z, c('utci_z', 'sound_z'),
        'Wu 2025', paste('OC ~ UTCI + sound |', sound_col), 'overall_comfort', ratings[['overall_comfort']], sound_col,
        'Source multiple regression of OCV on UTCI and LAeq (they also entered TCV and ACV; those vote predictors are omitted here to keep the environmental terms). Summer only.')
    }
    data <- cells[complete.cases(cells[, c('thermal_comfort', 'utci', 'dba')]), ]
    data$loud60 <- as.numeric(data$dba >= 60)
    data$utci_z <- as.numeric(scale(data$utci))
    if (length(unique(data$loud60)) > 1L)
      lmm_terms(data, thermal_comfort ~ loud60 * utci_z, c('loud60', 'utci_z', 'loud60:utci_z'),
        'Wu 2025', 'TC ~ I(dBA>=60) x UTCI', 'thermal_comfort', ratings[['thermal_comfort']], 'dba',
        'Source: LAeq >= 60 dB(A) exacerbates thermal discomfort; subjective thermal = domain thermal comfort (§2). Cutoff is the published 60 dB(A), not a data-driven knot.')
    for (sound_col in setdiff(sound_cols, 'dba')) {
      data <- cells[complete.cases(cells[, c('thermal_comfort', 'utci', sound_col)]), ]
      if (nrow(data) < 8L || length(unique(data[[sound_col]])) < 2L) next
      knot <- stats::median(data[[sound_col]], na.rm = TRUE)
      data$loud <- as.numeric(data[[sound_col]] >= knot)
      if (length(unique(data$loud)) < 2L) next
      data$utci_z <- as.numeric(scale(data$utci))
      lmm_terms(data, thermal_comfort ~ loud * utci_z, c('loud', 'utci_z', 'loud:utci_z'),
        'Wu 2025', paste('TC ~ high-sound x UTCI |', sound_col), 'thermal_comfort', ratings[['thermal_comfort']], sound_col,
        paste0('Wu 60 dB cutoff analogue: encoding split at median ', format(knot, digits = 4), '. Not LAeq.'))
    }
  }

  test_Xu <- function() {
    # Xu et al. (2026), DOI: 10.1007/s10668-026-08213-4.
    # Source ACV has no significant breakpoint: do not impose the ASV 64.8-dB knot.
    # Linear AC association below is an explicit random-intercept adaptation.
    for (sound_col in sound_cols) {
      data <- cells[complete.cases(cells[, c('acoustic_comfort', sound_col)]), ]
      if (nrow(data) < 8L || length(unique(data[[sound_col]])) < 2L) next
      data$sound_z <- as.numeric(scale(data[[sound_col]]))
      lmm_terms(data, acoustic_comfort ~ sound_z, 'sound_z',
        'Xu 2026', paste('linear AC ~ sound |', sound_col),
        'acoustic_comfort', ratings[['acoustic_comfort']], sound_col,
        'Source ACV declined without a significant breakpoint. Linear participant-LMM adaptation; ASV unrecorded, so the 64.8-dB ASV breakpoint is not fitted to AC.')
    }
    # Source combined-exposure condition: air temperature >32 C AND sound >65 dB.
    # DOI above, section 6.2. UTCI is not substituted for air temperature.
    data <- cells[complete.cases(cells[, c('thermal_comfort', 'air_temp_c', 'dba')]), ]
    data$hot <- as.numeric(data$air_temp_c > 32)
    data$loud <- as.numeric(data$dba > 65)
    counts <- table(factor(data$hot, levels = 0:1), factor(data$loud, levels = 0:1))
    xu_cell_note <<- paste('Xu >32 C air temperature x >65 dBA cell counts (rows cool/hot, columns quieter/louder):', paste(as.vector(t(counts)), collapse = ', '))
    if (all(counts > 0L)) {
      lmm_terms(data, thermal_comfort ~ hot * loud, c('hot', 'loud', 'hot:loud'),
        'Xu 2026', 'TC ~ I(air_temp_c>32) x I(dBA>65)',
        'thermal_comfort', ratings[['thermal_comfort']], 'dba',
        paste('Source >32 C air-temperature / >65 dB combined condition; participant-LMM adaptation to repeated phases, not source CART/SHAP.', xu_cell_note))
    } else {
      xu_cell_note <<- paste(xu_cell_note, '; interaction NOT ESTIMABLE: an empty 2x2 cell aliases the factorial coefficients. No substituted cutoff was searched.')
    }
  }

  test_Zhen <- function() {
    # Zhen et al. (2025), DOI: 10.1016/j.buildenv.2024.112327.
    # Primary dBA model lacks Chen's additional natural-share covariate.
    # Retain that distinct sensitivity; omit duplicate alternative encodings.
    data <- cells[complete.cases(cells[, c('thermal_comfort', 'utci', 'dba')]), ]
    lmm_terms(data, thermal_comfort ~ utci * dba,
      c('utci', 'dba', 'utci:dba'),
      'Zhen 2025', 'TC ~ UTCI x sound | dba', 'thermal_comfort',
      ratings[['thermal_comfort']], 'dba',
      'Source TSV–UTCI stratum slopes: subjective thermal = thermal_comfort (§2). Primary dBA sensitivity omits Chen natural-share covariate. Alternative encodings are canonical Chen fits, not duplicated.')
  }

  test_ZhangSciRep <- function() {
    # Zhang 2026 Sci Rep: TCV ~ AcCV x PET. Aesthetics omitted.
    data <- cells[complete.cases(cells[, c('thermal_comfort', 'acoustic_comfort', 'pet')]), ]
    data$ac_z <- as.numeric(scale(data$acoustic_comfort))
    data$pet_z <- as.numeric(scale(data$pet))
    lmm_terms(data, thermal_comfort ~ ac_z * pet_z, c('ac_z', 'pet_z', 'ac_z:pet_z'),
      'Zhang 2026 SciRep', 'TC ~ AC x PET', 'thermal_comfort', ratings[['thermal_comfort']], 'comfort-domain association (perceived AC x PET)',
      'Source ordered logit TCV ~ AcCV x PET; Gaussian LMM adaptation; aesthetic satisfaction not collected.')
  }

  test_ZhangBSim <- function() {
    # Zhang 2026 Building Simulation: Spearman by site of comfort vs sound. ENVI-met/CadnaA not fitted.
    for (phase in unique(cells$PhaseID)) for (outcome in names(ratings)) {
      data <- cells[cells$PhaseID == phase, ]
      row <- H4_AL$spearman_row(data$dba, data[[outcome]], 'Zhang 2026 BSim',
        paste('Spearman', outcome, 'vs dBA, phase', phase), outcome,
        paste(ratings[[outcome]], 'ucm_SND_dBA', sep = ', '), 'Spearman rho',
        paste('spearman(', outcome, ', dBA) within phase as site analogue'),
        'Source Spearman by historic-space type. ENVI-met/CadnaA/HIA not fitted. Person-mean Spearman.',
        length(unique(data$ParticipantID)), data$ParticipantID)
      row$sound_variable <- 'dba'
      add(row)
    }
  }

  test_Tang <- function() {
    # Tang et al. 2026 Build Environ 114742: physiology ~ dBA x PET; diversity x PET; Kruskal dBA quartiles x PET half.
    tang_physio <- c(hr = 'empatica_heart_rate', sdnn = 'empatica_hrv_td_sdnn', rmssd = 'empatica_hrv_td_rmssd')
    walk <- cells[cells$PhaseID %in% c('WalkG', 'WalkU'), , drop = FALSE]
    pet_med <- stats::median(walk$pet, na.rm = TRUE)
    walk$thermal_stratum <- ifelse(is.finite(walk$pet) & walk$pet >= pet_med, 'warmer', 'cooler')
    for (outcome in names(tang_physio)) {
      col <- outcome
      data <- walk[complete.cases(walk[, c(col, 'dba', 'pet', 'ParticipantID')]), ]
      if (nrow(data) < 8L) next
      data$Y <- data[[col]]
      data$dba_z <- as.numeric(scale(data$dba))
      data$pet_z <- as.numeric(scale(data$pet))
      lmm_terms(data, Y ~ dba_z * pet_z, c('dba_z', 'pet_z', 'dba_z:pet_z'),
        'Tang 2026', paste('Physiology ~ dBA x PET |', outcome), outcome, tang_physio[[outcome]], 'dba',
        'Source outdoor playback factorial not reproduced. Pooled field LMM on 8-min phase means; Wald t replaces ANOVA; PET stratum per source.')
      if (any(is.finite(walk$soundscape_diversity))) {
        d2 <- walk[complete.cases(walk[, c(col, 'soundscape_diversity', 'pet')]), ]
        if (nrow(d2) >= 8L && length(unique(d2$soundscape_diversity)) > 1L) {
          d2$Y <- d2[[col]]
          d2$div_z <- as.numeric(scale(d2$soundscape_diversity))
          d2$pet_z <- as.numeric(scale(d2$pet))
          lmm_terms(d2, Y ~ div_z * pet_z, c('div_z', 'pet_z', 'div_z:pet_z'),
            'Tang 2026', paste('Physiology ~ Shannon diversity x PET |', outcome), outcome, tang_physio[[outcome]], 'YAMNet proportion entropy (phase)',
            'Soundscape diversity = Shannon entropy of phase-mean YAMNet class shares; not source SDI from labelled sources.')
        }
      }
      for (stratum in c('cooler', 'warmer')) {
        d <- walk[walk$thermal_stratum == stratum & is.finite(walk[[col]]), ]
        if (nrow(d) < 4L) next
        br <- stats::quantile(d$dba, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)
        br <- unique(br[is.finite(br)])
        if (length(br) < 3L) next
        d$dba_q <- cut(d$dba, br, include.lowest = TRUE)
        row <- h4_kruskal_row(d[[col]], d$dba_q, 'Tang 2026',
          paste('Kruskal-Wallis physiology across dBA quartiles |', stratum, '|', outcome),
          outcome, tang_physio[[outcome]], 'dba',
          paste('Source one-way ANOVA/Kruskal across six assigned soundscapes within PET stratum;', stratum, 'PET split at median. Field dBA quartiles.'))
        row$n_participants <- length(unique(d$ParticipantID))
        add(row)
      }
    }
  }

  test_Peng <- function() {
    # Peng et al. 2026 Urban Sci 10:60: Kruskal WalkG vs WalkU; Spearman VE/AE/TE; OC regression analogue.
    comfort_cols <- c('thermal_comfort', 'acoustic_comfort', 'visual_comfort', 'overall_comfort')
    phase_ratings <- attr(cells, 'ratings')
    walk <- cells[cells$PhaseID %in% c('WalkG', 'WalkU'), , drop = FALSE]
    for (var in c('dba', 'utci', comfort_cols)) {
      data <- walk[!is.na(walk$PhaseID) & is.finite(walk[[var]]), ]
      if (nrow(data) < 4L) next
      row <- h4_kruskal_row(data[[var]], data$PhaseID, 'Peng 2026',
        paste('Kruskal-Wallis WalkG vs WalkU |', var), var,
        if (var %in% names(phase_ratings)) phase_ratings[[var]] else var,
        if (var == 'dba') 'dba' else 'phase context (not sound level)',
        'WalkG and WalkU only (item 6); source Kruskal on openness groups.')
      row$n_participants <- length(unique(data$ParticipantID))
      add(row)
    }
  for (pair in list(c('thermal_comfort', 'acoustic_comfort'), c('thermal_comfort', 'visual_comfort'),
                    c('acoustic_comfort', 'visual_comfort'), c('acoustic_comfort', 'dba'), c('thermal_comfort', 'dba'))) {
    if (!all(pair %in% names(cells))) next
    row <- H4_AL$spearman_row(walk[[pair[1]]], walk[[pair[2]]], 'Peng 2026',
      paste('Spearman', pair[1], 'vs', pair[2]), pair[1],
      paste(phase_ratings[[pair[1]]], pair[2], sep = ', '), 'Spearman rho',
      paste('spearman(', pair[1], ',', pair[2], ') on phase cells'),
      'Source Spearman among VE/AE/TE and behaviour; participant-mean adaptation.',
      length(unique(walk$ParticipantID)), walk$ParticipantID)
    row <- H4_AL$attach_sound(row, if (pair[2] == 'dba') 'dba' else 'comfort-domain association (no measured sound predictor)')
    add(row)
  }
    data <- walk[complete.cases(walk[, c('overall_comfort', 'thermal_comfort', 'acoustic_comfort', 'visual_comfort', 'ParticipantID')]), ]
    if (nrow(data) >= 8L) {
      lmm_terms(data, overall_comfort ~ thermal_comfort + acoustic_comfort + visual_comfort,
        c('thermal_comfort', 'acoustic_comfort', 'visual_comfort'),
        'Peng 2026', 'OC ~ thermal + acoustic + visual votes', 'overall_comfort', phase_ratings[['overall_comfort']],
        'comfort-domain association (no measured sound predictor)',
        'Source multiple regression of observed behaviour on VE/AE/TE; behaviour not collected — OC ~ votes analogue.')
    }
  }

  test_Simsek <- function() {
    # Simsek 2026 SREES 11113: Pearson within WalkG/WalkU; pooled LMM on walk cells.
    phase_ratings <- attr(cells, 'ratings')
    walk <- cells[cells$PhaseID %in% c('WalkG', 'WalkU'), , drop = FALSE]
    preds <- c(dba = 'ucm_SND_dBA', utci = 'ucm_UTCI', rh = 'ucm_AIR_RH', wind_aws = 'ucm_WIND_AWS')
    for (phase in c('WalkG', 'WalkU')) {
      data <- walk[walk$PhaseID == phase & is.finite(walk$acoustic_comfort), ]
      np <- length(unique(data$ParticipantID))
      for (pred in names(preds)) {
        if (!pred %in% names(data)) next
        add(h4_pearson_row(data[[pred]], data$acoustic_comfort, 'Simsek 2026',
          paste('Pearson AC vs', pred, 'within phase', phase), 'acoustic_comfort', pred,
          phase_ratings[['acoustic_comfort']], if (pred == 'dba') 'dba' else pred,
          paste('Source stage-1 Pearson within park analogue;', phase, 'n =', nrow(data), 'phase cells.'),
          np))
      }
    }
    use_preds <- intersect(names(preds), names(cells))
    need <- c('acoustic_comfort', use_preds, 'ParticipantID')
    data <- walk[complete.cases(walk[, need]), ]
    if (nrow(data) >= 8L) {
      for (pred in use_preds) data[[paste0(pred, '_z')]] <- as.numeric(scale(data[[pred]]))
      rhs <- paste(paste0(use_preds, '_z'), collapse = ' + ')
      form <- stats::as.formula(paste('acoustic_comfort ~', rhs))
      terms <- paste0(use_preds, '_z')
      lmm_terms(data, form, terms, 'Simsek 2026', 'AC ~ multivariate env (LMM)', 'acoustic_comfort',
        phase_ratings[['acoustic_comfort']], 'dba',
        paste('Source stage-2 multiple regression of auditory comfort on SPL, thermal and wind;',
          'vertical illuminance absent; participant intercept adapts to repeated phases.'))
    }
  }

  # Explicit paper order, also callable one paper at a time from the entry script.
  xu_cell_note <- 'Xu combined-condition block not requested.'
  for (paper in papers) {
    switch(paper,
      Qin = test_Qin(),
      Mohammadzadeh = test_Mohammadzadeh(),
      Gao = test_Gao(),
      Wu = test_Wu(),
      Xu = test_Xu(),
      Zhen = test_Zhen(),
      ZhangSciRep = test_ZhangSciRep(),
      ZhangBSim = test_ZhangBSim(),
      Tang = test_Tang(),
      Peng = test_Peng(),
      Simsek = test_Simsek(),
      stop('Unknown outdoor paper: ', paper)
    )
  }

  note_lines <- list(
    Tang = '- Tang2026: WalkG/WalkU. LMM physiology ~ z(dBA)*z(PET) and ~ z(Shannon diversity)*z(PET); Kruskal-Wallis dBA quartiles within median PET half.',
    Peng = '- Peng2026: WalkG/WalkU. Kruskal-Wallis; Spearman among votes and dBA; LMM OC ~ thermal + acoustic + visual.',
    Simsek = '- Simsek2026: WalkG/WalkU. Pearson AC vs dBA/UTCI/RH/wind within phase; LMM AC ~ z(env predictors).')
  notes <- c('', '## Outdoor replications (this run)', unlist(note_lines[intersect(names(note_lines), papers)]))
  list(results = if (length(results)) do.call(rbind, results) else data.frame(), notes = notes)
}

h4_additional_outdoor_tests <- function(epochs, papers = c('Cureau', 'Chen'), include_scopus = TRUE) {
  thermal_comfort_col <- 'questionnaire_thermal_comfort_1_5'
  acoustic_comfort_col <- 'questionnaire_acoustic_comfort_1_5'
  visual_comfort_col <- 'questionnaire_visual_comfort_1_5'
  overall_comfort_col <- 'questionnaire_current_comfort_1_7'
  ratings <- c(
    thermal_comfort = thermal_comfort_col,
    acoustic_comfort = acoustic_comfort_col,
    visual_comfort = visual_comfort_col,
    overall_comfort = overall_comfort_col)
  cells <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
    frame <- data.frame(
      ParticipantID = as.character(epochs$ParticipantID[rows[1]]),
      PhaseID = as.character(epochs$PhaseID[rows[1]]),
      utci = H4_UTIL$finite_mean(epochs$ucm_UTCI[rows]),
      dba = H4_UTIL$energy_mean_db(epochs$ucm_SND_dBA[rows]),
      nature = H4_UTIL$finite_mean(epochs$rural_natural_proportion[rows]),
      sound_corridor_urban = H4_UTIL$finite_mean(if ('sound_corridor_urban' %in% names(epochs)) epochs$sound_corridor_urban[rows] else NA_real_),
      sound_yamnet_majority_traffic = H4_UTIL$finite_mean(if ('sound_yamnet_majority_traffic' %in% names(epochs)) epochs$sound_yamnet_majority_traffic[rows] else NA_real_),
      thermal_comfort = H4_UTIL$finite_mean(epochs[[thermal_comfort_col]][rows]),
      acoustic_comfort = H4_UTIL$finite_mean(epochs[[acoustic_comfort_col]][rows]),
      visual_comfort = H4_UTIL$finite_mean(epochs[[visual_comfort_col]][rows]),
      overall_comfort = H4_UTIL$finite_mean(epochs[[overall_comfort_col]][rows]))
    for (col in intersect(H4_SOUND$category, names(epochs))) frame[[col]] <- H4_UTIL$finite_mean(epochs[[col]][rows])
    frame
  }))
  results <- list()
  make_row <- function(paper, test, outcome, term, estimate = NA_real_, se = NA_real_, low = NA_real_, high = NA_real_,
                       stat = NA_real_, df = NA_real_, p = NA_real_, n = 0L, np = 0L, statistic_test, model_id, note,
                       sound_variable = 'measured dBA / acoustic comfort / nature share') {
    data.frame(
      paper = paper, test = test, outcome = outcome, source_column = ratings[[outcome]], term = term,
      estimate = estimate, se = se, ci_low = low, ci_high = high, statistic = stat, df = df, p = p,
      n_observations = n, n_participants = np, statistic_test = statistic_test,
      paper_rule = 'p < 0.05', paper_rule_met = if (is.finite(p)) p < .05 else NA,
      transformation = 'raw questionnaire score', term_units = 'see model_details',
      model_id = model_id, model_details = note, sound_variable = sound_variable)
  }

  if ('Cureau' %in% papers) {
  # ---------------------------------------------------------------------------
  # Cureau, Pigliautile, Pioppi and Pisello (2022). Int J Biometeorol.
  # Source: Fisher exact tests between comfort-domain categories, separately by park.
  # Phase is the site analogue. Each participant contributes once within each test.
  # ---------------------------------------------------------------------------
  for (phase in unique(cells$PhaseID)) {
    for (pair in combn(names(ratings), 2, simplify = FALSE)) {
      data <- cells[cells$PhaseID == phase & is.finite(cells[[pair[1]]]) & is.finite(cells[[pair[2]]]), ]
      contingency <- table(data[[pair[1]]], data[[pair[2]]])
      fit <- if (nrow(contingency) > 1L && ncol(contingency) > 1L) {
        tryCatch(fisher.test(contingency, workspace = 2e7), error = function(e) e)
      } else simpleError('Only one observed response category')
      results[[length(results) + 1L]] <- make_row(
        'Cureau 2022', paste('Fisher exact comfort-domain association, phase', phase),
        pair[1], pair[2],
        p = if (inherits(fit, 'error')) NA_real_ else fit$p.value,
        n = nrow(data), np = length(unique(data$ParticipantID)),
        statistic_test = 'Fisher exact test (contingency-table association)',
        model_id = paste(pair, collapse = ' versus '),
        note = paste(
          'Cureau et al. 2022. Source Fisher exact method; phase treated as site; six domain pairs per phase.',
          'Overall item is 7-point here, 5-point in source.',
          if (inherits(fit, 'error')) conditionMessage(fit) else ''),
        sound_variable = 'comfort-domain association (no measured sound predictor)')
    }
  }

  }

  if ('Chen' %in% papers) {
  # ---------------------------------------------------------------------------
  # Chen, Chen, Lin et al. (2023). Forests 14(6):1161.
  # Source RM-ANOVA with ranked dominant-source factor cannot be reconstructed.
  # Adaptation: rating ~ zUTCI * zdBA + zNaturalShare + (1|participant).
  # ---------------------------------------------------------------------------
  for (outcome in c('thermal_comfort', 'acoustic_comfort', 'overall_comfort')) {
    data <- cells[complete.cases(cells[, c(outcome, 'utci', 'dba', 'nature')]), ]
    data$utci_z <- as.numeric(scale(data$utci))
    data$dba_z <- as.numeric(scale(data$dba))
    data$nature_z <- as.numeric(scale(data$nature))
    data$ParticipantID <- factor(data$ParticipantID)
    fit <- tryCatch(
      nlme::lme(reformulate(c('utci_z * dba_z', 'nature_z'), response = outcome), data = data,
        random = ~ 1 | ParticipantID, method = 'REML', na.action = na.fail,
        control = nlme::lmeControl(opt = 'optim', returnObject = FALSE)),
      error = function(e) e)
    for (term in c('utci_z', 'dba_z', 'nature_z', 'utci_z:dba_z')) {
      coefficient <- if (!inherits(fit, 'error') && term %in% rownames(summary(fit)$tTable)) summary(fit)$tTable[term, ] else rep(NA_real_, 5)
      critical <- if (is.finite(coefficient[3])) qt(.975, coefficient[3]) else NA_real_
      results[[length(results) + 1L]] <- make_row(
        'Chen 2023 (adapted)', paste('Continuous participant LMM:', term), outcome, term,
        coefficient[1], coefficient[2], coefficient[1] - critical * coefficient[2], coefficient[1] + critical * coefficient[2],
        coefficient[4], coefficient[3], coefficient[5], nrow(data), nlevels(data$ParticipantID),
        't-test (random-intercept LMM coefficient)',
        paste(outcome, '~ utci_z * dba_z + nature_z + (1|ParticipantID)'),
        paste(
          'Chen et al. 2023 Forests 14:1161. Adaptation, NOT the published ANOVA.',
          'Natural share substitutes for unavailable ranked dominant-source factor.',
          if (inherits(fit, 'error')) conditionMessage(fit) else ''),
        sound_variable = 'dba')
    }
  }
  chen_other <- intersect(c('sound_corridor_urban', 'sound_yamnet_majority_traffic', H4_SOUND$category), names(cells))
  for (sound_col in chen_other) {
    for (outcome in c('thermal_comfort', 'acoustic_comfort', 'overall_comfort')) {
      data <- cells[complete.cases(cells[, c(outcome, 'utci', sound_col)]), ]
      if (!nrow(data) || length(unique(data[[sound_col]])) < 2L) next
      data$utci_z <- as.numeric(scale(data$utci))
      data$sound_z <- as.numeric(scale(data[[sound_col]]))
      data$ParticipantID <- factor(data$ParticipantID)
      fit <- tryCatch(
        nlme::lme(reformulate('utci_z * sound_z', response = outcome), data = data,
          random = ~ 1 | ParticipantID, method = 'REML', na.action = na.fail,
          control = nlme::lmeControl(opt = 'optim', returnObject = FALSE)),
        error = function(e) e)
      for (term in c('utci_z', 'sound_z', 'utci_z:sound_z')) {
        coefficient <- if (!inherits(fit, 'error') && term %in% rownames(summary(fit)$tTable)) summary(fit)$tTable[term, ] else rep(NA_real_, 5)
        critical <- if (is.finite(coefficient[3])) qt(.975, coefficient[3]) else NA_real_
        results[[length(results) + 1L]] <- make_row(
          'Chen 2023 (adapted)', paste('Continuous participant LMM:', term, '|', sound_col), outcome, term,
          coefficient[1], coefficient[2], coefficient[1] - critical * coefficient[2], coefficient[1] + critical * coefficient[2],
          coefficient[4], coefficient[3], coefficient[5], nrow(data), nlevels(data$ParticipantID),
          't-test (random-intercept LMM coefficient)',
          paste(outcome, '~ utci_z * sound_z + (1|ParticipantID); sound =', sound_col),
          paste('Chen 2023 adaptation with', sound_col, 'in place of dBA. Not the published ANOVA.',
            if (inherits(fit, 'error')) conditionMessage(fit) else ''),
          sound_variable = sound_col)
      }
    }
  }

  }

  # Ueberham et al. (2019): not fitted (no subjective exposure-intensity items).
  # Li, Li and Wang (2025): not fitted (no arrival/departure or SLV).

  notes <- c('',
    '## Additional outdoor papers (verified 2026-11-06)',
    '- Cureau2022: Fisher exact comfort-domain method by phase/site analogue. Seven-point overall comfort differs from source five-point item. No independent-local-sample Mann-Whitney; this cohort is paired.',
    '- Cureau2022 multinomial models NOT copied.',
    '- Chen2023: continuous participant-LMM adaptation rating ~ zUTCI * zdBA + zNaturalShare + (1|ParticipantID), plus encodings 2-4 without the nature-share term. Not the published ANOVA.',
    '- Ueberham2019: subjective exposure-intensity items absent; NOT fitted.',
    '- Li2025: arrival/departure and subjective loudness not collected; NOT fitted.',
    '- New model and outcome choices are post-hoc additions; source p<.05 decision rule per row (no catalogue-wide BH in H4_sound_literature_test.R).')
  extra <- if (include_scopus) h4_scopus_outdoor_tests(epochs) else list(results = data.frame(), notes = character())
  list(results = rbind(do.call(rbind, results), extra$results), notes = c(notes, extra$notes))
}

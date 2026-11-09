# Source-inspired outdoor methods; equivalent Chen specifications are not fitted twice.
# Li 2025 and Jin 2020 chamber playback are documented, not fitted.
# Catalog columns stay: paper, test, outcome, source_column, term, estimate, se, ci_low, ci_high,
# statistic, df, p, n_observations, n_participants, statistic_test, paper_rule, paper_rule_met,
# transformation, term_units, model_id, model_details, sound_variable.

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
    Tang = '- Tang2026: WalkG/WalkU. LMM physiology ~ z(dBA)*z(UTCI) and ~ z(Shannon diversity)*z(UTCI); Kruskal-Wallis dBA quartiles within median UTCI half.',
    Peng = '- Peng2026: WalkG/WalkU. Kruskal-Wallis; Spearman among votes and dBA; LMM OC ~ thermal + acoustic + visual.',
    Simsek = '- Simsek2026: WalkG/WalkU. Pearson AC vs dBA/UTCI/RH/wind within phase; LMM AC ~ z(env predictors).')
  notes <- c('', '## Outdoor replications (this run)', unlist(note_lines[intersect(names(note_lines), papers)]))
  list(results = if (length(results)) do.call(rbind, results) else data.frame(), notes = notes)
}

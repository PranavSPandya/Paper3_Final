# Additional outdoor comfort methods, verified against saved full-text PDFs.
# Cureau and Chen are written as separate paper blocks. Scopus papers are in
# H4_scopus_outdoor_methods.R and are appended at the end.
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
    '- New model and outcome choices are post-hoc additions. BH within paper/test; source p<.05 decision rule retained.')
  extra <- if (include_scopus) h4_scopus_outdoor_tests(epochs) else list(results = data.frame(), notes = character())
  list(results = rbind(do.call(rbind, results), extra$results), notes = c(notes, extra$notes))
}

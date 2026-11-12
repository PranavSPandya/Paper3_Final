# H4: replication tests aligned with documents/H4_papers_screened_final.md (item 9).
# WalkG/WalkU where item 6 specifies walking; core four phases only; no FDR or encoding sweeps.

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run this file with Rscript')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
library_dir <- file.path(dirname(.entry), 'library')
code_paths <- c(.entry, file.path(library_dir, c('Paper3_common.R', 'H4_sound_literature_helpers.R')))
code_fingerprints <- tools::md5sum(code_paths)
source(code_paths[2], local = FALSE)
source(code_paths[3], local = FALSE)
if (!requireNamespace('nlme', quietly = TRUE)) stop('Required package missing: nlme')
suppressPackageStartupMessages(library(nlme))

root <- resolve_project_root()
analysis_phases <- PAPER3_CORE_PHASES
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_sound_literature_test')
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs <- read.csv(input, check.names = FALSE)
epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% analysis_phases, ]
epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = 'UTC')
stopifnot(!anyNA(epochs$Datetime), !anyDuplicated(epochs[c('ParticipantID', 'PhaseID', 'Datetime')]))
epochs <- epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
stopifnot(setequal(unique(epochs$ParticipantID), PAPER3_PARTICIPANTS))
stopifnot(length(H4_UTIL$bouts(epochs)) == length(PAPER3_PARTICIPANTS) * length(analysis_phases))

outcomes <- paper3_physiological_outcomes()
hrv_available <- tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c('true', '1')
for (column_name in attr(outcomes, 'empatica_hrv_fd_window')) epochs[[column_name]][!hrv_available] <- NA_real_

ratings <- c(thermal_comfort = 'questionnaire_thermal_comfort_1_5',
  acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
  visual_comfort = 'questionnaire_visual_comfort_1_5',
  overall_comfort = 'questionnaire_current_comfort_1_7')
cells_all <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
  cell <- data.frame(ParticipantID = epochs$ParticipantID[rows[1]], PhaseID = epochs$PhaseID[rows[1]],
    utci = H4_UTIL$finite_mean(epochs$ucm_UTCI[rows]),
    dba = H4_UTIL$energy_mean_db(epochs$ucm_SND_dBA[rows]))
  for (outcome in names(ratings)) {
    values <- unique(epochs[[ratings[[outcome]]]][rows])
    values <- values[is.finite(values)]
    if (length(values) > 1L) stop('More than one phase rating: ', outcome, ', ', cell$ParticipantID, ', ', cell$PhaseID)
    cell[[outcome]] <- if (length(values)) values[1] else NA_real_
  }
  cell
}))
cells_walk <- cells_all[cells_all$PhaseID %in% H4_PHASE_WALK, , drop = FALSE]

source_papers <- c(
  Rodrigues = 'H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf',
  Jin = 'H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf',
  Cureau = 'Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf',
  Wu = 'Sound_evidence/Sound - Wu2025 - thermal acoustic overall comfort cold-region parks.pdf',
  Xu = 'Sound_evidence/Sound - Xu2026 - threshold thermal-acoustic urban public spaces.pdf')
source_paths <- file.path(root, 'Experiment papers', source_papers)
if (!all(file.exists(source_paths))) stop('Verified source PDF missing: ', paste(source_papers[!file.exists(source_paths)], collapse = '; '))
source_fingerprints <- tools::md5sum(source_paths)
results <- list()
fit_notes <- character()

result_row <- function(paper, test, outcome, predictor, data, estimate = NA_real_, se = NA_real_,
                       ci = c(NA_real_, NA_real_), statistic = NA_real_, df = NA, p = NA_real_,
                       statistic_test, model, note, sound_variable = 'ucm_SND_dBA') {
  data.frame(paper = paper, test = test, outcome = outcome,
    source_column = unname(ratings[outcome]), term = predictor,
    estimate = estimate, se = se, ci_low = ci[1], ci_high = ci[2], statistic = statistic, df = df, p = p,
    n_observations = nrow(data), n_participants = length(unique(data$ParticipantID)),
    statistic_test = statistic_test, paper_rule = 'p < 0.05',
    paper_rule_met = if (is.finite(p)) p < 0.05 else NA,
    transformation = 'raw questionnaire score', term_units = 'see model_details',
    model_id = model, model_details = note, sound_variable = sound_variable)
}

# Rodrigues 2026 — WalkG/WalkU trip LMM (item 9).
rodrigues_block <- H4_RODRIGUES$run(epochs, nlme::lmeControl(opt = 'optim'))
rodrigues_block$results$sound_variable <- 'ucm_SND_dBA'
rodrigues_block$results$model_details <- paste(rodrigues_block$results$model_details,
  'Source H2 thematic model; WalkU/WalkG only.')
results$rodrigues <- rodrigues_block$results

# Jin 2020 — Type-II ANOVA on walk cells (item 9).
jin <- cells_walk
finite_sound <- jin$dba[is.finite(jin$dba)]
if (!length(finite_sound)) stop('Jin: no finite sound measurements')
sound_breaks <- seq(min(55, 5 * floor(min(finite_sound) / 5)),
  max(75, 5 * (floor(max(finite_sound) / 5) + 1)), by = 5)
jin$sound_level <- cut(jin$dba, sound_breaks, right = FALSE, include.lowest = TRUE)
jin$thermal_level <- cut(jin$utci, c(-Inf, -40, -27, -13, 0, 9, 26, 32, 38, 46, Inf), right = FALSE)
jin_rows <- list()
for (outcome in c('thermal_comfort', 'acoustic_comfort', 'overall_comfort')) {
  data <- droplevels(jin[complete.cases(jin[c(outcome, 'sound_level', 'thermal_level')]), ])
  data$ParticipantID <- factor(data$ParticipantID)
  if (nrow(data) < 2L || nlevels(data$sound_level) < 2L || nlevels(data$thermal_level) < 2L) {
    fit_notes <- c(fit_notes, paste('Jin 2020:', outcome, 'fewer than two observed levels in a required factor; not estimable.'))
    next
  }
  anova_table <- H4_JIN$anova_type2(data[[outcome]], data$sound_level, data$thermal_level, data$ParticipantID)
  if (is.null(anova_table)) next
  observed <- table(data$sound_level, data$thermal_level)
  nominal_df <- (nlevels(data$sound_level) - 1L) * (nlevels(data$thermal_level) - 1L)
  support <- sprintf('%d walk phase cells; %d of %d band x category cells empty; interaction rank df %s of nominal %d.',
    nrow(data), sum(observed == 0), length(observed), anova_table$df_term[3], nominal_df)
  for (index in seq_len(nrow(anova_table))) {
    estimable <- is.finite(anova_table$p[index])
    if (!estimable) fit_notes <- c(fit_notes, paste('Jin 2020:', outcome, anova_table$effect[index],
      'not identifiable (rank df', anova_table$df_term[index], ', residual df', anova_table$df_resid[index], '); not fitted.', support))
    jin_rows[[length(jin_rows) + 1L]] <- result_row('Jin 2020',
      'Two-way ANOVA: source-spaced sound bands x UTCI stress categories', outcome, anova_table$effect[index], data,
      statistic = anova_table$F[index], df = paste(anova_table$df_term[index], anova_table$df_resid[index], sep = ', '),
      p = anova_table$p[index],
      statistic_test = if (index < 3) 'f-test (Type-II main effect, participant block, full-model error)' else 'f-test (estimable interaction vs additive model, participant block, full-model error)',
      model = paste(outcome, '~ ParticipantID + sound_level * thermal_level'),
      note = paste('WalkG/WalkU only. Source 5-dB spacing; participant blocking is adaptation.', support))
  }
}
if (length(jin_rows)) results$jin <- do.call(rbind, jin_rows)
fit_notes <- c(fit_notes, 'Jin observed sound x UTCI category counts (walk only):',
  capture.output(print(table(droplevels(jin$sound_level), droplevels(jin$thermal_level)))))

# Cureau 2022 — Fisher exact per WalkG and WalkU (item 9).
cureau_rows <- list()
for (phase in H4_PHASE_WALK) {
  for (pair in combn(names(ratings), 2, simplify = FALSE)) {
    data <- cells_walk[cells_walk$PhaseID == phase & complete.cases(cells_walk[pair]), ]
    contingency <- table(data[[pair[1]]], data[[pair[2]]])
    fit <- if (nrow(contingency) > 1L && ncol(contingency) > 1L)
      tryCatch(fisher.test(contingency, workspace = 2e7), error = function(error) error)
    else simpleError('Only one observed response category')
    cureau_rows[[length(cureau_rows) + 1L]] <- result_row('Cureau 2022',
      paste('Fisher exact comfort-domain association, phase', phase), pair[1], pair[2], data,
      p = if (inherits(fit, 'error')) NA_real_ else fit$p.value,
      statistic_test = 'Fisher exact test (contingency-table association)',
      model = paste(pair, collapse = ' versus '),
      note = paste('Published Fisher exact method. Phase is the site analogue.',
        if (inherits(fit, 'error')) conditionMessage(fit) else ''),
      sound_variable = 'comfort-domain association (no measured sound predictor)')
  }
}
results$cureau <- do.call(rbind, cureau_rows)

# Wu 2025 — published objective and subjective OC models on walk cells (item 9).
wu_rows <- list()
wu_models <- list(objective = overall_comfort ~ utci + dba,
                  subjective = overall_comfort ~ thermal_comfort + acoustic_comfort)
for (model_name in names(wu_models)) {
  formula <- wu_models[[model_name]]
  data <- cells_walk[complete.cases(cells_walk[all.vars(formula)]), ]
  data$ParticipantID <- factor(data$ParticipantID)
  fit <- tryCatch(nlme::lme(formula, random = ~ 1 | ParticipantID, data = data,
    method = 'REML', control = nlme::lmeControl(opt = 'optim')), error = function(error) error)
  for (predictor in attr(terms(formula), 'term.labels')) {
    coefficient <- if (!inherits(fit, 'error')) summary(fit)$tTable[predictor, ] else
      setNames(rep(NA_real_, 5), c('Value', 'Std.Error', 'DF', 't-value', 'p-value'))
    critical <- if (is.finite(coefficient['DF'])) qt(0.975, coefficient['DF']) else NA_real_
    wu_rows[[length(wu_rows) + 1L]] <- result_row('Wu 2025',
      paste('Published', model_name, 'additive predictor set'), 'overall_comfort', predictor, data,
      estimate = unname(coefficient['Value']),
      se = unname(coefficient['Std.Error']),
      ci = unname(coefficient['Value'] + c(-1, 1) * critical * coefficient['Std.Error']),
      statistic = unname(coefficient['t-value']), df = unname(coefficient['DF']), p = unname(coefficient['p-value']),
      statistic_test = 't-test (mixed regression coefficient; participant intercept)',
      model = paste(deparse(formula), collapse = ' '),
      note = paste('WalkG/WalkU only. Wu source equations 1/4 predictor sets.',
        if (inherits(fit, 'error')) conditionMessage(fit) else ''),
      sound_variable = if (model_name == 'objective') 'ucm_SND_dBA' else 'perceived acoustic comfort')
  }
}
results$wu <- do.call(rbind, wu_rows)

# Xu 2026 — Pearson within WalkG and WalkU (item 9).
xu_rows <- list()
for (phase in H4_PHASE_WALK) {
  for (outcome in c('thermal_comfort', 'acoustic_comfort')) {
    data <- cells_walk[cells_walk$PhaseID == phase & complete.cases(cells_walk[c('dba', outcome)]), ]
    fit <- if (nrow(data) >= 3L && sd(data$dba) > 0 && sd(data[[outcome]]) > 0)
      cor.test(data$dba, data[[outcome]], method = 'pearson') else NULL
    xu_rows[[length(xu_rows) + 1L]] <- result_row('Xu 2026',
      'Pearson sound-comfort association (phase-stratified)', outcome, paste('dBA, phase', phase), data,
      estimate = if (!is.null(fit)) unname(fit$estimate) else NA_real_,
      ci = if (!is.null(fit) && !is.null(fit$conf.int)) unname(fit$conf.int) else c(NA_real_, NA_real_),
      statistic = if (!is.null(fit)) unname(fit$statistic) else NA_real_,
      df = if (!is.null(fit)) unname(fit$parameter) else NA_real_,
      p = if (!is.null(fit)) fit$p.value else NA_real_,
      statistic_test = 'Pearson correlation t-test (two-sided)',
      model = paste('Pearson(', outcome, ', dBA) within', phase),
      note = if (is.null(fit)) 'not estimable (fewer than 3 people or no variation).' else 'Source Table 3-style Pearson; no threshold/CART/SHAP.')
  }
}
results$xu <- do.call(rbind, xu_rows)

# Tang, Peng, Simsek — scopus block (item 9); YAMNet corridor flag for diversity if present.
epochs_walk <- epochs[epochs$PhaseID %in% H4_PHASE_WALK, , drop = FALSE]
epochs_walk <- H4_SOUND$attach_encodings(epochs_walk)
source(file.path(library_dir, 'H4_scopus_outdoor_methods.R'), local = FALSE)
scopus_new <- h4_scopus_outdoor_tests(epochs_walk, papers = c('Tang', 'Peng', 'Simsek'))
if (nrow(scopus_new$results)) {
  results$tang_peng_simsek <- scopus_new$results
  fit_notes <- c(fit_notes, scopus_new$notes)
}

results <- Filter(function(block) is.data.frame(block) && nrow(block), results)
catalog <- do.call(H4_REPORT$catalog, results)
stopifnot(all(is.finite(catalog$p)), all(catalog$p >= 0 & catalog$p <= 1))

notes <- c('# H4 literature replications (screened guide item 9)',
  paste('Phases:', paste(analysis_phases, collapse = ', '), '; walk-only papers use', paste(H4_PHASE_WALK, collapse = ', ')),
  paste('Input MD5:', unname(input_fingerprint)),
  paste('Code MD5:', basename(code_paths), unname(code_fingerprints)),
  paste('Source PDF MD5:', source_papers, unname(source_fingerprints)),
  '', '## Methods',
  '- Rodrigues: trip LMM on WalkG/WalkU. Jin/Cureau/Wu/Xu: walk cells only.',
  '- Tang/Peng/Simsek: H4_scopus_outdoor_methods replication block.',
  '- No Benjamini-Hochberg correction; each row uses the paper_rule (typically p < 0.05).',
  '', '## Fit and support notes', fit_notes,
  H4_REPORT$not_estimable_notes(attr(catalog, 'not_estimable')))

if (!identical(unname(tools::md5sum(code_paths)), unname(code_fingerprints))) stop('H4 code changed during run')
if (!identical(unname(tools::md5sum(input)), unname(input_fingerprint))) stop('Merged input changed during run')
if (!identical(unname(tools::md5sum(source_paths)), unname(source_fingerprints))) stop('Source PDFs changed during run')
staged_outdir <- tempfile('H4_results_')
dir.create(staged_outdir, recursive = TRUE)
write.csv(catalog[setdiff(names(catalog), c('paper_rule_met', 'model_details'))],
  file.path(staged_outdir, 'H4_sound_literature_tests.csv'), row.names = FALSE, na = '')
writeLines(notes, file.path(staged_outdir, 'METHODS_NOTES.md'))
p3_finalize_directory(staged_outdir)
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
output_files <- list.files(staged_outdir, full.names = TRUE)
stopifnot(length(output_files) == 2L)
if (!all(file.copy(output_files, outdir, overwrite = TRUE))) stop('Failed to publish H4 files')
cat('Done:', outdir, paste(basename(output_files), collapse = ', '), '\n')

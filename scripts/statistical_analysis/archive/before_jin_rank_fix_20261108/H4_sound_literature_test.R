# H4: verified, feasible tests from the original sound papers.
# No automatic predictor substitutions, threshold search, or exposure-based exclusions.
# Run with Rscript; optional flags: --include-tram, --additional-only.
# This is a partial methodological replication, not replication of the source experiments.

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
include_tram <- '--include-tram' %in% commandArgs(TRUE)
additional_only <- '--additional-only' %in% commandArgs(TRUE)
analysis_phases <- c(PAPER3_CORE_PHASES, if (include_tram) 'Tram')
outdir <- file.path(root, 'output', 'statistical_analysis', 'results',
  paste0('H4_sound_literature_test', if (additional_only) '_outdoor', if (include_tram) '_tram'))
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs <- read.csv(input, check.names = FALSE)
epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% analysis_phases, ]
epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = 'UTC')
stopifnot(!anyNA(epochs$Datetime), !anyDuplicated(epochs[c('ParticipantID', 'PhaseID', 'Datetime')]))
epochs <- epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
stopifnot(setequal(unique(epochs$ParticipantID), PAPER3_PARTICIPANTS))
stopifnot(length(H4_UTIL$bouts(epochs)) == length(PAPER3_PARTICIPANTS) * length(analysis_phases))

# Frequency-domain HRV remains unavailable where its original 5-min estimate failed QC.
outcomes <- paper3_physiological_outcomes()
hrv_available <- tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c('true', '1')
for (column_name in attr(outcomes, 'empatica_hrv_fd_window')) epochs[[column_name]][!hrv_available] <- NA_real_

ratings <- c(thermal_comfort = 'questionnaire_thermal_comfort_1_5',
  acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
  visual_comfort = 'questionnaire_visual_comfort_1_5',
  overall_comfort = 'questionnaire_current_comfort_1_7')
cells <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
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

# Original PDFs checked directly, rather than relying on the screened guide.
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

# Shared result formatting only; each paper below specifies its own statistical test.
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

if (!additional_only) {
  # Rodrigues et al. (2026), J Urban Health; doi:10.1007/s11524-025-01051-1.
  # Statistical Analysis, pp. 348-349: separate thematic mixed-model blocks.
  # Walking trips: physiology ~ z(noise maximum) + z(noise SD) + participant intercept.
  # A separate temperature block is retained because it is explicitly in the source.
  # Trip summaries and available physiological counterparts differ from source devices.
  rodrigues_block <- H4_RODRIGUES$run(epochs, nlme::lmeControl(opt = 'optim'))
  rodrigues_block$results$sound_variable <- 'ucm_SND_dBA'
  rodrigues_block$results$model_details <- paste(rodrigues_block$results$model_details,
    'Source H2 thematic model; WalkU/WalkG only. Eight-minute trip summaries and available Empatica counterparts; not identical source instrumentation.')
  results$rodrigues <- rodrigues_block$results

  # Jin, Jin & Kang (2020), Build Environ 168:106517; doi:10.1016/j.buildenv.2019.106517.
  # Tables 3-7, sections 3.1-3.3: ANOVA of sound level x UTCI stress category.
  # Keep the source 5-dB spacing, NOT sample quartiles. Continue that spacing outside
  # its observed 55-75 dBA range so our observations are not discarded or clamped.
  # Participant blocking is necessary because our phase ratings repeat within people.
  jin <- cells
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
    design <- model.matrix(~ ParticipantID + sound_level * thermal_level, data)
    if (qr(design)$rank < ncol(design) || nrow(design) <= ncol(design)) {
      fit_notes <- c(fit_notes, paste('Jin 2020:', outcome,
        'full categorical interaction not estimable with observed source-style bins; no quartile or cutoff fallback.',
        'Retained phase cells:', nrow(data), '; design rank/columns:', qr(design)$rank, '/', ncol(design)))
      next
    }
    table <- H4_JIN$anova_type2(data[[outcome]], data$sound_level, data$thermal_level, data$ParticipantID)
    if (is.null(table)) next
    for (index in seq_len(nrow(table))) {
      jin_rows[[length(jin_rows) + 1L]] <- result_row('Jin 2020',
        'Two-way ANOVA: source-spaced sound bands x UTCI stress categories', outcome, table$effect[index], data,
        statistic = table$F[index], df = paste(table$df_term[index], table$df_resid[index], sep = ', '),
        p = table$p[index], statistic_test = 'f-test (Type-II ANOVA with participant blocking)',
        model = paste(outcome, '~ ParticipantID + sound_level * thermal_level'),
        note = 'Published ANOVA factors; source 5-dB spacing extended to retain all observed levels. Participant blocking and our rating scales are adaptations. No exposure threshold exclusions.')
    }
  }
  if (length(jin_rows)) results$jin <- do.call(rbind, jin_rows)
  fit_notes <- c(fit_notes, 'Jin observed sound x UTCI category counts:',
    capture.output(print(table(jin$sound_level, jin$thermal_level))))
}

# Cureau et al. (2022), Int J Biometeorol 66:2033-2045; doi:10.1007/s00484-022-02338-7.
# Data analysis, p. 2037: Fisher exact associations between comfort domains, by park.
# Each of our phases is the site analogue; one response per participant in each table.
# This tests association between ratings, not a measured sound-level effect.
cureau_rows <- list()
for (phase in analysis_phases) {
  for (pair in combn(names(ratings), 2, simplify = FALSE)) {
    data <- cells[cells$PhaseID == phase & complete.cases(cells[pair]), ]
    contingency <- table(data[[pair[1]]], data[[pair[2]]])
    fit <- if (nrow(contingency) > 1L && ncol(contingency) > 1L)
      tryCatch(fisher.test(contingency, workspace = 2e7), error = function(error) error)
    else simpleError('Only one observed response category')
    cureau_rows[[length(cureau_rows) + 1L]] <- result_row('Cureau 2022',
      paste('Fisher exact comfort-domain association, phase', phase), pair[1], pair[2], data,
      p = if (inherits(fit, 'error')) NA_real_ else fit$p.value,
      statistic_test = 'Fisher exact test (contingency-table association)',
      model = paste(pair, collapse = ' versus '),
      note = paste('Published Fisher exact method. Phase is the site analogue; our TC/AC/visual scores are 5-point and overall comfort is 7-point.',
        if (inherits(fit, 'error')) conditionMessage(fit) else ''),
      sound_variable = 'comfort-domain association (no measured sound predictor)')
  }
}
results$cureau <- do.call(rbind, cureau_rows)

# Wu et al. (2025), Energy Buildings 347:116329; doi:10.1016/j.enbuild.2025.116329.
# Section 4.4, equations 1 and 4: TWO SEPARATE additive regression models.
# Objective: overall comfort ~ UTCI + LAeq. Subjective: overall comfort ~ TC + AC.
# Keep raw units and both published predictor sets; do not add 60-dBA interactions.
# A random participant intercept adapts the regressions to repeated phase ratings.
wu_rows <- list()
wu_models <- list(objective = overall_comfort ~ utci + dba,
                  subjective = overall_comfort ~ thermal_comfort + acoustic_comfort)
for (model_name in names(wu_models)) {
  formula <- wu_models[[model_name]]
  data <- cells[complete.cases(cells[all.vars(formula)]), ]
  data$ParticipantID <- factor(data$ParticipantID)
  fit <- tryCatch(nlme::lme(formula, random = ~ 1 | ParticipantID, data = data,
    method = 'REML', control = nlme::lmeControl(opt = 'optim')), error = function(error) error)
  for (predictor in attr(terms(formula), 'term.labels')) {
    coefficient <- if (!inherits(fit, 'error')) summary(fit)$tTable[predictor, ] else
      setNames(rep(NA_real_, 5), c('Value', 'Std.Error', 'DF', 't-value', 'p-value'))
    critical <- if (is.finite(coefficient['DF'])) qt(0.975, coefficient['DF']) else NA_real_
    wu_rows[[length(wu_rows) + 1L]] <- result_row('Wu 2025',
      paste('Published', model_name, 'additive predictor set; repeated-participant adaptation'),
      'overall_comfort', predictor, data, estimate = unname(coefficient['Value']),
      se = unname(coefficient['Std.Error']),
      ci = unname(coefficient['Value'] + c(-1, 1) * critical * coefficient['Std.Error']),
      statistic = unname(coefficient['t-value']), df = unname(coefficient['DF']), p = unname(coefficient['p-value']),
      statistic_test = 't-test (mixed regression coefficient; participant intercept)',
      model = paste(deparse(formula), collapse = ' '),
      note = paste('Wu source equations 1/4 predictor sets. Raw UTCI degrees C/dBA or raw vote points. Participant intercept accounts for repeated ratings; coefficients are estimated from our summer data, not copied from the paper.',
        if (inherits(fit, 'error')) conditionMessage(fit) else ''),
      sound_variable = if (model_name == 'objective') 'ucm_SND_dBA' else 'perceived acoustic comfort')
  }
}
results$wu <- do.call(rbind, wu_rows)

# Xu et al. (2026), Environ Dev Sustain; doi:10.1007/s10668-026-08213-4.
# Section 4.1 / Table 3: Pearson correlations of measured sound with TC and AC.
# Apply within phase so each correlation has independent participants, not four
# allegedly independent observations per person. This stratification is our adaptation.
# Do not manufacture a linear mixed model or impose the paper's discovered thresholds.
xu_rows <- list()
for (phase in analysis_phases) {
  for (outcome in c('thermal_comfort', 'acoustic_comfort')) {
    data <- cells[cells$PhaseID == phase & complete.cases(cells[c('dba', outcome)]), ]
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
      note = 'Source section 4.1 / Table 3 bivariate Pearson test. Phase-stratified to avoid repeated-participant pseudoreplication; our 5-point ratings differ from source 7-point ratings. No thermal adjustment or exposure exclusion. This is not the source threshold, CART, clustering or SHAP analysis.')
  }
}
results$xu <- do.call(rbind, xu_rows)

# Explicitly unavailable source tests: do not silently replace outcome, exposure or test.
skipped <- c(
  'Moshammer 2019: published preceding 15-min exposure/outcome periods cannot be recreated within an 8-min phase; the former 5+3-min split is removed.',
  'Biel 2020: published baseline-to-follow-up changes and 30-min exposures/random slopes are not reproduced by 8-min phase means or invented 2-min windows.',
  'Kraus 2013: published 5-min lagged outcomes/exposures through 15 min and HR adjustment are not reproduced by one interval per 8-min phase. Its 65-dBA knot was source-based, not an exclusion, but the truncated analogue is removed.',
  'Korpilo 2024: original PDF not located in Experiment papers; the former log-EDA/broad-band NDSI model is not independently source-verified.',
  'Pigliautile 2021: controlled-room sound/thermal conditions are not available; phase-majority classifier labels cannot replace assigned source conditions.',
  'Chiucchiu 2026: original full-text PDF not located in Experiment papers; source-specific paired conditions cannot be independently verified from the screened MD.',
  'Chen 2023: source section 2.7 uses repeated-measures ANOVA/sphericity corrections and ranked source type. The continuous LMM plus classifier natural share is not that test; exact factor specification and source-ranking data are unavailable.',
  'Qin 2024: source uses PET/TSV, humidity grades and 20-dB sound grades, not the continuous TC ~ sound*RH mixed model. Its Table 2 does not identify the correlation estimator in the inspected text; no guessed Pearson/Spearman test or interaction is substituted.',
  'Mohammadzadeh 2023: source acoustic outcomes are soundscape quality, reported loudness, overall impression and perceived natural-source proportion. Generic AC and UTCI do not replace those outcomes or PET.',
  'Gao 2025: source restoration outcome is ROS, not our perceived-restorativeness PRS-11. No PRS substitution or quartile ANOVA is fitted under the source name.',
  'Zhen 2025: source sections 3.3.1-3.3.4 use 1-degree UTCI means and source/vote strata with fitted curves. The former raw TC ~ UTCI*dBA LMM is not its published test; source-type/ASV strata are unavailable.',
  'Zhang 2026 Scientific Reports: source ordered logistic models use PET, aesthetic perception and stated covariates. A Gaussian AC*UTCI mixed model is not a reproduction.',
  'Zhang 2026 Building Simulation: source Spearman tests in section 3.2.1.1 concern TSV versus meteorological variables; our TC/AC/OC-versus-dBA tests were not established by that source and are removed.',
  'Song 2013/2014 and Jo 2019: environment/playback contrasts are not isolated measured-sound tests in our field design; no forest/urban sound treatment is invented.',
  'Ueberham 2019, Li 2025 and Jin 2020 chamber: required questionnaire items, arrival/departure measurements or assigned sound/temperature treatments are unavailable.'
)

# Keep source raw p decisions distinct from our additional BH correction.
# One BH family per paper x named analysis block, across its exported tests/outcomes.
results <- Filter(function(block) is.data.frame(block) && nrow(block), results)
FDR <- do.call(H4_REPORT$catalog, results)
FDR$inference_status <- paste0('Source-rule raw p reported separately; q is additional BH within paper x named analysis block. ', FDR$inference_status)
significance_summary <- H4_REPORT$summary(FDR)
stopifnot(all(is.finite(FDR$p)), all(FDR$p >= 0 & FDR$p <= 1),
  all(is.finite(FDR$q_BH)), all(FDR$survives_FDR_q05 == (FDR$q_BH < 0.05)))
notes <- c('# H4 verified source methods: feasible components only',
  'Source PDFs were read directly on 8 November 2026; screened MD was not used as sole evidence.',
  'This does not reproduce any entire experiment. Repeated-measures, phase/site, instrument and rating-scale adaptations are explicit in each result row.',
  paste('Analysis phases:', paste(analysis_phases, collapse = ', ')),
  paste('Input MD5:', unname(input_fingerprint)),
  paste('Code MD5:', basename(code_paths), unname(code_fingerprints)),
  paste('Source PDF MD5:', source_papers, unname(source_fingerprints)),
  '', '## Rules',
  '- No universal UTCI/dBA/temperature filter, threshold search, majority-source proxy, category proportion or spectrum substitution.',
  '- Missing required values and original physiological QC are retained as necessary exclusions; exposure level alone does not exclude a row.',
  '- Recorded dBA is an energy aggregation of 10-s UCM medians, not a certified native LAeq. This measurement difference remains.',
  '- Raw p applies the source decision rule; BH q is an additional correction, not falsely attributed to the original paper.',
  '- One phase rating per participant/bout; repeated 10-s copies are never treated as independent votes.',
  '- Jin retains physical 5-dB spacing and UTCI stress categories, extending the dBA range when necessary. Unestimable factorial models have no quartile fallback.',
  '- Cureau: Fisher exact within phase. Wu: separate source objective/subjective additive predictor sets with participant intercept. Xu: source Pearson test within phase.',
  '- No publication-level equivalence, causal sound effect or predictive validation is asserted.',
  '', '## Source tests not reproduced (reason)', paste0('- ', skipped),
  '', '## Fit and support notes', fit_notes,
  H4_REPORT$not_estimable_notes(attr(FDR, 'not_estimable')))

# Publish three files only after successful staging and unchanged code/input/source checks.
if (!identical(unname(tools::md5sum(code_paths)), unname(code_fingerprints))) stop('H4 code changed during run')
if (!identical(unname(tools::md5sum(input)), unname(input_fingerprint))) stop('Merged input changed during run')
if (!identical(unname(tools::md5sum(source_paths)), unname(source_fingerprints))) stop('Source PDFs changed during run')
staged_outdir <- tempfile('H4_results_')
dir.create(staged_outdir, recursive = TRUE)
write.csv(FDR[setdiff(names(FDR), c('paper_rule_met', 'model_details'))],
  file.path(staged_outdir, 'H4_sound_literature_tests.csv'), row.names = FALSE, na = '')
write.csv(significance_summary, file.path(staged_outdir, 'SUMMARY_sound_tests_p_and_FDR.csv'), row.names = FALSE, na = '')
writeLines(notes, file.path(staged_outdir, 'METHODS_NOTES.md'))
p3_finalize_directory(staged_outdir)
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
output_files <- list.files(staged_outdir, full.names = TRUE)
stopifnot(length(output_files) == 3L)
if (!all(file.copy(output_files, outdir, overwrite = TRUE))) stop('Failed to publish H4 files')
cat('Done:', outdir, paste(basename(output_files), collapse = ', '), '\n')

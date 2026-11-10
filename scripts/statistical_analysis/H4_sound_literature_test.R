# H4: method-adaptation catalogue (documents/H4_papers_screened_final.md §0.8).
# Catalogue: screened guide **§3.1–§3.11** run blocks (Christos Grapas → Anna Laura → European field); §3.12–§3.14 not in this runner.
# Outputs: H4_sound_literature_tests.csv (+ SUMMARY, METHODS_NOTES). No separate Paper 3 route or tier extracts.
# Walk-only ports use WalkG/WalkU; Kraus uses all four core phases; Ueberham uses BikeG/BikeU only.

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run this file with Rscript')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
library_dir <- file.path(dirname(.entry), 'library')
code_paths <- c(.entry, file.path(library_dir, c('Paper3_common.R', 'H4_sound_literature_helpers.R')))
code_fingerprints <- tools::md5sum(code_paths)
for (path in code_paths[-1]) source(path, local = FALSE)
# Outcome-window HRV and native RRI are identical across sound substitutions: cache them once within this run.
original_read_rri <- H4_MOSHAMMER$read_rri
cached_rri <- NULL
H4_MOSHAMMER$read_rri <- function() {
  if (is.null(cached_rri)) cached_rri <<- original_read_rri()
  cached_rri
}
original_window_hrv <- H4_MOSHAMMER$lf_hf
window_hrv_cache <- new.env(parent = emptyenv())
H4_MOSHAMMER$lf_hf <- function(peak_time, rri_ms, start, end) {
  key <- paste(as.numeric(start), as.numeric(end), length(rri_ms), sum(rri_ms, na.rm = TRUE),
    paste(head(rri_ms, 5L), collapse = ','), paste(tail(rri_ms, 5L), collapse = ','))
  if (!exists(key, envir = window_hrv_cache, inherits = FALSE))
    assign(key, original_window_hrv(peak_time, rri_ms, start, end), envir = window_hrv_cache)
  get(key, envir = window_hrv_cache, inherits = FALSE)
}
for (package in c('nlme', 'mgcv')) if (!requireNamespace(package, quietly = TRUE)) stop('Required package missing: ', package)
suppressPackageStartupMessages({ library(nlme); library(mgcv) })
lme_control <- nlme::lmeControl(opt = 'optim')
started <- Sys.time()
step_log <- function(label) cat(sprintf('[%6.1f s] %s\n', as.numeric(difftime(Sys.time(), started, units = 'secs')), label))

root <- resolve_project_root()
analysis_phases <- PAPER3_CORE_PHASES
H4_PHASE_BIKE <- c('BikeG', 'BikeU')
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

# Frequency-domain HRV only where the dataset's 5-min window passed QC; window bounds are needed by Kraus.
outcomes <- paper3_physiological_outcomes()
hrv_available <- tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c('true', '1')
for (column_name in attr(outcomes, 'empatica_hrv_fd_window')) epochs[[column_name]][!hrv_available] <- NA_real_
epochs$hrv_window_available <- hrv_available
epochs$hrv_seg_start <- H4_UTIL$parse_utc(epochs$empatica_hrv_fd_5min_segment_start)
epochs$hrv_seg_end <- H4_UTIL$parse_utc(epochs$empatica_hrv_fd_5min_segment_end)
epochs <- H4_SOUND$attach_encodings(epochs)
epochs_walk <- epochs[epochs$PhaseID %in% H4_PHASE_WALK, , drop = FALSE]
epochs_bike <- epochs[epochs$PhaseID %in% H4_PHASE_BIKE, , drop = FALSE]

ratings <- c(thermal_comfort = 'questionnaire_thermal_comfort_1_5',
  acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
  visual_comfort = 'questionnaire_visual_comfort_1_5',
  overall_comfort = 'questionnaire_current_comfort_1_7')
# Richer phase cells (RH, air temperature, wind, physiology, YAMNet shares, PRS) for the outdoor blocks.
outdoor_walk <- h4_outdoor_phase_cells(epochs_walk)
outdoor_bike <- h4_outdoor_phase_cells(epochs_bike)

source_papers <- c(
  Rodrigues = 'H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf',
  Cureau = 'Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf')
optional_papers <- c(
  Moshammer = 'H4 Sound literature test/Included - Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf',
  Kraus = 'Sound_evidence/Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf',
  Chiucchiu = 'Anna Laura/Sound - The role of personality in multi-domain environmental perception An occupant-centric approach.pdf',
  Ueberham = 'Sound_evidence/Ueberham2019_Cyclists_multiple_environmental_exposures.pdf',
  Korpilo = 'Sound_evidence/Sound - Korpilo2024 - Landscape soundscape quality stress recovery urban nature.pdf')
grapas_glob <- list.files(file.path(root, 'Experiment papers', 'Urban Climate Literature'),
  pattern = 'Grapas.*2026.*\\.pdf$', full.names = FALSE)
if (length(grapas_glob)) optional_papers <- c(Grapas = file.path('Urban Climate Literature', grapas_glob[1]), optional_papers)
pigliautile_pdf <- list.files(file.path(root, 'Experiment papers', 'Sound_evidence'),
  pattern = '^Sound - Environmental thermal influence over soundscape perception.*\\.pdf$')
if (length(pigliautile_pdf)) optional_papers <- c(Pigliautile = file.path('Sound_evidence', pigliautile_pdf[1]), optional_papers)
source_paths <- file.path(root, 'Experiment papers', source_papers)
if (!all(file.exists(source_paths))) stop('Verified source PDF missing: ', paste(source_papers[!file.exists(source_paths)], collapse = '; '))
optional_present <- file.exists(file.path(root, 'Experiment papers', optional_papers))
missing_optional <- optional_papers[!optional_present]
source_papers <- c(source_papers, optional_papers[optional_present])
source_paths <- file.path(root, 'Experiment papers', source_papers)
source_fingerprints <- tools::md5sum(source_paths)
results <- list()
fit_notes <- character()

result_row <- function(paper, test, outcome, predictor, data, estimate = NA_real_, se = NA_real_,
                       ci = c(NA_real_, NA_real_), statistic = NA_real_, df = NA, p = NA_real_,
                       statistic_test, model, note, sound_variable = 'ucm_SND_dBA',
                       source_column = unname(ratings[outcome]), transformation = 'raw questionnaire score') {
  data.frame(paper = paper, test = test, outcome = outcome,
    source_column = source_column, term = predictor,
    estimate = estimate, se = se, ci_low = ci[1], ci_high = ci[2], statistic = statistic, df = df, p = p,
    n_observations = nrow(data), n_participants = length(unique(data$ParticipantID)),
    statistic_test = statistic_test, paper_rule = 'p < 0.05',
    paper_rule_met = if (is.finite(p)) p < 0.05 else NA,
    transformation = transformation, term_units = 'see model_details',
    model_id = model, model_details = note, sound_variable = sound_variable)
}
with_sound <- function(block, value) {
  if (!'sound_variable' %in% names(block)) block$sound_variable <- value
  block
}
bind_rows <- function(rows) if (length(rows)) do.call(rbind, rows) else NULL
scopus_block <- function(paper) {
  out <- h4_scopus_outdoor_tests(epochs_walk, papers = paper)
  fit_notes <<- c(fit_notes, setdiff(out$notes, c('', '## Outdoor method ports (this run)')))
  out$results
}
tag_alt <- function(block, label, suffix) { block$sound_variable <- label; block$test <- paste0(block$test, suffix); block }
alt_sounds <- c(H4_SOUND$four_ways(names(epochs)),
  H4_SOUND$alternatives(names(epochs))[intersect(H4_SOUND$spectral, names(epochs))])

# =============================================================================
# 3.1 Grapas et al. 2026 — Pearson phase-mean dBA vs comfort (SOR analogue; Christos / Brussels).
# =============================================================================
step_log('3.1 Grapas 2026')
results$grapas <- H4_EUROPE_PORTS$grapas_pearson(outdoor_walk)

# =============================================================================
# 3.2 Pigliautile 2021 — WalkG/WalkU; Fig 3a air-quality warm-cool; (b) traffic-nature; (c) stratum Spearman.
# =============================================================================
step_log('3.2 Pigliautile 2021')
results$pigliautile <- H4_PIGLIAUTILE$run(epochs_walk)$results

# =============================================================================
# 3.3 IBPC 2018 poster — NEXT.ROOM warm vs cool vote analogue (not Pigliautile re-label).
# =============================================================================
step_log('3.3 IBPC 2018 poster')
results$ibpc <- H4_IBPC$run(epochs_walk)$results

# =============================================================================
# 3.4 Chiucchiù et al. 2026
# =============================================================================
step_log('3.4 Chiucchiù 2026')
results$chiucchiu <- H4_CHIUCCHIU$run(epochs_walk)$results

# =============================================================================
# 3.5 Cureau et al. 2022 — Fisher exact per WalkG and WalkU.
# =============================================================================
cureau_extra <- h4_additional_outdoor_tests(epochs_walk, papers = 'Cureau', include_scopus = FALSE)
outdoor_method_notes <- cureau_extra$notes
step_log('3.5 Cureau 2022')
results$cureau <- cureau_extra$results
# §3.6 Cureau Forum Acusticum 2023: same Fisher family as journal §3.5 — cited in screened guide only; not duplicated in CSV.

# =============================================================================
# 3.7 Moshammer 2019 — walk HRV (source GLS) + additive comfort LMM.
# =============================================================================
step_log('3.7 Moshammer 2019')
mosh_primary <- H4_MOSHAMMER$run(epochs_walk)$results
mosh_primary <- mosh_primary[grepl('walking phases', mosh_primary$test, fixed = TRUE), , drop = FALSE]
results$moshammer <- with_sound(mosh_primary, 'ucm_SND_dBA')
results$moshammer_comfort <- H4_EUROPE_PORTS$additive_comfort_lmm(outdoor_walk, lme_control)

# =============================================================================
# 3.8 Rodrigues 2026 — physiology blocks + comfort noise/temperature blocks.
# =============================================================================
step_log('3.8 Rodrigues 2026')
rodrigues_block <- H4_RODRIGUES$run(epochs_walk, lme_control)
rodrigues_block$results$sound_variable <- 'ucm_SND_dBA'
results$rodrigues <- rodrigues_block$results
results$rodrigues_comfort <- H4_EUROPE_PORTS$rodrigues_comfort_blocks(outdoor_walk, epochs_walk, lme_control)

# =============================================================================
# 3.9 Kraus 2013 — 5-min piecewise Leq on HRV (primary dBA).
# =============================================================================
step_log('3.9 Kraus 2013')
results$kraus <- with_sound(H4_KRAUS$run(epochs, lme_control)$results, 'ucm_SND_dBA')

# =============================================================================
# 3.10 Korpilo 2024 — EDA ~ NDSI analogue + temp (primary encoding).
# =============================================================================
step_log('3.10 Korpilo 2024')
results$korpilo <- with_sound(H4_KORPILO$run(epochs_walk, lme_control)$results, 'NDSI analogue (frequency-band proportions)')

# =============================================================================
# 3.11 Ueberham 2019 — BikeG/BikeU Spearman objective exposure vs comfort votes.
# =============================================================================
step_log('3.11 Ueberham 2019')
ueberham_rows <- list()
for (phase in H4_PHASE_BIKE) {
  data <- outdoor_bike[outdoor_bike$PhaseID == phase, , drop = FALSE]
  for (spec in list(c('dba', 'acoustic_comfort', 'ucm_SND_dBA'), c('utci', 'thermal_comfort', 'ucm_UTCI'))) {
    row <- H4_AL$spearman_row(data[[spec[1]]], data[[spec[2]]], 'Ueberham 2019',
      paste('Spearman objective route mean vs comfort |', spec[1], 'vs', spec[2], '| phase', phase), spec[2],
      paste(ratings[[spec[2]]], spec[3], sep = ', '), 'Spearman rho',
      paste('spearman(', spec[1], ',', spec[2], ') within', phase),
      'Source compares objective vs perceived intensity; comfort votes replace intensity items. BikeG/BikeU only.',
      length(unique(data$ParticipantID)), data$ParticipantID)
    ueberham_rows[[length(ueberham_rows) + 1L]] <- H4_AL$attach_sound(row, if (spec[1] == 'dba') 'dba' else 'temperature-only (UTCI)')
  }
}
results$ueberham <- bind_rows(ueberham_rows)

results <- Filter(function(block) is.data.frame(block) && nrow(block), results)
catalog <- do.call(H4_REPORT$catalog, unname(results))
primary_estimands <- H4_PRIMARY$subset(catalog)
significance_summary <- H4_REPORT$summary(catalog)
stopifnot(all(is.finite(catalog$p)), all(catalog$p >= 0 & catalog$p <= 1))
if (nrow(primary_estimands)) stopifnot(all(is.finite(primary_estimands$p)))
paper_counts <- table(factor(catalog$paper, levels = unique(catalog$paper)))
expected_papers <- c('Pigliautile 2021', 'IBPC 2018 poster', 'Chiucchiù 2026', 'Cureau 2022', 'Grapas 2026',
  'Moshammer 2019', 'Moshammer 2019 (comfort adaptation)', 'Rodrigues 2026', 'Rodrigues 2026 (comfort adaptation)',
  'Kraus 2013', 'Korpilo 2024', 'Ueberham 2019')
missing_papers <- setdiff(expected_papers, names(paper_counts))
if (length(missing_papers)) warning('No estimable rows for: ', paste(missing_papers, collapse = ', '))

notes <- c('# H4 method adaptation run (documents/H4_papers_screened_final.md sections 0.8 and 3)',
  paste('Phases:', paste(analysis_phases, collapse = ', '), '; walk-only papers use', paste(H4_PHASE_WALK, collapse = ', '),
    '; Kraus uses all four core phases; Ueberham uses', paste(H4_PHASE_BIKE, collapse = ', ')),
  paste('Input MD5:', unname(input_fingerprint)),
  paste('Code MD5:', basename(code_paths), unname(code_fingerprints)),
  paste('Source PDF MD5:', source_papers, unname(source_fingerprints)),
  if (length(missing_optional)) paste('Source PDF not found (not fingerprinted):', names(missing_optional), missing_optional),
  sprintf('Run time: %.1f s', as.numeric(difftime(Sys.time(), started, units = 'secs'))),
  '', '## Rows per paper (finite p)', sprintf('- %s: %d', names(paper_counts), as.integer(paper_counts)),
  if (length(missing_papers)) paste('- No estimable rows:', paste(missing_papers, collapse = ', ')),
  '', '## Methods (see documents/H4_papers_screened_final.md section 1.1 and section 3 item 9)',
  '- Catalogue run order: §3.1 Grapas → §3.2–§3.4 Anna Laura (Pigliautile, IBPC, Chiucchiù) → §3.5 Cureau → §3.7–§3.11 European field (§3.6 FA citation only; §3.12–§3.14 not run).',
  '- Grapas §3.1: Pearson dBA vs comfort on walk phase cells.',
  '- Pigliautile §3.2 / Chiucchiù §3.4: person-mean paired t and participant-mean Spearman on WalkG/WalkU (thermal split within person).',
  '- IBPC §3.3: warm–cool paired vote analogue (`H4_IBPC`); Pigliautile keeps traffic–nature + stratum Spearman + air-quality warm–cool.',
  '- Cureau 2022 §3.5: Fisher exact comfort-domain contrasts by walk phase (§3.6 FA preprint = citation, no duplicate CSV).',
  '- Moshammer §3.7 comfort: additive LMM dBA + UTCI; Rodrigues §3.8 comfort: noise/temperature blocks.',
  '- Moshammer HRV: walking-phase xtreg-re GLS; Kraus: 5-min piecewise Leq on HRV (all four phases); Korpilo: EDA ~ NDSI + temp.',
  '- Ueberham: Spearman within BikeG and BikeU (objective dBA/UTCI vs comfort votes).',
  '- Inference: each row\'s paper_rule only (documents/H4_papers_screened_final.md §1.4); no catalogue-wide BH/FDR in this run.',
  '- Output: H4_sound_literature_tests.csv = full §3 method ports (report by source paper). §0.3 manuscript highlights listed below only.',
  H4_PRIMARY$methods_notes(primary_estimands),
  '', '## Fit and support notes', fit_notes, outdoor_method_notes,
  H4_REPORT$not_estimable_notes(attr(catalog, 'not_estimable')))

if (!identical(unname(tools::md5sum(code_paths)), unname(code_fingerprints))) stop('H4 code changed during run')
if (!identical(unname(tools::md5sum(input)), unname(input_fingerprint))) stop('Merged input changed during run')
if (!identical(unname(tools::md5sum(source_paths)), unname(source_fingerprints))) stop('Source PDFs changed during run')
staged_outdir <- tempfile('H4_results_')
dir.create(staged_outdir, recursive = TRUE)
write.csv(catalog[setdiff(names(catalog), c('paper_rule_met', 'model_details'))],
  file.path(staged_outdir, 'H4_sound_literature_tests.csv'), row.names = FALSE, na = '')
write.csv(significance_summary, file.path(staged_outdir, 'SUMMARY_sound_tests_paper_rule.csv'), row.names = FALSE, na = '')
writeLines(notes, file.path(staged_outdir, 'METHODS_NOTES.md'))
p3_finalize_directory(staged_outdir)
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
for (legacy in c('H4_primary_estimands_results.csv', 'H4_route_contrast_results.csv')) {
  legacy_path <- file.path(outdir, legacy)
  if (file.exists(legacy_path)) file.remove(legacy_path)
}
output_files <- list.files(staged_outdir, full.names = TRUE)
stopifnot(length(output_files) == 3L)
if (!all(file.copy(output_files, outdir, overwrite = TRUE))) stop('Failed to publish H4 files')
step_log(sprintf('catalogue: %d rows from %d papers | §0.3 highlights: %d',
  nrow(catalog), length(paper_counts), nrow(primary_estimands)))
cat('Done:', outdir, paste(basename(output_files), collapse = ', '), '\n')

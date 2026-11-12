# H4 comfort / field-analogue catalogue (not source-paper replication).
# Blocks moved out of H4_sound_literature_test.R: Grapas Pearson, Pigliautile, IBPC,
# Moshammer/Rodrigues comfort LMMs, Ueberham comfort Spearman.
# Policy: documents/H1_H5_papers_screened_final.md section 4.
# Output: H4_sound_literature_test_adaptations/

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run this file with Rscript')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
library_dir <- file.path(dirname(.entry), 'library')
code_paths <- c(.entry, file.path(library_dir, c('Paper3_common.R', 'H4_sound_literature_helpers.R')))
code_fingerprints <- tools::md5sum(code_paths)
for (path in code_paths[-1]) source(path, local = FALSE)
for (package in c('nlme', 'mgcv')) if (!requireNamespace(package, quietly = TRUE)) stop('Required package missing: ', package)
suppressPackageStartupMessages({ library(nlme); library(mgcv) })
lme_control <- nlme::lmeControl(opt = 'optim')
started <- Sys.time()
step_log <- function(label) cat(sprintf('[%6.1f s] %s\n', as.numeric(difftime(Sys.time(), started, units = 'secs')), label))

root <- resolve_project_root()
analysis_phases <- PAPER3_CORE_PHASES
H4_PHASE_BIKE <- c('BikeG', 'BikeU')
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_sound_literature_test_adaptations')
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs <- read.csv(input, check.names = FALSE)
epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% analysis_phases, ]
epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = 'UTC')
epochs <- epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
epochs <- H4_SOUND$attach_encodings(epochs)
epochs_walk <- epochs[epochs$PhaseID %in% H4_PHASE_WALK, , drop = FALSE]
epochs_bike <- epochs[epochs$PhaseID %in% H4_PHASE_BIKE, , drop = FALSE]
outdoor_walk <- h4_outdoor_phase_cells(epochs_walk)
outdoor_bike <- h4_outdoor_phase_cells(epochs_bike)

ratings <- c(thermal_comfort = 'questionnaire_thermal_comfort_1_5',
  acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
  visual_comfort = 'questionnaire_visual_comfort_1_5',
  overall_comfort = 'questionnaire_current_comfort_1_7')
results <- list()
fit_notes <- character()
bind_rows <- function(rows) if (length(rows)) do.call(rbind, rows) else NULL

step_log('Grapas 2026 (SOR Pearson analogue)')
results$grapas <- H4_EUROPE_PORTS$grapas_pearson(outdoor_walk)
step_log('Pigliautile 2021')
results$pigliautile <- H4_PIGLIAUTILE$run(epochs_walk)$results
step_log('IBPC 2018 poster')
results$ibpc <- H4_IBPC$run(epochs_walk)$results
step_log('Moshammer 2019 comfort adaptation')
results$moshammer_comfort <- H4_EUROPE_PORTS$additive_comfort_lmm(outdoor_walk, lme_control)
step_log('Rodrigues 2026 comfort adaptation')
results$rodrigues_comfort <- H4_EUROPE_PORTS$rodrigues_comfort_blocks(outdoor_walk, epochs_walk, lme_control)
step_log('Ueberham 2019 comfort Spearman')
ueberham_rows <- list()
for (phase in H4_PHASE_BIKE) {
  data <- outdoor_bike[outdoor_bike$PhaseID == phase, , drop = FALSE]
  for (spec in list(c('dba', 'acoustic_comfort', 'ucm_SND_dBA'), c('utci', 'thermal_comfort', 'ucm_UTCI'))) {
    row <- H4_AL$spearman_row(data[[spec[1]]], data[[spec[2]]], 'Ueberham 2019',
      paste('Spearman objective route mean vs comfort |', spec[1], 'vs', spec[2], '| phase', phase), spec[2],
      paste(ratings[[spec[2]]], spec[3], sep = ', '), 'Spearman rho',
      paste('spearman(', spec[1], ',', spec[2], ') within', phase),
      'Comfort votes substitute for source intensity scales; not a replication row.',
      length(unique(data$ParticipantID)), data$ParticipantID)
    ueberham_rows[[length(ueberham_rows) + 1L]] <- H4_AL$attach_sound(row, if (spec[1] == 'dba') 'dba' else 'temperature-only (UTCI)')
  }
}
results$ueberham <- bind_rows(ueberham_rows)

results <- Filter(function(block) is.data.frame(block) && nrow(block), results)
catalog <- do.call(H4_REPORT$catalog, unname(results))
significance_summary <- H4_REPORT$summary(catalog)
stopifnot(all(is.finite(catalog$p)), all(catalog$p >= 0 & catalog$p <= 1))

notes <- c('# H4 adaptation catalogue (comfort / field analogue; not literature replication)',
  'See documents/H1_H5_papers_screened_final.md section 4. Primary replication: H4_sound_literature_test.R.',
  paste('Input MD5:', unname(input_fingerprint)),
  paste('Code MD5:', basename(code_paths), unname(code_fingerprints)),
  sprintf('Run time: %.1f s', as.numeric(difftime(Sys.time(), started, units = 'secs'))),
  '', '## Included blocks',
  '- Grapas-inspired Pearson on phase-mean dBA vs comfort (source used network/bootstrap machinery).',
  '- Pigliautile / IBPC NEXT.ROOM field analogues with analysis-added paired t and Spearman.',
  '- Moshammer and Rodrigues comfort-outcome LMMs (sources used HRV / trip physiology).',
  '- Ueberham Spearman with comfort votes (source used perceived intensity scales).',
  H4_REPORT$not_estimable_notes(attr(catalog, 'not_estimable')))

staged_outdir <- tempfile('H4_adapt_')
dir.create(staged_outdir, recursive = TRUE)
write.csv(catalog[setdiff(names(catalog), c('paper_rule_met', 'model_details'))],
  file.path(staged_outdir, 'H4_sound_literature_tests_adaptations.csv'), row.names = FALSE, na = '')
write.csv(significance_summary, file.path(staged_outdir, 'SUMMARY_sound_tests_paper_rule.csv'), row.names = FALSE, na = '')
writeLines(notes, file.path(staged_outdir, 'METHODS_NOTES.md'))
p3_finalize_directory(staged_outdir)
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
output_files <- list.files(staged_outdir, full.names = TRUE)
stopifnot(length(output_files) == 3L)
if (!all(file.copy(output_files, outdir, overwrite = TRUE))) stop('Failed to publish adaptation files')
step_log(sprintf('adaptation catalogue: %d rows from %d papers', nrow(catalog), length(unique(catalog$paper))))
cat('Done:', outdir, '\n')

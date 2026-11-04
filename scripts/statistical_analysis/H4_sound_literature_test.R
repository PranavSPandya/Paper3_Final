# H4 sound tests: reruns the methods of five outdoor studies on the Paper 3 field data (helpers in library/H4_sound_literature_helpers.R).
# Output: output/statistical_analysis/results/H4_sound_literature_test/ (run from the project root).

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run with Rscript on this file')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
.common <- file.path(dirname(.entry), 'library', 'Paper3_common.R')
.h4_helpers <- file.path(dirname(.entry), 'library', 'H4_sound_literature_helpers.R')
source(.common, local = FALSE)
source(.h4_helpers, local = FALSE)
for (pk in c('nlme', 'mgcv')) if (!requireNamespace(pk, quietly = TRUE)) stop('Required package missing: ', pk)
suppressPackageStartupMessages({ library(nlme); library(mgcv) })
root <- resolve_project_root()
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_sound_literature_test')
if (dir.exists(outdir) && length(list.files(outdir, all.files = TRUE, no.. = TRUE))) stop('Output folder already exists and is not empty: ', outdir)
outcomes <- paper3_physiological_outcomes()
input <- paper3_merged_8min_path(root)
epochs <- read.csv(input, check.names = FALSE)
epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% PAPER3_CORE_PHASES, , drop = FALSE]
epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = 'UTC')
stopifnot(!anyNA(epochs$Datetime), !anyDuplicated(epochs[c('ParticipantID', 'PhaseID', 'Datetime')]))
epochs <- epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
# Frequency-domain HRV values exist only where the dataset's 5-min window is available.
hrv_window_available <- tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c('true', '1')
for (column_name in attr(outcomes, 'empatica_hrv_fd_window')) epochs[[column_name]][!hrv_window_available] <- NA_real_
epochs$hrv_window_available <- hrv_window_available
epochs$hrv_seg_start <- H4_UTIL$parse_utc(epochs$empatica_hrv_fd_5min_segment_start)
epochs$hrv_seg_end <- H4_UTIL$parse_utc(epochs$empatica_hrv_fd_5min_segment_end)
participant_phase_bout <- interaction(epochs$ParticipantID, epochs$PhaseID, drop = TRUE)
stopifnot(length(unique(epochs$ParticipantID)) == 11L, nlevels(participant_phase_bout) == 44L)
lme_optim_control <- nlme::lmeControl(opt = "optim")

# Moshammer et al. (2019): random-effects GLS per dB
moshammer_block <- H4_MOSHAMMER$run(epochs)

# Jin, Jin & Kang (2020): two-way ANOVA, LAeq level x UTCI category
jin_block <- H4_JIN$run(epochs)

# Song et al. (2013, 2014): one-sided paired t-test, park vs city walk
song_block <- H4_SONG$run(epochs)

# Rodrigues et al. (2026): Noise and Temperature blocks of 7.Model_H2.py
rodrigues_block <- H4_RODRIGUES$run(epochs, lme_optim_control)

# Kraus et al. (2013): additive mixed models on 5-min intervals (lag 0 only)
kraus_block <- H4_KRAUS$run(epochs, lme_optim_control)

primary_label <- 'ucm_SND_dBA (primary)'
tag_sound <- function(results, label, suffix = '') { results$sound_variable <- label; results$test <- paste0(results$test, suffix); results }
primary_results <- list(tag_sound(moshammer_block$results, primary_label), tag_sound(jin_block$results, primary_label),
  tag_sound(song_block$results, 'not applicable (park vs city setting contrast)'),
  tag_sound(rodrigues_block$results, primary_label), tag_sound(kraus_block$results, primary_label))

# Repeat the sound tests with each alternative sound variable (Song and the Rodrigues temperature block have no sound term).
alternative_sounds <- H4_SOUND$alternatives(names(epochs))
alternative_results <- list(); alternative_notes <- character(0)
for (sound in alternative_sounds) {
  suffix <- paste0(' [', sound$column, ']')
  alt_kraus <- H4_KRAUS$run(epochs, lme_optim_control, sound)
  alternative_results[[sound$column]] <- do.call(rbind, list(
    tag_sound(H4_MOSHAMMER$run(epochs, sound)$results, sound$column, suffix),
    tag_sound(H4_JIN$run(epochs, sound)$results, sound$column, suffix),
    tag_sound(H4_RODRIGUES$run(epochs, lme_optim_control, sound)$results, sound$column, suffix),
    tag_sound(alt_kraus$results, sound$column, suffix)))
  alternative_notes <- c(alternative_notes, sprintf('  - %s (%s): Kraus knot = median %.4g, slope per 1 SD = %.4g; AIC: %s', sound$column, sound$family,
    alt_kraus$knot, alt_kraus$step, paste(names(alt_kraus$selection), sub(';.*', '', unlist(alt_kraus$selection)), sep = ' ', collapse = ' | ')))}

# Results catalog: paper rule plus BH within paper x test
FDR <- do.call(H4_REPORT$catalog, c(primary_results, alternative_results))
significance_summary <- H4_REPORT$summary(FDR)

# Write the results, the summary and METHODS_NOTES.
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
notes <- c('Paper screening list: documents/H4_papers_screened.md', '', H4_REPORT$methods_notes(jin_block$counts, jin_block$cells, kraus_block$selection,
  kraus_block$intervals), c(
  '', '## Alternative sound variables',
  sprintf('- %d descriptors (8 YAMNet sound-category proportions, 15 spectral descriptors), as named in the merged CSV, each substituted for ucm_SND_dBA in every sound-dependent test: %s.', length(alternative_sounds), paste(names(alternative_sounds), collapse = ', ')),
  '- Aggregation: dBA uses the energy mean; descriptors use the arithmetic mean, and max/SD for the Rodrigues NOISE_max/NOISE_std terms.',
  '- The dB(A) thresholds of the papers do not apply to these descriptors, so they are replaced: Kraus 65 dB(A) knot -> the descriptor\'s median 5-min value, slope per 5 dB -> per 1 SD of the 5-min values; Jin 5-dB LAeq levels -> quartiles (Q1-Q4) of the 44 phase means, UTCI categories unchanged; Moshammer slope per 1 unit of the descriptor (Hz or proportion 0-1).',
  '- Not repeated: Song (setting contrast, no sound term) and the Rodrigues Temperature block (no sound term).',
  '- FDR: Benjamini-Hochberg within paper x test x sound variable (the sound variable is part of the test label), i.e. the same outcome families as the dBA analysis, applied separately per descriptor. No correction across the 24 sound variables.',
  '- Rows: the test label carries [descriptor] for the alternatives (dBA rows have no suffix); SUMMARY has a sound_variable column.',
  '- Per-descriptor Kraus knot, scale and AIC trend choices:', alternative_notes),
  H4_REPORT$not_estimable_notes(attr(FDR, 'not_estimable')))
write_result_csv <- function(table, filename) write.csv(table, file.path(outdir, filename), row.names = FALSE, na = '')
write_result_csv(significance_summary, 'SUMMARY_sound_tests_p_and_FDR.csv')
write_result_csv(FDR[setdiff(names(FDR), c('paper_rule_met', 'model_details'))], 'H4_sound_literature_tests.csv')
p3_finalize_directory(outdir)
writeLines(notes, file.path(outdir, 'METHODS_NOTES.md'))
cat('Done:', outdir, paste(list.files(outdir), collapse = ', '), '\n')

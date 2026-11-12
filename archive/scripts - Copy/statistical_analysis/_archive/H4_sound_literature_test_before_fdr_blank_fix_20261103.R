# H4_sound_literature_test.R (canonical H4 sound literature script; supersedes H4_sound_literature_tests.R, 2026-11-03)
# Outdoor literature tests applied to Paper 3 field data (merged_all_11participants_8min.csv,
# 11 participants, 4 core phases). EXACT-METHOD REWRITE 2026-11-03: each block fits the source
# paper's own model, outcomes, scales and decision rule; where the 8-min / 11-participant data cannot
# support a step, the closest literal step is used and the limitation is written to METHODS_NOTES.md.
# Sources library/H4_sound_literature_helpers.R. Also repeats every sound-dependent test with
# each alternative sound descriptor of test_H4_othersound.R substituted for ucm_SND_dBA (see METHODS_NOTES.md).
# 1 Moshammer et al. (2019): random-effects GLS (Stata xtreg, re); preceding 5-min Leq, outcome 5-8 min
#    unadjusted (Table A2) and + air temperature (Methods).
# 2 Jin, Jin & Kang (2020): two-way ANOVA, LAeq 55-60/60-65/65-70/70-75 dB(A) x summer UTCI stress
#    category, thermal comfort and overall comfort votes, no participant block, cell counts reported.
# 3 Song et al. (2013, 2014): one-sided paired t-test park (WalkG) vs city (WalkU) on heart rate, ln(HF),
#    ln(LF/HF), 1-min values averaged over the walk; P < 0.05 one-sided.
# 4 Rodrigues et al. (2026): 7.Model_H2.py, Noise [NOISE_max, NOISE_std] and Temperature [Temp_max,
#    Temp_mean] blocks, fillna(0) + StandardScaler, MixedLM REML per raw trip-summary outcome
#    (STD/MAX/MEAN/MIN), rule round(p,4) < 0.05 and |round(beta,4)| > 0.1.
# 5 Kraus et al. (2013): additive mixed model on 5-min intervals, Leq lag 0 only in 8-min bouts (lags
#    5-10 / 10-15 min not estimable); piecewise Leq at 65 dB(A), activity, trends by AIC, compound symmetry.
# q_BH = Benjamini-Hochberg within paper x test across its outcomes: an extra column, not a paper rule.
# Output: output/statistical_analysis/results/H4_sound_literature_test/ (stops if not empty):
# H4_sound_literature_tests.csv (name kept: Paper3_output_names.R validates BH families by this file name),
# SUMMARY_sound_tests_p_and_FDR.csv, METHODS_NOTES.md, H4_sound_literature_test_run_info.csv.
# Run: Rscript scripts/statistical_analysis/H4_sound_literature_test.R  (from the project root)

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run with Rscript on this file')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
.common <- file.path(dirname(.entry), 'library', 'Paper3_common.R')
.h4_helpers <- file.path(dirname(.entry), 'library', 'H4_sound_literature_helpers.R')
.output_names <- file.path(dirname(.entry), 'library', 'Paper3_output_names.R')
source(.common, local = FALSE)
source(.h4_helpers, local = FALSE)
for (pk in c('nlme', 'mgcv')) if (!requireNamespace(pk, quietly = TRUE)) stop('Required package missing: ', pk)
suppressPackageStartupMessages({ library(nlme); library(mgcv) })
root <- resolve_project_root()
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_sound_literature_test')
if (dir.exists(outdir) && length(list.files(outdir, all.files = TRUE, no.. = TRUE))) stop('Output folder already exists and is not empty: ', outdir)
started <- Sys.time()
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

# --- Moshammer et al. (2019): random-effects GLS per dB (xtreg, re) -------------------------------
moshammer_block <- H4_MOSHAMMER$run(epochs)

# --- Jin, Jin & Kang (2020): two-way ANOVA LAeq level x UTCI category ------------------------------
jin_block <- H4_JIN$run(epochs)

# --- Song et al. (2013, 2014): one-sided paired t-test, park vs city walk --------------------------
song_block <- H4_SONG$run(epochs)

# --- Rodrigues et al. (2026): 7.Model_H2.py Noise and Temperature blocks ---------------------------
rodrigues_block <- H4_RODRIGUES$run(epochs, lme_optim_control)

# --- Kraus et al. (2013): additive mixed models on 5-min intervals (lag 0 only) -------------------
kraus_block <- H4_KRAUS$run(epochs, lme_optim_control)

primary_label <- 'ucm_SND_dBA (primary)'
tag_sound <- function(results, label, suffix = '') { results$sound_variable <- label; results$test <- paste0(results$test, suffix); results }
primary_results <- list(tag_sound(moshammer_block$results, primary_label), tag_sound(jin_block$results, primary_label),
  tag_sound(song_block$results, 'not applicable (park vs city setting contrast)'),
  tag_sound(rodrigues_block$results, primary_label), tag_sound(kraus_block$results, primary_label))

# --- Alternative sound variables (test_H4_othersound.R list) substituted for ucm_SND_dBA ----------
# Every sound-dependent test is repeated with each descriptor. Song is a setting contrast without a sound
# term and the Rodrigues Temperature block has no sound term, so neither is repeated.
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
    alt_kraus$knot, alt_kraus$step, paste(names(alt_kraus$selection), sub(';.*', '', unlist(alt_kraus$selection)), sep = ' ', collapse = ' | ')))
}

# --- Results catalog: paper rule + BH within paper x test (x sound variable via the test label) -----
FDR <- do.call(H4_REPORT$catalog, c(primary_results, alternative_results))
significance_summary <- H4_REPORT$summary(FDR)

# --- Write results, SUMMARY, METHODS_NOTES, run_manifest -------------------------------------------
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
.screening <- file.path(dirname(.entry), 'library', 'H4_papers_screened.md')
.screening_lines <- if (file.exists(.screening)) c(readLines(.screening, warn = FALSE), '') else character(0)
writeLines(c(.screening_lines, H4_REPORT$methods_notes(jin_block$counts, jin_block$cells, kraus_block$selection,
  kraus_block$intervals, moshammer_block$frame), c(
  '', '## Alternative sound variables (v3)',
  sprintf('- %d descriptors from test_H4_othersound.R (8 YAMNet sound-category proportions, 15 spectral descriptors), as named in the merged CSV, each substituted for ucm_SND_dBA in every sound-dependent test: %s.', length(alternative_sounds), paste(names(alternative_sounds), collapse = ', ')),
  '- Aggregation: dBA uses the energy mean; descriptors use the arithmetic mean (as test_H4_othersound.R), and max/SD for the Rodrigues NOISE_max/NOISE_std terms.',
  '- test_H4_othersound.R only ran the Rodrigues trip block (no thresholds), so thresholds are substituted here: Kraus 65 dB(A) knot -> the descriptor\'s median 5-min value, slope per 5 dB -> per 1 SD of the 5-min values; Jin 5-dB LAeq levels -> quartiles (Q1-Q4) of the 44 phase means, UTCI categories unchanged; Moshammer slope per 1 unit of the descriptor (Hz or proportion 0-1).',
  '- Not repeated: Song (setting contrast, no sound term) and the Rodrigues Temperature block (no sound term).',
  '- FDR: Benjamini-Hochberg within paper x test x sound variable (the sound variable is part of the test label), i.e. the same outcome families as the dBA analysis, applied separately per descriptor. No correction across the 24 sound variables.',
  '- Rows: sound_variable column (primary dBA = ucm_SND_dBA (primary)); the test label carries [descriptor] for the alternatives.',
  '- Per-descriptor Kraus knot, scale and AIC trend choices:', alternative_notes)), file.path(outdir, 'METHODS_NOTES.md'))
write_result_csv <- function(table, filename) write.csv(table, file.path(outdir, filename), row.names = FALSE, na = '')
write_result_csv(significance_summary, 'SUMMARY_sound_tests_p_and_FDR.csv')
write_result_csv(FDR[setdiff(names(FDR), c('paper_rule_met', 'model_details'))], 'H4_sound_literature_tests.csv')
file_md5 <- function(path) unname(tools::md5sum(path))
write_result_csv(data.frame(
  started = format(started), completed = format(Sys.time()), script = .entry, script_md5 = file_md5(.entry),
  helpers = .h4_helpers, helpers_md5 = file_md5(.h4_helpers), common_md5 = file_md5(.common),
  output_names_md5 = file_md5(.output_names), input = input, input_md5 = file_md5(input), R = R.version.string,
  nlme = as.character(packageVersion('nlme')), mgcv = as.character(packageVersion('mgcv'))
), 'run_manifest.csv')
cat('SUCCESS', format(Sys.time()), outdir, '\n')
if (sys.nframe() == 0L) paper3_standardize_result_directory(outdir)

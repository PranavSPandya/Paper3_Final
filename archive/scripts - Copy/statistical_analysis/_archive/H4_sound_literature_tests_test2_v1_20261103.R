# H4_sound_literature_tests_test2.R (test copy; the original H4_sound_literature_tests.R is unchanged)
# Outdoor literature tests applied to Paper 3 field data (merged_all_11participants_8min.csv,
# 11 participants, 4 core phases). EXACT-METHOD REWRITE 2026-11-03: each block fits the source
# paper's own model, outcomes, scales and decision rule; where the 8-min / 11-participant data cannot
# support a step, the closest literal step is used and the limitation is written to METHODS_NOTES.md.
# Sources library/H4_sound_literature_helpers_test2.R. Original script, helpers and outputs are untouched.
# 1 Moshammer et al. (2019): random-effects GLS (Stata xtreg, re) per 1 dB(A) noise Leq, walking bouts,
#    raw RR distance / SDNN / RMSSD / VLF / LF / HF; unadjusted (Table A2) and + air temperature (Methods).
# 2 Jin, Jin & Kang (2020): two-way ANOVA, LAeq 55-60/60-65/65-70/70-75 dB(A) x summer UTCI stress
#    category, thermal comfort and overall comfort votes, no participant block, cell counts reported.
# 3 Song et al. (2013, 2014): one-sided paired t-test park (WalkG) vs city (WalkU) on heart rate, ln(HF),
#    ln(LF/HF), 1-min values averaged over the walk; P < 0.05 one-sided.
# 4 Rodrigues et al. (2026): 7.Model_H2.py, Noise [NOISE_max, NOISE_std] and Temperature [Temp_max,
#    Temp_mean] blocks, fillna(0) + StandardScaler, MixedLM REML per raw trip-summary outcome
#    (STD/MAX/MEAN/MIN), rule round(p,4) < 0.05 and |round(beta,4)| > 0.1.
# 5 Kraus et al. (2013): additive mixed model on 5-min intervals, HR / SDNN / LFnu / HFnu / LF:HF (log
#    except HR), Leq piecewise at 65 dB(A) per 5 dB, categorical activity, HR adjustment for HRV, trends
#    by AIC, weekday by AIC, random participant + compound symmetry. Lags not supportable (see notes).
# q_BH = Benjamini-Hochberg within paper x test across its outcomes: an extra column, not a paper rule.
# Output: output/statistical_analysis/results/H4_sound_literature_tests_test2/ (stops if not empty):
# H4_sound_literature_tests.csv, SUMMARY_sound_tests_p_and_FDR.csv, METHODS_NOTES.md, run_info.
# Run: Rscript scripts/statistical_analysis/H4_sound_literature_tests_test2.R  (from the project root)

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run with Rscript on this file')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
.common <- file.path(dirname(.entry), 'library', 'Paper3_common.R')
.h4_helpers <- file.path(dirname(.entry), 'library', 'H4_sound_literature_helpers_test2.R')
.output_names <- file.path(dirname(.entry), 'library', 'Paper3_output_names.R')
source(.common, local = FALSE)
source(.h4_helpers, local = FALSE)
for (pk in c('nlme', 'mgcv')) if (!requireNamespace(pk, quietly = TRUE)) stop('Required package missing: ', pk)
suppressPackageStartupMessages({ library(nlme); library(mgcv) })
root <- resolve_project_root()
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_sound_literature_tests_test2')
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

# --- Kraus et al. (2013): additive mixed models on 5-min intervals --------------------------------
kraus_block <- H4_KRAUS$run(epochs, lme_optim_control)

# --- Results catalog: paper rule + BH within paper x test ------------------------------------------
FDR <- H4_REPORT$catalog(moshammer_block$results, jin_block$results, song_block$results,
  rodrigues_block$results, kraus_block$results)
significance_summary <- H4_REPORT$summary(FDR)

# --- Write results, SUMMARY, METHODS_NOTES, run_manifest -------------------------------------------
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeLines(H4_REPORT$methods_notes(jin_block$counts, jin_block$cells, kraus_block$selection,
  kraus_block$intervals, moshammer_block$frame), file.path(outdir, 'METHODS_NOTES.md'))
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

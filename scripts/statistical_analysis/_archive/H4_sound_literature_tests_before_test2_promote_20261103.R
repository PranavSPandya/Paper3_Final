# H4_sound_literature_tests.R
# Literature-inspired tests applied to Paper 3 field data; adaptations are documented in METHODS_NOTES.md
# (merged_all_11participants_8min.csv, 11 participants, 4 core phases). Our data, their test approach.
# Each paper's own p is reported as the paper would. q = Benjamini-Hochberg FDR added by us, per test
# family across outcomes (paper x test), sound terms only.
#
# FIELD EVIDENCE SET (2026-11-02): the six climate-chamber templates (Jo 2019, Yousefinezhad 2026,
# Dehghan 2017, Molaeifar 2020, Tohidi 2025, Abbasi 2020) were REMOVED from the active pipeline and
# archived at scripts/statistical_analysis/_archive/ (tier lab_precedent_archived; old results at
# output/statistical_analysis/results/archive/H4_sound_literature_tests_chamber_blocks_20261102/).
# Replacement outdoor/naturalistic blocks (ranking and fit: documents/H4_outdoor_replacement_papers.md):
# 1 Moshammer et al. (2019): (a) phase-level LMM per cardiovascular outcome, log/HRV per CSV transform,
#    outcome ~ Leq per 5 dB + MET (+ air temperature) + (1 | ParticipantID); per-5 dB slope reported
#    with and without the temperature term (their robustness claim). (b) Road-vs-park analogue: paired
#    WalkG - WalkU phase-mean contrast, unadjusted and adjusted for delta air temperature.
# 2 Jin, Jin & Kang (2020): perception family (SEPARATE from the 26 physio outcomes): end-of-phase
#    thermal comfort and environmental comfort ~ dBA bin (>= 65) x UTCI bin (> 26), participant-blocked
#    ANOVA on 44 phase cells; noise main effect + noise x UTCI interaction (their key questions).
# 4 Song et al. (2013, 2014): their published test is a paired park-vs-city walk on one or two
#    physiological outcomes, uncorrected p < 0.05 (they used a one-sided paired t). We keep a
#    two-sided paired t and restrict the family to SDNN and RMSSD (the two cardiovascular outcomes
#    with raw p < 0.05 on the temperature-adjusted WalkG-WalkU contrast). BH is within those two
#    outcomes only. This is a family-size sensitivity of the Moshammer road-park contrast, not a
#    new exposure model, and the outcome choice follows that screen.
# 5 Rodrigues et al. (2026) ANCHOR (unchanged): trip-level mixed model, Noise block (mean, max, SD of
#    dBA, z-scored), outcomes trip mean and SD, REML, Wald z; Temperature block fitted separately.
# 6 Kraus et al. (2013) ANCHOR (unchanged): phase summaries of overlapping 5-min HRV windows, Leq
#    piecewise at 65 dBA per 5 dB, no lag, MET activity, HR adjustment for HRV, log outcomes except HR,
#    trend form and confounders chosen by AIC; outcomes HR, SDNN, LFnu, HFnu, LF/HF.
# Removed from the active set because the source measure is not in this dataset: Mahecha 2018 and
# Teixeira 2020 (smartband stress-event algorithm; our phasic/top-decile rule was not their outcome)
# and Korpilo 2024 (NDSI soundscape index and normalized-EDA beta model; personal dBA and tonic EDA
# are a different test). Burns et al. (2016) modelled noise and heart rate only, with no thermal term.
# Screened, not coded (see METHODS_NOTES.md): Tartarini 2023 Cozie (descriptive),
# Schaupp 2025 (cortisol unavailable), Lan 2024 (same green-vs-urban contrast),
# Zhang 2026 + Lam 2024 (aesthetic/PEQ scales not collected; Jin block is the perception analogue),
# Tu 2026 (mediation design not replicable), Li 2026 (EEG and odor manipulation unavailable).
# Not testable with this data: Li 2025 (hypertension), Chen 2007 (hearing threshold), Bidel 2022 (EMG),
# Jafari 2021 (cortisol, blood pressure), He 2025 (90 dB), Molaeifar 95 dB levels, Moshammer BP endpoint.
# Output: output/statistical_analysis/results/H4_sound_literature_tests/ (stops if it exists and is not
# empty). Top level: SUMMARY, H4_sound_literature_tests.csv (all sound-family p and q), METHODS_NOTES.md,
# run_manifest.csv (publish limit: 5 files); per-block detail CSVs in details/ (Rodrigues Temperature
# block coefficients live only in details/7_Rodrigues2026_mixed_model.csv, not in the sound FDR catalog).
# Run: Rscript scripts/statistical_analysis/H4_sound_literature_tests.R  (from the project root)

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
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_sound_literature_tests')
if (dir.exists(outdir) && length(list.files(outdir, all.files = TRUE, no.. = TRUE))) stop('Output folder already exists and is not empty: ', outdir)
started <- Sys.time()
outcomes <- paper3_physiological_outcomes()
transforms <- paper3_read_outcome_transforms_csv(outcomes, root)
input <- paper3_merged_8min_path(root)
epochs <- read.csv(input, check.names = FALSE)
epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% PAPER3_CORE_PHASES, , drop = FALSE]
epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = 'UTC')
stopifnot(!anyNA(epochs$Datetime), !anyDuplicated(epochs[c('ParticipantID', 'PhaseID', 'Datetime')]))
epochs <- epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
hrv_window_available <- tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c('true', '1')
for (column_name in attr(outcomes, 'empatica_hrv_fd_window')) epochs[[column_name]][!hrv_window_available] <- NA_real_
participant_phase_bout <- interaction(epochs$ParticipantID, epochs$PhaseID, drop = TRUE)
stopifnot(length(unique(epochs$ParticipantID)) == 11L, nlevels(participant_phase_bout) == 44L)
epochs$Time10 <- as.integer(round((as.numeric(epochs$Datetime) - ave(as.numeric(epochs$Datetime), participant_phase_bout, FUN = min)) / 10))
for (local_outcome in outcomes) epochs[[paste0(local_outcome, '__tr')]] <- paper3_apply_csv_transform(epochs[[local_outcome]], local_outcome, transforms)
lme_optim_control <- nlme::lmeControl(opt = "optim")

# Phase-level exposure/outcome frame (44 participant x phase cells) shared by Moshammer and Jin.
phase_frame <- build_phase_frame(epochs, outcomes, participant_phase_bout)

# --- Moshammer et al. (2019) (a): temperature-adjusted phase-level LMM, per-5 dB Leq slope -------
moshammer_lmm_results <- do.call(rbind, lapply(H4_CARDIOVASCULAR_OUTCOMES, function(outcome_name) {
  moshammer_lmm_rows(phase_frame, outcome_name, lme_optim_control)
}))
moshammer_lmm_results$q_BH <- ave(moshammer_lmm_results$p, moshammer_lmm_results$spec, FUN = benjamini_hochberg)

# --- Moshammer et al. (2019) (b): road-vs-park analogue (paired WalkG - WalkU +/- delta temp) ----
moshammer_roadpark_results <- do.call(rbind, lapply(H4_CARDIOVASCULAR_OUTCOMES, function(outcome_name) {
  moshammer_roadpark_row(phase_frame, outcome_name)
}))
moshammer_roadpark_results$q_BH_unadjusted <- benjamini_hochberg(moshammer_roadpark_results$p_paired_unadjusted)
moshammer_roadpark_results$q_BH_adjusted <- benjamini_hochberg(moshammer_roadpark_results$p_contrast_temp_adjusted)

# --- Song et al. (2013, 2014): same WalkG-WalkU contrast, family limited to SDNN and RMSSD ------
song_primary_outcomes <- c('empatica_hrv_td_sdnn', 'empatica_hrv_td_rmssd')
song_primary_results <- moshammer_roadpark_results[match(song_primary_outcomes, moshammer_roadpark_results$outcome), , drop = FALSE]
song_primary_results$q_BH_unadjusted <- benjamini_hochberg(song_primary_results$p_paired_unadjusted)
song_primary_results$q_BH_adjusted <- benjamini_hochberg(song_primary_results$p_contrast_temp_adjusted)

# --- Jin, Jin & Kang (2020): perception family, dBA bin x UTCI bin participant-blocked ANOVA -----
jin_block <- run_jin_perception_block(phase_frame)
jin_results <- jin_block$jin_results
jin_cell_counts <- jin_block$jin_cell_counts
jin_results$q_BH_dba <- benjamini_hochberg(jin_results$p_dba)
jin_results$q_BH_utci <- benjamini_hochberg(jin_results$p_utci)
jin_results$q_BH_interaction <- benjamini_hochberg(jin_results$p_dba_x_utci)

# --- Rodrigues et al. (2026) ANCHOR: trip-level mixed models (noise and temperature blocks) ------
trip_summaries <- build_trip_summaries(epochs, outcomes, participant_phase_bout)
rodrigues_results <- run_rodrigues_models(trip_summaries, outcomes, lme_optim_control)
rodrigues_results$retained_Rodrigues_rule <- is.finite(rodrigues_results$p) & rodrigues_results$p < 0.05 & abs(rodrigues_results$beta) > 0.1
rodrigues_results$q_BH_26_per_term <- ave(
  rodrigues_results$p, rodrigues_results$block, rodrigues_results$outcome_summary, rodrigues_results$term, FUN = benjamini_hochberg)

# --- Kraus et al. (2013) ANCHOR: phase-level Leq piecewise mixed models (5 dB segments at 65 dBA) -
kraus_block <- run_kraus_block(epochs, lme_optim_control)
kraus_results <- kraus_block$kraus_results
kraus_model_selection <- kraus_block$kraus_model_selection
rownames(kraus_results) <- NULL
kraus_results$q_BH_5_per_term <- ave(kraus_results$p, kraus_results$term, FUN = benjamini_hochberg)

# --- Benjamini-Hochberg FDR catalog (one family per source test x outcomes) ----------------------
all_tests_fdr <- build_fdr_catalog(
  moshammer_lmm_results, moshammer_roadpark_results, jin_results,
  rodrigues_results, kraus_results, song_primary_results)
all_tests_fdr <- finalize_fdr_reporting(all_tests_fdr)
all_tests_fdr$statistic_test <- NA_character_
all_tests_fdr$statistic_test[all_tests_fdr$paper == 'Moshammer2019' & startsWith(all_tests_fdr$test, 'phase LMM')] <- 't-test (mixed-model coefficient)'
all_tests_fdr$statistic_test[all_tests_fdr$paper == 'Song2014' & all_tests_fdr$test == 'paired WalkG-WalkU phase means (unadjusted)'] <- 'paired t-test (two outcomes only)'
all_tests_fdr$statistic_test[all_tests_fdr$paper == 'Song2014' & all_tests_fdr$test == 'paired WalkG-WalkU adjusted for delta air temperature'] <- 't-test (ANCOVA intercept; two outcomes only)'
all_tests_fdr$statistic_test[all_tests_fdr$paper != 'Song2014' & all_tests_fdr$test == 'paired WalkG-WalkU phase means (unadjusted)'] <- 'paired t-test'
all_tests_fdr$statistic_test[all_tests_fdr$paper != 'Song2014' & all_tests_fdr$test == 'paired WalkG-WalkU adjusted for delta air temperature'] <- 't-test (ANCOVA intercept: delta outcome ~ delta air temperature)'
all_tests_fdr$statistic_test[all_tests_fdr$paper == 'Jin2020_perception'] <- 'f-test (participant-blocked ANOVA)'
all_tests_fdr$statistic_test[all_tests_fdr$paper == 'Rodrigues 2026'] <- 'Wald z-test'
all_tests_fdr$statistic_test[all_tests_fdr$paper == 'Kraus 2013'] <- 't-test (mixed-model coefficient)'
FDR <- all_tests_fdr

# --- Write SUMMARY, FDR table, METHODS_NOTES, run_manifest (details/ holds per-block tables) -----
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
details_dir <- file.path(outdir, 'details')
dir.create(details_dir, recursive = TRUE, showWarnings = FALSE)
writeLines(c(
  'Field adaptations; not exact experimental replications. Field evidence set of 2026-11-02.',
  'CHAMBER REMOVAL: the six climate-chamber templates (Jo 2019, Yousefinezhad 2026, Dehghan 2017, Molaeifar 2020, Tohidi 2025, Abbasi 2020) are no longer part of the active H4 pipeline. Code: scripts/statistical_analysis/_archive/H4_sound_literature_tests_chamber_blocks_20261102.R (+ helpers); results: output/statistical_analysis/results/archive/H4_sound_literature_tests_chamber_blocks_20261102/. They remain citable as laboratory precedent (tier lab_precedent_archived), not as H4 field tests. Replacement ranking and fit assessment: documents/H4_outdoor_replacement_papers.md.',
  'Moshammer et al. (2019): source = 1-h outdoor walks (Vienna road vs park), class-1 LAeq, ambulatory ECG-HRV + BP every 15 min, air temperature retained as the dominant covariate. (a) Our phase-level LMM uses energy-mean phase Leq per 5 dB with MET activity, reported with and without the air-temperature term (their robustness claim); blood pressure unavailable; 8 cardiovascular outcomes match their ECG endpoints. (b) Road-vs-park analogue maps onto paired WalkG-WalkU phase means; the temperature-adjusted contrast is the intercept of lm(delta outcome ~ delta air temperature), n = 11 pairs.',
  'Jin, Jin & Kang (2020): PERCEPTION FAMILY, separate from the 26 physio outcomes. End-of-phase questionnaire items (thermal comfort 1-5 primary, environmental comfort mean as overall-comfort analogue) on 44 phase cells; dBA bin = phase Leq >= 65 dBA, UTCI bin = phase mean UTCI > 26 C; participant-blocked ANOVA with additive main-effect F tests and a full-model interaction F test. Phase cells are imbalanced (quiet-hot cell n = 3); bins are observational, not assigned chamber levels. Source finding (higher traffic noise lowers thermal comfort; season-dependent temperature x noise interaction) maps onto our dBA main effect and dBA x UTCI interaction.',
  'Song et al. (2013 winter; 2014 spring): source = 15-min park vs city walks, paired t-test, one-sided p < 0.05, on heart rate and HRV, with no multiplicity correction and no sound-level or temperature term. Our block reuses the Moshammer WalkG-WalkU phase-mean contrast and keeps only SDNN and RMSSD, the two cardiovascular outcomes with raw p < 0.05 on the temperature-adjusted contrast. BH is within those two outcomes. The unadjusted paired t is their test; the temperature-adjusted intercept is reported beside it because that is the contrast those two p-values come from. Two-sided p-values are used, matching the rest of H4. Outcome choice follows the eight-outcome Moshammer screen, so this block is a family-size sensitivity, not an independent confirmatory test.',
  'Rodrigues et al. (2026) ANCHOR (unchanged): trip-level participant-intercept mixed models; published block used NOISE_max and NOISE_std (z-scored) from an Lden map - we add noise_mean for logged personal uCM dBA. REML, Wald p values; source retention p < 0.05 and |beta| > 0.1; we also apply BH-FDR within each noise term. The Temperature block is fitted for parity with the source but is excluded from H4_sound_literature_tests.csv (sound FDR catalog); see details/7_Rodrigues2026_mixed_model.csv.',
  'Kraus et al. (2013) ANCHOR (unchanged): source used 5-min windows. One observation per participant x phase; HRV is averaged over available overlapping 5-min estimates, while Leq and covariates summarize the full phase. No individual 5-min window is selected or temporally matched here. No lagged outcome because consecutive windows are separate phases. Source sound lags are not reproduced. Kraus did not model air temperature (time trend + activity adjustment only).',
  'Removed, not the same test: Mahecha 2018 and Teixeira 2020 (smartband stress-event algorithm is not in this dataset); Korpilo 2024 (NDSI and normalized-EDA beta model are not in this dataset); Burns 2016 (noise and heart rate only, no thermal term).',
  'Screened, not coded: Tartarini et al. 2023 Cozie (descriptive smartwatch data); Schaupp et al. 2025 (salivary cortisol unavailable); Lan et al. 2024 (same green-vs-urban contrast); Zhang et al. 2026 and Lam et al. 2024 (aesthetic/PEQ scales not collected); Tu et al. 2026 (mediation design not replicable on 44 phase cells); Li et al. 2026 (EEG and odor unavailable).',
  'Raw p and q values are preserved. BH-FDR is applied within each family (one paper test across its outcomes or sound terms), not across the whole set of papers.',
  'reporting_eligible is a reporting gate, not proof of scientific validity. Review-pending branches (Rodrigues, Kraus anchors) retain their raw results but are excluded from reportable significance flags.',
  'Degenerate or non-estimable fits are recorded with a note instead of terminating the run.'
), file.path(outdir, 'METHODS_NOTES.md'))
write_detail_csv <- function(table, filename, main = FALSE, subdir = details_dir) if (main) write.csv(table, file.path(outdir, filename), row.names = FALSE, na = '') else write.csv(table, file.path(subdir, filename), row.names = FALSE, na = '')
detail_tables <- list(
  list(phase_frame, '0_phase_frame_exposure_summaries.csv'),
  list(moshammer_lmm_results, '1_Moshammer2019_phase_LMM.csv'),
  list(moshammer_roadpark_results, '2_Moshammer2019_roadpark_paired.csv'),
  list(song_primary_results, '2b_Song2014_SDNN_RMSSD_paired.csv'),
  list(jin_results, '4_Jin2020_perception_ANOVA.csv'),
  list(jin_cell_counts, '4_Jin2020_perception_cell_counts.csv'),
  list(rodrigues_results, '7_Rodrigues2026_mixed_model.csv'),
  list(kraus_results, '8_Kraus2013_mixed_model.csv'),
  list(kraus_model_selection, '8_Kraus2013_AIC_selection.csv'))
invisible(lapply(detail_tables, function(pair) write_detail_csv(pair[[1]], pair[[2]])))
significance_summary <- build_significance_summary(
  moshammer_lmm_results, moshammer_roadpark_results, jin_results,
  rodrigues_results, kraus_results, song_primary_results)
write_detail_csv(significance_summary, 'SUMMARY_sound_tests_p_and_FDR.csv', main = TRUE)
write_detail_csv(FDR, 'H4_sound_literature_tests.csv', main = TRUE)
file_md5 <- function(path) unname(tools::md5sum(path))
write_detail_csv(data.frame(
  started = format(started), completed = format(Sys.time()), script = .entry, script_md5 = file_md5(.entry),
  common_md5 = file_md5(.common), input = input, input_md5 = file_md5(input), R = R.version.string,
  nlme = as.character(packageVersion('nlme')), mgcv = as.character(packageVersion('mgcv'))
), 'run_manifest.csv', main = TRUE)
cat('SUCCESS', format(Sys.time()), outdir, '\n')
if (sys.nframe() == 0L) paper3_standardize_result_directory(outdir)

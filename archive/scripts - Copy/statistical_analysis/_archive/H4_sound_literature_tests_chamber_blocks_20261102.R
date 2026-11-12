# H4_sound_literature_tests.R
# Literature-inspired tests applied to Paper 3 field data; adaptations are documented in METHODS_NOTES.md
# (merged_all_11participants_8min.csv, 11 participants, 4 core phases). Our data, their test approach.
# Each paper's own p is reported as the paper would. q = Benjamini-Hochberg FDR added by us, per test
# family across outcomes (26 outcomes; 5 for Kraus), sound terms only.
#
# 1 Jo et al. (2019): paired one-sided t-tests (green vs urban) on HR, ln HF, ln LF/HF.
# 2 Yousefinezhad et al. (2026): 4 conditions (Control, Heat, Noise, Heat+Noise), RM-ANOVA (Mauchly, GG) or
#   Friedman when not normal, Wilcoxon signed-rank post hoc. Heat = UTCI > 26 C, Noise = dBA >= 65
#   (their WBGT 30.62 C + 75 dBA give no epochs in this data).
# 3 Dehghan et al. (2017): Friedman test across the same 4 conditions.
# 4 Molaeifar et al. (2020): paired t-test, Hot+Loud vs reference Cool+Quiet (same cut-offs).
# 5 Tohidi et al. (2025): two-factor field adaptation (source abstract reports THREE factors incl. sound type), air temperature 20/25/30 C x noise 55/65/75/85 dBA (nearest level).
# 6 Abbasi et al. (2020): two-factor field adaptation (source also used 18 C), air temperature 22/26/30 C x noise 55/75 dBA (nearest level).
# 7 Rodrigues et al. (2026): trip-level mixed model, Noise block (mean, max, SD of dBA, z-scored), outcomes
#   trip mean and SD, REML, Wald z; Temperature block fitted separately (reported, not sound).
# 8 Kraus et al. (2013)-inspired adaptation: phase summaries of overlapping 5-min HRV windows, Leq piecewise at 65 dBA per 5 dB, no lag, MET activity,
#   HR adjustment for HRV, log outcomes except HR, trend form and confounders chosen by AIC; outcomes
#   HR, SDNN, LFnu, HFnu, LF/HF.
# Not testable with this data: Li 2025 (hypertension), Chen 2007 (hearing threshold), Bidel 2022 (EMG),
#   Jafari 2021 (cortisol, blood pressure), He 2025 (90 dB), Molaeifar 95 dB levels.
# Output: output/statistical_analysis/results/H4_sound_literature_tests/ (stops if it exists and is not empty). Saves 4 files: SUMMARY, 9_FDR table, METHODS_NOTES.md, run_manifest.csv. Includes BH-FDR q for every test (9_FDR_all_tests_p_and_q.csv).
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

# Shared observational 2x2 cut-offs (UTCI > 26 C, dBA >= 65) — label sets differ by paper block.
condition_levels <- c('Control', 'Heat', 'Noise', 'Heat+Noise')
exposure_cells <- c('Cool+Quiet', 'Hot+Quiet', 'Cool+Loud', 'Hot+Loud')
epochs$Condition <- assign_observational_2x2(epochs$ucm_UTCI, epochs$ucm_SND_dBA, condition_levels)
epochs$cell <- assign_observational_2x2(epochs$ucm_UTCI, epochs$ucm_SND_dBA, exposure_cells)
valid_temp_and_dba <- is.finite(epochs$ucm_AIR_temp) & is.finite(epochs$ucm_SND_dBA)
phase_means <- aggregate(epochs[paste0(outcomes, '__tr')], epochs[c('ParticipantID', 'PhaseID')], function(x) mean(x, na.rm = TRUE))

# --- Jo et al. (2019): green vs urban paired one-sided t-tests (HR, ln HF, ln LF/HF) ---
jo_one_sided_alternatives <- c(
  empatica_heart_rate = 'less', empatica_hrv_fd_hf = 'greater', empatica_hrv_fd_lf_hf_ratio = 'less')
jo_outcome_row <- function(outcome_name, transport_mode) {
  tr <- paste0(outcome_name, '__tr')
  paired_means <- merge(
    phase_means[phase_means$PhaseID == paste0(transport_mode, 'G'), c('ParticipantID', tr)],
    phase_means[phase_means$PhaseID == paste0(transport_mode, 'U'), c('ParticipantID', tr)],
    by = 'ParticipantID')
  paired_means <- paired_means[is.finite(paired_means[[2]]) & is.finite(paired_means[[3]]), ]
  result_row <- data.frame(
    mode = transport_mode, contrast = paste0(transport_mode, 'G_minus_', transport_mode, 'U'), outcome = outcome_name,
    transform = outcome_transform_label(transforms, outcome_name), n_pairs = nrow(paired_means),
    mean_green = NA, mean_urban = NA, mean_diff = NA, ci_low = NA, ci_high = NA, t = NA, df = NA, p_two_sided = NA,
    jo_one_sided_direction = if (outcome_name %in% names(jo_one_sided_alternatives)) {
      paste('Green', ifelse(jo_one_sided_alternatives[[outcome_name]] == 'less', '<', '>'), 'Urban')
    } else 'not in Jo et al. (2019)',
    p_one_sided_Jo = NA)
  pt <- paired_t_from_columns(paired_means, 2L, 3L)
  if (is.finite(pt$p)) {
    result_row[c('mean_green', 'mean_urban', 'mean_diff', 'ci_low', 'ci_high', 't', 'df', 'p_two_sided')] <-
      list(pt$mean_a, pt$mean_b, pt$mean_diff, pt$ci[1], pt$ci[2], pt$t, pt$df, pt$p)
    if (outcome_name %in% names(jo_one_sided_alternatives)) {
      result_row$p_one_sided_Jo <- t.test(paired_means[[2]], paired_means[[3]], paired = TRUE, alternative = jo_one_sided_alternatives[[outcome_name]])$p.value}
  }
  result_row}
jo_results <- do.call(rbind, lapply(c('Walk', 'Bike'), function(mode) {
  paired_t_outcome_rows(outcomes, function(outcome_name) jo_outcome_row(outcome_name, mode))
}))
jo_results$q_BH_two_sided_52 <- benjamini_hochberg(jo_results$p_two_sided)
jo_results$q_BH_one_sided_Jo_6 <- benjamini_hochberg(jo_results$p_one_sided_Jo)

# --- Yousefinezhad et al. (2026): four-condition RM-ANOVA (Mauchly, GG) or Friedman; Wilcoxon post hoc ---
# --- Dehghan et al. (2017): Friedman across same four conditions (p_friedman in condition_results) ---
four_condition_block <- run_four_condition_block(epochs, transforms, outcomes, condition_levels)
condition_results <- four_condition_block$condition_results
condition_posthoc_results <- four_condition_block$condition_posthoc_results
epochs_per_condition_by_participant <- as.data.frame.matrix(table(epochs$ParticipantID, factor(epochs$Condition, condition_levels)))
condition_results$q_BH_global_26 <- benjamini_hochberg(condition_results$p_global)
condition_posthoc_results$q_BH_26_per_comparison <- ave(condition_posthoc_results$p_wilcoxon, condition_posthoc_results$comparison, FUN = benjamini_hochberg)

# --- Molaeifar et al. (2020): paired t-test Hot+Loud vs Cool+Quiet ---
epochs_per_exposure_cell <- as.data.frame.matrix(table(epochs$ParticipantID, factor(epochs$cell, exposure_cells)))
hot_loud_paired_results <- paired_t_outcome_rows(outcomes, function(outcome_name) {
  paired_t_hot_loud_vs_cool_quiet_row(epochs, outcome_name, epochs$cell, exposure_cells)
})
hot_loud_paired_results$q_BH_26 <- benjamini_hochberg(hot_loud_paired_results$p_paired_t)

# --- Tohidi et al. (2025) and Abbasi et al. (2020): participant-blocked two-way ANOVA on snapped temp x noise ---
# design keys Tohidi2025 / Abbasi2020 match SUMMARY and 9_FDR `paper` column labels (outline results table).
factorial_designs <- list(
  Tohidi2025 = list(T = c(20, 25, 30), N = c(55, 65, 75, 85)),
  Abbasi2020 = list(T = c(22, 26, 30), N = c(55, 75)))
factorial_block <- run_factorial_designs(epochs, outcomes, factorial_designs, valid_temp_and_dba)
factorial_results <- factorial_block$factorial_results
factorial_cell_means <- factorial_block$factorial_cell_means
factorial_results$q_Temp_26 <- ave(factorial_results$p_Temp, factorial_results$design, FUN = benjamini_hochberg)
factorial_results$q_Noise_26 <- ave(factorial_results$p_Noise, factorial_results$design, FUN = benjamini_hochberg)
factorial_results$q_TempxNoise_26 <- ave(factorial_results$p_TempxNoise, factorial_results$design, FUN = benjamini_hochberg)

# --- Rodrigues et al. (2026): trip-level mixed models (noise and temperature blocks, z-scored dBA) ---
trip_summaries <- build_trip_summaries(epochs, outcomes, participant_phase_bout)
rodrigues_results <- run_rodrigues_models(trip_summaries, outcomes, lme_optim_control)
rodrigues_results$retained_Rodrigues_rule <- is.finite(rodrigues_results$p) & rodrigues_results$p < 0.05 & abs(rodrigues_results$beta) > 0.1
rodrigues_results$q_BH_26_per_term <- ave(
  rodrigues_results$p, rodrigues_results$block, rodrigues_results$outcome_summary, rodrigues_results$term, FUN = benjamini_hochberg)

# --- Kraus et al. (2013): phase-level Leq piecewise mixed models (5 dB per segment at 65 dBA) ---
kraus_block <- run_kraus_block(epochs, lme_optim_control)
kraus_results <- kraus_block$kraus_results
kraus_model_selection <- kraus_block$kraus_model_selection
rownames(kraus_results) <- NULL
kraus_results$q_BH_5_per_term <- ave(kraus_results$p, kraus_results$term, FUN = benjamini_hochberg)

# --- Benjamini-Hochberg FDR catalog (one family per source test x outcomes) ---
condition_results$q_friedman_26 <- benjamini_hochberg(condition_results$p_friedman)
all_tests_fdr <- build_fdr_catalog(jo_results, condition_results, condition_posthoc_results, hot_loud_paired_results, factorial_results, rodrigues_results, kraus_results)
all_tests_fdr <- finalize_fdr_reporting(all_tests_fdr, condition_results, condition_posthoc_results)
factorial_results$reporting_status <- 'Participant-blocked linear-model ANOVA'
kraus_results$reporting_status <- 'Phase-level summaries of overlapping 5-min HRV estimates; no lagged outcome'
FDR <- all_tests_fdr

# --- Write SUMMARY, FDR table, METHODS_NOTES, run_manifest ---
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeLines(c(
  'Field adaptations; not exact experimental replications.',
  'Jo et al. (2019): full 8-min phases vs 60-s source playback; only HR, HF and LF/HF match the source directional endpoints. The other outcomes are extensions. We map the source sound-only playback contrast onto green-vs-urban phase comparisons, so the test is not sound-specific (field confounding acknowledged).',
  'Yousefinezhad et al. (2026): UTCI > 26 C and 65 dBA are our observational cut-offs, not the original WBGT and noise assignments. Omnibus condition differences are not automatically sound-specific effects.',
  'Dehghan et al. (2017): source used seven conditions with three noise levels and change-from-baseline scores; here Friedman on four field-mapped conditions (Control, Heat, Noise, Heat+Noise).',
  'Molaeifar et al. (2020): source hazardous sound was 95 dB vs 65 dB reference; our dBA >= 65 loud cut-off equals their reference, so contrast direction and level meaning differ. The source five exposure/workload modes and baseline/time measurements are not reproduced by our two-condition comparison.',
  'Tohidi et al. (2025) / Abbasi et al. (2020): two-way ANOVA on participant cell means at the nearest source level, with participant as a fixed blocking factor; additive main-effect F tests and full-model interaction F test. Tohidi abstract reports three factors incl. sound type; Abbasi also used 18 C.',
  'Rodrigues et al. (2026): trip-level participant-intercept mixed models; published block used NOISE_max and NOISE_std (z-scored) from an Lden map—we add noise_mean for logged personal uCM dBA. REML, Wald p values; source retention p < 0.05 and |beta| > 0.1; we also apply BH-FDR within each noise term.',
  'Kraus et al. (2013): source used 5-min windows. One observation per participant x phase; HRV is averaged over available overlapping 5-min estimates, while Leq and covariates summarize the full phase. No individual 5-min window is selected or temporally matched here. No lagged outcome because consecutive windows are separate phases. Source sound lags are not reproduced.',
  'Raw p and q values are preserved. BH-FDR is applied within each family (one paper test across its outcomes), not across the whole set of papers.',
  'reporting_eligible is a reporting gate, not proof of scientific validity. Review-pending branches retain their raw results but are excluded from reportable significance flags.',
  'Constant-difference paired tests are skipped instead of terminating the run.'
), file.path(outdir, 'METHODS_NOTES.md'))
write_detail_csv <- function(table, filename, main = FALSE) if (main) write.csv(table, file.path(outdir, filename), row.names = FALSE, na = '')
detail_tables <- list(
  list(jo_results, '1_Jo2019_paired_ttests.csv'), list(condition_results, '2_Yousefinezhad2026_RMANOVA_Friedman.csv'),
  list(condition_posthoc_results, '2_Yousefinezhad2026_posthoc_wilcoxon.csv'),
  list(cbind(ParticipantID = rownames(epochs_per_condition_by_participant), epochs_per_condition_by_participant), '2_Yousefinezhad2026_epochs_per_condition.csv'),
  list(hot_loud_paired_results, '4_Molaeifar2020_paired_t_HotLoud_vs_CoolQuiet.csv'),
  list(factorial_results, '5_6_Tohidi2025_Abbasi2020_twoway_ANOVA.csv'), list(factorial_cell_means, '5_6_cell_means.csv'),
  list(rodrigues_results, '7_Rodrigues2026_mixed_model.csv'), list(kraus_results, '8_Kraus2013_mixed_model.csv'),
  list(kraus_model_selection, '8_Kraus2013_AIC_selection.csv'))
invisible(lapply(detail_tables, function(pair) write_detail_csv(pair[[1]], pair[[2]])))
significance_summary <- build_significance_summary(jo_results, condition_results, condition_posthoc_results, hot_loud_paired_results, factorial_results, rodrigues_results, kraus_results)
write_detail_csv(significance_summary, 'SUMMARY_sound_tests_p_and_FDR.csv', main = TRUE)
write_detail_csv(FDR, '9_FDR_all_tests_p_and_q.csv', main = TRUE)
file_md5 <- function(path) unname(tools::md5sum(path))
write_detail_csv(data.frame(
  started = format(started), completed = format(Sys.time()), script = .entry, script_md5 = file_md5(.entry),
  common_md5 = file_md5(.common), input = input, input_md5 = file_md5(input), R = R.version.string,
  nlme = as.character(packageVersion('nlme')), mgcv = as.character(packageVersion('mgcv'))
), 'run_manifest.csv', main = TRUE)
cat('SUCCESS', format(Sys.time()), outdir, '\n')
if (sys.nframe() == 0L) paper3_standardize_result_directory(outdir)

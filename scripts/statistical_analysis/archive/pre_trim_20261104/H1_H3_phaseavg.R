# H1-H3 phase-average analysis (engine: library/H1_H3_core.R).
# Output: output/statistical_analysis/results/H1_H3_phaseavg/ (extra detail files with PAPER3_WRITE_DETAILS=1).

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = c("nlme", "emmeans", "ggplot2", "statpsych"),
  load_packages = c("nlme", "emmeans", "ggplot2", "statpsych"),
  extra_setup = function() emmeans::emm_options(msg.interaction = FALSE))
PROJECT_ROOT <- resolve_project_root()

# Shared study settings
study_wide_spec <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = paper3_physiological_outcomes())

# Outcome transforms come from Normalization_H1toH4_all_parameters.csv.
study_wide_spec <- paper3_attach_outcome_normalization(study_wide_spec, PROJECT_ROOT)
OUTCOME_TRANSFORMS_CSV <- study_wide_spec$outcome_transforms_csv
# Step B (H1-H3): (x - mean(x | ParticipantID)) / sd(x | ParticipantID)
PAPER3_OUTCOME_WITHIN_PERSON_Z <- paper3_within_person_z

# Hypothesis specs; the outcome definitions come from one shared source.
h1_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)
h3_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)
# The 18 questionnaire items are added by the core.
h2_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)

# Planned contrasts: H1 = green vs urban (within mode); H3 = walk vs bike (within environment).
planned_h1_h3 <- paper3_h1_h3_planned_contrast_tables()
h1_hypothesis_spec$contrasts <- planned_h1_h3$h1
h3_hypothesis_spec$contrasts <- planned_h1_h3$h3

# Difference of differences on the 2x2 phase layout: (BikeG - BikeU) - (WalkG - WalkU)


# ---- H1 and H3 models (one set: green vs urban and walk vs bike use the same LMMs) ----
# Y = transformed outcome; Y_within_person_z = within-person z of Y.

H1_PhaseMean_Primary_LMM <- quote(
  nlme::lme(Y ~ PhaseID, random = ~ 1 | ParticipantID, data = participant_phase_mean_table, method = "REML"))

H1_PhaseMean_Sensitivity_WPZ_LMM <- quote(
  nlme::lme(Y_within_person_z ~ PhaseID, random = ~ 1 | ParticipantID, data = participant_phase_mean_table, method = "REML"))

H1_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
    data = ten_second_epoch_table,
    method = "REML"))

# Temporal sensitivity: 60 s epochs (robustness of the AR(1) grid)
H1_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_60s_step | ParticipantID / PhaseID),
    data = sixty_second_epoch_table,
    method = "REML"))


# ---- H2 model (psychophysiological concurrence) ----
H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_mean_table))

# BH families: H1/H3 primary and WPZ (26 outcomes x 2 contrasts), H2 one family (468 pairs), temporal one per term.

run_h1_h3_phaseavg <- function() {
  source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)
  cat("==============================================================================\n")
  cat("Running H1 and H3 (plus H2): phase contrasts, rmcorr, temporal AR(1)\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(study_wide_spec$participants), paste(study_wide_spec$participants, collapse = ", ")))
  cat(sprintf("Core phases (%d): %s\n", length(study_wide_spec$phases), paste(study_wide_spec$phases, collapse = ", ")))
  cat(sprintf("H1 and H3 LMM outcomes (%d): empatica [1:13] + eyetracker [14:26] (physiological time series)\n",
              length(h1_hypothesis_spec$physiological_outcome_names)))
  cat(sprintf("H2 psychological (%d): end-of-phase questionnaires (H2 rmcorr; also H1/H3 contrasts as a separate BH-FDR family)\n",
              length(h2_hypothesis_spec$psychological_outcomes)))
  cat(sprintf("H1 contrasts: %s | H3 contrasts: %s\n\n",
              paste(h1_hypothesis_spec$contrasts$Contrast, collapse = ", "),
              paste(h3_hypothesis_spec$contrasts$Contrast, collapse = ", ")))
  h1_to_h3_pipeline_run()}

if (sys.nframe() == 0L && !isTRUE(getOption("paper3_skip_auto_run", FALSE))) run_h1_h3_phaseavg()

# Tidy final CSV presentation after all calculations.
if (sys.nframe() == 0L) p3_finalize_directory(file.path(resolve_project_root(), "output", "statistical_analysis", "results", "H1_H3_phaseavg"))

# H1–H3 participant-phase (phase-average, non-time-series) inferential analysis — meeting spec (engine: H1_H3_core.R)
# Outputs: output/statistical_analysis/results/H1_H3_phaseavg/: H1_H3_Contrasts.csv, H2_Concordance.csv,
#   H1_H3_Temporal_AR1.csv, H1_to_H3_Statistical_Results_ForestPlot.jpg, H1_to_H3_Run_Manifest.csv
#   (PAPER3_WRITE_DETAILS=1 also writes the per-hypothesis H1_/H2_/H3_ files and H1_to_H3_Model_Audit.csv)
# H4: scripts/statistical_analysis/Analysis_combined_timeseries.R

if (!exists("PAPER3_PARTICIPANTS", inherits = FALSE)) {
  .entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (!length(.entry)) {
    .trail <- commandArgs(trailingOnly = TRUE)
    if (length(.trail) && file.exists(.trail[1])) .entry <- .trail[1]
  }
  if (length(.entry)) {
    source(file.path(dirname(normalizePath(.entry[1], mustWork = FALSE)), "library", "Paper3_common.R"), local = FALSE)
  } else if (file.exists(file.path("library", "Paper3_common.R"))) {
    source(file.path("library", "Paper3_common.R"), local = FALSE)
  }
}
paper3_source_statistical_common_if_needed()
paper3_statistical_bootstrap(
  required_packages = c("nlme", "emmeans", "ggplot2", "statpsych"),
  load_packages = c("nlme", "emmeans", "ggplot2", "statpsych"),
  extra_setup = function() emmeans::emm_options(msg.interaction = FALSE)
)
PROJECT_ROOT <- resolve_project_root()

# Shared study settings
study_wide_spec <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = paper3_physiological_outcomes()
)

# Outcome normalization: transformation_in_models in Normalization_H1toH4_all_parameters.csv
study_wide_spec <- paper3_attach_outcome_normalization(study_wide_spec, PROJECT_ROOT)
NORMALIZATION_CSV_PATH <- study_wide_spec$normalization_csv_path
OUTCOME_TRANSFORMS_CSV <- study_wide_spec$outcome_transforms_csv
PAPER3_APPLY_CSV_TRANSFORM <- function(x, column_name) {
  paper3_apply_csv_transform(x, column_name, OUTCOME_TRANSFORMS_CSV)
}
# Step B (H1–H3): (x - mean(x | ParticipantID)) / sd(x | ParticipantID)
PAPER3_OUTCOME_WITHIN_PERSON_Z <- paper3_within_person_z

# Separate hypothesis specifications; the outcome definitions share one source.
h1_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)
h3_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)
h2_hypothesis_spec <- list(
  physiological_outcome_names = study_wide_spec$physiological_outcome_names,
  psychological_outcomes = c(
    # Comfort / affect (single items)
    "questionnaire_current_comfort_1_7",
    "questionnaire_space_familiarity_1_5",
    "questionnaire_pleasantness_1_5",
    # Environmental comfort (five dimensions; no roll-up mean)
    "questionnaire_thermal_comfort_1_5",
    "questionnaire_acoustic_comfort_1_5",
    "questionnaire_visual_comfort_1_5",
    "questionnaire_air_quality_comfort_1_5",
    "questionnaire_odor_comfort_1_5",
    # STAI-6 (six oriented item scores; no scale mean)
    "questionnaire_stai_calm_rev_1_5",
    "questionnaire_stai_tense_1_5",
    "questionnaire_stai_upset_1_5",
    "questionnaire_stai_relaxed_rev_1_5",
    "questionnaire_stai_content_rev_1_5",
    "questionnaire_stai_worried_1_5",
    # PRS-11 (four subscales; no total mean)
    "questionnaire_prs11_fascination_mean_1_5",
    "questionnaire_prs11_being_away_mean_1_5",
    "questionnaire_prs11_coherence_mean_1_5",
    "questionnaire_prs11_scope_mean_1_5"
  )
)

# Planned contrasts: H1 = green vs urban (within mode); H3 = walk vs bike (within environment).
planned_h1_h3 <- paper3_h1_h3_planned_contrast_tables()
h1_hypothesis_spec$contrasts <- planned_h1_h3$h1
h3_hypothesis_spec$contrasts <- planned_h1_h3$h3

# Difference-of-differences on the 2×2 PhaseID layout (reported alongside planned contrasts):
#   (BikeG − BikeU) − (WalkG − WalkU)


# ==============================================================================
# EXPLICIT MODELS — H1 (green infrastructure vs reference routes)
# ==============================================================================
# Y = PAPER3_APPLY_CSV_TRANSFORM(x_raw, <outcome>); Y_within_person_z = Step B after Step A (PAPER3_OUTCOME_WITHIN_PERSON_Z).

H1_PhaseMean_Primary_LMM <- quote(
  nlme::lme(Y ~ PhaseID, random = ~ 1 | ParticipantID, data = participant_phase_mean_table, method = "REML")
)

H1_PhaseMean_Sensitivity_WPZ_LMM <- quote(
  nlme::lme(Y_within_person_z ~ PhaseID, random = ~ 1 | ParticipantID, data = participant_phase_mean_table, method = "REML")
)

H1_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
    data = ten_second_epoch_table,
    method = "REML"
  )
)

# H1 — temporal sensitivity: 60 s epoch aggregation (robustness to AR(1) grid)
H1_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_60s_step | ParticipantID / PhaseID),
    data = sixty_second_epoch_table,
    method = "REML"
  )
)


# ==============================================================================
# EXPLICIT MODELS — H3 (active travel mode contrasts)
# ==============================================================================
H3_PhaseMean_Primary_LMM <- quote(
  nlme::lme(Y ~ PhaseID, random = ~ 1 | ParticipantID, data = participant_phase_mean_table, method = "REML")
)

H3_PhaseMean_Sensitivity_WPZ_LMM <- quote(
  nlme::lme(Y_within_person_z ~ PhaseID, random = ~ 1 | ParticipantID, data = participant_phase_mean_table, method = "REML")
)

H3_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
    data = ten_second_epoch_table,
    method = "REML"
  )
)

H3_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_60s_step | ParticipantID / PhaseID),
    data = sixty_second_epoch_table,
    method = "REML"
  )
)


# ==============================================================================
# EXPLICIT MODEL — H2 (psychophysiological concurrence)
# ==============================================================================
H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_mean_table)
)

# FDR families: H1 primary / H1 WPZ / H3 primary / H3 WPZ (26 outcomes × 2 contrasts each within hypothesis);
# H2 one family (18 questionnaires × 26 physiological = 468 pairs);
# temporal one family per fixed-effect Term (26 outcomes; supports H1 & H3 phase contrasts from shared PhaseID effects).

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
  h1_to_h3_pipeline_run()
}

run_h1_and_h3 <- run_h1_h3_phaseavg

if (sys.nframe() == 0L && !isTRUE(getOption("paper3_skip_auto_run", FALSE))) run_h1_h3_phaseavg()

# Normalize final CSV presentation only after all analysis/report calculations.
if (sys.nframe() == 0L) paper3_standardize_result_directory(file.path(resolve_project_root(), "output", "statistical_analysis", "results", "H1_H3_phaseavg"))

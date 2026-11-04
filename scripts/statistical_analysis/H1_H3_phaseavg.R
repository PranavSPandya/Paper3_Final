# H1-H3 phase-average analysis: phase-mean contrasts, H2 rmcorr and temporal AR(1) models (shared code: library/H1_H3_core.R).
# Output: output/statistical_analysis/results/H1_H3_phaseavg/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = c("nlme", "emmeans", "statpsych", "data.table"),
  load_packages = c("nlme", "emmeans", "statpsych"),
  extra_setup = function() emmeans::emm_options(msg.interaction = FALSE))
PROJECT_ROOT <- resolve_project_root()
OUT_DIR <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "H1_H3_phaseavg")

# Shared study settings; outcome transforms come from Normalization_H1toH4_all_parameters.csv.
study_wide_spec <- paper3_attach_outcome_normalization(list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = paper3_physiological_outcomes()), PROJECT_ROOT)

# Planned contrasts: H1 = green vs urban (within mode); H3 = walk vs bike (within environment).
planned_h1_h3 <- paper3_h1_h3_planned_contrast_tables()

# ---- H1 and H3 models (one set: green vs urban and walk vs bike use the same LMMs) ----
# Y = transformed outcome; Y_within_person_z = within-person z of Y.

H1_PhaseMean_Primary_LMM <- quote(
  nlme::lme(Y ~ PhaseID, random = ~ 1 | ParticipantID, data = participant_phase_mean_table, method = "REML"))

H1_PhaseMean_Sensitivity_WPZ_LMM <- quote(
  nlme::lme(Y_within_person_z ~ PhaseID, random = ~ 1 | ParticipantID, data = participant_phase_mean_table, method = "REML"))

# ---- H2 model (psychophysiological concurrence) ----
H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_mean_table))

# BH families: each H1/H3 contrast is its own family over the 26 outcomes (primary and WPZ separately);
# H2 is one family over the fitted pairs; the temporal models have one family per term.
if (sys.nframe() == 0L) {

  source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)
  h1_h3_run_phaseavg()}

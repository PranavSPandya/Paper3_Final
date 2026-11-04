# H1-H3 outcome-only 10 s AR(1) time-series models (shared code: library/H1_H3_core.R); H2 rmcorr is only in H1_H3_phaseavg.R.
# Output: output/statistical_analysis/results/H1_H3_timeseries/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = "nlme",
  load_packages = "nlme")
PROJECT_ROOT <- resolve_project_root()
OUT_DIR <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "H1_H3_timeseries")

study_wide_spec <- paper3_attach_outcome_normalization(list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = paper3_physiological_outcomes()), PROJECT_ROOT)

# ---- 10 s and 60 s AR(1) models (outcome-only, sum-to-zero phase coding) ----
# Y_within_person_z: transformed outcome, then within-person z on the 10 s rows.
Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = ten_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"))

Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = sixty_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"))

if (sys.nframe() == 0L) {
  source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)
  h1_h3_run_timeseries()}

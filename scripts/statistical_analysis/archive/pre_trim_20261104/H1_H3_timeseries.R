# H1-H3 outcome-only 10 s AR(1) time-series models (engine: library/H1_H3_core.R); H2 rmcorr is only in H1_H3_phaseavg.R.
# Output: output/statistical_analysis/results/H1_H3_timeseries/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = "nlme",
  load_packages = "nlme")
PROJECT_ROOT <- resolve_project_root()
H1_H3_TIMESERIES_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/H1_H3_timeseries.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)

study_wide_spec <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = paper3_physiological_outcomes())

study_wide_spec <- paper3_attach_outcome_normalization(study_wide_spec, PROJECT_ROOT)
OUTCOME_TRANSFORMS_CSV <- study_wide_spec$outcome_transforms_csv
PAPER3_OUTCOME_WITHIN_PERSON_Z <- paper3_within_person_z

h1_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)
h3_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)
# The 18 questionnaire items are added by the core.
h2_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)

planned_h1_h3 <- paper3_h1_h3_planned_contrast_tables()
h1_hypothesis_spec$contrasts <- planned_h1_h3$h1
h3_hypothesis_spec$contrasts <- planned_h1_h3$h3

# ---- Time-series models shared by H1 / H2 / H3 (outcome-only, sum-to-zero PhaseID) ----
# Y_within_person_z: transformed outcome, then within-person z on the 10 s rows.
TimeSeries_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = ten_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"))

TimeSeries_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = sixty_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"))

H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_mean_table))

# Start the shared engine.
initialize_h1_h3_timeseries <- function() {
  assign("PAPER3_TIME_SERIES_ENGINE", TRUE, envir = .GlobalEnv)
  assign("TIME_SERIES_SCRIPT_PATH", H1_H3_TIMESERIES_SCRIPT_PATH, envir = .GlobalEnv)
  source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)
  h1_h3_install_time_series_globals()}

run_h1_h3_timeseries <- function() {
  initialize_h1_h3_timeseries()
  h1_h3_time_series_dispatch_from_env()}

if (sys.nframe() == 0L || interactive()) run_h1_h3_timeseries() else initialize_h1_h3_timeseries()

# Tidy final CSV presentation after all calculations.
if (sys.nframe() == 0L) p3_finalize_directory(file.path(resolve_project_root(), "output", "statistical_analysis", "results", "H1_H3_timeseries"))

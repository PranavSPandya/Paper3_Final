# H5 10 s epochs — prespecified within-person coupling LMMs with AR(1) (exploratory).
# Engine: library/H5_coupling_core.R
# Outputs: output/statistical_analysis/results/H5_stress_composite_timeseries/

if (!exists("PAPER3_PARTICIPANTS", inherits = FALSE)) {
  .entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (!length(.entry)) {
    .trail <- commandArgs(trailingOnly = TRUE)
    if (length(.trail) && file.exists(.trail[1])) .entry <- .trail[1]}
  if (length(.entry)) {
    source(file.path(dirname(normalizePath(.entry[1], mustWork = FALSE)), "library", "Paper3_common.R"), local = FALSE)
  } else if (file.exists(file.path("library", "Paper3_common.R"))) {
    source(file.path("library", "Paper3_common.R"), local = FALSE)}
}
paper3_source_statistical_common_if_needed()
paper3_statistical_bootstrap(
  required_packages = c("nlme"),
  load_packages = c("nlme"))
PROJECT_ROOT <- resolve_project_root()
LIBRARY_DIR <- paper3_statistical_library_dir()
physio_all <- paper3_physiological_outcomes()

H5_SPEC <- list(
  analysis_grain = "timeseries",
  results_subdir = "H5_stress_composite_timeseries",
  entry_script = "H5_stress_composite_timeseries.R",
  file_prefix = "H5_stress_composite_timeseries",
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = physio_all,
  physio_outcomes = c("empatica_eda_tonic", "empatica_hrv_td_rmssd"),
  env_index_names = c("thermal_load", "acoustic_load", "restorative_stress"),
  env_index_constituents = list(
    thermal_load = list(column = "ucm_UTCI", stress_direction = 1L),
    acoustic_load = list(column = "ucm_SND_dBA", stress_direction = 1L)
  ),
  restorative_constituents = c("SVF", "TVF", "gvi_50m"),
  morphology_stress_direction = c(SVF = -1L, TVF = -1L, gvi_50m = -1L),
  transparent_eye_constituents = list(
    eyetracker_fixation_rate = 1L,
    eyetracker_fixation_duration_s = -1L,
    eyetracker_pupil_diameter_avg = 1L,
    eyetracker_blink_duration_s = 1L
  ),
  psych_outcomes = c(
    "questionnaire_prs11_fascination_mean_1_5",
    "questionnaire_stai_tense_1_5",
    "questionnaire_acoustic_comfort_1_5"
  ),
  fdr_alpha = 0.05)

H5_SPEC <- paper3_attach_outcome_normalization(H5_SPEC, PROJECT_ROOT)
PAPER3_APPLY_CSV_TRANSFORM <- function(x, column_name) {
  paper3_apply_csv_transform(x, column_name, H5_SPEC$outcome_transforms_csv)}

run_h5_stress_composite_timeseries <- function() {
  source(file.path(LIBRARY_DIR, "H5_coupling_core.R"), local = FALSE)
  cat("Running H5 prespecified coupling LMMs (10 s epochs, AR(1))...\n")
  h5_coupling_run()}

if (sys.nframe() == 0L) run_h5_stress_composite_timeseries()

if (sys.nframe() == 0L) {
  paper3_standardize_result_directory(
    file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "H5_stress_composite_timeseries"))}

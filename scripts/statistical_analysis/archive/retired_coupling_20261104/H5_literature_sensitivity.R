# H5 — literature-style sensitivity tests (exploratory; separate output folder).
# Johnson multivar env->physio; Van Doren psych–physio rmcorr. Rodrigues → H4 only.
# Output: output/statistical_analysis/results/H5_literature_sensitivity/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = c("nlme"),
  load_packages = c("nlme")
)
PROJECT_ROOT <- resolve_project_root()
LIBRARY_DIR <- paper3_statistical_library_dir()

physio_all <- paper3_physiological_outcomes()

H5_LIT_SPEC <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physio_outcomes = physio_all,
  physiological_outcome_names = physio_all,
  fdr_alpha = 0.05,
  results_subdir = "H5_literature_sensitivity",
  file_prefix = "H5_literature",
  entry_script = "H5_literature_sensitivity.R",
  env_columns = list(
    atmo_pm1_avg = list(column = "atmo_pm1_avg", stress_direction = 1L),
    atmo_pm2.5_avg = list(column = "atmo_pm2.5_avg", stress_direction = 1L),
    atmo_pm10_avg = list(column = "atmo_pm10_avg", stress_direction = 1L),
    ucm_SND_dBA = list(column = "ucm_SND_dBA", stress_direction = 1L),
    ucm_UTCI = list(column = "ucm_UTCI", stress_direction = 1L),
    ucm_AIR_temp = list(column = "ucm_AIR_temp", stress_direction = 1L),
    gvi_50m = list(column = "gvi_50m", stress_direction = -1L),
    SVF = list(column = "SVF", stress_direction = -1L)
  ),
  physio_stress_direction = c(
    empatica_heart_rate = 1L, empatica_eda_tonic = 1L,
    empatica_hrv_td_sdnn = -1L, empatica_hrv_td_rmssd = -1L,
    empatica_skin_temperature = 1L
  ),
  johnson_predictors = c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "ucm_SND_dBA"),
  johnson_outcomes = c("empatica_eda_tonic", "empatica_heart_rate", "empatica_hrv_td_rmssd"),
  psych_columns = c(
    questionnaire_pleasantness_1_5 = -1L,
    questionnaire_stai_tense_1_5 = 1L,
    questionnaire_prs11_fascination_mean_1_5 = -1L
  ),
  vandoren_physio = c("empatica_eda_tonic", "empatica_heart_rate", "empatica_hrv_td_rmssd")
)
H5_LIT_SPEC <- paper3_attach_outcome_normalization(H5_LIT_SPEC, PROJECT_ROOT)
PAPER3_APPLY_CSV_TRANSFORM <- function(x, column_name) {
  paper3_apply_csv_transform(x, column_name, H5_LIT_SPEC$outcome_transforms_csv)
}

run_h5_literature_sensitivity <- function() {
  source(file.path(LIBRARY_DIR, "H5_literature_sensitivity_core.R"), local = FALSE)
  h5_literature_sensitivity_run()
}

if (sys.nframe() == 0L) {
  run_h5_literature_sensitivity()
  OUT_DIR <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "H5_literature_sensitivity")
  p3_finalize_directory(OUT_DIR)
}

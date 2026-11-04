# H5 — pairwise rmcorr of stress-oriented env and physiological composites (no questionnaires).
# Engine: library/H5_stress_composite_pairwise_core.R. Outputs: H5_stress_composite_pairwise/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = character(),
  load_packages = character()
)
PROJECT_ROOT <- resolve_project_root()
LIBRARY_DIR <- paper3_statistical_library_dir()

physio_outcomes <- paper3_physiological_outcomes()

# stress_direction: +1 = higher raw value implies higher stress; -1 = lower raw implies higher stress (after WPZ, multiply by sign).
h6_env_constituents <- list(
  ucm_UTCI = list(column = "ucm_UTCI", stress_direction = 1L),
  ucm_PET = list(column = "ucm_PET", stress_direction = 1L),
  ucm_MRT = list(column = "ucm_MRT", stress_direction = 1L),
  ucm_AIR_temp = list(column = "ucm_AIR_temp", stress_direction = 1L),
  ucm_AIR_RH = list(column = "ucm_AIR_RH", stress_direction = 1L),
  ucm_WIND_AWS = list(column = "ucm_WIND_AWS", stress_direction = 1L),
  ucm_SUN_Gh = list(column = "ucm_SUN_Gh", stress_direction = 1L),
  ucm_SND_dBA = list(column = "ucm_SND_dBA", stress_direction = 1L),
  ucm_HUMIDEX = list(column = "ucm_HUMIDEX", stress_direction = 1L),
  atmo_pm1_avg = list(column = "atmo_pm1_avg", stress_direction = 1L),
  atmo_pm2.5_avg = list(column = "atmo_pm2.5_avg", stress_direction = 1L),
  atmo_pm10_avg = list(column = "atmo_pm10_avg", stress_direction = 1L),
  lys_lux_avg = list(column = "lys_lux_avg", stress_direction = 1L),
  lys_medi_avg = list(column = "lys_medi_avg", stress_direction = 1L),
  lys_kelvin_avg = list(column = "lys_kelvin_avg", stress_direction = 1L),
  ucm_AIR_T_mid = list(column = "ucm_AIR_T_mid", stress_direction = 1L),
  SVF = list(column = "SVF", stress_direction = -1L),
  TVF = list(column = "TVF", stress_direction = -1L),
  BVF = list(column = "BVF", stress_direction = 1L),
  gvi_50m = list(column = "gvi_50m", stress_direction = -1L),
  ucm_GPS_speed_kmh = list(column = "ucm_GPS_speed_kmh", stress_direction = 1L)
)

h6_physio_stress_direction <- c(
  empatica_heart_rate = 1L, empatica_eda_tonic = 1L, empatica_eda_phasic = 1L,
  empatica_skin_temperature = 1L,
  empatica_hrv_td_sdnn = -1L, empatica_hrv_td_rmssd = -1L,
  empatica_hrv_fd_lf = -1L, empatica_hrv_fd_hf = -1L,
  empatica_hrv_fd_lf_hf_ratio = 1L, empatica_hrv_fd_lfnu = 1L, empatica_hrv_fd_hfnu = -1L,
  empatica_hrv_fd_vlf = -1L, empatica_hrv_fd_total_power = -1L,
  eyetracker_pupil_diameter_avg = 1L, eyetracker_pupil_change_rate = 1L,
  eyetracker_blink_duration_s = 1L, eyetracker_fixation_duration_s = -1L,
  eyetracker_fixation_rate = 1L, eyetracker_saccade_duration_s = 1L,
  eyetracker_saccade_amplitude = 1L, eyetracker_saccade_peak_velocity = 1L,
  eyetracker_gaze_velocity = 1L, eyetracker_gaze_dispersion = 1L,
  eyetracker_distance_from_center = 1L, eyetracker_gaze_centrality = 1L,
  eyetracker_eyelid_aperture_avg = 1L
)

h6_transparent_eye_constituents <- list(
  eyetracker_fixation_rate = 1L,
  eyetracker_fixation_duration_s = -1L,
  eyetracker_pupil_diameter_avg = 1L,
  eyetracker_blink_duration_s = 1L
)

h6_optional_env_groups <- list(
  env_group_thermal = list(
    label = "Environmental group: thermal load",
    constituents = c("ucm_UTCI", "ucm_PET", "ucm_MRT", "ucm_HUMIDEX", "ucm_AIR_temp")
  ),
  env_group_acoustic = list(
    label = "Environmental group: sound",
    constituents = c("ucm_SND_dBA")
  ),
  env_group_air_quality = list(
    label = "Environmental group: PM2.5",
    constituents = c("atmo_pm2.5_avg")
  ),
  env_group_light = list(
    label = "Environmental group: ambient light",
    constituents = c("lys_lux_avg", "lys_kelvin_avg")
  ),
  env_group_morphology = list(
    label = "Environmental group: sky–tree–building + GVI",
    constituents = c("SVF", "TVF", "BVF", "gvi_50m")
  ),
  env_group_motion = list(
    label = "Environmental group: travel speed",
    constituents = c("ucm_GPS_speed_kmh")
  )
)

H6_SPEC <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = physio_outcomes,
  env_constituents = h6_env_constituents,
  physio_stress_direction = h6_physio_stress_direction,
  transparent_eye_constituents = h6_transparent_eye_constituents,
  optional_env_groups = h6_optional_env_groups,
  include_optional_env_groups = TRUE,
  proprietary_eye_column = "eyetracker_stress_composite",
  proprietary_eye_stress_direction = 1L,
  min_rows_rmcorr = 20L,
  min_participants_rmcorr = 8L,
  fdr_alpha = 0.05,
  analysis_grain = "phaseavg",
  results_subdir = "H5_stress_composite_pairwise"
)

H6_SPEC <- paper3_attach_outcome_normalization(H6_SPEC, PROJECT_ROOT)
PAPER3_APPLY_CSV_TRANSFORM <- function(x, column_name) {
  paper3_apply_csv_transform(x, column_name, H6_SPEC$outcome_transforms_csv)
}

run_h6_stress_composite <- function() {
  source(file.path(LIBRARY_DIR, "H5_stress_composite_pairwise_core.R"), local = FALSE)
  cat("Running H5 pairwise env–physio composite rmcorr (no questionnaires)...\n")
  h6_dispatch_run()
}

if (sys.nframe() == 0L) run_h6_stress_composite()

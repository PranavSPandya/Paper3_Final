# H5 Urban Climate quality pass — spatial/date fixes, optional elapsed adjustment, LOPO (engine: H5_hotspot_core.R)
# Baseline snapshot (pre-change): archive/H5_exploratory_baseline_20261028_pre_uc_quality/
#
# Runs (set H5_UC_RUN):
#   spatial_fix  — route_distance resets per session Date; fixed replication audit
#   elapsed      — spatial_fix + median_end_time_s adjustment in RH1
#   lopo         — elapsed spec; writes H5_RH1_lopo_hotspot_coefficients.csv (no full coef dump per fold)

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
  required_packages = c("nlme", "lme4"),
  load_packages = c("nlme", "lme4")
)
PROJECT_ROOT <- resolve_project_root()
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)

h5_uc_base_spec <- function(results_subdirectory, elapsed = FALSE, lopo = FALSE) {
  spec <- list(
    participants = PAPER3_PARTICIPANTS,
    phases = PAPER3_CORE_PHASES,
    physiological_outcome_names = paper3_physiological_outcomes(),
    green_phases = c("WalkG", "BikeG"),
    route_distance_bin_m = 20L,
    pilot_walkg_only = FALSE,
    hotspot_inclusion_rule = "spatial_9of11",
    spatial_proximity_radius_m = 30L,
    min_participants_shared_place = 9L,
    min_participants_per_shared_bin = 2L,
    min_rows_per_model = 30L,
    min_replication_participant_hotspot_days = 5L,
    min_epochs_per_hotspot_day = 1L,
    rh1_stratify_by_phase = TRUE,
    rh1_outcome_scope = "all",
    rh1_use_phase_median_response = FALSE,
    rh1_primary_outcomes = c(
      "empatica_eda_tonic", "empatica_skin_temperature",
      "eyetracker_pupil_diameter_avg", "eyetracker_fixation_rate"
    ),
    exploratory_fdr_family = "within_outcome_x_phase",
    run_rh1_only = TRUE,
    rh1_include_temporal_lag = FALSE,
    rh1_include_cumulative_exposure = FALSE,
    rh1_include_elapsed_time_adjustment = elapsed,
    rh1_elapsed_term = "env_median_end_time_s_c",
    results_subdirectory = results_subdirectory,
    environment_moderator_column = "ucm_UTCI",
    outlier_z_threshold = 2,
    slope_column = "gps_segment_slope_pct",
    slope_source = "derived_point_to_point_ucm_GPS_alt_over_haversine_step_m",
    slope_status = "derived_not_in_merge_csv",
    slope_min_horizontal_m = 1,
    derived_exposure_columns = "gps_segment_slope_pct",
    exposure_columns = c(
      "SVF", "TVF", "BVF", "gps_segment_slope_pct", "gvi_50m",
      "ucm_UTCI", "ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_SUN_Gh",
      "ucm_SND_dBA", "ucm_PET", "ucm_MRT", "atmo_pm2.5_avg", "lys_lux_avg"
    ),
    sensitivity_covariate_columns = c(
      "ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_SUN_Gh", "ucm_SND_dBA",
      "ucm_PET", "ucm_MRT", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m"
    ),
    reactivity_outcomes = paper3_physiological_outcomes(),
    use_campaign_baseline_centering = TRUE,
    fit_participant_hotspot_random_slopes = TRUE,
    exploratory_fdr_alpha = 0.05
  )
  paper3_attach_outcome_normalization(spec, PROJECT_ROOT)
}

run_h5_uc_quality <- function(run = c("spatial_fix", "elapsed", "lopo")) {
  run <- match.arg(run)
  core_path <- file.path(paper3_statistical_library_dir(), "H5_hotspot_core.R")
  if (!file.exists(core_path)) stop("Missing H5 hotspot engine: ", core_path, call. = FALSE)
  source(core_path, local = FALSE)

  if (run == "spatial_fix") {
    spec <- h5_uc_base_spec("uc_quality_20261028_spatial_fix", elapsed = FALSE)
    h5s_dispatch_run(
      spec = spec, project_root = PROJECT_ROOT,
      script_path = normalizePath("scripts/statistical_analysis/H5_hotspot_uc_quality.R", mustWork = FALSE),
      raw_data_path = RAW_DATA_PATH
    )
  } else if (run == "elapsed") {
    spec <- h5_uc_base_spec("uc_quality_20261028_elapsed", elapsed = TRUE)
    h5s_dispatch_run(
      spec = spec, project_root = PROJECT_ROOT,
      script_path = normalizePath("scripts/statistical_analysis/H5_hotspot_uc_quality.R", mustWork = FALSE),
      raw_data_path = RAW_DATA_PATH
    )
  } else if (run == "lopo") {
    spec <- h5_uc_base_spec("uc_quality_20261028_lopo", elapsed = TRUE)
    h5s_run_lopo_rh1(spec = spec, project_root = PROJECT_ROOT, raw_data_path = RAW_DATA_PATH)
  }
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  run <- if (length(args)) args[1] else "all"
  if (identical(run, "all")) {
    for (step in c("spatial_fix", "elapsed", "lopo")) run_h5_uc_quality(step)
  } else {
    run_h5_uc_quality(run)
  }
}

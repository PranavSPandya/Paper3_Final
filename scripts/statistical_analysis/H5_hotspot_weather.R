# H5 exploratory — repeated hotspot exposure × backpack environment (merged CSV only; engine: H5_hotspot_core.R)
# Person-level campaign baseline centering; RH1–RH4 LMMs; participant×hotspot heterogeneity (RH3 random slope + outlier table).
# Outputs: output/statistical_analysis/results/H5_exploratory/
#
# HOTSPOT (§8.0): corridor flat-cap buffer polygons per PhaseID (ExpData Experiment path_8min_buffer).
# Epoch uCM GPS → seg_idx (walk 11 m / bike 35 m along-route cells); all assigned cells enter RH1 (no ≥9/11 rule).
# No cumulative route distance or pct-complete binning for hotspot identity.
# Hyperlocal env: hotspot-day medians from backpack uCM (and atmo/lys on person); NOT station weather in RH1.
# External archives (e.g. Weather Underground) are for optional grid/time enrichment vs uCM — see exposure_columns / future merge.
# Hotspot CHARACTERISTICS (place-intrinsic): SVF, TVF, BVF (CamUp); gps_segment_slope_pct (derived from ucm_GPS_alt).
# Momentary MODEL variables only (not hotspot definition): ucm_UTCI, ucm_AIR_temp, ucm_AIR_RH, ucm_WIND_AWS,
#   ucm_SUN_Gh, ucm_SND_dBA, ucm_PET, ucm_MRT, atmo_pm2.5_avg, lys_lux_avg. gvi_50m = sensitivity only, not definition.

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
  required_packages = c("nlme", "lme4", "sf"),
  load_packages = c("nlme", "lme4", "sf")
)
PROJECT_ROOT <- resolve_project_root()
H5_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/H5_hotspot_weather.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)

h5_hotspot_spec <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  physiological_outcome_names = paper3_physiological_outcomes(),
  green_phases = c("WalkG", "BikeG"),
  hotspot_definition = "corridor_buffer",
  buffer_gpkg_dir = "D:/Pranav/docker/ExpData/Experiment path_8min_buffer",
  route_distance_bin_m = NULL,
  # Pilot: TRUE → WalkG only for shared-hotspot assignment and RH1; FALSE → all PAPER3_CORE_PHASES.
  pilot_walkg_only = FALSE,
  hotspot_inclusion_rule = "corridor_all_assigned",
  spatial_proximity_radius_m = NULL,
  min_participants_shared_place = NULL,
  min_participants_per_shared_bin = 2L,
  min_rows_per_model = 30L,
  min_replication_participant_hotspot_days = 5L,
  # 8-min merge yields ~1 epoch per hotspot-day pass; keep 1 here (use >=3 only if epoch cadence increases).
  min_epochs_per_hotspot_day = 1L,
  # Hotspot_id is PhaseID-specific; stratified RH1 avoids PhaseID + hotspot_f aliasing (61 levels).
  rh1_stratify_by_phase = TRUE,
  rh1_outcome_scope = "all",
  rh1_use_phase_median_response = FALSE,
  rh1_primary_outcomes = c(
    "empatica_eda_tonic", "empatica_skin_temperature",
    "eyetracker_pupil_diameter_avg", "eyetracker_fixation_rate"
  ),
  # Locked exploratory multiplicity (single p_value_FDR in H5_hotspot_core.R; hotspot_f vs env families differ).
  exploratory_fdr_family = "within_outcome_x_phase",
  # Temporary: RH1 only (RH2–RH4 and staged sensitivities disabled in core until restored).
  run_rh1_only = TRUE,
  # RH1 temporal lag (off): prior hotspot-day row UTCI within participant×phase.
  rh1_include_temporal_lag = FALSE,
  rh1_lag_term = "env_ucm_UTCI_lag1_c",
  # RH1 cumulative exposure (sensitivity): set TRUE + results_subdirectory = "cumulative" to rerun; off for primary RH1.
  rh1_include_cumulative_exposure = FALSE,
  rh1_cumulative_term = "env_ucm_UTCI_cum_c",
  results_subdirectory = "",
  # RH1 moderator: grand-mean centered median backpack uCM UTCI at hotspot-day (hyperlocal grid cell, not WU/station).
  environment_moderator_column = "ucm_UTCI",
  outlier_z_threshold = 2,
  # No terrain slope column in merged CSV; point-to-point grade from ucm_GPS_alt (see H5_hotspot_slope_audit.csv).
  slope_column = "gps_segment_slope_pct",
  slope_source = "derived_point_to_point_ucm_GPS_alt_over_haversine_step_m",
  slope_status = "derived_not_in_merge_csv",
  slope_min_horizontal_m = 1,
  derived_exposure_columns = "gps_segment_slope_pct",
  # Hotspot profile aggregation (epoch medians -> hotspot-day): intrinsic SVF/TVF/BVF/slope + momentary uCM/atmo for models.
  exposure_columns = c(
    "SVF", "TVF", "BVF", "gps_segment_slope_pct", "gvi_50m",
    "ucm_UTCI", "ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_SUN_Gh",
    "ucm_SND_dBA", "ucm_PET", "ucm_MRT", "atmo_pm2.5_avg", "lys_lux_avg"
  ),
  # RH1 primary + RH1_sens_* : exactly one additional centered hotspot-day median per sensitivity run.
  sensitivity_covariate_columns = c(
    "ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_SUN_Gh", "ucm_SND_dBA",
    "ucm_PET", "ucm_MRT", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m"
  ),
  reactivity_outcomes = paper3_physiological_outcomes(),
  # (1–2) Campaign baseline: mean outcome across all participant epochs; hotspot rows use median(center_Y).
  use_campaign_baseline_centering = TRUE,
  # (3) RH3: random slope of buffer seg index | ParticipantID (when run_rh1_only = FALSE).
  fit_participant_hotspot_random_slopes = TRUE,
  exploratory_fdr_alpha = 0.05
)

h5_hotspot_spec <- paper3_attach_outcome_normalization(h5_hotspot_spec, PROJECT_ROOT)

# ==== EXPLICIT MODELS (merged CSV backpack env; §8.7 + participant baseline) ====
# Moderator term: env_ucm_UTCI_c = median_ucm_UTCI (hotspot-day) − grand mean.
# PRIMARY RH1 — per PhaseID when rh1_stratify_by_phase=TRUE:
#   lme(median_center_Y ~ env_ucm_UTCI_c + hotspot_f, random = ~1|ParticipantID)
# Else pooled: median_center_Y ~ PhaseID + env_ucm_UTCI_c + hotspot_f
# Sensitivity (optional flags): + env_ucm_UTCI_lag1_c → results/H5_exploratory/lag/;
#   + env_ucm_UTCI_cum_c → results/H5_exploratory/cumulative/ (not GAM/GAMM; same LMM + extra linear term).
# Writes RH1_hotspot_coefficients_<outcome>.csv (hotspot_f levels + p_value_FDR) and H5_RH1_hotspot_FDR_*.csv.
# PAUSED (run_rh1_only = TRUE): RH2 green_phase interaction; RH3 route_bin random slope; RH4 mobility_mode;
#   RH1_sens_<cov> staged +1 covariate runs — see h5s_fit_models_and_sensitivity() in H5_hotspot_core.R.

run_h5_hotspot_weather <- function() {
  core_path <- file.path(paper3_statistical_library_dir(), "H5_hotspot_core.R")
  if (!file.exists(core_path)) stop("Missing H5 hotspot engine: ", core_path, call. = FALSE)
  source(core_path, local = FALSE)
  h5s_dispatch_run(
    spec = h5_hotspot_spec,
    project_root = PROJECT_ROOT,
    script_path = H5_SCRIPT_PATH,
    raw_data_path = RAW_DATA_PATH
  )
}

if (sys.nframe() == 0L) run_h5_hotspot_weather()

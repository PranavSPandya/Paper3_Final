# H4 data loading, measurement screening and exposure preparation.

# --- data prep metadata (not part of equation spec) ---
if (is.null(H4_SPEC$outcome_transform_kind)) {
  stop("Outcome normalization not configured. Source scripts/H4_multivariate.R first (outcome transformations).", call. = FALSE)
}
# bilateral_sources: left/right sensor columns row-averaged to atmo_pm2.5_avg and lys_lux_avg in h4_prepare_data().
H4_SPEC$bilateral_sources <- list(
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")
)

# --- output paths (audit/_work and published H4_results; not part of meeting spec) ---
if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H4_core.R (source scripts/H4_multivariate.R).", call. = FALSE)
}
H4_OUT_PATHS <- local({
  result_dir <- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results")
  work_dir <- file.path(result_dir, "_work")
  dir.create(work_dir, recursive = TRUE, showWarnings = FALSE)
  list(
    result_dir = result_dir,
    work_dir = work_dir,
    filtration_csv = file.path(work_dir, "H4_Multivariate_Filtration_Results.csv"),
    audit_pdf = file.path(work_dir, "H4_All_Variables_Audit.pdf"),
    stage_summary_csv = file.path(work_dir, "H4_Audit_Stage_Summary.csv"),
    integration_csv = file.path(work_dir, "H4_Integration_Readiness.csv"),
    step_category_csv = file.path(work_dir, "H4_Step_Category_Counts.csv"),
    final_outcome_counts_csv = file.path(work_dir, "H4_Final_Outcome_Counts.csv"),
    transparency_md = file.path(work_dir, "H4_Transparency_Report.md"),
    formula_txt = file.path(work_dir, "H4_Multivariate_Formula.txt"),
    phase_coverage_csv = file.path(work_dir, "H4_Phase_Coverage.csv")
  )
})
RESULT_DIR <- H4_OUT_PATHS$result_dir
OUT_DIR <- H4_OUT_PATHS$work_dir
OUT_CSV <- H4_OUT_PATHS$filtration_csv
AUDIT_PDF <- H4_OUT_PATHS$audit_pdf
STAGE_SUMMARY_CSV <- H4_OUT_PATHS$stage_summary_csv
INTEGRATION_CSV <- H4_OUT_PATHS$integration_csv
STEP_CATEGORY_CSV <- H4_OUT_PATHS$step_category_csv
FINAL_OUTCOME_COUNTS_CSV <- H4_OUT_PATHS$final_outcome_counts_csv
TRANSPARENCY_MD <- H4_OUT_PATHS$transparency_md
FORMULA_TXT <- H4_OUT_PATHS$formula_txt

# --- Configuration ---
H4_DOMAINS <- list(
  Acoustic = "ucm_SND_dBA",
  Thermal = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS"),
  Index = c("ucm_HUMIDEX", "ucm_PET", "ucm_UTCI", "ucm_OPT"),
  Radiation = c("ucm_MRT", "ucm_SUN_Gh", "SVF"),
  Pollution = c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg"),
  Light = c("lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg"),
  Greenery = "gvi_50m")
H4_FLOW_DOMAIN_ORDER <- c("Thermal", "Index", "Acoustic", "Radiation", "Pollution", "Light", "Greenery")
H4_STEP4_THERMAL_CATEGORIES <- c("Thermal", "Index")
average_sources <- list(
  atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
  atmo_pm2.5_avg = H4_SPEC$bilateral_sources$atmo_pm2.5_avg,
  atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
  lys_lux_avg = H4_SPEC$bilateral_sources$lys_lux_avg,
  lys_medi_avg = c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi"),
  lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))
PARTICIPANTS <- H4_SPEC$participants
CORE_PHASES <- H4_SPEC$phases
SOUND_QC_COLUMNS <- c(
  "segment", "end_time_s", "window_duration_s", "is_complete_10s_window", "phase_start_offset_s", "yamnet_frame_count",
  "yamnet_threshold", "original_sample_rate_hz", "frequency_analysis_min_hz", "frequency_analysis_max_hz",
  "frequency_analysis_full_20khz_coverage")
SOUND_CATEGORY_PROP_COLUMNS <- c(
  "wind_prop", "rural_natural_prop", "vehicle_prop", "urban_manmade_neutral_prop", "urban_manmade_positive_prop",
  "urban_manmade_negative_prop", "mechanisms_prop", "unidentify_prop")
# Scene shares and totals are percent of the fisheye circle (0–100).
# Total_Vegetation_% = Tree_% + Plant_% + Grass_%; Total_Builtup_% = Building_% + Wall_% + Ceiling_%.
SVF_EXPOSURE_COLUMNS <- c(
  "Sky_%", "SVF", "Tree_%", "Plant_%", "Grass_%", "Total_Vegetation_%",
  "Building_%", "Wall_%", "Ceiling_%", "Total_Builtup_%")
SVF_QC_COLUMNS <- c(
  "Filename", "Timestamp", "Camera", "Calibration", "Calibration_Table", "Run_Config_Signature", "Calibration_QC",
  "Calibration_Ref_Radius_px", "Raw_Lens_Radius_px", "Rectified_Lens_Radius_px", "Square_Hemisphere_Crop", "SVF_Method",
  "SVF_Rings", "Pitch_Roll_Correction", "Model", "Image_Path", "Segmented_Image_Path", "telemetry_matched", "Manual_Mask_Path",
  "Manual_Sky_IoU", "Manual_Sky_Dice", "Manual_Pixel_Accuracy", "Manual_SVF", "SVF_Abs_Error_vs_Manual",
  "SVF_Frames_In_Window", "SVF_Status")
EXPECTED_SOUND_FREQUENCY_COLUMNS <- c(
  "dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz", "freq_prop_20_125", "freq_prop_125_1000",
  "freq_prop_1000_4000", "freq_prop_4000_8000", "freq_prop_8000_20000", "octave_prop_31_5_hz", "octave_prop_63_0_hz",
  "octave_prop_125_0_hz", "octave_prop_250_0_hz", "octave_prop_500_0_hz", "octave_prop_1000_0_hz", "octave_prop_2000_0_hz",
  "octave_prop_4000_0_hz", "octave_prop_8000_0_hz")
H4_PHASE_SUM_COLS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")

h4_read_data <- function() {
  raw <- read.csv(RAW_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE)
  for (v in setdiff(names(average_sources), names(raw)))
    raw[[v]] <- rowMeans(raw[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  raw
}

h4_prepare_data <- function(raw) {
    required <- unique(c("ParticipantID", "PhaseID", "Datetime", "empatica_hrv_fd_5min_available", unlist(H4_SPEC$bilateral_sources),
        c("ucm_UTCI", "ucm_SND_dBA", "gvi_50m"), H4_SPEC$all_outcomes))
    missing <- setdiff(required, names(raw))
    if (length(missing)) stop("Required H4 input columns missing: ", paste(missing, collapse = ", "))
    raw <- raw[raw$ParticipantID %in% H4_SPEC$participants & raw$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
    for (v in H4_SPEC$all_outcomes) {
        raw[[v]] <- as.numeric(raw[[v]])
        raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    }
    # hrv_log columns: non-positive values excluded before ln(x) at fit time (see fit_one_outcome)
    for (v in names(H4_SPEC$outcome_transform_kind)) {
      kind <- H4_SPEC$outcome_transform_kind[[v]]
      if (kind == "log") raw[[v]][!is.na(raw[[v]]) & raw[[v]] <= 0] <- NA_real_
      if (kind == "sqrt") raw[[v]][!is.na(raw[[v]]) & raw[[v]] < 0] <- NA_real_
    }
    for (v in names(H4_SPEC$bilateral_sources)) raw[[v]] <- rowMeans(raw[, H4_SPEC$bilateral_sources[[v]], drop = FALSE],
        na.rm = TRUE)
    for (v in c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg")) raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    raw$ucm_SND_dBA[!is.na(raw$ucm_SND_dBA) & raw$ucm_SND_dBA < 0] <- NA_real_
    available <- tolower(as.character(raw$empatica_hrv_fd_5min_available)) %in% c("true", "1")
    for (v in hrv_fd_outcomes()) raw[[v]][!available] <- NA_real_
    grid <- expand.grid(ParticipantID = H4_SPEC$participants, PhaseID = H4_SPEC$phases, stringsAsFactors = FALSE)
    grid <- grid[order(match(grid$ParticipantID, H4_SPEC$participants), match(grid$PhaseID, H4_SPEC$phases)), ]
    grid$ParticipantPhase <- paste(grid$ParticipantID, grid$PhaseID, sep = "::")
    keys <- paste(raw$ParticipantID, raw$PhaseID, sep = "::")
    if (length(setdiff(grid$ParticipantPhase, keys))) stop("Required participant-phase cells absent: ", paste(setdiff(grid$ParticipantPhase, keys), collapse = ", "))
    if (anyDuplicated(raw[, c("ParticipantID", "PhaseID", "Datetime")])) stop("Duplicate 10-second timestamps in input.")
    groups <- split(seq_len(nrow(raw)), factor(keys, levels = grid$ParticipantPhase))
    variables <- unique(c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m",
        H4_SPEC$all_outcomes))
    for (v in variables) grid[[v]] <- vapply(groups, function(ix) h4_mean(raw[[v]][ix]), numeric(1))
    coverage <- do.call(rbind, lapply(variables, function(v) {
        n <- vapply(groups, function(ix) sum(is.finite(raw[[v]][ix])), integer(1))
        data.frame(ParticipantID = grid$ParticipantID, PhaseID = grid$PhaseID,
            Measure_Type = if (v %in% H4_SPEC$all_outcomes) "Outcome" else "Exposure",
            Measure = v, N_valid = n, N_expected = H4_SPEC$expected_epochs,
            Coverage_pct = round(100 * n / H4_SPEC$expected_epochs, 1),
            Coverage_pass = n > 0L, stringsAsFactors = FALSE)
    }))
    if (any(coverage$Measure_Type == "Exposure" & !coverage$Coverage_pass)) stop("An exposure has no valid phase observations.")
    if (any(lengths(groups) != H4_SPEC$expected_epochs))
        warning("Matched-window row counts differ from declared denominator ", H4_SPEC$expected_epochs, ": ", paste(names(groups)[lengths(groups) !=
            H4_SPEC$expected_epochs], collapse = ", "), call. = FALSE)
    for (v in c("atmo_pm2.5_avg", "ucm_SND_dBA", "lys_lux_avg")) if (any(grid[[v]] < 0, na.rm = TRUE)) stop("Negative phase-mean values require review: ", v)
    if (any(grid$gvi_50m < 0 | grid$gvi_50m > 100, na.rm = TRUE)) stop("GVI outside 0-100%.")
    list(data = grid, coverage = coverage)
}

is_sound_semantic <- function(x) x %in% c("category", SOUND_CATEGORY_PROP_COLUMNS, sub("_prop$", "_score", setdiff(SOUND_CATEGORY_PROP_COLUMNS, "unidentify_prop"))) | grepl("^(sound_(prop|score)_|yamnet_class_[0-9]{3}_.+_(mean_score|prop)$)", x)

is_acoustic_frequency <- function(x) grepl("^(dominant_frequency_hz|spectral_centroid_hz|spectral_rolloff85_hz|freq_prop_|octave_prop_)", x)

is_svf_exposure <- function(x) x %in% SVF_EXPOSURE_COLUMNS

# --- Measurement audit ---

# classify_col_role
classify_col_role <- function(c) {
  info <- function(role, source, unit, action, decision = "Excluded") c(source, role, unit, action, decision)
  source <- if(grepl("^ucm_", c)) "UCM Backpack" else if(grepl("^atmo_lys_", c)) "Atmo / LYS" else
    if(grepl("^eyetracker_", c)) "Pupil Labs" else if(grepl("^gvi_", c)) "GVI" else "Study Design"
  # Step 1: QC/windowing fields describe signal quality, not the environment (Empatica_data_manual.pdf).
  if(grepl("^empatica_hrv_fd_5min_", c)) return(info("Physiological Signal Quality & HRV Windowing (Empatica QC)",
    "Empatica EmbracePlus", "QC / ms\u00b2", "Excluded from exposure funnel; physiological QC and window integrity metric"))
  metadata <- c("ParticipantID","PhaseID","Datetime","Date","ucm_Date","atmo_lys_Date","eyetracker_Date",
    "ucm_GPS_lat","ucm_GPS_lon","ucm_GPS_alt","ucm_GPS_HDOP","ucm_GPS_hdg","ucm_MAG_hdg",
    "ucm_GPS_speed_valid_sample_count","pct_complete","gvi_match_dist_m")
  # Step 1: identifiers, time and GPS are design/tracking fields; PhaseID enters Step 5 as a fixed effect.
  if(c %in% metadata) return(info("Study Metadata & Spatiotemporal Tracking", source, "Metadata",
    "Excluded from exposure funnel; spatial/temporal tracking only"))
  if(c %in% SOUND_QC_COLUMNS) return(info("Acoustic Processing QC & Provenance", "YAMNet / Spectral Processing",
    if(grepl("_hz$|sample_rate",c)) "Hz" else if(grepl("duration|offset",c)) "s" else if(grepl("prop",c)) "proportion" else "QC",
    "Excluded from exposure funnel; processing provenance / completeness / spectral-coverage QC"))
  if(c %in% SVF_QC_COLUMNS) return(info("SVF Processing QC & Provenance", "CamUp / DeepLabV3+ Xception65",
    if(grepl("Radius|Center|Width|Height",c)) "px" else if(grepl("IoU|Dice|Accuracy",c)) "validation metric" else "QC",
    "Excluded from exposure funnel; SVF calibration, segmentation, provenance, or manual-validation QC"))
  if(grepl("^questionnaire_clothing_|^questionnaire_background_",c) || c %in% c("questionnaire_participant_id",
    "questionnaire_response_index_within_participant","questionnaire_height_m","questionnaire_weight_kg","questionnaire_bmi_kg_m2","questionnaire_bmi_category_who"))
    return(info("Participant Demographics & Clothing Metadata","Questionnaire","Demographic","Excluded from exposure funnel; baseline cohort characterization"))
  # Step 1: lux_cat is a deterministic binning of lys_lux (derived, information-losing).
  if(grepl("__lux_cat$",c)) return(info("Derived Light Category (not an independent continuous exposure)", "LYS", "Category",
    "Derived illuminance category; continuous lux is available; no averaged replacement exists."))
  # Step 1: movement variables are inventory/QC fields, not H4 exposure predictors.
  if(grepl("__lys_movement$",c) || c %in% c("ucm_GPS_speed_kmh","empatica__met","empatica_acc_x","empatica_acc_y","empatica_acc_z","empatica_vector_magnitude"))
    return(info("Movement Covariates (Z)", if(grepl("^ucm_",c)) "UCM Backpack" else if(grepl("^atmo_lys_",c)) "LYS" else "Empatica EmbracePlus",
      if(c=="ucm_GPS_speed_kmh") "km/h" else if(c=="empatica__met") "MET" else if(grepl("__lys_movement$",c)) "Device movement output" else "g",
      "Movement variable retained in the complete inventory; it is not an H4 exposure predictor. No LYS movement average is declared."))
  # Step 1: outcomes (Y) can never be exposures.
  if(c %in% H4_SPEC$all_outcomes) return(info("Physiological Sensor Outcomes (Y_physio)",
    if(grepl("^empatica_",c)) "Empatica EmbracePlus" else "Pupil Labs Neon",
    if(grepl("heart_rate",c)) "bpm" else if(grepl("skin_temperature",c)) "\u00b0C" else if(grepl("pupil",c)) "mm" else if(grepl("eda",c)) "\u00b5S" else if(grepl("rmssd",c)) "ms" else "Physio unit",
    "Excluded from exposure funnel; objective dependent outcome (Y)", "Retained"))
  # Other person-side fields are outside the declared physiological outcome family.
  if(grepl("^(empatica|eyetracker|questionnaire)_",c)) return(info("Sensor or Questionnaire Field Outside Declared H4 Outcome Set",
    if(grepl("^empatica_",c)) "Empatica EmbracePlus" else if(grepl("^eyetracker_",c)) "Pupil Labs Neon" else "Questionnaire",
    "Not modeled in declared H4 outcome family","Excluded from H4 model; not in the declared physiological outcome specification","EXCLUDED UNDECLARED H4 OUTCOME"))
  source <- if(grepl("^ucm_",c)) "UCM Backpack" else if(grepl("^atmo_lys_",c)) "Atmotube / LYS" else
    if(grepl("^gvi_|^tree_|^grass_|^plant_",c)) "Eye-Level Panoramic Imagery" else if(is_sound_semantic(c)) "YAMNet Audio Classification" else
    if(is_acoustic_frequency(c)) "Native-WAV Spectral Analysis" else if(is_svf_exposure(c)) "CamUp / DeepLabV3+ Xception65" else "Solar Models"
  unit <- if(grepl("temp|UTCI|PET|MRT|T_bot|T_top|T_mid|HUMIDEX",c)) "\u00b0C" else if(grepl("SND|dBA",c)) "dBA" else
    if(grepl("pm",c)) "\u00b5g/m\u00b3" else if(grepl("lux",c)) "lux" else if(grepl("medi",c)) "medi" else if(grepl("kelvin",c)) "K" else
    if(grepl("gvi|tree|grass|plant|RH",c)) "%" else if(grepl("WIND",c)) "m/s" else if(grepl("_hz$",c)) "Hz" else
    if(is_sound_semantic(c)||grepl("^freq_prop_|^octave_prop_",c)) "proportion / score" else if(c=="SVF") "0-1" else if(grepl("_%$",c)) "%" else "Physical unit"
  info("Environmental Stressor Candidates (X_env)",source,unit,"Retained for Step 2 technical sensor consolidation","RETAINED FOR FILTRATION")
}

h4_step2_representation <- function(col) {
  # Derived: kt = Gh/G0 is a deterministic ratio of ucm_SUN_Gh [ClearCI p.3 eq.2]; co-entry is redundant [Zhu24 p.3].
  if (col == "Clearness_Index") return("Derived clearness index (kt = Gh/G0); measured solar exposure is ucm_SUN_Gh [ClearCI p.3 eq.2]")
  # G0 is computed from date/time/location (solar geometry); it is the kt denominator, not an exposure [ClearCI p.3 eq.2].
  if (col == "Clearness_Index_G0") return("Calculated extraterrestrial irradiance G0 (date/time/location only), not a measured or personal exposure; denominator of Clearness_Index (kt = Gh/G0) [ClearCI p.3 eq.2]; measured solar exposure is ucm_SUN_Gh.")
  # Derived: melanopic EDI estimated from LYS RGB channels, not measured spectrally [Beiglary25 p.5; Ishihara25 p.1, p.7, p.10; Sonneborn p.1].
  if (col == "lys_medi_avg") return("Derived metric estimated from LYS RGB channels, not measured spectrally; retained light measures lys_lux_avg and lys_kelvin_avg")
  # WEAK (study choice, no source): solar geometry is a time/location proxy and an input of G0, not a personal exposure.
  if (col %in% c("ucm_SUN_alt", "ucm_SUN_az")) return("Declared Step 2 exclusion: solar altitude and solar azimuth are outside the selected exposure set")
  # Atmotube T/RH sensors are worn-device housekeeping channels; UCM T/RH are the reference instruments [CityFeel17].
  if (grepl("^atmo_lys_atmotube_(left|right)__atmotube_humidity$", col)) return("Raw-source inventory only: UCM ucm_AIR_RH is the declared relative-humidity measure")
  if (grepl("^atmo_lys_atmotube_(left|right)__atmotube_temperature$", col)) return("Raw-source inventory only: UCM ucm_AIR_temp is the declared ambient-temperature measure")
  # WEAK: _SR/_S suffix meaning (alternative formulation) not documented locally; verify in UCM manual [CityFeel17].
  if (grepl("^ucm_.*_(SR|S)$", col)) return("Derived alternate UCM formulations (_SR/_S suffix); use the corresponding unsuffixed UCM measure")
  # Derived relation: IR radiometer channels are the inputs used to compute ucm_MRT [CityFeel17]; co-entry duplicates MRT.
  if (grepl("^ucm_IR_", col)) return("Directional IR radiometer channels (inputs used to compute ucm_MRT [CityFeel17]); measured solar exposure representative is ucm_SUN_Gh; not co-entered as separate radiation predictors")
  # Wind representative = apparent wind speed AWS (airflow at the body incl. own movement; convective-cooling exposure; complete in core phases).
  if (col == "ucm_WIND_TWS") return("Derived true-wind speed (device correction from AWS and related fields); wind representative: ucm_WIND_AWS")
  if (col %in% c("ucm_WIND_AWA", "ucm_WIND_TWD")) return("Derived wind direction/angle from ucm_WIND_AWS; wind speed representative is ucm_WIND_AWS. Circular direction coding is outside the current linear wind-speed specification.")
  # AH is a deterministic function of T and RH -> redundant with ucm_AIR_temp + ucm_AIR_RH [Zhu24 p.3].
  if (col == "ucm_AH") return("Humidity representative: ucm_AIR_RH; AH is an alternative formulation")
  # Height tiers of the same air-temperature measurement; highly collinear [Zhu24 p.3].
  if (col %in% c("ucm_AIR_T_bot", "ucm_AIR_T_mid", "ucm_AIR_T_top")) return("Air-temperature representative: ucm_AIR_temp; tier channels not co-entered")
  # gvi_50m is the original GVI scale value; other buffers, components (grass/plant/tree) and phase means are derived alternatives.
  if (grepl("^gvi_|^(plant|grass|tree)_phase_mean$", col) && col != "gvi_50m") return("Vegetation representative: gvi_50m; alternative scales/components not co-entered")
  # Scene % (sky/building/tree...) are segmentation components behind SVF [Qiu17 p.1]; SVF is the standard index.
  if (is_svf_exposure(col) && col != "SVF") return("Sky openness represented by SVF; scene percentages are separate secondary constructs, not equivalent exposures")
  # Derived/redundant: ucm_OPT is operative temperature, a function of air temperature and MRT [CityFeel17].
  if (col == "ucm_OPT") return("Derived/redundant: ucm_OPT is operative temperature, derived from air temperature and MRT [CityFeel17]")
  ""
}

classify_step2_consolidation <- function(col, role, raw, availability, n_phase_cells) {
  # fp: definition undocumented; excluded until documented (not a scientific rejection).
  if (col == "ucm_fp") return(c("Measurement definition and units", "UNVERIFIED DEFINITION (EXCLUDED)",
    "The definition, units and intended interpretation of fp have not been verified against source documentation; retain in the inventory but exclude from Step 2 analytical eligibility."))
  if (role != "Environmental Stressor Candidates (X_env)") return(c("N/A - Non-Environmental Stream", "N/A",
    "Non-environmental variable (metadata, demographic, covariate, or outcome)."))
  replacement <- names(average_sources)[vapply(average_sources, function(src) col %in% src, logical(1))]
  observed <- availability[match(col, availability$Variable_Name), ]
  representation <- h4_step2_representation(col)
  if (nzchar(representation)) return(c("Declared Step 2 exposure representation", "ALTERNATIVE REPRESENTATION (EXCLUDED)", representation))
  # Frequency/semantic sound outputs are separate constructs, not substitutes for calibrated LAeq (dBA).
  if (is_acoustic_frequency(col)) return(c("Separate frequency construct", "SECONDARY FREQUENCY BLOCK (NOT CORE SCREEN)", "Core sound-level representative is ucm_SND_dBA. Spectral descriptors remain available for separate frequency analyses; they are not equivalent to dBA and are not deleted from the input."))
  if (is_sound_semantic(col)) return(c("Separate sound-type construct", "SECONDARY SOUND-TYPE BLOCK (NOT CORE SCREEN)", "Core sound-level representative is ucm_SND_dBA. Semantic sound-type outputs remain secondary; source type is not equivalent to pressure level."))
  # Bilateral raw channels are replaced by their deterministic average [Zhu24 p.3]; raw RGB/IR channels are uncalibrated
  # conversion inputs [Beiglary25 p.5; Ishihara25 p.10]; residue/labels and the indoor/outdoor flag are not continuous exposures.
  if (length(replacement)) return(c("Declared average source (exact mapping)", "CONSOLIDATED RAW CHANNEL (EXCLUDED)",
    paste0("Source of ", replacement, "; not co-entered with its own deterministic average. This is a study aggregation choice, not evidence that placement bias was eliminated. LYS1/LYS2 measure different wearer locations.")))
  if (grepl("^atmo_lys_LYS[12]__lys_(rgb|[rgb]')", col)) return(c("Auxiliary device colour channels", "AUXILIARY DEVICE CHANNEL (EXCLUDED)",
    "Exported RGB/IR or r'/g'/b' channel; no average or conversion to an independently calibrated H4 exposure is declared. Kept in the inventory, not falsely claimed to be represented by lux. Validate units/calibration and a spectral hypothesis before modeling."))
  if (col %in% c("sound_prop_unidentified", "sound_class_id", "sound_category_label")) return(c("Rule 2.5: Acoustic Residue & Discrete Classifiers",
    "RESIDUAL / DISCRETE CLASSIFIER (EXCLUDED)", "Unclassified residual prevalence and categorical labels excluded from the continuous-exposure screen; calibrated LAeq, YAMNet semantic outputs, and spectral descriptors remain separately auditable."))
  if (col == "ucm_IO_flag") return(c("Rule 2.6: Microclimate Setting Protocol Flag", "DISCRETE PROTOCOL FLAG (EXCLUDED)",
    "Discrete indoor/outdoor setting flag excluded; experimental phase protocol already stratifies outdoor travel routes."))
  if (!is.numeric(raw[[col]])) return(c("Measurement type", "NON-NUMERIC LABEL (EXCLUDED)",
    if (col == "Clearness_Index_Infer") "Derived categorical clearness inference from Clearness_Index; not a continuous numeric exposure; no valid continuous-effect parameterization is declared. The original field remains in the input. Measured solar exposure is ucm_SUN_Gh"
    else "Not a continuous numeric exposure; no valid continuous-effect parameterization is declared. The original field remains in the input."))
  # Within-person effects need >= 2 phases per participant with variation.
  if (observed$Available_Phase_Cells < 2L || observed$Available_Participants < 2L || !is.finite(observed$Within_Person_SD) || observed$Within_Person_SD < 1e-12) {
    rat <- sprintf("Only %d of %d participant-phase cells across %d participants have finite phase means; a within-person effect cannot be estimated from one phase per participant or no centered variation. No imputation; rerun eligibility after broader valid coverage.", observed$Available_Phase_Cells, n_phase_cells, observed$Available_Participants)
    return(if (is_svf_exposure(col)) c("Within-person estimability / availability", "PENDING SVF PROCESSING / MERGE", paste0("SVF pending merge; not rejected. ", rat))
      else c("Within-person estimability / availability", "INSUFFICIENT WITHIN-PERSON COVERAGE (EXCLUDED)", rat))
  }
  c(if (col %in% c("ucm_WIND_AWA", "ucm_WIND_TWD", "ucm_SUN_az")) "Circular measurement: joint sine/cosine terms required" else "Available numeric measurement",
    "Retained", sprintf("Available in %d phase cells across %d participants after declared representation rules. Eligibility is not proof of measurement validity or automatic model inclusion.", observed$Available_Phase_Cells, observed$Available_Participants))
}

h4_audit_step3 <- function(raw, candidates) {
  candidates <- sort(candidates)
  keys <- paste(raw$ParticipantID, raw$PhaseID, sep = "::")
  cells <- sort(unique(keys))
  indices <- lapply(cells, function(key) which(keys == key))
  id <- sub("::.*", "", cells)
  blocks <- setNames(lapply(candidates, function(v) matrix(vapply(indices, function(ix) h4_mean(raw[[v]][ix]), numeric(1)), ncol = 1L)), candidates)
  z <- cbind(Mode_Walk = as.numeric(grepl("::Walk", cells)))
  complete <- complete.cases(do.call(cbind, blocks), z)
  omissions <- data.frame(Cell = cells[!complete], Missing = vapply(which(!complete), function(i) paste(c(names(blocks)[!vapply(blocks,
    function(b) all(is.finite(b[i, ])), logical(1))], colnames(z)[!is.finite(z[i, ])]), collapse = ", "), character(1)))
  if (sum(complete) < 4L || length(unique(id[complete])) < 2L) stop("Insufficient common phase cells for screening.")
  center <- function(x) apply(x[complete, , drop = FALSE], 2L, h4_person_mean_center, id = id[complete])
  blocks <- lapply(blocks, center)
  z <- center(z)
  exposure <- do.call(cbind, blocks)
  colnames(exposure) <- unlist(lapply(names(blocks), function(v) if (ncol(blocks[[v]]) == 1L) v else paste0(v, "__", colnames(blocks[[v]]))))
  if (any(apply(cbind(exposure, z), 2, sd) < 1e-12)) stop("Constant column on the common screening sample; review eligibility.")
  pearson <- cor(exposure)
  spearman <- cor(exposure, method = "spearman")
  pair_index <- which(upper.tri(pearson), arr.ind = TRUE)
  pairs <- data.frame(Field1 = rownames(pearson)[pair_index[, 1]], Field2 = colnames(pearson)[pair_index[, 2]],
    Pearson_r = pearson[pair_index], Spearman_rho = spearman[pair_index], N_phase_cells = nrow(exposure))
  pairs <- pairs[order(-abs(pairs$Pearson_r)), ]
  stopifnot(setequal(names(blocks), candidates))
  list(pairs = pairs, omissions = omissions)
}

classify_step3_domain <- function(col, step2_stat) {
  if (step2_stat == "SECONDARY FREQUENCY BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT", "Preserved for separate frequency analyses; not substituted for the core dBA sound-level representative."))
  if (step2_stat == "SECONDARY SOUND-TYPE BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY SOUNDSCAPE CONSTRUCT", "Preserved for separate sound-type analyses; not substituted for the core dBA sound-level representative."))
  if (is_svf_exposure(col) && step2_stat == "PENDING SVF PROCESSING / MERGE") return(c("Sky View / Urban Morphology", "PLANNED CANDIDATE - PROCESSING PENDING", "SVF pending merge; not in the current model."))
  if (step2_stat != "Retained") return(c("N/A", "N/A", "N/A"))
  dom <- if (is_svf_exposure(col)) "Sky View / Urban Morphology" else if (grepl("gvi|tree|grass|plant", col)) "Greenery" else if (grepl("pm", col)) "Air Pollution" else if (grepl("lux|medi|kelvin", col)) "Visual Light" else if (col == "ucm_SND_dBA" || is_acoustic_frequency(col) || is_sound_semantic(col)) "Acoustic" else "Thermal"
  return(c(dom, "DATA-ELIGIBLE SCREENING CANDIDATE", "All Step-2 eligible measurements advance. Step 3 reports within-person Pearson/Spearman correlations and full matrix rank on the same complete phase cells; no health outcomes or hand-picked domain representatives enter selection."))
}

infer_audit_domain <- function(var, role, current_domain) {
    if (!is.na(current_domain) && current_domain != "-") return(current_domain)
    if (role != "Environmental Stressor Candidates (X_env)") {
      if (grepl("Physiological", role)) return("8. Physiological")
      if (grepl("Movement", role)) return("Movement")
      return("Metadata")
    }
    if (var == "ucm_SND_dBA" || is_sound_semantic(var) || is_acoustic_frequency(var)) return("1. UCM Acoustic")
    if (grepl("temp|UTCI|PET|MRT|T_mid|T_bot|T_top|HUMIDEX|OPT|AH|RH|WIND|SUN|Clearness|IR_", var, ignore.case = TRUE)) return("2. UCM Thermal")
    if (is_svf_exposure(var) || var %in% SVF_QC_COLUMNS) return("4. UCM Radiation")
    if (grepl("pm", var, ignore.case = TRUE)) return("5. Atmo Pollution")
    if (grepl("lux|medi|kelvin", var, ignore.case = TRUE)) return("6. LYS Light")
    if (grepl("gvi|tree|grass|plant", var, ignore.case = TRUE)) return("7. GVI Greenery")
    "3. UCM Index"
  }

# count_stage_categories
count_stage_categories <- function(df, category_col, retained_mask, stage_name, scope_note) {
  cats <- as.character(df[[category_col]])
  cats[is.na(cats) | cats == "" | cats == "-"] <- "Not applicable / unclassified"
  groups <- split(seq_len(nrow(df)), cats)
  do.call(rbind, lapply(names(groups), function(category) {
    ix <- groups[[category]]
    n <- sum(retained_mask[ix], na.rm = TRUE)
    data.frame(Stage = stage_name, Category = category, Total_Entering_Category = length(ix),
      Retained_to_Next_Stage = n, Not_Advanced_from_Stage = length(ix) - n, Scope = scope_note,
      stringsAsFactors = FALSE)
  }))
}

h4_run_audit <- function() {
    cat("[1/6] Loading canonical 8-minute analysis dataset...\n")
    df <- read.csv(RAW_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE)
    analysis_keys <- do.call(paste, c(df[c("ParticipantID", "PhaseID", "Datetime")], sep = "::"))
    if (anyDuplicated(analysis_keys)) stop("Duplicate merge keys in analysis input.")
    raw_cols_all <- colnames(df)
    yamnet_class_columns <- grep("^yamnet_class_[0-9]{3}_.+_(mean_score|prop)$", raw_cols_all, value = TRUE)
    yamnet_class_names <- unique(sub("_(mean_score|prop)$", "", yamnet_class_columns))
    yamnet_class_ids <- unique(sub("^yamnet_class_([0-9]{3})_.*$", "\\1", yamnet_class_names))
    if (length(yamnet_class_names) > 0L && (length(yamnet_class_names) != 521L || !setequal(yamnet_class_ids, sprintf("%03d",
        0:520)))) {
        warning("YAMNet class fields are incomplete (found ", length(yamnet_class_names), " of 521). The physical H4 model does not use YAMNet; the audit will report those fields as unavailable.",
            call. = FALSE)
    }
    df$ParticipantID <- as.character(df$ParticipantID)
    df$PhaseID <- as.character(df$PhaseID)
    df <- df[df$ParticipantID %in% PARTICIPANTS, ]
    df$ParticipantID <- factor(df$ParticipantID, levels = PARTICIPANTS)
    for (v in names(average_sources)) df[[v]] <- rowMeans(df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
    df_core <- df[df$PhaseID %in% CORE_PHASES, ]
    cat(sprintf("Loaded %d observations across %d participants (%d core outdoor epochs).\n", nrow(df), length(unique(df$ParticipantID)),
        nrow(df_core)))
    # Exclusion sources ([key]; files under Paper3_Github/Experiment papers/): [Beiglary25] Beiglary et al. 2025 JMIR Aging e72338
    # p.5; [Ishihara25] Ishihara et al. 2025 SLEEP zsaf358 p.1/p.7/p.10; [Sonneborn] Sonneborn & Voss, light field studies p.1;
    # [ClearCI] clearness index kt = Gh/G0, p.3 eq.2; [Zhu24] Zhu et al. 2024 p.3/p.5; [Joubert26] Joubert et al. 2026 mixtures workflow;
    # [Qiu17] Qiu et al. 2017 p.1 (SVF); [CityFeel17] UCM sensor table, doi:10.1016/j.egypro.2017.07.427.
    cat("[2/6] Step 1: Auditing full schema and partitioning analytical roles...\n")
    # ---- Steps 1-3: roles, consolidation and audit tables ----
    derived_cols_all <- c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg")
    all_variables_pool <- unique(c(raw_cols_all, derived_cols_all))
    step1_mat <- t(sapply(all_variables_pool, function(col) if (col %in% derived_cols_all)
      c(if (grepl("^atmo_", col)) "Atmotube" else "LYS Study Average", "Environmental Stressor Candidates (X_env)",
        if (grepl("pm", col)) "µg/m³" else if (grepl("lux", col)) "lux" else if (grepl("medi", col)) "medi" else "K",
        "Retained for Step 2 technical sensor consolidation", "RETAINED FOR FILTRATION") else classify_col_role(col)))
    cat("[3/6] Step 2: Checking explicit replacements, measurement type and within-person availability...\n")
    stopifnot(length(unlist(average_sources)) == 12L, !anyDuplicated(unlist(average_sources)))
    h4_prepared_for_vif <- h4_prepare_data(df)
    audit_phase_groups <- split(seq_len(nrow(df_core)), paste(df_core$ParticipantID, df_core$PhaseID, sep = "::"))
    audit_availability <- do.call(rbind, lapply(all_variables_pool, function(col) {
      values <- if (is.numeric(df_core[[col]])) vapply(audit_phase_groups, function(ix) h4_mean(df_core[[col]][ix]), numeric(1)) else rep(NA_real_, length(audit_phase_groups))
      ids <- sub("::.*", "", names(audit_phase_groups))
      centered <- h4_person_mean_center(values, ids)
      data.frame(Variable_Name = col, Available_Phase_Cells = sum(is.finite(values)),
        Available_Participants = length(unique(ids[is.finite(values)])),
        Within_Person_SD = if (sum(is.finite(centered)) > 1L) sd(centered, na.rm = TRUE) else NA_real_)
    }))

    step2_mat <- t(mapply(classify_step2_consolidation, all_variables_pool, step1_mat[, 2],
      MoreArgs = list(raw = df_core, availability = audit_availability, n_phase_cells = nrow(h4_prepared_for_vif$data)), USE.NAMES = FALSE))
    cat("[4/6] Step 3: Auditing every Step-2 eligible measurement; no domain shortlist...\n")
    h4_measurement_sources <- data.frame(
        Variable_Name = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_SND_dBA", "ucm_SUN_Gh", "atmo_pm1_avg",
            "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg", "ucm_MRT", "ucm_PET", "ucm_UTCI",
            "ucm_HUMIDEX", "Clearness_Index", "Clearness_Index_G0", "gvi_50m", "ucm_WIND_AWS", "ucm_fp", "SVF"),
        Measurement_Code = c(rep("M", 4), rep("A", 4), rep("D", 9), "M", "U", "D"),
        Measurement_Type = c(rep("Instrument", 4), rep("Average", 4), rep("Derived", 9), "Wind", "Unverified", "SVF"),
        Inputs_or_Definition = c("[UCM]", "[UCM]", "[dBA]", "[Gh]", "[PM1 avg]", "[PM25 avg]", "[PM10 avg]", "[Lux avg]",
            "[Medi derived]", "[Kelvin avg]", "[MRT]", "[PET]", "[UTCI]", "[HUMIDEX]", "[kt derived]", "[G0 calc]", "[GVI]",
            "[AWS]", "[fp unverified]", "[SVF Holmer]"),
        Evidence = c(rep("[CityFeel17]", 4), rep("[avg_sources]", 4), "[MediRGB]", "[LYS]", rep("[CityFeel17]", 4),
            rep("[ClearCI]", 2), "[GVI merge]", "[AWS]", "[fp]", "[SVF Qiu17]"),
        stringsAsFactors = FALSE)
    step3_mat <- t(mapply(classify_step3_domain, all_variables_pool, step2_mat[, 2], USE.NAMES = FALSE))
    cat("Step 3: Tracing measurement sources and within-person dependencies; no predictor elimination...\n")
    screening_candidates <- all_variables_pool[step2_mat[, 2] == "Retained"]
    write.csv(h4_prepared_for_vif$coverage, H4_OUT_PATHS$phase_coverage_csv, row.names = FALSE, na = "")
    design_audit <- h4_audit_step3(df_core, screening_candidates)
    h4_retained_candidates <- screening_candidates
    # Clearness_Index, Clearness_Index_G0 and lys_medi_avg stay in the provenance table but are excluded in Step 2 (derived: Gh/G0; calculated G0; RGB-estimated melanopic EDI).
    stopifnot(setequal(screening_candidates, setdiff(h4_measurement_sources$Variable_Name, c("ucm_fp", "Clearness_Index", "Clearness_Index_G0", "lys_medi_avg"))))
    step1_criterion <- "Role classification: only X_env candidates proceed; metadata, outcomes, QC, and covariates do not enter exposure selection"
    step3_criterion <- "Measurement provenance and dependencies; within-person correlations and full-design rank are descriptive. All Step-2 candidates remain; no final exposure equation selected"
    role_outcomes <- rbind(
      c("Derived Light Category (not an independent continuous exposure)", "DERIVED LIGHT CATEGORY", NA),
      c("Physiological Sensor Outcomes (Y_physio)", "PHYSIOLOGICAL OUTCOME (Y)", "Objective physiological outcome; Step 4 uses 10-second summaries with declared HRV logs. Step 5 handles its outcome transformations separately."),
      c("Movement Covariates (Z)", "MOVEMENT COVARIATE (Z)", NA),
      c("Study Metadata & Spatiotemporal Tracking", "STUDY METADATA", "Spatiotemporal tracking, GPS positioning, or phase grouping metadata."),
      c("Participant Demographics & Clothing Metadata", "DEMOGRAPHIC METADATA", "Baseline participant demographic characteristics or clothing insulation metadata."),
      c("Acoustic Processing QC & Provenance", "QC METRIC", "YAMNet/spectral processing provenance, completeness, timing, or frequency-coverage QC; not an exposure predictor."),
      c("SVF Processing QC & Provenance", "QC METRIC", "SVF calibration, segmentation, run-integrity, telemetry, or manual-validation QC; not an exposure predictor."))
    final_filtration_df <- do.call(rbind, lapply(seq_along(all_variables_pool), function(i) {
      col <- all_variables_pool[i]; role <- step1_mat[i, 2]
      step2_stat <- step2_mat[i, 2]; dom <- step3_mat[i, 1]; step3_stat <- step3_mat[i, 2]
      dash <- function(x) ifelse(grepl("^N/A", x), "-", x)
      k <- match(role, role_outcomes[, 1])
      final <- if (col %in% h4_retained_candidates) c("CANDIDATE AFTER MEASUREMENT AUDIT", paste0("Available candidate in ", dom, ". Measurement dependencies are documented; no automatic VIF or correlation elimination. Model membership remains undecided; outcome models have not been refitted."))
        else if (step3_stat %in% c("EXPLORATORY SOUNDSCAPE CONSTRUCT", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT")) c(step3_stat, step3_mat[i, 3])
        else if (!step2_stat %in% c("N/A", "Retained")) c(if (step2_stat == "CONSOLIDATED RAW CHANNEL (EXCLUDED)") "CONSOLIDATED RAW STREAM (EXCLUDED)" else step2_stat, step2_mat[i, 3])
        else if (!is.na(k)) c(role_outcomes[k, 2], if (is.na(role_outcomes[k, 3])) step1_mat[i, 4] else role_outcomes[k, 3])
        else c("QC METRIC", "Signal quality, missingness verification, or HRV window integrity metric.")
      data.frame(Variable_Name = col, audit_availability[i, c("Available_Phase_Cells", "Available_Participants", "Within_Person_SD")],
        Declared_Average_Replacement = paste(names(average_sources)[vapply(average_sources, function(src) col %in% src, logical(1))], collapse = "; "),
        Platform_Source = step1_mat[i, 1], Native_Unit = step1_mat[i, 3], Scientific_Domain = dash(dom), Step1_Role = role,
        Step1_Criterion = paste0(step1_criterion, "; observed role: ", role),
        Step1_Decision = if (step1_mat[i, 5] == "RETAINED FOR FILTRATION") "Retained" else "-",
        Step2_Rule = dash(step2_mat[i, 1]), Step2_Status = dash(step2_stat), Step2_Decision = if (step2_stat == "Retained") "Retained" else "-",
        Step3_Status = dash(step3_stat),
        Step3_Criterion = paste0(step3_criterion, "; observed domain: ", dash(dom), "; status: ", dash(step3_stat)),
        Step3_Decision = if (step3_stat == "DATA-ELIGIBLE SCREENING CANDIDATE") "Retained" else "-",
        H4_Screening_Candidate = ifelse(col %in% screening_candidates, "Yes", "No"),
        Final_Filtration_Outcome = final[1], Scientific_Filtration_Rationale = final[2], stringsAsFactors = FALSE, row.names = NULL)
    }))
    source_index <- match(final_filtration_df$Variable_Name, h4_measurement_sources$Variable_Name)
    for (field in setdiff(names(h4_measurement_sources), "Variable_Name")) {
        final_filtration_df[[field]] <- h4_measurement_sources[[field]][source_index]
        final_filtration_df[[field]][is.na(final_filtration_df[[field]])] <- "-"
    }
    outcome_order <- c("CANDIDATE AFTER MEASUREMENT AUDIT", "EXPLORATORY SOUNDSCAPE CONSTRUCT", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT",
        "CONSOLIDATED RAW STREAM (EXCLUDED)", "PHYSIOLOGICAL OUTCOME (Y)",
        "MOVEMENT COVARIATE (Z)", "STUDY METADATA", "DEMOGRAPHIC METADATA", "QC METRIC")
    final_filtration_df$OrderRank <- match(final_filtration_df$Final_Filtration_Outcome, outcome_order)
    final_filtration_df <- final_filtration_df[order(final_filtration_df$OrderRank, final_filtration_df$Variable_Name), ]
    final_filtration_df$OrderRank <- NULL
    final_filtration_df$Audit_Domain <- mapply(infer_audit_domain, final_filtration_df$Variable_Name, final_filtration_df$Step1_Role,
        final_filtration_df$Scientific_Domain, USE.NAMES = FALSE)
    integration_families <- list(`Sound category frame proportions` = SOUND_CATEGORY_PROP_COLUMNS, `Acoustic frequency descriptors` = EXPECTED_SOUND_FREQUENCY_COLUMNS,
        `SVF / urban morphology` = SVF_EXPOSURE_COLUMNS)
    integration_df <- do.call(rbind, lapply(names(integration_families), function(fam) {
      expected <- integration_families[[fam]]
      present <- intersect(expected, raw_cols_all)
      missing <- setdiff(expected, raw_cols_all)
      coverage <- audit_availability[match(present, audit_availability$Variable_Name), ]
      minimum_cells <- if (nrow(coverage)) min(coverage$Available_Phase_Cells) else 0L
      data.frame(Family = fam, Expected_N = length(expected), Present_N = length(present), Missing_N = length(missing),
        Status = if (length(present) == 0) "ABSENT" else if (minimum_cells < 2L) if (fam == "SVF / urban morphology") "PLANNED_CANDIDATES_PENDING_PROCESSING_MERGE" else "SCHEMA_PRESENT_BUT_INSUFFICIENT_COVERAGE" else if (length(missing) == 0) "SCHEMA_COMPLETE_CHECK_COVERAGE" else "PARTIAL_SCHEMA_CHECK_COVERAGE",
        Minimum_Available_Phase_Cells = minimum_cells, Expected_Phase_Cells = nrow(h4_prepared_for_vif$data),
        Missing_Columns = if (length(missing)) paste(missing, collapse = "; ") else "", stringsAsFactors = FALSE)
    }))
    write.csv(integration_df, INTEGRATION_CSV, row.names = FALSE, na = "")
    stage_summary_df <- data.frame(Stage = c("Step 1: Complete inventory", "Step 2: Eligible representations", "Step 3: Measurement audit"),
        Count = c(nrow(final_filtration_df), length(screening_candidates), length(h4_retained_candidates)), Criterion = c("Every input column plus declared averages",
            "Existing consolidation and representation rules unchanged", "Provenance, dependencies and within-person diagnostics; no elimination"),
        stringsAsFactors = FALSE)
    write.csv(stage_summary_df, STAGE_SUMMARY_CSV, row.names = FALSE, na = "")
    step1_counts <- count_stage_categories(final_filtration_df, "Step1_Role", final_filtration_df$Step1_Decision == "Retained",
        "Step 1 - Analytical role classification", "All audited variables. Only environmental exposure candidates advance to Step 2.")
    step2_df <- final_filtration_df[final_filtration_df$Step1_Decision == "Retained", , drop = FALSE]
    step2_counts <- count_stage_categories(step2_df, "Step2_Rule", step2_df$Step2_Decision == "Retained", "Step 2 - Sensor preprocessing / consolidation",
        "Only environmental candidates from Step 1.")
    step3_df <- final_filtration_df[final_filtration_df$Step2_Decision == "Retained", , drop = FALSE]
    step3_counts <- count_stage_categories(step3_df, "Audit_Domain", step3_df$Step3_Decision == "Retained", "Step 3 - Within-person design diagnostics",
        "Only Step-2 retained environmental streams.")
    step_category_counts_df <- rbind(step1_counts, step2_counts, step3_counts)
    write.csv(step_category_counts_df, STEP_CATEGORY_CSV, row.names = FALSE, na = "")
    final_outcome_counts_df <- aggregate(list(Count = rep(1L, nrow(final_filtration_df))), by = list(Final_Outcome = final_filtration_df$Final_Filtration_Outcome),
        FUN = sum)
    final_outcome_counts_df <- final_outcome_counts_df[order(-final_outcome_counts_df$Count, final_outcome_counts_df$Final_Outcome),
        , drop = FALSE]
    write.csv(final_outcome_counts_df, FINAL_OUTCOME_COUNTS_CSV, row.names = FALSE, na = "")
    stage_totals_report <- data.frame(Stage = c("Step 1", "Step 2", "Step 3"), Entering = c(nrow(final_filtration_df), nrow(step2_df),
        nrow(step3_df)), Retained = c(sum(final_filtration_df$Step1_Decision == "Retained"), sum(step2_df$Step2_Decision == "Retained"),
        nrow(step3_df)), Not_Advanced = c(sum(final_filtration_df$Step1_Decision != "Retained"), sum(step2_df$Step2_Decision !=
        "Retained"), 0L))
    report_lines <- c("# H4 measurement audit", "Steps 1-2 retain the complete inventory and declared exposure representations. Step 3 groups candidates without outcome-based deletion.",
        "Step 4 retains all 16 eligible candidates, specifies alternative heat/PM equations, and checks full-design VIF/rank; no automatic deletion.",
        "Participant is the independent cluster. Step 4 defines seven equations (primary UTCI + PM2.5; optional Eq 2 sound-structure sensitivity; heat-form sensitivities on PM2.5; PM1/PM10 only with UTCI) including heat x sound interactions per equation heat form. Step 5 fits six by default (Eq 2 when H4_SPEC$fit_sound_sensitivity is TRUE). Earlier model outputs are historical until a verified rerun succeeds.",
        "## Stage totals", fmt_md_table(stage_totals_report), "## Measurement definitions and dependencies", fmt_md_table(h4_measurement_sources),
        "Step 2 representatives and averages are study choices, not automatic literature rules. LYS1 and LYS2 represent different wearers.",
        "fp remains unverified; true wind speed (TWS) excluded (gaps, undocumented correction); SVF from CamUp merge in merged_all_11participants_8min.csv (Step 2 Retained when coverage passes).",
        "## Within-person design diagnostics", fmt_md_table(design_audit$omissions), fmt_md_table(design_audit$pairs), "Same-data selection and fitting do not provide confirmatory inference.",
        "Sources: https://doi.org/10.1016/j.egypro.2017.07.427")
    writeLines(report_lines, TRANSPARENCY_MD, useBytes = TRUE)
    cat("\nH4 screening-path counts and domain counts\n")
    print(stage_totals_report, row.names = FALSE)
    print(step3_counts, row.names = FALSE)
    # ---- Step 4: retain candidates and specify/check equations ----
    final_filtration_df <- h4_step4_candidates(df_core, final_filtration_df)
    tryCatch(write.csv(final_filtration_df, OUT_CSV, row.names = FALSE, na = ""), error = function(e) write.csv(final_filtration_df,
        sub(".csv$", "_latest.csv", OUT_CSV), row.names = FALSE, na = ""))
    cat(sprintf("SUCCESS: Exported H4 multivariate audit CSV with %d variables to:\n  %s\n", nrow(final_filtration_df), OUT_CSV))
    selected_step2 <- final_filtration_df$Variable_Name[final_filtration_df$Step2_Decision == "Retained"]
    stopifnot(!any(grepl("^ucm_IR_|^ucm_.*_(SR|S)$|^ucm_AH$|^ucm_AIR_T_(bot|mid|top)$|IO_flag", selected_step2)),
              identical(grep("^ucm_WIND_", selected_step2, value = TRUE), "ucm_WIND_AWS"),
              identical(grep("^gvi_|^(plant|grass|tree)_phase_mean$", selected_step2, value = TRUE), "gvi_50m"),
              !any(is_acoustic_frequency(selected_step2)),
              all(c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_UTCI", "ucm_SND_dBA") %in% selected_step2))

    writeLines(c("Step 3: measurement categories.", "Step 4: retain 16 candidates; specify 7 equations (primary UTCI + PM2.5; Eq 2 sound sensitivity); check full-design rank and VIF on heat x sound terms.",
        "Step 5: mixed-model fitting (6 equations by default; Eq 2 when H4_SPEC$fit_sound_sensitivity is TRUE); new equations require a new verified fit."), FORMULA_TXT)

    list(audit_df = final_filtration_df, raw_df = df)
}

h4_step4_exposure_prep <- function(audit_df, raw_df) {
  for (v in setdiff(c("lys_lux_avg", "lys_kelvin_avg", "lys_medi_avg"), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  raw_df <- raw_df[raw_df$ParticipantID %in% H4_SPEC$participants & raw_df$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
  if (!"empatica_hrv_fd_5min_available" %in% names(raw_df)) stop("Missing HRV availability flag")
  available <- tolower(as.character(raw_df$empatica_hrv_fd_5min_available)) %in% c("true", "1")
  for (v in hrv_fd_outcomes()) raw_df[[v]][!available] <- NA_real_
  # Explicit one-step endpoint approximation: never fill internal gaps or cross a bout boundary.
  bout_order <- order(raw_df$ParticipantID, raw_df$PhaseID, as.POSIXct(raw_df$Datetime, tz = "UTC"))
  bout_sorted <- paste(raw_df$ParticipantID, raw_df$PhaseID)[bout_order]
  raw_df$SVF_endpoint_carried <- FALSE
  for (ix in split(bout_order, bout_sorted)) {
    if (length(ix) < 2L) next
    last <- tail(ix, 1L); previous <- tail(ix, 2L)[1L]
    gap <- as.numeric(difftime(as.POSIXct(raw_df$Datetime[last], tz = "UTC"), as.POSIXct(raw_df$Datetime[previous], tz = "UTC"), units = "secs"))
    if (!is.finite(raw_df$SVF[last]) && is.finite(raw_df$SVF[previous]) && is.finite(gap) && gap == 10) {
      raw_df$SVF[last] <- raw_df$SVF[previous]
      raw_df$SVF_endpoint_carried[last] <- TRUE
    }
  }
  audit_df <- h4_step4_candidates(raw_df, audit_df)
  reps <- audit_df$Variable_Name[audit_df$Step4_Category_Role %in% "covariate candidate"]
  nonthermal <- unique(reps)
  rep_tab <- audit_df[!is.na(audit_df$Step4_Domain), c("Step4_Domain", "Variable_Name", "Step4_Category_Role", "Step4_Decision", "Step4_Restriction")]
  base_heat <- list(`AIR_temp + AIR_RH + WIND_AWS` = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS"), HUMIDEX = "ucm_HUMIDEX", PET = "ucm_PET", UTCI = "ucm_UTCI")
  pm <- intersect(H4_DOMAINS$Pollution, reps)
  if (length(pm) != 3L || !all(c("ucm_MRT", "ucm_SND_dBA") %in% reps)) stop("Step 4 requires three PM alternatives, MRT and sound")
  # equation_spec is the seven-row table in the specification block (same ids, heat keys, PM, roles).
  # UTCI + PM2.5 is the pre-specified primary; Eq 2 adds PCA sound mains on the same heat/PM form.
  # Heat-form sensitivities stay on PM2.5. PM1 and PM10 are size sensitivities on UTCI only.
  stopifnot(nrow(equation_spec) == 7L, identical(equation_spec$equation_id, 1:7),
            all(equation_spec$heat_key %in% names(base_heat)), all(equation_spec$pm %in% pm),
            sum(equation_spec$role == "primary") == 1L, sum(equation_spec$role == "sound_sensitivity") == 1L)
  thermal <- list()
  for (i in seq_len(nrow(equation_spec))) {
    vars <- base_heat[[equation_spec$heat_key[i]]]
    attr(vars, "pm") <- equation_spec$pm[i]
    thermal[[h4_equation_thermal_label(equation_spec[i, , drop = FALSE])]] <- vars
  }
  eq2_sound <- get0("H4_EQ2_SOUND_MAIN_TERMS", envir = .GlobalEnv, ifnotfound = character(0))
  if (length(eq2_sound)) {
    missing_sound <- setdiff(eq2_sound, names(raw_df))
    if (length(missing_sound)) stop("Eq 2 sound terms missing from raw data: ", paste(missing_sound, collapse = ", "))
  }
  selected <- unique(c(nonthermal, unlist(thermal, use.names = FALSE), eq2_sound))
  # Within-bout centering (Enders & Tofighi 2007; Curran & Bauer 2011): each exposure minus its bout (participant x
  # phase) mean, divided by the SD of that deviation. PhaseID sum-to-zero effects carry the condition means.
  bout_id <- paste(raw_df$ParticipantID, raw_df$PhaseID, sep = "::")
  centered <- raw_x <- as.matrix(raw_df[, selected, drop = FALSE])
  storage.mode(centered) <- storage.mode(raw_x) <- "double"
  for (j in seq_len(ncol(raw_x))) {
    finite <- is.finite(raw_x[, j])
    centered[, j] <- raw_x[, j] - unname(tapply(raw_x[finite, j], bout_id[finite], mean)[bout_id])
    sdx <- sd(centered[finite, j])
    if (is.finite(sdx) && sdx > 0) centered[, j] <- centered[, j] / sdx
  }
  # Match the exact 60-second predecessor within the bout; row offsets are wrong when timestamps have gaps.
  stamp <- as.numeric(as.POSIXct(raw_df$Datetime, tz = "UTC"))
  time_keys <- paste(bout_id, stamp, sep = "::")
  if (any(!is.finite(stamp)) || anyDuplicated(time_keys)) stop("Invalid/duplicate timestamps in exposure preparation")
  lag_index <- match(paste(bout_id, stamp - 60, sep = "::"), time_keys)
  centered_lag60 <- centered
  centered_lag60[] <- NA_real_
  has_lag <- !is.na(lag_index)
  centered_lag60[has_lag, ] <- centered[lag_index[has_lag], , drop = FALSE]
  make_design <- function(z, vars, phase, test = "Noise", terms_order = NULL) {
    if (nrow(z) != length(phase)) stop("PhaseID/design row mismatch")
    env_covars <- setdiff(nonthermal, setdiff(H4_DOMAINS$Pollution, attr(vars, "pm")))
    if (!is.null(terms_order)) {
      ix_in_order <- terms_order[grepl(":", terms_order, fixed = TRUE)]
      mains_needed <- setdiff(terms_order, c(intersect(H4_PHASE_SUM_COLS, terms_order), ix_in_order))
      env_covars <- setdiff(mains_needed, vars)
    }
    design_mains <- h4_design_main_column_order(vars, env_covars)
    x <- cbind(z[, design_mains, drop = FALSE], h4_phase_design(phase))
    stopifnot(sum(H4_DOMAINS$Pollution %in% colnames(x)) == 1L, !anyDuplicated(colnames(x)))
    if (test != "Noise") {
      if (!is.null(terms_order)) {
        stopifnot(setequal(colnames(x), terms_order))
        return(x[, terms_order, drop = FALSE])
      }
      return(x)
    }
    ix_terms <- if (!is.null(terms_order)) h4_sound_interaction_terms(terms_order) else {
      paste0(vars, ":ucm_SND_dBA")
    }
    if (length(ix_terms)) {
      sound <- vapply(ix_terms, function(term) {
        parts <- strsplit(term, ":", fixed = TRUE)[[1]]
        z[, parts[1L]] * z[, parts[2L]]
      }, numeric(nrow(z)))
      sound <- matrix(sound, nrow = nrow(z), ncol = length(ix_terms), dimnames = list(NULL, ix_terms))
      x <- cbind(x, sound)
    }
    if (!is.null(terms_order)) {
      stopifnot(setequal(colnames(x), terms_order))
      x <- x[, terms_order, drop = FALSE]
    }
    x
  }
  catalog <- h4_equation_catalog(nonthermal, thermal, equation_spec)
  if (exists("H4_EQUATION_FIXED", envir = .GlobalEnv, inherits = FALSE)) {
    fixed <- get("H4_EQUATION_FIXED", envir = .GlobalEnv)
    for (i in seq_len(nrow(equation_spec))) {
      heat_label <- names(thermal)[i]
      vars <- thermal[[heat_label]]
      meeting_cols <- fixed[[as.character(equation_spec$equation_id[i])]]
      fitted_cols <- colnames(make_design(centered[1L, , drop = FALSE], vars, "WalkG", terms_order = meeting_cols))
      stopifnot(identical(fitted_cols, meeting_cols))
    }
  }
  list(raw_df = raw_df, nonthermal = nonthermal, thermal = thermal, selected = selected,
       centered = centered, centered_lag60 = centered_lag60, make_design = make_design, catalog = catalog,
       agreed_common = character(0), rep_tab = rep_tab)
}

h4_step4_candidates <- function(raw, audit) {
  eligible <- audit$Variable_Name[audit$Step3_Decision == "Retained"]
  audit <- audit[, !startsWith(names(audit), "Step4_PC1") & !names(audit) %in%
    c("Step4_Representative", "Step4_Representative_Rule", "Step4_Bootstrap_SelectionFreq"), drop = FALSE]
  audit$Step4_Domain <- NA_character_
  audit$Step4_Category_Role <- NA_character_
  audit$Step4_Decision <- "not eligible"
  audit$Step4_Restriction <- ""
  for (dom in names(H4_DOMAINS)) {
    vars <- intersect(H4_DOMAINS[[dom]], eligible)
    if (!all(vars %in% names(raw))) stop("Missing eligible Step 4 measurements: ", paste(setdiff(vars, names(raw)), collapse = ", "))
    i <- match(vars, audit$Variable_Name)
    audit$Step4_Domain[i] <- dom
    audit$Step4_Category_Role[i] <- if (dom %in% H4_STEP4_THERMAL_CATEGORIES) "thermal equation candidate" else "covariate candidate"
    audit$Step4_Decision[i] <- "retained candidate; no automatic deletion"
    audit$Step4_Restriction[i] <- if (dom == "Index") "One heat representation per equation" else
      if (dom == "Pollution") "One PM representation per candidate equation; all three jointly collinear" else "Full-equation VIF/rank review required"
  }
  stopifnot(setequal(eligible, audit$Variable_Name[!is.na(audit$Step4_Domain)]))
  audit
}


# Equation designs and collinearity checks
h4_vif_per_term <- function(X) {
  # Fox & Monette (1992) car::vif on the design only (not an outcome fit). Each three-column PhaseID span is one term;
  # the score GVIF^(1/df) is the square of car's GVIF^(1/(2*df)).
  X <- as.matrix(X)
  if (!ncol(X)) return(setNames(numeric(), character()))
  nms <- colnames(X)
  groups <- nms
  groups[startsWith(nms, "PhaseSum")] <- "PhaseID"
  ix <- grepl(":PhaseSum", nms, fixed = TRUE)
  groups[ix] <- paste0(sub(":PhaseSum.*$", "", nms[ix]), ":PhaseID")
  terms <- unique(groups)
  dfs <- vapply(terms, function(g) sum(groups == g), integer(1))
  if (any(dfs[grepl("PhaseID$", terms)] != 3L)) stop("Incomplete PhaseID contrast block")
  gvif <- rep(Inf, length(terms))
  if (all(is.finite(X)) && nrow(X) > ncol(X) + 1L && qr(cbind(1, X))$rank == ncol(X) + 1L) {
    if (length(terms) == 1L) gvif[] <- 1 else {
      # The residual scale cancels in car's coefficient correlation; a deterministic dummy response supplies the lm interface.
      d <- data.frame(.h4_response = sin(seq_len(nrow(X))) + cos(seq_len(nrow(X)) * sqrt(2)))
      for (i in seq_along(terms)) {
        block <- X[, groups == terms[i], drop = FALSE]
        d[[paste0("T", i)]] <- if (ncol(block) == 1L) block[, 1L] else I(block)
      }
      result <- car::vif(stats::lm(.h4_response ~ ., data = d))
      keys <- paste0("T", seq_along(terms))
      gvif <- if (is.matrix(result)) result[keys, "GVIF"] else result[keys]
    }
  }
  score <- setNames(as.numeric(gvif)^(1 / dfs), terms)
  attr(score, "gvif_table") <- data.frame(term = terms, GVIF = as.numeric(gvif), Df = dfs,
    GVIF_root = as.numeric(gvif)^(1 / (2 * dfs)), VIF_equivalent = as.numeric(score))
  score
}

h4_equation_term_order <- function(eq_id) {
  if (!exists("H4_EQUATION_FIXED", envir = .GlobalEnv, inherits = FALSE)) {
    stop("H4_EQUATION_FIXED not defined; source scripts/H4_multivariate.R first.", call. = FALSE)
  }
  get("H4_EQUATION_FIXED", envir = .GlobalEnv)[[as.character(eq_id)]]
}

h4_equation_thermal_label <- function(row) {
  label <- paste(row$heat_key, row$pm, sep = " / ")
  if (identical(row$role, "sound_sensitivity")) paste0(label, " (sound sensitivity)") else label
}

h4_sound_interaction_terms <- function(terms_order) {
  terms_order[grepl(":", terms_order, fixed = TRUE) & grepl("ucm_SND_dBA", terms_order, fixed = TRUE)]
}

# Step 3 / Step 4 left-to-right domain order (Thermal -> Greenery); phases then sound interactions.
h4_design_main_column_order <- function(heat_vars, env_covars) {
  heat_vars <- unique(as.character(heat_vars))
  env_covars <- unique(as.character(env_covars))
  snd <- intersect("ucm_SND_dBA", env_covars)
  rest <- setdiff(env_covars, c(heat_vars, snd))
  rest <- rest[order(match(rest, unlist(H4_DOMAINS[H4_FLOW_DOMAIN_ORDER], use.names = FALSE)), na.last = TRUE)]
  if (length(heat_vars) && length(snd)) c(heat_vars[1L], snd, heat_vars[-1L], rest) else c(heat_vars, snd, rest)
}

h4_equation_catalog <- function(nonthermal, thermal, equation_spec) {
  expected_thermal <- vapply(seq_len(nrow(equation_spec)), function(i)
    h4_equation_thermal_label(equation_spec[i, , drop = FALSE]), character(1))
  stopifnot(nrow(equation_spec) == 7L, length(thermal) == 7L, identical(names(thermal), expected_thermal))
  out <- do.call(rbind, lapply(seq_len(nrow(equation_spec)), function(id) {
    vars <- thermal[[id]]
    data.frame(equation_id = equation_spec$equation_id[id], heat_form = names(thermal)[id],
      pm_representation = attr(vars, "pm"), role = equation_spec$role[id],
      primary = equation_spec$role[id] == "primary", block = "heat_x_sound", test = "Noise",
      terms = paste(vapply(h4_equation_term_order(equation_spec$equation_id[id]), h4_spell_term, character(1)), collapse = " + "),
      heat_role = if (length(vars) > 1L) "Air temperature + RH + apparent wind" else paste(equation_spec$heat_key[id], "only"),
      fitted = FALSE, stringsAsFactors = FALSE)
  }))
  stopifnot(nrow(out) == 7L, identical(out$equation_id, 1:7), sum(out$primary) == 1L, out$primary[1],
            out$role[1] == "primary", out$role[2] == "sound_sensitivity", !anyDuplicated(out$terms),
            out$pm_representation[1:5] == "atmo_pm2.5_avg",
            out$pm_representation[6:7] == c("atmo_pm1_avg", "atmo_pm10_avg"))
  out$analysis_role <- ifelse(out$primary, "pre-specified primary (UTCI + PM2.5)",
    ifelse(out$role == "sound_sensitivity", "sound-structure sensitivity (Eq1 + PCA sound mains)",
      ifelse(out$role == "heat_sensitivity", "heat-form sensitivity (PM2.5)", "PM size sensitivity (UTCI heat form)")))
  out
}



h4_complete_rows <- function(raw_df, outcome, equation_id,
    outcome_kind = H4_SPEC$outcome_transform_kind) {
  terms <- setdiff(h4_equation_term_order(equation_id), H4_PHASE_SUM_COLS)
  needed <- unique(c(unlist(strsplit(terms, ":", fixed = TRUE)), outcome))
  values <- as.matrix(raw_df[, needed, drop = FALSE])
  storage.mode(values) <- "double"
  ok <- rowSums(!is.finite(values)) == 0L
  kind <- outcome_kind[[outcome]]
  if (identical(kind, "log")) ok <- ok & raw_df[[outcome]] > 0
  else if (identical(kind, "sqrt")) ok <- ok & raw_df[[outcome]] >= 0
  ok
}

h4_run_gvif_diagnostic <- function(prep, design_outcome = "empatica_heart_rate", vif_threshold = H4_SPEC$vif_threshold, write = TRUE) {
  # Explicit local bindings from the Step 4 preparation (no list2env into this frame).
  raw_df <- prep$raw_df
  centered <- prep$centered
  selected <- prep$selected
  catalog <- prep$catalog
  make_design <- prep$make_design
  thermal <- prep$thermal
  if (!design_outcome %in% names(raw_df)) stop("GVIF design outcome not in data: ", design_outcome)
  term_rows <- eq_rows <- list()
  for (i in seq_len(nrow(catalog))) {
    eq <- catalog[i, ]
    ok <- h4_complete_rows(raw_df, design_outcome, eq$equation_id)
    z <- centered[ok, , drop = FALSE]
    phase_vec <- raw_df$PhaseID[ok]
    n_rows <- nrow(z)
    design <- make_design(z, thermal[[eq$heat_form]], phase_vec, test = eq$test,
      terms_order = h4_equation_term_order(eq$equation_id))
    vv <- h4_vif_per_term(design)
    gt <- attr(vv, "gvif_table")
    phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
    mx <- max(vv, na.rm = TRUE)
    id_cols <- data.frame(equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block, test = eq$test,
      design_outcome = design_outcome, n_design_rows = n_rows, stringsAsFactors = FALSE)
    term_rows[[i]] <- data.frame(id_cols, grouped_term = gt$term, GVIF = gt$GVIF, Df = gt$Df, GVIF_root = gt$GVIF_root,
      VIF_equivalent = gt$VIF_equivalent, flag_vif_gt_threshold = gt$Df == 1L & (gt$VIF_equivalent >= vif_threshold | !is.finite(gt$VIF_equivalent)),
      stringsAsFactors = FALSE, row.names = NULL)
    eq_rows[[i]] <- data.frame(id_cols, max_vif_equivalent = mx, worst_grouped_term = names(vv)[which.max(vv)],
      phase_GVIF = phase_gt$GVIF, phase_Df = phase_gt$Df, phase_GVIF_root = phase_gt$GVIF_root,
      phase_vif_equivalent = phase_gt$VIF_equivalent, rank = qr(cbind(1, design))$rank, expected_rank = ncol(design) + 1L,
      full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L, stringsAsFactors = FALSE, row.names = NULL)
  }
  term_df <- do.call(rbind, term_rows)
  by_equation <- do.call(rbind, eq_rows)
  csv_path <- file.path(OUT_DIR, "H4_models", "H4_gvif_diagnostic.csv")
  if (write) {
    dir.create(file.path(OUT_DIR, "H4_models"), recursive = TRUE, showWarnings = FALSE)
    utils::write.csv(term_df, csv_path, row.names = FALSE, na = "")
  }
  list(terms = term_df, by_equation = by_equation, paths = c(csv = csv_path))
}

# A rank-deficient design blocks fitting; predictors are not removed automatically.
h4_design_preflight <- function(raw_df, centered, selected, catalog, thermal, make_design, fit_equation_ids, outcomes,
    outcome_kind = H4_SPEC$outcome_transform_kind) {
  preflight <- list()
  for (check_y in outcomes) {
    for (check_eid in fit_equation_ids) {
      valid <- h4_complete_rows(raw_df, check_y, check_eid, outcome_kind)
      check_z <- centered[valid, , drop = FALSE]
      check_phase <- raw_df$PhaseID[valid]
      check_eq <- catalog[catalog$equation_id == check_eid, ]
      check_x <- make_design(check_z, thermal[[check_eq$heat_form]], check_phase, test = check_eq$test,
        terms_order = h4_equation_term_order(check_eid))
      vv <- h4_vif_per_term(check_x)
      gt <- attr(vv, "gvif_table")
      phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
      if (!nrow(phase_gt)) phase_gt <- data.frame(GVIF = NA_real_, Df = 3L, GVIF_root = NA_real_, VIF_equivalent = NA_real_)
      exposure_terms <- intersect(colnames(check_x), selected)
      cells <- interaction(raw_df$ParticipantID[valid], check_phase, drop = TRUE)
      within_share <- vapply(exposure_terms, function(v) {
        x <- check_x[, v]
        total <- sum((x - mean(x))^2)
        if (total <= 0) return(NA_real_)
        sum((x - ave(x, cells, FUN = mean))^2) / total
      }, numeric(1))
      rr <- qr(cbind(Intercept = 1, check_x))$rank
      sigmas <- apply(check_x, 2L, stats::sd)
      singular <- svd(sweep(sweep(check_x, 2L, colMeans(check_x), "-"), 2L, ifelse(is.finite(sigmas) & sigmas > 0, sigmas, 1), "/"), nu = 0L, nv = 0L)$d
      mx <- max(vv)
      preflight[[length(preflight) + 1L]] <- data.frame(equation_id = check_eid, heat_form = check_eq$heat_form, block = check_eq$block,
        outcome = check_y, n = nrow(check_x), rank = rr, expected_rank = ncol(check_x) + 1L, full_rank = rr == ncol(check_x) + 1L,
        max_vif = mx, worst_term = names(vv)[which.max(vv)], diagnostic = "Design-only GVIF^(1/Df); ordinary VIF for Df=1",
        phase_df = phase_gt$Df, phase_gvif = phase_gt$GVIF, phase_gvif_root = phase_gt$GVIF_root, phase_vif_equivalent = phase_gt$VIF_equivalent,
        term_vif_equivalents = paste(names(vv), signif(vv, 6), sep = "=", collapse = ";"),
        within_participant_phase_variation_share = paste(names(within_share), signif(within_share, 6), sep = "=", collapse = ";"),
        high_vif_terms = paste(names(vv)[!is.finite(vv) | vv >= H4_SPEC$vif_threshold], collapse = ";"),
        condition_index = if (!length(singular) || min(singular) <= 1e-10) Inf else max(singular) / min(singular),
        passes_check = rr == ncol(check_x) + 1L, vif_flag = is.finite(mx) && mx >= H4_SPEC$vif_threshold, stringsAsFactors = FALSE)
    }
  }
  do.call(rbind, preflight)
}


# Shared measurement summaries
h4_mean <- function(x) {
  if (!is.numeric(x) && !is.logical(x) && !is.factor(x)) return(NA_real_)
  x <- as.numeric(x)
  if (any(is.finite(x))) mean(x[is.finite(x)]) else NA_real_
}

h4_person_mean_center <- function(x, id) ave(as.numeric(x), id, FUN = function(v) if (any(is.finite(v))) v - mean(v[is.finite(v)]) else rep(NA_real_, length(v)))

fmt_md_table <- function(df) {
  if(!nrow(df)) return("(none)")
  row <- function(x) paste0("| ", paste(gsub("\\|", "/", as.character(x)), collapse = " | "), " |")
  paste(c(row(names(df)), row(rep("---", ncol(df))), apply(df, 1, row)), collapse = "\n")
}


# Checksums detect source files changing while models run.
h4_file_checksums <- function(paths) as.character(tools::md5sum(paths))

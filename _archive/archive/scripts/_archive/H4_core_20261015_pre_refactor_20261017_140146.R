# H4_core.R — audit (Steps 1-4), reports, dispatch; sourced by H4_multivariate.R.
# H4_SPEC, equation prep, and LMM fit live in H4_multivariate.R.

# --- 1. Configuration (domains, column lists) ---
H4_DOMAINS <- list(
  Acoustic = "ucm_SND_dBA",
  Thermal = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS"),
  Index = c("ucm_HUMIDEX", "ucm_PET", "ucm_UTCI", "ucm_OPT"),
  Radiation = c("ucm_MRT", "ucm_SUN_Gh", "SVF_Holmer"),
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
SVF_EXPOSURE_COLUMNS <- c(
  "Sky_%", "SVF_Holmer", "Tree_%", "Plant_%", "Grass_%", "Combined_Vegetation_%", "Building_%", "Wall_%", "Ceiling_%")
SVF_QC_COLUMNS <- c(
  "Filename", "Timestamp", "Camera", "Calibration", "Calibration_Table", "Run_Config_Signature", "Calibration_QC",
  "Calibration_Ref_Radius_px", "Raw_Lens_Radius_px", "Rectified_Lens_Radius_px", "Square_Hemisphere_Crop", "SVF_Method",
  "SVF_Rings", "Pitch_Roll_Correction", "Model", "Image_Path", "Segmented_Image_Path", "telemetry_matched", "Manual_Mask_Path",
  "Manual_Sky_IoU", "Manual_Sky_Dice", "Manual_Pixel_Accuracy", "Manual_SVF_Holmer", "SVF_Abs_Error_vs_Manual",
  "SVF_Frames_In_Window", "SVF_Aggregation_Method", "SVF_Selection_Method", "SVF_Status")
EXPECTED_SOUND_FREQUENCY_COLUMNS <- c(
  "dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz", "freq_prop_20_125", "freq_prop_125_1000",
  "freq_prop_1000_4000", "freq_prop_4000_8000", "freq_prop_8000_20000", "octave_prop_31_5_hz", "octave_prop_63_0_hz",
  "octave_prop_125_0_hz", "octave_prop_250_0_hz", "octave_prop_500_0_hz", "octave_prop_1000_0_hz", "octave_prop_2000_0_hz",
  "octave_prop_4000_0_hz", "octave_prop_8000_0_hz")
H4_PHASE_SUM_COLS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")

# --- 2. Shared helpers ---

# Phase means and within-person centering.
# Within-bout centering and scaling of exposures are in h4_step4_exposure_prep.
# Benjamini-Hochberg FDR is applied inside h4_1_publish_fits.
# Data checks
# Phase means, sensor completeness, and measurement-audit classifiers.
h4_mean <- function(x) {
  if (!is.numeric(x) && !is.logical(x) && !is.factor(x)) return(NA_real_)
  x <- as.numeric(x)
  if (any(is.finite(x))) mean(x[is.finite(x)]) else NA_real_
}

h4_person_mean_center <- function(x, id) ave(as.numeric(x), id, FUN = function(v) if (any(is.finite(v))) v - mean(v[is.finite(v)]) else rep(NA_real_, length(v)))

# fmt_md_table
fmt_md_table <- function(df) {
  if(!nrow(df)) return("(none)")
  row <- function(x) paste0("| ", paste(gsub("\\|", "/", as.character(x)), collapse = " | "), " |")
  paste(c(row(names(df)), row(rep("---", ncol(df))), apply(df, 1, row)), collapse = "\n")
}

h4_spell_term <- function(term) {
  pretty <- c(ucm_SND_dBA = "sound", SND_dBA = "sound", gvi_50m = "GVI", Clearness_Index = "clearness (excluded in Step 2 as derived)",
    lys_lux_avg = "lux", lys_kelvin_avg = "colour temperature", ucm_SUN_Gh = "global solar radiation", ucm_WIND_AWS = "apparent wind",
    ucm_AIR_temp = "air temperature", ucm_AIR_RH = "humidity",
    ucm_MRT = "mean radiant temperature", ucm_HUMIDEX = "HUMIDEX", ucm_PET = "PET", ucm_UTCI = "UTCI",
    atmo_pm1_avg = "PM1", atmo_pm2.5_avg = "PM2.5", atmo_pm10_avg = "PM10", SVF_Holmer = "SVF",
    setNames(paste("Phase:", c("WalkG", "WalkU", "BikeG", "BikeU"), "vs mean of phases"), paste0("PhaseSum", c("WalkG", "WalkU", "BikeG", "BikeU"))))
  parts <- strsplit(term, ":", fixed = TRUE)[[1]]
  parts <- ifelse(parts %in% names(pretty), pretty[parts], parts)
  if (length(parts) > 1L) paste0("(", parts[1], " x ", parts[2], ")") else parts
}

# Validator (h4_prepare_data) and Steps 1-3 audit classifiers.
h4_prepare_data <- function(raw) {
    required <- unique(c("ParticipantID", "PhaseID", "Datetime", "empatica_hrv_fd_5min_available", unlist(H4_SPEC$bilateral_sources),
        names(H4_SPEC$exposure_centered)[c(1, 2, 5)], H4_SPEC$all_outcomes))
    missing <- setdiff(required, names(raw))
    if (length(missing)) stop("Required H4 input columns missing: ", paste(missing, collapse = ", "))
    raw <- raw[raw$ParticipantID %in% H4_SPEC$participants & raw$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
    for (v in H4_SPEC$all_outcomes) {
        raw[[v]] <- as.numeric(raw[[v]])
        raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    }
    for (v in H4_SPEC$hrv_log) raw[[v]][!is.na(raw[[v]]) & raw[[v]] <= 0] <- NA_real_
    for (v in names(H4_SPEC$bilateral_sources)) raw[[v]] <- rowMeans(raw[, H4_SPEC$bilateral_sources[[v]], drop = FALSE],
        na.rm = TRUE)
    for (v in c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg")) raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    raw$ucm_SND_dBA[!is.na(raw$ucm_SND_dBA) & raw$ucm_SND_dBA < 0] <- NA_real_
    available <- tolower(as.character(raw$empatica_hrv_fd_5min_available)) %in% c("true", "1")
    for (v in H4_SPEC$hrv_fd) raw[[v]][!available] <- NA_real_
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

# --- 3. Steps 1-3 audit ---

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
    if(is_sound_semantic(c)||grepl("^freq_prop_|^octave_prop_",c)) "proportion / score" else if(c=="SVF_Holmer") "0-1" else if(grepl("_%$",c)) "%" else "Physical unit"
  info("Environmental Stressor Candidates (X_env)",source,unit,"Retained for Step 2 technical sensor consolidation","RETAINED FOR FILTRATION")
}

# h4_step2_representation
h4_step2_representation <- function(col) {
  # Derived: kt = Gh/G0 is a deterministic ratio of ucm_SUN_Gh [ClearCI p.3 eq.2]; co-entry is redundant [Zhu24 p.3].
  if (col == "Clearness_Index") return("Derived from ucm_SUN_Gh (Gh/G0); retained source measurement ucm_SUN_Gh")
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
  if (grepl("^ucm_.*_(SR|S)$", col)) return("Declared formulation choice: use the corresponding unsuffixed UCM measure")
  # Derived relation: IR radiometer channels are the inputs used to compute ucm_MRT [CityFeel17]; co-entry duplicates MRT.
  if (grepl("^ucm_IR_", col)) return("MRT input: UCM IR radiometer channels are the inputs used to compute ucm_MRT, so they are excluded as MRT inputs (derived relation) [CityFeel17]")
  # Wind representative = apparent wind speed AWS (airflow at the body incl. own movement; convective-cooling exposure; complete in core phases).
  if (col == "ucm_WIND_TWS") return("True wind speed has systematic gaps (P16 BikeU, P17 WalkG 0%; 10 more partial cells incl. P16 BikeG 2%) and cannot be reconstructed from AWS/AWA/GPS (undocumented device correction); wind representative: ucm_WIND_AWS")
  if (col %in% c("ucm_WIND_AWA", "ucm_WIND_TWD")) return("Wind direction/angle (circular), derived; wind representative: ucm_WIND_AWS")
  # AH is a deterministic function of T and RH -> redundant with ucm_AIR_temp + ucm_AIR_RH [Zhu24 p.3].
  if (col == "ucm_AH") return("Humidity representative: ucm_AIR_RH; AH is an alternative formulation")
  # Height tiers of the same air-temperature measurement; highly collinear [Zhu24 p.3].
  if (col %in% c("ucm_AIR_T_bot", "ucm_AIR_T_mid", "ucm_AIR_T_top")) return("Air-temperature representative: ucm_AIR_temp; tier channels not co-entered")
  # gvi_50m is the original GVI scale value; other buffers, components (grass/plant/tree) and phase means are derived alternatives.
  if (grepl("^gvi_|^(plant|grass|tree)_phase_mean$", col) && col != "gvi_50m") return("Vegetation representative: gvi_50m; alternative scales/components not co-entered")
  # Scene % (sky/building/tree...) are segmentation components behind SVF [Qiu17 p.1]; SVF_Holmer is the standard index.
  if (is_svf_exposure(col) && col != "SVF_Holmer") return("Sky openness represented by SVF_Holmer; scene percentages are separate secondary constructs, not equivalent exposures")
  # Derived/redundant: ucm_OPT is operative temperature, a function of air temperature and MRT [CityFeel17].
  if (col == "ucm_OPT") return("Derived/redundant: ucm_OPT is operative temperature, derived from air temperature and MRT [CityFeel17]")
  ""
}

# classify_step2_consolidation
classify_step2_consolidation <- function(col, role) {
  # fp: definition undocumented; excluded until documented (not a scientific rejection).
  if (col == "ucm_fp") return(c("Measurement definition and units", "UNVERIFIED DEFINITION (EXCLUDED)",
    "The definition, units and intended interpretation of fp have not been verified against source documentation; retain in the inventory but exclude from Step 2 analytical eligibility."))
  if (role != "Environmental Stressor Candidates (X_env)") return(c("N/A - Non-Environmental Stream", "N/A",
    "Non-environmental variable (metadata, demographic, covariate, or outcome)."))
  replacement <- names(average_sources)[vapply(average_sources, function(src) col %in% src, logical(1))]
  observed <- audit_availability[match(col, audit_availability$Variable_Name), ]
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
  if (!is.numeric(df_core[[col]])) return(c("Measurement type", "NON-NUMERIC LABEL (EXCLUDED)",
    "Not a continuous numeric exposure; no valid continuous-effect parameterization is declared. The original field remains in the input."))
  # Within-person effects need >= 2 phases per participant with variation.
  if (observed$Available_Phase_Cells < 2L || observed$Available_Participants < 2L || !is.finite(observed$Within_Person_SD) || observed$Within_Person_SD < 1e-12) {
    rat <- sprintf("Only %d of %d participant-phase cells across %d participants have finite phase means; a within-person effect cannot be estimated from one phase per participant or no centered variation. No imputation; rerun eligibility after broader valid coverage.", observed$Available_Phase_Cells, nrow(h4_prepared_for_vif$data), observed$Available_Participants)
    return(if (is_svf_exposure(col)) c("Within-person estimability / availability", "PENDING SVF PROCESSING / MERGE", paste0("SVF pending merge; not rejected. ", rat))
      else c("Within-person estimability / availability", "INSUFFICIENT WITHIN-PERSON COVERAGE (EXCLUDED)", rat))
  }
  c(if (col %in% c("ucm_WIND_AWA", "ucm_WIND_TWD", "ucm_SUN_az")) "Circular measurement: joint sine/cosine terms required" else "Available numeric measurement",
    "Retained", sprintf("Available in %d phase cells across %d participants after declared representation rules. Eligibility is not proof of measurement validity or automatic model inclusion.", observed$Available_Phase_Cells, observed$Available_Participants))
}

# h4_audit_step3
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

# classify_step3_domain
classify_step3_domain <- function(col, step2_stat) {
  if (step2_stat == "SECONDARY FREQUENCY BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT", "Preserved for separate frequency analyses; not substituted for the core dBA sound-level representative."))
  if (step2_stat == "SECONDARY SOUND-TYPE BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY SOUNDSCAPE CONSTRUCT", "Preserved for separate sound-type analyses; not substituted for the core dBA sound-level representative."))
  if (is_svf_exposure(col) && step2_stat == "PENDING SVF PROCESSING / MERGE") return(c("Sky View / Urban Morphology", "PLANNED CANDIDATE - PROCESSING PENDING", "SVF pending merge; not in the current model."))
  if (step2_stat != "Retained") return(c("N/A", "N/A", "N/A"))
  dom <- if (is_svf_exposure(col)) "Sky View / Urban Morphology" else if (grepl("gvi|tree|grass|plant", col)) "Greenery" else if (grepl("pm", col)) "Air Pollution" else if (grepl("lux|medi|kelvin", col)) "Visual Light" else if (col == "ucm_SND_dBA" || is_acoustic_frequency(col) || is_sound_semantic(col)) "Acoustic" else "Thermal"
  return(c(dom, "DATA-ELIGIBLE SCREENING CANDIDATE", "All Step-2 eligible measurements advance. Step 3 reports within-person Pearson/Spearman correlations and full matrix rank on the same complete phase cells; no health outcomes or hand-picked domain representatives enter selection."))
}

# build_final_row
build_final_row <- function(i) {
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
}

# infer_audit_domain
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

# --- 4. Step 4 design and VIF ---

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

h4_step4_equation_lines <- function(audit_df, raw_df = NULL, prep = NULL) {
  if (is.null(prep)) {
    if (is.null(raw_df)) raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
    for (v in c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg")) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
    prep <- h4_step4_exposure_prep(audit_df, raw_df)
  }
  catalog <- prep$catalog
  # Recompute the proposed designs; never attach historical fitted-model VIFs to new equations.
  outcomes <- unlist(H4_SPEC$outcomes[c("Physiological_Autonomic", "Physiological_Ocular")], use.names = FALSE)
  checks <- do.call(rbind, lapply(outcomes, function(y)
    h4_run_gvif_diagnostic(prep, design_outcome = y, write = FALSE)$by_equation))
  gvif_hr <- do.call(rbind, lapply(split(checks, checks$equation_id), function(d)
    data.frame(equation_id = d$equation_id[1], max_vif_equivalent = max(d$max_vif_equivalent),
      min_rows = min(d$n_design_rows), max_rows = max(d$n_design_rows))))
  cat(sprintf("Step 4: %d outcome-equation designs; full rank %d/%d; VIF >= %s: %d; rows %d-%d.\n",
    nrow(checks), sum(checks$full_rank), nrow(checks), H4_SPEC$vif_threshold, sum(checks$max_vif_equivalent >= H4_SPEC$vif_threshold),
    min(checks$n_design_rows), max(checks$n_design_rows)))
  print(gvif_hr[, c("equation_id", "max_vif_equivalent", "min_rows", "max_rows")], row.names = FALSE)
  flow_design_term_label <- function(col) {
    labels <- c(ucm_SND_dBA = "SND dBA", gvi_50m = "GVI", lys_kelvin_avg = "kelvin", lys_lux_avg = "lux",
      SVF_Holmer = "SVF", ucm_MRT = "MRT", ucm_SUN_Gh = "solar irradiance",
      ucm_AIR_temp = "air temperature", ucm_AIR_RH = "humidity", ucm_WIND_AWS = "apparent wind",
      ucm_HUMIDEX = "HUMIDEX", ucm_PET = "PET", ucm_UTCI = "UTCI", atmo_pm1_avg = "PM1",
      `atmo_pm2.5_avg` = "PM2.5", atmo_pm10_avg = "PM10")
    if (grepl(":", col, fixed = TRUE)) {
      parts <- strsplit(col, ":", fixed = TRUE)[[1]]
      parts[parts == "SND_dBA"] <- "ucm_SND_dBA"
      paste0("(", paste(vapply(parts, flow_design_term_label, character(1)), collapse = " x "), ")")
    } else if (col %in% names(labels)) unname(labels[[col]]) else h4_spell_term(col)
  }
  equation_summands <- function(i) {
    eq <- catalog[i, ]
    vars <- prep$thermal[[eq$heat_form]]
    terms <- colnames(prep$make_design(prep$centered[1L, , drop = FALSE], vars, "WalkG", test = eq$test))
    interactions <- terms[grepl(":SND_dBA$", terms)]
    partners <- sub(":SND_dBA$", "", interactions)
    main_terms <- setdiff(terms, c(H4_PHASE_SUM_COLS, interactions, partners,
                                 if (length(interactions)) "ucm_SND_dBA"))
    display_terms <- c(main_terms, partners)
    domain_terms <- unlist(H4_DOMAINS[H4_FLOW_DOMAIN_ORDER], use.names = FALSE)
    display_terms <- display_terms[order(match(display_terms, domain_terms))]
    summands <- vapply(display_terms, function(term) {
      label <- flow_design_term_label(term)
      if (term %in% partners) paste0(label, " * SND dBA") else label
    }, character(1))
    list(eq = eq, summands = summands)
  }
  lines <- vapply(seq_len(nrow(catalog)), function(i) {
    built <- equation_summands(i)
    paste0("H4.1 Eq", built$eq$equation_id, " (", built$eq$role, "): empatica/eyetracker outcome ~ ",
      paste(built$summands, collapse = " + "),
      " + (1 | participant) + (1 | participant:phase); 10 s windows")
  }, character(1))
  vif_by_eq <- gvif_hr$max_vif_equivalent[match(catalog$equation_id, gvif_hr$equation_id)]
  list(lines = lines, max_vif = vif_by_eq, checks = checks)
}

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


h4_run_gvif_diagnostic <- function(prep, design_outcome = "empatica_heart_rate", vif_threshold = H4_SPEC$vif_threshold, write = TRUE) {
  # Explicit local bindings from the Step 4 preparation (no list2env into this frame).
  raw_df <- prep$raw_df
  centered <- prep$centered
  selected <- prep$selected
  catalog <- prep$catalog
  make_design <- prep$make_design
  thermal <- prep$thermal
  if (!design_outcome %in% names(raw_df)) stop("GVIF design outcome not in data: ", design_outcome)
  vals <- as.matrix(raw_df[, c(selected, design_outcome), drop = FALSE])
  storage.mode(vals) <- "double"
  ok <- apply(vals, 1L, function(v) all(is.finite(v)))
  if (design_outcome %in% H4_SPEC$hrv_log) ok <- ok & raw_df[[design_outcome]] > 0
  z <- centered[ok, , drop = FALSE]
  phase_vec <- raw_df$PhaseID[ok]
  n_rows <- nrow(z)
  term_rows <- eq_rows <- list()
  for (i in seq_len(nrow(catalog))) {
    eq <- catalog[i, ]
    design <- make_design(z, thermal[[eq$heat_form]], phase_vec, test = eq$test)
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
  md_path <- file.path(OUT_DIR, "H4_models", "H4_gvif_diagnostic.md")
  md <- c("# H4 design-only GVIF / VIF diagnostic", "", sprintf("Reference complete-case outcome: **%s** (n = %d). Other outcomes use different row sets; see `H4_design_redundancy_by_outcome.csv`.", design_outcome, n_rows),
    "", "## PhaseID vs single continuous predictors", "", "PhaseID enters as **three** sum-to-zero contrasts (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit).",
    "In `car::vif`, that span is one **Df = 3** term with a generalized VIF (GVIF).",
    paste0("- **GVIF^(1/(2*Df))** is what `car::vif` prints for multi-df terms (Fox & Monette 1992; [car::vif](https://rdrr.io/cran/car/man/vif.html))."),
    "- **VIF_equivalent = GVIF^(1/Df)** is the square of that root; we compare **VIF_equivalent** to ", vif_threshold, " for the PhaseID block.",
    "- Continuous **Df = 1** columns use ordinary VIF (= VIF_equivalent). Values above the threshold are **flagged only**; no predictor is dropped.",
    "", "## Equation summaries (heart rate complete cases)", "", "| Eq | Heat form | Block | n | Max VIF-equiv | Worst term | Phase GVIF | Phase VIF-equiv |",
    "|----|-----------|-------|---|---------------|------------|------------|-----------------|",
    with(by_equation, sprintf("| %d | %s | %s | %d | %.3f | %s | %.3f | %.3f |", equation_id, heat_form, block, n_design_rows,
      max_vif_equivalent, worst_grouped_term, phase_GVIF, phase_vif_equivalent)), "", sprintf("Generated UTC: %s", format(Sys.time(), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")))
  csv_path <- file.path(OUT_DIR, "H4_models", "H4_gvif_diagnostic.csv")
  if (write) {
    dir.create(file.path(OUT_DIR, "H4_models"), recursive = TRUE, showWarnings = FALSE)
    utils::write.csv(term_df, csv_path, row.names = FALSE, na = "")
    writeLines(md, md_path)
  }
  list(terms = term_df, by_equation = by_equation, paths = c(csv = csv_path, md = md_path))
}


# --- 6. Reports (render flow, audit pdf, write results) ---

h4_archive <- function(paths, archive_dir) {
  paths <- paths[file.exists(paths)]
  if (!length(paths)) return(invisible())
  dir.create(archive_dir, recursive = TRUE, showWarnings = FALSE)
  moved <- file.rename(paths, file.path(archive_dir, basename(paths)))
  if (!all(moved)) stop("Could not archive: ", paste(paths[!moved], collapse = ", "))
  cat(sprintf("Archived %d previous output(s) to %s\n", length(paths), archive_dir))
}

h4_write_results <- function(audit_df, step5_result) {
  if (is.null(step5_result$h4_1) || is.null(step5_result$h4_1$coef) || !nrow(step5_result$h4_1$coef))
    stop("H4.1 fitting incomplete; refusing to publish final report")
  if (!identical(unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH))), H4_START_MD5)) stop("Script or input changed; refusing final publication")
  res_dir <- RESULT_DIR
  md <- file.path(OUT_DIR, "H4_models"); rd <- function(f) read.csv(file.path(md, f), stringsAsFactors = FALSE, check.names = FALSE)
  manifest_path <- file.path(md, "H4_run_complete.csv")
  recorded_sources <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV)))
  if (!file.exists(manifest_path)) stop("Missing H4_run_complete.csv; run Step 5 before publishing")
  man <- read.csv(manifest_path, stringsAsFactors = FALSE)
  if (!identical(recorded_sources, unname(unlist(man[1L, c("code_md5", "input_md5", "audit_md5")], use.names = FALSE))))
    stop("Fitted bundle sources no longer match; refusing report publication")
  dir.create(res_dir, recursive = TRUE, showWarnings = FALSE)
  co <- rd("H4_coefficients.csv")
  st <- rd("H4_fit_status.csv")
  if (nrow(co)) {
  st$model_note <- trimws(paste(ifelse(st$residual_structure == "independent_fallback", "independent-residual fallback (no q);", ""),
    ifelse(st$boundary_variance %in% TRUE, "boundary random-effect variance;", ""), ifelse(st$high_ar1_flag %in% TRUE, "AR(1) rho > 0.95;", ""), ifelse(st$residual_structure == "ARMA20", "ARMA(2,0) (AR(1) rho > 0.95);", "")))
  k <- match(paste(co$equation, co$outcome), paste(st$heat_form, st$outcome))
  co$n <- st$n[k]; co$model_note <- st$model_note[k]
  co$analysis_role <- "H4.1: within-bout empatica/eyetracker association (10 s windows)"
  co$independent_unit <- "participant cluster; repeated 10-second windows"
  co$p_method <- "participant-cluster CR2 / Satterthwaite"
  fb <- co$residual_structure == "independent_fallback"
  co$q_note <- ifelse(fb, "excluded: fallback fit (independent residuals)", ifelse(!is.na(co$q), "",
    ifelse(co$term_type == "covariate", "not tested: covariate", ifelse(co$term_type == "intercept", "not tested: intercept",
    ifelse(grepl("BikeU", co$term), "derived: BikeU = -(WalkG + WalkU + BikeG)",
    ifelse(co$term_type == "phase (study design)", "not tested: phase (study design)", ""))))))
  co$q_note[st$high_ar1_flag[k] %in% TRUE] <- "excluded: unresolved high-AR1 covariance after attempted repair"
  co$q_note[co$low_df_flag %in% TRUE] <- trimws(paste(co$q_note[co$low_df_flag %in% TRUE], "low df (<4); interpret with caution"))
  is_th <- co$term_type == "thermal exposure"
  heat_table <- co[is_th, ]
  write.csv(heat_table, file.path(res_dir, "H4_Heat_Noise_Exposures.csv"), row.names = FALSE, na = "")
  write.csv(co[!is_th, ], file.path(res_dir, "H4_Covariates_and_Phases.csv"), row.names = FALSE, na = "")
  }
  th <- if (nrow(co)) unique(co[co$term_type == "thermal exposure" & !grepl(":", co$term), c("term", "equation")]) else data.frame()
  cov <- if (nrow(co)) unique(co$term[co$term_type == "covariate"]) else character()
  role <- vapply(audit_df$Variable_Name, function(v) {
    if (v %in% H4_SPEC$h4_1_outcomes) return("H4.1 physiological/ocular outcome (10 s time series)")
    if (nrow(th) && v %in% th$term) return(paste0("heat term in Eq '", paste(th$equation[th$term == v], collapse = "', '"), "' (+ x sound)"))
    if (v == "ucm_SND_dBA") return("covariate in all equations + interaction partner (sound)")
    if (v %in% cov) return("covariate in all equations")
    "not used" }, character(1))
  keep <- c("Variable_Name", "Platform_Source", "Native_Unit", "Scientific_Domain", "Step1_Decision", "Step2_Rule", "Step2_Decision",
            "Step3_Decision", "Scientific_Filtration_Rationale", "Step4_Domain", "Step4_Category_Role", "Step4_Decision", "Step4_Restriction")
  write.csv(cbind(audit_df[, keep], Step5_Role = role), file.path(res_dir, "H4_Variable_Selection.csv"), row.names = FALSE, na = "")
  ex <- audit_df[audit_df$Step1_Decision == "Retained" & audit_df$Step2_Decision != "Retained", ]
  ex_tab <- aggregate(Variable_Name ~ Scientific_Filtration_Rationale, ex, function(x) paste(x, collapse = ", "))
  n_tab <- if (nrow(st)) unique(st[, c("outcome", "n", "n_participants")][st$equation_id == 1, ]) else data.frame()
  h41_md <- c("## Physiological and ocular models (10-second time series)",
    "Outcomes: autonomic and ocular sensors only. Nested (1 | ParticipantID / PhaseID) with AR(1) within bout.",
    if (nrow(n_tab)) sprintf("Sample sizes (Eq 1): see H4_hypothesis_readme.txt and %d-%d rows per outcome.", min(n_tab$n), max(n_tab$n)) else "")
  rep_md <- c("# H4 results report", "", h41_md, "",
    "## Files",
    "- H4_Heat_Noise_Exposures.csv / H4_Covariates_and_Phases.csv: H4.1 only",
    "- H4_Variable_Selection.csv, H4_Selection_Flow.pdf; working fits under H4_results/_work/H4_models/", "",
    if (file.exists(file.path(md, "H4_hypothesis_readme.txt"))) readLines(file.path(md, "H4_hypothesis_readme.txt")) else character(),
    if (file.exists(file.path(md, "H4_gvif_diagnostic.md"))) c("", readLines(file.path(md, "H4_gvif_diagnostic.md"))) else character())
  writeLines(rep_md, file.path(res_dir, "H4_Report.md"))
  f <- file.path(res_dir, c("H4_Report.md", "H4_Selection_Flow.pdf", "H4_Variable_Selection.csv"))
  for (nm in c("H4_Covariates_and_Phases.csv", "H4_Heat_Noise_Exposures.csv"))
    if (file.exists(file.path(res_dir, nm))) f <- c(f, file.path(res_dir, nm))
  stopifnot(all(file.exists(f)))
  add <- if (nrow(man)) man[rep(1L, length(f)), , drop = FALSE] else
    data.frame(file = character(length(f)), md5 = character(length(f)), code_md5 = recorded_sources[1L],
      input_md5 = recorded_sources[2L], audit_md5 = recorded_sources[3L], spec_md5 = NA_character_,
      completed_utc = character(length(f)), run_complete = logical(length(f)), run_scope = character(length(f)),
      stringsAsFactors = FALSE)
  add$file <- normalizePath(f, winslash = "/", mustWork = TRUE); add$md5 <- unname(tools::md5sum(f))
  completed <- rbind(man[!startsWith(man$file, "../") & !basename(man$file) %in% basename(f), , drop = FALSE], add)
  if (!identical(unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV))), recorded_sources)) stop("Sources changed during publication; completion marker remains false")
  completed$completed_utc <- format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ")
  completed$run_complete <- TRUE
  completed$run_scope <- "FULL"
  write.csv(completed, file.path(md, "H4_run_complete.csv"), row.names = FALSE)
  cat("[Results] Wrote", length(f), "files to", res_dir, "\n")
}

render_h4_faceted_flow <- function(audit_all = NULL, prep = NULL) {
  PDF_PATH <- file.path(RESULT_DIR, "H4_Selection_Flow.pdf")
  library(grid)
  # Font size in points for every label on this page.
  FONT_SIZE <- 15
  LH <- function(fs) ceiling(fs * 1.2)   # tight line height (px) for a font size
  if (is.null(audit_all)) audit_all <- read.csv(OUT_CSV, stringsAsFactors = FALSE)
  raw <- read.csv(RAW_DATA_PATH, check.names = FALSE)
  for (v in names(average_sources)) raw[[v]] <- rowMeans(raw[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  audit_all <- h4_step4_candidates(raw, audit_all)
  audit <- audit_all
  stopifnot(!anyDuplicated(audit$Variable_Name))
  stopifnot(all(c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg") %in% audit$Variable_Name))
  # Sensor label rules, applied in order: "name" matches the variable name, otherwise the current sensor text (case-insensitive).
  vn <- audit$Variable_Name
  sensor <- audit$Platform_Source
  atmo_raw <- grepl("^atmo_lys_atmotube_(left|right)__", vn)
  sensor_rules <- rbind(c("name", "^atmo_lys_atmotube_(left|right)__", "Atmo raw"), c("name", "^atmo_pm", "Atmo average"),
    c("name", "^lys_", "LYS average"), c("src", "UCM Backpack", "UCM"), c("atmotube", "Atmotube", "Atmo average"),
    c("src", "(^|[^A-Za-z])LYS([^A-Za-z]|$)", "LYS average"), c("name", "^atmo_lys_LYS1__", "LYS1 raw"), c("name", "^atmo_lys_LYS2__", "LYS2 raw"),
    c("src", "Eye-Level Panoramic Imagery|GVI", "GVI imagery"), c("src", "CamUp|DeepLab", "SVF imagery"), c("src", "Native-WAV|YAMNet", "Sound"),
    c("src", "Solar", "Solar"), c("name", "^empatica_", "Empatica"), c("name", "^eyetracker_", "Eye-tracker"), c("name", "^questionnaire_", "Questionnaire"))
  for (r in seq_len(nrow(sensor_rules))) {
    hit <- if (sensor_rules[r, 1] == "name") grepl(sensor_rules[r, 2], vn) else grepl(sensor_rules[r, 2], sensor, ignore.case = TRUE)
    sensor[hit & !(sensor_rules[r, 1] == "atmotube" & atmo_raw)] <- sensor_rules[r, 3]
  }
  sensor[grepl("Metadata|Demographics|QC|Provenance|Signal Quality", audit$Step1_Role)] <- "Metadata / QC"
  label_rules <- rbind(c("^atmo_lys_atmotube_(left|right)__atmotube_", "\\1 "), c("^atmo_lys_LYS([12])__lys_", "LYS\\1 "),
    c("^dominant_frequency_hz$", "dominant frequency (Hz)"), c("^spectral_centroid_hz$", "spectral centroid (Hz)"),
    c("^spectral_rolloff85_hz$", "spectral rolloff 85% (Hz)"), c("^freq_prop_([0-9]+)_([0-9]+)$", "band proportion \\1-\\2 Hz"),
    c("^octave_prop_([0-9]+)_([0-9]+)_hz$", "octave proportion \\1.\\2 Hz"), c("([0-9]+)\\.0 Hz$", "\\1 Hz"),
    c("(?i)^log_lys_", "log "), c("(?i)^ucm_", ""), c("(?i)^atmo_", ""), c("(?i)^lys_", ""), c("(?i)^gvi_", "GVI "),
    c("(?i)^tree_", "Tree "), c("(?i)^grass_", "Grass "), c("(?i)^plant_", "Plant "),
    c("^lys_atmotube_(left|right)__atmotube_", "\\1 "), c("^lys_LYS([12])__lys_", "LYS\\1 "),
    c("^(empatica|eyetracker|questionnaire)_", ""), c("(?i)_avg$", " avg"))
  column_label <- audit$Variable_Name
  for (r in seq_len(nrow(label_rules))) column_label <- sub(label_rules[r, 1], label_rules[r, 2], column_label, perl = TRUE)
  audit$Sensor <- sensor
  audit$Column <- trimws(gsub("_", " ", column_label))
  audit$Column <- sub("^background ", "", audit$Column)
  audit$Column[audit$Variable_Name == "SVF_Holmer"] <- "SVF"
  audit$Column <- sub("^hrv fd 5min ", "HRV 5min ", audit$Column)
  audit$Column <- sub("response index within participant", "response index", audit$Column)
  audit$Column <- sub(" seconds$", " (s)", audit$Column)
  audit$Column[match(c("ucm_Date", "atmo_lys_Date", "eyetracker_Date"), audit$Variable_Name, nomatch = 0L)] <- c("Date (UCM)", "Date (Atmo/LYS)", "Date (eye)")[c("ucm_Date", "atmo_lys_Date", "eyetracker_Date") %in% audit$Variable_Name]
  audit <- audit[order(audit$Sensor, audit$Column), ]
  step2 <- audit[audit$Step2_Status == "Retained", ]
  expected_raw_sources <- c(paste0("atmo_lys_atmotube_", rep(c("left", "right"), 3), "__atmotube_pm", rep(c("1", "2.5", "10"), each = 2)), paste0("atmo_lys_LYS", rep(1:2, each = 3), "__lys_", rep(c("lux", "medi", "kelvin"), 2)),
    paste0("atmo_lys_LYS", rep(1:2, each = 7), "__lys_", rep(c("b'", "g'", "r'", "rgbb", "rgbg", "rgbir", "rgbr"), 2)))
  stopifnot(all(expected_raw_sources %in% audit$Variable_Name),
    !any(grepl("^atmo_lys_(atmotube_left|atmotube_right|LYS1|LYS2)__", step2$Variable_Name)))
  candidate_names <- audit$Variable_Name[audit$Step3_Decision == "Retained"]
  stopifnot(length(candidate_names) > 0L)
  sensor_order <- c("UCM", "Atmo raw", "Atmo average", "LYS1 raw", "LYS2 raw", "LYS average", "GVI imagery", "SVF imagery", "Sound", "Solar", "Empatica", "Eye-tracker", "Questionnaire", "Metadata / QC")
  stopifnot(all(audit$Sensor %in% sensor_order), nrow(audit) == nrow(audit_all))
  audit <- audit[order(match(audit$Sensor, sensor_order), audit$Column), ]
  audit$Slot <- ave(seq_len(nrow(audit)), audit$Sensor, FUN = seq_along)
  audit$Subcolumn <- (audit$Slot - 1L) %/% 14L
  audit$Row <- (audit$Slot - 1L) %% 14L
  ncolumns <- sapply(sensor_order, function(s) max(c(0L, audit$Subcolumn[audit$Sensor == s])) + 1L)
  physio <- unlist(H4_SPEC$outcomes[c("Physiological_Autonomic", "Physiological_Ocular")], use.names = FALSE)
  stopifnot(all(physio %in% audit$Variable_Name), setequal(intersect(physio, H4_SPEC$hrv_log), H4_SPEC$hrv_log))
  shown <- audit$Column[match(physio, audit$Variable_Name)]
  physio_label <- ifelse(physio %in% H4_SPEC$hrv_log, paste0("log(", shown, ")"), shown)
  longest_label <- audit$Column
  is_selected <- audit$Variable_Name %in% candidate_names
  longest_label[is_selected] <- paste0(longest_label[is_selected], " [", audit$Measurement_Code[is_selected], "]")
  longest_label[match(physio, audit$Variable_Name)] <- physio_label
  grDevices::pdf(file = NULL, pointsize = FONT_SIZE, family = "Helvetica")
  label_width <- strwidth(longest_label, units = "inches")
  dev.off()
  all_titles <- c("Inventory (000)", "Representatives (000)", "Domain Grouping (000)", "Equations + design VIF", "(6 equations; physiological and ocular outcomes)")
  title_w <- max(strwidth(unlist(strsplit(all_titles, "\n")), units = "inches", cex = FONT_SIZE / FONT_SIZE, font = 2)) * 1.3 + .25
  widths <- vapply(sensor_order, function(s) ncolumns[s] * (max(c(.8, label_width[audit$Sensor == s])) * 1.04 + .18), numeric(1))
  page_width <- title_w + sum(widths) + .1
  lefts <- (title_w + cumsum(c(0, head(widths, -1)))) / page_width
  sensor_width <- widths / page_width
  sensor_id <- match(audit$Sensor, sensor_order)
  audit$X <- lefts[sensor_id] + .06 / page_width +
    audit$Subcolumn * sensor_width[sensor_id] / ncolumns[sensor_id]
  stages <- list(audit, audit[audit$Step2_Status == "Retained", ], audit[audit$Step3_Decision == "Retained", ])
  stopifnot(all(candidate_names %in% step2$Variable_Name), setequal(stages[[3]]$Variable_Name, step2$Variable_Name))
  stopifnot(all(vapply(stages, function(d) all(d$X == audit$X[match(d$Variable_Name, audit$Variable_Name)]), logical(1))))
  titles <- c(paste0("STEP 1\nInventory (", nrow(audit), ")"), paste0("STEP 2\nRepresentatives (", nrow(step2), ")\nRules + coverage"),
    paste0("STEP 3\nDomain Grouping (", nrow(stages[[3]]), ")"))
  max_rows <- vapply(stages, function(d) as.integer(max(c(1L, d$Row + 1L))), integer(1))
  max_rows[-1] <- vapply(stages[-1], function(d) as.integer(max(c(1L, table(interaction(d$Sensor, d$Subcolumn, drop = TRUE))))), integer(1))
  row_px <- c(LH(FONT_SIZE), LH(FONT_SIZE), LH(FONT_SIZE))
  title_px <- vapply(titles, function(t) length(strsplit(t, "\n")[[1]]) * LH(FONT_SIZE), numeric(1))
  display_domains <- H4_DOMAINS[H4_FLOW_DOMAIN_ORDER]
  n3 <- max(lengths(lapply(display_domains, intersect, candidate_names))) + 1L
  content_px <- c(max_rows[1] * row_px[1], max_rows[2] * row_px[2], LH(FONT_SIZE) + n3 * LH(FONT_SIZE))
  band_height <- pmax(title_px, content_px) + 20
  step5 <- h4_step4_equation_lines(audit_all, raw, prep = prep)
  n_eq <- length(step5$lines)
  equation_rows <- lengths(strsplit(step5$lines, "\n", fixed = TRUE))
  # Reserve space for the two model-design footnotes.
  step5_height <- max(3 * LH(FONT_SIZE), sum(equation_rows) * LH(FONT_SIZE) + n_eq * 5) + 2 * LH(FONT_SIZE) + 14
  head_px <- 8 + LH(FONT_SIZE) + LH(FONT_SIZE) + 2 * LH(FONT_SIZE) + 6
  page_height <- head_px + sum(band_height) + step5_height + 6
  band_top <- page_height - head_px - c(0, head(cumsum(band_height), -1))
  text_at <- function(x, y, label, size = 18, bold = FALSE, color = "#222222")
    grid.text(label, x = x, y = y, just = c("left", "top"), gp = gpar(fontsize = size, fontface = if (bold) "bold" else "plain", col = color))
  grDevices::cairo_pdf(PDF_PATH, width = page_width, height = page_height / 72, onefile = TRUE)
  grid.newpage()
  text_at(.06 / page_width, 1 - 8 / page_height, "H4 environmental-variable selection", FONT_SIZE, TRUE)
  text_at(.06 / page_width, 1 - (8 + LH(FONT_SIZE)) / page_height, "Step 4: six equations (primary UTCI + PM2.5; heat-form and PM-size sensitivities). Check full-design VIF/rank; no PCA/LASSO or automatic variable deletion.", FONT_SIZE)
  pending_svf <- sum(audit$Step2_Status == "PENDING SVF PROCESSING / MERGE")
  for (s in seq_along(sensor_order)) {
    heading <- sub(" (raw|average|imagery)$", "\n\\1", sensor_order[s])
    text_at(lefts[s] + .06 / page_width, 1 - (8 + LH(FONT_SIZE) + LH(FONT_SIZE) + 4) / page_height, heading, FONT_SIZE, TRUE)
  }
  for (k in seq_along(stages)) {
    d <- stages[[k]]
    if (k >= 2L && nrow(d) > 0L) d$Row <- ave(seq_len(nrow(d)), interaction(d$Sensor, d$Subcolumn), FUN = function(x) seq_along(x) - 1L)
    grid.text(titles[k], x = .06 / page_width, y = (band_top[k] - 6) / page_height,
      just = c("left", "top"), gp = gpar(fontsize = FONT_SIZE, fontface = "bold", col = "#222222", lineheight = 1.2))
    if (k == 2L && pending_svf > 0L) text_at(lefts[match("SVF imagery", sensor_order)] + .12 / page_width, band_top[k] / page_height,
      "SVF", FONT_SIZE)
    if (k == 3L) {
      category_width <- (page_width - title_w) / length(display_domains)
      for (g in seq_along(display_domains)) {
        domain <- names(display_domains)[g]
        category_x <- (title_w + (g - 1L) * category_width) / page_width
        variables <- intersect(display_domains[[g]], candidate_names)
        labels <- audit$Column[match(variables, audit$Variable_Name)]
        y_b <- band_top[k] - 6
        heading <- domain
        text_at(category_x, y_b / page_height, heading, FONT_SIZE, TRUE)
        for (j in seq_along(labels)) text_at(category_x, (y_b - LH(FONT_SIZE) - LH(FONT_SIZE) * (j - 1L)) / page_height, labels[j], FONT_SIZE)
        if (domain == "Radiation" && pending_svf > 0L) text_at(category_x,
          (y_b - LH(FONT_SIZE) - LH(FONT_SIZE) * length(labels)) / page_height, "SVF", FONT_SIZE)
      }
    } else for (j in seq_len(nrow(d))) {
      label <- d$Column[j]
      if (k >= 2L && d$Variable_Name[j] %in% H4_SPEC$hrv_log) label <- paste0("log(", label, ")")
      if (k == 3L) label <- paste0(label, " [", d$Measurement_Code[j], "]")
      text_at(d$X[j], (band_top[k] - 6 - d$Row[j] * row_px[k]) / page_height, label, if (k == 1L) FONT_SIZE else FONT_SIZE)
    }
  }
  x0 <- title_w / page_width
  draw_step_block <- function(title, lines, y_top) {
    grid.text(title, x = .06 / page_width, y = (y_top - 6) / page_height,
      just = c("left", "top"), gp = gpar(fontsize = FONT_SIZE, fontface = "bold", lineheight = 1.2))
    y <- y_top - 6
    vif_lab <- sprintf("max VIF = %.2f", step5$max_vif)
    width_npc <- function(t, fs) max(vapply(t, function(x) convertWidth(grobWidth(textGrob(x, gp = gpar(fontsize = fs))), "npc", TRUE), 0))
    avail <- .985 - width_npc(vif_lab, FONT_SIZE) - 40 / 72 / page_width - x0
    if (width_npc(unlist(strsplit(lines, "\n", fixed = TRUE)), FONT_SIZE) > avail) stop("Full equation exceeds available PDF width")
    for (j in seq_along(lines)) {
      grid.text(vif_lab[j], x = .985, y = y / page_height, just = c("right", "top"), gp = gpar(fontsize = FONT_SIZE, col = "#222222"))
      for (line in strsplit(lines[j], "\n", fixed = TRUE)[[1L]]) {
        text_at(x0, y / page_height, line, FONT_SIZE)
        y <- y - LH(FONT_SIZE)
      }
      y <- y - 5
    }
    text_at(x0, y / page_height, "Empatica/eyetracker on 10 s windows; within-bout centered exposures; AR(1) within participant-phase.", FONT_SIZE)
    text_at(x0, (y - LH(FONT_SIZE)) / page_height, "All equations adjust for phase. A * SND dBA includes A + SND dBA + A x SND dBA.", FONT_SIZE)
  }
  draw_step_block(paste0("STEP 4\nEquations + design VIF\n(6 equations; physiological and ocular outcomes)"), step5$lines, step5_height + 3)
  dev.off()
  # Refresh only the figure hash and label its scope; fitted tables still identify their original run.
  manifest_path <- file.path(OUT_DIR, "H4_models", "H4_run_complete.csv")
  if (file.exists(manifest_path)) {
    manifest <- read.csv(manifest_path, stringsAsFactors = FALSE)
    figure_row <- basename(manifest$file) == basename(PDF_PATH)
    if (any(figure_row)) {
      manifest$file[figure_row] <- normalizePath(PDF_PATH, winslash = "/", mustWork = TRUE)
      manifest$md5[figure_row] <- unname(tools::md5sum(PDF_PATH))
      if (!"artifact_scope" %in% names(manifest)) manifest$artifact_scope <- "fitted run; consult original code_md5"
      manifest$artifact_scope[figure_row] <- "current Step 4 candidate designs only; not evidence of a new model fit"
      write.csv(manifest, manifest_path, row.names = FALSE)
    }
  }
  cat("Verified stage counts:", paste(vapply(stages, nrow, integer(1)), collapse = " -> "), ". Fixed horizontal positions; zero connectors.\n")
  cat("Saved figure (1 page):", PDF_PATH, "\n")
}

render_audit_pdf <- function(audit_df, output_path, preview_path = NULL) {
    collapse_group <- function(df, mask, new_name) {
        if (sum(mask) <= 1) return(df)
        df$Variable_Name[which(mask)[1]] <- sprintf("%s (%d variables)", new_name, sum(mask))
        df[!(mask & seq_len(nrow(df)) != which(mask)[1]), ]
    }
    audit_df <- collapse_group(audit_df, grepl("yamnet_class", audit_df$Variable_Name), "YAMNet Audio Classes")
    audit_df <- collapse_group(audit_df, grepl("^octave_prop", audit_df$Variable_Name), "Octave Frequency Bands")
    is_environment <- audit_df$Step1_Role == "Environmental Stressor Candidates (X_env)"
    is_physio <- grepl("Physiological Sensor Outcomes", audit_df$Step1_Role)
    is_outcome <- is_physio
    is_metadata_qc <- grepl("Metadata|Demographics|QC|Provenance|Signal Quality", audit_df$Step1_Role) | audit_df$Final_Filtration_Outcome == "QC METRIC"
    is_movement <- grepl("Movement", audit_df$Step1_Role)
    role <- ifelse(is_environment, "Environmental Candidate (X)", ifelse(is_physio, "Outcome Y - Physiological",
        ifelse(is_movement, "Movement Covariate (Z)", ifelse(is_metadata_qc, "Metadata / QC - Not Candidate",
            "Outside Declared H4 Set"))))
    step2 <- ifelse(is_environment & audit_df$Step2_Status != "-", ifelse(audit_df$Step2_Decision == "Retained", "Eligible", "Not advanced"),
        ifelse(is_outcome, "Analyzed as outcome Y", ifelse(is_movement, "Movement variable", "-")))
    candidate <- audit_df$H4_Screening_Candidate == "Yes"
    step3 <- ifelse(candidate, paste(audit_df$Measurement_Code, audit_df$Measurement_Type), "-")
    final_role <- ifelse(candidate, "Candidate; model specification pending", ifelse(is_physio, "Physiological outcome",
        ifelse(is_movement, "Movement covariate", audit_df$Final_Filtration_Outcome)))
    clean_source <- audit_df$Platform_Source
    for (r in list(c("YAMNet", "YAMNet Audio"), c("Atmo", "Atmotube"), c("UCM Backpack", "UCM Backpack"), c("Empatica", "Empatica"),
        c("LYS", "LYS Button"), c("Pupil", "Eye-Tracker"), c("Questionnaire|Surveys", "Questionnaire"),
        c("Imagery|GVI|DeepLabV3", "Street View / GIS"), c("WAV Spectral", "Acoustic Spectral")))
        clean_source <- sub(paste0("^.*(", r[1], ").*$"), r[2], clean_source)
    table_df <- data.frame(`Sr. No.` = integer(nrow(audit_df)), `Data Source (Sensor)` = clean_source, Variable = audit_df$Variable_Name,
        `Step 1: Role` = role, `Step 2: Preprocessing` = step2, `Step 3: Measurement provenance` = step3, `Final role` = final_role,
        check.names = FALSE, stringsAsFactors = FALSE)
    role_priority <- ifelse(grepl("Outcome", table_df$`Step 1: Role`), "01", ifelse(grepl("Primary Predictor", table_df$`Final role`),
        "02", ifelse(grepl("Environmental Candidate", table_df$`Step 1: Role`), "03", ifelse(grepl("Covariate", table_df$`Step 1: Role`),
            "04", "05"))))
    order_key <- paste0(role_priority, "_", table_df[[2]], "_", table_df$Variable)
    table_df <- table_df[order(order_key), , drop = FALSE]
    table_df$`Sr. No.` <- seq_len(nrow(table_df))
    page_rows <- split(seq_len(nrow(table_df)), ceiling(seq_len(nrow(table_df))/15L))
    wrap_widths <- c(6L, 20L, 42L, 28L, 34L, 34L, 38L)
    column_widths <- c(0.5, 1.8, 3.4, 2.4, 2.8, 2.8, 3.2)
    grDevices::cairo_pdf(output_path, width = 17, height = 11, onefile = TRUE, family = "sans")
    on.exit(grDevices::dev.off(), add = TRUE)
    subtitle_text <- paste("Step 1: Complete column inventory and analytical roles.", "Step 2: Existing sensor consolidation and exposure-representation rules, unchanged.",
        "Step 3: Measurement provenance and shared-design diagnostics; all Step-2 eligible fields remain candidates.", "No VIF elimination stage. Current fitted equation and diagnostics are in H4_Step5_Equations_Checks.txt.",
        sep = "\n")
    for (page in seq_along(page_rows)) {
        rows <- page_rows[[page]]
        page_df <- table_df[rows, , drop = FALSE]
        for (column in seq_len(ncol(page_df))) {
            page_df[[column]] <- vapply(as.character(page_df[[column]]), function(value)
                paste(strwrap(value, width = wrap_widths[column]), collapse = "\n"), character(1))
        }
        table_grob <- gridExtra::tableGrob(page_df, rows = NULL, theme = gridExtra::ttheme_minimal(base_size = 9, padding = grid::unit(c(3,
            4.5), "mm"), core = list(fg_params = list(hjust = 0, x = 0.02, fontsize = 9), bg_params = list(fill = c("#ffffff",
            "#f8f9fa")[((seq_len(nrow(page_df)) - 1)%%2) + 1], col = NA, lwd = 0)), colhead = list(fg_params = list(fontface = "bold", hjust = 0,
            x = 0.02, fontsize = 9.5), bg_params = list(fill = "#dce6f1", col = NA, lwd = 0))))
        table_grob$widths <- grid::unit(column_widths, "in")
        if (page == 1L && !is.null(preview_path)) {
            preview <- gridExtra::arrangeGrob(grid::textGrob("H4 Variable Audit Table", gp = grid::gpar(fontface = "bold",
                fontsize = 16)), table_grob, ncol = 1, heights = grid::unit(c(0.6, 9.8), "in"))
            ggplot2::ggsave(preview_path, preview, width = 17, height = 11, dpi = 220, limitsize = FALSE)
        }
        grid::grid.newpage()
        grid::grid.text("H4 Comprehensive Variable Audit", x = 0.5, y = 0.965, gp = grid::gpar(fontface = "bold", fontsize = 15))
        grid::grid.text(subtitle_text, x = 0.5, y = 0.89, just = c("centre", "top"), gp = grid::gpar(fontsize = 8.5, col = "#333333",
            lineheight = 1.1))
        grid::pushViewport(grid::viewport(x = 0.5, y = 0.77, just = c("centre", "top"), width = sum(table_grob$widths), height = sum(table_grob$heights)))
        grid::grid.draw(table_grob)
        grid::popViewport()
        grid::grid.text(sprintf("Page %d of %d  |  Full machine-readable audit: H4_Multivariate_Filtration_Results.csv",
            page, length(page_rows)), x = 0.5, y = 0.03, gp = grid::gpar(fontsize = 8, col = "gray40"))
    }
    invisible(length(page_rows))
}

# --- 7. Pipeline: h4_run_full_pipeline, h4_dispatch_run ---

h4_run_audit <- function() {
    # Full run: archive the top-level outputs this script regenerates (H4_models/ archives itself in Step 5).
    h4_regenerated <- c(OUT_CSV, sub(".csv$", "_latest.csv", OUT_CSV), AUDIT_PNG, AUDIT_PDF, STAGE_SUMMARY_CSV, INTEGRATION_CSV,
                        STEP_CATEGORY_CSV, FINAL_OUTCOME_COUNTS_CSV, TRANSPARENCY_MD, FORMULA_TXT,
                        file.path(OUT_DIR, "H4_Phase_Coverage.csv"),
                        file.path(RESULT_DIR, c("H4_Heat_Noise_Exposures.csv", "H4_Covariates_and_Phases.csv", "H4_Report.md",
                          "H4_Selection_Flow.pdf", "H4_Variable_Selection.csv")))
    h4_archive(h4_regenerated, file.path(OUT_DIR, "_archive", paste0("run_", format(Sys.time(), "%Y%m%d_%H%M%S"))))
    cat("[1/6] Loading canonical 8-minute analysis dataset...\n")
    df <- read.csv(RAW_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE)
    BASE_DATA_PATH <- file.path(dirname(PROJECT_ROOT), "Paper3_Github/output/merged_all_11participants_8min.csv")
    if (file.exists(BASE_DATA_PATH)) {
      base_data <- read.csv(BASE_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE)
      key_columns <- c("ParticipantID", "PhaseID", "Datetime")
      key_string <- function(x) do.call(paste, c(x[key_columns], sep = "::"))
      base_keys <- key_string(base_data)
      if (anyDuplicated(base_keys) || anyDuplicated(key_string(df))) stop("Duplicate merge keys in analysis or canonical input.")
      base_order <- match(key_string(df), base_keys)
      if (anyNA(base_order) || nrow(df) != nrow(base_data)) stop("Analysis merge keys differ from canonical input; rebuild statistical inputs.")
      shared_model_columns <- intersect(names(base_data), c(H4_SPEC$all_outcomes, "empatica_hrv_fd_5min_available", unlist(H4_SPEC$bilateral_sources), "ucm_UTCI", "ucm_SND_dBA"))
      stale_columns <- shared_model_columns[!vapply(shared_model_columns, function(v) isTRUE(all.equal(df[[v]], base_data[[v]][base_order], tolerance = 1e-10, check.attributes = FALSE)), logical(1))]
      if (length(stale_columns)) stop("Analysis merge has stale sensor values; rebuild statistical inputs: ", paste(stale_columns, collapse = ", "))
    } else {
      warning("Canonical sensor base not found at ", BASE_DATA_PATH, ". Skipping stale-data check (this is expected if running externally).")
    }
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

    step2_mat <- t(mapply(classify_step2_consolidation, all_variables_pool, step1_mat[, 2], USE.NAMES = FALSE))
    cat("[4/6] Step 3: Auditing every Step-2 eligible measurement; no domain shortlist...\n")
    h4_measurement_sources <- data.frame(
        Variable_Name = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_SND_dBA", "ucm_SUN_Gh", "atmo_pm1_avg",
            "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg", "ucm_MRT", "ucm_PET", "ucm_UTCI",
            "ucm_HUMIDEX", "Clearness_Index", "Clearness_Index_G0", "gvi_50m", "ucm_WIND_AWS", "ucm_fp", "SVF_Holmer"),
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
    write.csv(h4_prepared_for_vif$coverage, file.path(OUT_DIR, "H4_Phase_Coverage.csv"), row.names = FALSE, na = "")
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
    final_filtration_df <- do.call(rbind, lapply(1:length(all_variables_pool), build_final_row))
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
        "Participant is the independent cluster. Step 4 defines six equations (primary UTCI + PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 only with UTCI) including heat x sound and MRT x sound. Step 5 fits those six for physiological and ocular outcomes. Earlier model outputs are historical until a verified rerun succeeds.",
        "## Stage totals", fmt_md_table(stage_totals_report), "## Measurement definitions and dependencies", fmt_md_table(h4_measurement_sources),
        "Step 2 representatives and averages are study choices, not automatic literature rules. LYS1 and LYS2 represent different wearers.",
        "fp remains unverified; true wind speed (TWS) excluded (gaps, undocumented correction); SVF_Holmer from CamUp merge in merged_all_11participants_8min.csv (Step 2 Retained when coverage passes).",
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

    writeLines(c("Step 3: measurement categories.", "Step 4: retain 16 candidates; specify 6 equations (primary UTCI + PM2.5); check full-design rank and VIF including MRT x sound.",
        "Step 5: mixed-model fitting, covariance diagnostics and inference; new equations require a new verified fit."), FORMULA_TXT)

    list(audit_df = final_filtration_df, raw_df = df)
}

h4_run_full_pipeline <- function() {
    res <- h4_run_audit()
    invisible(h4_run_models(res$audit_df, res$raw_df))
    cat("H4 multivariate full pipeline completed successfully.\n")
    quit(save = "no", status = 0)
}

h4_publish_outputs <- function(audit_df, step5_result, prep = NULL) {
  render_h4_faceted_flow(prep = prep)
  h4_write_results(audit_df, step5_result)
  if (identical(Sys.getenv("H4_INCLUDE_AUDIT_PDF"), "1")) {
    render_audit_pdf(audit_df, AUDIT_PDF)
    cat("Included optional wide audit table PDF:", AUDIT_PDF, "\n")
  }
  invisible(NULL)
}

# h4_dispatch_run() reads optional environment flags before the default full pipeline.
# H4_RENDER_FLOW_ONLY: render only the one-page selection-flow figure (H4_Selection_Flow.pdf); no fits or CSV publish.
# H4_AUDIT_PDF_ONLY / H4_INCLUDE_AUDIT_PDF: wide full-variable audit table PDF; optional on full run (default off).
# H4_TIME_SENSITIVITY (and H4_STEP6_PRIMARY): retired modes; the script stops with an error if either is set.
# H4_STEP5_ONLY: skip Steps 1-3, load saved Step 4 audit CSV (OUT_CSV), run fit + publish; STEP4/GVIF/FACET_REFRESH are partial reruns.
h4_dispatch_run <- function() {
  if (identical(Sys.getenv("H4_STEP6_PRIMARY"), "1")) stop("The post-hoc UTCI reporting mode is retired; inspect the current Step 5 report.")
  if (identical(Sys.getenv("H4_TIME_SENSITIVITY"), "1")) {
    stop("Temporal sensitivity is not migrated to the consolidated fitter. No models run: do not use the archived wrapper, which targets a removed script.", call. = FALSE)
  }
  if (identical(Sys.getenv("H4_RENDER_FLOW_ONLY"), "1")) {
    render_h4_faceted_flow()
    quit(save = "no", status = 0)
  }
  if (identical(Sys.getenv("H4_AUDIT_PDF_ONLY"), "1")) {
    if (!file.exists(OUT_CSV)) stop("Existing H4 audit CSV not found: ", OUT_CSV, call. = FALSE)
    render_audit_pdf(utils::read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), AUDIT_PDF)
    cat("Rendered audit table PDF only:", AUDIT_PDF, "\n")
    quit(save = "no", status = 0)
  }
  if (identical(Sys.getenv("H4_STEP4_ONLY"), "1")) {
    render_h4_faceted_flow()
    cat("Step 4 only: updated candidate-equation PDF and scoped figure hash; no model fits or coefficient writes.\n")
    quit(save = "no", status = 0)
  }
  if (identical(Sys.getenv("H4_GVIF_ONLY"), "1")) {
    if (file.exists(file.path(OUT_DIR, "H4_models", "H4_run_complete.csv")))
      stop("H4_models has a completion manifest; rerun Step 5 instead of rewriting GVIF files after hashing.")
    raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
    for (v in setdiff(names(average_sources), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
    out <- h4_run_gvif_diagnostic(h4_step4_exposure_prep(read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), raw_df))
    cat("Wrote GVIF diagnostic:", out$paths["csv"], "\n")
    quit(save = "no", status = 0)
  }
  if (identical(Sys.getenv("H4_FACET_REFRESH"), "1")) {
    if (!file.exists(file.path(OUT_DIR, "H4_models", "H4_run_complete.csv"))) {
      raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
      for (v in setdiff(names(average_sources), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
      h4_run_gvif_diagnostic(h4_step4_exposure_prep(read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), raw_df))
    }
    render_h4_faceted_flow()
    quit(save = "no", status = 0)
  }
  if (identical(Sys.getenv("H4_STEP5_ONLY"), "1")) {
    if (!file.exists(OUT_CSV)) stop("H4_STEP5_ONLY=1 but no saved Step 4 audit at: ", OUT_CSV, call. = FALSE)
    cat("[Fast Track] Found existing validated Step 4 audit at:", OUT_CSV, "\n")
    audit_df <- read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE)
    raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
    for (v in setdiff(names(average_sources), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
    invisible(h4_run_models(audit_df, raw_df))
    cat("H4 multivariate Step 5 execution and faceted flow PDF update completed successfully.\n")
    quit(save = "no", status = 0)
  }
  h4_run_full_pipeline()
}

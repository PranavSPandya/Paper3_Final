# Analysis_combined_core.R — audit (Steps 1-4), reports, dispatch; sourced by Analysis_combined_timeseries.R / Analysis_combined_phaseavg.R.
# h4_study_spec cohort/outcomes and equation quotes live in the meeting entry scripts.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing Analysis_combined_core.R (source scripts/statistical_analysis/Analysis_combined_timeseries.R).", call. = FALSE)
}
if (!exists("h4_study_spec", envir = .GlobalEnv, inherits = FALSE)) {
  stop("h4_study_spec must be set before sourcing Analysis_combined_core.R.", call. = FALSE)
}
h4_study_spec <- paper3_ensure_outcome_normalization(h4_study_spec, PROJECT_ROOT)
if (is.null(h4_study_spec$all_physiological_outcomes)) {
  h4_study_spec$all_physiological_outcomes <- h4_study_spec$physiological_outcome_names
}
h4_study_spec$empatica_hrv_fd_window_outcomes <- attr(h4_study_spec$physiological_outcome_names, "empatica_hrv_fd_window")
# --- data prep metadata (not part of equation spec) ---
# outcome_transform: report labels from normalization CSV.
h4_study_spec$outcome_transform <- setNames(
  ifelse(h4_study_spec$all_physiological_outcomes %in% h4_study_spec$natural_log_outcome_names, "natural log", "native"),
  h4_study_spec$all_physiological_outcomes
)
# bilateral_sources: left/right sensor columns row-averaged to atmo_pm2.5_avg and lys_lux_avg in h4_prepare_data().
h4_study_spec$bilateral_sources <- list(
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")
)

# --- output paths (flat analysis-specific H4 result folders; not part of meeting spec) ---
# Variant folders: results/Analysis_combined_timeseries/ or results/Analysis_combined_phaseavg/ (Analysis_combined_timeseries_* / Analysis_combined_phaseavg_* files).
# h4_file() maps "H4_x" -> "<H4_VARIANT>_x" with H4_FILE_PREFIX = paste0("Analysis_combined_", H4_VARIANT).
# H4_ANALYSIS_MODE is set by Analysis_combined_phaseavg.R before sourcing this file; default is timeseries.
H4_VARIANT <- if (identical(get0("H4_ANALYSIS_MODE", ifnotfound = "timeseries"), "phaseavg")) "phaseavg" else "timeseries"
H4_FILE_PREFIX <- paste0("Analysis_combined_", H4_VARIANT)
h4_file <- function(filename) sub("^H4_", paste0(H4_FILE_PREFIX, "_"), filename)
H4_RESULTS_ROOT <- file.path(PROJECT_ROOT, "output/statistical_analysis/results")
H4_OUT_PATHS <- local({
  result_dir <- file.path(H4_RESULTS_ROOT, H4_FILE_PREFIX)
  work_dir <- result_dir
  dir.create(work_dir, recursive = TRUE, showWarnings = FALSE)
  list(
    result_dir = result_dir,
    work_dir = work_dir,
    filtration_csv = file.path(work_dir, h4_file("H4_Multivariate_Filtration_Results.csv")),
    audit_pdf = file.path(work_dir, h4_file("H4_All_Variables_Audit.pdf")),
    stage_summary_csv = file.path(work_dir, h4_file("H4_Audit_Stage_Summary.csv")),
    integration_csv = file.path(work_dir, h4_file("H4_Integration_Readiness.csv")),
    step_category_csv = file.path(work_dir, h4_file("H4_Step_Category_Counts.csv")),
    final_outcome_counts_csv = file.path(work_dir, h4_file("H4_Final_Outcome_Counts.csv")),
    transparency_md = file.path(work_dir, h4_file("H4_Transparency_Report.md")),
    formula_txt = file.path(work_dir, h4_file("H4_Multivariate_Formula.txt")),
    phase_coverage_csv = file.path(work_dir, h4_file("H4_Phase_Coverage.csv"))
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

# --- 1. Configuration (domains, column lists) ---
H4_DOMAINS <- list(
  Acoustic = "ucm_SND_dBA",
  Thermal = c("ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_WIND_AWS"),
  Index = c("ucm_HUMIDEX", "ucm_PET", "ucm_UTCI", "ucm_OPT"),
  Radiation = c("ucm_MRT", "ucm_SUN_Gh", "SVF"),
  Pollution = c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg"),
  Light = c("lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg"),
  Greenery = "gvi_50m")
H4_FLOW_DOMAIN_ORDER <- c("Thermal", "Index", "Acoustic", "Radiation", "Pollution", "Light", "Greenery")
H4_STEP4_THERMAL_CATEGORIES <- c("Thermal", "Index")
average_sources <- list(
  atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
  atmo_pm2.5_avg = h4_study_spec$bilateral_sources$atmo_pm2.5_avg,
  atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
  lys_lux_avg = h4_study_spec$bilateral_sources$lys_lux_avg,
  lys_medi_avg = c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi"),
  lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))
h4_apply_average_sources <- function(raw_df, vars = names(average_sources), missing_only = TRUE) {
  use <- if (missing_only) intersect(vars, setdiff(names(average_sources), names(raw_df))) else intersect(vars, names(average_sources))
  for (v in use) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  raw_df
}
PARTICIPANTS <- h4_study_spec$participants
CORE_PHASES <- h4_study_spec$phases
SOUND_QC_COLUMNS <- c(
  "segment", "end_time_s", "window_duration_s", "is_complete_10s_window", "phase_start_offset_s", "yamnet_frame_count",
  "yamnet_threshold", "original_sample_rate_hz", "frequency_analysis_min_hz", "frequency_analysis_max_hz",
  "frequency_analysis_full_20khz_coverage")
SOUND_CATEGORY_PROP_COLUMNS <- c(
  "wind_proportion", "rural_natural_proportion", "vehicle_proportion", "urban_manmade_neutral_proportion", "urban_manmade_positive_proportion",
  "urban_manmade_negative_proportion", "mechanisms_proportion", "unidentify_proportion")
# Scene shares and totals are percent of the fisheye circle (0â€“100).
# Total_Vegetation_% = Tree_% + Plant_% + Grass_%; Total_Builtup_% = Building_% + Wall_% (ceiling separate).
# Combined_Vegetation_% is the current merge's vegetation aggregate (secondary to SVF).
SVF_EXPOSURE_COLUMNS <- c(
  "Sky_%", "SVF", "Tree_%", "Plant_%", "Grass_%", "Total_Vegetation_%", "Combined_Vegetation_%",
  "Building_%", "Wall_%", "Ceiling_%", "Total_Builtup_%")
SVF_QC_COLUMNS <- c(
  "Filename", "Timestamp", "Camera", "Calibration", "Calibration_Table", "Run_Config_Signature", "Calibration_QC",
  "Calibration_Ref_Radius_px", "Raw_Lens_Radius_px", "Rectified_Lens_Radius_px", "Square_Hemisphere_Crop", "SVF_Method",
  "SVF_Rings", "Pitch_Roll_Correction", "Model", "Image_Path", "Segmented_Image_Path", "telemetry_matched",
  "SVF_Frames_In_Window", "SVF_Status")
EXPECTED_SOUND_FREQUENCY_COLUMNS <- c(
  "dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz", "freq_proportion_20_to_200Hz",
  "freq_proportion_200_to_2000Hz", "freq_proportion_2000_to_20000Hz", "octave_proportion_31.25Hz", "octave_proportion_62.5Hz",
  "octave_proportion_125Hz", "octave_proportion_250Hz", "octave_proportion_500Hz", "octave_proportion_1000Hz", "octave_proportion_2000Hz",
  "octave_proportion_4000Hz", "octave_proportion_8000Hz")
H4_PHASE_SUM_COLS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")

# merge_11participant_statistical_inputs.py exports _Hz / octave_proportion_*_Hz; meeting scripts use *_hz / 31.25Hz names.
h4_normalize_merged_schema_names <- function(df) {
  renames <- c(
    spectral_centroid_Hz = "spectral_centroid_hz",
    dominant_frequency_Hz = "dominant_frequency_hz",
    spectral_rolloff85_Hz = "spectral_rolloff85_hz",
    octave_proportion_31_5_Hz = "octave_proportion_31.25Hz",
    octave_proportion_63_0_Hz = "octave_proportion_62.5Hz",
    octave_proportion_125_0_Hz = "octave_proportion_125Hz",
    octave_proportion_250_0_Hz = "octave_proportion_250Hz",
    octave_proportion_500_0_Hz = "octave_proportion_500Hz",
    octave_proportion_1000_0_Hz = "octave_proportion_1000Hz",
    octave_proportion_2000_0_Hz = "octave_proportion_2000Hz",
    octave_proportion_4000_0_Hz = "octave_proportion_4000Hz",
    octave_proportion_8000_0_Hz = "octave_proportion_8000Hz"
  )
  for (from in names(renames)) {
    to <- unname(renames[[from]])
    if (!from %in% names(df)) next
    if (to %in% names(df) && !identical(from, to)) {
      stop("Column rename conflict: ", from, " and ", to, " both present.", call. = FALSE)
    }
    names(df)[names(df) == from] <- to
  }
  df
}

h4_read_merged_analysis_data <- function() {
  h4_normalize_merged_schema_names(read.csv(RAW_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE))
}

h4_equation_term_order <- function(eq_id) {
  if (!exists("H4_EQUATION_FIXED", envir = .GlobalEnv, inherits = FALSE)) {
    stop("H4_EQUATION_FIXED not defined; source scripts/statistical_analysis/Analysis_combined_timeseries.R first.", call. = FALSE)
  }
  get("H4_EQUATION_FIXED", envir = .GlobalEnv)[[as.character(eq_id)]]
}

h4_equation_thermal_label <- function(row) {
  pm_short <- c(atmo_pm2.5_avg = "PM2.5", atmo_pm1_avg = "PM1", atmo_pm10_avg = "PM10")[row$particulate_matter_column]
  stopifnot(length(pm_short) == 1L, !is.na(pm_short))
  paste0("Eq", row$equation_number, ": heat = ", row$heat_predictor_label, ", PM = ", unname(pm_short))
}

h4_sound_interaction_terms <- function(terms_order) {
  terms_order[grepl(":", terms_order, fixed = TRUE) & grepl("ucm_SND_dBA", terms_order, fixed = TRUE)]
}

# Step 3 / Step 4 left-to-right domain order (Thermal -> Greenery); phases then sound interactions.
h4_domain_var_sequence <- function() unlist(H4_DOMAINS[H4_FLOW_DOMAIN_ORDER], use.names = FALSE)

h4_order_mains_by_flow_domain <- function(main_names) {
  main_names <- unique(as.character(main_names))
  seq <- h4_domain_var_sequence()
  main_names[order(match(main_names, seq), na.last = TRUE)]
}

# Pre-interaction design columns: heat (equation order), sound after first heat main, then other covariates by domain.
h4_design_main_column_order <- function(heat_vars, env_covars) {
  heat_vars <- unique(as.character(heat_vars))
  env_covars <- unique(as.character(env_covars))
  snd <- intersect("ucm_SND_dBA", env_covars)
  rest <- h4_order_mains_by_flow_domain(setdiff(env_covars, c(heat_vars, snd)))
  if (length(heat_vars) && length(snd)) c(heat_vars[1L], snd, heat_vars[-1L], rest) else c(heat_vars, snd, rest)
}

h4_order_terms_by_flow_domain <- function(term_names, heat_vars = character(0)) {
  term_names <- unique(as.character(term_names))
  heat_vars <- unique(as.character(heat_vars))
  domain_seq <- h4_domain_var_sequence()
  phases <- intersect(H4_PHASE_SUM_COLS, term_names)
  interactions <- term_names[grepl(":", term_names, fixed = TRUE)]
  mains <- setdiff(term_names, c(phases, interactions))
  heat_mains <- intersect(mains, heat_vars)
  heat_mains <- heat_mains[order(match(heat_mains, domain_seq))]
  snd <- intersect("ucm_SND_dBA", mains)
  other_mains <- setdiff(mains, c(heat_mains, snd))
  other_mains <- other_mains[order(match(other_mains, domain_seq))]
  ordered_mains <- if (length(heat_mains) && length(snd)) {
    c(heat_mains[1L], snd, heat_mains[-1L], other_mains)
  } else {
    c(heat_mains, snd, other_mains)
  }
  if (length(interactions)) {
    partners <- vapply(interactions, function(term) {
      setdiff(strsplit(term, ":", fixed = TRUE)[[1]], "ucm_SND_dBA")[1L]
    }, character(1))
    partner_rank <- function(p) {
      if (p %in% heat_mains) return(match(p, heat_mains))
      unname(match(p, domain_seq))
    }
    interactions <- interactions[order(vapply(partners, partner_rank, numeric(1)), na.last = TRUE)]
  }
  c(ordered_mains, phases, interactions)
}

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
    ucm_AIR_T_mid = "air temperature (mid)", ucm_AIR_temp = "air temperature", ucm_AIR_RH = "humidity",
    ucm_MRT = "mean radiant temperature", ucm_HUMIDEX = "HUMIDEX", ucm_PET = "PET", ucm_UTCI = "UTCI",
    atmo_pm1_avg = "PM1", atmo_pm2.5_avg = "PM2.5", atmo_pm10_avg = "PM10",
    setNames(paste("Phase:", c("WalkG", "WalkU", "BikeG", "BikeU"), "vs mean of phases"), paste0("PhaseSum", c("WalkG", "WalkU", "BikeG", "BikeU"))))
  parts <- strsplit(term, ":", fixed = TRUE)[[1]]
  parts <- ifelse(parts %in% names(pretty), pretty[parts], parts)
  if (length(parts) > 1L) paste0("(", parts[1], " x ", parts[2], ")") else parts
}

# Validator (h4_prepare_data) and Steps 1-3 audit classifiers.
h4_prepare_data <- function(raw) {
    required <- unique(c("ParticipantID", "PhaseID", "Datetime", "empatica_hrv_fd_5min_available", unlist(h4_study_spec$bilateral_sources),
        c("ucm_UTCI", "ucm_SND_dBA", "gvi_50m"), h4_study_spec$all_physiological_outcomes))
    missing <- setdiff(required, names(raw))
    if (length(missing)) stop("Required H4 input columns missing: ", paste(missing, collapse = ", "))
    raw <- raw[raw$ParticipantID %in% h4_study_spec$participants & raw$PhaseID %in% h4_study_spec$phases, , drop = FALSE]
    for (v in h4_study_spec$all_physiological_outcomes) {
        raw[[v]] <- as.numeric(raw[[v]])
        raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    }
    # natural-log outcomes: non-positive values excluded before ln(x) at fit time (see fit_one_outcome)
    for (v in h4_study_spec$natural_log_outcome_names) raw[[v]][!is.na(raw[[v]]) & raw[[v]] <= 0] <- NA_real_
    for (v in names(h4_study_spec$bilateral_sources)) raw[[v]] <- rowMeans(raw[, h4_study_spec$bilateral_sources[[v]], drop = FALSE],
        na.rm = TRUE)
    for (v in c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg")) raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    raw$ucm_SND_dBA[!is.na(raw$ucm_SND_dBA) & raw$ucm_SND_dBA < 0] <- NA_real_
    available <- tolower(as.character(raw$empatica_hrv_fd_5min_available)) %in% c("true", "1")
    for (v in h4_study_spec$empatica_hrv_fd_window_outcomes) raw[[v]][!available] <- NA_real_
    grid <- expand.grid(ParticipantID = h4_study_spec$participants, PhaseID = h4_study_spec$phases, stringsAsFactors = FALSE)
    grid <- grid[order(match(grid$ParticipantID, h4_study_spec$participants), match(grid$PhaseID, h4_study_spec$phases)), ]
    grid$ParticipantPhase <- paste(grid$ParticipantID, grid$PhaseID, sep = "::")
    keys <- paste(raw$ParticipantID, raw$PhaseID, sep = "::")
    if (length(setdiff(grid$ParticipantPhase, keys))) stop("Required participant-phase cells absent: ", paste(setdiff(grid$ParticipantPhase, keys), collapse = ", "))
    if (anyDuplicated(raw[, c("ParticipantID", "PhaseID", "Datetime")])) stop("Duplicate 10-second timestamps in input.")
    groups <- split(seq_len(nrow(raw)), factor(keys, levels = grid$ParticipantPhase))
    variables <- unique(c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m",
        h4_study_spec$all_physiological_outcomes))
    for (v in variables) grid[[v]] <- vapply(groups, function(ix) h4_mean(raw[[v]][ix]), numeric(1))
    coverage <- do.call(rbind, lapply(variables, function(v) {
        n <- vapply(groups, function(ix) sum(is.finite(raw[[v]][ix])), integer(1))
        data.frame(ParticipantID = grid$ParticipantID, PhaseID = grid$PhaseID,
            Measure_Type = if (v %in% h4_study_spec$all_physiological_outcomes) "Outcome" else "Exposure",
            Measure = v, N_valid = n, N_expected = h4_study_spec$expected_epoch_count,
            Coverage_pct = round(100 * n / h4_study_spec$expected_epoch_count, 1),
            Coverage_pass = n > 0L, stringsAsFactors = FALSE)
    }))
    if (any(coverage$Measure_Type == "Exposure" & !coverage$Coverage_pass)) stop("An exposure has no valid phase observations.")
    if (any(lengths(groups) != h4_study_spec$expected_epoch_count))
        warning("Matched-window row counts differ from declared denominator ", h4_study_spec$expected_epoch_count, ": ", paste(names(groups)[lengths(groups) !=
            h4_study_spec$expected_epoch_count], collapse = ", "), call. = FALSE)
    for (v in c("atmo_pm2.5_avg", "ucm_SND_dBA", "lys_lux_avg")) if (any(grid[[v]] < 0, na.rm = TRUE)) stop("Negative phase-mean values require review: ", v)
    if (any(grid$gvi_50m < 0 | grid$gvi_50m > 100, na.rm = TRUE)) stop("GVI outside 0-100%.")
    list(data = grid, coverage = coverage)
}

is_sound_semantic <- function(x) x %in% c("category", SOUND_CATEGORY_PROP_COLUMNS, sub("_proportion$", "_score", setdiff(SOUND_CATEGORY_PROP_COLUMNS, "unidentify_proportion"))) | grepl("^(sound_(proportion|score)_|yamnet_class_[0-9]{3}_.+_(mean_score|proportion)$)", x)

is_acoustic_frequency <- function(x) {
  grepl("^(dominant_frequency|spectral_centroid|spectral_rolloff85)_hz$", x, ignore.case = TRUE) |
    grepl("^freq_proportion_", x) | grepl("^octave_proportion_", x)
}

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
  if(c %in% h4_study_spec$all_physiological_outcomes) return(info("Physiological Sensor Outcomes (Y_physio)",
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
    if(is_sound_semantic(c)||grepl("^freq_proportion_|^octave_proportion_",c)) "proportion / score" else if(c=="SVF") "0-1" else if(grepl("_%$",c)) "%" else "Physical unit"
  info("Environmental Stressor Candidates (X_env)",source,unit,"Retained for Step 2 technical sensor consolidation","RETAINED FOR FILTRATION")
}

# h4_step2_representation
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
  if (grepl("^atmo_lys_atmotube_(left|right)__atmotube_temperature$", col)) return("Raw-source inventory only: UCM ucm_AIR_T_mid is the declared ambient-temperature measure")
  # WEAK: _SR/_S suffix meaning (alternative formulation) not documented locally; verify in UCM manual [CityFeel17].
  if (grepl("^ucm_.*_(SR|S)$", col)) return("Derived alternate UCM formulations (_SR/_S suffix); use the corresponding unsuffixed UCM measure")
  # Derived relation: IR radiometer channels are the inputs used to compute ucm_MRT [CityFeel17]; co-entry duplicates MRT.
  if (grepl("^ucm_IR_", col)) return("Directional IR radiometer channels (inputs used to compute ucm_MRT [CityFeel17]); measured solar exposure representative is ucm_SUN_Gh; not co-entered as separate radiation predictors")
  # Wind representative = apparent wind speed AWS (airflow at the body incl. own movement; convective-cooling exposure; complete in core phases).
  if (col == "ucm_WIND_TWS") return("Derived true-wind speed (device correction from AWS and related fields); wind representative: ucm_WIND_AWS")
  if (col %in% c("ucm_WIND_AWA", "ucm_WIND_TWD")) return("Derived wind direction/angle from ucm_WIND_AWS; wind speed representative is ucm_WIND_AWS. Circular direction coding is outside the current linear wind-speed specification.")
  # AH is a deterministic function of T and RH -> redundant with ucm_AIR_T_mid + ucm_AIR_RH [Zhu24 p.3].
  if (col == "ucm_AH") return("Humidity representative: ucm_AIR_RH; AH is an alternative formulation")
  # Aggregate / alternate height tiers of air temperature; highly collinear [Zhu24 p.3]. Mid-height is the Eq 2 heat term.
  if (col %in% c("ucm_AIR_temp", "ucm_AIR_T_bot", "ucm_AIR_T_top")) return("Air-temperature representative: ucm_AIR_T_mid; alternate height/aggregate channels not co-entered")
  # gvi_50m is the original GVI scale value; other buffers, components (grass/plant/tree) and phase means are derived alternatives.
  if (grepl("^gvi_|^(plant|grass|tree)_phase_mean$", col) && col != "gvi_50m") return("Vegetation representative: gvi_50m; alternative scales/components not co-entered")
  # Annular tree/building view fractions (TVF/BVF) and scene % are components behind SVF [Qiu17 p.1]; SVF is the standard index.
  if (col %in% c("BVF", "TVF")) return("Annular building/tree view fractions; sky openness representative is SVF; not co-entered in core Step-2 screen")
  if (is_svf_exposure(col) && col != "SVF") return("Sky openness represented by SVF; scene percentages are separate secondary constructs, not equivalent exposures")
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
    if (col == "Clearness_Index_Infer") "Derived categorical clearness inference from Clearness_Index; not a continuous numeric exposure; no valid continuous-effect parameterization is declared. The original field remains in the input. Measured solar exposure is ucm_SUN_Gh"
    else "Not a continuous numeric exposure; no valid continuous-effect parameterization is declared. The original field remains in the input."))
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
    if (is.null(raw_df)) raw_df <- h4_read_merged_analysis_data()
    raw_df <- h4_apply_average_sources(raw_df, c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg"))
    prep <- h4_step4_exposure_prep(audit_df, raw_df)
  }
  catalog <- prep$catalog
  # Recompute the proposed designs; never attach historical fitted-model VIFs to new equations.
  outcomes <- h4_study_spec$all_physiological_outcomes
  checks <- if (!is.null(prep$phase_checks)) prep$phase_checks else do.call(rbind, lapply(outcomes, function(y)
    h4_run_gvif_diagnostic(prep, design_outcome = y, write = FALSE)$by_equation))
  gvif_hr <- do.call(rbind, lapply(split(checks, checks$equation_id), function(d)
    data.frame(equation_id = d$equation_id[1], max_vif_equivalent = max(d$max_vif_equivalent),
      min_rows = min(d$n_design_rows), max_rows = max(d$n_design_rows))))
  cat(sprintf("Step 4: %d outcome-equation designs; full rank %d/%d; VIF >= %s: %d; rows %d-%d.\n",
    nrow(checks), sum(checks$full_rank), nrow(checks), h4_study_spec$variance_inflation_factor_limit, sum(checks$max_vif_equivalent >= h4_study_spec$variance_inflation_factor_limit),
    min(checks$n_design_rows), max(checks$n_design_rows)))
  print(gvif_hr[, c("equation_id", "max_vif_equivalent", "min_rows", "max_rows")], row.names = FALSE)
  # Render the current declared fixed effects; headings/comments are not an equation data source.
  lines <- vapply(catalog$equation_id, function(eq_id) {
    labels <- vapply(h4_equation_term_order(eq_id), h4_spell_term, character(1))
    paste0("Eq ", eq_id, ": ", paste(labels, collapse = " + "))
  }, character(1))
  vif_by_eq <- gvif_hr$max_vif_equivalent[match(catalog$equation_id, gvif_hr$equation_id)]
  list(lines = lines, max_vif = vif_by_eq, checks = checks)
}

# Worked example for h4_vif_per_term (design only; the dummy .h4_response does not enter the VIF).
# Two Df = 1 predictors. Regress x1 on x2 and get R^2 = 0.75.
#   car::vif returns VIF = 1/(1-R^2) = 1/0.25 = 4 (a named vector, not a GVIF matrix).
#   Stored: GVIF = 4, Df = 1, GVIF_root = 4^(1/(2*1)) = 2, VIF_equivalent = 4^(1/1) = 4.
#   The returned score is that VIF_equivalent (4), the number compared with the VIF limit.
# PhaseID is one term, Df = 3 (three sum-to-zero columns). If car::vif reports GVIF = 8:
#   GVIF_root = 8^(1/(2*3)) = 8^(1/6) = sqrt(2) ≈ 1.414  (the root car prints)
#   VIF_equivalent = 8^(1/3) = 2 = (GVIF_root)^2         (the score)
# A non-finite or rank-deficient design is left at GVIF = Inf, so the score is Inf.
# Fox & Monette (1992). A single grouped term is defined as GVIF = 1 and car::vif is not called.
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


h4_run_gvif_diagnostic <- function(prep, design_outcome = "empatica_heart_rate", vif_threshold = h4_study_spec$variance_inflation_factor_limit, write = TRUE) {
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
  md_path <- file.path(OUT_DIR, h4_file("H4_gvif_diagnostic.md"))
  md <- c("# H4 design-only GVIF / VIF diagnostic", "", sprintf("Reference complete-case outcome: **%s** (n = %d). Other outcomes use different row sets; see `%s`.", design_outcome, n_rows, h4_file("H4_design_redundancy_by_outcome.csv")),
    "", "## PhaseID vs single continuous predictors", "", "PhaseID enters as **three** sum-to-zero contrasts (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit).",
    "In `car::vif`, that span is one **Df = 3** term with a generalized VIF (GVIF).",
    paste0("- **GVIF^(1/(2*Df))** is what `car::vif` prints for multi-df terms (Fox & Monette 1992; [car::vif](https://rdrr.io/cran/car/man/vif.html))."),
    "- **VIF_equivalent = GVIF^(1/Df)** is the square of that root; we compare **VIF_equivalent** to ", vif_threshold, " for the PhaseID block.",
    "- Continuous **Df = 1** columns use ordinary VIF (= VIF_equivalent). Values above the threshold are **flagged only**; no predictor is dropped.",
    "", "## Equation summaries (heart rate complete cases)", "", "| Eq | Heat form | Block | n | Max VIF-equiv | Worst term | Phase GVIF | Phase VIF-equiv |",
    "|----|-----------|-------|---|---------------|------------|------------|-----------------|",
    with(by_equation, sprintf("| %d | %s | %s | %d | %.3f | %s | %.3f | %.3f |", equation_id, heat_form, block, n_design_rows,
      max_vif_equivalent, worst_grouped_term, phase_GVIF, phase_vif_equivalent)), "", sprintf("Generated UTC: %s", format(Sys.time(), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")))
  csv_path <- file.path(OUT_DIR, h4_file("H4_gvif_diagnostic.csv"))
  if (write) {
    dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
    utils::write.csv(term_df, csv_path, row.names = FALSE, na = "")
    writeLines(md, md_path)
  }
  list(terms = term_df, by_equation = by_equation, paths = c(csv = csv_path, md = md_path))
}


# --- 6. Reports (render flow, audit pdf, write results) ---

h4_archive <- function(paths) {
  paths <- unique(paths[file.exists(paths)])
  if (!length(paths)) return(invisible())
  root <- normalizePath(PROJECT_ROOT, winslash = "/", mustWork = TRUE)
  files <- unique(unlist(lapply(paths, function(path) {
    if (dir.exists(path)) list.files(path, recursive = TRUE, full.names = TRUE, all.files = TRUE, no.. = TRUE) else path
  }), use.names = FALSE))
  files <- files[!file.info(files)$isdir]
  if (!length(files)) return(invisible())
  source <- normalizePath(files, winslash = "/", mustWork = TRUE)
  if (any(!startsWith(source, paste0(root, "/")))) stop("Cannot archive files outside Paper3_Final.")
  archived <- file.path(root, "archive", substring(source, nchar(root) + 2L))
  extension <- tools::file_ext(archived)
  stem <- ifelse(nzchar(extension), substr(archived, 1L, nchar(archived) - nchar(extension) - 1L), archived)
  archived <- paste0(stem, "_", format(Sys.time(), "%Y%m%d_%H%M%S"), ifelse(nzchar(extension), paste0(".", extension), ""))
  if (any(file.exists(archived))) stop("Archive destination already exists; refusing to overwrite.")
  for (i in seq_along(files)) {
    dir.create(dirname(archived[i]), recursive = TRUE, showWarnings = FALSE)
    if (!file.rename(files[i], archived[i])) stop("Could not archive: ", files[i])
  }
  for (path in paths[dir.exists(paths)]) unlink(path, recursive = TRUE)
  cat(sprintf("Archived %d file(s) under %s\n", length(files), file.path(root, "archive")))
}

h4_write_results <- function(audit_df, step5_result) {
  res_obj <- if (!is.null(step5_result$h4)) step5_result$h4 else if (!is.null(step5_result$h4_1)) step5_result$h4_1 else step5_result
  if (is.null(res_obj) || is.null(res_obj$coef) || !nrow(res_obj$coef))
    stop("H4 fitting incomplete; refusing to publish final report")
  if (!identical(unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH))), H4_START_MD5)) stop("Script or input changed; refusing final publication")
  res_dir <- RESULT_DIR
  md <- OUT_DIR; rd <- function(f) read.csv(file.path(md, h4_file(f)), stringsAsFactors = FALSE, check.names = FALSE)
  manifest_path <- file.path(md, h4_file("H4_run_complete.csv"))
  recorded_sources <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV)))
  if (!file.exists(manifest_path)) stop("Missing ", h4_file("H4_run_complete.csv"), "; run Step 5 before publishing")
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
  co$q_note <- ifelse(co$inference_status == "Tested", co$FDR_scope, co$inference_status)
  co$q_note[st$high_ar1_flag[k] %in% TRUE] <- "excluded: unresolved high-AR1 covariance after attempted repair"
  co$q_note[co$low_df_flag %in% TRUE] <- trimws(paste(co$q_note[co$low_df_flag %in% TRUE], "low df (<4); interpret with caution"))
  is_th <- co$term_type %in% c("thermal exposure", "sound exposure")
  heat_table <- co[is_th, ]
  write.csv(heat_table, file.path(res_dir, h4_file("H4_Heat_Noise_Exposures.csv")), row.names = FALSE, na = "NA")
  write.csv(co[!is_th, ], file.path(res_dir, h4_file("H4_Covariates_and_Phases.csv")), row.names = FALSE, na = "NA")
  }
  th <- if (nrow(co)) unique(co[co$term_type == "thermal exposure" & !grepl(":", co$term), c("term", "equation")]) else data.frame()
  cov <- if (nrow(co)) unique(co$term[co$term_type == "covariate"]) else character()
  role <- vapply(audit_df$Variable_Name, function(v) {
    if (v %in% h4_study_spec$all_physiological_outcomes) return("H4.1 physiological sensor outcome (10 s time series)")
    if (nrow(th) && v %in% th$term) return(paste0("heat term in Eq '", paste(th$equation[th$term == v], collapse = "', '"), "' (+ x sound)"))
    if (v %in% "ucm_SND_dBA") return("sound main-effect test; see equation-specific results")
    if (v %in% cov) return(paste("adjustment term in:", paste(unique(co$equation[co$term == v]), collapse = "; ")))
    "not used" }, character(1))
  keep <- c("Variable_Name", "Platform_Source", "Native_Unit", "Scientific_Domain", "Step1_Decision", "Step2_Rule", "Step2_Decision",
            "Step3_Decision", "Scientific_Filtration_Rationale", "Step4_Domain", "Step4_Category_Role", "Step4_Decision", "Step4_Restriction")
  write.csv(cbind(audit_df[, keep], Step5_Role = role), file.path(res_dir, h4_file("H4_Variable_Selection.csv")), row.names = FALSE, na = "")
  ex <- audit_df[audit_df$Step1_Decision == "Retained" & audit_df$Step2_Decision != "Retained", ]
  ex_tab <- aggregate(Variable_Name ~ Scientific_Filtration_Rationale, ex, function(x) paste(x, collapse = ", "))
  n_tab <- if (nrow(st)) unique(st[, c("outcome", "n", "n_participants")][st$equation_id == 1, ]) else data.frame()
  h41_md <- c("## Physiological sensor models (10-second time series)",
    "Outcomes: 26 empatica + eyetracker columns (see h4_study_spec$physiological_outcome_names). Nested (1 | ParticipantID / PhaseID) with AR(1) within bout.",
    if (nrow(n_tab)) sprintf("Sample sizes (Eq 1): see %s and %d-%d rows per outcome.", h4_file("H4_hypothesis_readme.txt"), min(n_tab$n), max(n_tab$n)) else "")
  rep_md <- c("# H4 results report", "", h41_md, "",
    "## Files",
    sprintf("- %s / %s: H4.1 only", h4_file("H4_Heat_Noise_Exposures.csv"), h4_file("H4_Covariates_and_Phases.csv")),
    sprintf("- %s, %s; working fits in results/%s/", h4_file("H4_Variable_Selection.csv"), h4_file("H4_Selection_Flow.pdf"), basename(RESULT_DIR)), "",
    if (file.exists(file.path(md, h4_file("H4_hypothesis_readme.txt")))) readLines(file.path(md, h4_file("H4_hypothesis_readme.txt"))) else character(),
    if (file.exists(file.path(md, h4_file("H4_gvif_diagnostic.md")))) c("", readLines(file.path(md, h4_file("H4_gvif_diagnostic.md")))) else character())
  writeLines(rep_md, file.path(res_dir, h4_file("H4_Report.md")))
  f <- file.path(res_dir, h4_file(c("H4_Report.md", "H4_Selection_Flow.pdf", "H4_Variable_Selection.csv")))
  for (nm in h4_file(c("H4_Covariates_and_Phases.csv", "H4_Heat_Noise_Exposures.csv")))
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
  write.csv(completed, file.path(md, h4_file("H4_run_complete.csv")), row.names = FALSE)
  cat("[Results] Wrote", length(f), "files to", res_dir, "\n")
}

render_h4_faceted_flow <- function(audit_all = NULL, prep = NULL) {
  PDF_PATH <- file.path(RESULT_DIR, h4_file("H4_Selection_Flow.pdf"))
  library(grid)
  # Font size in points for every label on this page.
  FONT_SIZE <- 15
  LH <- function(fs) ceiling(fs * 1.2)   # tight line height (px) for a font size
  if (is.null(audit_all)) audit_all <- read.csv(OUT_CSV, stringsAsFactors = FALSE)
  raw <- h4_read_merged_analysis_data()
  raw <- h4_apply_average_sources(raw, missing_only = FALSE)
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
    c("^spectral_rolloff85_hz$", "spectral rolloff 85% (Hz)"), c("^freq_proportion_([0-9]+)_to_([0-9]+)Hz$", "band proportion \\1-\\2 Hz"),
    c("^octave_proportion_([0-9.]+)Hz$", "octave proportion \\1 Hz"), c("([0-9]+)\\.0 Hz$", "\\1 Hz"),
    c("(?i)^log_lys_", "log "), c("(?i)^ucm_", ""), c("(?i)^atmo_", ""), c("(?i)^lys_", ""), c("(?i)^gvi_", "GVI "),
    c("(?i)^tree_", "Tree "), c("(?i)^grass_", "Grass "), c("(?i)^plant_", "Plant "),
    c("^lys_atmotube_(left|right)__atmotube_", "\\1 "), c("^lys_LYS([12])__lys_", "LYS\\1 "),
    c("^(empatica|eyetracker|questionnaire)_", ""), c("(?i)_avg$", " avg"))
  column_label <- audit$Variable_Name
  for (r in seq_len(nrow(label_rules))) column_label <- sub(label_rules[r, 1], label_rules[r, 2], column_label, perl = TRUE)
  audit$Sensor <- sensor
  audit$Column <- trimws(gsub("_", " ", column_label))
  audit$Column <- sub("^background ", "", audit$Column)
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
  ingredient_names <- unique(unlist(average_sources[intersect(names(average_sources), candidate_names)], use.names = FALSE))
  audit$Display_Priority <- ifelse(audit$Variable_Name %in% candidate_names, 0L,
    ifelse(audit$Variable_Name %in% ingredient_names, 1L, 2L))
  audit <- audit[order(match(audit$Sensor, sensor_order), audit$Display_Priority, audit$Column), ]
  audit$Slot <- ave(seq_len(nrow(audit)), audit$Sensor, FUN = seq_along)
  audit$Subcolumn <- (audit$Slot - 1L) %/% 14L
  audit$Row <- (audit$Slot - 1L) %% 14L
  ncolumns <- sapply(sensor_order, function(s) max(c(0L, audit$Subcolumn[audit$Sensor == s])) + 1L)
  physio <- h4_study_spec$all_physiological_outcomes
  stopifnot(all(physio %in% audit$Variable_Name), setequal(intersect(physio, h4_study_spec$natural_log_outcome_names), h4_study_spec$natural_log_outcome_names))
  shown <- audit$Column[match(physio, audit$Variable_Name)]
  physio_label <- ifelse(physio %in% h4_study_spec$natural_log_outcome_names, paste0("log(", shown, ")"), shown)
  longest_label <- audit$Column
  is_selected <- audit$Variable_Name %in% candidate_names
  longest_label[is_selected] <- paste0(longest_label[is_selected], " [", audit$Measurement_Code[is_selected], "]")
  longest_label[match(physio, audit$Variable_Name)] <- physio_label
  grDevices::pdf(file = NULL, pointsize = FONT_SIZE, family = "Helvetica")
  label_width <- strwidth(longest_label, units = "inches")
  dev.off()
  all_titles <- c("Inventory (000)", "Representatives (000)", "Domain Grouping (000)", "Equations + design VIF", "(6 equations)")
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
    paste0("STEP 2\nDomain Grouping (", nrow(stages[[3]]), ")"))
  max_rows <- vapply(stages, function(d) as.integer(max(c(1L, d$Row + 1L))), integer(1))
  max_rows[-1] <- vapply(stages[-1], function(d) as.integer(max(c(1L, table(interaction(d$Sensor, d$Subcolumn, drop = TRUE))))), integer(1))
  row_px <- c(LH(FONT_SIZE), LH(FONT_SIZE), LH(FONT_SIZE))
  title_px <- vapply(titles, function(t) length(strsplit(t, "\n")[[1]]) * LH(FONT_SIZE), numeric(1))
  display_domains <- H4_DOMAINS[H4_FLOW_DOMAIN_ORDER]
  n3 <- max(lengths(lapply(display_domains, intersect, candidate_names))) + 1L
  content_px <- c(max_rows[1] * row_px[1], max_rows[2] * row_px[2], LH(FONT_SIZE) + n3 * LH(FONT_SIZE))
  band_height <- pmax(title_px, content_px) + 20
  band_height[2L] <- 0
  step5 <- h4_step4_equation_lines(audit_all, raw, prep = prep)
  n_eq <- length(step5$lines)
  equation_rows <- lengths(strsplit(step5$lines, "\n", fixed = TRUE))
  step5_height <- max(3 * LH(FONT_SIZE), sum(equation_rows) * LH(FONT_SIZE) + n_eq * 5) + 14
  note_lines <- character()
  note_bold <- logical()
  explained <- character()
  add_note <- function(text, bold = FALSE) {
    wrapped <- strwrap(text, width = 360L)
    note_lines <<- c(note_lines, wrapped)
    note_bold <<- c(note_bold, rep(bold, length(wrapped)))
  }
  for (source_index in seq_along(sensor_order)) {
    group <- audit[audit$Sensor == sensor_order[source_index], ]
    if (!nrow(group)) next
    add_note(paste0(source_index, ". ", sensor_order[source_index]), TRUE)
    chosen <- group$Variable_Name %in% candidate_names
    ingredients <- group$Variable_Name %in% ingredient_names
    if (any(chosen)) add_note(paste0("- Retained: ", paste(group$Column[chosen], collapse = ", "), "."))
    if (any(ingredients)) add_note(paste0("- Inputs to retained averages: ", paste(group$Column[ingredients], collapse = ", "),
      ". Highlighted as source measurements; not entered alongside their averages."))
    omitted <- group[!chosen & !ingredients, ]
    if (!nrow(omitted)) next
    reason <- omitted$Scientific_Filtration_Rationale
    reason[is.na(reason) | reason == "" | reason == "-"] <- omitted$Step2_Status[is.na(reason) | reason == "" | reason == "-"]
    reason[is_acoustic_frequency(omitted$Variable_Name)] <- "Not in the H4 equations; spectral information is distinct from sound level."
    reason[is_sound_semantic(omitted$Variable_Name)] <- "Not in the H4 equations; sound type is distinct from sound level."
    reason[omitted$Variable_Name %in% h4_study_spec$all_physiological_outcomes] <- "Used as a physiological or ocular response, not an environmental predictor."
    reason[omitted$Variable_Name == "Clearness_Index"] <- "Derived clearness index (kt = Gh/G0); measured solar exposure is ucm_SUN_Gh [ClearCI p.3 eq.2]"
    for (why in unique(reason)) {
      rows <- which(reason == why)
      add_note(paste0("- ", paste(omitted$Column[rows], collapse = ", "), ": ", why))
      explained <- c(explained, omitted$Variable_Name[rows])
    }
  }
  stopifnot(!anyDuplicated(explained),
    setequal(explained, setdiff(audit$Variable_Name, c(candidate_names, ingredient_names))))
  notes_height <- (length(note_lines) + 2L) * LH(FONT_SIZE) + 20
  band_height[2L] <- notes_height
  head_px <- 8 + LH(FONT_SIZE) + 2 * LH(FONT_SIZE) + 6
  page_height <- head_px + sum(band_height) + step5_height + 6
  band_top <- page_height - head_px - c(0, head(cumsum(band_height), -1))
  text_at <- function(x, y, label, size = 18, bold = FALSE, color = "#222222")
    grid.text(label, x = x, y = y, just = c("left", "top"), gp = gpar(fontsize = size, fontface = if (bold) "bold" else "plain", col = color))
  grDevices::cairo_pdf(PDF_PATH, width = page_width, height = page_height / 72, onefile = TRUE)
  grid.newpage()
  text_at(.06 / page_width, 1 - 8 / page_height, paste("H4", basename(RESULT_DIR), "environmental-variable selection"), FONT_SIZE, TRUE)
  pending_svf <- sum(audit$Step2_Status == "PENDING SVF PROCESSING / MERGE")
  for (s in seq_along(sensor_order)) {
    heading <- sub(" (raw|average|imagery)$", "\n\\1", sensor_order[s])
    text_at(lefts[s] + .06 / page_width, 1 - (8 + LH(FONT_SIZE) + 4) / page_height, heading, FONT_SIZE, TRUE)
  }
  for (k in c(1L, 3L)) {
    d <- stages[[k]]
    if (k >= 2L && nrow(d) > 0L) d$Row <- ave(seq_len(nrow(d)), interaction(d$Sensor, d$Subcolumn), FUN = function(x) seq_along(x) - 1L)
    grid.text(titles[k], x = .06 / page_width, y = (band_top[k] - 6) / page_height,
      just = c("left", "top"), gp = gpar(fontsize = FONT_SIZE, fontface = "bold", col = "#222222", lineheight = 1.2))
    if (k == 2L && pending_svf > 0L) text_at(lefts[match("SVF imagery", sensor_order)] + .12 / page_width, band_top[k] / page_height,
      "SVF", FONT_SIZE)
    if (k == 3L) {
      category_left <- title_w / page_width
      for (g in seq_along(display_domains)) {
        domain <- names(display_domains)[g]
        category_x <- category_left
        variables <- intersect(display_domains[[g]], candidate_names)
        labels <- audit$Column[match(variables, audit$Variable_Name)]
        y_b <- band_top[k] - 6
        heading <- domain
        text_at(category_x, y_b / page_height, heading, FONT_SIZE, TRUE)
        for (j in seq_along(labels)) text_at(category_x, (y_b - LH(FONT_SIZE) - LH(FONT_SIZE) * (j - 1L)) / page_height, labels[j], FONT_SIZE)
        if (domain == "Radiation" && pending_svf > 0L) text_at(category_x,
          (y_b - LH(FONT_SIZE) - LH(FONT_SIZE) * length(labels)) / page_height, "SVF", FONT_SIZE)
        category_left <- category_x + max(convertWidth(grobWidth(textGrob(c(heading, labels), gp = gpar(fontsize = FONT_SIZE))), "npc", TRUE)) + 1.2 / page_width
      }
    } else for (j in seq_len(nrow(d))) {
      label <- d$Column[j]
      if (k >= 2L && d$Variable_Name[j] %in% h4_study_spec$natural_log_outcome_names) label <- paste0("log(", label, ")")
      if (k == 3L) label <- paste0(label, " [", d$Measurement_Code[j], "]")
      label_y <- (band_top[k] - 6 - d$Row[j] * row_px[k]) / page_height
      retained <- k == 1L && d$Variable_Name[j] %in% c(candidate_names, ingredient_names)
      if (retained) {
        label_width <- convertWidth(grobWidth(textGrob(label, gp = gpar(fontsize = FONT_SIZE))), "npc", TRUE)
        grid.rect(x = d$X[j], y = label_y, width = label_width + 4 / 72 / page_width,
          height = LH(FONT_SIZE) / page_height, just = c("left", "top"),
          gp = gpar(fill = "#FFF2CC", col = NA))
      }
      text_at(d$X[j], label_y, label, FONT_SIZE)
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
    vif_x <- x0 + width_npc(unlist(strsplit(lines, "\n", fixed = TRUE)), FONT_SIZE) + .6 / page_width
    for (j in seq_along(lines)) {
      text_at(vif_x, y / page_height, vif_lab[j], FONT_SIZE)
      for (line in strsplit(lines[j], "\n", fixed = TRUE)[[1L]]) {
        text_at(x0, y / page_height, line, FONT_SIZE)
        y <- y - LH(FONT_SIZE)
      }
      y <- y - 5
    }
  }
  draw_step_block(paste0("STEP 3\nEquations + design VIF\n(6 equations)"), step5$lines, step5_height + 3)
  notes_top <- band_top[2L]
  text_at(x0, (notes_top - 10) / page_height, "Parameters and decisions by source", FONT_SIZE, TRUE)
  for (j in seq_along(note_lines))
    text_at(x0, (notes_top - 10 - j * LH(FONT_SIZE)) / page_height, note_lines[j], FONT_SIZE, note_bold[j])
  grid.lines(x = c(.06 / page_width, .985), y = rep((band_top[3L] + 8) / page_height, 2L), gp = gpar(col = "#222222"))
  dev.off()
  # Refresh only the figure hash and label its scope; fitted tables still identify their original run.
  manifest_path <- file.path(OUT_DIR, h4_file("H4_run_complete.csv"))
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
    audit_df <- collapse_group(audit_df, grepl("^octave_proportion_", audit_df$Variable_Name), "Octave Frequency Bands")
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


# ==============================================================================
# STEP 4-5 CORE ENGINE: EXPOSURES, CONTRASTS, FITTER & SENSITIVITIES
# ==============================================================================

h4_phase_design <- function(phase) {
  phase <- factor(as.character(phase), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  if (anyNA(phase)) stop("Unknown or missing H4 PhaseID")
  design <- stats::model.matrix(~ phase, contrasts.arg = list(phase = stats::contr.sum(4L)))[, -1L, drop = FALSE]
  colnames(design) <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
  design
}

h4_phase_contrast_weights <- function() {
  # Equal weighting of the two modes/environments, not observed row frequencies.
  w <- rbind(Urban_minus_Green = c(-.5, .5, -.5, .5), Urban_minus_Green_Walk = c(-1, 1, 0, 0), Urban_minus_Green_Bike = c(0, 0, -1, 1),
             Bike_minus_Walk = c(-.5, -.5, .5, .5), Mode_by_Environment = c(1, -1, -1, 1))
  w %*% h4_phase_design(c("WalkG", "WalkU", "BikeG", "BikeU"))
}

h4_phase_contrasts <- function(fit, cluster) {
  beta <- nlme::fixef(fit)
  weights <- h4_phase_contrast_weights()
  V <- clubSandwich::vcovCR(fit, cluster = cluster, type = "CR2")
  do.call(rbind, lapply(seq_len(nrow(weights)), function(i) {
    L <- matrix(0, 1L, length(beta), dimnames = list(NULL, names(beta)))
    stopifnot(all(colnames(weights) %in% names(beta)))
    L[1L, colnames(weights)] <- weights[i, ]
    test <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
    estimate <- as.numeric(L %*% beta)
    se <- sqrt(as.numeric(L %*% V %*% t(L)))
    df <- as.numeric(test$df_denom)
    if (!is.finite(df) || df <= 0 || !is.finite(se)) stop("Invalid phase-contrast CR2 inference")
    data.frame(contrast = rownames(weights)[i], estimate = estimate, se = se, df = df, low_df_flag = df < 4,
               ci_low = estimate - stats::qt(.975, df) * se, ci_high = estimate + stats::qt(.975, df) * se, p_value = as.numeric(test$p_val), stringsAsFactors = FALSE)
  }))
}

h4_phase_mean_init_coefficient_frame <- function(equation_id, outcome, design_columns, has_phase, fixed_term_labels) {
  terms_out <- c(ifelse(design_columns == "(Intercept)", "Intercept", design_columns), if (has_phase) "PhaseSumBikeU")
  heat_predictors <- intersect(fixed_term_labels, c("ucm_UTCI", "ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_MRT", "ucm_HUMIDEX", "ucm_PET"))
  term_type <- ifelse(terms_out == "Intercept", "intercept",
    ifelse(startsWith(terms_out, "PhaseSum"), "phase (study design)",
      ifelse(terms_out %in% "ucm_SND_dBA", "sound exposure",
        ifelse(terms_out %in% heat_predictors | grepl(":", terms_out, fixed = TRUE), "thermal exposure", "covariate"))))
  data.frame(equation_id = equation_id, equation = h4_equation_thermal_label(h4_equation_table[equation_id, ]),
    outcome = outcome, term = terms_out, term_type = term_type,
    Beta = NA_real_, SE = NA_real_, df = NA_real_, ci_low = NA_real_, ci_high = NA_real_, p = NA_real_, stringsAsFactors = FALSE)
}

h4_phase_mean_results <- function(equation_id, outcome, fixed, phase, design, fit, note) {
  # Keep historical coefficient labels, classifications and reporting consumers stable.
  columns <- gsub("_phase_z", "", colnames(design), fixed = TRUE)
  full_rank <- qr(design)$rank == ncol(design)
  has_phase <- all(H4_PHASE_SUM_COLS %in% columns)
  fixed_labels <- gsub("_phase_z", "", attr(terms(fixed), "term.labels"), fixed = TRUE)
  result <- h4_phase_mean_init_coefficient_frame(equation_id, outcome, columns, has_phase, fixed_labels)
  success <- FALSE
  boundary <- NA
  phase_comparisons <- NULL
  if (!is.null(fit)) {
    robust <- tryCatch(withCallingHandlers(
      clubSandwich::coef_test(fit, vcov = "CR2", cluster = phase$ParticipantID, test = "Satterthwaite"),
      warning = function(w) note <<- c(note, conditionMessage(w)),
      error = function(e) { note <<- c(note, paste("CR2:", conditionMessage(e))); NULL }))
    if (!is.null(robust)) {
      index <- match(ifelse(result$term == "Intercept", "(Intercept)", result$term), gsub("_phase_z", "", rownames(robust), fixed = TRUE))
      result$Beta <- robust$beta[index]
      result$SE <- robust$SE[index]
      result$df <- robust$df_Satt[index]
      result$p <- 2 * pt(-abs(result$Beta / result$SE), result$df)
      result$ci_low <- result$Beta - qt(.975, result$df) * result$SE
      result$ci_high <- result$Beta + qt(.975, result$df) * result$SE
      success <- all(is.finite(robust$beta))
      if (has_phase) tryCatch({
        variance <- clubSandwich::vcovCR(fit, cluster = phase$ParticipantID, type = "CR2")
        weights <- matrix(0, 1L, length(nlme::fixef(fit)), dimnames = list(NULL, names(nlme::fixef(fit))))
        weights[1L, c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")] <- -1
        test <- clubSandwich::Wald_test(fit, constraints = weights, vcov = variance, test = "HTZ")
        row <- which(result$term == "PhaseSumBikeU")
        result$Beta[row] <- as.numeric(weights %*% nlme::fixef(fit))
        result$SE[row] <- sqrt(as.numeric(weights %*% variance %*% t(weights)))
        result$df[row] <- as.numeric(test$df_denom)
        result$p[row] <- as.numeric(test$p_val)
        result$ci_low[row] <- result$Beta[row] - qt(.975, result$df[row]) * result$SE[row]
        result$ci_high[row] <- result$Beta[row] + qt(.975, result$df[row]) * result$SE[row]
      }, error = function(e) note <<- c(note, paste("BikeU contrast:", conditionMessage(e))))
      boundary <- as.numeric(nlme::VarCorr(fit)[1L, "Variance"]) < 1e-6 * sigma(fit)^2
      if (has_phase) phase_comparisons <- tryCatch(h4_phase_contrasts(fit, phase$ParticipantID),
        error = function(e) { note <<- c(note, paste("Phase contrasts:", conditionMessage(e))); NULL })
    }
  }
  result$low_df_flag <- is.finite(result$df) & result$df < 4
  result$transformation <- if (outcome %in% h4_study_spec$natural_log_outcome_names) "natural log before phase averaging" else "native"
  result$n <- nrow(phase)
  result$n_participants <- nlevels(phase$ParticipantID)
  status <- data.frame(equation_id = equation_id, outcome = outcome, success = success,
    n = nrow(phase), n_participants = nlevels(phase$ParticipantID),
    min_epochs_per_phase = if (nrow(phase)) min(phase$epochs) else 0,
    max_epochs_per_phase = if (nrow(phase)) max(phase$epochs) else 0,
    coefficients = ncol(design), full_rank = full_rank, boundary_variance = boundary,
    condition_index = kappa(design, exact = TRUE),
    note = if (length(note)) paste(unique(note), collapse = "; ") else "Completed")
  if (!is.null(phase_comparisons)) {
    phase_comparisons$equation_id <- equation_id
    phase_comparisons$outcome <- outcome
  }
  coverage <- phase[, c("ParticipantID", "PhaseID", "epochs")]
  coverage$equation_id <- equation_id
  coverage$outcome <- outcome
  list(coefficients = result, status = status, contrasts = phase_comparisons, coverage = coverage)
}

h4_step4_exposure_prep <- function(audit_df, raw_df) {
  raw_df <- h4_apply_average_sources(raw_df, c("lys_lux_avg", "lys_kelvin_avg", "lys_medi_avg"))
  raw_df <- raw_df[raw_df$ParticipantID %in% h4_study_spec$participants & raw_df$PhaseID %in% h4_study_spec$phases, , drop = FALSE]
  if (!"empatica_hrv_fd_5min_available" %in% names(raw_df)) stop("Missing HRV availability flag")
  available <- tolower(as.character(raw_df$empatica_hrv_fd_5min_available)) %in% c("true", "1")
  for (v in h4_study_spec$empatica_hrv_fd_window_outcomes) raw_df[[v]][!available] <- NA_real_
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
  base_heat <- list(`AIR_T_mid + AIR_RH + WIND_AWS` = c("ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_WIND_AWS"), HUMIDEX = "ucm_HUMIDEX", PET = "ucm_PET", UTCI = "ucm_UTCI")
  pm <- intersect(H4_DOMAINS$Pollution, reps)
  if (length(pm) != 3L || !all(c("ucm_MRT", "ucm_SND_dBA") %in% reps)) stop("Step 4 requires three PM alternatives, MRT and sound")
  # h4_equation_table is the six-row table in the specification block (same ids, heat keys, PM, roles).
  # UTCI + PM2.5 is the pre-specified primary.
  # Heat-form sensitivities stay on PM2.5. PM1 and PM10 are size sensitivities on UTCI only.
  # MRT Ã— SND_dBA is Eq 2 only (multi-component air/RH/wind heat form).
  stopifnot(nrow(h4_equation_table) == 6L, identical(h4_equation_table$equation_number, 1:6),
            all(h4_equation_table$heat_predictor_label %in% names(base_heat)), all(h4_equation_table$particulate_matter_column %in% pm),
            sum(h4_equation_table$equation_role == "primary") == 1L, !any(h4_equation_table$equation_role == "sound_sensitivity"))
  thermal <- list()
  for (i in seq_len(nrow(h4_equation_table))) {
    vars <- base_heat[[h4_equation_table$heat_predictor_label[i]]]
    attr(vars, "pm") <- h4_equation_table$particulate_matter_column[i]
    thermal[[h4_equation_thermal_label(h4_equation_table[i, , drop = FALSE])]] <- vars
  }
  selected <- unique(c(nonthermal, unlist(thermal, use.names = FALSE)))
  h4_prepare_bout_design(raw_df, selected, nonthermal, thermal, rep_tab)
}

h4_equation_catalog <- function(nonthermal, thermal, h4_equation_table) {
  stopifnot(nrow(h4_equation_table) == 6L, length(thermal) == 6L)
  for (i in seq_len(nrow(h4_equation_table))) {
    stopifnot(identical(names(thermal)[i], h4_equation_thermal_label(h4_equation_table[i, , drop = FALSE])))
  }
  out <- do.call(rbind, lapply(seq_len(nrow(h4_equation_table)), function(id) {
    vars <- thermal[[id]]
    data.frame(equation_id = h4_equation_table$equation_number[id], heat_form = names(thermal)[id],
      pm_representation = attr(vars, "pm"), role = h4_equation_table$equation_role[id],
      primary = h4_equation_table$equation_role[id] == "primary", block = "heat_x_sound", test = "Noise",
      terms = paste(vapply(if (exists("H4_EQUATION_FIXED", envir = .GlobalEnv, inherits = FALSE)) {
        h4_equation_term_order(h4_equation_table$equation_number[id])
      } else {
        heat_ix <- paste0(vars, ":ucm_SND_dBA")
        ix_fallback <- if (length(vars) > 1L) c(heat_ix, "ucm_MRT:ucm_SND_dBA") else heat_ix
        h4_order_terms_by_flow_domain(c(
          setdiff(nonthermal, setdiff(H4_DOMAINS$Pollution, attr(vars, "pm"))), vars, H4_PHASE_SUM_COLS,
          ix_fallback
        ), heat_vars = vars)
      }, h4_spell_term, character(1)), collapse = " + "),
      heat_role = if (length(vars) > 1L) "Air temperature + RH + apparent wind" else paste(h4_equation_table$heat_predictor_label[id], "only"),
      fitted = FALSE, stringsAsFactors = FALSE)
  }))
  stopifnot(nrow(out) == 6L, identical(out$equation_id, 1:6), sum(out$primary) == 1L, out$primary[1],
            out$role[1] == "primary", !any(out$role == "sound_sensitivity"), !anyDuplicated(out$terms),
            out$pm_representation[1:4] == "atmo_pm2.5_avg",
            out$pm_representation[5:6] == c("atmo_pm1_avg", "atmo_pm10_avg"))
  out$analysis_role <- ifelse(out$primary, "pre-specified primary (UTCI + PM2.5)",
    ifelse(out$role == "heat_sensitivity", "heat-form sensitivity (PM2.5)", "PM size sensitivity (UTCI heat form)"))
  out
}

# --- H4.1: REML fit, CR2 inference, Benjamini-Hochberg FDR ---
# --- 5. H4.1 fit and FDR ---

h4_env_int <- function(name, default = NA_integer_) {
  raw <- Sys.getenv(name, unset = "")
  if (!nzchar(raw)) return(default)
  v <- suppressWarnings(as.integer(raw))
  if (is.na(v)) stop("Environment variable ", name, " must be an integer, got: ", raw, call. = FALSE)
  v
}

# Slice Step 5 jobs (1-based indices into the 26×6 queue). H4_JOB_END or H4_MAX_JOBS optional.
h4_step5_job_slice <- function(jobs) {
  n <- length(jobs)
  start <- h4_env_int("H4_JOB_START", 1L)
  end <- h4_env_int("H4_JOB_END", NA_integer_)
  max_jobs <- h4_env_int("H4_MAX_JOBS", NA_integer_)
  if (is.na(end) && !is.na(max_jobs)) end <- start + max_jobs - 1L
  if (is.na(end)) end <- n
  start <- max(1L, min(start, n))
  end <- max(start, min(end, n))
  list(
    jobs = jobs[start:end],
    indices = seq.int(start, end),
    start = start,
    end = end,
    total = n
  )
}

h4_step5_load_records <- function(path, n_jobs) {
  empty <- vector("list", n_jobs)
  if (!file.exists(path)) return(empty)
  x <- tryCatch(readRDS(path), error = function(e) NULL)
  if (is.null(x)) return(empty)
  if (is.list(x) && identical(x$format, "step5_checkpoint") && is.list(x$records)) {
    rec <- x$records
    if (length(rec) == n_jobs) return(rec)
    if (length(rec) < n_jobs) return(c(rec, vector("list", n_jobs - length(rec))))
    return(rec[seq_len(n_jobs)])
  }
  if (is.list(x) && length(x) == n_jobs && !is.null(x[[1L]]) && is.list(x[[1L]]) && "status" %in% names(x[[1L]])) {
    return(x)
  }
  empty
}

h4_step5_write_checkpoint <- function(records, fingerprints, h4_model_dir) {
  path <- file.path(h4_model_dir, h4_file("H4_fit_records.rds"))
  payload <- list(
    format = "step5_checkpoint",
    records = records,
    fingerprints = fingerprints,
    updated_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ")
  )
  saveRDS(payload, path, version = 2L)
  status_parts <- lapply(records, function(r) if (is.null(r)) NULL else r$status)
  status_parts <- Filter(Negate(is.null), status_parts)
  if (length(status_parts)) {
    status_df <- do.call(rbind, status_parts)
    utils::write.csv(status_df, file.path(h4_model_dir, h4_file("H4_fit_status.csv")),
      row.names = FALSE, na = "NA")
  }
  n_done <- sum(!vapply(records, is.null, logical(1L)))
  cat(sprintf("[Step 5 checkpoint] %d/%d jobs saved -> %s\n", n_done, length(records), path))
  invisible(n_done)
}

h4_complete_rows <- function(raw_df, outcome, equation_id, natural_log_outcomes = h4_study_spec$natural_log_outcome_names) {
  predictors <- unique(unlist(strsplit(h4_equation_term_order(equation_id), ":", fixed = TRUE)))
  predictors <- setdiff(predictors, H4_PHASE_SUM_COLS)
  values <- as.matrix(raw_df[, c(predictors, outcome), drop = FALSE])
  storage.mode(values) <- "double"
  ok <- rowSums(!is.finite(values)) == 0L
  if (outcome %in% natural_log_outcomes) ok <- ok & raw_df[[outcome]] > 0
  ok
}

h4_fit_begin <- function(audit_df = NULL, raw_df = NULL) {
  suppressPackageStartupMessages({
    library(nlme)
    library(clubSandwich)
    library(parallel)
  })
  if (is.null(audit_df)) {
    if (!file.exists(OUT_CSV)) stop("Audit results CSV not found: ", OUT_CSV)
    audit_df <- read.csv(OUT_CSV, check.names = FALSE)
  }
  if (is.null(raw_df)) {
    raw_df <- h4_read_merged_analysis_data()
    # Rebuild the averaged sensor columns (Atmotube PM, LYS) that are not stored in the raw CSV.
    raw_df <- h4_apply_average_sources(raw_df)
  }
  h4_model_dir <- OUT_DIR
  dir.create(h4_model_dir, recursive = TRUE, showWarnings = FALSE)
  job_start_env <- h4_env_int("H4_JOB_START", 1L)
  continue_checkpoint <- job_start_env > 1L || identical(Sys.getenv("H4_APPEND_BATCH", unset = ""), "1")
  if (!continue_checkpoint) {
  old_items <- list.files(h4_model_dir, pattern = paste0("^", H4_FILE_PREFIX, "_(coefficients|covariance_sensitivity|design_redundancy_by_outcome|equations|fit_records|fit_status|gvif_diagnostic|hypothesis|phase_contrasts|run_complete|session_info|lag60_sensitivity)"))
  h4_archive(file.path(h4_model_dir, old_items))
  } else {
    cat(sprintf("[Step 5] Continuing checkpoint (H4_JOB_START=%d or H4_APPEND_BATCH=1); fit_records/fit_status not archived.\n", job_start_env))
  }
  spec_rds <- tempfile(fileext = ".rds")
  saveRDS(h4_study_spec, spec_rds, version = 2L, compress = FALSE)
  # spec_md5 hashes the declared analysis specification, so it changes only when the spec changes.
  fingerprints <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV, spec_rds)))
  if (!identical(fingerprints[1:2], H4_START_MD5)) stop("Script or input changed since startup; no models run from inconsistent sources")
  names(fingerprints) <- c("code_md5", "input_md5", "audit_md5", "spec_md5")
  unlink(spec_rds)
  list(audit_df = audit_df, raw_df = raw_df, h4_model_dir = h4_model_dir, fingerprints = fingerprints)
}

h4_fit_queue <- function(fit_one_outcome, prep, preflight_df, fingerprints, h4_model_dir, outcomes, fit_equation_ids) {
  catalog <- prep$catalog
  nonthermal <- prep$nonthermal
  agreed_common <- prep$agreed_common
  raw_df <- prep$raw_df
  cat(sprintf("[Step 5] Fitting %d equations across %d outcomes in parallel...\n", length(fit_equation_ids), length(outcomes)))
  jobs <- unlist(lapply(outcomes, function(y) lapply(fit_equation_ids, function(eid) list(outcome = y, equation_id = eid))), recursive = FALSE)
  stopifnot(length(jobs) == length(outcomes) * length(fit_equation_ids))
  slice <- h4_step5_job_slice(jobs)
  ck_path <- file.path(h4_model_dir, h4_file("H4_fit_records.rds"))
  records <- h4_step5_load_records(ck_path, length(jobs))
  publish_only <- identical(Sys.getenv("H4_PUBLISH_ONLY", unset = ""), "1")
  if (publish_only && file.exists(ck_path)) {
    xck <- tryCatch(readRDS(ck_path), error = function(e) NULL)
    if (!is.null(xck$fingerprints)) {
      fingerprints <- xck$fingerprints
      cat("[Step 5] H4_PUBLISH_ONLY=1: using fingerprints stored in fit_records checkpoint.\n")
    }
  }
  n_done_pre <- sum(!vapply(records, is.null, logical(1L)))
  if (publish_only && n_done_pre < length(jobs)) {
    stop(sprintf("H4_PUBLISH_ONLY=1 but checkpoint has only %d/%d jobs.", n_done_pre, length(jobs)), call. = FALSE)
  }
  cat(sprintf("[Step 5] Job queue: %d total; this run jobs %d-%d (%d jobs).\n",
              slice$total, slice$start, slice$end, length(slice$jobs)))
  # Default serial (1 worker); parallel only when H4_PARALLEL_WORKERS>1 explicitly set.
  workers_env <- suppressWarnings(as.integer(Sys.getenv("H4_PARALLEL_WORKERS", "")))
  workers_default <- 1L
  workers <- if (!is.na(workers_env) && workers_env >= 1L) {
    min(workers_env, length(slice$jobs))
  } else {
    min(workers_default, length(slice$jobs))
  }
  if (workers > 1L && length(slice$jobs) > 1L) {
    warning("H4_PARALLEL_WORKERS>1 disables per-job logging/checkpoints; forcing serial for this batch.", call. = FALSE)
    workers <- 1L
  }
  cat(sprintf("[Parallel] %d worker(s); checkpoint after each job in this slice.\n", workers))
  if (publish_only && n_done_pre == length(jobs)) {
    cat("[Step 5] H4_PUBLISH_ONLY=1: skipping fit loop; publishing completed checkpoint.\n")
  }
  for (k in seq_along(slice$jobs)) {
    if (publish_only && n_done_pre == length(jobs)) break
    job <- slice$jobs[[k]]
    job_idx <- slice$indices[k]
    cat(sprintf("[Step 5 job %d/%d] START outcome=%s equation_id=%d\n",
                job_idx, slice$total, job$outcome, job$equation_id))
    t0 <- proc.time()[3L]
    res <- tryCatch(
      fit_one_outcome(job),
      error = function(e) {
        cat(sprintf("[Step 5 job %d/%d] ERROR outcome=%s equation_id=%d: %s\n",
                    job_idx, slice$total, job$outcome, job$equation_id, conditionMessage(e)))
        stop(e)
      }
    )
    cat(sprintf("[Step 5 job %d/%d] DONE outcome=%s equation_id=%d (%.1fs)\n",
                job_idx, slice$total, job$outcome, job$equation_id, proc.time()[3L] - t0))
    records[[job_idx]] <- res
    h4_step5_write_checkpoint(records, fingerprints, h4_model_dir)
  }
  n_done <- sum(!vapply(records, is.null, logical(1L)))
  if (n_done < length(jobs)) {
    cat(sprintf("[Step 5] Partial: %d/%d jobs complete. Next batch: set H4_JOB_START=%d (or H4_MAX_JOBS=N).\n",
                n_done, length(jobs), slice$end + 1L))
    return(invisible(list(records = records, complete = FALSE, n_done = n_done)))
  }
  fit_results <- records
  attr(fit_results, "fingerprints") <- fingerprints
  h4_step5_write_checkpoint(records, fingerprints, h4_model_dir)
  published <- h4_publish_fits(fit_results, fingerprints, h4_model_dir, outcomes, fit_equation_ids,
    catalog, prep, nonthermal, agreed_common, preflight_df, raw_df)
  # The report writer consumes the published coefficient/status object, alongside the checkpoint metadata.
  invisible(list(records = fit_results, complete = TRUE, h4 = published))
}

# h4_1_fit prepares designs and dispatches jobs.
# h4_1_fit_equations fits one outcome. h4_1_publish_fits writes the tables.
h4_fit_equations <- function(fit_equation_ids, y, catalog, thermal, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, transformation,
    raw_df, agreed_common, do_fit_with_fallback, fit_lme, nested, fitted_model) {
coef_rows <- contrast_rows <- status_rows <- sens_rows <- lag_rows <- list()
status_row <- function(success, converged, structure, note, residual_sd = NA_real_, ar1_rho = NA_real_,
                       lag1_normalized = NA_real_, n_adjacent = 0L, residual_skew = NA_real_, residual_excess_kurtosis = NA_real_,
                       boundary_variance = NA, high_ar1_flag = NA, min_cr2_df = NA_real_, min_cr2_df_heat = NA_real_)
  data.frame(equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y,
    success = success, n = nrow(model_data), n_participants = nlevels(model_data$ParticipantID),
    transformation = transformation, converged = converged, residual_structure = structure, residual_sd = residual_sd,
    ar1_rho = ar1_rho, lag1_normalized = lag1_normalized, n_adjacent = n_adjacent,
    residual_skew = residual_skew, residual_excess_kurtosis = residual_excess_kurtosis,
    boundary_variance = boundary_variance, high_ar1_flag = high_ar1_flag, min_cr2_df = min_cr2_df, min_cr2_df_heat = min_cr2_df_heat,
    participant_ids = paste(sort(unique(as.character(model_data$ParticipantID))), collapse = ";"),
    n_available_outcome = sum(is.finite(raw_df[[y]])), n_removed = nrow(raw_df) - nrow(model_data),
    note = note, stringsAsFactors = FALSE)
coef_frame <- function(term, est, se, df, p = 2 * pt(-abs(est / se), df), note = "")
  data.frame(equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y, term = term, estimate = est, se = se, df = df,
    residual_structure = attempt$residual_structure, ci_low = est - qt(0.975, df) * se, ci_high = est + qt(0.975, df) * se,
    t_stat = est / se, p_value = p, q_value = NA_real_, low_df_flag = is.finite(df) & df < 4, term_note = note, stringsAsFactors = FALSE)
for (eq_id in fit_equation_ids) {
  eq_row <- catalog[catalog$equation_id == eq_id, ]
  heat_representation <- eq_row$heat_form
  blk <- eq_row$block
  original_terms <- fitted_model$original_terms
  safe_terms <- fitted_model$safe_terms
  model_data <- fitted_model$data
  fml <- fitted_model$formula
  attempt <- fitted_model$attempt
  fit <- attempt$fit
  if (is.null(fit)) {
    status_rows[[length(status_rows) + 1]] <- status_row(FALSE, FALSE, "not_fitted",
      paste("AR1 and independent-residual fits failed:", attempt$note))
    next
  }
  cr2_messages <- character()
  robust <- tryCatch(withCallingHandlers({
    result <- clubSandwich::coef_test(fit, vcov = "CR2", cluster = model_data$ParticipantID, test = "Satterthwaite")
    if (!isTRUE(all.equal(as.numeric(result$beta), as.numeric(nlme::fixef(fit)), tolerance = 1e-8)))
      stop("CR2 coefficient order does not match fixed effects")
    result
  }, warning = function(w) cr2_messages <<- c(cr2_messages, conditionMessage(w))),
    error = function(e) { cr2_messages <<- c(cr2_messages, conditionMessage(e)); NULL })
  if (is.null(robust)) {
    status_rows[[length(status_rows) + 1]] <- status_row(FALSE, TRUE, attempt$residual_structure,
      paste("CR2 estimation failed:", attempt$note, paste(cr2_messages, collapse = "; ")))
    next
  }
  normalized_residuals <- tryCatch(residuals(fit, level = 2, type = "normalized"), error = function(e) NULL)
  grp <- interaction(model_data$ParticipantID, model_data$PhaseID, drop = TRUE)
  adj <- which(as.character(grp[-1]) == as.character(grp[-length(grp)]) & abs(diff(model_data$Time10) - 1) < 1e-6)
  lag1 <- if (!is.null(normalized_residuals) && length(adj) > 2) stats::cor(normalized_residuals[adj], normalized_residuals[adj + 1L]) else NA_real_
  rho <- tryCatch(unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)
  if (length(rho) != 1L) rho <- NA_real_
  centered_normalized_residuals <- if (!is.null(normalized_residuals)) normalized_residuals - mean(normalized_residuals) else NULL
  rms <- if (!is.null(centered_normalized_residuals)) sqrt(mean(centered_normalized_residuals^2)) else NA_real_
  skew <- if (!is.null(centered_normalized_residuals) && rms > 0) mean((centered_normalized_residuals / rms)^3) else NA_real_
  kurt <- if (!is.null(centered_normalized_residuals) && rms > 0) mean((centered_normalized_residuals / rms)^4) - 3 else NA_real_
  variance_text <- nlme::VarCorr(fit)[, "Variance"]
  random_var <- as.numeric(variance_text[grepl("^[0-9.+eE-]+$", variance_text)])
  boundary <- any(random_var[is.finite(random_var)] < 1e-6 * sigma(fit)^2)
  high_ar1 <- is.finite(rho) & rho > 0.95
  # low_df_flag: CR2/Satterthwaite df < 4 make t tests unreliable (Tipton 2015; Pustejovsky & Tipton 2018); flagged, never dropped.
  coefficient_results <- coef_frame(c("Intercept", original_terms), robust$beta, robust$SE, robust$df_Satt)
  # Under contr.sum(4) the fourth phase deviation is exactly PhaseSumBikeU = -(WalkG + WalkU + BikeG).
  phase_cols <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
  if (all(phase_cols %in% original_terms)) {
    bikeu <- tryCatch({
      V <- clubSandwich::vcovCR(fit, cluster = model_data$ParticipantID, type = "CR2")
      L <- matrix(0, 1L, length(nlme::fixef(fit)), dimnames = list(NULL, names(nlme::fixef(fit))))
      L[1L, phase_cols] <- -1
      wt <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
      list(as.numeric(L %*% nlme::fixef(fit)), sqrt(as.numeric(L %*% V %*% t(L))), as.numeric(wt$df_denom), as.numeric(wt$p_val), NULL)
    }, error = function(e) list(NA_real_, NA_real_, NA_real_, NA_real_, paste("BikeU contrast failed:", conditionMessage(e))))
    pos <- match("PhaseSumBikeG", coefficient_results$term)
    coefficient_results <- rbind(coefficient_results[seq_len(pos), ], coef_frame("PhaseSumBikeU", bikeu[[1]], bikeu[[2]], bikeu[[3]], bikeu[[4]],
      paste(c("Derived contrast: BikeU = -(WalkG + WalkU + BikeG)", bikeu[[5]]), collapse = "; ")),
      coefficient_results[-seq_len(pos), ])
    rownames(coefficient_results) <- NULL
  }
  coefficient_results$term_category <- "Nonthermal_Covariate"
  coefficient_results$term_category[coefficient_results$term == "Intercept"] <- "Intercept"
  coefficient_results$term_category[startsWith(coefficient_results$term, "Phase")] <- "Phase_Condition"
  heat_terms <- unique(c(thermal[[heat_representation]], intersect(original_terms, "ucm_MRT")))
  coefficient_results$term_category[coefficient_results$term %in% heat_terms] <- "Heat_Main_Effect"
  sound_ix <- grepl(":", coefficient_results$term, fixed = TRUE) & grepl("ucm_SND_dBA", coefficient_results$term, fixed = TRUE)
  coefficient_results$term_category[sound_ix] <- "Thermal_x_Sound"
  coefficient_results$term_category[grepl(":PhaseSum", coefficient_results$term, fixed = TRUE)] <- "Thermal_x_Phase"
  # Candidate terms are specified before outcome fits; no significance-based or PCA selection.
  coefficient_results$selection_status <- ifelse(coefficient_results$term == "Intercept", "intercept",
    ifelse(coefficient_results$term_category == "Nonthermal_Covariate" & !(coefficient_results$term %in% agreed_common),
           "retained_candidate", "specified_term"))
  coef_non_int <- coefficient_results[coefficient_results$term != "Intercept", ]
  min_df <- if (nrow(coef_non_int) > 0) min(coef_non_int$df, na.rm = TRUE) else NA_real_
  heat_only <- coef_non_int[coef_non_int$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound", "Thermal_x_Phase"), ]
  min_df_heat <- if (nrow(heat_only) > 0) min(heat_only$df, na.rm = TRUE) else NA_real_
  status_rows[[length(status_rows) + 1]] <- status_row(TRUE, TRUE, attempt$residual_structure,
    paste(if (identical(attempt$residual_structure, "independent_fallback")) "INDEPENDENT-RESIDUAL FALLBACK (not equivalent to AR1)" else paste(attempt$residual_structure, "fit completed"),
          attempt$note, paste(cr2_messages, collapse = "; "), sep = "; "),
    residual_sd = sigma(fit), ar1_rho = rho, lag1_normalized = lag1, n_adjacent = length(adj),
    residual_skew = skew, residual_excess_kurtosis = kurt, boundary_variance = boundary, high_ar1_flag = high_ar1,
    min_cr2_df = min_df, min_cr2_df_heat = min_df_heat)
  coef_rows[[length(coef_rows) + 1]] <- coefficient_results
  contrast_messages <- character()
  phase_tests <- tryCatch(withCallingHandlers(h4_phase_contrasts(fit, model_data$ParticipantID),
    warning = function(w) contrast_messages <<- c(contrast_messages, conditionMessage(w))),
    error = function(e) { contrast_messages <<- c(contrast_messages, conditionMessage(e)); NULL })
  if (is.null(phase_tests)) phase_tests <- data.frame(contrast = rownames(h4_phase_contrast_weights()), estimate = NA_real_,
    se = NA_real_, df = NA_real_, low_df_flag = NA, ci_low = NA_real_, ci_high = NA_real_, p_value = NA_real_)
  contrast_rows[[length(contrast_rows) + 1L]] <- cbind(phase_tests, outcome = y, residual_structure = attempt$residual_structure,
    equation_id = eq_id, note = paste(contrast_messages, collapse = "; "), stringsAsFactors = FALSE)
  sens_part <- h4_sensitivity_rows(coefficient_results, attempt, boundary, high_ar1, fit_lme, fml, model_data,
    original_terms, safe_terms, nested, eq_id, heat_representation, blk, y)
  if (!is.null(sens_part)) sens_rows[[length(sens_rows) + 1L]] <- sens_part

  lag_part <- h4_lag60_rows(coefficient_results, attempt, fit_lme, fml, nested, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
    eq_row, original_terms, safe_terms, eq_id, y)
  if (!is.null(lag_part)) lag_rows[[length(lag_rows) + 1L]] <- lag_part

}
list(
  coef = if (length(coef_rows)) do.call(rbind, coef_rows) else NULL,
  status = if (length(status_rows)) do.call(rbind, status_rows) else NULL,
  contrasts = if (length(contrast_rows)) do.call(rbind, contrast_rows) else NULL,
  sensitivity = if (length(sens_rows)) do.call(rbind, sens_rows) else NULL,
  lag60 = if (length(lag_rows)) do.call(rbind, lag_rows) else NULL
)
}

h4_coefficient_fdr <- function(results, equation, term, p, eligible, outcomes) {
  tested <- term != "Intercept" & term != "(Intercept)"
  available <- eligible & is.finite(p)
  results$q <- results$q_equation <- NA_real_
  for (key in unique(paste(equation, term))) {
    rows <- which(paste(equation, term) == key & tested & available)
    if (length(rows)) results$q[rows] <- p.adjust(p[rows], "BH", n = length(outcomes))
  }
  for (eq in unique(equation)) {
    rows <- which(equation == eq & tested & available)
    planned <- length(unique(term[equation == eq & tested])) * length(outcomes)
    if (length(rows)) results$q_equation[rows] <- p.adjust(p[rows], "BH", n = planned)
  }
  results$inference_status <- ifelse(!available, "Not estimable: model covariance or coefficient inference unavailable",
    ifelse(!tested, "Not applicable: intercept is not an exposure or phase contrast", "Tested"))
  results$FDR_scope <- ifelse(tested, sprintf("BH per term within equation across %d planned outcomes; q_equation covers all non-intercept terms within equation", length(outcomes)),
    "Not applicable: intercept")
  results$FDR_significant <- ifelse(is.finite(results$q), ifelse(results$q < .05, "TRUE", "FALSE"),
    ifelse(tested, "Not estimable", "Not applicable"))
  results$FDR_equation_significant <- ifelse(is.finite(results$q_equation), ifelse(results$q_equation < .05, "TRUE", "FALSE"),
    ifelse(tested, "Not estimable", "Not applicable"))
  results
}

h4_write_phase_results <- function(results, coefficients, status, report, audit, prepared, shared_audit_dir) {
  model_dir <- OUT_DIR
  dir.create(model_dir, recursive = TRUE, showWarnings = FALSE)
  old <- list.files(RESULT_DIR, full.names = TRUE)
  h4_archive(old[file.exists(old) & !dir.exists(old)])
  write_table <- function(data, path) write.csv(data, path, row.names = FALSE, na = "NA")
  coverage <- do.call(rbind, lapply(results, `[[`, "coverage"))
  names(coverage)[names(coverage) == "epochs"] <- "N_valid_epochs"
  coverage$N_expected_epochs <- h4_study_spec$expected_epoch_count
  coverage$Coverage_pct <- 100 * coverage$N_valid_epochs / coverage$N_expected_epochs
  write_table(coverage, file.path(OUT_DIR, h4_file("H4_Phase_Coverage.csv")))
  status$heat_form <- prepared$catalog$heat_form[match(status$equation_id, prepared$catalog$equation_id)]
  status$residual_structure <- "phase_random_intercept"
  index <- match(paste(coefficients$equation_id, coefficients$outcome), paste(status$equation_id, status$outcome))
  coefficients$residual_structure <- "phase_random_intercept"
  coefficients$covariance_robust <- "Not applicable: no temporal covariance comparison"
  coefficients$model_note <- paste(status$note[index],
    ifelse(status$boundary_variance[index], "Boundary random-intercept variance;", ""))
  coefficients$analysis_role <- "Exploratory VIF-screened phase-mean models; participant-cluster inference"
  coefficients$independent_unit <- "Participant cluster; repeated phase means"
  coefficients$p_method <- "participant-cluster CR2 / Satterthwaite"
  exposures <- coefficients$term_type %in% c("thermal exposure", "sound exposure")
  write_table(coefficients[exposures, ], file.path(RESULT_DIR, h4_file("H4_Heat_Noise_Exposures.csv")))
  write_table(coefficients[!exposures, ], file.path(RESULT_DIR, h4_file("H4_Covariates_and_Phases.csv")))
  catalog <- prepared$catalog
  catalog$analysis_role <- paste("Phase-mean sensitivity:", catalog$analysis_role)
  catalog$attempted <- vapply(catalog$equation_id, function(id) sum(status$equation_id == id), integer(1))
  catalog$succeeded <- vapply(catalog$equation_id, function(id) sum(status$success[status$equation_id == id]), integer(1))
  catalog$failed <- catalog$attempted - catalog$succeeded
  catalog$fitted <- catalog$succeeded > 0
  catalog$random <- "~1|ParticipantID"
  catalog$correlation <- "None: one phase mean per participant-phase"
  comparisons <- do.call(rbind, lapply(results, `[[`, "contrasts"))
  grid <- expand.grid(outcome = h4_study_spec$all_physiological_outcomes, equation_id = h4_equation_table$equation_number,
    contrast = rownames(h4_phase_contrast_weights()), stringsAsFactors = FALSE)
  if (is.null(comparisons)) {
    comparisons <- grid
    comparisons$p_value <- NA_real_
  } else comparisons <- merge(grid, comparisons, by = c("outcome", "equation_id", "contrast"), all.x = TRUE)
  comparisons <- h4_coefficient_fdr(comparisons, comparisons$equation_id, comparisons$contrast,
    comparisons$p_value, is.finite(comparisons$p_value), h4_study_spec$all_physiological_outcomes)
  phase_included <- vapply(h4_equation_table$equation_number, function(id)
    all(H4_PHASE_SUM_COLS %in% h4_equation_term_order(id)), logical(1))
  no_phase <- !phase_included[match(comparisons$equation_id, h4_equation_table$equation_number)]
  comparisons$inference_status[no_phase] <- "Not applicable: phase adjustment not included in the retained model"
  comparisons$FDR_significant[no_phase] <- comparisons$FDR_equation_significant[no_phase] <- "Not applicable"
  comparisons$FDR_scope[no_phase] <- "Not applicable: no phase contrasts fitted"
  report <- c(report, sprintf("Separate exploratory phase contrasts: %d per-contrast q<.05 and %d equation-wide contrast q<.05; these are phase comparisons, not heat/sound exposure findings.",
    sum(comparisons$q < .05, na.rm = TRUE), sum(comparisons$q_equation < .05, na.rm = TRUE)))
  design <- status
  design$passes_check <- design$full_rank
  design$diagnostic <- "Phase-mean design; participant-centered phase exposures"
  bundle <- list(H4_coefficients.csv = coefficients, H4_fit_status.csv = status,
    H4_equations.csv = catalog, H4_phase_contrasts.csv = comparisons,
    H4_design_redundancy_by_outcome.csv = design)
  names(bundle) <- h4_file(names(bundle))
  for (name in names(bundle)) if (is.data.frame(bundle[[name]])) write_table(bundle[[name]], file.path(model_dir, name)) else
    writeLines(bundle[[name]], file.path(model_dir, name))
  design_lines <- vapply(h4_equation_table$equation_number, function(id) sprintf("Eq%d: %d-%d phase observations; full rank %s.",
    id, min(status$n[status$equation_id == id]), max(status$n[status$equation_id == id]),
    if (all(status$full_rank[status$equation_id == id])) "yes" else "no"), character(1))
  saveRDS(results, file.path(model_dir, h4_file("H4_fit_records.rds")))
  prepared$phase_checks <- data.frame(equation_id = status$equation_id,
    n_design_rows = status$n, full_rank = status$full_rank, max_vif_equivalent = status$max_vif_equivalent)
  render_h4_faceted_flow(audit_all = audit, prep = prepared)
  writeLines(c(report, "", design_lines), file.path(RESULT_DIR, h4_file("H4_Report.md")))
  paths <- list.files(RESULT_DIR, recursive = TRUE, full.names = TRUE)
  paths <- paths[!dir.exists(paths) & basename(paths) != h4_file("H4_run_complete.csv")]
  manifest <- data.frame(file = normalizePath(paths, winslash = "/"), md5 = unname(tools::md5sum(paths)),
    code_md5 = unname(tools::md5sum(file.path(SCRIPT_DIR, "Analysis_combined_phaseavg.R"))),
    equation_code_md5 = unname(tools::md5sum(file.path(SCRIPT_DIR, "Analysis_combined_timeseries.R"))),
    core_md5 = unname(tools::md5sum(file.path(SCRIPT_DIR, "library", "Analysis_combined_core.R"))), input_md5 = unname(tools::md5sum(RAW_DATA_PATH)),
    completed_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ"), run_complete = TRUE, run_scope = "PHASE_AVERAGE")
  write_table(manifest, file.path(model_dir, h4_file("H4_run_complete.csv")))
  cat("Phase-average output package:", RESULT_DIR, "\n", nrow(manifest), "tracked artifacts plus completion manifest\n")
}

h4_phase_publish_results <- function(results, prepared, audit, shared_audit_dir) {
  coefficients <- do.call(rbind, lapply(results, `[[`, "coefficients"))
  status <- do.call(rbind, lapply(results, `[[`, "status"))
  coefficients <- h4_coefficient_fdr(coefficients, coefficients$equation_id, coefficients$term,
    coefficients$p, is.finite(coefficients$p), h4_study_spec$all_physiological_outcomes)
  failed <- !is.finite(coefficients$p)
  index <- match(paste(coefficients$equation_id, coefficients$outcome), paste(status$equation_id, status$outcome))
  coefficients$inference_status[failed] <- ifelse(status$note[index[failed]] == "Completed",
    "Not estimable: CR2 p-value or degrees of freedom unavailable", paste("Not estimable:", status$note[index[failed]]))
  coefficients$term <- sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", coefficients$term)
  report <- c("# H4 phase-average sensitivity", "",
    "These exploratory models use the six explicit phase-average formulas in Analysis_combined_phaseavg.R. Each includes sum-to-zero phase adjustment; solar irradiance and GVI are omitted from this variant.",
    "The declared formulas are fixed across all 26 outcomes. Outcome-specific phase-mean design rank and VIF are reported; VIF flags do not automatically remove variables.",
    "All six equations include the three sum-to-zero phase contrasts and a participant random intercept.",
    "The same matched eight-minute input as Analysis_combined_timeseries.R is averaged over each participant-phase; this does not change to the full-duration input. Participant random intercept, REML, participant-cluster CR2/Satterthwaite inference; no temporal AR(1).",
    "Epoch eligibility uses each original complete equation, preserving the screening comparison sample. SVF endpoint carry-forward follows H4 time-series preparation. Each model averages predictors and outcome over identical observed epochs.",
    "Natural-log outcomes (HRV, EDA tonic) are logged before averaging. Exposures are centered within participant across phase means and scaled by pooled SD before forming interactions.",
    "These are phase-mean associations, not within-bout fluctuations. Interactions are products of phase means, not means of epoch interaction products.",
    "q: BH across 26 planned outcomes per term/equation. q_equation: BH across all non-intercept terms and outcomes within equation. No correction across equations.",
    "Boundary variance, low df, missing phases and warnings remain visible; no automatic variable removal or uncorrelated fallback.", "",
    sprintf("Models with estimates: %d/%d; low-df coefficient rows: %d.",
      sum(status$success), nrow(status), sum(coefficients$low_df_flag)),
    sprintf("Per-term q<.05: %d; equation-wide q<.05: %d. Counts include exploratory adjustment/phase terms.",
      sum(coefficients$q < .05, na.rm = TRUE), sum(coefficients$q_equation < .05, na.rm = TRUE)))
  h4_write_phase_results(results, coefficients, status, report, audit, prepared, shared_audit_dir)
  invisible(NULL)
}

h4_publish_fits <- function(fit_results, fingerprints, h4_model_dir, outcomes, fit_equation_ids,
    catalog, prep, nonthermal, agreed_common, preflight_df, raw_df) {
  coef_all <- do.call(rbind, lapply(fit_results, `[[`, "coef"))
  status_all <- do.call(rbind, lapply(fit_results, `[[`, "status"))
  stopifnot(nrow(status_all) == length(outcomes) * length(fit_equation_ids),
            !anyDuplicated(status_all[, c("outcome", "equation_id")]))
  if (is.null(coef_all) || !nrow(coef_all)) stop("All fits failed; existing published outputs preserved")
  contrast_all <- do.call(rbind, lapply(fit_results, `[[`, "contrasts"))
  contrast_grid <- expand.grid(outcome = outcomes, equation_id = fit_equation_ids,
                              contrast = rownames(h4_phase_contrast_weights()), stringsAsFactors = FALSE)
  if (is.null(contrast_all)) stop("No phase-contrast records returned")
  stopifnot(!anyDuplicated(contrast_all[, c("outcome", "equation_id", "contrast")]))
  contrast_all <- merge(contrast_grid, contrast_all, by = c("outcome", "equation_id", "contrast"), all.x = TRUE)
  contrast_all$note[is.na(contrast_all$note)] <- paste0("Model failed; contrast not estimable (see ", h4_file("H4_fit_status.csv"), ")")
  # Phase contrasts have their own declared per-contrast/outcome correction, separate from exposure tests.
  contrast_all$fdr_note <- "BH per contrast within equation across planned outcomes; exploratory phase comparison"
  contrast_all$q_value <- NA_real_
  sens_all <- do.call(rbind, lapply(fit_results, `[[`, "sensitivity"))
  lag_all <- do.call(rbind, lapply(fit_results, `[[`, "lag60"))
  if (!is.null(lag_all)) {
    # Separate exploratory family: BH per equation x term across outcomes; never merged into the primary q.
    lag_all$q_lag60 <- NA_real_
    for (k in unique(paste(lag_all$equation_id, lag_all$term))) {
      idx <- which(paste(lag_all$equation_id, lag_all$term) == k & lag_all$inference_eligible & is.finite(lag_all$p_value))
      if (length(idx)) lag_all$q_lag60[idx] <- p.adjust(lag_all$p_value[idx], "BH", n = length(outcomes))
    }
    lag_all$FDR_significant <- ifelse(is.finite(lag_all$q_lag60), ifelse(lag_all$q_lag60 < .05, "TRUE", "FALSE"), "Not estimable")
    lag_all$FDR_scope <- "Exploratory lag sensitivity: BH per term/equation across planned outcomes"
    lag_all$inference_status <- ifelse(is.finite(lag_all$q_lag60), "Tested", paste("Not estimable:", lag_all$note))
    utils::write.csv(lag_all, file.path(h4_model_dir, h4_file("H4_lag60_sensitivity.csv")), row.names = FALSE, na = "NA")
  }
  if (is.null(sens_all)) stop("No covariance sensitivity records returned")
  # Report every non-intercept term; preserve invalid inference as explicitly unavailable.
  primary_cats <- c("Heat_Main_Effect", "Thermal_x_Sound")
  is_sound <- coef_all$term %in% "ucm_SND_dBA"
  coef_all$term_category[is_sound] <- "Sound_Main_Effect"
  status_index <- match(paste(coef_all$equation_id, coef_all$outcome), paste(status_all$equation_id, status_all$outcome))
  stopifnot(!anyNA(status_index))
  unresolved_ar1 <- status_all$high_ar1_flag[status_index] %in% TRUE
  is_correlated_fit <- coef_all$residual_structure %in% c("AR1", "ARMA20") & !unresolved_ar1
  contrast_status <- match(paste(contrast_all$equation_id, contrast_all$outcome), paste(status_all$equation_id, status_all$outcome))
  contrast_eligible <- status_all$residual_structure[contrast_status] %in% c("AR1", "ARMA20") &
    !(status_all$high_ar1_flag[contrast_status] %in% TRUE)
  contrast_fdr <- h4_coefficient_fdr(data.frame(row = seq_len(nrow(contrast_all))), contrast_all$equation_id,
    contrast_all$contrast, contrast_all$p_value, contrast_eligible, outcomes)
  contrast_all$q_value <- contrast_fdr$q
  contrast_all$FDR_significant <- contrast_fdr$FDR_significant
  contrast_all$inference_status <- contrast_fdr$inference_status
  contrast_all$p_value[!contrast_eligible] <- NA_real_
  alternate_fdr <- h4_coefficient_fdr(data.frame(row = seq_len(nrow(sens_all))),
    paste(sens_all$equation_id, sens_all$sensitivity_specification), sens_all$term,
    sens_all$alt_p_value, sens_all$sensitivity_status == "success", outcomes)
  sens_all$alt_q <- alternate_fdr$q
  sens_all$alt_FDR_significant <- alternate_fdr$FDR_significant
  sens_all$alt_inference_status <- ifelse(sens_all$sensitivity_status == "success", alternate_fdr$inference_status,
    paste("Not estimable:", sens_all$sensitivity_status))
  sens_all$alt_FDR_scope <- "Exploratory covariance sensitivity: BH per equation, covariance specification and term across planned outcomes"
  m_term <- length(outcomes)
  fdr <- h4_coefficient_fdr(data.frame(row = seq_len(nrow(coef_all))), coef_all$equation_id,
    coef_all$term, coef_all$p_value, is_correlated_fit, outcomes)
  coef_all$q_term <- fdr$q
  coef_all$q_equation <- fdr$q_equation
  coef_all$fdr_family <- ifelse(is.finite(fdr$q), "per_term_within_equation", fdr$inference_status)

  st <- split(status_all$success, factor(status_all$equation_id, levels = catalog$equation_id))
  catalog$attempted <- unname(lengths(st))
  catalog$succeeded <- unname(vapply(st, sum, integer(1)))
  catalog$failed <- catalog$attempted - catalog$succeeded
  catalog$fitted <- catalog$succeeded > 0L
  catalog[c("code_md5", "input_md5")] <- as.list(fingerprints[c("code_md5", "input_md5")])
  status_all[names(fingerprints)] <- as.list(fingerprints)
  sens_all[names(fingerprints)] <- as.list(fingerprints)
  # covariance_robust = FALSE if any alternative estimate lies outside the primary 95% CI, CIs do not overlap or the sign flips;
  # NA without a successful refit. alt_* report the independent-residual refit (else the boundary refit).
  coef_all <- h4_merge_covariance_sensitivity(coef_all, sens_all)
  # Both correction scopes are explicit; sensitivity equations remain separate analyses.
  is_thermal <- coef_all$term_category %in% c(primary_cats, "Thermal_x_Phase")
  coef_out <- data.frame(equation = coef_all$heat_form, outcome = coef_all$outcome,
    term = sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", coef_all$term),
    term_type = ifelse(coef_all$term == "Intercept", "intercept", ifelse(startsWith(coef_all$term, "PhaseSum"), "phase (study design)",
      ifelse(is_thermal, "thermal exposure", ifelse(is_sound, "sound exposure", "covariate")))),
    Beta = coef_all$estimate, ci_low = coef_all$ci_low, ci_high = coef_all$ci_high, p = ifelse(is_correlated_fit, coef_all$p_value, NA_real_),
    df = coef_all$df, low_df_flag = coef_all$low_df_flag,
    q = fdr$q, q_equation = fdr$q_equation, FDR_significant = fdr$FDR_significant,
    FDR_equation_significant = fdr$FDR_equation_significant, FDR_scope = fdr$FDR_scope,
    inference_status = fdr$inference_status,
    covariance_robust = coef_all$covariance_robust, residual_structure = coef_all$residual_structure, stringsAsFactors = FALSE)
  hypo_df <- coef_out[is_thermal | is_sound, ]
  postsel <- setdiff(nonthermal, agreed_common)
  rep_lines <- vapply(split(prep$rep_tab, prep$rep_tab$Step4_Domain), function(domain_rows)
    paste0("     * ", domain_rows$Step4_Domain[1], ": ", paste(domain_rows$Variable_Name, collapse = ", "), "; ", domain_rows$Step4_Restriction[1]), character(1))
  readme_lines <- h4_readme_lines(status_all, coef_all, sens_all, catalog, preflight_df, outcomes, raw_df,
                                    agreed_common, postsel, rep_lines, fingerprints)
  m_primary_txt <- sprintf("m = %d per term", as.integer(m_term))
  pkgs <- c("nlme", "clubSandwich", "car", "ggplot2", "gridExtra")
  session_lines <- c(capture.output(utils::sessionInfo()), "", paste0(pkgs, " ", vapply(pkgs, function(p)
    tryCatch(as.character(utils::packageVersion(p)), error = function(e) "not installed"), character(1))))
  bundle <- list(
    H4_equations.csv = catalog,
    H4_fit_status.csv = status_all,
    H4_coefficients.csv = coef_out,
    H4_hypothesis.csv = hypo_df,
    H4_phase_contrasts.csv = setNames(contrast_all, sub("^estimate$", "Beta", sub("^q_value$", "q", names(contrast_all)))),
    H4_covariance_sensitivity.csv = sens_all,
    H4_hypothesis_readme.txt = readme_lines,
    H4_session_info.txt = session_lines
  )
  names(bundle) <- h4_file(names(bundle))
  # Sequential publication; the completion manifest is invalidated first (readers must reject a missing manifest).
  manifest_path <- file.path(h4_model_dir, h4_file("H4_run_complete.csv"))
  live_triple <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV)))
  stored_triple <- unname(fingerprints[c("code_md5", "input_md5", "audit_md5")])
  if (!identical(live_triple, stored_triple)) {
    publish_only <- identical(Sys.getenv("H4_PUBLISH_ONLY", unset = ""), "1")
    data_audit_ok <- identical(live_triple[c(2L, 3L)], stored_triple[c(2L, 3L)])
    if (publish_only && data_audit_ok) {
      warning("H4 script fingerprint differs from checkpoint; input and audit CSV unchanged — publishing from checkpoint.", call. = FALSE)
    } else {
    stop("Script, input or audit changed during fitting; checkpoint retained, inconsistent results not published")
    }
  }
  if (file.exists(manifest_path) && !file.remove(manifest_path)) stop("Cannot invalidate old completion manifest")
  for (nm in names(bundle)) {
    target_path <- file.path(h4_model_dir, nm)
    if (is.data.frame(bundle[[nm]])) write.csv(bundle[[nm]], target_path, row.names = FALSE, na = "NA") else writeLines(bundle[[nm]], target_path)
  }
  extra_files <- h4_file(c("H4_fit_records.rds", "H4_gvif_diagnostic.csv", "H4_gvif_diagnostic.md",
                   "H4_design_redundancy_by_outcome.csv", "H4_covariance_sensitivity.csv", "H4_lag60_sensitivity.csv", "H4_session_info.txt"))
  man_files <- unique(c(names(bundle), extra_files[file.exists(file.path(h4_model_dir, extra_files))]))
  write.csv(data.frame(file = man_files, md5 = unname(tools::md5sum(file.path(h4_model_dir, man_files))), as.list(fingerprints),
    completed_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ"), run_complete = FALSE,
    run_scope = "FULL", stringsAsFactors = FALSE), manifest_path, row.names = FALSE)
  cat(sprintf("[Step 5] Bundle published to %s. Total fitted models: %d, Succeeded: %d, Failed: %d\n",
              h4_model_dir, nrow(status_all), sum(status_all$success), sum(!status_all$success)))
  cat(sprintf("[H4.1] Heat/sound exposure rows: %d, p < 0.05: %d, q < 0.05: %d (per-term BH; %s)\n",
              nrow(hypo_df), sum(hypo_df$p < 0.05, na.rm = TRUE), sum(hypo_df$q < 0.05, na.rm = TRUE), m_primary_txt))
  invisible(list(catalog = catalog, status = status_all, coef = coef_all, hypothesis = hypo_df))
}

# share). A rank-deficient design blocks fitting (no predictor removal). Extracted from h4_1_fit.
h4_design_preflight <- function(raw_df, centered, selected, catalog, thermal, make_design, fit_equation_ids, outcomes, natural_log_outcomes) {
  preflight <- list()
  for (check_y in outcomes) {
    for (check_eid in fit_equation_ids) {
      valid <- h4_complete_rows(raw_df, check_y, check_eid, natural_log_outcomes)
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
        high_vif_terms = paste(names(vv)[!is.finite(vv) | vv >= h4_study_spec$variance_inflation_factor_limit], collapse = ";"),
        condition_index = if (!length(singular) || min(singular) <= 1e-10) Inf else max(singular) / min(singular),
        passes_check = rr == ncol(check_x) + 1L, vif_flag = is.finite(mx) && mx >= h4_study_spec$variance_inflation_factor_limit, stringsAsFactors = FALSE)
    }
  }
  do.call(rbind, preflight)
}

h4_sensitivity_rows <- function(coefficient_results, attempt, boundary, high_ar1, fit_lme, fml, model_data,
    original_terms, safe_terms, nested, eq_id, heat_representation, blk, y) {
  sens_rows <- list()
  # Both covariance checks use the same fitting and coefficient-comparison code.
  target_idx <- which(coefficient_results$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound"))
  sensitivity_specs <- list()
  if (isTRUE(boundary)) sensitivity_specs$boundary <- list(
    flag = "boundary_variance", name = "random_intercept_participant_only_AR1",
    random = ~ 1 | ParticipantID, correlation = attempt$corfun())
  # Every AR1 fit gets an independent-residual comparison, including rho <= 0.95.
  if (isTRUE(high_ar1) || attempt$residual_structure %in% c("AR1", "ARMA20")) sensitivity_specs$independent <- list(
    flag = if (isTRUE(high_ar1)) "high_ar1" else "routine_independent_refit",
    name = "independent_residuals_nested_random_CR2",
    random = nested, correlation = NULL)
  if (length(target_idx)) for (specification in sensitivity_specs) {
    sensitivity_messages <- character()
    alt_fit <- fit_lme(fml, model_data, specification$random, specification$correlation, function(opt, kind, msg)
      sensitivity_messages <<- c(sensitivity_messages, if (kind == "error") paste0(opt, ": ", msg) else msg))
    alt_robust <- if (!is.null(alt_fit)) {
      tryCatch(clubSandwich::coef_test(alt_fit, vcov = "CR2", cluster = model_data$ParticipantID, test = "Satterthwaite"),
               error = function(e) { sensitivity_messages <<- c(sensitivity_messages, paste("CR2:", conditionMessage(e))); NULL })
    } else NULL
    for (i_t in target_idx) {
      t_name <- coefficient_results$term[i_t]
      p_est <- coefficient_results$estimate[i_t]
      alt_idx <- integer(0)
      k <- match(t_name, original_terms)
      if (!is.null(alt_robust) && !is.na(k)) {
        rn_match <- which(rownames(alt_robust) == safe_terms[k])
        if (length(rn_match) == 1L) alt_idx <- rn_match else if (k + 1L <= nrow(alt_robust)) alt_idx <- k + 1L
      }
      a_est <- a_se <- a_df <- a_cil <- a_cih <- a_pval <- NA_real_
      status_txt <- if (is.null(alt_fit)) paste("fit_failed:", paste(sensitivity_messages, collapse = "; ")) else "cr2_failed"
      if (length(alt_idx) == 1L) {
        a_est <- as.numeric(alt_robust$beta[alt_idx])
        a_se <- as.numeric(alt_robust$SE[alt_idx])
        a_df <- as.numeric(alt_robust$df_Satt[alt_idx])
        a_cil <- a_est - qt(0.975, a_df) * a_se
        a_cih <- a_est + qt(0.975, a_df) * a_se
        a_pval <- as.numeric(alt_robust[["p_Satt"]][alt_idx])
        status_txt <- "success"
      }
      sens_rows[[length(sens_rows) + 1L]] <- data.frame(
        equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y,
        diagnostic_flag = specification$flag,
        sensitivity_specification = specification$name,
        term = t_name, term_category = coefficient_results$term_category[i_t],
        primary_estimate = p_est, primary_se = coefficient_results$se[i_t], primary_df = coefficient_results$df[i_t],
        primary_ci_low = coefficient_results$ci_low[i_t], primary_ci_high = coefficient_results$ci_high[i_t], primary_p_value = coefficient_results$p_value[i_t],
        alt_estimate = a_est, alt_se = a_se, alt_df = a_df,
        alt_ci_low = a_cil, alt_ci_high = a_cih, alt_p_value = a_pval,
        estimate_diff = a_est - p_est, estimate_rel_diff_pct = if (is.finite(a_est) && abs(p_est) > 1e-12) 100 * (a_est - p_est) / abs(p_est) else NA_real_,
        ci_overlap = if (is.finite(a_est)) (coefficient_results$ci_low[i_t] <= a_cih) && (a_cil <= coefficient_results$ci_high[i_t]) else NA,
        sensitivity_status = status_txt, stringsAsFactors = FALSE)
    }
  }
  if (length(sens_rows)) do.call(rbind, sens_rows) else NULL
}

h4_lag60_rows <- function(coefficient_results, attempt, fit_lme, fml, nested, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
    eq_row, original_terms, safe_terms, eq_id, y) {
  heat_vars <- thermal[[heat_representation]]
  # Lag heat mains; include MRT only when the meeting formula actually uses it (Eq 2).
  lagged_vars <- unique(c(heat_vars, intersect(c("ucm_MRT"), original_terms)))
  lag_ok <- rowSums(!is.finite(lagged_exposures[, lagged_vars, drop = FALSE])) == 0L
  if (!any(lag_ok)) return(NULL)
  current_exposures <- centered_exposures[lag_ok, , drop = FALSE]
  lag_exposures <- current_exposures
  lag_exposures[, lagged_vars] <- lagged_exposures[lag_ok, lagged_vars, drop = FALSE]
  fit_comparison <- function(exposures) {
    design <- make_design(exposures, heat_vars, outcome_rows$PhaseID[lag_ok], test = eq_row$test,
      terms_order = h4_equation_term_order(eq_id))
    stopifnot(identical(colnames(design), original_terms))
    colnames(design) <- safe_terms
    data <- cbind(outcome_rows[lag_ok, , drop = FALSE], Y = outcome_values[lag_ok], as.data.frame(design))
    data <- data[order(data$ParticipantID, data$PhaseID, data$Time10), ]
    messages <- character()
    fit <- fit_lme(fml, data, nested, attempt$corfun(), function(opt, kind, msg)
      messages <<- c(messages, paste(opt, kind, msg)))
    robust <- if (!is.null(fit)) tryCatch(withCallingHandlers(
      clubSandwich::coef_test(fit, vcov = "CR2", cluster = data$ParticipantID, test = "Satterthwaite"),
      warning = function(w) messages <<- c(messages, conditionMessage(w))),
      error = function(e) { messages <<- c(messages, conditionMessage(e)); NULL }) else NULL
    rho <- if (!is.null(fit) && identical(attempt$residual_structure, "AR1"))
      as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE)) else NA_real_
    eligible <- !is.null(robust) && attempt$residual_structure %in% c("AR1", "ARMA20") &&
      !(length(rho) == 1L && is.finite(rho) && rho > .95)
    list(data = data, robust = robust, eligible = eligible, note = paste(messages, collapse = "; "))
  }
  current <- fit_comparison(current_exposures)
  lagged <- fit_comparison(lag_exposures)
  stopifnot(identical(current$data[, c("ParticipantID", "PhaseID", "Time10", "Y")],
                      lagged$data[, c("ParticipantID", "PhaseID", "Time10", "Y")]))
  term_result <- function(result, term) {
    index <- if (!is.null(result$robust)) match(term, rownames(result$robust)) else NA_integer_
    if (is.na(index)) return(c(estimate = NA, se = NA, df = NA, ci_low = NA, ci_high = NA, p = NA))
    estimate <- result$robust$beta[index]; se <- result$robust$SE[index]; df <- result$robust$df_Satt[index]
    c(estimate = estimate, se = se, df = df, ci_low = estimate - qt(.975, df) * se,
      ci_high = estimate + qt(.975, df) * se,
      p = if (result$eligible) result$robust$p_Satt[index] else NA_real_)
  }
  rows <- lapply(which(coefficient_results$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound")), function(i) {
    term <- coefficient_results$term[i]
    safe_term <- safe_terms[match(term, original_terms)]
    lag_result <- term_result(lagged, safe_term); current_result <- term_result(current, safe_term)
    data.frame(equation_id = eq_id, heat_form = heat_representation, outcome = y, term = term,
      term_category = coefficient_results$term_category[i], residual_structure = attempt$residual_structure,
      n = nrow(lagged$data), estimate = lag_result["estimate"], se = lag_result["se"], df = lag_result["df"],
      ci_low = lag_result["ci_low"], ci_high = lag_result["ci_high"], p_value = lag_result["p"],
      inference_eligible = lagged$eligible,
      same_sample_current_estimate = current_result["estimate"], same_sample_current_se = current_result["se"],
      same_sample_current_df = current_result["df"], same_sample_current_ci_low = current_result["ci_low"],
      same_sample_current_ci_high = current_result["ci_high"], same_sample_current_p = current_result["p"],
      same_sample_current_inference_eligible = current$eligible,
      note = paste("Current:", current$note, "Lagged:", lagged$note), row.names = NULL, stringsAsFactors = FALSE)
  })
  if (length(rows)) do.call(rbind, rows) else NULL
}

# any alternative estimate lies outside the primary 95% CI, the CIs do not overlap or the sign flips;
# NA without a successful refit. alt_* report the independent-residual refit (else the boundary refit).
# Extracted verbatim from h4_1_fit.
h4_merge_covariance_sensitivity <- function(coef_all, sens_all) {
  coef_all$covariance_robust <- NA; coef_all$alt_estimate <- NA_real_; coef_all$alt_ci_low <- NA_real_
  coef_all$alt_ci_high <- NA_real_; coef_all$alt_structure <- NA_character_
  sens_ok <- sens_all[sens_all$sensitivity_status == "success" & is.finite(sens_all$alt_estimate), , drop = FALSE]
  if (nrow(sens_ok)) {
    sens_ok$fails <- with(sens_ok, alt_estimate < primary_ci_low | alt_estimate > primary_ci_high |
                            !(ci_overlap %in% TRUE) | sign(alt_estimate) != sign(primary_estimate))
    key_s <- paste(sens_ok$equation_id, sens_ok$outcome, sens_ok$term)
    key_c <- paste(coef_all$equation_id, coef_all$outcome, coef_all$term)
    has <- key_c %in% key_s
    coef_all$covariance_robust[has] <- !vapply(key_c[has], function(k) any(sens_ok$fails[key_s == k]), logical(1))
    pick <- sens_ok[order(sens_ok$sensitivity_specification != "independent_residuals_nested_random_CR2"), , drop = FALSE]
    j <- match(key_c, paste(pick$equation_id, pick$outcome, pick$term))
    coef_all$alt_estimate <- pick$alt_estimate[j]; coef_all$alt_ci_low <- pick$alt_ci_low[j]
    coef_all$alt_ci_high <- pick$alt_ci_high[j]; coef_all$alt_structure <- pick$sensitivity_specification[j]
  }
  fb_rows <- coef_all$residual_structure %in% "independent_fallback"
  coef_all$covariance_robust[fb_rows] <- NA; coef_all$alt_estimate[fb_rows] <- NA_real_
  coef_all$alt_ci_low[fb_rows] <- NA_real_; coef_all$alt_ci_high[fb_rows] <- NA_real_; coef_all$alt_structure[fb_rows] <- NA_character_
  coef_all
}

h4_readme_lines <- function(status_all, coef_all, sens_all, catalog, preflight_df, outcomes, raw_df,
                              agreed_common, postsel, rep_lines, fingerprints) {
  primary_cats <- c("Heat_Main_Effect", "Thermal_x_Sound")
  status_index <- match(paste(coef_all$equation_id, coef_all$outcome), paste(status_all$equation_id, status_all$outcome))
  stopifnot(!anyNA(status_index))
  unresolved_ar1 <- status_all$high_ar1_flag[status_index] %in% TRUE
  is_correlated_fit <- coef_all$residual_structure %in% c("AR1", "ARMA20") & !unresolved_ar1
  m_term <- length(outcomes)
  n_rows_fit <- status_all$n[status_all$success]
  n_text <- if (length(n_rows_fit)) sprintf("%d-%d rows per outcome-equation (median %d)", min(n_rows_fit), max(n_rows_fit), as.integer(stats::median(n_rows_fit))) else "no successful fits"
  vif_max <- suppressWarnings(max(preflight_df$max_vif[is.finite(preflight_df$max_vif)]))
  vif_txt <- if (is.finite(vif_max)) sprintf("max grouped VIF-equiv = %.2f; %d design(s) >= %s", vif_max, sum(preflight_df$vif_flag, na.rm = TRUE), h4_study_spec$variance_inflation_factor_limit) else "VIF not computed"
  np_rng <- range(status_all$n_participants[status_all$success], na.rm = TRUE)
  hits <- coef_all[coef_all$term_category %in% primary_cats & is.finite(coef_all$q_term) & coef_all$q_term < 0.05, , drop = FALSE]
  hits_txt <- if (nrow(hits)) sprintf("%d thermal q<0.05 row(s); see H4_coefficients.csv", nrow(hits)) else "none (no q < 0.05)"
  eq_ids <- paste(catalog$equation_id, collapse = ", ")
  c(
    "H4.1 Physiological Sensor Time-Series Models",
    "Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md",
    sprintf("Equations (catalog ids): %s â€” primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.", eq_ids),
    sprintf("Sample: 10 s windows; %s; %d outcomes; participants %d-%d per model.", n_text, length(unique(status_all$outcome)), np_rng[1], np_rng[2]),
    sprintf("Design VIF (threshold %s): %s. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.", h4_study_spec$variance_inflation_factor_limit, vif_txt),
    sprintf("Fits: %d/%d successful outcome-equation models. All non-intercept coefficients have BH q across planned outcomes per term/equation, plus q_equation across all non-intercept terms/outcomes within equation. Intercepts and invalid inference have explicit status text. Equations are not pooled into one correction family.", sum(status_all$success), nrow(status_all)),
    sprintf("SVF endpoint carry-forward rows: %d.", sum(raw_df$SVF_endpoint_carried)),
    sprintf("Covariates retained after Step 4: %s.", if (length(postsel)) paste(postsel, collapse = ", ") else "none"),
    sprintf("Thermal q<0.05: %s. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).", hits_txt),
    sprintf("All non-intercept coefficients: %d per-term q<0.05 and %d equation-wide q<0.05. These include exploratory adjustment/phase effects and repeated sensitivity specifications, not independent H4 discoveries.",
      sum(coef_all$q_term < .05, na.rm = TRUE), sum(coef_all$q_equation < .05, na.rm = TRUE)),
    sprintf("Sound main effects: %d per-term q<0.05. Sound interactions: %d. Phase contrasts and other adjustments are fully reported in the coefficient tables.",
      sum(coef_all$q_term[coef_all$term_category == "Sound_Main_Effect"] < .05, na.rm = TRUE),
      sum(coef_all$q_term[coef_all$term_category == "Thermal_x_Sound"] < .05, na.rm = TRUE)),
    sprintf("Generated: %s UTC | code_md5 %s | input_md5 %s | audit_md5 %s | spec_md5 %s",
            format(Sys.time(), tz = "UTC", format = "%Y-%m-%d %H:%M:%S"),
            fingerprints["code_md5"], fingerprints["input_md5"], fingerprints["audit_md5"], fingerprints["spec_md5"])
  )
}

# --- Entry: design + fit (after core audit), publish via core ---
h4_run_models <- function(audit_df, raw_df, prep = NULL) {
  if (is.null(prep)) prep <- h4_step4_exposure_prep(audit_df, raw_df)
  step5_result <- h4_fit(audit_df, raw_df, prep = prep)
  h4_publish_outputs(audit_df, step5_result, prep = prep)
  invisible(step5_result)
}

# --- 7. Pipeline: h4_run_full_pipeline, h4_dispatch_run ---

h4_run_audit <- function() {
    # Input audits and model artifacts are archived separately before regeneration.
    h4_regenerated <- c(OUT_CSV, sub(".csv$", "_latest.csv", OUT_CSV), AUDIT_PDF, STAGE_SUMMARY_CSV, INTEGRATION_CSV,
                        STEP_CATEGORY_CSV, FINAL_OUTCOME_COUNTS_CSV, TRANSPARENCY_MD, FORMULA_TXT,
                        H4_OUT_PATHS$phase_coverage_csv,
                        file.path(RESULT_DIR, h4_file(c("H4_Heat_Noise_Exposures.csv", "H4_Covariates_and_Phases.csv", "H4_Report.md",
                          "H4_Selection_Flow.pdf", "H4_Variable_Selection.csv"))))
    h4_archive(h4_regenerated)
    cat("[1/6] Loading canonical 8-minute analysis dataset...\n")
    df <- h4_read_merged_analysis_data()
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
    df <- h4_apply_average_sources(df, missing_only = FALSE)
    df_core <<- df[df$PhaseID %in% CORE_PHASES, ]
    cat(sprintf("Loaded %d observations across %d participants (%d core outdoor epochs).\n", nrow(df), length(unique(df$ParticipantID)),
        nrow(df_core)))
    # Exclusion sources ([key]; files under Paper3_Github/Experiment papers/): [Beiglary25] Beiglary et al. 2025 JMIR Aging e72338
    # p.5; [Ishihara25] Ishihara et al. 2025 SLEEP zsaf358 p.1/p.7/p.10; [Sonneborn] Sonneborn & Voss, light field studies p.1;
    # [ClearCI] clearness index kt = Gh/G0, p.3 eq.2; [Zhu24] Zhu et al. 2024 p.3/p.5; [Joubert26] Joubert et al. 2026 mixtures workflow;
    # [Qiu17] Qiu et al. 2017 p.1 (SVF); [CityFeel17] UCM sensor table, doi:10.1016/j.egypro.2017.07.427.
    cat("[2/6] Step 1: Auditing full schema and partitioning analytical roles...\n")
    # ---- Steps 1-3: roles, consolidation and audit tables ----
    derived_cols_all <- c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg")
    # Step 1-3 helpers resolve audit tables from .GlobalEnv (legacy script-level bindings).
    all_variables_pool <<- unique(c(raw_cols_all, derived_cols_all))
    step1_mat <<- t(sapply(all_variables_pool, function(col) if (col %in% derived_cols_all)
      c(if (grepl("^atmo_", col)) "Atmotube" else "LYS Study Average", "Environmental Stressor Candidates (X_env)",
        if (grepl("pm", col)) "Âµg/mÂ³" else if (grepl("lux", col)) "lux" else if (grepl("medi", col)) "medi" else "K",
        "Retained for Step 2 technical sensor consolidation", "RETAINED FOR FILTRATION") else classify_col_role(col)))
    cat("[3/6] Step 2: Checking explicit replacements, measurement type and within-person availability...\n")
    stopifnot(length(unlist(average_sources)) == 12L, !anyDuplicated(unlist(average_sources)))
    h4_prepared_for_vif <- h4_prepare_data(df)
    audit_phase_groups <- split(seq_len(nrow(df_core)), paste(df_core$ParticipantID, df_core$PhaseID, sep = "::"))
    audit_availability <<- do.call(rbind, lapply(all_variables_pool, function(col) {
      values <- if (is.numeric(df_core[[col]])) vapply(audit_phase_groups, function(ix) h4_mean(df_core[[col]][ix]), numeric(1)) else rep(NA_real_, length(audit_phase_groups))
      ids <- sub("::.*", "", names(audit_phase_groups))
      centered <- h4_person_mean_center(values, ids)
      data.frame(Variable_Name = col, Available_Phase_Cells = sum(is.finite(values)),
        Available_Participants = length(unique(ids[is.finite(values)])),
        Within_Person_SD = if (sum(is.finite(centered)) > 1L) sd(centered, na.rm = TRUE) else NA_real_)
    }))

    step2_mat <<- t(mapply(classify_step2_consolidation, all_variables_pool, step1_mat[, 2], USE.NAMES = FALSE))
    cat("[4/6] Step 3: Auditing every Step-2 eligible measurement; no domain shortlist...\n")
    h4_measurement_sources <- data.frame(
        Variable_Name = c("ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_SND_dBA", "ucm_SUN_Gh", "atmo_pm1_avg",
            "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg", "ucm_MRT", "ucm_PET", "ucm_UTCI",
            "ucm_HUMIDEX", "Clearness_Index", "Clearness_Index_G0", "gvi_50m", "ucm_WIND_AWS", "ucm_fp", "SVF"),
        Measurement_Code = c(rep("M", 4), rep("A", 4), rep("D", 9), "M", "U", "D"),
        Measurement_Type = c(rep("Instrument", 4), rep("Average", 4), rep("Derived", 9), "Wind", "Unverified", "SVF"),
        Inputs_or_Definition = c("[UCM T_mid]", "[UCM]", "[dBA]", "[Gh]", "[PM1 avg]", "[PM25 avg]", "[PM10 avg]", "[Lux avg]",
            "[Medi derived]", "[Kelvin avg]", "[MRT]", "[PET]", "[UTCI]", "[HUMIDEX]", "[kt derived]", "[G0 calc]", "[GVI]",
            "[AWS]", "[fp unverified]", "[SVF Holmer]"),
        Evidence = c(rep("[CityFeel17]", 4), rep("[avg_sources]", 4), "[MediRGB]", "[LYS]", rep("[CityFeel17]", 4),
            rep("[ClearCI]", 2), "[GVI merge]", "[AWS]", "[fp]", "[SVF Qiu17]"),
        stringsAsFactors = FALSE)
    step3_mat <<- t(mapply(classify_step3_domain, all_variables_pool, step2_mat[, 2], USE.NAMES = FALSE))
    cat("Step 3: Tracing measurement sources and within-person dependencies; no predictor elimination...\n")
    screening_candidates <<- all_variables_pool[step2_mat[, 2] == "Retained"]
    write.csv(h4_prepared_for_vif$coverage, H4_OUT_PATHS$phase_coverage_csv, row.names = FALSE, na = "")
    design_audit <- h4_audit_step3(df_core, screening_candidates)
    h4_retained_candidates <<- screening_candidates
    # Clearness_Index, Clearness_Index_G0 and lys_medi_avg stay in the provenance table but are excluded in Step 2 (derived: Gh/G0; calculated G0; RGB-estimated melanopic EDI).
    .h4_expected_screen <- setdiff(h4_measurement_sources$Variable_Name, c("ucm_fp", "Clearness_Index", "Clearness_Index_G0", "lys_medi_avg"))
    if (!setequal(screening_candidates, .h4_expected_screen)) {
      stop(sprintf(
        "Step-2 Retained set != expected measurement sources.\nOnly in screening: %s\nOnly in expected: %s",
        paste(sort(setdiff(screening_candidates, .h4_expected_screen)), collapse = ", "),
        paste(sort(setdiff(.h4_expected_screen, screening_candidates)), collapse = ", ")
      ), call. = FALSE)
    }
    step1_criterion <<- "Role classification: only X_env candidates proceed; metadata, outcomes, QC, and covariates do not enter exposure selection"
    step3_criterion <<- "Measurement provenance and dependencies; within-person correlations and full-design rank are descriptive. All Step-2 candidates remain; no final exposure equation selected"
    role_outcomes <<- rbind(
      c("Derived Light Category (not an independent continuous exposure)", "DERIVED LIGHT CATEGORY", NA),
      c("Physiological Sensor Outcomes (Y_physio)", "PHYSIOLOGICAL OUTCOME (Y)", "Objective physiological outcome; Step 4 uses 10-second summaries with declared natural logs (HRV, EDA tonic). Step 5 handles its outcome transformations separately."),
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
        "Participant is the independent cluster. Step 4 defines six equations (primary UTCI + PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 only with UTCI) including heat x sound and MRT x sound. Step 5 fits all six. Earlier model outputs are historical until a verified rerun succeeds.",
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
    stopifnot(!any(grepl("^ucm_IR_|^ucm_.*_(SR|S)$|^ucm_AH$|^ucm_AIR_T_(bot|top)$|^ucm_AIR_temp$|IO_flag", selected_step2)),
              identical(grep("^ucm_WIND_", selected_step2, value = TRUE), "ucm_WIND_AWS"),
              identical(grep("^gvi_|^(plant|grass|tree)_phase_mean$", selected_step2, value = TRUE), "gvi_50m"),
              !any(is_acoustic_frequency(selected_step2)),
              all(c("ucm_AIR_T_mid", "ucm_AIR_RH", "ucm_UTCI", "ucm_SND_dBA") %in% selected_step2))

    writeLines(c("Step 3: measurement categories.", "Step 4: retain 16 candidates; specify 6 equations (primary UTCI + PM2.5); check full-design rank and VIF; MRT x sound is Eq 2 only.",
        "Step 5: mixed-model fitting (all 6 equations); new equations require a new verified fit."), FORMULA_TXT)

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
# H4_PUBLISH_ONLY=1 (with Step 5 checkpoint complete): skip refitting; write coefficients/status from fit_records.rds.
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
    if (file.exists(file.path(OUT_DIR, h4_file("H4_run_complete.csv"))))
      stop("A completed model bundle exists; rerun Step 5 instead of rewriting GVIF files after hashing.")
    raw_df <- h4_read_merged_analysis_data()
    raw_df <- h4_apply_average_sources(raw_df)
    out <- h4_run_gvif_diagnostic(h4_step4_exposure_prep(read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), raw_df))
    cat("Wrote GVIF diagnostic:", out$paths["csv"], "\n")
    quit(save = "no", status = 0)
  }
  if (identical(Sys.getenv("H4_FACET_REFRESH"), "1")) {
    if (!file.exists(file.path(OUT_DIR, h4_file("H4_run_complete.csv")))) {
      raw_df <- h4_read_merged_analysis_data()
      raw_df <- h4_apply_average_sources(raw_df)
      h4_run_gvif_diagnostic(h4_step4_exposure_prep(read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), raw_df))
    }
    render_h4_faceted_flow()
    quit(save = "no", status = 0)
  }
  if (identical(Sys.getenv("H4_STEP5_ONLY"), "1")) {
    if (!file.exists(OUT_CSV)) stop("H4_STEP5_ONLY=1 but no saved Step 4 audit at: ", OUT_CSV, call. = FALSE)
    cat("[Fast Track] Found existing validated Step 4 audit at:", OUT_CSV, "\n")
    audit_df <- read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE)
    raw_df <- h4_read_merged_analysis_data()
    raw_df <- h4_apply_average_sources(raw_df)
    invisible(h4_run_models(audit_df, raw_df))
    cat("H4 multivariate Step 5 execution and faceted flow PDF update completed successfully.\n")
    quit(save = "no", status = 0)
  }
  h4_run_full_pipeline()
}

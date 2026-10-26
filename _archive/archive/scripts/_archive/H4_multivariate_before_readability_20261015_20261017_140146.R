# H4 entry: Rscript scripts/H4_multivariate.R -> run_h4(). Methods: Paper3_Methods_Plain.md
# Six equations (non-thermal covariates, phase sum-to-zero, heat/MRT x sound): see equation_spec below.

# Six equations. Ids, heat keys, PM terms, and roles are the fitted set.
equation_spec <- data.frame(
    equation_id = 1:6,
    heat_key = c("UTCI", "AIR_temp + AIR_RH + WIND_AWS", "HUMIDEX", "PET", "UTCI", "UTCI"),
    pm = c("atmo_pm2.5_avg", "atmo_pm2.5_avg", "atmo_pm2.5_avg", "atmo_pm2.5_avg", "atmo_pm1_avg", "atmo_pm10_avg"),
    role = c("primary", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity", "pm_size_sensitivity", "pm_size_sensitivity"),
    stringsAsFactors = FALSE)
stopifnot(nrow(equation_spec) == 6L, identical(equation_spec$equation_id, 1:6),
    sum(equation_spec$role == "primary") == 1L)
# ---- Setup: packages, paths and run guards ----
suppressPackageStartupMessages({
    library(ggplot2)
    library(gridExtra)
})

resolve_project_root <- function() {
  arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  candidates <- c(if(length(arg)) file.path(dirname(sub("^--file=", "", arg[1])), ".."), getwd(), file.path(getwd(), ".."))
  for(root in unique(candidates)) {
    root <- normalizePath(root, winslash = "/", mustWork = FALSE)
    if(file.exists(file.path(root, "output/merged_all_11participants_8min.csv"))) return(root)
  }
  stop("Cannot find output/merged_all_11participants_8min.csv; run from the repository or scripts folder.")
}

required_packages <- c("ggplot2", "gridExtra", "car", "nlme", "clubSandwich")

missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)

grDevices::pdf(file = NULL)

PROJECT_ROOT <- resolve_project_root()

RAW_DATA_PATH <- file.path(PROJECT_ROOT, "output/merged_all_11participants_8min.csv")

script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))

H4_SCRIPT_PATH <- if (length(script_arg) && file.exists(script_arg[1])) script_arg[1] else file.path(PROJECT_ROOT, "scripts/H4_multivariate.R")

SCRIPT_DIR <- if (length(script_arg)) dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE)) else file.path(PROJECT_ROOT, "scripts")

H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))

# All H4 writes stay under this results folder; diagnostics remain in its _work subfolder.
RESULT_DIR <- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results")

OUT_DIR <- file.path(RESULT_DIR, "_work")

dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

OUT_CSV <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")

AUDIT_PNG <- file.path(OUT_DIR, "H4_All_Variables_Audit.png")

AUDIT_PDF <- file.path(OUT_DIR, "H4_All_Variables_Audit.pdf")

STAGE_SUMMARY_CSV <- file.path(OUT_DIR, "H4_Audit_Stage_Summary.csv")

INTEGRATION_CSV <- file.path(OUT_DIR, "H4_Integration_Readiness.csv")

STEP_CATEGORY_CSV <- file.path(OUT_DIR, "H4_Step_Category_Counts.csv")

FINAL_OUTCOME_COUNTS_CSV <- file.path(OUT_DIR, "H4_Final_Outcome_Counts.csv")

TRANSPARENCY_MD <- file.path(OUT_DIR, "H4_Transparency_Report.md")

FORMULA_TXT <- file.path(OUT_DIR, "H4_Multivariate_Formula.txt")

H4_DOMAINS <- list(Acoustic = "ucm_SND_dBA", Thermal = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS"), Index = c("ucm_HUMIDEX",
    "ucm_PET", "ucm_UTCI", "ucm_OPT"), Radiation = c("ucm_MRT", "ucm_SUN_Gh", "SVF_Holmer"),
    Pollution = c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg"), Light = c("lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg"),
    Greenery = "gvi_50m")
H4_FLOW_DOMAIN_ORDER <- c("Thermal", "Index", "Acoustic", "Radiation", "Pollution", "Light", "Greenery")

# ---- Step 4: retain candidates, specify alternatives, check complete equation designs ----
H4_STEP4_THERMAL_CATEGORIES <- c("Thermal", "Index")


# ---- Analysis specification and input validation ----
# =============================================================================
# Specification
# Physiological and ocular outcomes, exposure definitions and analysis settings.
# =============================================================================
H4_SPEC <- list(participants = c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"), phases = c("BikeU",
    "BikeG", "WalkU", "WalkG"),
    outcomes = list(Physiological_Autonomic = c("empatica_heart_rate",
    "empatica_eda_tonic", "empatica_eda_phasic", "empatica_skin_temperature", "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd",
    "empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_lfnu", "empatica_hrv_fd_hfnu",
    "empatica_hrv_fd_vlf", "empatica_hrv_fd_total_power"), Physiological_Ocular = c("eyetracker_pupil_diameter_avg", "eyetracker_pupil_change_rate",
    "eyetracker_blink_duration_s", "eyetracker_fixation_duration_s", "eyetracker_fixation_rate", "eyetracker_saccade_duration_s",
    "eyetracker_saccade_amplitude", "eyetracker_saccade_peak_velocity", "eyetracker_gaze_velocity", "eyetracker_gaze_dispersion",
    "eyetracker_distance_from_center", "eyetracker_gaze_centrality", "eyetracker_eyelid_aperture_avg")), hrv_log = c("empatica_hrv_td_sdnn",
    "empatica_hrv_td_rmssd", "empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_vlf",
    "empatica_hrv_fd_total_power"), hrv_fd = c("empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio",
    "empatica_hrv_fd_lfnu", "empatica_hrv_fd_hfnu", "empatica_hrv_fd_vlf", "empatica_hrv_fd_total_power"), vif_threshold = 5, expected_epochs = 49L)

H4_SPEC$h4_1_outcomes <- unlist(H4_SPEC$outcomes, use.names = FALSE)

H4_SPEC$all_outcomes <- unlist(H4_SPEC$outcomes, use.names = FALSE)

# Outcome transformations follow scripts/Normalization_H1toH4.ipynb (and _physio.csv): HRV = ln(x) for x > 0 (rows <= 0
# dropped), never ln(1 + x); other outcomes native (Laborde, Mosley & Thayer 2017; Task Force 1996).
H4_SPEC$outcome_transform <- setNames(ifelse(H4_SPEC$all_outcomes %in% H4_SPEC$hrv_log, "natural log", "native"), H4_SPEC$all_outcomes)

H4_SPEC$exposure_centered <- c(ucm_UTCI = "PC_UTCI", ucm_SND_dBA = "PC_dBA", atmo_pm2.5_avg = "PC_PM25", lys_lux_avg = "PC_Lux",
    gvi_50m = "PC_GVI")

H4_SPEC$bilateral_sources <- list(atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"))

average_sources <- list(atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
    atmo_pm2.5_avg = H4_SPEC$bilateral_sources$atmo_pm2.5_avg, atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10",
        "atmo_lys_atmotube_right__atmotube_pm10"), lys_lux_avg = H4_SPEC$bilateral_sources$lys_lux_avg, lys_medi_avg = c("atmo_lys_LYS1__lys_medi",
        "atmo_lys_LYS2__lys_medi"), lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))

PARTICIPANTS <- H4_SPEC$participants

CORE_PHASES <- H4_SPEC$phases

SOUND_QC_COLUMNS <- c("segment", "end_time_s", "window_duration_s", "is_complete_10s_window", "phase_start_offset_s", "yamnet_frame_count", "yamnet_threshold",
    "original_sample_rate_hz", "frequency_analysis_min_hz", "frequency_analysis_max_hz", "frequency_analysis_full_20khz_coverage")

SOUND_CATEGORY_PROP_COLUMNS <- c("wind_prop", "rural_natural_prop", "vehicle_prop", "urban_manmade_neutral_prop", "urban_manmade_positive_prop", "urban_manmade_negative_prop", "mechanisms_prop", "unidentify_prop")

SVF_EXPOSURE_COLUMNS <- c("Sky_%", "SVF_Holmer", "Tree_%", "Plant_%", "Grass_%", "Combined_Vegetation_%", "Building_%", "Wall_%", "Ceiling_%")

SVF_QC_COLUMNS <- c("Filename", "Timestamp", "Camera", "Calibration", "Calibration_Table", "Run_Config_Signature", "Calibration_QC",
    "Calibration_Ref_Radius_px", "Raw_Lens_Radius_px", "Rectified_Lens_Radius_px", "Square_Hemisphere_Crop", "SVF_Method",
    "SVF_Rings", "Pitch_Roll_Correction", "Model", "Image_Path", "Segmented_Image_Path", "telemetry_matched", "Manual_Mask_Path",
    "Manual_Sky_IoU", "Manual_Sky_Dice", "Manual_Pixel_Accuracy", "Manual_SVF_Holmer", "SVF_Abs_Error_vs_Manual",
    "SVF_Frames_In_Window", "SVF_Aggregation_Method", "SVF_Selection_Method", "SVF_Status")

EXPECTED_SOUND_FREQUENCY_COLUMNS <- c("dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz", "freq_prop_20_125",
    "freq_prop_125_1000", "freq_prop_1000_4000", "freq_prop_4000_8000", "freq_prop_8000_20000", "octave_prop_31_5_hz", "octave_prop_63_0_hz",
    "octave_prop_125_0_hz", "octave_prop_250_0_hz", "octave_prop_500_0_hz", "octave_prop_1000_0_hz", "octave_prop_2000_0_hz",
    "octave_prop_4000_0_hz", "octave_prop_8000_0_hz")

H4_PHASE_SUM_COLS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")

source(file.path(SCRIPT_DIR, "H4_core.R"), local = FALSE)

run_h4 <- function() {
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
        if (!file.exists(OUT_CSV)) stop("H4_STEP5_ONLY=1 but no saved Step 4 audit at: ", OUT_CSV)
        cat("[Fast Track] Found existing validated Step 4 audit at:", OUT_CSV, "\n")
        step5_result <- h4_1_fit()
        render_h4_faceted_flow()
        h4_write_results(read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), step5_result)
        cat("H4 multivariate Step 5 execution and faceted flow PDF update completed successfully.\n")
        quit(save = "no", status = 0)
    }
    h4_run_full_pipeline()
}

if (sys.nframe() == 0L) run_h4()

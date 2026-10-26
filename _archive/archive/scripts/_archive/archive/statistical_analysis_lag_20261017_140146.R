# ==============================================================================
# SCRIPT: statistical_analysis_lag.R
# PURPOSE: Auditable participant-phase inference and time-lagged exposure modeling
#          for Paper 3, evaluating lagged behavior of Greenness (GVI) and
#          environmental stressors on physiological & ocular responses.
#
# KEY ANALYTICAL COMPONENTS:
#   1. H1/H3 Factorial Contrasts: REML participant-phase-mean LMMs (Mode x Environment).
#   2. H2 Psychophysiological Concurrence: Person-mean-centered LMMs (Van Doren et al. 2021).
#   3. H4 Concurrent Environmental Stressors: Single-predictor REML LMMs.
#   4. H4 Lagged & Cumulative Environmental Dynamics (Section 6B):
#      - Discrete Time Lags: 0s (concurrent), 10s, 20s, 30s, 60s, 120s
#      - Rolling Cumulative Windows: 30s, 60s, 120s past moving averages
#      - Model: outcome_z ~ Mode + pred_lag_z + (1 | ParticipantPhaseID)
#               with serial autocorrelation corAR1(form = ~ time_10s_step | ParticipantPhaseID)
#      - Evaluated across Greenness (GVI 50m, tree, grass, point GVI), Thermal (UTCI,
#        PET, air temp, MRT), Solar (Clearness Index, daylight lux, global solar),
#        Acoustic (dBA, vehicle noise, human voices), and Air Quality (PM2.5).
#   5. All outputs saved directly to: output/statistical_analysis_lag/
# ==============================================================================

suppressPackageStartupMessages({
  library(nlme)
  library(emmeans)
  library(ggplot2)
})
emm_options(msg.interaction = FALSE)
set.seed(20260717)

# 1. Configuration & dictionaries ---------------------------------------------
WD <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
PROJECT_ROOT <- if (basename(WD) == "scripts") dirname(WD) else WD
SIBLING_DATA_ROOT <- file.path(dirname(PROJECT_ROOT), "Paper3_Github")

RAW_PATH <- Sys.getenv("PAPER3_RAW_PATH", file.path(PROJECT_ROOT, "output", "merged_all_11participants_8min.csv"))
GVI_PATH <- file.path(PROJECT_ROOT, "output", "GVI_output", "merged_all_11participants_8min_GVI.csv")
KEY_PATH <- Sys.getenv("PAPER3_KEY_PATH", file.path(SIBLING_DATA_ROOT, "output", "key.csv"))
OUT_DIR <- Sys.getenv("PAPER3_OUT_DIR", unset = file.path(PROJECT_ROOT, "output", "statistical_analysis_lag"))
SCRIPT_PATH <- Sys.getenv("PAPER3_SCRIPT_PATH", unset = file.path(PROJECT_ROOT, "scripts", "statistical_analysis_lag.R"))
MAKE_FIGURES <- tolower(Sys.getenv("PAPER3_MAKE_FIGURES", unset = "false")) %in% c("1", "true", "yes")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

PARTICIPANTS   <- c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17")
CORE_PHASES    <- c("BikeU", "WalkU", "BikeG", "WalkG")
H4_PHASES      <- c(CORE_PHASES, "Tram")
MATCHED_CAP_SEC <- 8 * 60

OUTCOMES <- list(
  Psychological = c("questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5",
                    "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"),
  Physiological_Autonomic = c("empatica_heart_rate", "empatica_eda_tonic", "empatica_eda_phasic",
                              "empatica_skin_temperature", "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd"),
  Physiological_Ocular = c("eyetracker_pupil_diameter_avg", "eyetracker_pupil_change_rate",
                           "eyetracker_blink_duration_s", "eyetracker_fixation_duration_s",
                           "eyetracker_fixation_rate", "eyetracker_saccade_duration_s",
                           "eyetracker_saccade_amplitude", "eyetracker_saccade_peak_velocity",
                           "eyetracker_gaze_velocity", "eyetracker_gaze_dispersion",
                           "eyetracker_distance_from_center", "eyetracker_gaze_centrality",
                           "eyetracker_eyelid_aperture_avg")
)
all_outcomes      <- unlist(OUTCOMES, use.names = FALSE)
outcome_group_map <- setNames(rep(names(OUTCOMES), lengths(OUTCOMES)), all_outcomes)

clean_labels <- c(
  # Psychological Surveys
  "questionnaire_current_comfort_1_7"   = "Survey: General Comfort (1-7)",
  "questionnaire_pleasantness_1_5"      = "Survey: Pleasantness (1-5)",
  "questionnaire_stai6_mean_1_5"        = "Survey: State Anxiety (STAI-6)",
  "questionnaire_prs11_total_mean_1_5"  = "Survey: Restorativeness (PRS-11)",
  
  # Empatica EmbracePlus (Autonomic Physiology)
  "empatica_heart_rate"                 = "Empatica: Heart Rate (bpm)",
  "empatica_eda_tonic"                  = "Empatica: EDA Tonic Level (SCL)",
  "empatica_eda_phasic"                 = "Empatica: EDA Phasic (SCR)",
  "empatica_skin_temperature"           = "Empatica: Skin Temperature (°C)",
  "empatica_hrv_td_sdnn"                = "Empatica: HRV (SDNN)",
  "empatica_hrv_td_rmssd"               = "Empatica: HRV (RMSSD)",
  
  # Pupil Labs Neon (Eye Tracking / Ocular)
  "eyetracker_pupil_diameter_avg"       = "Pupil Labs: Pupil Diameter (mm)",
  "eyetracker_pupil_change_rate"        = "Pupil Labs: Pupil Change Rate",
  "eyetracker_blink_duration_s"         = "Pupil Labs: Blink Duration (s)",
  "eyetracker_fixation_duration_s"      = "Pupil Labs: Fixation Duration (s)",
  "eyetracker_fixation_rate"            = "Pupil Labs: Fixation Rate (/s)",
  "eyetracker_saccade_duration_s"       = "Pupil Labs: Saccade Duration (s)",
  "eyetracker_saccade_amplitude"        = "Pupil Labs: Saccade Amplitude (°)",
  "eyetracker_saccade_peak_velocity"    = "Pupil Labs: Saccade Peak Velocity (°/s)",
  "eyetracker_gaze_velocity"            = "Pupil Labs: Gaze Velocity (°/s)",
  "eyetracker_gaze_dispersion"          = "Pupil Labs: Gaze Dispersion",
  "eyetracker_gaze_centrality"          = "Pupil Labs: Gaze Centrality",
  "eyetracker_distance_from_center"     = "Pupil Labs: Gaze Distance from Center (px)",
  "eyetracker_eyelid_aperture_avg"      = "Pupil Labs: Eyelid Aperture (mm)",

  # Environmental Predictors - Explicit Sensor Platform Designation
  # UCM Backpack: Thermal & Microclimatic
  "ucm_PET"                             = "UCM: PET Thermal Index (°C)",
  "ucm_PET_SR"                          = "UCM: PET (Solar Radiation, °C)",
  "ucm_UTCI"                            = "UCM: UTCI Thermal Index (°C)",
  "ucm_UTCI_SR"                         = "UCM: UTCI (Solar Radiation, °C)",
  "ucm_AIR_temp"                        = "UCM: Air Temperature (°C)",
  "ucm_AIR_RH"                          = "UCM: Relative Humidity (%)",
  "ucm_AIR_T_bot"                       = "UCM: Air Temp Bottom (°C)",
  "ucm_AIR_T_mid"                       = "UCM: Air Temp Middle (°C)",
  "ucm_AIR_T_top"                       = "UCM: Air Temp Top (°C)",
  "ucm_AH"                              = "UCM: Absolute Humidity (g/m³)",
  "ucm_HUMIDEX"                         = "UCM: Humidex Thermal Index",
  "ucm_HUMIDEX_SR"                      = "UCM: Humidex (Solar Radiation)",
  "ucm_MRT"                             = "UCM: Mean Radiant Temp (°C)",
  "ucm_MRT_S"                           = "UCM: Mean Radiant Temp (Solar, °C)",
  "ucm_OPT"                             = "UCM: Operative Temp (°C)",
  "ucm_WIND_AWA"                        = "UCM: Apparent Wind Angle (°)",
  "ucm_WIND_AWS"                        = "UCM: Apparent Wind Speed (m/s)",
  "ucm_WIND_TWD"                        = "UCM: True Wind Direction (°)",
  "ucm_WIND_TWS"                        = "UCM: True Wind Speed (m/s)",

  # UCM Backpack: Solar, Radiation & Kinematics
  "ucm_SUN_Gh"                          = "UCM: Global Solar Rad (W/m²)",
  "ucm_SUN_alt"                         = "UCM: Sun Altitude (°)",
  "ucm_SUN_az"                          = "UCM: Solar Azimuth (°)",
  "Clearness_Index"                     = "UCM: Clearness Index (kt)",
  "ucm_IR_up"                           = "UCM: Thermal Radiation Up (W/m²)",
  "ucm_IR_down"                         = "UCM: Thermal Radiation Down (W/m²)",
  "ucm_IR_front"                        = "UCM: Thermal Radiation Front (W/m²)",
  "ucm_IR_back"                         = "UCM: Thermal Radiation Back (W/m²)",
  "ucm_IR_left"                         = "UCM: Thermal Radiation Left (W/m²)",
  "ucm_IR_right"                        = "UCM: Thermal Radiation Right (W/m²)",
  "ucm_IR_spot_sky"                     = "UCM: IR Surface Temp Sky (°C)",
  "ucm_IR_spot_gnd"                     = "UCM: IR Surface Temp Ground (°C)",
  "ucm_IR_spot_left"                    = "UCM: IR Surface Temp Left (°C)",
  "ucm_IR_spot_right"                   = "UCM: IR Surface Temp Right (°C)",
  "ucm_SND_dBA"                         = "UCM: Acoustic Noise (dBA)",
  "ucm_GPS_speed_kmh"                   = "UCM: Speed (km/h)",
  "ucm_GPS_alt"                         = "UCM: Altitude (m)",
  "ucm_GPS_hdg"                         = "UCM: GPS Heading (°)",
  "ucm_MAG_hdg"                         = "UCM: Magnetic Heading (°)",
  "ucm_GPS_HDOP"                        = "UCM: GPS HDOP",

  # Atmotube (Averaged Researcher Left & Right)
  "atmo_pm1.0_avg"                      = "Atmotube: PM1.0 (µg/m³)",
  "atmo_pm2.5_avg"                      = "Atmotube: PM2.5 (µg/m³)",
  "atmo_pm10_avg"                       = "Atmotube: PM10 (µg/m³)",
  "atmo_temperature_avg"                = "Atmotube: Air Temp (°C)",
  "atmo_humidity_avg"                   = "Atmotube: Relative Humidity (%)",

  # LYS Button (Averaged Participant LYS1 & Researcher LYS2)
  "lys_lux_avg"                         = "LYS: Illuminance (lux)",
  "lys_rgbb_avg"                        = "LYS: Blue Irradiance (rgbb)",
  "lys_rgbg_avg"                        = "LYS: Green Irradiance (rgbg)",
  "lys_rgbr_avg"                        = "LYS: Red Irradiance (rgbr)",
  "lys_kelvin_avg"                      = "LYS: Color Temperature (K)",
  "lys_medi_avg"                        = "LYS: Melanopic EDI (medi)",

  # GVI (Eye-Level 360° Visual Greenness)
  "gvi_50m"                             = "GVI: Green View Index (50m)",
  "gvi_tree_50m"                        = "GVI: Tree Canopy (50m)",
  "gvi_grass_50m"                       = "GVI: Grass View Index (50m)",
  "gvi_plant_50m"                       = "GVI: Total Plant View Index (50m)",
  "gvi_point_gvi"                       = "GVI: Point Green View Index",
  "gvi_point_tree"                      = "GVI: Point Tree Canopy",
  "gvi_phase_mean"                      = "GVI: Phase Mean GVI",
  "tree_phase_mean"                     = "GVI: Phase Mean Tree Canopy",

  # YAMNet (Deep Learning Sound Event Classification)
  "sound_prop_vehicle"                  = "YAMNet: Vehicle Sound Prop",
  "sound_prop_urban_manmade"            = "YAMNet: Urban Sound Prop",
  "sound_prop_rural_natural"            = "YAMNet: Natural Sound Prop",
  "sound_prop_human_activity"           = "YAMNet: Human Activity Sound Prop",
  "sound_prop_wind"                     = "YAMNet: Wind Sound Prop",
  "sound_prop_mechanisms"               = "YAMNet: Machinery Sound Prop",
  "sound_prop_unidentify"               = "YAMNet: Unidentified Sound Prop",
  "sound_level_dbfs"                    = "YAMNet: Audio Level (dBFS)"
)

get_pred_sensor <- function(p) {
  if (grepl("^(ucm_|Clearness_Index$)", p)) return("UCM")
  if (grepl("^atmo_", p)) return("Atmotube")
  if (grepl("^lys_", p)) return("LYS")
  if (grepl("^(gvi_|tree_)", p)) return("GVI")
  if (grepl("^sound_", p)) return("YAMNet")
  "Environmental"
}

get_outc_sensor <- function(o) {
  if (grepl("^empatica_", o)) return("Empatica EmbracePlus")
  if (grepl("^eyetracker_", o)) return("Pupil Labs Neon")
  if (grepl("^questionnaire_", o)) return("Psychological Survey")
  "Physiological"
}

# 2. Reusable Helper Functions -------------------------------------------------
mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)
safe_rbind <- function(x) if (length(x) > 0) do.call(rbind, x) else data.frame()

safe_write_csv <- function(data, path) {
  res <- tryCatch({
    write.csv(data, path, row.names = FALSE, na = "")
    TRUE
  }, error = function(e) {
    warning(sprintf("File locked: %s. Writing fallback copy...", path))
    FALSE
  })
  if (!res) {
    alt_path <- sub("\\.csv$", "_latest.csv", path)
    tryCatch(write.csv(data, alt_path, row.names = FALSE, na = ""), error = function(e) NULL)
  }
}

fit_phase_lmm <- function(fml, data, method = "REML") {
  tryCatch(
    lme(as.formula(fml), random = ~ 1 | ParticipantID, data = data, method = method,
        na.action = na.omit,
        control = lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = TRUE)),
    error = function(e) NULL
  )
}

model_data_ok <- function(data, outcome, min_rows, min_participants) {
  x <- data[[outcome]]
  nrow(data) >= min_rows && length(unique(data$ParticipantID)) >= min_participants &&
    is.finite(sd(x, na.rm = TRUE)) && sd(x, na.rm = TRUE) != 0
}

within_person_z <- function(x, id) {
  ave(as.numeric(x), id, FUN = function(v) {
    m <- mean(v, na.rm = TRUE)
    s <- sd(v, na.rm = TRUE)
    if (!is.finite(s) || s == 0) rep(NA_real_, length(v)) else (v - m) / s
  })
}

discrete_lag <- function(x, k) {
  n <- length(x)
  if (k == 0) return(x)
  if (n <= k) return(rep(NA_real_, n))
  c(rep(NA_real_, k), x[1:(n - k)])
}

roll_mean_right <- function(x, w) {
  n <- length(x)
  if (n < w) return(rep(NA_real_, n))
  res <- rep(NA_real_, n)
  cs <- cumsum(ifelse(is.na(x), 0, x))
  cn <- cumsum(!is.na(x))
  for (i in w:n) {
    sw <- cs[i] - if (i == w) 0 else cs[i - w]
    cw <- cn[i] - if (i == w) 0 else cn[i - w]
    if (cw >= ceiling(w / 2)) res[i] <- sw / cw
  }
  res
}

add_group_adjustments <- function(tab, group_col) {
  if (nrow(tab) == 0) return(tab)
  groups <- tab[[group_col]]
  tab$q_FDR <- ave(tab$p_value, groups, FUN = function(p) p.adjust(p, method = "BH"))
  tab
}

model_cohens_d <- function(cnt, fit) {
  if (!inherits(fit, "lme")) {
    return(c(d = NA_real_, low = NA_real_, high = NA_real_))
  }
  vars <- as.numeric(VarCorr(fit)[, "Variance"])
  vars <- vars[is.finite(vars)]
  rand_var <- if (length(vars) > 1) sum(head(vars, -1L)) else 0
  res_var <- sigma(fit)^2
  sd_tot <- sqrt(rand_var + res_var)
  if (!is.finite(sd_tot) || sd_tot <= 0) {
    return(c(d = NA_real_, low = NA_real_, high = NA_real_))
  }
  c(d = cnt$estimate / sd_tot, low = cnt$lower.CL / sd_tot, high = cnt$upper.CL / sd_tot)
}

interaction_summary <- function(fit) {
  a <- tryCatch(as.data.frame(anova(fit))["Mode:Environment", , drop = FALSE],
                error = function(e) NULL)
  if (is.null(a) || nrow(a) == 0) return("NA")
  p <- suppressWarnings(as.numeric(a[["p-value"]][1]))
  f <- suppressWarnings(as.numeric(a[["F-value"]][1]))
  df <- suppressWarnings(as.numeric(a[["denDF"]][1]))
  if (is.finite(p)) {
    sprintf("F(1,%s)=%.2f, p=%.4f%s",
            ifelse(is.finite(df), as.character(round(df)), "NA"),
            ifelse(is.finite(f), f, NA_real_), p,
            ifelse(p < 0.05, " (sig)", " (ns)"))
  } else "NA"
}

# Explicit simple contrasts per user specification
extract_h1_h3 <- function(fit, data, raw_col, outcome_name, outcome_group, condition_name,
                          duration_label, norm_label, family_set_name, fml_str) {
  if (is.null(fit)) return(list(h1 = list(), h3 = list()))

  rg <- ref_grid(fit)
  em <- emmeans(rg, ~ Mode * Environment)
  cell_df <- as.data.frame(em)
  cell_map <- setNames(cell_df$emmean, paste(cell_df$Mode, cell_df$Environment, sep = ":"))

  # H1: Green - Urban within Bike; Green - Urban within Walk
  # H3: Walk - Bike within Urban; Walk - Bike within Green
  simple_h1 <- contrast(em, method = "revpairwise", by = "Mode", adjust = "none")
  simple_h3 <- contrast(em, method = "pairwise", by = "Environment", adjust = "none")

  c_h1 <- as.data.frame(confint(simple_h1))
  c_h3 <- as.data.frame(confint(simple_h3))
  t_h1 <- as.data.frame(test(simple_h1))
  t_h3 <- as.data.frame(test(simple_h3))

  h1_df <- merge(c_h1, t_h1[, c("Mode", "contrast", "t.ratio", "p.value")],
                 by = c("Mode", "contrast"), all.x = TRUE)
  h3_df <- merge(c_h3, t_h3[, c("Environment", "contrast", "t.ratio", "p.value")],
                 by = c("Environment", "contrast"), all.x = TRUE)

  int_text <- interaction_summary(fit)

  h1_out <- list()
  for (i in seq_len(nrow(h1_df))) {
    row <- h1_df[i, ]
    sub_hyp <- ifelse(row$Mode == "Bike", "H1_Bike", "H1_Walk")
    contrast_name <- sprintf("Green - Urban within %s", row$Mode)
    cnt_obj <- simple_h1[simple_h1@grid$Mode == row$Mode]
    d_vals <- model_cohens_d(row, fit)

    ref_mode_env <- paste(row$Mode, "Urban", sep = ":")
    cmp_mode_env <- paste(row$Mode, "Green", sep = ":")
    ref_mu <- cell_map[[ref_mode_env]]
    cmp_mu <- cell_map[[cmp_mode_env]]
    ref_n <- sum(data$Mode == row$Mode & data$Environment == "Urban", na.rm = TRUE)
    cmp_n <- sum(data$Mode == row$Mode & data$Environment == "Green", na.rm = TRUE)

    h1_out[[length(h1_out) + 1]] <- data.frame(
      Hypothesis = "H1", Sub_Hypothesis = sub_hyp, Contrast_ID = sub_hyp,
      Contrast = contrast_name, Outcome_Group = outcome_group, Outcome = outcome_name,
      Condition = condition_name, Duration = duration_label, Predictor = "Environment",
      Result = sprintf("%s: %s vs %s in %s", outcome_name, "Green", "Urban", row$Mode),
      Normalization = norm_label, Family_Set = family_set_name, Model_Formula = fml_str,
      Interaction_Test = int_text, Estimate_SD = row$estimate, SE = row$SE, df = row$df,
      p_value = row$p.value, Cohens_d_LMM = d_vals["d"],
      CI95_low = d_vals["low"], CI95_high = d_vals["high"],
      Reference_Mean = ref_mu, Comparison_Mean = cmp_mu,
      Reference_N = ref_n, Comparison_N = cmp_n, stringsAsFactors = FALSE
    )
  }

  h3_out <- list()
  for (i in seq_len(nrow(h3_df))) {
    row <- h3_df[i, ]
    sub_hyp <- ifelse(row$Environment == "Urban", "H3_Urban", "H3_Green")
    contrast_name <- sprintf("Walk - Bike within %s", row$Environment)
    cnt_obj <- simple_h3[simple_h3@grid$Environment == row$Environment]
    d_vals <- model_cohens_d(row, fit)

    ref_mode_env <- paste("Bike", row$Environment, sep = ":")
    cmp_mode_env <- paste("Walk", row$Environment, sep = ":")
    ref_mu <- cell_map[[ref_mode_env]]
    cmp_mu <- cell_map[[cmp_mode_env]]
    ref_n <- sum(data$Mode == "Bike" & data$Environment == row$Environment, na.rm = TRUE)
    cmp_n <- sum(data$Mode == "Walk" & data$Environment == row$Environment, na.rm = TRUE)

    h3_out[[length(h3_out) + 1]] <- data.frame(
      Hypothesis = "H3", Sub_Hypothesis = sub_hyp, Contrast_ID = sub_hyp,
      Contrast = contrast_name, Outcome_Group = outcome_group, Outcome = outcome_name,
      Condition = condition_name, Duration = duration_label, Predictor = "Mode",
      Result = sprintf("%s: %s vs %s in %s", outcome_name, "Walk", "Bike", row$Environment),
      Normalization = norm_label, Family_Set = family_set_name, Model_Formula = fml_str,
      Interaction_Test = int_text, Estimate_SD = row$estimate, SE = row$SE, df = row$df,
      p_value = row$p.value, Cohens_d_LMM = d_vals["d"],
      CI95_low = d_vals["low"], CI95_high = d_vals["high"],
      Reference_Mean = ref_mu, Comparison_Mean = cmp_mu,
      Reference_N = ref_n, Comparison_N = cmp_n, stringsAsFactors = FALSE
    )
  }

  list(h1 = h1_out, h3 = h3_out)
}

adjust_by_family <- function(tab, family_size_map = NULL) {
  if (nrow(tab) == 0) return(tab)
  tab$Correction_Family <- paste(tab$Hypothesis, tab$Family_Set, tab$Contrast_ID,
                                 tab$Normalization, sep = "__")
  tab$q_FDR <- NA_real_
  tab$Family_Size <- NA_integer_

  for (fam in unique(tab$Correction_Family)) {
    idx <- which(tab$Correction_Family == fam)
    p <- tab$p_value[idx]
    fs <- as.character(tab$Family_Set[idx[1]])
    planned_n <- if (!is.null(family_size_map) && fs %in% names(family_size_map)) {
      as.integer(family_size_map[[fs]])
    } else {
      sum(!is.na(p))
    }
    planned_n <- max(planned_n, sum(!is.na(p)))
    tab$q_FDR[idx] <- p.adjust(p, method = "BH")
    tab$Family_Size[idx] <- planned_n
  }

  tab$FDR_significance <- !is.na(tab$q_FDR) & tab$q_FDR < 0.05
  tab
}

hms_to_sec <- function(x) {
  x <- as.character(x)
  out <- rep(NA_real_, length(x))
  good <- !is.na(x) & nzchar(x)
  if (any(good)) {
    sp <- strsplit(x[good], ":", fixed = TRUE)
    out[good] <- vapply(sp, function(z) {
      if (length(z) != 3) return(NA_real_)
      as.numeric(z[1]) * 3600 + as.numeric(z[2]) * 60 + as.numeric(z[3])
    }, numeric(1))
  }
  out
}

harmonize_schema <- function(data, key_path) {
  if (file.exists(key_path) && all(c("ParticipantID", "PhaseID", "Datetime") %in% names(data))) {
    key <- read.csv(key_path, stringsAsFactors = FALSE, check.names = FALSE)
    ref_phases <- c("BikeU", "WalkU", "BikeG", "WalkG", "Tram")
    needed_key <- c("Participant_ID", "Indoor_start", "Indoor_end", paste0(ref_phases, "_start"))
    if (all(needed_key %in% names(key))) {
      row_sec <- hms_to_sec(format(as.POSIXct(data$Datetime, tz = "UTC"), "%H:%M:%S"))
      blank_phase <- is.na(data$PhaseID) | trimws(as.character(data$PhaseID)) == ""
      circular_diff <- function(a, b) {
        d <- a - b
        d[d > 43200] <- d[d > 43200] - 86400
        d[d < -43200] <- d[d < -43200] + 86400
        d
      }

      for (i in seq_len(nrow(key))) {
        pid_raw <- trimws(as.character(key$Participant_ID[i]))
        pid <- ifelse(grepl("^P", pid_raw, ignore.case = TRUE), toupper(pid_raw), paste0("P", pid_raw))
        diffs <- numeric(0)

        for (ph in ref_phases) {
          key_start <- hms_to_sec(key[[paste0(ph, "_start")]][i])
          idx_ph <- data$ParticipantID == pid & data$PhaseID == ph & is.finite(row_sec)
          if (!is.finite(key_start) || !any(idx_ph)) next
          observed_start <- min(row_sec[idx_ph], na.rm = TRUE)
          diffs <- c(diffs, circular_diff(observed_start, key_start))
        }

        if (length(diffs) < 3) next
        offset_spread <- max(diffs, na.rm = TRUE) - min(diffs, na.rm = TRUE)
        if (!is.finite(offset_spread) || offset_spread > 30) next
        offset <- median(diffs, na.rm = TRUE)
        st <- hms_to_sec(key$Indoor_start[i])
        en <- hms_to_sec(key$Indoor_end[i])
        if (!is.finite(st) || !is.finite(en)) next
        st_aligned <- (st + offset) %% 86400
        en_aligned <- (en + offset) %% 86400

        tol <- 5
        if (st_aligned <= en_aligned) {
          in_time <- row_sec >= (st_aligned - tol) & row_sec <= (en_aligned + tol)
        } else {
          in_time <- row_sec >= (st_aligned - tol) | row_sec <= (en_aligned + tol)
        }
        hit <- blank_phase & data$ParticipantID == pid & in_time
        data$PhaseID[hit] <- "Indoor"
      }
    }
  }
  data
}

# 3. Data Loading & Feature Engineering ----------------------------------------
cat("[1/6] Loading and formatting dataset...\n")
if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
df <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
df$ParticipantID <- as.character(df$ParticipantID)
df$PhaseID <- as.character(df$PhaseID)
df <- harmonize_schema(df, KEY_PATH)

# Merge Eye-Level GVI metrics if available from GVI_output
if (file.exists(GVI_PATH)) {
  gvi_df <- read.csv(GVI_PATH, stringsAsFactors = FALSE, check.names = FALSE)
  gvi_add_cols <- setdiff(c("gvi_50m", "gvi_tree_50m", "gvi_grass_50m", "gvi_plant_50m", "gvi_match_dist_m"), names(df))
  gvi_add_cols <- intersect(gvi_add_cols, names(gvi_df))
  if (length(gvi_add_cols) > 0) {
    cat("   Merging Eye-Level GVI columns from:", GVI_PATH, "\n")
    df <- merge(df, gvi_df[, c("ParticipantID", "PhaseID", "Datetime", gvi_add_cols)],
                by = c("ParticipantID", "PhaseID", "Datetime"), all.x = TRUE)
  }
}

missing_participants <- setdiff(PARTICIPANTS, unique(df$ParticipantID))
if (length(missing_participants) > 0) {
  stop("Verified 11-participant input is incomplete. Missing: ",
       paste(missing_participants, collapse = ", "))
}
phase_grid <- expand.grid(ParticipantID = PARTICIPANTS, PhaseID = CORE_PHASES,
                          stringsAsFactors = FALSE)
present_grid <- unique(df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES,
                          c("ParticipantID", "PhaseID")])
grid_key <- paste(phase_grid$ParticipantID, phase_grid$PhaseID, sep = "::")
present_key <- paste(present_grid$ParticipantID, present_grid$PhaseID, sep = "::")
missing_cells <- phase_grid[!grid_key %in% present_key, , drop = FALSE]
if (nrow(missing_cells) > 0) {
  stop("Core within-subject design is incomplete; missing participant-phase cells: ",
       paste(paste(missing_cells$ParticipantID, missing_cells$PhaseID, sep = "/"), collapse = ", "))
}

safe_pair_mean <- function(data, left, right) {
  if (!all(c(left, right) %in% names(data))) return(rep(NA_real_, nrow(data)))
  z <- rowMeans(cbind(as.numeric(data[[left]]), as.numeric(data[[right]])), na.rm = TRUE)
  z[is.nan(z)] <- NA_real_
  z
}
pair_map <- list(
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")
)
for (nm in names(pair_map)) df[[nm]] <- do.call(safe_pair_mean, c(list(df), pair_map[[nm]]))

lys_participant_map <- c(
  lys_lux_participant = "atmo_lys_LYS1__lys_lux"
)
for (nm in names(lys_participant_map)) {
  src <- lys_participant_map[[nm]]
  df[[nm]] <- if (src %in% names(df)) as.numeric(df[[src]]) else NA_real_
}

sensor_outcomes <- intersect(c(OUTCOMES$Physiological_Autonomic, OUTCOMES$Physiological_Ocular), names(df))
psych_outcomes  <- intersect(OUTCOMES$Psychological, names(df))

exclude_env_metadata <- c(
  "atmo_lys_Date", "ucm_Date", "ucm_GPS_lat", "ucm_GPS_lon", "ucm_IO_flag",
  "atmo_lys_LYS1__lux_cat", "atmo_lys_LYS2__lux_cat", "ucm_fp", "ucm_GPS_speed_valid_sample_count",
  "sound_class_id", "sound_category_label"
)
all_env_candidates <- grep("^(atmo_|lys_|atmo_lys_|ucm_|gvi_|tree_|sound_|Clearness_Index$)", names(df), value = TRUE)
all_env_candidates <- setdiff(all_env_candidates, exclude_env_metadata)

env_predictors <- character(0)
for (nm in all_env_candidates) {
  val <- suppressWarnings(as.numeric(df[[nm]]))
  if (sum(!is.na(val)) > 50 && length(unique(na.omit(val))) > 1) {
    env_predictors <- c(env_predictors, nm)
  }
}
env_predictors <- unique(c(env_predictors, "atmo_pm2.5_avg", "lys_lux_avg", "Clearness_Index"))
env_predictors <- intersect(env_predictors, names(df))

within_person_vars <- unique(c(sensor_outcomes, env_predictors))
within_person_vars <- intersect(within_person_vars, names(df))
for (outcome in within_person_vars) {
  df[[paste0("wpz__", outcome)]] <- within_person_z(df[[outcome]], df$ParticipantID)
}

route <- df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ]
route$Datetime           <- as.POSIXct(route$Datetime, tz = "UTC")
route$ParticipantID      <- factor(route$ParticipantID, levels = PARTICIPANTS)
route$PhaseID            <- factor(route$PhaseID, levels = CORE_PHASES)
route$Mode               <- factor(ifelse(grepl("^Bike", route$PhaseID), "Bike", "Walk"), levels = c("Bike", "Walk"))
route$Environment        <- factor(ifelse(grepl("U$", route$PhaseID), "Urban", "Green"), levels = c("Urban", "Green"))
route$ParticipantPhaseID <- factor(paste(route$ParticipantID, route$PhaseID, sep = "_"))
route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]

route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
                               FUN = function(x) x - min(x, na.rm = TRUE))
route$time_min   <- route$time_in_phase_sec / 60
route$time_10s_step <- as.numeric(ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
                                      FUN = function(x) round((x - min(x, na.rm = TRUE)) / 10)))
route <- route[!duplicated(paste(route$ParticipantPhaseID, route$time_10s_step)), ]

# Keep Matched 8-minute steady-state window for primary route condition
matched_route <- route[route$time_in_phase_sec <= MATCHED_CAP_SEC, ]
CONDITIONS <- list(Matched_start_8min = matched_route)

# 4. Primary H1 and H3 Planned Contrasts --------------------------------------
cat("[2/6] Evaluating H1 (Green vs Urban) & H3 (Walk vs Bike) planned contrasts...\n")
h1_list <- list()
h3_list <- list()
model_audit <- list()

N_PLANNED_SENSOR_OUTCOMES <- length(sensor_outcomes)
N_PLANNED_PSYCH_OUTCOMES  <- length(psych_outcomes)
N_PLANNED_ALL_OUTCOMES    <- N_PLANNED_SENSOR_OUTCOMES + N_PLANNED_PSYCH_OUTCOMES

for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  family_set <- "Matched8min"
  dur_label <- "Matched_start_8min"

  value_cols <- intersect(c(sensor_outcomes, paste0("wpz__", sensor_outcomes)), names(d_cond))
  sensor_phase <- aggregate(
    d_cond[value_cols],
    by = d_cond[c("ParticipantID", "PhaseID", "Mode", "Environment")],
    FUN = mean_na
  )
  sensor_phase$Mode <- factor(sensor_phase$Mode, levels = c("Bike", "Walk"))
  sensor_phase$Environment <- factor(sensor_phase$Environment, levels = c("Urban", "Green"))

  for (outcome in sensor_outcomes) {
    for (norm_label in c("-", "Within-Person Z-score")) {
      value_col <- if (norm_label == "Within-Person Z-score") paste0("wpz__", outcome) else outcome
      d <- sensor_phase[complete.cases(sensor_phase[, c(value_col, "Mode", "Environment", "ParticipantID")]), ]

      model_cols <- c("Mode", "Environment", "ParticipantID", "outcome_z")
      d$outcome_z <- if (norm_label == "Within-Person Z-score") d[[value_col]] else as.numeric(scale(d[[value_col]]))
      d <- d[complete.cases(d[, model_cols, drop = FALSE]), , drop = FALSE]
      d$ParticipantID <- factor(d$ParticipantID, levels = PARTICIPANTS)

      if (!model_data_ok(d, "outcome_z", 28, 8)) next

      fml <- "outcome_z ~ Mode * Environment"
      fit <- fit_phase_lmm(fml, d, method = "REML")
      ok <- !is.null(fit)
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "Sensor_LMM", Condition = paste(cname, norm_label), Outcome = outcome,
        Status = ifelse(ok, "FIT", "NOT_FIT"), N_rows = nrow(d),
        N_participants = length(unique(d$ParticipantID)),
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "", stringsAsFactors = FALSE
      )
      if (!ok) next

      ex <- extract_h1_h3(
        fit, d, "outcome_z", outcome, outcome_group_map[outcome], cname,
        dur_label, norm_label,
        family_set, sprintf("%s_z ~ Mode * Environment + (1|ParticipantID)", outcome)
      )
      h1_list <- c(h1_list, ex$h1)
      h3_list <- c(h3_list, ex$h3)
    }
  }
}

# Psychological outcomes
for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  dur_label <- "Matched_start_8min"

  psych_src <- d_cond[d_cond$ParticipantID %in% PARTICIPANTS & d_cond$PhaseID %in% CORE_PHASES,
                      unique(c("ParticipantID", "PhaseID", psych_outcomes)), drop = FALSE]
  psych_phase <- if (length(psych_outcomes) > 0 && nrow(psych_src) > 0) {
    aggregate(psych_src[psych_outcomes], by = psych_src[c("ParticipantID", "PhaseID")], FUN = mean_na)
  } else {
    data.frame(ParticipantID = character(0), PhaseID = character(0), stringsAsFactors = FALSE)
  }

  if (nrow(psych_phase) > 0) {
    psych_phase$ParticipantID <- factor(psych_phase$ParticipantID, levels = PARTICIPANTS)
    psych_phase$Mode <- factor(ifelse(grepl("^Bike", psych_phase$PhaseID), "Bike", "Walk"), levels = c("Bike", "Walk"))
    psych_phase$Environment <- factor(ifelse(grepl("U$", psych_phase$PhaseID), "Urban", "Green"), levels = c("Urban", "Green"))
    for (outcome in psych_outcomes) {
      psych_phase[[paste0("wpz__", outcome)]] <- within_person_z(psych_phase[[outcome]], psych_phase$ParticipantID)
    }
  }

  for (outcome in psych_outcomes) {
    for (norm_label in c("-", "Within-Person Z-score")) {
      value_col <- if (norm_label == "Within-Person Z-score") paste0("wpz__", outcome) else outcome
      d <- psych_phase[complete.cases(psych_phase[, c(value_col, "Mode", "Environment", "ParticipantID")]), ]
      model_cols <- c("Mode", "Environment", "ParticipantID", "outcome_z")
      d$outcome_z <- if (norm_label == "Within-Person Z-score") d[[value_col]] else as.numeric(scale(d[[value_col]]))
      d <- d[complete.cases(d[, model_cols, drop = FALSE]), , drop = FALSE]
      if (!model_data_ok(d, "outcome_z", 28, 8)) next

      fml <- "outcome_z ~ Mode * Environment"
      fit <- fit_phase_lmm(fml, d, method = "REML")
      ok <- !is.null(fit)
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "Psych_LMM", Condition = paste(cname, norm_label), Outcome = outcome,
        Status = ifelse(ok, "FIT", "NOT_FIT"), N_rows = nrow(d),
        N_participants = length(unique(d$ParticipantID)),
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "", stringsAsFactors = FALSE)
      if (!ok) next

      ex <- extract_h1_h3(
        fit, d, "outcome_z", outcome, outcome_group_map[outcome],
        cname, dur_label, norm_label,
        "Matched8min", sprintf("%s_z ~ Mode * Environment + (1|ParticipantID)", outcome)
      )
      h1_list <- c(h1_list, ex$h1)
      h3_list <- c(h3_list, ex$h3)
    }
  }
}

all_h13_family_sizes <- c(Matched8min = N_PLANNED_SENSOR_OUTCOMES)
h1_table <- adjust_by_family(safe_rbind(h1_list), all_h13_family_sizes)
h3_table <- adjust_by_family(safe_rbind(h3_list), all_h13_family_sizes)

# 5. H2: Psychological–Physiological Concurrence ----------------------------
cat("[3/6] Evaluating H2 psychological-physiological concurrence...\n")
h2_physio_outcomes <- intersect(sensor_outcomes, names(df))
h2_psych_outcomes  <- intersect(psych_outcomes, names(df))
h2_results_list <- list()

for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  dur_label <- "Matched_start_8min"

  h2_needed_raw <- unique(c("ParticipantID", "PhaseID", "Mode", "Environment", h2_physio_outcomes, h2_psych_outcomes))
  h2_needed_raw <- intersect(h2_needed_raw, names(d_cond))

  h2_phase_df <- aggregate(
    d_cond[setdiff(h2_needed_raw, c("ParticipantID", "PhaseID", "Mode", "Environment"))],
    by = d_cond[c("ParticipantID", "PhaseID", "Mode", "Environment")],
    FUN = mean_na
  )
  if (nrow(h2_phase_df) == 0) next
  h2_phase_df$ParticipantID <- factor(h2_phase_df$ParticipantID, levels = PARTICIPANTS)
  h2_phase_df$Mode <- factor(h2_phase_df$Mode, levels = c("Bike", "Walk"))

  for (norm_label in c("-", "Within-Person Z-score")) {
    for (psych_var in h2_psych_outcomes) {
      clean_psych_name <- if (!is.na(clean_labels[psych_var])) clean_labels[psych_var] else psych_var

      for (phys_var in h2_physio_outcomes) {
        phys_grp <- outcome_group_map[phys_var]
        clean_phys_name <- if (!is.na(clean_labels[phys_var])) clean_labels[phys_var] else phys_var
        d_sub <- h2_phase_df
        needed_cols <- c("ParticipantID", "Mode", psych_var, phys_var)
        d_sub <- d_sub[complete.cases(d_sub[, needed_cols, drop = FALSE]), , drop = FALSE]
        if (!model_data_ok(d_sub, phys_var, 20, 8)) next

        if (norm_label == "Within-Person Z-score") {
          d_sub$phys_z <- within_person_z(d_sub[[phys_var]], d_sub$ParticipantID)
          d_sub$psych_z <- within_person_z(d_sub[[psych_var]], d_sub$ParticipantID)
          fml_str <- "phys_z ~ Mode + psych_z"
          term_interest <- "psych_z"
        } else {
          psych_between <- ave(d_sub[[psych_var]], d_sub$ParticipantID, FUN = mean_na)
          psych_within  <- d_sub[[psych_var]] - psych_between
          d_sub$psych_within_z  <- as.numeric(scale(psych_within))
          d_sub$psych_between_z <- as.numeric(scale(psych_between))
          d_sub$phys_z <- as.numeric(scale(d_sub[[phys_var]]))
          fml_str <- "phys_z ~ Mode + psych_within_z + psych_between_z"
          term_interest <- "psych_within_z"
        }

        fit_h2 <- fit_phase_lmm(fml_str, d_sub, method = "REML")
        if (is.null(fit_h2)) next
        tt_h2 <- summary(fit_h2)$tTable
        if (!term_interest %in% rownames(tt_h2)) next

        b_val  <- as.numeric(tt_h2[term_interest, "Value"])
        se_val <- as.numeric(tt_h2[term_interest, "Std.Error"])
        t_val  <- as.numeric(tt_h2[term_interest, "t-value"])
        df_val <- as.numeric(tt_h2[term_interest, "DF"])
        p_val  <- as.numeric(tt_h2[term_interest, "p-value"])
        r_part <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + df_val))

        raw_direction_desc <- if (b_val >= 0) {
          sprintf("Higher %s corresponds to higher %s", clean_psych_name, clean_phys_name)
        } else {
          sprintf("Higher %s corresponds to lower %s", clean_psych_name, clean_phys_name)
        }

        model_desc <- if (norm_label == "Within-Person Z-score") {
          sprintf("wpz(%s) ~ Mode + wpz(%s) + (1|ParticipantID)", phys_var, psych_var)
        } else {
          sprintf("%s_z ~ Mode + %s_within + %s_between + (1|ParticipantID)", phys_var, psych_var, psych_var)
        }

        h2_results_list[[length(h2_results_list) + 1]] <- data.frame(
          Sub_Hypothesis = "H2.1", Model_Type = "Psych_Physio_Concurrence",
          Psychological_Measure = psych_var, Physiological_Measure = phys_var,
          Outcome_Group = phys_grp, Duration = dur_label, Normalization = norm_label,
          Model_Formula = model_desc, Raw_Direction = raw_direction_desc,
          Beta_Within_Std = b_val, SE = se_val,
          CI95_low = b_val - 1.96 * se_val, CI95_high = b_val + 1.96 * se_val,
          t_stat = t_val, df = df_val, p_value = p_val, Partial_r_Within = r_part,
          N_PhaseBouts = nrow(d_sub), N_Participants = length(unique(d_sub$ParticipantID)),
          stringsAsFactors = FALSE
        )
      }
    }
  }
}

h2_table <- safe_rbind(h2_results_list)
if (nrow(h2_table) > 0) {
  h2_family_key <- paste(h2_table$Duration, h2_table$Normalization, sep = "__")
  h2_table$q_FDR <- ave(h2_table$p_value, h2_family_key, FUN = function(p) p.adjust(p, method = "BH"))
  h2_table$FDR_significance <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05
  h2_table$Result <- ifelse(h2_table$FDR_significance, h2_table$Raw_Direction, "No FDR-significant concurrence")
  h2_table$Raw_Direction <- NULL
}

# 6. H4: Concurrent Environmental Stressor Models -----------------------------
cat("[4/6] Evaluating H4 concurrent environmental stressors...\n")
h4_all_outcomes <- intersect(sensor_outcomes, names(df))
h4_needed_cols <- unique(c("ParticipantID", "PhaseID", h4_all_outcomes, env_predictors))
h4_needed_cols <- intersect(h4_needed_cols, names(df))

h4_results_list <- list()

for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  dur_label <- "Matched_start_8min"

  cond_phase <- aggregate(
    d_cond[setdiff(h4_needed_cols, c("ParticipantID", "PhaseID"))],
    by = d_cond[c("ParticipantID", "PhaseID")],
    FUN = mean_na
  )
  cond_phase$ParticipantID <- factor(cond_phase$ParticipantID, levels = PARTICIPANTS)
  cond_phase$Mode <- factor(ifelse(grepl("^Bike", cond_phase$PhaseID), "Bike", "Walk"), levels = c("Bike", "Walk"))
  cond_phase$Environment <- factor(ifelse(grepl("U$", cond_phase$PhaseID), "Urban", "Green"), levels = c("Urban", "Green"))

  for (norm_label in c("-", "Within-Person Z-score")) {
    for (outc in h4_all_outcomes) {
      outc_grp <- outcome_group_map[outc]
      h4_curr_phase <- cond_phase
      wpz_col <- paste0("wpz__", outc)
      h4_curr_phase$curr_outc <- if (norm_label == "Within-Person Z-score" && wpz_col %in% names(h4_curr_phase)) {
        h4_curr_phase[[wpz_col]]
      } else {
        h4_curr_phase[[outc]]
      }

      for (pred in env_predictors) {
        pred_col <- if (norm_label == "Within-Person Z-score") paste0("wpz__", pred) else pred
        needed_s <- c("curr_outc", pred_col, "Mode", "ParticipantID")
        if (!all(needed_s %in% names(h4_curr_phase))) next
        d_s <- h4_curr_phase[complete.cases(h4_curr_phase[, needed_s, drop = FALSE]), , drop = FALSE]
        if (!model_data_ok(d_s, "curr_outc", 20, 8)) next

        d_s$outcome_z <- if (norm_label == "Within-Person Z-score") d_s$curr_outc else as.numeric(scale(d_s$curr_outc))
        d_s$pred_z    <- if (norm_label == "Within-Person Z-score") d_s[[pred_col]] else as.numeric(scale(d_s[[pred_col]]))

        fml_s <- "outcome_z ~ Mode + pred_z"
        fit_s <- fit_phase_lmm(fml_s, d_s, method = "REML")
        if (!is.null(fit_s)) {
          tt_s <- summary(fit_s)$tTable
          if ("pred_z" %in% rownames(tt_s)) {
            h4_results_list[[length(h4_results_list) + 1]] <- data.frame(
              Sub_Hypothesis = "H4.1", Model_Type = "Single_Predictor",
              Predictor = pred, Duration = dur_label, Normalization = norm_label,
              Outcome_Group = outc_grp, Outcome = outc,
              Model_Formula = sprintf("%s_z ~ Mode + scale(%s) + (1|ParticipantID)", outc, pred),
              Beta_Std = tt_s["pred_z", "Value"], SE = tt_s["pred_z", "Std.Error"],
              CI95_low = tt_s["pred_z", "Value"] - 1.96 * tt_s["pred_z", "Std.Error"],
              CI95_high = tt_s["pred_z", "Value"] + 1.96 * tt_s["pred_z", "Std.Error"],
              t_stat = tt_s["pred_z", "t-value"], df = tt_s["pred_z", "DF"],
              p_value = tt_s["pred_z", "p-value"],
              Result = ifelse(tt_s["pred_z", "Value"] >= 0,
                              sprintf("Higher %s is associated with higher %s", pred, outc),
                              sprintf("Higher %s is associated with lower %s", pred, outc)),
              N_rows = nrow(d_s), stringsAsFactors = FALSE
            )
          }
        }
      }
    }
  }
}

h4_table <- safe_rbind(h4_results_list)
if (nrow(h4_table) > 0) {
  h4_table$Correction_Family <- paste(h4_table$Sub_Hypothesis, h4_table$Predictor,
                                      h4_table$Duration, h4_table$Normalization, sep = "__")
  h4_table$q_FDR <- ave(h4_table$p_value, h4_table$Correction_Family, FUN = function(p) p.adjust(p, method = "BH"))
  h4_table$Correction_Family <- NULL
  h4_table$FDR_significance <- !is.na(h4_table$q_FDR) & h4_table$q_FDR < 0.05
}

# 7. SECTION 6B: Comprehensive Lagged & Cumulative Environmental Dynamics ----
cat("[5/6] Fitting 10-second Lagged & Cumulative Environmental Stressor Dynamics (AR1)...\n")

# Target environmental predictor streams for lag modeling
target_lag_predictors <- c(
  # Greenness & Canopy (GVI)
  "gvi_50m", "gvi_tree_50m", "gvi_grass_50m", "gvi_point_gvi", "gvi_point_tree",
  # Thermal & Microclimatic Stress (UCM)
  "ucm_UTCI", "ucm_PET", "ucm_AIR_T_bot", "ucm_MRT", "ucm_AIR_RH",
  # Solar Radiation & Daylight (UCM & LYS)
  "Clearness_Index", "ucm_SUN_Gh", "lys_lux_avg",
  # Acoustic Environment & Soundscape (UCM & YAMNet)
  "ucm_SND_dBA", "sound_prop_vehicle", "sound_prop_urban_manmade_positive", "sound_prop_urban_manmade_neutral",
  "sound_prop_urban_manmade_negative", "sound_prop_rural_natural",
  # Air Pollution (Atmotube)
  "atmo_pm2.5_avg", "atmo_pm1.0_avg", "atmo_pm10_avg"
)
target_lag_predictors <- intersect(target_lag_predictors, names(matched_route))

discrete_lags_sec <- c(0, 10, 20, 30, 60, 120)
rolling_windows_sec <- c(30, 60, 120)

cat(sprintf("   Selected %d predictor streams across 6 discrete lags and 3 rolling windows.\n",
            length(target_lag_predictors)))

# Precompute all lag and rolling features per participant-phase
lag_route <- matched_route
t_pre0 <- Sys.time()

for (pred in target_lag_predictors) {
  for (lsec in discrete_lags_sec) {
    k <- round(lsec / 10)
    col_nm <- sprintf("%s__lag_%ds", pred, lsec)
    lag_route[[col_nm]] <- unlist(lapply(split(lag_route[[pred]], lag_route$ParticipantPhaseID), discrete_lag, k = k), use.names = FALSE)
  }
  for (rsec in rolling_windows_sec) {
    w <- round(rsec / 10)
    col_nm <- sprintf("%s__roll_%ds", pred, rsec)
    lag_route[[col_nm]] <- unlist(lapply(split(lag_route[[pred]], lag_route$ParticipantPhaseID), roll_mean_right, w = w), use.names = FALSE)
  }
}
cat(sprintf("   Precomputed lag features in %.2f seconds.\n", as.numeric(difftime(Sys.time(), t_pre0, units = "secs"))))

h4_lag_results_list <- list()
n_lag_preds <- length(target_lag_predictors)

for (p_idx in seq_along(target_lag_predictors)) {
  pred <- target_lag_predictors[p_idx]
  t_pred_start <- Sys.time()

  # Build list of lag specifications
  all_specs <- c(
    lapply(discrete_lags_sec, function(s) list(type = "Discrete_Lag", sec = s, epochs = round(s / 10),
                                              col = sprintf("%s__lag_%ds", pred, s))),
    lapply(rolling_windows_sec, function(s) list(type = "Rolling_Window", sec = s, epochs = round(s / 10),
                                                col = sprintf("%s__roll_%ds", pred, s)))
  )

  for (spec in all_specs) {
    lag_col <- spec$col

    for (outc in sensor_outcomes) {
      outc_grp <- outcome_group_map[outc]
      needed <- c("ParticipantPhaseID", "ParticipantID", "Mode", "time_10s_step", outc, lag_col)
      d_sub <- lag_route[complete.cases(lag_route[, needed, drop = FALSE]), needed, drop = FALSE]
      if (nrow(d_sub) < 100 || length(unique(d_sub$ParticipantID)) < 8) next

      d_sub$outcome_z  <- as.numeric(scale(d_sub[[outc]]))
      d_sub$pred_lag_z <- as.numeric(scale(d_sub[[lag_col]]))

      if (!is.finite(sd(d_sub$pred_lag_z, na.rm = TRUE)) || sd(d_sub$pred_lag_z, na.rm = TRUE) == 0) next

      # Model fitting: Try LMM with corAR1; fall back to random intercept only if AR(1) fails
      status_label <- "FIT_AR1"
      fit_lag <- tryCatch(
        lme(outcome_z ~ Mode + pred_lag_z, random = ~ 1 | ParticipantPhaseID,
            correlation = corAR1(form = ~ time_10s_step | ParticipantPhaseID),
            data = d_sub, method = "REML", na.action = na.omit,
            control = lmeControl(maxIter = 30, msMaxIter = 30, tolerance = 1e-4)),
        error = function(e1) {
          status_label <<- "FIT_NO_AR1"
          tryCatch(
            lme(outcome_z ~ Mode + pred_lag_z, random = ~ 1 | ParticipantPhaseID,
                data = d_sub, method = "REML", na.action = na.omit,
                control = lmeControl(maxIter = 30, msMaxIter = 30, tolerance = 1e-4)),
            error = function(e2) NULL
          )
        }
      )

      if (!is.null(fit_lag)) {
        tt <- summary(fit_lag)$tTable
        if ("pred_lag_z" %in% rownames(tt)) {
          phi_val <- tryCatch({
            val <- as.numeric(coef(fit_lag$modelStruct$corStruct, unconstrained = FALSE))
            if (length(val) == 0 || is.null(val)) NA_real_ else val[1]
          }, error = function(e) NA_real_)

          b_val  <- as.numeric(tt["pred_lag_z", "Value"])
          se_val <- as.numeric(tt["pred_lag_z", "Std.Error"])
          t_val  <- as.numeric(tt["pred_lag_z", "t-value"])
          df_val <- as.numeric(tt["pred_lag_z", "DF"])
          p_val  <- as.numeric(tt["pred_lag_z", "p-value"])

          fml_text <- if (spec$type == "Discrete_Lag") {
            sprintf("%s_z ~ Mode + %s(lag %ds) + (1|ParticipantPhaseID)%s",
                    outc, pred, spec$sec, ifelse(status_label == "FIT_AR1", " + corAR1", ""))
          } else {
            sprintf("%s_z ~ Mode + %s(roll %ds) + (1|ParticipantPhaseID)%s",
                    outc, pred, spec$sec, ifelse(status_label == "FIT_AR1", " + corAR1", ""))
          }

          res_text <- if (spec$type == "Discrete_Lag") {
            ifelse(b_val >= 0,
                   sprintf("Higher %s at -%ds lag is associated with higher %s", pred, spec$sec, outc),
                   sprintf("Higher %s at -%ds lag is associated with lower %s", pred, spec$sec, outc))
          } else {
            ifelse(b_val >= 0,
                   sprintf("Higher %s (%ds rolling mean) is associated with higher %s", pred, spec$sec, outc),
                   sprintf("Higher %s (%ds rolling mean) is associated with lower %s", pred, spec$sec, outc))
          }

          h4_lag_results_list[[length(h4_lag_results_list) + 1]] <- data.frame(
            Sub_Hypothesis = ifelse(spec$type == "Discrete_Lag", "H4_Lag_Discrete", "H4_Lag_Rolling"),
            Model_Type = "Lagged_Environmental_LMM",
            Predictor = pred,
            Lag_Type = spec$type,
            Lag_Seconds = spec$sec,
            Lag_Epochs = spec$epochs,
            Outcome_Group = outc_grp,
            Outcome = outc,
            Model_Formula = fml_text,
            Beta_Std = b_val,
            SE = se_val,
            CI95_low = b_val - 1.96 * se_val,
            CI95_high = b_val + 1.96 * se_val,
            t_stat = t_val,
            df = df_val,
            p_value = p_val,
            AR1_Phi = phi_val,
            Model_Status = status_label,
            Result = res_text,
            N_Epochs = nrow(d_sub),
            N_Participants = length(unique(d_sub$ParticipantID)),
            stringsAsFactors = FALSE
          )
        }
      }
    }
  }

  cat(sprintf("   [%2d/%2d] Evaluated lag models for %-22s (elapsed: %.1f s)\n",
              p_idx, n_lag_preds, pred, as.numeric(difftime(Sys.time(), t_pred_start, units = "secs"))))
}

h4_lag_table <- safe_rbind(h4_lag_results_list)
if (nrow(h4_lag_table) > 0) {
  # FDR correction grouped by Predictor x Lag_Type x Lag_Seconds across outcomes
  h4_lag_table$Correction_Family <- paste(h4_lag_table$Predictor, h4_lag_table$Lag_Type,
                                          h4_lag_table$Lag_Seconds, sep = "__")
  h4_lag_table$q_FDR <- ave(h4_lag_table$p_value, h4_lag_table$Correction_Family,
                            FUN = function(p) p.adjust(p, method = "BH"))
  h4_lag_table$Correction_Family <- NULL
  h4_lag_table$FDR_significance <- !is.na(h4_lag_table$q_FDR) & h4_lag_table$q_FDR < 0.05
}

# 8. Write Dedicated CSV Tables to OUT_DIR ------------------------------------
cat("[6/6] Writing statistical tables to:", OUT_DIR, "...\n")

h1_cols_keep <- c("Sub_Hypothesis", "Contrast", "Outcome_Group", "Outcome", "Condition", "Duration",
                  "Predictor", "Result", "Normalization", "Model_Formula", "Interaction_Test", "Estimate_SD", "SE", "df",
                  "p_value", "q_FDR", "FDR_significance", "Cohens_d_LMM", "CI95_low", "CI95_high",
                  "Reference_Mean", "Comparison_Mean", "Reference_N", "Comparison_N")
h1_clean_table <- h1_table[, intersect(h1_cols_keep, names(h1_table)), drop = FALSE]
h3_clean_table <- h3_table[, intersect(h1_cols_keep, names(h3_table)), drop = FALSE]

h2_cols_keep <- c("Sub_Hypothesis", "Model_Type", "Psychological_Measure", "Physiological_Measure",
                  "Outcome_Group", "Duration", "Normalization", "Model_Formula", "Result",
                  "Beta_Within_Std", "SE", "CI95_low", "CI95_high", "t_stat", "df", "p_value", "Partial_r_Within",
                  "N_PhaseBouts", "N_Participants", "q_FDR", "FDR_significance")
h2_clean_table <- h2_table[, intersect(h2_cols_keep, names(h2_table)), drop = FALSE]

# Decorate H1 and H3 tables with Outcome_Sensor and Clean_Outcome
h1_table$Outcome_Sensor <- sapply(h1_table$Outcome, get_outc_sensor)
h1_table$Clean_Outcome  <- ifelse(!is.na(clean_labels[h1_table$Outcome]), clean_labels[h1_table$Outcome], h1_table$Outcome)
h3_table$Outcome_Sensor <- sapply(h3_table$Outcome, get_outc_sensor)
h3_table$Clean_Outcome  <- ifelse(!is.na(clean_labels[h3_table$Outcome]), clean_labels[h3_table$Outcome], h3_table$Outcome)

h2_table$Physiological_Sensor <- sapply(h2_table$Physiological_Measure, get_outc_sensor)
h2_table$Clean_Physiological  <- ifelse(!is.na(clean_labels[h2_table$Physiological_Measure]), clean_labels[h2_table$Physiological_Measure], h2_table$Physiological_Measure)
h2_table$Clean_Psychological  <- ifelse(!is.na(clean_labels[h2_table$Psychological_Measure]), clean_labels[h2_table$Psychological_Measure], h2_table$Psychological_Measure)

# Decorate H4 lag table
if (nrow(h4_lag_table) > 0) {
  h4_lag_table$Predictor_Sensor <- sapply(h4_lag_table$Predictor, get_pred_sensor)
  h4_lag_table$Clean_Predictor  <- ifelse(!is.na(clean_labels[h4_lag_table$Predictor]), clean_labels[h4_lag_table$Predictor], h4_lag_table$Predictor)
  h4_lag_table$Outcome_Sensor   <- sapply(h4_lag_table$Outcome, get_outc_sensor)
  h4_lag_table$Clean_Outcome    <- ifelse(!is.na(clean_labels[h4_lag_table$Outcome]), clean_labels[h4_lag_table$Outcome], h4_lag_table$Outcome)
}

h1_cols_keep <- c("Sub_Hypothesis", "Contrast", "Outcome_Sensor", "Clean_Outcome", "Outcome_Group", "Outcome", "Condition", "Duration",
                  "Predictor", "Result", "Normalization", "Model_Formula", "Interaction_Test", "Estimate_SD", "SE", "df",
                  "p_value", "q_FDR", "FDR_significance", "Cohens_d_LMM", "CI95_low", "CI95_high",
                  "Reference_Mean", "Comparison_Mean", "Reference_N", "Comparison_N")
h1_clean_table <- h1_table[, intersect(h1_cols_keep, names(h1_table)), drop = FALSE]
h3_clean_table <- h3_table[, intersect(h1_cols_keep, names(h3_table)), drop = FALSE]

h2_cols_keep <- c("Sub_Hypothesis", "Model_Type", "Clean_Psychological", "Psychological_Measure",
                  "Physiological_Sensor", "Clean_Physiological", "Physiological_Measure",
                  "Outcome_Group", "Duration", "Normalization", "Model_Formula", "Result",
                  "Beta_Within_Std", "SE", "CI95_low", "CI95_high", "t_stat", "df", "p_value", "Partial_r_Within",
                  "N_PhaseBouts", "N_Participants", "q_FDR", "FDR_significance")
h2_clean_table <- h2_table[, intersect(h2_cols_keep, names(h2_table)), drop = FALSE]

h4_cols_keep <- c("Sub_Hypothesis", "Model_Type", "Predictor_Sensor", "Clean_Predictor", "Predictor",
                  "Duration", "Normalization", "Outcome_Sensor", "Clean_Outcome", "Outcome_Group", "Outcome", "Model_Formula",
                  "Result", "Beta_Std", "SE", "CI95_low", "CI95_high", "t_stat", "df", "p_value", "q_FDR", "FDR_significance", "N_rows")

h4_single_table <- h4_table[, intersect(h4_cols_keep, names(h4_table)), drop = FALSE]

safe_write_csv(h1_clean_table, file.path(OUT_DIR, "H1_Green_vs_Urban.csv"))
safe_write_csv(h3_clean_table, file.path(OUT_DIR, "H3_Walk_vs_Bike.csv"))
safe_write_csv(h2_clean_table, file.path(OUT_DIR, "H2_Physio_Psycho_Concordance.csv"))
safe_write_csv(h4_single_table, file.path(OUT_DIR, "H4_Environmental_Stressors.csv"))
safe_write_csv(h4_lag_table, file.path(OUT_DIR, "H4_Environmental_Stressors_Lag.csv"))

# Master Combined Table
result_tables <- list(H1 = h1_clean_table, H2 = h2_clean_table,
                      H3 = h3_clean_table, H4 = h4_single_table)
result_tables <- Map(function(tab, hyp) {
  tab$Hypothesis <- hyp
  tab
}, result_tables, names(result_tables))
all_result_cols <- unique(unlist(lapply(result_tables, names)))
results_h1_4 <- do.call(rbind, lapply(result_tables, function(tab) {
  for (nm in setdiff(all_result_cols, names(tab))) tab[[nm]] <- NA
  tab[all_result_cols]
}))
rownames(results_h1_4) <- NULL
safe_write_csv(results_h1_4, file.path(OUT_DIR, "results_H1-4.csv"))

# Audit and Manifest
model_audit_df <- safe_rbind(model_audit)
safe_write_csv(model_audit_df, file.path(OUT_DIR, "Model_Audit.csv"))

manifest <- data.frame(
  Script = SCRIPT_PATH,
  Script_MD5 = unname(tools::md5sum(SCRIPT_PATH)),
  Input_File = RAW_PATH,
  GVI_File = if (file.exists(GVI_PATH)) GVI_PATH else "None",
  Key_File = KEY_PATH,
  Input_Rows = nrow(df),
  Input_Columns = ncol(df),
  N_Participants = length(intersect(PARTICIPANTS, unique(df$ParticipantID))),
  Completed_At = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
  H1_Primary_Significant_FDR = sum(h1_clean_table$FDR_significance, na.rm = TRUE),
  H3_Primary_Significant_FDR = sum(h3_clean_table$FDR_significance, na.rm = TRUE),
  H2_Significant_FDR = sum(h2_clean_table$FDR_significance, na.rm = TRUE),
  H4_Concurrent_Significant_FDR = sum(h4_single_table$FDR_significance, na.rm = TRUE),
  H4_Lag_Models_Fitted = nrow(h4_lag_table),
  H4_Lag_Significant_FDR = sum(h4_lag_table$FDR_significance, na.rm = TRUE),
  stringsAsFactors = FALSE
)
safe_write_csv(manifest, file.path(OUT_DIR, "Run_Manifest.csv"))

cat("==============================================================================\n")
cat("SUCCESS: All models executed and exported to:", OUT_DIR, "\n")
cat("   H4 Lagged models fitted:", nrow(h4_lag_table), "\n")
cat("   H4 Lagged FDR-significant associations:", sum(h4_lag_table$FDR_significance, na.rm = TRUE), "\n")
cat("   Output lag table:", file.path(OUT_DIR, "H4_Environmental_Stressors_Lag.csv"), "\n")
cat("==============================================================================\n")

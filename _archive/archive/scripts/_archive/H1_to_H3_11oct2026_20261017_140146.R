# ==============================================================================
# SCRIPT: statistical_analysis.R
# PURPOSE: Auditable participant-phase inferential analysis for Paper 3.
#          Key methodological foundations:
#            - H1/H3 sensor streams: one participant-phase mean per condition (REML LMM).
#            - H1/H3 questionnaires: one participant-phase row (never duplicated across 10-s epochs).
#            - Planned simple contrasts: BikeG-BikeU, WalkG-WalkU, WalkU-BikeU, WalkG-BikeG,
#              plus marginal effects and Mode*Environment interaction tests.
#            - Primary duration: participant-matched first 8 minutes.
#            - Primary normalization: Within-Person Z-score calculated strictly on core
#              outdoor experimental routes (BikeU, BikeG, WalkU, WalkG); no Indoor or Tram baseline contamination.
#            - H2: within-person psychophysiological concurrence mixed models (Van Doren 2021; Cuve 2023)
#              evaluating whether autonomic/ocular changes track psychological states across bouts.
#            - H4 is intentionally excluded from this archived script.
#              Current H4 implementation: scripts/H4_multivariate.R.
#            - Complete model audit logging: all attempted, fitted, skipped, or failed models recorded in Model_Audit.csv.
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
KEY_PATH <- Sys.getenv("PAPER3_KEY_PATH", file.path(PROJECT_ROOT, "output", "key.csv"))
if (!file.exists(KEY_PATH)) {
  KEY_PATH <- file.path(SIBLING_DATA_ROOT, "output", "key.csv")
}
OUT_DIR <- Sys.getenv("PAPER3_OUT_DIR", file.path(PROJECT_ROOT, "output", "statistical_analysis", "results"))
SCRIPT_PATH <- file.path(PROJECT_ROOT, "scripts", "H1_to_H3.R")
MAKE_FIGURES <- Sys.getenv("PAPER3_MAKE_FIGURES", "TRUE") == "TRUE"
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

PARTICIPANTS    <- c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17")
CORE_PHASES     <- c("BikeU", "WalkU", "BikeG", "WalkG")
MATCHED_CAP_SEC <- 8 * 60

OUTCOMES <- list(
  Psychological = c(
    "questionnaire_current_comfort_1_7",
    "questionnaire_pleasantness_1_5",
    "questionnaire_stai6_mean_1_5",
    "questionnaire_prs11_total_mean_1_5"
  ),
  Physiological_Autonomic = c(
    "empatica_heart_rate",
    "empatica_eda_tonic",
    "empatica_eda_phasic",
    "empatica_skin_temperature",
    "empatica_hrv_td_sdnn",
    "empatica_hrv_td_rmssd",
    "empatica_hrv_fd_lf",
    "empatica_hrv_fd_hf",
    "empatica_hrv_fd_lf_hf_ratio",
    "empatica_hrv_fd_lfnu",
    "empatica_hrv_fd_hfnu",
    "empatica_hrv_fd_vlf",
    "empatica_hrv_fd_total_power"
  ),
  Physiological_Ocular = c(
    "eyetracker_pupil_diameter_avg",
    "eyetracker_pupil_change_rate",
    "eyetracker_blink_duration_s",
    "eyetracker_fixation_duration_s",
    "eyetracker_fixation_rate",
    "eyetracker_saccade_duration_s",
    "eyetracker_saccade_amplitude",
    "eyetracker_saccade_peak_velocity",
    "eyetracker_gaze_velocity",
    "eyetracker_gaze_dispersion",
    "eyetracker_distance_from_center",
    "eyetracker_gaze_centrality",
    "eyetracker_eyelid_aperture_avg"
  )
)
all_outcomes      <- unlist(OUTCOMES, use.names = FALSE)
outcome_group_map <- setNames(rep(names(OUTCOMES), lengths(OUTCOMES)), all_outcomes)

clean_labels <- c(
  # Psychological Surveys
  "questionnaire_current_comfort_1_7"   = "Survey: General Comfort (1-7)",
  "questionnaire_pleasantness_1_5"      = "Survey: Pleasantness (1-5)",
  "questionnaire_stai6_mean_1_5"        = "Survey: State Anxiety (STAI-6)",
  "questionnaire_prs11_total_mean_1_5"  = "Survey: Restorativeness (PRS-11)",
  
  # Empatica EmbracePlus: Autonomic Physiology (Time Domain & Core)
  "empatica_heart_rate"                 = "Empatica: Heart Rate (bpm)",
  "empatica_eda_tonic"                  = "Empatica: EDA Tonic Level (SCL)",
  "empatica_eda_phasic"                 = "Empatica: EDA Phasic (SCR)",
  "empatica_skin_temperature"           = "Empatica: Skin Temperature (°C)",
  "empatica_hrv_td_sdnn"                = "Empatica: HRV (SDNN, ms)",
  "empatica_hrv_td_rmssd"               = "Empatica: HRV (RMSSD, ms)",
  
  # Empatica EmbracePlus: Autonomic Physiology (Frequency Domain HRV)
  "empatica_hrv_fd_lf"                  = "Empatica: HRV LF Power (ms²)",
  "empatica_hrv_fd_hf"                  = "Empatica: HRV HF Power (ms²)",
  "empatica_hrv_fd_lf_hf_ratio"         = "Empatica: HRV LF/HF Ratio",
  "empatica_hrv_fd_lfnu"                = "Empatica: HRV LF (nu)",
  "empatica_hrv_fd_hfnu"                = "Empatica: HRV HF (nu)",
  "empatica_hrv_fd_vlf"                 = "Empatica: HRV VLF Power (ms²)",
  "empatica_hrv_fd_total_power"         = "Empatica: HRV Total Power (ms²)",
  
  # Eyetracker (Pupil Labs Neon)
  "eyetracker_pupil_diameter_avg"       = "Eyetracker: Pupil Diameter (mm)",
  "eyetracker_pupil_change_rate"        = "Eyetracker: Pupil Change Rate",
  "eyetracker_blink_duration_s"         = "Eyetracker: Blink Duration (s)",
  "eyetracker_fixation_duration_s"      = "Eyetracker: Fixation Duration (s)",
  "eyetracker_fixation_rate"            = "Eyetracker: Fixation Rate (/s)",
  "eyetracker_saccade_duration_s"       = "Eyetracker: Saccade Duration (s)",
  "eyetracker_saccade_amplitude"        = "Eyetracker: Saccade Amplitude (°)",
  "eyetracker_saccade_peak_velocity"    = "Eyetracker: Saccade Peak Velocity (°/s)",
  "eyetracker_gaze_velocity"            = "Eyetracker: Gaze Velocity (°/s)",
  "eyetracker_gaze_dispersion"          = "Eyetracker: Gaze Dispersion",
  "eyetracker_gaze_centrality"          = "Eyetracker: Gaze Centrality",
  "eyetracker_distance_from_center"     = "Eyetracker: Gaze Distance from Center (px)",
  "eyetracker_eyelid_aperture_avg"      = "Eyetracker: Eyelid Aperture (mm)",

  # Environmental Predictors - UCM Backpack: Thermal & Microclimatic
  "ucm_PET"                             = "UCM: PET Thermal Index (°C)",
  "ucm_UTCI"                            = "UCM: UTCI Thermal Index (°C)",
  "ucm_AIR_temp"                        = "UCM: Air Temperature (°C)",
  "ucm_AIR_RH"                          = "UCM: Relative Humidity (%)",
  "ucm_HUMIDEX"                         = "UCM: Humidex Thermal Index",
  "ucm_MRT"                             = "UCM: Mean Radiant Temp (°C)",
  "ucm_WIND_AWS"                        = "UCM: Apparent Wind Speed (m/s)",
  "ucm_WIND_TWS"                        = "UCM: True Wind Speed (m/s)",
  "Clearness_Index"                     = "UCM: Solar Clearness Index",

  # Environmental Predictors - Acoustic (UCM Physical Sound Level)
  "ucm_SND_dBA"                         = "UCM: Acoustic Noise Level (dBA)",

  # Environmental Predictors - Air Quality (Atmotube Researcher-Carried Bilateral Average)
  "atmo_pm1.0_avg"                      = "Atmotube: PM1.0 (µg/m³)",
  "atmo_pm2.5_avg"                      = "Atmotube: PM2.5 (µg/m³)",
  "atmo_pm10_avg"                       = "Atmotube: PM10 (µg/m³)",
  "atmo_temperature_avg"                = "Atmotube: Air Temperature (°C)",
  "atmo_humidity_avg"                   = "Atmotube: Humidity (%)",

  # Environmental Predictors - Visual Lighting (LYS Sensors)
  "lys_lux_avg"                         = "LYS: Route Illuminance (lux)",
  "atmo_lys_LYS1__lys_lux"              = "LYS: Personal Illuminance (LYS1, lux)",
  "lys_rgbb_avg"                        = "LYS: Blue Irradiance (rgbb)",
  "lys_rgbg_avg"                        = "LYS: Green Irradiance (rgbg)",
  "lys_rgbr_avg"                        = "LYS: Red Irradiance (rgbr)",
  "lys_kelvin_avg"                      = "LYS: Color Temperature (K)",

  # Environmental Predictors - Greenery (Eye-Level 360° Visual GVI)
  "gvi_50m"                             = "GVI: Green View Index (50m)",

  # Environmental Predictors - YAMNet Audio Semantic Classifications
  "sound_level_dbfs"                    = "YAMNet: Audio Power Level (dBFS)",
  "sound_prop_vehicle"                  = "YAMNet: Vehicle Sound Prop",
  "sound_prop_urban_manmade"            = "YAMNet: Urban/Manmade Sound Prop",
  "sound_prop_rural_natural"            = "YAMNet: Natural Sound Prop",
  "sound_prop_wind"                     = "YAMNet: Wind Sound Prop",
  "sound_prop_mechanisms"               = "YAMNet: Machinery Sound Prop"
)

get_pred_sensor <- function(p) {
  if (grepl("^(ucm_|Clearness_Index$)", p)) return("UCM")
  if (grepl("^atmo_", p)) return("Atmotube")
  if (grepl("^(lys_|atmo_lys_LYS)", p)) return("LYS")
  if (grepl("^(gvi_|tree_)", p)) return("GVI")
  if (grepl("^sound_", p)) return("YAMNet")
  "Environmental"
}

get_outc_sensor <- function(o) {
  if (grepl("^empatica_", o)) return("Empatica")
  if (grepl("^eyetracker_", o)) return("Eyetracker")
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
    warning(sprintf("File locked by Excel or another process: %s. Attempting fallback...", path))
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
  if (!outcome %in% names(data)) return(FALSE)
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
  den <- suppressWarnings(as.numeric(a$denDF[1]))
  if (!is.finite(p)) return("NA")
  sprintf("F(1,%s)=%.2f, p=%.4f", ifelse(is.finite(den), as.character(round(den)), "NA"), f, p)
}

contrast_result <- function(contrast_id, estimate, outcome) {
  if (!is.finite(estimate)) return(NA_character_)
  route_pairs <- list(
    H1_Bike = c("BikeG", "BikeU"),
    H1_Walk = c("WalkG", "WalkU"),
    H3_Urban = c("WalkU", "BikeU"),
    H3_Green = c("WalkG", "BikeG")
  )
  if (!contrast_id %in% names(route_pairs)) return(NA_character_)
  pair <- route_pairs[[contrast_id]]
  if (estimate < 0) pair <- rev(pair)
  sprintf("%s > %s for %s", pair[1], pair[2], outcome)
}

make_result_row <- function(hypothesis, sub_hypothesis, contrast_id, contrast_label,
                            outcome, outcome_group, condition, duration, normalization,
                            family_set, fit, cnt, reference_mean, comparison_mean,
                            reference_n, comparison_n, model_formula, interaction_test) {
  d <- model_cohens_d(cnt, fit)
  data.frame(
    Sub_Hypothesis = sub_hypothesis,
    Contrast = contrast_label,
    Outcome_Group = outcome_group,
    Outcome = outcome,
    Predictor = ifelse(hypothesis == "H1", "Environment", "Mode"),
    Result = contrast_result(contrast_id, cnt$estimate, outcome),
    Condition = condition,
    Duration = duration,
    Normalization = normalization,
    Model_Formula = model_formula,
    Interaction_Test = interaction_test,
    Estimate_SD = cnt$estimate,
    SE = cnt$SE,
    df = cnt$df,
    p_value = cnt$p.value,
    Cohens_d_LMM = d["d"],
    CI95_low = d["low"],
    CI95_high = d["high"],
    Reference_Mean = reference_mean,
    Comparison_Mean = comparison_mean,
    Reference_N = reference_n,
    Comparison_N = comparison_n,
    Hypothesis = hypothesis,
    Contrast_ID = contrast_id,
    Family_Set = family_set,
    stringsAsFactors = FALSE
  )
}

extract_h1_h3 <- function(fit, d, value_col, outcome, outcome_group, condition,
                          duration, normalization, family_set, model_formula) {
  h1 <- list(); h3 <- list()
  int_txt <- interaction_summary(fit)
  add_row <- function(hyp, sub, cid, label, cnt, ref, comp) {
    row <- make_result_row(
      hyp, sub, cid, label, outcome, outcome_group, condition, duration, normalization,
      family_set, fit, cnt, mean(d[[value_col]][ref], na.rm = TRUE),
      mean(d[[value_col]][comp], na.rm = TRUE), sum(ref), sum(comp), model_formula, int_txt
    )
    if (hyp == "H1") h1[[length(h1) + 1]] <<- row else h3[[length(h3) + 1]] <<- row
  }

  em_h1 <- emmeans(fit, ~ Environment | Mode, weights = "equal")
  c_h1 <- as.data.frame(summary(contrast(
    em_h1, method = list(Green_minus_Urban = c(-1, 1)), infer = c(TRUE, TRUE)
  )))
  for (i in seq_len(nrow(c_h1))) {
    md <- as.character(c_h1$Mode[i])
    add_row("H1", ifelse(md == "Bike", "H1.1", "H1.2"),
            ifelse(md == "Bike", "H1_Bike", "H1_Walk"),
            sprintf("Green - Urban within %s", md), c_h1[i, ],
            d$Environment == "Urban" & d$Mode == md,
            d$Environment == "Green" & d$Mode == md)
  }

  em_h3 <- emmeans(fit, ~ Mode | Environment, weights = "equal")
  c_h3 <- as.data.frame(summary(contrast(
    em_h3, method = list(Walk_minus_Bike = c(-1, 1)), infer = c(TRUE, TRUE)
  )))
  for (i in seq_len(nrow(c_h3))) {
    ev <- as.character(c_h3$Environment[i])
    add_row("H3", ifelse(ev == "Urban", "H3.1", "H3.2"),
            ifelse(ev == "Urban", "H3_Urban", "H3_Green"),
            sprintf("Walk - Bike within %s", ev), c_h3[i, ],
            d$Mode == "Bike" & d$Environment == ev,
            d$Mode == "Walk" & d$Environment == ev)
  }

  list(h1 = h1, h3 = h3)
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

# 3. Data Loading & Feature Engineering ----------------------------------------
cat("[1/6] Loading and formatting dataset...\n")
if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
df <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
raw_source_columns <- names(df)
df$ParticipantID <- as.character(df$ParticipantID)
df$PhaseID <- as.character(df$PhaseID)

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
core_time_key <- paste(df$ParticipantID, df$PhaseID, df$Datetime, sep = "::")
core_idx <- df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% c(CORE_PHASES, "Tram")
if (anyDuplicated(core_time_key[core_idx])) {
  stop("Duplicate ParticipantID/PhaseID/Datetime keys detected in active/Tram data.")
}
cat("   Input:", RAW_PATH, "\n")
cat("   Rows/columns:", nrow(df), "/", ncol(df),
    "| Participants:", length(intersect(PARTICIPANTS, unique(df$ParticipantID))),
    "of", length(PARTICIPANTS), "| Indoor rows:",
    sum(df$PhaseID == "Indoor", na.rm = TRUE), "\n")

# Bilateral sensor fusion for researcher-carried Atmotube and corridor LYS
safe_pair_mean <- function(data, left, right) {
  if (!all(c(left, right) %in% names(data))) return(rep(NA_real_, nrow(data)))
  z <- rowMeans(cbind(as.numeric(data[[left]]), as.numeric(data[[right]])), na.rm = TRUE)
  z[is.nan(z)] <- NA_real_
  z
}
pair_map <- list(
  atmo_pm1.0_avg       = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
  atmo_pm2.5_avg       = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  atmo_pm10_avg        = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
  atmo_temperature_avg = c("atmo_lys_atmotube_left__atmotube_temperature", "atmo_lys_atmotube_right__atmotube_temperature"),
  atmo_humidity_avg    = c("atmo_lys_atmotube_left__atmotube_humidity", "atmo_lys_atmotube_right__atmotube_humidity"),
  lys_lux_avg          = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
  lys_rgbb_avg         = c("atmo_lys_LYS1__lys_rgbb", "atmo_lys_LYS2__lys_rgbb"),
  lys_rgbg_avg         = c("atmo_lys_LYS1__lys_rgbg", "atmo_lys_LYS2__lys_rgbg"),
  lys_rgbr_avg         = c("atmo_lys_LYS1__lys_rgbr", "atmo_lys_LYS2__lys_rgbr"),
  lys_kelvin_avg       = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"),
  lys_medi_avg         = c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi")
)
for (nm in names(pair_map)) df[[nm]] <- do.call(safe_pair_mean, c(list(df), pair_map[[nm]]))

# Synchronize clean YAMNet acoustic features
if (!"sound_prop_urban_manmade" %in% names(df)) {
  um_cols <- intersect(c("sound_prop_urban_manmade_positive", "sound_prop_urban_manmade_neutral", "sound_prop_urban_manmade_negative"), names(df))
  if (length(um_cols) > 0) {
    df$sound_prop_urban_manmade <- rowSums(df[, um_cols, drop = FALSE], na.rm = TRUE)
  }
}

# Personal participant lighting (LYS1)
if ("atmo_lys_LYS1__lys_lux" %in% names(df) && !"lys_lux_participant" %in% names(df)) {
  df$lys_lux_participant <- as.numeric(df[["atmo_lys_LYS1__lys_lux"]])
}

# Declared Outcomes Audit
sensor_outcomes <- intersect(c(OUTCOMES$Physiological_Autonomic, OUTCOMES$Physiological_Ocular), names(df))
psych_outcomes  <- intersect(OUTCOMES$Psychological, names(df))
if (length(sensor_outcomes) == 0) stop("No declared physiological/ocular outcome columns are available after schema harmonization.")
if (length(psych_outcomes) == 0) warning("No declared psychological outcome columns are available.")

# H4 environmental predictor selection/audit moved to scripts/H4_multivariate.R.\n\n# Route Dataset Preparation & FROZEN Within-Person Standardization -------------
# Golden rule: Standardization reference is strictly the participant's observations
# during the 4 active outdoor experimental trials (BikeU, BikeG, WalkU, WalkG).
# Zero Indoor or Tram baseline contamination.
route <- df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ]
route$Datetime           <- as.POSIXct(route$Datetime, tz = "UTC")
if (anyNA(route$Datetime)) stop("Unparseable Datetime values found in core route data.")
route$ParticipantID      <- factor(route$ParticipantID, levels = PARTICIPANTS)
route$Mode               <- factor(ifelse(grepl("^Bike", route$PhaseID), "Bike", "Walk"), levels = c("Bike", "Walk"))
route$Environment        <- factor(ifelse(grepl("U$", route$PhaseID), "Urban", "Green"), levels = c("Urban", "Green"))
route$ModeEnvironment    <- interaction(route$Mode, route$Environment, drop = TRUE)
route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]

# Compute Within-Person Z-scores strictly across the 4 core routes
within_person_vars <- unique(c(sensor_outcomes, psych_outcomes))
within_person_vars <- intersect(within_person_vars, names(route))
for (v in within_person_vars) {
  route[[paste0("wpz__", v)]] <- within_person_z(route[[v]], route$ParticipantID)
}

route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
                               FUN = function(x) x - min(x, na.rm = TRUE))
route$time_min   <- route$time_in_phase_sec / 60
route$time_10sec <- route$time_in_phase_sec / 10

durations <- aggregate(time_in_phase_sec ~ ParticipantID + PhaseID, route, max, na.rm = TRUE)
dur_w <- reshape(durations, idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
names(dur_w) <- sub("time_in_phase_sec\\.", "", names(dur_w))
for (nm in CORE_PHASES) if (!nm %in% names(dur_w)) dur_w[[nm]] <- NA_real_
dur_w$Common_cap <- pmin(dur_w$BikeU, dur_w$BikeG, dur_w$WalkU, dur_w$WalkG,
                         MATCHED_CAP_SEC, na.rm = FALSE)
route <- merge(route, dur_w[c("ParticipantID", "Common_cap")],
               by = "ParticipantID", all.x = TRUE, sort = FALSE)
route$matched_cap_sec <- route$Common_cap

CONDITIONS <- list(
  "Primary: Matched duration <=8 min" =
    route[!is.na(route$matched_cap_sec) & route$time_in_phase_sec <= route$matched_cap_sec, ]
)

# H4 VIF selection moved to scripts/H4_multivariate.R.\n\n# 4. H1 & H3 Inferential Models (All 30 Declared Outcomes) ----------------------
cat("[2/6] Fitting unified H1/H3 models across all 30 declared outcomes (sensors + questionnaires)...\n")
h1_list <- list(); h3_list <- list(); model_audit <- list()

declared_missing <- setdiff(all_outcomes, names(df))
if (length(declared_missing) > 0) {
  for (outcome in declared_missing) {
    model_audit[[length(model_audit) + 1]] <- data.frame(
      Analysis = "Input_schema", Condition = "All", Outcome = outcome, Predictor = "NA",
      Status = "NOT_AVAILABLE_IN_INPUT", N_rows = 0, N_participants = 0,
      Temporal_Rho_Not_Used = NA_real_, Warning = "",
      Error = "Declared outcome absent from input dataset.",
      stringsAsFactors = FALSE
    )
  }
}

for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  family_set <- "Primary"
  dur_label <- "Matched_start_8min"
  norm_label <- "Within-Person Z-score"

  # Participant-phase aggregation: exactly 1 observation per participant x phase (N = 44)
  # Continuous sensors are averaged across the matched duration.
  # Questionnaires are already recorded once per phase and have identical values across epochs.
  all_phase_vars <- unique(c(sensor_outcomes, psych_outcomes,
                            paste0("wpz__", sensor_outcomes), paste0("wpz__", psych_outcomes)))
  all_phase_vars <- intersect(all_phase_vars, names(d_cond))

  phase_df <- aggregate(
    d_cond[all_phase_vars],
    by = d_cond[c("ParticipantID", "PhaseID", "Mode", "Environment")],
    FUN = mean_na
  )
  phase_df$ParticipantID <- factor(phase_df$ParticipantID, levels = PARTICIPANTS)
  phase_df$Mode <- factor(phase_df$Mode, levels = c("Bike", "Walk"))
  phase_df$Environment <- factor(phase_df$Environment, levels = c("Urban", "Green"))

  for (outcome in intersect(all_outcomes, names(d_cond))) {
    value_col <- paste0("wpz__", outcome)
    outc_grp <- outcome_group_map[outcome]
    
    if (!value_col %in% names(phase_df)) {
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "H1H3_phase_mean", Condition = cname, Outcome = outcome, Predictor = "Mode*Environment",
        Status = "NOT_FIT_MISSING_COLUMN", N_rows = 0, N_participants = 0,
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "wpz column missing",
        stringsAsFactors = FALSE
      )
      next
    }

    d <- phase_df[complete.cases(phase_df[, c(value_col, "Mode", "Environment", "ParticipantID")]), ]
    d$outcome_z <- d[[value_col]]
    n_pid <- length(unique(d$ParticipantID))

    if (!model_data_ok(d, "outcome_z", 24, 8)) {
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "H1H3_phase_mean", Condition = cname, Outcome = outcome, Predictor = "Mode*Environment",
        Status = "NOT_FIT_INSUFFICIENT_DATA", N_rows = nrow(d), N_participants = n_pid,
        Temporal_Rho_Not_Used = NA_real_, Warning = "Fewer than 24 bouts or 8 participants", Error = "",
        stringsAsFactors = FALSE
      )
      next
    }

    fml <- "outcome_z ~ Mode * Environment"
    fit <- fit_phase_lmm(fml, d, method = "REML")
    if (is.null(fit)) {
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "H1H3_phase_mean", Condition = cname, Outcome = outcome, Predictor = "Mode*Environment",
        Status = "FAILED_CONVERGENCE", N_rows = nrow(d), N_participants = n_pid,
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "nlme::lme failed to converge",
        stringsAsFactors = FALSE
      )
      next
    }

    model_audit[[length(model_audit) + 1]] <- data.frame(
      Analysis = "H1H3_phase_mean", Condition = cname, Outcome = outcome, Predictor = "Mode*Environment",
      Status = "FIT", N_rows = nrow(d), N_participants = n_pid,
      Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "", stringsAsFactors = FALSE
    )

    ex <- extract_h1_h3(
      fit, d, "outcome_z", outcome, outc_grp, cname,
      dur_label, norm_label,
      family_set, sprintf("wpz(%s) ~ Mode * Environment + (1|ParticipantID)", outcome)
    )
    h1_list <- c(h1_list, ex$h1)
    h3_list <- c(h3_list, ex$h3)
  }
}

N_PLANNED_ALL_OUTCOMES <- length(intersect(all_outcomes, names(df)))
all_h13_family_sizes <- c(Primary = N_PLANNED_ALL_OUTCOMES)
h1_table <- adjust_by_family(safe_rbind(h1_list), all_h13_family_sizes)
h3_table <- adjust_by_family(safe_rbind(h3_list), all_h13_family_sizes)

# 4D. Temporal Time-Series Mixed Models with AR(1) Autocorrelation -------------
cat("[2b/6] Fitting 10-second temporal time-series LMMs with AR(1) autocorrelation...\n")
temporal_results_list <- list()
route_ar1 <- route
route_ar1$time_10s_step <- round(route_ar1$time_in_phase_sec / 10)
route_ar1$PhaseID <- factor(route_ar1$PhaseID, levels = CORE_PHASES)

for (outc in sensor_outcomes) {
  outc_grp <- outcome_group_map[outc]
  needed <- c("ParticipantID", "PhaseID", "Mode", "Environment", "time_min", "time_10s_step", outc)
  d_ts <- route_ar1[complete.cases(route_ar1[, needed, drop = FALSE]), needed, drop = FALSE]
  d_ts <- d_ts[!duplicated(paste(d_ts$ParticipantID, d_ts$PhaseID, d_ts$time_10s_step)), ]
  d_ts <- d_ts[order(d_ts$ParticipantID, d_ts$PhaseID, d_ts$time_10s_step), ]
  if (!model_data_ok(d_ts, outc, 100, 8)) {
    model_audit[[length(model_audit) + 1]] <- data.frame(
      Analysis = "Temporal_AR1", Condition = "Primary_10s", Outcome = outc, Predictor = "time_min*Env*Mode",
      Status = "NOT_FIT_INSUFFICIENT_DATA", N_rows = nrow(d_ts), N_participants = length(unique(d_ts$ParticipantID)),
      Temporal_Rho_Not_Used = NA_real_, Warning = "Insufficient time-series rows", Error = "",
      stringsAsFactors = FALSE
    )
    next
  }

  fit_ar1 <- tryCatch(
    lme(as.formula(paste(outc, "~ Mode * Environment * time_min")),
        random = ~ 1 | ParticipantID,
        correlation = corAR1(form = ~ time_10s_step | ParticipantID/PhaseID),
        data = d_ts, method = "REML", na.action = na.omit,
        control = lmeControl(opt = "optim", maxIter = 200, msMaxIter = 200, returnObject = TRUE)),
    error = function(e) NULL
  )

  if (is.null(fit_ar1)) {
    model_audit[[length(model_audit) + 1]] <- data.frame(
      Analysis = "Temporal_AR1", Condition = "Primary_10s", Outcome = outc, Predictor = "time_min*Env*Mode",
      Status = "FAILED_CONVERGENCE", N_rows = nrow(d_ts), N_participants = length(unique(d_ts$ParticipantID)),
      Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "AR(1) model failed to converge",
      stringsAsFactors = FALSE
    )
    next
  }

  model_audit[[length(model_audit) + 1]] <- data.frame(
    Analysis = "Temporal_AR1", Condition = "Primary_10s", Outcome = outc, Predictor = "time_min*Env*Mode",
    Status = "FIT", N_rows = nrow(d_ts), N_participants = length(unique(d_ts$ParticipantID)),
    Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "", stringsAsFactors = FALSE
  )

  tt_ar1 <- summary(fit_ar1)$tTable
  rho_est <- tryCatch(as.numeric(coef(fit_ar1$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)

  for (tname in rownames(tt_ar1)) {
    if (tname == "(Intercept)") next
    temporal_results_list[[length(temporal_results_list) + 1]] <- data.frame(
      Outcome_Group = outc_grp,
      Outcome = outc,
      Clean_Outcome = ifelse(!is.na(clean_labels[outc]), clean_labels[outc], outc),
      Term = tname,
      Estimate = tt_ar1[tname, "Value"],
      SE = tt_ar1[tname, "Std.Error"],
      t_stat = tt_ar1[tname, "t-value"],
      df = tt_ar1[tname, "DF"],
      p_value = tt_ar1[tname, "p-value"],
      AR1_phi = rho_est,
      N_epochs = nrow(d_ts),
      N_participants = length(unique(d_ts$ParticipantID)),
      stringsAsFactors = FALSE
    )
  }
}
temporal_table <- safe_rbind(temporal_results_list)
if (nrow(temporal_table) > 0) {
  temporal_table$q_FDR <- ave(temporal_table$p_value, temporal_table$Term,
                              FUN = function(p) p.adjust(p, method = "BH"))
  temporal_table$FDR_significance <- !is.na(temporal_table$q_FDR) & temporal_table$q_FDR < 0.05
}

# 5. H2: Psychological–Physiological Concurrence ----------------------------
# Evaluates whether acute within-person changes in psychological state across experimental
# phases correspond to concurrent changes in autonomic physiology and ocular metrics.
# Aggregated strictly at the participant-phase level (N = 44).
# Model: wpz(psych) ~ wpz(phys) + (1 | ParticipantID)
cat("[3/6] Evaluating H2 psychophysiological concurrence models...\n")

h2_physio_outcomes <- intersect(sensor_outcomes, names(df))
h2_psych_outcomes  <- intersect(psych_outcomes, names(df))
h2_results_list <- list()

for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  dur_label <- "Matched_start_8min"
  norm_label <- "Within-Person Z-score"

  h2_needed <- unique(c("ParticipantID", "PhaseID", "Mode", "Environment",
                        paste0("wpz__", h2_physio_outcomes), paste0("wpz__", h2_psych_outcomes)))
  h2_needed <- intersect(h2_needed, names(d_cond))

  h2_value_cols <- setdiff(h2_needed, c("ParticipantID", "PhaseID", "Mode", "Environment"))
  h2_phase_df <- aggregate(
    d_cond[h2_value_cols],
    by = d_cond[c("ParticipantID", "PhaseID", "Mode", "Environment")],
    FUN = mean_na
  )
  h2_phase_df$ParticipantID <- factor(h2_phase_df$ParticipantID, levels = PARTICIPANTS)
  h2_phase_df$Mode <- factor(h2_phase_df$Mode, levels = c("Bike", "Walk"))
  h2_phase_df$Environment <- factor(h2_phase_df$Environment, levels = c("Urban", "Green"))

  for (psych_var in h2_psych_outcomes) {
    clean_psych_name <- clean_labels[psych_var]
    if (is.na(clean_psych_name)) clean_psych_name <- psych_var
    psych_col <- paste0("wpz__", psych_var)

    for (phys_var in h2_physio_outcomes) {
      phys_grp <- outcome_group_map[phys_var]
      clean_phys_name <- clean_labels[phys_var]
      if (is.na(clean_phys_name)) clean_phys_name <- phys_var
      phys_col <- paste0("wpz__", phys_var)

      needed_cols <- c("ParticipantID", psych_col, phys_col)
      if (!all(needed_cols %in% names(h2_phase_df))) {
        model_audit[[length(model_audit) + 1]] <- data.frame(
          Analysis = "H2_concurrence", Condition = cname, Outcome = psych_var, Predictor = phys_var,
          Status = "NOT_FIT_MISSING_COLUMN", N_rows = 0, N_participants = 0,
          Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "wpz columns missing",
          stringsAsFactors = FALSE
        )
        next
      }

      d_sub <- h2_phase_df[complete.cases(h2_phase_df[, needed_cols, drop = FALSE]), , drop = FALSE]
      d_sub$psych_z <- d_sub[[psych_col]]
      d_sub$phys_z  <- d_sub[[phys_col]]
      n_pid <- length(unique(d_sub$ParticipantID))

      if (!model_data_ok(d_sub, "phys_z", 20, 8)) {
        model_audit[[length(model_audit) + 1]] <- data.frame(
          Analysis = "H2_concurrence", Condition = cname, Outcome = psych_var, Predictor = phys_var,
          Status = "NOT_FIT_INSUFFICIENT_DATA", N_rows = nrow(d_sub), N_participants = n_pid,
          Temporal_Rho_Not_Used = NA_real_, Warning = "Insufficient complete bouts", Error = "",
          stringsAsFactors = FALSE
        )
        next
      }

      fml_str <- "psych_z ~ phys_z"
      fit_h2 <- fit_phase_lmm(fml_str, d_sub, method = "REML")
      if (is.null(fit_h2)) {
        model_audit[[length(model_audit) + 1]] <- data.frame(
          Analysis = "H2_concurrence", Condition = cname, Outcome = psych_var, Predictor = phys_var,
          Status = "FAILED_CONVERGENCE", N_rows = nrow(d_sub), N_participants = n_pid,
          Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "LMM failed to converge",
          stringsAsFactors = FALSE
        )
        next
      }

      tt_h2 <- summary(fit_h2)$tTable
      if (!"phys_z" %in% rownames(tt_h2)) next

      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "H2_concurrence", Condition = cname, Outcome = psych_var, Predictor = phys_var,
        Status = "FIT", N_rows = nrow(d_sub), N_participants = n_pid,
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "", stringsAsFactors = FALSE
      )

      b_val  <- as.numeric(tt_h2["phys_z", "Value"])
      se_val <- as.numeric(tt_h2["phys_z", "Std.Error"])
      t_val  <- as.numeric(tt_h2["phys_z", "t-value"])
      df_val <- as.numeric(tt_h2["phys_z", "DF"])
      p_val  <- as.numeric(tt_h2["phys_z", "p-value"])
      r_part <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + df_val))

      # Concurrence directional phrasing (association across bouts, never "predicts")
      raw_direction_desc <- if (b_val >= 0) {
        sprintf("Higher %s is associated with higher %s", clean_phys_name, clean_psych_name)
      } else {
        sprintf("Higher %s is associated with lower %s", clean_phys_name, clean_psych_name)
      }

      model_desc <- sprintf("wpz(%s) ~ wpz(%s) + (1|ParticipantID)", psych_var, phys_var)

      h2_results_list[[length(h2_results_list) + 1]] <- data.frame(
        Sub_Hypothesis = "H2.1",
        Model_Type = "Psych_Physio_Concurrence",
        Psychological_Measure = psych_var,
        Physiological_Measure = phys_var,
        Outcome_Group = phys_grp,
        Duration = dur_label,
        Normalization = norm_label,
        Model_Formula = model_desc,
        Raw_Direction = raw_direction_desc,
        Beta_Within_Std = b_val,
        SE = se_val,
        CI95_low = b_val - 1.96 * se_val,
        CI95_high = b_val + 1.96 * se_val,
        t_stat = t_val,
        df = df_val,
        p_value = p_val,
        Partial_r_Within = r_part,
        N_PhaseBouts = nrow(d_sub),
        N_Participants = n_pid,
        stringsAsFactors = FALSE
      )
    }
  }
}

h2_table <- safe_rbind(h2_results_list)
if (nrow(h2_table) > 0) {
  h2_family_key <- paste(h2_table$Duration, h2_table$Normalization, sep = "__")
  h2_table$q_FDR <- ave(h2_table$p_value, h2_family_key,
                        FUN = function(p) p.adjust(p, method = "BH"))
  h2_table$FDR_significance <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05

  # Expanded psychophysiological literature expectation dictionary including frequency-domain HRV
  lit_dict <- list(
    empatica_heart_rate = list(
      pos_exp_sign = -1, interpretability = "Established",
      citation = "Van Doren et al. (2021) Biol Psychol; Ulrich et al. (1991) J Environ Psychol",
      note = "Heart rate decreases during positive/restorative states reflecting reduced cardiovascular strain"
    ),
    empatica_eda_tonic = list(
      pos_exp_sign = -1, interpretability = "Established",
      citation = "Boucsein (2012) Electrodermal Activity; Ulrich et al. (1991) J Environ Psychol",
      note = "Tonic skin conductance level (SCL) decreases with reduced sympathetic arousal"
    ),
    empatica_eda_phasic = list(
      pos_exp_sign = -1, interpretability = "Established",
      citation = "Boucsein (2012) Electrodermal Activity; Dawson et al. (2017) Cambridge Handb Psychophysiol",
      note = "Phasic skin conductance responses (SCR) decrease with lower acute sympathetic reactivity"
    ),
    empatica_hrv_td_rmssd = list(
      pos_exp_sign = 1, interpretability = "Established",
      citation = "Laborde et al. (2017) Front Psychol; Shaffer & Ginsberg (2017) Front Public Health",
      note = "RMSSD increases reflecting greater parasympathetic/vagal tone and autonomic recovery"
    ),
    empatica_hrv_td_sdnn = list(
      pos_exp_sign = 1, interpretability = "Moderate/Cautious",
      citation = "Shaffer & Ginsberg (2017) Front Public Health; Task Force ESC/NASPE (1996) Circulation",
      note = "SDNN reflects overall autonomic variability, generally higher with lower stress"
    ),
    empatica_hrv_fd_hf = list(
      pos_exp_sign = 1, interpretability = "Established",
      citation = "Laborde et al. (2017) Front Psychol; Task Force ESC/NASPE (1996) Circulation",
      note = "High-frequency HRV reflects parasympathetic vagal modulation and increases during calm/restorative states"
    ),
    empatica_hrv_fd_lf_hf_ratio = list(
      pos_exp_sign = -1, interpretability = "Established",
      citation = "Van Doren et al. (2021) Biol Psychol; Pagani et al. (1986) Circ Res",
      note = "LF/HF ratio reflects sympathetic/vagal balance; decreases during relaxed/comfortable psychological states"
    ),
    empatica_hrv_fd_lfnu = list(
      pos_exp_sign = -1, interpretability = "Moderate/Cautious",
      citation = "Task Force ESC/NASPE (1996) Circulation",
      note = "Normalized LF reflects sympathetic dominance; decreases in restorative conditions"
    ),
    empatica_hrv_fd_hfnu = list(
      pos_exp_sign = 1, interpretability = "Moderate/Cautious",
      citation = "Task Force ESC/NASPE (1996) Circulation",
      note = "Normalized HF reflects parasympathetic vagal tone; increases in restorative conditions"
    ),
    empatica_hrv_fd_lf = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Shaffer & Ginsberg (2017) Front Public Health",
      note = "LF power reflects mixed sympathetic, parasympathetic, and baroreflex activity"
    ),
    empatica_hrv_fd_vlf = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Shaffer & Ginsberg (2017) Front Public Health",
      note = "VLF power reflects thermoregulatory, renin-angiotensin, and slow endocrine mechanisms"
    ),
    empatica_hrv_fd_total_power = list(
      pos_exp_sign = 1, interpretability = "Moderate/Cautious",
      citation = "Task Force ESC/NASPE (1996) Circulation",
      note = "Total spectral power reflects overall autonomic capacity"
    ),
    empatica_skin_temperature = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Romanovsky (2014) Handb Clin Neurol; Charkoudian (2010) Auton Neurosci",
      note = "Skin temperature reflects environmental thermal exchange, convective airflow, and vasomotor tone"
    ),
    eyetracker_pupil_diameter_avg = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Cuve et al. (2023) Psychophysiology; Mathot (2018) Front Integr Neurosci",
      note = "Pupil diameter is heavily dominated by ambient retinal illuminance and cognitive visual exploration"
    ),
    eyetracker_pupil_change_rate = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Cuve et al. (2023) Psychophysiology",
      note = "Pupil change rate reflects rapid light transitions and active visual processing across outdoor environments"
    ),
    eyetracker_blink_duration_s = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Schleicher et al. (2008) Ergonomics; Bentivoglio et al. (1997) Mov Disord",
      note = "Blink duration is modulated by ambient airflow, fatigue, visual attention, and emotional valence"
    ),
    eyetracker_fixation_duration_s = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull; Berto et al. (2008) J Environ Psychol",
      note = "Fixation duration depends on scene complexity, visual task demands, and restorative soft fascination"
    ),
    eyetracker_fixation_rate = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull",
      note = "Fixation rate varies with navigation scanning density and movement velocity"
    ),
    eyetracker_saccade_duration_s = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull",
      note = "Saccade kinematics are task- and navigation-driven in active mobility"
    ),
    eyetracker_saccade_amplitude = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull; Franconeri et al. (2013) Trends Cogn Sci",
      note = "Saccade amplitude reflects spatial extent of visual scanning in urban vs green environments"
    ),
    eyetracker_saccade_peak_velocity = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull",
      note = "Saccade peak velocity is constrained by the main sequence and motor exploration requirements"
    ),
    eyetracker_gaze_velocity = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull",
      note = "Overall gaze velocity reflects active physical mobility speed and environmental hazard tracking"
    ),
    eyetracker_gaze_dispersion = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Valtchanov & Ellard (2015) J Environ Psychol",
      note = "Visual dispersion reflects visual exploratory breadth vs concentrated forward path tracking"
    ),
    eyetracker_distance_from_center = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Tatler (2007) J Vis",
      note = "Central visual bias vs peripheral exploration depends on forward travel mode and route obstacles"
    ),
    eyetracker_gaze_centrality = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Tatler (2007) J Vis",
      note = "Forward gaze concentration is heavily governed by cycling vs walking navigation constraints"
    ),
    eyetracker_eyelid_aperture_avg = list(
      pos_exp_sign = NA_real_, interpretability = "Context-dependent",
      citation = "Stern et al. (1994) Psychophysiology",
      note = "Eyelid aperture is directly influenced by solar glare, wind speed, and alertness"
    )
  )

  n_rows <- nrow(h2_table)
  lit_exp_dir <- character(n_rows); lit_interp_cat <- character(n_rows); lit_citation <- character(n_rows)
  h2_result_col <- character(n_rows); h2_interp_col <- character(n_rows)

  for (i in seq_len(n_rows)) {
    p_meas <- h2_table$Psychological_Measure[i]
    y_meas <- h2_table$Physiological_Measure[i]
    is_fdr_sig <- isTRUE(h2_table$FDR_significance[i])
    b_val <- h2_table$Beta_Within_Std[i]
    raw_dir <- h2_table$Raw_Direction[i]

    entry <- lit_dict[[y_meas]]
    interp_cat <- if (!is.null(entry)) entry$interpretability else "Unclassified"
    cit_val <- if (!is.null(entry)) entry$citation else ""

    is_anxiety <- grepl("stai", p_meas, ignore.case = TRUE)
    pos_exp <- if (!is.null(entry)) entry$pos_exp_sign else NA_real_
    exp_sign <- if (!is.na(pos_exp)) (if (is_anxiety) -pos_exp else pos_exp) else NA_real_
    exp_dir_label <- if (is.na(exp_sign)) "Context-dependent" else if (exp_sign > 0) "Positive (+)" else "Negative (-)"

    lit_exp_dir[i] <- exp_dir_label
    lit_interp_cat[i] <- interp_cat
    lit_citation[i] <- cit_val

    if (!is_fdr_sig) {
      h2_result_col[i] <- "No FDR-significant concurrence"
      h2_interp_col[i] <- "No evidence of concurrence (q_FDR >= 0.05)"
    } else {
      h2_result_col[i] <- raw_dir
      if (interp_cat == "Context-dependent" || is.na(exp_sign)) {
        h2_interp_col[i] <- "Significant concurrence; direction not uniquely interpretable"
      } else {
        obs_sign <- sign(b_val)
        if (obs_sign == exp_sign) {
          h2_interp_col[i] <- "Literature-consistent concurrence"
        } else {
          h2_interp_col[i] <- "Opposite to literature-expected direction"
        }
      }
    }
  }

  h2_table$Result <- h2_result_col
  h2_table$Literature_Expected_Direction <- lit_exp_dir
  h2_table$Literature_Interpretability <- lit_interp_cat
  h2_table$Literature_Citation <- lit_citation
  h2_table$H2_Interpretation <- h2_interp_col
  h2_table$Raw_Direction <- NULL
}

# H4 model fitting moved to scripts/H4_multivariate.R.\n\n# 7. Write Dedicated CSV Tables ------------------------------------------------
cat("[5/6] Writing corrected, auditable outputs...\n")

h1_table$Outcome_Sensor <- sapply(h1_table$Outcome, get_outc_sensor)
h1_table$Clean_Outcome  <- ifelse(!is.na(clean_labels[h1_table$Outcome]), clean_labels[h1_table$Outcome], h1_table$Outcome)
h3_table$Outcome_Sensor <- sapply(h3_table$Outcome, get_outc_sensor)
h3_table$Clean_Outcome  <- ifelse(!is.na(clean_labels[h3_table$Outcome]), clean_labels[h3_table$Outcome], h3_table$Outcome)

h2_table$Physiological_Sensor <- sapply(h2_table$Physiological_Measure, get_outc_sensor)
h2_table$Clean_Physiological  <- ifelse(!is.na(clean_labels[h2_table$Physiological_Measure]), clean_labels[h2_table$Physiological_Measure], h2_table$Physiological_Measure)
h2_table$Clean_Psychological  <- ifelse(!is.na(clean_labels[h2_table$Psychological_Measure]), clean_labels[h2_table$Psychological_Measure], h2_table$Psychological_Measure)

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
                  "N_PhaseBouts", "N_Participants", "q_FDR", "FDR_significance",
                  "Literature_Expected_Direction", "Literature_Interpretability",
                  "Literature_Citation", "H2_Interpretation")
h2_clean_table <- h2_table[, intersect(h2_cols_keep, names(h2_table)), drop = FALSE]

safe_write_csv(h1_clean_table, file.path(OUT_DIR, "H1_Green_vs_Urban.csv"))
safe_write_csv(h3_clean_table, file.path(OUT_DIR, "H3_Walk_vs_Bike.csv"))
safe_write_csv(h2_clean_table, file.path(OUT_DIR, "H2_Physio_Psycho_Concordance.csv"))
safe_write_csv(temporal_table, file.path(OUT_DIR, "H1_H3_Temporal_TimeSeries_AR1.csv"))

# Literature interpretation reference companion
lit_companion_df <- do.call(rbind, lapply(names(lit_dict), function(mname) {
  item <- lit_dict[[mname]]
  data.frame(
    Physiological_Measure = mname,
    Clean_Physiological = ifelse(!is.na(clean_labels[mname]), clean_labels[mname], mname),
    Outcome_Group = if (grepl("^empatica", mname)) "Physiological_Autonomic" else "Physiological_Ocular",
    Expected_Direction_Positive_State = if (is.na(item$pos_exp_sign)) "Context-dependent" else if (item$pos_exp_sign > 0) "Higher (+)" else "Lower (-)",
    Expected_Direction_Anxious_State_STAI = if (is.na(item$pos_exp_sign)) "Context-dependent" else if (item$pos_exp_sign > 0) "Lower (-)" else "Higher (+)",
    Interpretability = item$interpretability,
    Literature_Citation = item$citation,
    Theoretical_Note = item$note,
    stringsAsFactors = FALSE
  )
}))
safe_write_csv(lit_companion_df, file.path(OUT_DIR, "H2_Literature_Interpretation.csv"))

# Complete model audit table
model_audit_df <- safe_rbind(model_audit)
safe_write_csv(model_audit_df, file.path(OUT_DIR, "Model_Audit.csv"))

# 8. Forest Plots -------------------------------------------------------------
if (MAKE_FIGURES) {
  cat("[6/6] Rendering primary forest plots...\n")
  
  # H1 & H3 Primary Forest Plot
  plot_df <- data.frame()
  if (nrow(h1_table) > 0 && nrow(h3_table) > 0 &&
      all(c("Family_Set", "Contrast_ID") %in% names(h1_table)) &&
      all(c("Family_Set", "Contrast_ID") %in% names(h3_table))) {
    plot_h1 <- h1_table[h1_table$Family_Set == "Primary" & h1_table$Contrast_ID %in% c("H1_Bike", "H1_Walk"), , drop = FALSE]
    plot_h3 <- h3_table[h3_table$Family_Set == "Primary" & h3_table$Contrast_ID %in% c("H3_Urban", "H3_Green"), , drop = FALSE]
    if (nrow(plot_h1) > 0) plot_h1$Plot_Hypothesis <- "H1: Green vs Urban"
    if (nrow(plot_h3) > 0) plot_h3$Plot_Hypothesis <- "H3: Walk vs Bike"
    plot_df <- rbind(plot_h1, plot_h3)
  }

  if (nrow(plot_df) > 0) {
    plot_df$Clean_Outcome <- clean_labels[plot_df$Outcome]
    plot_df$Clean_Outcome[is.na(plot_df$Clean_Outcome)] <- plot_df$Outcome[is.na(plot_df$Clean_Outcome)]
    plot_df$Direction <- ifelse(
      plot_df$Hypothesis == "H1",
      ifelse(plot_df$Cohens_d_LMM >= 0, "Higher in Green", "Higher in Urban"),
      ifelse(plot_df$Cohens_d_LMM >= 0, "Higher in Walking", "Higher in Biking")
    )
    plot_df$Label <- sprintf("d=%.2f%s", plot_df$Cohens_d_LMM,
                             ifelse(!is.na(plot_df$q_FDR) & plot_df$q_FDR < 0.05, "*", ""))

    p_forest <- ggplot(plot_df, aes(x = Cohens_d_LMM,
                                    y = reorder(Clean_Outcome, Cohens_d_LMM))) +
      geom_vline(xintercept = 0, linetype = "dashed", linewidth = 0.6) +
      geom_errorbar(aes(xmin = CI95_low, xmax = CI95_high),
                    orientation = "y", width = 0.3, linewidth = 0.8) +
      geom_point(size = 2.5) +
      geom_text(aes(label = Label), vjust = -0.7, size = 2.6, show.legend = FALSE) +
      facet_wrap(~ Plot_Hypothesis, scales = "free_x") +
      labs(
        title = "Paper 3 Primary Mixed-Model Standardized Effect Sizes (H1 & H3)",
        subtitle = "REML LMM with Mode*Environment + (1|ParticipantID) on participant-phase units. * FDR q < 0.05.",
        x = "Standardized LMM Cohen's d (95% CI)", y = ""
      ) +
      theme_minimal(base_size = 10)
    ggsave(file.path(OUT_DIR, "Statistical_Results_ForestPlot.png"),
           plot = p_forest, width = 14, height = 11, dpi = 300)
  }

} else {
  cat("[6/6] Figures disabled; statistical outputs only.\n")
}

# 9. Run Manifest --------------------------------------------------------------
script_path <- normalizePath(SCRIPT_PATH, winslash = "/", mustWork = FALSE)

manifest <- data.frame(
  Script = script_path,
  Script_MD5 = tryCatch(unname(tools::md5sum(script_path)), error = function(e) NA_character_),
  Input_File = RAW_PATH,
  Key_File = ifelse(file.exists(KEY_PATH), KEY_PATH, NA_character_),
  Input_Schema = "Prefixed validated schema",
  Input_MD5 = tryCatch(unname(tools::md5sum(RAW_PATH)), error = function(e) NA_character_),
  Input_Rows = nrow(df),
  Input_Columns = ncol(df),
  Input_Indoor_Rows = sum(df$PhaseID == "Indoor", na.rm = TRUE),
  Input_Tram_Rows = sum(df$PhaseID == "Tram", na.rm = TRUE),
  Available_Declared_Outcomes = length(intersect(all_outcomes, names(df))),
  Missing_Declared_Outcomes = paste(setdiff(all_outcomes, names(df)), collapse = ","),
  Common_Duration_Min_Sec = if (any(is.finite(route$matched_cap_sec))) min(route$matched_cap_sec, na.rm = TRUE) else NA_real_,
  Common_Duration_Max_Sec = if (any(is.finite(route$matched_cap_sec))) max(route$matched_cap_sec, na.rm = TRUE) else NA_real_,
  Primary_Sensor_Model = "REML participant-phase-mean LMM; Mode*Environment + (1|ParticipantID); matched first-8-minutes",
  Primary_Questionnaire_Model = "REML phase-level LMM; Mode*Environment + (1|ParticipantID); one row per participant x phase (N=44)",
  Matched_Duration_Sensitivity = "Participant-specific common duration across BikeU/BikeG/WalkU/WalkG, capped at 8 minutes from phase start",
  Normalization = "Within-Person Z-score calculated strictly on core outdoor experimental routes (BikeU, BikeG, WalkU, WalkG); zero Indoor or Tram baseline contamination",
  H2_Method = "Within-person psychophysiological concurrence mixed models (Van Doren 2021; Cuve 2023) across 104 pairs (4 questionnaires x 26 autonomic/ocular outcomes)",
  Multiple_Testing = "Benjamini-Hochberg FDR (q < 0.05) within declared hypothesis families",
  N_Participants = length(PARTICIPANTS),
  N_Declared_Outcomes = length(all_outcomes),
  Completed_At = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
  H1_Primary_Significant_FDR = if (nrow(h1_table) > 0) sum(h1_table$Family_Set == "Primary" & !is.na(h1_table$q_FDR) & h1_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  H3_Primary_Significant_FDR = if (nrow(h3_table) > 0) sum(h3_table$Family_Set == "Primary" & !is.na(h3_table$q_FDR) & h3_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  H2_Significant_FDR = if (nrow(h2_table) > 0) sum(!is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  Total_Attempted_Models_Audited = nrow(model_audit_df),
  Failed_or_Unstable_Models = if (nrow(model_audit_df) > 0) sum(grepl("NOT_FIT|FAILED_CONVERGENCE|UNSTABLE", model_audit_df$Status)) else 0,
  stringsAsFactors = FALSE
)
write.csv(manifest, file.path(OUT_DIR, "Run_Manifest.csv"), row.names = FALSE, na = "")

# 10. Combined Results Export --------------------------------------------------
result_tables <- list(H1 = h1_clean_table, H2 = h2_clean_table,
                      H3 = h3_clean_table)
result_tables <- Map(function(tab, hyp) {
  tab$Hypothesis <- hyp
  tab
}, result_tables, names(result_tables))
all_result_cols <- unique(unlist(lapply(result_tables, names)))
results_h1_3 <- do.call(rbind, lapply(result_tables, function(tab) {
  for (nm in setdiff(all_result_cols, names(tab))) tab[[nm]] <- NA
  tab[all_result_cols]
}))
rownames(results_h1_3) <- NULL
safe_write_csv(results_h1_3, file.path(OUT_DIR, "results_H1-H3.csv"))

results_h1_h3 <- rbind(result_tables$H1, result_tables$H3)
safe_write_csv(results_h1_h3, file.path(OUT_DIR, "results_H1_H3.csv"))

cat("   Combined H1-H3 results:", nrow(results_h1_3), "rows /", ncol(results_h1_3), "columns\n")
cat("   Combined H1-H3 results:", nrow(results_h1_h3), "rows /", ncol(results_h1_h3), "columns\n")
cat(sprintf("   Model Audit Logged: %d total attempted models (%d fits, %d non-fits/skips logged)\n",
            nrow(model_audit_df), sum(model_audit_df$Status == "FIT"),
            sum(model_audit_df$Status != "FIT")))
cat("\nSUCCESS: Archived H1-H3 statistical analysis pipeline finished. The current H4 implementation is scripts/H4_multivariate.R.\n")

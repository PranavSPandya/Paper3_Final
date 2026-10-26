# ==============================================================================
# SCRIPT: H1_to_H3.R
# PURPOSE: Auditable participant-phase inferential analysis for Paper 3 (H1, H2, H3).
#          H4 lives in scripts/H4_multivariate.R.
#          Key methodological foundations:
#            - Input: participant-matched first 8 minutes per core phase
#              (output/merged_all_11participants_8min.csv). Script stops if any core
#              phase spans more than 480 s, so all models use the matched window only.
#            - H1/H3 sensor streams: one participant-phase mean per condition (REML LMM).
#            - H1/H3 questionnaires: one participant-phase row (never duplicated across 10-s epochs).
#            - Planned simple contrasts: BikeG-BikeU, WalkG-WalkU, WalkU-BikeU, WalkG-BikeG,
#              named by PhaseID (BikeU_BikeG, WalkU_WalkG, BikeU_WalkU, BikeG_WalkG) plus the
#              difference-of-differences test. BH-FDR uses the planned family size.
#            - Outcome units (primary): notebook transforms (scripts/Normalization_H1toH4_physio.csv:
#              ln(x) for 7 HRV outcomes, others native) + participant random intercept.
#            - Sensitivity: same model on within-person z-scores (after the transform) over the
#              4 core outdoor phases on 10-s epochs; separate BH-FDR family; no Indoor/Tram reference.
#            - H1/H3 outcomes: 26 physiological measures only; questionnaires are used only in H2.
#            - Temporal sensitivity: 10-s AR(1) LMMs on the same within-person z outcomes and
#              the same matched 8-min window; duplicates stop the run, NA exclusions are logged.
#            - H2: within-person repeated-measures correlation (rmcorr) across the 4 core phases
#              (Bakdash & Marusich 2017, Front Psychol 8:456, doi:10.3389/fpsyg.2017.00456);
#              4 questionnaires x all 26 physiological outcomes, one BH-FDR family of 104.
#            - Complete model audit logging in Model_Audit.csv.
# ==============================================================================

suppressPackageStartupMessages({
  library(nlme)
  library(emmeans)
  library(ggplot2)
  library(statpsych)
})
emm_options(msg.interaction = FALSE)

# 1. Configuration & dictionaries ---------------------------------------------
WD <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
PROJECT_ROOT <- if (basename(WD) == "scripts") dirname(WD) else WD
SIBLING_DATA_ROOT <- file.path(dirname(PROJECT_ROOT), "Paper3_Github")

# LOCKED: the only valid input is the participant-matched first-8-min file (no env override).
RAW_PATH <- file.path(PROJECT_ROOT, "output", "merged_all_11participants_8min.csv")
if (basename(RAW_PATH) != "merged_all_11participants_8min.csv") stop("H1_to_H3.R must use merged_all_11participants_8min.csv only.")
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


# Units of the RAW participant-phase means (Reference_Mean_raw / Comparison_Mean_raw), taken from the column-name
# suffixes and clean_labels. HRV raw means are on the native scale (ms / ms^2); only SMD_paired_Bonett and H2 rmcorr
# use ln(x) for the seven HRV_LOG outcomes. "not specified in source data" = no unit given in the column name or label.
OUTCOME_UNITS <- c(
  questionnaire_current_comfort_1_7  = "rating scale points (1-7)",
  questionnaire_pleasantness_1_5     = "rating scale points (1-5)",
  questionnaire_stai6_mean_1_5       = "rating scale points (mean item score, 1-5)",
  questionnaire_prs11_total_mean_1_5 = "rating scale points (mean item score, 1-5)",
  empatica_heart_rate          = "bpm",
  empatica_eda_tonic           = "uS (microsiemens)",
  empatica_eda_phasic          = "uS (microsiemens)",
  empatica_skin_temperature    = "degC",
  empatica_hrv_td_sdnn         = "ms",
  empatica_hrv_td_rmssd        = "ms",
  empatica_hrv_fd_lf           = "ms^2",
  empatica_hrv_fd_hf           = "ms^2",
  empatica_hrv_fd_lf_hf_ratio  = "unitless (ratio)",
  empatica_hrv_fd_lfnu         = "normalized units (n.u.)",
  empatica_hrv_fd_hfnu         = "normalized units (n.u.)",
  empatica_hrv_fd_vlf          = "ms^2",
  empatica_hrv_fd_total_power  = "ms^2",
  eyetracker_pupil_diameter_avg    = "mm",
  eyetracker_pupil_change_rate     = "not specified in source data",
  eyetracker_blink_duration_s      = "s",
  eyetracker_fixation_duration_s   = "s",
  eyetracker_fixation_rate         = "per s",
  eyetracker_saccade_duration_s    = "s",
  eyetracker_saccade_amplitude     = "deg",
  eyetracker_saccade_peak_velocity = "deg/s",
  eyetracker_gaze_velocity         = "deg/s",
  eyetracker_gaze_dispersion       = "not specified in source data",
  eyetracker_gaze_centrality       = "not specified in source data",
  eyetracker_distance_from_center  = "px",
  eyetracker_eyelid_aperture_avg   = "mm")
# Units as analysed in H2 (ln(x) applied to the seven HRV_LOG outcomes before rmcorr)
H2_LOG_UNITS <- c(empatica_hrv_td_sdnn = "ln(ms)", empatica_hrv_td_rmssd = "ln(ms)", empatica_hrv_fd_lf = "ln(ms^2)",
                  empatica_hrv_fd_hf = "ln(ms^2)", empatica_hrv_fd_lf_hf_ratio = "ln(ratio), unitless",
                  empatica_hrv_fd_vlf = "ln(ms^2)", empatica_hrv_fd_total_power = "ln(ms^2)")
units_of <- function(v) unname(ifelse(!is.na(OUTCOME_UNITS[v]), OUTCOME_UNITS[v], "not specified in source data"))

# Plain words for "higher"/"lower" per physiological measure, used in the H2 Direction sentence
DIRECTION_WORDS <- list(
  empatica_heart_rate              = c("faster", "slower"),
  empatica_skin_temperature        = c("warmer", "cooler"),
  eyetracker_pupil_diameter_avg    = c("larger", "smaller"),
  eyetracker_blink_duration_s      = c("longer", "shorter"),
  eyetracker_fixation_duration_s   = c("longer", "shorter"),
  eyetracker_saccade_duration_s    = c("longer", "shorter"),
  eyetracker_saccade_amplitude     = c("larger", "smaller"),
  eyetracker_saccade_peak_velocity = c("faster", "slower"),
  eyetracker_gaze_velocity         = c("faster", "slower"),
  eyetracker_eyelid_aperture_avg   = c("wider", "narrower"),
  eyetracker_distance_from_center  = c("farther from centre", "closer to centre"))
dir_word <- function(v, up) vapply(seq_along(v), function(i) {
  w <- DIRECTION_WORDS[[v[i]]]; if (is.null(w)) w <- c("higher", "lower"); if (isTRUE(up[i])) w[1] else w[2] }, character(1))

# Method citations (verified 2026-10-11 via live search; local PDFs in Paper3_Github/Experiment papers/H1 to H4/)
CITE_LMM   <- "Pinheiro JC, Bates DM (2000) Mixed-Effects Models in S and S-PLUS. Springer, New York. doi:10.1007/b98882 (R package nlme)"
CITE_EMM   <- "Lenth R (2023) emmeans: Estimated Marginal Means, aka Least-Squares Means. R package version 1.8.4-1. https://CRAN.R-project.org/package=emmeans"
CITE_FDR   <- "Benjamini Y, Hochberg Y (1995) J R Stat Soc B 57(1):289-300. doi:10.1111/j.2517-6161.1995.tb02031.x"
CITE_WPZ   <- "Ben-Shakhar G (1985) Standardization within individuals: a simple method to neutralize individual differences in skin conductance. Psychophysiology 22(3):292-299. doi:10.1111/j.1469-8986.1985.tb01603.x"
CITE_SMD   <- "Bonett DG (2008) Confidence intervals for standardized linear contrasts of means. Psychol Methods 13(2):99-109. doi:10.1037/1082-989X.13.2.99 (R package statpsych::ci.stdmean.ps)"
CITE_RMC   <- "Bakdash JZ, Marusich LR (2017) Repeated Measures Correlation. Front Psychol 8:456. doi:10.3389/fpsyg.2017.00456"

# Planned H1/H3 contrasts, named only by PhaseID. Beta = second PhaseID minus first PhaseID.
H13_CONTRASTS <- data.frame(
  Hypothesis         = c("H1", "H1", "H3", "H3"),
  Sub_Hypothesis     = c("H1.1", "H1.2", "H3.1", "H3.2"),
  Reference_PhaseID  = c("BikeU", "WalkU", "BikeU", "BikeG"),
  Comparison_PhaseID = c("BikeG", "WalkG", "WalkU", "WalkG"),
  stringsAsFactors = FALSE)
H13_CONTRASTS$Contrast <- paste(H13_CONTRASTS$Reference_PhaseID, H13_CONTRASTS$Comparison_PhaseID, sep = "_")

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

# Effect size for H1/H3 contrasts: paired-samples standardized mean difference, Bonett (2008),
# Psychological Methods 13(2):99-109, doi:10.1037/1082-989X.13.2.99, via the author's published R package
# statpsych::ci.stdmean.ps (square-root unweighted-variance standardizer sqrt((SD1^2 + SD2^2)/2), equal
# variances not assumed). Reported: bias-adjusted estimate with Bonett's 95% CI.
# Computed on participant-phase means in analysis units (notebook transform: ln(x) for HRV_LOG_ES, else native).
# Within-person z-scores are NOT used: their residual SD is shrunk by person-standardisation plus averaging
# ~48 epochs per phase, which inflated the earlier model-based d. p-values and q-values stay from the LMM.
# Outcome transforms come from the Normalization notebook (scripts/Normalization_H1toH4_physio.csv): ln(x) where
# "Transformation in Step 5" starts with "Natural log" (x <= 0 -> NA); all other outcomes untransformed.
# Applied once to the 10-s rows (section 4), before z-scoring, phase means, SMD and H2 rmcorr.
NB_TRANSFORM <- read.csv(file.path(PROJECT_ROOT, "scripts", "Normalization_H1toH4_physio.csv"), check.names = FALSE)
HRV_LOG_ES <- NB_TRANSFORM$Column[startsWith(NB_TRANSFORM$`Transformation in Step 5`, "Natural log")]
paired_smd <- function(d, outcome, ref, comp) {
  na3 <- c(g = NA_real_, low = NA_real_, high = NA_real_)
  if (!outcome %in% names(d)) return(na3)
  m <- merge(d[ref, c("ParticipantID", outcome)], d[comp, c("ParticipantID", outcome)],
             by = "ParticipantID", suffixes = c(".ref", ".comp"))
  x <- as.numeric(m[[2]]); y <- as.numeric(m[[3]])
  ok <- is.finite(x) & is.finite(y); x <- x[ok]; y <- y[ok]
  if (length(x) < 4 || sd(x) == 0 || sd(y) == 0) return(na3)
  ci <- statpsych::ci.stdmean.ps(0.05, mean(y), mean(x), sd(y), sd(x), cor(x, y), length(x))
  c(g = ci[1, "adj Estimate"], low = ci[1, "LL"], high = ci[1, "UL"])
}

extract_h1_h3 <- function(fit, d, outcome, family_set, value_col) {
  lv <- levels(d$PhaseID)
  wvec <- function(plus, minus) { w <- setNames(rep(0, length(lv)), lv); w[plus] <- 1; w[minus] <- -1; unname(w) }
  em <- emmeans(fit, ~ PhaseID)
  cm <- setNames(lapply(seq_len(nrow(H13_CONTRASTS)), function(i)
    wvec(H13_CONTRASTS$Comparison_PhaseID[i], H13_CONTRASTS$Reference_PhaseID[i])), H13_CONTRASTS$Contrast)
  cc <- as.data.frame(summary(contrast(em, method = cm), infer = c(TRUE, TRUE)))
  # Difference of differences across the 2x2 layout: (BikeG - BikeU) - (WalkG - WalkU)
  ii <- as.data.frame(summary(contrast(em, method = list(DiD = wvec(c("BikeG", "WalkU"), c("BikeU", "WalkG")))),
                              infer = c(TRUE, TRUE)))
  int_txt <- sprintf("(BikeG - BikeU) - (WalkG - WalkU) = %.3f, t(%d) = %.2f, p = %.4f",
                     ii$estimate, round(ii$df), ii$t.ratio, ii$p.value)
  do.call(rbind, lapply(seq_len(nrow(H13_CONTRASTS)), function(i) {
    k <- H13_CONTRASTS[i, ]
    ref <- d$PhaseID == k$Reference_PhaseID; comp <- d$PhaseID == k$Comparison_PhaseID
    es <- paired_smd(d, outcome, ref, comp)
    est <- cc$estimate[i]
    data.frame(
      Hypothesis = k$Hypothesis, Sub_Hypothesis = k$Sub_Hypothesis, Contrast = k$Contrast,
      Reference_PhaseID = k$Reference_PhaseID, Comparison_PhaseID = k$Comparison_PhaseID,
      Outcome = outcome,
      Direction = if (is.finite(est)) sprintf("%s is %s in %s than in %s", outcome,
                    ifelse(est > 0, "higher", "lower"), k$Comparison_PhaseID, k$Reference_PhaseID) else NA_character_,
      Beta = est, SE = cc$SE[i], df = cc$df[i], t_ratio = cc$t.ratio[i], p_value = cc$p.value[i],
      Reference_Mean_raw = mean(d[[outcome]][ref], na.rm = TRUE),
      Comparison_Mean_raw = mean(d[[outcome]][comp], na.rm = TRUE),
      N_Participants = length(intersect(d$ParticipantID[ref], d$ParticipantID[comp])),
      SMD_paired_Bonett = unname(es["g"]), SMD_CI95_low = unname(es["low"]), SMD_CI95_high = unname(es["high"]),
      Model_Formula = sprintf("lme(%s ~ PhaseID, random = ~1 | ParticipantID); Beta = %s - %s",
                              value_col, k$Comparison_PhaseID, k$Reference_PhaseID),
      Interaction_Test = int_txt,
      Normalization = if (startsWith(value_col, "wpz__")) "Sensitivity: within-person z-score over the 4 PhaseIDs (after notebook transform)" else "Primary: analysis units (notebook transform), random intercept",
      Family_Set = family_set, Contrast_ID = k$Contrast,
      stringsAsFactors = FALSE)
  }))
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
    tab$q_FDR[idx] <- p.adjust(p, method = "BH", n = planned_n)
    tab$Family_Size[idx] <- planned_n
  }

  tab$FDR_significant <- !is.na(tab$q_FDR) & tab$q_FDR < 0.05
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

# H4 environmental predictor selection/audit: see scripts/H4_multivariate.R.

# Route Dataset Preparation & FROZEN Within-Person Standardization -------------
# Golden rule: Standardization reference is strictly the participant's observations
# during the 4 active outdoor experimental trials (BikeU, BikeG, WalkU, WalkG).
# Zero Indoor or Tram baseline contamination.
route <- df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ]
route$Datetime           <- as.POSIXct(route$Datetime, tz = "UTC")
if (anyNA(route$Datetime)) stop("Unparseable Datetime values found in core route data.")
phase_span <- aggregate(as.numeric(route$Datetime), by = route[c("ParticipantID", "PhaseID")],
                        FUN = function(x) max(x) - min(x))
if (any(phase_span$x > MATCHED_CAP_SEC)) {
  bad <- phase_span[phase_span$x > MATCHED_CAP_SEC, ]
  stop("Input is not the matched 8-min file; phases longer than 480 s: ",
       paste(bad$ParticipantID, bad$PhaseID, bad$x, sep = "/", collapse = ", "))
}
route$ParticipantID      <- factor(route$ParticipantID, levels = PARTICIPANTS)
route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]

# Notebook transforms on the 10-s rows, before z-scores and phase means
for (v in intersect(HRV_LOG_ES, names(route))) route[[v]] <- ifelse(route[[v]] > 0, log(route[[v]]), NA_real_)
# Compute Within-Person Z-scores strictly across the 4 core routes (sensitivity analysis + temporal AR(1))
within_person_vars <- unique(c(sensor_outcomes, psych_outcomes))
within_person_vars <- intersect(within_person_vars, names(route))
# Sensors: z across the 10-s epochs of the 4 core phases (equal epochs per phase in the matched file).
for (v in intersect(sensor_outcomes, within_person_vars)) {
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

# H4 VIF selection: see scripts/H4_multivariate.R.

# 4. H1 & H3 Inferential Models (26 physiological outcomes) ----------------------
cat("[2/6] Fitting H1/H3 models across the 26 physiological outcomes (questionnaires are H2 only)...\n")
h13_list <- list(); model_audit <- list()

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
    by = d_cond[c("ParticipantID", "PhaseID")],
    FUN = mean_na
  )
  phase_df$ParticipantID <- factor(phase_df$ParticipantID, levels = PARTICIPANTS)
  phase_df$PhaseID <- factor(phase_df$PhaseID, levels = CORE_PHASES)

  for (family_set in c("Primary", "Sensitivity_WPZ"))
  for (outcome in intersect(sensor_outcomes, names(d_cond))) {   # physio only; questionnaires belong to H2
    value_col <- if (family_set == "Primary") outcome else paste0("wpz__", outcome)
    outc_grp <- outcome_group_map[outcome]
    
    if (!value_col %in% names(phase_df)) {
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = paste0("H1H3_phase_mean_", family_set), Condition = cname, Outcome = outcome, Predictor = "PhaseID",
        Status = "NOT_FIT_MISSING_COLUMN", N_rows = 0, N_participants = 0,
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = paste(value_col, "column missing"),
        stringsAsFactors = FALSE
      )
      next
    }

    d <- phase_df[complete.cases(phase_df[, c(value_col, "PhaseID", "ParticipantID")]), ]
    d$outcome_z <- d[[value_col]]
    n_pid <- length(unique(d$ParticipantID))

    if (!model_data_ok(d, "outcome_z", 24, 8)) {
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = paste0("H1H3_phase_mean_", family_set), Condition = cname, Outcome = outcome, Predictor = "PhaseID",
        Status = "NOT_FIT_INSUFFICIENT_DATA", N_rows = nrow(d), N_participants = n_pid,
        Temporal_Rho_Not_Used = NA_real_, Warning = "Fewer than 24 bouts or 8 participants", Error = "",
        stringsAsFactors = FALSE
      )
      next
    }

    fml <- "outcome_z ~ PhaseID"
    fit <- fit_phase_lmm(fml, d, method = "REML")
    if (is.null(fit)) {
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = paste0("H1H3_phase_mean_", family_set), Condition = cname, Outcome = outcome, Predictor = "PhaseID",
        Status = "FAILED_CONVERGENCE", N_rows = nrow(d), N_participants = n_pid,
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "nlme::lme failed to converge",
        stringsAsFactors = FALSE
      )
      next
    }

    model_audit[[length(model_audit) + 1]] <- data.frame(
      Analysis = paste0("H1H3_phase_mean_", family_set), Condition = cname, Outcome = outcome, Predictor = "PhaseID",
      Status = "FIT", N_rows = nrow(d), N_participants = n_pid,
      Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "", stringsAsFactors = FALSE
    )

    h13_list[[length(h13_list) + 1]] <- extract_h1_h3(fit, d, outcome, family_set, value_col)
  }
}

N_PLANNED_ALL_OUTCOMES <- length(sensor_outcomes)
all_h13_family_sizes <- c(Primary = N_PLANNED_ALL_OUTCOMES, Sensitivity_WPZ = N_PLANNED_ALL_OUTCOMES)
h13_table <- adjust_by_family(safe_rbind(h13_list), all_h13_family_sizes)
h1_table <- h13_table[h13_table$Hypothesis == "H1", , drop = FALSE]
h3_table <- h13_table[h13_table$Hypothesis == "H3", , drop = FALSE]

# 4D. Temporal Time-Series Mixed Models with AR(1) Autocorrelation -------------
cat("[2b/6] Fitting 10-second temporal time-series LMMs with AR(1) autocorrelation...\n")
temporal_results_list <- list()
temporal_sens_list <- list()
route_ar1 <- CONDITIONS[[1]]   # same matched first-8-min window as the primary models
route_ar1$time_10s_step <- round(route_ar1$time_in_phase_sec / 10)
route_ar1$PhaseID <- factor(route_ar1$PhaseID, levels = CORE_PHASES)
step_key <- paste(route_ar1$ParticipantID, route_ar1$PhaseID, route_ar1$time_10s_step)
if (anyDuplicated(step_key)) {
  stop("Temporal AR(1): ", sum(duplicated(step_key)),
       " duplicate participant/phase/10-s steps; fix the epoch grid upstream instead of dropping rows.")
}

for (outc in sensor_outcomes) {
  outc_grp <- outcome_group_map[outc]
  zc <- paste0("wpz__", outc)
  needed <- c("ParticipantID", "PhaseID", "time_min", "time_10s_step", zc)
  keep <- complete.cases(route_ar1[, needed, drop = FALSE])
  n_na_excluded <- sum(!keep)
  d_ts <- route_ar1[keep, needed, drop = FALSE]
  d_ts$outcome_z <- d_ts[[zc]]
  d_ts <- d_ts[order(d_ts$ParticipantID, d_ts$PhaseID, d_ts$time_10s_step), ]
  na_note <- sprintf("NA epochs excluded: %d of %d", n_na_excluded, nrow(route_ar1))
  if (!model_data_ok(d_ts, "outcome_z", 100, 8)) {
    model_audit[[length(model_audit) + 1]] <- data.frame(
      Analysis = "Temporal_AR1", Condition = "Primary_10s_matched_8min", Outcome = outc, Predictor = "PhaseID*time_min",
      Status = "NOT_FIT_INSUFFICIENT_DATA", N_rows = nrow(d_ts), N_participants = length(unique(d_ts$ParticipantID)),
      Temporal_Rho_Not_Used = NA_real_, Warning = paste("Insufficient time-series rows;", na_note), Error = "",
      stringsAsFactors = FALSE
    )
    next
  }

  # AR(1) residual correlation: Pinheiro JC, Bates DM (2000) Mixed-Effects Models in S and S-PLUS. Springer. doi:10.1007/b98882
  # Primary fit is unchanged (optim). Only if it fails, retry with the same nlminb -> optim fallback used in
  # H4_multivariate.R (lmeControl maxIter = 100, msMaxIter = 150, corAR1 start value = 0.2). No other model changes.
  fit_ar1_with_fallback <- function(dd, step_var) {
    ar1_form <- as.formula(paste("~", step_var, "| ParticipantID/PhaseID"))
    fit_one <- function(opt, primary) {
      ctl <- if (primary) lmeControl(opt = "optim", maxIter = 200, msMaxIter = 200, returnObject = TRUE) else
        lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = opt)
      cs <- if (primary) corAR1(form = ar1_form) else corAR1(value = 0.2, form = ar1_form)
      tryCatch(lme(outcome_z ~ PhaseID * time_min, random = ~ 1 | ParticipantID, correlation = cs,
                   data = dd, method = "REML", na.action = na.omit, control = ctl),
               error = function(e) NULL)
    }
    f <- fit_one("optim", TRUE)
    if (!is.null(f)) return(list(fit = f, method = "optim (primary)"))
    f <- fit_one("nlminb", FALSE)
    if (!is.null(f)) return(list(fit = f, method = "nlminb (fallback, as in H4_multivariate.R)"))
    f <- fit_one("optim", FALSE)
    if (!is.null(f)) return(list(fit = f, method = "optim (fallback, as in H4_multivariate.R)"))
    list(fit = NULL, method = "none (not converged)")
  }

  fr <- fit_ar1_with_fallback(d_ts, "time_10s_step")
  fit_ar1 <- fr$fit
  all_terms <- colnames(model.matrix(~ PhaseID * time_min, data = d_ts))[-1]

  # Sensitivity: 60-s epoch means (6 x 10-s epochs). Chosen over 30-s because averaging over a longer window
  # lowers the near-unit lag-1 autocorrelation seen at 10 s while still leaving 8 points per participant-phase.
  d_60 <- d_ts
  d_60$time_60s_step <- floor(d_60$time_10s_step / 6)
  d_60 <- aggregate(cbind(outcome_z, time_min) ~ ParticipantID + PhaseID + time_60s_step, data = d_60, FUN = mean)
  d_60$PhaseID <- factor(d_60$PhaseID, levels = CORE_PHASES)
  d_60 <- d_60[order(d_60$ParticipantID, d_60$PhaseID, d_60$time_60s_step), ]
  fr60 <- fit_ar1_with_fallback(d_60, "time_60s_step")
  tt60 <- if (!is.null(fr60$fit)) summary(fr60$fit)$tTable else NULL
  rho60 <- if (!is.null(fr60$fit)) tryCatch(as.numeric(coef(fr60$fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_) else NA_real_
  for (tname in all_terms) {
    has60 <- !is.null(tt60) && tname %in% rownames(tt60)
    temporal_sens_list[[length(temporal_sens_list) + 1]] <- data.frame(
      Outcome_Group = outc_grp, Outcome = outc,
      Clean_Outcome = ifelse(!is.na(clean_labels[outc]), clean_labels[outc], outc),
      Term = tname,
      Model_Formula = sprintf("lme(mean wpz__%s per 60-s epoch ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_60s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU", outc),
      Beta_60s = if (has60) tt60[tname, "Value"] else NA_real_,
      SE_60s = if (has60) tt60[tname, "Std.Error"] else NA_real_,
      p_value_60s = if (has60) tt60[tname, "p-value"] else NA_real_,
      AR1_phi_60s = rho60, Fit_Method_60s = fr60$method,
      N_epochs_60s = nrow(d_60), stringsAsFactors = FALSE
    )
  }

  if (is.null(fit_ar1)) {
    model_audit[[length(model_audit) + 1]] <- data.frame(
      Analysis = "Temporal_AR1", Condition = "Primary_10s_matched_8min", Outcome = outc, Predictor = "PhaseID*time_min",
      Status = "FAILED_CONVERGENCE", N_rows = nrow(d_ts), N_participants = length(unique(d_ts$ParticipantID)),
      Temporal_Rho_Not_Used = NA_real_, Warning = na_note, Error = "AR(1) model failed to converge (optim, nlminb and optim fallbacks)",
      stringsAsFactors = FALSE
    )
    for (tname in all_terms) {
      temporal_results_list[[length(temporal_results_list) + 1]] <- data.frame(
        Outcome_Group = outc_grp, Outcome = outc,
        Clean_Outcome = ifelse(!is.na(clean_labels[outc]), clean_labels[outc], outc),
        Term = tname,
        Model_Formula = sprintf("lme(wpz__%s ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_10s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU", outc),
        Normalization = "Within-Person Z-score", Duration = "Matched_start_8min",
        Beta = NA_real_, SE = NA_real_, t_stat = NA_real_, df = NA_real_, p_value = NA_real_, AR1_phi = NA_real_,
        N_epochs = nrow(d_ts), N_participants = length(unique(d_ts$ParticipantID)),
        Fit_Method = fr$method, Status = "FAILED_CONVERGENCE", stringsAsFactors = FALSE
      )
    }
    next
  }

  model_audit[[length(model_audit) + 1]] <- data.frame(
    Analysis = "Temporal_AR1", Condition = "Primary_10s_matched_8min", Outcome = outc, Predictor = "PhaseID*time_min",
    Status = "FIT", N_rows = nrow(d_ts), N_participants = length(unique(d_ts$ParticipantID)),
    Temporal_Rho_Not_Used = NA_real_, Warning = paste0(na_note, "; fit method: ", fr$method), Error = "", stringsAsFactors = FALSE
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
      Model_Formula = sprintf("lme(wpz__%s ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_10s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU", outc),
      Normalization = "Within-Person Z-score",
      Duration = "Matched_start_8min",
      Beta = tt_ar1[tname, "Value"],
      SE = tt_ar1[tname, "Std.Error"],
      t_stat = tt_ar1[tname, "t-value"],
      df = tt_ar1[tname, "DF"],
      p_value = tt_ar1[tname, "p-value"],
      AR1_phi = rho_est,
      N_epochs = nrow(d_ts),
      N_participants = length(unique(d_ts$ParticipantID)),
      Fit_Method = fr$method, Status = "FIT",
      stringsAsFactors = FALSE
    )
  }
}
temporal_table <- safe_rbind(temporal_results_list)
# BH-FDR family = one Term across all planned sensor outcomes (26), whether or not each model converged
# (same planned-family convention as adjust_by_family for H1/H3). Benjamini Y, Hochberg Y (1995) J R Stat Soc B 57:289-300.
TEMPORAL_FAMILY_N <- length(sensor_outcomes)
if (nrow(temporal_table) > 0) {
  temporal_table$Family_Size <- TEMPORAL_FAMILY_N
  temporal_table$q_FDR <- ave(temporal_table$p_value, temporal_table$Term,
                              FUN = function(p) p.adjust(p, method = "BH", n = TEMPORAL_FAMILY_N))
  temporal_table$FDR_significant <- !is.na(temporal_table$q_FDR) & temporal_table$q_FDR < 0.05
  temporal_table$Stability_Flag <- ifelse(temporal_table$Status != "FIT", "not converged",
                                          ifelse(!is.na(temporal_table$AR1_phi) & temporal_table$AR1_phi > 0.95,
                                                 "rho > 0.95, interpret cautiously", ""))
}
temporal_sens_table <- safe_rbind(temporal_sens_list)
if (nrow(temporal_sens_table) > 0) {
  temporal_sens_table$Family_Size <- TEMPORAL_FAMILY_N
  temporal_sens_table$q_FDR_60s <- ave(temporal_sens_table$p_value_60s, temporal_sens_table$Term,
                                       FUN = function(p) p.adjust(p, method = "BH", n = TEMPORAL_FAMILY_N))
  temporal_sens_table$FDR_significant_60s <- !is.na(temporal_sens_table$q_FDR_60s) & temporal_sens_table$q_FDR_60s < 0.05
  prim <- temporal_table[, c("Outcome", "Term", "Beta", "p_value", "q_FDR", "FDR_significant", "AR1_phi", "Fit_Method", "Stability_Flag")]
  temporal_sens_table <- merge(prim, temporal_sens_table, by = c("Outcome", "Term"), all = TRUE, sort = FALSE)
  temporal_sens_table$Same_Sign_As_Primary <- sign(temporal_sens_table$Beta) == sign(temporal_sens_table$Beta_60s)
  temporal_sens_table$Primary_Holds_In_60s <- temporal_sens_table$FDR_significant %in% TRUE &
    temporal_sens_table$FDR_significant_60s %in% TRUE & temporal_sens_table$Same_Sign_As_Primary %in% TRUE
}

# 5. H2: Psychological–Physiological Concurrence ----------------------------
# Evaluates whether acute within-person changes in psychological state across experimental
# phases correspond to concurrent changes in autonomic physiology and ocular metrics.
# Aggregated strictly at the participant-phase level (N = 44).
# H2: within-person rmcorr across the 4 core phases; each participant is their own reference
# (Bakdash & Marusich 2017, Front Psychol 8:456). 4 questionnaires x 26 physiological outcomes = 104 pairs; one BH-FDR family.
cat("[3/6] Evaluating H2 psychophysiological concurrence models...\n")


h2_physio_outcomes <- intersect(sensor_outcomes, names(df))   # all 26, no representatives
h2_psych_outcomes  <- intersect(psych_outcomes, names(df))
h2_results_list <- list()

for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  dur_label <- "Matched_start_8min"
  norm_label <- "Within-Person Z-score"

  # H2: within-person repeated-measures correlation (rmcorr) across the 4 core phases.
  # Bakdash, J. Z., & Marusich, L. R. (2017). Repeated Measures Correlation. Frontiers in Psychology, 8, 456.
  #   https://doi.org/10.3389/fpsyg.2017.00456
  #   Local copy: Paper3_Github/Experiment papers/H1 to H4/H2 concurdence - Repeated Measures Correlation.pdf
  # rmcorr = ANCOVA lm(psych ~ factor(ParticipantID) + physio): the common within-individual slope across phases,
  # df = N - k - 1 (k participants). Inputs: participant-phase means on the native scale, ln(x) for the seven HRV
  # outcomes (H4 rule). Assumes one common slope; interpreted as concordance ACROSS mobility conditions.
  # BH-FDR over all 104 pairs (4 questionnaires x 26 physiological outcomes).
  HRV_LOG <- c("empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd", "empatica_hrv_fd_lf", "empatica_hrv_fd_hf",
               "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_vlf", "empatica_hrv_fd_total_power")
  rm_src <- d_cond[c("ParticipantID", "PhaseID", h2_psych_outcomes, h2_physio_outcomes)]
  # HRV_LOG outcomes are already ln-transformed on the 10-s rows (notebook transform, section 4)
  rm_ph <- aggregate(rm_src[c(h2_psych_outcomes, h2_physio_outcomes)],
                     by = rm_src[c("ParticipantID", "PhaseID")], FUN = mean_na)
  for (psych_var in h2_psych_outcomes) {
    clean_psych_name <- ifelse(is.na(clean_labels[psych_var]), psych_var, clean_labels[psych_var])
    for (phys_var in h2_physio_outcomes) {
      clean_phys_name <- ifelse(is.na(clean_labels[phys_var]), phys_var, clean_labels[phys_var])
      x <- rm_ph[complete.cases(rm_ph[c(psych_var, phys_var)]), c("ParticipantID", psych_var, phys_var)]
      x <- x[x$ParticipantID %in% names(which(table(x$ParticipantID) >= 2)), , drop = FALSE]
      names(x) <- c("ParticipantID", "psych", "phys")
      x$ParticipantID <- droplevels(factor(x$ParticipantID))
      n_pid <- nlevels(x$ParticipantID)
      if (nrow(x) < 20 || n_pid < 8 || sd(x$phys) == 0) {
        model_audit[[length(model_audit) + 1]] <- data.frame(
          Analysis = "H2_rmcorr", Condition = cname, Outcome = psych_var, Predictor = phys_var,
          Status = "NOT_FIT_INSUFFICIENT_DATA", N_rows = nrow(x), N_participants = n_pid,
          Temporal_Rho_Not_Used = NA_real_, Warning = "Fewer than 20 bouts or 8 participants", Error = "",
          stringsAsFactors = FALSE)
        next
      }
      f_rm <- lm(psych ~ ParticipantID + phys, data = x)
      cf <- summary(f_rm)$coefficients["phys", ]
      dfr <- f_rm$df.residual
      t_val <- cf[["t value"]]
      r_rm <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + dfr))
      z_ci <- atanh(r_rm) + c(-1, 1) * qnorm(0.975) / sqrt(dfr - 1)   # Bakdash & Marusich (2017) Fisher-z CI
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "H2_rmcorr", Condition = cname, Outcome = psych_var, Predictor = phys_var,
        Status = "FIT", N_rows = nrow(x), N_participants = n_pid, Temporal_Rho_Not_Used = NA_real_,
        Warning = "", Error = "", stringsAsFactors = FALSE)
      h2_results_list[[length(h2_results_list) + 1]] <- data.frame(
        Sub_Hypothesis = "H2",
        Model_Type = "rmcorr_within_person",
        Phase = "All_core_phases",
        Psychological_Measure = psych_var,
        Physiological_Measure = phys_var,
        Outcome_Group = outcome_group_map[phys_var],
        Duration = dur_label,
        Normalization = "Within-person centring by rmcorr (participant factor); ln(x) for HRV",
        Model_Formula = sprintf("rmcorr: lm(%s ~ ParticipantID + %s), Bakdash & Marusich 2017", psych_var, phys_var),
        Raw_Direction = sprintf("Higher %s is associated with %s %s", clean_phys_name,
                                ifelse(r_rm >= 0, "higher", "lower"), clean_psych_name),
        Beta_Within_Std = r_rm,
        Beta = cf[["Estimate"]],
        SE = cf[["Std. Error"]],
        CI95_low = tanh(z_ci[1]),
        CI95_high = tanh(z_ci[2]),
        t_stat = t_val,
        df = dfr,
        p_value = cf[["Pr(>|t|)"]],
        Partial_r_Within = r_rm,
        Spearman_rho = NA_real_,
        N_PhaseBouts = nrow(x),
        N_Participants = n_pid,
        stringsAsFactors = FALSE)
    }
  }

}

h2_table <- safe_rbind(h2_results_list)
rownames(h2_table) <- NULL
if (nrow(h2_table) > 0) {
  h2_family_key <- paste(h2_table$Duration, h2_table$Normalization, h2_table$Phase, sep = "__")
  h2_table$q_FDR <- ave(h2_table$p_value, h2_family_key,
                        FUN = function(p) p.adjust(p, method = "BH"))
  h2_table$FDR_significant <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05

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
      pos_exp_sign = NA, interpretability = "Context-dependent",
      citation = "Billman GE (2013) The LF/HF ratio does not accurately measure cardiac sympatho-vagal balance. Front Physiol 4:26. doi:10.3389/fphys.2013.00026",
      note = "LF/HF ratio is often read as sympathetic/vagal balance, but this reading is disputed (Billman 2013); no expected direction is assumed"
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
    is_fdr_sig <- isTRUE(h2_table$FDR_significant[i])
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
  h2_table$Method_Note <- paste("rmcorr estimates one common within-person slope across the 4 mobility conditions",
    "(Bakdash & Marusich 2017); association includes condition-driven co-variation of psychological and",
    "physiological measures; direction is not uniquely interpretable for context-dependent measures.")
  h2_table$Raw_Direction <- NULL
}

# H4 model fitting: see scripts/H4_multivariate.R.

# 7. Write Dedicated CSV Tables ------------------------------------------------
cat("[5/6] Writing corrected, auditable outputs...\n")

meaning_of <- function(v) vapply(v, function(o) if (!is.null(lit_dict[[o]])) lit_dict[[o]]$note else NA_character_, character(1))
label_of   <- function(v) ifelse(!is.na(clean_labels[v]), clean_labels[v], v)

h13_out <- h13_table
h13_out$Outcome_Label   <- label_of(h13_out$Outcome)
h13_out$Outcome_Meaning <- meaning_of(h13_out$Outcome)
h13_out$Units           <- units_of(h13_out$Outcome)
h13_out$How_To_Read <- sprintf("Beta > 0: %s higher in %s than %s; < 0: lower. Beta units: Primary rows = Units (ln(Units) for the 7 HRV outcomes, notebook transform); Sensitivity_WPZ rows = within-person SD. Reference_Mean_raw/Comparison_Mean_raw and SMD_paired_Bonett use the same analysis units (ln for HRV).",
                               h13_out$Outcome, h13_out$Comparison_PhaseID, h13_out$Reference_PhaseID)
h13_out$Method_Citation <- paste(CITE_WPZ, CITE_LMM, CITE_EMM, CITE_FDR, CITE_SMD, sep = " | ")
h13_cols <- c("Hypothesis", "Sub_Hypothesis", "Contrast", "Reference_PhaseID", "Comparison_PhaseID",
              "Outcome", "Outcome_Label", "Units", "Outcome_Meaning", "Direction", "How_To_Read",
              "Beta", "SE", "df", "t_ratio", "p_value", "q_FDR", "FDR_significant", "Family_Size",
              "SMD_paired_Bonett", "SMD_CI95_low", "SMD_CI95_high",
              "Reference_Mean_raw", "Comparison_Mean_raw", "N_Participants",
              "Model_Formula", "Interaction_Test", "Normalization", "Method_Citation")
h13_clean_table <- h13_out[, intersect(h13_cols, names(h13_out)), drop = FALSE]

h2_table$Questionnaire       <- h2_table$Psychological_Measure
h2_table$Physio              <- h2_table$Physiological_Measure
h2_table$Physio_Label        <- label_of(h2_table$Physio)
h2_table$Questionnaire_Label <- label_of(h2_table$Questionnaire)
h2_table$Physio_Meaning      <- meaning_of(h2_table$Physio)
h2_table$Literature_Expected_Direction_Anxiety <- vapply(h2_table$Physio, function(o) { it <- lit_dict[[o]]; if (is.null(it) || is.na(it$pos_exp_sign)) "Context-dependent" else if (it$pos_exp_sign > 0) "Lower (-) with higher anxiety" else "Higher (+) with higher anxiety" }, character(1))
h2_table$Physio_Units        <- unname(ifelse(!is.na(H2_LOG_UNITS[h2_table$Physio]), H2_LOG_UNITS[h2_table$Physio], units_of(h2_table$Physio)))
h2_table$Direction <- sprintf("Within the same participant, in PhaseIDs where %s was rated higher, %s was %s (r = %.2f)",
                              h2_table$Questionnaire, h2_table$Physio,
                              dir_word(h2_table$Physio, h2_table$Partial_r_Within >= 0), h2_table$Partial_r_Within)
h2_table$How_To_Read <- "r > 0: both go up together across the participant's own PhaseIDs; r < 0: one goes up as the other goes down. CI95_low/CI95_high are for r. Beta: change in Questionnaire (its own units) per 1 Physio_Units of Physio, within the same participant, from the same lm; SE is its standard error; p_value is the same for r and Beta."
h2_table$Method_Citation <- paste(CITE_RMC, CITE_FDR, sep = " | ")
h2_cols <- c("Questionnaire", "Questionnaire_Label", "Physio", "Physio_Label", "Physio_Units", "Physio_Meaning",
             "Direction", "How_To_Read", "Partial_r_Within", "CI95_low", "CI95_high", "Beta", "SE", "t_stat", "df",
             "p_value", "q_FDR", "FDR_significant", "N_PhaseBouts", "N_Participants",
             "Model_Formula", "Literature_Expected_Direction", "Literature_Expected_Direction_Anxiety", "Literature_Interpretability",
             "Literature_Citation", "H2_Interpretation", "Method_Note", "Method_Citation")
h2_clean_table <- h2_table[, intersect(h2_cols, names(h2_table)), drop = FALSE]
names(h2_clean_table)[names(h2_clean_table) == "Partial_r_Within"] <- "r_rmcorr"

safe_write_csv(h13_clean_table, file.path(OUT_DIR, "H1_H3_Contrasts.csv"))
safe_write_csv(h2_clean_table, file.path(OUT_DIR, "H2_Physio_Psycho_Concordance.csv"))
safe_write_csv(temporal_table, file.path(OUT_DIR, "H1_H3_Temporal_TimeSeries_AR1.csv"))
safe_write_csv(temporal_sens_table, file.path(OUT_DIR, "H1_H3_Temporal_AR1_Sensitivity.csv"))

# Literature notes are merged into H2_Physio_Psycho_Concordance.csv (Literature_* columns).

# Complete model audit table
model_audit_df <- safe_rbind(model_audit)
safe_write_csv(model_audit_df, file.path(OUT_DIR, "Model_Audit.csv"))

# 8. Forest Plots -------------------------------------------------------------
if (MAKE_FIGURES) {
  cat("[6/6] Rendering primary forest plots...\n")
  
  # H1 & H3 forest plot: paired SMD (Bonett 2008) per PhaseID contrast
  plot_df <- h13_out[h13_out$Family_Set == "Primary" & is.finite(h13_out$SMD_paired_Bonett), , drop = FALSE]
  if (nrow(plot_df) > 0) {
    plot_df$Panel <- sprintf("%s %s: %s minus %s", plot_df$Hypothesis, plot_df$Sub_Hypothesis,
                             plot_df$Comparison_PhaseID, plot_df$Reference_PhaseID)
    plot_df$Label <- sprintf("%.2f%s", plot_df$SMD_paired_Bonett, ifelse(!is.na(plot_df$q_FDR) & plot_df$q_FDR < 0.05, "*", ""))
    p_forest <- ggplot(plot_df, aes(x = SMD_paired_Bonett, y = Outcome)) +
      geom_vline(xintercept = 0, linetype = "dashed", linewidth = 0.6) +
      geom_errorbar(aes(xmin = SMD_CI95_low, xmax = SMD_CI95_high), orientation = "y", width = 0.3, linewidth = 0.7) +
      geom_point(size = 2.2) +
      geom_text(aes(label = Label), vjust = -0.7, size = 2.4) +
      facet_wrap(~ Panel, ncol = 4, scales = "free_x") +
      labs(title = "H1 and H3: paired standardized mean difference per PhaseID contrast",
           subtitle = "Positive = higher in the second PhaseID. Bonett (2008) 95% CI on participant-phase means (ln for HRV). * BH-FDR q < 0.05 from primary lme(outcome ~ PhaseID).",
           x = "Paired standardized mean difference (Bonett 2008)", y = "") +
      theme_minimal(base_size = 9)
    ggsave(file.path(OUT_DIR, "Statistical_Results_ForestPlot.jpg"), plot = p_forest,
           width = 16, height = 10, dpi = 300, device = "jpeg")
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
  Primary_Sensor_Model = "lme(<outcome> ~ PhaseID, random = ~1 | ParticipantID), REML, participant-phase means in analysis units (notebook transform: ln(x) for 7 HRV outcomes), matched first 8 min; 26 physiological outcomes",
  Sensitivity_Sensor_Model = "Same model on within-person z-scores (wpz__, computed after the notebook transform); separate BH-FDR family (Family_Set = Sensitivity_WPZ)",
  Matched_Duration_Sensitivity = "Participant-specific common duration across BikeU/BikeG/WalkU/WalkG, capped at 8 minutes from phase start",
  Normalization = "Primary: analysis units (scripts/Normalization_H1toH4_physio.csv transforms) + participant random intercept. Sensitivity and temporal AR(1): within-person z over the 4 core routes (after transform); no Indoor/Tram reference",
  H2_Method = "Within-person rmcorr across 4 core phases (Bakdash & Marusich 2017); 4 questionnaires x 26 physiological outcomes = 104 pairs; one BH-FDR family",
  Temporal_Method = "10-s AR(1) LMM on within-person z outcomes, matched first 8 min",
  Multiple_Testing = "Benjamini-Hochberg FDR (q < 0.05) within declared hypothesis families",
  N_Participants = length(PARTICIPANTS),
  N_Declared_Outcomes = length(all_outcomes),
  Completed_At = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
  H1_Primary_Significant_FDR = if (nrow(h1_table) > 0) sum(h1_table$Family_Set == "Primary" & !is.na(h1_table$q_FDR) & h1_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  H1_Sensitivity_WPZ_Significant_FDR = sum(h13_table$Hypothesis == "H1" & h13_table$Family_Set == "Sensitivity_WPZ" & h13_table$FDR_significant),
  H3_Sensitivity_WPZ_Significant_FDR = sum(h13_table$Hypothesis == "H3" & h13_table$Family_Set == "Sensitivity_WPZ" & h13_table$FDR_significant),
  H3_Primary_Significant_FDR = if (nrow(h3_table) > 0) sum(h3_table$Family_Set == "Primary" & !is.na(h3_table$q_FDR) & h3_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  H2_Significant_FDR = if (nrow(h2_table) > 0) sum(!is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  Total_Attempted_Models_Audited = nrow(model_audit_df),
  Failed_or_Unstable_Models = if (nrow(model_audit_df) > 0) sum(grepl("NOT_FIT|FAILED_CONVERGENCE|UNSTABLE", model_audit_df$Status)) else 0,
  stringsAsFactors = FALSE
)
write.csv(manifest, file.path(OUT_DIR, "Run_Manifest.csv"), row.names = FALSE, na = "")

cat("   H1/H3 contrasts:", nrow(h13_clean_table), "rows | H2 pairs:", nrow(h2_clean_table), "rows\n")
cat(sprintf("   Model Audit Logged: %d total attempted models (%d fits, %d non-fits/skips logged)\n",
            nrow(model_audit_df), sum(model_audit_df$Status == "FIT"),
            sum(model_audit_df$Status != "FIT")))
cat("\nSUCCESS: H1-H3 pipeline finished. H4: scripts/H4_multivariate.R.\n")

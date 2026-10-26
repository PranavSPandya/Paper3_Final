# H1_H3_core.R — load, fit, FDR, figures, and CSV outputs; sourced by H1_to_H3.R.
# H1_TO_H3_SPEC, paths, and H1/H2/H3 model quote() templates live in H1_to_H3.R.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H1_H3_core.R (source scripts/H1_to_H3.R).", call. = FALSE)
}
if (!exists("H1_TO_H3_SPEC", envir = .GlobalEnv, inherits = FALSE)) {
  stop("H1_TO_H3_SPEC must be set before sourcing H1_H3_core.R.", call. = FALSE)
}

PARTICIPANTS <- H1_TO_H3_SPEC$participants
CORE_PHASES <- H1_TO_H3_SPEC$phases
MATCHED_CAP_SEC <- H1_TO_H3_SPEC$matched_cap_sec
h1_contrasts <- H1_TO_H3_SPEC$h1_contrasts
h3_contrasts <- H1_TO_H3_SPEC$h3_contrasts
OUTCOMES <- list(
  Psychological = H1_TO_H3_SPEC$h2_psychological,
  Physiological_Autonomic = H1_TO_H3_SPEC$outcomes$physiological[1:13],
  Physiological_Ocular = H1_TO_H3_SPEC$outcomes$physiological[14:26]
)
all_outcomes <- H1_TO_H3_SPEC$all_declared_columns
outcome_group_map <- setNames(
  rep(names(OUTCOMES), vapply(OUTCOMES, length, integer(1))),
  unlist(OUTCOMES, use.names = FALSE)
)
HRV_LOG_ES <- hrv_log_outcomes()
SCRIPT_PATH <- H1_TO_H3_SCRIPT_PATH

clean_labels <- c(
  "questionnaire_current_comfort_1_7"   = "Survey: General Comfort (1-7)",
  "questionnaire_pleasantness_1_5"      = "Survey: Pleasantness (1-5)",
  "questionnaire_stai6_mean_1_5"        = "Survey: State Anxiety (STAI-6)",
  "questionnaire_prs11_total_mean_1_5"  = "Survey: Restorativeness (PRS-11)",
  "empatica_heart_rate"                 = "Empatica: Heart Rate (bpm)",
  "empatica_eda_tonic"                  = "Empatica: EDA Tonic Level (SCL)",
  "empatica_eda_phasic"                 = "Empatica: EDA Phasic (SCR)",
  "empatica_skin_temperature"           = "Empatica: Skin Temperature (°C)",
  "empatica_hrv_td_sdnn"                = "Empatica: HRV (SDNN, ms)",
  "empatica_hrv_td_rmssd"               = "Empatica: HRV (RMSSD, ms)",
  "empatica_hrv_fd_lf"                  = "Empatica: HRV LF Power (ms²)",
  "empatica_hrv_fd_hf"                  = "Empatica: HRV HF Power (ms²)",
  "empatica_hrv_fd_lf_hf_ratio"         = "Empatica: HRV LF/HF Ratio",
  "empatica_hrv_fd_lfnu"                = "Empatica: HRV LF (nu)",
  "empatica_hrv_fd_hfnu"                = "Empatica: HRV HF (nu)",
  "empatica_hrv_fd_vlf"                 = "Empatica: HRV VLF Power (ms²)",
  "empatica_hrv_fd_total_power"         = "Empatica: HRV Total Power (ms²)",
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
  "eyetracker_eyelid_aperture_avg"      = "Eyetracker: Eyelid Aperture (mm)")



# Units of the raw participant-phase means (from column-name suffixes and labels); H2 uses ln units for the HRV_LOG outcomes.
OUTCOME_UNITS <- c(
  questionnaire_current_comfort_1_7 = "rating scale points (1-7)", questionnaire_pleasantness_1_5 = "rating scale points (1-5)", questionnaire_stai6_mean_1_5 = "rating scale points (mean item score, 1-5)",
  questionnaire_prs11_total_mean_1_5 = "rating scale points (mean item score, 1-5)", empatica_heart_rate = "bpm", empatica_eda_tonic = "uS (microsiemens)",
  empatica_eda_phasic = "uS (microsiemens)", empatica_skin_temperature = "degC", empatica_hrv_td_sdnn = "ms",
  empatica_hrv_td_rmssd = "ms", empatica_hrv_fd_lf = "ms^2", empatica_hrv_fd_hf = "ms^2",
  empatica_hrv_fd_lf_hf_ratio = "unitless (ratio)", empatica_hrv_fd_lfnu = "normalized units (n.u.)", empatica_hrv_fd_hfnu = "normalized units (n.u.)",
  empatica_hrv_fd_vlf = "ms^2", empatica_hrv_fd_total_power = "ms^2", eyetracker_pupil_diameter_avg = "mm",
  eyetracker_pupil_change_rate = "not specified in source data", eyetracker_blink_duration_s = "s", eyetracker_fixation_duration_s = "s",
  eyetracker_fixation_rate = "per s", eyetracker_saccade_duration_s = "s", eyetracker_saccade_amplitude = "deg",
  eyetracker_saccade_peak_velocity = "deg/s", eyetracker_gaze_velocity = "deg/s", eyetracker_gaze_dispersion = "not specified in source data",
  eyetracker_gaze_centrality = "not specified in source data", eyetracker_distance_from_center = "px", eyetracker_eyelid_aperture_avg = "mm")
H2_LOG_UNITS <- c(empatica_hrv_td_sdnn = "ln(ms)", empatica_hrv_td_rmssd = "ln(ms)", empatica_hrv_fd_lf = "ln(ms^2)",
                  empatica_hrv_fd_hf = "ln(ms^2)", empatica_hrv_fd_lf_hf_ratio = "ln(ratio), unitless",
                  empatica_hrv_fd_vlf = "ln(ms^2)", empatica_hrv_fd_total_power = "ln(ms^2)")
units_of <- function(v) unname(ifelse(!is.na(OUTCOME_UNITS[v]), OUTCOME_UNITS[v], "not specified in source data"))

# Plain words for "higher"/"lower" per physiological measure (H2 Direction sentence)
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

# 2. Reusable Helper Functions -------------------------------------------------
label_of <- function(v) ifelse(!is.na(clean_labels[v]), clean_labels[v], v)
mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)
safe_rbind <- function(x) if (length(x) > 0) do.call(rbind, x) else data.frame()

safe_write_csv <- function(data, path) {
  ok <- tryCatch({ write.csv(data, path, row.names = FALSE, na = ""); TRUE }, error = function(e) {
    warning(sprintf("File locked by Excel or another process: %s. Attempting fallback...", path)); FALSE })
  if (!ok) tryCatch(write.csv(data, sub("\\.csv$", "_latest.csv", path), row.names = FALSE, na = ""), error = function(e) NULL)
}

audit_row <- function(analysis, condition, outcome, predictor, status, n_rows, n_pid, warn = "", err = "")
  data.frame(Analysis = analysis, Condition = condition, Outcome = outcome, Predictor = predictor, Status = status,
             N_rows = n_rows, N_participants = n_pid, Temporal_Rho_Not_Used = NA_real_, Warning = warn, Error = err,
             stringsAsFactors = FALSE)

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

# H1 and H3 effect size: paired standardized mean difference (Bonett 2008, Psychol Methods 13:99-109) via
# statpsych::ci.stdmean.ps (sqrt((SD1^2 + SD2^2)/2) standardizer), bias-adjusted estimate with 95% CI, on participant-phase
# means in analysis units. Within-person z-scores are not used (person-standardisation shrinks the SD). p/q come from the LMM.
# Transforms: ln(x) where "Transformation in Step 5" starts with "Natural log" (x <= 0 -> NA), applied once to the 10-s rows.
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

extract_phase_lmm_contrasts <- function(fit, d, outcome, family_set, value_col) {
  contrast_rows <- rbind(h1_contrasts, h3_contrasts)
  lv <- levels(d$PhaseID)
  wvec <- function(plus, minus) { w <- setNames(rep(0, length(lv)), lv); w[plus] <- 1; w[minus] <- -1; unname(w) }
  em <- emmeans(fit, ~ PhaseID)
  cm <- setNames(lapply(seq_len(nrow(contrast_rows)), function(i)
    wvec(contrast_rows$Comparison_PhaseID[i], contrast_rows$Reference_PhaseID[i])), contrast_rows$Contrast)
  cc <- as.data.frame(summary(contrast(em, method = cm), infer = c(TRUE, TRUE)))
  # Difference of differences across the 2x2 layout: (BikeG - BikeU) - (WalkG - WalkU)
  ii <- as.data.frame(summary(contrast(em, method = list(DiD = wvec(c("BikeG", "WalkU"), c("BikeU", "WalkG")))),
                              infer = c(TRUE, TRUE)))
  int_txt <- sprintf("(BikeG - BikeU) - (WalkG - WalkU) = %.3f, t(%d) = %.2f, p = %.4f",
                     ii$estimate, round(ii$df), ii$t.ratio, ii$p.value)
  do.call(rbind, lapply(seq_len(nrow(contrast_rows)), function(i) {
    k <- contrast_rows[i, ]
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

adjust_by_family <- function(tab, family_size_map) {
  if (nrow(tab) == 0) return(tab)
  tab$Correction_Family <- paste(tab$Hypothesis, tab$Family_Set, tab$Contrast_ID, tab$Normalization, sep = "__")
  tab$q_FDR <- NA_real_
  tab$Family_Size <- NA_integer_
  for (fam in unique(tab$Correction_Family)) {
    idx <- which(tab$Correction_Family == fam)
    fs <- as.character(tab$Family_Set[idx[1]])
    planned_n <- max(if (fs %in% names(family_size_map)) as.integer(family_size_map[[fs]]) else 0L, sum(!is.na(tab$p_value[idx])))
    tab$q_FDR[idx] <- p.adjust(tab$p_value[idx], method = "BH", n = planned_n)
    tab$Family_Size[idx] <- planned_n
  }
  tab$FDR_significant <- !is.na(tab$q_FDR) & tab$q_FDR < 0.05
  tab
}


h1_to_h3_pipeline_run <- function() {
  # 3. Data Loading & Feature Engineering ----------------------------------------
  cat("[1/6] Loading and formatting dataset...\n")
  if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
  df <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
  df$ParticipantID <- as.character(df$ParticipantID)
  df$PhaseID <- as.character(df$PhaseID)

  missing_participants <- setdiff(PARTICIPANTS, unique(df$ParticipantID))
  if (length(missing_participants) > 0) stop("Verified 11-participant input is incomplete. Missing: ", paste(missing_participants, collapse = ", "))
  phase_grid <- expand.grid(ParticipantID = PARTICIPANTS, PhaseID = CORE_PHASES, stringsAsFactors = FALSE)
  present_key <- with(df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ], paste(ParticipantID, PhaseID, sep = "::"))
  missing_cells <- phase_grid[!paste(phase_grid$ParticipantID, phase_grid$PhaseID, sep = "::") %in% present_key, , drop = FALSE]
  if (nrow(missing_cells) > 0) stop("Core within-subject design is incomplete; missing participant-phase cells: ",
    paste(paste(missing_cells$ParticipantID, missing_cells$PhaseID, sep = "/"), collapse = ", "))
  core_time_key <- paste(df$ParticipantID, df$PhaseID, df$Datetime, sep = "::")
  core_idx <- df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% c(CORE_PHASES, "Tram")
  if (anyDuplicated(core_time_key[core_idx])) stop("Duplicate ParticipantID/PhaseID/Datetime keys detected in active/Tram data.")
  cat("   Input:", RAW_PATH, "\n")
  cat("   Rows/columns:", nrow(df), "/", ncol(df), "| Participants:", length(intersect(PARTICIPANTS, unique(df$ParticipantID))),
      "of", length(PARTICIPANTS), "| Indoor rows:", sum(df$PhaseID == "Indoor", na.rm = TRUE), "\n")

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

  # Derived input columns kept for the manifest column count (not used by H1, H2, or H3 models)
  um_cols <- intersect(c("sound_prop_urban_manmade_positive", "sound_prop_urban_manmade_neutral", "sound_prop_urban_manmade_negative"), names(df))
  if (!"sound_prop_urban_manmade" %in% names(df) && length(um_cols) > 0) df$sound_prop_urban_manmade <- rowSums(df[, um_cols, drop = FALSE], na.rm = TRUE)
  if ("atmo_lys_LYS1__lys_lux" %in% names(df) && !"lys_lux_participant" %in% names(df)) df$lys_lux_participant <- as.numeric(df[["atmo_lys_LYS1__lys_lux"]])

  sensor_outcomes <- intersect(c(OUTCOMES$Physiological_Autonomic, OUTCOMES$Physiological_Ocular), names(df))
  psych_outcomes  <- intersect(OUTCOMES$Psychological, names(df))
  if (length(sensor_outcomes) == 0) stop("No declared physiological/ocular outcome columns are available after schema harmonization.")
  if (length(psych_outcomes) == 0) warning("No declared psychological outcome columns are available.")

  # Within-person standardization reference: the participant's 4 core outdoor phases only (no Indoor/Tram).
  route <- df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ]
  route$Datetime           <- as.POSIXct(route$Datetime, tz = "UTC")
  if (anyNA(route$Datetime)) stop("Unparseable Datetime values found in core route data.")
  phase_span <- aggregate(as.numeric(route$Datetime), by = route[c("ParticipantID", "PhaseID")], FUN = function(x) max(x) - min(x))
  bad <- phase_span[phase_span$x > MATCHED_CAP_SEC, ]
  if (nrow(bad)) stop("Input is not the matched 8-min file; phases longer than 480 s: ", paste(bad$ParticipantID, bad$PhaseID, bad$x, sep = "/", collapse = ", "))
  route$ParticipantID      <- factor(route$ParticipantID, levels = PARTICIPANTS)
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]

  # Notebook transforms on the 10-s rows, before z-scores and phase means
  for (v in intersect(HRV_LOG_ES, names(route))) route[[v]] <- ifelse(route[[v]] > 0, log(route[[v]]), NA_real_)
  # Within-person z-scores across the 10-s epochs of the 4 core phases (sensitivity + temporal AR(1))
  for (v in intersect(sensor_outcomes, names(route))) route[[paste0("wpz__", v)]] <- within_person_z(route[[v]], route$ParticipantID)

  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID, FUN = function(x) x - min(x, na.rm = TRUE))
  route$time_min <- route$time_in_phase_sec / 60

  durations <- aggregate(time_in_phase_sec ~ ParticipantID + PhaseID, route, max, na.rm = TRUE)
  dur_w <- reshape(durations, idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
  names(dur_w) <- sub("time_in_phase_sec\\.", "", names(dur_w))
  for (nm in CORE_PHASES) if (!nm %in% names(dur_w)) dur_w[[nm]] <- NA_real_
  dur_w$Common_cap <- pmin(dur_w$BikeU, dur_w$BikeG, dur_w$WalkU, dur_w$WalkG, MATCHED_CAP_SEC, na.rm = FALSE)
  route <- merge(route, dur_w[c("ParticipantID", "Common_cap")], by = "ParticipantID", all.x = TRUE, sort = FALSE)
  route$matched_cap_sec <- route$Common_cap

  CONDITIONS <- list("Primary: Matched duration <=8 min" = route[!is.na(route$matched_cap_sec) & route$time_in_phase_sec <= route$matched_cap_sec, ])
  cname <- names(CONDITIONS)[1]
  d_cond <- CONDITIONS[[1]]

  # 4. H1 & H3 Inferential Models (26 physiological outcomes) ----------------------
  cat("[2/6] Fitting H1 and H3 models across the 26 physiological outcomes (questionnaires are H2 only)...\n")
  phase_lmm_rows <- list(); model_audit <- list()

  for (outcome in setdiff(all_outcomes, names(df)))
    model_audit[[length(model_audit) + 1]] <- audit_row("Input_schema", "All", outcome, "NA", "NOT_AVAILABLE_IN_INPUT", 0, 0,
                                                        err = "Declared outcome absent from input dataset.")

  # Participant-phase means: one row per participant x phase (N = 44); questionnaires are constant within a phase.
  all_phase_vars <- intersect(unique(c(sensor_outcomes, psych_outcomes, paste0("wpz__", sensor_outcomes), paste0("wpz__", psych_outcomes))), names(d_cond))
  phase_df <- aggregate(d_cond[all_phase_vars], by = d_cond[c("ParticipantID", "PhaseID")], FUN = mean_na)
  phase_df$ParticipantID <- factor(phase_df$ParticipantID, levels = PARTICIPANTS)
  phase_df$PhaseID <- factor(phase_df$PhaseID, levels = CORE_PHASES)

  for (family_set in c("Primary", "Sensitivity_WPZ"))
  for (outcome in intersect(sensor_outcomes, names(d_cond))) {   # physio only; questionnaires belong to H2
    value_col <- if (family_set == "Primary") outcome else paste0("wpz__", outcome)
    analysis <- paste0("H1_and_H3_phase_mean_", family_set)
    if (!value_col %in% names(phase_df)) {
      model_audit[[length(model_audit) + 1]] <- audit_row(analysis, cname, outcome, "PhaseID", "NOT_FIT_MISSING_COLUMN", 0, 0,
                                                          err = paste(value_col, "column missing"))
      next
    }
    d <- phase_df[complete.cases(phase_df[, c(value_col, "PhaseID", "ParticipantID")]), ]
    d$outcome_z <- d[[value_col]]
    n_pid <- length(unique(d$ParticipantID))
    fit <- if (model_data_ok(d, "outcome_z", 24, 8)) fit_phase_lmm("outcome_z ~ PhaseID", d, method = "REML")
    status <- if (!model_data_ok(d, "outcome_z", 24, 8)) "NOT_FIT_INSUFFICIENT_DATA" else if (is.null(fit)) "FAILED_CONVERGENCE" else "FIT"
    model_audit[[length(model_audit) + 1]] <- audit_row(analysis, cname, outcome, "PhaseID", status, nrow(d), n_pid,
      warn = if (status == "NOT_FIT_INSUFFICIENT_DATA") "Fewer than 24 bouts or 8 participants" else "",
      err = if (status == "FAILED_CONVERGENCE") "nlme::lme failed to converge" else "")
    if (status == "FIT") phase_lmm_rows[[length(phase_lmm_rows) + 1]] <- extract_phase_lmm_contrasts(fit, d, outcome, family_set, value_col)
  }

  phase_lmm_table <- adjust_by_family(safe_rbind(phase_lmm_rows), c(Primary = length(sensor_outcomes), Sensitivity_WPZ = length(sensor_outcomes)))

  # AR(1) residual correlation (Pinheiro & Bates 2000). Primary fit uses optim; only if it fails, the nlminb -> optim fallback
  # of H4_multivariate.R (maxIter 100, msMaxIter 150, corAR1 start 0.2) is tried. No other model changes.
  fit_ar1_with_fallback <- function(dd, step_var) {
    ar1_form <- as.formula(paste("~", step_var, "| ParticipantID/PhaseID"))
    fit_one <- function(opt, primary) {
      ctl <- if (primary) lmeControl(opt = "optim", maxIter = 200, msMaxIter = 200, returnObject = TRUE) else
        lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = opt)
      cs <- if (primary) corAR1(form = ar1_form) else corAR1(value = 0.2, form = ar1_form)
      tryCatch(lme(outcome_z ~ PhaseID * time_min, random = ~ 1 | ParticipantID, correlation = cs,
                   data = dd, method = "REML", na.action = na.omit, control = ctl), error = function(e) NULL)
    }
    f <- fit_one("optim", TRUE)
    if (!is.null(f)) return(list(fit = f, method = "optim (primary)"))
    f <- fit_one("nlminb", FALSE)
    if (!is.null(f)) return(list(fit = f, method = "nlminb (fallback, as in H4_multivariate.R)"))
    f <- fit_one("optim", FALSE)
    if (!is.null(f)) return(list(fit = f, method = "optim (fallback, as in H4_multivariate.R)"))
    list(fit = NULL, method = "none (not converged)")
  }
  ar1_rho <- function(fit) if (is.null(fit)) NA_real_ else tryCatch(as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)
  # One temporal output row per term; tt = NULL gives NA estimates (failed fit).
  ts_row <- function(outc, tname, formula, tt, cols, ...) {
    has <- !is.null(tt) && tname %in% rownames(tt)
    est <- setNames(lapply(cols, function(cc) if (has) tt[tname, cc] else NA_real_), names(cols))
    data.frame(Outcome_Group = outcome_group_map[outc], Outcome = outc, Clean_Outcome = ifelse(!is.na(clean_labels[outc]), clean_labels[outc], outc),
               Term = tname, Model_Formula = sprintf(formula, outc), ..., est, stringsAsFactors = FALSE)
  }

  # 4D. Temporal Time-Series Mixed Models with AR(1) Autocorrelation -------------
  cat("[2b/6] Fitting 10-second temporal time-series LMMs with AR(1) autocorrelation...\n")
  temporal_results_list <- list(); temporal_sens_list <- list()
  route_ar1 <- CONDITIONS[[1]]   # same matched first-8-min window as the primary models
  route_ar1$time_10s_step <- round(route_ar1$time_in_phase_sec / 10)
  route_ar1$PhaseID <- factor(route_ar1$PhaseID, levels = CORE_PHASES)
  step_key <- paste(route_ar1$ParticipantID, route_ar1$PhaseID, route_ar1$time_10s_step)
  if (anyDuplicated(step_key)) stop("Temporal AR(1): ", sum(duplicated(step_key)),
    " duplicate participant/phase/10-s steps; fix the epoch grid upstream instead of dropping rows.")
  F10 <- "lme(wpz__%s ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_10s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU"
  F60 <- "lme(mean wpz__%s per 60-s epoch ~ PhaseID * time_min, random = ~1 | ParticipantID, correlation = corAR1(~ time_60s_step | ParticipantID/PhaseID)); reference PhaseID = BikeU"

  for (outc in sensor_outcomes) {
    zc <- paste0("wpz__", outc)
    needed <- c("ParticipantID", "PhaseID", "time_min", "time_10s_step", zc)
    keep <- complete.cases(route_ar1[, needed, drop = FALSE])
    n_na_excluded <- sum(!keep)
    d_ts <- route_ar1[keep, needed, drop = FALSE]
    d_ts$outcome_z <- d_ts[[zc]]
    d_ts <- d_ts[order(d_ts$ParticipantID, d_ts$PhaseID, d_ts$time_10s_step), ]
    na_note <- sprintf("NA epochs excluded: %d of %d", n_na_excluded, nrow(route_ar1))
    n_pid <- length(unique(d_ts$ParticipantID))
    if (!model_data_ok(d_ts, "outcome_z", 100, 8)) {
      model_audit[[length(model_audit) + 1]] <- audit_row("Temporal_AR1", "Primary_10s_matched_8min", outc, "PhaseID*time_min",
        "NOT_FIT_INSUFFICIENT_DATA", nrow(d_ts), n_pid, warn = paste("Insufficient time-series rows;", na_note))
      next
    }
    fr <- fit_ar1_with_fallback(d_ts, "time_10s_step")
    all_terms <- colnames(model.matrix(~ PhaseID * time_min, data = d_ts))[-1]

    # Sensitivity: 60-s epoch means (6 x 10-s epochs); a longer window lowers the near-unit lag-1 autocorrelation at 10 s
    # while leaving 8 points per participant-phase.
    d_60 <- d_ts
    d_60$time_60s_step <- floor(d_60$time_10s_step / 6)
    d_60 <- aggregate(cbind(outcome_z, time_min) ~ ParticipantID + PhaseID + time_60s_step, data = d_60, FUN = mean)
    d_60$PhaseID <- factor(d_60$PhaseID, levels = CORE_PHASES)
    d_60 <- d_60[order(d_60$ParticipantID, d_60$PhaseID, d_60$time_60s_step), ]
    fr60 <- fit_ar1_with_fallback(d_60, "time_60s_step")
    tt60 <- if (!is.null(fr60$fit)) summary(fr60$fit)$tTable
    for (tname in all_terms) temporal_sens_list[[length(temporal_sens_list) + 1]] <- cbind(
      ts_row(outc, tname, F60, tt60, c(Beta_60s = "Value", SE_60s = "Std.Error", p_value_60s = "p-value")),
      AR1_phi_60s = ar1_rho(fr60$fit), Fit_Method_60s = fr60$method, N_epochs_60s = nrow(d_60), stringsAsFactors = FALSE)

    status <- if (is.null(fr$fit)) "FAILED_CONVERGENCE" else "FIT"
    model_audit[[length(model_audit) + 1]] <- audit_row("Temporal_AR1", "Primary_10s_matched_8min", outc, "PhaseID*time_min", status,
      nrow(d_ts), n_pid, warn = if (status == "FIT") paste0(na_note, "; fit method: ", fr$method) else na_note,
      err = if (status == "FIT") "" else "AR(1) model failed to converge (optim, nlminb and optim fallbacks)")
    tt_ar1 <- if (status == "FIT") summary(fr$fit)$tTable
    terms <- if (status == "FIT") setdiff(rownames(tt_ar1), "(Intercept)") else all_terms
    for (tname in terms) temporal_results_list[[length(temporal_results_list) + 1]] <- cbind(
      ts_row(outc, tname, F10, tt_ar1, c(Beta = "Value", SE = "Std.Error", t_stat = "t-value", df = "DF", p_value = "p-value"),
             Normalization = "Within-Person Z-score", Duration = "Matched_start_8min"),
      AR1_phi = ar1_rho(fr$fit), N_epochs = nrow(d_ts), N_participants = n_pid, Fit_Method = fr$method, Status = status, stringsAsFactors = FALSE)
  }
  temporal_table <- safe_rbind(temporal_results_list)
  # BH-FDR family = one Term across all 26 planned sensor outcomes, converged or not (Benjamini & Hochberg 1995).
  TEMPORAL_FAMILY_N <- length(sensor_outcomes)
  if (nrow(temporal_table) > 0) {
    temporal_table$Family_Size <- TEMPORAL_FAMILY_N
    temporal_table$q_FDR <- ave(temporal_table$p_value, temporal_table$Term, FUN = function(p) p.adjust(p, method = "BH", n = TEMPORAL_FAMILY_N))
    temporal_table$FDR_significant <- !is.na(temporal_table$q_FDR) & temporal_table$q_FDR < 0.05
    temporal_table$Stability_Flag <- ifelse(temporal_table$Status != "FIT", "not converged",
      ifelse(!is.na(temporal_table$AR1_phi) & temporal_table$AR1_phi > 0.95, "rho > 0.95, interpret cautiously", ""))
  }
  temporal_sens_table <- safe_rbind(temporal_sens_list)
  if (nrow(temporal_sens_table) > 0) {
    temporal_sens_table$Family_Size <- TEMPORAL_FAMILY_N
    temporal_sens_table$q_FDR_60s <- ave(temporal_sens_table$p_value_60s, temporal_sens_table$Term, FUN = function(p) p.adjust(p, method = "BH", n = TEMPORAL_FAMILY_N))
    temporal_sens_table$FDR_significant_60s <- !is.na(temporal_sens_table$q_FDR_60s) & temporal_sens_table$q_FDR_60s < 0.05
    prim <- temporal_table[, c("Outcome", "Term", "Beta", "p_value", "q_FDR", "FDR_significant", "AR1_phi", "Fit_Method", "Stability_Flag")]
    temporal_sens_table <- merge(prim, temporal_sens_table, by = c("Outcome", "Term"), all = TRUE, sort = FALSE)
    temporal_sens_table$Same_Sign_As_Primary <- sign(temporal_sens_table$Beta) == sign(temporal_sens_table$Beta_60s)
    temporal_sens_table$Primary_Holds_In_60s <- temporal_sens_table$FDR_significant %in% TRUE &
      temporal_sens_table$FDR_significant_60s %in% TRUE & temporal_sens_table$Same_Sign_As_Primary %in% TRUE
  }

  # 5. H2: within-person rmcorr (Bakdash & Marusich 2017, Front Psychol 8:456) across the 4 core phases ----------------
  # rmcorr = lm(psych ~ factor(ParticipantID) + physio): one common within-person slope, df = N - k - 1. Inputs are
  # participant-phase means (ln(x) already applied to the HRV outcomes). 4 questionnaires x 26 outcomes, one BH-FDR family.
  cat("[3/6] Evaluating H2 psychophysiological concurrence models...\n")
  h2_physio_outcomes <- intersect(sensor_outcomes, names(df))
  h2_psych_outcomes  <- intersect(psych_outcomes, names(df))
  h2_results_list <- list()
  rm_src <- d_cond[c("ParticipantID", "PhaseID", h2_psych_outcomes, h2_physio_outcomes)]
  rm_ph <- aggregate(rm_src[c(h2_psych_outcomes, h2_physio_outcomes)], by = rm_src[c("ParticipantID", "PhaseID")], FUN = mean_na)
  for (psych_var in h2_psych_outcomes) for (phys_var in h2_physio_outcomes) {
    x <- rm_ph[complete.cases(rm_ph[c(psych_var, phys_var)]), c("ParticipantID", psych_var, phys_var)]
    x <- x[x$ParticipantID %in% names(which(table(x$ParticipantID) >= 2)), , drop = FALSE]
    names(x) <- c("ParticipantID", "psych", "phys")
    x$ParticipantID <- droplevels(factor(x$ParticipantID))
    n_pid <- nlevels(x$ParticipantID)
    if (nrow(x) < 20 || n_pid < 8 || sd(x$phys) == 0) {
      model_audit[[length(model_audit) + 1]] <- audit_row("H2_rmcorr", cname, psych_var, phys_var, "NOT_FIT_INSUFFICIENT_DATA", nrow(x), n_pid,
                                                          warn = "Fewer than 20 bouts or 8 participants")
      next
    }
    f_rm <- lm(psych ~ ParticipantID + phys, data = x)
    cf <- summary(f_rm)$coefficients["phys", ]
    dfr <- f_rm$df.residual
    t_val <- cf[["t value"]]
    r_rm <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + dfr))
    z_ci <- atanh(r_rm) + c(-1, 1) * qnorm(0.975) / sqrt(dfr - 1)   # Fisher-z CI (Bakdash & Marusich 2017)
    model_audit[[length(model_audit) + 1]] <- audit_row("H2_rmcorr", cname, psych_var, phys_var, "FIT", nrow(x), n_pid)
    h2_results_list[[length(h2_results_list) + 1]] <- data.frame(
      Psychological_Measure = psych_var, Physiological_Measure = phys_var,
      Model_Formula = sprintf("rmcorr: lm(%s ~ ParticipantID + %s), Bakdash & Marusich 2017", psych_var, phys_var),
      Raw_Direction = sprintf("Higher %s is associated with %s %s", label_of(phys_var), ifelse(r_rm >= 0, "higher", "lower"), label_of(psych_var)),
      Beta = cf[["Estimate"]], SE = cf[["Std. Error"]], CI95_low = tanh(z_ci[1]), CI95_high = tanh(z_ci[2]), t_stat = t_val, df = dfr,
      p_value = cf[["Pr(>|t|)"]], Partial_r_Within = r_rm, N_PhaseBouts = nrow(x), N_Participants = n_pid, stringsAsFactors = FALSE)
  }

  # Literature expectation per physiological measure: sign of the association with positive states (NA = no expected direction)
  LIT <- as.data.frame(do.call(rbind, list(
    c("empatica_heart_rate", "-1", "Established", "Van Doren et al. (2021) Biol Psychol; Ulrich et al. (1991) J Environ Psychol", "Heart rate decreases during positive/restorative states reflecting reduced cardiovascular strain"),
    c("empatica_eda_tonic", "-1", "Established", "Boucsein (2012) Electrodermal Activity; Ulrich et al. (1991) J Environ Psychol", "Tonic skin conductance level (SCL) decreases with reduced sympathetic arousal"),
    c("empatica_eda_phasic", "-1", "Established", "Boucsein (2012) Electrodermal Activity; Dawson et al. (2017) Cambridge Handb Psychophysiol", "Phasic skin conductance responses (SCR) decrease with lower acute sympathetic reactivity"),
    c("empatica_hrv_td_rmssd", "1", "Established", "Laborde et al. (2017) Front Psychol; Shaffer & Ginsberg (2017) Front Public Health", "RMSSD increases reflecting greater parasympathetic/vagal tone and autonomic recovery"),
    c("empatica_hrv_td_sdnn", "1", "Moderate/Cautious", "Shaffer & Ginsberg (2017) Front Public Health; Task Force ESC/NASPE (1996) Circulation", "SDNN reflects overall autonomic variability, generally higher with lower stress"),
    c("empatica_hrv_fd_hf", "1", "Established", "Laborde et al. (2017) Front Psychol; Task Force ESC/NASPE (1996) Circulation", "High-frequency HRV reflects parasympathetic vagal modulation and increases during calm/restorative states"),
    c("empatica_hrv_fd_lf_hf_ratio", "NA", "Context-dependent", "Billman GE (2013) The LF/HF ratio does not accurately measure cardiac sympatho-vagal balance. Front Physiol 4:26. doi:10.3389/fphys.2013.00026", "LF/HF ratio is often read as sympathetic/vagal balance, but this reading is disputed (Billman 2013); no expected direction is assumed"),
    c("empatica_hrv_fd_lfnu", "-1", "Moderate/Cautious", "Task Force ESC/NASPE (1996) Circulation", "Normalized LF reflects sympathetic dominance; decreases in restorative conditions"),
    c("empatica_hrv_fd_hfnu", "1", "Moderate/Cautious", "Task Force ESC/NASPE (1996) Circulation", "Normalized HF reflects parasympathetic vagal tone; increases in restorative conditions"),
    c("empatica_hrv_fd_lf", "NA", "Context-dependent", "Shaffer & Ginsberg (2017) Front Public Health", "LF power reflects mixed sympathetic, parasympathetic, and baroreflex activity"),
    c("empatica_hrv_fd_vlf", "NA", "Context-dependent", "Shaffer & Ginsberg (2017) Front Public Health", "VLF power reflects thermoregulatory, renin-angiotensin, and slow endocrine mechanisms"),
    c("empatica_hrv_fd_total_power", "1", "Moderate/Cautious", "Task Force ESC/NASPE (1996) Circulation", "Total spectral power reflects overall autonomic capacity"),
    c("empatica_skin_temperature", "NA", "Context-dependent", "Romanovsky (2014) Handb Clin Neurol; Charkoudian (2010) Auton Neurosci", "Skin temperature reflects environmental thermal exchange, convective airflow, and vasomotor tone"),
    c("eyetracker_pupil_diameter_avg", "NA", "Context-dependent", "Cuve et al. (2023) Psychophysiology; Mathot (2018) Front Integr Neurosci", "Pupil diameter is heavily dominated by ambient retinal illuminance and cognitive visual exploration"),
    c("eyetracker_pupil_change_rate", "NA", "Context-dependent", "Cuve et al. (2023) Psychophysiology", "Pupil change rate reflects rapid light transitions and active visual processing across outdoor environments"),
    c("eyetracker_blink_duration_s", "NA", "Context-dependent", "Schleicher et al. (2008) Ergonomics; Bentivoglio et al. (1997) Mov Disord", "Blink duration is modulated by ambient airflow, fatigue, visual attention, and emotional valence"),
    c("eyetracker_fixation_duration_s", "NA", "Context-dependent", "Rayner (1998) Psychol Bull; Berto et al. (2008) J Environ Psychol", "Fixation duration depends on scene complexity, visual task demands, and restorative soft fascination"),
    c("eyetracker_fixation_rate", "NA", "Context-dependent", "Rayner (1998) Psychol Bull", "Fixation rate varies with navigation scanning density and movement velocity"),
    c("eyetracker_saccade_duration_s", "NA", "Context-dependent", "Rayner (1998) Psychol Bull", "Saccade kinematics are task- and navigation-driven in active mobility"),
    c("eyetracker_saccade_amplitude", "NA", "Context-dependent", "Rayner (1998) Psychol Bull; Franconeri et al. (2013) Trends Cogn Sci", "Saccade amplitude reflects spatial extent of visual scanning in urban vs green environments"),
    c("eyetracker_saccade_peak_velocity", "NA", "Context-dependent", "Rayner (1998) Psychol Bull", "Saccade peak velocity is constrained by the main sequence and motor exploration requirements"),
    c("eyetracker_gaze_velocity", "NA", "Context-dependent", "Rayner (1998) Psychol Bull", "Overall gaze velocity reflects active physical mobility speed and environmental hazard tracking"),
    c("eyetracker_gaze_dispersion", "NA", "Context-dependent", "Valtchanov & Ellard (2015) J Environ Psychol", "Visual dispersion reflects visual exploratory breadth vs concentrated forward path tracking"),
    c("eyetracker_distance_from_center", "NA", "Context-dependent", "Tatler (2007) J Vis", "Central visual bias vs peripheral exploration depends on forward travel mode and route obstacles"),
    c("eyetracker_gaze_centrality", "NA", "Context-dependent", "Tatler (2007) J Vis", "Forward gaze concentration is heavily governed by cycling vs walking navigation constraints"),
    c("eyetracker_eyelid_aperture_avg", "NA", "Context-dependent", "Stern et al. (1994) Psychophysiology", "Eyelid aperture is directly influenced by solar glare, wind speed, and alertness")
  )), stringsAsFactors = FALSE)
  names(LIT) <- c("outcome", "pos_exp_sign", "interpretability", "citation", "note")
  LIT$pos_exp_sign <- suppressWarnings(as.numeric(LIT$pos_exp_sign))

  h2_table <- safe_rbind(h2_results_list)
  rownames(h2_table) <- NULL
  if (nrow(h2_table) > 0) {
    h2_table$q_FDR <- p.adjust(h2_table$p_value, method = "BH")
    h2_table$FDR_significant <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05
    k <- match(h2_table$Physiological_Measure, LIT$outcome)
    interp_cat <- ifelse(is.na(k), "Unclassified", LIT$interpretability[k])
    exp_sign <- ifelse(grepl("stai", h2_table$Psychological_Measure, ignore.case = TRUE), -1, 1) * LIT$pos_exp_sign[k]
    sig <- h2_table$FDR_significant
    h2_table$Result <- ifelse(sig, h2_table$Raw_Direction, "No FDR-significant concurrence")
    h2_table$Literature_Expected_Direction <- ifelse(is.na(exp_sign), "Context-dependent", ifelse(exp_sign > 0, "Positive (+)", "Negative (-)"))
    h2_table$Literature_Interpretability <- interp_cat
    h2_table$Literature_Citation <- ifelse(is.na(k), "", LIT$citation[k])
    h2_table$H2_Interpretation <- ifelse(!sig, "No evidence of concurrence (q_FDR >= 0.05)",
      ifelse(interp_cat == "Context-dependent" | is.na(exp_sign), "Significant concurrence; direction not uniquely interpretable",
        ifelse(sign(h2_table$Partial_r_Within) == exp_sign, "Literature-consistent concurrence", "Opposite to literature-expected direction")))
    h2_table$Method_Note <- paste("rmcorr estimates one common within-person slope across the 4 mobility conditions",
      "(Bakdash & Marusich 2017); association includes condition-driven co-variation of psychological and",
      "physiological measures; direction is not uniquely interpretable for context-dependent measures.")
    h2_table$Raw_Direction <- NULL
  }


  # 7. Write Dedicated CSV Tables ------------------------------------------------
  cat("[5/6] Writing corrected, auditable outputs...\n")

  meaning_of <- function(v) unname(LIT$note[match(v, LIT$outcome)])

  phase_lmm_out <- phase_lmm_table
  phase_lmm_out$Outcome_Label   <- label_of(phase_lmm_out$Outcome)
  phase_lmm_out$Outcome_Meaning <- meaning_of(phase_lmm_out$Outcome)
  phase_lmm_out$Units           <- units_of(phase_lmm_out$Outcome)
  phase_lmm_out$How_To_Read <- sprintf("Beta > 0: %s higher in %s than %s; < 0: lower. Beta units: Primary rows = Units (ln(Units) for the 7 HRV outcomes, notebook transform); Sensitivity_WPZ rows = within-person SD. Reference_Mean_raw/Comparison_Mean_raw and SMD_paired_Bonett use the same analysis units (ln for HRV).",
                                 phase_lmm_out$Outcome, phase_lmm_out$Comparison_PhaseID, phase_lmm_out$Reference_PhaseID)
  phase_lmm_out$Method_Citation <- paste(CITE_WPZ, CITE_LMM, CITE_EMM, CITE_FDR, CITE_SMD, sep = " | ")
  phase_lmm_cols <- c("Hypothesis", "Sub_Hypothesis", "Contrast", "Reference_PhaseID", "Comparison_PhaseID",
                "Outcome", "Outcome_Label", "Units", "Outcome_Meaning", "Direction", "How_To_Read",
                "Beta", "SE", "df", "t_ratio", "p_value", "q_FDR", "FDR_significant", "Family_Size",
                "SMD_paired_Bonett", "SMD_CI95_low", "SMD_CI95_high",
                "Reference_Mean_raw", "Comparison_Mean_raw", "N_Participants",
                "Model_Formula", "Interaction_Test", "Normalization", "Method_Citation")
  phase_lmm_clean_table <- phase_lmm_out[, intersect(phase_lmm_cols, names(phase_lmm_out)), drop = FALSE]

  h2_table$Questionnaire       <- h2_table$Psychological_Measure
  h2_table$Physio              <- h2_table$Physiological_Measure
  h2_table$Physio_Label        <- label_of(h2_table$Physio)
  h2_table$Questionnaire_Label <- label_of(h2_table$Questionnaire)
  h2_table$Physio_Meaning      <- meaning_of(h2_table$Physio)
  pos_sign <- LIT$pos_exp_sign[match(h2_table$Physio, LIT$outcome)]
  h2_table$Literature_Expected_Direction_Anxiety <- ifelse(is.na(pos_sign), "Context-dependent", ifelse(pos_sign > 0, "Lower (-) with higher anxiety", "Higher (+) with higher anxiety"))
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

  safe_write_csv(phase_lmm_clean_table, file.path(OUT_DIR, "H1_H3_Contrasts.csv"))
  safe_write_csv(h2_clean_table, file.path(OUT_DIR, "H2_Physio_Psycho_Concordance.csv"))
  safe_write_csv(temporal_table, file.path(OUT_DIR, "H1_H3_Temporal_TimeSeries_AR1.csv"))
  safe_write_csv(temporal_sens_table, file.path(OUT_DIR, "H1_H3_Temporal_AR1_Sensitivity.csv"))
  model_audit_df <- safe_rbind(model_audit)
  safe_write_csv(model_audit_df, file.path(OUT_DIR, "Model_Audit.csv"))

  # 8. Forest Plots -------------------------------------------------------------
  if (MAKE_FIGURES) {
    cat("[6/6] Rendering primary forest plots...\n")
  
    # H1 & H3 forest plot: paired SMD (Bonett 2008) per PhaseID contrast
    plot_df <- phase_lmm_out[phase_lmm_out$Family_Set == "Primary" & is.finite(phase_lmm_out$SMD_paired_Bonett), , drop = FALSE]
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
    H1_Primary_Significant_FDR = sum(phase_lmm_table$Hypothesis == "H1" & phase_lmm_table$Family_Set == "Primary" & phase_lmm_table$FDR_significant),
    H1_Sensitivity_WPZ_Significant_FDR = sum(phase_lmm_table$Hypothesis == "H1" & phase_lmm_table$Family_Set == "Sensitivity_WPZ" & phase_lmm_table$FDR_significant),
    H3_Sensitivity_WPZ_Significant_FDR = sum(phase_lmm_table$Hypothesis == "H3" & phase_lmm_table$Family_Set == "Sensitivity_WPZ" & phase_lmm_table$FDR_significant),
    H3_Primary_Significant_FDR = sum(phase_lmm_table$Hypothesis == "H3" & phase_lmm_table$Family_Set == "Primary" & phase_lmm_table$FDR_significant),
    H2_Significant_FDR = sum(h2_table$FDR_significant),
    Total_Attempted_Models_Audited = nrow(model_audit_df),
    Failed_or_Unstable_Models = sum(grepl("NOT_FIT|FAILED_CONVERGENCE|UNSTABLE", model_audit_df$Status)),
    stringsAsFactors = FALSE
  )
  write.csv(manifest, file.path(OUT_DIR, "Run_Manifest.csv"), row.names = FALSE, na = "")

  cat("   H1 and H3 contrasts:", nrow(phase_lmm_clean_table), "rows | H2 pairs:", nrow(h2_clean_table), "rows\n")
  cat(sprintf("   Model Audit Logged: %d total attempted models (%d fits, %d non-fits/skips logged)\n",
              nrow(model_audit_df), sum(model_audit_df$Status == "FIT"),
              sum(model_audit_df$Status != "FIT")))
  cat("\nSUCCESS: H1 and H3 pipeline finished (H2 included). H4: scripts/H4_multivariate.R.\n")
}

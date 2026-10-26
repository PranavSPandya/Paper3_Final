# H4 multivariate LME — meeting spec (engine: H4_core.R)
suppressPackageStartupMessages({
  library(ggplot2)
  library(gridExtra)
})

required_packages <- c("ggplot2", "gridExtra", "car", "nlme", "clubSandwich")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)
grDevices::pdf(file = NULL)

script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
SCRIPT_DIR <- if (length(script_arg)) {
  dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE))
} else {
  wd <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
  if (basename(wd) == "scripts") wd else file.path(wd, "scripts")
}
source(file.path(SCRIPT_DIR, "Paper3_common.R"), local = FALSE)

PROJECT_ROOT <- resolve_project_root()
H4_SCRIPT_PATH <- if (length(script_arg) && file.exists(script_arg[1])) script_arg[1] else file.path(PROJECT_ROOT, "scripts/H4_multivariate.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))

# Cohort, phase and outcome specification
# physiological: 26 fitted outcomes (indices 1-13 empatica, 14-26 eyetracker).
# Slice examples: empatica only [1:13]; eyetracker only [14:26]; HRV log-transform subset = attr(..., "hrv_log").
H4_SPEC <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = c("BikeU", "BikeG", "WalkU", "WalkG"),
  outcomes = list(physiological = paper3_physiological_outcomes()),
  vif_threshold = 5,
  expected_epochs = 49L,
  # Eq 2 (sound sensitivity) is in the design/VIF catalog; Step 5 fits it only when TRUE.
  fit_sound_sensitivity = FALSE
)

stopifnot(length(H4_SPEC$outcomes$physiological) == 26L)
H4_SPEC$all_outcomes <- H4_SPEC$outcomes$physiological
H4_SPEC$h4_1_outcomes <- H4_SPEC$all_outcomes

hrv_log_outcomes <- function() attr(H4_SPEC$outcomes$physiological, "hrv_log")
hrv_fd_outcomes <- function() attr(H4_SPEC$outcomes$physiological, "hrv_fd")

# Data-prep metadata (outcome_transform, bilateral_sources) is set in H4_core.R when sourced.


# ==============================================================================
# SEVEN EXPLICIT MULTIVARIATE LME MODELS (PRIMARY & SENSITIVITY)
# ==============================================================================

# PCA-informed sound mains for proposed Eq 2 (Sound_screening_pca_vif.md); Eq 1 structure unchanged.
H4_EQ2_SOUND_MAIN_TERMS <- c(
  "freq_prop_20_125", "urban_manmade_positive_prop", "vehicle_prop", "wind_prop",
  "freq_prop_8000_20000", "mechanisms_prop", "octave_prop_125_0_hz",
  "urban_manmade_neutral_prop", "freq_prop_4000_8000", "dominant_frequency_hz"
)

# UTCI in rows 1–2, 6–7: Eq1 primary; Eq2 sound sensitivity on UTCI+PM2.5; Eqs 6–7 PM size on UTCI.
equation_spec <- data.frame(
  equation_id = 1:7,
  heat_key = c("UTCI", "UTCI", "AIR_temp + AIR_RH + WIND_AWS", "HUMIDEX", "PET", "UTCI", "UTCI"),
  pm = c("atmo_pm2.5_avg", "atmo_pm2.5_avg", rep("atmo_pm2.5_avg", 3), "atmo_pm1_avg", "atmo_pm10_avg"),
  role = c("primary", "sound_sensitivity", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity",
    "pm_size_sensitivity", "pm_size_sensitivity"),
  stringsAsFactors = FALSE
)

# Nested random intercepts: participant, then phase within participant (random effects, not fixed).
# AR(1) on residuals within bout (correlation structure, not a fixed effect).
# Eq 1 (Primary Model): UTCI * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 2 (Sound sensitivity): Eq 1 + ten PCA-screened sound main effects (freq/semantic props + dominant frequency)
Eq2 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop + freq_prop_8000_20000 + mechanisms_prop + octave_prop_125_0_hz + urban_manmade_neutral_prop + freq_prop_4000_8000 + dominant_frequency_hz + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 3 (Heat sensitivity — air temp, RH, wind): air temp * Sound + RH * Sound + wind * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq3 <- quote(nlme::lme(
  Y ~ ucm_MRT * ucm_SND_dBA +  ucm_AIR_temp * ucm_SND_dBA + ucm_AIR_RH * ucm_SND_dBA + ucm_WIND_AWS * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 4 (Heat sensitivity — HUMIDEX): HUMIDEX * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq4 <- quote(nlme::lme(
  Y ~ ucm_HUMIDEX * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 5 (Heat sensitivity — PET): PET * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq5 <- quote(nlme::lme(
  Y ~ ucm_PET * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 6 (PM size sensitivity — PM1): UTCI * Sound + solar irradiance + SVF (sky view) + PM1 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq6 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm1_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 7 (PM size sensitivity — PM10): UTCI * Sound + solar irradiance + SVF (sky view) + PM10 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq7 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm10_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Pipeline validation: fixed-effect order parsed from the seven formulas above (not edited separately).
h4_fixed_terms_from_lme_quote <- function(lme_quote) {
  fml <- as.formula(lme_quote[[2L]])
  gsub("`", "", attr(terms(fml), "term.labels"), fixed = TRUE)
}
H4_EQUATION_FIXED <- list(
  `1` = h4_fixed_terms_from_lme_quote(Eq1),
  `2` = h4_fixed_terms_from_lme_quote(Eq2),
  `3` = h4_fixed_terms_from_lme_quote(Eq3),
  `4` = h4_fixed_terms_from_lme_quote(Eq4),
  `5` = h4_fixed_terms_from_lme_quote(Eq5),
  `6` = h4_fixed_terms_from_lme_quote(Eq6),
  `7` = h4_fixed_terms_from_lme_quote(Eq7)
)
stopifnot(identical(H4_EQ2_SOUND_MAIN_TERMS, setdiff(H4_EQUATION_FIXED[["2"]], H4_EQUATION_FIXED[["1"]])))

# ==============================================================================
# WORKFLOW
# ==============================================================================
run_h4 <- function() {
  # Load audit/fit engine after H4_SPEC and Eq1–7 are defined (script top level).
  source(file.path(SCRIPT_DIR, "H4_core.R"), local = FALSE)
  cat("==============================================================================\n")
  cat("Running H4: Multivariate Models of Noise Amplification on Thermal Discomfort\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(H4_SPEC$participants), paste(H4_SPEC$participants, collapse = ", ")))
  cat(sprintf("Outcomes     (%d): %d empatica + %d eyetracker (physiological vector)\n",
              length(H4_SPEC$all_outcomes), 13L, 13L))
  cat(sprintf("Equations    (%d): 1 Primary, 1 Sound (fit=%s), 3 Heat, 2 PM\n\n",
              nrow(equation_spec), H4_SPEC$fit_sound_sensitivity))

  h4_dispatch_run()
}

if (sys.nframe() == 0L) run_h4()

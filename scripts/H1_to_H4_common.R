# H1_to_H4_common.R — minimal shared cohort/outcome/path helpers (H1–H3 meeting file, H4_multivariate.R).
# Not sourced by H4_core.R (H4-only audit/engine stays decoupled).

resolve_project_root <- function() {
  normalizePath(file.path(SCRIPT_DIR, ".."), winslash = "/", mustWork = TRUE)
}

PAPER3_PARTICIPANTS <- c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17")
PAPER3_CORE_PHASES <- c("BikeU", "WalkU", "BikeG", "WalkG")
PAPER3_MATCHED_CAP_SEC <- 8L * 60L

paper3_merged_8min_path <- function(root = resolve_project_root()) {
  file.path(root, "output", "merged_all_11participants_8min.csv")
}

# 26 physiological outcomes (indices 1–13 empatica, 14–26 eyetracker); attrs match H4_multivariate.R.
paper3_physiological_outcomes <- function() {
  p <- c(
    "empatica_heart_rate", "empatica_eda_tonic", "empatica_eda_phasic", "empatica_skin_temperature",
    "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd", "empatica_hrv_fd_lf", "empatica_hrv_fd_hf",
    "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_lfnu", "empatica_hrv_fd_hfnu", "empatica_hrv_fd_vlf",
    "empatica_hrv_fd_total_power",
    "eyetracker_pupil_diameter_avg", "eyetracker_pupil_change_rate", "eyetracker_blink_duration_s",
    "eyetracker_fixation_duration_s", "eyetracker_fixation_rate", "eyetracker_saccade_duration_s",
    "eyetracker_saccade_amplitude", "eyetracker_saccade_peak_velocity", "eyetracker_gaze_velocity",
    "eyetracker_gaze_dispersion", "eyetracker_distance_from_center", "eyetracker_gaze_centrality",
    "eyetracker_eyelid_aperture_avg"
  )
  attr(p, "hrv_log") <- p[c(5L, 6L, 7L, 8L, 9L, 12L, 13L)]
  attr(p, "hrv_fd") <- p[7L:13L]
  p
}

# Outcome transforms aligned with Normalization_results.md "Transformation in Step 5".
# profile "step5" = Normalization_results.md "Transformation in Step 5".
paper3_outcome_normalization_map <- function(profile = "step5") {
  profile <- match.arg(profile, c("step5"))
  out <- paper3_physiological_outcomes()
  map <- setNames(rep("native", length(out)), out)
  map[attr(out, "hrv_log")] <- "log"
  map
}

paper3_outcome_transform_label <- function(kind) {
  switch(kind, native = "native", log = "natural log", sqrt = "square root",
    stop("Unknown outcome transform kind: ", kind, call. = FALSE))
}

paper3_outcome_transform_apply <- function(x, kind) {
  x <- as.numeric(x)
  if (kind == "native") return(x)
  if (kind == "log") {
    x[!is.finite(x) | x <= 0] <- NA_real_
    x[is.finite(x)] <- log(x[is.finite(x)])
    return(x)
  }
  if (kind == "sqrt") {
    x[!is.finite(x) | x < 0] <- NA_real_
    x[is.finite(x)] <- sqrt(x[is.finite(x)])
    return(x)
  }
  stop("Unknown outcome transform kind: ", kind, call. = FALSE)
}

paper3_outcome_transform_eligible <- function(x, kind) {
  x <- as.numeric(x)
  if (kind == "log") is.finite(x) & x > 0
  else if (kind == "sqrt") is.finite(x) & x >= 0
  else is.finite(x)
}

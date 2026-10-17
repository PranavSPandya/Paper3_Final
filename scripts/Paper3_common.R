# Paper3_common.R — minimal shared cohort/outcome/path helpers (H1–H3 meeting file, H4_multivariate.R).
# Not sourced by H4_core.R (H4-only audit/engine stays decoupled).

resolve_project_root <- function() {
  arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  candidates <- c(
    if (length(arg)) file.path(dirname(sub("^--file=", "", arg[1])), ".."),
    getwd(),
    file.path(getwd(), "..")
  )
  for (root in unique(candidates)) {
    root <- normalizePath(root, winslash = "/", mustWork = FALSE)
    if (file.exists(file.path(root, "output/merged_all_11participants_8min.csv"))) return(root)
  }
  stop("Cannot find output/merged_all_11participants_8min.csv; run from the repository or scripts folder.", call. = FALSE)
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

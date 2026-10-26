# Paper3_common.R — minimal shared cohort/outcome/path helpers (H1–H3 meeting file, H4_time_series.R).
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

# 26 physiological outcomes (indices 1–13 empatica, 14–26 eyetracker); attrs match H4_time_series.R.
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
  attr(p, "hrv_log") <- p[c(2L, 5L, 6L, 7L, 8L, 9L, 12L, 13L)]
  attr(p, "hrv_fd") <- p[7L:13L]
  p
}

PAPER3_NORMALIZATION_CSV <- file.path("output", "statistical_analysis", "Normalization & Parameter Screening",
  "Normalization", "Normalization_H1toH4_all_parameters.csv")
PAPER3_OUTCOME_TRANSFORMS <- c("Natural log", "No transformation")

# Natural-log outcomes as written by Normalization_H1toH4.ipynb (transformation_in_models).
# Stops on missing or unknown transformations and when the log set differs from attr(outcomes, "hrv_log").
paper3_log_outcomes <- function(outcomes = paper3_physiological_outcomes(), root = resolve_project_root()) {
  path <- file.path(root, PAPER3_NORMALIZATION_CSV)
  table <- read.csv(path, check.names = FALSE, stringsAsFactors = FALSE)
  if (anyDuplicated(table$column_name)) stop("Duplicate column_name rows in ", path, call. = FALSE)
  rule <- table$transformation_in_models[match(outcomes, table$column_name)]
  if (anyNA(rule)) stop("No transformation in ", path, " for: ", paste(outcomes[is.na(rule)], collapse = ", "), call. = FALSE)
  unknown <- setdiff(rule, PAPER3_OUTCOME_TRANSFORMS)
  if (length(unknown)) stop("Unknown outcome transformation in ", path, ": ", paste(unknown, collapse = ", "), call. = FALSE)
  logged <- outcomes[rule == "Natural log"]
  declared <- attr(outcomes, "hrv_log")
  if (!setequal(logged, declared)) stop("Natural-log outcomes in ", path, " differ from attr(outcomes, \"hrv_log\"). CSV only: ",
    paste(setdiff(logged, declared), collapse = ", "), "; hrv_log only: ", paste(setdiff(declared, logged), collapse = ", "), call. = FALSE)
  logged
}

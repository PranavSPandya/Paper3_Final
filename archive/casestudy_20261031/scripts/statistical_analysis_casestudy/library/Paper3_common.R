# Paper3_common.R — shared cohort/outcome/path helpers (H1–H3 and H4 meeting files).
# Sourced at the top of meeting entry scripts only; H4_core.R stays decoupled from re-sourcing this file.

.paper3_resolve_script_dir <- function() {
  script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (length(script_arg)) {
    return(dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE)))
  }
  entry <- get0(".entry", envir = .GlobalEnv, ifnotfound = character())
  if (length(entry) && file.exists(entry[1L])) {
    return(dirname(normalizePath(entry[1L], winslash = "/", mustWork = TRUE)))
  }
  wd <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
  if (basename(wd) == "statistical_analysis") {
    wd
  } else if (basename(wd) == "scripts") {
    file.path(wd, "statistical_analysis")
  } else {
    file.path(wd, "scripts", "statistical_analysis")
  }
}

paper3_statistical_script_dir <- function() {
  .paper3_resolve_script_dir()
}

paper3_statistical_library_dir <- function(script_dir = paper3_statistical_script_dir()) {
  file.path(script_dir, "library")
}

resolve_project_root <- function() {
  arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  entry <- get0(".entry", envir = .GlobalEnv, ifnotfound = character())
  start_dirs <- c(if (length(arg)) dirname(sub("^--file=", "", arg[1])),
    if (length(entry) && file.exists(entry[1L])) dirname(entry[1L]), getwd())
  candidates <- unlist(lapply(start_dirs, function(d) {
    d <- normalizePath(d, winslash = "/", mustWork = FALSE)
    if (basename(d) == "library" && basename(dirname(d)) == "statistical_analysis") {
      d <- dirname(d)
    }
    c(
      d,
      file.path(d, ".."),
      file.path(d, "..", ".."),
      file.path(d, "..", "..", ".."),
      file.path(d, "..", "..", "..", "..")
    )
  }))
  for (root in unique(candidates)) {
    root <- normalizePath(root, winslash = "/", mustWork = FALSE)
    if (file.exists(file.path(root, "output/merged_all_11participants_8min.csv"))) return(root)
  }
  stop(
    "Cannot find output/merged_all_11participants_8min.csv; run an entry script under scripts/statistical_analysis/ or set wd to the repository.",
    call. = FALSE
  )
}

paper3_entry_script_path <- function(fallback_relative) {
  script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (length(script_arg) && file.exists(script_arg[1])) {
    script_arg[1]
  } else {
    file.path(resolve_project_root(), fallback_relative)
  }
}

paper3_source_statistical_common_if_needed <- function() {
  if (exists("PAPER3_PARTICIPANTS", envir = .GlobalEnv, inherits = FALSE)) {
    return(invisible(FALSE))
  }
  script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (!length(script_arg)) {
    trailing <- commandArgs(trailingOnly = TRUE)
    if (length(trailing) && file.exists(trailing[1])) script_arg <- trailing[1]
  }
  common_path <- if (length(script_arg)) {
    file.path(
      dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE)),
      "library", "Paper3_common.R"
    )
  } else if (file.exists("library/Paper3_common.R")) {
    normalizePath("library/Paper3_common.R", winslash = "/", mustWork = TRUE)
  } else if (file.exists("scripts/statistical_analysis/library/Paper3_common.R")) {
    normalizePath("scripts/statistical_analysis/library/Paper3_common.R", winslash = "/", mustWork = TRUE)
  } else {
    stop(
      "Cannot locate Paper3_common.R; run via Rscript on an entry script or setwd to scripts/statistical_analysis.",
      call. = FALSE
    )
  }
  source(common_path, local = FALSE)
  invisible(TRUE)
}

paper3_attach_statistical_common <- function() {
  if (!exists("PAPER3_PARTICIPANTS", envir = .GlobalEnv, inherits = FALSE)) {
    paper3_source_statistical_common_if_needed()
  }
  script_dir <- paper3_statistical_script_dir()
  library_dir <- paper3_statistical_library_dir(script_dir)
  assign("SCRIPT_DIR", script_dir, envir = .GlobalEnv)
  assign("LIBRARY_DIR", library_dir, envir = .GlobalEnv)
  invisible(list(
    script_dir = script_dir,
    library_dir = library_dir,
    project_root = resolve_project_root()
  ))
}

paper3_entry_load_packages <- function(
  required_packages,
  load_packages = character(),
  h4_pdf_null = FALSE,
  extra_setup = NULL
) {
  missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing_packages)) {
    stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)
  }
  if (length(load_packages)) {
    suppressPackageStartupMessages({
      for (pkg in load_packages) {
        library(pkg, character.only = TRUE)
      }
    })
  }
  if (isTRUE(h4_pdf_null)) {
    grDevices::pdf(file = NULL)
  }
  if (is.function(extra_setup)) {
    extra_setup()
  }
  invisible(NULL)
}

paper3_statistical_bootstrap <- function(
  required_packages,
  load_packages = character(),
  extra_setup = NULL,
  h4_pdf_null = FALSE
) {
  info <- paper3_attach_statistical_common()
  paper3_entry_load_packages(
    required_packages = required_packages,
    load_packages = load_packages,
    h4_pdf_null = h4_pdf_null,
    extra_setup = extra_setup
  )
  info
}

PAPER3_PARTICIPANTS <- c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17")
PAPER3_CORE_PHASES <- c("BikeU", "WalkU", "BikeG", "WalkG")
PAPER3_MATCHED_CAP_SEC <- 8L * 60L

paper3_merged_8min_path <- function(root = resolve_project_root()) {
  file.path(root, "output", "merged_all_11participants_8min.csv")
}

PAPER3_N_PHYSIOLOGICAL <- 26L
PAPER3_N_EMPATICA <- 13L

# Physiological outcomes (empatica then eyetracker); attrs used only inside Paper3_common helpers.
paper3_physiological_outcomes <- function() {
  physiological_outcome_names <- c(
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
  attr(physiological_outcome_names, "empatica_hrv_fd_window") <- physiological_outcome_names[7L:13L]
  physiological_outcome_names
}

paper3_validate_physiological_outcomes <- function(outcomes) {
  canonical <- paper3_physiological_outcomes()
  if (!identical(outcomes, canonical)) {
    stop("physiological_outcome_names must be identical to paper3_physiological_outcomes().", call. = FALSE)
  }
  invisible(outcomes)
}

paper3_physiological_outcome_groups <- function(outcomes = paper3_physiological_outcomes()) {
  paper3_validate_physiological_outcomes(outcomes)
  list(
    empatica = outcomes[seq_len(PAPER3_N_EMPATICA)],
    eyetracker = outcomes[seq(PAPER3_N_EMPATICA + 1L, PAPER3_N_PHYSIOLOGICAL)]
  )
}

PAPER3_NORMALIZATION_CSV <- file.path("output", "statistical_analysis", "Normalization & Parameter Screening",
  "Normalization", "Normalization_H1toH4_all_parameters.csv")
PAPER3_OUTCOME_TRANSFORMS <- c("Natural log", "No transformation")

paper3_read_outcome_transforms_csv <- function(outcomes, root = resolve_project_root()) {
  paper3_validate_physiological_outcomes(outcomes)
  path <- file.path(root, PAPER3_NORMALIZATION_CSV)
  table <- read.csv(path, check.names = FALSE, stringsAsFactors = FALSE)
  if (anyDuplicated(table$column_name)) stop("Duplicate column_name rows in ", path, call. = FALSE)
  rows <- table[match(outcomes, table$column_name), c("column_name", "transformation_in_models"), drop = FALSE]
  if (anyNA(rows$column_name)) {
    stop("No normalization CSV row for: ", paste(outcomes[is.na(rows$column_name)], collapse = ", "), call. = FALSE)
  }
  unknown <- setdiff(rows$transformation_in_models, PAPER3_OUTCOME_TRANSFORMS)
  if (length(unknown)) stop("Unknown transformation_in_models in ", path, ": ", paste(unknown, collapse = ", "), call. = FALSE)
  rownames(rows) <- NULL
  rows
}

paper3_log_outcomes <- function(outcomes = paper3_physiological_outcomes(), root = resolve_project_root()) {
  rows <- paper3_read_outcome_transforms_csv(outcomes, root)
  outcomes[rows$transformation_in_models == "Natural log"]
}

paper3_normalization_csv_path <- function(root = resolve_project_root()) {
  file.path(root, PAPER3_NORMALIZATION_CSV)
}

# Natural log ln(x) for model outcomes; non-finite and x <= 0 -> NA (matches Normalization_H1toH4.ipynb).
paper3_outcome_natural_log <- function(x) {
  ifelse(is.finite(x) & x > 0, log(x), NA_real_)
}

paper3_apply_csv_transform <- function(x, column_name, outcome_transforms_csv) {
  label <- outcome_transforms_csv$transformation_in_models[
    match(column_name, outcome_transforms_csv$column_name)
  ]
  if (is.na(label)) stop("No transformation_in_models for column: ", column_name, call. = FALSE)
  if (label == "Natural log") paper3_outcome_natural_log(x)
  else if (label == "No transformation") x
  else stop("Unsupported transformation_in_models: ", label, call. = FALSE)
}

# Step B (H1–H3): (x - mean(x | ParticipantID)) / sd(x | ParticipantID); sd == 0 -> NA.
paper3_within_person_z <- function(x, ParticipantID) {
  ave(as.numeric(x), ParticipantID, FUN = function(v) {
    m <- mean(v, na.rm = TRUE)
    s <- sd(v, na.rm = TRUE)
    if (!is.finite(s) || s == 0) rep(NA_real_, length(v)) else (v - m) / s
  })
}

paper3_attach_outcome_normalization <- function(spec, root = resolve_project_root()) {
  if (is.null(spec$physiological_outcome_names)) {
    stop("spec must include physiological_outcome_names.", call. = FALSE)
  }
  path <- paper3_normalization_csv_path(root)
  if (!file.exists(path)) stop("Missing normalization CSV: ", path, call. = FALSE)
  spec$normalization_csv_path <- path
  spec$outcome_transforms_csv <- paper3_read_outcome_transforms_csv(spec$physiological_outcome_names, root)
  spec$natural_log_outcome_names <- spec$physiological_outcome_names[
    spec$outcome_transforms_csv$transformation_in_models == "Natural log"
  ]
  spec
}

paper3_ensure_outcome_normalization <- function(spec, root = resolve_project_root()) {
  paper3_validate_physiological_outcomes(spec$physiological_outcome_names)
  if (is.null(spec$outcome_transforms_csv)) {
    paper3_attach_outcome_normalization(spec, root)
  } else {
    if (is.null(spec$normalization_csv_path)) {
      spec$normalization_csv_path <- paper3_normalization_csv_path(root)
    }
    if (is.null(spec$natural_log_outcome_names)) {
      spec$natural_log_outcome_names <- spec$physiological_outcome_names[
        spec$outcome_transforms_csv$transformation_in_models == "Natural log"
      ]
    }
    spec
  }
}

# Preregistered H1 (green vs urban within mode) and H3 (walk vs bike within environment) contrasts.
# Beta = Comparison minus Reference; emmeans reference level = BikeU.
paper3_h1_h3_planned_contrast_tables <- function() {
  h1 <- data.frame(
    Hypothesis = "H1",
    Sub_Hypothesis = c("H1.1", "H1.2"),
    Reference_PhaseID = c("BikeU", "WalkU"),
    Comparison_PhaseID = c("BikeG", "WalkG"),
    stringsAsFactors = FALSE
  )
  h3 <- data.frame(
    Hypothesis = "H3",
    Sub_Hypothesis = c("H3.1", "H3.2"),
    Reference_PhaseID = c("BikeU", "BikeG"),
    Comparison_PhaseID = c("WalkU", "WalkG"),
    stringsAsFactors = FALSE
  )
  h1$Contrast <- paste(h1$Reference_PhaseID, h1$Comparison_PhaseID, sep = "_")
  h3$Contrast <- paste(h3$Reference_PhaseID, h3$Comparison_PhaseID, sep = "_")
  list(h1 = h1, h3 = h3)
}

source(file.path(paper3_statistical_library_dir(), "casestudy_covariate.R"), local = FALSE)

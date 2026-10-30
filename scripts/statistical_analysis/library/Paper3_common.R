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

# --- Exploratory participant subgroups (clearness / fitness / activeness) ---
# Canonical clearness: Participant_Clearness_Summary_core_phases.csv (core-phase mean kt).
# Clearness lower/higher: fixed literature epoch-class floor kt = 0.30 (matches compute_clearness_index.py).
# Fitness/activeness: output/statistical_analysis/Participant Casestudy/Participant_fitness_activeness.csv

PAPER3_CLEARNESS_SUBGROUP_KT_THRESHOLD <- 0.30

paper3_fitness_activeness_lookup_path <- function(root = resolve_project_root()) {
  file.path(root, "output", "statistical_analysis", "Participant Casestudy", "Participant_fitness_activeness.csv")
}

paper3_clearness_summary_core_path <- function(root = resolve_project_root()) {
  file.path(root, "output", "Clearness Index", "Participant_Clearness_Summary_core_phases.csv")
}

paper3_exploratory_group_levels <- function() {
  list(
    clearness_index = c("higher", "lower"),
    fitness = c("fit", "not_fit"),
    activeness = c("active", "inactive")
  )
}

paper3_exploratory_group_assignments <- function(project_root = resolve_project_root()) {
  lookup <- read.csv(paper3_fitness_activeness_lookup_path(project_root), stringsAsFactors = FALSE)
  ci <- read.csv(paper3_clearness_summary_core_path(project_root), stringsAsFactors = FALSE)
  stopifnot(
    !anyDuplicated(lookup$ParticipantID),
    !anyDuplicated(ci$ParticipantID),
    setequal(lookup$ParticipantID, PAPER3_PARTICIPANTS),
    setequal(ci$ParticipantID, PAPER3_PARTICIPANTS),
    all(is.finite(ci$Clearness_Index_Mean))
  )
  cutoff <- PAPER3_CLEARNESS_SUBGROUP_KT_THRESHOLD
  ci_key <- setNames(ci$Clearness_Index_Mean, ci$ParticipantID)
  out <- lookup
  out$clearness_mean <- unname(ci_key[out$ParticipantID])
  out$clearness_group <- ifelse(out$clearness_mean >= cutoff, "Higher", "Lower")
  out$clearness_index <- tolower(out$clearness_group)
  out$clearness_rule <- sprintf("participant_mean_kt_%s_literature_0.30", ifelse(out$clearness_mean >= cutoff, "ge", "lt"))
  out$fitness_group <- out$fitness
  out$fitness <- ifelse(out$fitness == "Fit", "fit", "not_fit")
  out$activeness <- tolower(out$activeness)
  out$clearness_cutoff <- cutoff
  out[, c(
    "ParticipantID", "clearness_mean", "clearness_cutoff", "clearness_rule", "clearness_group", "clearness_index",
    "fitness_group", "fitness", "activeness"
  )]
}

paper3_write_exploratory_group_assignments_csv <- function(project_root = resolve_project_root()) {
  tab <- paper3_exploratory_group_assignments(project_root)
  path <- file.path(project_root, "output", "statistical_analysis", "results", "H_group_assignments_grouped_by_all.csv")
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  utils::write.csv(tab, path, row.names = FALSE)
  invisible(path)
}

paper3_active_participants <- function() {
  opt <- getOption("paper3_exploratory_group_ids", NULL)
  if (!is.null(opt)) return(as.character(opt))
  PAPER3_PARTICIPANTS
}

paper3_parse_exploratory_group_cli <- function(args = commandArgs(trailingOnly = TRUE)) {
  group_arg <- sub("^--group=", "", grep("^--group=", args, value = TRUE))
  level_arg <- sub("^--level=", "", grep("^--level=", args, value = TRUE))
  if (length(group_arg) != 1L || length(level_arg) != 1L) {
    stop(
      "Specify --group=clearness_index|fitness|activeness and ",
      "--level=higher|lower|fit|not_fit|active|inactive",
      call. = FALSE
    )
  }
  list(
    dimension = group_arg[1L],
    level = level_arg[1L],
    overwrite = "--overwrite" %in% args
  )
}

paper3_exploratory_group_output_suffix <- function(dimension, level) {
  paste0("_grouped_by_", dimension, "_", level)
}

paper3_exploratory_group_participant_ids <- function(dimension, level, assignments = NULL, project_root = resolve_project_root()) {
  allowed <- paper3_exploratory_group_levels()
  if (!dimension %in% names(allowed) || !level %in% allowed[[dimension]]) {
    stop("Invalid exploratory group or level: ", dimension, " / ", level, call. = FALSE)
  }
  if (is.null(assignments)) assignments <- paper3_exploratory_group_assignments(project_root)
  col <- dimension
  ids <- assignments$ParticipantID[assignments[[col]] == level]
  if (!length(ids)) stop("No participants for group ", dimension, " / ", level, call. = FALSE)
  as.character(ids)
}

paper3_exploratory_group_out_dir <- function(project_root, results_base_name, dimension, level) {
  file.path(
    project_root,
    "output",
    "statistical_analysis",
    "results",
    paste0(results_base_name, paper3_exploratory_group_output_suffix(dimension, level))
  )
}

paper3_write_exploratory_group_sidecar <- function(grp, out_dir = grp$out_dir) {
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  utils::write.csv(grp$assignments, file.path(out_dir, "group_assignments.csv"), row.names = FALSE)
  suffix <- grp$output_suffix
  notes <- c(
    paste("Group:", grp$dimension, grp$level),
    paste("Participant IDs:", paste(grp$participant_ids, collapse = ", ")),
    paste("Participants:", length(grp$participant_ids)),
    paste(
      "Clearness rule (when used): participant mean kt over core phases;",
      "lower = kt < 0.30, higher = kt >= 0.30 (literature cloudy/overcast boundary;",
      "matches epoch Sunny/Partly/Cloudy thresholds in compute_clearness_index.py)."
    ),
    paste("Clearness cutoff kt:", grp$clearness_cutoff),
    "Exploratory subgroup: observational labels; participant and field-day confounding possible.",
    "Do not treat significance differences across groups as causal."
  )
  base::writeLines(notes, file.path(out_dir, paste0("group_notes", suffix, ".txt")))
  invisible(out_dir)
}

paper3_exploratory_group_from_cli <- function(
  project_root,
  results_base_name,
  stop_if_nonempty = TRUE,
  args = commandArgs(trailingOnly = TRUE)
) {
  cli <- paper3_parse_exploratory_group_cli(args)
  assignments <- paper3_exploratory_group_assignments(project_root)
  ids <- paper3_exploratory_group_participant_ids(cli$dimension, cli$level, assignments)
  out_dir <- paper3_exploratory_group_out_dir(project_root, results_base_name, cli$dimension, cli$level)
  allow_overwrite <- isTRUE(cli$overwrite) || identical(Sys.getenv("PAPER3_GROUP_OVERWRITE", ""), "1")
  if (
    isTRUE(stop_if_nonempty) && !allow_overwrite &&
      dir.exists(out_dir) && length(list.files(out_dir, all.files = TRUE, no.. = TRUE))
  ) {
    stop("Output folder exists and is not empty: ", out_dir, call. = FALSE)
  }
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  grp <- list(
    dimension = cli$dimension,
    level = cli$level,
    participant_ids = ids,
    assignments = assignments,
    clearness_cutoff = assignments$clearness_cutoff[1L],
    output_suffix = paper3_exploratory_group_output_suffix(cli$dimension, cli$level),
    out_dir = out_dir,
    results_base_name = results_base_name
  )
  paper3_write_exploratory_group_sidecar(grp, out_dir)
  grp
}

paper3_apply_exploratory_group_from_cli <- function(project_root, results_base_name, stop_if_nonempty = TRUE) {
  grp <- paper3_exploratory_group_from_cli(project_root, results_base_name, stop_if_nonempty = stop_if_nonempty)
  options(
    paper3_exploratory_group_ids = grp$participant_ids,
    paper3_exploratory_output_suffix = grp$output_suffix
  )
  Sys.setenv(PAPER3_OUT_DIR = grp$out_dir)
  invisible(grp)
}

# Primary H1/H3 pipelines require >= 8 participants (see H1_H3_core.R model_data_ok guards).
PAPER3_EXPLORATORY_MIN_PARTICIPANTS_H1H3 <- 8L

paper3_exploratory_group_active <- function() {
  !is.null(getOption("paper3_exploratory_group_ids", NULL))
}

paper3_exploratory_min_participants_h1h3 <- function() {
  as.integer(Sys.getenv("PAPER3_EXPLORATORY_MIN_PARTICIPANTS_H1H3", PAPER3_EXPLORATORY_MIN_PARTICIPANTS_H1H3))
}

paper3_exploratory_h1h3_inference_eligible <- function(n_participants) {
  as.integer(n_participants) >= paper3_exploratory_min_participants_h1h3()
}

paper3_exploratory_write_inference_skipped <- function(out_dir, output_suffix, pipeline_label, n_participants, participant_ids, reason = NULL) {
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  min_n <- paper3_exploratory_min_participants_h1h3()
  if (is.null(reason)) {
    reason <- sprintf(
      "Skipped inferential publish: %d participant(s) in subgroup (minimum %d for %s). Audit-only or empty contrast tables are expected; do not interpret as null findings.",
      as.integer(n_participants), min_n, pipeline_label
    )
  }
  tab <- data.frame(
    pipeline = pipeline_label,
    skipped_inference = TRUE,
    n_participants = as.integer(n_participants),
    min_participants_required = min_n,
    participant_ids = paste(participant_ids, collapse = ";"),
    reason = reason,
    skipped_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ"),
    stringsAsFactors = FALSE
  )
  path <- file.path(out_dir, paste0("exploratory_inference_skipped", output_suffix, ".csv"))
  utils::write.csv(tab, path, row.names = FALSE)
  cat(reason, "\n")
  invisible(path)
}

# Rename flat outputs in a grouped folder once (idempotent on reruns).
paper3_finish_grouped_output_renames <- function(out_dir, suffix) {
  if (!nzchar(suffix) || !dir.exists(out_dir)) return(invisible(NULL))
  keep_plain <- c("group_assignments.csv")
  files <- list.files(out_dir, full.names = TRUE, recursive = FALSE)
  for (f in files) {
    if (dir.exists(f)) next
    nm <- basename(f)
    if (nm %in% keep_plain) next
    if (grepl(paste0(suffix, "(\\.|$)"), nm)) next
    ext <- tools::file_ext(nm)
    base <- if (nzchar(ext)) sub(paste0("\\.", ext, "$"), "", nm) else nm
    target <- if (nzchar(ext)) {
      file.path(dirname(f), paste0(base, suffix, ".", ext))
    } else {
      paste0(f, suffix)
    }
    if (file.exists(target)) next
    if (!file.rename(f, target)) warning("Could not suffix grouped output: ", f, call. = FALSE)
  }
  invisible(NULL)
}

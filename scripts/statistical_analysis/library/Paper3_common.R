# Shared cohort, paths and helpers for scripts/statistical_analysis/; entry scripts source it and call paper3_statistical_bootstrap().

paper3_statistical_script_dir <- function() {
  script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (length(script_arg)) {
    return(dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE)))}
  entry <- get0(".entry", envir = .GlobalEnv, ifnotfound = character())
  if (length(entry) && file.exists(entry[1L])) {
    return(dirname(normalizePath(entry[1L], winslash = "/", mustWork = TRUE)))}
  wd <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
  if (basename(wd) == "statistical_analysis") {
    wd
  } else if (basename(wd) == "scripts") {
    file.path(wd, "statistical_analysis")
  } else {
    file.path(wd, "scripts", "statistical_analysis")}}

paper3_statistical_library_dir <- function(script_dir = paper3_statistical_script_dir()) {
  file.path(script_dir, "library")}

resolve_project_root <- function() {
  arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  entry <- get0(".entry", envir = .GlobalEnv, ifnotfound = character())
  start_dirs <- c(if (length(arg)) dirname(sub("^--file=", "", arg[1])),
    if (length(entry) && file.exists(entry[1L])) dirname(entry[1L]), getwd())
  candidates <- unlist(lapply(start_dirs, function(directory) {
    directory <- normalizePath(directory, winslash = "/", mustWork = FALSE)
    if (basename(directory) == "library" && basename(dirname(directory)) == "statistical_analysis") {
      directory <- dirname(directory)}
    c(
      directory,
      file.path(directory, ".."),
      file.path(directory, "..", ".."),
      file.path(directory, "..", "..", ".."),
      file.path(directory, "..", "..", "..", ".."))}))
  for (root in unique(candidates)) {
    root <- normalizePath(root, winslash = "/", mustWork = FALSE)
    if (file.exists(file.path(root, "output/merged_all_11participants_8min.csv"))) return(root)}
  stop(
    "Cannot find output/merged_all_11participants_8min.csv; run an entry script under scripts/statistical_analysis/ or set wd to the repository.",
    call. = FALSE)}

paper3_attach_statistical_common <- function() {
  script_dir <- paper3_statistical_script_dir()
  library_dir <- paper3_statistical_library_dir(script_dir)
  assign("SCRIPT_DIR", script_dir, envir = .GlobalEnv)
  assign("LIBRARY_DIR", library_dir, envir = .GlobalEnv)
  invisible(list(
    script_dir = script_dir,
    library_dir = library_dir,
    project_root = resolve_project_root()))}

paper3_entry_load_packages <- function(
  required_packages,
  load_packages = character(),
  extra_setup = NULL
) {
  missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing_packages)) {
    stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)}
  if (length(load_packages)) {
    suppressPackageStartupMessages({
      for (pkg in load_packages) {
        library(pkg, character.only = TRUE)}})}
  if (is.function(extra_setup)) {
    extra_setup()}
  invisible(NULL)}

paper3_statistical_bootstrap <- function(
  required_packages,
  load_packages = character(),
  extra_setup = NULL
) {
  info <- paper3_attach_statistical_common()

  paper3_entry_load_packages(
    required_packages = required_packages,
    load_packages = load_packages,
    extra_setup = extra_setup)
  invisible(info)}

PAPER3_PARTICIPANTS <- c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17")
PAPER3_CORE_PHASES <- c("BikeU", "WalkU", "BikeG", "WalkG")
PAPER3_MATCHED_CAP_SEC <- 8L * 60L

paper3_merged_8min_path <- function(root = resolve_project_root()) {
  file.path(root, "output", "merged_all_11participants_8min.csv")}

# Physiological outcomes (empatica then eyetracker); the attr marks the 5-min HRV frequency-domain window.
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
    "eyetracker_eyelid_aperture_avg")
  attr(physiological_outcome_names, "empatica_hrv_fd_window") <- physiological_outcome_names[7L:13L]
  physiological_outcome_names}

paper3_validate_physiological_outcomes <- function(outcomes) {
  canonical <- paper3_physiological_outcomes()
  if (!identical(outcomes, canonical)) {
    stop("physiological_outcome_names must be identical to paper3_physiological_outcomes().", call. = FALSE)}
  invisible(outcomes)}

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
    stop("No normalization CSV row for: ", paste(outcomes[is.na(rows$column_name)], collapse = ", "), call. = FALSE)}
  unknown <- setdiff(rows$transformation_in_models, PAPER3_OUTCOME_TRANSFORMS)
  if (length(unknown)) stop("Unknown transformation_in_models in ", path, ": ", paste(unknown, collapse = ", "), call. = FALSE)
  rownames(rows) <- NULL
  rows}

paper3_normalization_csv_path <- function(root = resolve_project_root()) {
  file.path(root, PAPER3_NORMALIZATION_CSV)}

# Natural log ln(x) for model outcomes; non-finite and x <= 0 -> NA (matches Normalization_H1toH4.ipynb).
paper3_outcome_natural_log <- function(x) {
  ifelse(is.finite(x) & x > 0, log(x), NA_real_)}

paper3_apply_csv_transform <- function(x, column_name, outcome_transforms_csv) {
  label <- outcome_transforms_csv$transformation_in_models[
    match(column_name, outcome_transforms_csv$column_name)]
  if (is.na(label)) stop("No transformation_in_models for column: ", column_name, call. = FALSE)
  if (label == "Natural log") paper3_outcome_natural_log(x)
  else if (label == "No transformation") x
  else stop("Unsupported transformation_in_models: ", label, call. = FALSE)}

# Outcome transform used by the H5 scripts, which set OUTCOME_TRANSFORMS_CSV first.
PAPER3_APPLY_CSV_TRANSFORM <- function(x, column_name) {
  paper3_apply_csv_transform(x, column_name, OUTCOME_TRANSFORMS_CSV)}

# Within-person z: (x - participant mean) / participant SD; NA when the participant's SD is 0.
paper3_within_person_z <- function(x, ParticipantID) {
  ave(as.numeric(x), ParticipantID, FUN = function(participant_values) {
    participant_mean <- mean(participant_values, na.rm = TRUE)
    participant_sd <- sd(participant_values, na.rm = TRUE)
    if (!is.finite(participant_sd) || participant_sd == 0) rep(NA_real_, length(participant_values)) else (participant_values - participant_mean) / participant_sd})}

paper3_attach_outcome_normalization <- function(spec, root = resolve_project_root()) {
  if (is.null(spec$physiological_outcome_names)) {
    stop("spec must include physiological_outcome_names.", call. = FALSE)}
  path <- paper3_normalization_csv_path(root)
  if (!file.exists(path)) stop("Missing normalization CSV: ", path, call. = FALSE)
  spec$normalization_csv_path <- path
  spec$outcome_transforms_csv <- paper3_read_outcome_transforms_csv(spec$physiological_outcome_names, root)
  spec$natural_log_outcome_names <- spec$physiological_outcome_names[
    spec$outcome_transforms_csv$transformation_in_models == "Natural log"]
  spec}

# Planned H1 (green vs urban) and H3 (walk vs bike) contrasts; Beta = Comparison - Reference, reference level BikeU.
paper3_h1_h3_planned_contrast_tables <- function() {
  h1 <- data.frame(
    Hypothesis = "H1",
    Sub_Hypothesis = c("H1.1", "H1.2"),
    Reference_PhaseID = c("BikeU", "WalkU"),
    Comparison_PhaseID = c("BikeG", "WalkG"),
    stringsAsFactors = FALSE)
  h3 <- data.frame(
    Hypothesis = "H3",
    Sub_Hypothesis = c("H3.1", "H3.2"),
    Reference_PhaseID = c("BikeU", "BikeG"),
    Comparison_PhaseID = c("WalkU", "WalkG"),
    stringsAsFactors = FALSE)
  h1$Contrast <- paste(h1$Reference_PhaseID, h1$Comparison_PhaseID, sep = "_")
  h3$Contrast <- paste(h3$Reference_PhaseID, h3$Comparison_PhaseID, sep = "_")
  list(h1 = h1, h3 = h3)}

# Sum-to-zero phase columns; BikeU is minus the sum of the other three.
paper3_phase_sum_design <- function(phase) {
  phase <- factor(as.character(phase), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  if (anyNA(phase)) stop("Unknown or missing PhaseID")
  design <- stats::model.matrix(~ phase, contrasts.arg = list(phase = stats::contr.sum(4L)))[, -1L, drop = FALSE]
  colnames(design) <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
  design}

# End-of-phase questionnaire columns for H2 / H1 questionnaire contrasts and Analysis Eq8 (no STAI-6 or env-comfort roll-up means).
paper3_psych_questionnaire_outcomes <- function() {
  c(
    "questionnaire_current_comfort_1_7",
    "questionnaire_space_familiarity_1_5",
    "questionnaire_pleasantness_1_5",
    "questionnaire_thermal_comfort_1_5",
    "questionnaire_acoustic_comfort_1_5",
    "questionnaire_visual_comfort_1_5",
    "questionnaire_air_quality_comfort_1_5",
    "questionnaire_odor_comfort_1_5",
    "questionnaire_stai_calm_rev_1_5",
    "questionnaire_stai_tense_1_5",
    "questionnaire_stai_upset_1_5",
    "questionnaire_stai_relaxed_rev_1_5",
    "questionnaire_stai_content_rev_1_5",
    "questionnaire_stai_worried_1_5",
    "questionnaire_prs11_fascination_mean_1_5",
    "questionnaire_prs11_being_away_mean_1_5",
    "questionnaire_prs11_coherence_mean_1_5",
    "questionnaire_prs11_scope_mean_1_5"
  )}

# Cohort, phases and the 26 physiological outcomes for both Analysis_combined entry scripts.
paper3_combined_study_spec <- function(root = resolve_project_root()) {
  spec <- list(
    participants = PAPER3_PARTICIPANTS,
    phases = c("BikeU", "BikeG", "WalkU", "WalkG"),
    physiological_outcome_names = paper3_physiological_outcomes())
  paper3_attach_outcome_normalization(spec, root)}

mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)

# Row mean of a left/right sensor pair; NA when either column is absent or both readings are missing.
paper3_pair_mean <- function(data, left, right) {
  if (!all(c(left, right) %in% names(data))) return(rep(NA_real_, nrow(data)))
  z <- rowMeans(cbind(as.numeric(data[[left]]), as.numeric(data[[right]])), na.rm = TRUE)
  z[is.nan(z)] <- NA_real_
  z}

paper3_add_pair_means <- function(data, pair_map) {
  for (nm in names(pair_map)) data[[nm]] <- paper3_pair_mean(data, pair_map[[nm]][1L], pair_map[[nm]][2L])
  data}

# Participant-specific common duration across the four phases, capped at cap_sec; route needs time_in_phase_sec.
paper3_merge_common_cap <- function(route, phases, cap_sec) {
  durations <- aggregate(time_in_phase_sec ~ ParticipantID + PhaseID, route, max, na.rm = TRUE)
  phase_durations_wide <- reshape(durations, idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
  names(phase_durations_wide) <- sub("time_in_phase_sec\\.", "", names(phase_durations_wide))
  for (nm in phases) if (!nm %in% names(phase_durations_wide)) phase_durations_wide[[nm]] <- NA_real_
  phase_durations_wide$Common_cap <- pmin(
    phase_durations_wide$BikeU, phase_durations_wide$BikeG,
    phase_durations_wide$WalkU, phase_durations_wide$WalkG,
    cap_sec, na.rm = FALSE)
  merge(route, phase_durations_wide[c("ParticipantID", "Common_cap")], by = "ParticipantID", all.x = TRUE, sort = FALSE)}

# Exact two-sided sign-flip test on the mean; t-interval on the values.
paper3_signflip_mean <- function(values, min_n = 6L) {
  local_values <- values[is.finite(values)]; n <- length(local_values)
  if (n < min_n || sd(local_values) < 1e-12) return(list(N = n, estimate = NA_real_, ci_low = NA_real_, ci_high = NA_real_, p = NA_real_))
  p <- 0
  for (key in 0:(2^n - 1L)) {
    signs <- 2 * as.integer(intToBits(key))[seq_len(n)] - 1
    p <- p + (abs(mean(local_values * signs)) >= abs(mean(local_values)) - 1e-12)}
  half_width <- qt(.975, n - 1L) * sd(local_values) / sqrt(n)
  list(N = n, estimate = mean(local_values), ci_low = mean(local_values) - half_width, ci_high = mean(local_values) + half_width, p = p / (2^n))}

# Output naming layer: renames columns, checks BH families and writes the compact public tables; never changes results.

P3_DERIVED <- c("statistic_type", "estimate_type", "correlation_type", "confidence_level",
                "adjustment_method", "adjustment_family", "adjustment_family_size")
P3_P_COLUMNS <- c("p", "p_value", "q", "q_FDR", "q_BH", "p_value_FDR", "fdr_q", "p_value_adjusted",
                  "q_value", "SignFlip_p", "p_value_60s", "n_p_lt_05", "n_significant_unadjusted")

P3_MAP <- c(
  Beta = "estimate", SE = "std_error", se = "std_error", Beta_60s = "estimate_60s", SE_60s = "std_error_60s",
  p = "p_value", q = "p_value_adjusted", q_FDR = "p_value_adjusted", q_BH = "p_value_adjusted",
  fdr_q = "p_value_adjusted", p_value_FDR = "p_value_adjusted", q_equation = "p_value_adjusted_equation",
  SignFlip_p = "p_value_signflip", SignFlip_q = "p_value_adjusted_signflip", q_FDR_60s = "p_value_adjusted_60s",
  Beta_CI95_low = "ci_lower", Beta_CI95_high = "ci_upper", ci_low = "ci_lower", ci_high = "ci_upper",
  Beta_CI95_60s_low = "ci_lower_60s", Beta_CI95_60s_high = "ci_upper_60s",
  SMD_paired_Bonett = "smd", SMD_CI95_low = "smd_ci_lower", SMD_CI95_high = "smd_ci_upper",
  t_ratio = "statistic", t_stat = "statistic", t_or_z = "statistic",
  r_rmcorr = "correlation", r_rm = "correlation", Partial_r_Within = "correlation", rho = "correlation",
  CI95_low = "correlation_ci_lower", CI95_high = "correlation_ci_upper",
  N_Participants = "n_participants", N_participants = "n_participants", participants = "n_participants",
  N_Complete_Pairs = "n_pairs", N_PhaseBouts = "n_observations", n_phase_bouts = "n_observations",
  N_epochs = "n_observations", n_epochs = "n_observations", n = "n_observations",
  N_epochs_60s = "n_observations_60s", n_epochs_60s = "n_observations_60s",
  Family_Size = "adjustment_family_size", FDR_scope = "adjustment_family",
  FDR_significant = "significant_adjusted", fdr_significant = "significant_adjusted",
  survives_FDR_q05 = "significant_adjusted", FDR_equation_significant = "significant_adjusted_equation",
  FDR_significant_60s = "significant_adjusted_60s", sig_p05 = "significant_unadjusted",
  significant_raw_p05 = "significant_unadjusted", reportable_sig_p05 = "reportable_significant_unadjusted",
  reportable_FDR_q05 = "reportable_significant_adjusted", significant_p = "significant_unadjusted_outcomes",
  surviving_FDR = "significant_adjusted_outcomes", n_p_lt_05 = "n_significant_unadjusted",
  n_q_lt_05 = "n_significant_adjusted", n_raw_p_lt_alpha = "n_significant_unadjusted",
  n_fdr_significant = "n_significant_adjusted",
  n_fdr_significant_primary_panel = "n_significant_adjusted_primary_panel",
  exploratory_fdr_family = "adjustment_family", fdr_group_columns = "adjustment_family_columns",
  Model = "model_formula", model = "model_id", equation_id = "model_id", equation = "model_label",
  heat_form = "model_label", Term = "term", Outcome = "outcome", PhaseID = "phase_id", phase = "phase_id",
  ParticipantID = "participant_id", Contrast = "contrast", Date = "date", Datetime = "datetime",
  AR1_phi = "ar1_rho", ar1_phi = "ar1_rho", ar1 = "ar1_rho", AR1_phi_60s = "ar1_rho_60s", ar1_phi_60s = "ar1_rho_60s",
  Clean_Outcome = "outcome_label", clean_outcome = "outcome_label", sound_test = "test",
  Status = "fit_status", status = "fit_status",
  Questionnaire = "outcome", questionnaire = "outcome", Questionnaire_Label = "outcome_label",
  questionnaire_label = "outcome_label", Physio = "term", physio = "term", Physio_Label = "term_label",
  physio_label = "term_label", Physio_Units = "term_units", physio_units = "term_units",
  Physio_Meaning = "term_meaning", physio_meaning = "term_meaning", Psych = "outcome", psych = "outcome",
  Psychological_Measure = "outcome", psychological_measure = "outcome",
  Physiological_Measure = "term", physiological_measure = "term",
  Reference_PhaseID = "reference_phase_id", Comparison_PhaseID = "comparison_phase_id",
  Metric = "field", Value = "value")

p3_snake <- function(x) {
  x <- gsub("([a-z0-9])([A-Z])", "\\1_\\2", x)
  x <- gsub("[^A-Za-z0-9]+", "_", x)
  tolower(gsub("^_|_$", "", gsub("_+", "_", x)))}
p3_nb <- function(values) !is.na(values) & nzchar(values)
p3_num <- function(values) suppressWarnings(as.numeric(values))
p3_read <- function(path) utils::read.csv(path, colClasses = "character", check.names = FALSE,
                                          na.strings = c("", "NA", "NaN"))
p3_write <- function(output_table, path) {
  output_table[] <- lapply(output_table, as.character)
  if (file.exists(path)) {
    old <- p3_read(path)
    if (identical(names(old), names(output_table)) && nrow(old) == nrow(output_table) &&
        identical(unname(as.list(old)), unname(as.list(output_table)))) return(invisible(FALSE))}
  utils::write.csv(output_table, path, row.names = FALSE, na = "")
  invisible(TRUE)}
p3_col <- function(input_table, column_name) if (column_name %in% names(input_table)) input_table[[column_name]] else rep(NA_character_, nrow(input_table))

# 1. Column names
p3_target_names <- function(input_table, file) {
  old <- names(input_table)
  new <- vapply(old, function(z) if (z %in% names(P3_MAP)) unname(P3_MAP[[z]]) else p3_snake(z), "")
  if (any(c("Psych", "psych") %in% old)) {                 # H2: response = questionnaire, predictor = physiology
    new[old %in% c("Outcome", "outcome")] <- "term"
    new[old %in% c("Units", "units")] <- "term_units"
  } else if (grepl("Contrasts", file)) new[old %in% c("Units", "units")] <- "outcome_units"
  if ("N" %in% old) new[old == "N"] <- "n_participants"
  if ("model_id" %in% old && any(grepl("lm\\(", input_table$model_id))) new[old == "model_id"] <- "model_formula"
  unname(new)}

p3_rename <- function(input_table, file) {
  new <- p3_target_names(input_table, file)
  out <- list()
  for (index in seq_along(input_table)) {
    column_name <- new[index]; incoming_values <- input_table[[index]]
    if (is.null(out[[column_name]])) { out[[column_name]] <- incoming_values; next }
    existing_values <- out[[column_name]]; clash <- p3_nb(existing_values) & p3_nb(incoming_values) & existing_values != incoming_values
    if (any(clash)) stop("Conflicting values while merging '", names(input_table)[index], "' into '", column_name, "' in ", file, call. = FALSE)
    existing_values[!p3_nb(existing_values) & p3_nb(incoming_values)] <- incoming_values[!p3_nb(existing_values) & p3_nb(incoming_values)]
    out[[column_name]] <- existing_values}
  as.data.frame(out, stringsAsFactors = FALSE, check.names = FALSE)}

# 2. BH families (worked out from the table)
p3_family <- function(results, file) {
  n <- nrow(results); col <- function(name) p3_col(results, name)
  q <- p3_num(col("p_value_adjusted")); has <- is.finite(q)
  count_tests <- function(key, included = rep(TRUE, n)) as.integer(ave(as.numeric(included), key, FUN = sum))
  count_distinct <- function(key, included) as.integer(ave(seq_len(n), key, FUN = function(index) length(unique(included[index]))))
  finite_p <- is.finite(p3_num(col("p_value")))
  res <- NULL
  if (grepl("Heat_Noise_Exposures|_hypothesis\\.csv$", file)) {
    mid <- if ("model_id" %in% names(results)) col("model_id") else col("model_label")
    key <- paste(mid, col("term")); size <- count_distinct(key, col("outcome"))
    res <- list(key = key, size = size, forced = TRUE, text = sprintf(
      "BH within model x term across the %d planned outcomes; p_value_adjusted_equation: BH within model across all non-intercept terms x outcomes", size))

  } else if (grepl("phase_contrasts\\.csv$", file)) {
    mid <- if ("model_id" %in% names(results)) col("model_id") else col("model_label")
    key <- paste(mid, col("contrast")); size <- count_distinct(key, col("outcome"))
    eq <- count_distinct(mid, col("contrast")) * count_distinct(mid, col("outcome"))
    res <- list(key = key, size = size, forced = TRUE, text = sprintf(
      "BH within model x contrast across the %d planned outcomes; p_value_adjusted_equation: BH within model across %d contrast x outcome tests", size, eq))

  } else if (grepl("H1_H3_Contrasts\\.csv$", file)) {
    key <- paste(col("outcome_type"), col("hypothesis"), col("normalization"), col("contrast"))
    size <- as.integer(col("adjustment_family_size"))
    res <- list(key = key, size = size, forced = TRUE, text = sprintf(
      "BH within outcome_type x hypothesis x normalization x contrast across %d planned outcomes; p_value_adjusted_signflip: same family", size))
  } else if (grepl("Temporal_AR1", file)) {
    key <- paste(col("hypothesis"), col("analysis"), col("analysis_entry"), col("term"))
    size <- as.integer(col("adjustment_family_size"))
    res <- list(key = key, size = size, forced = TRUE, text = sprintf(
      "BH within term across %d sensor outcomes (10 s AR(1) model); p_value_adjusted_60s: same family for the 60 s model", size))
  } else if (grepl("Planned_Contrasts_10s", file)) {
    key <- paste(col("table"), col("hypothesis"), col("effect")); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE,
      text = sprintf("BH within hypothesis x effect across %d contrast x outcome tests (both contrasts of the hypothesis pooled)", size))
  } else if (grepl("H2_Concordance\\.csv$", file)) {
    key <- col("test"); sp <- grepl("spearman", key, ignore.case = TRUE)
    size <- ifelse(sp, count_tests(key), count_tests(key, finite_p))
    res <- list(key = key, size = size, forced = sp, text = ifelse(sp,
      sprintf("BH across the %d planned restoration (delta PRS) Spearman tests", size),
      sprintf("BH across all %d questionnaire x physiological rmcorr tests", size)))
  } else if (grepl("H4_sound_literature_tests\\.csv$", file)) {
    key <- paste(col("paper"), col("test")); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf("BH within paper x test across its %d outcome tests", size))
  } else if (grepl("H5_stress_composite_(phaseavg|timeseries)_coupling_env_physio", file)) {
    key <- col("analysis_family"); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE,
      text = sprintf("BH within %s across prespecified env-to-physio coupling tests", key))
  } else if (grepl("H5_stress_composite_(phaseavg|timeseries)_coupling_psych_physio", file)) {
    key <- col("analysis_family"); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE,
      text = sprintf("BH within %s across prespecified psych-to-physio tests (env-adjusted)", key))
  } else if (grepl("H5_literature_(johnson|rodrigues|vandoren)", file)) {
    key <- col("analysis_family"); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE,
      text = sprintf("BH within %s (literature-style sensitivity; one family per source x test type)", key))
  } else if (grepl("Analysis_combined_timeseries_supplementary_blocks", file)) {
    key <- col("table"); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf("BH within supplementary block (%s) across its %d tests", key, size))}
  if (is.null(res)) return(NULL)
  res$forced <- rep_len(res$forced, n); res$text <- rep_len(res$text, n); res$has <- has
  res}

p3_check_family <- function(results, family, file) {
  p <- p3_num(results$p_value); q <- p3_num(results$p_value_adjusted); bad <- 0L
  for (family_key in unique(family$key[family$has])) {
    family_rows <- which(family$key == family_key & is.finite(p)); if (!length(family_rows)) next
    family_size <- if (family$forced[family_rows[1]]) max(family$size[family_rows[1]], length(family_rows)) else length(family_rows)
    expected_q <- stats::p.adjust(p[family_rows], "BH", n = family_size); available_q <- is.finite(q[family_rows])
    bad <- bad + sum(abs(expected_q[available_q] - q[family_rows][available_q]) > 1e-9 * pmax(1e-12, q[family_rows][available_q]))}
  if (bad) stop("VALIDATION FAILED: ", bad, " adjusted p values in ", file, " do not match the documented BH family; finalization stopped", call. = FALSE)
  invisible(bad)}

# 3. Per-table presentation
p3_finalize_table <- function(results, file) {
  col <- function(local_key) p3_col(results, local_key)
  if (grepl("H4_sound_literature_tests\\.csv$", file) && "test" %in% names(results)) {      # omnibus ANOVA rows: F belongs in statistic
    if (!"statistic" %in% names(results)) results$statistic <- NA_character_
    selected_rows <- grepl("ANOVA", results$test, ignore.case = TRUE) & p3_nb(results$estimate) & !p3_nb(results$statistic)
    results$statistic[selected_rows] <- results$estimate[selected_rows]; results$estimate[selected_rows] <- NA_character_
    column_order <- setdiff(names(results), "statistic"); estimate_position <- match("estimate", column_order)
    results <- results[c(column_order[seq_len(estimate_position)], "statistic", column_order[-seq_len(estimate_position)])]}
  flags <- grep("^(significant|reportable_significant)", names(results), value = TRUE)
  flags <- flags[!grepl("_outcomes$", flags)]
  for (local_key in flags) {
    values <- trimws(results[[local_key]]); up <- toupper(values)
    bad <- p3_nb(values) & !up %in% c("TRUE", "FALSE")
    if (any(bad)) {
      if (!"inference_status" %in% names(results)) results$inference_status <- NA_character_
      fill <- bad & !p3_nb(results$inference_status); results$inference_status[fill] <- values[fill]; values[bad] <- NA}
    values[toupper(values) %in% c("TRUE", "FALSE")] <- toupper(values[toupper(values) %in% c("TRUE", "FALSE")])
    results[[local_key]] <- values}
  for (pair in list(c("p_value_adjusted", "significant_adjusted"), c("p_value_adjusted_60s", "significant_adjusted_60s"))) {
    if (!pair[1] %in% names(results)) next
    if (!pair[2] %in% names(results)) results[[pair[2]]] <- NA_character_
    qv <- p3_num(results[[pair[1]]]); selected_rows <- is.finite(qv) & !p3_nb(results[[pair[2]]])
    results[[pair[2]]][selected_rows] <- ifelse(qv[selected_rows] < 0.05, "TRUE", "FALSE")
    results[[pair[2]]][!is.finite(qv)] <- NA_character_}
  tag <- paste(col("test"), col("table"))
  if ("estimate" %in% names(results)) {
    has <- p3_nb(col("estimate")) | p3_nb(col("estimate_60s"))
    results$estimate_type <- ifelse(!has, NA, ifelse(p3_nb(col("contrast")) & !grepl("Concordance|rmcorr", tag), "contrast",
                              ifelse(grepl("paired t", col("test")), "mean_difference", "regression_coefficient")))}
  if ("statistic" %in% names(results)) {
    st <- ifelse(p3_nb(results$statistic), "t", NA)
    st[p3_nb(results$statistic) & grepl("ANOVA", col("test"), ignore.case = TRUE)] <- "F"
    results$statistic_type <- st}
  if ("correlation" %in% names(results))
    results$correlation_type <- ifelse(!p3_nb(results$correlation), NA,
                                 ifelse(grepl("spearman", tag, ignore.case = TRUE), "spearman_rho", "repeated_measures_correlation"))
  ci <- intersect(c("ci_lower", "ci_upper", "smd_ci_lower", "smd_ci_upper", "correlation_ci_lower",
                    "correlation_ci_upper", "ci_lower_60s", "ci_upper_60s"), names(results))
  if (length(ci)) results$confidence_level <- ifelse(Reduce(`|`, lapply(ci, function(local_key) p3_nb(results[[local_key]]))), "0.95", NA)
  family <- p3_family(results, file)
  if (!is.null(family)) {
    results$adjustment_method <- ifelse(family$has, "BH", NA)
    results$adjustment_family <- ifelse(family$has, family$text, NA)
    results$adjustment_family_size <- ifelse(family$has, as.character(family$size), NA)
    p3_check_family(results, family, file)
    if (grepl('Sensitivity_60s[.]csv$', file) && 'p_value_adjusted_60s' %in% names(results)) {
      secondary <- results
      secondary$p_value <- col('p_value_60s')
      secondary$p_value_adjusted <- col('p_value_adjusted_60s')
      f60 <- family
      f60$has <- is.finite(p3_num(secondary$p_value_adjusted))
      p3_check_family(secondary, f60, file)}}
  results[c(setdiff(names(results), P3_DERIVED), intersect(P3_DERIVED, names(results)))]}

# 4. Folder finalization, in place
p3_finalize_directory <- function(directory) {
  if (!dir.exists(directory)) return(invisible(NULL))
  folder <- basename(normalizePath(directory, winslash = "/"))
  for (file_name in sort(list.files(directory, pattern = "\\.csv$"))) {
    path <- file.path(directory, file_name); x <- p3_read(path)
    already_public <- identical(names(x)[1:2], c("script_name", "source_table"))
    if (already_public || (!grepl("_hypothesis\\.csv$", file_name) && !any(names(x) %in% P3_P_COLUMNS))) next
    x <- p3_rename(x, file_name)
    x <- p3_finalize_table(x, file_name)
    if ('p_value' %in% names(x)) {
      x <- p3_public_result(x, file_name)
      if (folder %in% c('H1_H3_phaseavg', 'H1_H3_timeseries'))
        x$script_name <- rep(paste0(folder, '.R'), nrow(x))}
    p3_write(x, path)}
  remaining <- list.files(directory)
  remaining <- remaining[!dir.exists(file.path(directory, remaining))]
  if (length(remaining) > 5L) stop('OUTPUT LIMIT: ', folder, ' would publish ', length(remaining),
    ' files (maximum 5). Consolidate optional outputs before finalization.', call. = FALSE)
  invisible(NULL)}

# Compact public statistical schema. Internal analysis objects keep their original names.
P3_60S_FIELDS <- c('estimate', 'std_error', 'ci_lower', 'ci_upper', 'df', 'statistic',
  'p_value', 'p_value_adjusted', 'significant_adjusted', 'n_observations', 'n_participants')

p3_public_result <- function(source_results, file) {
  n <- nrow(source_results)
  get <- function(column_name) p3_col(source_results, column_name)
  fill <- function(values, fallback) {
    selected_rows <- !p3_nb(values)
    values[selected_rows] <- fallback[selected_rows]
    values}
  join <- function(keys) {
    context_values <- rep('', n)
    for (column_name in keys) {
      z <- get(column_name)
      selected_rows <- p3_nb(z)
      context_values[selected_rows] <- paste0(context_values[selected_rows], ifelse(nzchar(context_values[selected_rows]), '; ', ''), column_name, '=', z[selected_rows])}
    context_values}
  script <- if (grepl('^Analysis_combined_phaseavg', file)) 'Analysis_combined_phaseavg.R' else
    if (grepl('^Analysis_combined_timeseries', file)) 'Analysis_combined_timeseries.R' else
    if (grepl('H4_sound_literature_tests\\.csv$', file)) 'H4_sound_literature_test.R' else ''
  # H1/H3 folders get script_name from the directory finalizer.
  public_results <- data.frame(script_name = rep(script, n), source_table = rep(file, n), stringsAsFactors = FALSE)
  public_results$model_id <- fill(get('model_id'), get('model_label'))
  public_results$context <- join(c('hypothesis', 'analysis', 'analysis_entry', 'table', 'mode', 'duration', 'outcome_type', 'block'))
  public_results$outcome <- get('outcome')
  public_results$predictor <- get('term')
  public_results$comparison <- get('contrast')
  selected_rows <- p3_nb(get('reference_phase_id')) & p3_nb(get('comparison_phase_id'))
  public_results$comparison[selected_rows] <- paste(get('comparison_phase_id')[selected_rows], '-', get('reference_phase_id')[selected_rows])
  for (column_name in c('phase_id', 'estimate', 'std_error', 'ci_lower', 'ci_upper', 'correlation',
    'correlation_ci_lower', 'correlation_ci_upper', 'smd', 'smd_ci_lower', 'smd_ci_upper', 'df', 'n_participants', 'n_observations', 'n_pairs')) {
    public_results[[column_name]] <- get(column_name)}
  public_results$test_statistic <- get('statistic')
  type <- get('statistic_type')
  type <- ifelse(type == 't', 't-test (model coefficient or contrast)', ifelse(type == 'z', 'Wald z-test', ifelse(type == 'F', 'f-test (ANOVA)', type)))
  explicit <- get('statistic_test')
  public_results$statistic_test <- fill(explicit, type)
  if (grepl('H4_sound_literature_tests\\.csv$', file)) {
    public_results$paper <- get('paper')
    public_results$context <- get('test')
    is_comparison <- grepl('paired|ANOVA', get('test'), ignore.case = TRUE)
    public_results$comparison[is_comparison] <- get('test')[is_comparison]
    public_results$predictor[!is_comparison] <- get('test')[!is_comparison]}
  if (grepl('^Analysis_combined', file) && !grepl('supplementary_blocks', file)) {
    public_results$statistic_test <- rep(if (grepl('phase_contrasts', file)) 't-test (model phase contrast)' else 't-test (model coefficient)', n)}
  if (grepl('Temporal_AR1', file)) public_results$statistic_test <- rep('t-test (mixed-model coefficient)', n)
  if ('correlation' %in% names(source_results)) {
    ctype <- get('correlation_type')
    selected_rows <- p3_nb(get('correlation'))
    public_results$statistic_test[selected_rows] <- ifelse(ctype[selected_rows] == 'spearman_rho', 'Spearman correlation test', 't-test (within-participant correlation)')}
  public_results$scale <- join(c('transformation', 'normalization', 'outcome_units', 'term_units'))
  public_results$p_value <- get('p_value')
  public_results$q_value <- get('p_value_adjusted')
  public_results$FDR_significant <- get('significant_adjusted')
  public_results$inference_note <- join(c('inference_status', 'fit_status', 'stability_flag', 'reporting_note', 'method_validation_status', 'fdr_note', 'effect_note'))
  # Planned 10 s contrasts: phase_level (difference at the mean analysed time) vs phase_slope rows must be distinguishable.
  if ('effect' %in% names(source_results)) public_results$effect_type <- get('effect')
  for (column_name in c('low_df_flag', 'boundary_variance', 'high_ar1_flag')) {
    selected_rows <- toupper(get(column_name)) == 'TRUE'
    selected_rows[is.na(selected_rows)] <- FALSE
    public_results$inference_note[selected_rows] <- paste0(public_results$inference_note[selected_rows], '; ', column_name, '=TRUE')}
  if ('reporting_eligible' %in% names(source_results)) {
    selected_rows <- toupper(get('reporting_eligible')) == 'FALSE'
    selected_rows[is.na(selected_rows)] <- FALSE
    public_results$inference_note[selected_rows] <- paste0(public_results$inference_note[selected_rows], '; reporting_eligible=FALSE')}
  if (grepl('Sensitivity_60s[.]csv$', file)) {
    # This file reports the 60-s fits.
    for (column_name in P3_60S_FIELDS) {
      public_name <- if (column_name == 'statistic') 'test_statistic' else if (column_name == 'p_value_adjusted') 'q_value' else if (column_name == 'significant_adjusted') 'FDR_significant' else column_name
      public_results[[public_name]] <- get(paste0(column_name, '_60s'))}
    public_results$context <- paste0(public_results$context, ifelse(nzchar(public_results$context), '; ', ''), 'epoch_seconds=60; role=sensitivity')
    public_results$scale <- rep('within-person z-score; coefficient scale follows the model term', n)
    public_results$inference_note <- join(c('fit_method_60s'))
    rho60 <- p3_num(get('ar1_rho_60s'))
    selected_rows <- is.finite(rho60) & rho60 > .95
    public_results$inference_note[selected_rows] <- paste0(public_results$inference_note[selected_rows], '; AR1 rho > 0.95, interpret cautiously')}
  missing_q <- !is.finite(p3_num(public_results$q_value))
  public_results$FDR_significant[missing_q] <- NA_character_
  public_results$inference_note[missing_q] <- paste0(public_results$inference_note[missing_q], '; FDR unavailable for this test')
  mandatory <- c('script_name', 'source_table', 'outcome', 'p_value', 'q_value', 'FDR_significant')
  keep <- names(public_results) %in% mandatory | vapply(public_results, function(z) any(p3_nb(z)), logical(1))
  public_results[keep]}

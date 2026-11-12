# Paper3 final output layer (presentation only; called at the end of every statistical script).
# It never changes a model, estimate, p value, adjusted p value or adjustment family. Per result folder it
#  1) renames columns to the shared vocabulary (public fields: p_value, q_value, FDR_significant, estimate, std_error,
#     ci_lower/ci_upper, test_statistic/statistic_test, correlation*, n_participants, n_observations, phase_id, ...),
#  2) documents the BH family each analysis used (adjustment_method / adjustment_family / adjustment_family_size,
#     sizes counted from the table itself) and re-checks the stored adjusted p values against that family,
#  3) merges sibling tables (fit status into the timeseries hypothesis table; H5 epoch and grid-label tables) and
#     folds manifests, run_complete and the column dictionary into one <folder>_run_info.csv
#     (section, item, field, value) whose file checksums are computed after every other file is final.
# Idempotent: a second run on finalized files rewrites nothing. Retired former-H6 files (H6_1_*, H6_2_*, H6_3_*,
# H6_README.txt) and the Step 1-4 filtration audit (input fingerprint of the timeseries run) are never touched.

P3_RETIRED_PATTERN <- "^(H6_1_|H6_2_|H6_3_|H6_README)"
P3_UNTOUCHED_PATTERN <- "Multivariate_Filtration_Results\\.csv$"
P3_DATA_TABLES <- c("H5_hotspot_day.csv", "H5_epoch_buffer_assignment.csv", "H5_corridor_grid_label_map.csv",
                    "H5_epoch_hotspot_assignment.csv", "H5_participant_phase_composites.csv", "H5_epoch_composites.csv")
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
  n_hotspot_f_tests = "n_tests",
  Model = "model_formula", model = "model_id", equation_id = "model_id", equation = "model_label",
  heat_form = "model_label", Term = "term", Outcome = "outcome", PhaseID = "phase_id", phase = "phase_id",
  ParticipantID = "participant_id", Contrast = "contrast", Date = "date", Datetime = "datetime",
  AR1_phi = "ar1_rho", ar1_phi = "ar1_rho", ar1 = "ar1_rho", AR1_phi_60s = "ar1_rho_60s", ar1_phi_60s = "ar1_rho_60s",
  Clean_Outcome = "outcome_label", clean_outcome = "outcome_label", hotspots = "n_hotspots", sound_test = "test",
  Status = "fit_status", status = "fit_status",
  Questionnaire = "outcome", questionnaire = "outcome", Questionnaire_Label = "outcome_label",
  questionnaire_label = "outcome_label", Physio = "term", physio = "term", Physio_Label = "term_label",
  physio_label = "term_label", Physio_Units = "term_units", physio_units = "term_units",
  Physio_Meaning = "term_meaning", physio_meaning = "term_meaning", Psych = "outcome", psych = "outcome",
  Psychological_Measure = "outcome", psychological_measure = "outcome",
  Physiological_Measure = "term", physiological_measure = "term",
  Reference_PhaseID = "reference_phase_id", Comparison_PhaseID = "comparison_phase_id",
  Metric = "field", Value = "value")

P3_H5_NOTE_OLD <- "raw two-sided p-values; not FDR-adjusted across hotspot levels"
P3_H5_NOTE_NEW <- "p_value: raw two-sided Wald p (z for lme4 fits, t for nlme fits); p_value_adjusted: BH within outcome x phase_id across hotspot cells"

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

# --- 1. column names -------------------------------------------------------------------------
p3_target_names <- function(input_table, file, data_table = file %in% P3_DATA_TABLES) {
  old <- names(input_table)
  new <- vapply(old, function(z) if (z %in% names(P3_MAP)) unname(P3_MAP[[z]]) else if (data_table) z else p3_snake(z), "")
  if (any(c("Psych", "psych") %in% old)) {                 # H2: response = questionnaire, predictor = physiology
    new[old %in% c("Outcome", "outcome")] <- "term"
    new[old %in% c("Units", "units")] <- "term_units"
  } else if (grepl("Contrasts", file)) new[old %in% c("Units", "units")] <- "outcome_units"
  if ("N" %in% old) new[old == "N"] <- "n_participants"
  if (data_table) new[old == "n_epochs"] <- "n_epochs"   # hotspot-day: epochs per hotspot visit, kept as is
  if ("model_id" %in% old && any(grepl("lm\\(", input_table$model_id))) new[old == "model_id"] <- "model_formula"
  unname(new)}

p3_rename <- function(input_table, file) {
  new <- p3_target_names(input_table, file)
  out <- list(); source_names <- list()
  for (index in seq_along(input_table)) {
    column_name <- new[index]; incoming_values <- input_table[[index]]
    if (is.null(out[[column_name]])) { out[[column_name]] <- incoming_values; source_names[[column_name]] <- names(input_table)[index]; next }
    existing_values <- out[[column_name]]; clash <- p3_nb(existing_values) & p3_nb(incoming_values) & existing_values != incoming_values
    if (any(clash)) stop("Conflicting values while merging '", names(input_table)[index], "' into '", column_name, "' in ", file, call. = FALSE)
    existing_values[!p3_nb(existing_values) & p3_nb(incoming_values)] <- incoming_values[!p3_nb(existing_values) & p3_nb(incoming_values)]
    out[[column_name]] <- existing_values; source_names[[column_name]] <- c(source_names[[column_name]], names(input_table)[index])}
  out <- as.data.frame(out, stringsAsFactors = FALSE, check.names = FALSE)
  dict <- do.call(rbind, lapply(names(source_names), function(column_name) data.frame(field = column_name, source_column = source_names[[column_name]], stringsAsFactors = FALSE)))
  list(data = out, dict = dict)}

# --- 2. BH families (computed from the table; text describes what the analysis code does) ------
p3_family <- function(results, file) {
  n <- nrow(results); col <- function(name) p3_col(results, name)
  q <- p3_num(col("p_value_adjusted")); has <- is.finite(q)
  count_tests <- function(key, included = rep(TRUE, n)) as.integer(ave(as.numeric(included), key, FUN = sum))
  count_distinct <- function(key, included) as.integer(ave(seq_len(n), key, FUN = function(index) length(unique(included[index]))))
  finite_p <- is.finite(p3_num(col("p_value")))
  res <- NULL
  if (grepl("Heat_Noise_Exposures|Covariates_and_Phases|_hypothesis\\.csv$", file)) {
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
  } else if (grepl("H1_H3_Contrasts\\.csv$|^H[13]_Contrasts\\.csv$", file)) {
    key <- paste(col("outcome_type"), col("hypothesis"), col("normalization"), col("contrast"))
    size <- as.integer(col("adjustment_family_size"))
    res <- list(key = key, size = size, forced = TRUE, text = sprintf(
      "BH within outcome_type x hypothesis x normalization x contrast across %d planned outcomes; p_value_adjusted_signflip: same family", size))
  } else if (grepl("Temporal_AR1", file)) {
    key <- paste(col("hypothesis"), col("analysis"), col("analysis_entry"), col("term"))
    size <- as.integer(col("adjustment_family_size"))
    res <- list(key = key, size = size, forced = TRUE, text = sprintf(
      "BH within term across %d sensor outcomes (10 s AR(1) model); p_value_adjusted_60s: same family for the 60 s model", size))
  } else if (grepl("Planned_Contrasts_and_H2", file)) {
    h2 <- grepl("Concordance", col("table")); key <- paste(col("table"), col("hypothesis"), ifelse(h2, "", col("effect")))
    size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE, text = ifelse(h2,
      sprintf("BH across all %d questionnaire x physiological rmcorr tests", size),
      sprintf("BH within hypothesis x effect across %d contrast x outcome tests (both contrasts of the hypothesis pooled)", size)))
  } else if (grepl("H2_Concordance\\.csv$", file)) {
    key <- col("test"); sp <- grepl("spearman", key, ignore.case = TRUE)
    size <- ifelse(sp, count_tests(key), count_tests(key, finite_p))
    res <- list(key = key, size = size, forced = sp, text = ifelse(sp,
      sprintf("BH across the %d planned restoration (delta PRS) Spearman tests", size),
      sprintf("BH across all %d questionnaire x physiological rmcorr tests", size)))
  } else if (grepl("^(9_FDR|H4_sound_literature_tests\\.csv$)", file)) {
    key <- paste(col("paper"), col("test")); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf("BH within paper x test across its %d outcome tests", size))
  } else if (grepl("RH1_hotspot_FDR_all_tests|RH1_hotspot_coefficients", file)) {
    key <- paste(col("outcome"), col("phase_id")); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf("BH within outcome x phase_id across the %d hotspot cell coefficients", size))
  } else if (grepl("H5_view_model_coefficients", file)) {
    key <- ifelse(has, "pooled", NA); size <- rep(sum(has), n)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf(
      "BH pooled across all %d phase_id x outcome x view-factor (SVF, TVF, BVF) exposure terms; class and covariate terms not adjusted", size))
  } else if (grepl("H5_stress_composite_(phaseavg|timeseries)_coupling_env_physio", file)) {
    key <- col("analysis_family"); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE,
      text = sprintf("BH within %s across prespecified env-to-physio coupling tests", key))
  } else if (grepl("H5_stress_composite_(phaseavg|timeseries)_coupling_psych_physio", file)) {
    key <- col("analysis_family"); size <- count_tests(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE,
      text = sprintf("BH within %s across prespecified psych-to-physio tests (env-adjusted)", key))
  } else if (grepl("H5_pairwise_rmcorr", file)) {
    key <- ifelse(has, "pooled", NA); size <- rep(sum(has), n)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf("BH across all %d fitted composite pairs", size))}
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

# --- 3. per-table presentation ---------------------------------------------------------------
p3_finalize_table <- function(results, file) {
  col <- function(local_key) p3_col(results, local_key)
  if (grepl("^(9_FDR|H4_sound_literature_tests\\.csv$)", file) && "test" %in% names(results)) {      # omnibus ANOVA rows: F belongs in statistic
    if (!"statistic" %in% names(results)) results$statistic <- NA_character_
    selected_rows <- grepl("ANOVA", results$test, ignore.case = TRUE) & p3_nb(results$estimate) & !p3_nb(results$statistic)
    results$statistic[selected_rows] <- results$estimate[selected_rows]; results$estimate[selected_rows] <- NA_character_
    column_order <- setdiff(names(results), "statistic"); estimate_position <- match("estimate", column_order)
    results <- results[c(column_order[seq_len(estimate_position)], "statistic", column_order[-seq_len(estimate_position)])]}
  if ("p_value_note" %in% names(results)) results$p_value_note[results$p_value_note %in% P3_H5_NOTE_OLD] <- P3_H5_NOTE_NEW
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
    if (grepl("RH1_hotspot", file)) {
      z <- p3_num(results$statistic); p <- p3_num(col("p_value"))
      st[is.finite(z) & is.finite(p) & abs(2 * stats::pnorm(-abs(z)) - p) <= 1e-6 * pmax(p, 1e-300)] <- "z"}
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
    if(grepl('Sensitivity_60s[.]csv$',file) && 'p_value_adjusted_60s' %in% names(results)) {
      secondary<-results;secondary$p_value<-col('p_value_60s');secondary$p_value_adjusted<-col('p_value_adjusted_60s')
      f60<-family;f60$has<-is.finite(p3_num(secondary$p_value_adjusted))
      p3_check_family(secondary,f60,file)}
  }
  results[c(setdiff(names(results), P3_DERIVED), intersect(P3_DERIVED, names(results)))]}

# --- 4. run_info -------------------------------------------------------------------------------
p3_info_rows <- function(manifest, source_file) {
  rows <- function(section, item, field, value) data.frame(section = section, item = item, field = field,
    value = ifelse(is.na(value), "", value), stringsAsFactors = FALSE)
  fld <- function(record_count) p3_target_names(as.data.frame(stats::setNames(rep(list(character()), length(record_count)), record_count), check.names = FALSE), "manifest")
  nm <- names(manifest)
  if (length(nm) == 2 && tolower(nm[1]) %in% c("field", "metric"))
    return(rows("run", "manifest", p3_snake(manifest[[1]]), manifest[[2]]))
  record_type <- intersect(c("Record_Type", "record_type"), nm)
  if (length(record_type)) {
    out <- list(); record_count <- 0L
    for (index in seq_len(nrow(manifest))) {
      keep <- setdiff(nm, record_type)
      if (identical(manifest[[record_type]][index], "Run_Manifest")) {
        item <- if ("Hypothesis" %in% nm) manifest$Hypothesis[index] else if ("hypothesis" %in% nm) manifest$hypothesis[index] else sprintf("%03d", index)
        record_values <- unlist(manifest[index, keep]); populated <- p3_nb(record_values)
        out[[length(out) + 1]] <- rows("run", paste0("manifest_", item), fld(keep[populated]), record_values[populated])
      } else {
        record_count <- record_count + 1L; record_values <- unlist(manifest[index, keep]); populated <- p3_nb(record_values)
        out[[length(out) + 1]] <- rows("model_audit", sprintf("%03d", record_count), fld(keep[populated]), record_values[populated])}
    }
    return(do.call(rbind, out))}
  if (all(c("file", "md5") %in% nm)) {
    const <- setdiff(nm[vapply(manifest, function(record_values) length(unique(record_values)) == 1L, TRUE)], c("file", "md5"))
    out <- rows("run", "run_complete", fld(const), unlist(manifest[1, const]))
    vary <- setdiff(nm, c(const, "file", "md5"))
    if (length(vary)) for (index in seq_len(nrow(manifest)))
      out <- rbind(out, rows("run_complete_file", basename(manifest$file[index]), fld(vary), unlist(manifest[index, vary])))
    return(out)}
  item <- if (grepl("FDR_summary", source_file)) "summary" else "manifest"
  section <- if (grepl("FDR_summary", source_file)) "rh1_fdr_summary" else "run"
  if (nrow(manifest) == 1L) return(rows(section, item, fld(nm), unlist(manifest[1, ])))
  do.call(rbind, lapply(seq_len(nrow(manifest)), function(index) rows(section, sprintf("%s_%03d", item, index), fld(nm), unlist(manifest[index, ]))))}

p3_merge_fit_status <- function(hypothesis_table, fit_path) {
  fit_status_table <- p3_rename(p3_read(fit_path), basename(fit_path))$data
  matched_rows <- match(paste(hypothesis_table$model_label, hypothesis_table$outcome), paste(fit_status_table$model_label, fit_status_table$outcome))
  if (anyNA(matched_rows)) stop("Fit status does not cover every hypothesis row: ", fit_path, call. = FALSE)
  fit_status_table <- fit_status_table[matched_rows, , drop = FALSE]
  if ("residual_structure" %in% names(hypothesis_table) && any(p3_nb(hypothesis_table$residual_structure) & hypothesis_table$residual_structure != fit_status_table$residual_structure, na.rm = TRUE))
    stop("residual_structure differs between hypothesis and fit status", call. = FALSE)
  md5 <- grep("_md5$", names(fit_status_table), value = TRUE)
  md5 <- md5[vapply(md5, function(model_result) length(unique(fit_status_table[[model_result]])) == 1L, TRUE)]
  add <- setdiff(names(fit_status_table), c(names(hypothesis_table), md5))
  model_position <- match("model_label", names(hypothesis_table))
  hypothesis_table <- cbind(hypothesis_table[seq_len(model_position - 1)], model_id = fit_status_table$model_id, hypothesis_table[model_position:ncol(hypothesis_table)], fit_status_table[setdiff(add, "model_id")], stringsAsFactors = FALSE)
  list(data = hypothesis_table, added = add, md5 = if (length(md5)) unlist(fit_status_table[1, md5]) else NULL)}

p3_merge_epoch <- function(ep_path, lm_path) {
  epoch_table <- p3_rename(p3_read(ep_path), "H5_epoch_buffer_assignment.csv")$data
  grid_labels <- p3_rename(p3_read(lm_path), "H5_corridor_grid_label_map.csv")$data
  matched_rows <- match(paste(epoch_table$phase_id, epoch_table$hotspot_id), paste(grid_labels$phase_id, grid_labels$hotspot_id))
  for (column_name in intersect(c("route_bin", "buffer_seg_idx"), names(grid_labels))) {
    epoch_values <- epoch_table[[column_name]]; label_values <- grid_labels[[column_name]][matched_rows]; comparable <- !is.na(matched_rows) & p3_nb(epoch_values) & p3_nb(label_values)
    if (any(p3_num(epoch_values[comparable]) != p3_num(label_values[comparable]))) stop("Epoch and grid-label tables disagree on ", column_name, call. = FALSE)}
  extra <- setdiff(names(grid_labels), names(epoch_table))
  out <- cbind(epoch_table, grid_labels[matched_rows, extra, drop = FALSE], stringsAsFactors = FALSE); rownames(out) <- NULL
  back <- unique(out[!is.na(matched_rows), names(grid_labels), drop = FALSE])
  if (nrow(back) != nrow(grid_labels)) stop("Grid-label table is not fully recoverable from the merged epoch table", call. = FALSE)
  list(data = out, extra = extra, epoch_cols = names(epoch_table))}

p3_run_info_path <- function(directory) {
  directory <- normalizePath(directory, winslash = "/", mustWork = FALSE)
  file.path(directory, paste0(basename(directory), "_run_info.csv"))}

p3_finalize_directory_staged <- function(directory, detail_dir = get0("H4_DETAIL_DIR", ifnotfound = NULL)) {
  if (!dir.exists(directory)) return(invisible(NULL))
  if (exists("h4_prune_auxiliary_results", mode = "function")) h4_prune_auxiliary_results(directory)
  folder <- basename(normalizePath(directory, winslash = "/"))
  info_path <- p3_run_info_path(directory)
  info_name <- basename(info_path)
  files <- sort(list.files(directory, pattern = "\\.csv$"))
  files <- files[!grepl(P3_RETIRED_PATTERN, files) & !grepl(P3_UNTOUCHED_PATTERN, files) & files != info_name]
  sections <- list(); dict <- list(); consumed <- character()
  prior_schema <- if(file.exists(info_path)) p3_read(info_path) else NULL
  row_metadata <- list()
  add_dict <- function(item, dictionary_rows, source_file) dict[[length(dict) + 1]] <<- data.frame(section = "column_dictionary",
    item = item, field = dictionary_rows$field, value = paste0(source_file, ":", dictionary_rows$source_column), stringsAsFactors = FALSE)

  info_src <- files[grepl("_run_complete\\.csv$|Run_Manifest\\.csv$|run_manifest\\.csv$|RH1_hotspot_FDR_summary\\.csv$", files)]
  for (file_name in info_src) { sections[[length(sections) + 1]] <- p3_info_rows(p3_read(file.path(directory, file_name)), file_name); consumed <- c(consumed, file_name) }
  old_dict <- NULL
  if ("OUTPUT_COLUMN_DICTIONARY.csv" %in% files) { old_dict <- p3_read(file.path(directory, "OUTPUT_COLUMN_DICTIONARY.csv")); consumed <- c(consumed, "OUTPUT_COLUMN_DICTIONARY.csv") }

  # H5: epoch assignment + grid labels -> one lossless table
  ep <- "H5_epoch_buffer_assignment.csv"; lm <- "H5_corridor_grid_label_map.csv"
  if (all(c(ep, lm) %in% files)) {
    mg <- p3_merge_epoch(file.path(directory, ep), file.path(directory, lm))
    target <- "H5_epoch_hotspot_assignment.csv"
    p3_write(mg$data, file.path(directory, target))
    add_dict(target, p3_rename(p3_read(file.path(directory, ep))[0, ], ep)$dict, ep)
    add_dict(target, subset(p3_rename(p3_read(file.path(directory, lm))[0, ], lm)$dict, field %in% mg$extra), lm)
    consumed <- c(consumed, ep, lm); files <- union(files, target)}
  fit_name <- grep("_fit_status\\.csv$", files, value = TRUE)
  fit_path <- if (length(fit_name)) file.path(directory, fit_name[1]) else if (!is.null(detail_dir)) {
    cand <- list.files(detail_dir, pattern = "_fit_status\\.csv$", full.names = TRUE); if (length(cand)) cand[1] else NULL } else NULL
  consumed <- c(consumed, fit_name)

  for (file_name in setdiff(files, consumed)) {
    path <- file.path(directory, file_name); raw <- p3_restore_public(p3_read(path), prior_schema, file_name)
    is_data <- file_name %in% P3_DATA_TABLES
    is_hyp <- grepl("_hypothesis\\.csv$", file_name)
    if (!is_data && !is_hyp && !any(names(raw) %in% P3_P_COLUMNS)) next
    rn <- p3_rename(raw, file_name); x <- rn$data
    add_dict(file_name, rn$dict, file_name)
    if (is_hyp && !is.null(fit_path) && !"converged" %in% names(x)) {
      mf <- p3_merge_fit_status(x, fit_path); x <- mf$data
      fd <- p3_rename(p3_read(fit_path)[0, ], basename(fit_path))$dict
      add_dict(file_name, subset(fd, field %in% mf$added), basename(fit_path))
      if (length(mf$md5)) sections[[length(sections) + 1]] <- data.frame(section = "run", item = "fit_status",
        field = names(mf$md5), value = unname(mf$md5), stringsAsFactors = FALSE)}
    if (!is_data) x <- p3_finalize_table(x, file_name)
    if (!is_data && 'p_value' %in% names(x)) {
      public <- p3_public_result(x, file_name)
      if(folder %in% c('H1_H3_phaseavg','H1_H3_timeseries','H5_stress_composite_phaseavg','H5_stress_composite_timeseries')) public$script_name <- rep(paste0(folder,'.R'),nrow(public))
      removed_fields <- setdiff(names(x), c(names(public),'p_value_adjusted','significant_adjusted','term','hotspot_id','n_hotspots','statistic'))
      # Store compacted model context in the existing run_info, not extra output CSVs.
      for(column_name in removed_fields) {
        column_values <- x[[column_name]]; populated_rows <- which(p3_nb(column_values))
        if(length(populated_rows)) row_metadata[[length(row_metadata)+1L]] <- data.frame(
          section='result_context', item=paste0(file_name,'::',populated_rows), field=column_name, value=column_values[populated_rows],stringsAsFactors=FALSE)}
      if(grepl('Sensitivity_60s[.]csv$',file_name)) {
        for(column_name in intersect(P3_60S_FIELDS,names(x))) {
          populated_rows<-which(p3_nb(x[[column_name]]))
          if(length(populated_rows))row_metadata[[length(row_metadata)+1L]]<-data.frame(
            section='result_context',item=paste0(file_name,'::',populated_rows),field=paste0('reference10s__',column_name),value=x[[column_name]][populated_rows],stringsAsFactors=FALSE)}
      }
      x <- public}
    p3_write(x, path)
    der <- union(intersect(P3_DERIVED, names(x)), setdiff(names(x), rn$dict$field))
    if (length(der)) dict[[length(dict) + 1]] <- data.frame(section = "column_dictionary", item = file_name, field = der,
      value = "derived", stringsAsFactors = FALSE)}

  # run_info: new sections replace old ones (section 'run' by item); dictionary keeps the full rename history
  prior <- if (file.exists(info_path)) p3_read(info_path) else NULL
  if (!is.null(prior)) prior[is.na(prior)] <- ""
  if(length(row_metadata)) sections[[length(sections)+1L]] <- do.call(rbind,row_metadata)
  new <- if (length(sections)) do.call(rbind, sections) else NULL
  keep <- prior
  if (!is.null(keep)) {
    keep <- keep[!keep$section %in% c("files", "column_dictionary"), , drop = FALSE]
    if (!is.null(new)) keep <- keep[!(keep$section %in% setdiff(unique(new$section), "run") |
                                      (keep$section == "run" & keep$item %in% new$item[new$section == "run"])), , drop = FALSE]}
  meta <- rbind(keep, new)
  dictionary_rows <- if (length(dict)) do.call(rbind, dict) else NULL
  if (!is.null(old_dict) && !is.null(dictionary_rows) && all(c("file", "original_column", "standard_column") %in% names(old_dict))) {
    src <- sub("^.*:", "", dictionary_rows$value); sfile <- sub(":.*$", "", dictionary_rows$value)
    for (index in seq_len(nrow(old_dict))) {
      other_index <- which(sfile == old_dict$file[index] & src == old_dict$standard_column[index])
      if (length(other_index)) dictionary_rows <- rbind(dictionary_rows, data.frame(section = "column_dictionary", item = dictionary_rows$item[other_index[1]], field = dictionary_rows$field[other_index[1]],
        value = paste0(old_dict$file[index], ":", old_dict$original_column[index]), stringsAsFactors = FALSE))}
  }
  if (!is.null(prior)) dictionary_rows <- rbind(dictionary_rows, prior[prior$section == "column_dictionary", , drop = FALSE])
  remaining <- setdiff(sort(list.files(directory)), c(consumed, info_name))
  remaining <- remaining[!dir.exists(file.path(directory, remaining))]
  if (!is.null(dictionary_rows) && nrow(dictionary_rows)) {
    dictionary_rows <- unique(dictionary_rows[dictionary_rows$item %in% remaining, , drop = FALSE])
    hdr <- lapply(stats::setNames(unique(dictionary_rows$item), unique(dictionary_rows$item)), function(file_name) names(utils::read.csv(file.path(directory, file_name), nrows = 1, check.names = FALSE)))
    dictionary_rows <- dictionary_rows[mapply(function(file_name, column_name) column_name %in% hdr[[file_name]], dictionary_rows$item, dictionary_rows$field), , drop = FALSE]
    ident <- dictionary_rows$value == paste0(dictionary_rows$item, ":", dictionary_rows$field)
    other <- paste(dictionary_rows$item, dictionary_rows$field) %in% paste(dictionary_rows$item, dictionary_rows$field)[!ident]
    dictionary_rows <- dictionary_rows[!(ident & other), , drop = FALSE]
    pos <- mapply(function(file_name, column_name) match(column_name, hdr[[file_name]]), dictionary_rows$item, dictionary_rows$field)
    dictionary_rows <- dictionary_rows[order(dictionary_rows$item, pos, dictionary_rows$value), , drop = FALSE]}
  # No successful finalization may publish more than five top-level files.
  published_count <- length(remaining) + 1L # includes the consolidated run_info
  if (published_count > 5L) stop('OUTPUT LIMIT: ', folder, ' would publish ', published_count,
    ' files (maximum 5). Consolidate optional outputs before finalization.', call. = FALSE)
  fl <- do.call(rbind, lapply(remaining, function(file_name) {
    file_path <- file.path(directory, file_name)
    data.frame(section = "files", item = file_name, field = c("md5", "bytes"),
               value = c(unname(tools::md5sum(file_path)), as.character(file.info(file_path)$size)), stringsAsFactors = FALSE)
  }))
  validation <- data.frame(section='validation', item='output_schema',
    field=c('bh_check','published_file_count','maximum_published_files'),
    value=c('passed_or_not_applicable',as.character(published_count),'5'),stringsAsFactors=FALSE)
  if (!is.null(meta)) meta <- meta[!(meta$section=='validation' & meta$item=='output_schema'),,drop=FALSE]
  info <- rbind(meta, dictionary_rows, fl, validation)
  info <- info[order(info$section,info$item,info$field,info$value),,drop=FALSE]; rownames(info) <- NULL
  if (!is.null(info) && nrow(info)) p3_write(info, info_path)
  gone <- consumed[file.exists(file.path(directory, consumed))]
  if (length(gone)) file.remove(file.path(directory, gone))
  invisible(info_path)}

# Validate a private copy first. Rejected validation cannot rename or delete published files.
p3_finalize_directory <- function(directory, detail_dir = get0("H4_DETAIL_DIR", ifnotfound = NULL)) {
  if (!dir.exists(directory)) return(invisible(NULL))
  directory <- normalizePath(directory, winslash = "/", mustWork = TRUE)
  workspace <- tempfile("paper3_output_transaction_")
  dir.create(workspace)
  on.exit(unlink(workspace, recursive = TRUE), add = TRUE)
  original_dir <- file.path(workspace, "original")
  staged_dir <- file.path(workspace, basename(directory))
  dir.create(original_dir); dir.create(staged_dir)
  original_files <- list.files(directory, full.names = TRUE, all.files = TRUE, no.. = TRUE)
  original_files <- original_files[!dir.exists(original_files)]
  if (length(original_files)) {
    if (!all(file.copy(original_files, original_dir, copy.date = TRUE)) ||
        !all(file.copy(original_files, staged_dir, copy.date = TRUE)))
      stop("Could not stage output transaction; published files unchanged", call. = FALSE)}
  p3_finalize_directory_staged(staged_dir, detail_dir = detail_dir)
  final_files <- list.files(staged_dir, full.names = TRUE, all.files = TRUE, no.. = TRUE)
  final_names <- basename(final_files)
  original_names <- basename(original_files)
  changed <- final_files[vapply(final_files, function(file_path) {
    target <- file.path(directory, basename(file_path))
    !file.exists(target) || !identical(unname(tools::md5sum(file_path)), unname(tools::md5sum(target)))
  }, logical(1))]
  removed <- setdiff(original_names, final_names)
  if (!length(changed) && !length(removed))
    return(invisible(file.path(directory, paste0(basename(directory), "_run_info.csv"))))
  # Roll back publication if copying/removal fails (e.g. a locked output file).
  committed <- FALSE
  on.exit({
    if (!committed) {
      added <- setdiff(final_names, original_names)
      if (length(added)) unlink(file.path(directory, added))
      restored <- if (length(original_files)) file.copy(
        file.path(original_dir, original_names), directory, overwrite = TRUE, copy.date = TRUE) else TRUE
      if (!all(restored)) warning("Output rollback incomplete: restore files from the project archive backup")}
  }, add = TRUE, after = FALSE)
  for (file_path in changed) if (!file.copy(file_path, file.path(directory, basename(file_path)), overwrite = TRUE, copy.date = TRUE))
    stop("Output publication failed; restoring original files", call. = FALSE)
  if (length(removed) && !all(file.remove(file.path(directory, removed))))
    stop("Output cleanup failed; restoring original files", call. = FALSE)
  committed <- TRUE
  invisible(file.path(directory, paste0(basename(directory), "_run_info.csv")))}

# Entry point kept for the existing calls at the end of each script.
paper3_standardize_result_directory <- function(directory) p3_finalize_directory(directory)


# Compact public statistical schema. Internal analysis objects keep their original names.
P3_60S_FIELDS <- c('estimate','std_error','ci_lower','ci_upper','df','statistic',
                  'p_value','p_value_adjusted','significant_adjusted','n_observations','n_participants')

p3_restore_public <- function(public_table, metadata, file) {
  if(!'q_value' %in% names(public_table)) return(public_table)
  mapping <- c(q_value='p_value_adjusted', FDR_significant='significant_adjusted',
    predictor='term',comparison='contrast',grid_id='hotspot_id',n_grids='n_hotspots',test_statistic='statistic')
  for(column_name in intersect(names(mapping),names(public_table))) {public_table[[mapping[[column_name]]]]<-public_table[[column_name]];public_table[[column_name]]<-NULL}
  if(grepl('^(9_FDR|H4_sound_literature_tests\\.csv$)',file)) {public_table$term<-NULL;public_table$contrast<-NULL}
  for(column_name in intersect(c('script_name','source_table','context','scale','inference_note'),names(public_table))) public_table[[column_name]]<-NULL
  # Recover source context for validation and plotting without exposing wide tables.
  if(!is.null(metadata) && all(c('section','item','field','value') %in% names(metadata))) {
    z<-metadata[metadata$section=='result_context' & startsWith(metadata$item,paste0(file,'::')),,drop=FALSE]
    promoted60<-grepl('Sensitivity_60s[.]csv$',file) && any(startsWith(z$field,'reference10s__'))
    live60<-character()
    if(promoted60) {
      for(column_name in P3_60S_FIELDS) {
        live60<-c(live60,paste0(column_name,'_60s'))
        public_table[[paste0(column_name,'_60s')]]<-if(column_name %in% names(public_table))public_table[[column_name]]else rep(NA_character_,nrow(public_table))
        public_table[[column_name]]<-NULL}
    }
    for(column_name in setdiff(unique(z$field),live60)) {
      field_metadata<-z[z$field==column_name,,drop=FALSE]
      # Use the last :: separator; filenames need no regular-expression interpretation.
      row_numbers<-as.integer(sub('^.*::','',field_metadata$item));ok<-!is.na(row_numbers)&row_numbers>=1&row_numbers<=nrow(public_table)
      if(!column_name %in% names(public_table)) public_table[[column_name]]<-rep(NA_character_,nrow(public_table))
      public_table[[column_name]][row_numbers[ok]]<-field_metadata$value[ok]}
    if(promoted60) {
      for(column_name in P3_60S_FIELDS) {
        ref<-paste0('reference10s__',column_name)
        public_table[[column_name]]<-if(ref %in% names(public_table))public_table[[ref]]else rep(NA_character_,nrow(public_table))
        public_table[[ref]]<-NULL}
    }
  }
  public_table}
p3_public_result <- function(source_results,file) {
  n<-nrow(source_results);get<-function(column_name)p3_col(source_results,column_name)
  fill<-function(first_values,second_values){selected_rows<-!p3_nb(first_values);first_values[selected_rows]<-second_values[selected_rows];first_values}
  join<-function(keys){context_values<-rep('',n);for(column_name in keys){z<-get(column_name);selected_rows<-p3_nb(z);context_values[selected_rows]<-paste0(context_values[selected_rows],ifelse(nzchar(context_values[selected_rows]),'; ',''),column_name,'=',z[selected_rows])};context_values}
  script<-if(grepl('^Analysis_combined_phaseavg',file))'Analysis_combined_phaseavg.R' else
    if(grepl('^Analysis_combined_timeseries',file))'Analysis_combined_timeseries.R' else
    if(grepl('^H5_stress_composite_timeseries',file))'H5_stress_composite_timeseries.R' else
    if(grepl('^H5_stress_composite_phaseavg',file))'H5_stress_composite_phaseavg.R' else
    if(grepl('^H5_stress_composite',file))'H5_stress_composite.R' else
    if(grepl('^(9_FDR|H4_sound_literature_tests\\.csv$)',file))'H4_sound_literature_tests.R' else ''
  # The H1/H3 filenames overlap between variants; provenance is set by the directory finalizer.
  if(!nzchar(script))script<-get0('P3_EXPORT_SCRIPT',ifnotfound='H1_H3_phaseavg.R')
  public_results<-data.frame(script_name=rep(script,n),source_table=rep(file,n),stringsAsFactors=FALSE)
  public_results$model_id<-fill(get('model_id'),get('model_label'))
  public_results$context<-join(c('hypothesis','analysis','analysis_entry','table','mode','duration','outcome_type','block'))
  public_results$outcome<-fill(get('outcome'),get('composite_y'))
  public_results$predictor<-fill(get('term'),get('composite_x'));public_results$comparison<-get('contrast')
  selected_rows<-p3_nb(get('reference_phase_id')) & p3_nb(get('comparison_phase_id'))
  public_results$comparison[selected_rows]<-paste(get('comparison_phase_id')[selected_rows],'-',get('reference_phase_id')[selected_rows])
  for(column_name in c('phase_id','hotspot_id','grid_label','estimate','std_error','ci_lower','ci_upper','correlation',
    'correlation_ci_lower','correlation_ci_upper','smd','smd_ci_lower','smd_ci_upper','df','n_participants','n_observations','n_pairs','n_hotspots'))public_results[[column_name]]<-get(column_name)
  names(public_results)[names(public_results)=='hotspot_id']<-'grid_id';names(public_results)[names(public_results)=='n_hotspots']<-'n_grids'
  public_results$test_statistic<-get('statistic')
  type<-get('statistic_type')
  type<-ifelse(type=='t','t-test (model coefficient or contrast)',ifelse(type=='z','Wald z-test',ifelse(type=='F','f-test (ANOVA)',type)))
  explicit<-get('statistic_test');public_results$statistic_test<-fill(explicit,type)
  if(grepl('^(9_FDR|H4_sound_literature_tests\\.csv$)',file)) {
    public_results$paper<-get('paper');public_results$context<-get('test')
    is_comparison<-grepl('paired|Wilcoxon|Friedman|condition|ANOVA',get('test'),ignore.case=TRUE)
    public_results$comparison[is_comparison]<-get('test')[is_comparison];public_results$predictor[!is_comparison]<-get('test')[!is_comparison]
    public_results$comparison[get('paper')=='Jo 2019']<-'Green - Urban'
    test_name<-get('test');label<-rep('',n)
    label[grepl('paired one-sided',test_name)]<-'one-sided paired t-test'
    label[grepl('paired t Hot',test_name)]<-'two-sided paired t-test'
    label[grepl('Wilcoxon',test_name)]<-'Wilcoxon signed-rank test'
    label[grepl('Friedman',test_name)]<-'Friedman test'
    label[grepl('ANOVA',test_name)]<-'f-test (participant-blocked ANOVA)'
    label[get('paper')=='Rodrigues 2026']<-'Wald z-test'
    label[get('paper')=='Kraus 2013']<-'t-test (mixed-model coefficient)'
    # Existing exports did not retain the ANOVA/Friedman selection. Never guess it.
    label[test_name=='global 4-condition test']<-'omnibus test (selection not retained in old export)'
    public_results$statistic_test<-fill(explicit,label)}
  if(grepl('^Analysis_combined',file)) public_results$statistic_test<-rep(if(grepl('phase_contrasts',file))'t-test (model phase contrast)'else 't-test (model coefficient)',n)
  if(grepl('Temporal_AR1',file))public_results$statistic_test<-rep('t-test (mixed-model coefficient)',n)
  if(file=='H5_view_model_coefficients.csv')public_results$statistic_test<-rep('t-test (mixed-model coefficient)',n)
  if('correlation' %in% names(source_results)) {
    ctype<-get('correlation_type');selected_rows<-p3_nb(get('correlation'))
    public_results$statistic_test[selected_rows]<-ifelse(ctype[selected_rows]=='spearman_rho','Spearman correlation test','t-test (within-participant correlation)')}
  public_results$scale<-join(c('transformation','normalization','outcome_units','term_units'))
  public_results$p_value<-get('p_value');public_results$q_value<-get('p_value_adjusted')
  public_results$FDR_significant<-get('significant_adjusted')
  public_results$inference_note<-join(c('inference_status','fit_status','stability_flag','reporting_note','method_validation_status'))
  for(column_name in c('low_df_flag','boundary_variance','high_ar1_flag')) {
    selected_rows<-toupper(get(column_name))=='TRUE';selected_rows[is.na(selected_rows)]<-FALSE
    public_results$inference_note[selected_rows]<-paste0(public_results$inference_note[selected_rows],'; ',column_name,'=TRUE')}
  if('reporting_eligible' %in% names(source_results)) {
    selected_rows<-toupper(get('reporting_eligible'))=='FALSE';selected_rows[is.na(selected_rows)]<-FALSE
    public_results$inference_note[selected_rows]<-paste0(public_results$inference_note[selected_rows],'; reporting_eligible=FALSE')}
  if(file=='H5_view_model_coefficients.csv') {
    selected_rows<-get('term')=='exposure' & get('model_id') %in% c('SVF','TVF','BVF');selected_rows[is.na(selected_rows)]<-FALSE
    public_results$scale[selected_rows]<-'view-factor coefficient per 0.1 increase'
    selected_rows<-p3_nb(get('class_reference'));selected_rows[is.na(selected_rows)]<-FALSE
    public_results$inference_note[selected_rows]<-paste0(public_results$inference_note[selected_rows],'; class reference=',get('class_reference')[selected_rows])}
  if(grepl('Sensitivity_60s[.]csv$',file)) {
    # This file reports 60-s fits; 10-s reference cells remain in run_info only.
    for(column_name in P3_60S_FIELDS) public_results[[if(column_name=='statistic')'test_statistic'else if(column_name=='p_value_adjusted')'q_value'else if(column_name=='significant_adjusted')'FDR_significant'else column_name]]<-get(paste0(column_name,'_60s'))
    public_results$context<-paste0(public_results$context,ifelse(nzchar(public_results$context),'; ',''),'epoch_seconds=60; role=sensitivity')
    public_results$scale<-rep('within-person z-score; coefficient scale follows the model term',n)
    public_results$inference_note<-join(c('fit_method_60s'))
    rho60<-p3_num(get('ar1_rho_60s'));selected_rows<-is.finite(rho60)&rho60>.95
    public_results$inference_note[selected_rows]<-paste0(public_results$inference_note[selected_rows],'; AR1 rho > 0.95, interpret cautiously')}
  missing_q<-!is.finite(p3_num(public_results$q_value))
  public_results$FDR_significant[missing_q]<-NA_character_
  public_results$inference_note[missing_q]<-paste0(public_results$inference_note[missing_q],'; FDR unavailable for this test')
  mandatory<-c('script_name','source_table','outcome','p_value','q_value','FDR_significant')
  keep<-names(public_results) %in% mandatory | vapply(public_results,function(z)any(p3_nb(z)),logical(1))
  public_results[keep]}

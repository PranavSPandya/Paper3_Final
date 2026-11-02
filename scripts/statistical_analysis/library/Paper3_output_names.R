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
                    "H5_epoch_hotspot_assignment.csv", "H6_participant_phase_composites.csv", "H6_epoch_composites.csv")
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
  Metric = "field", Value = "value"
)

P3_H5_NOTE_OLD <- "raw two-sided p-values; not FDR-adjusted across hotspot levels"
P3_H5_NOTE_NEW <- "p_value: raw two-sided Wald p (z for lme4 fits, t for nlme fits); p_value_adjusted: BH within outcome x phase_id across hotspot cells"

p3_snake <- function(x) {
  x <- gsub("([a-z0-9])([A-Z])", "\\1_\\2", x)
  x <- gsub("[^A-Za-z0-9]+", "_", x)
  tolower(gsub("^_|_$", "", gsub("_+", "_", x)))
}
p3_nb <- function(v) !is.na(v) & nzchar(v)
p3_num <- function(v) suppressWarnings(as.numeric(v))
p3_read <- function(path) utils::read.csv(path, colClasses = "character", check.names = FALSE,
                                          na.strings = c("", "NA", "NaN"))
p3_write <- function(x, path) {
  x[] <- lapply(x, as.character)
  if (file.exists(path)) {
    old <- p3_read(path)
    if (identical(names(old), names(x)) && nrow(old) == nrow(x) &&
        identical(unname(as.list(old)), unname(as.list(x)))) return(invisible(FALSE))
  }
  utils::write.csv(x, path, row.names = FALSE, na = "")
  invisible(TRUE)
}
p3_col <- function(x, k) if (k %in% names(x)) x[[k]] else rep(NA_character_, nrow(x))

# --- 1. column names -------------------------------------------------------------------------
p3_target_names <- function(x, file, data_table = file %in% P3_DATA_TABLES) {
  old <- names(x)
  new <- vapply(old, function(z) if (z %in% names(P3_MAP)) unname(P3_MAP[[z]]) else if (data_table) z else p3_snake(z), "")
  if (any(c("Psych", "psych") %in% old)) {                 # H2: response = questionnaire, predictor = physiology
    new[old %in% c("Outcome", "outcome")] <- "term"
    new[old %in% c("Units", "units")] <- "term_units"
  } else if (grepl("Contrasts", file)) new[old %in% c("Units", "units")] <- "outcome_units"
  if ("N" %in% old) new[old == "N"] <- "n_participants"
  if (data_table) new[old == "n_epochs"] <- "n_epochs"   # hotspot-day: epochs per hotspot visit, kept as is
  if ("model_id" %in% old && any(grepl("lm\\(", x$model_id))) new[old == "model_id"] <- "model_formula"
  unname(new)
}

p3_rename <- function(x, file) {
  new <- p3_target_names(x, file)
  out <- list(); src <- list()
  for (i in seq_along(x)) {
    k <- new[i]; v <- x[[i]]
    if (is.null(out[[k]])) { out[[k]] <- v; src[[k]] <- names(x)[i]; next }
    a <- out[[k]]; clash <- p3_nb(a) & p3_nb(v) & a != v
    if (any(clash)) stop("Conflicting values while merging '", names(x)[i], "' into '", k, "' in ", file, call. = FALSE)
    a[!p3_nb(a) & p3_nb(v)] <- v[!p3_nb(a) & p3_nb(v)]
    out[[k]] <- a; src[[k]] <- c(src[[k]], names(x)[i])
  }
  out <- as.data.frame(out, stringsAsFactors = FALSE, check.names = FALSE)
  dict <- do.call(rbind, lapply(names(src), function(k) data.frame(field = k, source_column = src[[k]], stringsAsFactors = FALSE)))
  list(data = out, dict = dict)
}

# --- 2. BH families (computed from the table; text describes what the analysis code does) ------
p3_family <- function(x, file) {
  n <- nrow(x); col <- function(k) p3_col(x, k)
  q <- p3_num(col("p_value_adjusted")); has <- is.finite(q)
  cnt <- function(key, v = rep(TRUE, n)) as.integer(ave(as.numeric(v), key, FUN = sum))
  ndist <- function(key, v) as.integer(ave(seq_len(n), key, FUN = function(i) length(unique(v[i]))))
  finite_p <- is.finite(p3_num(col("p_value")))
  res <- NULL
  if (grepl("Heat_Noise_Exposures|_hypothesis\\.csv$", file)) {
    mid <- if ("model_id" %in% names(x)) col("model_id") else col("model_label")
    key <- paste(mid, col("term")); size <- ndist(key, col("outcome"))
    res <- list(key = key, size = size, forced = TRUE, text = sprintf(
      "BH within model x term across the %d planned outcomes; p_value_adjusted_equation: BH within model across all non-intercept terms x outcomes", size))
  } else if (grepl("phase_contrasts\\.csv$", file)) {
    mid <- if ("model_id" %in% names(x)) col("model_id") else col("model_label")
    key <- paste(mid, col("contrast")); size <- ndist(key, col("outcome"))
    eq <- ndist(mid, col("contrast")) * ndist(mid, col("outcome"))
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
    size <- cnt(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE, text = ifelse(h2,
      sprintf("BH across all %d questionnaire x physiological rmcorr tests", size),
      sprintf("BH within hypothesis x effect across %d contrast x outcome tests (both contrasts of the hypothesis pooled)", size)))
  } else if (grepl("H2_Concordance\\.csv$", file)) {
    key <- col("test"); sp <- grepl("spearman", key, ignore.case = TRUE)
    size <- ifelse(sp, cnt(key), cnt(key, finite_p))
    res <- list(key = key, size = size, forced = sp, text = ifelse(sp,
      sprintf("BH across the %d planned restoration (delta PRS) Spearman tests", size),
      sprintf("BH across all %d questionnaire x physiological rmcorr tests", size)))
  } else if (grepl("^9_FDR", file)) {
    key <- paste(col("paper"), col("test")); size <- cnt(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf("BH within paper x test across its %d outcome tests", size))
  } else if (grepl("RH1_hotspot_FDR_all_tests|RH1_hotspot_coefficients", file)) {
    key <- paste(col("outcome"), col("phase_id")); size <- cnt(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf("BH within outcome x phase_id across the %d hotspot cell coefficients", size))
  } else if (grepl("H5_view_model_coefficients", file)) {
    key <- ifelse(has, "pooled", NA); size <- rep(sum(has), n)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf(
      "BH pooled across all %d phase_id x outcome x view-factor (SVF, TVF, BVF) exposure terms; class and covariate terms not adjusted", size))
  } else if (grepl("H6_stress_composite_(phaseavg|timeseries)_coupling_env_physio", file)) {
    key <- col("analysis_family"); size <- cnt(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE,
      text = sprintf("BH within %s across prespecified env-to-physio coupling tests", key))
  } else if (grepl("H6_stress_composite_(phaseavg|timeseries)_coupling_psych_physio", file)) {
    key <- col("analysis_family"); size <- cnt(key, finite_p)
    res <- list(key = key, size = size, forced = FALSE,
      text = sprintf("BH within %s across prespecified psych-to-physio tests (env-adjusted)", key))
  } else if (grepl("H6_pairwise_rmcorr", file)) {
    key <- ifelse(has, "pooled", NA); size <- rep(sum(has), n)
    res <- list(key = key, size = size, forced = FALSE, text = sprintf("BH across all %d fitted composite pairs", size))
  }
  if (is.null(res)) return(NULL)
  res$forced <- rep_len(res$forced, n); res$text <- rep_len(res$text, n); res$has <- has
  res
}

p3_check_family <- function(x, fam, file) {
  p <- p3_num(x$p_value); q <- p3_num(x$p_value_adjusted); bad <- 0L
  for (k in unique(fam$key[fam$has])) {
    i <- which(fam$key == k & is.finite(p)); if (!length(i)) next
    nn <- if (fam$forced[i[1]]) max(fam$size[i[1]], length(i)) else length(i)
    qh <- stats::p.adjust(p[i], "BH", n = nn); j <- is.finite(q[i])
    bad <- bad + sum(abs(qh[j] - q[i][j]) > 1e-9 * pmax(1e-12, q[i][j]))
  }
  if (bad) stop("VALIDATION FAILED: ", bad, " adjusted p values in ", file, " do not match the documented BH family; finalization stopped", call. = FALSE)
  invisible(bad)
}

# --- 3. per-table presentation ---------------------------------------------------------------
p3_finalize_table <- function(x, file) {
  n <- nrow(x); col <- function(k) p3_col(x, k)
  if (grepl("^9_FDR", file) && "test" %in% names(x)) {      # omnibus ANOVA rows: F belongs in statistic
    if (!"statistic" %in% names(x)) x$statistic <- NA_character_
    i <- grepl("ANOVA", x$test, ignore.case = TRUE) & p3_nb(x$estimate) & !p3_nb(x$statistic)
    x$statistic[i] <- x$estimate[i]; x$estimate[i] <- NA_character_
    o <- setdiff(names(x), "statistic"); w <- match("estimate", o)
    x <- x[c(o[seq_len(w)], "statistic", o[-seq_len(w)])]
  }
  if ("p_value_note" %in% names(x)) x$p_value_note[x$p_value_note %in% P3_H5_NOTE_OLD] <- P3_H5_NOTE_NEW
  flags <- grep("^(significant|reportable_significant)", names(x), value = TRUE)
  flags <- flags[!grepl("_outcomes$", flags)]
  for (k in flags) {
    v <- trimws(x[[k]]); up <- toupper(v)
    bad <- p3_nb(v) & !up %in% c("TRUE", "FALSE")
    if (any(bad)) {
      if (!"inference_status" %in% names(x)) x$inference_status <- NA_character_
      fill <- bad & !p3_nb(x$inference_status); x$inference_status[fill] <- v[fill]; v[bad] <- NA
    }
    v[toupper(v) %in% c("TRUE", "FALSE")] <- toupper(v[toupper(v) %in% c("TRUE", "FALSE")])
    x[[k]] <- v
  }
  for (pair in list(c("p_value_adjusted", "significant_adjusted"), c("p_value_adjusted_60s", "significant_adjusted_60s"))) {
    if (!pair[1] %in% names(x)) next
    if (!pair[2] %in% names(x)) x[[pair[2]]] <- NA_character_
    qv <- p3_num(x[[pair[1]]]); i <- is.finite(qv) & !p3_nb(x[[pair[2]]])
    x[[pair[2]]][i] <- ifelse(qv[i] < 0.05, "TRUE", "FALSE")
    x[[pair[2]]][!is.finite(qv)] <- NA_character_
  }
  tag <- paste(col("test"), col("table"))
  if ("estimate" %in% names(x)) {
    has <- p3_nb(col("estimate")) | p3_nb(col("estimate_60s"))
    x$estimate_type <- ifelse(!has, NA, ifelse(p3_nb(col("contrast")) & !grepl("Concordance|rmcorr", tag), "contrast",
                              ifelse(grepl("paired t", col("test")), "mean_difference", "regression_coefficient")))
  }
  if ("statistic" %in% names(x)) {
    st <- ifelse(p3_nb(x$statistic), "t", NA)
    st[p3_nb(x$statistic) & grepl("ANOVA", col("test"), ignore.case = TRUE)] <- "F"
    if (grepl("RH1_hotspot", file)) {
      z <- p3_num(x$statistic); p <- p3_num(col("p_value"))
      st[is.finite(z) & is.finite(p) & abs(2 * stats::pnorm(-abs(z)) - p) <= 1e-6 * pmax(p, 1e-300)] <- "z"
    }
    x$statistic_type <- st
  }
  if ("correlation" %in% names(x))
    x$correlation_type <- ifelse(!p3_nb(x$correlation), NA,
                                 ifelse(grepl("spearman", tag, ignore.case = TRUE), "spearman_rho", "repeated_measures_correlation"))
  ci <- intersect(c("ci_lower", "ci_upper", "smd_ci_lower", "smd_ci_upper", "correlation_ci_lower",
                    "correlation_ci_upper", "ci_lower_60s", "ci_upper_60s"), names(x))
  if (length(ci)) x$confidence_level <- ifelse(Reduce(`|`, lapply(ci, function(k) p3_nb(x[[k]]))), "0.95", NA)
  fam <- p3_family(x, file)
  if (!is.null(fam)) {
    x$adjustment_method <- ifelse(fam$has, "BH", NA)
    x$adjustment_family <- ifelse(fam$has, fam$text, NA)
    x$adjustment_family_size <- ifelse(fam$has, as.character(fam$size), NA)
    p3_check_family(x, fam, file)
    if(grepl('Sensitivity_60s[.]csv$',file) && 'p_value_adjusted_60s' %in% names(x)) {
      secondary<-x;secondary$p_value<-col('p_value_60s');secondary$p_value_adjusted<-col('p_value_adjusted_60s')
      f60<-fam;f60$has<-is.finite(p3_num(secondary$p_value_adjusted))
      p3_check_family(secondary,f60,file)
    }
  }
  x[c(setdiff(names(x), P3_DERIVED), intersect(P3_DERIVED, names(x)))]
}

# --- 4. run_info -------------------------------------------------------------------------------
p3_info_rows <- function(x, source_file) {
  rows <- function(section, item, field, value) data.frame(section = section, item = item, field = field,
    value = ifelse(is.na(value), "", value), stringsAsFactors = FALSE)
  fld <- function(k) p3_target_names(as.data.frame(stats::setNames(rep(list(character()), length(k)), k), check.names = FALSE), "manifest")
  nm <- names(x)
  if (length(nm) == 2 && tolower(nm[1]) %in% c("field", "metric"))
    return(rows("run", "manifest", p3_snake(x[[1]]), x[[2]]))
  rt <- intersect(c("Record_Type", "record_type"), nm)
  if (length(rt)) {
    out <- list(); k <- 0L
    for (i in seq_len(nrow(x))) {
      keep <- setdiff(nm, rt)
      if (identical(x[[rt]][i], "Run_Manifest")) {
        item <- if ("Hypothesis" %in% nm) x$Hypothesis[i] else if ("hypothesis" %in% nm) x$hypothesis[i] else sprintf("%03d", i)
        v <- unlist(x[i, keep]); j <- p3_nb(v)
        out[[length(out) + 1]] <- rows("run", paste0("manifest_", item), fld(keep[j]), v[j])
      } else {
        k <- k + 1L; v <- unlist(x[i, keep]); j <- p3_nb(v)
        out[[length(out) + 1]] <- rows("model_audit", sprintf("%03d", k), fld(keep[j]), v[j])
      }
    }
    return(do.call(rbind, out))
  }
  if (all(c("file", "md5") %in% nm)) {
    const <- setdiff(nm[vapply(x, function(v) length(unique(v)) == 1L, TRUE)], c("file", "md5"))
    out <- rows("run", "run_complete", fld(const), unlist(x[1, const]))
    vary <- setdiff(nm, c(const, "file", "md5"))
    if (length(vary)) for (i in seq_len(nrow(x)))
      out <- rbind(out, rows("run_complete_file", basename(x$file[i]), fld(vary), unlist(x[i, vary])))
    return(out)
  }
  item <- if (grepl("FDR_summary", source_file)) "summary" else "manifest"
  section <- if (grepl("FDR_summary", source_file)) "rh1_fdr_summary" else "run"
  if (nrow(x) == 1L) return(rows(section, item, fld(nm), unlist(x[1, ])))
  do.call(rbind, lapply(seq_len(nrow(x)), function(i) rows(section, sprintf("%s_%03d", item, i), fld(nm), unlist(x[i, ]))))
}

p3_merge_fit_status <- function(h, fit_path) {
  f <- p3_rename(p3_read(fit_path), basename(fit_path))$data
  k <- match(paste(h$model_label, h$outcome), paste(f$model_label, f$outcome))
  if (anyNA(k)) stop("Fit status does not cover every hypothesis row: ", fit_path, call. = FALSE)
  f <- f[k, , drop = FALSE]
  if ("residual_structure" %in% names(h) && any(p3_nb(h$residual_structure) & h$residual_structure != f$residual_structure, na.rm = TRUE))
    stop("residual_structure differs between hypothesis and fit status", call. = FALSE)
  md5 <- grep("_md5$", names(f), value = TRUE)
  md5 <- md5[vapply(md5, function(m) length(unique(f[[m]])) == 1L, TRUE)]
  add <- setdiff(names(f), c(names(h), md5))
  w <- match("model_label", names(h))
  h <- cbind(h[seq_len(w - 1)], model_id = f$model_id, h[w:ncol(h)], f[setdiff(add, "model_id")], stringsAsFactors = FALSE)
  list(data = h, added = add, md5 = if (length(md5)) unlist(f[1, md5]) else NULL)
}

p3_merge_epoch <- function(ep_path, lm_path) {
  e <- p3_rename(p3_read(ep_path), "H5_epoch_buffer_assignment.csv")$data
  m <- p3_rename(p3_read(lm_path), "H5_corridor_grid_label_map.csv")$data
  k <- match(paste(e$phase_id, e$hotspot_id), paste(m$phase_id, m$hotspot_id))
  for (v in intersect(c("route_bin", "buffer_seg_idx"), names(m))) {
    a <- e[[v]]; b <- m[[v]][k]; i <- !is.na(k) & p3_nb(a) & p3_nb(b)
    if (any(p3_num(a[i]) != p3_num(b[i]))) stop("Epoch and grid-label tables disagree on ", v, call. = FALSE)
  }
  extra <- setdiff(names(m), names(e))
  out <- cbind(e, m[k, extra, drop = FALSE], stringsAsFactors = FALSE); rownames(out) <- NULL
  back <- unique(out[!is.na(k), names(m), drop = FALSE])
  if (nrow(back) != nrow(m)) stop("Grid-label table is not fully recoverable from the merged epoch table", call. = FALSE)
  list(data = out, extra = extra, epoch_cols = names(e))
}

p3_run_info_path <- function(directory) {
  directory <- normalizePath(directory, winslash = "/", mustWork = FALSE)
  file.path(directory, paste0(basename(directory), "_run_info.csv"))
}

p3_finalize_directory_staged <- function(directory, detail_dir = get0("H4_DETAIL_DIR", ifnotfound = NULL)) {
  if (!dir.exists(directory)) return(invisible(NULL))
  folder <- basename(normalizePath(directory, winslash = "/"))
  info_path <- p3_run_info_path(directory)
  info_name <- basename(info_path)
  files <- sort(list.files(directory, pattern = "\\.csv$"))
  files <- files[!grepl(P3_RETIRED_PATTERN, files) & !grepl(P3_UNTOUCHED_PATTERN, files) & files != info_name]
  sections <- list(); dict <- list(); consumed <- character()
  prior_schema <- if(file.exists(info_path)) p3_read(info_path) else NULL
  row_metadata <- list()
  add_dict <- function(item, d, source_file) dict[[length(dict) + 1]] <<- data.frame(section = "column_dictionary",
    item = item, field = d$field, value = paste0(source_file, ":", d$source_column), stringsAsFactors = FALSE)

  info_src <- files[grepl("_run_complete\\.csv$|Run_Manifest\\.csv$|run_manifest\\.csv$|RH1_hotspot_FDR_summary\\.csv$", files)]
  for (f in info_src) { sections[[length(sections) + 1]] <- p3_info_rows(p3_read(file.path(directory, f)), f); consumed <- c(consumed, f) }
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
    consumed <- c(consumed, ep, lm); files <- union(files, target)
  }
  fit_name <- grep("_fit_status\\.csv$", files, value = TRUE)
  fit_path <- if (length(fit_name)) file.path(directory, fit_name[1]) else if (!is.null(detail_dir)) {
    cand <- list.files(detail_dir, pattern = "_fit_status\\.csv$", full.names = TRUE); if (length(cand)) cand[1] else NULL } else NULL
  consumed <- c(consumed, fit_name)

  for (f in setdiff(files, consumed)) {
    path <- file.path(directory, f); raw <- p3_restore_public(p3_read(path), prior_schema, f)
    is_data <- f %in% P3_DATA_TABLES
    is_hyp <- grepl("_hypothesis\\.csv$", f)
    if (!is_data && !is_hyp && !any(names(raw) %in% P3_P_COLUMNS)) next
    rn <- p3_rename(raw, f); x <- rn$data
    add_dict(f, rn$dict, f)
    if (is_hyp && !is.null(fit_path) && !"converged" %in% names(x)) {
      mf <- p3_merge_fit_status(x, fit_path); x <- mf$data
      fd <- p3_rename(p3_read(fit_path)[0, ], basename(fit_path))$dict
      add_dict(f, subset(fd, field %in% mf$added), basename(fit_path))
      if (length(mf$md5)) sections[[length(sections) + 1]] <- data.frame(section = "run", item = "fit_status",
        field = names(mf$md5), value = unname(mf$md5), stringsAsFactors = FALSE)
    }
    if (!is_data) x <- p3_finalize_table(x, f)
    if (!is_data && 'p_value' %in% names(x)) {
      public <- p3_public_result(x, f)
      if(folder %in% c('H1_H3_phaseavg','H1_H3_timeseries','H6_stress_composite_phaseavg','H6_stress_composite_timeseries')) public$script_name <- rep(paste0(folder,'.R'),nrow(public))
      removed_fields <- setdiff(names(x), c(names(public),'p_value_adjusted','significant_adjusted','term','hotspot_id','n_hotspots','statistic'))
      # Store compacted model context in the existing run_info, not extra output CSVs.
      for(k in removed_fields) {
        v <- x[[k]]; ix <- which(p3_nb(v))
        if(length(ix)) row_metadata[[length(row_metadata)+1L]] <- data.frame(
          section='result_context', item=paste0(f,'::',ix), field=k, value=v[ix],stringsAsFactors=FALSE)
      }
      if(grepl('Sensitivity_60s[.]csv$',f)) {
        for(k in intersect(P3_60S_FIELDS,names(x))) {
          ix<-which(p3_nb(x[[k]]))
          if(length(ix))row_metadata[[length(row_metadata)+1L]]<-data.frame(
            section='result_context',item=paste0(f,'::',ix),field=paste0('reference10s__',k),value=x[[k]][ix],stringsAsFactors=FALSE)
        }
      }
      x <- public
    }
    p3_write(x, path)
    der <- union(intersect(P3_DERIVED, names(x)), setdiff(names(x), rn$dict$field))
    if (length(der)) dict[[length(dict) + 1]] <- data.frame(section = "column_dictionary", item = f, field = der,
      value = "derived", stringsAsFactors = FALSE)
  }

  # run_info: new sections replace old ones (section 'run' by item); dictionary keeps the full rename history
  prior <- if (file.exists(info_path)) p3_read(info_path) else NULL
  if (!is.null(prior)) prior[is.na(prior)] <- ""
  if(length(row_metadata)) sections[[length(sections)+1L]] <- do.call(rbind,row_metadata)
  new <- if (length(sections)) do.call(rbind, sections) else NULL
  keep <- prior
  if (!is.null(keep)) {
    keep <- keep[!keep$section %in% c("files", "column_dictionary"), , drop = FALSE]
    if (!is.null(new)) keep <- keep[!(keep$section %in% setdiff(unique(new$section), "run") |
                                      (keep$section == "run" & keep$item %in% new$item[new$section == "run"])), , drop = FALSE]
  }
  meta <- rbind(keep, new)
  d <- if (length(dict)) do.call(rbind, dict) else NULL
  if (!is.null(old_dict) && !is.null(d) && all(c("file", "original_column", "standard_column") %in% names(old_dict))) {
    src <- sub("^.*:", "", d$value); sfile <- sub(":.*$", "", d$value)
    for (i in seq_len(nrow(old_dict))) {
      j <- which(sfile == old_dict$file[i] & src == old_dict$standard_column[i])
      if (length(j)) d <- rbind(d, data.frame(section = "column_dictionary", item = d$item[j[1]], field = d$field[j[1]],
        value = paste0(old_dict$file[i], ":", old_dict$original_column[i]), stringsAsFactors = FALSE))
    }
  }
  if (!is.null(prior)) d <- rbind(d, prior[prior$section == "column_dictionary", , drop = FALSE])
  remaining <- setdiff(sort(list.files(directory)), c(consumed, info_name))
  remaining <- remaining[!dir.exists(file.path(directory, remaining))]
  if (!is.null(d) && nrow(d)) {
    d <- unique(d[d$item %in% remaining, , drop = FALSE])
    hdr <- lapply(stats::setNames(unique(d$item), unique(d$item)), function(f) names(utils::read.csv(file.path(directory, f), nrows = 1, check.names = FALSE)))
    d <- d[mapply(function(f, k) k %in% hdr[[f]], d$item, d$field), , drop = FALSE]
    ident <- d$value == paste0(d$item, ":", d$field)
    other <- paste(d$item, d$field) %in% paste(d$item, d$field)[!ident]
    d <- d[!(ident & other), , drop = FALSE]
    pos <- mapply(function(f, k) match(k, hdr[[f]]), d$item, d$field)
    d <- d[order(d$item, pos, d$value), , drop = FALSE]
  }
  # No successful finalization may publish more than five top-level files.
  published_count <- length(remaining) + 1L # includes the consolidated run_info
  if (published_count > 5L) stop('OUTPUT LIMIT: ', folder, ' would publish ', published_count,
    ' files (maximum 5). Consolidate optional outputs before finalization.', call. = FALSE)
  fl <- do.call(rbind, lapply(remaining, function(f) {
    p <- file.path(directory, f)
    data.frame(section = "files", item = f, field = c("md5", "bytes"),
               value = c(unname(tools::md5sum(p)), as.character(file.info(p)$size)), stringsAsFactors = FALSE)
  }))
  validation <- data.frame(section='validation', item='output_schema',
    field=c('bh_check','published_file_count','maximum_published_files'),
    value=c('passed_or_not_applicable',as.character(published_count),'5'),stringsAsFactors=FALSE)
  if (!is.null(meta)) meta <- meta[!(meta$section=='validation' & meta$item=='output_schema'),,drop=FALSE]
  info <- rbind(meta, d, fl, validation)
  info <- info[order(info$section,info$item,info$field,info$value),,drop=FALSE]; rownames(info) <- NULL
  if (!is.null(info) && nrow(info)) p3_write(info, info_path)
  gone <- consumed[file.exists(file.path(directory, consumed))]
  if (length(gone)) file.remove(file.path(directory, gone))
  invisible(info_path)
}

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
      stop("Could not stage output transaction; published files unchanged", call. = FALSE)
  }
  p3_finalize_directory_staged(staged_dir, detail_dir = detail_dir)
  final_files <- list.files(staged_dir, full.names = TRUE, all.files = TRUE, no.. = TRUE)
  final_names <- basename(final_files)
  original_names <- basename(original_files)
  changed <- final_files[vapply(final_files, function(p) {
    target <- file.path(directory, basename(p))
    !file.exists(target) || !identical(unname(tools::md5sum(p)), unname(tools::md5sum(target)))
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
      if (!all(restored)) warning("Output rollback incomplete: restore files from the project archive backup")
    }
  }, add = TRUE, after = FALSE)
  for (p in changed) if (!file.copy(p, file.path(directory, basename(p)), overwrite = TRUE, copy.date = TRUE))
    stop("Output publication failed; restoring original files", call. = FALSE)
  if (length(removed) && !all(file.remove(file.path(directory, removed))))
    stop("Output cleanup failed; restoring original files", call. = FALSE)
  committed <- TRUE
  invisible(file.path(directory, paste0(basename(directory), "_run_info.csv")))
}

# Entry point kept for the existing calls at the end of each script.
paper3_standardize_result_directory <- function(directory) p3_finalize_directory(directory)


# Compact public statistical schema. Internal analysis objects keep their original names.
P3_60S_FIELDS <- c('estimate','std_error','ci_lower','ci_upper','df','statistic',
                  'p_value','p_value_adjusted','significant_adjusted','n_observations','n_participants')

p3_restore_public <- function(x, metadata, file) {
  if(!'q_value' %in% names(x)) return(x)
  mapping <- c(q_value='p_value_adjusted', FDR_significant='significant_adjusted',
    predictor='term',comparison='contrast',grid_id='hotspot_id',n_grids='n_hotspots',test_statistic='statistic')
  for(k in intersect(names(mapping),names(x))) {x[[mapping[[k]]]]<-x[[k]];x[[k]]<-NULL}
  if(grepl('^9_FDR',file)) {x$term<-NULL;x$contrast<-NULL}
  for(k in intersect(c('script_name','source_table','context','scale','inference_note'),names(x))) x[[k]]<-NULL
  # Recover source context for validation and plotting without exposing wide tables.
  if(!is.null(metadata) && all(c('section','item','field','value') %in% names(metadata))) {
    z<-metadata[metadata$section=='result_context' & startsWith(metadata$item,paste0(file,'::')),,drop=FALSE]
    promoted60<-grepl('Sensitivity_60s[.]csv$',file) && any(startsWith(z$field,'reference10s__'))
    live60<-character()
    if(promoted60) {
      for(k in P3_60S_FIELDS) {
        live60<-c(live60,paste0(k,'_60s'))
        x[[paste0(k,'_60s')]]<-if(k %in% names(x))x[[k]]else rep(NA_character_,nrow(x))
        x[[k]]<-NULL
      }
    }
    for(k in setdiff(unique(z$field),live60)) {
      a<-z[z$field==k,,drop=FALSE]
      # Use the last :: separator; filenames need no regular-expression interpretation.
      i<-as.integer(sub('^.*::','',a$item));ok<-!is.na(i)&i>=1&i<=nrow(x)
      if(!k %in% names(x)) x[[k]]<-rep(NA_character_,nrow(x))
      x[[k]][i[ok]]<-a$value[ok]
    }
    if(promoted60) {
      for(k in P3_60S_FIELDS) {
        ref<-paste0('reference10s__',k)
        x[[k]]<-if(ref %in% names(x))x[[ref]]else rep(NA_character_,nrow(x))
        x[[ref]]<-NULL
      }
    }
  }
  x
}
p3_public_result <- function(x,file) {
  n<-nrow(x);get<-function(k)p3_col(x,k)
  fill<-function(a,b){i<-!p3_nb(a);a[i]<-b[i];a}
  join<-function(keys){v<-rep('',n);for(k in keys){z<-get(k);i<-p3_nb(z);v[i]<-paste0(v[i],ifelse(nzchar(v[i]),'; ',''),k,'=',z[i])};v}
  script<-if(grepl('^Analysis_combined_phaseavg',file))'Analysis_combined_phaseavg.R' else
    if(grepl('^Analysis_combined_timeseries',file))'Analysis_combined_timeseries.R' else
    if(grepl('^H5_',file))'H5_hotspot_weather.R' else
    if(grepl('^H6_',file))'H6_stress_composite.R' else
    if(grepl('^9_FDR',file))'H4_sound_literature_tests.R' else ''
  # The H1/H3 filenames overlap between variants; provenance is set by the directory finalizer.
  if(!nzchar(script))script<-get0('P3_EXPORT_SCRIPT',ifnotfound='H1_H3_phaseavg.R')
  y<-data.frame(script_name=rep(script,n),source_table=rep(file,n),stringsAsFactors=FALSE)
  y$model_id<-fill(get('model_id'),get('model_label'))
  y$context<-join(c('hypothesis','analysis','analysis_entry','table','mode','duration','outcome_type','block'))
  y$outcome<-fill(get('outcome'),get('composite_y'))
  y$predictor<-fill(get('term'),get('composite_x'));y$comparison<-get('contrast')
  i<-p3_nb(get('reference_phase_id')) & p3_nb(get('comparison_phase_id'))
  y$comparison[i]<-paste(get('comparison_phase_id')[i],'-',get('reference_phase_id')[i])
  for(k in c('phase_id','hotspot_id','grid_label','estimate','std_error','ci_lower','ci_upper','correlation',
    'correlation_ci_lower','correlation_ci_upper','smd','smd_ci_lower','smd_ci_upper','df','n_participants','n_observations','n_pairs','n_hotspots'))y[[k]]<-get(k)
  names(y)[names(y)=='hotspot_id']<-'grid_id';names(y)[names(y)=='n_hotspots']<-'n_grids'
  y$test_statistic<-get('statistic')
  type<-get('statistic_type')
  type<-ifelse(type=='t','t-test (model coefficient or contrast)',ifelse(type=='z','Wald z-test',ifelse(type=='F','f-test (ANOVA)',type)))
  explicit<-get('statistic_test');y$statistic_test<-fill(explicit,type)
  if(grepl('^9_FDR',file)) {
    y$paper<-get('paper');y$context<-get('test')
    cmp<-grepl('paired|Wilcoxon|Friedman|condition|ANOVA',get('test'),ignore.case=TRUE)
    y$comparison[cmp]<-get('test')[cmp];y$predictor[!cmp]<-get('test')[!cmp]
    y$comparison[get('paper')=='Jo 2019']<-'Green - Urban'
    infer<-get('test');label<-rep('',n)
    label[grepl('paired one-sided',infer)]<-'one-sided paired t-test'
    label[grepl('paired t Hot',infer)]<-'two-sided paired t-test'
    label[grepl('Wilcoxon',infer)]<-'Wilcoxon signed-rank test'
    label[grepl('Friedman',infer)]<-'Friedman test'
    label[grepl('ANOVA',infer)]<-'f-test (participant-blocked ANOVA)'
    label[get('paper')=='Rodrigues 2026']<-'Wald z-test'
    label[get('paper')=='Kraus 2013']<-'t-test (mixed-model coefficient)'
    # Existing exports did not retain the ANOVA/Friedman selection. Never guess it.
    label[infer=='global 4-condition test']<-'omnibus test (selection not retained in old export)'
    y$statistic_test<-fill(explicit,label)
  }
  if(grepl('^Analysis_combined',file)) y$statistic_test<-rep(if(grepl('phase_contrasts',file))'t-test (model phase contrast)'else 't-test (model coefficient)',n)
  if(grepl('Temporal_AR1',file))y$statistic_test<-rep('t-test (mixed-model coefficient)',n)
  if(file=='H5_view_model_coefficients.csv')y$statistic_test<-rep('t-test (mixed-model coefficient)',n)
  if('correlation' %in% names(x)) {
    ctype<-get('correlation_type');i<-p3_nb(get('correlation'))
    y$statistic_test[i]<-ifelse(ctype[i]=='spearman_rho','Spearman correlation test','t-test (within-participant correlation)')
  }
  y$scale<-join(c('transformation','normalization','outcome_units','term_units'))
  y$p_value<-get('p_value');y$q_value<-get('p_value_adjusted')
  y$FDR_significant<-get('significant_adjusted')
  y$inference_note<-join(c('inference_status','fit_status','stability_flag','reporting_note','method_validation_status'))
  for(k in c('low_df_flag','boundary_variance','high_ar1_flag')) {
    i<-toupper(get(k))=='TRUE';i[is.na(i)]<-FALSE
    y$inference_note[i]<-paste0(y$inference_note[i],'; ',k,'=TRUE')
  }
  if('reporting_eligible' %in% names(x)) {
    i<-toupper(get('reporting_eligible'))=='FALSE';i[is.na(i)]<-FALSE
    y$inference_note[i]<-paste0(y$inference_note[i],'; reporting_eligible=FALSE')
  }
  if(file=='H5_view_model_coefficients.csv') {
    i<-get('term')=='exposure' & get('model_id') %in% c('SVF','TVF','BVF');i[is.na(i)]<-FALSE
    y$scale[i]<-'view-factor coefficient per 0.1 increase'
    i<-p3_nb(get('class_reference'));i[is.na(i)]<-FALSE
    y$inference_note[i]<-paste0(y$inference_note[i],'; class reference=',get('class_reference')[i])
  }
  if(grepl('Sensitivity_60s[.]csv$',file)) {
    # This file reports 60-s fits; 10-s reference cells remain in run_info only.
    for(k in P3_60S_FIELDS) y[[if(k=='statistic')'test_statistic'else if(k=='p_value_adjusted')'q_value'else if(k=='significant_adjusted')'FDR_significant'else k]]<-get(paste0(k,'_60s'))
    y$context<-paste0(y$context,ifelse(nzchar(y$context),'; ',''),'epoch_seconds=60; role=sensitivity')
    y$scale<-rep('within-person z-score; coefficient scale follows the model term',n)
    y$inference_note<-join(c('fit_method_60s'))
    rho60<-p3_num(get('ar1_rho_60s'));i<-is.finite(rho60)&rho60>.95
    y$inference_note[i]<-paste0(y$inference_note[i],'; AR1 rho > 0.95, interpret cautiously')
  }
  missing_q<-!is.finite(p3_num(y$q_value))
  y$FDR_significant[missing_q]<-NA_character_
  y$inference_note[missing_q]<-paste0(y$inference_note[missing_q],'; FDR unavailable for this test')
  mandatory<-c('script_name','source_table','outcome','p_value','q_value','FDR_significant')
  keep<-names(y) %in% mandatory | vapply(y,function(z)any(p3_nb(z)),logical(1))
  y[keep]
}

# One-off FDR inventory scan (sound + thermal x sound)
root <- normalizePath("output/statistical_analysis/results", winslash = "/", mustWork = TRUE)

is_fdr_hit <- function(df) {
  hit <- rep(FALSE, nrow(df))
  if ("q_FDR" %in% names(df)) {
    qv <- suppressWarnings(as.numeric(df$q_FDR))
    hit <- hit | (!is.na(qv) & qv < 0.05)
  }
  if ("q" %in% names(df)) {
    qv <- suppressWarnings(as.numeric(df$q))
    hit <- hit | (!is.na(qv) & qv < 0.05)
  }
  if ("FDR_significant" %in% names(df)) {
    fs <- df$FDR_significant
    if (is.logical(fs)) {
      hit <- hit | (fs %in% TRUE)
    } else {
      hit <- hit | (toupper(as.character(fs)) %in% c("TRUE", "T", "1"))
    }
  }
  hit
}

should_scan_file <- function(f) {
  f <- gsub("\\\\", "/", f)
  if (grepl(" - Copy/", f, fixed = TRUE)) return(FALSE)
  if (grepl("H4_timeseries_sound_30s", f, fixed = TRUE)) return(FALSE)
  if (grepl("H4_sound_heat_sound_interaction_contrasts\\.csv$", f)) return(TRUE)
  if (grepl("/H4_timeseries_sound/|/H4_phaseavg_sound/", f)) {
    return(grepl(
      "H4_sound_band_contrasts\\.csv$|H4_sound_coefficients\\.csv$|H4_sound_exposure_tests\\.csv$",
      f
    ))
  }
  if (grepl("/H4_phaseavg/H4_phaseavg_coefficients\\.csv$", f)) return(TRUE)
  if (grepl("/H4_timeseries/", f) && grepl("coefficient|exposure", basename(f), ignore.case = TRUE)) {
    return(TRUE)
  }
  FALSE
}

primary_thermal_sound_row <- function(df) {
  tt <- if ("term_type" %in% names(df)) df$term_type else rep("", nrow(df))
  tm <- if ("term" %in% names(df)) df$term else rep("", nrow(df))
  grepl("thermal_x_sound", tt, ignore.case = TRUE) |
    grepl(":.*SND|ucm_UTCI:ucm_SND|UTCI.*:.*SND", tm, ignore.case = TRUE)
}

dirs <- c(
  file.path(root, "H4_timeseries_sound"),
  file.path(root, "H4_phaseavg_sound"),
  file.path(root, "H4_phaseavg"),
  file.path(root, "H4_timeseries")
)
files <- character(0)
for (d in dirs) {
  if (!dir.exists(d)) next
  files <- c(files, list.files(d, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE))
}
int_extra <- list.files(root, pattern = "H4_sound_heat_sound_interaction_contrasts\\.csv$", recursive = TRUE, full.names = TRUE)
files <- unique(c(files, int_extra))
files <- files[vapply(files, should_scan_file, logical(1L))]

message("Scanning ", length(files), " CSV files")

rows <- list()
for (f in files) {
  df <- tryCatch(
    read.csv(f, stringsAsFactors = FALSE, check.names = FALSE),
    error = function(e) NULL
  )
  if (is.null(df) || !nrow(df)) next
  if (grepl("/H4_phaseavg/H4_phaseavg_coefficients", gsub("\\\\", "/", f))) {
    df <- df[primary_thermal_sound_row(df), , drop = FALSE]
    if (!nrow(df)) next
  }
  if (grepl("/H4_timeseries/", gsub("\\\\", "/", f)) && !grepl("_sound", f)) {
    if (!"term" %in% names(df) && !"term_type" %in% names(df)) next
    df <- df[primary_thermal_sound_row(df), , drop = FALSE]
    if (!nrow(df)) next
  }
  hit <- is_fdr_hit(df)
  if (!any(hit)) next
  df <- df[hit, , drop = FALSE]
  df$file_path <- gsub("\\\\", "/", normalizePath(f, winslash = "/", mustWork = FALSE))
  rows[[length(rows) + 1L]] <- df
}

if (!length(rows)) {
  message("NO FDR HITS")
  quit(save = "no", status = 0)
}

out <- do.call(rbind, rows)
out$q_FDR_report <- if ("q_FDR" %in% names(out)) as.numeric(out$q_FDR) else NA_real_
miss <- is.na(out$q_FDR_report)
if ("q" %in% names(out)) out$q_FDR_report[miss] <- as.numeric(out$q[miss])

out$term_or_contrast <- NA_character_
if ("contrast_id" %in% names(out)) out$term_or_contrast <- as.character(out$contrast_id)
if ("term" %in% names(out)) {
  blank <- is.na(out$term_or_contrast) | out$term_or_contrast == ""
  out$term_or_contrast[blank] <- as.character(out$term[blank])
}
if ("comparison" %in% names(out)) {
  blank <- is.na(out$term_or_contrast) | out$term_or_contrast == ""
  out$term_or_contrast[blank] <- paste(out$comparison[blank], "vs", out$reference[blank])
}

out$is_thermal_x_sound <- FALSE
if ("term_type" %in% names(out)) {
  out$is_thermal_x_sound <- grepl("thermal_x_sound", out$term_type, ignore.case = TRUE)
}
if ("term" %in% names(out)) {
  out$is_thermal_x_sound <- out$is_thermal_x_sound |
    grepl(":.*SND|ucm_UTCI:ucm_SND", out$term, ignore.case = TRUE)
}

fp <- out$file_path
fp <- sub(paste0("^", gsub("([.|()\\^{}+$*?]|\\[|\\])", "\\\\\\1", root), "/?"), "", fp)
out$analysis_variant <- sub("/[^/]+$", "", fp)

out$p_report <- if ("p" %in% names(out)) as.numeric(out$p) else NA_real_
if ("p_value" %in% names(out)) {
  m <- is.na(out$p_report)
  out$p_report[m] <- as.numeric(out$p_value[m])
}

out$n_participants_report <- if ("n_participants" %in% names(out)) out$n_participants else NA
if ("n" %in% names(out)) {
  m <- is.na(out$n_participants_report)
  out$n_participants_report[m] <- out$n[m]
}

out$inference_report <- if ("inference_eligible" %in% names(out)) out$inference_eligible else NA
if ("inference_status" %in% names(out)) {
  m <- is.na(out$inference_report) | out$inference_report == ""
  out$inference_report[m] <- out$inference_status[m]
}

out$epoch_report <- if ("epoch_sec" %in% names(out)) out$epoch_sec else NA
out$stratum_report <- if ("utci_stratum" %in% names(out)) out$utci_stratum else NA
out$outcome_report <- if ("outcome" %in% names(out)) out$outcome else NA

out <- out[order(out$q_FDR_report, out$p_report, na.last = TRUE), ]

out$term_type_report <- if ("term_type" %in% names(out)) out$term_type else NA
out$sound_variable_report <- if ("sound_variable" %in% names(out)) out$sound_variable else NA

report <- data.frame(
  analysis_variant = out$analysis_variant,
  file = out$file_path,
  sound_variable = out$sound_variable_report,
  outcome = out$outcome_report,
  term_contrast = out$term_or_contrast,
  term_type = out$term_type_report,
  utci_stratum = out$stratum_report,
  epoch_sec = out$epoch_report,
  p = out$p_report,
  q_FDR = out$q_FDR_report,
  n_participants = out$n_participants_report,
  inference_eligible = out$inference_report,
  thermal_x_sound = out$is_thermal_x_sound,
  stringsAsFactors = FALSE
)

write.csv(report, file.path(root, "_fdr_scan_hits_report.csv"), row.names = FALSE)
message("TOTAL HITS: ", nrow(report))
message("thermal_x_sound FDR hits: ", sum(report$thermal_x_sound, na.rm = TRUE))
message("Hits by variant:")
print(sort(table(report$analysis_variant), decreasing = TRUE))
band_hits <- sum(grepl("band_contrasts", report$file, fixed = TRUE))
message("Stratum band contrast FDR hits: ", band_hits)
if (band_hits == 0L) message("ZERO FDR hits in H4_sound_band_contrasts.csv files.")
int_exists <- any(grepl("heat_sound_interaction", report$file))
if (!int_exists) message("H4_sound_heat_sound_interaction_contrasts.csv: NOT FOUND / no FDR hits.")

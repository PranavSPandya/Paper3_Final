# H1/H2/H3 outcome-only time series engine — data load, fit loop, I/O (no hypothesis formulas).

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H1_to_H3_time_series_core.R.", call. = FALSE)
}
for (spec_name in c("GLOBAL_SPEC", "TIME_SERIES_SPEC")) {
  if (!exists(spec_name, envir = .GlobalEnv, inherits = FALSE)) {
    stop(spec_name, " must be set before sourcing H1_to_H3_time_series_core.R.", call. = FALSE)
  }
}
stopifnot(is.character(TIME_SERIES_SPEC$hypothesis), length(TIME_SERIES_SPEC$hypothesis) == 1L)
TIME_SERIES_SPEC$hypothesis <- match.arg(TIME_SERIES_SPEC$hypothesis, c("H1", "H2", "H3"))

for (model_name in c("TimeSeries_Temporal_AR1_10s_LMM", "TimeSeries_Temporal_AR1_60s_LMM")) {
  if (!exists(model_name, envir = .GlobalEnv, inherits = FALSE)) {
    stop(model_name, " must be defined in the meeting script before sourcing this engine.", call. = FALSE)
  }
}

time_series_script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
TIME_SERIES_SCRIPT_PATH <- if (length(time_series_script_arg) && file.exists(time_series_script_arg[1])) {
  time_series_script_arg[1]
} else {
  file.path(PROJECT_ROOT, "scripts", paste0(TIME_SERIES_SPEC$hypothesis, "_time_series.R"))
}

assign("PAPER3_TIME_SERIES_ENGINE", TRUE, envir = .GlobalEnv)
source(file.path(SCRIPT_DIR, "H1_H3_core.R"), local = FALSE)

# Single shared folder for H1/H2/H3; files are prefixed with the active hypothesis (e.g. H1_Run_Manifest.csv).
OUT_DIR <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "H1_to_H3_time_series")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
time_series_output_path <- function(filename) file.path(OUT_DIR, paste0(TIME_SERIES_SPEC$hypothesis, "_", filename))

tag_hypothesis_rows <- function(result_table, hypothesis_id) {
  if (nrow(result_table) == 0) return(result_table)
  result_table$Hypothesis <- hypothesis_id
  result_table$Analysis_Entry <- paste0(hypothesis_id, "_time_series")
  result_table
}

h1_h3_time_series_dispatch_run <- function() {
  hypothesis_id <- TIME_SERIES_SPEC$hypothesis
  n_outcomes <- length(GLOBAL_SPEC$physiological_outcomes)
  cat("==============================================================================\n")
  cat(sprintf("Running %s time series: outcome-only 10 s AR(1) LMMs (engine: H1_to_H3_time_series_core.R)\n", hypothesis_id))
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(GLOBAL_SPEC$participants), paste(GLOBAL_SPEC$participants, collapse = ", ")))
  cat(sprintf("Outcomes (%d): physiological 10 s series (within-person z); no environmental predictors\n\n", n_outcomes))

  cat("[1/3] Loading matched 8-min epoch data...\n")
  route_data_bundle <- h1_h3_load_route_data()
  input_data <- route_data_bundle$df
  route_data <- route_data_bundle$route
  conditions <- route_data_bundle$CONDITIONS
  condition_name <- route_data_bundle$cname
  condition_data <- route_data_bundle$d_cond
  physiological_outcomes <- route_data_bundle$sensor_outcomes
  psychological_outcomes <- route_data_bundle$psych_outcomes
  model_audit <- list()

  cat("[2/3] Fitting 10 s / 60 s AR(1) temporal LMMs...\n")
  temporal_fit <- h1_h3_fit_temporal_ar1(route_data, conditions, physiological_outcomes, model_audit)
  temporal_table <- tag_hypothesis_rows(temporal_fit$temporal_table, hypothesis_id)
  temporal_sens_table <- tag_hypothesis_rows(temporal_fit$temporal_sens_table, hypothesis_id)
  model_audit <- temporal_fit$model_audit

  secondary_table <- NULL
  if (exists("time_series_secondary_fit", envir = .GlobalEnv, inherits = FALSE)) {
    cat("[2b/3] Running hypothesis-specific secondary fit from meeting script...\n")
    secondary_result <- get("time_series_secondary_fit", envir = .GlobalEnv)(list(
      hypothesis = hypothesis_id, input_data = input_data, condition_data = condition_data, condition_name = condition_name,
      physiological_outcomes = physiological_outcomes, psychological_outcomes = psychological_outcomes,
      model_audit = model_audit, OUT_DIR = OUT_DIR
    ))
    if (is.list(secondary_result)) {
      if (!is.null(secondary_result$model_audit)) model_audit <- secondary_result$model_audit
      secondary_table <- secondary_result$table
    }
  }

  cat("[3/3] Writing CSV outputs...\n")
  safe_write_csv(temporal_table, time_series_output_path("Temporal_TimeSeries_AR1_10s.csv"))
  safe_write_csv(temporal_sens_table, time_series_output_path("Temporal_AR1_Sensitivity_60s.csv"))
  if (!is.null(secondary_table) && nrow(secondary_table) > 0) {
    secondary_csv_name <- get0("TIME_SERIES_SECONDARY_CSV", envir = .GlobalEnv, ifnotfound = "Secondary_Fit.csv")
    safe_write_csv(secondary_table, time_series_output_path(secondary_csv_name))
  }
  model_audit_df <- safe_rbind(model_audit)
  safe_write_csv(model_audit_df, time_series_output_path("Model_Audit.csv"))

  manifest <- data.frame(
    Script = normalizePath(TIME_SERIES_SCRIPT_PATH, winslash = "/", mustWork = FALSE),
    Engine = "scripts/H1_to_H3_time_series_core.R",
    Hypothesis = hypothesis_id,
    Input_File = RAW_PATH,
    Output_Directory = OUT_DIR,
    N_Physiological_Outcomes = length(physiological_outcomes),
    N_Temporal_Rows = nrow(temporal_table),
    N_Secondary_Rows = if (is.null(secondary_table)) 0L else nrow(secondary_table),
    Completed_At = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
    stringsAsFactors = FALSE
  )
  manifest_extra <- get0("TIME_SERIES_MANIFEST_EXTRA", envir = .GlobalEnv, ifnotfound = NULL)
  if (!is.null(manifest_extra)) {
    manifest <- cbind(manifest, as.data.frame(as.list(manifest_extra), stringsAsFactors = FALSE))
  }
  write.csv(manifest, time_series_output_path("Run_Manifest.csv"), row.names = FALSE, na = "")

  cat(sprintf("\nSUCCESS: %s time series finished. Outputs: %s\n", hypothesis_id, OUT_DIR))
  invisible(list(temporal_table = temporal_table, temporal_sens_table = temporal_sens_table, secondary = secondary_table))
}

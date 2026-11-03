# Phaseavg design max VIF for Model C/D (optional gvi_50m) — HR, 44 phase cells.
file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
script_dir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg)) else "."
setwd(normalizePath(script_dir, winslash = "/", mustWork = TRUE))

run_h4_phaseavg <- function(...) invisible(NULL)
run_h4 <- function(...) invisible(NULL)
paper3_standardize_result_directory <- function(...) invisible(NULL)

source("Analysis_combined_phaseavg.R", local = FALSE)
suppressPackageStartupMessages(library(car))
H4_ANALYSIS_MODE <- "phaseavg"
source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
rm("H4_ANALYSIS_MODE", envir = .GlobalEnv)

shared_audit_dir <- file.path(H4_RESULTS_ROOT, "Analysis_combined_timeseries")
audit_path <- file.path(shared_audit_dir, "Analysis_combined_timeseries_Multivariate_Filtration_Results.csv")
raw <- h4_read_merged_analysis_data()
raw <- h4_apply_average_sources(raw)
audit <- read.csv(audit_path, check.names = FALSE)
prepared <- h4_step4_exposure_prep(audit, raw)
raw_df <- prepared$raw_df

hr_outcome <- "empatica_heart_rate"
base_with_sun <- c(
  "ucm_MRT", "ucm_SND_dBA", "ucm_SUN_Gh", "SVF",
  "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")
base_no_sun <- setdiff(base_with_sun, "ucm_SUN_Gh")
ph <- H4_PHASE_SUM_COLS

phaseavg_vif <- function(outcome, fixed, eligibility, return_per_term = FALSE) {
  data <- raw_df[, c("ParticipantID", "PhaseID", eligibility, outcome), drop = FALSE]
  data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[outcome]], outcome)
  valid <- rowSums(!is.finite(as.matrix(data[, c(eligibility, "Y")]))) == 0
  data <- data[valid, ]
  model_data <- aggregate(data[, c(eligibility, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
  model_data$ParticipantID <- factor(model_data$ParticipantID)
  for (variable in eligibility) {
    phase_mean <- model_data[[variable]]
    person_mean <- ave(phase_mean, model_data$ParticipantID, FUN = mean)
    centered <- phase_mean - person_mean
    shared_sd <- sd(centered)
    model_data[[paste0(variable, "_phase_z")]] <-
      if (is.finite(shared_sd) && shared_sd > 0) centered / shared_sd else centered
  }
  model_data[, H4_PHASE_SUM_COLS] <- h4_phase_design(model_data$PhaseID)
  design <- model.matrix(fixed, model_data)
  design <- design[, colnames(design) != "(Intercept)", drop = FALSE]
  vv <- h4_vif_per_term(design)
  out <- list(
    n_design_rows = nrow(model_data),
    max_vif_equivalent = max(vv, na.rm = TRUE),
    worst_term = names(vv)[which.max(vv)])
  if (return_per_term) out$per_term <- vv
  out
}

run_model <- function(label, eligibility, include_gvi) {
  elig <- if (include_gvi) c(eligibility, "gvi_50m") else eligibility
  z <- paste0(elig, "_phase_z")
  fixed <- as.formula(paste("Y ~", paste(c(z, ph), collapse = " + ")))
  phaseavg_vif(hr_outcome, fixed, elig, return_per_term = TRUE)
}

specs <- list(
  list(model = "C (with SUN, with GVI)", eligibility = base_with_sun, include_gvi = TRUE),
  list(model = "D (no SUN, with GVI)", eligibility = base_no_sun, include_gvi = TRUE),
  list(model = "C' (with SUN, no GVI)", eligibility = base_with_sun, include_gvi = FALSE),
  list(model = "D' (no SUN, no GVI)", eligibility = base_no_sun, include_gvi = FALSE))

results <- lapply(specs, function(s) {
  r <- run_model(s$model, s$eligibility, s$include_gvi)
  c(list(model = s$model), r)
})

out_dir <- file.path(H4_RESULTS_ROOT, "Analysis_combined_phaseavg")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

summary_df <- data.frame(
  model = vapply(results, function(r) r$model, character(1)),
  n_design_rows = vapply(results, function(r) r$n_design_rows, numeric(1)),
  max_vif_equivalent = round(vapply(results, function(r) r$max_vif_equivalent, numeric(1)), 2),
  worst_term = vapply(results, function(r) r$worst_term, character(1)),
  stringsAsFactors = FALSE)
utils::write.csv(summary_df, file.path(out_dir, "Analysis_combined_phaseavg_sun_gvi_vif_summary.csv"), row.names = FALSE)

all_terms <- Reduce(union, lapply(results, function(r) names(r$per_term)))
per_term <- data.frame(term = all_terms, stringsAsFactors = FALSE)
for (r in results) {
  col <- make.names(r$model)
  per_term[[col]] <- round(r$per_term[all_terms], 2)
}
utils::write.csv(per_term, file.path(out_dir, "Analysis_combined_phaseavg_sun_gvi_vif_per_term.csv"), row.names = FALSE)

cat("Phaseavg design VIF (outcome:", hr_outcome, ")\n\n")
print(summary_df, row.names = FALSE)
for (r in results) {
  cat("\nPer-term VIF (", r$model, "):\n", sep = "")
  print(sort(round(r$per_term, 2), decreasing = TRUE))
}

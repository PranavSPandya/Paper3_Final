# One-off: phaseavg design max VIF for custom Model A / B (HR, includes gvi_50m).
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
eligibility <- c(
  "ucm_AIR_T_mid", "ucm_SND_dBA", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_MRT",
  "SVF", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg", "gvi_50m")

phaseavg_max_vif <- function(outcome, fixed, eligibility) {
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
  list(
    n_design_rows = nrow(model_data),
    max_vif_equivalent = max(vv, na.rm = TRUE),
    worst_term = names(vv)[which.max(vv)])
}

z_all <- paste0(eligibility, "_phase_z")
z_b <- setdiff(z_all, "ucm_AIR_T_mid_phase_z")
ph <- H4_PHASE_SUM_COLS
fixed_a <- as.formula(paste("Y ~", paste(c(z_all, ph), collapse = " + ")))
fixed_b <- as.formula(paste("Y ~", paste(c(z_b, ph), collapse = " + ")))

rA <- phaseavg_max_vif(hr_outcome, fixed_a, eligibility)
rB <- phaseavg_max_vif(hr_outcome, fixed_b, eligibility)

cat("Phaseavg design VIF (outcome:", hr_outcome, "; n =", rA$n_design_rows, "cells)\n")
cat("Model A (full):     max VIF =", round(rA$max_vif_equivalent, 2), "; worst term:", rA$worst_term, "\n")
cat("Model B (no air T): max VIF =", round(rB$max_vif_equivalent, 2), "; worst term:", rB$worst_term, "\n")

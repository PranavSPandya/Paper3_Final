# Eq2-like: air micro + PM + light + GVI + PhaseSum; SVF and ucm_SUN_Gh omitted.
file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
script_dir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg)) else "."
setwd(normalizePath(script_dir, winslash = "/", mustWork = TRUE))
run_h4_phaseavg <- function(...) invisible(NULL)
run_h4 <- function(...) invisible(NULL)
paper3_standardize_result_directory <- function(...) invisible(NULL)
source("Analysis_combined_phaseavg.R", local = FALSE)
H4_ANALYSIS_MODE <- "phaseavg"
source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)

elig <- c(
  "ucm_AIR_T_mid", "ucm_SND_dBA", "ucm_AIR_RH", "ucm_WIND_AWS",
  "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")
ph <- H4_PHASE_SUM_COLS
hr <- "empatica_heart_rate"

phase_vif <- function() {
  raw <- h4_apply_average_sources(h4_read_merged_analysis_data())
  data <- raw[, c("ParticipantID", "PhaseID", elig, hr)]
  data <- data[data$PhaseID %in% h4_study_spec$phases, , drop = FALSE]
  data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[hr]], hr)
  data <- data[rowSums(!is.finite(as.matrix(data[, c(elig, "Y")]))) == 0, ]
  md <- aggregate(data[, c(elig, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
  md$PhaseID <- factor(md$PhaseID, levels = h4_study_spec$phases)
  for (v in elig) {
    pm <- md[[v]]
    cm <- pm - ave(pm, md$ParticipantID, FUN = mean)
    sdv <- sd(cm)
    md[[paste0(v, "_phase_z")]] <- if (is.finite(sdv) && sdv > 0) cm / sdv else cm
  }
  md[, ph] <- h4_phase_design(md$PhaseID)
  z <- paste0(elig, "_phase_z")
  design <- model.matrix(as.formula(paste("Y ~", paste(c(z, ph), collapse = " + "))), md)[, -1, drop = FALSE]
  vv <- h4_vif_per_term(design)
  list(n = nrow(md), vv = vv)
}

timeseries_vif <- function() {
  audit <- read.csv(file.path(H4_RESULTS_ROOT, "Analysis_combined_timeseries",
    "Analysis_combined_timeseries_Multivariate_Filtration_Results.csv"), check.names = FALSE)
  raw <- h4_apply_average_sources(h4_read_merged_analysis_data())
  prepared <- h4_step4_exposure_prep(audit, raw)
  raw_df <- prepared$raw_df
  predictors <- elig
  values <- as.matrix(raw_df[, c(predictors, hr), drop = FALSE])
  storage.mode(values) <- "double"
  ok <- rowSums(!is.finite(values)) == 0L
  z <- prepared$centered[ok, predictors, drop = FALSE]
  ph_mat <- h4_phase_design(raw_df$PhaseID[ok])
  design <- cbind(z, ph_mat)
  colnames(design) <- c(paste0(predictors, "_bout_z"), ph)
  vv <- h4_vif_per_term(design)
  list(n = sum(ok), vv = vv)
}

cat("Spec (no SVF, no ucm_SUN_Gh, no gvi_50m):\n")
cat(paste(c(elig, ph), collapse = " + "), "\n\n")
cat("=== Phase mean (HR complete) ===\n")
p <- phase_vif()
cat("n =", p$n, "max VIF =", round(max(p$vv), 2), "worst =", names(p$vv)[which.max(p$vv)], "\n")
print(round(sort(p$vv, decreasing = TRUE), 2))
cat("\n=== 10 s timeseries (HR complete) ===\n")
t <- timeseries_vif()
cat("n =", t$n, "max VIF =", round(max(t$vv), 2), "worst =", names(t$vv)[which.max(t$vv)], "\n")
print(round(sort(t$vv, decreasing = TRUE), 2))

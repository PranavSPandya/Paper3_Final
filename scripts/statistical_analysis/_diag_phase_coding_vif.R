# Same 4-phase adjustment, different contrast coding — Eq3 design VIF.
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

audit <- read.csv(file.path(H4_RESULTS_ROOT, "Analysis_combined_timeseries",
  "Analysis_combined_timeseries_Multivariate_Filtration_Results.csv"), check.names = FALSE)
raw <- h4_apply_average_sources(h4_read_merged_analysis_data())
prepared <- h4_step4_exposure_prep(audit, raw)
raw_df <- prepared$raw_df
hr <- "empatica_heart_rate"
eq3_elig <- c(
  "ucm_AIR_T_mid", "ucm_SND_dBA", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_MRT",
  "SVF", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")

data <- raw_df[, c("ParticipantID", "PhaseID", eq3_elig, hr), drop = FALSE]
data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[hr]], hr)
data <- data[rowSums(!is.finite(as.matrix(data[, c(eq3_elig, "Y")]))) == 0, ]
md <- aggregate(data[, c(eq3_elig, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
md$ParticipantID <- factor(md$ParticipantID)
for (v in eq3_elig) {
  pm <- md[[v]]
  cm <- pm - ave(pm, md$ParticipantID, FUN = mean)
  sdv <- sd(cm)
  md[[paste0(v, "_phase_z")]] <- if (is.finite(sdv) && sdv > 0) cm / sdv else cm
}

z_cols <- paste0(eq3_elig, "_phase_z")
lev <- c("WalkG", "WalkU", "BikeG", "BikeU")
phase_fac <- factor(md$PhaseID, levels = lev)

max_vif_lm <- function(phase_mat, label) {
  d <- cbind(md[, z_cols, drop = FALSE], phase_mat, Y = md$Y)
  f <- as.formula(paste("Y ~", paste(colnames(d)[colnames(d) != "Y"], collapse = " + ")))
  fit <- lm(f, data = d)
  v <- car::vif(fit)
  if (is.matrix(v)) {
    mrt <- v["ucm_MRT_phase_z", "GVIF"]
    if (is.na(mrt)) mrt <- v["ucm_MRT_phase_z", 1]
    worst <- rownames(v)[which.max(v[, "GVIF"])]
    mx <- max(v[, "GVIF"])
  } else {
    mrt <- v["ucm_MRT_phase_z"]
    worst <- names(v)[which.max(v)]
    mx <- max(v)
  }
  cbind(label = label, max_GVIF = mx, worst_term = worst, MRT_GVIF = mrt)
}

rows <- list()

# Sum-to-zero (repo default; BikeU implicit)
md[, H4_PHASE_SUM_COLS] <- h4_phase_design(md$PhaseID)
rows[[1]] <- max_vif_lm(md[, H4_PHASE_SUM_COLS, drop = FALSE],
  "Sum: PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG (BikeU implicit)")

# Treatment reference = each level omitted in turn
for (ref in lev) {
  pm <- stats::model.matrix(~ phase_fac, contrasts = list(
    phase_fac = stats::contr.treatment(length(lev), base = match(ref, lev))))[, -1L, drop = FALSE]
  rows[[length(rows) + 1L]] <- max_vif_lm(
    pm, paste0("Treatment ref ", ref, " (omit ", ref, "; columns: ",
      paste(colnames(pm), collapse = ", "), ")"))
}

out <- do.call(rbind, rows)
cat("Eq3 exposures + 3 phase contrasts, n =", nrow(md), "\n\n")
print(out, row.names = FALSE)

cat("\nNote: Any full-rank 3-column coding of 4 phases spans the SAME subspace;\n")
cat("MRT VIF should match (reparameterization only).\n")

# Diagnostic: why ucm_MRT_phase_z inflates VIF with PhaseSum* (44 HR cells).
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

build_phase_design <- function(eligibility, outcome = hr) {
  data <- raw_df[, c("ParticipantID", "PhaseID", eligibility, outcome), drop = FALSE]
  data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[outcome]], outcome)
  data <- data[rowSums(!is.finite(as.matrix(data[, c(eligibility, "Y")]))) == 0, ]
  md <- aggregate(data[, c(eligibility, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
  md$ParticipantID <- factor(md$ParticipantID)
  for (v in eligibility) {
    pm <- md[[v]]
    cm <- pm - ave(pm, md$ParticipantID, FUN = mean)
    sdv <- sd(cm)
    md[[paste0(v, "_phase_z")]] <- if (is.finite(sdv) && sdv > 0) cm / sdv else cm
  }
  md[, H4_PHASE_SUM_COLS] <- h4_phase_design(md$PhaseID)
  md
}

# Eq3 phase-mean eligibility (no SUN/GVI in fit)
eq3_elig <- c(
  "ucm_AIR_T_mid", "ucm_SND_dBA", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_MRT",
  "SVF", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")
md <- build_phase_design(eq3_elig)

z_cols <- paste0(eq3_elig, "_phase_z")
ph <- H4_PHASE_SUM_COLS
Xz <- as.matrix(md[, z_cols, drop = FALSE])
Xph <- as.matrix(md[, ph, drop = FALSE])

# 1) Correlation of each _phase_z with each PhaseSum column
cor_phase <- cor(cbind(Xz, Xph))
cor_with_sums <- sapply(z_cols, function(z) {
  r <- cor(md[[z]], md[, ph, drop = FALSE])
  ix <- which.max(abs(r))
  list(max_abs = max(abs(r)), which_max = ph[ix], r = r)
}, simplify = FALSE)

# 2) R² from regressing each _phase_z on PhaseSum* only → implied VIF if only phase in aux reg
r2_on_phase <- sapply(z_cols, function(z) {
  fit <- lm(as.formula(paste(z, "~", paste(ph, collapse = " + "))), data = md)
  summary(fit)$r.squared
})
vif_if_only_phase <- 1 / (1 - r2_on_phase)

# 3) Full Eq3 design: VIF per term
fixed_eq3 <- as.formula(paste("Y ~", paste(c(z_cols, ph), collapse = " + ")))
design <- model.matrix(fixed_eq3, md)[, -1, drop = FALSE]
vv <- h4_vif_per_term(design)

# 4) Increment: R² of MRT on phase + micro block (without MRT)
others <- setdiff(z_cols, "ucm_MRT_phase_z")
micro <- c("ucm_AIR_T_mid_phase_z", "ucm_AIR_RH_phase_z", "ucm_WIND_AWS_phase_z")
r2_mrt_on_phase <- summary(lm(as.formula(paste("ucm_MRT_phase_z ~", paste(c(ph, micro), collapse = " + "))), data = md))$r.squared
r2_mrt_on_phase_only <- summary(lm(as.formula(paste("ucm_MRT_phase_z ~", paste(ph, collapse = " + "))), data = md))$r.squared
r2_mrt_on_micro_only <- summary(lm(as.formula(paste("ucm_MRT_phase_z ~", paste(micro, collapse = " + "))), data = md))$r.squared

# 5) Person-centered raw correlation matrix (key thermal/GVI proxies if present)
extra <- intersect(c("ucm_UTCI", "gvi_50m", "ucm_SUN_Gh"), names(md))
if (length(extra)) {
  for (v in extra) {
    pm <- md[[v]]
    cm <- pm - ave(pm, md$ParticipantID, FUN = mean)
    sdv <- sd(cm)
    md[[paste0(v, "_pc")]] <- if (is.finite(sdv) && sdv > 0) cm / sdv else cm
  }
}

cat("=== Phase-mean design n =", nrow(md), "cells (HR complete on Eq3 eligibility) ===\n\n")

cat("--- A. |r| between each Eq3 _phase_z and PhaseSum columns (max across 3) ---\n")
tab_a <- do.call(rbind, lapply(z_cols, function(z) {
  r <- cor(md[[z]], md[, ph, drop = FALSE])
  data.frame(
    term = sub("_phase_z$", "", z),
    max_abs_r = round(max(abs(r)), 3),
    strongest_phase_contrast = ph[which.max(abs(r))],
    stringsAsFactors = FALSE)
}))
tab_a <- tab_a[order(-tab_a$max_abs_r), ]
print(tab_a, row.names = FALSE)

cat("\n--- B. R² from regressing _phase_z ~ PhaseSum* only (shared route structure) ---\n")
cat("Implied VIF vs phase block alone = 1/(1-R²)\n\n")
tab_b <- data.frame(
  term = sub("_phase_z$", "", z_cols),
  R2_on_phase_sums = round(r2_on_phase, 3),
  VIF_implied = round(vif_if_only_phase, 2),
  full_design_VIF = round(as.numeric(vv[z_cols]), 2),
  stringsAsFactors = FALSE)
tab_b <- tab_b[order(-tab_b$full_design_VIF), ]
print(tab_b, row.names = FALSE)

cat("\n--- C. ucm_MRT_phase_z: what predicts it? ---\n")
cat(sprintf("R²(MRT_z ~ PhaseSum* only)           = %.3f  → VIF vs phase only ≈ %.2f\n",
  r2_mrt_on_phase_only, 1 / (1 - r2_mrt_on_phase_only)))
cat(sprintf("R²(MRT_z ~ air T + RH + wind only)  = %.3f\n", r2_mrt_on_micro_only))
cat(sprintf("R²(MRT_z ~ PhaseSum* + micro block) = %.3f  → VIF vs those ≈ %.2f\n",
  r2_mrt_on_phase, 1 / (1 - r2_mrt_on_phase)))

cat("\n--- D. Full Eq3 design VIF (equivalent), sorted ---\n")
print(round(sort(vv, decreasing = TRUE), 2))

cat("\n--- E. PhaseID block in full Eq3 ---\n")
if ("PhaseID" %in% names(vv)) cat("PhaseID VIF-equiv:", round(vv["PhaseID"], 2), "\n")

cat("\n--- F. ucm_MRT_phase_z vs EACH PhaseSum column (Eq3 cells) ---\n")
mrt <- md$ucm_MRT_phase_z
for (p in ph) {
  fit1 <- lm(mrt ~ md[[p]])
  cat(sprintf("  %s: r = %+.3f, R² alone = %.3f\n", p, cor(mrt, md[[p]]), summary(fit1)$r.squared))
}
r2_all_ph <- summary(lm(mrt ~ ., data = md[, ph, drop = FALSE]))$r.squared
cat(sprintf("  All three PhaseSum*: joint R² = %.3f (VIF if MRT only competed with phases ≈ %.1f)\n",
  r2_all_ph, 1 / (1 - r2_all_ph)))
r2_rest_eq3 <- summary(lm(as.formula(paste(
  "ucm_MRT_phase_z ~", paste(setdiff(c(z_cols, ph), "ucm_MRT_phase_z"), collapse = " + "))), data = md))$r.squared
cat(sprintf("  MRT_z ~ all OTHER Eq3 fixed effects: R² = %.3f → MRT VIF = %.1f\n",
  r2_rest_eq3, 1 / (1 - r2_rest_eq3)))

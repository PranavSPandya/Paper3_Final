# VIF + collinearity: MRT + SND + PM + lux + kelvin + PhaseSum* (no SVF, no GVI).
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

elig <- c("ucm_MRT", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")
ph <- H4_PHASE_SUM_COLS

data <- raw_df[, c("ParticipantID", "PhaseID", elig, hr), drop = FALSE]
data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[hr]], hr)
data <- data[rowSums(!is.finite(as.matrix(data[, c(elig, "Y")]))) == 0, ]
md <- aggregate(data[, c(elig, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
md$ParticipantID <- factor(md$ParticipantID)
for (v in elig) {
  pm <- md[[v]]
  cm <- pm - ave(pm, md$ParticipantID, FUN = mean)
  sdv <- sd(cm)
  md[[paste0(v, "_phase_z")]] <- if (is.finite(sdv) && sdv > 0) cm / sdv else cm
}
md[, ph] <- h4_phase_design(md$PhaseID)

z_cols <- paste0(elig, "_phase_z")
fixed <- as.formula(paste("Y ~", paste(c(z_cols, ph), collapse = " + ")))
design <- model.matrix(fixed, md)[, -1, drop = FALSE]
vv <- h4_vif_per_term(design)

r2_on_phase <- sapply(z_cols, function(z) {
  summary(lm(as.formula(paste(z, "~", paste(ph, collapse = " + "))), data = md))$r.squared
})

r2_on_rest <- sapply(z_cols, function(z) {
  others <- setdiff(c(z_cols, ph), z)
  summary(lm(as.formula(paste(z, "~", paste(others, collapse = " + "))), data = md))$r.squared
})

cat("=== Spec: MRT + SND + PM2.5 + lux + kelvin + PhaseSum* ===\n")
cat("n =", nrow(md), "HR phase cells\n\n")

cat("Max VIF-equiv:", round(max(vv), 2), " | Worst:", names(vv)[which.max(vv)], "\n\n")
cat("All terms (sorted):\n")
print(round(sort(vv, decreasing = TRUE), 2))

tab <- data.frame(
  term = sub("_phase_z$", "", z_cols),
  R2_on_PhaseSum = round(r2_on_phase, 3),
  VIF_if_only_phase = round(1 / (1 - r2_on_phase), 2),
  R2_on_all_other_X = round(r2_on_rest, 3),
  full_VIF = round(as.numeric(vv[z_cols]), 2),
  stringsAsFactors = FALSE)
tab <- tab[order(-tab$full_VIF), ]
cat("\nPer exposure term:\n")
print(tab, row.names = FALSE)

r2_mrt <- summary(lm(as.formula(paste("ucm_MRT_phase_z ~",
  paste(setdiff(c(z_cols, ph), "ucm_MRT_phase_z"), collapse = " + "))), data = md))$r.squared
r2_snd <- summary(lm(as.formula(paste("ucm_SND_dBA_phase_z ~",
  paste(setdiff(c(z_cols, ph), "ucm_SND_dBA_phase_z"), collapse = " + "))), data = md))$r.squared

cat("\nAuxiliary (full spec):\n")
cat(sprintf("  R²(MRT | rest) = %.3f → VIF %.2f\n", r2_mrt, 1 / (1 - r2_mrt)))
cat(sprintf("  R²(SND | rest) = %.3f → VIF %.2f\n", r2_snd, 1 / (1 - r2_snd)))

R <- cor(md[, z_cols, drop = FALSE])
cat("\nMax |r| with other exposures (same _phase_z):\n")
for (i in seq_along(z_cols)) {
  rrow <- abs(R[i, -i])
  cat(" ", sub("_phase_z$", "", z_cols[i]), "↔",
    sub("_phase_z$", "", z_cols[-i][which.max(rrow)]), "=",
    round(max(rrow), 3), "\n")
}

# Drop-one max VIF
cat("\nDrop-one max VIF (keep PhaseSum*):\n")
for (drop_z in z_cols) {
  keep <- setdiff(c(z_cols, ph), drop_z)
  d2 <- model.matrix(as.formula(paste("Y~", paste(keep, collapse = "+"))), md)[, -1, drop = FALSE]
  v2 <- h4_vif_per_term(d2)
  cat(" ", sub("_phase_z$", "", drop_z), "→ max", round(max(v2), 2),
    "worst", names(v2)[which.max(v2)], "\n")
}

file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
script_dir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg)) else "."
setwd(normalizePath(script_dir, winslash = "/", mustWork = TRUE))
run_h4_phaseavg <- function(...) invisible(NULL)
run_h4 <- function(...) invisible(NULL)
paper3_standardize_result_directory <- function(...) invisible(NULL)
source("Analysis_combined_phaseavg.R", local = FALSE)
H4_ANALYSIS_MODE <- "phaseavg"
source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)

hr <- "empatica_heart_rate"
elig <- c("ucm_AIR_T_mid", "ucm_SND_dBA", "ucm_AIR_RH", "ucm_WIND_AWS",
  "SVF", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")
ph <- H4_PHASE_SUM_COLS
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

t <- "ucm_AIR_T_mid_phase_z"
svf <- "SVF_phase_z"
cat("Person-mean-centered phase cells n =", nrow(md), "\n\n")
cat("Correlations (phase_z):\n")
print(round(cor(md[, paste0(elig, "_phase_z")]), 2))

r2_t_ph <- summary(lm(as.formula(paste(t, "~", paste(ph, collapse = "+"))), md))$r.squared
r2_t_svf <- summary(lm(as.formula(paste(t, "~", svf)), md))$r.squared
r2_t_ph_svf <- summary(lm(as.formula(paste(t, "~", paste(c(ph, svf), collapse = "+"))), md))$r.squared
r2_svf_ph <- summary(lm(as.formula(paste(svf, "~", paste(ph, collapse = "+"))), md))$r.squared
cat("\nR2 air T ~ PhaseSum:", round(r2_t_ph, 3), "\n")
cat("R2 air T ~ SVF only:", round(r2_t_svf, 3), "\n")
cat("R2 air T ~ PhaseSum + SVF:", round(r2_t_ph_svf, 3), "\n")
cat("R2 SVF ~ PhaseSum:", round(r2_svf_ph, 3), "\n")
others_no_svf <- c(setdiff(paste0(elig, "_phase_z"), c(t, svf)), ph)
r2_t_all_no_svf <- summary(lm(as.formula(paste(t, "~", paste(others_no_svf, collapse = "+"))), md))$r.squared
cat("R2 air T ~ other Eq2 (no SVF):", round(r2_t_all_no_svf, 3),
  " VIF~", round(1 / (1 - r2_t_all_no_svf), 2), "\n")

full <- paste(c(paste0(elig, "_phase_z"), ph), collapse = "+")
no_svf <- paste(c(setdiff(paste0(elig, "_phase_z"), svf), ph), collapse = "+")
d1 <- model.matrix(as.formula(paste("Y~", full)), md)[, -1]
d2 <- model.matrix(as.formula(paste("Y~", no_svf)), md)[, -1]
cat("\nMax VIF with SVF:", round(max(h4_vif_per_term(d1)), 2), "\n")
cat("Max VIF without SVF:", round(max(h4_vif_per_term(d2)), 2), "\n")

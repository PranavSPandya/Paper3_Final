file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
script_dir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg)) else "."
setwd(normalizePath(script_dir, winslash = "/", mustWork = TRUE))
run_h4_phaseavg <- function(...) invisible(NULL)
run_h4 <- function(...) invisible(NULL)
paper3_standardize_result_directory <- function(...) invisible(NULL)
source("Analysis_combined_phaseavg.R", local = FALSE)
H4_ANALYSIS_MODE <- "phaseavg"
source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
raw <- h4_apply_average_sources(h4_read_merged_analysis_data())
hr <- "empatica_heart_rate"
elig <- c("ucm_MRT", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")
ph <- H4_PHASE_SUM_COLS
data <- raw[, c("ParticipantID", "PhaseID", elig, hr)]
data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[hr]], hr)
data <- data[rowSums(!is.finite(as.matrix(data[, c(elig, "Y")]))) == 0, ]
data <- data[data$PhaseID %in% h4_study_spec$phases, , drop = FALSE]
md <- aggregate(data[, c(elig, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
md$PhaseID <- factor(md$PhaseID, levels = h4_study_spec$phases)
for (v in elig) {
  pm <- md[[v]]
  cm <- pm - ave(pm, md$ParticipantID, FUN = mean)
  sdv <- sd(cm)
  md[[paste0(v, "_phase_z")]] <- if (is.finite(sdv) && sdv > 0) cm / sdv else cm
}
md[, ph] <- h4_phase_design(md$PhaseID)
mrt <- "ucm_MRT_phase_z"
cov_only <- setdiff(paste0(elig, "_phase_z"), mrt)
others <- c(cov_only, ph)
r2_ph <- summary(lm(as.formula(paste(mrt, "~", paste(ph, collapse = " + "))), data = md))$r.squared
r2_cov <- summary(lm(as.formula(paste(mrt, "~", paste(cov_only, collapse = " + "))), data = md))$r.squared
r2_all <- summary(lm(as.formula(paste(mrt, "~", paste(others, collapse = " + "))), data = md))$r.squared
design <- model.matrix(as.formula(paste("Y ~", paste(c(paste0(elig, "_phase_z"), ph), collapse = " + "))), md)[, -1, drop = FALSE]
vv <- h4_vif_per_term(design)
cat("n =", nrow(md), "\n")
cat("R2 MRT ~ PhaseSum only:", round(r2_ph, 4), " implied VIF", round(1 / (1 - r2_ph), 2), "\n")
cat("R2 MRT ~ sound/PM/light only:", round(r2_cov, 4), "\n")
cat("R2 MRT ~ all other Eq3 fixed:", round(r2_all, 4), " implied VIF", round(1 / (1 - r2_all), 2), "\n")
cat("h4_vif ucm_MRT_phase_z:", round(vv["ucm_MRT_phase_z"], 2), "\n")

# Eq2 phase-mean: which drops bring max VIF below 10? (HR complete cases, n=44)
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
elig_full <- c(
  "ucm_AIR_T_mid", "ucm_SND_dBA", "ucm_AIR_RH", "ucm_WIND_AWS",
  "SVF", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")
ph <- H4_PHASE_SUM_COLS

build_md <- function(eligibility) {
  raw <- h4_apply_average_sources(h4_read_merged_analysis_data())
  data <- raw[, c("ParticipantID", "PhaseID", eligibility, hr)]
  data <- data[data$PhaseID %in% h4_study_spec$phases, , drop = FALSE]
  data$Y <- PAPER3_APPLY_CSV_TRANSFORM(data[[hr]], hr)
  data <- data[rowSums(!is.finite(as.matrix(data[, c(eligibility, "Y")]))) == 0, ]
  md <- aggregate(data[, c(eligibility, "Y")], data[, c("ParticipantID", "PhaseID")], mean)
  md$PhaseID <- factor(md$PhaseID, levels = h4_study_spec$phases)
  for (v in eligibility) {
    pm <- md[[v]]
    cm <- pm - ave(pm, md$ParticipantID, FUN = mean)
    sdv <- sd(cm)
    md[[paste0(v, "_phase_z")]] <- if (is.finite(sdv) && sdv > 0) cm / sdv else cm
  }
  if (length(ph)) md[, ph] <- h4_phase_design(md$PhaseID)
  md
}

max_vif <- function(eligibility, include_phase = TRUE) {
  md <- build_md(eligibility)
  z <- paste0(eligibility, "_phase_z")
  rhs <- if (include_phase) c(z, ph) else z
  design <- model.matrix(as.formula(paste("Y ~", paste(rhs, collapse = " + "))), md)[, -1, drop = FALSE]
  vv <- h4_vif_per_term(design)
  list(max = max(vv), worst = names(vv)[which.max(vv)], vv = vv, n = nrow(md))
}

cat("=== Eq2 phase-mean full design ===\n")
full <- max_vif(elig_full, TRUE)
print(round(sort(full$vv, decreasing = TRUE), 2))
cat("max", round(full$max, 2), "worst", full$worst, "n", full$n, "\n\n")

t_mid <- "ucm_AIR_T_mid_phase_z"
md <- build_md(elig_full)
r2_ph <- summary(lm(as.formula(paste(t_mid, "~", paste(ph, collapse = " + "))), data = md))$r.squared
others <- c(setdiff(paste0(elig_full, "_phase_z"), t_mid), ph)
r2_all <- summary(lm(as.formula(paste(t_mid, "~", paste(others, collapse = " + "))), data = md))$r.squared
cat("R2 AIR_T_mid ~ PhaseSum only:", round(r2_ph, 4), " VIF~", round(1 / (1 - r2_ph), 2), "\n")
cat("R2 AIR_T_mid ~ all other fixed:", round(r2_all, 4), " VIF~", round(1 / (1 - r2_all), 2), "\n\n")

scenarios <- list(
  "drop PhaseSum*" = list(elig = elig_full, phase = FALSE),
  "drop SVF" = list(elig = setdiff(elig_full, "SVF"), phase = TRUE),
  "drop RH + wind" = list(elig = setdiff(elig_full, c("ucm_AIR_RH", "ucm_WIND_AWS")), phase = TRUE),
  "drop air T (keep RH+wind)" = list(elig = setdiff(elig_full, "ucm_AIR_T_mid"), phase = TRUE),
  "drop SVF + PhaseSum*" = list(elig = setdiff(elig_full, "SVF"), phase = FALSE),
  "drop RH + wind + PhaseSum*" = list(elig = setdiff(elig_full, c("ucm_AIR_RH", "ucm_WIND_AWS")), phase = FALSE),
  "micro block only (T,RH,wind) + sound + PM + light, no SVF, no PhaseSum" = list(
    elig = c("ucm_AIR_T_mid", "ucm_SND_dBA", "ucm_AIR_RH", "ucm_WIND_AWS",
      "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg"), phase = FALSE),
  "sound + PM + light + PhaseSum only (no air, no SVF)" = list(
    elig = c("ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg"), phase = TRUE))

cat("=== Drop scenarios (max VIF) ===\n")
for (nm in names(scenarios)) {
  s <- scenarios[[nm]]
  r <- max_vif(s$elig, s$phase)
  flag <- if (r$max < 10) "<10" else ">=10"
  cat(sprintf("%-55s max %5.2f  worst %-28s %s\n", nm, r$max, r$worst, flag))
}

# Single-term leave-one-out on worst driver
cat("\n=== Leave one predictor out (keep PhaseSum) ===\n")
for (drop in elig_full) {
  r <- max_vif(setdiff(elig_full, drop), TRUE)
  cat(sprintf("drop %-20s max %5.2f worst %s\n", drop, r$max, r$worst))
}

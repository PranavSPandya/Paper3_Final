# Eq2 VIF cascade: full -> drop SVF -> drop SUN -> drop SND (no GVI); HR reference, phase + 10s.
file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
script_dir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg)) else "."
setwd(normalizePath(script_dir, winslash = "/", mustWork = TRUE))
run_h4_phaseavg <- function(...) invisible(NULL)
run_h4 <- function(...) invisible(NULL)
paper3_standardize_result_directory <- function(...) invisible(NULL)
source("Analysis_combined_phaseavg.R", local = FALSE)
H4_ANALYSIS_MODE <- "phaseavg"
source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)

ph <- H4_PHASE_SUM_COLS
hr <- "empatica_heart_rate"
base <- c(
  "ucm_AIR_T_mid", "ucm_SND_dBA", "ucm_AIR_RH", "ucm_WIND_AWS",
  "ucm_SUN_Gh", "SVF", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg")

scenarios <- list(
  "1_full (SUN + SVF + SND)" = base,
  "2_drop SVF" = setdiff(base, "SVF"),
  "3_drop SVF + SUN_Gh" = setdiff(base, c("SVF", "ucm_SUN_Gh")),
  "4_drop SVF + SUN_Gh + SND" = setdiff(base, c("SVF", "ucm_SUN_Gh", "ucm_SND_dBA")))

phase_vif <- function(elig) {
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
  list(n = nrow(md), max = max(vv), worst = names(vv)[which.max(vv)], vv = vv)
}

timeseries_vif <- function(elig) {
  audit <- read.csv(file.path(H4_RESULTS_ROOT, "Analysis_combined_timeseries",
    "Analysis_combined_timeseries_Multivariate_Filtration_Results.csv"), check.names = FALSE)
  raw <- h4_apply_average_sources(h4_read_merged_analysis_data())
  prepared <- h4_step4_exposure_prep(audit, raw)
  raw_df <- prepared$raw_df
  ok <- rowSums(!is.finite(as.matrix(raw_df[, c(elig, hr), drop = FALSE]))) == 0L
  z <- prepared$centered[ok, elig, drop = FALSE]
  design <- cbind(z, h4_phase_design(raw_df$PhaseID[ok]))
  colnames(design) <- c(paste0(elig, "_bout_z"), ph)
  vv <- h4_vif_per_term(design)
  list(n = sum(ok), max = max(vv), worst = names(vv)[which.max(vv)], vv = vv)
}

for (nm in names(scenarios)) {
  elig <- scenarios[[nm]]
  cat("\n==========", nm, "==========\n")
  cat(paste(c(elig, ph), collapse = " + "), "\n\n")
  p <- phase_vif(elig)
  t <- timeseries_vif(elig)
  cat("Phase mean  n =", p$n, " max VIF =", round(p$max, 2), " (", p$worst, ")\n")
  print(round(sort(p$vv, decreasing = TRUE), 2))
  cat("\n10 s        n =", t$n, " max VIF =", round(t$max, 2), " (", t$worst, ")\n")
  print(round(sort(t$vv, decreasing = TRUE), 2))
}

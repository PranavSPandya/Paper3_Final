# VIF for Eq3: MRT + SND + PM2.5 + lux + kelvin + PhaseSum* (phase + timeseries).
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

phase_vif <- function() {
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
  fixed <- as.formula(paste("Y ~", paste(c(paste0(elig, "_phase_z"), ph), collapse = " + ")))
  design <- model.matrix(fixed, md)[, -1, drop = FALSE]
  vv <- h4_vif_per_term(design)
  list(n = nrow(md), vv = vv)
}

timeseries_vif <- function() {
  ok <- h4_complete_rows(raw_df, hr, 3L)
  eq <- prepared$catalog[prepared$catalog$equation_id == 3L, ]
  z <- prepared$centered[ok, , drop = FALSE]
  phase_vec <- raw_df$PhaseID[ok]
  design <- prepared$make_design(z, prepared$thermal[[eq$heat_form]], phase_vec, test = eq$test,
    terms_order = h4_equation_term_order(3L))
  vv <- h4_vif_per_term(design)
  list(n = nrow(z), vv = vv)
}

cat("=== Eq3 phase mean (no GVI) ===\n")
p <- phase_vif()
cat("n =", p$n, "max VIF =", round(max(p$vv), 2), "worst =", names(p$vv)[which.max(p$vv)], "\n")
print(round(sort(p$vv, decreasing = TRUE), 2))

cat("\n=== Eq3 10 s timeseries (no GVI) ===\n")
t <- timeseries_vif()
cat("n =", t$n, "max VIF =", round(max(t$vv), 2), "worst =", names(t$vv)[which.max(t$vv)], "\n")
print(round(sort(t$vv, decreasing = TRUE), 2))

# Eq1 with MRT instead of UTCI: design max VIF (HR reference) and drop-one env terms.
# Grains: phase-average (primary) and 10 s bout (Eq1 + SUN/GVI), same pipeline as _compute_eq3_phaseavg_vif_drops.R.

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
prepared_phase <- h4_step4_exposure_prep(audit, raw)
raw_df <- prepared_phase$raw_df

hr_outcome <- "empatica_heart_rate"
vif_limit <- h4_study_spec$variance_inflation_factor_limit
phase_labels <- H4_PHASE_SUM_COLS

reference_eq1 <- H4_REFERENCE_MODELS[["1"]][[2L]]
eligibility_mrt <- setdiff(all.vars(reference_eq1), c("Y", phase_labels))
eligibility_mrt <- sub("^ucm_UTCI$", "ucm_MRT", eligibility_mrt)

eq1_mrt_labels <- c(
  "ucm_MRT_phase_z", "ucm_SND_dBA_phase_z", "SVF_phase_z", "atmo_pm2.5_avg_phase_z",
  "lys_lux_avg_phase_z", "lys_kelvin_avg_phase_z", phase_labels)
eq1_mrt_fixed <- as.formula(paste("Y ~", paste(setdiff(eq1_mrt_labels, phase_labels), collapse = " + "),
  "+ PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG"))

eq1_utci_fixed <- as.formula(Eq1[[2L]])

term_labels <- function(fixed) attr(terms(fixed), "term.labels")
make_formula <- function(keep_labels) as.formula(paste("Y ~", paste(keep_labels, collapse = " + ")))

phaseavg_max_vif <- function(outcome, fixed, eligibility) {
  data <- raw_df[, c("ParticipantID", "PhaseID", eligibility, outcome)]
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
  model_data[, phase_labels] <- h4_phase_design(model_data$PhaseID)
  design <- model.matrix(fixed, model_data)
  design <- design[, colnames(design) != "(Intercept)", drop = FALSE]
  vv <- h4_vif_per_term(design)
  list(
    n_design_rows = nrow(model_data),
    max_vif_equivalent = max(vv, na.rm = TRUE),
    worst_term = names(vv)[which.max(vv)],
    full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L)
}

run_phase_scenario <- function(dropped_label, fixed, eligibility) {
  r <- phaseavg_max_vif(hr_outcome, fixed, eligibility)
  data.frame(
    grain = "phaseavg",
    dropped_terms = dropped_label,
    max_vif = round(r$max_vif_equivalent, 2),
    worst_term = r$worst_term,
    under_10 = r$max_vif_equivalent < vif_limit,
    n_design_rows = r$n_design_rows,
    full_rank = r$full_rank,
    stringsAsFactors = FALSE)
}

env_one_drop <- setdiff(eq1_mrt_labels, phase_labels)
stopifnot(all(env_one_drop %in% term_labels(eq1_mrt_fixed)))

phase_rows <- list()
phase_rows[[1L]] <- run_phase_scenario("(none — Eq1 MRT full)", eq1_mrt_fixed, eligibility_mrt)
phase_rows[[2L]] <- run_phase_scenario("(none — Eq1 UTCI full)", eq1_utci_fixed, setdiff(all.vars(reference_eq1), c("Y", phase_labels)))

k <- length(phase_rows)
all_mrt_labels <- term_labels(eq1_mrt_fixed)
for (lab in env_one_drop) {
  k <- k + 1L
  phase_rows[[k]] <- run_phase_scenario(sub("_phase_z$", "", lab), make_formula(setdiff(all_mrt_labels, lab)), eligibility_mrt)
}

# --- 10 s bout (Eq1 structure: MRT + SUN/GVI) ---
source("Analysis_combined_timeseries.R", local = FALSE)
H4_ANALYSIS_MODE <- "timeseries"
source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
rm("H4_ANALYSIS_MODE", envir = .GlobalEnv)

prepared_ts <- h4_step4_exposure_prep(audit, raw)
raw_ts <- prepared_ts$raw_df
centered <- prepared_ts$centered

eq1_mrt_terms <- sub("^ucm_UTCI$", "ucm_MRT", H4_EQUATION_FIXED[["1"]])

bout_term_label <- function(raw_name) {
  if (raw_name %in% phase_labels) raw_name else paste0(raw_name, "_bout_z")
}

bout_fixed_from_mains <- function(mains_order) {
  labels <- vapply(mains_order, bout_term_label, character(1))
  as.formula(paste("Y ~", paste(labels, collapse = " + ")))
}

bout_complete_rows <- function(outcome, mains_order) {
  predictors <- setdiff(mains_order, phase_labels)
  values <- as.matrix(raw_ts[, c(predictors, outcome), drop = FALSE])
  storage.mode(values) <- "double"
  ok <- rowSums(!is.finite(values)) == 0L
  if (outcome %in% h4_study_spec$natural_log_outcome_names) ok <- ok & raw_ts[[outcome]] > 0
  ok
}

timeseries_max_vif <- function(mains_order) {
  ok <- bout_complete_rows(hr_outcome, mains_order)
  z <- centered[ok, , drop = FALSE]
  phase_vec <- raw_ts$PhaseID[ok]
  env_mains <- setdiff(mains_order, phase_labels)
  model_data <- as.data.frame(z[, env_mains, drop = FALSE])
  names(model_data) <- vapply(env_mains, bout_term_label, character(1))
  if (any(phase_labels %in% mains_order)) {
    phase_mat <- h4_phase_design(phase_vec)
    for (lab in intersect(phase_labels, mains_order)) model_data[[lab]] <- phase_mat[, lab]
  }
  fixed <- bout_fixed_from_mains(mains_order)
  design <- model.matrix(reformulate(attr(terms(fixed), "term.labels")), model_data)
  design <- design[, colnames(design) != "(Intercept)", drop = FALSE]
  vv <- h4_vif_per_term(design)
  list(
    n_design_rows = nrow(model_data),
    max_vif_equivalent = max(vv, na.rm = TRUE),
    worst_term = names(vv)[which.max(vv)],
    full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L)
}

run_ts_scenario <- function(dropped_label, mains_order) {
  r <- timeseries_max_vif(mains_order)
  data.frame(
    grain = "timeseries_10s",
    dropped_terms = dropped_label,
    max_vif = round(r$max_vif_equivalent, 2),
    worst_term = r$worst_term,
    under_10 = r$max_vif_equivalent < vif_limit,
    n_design_rows = r$n_design_rows,
    full_rank = r$full_rank,
    stringsAsFactors = FALSE)
}

ts_rows <- list()
ts_rows[[1L]] <- run_ts_scenario("(none — Eq1 MRT full)", eq1_mrt_terms)
ts_rows[[2L]] <- run_ts_scenario("(none — Eq1 UTCI full)", H4_EQUATION_FIXED[["1"]])
k <- length(ts_rows)
for (main in setdiff(eq1_mrt_terms, phase_labels)) {
  k <- k + 1L
  ts_rows[[k]] <- run_ts_scenario(main, setdiff(eq1_mrt_terms, main))
}

out <- rbind(do.call(rbind, phase_rows), do.call(rbind, ts_rows))
out <- out[order(out$grain, out$max_vif, out$dropped_terms), , drop = FALSE]

out_dir_phase <- file.path(H4_RESULTS_ROOT, "Analysis_combined_phaseavg")
dir.create(out_dir_phase, recursive = TRUE, showWarnings = FALSE)

out_csv <- file.path(out_dir_phase, "Analysis_combined_eq1_mrt_vif_drop_scenarios.csv")
utils::write.csv(out, out_csv, row.names = FALSE)
utils::write.csv(out[out$grain == "timeseries_10s", , drop = FALSE],
  file.path(H4_RESULTS_ROOT, "Analysis_combined_timeseries_eq1_mrt_vif_drop_scenarios.csv"), row.names = FALSE)

cat("Eq1 MRT vs UTCI — design max VIF (outcome:", hr_outcome, "; threshold", vif_limit, ")\n\n")
for (g in unique(out$grain)) {
  cat("===", g, "===\n")
  sub <- out[out$grain == g, c("dropped_terms", "max_vif", "worst_term", "under_10", "n_design_rows")]
  print(sub, row.names = FALSE)
  cat("\n")
}
cat("Wrote:", out_csv, "\n")

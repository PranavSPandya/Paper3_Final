# Design-only max VIF per Eq1-7 for Analysis_combined phaseavg and timeseries (no LME fits).
# Writes:
#   output/statistical_analysis/results/Analysis_combined_phaseavg/Analysis_combined_phaseavg_gvif_summary.csv
#   output/statistical_analysis/results/Analysis_combined_timeseries/Analysis_combined_timeseries_gvif_summary.csv
#   output/statistical_analysis/results/Analysis_combined_gvif_summary_both_grains.csv

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
prepared <- h4_step4_exposure_prep(audit, raw)
raw_df <- prepared$raw_df

outcomes <- h4_study_spec$all_physiological_outcomes
hr_outcome <- "empatica_heart_rate"
equations <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7)
n_eq <- length(equations)

compact_terms <- function(id) {
  paste(vapply(H4_EQUATION_FIXED[[as.character(id)]], h4_spell_term, character(1)), collapse = ", ")
}

phaseavg_max_vif <- function(outcome, equation_id = NULL, fixed = NULL, eligibility = NULL) {
  if (is.null(fixed)) {
    stopifnot(!is.null(equation_id))
    fixed <- as.formula(equations[[equation_id]][[2L]])
  }
  if (is.null(eligibility)) {
    stopifnot(!is.null(equation_id))
    eligibility <- setdiff(
      h4_fixed_terms_from_lme_quote(equations[[equation_id]]),
      H4_PHASE_SUM_COLS)
  }
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
  model_data[, H4_PHASE_SUM_COLS] <- h4_phase_design(model_data$PhaseID)
  design <- model.matrix(fixed, model_data)
  design <- design[, colnames(design) != "(Intercept)", drop = FALSE]
  vv <- h4_vif_per_term(design)
  list(
    outcome = outcome,
    equation_id = if (is.null(equation_id)) NA_integer_ else equation_id,
    n_design_rows = nrow(model_data),
    max_vif_equivalent = max(vv, na.rm = TRUE),
    worst_term = names(vv)[which.max(vv)],
    full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L)
}

timeseries_max_vif <- function(outcome, equation_id) {
  eq <- prepared$catalog[prepared$catalog$equation_id == equation_id, ]
  ok <- h4_complete_rows(raw_df, outcome, equation_id)
  z <- prepared$centered[ok, , drop = FALSE]
  phase_vec <- raw_df$PhaseID[ok]
  design <- prepared$make_design(z, prepared$thermal[[eq$heat_form]], phase_vec, test = eq$test,
    terms_order = h4_equation_term_order(equation_id))
  vv <- h4_vif_per_term(design)
  list(
    outcome = outcome,
    equation_id = equation_id,
    n_design_rows = nrow(z),
    max_vif_equivalent = max(vv, na.rm = TRUE),
    worst_term = names(vv)[which.max(vv)],
    full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L)
}

summarize_grain <- function(detail) {
  hr <- detail[detail$outcome == hr_outcome, ]
  do.call(rbind, lapply(split(detail, detail$equation_id), function(d) {
    id <- d$equation_id[1L]
    worst_ix <- which.max(d$max_vif_equivalent)
    data.frame(
      equation_id = id,
      terms = compact_terms(id),
      max_vif_heart_rate = hr$max_vif_equivalent[hr$equation_id == id],
      worst_term_heart_rate = hr$worst_term[hr$equation_id == id],
      n_design_rows_hr = hr$n_design_rows[hr$equation_id == id],
      max_vif_worst_outcome = max(d$max_vif_equivalent, na.rm = TRUE),
      worst_outcome = d$outcome[worst_ix],
      worst_term_worst_outcome = d$worst_term[worst_ix],
      stringsAsFactors = FALSE)
  }))
}

rows <- list()
k <- 0L
for (outcome in outcomes) for (equation_id in seq_len(n_eq)) {
  k <- k + 1L
  rows[[k]] <- phaseavg_max_vif(outcome, equation_id)
}
phase_detail <- do.call(rbind, lapply(rows, as.data.frame, stringsAsFactors = FALSE))
phase_summary <- summarize_grain(phase_detail)
phase_summary <- phase_summary[order(phase_summary$equation_id), ]

rows <- list()
k <- 0L
for (outcome in outcomes) for (equation_id in seq_len(n_eq)) {
  k <- k + 1L
  rows[[k]] <- timeseries_max_vif(outcome, equation_id)
}
ts_detail <- do.call(rbind, lapply(rows, as.data.frame, stringsAsFactors = FALSE))
ts_summary <- summarize_grain(ts_detail)
ts_summary <- ts_summary[order(ts_summary$equation_id), ]

both <- merge(
  phase_summary[, c("equation_id", "terms", "max_vif_heart_rate", "worst_term_heart_rate", "n_design_rows_hr",
    "max_vif_worst_outcome", "worst_outcome")],
  ts_summary[, c("equation_id", "max_vif_heart_rate", "worst_term_heart_rate", "n_design_rows_hr",
    "max_vif_worst_outcome", "worst_outcome")],
  by = "equation_id", suffixes = c("_phaseavg", "_timeseries"))

both$max_vif_heart_rate_phaseavg <- round(both$max_vif_heart_rate_phaseavg, 2)
both$max_vif_heart_rate_timeseries <- round(both$max_vif_heart_rate_timeseries, 2)
both$max_vif_worst_outcome_phaseavg <- round(both$max_vif_worst_outcome_phaseavg, 2)
both$max_vif_worst_outcome_timeseries <- round(both$max_vif_worst_outcome_timeseries, 2)

phase_out_dir <- file.path(H4_RESULTS_ROOT, "Analysis_combined_phaseavg")
dir.create(phase_out_dir, recursive = TRUE, showWarnings = FALSE)

phase_csv <- file.path(phase_out_dir, "Analysis_combined_phaseavg_gvif_summary.csv")
ts_csv <- file.path(H4_RESULTS_ROOT, "Analysis_combined_timeseries_gvif_summary.csv")
both_csv <- file.path(H4_RESULTS_ROOT, "Analysis_combined_gvif_summary_both_grains.csv")

phase_write <- phase_summary
phase_write$max_vif_heart_rate <- round(phase_write$max_vif_heart_rate, 2)
phase_write$max_vif_worst_outcome <- round(phase_write$max_vif_worst_outcome, 2)
utils::write.csv(phase_write, phase_csv, row.names = FALSE)

ts_write <- ts_summary
ts_write$max_vif_heart_rate <- round(ts_write$max_vif_heart_rate, 2)
ts_write$max_vif_worst_outcome <- round(ts_write$max_vif_worst_outcome, 2)
utils::write.csv(ts_write, ts_csv, row.names = FALSE)

utils::write.csv(both, both_csv, row.names = FALSE)

cat("Design VIF summary (threshold", h4_study_spec$variance_inflation_factor_limit,
  "; reference outcome", hr_outcome, ")\n\n")
cat("=== Combined Eq1-7 (HR reference; footnote = worst of 26 outcomes) ===\n")
print(both[, c("equation_id", "terms", "max_vif_heart_rate_phaseavg", "max_vif_heart_rate_timeseries",
  "max_vif_worst_outcome_phaseavg", "max_vif_worst_outcome_timeseries")], row.names = FALSE)
cat("\nWrote:", phase_csv, "\n")
cat("Wrote:", ts_csv, "\n")
cat("Wrote:", both_csv, "\n")

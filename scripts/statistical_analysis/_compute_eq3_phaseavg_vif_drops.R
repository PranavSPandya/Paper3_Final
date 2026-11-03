# Eq3 phaseavg design VIF: drop-one and micro-block combinations (HR reference, 44 cells).
# Same pipeline as _compute_phaseavg_gvif_summary.R / h4_vif_per_term (no LME fits).

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

hr_outcome <- "empatica_heart_rate"
eq3_id <- 3L
eq2_id <- 2L
vif_limit <- h4_study_spec$variance_inflation_factor_limit

reference_eq3 <- H4_REFERENCE_MODELS[[as.character(eq3_id)]][[2L]]
eligibility_eq3 <- setdiff(all.vars(reference_eq3), c("Y", H4_PHASE_SUM_COLS))

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
  model_data[, H4_PHASE_SUM_COLS] <- h4_phase_design(model_data$PhaseID)
  design <- model.matrix(fixed, model_data)
  design <- design[, colnames(design) != "(Intercept)", drop = FALSE]
  vv <- h4_vif_per_term(design)
  list(
    n_design_rows = nrow(model_data),
    max_vif_equivalent = max(vv, na.rm = TRUE),
    worst_term = names(vv)[which.max(vv)],
    full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L)
}

term_labels <- function(fixed) attr(terms(fixed), "term.labels")

make_formula <- function(keep_labels) {
  as.formula(paste("Y ~", paste(keep_labels, collapse = " + ")))
}

eq3_fixed <- as.formula(Eq3[[2L]])
eq2_fixed <- as.formula(Eq2[[2L]])
all_eq3_labels <- term_labels(eq3_fixed)
phase_labels <- H4_PHASE_SUM_COLS
env_one_drop <- c(
  "ucm_AIR_T_mid_phase_z", "ucm_SND_dBA_phase_z", "ucm_AIR_RH_phase_z",
  "ucm_WIND_AWS_phase_z", "ucm_MRT_phase_z", "SVF_phase_z",
  "atmo_pm2.5_avg_phase_z", "lys_lux_avg_phase_z", "lys_kelvin_avg_phase_z")
stopifnot(all(env_one_drop %in% all_eq3_labels))

micro_block <- c("ucm_AIR_T_mid_phase_z", "ucm_AIR_RH_phase_z", "ucm_WIND_AWS_phase_z", "ucm_MRT_phase_z")

run_scenario <- function(dropped_label, fixed) {
  r <- phaseavg_max_vif(hr_outcome, fixed, eligibility_eq3)
  data.frame(
    dropped_terms = dropped_label,
    max_vif = round(r$max_vif_equivalent, 2),
    worst_term = r$worst_term,
    under_10 = r$max_vif_equivalent < vif_limit,
    n_design_rows = r$n_design_rows,
    full_rank = r$full_rank,
    stringsAsFactors = FALSE)
}

rows <- list()

rows[[1L]] <- run_scenario("(none — Eq3 full)", eq3_fixed)
rows[[2L]] <- run_scenario("(none — Eq2 baseline)", eq2_fixed)

k <- length(rows)
for (lab in env_one_drop) {
  k <- k + 1L
  short <- sub("_phase_z$", "", lab)
  rows[[k]] <- run_scenario(short, make_formula(setdiff(all_eq3_labels, lab)))
}

# Drop MRT only explicitly labeled (same as Eq2 structure on micro+shared covariates)
k <- k + 1L
rows[[k]] <- run_scenario("ucm_MRT (→ Eq2-like)", make_formula(setdiff(all_eq3_labels, "ucm_MRT_phase_z")))

combos <- list()
combos[[length(combos) + 1L]] <- micro_block[c(1, 2)]
combos[[length(combos) + 1L]] <- micro_block[c(1, 3)]
combos[[length(combos) + 1L]] <- micro_block[c(1, 4)]
combos[[length(combos) + 1L]] <- micro_block[c(2, 3)]
combos[[length(combos) + 1L]] <- micro_block[c(2, 4)]
combos[[length(combos) + 1L]] <- micro_block[c(3, 4)]
combos[[length(combos) + 1L]] <- micro_block[c(1, 2, 3)]
combos[[length(combos) + 1L]] <- micro_block[c(1, 2, 4)]
combos[[length(combos) + 1L]] <- micro_block[c(1, 3, 4)]
combos[[length(combos) + 1L]] <- micro_block[c(2, 3, 4)]
combos[[length(combos) + 1L]] <- micro_block

for (drop_set in combos) {
  k <- k + 1L
  drop_short <- paste(sub("_phase_z$", "", drop_set), collapse = " + ")
  rows[[k]] <- run_scenario(
    paste0("micro block drop: ", drop_short),
    make_formula(setdiff(all_eq3_labels, drop_set)))
}

out <- do.call(rbind, rows)
out <- out[order(out$max_vif, out$dropped_terms), , drop = FALSE]

out_dir <- file.path(H4_RESULTS_ROOT, "Analysis_combined_phaseavg")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
out_csv <- file.path(out_dir, "Analysis_combined_phaseavg_eq3_vif_drop_scenarios.csv")
utils::write.csv(out, out_csv, row.names = FALSE)

# Eq2 single drops (same 44 HR cells; Eq2 eligibility)
reference_eq2 <- H4_REFERENCE_MODELS[[as.character(eq2_id)]][[2L]]
eligibility_eq2 <- setdiff(all.vars(reference_eq2), c("Y", H4_PHASE_SUM_COLS))
eq2_labels <- term_labels(eq2_fixed)
eq2_env <- setdiff(eq2_labels, phase_labels)
eq2_rows <- list()
eq2_rows[[1L]] <- {
  r <- phaseavg_max_vif(hr_outcome, eq2_fixed, eligibility_eq2)
  data.frame(dropped_terms = "(none — Eq2 full)", max_vif = round(r$max_vif_equivalent, 2),
    worst_term = r$worst_term, under_10 = r$max_vif_equivalent < vif_limit,
    n_design_rows = r$n_design_rows, stringsAsFactors = FALSE)
}
for (lab in eq2_env) {
  r <- phaseavg_max_vif(hr_outcome, make_formula(setdiff(eq2_labels, lab)), eligibility_eq2)
  eq2_rows[[length(eq2_rows) + 1L]] <- data.frame(
    dropped_terms = sub("_phase_z$", "", lab), max_vif = round(r$max_vif_equivalent, 2),
    worst_term = r$worst_term, under_10 = r$max_vif_equivalent < vif_limit,
    n_design_rows = r$n_design_rows, stringsAsFactors = FALSE)
}
eq2_out <- do.call(rbind, eq2_rows)
eq2_out <- eq2_out[order(eq2_out$max_vif, eq2_out$dropped_terms), , drop = FALSE]
eq2_csv <- file.path(out_dir, "Analysis_combined_phaseavg_eq2_vif_drop_one.csv")
utils::write.csv(eq2_out, eq2_csv, row.names = FALSE)

cat("Eq3 phaseavg VIF drop scenarios (outcome:", hr_outcome, "; eligibility: Eq3;", vif_limit, "threshold)\n\n")
print(out[, c("dropped_terms", "max_vif", "worst_term", "under_10", "n_design_rows")], row.names = FALSE)
cat("\nWrote:", out_csv, "\n\n")

cat("Eq2 phaseavg drop-one (outcome:", hr_outcome, ")\n\n")
print(eq2_out, row.names = FALSE)
cat("\nWrote:", eq2_csv, "\n")

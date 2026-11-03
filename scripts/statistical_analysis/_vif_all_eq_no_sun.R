# Counterfactual max VIF: current Eq1-7 fixed terms with ucm_SUN_Gh removed everywhere (HR reference).
file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
script_dir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg)) else "."
setwd(normalizePath(script_dir, winslash = "/", mustWork = TRUE))

run_h4_phaseavg <- function(...) invisible(NULL)
run_h4 <- function(...) invisible(NULL)
paper3_standardize_result_directory <- function(...) invisible(NULL)
source("Analysis_combined_phaseavg.R", local = FALSE)
H4_ANALYSIS_MODE <- "phaseavg"
source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
rm("H4_ANALYSIS_MODE", envir = .GlobalEnv)

audit <- read.csv(file.path(H4_RESULTS_ROOT, "Analysis_combined_timeseries",
  "Analysis_combined_timeseries_Multivariate_Filtration_Results.csv"), check.names = FALSE)
raw <- h4_apply_average_sources(h4_read_merged_analysis_data())
prepared <- h4_step4_exposure_prep(audit, raw)
raw_df <- prepared$raw_df
hr <- "empatica_heart_rate"
equations <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7)

drop_sun <- function(terms) terms[terms != "ucm_SUN_Gh"]

phaseavg_vif <- function(equation_id, fixed_terms) {
  eligibility <- setdiff(fixed_terms, H4_PHASE_SUM_COLS)
  data <- raw_df[, c("ParticipantID", "PhaseID", eligibility, hr)]
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
  md[, H4_PHASE_SUM_COLS] <- h4_phase_design(md$PhaseID)
  z_terms <- paste0(eligibility, "_phase_z")
  fixed <- as.formula(paste("Y ~", paste(c(z_terms, H4_PHASE_SUM_COLS), collapse = " + ")))
  design <- model.matrix(fixed, md)[, -1, drop = FALSE]
  vv <- h4_vif_per_term(design)
  list(max = max(vv), worst = names(vv)[which.max(vv)], n = nrow(md))
}

timeseries_vif <- function(equation_id) {
  terms_order <- drop_sun(h4_equation_term_order(equation_id))
  predictors <- setdiff(unique(unlist(strsplit(terms_order, ":", fixed = TRUE))), H4_PHASE_SUM_COLS)
  values <- as.matrix(raw_df[, c(predictors, hr), drop = FALSE])
  storage.mode(values) <- "double"
  ok <- rowSums(!is.finite(values)) == 0L
  eq <- prepared$catalog[prepared$catalog$equation_id == equation_id, ]
  z <- prepared$centered[ok, , drop = FALSE]
  phase_vec <- raw_df$PhaseID[ok]
  design <- prepared$make_design(z, prepared$thermal[[eq$heat_form]], phase_vec, test = eq$test,
    terms_order = terms_order)
  vv <- h4_vif_per_term(design)
  list(max = max(vv), worst = names(vv)[which.max(vv)], n = sum(ok))
}

rows <- lapply(seq_len(7L), function(id) {
  base <- H4_EQUATION_FIXED[[as.character(id)]]
  fixed <- drop_sun(base)
  pa <- phaseavg_vif(id, fixed)
  ts <- timeseries_vif(id)
  data.frame(
    equation_id = id,
    max_vif_timeseries_no_sun = round(ts$max, 2),
    worst_ts = ts$worst,
    n_ts = ts$n,
    max_vif_phaseavg_no_sun = round(pa$max, 2),
    worst_pa = pa$worst,
    n_pa = pa$n,
    stringsAsFactors = FALSE)
})
out <- do.call(rbind, rows)
print(out, row.names = FALSE)

source("library/Paper3_common.R")
paper3_attach_statistical_common()
assign("H4_VARIANT", "timeseries", .GlobalEnv)
source("H4_timeseries.R")
source("library/H4_core.R")
OUT_CSV <- file.path(OUT_DIR, h4_file("H4_Multivariate_Filtration_Results.csv"))
raw <- paper3_timeseries_attach_corridor_grid(h4_apply_average_sources(h4_read_merged_analysis_data()), PROJECT_ROOT)
fitters <- h4_bout_fitters()
job <- list(outcome = "empatica_heart_rate", equation_id = 1L)
cat("loading prep...\n")
prep <- tryCatch(h4_step4_exposure_prep(read.csv(OUT_CSV, check.names = FALSE), raw), error = function(e) { print(e); stop(e) })
cat("prep ok\n")
tryCatch({
  res <- local({
    fit_one <- function(job) {
      cat("fit_one start\n")
      y <- job$outcome
      eq_id <- job$equation_id
      raw_df <- prep$raw_df
      centered <- prep$centered
      natural_log_outcomes <- h4_study_spec$natural_log_outcome_names
      ok <- h4_complete_rows(raw_df, y, eq_id, natural_log_outcomes); cat("ok rows", sum(ok), "\n")
      outcome_matrix <- as.matrix(raw_df[, c(prep$selected, y), drop = FALSE])
      outcome_rows <- raw_df[ok, c("ParticipantID", "PhaseID", "Datetime"), drop = FALSE]
      stamp <- as.numeric(as.POSIXct(outcome_rows$Datetime, tz = "UTC"))
      bout <- interaction(outcome_rows$ParticipantID, outcome_rows$PhaseID, drop = TRUE)
      outcome_rows$Time10 <- as.integer(round((stamp - ave(stamp, bout, FUN = min)) / 10))
      centered_exposures <- centered[ok, , drop = FALSE]
      outcome_values <- outcome_matrix[ok, y]
      outcome_values <- PAPER3_APPLY_CSV_TRANSFORM(outcome_values, y)
      eq_row <- prep$catalog[prep$catalog$equation_id == eq_id, ]
      term_order <- h4_equation_term_order(eq_id)
      design <- prep$make_design(centered_exposures, prep$thermal[[eq_row$heat_form]], outcome_rows$PhaseID,
        test = eq_row$test, terms_order = setdiff(term_order, "grid_f")); cat("design ok\n")
      original_terms <- colnames(design)
      if ("grid_f" %in% term_order) original_terms <- c(original_terms, "grid_f")
      processed_terms <- vapply(strsplit(original_terms, ":", fixed = TRUE), function(parts) {
        paste(vapply(parts, function(p) {
          if (identical(p, "grid_f") || startsWith(p, "PhaseSum")) p else paste0(p, "_bout_z")
        }, character(1)), collapse = ":")
      }, character(1))
      safe_terms <- make.names(processed_terms, unique = TRUE)
      colnames(design) <- safe_terms
      cat("building model_data\n")
      model_data <- cbind(outcome_rows, Y = outcome_values, as.data.frame(design))
      cat("model_data base ok\n")
      if ("grid_f" %in% term_order) model_data$grid_f <- raw_df$grid_f[ok]
      cat("grid attached\n")
      cat("ncol model_data", ncol(model_data), "length safe_terms", length(safe_terms), "\n")
      cat("dup names", anyDuplicated(names(model_data)), "\n")
      fml <- reformulate(safe_terms, response = "Y")
      mm <- try(model.matrix(fml, model_data), silent = TRUE)
      if (inherits(mm, "try-error")) print(mm) else cat("mm ncol", ncol(mm), "\n")
      attempt <- fitters$do_fit_with_fallback(fml, model_data)
      cat("fit null?", is.null(attempt$fit), "\n")
      if (!is.null(attempt$fit)) cat("n coef", length(nlme::fixef(attempt$fit)), "\n")
      attempt
    }
    fit_one(job)
  })
}, error = function(e) {
  traceback()
  stop(e)
})

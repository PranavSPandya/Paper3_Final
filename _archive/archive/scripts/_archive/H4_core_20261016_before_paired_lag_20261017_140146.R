# H4 reusable statistics, model fitting and result tables.

h4_spell_term <- function(term) {
  pretty <- c(ucm_SND_dBA = "sound", SND_dBA = "sound", gvi_50m = "GVI", Clearness_Index = "clearness (excluded in Step 2 as derived)",
    lys_lux_avg = "lux", lys_kelvin_avg = "colour temperature", ucm_SUN_Gh = "global solar radiation", ucm_WIND_AWS = "apparent wind",
    ucm_AIR_temp = "air temperature", ucm_AIR_RH = "humidity",
    ucm_MRT = "mean radiant temperature", ucm_HUMIDEX = "HUMIDEX", ucm_PET = "PET", ucm_UTCI = "UTCI",
    atmo_pm1_avg = "PM1", atmo_pm2.5_avg = "PM2.5", atmo_pm10_avg = "PM10", SVF_Holmer = "SVF",
    setNames(paste("Phase:", c("WalkG", "WalkU", "BikeG", "BikeU"), "vs mean of phases"), paste0("PhaseSum", c("WalkG", "WalkU", "BikeG", "BikeU"))))
  parts <- strsplit(term, ":", fixed = TRUE)[[1]]
  parts <- ifelse(parts %in% names(pretty), pretty[parts], parts)
  if (length(parts) > 1L) paste0("(", parts[1], " x ", parts[2], ")") else parts
}

h4_phase_design <- function(phase) {
  phase <- factor(as.character(phase), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  if (anyNA(phase)) stop("Unknown or missing H4 PhaseID")
  design <- stats::model.matrix(~ phase, contrasts.arg = list(phase = stats::contr.sum(4L)))[, -1L, drop = FALSE]
  colnames(design) <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
  design
}

h4_phase_contrast_weights <- function() {
  # Equal weighting of the two modes/environments, not observed row frequencies.
  w <- rbind(Urban_minus_Green = c(-.5, .5, -.5, .5), Urban_minus_Green_Walk = c(-1, 1, 0, 0), Urban_minus_Green_Bike = c(0, 0, -1, 1),
             Bike_minus_Walk = c(-.5, -.5, .5, .5), Mode_by_Environment = c(1, -1, -1, 1))
  w %*% h4_phase_design(c("WalkG", "WalkU", "BikeG", "BikeU"))
}

h4_phase_contrasts <- function(fit, cluster) {
  beta <- nlme::fixef(fit)
  weights <- h4_phase_contrast_weights()
  V <- clubSandwich::vcovCR(fit, cluster = cluster, type = "CR2")
  do.call(rbind, lapply(seq_len(nrow(weights)), function(i) {
    L <- matrix(0, 1L, length(beta), dimnames = list(NULL, names(beta)))
    if (!all(colnames(weights) %in% names(beta))) stop("Phase contrasts do not match model coefficients")
    L[1L, colnames(weights)] <- weights[i, ]
    test <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
    estimate <- as.numeric(L %*% beta)
    se <- sqrt(as.numeric(L %*% V %*% t(L)))
    df <- as.numeric(test$df_denom)
    if (!is.finite(df) || df <= 0 || !is.finite(se)) stop("Invalid phase-contrast CR2 inference")
    data.frame(contrast = rownames(weights)[i], estimate = estimate, se = se, df = df, low_df_flag = df < 4,
               ci_low = estimate - stats::qt(.975, df) * se, ci_high = estimate + stats::qt(.975, df) * se, p_value = as.numeric(test$p_val), stringsAsFactors = FALSE)
  }))
}

h4_fit <- function(prepared_data, design_checks) {
  suppressPackageStartupMessages({
    library(nlme)
    library(clubSandwich)
    library(parallel)
  })
  model_directory <- file.path(OUT_DIR, "H4_models")
  dir.create(model_directory, recursive = TRUE, showWarnings = FALSE)
  # Archive pre-existing items (except earlier _archive_* folders) so the folder only holds this run's outputs.
  old_items <- grep("^_archive_", list.files(model_directory, all.files = TRUE, no.. = TRUE), value = TRUE, invert = TRUE)
  h4_archive(file.path(model_directory, old_items), file.path(model_directory, paste0("_archive_", format(Sys.time(), "%Y%m%d_%H%M%S"))))
  specification_file <- tempfile(fileext = ".rds")
  saveRDS(H4_SPEC, specification_file, version = 2L, compress = FALSE)
  source_checksums <- h4_file_checksums(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV, specification_file))
  if (!identical(source_checksums[1:2], H4_START_MD5)) stop("Script or input changed since startup; no models run from inconsistent sources")
  names(source_checksums) <- c("code_md5", "input_md5", "audit_md5", "spec_md5")
  unlink(specification_file)
  raw_data <- prepared_data$raw_df
  thermal <- prepared_data$thermal
  centered <- prepared_data$centered
  centered_lag60 <- prepared_data$centered_lag60
  make_design <- prepared_data$make_design
  catalog <- prepared_data$catalog
  agreed_common <- prepared_data$agreed_common
  if (nrow(catalog) != 7L || !identical(catalog$equation_id, 1:7)) stop("Expected equations 1 through 7")

  outcomes <- H4_SPEC$all_outcomes
  hrv_log <- hrv_log_outcomes()
  model_template <- Eq1
  for (equation_id in 2:7) {
    other_template <- get(paste0("Eq", equation_id), envir = .GlobalEnv)
    if (!identical(as.list(model_template)[c("random", "correlation", "method", "na.action")],
                   as.list(other_template)[c("random", "correlation", "method", "na.action")]))
      stop("Equations must use the same random effects, residual correlation, fitting method and missing-data rule")
  }
  nested <- eval(model_template$random)
  ar1 <- function() eval(model_template$correlation)
  # Rule: refit with ARMA(2,0) per bout when the primary AR(1) rho > 0.95; otherwise keep AR(1).
  arma2 <- function() nlme::corARMA(c(0.5, 0.2), form = ~ Time10 | ParticipantID / PhaseID, p = 2, q = 0)
  # nlminb and optim are the two R optimization methods supported by nlme.
  fit_lme <- function(model_formula, model_data, random, correlation, record_message, optimizers = c("nlminb", "optim")) {
    for (optimizer in optimizers) {
      fit <- tryCatch(withCallingHandlers(
        {
          model_call <- model_template
          model_call[[2L]] <- quote(model_formula)
          model_call$data <- quote(model_data)
          model_call$random <- quote(random)
          model_call$correlation <- quote(correlation)
          model_call$control <- quote(nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = optimizer))
          eval(model_call)
        },
        warning = function(w) record_message(optimizer, "warning", conditionMessage(w))),
        error = function(e) { record_message(optimizer, "error", conditionMessage(e)); NULL })
      if (!is.null(fit)) return(fit)
    }
    NULL
  }
  # Both AR1 optimizers before the sensitivity-only independent fallback.
  do_fit_with_fallback <- function(model_formula, model_data) {
    messages <- character()
    logger <- function(label) function(optimizer, kind, msg) messages <<- c(messages, sprintf("%s %s: %s", if (is.null(label)) optimizer else label, kind, msg))
    fit <- fit_lme(model_formula, model_data, nested, ar1(), logger(NULL))
    structure <- "AR1"
    corfun <- ar1
    if (!is.null(fit)) {
      rho <- tryCatch(as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)
      if (length(rho) == 1L && is.finite(rho) && rho > 0.95) {
        fit2 <- fit_lme(model_formula, model_data, nested, arma2(), logger("ARMA(2,0)"))
        if (is.null(fit2)) messages <- c(messages, sprintf("AR(1) rho = %.4f > 0.95 but ARMA(2,0) failed; AR(1) kept", rho)) else {
          fit <- fit2; structure <- "ARMA20"; corfun <- arma2
          messages <- c(messages, sprintf("ARMA(2,0) used: AR(1) rho = %.4f > 0.95", rho))
        }
      }
    }
    if (is.null(fit)) {
      fit <- fit_lme(model_formula, model_data, nested, NULL, logger("uncorrelated"), optimizers = "nlminb")
      structure <- "independent_fallback"
      corfun <- function() NULL
      if (!is.null(fit)) messages <- c(messages, "Fallback: AR(1) failed; fitted independent residual covariance (sensitivity-only fit)")
    }
    list(fit = fit, note = paste(messages, collapse = "; "), residual_structure = if (is.null(fit)) "not_fitted" else structure, corfun = corfun)
  }

  fit_equation_ids <- catalog$equation_id
  if (!isTRUE(H4_SPEC$fit_sound_sensitivity)) {
    fit_equation_ids <- fit_equation_ids[catalog$role[match(fit_equation_ids, catalog$equation_id)] != "sound_sensitivity"]
  }
  # Outcome-specific redundancy audit before fitting; a rank-deficient design blocks fitting (no predictor removal).
  if (nrow(design_checks) != length(outcomes) * length(fit_equation_ids) ||
      !setequal(unique(design_checks$equation_id), fit_equation_ids) ||
      !setequal(unique(design_checks$outcome), outcomes)) stop("Design checks do not cover every requested outcome and equation")
  design_checks_file <- file.path(model_directory, "H4_design_redundancy_by_outcome.csv")
  utils::write.csv(design_checks, design_checks_file, row.names = FALSE, na = "")
  if (any(!design_checks$passes_check)) stop(sprintf("Step 5 rank-deficiency blocked fitting for %d outcome-equation designs. Review %s; GVIF/VIF flags alone do not remove predictors.",
    sum(!design_checks$passes_check), design_checks_file), call. = FALSE)
  fit_outcome_equation <- function(job) {
    outcome <- job$outcome
    fit_equation_ids <- job$equation_id
    if (length(fit_equation_ids) != 1L) stop("Each fitting job must contain one equation")
    ok <- h4_complete_rows(raw_data, outcome, fit_equation_ids, hrv_log)
    outcome_rows <- raw_data[ok, c("ParticipantID", "PhaseID", "Datetime"), drop = FALSE]
    outcome_rows$ParticipantID <- factor(outcome_rows$ParticipantID)
    outcome_rows$PhaseID <- factor(outcome_rows$PhaseID, levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
    stamp <- as.numeric(as.POSIXct(outcome_rows$Datetime, tz = "UTC"))
    bout <- interaction(outcome_rows$ParticipantID, outcome_rows$PhaseID, drop = TRUE)
    outcome_rows$Time10 <- as.integer(round((stamp - ave(stamp, bout, FUN = min)) / 10))
    if (any(!is.finite(stamp)) || anyDuplicated(outcome_rows[, c("ParticipantID", "PhaseID", "Time10")]))
      stop("Invalid/duplicate timestamps for outcome: ", outcome)
    centered_exposures <- centered[ok, , drop = FALSE]
    lagged_exposures <- centered_lag60[ok, , drop = FALSE]
    outcome_values <- raw_data[[outcome]][ok]
    transformation <- "native"
    if (outcome %in% hrv_log) {
      keep <- is.finite(outcome_values) & outcome_values > 0
      outcome_rows <- outcome_rows[keep, , drop = FALSE]
      centered_exposures <- centered_exposures[keep, , drop = FALSE]
      lagged_exposures <- lagged_exposures[keep, , drop = FALSE]
      # natural log (ln) applied here for hrv_log columns (not log1p)
      outcome_values <- log(outcome_values[keep])
      transformation <- H4_SPEC$outcome_transform[[outcome]]
    }
    h4_fit_equations(fit_equation_ids, outcome, catalog, thermal, make_design,
      centered_exposures, lagged_exposures, outcome_rows, outcome_values, transformation,
      raw_data, agreed_common, do_fit_with_fallback, fit_lme, nested)
  }
  cat(sprintf("[Step 5] Fitting %d equations across %d outcomes in parallel...\n", length(fit_equation_ids), length(outcomes)))
  workers <- min(length(fit_equation_ids), max(1L, parallel::detectCores() - 2L))
  jobs <- unlist(lapply(outcomes, function(outcome) lapply(fit_equation_ids, function(eid) list(outcome = outcome, equation_id = eid))), recursive = FALSE)
  cat(sprintf("[Parallel] %d workers; %d individual outcome-equation jobs; one job per dispatch.\n", workers, length(jobs)))
  worker_cluster <- parallel::makeCluster(workers)
  on.exit(if (!is.null(worker_cluster)) parallel::stopCluster(worker_cluster), add = TRUE)
  parallel::clusterEvalQ(worker_cluster, { library(nlme); library(clubSandwich); NULL })
  parallel::clusterExport(worker_cluster, c("raw_data", "centered", "centered_lag60", "arma2", "thermal",
                                "outcomes", "hrv_log", "catalog", "fit_equation_ids",
                                "make_design", "do_fit_with_fallback", "fit_lme", "nested", "ar1", "model_template", "h4_spell_term", "agreed_common"), envir = environment())
  h4_cluster_globals <- lag_se(envir = .GlobalEnv, pattern = "^(h4_|H4_)", all.names = TRUE)
  parallel::clusterExport(worker_cluster, c(h4_cluster_globals, "hrv_log_outcomes", "hrv_fd_outcomes", "equation_spec"), envir = .GlobalEnv)
  fit_results <- parallel::parLapplyLB(worker_cluster, jobs, fit_outcome_equation, chunk.size = 1L)
  parallel::stopCluster(worker_cluster)
  worker_cluster <- NULL
  attr(fit_results, "fingerprints") <- source_checksums
  saveRDS(fit_results, file.path(model_directory, "H4_fit_records.rds"))
  h4_publish_fits(fit_results, source_checksums, model_directory, outcomes, fit_equation_ids,
    catalog)
}

h4_fit_equations <- function(fit_equation_ids, outcome, catalog, thermal, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, transformation,
    raw_data, agreed_common, do_fit_with_fallback, fit_lme, nested) {
  coefficient_rows <- contrast_rows <- status_rows <- sensitivity_rows <- lag_rows <- list()
  status_row <- function(success, converged, structure, note, residual_sd = NA_real_, ar1_rho = NA_real_,
                         lag1_normalized = NA_real_, n_adjacent = 0L, residual_skew = NA_real_, residual_excess_kurtosis = NA_real_,
                         boundary_variance = NA, high_ar1_flag = NA, min_cr2_df = NA_real_, min_cr2_df_heat = NA_real_)
    data.frame(equation_id = equation_id, heat_form = heat_representation, block = analysis_block, outcome = outcome,
      success = success, n = nrow(model_data), n_participants = nlevels(model_data$ParticipantID),
      transformation = transformation, converged = converged, residual_structure = structure, residual_sd = residual_sd,
      ar1_rho = ar1_rho, lag1_normalized = lag1_normalized, n_adjacent = n_adjacent,
      residual_skew = residual_skew, residual_excess_kurtosis = residual_excess_kurtosis,
      boundary_variance = boundary_variance, high_ar1_flag = high_ar1_flag, min_cr2_df = min_cr2_df, min_cr2_df_heat = min_cr2_df_heat,
      participant_ids = paste(sort(unique(as.character(model_data$ParticipantID))), collapse = ";"),
      n_available_outcome = sum(is.finite(raw_data[[outcome]])), n_removed = nrow(raw_data) - nrow(model_data),
      note = note, stringsAsFactors = FALSE)
  coef_frame <- function(term, est, se, df, p = 2 * pt(-abs(est / se), df), note = "")
    data.frame(equation_id = equation_id, heat_form = heat_representation, block = analysis_block, outcome = outcome, term = term, estimate = est, se = se, df = df,
      residual_structure = attempt$residual_structure, ci_low = est - qt(0.975, df) * se, ci_high = est + qt(0.975, df) * se,
      t_stat = est / se, p_value = p, q_value = NA_real_, low_df_flag = is.finite(df) & df < 4, term_note = note, stringsAsFactors = FALSE)
  for (equation_id in fit_equation_ids) {
    equation <- catalog[catalog$equation_id == equation_id, ]
    heat_representation <- equation$heat_form
    analysis_block <- equation$block
    design <- make_design(centered_exposures, thermal[[heat_representation]], outcome_rows$PhaseID, test = equation$test,
      terms_order = h4_equation_term_order(equation_id))
    original_terms <- colnames(design)
    safe_terms <- make.names(original_terms, unique = TRUE)
    colnames(design) <- safe_terms
    model_data <- cbind(outcome_rows, Y = outcome_values, as.data.frame(design))
    model_data <- model_data[order(model_data$ParticipantID, model_data$PhaseID, model_data$Time10), ]
    model_formula <- reformulate(safe_terms, response = "Y")
    attempt <- do_fit_with_fallback(model_formula, model_data)
    fit <- attempt$fit
    if (is.null(fit)) {
      status_rows[[length(status_rows) + 1]] <- status_row(FALSE, FALSE, "not_fitted",
        paste("AR1 and independent-residual fits failed:", attempt$note))
      next
    }
    cr2_messages <- character()
    robust <- tryCatch(withCallingHandlers({
      result <- clubSandwich::coef_test(fit, vcov = "CR2", cluster = model_data$ParticipantID, test = "Satterthwaite")
      if (!isTRUE(all.equal(as.numeric(result$beta), as.numeric(nlme::fixef(fit)), tolerance = 1e-8)))
        stop("CR2 coefficient order does not match fixed effects")
      result
    }, warning = function(w) cr2_messages <<- c(cr2_messages, conditionMessage(w))),
      error = function(e) { cr2_messages <<- c(cr2_messages, conditionMessage(e)); NULL })
    if (is.null(robust)) {
      status_rows[[length(status_rows) + 1]] <- status_row(FALSE, TRUE, attempt$residual_structure,
        paste("CR2 estimation failed:", attempt$note, paste(cr2_messages, collapse = "; ")))
      next
    }
    normalized_residuals <- tryCatch(residuals(fit, level = 2, type = "normalized"), error = function(e) NULL)
    participant_phase <- interaction(model_data$ParticipantID, model_data$PhaseID, drop = TRUE)
    adjacent_rows <- which(as.character(participant_phase[-1]) == as.character(participant_phase[-length(participant_phase)]) & abs(diff(model_data$Time10) - 1) < 1e-6)
    lag1 <- if (!is.null(normalized_residuals) && length(adjacent_rows) > 2) stats::cor(normalized_residuals[adjacent_rows], normalized_residuals[adjacent_rows + 1L]) else NA_real_
    rho <- tryCatch(as.numeric(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)
    if (length(rho) != 1L) rho <- NA_real_
    centered_normalized_residuals <- if (!is.null(normalized_residuals)) normalized_residuals - mean(normalized_residuals) else NULL
    rms <- if (!is.null(centered_normalized_residuals)) sqrt(mean(centered_normalized_residuals^2)) else NA_real_
    residual_skewness <- if (!is.null(centered_normalized_residuals) && rms > 0) mean((centered_normalized_residuals / rms)^3) else NA_real_
    residual_kurtosis <- if (!is.null(centered_normalized_residuals) && rms > 0) mean((centered_normalized_residuals / rms)^4) - 3 else NA_real_
    variance_text <- nlme::VarCorr(fit)[, "Variance"]
    random_var <- as.numeric(variance_text[grepl("^[0-9.+eE-]+$", variance_text)])
    boundary <- any(random_var[is.finite(random_var)] < 1e-6 * sigma(fit)^2)
    high_ar1 <- is.finite(rho) & rho > 0.95
    # low_df_flag: CR2/Satterthwaite df < 4 make t tests unreliable (Tipton 2015; Pustejovsky & Tipton 2018); flagged, never dropped.
    coefficient_results <- coef_frame(c("Intercept", original_terms), robust$beta, robust$SE, robust$df_Satt)
    # Under contr.sum(4) the fourth phase deviation is exactly PhaseSumBikeU = -(WalkG + WalkU + BikeG).
    phase_cols <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
    if (all(phase_cols %in% original_terms)) {
      bikeu <- tryCatch({
        V <- clubSandwich::vcovCR(fit, cluster = model_data$ParticipantID, type = "CR2")
        L <- matrix(0, 1L, length(nlme::fixef(fit)), dimnames = list(NULL, names(nlme::fixef(fit))))
        L[1L, phase_cols] <- -1
        wt <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
        list(as.numeric(L %*% nlme::fixef(fit)), sqrt(as.numeric(L %*% V %*% t(L))), as.numeric(wt$df_denom), as.numeric(wt$p_val), NULL)
      }, error = function(e) list(NA_real_, NA_real_, NA_real_, NA_real_, paste("BikeU contrast failed:", conditionMessage(e))))
      pos <- match("PhaseSumBikeG", coefficient_results$term)
      coefficient_results <- rbind(coefficient_results[seq_len(pos), ], coef_frame("PhaseSumBikeU", bikeu[[1]], bikeu[[2]], bikeu[[3]], bikeu[[4]],
        paste(c("Derived contrast (BikeU = -(WalkG + WalkU + BikeG)); reported only, excluded from all FDR families", bikeu[[5]]), collapse = "; ")),
        coefficient_results[-seq_len(pos), ])
      rownames(coefficient_results) <- NULL
    }
    coefficient_results$term_category <- "Nonthermal_Covariate"
    coefficient_results$term_category[coefficient_results$term == "Intercept"] <- "Intercept"
    coefficient_results$term_category[startsWith(coefficient_results$term, "Phase")] <- "Phase_Condition"
    coefficient_results$term_category[coefficient_results$term %in% thermal[[heat_representation]]] <- "Heat_Main_Effect"
    sound_ix <- grepl(":", coefficient_results$term, fixed = TRUE) & grepl("ucm_SND_dBA", coefficient_results$term, fixed = TRUE)
    coefficient_results$term_category[sound_ix] <- "Thermal_x_Sound"
    coefficient_results$term_category[grepl(":PhaseSum", coefficient_results$term, fixed = TRUE)] <- "Thermal_x_Phase"
    # Candidate terms are specified before outcome fits; no significance-based or PCA selection.
    coefficient_results$selection_status <- ifelse(coefficient_results$term == "Intercept", "intercept",
      ifelse(coefficient_results$term_category == "Nonthermal_Covariate" & !(coefficient_results$term %in% agreed_common),
             "retained_candidate", "specified_term"))
    coef_non_int <- coefficient_results[coefficient_results$term != "Intercept", ]
    min_df <- if (nrow(coef_non_int) > 0) min(coef_non_int$df, na.rm = TRUE) else NA_real_
    heat_only <- coef_non_int[coef_non_int$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound", "Thermal_x_Phase"), ]
    min_df_heat <- if (nrow(heat_only) > 0) min(heat_only$df, na.rm = TRUE) else NA_real_
    status_rows[[length(status_rows) + 1]] <- status_row(TRUE, TRUE, attempt$residual_structure,
      paste(if (identical(attempt$residual_structure, "independent_fallback")) "INDEPENDENT-RESIDUAL FALLBACK (not equivalent to AR1)" else paste(attempt$residual_structure, "fit completed"),
            attempt$note, paste(cr2_messages, collapse = "; "), sep = "; "),
      residual_sd = sigma(fit), ar1_rho = rho, lag1_normalized = lag1, n_adjacent = length(adjacent_rows),
      residual_skew = residual_skewness, residual_excess_kurtosis = residual_kurtosis, boundary_variance = boundary, high_ar1_flag = high_ar1,
      min_cr2_df = min_df, min_cr2_df_heat = min_df_heat)
    coefficient_rows[[length(coefficient_rows) + 1]] <- coefficient_results
    contrast_messages <- character()
    phase_tests <- tryCatch(withCallingHandlers(h4_phase_contrasts(fit, model_data$ParticipantID),
      warning = function(w) contrast_messages <<- c(contrast_messages, conditionMessage(w))),
      error = function(e) { contrast_messages <<- c(contrast_messages, conditionMessage(e)); NULL })
    if (is.null(phase_tests)) phase_tests <- data.frame(contrast = rownames(h4_phase_contrast_weights()), estimate = NA_real_,
      se = NA_real_, df = NA_real_, low_df_flag = NA, ci_low = NA_real_, ci_high = NA_real_, p_value = NA_real_)
    contrast_rows[[length(contrast_rows) + 1L]] <- cbind(phase_tests, outcome = outcome, residual_structure = attempt$residual_structure,
      equation_id = equation_id, note = paste(contrast_messages, collapse = "; "), stringsAsFactors = FALSE)
    sensitivity_result <- h4_sensitivity_rows(coefficient_results, attempt, boundary, high_ar1, fit_lme, model_formula, model_data,
      original_terms, safe_terms, nested, equation_id, heat_representation, analysis_block, outcome)
    if (!is.null(sensitivity_result)) sensitivity_rows[[length(sensitivity_rows) + 1L]] <- sensitivity_result

    lag_result <- h4_lag60_rows(coefficient_results, attempt, fit_lme, model_formula, nested, make_design,
      centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
      equation, original_terms, safe_terms, equation_id, outcome)
    if (!is.null(lag_result)) lag_rows[[length(lag_rows) + 1L]] <- lag_result

  }
  list(
    coef = if (length(coefficient_rows)) do.call(rbind, coefficient_rows) else NULL,
    status = if (length(status_rows)) do.call(rbind, status_rows) else NULL,
    contrasts = if (length(contrast_rows)) do.call(rbind, contrast_rows) else NULL,
    sensitivity = if (length(sensitivity_rows)) do.call(rbind, sensitivity_rows) else NULL,
    lag60 = if (length(lag_rows)) do.call(rbind, lag_rows) else NULL
  )
}

h4_publish_fits <- function(fit_results, source_checksums, model_directory, outcomes, fit_equation_ids,
    catalog) {
  coefficients <- do.call(rbind, lapply(fit_results, `[[`, "coef"))
  fit_status <- do.call(rbind, lapply(fit_results, `[[`, "status"))
  if (nrow(fit_status) != length(outcomes) * length(fit_equation_ids) ||
      anyDuplicated(fit_status[, c("outcome", "equation_id")])) stop("Missing or duplicated outcome-equation fit records")
  if (is.null(coefficients) || !nrow(coefficients)) stop("All fits failed; existing published outputs preserved")
  contrast_all <- do.call(rbind, lapply(fit_results, `[[`, "contrasts"))
  contrast_grid <- expand.grid(outcome = outcomes, equation_id = fit_equation_ids,
                              contrast = rownames(h4_phase_contrast_weights()), stringsAsFactors = FALSE)
  if (is.null(contrast_all)) stop("No phase-contrast records returned")
  if (anyDuplicated(contrast_all[, c("outcome", "equation_id", "contrast")])) stop("Duplicated phase-contrast records")
  contrast_all <- merge(contrast_grid, contrast_all, by = c("outcome", "equation_id", "contrast"), all.x = TRUE)
  contrast_all$note[is.na(contrast_all$note)] <- "Model failed; contrast not estimable (see H4_fit_status.csv)"
  # Phase/design contrasts are diagnostics, not members of the H4 exposure-test family.
  contrast_all$fdr_note <- "not tested: phase/design contrast"
  contrast_all$q_value <- NA_real_
  covariance_results <- do.call(rbind, lapply(fit_results, `[[`, "sensitivity"))
  lag_results <- do.call(rbind, lapply(fit_results, `[[`, "lag60"))
  if (!is.null(lag_results)) {
    # Separate exploratory family: BH per equation x term across outcomes; never merged into the primary q.
    lag_results$q_lag60 <- NA_real_
    for (k in unique(paste(lag_results$equation_id, lag_results$term))) {
      idx <- which(paste(lag_results$equation_id, lag_results$term) == k & lag_results$inference_eligible & is.finite(lag_results$p_value))
      if (length(idx)) lag_results$q_lag60[idx] <- p.adjust(lag_results$p_value[idx], "BH", n = length(outcomes))
    }
    utils::write.csv(lag_results, file.path(model_directory, "H4_lag60_sensitivity.csv"), row.names = FALSE, na = "")
  }
  if (is.null(covariance_results)) stop("No covariance sensitivity records returned")
  # BH correction within each equation and thermal term, across all declared outcomes.
  thermal_categories <- c("Heat_Main_Effect", "Thermal_x_Sound")
  status_index <- match(paste(coefficients$equation_id, coefficients$outcome), paste(fit_status$equation_id, fit_status$outcome))
  if (anyNA(status_index)) stop("Coefficients have no matching fit-status record")
  unresolved_ar1 <- fit_status$high_ar1_flag[status_index] %in% TRUE
  is_correlated_fit <- coefficients$residual_structure %in% c("AR1", "ARMA20") & !unresolved_ar1
  number_of_outcomes <- length(outcomes)
  coefficients$q_term <- NA_real_
  for (k in unique(paste(coefficients$equation_id, coefficients$term))) {
    idx <- which(paste(coefficients$equation_id, coefficients$term) == k & coefficients$term != "PhaseSumBikeU" & is_correlated_fit & is.finite(coefficients$p_value) &
                 coefficients$term_category %in% c(thermal_categories, "Thermal_x_Phase"))
    if (length(idx) > number_of_outcomes) stop("FDR family contains more tests than outcomes")
    if (length(idx)) coefficients$q_term[idx] <- p.adjust(coefficients$p_value[idx], method = "BH", n = number_of_outcomes)
  }
  coefficients$fdr_family <- ifelse(is.finite(coefficients$q_term) & coefficients$term_category %in% thermal_categories, "thermal_per_term", "other")

  equation_counts <- split(fit_status$success, factor(fit_status$equation_id, levels = catalog$equation_id))
  catalog$attempted <- as.integer(lengths(equation_counts))
  catalog$succeeded <- as.integer(vapply(equation_counts, sum, integer(1)))
  catalog$failed <- catalog$attempted - catalog$succeeded
  catalog$fitted <- catalog$succeeded > 0L
  catalog[c("code_md5", "input_md5")] <- as.list(source_checksums[c("code_md5", "input_md5")])
  fit_status[names(source_checksums)] <- as.list(source_checksums)
  covariance_results[names(source_checksums)] <- as.list(source_checksums)
  # covariance_robust = FALSE if any alternative estimate lies outside the primary 95% CI, CIs do not overlap or the sign flips;
  # NA without a successful refit. alt_* report the independent-residual refit (else the boundary refit).
  coefficients <- h4_merge_covariance_sensitivity(coefficients, covariance_results)
  # Simplified main table: one q (per-term BH across outcomes; thermal rows only) and one term_type.
  is_thermal <- coefficients$term_category %in% c(thermal_categories, "Thermal_x_Phase")
  coefficient_table <- data.frame(equation = coefficients$heat_form, outcome = coefficients$outcome,
    term = sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", coefficients$term),
    term_type = ifelse(coefficients$term == "Intercept", "intercept", ifelse(startsWith(coefficients$term, "PhaseSum"), "phase (study design)",
      ifelse(is_thermal, "thermal exposure", "covariate"))),
    Beta = coefficients$estimate, ci_low = coefficients$ci_low, ci_high = coefficients$ci_high, p = ifelse(is_correlated_fit, coefficients$p_value, NA_real_),
    df = coefficients$df, low_df_flag = coefficients$low_df_flag,
    q = coefficients$q_term, FDR_significant = ifelse(is.na(coefficients$q_term), NA, coefficients$q_term < 0.05),
    covariance_robust = coefficients$covariance_robust, residual_structure = coefficients$residual_structure, stringsAsFactors = FALSE)
  hypothesis_table <- coefficient_table[is_thermal, ]
  if (!identical(h4_file_checksums(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV)),
                 as.character(source_checksums[c("code_md5", "input_md5", "audit_md5")])))
    stop("Script, input or audit changed during fitting; results not saved")
  tables <- list(H4_equations.csv = catalog, H4_fit_status.csv = fit_status,
    H4_coefficients.csv = coefficient_table, H4_hypothesis.csv = hypothesis_table,
    H4_phase_contrasts.csv = transform(setNames(contrast_all, sub("^estimate$", "Beta", sub("^q_value$", "q", names(contrast_all)))),
      FDR_significant = ifelse(is.na(q), NA, q < 0.05)),
    H4_covariance_sensitivity.csv = covariance_results)
  for (name in names(tables)) write.csv(tables[[name]], file.path(model_directory, name), row.names = FALSE, na = "")
  invisible(list(h4 = list(catalog = catalog, status = fit_status, coef = coefficients,
    export = coefficient_table, hypothesis = hypothesis_table)))
}

h4_sensitivity_rows <- function(coefficient_results, attempt, boundary, high_ar1, fit_lme, model_formula, model_data,
    original_terms, safe_terms, nested, equation_id, heat_representation, analysis_block, outcome) {
  sensitivity_rows <- list()
  # Both covariance checks use the same fitting and coefficient-comparison code.
  thermal_rows <- which(coefficient_results$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound"))
  sensitivity_specs <- list()
  if (isTRUE(boundary)) sensitivity_specs$boundary <- list(
    flag = "boundary_variance", name = "random_intercept_participant_only_AR1",
    random = ~ 1 | ParticipantID, correlation = attempt$corfun())
  # Every AR1 fit gets an independent-residual comparison, including rho <= 0.95.
  if (isTRUE(high_ar1) || attempt$residual_structure %in% c("AR1", "ARMA20")) sensitivity_specs$independent <- list(
    flag = if (isTRUE(high_ar1)) "high_ar1" else "routine_independent_refit",
    name = "independent_residuals_nested_random_CR2",
    random = nested, correlation = NULL)
  if (length(thermal_rows)) for (specification in sensitivity_specs) {
    sensitivity_messages <- character()
    alternative_fit <- fit_lme(model_formula, model_data, specification$random, specification$correlation, function(optimizer, kind, msg)
      sensitivity_messages <<- c(sensitivity_messages, if (kind == "error") paste0(optimizer, ": ", msg) else msg))
    alternative_test <- if (!is.null(alternative_fit)) {
      tryCatch(clubSandwich::coef_test(alternative_fit, vcov = "CR2", cluster = model_data$ParticipantID, test = "Satterthwaite"),
               error = function(e) { sensitivity_messages <<- c(sensitivity_messages, paste("CR2:", conditionMessage(e))); NULL })
    } else NULL
    for (term_index in thermal_rows) {
      term_name <- coefficient_results$term[term_index]
      primary_estimate <- coefficient_results$estimate[term_index]
      alternative_row <- integer(0)
      k <- match(term_name, original_terms)
      if (!is.null(alternative_test) && !is.na(k)) {
        rn_match <- which(rownames(alternative_test) == safe_terms[k])
        if (length(rn_match) == 1L) alternative_row <- rn_match else if (k + 1L <= nrow(alternative_test)) alternative_row <- k + 1L
      }
      alternative_estimate <- alternative_se <- alternative_df <- alternative_ci_low <- alternative_ci_high <- alternative_p <- NA_real_
      sensitivity_status <- if (is.null(alternative_fit)) paste("fit_failed:", paste(sensitivity_messages, collapse = "; ")) else "cr2_failed"
      if (length(alternative_row) == 1L) {
        alternative_estimate <- as.numeric(alternative_test$beta[alternative_row])
        alternative_se <- as.numeric(alternative_test$SE[alternative_row])
        alternative_df <- as.numeric(alternative_test$df_Satt[alternative_row])
        alternative_ci_low <- alternative_estimate - qt(0.975, alternative_df) * alternative_se
        alternative_ci_high <- alternative_estimate + qt(0.975, alternative_df) * alternative_se
        alternative_p <- as.numeric(alternative_test[["p_Satt"]][alternative_row])
        sensitivity_status <- "success"
      }
      sensitivity_rows[[length(sensitivity_rows) + 1L]] <- data.frame(
        equation_id = equation_id, heat_form = heat_representation, block = analysis_block, outcome = outcome,
        diagnostic_flag = specification$flag,
        sensitivity_specification = specification$name,
        term = term_name, term_category = coefficient_results$term_category[term_index],
        primary_estimate = primary_estimate, primary_se = coefficient_results$se[term_index], primary_df = coefficient_results$df[term_index],
        primary_ci_low = coefficient_results$ci_low[term_index], primary_ci_high = coefficient_results$ci_high[term_index], primary_p_value = coefficient_results$p_value[term_index],
        alt_estimate = alternative_estimate, alt_se = alternative_se, alt_df = alternative_df,
        alt_ci_low = alternative_ci_low, alt_ci_high = alternative_ci_high, alt_p_value = alternative_p,
        estimate_diff = alternative_estimate - primary_estimate, estimate_rel_diff_pct = if (is.finite(alternative_estimate) && abs(primary_estimate) > 1e-12) 100 * (alternative_estimate - primary_estimate) / abs(primary_estimate) else NA_real_,
        ci_overlap = if (is.finite(alternative_estimate)) (coefficient_results$ci_low[term_index] <= alternative_ci_high) && (alternative_ci_low <= coefficient_results$ci_high[term_index]) else NA,
        sensitivity_status = sensitivity_status, stringsAsFactors = FALSE)
    }
  }
  if (length(sensitivity_rows)) do.call(rbind, sensitivity_rows) else NULL
}

h4_lag60_rows <- function(coefficient_results, attempt, fit_lme, model_formula, nested, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
    equation, original_terms, safe_terms, equation_id, outcome) {
  lag_rows <- list()
  # 60-s lag sensitivity: heat terms (and heat x sound) use exposure 60 s earlier; same covariance as primary; own FDR family.
  heat_vars <- thermal[[heat_representation]]
  lagged_vars <- unique(heat_vars)
  lag_ok <- stats::complete.cases(lagged_exposures[, lagged_vars, drop = FALSE])
  lag_mix_exposures <- centered_exposures[lag_ok, , drop = FALSE]
  lag_mix_exposures[, lagged_vars] <- lagged_exposures[lag_ok, lagged_vars, drop = FALSE]
  lag_design <- make_design(lag_mix_exposures, heat_vars, outcome_rows$PhaseID[lag_ok], test = equation$test,
    terms_order = h4_equation_term_order(equation_id))
  colnames(lag_design) <- make.names(colnames(lag_design), unique = TRUE)
  lag_model_data <- cbind(outcome_rows[lag_ok, , drop = FALSE], Y = outcome_values[lag_ok], as.data.frame(lag_design))
  lag_model_data <- lag_model_data[order(lag_model_data$ParticipantID, lag_model_data$PhaseID, lag_model_data$Time10), ]
  lag_msg <- character()
  lag_fit <- fit_lme(model_formula, lag_model_data, nested, attempt$corfun(), function(optimizer, kind, msg) lag_msg <<- c(lag_msg, paste(optimizer, kind, msg)))
  lag_robust <- if (!is.null(lag_fit)) tryCatch(clubSandwich::coef_test(lag_fit, vcov = "CR2", cluster = lag_model_data$ParticipantID, test = "Satterthwaite"),
    error = function(e) { lag_msg <<- c(lag_msg, conditionMessage(e)); NULL }) else NULL
  lag_rho <- if (!is.null(lag_fit) && identical(attempt$residual_structure, "AR1")) as.numeric(coef(lag_fit$modelStruct$corStruct, unconstrained = FALSE)) else NA_real_
  lag_reportable <- !is.null(lag_robust) && attempt$residual_structure %in% c("AR1", "ARMA20") &&
    !(length(lag_rho) == 1L && is.finite(lag_rho) && lag_rho > .95)
  for (term_index in which(coefficient_results$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound"))) {
    k <- match(coefficient_results$term[term_index], original_terms)
    lag_row <- if (!is.null(lag_robust)) match(safe_terms[k], rownames(lag_robust)) else NA_integer_
    if (!is.null(lag_robust) && is.na(lag_row)) lag_row <- k + 1L
    lag_estimate <- if (is.na(lag_row)) NA_real_ else lag_robust$beta[lag_row]; lag_se <- if (is.na(lag_row)) NA_real_ else lag_robust$SE[lag_row]; lag_df <- if (is.na(lag_row)) NA_real_ else lag_robust$df_Satt[lag_row]
    lag_rows[[length(lag_rows) + 1L]] <- data.frame(equation_id = equation_id, heat_form = heat_representation, outcome = outcome, term = coefficient_results$term[term_index],
      term_category = coefficient_results$term_category[term_index], residual_structure = attempt$residual_structure, n = nrow(lag_model_data),
      estimate = lag_estimate, se = lag_se, df = lag_df, ci_low = lag_estimate - qt(0.975, lag_df) * lag_se, ci_high = lag_estimate + qt(0.975, lag_df) * lag_se,
      p_value = if (is.na(lag_row) || !lag_reportable) NA_real_ else lag_robust$p_Satt[lag_row], inference_eligible = lag_reportable,
      full_sample_contemporaneous_estimate = coefficient_results$estimate[term_index], full_sample_contemporaneous_p = coefficient_results$p_value[term_index],
      note = paste(lag_msg, collapse = "; "), stringsAsFactors = FALSE)
  }
  if (length(lag_rows)) do.call(rbind, lag_rows) else NULL
}

# any alternative estimate lies outside the primary 95% CI, the CIs do not overlap or the sign flips;
# NA without a successful refit. alt_* report the independent-residual refit (else the boundary refit).
h4_merge_covariance_sensitivity <- function(coefficients, covariance_results) {
  coefficients$covariance_robust <- NA; coefficients$alt_estimate <- NA_real_; coefficients$alt_ci_low <- NA_real_
  coefficients$alt_ci_high <- NA_real_; coefficients$alt_structure <- NA_character_
  sens_ok <- covariance_results[covariance_results$sensitivity_status == "success" & is.finite(covariance_results$alt_estimate), , drop = FALSE]
  if (nrow(sens_ok)) {
    sens_ok$fails <- with(sens_ok, alt_estimate < primary_ci_low | alt_estimate > primary_ci_high |
                            !(ci_overlap %in% TRUE) | sign(alt_estimate) != sign(primary_estimate))
    key_s <- paste(sens_ok$equation_id, sens_ok$outcome, sens_ok$term)
    key_c <- paste(coefficients$equation_id, coefficients$outcome, coefficients$term)
    has <- key_c %in% key_s
    coefficients$covariance_robust[has] <- !vapply(key_c[has], function(k) any(sens_ok$fails[key_s == k]), logical(1))
    pick <- sens_ok[order(sens_ok$sensitivity_specification != "independent_residuals_nested_random_CR2"), , drop = FALSE]
    j <- match(key_c, paste(pick$equation_id, pick$outcome, pick$term))
    coefficients$alt_estimate <- pick$alt_estimate[j]; coefficients$alt_ci_low <- pick$alt_ci_low[j]
    coefficients$alt_ci_high <- pick$alt_ci_high[j]; coefficients$alt_structure <- pick$sensitivity_specification[j]
  }
  fb_rows <- coefficients$residual_structure %in% "independent_fallback"
  coefficients$covariance_robust[fb_rows] <- NA; coefficients$alt_estimate[fb_rows] <- NA_real_
  coefficients$alt_ci_low[fb_rows] <- NA_real_; coefficients$alt_ci_high[fb_rows] <- NA_real_; coefficients$alt_structure[fb_rows] <- NA_character_
  coefficients
}

h4_archive <- function(paths, archive_dir) {
  paths <- paths[file.exists(paths)]
  if (!length(paths)) return(invisible())
  dir.create(archive_dir, recursive = TRUE, showWarnings = FALSE)
  moved <- file.rename(paths, file.path(archive_dir, basename(paths)))
  if (!all(moved)) stop("Could not archive: ", paste(paths[!moved], collapse = ", "))
  cat(sprintf("Archived %d previous output(s) to %s\n", length(paths), archive_dir))
}

h4_write_results <- function(measurement_audit, step5_result) {
  results <- step5_result$h4
  if (is.null(results) || is.null(results$coef) || !nrow(results$coef))
    stop("H4 fitting incomplete; result tables not saved")
  results_directory <- RESULT_DIR
  coefficients <- results$export
  fit_status <- results$status
  if (nrow(coefficients)) {
  fit_status$model_note <- trimws(paste(ifelse(fit_status$residual_structure == "independent_fallback", "independent-residual fallback (no q);", ""),
    ifelse(fit_status$boundary_variance %in% TRUE, "boundary random-effect variance;", ""), ifelse(fit_status$high_ar1_flag %in% TRUE, "AR(1) rho > 0.95;", ""), ifelse(fit_status$residual_structure == "ARMA20", "ARMA(2,0) (AR(1) rho > 0.95);", "")))
  k <- match(paste(coefficients$equation, coefficients$outcome), paste(fit_status$heat_form, fit_status$outcome))
  coefficients$n <- fit_status$n[k]; coefficients$model_note <- fit_status$model_note[k]
  coefficients$analysis_role <- "H4.1: within-bout empatica/eyetracker association (10 s windows)"
  coefficients$independent_unit <- "participant cluster; repeated 10-second windows"
  coefficients$p_method <- "participant-cluster CR2 / Satterthwaite"
  fb <- coefficients$residual_structure == "independent_fallback"
  coefficients$q_note <- ifelse(fb, "excluded: fallback fit (independent residuals)", ifelse(!is.na(coefficients$q), "",
    ifelse(coefficients$term_type == "covariate", "not tested: covariate", ifelse(coefficients$term_type == "intercept", "not tested: intercept",
    ifelse(grepl("BikeU", coefficients$term), "derived: BikeU = -(WalkG + WalkU + BikeG)",
    ifelse(coefficients$term_type == "phase (study design)", "not tested: phase (study design)", ""))))))
  coefficients$q_note[fit_status$high_ar1_flag[k] %in% TRUE] <- "excluded: unresolved high-AR1 covariance after attempted repair"
  coefficients$q_note[coefficients$low_df_flag %in% TRUE] <- trimws(paste(coefficients$q_note[coefficients$low_df_flag %in% TRUE], "low df (<4); interpret with caution"))
  is_th <- coefficients$term_type == "thermal exposure"
  heat_table <- coefficients[is_th, ]
  write.csv(heat_table, file.path(results_directory, "H4_Heat_Noise_Exposures.csv"), row.names = FALSE, na = "")
  write.csv(coefficients[!is_th, ], file.path(results_directory, "H4_Covariates_and_Phases.csv"), row.names = FALSE, na = "")
  }
  invisible(coefficients)
}

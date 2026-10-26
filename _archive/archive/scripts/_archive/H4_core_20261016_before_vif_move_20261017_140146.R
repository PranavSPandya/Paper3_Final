# H4 reusable statistics, model fitting and result tables.

h4_mean <- function(x) {
  if (!is.numeric(x) && !is.logical(x) && !is.factor(x)) return(NA_real_)
  x <- as.numeric(x)
  if (any(is.finite(x))) mean(x[is.finite(x)]) else NA_real_
}

h4_person_mean_center <- function(x, id) ave(as.numeric(x), id, FUN = function(v) if (any(is.finite(v))) v - mean(v[is.finite(v)]) else rep(NA_real_, length(v)))

# fmt_md_table
fmt_md_table <- function(df) {
  if(!nrow(df)) return("(none)")
  row <- function(x) paste0("| ", paste(gsub("\\|", "/", as.character(x)), collapse = " | "), " |")
  paste(c(row(names(df)), row(rep("---", ncol(df))), apply(df, 1, row)), collapse = "\n")
}

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
    stopifnot(all(colnames(weights) %in% names(beta)))
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

h4_vif_per_term <- function(X) {
  # Fox & Monette (1992) car::vif on the design only (not an outcome fit). Each three-column PhaseID span is one term;
  # the score GVIF^(1/df) is the square of car's GVIF^(1/(2*df)).
  X <- as.matrix(X)
  if (!ncol(X)) return(setNames(numeric(), character()))
  nms <- colnames(X)
  groups <- nms
  groups[startsWith(nms, "PhaseSum")] <- "PhaseID"
  ix <- grepl(":PhaseSum", nms, fixed = TRUE)
  groups[ix] <- paste0(sub(":PhaseSum.*$", "", nms[ix]), ":PhaseID")
  terms <- unique(groups)
  dfs <- vapply(terms, function(g) sum(groups == g), integer(1))
  if (any(dfs[grepl("PhaseID$", terms)] != 3L)) stop("Incomplete PhaseID contrast block")
  gvif <- rep(Inf, length(terms))
  if (all(is.finite(X)) && nrow(X) > ncol(X) + 1L && qr(cbind(1, X))$rank == ncol(X) + 1L) {
    if (length(terms) == 1L) gvif[] <- 1 else {
      # The residual scale cancels in car's coefficient correlation; a deterministic dummy response supplies the lm interface.
      d <- data.frame(.h4_response = sin(seq_len(nrow(X))) + cos(seq_len(nrow(X)) * sqrt(2)))
      for (i in seq_along(terms)) {
        block <- X[, groups == terms[i], drop = FALSE]
        d[[paste0("T", i)]] <- if (ncol(block) == 1L) block[, 1L] else I(block)
      }
      result <- car::vif(stats::lm(.h4_response ~ ., data = d))
      keys <- paste0("T", seq_along(terms))
      gvif <- if (is.matrix(result)) result[keys, "GVIF"] else result[keys]
    }
  }
  score <- setNames(as.numeric(gvif)^(1 / dfs), terms)
  attr(score, "gvif_table") <- data.frame(term = terms, GVIF = as.numeric(gvif), Df = dfs,
    GVIF_root = as.numeric(gvif)^(1 / (2 * dfs)), VIF_equivalent = as.numeric(score))
  score
}

h4_fit <- function(audit_df, raw_df, prep, preflight_df) {
  suppressPackageStartupMessages({
    library(nlme)
    library(clubSandwich)
    library(parallel)
  })
  h4_model_dir <- file.path(OUT_DIR, "H4_models")
  dir.create(h4_model_dir, recursive = TRUE, showWarnings = FALSE)
  # Archive pre-existing items (except earlier _archive_* folders) so the folder only holds this run's outputs.
  old_items <- grep("^_archive_", list.files(h4_model_dir, all.files = TRUE, no.. = TRUE), value = TRUE, invert = TRUE)
  h4_archive(file.path(h4_model_dir, old_items), file.path(h4_model_dir, paste0("_archive_", format(Sys.time(), "%Y%m%d_%H%M%S"))))
  spec_rds <- tempfile(fileext = ".rds")
  saveRDS(H4_SPEC, spec_rds, version = 2L, compress = FALSE)
  # spec_md5 hashes the declared analysis specification, so it changes only when the spec changes.
  fingerprints <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV, spec_rds)))
  if (!identical(fingerprints[1:2], H4_START_MD5)) stop("Script or input changed since startup; no models run from inconsistent sources")
  names(fingerprints) <- c("code_md5", "input_md5", "audit_md5", "spec_md5")
  unlink(spec_rds)
  # Explicit local bindings from the Step 4 preparation (no list2env into this frame).
  raw_df <- prep$raw_df
  nonthermal <- prep$nonthermal
  thermal <- prep$thermal
  selected <- prep$selected
  centered <- prep$centered
  centered_lag60 <- prep$centered_lag60
  make_design <- prep$make_design
  catalog <- prep$catalog
  agreed_common <- prep$agreed_common
  stopifnot(nrow(catalog) == 7L, identical(catalog$equation_id, 1:7))

  outcomes <- H4_SPEC$all_outcomes
  hrv_log <- hrv_log_outcomes()
  model_template <- Eq1
  for (eq_id in 2:7) {
    other_template <- get(paste0("Eq", eq_id), envir = .GlobalEnv)
    stopifnot(identical(model_template$random, other_template$random),
              identical(model_template$correlation, other_template$correlation),
              identical(model_template$method, other_template$method),
              identical(model_template$na.action, other_template$na.action))
  }
  nested <- eval(model_template$random)
  ar1 <- function() eval(model_template$correlation)
  # Rule: refit with ARMA(2,0) per bout when the primary AR(1) rho > 0.95; otherwise keep AR(1).
  arma2 <- function() nlme::corARMA(c(0.5, 0.2), form = ~ Time10 | ParticipantID / PhaseID, p = 2, q = 0)
  # REML fit trying each optimizer in turn; log(opt, kind, message) records warnings and errors.
  fit_lme <- function(fml, fd, random, correlation, log, opts = c("nlminb", "optim")) {
    for (opt in opts) {
      fit <- tryCatch(withCallingHandlers(
        {
          model_call <- model_template
          model_call[[2L]] <- quote(fml)
          model_call$data <- quote(fd)
          model_call$random <- quote(random)
          model_call$correlation <- quote(correlation)
          model_call$control <- quote(nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = opt))
          eval(model_call)
        },
        warning = function(w) log(opt, "warning", conditionMessage(w))),
        error = function(e) { log(opt, "error", conditionMessage(e)); NULL })
      if (!is.null(fit)) return(fit)
    }
    NULL
  }
  # Both AR1 optimizers before the sensitivity-only independent fallback.
  do_fit_with_fallback <- function(fml, fd) {
    messages <- character()
    logger <- function(label) function(opt, kind, msg) messages <<- c(messages, sprintf("%s %s: %s", if (is.null(label)) opt else label, kind, msg))
    fit <- fit_lme(fml, fd, nested, ar1(), logger(NULL))
    structure <- "AR1"
    corfun <- ar1
    if (!is.null(fit)) {
      rho <- tryCatch(unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)
      if (length(rho) == 1L && is.finite(rho) && rho > 0.95) {
        fit2 <- fit_lme(fml, fd, nested, arma2(), logger("ARMA(2,0)"))
        if (is.null(fit2)) messages <- c(messages, sprintf("AR(1) rho = %.4f > 0.95 but ARMA(2,0) failed; AR(1) kept", rho)) else {
          fit <- fit2; structure <- "ARMA20"; corfun <- arma2
          messages <- c(messages, sprintf("ARMA(2,0) used: AR(1) rho = %.4f > 0.95", rho))
        }
      }
    }
    if (is.null(fit)) {
      fit <- fit_lme(fml, fd, nested, NULL, logger("uncorrelated"), opts = "nlminb")
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
  stopifnot(nrow(preflight_df) == length(outcomes) * length(fit_equation_ids),
    setequal(unique(preflight_df$equation_id), fit_equation_ids),
    setequal(unique(preflight_df$outcome), outcomes))
  preflight_csv <- file.path(h4_model_dir, "H4_design_redundancy_by_outcome.csv")
  utils::write.csv(preflight_df, preflight_csv, row.names = FALSE, na = "")
  if (any(!preflight_df$passes_check)) stop(sprintf("Step 5 rank-deficiency blocked fitting for %d outcome-equation designs. Review %s; GVIF/VIF flags alone do not remove predictors.",
    sum(!preflight_df$passes_check), preflight_csv), call. = FALSE)
  fit_one_outcome <- function(job) {
    y <- job$outcome
    fit_equation_ids <- job$equation_id
    stopifnot(length(fit_equation_ids) == 1L)
    ok <- h4_complete_rows(raw_df, y, fit_equation_ids, hrv_log)
    outcome_rows <- raw_df[ok, c("ParticipantID", "PhaseID", "Datetime"), drop = FALSE]
    outcome_rows$ParticipantID <- factor(outcome_rows$ParticipantID)
    outcome_rows$PhaseID <- factor(outcome_rows$PhaseID, levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
    stamp <- as.numeric(as.POSIXct(outcome_rows$Datetime, tz = "UTC"))
    bout <- interaction(outcome_rows$ParticipantID, outcome_rows$PhaseID, drop = TRUE)
    outcome_rows$Time10 <- as.integer(round((stamp - ave(stamp, bout, FUN = min)) / 10))
    if (any(!is.finite(stamp)) || anyDuplicated(outcome_rows[, c("ParticipantID", "PhaseID", "Time10")]))
      stop("Invalid/duplicate timestamps for outcome: ", y)
    centered_exposures <- centered[ok, , drop = FALSE]
    lagged_exposures <- centered_lag60[ok, , drop = FALSE]
    outcome_values <- raw_df[[y]][ok]
    transformation <- "native"
    if (y %in% hrv_log) {
      keep <- is.finite(outcome_values) & outcome_values > 0
      outcome_rows <- outcome_rows[keep, , drop = FALSE]
      centered_exposures <- centered_exposures[keep, , drop = FALSE]
      lagged_exposures <- lagged_exposures[keep, , drop = FALSE]
      # natural log (ln) applied here for hrv_log columns (not log1p)
      outcome_values <- log(outcome_values[keep])
      transformation <- H4_SPEC$outcome_transform[[y]]
    }
    h4_fit_equations(fit_equation_ids, y, catalog, thermal, make_design,
      centered_exposures, lagged_exposures, outcome_rows, outcome_values, transformation,
      raw_df, agreed_common, do_fit_with_fallback, fit_lme, nested)
  }
  cat(sprintf("[Step 5] Fitting %d equations across %d outcomes in parallel...\n", length(fit_equation_ids), length(outcomes)))
  workers <- min(length(fit_equation_ids), max(1L, parallel::detectCores() - 2L))
  jobs <- unlist(lapply(outcomes, function(y) lapply(fit_equation_ids, function(eid) list(outcome = y, equation_id = eid))), recursive = FALSE)
  stopifnot(length(jobs) == length(outcomes) * length(fit_equation_ids))
  cat(sprintf("[Parallel] %d workers; %d individual outcome-equation jobs; one job per dispatch.\n", workers, length(jobs)))
  cl <- parallel::makeCluster(workers)
  on.exit(if (!is.null(cl)) parallel::stopCluster(cl), add = TRUE)
  parallel::clusterEvalQ(cl, { library(nlme); library(clubSandwich); NULL })
  parallel::clusterExport(cl, c("raw_df", "centered", "centered_lag60", "arma2", "selected", "nonthermal", "thermal",
                                "outcomes", "hrv_log", "catalog", "fit_equation_ids",
                                "make_design", "do_fit_with_fallback", "fit_lme", "nested", "ar1", "model_template", "h4_spell_term", "agreed_common"), envir = environment())
  h4_cluster_globals <- ls(envir = .GlobalEnv, pattern = "^(h4_|H4_)", all.names = TRUE)
  parallel::clusterExport(cl, c(h4_cluster_globals, "hrv_log_outcomes", "hrv_fd_outcomes", "equation_spec"), envir = .GlobalEnv)
  fit_results <- parallel::parLapplyLB(cl, jobs, fit_one_outcome, chunk.size = 1L)
  parallel::stopCluster(cl)
  cl <- NULL
  attr(fit_results, "fingerprints") <- fingerprints
  saveRDS(fit_results, file.path(h4_model_dir, "H4_fit_records.rds"))
  h4_publish_fits(fit_results, fingerprints, h4_model_dir, outcomes, fit_equation_ids,
    catalog, prep, nonthermal, agreed_common, preflight_df, raw_df)
}

h4_fit_equations <- function(fit_equation_ids, y, catalog, thermal, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, transformation,
    raw_df, agreed_common, do_fit_with_fallback, fit_lme, nested) {
coef_rows <- contrast_rows <- status_rows <- sens_rows <- lag_rows <- list()
status_row <- function(success, converged, structure, note, residual_sd = NA_real_, ar1_rho = NA_real_,
                       lag1_normalized = NA_real_, n_adjacent = 0L, residual_skew = NA_real_, residual_excess_kurtosis = NA_real_,
                       boundary_variance = NA, high_ar1_flag = NA, min_cr2_df = NA_real_, min_cr2_df_heat = NA_real_)
  data.frame(equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y,
    success = success, n = nrow(model_data), n_participants = nlevels(model_data$ParticipantID),
    transformation = transformation, converged = converged, residual_structure = structure, residual_sd = residual_sd,
    ar1_rho = ar1_rho, lag1_normalized = lag1_normalized, n_adjacent = n_adjacent,
    residual_skew = residual_skew, residual_excess_kurtosis = residual_excess_kurtosis,
    boundary_variance = boundary_variance, high_ar1_flag = high_ar1_flag, min_cr2_df = min_cr2_df, min_cr2_df_heat = min_cr2_df_heat,
    participant_ids = paste(sort(unique(as.character(model_data$ParticipantID))), collapse = ";"),
    n_available_outcome = sum(is.finite(raw_df[[y]])), n_removed = nrow(raw_df) - nrow(model_data),
    note = note, stringsAsFactors = FALSE)
coef_frame <- function(term, est, se, df, p = 2 * pt(-abs(est / se), df), note = "")
  data.frame(equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y, term = term, estimate = est, se = se, df = df,
    residual_structure = attempt$residual_structure, ci_low = est - qt(0.975, df) * se, ci_high = est + qt(0.975, df) * se,
    t_stat = est / se, p_value = p, q_value = NA_real_, low_df_flag = is.finite(df) & df < 4, term_note = note, stringsAsFactors = FALSE)
for (eq_id in fit_equation_ids) {
  eq_row <- catalog[catalog$equation_id == eq_id, ]
  heat_representation <- eq_row$heat_form
  blk <- eq_row$block
  design <- make_design(centered_exposures, thermal[[heat_representation]], outcome_rows$PhaseID, test = eq_row$test,
    terms_order = h4_equation_term_order(eq_id))
  original_terms <- colnames(design)
  safe_terms <- make.names(original_terms, unique = TRUE)
  colnames(design) <- safe_terms
  model_data <- cbind(outcome_rows, Y = outcome_values, as.data.frame(design))
  model_data <- model_data[order(model_data$ParticipantID, model_data$PhaseID, model_data$Time10), ]
  fml <- reformulate(safe_terms, response = "Y")
  attempt <- do_fit_with_fallback(fml, model_data)
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
  grp <- interaction(model_data$ParticipantID, model_data$PhaseID, drop = TRUE)
  adj <- which(as.character(grp[-1]) == as.character(grp[-length(grp)]) & abs(diff(model_data$Time10) - 1) < 1e-6)
  lag1 <- if (!is.null(normalized_residuals) && length(adj) > 2) stats::cor(normalized_residuals[adj], normalized_residuals[adj + 1L]) else NA_real_
  rho <- tryCatch(unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)
  if (length(rho) != 1L) rho <- NA_real_
  centered_normalized_residuals <- if (!is.null(normalized_residuals)) normalized_residuals - mean(normalized_residuals) else NULL
  rms <- if (!is.null(centered_normalized_residuals)) sqrt(mean(centered_normalized_residuals^2)) else NA_real_
  skew <- if (!is.null(centered_normalized_residuals) && rms > 0) mean((centered_normalized_residuals / rms)^3) else NA_real_
  kurt <- if (!is.null(centered_normalized_residuals) && rms > 0) mean((centered_normalized_residuals / rms)^4) - 3 else NA_real_
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
    residual_sd = sigma(fit), ar1_rho = rho, lag1_normalized = lag1, n_adjacent = length(adj),
    residual_skew = skew, residual_excess_kurtosis = kurt, boundary_variance = boundary, high_ar1_flag = high_ar1,
    min_cr2_df = min_df, min_cr2_df_heat = min_df_heat)
  coef_rows[[length(coef_rows) + 1]] <- coefficient_results
  contrast_messages <- character()
  phase_tests <- tryCatch(withCallingHandlers(h4_phase_contrasts(fit, model_data$ParticipantID),
    warning = function(w) contrast_messages <<- c(contrast_messages, conditionMessage(w))),
    error = function(e) { contrast_messages <<- c(contrast_messages, conditionMessage(e)); NULL })
  if (is.null(phase_tests)) phase_tests <- data.frame(contrast = rownames(h4_phase_contrast_weights()), estimate = NA_real_,
    se = NA_real_, df = NA_real_, low_df_flag = NA, ci_low = NA_real_, ci_high = NA_real_, p_value = NA_real_)
  contrast_rows[[length(contrast_rows) + 1L]] <- cbind(phase_tests, outcome = y, residual_structure = attempt$residual_structure,
    equation_id = eq_id, note = paste(contrast_messages, collapse = "; "), stringsAsFactors = FALSE)
  sens_part <- h4_sensitivity_rows(coefficient_results, attempt, boundary, high_ar1, fit_lme, fml, model_data,
    original_terms, safe_terms, nested, eq_id, heat_representation, blk, y)
  if (!is.null(sens_part)) sens_rows[[length(sens_rows) + 1L]] <- sens_part

  lag_part <- h4_lag60_rows(coefficient_results, attempt, fit_lme, fml, nested, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
    eq_row, original_terms, safe_terms, eq_id, y)
  if (!is.null(lag_part)) lag_rows[[length(lag_rows) + 1L]] <- lag_part

}
list(
  coef = if (length(coef_rows)) do.call(rbind, coef_rows) else NULL,
  status = if (length(status_rows)) do.call(rbind, status_rows) else NULL,
  contrasts = if (length(contrast_rows)) do.call(rbind, contrast_rows) else NULL,
  sensitivity = if (length(sens_rows)) do.call(rbind, sens_rows) else NULL,
  lag60 = if (length(lag_rows)) do.call(rbind, lag_rows) else NULL
)
}

h4_publish_fits <- function(fit_results, fingerprints, h4_model_dir, outcomes, fit_equation_ids,
    catalog, prep, nonthermal, agreed_common, preflight_df, raw_df) {
  coef_all <- do.call(rbind, lapply(fit_results, `[[`, "coef"))
  status_all <- do.call(rbind, lapply(fit_results, `[[`, "status"))
  stopifnot(nrow(status_all) == length(outcomes) * length(fit_equation_ids),
            !anyDuplicated(status_all[, c("outcome", "equation_id")]))
  if (is.null(coef_all) || !nrow(coef_all)) stop("All fits failed; existing published outputs preserved")
  contrast_all <- do.call(rbind, lapply(fit_results, `[[`, "contrasts"))
  contrast_grid <- expand.grid(outcome = outcomes, equation_id = fit_equation_ids,
                              contrast = rownames(h4_phase_contrast_weights()), stringsAsFactors = FALSE)
  if (is.null(contrast_all)) stop("No phase-contrast records returned")
  stopifnot(!anyDuplicated(contrast_all[, c("outcome", "equation_id", "contrast")]))
  contrast_all <- merge(contrast_grid, contrast_all, by = c("outcome", "equation_id", "contrast"), all.x = TRUE)
  contrast_all$note[is.na(contrast_all$note)] <- "Model failed; contrast not estimable (see H4_fit_status.csv)"
  # Phase/design contrasts are diagnostics, not members of the H4 exposure-test family.
  contrast_all$fdr_note <- "not tested: phase/design contrast"
  contrast_all$q_value <- NA_real_
  sens_all <- do.call(rbind, lapply(fit_results, `[[`, "sensitivity"))
  lag_all <- do.call(rbind, lapply(fit_results, `[[`, "lag60"))
  if (!is.null(lag_all)) {
    # Separate exploratory family: BH per equation x term across outcomes; never merged into the primary q.
    lag_all$q_lag60 <- NA_real_
    for (k in unique(paste(lag_all$equation_id, lag_all$term))) {
      idx <- which(paste(lag_all$equation_id, lag_all$term) == k & lag_all$inference_eligible & is.finite(lag_all$p_value))
      if (length(idx)) lag_all$q_lag60[idx] <- p.adjust(lag_all$p_value[idx], "BH", n = length(outcomes))
    }
    utils::write.csv(lag_all, file.path(h4_model_dir, "H4_lag60_sensitivity.csv"), row.names = FALSE, na = "")
  }
  if (is.null(sens_all)) stop("No covariance sensitivity records returned")
# FDR
# H4.1: Benjamini-Hochberg per term, within each equation, across outcomes.
# Phase, BikeU, covariates, intercept, fallback, and unresolved high-AR1 fits get no q.
  # FDR (BH 1995): per term within each equation across outcomes (m = n_outcomes) for thermal and thermal x sound.
  # Phase, derived BikeU, covariates, intercept and fallback fits get no q (family fixed 2026-10-11, exploratory).
  primary_cats <- c("Heat_Main_Effect", "Thermal_x_Sound")
  status_index <- match(paste(coef_all$equation_id, coef_all$outcome), paste(status_all$equation_id, status_all$outcome))
  stopifnot(!anyNA(status_index))
  unresolved_ar1 <- status_all$high_ar1_flag[status_index] %in% TRUE
  is_correlated_fit <- coef_all$residual_structure %in% c("AR1", "ARMA20") & !unresolved_ar1
  m_term <- length(outcomes)
  coef_all$q_term <- NA_real_
  for (k in unique(paste(coef_all$equation_id, coef_all$term))) {
    idx <- which(paste(coef_all$equation_id, coef_all$term) == k & coef_all$term != "PhaseSumBikeU" & is_correlated_fit & is.finite(coef_all$p_value) &
                 coef_all$term_category %in% c(primary_cats, "Thermal_x_Phase"))
    stopifnot(length(idx) <= m_term)
    if (length(idx)) coef_all$q_term[idx] <- p.adjust(coef_all$p_value[idx], method = "BH", n = m_term)
  }
  coef_all$fdr_family <- ifelse(is.finite(coef_all$q_term) & coef_all$term_category %in% primary_cats, "thermal_per_term", "other")

  st <- split(status_all$success, factor(status_all$equation_id, levels = catalog$equation_id))
  catalog$attempted <- unname(lengths(st))
  catalog$succeeded <- unname(vapply(st, sum, integer(1)))
  catalog$failed <- catalog$attempted - catalog$succeeded
  catalog$fitted <- catalog$succeeded > 0L
  catalog[c("code_md5", "input_md5")] <- as.list(fingerprints[c("code_md5", "input_md5")])
  status_all[names(fingerprints)] <- as.list(fingerprints)
  sens_all[names(fingerprints)] <- as.list(fingerprints)
  # covariance_robust = FALSE if any alternative estimate lies outside the primary 95% CI, CIs do not overlap or the sign flips;
  # NA without a successful refit. alt_* report the independent-residual refit (else the boundary refit).
  coef_all <- h4_merge_covariance_sensitivity(coef_all, sens_all)
  # Simplified main table: one q (per-term BH across outcomes; thermal rows only) and one term_type.
  is_thermal <- coef_all$term_category %in% c(primary_cats, "Thermal_x_Phase")
  coef_out <- data.frame(equation = coef_all$heat_form, outcome = coef_all$outcome,
    term = sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", coef_all$term),
    term_type = ifelse(coef_all$term == "Intercept", "intercept", ifelse(startsWith(coef_all$term, "PhaseSum"), "phase (study design)",
      ifelse(is_thermal, "thermal exposure", "covariate"))),
    Beta = coef_all$estimate, ci_low = coef_all$ci_low, ci_high = coef_all$ci_high, p = ifelse(is_correlated_fit, coef_all$p_value, NA_real_),
    df = coef_all$df, low_df_flag = coef_all$low_df_flag,
    q = coef_all$q_term, FDR_significant = ifelse(is.na(coef_all$q_term), NA, coef_all$q_term < 0.05),
    covariance_robust = coef_all$covariance_robust, residual_structure = coef_all$residual_structure, stringsAsFactors = FALSE)
  hypo_df <- coef_out[is_thermal, ]
  postsel <- setdiff(nonthermal, agreed_common)
  if (!identical(unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV))),
                 unname(fingerprints[c("code_md5", "input_md5", "audit_md5")])))
    stop("Script, input or audit changed during fitting; results not saved")
  tables <- list(H4_equations.csv = catalog, H4_fit_status.csv = status_all,
    H4_coefficients.csv = coef_out, H4_hypothesis.csv = hypo_df,
    H4_phase_contrasts.csv = transform(setNames(contrast_all, sub("^estimate$", "Beta", sub("^q_value$", "q", names(contrast_all)))),
      FDR_significant = ifelse(is.na(q), NA, q < 0.05)),
    H4_covariance_sensitivity.csv = sens_all)
  for (name in names(tables)) write.csv(tables[[name]], file.path(h4_model_dir, name), row.names = FALSE, na = "")
  invisible(list(h4 = list(catalog = catalog, status = status_all, coef = coef_all,
    export = coef_out, hypothesis = hypo_df)))
}

h4_sensitivity_rows <- function(coefficient_results, attempt, boundary, high_ar1, fit_lme, fml, model_data,
    original_terms, safe_terms, nested, eq_id, heat_representation, blk, y) {
  sens_rows <- list()
  # Both covariance checks use the same fitting and coefficient-comparison code.
  target_idx <- which(coefficient_results$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound"))
  sensitivity_specs <- list()
  if (isTRUE(boundary)) sensitivity_specs$boundary <- list(
    flag = "boundary_variance", name = "random_intercept_participant_only_AR1",
    random = ~ 1 | ParticipantID, correlation = attempt$corfun())
  # Every AR1 fit gets an independent-residual comparison, including rho <= 0.95.
  if (isTRUE(high_ar1) || attempt$residual_structure %in% c("AR1", "ARMA20")) sensitivity_specs$independent <- list(
    flag = if (isTRUE(high_ar1)) "high_ar1" else "routine_independent_refit",
    name = "independent_residuals_nested_random_CR2",
    random = nested, correlation = NULL)
  if (length(target_idx)) for (specification in sensitivity_specs) {
    sensitivity_messages <- character()
    alt_fit <- fit_lme(fml, model_data, specification$random, specification$correlation, function(opt, kind, msg)
      sensitivity_messages <<- c(sensitivity_messages, if (kind == "error") paste0(opt, ": ", msg) else msg))
    alt_robust <- if (!is.null(alt_fit)) {
      tryCatch(clubSandwich::coef_test(alt_fit, vcov = "CR2", cluster = model_data$ParticipantID, test = "Satterthwaite"),
               error = function(e) { sensitivity_messages <<- c(sensitivity_messages, paste("CR2:", conditionMessage(e))); NULL })
    } else NULL
    for (i_t in target_idx) {
      t_name <- coefficient_results$term[i_t]
      p_est <- coefficient_results$estimate[i_t]
      alt_idx <- integer(0)
      k <- match(t_name, original_terms)
      if (!is.null(alt_robust) && !is.na(k)) {
        rn_match <- which(rownames(alt_robust) == safe_terms[k])
        if (length(rn_match) == 1L) alt_idx <- rn_match else if (k + 1L <= nrow(alt_robust)) alt_idx <- k + 1L
      }
      a_est <- a_se <- a_df <- a_cil <- a_cih <- a_pval <- NA_real_
      status_txt <- if (is.null(alt_fit)) paste("fit_failed:", paste(sensitivity_messages, collapse = "; ")) else "cr2_failed"
      if (length(alt_idx) == 1L) {
        a_est <- as.numeric(alt_robust$beta[alt_idx])
        a_se <- as.numeric(alt_robust$SE[alt_idx])
        a_df <- as.numeric(alt_robust$df_Satt[alt_idx])
        a_cil <- a_est - qt(0.975, a_df) * a_se
        a_cih <- a_est + qt(0.975, a_df) * a_se
        a_pval <- as.numeric(alt_robust[["p_Satt"]][alt_idx])
        status_txt <- "success"
      }
      sens_rows[[length(sens_rows) + 1L]] <- data.frame(
        equation_id = eq_id, heat_form = heat_representation, block = blk, outcome = y,
        diagnostic_flag = specification$flag,
        sensitivity_specification = specification$name,
        term = t_name, term_category = coefficient_results$term_category[i_t],
        primary_estimate = p_est, primary_se = coefficient_results$se[i_t], primary_df = coefficient_results$df[i_t],
        primary_ci_low = coefficient_results$ci_low[i_t], primary_ci_high = coefficient_results$ci_high[i_t], primary_p_value = coefficient_results$p_value[i_t],
        alt_estimate = a_est, alt_se = a_se, alt_df = a_df,
        alt_ci_low = a_cil, alt_ci_high = a_cih, alt_p_value = a_pval,
        estimate_diff = a_est - p_est, estimate_rel_diff_pct = if (is.finite(a_est) && abs(p_est) > 1e-12) 100 * (a_est - p_est) / abs(p_est) else NA_real_,
        ci_overlap = if (is.finite(a_est)) (coefficient_results$ci_low[i_t] <= a_cih) && (a_cil <= coefficient_results$ci_high[i_t]) else NA,
        sensitivity_status = status_txt, stringsAsFactors = FALSE)
    }
  }
  if (length(sens_rows)) do.call(rbind, sens_rows) else NULL
}

h4_lag60_rows <- function(coefficient_results, attempt, fit_lme, fml, nested, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
    eq_row, original_terms, safe_terms, eq_id, y) {
  lag_rows <- list()
  # 60-s lag sensitivity: heat terms (and heat x sound) use exposure 60 s earlier; same covariance as primary; own FDR family.
  heat_vars <- thermal[[heat_representation]]
  lagged_vars <- unique(heat_vars)
  lag_ok <- stats::complete.cases(lagged_exposures[, lagged_vars, drop = FALSE])
  lag_mix_exposures <- centered_exposures[lag_ok, , drop = FALSE]
  lag_mix_exposures[, lagged_vars] <- lagged_exposures[lag_ok, lagged_vars, drop = FALSE]
  lag_design <- make_design(lag_mix_exposures, heat_vars, outcome_rows$PhaseID[lag_ok], test = eq_row$test,
    terms_order = h4_equation_term_order(eq_id))
  colnames(lag_design) <- make.names(colnames(lag_design), unique = TRUE)
  lag_model_data <- cbind(outcome_rows[lag_ok, , drop = FALSE], Y = outcome_values[lag_ok], as.data.frame(lag_design))
  lag_model_data <- lag_model_data[order(lag_model_data$ParticipantID, lag_model_data$PhaseID, lag_model_data$Time10), ]
  lag_msg <- character()
  lag_fit <- fit_lme(fml, lag_model_data, nested, attempt$corfun(), function(opt, kind, msg) lag_msg <<- c(lag_msg, paste(opt, kind, msg)))
  lag_robust <- if (!is.null(lag_fit)) tryCatch(clubSandwich::coef_test(lag_fit, vcov = "CR2", cluster = lag_model_data$ParticipantID, test = "Satterthwaite"),
    error = function(e) { lag_msg <<- c(lag_msg, conditionMessage(e)); NULL }) else NULL
  lag_rho <- if (!is.null(lag_fit) && identical(attempt$residual_structure, "AR1")) unname(coef(lag_fit$modelStruct$corStruct, unconstrained = FALSE)) else NA_real_
  lag_reportable <- !is.null(lag_robust) && attempt$residual_structure %in% c("AR1", "ARMA20") &&
    !(length(lag_rho) == 1L && is.finite(lag_rho) && lag_rho > .95)
  for (i_t in which(coefficient_results$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound"))) {
    k <- match(coefficient_results$term[i_t], original_terms)
    li <- if (!is.null(lag_robust)) match(safe_terms[k], rownames(lag_robust)) else NA_integer_
    if (!is.null(lag_robust) && is.na(li)) li <- k + 1L
    le <- if (is.na(li)) NA_real_ else lag_robust$beta[li]; ls <- if (is.na(li)) NA_real_ else lag_robust$SE[li]; ldf <- if (is.na(li)) NA_real_ else lag_robust$df_Satt[li]
    lag_rows[[length(lag_rows) + 1L]] <- data.frame(equation_id = eq_id, heat_form = heat_representation, outcome = y, term = coefficient_results$term[i_t],
      term_category = coefficient_results$term_category[i_t], residual_structure = attempt$residual_structure, n = nrow(lag_model_data),
      estimate = le, se = ls, df = ldf, ci_low = le - qt(0.975, ldf) * ls, ci_high = le + qt(0.975, ldf) * ls,
      p_value = if (is.na(li) || !lag_reportable) NA_real_ else lag_robust$p_Satt[li], inference_eligible = lag_reportable,
      full_sample_contemporaneous_estimate = coefficient_results$estimate[i_t], full_sample_contemporaneous_p = coefficient_results$p_value[i_t],
      note = paste(lag_msg, collapse = "; "), stringsAsFactors = FALSE)
  }
  if (length(lag_rows)) do.call(rbind, lag_rows) else NULL
}

# any alternative estimate lies outside the primary 95% CI, the CIs do not overlap or the sign flips;
# NA without a successful refit. alt_* report the independent-residual refit (else the boundary refit).
h4_merge_covariance_sensitivity <- function(coef_all, sens_all) {
  coef_all$covariance_robust <- NA; coef_all$alt_estimate <- NA_real_; coef_all$alt_ci_low <- NA_real_
  coef_all$alt_ci_high <- NA_real_; coef_all$alt_structure <- NA_character_
  sens_ok <- sens_all[sens_all$sensitivity_status == "success" & is.finite(sens_all$alt_estimate), , drop = FALSE]
  if (nrow(sens_ok)) {
    sens_ok$fails <- with(sens_ok, alt_estimate < primary_ci_low | alt_estimate > primary_ci_high |
                            !(ci_overlap %in% TRUE) | sign(alt_estimate) != sign(primary_estimate))
    key_s <- paste(sens_ok$equation_id, sens_ok$outcome, sens_ok$term)
    key_c <- paste(coef_all$equation_id, coef_all$outcome, coef_all$term)
    has <- key_c %in% key_s
    coef_all$covariance_robust[has] <- !vapply(key_c[has], function(k) any(sens_ok$fails[key_s == k]), logical(1))
    pick <- sens_ok[order(sens_ok$sensitivity_specification != "independent_residuals_nested_random_CR2"), , drop = FALSE]
    j <- match(key_c, paste(pick$equation_id, pick$outcome, pick$term))
    coef_all$alt_estimate <- pick$alt_estimate[j]; coef_all$alt_ci_low <- pick$alt_ci_low[j]
    coef_all$alt_ci_high <- pick$alt_ci_high[j]; coef_all$alt_structure <- pick$sensitivity_specification[j]
  }
  fb_rows <- coef_all$residual_structure %in% "independent_fallback"
  coef_all$covariance_robust[fb_rows] <- NA; coef_all$alt_estimate[fb_rows] <- NA_real_
  coef_all$alt_ci_low[fb_rows] <- NA_real_; coef_all$alt_ci_high[fb_rows] <- NA_real_; coef_all$alt_structure[fb_rows] <- NA_character_
  coef_all
}

h4_archive <- function(paths, archive_dir) {
  paths <- paths[file.exists(paths)]
  if (!length(paths)) return(invisible())
  dir.create(archive_dir, recursive = TRUE, showWarnings = FALSE)
  moved <- file.rename(paths, file.path(archive_dir, basename(paths)))
  if (!all(moved)) stop("Could not archive: ", paste(paths[!moved], collapse = ", "))
  cat(sprintf("Archived %d previous output(s) to %s\n", length(paths), archive_dir))
}

h4_write_results <- function(audit_df, step5_result) {
  res_obj <- step5_result$h4
  if (is.null(res_obj) || is.null(res_obj$coef) || !nrow(res_obj$coef))
    stop("H4 fitting incomplete; result tables not saved")
  res_dir <- RESULT_DIR
  co <- res_obj$export
  st <- res_obj$status
  if (nrow(co)) {
  st$model_note <- trimws(paste(ifelse(st$residual_structure == "independent_fallback", "independent-residual fallback (no q);", ""),
    ifelse(st$boundary_variance %in% TRUE, "boundary random-effect variance;", ""), ifelse(st$high_ar1_flag %in% TRUE, "AR(1) rho > 0.95;", ""), ifelse(st$residual_structure == "ARMA20", "ARMA(2,0) (AR(1) rho > 0.95);", "")))
  k <- match(paste(co$equation, co$outcome), paste(st$heat_form, st$outcome))
  co$n <- st$n[k]; co$model_note <- st$model_note[k]
  co$analysis_role <- "H4.1: within-bout empatica/eyetracker association (10 s windows)"
  co$independent_unit <- "participant cluster; repeated 10-second windows"
  co$p_method <- "participant-cluster CR2 / Satterthwaite"
  fb <- co$residual_structure == "independent_fallback"
  co$q_note <- ifelse(fb, "excluded: fallback fit (independent residuals)", ifelse(!is.na(co$q), "",
    ifelse(co$term_type == "covariate", "not tested: covariate", ifelse(co$term_type == "intercept", "not tested: intercept",
    ifelse(grepl("BikeU", co$term), "derived: BikeU = -(WalkG + WalkU + BikeG)",
    ifelse(co$term_type == "phase (study design)", "not tested: phase (study design)", ""))))))
  co$q_note[st$high_ar1_flag[k] %in% TRUE] <- "excluded: unresolved high-AR1 covariance after attempted repair"
  co$q_note[co$low_df_flag %in% TRUE] <- trimws(paste(co$q_note[co$low_df_flag %in% TRUE], "low df (<4); interpret with caution"))
  is_th <- co$term_type == "thermal exposure"
  heat_table <- co[is_th, ]
  write.csv(heat_table, file.path(res_dir, "H4_Heat_Noise_Exposures.csv"), row.names = FALSE, na = "")
  write.csv(co[!is_th, ], file.path(res_dir, "H4_Covariates_and_Phases.csv"), row.names = FALSE, na = "")
  }
  invisible(co)
}

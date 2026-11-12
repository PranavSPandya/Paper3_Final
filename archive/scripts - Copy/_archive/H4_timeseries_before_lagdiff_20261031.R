# H4 time-series LME — explicit preparation and equations; shared audits/reporting in H4_core.R
if (!exists("PAPER3_PARTICIPANTS", inherits = FALSE)) {
  .entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (!length(.entry)) {
    .trail <- commandArgs(trailingOnly = TRUE)
    if (length(.trail) && file.exists(.trail[1])) .entry <- .trail[1]
  }
  if (!length(.entry)) {
    .source_files <- vapply(sys.frames(), function(frame) {
      if (is.null(frame$ofile)) "" else as.character(frame$ofile)[1L]
    }, character(1))
    .entry <- tail(.source_files[nzchar(.source_files)], 1L)
  }
  if (length(.entry)) {
    source(file.path(dirname(normalizePath(.entry[1], mustWork = FALSE)), "library", "Paper3_common.R"), local = FALSE)
  } else if (file.exists(file.path("library", "Paper3_common.R"))) {
    source(file.path("library", "Paper3_common.R"), local = FALSE)
  }
}
paper3_source_statistical_common_if_needed()
paper3_statistical_bootstrap(
  required_packages = c("ggplot2", "gridExtra", "car", "nlme", "clubSandwich"),
  load_packages = c("ggplot2", "gridExtra"),
  h4_pdf_null = TRUE
)
PROJECT_ROOT <- resolve_project_root()
# Step 5: serial fits (H4_PARALLEL_WORKERS=1). Optional batches via H4_JOB_START / H4_JOB_END or H4_MAX_JOBS (156 jobs = 26 outcomes × 6 equations).
Sys.setenv(H4_PARALLEL_WORKERS = "1")
H4_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/H4_timeseries.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))

# Cohort, phase and outcome specification (26 physiological outcomes via paper3_physiological_outcomes()).
h4_study_spec <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = c("BikeU", "BikeG", "WalkU", "WalkG"),
  physiological_outcome_names = paper3_physiological_outcomes(),
  variance_inflation_factor_limit = 5,
  expected_epoch_count = 49L
)

h4_study_spec <- paper3_attach_outcome_normalization(h4_study_spec, PROJECT_ROOT)
NORMALIZATION_CSV_PATH <- h4_study_spec$normalization_csv_path
OUTCOME_TRANSFORMS_CSV <- h4_study_spec$outcome_transforms_csv
PAPER3_APPLY_CSV_TRANSFORM <- function(x, column_name) {
  paper3_apply_csv_transform(x, column_name, OUTCOME_TRANSFORMS_CSV)
}


# Eq1 is the model. Eq2–6 change the heat or PM term. Y is not centered. Predictors ending in _bout_z are.

# UTCI in rows 1, 5–6: Eq1 primary; Eqs 5–6 PM size on UTCI.
h4_equation_table <- data.frame(
  equation_number = 1:6,
  heat_predictor_label = c("UTCI", "AIR_T_mid + AIR_RH + WIND_AWS", "HUMIDEX", "PET", "UTCI", "UTCI"),
  particulate_matter_column = c(rep("atmo_pm2.5_avg", 4), "atmo_pm1_avg", "atmo_pm10_avg"),
  equation_role = c("primary", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity",
    "pm_size_sensitivity", "pm_size_sensitivity"),
  stringsAsFactors = FALSE
)

# Eq1 primary: UTCI x sound. Random intercept per person and phase. AR(1) within the bout.
# Y <- PAPER3_APPLY_CSV_TRANSFORM(x, column_name)
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI_bout_z * ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq2: air temperature, humidity, wind, MRT, each x sound
Eq2 <- quote(nlme::lme(
  Y ~ ucm_AIR_T_mid_bout_z * ucm_SND_dBA_bout_z + ucm_AIR_RH_bout_z * ucm_SND_dBA_bout_z + ucm_WIND_AWS_bout_z * ucm_SND_dBA_bout_z + ucm_MRT_bout_z * ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq3: HUMIDEX x sound
Eq3 <- quote(nlme::lme(
  Y ~ ucm_HUMIDEX_bout_z * ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq4: PET x sound
Eq4 <- quote(nlme::lme(
  Y ~ ucm_PET_bout_z * ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq5: Eq1 with PM1
Eq5 <- quote(nlme::lme(
  Y ~ ucm_UTCI_bout_z * ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm1_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq6: Eq1 with PM10
Eq6 <- quote(nlme::lme(
  Y ~ ucm_UTCI_bout_z * ucm_SND_dBA_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z + atmo_pm10_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z + gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

h4_prepare_bout_exposures <- function(raw_df, selected) {
  bout_id <- paste(raw_df$ParticipantID, raw_df$PhaseID, sep = "::")
  centered <- raw_x <- as.matrix(raw_df[, selected, drop = FALSE])
  storage.mode(centered) <- storage.mode(raw_x) <- "double"
  for (j in seq_len(ncol(raw_x))) {
    x <- raw_x[, j]
    finite <- is.finite(x)
    bout_mean <- ave(ifelse(finite, x, NA_real_), raw_df$ParticipantID, raw_df$PhaseID,
      FUN = function(v) mean(v, na.rm = TRUE))
    deviation <- x - bout_mean
    shared_sd <- sd(deviation[is.finite(deviation)])
    centered[, j] <- if (is.finite(shared_sd) && shared_sd > 0) deviation / shared_sd else deviation
  }
  # Match the exact 60-second predecessor within the bout; row offsets are wrong when timestamps have gaps.
  stamp <- as.numeric(as.POSIXct(raw_df$Datetime, tz = "UTC"))
  time_keys <- paste(bout_id, stamp, sep = "::")
  if (any(!is.finite(stamp)) || anyDuplicated(time_keys)) stop("Invalid/duplicate timestamps in exposure preparation")
  lag_index <- match(paste(bout_id, stamp - 60, sep = "::"), time_keys)
  centered_lag60 <- centered
  centered_lag60[] <- NA_real_
  has_lag <- !is.na(lag_index)
  centered_lag60[has_lag, ] <- centered[lag_index[has_lag], , drop = FALSE]
  list(centered = centered, centered_lag60 = centered_lag60)
}

h4_prepare_bout_design <- function(raw_df, selected, nonthermal, thermal, rep_tab) {
  exposure_data <- h4_prepare_bout_exposures(raw_df, selected)
  centered <- exposure_data$centered
  centered_lag60 <- exposure_data$centered_lag60
  make_design <- function(z, vars, phase, test = "Noise", terms_order = NULL) {
    if (nrow(z) != length(phase)) stop("PhaseID/design row mismatch")
    env_covars <- setdiff(nonthermal, setdiff(H4_DOMAINS$Pollution, attr(vars, "pm")))
    if (!is.null(terms_order)) {
      ix_in_order <- terms_order[grepl(":", terms_order, fixed = TRUE)]
      mains_needed <- setdiff(terms_order, c(intersect(H4_PHASE_SUM_COLS, terms_order), ix_in_order))
      # Meeting quotes are authoritative: do not inject extra nonthermal mains (e.g. MRT outside Eq 2).
      env_covars <- setdiff(mains_needed, vars)
    }
    design_mains <- h4_design_main_column_order(vars, env_covars)
    x <- cbind(z[, design_mains, drop = FALSE], h4_phase_design(phase))
    stopifnot(sum(H4_DOMAINS$Pollution %in% colnames(x)) == 1L, !anyDuplicated(colnames(x)))
    if (test != "Noise") {
      if (!is.null(terms_order)) {
        stopifnot(setequal(colnames(x), terms_order))
        return(x[, terms_order, drop = FALSE])
      }
      return(x)
    }
    ix_terms <- if (!is.null(terms_order)) h4_sound_interaction_terms(terms_order) else {
      # Fallback when meeting quotes are absent: heat Ã— SND; MRT Ã— SND only for multi-component (Eq 2) heat form.
      heat_ix <- paste0(vars, ":ucm_SND_dBA")
      if (length(vars) > 1L) c(heat_ix, "ucm_MRT:ucm_SND_dBA") else heat_ix
    }
    if (length(ix_terms)) {
      sound <- vapply(ix_terms, function(term) {
        parts <- strsplit(term, ":", fixed = TRUE)[[1L]]
        z[, parts[1L]] * z[, parts[2L]]
      }, numeric(nrow(z)))
      sound <- matrix(sound, nrow = nrow(z), ncol = length(ix_terms), dimnames = list(NULL, ix_terms))
      x <- cbind(x, sound)
    }
    if (!is.null(terms_order)) {
      stopifnot(setequal(colnames(x), terms_order))
      x <- x[, terms_order, drop = FALSE]
    }
    x
  }
  catalog <- h4_equation_catalog(nonthermal, thermal, h4_equation_table)
  # Phase-average models validate their aggregated model matrix in h4_phase_model_data.
  if (exists("H4_EQUATION_FIXED", envir = .GlobalEnv, inherits = FALSE) && H4_VARIANT != "phaseavg") {
    fixed <- get("H4_EQUATION_FIXED", envir = .GlobalEnv)
    for (i in seq_len(nrow(h4_equation_table))) {
      heat_label <- names(thermal)[i]
      vars <- thermal[[heat_label]]
      meeting_cols <- fixed[[as.character(h4_equation_table$equation_number[i])]]
      fitted_cols <- colnames(make_design(centered[1L, , drop = FALSE], vars, "WalkG", terms_order = meeting_cols))
      stopifnot(identical(fitted_cols, meeting_cols))
    }
  }
  list(raw_df = raw_df, nonthermal = nonthermal, thermal = thermal, selected = selected,
       centered = centered, centered_lag60 = centered_lag60, make_design = make_design, catalog = catalog,
       agreed_common = character(0), rep_tab = rep_tab)
}

h4_bout_fitters <- function() {
  templates <- list(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6)
  model_template <- templates[[1L]]
  for (eq_id in 2:6) {
    other_template <- templates[[eq_id]]
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
        nlme::lme(
          fixed = fml,
          data = fd,
          random = random,
          correlation = correlation,
          method = eval(model_template$method),
          na.action = eval(model_template$na.action),
          control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = opt)
        ),
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

  list(nested = nested, fit_lme = fit_lme, do_fit_with_fallback = do_fit_with_fallback)
}

# Executed analysis: whole-bout centering precedes outcome filtering; no scaling is recomputed on filtered rows.
h4_fit <- function(audit_df = NULL, raw_df = NULL, prep = NULL) {
  setup <- h4_fit_begin(audit_df, raw_df)
  audit_df <- setup$audit_df
  raw_df <- setup$raw_df
  h4_model_dir <- setup$h4_model_dir
  fingerprints <- setup$fingerprints
  if (is.null(prep)) prep <- h4_step4_exposure_prep(audit_df, raw_df)
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
  stopifnot(nrow(catalog) == 6L, identical(catalog$equation_id, 1:6))

  outcomes <- h4_study_spec$all_physiological_outcomes
  natural_log_outcomes <- h4_study_spec$natural_log_outcome_names
  gvif_diag <- h4_run_gvif_diagnostic(prep)
  cat("[Step 5] GVIF diagnostic (design outcome empatica_heart_rate):", gvif_diag$paths["csv"], "\n")
  fitters <- h4_bout_fitters()
  nested <- fitters$nested
  fit_lme <- fitters$fit_lme
  do_fit_with_fallback <- fitters$do_fit_with_fallback

  fit_equation_ids <- catalog$equation_id
  # Outcome-specific redundancy audit before fitting; a rank-deficient design blocks fitting (no predictor removal).
  preflight_df <- h4_design_preflight(raw_df, centered, selected, catalog, thermal, make_design, fit_equation_ids, outcomes, natural_log_outcomes)
  preflight_csv <- file.path(h4_model_dir, h4_file("H4_design_redundancy_by_outcome.csv"))
  utils::write.csv(preflight_df, preflight_csv, row.names = FALSE, na = "")
  if (any(!preflight_df$passes_check)) stop(sprintf("Step 5 rank-deficiency blocked fitting for %d outcome-equation designs. Review %s; GVIF/VIF flags alone do not remove predictors.",
    sum(!preflight_df$passes_check), preflight_csv), call. = FALSE)
  fit_one_outcome <- function(job) {
    y <- job$outcome
    equation_id <- eq_id <- job$equation_id
    outcome_matrix <- as.matrix(raw_df[, c(selected, y), drop = FALSE])
    storage.mode(outcome_matrix) <- "double"
    predictors <- unique(unlist(strsplit(H4_EQUATION_FIXED[[equation_id]], ":", fixed = TRUE)))
    predictors <- setdiff(predictors, H4_PHASE_SUM_COLS)
    values <- as.matrix(raw_df[, c(predictors, y), drop = FALSE])
    storage.mode(values) <- "double"
    ok <- rowSums(!is.finite(values)) == 0L
    if (y %in% natural_log_outcomes) ok <- ok & raw_df[[y]] > 0
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
    outcome_values <- outcome_matrix[ok, y]
    if (y %in% natural_log_outcomes) {
      keep <- is.finite(outcome_values) & outcome_values > 0
      outcome_rows <- outcome_rows[keep, , drop = FALSE]
      centered_exposures <- centered_exposures[keep, , drop = FALSE]
      lagged_exposures <- lagged_exposures[keep, , drop = FALSE]
      outcome_values <- outcome_values[keep]
    }
    outcome_values <- PAPER3_APPLY_CSV_TRANSFORM(outcome_values, y)
    eq_row <- prep$catalog[prep$catalog$equation_id == eq_id, ]
    design <- prep$make_design(centered_exposures, prep$thermal[[eq_row$heat_form]], outcome_rows$PhaseID,
      test = eq_row$test, terms_order = h4_equation_term_order(eq_id))
    original_terms <- colnames(design)
    processed_terms <- vapply(strsplit(original_terms, ":", fixed = TRUE), function(parts) {
      paste(ifelse(startsWith(parts, "PhaseSum"), parts, paste0(parts, "_bout_z")), collapse = ":")
    }, character(1))
    safe_terms <- make.names(processed_terms, unique = TRUE)
    colnames(design) <- safe_terms
    model_data <- cbind(outcome_rows, stats::setNames(list(outcome_values), "Y"), as.data.frame(design))
    model_data <- model_data[order(model_data$ParticipantID, model_data$PhaseID, model_data$Time10), ]
      # Execute the explicit REML/AR1 fitter below; existing ARMA/independent fallback rules are retained.
    attempt <- do_fit_with_fallback(reformulate(safe_terms, response = "Y"), model_data)
    h4_fit_equations(eq_id, y, prep$catalog, prep$thermal, prep$make_design,
      centered_exposures, lagged_exposures, outcome_rows, outcome_values,
      h4_study_spec$outcome_transform[[y]], raw_df, prep$agreed_common,
      do_fit_with_fallback, fit_lme, nested,
      fitted_model = list(original_terms = original_terms, safe_terms = safe_terms,
        data = model_data, formula = reformulate(safe_terms, response = "Y"), attempt = attempt))
  }
  h4_fit_queue(fit_one_outcome, prep, preflight_df, fingerprints, h4_model_dir, outcomes, fit_equation_ids)
}

# Pipeline validation: fixed-effect order parsed from the six formulas above (not edited separately).
h4_fixed_terms_from_lme_quote <- function(lme_quote) {
  fml <- as.formula(lme_quote[[2L]])
  gsub("_(phase|bout)_z", "", gsub("`", "", attr(terms(fml), "term.labels"), fixed = TRUE))
}
H4_EQUATION_FIXED <- list(
  `1` = h4_fixed_terms_from_lme_quote(Eq1),
  `2` = h4_fixed_terms_from_lme_quote(Eq2),
  `3` = h4_fixed_terms_from_lme_quote(Eq3),
  `4` = h4_fixed_terms_from_lme_quote(Eq4),
  `5` = h4_fixed_terms_from_lme_quote(Eq5),
  `6` = h4_fixed_terms_from_lme_quote(Eq6)
)
# MRT × SND_dBA interaction is Eq 2 only; Eq 2 heat air term is mid-height temperature.
MRT_SOUND_INTERACTION <- c("ucm_MRT:ucm_SND_dBA", "ucm_SND_dBA:ucm_MRT")
stopifnot(
  !any(H4_EQUATION_FIXED[["1"]] %in% MRT_SOUND_INTERACTION),
  any(H4_EQUATION_FIXED[["2"]] %in% MRT_SOUND_INTERACTION),
  !any(H4_EQUATION_FIXED[["3"]] %in% MRT_SOUND_INTERACTION),
  !any(H4_EQUATION_FIXED[["4"]] %in% MRT_SOUND_INTERACTION),
  !any(H4_EQUATION_FIXED[["5"]] %in% MRT_SOUND_INTERACTION),
  !any(H4_EQUATION_FIXED[["6"]] %in% MRT_SOUND_INTERACTION),
  any(grepl("^ucm_AIR_T_mid", H4_EQUATION_FIXED[["2"]], fixed = FALSE)),
  !any(grepl("ucm_AIR_temp", unlist(H4_EQUATION_FIXED), fixed = TRUE))
)

# ==============================================================================
# WORKFLOW
# ==============================================================================
run_h4 <- function() {
  # Load audit/fit engine after h4_study_spec and Eq1–6 are defined (script top level).
  source(file.path(LIBRARY_DIR, "H4_core.R"), local = FALSE)
  cat("==============================================================================\n")
  cat("Running H4: Multivariate Models of Noise Amplification on Thermal Discomfort\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(h4_study_spec$participants), paste(h4_study_spec$participants, collapse = ", ")))
  cat(sprintf("Outcomes     (%d): %d empatica + %d eyetracker (physiological vector)\n",
              length(h4_study_spec$all_physiological_outcomes), 13L, 13L))
  cat(sprintf("Equations    (%d): 1 Primary, 3 Heat, 2 PM\n\n", nrow(h4_equation_table)))

  h4_dispatch_run()
}

if (sys.nframe() == 0L) run_h4()

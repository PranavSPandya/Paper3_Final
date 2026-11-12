# H4 time-series LME — explicit preparation and equations; shared audits/reporting in Analysis_combined_core.R
# Lagged-difference block (added 2026-10-31; moved here from H6.2 of H6_exploratory.R, now removed): a robustness /
# exploratory extension of H4, NOT a separate hypothesis. Per person, Pearson r between the 10 s first
# difference of an exposure (window ending at t - lag) and of a response (window ending at t), lags
# 0/10/30/60 s, exact 10 s predecessors within each participant/phase, pairs pooled across phases
# (>= 20 pairs, both changes varying); Fisher z (capped at +-0.999), unweighted mean across people,
# back-transformed mean r; exact two-sided sign-flip test on mean z (>= 6 people); t-interval on z,
# back-transformed; BH across the 12 pairing x lag rows. Raw values: no centering, standardization,
# transformation, covariates or random effects. Pairings: lys_lux_avg -> eyetracker_pupil_diameter_avg,
# ucm_MRT -> empatica_skin_temperature, ucm_SND_dBA -> empatica_eda_phasic. Not causal, not response time.
# Runs ONLY with: Rscript scripts/statistical_analysis/Analysis_combined_timeseries.R --lagdiff-only
# (a normal or grouped H4 run does not execute it). Output: output/statistical_analysis/results/Analysis_combined_timeseries_lagdiff/
# Sound-source-adjusted block (added 2026-10-31; moved here from H6.3 of H6_exploratory.R, now removed; archived as
# scripts/_archive/H6_exploratory_final_20261031.R): exploratory extension of H4, NOT a separate hypothesis. Unlike the
# H4 sound run (H4_timeseries_sound.R), where a sound-source proportion REPLACES dBA, here the source term is estimated
# CONDITIONAL on loudness, heat and light. Per participant: 10 s rows with complete source, ucm_SND_dBA, ucm_UTCI,
# lys_lux_avg (same LYS1/LYS2 mean as above) and outcome (>= 60 rows, >= 2 phases); each variable centred within phase
# and standardised within person; lm(y ~ source + dba + utci + lux); participant dropped if rank-deficient or the source
# VIF >= 5; slope = Beta_SD. Exact two-sided sign-flip test on the mean slope (>= 6 people); t-interval; BH across the 4
# rows. Sources: vehicle_proportion, rural_natural_proportion; outcomes: empatica_eda_tonic, eyetracker_fixation_rate
# (raw units, no log). Not causal. Runs ONLY with: Rscript scripts/statistical_analysis/Analysis_combined_timeseries.R --sourceadj-only
# (normal, grouped and --lagdiff-only runs do not execute it). Output: output/statistical_analysis/results/Analysis_combined_timeseries_sourceadj/
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
H4_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/Analysis_combined_timeseries.R")
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
  source(file.path(LIBRARY_DIR, "Analysis_combined_core.R"), local = FALSE)
  cat("==============================================================================\n")
  cat("Running H4: Multivariate Models of Noise Amplification on Thermal Discomfort\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(h4_study_spec$participants), paste(h4_study_spec$participants, collapse = ", ")))
  cat(sprintf("Outcomes     (%d): %d empatica + %d eyetracker (physiological vector)\n",
              length(h4_study_spec$all_physiological_outcomes), 13L, 13L))
  cat(sprintf("Equations    (%d): 1 Primary, 3 Heat, 2 PM\n\n", nrow(h4_equation_table)))

  h4_dispatch_run()
}

# ==============================================================================
# LAGGED-DIFFERENCE BLOCK (robustness/exploratory extension of H4; formerly H6.2). See header note.
# ==============================================================================
h4_lagdiff_run <- function(input_path = RAW_DATA_PATH,
    out_dir = file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "Analysis_combined_timeseries_lagdiff")) {
  pairs <- list(c("lys_lux_avg", "eyetracker_pupil_diameter_avg"),
                c("ucm_MRT", "empatica_skin_temperature"),
                c("ucm_SND_dBA", "empatica_eda_phasic"))
  lags <- c(0L, 10L, 30L, 60L)
  participants <- h4_study_spec$participants
  phases <- h4_study_spec$phases
  needed <- c("ParticipantID", "PhaseID", "Datetime", "atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux",
              "eyetracker_pupil_diameter_avg", "ucm_MRT", "empatica_skin_temperature",
              "ucm_SND_dBA", "empatica_eda_phasic")
  header <- names(utils::read.csv(input_path, nrows = 0, check.names = FALSE))
  miss <- setdiff(needed, header)
  if (length(miss)) stop("Lagged-difference block: absent input columns: ", paste(miss, collapse = ", "))
  raw <- utils::read.csv(input_path, check.names = FALSE,
    colClasses = ifelse(header %in% needed, "character", "NULL"), na.strings = c("", "NA", "NaN", "null"))
  for (nm in needed[-(1:3)]) raw[[nm]] <- suppressWarnings(as.numeric(raw[[nm]]))
  # Same light definition as H4: mean of available LYS1/LYS2 readings; both missing stays NA.
  raw$lys_lux_avg <- rowMeans(raw[, c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")], na.rm = TRUE)
  raw$lys_lux_avg[!is.finite(raw$lys_lux_avg)] <- NA_real_
  d <- raw[raw$ParticipantID %in% participants & raw$PhaseID %in% phases, , drop = FALSE]
  d$Datetime <- as.POSIXct(d$Datetime, tz = "UTC", tryFormats = c("%Y-%m-%d %H:%M:%OS", "%Y-%m-%dT%H:%M:%OS",
    "%Y-%m-%d %H:%M:%OS%z", "%Y-%m-%dT%H:%M:%OS%z"))
  if (!nrow(d) || anyNA(d$Datetime)) stop("Lagged-difference block: empty core routes or unparseable Datetime")
  d <- d[order(d$ParticipantID, d$PhaseID, d$Datetime), , drop = FALSE]
  if (anyDuplicated(d[, c("ParticipantID", "PhaseID", "Datetime")])) stop("Duplicate participant/phase/time keys")
  groups <- split(d, interaction(d$ParticipantID, d$PhaseID, drop = TRUE), drop = TRUE)
  if (any(vapply(groups, function(x) as.numeric(max(x$Datetime) - min(x$Datetime), units = "secs") > 480.01, logical(1))))
    stop("Data exceed first matched 8 minutes")
  # Exact two-sided sign-flip test on the mean; t-interval on the values.
  signflip <- function(values, min_n = 6L) {
    v <- values[is.finite(values)]; n <- length(v)
    if (n < min_n || sd(v) < 1e-12) return(list(N = n, estimate = NA_real_, ci_low = NA_real_, ci_high = NA_real_, p = NA_real_))
    p <- 0
    for (k in 0:(2^n - 1L)) {
      signs <- 2 * as.integer(intToBits(k))[seq_len(n)] - 1
      p <- p + (abs(mean(v * signs)) >= abs(mean(v)) - 1e-12)
    }
    h <- qt(.975, n - 1L) * sd(v) / sqrt(n)
    list(N = n, estimate = mean(v), ci_low = mean(v) - h, ci_high = mean(v) + h, p = p / (2^n))
  }
  lag_subject <- list(); lag_results <- list()
  for (pair in pairs) {
    exposure <- pair[1]; outcome <- pair[2]
    for (lag in lags) {
      obs <- list()
      for (x in groups) {
        sec <- as.numeric(difftime(x$Datetime, x$Datetime[1], units = "secs"))
        step <- as.integer(round(sec / 10))
        if (any(abs(sec - 10 * step) > 1.2) || anyDuplicated(step))
          stop("Unexpected time-grid mismatch: ", x$ParticipantID[1], "/ ", x$PhaseID[1])
        ids_y_prev <- match(step - 1L, step)
        ids_x <- match(step - as.integer(lag / 10), step)
        ids_x_prev <- match(step - as.integer(lag / 10) - 1L, step)
        Y <- x[[outcome]]; X <- x[[exposure]]
        dy <- Y - Y[ids_y_prev]
        dx <- X[ids_x] - X[ids_x_prev]
        ok <- is.finite(dy) & is.finite(dx)
        if (sum(ok)) obs[[length(obs) + 1L]] <- data.frame(ParticipantID = x$ParticipantID[1], dy = dy[ok], dx = dx[ok])
      }
      if (!length(obs)) next
      allobs <- do.call(rbind, obs)
      rows <- list()
      for (id in unique(allobs$ParticipantID)) {
        sub <- allobs[allobs$ParticipantID == id, ]
        rv <- if (nrow(sub) >= 20L && sd(sub$dx) > 1e-10 && sd(sub$dy) > 1e-10) cor(sub$dx, sub$dy) else NA_real_
        rows[[length(rows) + 1L]] <- data.frame(Exposure = exposure, Outcome = outcome, Lag_s = lag,
          ParticipantID = id, N_10s_changes = nrow(sub), r = rv)
      }
      b <- do.call(rbind, rows); lag_subject[[length(lag_subject) + 1L]] <- b
      z <- atanh(pmax(-.999, pmin(.999, b$r[is.finite(b$r)])))
      tt <- signflip(z)
      lag_results[[length(lag_results) + 1L]] <- data.frame(Exposure = exposure, Outcome = outcome, Lag_s = lag,
        N_Participants = tt$N, mean_r = if (is.finite(tt$estimate)) tanh(tt$estimate) else NA_real_,
        ci_low = if (is.finite(tt$ci_low)) tanh(tt$ci_low) else NA_real_,
        ci_high = if (is.finite(tt$ci_high)) tanh(tt$ci_high) else NA_real_, p = tt$p,
        N_Changes = sum(b$N_10s_changes[is.finite(b$r)]))
    }
  }
  res <- do.call(rbind, lag_results)
  res$q <- NA_real_; ok <- is.finite(res$p); res$q[ok] <- p.adjust(res$p[ok], method = "BH")
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
  utils::write.csv(res, file.path(out_dir, "Analysis_combined_timeseries_lagdiff_profiles.csv"), row.names = FALSE)
  utils::write.csv(do.call(rbind, lag_subject), file.path(out_dir, "Analysis_combined_timeseries_lagdiff_participant_correlations.csv"), row.names = FALSE)
  writeLines(c("H4 lagged-difference block: robustness/exploratory extension of H4 (formerly H6.2); not a separate hypothesis; no causal claims.",
    paste("Generated:", as.character(Sys.time())), paste("Input:", normalizePath(input_path)),
    paste("Input MD5:", unname(tools::md5sum(input_path))), paste("Script:", H4_SCRIPT_PATH),
    paste("Script MD5:", unname(tools::md5sum(H4_SCRIPT_PATH))),
    paste("Participants:", paste(sort(unique(d$ParticipantID)), collapse = ", ")),
    paste("Core route rows:", nrow(d)), paste("Participant-phase bouts:", length(groups)),
    "Method: per-person Pearson r of exact 10 s first differences (exposure window ending at t - lag; response window ending at t), lags 0/10/30/60 s, pairs pooled across phases (>=20, both varying); Fisher z capped at +-0.999; unweighted mean across people; exact two-sided sign-flip (>=6 people); t-interval on z; BH across the 12 rows.",
    "Raw values: no centering, standardization, transformation, covariates or random effects."),
    file.path(out_dir, "Analysis_combined_timeseries_lagdiff_README.txt"))
  cat("Lagged-difference block finished. Results written to:", out_dir, "\n")
  print(res[, c("Exposure", "Outcome", "Lag_s", "N_Participants", "mean_r", "ci_low", "ci_high", "p", "q")])
  invisible(res)
}

h4_sourceadj_run <- function(input_path = RAW_DATA_PATH,
    out_dir = file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "Analysis_combined_timeseries_sourceadj")) {
  # Faithful port of H6.3 (H6_exploratory.R L190-235); same input, participants, phases and light definition as the lagdiff block.
  source_terms <- c("vehicle_proportion", "rural_natural_proportion")
  source_outcomes <- c("empatica_eda_tonic", "eyetracker_fixation_rate")
  participants <- h4_study_spec$participants
  phases <- h4_study_spec$phases
  needed <- c("ParticipantID", "PhaseID", "Datetime", "atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux",
              "ucm_SND_dBA", "ucm_UTCI", source_terms, source_outcomes)
  header <- names(utils::read.csv(input_path, nrows = 0, check.names = FALSE))
  miss <- setdiff(needed, header)
  if (length(miss)) stop("Sound-source-adjusted block: absent input columns: ", paste(miss, collapse = ", "))
  raw <- utils::read.csv(input_path, check.names = FALSE,
    colClasses = ifelse(header %in% needed, "character", "NULL"), na.strings = c("", "NA", "NaN", "null"))
  for (nm in needed[-(1:3)]) raw[[nm]] <- suppressWarnings(as.numeric(raw[[nm]]))
  # Same light definition as H4: mean of available LYS1/LYS2 readings; both missing stays NA.
  raw$lys_lux_avg <- rowMeans(raw[, c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")], na.rm = TRUE)
  raw$lys_lux_avg[!is.finite(raw$lys_lux_avg)] <- NA_real_
  d <- raw[raw$ParticipantID %in% participants & raw$PhaseID %in% phases, , drop = FALSE]
  d$Datetime <- as.POSIXct(d$Datetime, tz = "UTC", tryFormats = c("%Y-%m-%d %H:%M:%OS", "%Y-%m-%dT%H:%M:%OS",
    "%Y-%m-%d %H:%M:%OS%z", "%Y-%m-%dT%H:%M:%OS%z"))
  if (!nrow(d) || anyNA(d$Datetime)) stop("Sound-source-adjusted block: empty core routes or unparseable Datetime")
  d <- d[order(d$ParticipantID, d$PhaseID, d$Datetime), , drop = FALSE]
  # Exact two-sided sign-flip test on the mean; t-interval on the values (as H6 signflip).
  signflip <- function(values, min_n = 6L) {
    v <- values[is.finite(values)]; n <- length(v)
    if (n < min_n || sd(v) < 1e-12) return(list(N = n, estimate = NA_real_, ci_low = NA_real_, ci_high = NA_real_, p = NA_real_))
    p <- 0
    for (k in 0:(2^n - 1L)) {
      signs <- 2 * as.integer(intToBits(k))[seq_len(n)] - 1
      p <- p + (abs(mean(v * signs)) >= abs(mean(v)) - 1e-12)
    }
    h <- qt(.975, n - 1L) * sd(v) / sqrt(n)
    list(N = n, estimate = mean(v), ci_low = mean(v) - h, ci_high = mean(v) + h, p = p / (2^n))
  }
  source_subject <- list(); source_results <- list()
  for (source in source_terms) for (outcome in source_outcomes) {
    predictors <- c(source, "ucm_SND_dBA", "ucm_UTCI", "lys_lux_avg")
    tmp_results <- list()
    for (id in participants) {
      a <- d[d$ParticipantID == id, c("ParticipantID", "PhaseID", predictors, outcome), drop = FALSE]
      a <- a[complete.cases(a), , drop = FALSE]
      if (nrow(a) < 60L || length(unique(a$PhaseID)) < 2L) next
      rename <- c("source", "dba", "utci", "lux", "y")
      names(a)[match(c(predictors, outcome), names(a))] <- rename
      for (nm in rename) {
        a[[nm]] <- a[[nm]] - ave(a[[nm]], a$PhaseID, FUN = mean)
        s <- sd(a[[nm]])
        if (is.finite(s) && s > 1e-10) a[[nm]] <- a[[nm]] / s else a[[nm]] <- NA_real_
      }
      a <- a[complete.cases(a), , drop = FALSE]
      if (nrow(a) < 60L) next
      f <- lm(y ~ source + dba + utci + lux, data = a)
      if (f$rank != 5L) next
      aux <- lm(source ~ dba + utci + lux, data = a)
      vif <- 1 / (1 - summary(aux)$r.squared)
      if (!is.finite(vif) || vif >= 5) next
      b <- unname(coef(f)["source"])
      if (!is.finite(b)) next
      tmp_results[[length(tmp_results) + 1L]] <- data.frame(Source = source, Outcome = outcome, ParticipantID = id,
        N_10s = nrow(a), Beta_SD = b, source_VIF = vif)
    }
    b <- if (length(tmp_results)) do.call(rbind, tmp_results) else data.frame()
    if (nrow(b)) source_subject[[length(source_subject) + 1L]] <- b
    tt <- signflip(if (nrow(b)) b$Beta_SD else numeric())
    source_results[[length(source_results) + 1L]] <- data.frame(Source = source, Outcome = outcome, N_Participants = tt$N,
      mean_beta_SD = tt$estimate, ci_low = tt$ci_low, ci_high = tt$ci_high, p = tt$p,
      N_10s = if (nrow(b)) sum(b$N_10s) else 0L)
  }
  res <- do.call(rbind, source_results)
  res$q <- NA_real_; ok <- is.finite(res$p); res$q[ok] <- p.adjust(res$p[ok], method = "BH")
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
  utils::write.csv(res, file.path(out_dir, "Analysis_combined_timeseries_sourceadj_results.csv"), row.names = FALSE)
  utils::write.csv(if (length(source_subject)) do.call(rbind, source_subject) else data.frame(),
    file.path(out_dir, "Analysis_combined_timeseries_sourceadj_participant_slopes.csv"), row.names = FALSE)
  writeLines(c("H4 sound-source-adjusted block: exploratory extension of H4 (formerly H6.3); not a separate hypothesis; no causal claims.",
    paste("Generated:", as.character(Sys.time())), paste("Input:", normalizePath(input_path)),
    paste("Input MD5:", unname(tools::md5sum(input_path))), paste("Script:", H4_SCRIPT_PATH),
    paste("Script MD5:", unname(tools::md5sum(H4_SCRIPT_PATH))),
    paste("Participants:", paste(sort(unique(d$ParticipantID)), collapse = ", ")), paste("Core route rows:", nrow(d)),
    "Method: per participant, 10 s rows with complete source, ucm_SND_dBA, ucm_UTCI, lys_lux_avg (mean of available LYS1/LYS2) and outcome (>=60 rows, >=2 phases); each variable centred within phase and standardised within person; lm(y ~ source + dba + utci + lux); participant dropped if rank-deficient or source VIF >= 5; Beta_SD = source slope.",
    "Inference: exact two-sided sign-flip test on the mean participant slope (>=6 people); t-interval; BH across the 4 source x outcome rows.",
    "Differs from H4_timeseries_sound.R, where the source proportion replaces dBA; here it is adjusted for dBA, UTCI and lux. Raw outcome units (no log)."),
    file.path(out_dir, "Analysis_combined_timeseries_sourceadj_README.txt"))
  cat("Sound-source-adjusted block finished. Results written to:", out_dir, "\n")
  print(res)
  invisible(res)
}

if (sys.nframe() == 0L) {
  h4_cli_args <- commandArgs(trailingOnly = TRUE)
  if ("--sourceadj-only" %in% h4_cli_args) h4_sourceadj_run() else
  if ("--lagdiff-only" %in% h4_cli_args) h4_lagdiff_run() else run_h4()
}

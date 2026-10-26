# H4 multivariate entry — noise amplifies thermal discomfort on physiological outcomes.
# Six heat×sound equations (non-thermal covariates, phase contrasts, centered exposures).
# Methods map: Paper3_Code_Design_Methodology_Map.md | Run: Rscript scripts/H4_multivariate.R
# Meeting file: hypothesis, H4_SPEC, Step 4 design, H4.1 fit + FDR. Audit/render/dispatch: scripts/H4_core.R.

# id | heat_key                         | pm               | role
#  1 | UTCI                             | atmo_pm2.5_avg   | primary
#  2 | AIR_temp+AIR_RH+WIND_AWS         | atmo_pm2.5_avg   | heat_sensitivity
#  3 | HUMIDEX                          | atmo_pm2.5_avg   | heat_sensitivity
#  4 | PET                              | atmo_pm2.5_avg   | heat_sensitivity
#  5 | UTCI                             | atmo_pm1_avg     | pm_size_sensitivity
#  6 | UTCI                             | atmo_pm10_avg    | pm_size_sensitivity
equation_spec <- data.frame(
  equation_id = 1:6,
  heat_key = c("UTCI", "AIR_temp + AIR_RH + WIND_AWS", "HUMIDEX", "PET", "UTCI", "UTCI"),
  pm = c("atmo_pm2.5_avg", "atmo_pm2.5_avg", "atmo_pm2.5_avg", "atmo_pm2.5_avg", "atmo_pm1_avg", "atmo_pm10_avg"),
  role = c("primary", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity", "pm_size_sensitivity", "pm_size_sensitivity"),
  stringsAsFactors = FALSE)
stopifnot(nrow(equation_spec) == 6L, identical(equation_spec$equation_id, 1:6), sum(equation_spec$role == "primary") == 1L)

suppressPackageStartupMessages({ library(ggplot2); library(gridExtra) })
required_packages <- c("ggplot2", "gridExtra", "car", "nlme", "clubSandwich")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)
grDevices::pdf(file = NULL)

resolve_project_root <- function() {
  arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  candidates <- c(if (length(arg)) file.path(dirname(sub("^--file=", "", arg[1])), ".."), getwd(), file.path(getwd(), ".."))
  for (root in unique(candidates)) {
    root <- normalizePath(root, winslash = "/", mustWork = FALSE)
    if (file.exists(file.path(root, "output/merged_all_11participants_8min.csv"))) return(root)
  }
  stop("Cannot find output/merged_all_11participants_8min.csv; run from the repository or scripts folder.")
}

PROJECT_ROOT <- resolve_project_root()
script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
H4_SCRIPT_PATH <- if (length(script_arg) && file.exists(script_arg[1])) script_arg[1] else file.path(PROJECT_ROOT, "scripts/H4_multivariate.R")
SCRIPT_DIR <- if (length(script_arg)) dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE)) else file.path(PROJECT_ROOT, "scripts")
RAW_DATA_PATH <- file.path(PROJECT_ROOT, "output/merged_all_11participants_8min.csv")
H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))
RESULT_DIR <- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results")
OUT_DIR <- file.path(RESULT_DIR, "_work")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
OUT_CSV <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")
AUDIT_PNG <- file.path(OUT_DIR, "H4_All_Variables_Audit.png")
AUDIT_PDF <- file.path(OUT_DIR, "H4_All_Variables_Audit.pdf")
STAGE_SUMMARY_CSV <- file.path(OUT_DIR, "H4_Audit_Stage_Summary.csv")
INTEGRATION_CSV <- file.path(OUT_DIR, "H4_Integration_Readiness.csv")
STEP_CATEGORY_CSV <- file.path(OUT_DIR, "H4_Step_Category_Counts.csv")
FINAL_OUTCOME_COUNTS_CSV <- file.path(OUT_DIR, "H4_Final_Outcome_Counts.csv")
TRANSPARENCY_MD <- file.path(OUT_DIR, "H4_Transparency_Report.md")
FORMULA_TXT <- file.path(OUT_DIR, "H4_Multivariate_Formula.txt")


# --- H4_SPEC (participants, phases, outcomes, HRV log, VIF) ---
H4_SPEC <- list(
  participants = c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"),
  phases = c("BikeU", "BikeG", "WalkU", "WalkG"),
  outcomes = list(
    Physiological_Autonomic = c(
      "empatica_heart_rate", "empatica_eda_tonic", "empatica_eda_phasic", "empatica_skin_temperature",
      "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd", "empatica_hrv_fd_lf", "empatica_hrv_fd_hf",
      "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_lfnu", "empatica_hrv_fd_hfnu", "empatica_hrv_fd_vlf",
      "empatica_hrv_fd_total_power"),
    Physiological_Ocular = c(
      "eyetracker_pupil_diameter_avg", "eyetracker_pupil_change_rate", "eyetracker_blink_duration_s",
      "eyetracker_fixation_duration_s", "eyetracker_fixation_rate", "eyetracker_saccade_duration_s",
      "eyetracker_saccade_amplitude", "eyetracker_saccade_peak_velocity", "eyetracker_gaze_velocity",
      "eyetracker_gaze_dispersion", "eyetracker_distance_from_center", "eyetracker_gaze_centrality",
      "eyetracker_eyelid_aperture_avg")),
  hrv_log = c(
    "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd", "empatica_hrv_fd_lf", "empatica_hrv_fd_hf",
    "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_vlf", "empatica_hrv_fd_total_power"),
  hrv_fd = c(
    "empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_lfnu",
    "empatica_hrv_fd_hfnu", "empatica_hrv_fd_vlf", "empatica_hrv_fd_total_power"),
  vif_threshold = 5, expected_epochs = 49L)
H4_SPEC$h4_1_outcomes <- unlist(H4_SPEC$outcomes, use.names = FALSE)
H4_SPEC$all_outcomes <- unlist(H4_SPEC$outcomes, use.names = FALSE)
# Outcome transforms: HRV ln(x) for x > 0 (Laborde; Task Force 1996); see Normalization_H1toH4.ipynb.
H4_SPEC$outcome_transform <- setNames(
  ifelse(H4_SPEC$all_outcomes %in% H4_SPEC$hrv_log, "natural log", "native"), H4_SPEC$all_outcomes)
H4_SPEC$exposure_centered <- c(
  ucm_UTCI = "PC_UTCI", ucm_SND_dBA = "PC_dBA", atmo_pm2.5_avg = "PC_PM25", lys_lux_avg = "PC_Lux", gvi_50m = "PC_GVI")
H4_SPEC$bilateral_sources <- list(
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"))


source(file.path(SCRIPT_DIR, "H4_core.R"), local = FALSE)

# --- Step 4: exposure prep, equation catalog, within-bout centering, make_design ---
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

# Exposure preparation and the six equations
# equation_spec lives in the specification block. h4_equation_catalog checks the six rows.
h4_step4_exposure_prep <- function(audit_df, raw_df) {
  for (v in setdiff(c("lys_lux_avg", "lys_kelvin_avg", "lys_medi_avg"), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  raw_df <- raw_df[raw_df$ParticipantID %in% H4_SPEC$participants & raw_df$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
  if (!"empatica_hrv_fd_5min_available" %in% names(raw_df)) stop("Missing HRV availability flag")
  available <- tolower(as.character(raw_df$empatica_hrv_fd_5min_available)) %in% c("true", "1")
  for (v in H4_SPEC$hrv_fd) raw_df[[v]][!available] <- NA_real_
  # Explicit one-step endpoint approximation: never fill internal gaps or cross a bout boundary.
  bout_order <- order(raw_df$ParticipantID, raw_df$PhaseID, as.POSIXct(raw_df$Datetime, tz = "UTC"))
  bout_sorted <- paste(raw_df$ParticipantID, raw_df$PhaseID)[bout_order]
  raw_df$SVF_endpoint_carried <- FALSE
  for (ix in split(bout_order, bout_sorted)) {
    if (length(ix) < 2L) next
    last <- tail(ix, 1L); previous <- tail(ix, 2L)[1L]
    gap <- as.numeric(difftime(as.POSIXct(raw_df$Datetime[last], tz = "UTC"), as.POSIXct(raw_df$Datetime[previous], tz = "UTC"), units = "secs"))
    if (!is.finite(raw_df$SVF_Holmer[last]) && is.finite(raw_df$SVF_Holmer[previous]) && is.finite(gap) && gap == 10) {
      raw_df$SVF_Holmer[last] <- raw_df$SVF_Holmer[previous]
      raw_df$SVF_endpoint_carried[last] <- TRUE
    }
  }
  audit_df <- h4_step4_candidates(raw_df, audit_df)
  reps <- audit_df$Variable_Name[audit_df$Step4_Category_Role %in% "covariate candidate"]
  nonthermal <- unique(reps)
  rep_tab <- audit_df[!is.na(audit_df$Step4_Domain), c("Step4_Domain", "Variable_Name", "Step4_Category_Role", "Step4_Decision", "Step4_Restriction")]
  base_heat <- list(`AIR_temp + AIR_RH + WIND_AWS` = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS"), HUMIDEX = "ucm_HUMIDEX", PET = "ucm_PET", UTCI = "ucm_UTCI")
  pm <- intersect(H4_DOMAINS$Pollution, reps)
  if (length(pm) != 3L || !all(c("ucm_MRT", "ucm_SND_dBA") %in% reps)) stop("Step 4 requires three PM alternatives, MRT and sound")
  # equation_spec is the six-row table in the specification block (same ids, heat keys, PM, roles).
  # UTCI + PM2.5 is the pre-specified primary. Heat-form sensitivities stay on PM2.5.
  # PM1 and PM10 are size sensitivities on UTCI only (no other heat form x PM1/PM10).
  stopifnot(nrow(equation_spec) == 6L, identical(equation_spec$equation_id, 1:6),
            all(equation_spec$heat_key %in% names(base_heat)), all(equation_spec$pm %in% pm),
            sum(equation_spec$role == "primary") == 1L)
  thermal <- list()
  for (i in seq_len(nrow(equation_spec))) {
    vars <- base_heat[[equation_spec$heat_key[i]]]
    attr(vars, "pm") <- equation_spec$pm[i]
    thermal[[paste(equation_spec$heat_key[i], equation_spec$pm[i], sep = " / ")]] <- vars
  }
  selected <- unique(c(nonthermal, unlist(thermal, use.names = FALSE)))
  # Within-bout centering (Enders & Tofighi 2007; Curran & Bauer 2011): each exposure minus its bout (participant x
  # phase) mean, divided by the SD of that deviation. PhaseID sum-to-zero effects carry the condition means.
  bout_id <- paste(raw_df$ParticipantID, raw_df$PhaseID, sep = "::")
  centered <- raw_x <- as.matrix(raw_df[, selected, drop = FALSE])
  storage.mode(centered) <- storage.mode(raw_x) <- "double"
  for (j in seq_len(ncol(raw_x))) {
    finite <- is.finite(raw_x[, j])
    centered[, j] <- raw_x[, j] - unname(tapply(raw_x[finite, j], bout_id[finite], mean)[bout_id])
    sdx <- sd(centered[finite, j])
    if (is.finite(sdx) && sdx > 0) centered[, j] <- centered[, j] / sdx
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
  make_design <- function(z, vars, phase, test = "Noise") {
    if (nrow(z) != length(phase)) stop("PhaseID/design row mismatch")
    covars <- setdiff(nonthermal, setdiff(H4_DOMAINS$Pollution, attr(vars, "pm")))
    x <- cbind(z[, unique(c(covars, vars)), drop = FALSE], h4_phase_design(phase))
    stopifnot(sum(H4_DOMAINS$Pollution %in% colnames(x)) == 1L, !anyDuplicated(colnames(x)))
    if (test != "Noise") return(x)
    interaction_vars <- unique(c(vars, "ucm_MRT"))
    sound <- z[, interaction_vars, drop = FALSE] * z[, "ucm_SND_dBA"]
    colnames(sound) <- paste0(interaction_vars, ":SND_dBA")
    cbind(x, sound)
  }
  catalog <- h4_equation_catalog(nonthermal, thermal, equation_spec)
  list(raw_df = raw_df, nonthermal = nonthermal, thermal = thermal, selected = selected,
       centered = centered, centered_lag60 = centered_lag60, make_design = make_design, catalog = catalog,
       agreed_common = character(0), rep_tab = rep_tab)
}

h4_equation_catalog <- function(nonthermal, thermal, equation_spec) {
  stopifnot(nrow(equation_spec) == 6L, length(thermal) == 6L,
            identical(names(thermal), paste(equation_spec$heat_key, equation_spec$pm, sep = " / ")))
  out <- do.call(rbind, lapply(seq_len(nrow(equation_spec)), function(id) {
    vars <- thermal[[id]]
    data.frame(equation_id = equation_spec$equation_id[id], heat_form = names(thermal)[id],
      pm_representation = attr(vars, "pm"), role = equation_spec$role[id],
      primary = equation_spec$role[id] == "primary", block = "heat_x_sound", test = "Noise",
      terms = paste(vapply(c(setdiff(nonthermal, setdiff(H4_DOMAINS$Pollution, attr(vars, "pm"))), vars, H4_PHASE_SUM_COLS, paste0(unique(c(vars, "ucm_MRT")), ":SND_dBA")), h4_spell_term, character(1)), collapse = " + "),
      heat_role = if (length(vars) > 1L) "Air temperature + RH + apparent wind" else paste(equation_spec$heat_key[id], "only"),
      fitted = FALSE, stringsAsFactors = FALSE)
  }))
  stopifnot(nrow(out) == 6L, identical(out$equation_id, 1:6), sum(out$primary) == 1L, out$primary[1],
            out$role[1] == "primary", !anyDuplicated(out$terms),
            out$pm_representation[1:4] == "atmo_pm2.5_avg",
            out$pm_representation[5:6] == c("atmo_pm1_avg", "atmo_pm10_avg"))
  out$analysis_role <- ifelse(out$primary, "pre-specified primary (UTCI + PM2.5)",
    ifelse(out$role == "heat_sensitivity", "heat-form sensitivity (PM2.5)", "PM size sensitivity (UTCI heat form)"))
  out
}

# --- H4.1: REML fit, CR2 inference, Benjamini-Hochberg FDR ---
# --- 5. H4.1 fit and FDR ---

h4_1_fit <- function(audit_df = NULL, raw_df = NULL, prep = NULL) {
  suppressPackageStartupMessages({
    library(nlme)
    library(clubSandwich)
    library(parallel)
  })
  if (is.null(audit_df)) {
    if (!file.exists(OUT_CSV)) stop("Audit results CSV not found: ", OUT_CSV)
    audit_df <- read.csv(OUT_CSV, check.names = FALSE)
  }
  if (is.null(raw_df)) {
    raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
    # Rebuild the averaged sensor columns (Atmotube PM, LYS) that are not stored in the raw CSV.
    for (v in setdiff(names(average_sources), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  }
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

  outcomes <- H4_SPEC$h4_1_outcomes
  hrv_log <- H4_SPEC$hrv_log
  gvif_diag <- h4_run_gvif_diagnostic(prep)
  cat("[Step 5] GVIF diagnostic (design outcome empatica_heart_rate):", gvif_diag$paths["csv"], "\n")
  nested <- ~ 1 | ParticipantID / PhaseID
  ar1 <- function() nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID)
  # Rule: refit with ARMA(2,0) per bout when the primary AR(1) rho > 0.95; otherwise keep AR(1).
  arma2 <- function() nlme::corARMA(c(0.5, 0.2), form = ~ Time10 | ParticipantID / PhaseID, p = 2, q = 0)
  # REML fit trying each optimizer in turn; log(opt, kind, message) records warnings and errors.
  fit_lme <- function(fml, fd, random, correlation, log, opts = c("nlminb", "optim")) {
    for (opt in opts) {
      fit <- tryCatch(withCallingHandlers(
        nlme::lme(fml, data = fd, random = random, correlation = correlation, method = "REML", na.action = na.fail,
          control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = opt)),
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
  # Outcome-specific redundancy audit before fitting; a rank-deficient design blocks fitting (no predictor removal).
  preflight_df <- h4_1_design_preflight(raw_df, centered, selected, catalog, thermal, make_design, fit_equation_ids, outcomes, hrv_log)
  preflight_csv <- file.path(h4_model_dir, "H4_design_redundancy_by_outcome.csv")
  utils::write.csv(preflight_df, preflight_csv, row.names = FALSE, na = "")
  if (any(!preflight_df$passes_check)) stop(sprintf("Step 5 rank-deficiency blocked fitting for %d outcome-equation designs. Review %s; GVIF/VIF flags alone do not remove predictors.",
    sum(!preflight_df$passes_check), preflight_csv), call. = FALSE)
  fit_one_outcome <- function(job) {
    y <- job$outcome
    fit_equation_ids <- job$equation_id
    outcome_matrix <- as.matrix(raw_df[, c(selected, y), drop = FALSE])
    storage.mode(outcome_matrix) <- "double"
    ok <- apply(outcome_matrix, 1, function(v) all(is.finite(v)))
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
    transformation <- "native"
    if (y %in% hrv_log) {
      keep <- is.finite(outcome_values) & outcome_values > 0
      outcome_rows <- outcome_rows[keep, , drop = FALSE]
      centered_exposures <- centered_exposures[keep, , drop = FALSE]
      lagged_exposures <- lagged_exposures[keep, , drop = FALSE]
      outcome_values <- log(outcome_values[keep])
      transformation <- H4_SPEC$outcome_transform[[y]]
    }
    h4_1_fit_equations(fit_equation_ids, y, catalog, thermal, make_design,
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
                                "make_design", "do_fit_with_fallback", "fit_lme", "nested", "ar1", "h4_spell_term", "agreed_common"), envir = environment())
  parallel::clusterExport(cl, c("h4_phase_design", "h4_vif_per_term", "H4_SPEC", "H4_DOMAINS",
                                "h4_phase_contrasts", "h4_phase_contrast_weights", "h4_1_fit_equations", "h4_1_sensitivity_rows", "h4_1_lag60_rows"), envir = .GlobalEnv)
  fit_results <- parallel::parLapplyLB(cl, jobs, fit_one_outcome, chunk.size = 1L)
  parallel::stopCluster(cl)
  cl <- NULL
  attr(fit_results, "fingerprints") <- fingerprints
  saveRDS(fit_results, file.path(h4_model_dir, "H4_fit_records.rds"))
  h4_1_publish_fits(fit_results, fingerprints, h4_model_dir, outcomes, fit_equation_ids,
    catalog, prep, nonthermal, agreed_common, preflight_df, raw_df)
}

# h4_1_fit prepares designs and dispatches jobs.
# h4_1_fit_equations fits one outcome. h4_1_publish_fits writes the tables.
h4_1_fit_equations <- function(fit_equation_ids, y, catalog, thermal, make_design,
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
  design <- make_design(centered_exposures, thermal[[heat_representation]], outcome_rows$PhaseID, test = eq_row$test)
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
  coefficient_results$term_category[grepl(":SND_dBA", coefficient_results$term)] <- "Thermal_x_Sound"
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
  sens_part <- h4_1_sensitivity_rows(coefficient_results, attempt, boundary, high_ar1, fit_lme, fml, model_data,
    original_terms, safe_terms, nested, eq_id, heat_representation, blk, y)
  if (!is.null(sens_part)) sens_rows[[length(sens_rows) + 1L]] <- sens_part

  lag_part <- h4_1_lag60_rows(coefficient_results, attempt, fit_lme, fml, nested, make_design,
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

h4_1_publish_fits <- function(fit_results, fingerprints, h4_model_dir, outcomes, fit_equation_ids,
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
  coef_all <- h4_1_merge_covariance_sensitivity(coef_all, sens_all)
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
  rep_lines <- vapply(split(prep$rep_tab, prep$rep_tab$Step4_Domain), function(domain_rows)
    paste0("     * ", domain_rows$Step4_Domain[1], ": ", paste(domain_rows$Variable_Name, collapse = ", "), "; ", domain_rows$Step4_Restriction[1]), character(1))
  readme_lines <- h4_1_readme_lines(status_all, coef_all, sens_all, catalog, preflight_df, outcomes, raw_df,
                                    agreed_common, postsel, rep_lines, fingerprints)
  m_primary_txt <- sprintf("m = %d per term", as.integer(m_term))
  pkgs <- c("nlme", "clubSandwich", "car", "ggplot2", "gridExtra")
  session_lines <- c(capture.output(utils::sessionInfo()), "", paste0(pkgs, " ", vapply(pkgs, function(p)
    tryCatch(as.character(utils::packageVersion(p)), error = function(e) "not installed"), character(1))))
  bundle <- list(
    H4_equations.csv = catalog,
    H4_fit_status.csv = status_all,
    H4_coefficients.csv = coef_out,
    H4_hypothesis.csv = hypo_df,
    H4_phase_contrasts.csv = transform(setNames(contrast_all, sub("^estimate$", "Beta", sub("^q_value$", "q", names(contrast_all)))),
                                     FDR_significant = ifelse(is.na(q), NA, q < 0.05)),
    H4_covariance_sensitivity.csv = sens_all,
    H4_hypothesis_readme.txt = readme_lines,
    H4_session_info.txt = session_lines
  )
  # Sequential publication; the completion manifest is invalidated first (readers must reject a missing manifest).
  manifest_path <- file.path(h4_model_dir, "H4_run_complete.csv")
  if (!identical(unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH, OUT_CSV))), unname(fingerprints[c("code_md5", "input_md5", "audit_md5")])))
    stop("Script, input or audit changed during fitting; checkpoint retained, inconsistent results not published")
  if (file.exists(manifest_path) && !file.remove(manifest_path)) stop("Cannot invalidate old completion manifest")
  for (nm in names(bundle)) {
    target_path <- file.path(h4_model_dir, nm)
    if (is.data.frame(bundle[[nm]])) write.csv(bundle[[nm]], target_path, row.names = FALSE, na = "") else writeLines(bundle[[nm]], target_path)
  }
  extra_files <- c("H4_fit_records.rds", "H4_gvif_diagnostic.csv", "H4_gvif_diagnostic.md",
                   "H4_design_redundancy_by_outcome.csv", "H4_covariance_sensitivity.csv", "H4_lag60_sensitivity.csv", "H4_session_info.txt")
  man_files <- unique(c(names(bundle), extra_files[file.exists(file.path(h4_model_dir, extra_files))]))
  write.csv(data.frame(file = man_files, md5 = unname(tools::md5sum(file.path(h4_model_dir, man_files))), as.list(fingerprints),
    completed_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ"), run_complete = FALSE,
    run_scope = "FULL", stringsAsFactors = FALSE), manifest_path, row.names = FALSE)
  cat(sprintf("[Step 5] Bundle published to %s. Total fitted models: %d, Succeeded: %d, Failed: %d\n",
              h4_model_dir, nrow(status_all), sum(status_all$success), sum(!status_all$success)))
  cat(sprintf("[H4.1] Thermal rows: %d, p < 0.05: %d, q < 0.05: %d (per-term BH; %s)\n",
              nrow(hypo_df), sum(hypo_df$p < 0.05, na.rm = TRUE), sum(hypo_df$q < 0.05, na.rm = TRUE), m_primary_txt))
  invisible(list(h4_1 = list(catalog = catalog, status = status_all, coef = coef_all, hypothesis = hypo_df)))
}

# share). A rank-deficient design blocks fitting (no predictor removal). Extracted from h4_1_fit.
h4_1_design_preflight <- function(raw_df, centered, selected, catalog, thermal, make_design, fit_equation_ids, outcomes, hrv_log) {
  preflight <- list()
  for (check_y in outcomes) {
    check_vals <- as.matrix(raw_df[, c(selected, check_y), drop = FALSE])
    storage.mode(check_vals) <- "double"
    valid <- apply(check_vals, 1L, function(v) all(is.finite(v)))
    if (check_y %in% hrv_log) valid <- valid & raw_df[[check_y]] > 0
    check_z <- centered[valid, , drop = FALSE]
    check_phase <- raw_df$PhaseID[valid]
    for (check_eid in fit_equation_ids) {
      check_eq <- catalog[catalog$equation_id == check_eid, ]
      check_x <- make_design(check_z, thermal[[check_eq$heat_form]], check_phase, test = check_eq$test)
      vv <- h4_vif_per_term(check_x)
      gt <- attr(vv, "gvif_table")
      phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
      if (!nrow(phase_gt)) phase_gt <- data.frame(GVIF = NA_real_, Df = 3L, GVIF_root = NA_real_, VIF_equivalent = NA_real_)
      exposure_terms <- intersect(colnames(check_x), selected)
      cells <- interaction(raw_df$ParticipantID[valid], check_phase, drop = TRUE)
      within_share <- vapply(exposure_terms, function(v) {
        x <- check_x[, v]
        total <- sum((x - mean(x))^2)
        if (total <= 0) return(NA_real_)
        sum((x - ave(x, cells, FUN = mean))^2) / total
      }, numeric(1))
      rr <- qr(cbind(Intercept = 1, check_x))$rank
      sigmas <- apply(check_x, 2L, stats::sd)
      singular <- svd(sweep(sweep(check_x, 2L, colMeans(check_x), "-"), 2L, ifelse(is.finite(sigmas) & sigmas > 0, sigmas, 1), "/"), nu = 0L, nv = 0L)$d
      mx <- max(vv)
      preflight[[length(preflight) + 1L]] <- data.frame(equation_id = check_eid, heat_form = check_eq$heat_form, block = check_eq$block,
        outcome = check_y, n = nrow(check_x), rank = rr, expected_rank = ncol(check_x) + 1L, full_rank = rr == ncol(check_x) + 1L,
        max_vif = mx, worst_term = names(vv)[which.max(vv)], diagnostic = "Design-only GVIF^(1/Df); ordinary VIF for Df=1",
        phase_df = phase_gt$Df, phase_gvif = phase_gt$GVIF, phase_gvif_root = phase_gt$GVIF_root, phase_vif_equivalent = phase_gt$VIF_equivalent,
        term_vif_equivalents = paste(names(vv), signif(vv, 6), sep = "=", collapse = ";"),
        within_participant_phase_variation_share = paste(names(within_share), signif(within_share, 6), sep = "=", collapse = ";"),
        high_vif_terms = paste(names(vv)[!is.finite(vv) | vv >= H4_SPEC$vif_threshold], collapse = ";"),
        condition_index = if (!length(singular) || min(singular) <= 1e-10) Inf else max(singular) / min(singular),
        passes_check = rr == ncol(check_x) + 1L, vif_flag = is.finite(mx) && mx >= H4_SPEC$vif_threshold, stringsAsFactors = FALSE)
    }
  }
  do.call(rbind, preflight)
}

h4_1_sensitivity_rows <- function(coefficient_results, attempt, boundary, high_ar1, fit_lme, fml, model_data,
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

h4_1_lag60_rows <- function(coefficient_results, attempt, fit_lme, fml, nested, make_design,
    centered_exposures, lagged_exposures, outcome_rows, outcome_values, thermal, heat_representation,
    eq_row, original_terms, safe_terms, eq_id, y) {
  lag_rows <- list()
  # 60-s lag sensitivity: heat terms (and heat x sound) use exposure 60 s earlier; same covariance as primary; own FDR family.
  heat_vars <- thermal[[heat_representation]]
  lagged_vars <- unique(c(heat_vars, "ucm_MRT"))
  lag_ok <- stats::complete.cases(lagged_exposures[, lagged_vars, drop = FALSE])
  lag_mix_exposures <- centered_exposures[lag_ok, , drop = FALSE]
  lag_mix_exposures[, lagged_vars] <- lagged_exposures[lag_ok, lagged_vars, drop = FALSE]
  lag_design <- make_design(lag_mix_exposures, heat_vars, outcome_rows$PhaseID[lag_ok], test = eq_row$test)
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
# Extracted verbatim from h4_1_fit.
h4_1_merge_covariance_sensitivity <- function(coef_all, sens_all) {
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

h4_1_readme_lines <- function(status_all, coef_all, sens_all, catalog, preflight_df, outcomes, raw_df,
                              agreed_common, postsel, rep_lines, fingerprints) {
  primary_cats <- c("Heat_Main_Effect", "Thermal_x_Sound")
  status_index <- match(paste(coef_all$equation_id, coef_all$outcome), paste(status_all$equation_id, status_all$outcome))
  stopifnot(!anyNA(status_index))
  unresolved_ar1 <- status_all$high_ar1_flag[status_index] %in% TRUE
  is_correlated_fit <- coef_all$residual_structure %in% c("AR1", "ARMA20") & !unresolved_ar1
  m_term <- length(outcomes)
  n_rows_fit <- status_all$n[status_all$success]
  n_text <- if (length(n_rows_fit)) sprintf("%d-%d rows per outcome-equation (median %d)", min(n_rows_fit), max(n_rows_fit), as.integer(stats::median(n_rows_fit))) else "no successful fits"
  vif_max <- suppressWarnings(max(preflight_df$max_vif[is.finite(preflight_df$max_vif)]))
  vif_txt <- if (is.finite(vif_max)) sprintf("max grouped VIF-equiv = %.2f; %d design(s) >= %s", vif_max, sum(preflight_df$vif_flag, na.rm = TRUE), H4_SPEC$vif_threshold) else "VIF not computed"
  np_rng <- range(status_all$n_participants[status_all$success], na.rm = TRUE)
  hits <- coef_all[coef_all$term_category %in% primary_cats & is.finite(coef_all$q_term) & coef_all$q_term < 0.05, , drop = FALSE]
  hits_txt <- if (nrow(hits)) sprintf("%d thermal q<0.05 row(s); see H4_coefficients.csv", nrow(hits)) else "none (no q < 0.05)"
  eq_ids <- paste(catalog$equation_id, collapse = ", ")
  c(
    "H4.1 Physiological/Ocular Time-Series Models",
    "Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md",
    sprintf("Equations (catalog ids): %s — primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.", eq_ids),
    sprintf("Sample: 10 s windows; %s; %d outcomes; participants %d-%d per model.", n_text, length(unique(status_all$outcome)), np_rng[1], np_rng[2]),
    sprintf("Design VIF (threshold %s): %s. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.", H4_SPEC$vif_threshold, vif_txt),
    sprintf("Fits: %d/%d successful outcome-equation models. FDR: BH per term within equation across outcomes (thermal + thermal x sound).", sum(status_all$success), nrow(status_all)),
    sprintf("SVF endpoint carry-forward rows: %d.", sum(raw_df$SVF_endpoint_carried)),
    sprintf("Covariates retained after Step 4: %s.", if (length(postsel)) paste(postsel, collapse = ", ") else "none"),
    sprintf("Thermal q<0.05: %s. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).", hits_txt),
    sprintf("Generated: %s UTC | code_md5 %s | input_md5 %s | audit_md5 %s | spec_md5 %s",
            format(Sys.time(), tz = "UTC", format = "%Y-%m-%d %H:%M:%S"),
            fingerprints["code_md5"], fingerprints["input_md5"], fingerprints["audit_md5"], fingerprints["spec_md5"])
  )
}

# --- Entry: design + fit (after core audit), publish via core ---
h4_run_models <- function(audit_df, raw_df, prep = NULL) {
  if (is.null(prep)) prep <- h4_step4_exposure_prep(audit_df, raw_df)
  step5_result <- h4_1_fit(audit_df, raw_df, prep = prep)
  h4_publish_outputs(audit_df, step5_result, prep = prep)
  invisible(step5_result)
}

run_h4 <- function() h4_dispatch_run()

if (sys.nframe() == 0L) run_h4()

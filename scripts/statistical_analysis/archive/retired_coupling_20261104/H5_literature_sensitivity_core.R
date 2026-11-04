# H5 literature-style sensitivity tests (phase means; separate from peak / pairwise primary H5).
# Johnson et al. (2023): multivar env -> physio LMM (within-person random intercept).
# Van Doren et al. (2021): questionnaire–physiology rmcorr (emotion coherence analogue).
# Rodrigues et al. (2026): prespecified in H4 only (7.Model_H2.py noise/temperature blocks), not here.
# Gidlow-style setting contrasts: prespecified under H1_H3, not duplicated here.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H5_literature_sensitivity_core.R.", call. = FALSE)
}
if (!exists("H5_LIT_SPEC", envir = .GlobalEnv, inherits = FALSE)) {
  stop("H5_LIT_SPEC must be set before sourcing H5_literature_sensitivity_core.R.", call. = FALSE)
}

`%||%` <- function(a, b) if (!is.null(a)) a else b
mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)

RESULTS_ROOT <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results")
OUT_DIR <- file.path(RESULTS_ROOT, H5_LIT_SPEC$results_subdir)
FILE_PREFIX <- H5_LIT_SPEC$file_prefix
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

PARTICIPANTS <- H5_LIT_SPEC$participants
CORE_PHASES <- H5_LIT_SPEC$phases
MATCHED_CAP_SEC <- H5_LIT_SPEC$matched_cap_sec
RAW_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
FDR_ALPHA <- H5_LIT_SPEC$fdr_alpha

safe_write_csv <- function(data, path) {
  tryCatch(write.csv(data, path, row.names = FALSE, na = ""), error = function(e) {
    warning("Could not write ", path, ": ", conditionMessage(e))
  })
}

h5_lit_wpz <- function(x, pid, stress_direction = 1L) {
  as.numeric(stress_direction) * paper3_within_person_z(x, pid)
}

h5_lit_load_phase_table <- function() {
  if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
  input_data <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
  input_data <- paper3_add_pair_means(input_data, list(
    atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
    atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
    atmo_humidity_avg = c(
      "atmo_lys_atmotube_left__atmotube_humidity", "atmo_lys_atmotube_right__atmotube_humidity"
    ),
    atmo_temperature_avg = c(
      "atmo_lys_atmotube_left__atmotube_temperature", "atmo_lys_atmotube_right__atmotube_temperature"
    )
  ))
  input_data$ParticipantID <- as.character(input_data$ParticipantID)
  input_data$PhaseID <- as.character(input_data$PhaseID)
  route <- input_data[input_data$ParticipantID %in% PARTICIPANTS & input_data$PhaseID %in% CORE_PHASES, ]
  route$Datetime <- as.POSIXct(route$Datetime, tz = "UTC")
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]
  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
    FUN = function(x) x - min(x, na.rm = TRUE))
  route <- paper3_merge_common_cap(route, CORE_PHASES, MATCHED_CAP_SEC)
  route <- route[!is.na(route$Common_cap) & route$time_in_phase_sec <= route$Common_cap, ]

  tf <- get0("PAPER3_APPLY_CSV_TRANSFORM", envir = .GlobalEnv, ifnotfound = NULL)
  all_raw <- unique(c(
    unlist(lapply(H5_LIT_SPEC$env_columns, `[[`, "column")),
    H5_LIT_SPEC$johnson_outcomes, H5_LIT_SPEC$vandoren_physio,
    names(H5_LIT_SPEC$psych_columns)
  ))
  missing_raw <- setdiff(all_raw, names(route))
  if (length(missing_raw)) {
    stop("H5 literature: column(s) missing in merged input: ", paste(missing_raw, collapse = ", "), call. = FALSE)
  }
  if (is.function(tf)) {
    tf_cols <- unique(c(H5_LIT_SPEC$johnson_outcomes, H5_LIT_SPEC$vandoren_physio))
    for (col in intersect(tf_cols, names(route))) {
      route[[col]] <- tf(route[[col]], col)
    }
  }
  phase <- aggregate(route[all_raw], by = route[c("ParticipantID", "PhaseID")], FUN = mean_na)
  phase$ParticipantID <- factor(phase$ParticipantID, levels = PARTICIPANTS)
  phase$PhaseID <- factor(phase$PhaseID, levels = CORE_PHASES)
  pid <- phase$ParticipantID
  for (nm in names(H5_LIT_SPEC$env_columns)) {
    spec <- H5_LIT_SPEC$env_columns[[nm]]
    phase[[paste0("env__", nm)]] <- h5_lit_wpz(phase[[spec$column]], pid, spec$stress_direction)
  }
  for (col in unique(c(H5_LIT_SPEC$johnson_outcomes, H5_LIT_SPEC$vandoren_physio))) {
    dir <- H5_LIT_SPEC$physio_stress_direction[[col]] %||% 1L
    phase[[paste0("out__", col)]] <- h5_lit_wpz(phase[[col]], pid, dir)
  }
  for (col in names(H5_LIT_SPEC$psych_columns)) {
    dir <- H5_LIT_SPEC$psych_columns[[col]]
    phase[[paste0("psych__", col)]] <- h5_lit_wpz(phase[[col]], pid, dir)
  }
  phase
}

h5_lit_apply_fdr <- function(tbl, family_col = "analysis_family") {
  if (!nrow(tbl)) return(tbl)
  tbl$q_FDR <- NA_real_
  for (fam in unique(tbl[[family_col]])) {
    idx <- which(tbl[[family_col]] == fam & tbl$fit_status == "FIT" & is.finite(tbl$p_value))
    if (length(idx)) tbl$q_FDR[idx] <- p.adjust(tbl$p_value[idx], method = "BH")
  }
  tbl$FDR_significant <- !is.na(tbl$q_FDR) & tbl$q_FDR < FDR_ALPHA
  tbl
}

h5_lit_fit_rmcorr <- function(x, y, participant) {
  dat <- data.frame(ParticipantID = factor(participant), composite_x = x, composite_y = y)
  dat <- dat[complete.cases(dat), , drop = FALSE]
  dat <- dat[dat$ParticipantID %in% names(which(table(dat$ParticipantID) >= 2)), , drop = FALSE]
  dat$ParticipantID <- droplevels(dat$ParticipantID)
  n_pid <- nlevels(dat$ParticipantID)
  if (nrow(dat) < 20L || n_pid < 8L) {
    return(list(status = "NOT_FIT_INSUFFICIENT_DATA", n = nrow(dat), n_pid = n_pid))
  }
  if (sd(dat$composite_x) == 0 || sd(dat$composite_y) == 0) {
    return(list(status = "NOT_FIT_ZERO_VARIANCE", n = nrow(dat), n_pid = n_pid))
  }
  fit <- tryCatch(lm(composite_y ~ ParticipantID + composite_x, data = dat), error = function(e) NULL)
  if (is.null(fit)) return(list(status = "FAILED", n = nrow(dat), n_pid = n_pid))
  cf <- summary(fit)$coefficients["composite_x", ]
  dfr <- fit$df.residual
  t_val <- cf[["t value"]]
  r_rm <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + dfr))
  list(
    status = "FIT", n = nrow(dat), n_pid = n_pid,
    estimate = cf[["Estimate"]], std_error = cf[["Std. Error"]], df = dfr,
    statistic = t_val, p_value = cf[["Pr(>|t|)"]], r_rm = r_rm
  )
}

h5_lit_fit_lmm <- function(dat, y_col, fixed_rhs) {
  req <- unique(c(y_col, unlist(strsplit(fixed_rhs, " + ", fixed = TRUE)), "ParticipantID", "PhaseID"))
  missing_vars <- setdiff(req, names(dat))
  if (length(missing_vars)) {
    return(list(status = "FAILED_MISSING_VARS", n_obs = NA_integer_, n_pid = NA_integer_))
  }
  sub <- dat[complete.cases(dat[req]), req, drop = FALSE]
  n_obs <- nrow(sub)
  n_pid <- length(unique(sub$ParticipantID))
  if (n_obs < 20L || n_pid < 8L) {
    return(list(status = "NOT_FIT_INSUFFICIENT_DATA", n_obs = n_obs, n_pid = n_pid))
  }
  if (!is.finite(sd(sub[[y_col]], na.rm = TRUE)) || sd(sub[[y_col]], na.rm = TRUE) == 0) {
    return(list(status = "NOT_FIT_ZERO_VARIANCE", n_obs = n_obs, n_pid = n_pid))
  }
  form <- as.formula(paste(y_col, "~", fixed_rhs))
  sub$ParticipantID <- factor(sub$ParticipantID)
  sub$PhaseID <- factor(sub$PhaseID, levels = CORE_PHASES)
  fit <- tryCatch(
    nlme::lme(form, data = sub, random = ~ 1 | ParticipantID, method = "REML",
      control = nlme::lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = FALSE)),
    error = function(e) NULL
  )
  if (is.null(fit)) return(list(status = "FAILED_CONVERGENCE", n_obs = n_obs, n_pid = n_pid))
  list(status = "FIT", n_obs = n_obs, n_pid = n_pid, tTable = summary(fit)$tTable,
    model_formula = sprintf("lme(%s ~ %s, random = ~1|ParticipantID)", y_col, fixed_rhs))
}

h5_lit_extract_term <- function(fit_obj, term) {
  if (is.null(fit_obj$tTable) || !term %in% rownames(fit_obj$tTable)) {
    return(list(estimate = NA_real_, std_error = NA_real_, df = NA_real_, statistic = NA_real_, p_value = NA_real_))
  }
  cf <- fit_obj$tTable[term, , drop = FALSE]
  list(
    estimate = cf[1, "Value"], std_error = cf[1, "Std.Error"], df = cf[1, "DF"],
    statistic = cf[1, "t-value"], p_value = cf[1, "p-value"]
  )
}

h5_lit_johnson_multivar <- function(phase) {
  rows <- list()
  outcomes <- H5_LIT_SPEC$johnson_outcomes
  pred_ids <- H5_LIT_SPEC$johnson_predictors
  pred_cols <- paste0("env__", pred_ids)
  rhs <- paste(c(pred_cols, "PhaseID"), collapse = " + ")
  for (out_id in outcomes) {
    y_col <- paste0("out__", out_id)
    fit <- h5_lit_fit_lmm(phase, y_col, rhs)
    for (pred_id in pred_ids) {
      term <- paste0("env__", pred_id)
      ex <- h5_lit_extract_term(fit, term)
      rows[[length(rows) + 1L]] <- data.frame(
        literature_source = "Johnson_Kanjo_Woodward_2023",
        analysis_family = "H5_lit_Johnson_multivar_env_physio",
        citation_note = "Multivar LMM analogue of Table 3 (EDA/HR ~ PM + noise); NH3 omitted (not measured).",
        outcome = out_id, predictor = pred_id,
        estimand = "phase-mean WPZ physio ~ WPZ PM/noise + PhaseID",
        fit_status = fit$status, model_formula = fit$model_formula %||% "",
        n_observations = fit$n_obs %||% NA_integer_, n_participants = fit$n_pid %||% NA_integer_,
        estimate = ex$estimate, std_error = ex$std_error, df = ex$df,
        statistic = ex$statistic, p_value = ex$p_value, stringsAsFactors = FALSE
      )
    }
  }
  h5_lit_apply_fdr(do.call(rbind, rows))
}

h5_lit_vandoren_rmcorr <- function(phase) {
  rows <- list()
  for (psych_id in names(H5_LIT_SPEC$psych_columns)) {
    x <- phase[[paste0("psych__", psych_id)]]
    for (out_id in H5_LIT_SPEC$vandoren_physio) {
      y <- phase[[paste0("out__", out_id)]]
      fit <- h5_lit_fit_rmcorr(x, y, phase$ParticipantID)
      rows[[length(rows) + 1L]] <- data.frame(
        literature_source = "Van_Doren_et_al_2021",
        analysis_family = "H5_lit_VanDoren_psych_physio_rmcorr",
        citation_note = "Phase-mean questionnaire WPZ vs physio WPZ (EMA coherence analogue; not momentary).",
        questionnaire = psych_id, physiological_outcome = out_id,
        fit_status = fit$status, n_observations = fit$n %||% NA_integer_,
        n_participants = fit$n_pid %||% NA_integer_,
        r_rm = fit$r_rm %||% NA_real_, estimate = fit$estimate %||% NA_real_,
        std_error = fit$std_error %||% NA_real_, df = fit$df %||% NA_real_,
        statistic = fit$statistic %||% NA_real_, p_value = fit$p_value %||% NA_real_,
        stringsAsFactors = FALSE
      )
    }
  }
  h5_lit_apply_fdr(do.call(rbind, rows))
}

h5_literature_sensitivity_run <- function() {
  cat("[H5 literature] Loading phase means...\n")
  phase <- h5_lit_load_phase_table()
  stale <- c("_rodrigues_rmcorr.csv", "_rodrigues_multivar.csv")
  for (suf in stale) {
    p <- file.path(OUT_DIR, paste0(FILE_PREFIX, suf))
    if (file.exists(p)) unlink(p)
  }
  cat("[H5 literature] Johnson (2023) multivar env -> physio...\n")
  johnson <- h5_lit_johnson_multivar(phase)
  safe_write_csv(johnson, file.path(OUT_DIR, paste0(FILE_PREFIX, "_johnson_multivar.csv")))
  cat("[H5 literature] Van Doren psych–physio rmcorr...\n")
  vand <- h5_lit_vandoren_rmcorr(phase)
  safe_write_csv(vand, file.path(OUT_DIR, paste0(FILE_PREFIX, "_vandoren_rmcorr.csv")))
  manifest <- data.frame(
    Metric = c(
      "entry_script", "analysis_grain", "n_johnson_tests_fit", "n_johnson_FDR_significant",
      "n_vandoren_rmcorr_fit", "n_vandoren_FDR_significant",
      "notes_Rodrigues_2026", "notes_Gidlow_2016", "notes_Kim_2023_ML", "notes_Bakdash_pairwise"
    ),
    Value = c(
      H5_LIT_SPEC$entry_script, "phaseavg",
      sum(johnson$fit_status == "FIT"), sum(johnson$FDR_significant %in% TRUE, na.rm = TRUE),
      sum(vand$fit_status == "FIT"), sum(vand$FDR_significant %in% TRUE, na.rm = TRUE),
      "Noise/Temperature blocks (7.Model_H2.py): H4_sound_literature_test.R only — not duplicated in H5.",
      "Setting contrast (green vs urban): see H1_H3, not duplicated here.",
      "Spatial ML classifier: not replicated (different estimand).",
      "Within-person pairwise grid: see H5_stress_composite_pairwise.R."
    ),
    stringsAsFactors = FALSE
  )
  safe_write_csv(manifest, file.path(OUT_DIR, paste0(FILE_PREFIX, "_run_manifest.csv")))
  cat(sprintf(
    "[H5 literature] Done. Johnson FDR: %d; Van Doren FDR: %d. %s\n",
    sum(johnson$FDR_significant %in% TRUE, na.rm = TRUE),
    sum(vand$FDR_significant %in% TRUE, na.rm = TRUE),
    OUT_DIR
  ))
  invisible(list(johnson = johnson, vandoren = vand))
}

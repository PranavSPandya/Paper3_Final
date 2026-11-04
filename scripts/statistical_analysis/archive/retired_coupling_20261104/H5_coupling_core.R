# H5: environmental exposure and 26 physiological outcomes only (no questionnaires).
# Primary — peak-centered cumulative exposure within each bout, then post-peak physio LMMs.
# Secondary — env-index coupling LMMs (thermal, acoustic, restorative loads).
# Cumulative exposure = cumulative sum of bout-mean-centered, stress-oriented epoch values.

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H5_coupling_core.R.", call. = FALSE)
}

`%||%` <- function(a, b) if (!is.null(a)) a else b
mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)

h5_env_condition_definitions <- function() {
  list(
    ucm_UTCI = list(column = "ucm_UTCI", stress_direction = 1L),
    ucm_PET = list(column = "ucm_PET", stress_direction = 1L),
    ucm_MRT = list(column = "ucm_MRT", stress_direction = 1L),
    ucm_AIR_temp = list(column = "ucm_AIR_temp", stress_direction = 1L),
    ucm_AIR_RH = list(column = "ucm_AIR_RH", stress_direction = 1L),
    ucm_WIND_AWS = list(column = "ucm_WIND_AWS", stress_direction = 1L),
    ucm_SUN_Gh = list(column = "ucm_SUN_Gh", stress_direction = 1L),
    ucm_SND_dBA = list(column = "ucm_SND_dBA", stress_direction = 1L),
    ucm_HUMIDEX = list(column = "ucm_HUMIDEX", stress_direction = 1L),
    ucm_AIR_T_mid = list(column = "ucm_AIR_T_mid", stress_direction = 1L),
    atmo_pm1_avg = list(column = "atmo_pm1_avg", stress_direction = 1L),
    atmo_pm2.5_avg = list(column = "atmo_pm2.5_avg", stress_direction = 1L),
    atmo_pm10_avg = list(column = "atmo_pm10_avg", stress_direction = 1L),
    atmo_humidity_avg = list(column = "atmo_humidity_avg", stress_direction = 1L),
    atmo_temperature_avg = list(column = "atmo_temperature_avg", stress_direction = 1L),
    lys_lux_avg = list(column = "lys_lux_avg", stress_direction = 1L),
    lys_kelvin_avg = list(column = "lys_kelvin_avg", stress_direction = 1L),
    SVF = list(column = "SVF", stress_direction = -1L),
    TVF = list(column = "TVF", stress_direction = -1L),
    gvi_50m = list(column = "gvi_50m", stress_direction = -1L),
    ucm_GPS_speed_kmh = list(column = "ucm_GPS_speed_kmh", stress_direction = 1L)
  )
}

h5_stress_composite_spec <- function(grain) {
  prefix <- paste0("H5_stress_composite_", grain)
  physio_all <- paper3_physiological_outcomes()
  spec <- list(
    analysis_grain = grain,
    results_subdir = prefix,
    entry_script = paste0(prefix, ".R"),
    file_prefix = prefix,
    participants = PAPER3_PARTICIPANTS,
    phases = PAPER3_CORE_PHASES,
    matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
    physiological_outcome_names = physio_all,
    physio_outcomes = physio_all,
    env_index_names = c("thermal_load", "acoustic_load", "restorative_stress"),
    env_index_constituents = list(
      thermal_load = list(column = "ucm_UTCI", stress_direction = 1L),
      acoustic_load = list(column = "ucm_SND_dBA", stress_direction = 1L)
    ),
    restorative_constituents = c("SVF", "TVF", "gvi_50m"),
    morphology_stress_direction = c(SVF = -1L, TVF = -1L, gvi_50m = -1L),
    env_condition_definitions = h5_env_condition_definitions(),
    fdr_alpha = 0.05
  )
  paper3_attach_outcome_normalization(spec, PROJECT_ROOT)
}

h5_stress_composite_setup <- function(grain) {
  spec <- h5_stress_composite_spec(grain)
  results_root <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results")
  list2env(list(
    H5_SPEC = spec,
    OUTCOME_TRANSFORMS_CSV = spec$outcome_transforms_csv,
    RESULTS_ROOT = results_root,
    OUT_DIR = file.path(results_root, spec$results_subdir),
    PARTICIPANTS = spec$participants,
    CORE_PHASES = spec$phases,
    MATCHED_CAP_SEC = spec$matched_cap_sec,
    RAW_PATH = paper3_merged_8min_path(PROJECT_ROOT),
    GRAIN = spec$analysis_grain,
    ENTRY_SCRIPT = spec$entry_script,
    FILE_PREFIX = spec$file_prefix
  ), envir = .GlobalEnv)
  dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
  assign("PAPER3_APPLY_CSV_TRANSFORM", function(x, column_name) {
    paper3_apply_csv_transform(x, column_name, OUTCOME_TRANSFORMS_CSV)
  }, envir = .GlobalEnv)
}

h5_stress_composite_run <- function(grain) {
  h5_stress_composite_setup(grain)
  cat(sprintf(
    "Running H5 (%s): peak-centered env exposure + env-index/physio LMMs (no questionnaires)...\n",
    if (grain == "phaseavg") "phase means" else "10 s epochs + AR(1)"
  ))
  h5_coupling_run()
}

safe_write_csv <- function(data, path) {
  tryCatch(write.csv(data, path, row.names = FALSE, na = ""), error = function(e) {
    warning("Could not write ", path, ": ", conditionMessage(e))
  })
}

h5_wpz <- function(x, pid) {
  fn <- get0("PAPER3_OUTCOME_WITHIN_PERSON_Z", envir = .GlobalEnv, ifnotfound = paper3_within_person_z)
  fn(x, pid)
}

h5_oriented_wpz <- function(x, pid, stress_direction, transform_fn = NULL, col = NULL) {
  if (is.function(transform_fn) && !is.null(col)) x <- transform_fn(x, col)
  as.numeric(stress_direction) * h5_wpz(x, pid)
}

h5_composite_rowmean <- function(mat) {
  if (is.null(mat) || ncol(mat) == 0) return(rep(NA_real_, nrow(mat)))
  rowMeans(as.matrix(mat), na.rm = TRUE)
}

h5_load_matched_route <- function() {
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
    ),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
    lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin")
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
  route$ParticipantID <- factor(route$ParticipantID, levels = PARTICIPANTS)
  route$PhaseID <- factor(route$PhaseID, levels = CORE_PHASES)
  route$time_10s_step <- as.integer(floor(route$time_in_phase_sec / 10))
  route
}

h5_build_analysis_frame <- function(route) {
  tf <- get0("PAPER3_APPLY_CSV_TRANSFORM", envir = .GlobalEnv, ifnotfound = NULL)
  physio_cols <- H5_SPEC$physio_outcomes
  env_single <- H5_SPEC$env_index_constituents
  morph <- H5_SPEC$restorative_constituents
  need_raw <- unique(c(
    unlist(lapply(env_single, `[[`, "column")),
    morph, physio_cols
  ))
  missing_raw <- setdiff(need_raw, names(route))
  if (length(missing_raw)) {
    stop(
      "H5 coupling: column(s) not in merged input: ", paste(missing_raw, collapse = ", "),
      call. = FALSE
    )
  }
  if (is.function(tf)) {
    for (col in intersect(physio_cols, names(route))) route[[col]] <- tf(route[[col]], col)
  }
  if (GRAIN == "phaseavg") {
    base <- aggregate(route[need_raw], by = route[c("ParticipantID", "PhaseID")], FUN = mean_na)
  } else {
    base <- route[c("ParticipantID", "PhaseID", "time_10s_step", need_raw)]
  }
  pid <- base$ParticipantID
  for (nm in names(env_single)) {
    spec <- env_single[[nm]]
    base[[paste0("idx_", nm)]] <- h5_oriented_wpz(base[[spec$column]], pid, spec$stress_direction)
  }
  morph_wpz <- list()
  for (col in morph) {
    dir <- H5_SPEC$morphology_stress_direction[[col]]
    morph_wpz[[col]] <- h5_oriented_wpz(base[[col]], pid, dir)
  }
  base$idx_restorative_stress <- h5_composite_rowmean(as.data.frame(morph_wpz))
  for (col in physio_cols) {
    base[[paste0("out_", col)]] <- h5_wpz(base[[col]], pid)
  }
  base
}

h5_fit_lmm_row <- function(dat, y_col, fixed_rhs, timeseries = FALSE) {
  req <- unique(c(y_col, unlist(strsplit(fixed_rhs, " + ", fixed = TRUE)), "ParticipantID", "PhaseID"))
  if (timeseries) req <- c(req, "time_10s_step")
  missing_vars <- setdiff(req, names(dat))
  if (length(missing_vars)) {
    stop(
      "H5 coupling: model variable(s) missing: ", paste(missing_vars, collapse = ", "),
      " (", y_col, " ~ ", fixed_rhs, ")", call. = FALSE
    )
  }
  analysis_data <- dat[complete.cases(dat[req]), req, drop = FALSE]
  n_obs <- nrow(analysis_data)
  n_pid <- length(unique(analysis_data$ParticipantID))
  min_rows <- if (timeseries) 120L else 20L
  if (n_obs < min_rows || n_pid < 8L) {
    return(list(status = "NOT_FIT_INSUFFICIENT_DATA", n_obs = n_obs, n_pid = n_pid))
  }
  if (!is.finite(sd(analysis_data[[y_col]], na.rm = TRUE)) || sd(analysis_data[[y_col]], na.rm = TRUE) == 0) {
    return(list(status = "NOT_FIT_ZERO_VARIANCE", n_obs = n_obs, n_pid = n_pid))
  }
  form <- as.formula(paste(y_col, "~", fixed_rhs))
  analysis_data$ParticipantID <- factor(analysis_data$ParticipantID)
  analysis_data$PhaseID <- factor(analysis_data$PhaseID, levels = CORE_PHASES)
  structure <- NA_character_
  fit <- tryCatch({
    if (timeseries) {
      analysis_data <- analysis_data[order(
        analysis_data$ParticipantID, analysis_data$PhaseID, analysis_data$time_10s_step
      ), ]
      ar1_form <- nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID)
      out <- tryCatch(
        nlme::lme(form, data = analysis_data, random = ~ 1 | ParticipantID, correlation = ar1_form,
          method = "REML", control = nlme::lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = FALSE)),
        error = function(e) NULL
      )
      if (!is.null(out)) structure <- "AR1"
      out
    } else {
      structure <- "INDEPENDENT_PHASE_MEANS"
      nlme::lme(form, data = analysis_data, random = ~ 1 | ParticipantID, method = "REML",
        control = nlme::lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = FALSE))
    }
  }, error = function(e) NULL)
  if (is.null(fit)) return(list(status = "FAILED_CONVERGENCE", n_obs = n_obs, n_pid = n_pid))
  list(status = "FIT", n_obs = n_obs, n_pid = n_pid, fit = fit, tTable = summary(fit)$tTable,
    residual_structure = structure)
}

h5_model_formula <- function(y_col, rhs_text, fit_obj) {
  structure <- fit_obj$residual_structure %||% NA_character_
  re_txt <- if (identical(structure, "AR1") || (is.na(structure) && GRAIN == "timeseries")) {
    "random = ~1 | ParticipantID, correlation = corAR1(~ time_10s_step | ParticipantID/PhaseID)"
  } else {
    "random = ~1 | ParticipantID"
  }
  sprintf("lme(%s ~ %s, %s)", y_col, rhs_text, re_txt)
}

h5_extract_term <- function(fit_obj, term) {
  if (is.null(fit_obj$fit) || !term %in% rownames(fit_obj$tTable)) {
    return(list(
      estimate = NA_real_, std_error = NA_real_, df = NA_real_,
      statistic = NA_real_, p_value = NA_real_
    ))
  }
  cf <- fit_obj$tTable[term, , drop = FALSE]
  list(
    estimate = cf[1, "Value"],
    std_error = cf[1, "Std.Error"],
    df = cf[1, "DF"],
    statistic = cf[1, "t-value"],
    p_value = cf[1, "p-value"]
  )
}

h5_apply_fdr <- function(tbl, family_col = "analysis_family") {
  if (!nrow(tbl)) return(tbl)
  tbl$q_FDR <- NA_real_
  for (fam in unique(tbl[[family_col]])) {
    index <- which(tbl[[family_col]] == fam & tbl$fit_status == "FIT" & is.finite(tbl$p_value))
    if (length(index)) tbl$q_FDR[index] <- p.adjust(tbl$p_value[index], method = "BH")
  }
  tbl$FDR_significant <- !is.na(tbl$q_FDR) & tbl$q_FDR < H5_SPEC$fdr_alpha
  tbl
}

h5_peak_published_csv_basenames <- function() {
  c(
    paste0(FILE_PREFIX, "_peak_timing_per_bout.csv"),
    paste0(FILE_PREFIX, "_peak_postpeak_physio_effects.csv"),
    paste0(FILE_PREFIX, "_peak_fdr_survivors.csv"),
    paste0(FILE_PREFIX, "_peak_fdr_family_summary.csv"),
    paste0(FILE_PREFIX, "_run_manifest.csv")
  )
}

h5_write_peak_fdr_summaries <- function(effects) {
  survivors <- effects[effects$FDR_significant %in% TRUE, , drop = FALSE]
  safe_write_csv(survivors, file.path(OUT_DIR, paste0(FILE_PREFIX, "_peak_fdr_survivors.csv")))
  fit_n <- sum(effects$fit_status == "FIT", na.rm = TRUE)
  sig_n <- sum(effects$FDR_significant %in% TRUE, na.rm = TRUE)
  qv <- effects$q_FDR[is.finite(effects$q_FDR)]
  family_summary <- data.frame(
    analysis_family = "H5_peak_post_exposure_physio",
    analysis_grain = GRAIN,
    fdr_alpha = H5_SPEC$fdr_alpha,
    adjustment_method = "BH",
    n_tests_total = nrow(effects),
    n_tests_fit = fit_n,
    n_FDR_significant = sig_n,
    min_q_FDR = if (length(qv)) min(qv) else NA_real_,
    stringsAsFactors = FALSE
  )
  safe_write_csv(family_summary, file.path(OUT_DIR, paste0(FILE_PREFIX, "_peak_fdr_family_summary.csv")))
  invisible(list(n_tests_fit = fit_n, n_FDR_significant = sig_n, min_q_FDR = family_summary$min_q_FDR[1L]))
}

h5_discover_varying_env_conditions <- function(route, definitions) {
  definitions <- definitions[vapply(definitions, function(d) d$column %in% names(route), logical(1))]
  keep <- vapply(names(definitions), function(nm) {
    col <- definitions[[nm]]$column
    sds <- tapply(route[[col]], route$ParticipantPhaseID, function(x) {
      x <- x[is.finite(x)]
      if (length(x) < 3L) return(NA_real_)
      stats::sd(x)
    })
    sum(is.finite(sds) & sds > 1e-6, na.rm = TRUE) >= 8L
  }, logical(1))
  definitions[keep]
}

h5_peak_and_postpeak_one_bout <- function(bout_rows, env_column, stress_direction, physio_columns) {
  bout_rows <- bout_rows[order(bout_rows$time_10s_step), , drop = FALSE]
  n_epochs <- nrow(bout_rows)
  if (n_epochs < 8L) return(list(status = "SKIP_TOO_SHORT"))
  raw_env <- bout_rows[[env_column]]
  if (!any(is.finite(raw_env)) || stats::sd(raw_env, na.rm = TRUE) < 1e-8) {
    return(list(status = "SKIP_NO_ENV_VARIANCE"))
  }
  bout_mean_env <- mean(raw_env, na.rm = TRUE)
  centered_stress_env <- as.numeric(stress_direction) * (raw_env - bout_mean_env)
  centered_stress_env[!is.finite(centered_stress_env)] <- 0
  cumulative_exposure <- cumsum(centered_stress_env)
  peak_epoch <- which.max(cumulative_exposure)
  peak_seconds <- (peak_epoch - 1L) * 10L
  post_mask <- seq_len(n_epochs) > peak_epoch
  post_peak_exposure_total <- sum(centered_stress_env[post_mask], na.rm = TRUE)
  pid <- bout_rows$ParticipantID[1L]
  physio_post_means <- setNames(
    vapply(physio_columns, function(pcol) {
      mean(h5_wpz(bout_rows[[pcol]], pid)[post_mask], na.rm = TRUE)
    }, numeric(1)),
    physio_columns
  )
  list(
    status = "OK",
    n_epochs = n_epochs,
    bout_length_seconds = max(bout_rows$time_in_phase_sec, na.rm = TRUE),
    peak_epoch = peak_epoch,
    peak_seconds = peak_seconds,
    post_peak_exposure_total = post_peak_exposure_total,
    n_post_peak_epochs = sum(post_mask),
    physio_post_means = physio_post_means
  )
}

h5_build_peak_timing_and_postpeak_table <- function(route) {
  defs <- h5_discover_varying_env_conditions(route, H5_SPEC$env_condition_definitions)
  physio_cols <- H5_SPEC$physio_outcomes
  tf <- get0("PAPER3_APPLY_CSV_TRANSFORM", envir = .GlobalEnv, ifnotfound = NULL)
  if (is.function(tf)) {
    for (col in intersect(physio_cols, names(route))) route[[col]] <- tf(route[[col]], col)
  }
  timing_by_cond <- list()
  effect_by_cond <- list()
  split_route <- split(route, route$ParticipantPhaseID)
  for (cond_id in names(defs)) {
    spec <- defs[[cond_id]]
    timing_chunks <- list()
    effect_chunks <- list()
    for (bout in split_route) {
      res <- h5_peak_and_postpeak_one_bout(bout, spec$column, spec$stress_direction, physio_cols)
      if (res$status != "OK") next
      pid <- as.character(bout$ParticipantID[1L])
      phase <- as.character(bout$PhaseID[1L])
      timing_chunks[[length(timing_chunks) + 1L]] <- data.frame(
        ParticipantID = pid, PhaseID = phase, env_condition = cond_id, env_column = spec$column,
        peak_epoch = res$peak_epoch, peak_seconds_from_bout_start = res$peak_seconds,
        bout_length_epochs = res$n_epochs, bout_length_seconds = res$bout_length_seconds,
        n_post_peak_epochs = res$n_post_peak_epochs, post_peak_exposure_total = res$post_peak_exposure_total,
        stringsAsFactors = FALSE
      )
      effect_chunks[[length(effect_chunks) + 1L]] <- data.frame(
        ParticipantID = pid, PhaseID = phase, env_condition = cond_id,
        physiological_outcome = physio_cols,
        post_peak_exposure_total = res$post_peak_exposure_total,
        post_peak_physio_mean_wpz = as.numeric(res$physio_post_means[physio_cols]),
        stringsAsFactors = FALSE
      )
    }
    if (length(timing_chunks)) timing_by_cond[[cond_id]] <- do.call(rbind, timing_chunks)
    if (length(effect_chunks)) effect_by_cond[[cond_id]] <- do.call(rbind, effect_chunks)
  }
  list(
    varying_conditions = names(defs),
    peak_timing = if (length(timing_by_cond)) do.call(rbind, timing_by_cond) else data.frame(),
    postpeak_long = if (length(effect_by_cond)) do.call(rbind, effect_by_cond) else data.frame()
  )
}

h5_fit_postpeak_lmm <- function(long_tbl, outcome_id) {
  sub <- long_tbl[long_tbl$physiological_outcome == outcome_id, , drop = FALSE]
  sub <- sub[complete.cases(sub[c(
    "post_peak_physio_mean_wpz", "post_peak_exposure_total", "ParticipantID", "PhaseID"
  )]), , drop = FALSE]
  n_obs <- nrow(sub)
  n_pid <- length(unique(sub$ParticipantID))
  if (n_obs < 20L || n_pid < 8L) {
    return(list(status = "NOT_FIT_INSUFFICIENT_DATA", n_obs = n_obs, n_pid = n_pid))
  }
  if (stats::sd(sub$post_peak_exposure_total) == 0) {
    return(list(status = "NOT_FIT_ZERO_VARIANCE", n_obs = n_obs, n_pid = n_pid))
  }
  sub$ParticipantID <- factor(sub$ParticipantID)
  sub$PhaseID <- factor(sub$PhaseID, levels = CORE_PHASES)
  form <- post_peak_physio_mean_wpz ~ post_peak_exposure_total + PhaseID
  fit <- tryCatch(
    nlme::lme(form, data = sub, random = ~ 1 | ParticipantID, method = "REML",
      control = nlme::lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = FALSE)),
    error = function(e) NULL
  )
  if (is.null(fit)) return(list(status = "FAILED_CONVERGENCE", n_obs = n_obs, n_pid = n_pid))
  tt <- summary(fit)$tTable
  term <- "post_peak_exposure_total"
  if (!term %in% rownames(tt)) return(list(status = "FAILED_NO_TERM", n_obs = n_obs, n_pid = n_pid))
  cf <- tt[term, , drop = FALSE]
  list(
    status = "FIT", n_obs = n_obs, n_pid = n_pid,
    estimate = cf[1, "Value"], std_error = cf[1, "Std.Error"], df = cf[1, "DF"],
    statistic = cf[1, "t-value"], p_value = cf[1, "p-value"],
    model_formula = paste0(
      "lme(post_peak_physio_mean_wpz ~ post_peak_exposure_total + PhaseID, random = ~1|ParticipantID)"
    )
  )
}

h5_run_peak_centered_analysis <- function(route) {
  built <- h5_build_peak_timing_and_postpeak_table(route)
  long <- built$postpeak_long
  if (!nrow(long)) {
    return(list(peak_timing = built$peak_timing, postpeak_effects = data.frame(), varying_conditions = character()))
  }
  rows <- list()
  for (cond in unique(long$env_condition)) {
    sub_long <- long[long$env_condition == cond, , drop = FALSE]
    for (out_id in H5_SPEC$physio_outcomes) {
      fit <- h5_fit_postpeak_lmm(sub_long, out_id)
      rows[[length(rows) + 1L]] <- data.frame(
        hypothesis = "H5",
        analysis_family = "H5_peak_post_exposure_physio",
        analysis_grain = GRAIN,
        env_condition = cond,
        outcome = out_id,
        estimand = "post_peak_mean_wpz_physio ~ post_peak_exposure_total (+ PhaseID)",
        fit_status = fit$status,
        model_formula = fit$model_formula %||% "",
        n_observations = fit$n_obs %||% NA_integer_,
        n_participants = fit$n_pid %||% NA_integer_,
        estimate = fit$estimate %||% NA_real_,
        std_error = fit$std_error %||% NA_real_,
        df = fit$df %||% NA_real_,
        statistic = fit$statistic %||% NA_real_,
        p_value = fit$p_value %||% NA_real_,
        stringsAsFactors = FALSE
      )
    }
  }
  effects <- h5_apply_fdr(do.call(rbind, rows))
  safe_write_csv(built$peak_timing, file.path(OUT_DIR, paste0(FILE_PREFIX, "_peak_timing_per_bout.csv")))
  safe_write_csv(effects, file.path(OUT_DIR, paste0(FILE_PREFIX, "_peak_postpeak_physio_effects.csv")))
  h5_write_peak_fdr_summaries(effects)
  list(
    peak_timing = built$peak_timing, postpeak_effects = effects,
    varying_conditions = built$varying_conditions
  )
}

h5_purge_stale_outputs <- function() {
  if (!dir.exists(OUT_DIR)) return(invisible(NULL))
  keep <- h5_peak_published_csv_basenames()
  for (path in list.files(OUT_DIR, full.names = TRUE)) {
    bn <- basename(path)
    if (bn %in% keep) next
    if (grepl("\\.csv$", bn, ignore.case = TRUE)) unlink(path)
  }
  invisible(NULL)
}

h5_coupling_run <- function() {
  cat(sprintf("[H5 / %s] Loading matched 8-min data...\n", GRAIN))
  h5_purge_stale_outputs()
  route <- h5_load_matched_route()
  cat(sprintf("[H5 / %s] Peak-centered cumulative exposure (primary)...\n", GRAIN))
  peak_out <- h5_run_peak_centered_analysis(route)
  dat <- h5_build_analysis_frame(route)
  timeseries <- GRAIN == "timeseries"
  env_idx <- H5_SPEC$env_index_names
  phys_y_cols <- stats::setNames(paste0("out_", H5_SPEC$physio_outcomes), H5_SPEC$physio_outcomes)
  cat(sprintf("[H5 / %s] Env-index coupling LMMs (secondary)...\n", GRAIN))
  rows_a <- list()
  for (y_id in names(phys_y_cols)) {
    y_col <- phys_y_cols[[y_id]]
    for (x_id in env_idx) {
      x_col <- paste0("idx_", x_id)
      rhs <- paste(x_col, "PhaseID", sep = " + ")
      fit <- h5_fit_lmm_row(dat, y_col, rhs, timeseries = timeseries)
      ex <- h5_extract_term(fit, x_col)
      rows_a[[length(rows_a) + 1L]] <- data.frame(
        hypothesis = "H5", analysis_family = "H5_A_env_physio", analysis_grain = GRAIN,
        outcome = y_id, term = x_id, env_index = x_id, fit_status = fit$status,
        residual_structure = fit$residual_structure %||% NA_character_,
        model_formula = h5_model_formula(y_col, rhs, fit),
        n_observations = fit$n_obs %||% NA_integer_, n_participants = fit$n_pid %||% NA_integer_,
        estimate = ex$estimate, std_error = ex$std_error, df = ex$df,
        statistic = ex$statistic, p_value = ex$p_value, stringsAsFactors = FALSE
      )
    }
  }
  tbl_a <- h5_apply_fdr(do.call(rbind, rows_a))
  n_peak <- nrow(peak_out$postpeak_effects)
  n_peak_fdr <- sum(peak_out$postpeak_effects$FDR_significant %in% TRUE, na.rm = TRUE)
  n_peak_fit <- sum(peak_out$postpeak_effects$fit_status == "FIT")
  n_h5_a_fdr <- sum(tbl_a$FDR_significant %in% TRUE, na.rm = TRUE)
  manifest <- data.frame(
    Metric = c(
      "analysis_grain", "entry_script", "varying_env_conditions",
      "peak_fdr_family", "n_peak_tests", "n_peak_tests_fit", "n_peak_FDR_significant",
      "n_env_physio_tests", "H5_A_FDR_significant",
      "peak_timing_median_seconds_ucm_UTCI", "peak_timing_median_seconds_ucm_WIND_AWS",
      "peak_timing_median_seconds_ucm_AIR_RH"
    ),
    Value = c(
      GRAIN, ENTRY_SCRIPT, paste(peak_out$varying_conditions, collapse = ";"),
      "H5_peak_post_exposure_physio: one BH family over all condition x outcome tests",
      n_peak, n_peak_fit, n_peak_fdr, nrow(tbl_a), n_h5_a_fdr,
      h5_median_peak_seconds(peak_out$peak_timing, "ucm_UTCI"),
      h5_median_peak_seconds(peak_out$peak_timing, "ucm_WIND_AWS"),
      h5_median_peak_seconds(peak_out$peak_timing, "ucm_AIR_RH")
    ),
    stringsAsFactors = FALSE
  )
  safe_write_csv(manifest, file.path(OUT_DIR, paste0(FILE_PREFIX, "_run_manifest.csv")))
  h5_purge_stale_outputs()
  cat(sprintf(
    "[H5 / %s] Done. Peak: %d/%d FDR q<%.2f; env–physio: %d/%d FDR q<%.2f. %s\n",
    GRAIN, n_peak_fdr, n_peak_fit, H5_SPEC$fdr_alpha,
    n_h5_a_fdr, sum(tbl_a$fit_status == "FIT"), H5_SPEC$fdr_alpha,
    OUT_DIR
  ))
  invisible(list(peak = peak_out, env_physio = tbl_a))
}

h5_median_peak_seconds <- function(timing_tbl, condition_id) {
  if (!nrow(timing_tbl)) return(NA_character_)
  sub <- timing_tbl[timing_tbl$env_condition == condition_id, "peak_seconds_from_bout_start", drop = TRUE]
  sub <- sub[is.finite(sub)]
  if (!length(sub)) return(NA_character_)
  as.character(stats::median(sub))
}

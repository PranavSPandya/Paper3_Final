# H9_stress_composite_core.R — phase-mean composites and pairwise rmcorr (sourced by H9_stress_composite.R).

if (!exists("PROJECT_ROOT", envir = .GlobalEnv, inherits = FALSE)) {
  stop("PROJECT_ROOT must be set before sourcing H9_stress_composite_core.R.", call. = FALSE)
}
if (!exists("H9_SPEC", envir = .GlobalEnv, inherits = FALSE)) {
  stop("H9_SPEC must be set before sourcing H9_stress_composite_core.R.", call. = FALSE)
}

RESULTS_ROOT <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results")
OUT_DIR <- file.path(RESULTS_ROOT, "H9_stress_composite")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

PARTICIPANTS <- H9_SPEC$participants
CORE_PHASES <- H9_SPEC$phases
MATCHED_CAP_SEC <- H9_SPEC$matched_cap_sec
RAW_PATH <- paper3_merged_8min_path(PROJECT_ROOT)

mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)
safe_write_csv <- function(data, path) {
  tryCatch(write.csv(data, path, row.names = FALSE, na = ""), error = function(e) {
    warning("Could not write ", path, ": ", conditionMessage(e))
  })
}

h9_pair_mean_columns <- function(df) {
  safe_pair_mean <- function(data, left, right) {
    if (!all(c(left, right) %in% names(data))) return(rep(NA_real_, nrow(data)))
    z <- rowMeans(cbind(as.numeric(data[[left]]), as.numeric(data[[right]])), na.rm = TRUE)
    z[is.nan(z)] <- NA_real_
    z
  }
  pair_map <- list(
    atmo_pm1.0_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
    atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
    lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin")
  )
  for (nm in names(pair_map)) df[[nm]] <- do.call(safe_pair_mean, c(list(df), pair_map[[nm]]))
  df
}

h9_load_matched_route <- function() {
  if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
  df <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
  df <- h9_pair_mean_columns(df)
  df$ParticipantID <- as.character(df$ParticipantID)
  df$PhaseID <- as.character(df$PhaseID)
  route <- df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ]
  route$Datetime <- as.POSIXct(route$Datetime, tz = "UTC")
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]
  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
    FUN = function(x) x - min(x, na.rm = TRUE))
  durations <- aggregate(time_in_phase_sec ~ ParticipantID + PhaseID, route, max, na.rm = TRUE)
  phase_durations_wide <- reshape(durations, idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
  names(phase_durations_wide) <- sub("time_in_phase_sec\\.", "", names(phase_durations_wide))
  for (nm in CORE_PHASES) if (!nm %in% names(phase_durations_wide)) phase_durations_wide[[nm]] <- NA_real_
  phase_durations_wide$Common_cap <- pmin(
    phase_durations_wide$BikeU, phase_durations_wide$BikeG,
    phase_durations_wide$WalkU, phase_durations_wide$WalkG,
    MATCHED_CAP_SEC, na.rm = FALSE
  )
  route <- merge(route, phase_durations_wide[c("ParticipantID", "Common_cap")], by = "ParticipantID", all.x = TRUE, sort = FALSE)
  route <- route[!is.na(route$Common_cap) & route$time_in_phase_sec <= route$Common_cap, ]
  route
}

h9_phase_means <- function(route, value_cols) {
  value_cols <- intersect(value_cols, names(route))
  if (!length(value_cols)) return(data.frame())
  agg <- aggregate(route[value_cols], by = route[c("ParticipantID", "PhaseID")], FUN = mean_na)
  agg$ParticipantID <- factor(agg$ParticipantID, levels = PARTICIPANTS)
  agg$PhaseID <- factor(agg$PhaseID, levels = CORE_PHASES)
  agg
}

h9_stress_oriented_wpz <- function(phase_df, column, stress_direction, transform_fn = NULL) {
  if (!column %in% names(phase_df)) return(rep(NA_real_, nrow(phase_df)))
  x <- phase_df[[column]]
  if (is.function(transform_fn)) x <- transform_fn(x, column)
  z <- paper3_within_person_z(x, phase_df$ParticipantID)
  as.numeric(stress_direction) * z
}

h9_build_constituent_wpz <- function(phase_df, constituents_named) {
  # constituents_named: named list of stress_direction or name -> direction vector aligned to columns
  out <- list()
  transform_fn <- get0("PAPER3_APPLY_CSV_TRANSFORM", envir = .GlobalEnv, ifnotfound = NULL)
  physio_set <- H9_SPEC$physiological_outcome_names
  for (nm in names(constituents_named)) {
    spec <- constituents_named[[nm]]
    col <- if (is.list(spec)) spec$column else nm
    dir <- if (is.list(spec)) spec$stress_direction else constituents_named[[nm]]
    tf <- if (col %in% physio_set && is.function(transform_fn)) transform_fn else NULL
    out[[nm]] <- h9_stress_oriented_wpz(phase_df, col, dir, transform_fn = tf)
  }
  as.data.frame(out, optional = TRUE)
}

h9_composite_from_wpz <- function(wpz_mat) {
  if (is.null(wpz_mat) || ncol(wpz_mat) == 0) return(rep(NA_real_, 0))
  if (ncol(wpz_mat) == 1) return(wpz_mat[[1]])
  rowMeans(as.matrix(wpz_mat), na.rm = TRUE)
}

h9_fit_rmcorr <- function(x, y, participant) {
  dat <- data.frame(ParticipantID = factor(participant), composite_x = x, composite_y = y)
  dat <- dat[complete.cases(dat), , drop = FALSE]
  dat <- dat[dat$ParticipantID %in% names(which(table(dat$ParticipantID) >= 2)), , drop = FALSE]
  dat$ParticipantID <- droplevels(dat$ParticipantID)
  n_pid <- nlevels(dat$ParticipantID)
  if (nrow(dat) < H9_SPEC$min_rows_rmcorr || n_pid < H9_SPEC$min_participants_rmcorr) {
    return(list(status = "NOT_FIT_INSUFFICIENT_DATA", n = nrow(dat), n_pid = n_pid))
  }
  if (sd(dat$composite_x) == 0 || sd(dat$composite_y) == 0) {
    return(list(status = "NOT_FIT_ZERO_VARIANCE", n = nrow(dat), n_pid = n_pid))
  }
  fit <- tryCatch(
    lm(composite_y ~ ParticipantID + composite_x, data = dat),
    error = function(e) NULL
  )
  if (is.null(fit)) return(list(status = "FAILED", n = nrow(dat), n_pid = n_pid))
  cf <- summary(fit)$coefficients["composite_x", ]
  dfr <- fit$df.residual
  t_val <- cf[["t value"]]
  r_rm <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + dfr))
  z_ci <- atanh(r_rm) + c(-1, 1) * qnorm(0.975) / sqrt(max(dfr - 1, 1))
  list(
    status = "FIT", n = nrow(dat), n_pid = n_pid,
    beta = cf[["Estimate"]], se = cf[["Std. Error"]], t = t_val, df = dfr,
    p_value = cf[["Pr(>|t|)"]], r_rm = r_rm,
    ci_low = tanh(z_ci[1]), ci_high = tanh(z_ci[2])
  )
}

`%||%` <- function(a, b) if (!is.null(a)) a else b

h9_dispatch_run <- function() {
  cat("[H9 1/4] Loading matched 8-min route epochs...\n")
  route <- h9_load_matched_route()

  env_cols <- vapply(H9_SPEC$env_constituents, function(x) x$column, character(1))
  physio_cols <- H9_SPEC$physiological_outcome_names
  extra_cols <- unique(c(
    physio_cols, env_cols, H9_SPEC$proprietary_eye_column,
    names(H9_SPEC$transparent_eye_constituents)
  ))
  phase_raw <- h9_phase_means(route, extra_cols)

  cat("[H9 2/4] Building stress-oriented composites on participant-phase means...\n")
  composite_defs <- list()
  composite_values <- data.frame(
    ParticipantID = phase_raw$ParticipantID,
    PhaseID = phase_raw$PhaseID,
    stringsAsFactors = FALSE
  )

  # Per-physiological scalar composites
  physio_dirs <- H9_SPEC$physio_stress_direction
  physio_dirs <- physio_dirs[intersect(names(physio_dirs), physio_cols)]
  physio_wpz <- h9_build_constituent_wpz(phase_raw, physio_dirs)
  for (nm in names(physio_dirs)) {
    id <- paste0("physio__", nm)
    composite_values[[id]] <- physio_wpz[[nm]]
    composite_defs[[id]] <- data.frame(
      composite_id = id, domain = "physiological", label = nm,
      constituents = nm, stress_directions = physio_dirs[[nm]],
      stringsAsFactors = FALSE
    )
  }

  # Per-environment scalar composites
  env_wpz <- h9_build_constituent_wpz(phase_raw, H9_SPEC$env_constituents)
  for (nm in names(H9_SPEC$env_constituents)) {
    if (!nm %in% names(env_wpz)) next
    id <- paste0("env__", nm)
    composite_values[[id]] <- env_wpz[[nm]]
    composite_defs[[id]] <- data.frame(
      composite_id = id, domain = "environmental", label = nm,
      constituents = H9_SPEC$env_constituents[[nm]]$column,
      stress_directions = H9_SPEC$env_constituents[[nm]]$stress_direction,
      stringsAsFactors = FALSE
    )
  }

  # Transparent eye index (4 features)
  eye_wpz <- h9_build_constituent_wpz(phase_raw, H9_SPEC$transparent_eye_constituents)
  composite_values$eye__transparent_stress_index <- h9_composite_from_wpz(eye_wpz)
  composite_defs$eye__transparent_stress_index <- data.frame(
    composite_id = "eye__transparent_stress_index", domain = "ocular_transparent",
    label = "Transparent ocular stress index (4-feature equal weight)",
    constituents = paste(names(H9_SPEC$transparent_eye_constituents), collapse = ";"),
    stress_directions = paste(unlist(H9_SPEC$transparent_eye_constituents), collapse = ";"),
    stringsAsFactors = FALSE
  )

  # Proprietary Pupil Labs score (kept separate)
  prop_col <- H9_SPEC$proprietary_eye_column
  if (prop_col %in% names(phase_raw)) {
    composite_values$eye__proprietary_stress_composite <- h9_stress_oriented_wpz(
      phase_raw, prop_col, H9_SPEC$proprietary_eye_stress_direction
    )
    composite_defs$eye__proprietary_stress_composite <- data.frame(
      composite_id = "eye__proprietary_stress_composite", domain = "ocular_proprietary",
      label = prop_col,
      constituents = prop_col,
      stress_directions = H9_SPEC$proprietary_eye_stress_direction,
      stringsAsFactors = FALSE
    )
  }

  # Optional grouped environmental composites
  if (isTRUE(H9_SPEC$include_optional_env_groups)) {
    for (gid in names(H9_SPEC$optional_env_groups)) {
      gspec <- H9_SPEC$optional_env_groups[[gid]]
      const_ids <- gspec$constituents
      sub <- env_wpz[, intersect(const_ids, names(env_wpz)), drop = FALSE]
      if (ncol(sub) == 0) next
      composite_values[[gid]] <- h9_composite_from_wpz(sub)
      composite_defs[[gid]] <- data.frame(
        composite_id = gid, domain = "environmental_group",
        label = gspec$label,
        constituents = paste(const_ids, collapse = ";"),
        stress_directions = paste(vapply(const_ids, function(k) {
          d <- H9_SPEC$env_constituents[[k]]$stress_direction
          if (is.null(d)) NA_integer_ else d
        }, integer(1)), collapse = ";"),
        stringsAsFactors = FALSE
      )
    }
  }

  def_table <- do.call(rbind, composite_defs)
  rownames(def_table) <- NULL

  composite_cols <- setdiff(names(composite_values), c("ParticipantID", "PhaseID"))
  safe_write_csv(composite_values, file.path(OUT_DIR, "H9_participant_phase_composites.csv"))
  safe_write_csv(def_table, file.path(OUT_DIR, "H9_composite_definitions.csv"))

  cat("[H9 3/4] Pairwise rmcorr across composites (one BH-FDR family)...\n")
  pairs_list <- list()
  for (i in seq_along(composite_cols)) for (j in seq_along(composite_cols)) {
    if (j <= i) next
    cx <- composite_cols[i]
    cy <- composite_cols[j]
    fit <- h9_fit_rmcorr(
      composite_values[[cx]], composite_values[[cy]], composite_values$ParticipantID
    )
    pairs_list[[length(pairs_list) + 1]] <- data.frame(
      Composite_X = cx, Composite_Y = cy,
      Domain_X = def_table$domain[match(cx, def_table$composite_id)],
      Domain_Y = def_table$domain[match(cy, def_table$composite_id)],
      Status = fit$status,
      N_PhaseBouts = fit$n %||% NA_integer_,
      N_Participants = fit$n_pid %||% NA_integer_,
      Beta = fit$beta %||% NA_real_,
      SE = fit$se %||% NA_real_,
      t_stat = fit$t %||% NA_real_,
      df = fit$df %||% NA_real_,
      p_value = fit$p_value %||% NA_real_,
      r_rm = fit$r_rm %||% NA_real_,
      CI95_low = fit$ci_low %||% NA_real_,
      CI95_high = fit$ci_high %||% NA_real_,
      Model = "rmcorr: lm(Y ~ ParticipantID + X), Bakdash & Marusich 2017",
      stringsAsFactors = FALSE
    )
  }
  pairs_table <- do.call(rbind, pairs_list)
  rownames(pairs_table) <- NULL
  fit_idx <- pairs_table$Status == "FIT" & is.finite(pairs_table$p_value)
  pairs_table$q_FDR <- NA_real_
  if (any(fit_idx)) {
    pairs_table$q_FDR[fit_idx] <- p.adjust(pairs_table$p_value[fit_idx], method = "BH")
  }
  pairs_table$FDR_significant <- !is.na(pairs_table$q_FDR) & pairs_table$q_FDR < H9_SPEC$fdr_alpha
  pairs_table <- pairs_table[order(pairs_table$q_FDR, pairs_table$p_value, decreasing = FALSE, na.last = TRUE), ]
  safe_write_csv(pairs_table, file.path(OUT_DIR, "H9_pairwise_rmcorr.csv"))

  n_fdr <- sum(pairs_table$FDR_significant %in% TRUE, na.rm = TRUE)
  n_fit <- sum(fit_idx)
  manifest <- data.frame(
    Metric = c("N_composites", "N_pairs_attempted", "N_pairs_fit", "N_FDR_significant_q05"),
    Value = c(length(composite_cols), nrow(pairs_table), n_fit, n_fdr),
    stringsAsFactors = FALSE
  )
  safe_write_csv(manifest, file.path(OUT_DIR, "H9_run_manifest.csv"))

  cat(sprintf("[H9 4/4] Done. %d composites, %d pairs fit, %d FDR-significant (q < %.2f).\n",
              length(composite_cols), n_fit, n_fdr, H9_SPEC$fdr_alpha))
  cat("Outputs: ", OUT_DIR, "\n", sep = "")
  invisible(list(composites = composite_values, pairs = pairs_table, definitions = def_table))
}

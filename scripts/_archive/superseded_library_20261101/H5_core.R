# H5_core.R — exploratory dominance zones (Gong, Ma & Kan 2019), GVI cross-check, UTCI stress matrix

h5_haversine_m <- function(lat1, lon1, lat2, lon2) {
  rad <- pi / 180
  lat1 <- lat1 * rad
  lat2 <- lat2 * rad
  dlat <- (lat2 - lat1)
  dlon <- (lon2 - lon1) * rad
  a <- sin(dlat / 2)^2 + cos(lat1) * cos(lat2) * sin(dlon / 2)^2
  6371000 * 2 * atan2(sqrt(a), sqrt(1 - a))
}

h5_z <- function(x) {
  m <- mean(x, na.rm = TRUE)
  s <- sd(x, na.rm = TRUE)
  if (!is.finite(s) || s == 0) rep(NA_real_, length(x)) else (x - m) / s
}

h5_person_center <- function(x, id) {
  ave(as.numeric(x), id, FUN = function(v) v - mean(v, na.rm = TRUE))
}

h5_output_dir <- function(project_root) {
  file.path(project_root, "output", "statistical_analysis", "results", "H5_exploratory")
}

h5_add_bilateral_means <- function(dat) {
  safe_pair_mean <- function(left, right) {
    if (!all(c(left, right) %in% names(dat))) return(rep(NA_real_, nrow(dat)))
    z <- rowMeans(cbind(as.numeric(dat[[left]]), as.numeric(dat[[right]])), na.rm = TRUE)
    z[is.nan(z)] <- NA_real_
    z
  }
  dat$atmo_pm2.5_avg <- safe_pair_mean(
    "atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"
  )
  dat$lys_lux_avg <- safe_pair_mean("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")
  dat
}

# Gong, Ma & Kan (2019) dominance on normalized CamUp SVF / TVF / BVF (sky / tree / building shares).
h5_gong_ma_kan_dominance <- function(svf, tvf, bvf) {
  svf <- as.numeric(svf)
  tvf <- as.numeric(tvf)
  bvf <- as.numeric(bvf)
  n <- length(svf)
  out <- rep(NA_character_, n)
  for (i in seq_len(n)) {
    s <- svf[i] + tvf[i] + bvf[i]
    if (!is.finite(s) || s <= 0) next
    p_s <- svf[i] / s
    p_t <- tvf[i] / s
    p_b <- bvf[i] / s
    nm <- c(S = p_s, T = p_t, B = p_b)
    ord <- order(nm, decreasing = TRUE)
    pr <- nm[ord]
    lab <- names(pr)
    pr1 <- pr[1L]
    pr2 <- pr[2L]
    pr3 <- pr[3L]
    if (pr1 >= 2 * pr2) {
      out[i] <- lab[1L]
    } else if (pr1 < 2 * pr2 && pr2 >= 2 * pr3) {
      pair_set <- sort(lab[1:2])
      out[i] <- if (identical(pair_set, c("B", "S"))) {
        "BS"
      } else if (identical(pair_set, c("S", "T"))) {
        "TS"
      } else if (identical(pair_set, c("B", "T"))) {
        "TB"
      } else {
        paste0(pair_set[1L], pair_set[2L])
      }
    } else {
      out[i] <- "A"
    }
  }
  factor(out, levels = c("S", "B", "T", "BS", "TS", "TB", "A"))
}

# UTCI-Fiala / Brode et al. stress categories (°C).
h5_utci_stress_category <- function(utci) {
  utci <- as.numeric(utci)
  cut(
    utci,
    breaks = c(-Inf, -40, -27, -13, 0, 9, 26, 32, 38, 46, Inf),
    labels = c(
      "extreme_cold_stress", "very_strong_cold_stress", "strong_cold_stress",
      "moderate_cold_stress", "slight_cold_stress", "no_thermal_stress",
      "moderate_heat_stress", "strong_heat_stress", "very_strong_heat_stress",
      "extreme_heat_stress"
    ),
    right = FALSE
  )
}

# WUDAPT / Stewart & Oke LCZ morphology backdrop (not a zone rule); green vs built phases.
h5_lcz_context_label <- function(svf, phase_id, green_phases) {
  svf <- as.numeric(svf)
  phase_id <- as.character(phase_id)
  green_phases <- as.character(green_phases)
  out <- rep(NA_character_, length(svf))
  for (i in seq_along(svf)) {
    if (!is.finite(svf[i])) next
    if (phase_id[i] %in% green_phases) {
      out[i] <- if (svf[i] < 0.4) {
        "LCZ_A_dense_trees_context"
      } else if (svf[i] >= 0.5 && svf[i] <= 0.8) {
        "LCZ_B_scattered_trees_context"
      } else {
        "LCZ_green_other_context"
      }
    } else {
      out[i] <- if (svf[i] < 0.35) {
        "LCZ_compact_built_context"
      } else if (svf[i] > 0.7) {
        "LCZ_open_built_context"
      } else {
        "LCZ_urban_mixed_context"
      }
    }
  }
  out
}

h5_build_epoch_table <- function(spec, raw_data_path) {
  need <- unique(c(
    "ParticipantID", "PhaseID", "end_time_s", "ucm_GPS_lat", "ucm_GPS_lon",
    "atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5",
    "atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux",
    spec$exposure_columns, spec$microclimate_stress_columns, spec$reactivity_outcomes,
    spec$questionnaire_stressor_columns
  ))
  dat <- read.csv(raw_data_path, check.names = FALSE, stringsAsFactors = FALSE)
  dat <- h5_add_bilateral_means(dat)
  miss <- setdiff(need, names(dat))
  if (length(miss)) stop("H5 missing columns in merge CSV: ", paste(miss, collapse = ", "), call. = FALSE)
  dat <- dat[dat$ParticipantID %in% spec$participants & dat$PhaseID %in% spec$phases, , drop = FALSE]
  dat$ParticipantID <- factor(dat$ParticipantID, levels = spec$participants)
  dat$PhaseID <- factor(dat$PhaseID, levels = spec$phases)
  dat
}

h5_phase_stressor_count <- function(dat, spec) {
  qcols <- spec$questionnaire_stressor_columns
  phase_q <- unique(dat[, c("ParticipantID", "PhaseID", qcols)])
  thermal_bad <- as.numeric(phase_q$questionnaire_thermal_comfort_1_5 <= 2)
  env_bad <- as.numeric(phase_q$questionnaire_environmental_comfort_mean_1_5 <= 2)
  stai_bad <- as.numeric(phase_q$questionnaire_stai6_mean_1_5 >= 4)
  pleasant_bad <- as.numeric(phase_q$questionnaire_pleasantness_1_5 <= 2)
  phase_q$questionnaire_stressor_count <- thermal_bad + env_bad + stai_bad + pleasant_bad
  merge(
    dat[, setdiff(names(dat), qcols), drop = FALSE],
    phase_q[, c("ParticipantID", "PhaseID", "questionnaire_stressor_count")],
    by = c("ParticipantID", "PhaseID"), all.x = TRUE
  )
}

h5_route_distance <- function(dat) {
  dat <- dat[order(dat$ParticipantID, dat$PhaseID, dat$end_time_s), , drop = FALSE]
  dist <- numeric(nrow(dat))
  idx <- 1L
  while (idx <= nrow(dat)) {
    pid <- dat$ParticipantID[idx]
    ph <- dat$PhaseID[idx]
    j <- idx
    cum <- 0
    while (j <= nrow(dat) && dat$ParticipantID[j] == pid && dat$PhaseID[j] == ph) {
      if (j > idx) {
        step <- h5_haversine_m(
          dat$ucm_GPS_lat[j - 1L], dat$ucm_GPS_lon[j - 1L],
          dat$ucm_GPS_lat[j], dat$ucm_GPS_lon[j]
        )
        if (is.finite(step)) cum <- cum + step
      }
      dist[j] <- cum
      j <- j + 1L
    }
    idx <- j
  }
  dat$route_distance_m <- dist
  dat
}

h5_assign_dominance_zones <- function(dat, spec) {
  dom <- h5_gong_ma_kan_dominance(dat$SVF, dat$TVF, dat$BVF)
  dat$dominance_class <- dom
  dat$zone_cluster <- as.integer(dat$dominance_class)
  dat$zone_label <- paste0(dat$PhaseID, "_", as.character(dat$dominance_class))
  dat$utci_stress <- h5_utci_stress_category(dat$ucm_UTCI)
  dat$lcz_context <- h5_lcz_context_label(dat$SVF, dat$PhaseID, spec$green_phases)
  dat$stress_dominance_cell <- paste0(as.character(dat$utci_stress), "__", as.character(dat$dominance_class))
  thr <- spec$gvi_green_threshold_pct
  dat$gvi_green_binary <- is.finite(dat$gvi_50m) & dat$gvi_50m >= thr
  dat$gvi_mapillary_green <- ifelse(dat$gvi_green_binary, "Green", "No-Green")
  dat
}

h5_shared_map_bins <- function(dat, spec) {
  dat$route_bin <- floor(dat$route_distance_m / spec$route_distance_bin_m)
  dat$shared_map_bin <- FALSE
  for (ph in levels(dat$PhaseID)) {
    for (b in unique(dat$route_bin[dat$PhaseID == ph])) {
      sel <- dat$PhaseID == ph & dat$route_bin == b & !is.na(dat$ucm_GPS_lat)
      n_part <- length(unique(dat$ParticipantID[sel]))
      if (n_part >= spec$min_participants_per_shared_bin) dat$shared_map_bin[sel] <- TRUE
    }
  }
  dat
}

h5_microclimate_stress_index <- function(dat, spec) {
  utci_pc <- h5_person_center(dat$ucm_UTCI, dat$ParticipantID)
  snd_pc <- h5_person_center(dat$ucm_SND_dBA, dat$ParticipantID)
  stress_z <- h5_z(dat$eyetracker_stress_composite)
  q_z <- h5_z(dat$questionnaire_stressor_count)
  mat <- cbind(h5_z(utci_pc), h5_z(snd_pc), stress_z, q_z)
  dat$mcsi <- rowMeans(mat, na.rm = TRUE)
  thr <- ave(dat$mcsi, dat$ParticipantID, FUN = function(v) {
    m <- median(v, na.rm = TRUE)
    s <- sd(v, na.rm = TRUE)
    if (!is.finite(s) || s == 0) rep(NA_real_, length(v)) else m + 0.5 * s
  })
  dat$mcsi_high <- is.finite(dat$mcsi) & is.finite(thr) & dat$mcsi >= thr
  dat
}

h5_delta_outcomes <- function(dat, spec, apply_transform) {
  in_norm <- spec$outcome_transforms_csv$column_name
  for (outcome in spec$reactivity_outcomes) {
    y <- if (outcome %in% in_norm) {
      apply_transform(dat[[outcome]], outcome)
    } else {
      as.numeric(dat[[outcome]])
    }
    med <- ave(y, dat$ParticipantID, dat$PhaseID, FUN = function(v) median(v, na.rm = TRUE))
    dat[[paste0("delta_", outcome)]] <- y - med
  }
  dat
}

h5_dominance_class_counts <- function(dat) {
  ok <- !is.na(dat$dominance_class)
  sub <- dat[ok, , drop = FALSE]
  agg <- aggregate(
    list(n_epochs = rep(1L, nrow(sub))),
    by = list(PhaseID = sub$PhaseID, dominance_class = sub$dominance_class),
    FUN = length
  )
  agg$n_participants <- as.integer(mapply(function(ph, dc) {
    length(unique(sub$ParticipantID[sub$PhaseID == ph & sub$dominance_class == dc]))
  }, agg$PhaseID, agg$dominance_class))
  agg[order(agg$PhaseID, agg$dominance_class), , drop = FALSE]
}

h5_zone_profiles <- function(dat, spec) {
  ok <- !is.na(dat$dominance_class)
  dat <- dat[ok, , drop = FALSE]
  prof <- aggregate(
    dat[, spec$exposure_columns, drop = FALSE],
    by = list(PhaseID = dat$PhaseID, dominance_class = dat$dominance_class),
    FUN = function(v) median(v, na.rm = TRUE)
  )
  prof$n_epochs <- as.integer(mapply(function(ph, dc) {
    sum(dat$PhaseID == ph & dat$dominance_class == dc)
  }, prof$PhaseID, prof$dominance_class))
  prof$n_participants <- as.integer(mapply(function(ph, dc) {
    length(unique(dat$ParticipantID[dat$PhaseID == ph & dat$dominance_class == dc]))
  }, prof$PhaseID, prof$dominance_class))
  lcz_mode <- mapply(function(ph, dc) {
    x <- dat$lcz_context[dat$PhaseID == ph & dat$dominance_class == dc]
    x <- x[!is.na(x)]
    if (!length(x)) NA_character_ else names(sort(table(x), decreasing = TRUE))[1L]
  }, prof$PhaseID, prof$dominance_class, USE.NAMES = FALSE)
  prof$lcz_context_mode <- lcz_mode
  prof
}

h5_stress_dominance_matrix <- function(dat) {
  ok <- !is.na(dat$dominance_class) & !is.na(dat$utci_stress)
  sub <- dat[ok, c("utci_stress", "dominance_class", "PhaseID"), drop = FALSE]
  if (!nrow(sub)) return(data.frame(note = "no complete stress x dominance rows"))
  agg <- aggregate(
    list(n = rep(1L, nrow(sub))),
    by = list(
      PhaseID = sub$PhaseID,
      utci_stress = sub$utci_stress,
      dominance_class = sub$dominance_class
    ),
    FUN = sum
  )
  agg[order(agg$PhaseID, agg$utci_stress, agg$dominance_class), , drop = FALSE]
}

h5_gvi_fallback_summary <- function(dat, spec) {
  ok <- !is.na(dat$dominance_class) & is.finite(dat$gvi_50m)
  sub <- dat[ok, , drop = FALSE]
  if (nrow(sub) < 10L) {
    return(data.frame(note = "insufficient gvi_50m for cross-check", stringsAsFactors = FALSE))
  }
  tree_like <- sub$dominance_class %in% c("T", "TS", "TB")
  cor_tvf_gvi <- suppressWarnings(cor(sub$TVF, sub$gvi_50m, use = "complete.obs"))
  cor_svf_gvi <- suppressWarnings(cor(sub$SVF, sub$gvi_50m, use = "complete.obs"))
  tab <- table(dominance = sub$dominance_class, gvi_mapillary = sub$gvi_mapillary_green)
  agree_tree <- NA_real_
  if (any(tree_like)) {
    agree_tree <- mean(sub$gvi_green_binary[tree_like], na.rm = TRUE)
  }
  rows <- list(
    data.frame(
      metric = "spearman_pearson_TVF_vs_gvi_50m",
      value = cor_tvf_gvi,
      n = nrow(sub),
      note = "Mapillary gvi_50m static; not study-date matched",
      stringsAsFactors = FALSE
    ),
    data.frame(
      metric = "correlation_SVF_vs_gvi_50m",
      value = cor_svf_gvi,
      n = nrow(sub),
      note = "Mapillary gvi_50m static; not study-date matched",
      stringsAsFactors = FALSE
    ),
    data.frame(
      metric = "pct_gvi_green_when_dominance_T_TS_TB",
      value = agree_tree,
      n = sum(tree_like),
      note = paste0("binary Green if gvi_50m >= ", spec$gvi_green_threshold_pct, "%"),
      stringsAsFactors = FALSE
    )
  )
  out <- do.call(rbind, rows)
  out$contingency <- paste(capture.output(print(tab)), collapse = " | ")
  out
}

h5_lcz_context_summary <- function(dat) {
  ok <- !is.na(dat$lcz_context)
  sub <- dat[ok, , drop = FALSE]
  aggregate(
    list(n_epochs = rep(1L, nrow(sub))),
    by = list(PhaseID = sub$PhaseID, lcz_context = sub$lcz_context),
    FUN = length
  )
}

h5_fit_reactivity_lmm <- function(dat, spec) {
  dat <- dat[!is.na(dat$dominance_class), , drop = FALSE]
  dat$zone_factor <- factor(dat$zone_label)
  rows <- list()
  for (outcome in spec$reactivity_outcomes) {
    dcol <- paste0("delta_", outcome)
    if (!dcol %in% names(dat)) next
    sub <- dat[!is.na(dat[[dcol]]) & !is.na(dat$zone_factor), , drop = FALSE]
    sub$zone_factor <- droplevels(sub$zone_factor)
    if (nrow(sub) < 50L || nlevels(sub$zone_factor) < 2L) {
      rows[[length(rows) + 1L]] <- data.frame(
        outcome = outcome, term = "zone_factor", estimate = NA_real_, SE = NA_real_,
        p_value = NA_real_, n_obs = nrow(sub), status = "insufficient_data",
        model = NA_character_, stringsAsFactors = FALSE
      )
      next
    }
    fit <- tryCatch(
      nlme::lme(
        fixed = as.formula(paste(dcol, "~ zone_factor")),
        random = ~ 1 | ParticipantID,
        data = sub,
        method = "REML",
        na.action = na.omit
      ),
      error = function(e) e
    )
    model_tag <- "lme_zone_random_participant"
    if (inherits(fit, "error")) {
      fit <- tryCatch(
        lm(as.formula(paste(dcol, "~ zone_factor + ParticipantID")), data = sub, na.action = na.omit),
        error = function(e) e
      )
      model_tag <- "lm_zone_plus_participant_fixed"
    }
    if (inherits(fit, "error")) {
      rows[[length(rows) + 1L]] <- data.frame(
        outcome = outcome, term = "zone_factor", estimate = NA_real_, SE = NA_real_,
        p_value = NA_real_, n_obs = nrow(sub), status = paste("fit_error:", fit$message),
        model = NA_character_, stringsAsFactors = FALSE
      )
      next
    }
    if (inherits(fit, "lme")) {
      sm <- summary(fit)
      coefs <- sm$tTable
    } else {
      sm <- summary(fit)
      coefs <- cbind(
        Value = coef(sm)[, "Estimate"],
        `Std.Error` = coef(sm)[, "Std. Error"],
        `p-value` = coef(sm)[, "Pr(>|t|)"]
      )
    }
    zone_rows <- grep("^zone_factor", rownames(coefs))
    for (zr in zone_rows) {
      rows[[length(rows) + 1L]] <- data.frame(
        outcome = outcome,
        term = rownames(coefs)[zr],
        estimate = coefs[zr, "Value"],
        SE = coefs[zr, "Std.Error"],
        p_value = coefs[zr, "p-value"],
        n_obs = if (inherits(fit, "lme")) fit$dims["N"] else nobs(fit),
        status = "ok",
        model = model_tag,
        stringsAsFactors = FALSE
      )
    }
  }
  tab <- do.call(rbind, rows)
  if (nrow(tab)) {
    ok <- tab$status == "ok" & is.finite(tab$p_value)
    tab$p_value_FDR <- NA_real_
    if (any(ok)) tab$p_value_FDR[ok] <- p.adjust(tab$p_value[ok], method = "BH")
    tab$analysis <- "delta_outcome ~ PhaseID_dominance_zone; random intercept ParticipantID"
    tab$family_note <- "Exploratory H5 only; not merged with H1–H4 FDR"
  }
  tab
}

h5_zone_entry_lags <- function(dat, spec) {
  dat <- dat[order(dat$ParticipantID, dat$PhaseID, dat$end_time_s), , drop = FALSE]
  dat$zone_entry <- FALSE
  for (i in seq_len(nrow(dat))) {
    if (is.na(dat$dominance_class[i])) next
    if (i == 1L || dat$ParticipantID[i] != dat$ParticipantID[i - 1L] ||
      dat$PhaseID[i] != dat$PhaseID[i - 1L] ||
      is.na(dat$dominance_class[i - 1L]) ||
      dat$dominance_class[i] != dat$dominance_class[i - 1L]) {
      dat$zone_entry[i] <- TRUE
    }
  }
  entries <- which(dat$zone_entry & dat$shared_map_bin)
  if (!length(entries)) return(data.frame(note = "no shared-map zone entries", stringsAsFactors = FALSE))
  out <- list()
  for (outcome in spec$reactivity_outcomes) {
    dcol <- paste0("delta_", outcome)
    if (!dcol %in% names(dat)) next
    for (lag in spec$lag_steps) {
      vals <- vapply(entries, function(i) {
        j <- i + lag
        if (j > nrow(dat)) return(NA_real_)
        if (dat$ParticipantID[j] != dat$ParticipantID[i] || dat$PhaseID[j] != dat$PhaseID[i]) return(NA_real_)
        dat[[dcol]][j]
      }, numeric(1))
      out[[length(out) + 1L]] <- data.frame(
        outcome = outcome,
        lag_steps = lag,
        lag_seconds = lag * 10L,
        n_events = length(entries),
        mean_delta = mean(vals, na.rm = TRUE),
        sd_delta = sd(vals, na.rm = TRUE),
        stringsAsFactors = FALSE
      )
    }
  }
  do.call(rbind, out)
}

h5_dispatch_run <- function(spec, project_root, script_path, raw_data_path) {
  out_dir <- h5_output_dir(project_root)
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  apply_transform <- function(x, col) paper3_apply_csv_transform(x, col, spec$outcome_transforms_csv)

  dat <- h5_build_epoch_table(spec, raw_data_path)
  dat <- h5_phase_stressor_count(dat, spec)
  dat <- h5_route_distance(dat)
  dat <- h5_assign_dominance_zones(dat, spec)
  dat <- h5_shared_map_bins(dat, spec)
  dat <- h5_microclimate_stress_index(dat, spec)
  dat <- h5_delta_outcomes(dat, spec, apply_transform)

  class_counts <- h5_dominance_class_counts(dat)
  profiles <- h5_zone_profiles(dat, spec)
  stress_dom <- h5_stress_dominance_matrix(dat)
  gvi_sum <- h5_gvi_fallback_summary(dat, spec)
  lcz_sum <- h5_lcz_context_summary(dat)
  lmm <- h5_fit_reactivity_lmm(dat, spec)
  lags <- h5_zone_entry_lags(dat, spec)

  write.csv(dat, file.path(out_dir, "H5_epoch_zones.csv"), row.names = FALSE)
  write.csv(class_counts, file.path(out_dir, "H5_dominance_class_counts.csv"), row.names = FALSE)
  write.csv(profiles, file.path(out_dir, "H5_zone_exposure_profiles.csv"), row.names = FALSE)
  write.csv(stress_dom, file.path(out_dir, "H5_stress_dominance_matrix.csv"), row.names = FALSE)
  write.csv(gvi_sum, file.path(out_dir, "H5_gvi_fallback_summary.csv"), row.names = FALSE)
  write.csv(lcz_sum, file.path(out_dir, "H5_lcz_context_summary.csv"), row.names = FALSE)
  write.csv(lmm, file.path(out_dir, "H5_reactivity_lmm.csv"), row.names = FALSE)
  write.csv(lags, file.path(out_dir, "H5_zone_entry_lag_summary.csv"), row.names = FALSE)

  manifest <- data.frame(
    field = c(
      "script_path", "raw_data_path", "zone_method", "n_epochs", "n_with_dominance_class",
      "n_shared_map_epochs", "n_mcsi_high", "gvi_green_threshold_pct", "route_distance_bin_m",
      "timestamp_utc"
    ),
    value = c(
      script_path, raw_data_path, spec$zone_method,
      as.character(nrow(dat)),
      as.character(sum(!is.na(dat$dominance_class))),
      as.character(sum(dat$shared_map_bin)),
      as.character(sum(dat$mcsi_high, na.rm = TRUE)),
      as.character(spec$gvi_green_threshold_pct),
      as.character(spec$route_distance_bin_m),
      format(Sys.time(), tz = "UTC", usetz = TRUE)
    ),
    stringsAsFactors = FALSE
  )
  write.csv(manifest, file.path(out_dir, "H5_Run_Manifest.csv"), row.names = FALSE)

  cat("[H5 exploratory] Wrote:", out_dir, "\n")
  cat(sprintf(
    "  epochs=%d dominance_assigned=%d shared_map_epochs=%d mcsi_high=%d\n",
    nrow(dat), sum(!is.na(dat$dominance_class)), sum(dat$shared_map_bin), sum(dat$mcsi_high, na.rm = TRUE)
  ))
  print(class_counts)
  if (nrow(gvi_sum) && is.finite(gvi_sum$value[gvi_sum$metric == "spearman_pearson_TVF_vs_gvi_50m"][1L])) {
    cat(sprintf("  TVF vs gvi_50m r=%.3f\n", gvi_sum$value[gvi_sum$metric == "spearman_pearson_TVF_vs_gvi_50m"][1L]))
  }
  if (nrow(lmm) && any(lmm$status == "ok")) {
    sig <- sum(lmm$status == "ok" & lmm$p_value_FDR < spec$exploratory_fdr_alpha, na.rm = TRUE)
    cat(sprintf("  reactivity terms=%d FDR_sig=%d (exploratory family)\n", sum(lmm$status == "ok"), sig))
  }
  invisible(list(
    epoch = dat, class_counts = class_counts, profiles = profiles,
    stress_dom = stress_dom, gvi_sum = gvi_sum, lcz_sum = lcz_sum,
    lmm = lmm, lags = lags, manifest = manifest
  ))
}

# H5_hotspot_core.R — repeated hotspot × day exposure; backpack (merged CSV) env moderation; campaign baseline centering
#
# === HOTSPOT DEFINITION (align with documents/Paper3_outline_ml.md §8.0) ===
# Primary: corridor_buffer — uCM GPS point-in-polygon to ExpData *_buffer_{11|35}m.gpkg (seg_idx);
#   hotspot_id = PhaseID_seg{k}; inclusion = all GPS-assigned buffer cells (no cohort min-N rule).
# Legacy distance_bin: route_distance_m / route_distance_bin_m; spatial_9of11 haversine on bin medians.
# Data: merged_all_11participants_8min.csv only.
#
# PLACE-INTRINSIC HOTSPOT CHARACTERISTICS (hotspot profile / stability tables; define the location):
#   SVF, TVF, BVF  — continuous CamUp fisheye view factors (in-study photos; not external GIS/Mapillary).
#   gps_segment_slope_pct — derived point-to-point grade from ucm_GPS_alt and haversine step (see h5s_add_gps_segment_slope).
# Aggregated per hotspot-day as median_* in H5_hotspot_day.csv; cross-visit summaries in H5_hotspot_exposure_stability.csv.
#
# MOMENTARY ENVIRONMENT (NOT hotspot identity — covariates / moderators in RH1–RH4 and RH1_sens_* only):
#   ucm_UTCI (primary moderator -> env_ucm_UTCI_c), ucm_AIR_temp, ucm_AIR_RH, ucm_WIND_AWS, ucm_SUN_Gh,
#   ucm_SND_dBA, ucm_PET, ucm_MRT, atmo_pm2.5_avg, lys_lux_avg.
# Grand-mean centered at hotspot-day after median epoch aggregation (h5s_center_env_predictors).
#
# NOT USED TO DEFINE HOTSPOTS: gvi_50m (external Mapillary/static GVI) — optional sensitivity covariate only.
# ===========================================================================================================

h5s_haversine_m <- function(lat1, lon1, lat2, lon2) {
  rad <- pi / 180
  lat1 <- lat1 * rad
  lat2 <- lat2 * rad
  dlat <- (lat2 - lat1)
  dlon <- (lon2 - lon1) * rad
  a <- sin(dlat / 2)^2 + cos(lat1) * cos(lat2) * sin(dlon / 2)^2
  6371000 * 2 * atan2(sqrt(a), sqrt(1 - a))
}

h5s_output_dir <- function(project_root, spec = NULL) {
  base <- file.path(project_root, "output", "statistical_analysis", "results", "H5_exploratory")
  sub <- if (!is.null(spec)) spec$results_subdirectory else NULL
  if (!is.null(sub) && nzchar(sub)) file.path(base, sub) else base
}

# RH1 temporal lag: previous measurement row within ParticipantID × PhaseID (Date, then route_bin).
# LAG_TERM = env_ucm_UTCI_lag1_c (prior row's grand-mean-centered hotspot-day UTCI).
# Lagged hotspot_f omitted (collinear with current hotspot_f on adjacent bins); hotspot_id_lag1 kept for audit.
h5s_rh1_use_temporal_lag <- function(spec) {
  isTRUE(spec$rh1_include_temporal_lag)
}

h5s_rh1_lag_term_name <- function(spec) {
  if (is.null(spec$rh1_lag_term)) "env_ucm_UTCI_lag1_c" else spec$rh1_lag_term
}

h5s_rh1_lag_rhs_term <- function(spec) {
  paste0("`", h5s_rh1_lag_term_name(spec), "`")
}

h5s_add_rh1_temporal_lags <- function(hd, spec) {
  if (!h5s_rh1_use_temporal_lag(spec)) return(hd)
  env_c <- h5s_moderator_term_name(spec)
  lag_col <- h5s_rh1_lag_term_name(spec)
  if (!env_c %in% names(hd)) {
    stop("H5 RH1 lag: missing ", env_c, " on hotspot-day table.", call. = FALSE)
  }
  ord <- order(hd$ParticipantID, hd$PhaseID, hd$Date, hd$route_bin, hd$hotspot_id)
  hd <- hd[ord, , drop = FALSE]
  n <- nrow(hd)
  lag_utci <- rep(NA_real_, n)
  lag_bin <- rep(NA_integer_, n)
  lag_hs <- rep(NA_character_, n)
  idx <- 1L
  while (idx <= n) {
    j <- idx
    pid <- hd$ParticipantID[idx]
    ph <- hd$PhaseID[idx]
    dt <- hd$Date[idx]
    while (j <= n && hd$ParticipantID[j] == pid && hd$PhaseID[j] == ph && hd$Date[j] == dt) {
      if (j > idx) {
        prev <- j - 1L
        lag_utci[j] <- hd[[env_c]][prev]
        lag_bin[j] <- hd$route_bin[prev]
        lag_hs[j] <- as.character(hd$hotspot_id[prev])
      }
      j <- j + 1L
    }
    idx <- j
  }
  hd[[lag_col]] <- lag_utci
  hd$route_bin_lag1 <- lag_bin
  hd$hotspot_id_lag1 <- lag_hs
  hd
}

# RH1 cumulative exposure: running sum of grand-mean-centered hotspot-day UTCI within ParticipantID × PhaseID
# (Date, then route_bin). Column env_ucm_UTCI_cum_c = cumsum(env_ucm_UTCI_c) within block, then − global mean
# (same centering convention as env_ucm_UTCI_c). Hotspot bin cumsum omitted (collinear with route position + hotspot_f).
h5s_rh1_use_cumulative_exposure <- function(spec) {
  isTRUE(spec$rh1_include_cumulative_exposure)
}

h5s_rh1_cumulative_term_name <- function(spec) {
  if (is.null(spec$rh1_cumulative_term)) "env_ucm_UTCI_cum_c" else spec$rh1_cumulative_term
}

h5s_rh1_cumulative_rhs_term <- function(spec) {
  paste0("`", h5s_rh1_cumulative_term_name(spec), "`")
}

h5s_add_rh1_cumulative_exposure <- function(hd, spec) {
  if (!h5s_rh1_use_cumulative_exposure(spec)) return(hd)
  env_c <- h5s_moderator_term_name(spec)
  cum_col <- h5s_rh1_cumulative_term_name(spec)
  if (!env_c %in% names(hd)) {
    stop("H5 RH1 cumulative: missing ", env_c, " on hotspot-day table.", call. = FALSE)
  }
  ord <- order(hd$ParticipantID, hd$PhaseID, hd$Date, hd$route_bin, hd$hotspot_id)
  hd <- hd[ord, , drop = FALSE]
  n <- nrow(hd)
  cum_utci <- rep(NA_real_, n)
  idx <- 1L
  while (idx <= n) {
    j <- idx
    pid <- hd$ParticipantID[idx]
    ph <- hd$PhaseID[idx]
    dt <- hd$Date[idx]
    running <- 0
    while (j <= n && hd$ParticipantID[j] == pid && hd$PhaseID[j] == ph && hd$Date[j] == dt) {
      v <- hd[[env_c]][j]
      if (is.finite(v)) running <- running + v
      cum_utci[j] <- running
      j <- j + 1L
    }
    idx <- j
  }
  fin <- is.finite(cum_utci)
  if (any(fin)) cum_utci[fin] <- cum_utci[fin] - mean(cum_utci[fin])
  hd[[cum_col]] <- cum_utci
  hd
}

h5s_rh1_use_elapsed_time_adjustment <- function(spec) {
  isTRUE(spec$rh1_include_elapsed_time_adjustment)
}

h5s_rh1_elapsed_term_name <- function(spec) {
  if (is.null(spec$rh1_elapsed_term)) "env_median_end_time_s_c" else spec$rh1_elapsed_term
}

h5s_rh1_elapsed_rhs_term <- function(spec) {
  paste0("`", h5s_rh1_elapsed_term_name(spec), "`")
}

h5s_add_elapsed_time_covariate <- function(hd, spec) {
  if (!"median_end_time_s" %in% names(hd)) {
    stop("H5 elapsed adjustment: missing median_end_time_s on hotspot-day table.", call. = FALSE)
  }
  col <- h5s_rh1_elapsed_term_name(spec)
  v <- hd$median_end_time_s
  fin <- is.finite(v)
  hd[[col]] <- NA_real_
  if (any(fin)) hd[[col]][fin] <- v[fin] - mean(v[fin])
  hd
}

h5s_rh1_elapsed_adjustment <- function(spec) {
  if (!h5s_rh1_use_elapsed_time_adjustment(spec)) {
    return(list(use = FALSE, col = NA_character_, rhs = ""))
  }
  col <- h5s_rh1_elapsed_term_name(spec)
  list(
    use = TRUE,
    col = col,
    rhs = paste0(" + ", h5s_rh1_elapsed_rhs_term(spec))
  )
}

h5s_rh1_secondary_temporal_term <- function(spec) {
  if (h5s_rh1_use_temporal_lag(spec)) {
    col <- h5s_rh1_lag_term_name(spec)
    return(list(
      use = TRUE, col = col, rhs = paste0(" + ", h5s_rh1_lag_rhs_term(spec)),
      drop_incomplete = TRUE, kind = "lag"
    ))
  }
  if (h5s_rh1_use_cumulative_exposure(spec)) {
    col <- h5s_rh1_cumulative_term_name(spec)
    return(list(
      use = TRUE, col = col, rhs = paste0(" + ", h5s_rh1_cumulative_rhs_term(spec)),
      drop_incomplete = FALSE, kind = "cumulative"
    ))
  }
  list(use = FALSE, col = NA_character_, rhs = "", drop_incomplete = FALSE, kind = NA_character_)
}

# When spec$pilot_walkg_only is TRUE, restrict epochs to WalkG (walk-in-green pilot).
h5s_analysis_phases <- function(spec) {
  if (isTRUE(spec$pilot_walkg_only)) return("WalkG")
  spec$phases
}

h5s_rh1_phase_fixed_prefix <- function(hd_m) {
  if (length(unique(as.character(hd_m$PhaseID))) <= 1L) return("")
  "PhaseID + "
}

# RH1 exploratory BH-FDR (single p_value_FDR column; family from spec$exploratory_fdr_family).
h5s_rh1_stratify_by_phase <- function(spec) {
  if (is.null(spec$rh1_stratify_by_phase)) return(FALSE)
  isTRUE(spec$rh1_stratify_by_phase)
}

h5s_exploratory_fdr_family <- function(spec) {
  if (is.null(spec$exploratory_fdr_family)) "within_outcome" else spec$exploratory_fdr_family
}

h5s_apply_bh_fdr <- function(p) {
  p <- as.numeric(p)
  q <- rep(NA_real_, length(p))
  ok <- is.finite(p)
  if (!any(ok)) return(q)
  po <- p[ok]
  m <- length(po)
  ord <- order(po)
  ranked <- po[ord]
  qv <- ranked * m / seq_len(m)
  qv <- rev(cummin(rev(qv)))
  qv <- pmin(qv, 1)
  q_full <- rep(NA_real_, m)
  q_full[ord] <- qv
  q[ok] <- q_full
  q
}

h5s_apply_bh_fdr_grouped <- function(df, p_col = "p_value", group_cols = NULL) {
  if (!nrow(df)) return(numeric())
  q <- rep(NA_real_, nrow(df))
  if (is.null(group_cols) || !length(group_cols)) {
    return(h5s_apply_bh_fdr(df[[p_col]]))
  }
  miss <- setdiff(group_cols, names(df))
  if (length(miss)) {
    stop("H5 FDR: missing group columns: ", paste(miss, collapse = ", "), call. = FALSE)
  }
  keys <- interaction(df[, group_cols, drop = FALSE], drop = TRUE)
  for (g in unique(keys)) {
    idx <- which(keys == g)
    q[idx] <- h5s_apply_bh_fdr(df[[p_col]][idx])
  }
  q
}

# Hotspot_f uses locked family; env_ucm_UTCI_c uses within_outcome when stratified (one test per outcome×phase).
h5s_fdr_group_cols <- function(spec, target = c("env_moderator", "hotspot_coef")) {
  target <- match.arg(target)
  fam <- h5s_exploratory_fdr_family(spec)
  if (target == "hotspot_coef") {
    if (fam == "pooled") return(NULL)
    if (fam == "within_outcome") return("outcome")
    if (fam == "within_outcome_x_phase") return(c("outcome", "PhaseID"))
    stop("H5 FDR: unknown exploratory_fdr_family: ", fam, call. = FALSE)
  }
  if (fam == "pooled") return(NULL)
  if (fam == "within_outcome") return("outcome")
  if (fam == "within_outcome_x_phase") {
    if (h5s_rh1_stratify_by_phase(spec)) return("outcome")
    return(c("outcome", "PhaseID"))
  }
  stop("H5 FDR: unknown exploratory_fdr_family: ", fam, call. = FALSE)
}

h5s_env_moderator_fdr_family_label <- function(spec) {
  fam <- h5s_exploratory_fdr_family(spec)
  if (fam == "within_outcome_x_phase" && h5s_rh1_stratify_by_phase(spec)) {
    return("within_outcome (env: one UTCI test per outcome×phase model)")
  }
  fam
}

h5s_rh1_outcomes <- function(spec) {
  if (!is.null(spec$rh1_outcome_names)) return(spec$rh1_outcome_names)
  if (identical(spec$rh1_outcome_scope, "primary")) {
    if (is.null(spec$rh1_primary_outcomes)) {
      stop("H5 hotspot: rh1_outcome_scope='primary' requires rh1_primary_outcomes", call. = FALSE)
    }
    return(spec$rh1_primary_outcomes)
  }
  spec$reactivity_outcomes
}

h5s_rh1_median_outcome_col <- function(outcome, spec) {
  if (isTRUE(spec$rh1_use_phase_median_response)) {
    paste0("median_delta_phase_", outcome)
  } else {
    paste0("median_center_", outcome)
  }
}

h5s_rh1_response_label <- function(spec) {
  if (isTRUE(spec$rh1_use_phase_median_response)) "median_delta_phase" else "median_center"
}

h5s_discover_environment_columns <- function(dat) {
  nms <- names(dat)
  grep(
    "^(ucm_|SVF$|TVF$|BVF$|gvi_|atmo_lys_|wind_|empatica_skin_temperature)",
    nms,
    value = TRUE
  )
}

h5s_moderator_term_name <- function(spec) {
  h5s_centered_covariate_name(spec$environment_moderator_column)
}

h5s_centered_covariate_name <- function(raw_col) {
  paste0("env_", raw_col, "_c")
}

h5s_formula_term <- function(raw_col) {
  paste0("`", h5s_centered_covariate_name(raw_col), "`")
}

h5s_center_env_predictors <- function(hd, spec) {
  cols <- unique(c(
    spec$environment_moderator_column,
    spec$sensitivity_covariate_columns,
    spec$exposure_columns
  ))
  for (col in cols) {
    med_col <- paste0("median_", col)
    if (!med_col %in% names(hd)) next
    cname <- h5s_centered_covariate_name(col)
    hd[[cname]] <- hd[[med_col]] - mean(hd[[med_col]], na.rm = TRUE)
  }
  med_col <- paste0("median_", spec$environment_moderator_column)
  if (!med_col %in% names(hd)) {
    stop(
      "H5 hotspot: missing ", med_col,
      " (set spec$environment_moderator_column and include column in spec$exposure_columns).",
      call. = FALSE
    )
  }
  hd
}

h5s_add_bilateral_means <- function(dat) {
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

h5s_raw_exposure_columns <- function(spec) {
  derived <- if (is.null(spec$derived_exposure_columns)) character() else spec$derived_exposure_columns
  setdiff(spec$exposure_columns, derived)
}

h5s_hotspot_definition <- function(spec) {
  if (is.null(spec$hotspot_definition)) "corridor_buffer" else spec$hotspot_definition
}

h5s_order_epochs <- function(dat) {
  dat[order(dat$ParticipantID, dat$PhaseID, dat$Date, dat$Datetime), , drop = FALSE]
}

h5s_buffer_gpkg_path <- function(phase, spec) {
  dir <- spec$buffer_gpkg_dir
  if (is.null(dir) || !nzchar(dir)) {
    stop("H5 corridor_buffer: set spec$buffer_gpkg_dir to Experiment path_8min_buffer.", call. = FALSE)
  }
  walk <- grepl("^Walk", as.character(phase))
  width_m <- if (walk) 11L else 35L
  file.path(dir, paste0(phase, "_buffer_", width_m, "m.gpkg"))
}

h5s_load_buffer_polygons <- function(spec) {
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("H5 corridor_buffer requires R package 'sf'. Install with install.packages('sf').", call. = FALSE)
  }
  phases <- h5s_analysis_phases(spec)
  out <- list()
  for (ph in phases) {
    path <- h5s_buffer_gpkg_path(ph, spec)
    if (!file.exists(path)) stop("H5 corridor_buffer: missing ", path, call. = FALSE)
    g <- sf::st_read(path, quiet = TRUE)
    if (!"seg_idx" %in% names(g)) {
      stop("H5 corridor_buffer: seg_idx column missing in ", path, call. = FALSE)
    }
    keep <- intersect(c("phase", "seg_idx", "geometry"), names(g))
    out[[ph]] <- sf::st_transform(g[, keep, drop = FALSE], 4326)
  }
  out
}

h5s_buffer_join_cache_path <- function(spec, raw_data_path) {
  file.path(
    dirname(raw_data_path),
    "statistical_analysis",
    "cache",
    "H5_buffer_seg_assignment.csv"
  )
}

h5s_run_python_buffer_join <- function(raw_data_path, spec, cache_path) {
  py <- file.path(
    paper3_statistical_library_dir(),
    "H5_buffer_spatial_join.py"
  )
  if (!file.exists(py)) stop("Missing ", py, call. = FALSE)
  dir.create(dirname(cache_path), recursive = TRUE, showWarnings = FALSE)
  args <- c(
    py,
    normalizePath(raw_data_path, winslash = "/", mustWork = TRUE),
    normalizePath(spec$buffer_gpkg_dir, winslash = "/", mustWork = TRUE),
    normalizePath(cache_path, winslash = "/", mustWork = TRUE)
  )
  out <- system2("python", args, stdout = TRUE, stderr = TRUE)
  status <- attr(out, "status")
  if (!is.null(status) && status != 0L) {
    stop("H5_buffer_spatial_join.py failed:\n", paste(out, collapse = "\n"), call. = FALSE)
  }
  invisible(cache_path)
}

h5s_spatial_join_buffer_seg <- function(dat, spec, raw_data_path = NULL) {
  if (requireNamespace("sf", quietly = TRUE)) {
    polys <- h5s_load_buffer_polygons(spec)
    seg <- rep(NA_integer_, nrow(dat))
    for (ph in names(polys)) {
      sel <- which(as.character(dat$PhaseID) == ph &
        is.finite(dat$ucm_GPS_lat) & is.finite(dat$ucm_GPS_lon))
      if (!length(sel)) next
      pts <- sf::st_as_sf(
        dat[sel, , drop = FALSE],
        coords = c("ucm_GPS_lon", "ucm_GPS_lat"),
        crs = 4326,
        remove = FALSE
      )
      pts$._pt_idx <- seq_len(nrow(pts))
      joined <- sf::st_join(pts, polys[[ph]], join = sf::st_intersects, left = TRUE)
      jdf <- data.frame(
        pt_idx = joined$._pt_idx,
        seg_idx = as.integer(joined$seg_idx),
        stringsAsFactors = FALSE
      )
      for (r in unique(jdf$pt_idx)) {
        cand <- jdf$seg_idx[jdf$pt_idx == r]
        cand <- cand[is.finite(cand)]
        if (length(cand)) seg[sel[r]] <- min(cand)
      }
    }
    return(seg)
  }
  if (is.null(raw_data_path)) {
    stop("H5 corridor_buffer: install R package 'sf' or pass raw_data_path for Python join.", call. = FALSE)
  }
  cache_path <- h5s_buffer_join_cache_path(spec, raw_data_path)
  h5s_run_python_buffer_join(raw_data_path, spec, cache_path)
  joined <- read.csv(cache_path, stringsAsFactors = FALSE)
  joined$Datetime <- as.POSIXct(joined$Datetime, tz = "UTC")
  dat$Datetime <- as.POSIXct(dat$Datetime, tz = "UTC")
  key <- paste(dat$ParticipantID, dat$PhaseID, dat$Datetime)
  jkey <- paste(joined$ParticipantID, joined$PhaseID, joined$Datetime)
  idx <- match(key, jkey)
  as.integer(joined$buffer_seg_idx[idx])
}

h5s_buffer_assign_shared <- function(dat, spec) {
  dat$shared_hotspot <- FALSE
  ok <- is.finite(dat$route_bin) & !is.na(dat$hotspot_id)
  if (!any(ok)) return(dat)
  rule <- h5s_hotspot_inclusion_rule(spec)
  if (rule == "corridor_all_assigned") {
    dat$shared_hotspot[ok] <- TRUE
    return(dat)
  }
  cells <- unique(dat[ok, c("PhaseID", "route_bin"), drop = FALSE])
  min_n <- h5s_min_participants_for_shared(spec)
  for (i in seq_len(nrow(cells))) {
    ph <- cells$PhaseID[i]
    rb <- cells$route_bin[i]
    sel <- ok & dat$PhaseID == ph & dat$route_bin == rb
    n_part <- length(unique(dat$ParticipantID[sel]))
    if (n_part >= min_n) dat$shared_hotspot[sel] <- TRUE
  }
  dat
}

h5s_assign_buffer_hotspots <- function(dat, spec, raw_data_path = NULL) {
  dat$buffer_seg_idx <- h5s_spatial_join_buffer_seg(dat, spec, raw_data_path = raw_data_path)
  dat$route_bin <- dat$buffer_seg_idx
  dat$hotspot_id <- paste0(as.character(dat$PhaseID), "_seg", dat$route_bin)
  dat$hotspot_id[!is.finite(dat$route_bin)] <- NA_character_
  h5s_buffer_assign_shared(dat, spec)
}

h5s_build_epoch_table <- function(spec, raw_data_path) {
  need <- unique(c(
    "ParticipantID", "PhaseID", "Date", "Datetime",
    "ucm_GPS_lat", "ucm_GPS_lon", "ucm_GPS_alt",
    "atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5",
    "atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux",
    spec$environment_moderator_column,
    h5s_raw_exposure_columns(spec), spec$reactivity_outcomes
  ))
  dat <- read.csv(raw_data_path, check.names = FALSE, stringsAsFactors = FALSE)
  dat <- h5s_add_bilateral_means(dat)
  miss <- setdiff(need, names(dat))
  if (length(miss)) stop("H5 hotspot missing columns: ", paste(miss, collapse = ", "), call. = FALSE)
  phases <- h5s_analysis_phases(spec)
  dat <- dat[dat$ParticipantID %in% spec$participants & dat$PhaseID %in% phases, , drop = FALSE]
  dat$ParticipantID <- factor(dat$ParticipantID, levels = spec$participants)
  dat$PhaseID <- factor(dat$PhaseID, levels = phases)
  dat$Date <- as.Date(dat$Date)
  dat$mobility_mode <- ifelse(grepl("^Walk", dat$PhaseID), "walk", "bike")
  dat$green_phase <- dat$PhaseID %in% spec$green_phases
  dat
}

h5s_route_distance <- function(dat) {
  dat <- dat[order(dat$ParticipantID, dat$PhaseID, dat$Date, dat$end_time_s), , drop = FALSE]
  dist <- numeric(nrow(dat))
  idx <- 1L
  while (idx <= nrow(dat)) {
    pid <- dat$ParticipantID[idx]
    ph <- dat$PhaseID[idx]
    dt <- dat$Date[idx]
    j <- idx
    cum <- 0
    while (j <= nrow(dat) && dat$ParticipantID[j] == pid && dat$PhaseID[j] == ph && dat$Date[j] == dt) {
      if (j > idx) {
        step <- h5s_haversine_m(
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

# Point-to-point route grade (%): 100 * delta(ucm_GPS_alt) / horizontal step (m), within participant × phase.
h5s_add_gps_segment_slope <- function(dat, spec) {
  min_horiz <- if (is.null(spec$slope_min_horizontal_m)) 1 else spec$slope_min_horizontal_m
  col <- spec$slope_column
  dat <- h5s_order_epochs(dat)
  slope <- rep(NA_real_, nrow(dat))
  idx <- 1L
  while (idx <= nrow(dat)) {
    pid <- dat$ParticipantID[idx]
    ph <- dat$PhaseID[idx]
    dt <- dat$Date[idx]
    j <- idx
    while (j <= nrow(dat) && dat$ParticipantID[j] == pid && dat$PhaseID[j] == ph && dat$Date[j] == dt) {
      if (j > idx) {
        horiz <- h5s_haversine_m(
          dat$ucm_GPS_lat[j - 1L], dat$ucm_GPS_lon[j - 1L],
          dat$ucm_GPS_lat[j], dat$ucm_GPS_lon[j]
        )
        dalt <- as.numeric(dat$ucm_GPS_alt[j]) - as.numeric(dat$ucm_GPS_alt[j - 1L])
        if (is.finite(horiz) && horiz >= min_horiz && is.finite(dalt)) {
          slope[j] <- 100 * dalt / horiz
        }
      }
      j <- j + 1L
    }
    idx <- j
  }
  dat[[col]] <- slope
  dat
}

h5s_slope_audit <- function(dat, spec) {
  col <- spec$slope_column
  v <- dat[[col]]
  data.frame(
    metric = c(
      "slope_column", "slope_source", "slope_elevation_input",
      "n_epochs", "n_finite_slope", "pct_finite_slope",
      "median_slope_pct", "mean_abs_slope_pct", "slope_min_horizontal_m"
    ),
    value = c(
      col,
      if (is.null(spec$slope_source)) "derived" else spec$slope_source,
      "ucm_GPS_alt",
      as.character(length(v)),
      as.character(sum(is.finite(v))),
      as.character(round(100 * mean(is.finite(v)), 2)),
      as.character(stats::median(v, na.rm = TRUE)),
      as.character(mean(abs(v), na.rm = TRUE)),
      as.character(if (is.null(spec$slope_min_horizontal_m)) 1 else spec$slope_min_horizontal_m)
    ),
    stringsAsFactors = FALSE
  )
}

h5s_hotspot_inclusion_rule <- function(spec) {
  rule <- if (is.null(spec$hotspot_inclusion_rule)) "corridor_all_assigned" else spec$hotspot_inclusion_rule
  if (!rule %in% c(
    "corridor_all_assigned", "buffer_min_participants", "spatial_9of11", "legacy_min2_label"
  )) {
    stop("H5 hotspot: unknown hotspot_inclusion_rule: ", rule, call. = FALSE)
  }
  rule
}

# Corridor buffer cells (GPKG seg_idx / route_bin, 0-based) -> PhaseID_gridN labels for tables/figures.
h5s_grid_number <- function(route_bin) {
  as.integer(route_bin) + 1L
}

h5s_grid_label <- function(phase_id, route_bin) {
  paste0(as.character(phase_id), "_grid", h5s_grid_number(route_bin))
}

h5s_route_bin_from_hotspot_id <- function(hotspot_id) {
  if (!nzchar(hotspot_id) || !grepl("_seg[0-9]+$", hotspot_id, perl = TRUE)) return(NA_integer_)
  as.integer(sub(".*_seg", "", hotspot_id))
}

h5s_hotspot_label_map_df <- function(dat) {
  need <- c("PhaseID", "hotspot_id", "route_bin")
  if (!all(need %in% names(dat))) return(data.frame())
  ok <- !is.na(dat$hotspot_id)
  if ("shared_hotspot" %in% names(dat)) ok <- ok & dat$shared_hotspot %in% TRUE
  sub <- unique(dat[ok, c(need, intersect("buffer_seg_idx", names(dat))), drop = FALSE])
  if (!nrow(sub)) return(data.frame())
  if (!is.finite(sub$route_bin)[1L]) {
    sub$route_bin <- vapply(sub$hotspot_id, h5s_route_bin_from_hotspot_id, integer(1L))
  }
  sub <- sub[order(sub$PhaseID, sub$route_bin), , drop = FALSE]
  sub$grid_number <- h5s_grid_number(sub$route_bin)
  sub$grid_label <- mapply(h5s_grid_label, sub$PhaseID, sub$route_bin, USE.NAMES = FALSE)
  sub
}

h5s_attach_hotspot_factor <- function(hd) {
  if (!"route_bin" %in% names(hd)) {
    hd$route_bin <- vapply(hd$hotspot_id, h5s_route_bin_from_hotspot_id, integer(1L))
  }
  u <- unique(hd[, c("hotspot_id", "route_bin", "PhaseID"), drop = FALSE])
  u <- u[order(u$PhaseID, u$route_bin), , drop = FALSE]
  u$grid_label <- mapply(h5s_grid_label, u$PhaseID, u$route_bin, USE.NAMES = FALSE)
  hd$hotspot_f <- factor(hd$hotspot_id, levels = u$hotspot_id, labels = u$grid_label)
  hd
}

h5s_hotspot_coef_term_display <- function(model_term, lookup) {
  raw <- sub("^hotspot_f", "", model_term, fixed = FALSE)
  if (nrow(lookup) && "grid_label" %in% names(lookup) && raw %in% lookup$grid_label) {
    return(raw)
  }
  mn <- make.names(raw)
  w <- make.names(lookup$grid_label) == mn
  if (any(w)) return(lookup$grid_label[w][1L])
  raw
}

h5s_hotspot_id_from_model_term <- function(model_term, lookup) {
  lab <- h5s_hotspot_coef_term_display(model_term, lookup)
  w <- lookup$grid_label == lab
  if (any(w)) return(lookup$hotspot_id[w][1L])
  hid <- sub("^hotspot_f", "", model_term, fixed = FALSE)
  if (hid %in% lookup$hotspot_id) return(hid)
  NA_character_
}

h5s_min_participants_for_outliers <- function(spec) {
  rule <- h5s_hotspot_inclusion_rule(spec)
  if (rule == "corridor_all_assigned") {
    n <- if (is.null(spec$min_participants_per_shared_bin)) 2L else as.integer(spec$min_participants_per_shared_bin)
    return(max(2L, n))
  }
  h5s_min_participants_for_shared(spec)
}

h5s_min_participants_for_shared <- function(spec) {
  rule <- h5s_hotspot_inclusion_rule(spec)
  if (rule %in% c("buffer_min_participants", "spatial_9of11")) {
    if (is.null(spec$min_participants_shared_place)) {
      stop("H5 hotspot: rule requires min_participants_shared_place", call. = FALSE)
    }
    return(as.integer(spec$min_participants_shared_place))
  }
  if (rule == "legacy_min2_label") {
    if (is.null(spec$min_participants_per_shared_bin)) {
      stop("H5 hotspot: legacy rule requires min_participants_per_shared_bin", call. = FALSE)
    }
    return(as.integer(spec$min_participants_per_shared_bin))
  }
  stop("H5 hotspot: unreachable min_participants_for_shared", call. = FALSE)
}

h5s_spatial_proximity_radius_m <- function(spec) {
  if (is.null(spec$spatial_proximity_radius_m)) 30 else spec$spatial_proximity_radius_m
}

# One row per ParticipantID × PhaseID × route_bin with median epoch GPS in that distance bin.
h5s_participant_route_bin_median_gps <- function(dat) {
  med_fun <- function(v) stats::median(v, na.rm = TRUE)
  lat_a <- aggregate(
    list(med_lat = dat$ucm_GPS_lat),
    by = list(
      ParticipantID = dat$ParticipantID,
      PhaseID = dat$PhaseID,
      route_bin = dat$route_bin
    ),
    FUN = med_fun
  )
  lon_a <- aggregate(
    list(med_lon = dat$ucm_GPS_lon),
    by = list(
      ParticipantID = dat$ParticipantID,
      PhaseID = dat$PhaseID,
      route_bin = dat$route_bin
    ),
    FUN = med_fun
  )
  merge(lat_a, lon_a, by = c("ParticipantID", "PhaseID", "route_bin"), all = TRUE)
}

# Largest participant count within radius R of any anchor median (distinct participants).
h5s_spatial_place_cluster_size <- function(med_lat, med_lon, radius_m) {
  n <- length(med_lat)
  if (n < 1L) return(0L)
  ok <- is.finite(med_lat) & is.finite(med_lon)
  if (sum(ok) < 1L) return(0L)
  med_lat <- med_lat[ok]
  med_lon <- med_lon[ok]
  n <- length(med_lat)
  best <- 0L
  for (i in seq_len(n)) {
    d <- vapply(
      seq_len(n),
      function(j) h5s_haversine_m(med_lat[i], med_lon[i], med_lat[j], med_lon[j]),
      numeric(1)
    )
    best <- max(best, sum(d <= radius_m))
  }
  as.integer(best)
}

h5s_route_bin_shared_legacy <- function(dat, spec) {
  out <- logical(nrow(dat))
  for (hid in unique(dat$hotspot_id)) {
    n_part <- length(unique(dat$ParticipantID[dat$hotspot_id == hid]))
    if (n_part >= spec$min_participants_per_shared_bin) {
      out[dat$hotspot_id == hid] <- TRUE
    }
  }
  out
}

h5s_route_bin_shared_spatial <- function(med_gps, phase, route_bin, spec) {
  sub <- med_gps[med_gps$PhaseID == phase & med_gps$route_bin == route_bin, , drop = FALSE]
  if (!nrow(sub)) return(FALSE)
  min_n <- h5s_min_participants_for_shared(spec)
  radius_m <- h5s_spatial_proximity_radius_m(spec)
  h5s_spatial_place_cluster_size(sub$med_lat, sub$med_lon, radius_m) >= min_n
}

h5s_assign_shared_hotspots <- function(dat, spec, rule = NULL) {
  rule <- if (is.null(rule)) h5s_hotspot_inclusion_rule(spec) else rule
  if (rule == "corridor_all_assigned") {
    dat$shared_hotspot <- is.finite(dat$route_bin) & !is.na(dat$hotspot_id)
    return(dat)
  }
  if (rule == "buffer_min_participants") {
    return(h5s_buffer_assign_shared(dat, spec))
  }
  if (rule == "legacy_min2_label") {
    dat$shared_hotspot <- h5s_route_bin_shared_legacy(dat, spec)
    return(dat)
  }
  med_gps <- h5s_participant_route_bin_median_gps(dat)
  dat$shared_hotspot <- FALSE
  cells <- unique(dat[, c("PhaseID", "route_bin"), drop = FALSE])
  for (i in seq_len(nrow(cells))) {
    ph <- cells$PhaseID[i]
    rb <- cells$route_bin[i]
    if (!h5s_route_bin_shared_spatial(med_gps, ph, rb, spec)) next
    sel <- dat$PhaseID == ph & dat$route_bin == rb
    dat$shared_hotspot[sel] <- TRUE
  }
  dat
}

h5s_assign_hotspots <- function(dat, spec, raw_data_path = NULL) {
  if (h5s_hotspot_definition(spec) == "corridor_buffer") {
    return(h5s_assign_buffer_hotspots(dat, spec, raw_data_path = raw_data_path))
  }
  if (is.null(spec$route_distance_bin_m)) {
    stop("H5 distance_bin: set spec$route_distance_bin_m", call. = FALSE)
  }
  dat$route_bin <- floor(dat$route_distance_m / spec$route_distance_bin_m)
  dat$hotspot_id <- paste0(as.character(dat$PhaseID), "_bin", dat$route_bin)
  h5s_assign_shared_hotspots(dat, spec)
}

# Compare shared-hotspot counts under legacy label rule vs spatial 9-of-11 place rule (audit only).
h5s_compare_hotspot_inclusion_audit <- function(spec, project_root, raw_data_path) {
  dat <- h5s_build_epoch_table(spec, raw_data_path)
  if (h5s_hotspot_definition(spec) == "corridor_buffer") {
    dat <- h5s_assign_buffer_hotspots(dat, spec, raw_data_path = raw_data_path)
    active <- dat[dat$shared_hotspot, , drop = FALSE]
    return(data.frame(
      metric = c(
        "hotspot_definition", "hotspot_inclusion_rule_active",
        "min_participants_shared_place",
        "n_epochs_in_buffer", "n_epochs_unassigned_buffer",
        "n_shared_hotspot_id", "n_shared_phase_seg_cells"
      ),
      value = c(
        h5s_hotspot_definition(spec),
        h5s_hotspot_inclusion_rule(spec),
        as.character(h5s_min_participants_for_shared(spec)),
        as.character(sum(is.finite(dat$route_bin))),
        as.character(sum(!is.finite(dat$route_bin))),
        as.character(length(unique(active$hotspot_id))),
        as.character(nrow(unique(active[, c("PhaseID", "route_bin"), drop = FALSE])))
      ),
      stringsAsFactors = FALSE
    ))
  }
  dat <- h5s_route_distance(dat)
  dat$route_bin <- floor(dat$route_distance_m / spec$route_distance_bin_m)
  dat$hotspot_id <- paste0(as.character(dat$PhaseID), "_bin", dat$route_bin)

  legacy <- h5s_assign_shared_hotspots(dat, spec, rule = "legacy_min2_label")
  spatial <- h5s_assign_shared_hotspots(dat, spec, rule = "spatial_9of11")

  n_legacy_ids <- length(unique(legacy$hotspot_id[legacy$shared_hotspot]))
  n_spatial_ids <- length(unique(spatial$hotspot_id[spatial$shared_hotspot]))
  n_legacy_cells <- nrow(unique(legacy[legacy$shared_hotspot, c("PhaseID", "route_bin"), drop = FALSE]))
  n_spatial_cells <- nrow(unique(spatial[spatial$shared_hotspot, c("PhaseID", "route_bin"), drop = FALSE]))

  data.frame(
    metric = c(
      "hotspot_inclusion_rule_active",
      "spatial_proximity_radius_m",
      "min_participants_shared_place",
      "min_participants_per_shared_bin_legacy",
      "n_shared_hotspot_id_legacy_min2_label",
      "n_shared_hotspot_id_spatial_9of11",
      "n_shared_phase_route_bin_legacy",
      "n_shared_phase_route_bin_spatial",
      "n_shared_hotspot_id_delta_spatial_minus_legacy"
    ),
    value = c(
      h5s_hotspot_inclusion_rule(spec),
      as.character(h5s_spatial_proximity_radius_m(spec)),
      as.character(h5s_min_participants_for_shared(
        modifyList(spec, list(hotspot_inclusion_rule = "spatial_9of11"))
      )),
      as.character(spec$min_participants_per_shared_bin),
      as.character(n_legacy_ids),
      as.character(n_spatial_ids),
      as.character(n_legacy_cells),
      as.character(n_spatial_cells),
      as.character(n_spatial_ids - n_legacy_ids)
    ),
    stringsAsFactors = FALSE
  )
}

h5s_transform_outcome <- function(x, outcome, spec, apply_transform) {
  in_norm <- spec$outcome_transforms_csv$column_name
  if (outcome %in% in_norm) apply_transform(x, outcome) else as.numeric(x)
}

# (1) Campaign-wide mean per participant (all epochs in cohort phases).
h5s_participant_campaign_baselines <- function(dat, spec, apply_transform) {
  rows <- list()
  for (outcome in spec$reactivity_outcomes) {
    y <- h5s_transform_outcome(dat[[outcome]], outcome, spec, apply_transform)
    for (pid in levels(dat$ParticipantID)) {
      sel <- dat$ParticipantID == pid
      v <- y[sel]
      rows[[length(rows) + 1L]] <- data.frame(
        ParticipantID = pid,
        outcome = outcome,
        campaign_baseline_mean = mean(v, na.rm = TRUE),
        campaign_baseline_median = median(v, na.rm = TRUE),
        n_epochs = sum(is.finite(v)),
        stringsAsFactors = FALSE
      )
    }
  }
  do.call(rbind, rows)
}

# (2) Epoch deviation from participant overall baseline (not phase median).
h5s_add_campaign_centered_outcomes <- function(dat, spec, apply_transform, baselines) {
  for (outcome in spec$reactivity_outcomes) {
    y <- h5s_transform_outcome(dat[[outcome]], outcome, spec, apply_transform)
    bl <- baselines$campaign_baseline_mean[match(
      paste(dat$ParticipantID, outcome, sep = "|"),
      paste(baselines$ParticipantID, baselines$outcome, sep = "|")
    )]
    dat[[paste0("center_", outcome)]] <- y - bl
    med <- ave(y, dat$ParticipantID, dat$PhaseID, FUN = function(v) median(v, na.rm = TRUE))
    dat[[paste0("delta_phase_", outcome)]] <- y - med
  }
  dat
}

h5s_aggregate_hotspot_day <- function(dat, spec) {
  exp_cols <- spec$exposure_columns
  center_cols <- paste0("center_", spec$reactivity_outcomes)
  delta_cols <- paste0("delta_phase_", spec$reactivity_outcomes)
  out_cols <- unique(c(center_cols, delta_cols))
  keys <- c("ParticipantID", "PhaseID", "Date", "hotspot_id", "mobility_mode", "green_phase", "route_bin")
  sub <- dat[dat$shared_hotspot, , drop = FALSE]
  if (!nrow(sub)) stop("H5 hotspot: no shared_hotspot epochs.", call. = FALSE)

  med_fun <- function(v) median(v, na.rm = TRUE)
  base <- aggregate(
    list(n_epochs = sub$ParticipantID),
    by = sub[, keys, drop = FALSE],
    FUN = length
  )
  if (h5s_rh1_use_elapsed_time_adjustment(spec) && "end_time_s" %in% names(sub)) {
    a_t <- aggregate(list(median_end_time_s = sub$end_time_s), by = sub[, keys, drop = FALSE], FUN = med_fun)
    base$median_end_time_s <- a_t$median_end_time_s
  }
  for (col in exp_cols) {
    a <- aggregate(list(x = sub[[col]]), by = sub[, keys, drop = FALSE], FUN = med_fun)
    base[[paste0("median_", col)]] <- a$x
  }
  for (col in out_cols) {
    if (!col %in% names(sub)) next
    a <- aggregate(list(x = sub[[col]]), by = sub[, keys, drop = FALSE], FUN = med_fun)
    base[[paste0("median_", col)]] <- a$x
  }
  min_ep <- spec$min_epochs_per_hotspot_day
  if (!is.null(min_ep) && is.finite(min_ep) && min_ep > 1L) {
    base <- base[base$n_epochs >= as.integer(min_ep), , drop = FALSE]
    if (!nrow(base)) {
      stop(
        "H5 hotspot: no hotspot-day rows after min_epochs_per_hotspot_day=",
        min_ep, call. = FALSE
      )
    }
  }
  base
}

h5s_cell_count_audit <- function(hd, spec) {
  # Same participant + hotspot on >=2 distinct session dates (design support for repeat visits).
  pu <- unique(hd[, c("ParticipantID", "hotspot_id", "Date"), drop = FALSE])
  pu2 <- aggregate(
    list(n_distinct_dates = rep(1L, nrow(pu))),
    by = list(ParticipantID = pu$ParticipantID, hotspot_id = pu$hotspot_id),
    FUN = length
  )
  n_repl_person_hotspot <- sum(pu2$n_distinct_dates >= 2L)

  ph <- unique(hd[, c("hotspot_id", "Date"), drop = FALSE])
  ph2 <- aggregate(
    list(n_distinct_dates = rep(1L, nrow(ph))),
    by = list(hotspot_id = ph$hotspot_id),
    FUN = length
  )
  n_hotspots_multi_date <- sum(ph2$n_distinct_dates >= 2L, na.rm = TRUE)

  n_participants_two_plus_days <- sum(vapply(
    split(hd$Date, hd$ParticipantID),
    function(d) length(unique(d)) >= 2L,
    logical(1L)
  ))

  rule <- h5s_hotspot_inclusion_rule(spec)
  data.frame(
    metric = c(
      "n_hotspot_day_rows", "n_shared_hotspots", "n_participants",
      "n_participant_hotspot_with_2plus_dates",
      "n_hotspots_with_2plus_campaign_dates",
      "n_participants_with_2plus_campaign_dates",
      "pilot_walkg_only",
      "hotspot_inclusion_rule",
      "spatial_proximity_radius_m",
      "min_participants_shared_place",
      "min_participants_per_shared_bin_legacy",
      "min_epochs_per_hotspot_day",
      "rh1_stratify_by_phase"
    ),
    value = c(
      nrow(hd),
      length(unique(hd$hotspot_id)),
      length(unique(hd$ParticipantID)),
      n_repl_person_hotspot,
      n_hotspots_multi_date,
      n_participants_two_plus_days,
      as.character(isTRUE(spec$pilot_walkg_only)),
      rule,
      if (rule == "spatial_9of11") as.character(h5s_spatial_proximity_radius_m(spec)) else NA_character_,
      if (rule == "spatial_9of11") as.character(h5s_min_participants_for_shared(spec)) else NA_character_,
      if (is.null(spec$min_participants_per_shared_bin)) NA_character_ else as.character(spec$min_participants_per_shared_bin),
      if (is.null(spec$min_epochs_per_hotspot_day)) NA_character_ else as.character(spec$min_epochs_per_hotspot_day),
      as.character(h5s_rh1_stratify_by_phase(spec))
    ),
    stringsAsFactors = FALSE
  )
}

h5s_extract_lme_row <- function(fit, term, model_id, outcome) {
  sm <- summary(fit)
  ct <- sm$tTable
  if (!term %in% rownames(ct)) {
    return(data.frame(
      model_id = model_id, outcome = outcome, term = term, status = "term_missing",
      estimate = NA_real_, std_error = NA_real_, df = NA_real_, p_value = NA_real_,
      stringsAsFactors = FALSE
    ))
  }
  data.frame(
    model_id = model_id, outcome = outcome, term = term, status = "ok",
    estimate = ct[term, "Value"],
    std_error = ct[term, "Std.Error"],
    df = ct[term, "DF"],
    p_value = ct[term, "p-value"],
    stringsAsFactors = FALSE
  )
}

h5s_extract_lmer_row <- function(fit, term, model_id, outcome) {
  ct <- as.data.frame(coef(summary(fit)))
  if (ncol(ct) < 3L || !term %in% rownames(ct)) {
    return(data.frame(
      model_id = model_id, outcome = outcome, term = term, status = "term_missing",
      estimate = NA_real_, std_error = NA_real_, df = NA_real_, p_value = NA_real_,
      stringsAsFactors = FALSE
    ))
  }
  est <- ct[term, 1L]
  se <- ct[term, 2L]
  tval <- ct[term, 3L]
  data.frame(
    model_id = model_id, outcome = outcome, term = term, status = "ok",
    estimate = est, std_error = se, df = NA_real_,
    p_value = 2 * stats::pnorm(-abs(tval)),
    stringsAsFactors = FALSE
  )
}

h5s_fit_hotspot_lmm <- function(fixed_rhs, hd_m, random_participant = TRUE) {
  if (random_participant && requireNamespace("lme4", quietly = TRUE)) {
    fml <- stats::as.formula(paste("y ~", fixed_rhs, "+ (1 | ParticipantID)"))
    fit <- try(
      lme4::lmer(
        fml, data = hd_m, REML = TRUE,
        control = lme4::lmerControl(check.conv.singular = "ignore", check.conv.hess = "ignore")
      ),
      silent = TRUE
    )
    if (!inherits(fit, "try-error")) {
      return(list(converged = TRUE, engine = "lme4", fit = fit, err = NA_character_))
    }
    err <- conditionMessage(attr(fit, "condition"))
  } else {
    err <- NA_character_
  }
  if (!random_participant) {
    fml <- stats::as.formula(paste("y ~", fixed_rhs))
    fit <- try(nlme::lme(fml, data = hd_m, method = "REML", na.action = na.omit), silent = TRUE)
  } else {
    fml <- stats::as.formula(paste("y ~", fixed_rhs))
    fit <- try(
      nlme::lme(fml, data = hd_m, random = ~ 1 | ParticipantID, method = "REML", na.action = na.omit),
      silent = TRUE
    )
  }
  if (inherits(fit, "try-error")) {
    return(list(
      converged = FALSE, engine = "nlme", fit = NULL,
      err = if (length(err)) err else conditionMessage(attr(fit, "condition"))
    ))
  }
  list(converged = TRUE, engine = "nlme", fit = fit, err = NA_character_)
}

h5s_extract_fixed_rows <- function(fit_res, model_id, outcome, terms) {
  if (!fit_res$converged) {
    return(data.frame(
      model_id = model_id, outcome = outcome, term = terms, status = "fit_error",
      estimate = NA_real_, std_error = NA_real_, df = NA_real_, p_value = NA_real_,
      stringsAsFactors = FALSE
    ))
  }
  ext <- if (fit_res$engine == "lme4") h5s_extract_lmer_row else h5s_extract_lme_row
  do.call(rbind, lapply(terms, function(t) ext(fit_res$fit, t, model_id, outcome)))
}

h5s_primary_effects_held <- function(primary_rows, sens_rows, env_c, alpha) {
  p_ok <- primary_rows[primary_rows$term == env_c & primary_rows$status == "ok", , drop = FALSE]
  s_ok <- sens_rows[sens_rows$term == env_c & sens_rows$status == "ok", , drop = FALSE]
  if (!nrow(p_ok) || !nrow(s_ok)) {
    return(c(primary_effects_held = NA, env_sign_held = NA, env_sig_pattern_held = NA))
  }
  env_sign <- sign(p_ok$estimate[1L]) == sign(s_ok$estimate[1L])
  env_sig <- (p_ok$p_value[1L] < alpha) == (s_ok$p_value[1L] < alpha)
  phase_p <- primary_rows[grepl("^PhaseID", primary_rows$term) & primary_rows$status == "ok", , drop = FALSE]
  phase_sign_ok <- TRUE
  if (nrow(phase_p)) {
    for (i in seq_len(nrow(phase_p))) {
      t <- phase_p$term[i]
      s_row <- sens_rows[sens_rows$term == t & sens_rows$status == "ok", , drop = FALSE]
      if (!nrow(s_row)) {
        phase_sign_ok <- FALSE
        break
      }
      if (sign(phase_p$estimate[i]) != sign(s_row$estimate[1L])) {
        phase_sign_ok <- FALSE
        break
      }
    }
  }
  held <- isTRUE(env_sign) && isTRUE(phase_sign_ok) && isTRUE(env_sig)
  c(primary_effects_held = held, env_sign_held = env_sign, env_sig_pattern_held = env_sig)
}

h5s_run_extended_models <- function(spec) {
  isFALSE(isTRUE(spec$run_rh1_only))
}

h5s_rh1_hotspot_coef_table <- function(fit_res, outcome, phase_id = NA_character_, lookup = NULL) {
  note_p <- "raw two-sided p-values; not FDR-adjusted across hotspot levels"
  if (!fit_res$converged) {
    return(data.frame(
      PhaseID = phase_id,
      model_id = "RH1", outcome = outcome, hotspot_id = NA_character_, term = NA_character_,
      estimate = NA_real_, std_error = NA_real_, t_or_z = NA_real_, p_value = NA_real_,
      significant_raw_p05 = NA, p_value_note = note_p, stringsAsFactors = FALSE
    ))
  }
  if (fit_res$engine == "lme4") {
    ct <- as.data.frame(coef(summary(fit_res$fit)))
    colnames(ct) <- c("estimate", "std_error", "t_or_z")
    ct$p_value <- 2 * stats::pnorm(-abs(ct$t_or_z))
  } else {
    ct <- as.data.frame(summary(fit_res$fit)$tTable)
    ct$t_or_z <- ct[["t-value"]]
    ct$p_value <- ct[["p-value"]]
    ct$estimate <- ct[["Value"]]
    ct$std_error <- ct[["Std.Error"]]
  }
  rn <- rownames(ct)
  hs_terms <- rn[grepl("^hotspot_f", rn, fixed = FALSE)]
  if (!length(hs_terms)) {
    return(data.frame(
      PhaseID = phase_id,
      model_id = "RH1", outcome = outcome, hotspot_id = NA_character_, term = NA_character_,
      estimate = NA_real_, std_error = NA_real_, t_or_z = NA_real_, p_value = NA_real_,
      significant_raw_p05 = NA, p_value_note = note_p, stringsAsFactors = FALSE
    ))
  }
  if (is.null(lookup) || !nrow(lookup)) {
    lookup <- data.frame(
      hotspot_id = sub("^hotspot_f", "", hs_terms, fixed = FALSE),
      grid_label = sub("^hotspot_f", "", hs_terms, fixed = FALSE),
      stringsAsFactors = FALSE
    )
  }
  display_term <- vapply(hs_terms, h5s_hotspot_coef_term_display, character(1L), lookup = lookup)
  internal_id <- vapply(hs_terms, h5s_hotspot_id_from_model_term, character(1L), lookup = lookup)
  data.frame(
    PhaseID = phase_id,
    model_id = "RH1",
    outcome = outcome,
    hotspot_id = internal_id,
    grid_label = display_term,
    term_model = hs_terms,
    term = display_term,
    estimate = ct[hs_terms, "estimate"],
    std_error = ct[hs_terms, "std_error"],
    t_or_z = ct[hs_terms, "t_or_z"],
    p_value = ct[hs_terms, "p_value"],
    significant_raw_p05 = ct[hs_terms, "p_value"] < 0.05,
    p_value_note = note_p,
    stringsAsFactors = FALSE,
    row.names = NULL
  )
}

h5s_write_rh1_hotspot_coef_dumps <- function(coef_by_outcome, out_dir, spec) {
  alpha <- spec$exploratory_fdr_alpha
  fam <- h5s_exploratory_fdr_family(spec)
  gc <- h5s_fdr_group_cols(spec, "hotspot_coef")
  note_path <- file.path(out_dir, "RH1_hotspot_coefficients_p_value_note.txt")
  writeLines(c(
    "RH1 hotspot_f fixed-effect coefficients (reference hotspot level omitted by contrast coding).",
    "term / grid_label: corridor buffer cell (route_bin + 1 within PhaseID), e.g. BikeG_grid3.",
    "hotspot_id: internal PhaseID_seg{k}; term_model: raw R fixed-effect name.",
    paste0("p_value_FDR: Benjamini-Hochberg within family '", fam, "' (see spec$exploratory_fdr_family)."),
    "p_value: raw two-sided.",
    "Compare env_ucm_UTCI_c moderator in H5_hotspot_weather_models.csv (separate FDR family for env term)."
  ), note_path)
  parts <- list()
  for (outcome in names(coef_by_outcome)) {
    tab <- coef_by_outcome[[outcome]]
    if (!nrow(tab)) next
    term_m <- if ("term_model" %in% names(tab)) tab$term_model else tab$term
    tab <- tab[grepl("^hotspot_f", term_m, fixed = FALSE), , drop = FALSE]
    if (nrow(tab)) parts[[length(parts) + 1L]] <- tab
  }
  all_hs <- if (length(parts)) do.call(rbind, parts) else data.frame()
  if (nrow(all_hs)) {
    all_hs$p_value_FDR <- h5s_apply_bh_fdr_grouped(all_hs, group_cols = gc)
    all_hs$fdr_significant <- is.finite(all_hs$p_value_FDR) & all_hs$p_value_FDR < alpha
  }
  sig_raw_rows <- list()
  for (outcome in names(coef_by_outcome)) {
    tab <- coef_by_outcome[[outcome]]
    if (nrow(all_hs) && "outcome" %in% names(all_hs)) {
      sub <- all_hs[all_hs$outcome == outcome, , drop = FALSE]
      if (nrow(sub)) {
        fdr_key <- if ("term_model" %in% names(sub)) sub$term_model else sub$term
        fdr_map <- sub$p_value_FDR
        names(fdr_map) <- fdr_key
        sig_map <- sub$fdr_significant
        names(sig_map) <- fdr_key
        tab_key <- if ("term_model" %in% names(tab)) tab$term_model else tab$term
        tab$p_value_FDR <- fdr_map[tab_key]
        tab$fdr_significant <- sig_map[tab_key]
      }
    }
    out_path <- file.path(out_dir, paste0("RH1_hotspot_coefficients_", outcome, ".csv"))
    write.csv(tab, out_path, row.names = FALSE)
    if ("significant_raw_p05" %in% names(tab)) {
      sig <- tab[tab$significant_raw_p05 %in% TRUE, , drop = FALSE]
      if (nrow(sig)) {
        sig_raw_rows[[length(sig_raw_rows) + 1L]] <- sig[, c("outcome", "hotspot_id", "estimate", "p_value"), drop = FALSE]
      }
    }
  }
  if (length(sig_raw_rows)) {
    write.csv(
      do.call(rbind, sig_raw_rows),
      file.path(out_dir, "RH1_hotspot_coefficients_significant_raw_p05.csv"),
      row.names = FALSE
    )
  }
  if (nrow(all_hs)) {
    write.csv(
      all_hs[order(all_hs$outcome, all_hs$PhaseID, all_hs$hotspot_id), , drop = FALSE],
      file.path(out_dir, "H5_RH1_hotspot_FDR_all_tests.csv"),
      row.names = FALSE
    )
    locked <- all_hs[all_hs$fdr_significant %in% TRUE, , drop = FALSE]
    if (nrow(locked)) {
      write.csv(
        locked[order(locked$outcome, locked$PhaseID, locked$p_value_FDR), , drop = FALSE],
        file.path(out_dir, "H5_RH1_hotspot_FDR_significant.csv"),
        row.names = FALSE
      )
    } else {
      write.csv(
        data.frame(note = paste0("no FDR q < ", alpha, " in family ", fam)),
        file.path(out_dir, "H5_RH1_hotspot_FDR_significant.csv"),
        row.names = FALSE
      )
    }
    primary <- if (!is.null(spec$rh1_primary_outcomes)) {
      all_hs[all_hs$outcome %in% spec$rh1_primary_outcomes, , drop = FALSE]
    } else {
      all_hs[0, , drop = FALSE]
    }
    n_primary_fdr <- if (nrow(primary)) sum(primary$fdr_significant %in% TRUE, na.rm = TRUE) else 0L
    write.csv(
      data.frame(
        n_hotspot_f_tests = nrow(all_hs),
        n_raw_p_lt_alpha = sum(all_hs$p_value < alpha, na.rm = TRUE),
        n_fdr_significant = sum(all_hs$fdr_significant %in% TRUE, na.rm = TRUE),
        n_fdr_significant_primary_panel = n_primary_fdr,
        exploratory_fdr_family = fam,
        fdr_group_columns = if (is.null(gc)) "pooled" else paste(gc, collapse = ";"),
        note = "BH on hotspot_f coefficients only"
      ),
      file.path(out_dir, "H5_RH1_hotspot_FDR_summary.csv"),
      row.names = FALSE
    )
  }
  invisible(coef_by_outcome)
}

h5s_key_fixed_terms <- function(fit_res, env_c, extra_terms = character()) {
  if (!fit_res$converged) return(unique(c(env_c, extra_terms)))
  if (fit_res$engine == "lme4") {
    rn <- rownames(coef(summary(fit_res$fit)))
  } else {
    rn <- rownames(summary(fit_res$fit)$tTable)
  }
  unique(c(rn[grepl("^PhaseID", rn)], env_c, extra_terms[extra_terms %in% rn]))
}

h5s_fit_models_and_sensitivity <- function(hd, spec, out_dir = NULL) {
  hd$ParticipantID <- factor(hd$ParticipantID, levels = spec$participants)
  hd$PhaseID <- factor(hd$PhaseID, levels = h5s_analysis_phases(spec))
  env_c <- h5s_moderator_term_name(spec)
  env_term <- h5s_formula_term(spec$environment_moderator_column)
  env_int_green <- paste0(env_term, ":green_phaseTRUE")
  alpha <- spec$exploratory_fdr_alpha
  stratify <- h5s_rh1_stratify_by_phase(spec)
  resp_label <- h5s_rh1_response_label(spec)
  rh1_outcomes <- h5s_rh1_outcomes(spec)
  rh1_sec <- h5s_rh1_secondary_temporal_term(spec)
  sec_c <- if (rh1_sec$use) rh1_sec$col else NA_character_
  sec_rhs <- rh1_sec$rhs
  rh1_elapsed <- h5s_rh1_elapsed_adjustment(spec)
  elapsed_c <- if (rh1_elapsed$use) rh1_elapsed$col else NA_character_
  elapsed_rhs <- rh1_elapsed$rhs

  model_rows <- list()
  sens_summary_rows <- list()
  rh1_primary_by_outcome <- list()
  rh1_hotspot_coef_by_outcome <- list()

  for (outcome in rh1_outcomes) {
    ycol <- h5s_rh1_median_outcome_col(outcome, spec)
    if (!ycol %in% names(hd)) next
    hd$y <- hd[[ycol]]
    hd_m <- hd[is.finite(hd$y) & is.finite(hd[[env_c]]), , drop = FALSE]
    if (rh1_sec$use) {
      hd_m <- hd_m[is.finite(hd_m[[sec_c]]), , drop = FALSE]
    }
    if (rh1_elapsed$use) {
      hd_m <- hd_m[is.finite(hd_m[[elapsed_c]]), , drop = FALSE]
    }
    if (nrow(hd_m) < spec$min_rows_per_model) {
      model_rows[[length(model_rows) + 1L]] <- data.frame(
        PhaseID = NA_character_, model_id = "RH1", outcome = outcome, term = NA_character_,
        status = "insufficient_rows",
        estimate = NA_real_, std_error = NA_real_, df = NA_real_, p_value = NA_real_,
        stringsAsFactors = FALSE
      )
      next
    }

    phase_levels <- if (stratify) levels(hd_m$PhaseID) else NA_character_
    n_slices <- if (stratify) length(phase_levels) else 1L
    coef_parts <- list()

    for (slice_i in seq_len(n_slices)) {
      if (stratify) {
        ph <- phase_levels[slice_i]
        hd_p <- hd_m[hd_m$PhaseID == ph, , drop = FALSE]
        hd_p <- h5s_attach_hotspot_factor(hd_p)
        phase_prefix <- ""
        phase_id <- ph
      } else {
        hd_p <- h5s_attach_hotspot_factor(hd_m)
        phase_prefix <- h5s_rh1_phase_fixed_prefix(hd_m)
        phase_id <- NA_character_
      }
      if (nrow(hd_p) < spec$min_rows_per_model) next

      rh1_rhs <- paste0(phase_prefix, env_term, elapsed_rhs, sec_rhs, " + hotspot_f")
      rh1_formula <- paste0(
        resp_label, "_", outcome, " ~ ", if (nzchar(phase_prefix)) "PhaseID + " else "",
        env_c,
        if (rh1_elapsed$use) paste0(" + ", elapsed_c) else "",
        if (rh1_sec$use) paste0(" + ", sec_c) else "", " + hotspot_f; random = ~1|ParticipantID",
        if (stratify) paste0(" [PhaseID=", phase_id, "]") else ""
      )
      rh1 <- h5s_fit_hotspot_lmm(rh1_rhs, hd_p, random_participant = TRUE)
      rh1_extra <- c(
        if (rh1_elapsed$use) elapsed_c else character(),
        if (rh1_sec$use) sec_c else character()
      )
      rh1_terms <- h5s_key_fixed_terms(rh1, env_c, rh1_extra)
      rh1_rows <- h5s_extract_fixed_rows(rh1, "RH1", outcome, rh1_terms)
      rh1_rows$PhaseID <- phase_id
      rh1_primary_by_outcome[[paste(outcome, phase_id, sep = "|")]] <- rh1_rows
      model_rows[[length(model_rows) + 1L]] <- rh1_rows
      hs_lookup <- unique(hd_p[, c("hotspot_id", "route_bin", "PhaseID"), drop = FALSE])
      hs_lookup$grid_label <- mapply(
        h5s_grid_label, hs_lookup$PhaseID, hs_lookup$route_bin, USE.NAMES = FALSE
      )
      coef_parts[[length(coef_parts) + 1L]] <- h5s_rh1_hotspot_coef_table(
        rh1, outcome, phase_id = phase_id, lookup = hs_lookup
      )

      sens_summary_rows[[length(sens_summary_rows) + 1L]] <- data.frame(
        model_id = "RH1_primary",
        PhaseID = phase_id,
        outcome = outcome,
        formula = rh1_formula,
        added_covariate = NA_character_,
        converged = rh1$converged,
        fit_engine = rh1$engine,
        fit_error = rh1$err,
        env_ucm_UTCI_c_estimate = rh1_rows$estimate[rh1_rows$term == env_c][1L],
        env_ucm_UTCI_c_p_value = rh1_rows$p_value[rh1_rows$term == env_c][1L],
        rh1_lag_term = if (identical(rh1_sec$kind, "lag")) sec_c else NA_character_,
        rh1_lag_estimate = if (identical(rh1_sec$kind, "lag")) rh1_rows$estimate[rh1_rows$term == sec_c][1L] else NA_real_,
        rh1_lag_p_value = if (identical(rh1_sec$kind, "lag")) rh1_rows$p_value[rh1_rows$term == sec_c][1L] else NA_real_,
        rh1_cumulative_term = if (identical(rh1_sec$kind, "cumulative")) sec_c else NA_character_,
        rh1_cumulative_estimate = if (identical(rh1_sec$kind, "cumulative")) rh1_rows$estimate[rh1_rows$term == sec_c][1L] else NA_real_,
        rh1_cumulative_p_value = if (identical(rh1_sec$kind, "cumulative")) rh1_rows$p_value[rh1_rows$term == sec_c][1L] else NA_real_,
        primary_effects_held = NA,
        env_sign_held = NA,
        env_sig_pattern_held = NA,
        stringsAsFactors = FALSE
      )
    }
    if (length(coef_parts)) {
      rh1_hotspot_coef_by_outcome[[outcome]] <- do.call(rbind, coef_parts)
    }

    if (h5s_run_extended_models(spec)) {
      hd_m <- h5s_attach_hotspot_factor(hd_m)
      for (cov in spec$sensitivity_covariate_columns) {
        cov_term <- h5s_formula_term(cov)
        cov_c <- h5s_centered_covariate_name(cov)
        if (!cov_c %in% names(hd_m)) next
        hd_s <- hd_m[is.finite(hd_m[[cov_c]]), , drop = FALSE]
        if (nrow(hd_s) < spec$min_rows_per_model) next
        sens_id <- paste0("RH1_sens_", cov)
        sens_rhs <- paste0(phase_prefix, env_term, " + ", cov_term, " + hotspot_f")
        sens_formula <- paste0(
          "median_center_", outcome, " ~ ", if (nzchar(phase_prefix)) "PhaseID + " else "",
          env_c, " + ", cov_c, " + hotspot_f",
          "; random = ~1|ParticipantID"
        )
        sens_fit <- h5s_fit_hotspot_lmm(sens_rhs, hd_s, random_participant = TRUE)
        sens_terms <- c(h5s_key_fixed_terms(sens_fit, env_c), cov_c)
        sens_rows <- h5s_extract_fixed_rows(sens_fit, sens_id, outcome, sens_terms)
        model_rows[[length(model_rows) + 1L]] <- sens_rows
        cmp <- h5s_primary_effects_held(rh1_rows, sens_rows, env_c, alpha)
        sens_summary_rows[[length(sens_summary_rows) + 1L]] <- data.frame(
          model_id = sens_id,
          outcome = outcome,
          formula = sens_formula,
          added_covariate = cov,
          converged = sens_fit$converged,
          fit_engine = sens_fit$engine,
          fit_error = sens_fit$err,
          env_ucm_UTCI_c_estimate = sens_rows$estimate[sens_rows$term == env_c][1L],
          env_ucm_UTCI_c_p_value = sens_rows$p_value[sens_rows$term == env_c][1L],
          primary_effects_held = as.logical(cmp["primary_effects_held"]),
          env_sign_held = as.logical(cmp["env_sign_held"]),
          env_sig_pattern_held = as.logical(cmp["env_sig_pattern_held"]),
          stringsAsFactors = FALSE
        )
      }

      # RH2: PhaseID + env_ucm_UTCI_c * green_phase + hotspot_f
      rh2_rhs <- paste("PhaseID +", env_term, "* green_phase + hotspot_f")
      rh2 <- h5s_fit_hotspot_lmm(rh2_rhs, hd_m, random_participant = TRUE)
      if (rh2$converged) {
        rn2 <- if (rh2$engine == "lme4") {
          rownames(coef(summary(rh2$fit)))
        } else {
          rownames(summary(rh2$fit)$tTable)
        }
        rh2_terms <- c(env_c, rn2[grepl(env_c, rn2, fixed = TRUE) & grepl("green_phase", rn2)])
        model_rows[[length(model_rows) + 1L]] <- h5s_extract_fixed_rows(rh2, "RH2", outcome, rh2_terms)
      }

      # RH3: random slope route_bin_num | ParticipantID
      hd_m$route_bin_num <- as.numeric(hd_m$route_bin)
      f_rh3 <- try(
        nlme::lme(
          stats::as.formula(paste("y ~ PhaseID +", env_term, "+ route_bin_num")),
          data = hd_m, random = ~ route_bin_num | ParticipantID, method = "REML", na.action = na.omit
        ),
        silent = TRUE
      )
      if (!inherits(f_rh3, "try-error")) {
        model_rows[[length(model_rows) + 1L]] <- data.frame(
          model_id = "RH3", outcome = outcome, term = "random_slope_route_bin",
          status = "ok", estimate = NA_real_, std_error = NA_real_, df = NA_real_, p_value = NA_real_,
          stringsAsFactors = FALSE
        )
      }

      # RH4: mobility_mode + env + hotspot_f
      rh4 <- h5s_fit_hotspot_lmm(paste("mobility_mode +", env_term, "+ hotspot_f"), hd_m, random_participant = TRUE)
      if (rh4$converged) {
        model_rows[[length(model_rows) + 1L]] <- h5s_extract_fixed_rows(rh4, "RH4_mode", outcome, "mobility_modewalk")
      }
    }
  }

  tab <- do.call(rbind, model_rows)
  ok <- tab$status == "ok" & tab$term == env_c & tab$model_id == "RH1"
  tab$p_value_FDR <- NA_real_
  tab$fdr_significant <- FALSE
  if (any(ok)) {
    sub <- tab[ok, , drop = FALSE]
    gc_env <- h5s_fdr_group_cols(spec, "env_moderator")
    tab$p_value_FDR[ok] <- h5s_apply_bh_fdr_grouped(sub, group_cols = gc_env)
    tab$fdr_significant[ok] <- is.finite(tab$p_value_FDR[ok]) & tab$p_value_FDR[ok] < alpha
  }
  fdr_family <- h5s_env_moderator_fdr_family_label(spec)
  strat_note <- if (stratify) "RH1 stratified by PhaseID (hotspot_f within phase)" else "RH1 pooled PhaseID fixed effect"
  tab$family_note <- if (h5s_run_extended_models(spec)) {
    paste0(
      "Exploratory H5 hotspot; ", strat_note, "; backpack env moderator ",
      spec$environment_moderator_column,
      "; staged +1 covariate sensitivities; FDR family ", fdr_family,
      "; not merged with H1–H4 FDR"
    )
  } else {
    paste0(
      "Exploratory H5 hotspot RH1 only; ", strat_note,
      "; response=", resp_label,
      if (identical(rh1_sec$kind, "lag")) {
        paste0("; RH1 lag=", sec_c, " (prior row UTCI within participant×phase)")
      } else if (identical(rh1_sec$kind, "cumulative")) {
        paste0("; RH1 cumulative=", sec_c, " (cumsum centered UTCI within participant×phase, grand-mean centered)")
      } else {
        ""
      },
      "; FDR family ", fdr_family,
      "; not merged with H1–H4 FDR"
    )
  }
  sens_summary <- if (length(sens_summary_rows)) do.call(rbind, sens_summary_rows) else {
    data.frame(note = "RH1 only — sensitivities skipped (run_rh1_only)", stringsAsFactors = FALSE)
  }
  if (!is.null(out_dir) && length(rh1_hotspot_coef_by_outcome)) {
    h5s_write_rh1_hotspot_coef_dumps(rh1_hotspot_coef_by_outcome, out_dir, spec)
  }
  list(
    models = tab, sensitivity_summary = sens_summary,
    sensitivity_detail = tab[tab$model_id == "RH1", , drop = FALSE],
    rh1_hotspot_coef_by_outcome = rh1_hotspot_coef_by_outcome
  )
}

h5s_fit_models <- function(hd, spec) {
  h5s_fit_models_and_sensitivity(hd, spec)$models
}

h5s_participant_hotspot_random_effects <- function(hd, spec) {
  out <- list()
  for (outcome in spec$reactivity_outcomes) {
    ycol <- paste0("median_center_", outcome)
    if (!ycol %in% names(hd)) next
    hd$y <- hd[[ycol]]
    hd_m <- hd[is.finite(hd$y), , drop = FALSE]
    if (nrow(hd_m) < spec$min_rows_per_model) next
    hd_m$route_bin_num <- as.numeric(hd_m$route_bin)
    env_c <- h5s_moderator_term_name(spec)
    f <- try(nlme::lme(
      stats::as.formula(paste("y ~ PhaseID +", env_c, "+ route_bin_num")),
      data = hd_m, random = ~ route_bin_num | ParticipantID, method = "REML", na.action = na.omit
    ), silent = TRUE)
    if (inherits(f, "try-error")) next
    re <- as.data.frame(nlme::ranef(f))
    re$ParticipantID <- rownames(re)
    re$outcome <- outcome
    out[[length(out) + 1L]] <- re
  }
  if (!length(out)) return(data.frame(note = "no random-effect fits"))
  do.call(rbind, out)
}

h5s_participant_hotspot_outliers <- function(hd, spec) {
  thr <- spec$outlier_z_threshold
  rows <- list()
  for (outcome in spec$reactivity_outcomes) {
    ycol <- paste0("median_center_", outcome)
    if (!ycol %in% names(hd)) next
    for (hid in unique(hd$hotspot_id)) {
      sel <- hd$hotspot_id == hid & is.finite(hd[[ycol]])
      if (sum(sel) < h5s_min_participants_for_outliers(spec)) next
      v <- hd[[ycol]][sel]
      mu <- mean(v, na.rm = TRUE)
      sdv <- sd(v, na.rm = TRUE)
      if (!is.finite(sdv) || sdv == 0) next
      sub <- hd[sel, , drop = FALSE]
      z <- (sub[[ycol]] - mu) / sdv
      for (i in seq_len(nrow(sub))) {
        if (abs(z[i]) >= thr) {
          rows[[length(rows) + 1L]] <- data.frame(
            outcome = outcome,
            hotspot_id = hid,
            ParticipantID = as.character(sub$ParticipantID[i]),
            PhaseID = as.character(sub$PhaseID[i]),
            Date = as.character(sub$Date[i]),
            median_center = sub[[ycol]][i],
            hotspot_mean = mu,
            hotspot_sd = sdv,
            z_score = z[i],
            flag = if (z[i] > 0) "high_vs_hotspot_peers" else "low_vs_hotspot_peers",
            stringsAsFactors = FALSE
          )
        }
      }
    }
  }
  if (!length(rows)) {
    return(data.frame(note = paste0("no |z| >= ", thr, " at shared hotspots"), stringsAsFactors = FALSE))
  }
  do.call(rbind, rows)
}

h5s_positive_result_criteria <- function(audit, models, spec) {
  n_repl <- audit$value[audit$metric == "n_participant_hotspot_with_2plus_dates"]
  env_c <- h5s_moderator_term_name(spec)
  rh1_ok <- models[models$model_id == "RH1" & models$term == env_c & models$status == "ok", , drop = FALSE]
  data.frame(
    criterion = c(
      "replication_5plus_participant_hotspot_2dates",
      "RH1_env_moderator_FDR_sig",
      "RH1_env_moderator_raw_p_lt_alpha"
    ),
    passed = c(
      is.finite(n_repl) && n_repl >= spec$min_replication_participant_hotspot_days,
      any(rh1_ok$fdr_significant %in% TRUE, na.rm = TRUE),
      any(rh1_ok$p_value < spec$exploratory_fdr_alpha, na.rm = TRUE)
    ),
    detail = c(
      paste0("n=", n_repl),
      paste0(
        "n_FDR_sig=", sum(rh1_ok$fdr_significant %in% TRUE, na.rm = TRUE),
        "; env_FDR_family=", h5s_env_moderator_fdr_family_label(spec)
      ),
      paste0("n_raw_sig=", sum(rh1_ok$p_value < spec$exploratory_fdr_alpha, na.rm = TRUE))
    ),
    stringsAsFactors = FALSE
  )
}

h5s_hotspot_stability <- function(hd, spec) {
  slope_med <- paste0("median_", spec$slope_column)
  keys <- list(hotspot_id = hd$hotspot_id, PhaseID = hd$PhaseID)
  out <- aggregate(
    list(
      median_SVF = hd$median_SVF, median_TVF = hd$median_TVF, median_BVF = hd$median_BVF,
      median_ucm_UTCI = hd$median_ucm_UTCI
    ),
    by = keys,
    FUN = function(v) median(v, na.rm = TRUE)
  )
  if (slope_med %in% names(hd)) {
    out[[slope_med]] <- aggregate(hd[[slope_med]], by = keys, FUN = function(v) median(v, na.rm = TRUE))$x
    out[[paste0("mean_", spec$slope_column)]] <- aggregate(
      hd[[slope_med]], by = keys, FUN = function(v) mean(v, na.rm = TRUE)
    )$x
  }
  out
}

h5s_dispatch_run <- function(spec, project_root, script_path, raw_data_path) {
  out_dir <- h5s_output_dir(project_root, spec)
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  apply_transform <- function(x, col) paper3_apply_csv_transform(x, col, spec$outcome_transforms_csv)

  prep <- h5s_prepare_hotspot_day(spec, raw_data_path, apply_transform)
  dat <- prep$epoch
  baselines <- prep$baselines
  hotspot_day <- prep$hotspot_day
  if (h5s_hotspot_definition(spec) == "corridor_buffer") {
    audit_cols <- intersect(
      c(
        "ParticipantID", "PhaseID", "Date", "Datetime", "buffer_seg_idx", "route_bin",
        "hotspot_id", "shared_hotspot", "ucm_GPS_lat", "ucm_GPS_lon"
      ),
      names(dat)
    )
    write.csv(
      dat[, audit_cols, drop = FALSE],
      file.path(out_dir, "H5_epoch_buffer_assignment.csv"),
      row.names = FALSE
    )
    label_map <- h5s_hotspot_label_map_df(dat)
    if (nrow(label_map)) {
      write.csv(
        label_map,
        file.path(out_dir, "H5_corridor_grid_label_map.csv"),
        row.names = FALSE
      )
    }
  }
  slope_audit <- h5s_slope_audit(dat, spec)
  env_discovered <- h5s_discover_environment_columns(dat)

  audit <- h5s_cell_count_audit(hotspot_day, spec)
  stability <- h5s_hotspot_stability(hotspot_day, spec)
  fit_bundle <- h5s_fit_models_and_sensitivity(hotspot_day, spec, out_dir = out_dir)
  models <- fit_bundle$models
  sensitivity_summary <- fit_bundle$sensitivity_summary
  sensitivity_models <- fit_bundle$sensitivity_detail
  outliers <- h5s_participant_hotspot_outliers(hotspot_day, spec)
  criteria <- h5s_positive_result_criteria(audit, models, spec)

  re_fx <- if (h5s_run_extended_models(spec)) {
    try(h5s_participant_hotspot_random_effects(hotspot_day, spec), silent = TRUE)
  } else {
    data.frame(note = "RH1 only — RH3 random-effect extraction skipped (run_rh1_only)")
  }
  if (inherits(re_fx, "try-error")) re_fx <- data.frame(note = "random-effect extraction failed")

  write.csv(baselines, file.path(out_dir, "H5_participant_campaign_baselines.csv"), row.names = FALSE)
  write.csv(hotspot_day, file.path(out_dir, "H5_hotspot_day.csv"), row.names = FALSE)
  write.csv(audit, file.path(out_dir, "H5_hotspot_cell_audit.csv"), row.names = FALSE)
  write.csv(stability, file.path(out_dir, "H5_hotspot_exposure_stability.csv"), row.names = FALSE)
  write.csv(slope_audit, file.path(out_dir, "H5_hotspot_slope_audit.csv"), row.names = FALSE)
  write.csv(models, file.path(out_dir, "H5_hotspot_weather_models.csv"), row.names = FALSE)
  write.csv(sensitivity_summary, file.path(out_dir, "H5_hotspot_sensitivity_summary.csv"), row.names = FALSE)
  write.csv(sensitivity_models, file.path(out_dir, "H5_hotspot_sensitivity_models.csv"), row.names = FALSE)
  write.csv(outliers, file.path(out_dir, "H5_participant_hotspot_outliers.csv"), row.names = FALSE)
  write.csv(criteria, file.path(out_dir, "H5_hotspot_positive_criteria.csv"), row.names = FALSE)
  if (is.data.frame(re_fx)) write.csv(re_fx, file.path(out_dir, "H5_participant_hotspot_random_effects.csv"), row.names = FALSE)

  env_c <- h5s_moderator_term_name(spec)
  inclusion_audit <- try(
    h5s_compare_hotspot_inclusion_audit(spec, project_root, raw_data_path),
    silent = TRUE
  )
  if (!inherits(inclusion_audit, "try-error")) {
    write.csv(
      inclusion_audit,
      file.path(out_dir, "H5_hotspot_inclusion_rule_comparison.csv"),
      row.names = FALSE
    )
  }

  manifest <- data.frame(
    field = c(
      "script_path", "raw_data_path", "analysis", "hotspot_definition", "buffer_gpkg_dir",
      "route_distance_bin_m",
      "pilot_walkg_only", "analysis_phases",
      "rh1_stratify_by_phase", "rh1_outcome_scope", "rh1_response",
      "rh1_include_temporal_lag", "rh1_lag_term",
      "rh1_include_cumulative_exposure", "rh1_cumulative_term",
      "rh1_include_elapsed_time_adjustment", "rh1_elapsed_term",
      "epoch_order_within_session", "results_subdirectory",
      "min_epochs_per_hotspot_day", "exploratory_fdr_family",
      "hotspot_inclusion_rule", "spatial_proximity_radius_m", "min_participants_shared_place",
      "environment_moderator_column", "environment_moderator_term",
      "exposure_columns_aggregated", "sensitivity_covariates_one_at_a_time",
      "environment_columns_discovered_n", "environment_columns_discovered",
      "hotspot_slope_column", "hotspot_slope_status", "hotspot_slope_source_column",
      "n_epochs", "n_hotspot_day_rows", "timestamp_utc"
    ),
    value = c(
      if (is.null(script_path)) "" else as.character(script_path),
      raw_data_path, "repeated_hotspot_backpack_env_staged_sensitivity",
      h5s_hotspot_definition(spec),
      if (is.null(spec$buffer_gpkg_dir)) "" else as.character(spec$buffer_gpkg_dir),
      if (is.null(spec$route_distance_bin_m)) "" else as.character(spec$route_distance_bin_m),
      as.character(isTRUE(spec$pilot_walkg_only)),
      paste(h5s_analysis_phases(spec), collapse = ";"),
      as.character(h5s_rh1_stratify_by_phase(spec)),
      if (is.null(spec$rh1_outcome_scope)) "all" else spec$rh1_outcome_scope,
      h5s_rh1_response_label(spec),
      as.character(h5s_rh1_use_temporal_lag(spec)),
      if (h5s_rh1_use_temporal_lag(spec)) h5s_rh1_lag_term_name(spec) else NA_character_,
      as.character(h5s_rh1_use_cumulative_exposure(spec)),
      if (h5s_rh1_use_cumulative_exposure(spec)) h5s_rh1_cumulative_term_name(spec) else NA_character_,
      as.character(h5s_rh1_use_elapsed_time_adjustment(spec)),
      if (h5s_rh1_use_elapsed_time_adjustment(spec)) h5s_rh1_elapsed_term_name(spec) else NA_character_,
      if (h5s_hotspot_definition(spec) == "corridor_buffer") {
        "ParticipantID_PhaseID_Date_Datetime"
      } else {
        "route_distance_resets_per_session_date"
      },
      if (is.null(spec$results_subdirectory)) "" else spec$results_subdirectory,
      as.character(if (is.null(spec$min_epochs_per_hotspot_day)) NA_integer_ else spec$min_epochs_per_hotspot_day),
      if (is.null(spec$exploratory_fdr_family)) "within_outcome" else spec$exploratory_fdr_family,
      h5s_hotspot_inclusion_rule(spec),
      as.character(h5s_spatial_proximity_radius_m(spec)),
      as.character(if (h5s_hotspot_inclusion_rule(spec) == "spatial_9of11") {
        h5s_min_participants_for_shared(spec)
      } else NA_integer_),
      spec$environment_moderator_column, env_c,
      paste(spec$exposure_columns, collapse = ";"),
      paste(spec$sensitivity_covariate_columns, collapse = ";"),
      as.character(length(env_discovered)),
      paste(env_discovered, collapse = ";"),
      spec$slope_column,
      if (is.null(spec$slope_status)) "derived" else spec$slope_status,
      "ucm_GPS_alt",
      as.character(nrow(dat)),
      as.character(nrow(hotspot_day)),
      format(Sys.time(), tz = "UTC", usetz = TRUE)
    ),
    stringsAsFactors = FALSE
  )
  write.csv(manifest, file.path(out_dir, "H5_Run_Manifest.csv"), row.names = FALSE)

  cat("[H5 hotspot backpack env] Wrote:", out_dir, "\n")
  print(audit)
  print(criteria)
  invisible(list(
    epoch = dat, baselines = baselines, hotspot_day = hotspot_day,
    audit = audit, models = models, outliers = outliers, criteria = criteria
  ))
}

# Build hotspot-day table through centering / optional RH1 covariate columns (shared by dispatch + LOPO).
h5s_prepare_hotspot_day <- function(spec, raw_data_path, apply_transform) {
  dat <- h5s_build_epoch_table(spec, raw_data_path)
  dat <- h5s_order_epochs(dat)
  if (h5s_hotspot_definition(spec) == "distance_bin") {
    dat <- h5s_route_distance(dat)
  }
  dat <- h5s_add_gps_segment_slope(dat, spec)
  dat <- h5s_assign_hotspots(dat, spec, raw_data_path = raw_data_path)
  baselines <- h5s_participant_campaign_baselines(dat, spec, apply_transform)
  dat <- h5s_add_campaign_centered_outcomes(dat, spec, apply_transform, baselines)
  hotspot_day <- h5s_aggregate_hotspot_day(dat, spec)
  hotspot_day <- h5s_center_env_predictors(hotspot_day, spec)
  hotspot_day <- h5s_add_rh1_temporal_lags(hotspot_day, spec)
  hotspot_day <- h5s_add_rh1_cumulative_exposure(hotspot_day, spec)
  if (h5s_rh1_use_elapsed_time_adjustment(spec)) {
    hotspot_day <- h5s_add_elapsed_time_covariate(hotspot_day, spec)
  }
  list(epoch = dat, baselines = baselines, hotspot_day = hotspot_day)
}

# Leave-one-participant-out RH1 hotspot_f coefficients (raw p; FDR applied in temp/H5_RH1_hotspot_FDR.py).
h5s_run_lopo_rh1 <- function(spec, project_root, raw_data_path) {
  out_dir <- h5s_output_dir(project_root, spec)
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  apply_transform <- function(x, col) paper3_apply_csv_transform(x, col, spec$outcome_transforms_csv)
  prep <- h5s_prepare_hotspot_day(spec, raw_data_path, apply_transform)
  hd_all <- prep$hotspot_day
  rows <- list()
  for (leave_out in spec$participants) {
    hd_lo <- hd_all[as.character(hd_all$ParticipantID) != as.character(leave_out), , drop = FALSE]
    fit_bundle <- h5s_fit_models_and_sensitivity(hd_lo, spec, out_dir = NULL)
    for (outcome in names(fit_bundle$rh1_hotspot_coef_by_outcome)) {
      tb <- fit_bundle$rh1_hotspot_coef_by_outcome[[outcome]]
      if (!is.data.frame(tb) || !nrow(tb)) next
      tb$leave_out_participant <- leave_out
      rows[[length(rows) + 1L]] <- tb
    }
  }
  lopo <- if (length(rows)) do.call(rbind, rows) else data.frame(note = "no LOPO rows")
  write.csv(lopo, file.path(out_dir, "H5_RH1_lopo_hotspot_coefficients.csv"), row.names = FALSE)
  invisible(lopo)
}

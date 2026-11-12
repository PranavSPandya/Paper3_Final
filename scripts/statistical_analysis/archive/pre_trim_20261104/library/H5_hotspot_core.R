# H5 engine: repeated hotspot x day exposure, backpack environment moderation and campaign baseline centering.
# Hotspots are corridor buffer cells (uCM GPS in *_buffer_{11|35}m.gpkg); SVF/TVF/BVF/slope describe the site, uCM values are momentary covariates.

h5s_haversine_m <- function(lat1, lon1, lat2, lon2) {
  rad <- pi / 180
  lat1 <- lat1 * rad
  lat2 <- lat2 * rad
  dlat <- (lat2 - lat1)
  dlon <- (lon2 - lon1) * rad
  a <- sin(dlat / 2)^2 + cos(lat1) * cos(lat2) * sin(dlon / 2)^2
  6371000 * 2 * atan2(sqrt(a), sqrt(1 - a))}

# Output folder named after the entry script.
h5s_output_dir <- function(project_root, spec = NULL) {
  base <- file.path(project_root, "output", "statistical_analysis", "results", "H5_hotspot_weather")
  sub <- if (!is.null(spec)) spec$results_subdirectory else NULL
  if (!is.null(sub) && nzchar(sub)) file.path(base, sub) else base}

h5s_archive_legacy_output_dir <- function(project_root) {
  results <- file.path(project_root, "output", "statistical_analysis", "results")
  legacy <- file.path(results, "H5_exploratory")
  if (!dir.exists(legacy)) return(invisible(NULL))
  target <- file.path(results, "archive", "superseded_20261103", "H5_exploratory")
  if (dir.exists(target)) target <- paste0(target, "_", format(Sys.time(), "%Y%m%d_%H%M%S"))
  dir.create(dirname(target), recursive = TRUE, showWarnings = FALSE)
  if (!file.rename(legacy, target)) {
    warning("Could not move legacy results/H5_exploratory to ", target, "; move it by hand.", call. = FALSE)
  } else message("[H5] Archived legacy results/H5_exploratory -> ", target)
  invisible(target)}

h5s_rh1_phase_fixed_prefix <- function(hd_m) {
  if (length(unique(as.character(hd_m$PhaseID))) <= 1L) return("")
  "PhaseID + "}

# Prior hotspot-day UTCI within participant x phase x date (order route_bin). Off unless spec$rh1_include_temporal_lag.
h5s_rh1_use_temporal_lag <- function(spec) {
  isTRUE(spec$rh1_include_temporal_lag)}

h5s_rh1_lag_term_name <- function(spec) {
  if (is.null(spec$rh1_lag_term)) "env_ucm_UTCI_lag1_c" else spec$rh1_lag_term}

h5s_add_rh1_temporal_lags <- function(hd, spec) {
  if (!h5s_rh1_use_temporal_lag(spec)) return(hd)
  env_c <- h5s_moderator_term_name(spec)
  lag_col <- h5s_rh1_lag_term_name(spec)
  if (!env_c %in% names(hd)) {
    stop("H5 RH1 lag: missing ", env_c, " on hotspot-day table.", call. = FALSE)}
  ord <- order(hd$ParticipantID, hd$PhaseID, hd$Date, hd$route_bin, hd$hotspot_id)
  hd <- hd[ord, , drop = FALSE]
  n <- nrow(hd)
  lag_utci <- rep(NA_real_, n)
  idx <- 1L
  while (idx <= n) {
    other_index <- idx
    pid <- hd$ParticipantID[idx]
    ph <- hd$PhaseID[idx]
    dt <- hd$Date[idx]
    while (other_index <= n && hd$ParticipantID[other_index] == pid &&
           hd$PhaseID[other_index] == ph && hd$Date[other_index] == dt) {
      if (other_index > idx) lag_utci[other_index] <- hd[[env_c]][other_index - 1L]
      other_index <- other_index + 1L}
    idx <- other_index}
  hd[[lag_col]] <- lag_utci
  hd}

# RH1 exploratory BH-FDR (single p_value_FDR column; family from spec$exploratory_fdr_family).
h5s_rh1_stratify_by_phase <- function(spec) {
  if (is.null(spec$rh1_stratify_by_phase)) return(FALSE)
  isTRUE(spec$rh1_stratify_by_phase)}

h5s_exploratory_fdr_family <- function(spec) {
  if (is.null(spec$exploratory_fdr_family)) "within_outcome" else spec$exploratory_fdr_family}

h5s_apply_bh_fdr <- function(p) {
  p <- as.numeric(p)
  q <- rep(NA_real_, length(p))
  finite_p <- is.finite(p)
  q[finite_p] <- stats::p.adjust(p[finite_p], method = "BH")
  q
}

h5s_apply_bh_fdr_grouped <- function(input_data, p_col = "p_value", group_cols = NULL) {
  if (!nrow(input_data)) return(numeric())
  q <- rep(NA_real_, nrow(input_data))
  if (is.null(group_cols) || !length(group_cols)) {
    return(h5s_apply_bh_fdr(input_data[[p_col]]))}
  miss <- setdiff(group_cols, names(input_data))
  if (length(miss)) {
    stop("H5 FDR: missing group columns: ", paste(miss, collapse = ", "), call. = FALSE)}
  keys <- interaction(input_data[, group_cols, drop = FALSE], drop = TRUE)
  for (key in unique(keys)) {
    idx <- which(keys == key)
    q[idx] <- h5s_apply_bh_fdr(input_data[[p_col]][idx])}
  q}

# hotspot_f uses the locked family; env_ucm_UTCI_c is tested within outcome x phase when stratified.
h5s_fdr_group_cols <- function(spec, target = c("env_moderator", "hotspot_coef")) {
  target <- match.arg(target)
  fam <- h5s_exploratory_fdr_family(spec)
  if (target == "hotspot_coef") {
    if (fam == "pooled") return(NULL)
    if (fam == "within_outcome") return("outcome")
    if (fam == "within_outcome_x_phase") return(c("outcome", "PhaseID"))
    stop("H5 FDR: unknown exploratory_fdr_family: ", fam, call. = FALSE)}
  if (fam == "pooled") return(NULL)
  if (fam == "within_outcome") return("outcome")
  if (fam == "within_outcome_x_phase") {
    if (h5s_rh1_stratify_by_phase(spec)) return("outcome")
    return(c("outcome", "PhaseID"))}
  stop("H5 FDR: unknown exploratory_fdr_family: ", fam, call. = FALSE)}

h5s_env_moderator_fdr_family_label <- function(spec) {
  fam <- h5s_exploratory_fdr_family(spec)
  if (fam == "within_outcome_x_phase" && h5s_rh1_stratify_by_phase(spec)) {
    return("within_outcome (env: one UTCI test per outcome×phase model)")}
  fam}

h5s_rh1_outcomes <- function(spec) {
  if (!is.null(spec$rh1_outcome_names)) return(spec$rh1_outcome_names)
  if (identical(spec$rh1_outcome_scope, "primary")) {
    if (is.null(spec$rh1_primary_outcomes)) {
      stop("H5 hotspot: rh1_outcome_scope='primary' requires rh1_primary_outcomes", call. = FALSE)}
    return(spec$rh1_primary_outcomes)}
  spec$reactivity_outcomes}

h5s_rh1_median_outcome_col <- function(outcome, spec) {
  if (isTRUE(spec$rh1_use_phase_median_response)) {
    paste0("median_delta_phase_", outcome)
  } else {
    paste0("median_center_", outcome)}
}

h5s_rh1_response_label <- function(spec) {
  if (isTRUE(spec$rh1_use_phase_median_response)) "median_delta_phase" else "median_center"}

h5s_discover_environment_columns <- function(dat) {
  nms <- names(dat)
  grep(
    "^(ucm_|SVF$|TVF$|BVF$|gvi_|atmo_lys_|wind_|empatica_skin_temperature)",
    nms,
    value = TRUE)}

h5s_moderator_term_name <- function(spec) {
  h5s_centered_covariate_name(spec$environment_moderator_column)}

h5s_centered_covariate_name <- function(raw_col) {
  paste0("env_", raw_col, "_c")}

h5s_formula_term <- function(raw_col) {
  paste0("`", h5s_centered_covariate_name(raw_col), "`")}

h5s_center_env_predictors <- function(hd, spec) {
  cols <- unique(c(
    spec$environment_moderator_column,
    spec$sensitivity_covariate_columns,
    spec$exposure_columns))
  for (col in cols) {
    med_col <- paste0("median_", col)
    if (!med_col %in% names(hd)) next
    cname <- h5s_centered_covariate_name(col)
    hd[[cname]] <- hd[[med_col]] - mean(hd[[med_col]], na.rm = TRUE)}
  med_col <- paste0("median_", spec$environment_moderator_column)
  if (!med_col %in% names(hd)) {
    stop(
      "H5 hotspot: missing ", med_col,
      " (set spec$environment_moderator_column and include column in spec$exposure_columns).",
      call. = FALSE)}
  hd}

h5s_add_bilateral_means <- function(dat) {
  paper3_add_pair_means(dat, list(
    atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")))}

h5s_raw_exposure_columns <- function(spec) {
  derived <- if (is.null(spec$derived_exposure_columns)) character() else spec$derived_exposure_columns
  setdiff(spec$exposure_columns, derived)}

h5s_hotspot_definition <- function(spec) {
  if (is.null(spec$hotspot_definition)) "corridor_buffer" else spec$hotspot_definition}

h5s_order_epochs <- function(dat) {
  dat[order(dat$ParticipantID, dat$PhaseID, dat$Date, dat$Datetime), , drop = FALSE]}

h5s_buffer_gpkg_path <- function(phase, spec) {
  dir <- spec$buffer_gpkg_dir
  if (is.null(dir) || !nzchar(dir)) {
    stop("H5 corridor_buffer: set spec$buffer_gpkg_dir to Experiment path_8min_buffer.", call. = FALSE)}
  walk <- grepl("^Walk", as.character(phase))
  width_m <- if (walk) 11L else 35L
  file.path(dir, paste0(phase, "_buffer_", width_m, "m.gpkg"))}

h5s_load_buffer_polygons <- function(spec) {
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("H5 corridor_buffer requires R package 'sf'. Install with install.packages('sf').", call. = FALSE)}
  phases <- spec$phases
  out <- list()
  for (ph in phases) {
    path <- h5s_buffer_gpkg_path(ph, spec)
    if (!file.exists(path)) stop("H5 corridor_buffer: missing ", path, call. = FALSE)
    polygons <- sf::st_read(path, quiet = TRUE)
    if (!"seg_idx" %in% names(polygons)) {
      stop("H5 corridor_buffer: seg_idx column missing in ", path, call. = FALSE)}
    keep <- intersect(c("phase", "seg_idx", "geometry"), names(polygons))
    out[[ph]] <- sf::st_transform(polygons[, keep, drop = FALSE], 4326)}
  out}

h5s_spatial_join_buffer_seg <- function(dat, spec) {
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
      remove = FALSE)
    pts$._pt_idx <- seq_len(nrow(pts))
    joined <- sf::st_join(pts, polys[[ph]], join = sf::st_intersects, left = TRUE)
    jdf <- data.frame(
      pt_idx = joined$._pt_idx,
      seg_idx = as.integer(joined$seg_idx),
      stringsAsFactors = FALSE)
    for (point_index in unique(jdf$pt_idx)) {
      cand <- jdf$seg_idx[jdf$pt_idx == point_index]
      cand <- cand[is.finite(cand)]
      if (length(cand)) seg[sel[point_index]] <- min(cand)}
  }
  seg}

h5s_buffer_assign_shared <- function(dat) {
  dat$shared_hotspot <- is.finite(dat$route_bin) & !is.na(dat$hotspot_id)
  dat}

h5s_assign_buffer_hotspots <- function(dat, spec) {
  dat$buffer_seg_idx <- h5s_spatial_join_buffer_seg(dat, spec)
  dat$route_bin <- dat$buffer_seg_idx
  width <- if (is.null(spec$adjacent_cell_group)) 1L else as.integer(spec$adjacent_cell_group)
  if (is.finite(width) && width > 1L) {
    dat$route_bin <- ifelse(is.finite(dat$buffer_seg_idx), floor(dat$buffer_seg_idx / width), NA_real_)}
  dat$hotspot_id <- paste0(as.character(dat$PhaseID), "_seg", dat$route_bin)
  dat$hotspot_id[!is.finite(dat$route_bin)] <- NA_character_
  h5s_buffer_assign_shared(dat)}

h5s_build_epoch_table <- function(spec, raw_data_path) {
  need <- unique(c(
    "ParticipantID", "PhaseID", "Date", "Datetime",
    "ucm_GPS_lat", "ucm_GPS_lon", "ucm_GPS_alt",
    "atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5",
    "atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux",
    spec$environment_moderator_column,
    h5s_raw_exposure_columns(spec), spec$reactivity_outcomes))
  dat <- read.csv(raw_data_path, check.names = FALSE, stringsAsFactors = FALSE)
  dat <- h5s_add_bilateral_means(dat)
  miss <- setdiff(need, names(dat))
  if (length(miss)) stop("H5 hotspot missing columns: ", paste(miss, collapse = ", "), call. = FALSE)
  phases <- spec$phases
  dat <- dat[dat$ParticipantID %in% spec$participants & dat$PhaseID %in% phases, , drop = FALSE]
  dat$ParticipantID <- factor(dat$ParticipantID, levels = spec$participants)
  dat$PhaseID <- factor(dat$PhaseID, levels = phases)
  dat$Date <- as.Date(dat$Date)
  dat$mobility_mode <- ifelse(grepl("^Walk", dat$PhaseID), "walk", "bike")
  dat$green_phase <- dat$PhaseID %in% spec$green_phases
  dat}

# Point-to-point route grade (%): 100 * delta(ucm_GPS_alt) / horizontal step (m), within participant x phase.
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
    other_index <- idx
    while (other_index <= nrow(dat) && dat$ParticipantID[other_index] == pid && dat$PhaseID[other_index] == ph && dat$Date[other_index] == dt) {
      if (other_index > idx) {
        horiz <- h5s_haversine_m(
          dat$ucm_GPS_lat[other_index - 1L], dat$ucm_GPS_lon[other_index - 1L],
          dat$ucm_GPS_lat[other_index], dat$ucm_GPS_lon[other_index])
        dalt <- as.numeric(dat$ucm_GPS_alt[other_index]) - as.numeric(dat$ucm_GPS_alt[other_index - 1L])
        if (is.finite(horiz) && horiz >= min_horiz && is.finite(dalt)) {
          slope[other_index] <- 100 * dalt / horiz}
      }
      other_index <- other_index + 1L}
    idx <- other_index}
  dat[[col]] <- slope
  dat}

h5s_slope_audit <- function(dat, spec) {
  col <- spec$slope_column
  values <- dat[[col]]
  data.frame(
    metric = c(
      "slope_column", "slope_source", "slope_elevation_input",
      "n_epochs", "n_finite_slope", "pct_finite_slope",
      "median_slope_pct", "mean_abs_slope_pct", "slope_min_horizontal_m"),
    value = c(
      col,
      if (is.null(spec$slope_source)) "derived" else spec$slope_source,
      "ucm_GPS_alt",
      as.character(length(values)),
      as.character(sum(is.finite(values))),
      as.character(round(100 * mean(is.finite(values)), 2)),
      as.character(stats::median(values, na.rm = TRUE)),
      as.character(mean(abs(values), na.rm = TRUE)),
      as.character(if (is.null(spec$slope_min_horizontal_m)) 1 else spec$slope_min_horizontal_m)),
    stringsAsFactors = FALSE)}

h5s_hotspot_inclusion_rule <- function(spec) {
  rule <- if (is.null(spec$hotspot_inclusion_rule)) "corridor_all_assigned" else spec$hotspot_inclusion_rule
  if (rule != "corridor_all_assigned") {
    stop("H5 hotspot: unknown hotspot_inclusion_rule: ", rule, call. = FALSE)}
  rule}

# Corridor buffer cells (GPKG seg_idx / route_bin, 0-based) -> PhaseID_gridN labels for tables/figures.
h5s_grid_number <- function(route_bin) {
  as.integer(route_bin) + 1L}

h5s_grid_label <- function(phase_id, route_bin) {
  paste0(as.character(phase_id), "_grid", h5s_grid_number(route_bin))}

h5s_route_bin_from_hotspot_id <- function(hotspot_id) {
  if (!nzchar(hotspot_id) || !grepl("_seg[0-9]+$", hotspot_id, perl = TRUE)) return(NA_integer_)
  as.integer(sub(".*_seg", "", hotspot_id))}

h5s_hotspot_label_map_df <- function(dat) {
  need <- c("PhaseID", "hotspot_id", "route_bin")
  if (!all(need %in% names(dat))) return(data.frame())
  ok <- !is.na(dat$hotspot_id)
  if ("shared_hotspot" %in% names(dat)) ok <- ok & dat$shared_hotspot %in% TRUE
  # route_bin is the modelled cell. buffer_seg_idx stays the original corridor index and can span several values inside one grouped cell.
  sub <- unique(dat[ok, need, drop = FALSE])
  if (!nrow(sub)) return(data.frame())
  if (!is.finite(sub$route_bin)[1L]) {
    sub$route_bin <- vapply(sub$hotspot_id, h5s_route_bin_from_hotspot_id, integer(1L))}
  sub <- sub[order(sub$PhaseID, sub$route_bin), , drop = FALSE]
  sub$grid_number <- h5s_grid_number(sub$route_bin)
  sub$grid_label <- mapply(h5s_grid_label, sub$PhaseID, sub$route_bin, USE.NAMES = FALSE)
  sub}

h5s_attach_hotspot_factor <- function(hd) {
  if (!"route_bin" %in% names(hd)) {
    hd$route_bin <- vapply(hd$hotspot_id, h5s_route_bin_from_hotspot_id, integer(1L))}
  cells <- unique(hd[, c("hotspot_id", "route_bin", "PhaseID"), drop = FALSE])
  cells <- cells[order(cells$PhaseID, cells$route_bin), , drop = FALSE]
  cells$grid_label <- mapply(h5s_grid_label, cells$PhaseID, cells$route_bin, USE.NAMES = FALSE)
  hd$hotspot_f <- factor(hd$hotspot_id, levels = cells$hotspot_id, labels = cells$grid_label)
  n_cells <- nlevels(hd$hotspot_f)
  if (n_cells >= 2L) contrasts(hd$hotspot_f) <- contr.sum(n_cells)
  hd}

# Deviation of each cell from the phase mean (sum-to-zero). Includes the level contr.sum omits.
h5s_cell_effects_vs_mean <- function(fit) {
  beta <- nlme::fixef(fit)
  variance <- as.matrix(vcov(fit))
  cell_names <- levels(fit$data$hotspot_f)
  n_cells <- length(cell_names)
  coef_names <- paste0("hotspot_f", seq_len(n_cells - 1L))
  if (!all(coef_names %in% names(beta))) return(NULL)
  slope <- beta[coef_names]
  slope_variance <- variance[coef_names, coef_names, drop = FALSE]
  estimate <- c(slope, -sum(slope))
  std_error <- c(sqrt(diag(slope_variance)), sqrt(sum(slope_variance)))
  df_all <- fit$fixDF$X
  df <- if (!is.null(df_all)) min(df_all[coef_names], na.rm = TRUE) else NA_real_
  t_or_z <- estimate / std_error
  data.frame(
    grid_label = cell_names,
    estimate = estimate,
    std_error = std_error,
    t_or_z = t_or_z,
    df = df,
    p_value = 2 * stats::pt(abs(t_or_z), df = df, lower.tail = FALSE),
    stringsAsFactors = FALSE)}

h5s_detrend_slow_outcome <- function(hd_p, outcome, spec) {
  slow <- spec$slow_drift_outcomes
  if (is.null(slow) || !outcome %in% slow) return(hd_p)
  pieces <- split(seq_len(nrow(hd_p)), hd_p$ParticipantID)
  y_new <- hd_p$y
  for (ix in pieces) {
    y <- hd_p$y[ix]
    x <- as.numeric(hd_p$route_bin[ix])
    ok <- is.finite(y) & is.finite(x)
    if (sum(ok) < 3L || stats::sd(x[ok]) == 0) next
    y_new[ix][ok] <- stats::residuals(stats::lm(y[ok] ~ x[ok]))}
  hd_p$y <- y_new
  hd_p}

h5s_hotspot_coef_term_display <- function(model_term, lookup) {
  raw <- sub("^hotspot_f", "", model_term, fixed = FALSE)
  if (nrow(lookup) && "grid_label" %in% names(lookup) && raw %in% lookup$grid_label) {
    return(raw)}
  mn <- make.names(raw)
  hit <- make.names(lookup$grid_label) == mn
  if (any(hit)) return(lookup$grid_label[hit][1L])
  raw}

h5s_hotspot_id_from_model_term <- function(model_term, lookup) {
  lab <- h5s_hotspot_coef_term_display(model_term, lookup)
  hit <- lookup$grid_label == lab
  if (any(hit)) return(lookup$hotspot_id[hit][1L])
  hid <- sub("^hotspot_f", "", model_term, fixed = FALSE)
  if (hid %in% lookup$hotspot_id) return(hid)
  NA_character_}

h5s_min_participants_for_outliers <- function(spec) {
  n <- if (is.null(spec$min_participants_per_shared_bin)) 2L else as.integer(spec$min_participants_per_shared_bin)
  max(2L, n)}

h5s_spatial_proximity_radius_m <- function(spec) {
  if (is.null(spec$spatial_proximity_radius_m)) 30 else spec$spatial_proximity_radius_m}

# Corridor-buffer hotspot inclusion counts (audit only).
h5s_compare_hotspot_inclusion_audit <- function(spec, raw_data_path) {
  dat <- h5s_build_epoch_table(spec, raw_data_path)
  dat <- h5s_assign_buffer_hotspots(dat, spec)
  active <- dat[dat$shared_hotspot, , drop = FALSE]
  data.frame(
    metric = c(
      "hotspot_definition", "hotspot_inclusion_rule_active",
      "min_participants_shared_place",
      "n_epochs_in_buffer", "n_epochs_unassigned_buffer",
      "n_shared_hotspot_id", "n_shared_phase_seg_cells"),
    value = c(
      h5s_hotspot_definition(spec),
      h5s_hotspot_inclusion_rule(spec),
      NA_character_,
      as.character(sum(is.finite(dat$route_bin))),
      as.character(sum(!is.finite(dat$route_bin))),
      as.character(length(unique(active$hotspot_id))),
      as.character(nrow(unique(active[, c("PhaseID", "route_bin"), drop = FALSE])))),
    stringsAsFactors = FALSE)}

h5s_transform_outcome <- function(x, outcome, spec, apply_transform) {
  in_norm <- spec$outcome_transforms_csv$column_name
  y <- if (outcome %in% in_norm) apply_transform(x, outcome) else as.numeric(x)
  extra <- spec$h5_log1p_outcomes
  if (!is.null(extra) && outcome %in% extra) {
    label <- spec$outcome_transforms_csv$transformation_in_models[
      match(outcome, spec$outcome_transforms_csv$column_name)]
    if (is.na(label) || label == "No transformation") {
      y <- ifelse(is.finite(y) & y >= 0, log1p(y), NA_real_)}}
  y}

# (1) Campaign-wide mean per participant (all epochs in cohort phases).
h5s_participant_campaign_baselines <- function(dat, spec, apply_transform) {
  rows <- list()
  for (outcome in spec$reactivity_outcomes) {
    y <- h5s_transform_outcome(dat[[outcome]], outcome, spec, apply_transform)
    for (pid in levels(dat$ParticipantID)) {
      sel <- dat$ParticipantID == pid
      values <- y[sel]
      rows[[length(rows) + 1L]] <- data.frame(
        ParticipantID = pid,
        outcome = outcome,
        campaign_baseline_mean = mean(values, na.rm = TRUE),
        campaign_baseline_median = median(values, na.rm = TRUE),
        n_epochs = sum(is.finite(values)),
        stringsAsFactors = FALSE)}
  }
  do.call(rbind, rows)}

# (2) Epoch deviation from participant overall baseline (not phase median).
h5s_add_campaign_centered_outcomes <- function(dat, spec, apply_transform, baselines) {
  for (outcome in spec$reactivity_outcomes) {
    y <- h5s_transform_outcome(dat[[outcome]], outcome, spec, apply_transform)
    bl <- baselines$campaign_baseline_mean[match(
      paste(dat$ParticipantID, outcome, sep = "|"),
      paste(baselines$ParticipantID, baselines$outcome, sep = "|"))]
    dat[[paste0("center_", outcome)]] <- y - bl
    med <- ave(y, dat$ParticipantID, dat$PhaseID, FUN = function(values) median(values, na.rm = TRUE))
    dat[[paste0("delta_phase_", outcome)]] <- y - med}
  dat}

h5s_aggregate_hotspot_day <- function(dat, spec) {
  exp_cols <- spec$exposure_columns
  center_cols <- paste0("center_", spec$reactivity_outcomes)
  delta_cols <- paste0("delta_phase_", spec$reactivity_outcomes)
  out_cols <- unique(c(center_cols, delta_cols))
  keys <- c("ParticipantID", "PhaseID", "Date", "hotspot_id", "mobility_mode", "green_phase", "route_bin")
  sub <- dat[dat$shared_hotspot, , drop = FALSE]
  if (!nrow(sub)) stop("H5 hotspot: no shared_hotspot epochs.", call. = FALSE)

  med_fun <- function(values) median(values, na.rm = TRUE)
  base <- aggregate(
    list(n_epochs = sub$ParticipantID),
    by = sub[, keys, drop = FALSE],
    FUN = length)
  for (col in exp_cols) {
    medians <- aggregate(list(x = sub[[col]]), by = sub[, keys, drop = FALSE], FUN = med_fun)
    base[[paste0("median_", col)]] <- medians$x}
  for (col in out_cols) {
    if (!col %in% names(sub)) next
    medians <- aggregate(list(x = sub[[col]]), by = sub[, keys, drop = FALSE], FUN = med_fun)
    base[[paste0("median_", col)]] <- medians$x}
  min_ep <- spec$min_epochs_per_hotspot_day
  if (!is.null(min_ep) && is.finite(min_ep) && min_ep > 1L) {
    base <- base[base$n_epochs >= as.integer(min_ep), , drop = FALSE]
    if (!nrow(base)) {
      stop(
        "H5 hotspot: no hotspot-day rows after min_epochs_per_hotspot_day=",
        min_ep, call. = FALSE)}
  }
  base}

h5s_cell_count_audit <- function(hd, spec) {
  # Same participant + hotspot on >=2 distinct session dates (design support for repeat visits).
  pu <- unique(hd[, c("ParticipantID", "hotspot_id", "Date"), drop = FALSE])
  pu2 <- aggregate(
    list(n_distinct_dates = rep(1L, nrow(pu))),
    by = list(ParticipantID = pu$ParticipantID, hotspot_id = pu$hotspot_id),
    FUN = length)
  n_repl_person_hotspot <- sum(pu2$n_distinct_dates >= 2L)

  ph <- unique(hd[, c("hotspot_id", "Date"), drop = FALSE])
  ph2 <- aggregate(
    list(n_distinct_dates = rep(1L, nrow(ph))),
    by = list(hotspot_id = ph$hotspot_id),
    FUN = length)
  n_hotspots_multi_date <- sum(ph2$n_distinct_dates >= 2L, na.rm = TRUE)

  n_participants_two_plus_days <- sum(vapply(
    split(hd$Date, hd$ParticipantID),
    function(dates) length(unique(dates)) >= 2L,
    logical(1L)))

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
      "rh1_stratify_by_phase"),
    value = c(
      nrow(hd),
      length(unique(hd$hotspot_id)),
      length(unique(hd$ParticipantID)),
      n_repl_person_hotspot,
      n_hotspots_multi_date,
      n_participants_two_plus_days,
      "FALSE",
      rule,
      NA_character_,
      NA_character_,
      if (is.null(spec$min_participants_per_shared_bin)) NA_character_ else as.character(spec$min_participants_per_shared_bin),
      if (is.null(spec$min_epochs_per_hotspot_day)) NA_character_ else as.character(spec$min_epochs_per_hotspot_day),
      as.character(h5s_rh1_stratify_by_phase(spec))),
    stringsAsFactors = FALSE)}

h5s_extract_lme_row <- function(fit, term, model_id, outcome) {
  sm <- summary(fit)
  ct <- sm$tTable
  if (!term %in% rownames(ct)) {
    return(data.frame(
      model_id = model_id, outcome = outcome, term = term, status = "term_missing",
      estimate = NA_real_, std_error = NA_real_, df = NA_real_, p_value = NA_real_,
      stringsAsFactors = FALSE))}
  data.frame(
    model_id = model_id, outcome = outcome, term = term, status = "ok",
    estimate = ct[term, "Value"],
    std_error = ct[term, "Std.Error"],
    df = ct[term, "DF"],
    p_value = ct[term, "p-value"],
    stringsAsFactors = FALSE)}

# nlme::lme with participant intercept and corAR1(~ route_bin | ParticipantID/PhaseID); falls back to no AR(1) if that fails.
h5s_fit_hotspot_lmm <- function(fixed_rhs, hd_m) {
  fml <- stats::as.formula(paste("y ~", fixed_rhs))
  hd_m <- hd_m[order(hd_m$ParticipantID, hd_m$PhaseID, hd_m$Date, hd_m$route_bin), , drop = FALSE]
  hd_m$route_bin <- as.integer(hd_m$route_bin)
  hd_m$ar1_block <- factor(paste(hd_m$PhaseID, hd_m$Date, sep = "_"))
  dup_phase <- anyDuplicated(hd_m[, c("ParticipantID", "PhaseID", "route_bin")]) > 0L
  dup_block <- anyDuplicated(hd_m[, c("ParticipantID", "ar1_block", "route_bin")]) > 0L
  cor_form <- if (!dup_phase) ~ route_bin | ParticipantID / PhaseID else ~ route_bin | ParticipantID / ar1_block
  structure_label <- if (!dup_phase) "AR1(route_bin | ParticipantID/PhaseID)" else "AR1(route_bin | ParticipantID/PhaseID-Date)"
  fit <- if (dup_block) structure(list(), class = "try-error", condition = simpleError("duplicate route_bin within AR(1) block")) else try(
    nlme::lme(
      fml, data = hd_m, random = ~ 1 | ParticipantID, correlation = nlme::corAR1(form = cor_form),
      method = "REML", na.action = na.omit, control = nlme::lmeControl(returnObject = FALSE)),
    silent = TRUE)
  if (!inherits(fit, "try-error")) {
    return(list(converged = TRUE, engine = "nlme_AR1", fit = fit, err = NA_character_,
      residual_structure = structure_label))}
  ar1_err <- conditionMessage(attr(fit, "condition"))
  fit <- try(
    nlme::lme(fml, data = hd_m, random = ~ 1 | ParticipantID, method = "REML", na.action = na.omit,
      control = nlme::lmeControl(returnObject = FALSE)),
    silent = TRUE)
  if (inherits(fit, "try-error")) {
    return(list(converged = FALSE, engine = "nlme", fit = NULL,
      err = paste0("AR(1): ", ar1_err, "; no-AR(1): ", conditionMessage(attr(fit, "condition"))),
      residual_structure = NA_character_))}
  list(converged = TRUE, engine = "nlme_no_AR1_fallback", fit = fit,
    err = paste0("AR(1) fit failed: ", ar1_err), residual_structure = "independent (AR1 failed)")}

h5s_extract_fixed_rows <- function(fit_res, model_id, outcome, terms) {
  if (!fit_res$converged) {
    return(data.frame(
      model_id = model_id, outcome = outcome, term = terms, status = "fit_error",
      estimate = NA_real_, std_error = NA_real_, df = NA_real_, p_value = NA_real_,
      stringsAsFactors = FALSE))}
  do.call(rbind, lapply(terms, function(t) h5s_extract_lme_row(fit_res$fit, t, model_id, outcome)))}

h5s_rh1_hotspot_coef_table <- function(fit_res, outcome, phase_id = NA_character_, lookup = NULL) {
  note_p <- "p_value: cell minus the phase mean (sum-to-zero); BH within outcome x phase across cells. Cells are linearly dependent."
  empty <- data.frame(
    PhaseID = phase_id, model_id = "RH1", outcome = outcome, hotspot_id = NA_character_,
    term = NA_character_, estimate = NA_real_, std_error = NA_real_, t_or_z = NA_real_,
    p_value = NA_real_, significant_raw_p05 = NA, p_value_note = note_p, stringsAsFactors = FALSE)
  if (!fit_res$converged) return(empty)
  effects <- h5s_cell_effects_vs_mean(fit_res$fit)
  if (is.null(effects)) return(empty)
  if (is.null(lookup) || !nrow(lookup)) {
    lookup <- data.frame(hotspot_id = effects$grid_label, grid_label = effects$grid_label, stringsAsFactors = FALSE)}
  id_of <- lookup$hotspot_id[match(effects$grid_label, lookup$grid_label)]
  data.frame(
    PhaseID = phase_id,
    model_id = "RH1",
    outcome = outcome,
    hotspot_id = id_of,
    grid_label = effects$grid_label,
    term_model = paste0("hotspot_f", effects$grid_label),
    term = effects$grid_label,
    estimate = effects$estimate,
    std_error = effects$std_error,
    t_or_z = effects$t_or_z,
    p_value = effects$p_value,
    significant_raw_p05 = effects$p_value < 0.05,
    p_value_note = note_p,
    stringsAsFactors = FALSE,
    row.names = NULL)}

# By default only the main H5 tables are saved; PAPER3_WRITE_DETAILS=1 writes every detail table.
H5_WRITE_DETAILS <- identical(Sys.getenv("PAPER3_WRITE_DETAILS", unset = ""), "1")

h5s_write_rh1_hotspot_coef_dumps <- function(coef_by_outcome, out_dir, spec) {
  alpha <- spec$exploratory_fdr_alpha
  fam <- h5s_exploratory_fdr_family(spec)
  gc <- h5s_fdr_group_cols(spec, "hotspot_coef")
  note_path <- file.path(out_dir, "RH1_hotspot_coefficients_p_value_note.txt")
  if (H5_WRITE_DETAILS) writeLines(c(
    "RH1 cell effects are deviations from the phase mean (sum-to-zero), not contrasts against the first cell.",
    "term / grid_label: corridor buffer cell (route_bin + 1 within PhaseID), e.g. BikeG_grid3.",
    "hotspot_id: internal PhaseID_seg{k}; term_model: raw R fixed-effect name.",
    paste0("p_value_FDR: Benjamini-Hochberg within family '", fam, "' (see spec$exploratory_fdr_family)."),
    "p_value: raw two-sided.",
    "Compare env_ucm_UTCI_c moderator in H5_hotspot_weather_models.csv (separate FDR family for env term)."),
    note_path)
  parts <- list()
  for (outcome in names(coef_by_outcome)) {
    tab <- coef_by_outcome[[outcome]]
    if (!nrow(tab)) next
    term_m <- if ("term_model" %in% names(tab)) tab$term_model else tab$term
    tab <- tab[grepl("^hotspot_f", term_m, fixed = FALSE), , drop = FALSE]
    if (nrow(tab)) parts[[length(parts) + 1L]] <- tab}
  all_hs <- if (length(parts)) do.call(rbind, parts) else data.frame()
  if (nrow(all_hs)) {
    all_hs$p_value_FDR <- h5s_apply_bh_fdr_grouped(all_hs, group_cols = gc)
    all_hs$fdr_significant <- is.finite(all_hs$p_value_FDR) & all_hs$p_value_FDR < alpha}
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
        tab$fdr_significant <- sig_map[tab_key]}
    }
    out_path <- file.path(out_dir, paste0("RH1_hotspot_coefficients_", outcome, ".csv"))
    if (H5_WRITE_DETAILS) write.csv(tab, out_path, row.names = FALSE)
    if ("significant_raw_p05" %in% names(tab)) {
      sig <- tab[tab$significant_raw_p05 %in% TRUE, , drop = FALSE]
      if (nrow(sig)) {
        sig_raw_rows[[length(sig_raw_rows) + 1L]] <- sig[, c("outcome", "hotspot_id", "estimate", "p_value"), drop = FALSE]}
    }
  }
  if (length(sig_raw_rows) && H5_WRITE_DETAILS) {
    write.csv(
      do.call(rbind, sig_raw_rows),
      file.path(out_dir, "RH1_hotspot_coefficients_significant_raw_p05.csv"),
      row.names = FALSE)}
  if (nrow(all_hs)) {
    write.csv(
      all_hs[order(all_hs$outcome, all_hs$PhaseID, all_hs$hotspot_id), , drop = FALSE],
      file.path(out_dir, "H5_RH1_hotspot_FDR_all_tests.csv"),
      row.names = FALSE)
    locked <- all_hs[all_hs$fdr_significant %in% TRUE, , drop = FALSE]
    if (!H5_WRITE_DETAILS) {
      # FDR-significant rows are the fdr_significant == TRUE rows of H5_RH1_hotspot_FDR_all_tests.csv
    } else if (nrow(locked)) {
      write.csv(
        locked[order(locked$outcome, locked$PhaseID, locked$p_value_FDR), , drop = FALSE],
        file.path(out_dir, "H5_RH1_hotspot_FDR_significant.csv"),
        row.names = FALSE)
    } else {
      write.csv(
        data.frame(note = paste0("no FDR q < ", alpha, " in family ", fam)),
        file.path(out_dir, "H5_RH1_hotspot_FDR_significant.csv"),
        row.names = FALSE)}
    primary <- if (!is.null(spec$rh1_primary_outcomes)) {
      all_hs[all_hs$outcome %in% spec$rh1_primary_outcomes, , drop = FALSE]
    } else {
      all_hs[0, , drop = FALSE]}
    n_primary_fdr <- if (nrow(primary)) sum(primary$fdr_significant %in% TRUE, na.rm = TRUE) else 0L
    write.csv(
      data.frame(
        n_hotspot_f_tests = nrow(all_hs),
        n_raw_p_lt_alpha = sum(all_hs$p_value < alpha, na.rm = TRUE),
        n_fdr_significant = sum(all_hs$fdr_significant %in% TRUE, na.rm = TRUE),
        n_fdr_significant_primary_panel = n_primary_fdr,
        exploratory_fdr_family = fam,
        fdr_group_columns = if (is.null(gc)) "pooled" else paste(gc, collapse = ";"),
        note = "BH on hotspot_f coefficients only"),
      file.path(out_dir, "H5_RH1_hotspot_FDR_summary.csv"),
      row.names = FALSE)}
  invisible(coef_by_outcome)}

h5s_key_fixed_terms <- function(fit_res, env_c) {
  if (!fit_res$converged) return(env_c)
  rn <- rownames(summary(fit_res$fit)$tTable)
  unique(c(rn[grepl("^PhaseID", rn)], env_c))}

h5s_fit_models_and_sensitivity <- function(hd, spec, out_dir = NULL) {
  hd$ParticipantID <- factor(hd$ParticipantID, levels = spec$participants)
  hd$PhaseID <- factor(hd$PhaseID, levels = spec$phases)
  env_c <- h5s_moderator_term_name(spec)
  env_term <- h5s_formula_term(spec$environment_moderator_column)
  alpha <- spec$exploratory_fdr_alpha
  stratify <- h5s_rh1_stratify_by_phase(spec)
  resp_label <- h5s_rh1_response_label(spec)
  rh1_outcomes <- h5s_rh1_outcomes(spec)

  model_rows <- list()
  sens_summary_rows <- list()
  rh1_primary_by_outcome <- list()
  rh1_hotspot_coef_by_outcome <- list()

  for (outcome in rh1_outcomes) {
    ycol <- h5s_rh1_median_outcome_col(outcome, spec)
    if (!ycol %in% names(hd)) next
    hd$y <- hd[[ycol]]
    hd_m <- hd[is.finite(hd$y) & is.finite(hd[[env_c]]), , drop = FALSE]
    if (nrow(hd_m) < spec$min_rows_per_model) {
      model_rows[[length(model_rows) + 1L]] <- data.frame(
        PhaseID = NA_character_, model_id = "RH1", outcome = outcome, term = NA_character_,
        status = "insufficient_rows",
        estimate = NA_real_, std_error = NA_real_, df = NA_real_, p_value = NA_real_,
        stringsAsFactors = FALSE)
      next}

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
        phase_id <- NA_character_}
      if (nrow(hd_p) < spec$min_rows_per_model) next
      lag_rhs <- ""
      if (h5s_rh1_use_temporal_lag(spec)) {
        lag_col <- h5s_rh1_lag_term_name(spec)
        hd_p <- hd_p[is.finite(hd_p[[lag_col]]), , drop = FALSE]
        if (nrow(hd_p) < spec$min_rows_per_model) next
        lag_rhs <- paste0(" + `", lag_col, "`")}
      hd_p <- h5s_detrend_slow_outcome(hd_p, outcome, spec)
      hd_p$hotspot_f <- droplevels(hd_p$hotspot_f)
      if (nlevels(hd_p$hotspot_f) >= 2L) contrasts(hd_p$hotspot_f) <- contr.sum(nlevels(hd_p$hotspot_f))

      rh1_rhs <- paste0(phase_prefix, env_term, lag_rhs, " + hotspot_f")
      rh1_formula <- paste0(
        resp_label, "_", outcome, " ~ ", if (nzchar(phase_prefix)) "PhaseID + " else "",
        env_c, if (nzchar(lag_rhs)) paste0(" + ", h5s_rh1_lag_term_name(spec)) else "",
        " + hotspot_f; random = ~1|ParticipantID",
        if (stratify) paste0(" [PhaseID=", phase_id, "]") else "")
      rh1 <- h5s_fit_hotspot_lmm(rh1_rhs, hd_p)
      rh1_formula <- paste0(rh1_formula, "; correlation = ",
        if (is.null(rh1$residual_structure) || is.na(rh1$residual_structure)) "none (fit failed)" else rh1$residual_structure)
      rh1_terms <- h5s_key_fixed_terms(rh1, env_c)
      if (h5s_rh1_use_temporal_lag(spec)) rh1_terms <- unique(c(rh1_terms, h5s_rh1_lag_term_name(spec)))
      rh1_rows <- h5s_extract_fixed_rows(rh1, "RH1", outcome, rh1_terms)
      rh1_rows$PhaseID <- phase_id
      rh1_primary_by_outcome[[paste(outcome, phase_id, sep = "|")]] <- rh1_rows
      model_rows[[length(model_rows) + 1L]] <- rh1_rows
      hs_lookup <- unique(hd_p[, c("hotspot_id", "route_bin", "PhaseID"), drop = FALSE])
      hs_lookup$grid_label <- mapply(
        h5s_grid_label, hs_lookup$PhaseID, hs_lookup$route_bin, USE.NAMES = FALSE)
      coef_parts[[length(coef_parts) + 1L]] <- h5s_rh1_hotspot_coef_table(
        rh1, outcome, phase_id = phase_id, lookup = hs_lookup)

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
        rh1_lag_term = if (h5s_rh1_use_temporal_lag(spec)) h5s_rh1_lag_term_name(spec) else NA_character_,
        rh1_lag_estimate = if (h5s_rh1_use_temporal_lag(spec)) rh1_rows$estimate[rh1_rows$term == h5s_rh1_lag_term_name(spec)][1L] else NA_real_,
        rh1_lag_p_value = if (h5s_rh1_use_temporal_lag(spec)) rh1_rows$p_value[rh1_rows$term == h5s_rh1_lag_term_name(spec)][1L] else NA_real_,
        rh1_cumulative_term = NA_character_,
        rh1_cumulative_estimate = NA_real_,
        rh1_cumulative_p_value = NA_real_,
        primary_effects_held = NA,
        env_sign_held = NA,
        env_sig_pattern_held = NA,
        stringsAsFactors = FALSE)}
    if (length(coef_parts)) {
      rh1_hotspot_coef_by_outcome[[outcome]] <- do.call(rbind, coef_parts)}
  }

  tab <- do.call(rbind, model_rows)
  ok <- tab$status == "ok" & tab$term == env_c & tab$model_id == "RH1"
  tab$p_value_FDR <- NA_real_
  tab$fdr_significant <- FALSE
  if (any(ok)) {
    sub <- tab[ok, , drop = FALSE]
    gc_env <- h5s_fdr_group_cols(spec, "env_moderator")
    tab$p_value_FDR[ok] <- h5s_apply_bh_fdr_grouped(sub, group_cols = gc_env)
    tab$fdr_significant[ok] <- is.finite(tab$p_value_FDR[ok]) & tab$p_value_FDR[ok] < alpha}
  fdr_family <- h5s_env_moderator_fdr_family_label(spec)
  strat_note <- if (stratify) "RH1 stratified by PhaseID (hotspot_f within phase)" else "RH1 pooled PhaseID fixed effect"
  tab$family_note <- paste0(
    "Exploratory H5 hotspot RH1 only; ", strat_note,
    "; response=", resp_label,
    "; FDR family ", fdr_family,
    "; not merged with H1–H4 FDR")
  sens_summary <- if (length(sens_summary_rows)) do.call(rbind, sens_summary_rows) else {
    data.frame(note = "RH1 only — sensitivities skipped (run_rh1_only)", stringsAsFactors = FALSE)}
  if (!is.null(out_dir) && length(rh1_hotspot_coef_by_outcome)) {
    h5s_write_rh1_hotspot_coef_dumps(rh1_hotspot_coef_by_outcome, out_dir, spec)}
  list(
    models = tab, sensitivity_summary = sens_summary,
    sensitivity_detail = tab[tab$model_id == "RH1", , drop = FALSE],
    rh1_hotspot_coef_by_outcome = rh1_hotspot_coef_by_outcome)}

h5s_participant_hotspot_outliers <- function(hd, spec) {
  thr <- spec$outlier_z_threshold
  rows <- list()
  for (outcome in spec$reactivity_outcomes) {
    ycol <- paste0("median_center_", outcome)
    if (!ycol %in% names(hd)) next
    for (hid in unique(hd$hotspot_id)) {
      sel <- hd$hotspot_id == hid & is.finite(hd[[ycol]])
      if (sum(sel) < h5s_min_participants_for_outliers(spec)) next
      values <- hd[[ycol]][sel]
      mu <- mean(values, na.rm = TRUE)
      sdv <- sd(values, na.rm = TRUE)
      if (!is.finite(sdv) || sdv == 0) next
      sub <- hd[sel, , drop = FALSE]
      z <- (sub[[ycol]] - mu) / sdv
      for (index in seq_len(nrow(sub))) {
        if (abs(z[index]) >= thr) {
          rows[[length(rows) + 1L]] <- data.frame(
            outcome = outcome,
            hotspot_id = hid,
            ParticipantID = as.character(sub$ParticipantID[index]),
            PhaseID = as.character(sub$PhaseID[index]),
            Date = as.character(sub$Date[index]),
            median_center = sub[[ycol]][index],
            hotspot_mean = mu,
            hotspot_sd = sdv,
            z_score = z[index],
            flag = if (z[index] > 0) "high_vs_hotspot_peers" else "low_vs_hotspot_peers",
            stringsAsFactors = FALSE)}
      }
    }
  }
  if (!length(rows)) {
    return(data.frame(note = paste0("no |z| >= ", thr, " at shared hotspots"), stringsAsFactors = FALSE))}
  do.call(rbind, rows)}

h5s_positive_result_criteria <- function(audit, models, spec) {
  n_repl <- audit$value[audit$metric == "n_participant_hotspot_with_2plus_dates"]
  env_c <- h5s_moderator_term_name(spec)
  rh1_ok <- models[models$model_id == "RH1" & models$term == env_c & models$status == "ok", , drop = FALSE]
  data.frame(
    criterion = c(
      "replication_5plus_participant_hotspot_2dates",
      "RH1_env_moderator_FDR_sig",
      "RH1_env_moderator_raw_p_lt_alpha"),
    passed = c(
      is.finite(n_repl) && n_repl >= spec$min_replication_participant_hotspot_days,
      any(rh1_ok$fdr_significant %in% TRUE, na.rm = TRUE),
      any(rh1_ok$p_value < spec$exploratory_fdr_alpha, na.rm = TRUE)),
    detail = c(
      paste0("n=", n_repl),
      paste0(
        "n_FDR_sig=", sum(rh1_ok$fdr_significant %in% TRUE, na.rm = TRUE),
        "; env_FDR_family=", h5s_env_moderator_fdr_family_label(spec)),
      paste0("n_raw_sig=", sum(rh1_ok$p_value < spec$exploratory_fdr_alpha, na.rm = TRUE))),
    stringsAsFactors = FALSE)}

h5s_hotspot_stability <- function(hd, spec) {
  slope_med <- paste0("median_", spec$slope_column)
  keys <- list(hotspot_id = hd$hotspot_id, PhaseID = hd$PhaseID)
  out <- aggregate(
    list(
      median_SVF = hd$median_SVF, median_TVF = hd$median_TVF, median_BVF = hd$median_BVF,
      median_ucm_UTCI = hd$median_ucm_UTCI),
    by = keys,
    FUN = function(values) median(values, na.rm = TRUE))
  if (slope_med %in% names(hd)) {
    out[[slope_med]] <- aggregate(hd[[slope_med]], by = keys, FUN = function(values) median(values, na.rm = TRUE))$x
    out[[paste0("mean_", spec$slope_column)]] <- aggregate(
      hd[[slope_med]], by = keys, FUN = function(values) mean(values, na.rm = TRUE))$x}
  out}

h5s_dispatch_run <- function(spec, project_root, script_path, raw_data_path) {
  out_dir <- h5s_output_dir(project_root, spec)
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  apply_transform <- function(x, col) paper3_apply_csv_transform(x, col, spec$outcome_transforms_csv)

  prep <- h5s_prepare_hotspot_day(spec, raw_data_path, apply_transform)
  dat <- prep$epoch
  baselines <- prep$baselines
  hotspot_day <- prep$hotspot_day
  audit_cols <- intersect(
    c(
      "ParticipantID", "PhaseID", "Date", "Datetime", "buffer_seg_idx", "route_bin",
      "hotspot_id", "shared_hotspot", "ucm_GPS_lat", "ucm_GPS_lon"),
    names(dat))
  write.csv(
    dat[, audit_cols, drop = FALSE],
    file.path(out_dir, "H5_epoch_buffer_assignment.csv"),
    row.names = FALSE)
  label_map <- h5s_hotspot_label_map_df(dat)
  if (nrow(label_map)) {
    write.csv(
      label_map,
      file.path(out_dir, "H5_corridor_grid_label_map.csv"),
      row.names = FALSE)}
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

  re_fx <- data.frame(note = "RH1 only — RH3 random-effect extraction skipped (run_rh1_only)")

  write.csv(hotspot_day, file.path(out_dir, "H5_hotspot_day.csv"), row.names = FALSE)
  if (H5_WRITE_DETAILS) {
    write.csv(baselines, file.path(out_dir, "H5_participant_campaign_baselines.csv"), row.names = FALSE)
    write.csv(audit, file.path(out_dir, "H5_hotspot_cell_audit.csv"), row.names = FALSE)
    write.csv(stability, file.path(out_dir, "H5_hotspot_exposure_stability.csv"), row.names = FALSE)
    write.csv(slope_audit, file.path(out_dir, "H5_hotspot_slope_audit.csv"), row.names = FALSE)
    write.csv(models, file.path(out_dir, "H5_hotspot_weather_models.csv"), row.names = FALSE)
    write.csv(sensitivity_summary, file.path(out_dir, "H5_hotspot_sensitivity_summary.csv"), row.names = FALSE)
    write.csv(sensitivity_models, file.path(out_dir, "H5_hotspot_sensitivity_models.csv"), row.names = FALSE)
    write.csv(outliers, file.path(out_dir, "H5_participant_hotspot_outliers.csv"), row.names = FALSE)
    write.csv(criteria, file.path(out_dir, "H5_hotspot_positive_criteria.csv"), row.names = FALSE)
    write.csv(re_fx, file.path(out_dir, "H5_participant_hotspot_random_effects.csv"), row.names = FALSE)}

  env_c <- h5s_moderator_term_name(spec)
  if (H5_WRITE_DETAILS) {
    inclusion_audit <- try(h5s_compare_hotspot_inclusion_audit(spec, raw_data_path), silent = TRUE)
    if (!inherits(inclusion_audit, "try-error")) {
      write.csv(
        inclusion_audit,
        file.path(out_dir, "H5_hotspot_inclusion_rule_comparison.csv"),
        row.names = FALSE)}
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
      "n_epochs", "n_hotspot_day_rows", "timestamp_utc"),
    value = c(
      if (is.null(script_path)) "" else as.character(script_path),
      raw_data_path, "repeated_hotspot_backpack_env_staged_sensitivity",
      h5s_hotspot_definition(spec),
      if (is.null(spec$buffer_gpkg_dir)) "" else as.character(spec$buffer_gpkg_dir),
      "",
      "FALSE",
      paste(spec$phases, collapse = ";"),
      as.character(h5s_rh1_stratify_by_phase(spec)),
      if (is.null(spec$rh1_outcome_scope)) "all" else spec$rh1_outcome_scope,
      h5s_rh1_response_label(spec),
      as.character(h5s_rh1_use_temporal_lag(spec)),
      if (h5s_rh1_use_temporal_lag(spec)) h5s_rh1_lag_term_name(spec) else NA_character_,
      "FALSE", NA_character_,
      "FALSE", NA_character_,
      "ParticipantID_PhaseID_Date_Datetime",
      if (is.null(spec$results_subdirectory)) "" else spec$results_subdirectory,
      as.character(if (is.null(spec$min_epochs_per_hotspot_day)) NA_integer_ else spec$min_epochs_per_hotspot_day),
      if (is.null(spec$exploratory_fdr_family)) "within_outcome" else spec$exploratory_fdr_family,
      h5s_hotspot_inclusion_rule(spec),
      as.character(h5s_spatial_proximity_radius_m(spec)),
      NA_character_,
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
      format(Sys.time(), tz = "UTC", usetz = TRUE)),
    stringsAsFactors = FALSE)
  write.csv(manifest, file.path(out_dir, "H5_Run_Manifest.csv"), row.names = FALSE)

  cat("[H5 hotspot backpack env] Wrote:", out_dir, "\n")
  print(audit)
  print(criteria)
  invisible(list(
    epoch = dat, baselines = baselines, hotspot_day = hotspot_day,
    audit = audit, models = models, outliers = outliers, criteria = criteria))}

# Build the hotspot-day table through centering.
h5s_prepare_hotspot_day <- function(spec, raw_data_path, apply_transform) {
  dat <- h5s_build_epoch_table(spec, raw_data_path)
  dat <- h5s_order_epochs(dat)
  dat <- h5s_add_gps_segment_slope(dat, spec)
  dat <- h5s_assign_buffer_hotspots(dat, spec)
  baselines <- h5s_participant_campaign_baselines(dat, spec, apply_transform)
  dat <- h5s_add_campaign_centered_outcomes(dat, spec, apply_transform, baselines)
  hotspot_day <- h5s_aggregate_hotspot_day(dat, spec)
  hotspot_day <- h5s_center_env_predictors(hotspot_day, spec)
  hotspot_day <- h5s_add_rh1_temporal_lags(hotspot_day, spec)
  list(epoch = dat, baselines = baselines, hotspot_day = hotspot_day)}


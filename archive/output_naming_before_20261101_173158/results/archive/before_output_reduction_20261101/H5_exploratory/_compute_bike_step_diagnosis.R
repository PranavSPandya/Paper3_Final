#!/usr/bin/env Rscript
# BikeU vs BikeG: diagnose ~2x |delta pct_complete| (natural step size for hotspot buffer).
suppressPackageStartupMessages(library(data.table))

proj <- "d:/Pranav/docker/Paper3_Final"
MERGED <- file.path(proj, "output/merged_all_11participants_8min.csv")
OUT_DIR <- file.path(proj, "output/statistical_analysis/results/H5_exploratory")
OUT_PHASE <- file.path(OUT_DIR, "H5_bike_step_diagnosis.csv")
OUT_SESSION <- file.path(OUT_DIR, "H5_bike_step_diagnosis_by_session.csv")
OUT_GPS <- file.path(OUT_DIR, "H5_bike_step_diagnosis_gps_quality.csv")
OUT_PCT_NORM <- file.path(OUT_DIR, "H5_bike_step_diagnosis_pct_normalization.csv")
OUT_STOP_RUN <- file.path(OUT_DIR, "H5_bike_step_diagnosis_stop_runlengths.csv")

source(file.path(proj, "scripts/statistical_analysis/library/Paper3_common.R"), local = FALSE)
source(file.path(proj, "scripts/statistical_analysis/library/H5_hotspot_core.R"), local = FALSE)
source(file.path(proj, "scripts/statistical_analysis/H5_hotspot_weather.R"), local = FALSE)

haversine_m <- function(lat1, lon1, lat2, lon2) {
  h5s_haversine_m(lat1, lon1, lat2, lon2)
}

dat <- h5s_build_epoch_table(h5_hotspot_spec, MERGED)
dat <- h5s_route_distance(dat)
setDT(dat)
dat[, Datetime := as.POSIXct(Datetime, tz = "UTC")]
dat <- dat[PhaseID %in% c("BikeU", "BikeG")]

# Cohort fixed route length (H5 convention)
phase_len_cohort <- dat[, .(
  phase_route_length_m_gps_max = max(route_distance_m, na.rm = TRUE),
  n_epochs = .N,
  n_participants = uniqueN(ParticipantID)
), by = PhaseID]

# Per-session max GPS distance
session_len <- dat[, .(
  session_route_max_m = max(route_distance_m, na.rm = TRUE),
  n_epochs = .N
), by = .(ParticipantID, PhaseID, Date)]

setorder(dat, ParticipantID, PhaseID, Date, end_time_s, Datetime)
dat[, `:=`(
  delta_route_m = route_distance_m - shift(route_distance_m),
  delta_pct = pct_complete - shift(pct_complete),
  dt_s = as.numeric(difftime(Datetime, shift(Datetime), units = "secs")),
  delta_lat = ucm_GPS_lat - shift(ucm_GPS_lat),
  delta_lon = ucm_GPS_lon - shift(ucm_GPS_lon)
), by = .(ParticipantID, PhaseID, Date)]

# GPS step (independent of cumulative route)
dat[, gps_step_m := {
  lat1 <- shift(ucm_GPS_lat)
  lon1 <- shift(ucm_GPS_lon)
  lat2 <- ucm_GPS_lat
  lon2 <- ucm_GPS_lon
  mapply(function(a, b, c, d) {
    if (!is.finite(a) || !is.finite(b) || !is.finite(c) || !is.finite(d)) return(NA_real_)
    haversine_m(a, b, c, d)
  }, lat1, lon1, lat2, lon2, SIMPLIFY = TRUE, USE.NAMES = FALSE)
}, by = .(ParticipantID, PhaseID, Date)]

dat <- merge(dat, phase_len_cohort[, .(PhaseID, phase_route_length_m_gps_max)], by = "PhaseID", all.x = TRUE)
dat <- merge(dat, session_len, by = c("ParticipantID", "PhaseID", "Date"), all.x = TRUE)
dat[, `:=`(
  speed_route_mps = fifelse(is.finite(dt_s) & dt_s > 0, delta_route_m / dt_s, NA_real_),
  speed_gps_mps = fifelse(is.finite(dt_s) & dt_s > 0, gps_step_m / dt_s, NA_real_),
  speed_pct_mps = fifelse(
    is.finite(dt_s) & dt_s > 0 & is.finite(delta_pct) & phase_route_length_m_gps_max > 0,
    (delta_pct / 100) * phase_route_length_m_gps_max / dt_s, NA_real_
  ),
  speed_pct_session_mps = fifelse(
    is.finite(dt_s) & dt_s > 0 & is.finite(delta_pct) & session_route_max_m > 0,
    (delta_pct / 100) * session_route_max_m / dt_s, NA_real_
  )
)]

d <- dat[!is.na(delta_pct) & !is.na(dt_s)]
d[, `:=`(
  is_nominal_dt = dt_s >= 9 & dt_s <= 21,
  is_gap_dt = dt_s > 21,
  is_zero_route = is.finite(delta_route_m) & delta_route_m <= 0.5,
  is_zero_gps = is.finite(gps_step_m) & gps_step_m <= 0.5,
  is_zero_pct = abs(delta_pct) <= 0.05,
  is_negative_route = is.finite(delta_route_m) & delta_route_m < -0.5,
  is_negative_pct = delta_pct < -0.05,
  is_dup_coord = is.finite(delta_lat) & is.finite(delta_lon) & abs(delta_lat) < 1e-9 & abs(delta_lon) < 1e-9,
  is_jump_gps = is.finite(gps_step_m) & gps_step_m > 50,
  is_stationary = is.finite(speed_route_mps) & speed_route_mps < 0.5,
  is_fast = is.finite(speed_route_mps) & speed_route_mps > 5
)]

# Stop run-lengths: consecutive epochs with near-zero GPS step within session
stop_runs <- d[is_zero_gps == TRUE, {
  r <- rle(is_zero_gps)
  data.table(run_length_epochs = r$lengths[r$values == TRUE])
}, by = .(ParticipantID, PhaseID, Date)]

stop_summary <- rbindlist(list(
  d[, .(
    metric = "all_epochs",
    n = .N,
    median_run = NA_real_,
    p75_run = NA_real_,
    max_run = NA_real_
  ), by = PhaseID],
  stop_runs[, .(
    metric = "zero_gps_step_runs",
    n = .N,
    median_run = as.numeric(median(run_length_epochs)),
    p75_run = as.numeric(quantile(run_length_epochs, 0.75, names = FALSE)),
    max_run = as.numeric(max(run_length_epochs))
  ), by = PhaseID]
), fill = TRUE)

# Monotonicity of route_distance within session
mono <- dat[, {
  dr <- diff(route_distance_m)
  dr <- dr[is.finite(dr)]
  list(
    n_steps = length(dr),
    n_negative_steps = sum(dr < -0.5, na.rm = TRUE),
    frac_negative = if (length(dr)) mean(dr < -0.5, na.rm = TRUE) else NA_real_,
    max_backward_m = if (any(dr < 0, na.rm = TRUE)) min(dr, na.rm = TRUE) else 0
  )
}, by = .(ParticipantID, PhaseID, Date)]

gps_missing <- dat[, .(
  frac_missing_lat = mean(!is.finite(ucm_GPS_lat)),
  frac_missing_lon = mean(!is.finite(ucm_GPS_lon)),
  frac_missing_alt = mean(!is.finite(ucm_GPS_alt)),
  median_hdop = median(ucm_GPS_HDOP, na.rm = TRUE)
), by = .(ParticipantID, PhaseID, Date)]

phase_summary <- d[, {
  sp <- speed_route_mps[is.finite(speed_route_mps) & is_nominal_dt]
  list(
    n_consecutive_epochs = .N,
    n_participants = uniqueN(ParticipantID),
    n_sessions = uniqueN(paste(ParticipantID, Date)),
    median_dt_s = median(dt_s, na.rm = TRUE),
    p25_dt_s = quantile(dt_s, 0.25, na.rm = TRUE, names = FALSE),
    p75_dt_s = quantile(dt_s, 0.75, na.rm = TRUE, names = FALSE),
    share_nominal_9_21s = mean(is_nominal_dt, na.rm = TRUE),
    share_gap_dt_gt_21s = mean(is_gap_dt, na.rm = TRUE),
    share_zero_route_delta = mean(is_zero_route, na.rm = TRUE),
    share_zero_gps_step = mean(is_zero_gps, na.rm = TRUE),
    share_zero_pct_delta = mean(is_zero_pct, na.rm = TRUE),
    share_negative_route_delta = mean(is_negative_route, na.rm = TRUE),
    share_negative_pct_delta = mean(is_negative_pct, na.rm = TRUE),
    share_dup_gps_coord = mean(is_dup_coord, na.rm = TRUE),
    share_gps_jump_gt_50m = mean(is_jump_gps, na.rm = TRUE),
    speed_route_median_mps = median(sp, na.rm = TRUE),
    speed_route_p25_mps = quantile(sp, 0.25, na.rm = TRUE, names = FALSE),
    speed_route_p75_mps = quantile(sp, 0.75, na.rm = TRUE, names = FALSE),
    share_speed_lt_0p5_mps = mean(is_stationary & is_nominal_dt, na.rm = TRUE),
    share_speed_gt_5_mps = mean(is_fast & is_nominal_dt, na.rm = TRUE),
    median_abs_delta_pct_pp = median(abs(delta_pct), na.rm = TRUE),
    median_abs_delta_route_m = median(abs(delta_route_m), na.rm = TRUE),
    median_abs_delta_pct_implied_m_cohort = median(abs(delta_pct), na.rm = TRUE) / 100 *
      unique(phase_route_length_m_gps_max),
    speed_pct_cohort_median_mps = median(speed_pct_mps[is.finite(speed_pct_mps) & is_nominal_dt], na.rm = TRUE),
    speed_pct_session_median_mps = median(speed_pct_session_mps[is.finite(speed_pct_session_mps) & is_nominal_dt], na.rm = TRUE)
  )
}, by = PhaseID]

if (!"phase_route_length_m_gps_max" %in% names(phase_summary)) {
  phase_summary <- merge(phase_summary, phase_len_cohort[, .(PhaseID, phase_route_length_m_gps_max, n_epochs, n_participants)], by = "PhaseID", all.x = TRUE)
}
phase_summary[, `:=`(
  hardcoded_route_length_m = fifelse(PhaseID == "BikeG", 2233, fifelse(PhaseID == "BikeU", 2143, NA_real_)),
  data_source = MERGED,
  route_length_note = "cohort max cumulative h5s_route_distance (GPS haversine within participant x phase x date sessions)"
)]
phase_summary[, pct_vs_hardcoded_diff_m := phase_route_length_m_gps_max - hardcoded_route_length_m]

# pct_complete normalization check: correlation pct vs route/session max at epoch level
pct_norm <- dat[, {
  Ls <- max(route_distance_m, na.rm = TRUE)
  Lc <- phase_len_cohort[PhaseID == .BY$PhaseID, phase_route_length_m_gps_max]
  list(
    session_route_max_m = Ls,
    pct_at_session_max = pct_complete[which.max(route_distance_m)],
    implied_pct_from_cohort_route = 100 * route_distance_m / Lc,
    median_abs_pct_minus_cohort_implied = median(abs(pct_complete - 100 * route_distance_m / Lc), na.rm = TRUE),
    median_abs_pct_minus_session_implied = median(abs(pct_complete - 100 * route_distance_m / Ls), na.rm = TRUE),
    cor_pct_route = suppressWarnings(cor(pct_complete, route_distance_m, use = "pairwise.complete.obs"))
  )
}, by = .(ParticipantID, PhaseID, Date)]

pct_norm_phase <- pct_norm[, .(
  n_sessions = .N,
  median_cor_pct_route = median(cor_pct_route, na.rm = TRUE),
  mean_pct_at_session_max = mean(pct_at_session_max, na.rm = TRUE),
  median_abs_pct_minus_cohort_implied_pp = median(median_abs_pct_minus_cohort_implied, na.rm = TRUE),
  median_abs_pct_minus_session_implied_pp = median(median_abs_pct_minus_session_implied, na.rm = TRUE),
  median_session_route_max_m = median(session_route_max_m, na.rm = TRUE),
  interpretation = "If pct uses fixed cohort route length, median_abs_pct_minus_cohort_implied is small; if per-session length, session-implied is small."
), by = PhaseID]

session_summary <- merge(
  d[, .(
    n_epochs = .N,
    median_speed_mps = median(speed_route_mps[is_nominal_dt], na.rm = TRUE),
    share_stationary = mean(is_stationary & is_nominal_dt, na.rm = TRUE),
    share_zero_gps = mean(is_zero_gps, na.rm = TRUE),
    median_abs_delta_pct = median(abs(delta_pct), na.rm = TRUE),
    median_abs_delta_route_m = median(abs(delta_route_m), na.rm = TRUE)
  ), by = .(ParticipantID, PhaseID, Date)],
  session_len,
  by = c("ParticipantID", "PhaseID", "Date")
)

gps_phase <- merge(
  gps_missing[, .(
    median_frac_missing_lat = median(frac_missing_lat),
    median_frac_missing_lon = median(frac_missing_lon),
    median_hdop = median(median_hdop, na.rm = TRUE)
  ), by = PhaseID],
  mono[, .(
    n_sessions = .N,
    total_negative_route_steps = sum(n_negative_steps),
    sessions_with_any_backward = sum(n_negative_steps > 0),
    max_backward_m = min(max_backward_m)
  ), by = PhaseID],
  by = "PhaseID"
)

fwrite(phase_summary, OUT_PHASE)
fwrite(session_summary, OUT_SESSION)
fwrite(gps_phase, OUT_GPS)
fwrite(pct_norm_phase, OUT_PCT_NORM)
fwrite(stop_summary, OUT_STOP_RUN)

cat("Wrote:\n", OUT_PHASE, "\n", OUT_SESSION, "\n", OUT_GPS, "\n", OUT_PCT_NORM, "\n", OUT_STOP_RUN, "\n", sep = "")

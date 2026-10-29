#!/usr/bin/env Rscript
# Full merged CSV: consecutive pct_complete deltas by PhaseID (not H5 shared-hotspot subset).
suppressPackageStartupMessages(library(data.table))

proj <- "d:/Pranav/docker/Paper3_Final"
MERGED <- file.path(proj, "output/merged_all_11participants_8min.csv")
OUT <- file.path(proj, "output/statistical_analysis/results/H5_exploratory/H5_pct_complete_delta_by_phase_full_merge.csv")
BIN_M <- 20L

source(file.path(proj, "scripts/statistical_analysis/library/Paper3_common.R"), local = FALSE)
source(file.path(proj, "scripts/statistical_analysis/library/H5_hotspot_core.R"), local = FALSE)
source(file.path(proj, "scripts/statistical_analysis/H5_hotspot_weather.R"), local = FALSE)

dat <- h5s_build_epoch_table(h5_hotspot_spec, MERGED)
dat <- h5s_route_distance(dat)
setDT(dat)
dat[, route_bin := floor(route_distance_m / BIN_M)]

# Fixed-route length per phase: cohort max cumulative GPS distance (full merge, all epochs with finite route_distance_m).
phase_len <- dat[, .(
  phase_route_length_m_gps_max = max(route_distance_m, na.rm = TRUE),
  max_route_bin = max(route_bin, na.rm = TRUE),
  n_epochs = .N,
  n_participants = uniqueN(ParticipantID)
), by = PhaseID]
phase_len[, phase_route_length_m_bin := (max_route_bin + 1L) * BIN_M]
# Primary length for meter conversion: GPS max (matches pct_complete along travelled route).
phase_len[, phase_route_length_m := phase_route_length_m_gps_max]

core_phases <- c("BikeG", "BikeU", "WalkG", "WalkU", "Tram")
dat <- dat[PhaseID %in% core_phases & is.finite(pct_complete)]

summarize_deltas <- function(dt, analysis_label, dedupe_datetime = FALSE) {
  x <- copy(dt)
  if (dedupe_datetime) {
    x <- x[, .(pct_complete = median(pct_complete, na.rm = TRUE)), by = .(ParticipantID, PhaseID, Date, Datetime)]
  }
  setorder(x, ParticipantID, PhaseID, Date, Datetime)
  x[, delta_pct := pct_complete - shift(pct_complete), by = .(ParticipantID, PhaseID, Date)]
  x[, dt_s := as.numeric(difftime(Datetime, shift(Datetime), units = "secs")), by = .(ParticipantID, PhaseID, Date)]
  d <- x[!is.na(delta_pct)]
  d[, is_nominal_epoch_step := is.finite(dt_s) & dt_s >= 9 & dt_s <= 21]

  cohort <- x[, .(
    n_epochs = .N,
    n_participants = uniqueN(ParticipantID),
    pct_min = min(pct_complete, na.rm = TRUE),
    pct_max = max(pct_complete, na.rm = TRUE),
    pct_median = median(pct_complete, na.rm = TRUE)
  ), by = PhaseID]

  delta_stats <- d[, {
    ad <- abs(delta_pct)
    L <- phase_len[PhaseID == .BY$PhaseID, phase_route_length_m]
    list(
      n_deltas = .N,
      n_participants_with_delta = uniqueN(ParticipantID),
      n_nominal_10s_steps = sum(is_nominal_epoch_step, na.rm = TRUE),
      frac_non_nominal_dt = mean(!is_nominal_epoch_step, na.rm = TRUE),
      delta_signed_mean_pp = mean(delta_pct, na.rm = TRUE),
      delta_signed_median_pp = median(delta_pct, na.rm = TRUE),
      delta_signed_p25_pp = quantile(delta_pct, 0.25, na.rm = TRUE, names = FALSE),
      delta_signed_p75_pp = quantile(delta_pct, 0.75, na.rm = TRUE, names = FALSE),
      delta_signed_iqr_pp = IQR(delta_pct, na.rm = TRUE),
      delta_abs_mean_pp = mean(ad, na.rm = TRUE),
      delta_abs_median_pp = median(ad, na.rm = TRUE),
      delta_abs_p25_pp = quantile(ad, 0.25, na.rm = TRUE, names = FALSE),
      delta_abs_p75_pp = quantile(ad, 0.75, na.rm = TRUE, names = FALSE),
      delta_abs_iqr_pp = IQR(ad, na.rm = TRUE),
      delta_signed_median_m = (median(delta_pct, na.rm = TRUE) / 100) * L,
      delta_abs_median_m = (median(ad, na.rm = TRUE) / 100) * L,
      delta_abs_mean_m = (mean(ad, na.rm = TRUE) / 100) * L,
      delta_abs_p75_m = (quantile(ad, 0.75, na.rm = TRUE, names = FALSE) / 100) * L,
      expected_uniform_20m_bin_step_pp = 100 * BIN_M / L
    )
  }, by = PhaseID]

  merge(cohort, delta_stats, by = "PhaseID", all = TRUE)[, analysis := analysis_label]
}

r1 <- summarize_deltas(dat, "consecutive_epochs_same_session", dedupe_datetime = FALSE)
r2 <- summarize_deltas(dat, "unique_datetime_median_pct", dedupe_datetime = TRUE)

out <- rbindlist(list(r1, r2), fill = TRUE)
out <- merge(out, phase_len[, .(PhaseID, phase_route_length_m, phase_route_length_m_gps_max, phase_route_length_m_bin, max_route_bin)],
  by = "PhaseID", all.x = TRUE)
out[, `:=`(
  data_source = MERGED,
  epoch_unit_note = "Merged file name says 8min; observed Datetime spacing is ~10 s between consecutive rows within ParticipantID x PhaseID x Date.",
  meter_conversion_assumption = "delta_m = (delta_pct_pp / 100) * phase_route_length_m; phase_route_length_m = cohort max cumulative GPS route_distance_m on fixed phase route (full merge).",
  h5_current_route_distance_bin_m = 20L,
  h5_current_spatial_proximity_radius_m = 30L
)]

setcolorder(out, c(
  "analysis", "PhaseID", "n_epochs", "n_participants", "pct_min", "pct_max", "pct_median",
  "n_deltas", "n_participants_with_delta", "n_nominal_10s_steps", "frac_non_nominal_dt",
  "delta_signed_mean_pp", "delta_signed_median_pp", "delta_signed_p25_pp", "delta_signed_p75_pp", "delta_signed_iqr_pp",
  "delta_abs_mean_pp", "delta_abs_median_pp", "delta_abs_p25_pp", "delta_abs_p75_pp", "delta_abs_iqr_pp",
  "delta_signed_median_m", "delta_abs_median_m", "delta_abs_mean_m", "delta_abs_p75_m",
  "phase_route_length_m", "phase_route_length_m_gps_max", "phase_route_length_m_bin", "max_route_bin",
  "expected_uniform_20m_bin_step_pp",
  "h5_current_route_distance_bin_m", "h5_current_spatial_proximity_radius_m",
  "data_source", "epoch_unit_note", "meter_conversion_assumption"
))

fwrite(out, OUT)
cat("Wrote:", OUT, "\n")
print(out[, .(analysis, PhaseID, n_epochs, pct_min, pct_max, delta_abs_median_pp, delta_abs_median_m, phase_route_length_m)])

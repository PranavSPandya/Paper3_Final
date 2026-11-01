#!/usr/bin/env Rscript
# One-off: % completion and consecutive-look deltas for H5 hotspot-day rows.
suppressPackageStartupMessages({
  library(data.table)
})

BIN_M <- 20L
HD_PATH <- "d:/Pranav/docker/Paper3_Final/output/statistical_analysis/results/H5_exploratory/H5_hotspot_day.csv"
MERGED_PATH <- "d:/Pranav/docker/Paper3_Final/output/merged_all_11participants_8min.csv"

hd <- fread(HD_PATH)
hd[, Date := as.IDate(Date)]

# --- Attach median pct_complete from merged 8min (same keys as H5 aggregate + route_bin) ---
# Replicate H5 route_bin on merged epochs (requires end_time_s + GPS; use existing pipeline via sourcing).
proj <- "d:/Pranav/docker/Paper3_Final"
source(file.path(proj, "scripts/statistical_analysis/library/Paper3_common.R"), local = FALSE)
source(file.path(proj, "scripts/statistical_analysis/library/H5_hotspot_core.R"), local = FALSE)

PROJECT_ROOT <- proj
H5_SCRIPT_PATH <- file.path(proj, "scripts/statistical_analysis/H5_hotspot_weather.R")
source(H5_SCRIPT_PATH, local = FALSE)
# h5_hotspot_spec defined by sourced meeting script

dat <- h5s_build_epoch_table(h5_hotspot_spec, MERGED_PATH)
dat <- h5s_route_distance(dat)
dat <- h5s_add_gps_segment_slope(dat, h5_hotspot_spec)
dat <- h5s_assign_hotspots(dat, h5_hotspot_spec)
dat <- dat[dat$shared_hotspot, ]

pct_agg <- aggregate(
  list(median_pct_complete = dat$pct_complete),
  by = dat[, c("ParticipantID", "PhaseID", "Date", "route_bin"), drop = FALSE],
  FUN = function(v) stats::median(v, na.rm = TRUE)
)
setDT(pct_agg)
pct_agg[, Date := as.IDate(Date)]

hd <- merge(hd, pct_agg, by = c("ParticipantID", "PhaseID", "Date", "route_bin"), all.x = TRUE)

# Phase fixed-route length proxy: max observed route_distance bin edge across cohort (shared epochs).
phase_max_bin <- hd[, .(max_route_bin = max(route_bin, na.rm = TRUE)), by = PhaseID]
phase_max_bin[, phase_route_length_m := (max_route_bin + 1L) * BIN_M]
hd <- merge(hd, phase_max_bin, by = "PhaseID", all.x = TRUE)

# Route-bin % completion (H5-aligned): bin midpoint / phase route length.
hd[, pct_from_route_bin := 100 * ((route_bin + 0.5) * BIN_M) / phase_route_length_m]

# Primary % completion for analysis: merged pct_complete when present, else route-bin proxy.
hd[, pct_completion := fifelse(is.finite(median_pct_complete), median_pct_complete, pct_from_route_bin)]

# Order matches H5 RH1 lag: ParticipantID, PhaseID, Date, route_bin, hotspot_id
ord <- order(hd$ParticipantID, hd$PhaseID, hd$Date, hd$route_bin, hd$hotspot_id)
hd <- hd[ord]

# Consecutive deltas within ParticipantID × PhaseID (across dates).
hd[, delta_pct := pct_completion - shift(pct_completion), by = .(ParticipantID, PhaseID)]
hd[, delta_route_bin_pct := pct_from_route_bin - shift(pct_from_route_bin), by = .(ParticipantID, PhaseID)]

# Drop first row per participant-phase (no prior look).
deltas <- hd[!is.na(delta_pct)]

phase_summary <- hd[, {
  pmin <- min(pct_completion, na.rm = TRUE)
  pmax <- max(pct_completion, na.rm = TRUE)
  .(
  n_rows = .N,
  n_participants = uniqueN(ParticipantID),
  pct_min = pmin,
  pct_max = pmax,
  pct_range = pmax - pmin,
  n_with_merged_pct = sum(is.finite(median_pct_complete)),
  phase_route_length_m = phase_route_length_m[1L],
  max_route_bin = max_route_bin[1L]
  )
}, by = PhaseID]

delta_summary <- deltas[, .(
  n_deltas = .N,
  n_participants = uniqueN(ParticipantID),
  mean_delta = mean(delta_pct, na.rm = TRUE),
  median_delta = median(delta_pct, na.rm = TRUE),
  sd_delta = stats::sd(delta_pct, na.rm = TRUE),
  mean_abs_delta = mean(abs(delta_pct), na.rm = TRUE),
  median_abs_delta = median(abs(delta_pct), na.rm = TRUE),
  min_delta = min(delta_pct, na.rm = TRUE),
  max_delta = max(delta_pct, na.rm = TRUE),
  mean_delta_route_bin = mean(delta_route_bin_pct, na.rm = TRUE),
  median_delta_route_bin = median(delta_route_bin_pct, na.rm = TRUE)
), by = PhaseID]

out <- merge(phase_summary, delta_summary, by = "PhaseID", all.x = TRUE, sort = TRUE)

cat("\n=== Formula ===\n")
cat("pct_completion = median(pct_complete) over epochs in ParticipantID x PhaseID x Date x route_bin (shared_hotspot epochs);\n")
cat("  fallback: 100 * (route_bin + 0.5) * 20 / ((max route_bin in phase)+1)*20).\n")
cat("Look order: ParticipantID, PhaseID, Date, route_bin, hotspot_id (H5 RH1 lag order).\n")
cat("Delta: pct_completion[i] - pct_completion[i-1] within each ParticipantID x PhaseID.\n\n")

print(as.data.frame(out), row.names = FALSE, digits = 4)

# Per-participant-phase range (for cross-participant summary of ranges)
pp_range <- hd[, .(
  pct_min = min(pct_completion, na.rm = TRUE),
  pct_max = max(pct_completion, na.rm = TRUE),
  n_looks = .N
), by = .(ParticipantID, PhaseID)]
pp_range[, range_pp := pct_max - pct_min]

cat("\n=== Mean participant-phase range by PhaseID ===\n")
print(as.data.frame(pp_range[, .(
  mean_pp_range = mean(range_pp),
  median_pp_range = median(range_pp),
  min_pp_range = min(range_pp),
  max_pp_range = max(range_pp)
), by = PhaseID]), row.names = FALSE, digits = 4)

# Within same Date only (consecutive bins on one pass).
hd[, delta_pct_same_date := pct_completion - shift(pct_completion), by = .(ParticipantID, PhaseID, Date)]
deltas_day <- hd[!is.na(delta_pct_same_date)]

delta_day_summary <- deltas_day[, .(
  n_deltas_same_date = .N,
  mean_delta = mean(delta_pct_same_date, na.rm = TRUE),
  median_delta = median(delta_pct_same_date, na.rm = TRUE),
  sd_delta = stats::sd(delta_pct_same_date, na.rm = TRUE),
  mean_abs_delta = mean(abs(delta_pct_same_date), na.rm = TRUE),
  median_abs_delta = median(abs(delta_pct_same_date), na.rm = TRUE),
  min_delta = min(delta_pct_same_date, na.rm = TRUE),
  max_delta = max(delta_pct_same_date, na.rm = TRUE)
), by = PhaseID]

out2 <- merge(out, delta_day_summary, by = "PhaseID", all.x = TRUE, sort = TRUE)
out2[, expected_uniform_bin_step_pct := 100 * BIN_M / phase_route_length_m]

out_path <- file.path(proj, "output/statistical_analysis/results/H5_exploratory/H5_pct_completion_look_deltas.csv")
fwrite(out2, out_path)
fwrite(hd[, .(ParticipantID, PhaseID, Date, route_bin, pct_completion, median_pct_complete, pct_from_route_bin)],
       file.path(proj, "output/statistical_analysis/results/H5_exploratory/_tmp_hd_pct_rows.csv"))

cat("\n=== Same-date consecutive looks (Participant x Phase x Date) ===\n")
print(as.data.frame(delta_day_summary[order(PhaseID)]), row.names = FALSE, digits = 4)

cat("\n=== Overall ===\n")
cat("Total hotspot-day rows:", nrow(hd), "\n")
cat("Total deltas (participant-phase, all dates):", nrow(deltas), "\n")
cat("Total deltas (same date only):", nrow(deltas_day), "\n")
cat("Rows missing merged pct_complete:", sum(!is.finite(hd$median_pct_complete)), "\n")
cat("Wrote:", out_path, "\n")

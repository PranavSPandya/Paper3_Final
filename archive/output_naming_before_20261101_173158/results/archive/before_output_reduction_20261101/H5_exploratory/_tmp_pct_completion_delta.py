"""Compute H5 hotspot-day % completion and consecutive-look deltas."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

import pandas as pd

ROOT = Path(r"d:/Pranav/docker/Paper3_Final")
HD = ROOT / "output/statistical_analysis/results/H5_exploratory/H5_hotspot_day.csv"
OUT = ROOT / "output/statistical_analysis/results/H5_exploratory/H5_pct_completion_look_deltas.csv"

# Run R chunk for median pct_complete join (reuse H5 epoch pipeline)
R_CODE = r"""
suppressPackageStartupMessages(library(data.table))
proj <- "d:/Pranav/docker/Paper3_Final"
source(file.path(proj, "scripts/statistical_analysis/library/Paper3_common.R"))
source(file.path(proj, "scripts/statistical_analysis/H5_hotspot_weather.R"), local = FALSE)
MERGED <- file.path(proj, "output/merged_all_11participants_8min.csv")
HD_PATH <- file.path(proj, "output/statistical_analysis/results/H5_exploratory/H5_hotspot_day.csv")
BIN_M <- 20L
hd <- fread(HD_PATH)
hd[, Date := as.IDate(Date)]
dat <- h5s_build_epoch_table(h5_hotspot_spec, MERGED)
dat <- h5s_route_distance(dat)
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
phase_max <- hd[, .(max_route_bin = max(route_bin)), by = PhaseID]
phase_max[, phase_route_length_m := (max_route_bin + 1L) * BIN_M]
hd <- merge(hd, phase_max, by = "PhaseID", all.x = TRUE)
hd[, pct_from_route_bin := 100 * ((route_bin + 0.5) * BIN_M) / phase_route_length_m]
hd[, pct_completion := fifelse(is.finite(median_pct_complete), median_pct_complete, pct_from_route_bin)]
fwrite(hd, file.path(proj, "output/statistical_analysis/results/H5_exploratory/_tmp_hd_with_pct.csv"))
"""

subprocess.run(["Rscript", "-e", R_CODE], check=True, cwd=ROOT)

hd = pd.read_csv(ROOT / "output/statistical_analysis/results/H5_exploratory/_tmp_hd_with_pct.csv")
hd["Date"] = pd.to_datetime(hd["Date"]).dt.date

ORDER = ["ParticipantID", "PhaseID", "Date", "route_bin", "hotspot_id"]
hd = hd.sort_values(ORDER)

BIN_M = 20


def add_deltas(g: pd.DataFrame, within_date: bool) -> pd.DataFrame:
    g = g.sort_values(["Date", "route_bin", "hotspot_id"])
    if within_date:
        g["delta_pct"] = g.groupby("Date", group_keys=False)["pct_completion"].diff()
    else:
        g["delta_pct"] = g["pct_completion"].diff()
    return g


rows = []
for phase in sorted(hd["PhaseID"].unique()):
    sub = hd[hd["PhaseID"] == phase]
    for within_date, label in ((False, "participant_phase"), (True, "participant_phase_same_date")):
        parts = []
        for (_, g) in sub.groupby("ParticipantID", sort=False):
            parts.append(add_deltas(g.copy(), within_date=within_date))
        d = pd.concat(parts, ignore_index=True)
        deltas = d["delta_pct"].dropna()
        pp = (
            d.groupby("ParticipantID")["pct_completion"]
            .agg(pct_min="min", pct_max="max", n_looks="count")
            .assign(range=lambda x: x["pct_max"] - x["pct_min"])
        )
        rows.append(
            {
                "PhaseID": phase,
                "delta_scope": label,
                "n_rows": len(d),
                "n_participants": d["ParticipantID"].nunique(),
                "pct_min_all_rows": sub["pct_completion"].min(),
                "pct_max_all_rows": sub["pct_completion"].max(),
                "pct_range_all_rows": sub["pct_completion"].max() - sub["pct_completion"].min(),
                "mean_participant_range": pp["range"].mean(),
                "median_participant_range": pp["range"].median(),
                "n_deltas": len(deltas),
                "mean_delta": deltas.mean(),
                "median_delta": deltas.median(),
                "sd_delta": deltas.std(ddof=1) if len(deltas) > 1 else float("nan"),
                "mean_abs_delta": deltas.abs().mean(),
                "median_abs_delta": deltas.abs().median(),
                "min_delta": deltas.min() if len(deltas) else float("nan"),
                "max_delta": deltas.max() if len(deltas) else float("nan"),
                "phase_route_length_m": sub["phase_route_length_m"].iloc[0],
                "max_route_bin": sub["max_route_bin"].iloc[0],
                "expected_delta_if_uniform_bins_pct": 100 * BIN_M / sub["phase_route_length_m"].iloc[0],
            }
        )

summary = pd.DataFrame(rows)
summary.to_csv(OUT, index=False)
pd.set_option("display.max_columns", None)
pd.set_option("display.width", 200)
print(summary.to_string(index=False, float_format=lambda x: f"{x:.4f}"))

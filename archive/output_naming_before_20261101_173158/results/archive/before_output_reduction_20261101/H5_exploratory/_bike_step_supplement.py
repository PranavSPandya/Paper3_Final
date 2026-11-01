import pandas as pd
import numpy as np
from pathlib import Path

proj = Path(r"d:/Pranav/docker/Paper3_Final")
session = pd.read_csv(proj / "output/statistical_analysis/results/H5_exploratory/H5_bike_step_diagnosis_by_session.csv")
phase = pd.read_csv(proj / "output/statistical_analysis/results/H5_exploratory/H5_bike_step_diagnosis.csv")

# Re-read merged for slope (light columns only)
cols = ["ParticipantID", "PhaseID", "Date", "Datetime", "end_time_s", "pct_complete", "ucm_GPS_lat", "ucm_GPS_lon"]
dat = pd.read_csv(proj / "output/merged_all_11participants_8min.csv", usecols=cols)
dat = dat[dat["PhaseID"].isin(["BikeU", "BikeG"])].copy()
dat["Datetime"] = pd.to_datetime(dat["Datetime"])
dat = dat.sort_values(["ParticipantID", "PhaseID", "Date", "end_time_s", "Datetime"])

def haversine(lat1, lon1, lat2, lon2):
    r = 6371000.0
    p = np.pi / 180
    a = np.sin((lat2 - lat1) * p / 2) ** 2 + np.cos(lat1 * p) * np.cos(lat2 * p) * np.sin((lon2 - lon1) * p / 2) ** 2
    return 2 * r * np.arcsin(np.sqrt(a))

# cumulative route distance per session
route = []
for _key, g in dat.groupby(["ParticipantID", "PhaseID", "Date"], sort=False):
    lat = g["ucm_GPS_lat"].to_numpy(float)
    lon = g["ucm_GPS_lon"].to_numpy(float)
    cum = np.zeros(len(g))
    for i in range(1, len(g)):
        if np.all(np.isfinite([lat[i - 1], lon[i - 1], lat[i], lon[i]])):
            cum[i] = cum[i - 1] + haversine(lat[i - 1], lon[i - 1], lat[i], lon[i])
    route.append(pd.Series(cum, index=g.index))
dat["route_distance_m"] = pd.concat(route).sort_index()

dat["dt_s"] = dat.groupby(["ParticipantID", "PhaseID", "Date"])["Datetime"].diff().dt.total_seconds()
dat["delta_route"] = dat.groupby(["ParticipantID", "PhaseID", "Date"])["route_distance_m"].diff()
dat["delta_pct"] = dat.groupby(["ParticipantID", "PhaseID", "Date"])["pct_complete"].diff()
d = dat.dropna(subset=["delta_pct", "dt_s"])
d = d[(d["dt_s"] >= 9) & (d["dt_s"] <= 21)]
d["speed"] = d["delta_route"] / d["dt_s"]
moving = d[(d["speed"] > 0.5) & (d["delta_pct"].abs() > 0.05)]

rows = []
for ph, g in d.groupby("PhaseID"):
    gm = moving[moving["PhaseID"] == ph]
    rows.append(
        {
            "PhaseID": ph,
            "median_abs_delta_pct_all_nominal": g["delta_pct"].abs().median(),
            "median_abs_delta_pct_moving": gm["delta_pct"].abs().median(),
            "median_abs_delta_route_all": g["delta_route"].abs().median(),
            "median_abs_delta_route_moving": gm["delta_route"].abs().median(),
            "share_stationary_nominal": (g["speed"] <= 0.5).mean(),
        }
    )
sup = pd.DataFrame(rows)
out = proj / "output/statistical_analysis/results/H5_exploratory/H5_bike_step_diagnosis_moving_only.csv"
sup.to_csv(out, index=False)

# session slopes
slopes = []
for key, g in dat.groupby(["ParticipantID", "PhaseID", "Date"]):
    ok = g["pct_complete"].notna() & g["route_distance_m"].notna()
    if ok.sum() < 10:
        continue
    sub = g.loc[ok]
    slope = np.polyfit(sub["route_distance_m"], sub["pct_complete"], 1)[0]
    slopes.append({"ParticipantID": key[0], "PhaseID": key[1], "Date": key[2], "slope_pct_per_m": slope, "implied_L_m": 100 / slope if slope > 0 else np.nan})

sl = pd.DataFrame(slopes)
sl_sum = sl.groupby("PhaseID").agg(
    median_slope_pct_per_m=("slope_pct_per_m", "median"),
    median_implied_L_m=("implied_L_m", "median"),
    n_sessions=("slope_pct_per_m", "count"),
)
sl_out = proj / "output/statistical_analysis/results/H5_exploratory/H5_bike_step_diagnosis_pct_gps_slope.csv"
sl_sum.reset_index().to_csv(sl_out, index=False)
print(sup)
print(sl_sum)
print("Wrote", out, sl_out)

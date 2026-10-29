"""Assign merged 8-min epoch rows to corridor buffer seg_idx (point-in-polygon)."""
from __future__ import annotations

import sys
from pathlib import Path

import geopandas as gpd
import pandas as pd

PHASES = ("BikeU", "WalkU", "BikeG", "WalkG")
WALK = {"WalkU", "WalkG"}


def gpkg_for_phase(buffer_dir: Path, phase: str) -> Path:
    width = 11 if phase in WALK else 35
    return buffer_dir / f"{phase}_buffer_{width}m.gpkg"


def main() -> None:
    if len(sys.argv) != 4:
        print("Usage: H5_buffer_spatial_join.py <merged_csv> <buffer_dir> <out_csv>", file=sys.stderr)
        sys.exit(2)
    merged_path = Path(sys.argv[1])
    buffer_dir = Path(sys.argv[2])
    out_path = Path(sys.argv[3])

    usecols = ["ParticipantID", "PhaseID", "Date", "Datetime", "ucm_GPS_lat", "ucm_GPS_lon"]
    df = pd.read_csv(merged_path, usecols=usecols, parse_dates=["Datetime"])
    df["buffer_seg_idx"] = pd.NA

    for phase in PHASES:
        gpkg = gpkg_for_phase(buffer_dir, phase)
        if not gpkg.exists():
            raise FileNotFoundError(gpkg)
        polys = gpd.read_file(gpkg)
        if "seg_idx" not in polys.columns:
            raise ValueError(f"seg_idx missing in {gpkg}")
        polys = polys.to_crs(4326)
        sub = df[df["PhaseID"] == phase].copy()
        if sub.empty:
            continue
        ok = sub["ucm_GPS_lat"].notna() & sub["ucm_GPS_lon"].notna()
        if not ok.any():
            continue
        pts = gpd.GeoDataFrame(
            sub.loc[ok],
            geometry=gpd.points_from_xy(sub.loc[ok, "ucm_GPS_lon"], sub.loc[ok, "ucm_GPS_lat"]),
            crs="EPSG:4326",
        )
        joined = gpd.sjoin(pts, polys[["seg_idx", "geometry"]], predicate="intersects", how="left")
        seg_min = joined.groupby(level=0)["seg_idx"].min()
        df.loc[seg_min.index, "buffer_seg_idx"] = seg_min.astype("Int64")

    out_path.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(out_path, index=False)
    print(f"Wrote {out_path} ({len(df)} rows)")


if __name__ == "__main__":
    main()

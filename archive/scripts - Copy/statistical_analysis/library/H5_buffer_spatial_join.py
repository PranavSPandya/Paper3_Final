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
    output_path = Path(sys.argv[3])

    columns = ["ParticipantID", "PhaseID", "Date", "Datetime", "ucm_GPS_lat", "ucm_GPS_lon"]
    epochs = pd.read_csv(merged_path, usecols=columns, parse_dates=["Datetime"])
    epochs["buffer_seg_idx"] = pd.NA

    for phase in PHASES:
        buffer_path = gpkg_for_phase(buffer_dir, phase)
        if not buffer_path.exists():
            raise FileNotFoundError(buffer_path)
        buffer_polygons = gpd.read_file(buffer_path)
        if "seg_idx" not in buffer_polygons.columns:
            raise ValueError(f"seg_idx missing in {buffer_path}")
        buffer_polygons = buffer_polygons.to_crs(4326)
        phase_epochs = epochs[epochs["PhaseID"] == phase].copy()
        if phase_epochs.empty:
            continue
        valid_coordinates = phase_epochs["ucm_GPS_lat"].notna() & phase_epochs["ucm_GPS_lon"].notna()
        if not valid_coordinates.any():
            continue
        epoch_points = gpd.GeoDataFrame(
            phase_epochs.loc[valid_coordinates],
            geometry=gpd.points_from_xy(phase_epochs.loc[valid_coordinates, "ucm_GPS_lon"], phase_epochs.loc[valid_coordinates, "ucm_GPS_lat"]),
            crs="EPSG:4326",
        )
        joined = gpd.sjoin(epoch_points, buffer_polygons[["seg_idx", "geometry"]], predicate="intersects", how="left")
        segment_indices = joined.groupby(level=0)["seg_idx"].min()
        epochs.loc[segment_indices.index, "buffer_seg_idx"] = segment_indices.astype("Int64")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    epochs.to_csv(output_path, index=False)
    print(f"Wrote {output_path} ({len(epochs)} rows)")


if __name__ == "__main__":
    main()

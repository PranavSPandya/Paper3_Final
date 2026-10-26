"""
match_mapillary_gvi.py
======================
Spatially match computed Mapillary 360 GVI metrics to participant trajectories.

Reads:
  - GVI_Xception_Mapillary_360_metrics.csv (static route point GVI calculations)
  - merged_all_11participants_8min.csv (1-second participant physiological and environmental data)
  - merged_all_11participants.csv (full participant dataset)

Outputs:
  - merged_all_11participants_8min_GVI.csv
  - merged_all_11participants_GVI.csv

Spatial matching rule:
  For each 1-second participant GPS location (ucm_GPS_lat, ucm_GPS_lon) in a given phase,
  find the nearest Mapillary route point within the phase.
  Record the nearest point GVI, tree%, grass%, plant%, and distance.
  Also append phase-level summary means for GVI, tree, grass, and plant.
"""

from pathlib import Path
import numpy as np
import pandas as pd

# ── CONFIG ─────────────────────────────────────────────────────────────────
PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_DIR = PROJECT_ROOT / "output"
MERGED_8MIN_PATH = OUTPUT_DIR / "merged_all_11participants_8min.csv"
MERGED_FULL_PATH = OUTPUT_DIR / "merged_all_11participants.csv"
MAPILLARY_PATH = OUTPUT_DIR / "GVI_output" / "GVI_Xception_Mapillary_360_metrics.csv"
OUT_8MIN_PATH = OUTPUT_DIR / "GVI_output" / "merged_all_11participants_8min_GVI.csv"
OUT_FULL_PATH = OUTPUT_DIR / "GVI_output" / "merged_all_11participants_GVI.csv"
MAX_MATCH_RADIUS_M = 50.0

# ── LOAD ───────────────────────────────────────────────────────────────────
def load_mapillary_metrics(path: Path) -> pd.DataFrame:
    print(f"Loading Mapillary GVI metrics from: {path}")
    df_map = pd.read_csv(path)
    required = ['PhaseID', 'PointID', 'point_lat', 'point_lon', 'GVI_%', 'Tree_%', 'Grass_%', 'Plant_%']
    if df_map[required].isna().any().any():
        raise ValueError('GVI metrics contain missing matching fields')
    if df_map.duplicated(['PhaseID', 'PointID']).any():
        raise ValueError('Select one image per route point before matching GVI')
    return df_map

# ── DEFINE ─────────────────────────────────────────────────────────────────
def haversine_np(lon1, lat1, lon2, lat2):
    """Vectorized Haversine distance in meters."""
    lon1, lat1, lon2, lat2 = map(np.radians, [lon1, lat1, lon2, lat2])
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = np.sin(dlat / 2.0)**2 + np.cos(lat1) * np.cos(lat2) * np.sin(dlon / 2.0)**2
    c = 2 * np.arcsin(np.sqrt(a))
    km = 6367 * c
    return km * 1000.0


def compute_phase_summaries(df_map: pd.DataFrame) -> pd.DataFrame:
    """Compute phase-level aggregate GVI metrics."""
    return df_map.groupby('PhaseID').agg(
        gvi_phase_mean=('GVI_%', 'mean'),
        tree_phase_mean=('Tree_%', 'mean'),
        grass_phase_mean=('Grass_%', 'mean'),
        plant_phase_mean=('Plant_%', 'mean')
    ).reset_index()


def match_gvi_to_merged(merged_df: pd.DataFrame, map_df: pd.DataFrame, piv_map: pd.DataFrame, max_radius_m: float = 50.0) -> pd.DataFrame:
    """Matches 1s GPS observations to nearest GVI points within phase."""
    df = merged_df.copy()

    # Remove any existing GVI columns before matching to ensure idempotency
    existing_gvi_cols = [c for c in [
        'gvi_50m', 'gvi_tree_50m', 'gvi_grass_50m', 'gvi_plant_50m',
        'gvi_point_gvi', 'gvi_point_tree', 'gvi_point_grass', 'gvi_point_plant',
        'gvi_match_dist_m', 'gvi_matched_point_id',
        'gvi_phase_min', 'gvi_phase_max', 'gvi_phase_std',
        'gvi_phase_mean', 'tree_phase_mean', 'grass_phase_mean', 'plant_phase_mean',
    ] if c in df.columns]
    if existing_gvi_cols:
        df = df.drop(columns=existing_gvi_cols)

    # Initialize matching columns
    df['gvi_50m'] = np.nan
    df['gvi_tree_50m'] = np.nan
    df['gvi_grass_50m'] = np.nan
    df['gvi_plant_50m'] = np.nan
    df['gvi_match_dist_m'] = np.nan

    # Pre-index mapillary points by phase
    map_by_phase = {}
    for phase, sub in map_df.groupby('PhaseID'):
        map_by_phase[phase] = {
            'lons': sub['point_lon'].values,
            'lats': sub['point_lat'].values,
            'gvi': sub['GVI_%'].values,
            'tree': sub['Tree_%'].values,
            'grass': sub['Grass_%'].values,
            'plant': sub['Plant_%'].values,
            'pid': sub['PointID'].values
        }

    has_gps = df['ucm_GPS_lat'].notna() & df['ucm_GPS_lon'].notna()
    print(f"Total rows: {len(df)}, Rows with valid UCM GPS: {has_gps.sum()}")

    matched_count = 0
    rejected_count = 0
    for idx in df[has_gps].index:
        phase = df.at[idx, 'PhaseID']
        if phase not in map_by_phase:
            continue

        m_phase = map_by_phase[phase]
        c_lat = df.at[idx, 'ucm_GPS_lat']
        c_lon = df.at[idx, 'ucm_GPS_lon']

        dists = haversine_np(c_lon, c_lat, m_phase['lons'], m_phase['lats'])
        min_idx = np.argmin(dists)
        min_d = dists[min_idx]

        if min_d > max_radius_m:
            rejected_count += 1
            continue

        df.at[idx, 'gvi_50m'] = m_phase['gvi'][min_idx]
        df.at[idx, 'gvi_tree_50m'] = m_phase['tree'][min_idx]
        df.at[idx, 'gvi_grass_50m'] = m_phase['grass'][min_idx]
        df.at[idx, 'gvi_plant_50m'] = m_phase['plant'][min_idx]
        df.at[idx, 'gvi_match_dist_m'] = min_d
        if min_d <= max_radius_m:
            matched_count += 1

    overlap_piv = [c for c in piv_map.columns if c != 'PhaseID' and c in df.columns]
    if overlap_piv:
        df = df.drop(columns=overlap_piv)
    df = df.merge(piv_map, on='PhaseID', how='left')
    print(
        f"Matched {matched_count} points within {max_radius_m}m radius; "
        f"rejected {rejected_count} nearest points beyond the radius."
    )
    return df

# ── RUN ────────────────────────────────────────────────────────────────────
def main():
    df_map = load_mapillary_metrics(MAPILLARY_PATH)
    piv_map = compute_phase_summaries(df_map)

    # 1. Process 8-min dataset
    if MERGED_8MIN_PATH.exists():
        print(f"\nProcessing 8-min dataset: {MERGED_8MIN_PATH}")
        df_8min = pd.read_csv(MERGED_8MIN_PATH, low_memory=False)
        df_8min_gvi = match_gvi_to_merged(df_8min, df_map, piv_map, MAX_MATCH_RADIUS_M)
        OUT_8MIN_PATH.parent.mkdir(parents=True, exist_ok=True)
        temporary = OUT_8MIN_PATH.with_suffix('.tmp.csv')
        df_8min_gvi.to_csv(temporary, index=False)
        temporary.replace(OUT_8MIN_PATH)
        print(f"Saved matched 8-min GVI dataset to: {OUT_8MIN_PATH}")
        print("\nPhase summary in 8-min data:")
        print(df_8min_gvi.groupby('PhaseID')[['gvi_50m', 'gvi_tree_50m', 'gvi_grass_50m', 'gvi_plant_50m', 'gvi_match_dist_m', 'gvi_phase_mean']].mean())

    # 2. Process Full dataset
    if MERGED_FULL_PATH.exists():
        print(f"\nProcessing Full dataset: {MERGED_FULL_PATH}")
        df_full = pd.read_csv(MERGED_FULL_PATH, low_memory=False)
        df_full_gvi = match_gvi_to_merged(df_full, df_map, piv_map, MAX_MATCH_RADIUS_M)
        OUT_FULL_PATH.parent.mkdir(parents=True, exist_ok=True)
        temporary = OUT_FULL_PATH.with_suffix('.tmp.csv')
        df_full_gvi.to_csv(temporary, index=False)
        temporary.replace(OUT_FULL_PATH)
        print(f"Saved matched Full GVI dataset to: {OUT_FULL_PATH}")

    print("\nGVI Matching Pipeline Complete!")


if __name__ == "__main__":
    main()

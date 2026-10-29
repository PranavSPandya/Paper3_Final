"""Download RMI AWS 10-min observations (Uccle 6447) for Paper3 campaign dates.

Nearest official sub-hourly meteo to the Usquare corridor (~3–4 km). Use to enrich
uCM epochs; primary hyperlocal meteo remains backpack uCM (~10 s) in merged CSVs.

Hourly macro backup: D:/Pranav/docker/Paper3_Github/Weather underground.csv
(Open-Meteo-style point at 50.828, 4.388 — not WU PWS, not minute resolution).

Usage:
  python scripts/fetch_rmi_uccle_10min.py
  python scripts/fetch_rmi_uccle_10min.py --dates 2025-08-03,2025-08-04
  python scripts/fetch_rmi_uccle_10min.py --merge d:/Pranav/docker/Paper3_Final/output/merged_all_11participants_8min.csv
  python scripts/fetch_rmi_uccle_10min.py --skip-fetch --merge ...   # merge only (WFS already cached)

The opendata.meteo.be map UI often hangs; this script uses WFS CSV (one day per request).
If merge fails with OpenBLAS OOM on Windows, set OPENBLAS_NUM_THREADS=1 (this script sets it by default).
"""
from __future__ import annotations

import os

os.environ.setdefault("OPENBLAS_NUM_THREADS", "1")
os.environ.setdefault("OMP_NUM_THREADS", "1")

import argparse
import io
import urllib.parse
import urllib.request
from pathlib import Path

import pandas as pd

WFS_BASE = "https://opendata.meteo.be/service/ows"
UCCLE_CODE = 6447
DEFAULT_HOURLY = Path(r"D:/Pranav/docker/Paper3_Github/Weather underground.csv")
DEFAULT_OUT = Path(r"D:/Pranav/docker/Paper3_Final/output/external_meteo/rmi_uccle_aws_10min.csv")
DEFAULT_MERGE_OUT = Path(
    r"D:/Pranav/docker/Paper3_Final/output/external_meteo/merged_8min_with_rmi_uccle_10min.csv"
)


def campaign_dates_from_hourly(path: Path) -> list[str]:
    df = pd.read_csv(path, usecols=["Date"])
    return sorted(df["Date"].astype(str).unique())


def fetch_uccle_day(day: str, station: int = UCCLE_CODE) -> pd.DataFrame:
    cql = f"code = {station} AND timestamp BETWEEN '{day} 00:00:00' AND '{day} 23:59:59'"
    params = {
        "service": "wfs",
        "version": "2.0.0",
        "request": "getFeature",
        "typeNames": "aws:aws_10min",
        "outputformat": "csv",
        "CQL_FILTER": cql,
    }
    url = WFS_BASE + "?" + urllib.parse.urlencode(params)
    with urllib.request.urlopen(url, timeout=180) as resp:
        raw = resp.read()
    if not raw.strip():
        return pd.DataFrame()
    df = pd.read_csv(io.BytesIO(raw))
    if "timestamp" in df.columns:
        df["timestamp"] = pd.to_datetime(df["timestamp"], utc=True, errors="coerce")
    df["campaign_date"] = day
    return df


def fetch_all(days: list[str], station: int = UCCLE_CODE) -> pd.DataFrame:
    parts: list[pd.DataFrame] = []
    for day in days:
        print(f"Fetching Uccle {station} 10-min: {day} ...")
        part = fetch_uccle_day(day, station=station)
        print(f"  rows={len(part)}")
        parts.append(part)
    if not parts:
        return pd.DataFrame()
    out = pd.concat(parts, ignore_index=True)
    out = out.sort_values("timestamp").drop_duplicates(subset=["code", "timestamp"], keep="first")
    return out


def merge_asof_epochs(merged_path: Path, rmi: pd.DataFrame, out_path: Path) -> pd.DataFrame:
    m = pd.read_csv(merged_path, low_memory=False)
    time_col = "key_datetime" if "key_datetime" in m.columns else "Datetime"
    if time_col not in m.columns:
        raise SystemExit(f"Merge CSV missing {time_col}")
    m["_epoch_ts"] = pd.to_datetime(m[time_col], utc=True, errors="coerce")
    r = rmi.rename(columns={"timestamp": "_rmi_ts"}).sort_values("_rmi_ts")
    keep = [
        "_rmi_ts",
        "temp_dry_shelter_avg",
        "humidity_rel_shelter_avg",
        "pressure",
        "wind_speed_10m",
        "wind_direction",
        "precip_quantity",
        "short_wave_from_sky_avg",
    ]
    keep = [c for c in keep if c in r.columns]
    rmi_sub = r[keep].copy()
    rmi_sub = rmi_sub.rename(
        columns={
            c: ("rmi_uccle_timestamp" if c == "_rmi_ts" else f"rmi_uccle_{c}")
            for c in rmi_sub.columns
        }
    )
    joined = pd.merge_asof(
        m.sort_values("_epoch_ts"),
        rmi_sub,
        left_on="_epoch_ts",
        right_on="rmi_uccle_timestamp",
        direction="backward",
        tolerance=pd.Timedelta("10min"),
    )
    joined = joined.drop(columns=["_epoch_ts"], errors="ignore")
    out_path.parent.mkdir(parents=True, exist_ok=True)
    joined.to_csv(out_path, index=False)
    temp_col = "rmi_uccle_temp_dry_shelter_avg"
    n_match = joined[temp_col].notna().sum() if temp_col in joined.columns else 0
    print(f"Wrote {out_path} ({len(joined)} rows, RMI matched epochs={n_match})")
    return joined


def main() -> None:
    p = argparse.ArgumentParser(description="Fetch RMI Uccle AWS 10-min for Paper3 campaign.")
    p.add_argument("--hourly-csv", type=Path, default=DEFAULT_HOURLY)
    p.add_argument("--out", type=Path, default=DEFAULT_OUT)
    p.add_argument("--dates", type=str, default="", help="Comma-separated YYYY-MM-DD (default: from hourly CSV)")
    p.add_argument("--station", type=int, default=UCCLE_CODE)
    p.add_argument("--merge", type=Path, default=None, help="Optional merged 8min CSV for backward as-of join")
    p.add_argument("--merge-out", type=Path, default=DEFAULT_MERGE_OUT)
    p.add_argument(
        "--skip-fetch",
        action="store_true",
        help="Use existing --out CSV (WFS download skipped; requires --merge or manual use of cache)",
    )
    args = p.parse_args()

    if args.skip_fetch:
        if not args.out.is_file():
            raise SystemExit(f"--skip-fetch but missing {args.out}")
        rmi = pd.read_csv(args.out)
        if "timestamp" in rmi.columns:
            rmi["timestamp"] = pd.to_datetime(rmi["timestamp"], utc=True, errors="coerce")
        print(f"Loaded {args.out} ({len(rmi)} rows)")
    else:
        if args.dates.strip():
            days = [d.strip() for d in args.dates.split(",") if d.strip()]
        else:
            if not args.hourly_csv.is_file():
                raise SystemExit(f"Missing hourly reference: {args.hourly_csv}")
            days = campaign_dates_from_hourly(args.hourly_csv)

        rmi = fetch_all(days, station=args.station)
        if rmi.empty:
            raise SystemExit("No RMI rows returned.")
        args.out.parent.mkdir(parents=True, exist_ok=True)
        rmi.to_csv(args.out, index=False)
        print(f"Wrote {args.out} ({len(rmi)} rows, {rmi['timestamp'].min()} .. {rmi['timestamp'].max()})")

    if args.merge:
        merge_asof_epochs(args.merge, rmi, args.merge_out)


if __name__ == "__main__":
    main()

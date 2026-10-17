"""
download_mapillary_route_points.py
==================================
Download Mapillary 360 equirectangular panoramas for Paper 3 route points.

This script queries the Mapillary Graph API v4 for panoramic images (is_pano == True)
within a specified search radius (default 50 m) around audited route points in merged_path.gpkg.

Outputs:
  - Downloaded panoramas: output/GVI_output/images/Mapillary computation images/
  - Route metadata table: output/GVI_output/Mapillary_route_metadata.csv
"""

import argparse
import json
import math
import os
import time
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

import geopandas as gpd
import pandas as pd

# ── CONFIG ─────────────────────────────────────────────────────────────────
PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_DIR = PROJECT_ROOT / "output" / "GVI_output"
POINTS_GPKG = OUTPUT_DIR / "merged_path.gpkg"
IMAGE_DIR = OUTPUT_DIR / "images" / "Mapillary computation images"
METADATA_CSV = OUTPUT_DIR / "Mapillary_route_metadata.csv"
ARCHIVE_METADATA_DIR = PROJECT_ROOT / "archive" / "output" / "GVI_output" / "_archive"

DEFAULT_TOKEN = None  # set MAPILLARY_CLIENT_TOKEN or MAPILLARY_ACCESS_TOKEN in the environment
DEFAULT_RADIUS_M = 50.0

# ── DEFINE ─────────────────────────────────────────────────────────────────
def haversine(lat1, lon1, lat2, lon2):
    """Haversine distance between two coordinates in meters."""
    R = 6371000.0
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    dphi = math.radians(lat2 - lat1)
    dlambda = math.radians(lon2 - lon1)
    a = math.sin(dphi / 2.0)**2 + math.cos(phi1) * math.cos(phi2) * math.sin(dlambda / 2.0)**2
    return 2.0 * R * math.atan2(math.sqrt(a), math.sqrt(1.0 - a))


def query_mapillary_candidates(lat, lon, token, radius_m=50.0):
    """Query Mapillary Graph API v4 for 360 equirectangular panoramas within radius_m."""
    delta_lat = radius_m / 111320.0
    delta_lon = radius_m / (111320.0 * math.cos(math.radians(lat)))
    bbox = f"{lon - delta_lon},{lat - delta_lat},{lon + delta_lon},{lat + delta_lat}"
    
    url = (
        f"https://graph.mapillary.com/images?access_token={token}"
        f"&fields=id,captured_at,computed_geometry,compass_angle,is_pano,sequence,thumb_2048_url,thumb_original_url"
        f"&bbox={bbox}&limit=100"
    )
    
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=20) as resp:
                data = json.loads(resp.read().decode("utf-8"))
            images = data.get("data", [])
            panos = []
            for img in images:
                if not img.get("is_pano", False):
                    continue
                coords = img.get("computed_geometry", {}).get("coordinates", [])
                if len(coords) < 2:
                    continue
                img_lon, img_lat = coords[0], coords[1]
                dist = haversine(lat, lon, img_lat, img_lon)
                if dist <= radius_m:
                    panos.append({
                        "id": str(img.get("id")),
                        "lat": img_lat,
                        "lon": img_lon,
                        "distance_m": round(dist, 2),
                        "compass_angle": img.get("compass_angle"),
                        "captured_at": img.get("captured_at", 0),
                        "sequence_id": str(img.get("sequence", "")),
                        "is_pano": True,
                        "url": img.get("thumb_2048_url") or img.get("thumb_original_url")
                    })
            panos.sort(key=lambda x: x["distance_m"])
            return {"status": "OK", "candidates": panos, "total_candidates": len(panos)}
        except Exception as exc:
            if attempt == 2:
                return {"status": "ERROR", "error": str(exc), "candidates": [], "total_candidates": 0}
            time.sleep(2 ** attempt)
            
    return {"status": "ERROR", "error": "Max retries exceeded", "candidates": [], "total_candidates": 0}


def download_image(url, target_path):
    """Download image to target path."""
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"})
    with urllib.request.urlopen(req, timeout=30) as resp, open(target_path, "wb") as f:
        f.write(resp.read())


# ── RUN ────────────────────────────────────────────────────────────────────
def main():
    parser = argparse.ArgumentParser(description="Download Mapillary 360 route points.")
    parser.add_argument("--dry-run", action="store_true", help="Query API without downloading images")
    parser.add_argument("--radius", type=float, default=DEFAULT_RADIUS_M, help="Search radius in meters")
    parser.add_argument("--limit", type=int, default=None, help="Process only first N points")
    args = parser.parse_args()

    token = os.environ.get("MAPILLARY_CLIENT_TOKEN") or os.environ.get("MAPILLARY_ACCESS_TOKEN") or DEFAULT_TOKEN
    if not token:
        raise SystemExit("Set MAPILLARY_CLIENT_TOKEN or MAPILLARY_ACCESS_TOKEN; no API key is embedded in this script.")
    
    if not POINTS_GPKG.exists():
        raise SystemExit(f"Input route GeoPackage missing: {POINTS_GPKG}")

    IMAGE_DIR.mkdir(parents=True, exist_ok=True)
    METADATA_CSV.parent.mkdir(parents=True, exist_ok=True)

    # Initialize metadata from existing file or archive
    existing_records = {}
    archived_metadata = sorted(ARCHIVE_METADATA_DIR.glob("Mapillary_route_metadata_*.csv"))
    source_csv = METADATA_CSV if METADATA_CSV.exists() else (archived_metadata[-1] if archived_metadata else None)
    if source_csv and source_csv.exists():
        print(f"Loading existing metadata from: {source_csv}")
        df_exist = pd.read_csv(source_csv).fillna("")
        for rec in df_exist.to_dict("records"):
            existing_records[str(rec.get("PointID"))] = rec

    print(f"Reading sample points from: {POINTS_GPKG}")
    points = gpd.read_file(POINTS_GPKG, layer="sample_points").to_crs("EPSG:4326")
    selected_points = points if args.limit is None else points.iloc[:args.limit]

    output_records = []
    print(f"Processing {len(selected_points)} route points with search radius {args.radius} m...")

    for num, row in enumerate(selected_points.itertuples(index=False), 1):
        point_id = str(row.PointID)
        phase_id = str(row.PhaseID)
        point_lon, point_lat = row.geometry.x, row.geometry.y

        # Check existing complete record
        if point_id in existing_records:
            rec = existing_records[point_id]
            fpath = Path(rec.get("local_path", ""))
            # Also check in canonical IMAGE_DIR
            canonical_path = IMAGE_DIR / rec.get("filename", "")
            target_fpath = canonical_path if canonical_path.exists() else fpath
            if target_fpath.exists() and target_fpath.stat().st_size > 0 and rec.get("status") in ("DOWNLOADED", "DOWNLOADED_EXISTING"):
                rec["local_path"] = str(target_fpath)
                rec["status"] = "DOWNLOADED_EXISTING"
                output_records.append(rec)
                print(f"[{num}/{len(selected_points)}] {point_id}: Existing image present ({rec.get('filename')})")
                continue

        # Query Mapillary API
        query_res = query_mapillary_candidates(point_lat, point_lon, token, radius_m=args.radius)
        if query_res["status"] != "OK" or not query_res["candidates"]:
            rec = {
                "PhaseID": phase_id,
                "PointID": point_id,
                "candidate_count": query_res["total_candidates"],
                "capture_date": "",
                "captured_at_utc": "",
                "compass_angle": "",
                "distance_m": "",
                "error": query_res.get("error", "NO_PANOS_FOUND"),
                "filename": "",
                "image_id": "",
                "image_lat": "",
                "image_lon": "",
                "is_pano": False,
                "local_path": "",
                "point_lat": point_lat,
                "point_lon": point_lon,
                "radius_m": args.radius,
                "sequence_id": "",
                "status": "NO_ELIGIBLE_PANO"
            }
            output_records.append(rec)
            print(f"[{num}/{len(selected_points)}] {point_id}: No eligible panorama found")
            continue

        best = query_res["candidates"][0]
        cap_ms = best["captured_at"]
        dt = datetime.fromtimestamp(cap_ms / 1000.0, tz=timezone.utc)
        cap_date = dt.strftime("%Y-%m-%d")
        cap_utc = dt.isoformat()
        
        fname = f"Mapillary_{cap_date}_{point_id}_id_{best['id']}.jpg"
        img_path = IMAGE_DIR / fname

        status = "FOUND" if args.dry_run else "DOWNLOADED"
        error_msg = ""

        if not args.dry_run:
            if img_path.exists() and img_path.stat().st_size > 0:
                status = "DOWNLOADED_EXISTING"
            else:
                try:
                    download_image(best["url"], img_path)
                    status = "DOWNLOADED"
                except Exception as exc:
                    status = "DOWNLOAD_ERROR"
                    error_msg = str(exc)

        rec = {
            "PhaseID": phase_id,
            "PointID": point_id,
            "candidate_count": query_res["total_candidates"],
            "capture_date": cap_date,
            "captured_at_utc": cap_utc,
            "compass_angle": best["compass_angle"],
            "distance_m": best["distance_m"],
            "error": error_msg,
            "filename": fname,
            "image_id": best["id"],
            "image_lat": best["lat"],
            "image_lon": best["lon"],
            "is_pano": True,
            "local_path": str(img_path),
            "point_lat": point_lat,
            "point_lon": point_lon,
            "radius_m": args.radius,
            "sequence_id": best["sequence_id"],
            "status": status
        }
        output_records.append(rec)
        print(f"[{num}/{len(selected_points)}] {point_id}: {status} -> {fname} (dist: {best['distance_m']}m)")

        # Periodically save metadata
        if num % 20 == 0 or num == len(selected_points):
            pd.DataFrame(output_records).to_csv(METADATA_CSV, index=False)
            
        time.sleep(0.1)

    pd.DataFrame(output_records).to_csv(METADATA_CSV, index=False)
    print(f"\nMetadata saved to: {METADATA_CSV}")
    print(f"Images location: {IMAGE_DIR}")
    print(f"Total points processed: {len(output_records)}")


if __name__ == "__main__":
    main()

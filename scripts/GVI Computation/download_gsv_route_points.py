"""Download dated Google Street View directional views for Paper 3 route points.

The six headings together cover 360 degrees around the selected panorama. This
uses the same Google Street View Static API workflow as the archived Paper 2
downloader, but reads the audited route-point GeoPackage and writes only to the
Paper 3 GVI output folders.
"""

import argparse
import json
import os
import time
from datetime import date
from io import BytesIO
from pathlib import Path

import geopandas as gpd
import pandas as pd
import requests
from PIL import Image


PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_DIR = PROJECT_ROOT / "output"
POINTS = OUTPUT_DIR / "GVI_output" / "merged_path.gpkg"
IMAGE_DIR = OUTPUT_DIR / "GSV computation images"
METADATA_CSV = OUTPUT_DIR / "GVI_output" / "GSV_route_metadata.csv"
PANORAMA_METADATA_CSV = OUTPUT_DIR / "GVI_output" / "GSV_360_route_metadata.csv"
HEADINGS = (0, 60, 120, 180, 240, 300)
MIN_YEAR, MAX_YEAR = 2021, date.today().year
ALLOWED_MONTHS = set(range(3, 12))


def haversine(lat1, lon1, lat2, lon2):
    from math import asin, cos, radians, sin, sqrt

    dlat, dlon = radians(lat2 - lat1), radians(lon2 - lon1)
    a = sin(dlat / 2) ** 2 + cos(radians(lat1)) * cos(radians(lat2)) * sin(dlon / 2) ** 2
    return 6_371_000 * 2 * asin(sqrt(a))


def eligible(date_text):
    try:
        value = pd.Timestamp(date_text)
        return MIN_YEAR <= value.year <= MAX_YEAR and value.month in ALLOWED_MONTHS
    except (TypeError, ValueError):
        return False


def historical_panos(pano_id):
    url = (
        "https://www.google.com/maps/photometa/v1?authuser=0&hl=en&gl=us&pb="
        "!1m4!1smaps_sv.tactile!11m2!2m1!1b1!2m2!1sen!2sus"
        f"!3m3!1m2!1e2!2s{pano_id}"
        "!4m57!1e1!1e2!1e3!1e4!1e5!1e6!1e8!1e12!2m1!1e1!4m1!1i48!5m1!1e1!5m1!1e2"
        "!6m1!1e1!6m1!1e2!9m36!1m3!1e2!2b1!3e2!1m3!1e3!2b1!3e2"
        "!1m3!1e10!2b1!3e2!1m3!1e1!2b1!3e2!1m3!1e4!2b1!3e2"
        "!1m3!1e5!2b1!3e2!1m3!1e6!2b1!3e2!1m3!1e8!2b1!3e2"
        "!1m3!1e12!2b1!3e2!1m3!1e14!2b1!3e2!1m3!1e19!2b1!3e2!1m3!1e20!2b1!3e2"
    )
    try:
        text = requests.get(url, timeout=20).text
        if text.startswith(")]}'"):
            text = text[4:].strip()
        data = json.loads(text)
        entries = data[1][5][0][3][0]
        return [(item[0][1], f"{item[1][0]}-{item[1][1]:02d}-01") for item in entries]
    except (IndexError, KeyError, TypeError, ValueError, requests.RequestException):
        return []


def metadata(lat, lon, key, pano_id=None, radius=50):
    params = {"key": key, "radius": radius, "location": f"{lat},{lon}"}
    if pano_id:
        params = {"key": key, "pano": pano_id}
    last = {"status": "ERROR", "error": "metadata request failed"}
    for attempt in range(3):
        try:
            data = requests.get(
                "https://maps.googleapis.com/maps/api/streetview/metadata",
                params=params,
                timeout=20,
            ).json()
            if data.get("status") == "OK":
                return {
                    "status": "OK",
                    "pano_id": data.get("pano_id"),
                    "date": data.get("date"),
                    "lat": data["location"]["lat"],
                    "lon": data["location"]["lng"],
                }
            last = {"status": data.get("status", "ERROR"), "error": data.get("error_message", "")}
        except (KeyError, TypeError, requests.RequestException, ValueError) as exc:
            last = {"status": "ERROR", "error": str(exc)}
        time.sleep(2 ** attempt)
    return last


def newest_eligible_pano(lat, lon, key):
    last = {"status": "NO_ELIGIBLE_DATE", "default_date": ""}
    for radius in (50, 100):
        current = metadata(lat, lon, key, radius=radius)
        if current.get("status") != "OK":
            last = current
            continue
        candidates = {current["pano_id"]: current["date"]}
        candidates.update(dict(historical_panos(current["pano_id"])))
        eligible_candidates = [(pd.Timestamp(dt), pano) for pano, dt in candidates.items() if eligible(dt)]
        if not eligible_candidates:
            last = {"status": "NO_ELIGIBLE_DATE", "default_date": current.get("date"), "search_radius_m": radius}
            continue
        _, selected_id = max(eligible_candidates)
        selected = metadata(lat, lon, key, selected_id)
        selected["distance_m"] = haversine(lat, lon, selected.get("lat", lat), selected.get("lon", lon))
        selected["search_radius_m"] = radius
        return selected
    return last


def download_view(pano_id, heading, key):
    params = {
        "size": "640x640",
        "heading": heading,
        "pitch": 0,
        "fov": 90,
        "pano": pano_id,
        "key": key,
        "return_error_codes": "true",
    }
    last_error = None
    for attempt in range(3):
        try:
            response = requests.get("https://maps.googleapis.com/maps/api/streetview", params=params, timeout=30)
            if response.status_code == 200 and "image" in response.headers.get("content-type", ""):
                return Image.open(BytesIO(response.content)).convert("RGB")
            last_error = f"HTTP {response.status_code}: {response.text[:200]}"
        except requests.RequestException as exc:
            last_error = f"{type(exc).__name__}: {exc}"
        time.sleep(2 ** attempt)
    raise RuntimeError(last_error or "unknown image-download error")


def download_panorama(pano_id, zoom=2):
    """Download and stitch a true 2:1 Street View equirectangular panorama."""
    if zoom < 1:
        raise ValueError("Panorama zoom must be at least 1")
    columns, rows = 2**zoom, 2 ** (zoom - 1)
    panorama = Image.new("RGB", (512 * columns, 512 * rows))
    headers = {"User-Agent": "Mozilla/5.0", "Referer": "https://www.google.com/maps/"}
    for y in range(rows):
        for x in range(columns):
            params = {
                "cb_client": "maps_sv.tactile",
                "panoid": pano_id,
                "x": x,
                "y": y,
                "zoom": zoom,
                "nbt": 1,
                "fover": 2,
            }
            response = requests.get(
                "https://streetviewpixels-pa.googleapis.com/v1/tile",
                params=params,
                headers=headers,
                timeout=30,
            )
            if response.status_code != 200 or "image" not in response.headers.get("content-type", ""):
                raise RuntimeError(f"Panorama tile failed: HTTP {response.status_code}: {response.text[:200]}")
            panorama.paste(Image.open(BytesIO(response.content)).convert("RGB"), (x * 512, y * 512))
    return panorama


def download_route_panoramas(points, metadata_records, zoom, limit=None):
    records_by_point = {}
    for record in metadata_records:
        records_by_point.setdefault(str(record.get("PointID", "")), []).append(record)
    output_records = []
    selected_points = points if limit is None else points.iloc[:limit]
    for number, row in enumerate(selected_points.itertuples(index=False), 1):
        point_id = str(row.PointID)
        source = next((r for r in records_by_point.get(point_id, []) if r.get("pano_id")), None)
        if source is None:
            output_records.append({"PointID": point_id, "PhaseID": row.PhaseID, "status": "NO_ELIGIBLE_PANO"})
            print(f"[{number}/{len(selected_points)}] {point_id}: no selected panorama", flush=True)
            continue
        capture_date = str(source.get("capture_date", ""))
        filename = f"GSV_{capture_date}_{point_id}_360.jpg"
        path = IMAGE_DIR / filename
        status = "DOWNLOADED_EXISTING"
        error = ""
        if not path.exists() or path.stat().st_size == 0:
            try:
                download_panorama(str(source["pano_id"]), zoom=zoom).save(path, quality=95)
                status = "DOWNLOADED_360"
            except (OSError, RuntimeError, requests.RequestException) as exc:
                status, error = "DOWNLOAD_ERROR", str(exc)
        output_records.append({
            "PointID": point_id,
            "PhaseID": row.PhaseID,
            "status": status,
            "error": error,
            "capture_date": capture_date,
            "pano_id": source["pano_id"],
            "zoom": zoom,
            "filename": filename,
            "local_path": str(path),
        })
        PANORAMA_METADATA_CSV.parent.mkdir(parents=True, exist_ok=True)
        pd.DataFrame(output_records).to_csv(PANORAMA_METADATA_CSV, index=False)
        print(f"[{number}/{len(selected_points)}] {point_id}: {status}", flush=True)
    PANORAMA_METADATA_CSV.parent.mkdir(parents=True, exist_ok=True)
    pd.DataFrame(output_records).to_csv(PANORAMA_METADATA_CSV, index=False)
    return output_records


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true", help="Find eligible panoramas without downloading images")
    parser.add_argument("--panorama", action="store_true", help="Download one true equirectangular panorama per route point")
    parser.add_argument("--panorama-zoom", type=int, default=2, help="Tile zoom for equirectangular panoramas (2 = 2048x1024)")
    parser.add_argument("--limit", type=int, default=None, help="Process only the first N points")
    args = parser.parse_args()
    key = os.environ.get("GOOGLE_MAPS_API_KEY")
    if not key and not args.panorama:
        raise SystemExit("GOOGLE_MAPS_API_KEY is not set; no API key is embedded in this script.")
    if not POINTS.exists():
        raise SystemExit(f"Missing input GeoPackage: {POINTS}")

    points = gpd.read_file(POINTS, layer="sample_points").to_crs("EPSG:4326")
    IMAGE_DIR.mkdir(parents=True, exist_ok=True)
    records_by_point = {}
    if METADATA_CSV.exists():
        for record in pd.read_csv(METADATA_CSV).fillna("").to_dict("records"):
            records_by_point.setdefault(str(record.get("PointID", "")), []).append(record)
    if args.panorama:
        metadata_records = [record for rows in records_by_point.values() for record in rows]
        download_route_panoramas(points, metadata_records, args.panorama_zoom, args.limit)
        print(f"Panorama metadata: {PANORAMA_METADATA_CSV}")
        print(f"Panorama images: {IMAGE_DIR}")
        return
    for number, row in enumerate(points.itertuples(index=False), 1):
        point_id = str(row.PointID)
        existing = records_by_point.get(point_id, [])
        existing_files = [Path(str(r.get("local_path", ""))) for r in existing if r.get("local_path")]
        if existing and len(existing) == len(HEADINGS) and all(p.exists() and p.stat().st_size > 0 for p in existing_files):
            print(f"[{number}/{len(points)}] {point_id}: existing complete point")
            continue
        lon, lat = row.geometry.x, row.geometry.y
        pano = newest_eligible_pano(lat, lon, key)
        print(f"[{number}/{len(points)}] {row.PointID}: {pano.get('status')} {pano.get('date', '')}")
        point_records = []
        if pano.get("status") != "OK":
            point_records.append({"PointID": row.PointID, "PhaseID": row.PhaseID, "status": pano.get("status"), "error": pano.get("error", ""), "default_date": pano.get("default_date", ""), "search_radius_m": pano.get("search_radius_m", ""), "point_lat": lat, "point_lon": lon})
            records_by_point[point_id] = point_records
            pd.DataFrame([r for rows in records_by_point.values() for r in rows]).to_csv(METADATA_CSV, index=False)
            continue
        for heading in HEADINGS:
            filename = f"GSV_{pano['date']}_{row.PointID}_heading_{heading:03d}.jpg"
            path = IMAGE_DIR / filename
            status = "FOUND" if args.dry_run else "DOWNLOADED"
            error = None
            if not args.dry_run and not path.exists():
                try:
                    download_view(pano["pano_id"], heading, key).save(path, quality=95)
                except RuntimeError as exc:
                    status = "DOWNLOAD_ERROR"
                    error = str(exc)
            elif not args.dry_run:
                status = "DOWNLOADED_EXISTING"
            point_records.append({
                "PointID": row.PointID,
                "PhaseID": row.PhaseID,
                "status": status,
                "error": error,
                "capture_date": pano["date"],
                "pano_id": pano["pano_id"],
                "heading": heading,
                "point_lat": lat,
                "point_lon": lon,
                "pano_lat": pano["lat"],
                "pano_lon": pano["lon"],
                "distance_m": pano.get("distance_m"),
                "search_radius_m": pano.get("search_radius_m"),
                "filename": filename,
                "local_path": str(path),
            })
        records_by_point[point_id] = point_records
        pd.DataFrame([r for rows in records_by_point.values() for r in rows]).to_csv(METADATA_CSV, index=False)
        time.sleep(0.25)
    pd.DataFrame([r for rows in records_by_point.values() for r in rows]).to_csv(METADATA_CSV, index=False)
    print(f"Metadata: {METADATA_CSV}")
    print(f"Images: {IMAGE_DIR}")


if __name__ == "__main__":
    main()

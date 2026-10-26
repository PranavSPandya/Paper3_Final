"""Decode saved SVF overlay JPGs into per-pixel ADE20K class shares for CamUp images.

Selection: all rows of merged_SVF.csv except PhaseID == Tram, optionally only those with
other = 100 - (Sky+Tree+Plant+Grass+Building+Wall) > --min-other. Each overlay (70% class colour /
30% photo, JPEG, title bar on top) is unblended with the re-rectified photo,
colour = (overlay - 0.3 * photo) / 0.7, and every pixel inside the fisheye circle is assigned the
nearest ADE20K palette colour. No smoothing.

Read-only on output/SVF Output/ and the raw images; --out must not point inside output/SVF Output/.
Resumable: images already in --out are skipped, new results are appended in chunks.
"""
import argparse
import os
import sys
import time
from multiprocessing import Pool
from pathlib import Path

import cv2
import numpy as np
import pandas as pd

REPO = Path(__file__).resolve().parents[2]
SVF_DIR = REPO / "scripts" / "SVF Computation"
MERGED = REPO / "output" / "SVF Output" / "merged_SVF.csv"
SIX = ["Sky_%", "Tree_%", "Plant_%", "Grass_%", "Building_%", "Wall_%"]
KEY = ["ParticipantID", "PhaseID", "Filename"]
LABEL_DISTANCE_BATCH = 5_000

S = None
PALETTE = None
NAMES = None
RECTIFIERS = {}


def init_worker():
    global S, PALETTE, NAMES
    sys.path.insert(0, str(SVF_DIR))
    import compute_svf_camup
    from pixellib.semantic import create_ade20k_label_colormap, create_ade20k_label_namemap
    S = compute_svf_camup
    PALETTE = np.asarray(create_ade20k_label_colormap())[:151].astype(np.float32)
    NAMES = create_ade20k_label_namemap()


def class_names():
    from pixellib.semantic import create_ade20k_label_namemap
    names = create_ade20k_label_namemap()
    return [names[i] for i in range(151)]


def rectifier_for(w0, h0):
    if (w0, h0) not in RECTIFIERS:
        center = (w0 / 2.0, h0 / 2.0)
        radius = min(w0, h0) / 2.0
        rect = S.OpticalRectifier(list(S.MSE_REFERENCE_CALIBRATION_TABLE), w0, h0, center, radius, radius,
                                  S.MSE_REFERENCE_RADIUS_PX)
        RECTIFIERS[(w0, h0)] = (rect, center, radius)
    return RECTIFIERS[(w0, h0)]


def nearest_label(rgb):
    p2 = (PALETTE ** 2).sum(1)
    out = np.empty(len(rgb), np.int32)
    for i in range(0, len(rgb), LABEL_DISTANCE_BATCH):
        x = rgb[i:i + LABEL_DISTANCE_BATCH]
        out[i:i + LABEL_DISTANCE_BATCH] = ((x ** 2).sum(1)[:, None] - 2 * x @ PALETTE.T + p2[None]).argmin(1)
    return out


def decode(row):
    pid, phase, fn, image_path, overlay_path = row
    rec = {"ParticipantID": pid, "PhaseID": phase, "Filename": fn, "Decode_Error": ""}
    try:
        overlay = cv2.imread(overlay_path)
        raw = cv2.imread(image_path)
        if overlay is None or raw is None:
            raise ValueError("image read failed")
        h0, w0 = raw.shape[:2]
        rect, center, radius = rectifier_for(w0, h0)
        rect_bgr, f_mask = rect.rectify_image(raw)
        rx, cx, cy = int(round(radius)), int(round(center[0])), int(round(center[1]))
        x0, x1, y0, y1 = max(0, cx - rx), min(w0, cx + rx), max(0, cy - rx), min(h0, cy + rx)
        photo = rect_bgr[y0:y1, x0:x1].astype(np.float32)
        inside = f_mask[y0:y1, x0:x1] > 0
        body = overlay[overlay.shape[0] - photo.shape[0]:].astype(np.float32)
        if body.shape != photo.shape:
            raise ValueError(f"overlay/photo shape mismatch {body.shape} vs {photo.shape}")
        colour_rgb = np.clip((body - 0.3 * photo) / 0.7, 0, 255)[..., ::-1][inside]
        ids, counts = np.unique(nearest_label(colour_rgb), return_counts=True)
        area = float(inside.sum())
        rec.update({NAMES[i]: n / area * 100.0 for i, n in zip(ids, counts)})
    except Exception as e:
        rec["Decode_Error"] = str(e)
    return rec


def load_targets(min_other, tram_only=False):
    df = pd.read_csv(MERGED, usecols=KEY + ["Image_Path", "Segmented_Image_Path"] + SIX, low_memory=False)
    df = df[df["PhaseID"].eq("Tram") if tram_only else df["PhaseID"].ne("Tram")]
    if min_other > 0:
        df = df[100.0 - df[SIX].sum(axis=1) > min_other]
    return df.reset_index(drop=True)


def prepare_resume_output(out, columns, retry_errors=False):
    """Return completed keys, optionally retaining only successful prior rows atomically."""
    if not out.is_file():
        return set()
    existing = pd.read_csv(out, low_memory=False)
    missing = set(KEY + ["Decode_Error"]) - set(existing.columns)
    if missing:
        raise ValueError(f"Existing output is missing required resume columns: {sorted(missing)}")
    error_text = existing["Decode_Error"].fillna("").astype(str).str.strip()
    completed = existing.loc[error_text.eq("")].copy() if retry_errors else existing
    if retry_errors and len(completed) != len(existing):
        temporary = out.with_name(f".{out.name}.retry.tmp")
        completed.reindex(columns=columns).to_csv(temporary, index=False)
        os.replace(temporary, out)
    return set(map(tuple, completed[KEY].astype(str).values))


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--workers", type=int, default=8)
    ap.add_argument("--min-other", type=float, default=0.0)
    ap.add_argument("--chunk", type=int, default=200)
    ap.add_argument("--tram-only", action="store_true", help="Decode only Tram images into a separate output file.")
    ap.add_argument("--out", type=Path, default=None)
    ap.add_argument("--limit", type=int, default=None)
    ap.add_argument("--retry-errors", action="store_true", help="Remove prior error rows and decode them again.")
    args = ap.parse_args()
    if args.out is None:
        name = "decoded_all_classes_Tram.csv" if args.tram_only else "decoded_all_classes_noTram.csv"
        args.out = REPO / "output" / "SVF Output_2" / name
    if MERGED.parent.resolve() in args.out.resolve().parents:
        sys.exit(f"Refusing to write inside {MERGED.parent}")

    targets = load_targets(args.min_other, tram_only=args.tram_only)
    columns = KEY + ["Decode_Error"] + class_names()
    if args.out.is_file():
        done_keys = prepare_resume_output(args.out, columns, retry_errors=args.retry_errors)
        targets = targets[[k not in done_keys for k in map(tuple, targets[KEY].astype(str).values)]]
    if args.limit:
        targets = targets.head(args.limit)
    args.out.parent.mkdir(parents=True, exist_ok=True)

    jobs = list(targets[KEY + ["Image_Path", "Segmented_Image_Path"]].itertuples(index=False, name=None))
    total = len(jobs)
    print(f"{total} images to decode -> {args.out} ({args.workers} workers)", flush=True)
    if not total:
        return

    t0, n_done, n_err, buffer = time.time(), 0, 0, []
    with Pool(args.workers, initializer=init_worker) as pool:
        for rec in pool.imap_unordered(decode, jobs, chunksize=4):
            buffer.append(rec)
            n_done += 1
            n_err += bool(rec["Decode_Error"])
            if len(buffer) >= args.chunk or n_done == total:
                out = pd.DataFrame(buffer).reindex(columns=columns)
                class_cols = columns[4:]
                out[class_cols] = out[class_cols].fillna(0.0)
                out.to_csv(args.out, mode="a", header=not args.out.is_file(), index=False)
                buffer = []
                rate = n_done / (time.time() - t0)
                eta = (total - n_done) / rate / 60 if rate else float("nan")
                print(f"{n_done}/{total} done | errors {n_err} | {rate:.2f} img/s | ETA {eta:.1f} min", flush=True)


if __name__ == "__main__":
    main()

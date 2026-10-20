"""
run_gvi_xception_route.py
=========================
Standalone Python script based on:
"C:\\Users\\pandya\\OneDrive - UCL\\Data shared\\Response 30Mar\\Paper2_Revision\\final gvi\\biking_photos_original unedited.ipynb"

This script executes the DeepLabV3+ model with Xception-65 backbone on ADE20K:
- Target model: deeplabv3_xception65_ade20k.h5
- Target categories: 'tree', 'grass', 'plant' (+ sky/built-up metrics)
- Computes Tree %, Grass %, Plant %, and Combined GVI %
- Saves segmented PNGs and a full 151-class CSV; ProcessPool --workers
- Compatible with TensorFlow 2.x via automatic Keras layer patching
"""

import os
import sys
import json
import argparse
import urllib.request
import time
import types
from concurrent.futures import ProcessPoolExecutor, as_completed
from pathlib import Path

import numpy as np
import pandas as pd
import cv2
from PIL import Image

# Keep TensorFlow logging quiet without changing the model or its predictions.
os.environ.setdefault("TF_CPP_MIN_LOG_LEVEL", "3")
os.environ.setdefault("TF_ENABLE_ONEDNN_OPTS", "0")
os.environ.setdefault("TF_USE_LEGACY_KERAS", "1")

# Model URL and paths. The colleague's notebook uses the same ADE20K
# DeepLabV3+ Xception-65 model and the same tree/grass/plant categories.
MODEL_URL = "https://github.com/ayoolaolafenwa/PixelLib/releases/download/1.3/deeplabv3_xception65_ade20k.h5"
MODEL_FILENAME = "deeplabv3_xception65_ade20k.h5"
MODEL_DIR = Path(__file__).resolve().parent
MODEL_PATH = MODEL_DIR / MODEL_FILENAME

PROJECT_ROOT = Path(__file__).resolve().parents[2]
INPUT_DIR = PROJECT_ROOT / "output" / "GSV computation images"
SEGMENTED_DIR = PROJECT_ROOT / "output" / "GVI_output" / "Segmented images"
OUTPUT_CSV = PROJECT_ROOT / "output" / "GVI_output" / "GVI_Xception_route_metrics.csv"
FINAL_GVI_CSV = OUTPUT_CSV
OUTPUT_JSON = PROJECT_ROOT / "output" / "GVI_output" / "GVI_Xception_route_output.json"
CLASSES_CSV = PROJECT_ROOT / "output" / "GVI_output" / "151_classes_GVI.csv"
IMAGE_SUFFIXES = {".jpg", ".jpeg", ".png"}
GREEN_THRESHOLD_PCT = 10.0
TRAINED_IMAGE_WIDTH = 512
MEAN_SUBTRACTION_VALUE = 127.5

# Per-process worker state (one model load per ProcessPool worker).
_WORKER = {}


def _patch_keras_for_pixellib():
    """Patch tensorflow.python.keras for PixelLib on modern TF."""
    try:
        import tensorflow as tf  # noqa: F401
        import tensorflow.keras as keras_api
        import tensorflow.keras.layers as keras_layers
        import tensorflow.python.keras.models as internal_models

        layers_module = sys.modules.get("tensorflow.python.keras.layers")
        if layers_module is None:
            layers_module = types.ModuleType("tensorflow.python.keras.layers")
            sys.modules["tensorflow.python.keras.layers"] = layers_module
        for attr in dir(keras_layers):
            setattr(layers_module, attr, getattr(keras_layers, attr))
        internal_models.Model = keras_api.Model
    except ImportError:
        pass


def _configure_tf_device():
    """Enable GPU memory growth when a GPU is visible; return GPU list."""
    import tensorflow as tf

    gpus = tf.config.list_physical_devices("GPU")
    for gpu in gpus:
        try:
            tf.config.experimental.set_memory_growth(gpu, True)
        except Exception:
            pass
    return gpus


def download_model_if_needed():
    if not MODEL_PATH.exists():
        print(f"Downloading {MODEL_FILENAME} from {MODEL_URL} ...", flush=True)
        urllib.request.urlretrieve(MODEL_URL, str(MODEL_PATH))
        print(f"Downloaded model to: {MODEL_PATH} ({MODEL_PATH.stat().st_size:,} bytes)", flush=True)
    else:
        print(f"Found existing Xception model at: {MODEL_PATH}", flush=True)


def _class_ratio_percent(class_names, ratios, category):
    """Return PixelLib's ratio for one ADE20K class, in percentage units."""
    if len(class_names) != len(ratios):
        raise ValueError("PixelLib returned different numbers of class names and ratios")
    if len(set(class_names)) != len(class_names):
        raise ValueError("PixelLib returned duplicate class names")
    if category not in class_names:
        return 0.0
    value = float(ratios[class_names.index(category)])
    if not np.isfinite(value) or not 0.0 <= value <= 100.0:
        raise ValueError(f"Invalid {category} ratio returned by PixelLib: {value}")
    return value


def _image_identity(image_path):
    parts = image_path.stem.split("_")
    if len(parts) >= 4 and parts[0] in {"GSV", "Mapillary"}:
        source, capture_date, phase_id, point_number = parts[:4]
        point_id = f"{phase_id}_{point_number}"
        heading = parts[5] if source == "GSV" and len(parts) >= 6 and parts[4] == "heading" else ""
        return source, capture_date, phase_id, point_id, heading
    return "Unknown", "", "", image_path.stem, ""


def _feature_season(image_path, source, point_id):
    stem_lower = image_path.stem.lower()
    if "_summer_" in stem_lower:
        idx = stem_lower.rfind("_summer_")
        return image_path.stem[:idx], "Summer"
    if "_winter_" in stem_lower:
        idx = stem_lower.rfind("_winter_")
        return image_path.stem[:idx], "Winter"
    return point_id, source


def _ade20k_labels_from_rgb(model, image_rgb):
    """Run DeepLabV3+ like PixelLib (512 pad) and return unpadded label map."""
    w, h = image_rgb.shape[:2]
    ratio = float(TRAINED_IMAGE_WIDTH) / float(np.max([w, h]))
    resized = np.array(
        Image.fromarray(image_rgb.astype("uint8")).resize((int(ratio * h), int(ratio * w)))
    )
    resized = (resized / MEAN_SUBTRACTION_VALUE) - 1.0
    pad_x = int(TRAINED_IMAGE_WIDTH - resized.shape[0])
    pad_y = int(TRAINED_IMAGE_WIDTH - resized.shape[1])
    padded = np.pad(resized, ((0, pad_x), (0, pad_y), (0, 0)), mode="constant")
    pred = model.predict(np.expand_dims(padded, 0), verbose=0)
    labels = np.argmax(pred.squeeze(), -1)
    if pad_x > 0:
        labels = labels[:-pad_x]
    if pad_y > 0:
        labels = labels[:, :-pad_y]
    return labels


def _percentages_from_labels(labels, n_classes=151):
    counts = np.bincount(labels.ravel().astype(np.int64), minlength=n_classes).astype(np.float64)
    if counts.shape[0] < n_classes:
        counts = np.pad(counts, (0, n_classes - counts.shape[0]))
    elif counts.shape[0] > n_classes:
        counts = counts[:n_classes]
    total = float(counts.sum())
    if total <= 0:
        raise ValueError("Empty label map")
    return (counts / total) * 100.0


def _pct_by_name(pcts, name_to_idx, name):
    idx = name_to_idx.get(name)
    if idx is None:
        return 0.0
    return float(pcts[idx])


def _save_segmented_png(image_rgb, labels, out_path, title_text):
    """Fast side-by-side original | colored mask (no matplotlib)."""
    from pixellib.semantic import labelAde20k_to_color_image

    color = labelAde20k_to_color_image(labels)
    color = np.array(
        Image.fromarray(color.astype("uint8")).resize((image_rgb.shape[1], image_rgb.shape[0]))
    )
    # Soft overlay for the right panel (cheaper than PixelLib overlay=True path).
    overlay = cv2.addWeighted(color, 0.7, image_rgb, 0.3, 0)
    left = image_rgb
    right = overlay
    if left.shape[0] != right.shape[0]:
        right = np.array(Image.fromarray(right).resize((right.shape[1], left.shape[0])))
    gap = np.full((left.shape[0], 8, 3), 255, dtype=np.uint8)
    combo = np.concatenate([left, gap, right], axis=1)
    header_h = 36
    canvas = np.full((combo.shape[0] + header_h, combo.shape[1], 3), 255, dtype=np.uint8)
    canvas[header_h:] = combo
    cv2.putText(
        canvas,
        title_text[:120],
        (8, 24),
        cv2.FONT_HERSHEY_SIMPLEX,
        0.55,
        (20, 20, 20),
        1,
        cv2.LINE_AA,
    )
    out_path.parent.mkdir(parents=True, exist_ok=True)
    # RGB -> BGR for cv2.imwrite
    ok = cv2.imwrite(str(out_path), cv2.cvtColor(canvas, cv2.COLOR_RGB2BGR))
    if not ok:
        raise OSError(f"Failed to write segmented PNG: {out_path}")


def _init_worker(model_path, save_segmented, segmented_dir):
    """Load PixelLib/TF model once per process."""
    _patch_keras_for_pixellib()
    gpus = _configure_tf_device()
    from pixellib.semantic import semantic_segmentation, create_ade20k_label_namemap
    import pixellib

    # Remap ADE20K colormap so Plant (class 18) matches Grass vivid emerald green.
    orig_cmap = pixellib.semantic.create_ade20k_label_colormap

    def custom_cmap():
        c = orig_cmap()
        c[18] = [4, 250, 7]
        return c

    pixellib.semantic.create_ade20k_label_colormap = custom_cmap

    seg = semantic_segmentation()
    seg.load_ade20k_model(str(model_path))
    name_map = create_ade20k_label_namemap()
    name_to_idx = {str(v): int(k) for k, v in name_map.items()}

    _WORKER["model"] = seg.model2
    _WORKER["name_map"] = name_map
    _WORKER["name_to_idx"] = name_to_idx
    _WORKER["save_segmented"] = bool(save_segmented)
    _WORKER["segmented_dir"] = Path(segmented_dir) if segmented_dir else None
    _WORKER["has_gpu"] = bool(gpus)
    print(
        f"[worker {os.getpid()}] model ready | GPU devices={len(gpus)}",
        flush=True,
    )


def _process_one(img_path_str):
    """Worker entry: infer one image; return metrics + 151-class rows."""
    img_p = Path(img_path_str)
    fn = img_p.name
    t0 = time.perf_counter()
    try:
        image_rgb = np.array(Image.open(img_p).convert("RGB"))
        labels = _ade20k_labels_from_rgb(_WORKER["model"], image_rgb)
        pcts = _percentages_from_labels(labels, n_classes=151)
        name_to_idx = _WORKER["name_to_idx"]
        name_map = _WORKER["name_map"]

        sky_pct = _pct_by_name(pcts, name_to_idx, "sky")
        tree_pct = _pct_by_name(pcts, name_to_idx, "tree")
        plant_pct = _pct_by_name(pcts, name_to_idx, "plant")
        grass_pct = _pct_by_name(pcts, name_to_idx, "grass")
        building_pct = _pct_by_name(pcts, name_to_idx, "building")
        wall_pct = _pct_by_name(pcts, name_to_idx, "wall")
        ceiling_pct = _pct_by_name(pcts, name_to_idx, "ceiling")

        total_vegetation_pct = round(tree_pct + plant_pct + grass_pct, 4)
        total_builtup_pct = round(building_pct + wall_pct + ceiling_pct, 4)
        combined_gvi = total_vegetation_pct
        if combined_gvi > 100.0:
            raise ValueError(f"Combined GVI exceeds 100%: {combined_gvi}")
        if total_builtup_pct > 100.0:
            raise ValueError(f"Total built-up exceeds 100%: {total_builtup_pct}")
        if not np.isclose(pcts.sum(), 100.0, atol=1e-4):
            raise ValueError(f"151-class percentages sum to {pcts.sum():.6f}, not 100")

        classification = "Green" if combined_gvi >= GREEN_THRESHOLD_PCT else "No-Green"
        source, capture_date, phase_id, point_id, heading = _image_identity(img_p)
        fid, season = _feature_season(img_p, source, point_id)

        if _WORKER["save_segmented"] and _WORKER["segmented_dir"] is not None:
            title = (
                f"Tree:{tree_pct:.1f}% Grass:{grass_pct:.1f}% Plant:{plant_pct:.1f}% | "
                f"GVI:{combined_gvi:.1f}% ({classification})"
            )
            out_img = _WORKER["segmented_dir"] / f"{img_p.stem}_segmented.png"
            _save_segmented_png(image_rgb, labels, out_img, title)

        metrics = {
            "FeatureID": fid,
            "Season": season,
            "Source": source,
            "CaptureDate": capture_date,
            "PhaseID": phase_id,
            "PointID": point_id,
            "Heading": heading,
            "Filename": fn,
            "Sky_%": sky_pct,
            "Tree_%": tree_pct,
            "Plant_%": plant_pct,
            "Grass_%": grass_pct,
            "Total_Vegetation_%": total_vegetation_pct,
            "Building_%": building_pct,
            "Wall_%": wall_pct,
            "Ceiling_%": ceiling_pct,
            "Total_Builtup_%": total_builtup_pct,
            "GVI_%": combined_gvi,
            "Image_Classification": classification,
            "Model": "DeepLabV3+_Xception65_ADE20K",
            "Image_Path": str(img_p),
        }
        class_row = {
            "FeatureID": fid,
            "Season": season,
            "Source": source,
            "Filename": fn,
            "Class_Data_Source": "direct_model_labels",
        }
        class_row.update({name_map[i]: float(pcts[i]) for i in range(151)})

        output_dict = {
            "Sky_Proportion": f"{sky_pct:.4f}%",
            "Tree_Proportion": f"{tree_pct:.4f}%",
            "Plant_Proportion": f"{plant_pct:.4f}%",
            "Grass_Proportion": f"{grass_pct:.4f}%",
            "Total_Vegetation": f"{total_vegetation_pct:.4f}%",
            "Building_Proportion": f"{building_pct:.4f}%",
            "Wall_Proportion": f"{wall_pct:.4f}%",
            "Ceiling_Proportion": f"{ceiling_pct:.4f}%",
            "Total_Builtup": f"{total_builtup_pct:.4f}%",
            "Combined_GVI": f"{combined_gvi:.4f}%",
            "Classification": classification,
        }
        elapsed = time.perf_counter() - t0
        return {
            "ok": True,
            "filename": fn,
            "metrics": metrics,
            "classes": class_row,
            "json": output_dict,
            "seconds": elapsed,
            "pid": os.getpid(),
        }
    except Exception as e:
        return {
            "ok": False,
            "filename": fn,
            "error": f"{type(e).__name__}: {e}",
            "seconds": time.perf_counter() - t0,
            "pid": os.getpid(),
        }


def _collect_files(args, input_dir):
    files = sorted(
        [p for p in input_dir.iterdir() if p.is_file() and p.suffix.lower() in IMAGE_SUFFIXES],
        key=lambda p: p.name.lower(),
    )
    if args.single_image:
        target_name = args.single_image.strip().lower()
        files = [p for p in files if p.name.lower() == target_name]
        if not files:
            raise FileNotFoundError(f"Specified single image not found in {input_dir}: {args.single_image}")
        print(f"Single image mode selected: {files[0].name}")
        return files

    if not args.all_images:
        files = [p for p in files if ("_summer_" in p.stem.lower() or "_winter_" in p.stem.lower())]
    if args.stations:
        target_fids = {s.strip().upper() for s in args.stations.split(",")}

        def get_fid(p):
            stem_l = p.stem.lower()
            for tok in ["_summer_", "_winter_"]:
                if tok in stem_l:
                    return p.stem[: stem_l.rfind(tok)].upper()
            return p.stem.split("_")[0].upper()

        files = [p for p in files if get_fid(p) in target_fids]
        print(f"Selective station filtering active: {len(files)} image(s) selected for stations {args.stations}")
    if args.season:
        season_tok = f"_{args.season.lower()}_"
        files = [p for p in files if season_tok in p.stem.lower()]
        print(f"Selective season filtering active: {len(files)} image(s) selected for season '{args.season}'")
    return files


def main():
    parser = argparse.ArgumentParser(description="Run DeepLabV3+ Xception-65 GVI computation.")
    parser.add_argument("--save-segmented", action="store_true", default=True, help="Save side-by-side original and segmented images (always enabled).")
    parser.add_argument("--single-image", type=str, default=None, help="Process only a single image filename.")
    parser.add_argument("--stations", type=str, default=None, help="Comma-separated station IDs to process and merge into CSV.")
    parser.add_argument("--season", type=str, default=None, choices=["summer", "winter"], help="Filter processing by season (summer or winter).")
    parser.add_argument("--all-images", action="store_true", help="Process all route GSV images, regardless of season tokens.")
    parser.add_argument("--input-dir", type=Path, default=INPUT_DIR, help="Image folder to process.")
    parser.add_argument("--output-csv", type=Path, default=OUTPUT_CSV, help="Metrics CSV output path.")
    parser.add_argument("--output-json", type=Path, default=OUTPUT_JSON, help="Metrics JSON output path.")
    parser.add_argument("--classes-csv", type=Path, default=CLASSES_CSV, help="Full 151 ADE20K class CSV output path.")
    parser.add_argument("--segmented-dir", type=Path, default=SEGMENTED_DIR, help="Optional segmented-image output folder.")
    parser.add_argument(
        "--workers",
        type=int,
        default=3,
        help="Parallel process workers (default 3). Each worker loads its own TF model.",
    )
    args = parser.parse_args()
    input_dir = args.input_dir
    output_csv = args.output_csv
    output_json = args.output_json
    classes_csv = args.classes_csv
    segmented_dir = args.segmented_dir
    workers = max(1, int(args.workers))

    print("=" * 80)
    print("XCEPTION (DEEPLABV3+ XCEPTION-65) GVI CALCULATION PIPELINE")
    print("Based on: biking_photos_original unedited.ipynb")
    print("=" * 80)

    _patch_keras_for_pixellib()
    try:
        import tensorflow as tf
        from pixellib.semantic import semantic_segmentation  # noqa: F401
    except ImportError as e:
        raise SystemExit(
            "PixelLib/TensorFlow is unavailable. Run this script with the environment "
            "containing the colleague notebook's PixelLib dependencies."
        ) from e

    gpus = _configure_tf_device()
    print(f"TensorFlow {tf.__version__} | physical GPUs: {gpus if gpus else 'NONE (CPU)'}", flush=True)
    if not gpus:
        print(
            "NOTE: This TF build has no GPU on native Windows. "
            f"Using {workers} CPU process worker(s) for throughput.",
            flush=True,
        )
    elif workers > 1:
        print(
            f"WARNING: {workers} GPU workers on one GPU may OOM; "
            "workers will use memory growth and may need --workers 1 or 2.",
            flush=True,
        )

    download_model_if_needed()

    if not input_dir.is_dir():
        raise FileNotFoundError(f"Input image directory does not exist: {input_dir}")

    files = _collect_files(args, input_dir)
    if not files:
        raise FileNotFoundError(f"No valid image files found in: {input_dir}")
    print(f"Total images to process: {len(files)}")
    print(f"Workers: {workers} | save_segmented={args.save_segmented} | classes_csv={classes_csv}")
    if args.save_segmented:
        segmented_dir.mkdir(parents=True, exist_ok=True)
        print(f"Segmented PNGs -> {segmented_dir}")

    output_dict = {}
    rows = []
    class_rows = []
    errors = []
    timings = []
    t_run0 = time.perf_counter()

    # Warm the parent import path; each worker reloads the model in initializer.
    initargs = (str(MODEL_PATH), bool(args.save_segmented), str(segmented_dir))
    paths = [str(p) for p in files]

    if workers == 1:
        _init_worker(*initargs)
        done_count = 0
        for path in paths:
            done_count += 1
            result = _process_one(path)
            _handle_result(result, done_count, len(files), rows, class_rows, output_dict, errors, timings)
    else:
        # On Windows, spawn requires the guard in __main__ (present below).
        with ProcessPoolExecutor(
            max_workers=workers,
            initializer=_init_worker,
            initargs=initargs,
        ) as ex:
            future_map = {ex.submit(_process_one, p): p for p in paths}
            done_count = 0
            for fut in as_completed(future_map):
                done_count += 1
                try:
                    result = fut.result()
                except Exception as e:
                    fn = Path(future_map[fut]).name
                    result = {
                        "ok": False,
                        "filename": fn,
                        "error": f"{type(e).__name__}: {e}",
                        "seconds": 0.0,
                        "pid": -1,
                    }
                _handle_result(result, done_count, len(files), rows, class_rows, output_dict, errors, timings)

    wall = time.perf_counter() - t_run0
    if timings:
        mean_s = float(np.mean(timings))
        print(
            f"\nTiming: wall={wall:.1f}s for {len(timings)} images | "
            f"mean worker s/image={mean_s:.1f}s | "
            f"effective wall s/image={wall / max(len(timings), 1):.1f}s",
            flush=True,
        )

    # Never publish a partial dataset: a missing image would change station-level
    # summer/winter comparisons while leaving a superficially valid CSV behind.
    if errors:
        details = "; ".join(f"{e['Filename']}: {e['Error']}" for e in errors)
        raise RuntimeError(f"{len(errors)} image(s) failed; no CSV/JSON outputs were written. {details}")

    if args.single_image:
        print(f"\nSingle image execution complete for {args.single_image}. Metrics not overwriting batch CSV.")
        return

    # Stable order for outputs
    rows.sort(key=lambda r: (str(r.get("FeatureID", "")), str(r.get("Season", "")), str(r.get("Filename", ""))))
    class_rows.sort(key=lambda r: (str(r.get("FeatureID", "")), str(r.get("Season", "")), str(r.get("Filename", ""))))

    if args.stations or args.season:
        print(f"\nMerging results into canonical metrics CSV...")
        if output_csv.exists():
            df_existing = pd.read_csv(output_csv)
            # Purge any legacy _2 records
            df_existing = df_existing[~df_existing["FeatureID"].str.contains("_2", case=False, na=False)]
            if args.stations and not args.season:
                target_fids = {s.strip().upper() for s in args.stations.split(",")}
                df_existing = df_existing[~df_existing["FeatureID"].str.upper().isin(target_fids)]
            elif args.season and not args.stations:
                df_existing = df_existing[df_existing["Season"].str.lower() != args.season.lower()]
            elif args.stations and args.season:
                target_fids = {s.strip().upper() for s in args.stations.split(",")}
                df_existing = df_existing[
                    ~(
                        df_existing["FeatureID"].str.upper().isin(target_fids)
                        & (df_existing["Season"].str.lower() == args.season.lower())
                    )
                ]
            df_out = pd.concat([df_existing, pd.DataFrame(rows)], ignore_index=True)
        else:
            df_out = pd.DataFrame(rows)
        if df_out["Filename"].duplicated().any():
            raise ValueError("Duplicate Filename results detected in merged output")
        df_out["Filename"] = df_out["Filename"].str.replace(".JPG", ".jpg", regex=False)
        df_out["Image_Path"] = df_out["Image_Path"].str.replace(".JPG", ".jpg", regex=False)
        df_out = df_out.sort_values(by=["FeatureID", "Season"]).reset_index(drop=True)
        output_csv.parent.mkdir(parents=True, exist_ok=True)
        df_out.to_csv(output_csv, index=False)
        print(f"Saved merged CSV metrics ({len(df_out)} rows) to: {output_csv}")
    else:
        # Save outputs
        df_out = pd.DataFrame(rows)
        if df_out["Filename"].duplicated().any():
            raise ValueError("Duplicate Filename results detected")
        df_out["Filename"] = df_out["Filename"].str.replace(".JPG", ".jpg", regex=False)
        df_out["Image_Path"] = df_out["Image_Path"].str.replace(".JPG", ".jpg", regex=False)
        df_out = df_out.sort_values(by=["FeatureID", "Season"]).reset_index(drop=True)
        output_csv.parent.mkdir(parents=True, exist_ok=True)
        df_out.to_csv(output_csv, index=False)
        print(f"\nSaved CSV metrics to: {output_csv}")

    # Full 151-class table (CamUp-style: all labels, sum ~100).
    df_cls = pd.DataFrame(class_rows)
    if df_cls["Filename"].duplicated().any():
        raise ValueError("Duplicate Filename in 151-class export")
    label_cols = [c for c in df_cls.columns if c not in {"FeatureID", "Season", "Source", "Filename", "Class_Data_Source"}]
    if len(label_cols) != 151:
        raise ValueError(f"Expected 151 class columns, got {len(label_cols)}")
    if not np.allclose(df_cls[label_cols].sum(axis=1), 100.0, atol=1e-3):
        raise ValueError("151-class rows do not sum to ~100%")
    classes_csv.parent.mkdir(parents=True, exist_ok=True)
    tmp_cls = classes_csv.with_suffix(".tmp.csv")
    df_cls.to_csv(tmp_cls, index=False)
    os.replace(tmp_cls, classes_csv)
    print(f"Saved 151-class CSV ({len(df_cls)} rows) to: {classes_csv}")

    if output_json.exists():
        try:
            with open(output_json, "r", encoding="utf-8") as jf:
                full_json = json.load(jf)
        except Exception:
            full_json = {}
        # Remove any _2 keys
        full_json = {k: v for k, v in full_json.items() if "_2" not in k}
        full_json.update(output_dict)
    else:
        full_json = output_dict

    output_json.parent.mkdir(parents=True, exist_ok=True)
    with open(output_json, "w", encoding="utf-8") as jf:
        json.dump(full_json, jf, indent=4)
    print(f"Saved JSON dictionary to: {output_json}")

    # The seasonal comparison applies only to unique station-season records.
    if {"Summer", "Winter"}.issubset(set(df_out["Season"])) and not df_out.duplicated(["FeatureID", "Season"]).any():
        piv = df_out.pivot(index="FeatureID", columns="Season", values="GVI_%")
        piv["Diff_Summer_minus_Winter"] = piv["Summer"] - piv["Winter"]
        piv["Inversion_Summer_lt_Winter"] = piv["Summer"] < piv["Winter"]
        piv["Summer_lt_10_and_Winter_gt_10"] = (piv["Summer"] < 10.0) & (piv["Winter"] > 10.0)
        print("\n" + "=" * 80)
        print("XCEPTION STATION-LEVEL COMPARISON SUMMARY (18 STATIONS):")
        print("=" * 80)
        print(piv.to_string())
        print("=" * 80)
        inversions = piv[piv["Inversion_Summer_lt_Winter"]]
        print(f"\nTotal stations where Summer < Winter: {len(inversions)}")
        crossing = piv[piv["Summer_lt_10_and_Winter_gt_10"]]
        print(f"Total stations where Summer < 10% AND Winter > 10%: {len(crossing)}")
        if len(crossing) > 0:
            print("ALERT: Stations crossing 10% threshold in inverted direction:")
            print(crossing.to_string())
    print("=" * 80)


def _handle_result(result, done_count, total, rows, class_rows, output_dict, errors, timings):
    fn = result["filename"]
    sec = float(result.get("seconds", 0.0))
    timings.append(sec)
    if result.get("ok"):
        rows.append(result["metrics"])
        class_rows.append(result["classes"])
        output_dict[fn] = result["json"]
        m = result["metrics"]
        print(
            f"[{done_count:03d}/{total:03d}] pid={result.get('pid')} {sec:.1f}s  {fn}  "
            f"Sky={m['Sky_%']:.2f} Tree={m['Tree_%']:.2f} Plant={m['Plant_%']:.2f} "
            f"Grass={m['Grass_%']:.2f} GVI={m['GVI_%']:.2f}% ({m['Image_Classification']})",
            flush=True,
        )
    else:
        errors.append({"Filename": fn, "Error": result.get("error", "unknown")})
        print(f"[{done_count:03d}/{total:03d}] ERROR {fn}: {result.get('error')}", flush=True)


if __name__ == "__main__":
    # Required for Windows ProcessPoolExecutor spawn.
    main()

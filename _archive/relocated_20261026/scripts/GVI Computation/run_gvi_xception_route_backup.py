"""
run_gvi_xception.py
===================
Standalone Python script based on:
"C:\\Users\\pandya\\OneDrive - UCL\\Data shared\\Response 30Mar\\Paper2_Revision\\final gvi\\biking_photos_original unedited.ipynb"

This script executes the DeepLabV3+ model with Xception-65 backbone on ADE20K:
- Target model: deeplabv3_xception65_ade20k.h5
- Target categories: 'tree' (index 4), 'grass' (index 8/9), 'plant' (index 10/17)
- Computes Tree %, Grass %, Plant %, and Combined GVI %
- Compatible with TensorFlow 2.x via automatic Keras layer patching
"""

import os
import sys
import json
import argparse
import urllib.request
from pathlib import Path

import numpy as np
import pandas as pd
from PIL import Image
import matplotlib.pyplot as plt

# Keep TensorFlow logging quiet without changing the model or its predictions.
os.environ.setdefault("TF_CPP_MIN_LOG_LEVEL", "3")

# 1. Automatic compatibility patch for pixellib on modern TensorFlow
try:
    import tensorflow as tf  # noqa: F401
    # Patch tensorflow.python.keras if missing in modern TF
    import tensorflow.keras.layers as keras_layers
    import sys
    class DummyModule:
        pass
    if 'tensorflow.python.keras.layers' not in sys.modules:
        dummy = DummyModule()
        for attr in dir(keras_layers):
            setattr(dummy, attr, getattr(keras_layers, attr))
        sys.modules['tensorflow.python.keras.layers'] = dummy
except ImportError:
    pass

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
IMAGE_SUFFIXES = {".jpg", ".jpeg", ".png"}
GREEN_THRESHOLD_PCT = 10.0

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

def main():
    parser = argparse.ArgumentParser(description="Run DeepLabV3+ Xception-65 GVI computation.")
    parser.add_argument("--save-segmented", action="store_true", help="Save side-by-side original and segmented images.")
    parser.add_argument("--single-image", type=str, default=None, help="Process only a single image filename.")
    parser.add_argument("--stations", type=str, default=None, help="Comma-separated station IDs to process and merge into CSV.")
    parser.add_argument("--season", type=str, default=None, choices=["summer", "winter"], help="Filter processing by season (summer or winter).")
    parser.add_argument("--all-images", action="store_true", help="Process all route GSV images, regardless of season tokens.")
    parser.add_argument("--input-dir", type=Path, default=INPUT_DIR, help="Image folder to process.")
    parser.add_argument("--output-csv", type=Path, default=OUTPUT_CSV, help="Metrics CSV output path.")
    parser.add_argument("--output-json", type=Path, default=OUTPUT_JSON, help="Metrics JSON output path.")
    parser.add_argument("--segmented-dir", type=Path, default=SEGMENTED_DIR, help="Optional segmented-image output folder.")
    args = parser.parse_args()
    input_dir = args.input_dir
    output_csv = args.output_csv
    output_json = args.output_json
    segmented_dir = args.segmented_dir

    print("=" * 80)
    print("XCEPTION (DEEPLABV3+ XCEPTION-65) GVI CALCULATION PIPELINE")
    print("Based on: biking_photos_original unedited.ipynb")
    print("=" * 80)

    try:
        import pixellib
        from pixellib.semantic import semantic_segmentation
    except ImportError as e:
        raise SystemExit(
            "PixelLib/TensorFlow is unavailable. Run this script with the environment "
            "containing the colleague notebook's PixelLib dependencies."
        ) from e

    download_model_if_needed()

    if not input_dir.is_dir():
        raise FileNotFoundError(f"Input image directory does not exist: {input_dir}")

    print("\nInitializing PixelLib semantic segmentation model (Xception-65 ADE20K)...")
    segment_image = semantic_segmentation()
    segment_image.load_ade20k_model(str(MODEL_PATH))
    print("Model loaded successfully.\n")

    # Remap ADE20K colormap so Plant (class 18) matches Grass (class 10) vivid emerald green:
    orig_cmap = pixellib.semantic.create_ade20k_label_colormap
    def custom_cmap():
        c = orig_cmap()
        c[18] = [4, 250, 7]
        return c
    pixellib.semantic.create_ade20k_label_colormap = custom_cmap

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
    else:
        if not args.all_images:
            files = [p for p in files if ("_summer_" in p.stem.lower() or "_winter_" in p.stem.lower())]
        if args.stations:
            target_fids = {s.strip().upper() for s in args.stations.split(",")}
            def get_fid(p):
                stem_l = p.stem.lower()
                for tok in ["_summer_", "_winter_"]:
                    if tok in stem_l:
                        return p.stem[:stem_l.rfind(tok)].upper()
                return p.stem.split('_')[0].upper()
            files = [p for p in files if get_fid(p) in target_fids]
            print(f"Selective station filtering active: {len(files)} image(s) selected for stations {args.stations}")
        if args.season:
            season_tok = f"_{args.season.lower()}_"
            files = [p for p in files if season_tok in p.stem.lower()]
            print(f"Selective season filtering active: {len(files)} image(s) selected for season '{args.season}'")
    if not files:
        raise FileNotFoundError(f"No valid image files found in: {input_dir}")
    print(f"Total images to process: {len(files)}")

    output_dict = {}
    rows = []
    errors = []

    for idx, img_p in enumerate(files, 1):
        fn = img_p.name
        print(f"[{idx:02d}/{len(files):02d}] Processing: {fn}", flush=True)

        try:
            # Segment image using ADE20K Xception
            segmap, output = segment_image.segmentAsAde20k(str(img_p), overlay=True)

            class_names = list(segmap.get('class_names', []))
            ratios = list(segmap.get('ratios', []))

            tree_pct = _class_ratio_percent(class_names, ratios, "tree")
            grass_pct = _class_ratio_percent(class_names, ratios, "grass")
            plant_pct = _class_ratio_percent(class_names, ratios, "plant")

            combined_gvi = round(tree_pct + grass_pct + plant_pct, 4)
            if combined_gvi > 100.0:
                raise ValueError(f"Combined GVI exceeds 100%: {combined_gvi}")
            classification = "Green" if combined_gvi >= GREEN_THRESHOLD_PCT else "No-Green"

            print(f"    Tree: {tree_pct:.4f}%, Grass: {grass_pct:.4f}%, Plant: {plant_pct:.4f}% => GVI: {combined_gvi:.4f}% ({classification})")

            if args.save_segmented:
                segmented_dir.mkdir(parents=True, exist_ok=True)
                fig, axes = plt.subplots(1, 2, figsize=(16, 6))
                raw_img = Image.open(img_p).convert("RGB")
                axes[0].imshow(np.array(raw_img))
                axes[0].set_title(f"Original Image: {fn}", fontsize=12)
                axes[0].axis("off")

                axes[1].imshow(output)
                axes[1].set_title(f"Tree: {tree_pct:.2f}%, Grass: {grass_pct:.2f}%, Plant: {plant_pct:.2f}% | GVI: {combined_gvi:.2f}% ({classification})", fontsize=12)
                axes[1].axis("off")

                plt.tight_layout()
                out_img_path = segmented_dir / f"{img_p.stem}_segmented.png"
                plt.savefig(out_img_path, bbox_inches="tight", dpi=150)
                plt.close()
                print(f"    Saved side-by-side segmentation to: {out_img_path}")

            output_dict[fn] = {
                'Tree_Proportion': f'{tree_pct:.4f}%',
                'Grass_Proportion': f'{grass_pct:.4f}%',
                'Plant_Proportion': f'{plant_pct:.4f}%',
                'Combined_GVI': f'{combined_gvi:.4f}%',
                'Classification': classification
            }

            source, capture_date, phase_id, point_id, heading = _image_identity(img_p)
            stem_lower = img_p.stem.lower()
            if "_summer_" in stem_lower:
                idx = stem_lower.rfind("_summer_")
                fid = img_p.stem[:idx]
                season = "Summer"
            elif "_winter_" in stem_lower:
                idx = stem_lower.rfind("_winter_")
                fid = img_p.stem[:idx]
                season = "Winter"
            else:
                fid = point_id
                season = source

            rows.append({
                'FeatureID': fid,
                'Season': season,
                'Source': source,
                'CaptureDate': capture_date,
                'PhaseID': phase_id,
                'PointID': point_id,
                'Heading': heading,
                'Filename': fn,
                'Tree_%': tree_pct,
                'Grass_%': grass_pct,
                'Plant_%': plant_pct,
                'GVI_%': combined_gvi,
                'Image_Classification': classification,
                'Model': 'DeepLabV3+_Xception65_ADE20K',
                'Image_Path': str(img_p)
            })

        except Exception as e:
            errors.append({"Filename": fn, "Error": f"{type(e).__name__}: {e}"})
            print(f"    Error processing {fn}: {e}", flush=True)

    # Never publish a partial dataset: a missing image would change station-level
    # summer/winter comparisons while leaving a superficially valid CSV behind.
    if errors:
        details = "; ".join(f"{e['Filename']}: {e['Error']}" for e in errors)
        raise RuntimeError(f"{len(errors)} image(s) failed; no CSV/JSON outputs were written. {details}")

    if args.single_image:
        print(f"\nSingle image execution complete for {args.single_image}. Metrics not overwriting batch CSV.")
        return

    if args.stations or args.season:
        print(f"\nMerging results into canonical metrics CSV...")
        if output_csv.exists():
            df_existing = pd.read_csv(output_csv)
            # Purge any legacy _2 records
            df_existing = df_existing[~df_existing['FeatureID'].str.contains('_2', case=False, na=False)]
            if args.stations and not args.season:
                target_fids = {s.strip().upper() for s in args.stations.split(",")}
                df_existing = df_existing[~df_existing['FeatureID'].str.upper().isin(target_fids)]
            elif args.season and not args.stations:
                df_existing = df_existing[df_existing['Season'].str.lower() != args.season.lower()]
            elif args.stations and args.season:
                target_fids = {s.strip().upper() for s in args.stations.split(",")}
                df_existing = df_existing[~(df_existing['FeatureID'].str.upper().isin(target_fids) & (df_existing['Season'].str.lower() == args.season.lower()))]
            df_out = pd.concat([df_existing, pd.DataFrame(rows)], ignore_index=True)
        else:
            df_out = pd.DataFrame(rows)
        if df_out['Filename'].duplicated().any():
            raise ValueError("Duplicate Filename results detected in merged output")
        df_out['Filename'] = df_out['Filename'].str.replace('.JPG', '.jpg', regex=False)
        df_out['Image_Path'] = df_out['Image_Path'].str.replace('.JPG', '.jpg', regex=False)
        df_out = df_out.sort_values(by=['FeatureID', 'Season']).reset_index(drop=True)
        output_csv.parent.mkdir(parents=True, exist_ok=True)
        df_out.to_csv(output_csv, index=False)
        print(f"Saved merged CSV metrics ({len(df_out)} rows) to: {output_csv}")
    else:
        # Save outputs
        df_out = pd.DataFrame(rows)
        if df_out['Filename'].duplicated().any():
            raise ValueError("Duplicate Filename results detected")
        df_out['Filename'] = df_out['Filename'].str.replace('.JPG', '.jpg', regex=False)
        df_out['Image_Path'] = df_out['Image_Path'].str.replace('.JPG', '.jpg', regex=False)
        df_out = df_out.sort_values(by=['FeatureID', 'Season']).reset_index(drop=True)
        output_csv.parent.mkdir(parents=True, exist_ok=True)
        df_out.to_csv(output_csv, index=False)
        print(f"\nSaved CSV metrics to: {output_csv}")

    if output_json.exists():
        try:
            with open(output_json, 'r', encoding='utf-8') as jf:
                full_json = json.load(jf)
        except Exception:
            full_json = {}
        # Remove any _2 keys
        full_json = {k: v for k, v in full_json.items() if "_2" not in k}
        full_json.update(output_dict)
    else:
        full_json = output_dict

    output_json.parent.mkdir(parents=True, exist_ok=True)
    with open(output_json, 'w', encoding='utf-8') as jf:
        json.dump(full_json, jf, indent=4)
    print(f"Saved JSON dictionary to: {output_json}")

    # Summary pivot table
    piv = df_out.pivot(index='FeatureID', columns='Season', values='GVI_%')
    if 'Summer' in piv.columns and 'Winter' in piv.columns:
        piv['Diff_Summer_minus_Winter'] = piv['Summer'] - piv['Winter']
        piv['Inversion_Summer_lt_Winter'] = piv['Summer'] < piv['Winter']
        piv['Summer_lt_10_and_Winter_gt_10'] = (piv['Summer'] < 10.0) & (piv['Winter'] > 10.0)
        print("\n" + "=" * 80)
        print("XCEPTION STATION-LEVEL COMPARISON SUMMARY (18 STATIONS):")
        print("=" * 80)
        print(piv.to_string())
        print("=" * 80)
        inversions = piv[piv['Inversion_Summer_lt_Winter']]
        print(f"\nTotal stations where Summer < Winter: {len(inversions)}")
        crossing = piv[piv['Summer_lt_10_and_Winter_gt_10']]
        print(f"Total stations where Summer < 10% AND Winter > 10%: {len(crossing)}")
        if len(crossing) > 0:
            print("ALERT: Stations crossing 10% threshold in inverted direction:")
            print(crossing.to_string())
    print("=" * 80)

if __name__ == "__main__":
    main()

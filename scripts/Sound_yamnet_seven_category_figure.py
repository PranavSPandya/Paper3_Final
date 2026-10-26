"""Five-panel sound segment figure for Paper 3 (Welch + YAMNet type).

Panel 1: waveform at original sample rate (Welch input)
Panel 2: Welch PSD with Di broad-band shading (freq_proportion_*)
Panel 3: YAMNet log-mel spectrogram (16 kHz)
Panel 4: heatmap patch × seven researcher categories (per-patch class sums)
Panel 5: row-level *_score and *_proportion bars (same rollup as the notebook)

Example:
  python scripts/Sound_yamnet_seven_category_figure.py --wav "path/to/phase.wav" --seconds 10
"""
from __future__ import annotations

import argparse
import csv
import io
import math
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import soundfile as sf
import tensorflow as tf
import tensorflow_hub as hub
from scipy.integrate import trapezoid
from scipy.signal import resample_poly, welch

YAMNET_SR = 16_000
PATCH_WINDOW_S = 0.96
PATCH_HOP_S = 0.48
AUDIO_MIN_HZ = 20.0
AUDIO_MAX_HZ = 20_000.0
DETECTION_THRESHOLD = 0.20

DI_BROAD_BANDS = (
    ("20–200 Hz", 20.0, 200.0, "#9467bd"),
    ("200–2000 Hz", 200.0, 2000.0, "#2ca02c"),
    ("2000–20000 Hz", 2000.0, 20_000.0, "#ff7f0e"),
)

RESEARCHER_CATEGORIES = {
    "Wind": "Wind|Wind noise (microphone)|Howl|Whoosh, swoosh, swish|Gust of wind|Blowing (wind)|Storm|Hurricane|Tornado".split(
        "|"
    ),
    "Rural/Natural": "Outside, rural or natural|Forest|Bird|Bird vocalization, bird call, bird song|Chirp, tweet|Coo|Crow|Insect|Cricket|Bee, wasp, etc.|Frog|Nature sounds|Stream|Water|Rain|Thunderstorm|Thunder|Ocean|Waves, surf|Animal|Livestock, farm animals, working animals|Horse|Cattle, bovinae|Sheep|Goat|Pig|Chicken, rooster|Dog|Cat|Wild animals|Wolf|Bird flight, flapping wings".split(
        "|"
    ),
    "Vehicle": "Vehicle|Motor vehicle (road)|Car|Car passing by|Truck|Bus|Motorcycle|Emergency vehicle|Siren|Police car (siren)|Ambulance (siren)|Fire engine, fire truck (siren)|Aircraft|Airplane|Helicopter|Train|Rail transport|Train horn|Subway, metro, underground|Boat, Water vehicle|Ship|Motorboat, speedboat|Engine|Engine starting|Idling|Accelerating, revving, vroom|Car alarm|Vehicle horn, car horn, honking".split(
        "|"
    ),
    "Urban/Manmade_neutral": "Outside, urban or manmade|City|Urban|Footsteps|Walking|Running|Skateboard|Bicycle".split("|"),
    "Urban/Manmade_positive": "Crowd|Cheering|Applause|Chatter|Conversation|Speech|Human voice|Street music|Busker|Music".split(
        "|"
    ),
    "Urban/Manmade_negative": "Traffic noise, roadway noise|Construction site|Jackhammer|Bulldozer|Excavator|Drilling|Hammering|Sawing|Power tool|Chainsaw|Siren|Emergency vehicle|Industrial noise|Factory|Machinery|Air conditioning".split(
        "|"
    ),
    "Mechanisms": "Mechanisms|Tools|Hammer|Hammering|Wood|Sawing|Filing (rasp)|Sanding|Power tool|Drill|Jackhammer|Chainsaw|Medium engine (mid frequency)|Light engine (high frequency)|Heavy engine (low frequency)|Engine knocking|Engine starting|Idling|Accelerating, revving, vroom|Door|Sliding door|Slam|Knock|Tap|Squeak|Creak|Ratchet, pawl|Clock|Tick|Ticking|Mechanical fan|Air conditioning|Microwave oven|Blender|Water tap, faucet|Flush|Zipper (clothing)|Keys jangling|Coin (dropping)|Scissors|Electric shaver, electric razor|Lawn mower|Printing|Typewriter|Keyboard (typing)".split(
        "|"
    ),
}

CATEGORY_ORDER = list(RESEARCHER_CATEGORIES.keys())


def load_class_names(model) -> list[str]:
    class_map_path = model.class_map_path().numpy().decode("utf-8")
    with tf.io.gfile.GFile(class_map_path, "r") as handle:
        rows = list(csv.reader(io.StringIO(handle.read())))
    names = [row[2] for row in rows if len(row) >= 3 and row[0] != "index"]
    if len(names) != 521:
        raise RuntimeError(f"Expected 521 YAMNet classes, got {len(names)}")
    return names


def to_mono(waveform: np.ndarray) -> np.ndarray:
    data = np.asarray(waveform, dtype=np.float32)
    if data.ndim == 2:
        data = data[:, 0]
    return np.clip(data, -1.0, 1.0)


def to_mono_16k(waveform: np.ndarray, sr: int) -> np.ndarray:
    data = to_mono(waveform)
    if sr == YAMNET_SR:
        return data
    g = math.gcd(int(sr), YAMNET_SR)
    return resample_poly(data, YAMNET_SR // g, int(sr) // g).astype(np.float32)


def category_indices(class_names: list[str]) -> dict[str, np.ndarray]:
    mapping: dict[str, np.ndarray] = {}
    for category, labels in RESEARCHER_CATEGORIES.items():
        label_set = set(labels)
        idx = np.array([i for i, name in enumerate(class_names) if name in label_set], dtype=int)
        if idx.size == 0:
            raise RuntimeError(f"No YAMNet labels matched category {category}")
        mapping[category] = idx
    return mapping


def patch_category_matrix(frame_scores: np.ndarray, cat_idx: dict[str, np.ndarray]) -> np.ndarray:
    rows = []
    for category in CATEGORY_ORDER:
        idx = cat_idx[category]
        rows.append(frame_scores[:, idx].sum(axis=1))
    return np.stack(rows, axis=1)


def _integrate_psd(freqs: np.ndarray, psd: np.ndarray, low: float, high: float) -> float:
    interior = freqs[(freqs > low) & (freqs < high)]
    grid = np.concatenate(([low], interior, [high]))
    return float(trapezoid(np.interp(grid, freqs, psd), grid))


def welch_psd(segment: np.ndarray, sr: int) -> tuple[np.ndarray, np.ndarray, dict[str, float]]:
    """Match notebook spectral_features Welch branch (Di proportions only)."""
    props = {label: float("nan") for label, _, _, _ in DI_BROAD_BANDS}
    max_hz = min(AUDIO_MAX_HZ, sr / 2.0)
    if segment.size < max(32, int(0.25 * sr)) or max_hz <= AUDIO_MIN_HZ or not np.any(np.abs(segment) > 0):
        return np.array([]), np.array([]), props

    nperseg = min(len(segment), max(1024, int(sr)))
    freqs, psd = welch(
        segment.astype(np.float64),
        fs=float(sr),
        window="hann",
        nperseg=nperseg,
        noverlap=nperseg // 2,
        detrend="constant",
        scaling="density",
    )
    valid = (freqs >= AUDIO_MIN_HZ) & (freqs <= max_hz) & np.isfinite(psd)
    f, p = freqs[valid], psd[valid]
    if f.size < 2 or not np.any(p > 0):
        return np.array([]), np.array([]), props

    total = float(trapezoid(p, f))
    if not np.isfinite(total) or total <= 0:
        return f, p, props

    for label, low, high, _ in DI_BROAD_BANDS:
        if high <= max_hz and low >= AUDIO_MIN_HZ:
            e = _integrate_psd(f, p, low, high)
            props[label] = float(e / total) if np.isfinite(e) else float("nan")
    return f, p, props


def rollup_row_metrics(
    frame_scores: np.ndarray,
    class_names: list[str],
    threshold: float = DETECTION_THRESHOLD,
) -> tuple[dict[str, float], dict[str, float], str]:
    """Same logic as classify_researcher_category in the YAMNet notebook."""
    class_means = frame_scores.mean(axis=0)
    category_scores: dict[str, float] = {}
    category_proportions: dict[str, float] = {c: 0.0 for c in CATEGORY_ORDER}
    category_proportions["Unidentify"] = 0.0
    any_match = np.zeros(frame_scores.shape[0], dtype=bool)

    for category, labels in RESEARCHER_CATEGORIES.items():
        label_set = set(labels)
        indices = [i for i, label in enumerate(class_names) if label in label_set]
        category_scores[category] = float(class_means[indices].sum())
        if indices:
            active = np.any(frame_scores[:, indices] >= threshold, axis=1)
            category_proportions[category] = float(active.mean())
            any_match |= active

    best = max(category_scores, key=category_scores.get)
    if category_scores[best] < threshold or category_scores[best] == 0:
        best = "Unidentify"
    category_proportions["Unidentify"] = float((~any_match).mean())
    return category_scores, category_proportions, best


def main() -> None:
    parser = argparse.ArgumentParser(description="Paper 3 Welch + YAMNet 7-category segment figure")
    parser.add_argument("--wav", type=Path, required=True, help="Input WAV (mono or stereo)")
    parser.add_argument("--seconds", type=float, default=10.0, help="Segment length from start (default 10 s)")
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("output/Sound_ucm/Paper3_sound_segment_welch_and_categories.png"),
        help="Output PNG path",
    )
    args = parser.parse_args()

    wav_path = args.wav.expanduser().resolve()
    if not wav_path.is_file():
        raise FileNotFoundError(wav_path)

    audio, sr = sf.read(str(wav_path), always_2d=False)
    n_samples = int(min(len(audio), max(1, args.seconds) * sr))
    segment = to_mono(np.asarray(audio[:n_samples]))
    seg16 = to_mono_16k(segment, int(sr))

    freqs, psd, di_props = welch_psd(segment, int(sr))

    model = hub.load("https://tfhub.dev/google/yamnet/1")
    class_names = load_class_names(model)
    cat_idx = category_indices(class_names)

    scores, _, spectrogram = model(tf.constant(seg16, dtype=tf.float32))
    frame_scores = np.asarray(scores.numpy(), dtype=np.float64)
    spec = np.asarray(spectrogram.numpy(), dtype=np.float64)
    cat_patch = patch_category_matrix(frame_scores, cat_idx)
    row_scores, row_props, category = rollup_row_metrics(frame_scores, class_names)

    fig = plt.figure(figsize=(11, 12))
    fig.suptitle(
        "Paper 3 — one segment: Welch frequency (§4) + YAMNet type (§3)\n"
        f"{wav_path.name} — first {n_samples / sr:.1f} s @ {sr} Hz | "
        f"row category = {category}",
        fontsize=11,
    )

    t_orig = np.arange(len(segment)) / sr
    ax1 = fig.add_subplot(5, 1, 1)
    ax1.plot(t_orig, segment, color="C0", linewidth=0.6)
    ax1.set_ylabel("Amplitude")
    ax1.set_xlabel("Time (s)")
    ax1.set_title("1. Waveform (original SR — Welch PSD uses this, not the 16 kHz resample)")

    ax2 = fig.add_subplot(5, 1, 2)
    if freqs.size:
        ymax = float(np.max(psd))
        for label, low, high, color in DI_BROAD_BANDS:
            ax2.axvspan(low, min(high, freqs[-1]), alpha=0.15, color=color, label=label)
        ax2.semilogy(freqs, psd + 1e-20, color="k", linewidth=0.8)
        ax2.set_xlim(AUDIO_MIN_HZ, min(AUDIO_MAX_HZ, sr / 2.0))
        ax2.set_ylabel("PSD")
        parts = [f"{label} {di_props[label]:.2f}" for label, _, _, _ in DI_BROAD_BANDS if np.isfinite(di_props[label])]
        ax2.set_title("2. Welch PSD — shaded Di bands → freq_proportion_*  (" + ", ".join(parts) + ")")
        ax2.legend(loc="upper right", fontsize=7)
    else:
        ax2.set_title("2. Welch PSD (insufficient signal)")

    ax3 = fig.add_subplot(5, 1, 3)
    ax3.imshow(spec.T, aspect="auto", origin="lower", interpolation="nearest")
    ax3.set_ylabel("Mel band")
    ax3.set_title("3. Log-mel spectrogram (YAMNet internal — type branch only)")

    ax4 = fig.add_subplot(5, 1, 4)
    im = ax4.imshow(
        cat_patch.T,
        aspect="auto",
        origin="lower",
        interpolation="nearest",
        cmap="gray_r",
        vmin=0.0,
        vmax=max(0.5, float(np.percentile(cat_patch, 99))),
    )
    patch_padding = (PATCH_WINDOW_S / 2) / PATCH_HOP_S
    ax4.set_xlim(-patch_padding - 0.5, cat_patch.shape[0] + patch_padding - 0.5)
    ax4.set_yticks(range(len(CATEGORY_ORDER)))
    ax4.set_yticklabels(CATEGORY_ORDER, fontsize=8)
    ax4.set_xlabel("YAMNet patch index")
    ax4.set_title("4. Per-patch summed class score within each of the 7 researcher categories")
    fig.colorbar(im, ax=ax4, fraction=0.02, pad=0.02, label="Summed score")

    ax5 = fig.add_subplot(5, 1, 5)
    y_pos = np.arange(len(CATEGORY_ORDER))
    score_vals = [row_scores[c] for c in CATEGORY_ORDER]
    prop_vals = [row_props[c] for c in CATEGORY_ORDER]
    ax5.barh(y_pos - 0.2, score_vals, height=0.35, color="steelblue", label="*_score (row)")
    ax5.barh(y_pos + 0.2, prop_vals, height=0.35, color="coral", label="*_proportion (row)")
    ax5.set_yticks(y_pos)
    ax5.set_yticklabels(CATEGORY_ORDER, fontsize=8)
    ax5.set_xlim(0, max(1.0, max(score_vals + prop_vals) * 1.1))
    ax5.axvline(DETECTION_THRESHOLD, color="gray", linestyle="--", linewidth=0.8, label="0.20 threshold")
    ax5.set_xlabel("Value")
    ax5.set_title(
        f"5. Row rollup (CSV columns) — unidentify_proportion = {row_props['Unidentify']:.2f}; "
        "category from max score"
    )
    ax5.legend(loc="lower right", fontsize=7)

    args.output.parent.mkdir(parents=True, exist_ok=True)
    fig.tight_layout(rect=(0, 0, 1, 0.96))
    fig.savefig(args.output, dpi=150)
    plt.close(fig)
    print(f"Wrote {args.output.resolve()}")


if __name__ == "__main__":
    main()

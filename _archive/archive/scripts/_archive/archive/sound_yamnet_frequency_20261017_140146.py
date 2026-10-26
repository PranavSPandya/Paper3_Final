"""
Canonical Paper 3 environmental sound pipeline.

Purpose
-------
Keep three acoustic constructs separate:
1) Sound level: RMS dBFS from the recorded WAV (relative digital level only).
   Calibrated environmental sound level remains UCM SND_dBA.
2) Sound source/type: YAMNet (16 kHz mono), summarized from frame-level
   predictions into mutually exclusive study categories.
3) Sound frequency: Welch power spectral density on the ORIGINAL sample-rate
   WAV, aligned to the same 10-second windows.

The two Bluyssen/Hamida papers motivate analysing sound type, level and
frequency as distinct characteristics. They do not prescribe YAMNet, a 0.20
threshold, or the spectral metrics below. The spectral metrics are standard
signal-processing descriptors added for field-audio characterization.

Primary-analysis safeguards
---------------------------
- One and only one WAV must exist per participant/phase.
- Active phase alignment is required from key.csv + first CamDown timestamp.
- Primary 10-second rows must be complete; incomplete final windows are retained
  only as QC rows and receive no YAMNet/frequency estimates.
- No per-file amplitude normalization is performed.
- Frequency analysis never uses the 16-kHz YAMNet waveform.
- Spectral outputs are relative energy descriptors, NOT calibrated dB SPL.
"""

from __future__ import annotations

import argparse
import csv
import io
import math
import os
import tempfile
from dataclasses import dataclass
from datetime import datetime, timedelta
from pathlib import Path
from typing import Iterable

import numpy as np
import pandas as pd
import soundfile as sf
import tensorflow as tf
import tensorflow_hub as hub
from scipy.signal import resample_poly, welch


# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

SEGMENT_DURATION_S = 10.0
YAMNET_SR = 16_000
YAMNET_THRESHOLD = 0.20
AUDIO_MIN_HZ = 20.0
AUDIO_MAX_HZ = 20_000.0

DEFAULT_PROJECT_ROOT = Path(r"C:\Users\pandya\Documents\Github\docker\Paper3_Final")
DEFAULT_RAW_UCM_ROOT = Path(
    r"C:\Users\pandya\OneDrive - UCL\Field experiment raw data\Complete Participantwise data\Final Data\ucm"
)
DEFAULT_KEY_CSV = Path(r"C:\Users\pandya\Documents\Github\docker\Paper3_Github\output\key.csv")
DEFAULT_OUTPUT_DIR = DEFAULT_PROJECT_ROOT / "output" / "Sound_ucm"

RETAINED_PARTICIPANTS = {"P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"}
PHASES = ["BikeG", "BikeU", "Tram", "WalkG", "WalkU"]
PRIMARY_MATCHED_SECONDS = 480.0

# Exact AudioSet label membership only. These sets are intentionally disjoint.
# Legacy category names are retained so existing Paper 3 downstream code keeps
# working. The valence words "positive/negative" are compatibility labels only;
# they are not interpreted as participant appraisal.
TARGET_CATEGORIES: dict[str, set[str]] = {
    "Wind": {
        "Wind", "Wind noise (microphone)", "Howl", "Whoosh, swoosh, swish",
        "Gust of wind", "Blowing (wind)",
    },
    "Rural/Natural": {
        "Outside, rural or natural", "Forest", "Bird",
        "Bird vocalization, bird call, bird song", "Chirp, tweet", "Coo", "Crow",
        "Insect", "Cricket", "Bee, wasp, etc.", "Frog", "Nature sounds",
        "Stream", "Water", "Rain", "Thunderstorm", "Thunder", "Ocean",
        "Waves, surf", "Animal", "Livestock, farm animals, working animals",
        "Horse", "Cattle, bovinae", "Sheep", "Goat", "Pig", "Chicken, rooster",
        "Dog", "Cat", "Wild animals", "Wolf", "Bird flight, flapping wings",
    },
    "Vehicle": {
        "Vehicle", "Motor vehicle (road)", "Car", "Car passing by", "Truck",
        "Bus", "Motorcycle", "Emergency vehicle", "Siren", "Police car (siren)",
        "Ambulance (siren)", "Fire engine, fire truck (siren)", "Aircraft",
        "Airplane", "Helicopter", "Train", "Rail transport", "Train horn",
        "Subway, metro, underground", "Boat, Water vehicle", "Ship",
        "Motorboat, speedboat", "Traffic noise, roadway noise", "Car alarm",
        "Vehicle horn, car horn, honking", "Engine", "Engine starting", "Idling",
        "Accelerating, revving, vroom", "Engine knocking",
        "Medium engine (mid frequency)", "Light engine (high frequency)",
        "Heavy engine (low frequency)",
    },
    "Urban/Manmade_neutral": {
        "Outside, urban or manmade", "City", "Footsteps", "Walking", "Running",
        "Skateboard", "Bicycle",
    },
    "Urban/Manmade_positive": {
        "Crowd", "Cheering", "Applause", "Chatter", "Conversation", "Speech",
        "Human voice", "Street music", "Music",
    },
    "Urban/Manmade_negative": {
        "Construction site", "Jackhammer", "Bulldozer", "Excavator", "Drilling",
        "Hammering", "Sawing", "Power tool", "Chainsaw", "Industrial noise",
        "Factory",
    },
    "Mechanisms": {
        "Mechanisms", "Tools", "Hammer", "Wood", "Filing (rasp)", "Sanding",
        "Drill", "Door", "Sliding door", "Slam", "Knock", "Tap", "Squeak",
        "Creak", "Ratchet, pawl", "Clock", "Tick", "Ticking", "Mechanical fan",
        "Air conditioning", "Microwave oven", "Blender", "Water tap, faucet",
        "Flush", "Zipper (clothing)", "Keys jangling", "Coin (dropping)",
        "Scissors", "Electric shaver, electric razor", "Lawn mower", "Printing",
        "Typewriter", "Keyboard (typing)",
    },
}
FALLBACK_CATEGORY = "Unidentify"
CATEGORY_CODES = {
    FALLBACK_CATEGORY: 0,
    "Wind": 1,
    "Rural/Natural": 2,
    "Vehicle": 3,
    "Urban/Manmade_neutral": 4,
    "Urban/Manmade_positive": 5,
    "Urban/Manmade_negative": 6,
    "Mechanisms": 7,
}
CATEGORY_TO_PROP_FIELD = {
    "Urban/Manmade_positive": "sound_prop_urban_manmade_positive",
    "Urban/Manmade_neutral": "sound_prop_urban_manmade_neutral",
    "Urban/Manmade_negative": "sound_prop_urban_manmade_negative",
    "Mechanisms": "sound_prop_mechanisms",
    "Rural/Natural": "sound_prop_rural_natural",
    FALLBACK_CATEGORY: "sound_prop_unidentify",
    "Vehicle": "sound_prop_vehicle",
    "Wind": "sound_prop_wind",
}

# Neutral paper-facing families approximating the four sound-source families
# used by Bluyssen/Hamida, plus wind/other for field recordings.
LEGACY_TO_PAPER_FAMILY = {
    "Rural/Natural": "Natural",
    "Vehicle": "Traffic",
    "Urban/Manmade_positive": "People",
    "Mechanisms": "Mechanical",
    "Urban/Manmade_negative": "Mechanical",
    "Wind": "Wind",
    "Urban/Manmade_neutral": "Other_urban",
    FALLBACK_CATEGORY: "Unidentified",
}
PAPER_FAMILIES = ["Natural", "Traffic", "People", "Mechanical", "Wind", "Other_urban", "Unidentified"]

# Standard octave-band centres. Values above Nyquist are reported as NaN.
OCTAVE_CENTERS_HZ = [31.5, 63.0, 125.0, 250.0, 500.0, 1000.0, 2000.0, 4000.0, 8000.0]


def _validate_category_definition() -> None:
    seen: dict[str, str] = {}
    duplicates: list[tuple[str, str, str]] = []
    for category, labels in TARGET_CATEGORIES.items():
        for label in labels:
            if label in seen:
                duplicates.append((label, seen[label], category))
            seen[label] = category
    if duplicates:
        raise RuntimeError(f"YAMNet target category labels overlap: {duplicates}")


_validate_category_definition()


# ---------------------------------------------------------------------------
# Model + class map
# ---------------------------------------------------------------------------

def load_yamnet():
    model = hub.load("https://tfhub.dev/google/yamnet/1")
    class_map_path = model.class_map_path().numpy().decode("utf-8")
    with tf.io.gfile.GFile(class_map_path, "r") as f:
        rows = list(csv.reader(io.StringIO(f.read())))
    class_names = [row[2] for row in rows if len(row) >= 3 and row[0] != "index"]
    if len(class_names) != 521:
        raise RuntimeError(f"Expected 521 YAMNet classes; got {len(class_names)}")
    return model, class_names


def build_category_indices(class_names: list[str]) -> dict[str, np.ndarray]:
    lookup = {name: i for i, name in enumerate(class_names)}
    out: dict[str, np.ndarray] = {}
    missing: list[tuple[str, str]] = []
    for category, labels in TARGET_CATEGORIES.items():
        idx = []
        for label in sorted(labels):
            if label in lookup:
                idx.append(lookup[label])
            else:
                missing.append((category, label))
        out[category] = np.asarray(idx, dtype=int)
    if missing:
        # Exact matching is intentional. Missing labels are surfaced rather than
        # silently replaced by substring matches.
        print(f"[WARN] {len(missing)} configured AudioSet labels absent from YAMNet class map: {missing}")
    if any(len(v) == 0 for v in out.values()):
        empty = [k for k, v in out.items() if len(v) == 0]
        raise RuntimeError(f"No valid YAMNet labels for categories: {empty}")
    return out


# ---------------------------------------------------------------------------
# Audio + timing
# ---------------------------------------------------------------------------

def load_original_audio_mono(path: Path) -> tuple[np.ndarray, int, int, str]:
    audio, sr = sf.read(path, dtype="float32", always_2d=True)
    if sr <= 0:
        raise ValueError(f"Invalid sample rate in {path}: {sr}")
    if not np.all(np.isfinite(audio)):
        raise ValueError(f"Non-finite audio samples in {path}")

    channels = int(audio.shape[1])
    if channels == 1:
        mono = audio[:, 0]
        channel_strategy = "native_mono"
    else:
        # YAMNet requires mono, and averaging unknown stereo channels can cause
        # phase cancellation and change the spectrum. Accept only effectively
        # duplicated channels automatically; otherwise require an explicit
        # methodological decision rather than silently down-mixing.
        reference = audio[:, [0]]
        max_channel_difference = float(np.max(np.abs(audio - reference)))
        if max_channel_difference <= 1e-6:
            mono = audio[:, 0]
            channel_strategy = "duplicated_channels_first_channel"
        else:
            raise RuntimeError(
                f"{path} has {channels} non-identical channels. "
                "Do not average them automatically for PhD analysis; document and "
                "implement the correct microphone/channel selection first."
            )

    # soundfile scales integer PCM into [-1, 1]. Preserve the original waveform
    # for RMS and PSD; never silently clip or normalize scientific source data.
    peak = float(np.max(np.abs(mono))) if mono.size else 0.0
    if peak > 1.0001:
        raise ValueError(
            f"{path} has |sample|={peak:.6f} > 1.0; dBFS/spectral interpretation "
            "requires verification of the WAV encoding before analysis"
        )
    return np.asarray(mono, dtype=np.float32), int(sr), channels, channel_strategy


def to_yamnet_16k(segment: np.ndarray, sr: int) -> np.ndarray:
    data = np.asarray(segment, dtype=np.float32)
    if sr == YAMNET_SR:
        out = data
    else:
        # Polyphase resampling is deterministic, high-quality, and avoids
        # optional codec/resampler dependencies.
        g = math.gcd(int(sr), int(YAMNET_SR))
        up = YAMNET_SR // g
        down = int(sr) // g
        out = resample_poly(data, up, down).astype(np.float32)
    return np.clip(out, -1.0, 1.0)


def rms_dbfs(segment: np.ndarray) -> float:
    if segment.size == 0:
        return np.nan
    rms = float(np.sqrt(np.mean(np.square(segment, dtype=np.float64))))
    if not np.isfinite(rms) or rms <= 0.0:
        return np.nan
    return float(20.0 * np.log10(rms))


def parse_time_str(value):
    if pd.isna(value):
        return None
    return datetime.strptime(str(value).strip(), "%H:%M:%S").time()


@dataclass(frozen=True)
class Recording:
    participant: str
    phase: str
    wav_path: Path
    phase_start_offset_s: float
    active_duration_s: float
    alignment_source: str


def discover_recordings(raw_root: Path, key_csv: Path) -> list[Recording]:
    if not raw_root.is_dir():
        raise FileNotFoundError(raw_root)
    if not key_csv.is_file():
        raise FileNotFoundError(key_csv)

    key_df = pd.read_csv(key_csv)
    required_key = {"Participant_ID"}
    missing = required_key.difference(key_df.columns)
    if missing:
        raise ValueError(f"key.csv missing required columns: {sorted(missing)}")
    key_df = key_df.copy()
    key_df["pid_clean"] = key_df["Participant_ID"].apply(lambda x: f"P{int(x)}")

    found: list[Recording] = []
    for pid in sorted(RETAINED_PARTICIPANTS, key=lambda x: int(x[1:])):
        pid_path = raw_root / pid
        if not pid_path.is_dir():
            raise FileNotFoundError(f"Missing participant folder: {pid_path}")

        k_rows = key_df[key_df["pid_clean"] == pid]
        if len(k_rows) != 1:
            raise ValueError(f"Expected exactly one key.csv row for {pid}; got {len(k_rows)}")
        k_row = k_rows.iloc[0]

        for phase in PHASES:
            phase_dir = pid_path / phase
            if not phase_dir.is_dir():
                raise FileNotFoundError(f"Missing phase folder: {phase_dir}")

            wavs = sorted(phase_dir.rglob("*.wav"))
            if len(wavs) != 1:
                raise RuntimeError(
                    f"{pid} {phase}: expected exactly one WAV, found {len(wavs)}: {wavs}"
                )
            wav_path = wavs[0]

            cams = sorted(phase_dir.rglob("CamDown/*.jpg"))
            if not cams:
                cams = sorted(phase_dir.rglob("CamDown/*.png"))
            if not cams:
                raise RuntimeError(f"{pid} {phase}: no CamDown image found for phase alignment")

            first_cam = cams[0]
            stamp = first_cam.stem.replace("cam_", "", 1)
            try:
                cam_dt = datetime.strptime(stamp, "%Y%m%d_%H%M%S")
            except ValueError as exc:
                raise ValueError(f"Cannot parse first CamDown timestamp: {first_cam.name}") from exc

            k_s = parse_time_str(k_row.get(f"{phase}_start"))
            k_e = parse_time_str(k_row.get(f"{phase}_end"))
            if k_s is None or k_e is None:
                raise ValueError(f"{pid} {phase}: missing {phase}_start/end in key.csv")

            start_dt = datetime.combine(cam_dt.date(), k_s)
            end_dt = datetime.combine(cam_dt.date(), k_e)
            if end_dt <= start_dt:
                end_dt += timedelta(days=1)
            offset_s = (start_dt - cam_dt).total_seconds()
            if offset_s < -1.0:
                raise RuntimeError(
                    f"{pid} {phase}: key phase start precedes first CamDown by {abs(offset_s):.1f}s; "
                    "alignment assumption is invalid"
                )
            offset_s = max(offset_s, 0.0)
            duration_s = (end_dt - start_dt).total_seconds()
            if duration_s <= 0:
                raise RuntimeError(f"{pid} {phase}: non-positive phase duration {duration_s}")

            found.append(
                Recording(
                    participant=pid,
                    phase=phase,
                    wav_path=wav_path,
                    phase_start_offset_s=float(offset_s),
                    active_duration_s=float(duration_s),
                    alignment_source="key.csv phase bounds relative to first CamDown timestamp",
                )
            )

    expected = len(RETAINED_PARTICIPANTS) * len(PHASES)
    if len(found) != expected:
        raise AssertionError(f"Expected {expected} participant-phase recordings; got {len(found)}")
    return found


# ---------------------------------------------------------------------------
# YAMNet frame-level classification
# ---------------------------------------------------------------------------

def classify_yamnet_segment(
    segment_16k: np.ndarray,
    model,
    category_indices: dict[str, np.ndarray],
    threshold: float,
) -> dict[str, object]:
    scores, _, _ = model(tf.constant(segment_16k, dtype=tf.float32))
    frame_scores = np.asarray(scores.numpy(), dtype=np.float64)
    if frame_scores.ndim != 2 or frame_scores.shape[1] != 521:
        raise RuntimeError(f"Unexpected YAMNet score shape: {frame_scores.shape}")

    categories = list(TARGET_CATEGORIES)
    cat_score = np.zeros((frame_scores.shape[0], len(categories)), dtype=np.float64)
    for j, category in enumerate(categories):
        idx = category_indices[category]
        cat_score[:, j] = frame_scores[:, idx].max(axis=1)

    # YAMNet is intrinsically multi-label (independent sigmoid outputs).
    # Preserve that property: a frame can simultaneously contain e.g. traffic
    # and speech. Category prevalence therefore does NOT have to sum to one.
    def active_at(thr: float) -> np.ndarray:
        return cat_score >= float(thr)

    active = active_at(threshold)
    category_mean_scores = cat_score.mean(axis=0)
    proportions = {
        CATEGORY_TO_PROP_FIELD[category]: float(np.mean(active[:, j]))
        for j, category in enumerate(categories)
    }
    no_target_active = ~np.any(active, axis=1)
    proportions[CATEGORY_TO_PROP_FIELD[FALLBACK_CATEGORY]] = float(
        np.mean(no_target_active)
    )

    ordered = list(CATEGORY_CODES)

    def dominant_for(thr: float) -> str:
        act = active_at(thr)
        prevalence = act.mean(axis=0)
        if not np.any(act):
            return FALLBACK_CATEGORY
        # Prevalence first, mean YAMNet category score second, stable configured
        # order third. This is retained only as a compatibility summary; the
        # multi-label proportions are the scientifically preferred outputs.
        best = max(
            range(len(categories)),
            key=lambda j: (prevalence[j], category_mean_scores[j], -j),
        )
        return categories[best]

    dominant = dominant_for(threshold)
    sensitivity_thresholds = (0.10, 0.20, 0.30)
    sensitivity_dominants = {
        thr: dominant_for(thr)
        for thr in sensitivity_thresholds
    }

    # Build broader reference families with OR logic across member categories
    # so simultaneous events are retained rather than made mutually exclusive.
    paper_family_members = {
        family: [j for j, category in enumerate(categories)
                 if LEGACY_TO_PAPER_FAMILY[category] == family]
        for family in PAPER_FAMILIES
        if family not in {"Unidentified"}
    }
    paper_props: dict[str, float] = {}
    for family in PAPER_FAMILIES:
        key = f"paper_prop_{family.lower()}"
        if family == "Unidentified":
            paper_props[key] = float(np.mean(no_target_active))
        else:
            members = paper_family_members.get(family, [])
            paper_props[key] = (
                float(np.mean(np.any(active[:, members], axis=1)))
                if members else 0.0
            )

    identifiable_families = [f for f in PAPER_FAMILIES if f != "Unidentified"]
    if np.all(no_target_active):
        paper_dominant = "Unidentified"
    else:
        paper_dominant = max(
            identifiable_families,
            key=lambda family: (
                paper_props[f"paper_prop_{family.lower()}"],
                -identifiable_families.index(family),
            ),
        )

    best_per_frame = np.max(cat_score, axis=1)
    result: dict[str, object] = {
        "sound_type": CATEGORY_CODES[dominant],
        "category": dominant,
        "paper_sound_family": paper_dominant,
        "yamnet_frame_count": int(frame_scores.shape[0]),
        "yamnet_threshold": float(threshold),
        "yamnet_mean_best_score": float(np.mean(best_per_frame)),
        "yamnet_min_best_score": float(np.min(best_per_frame)),
        "yamnet_unidentified_frame_prop": float(np.mean(no_target_active)),
        "yamnet_mean_active_categories_per_frame": float(np.mean(active.sum(axis=1))),
        "category_threshold_0_10": sensitivity_dominants[0.10],
        "category_threshold_0_20": sensitivity_dominants[0.20],
        "category_threshold_0_30": sensitivity_dominants[0.30],
        "category_stable_threshold_0_10_to_0_30": (
            len(set(sensitivity_dominants.values())) == 1
        ),
    }
    for j, category in enumerate(categories):
        field = CATEGORY_TO_PROP_FIELD[category].replace("sound_prop_", "sound_score_")
        result[field] = float(category_mean_scores[j])
    result.update(proportions)
    result.update(paper_props)
    return result


# ---------------------------------------------------------------------------
# Frequency-domain analysis on ORIGINAL sample rate
# ---------------------------------------------------------------------------

def _integrate_psd(freqs: np.ndarray, psd: np.ndarray, low: float, high: float) -> float:
    mask = (freqs >= low) & (freqs < high)
    if np.count_nonzero(mask) < 2:
        return np.nan
    return float(np.trapz(psd[mask], freqs[mask]))


def spectral_features(segment: np.ndarray, sr: int) -> dict[str, float]:
    result: dict[str, float] = {
        "original_sample_rate_hz": float(sr),
        "frequency_analysis_min_hz": AUDIO_MIN_HZ,
        "frequency_analysis_max_hz": float(min(AUDIO_MAX_HZ, sr / 2.0)),
        "frequency_analysis_full_20khz_coverage": bool((sr / 2.0) >= AUDIO_MAX_HZ),
        "spectral_method": "Welch_PSD_Hann_1s_50pct_overlap",
        "octave_method": "PSD_integral_geometric_band_edges_not_IEC61260_filterbank",
        "dominant_frequency_hz": np.nan,
        "spectral_centroid_hz": np.nan,
        "spectral_rolloff85_hz": np.nan,
        "freq_prop_20_125": np.nan,
        "freq_prop_125_1000": np.nan,
        "freq_prop_1000_4000": np.nan,
        "freq_prop_4000_8000": np.nan,
        "freq_prop_8000_20000": np.nan,
    }
    for center in OCTAVE_CENTERS_HZ:
        key = f"octave_prop_{str(center).replace('.', '_')}_hz"
        result[key] = np.nan

    if segment.size < max(32, int(0.25 * sr)):
        return result
    if not np.any(np.abs(segment) > 0):
        return result

    max_hz = min(AUDIO_MAX_HZ, sr / 2.0)
    if max_hz <= AUDIO_MIN_HZ:
        return result

    nperseg = min(len(segment), max(1024, int(sr)))
    noverlap = nperseg // 2
    freqs, psd = welch(
        segment.astype(np.float64),
        fs=float(sr),
        window="hann",
        nperseg=nperseg,
        noverlap=noverlap,
        detrend="constant",
        scaling="density",
    )
    valid = (freqs >= AUDIO_MIN_HZ) & (freqs <= max_hz) & np.isfinite(psd)
    f = freqs[valid]
    p = psd[valid]
    if f.size < 2 or not np.any(p > 0):
        return result

    total = float(np.trapz(p, f))
    if not np.isfinite(total) or total <= 0:
        return result

    result["dominant_frequency_hz"] = float(f[int(np.argmax(p))])
    result["spectral_centroid_hz"] = float(np.sum(f * p) / np.sum(p))

    cumulative = np.cumsum((p[:-1] + p[1:]) * 0.5 * np.diff(f))
    roll_target = 0.85 * total
    roll_idx = int(np.searchsorted(cumulative, roll_target, side="left"))
    roll_idx = min(roll_idx, len(f) - 1)
    result["spectral_rolloff85_hz"] = float(f[roll_idx])

    broad_bands = [
        ("freq_prop_20_125", 20.0, 125.0),
        ("freq_prop_125_1000", 125.0, 1000.0),
        ("freq_prop_1000_4000", 1000.0, 4000.0),
        ("freq_prop_4000_8000", 4000.0, 8000.0),
        ("freq_prop_8000_20000", 8000.0, 20000.0),
    ]
    for key, low, high in broad_bands:
        # A named band is reported only when the source recording contains the
        # entire band. Never silently call an 8-11 kHz fragment "8-20 kHz".
        if high <= max_hz:
            e = _integrate_psd(f, p, low, high)
            result[key] = float(e / total) if np.isfinite(e) else np.nan

    for center in OCTAVE_CENTERS_HZ:
        key = f"octave_prop_{str(center).replace('.', '_')}_hz"
        low = center / math.sqrt(2.0)
        high = center * math.sqrt(2.0)
        # Do not label a truncated edge band as a complete octave band.
        if low < AUDIO_MIN_HZ or high > max_hz:
            continue
        e = _integrate_psd(f, p, low, high)
        result[key] = float(e / total) if np.isfinite(e) else np.nan

    return result


# ---------------------------------------------------------------------------
# Pipeline
# ---------------------------------------------------------------------------

def analyze_recording(
    recording: Recording,
    model,
    category_indices: dict[str, np.ndarray],
    threshold: float,
) -> pd.DataFrame:
    audio, sr, channel_count, channel_strategy = load_original_audio_mono(recording.wav_path)
    total_duration_s = len(audio) / sr

    crop_start = int(round(recording.phase_start_offset_s * sr))
    crop_end = int(round((recording.phase_start_offset_s + recording.active_duration_s) * sr))
    tolerance_samples = int(round(1.0 * sr))
    if crop_start < 0 or crop_start >= len(audio):
        raise RuntimeError(
            f"{recording.participant} {recording.phase}: crop start outside WAV "
            f"(offset={recording.phase_start_offset_s:.2f}s, WAV={total_duration_s:.2f}s)"
        )
    if crop_end > len(audio) + tolerance_samples:
        raise RuntimeError(
            f"{recording.participant} {recording.phase}: requested phase end exceeds WAV by "
            f"{(crop_end-len(audio))/sr:.2f}s"
        )
    crop_end = min(crop_end, len(audio))
    clipped = audio[crop_start:crop_end]

    nominal_segment_samples = int(round(SEGMENT_DURATION_S * sr))
    if nominal_segment_samples <= 0:
        raise RuntimeError("Invalid 10-second sample count")

    n_segments = math.ceil(len(clipped) / nominal_segment_samples)
    records: list[dict[str, object]] = []

    for i in range(n_segments):
        s = i * nominal_segment_samples
        e = min(s + nominal_segment_samples, len(clipped))
        seg = clipped[s:e]
        duration = len(seg) / sr
        complete = abs(duration - SEGMENT_DURATION_S) <= (1.0 / sr)

        base: dict[str, object] = {
            "participant": recording.participant,
            "phase": recording.phase,
            "segment": i + 1,
            "start_time_s": round(i * SEGMENT_DURATION_S, 6),
            "end_time_s": round(i * SEGMENT_DURATION_S + duration, 6),
            "window_duration_s": round(duration, 6),
            "is_complete_10s_window": bool(complete),
            "wav_path": str(recording.wav_path),
            "original_channel_count": channel_count,
            "channel_strategy": channel_strategy,
            "alignment_source": recording.alignment_source,
            "phase_start_offset_s": recording.phase_start_offset_s,
            "sound_level_dbfs": np.nan,
            "sound_level_unit": "dBFS",
            "wav_level_calibrated_spl": False,
            "frequency_response_calibrated": False,
            "spectral_value_type": "relative_power_fraction",
            "sound_type": np.nan,
            "category": None,
            "paper_sound_family": None,
        }

        level = rms_dbfs(seg)
        base["sound_level_dbfs"] = level

        # Primary comparability rule: only complete 10-second windows get
        # YAMNet and frequency descriptors. The short tail remains explicit QC.
        if complete and np.isfinite(level):
            seg16 = to_yamnet_16k(seg, sr)
            # Exact 10 s should resample to almost exactly 160000 samples.
            target_n = int(round(SEGMENT_DURATION_S * YAMNET_SR))
            if abs(len(seg16) - target_n) > 2:
                raise RuntimeError(
                    f"Unexpected resampled length {len(seg16)} for complete 10-s window"
                )
            if len(seg16) < target_n:
                seg16 = np.pad(seg16, (0, target_n - len(seg16)))
            elif len(seg16) > target_n:
                seg16 = seg16[:target_n]

            base.update(classify_yamnet_segment(seg16, model, category_indices, threshold))
            base.update(spectral_features(seg, sr))
        else:
            # Ensure stable schema even for partial/silent QC rows.
            for field in CATEGORY_TO_PROP_FIELD.values():
                base[field] = np.nan
            for category in TARGET_CATEGORIES:
                score_field = CATEGORY_TO_PROP_FIELD[category].replace("sound_prop_", "sound_score_")
                base[score_field] = np.nan
            base["yamnet_mean_active_categories_per_frame"] = np.nan
            for family in PAPER_FAMILIES:
                base[f"paper_prop_{family.lower()}"] = np.nan
            base.update(spectral_features(np.array([], dtype=np.float32), sr))

        records.append(base)

    df = pd.DataFrame(records)
    if not df.empty:
        complete = df["is_complete_10s_window"].fillna(False)
        # Multi-label prevalence proportions are independent and therefore
        # need not sum to one. Each must, however, remain a valid proportion.
        prop_cols = list(CATEGORY_TO_PROP_FIELD.values())
        if complete.any():
            vals = df.loc[complete, prop_cols].apply(pd.to_numeric, errors="coerce")
            if vals.isna().any().any() or ((vals < 0.0) | (vals > 1.0)).any().any():
                raise AssertionError(
                    f"{recording.participant} {recording.phase}: invalid YAMNet prevalence proportion"
                )
    return df


def rebuild_combined_outputs(output_dir: Path) -> tuple[pd.DataFrame, pd.DataFrame]:
    expected = {
        f"{pid}_{phase}_sound_analysis.csv"
        for pid in RETAINED_PARTICIPANTS
        for phase in PHASES
    }
    files = sorted(p for p in output_dir.glob("*_sound_analysis.csv") if p.name in expected)
    if len(files) != len(expected):
        missing = sorted(expected.difference({p.name for p in files}))
        raise AssertionError(f"Expected {len(expected)} per-phase files; got {len(files)}. Missing: {missing}")

    frames = [pd.read_csv(p, low_memory=False) for p in files]
    combined = pd.concat(frames, ignore_index=True)
    full_csv = output_dir / "all_participants_sound_analysis.csv"
    combined.to_csv(full_csv, index=False)

    matched = combined[
        combined["phase"].isin(PHASES)
        & combined["is_complete_10s_window"].eq(True)
        & (pd.to_numeric(combined["end_time_s"], errors="coerce") <= PRIMARY_MATCHED_SECONDS)
    ].copy()

    # Exactly 48 complete 10-s windows are expected for each participant/phase
    # whose active duration reaches 8 minutes.
    matched_csv = output_dir / "all_participants_sound_analysis_matched_8min.csv"
    matched.to_csv(matched_csv, index=False)

    if set(combined["participant"].dropna()) != RETAINED_PARTICIPANTS:
        raise AssertionError("Combined sound output participant set is incorrect")
    if matched.empty or matched["end_time_s"].max() > PRIMARY_MATCHED_SECONDS:
        raise AssertionError("Matched 8-min sound output is invalid")
    return combined, matched


def run_pipeline(
    raw_root: Path = DEFAULT_RAW_UCM_ROOT,
    key_csv: Path = DEFAULT_KEY_CSV,
    output_dir: Path = DEFAULT_OUTPUT_DIR,
    threshold: float = YAMNET_THRESHOLD,
) -> tuple[pd.DataFrame, pd.DataFrame]:
    if not (0.0 <= threshold <= 1.0):
        raise ValueError("YAMNet threshold must be in [0,1]")

    output_dir.mkdir(parents=True, exist_ok=True)
    model, class_names = load_yamnet()
    category_indices = build_category_indices(class_names)
    recordings = discover_recordings(raw_root, key_csv)

    # Build the entire run in a staging directory. Canonical files are replaced
    # only after all 55 participant-phase analyses and both combined exports pass.
    with tempfile.TemporaryDirectory(prefix=".sound_run_", dir=output_dir) as td:
        stage = Path(td)
        for i, rec in enumerate(recordings, 1):
            print(
                f"[{i:02d}/{len(recordings):02d}] {rec.participant} {rec.phase} | "
                f"offset={rec.phase_start_offset_s:.1f}s active={rec.active_duration_s:.1f}s"
            )
            df = analyze_recording(rec, model, category_indices, threshold)
            out = stage / f"{rec.participant}_{rec.phase}_sound_analysis.csv"
            df.to_csv(out, index=False)

        combined, matched = rebuild_combined_outputs(stage)

        staged_files = sorted(stage.glob("*.csv"))
        expected_count = len(RETAINED_PARTICIPANTS) * len(PHASES) + 2
        if len(staged_files) != expected_count:
            raise AssertionError(
                f"Staging produced {len(staged_files)} CSVs; expected {expected_count}"
            )
        for staged in staged_files:
            os.replace(staged, output_dir / staged.name)

    print(f"Full sound output: {len(combined)} rows")
    print(f"Matched 8-min output: {len(matched)} rows")
    return combined, matched


def main() -> None:
    parser = argparse.ArgumentParser(description="Paper 3 YAMNet + original-rate sound-frequency pipeline")
    parser.add_argument("--raw-root", type=Path, default=DEFAULT_RAW_UCM_ROOT)
    parser.add_argument("--key-csv", type=Path, default=DEFAULT_KEY_CSV)
    parser.add_argument("--output-dir", type=Path, default=DEFAULT_OUTPUT_DIR)
    parser.add_argument("--yamnet-threshold", type=float, default=YAMNET_THRESHOLD)
    args = parser.parse_args()
    run_pipeline(args.raw_root, args.key_csv, args.output_dir, args.yamnet_threshold)


if __name__ == "__main__":
    main()

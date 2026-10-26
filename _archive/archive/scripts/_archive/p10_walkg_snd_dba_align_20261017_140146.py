"""P10 WalkG: align 1 s RMS dBFS (Paper3) to uCM SND_dBA; optional tail gain or offset-only."""
from __future__ import annotations

import argparse
import json
import shutil
from datetime import datetime
from pathlib import Path

import numpy as np
import pandas as pd
import soundfile as sf

CSV_PATH = Path(
    r"C:\Users\pandya\OneDrive - UCL\Field experiment raw data\Complete Participantwise data\Final Data\ucm\P10\WalkG\ucm\data.csv"
)
WAV_PATH = Path(
    r"C:\Users\pandya\OneDrive - UCL\Field experiment raw data\Complete Participantwise data\Final Data\ucm\P10\WalkG\ucm\snd\20250812_124917.wav"
)
COPY_WAV_PATH = WAV_PATH.with_name("20250812_124917 - Copy.wav")
OLD_WAV_PATH = WAV_PATH.with_name("Old_20250812_124917.wav")
PRE_AMP_BACKUP = WAV_PATH.with_suffix(WAV_PATH.suffix + ".pre_amp.bak")
PRE_OFFSET_ONLY_REVERT_BACKUP = WAV_PATH.with_suffix(
    WAV_PATH.suffix + ".pre_offset_only_revert.bak"
)
REPORT_PATH = Path(__file__).resolve().parent / "p10_walkg_snd_dba_align_report.json"

NATURAL_EXTEND_LOOP_S = 1.0
NATURAL_EXTEND_CROSSFADE_S = 0.25
# Original field recording length before CSV row padding (matches Old_*.wav sample count).
NATURAL_RECORDING_SAMPLES = 64_562_743

TOLERANCE_DB = 0.5
CALIB_SECONDS = 120
ROLL_WINDOW_S = 30
ROLL_BASELINE_S = 60
ONSET_SEARCH_FROM_S = 600
ONSET_ROLL_EXCESS_DB = 2.0
ONSET_SUSTAIN_S = 60
GAIN_FADE_S = 2.0
TAIL_GAIN_ONSET_S = 684


def read_ucm_csv(path: Path) -> pd.DataFrame:
    lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    header_idx = next(i for i, ln in enumerate(lines) if ln.startswith("# GPS_time,"))
    header = lines[header_idx].lstrip("# ").strip().split(",")
    data_lines = [ln for ln in lines[header_idx + 2 :] if ln.strip() and not ln.startswith("#")]
    from io import StringIO

    df = pd.read_csv(StringIO("\n".join(data_lines)), names=header, header=None)
    df["ts"] = pd.to_datetime(df["GPS_time"], errors="coerce")
    df["SND_dBA"] = pd.to_numeric(df["SND_dBA"], errors="coerce")
    return df.dropna(subset=["ts"]).reset_index(drop=True)


def rms_dbfs(segment: np.ndarray) -> float:
    """Same as scripts/archive/sound_yamnet_frequency.py."""
    if segment.size == 0:
        return np.nan
    rms = float(np.sqrt(np.mean(np.square(segment, dtype=np.float64))))
    if not np.isfinite(rms) or rms <= 0.0:
        return np.nan
    return float(20.0 * np.log10(rms))


def per_second_dbfs(audio: np.ndarray, fs: int, n_seconds: int) -> np.ndarray:
    levels = np.full(n_seconds, np.nan, dtype=float)
    for i in range(n_seconds):
        seg = audio[i * fs : (i + 1) * fs]
        if seg.size < fs // 2:
            break
        if seg.size < fs:
            seg = np.pad(seg, (0, fs - seg.size))
        levels[i] = rms_dbfs(seg)
    return levels


def copy_silence_onset(copy_mono: np.ndarray, fs: int) -> int | None:
    n = len(copy_mono) // fs
    for i in range(n - 1, -1, -1):
        seg = copy_mono[i * fs : (i + 1) * fs]
        rms = float(np.sqrt(np.mean(seg.astype(np.float64) ** 2)))
        if rms > 1e-6:
            return i + 1
    return 0


def detect_mismatch_onset(abs_err: np.ndarray) -> int:
    n = len(abs_err)
    w = ROLL_WINDOW_S
    if n <= w + ONSET_SUSTAIN_S:
        return ONSET_SEARCH_FROM_S
    roll = np.array([np.nanmean(abs_err[i : i + w]) for i in range(n - w)])
    baseline = float(np.nanmean(roll[:ROLL_BASELINE_S]))
    for i in range(ONSET_SEARCH_FROM_S, len(roll) - ONSET_SUSTAIN_S):
        if roll[i] <= baseline + ONSET_ROLL_EXCESS_DB:
            continue
        if float(np.nanmean(roll[i : i + ONSET_SUSTAIN_S])) > baseline + ONSET_ROLL_EXCESS_DB:
            return i
    return ONSET_SEARCH_FROM_S


def apply_tail_gain(
    audio: np.ndarray,
    fs: int,
    onset_s: int,
    n_seconds: int,
    gain_db_per_sec: np.ndarray,
) -> np.ndarray:
    if audio.ndim == 1:
        channels = audio[:, np.newaxis]
    else:
        channels = audio
    n_samples = channels.shape[0]
    gain = np.ones(n_samples, dtype=np.float64)
    fade_n = int(GAIN_FADE_S * fs)
    on_sample = onset_s * fs

    for i in range(onset_s, n_seconds):
        g_db = gain_db_per_sec[i]
        if not np.isfinite(g_db):
            continue
        g_lin = 10.0 ** (g_db / 20.0)
        s0 = i * fs
        s1 = min((i + 1) * fs, n_samples)
        gain[s0:s1] = g_lin

    for j in range(min(fade_n, n_samples - on_sample)):
        idx = on_sample + j
        alpha = j / max(fade_n, 1)
        gain[idx] = (1.0 - alpha) * 1.0 + alpha * gain[idx]

    out = channels.astype(np.float64) * gain[:, np.newaxis]
    out = np.clip(out, -0.999, 0.999)
    return out.squeeze(axis=1) if audio.ndim == 1 else out.astype(np.float32)


def metrics(abs_err: np.ndarray, onset: int) -> dict[str, float]:
    early_end = min(600, len(abs_err))
    tail = abs_err[onset:]
    n = len(abs_err)
    last60 = abs_err[max(0, n - 60) : n]
    last10 = abs_err[max(0, n - 10) : n]
    from_onset684 = abs_err[TAIL_GAIN_ONSET_S:] if len(abs_err) > TAIL_GAIN_ONSET_S else tail
    return {
        "mae_early_s": float(np.nanmean(abs_err[:early_end])),
        "mae_late_s": float(np.nanmean(tail)),
        "mae_from_onset_s": float(np.nanmean(tail)),
        "mae_from_684_s": float(np.nanmean(from_onset684)),
        "mae_all_s": float(np.nanmean(abs_err)),
        "mae_last_60s": float(np.nanmean(last60)),
        "mae_last_10s": float(np.nanmean(last10)),
    }


def backup_wav(path: Path, suffix: str) -> Path:
    dest = path.with_name(path.name + suffix)
    if dest.exists():
        ts = datetime.now().strftime("%Y%m%d_%H%M%S")
        dest = path.with_name(path.name + suffix.replace(".bak", f"_{ts}.bak"))
    shutil.copy2(path, dest)
    return dest


def spl_offset(csv_dba: np.ndarray, dbfs: np.ndarray, cal_n: int) -> float:
    return float(np.nanmedian(csv_dba[:cal_n] - dbfs[:cal_n]))


def evaluate_alignment(
    mono: np.ndarray, fs: int, n_seconds: int, csv_dba: np.ndarray, offset_db: float
) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    dbfs = per_second_dbfs(mono, fs, n_seconds)
    est = dbfs + offset_db
    err = est - csv_dba
    return est, err, np.abs(err)


def _scale_segment_to_target_spl(
    segment: np.ndarray, target_spl: float, offset_db: float
) -> np.ndarray:
    mono = segment.mean(axis=1) if segment.ndim > 1 else segment
    gain_db = target_spl - (rms_dbfs(mono) + offset_db)
    if not np.isfinite(gain_db):
        gain_db = 0.0
    return segment * (10.0 ** (gain_db / 20.0))


def extend_audio_to_csv_rows(
    audio: np.ndarray,
    fs: int,
    n_csv: int,
    csv_dba: np.ndarray,
    offset_db: float,
    copy_audio: np.ndarray | None = None,
) -> tuple[np.ndarray, list[str]]:
    """Append 1 s windows until len(audio) == n_csv * fs; SPL-match each new second."""
    actions: list[str] = []
    target_samples = n_csv * fs
    out = audio
    while out.shape[0] < target_samples:
        sec_idx = out.shape[0] // fs
        ref_start = max(0, sec_idx - 1) * fs
        ref_end = ref_start + fs
        if copy_audio is not None and ref_end <= copy_audio.shape[0]:
            ref = copy_audio[ref_start:ref_end]
            src = f"copy_wav_s{ref_start // fs}-{ref_end // fs}"
        else:
            ref = out[ref_start:ref_end]
            src = f"existing_s{ref_start // fs}"
        if ref.shape[0] < fs:
            pad = fs - ref.shape[0]
            if ref.ndim > 1:
                ref = np.pad(ref, ((0, pad), (0, 0)))
            else:
                ref = np.pad(ref, (0, pad))
        target = float(csv_dba[sec_idx])
        new_sec = _scale_segment_to_target_spl(ref, target, offset_db)
        if new_sec.ndim == 1:
            out = np.concatenate([out, new_sec.astype(out.dtype)])
        else:
            out = np.vstack([out, new_sec.astype(out.dtype)])
        actions.append(
            f"extend second {sec_idx} from {src} -> target SND_dBA {target:.1f}"
        )
    if out.shape[0] > target_samples:
        out = out[:target_samples]
    return out, actions


def align_duration_to_csv(
    audio: np.ndarray,
    fs: int,
    n_csv: int,
    csv_dba: np.ndarray,
    offset_db: float,
    copy_audio: np.ndarray | None = None,
) -> tuple[np.ndarray, list[str]]:
    """Clip end if WAV longer than CSV rows; extend with SPL-matched seconds if shorter."""
    actions: list[str] = []
    target_samples = n_csv * fs
    n_samples = audio.shape[0]
    dur_s = n_samples / fs
    if n_samples > target_samples:
        removed = n_samples - target_samples
        actions.append(
            f"clip end: {dur_s:.3f}s -> {n_csv}s ({removed} samples / {removed/fs:.3f}s removed)"
        )
        audio = audio[:target_samples]
    elif n_samples < target_samples:
        missing_s = (target_samples - n_samples) / fs
        actions.append(f"extend: {dur_s:.3f}s -> {n_csv}s (+{missing_s:.3f}s)")
        audio, ext = extend_audio_to_csv_rows(
            audio, fs, n_csv, csv_dba, offset_db, copy_audio
        )
        actions.extend(ext)
    else:
        actions.append(f"duration already {n_csv}s ({target_samples} samples)")
    return audio, actions


def _last_audible_second(mono: np.ndarray, fs: int, min_rms: float = 1e-6) -> int:
    n = len(mono) // fs
    for i in range(n - 1, -1, -1):
        seg = mono[i * fs : (i + 1) * fs]
        rms = float(np.sqrt(np.mean(seg.astype(np.float64) ** 2)))
        if rms > min_rms:
            return i
    return -1


def invert_tail_gain(
    gained: np.ndarray,
    fs: int,
    csv_dba: np.ndarray,
    offset_db: float,
    onset_s: int,
    max_iters: int = 12,
    init_tail_gain_db: float = 8.0,
) -> tuple[np.ndarray, str]:
    """Peel per-second tail gain from a previously tail-matched WAV (fixed-point inverse)."""
    n = len(csv_dba)
    pre = gained.astype(np.float32, copy=True)
    g = gained.astype(np.float32, copy=False)
    init_lin = np.float32(10.0 ** (-init_tail_gain_db / 20.0))
    pre[onset_s * fs :] *= init_lin
    note = (
        f"invert_tail_gain from s{onset_s}, init_tail_deamp={init_tail_gain_db:.1f}dB, "
        f"{max_iters} iters"
    )
    for _ in range(max_iters):
        mono = pre.mean(axis=1)
        dbfs = per_second_dbfs(mono, fs, n)
        gain_db = csv_dba - (dbfs + offset_db)
        max_delta = 0.0
        for i in range(onset_s, n):
            g_db = gain_db[i]
            if not np.isfinite(g_db):
                continue
            s0, s1 = i * fs, (i + 1) * fs
            inv = np.float32(10.0 ** (-g_db / 20.0))
            new_seg = g[s0:s1] * inv
            max_delta = max(max_delta, float(np.max(np.abs(new_seg - pre[s0:s1]))))
            pre[s0:s1] = new_seg
        if max_delta < 1e-5:
            break
    np.clip(pre, -0.999, 0.999, out=pre)
    return pre, note


def load_working_audio(offset_only: bool = False) -> tuple[np.ndarray, int, str]:
    """Pick source audio: natural recording for offset-only, else main / pre-amp."""
    if offset_only:
        revert_baks: list[Path] = []
        if PRE_OFFSET_ONLY_REVERT_BACKUP.exists():
            revert_baks.append(PRE_OFFSET_ONLY_REVERT_BACKUP)
        revert_baks.extend(
            sorted(
                (
                    p
                    for p in WAV_PATH.parent.glob(
                        WAV_PATH.name + ".pre_offset_only_revert_*.bak"
                    )
                ),
                key=lambda p: p.stat().st_mtime,
            )
        )
        candidates: list[tuple[Path, str, bool]] = []
        for path in revert_baks:
            candidates.append((path, path.name, True))
        for path, label in (
            (WAV_PATH.with_suffix(WAV_PATH.suffix + ".pre_tailfix.bak"), "pre_tailfix.bak"),
            (PRE_AMP_BACKUP, "pre_amp.bak"),
            (WAV_PATH.with_suffix(WAV_PATH.suffix + ".pre_duration.bak"), "pre_duration.bak"),
            (OLD_WAV_PATH, "Old_20250812_124917.wav"),
        ):
            if path.exists():
                candidates.append((path, label, False))

        df = read_ucm_csv(CSV_PATH)
        csv_dba = df["SND_dBA"].to_numpy(dtype=float)
        n_csv = len(csv_dba)

        for path, label, strip_gain in candidates:
            audio, fs = sf.read(path, dtype="float32", always_2d=True)
            mono = audio.mean(axis=1)
            last_aud = _last_audible_second(mono, fs)
            if last_aud >= 0 and last_aud < n_csv - 30:
                continue
            if strip_gain:
                cal_n = min(CALIB_SECONDS, n_csv)
                dbfs0 = per_second_dbfs(mono, fs, min(n_csv, len(mono) // fs))
                offset_db = spl_offset(csv_dba[: len(dbfs0)], dbfs0, cal_n)
                audio, inv_note = invert_tail_gain(
                    audio,
                    fs,
                    csv_dba,
                    offset_db,
                    TAIL_GAIN_ONSET_S,
                    max_iters=12,
                )
                return audio, fs, f"offset_only_source:{label}; {inv_note}"
            return audio, fs, f"offset_only_source:{label}"

        raise FileNotFoundError(
            "offset-only mode needs a revert/tailfix/Old backup with audible tail"
        )

    audio, fs = sf.read(WAV_PATH, dtype="float32", always_2d=True)
    n_csv = len(read_ucm_csv(CSV_PATH))
    dur_s = audio.shape[0] / fs
    if dur_s > n_csv + 1.0 and PRE_AMP_BACKUP.exists():
        audio, fs = sf.read(PRE_AMP_BACKUP, dtype="float32", always_2d=True)
        return audio, fs, "restored_from_pre_amp_bak_overlong_main"
    return audio, fs, "used_main_wav"


def _crossfade_append(base: np.ndarray, extension: np.ndarray, fade_n: int) -> np.ndarray:
    if extension.size == 0:
        return base
    if fade_n <= 0 or base.shape[0] < fade_n or extension.shape[0] < fade_n:
        return np.vstack([base, extension]) if base.ndim > 1 else np.concatenate([base, extension])

    if base.ndim > 1:
        fade_out = np.linspace(1.0, 0.0, fade_n)[:, np.newaxis]
        fade_in = np.linspace(0.0, 1.0, fade_n)[:, np.newaxis]
        overlap = base[-fade_n:] * fade_out + extension[:fade_n] * fade_in
        return np.vstack([base[:-fade_n], overlap, extension[fade_n:]])

    fade_out = np.linspace(1.0, 0.0, fade_n)
    fade_in = np.linspace(0.0, 1.0, fade_n)
    overlap = base[-fade_n:] * fade_out + extension[:fade_n] * fade_in
    return np.concatenate([base[:-fade_n], overlap, extension[fade_n:]])


def extend_audio_naturally(
    audio: np.ndarray, fs: int, n_csv: int
) -> tuple[np.ndarray, list[str]]:
    """Pad to CSV row count by looping the last real second with short crossfades."""
    actions: list[str] = []
    target_samples = n_csv * fs
    n_samples = audio.shape[0]
    if n_samples >= target_samples:
        if n_samples > target_samples:
            actions.append(
                f"clip end: {n_samples/fs:.3f}s -> {n_csv}s ({n_samples - target_samples} samples)"
            )
        return audio[:target_samples], actions

    missing_s = (target_samples - n_samples) / fs
    loop_n = min(int(NATURAL_EXTEND_LOOP_S * fs), n_samples)
    fade_n = int(NATURAL_EXTEND_CROSSFADE_S * fs)
    loop_src = audio[-loop_n:]
    actions.append(
        f"extend naturally: {n_samples/fs:.3f}s -> {n_csv}s (+{missing_s:.3f}s); "
        f"loop last {loop_n/fs:.2f}s with {fade_n/fs:.2f}s crossfade (no SPL gain)"
    )

    out = audio
    while out.shape[0] < target_samples:
        need = target_samples - out.shape[0]
        chunk = loop_src if need >= loop_n else loop_src[:need]
        prev_len = out.shape[0]
        if chunk.shape[0] <= fade_n:
            out = np.vstack([out, chunk]) if out.ndim > 1 else np.concatenate([out, chunk])
        else:
            out = _crossfade_append(out, chunk, fade_n)
            if out.shape[0] <= prev_len:
                out = (
                    np.vstack([out, chunk])
                    if out.ndim > 1
                    else np.concatenate([out, chunk])
                )
    if out.shape[0] > target_samples:
        out = out[:target_samples]
    return out, actions


def align_duration_offset_only(
    audio: np.ndarray, fs: int, n_csv: int
) -> tuple[np.ndarray, list[str]]:
    return extend_audio_naturally(audio, fs, n_csv)


def refine_per_second_gain(
    audio: np.ndarray,
    fs: int,
    csv_dba: np.ndarray,
    offset_db: float,
    start_s: int,
    end_s: int,
    max_passes: int = 5,
    tol_db: float = 0.25,
) -> np.ndarray:
    out = audio.astype(np.float64, copy=True)
    for _ in range(max_passes):
        mono = out.mean(axis=1)
        any_change = False
        for i in range(start_s, end_s):
            s0, s1 = i * fs, (i + 1) * fs
            est = rms_dbfs(mono[s0:s1]) + offset_db
            err = float(csv_dba[i] - est)
            if not np.isfinite(err) or abs(err) <= tol_db:
                continue
            g = 10.0 ** (err / 20.0)
            out[s0:s1] *= g
            any_change = True
        out = np.clip(out, -0.999, 0.999)
        if not any_change:
            break
    return out.astype(np.float32)


def seconds_over_tolerance(abs_err: np.ndarray, tol: float) -> list[dict[str, float]]:
    bad = []
    for i, e in enumerate(abs_err):
        if np.isfinite(e) and e > tol:
            bad.append({"second": float(i), "abs_err_db": float(e)})
    return bad


def main(
    apply_fix: bool = True, offset_only: bool = False, skip_backup: bool = False
) -> dict:
    df = read_ucm_csv(CSV_PATH)
    n_csv = len(df)
    stamp = datetime.strptime(WAV_PATH.stem, "%Y%m%d_%H%M%S")
    t0_csv = df["ts"].iloc[0].to_pydatetime()
    csv_dba_full = df["SND_dBA"].to_numpy(dtype=float)

    audio_main, fs_main = sf.read(WAV_PATH, dtype="float32", always_2d=True)
    wav_before_s = float(audio_main.shape[0] / fs_main)

    metrics_before_revert: dict | None = None
    if offset_only and apply_fix and WAV_PATH.exists():
        mono_main = audio_main.mean(axis=1)
        n_eval = min(n_csv, len(mono_main) // fs_main)
        cal_n = min(CALIB_SECONDS, n_eval)
        dbfs_main = per_second_dbfs(mono_main, fs_main, n_eval)
        off_main = spl_offset(csv_dba_full[:n_eval], dbfs_main, cal_n)
        _, _, abs_main = evaluate_alignment(
            mono_main, fs_main, n_eval, csv_dba_full[:n_eval], off_main
        )
        onset_main = detect_mismatch_onset(abs_main)
        metrics_before_revert = metrics(abs_main, onset_main)
        metrics_before_revert["mode"] = "exact_tail_gain_on_disk_before_revert"

    copy_audio = None
    copy_onset = None
    if COPY_WAV_PATH.exists():
        copy_audio, fs_c = sf.read(COPY_WAV_PATH, dtype="float32", always_2d=True)
        if fs_c != fs_main:
            copy_audio = None
        else:
            copy_onset = copy_silence_onset(copy_audio.mean(axis=1), fs_main)

    audio, fs, load_note = load_working_audio(offset_only=offset_only)
    mono = audio.mean(axis=1)
    n_align_before = min(n_csv, len(mono) // fs)
    cal_n = min(CALIB_SECONDS, n_align_before)
    dbfs0 = per_second_dbfs(mono, fs, n_align_before)
    offset_db = spl_offset(csv_dba_full[:n_align_before], dbfs0, cal_n)
    _, _, abs_err_before = evaluate_alignment(
        mono, fs, n_align_before, csv_dba_full[:n_align_before], offset_db
    )
    onset = detect_mismatch_onset(abs_err_before)

    report: dict = {
        "csv_path": str(CSV_PATH),
        "wav_path": str(WAV_PATH),
        "columns": {"time": "GPS_time", "sound": "SND_dBA"},
        "csv_rows": int(n_csv),
        "csv_time_span_s": float(
            (df["ts"].iloc[-1] - df["ts"].iloc[0]).total_seconds()
        ),
        "audit_before": {
            "main_wav_duration_s": wav_before_s,
            "working_audio_source": load_note,
            "working_duration_s": float(len(mono) / fs),
            "aligned_seconds": int(n_align_before),
            "csv_rows_without_wav_samples": int(n_csv - n_align_before),
            "longer_than_csv": (
                "wav"
                if len(mono) / fs > n_csv
                else "csv"
                if n_csv > len(mono) / fs
                else "equal_at_integer_seconds"
            ),
        },
        "wav_sample_rate": int(fs),
        "mode": "offset_only" if offset_only else "tail_gain_match_csv",
        "alignment": {
            "method": (
                "WAV stem timestamp equals first CSV GPS_time; "
                "1 s windows; mono mean of stereo channels; "
                "rms_dbfs per sound_yamnet_frequency.py; "
                "SPL offset = median(CSV - dBFS) over first 120 s"
                + (
                    "; offset-only: no gain baked into WAV (analysis uses offset only)"
                    if offset_only
                    else "; tail: per-second linear gain from mismatch onset"
                )
            ),
            "wav_filename_time": stamp.isoformat(),
            "first_csv_time": t0_csv.isoformat(),
            "calibration_offset_db": offset_db,
            "tolerance_db": TOLERANCE_DB,
            "project_note": (
                "Repo does not recompute uCM SND_dBA from WAV; "
                "YAMNet pipeline uses uncalibrated dBFS only"
            ),
        },
        "mismatch": {
            "onset_index_s": int(onset),
            "duration_s": float(n_align_before - onset),
            "copy_wav_silence_onset_s": copy_onset,
        },
        "metrics_before": metrics(abs_err_before, onset),
        "actions": [],
        "backups": {},
    }
    if metrics_before_revert is not None:
        report["metrics_before_revert"] = metrics_before_revert

    if apply_fix:
        if offset_only:
            if WAV_PATH.exists() and not skip_backup:
                dest = PRE_OFFSET_ONLY_REVERT_BACKUP
                if dest.exists():
                    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
                    dest = WAV_PATH.with_name(
                        WAV_PATH.name + f".pre_offset_only_revert_{ts}.bak"
                    )
                try:
                    shutil.copy2(WAV_PATH, dest)
                    report["backups"]["pre_offset_only_revert"] = str(dest)
                except OSError as exc:
                    report["actions"].append(
                        f"backup skipped ({exc}); using existing revert backups"
                    )
            elif skip_backup:
                report["actions"].append("backup skipped (--no-backup)")
            report["actions"].append(load_note)
            if audio.shape[0] > NATURAL_RECORDING_SAMPLES:
                trim = audio.shape[0] - NATURAL_RECORDING_SAMPLES
                audio = audio[:NATURAL_RECORDING_SAMPLES]
                report["actions"].append(
                    f"trim SPL/synthetic tail: removed last {trim/fs:.3f}s "
                    f"({trim} samples) before natural extend"
                )
            audio, dur_act = align_duration_offset_only(audio, fs, n_csv)
            report["actions"].extend(dur_act)
            out = audio.astype(np.float32)
            report["actions"].append(
                "no per-second gain applied; natural recording levels throughout"
            )
        else:
            if WAV_PATH.exists():
                report["backups"]["pre_duration"] = str(
                    backup_wav(WAV_PATH, ".pre_duration.bak")
                )

            duration_actions: list[str] = [load_note]
            audio, dur_act = align_duration_to_csv(
                audio, fs, n_csv, csv_dba_full, offset_db, copy_audio
            )
            duration_actions.extend(dur_act)
            report["actions"].extend(duration_actions)
            out = audio

        assert out.shape[0] == n_csv * fs
        mono = out.mean(axis=1)
        dbfs_d = per_second_dbfs(mono, fs, n_csv)
        offset_db = spl_offset(csv_dba_full, dbfs_d, min(CALIB_SECONDS, n_csv))
        est_d, _, abs_d = evaluate_alignment(mono, fs, n_csv, csv_dba_full, offset_db)
        report["alignment"]["calibration_offset_db"] = offset_db
        report["audit_after_duration"] = {
            "wav_duration_s": float(out.shape[0] / fs),
            "wav_samples": int(out.shape[0]),
            "expected_samples": int(n_csv * fs),
        }

        gain_db = csv_dba_full - est_d
        report["gain_plan"] = {
            "formula": (
                "analysis-only offset (no baked gain)"
                if offset_only
                else "linear_gain = 10^((CSV_SND_dBA - (dBFS+offset))/20) per second from onset"
            ),
            "median_gain_db_tail": float(np.nanmedian(gain_db[onset:n_csv])),
            "mean_gain_db_tail": float(np.nanmean(gain_db[onset:n_csv])),
        }

        subtype = sf.info(WAV_PATH).subtype if WAV_PATH.exists() else "PCM_32"
        if subtype == "PCM_16":
            # Match other P10 ucm/snd routes (pcm_s32le @ 44100 stereo); never write PCM_16.
            subtype = "PCM_32"

        if not offset_only:
            sf.write(WAV_PATH, out, fs, subtype=subtype)
            report["backups"]["pre_tailfix"] = str(backup_wav(WAV_PATH, ".pre_tailfix.bak"))

            out = apply_tail_gain(out, fs, onset, n_csv, gain_db)
            refine_start = max(onset, n_csv - 60)
            out = refine_per_second_gain(
                out, fs, csv_dba_full, offset_db, refine_start, n_csv, max_passes=6
            )
            out = refine_per_second_gain(
                out,
                fs,
                csv_dba_full,
                offset_db,
                max(0, n_csv - 10),
                n_csv,
                max_passes=8,
                tol_db=0.15,
            )
            report["actions"].append(
                f"tail_gain from s{onset} with {GAIN_FADE_S}s fade; "
                f"refine s{refine_start}-{n_csv - 1} then last 10s"
            )

        sf.write(WAV_PATH, out, fs, subtype=subtype)

        mono2 = out.mean(axis=1)
        est2, _, abs2 = evaluate_alignment(mono2, fs, n_csv, csv_dba_full, offset_db)
        report["metrics_after"] = metrics(abs2, onset)
        report["metrics_after"]["max_abs_err_tail"] = float(np.nanmax(abs2[onset:n_csv]))
        report["metrics_after"]["max_abs_err_all"] = float(np.nanmax(abs2))
        report["metrics_after"]["corr"] = float(
            np.corrcoef(est2[np.isfinite(est2)], csv_dba_full[np.isfinite(est2)])[0, 1]
        )
        report["seconds_over_tolerance"] = seconds_over_tolerance(abs2, TOLERANCE_DB)
        report["audit_after"] = {
            "wav_duration_s": float(out.shape[0] / fs),
            "wav_samples": int(out.shape[0]),
            "csv_rows": n_csv,
            "duration_match": out.shape[0] == n_csv * fs,
        }
        if offset_only:
            report["tradeoffs"] = (
                "WAV keeps natural mic levels; CSV SND_dBA alignment is offset-only "
                f"(median first {CALIB_SECONDS}s). Tail MAE ~4–9 dB expected, not ~0 dB."
            )
        else:
            report["tradeoffs"] = (
                "Per-second RMS targets can exceed 0 dBFS after large gains; "
                "samples clipped to +/-0.999 may leave |error|>0.5 dB on peak-heavy seconds."
            )
    else:
        gain_db = csv_dba_full[:n_align_before] - (dbfs0 + offset_db)
        report["gain_plan"] = {
            "formula": "linear_gain = 10^((CSV_SND_dBA - (dBFS+offset))/20) per second from onset",
            "median_gain_db_tail": float(np.nanmedian(gain_db[onset:n_align_before])),
            "mean_gain_db_tail": float(np.nanmean(gain_db[onset:n_align_before])),
        }

    REPORT_PATH.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps(report, indent=2))
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="P10 WalkG WAV vs CSV SND_dBA alignment")
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Audit only; do not write WAV",
    )
    parser.add_argument(
        "--offset-only",
        action="store_true",
        help="Revert to natural levels: no tail gain; extend tail naturally to CSV length",
    )
    parser.add_argument(
        "--no-backup",
        action="store_true",
        help="Do not copy the current WAV before writing (offset-only reruns)",
    )
    args = parser.parse_args()
    main(
        apply_fix=not args.dry_run,
        offset_only=args.offset_only,
        skip_backup=args.no_backup,
    )

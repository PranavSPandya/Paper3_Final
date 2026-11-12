"""Association plots: compounded environmental stress vs outcomes (10 s or phase mean)."""
from __future__ import annotations

import math
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.lines import Line2D
from scipy import stats

FALLBACK_ROOT = Path(r"C:\Users\sanga\Desktop\Pranav Paper3_Final")
MERGED_REL = Path("output") / "merged_all_11participants_8min.csv"
NORM_REL = (
    Path("output")
    / "statistical_analysis"
    / "Normalization & Parameter Screening"
    / "Normalization"
    / "Normalization_H1toH4_all_parameters.csv"
)

PARTICIPANTS = ["P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"]
PHASES = ["BikeU", "WalkU", "BikeG", "WalkG"]
MATCHED_CAP_SEC = 480

PHYSIO = [
    "empatica_heart_rate",
    "empatica_eda_tonic",
    "empatica_eda_phasic",
    "empatica_skin_temperature",
    "empatica_hrv_td_sdnn",
    "empatica_hrv_td_rmssd",
    "empatica_hrv_fd_lf",
    "empatica_hrv_fd_hf",
    "empatica_hrv_fd_lf_hf_ratio",
    "empatica_hrv_fd_lfnu",
    "empatica_hrv_fd_hfnu",
    "empatica_hrv_fd_vlf",
    "empatica_hrv_fd_total_power",
    "eyetracker_pupil_diameter_avg",
    "eyetracker_pupil_change_rate",
    "eyetracker_blink_duration_s",
    "eyetracker_fixation_duration_s",
    "eyetracker_fixation_rate",
    "eyetracker_saccade_duration_s",
    "eyetracker_saccade_amplitude",
    "eyetracker_saccade_peak_velocity",
    "eyetracker_gaze_velocity",
    "eyetracker_gaze_dispersion",
    "eyetracker_distance_from_center",
    "eyetracker_gaze_centrality",
    "eyetracker_eyelid_aperture_avg",
]

QUESTIONNAIRES = [
    "questionnaire_current_comfort_1_7",
    "questionnaire_space_familiarity_1_5",
    "questionnaire_pleasantness_1_5",
    "questionnaire_thermal_comfort_1_5",
    "questionnaire_acoustic_comfort_1_5",
    "questionnaire_visual_comfort_1_5",
    "questionnaire_air_quality_comfort_1_5",
    "questionnaire_odor_comfort_1_5",
    "questionnaire_stai_calm_rev_1_5",
    "questionnaire_stai_tense_1_5",
    "questionnaire_stai_upset_1_5",
    "questionnaire_stai_relaxed_rev_1_5",
    "questionnaire_stai_content_rev_1_5",
    "questionnaire_stai_worried_1_5",
    "questionnaire_prs11_fascination_mean_1_5",
    "questionnaire_prs11_being_away_mean_1_5",
    "questionnaire_prs11_coherence_mean_1_5",
    "questionnaire_prs11_scope_mean_1_5",
]

PHASE_STYLE = {
    "WalkG": {"color": "#2ca02c", "marker": "s"},
    "BikeG": {"color": "#2ca02c", "marker": "^"},
    "WalkU": {"color": "#ff7f0e", "marker": "s"},
    "BikeU": {"color": "#ff7f0e", "marker": "^"},
}
MARKER_SIZE_PHASE = 52
MARKER_SIZE_EPOCH = 16
ALPHA_PHASE = 0.72
ALPHA_EPOCH = 0.38
GREEN = "#2ca02c"
ORANGE = "#ff7f0e"
STRESS_FORMULA = "Stress Z = (Z_UTCI + Z_dBA + Z_BVF − Z_TVF) / 4"


def resolve_root() -> Path:
    for candidate in (Path.cwd().parent, Path.cwd(), FALLBACK_ROOT):
        if (candidate / MERGED_REL).exists():
            return candidate
    return FALLBACK_ROOT


def _natural_log(x: np.ndarray) -> np.ndarray:
    x = np.asarray(x, float)
    return np.where(np.isfinite(x) & (x > 0), np.log(x), np.nan)


def _prepare_epochs(root: Path) -> pd.DataFrame:
    path = root / MERGED_REL
    header = pd.read_csv(path, nrows=0).columns
    usecols = (
        ["ParticipantID", "PhaseID", "Datetime", "ucm_UTCI", "ucm_SND_dBA", "BVF", "TVF", "SVF"]
        + PHYSIO
        + QUESTIONNAIRES
    )
    if "empatica_hrv_fd_5min_available" in header:
        usecols.append("empatica_hrv_fd_5min_available")

    epochs = pd.read_csv(path, usecols=lambda c: c in usecols, low_memory=False)
    epochs = epochs[epochs.ParticipantID.isin(PARTICIPANTS) & epochs.PhaseID.isin(PHASES)].copy()
    epochs["Datetime"] = pd.to_datetime(epochs["Datetime"])
    epochs = epochs.sort_values(["ParticipantID", "PhaseID", "Datetime"])
    epochs["time_in_phase_sec"] = epochs.groupby(["ParticipantID", "PhaseID"]).Datetime.transform(
        lambda x: (x - x.min()).dt.total_seconds()
    )

    durations = epochs.groupby(["ParticipantID", "PhaseID"])["time_in_phase_sec"].max().unstack("PhaseID")
    caps = durations[PHASES].min(axis=1).clip(upper=MATCHED_CAP_SEC)
    epochs["Common_cap"] = epochs.ParticipantID.map(caps.to_dict())
    epochs = epochs[epochs.time_in_phase_sec <= epochs.Common_cap].copy()

    norm = pd.read_csv(root / NORM_REL).set_index("column_name")
    for col in PHYSIO:
        if col not in epochs.columns:
            continue
        tr = norm.loc[col, "transformation_in_models"] if col in norm.index else "No transformation"
        if tr == "Natural log":
            epochs[col] = _natural_log(epochs[col].to_numpy())

    if "empatica_hrv_fd_5min_available" in epochs.columns:
        ok = epochs.empatica_hrv_fd_5min_available.astype(str).str.lower().isin(["true", "1"])
        for col in PHYSIO[6:13]:
            epochs.loc[~ok, col] = np.nan

    epochs["PhaseID"] = pd.Categorical(epochs["PhaseID"], categories=PHASES, ordered=True)
    return epochs.reset_index(drop=True)


def pooled_z(values: pd.Series) -> np.ndarray:
    v = values.to_numpy(dtype=float)
    m = np.nanmean(v)
    s = np.nanstd(v, ddof=1)
    if not np.isfinite(s) or s < 1e-12:
        return np.zeros_like(v)
    return (v - m) / s


def add_compounded_stress(
    frame: pd.DataFrame,
    *,
    dba_col: str = "ucm_SND_dBA",
) -> pd.DataFrame:
    out = frame.copy()
    out["stress_z"] = (
        pooled_z(out["ucm_UTCI"])
        + pooled_z(out[dba_col])
        + pooled_z(out["BVF"])
        - pooled_z(out["TVF"])
    ) / 4.0
    return out


def load_epoch_table(root: Path) -> pd.DataFrame:
    """One row per matched 10 s epoch (48 × 11 × 4 = 2112 when complete)."""
    epochs = _prepare_epochs(root)
    return add_compounded_stress(epochs, dba_col="ucm_SND_dBA")


def load_phase_table(root: Path) -> pd.DataFrame:
    """Participant × phase means for end-of-phase questionnaire scores."""
    epochs = _prepare_epochs(root)

    def energy_mean_db(series: pd.Series) -> float:
        x = series.to_numpy(dtype=float)
        x = x[np.isfinite(x)]
        if x.size == 0:
            return np.nan
        return float(10 * np.log10(np.mean(10 ** (x / 10))))

    agg_cols = QUESTIONNAIRES + ["ucm_UTCI", "BVF", "TVF", "SVF"]
    means = epochs.groupby(["ParticipantID", "PhaseID"], as_index=False)[agg_cols].mean()
    dba = (
        epochs.groupby(["ParticipantID", "PhaseID"])["ucm_SND_dBA"]
        .apply(energy_mean_db)
        .reset_index(name="ucm_SND_dBA_energy")
    )
    phase = means.merge(dba, on=["ParticipantID", "PhaseID"], how="left")
    return add_compounded_stress(phase, dba_col="ucm_SND_dBA_energy")


def outcome_label(root: Path, column: str) -> str:
    norm = root / NORM_REL
    if norm.exists():
        table = pd.read_csv(norm).set_index("column_name")
        if column in table.index:
            label = str(table.at[column, "parameter_label"])
            if column in PHYSIO and table.at[column, "transformation_in_models"] == "Natural log":
                return f"ln {label}"
            return label
    text = column.replace("questionnaire_", "").replace("_mean_1_5", "").replace("_1_7", "").replace("_", " ")
    return text.title()


def _format_p(p: float) -> str:
    if not np.isfinite(p):
        return "p = NA"
    if p < 0.001:
        return "p < 0.001"
    if p < 0.01:
        return f"p = {p:.3f}"
    return f"p = {p:.2f}"


def draw_association_axis(
    ax,
    data: pd.DataFrame,
    outcome: str,
    ylab: str,
    *,
    show_xlabel: bool = False,
    marker_size: float = MARKER_SIZE_PHASE,
    alpha: float = ALPHA_PHASE,
) -> None:
    sub = data[["PhaseID", "ParticipantID", "stress_z", outcome]].copy()
    sub = sub[np.isfinite(sub.stress_z) & np.isfinite(sub[outcome])]
    for pid in PHASES:
        rows = sub[sub.PhaseID == pid]
        if rows.empty:
            continue
        sty = PHASE_STYLE[pid]
        ax.scatter(
            rows.stress_z,
            rows[outcome],
            c=sty["color"],
            marker=sty["marker"],
            s=marker_size,
            alpha=alpha,
            edgecolors="none",
            linewidths=0,
            zorder=2,
        )

    x = sub.stress_z.to_numpy()
    y = sub[outcome].to_numpy()
    if x.size >= 3:
        slope, intercept, r, p, _ = stats.linregress(x, y)
        xs = np.linspace(np.nanmin(x), np.nanmax(x), 50)
        ax.plot(xs, intercept + slope * xs, color="#1a535c", lw=1.4, zorder=3)
        n_txt = f"n = {x.size}"
        ax.text(
            0.03,
            0.97,
            f"{n_txt}\nr = {r:.2f}\n{_format_p(p)}",
            transform=ax.transAxes,
            va="top",
            ha="left",
            fontsize=6.5,
            bbox=dict(boxstyle="round,pad=0.25", facecolor="white", edgecolor="#cccccc", alpha=0.9),
        )

    ax.set_title(ylab, fontsize=7, loc="left", pad=2)
    ax.grid(True, linestyle="--", linewidth=0.4, alpha=0.45)
    ax.tick_params(labelsize=6)
    if show_xlabel:
        ax.set_xlabel("Compounded environmental stress (Z)", fontsize=7)
    else:
        ax.set_xticklabels([])


def save_single(fig, path_base: Path) -> None:
    path_base.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(path_base.with_suffix(".png"), dpi=300, bbox_inches="tight", facecolor="white")
    fig.savefig(path_base.with_suffix(".svg"), bbox_inches="tight", facecolor="white")
    plt.close(fig)


def phase_legend(fig) -> None:
    handles = [
        Line2D([], [], marker="s", ls="", color=GREEN, markersize=7, label="WalkG (square)"),
        Line2D([], [], marker="^", ls="", color=GREEN, markersize=7, label="BikeG (triangle)"),
        Line2D([], [], marker="s", ls="", color=ORANGE, markersize=7, label="WalkU (square)"),
        Line2D([], [], marker="^", ls="", color=ORANGE, markersize=7, label="BikeU (triangle)"),
    ]
    fig.legend(handles=handles, loc="upper center", ncol=4, frameon=False, fontsize=7, bbox_to_anchor=(0.5, 0.99))


def build_grid(
    data: pd.DataFrame,
    outcomes: list[str],
    root: Path,
    out_dir: Path,
    stem: str,
    *,
    ncol: int = 5,
    subtitle: str,
    marker_size: float,
    alpha: float,
    subdir: str,
) -> list[Path]:
    saved: list[Path] = []
    nrow = math.ceil(len(outcomes) / ncol)
    fig_w = ncol * 2.35
    fig_h = nrow * 2.15 + 0.55
    fig, axes = plt.subplots(nrow, ncol, figsize=(fig_w, fig_h), squeeze=False)
    fig.subplots_adjust(left=0.06, right=0.99, top=0.92, bottom=0.08, wspace=0.28, hspace=0.55)

    for i, outcome in enumerate(outcomes):
        r, c = divmod(i, ncol)
        ylab = outcome_label(root, outcome)
        draw_association_axis(
            axes[r][c],
            data,
            outcome,
            ylab,
            show_xlabel=(r == nrow - 1),
            marker_size=marker_size,
            alpha=alpha,
        )
        single = plt.figure(figsize=(3.2, 3.0))
        sax = single.add_subplot(111)
        draw_association_axis(
            sax, data, outcome, ylab, show_xlabel=True, marker_size=marker_size, alpha=alpha
        )
        sax.set_ylabel(ylab, fontsize=7)
        one_path = out_dir / subdir / outcome
        save_single(single, one_path)
        saved.append(one_path.with_suffix(".png"))

    for j in range(len(outcomes), nrow * ncol):
        r, c = divmod(j, ncol)
        axes[r][c].set_axis_off()

    for r in range(nrow - 1):
        for c in range(ncol):
            axes[r][c].set_xlabel("")

    fig.suptitle(f"{subtitle}\n{STRESS_FORMULA}", fontsize=8, y=0.995)
    phase_legend(fig)
    grid_base = out_dir / stem
    save_single(fig, grid_base)
    saved.append(grid_base.with_suffix(".png"))
    return saved


def run_all(root: Path | None = None, ncol: int = 5) -> Path:
    root = root or resolve_root()
    out_dir = root / "Figures" / "Association figures"
    out_dir.mkdir(parents=True, exist_ok=True)

    epochs = load_epoch_table(root)
    phase = load_phase_table(root)
    n_ep = len(epochs)
    per_phase = epochs.groupby(["ParticipantID", "PhaseID"]).size()
    print(f"Epoch rows: {n_ep} (expected 2112); per participant×phase: min={per_phase.min()}, max={per_phase.max()}")

    plt.rcParams.update(
        {
            "font.family": "DejaVu Sans",
            "axes.spines.top": False,
            "axes.spines.right": False,
            "pdf.fonttype": 42,
        }
    )
    paths = []
    paths.extend(
        build_grid(
            epochs,
            PHYSIO,
            root,
            out_dir,
            "Association_physiological_all",
            ncol=ncol,
            subtitle="Matched 10 s epochs (one marker per row; ln outcomes per analysis register)",
            marker_size=MARKER_SIZE_EPOCH,
            alpha=ALPHA_EPOCH,
            subdir="physiological",
        )
    )
    paths.extend(
        build_grid(
            phase,
            QUESTIONNAIRES,
            root,
            out_dir,
            "Association_questionnaire_all",
            ncol=ncol,
            subtitle="Participant × phase means (end-of-phase questionnaire; dBA = energy mean)",
            marker_size=MARKER_SIZE_PHASE,
            alpha=ALPHA_PHASE,
            subdir="questionnaire",
        )
    )
    print(f"Wrote {len(paths)} PNG paths under {out_dir}")
    return out_dir


if __name__ == "__main__":
    run_all()

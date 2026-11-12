"""H4 context plot: 11 participants on x.

Left: acoustic comfort (bar) over 10 s dBA (box).
Right: thermal comfort (box) over UTCI (bar).
"""
from pathlib import Path
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.patches import Patch, FancyBboxPatch
from matplotlib.gridspec import GridSpec

ROOT = Path(r"C:\Users\sanga\Desktop\Pranav Paper3_Final")
OUT = ROOT / "Figures"
PARTICIPANTS = ["P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"]
PHASES = ["WalkG", "WalkU", "BikeG", "BikeU"]
PHASE_COL = {"BikeU": "#a50f15", "WalkU": "#f08a5d", "BikeG": "#006d2c", "WalkG": "#74c476"}
OFFSET = np.array([-0.36, -0.12, 0.12, 0.36])
WIDTH = 0.20


def energy_mean(s):
    s = pd.to_numeric(s, errors="coerce")
    s = s[np.isfinite(s)]
    if s.empty:
        return np.nan
    return float(10 * np.log10(np.mean(np.power(10.0, s / 10.0))))


def load():
    df = pd.read_csv(ROOT / "output" / "merged_all_11participants_8min.csv", low_memory=False)
    df = df[df.PhaseID.isin(PHASES) & df.ParticipantID.isin(PARTICIPANTS)].copy()
    df["ucm_SND_dBA"] = pd.to_numeric(df.ucm_SND_dBA, errors="coerce")
    df["ucm_UTCI"] = pd.to_numeric(df.ucm_UTCI, errors="coerce")
    df["thermal"] = pd.to_numeric(df.questionnaire_thermal_comfort_1_5, errors="coerce")
    df["acoustic"] = pd.to_numeric(df.questionnaire_acoustic_comfort_1_5, errors="coerce")
    bout = (
        df.groupby(["ParticipantID", "PhaseID"], sort=False)
        .agg(utci=("ucm_UTCI", "mean"), thermal=("thermal", "first"),
             acoustic=("acoustic", "first"), dba_em=("ucm_SND_dBA", energy_mean))
        .reset_index()
    )
    return df, bout


def style_x(ax, label=False):
    ax.set_xlim(-0.7, len(PARTICIPANTS) - 0.3)
    ax.set_xticks(np.arange(len(PARTICIPANTS)))
    ax.set_xticklabels(PARTICIPANTS if label else [])
    if label:
        ax.set_xlabel("Participant")
    for k in range(len(PARTICIPANTS) - 1):
        ax.axvline(k + 0.5, color="#d9dee7", lw=0.5, zorder=1)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)


def draw():
    df, bout = load()
    plt.rcParams.update({
        "font.family": "DejaVu Sans", "font.size": 8, "axes.titlesize": 10,
        "axes.labelsize": 8, "xtick.labelsize": 8, "ytick.labelsize": 7.5,
        "legend.fontsize": 8, "axes.linewidth": 0.6, "pdf.fonttype": 42, "savefig.dpi": 300,
    })
    fig = plt.figure(figsize=(13.8, 7.2), facecolor="white")
    gs = GridSpec(2, 2, figure=fig, height_ratios=[1.05, 1.55], hspace=0.08, wspace=0.28,
                  left=0.07, right=0.98, top=0.88, bottom=0.16)
    ax_ac = fig.add_subplot(gs[0, 0])
    ax_dba = fig.add_subplot(gs[1, 0], sharex=ax_ac)
    ax_th = fig.add_subplot(gs[0, 1])
    ax_utci = fig.add_subplot(gs[1, 1], sharex=ax_th)

    for ax in (ax_ac, ax_dba, ax_th, ax_utci):
        for i in range(len(PARTICIPANTS)):
            ax.axvspan(i - 0.48, i + 0.48, color="#f4f6f8" if i % 2 == 0 else "white", zorder=0)

    for i, pid in enumerate(PARTICIPANTS):
        for j, phase in enumerate(PHASES):
            pos = i + OFFSET[j]
            col = PHASE_COL[phase]
            dba = df.loc[(df.ParticipantID == pid) & (df.PhaseID == phase), "ucm_SND_dBA"].dropna().to_numpy()
            row = bout[(bout.ParticipantID == pid) & (bout.PhaseID == phase)]
            if row.empty:
                continue
            r = row.iloc[0]
            ax_ac.bar(pos, r.acoustic, width=WIDTH, color=col, alpha=0.9, edgecolor="#222222", linewidth=0.4, zorder=3)
            if dba.size:
                ax_dba.boxplot(
                    [dba], positions=[pos], widths=WIDTH, whis=(5, 95), showfliers=False,
                    patch_artist=True, zorder=3, manage_ticks=False,
                    medianprops=dict(color="#111111", lw=0.9),
                    whiskerprops=dict(color="#333333", lw=0.6),
                    capprops=dict(color="#333333", lw=0.6),
                    boxprops=dict(facecolor=col, alpha=0.55, edgecolor="#222222", lw=0.6),
                )
            ax_utci.bar(pos, r.utci, width=WIDTH, color=col, alpha=0.9, edgecolor="#222222", linewidth=0.4, zorder=3)
            ax_th.add_patch(FancyBboxPatch(
                (pos - WIDTH / 2, r.thermal - 0.18), WIDTH, 0.36,
                boxstyle="square,pad=0", linewidth=0.8, edgecolor="#111111",
                facecolor=col, alpha=0.95, zorder=4,
            ))

    ax_ac.set_ylim(0.6, 5.6)
    ax_ac.set_yticks([1, 2, 3, 4, 5])
    ax_ac.set_ylabel("Acoustic comfort (1–5)")
    ax_ac.set_title("A  ·  Acoustic comfort (bar) and dBA (box)", loc="left", fontweight="bold")
    style_x(ax_ac, label=False)
    plt.setp(ax_ac.get_xticklabels(), visible=False)

    ax_dba.set_ylim(50, 88)
    ax_dba.set_ylabel("Sound level, 10 s (dB(A))")
    style_x(ax_dba, label=True)

    ax_th.set_ylim(0.6, 5.6)
    ax_th.set_yticks([1, 2, 3, 4, 5])
    ax_th.set_ylabel("Thermal comfort (1–5)")
    ax_th.set_title("B  ·  Thermal comfort (box) and UTCI (bar)", loc="left", fontweight="bold")
    style_x(ax_th, label=False)
    plt.setp(ax_th.get_xticklabels(), visible=False)

    ax_utci.set_ylim(18, 38)
    ax_utci.set_ylabel("UTCI (°C)")
    style_x(ax_utci, label=True)

    handles = [Patch(facecolor=PHASE_COL[p], edgecolor="#222222", label=p) for p in PHASES]
    fig.legend(handles=handles, loc="lower center", ncol=4, frameon=False, bbox_to_anchor=(0.5, 0.02))
    fig.suptitle("Exposure and comfort votes by participant", fontsize=13, fontweight="bold", y=0.98, color="#18334d")
    fig.text(
        0.5, 0.075,
        "Walking pair: smaller dBA gap, larger UTCI gap. Cycling pair: larger dBA gap, smaller UTCI gap. "
        "Votes are one rating per bout. dBA boxes are 10 s samples (5–95 % whiskers). Not the H4 test.",
        ha="center", fontsize=7.5, color="#475569",
    )
    OUT.mkdir(parents=True, exist_ok=True)
    stem = OUT / "H4_participant_exposure_votes"
    fig.savefig(stem.with_suffix(".svg"), bbox_inches="tight", facecolor="white")
    fig.savefig(stem.with_suffix(".png"), dpi=300, bbox_inches="tight", facecolor="white")
    plt.close(fig)
    print(f"saved {stem}.svg and {stem}.png")


if __name__ == "__main__":
    draw()

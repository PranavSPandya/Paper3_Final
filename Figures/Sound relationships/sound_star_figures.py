"""Sound-star figures: one per phase. Reads R output; writes PNG beside this file."""
from __future__ import annotations

from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.collections import LineCollection
from matplotlib.colors import LinearSegmentedColormap, Normalize, to_rgba
from matplotlib.lines import Line2D
from matplotlib.patches import Circle

ROOT = Path(r"C:\Users\sanga\Desktop\Pranav Paper3_Final")
FIG_DIR = ROOT / "Figures" / "Sound relationships"
OUT_DIR = FIG_DIR / "output"
PHASES = ("WalkG", "WalkU", "BikeG", "BikeU")
RED = "#c0392b"
GREEN = "#1e8449"
GREY = "#9aa3ad"
INK = "#1b1f24"
N_PARTICIPANTS = 11

CMAP = LinearSegmentedColormap.from_list(
    "beta_std",
    [(0.0, RED), (0.5, "#f4f1ea"), (1.0, GREEN)],
)


def is_true(val) -> bool:
    if isinstance(val, (bool, np.bool_)):
        return bool(val)
    return str(val).strip().lower() in {"true", "1", "yes"}


def id_key(val) -> tuple[int, int]:
    parts = str(val).split(".")
    return (int(parts[0]), int(parts[1]))


def sort_domain(df: pd.DataFrame) -> pd.DataFrame:
    if df.empty:
        return df
    return df.loc[sorted(df.index, key=lambda i: id_key(df.loc[i, "id"]))]


def load_tables():
    str_cols = {"id": str, "phase": str, "domain": str, "label": str, "family": str}
    spokes = pd.read_csv(OUT_DIR / "star_spokes.csv", dtype=str_cols)
    nodes = pd.read_csv(OUT_DIR / "star_nodes.csv", dtype=str_cols)
    return spokes, nodes


def vmax_beta(spokes: pd.DataFrame) -> float:
    sig = pd.to_numeric(spokes.loc[spokes["significant"].map(is_true), "beta_std"], errors="coerce")
    if sig.empty or not np.isfinite(sig.abs()).any():
        sig = pd.to_numeric(spokes["beta_std"], errors="coerce")
    vals = sig.abs()
    vals = vals[np.isfinite(vals)]
    if vals.empty:
        return 1.0
    return float(max(vals.max(), 0.05))


def stack_y(n: int, y0: float, y1: float) -> np.ndarray:
    if n <= 1:
        return np.array([(y0 + y1) / 2.0])
    return np.linspace(y1, y0, n)


def place(out: pd.DataFrame, rows: pd.DataFrame, x: float, y0: float, y1: float) -> None:
    ys = stack_y(len(rows), y0, y1)
    for idx, y in zip(rows.index, ys):
        out.at[idx, "x"] = x
        out.at[idx, "y"] = y


def layout_nodes(phase_nodes: pd.DataFrame) -> pd.DataFrame:
    out = phase_nodes.copy()
    out["x"] = np.nan
    out["y"] = np.nan
    env = sort_domain(out[out.domain == "env"])
    phys = sort_domain(out[out.domain == "physio"])
    psy = sort_domain(out[out.domain == "psycho"])
    place(out, env, 0.145, 0.12, 0.90)
    place(out, psy, 0.86, 0.12, 0.90)
    n_top = int(np.ceil(len(phys) / 2.0))
    place(out, phys.iloc[:n_top], 0.50, 0.64, 0.90)
    place(out, phys.iloc[n_top:], 0.50, 0.12, 0.36)
    return out


def spoke_style(beta: float, vmax: float) -> tuple[str, float, float]:
    mag = min(abs(beta) / vmax, 1.0)
    color = GREEN if beta > 0 else RED
    lw = 0.8 + 4.0 * mag
    alpha = 0.45 + 0.55 * mag
    return color, lw, alpha


def draw_phase(phase: str, spokes: pd.DataFrame, nodes: pd.DataFrame, vmax: float) -> None:
    phase_nodes = nodes[nodes.phase == phase].copy()
    phase_spokes = spokes[spokes.phase == phase].copy()
    lay = layout_nodes(phase_nodes)
    fig, ax = plt.subplots(figsize=(16, 12), facecolor="white")
    ax.set_facecolor("white")
    ax.set_xlim(0.0, 1.0)
    ax.set_ylim(0.0, 1.0)
    ax.axis("off")

    cx, cy = 0.50, 0.50
    n_part = pd.to_numeric(phase_nodes["n_id"], errors="coerce").max()
    n_part = int(n_part) if np.isfinite(n_part) and n_part > 0 else N_PARTICIPANTS
    fam = phase_spokes.groupby("family", dropna=False)["family_size"].max().to_dict()
    fam_txt = ", ".join(f"{k}={int(v)}" for k, v in sorted(fam.items()) if pd.notna(v))

    fig.suptitle(f"Sound relationships — {phase}", fontsize=17, fontweight="bold", color=INK, y=0.975)
    fig.text(
        0.50,
        0.935,
        f"Sensor mixed models and questionnaire correlations; BH families ({fam_txt}); n={n_part} participants.",
        ha="center",
        va="center",
        fontsize=8.6,
        color="#4a5560",
    )

    segs, colors, widths = [], [], []
    for _, row in phase_spokes.iterrows():
        if not is_true(row.significant):
            continue
        nd = lay[lay.id == row.id]
        if nd.empty:
            continue
        x, y = float(nd.x.iloc[0]), float(nd.y.iloc[0])
        beta = float(row.beta_std)
        color, lw, alpha = spoke_style(beta, vmax)
        segs.append([(cx, cy), (x, y)])
        rgba = np.array(to_rgba(color))
        rgba[3] = alpha
        colors.append(rgba)
        widths.append(lw)
    if segs:
        ax.add_collection(
            LineCollection(segs, colors=colors, linewidths=widths, zorder=2, capstyle="round")
        )

    for _, nd in lay.iterrows():
        sig = is_true(nd.significant)
        x, y = float(nd.x), float(nd.y)
        ax.add_patch(
            Circle(
                (x, y),
                0.012,
                facecolor="#f4efe4" if sig else "#eef3f7",
                edgecolor="#3d4a54" if sig else GREY,
                linewidth=1.7 if sig else 0.8,
                zorder=4,
            )
        )
        if nd.domain == "env":
            ha, tx = "right", x - 0.018
        elif nd.domain == "psycho":
            ha, tx = "left", x + 0.018
        else:
            ha, tx = "left", x + 0.017
        ax.text(
            tx,
            y,
            str(nd.label),
            ha=ha,
            va="center",
            fontsize=7.5,
            color=INK if sig else "#6b7280",
            fontweight="bold" if sig else "normal",
            zorder=5,
            clip_on=False,
        )

    ax.add_patch(Circle((cx, cy), 0.052, facecolor="#1b3a4b", edgecolor="#0e2430", linewidth=1.4, zorder=6))
    ax.text(cx, cy + 0.008, "SOUND", ha="center", va="center", fontsize=8.6, color="white", fontweight="bold", zorder=7)
    ax.text(cx, cy - 0.015, "dBA", ha="center", va="center", fontsize=8.1, color="#d6e4ee", zorder=7)

    ax.text(0.145, 0.935, "Environment", ha="center", va="bottom", fontsize=10.5, fontweight="bold", color="#2c3e50")
    ax.text(0.50, 0.935, "Physiology", ha="center", va="bottom", fontsize=10.5, fontweight="bold", color="#2c3e50")
    ax.text(0.86, 0.935, "Questionnaire", ha="center", va="bottom", fontsize=10.5, fontweight="bold", color="#2c3e50")

    sm = plt.cm.ScalarMappable(norm=Normalize(vmin=-vmax, vmax=vmax), cmap=CMAP)
    sm.set_array([])
    cax = fig.add_axes([0.37, 0.04, 0.26, 0.018])
    cb = fig.colorbar(sm, cax=cax, orientation="horizontal")
    cb.set_label(r"$\beta_{\mathrm{std}}$  (green +, red $-$)", fontsize=8, color=INK)
    cb.ax.tick_params(labelsize=7.5, color=INK)
    ax.legend(
        handles=[
            Line2D([0], [0], color=GREEN, lw=2.4, label=r"q < 0.05, $\beta_{\mathrm{std}}$ > 0"),
            Line2D([0], [0], color=RED, lw=2.4, label=r"q < 0.05, $\beta_{\mathrm{std}}$ < 0"),
            Line2D([0], [0], color=GREY, lw=1.2, label="no spoke (no significant result)"),
        ],
        loc="lower right",
        bbox_to_anchor=(0.99, 0.01),
        frameon=False,
        fontsize=8,
    )

    fig.subplots_adjust(left=0.04, right=0.98, top=0.90, bottom=0.08)
    stem = FIG_DIR / f"Sound_star_{phase}"
    fig.savefig(stem.with_suffix(".png"), dpi=220, facecolor="white")
    plt.close(fig)
    print(f"wrote {stem}.png")


def main() -> None:
    spokes, nodes = load_tables()
    vmax = vmax_beta(spokes)
    print(f"shared |beta_std| scale vmax={vmax:.4f}")
    for phase in PHASES:
        draw_phase(phase, spokes, nodes, vmax)


if __name__ == "__main__":
    main()

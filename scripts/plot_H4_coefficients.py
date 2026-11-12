"""Updated H4 coefficient plots. Walking bouts only. No product. No cycling extension."""
from pathlib import Path
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D

ROOT = Path(r"C:\Users\sanga\Desktop\Pranav Paper3_Final")
OUT = ROOT / "Figures"
CSV = ROOT / "output" / "statistical_analysis" / "results" / "H4_updated_merged_test" / "H4_updated_merged_tests.csv"

plt.rcParams.update({
    "font.family": "DejaVu Sans", "font.size": 7.5, "axes.titlesize": 8, "axes.labelsize": 7.5,
    "xtick.labelsize": 6.5, "ytick.labelsize": 6.5, "legend.fontsize": 6.5, "axes.linewidth": 0.6,
    "xtick.major.width": 0.5, "ytick.major.width": 0.5, "axes.spines.top": False, "axes.spines.right": False,
    "pdf.fonttype": 42, "savefig.dpi": 300})

H4_COL = {"dba_z": "#1b4f72", "utci_z": "#b03a2e"}
H4_OUT_LAB = {
    "thermal_comfort": "Thermal comfort",
    "acoustic_comfort": "Acoustic comfort",
    "overall_comfort": "Overall comfort",
}
H4_OUTCOMES = ["thermal_comfort", "acoustic_comfort", "overall_comfort"]


def save(fig, name):
    svg = OUT / (name + ".svg")
    png = OUT / (name + ".png")
    fig.savefig(svg, format="svg", facecolor="white", bbox_inches="tight")
    fig.savefig(png, format="png", dpi=300, facecolor="white", bbox_inches="tight")
    plt.close(fig)
    print("saved", svg)
    print("saved", png)


def h4_table():
    t = pd.read_csv(CSV)
    t = t[t.block == "measured_joint"].copy()
    for col in ("estimate", "p", "ci_lower", "ci_upper"):
        t[col] = pd.to_numeric(t[col], errors="coerce")
    return t


def h4_panel(ax, table, scope, title, show_y):
    s = table[table.scope == scope]
    ax.axvline(0, color="#777777", lw=0.6, ls="--")
    ax.grid(axis="x", color="#eeeeee", lw=0.5)
    ax.set_axisbelow(True)
    ypos = {oc: 2 - i for i, oc in enumerate(H4_OUTCOMES)}
    for oc in H4_OUTCOMES:
        y0 = ypos[oc]
        for term, dy in (("dba_z", 0.18), ("utci_z", -0.18)):
            r = s[(s.outcome == oc) & (s.term == term)].iloc[0]
            x, lo, hi, p = float(r.estimate), float(r.ci_lower), float(r.ci_upper), float(r.p)
            col = H4_COL[term]
            y = y0 + dy
            ax.plot([lo, hi], [y, y], color=col, lw=1.0, solid_capstyle="butt")
            sig = p < 0.05
            ax.plot(x, y, marker="o", ms=5.2, mfc=col if sig else "white", mec=col, mew=0.9, zorder=3)
            if sig:
                ax.text(x, y - 0.28, f"p={p:.3f}", ha="center", va="top", fontsize=5.2, color="#222222")
    ax.set_yticks([ypos[oc] for oc in H4_OUTCOMES])
    ax.set_yticklabels([H4_OUT_LAB[oc] for oc in H4_OUTCOMES] if show_y else [])
    ax.tick_params(axis="y", length=0 if not show_y else 2)
    ax.set_ylim(-0.7, 2.7)
    ax.set_xlim(-1.35, 1.05)
    ax.set_title(title, fontsize=8)
    ax.set_xlabel("Coefficient per 1 SD")


def main():
    table = h4_table()
    fig, ax = plt.subplots(figsize=(3.8, 3.15))
    fig.subplots_adjust(left=0.36, right=0.96, top=0.88, bottom=0.22)
    h4_panel(ax, table, "walk", "Walking (22 bouts)", True)
    legend_handles = [
        Line2D([], [], marker="o", ls="-", color=H4_COL["dba_z"], mfc=H4_COL["dba_z"], label="dBA  p < 0.05", ms=5),
        Line2D([], [], marker="o", ls="-", color=H4_COL["dba_z"], mfc="white", label="dBA  p ≥ 0.05", ms=5),
        Line2D([], [], marker="o", ls="-", color=H4_COL["utci_z"], mfc=H4_COL["utci_z"], label="UTCI  p < 0.05", ms=5),
        Line2D([], [], marker="o", ls="-", color=H4_COL["utci_z"], mfc="white", label="UTCI  p ≥ 0.05", ms=5),
    ]
    fig.legend(handles=legend_handles, loc="lower center", ncol=2, frameon=False, bbox_to_anchor=(0.66, -0.02))
    save(fig, "H4_coefficients")
    fig, ax = plt.subplots(figsize=(3.6, 3.15))
    fig.subplots_adjust(left=0.38, right=0.96, top=0.88, bottom=0.16)
    h4_panel(ax, table, "walk", "Walking (22 bouts)", True)
    save(fig, "H4_walk")


if __name__ == "__main__":
    main()

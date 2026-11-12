"""Render significant phase-specific acoustic relationships as PNGs."""
import argparse
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import pandas as pd

PHASES = ("WalkG", "WalkU", "BikeG", "BikeU")


def sound_label(name):
    if name == "ucm_SND_dBA":
        return "dBA"
    if name.startswith("octave_proportion_"):
        return name.removeprefix("octave_proportion_").removesuffix("_Hz").replace("_", ".") + " Hz octave"
    if name.startswith("freq_proportion_"):
        return name.removeprefix("freq_proportion_").replace("_", " ")
    return name.removesuffix("_proportion").replace("_", " ").capitalize()


def draw(data, phase, output):
    hits = data[data.significant].sort_values(["sound_measure", "domain", "label"])
    sounds = hits.sound_measure.unique()
    nodes = hits[["domain", "label"]].drop_duplicates().sort_values(["domain", "label"])
    count = max(len(sounds), len(nodes), 1)
    fig, ax = plt.subplots(figsize=(11, max(4, count * .38 + 1.8)), layout="constrained")
    ax.set(xlim=(0, 1), ylim=(-1, count))
    ax.axis("off")
    ax.set_title(f"Sound relationships | {phase}", fontsize=18, weight="bold")
    left = {sound: count - 1 - i for i, sound in enumerate(sounds)}
    right = {tuple(node): count - 1 - i for i, node in enumerate(nodes.itertuples(index=False, name=None))}
    for row in hits.itertuples():
        estimate = row.rho_spearman if row.domain == "psycho" else row.beta_std
        color = "#176680" if estimate > 0 else "#a34626"
        ax.plot([.33, .66], [left[row.sound_measure], right[row.domain, row.label]],
                color=color, lw=1.4, alpha=.72)
    for sound, y in left.items():
        ax.text(.31, y, sound_label(sound), ha="right", va="center")
    for (domain, label), y in right.items():
        ax.text(.68, y, f"{label} ({domain})", va="center")
    if hits.empty:
        ax.text(.5, .45, "No associations passed q < 0.05", transform=ax.transAxes, ha="center")
    tested = data.p.notna().sum()
    fig.supxlabel(f"{len(hits)} of {tested} estimable tests passed q < 0.05. "
                  "Blue = positive estimate. Rust = negative estimate.", fontsize=10)
    fig.savefig(output / f"Sound_spectrum_{phase}.png", dpi=200)
    plt.close(fig)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("results", type=Path)
    args = parser.parse_args()
    data = pd.read_csv(args.results)
    for phase in PHASES:
        draw(data[data.phase == phase], phase, args.results.parent)


if __name__ == "__main__":
    main()


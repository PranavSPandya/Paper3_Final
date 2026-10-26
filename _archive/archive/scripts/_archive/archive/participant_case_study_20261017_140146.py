"""Exploratory participant case-study subgroup profiles for Paper 3."""

# ── CONFIG ───────────────────────────────────────────────────────────────────
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

BASE = Path(r"C:\Users\pandya\Documents\Github\docker\Paper3_Final")
INPUT_CSV = BASE / "output" / "merged_all_11participants_8min.csv"
OUTPUT_DIR = BASE / "output" / "Participant Casestudy"
PHASES = ["BikeU", "WalkU", "BikeG", "WalkG"]

PHASE_COLORS = {
    "BikeU": "#d45500",
    "WalkU": "#b8860b",
    "BikeG": "#1a6b1a",
    "WalkG": "#52b852",
    "Tram": "#7f8c8d",
}
FIT_COLORS = {"Fit": "#27ae60", "Not Fit": "#c0392b"}
ACT_COLORS = {"Active": "#2980b9", "Inactive": "#e67e22"}

FITNESS = {
    "P4": "Not Fit", "P8": "Not Fit", "P9": "Fit", "P10": "Not Fit",
    "P11": "Fit", "P12": "Not Fit", "P13": "Not Fit", "P14": "Fit",
    "P15": "Fit", "P16": "Fit", "P17": "Fit",
}
ACTIVENESS = {
    "P4": "Active", "P8": "Active", "P9": "Active", "P10": "Inactive",
    "P11": "Inactive", "P12": "Inactive", "P13": "Active", "P14": "Active",
    "P15": "Active", "P16": "Inactive", "P17": "Inactive",
}

OUTCOMES = {
    "ucm_UTCI": "UTCI (°C)",
    "ucm_PET": "PET (°C)",
    "ucm_AIR_temp": "Air temperature (°C)",
    "empatica_skin_temperature": "Skin temperature (°C)",
    "empatica_eda_tonic": "EDA tonic (µS)",
    "empatica_heart_rate": "Heart rate (bpm)",
    "eyetracker_pupil_diameter_avg": "Pupil diameter (mm)",
    "questionnaire_current_comfort_1_7": "Comfort (1–7)",
}

PAIRINGS = [
    ("Group 1", "P11", "P16", "Normal weight, Fit, Inactive"),
    ("Group 2", "P10", "P12", "Overweight, Not Fit, Inactive"),
    ("Group 3", "P9", "P17", "Normal weight, Fit; Active vs Inactive"),
    ("Group 4", "P5", "P7", "Not Fit; Underweight vs Overweight"),
]

# ── LOAD ─────────────────────────────────────────────────────────────────────
df = pd.read_csv(INPUT_CSV, low_memory=False)
available = [column for column in OUTCOMES if column in df.columns]
df = df[df["PhaseID"].isin(PHASES)].copy()
df["ParticipantID"] = df["ParticipantID"].astype(str)
df["Fitness"] = df["ParticipantID"].map(FITNESS)
df["Activeness"] = df["ParticipantID"].map(ACTIVENESS)
df = df.dropna(subset=["Fitness", "Activeness"])

# One observation per participant × phase is the descriptive unit of analysis.
participant_phase = (
    df.groupby(["ParticipantID", "Fitness", "Activeness", "PhaseID"], as_index=False)[available]
    .mean()
)

# ── DEFINE ───────────────────────────────────────────────────────────────────
def make_contrasts(data):
    rows = []
    for grouping, levels in [("Fitness", ["Fit", "Not Fit"]), ("Activeness", ["Active", "Inactive"])]:
        for phase in PHASES:
            subset = data[data["PhaseID"].eq(phase)]
            for outcome in available:
                values = {
                    level: subset.loc[subset[grouping].eq(level), outcome].dropna()
                    for level in levels
                }
                a, b = values[levels[0]], values[levels[1]]
                rows.append({
                    "Grouping": grouping,
                    "PhaseID": phase,
                    "Outcome": outcome,
                    "Group_A": levels[0],
                    "Group_B": levels[1],
                    "N_A": int(a.size),
                    "N_B": int(b.size),
                    "Mean_A": a.mean(),
                    "Mean_B": b.mean(),
                    "Difference_A_minus_B": a.mean() - b.mean(),
                    "SD_A": a.std(ddof=1),
                    "SD_B": b.std(ddof=1),
                })
    return pd.DataFrame(rows)


def make_pairwise_comparisons(data):
    """Return exact pair differences plus cautious four-phase diagnostics."""
    rows = []
    for group, participant_a, participant_b, basis in PAIRINGS:
        for outcome in available:
            phase_rows = []
            for phase in PHASES:
                a = data.loc[
                    data["ParticipantID"].eq(participant_a) & data["PhaseID"].eq(phase), outcome
                ].dropna()
                b = data.loc[
                    data["ParticipantID"].eq(participant_b) & data["PhaseID"].eq(phase), outcome
                ].dropna()
                value_a = a.iloc[0] if not a.empty else np.nan
                value_b = b.iloc[0] if not b.empty else np.nan
                difference = value_a - value_b if pd.notna(value_a) and pd.notna(value_b) else np.nan
                phase_rows.append((phase, value_a, value_b, difference))

            differences = np.array([row[3] for row in phase_rows if pd.notna(row[3])], dtype=float)
            nonzero = differences[np.abs(differences) > 1e-12]
            direction_consistency = (
                max((nonzero > 0).mean(), (nonzero < 0).mean())
                if nonzero.size else np.nan
            )
            for phase, value_a, value_b, difference in phase_rows:
                rows.append({
                    "RowType": "Phase comparison",
                    "Group": group,
                    "Participant_A": participant_a,
                    "Participant_B": participant_b,
                    "Matching_basis": basis,
                    "Outcome": outcome,
                    "PhaseID": phase,
                    "Value_A": value_a,
                    "Value_B": value_b,
                    "Difference_A_minus_B": difference,
                    "N_phases_with_both_values": int(differences.size),
                    "Mean_difference_across_phases": differences.mean() if differences.size else np.nan,
                    "Median_difference_across_phases": np.median(differences) if differences.size else np.nan,
                    "Direction_consistency": direction_consistency,
                    "Inference_note": "Descriptive pair comparison only; no inferential p-value is reported.",
                })
    return pd.DataFrame(rows)


def plot_matched_pairs(data, output_path):
    fig, axes = plt.subplots(len(PAIRINGS), len(available), figsize=(24, 11), constrained_layout=True)
    axes = np.atleast_2d(axes)
    for row_index, (group, participant_a, participant_b, basis) in enumerate(PAIRINGS):
        for column_index, outcome in enumerate(available):
            ax = axes[row_index, column_index]
            for participant, linestyle, label in [
                (participant_a, "-", participant_a), (participant_b, "--", participant_b)
            ]:
                values = [
                    data.loc[
                        data["ParticipantID"].eq(participant) & data["PhaseID"].eq(phase), outcome
                    ].dropna().iloc[0]
                    if not data.loc[
                        data["ParticipantID"].eq(participant) & data["PhaseID"].eq(phase), outcome
                    ].dropna().empty else np.nan
                    for phase in PHASES
                ]
                ax.plot(range(len(PHASES)), values, color="black", linestyle=linestyle,
                        linewidth=1.2, marker="o", markersize=3.5, label=label)
            for phase_index, phase in enumerate(PHASES):
                for participant in (participant_a, participant_b):
                    values = data.loc[
                        data["ParticipantID"].eq(participant) & data["PhaseID"].eq(phase), outcome
                    ].dropna()
                    if not values.empty:
                        ax.scatter(phase_index, values.iloc[0], color=PHASE_COLORS[phase],
                                   edgecolor="white", linewidth=0.4, s=28, zorder=3)
            if row_index == 0:
                ax.set_title(OUTCOMES[outcome], fontsize=9, fontweight="bold")
            if column_index == 0:
                ax.set_ylabel(f"{group}\n{participant_a} vs {participant_b}", fontsize=8)
            ax.set_xticks(range(len(PHASES)), PHASES, rotation=45, ha="right", fontsize=7)
            ax.grid(axis="y", alpha=0.25)
            ax.tick_params(axis="y", labelsize=7)
    handles = [
        plt.Line2D([0], [0], color="black", linestyle="-", marker="o", label="Participant A"),
        plt.Line2D([0], [0], color="black", linestyle="--", marker="o", label="Participant B"),
    ]
    fig.legend(handles=handles, loc="upper center", ncol=2, frameon=False)
    fig.suptitle(
        "Matched participant case study: phase-level profiles\n"
        "Coloured markers identify phases; lines identify the two participants (descriptive)",
        fontsize=14, fontweight="bold",
    )
    fig.savefig(output_path, dpi=300)
    plt.close(fig)


def plot_grouping(data, grouping, levels, colors, output_path):
    fig, axes = plt.subplots(2, 4, figsize=(18, 8), constrained_layout=True)
    axes = axes.ravel()
    for ax, outcome in zip(axes, available):
        for phase_index, phase in enumerate(PHASES):
            subset = data[data["PhaseID"].eq(phase)]
            for offset, level in zip((-0.12, 0.12), levels):
                values = subset.loc[subset[grouping].eq(level), outcome].dropna().to_numpy(float)
                if values.size == 0:
                    continue
                x = phase_index + offset
                jitter = np.linspace(-0.045, 0.045, values.size)
                ax.scatter(
                    np.full(values.size, x) + jitter,
                    values,
                    color=colors[level], alpha=0.55, s=28, zorder=2,
                    edgecolor="white", linewidth=0.4,
                )
                ax.errorbar(
                    x, values.mean(), yerr=values.std(ddof=1) if values.size > 1 else 0,
                    fmt="o", color=colors[level], markeredgecolor="black",
                    markeredgewidth=0.7, markersize=7, capsize=3, zorder=3,
                )
        ax.set_title(OUTCOMES[outcome], fontsize=10, fontweight="bold")
        ax.set_xticks(range(len(PHASES)), PHASES)
        ax.grid(axis="y", alpha=0.25)
        ax.tick_params(labelsize=8)
    for ax in axes[len(available):]:
        ax.axis("off")
    handles = [
        plt.Line2D([0], [0], marker="o", color="none", markerfacecolor=colors[level],
                   markeredgecolor="black", label=level, markersize=7)
        for level in levels
    ]
    fig.legend(handles=handles, loc="upper center", ncol=len(levels), frameon=False,
               title=f"Grouped by {grouping}")
    fig.suptitle(
        f"Paper 3 participant-phase profiles grouped by {grouping} (descriptive)",
        fontsize=14, fontweight="bold",
    )
    fig.savefig(output_path, dpi=300)
    plt.close(fig)


# ── RUN / SAVE ───────────────────────────────────────────────────────────────
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
summary_path = OUTPUT_DIR / "Participant_Casestudy_Fitness_Activeness_summary.csv"
pairwise_path = OUTPUT_DIR / "Participant_Casestudy_matched_pair_comparisons.csv"
pairwise_figure_path = OUTPUT_DIR / "Participant_Casestudy_matched_pairs.png"
make_contrasts(participant_phase).to_csv(summary_path, index=False)
make_pairwise_comparisons(participant_phase).to_csv(pairwise_path, index=False)
plot_grouping(
    participant_phase, "Fitness", ["Fit", "Not Fit"], FIT_COLORS,
    OUTPUT_DIR / "Participant_Casestudy_grouped_by_fitness.png",
)
plot_grouping(
    participant_phase, "Activeness", ["Active", "Inactive"], ACT_COLORS,
    OUTPUT_DIR / "Participant_Casestudy_grouped_by_activeness.png",
)
plot_matched_pairs(participant_phase, pairwise_figure_path)

print(f"Participants: {participant_phase['ParticipantID'].nunique()}")
print("Fitness counts:", participant_phase.drop_duplicates("ParticipantID")["Fitness"].value_counts().to_dict())
print("Activeness counts:", participant_phase.drop_duplicates("ParticipantID")["Activeness"].value_counts().to_dict())
print(f"Saved: {summary_path}")
print(f"Saved: {pairwise_path}")
print(f"Saved: {pairwise_figure_path}")
print(f"Saved: {OUTPUT_DIR / 'Participant_Casestudy_grouped_by_fitness.png'}")
print(f"Saved: {OUTPUT_DIR / 'Participant_Casestudy_grouped_by_activeness.png'}")

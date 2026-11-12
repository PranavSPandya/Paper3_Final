"""Predict 10-second physiology with eight environmental random forests."""
import argparse
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestRegressor

OUTCOMES = {
    "empatica_skin_temperature": "Skin temperature",
    "empatica_eda_tonic": "Tonic EDA",
    "empatica_heart_rate": "Heart rate",
    "eyetracker_pupil_diameter_avg": "Pupil diameter",
}
PARTICIPANTS = "P4 P8 P9 P10 P11 P12 P13 P14 P15 P16 P17".split()
PHASES = ["WalkG", "WalkU", "BikeG", "BikeU"]
PAIRS = {
    **{f"PM{size}": [f"atmo_lys_atmotube_{side}__atmotube_pm{size}" for side in ("left", "right")]
       for size in ("1", "2.5", "10")},
    **{name: [f"atmo_lys_LYS{i}__lys_{column}" for i in (1, 2)]
       for name, column in (("Illuminance", "lux"), ("Colour temperature", "kelvin"))},
}
COMMON = ["ucm_SND_dBA", "ucm_SUN_Gh", "SVF", "Illuminance", "Colour temperature", "gvi_50m", *PHASES]
SPECS = [
    ["ucm_UTCI", "PM2.5"],
    ["ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "PM2.5"],
    ["ucm_MRT", "PM2.5"],
    ["ucm_HUMIDEX", "PM2.5"],
    ["ucm_PET", "PM2.5"],
    ["ucm_UTCI", "PM1"],
    ["ucm_UTCI", "PM10"],
]
EXTRA = ["TVF", "BVF", "ucm_GPS_speed_kmh", "spectral_centroid_Hz",
         "vehicle_proportion", "rural_natural_proportion", "wind_proportion"]
SPECS.append(list(dict.fromkeys([column for spec in SPECS for column in spec] + EXTRA)))


def load_data(path):
    required = {"ParticipantID", "PhaseID", "Datetime", *OUTCOMES}
    required.update({column for spec in SPECS for column in spec} | set(COMMON))
    required.difference_update(set(PAIRS) | set(PHASES))
    required.update(column for pair in PAIRS.values() for column in pair)
    frame = pd.read_csv(path, usecols=sorted(required), low_memory=False)
    frame = frame.loc[frame.ParticipantID.isin(PARTICIPANTS) & frame.PhaseID.isin(PHASES)].copy()
    frame["Datetime"] = pd.to_datetime(frame.Datetime, format="mixed", utc=True)
    if frame.duplicated(["ParticipantID", "PhaseID", "Datetime"]).any():
        raise ValueError("Duplicate participant-phase timestamps")
    bout = frame.groupby(["ParticipantID", "PhaseID"]).Datetime
    elapsed = (frame.Datetime - bout.transform("min")).dt.total_seconds()
    cap = elapsed.groupby([frame.ParticipantID, frame.PhaseID]).max().groupby(level=0).min().clip(upper=480)
    frame = frame.loc[elapsed <= frame.ParticipantID.map(cap)].copy()
    for column in required - {"ParticipantID", "PhaseID", "Datetime"}:
        frame[column] = pd.to_numeric(frame[column], errors="coerce").replace([np.inf, -np.inf], np.nan)
    for name, pair in PAIRS.items():
        frame[name] = frame[pair].mean(axis=1)
    for phase in PHASES:
        frame[phase] = frame.PhaseID.eq(phase).astype(int)
    return frame.sort_values(["ParticipantID", "PhaseID", "Datetime"])


def fit_folds(frame):
    rows = []
    for equation, spec in enumerate(SPECS, 1):
        predictors = COMMON + spec
        for outcome, label in OUTCOMES.items():
            data = frame.dropna(subset=[outcome, "ucm_SND_dBA"])
            for participant in PARTICIPANTS:
                test = data.ParticipantID.eq(participant)
                if not test.any():
                    continue
                train_y, test_y = data.loc[~test, outcome], data.loc[test, outcome]
                baseline = data.loc[~test].groupby("PhaseID")[outcome].mean()
                baseline_mse = np.mean((test_y - data.loc[test, "PhaseID"].map(baseline)) ** 2)
                errors = []
                for columns in (predictors, [c for c in predictors if c != "ucm_SND_dBA"]):
                    model = RandomForestRegressor(n_estimators=96, min_samples_leaf=12, random_state=42, n_jobs=2)
                    model.fit(data.loc[~test, columns], train_y)
                    errors.append(np.mean((test_y - model.predict(data.loc[test, columns])) ** 2))
                rows.append((equation, label, participant, int(test.sum()), baseline_mse, *errors))
    return pd.DataFrame(rows, columns=["equation", "outcome", "participant", "epochs",
                                     "baseline_mse", "rf_mse", "without_dba_mse"])


def plot(summary, column, title, caption, output):
    matrix = summary.pivot(index="outcome", columns="equation", values=column).loc[list(OUTCOMES.values())]
    values = matrix.to_numpy()
    limit = max(abs(values.min()), abs(values.max()), 1)
    fig, ax = plt.subplots(figsize=(10, 4))
    image = ax.imshow(values, cmap="RdBu", vmin=-limit, vmax=limit, aspect="auto")
    ax.set_xticks(range(8), [f"Eq {i}" for i in range(1, 9)])
    ax.set_yticks(range(len(matrix)), matrix.index)
    for (row, col), value in np.ndenumerate(values):
        ax.text(col, row, f"{value:+.1f}%", ha="center", va="center",
                color="white" if abs(value) > 0.65 * limit else "black")
    ax.set_title(title)
    fig.colorbar(image, ax=ax, label="RMSE change (%)")
    fig.text(0.02, 0.02, caption, fontsize=9)
    fig.tight_layout(rect=(0, 0.07, 1, 1))
    fig.savefig(output, dpi=200)
    plt.close(fig)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    output = args.output or args.root / "Figures" / "Sound relationships" / "random_forest"
    output.mkdir(parents=True, exist_ok=True)
    frame = load_data(args.root / "output" / "merged_all_11participants_8min.csv")
    folds = fit_folds(frame)
    summary = folds.groupby(["equation", "outcome"], as_index=False)[
        ["baseline_mse", "rf_mse", "without_dba_mse"]].mean()
    summary["participants"] = folds.groupby(["equation", "outcome"]).size().to_numpy()
    summary["improvement_vs_phase"] = 100 * (1 - np.sqrt(summary.rf_mse / summary.baseline_mse))
    summary["improvement_from_dba"] = 100 * (1 - np.sqrt(summary.rf_mse / summary.without_dba_mse))
    folds.to_csv(output / "held_out_participant_errors.csv", index=False)
    summary.to_csv(output / "rf_summary.csv", index=False)
    coverage = pd.DataFrame([
        (i, column, int(frame[column].notna().sum()), len(frame))
        for i, spec in enumerate(SPECS, 1) for column in COMMON + spec
    ], columns=["equation", "predictor", "available_epochs", "total_epochs"])
    coverage.to_csv(output / "predictor_coverage.csv", index=False)
    plot(summary, "improvement_vs_phase", "Random forest vs. phase-only baseline",
         "Positive values indicate lower held-out RMSE. Participants have equal weight.", output / "rf_performance.png")
    plot(summary, "improvement_from_dba", "Added predictive value of dBA",
         "Positive values favour the forest with dBA. Eq 8 retains the other acoustic predictors in both fits.",
         output / "rf_added_dba.png")
    print(summary[["equation", "outcome", "improvement_vs_phase", "improvement_from_dba"]].round(2).to_string(index=False))


if __name__ == "__main__":
    main()


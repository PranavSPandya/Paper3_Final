"""Standardized within-bout PCA of all numeric sound fields and candidate selection."""
from __future__ import annotations

import argparse
import hashlib
from io import BytesIO
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy.optimize import linear_sum_assignment
from sklearn.decomposition import PCA

# Config
REPO_ROOT = Path(__file__).resolve().parents[2]
MERGED_PATH = REPO_ROOT / "output/merged_all_11participants_8min.csv"
OUT_DIR = REPO_ROOT / "output/statistical_analysis/Normalization & Parameter Screening/PCA-informed/Sound frequencies selection"
PARTICIPANTS = ["P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"]
PHASES = ["BikeU", "WalkU", "BikeG", "WalkG"]
VARIANCE_TARGET = 0.80
MIN_PCS_B4 = 10
BANDS = ["freq_prop_20_125", "freq_prop_125_1000", "freq_prop_1000_4000",
         "freq_prop_4000_8000", "freq_prop_8000_20000"]
GROUP = ["ParticipantID", "PhaseID"]
SCORES = [f"{c}_score" for c in ["wind", "rural_natural", "vehicle",
          "urban_manmade_neutral", "urban_manmade_positive", "urban_manmade_negative", "mechanisms"]]
PROPORTIONS = [c.replace("_score", "_prop") for c in SCORES] + ["unidentify_prop"]
FREQUENCIES = ["dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz"] + BANDS + [
    f"octave_prop_{c}_hz" for c in ["31_5", "63_0", "125_0", "250_0", "500_0",
                                  "1000_0", "2000_0", "4000_0", "8000_0"]]
SOUND_COLUMNS = ["ucm_SND_dBA"] + FREQUENCIES + SCORES + PROPORTIONS
TEXT_OR_NOMINAL_SOUND_FIELDS = {
    "category": "Nominal classifier text label (e.g. Vehicle, Wind); audit field, not a PCA input.",
}
DIAGNOSTIC_COLUMNS = {
    "unidentify_prop": "Unidentified-classification proportion; retain for classification review, not as a sound exposure.",
}
STRUCTURAL_COLUMNS = {
    "ParticipantID": "Participant identifier; bout grouping and leave-one-participant-out refits only.",
    "PhaseID": "Transport-phase identifier; bout grouping only.",
    "Datetime": "Window timestamp; bout elapsed-time (<480 s) filter only.",
}
PCA_COLUMNS = [c for c in SOUND_COLUMNS if c not in DIAGNOSTIC_COLUMNS]
VIF_THRESHOLD = 5.0
BLOCK = "sound_exposures"
METHOD = "within-bout standardized correlation PCA"
REPORT_NAME = "Sound_screening_pca_vif.md"


# Load and define
def load_analysis_frame(path: Path) -> tuple[pd.DataFrame, str]:
    """Read the matched cohort once; validate numeric sound fields before complete-case PCA."""
    source_bytes = path.read_bytes()
    raw = pd.read_csv(BytesIO(source_bytes), low_memory=False)
    required = GROUP + ["Datetime", "category"] + SOUND_COLUMNS
    missing = sorted(set(required) - set(raw.columns))
    if missing:
        raise ValueError(f"Missing band fields: {missing}")
    sub = raw.loc[raw.ParticipantID.isin(PARTICIPANTS) & raw.PhaseID.isin(PHASES), required].copy()
    sub["Datetime"] = pd.to_datetime(sub.Datetime, errors="raise")
    if sub.duplicated(GROUP + ["Datetime"]).any():
        raise ValueError("Duplicate sound windows")
    elapsed = (sub.Datetime - sub.groupby(GROUP).Datetime.transform("min")).dt.total_seconds()
    sub = sub.loc[elapsed < 480].reset_index(drop=True)
    if sub.groupby(GROUP).ngroups != len(PARTICIPANTS) * len(PHASES):
        raise ValueError("Missing declared participant-phase bout")
    for c in SOUND_COLUMNS:
        sub[c] = pd.to_numeric(sub[c], errors="raise")
        values = sub[c].dropna()
        if not np.isfinite(values).all() or (values < 0).any():
            raise ValueError(f"Nonfinite or negative band values: {c}")
    if (sub[BANDS + PROPORTIONS + FREQUENCIES[8:]] > 1 + 1e-10).any().any():
        raise ValueError("A reported proportion exceeds one")
    complete_bands = sub[BANDS].dropna()
    if not np.allclose(complete_bands.sum(axis=1), 1, atol=1e-8, rtol=0):
        raise ValueError("Broad-band proportions do not partition unit energy")
    return sub, hashlib.sha256(source_bytes).hexdigest()


# ==============================================================================
# TRANSFORM / FIT
# ==============================================================================


def standardized_matrix(frame: pd.DataFrame, columns: list[str]) -> pd.DataFrame:
    centered = frame[columns] - frame.groupby(GROUP)[columns].transform("mean")
    scale = centered.std(ddof=1)
    if (scale <= 0).any() or not np.isfinite(scale).all():
        raise ValueError(f"Constant or invalid within-bout fields: {list(scale.index[~(scale > 0)])}")
    return centered / scale


def max_vif_standardized(frame: pd.DataFrame, columns: list[str]) -> float:
    """Max VIF from correlation of within-bout standardized predictors (no intercept in R)."""
    if not columns:
        return float("nan")
    if len(columns) == 1:
        return 1.0
    z = standardized_matrix(frame, columns)
    r = z.corr().values
    if np.linalg.matrix_rank(r) < len(columns):
        return float("inf")
    return float(np.diag(np.linalg.inv(r)).max())


def vif_per_term_standardized(frame: pd.DataFrame, columns: list[str]) -> pd.Series:
    if len(columns) == 1:
        return pd.Series({columns[0]: 1.0})
    z = standardized_matrix(frame, columns)
    r = z.corr().values
    if np.linalg.matrix_rank(r) < len(columns):
        return pd.Series(np.inf, index=columns)
    vifs = np.diag(np.linalg.inv(r))
    return pd.Series(vifs, index=columns)


def cumulative_vif_table(frame: pd.DataFrame, columns: list[str], chosen: np.ndarray) -> pd.DataFrame:
    """B4 PC order: per-step predictors are names[:k]; Max_VIF = max per-term VIF in that set."""
    names = [columns[i] for i in chosen]
    rows = []
    for step, name in enumerate(names, start=1):
        subset = names[:step]
        vifs = vif_per_term_standardized(frame, subset)
        rows.append({
            "Step": step,
            "Terms_included": step,
            "Latest_term": name,
            "Max_VIF": float(vifs.max()),
            "Highest_VIF_term": str(vifs.idxmax()),
        })
    return pd.DataFrame(rows)


def sound_set_vif_screen(frame: pd.DataFrame, columns: list[str], chosen: np.ndarray) -> dict:
    """Recompute every VIF after each removal until all retained terms meet the cutoff."""
    names = [columns[i] for i in chosen]
    initial = vif_per_term_standardized(frame, names)
    history, dropped = [], []
    while True:
        vifs = vif_per_term_standardized(frame, names)
        worst = str(vifs.idxmax())
        remove = float(vifs.max()) > VIF_THRESHOLD
        history.append({"Iteration": len(history), "Terms": len(names),
                        "Maximum_VIF": float(vifs.max()), "Highest_term": worst,
                        "Action": f"Remove {worst}" if remove else "Retain set"})
        if not remove:
            break
        names.remove(worst)
        dropped.append(worst)
    return {"initial_vifs": initial, "final_vifs": vifs, "retained": names,
            "dropped_term": ", ".join(dropped) if dropped else None,
            "history": pd.DataFrame(history)}


def representatives(weights: np.ndarray, k: int) -> np.ndarray:
    """B4-style sequential selection: largest absolute weight not already selected."""
    chosen = []
    for component in weights[:k]:
        order = np.argsort(-np.abs(component), kind="stable")
        chosen.append(next(int(j) for j in order if j not in chosen))
    return np.asarray(chosen)


def fit_pca(frame: pd.DataFrame, target: float) -> dict:
    columns = PCA_COLUMNS
    complete = frame.dropna(subset=columns).copy()
    x = standardized_matrix(complete, columns)
    if len(x) <= len(columns):
        raise ValueError("Insufficient complete windows for all-sound PCA")
    pca = PCA(svd_solver="full").fit(x)
    for row in pca.components_:
        if row[np.argmax(np.abs(row))] < 0:
            row *= -1
    scores = pca.transform(x)
    rank = np.linalg.matrix_rank(x - x.mean())
    k_variance = int(np.searchsorted(np.cumsum(pca.explained_variance_ratio_), target) + 1)
    k = max(k_variance, MIN_PCS_B4)
    if k > rank:
        raise ValueError("Retained PC count exceeds numerically identifiable rank")
    chosen = representatives(pca.components_, k)
    raw_centered = complete[columns] - complete.groupby(GROUP)[columns].transform("mean")
    similarity, winners = [], []
    for pid in complete.ParticipantID.unique():
        train = complete.loc[complete.ParticipantID != pid]
        xt = standardized_matrix(train, columns)
        fitted = PCA(svd_solver="full").fit(xt)
        if np.linalg.matrix_rank(xt - xt.mean()) < k:
            raise ValueError(f"Leaving out {pid} makes the retained subspace unidentifiable")
        match = np.abs(pca.components_[:k] @ fitted.components_[:rank].T)
        rows, matched = linear_sum_assignment(match, maximize=True)
        order = matched[np.argsort(rows)]
        aligned = fitted.components_[order]
        similarity.append(match[np.arange(k), order])
        winners.append(representatives(aligned, k))
    similarities = np.asarray(similarity)
    winners = np.asarray(winners)
    records = []
    for pc in range(rank):
        representative = int(chosen[pc]) if pc < k else None
        for j, column in enumerate(columns):
            records.append({
                "block": BLOCK,
                "method": METHOD,
                "PC": pc + 1,
                "column": column,
                "coefficient": pca.components_[pc, j],
                "squared_coefficient_pct": 100 * pca.components_[pc, j] ** 2,
                "corr_transformed_variable_PC": np.corrcoef(x[column], scores[:, pc])[0, 1],
                "corr_original_within_bout_variable_PC": np.corrcoef(raw_centered[column], scores[:, pc])[0, 1],
                "PC_retained": pc < k,
                "candidate_representative": j == representative,
                "LOPO_selection_fraction": np.mean(winners[:, pc] == j) if pc < k else np.nan,
                "LOPO_min_abs_component_cosine": similarities[:, pc].min() if pc < k else np.nan,
            })
    selected = raw_centered.iloc[:, chosen]
    selected_corr = selected.corr()
    if len(chosen) == 1:
        max_vif = 1.0
    elif np.linalg.matrix_rank(selected_corr) < len(chosen):
        max_vif = np.inf
    else:
        max_vif = np.diag(np.linalg.inv(selected_corr)).max()
    z = (selected - selected.mean()) / selected.std()
    design = np.column_stack([np.ones(len(z)), z])
    fitted_scores = design @ np.linalg.lstsq(design, scores[:, :k], rcond=None)[0]
    reconstruction_r2 = 1 - np.sum((scores[:, :k] - fitted_scores) ** 2, axis=0) / np.sum(
        (scores[:, :k] - scores[:, :k].mean(axis=0)) ** 2, axis=0)
    assert len(set(chosen)) == k and np.isfinite(scores).all()
    cum_vif = cumulative_vif_table(complete, columns, chosen)
    vif_screen = sound_set_vif_screen(complete, columns, chosen)
    return dict(
        columns=columns,
        complete=complete,
        x=x,
        pca=pca,
        scores=scores,
        rank=rank,
        k=k,
        k_variance=k_variance,
        records=records,
        chosen=chosen,
        max_vif=max_vif,
        reconstruction_r2=reconstruction_r2,
        cumulative_vif=cum_vif,
        vif_screen=vif_screen,
    )


def self_check() -> None:
    frame = pd.DataFrame({"ParticipantID": ["A"] * 4 + ["B"] * 4,
                          "PhaseID": ["WalkG"] * 8,
                          "x": [1., 2., 4., 8.] * 2, "y": [3., 1., 5., 2.] * 2})
    x = standardized_matrix(frame, ["x", "y"])
    assert np.allclose(x.std(ddof=1), 1)
    assert np.allclose(x.groupby([frame[c] for c in GROUP]).mean(), 0)
    frame["x"] *= 1000
    assert np.allclose(x, standardized_matrix(frame, ["x", "y"]))
    assert "unidentify_prop" not in PCA_COLUMNS and "category" not in PCA_COLUMNS
    assert len(PCA_COLUMNS) == 32
    assert list(representatives(np.array([[.9, .8, .1], [.9, .7, .6]]), 2)) == [0, 1]
    frame["duplicate_x"] = frame["x"]
    screen = sound_set_vif_screen(frame, ["x", "duplicate_x", "y"], np.arange(3))
    assert len(screen["retained"]) == 2 and screen["final_vifs"].max() <= VIF_THRESHOLD
    frame["another_x"] = frame["x"]
    screen = sound_set_vif_screen(frame, ["x", "duplicate_x", "another_x", "y"], np.arange(4))
    assert len(screen["history"]) == 3 and screen["final_vifs"].max() <= VIF_THRESHOLD


def make_figures(result: dict) -> tuple[plt.Figure, plt.Figure, plt.Figure]:
    pca, rank, k = result["pca"], result["rank"], result["k"]
    ev = pca.explained_variance_ratio_[:rank] * 100
    scree, ax = plt.subplots(figsize=(6, 4))
    ax.bar(np.arange(1, rank + 1), ev, color="slategray")
    ax.plot(np.arange(1, rank + 1), np.cumsum(ev), "o-", color="black", markersize=3)
    ax.axvline(k + 0.5, color="black", linestyle="--")
    ax.set(
        title=f"{k} PCs retained ({100 * pca.explained_variance_ratio_[:k].sum():.1f}% cumulative)",
        xlabel="PC",
        ylabel="Variance (%)",
        ylim=(0, 105),
    )
    scree.tight_layout()
    loadings, lax = plt.subplots(figsize=(10, 11))
    rows = np.arange(len(result["columns"]))
    lax.barh(rows - 0.18, pca.components_[0], height=0.36, color="slategray", label="PC1")
    lax.barh(rows + 0.18, pca.components_[1], height=0.36, color="black", label="PC2")
    labels = result["columns"]
    lax.set_yticks(rows, labels)
    lax.set_title("Standardized sound PCA weights (PC1 and PC2)")
    lax.legend(fontsize=8)
    loadings.tight_layout()
    scatter, sax = plt.subplots(figsize=(12, 9))
    # Correlation biplot: reciprocal SVD scalings preserve the rank-two reconstruction.
    pc_sd = np.sqrt(pca.explained_variance_[:2])
    row_coordinates = result["scores"][:, :2] / pc_sd
    vectors = pca.components_[:2].T * pc_sd
    sax.scatter(row_coordinates[:, 0], row_coordinates[:, 1],
                s=5, alpha=0.15, color="slategray")
    selected = set(result["chosen"])
    for j, (vx, vy) in enumerate(vectors):
        sax.annotate("", xy=(vx, vy), xytext=(0, 0),
                     arrowprops=dict(arrowstyle="->", color="black",
                                     alpha=0.9 if j in selected else 0.2,
                                     lw=1.2 if j in selected else 0.6))
    for side in [-1, 1]:
        labels = sorted([j for j in selected if (vectors[j, 0] >= 0) == (side == 1)],
                        key=lambda j: vectors[j, 1])
        positions = np.linspace(-1.2, 1.2, len(labels)) if len(labels) > 1 else [0]
        for j, label_y in zip(labels, positions):
            sax.annotate(result["columns"][j], xy=vectors[j], xytext=(side * 1.4, label_y),
                         fontsize=8, ha="left" if side == 1 else "right", va="center",
                         arrowprops=dict(arrowstyle="-", color="black", alpha=0.4, lw=0.6),
                         bbox=dict(facecolor="white", edgecolor="none", alpha=0.8, pad=1))
    sax.axhline(0, color="black", lw=0.5, alpha=0.3)
    sax.axvline(0, color="black", lw=0.5, alpha=0.3)
    sax.set(xlabel=f"PC1 ({ev[0]:.1f}%; scores in SD units)",
            ylabel=f"PC2 ({ev[1]:.1f}%; scores in SD units)",
            title="Correlation biplot: windows and sound-variable vectors")
    sax.set_aspect("equal", adjustable="datalim")
    scatter.text(0.5, 0.01, "Arrows are correlations with PC1/PC2; labels mark selected candidates.",
                 ha="center", fontsize=9)
    scatter.tight_layout()
    scatter.subplots_adjust(bottom=0.13)
    return scree, loadings, scatter


def write_csv_outputs(out_dir: Path, result: dict) -> dict[str, Path]:
    pca, k, rank = result["pca"], result["k"], result["rank"]
    full_load = pd.DataFrame(result["records"])
    variance = pd.DataFrame([
        dict(
            block=BLOCK,
            PC=i + 1,
            variance_explained_pct=100 * v,
            cumulative_pct=100 * pca.explained_variance_ratio_[: i + 1].sum(),
            retained=i < k,
        )
        for i, v in enumerate(pca.explained_variance_ratio_[:rank])
    ])
    scores = result["complete"][GROUP + ["Datetime"]].assign(
        block=BLOCK,
        PC1=result["scores"][:, 0],
        PC2=result["scores"][:, 1],
    )
    for i in range(2, k):
        scores[f"PC{i + 1}"] = result["scores"][:, i]
    candidates = full_load.loc[full_load.candidate_representative].copy().reset_index(drop=True)
    r2 = result["reconstruction_r2"]
    candidates["candidate_set_score_R2"] = [float(r2[int(pc) - 1]) for pc in candidates["PC"]]
    cum = result["cumulative_vif"].copy()
    candidates = candidates.merge(
        cum[["Step", "Terms_included", "Max_VIF", "Highest_VIF_term"]],
        left_on="PC",
        right_on="Step",
        how="left",
    ).drop(columns=["Step"])
    tables = {
        "pca_loadings.csv": full_load,
        "pca_loadings_pc1_pc2.csv": full_load.loc[full_load.PC <= 2],
        "pca_variance_explained.csv": variance,
        "pca_scores_pc1_pc2.csv": scores,
        "sound_pca_candidates.csv": candidates,
        "sound_cumulative_vif.csv": result["cumulative_vif"],
    }
    paths = {}
    for name, table in tables.items():
        path = out_dir / name
        table.to_csv(path, index=False)
        paths[name] = path
    return paths


def build_pca_results_md(frame, result, target, digest, merged_path, out_dir):
    pca, k = result["pca"], result["k"]
    k_variance = result.get("k_variance", k)
    records = pd.DataFrame(result["records"])
    selected = records.loc[records.candidate_representative, ["PC", "column", "coefficient"]].copy()
    screen = result["vif_screen"]
    selected["Sound-only VIF"] = selected.column.map(screen["initial_vifs"])
    names = selected["column"].tolist()
    selected = selected.rename(columns={"column": "terms"})
    selected.insert(2, "cumulative terms", [" + ".join(names[:i + 1]) for i in range(len(names))])
    final_max = screen["final_vifs"].max()
    candidates = list(TEXT_OR_NOMINAL_SOUND_FIELDS) + SOUND_COLUMNS
    excluded = "; ".join(f"`{c}`: {reason}" for group in
                         (TEXT_OR_NOMINAL_SOUND_FIELDS, DIAGNOSTIC_COLUMNS) for c, reason in group.items())
    return "\n".join([
        "# Sound screening: PCA and VIF", "",
        "**All candidate fields:** " + ", ".join(f"`{c}`" for c in candidates), "",
        "**Exclude before PCA:** " + excluded, "",
        f"**Retain {len(PCA_COLUMNS)} PCA inputs:** " + ", ".join(f"`{c}`" for c in PCA_COLUMNS), "",
        f"**Process:** {frame.ParticipantID.nunique()} participants, {frame.groupby(GROUP).ngroups} bouts; "
        f"{len(result['x'])}/{len(frame)} complete outdoor windows starting before 480 s. "
        "Center within participant-phase and divide by pooled within-bout SD. "
        f"The {target:.0%} rule gives {k_variance} PCs "
        f"({100 * pca.explained_variance_ratio_[:k_variance].sum():.3f}%); "
        f"the current minimum-{MIN_PCS_B4} setting retains {k} ({100 * pca.explained_variance_ratio_[:k].sum():.3f}%). "
        "Select one distinct original column per PC using the largest absolute coefficient (B4-style).", "",
        selected.to_markdown(index=False, floatfmt=".3f"), "",
        f"**VIF decision:** Sound-only maximum {final_max:.3f}; cutoff {VIF_THRESHOLD:g}. "
        + ("No terms removed." if len(screen["history"]) == 1 else
           "Highest-VIF terms above the cutoff removed and VIF recomputed: " +
           "; ".join(screen["history"]["Action"])),
        "**Full-equation check:** Run the full Eq1 design check after regenerating this report.", "",
        "**Interpretation:** Overlapping spectral/category representations remain. Original columns "
        "do not inherit PC explained variance. The minimum-PC setting, diagnostic exclusions and VIF rule "
        "are study choices; this screening does not validate fitted models.", "",
        "**References:** [Jolliffe & Cadima (2016)](https://doi.org/10.1098/rsta.2015.0202), "
        "[King & Jackson (1999)](https://doi.org/10.1002/%28SICI%291099-095X%28199901/02%2910%3A1%3C67%3A%3AAID-ENV336%3E3.0.CO%3B2-0), "
        "[Dormann et al. (2013)](https://doi.org/10.1111/j.1600-0587.2012.07348.x).", "",
        f"Input: {merged_path.resolve()}", ""])


# Run and save
def run_sound_frequency_pca(merged_path=None, out_dir=None,
                            variance_target=VARIANCE_TARGET, check_only=False):
    merged_path, out_dir = merged_path or MERGED_PATH, out_dir or OUT_DIR
    if not 0 < variance_target < 1:
        raise ValueError("Variance target must be strictly between zero and one")
    self_check()
    frame, digest = load_analysis_frame(merged_path)
    print("Exploratory screen: overlapping spectra and category representations receive repeated weight.")
    excluded = list(TEXT_OR_NOMINAL_SOUND_FIELDS) + list(DIAGNOSTIC_COLUMNS) + list(STRUCTURAL_COLUMNS)
    print(f"Excluded before PCA: {excluded}; {len(PCA_COLUMNS)} PCA inputs.")
    result = fit_pca(frame, variance_target)
    variance_pct = 100 * result["pca"].explained_variance_ratio_[:result["k"]].sum()
    summary = dict(merged_path=merged_path.resolve(), digest=digest,
                   n_complete=len(result["x"]), k=result["k"], variance_pct=variance_pct,
                   result=result, frame=frame)
    selected = pd.DataFrame(result["records"])
    print(f"Input: {merged_path.resolve()}")
    print(f"Complete windows: {len(result['x'])}; PCs: {result['k']} ({variance_pct:.1f}%)")
    print(selected.loc[selected.candidate_representative,
                       ["PC", "column", "LOPO_selection_fraction"]].to_string(index=False))
    if check_only:
        print("Check only: no output files written.")
        return summary
    out_dir.mkdir(parents=True, exist_ok=True)
    paths = write_csv_outputs(out_dir, result)
    names = ["pca_scree.png", "pca_loadings_pc1_pc2.png", "pca_biplot_pc1_pc2.png"]
    for figure, name in zip(make_figures(result), names):
        figure.savefig(out_dir / name, dpi=150)
        plt.close(figure)
        paths[name] = out_dir / name
    paths[REPORT_NAME] = REPO_ROOT / "Presentation material" / REPORT_NAME
    body = build_pca_results_md(
        frame, result, variance_target, digest, merged_path, out_dir)
    paths[REPORT_NAME].write_text(
        body, encoding="utf-8")
    summary["outputs"] = paths
    for path in paths.values():
        print(f"Saved: {path.resolve()}")
    return summary


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--merged", type=Path, default=MERGED_PATH)
    parser.add_argument("--out-dir", type=Path, default=OUT_DIR)
    parser.add_argument("--variance-target", type=float, default=VARIANCE_TARGET)
    parser.add_argument("--check-only", action="store_true")
    args = parser.parse_args()
    run_sound_frequency_pca(args.merged, args.out_dir, args.variance_target, args.check_only)


if __name__ == "__main__":
    main()

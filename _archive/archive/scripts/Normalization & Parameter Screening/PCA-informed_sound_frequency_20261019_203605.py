"""Family-wise within-bout PCA for Eq2 sound-structure candidates.

Five separate PCAs (YAMNet proportions, YAMNet scores, broad bands, octave bands,
spectral descriptors). Calibrated `ucm_SND_dBA` stays outside PCA and remains in
Equation 2 via the Eq1 heat × sound structure. Broad-band proportions enter as
ILR coordinates; octave composition is checked and reported.
"""
from __future__ import annotations

import argparse
import hashlib
import shutil
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
OUT_DIR = REPO_ROOT / (
    "output/statistical_analysis/Normalization & Parameter Screening/"
    "PCA-informed/Sound frequencies selection"
)
PARTICIPANTS = ["P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"]
PHASES = ["BikeU", "WalkU", "BikeG", "WalkG"]
PHASE_LEVELS = ["WalkG", "WalkU", "BikeG", "BikeU"]
VARIANCE_TARGET = 0.80
VIF_THRESHOLD = 5.0
CORR_THRESHOLD = 0.70
TARGET_N_MIN = 3
TARGET_N_MAX = 5
GROUP = ["ParticipantID", "PhaseID"]
METHOD = "within-bout standardized correlation PCA (family-wise)"
REPORT_NAME = "Sound_screening_pca_vif.md"

YAMNET_STEMS = [
    "wind", "rural_natural", "vehicle", "urban_manmade_neutral",
    "urban_manmade_positive", "urban_manmade_negative", "mechanisms",
]
SCORES = [f"{c}_score" for c in YAMNET_STEMS]
PROPORTIONS = [f"{c}_prop" for c in YAMNET_STEMS]
BANDS = [
    "freq_prop_20_125", "freq_prop_125_1000", "freq_prop_1000_4000",
    "freq_prop_4000_8000", "freq_prop_8000_20000",
]
OCTAVES = [
    f"octave_prop_{c}_hz"
    for c in ["31_5", "63_0", "125_0", "250_0", "500_0", "1000_0", "2000_0", "4000_0", "8000_0"]
]
SPECTRAL = ["dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz"]
SOUND_COLUMNS = ["ucm_SND_dBA"] + SPECTRAL + BANDS + OCTAVES + SCORES + PROPORTIONS + ["unidentify_prop"]

TEXT_OR_NOMINAL_SOUND_FIELDS = {
    "category": "Nominal classifier text label; audit field, not a PCA input.",
}
DIAGNOSTIC_COLUMNS = {
    "unidentify_prop": "Unidentified-classification residue; diagnostic only.",
}
OUTSIDE_PCA = {
    "ucm_SND_dBA": "Calibrated level; kept outside PCA and retained in Equation 2 via Eq1 heat × sound.",
}
STRUCTURAL_COLUMNS = {
    "ParticipantID": "Bout grouping / LOPO only.",
    "PhaseID": "Bout grouping / phase contrasts only.",
    "Datetime": "Elapsed-time (<480 s) filter only.",
}

FAMILIES = {
    "yamnet_proportions": {
        "label": "YAMNet proportions",
        "original_columns": PROPORTIONS,
        "compositional": False,
    },
    "yamnet_scores": {
        "label": "YAMNet scores",
        "original_columns": SCORES,
        "compositional": False,
    },
    "broad_bands": {
        "label": "Broad frequency bands",
        "original_columns": BANDS,
        "compositional": True,
    },
    "octave_bands": {
        "label": "Octave bands",
        "original_columns": OCTAVES,
        "compositional": "check",
    },
    "spectral_descriptors": {
        "label": "Spectral descriptors",
        "original_columns": SPECTRAL,
        "compositional": False,
    },
}

EQ1_BILATERAL = {
    "atmo_pm2.5_avg": (
        "atmo_lys_atmotube_left__atmotube_pm2.5",
        "atmo_lys_atmotube_right__atmotube_pm2.5",
    ),
    "lys_lux_avg": ("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
    "lys_kelvin_avg": ("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"),
}
EQ1_CONTINUOUS = [
    "ucm_UTCI", "ucm_SND_dBA", "ucm_MRT", "ucm_SUN_Gh", "SVF",
    "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg", "gvi_50m",
]
EQ1_INTERACTIONS = [("ucm_UTCI", "ucm_SND_dBA"), ("ucm_MRT", "ucm_SND_dBA")]
PHASE_SUM_COLS = ["PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG"]


# ==============================================================================
# LOAD
# ==============================================================================


def load_analysis_frame(path: Path) -> tuple[pd.DataFrame, str]:
    """Read the matched cohort once; validate sound fields and Eq1 covariates."""
    source_bytes = path.read_bytes()
    raw = pd.read_csv(BytesIO(source_bytes), low_memory=False)
    bilateral_needed = [c for pair in EQ1_BILATERAL.values() for c in pair]
    required = (
        GROUP + ["Datetime", "category"] + SOUND_COLUMNS
        + ["ucm_UTCI", "ucm_MRT", "ucm_SUN_Gh", "SVF", "gvi_50m"] + bilateral_needed
    )
    missing = sorted(set(required) - set(raw.columns))
    if missing:
        raise ValueError(f"Missing required fields: {missing}")
    sub = raw.loc[raw.ParticipantID.isin(PARTICIPANTS) & raw.PhaseID.isin(PHASES), required].copy()
    sub["Datetime"] = pd.to_datetime(sub.Datetime, errors="raise")
    if sub.duplicated(GROUP + ["Datetime"]).any():
        raise ValueError("Duplicate sound windows")
    elapsed = (sub.Datetime - sub.groupby(GROUP).Datetime.transform("min")).dt.total_seconds()
    sub = sub.loc[elapsed < 480].reset_index(drop=True)
    if sub.groupby(GROUP).ngroups != len(PARTICIPANTS) * len(PHASES):
        raise ValueError("Missing declared participant-phase bout")
    for name, cols in EQ1_BILATERAL.items():
        sub[name] = sub[list(cols)].mean(axis=1, skipna=True)
    for c in SOUND_COLUMNS + EQ1_CONTINUOUS:
        sub[c] = pd.to_numeric(sub[c], errors="raise")
    for c in SOUND_COLUMNS:
        values = sub[c].dropna()
        if not np.isfinite(values).all() or (values < 0).any():
            raise ValueError(f"Nonfinite or negative sound values: {c}")
    prop_like = BANDS + OCTAVES + PROPORTIONS + ["unidentify_prop"]
    if (sub[prop_like] > 1 + 1e-10).any().any():
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


def phase_sum_design(phase: pd.Series) -> pd.DataFrame:
    """R contr.sum(4) on WalkG, WalkU, BikeG, BikeU → three PhaseSum columns."""
    phase = pd.Categorical(phase.astype(str), categories=PHASE_LEVELS, ordered=False)
    if phase.isna().any():
        raise ValueError("Unknown or missing PhaseID")
    codes = phase.codes  # 0..3
    design = np.zeros((len(phase), 3), dtype=float)
    for i in range(3):
        design[codes == i, i] = 1.0
    design[codes == 3, :] = -1.0
    return pd.DataFrame(design, index=phase.index if hasattr(phase, "index") else None,
                        columns=PHASE_SUM_COLS)


def vif_per_term_standardized(frame: pd.DataFrame, columns: list[str]) -> pd.Series:
    if not columns:
        return pd.Series(dtype=float)
    if len(columns) == 1:
        return pd.Series({columns[0]: 1.0})
    z = standardized_matrix(frame, columns)
    r = z.corr().values
    if np.linalg.matrix_rank(r) < len(columns):
        return pd.Series(np.inf, index=columns)
    return pd.Series(np.diag(np.linalg.inv(r)), index=columns)


def max_vif_standardized(frame: pd.DataFrame, columns: list[str]) -> float:
    vifs = vif_per_term_standardized(frame, columns)
    return float(vifs.max()) if len(vifs) else float("nan")


def vif_per_term_matrix(z: pd.DataFrame) -> pd.Series:
    columns = list(z.columns)
    if len(columns) == 1:
        return pd.Series({columns[0]: 1.0})
    r = z.corr().values
    if np.linalg.matrix_rank(r) < len(columns):
        return pd.Series(np.inf, index=columns)
    return pd.Series(np.diag(np.linalg.inv(r)), index=columns)


def sound_set_vif_screen(frame: pd.DataFrame, columns: list[str]) -> dict:
    """Drop highest-VIF term until all retained terms meet the cutoff."""
    names = list(columns)
    if not names:
        empty = pd.Series(dtype=float)
        return {"initial_vifs": empty, "final_vifs": empty, "retained": [],
                "dropped_term": None, "history": pd.DataFrame()}
    initial = vif_per_term_standardized(frame, names)
    history, dropped = [], []
    while True:
        vifs = vif_per_term_standardized(frame, names)
        worst = str(vifs.idxmax())
        remove = float(vifs.max()) > VIF_THRESHOLD
        history.append({
            "Iteration": len(history), "Terms": len(names),
            "Maximum_VIF": float(vifs.max()), "Highest_term": worst,
            "Action": f"Remove {worst}" if remove else "Retain set",
        })
        if not remove:
            break
        names.remove(worst)
        dropped.append(worst)
        if not names:
            break
    return {"initial_vifs": initial, "final_vifs": vifs, "retained": names,
            "dropped_term": ", ".join(dropped) if dropped else None,
            "history": pd.DataFrame(history)}


def composition_audit(frame: pd.DataFrame, columns: list[str], atol: float = 1e-6) -> dict:
    complete = frame[columns].dropna()
    totals = complete.sum(axis=1)
    positive = bool((complete > 0).all().all())
    closed = bool(np.allclose(totals, 1.0, atol=atol, rtol=0)) if len(totals) else False
    return {
        "n_complete": int(len(complete)),
        "sum_min": float(totals.min()) if len(totals) else float("nan"),
        "sum_median": float(totals.median()) if len(totals) else float("nan"),
        "sum_max": float(totals.max()) if len(totals) else float("nan"),
        "closed_to_one": closed,
        "all_parts_positive": positive,
        "use_ilr": closed and positive,
    }


def ilr_helmert(values: np.ndarray) -> np.ndarray:
    """Orthonormal sequential binary partition ILR (Egozcue et al., 2003)."""
    if np.any(values <= 0) or not np.isfinite(values).all():
        raise ValueError("ILR requires strictly positive finite parts")
    log_x = np.log(values)
    d = values.shape[1]
    coords = np.empty((values.shape[0], d - 1), dtype=float)
    for i in range(d - 1):
        n_pos = i + 1
        scale = np.sqrt(n_pos / (n_pos + 1.0))
        coords[:, i] = scale * (log_x[:, :n_pos].mean(axis=1) - log_x[:, n_pos])
    return coords


def ilr_feature_frame(frame: pd.DataFrame, columns: list[str]) -> pd.DataFrame:
    coords = ilr_helmert(frame[columns].to_numpy(dtype=float))
    names = [f"ilr_{i + 1}" for i in range(coords.shape[1])]
    return pd.DataFrame(coords, index=frame.index, columns=names)


def representatives_from_loadings(weights: np.ndarray, k: int) -> np.ndarray:
    """B4-style: largest absolute loading not already selected."""
    chosen = []
    for component in weights[:k]:
        order = np.argsort(-np.abs(component), kind="stable")
        chosen.append(next(int(j) for j in order if j not in chosen))
    return np.asarray(chosen, dtype=int)


def representatives_from_correlations(corr_abs: np.ndarray, k: int) -> np.ndarray:
    """Distinct original variables with largest |corr| to each retained PC."""
    chosen = []
    for pc in range(k):
        order = np.argsort(-corr_abs[pc], kind="stable")
        chosen.append(next(int(j) for j in order if j not in chosen))
    return np.asarray(chosen, dtype=int)


def fit_family_pca(frame: pd.DataFrame, family_id: str, target: float) -> dict:
    meta = FAMILIES[family_id]
    original = list(meta["original_columns"])
    audit = composition_audit(frame, original)
    compositional_flag = meta["compositional"]
    if compositional_flag is True:
        use_ilr = True
    elif compositional_flag == "check":
        use_ilr = audit["use_ilr"]
    else:
        use_ilr = False
    if compositional_flag is True and not audit["use_ilr"]:
        raise ValueError(f"{family_id}: declared compositional but not closed/positive")

    complete = frame.dropna(subset=original).copy()
    if use_ilr:
        features = ilr_feature_frame(complete, original)
        feature_columns = list(features.columns)
        work = complete[GROUP + original].copy()
        for c in feature_columns:
            work[c] = features[c].to_numpy()
    else:
        feature_columns = original
        work = complete

    x = standardized_matrix(work, feature_columns)
    if len(x) <= len(feature_columns):
        raise ValueError(f"Insufficient complete windows for {family_id}")
    pca = PCA(svd_solver="full").fit(x)
    for row in pca.components_:
        if row[np.argmax(np.abs(row))] < 0:
            row *= -1
    scores = pca.transform(x)
    rank = int(np.linalg.matrix_rank(x - x.mean()))
    k = int(np.searchsorted(np.cumsum(pca.explained_variance_ratio_), target) + 1)
    k = min(max(k, 1), rank)
    raw_centered = complete[original] - complete.groupby(GROUP)[original].transform("mean")
    corr_abs = np.abs(np.corrcoef(scores[:, :k].T, raw_centered.to_numpy().T)[:k, k:])
    if use_ilr:
        chosen = representatives_from_correlations(corr_abs, k)
    else:
        chosen = representatives_from_loadings(pca.components_, k)

    similarity, winners = [], []
    for pid in complete.ParticipantID.unique():
        train_idx = complete.ParticipantID != pid
        train = work.loc[train_idx]
        xt = standardized_matrix(train, feature_columns)
        fitted = PCA(svd_solver="full").fit(xt)
        train_rank = int(np.linalg.matrix_rank(xt - xt.mean()))
        if train_rank < k:
            raise ValueError(f"{family_id}: leaving out {pid} makes retained subspace unidentifiable")
        match = np.abs(pca.components_[:k] @ fitted.components_[:train_rank].T)
        rows, matched = linear_sum_assignment(match, maximize=True)
        order = matched[np.argsort(rows)]
        aligned = fitted.components_[order]
        similarity.append(match[np.arange(k), order])
        if use_ilr:
            train_complete = complete.loc[train_idx]
            train_scores = fitted.transform(xt)[:, :k]
            train_centered = (
                train_complete[original]
                - train_complete.groupby(GROUP)[original].transform("mean")
            )
            train_corr = np.abs(np.corrcoef(train_scores.T, train_centered.to_numpy().T)[:k, k:])
            winners.append(representatives_from_correlations(train_corr, k))
        else:
            winners.append(representatives_from_loadings(aligned, k))
    similarities = np.asarray(similarity)
    winners = np.asarray(winners)

    records = []
    for pc in range(rank):
        representative = int(chosen[pc]) if pc < k else None
        for j, column in enumerate(feature_columns):
            records.append({
                "family": family_id,
                "family_label": meta["label"],
                "method": METHOD,
                "transform": "ILR" if use_ilr else "identity",
                "PC": pc + 1,
                "feature": column,
                "feature_role": "ilr_coordinate" if use_ilr else "original_variable",
                "coefficient": pca.components_[pc, j],
                "squared_coefficient_pct": 100 * pca.components_[pc, j] ** 2,
                "corr_transformed_feature_PC": np.corrcoef(x[column], scores[:, pc])[0, 1],
                "PC_retained": pc < k,
                "candidate_representative_feature": (not use_ilr) and j == representative,
            })
    original_records = []
    for pc in range(k):
        for j, column in enumerate(original):
            original_records.append({
                "family": family_id,
                "family_label": meta["label"],
                "PC": pc + 1,
                "original_column": column,
                "corr_original_within_bout_PC": np.corrcoef(
                    raw_centered[column], scores[:, pc])[0, 1],
                "abs_corr": float(corr_abs[pc, j]),
                "candidate_representative": j == int(chosen[pc]),
                "LOPO_selection_fraction": float(np.mean(winners[:, pc] == j)),
                "LOPO_min_abs_component_cosine": float(similarities[:, pc].min()),
                "loading_or_assoc": (
                    float(corr_abs[pc, j]) if use_ilr
                    else float(pca.components_[pc, original.index(column)])
                ),
            })

    if rank < 2:
        raise ValueError(f"{family_id}: need at least 2 PCs for a family biplot")
    # Biplot arrows = correlation of every original family column with PC1/PC2 scores.
    z_original = standardized_matrix(complete, original)
    biplot_corr = np.column_stack([
        [np.corrcoef(z_original[column], scores[:, pc])[0, 1] for column in original]
        for pc in range(2)
    ])
    if biplot_corr.shape != (len(original), 2):
        raise ValueError(f"{family_id}: biplot correlation shape mismatch")
    if not np.isfinite(biplot_corr).all():
        raise ValueError(f"{family_id}: non-finite biplot correlations")
    if set(original) != set(meta["original_columns"]):
        raise ValueError(f"{family_id}: original column set drifted from family definition")

    return dict(
        family=family_id,
        label=meta["label"],
        original_columns=original,
        feature_columns=feature_columns,
        use_ilr=use_ilr,
        composition_audit=audit,
        complete=complete,
        x=x,
        pca=pca,
        scores=scores,
        rank=rank,
        k=k,
        records=records,
        original_records=original_records,
        chosen=chosen,
        chosen_names=[original[i] for i in chosen],
        similarities=similarities,
        winners=winners,
        biplot_corr=biplot_corr,
    )


def construct_stem(name: str) -> str | None:
    for stem in YAMNET_STEMS:
        if name in {f"{stem}_prop", f"{stem}_score"}:
            return stem
    return None


# H4 scientific slots: traffic + low-frequency structure first (hypothesis / Hamida),
# then one other semantic, then at most one spectral-shape descriptor.
SCIENCE_SLOTS = [
    {
        "name": "traffic",
        "prefer": ["vehicle_prop", "vehicle_score"],
    },
    {
        "name": "low_frequency",
        "prefer": [
            "freq_prop_20_125", "octave_prop_63_0_hz", "octave_prop_125_0_hz",
            "freq_prop_125_1000", "octave_prop_31_5_hz",
        ],
    },
    {
        "name": "semantic_other",
        "prefer": [
            "wind_prop", "wind_score", "urban_manmade_positive_prop",
            "urban_manmade_positive_score", "urban_manmade_negative_prop",
            "urban_manmade_negative_score", "mechanisms_prop", "mechanisms_score",
            "rural_natural_prop", "rural_natural_score", "urban_manmade_neutral_prop",
            "urban_manmade_neutral_score",
        ],
    },
    {
        "name": "spectral_shape",
        "prefer": ["spectral_centroid_hz", "dominant_frequency_hz", "spectral_rolloff85_hz"],
    },
]


def _pool_row(pool: pd.DataFrame, column: str) -> pd.Series | None:
    hit = pool.loc[pool.column == column]
    return None if hit.empty else hit.iloc[0]


def _can_add(frame: pd.DataFrame, selected: list[str], column: str,
             *, use_corr: bool = True) -> tuple[bool, str]:
    if column in selected:
        return False, f"Skip {column}: duplicate."
    stem = construct_stem(column)
    if stem is not None:
        conflict = [c for c in selected if construct_stem(c) == stem]
        if conflict:
            return False, (
                f"Skip {column}: same YAMNet construct as {conflict[0]} "
                "(prefer one of prop/score)."
            )
    # At most one spectral descriptor (shape family is internally redundant).
    if column in SPECTRAL and any(c in SPECTRAL for c in selected):
        return False, f"Skip {column}: spectral-shape slot already filled."
    # Prefer a single low-frequency representation from broad OR octave.
    low_freq = set(SCIENCE_SLOTS[1]["prefer"])
    if column in low_freq and any(c in low_freq for c in selected):
        return False, f"Skip {column}: low-frequency slot already filled."
    candidate = selected + [column]
    complete = frame.dropna(subset=candidate)
    if use_corr and selected:
        z = standardized_matrix(complete, candidate)
        corr = z.corr().loc[column, selected].abs()
        if float(corr.max()) >= CORR_THRESHOLD:
            partner = str(corr.idxmax())
            return False, (
                f"Skip {column}: |r|={float(corr.max()):.3f} with {partner} "
                f"(threshold {CORR_THRESHOLD:g})."
            )
    vifs = vif_per_term_standardized(complete, candidate)
    if float(vifs.max()) > VIF_THRESHOLD:
        return False, (
            f"Skip {column}: sound-set max VIF {float(vifs.max()):.3f} > {VIF_THRESHOLD:g}."
        )
    return True, ""


def combine_family_representatives(frame: pd.DataFrame, family_results: list[dict]) -> dict:
    """Merge family reps; scientific slots + correlation/VIF prune → 3–5 terms."""
    rows = []
    for result in family_results:
        for rec in result["original_records"]:
            if not rec["candidate_representative"]:
                continue
            rows.append({
                "family": result["family"],
                "family_label": result["label"],
                "PC": rec["PC"],
                "column": rec["original_column"],
                "assoc": rec["loading_or_assoc"],
                "abs_assoc": abs(rec["loading_or_assoc"]),
                "LOPO_selection_fraction": rec["LOPO_selection_fraction"],
                "LOPO_min_abs_component_cosine": rec["LOPO_min_abs_component_cosine"],
                "transform": "ILR" if result["use_ilr"] else "identity",
            })
    pool = pd.DataFrame(rows)
    if pool.empty:
        raise ValueError("No family representatives available")
    # Within a YAMNet stem, prefer proportion over score for prevalence interpretation.
    pool["prop_preference"] = pool["column"].str.endswith("_prop").astype(int)
    pool = pool.sort_values(
        ["LOPO_selection_fraction", "prop_preference", "abs_assoc", "family", "PC"],
        ascending=[False, False, False, True, True],
        kind="mergesort",
    ).reset_index(drop=True)

    selected, notes = [], []
    available = set(pool["column"])

    for slot in SCIENCE_SLOTS:
        if len(selected) >= TARGET_N_MAX:
            break
        placed = False
        for column in slot["prefer"]:
            if column not in available:
                continue
            ok, reason = _can_add(frame, selected, column, use_corr=True)
            if not ok:
                notes.append(f"Slot {slot['name']}: {reason}")
                continue
            row = _pool_row(pool, column)
            selected.append(column)
            notes.append(
                f"Slot {slot['name']}: keep {column} from {row.family_label} PC{int(row.PC)} "
                f"(LOPO={row.LOPO_selection_fraction:.2f}; scientific priority)."
            )
            placed = True
            break
        if not placed:
            notes.append(f"Slot {slot['name']}: no eligible family representative.")

    # Fill remaining capacity by LOPO/stability order under the same constraints.
    for _, row in pool.iterrows():
        if len(selected) >= TARGET_N_MAX:
            notes.append(f"Skip {row.column}: already at target maximum {TARGET_N_MAX}.")
            continue
        ok, reason = _can_add(frame, selected, row.column, use_corr=True)
        if not ok:
            notes.append(reason)
            continue
        selected.append(row.column)
        notes.append(
            f"Fill keep {row.column} from {row.family_label} PC{int(row.PC)} "
            f"(LOPO={row.LOPO_selection_fraction:.2f})."
        )

    if len(selected) < TARGET_N_MIN:
        for _, row in pool.iterrows():
            if len(selected) >= TARGET_N_MIN:
                break
            ok, reason = _can_add(frame, selected, row.column, use_corr=False)
            if not ok:
                notes.append(f"Relax-fill {reason}")
                continue
            selected.append(row.column)
            notes.append(
                f"Relax-fill keep {row.column} to reach minimum {TARGET_N_MIN} "
                f"(correlation threshold relaxed)."
            )

    screen = sound_set_vif_screen(frame, selected)
    selected = screen["retained"]
    pool["selected_for_eq2"] = pool["column"].isin(selected)
    return {
        "pool": pool,
        "selected": selected,
        "notes": notes,
        "vif_screen": screen,
        "sound_max_vif": float(screen["final_vifs"].max()) if len(selected) else float("nan"),
    }


def eq2_design_matrix(frame: pd.DataFrame, sound_extras: list[str]) -> pd.DataFrame:
    """Within-bout standardized Eq1 continuous terms + interactions + phase sums + extras."""
    needed = EQ1_CONTINUOUS + sound_extras
    complete = frame.dropna(subset=needed).copy()
    z = standardized_matrix(complete, EQ1_CONTINUOUS)
    design = z.copy()
    for a, b in EQ1_INTERACTIONS:
        design[f"{a}:{b}"] = z[a] * z[b]
    for col in sound_extras:
        design[col] = standardized_matrix(complete, [col])[col]
    phase = phase_sum_design(complete["PhaseID"])
    for col in PHASE_SUM_COLS:
        design[col] = phase[col].to_numpy()
    return design


def full_eq2_vif(frame: pd.DataFrame, sound_extras: list[str]) -> dict:
    design = eq2_design_matrix(frame, sound_extras)
    vifs = vif_per_term_matrix(design)
    return {
        "design_columns": list(design.columns),
        "n_rows": len(design),
        "vifs": vifs,
        "max_vif": float(vifs.max()),
        "worst_term": str(vifs.idxmax()),
        "full_rank": int(np.linalg.matrix_rank(design.corr().values)) == len(design.columns),
    }


def self_check() -> None:
    frame = pd.DataFrame({
        "ParticipantID": ["A"] * 4 + ["B"] * 4,
        "PhaseID": ["WalkG"] * 8,
        "x": [1., 2., 4., 8.] * 2,
        "y": [3., 1., 5., 2.] * 2,
    })
    x = standardized_matrix(frame, ["x", "y"])
    assert np.allclose(x.std(ddof=1), 1)
    assert np.allclose(x.groupby([frame[c] for c in GROUP]).mean(), 0)
    frame["x"] *= 1000
    assert np.allclose(x, standardized_matrix(frame, ["x", "y"]))
    assert "ucm_SND_dBA" not in [c for f in FAMILIES.values() for c in f["original_columns"]]
    assert len(PROPORTIONS) == 7 and len(SCORES) == 7
    assert len(BANDS) == 5 and len(OCTAVES) == 9 and len(SPECTRAL) == 3
    comps = np.array([[0.1, 0.2, 0.3, 0.4], [0.25, 0.25, 0.25, 0.25]])
    ilr = ilr_helmert(comps)
    assert ilr.shape == (2, 3) and np.isfinite(ilr).all()
    assert list(representatives_from_loadings(np.array([[.9, .8, .1], [.9, .7, .6]]), 2)) == [0, 1]
    phase = phase_sum_design(pd.Series(PHASE_LEVELS))
    assert np.allclose(phase.loc[3].to_numpy(), [-1, -1, -1])
    frame["duplicate_x"] = frame["x"]
    screen = sound_set_vif_screen(frame, ["x", "duplicate_x", "y"])
    assert len(screen["retained"]) == 2 and screen["final_vifs"].max() <= VIF_THRESHOLD


TERMS_CSV_NAME = "sound_pca_terms.csv"
PC_CHECK_CSV_NAME = "sound_pca_pc_check.csv"
SCREE_FIG_NAME = "family_screes.png"
BIPLOT_FIG_NAME = "family_biplots.png"


def clear_output_dir(out_dir: Path) -> None:
    """Wipe the live PCA folder before writing the current essential set."""
    if not out_dir.exists():
        return
    for path in out_dir.iterdir():
        if path.is_file():
            path.unlink()
        elif path.is_dir():
            shutil.rmtree(path)


def _panel_grid_one_row(n_families: int, panel_w: float = 4.8, panel_h: float = 4.8):
    """Single row of panels, one family per panel."""
    fig, axes = plt.subplots(
        1, n_families, figsize=(panel_w * n_families, panel_h), squeeze=False,
    )
    return fig, axes[0]


def make_combined_scree(family_results: list[dict]) -> plt.Figure:
    """One figure: scree panel per family, all in one row."""
    fig, axes = _panel_grid_one_row(len(family_results), panel_w=4.6, panel_h=4.6)
    for i, result in enumerate(family_results):
        ax = axes[i]
        pca, rank, k = result["pca"], result["rank"], result["k"]
        pcs = np.arange(1, rank + 1)
        ev = pca.explained_variance_ratio_[:rank] * 100
        bars = ax.bar(pcs, ev, color="slategray")
        ax.plot(pcs, np.cumsum(ev), "o-", color="black", markersize=3)
        ax.axvline(k + 0.5, color="black", linestyle="--", linewidth=1)
        for bar, value in zip(bars, ev):
            ax.text(
                bar.get_x() + bar.get_width() / 2,
                bar.get_height() + 1.2,
                f"{value:.1f}",
                ha="center",
                va="bottom",
                fontsize=7,
                color="black",
            )
        cum = 100 * pca.explained_variance_ratio_[:k].sum()
        ilr = "ILR" if result["use_ilr"] else "raw"
        ax.set(
            title=f"{result['label']} ({ilr}): {k} PCs, {cum:.1f}%",
            xlabel="PC",
            ylabel="Variance (%)",
            ylim=(0, 112),
        )
    fig.suptitle("Family-wise PCA scree plots", fontsize=12, y=1.02)
    fig.tight_layout()
    return fig


def _short_biplot_label(name: str) -> str:
    """Display label only; every original column is still drawn exactly once."""
    return (
        name.replace("freq_prop_", "f")
        .replace("octave_prop_", "oct")
        .replace("_hz", "")
        .replace("urban_manmade_", "um_")
        .replace("rural_natural", "rural")
        .replace("spectral_", "sp_")
        .replace("dominant_frequency", "dom_freq")
    )


def draw_family_biplot(ax: plt.Axes, result: dict, eq2_selected: set[str]) -> list[str]:
    """Correlation biplot for one family; draw every original family column.

    Bold = family PCA representative (one per retained PC).
    Black box around label = also kept for Eq2 after cross-family selection.
    """
    columns = list(result["original_columns"])
    representatives = list(result["chosen_names"])
    if len(representatives) != result["k"]:
        raise ValueError(
            f"{result['family']}: expected {result['k']} PCA representatives, "
            f"got {len(representatives)}"
        )
    if len(set(representatives)) != len(representatives):
        raise ValueError(f"{result['family']}: duplicate PCA representatives")
    if not set(representatives).issubset(set(columns)):
        raise ValueError(f"{result['family']}: representative outside family columns")
    rep_set = set(representatives)
    corr = np.asarray(result["biplot_corr"], dtype=float)
    if corr.shape != (len(columns), 2):
        raise ValueError(f"{result['family']}: biplot must cover every original column")
    pca = result["pca"]
    ev = pca.explained_variance_ratio_[:2] * 100
    pc_sd = np.sqrt(pca.explained_variance_[:2])
    row_xy = result["scores"][:, :2] / pc_sd
    ax.scatter(row_xy[:, 0], row_xy[:, 1], s=4, alpha=0.12, color="slategray", linewidths=0)
    drawn = []
    bolded = []
    for j, column in enumerate(columns):
        vx, vy = corr[j, 0], corr[j, 1]
        is_rep = column in rep_set
        is_eq2 = column in eq2_selected
        ax.annotate(
            "",
            xy=(vx, vy),
            xytext=(0, 0),
            arrowprops=dict(
                arrowstyle="->",
                color="black" if is_rep else "dimgray",
                lw=1.5 if is_rep else 0.8,
                alpha=1.0 if is_rep else 0.75,
            ),
        )
        scale = 1.12
        ax.text(
            vx * scale,
            vy * scale,
            _short_biplot_label(column),
            fontsize=7,
            ha="center",
            va="center",
            color="black",
            fontweight="bold" if is_rep else "normal",
            bbox=dict(
                facecolor="white",
                edgecolor="black" if is_eq2 else "none",
                linewidth=1.0 if is_eq2 else 0.0,
                alpha=0.85,
                pad=0.7,
            ),
        )
        drawn.append(column)
        if is_rep:
            bolded.append(column)
    if set(bolded) != set(representatives) or len(bolded) != len(representatives):
        raise ValueError(
            f"{result['family']}: bold labels must equal PCA representatives; "
            f"bolded={sorted(bolded)}; reps={sorted(representatives)}"
        )
    if drawn != columns:
        raise ValueError(
            f"{result['family']}: biplot draw order mismatch; "
            f"drawn={drawn}, expected={columns}"
        )
    if set(drawn) != set(columns) or len(drawn) != len(columns):
        missing = sorted(set(columns) - set(drawn))
        extra = sorted(set(drawn) - set(columns))
        raise ValueError(
            f"{result['family']}: biplot must show every family column exactly once; "
            f"missing={missing}; extra={extra}"
        )
    ax.axhline(0, color="black", lw=0.5, alpha=0.3)
    ax.axvline(0, color="black", lw=0.5, alpha=0.3)
    lim = 1.35
    ax.set(
        xlim=(-lim, lim),
        ylim=(-lim, lim),
        aspect="equal",
        xlabel=f"PC1 ({ev[0]:.1f}%)",
        ylabel=f"PC2 ({ev[1]:.1f}%)",
    )
    ilr = "ILR PCA; arrows = corr(original, PC)" if result["use_ilr"] else "corr. PCA"
    ax.set_title(
        f"{result['label']} (n={len(columns)}; reps={result['k']}; {ilr})",
        fontsize=10,
    )
    return drawn


def make_combined_biplots(family_results: list[dict], selected: list[str]) -> plt.Figure:
    """One figure: biplot panel per family, all in one row; every family column labeled."""
    eq2_selected = set(selected)
    fig, axes = _panel_grid_one_row(len(family_results), panel_w=5.0, panel_h=5.0)
    inventory = {}
    for i, result in enumerate(family_results):
        drawn = draw_family_biplot(axes[i], result, eq2_selected)
        expected = list(FAMILIES[result["family"]]["original_columns"])
        if drawn != expected:
            raise ValueError(
                f"{result['family']}: biplot columns {drawn} != family definition {expected}"
            )
        inventory[result["family"]] = drawn
    for family_id, meta in FAMILIES.items():
        if family_id not in inventory:
            raise ValueError(f"Missing biplot panel for family {family_id}")
        if inventory[family_id] != list(meta["original_columns"]):
            raise ValueError(f"Family {family_id} biplot incomplete")
    fig.suptitle(
        "Family-wise correlation biplots "
        "(bold = PCA representative per retained PC; boxed = kept for Eq2)",
        fontsize=11,
        y=1.02,
    )
    fig.tight_layout()
    return fig


def cumulative_vif_steps(frame: pd.DataFrame, columns_in_order: list[str]) -> list[dict]:
    """Max VIF after each successive term is added (PC / selection order)."""
    rows = []
    for step, name in enumerate(columns_in_order, start=1):
        subset = columns_in_order[:step]
        complete = frame.dropna(subset=subset)
        vifs = vif_per_term_standardized(complete, subset)
        rows.append({
            "step": step,
            "terms_included": step,
            "latest_term": name,
            "terms_in_set": " + ".join(subset),
            "term_VIF": float(vifs[name]),
            "max_VIF": float(vifs.max()),
            "highest_VIF_term": str(vifs.idxmax()),
        })
    return rows


def write_outputs(out_dir: Path, frame: pd.DataFrame, family_results: list[dict],
                  combined: dict, eq2_vif: dict) -> dict[str, Path]:
    """Write terms CSV + PC-check CSV + scree + biplot (folder wiped first)."""
    clear_output_dir(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    paths: dict[str, Path] = {}
    scree = make_combined_scree(family_results)
    scree_path = out_dir / SCREE_FIG_NAME
    scree.savefig(scree_path, dpi=160, bbox_inches="tight")
    plt.close(scree)
    paths[SCREE_FIG_NAME] = scree_path

    biplot = make_combined_biplots(family_results, combined["selected"])
    biplot_path = out_dir / BIPLOT_FIG_NAME
    biplot.savefig(biplot_path, dpi=160, bbox_inches="tight")
    plt.close(biplot)
    paths[BIPLOT_FIG_NAME] = biplot_path

    for result in family_results:
        expected = list(FAMILIES[result["family"]]["original_columns"])
        got = list(result["original_columns"])
        if got != expected:
            raise ValueError(f"{result['family']}: column inventory {got} != {expected}")
        if result["biplot_corr"].shape[0] != len(expected):
            raise ValueError(f"{result['family']}: biplot_corr rows != n columns")

    # Every Family x retained PC x original term — audit who won each PC.
    check_rows = []
    for result in family_results:
        ev = result["pca"].explained_variance_ratio_
        measure = "Correlation" if result["use_ilr"] else "Loading"
        for rec in result["original_records"]:
            pc = int(rec["PC"])
            signed = (
                float(rec["corr_original_within_bout_PC"])
                if result["use_ilr"]
                else float(rec["loading_or_assoc"])
            )
            check_rows.append({
                "Family": result["label"],
                "PC": pc,
                "PC_kept": "Yes" if pc <= result["k"] else "No",
                "Pct_variance": float(100 * ev[pc - 1]),
                "Term": rec["original_column"],
                "Measure": measure,
                "Loading_or_corr": signed,
                "Is_representative": "Yes" if rec["candidate_representative"] else "No",
                "LOPO_how_often_this_term_won": float(rec["LOPO_selection_fraction"]),
            })
    check = pd.DataFrame(check_rows)
    if check.empty:
        raise ValueError("PC-check table is empty")
    # One Yes per Family x PC among retained PCs.
    wins = check.loc[check["Is_representative"] == "Yes"]
    if wins.duplicated(["Family", "PC"]).any():
        raise ValueError("PC-check: more than one representative for a Family x PC")
    n_expected = sum(result["k"] for result in family_results)
    if len(wins) != n_expected:
        raise ValueError(
            f"PC-check: expected {n_expected} representatives, got {len(wins)}"
        )
    check_path = out_dir / PC_CHECK_CSV_NAME
    check.to_csv(check_path, index=False)
    paths[PC_CHECK_CSV_NAME] = check_path

    # One row per PCA survivor. Plain column names only.
    term_rows = []
    overall_terms: list[str] = []
    family_running: dict[str, list[str]] = {fid: [] for fid in FAMILIES}
    row_number = 0
    for result in family_results:
        ordered = list(result["chosen_names"])
        if ordered != [result["original_columns"][i] for i in result["chosen"]]:
            raise ValueError(f"{result['family']}: chosen_names out of PC order")
        rec_by_col = {
            rec["original_column"]: rec
            for rec in result["original_records"]
            if rec["candidate_representative"]
        }
        for step_in_family, term in enumerate(ordered, start=1):
            row_number += 1
            family_running[result["family"]].append(term)
            overall_terms.append(term)
            family_vifs = vif_per_term_standardized(
                frame.dropna(subset=family_running[result["family"]]),
                family_running[result["family"]],
            )
            all_vifs = vif_per_term_standardized(
                frame.dropna(subset=overall_terms), overall_terms,
            )
            rec = rec_by_col[term]
            term_rows.append({
                "Row": row_number,
                "Family": result["label"],
                "Step_in_family": step_in_family,
                "PC": int(rec["PC"]),
                "Term": term,
                "Kept_in_Eq2": "Yes" if term in combined["selected"] else "No",
                "PCA_loading_or_corr": float(rec["loading_or_assoc"]),
                "LOPO_stability": float(rec["LOPO_selection_fraction"]),
                "Terms_added_in_this_family_so_far": " + ".join(
                    family_running[result["family"]]
                ),
                "VIF_max_within_this_family_so_far": float(family_vifs.max()),
                "Terms_added_from_all_rows_above_so_far": " + ".join(overall_terms),
                "VIF_max_all_rows_above_so_far": float(all_vifs.max()),
            })
    terms = pd.DataFrame(term_rows)
    terms_path = out_dir / TERMS_CSV_NAME
    terms.to_csv(terms_path, index=False)
    paths[TERMS_CSV_NAME] = terms_path
    return paths


def build_report(frame, family_results, combined, eq2_vif, target, digest,
                 merged_path) -> str:
    extras = " + ".join(f"`{c}`" for c in combined["selected"]) if combined["selected"] else "_none_"
    sel = combined["pool"].loc[combined["pool"].column.isin(combined["selected"])].copy()
    if len(sel):
        sel = sel.drop_duplicates("column")
        sel["order"] = sel["column"].map({c: i + 1 for i, c in enumerate(combined["selected"])})
        sel = sel.sort_values("order")
        sel_table = sel[[
            "order", "column", "family_label", "PC", "assoc", "LOPO_selection_fraction",
        ]].rename(columns={"assoc": "loading_or_corr", "LOPO_selection_fraction": "LOPO"}).to_markdown(
            index=False, floatfmt=".3f")
    else:
        sel_table = "_No sound mains retained._"

    family_rows = []
    for result in family_results:
        audit = result["composition_audit"]
        cum = 100 * result["pca"].explained_variance_ratio_[:result["k"]].sum()
        reps = ", ".join(f"`{n}`" for n in result["chosen_names"])
        family_rows.append({
            "family": result["label"],
            "n": len(result["original_columns"]),
            "ILR": "yes" if result["use_ilr"] else "no",
            "PCs": f"{result['k']} ({cum:.1f}%)",
            "representatives": reps,
            "closed_composition": audit["closed_to_one"],
        })
    family_table = pd.DataFrame(family_rows).to_markdown(index=False)

    keep_notes = [n for n in combined["notes"] if n.startswith("Slot ") or n.startswith("Fill keep")]
    lines = [
        "# Sound screening: family-wise PCA and VIF",
        "",
        "**Status: done.** Family-wise PCA screening finished; Eq2 sound mains locked in "
        "`scripts/H4_multivariate.R`. H4 already refit with these terms.",
        "",
        "**Read these only** (live PCA folder is wiped each run):",
        f"1. This report - `Presentation material/{REPORT_NAME}`",
        f"2. PC check - `.../{PC_CHECK_CSV_NAME}` "
        "(every Family x PC x Term; `Is_representative=Yes` is the variable chosen for that PC; "
        "`Measure` is Loading or Correlation)",
        f"3. Terms table - `.../{TERMS_CSV_NAME}` "
        "(one row = one PCA survivor; `Kept_in_Eq2=Yes` are the final Eq2 sound mains; "
        "`VIF_max_within_this_family_so_far` and `VIF_max_all_rows_above_so_far` are the two "
        "cumulative VIF columns)",
        f"4. Scree - `.../{SCREE_FIG_NAME}`",
        f"5. Biplots - `.../{BIPLOT_FIG_NAME}` (bold = PCA survivor; boxed = Kept_in_Eq2)",
        "",
        f"**Eq2 sound mains (locked):** Eq1 + {extras}. "
        f"`ucm_SND_dBA` stays in heat x sound. Eqs 1 and 3-7 unchanged.",
        "",
        sel_table,
        "",
        f"**VIF:** Eq2 sound-mains max {combined['sound_max_vif']:.3f}; "
        f"full Eq2 design max {eq2_vif['max_vif']:.3f} on `{eq2_vif['worst_term']}` "
        f"(n={eq2_vif['n_rows']}; full_rank={eq2_vif['full_rank']}). Cutoff {VIF_THRESHOLD:g}.",
        "",
        "## Method (short)",
        "",
        f"{frame.ParticipantID.nunique()} participants, {frame.groupby(GROUP).ngroups} bouts, "
        f"windows < 480 s. Five family PCAs (YAMNet proportions, YAMNet scores, broad bands, "
        f"octave bands, spectral descriptors). Within-bout center + pooled-SD scale. "
        f"Broad bands use ILR when closed and positive; octave composition checked. "
        f"Retain PCs >={target:.0%} variance (no minimum-PC floor). One original representative "
        f"per PC; LOPO stability; then scientific slots + |r|>={CORR_THRESHOLD:g} / VIF prune "
        f"to {TARGET_N_MIN}-{TARGET_N_MAX} terms. Excluded from PCA: `category`, `unidentify_prop`, "
        f"`ucm_SND_dBA`.",
        "",
        "## Family summary",
        "",
        family_table,
        "",
        "## Why these five",
        "",
    ]
    for note in keep_notes:
        lines.append(f"- {note}")
    lines.extend([
        "",
        "**References:** [Jolliffe & Cadima (2016)](https://doi.org/10.1098/rsta.2015.0202), "
        "[Egozcue et al. (2003)](https://doi.org/10.1023/A:1023818214614), "
        "[Dormann et al. (2013)](https://doi.org/10.1111/j.1600-0587.2012.07348.x).",
        "",
        f"Input: {merged_path.resolve()}",
        f"SHA-256: `{digest}`",
        "",
    ])
    return "\n".join(lines)


def run_sound_frequency_pca(merged_path=None, out_dir=None,
                            variance_target=VARIANCE_TARGET, check_only=False):
    merged_path, out_dir = merged_path or MERGED_PATH, out_dir or OUT_DIR
    if not 0 < variance_target < 1:
        raise ValueError("Variance target must be strictly between zero and one")
    self_check()
    frame, digest = load_analysis_frame(merged_path)
    print("Family-wise sound PCA: five blocks; ucm_SND_dBA outside PCA.")
    family_results = [fit_family_pca(frame, family_id, variance_target) for family_id in FAMILIES]
    for result in family_results:
        cum = 100 * result["pca"].explained_variance_ratio_[:result["k"]].sum()
        print(
            f"  {result['family']}: ILR={result['use_ilr']}; "
            f"k={result['k']} ({cum:.1f}%); reps={result['chosen_names']}"
        )
    combined = combine_family_representatives(frame, family_results)
    print(f"Selected Eq2 sound mains ({len(combined['selected'])}): {combined['selected']}")
    eq2_vif = full_eq2_vif(frame, combined["selected"])
    print(
        f"Full Eq2 design max VIF={eq2_vif['max_vif']:.3f} "
        f"({eq2_vif['worst_term']}); full_rank={eq2_vif['full_rank']}"
    )
    summary = dict(
        merged_path=merged_path.resolve(), digest=digest, frame=frame,
        family_results=family_results, combined=combined, eq2_vif=eq2_vif,
    )
    if check_only:
        print("Check only: no output files written.")
        return summary

    out_dir.mkdir(parents=True, exist_ok=True)
    paths = write_outputs(out_dir, frame, family_results, combined, eq2_vif)
    report_path = REPO_ROOT / "Presentation material" / REPORT_NAME
    body = build_report(
        frame, family_results, combined, eq2_vif, variance_target, digest, merged_path,
    )
    report_path.write_text(body, encoding="utf-8")
    paths[REPORT_NAME] = report_path
    summary["outputs"] = paths
    print("Look at these only:")
    print(f"  REPORT:   {report_path.resolve()}")
    print(f"  PC_CHECK: {(out_dir / PC_CHECK_CSV_NAME).resolve()}")
    print(f"  TERMS:    {(out_dir / TERMS_CSV_NAME).resolve()}")
    print(f"  SCREE:    {(out_dir / SCREE_FIG_NAME).resolve()}")
    print(f"  BIPLOTS:  {(out_dir / BIPLOT_FIG_NAME).resolve()}")
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

"""Sync H4_PRISMA_screening.csv with documents/H4_report.md — final decisions, no Pending.

Exclusion codes (only these):
  INDOOR | SOUND_NOT_WITH_HEAT | NOT_APPLICABLE
Full-text Included: records explicitly ported in H4_report.md §2 only.
"""

from __future__ import annotations

from datetime import date
from pathlib import Path

import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
CSV_PATH = ROOT / "documents" / "H4_PRISMA_screening.csv"
REPORT = ROOT / "documents" / "H4_report.md"
CONFIRMED = f"Confirmed {date.today().isoformat()}"
DECISION_BASIS = "H4_report.md"

ALLOWED_EXCLUSION = frozenset({"INDOOR", "SOUND_NOT_WITH_HEAT", "NOT_APPLICABLE"})

# H4_report.md §2 — only these are Included.
INCLUDED_UPDATED: dict[str, dict] = {
    "SC-136": {
        "title_abstract_decision": "Include",
        "title_abstract_exclusion_code": "",
        "title_abstract_evidence": "Outdoor plaza; UTCI + SPL; Spearman TSV×SPL (Zhen 2025).",
        "full_text_retrieval_status": "Retrieved",
        "full_text_decision": "Included",
        "full_text_primary_exclusion_code": "",
        "updated_h4_role": "Updated H4 — Spearman TSV×SPL (§2)",
        "full_text_evidence": "Source ρ(TSV,SPL); Brussels analogue on 22 walk bouts.",
        "decision_basis": "H4_report.md §2 [8] Zhen 2025",
    },
    "SC-269": {
        "title_abstract_decision": "Include",
        "title_abstract_exclusion_code": "",
        "title_abstract_evidence": "Park walks; wearable LAeq + comfort surveys (Cureau/Pisello 2022).",
        "full_text_retrieval_status": "Retrieved",
        "full_text_decision": "Included",
        "full_text_primary_exclusion_code": "",
        "updated_h4_role": "Updated H4 — park vs urban LAeq & votes (§2)",
        "full_text_evidence": "Mann–Whitney LAeq and comfort votes; Brussels paired Wilcoxon.",
        "decision_basis": "H4_report.md §2 [2] Cureau 2022",
    },
    "SC-022": {
        "title_abstract_decision": "Include",
        "title_abstract_exclusion_code": "",
        "title_abstract_evidence": "Thermo-acoustic experiment; physiology within thermal strata (Tang 2026).",
        "full_text_retrieval_status": "Retrieved",
        "full_text_decision": "Included",
        "full_text_primary_exclusion_code": "",
        "updated_h4_role": "Updated H4 — physiology within PET stratum (§2)",
        "full_text_evidence": "Kruskal–Wallis physiology by soundscape within PET band.",
        "decision_basis": "H4_report.md §2 [9] Tang 2026",
    },
    "LOCAL-PENG": {
        "title_abstract_decision": "Include",
        "title_abstract_exclusion_code": "",
        "title_abstract_evidence": "Field campaign; LAeq + thermal votes (Peng 2025).",
        "full_text_retrieval_status": "Local library",
        "full_text_decision": "Included",
        "full_text_primary_exclusion_code": "",
        "updated_h4_role": "Updated H4 — mixed-linear TSV~LAeq (§2)",
        "full_text_evidence": "Mixed models; Brussels thermal_comfort ~ dBA_z.",
        "decision_basis": "H4_report.md §2 [4] Peng 2025",
    },
    "LOCAL-RODRIGUES": {
        "title_abstract_decision": "Include",
        "title_abstract_exclusion_code": "",
        "title_abstract_evidence": "GPS walks; noise + skin temperature / HRV (Rodrigues 2026).",
        "full_text_retrieval_status": "Local library",
        "full_text_decision": "Included",
        "full_text_primary_exclusion_code": "",
        "updated_h4_role": "Updated H4 — noise max/sd mixed model (§2)",
        "full_text_evidence": "Participant-intercept noise block; Brussels 10 s dBA max/sd.",
        "decision_basis": "H4_report.md §2 [3] Rodrigues 2026",
    },
}

# Named in H4_report.md as out / not run — full-text Excluded with NOT_APPLICABLE or INDOOR.
EXCLUDED_NAMED: dict[str, dict] = {
    "SC-028": {
        "full_text_primary_exclusion_code": "NOT_APPLICABLE",
        "title_abstract_exclusion_code": "NOT_APPLICABLE",
        "updated_h4_role": "",
        "full_text_evidence": "Outcomes HR/EDA vs environment; not thermal comfort vs measured noise (H4_report.md).",
        "title_abstract_evidence": "Grapas Rome 2026 — not thermal-vote H4 (H4_report.md).",
    },
    "SC-102": {
        "full_text_primary_exclusion_code": "NOT_APPLICABLE",
        "title_abstract_exclusion_code": "NOT_APPLICABLE",
        "updated_h4_role": "",
        "full_text_evidence": "Restoration (ROS), not thermal discomfort vs noise (H4_report.md).",
        "title_abstract_evidence": "Gao & Zhu greenways — restoration focus (H4_report.md).",
    },
    "SC-248": {
        "full_text_primary_exclusion_code": "NOT_APPLICABLE",
        "title_abstract_exclusion_code": "NOT_APPLICABLE",
        "updated_h4_role": "",
        "full_text_evidence": "Models acoustic comfort from PET; not noise effect on thermal vote (H4_report.md).",
        "title_abstract_evidence": "Mohammadzadeh — reverse / different endpoint (H4_report.md).",
    },
    "LOCAL-GRAPASBRUSSELS": {
        "full_text_primary_exclusion_code": "NOT_APPLICABLE",
        "title_abstract_exclusion_code": "NOT_APPLICABLE",
        "updated_h4_role": "",
        "full_text_evidence": "Delay ~ exposure; not thermal discomfort vs noise (H4_report.md).",
        "title_abstract_evidence": "Grapas Brussels — wrong H4 endpoint though LAeq and UTCI measured.",
    },
    "LOCAL-CHIUCCHIU": {
        "full_text_primary_exclusion_code": "INDOOR",
        "title_abstract_exclusion_code": "INDOOR",
        "updated_h4_role": "",
        "full_text_evidence": "NEXT.ROOM indoor test room; not outdoor walking (H4_report.md).",
        "title_abstract_evidence": "Indoor chamber study (H4_report.md).",
    },
    "LOCAL-BAQUERO": {
        "full_text_primary_exclusion_code": "NOT_APPLICABLE",
        "title_abstract_exclusion_code": "NOT_APPLICABLE",
        "updated_h4_role": "",
        "full_text_evidence": "Stay / occupancy counts; not thermal comfort vs noise (H4_report.md).",
        "title_abstract_evidence": "Baquero — occupancy, not H4 discomfort test.",
    },
}

INDOOR_HINTS = (
    "indoor",
    "office building",
    "naturally ventilated",
    "open-plan office",
    "chamber",
    "test room",
    "laboratory experiment",
    "next.room",
    "living-room",
    "residential buildings",
    "vernacular dwellings",
    "traditional dwelling",
)

THERMAL_HINTS = (
    "utci",
    "pet",
    "thermal comfort",
    "thermal vote",
    "heat stress",
    "thermal perception",
    "thermal condition",
    "npet",
    "tsv",
)

SOUND_HINTS = (
    "laeq",
    "dba",
    "db(a)",
    "sound pressure",
    "sound level",
    "noise level",
    "spl",
    "acoustic environment",
    "soundscape",
    "a-weighted",
)

JOINT_THERMO_SOUND_HINTS = (
    "thermal-acoustic",
    "thermal–acoustic",
    "thermo-acoustic",
    "thermoacoustic",
    "thermal and acoustic",
    "thermal and sound",
    "combined effects",
    "interaction between thermal",
    "laeq",
    "spl",
)


def normalize_exclusion_code(code: str) -> str:
    c = (code or "").strip().upper()
    if c in ALLOWED_EXCLUSION:
        return c
    legacy = {
        "INDOOR_OR_CHAMBER": "INDOOR",
        "NO_MEASURED_SOUND": "SOUND_NOT_WITH_HEAT",
        "THERMAL_OUTCOME_UNCLEAR": "SOUND_NOT_WITH_HEAT",
        "THERMOACOUSTIC_NOT_IN_CATALOGUE": "NOT_APPLICABLE",
        "NOT_OUTDOOR_FIELD": "NOT_APPLICABLE",
        "SCOPE_NOT_H4": "NOT_APPLICABLE",
        "WRONG_OUTCOME": "NOT_APPLICABLE",
        "REVERSE_DIRECTION": "NOT_APPLICABLE",
    }
    return legacy.get(c, "NOT_APPLICABLE")


def _text(row: pd.Series) -> str:
    return f"{row.get('title', '')} {row.get('abstract', '')}".lower()


def classify_title_abstract(row: pd.Series) -> tuple[str, str, str]:
    rid = str(row["record_id"])
    if rid in INCLUDED_UPDATED:
        d = INCLUDED_UPDATED[rid]
        return (
            d["title_abstract_decision"],
            d["title_abstract_exclusion_code"],
            d["title_abstract_evidence"],
        )

    text = _text(row)

    if any(h in text for h in INDOOR_HINTS):
        return (
            "Exclude",
            "INDOOR",
            "Indoor or building-focused study; not outdoor walking H4.",
        )

    thermal = any(h in text for h in THERMAL_HINTS)
    sound = any(h in text for h in SOUND_HINTS)
    joint = any(h in text for h in JOINT_THERMO_SOUND_HINTS)

    if not thermal or not sound:
        return (
            "Exclude",
            "SOUND_NOT_WITH_HEAT",
            "Thermal comfort/heat and measured sound level not studied together in abstract.",
        )

    if not joint:
        return (
            "Exclude",
            "SOUND_NOT_WITH_HEAT",
            "Thermal and acoustic domains mentioned but not as a joint thermo-acoustic study.",
        )

    return (
        "Exclude",
        "NOT_APPLICABLE",
        "Outdoor or field thermo-acoustic scope; not retained as H4 evidence in H4_report.md.",
    )


def apply_full_text(row: pd.Series) -> pd.Series:
    rid = str(row["record_id"])

    if rid in INCLUDED_UPDATED:
        d = INCLUDED_UPDATED[rid]
        for k, v in d.items():
            row[k] = v
        row["reviewer_confirmation"] = CONFIRMED
        row["eligibility_basis_path"] = str(REPORT)
        return row

    if rid in EXCLUDED_NAMED:
        d = EXCLUDED_NAMED[rid]
        row["title_abstract_decision"] = "Exclude"
        row["full_text_retrieval_status"] = (
            "Local library" if rid.startswith("LOCAL") else "Retrieved"
        )
        row["full_text_decision"] = "Excluded"
        row["decision_basis"] = DECISION_BASIS
        for k, v in d.items():
            row[k] = v
        ta_code = normalize_exclusion_code(str(row.get("title_abstract_exclusion_code", "")))
        ft_code = normalize_exclusion_code(str(row.get("full_text_primary_exclusion_code", "")))
        row["title_abstract_exclusion_code"] = ta_code
        row["full_text_primary_exclusion_code"] = ft_code
        row["reviewer_confirmation"] = CONFIRMED
        row["eligibility_basis_path"] = str(REPORT)
        return row

    ta_dec, ta_code, ta_ev = classify_title_abstract(row)
    ta_code = normalize_exclusion_code(ta_code)
    row["title_abstract_decision"] = ta_dec
    row["title_abstract_exclusion_code"] = ta_code if ta_dec == "Exclude" else ""
    row["title_abstract_evidence"] = ta_ev

    row["full_text_retrieval_status"] = "Not retrieved"
    row["full_text_decision"] = "Excluded"
    row["full_text_primary_exclusion_code"] = ta_code
    row["updated_h4_role"] = ""
    row["full_text_evidence"] = ta_ev
    row["decision_basis"] = DECISION_BASIS
    row["reviewer_confirmation"] = CONFIRMED
    row["eligibility_basis_path"] = str(REPORT)
    return row


def main() -> None:
    if not CSV_PATH.is_file():
        raise SystemExit(f"Missing {CSV_PATH}")
    if not REPORT.is_file():
        raise SystemExit(f"Missing {REPORT}")

    df = pd.read_csv(CSV_PATH, low_memory=False)
    df = df.apply(apply_full_text, axis=1)

    for col in ("title_abstract_exclusion_code", "full_text_primary_exclusion_code"):
        if col in df.columns:
            df[col] = df[col].fillna("").map(
                lambda x: normalize_exclusion_code(x) if x else ""
            )

    bad_codes = set()
    for col in ("title_abstract_exclusion_code", "full_text_primary_exclusion_code"):
        for v in df[col].unique():
            if v and v not in ALLOWED_EXCLUSION:
                bad_codes.add(v)

    df.to_csv(CSV_PATH, index=False)
    print(f"Wrote {CSV_PATH}")
    print(f"Rows: {len(df)} | Included: {(df['full_text_decision'] == 'Included').sum()}")
    print("Exclusion codes (full text):")
    ex = df.loc[df["full_text_decision"] == "Excluded", "full_text_primary_exclusion_code"]
    print(ex.value_counts().to_string())
    if bad_codes:
        print("WARNING unexpected codes:", bad_codes)
    print("\nIncluded:")
    print(
        df.loc[df["full_text_decision"] == "Included", ["record_id", "updated_h4_role"]].to_string(
            index=False
        )
    )


if __name__ == "__main__":
    main()

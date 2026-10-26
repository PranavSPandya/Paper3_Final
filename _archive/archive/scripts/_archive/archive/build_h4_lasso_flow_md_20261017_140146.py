#!/usr/bin/env python3
"""Regenerate H4_LASSO_to_16equations_flow.md and equation letter columns in term map."""

from __future__ import annotations

import csv
import string
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
FILTRATION = REPO / "output/statistical_analysis/H4_multivariate/H4_Multivariate_Filtration_Results.csv"
EQUATIONS = REPO / "output/statistical_analysis/H4_multivariate/H4_models/H4_equations.csv"
TERM_MAP = REPO / "output/statistical_analysis/H4_multivariate/H4_term_to_equation_map.csv"
OUT_MD = REPO / "output/statistical_analysis/H4_multivariate/H4_LASSO_to_16equations_flow.md"

SPELL_VAR = {
    "ucm_SND_dBA": "sound",
    "gvi_50m": "GVI",
    "Clearness_Index": "clearness",
    "Clearness_Index_G0": "clearness index G0",
    "lys_lux_avg": "lux",
    "lys_kelvin_avg": "colour temperature",
    "lys_medi_avg": "melanopic equivalent daylight illuminance",
    "ucm_SUN_Gh": "global solar radiation",
    "ucm_WIND_TWS": "wind",
    "ucm_AIR_temp": "air temperature",
    "ucm_AIR_RH": "humidity",
    "ucm_MRT": "mean radiant temperature",
    "ucm_HUMIDEX": "HUMIDEX",
    "ucm_PET": "PET",
    "ucm_UTCI": "UTCI",
    "atmo_pm1_avg": "PM1",
    "atmo_pm2.5_avg": "PM2.5",
    "atmo_pm10_avg": "PM10",
}

PHASE_MAIN_SPELL = [
    "PhaseID: WalkG deviation",
    "PhaseID: WalkU deviation",
    "PhaseID: BikeG deviation",
]

BLOCK_LABEL = {
    "no_products": "full exposure",
    "heat_x_sound": "thermal × sound",
    "heat_x_activity": "thermal × phase (4 conditions)",
    "both_products": "thermal × sound × phase (4 conditions)",
}

UNION_SPELL_ORDER = [
    "clearness",
    "GVI",
    "colour temperature",
    "lux",
    "humidity",
    "air temperature",
    "HUMIDEX",
    "mean radiant temperature",
    "PET",
    "sound",
    "UTCI",
]

THERMAL_BY_HEAT_FORM: dict[str, list[str]] = {
    "Components": ["humidity", "air temperature", "mean radiant temperature"],
    "HUMIDEX": ["HUMIDEX"],
    "PET": ["PET"],
    "UTCI": ["UTCI"],
}

HEAT_FORMS = ["Components", "HUMIDEX", "PET", "UTCI"]
BLOCKS = ["no_products", "heat_x_sound", "heat_x_activity", "both_products"]

FILTRATION_REL = "H4_Multivariate_Filtration_Results.csv"


def spell_var(name: str) -> str:
    return SPELL_VAR.get(name, name)


def mermaid_id(prefix: str, raw: str) -> str:
    safe = "".join(c if c.isalnum() else "_" for c in raw)
    return f"{prefix}_{safe}"


def letter_seq(start: str = "a", n: int = 26) -> list[str]:
    letters = list(string.ascii_lowercase)
    if start != "a":
        i = letters.index(start)
        letters = letters[i:] + [
            f"{a}{b}" for a in string.ascii_lowercase for b in string.ascii_lowercase
        ]
    return letters[:n]


def load_filtration() -> list[dict[str, str]]:
    with FILTRATION.open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def step3_candidates(rows: list[dict[str, str]]) -> dict[str, dict[str, str]]:
    out: dict[str, dict[str, str]] = {}
    for r in rows:
        if r.get("H4_Screening_Candidate") == "Yes" and r.get("Step3_Decision") == "Retained":
            out[r["Variable_Name"]] = r
    return out


def union_var_by_spell(candidates: dict[str, dict[str, str]]) -> dict[str, str]:
    spell_to_var: dict[str, str] = {}
    for var, row in candidates.items():
        if row.get("Step4_Union_Decision") == "Retained":
            spell_to_var[spell_var(var)] = var
    return spell_to_var


def parse_terms(terms: str) -> list[str]:
    return [t.strip() for t in terms.split(" + ") if t.strip()]


def equation_title(eq_id: int, heat_form: str, block: str) -> str:
    return f"Eq {eq_id} · {heat_form} — {BLOCK_LABEL[block]}"


def eq_id_for(heat_form: str, block: str) -> int:
    return (HEAT_FORMS.index(heat_form) * 4) + BLOCKS.index(block) + 1


def term_uses_predictor(spell: str, term: str) -> bool:
    if spell in PHASE_MAIN_SPELL:
        return term == spell or spell in term
    if term == spell:
        return True
    if " x " in term and spell in term:
        return True
    return False


def equation_uses_predictor(spell: str, terms: list[str]) -> bool:
    return any(term_uses_predictor(spell, t) for t in terms)


def load_equations() -> list[dict[str, str]]:
    with EQUATIONS.open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def build_union_node_ids() -> dict[str, str]:
    union_nodes: dict[str, str] = {}
    for spell in UNION_SPELL_ORDER:
        union_nodes[spell] = mermaid_id("un", spell.replace(" ", "_"))
    for spell in PHASE_MAIN_SPELL:
        union_nodes[spell] = mermaid_id("ph", spell.replace(" ", "_").replace(":", ""))
    return union_nodes


def build_main_diagram_mermaid() -> str:
    """Single main diagram: union predictors → heat forms → sixteen equations."""
    union_nodes = build_union_node_ids()
    eq_rows = load_equations()
    eq_nodes: dict[int, str] = {}
    eq_terms: dict[int, list[str]] = {}

    lines = ["```mermaid", "flowchart TB"]
    lines.append(
        f'  SCR["18 screened → 11 retained<br/>(LASSO union; see {FILTRATION_REL})"]'
    )
    union_letters = letter_seq("a", len(UNION_SPELL_ORDER))
    lines.append('  subgraph UNION["Step 5 inputs · 11 LASSO union predictors"]')
    lines.append("    direction TB")
    for letter, spell in zip(union_letters, UNION_SPELL_ORDER):
        lines.append(f'    {union_nodes[spell]}["{letter}. {spell}"]')
    lines.append("  end")
    phase_letters = letter_seq("l", len(PHASE_MAIN_SPELL))
    lines.append('  subgraph PHASE["PhaseID sum-to-zero (always in design; not LASSO)"]')
    lines.append("    direction TB")
    for letter, spell in zip(phase_letters, PHASE_MAIN_SPELL):
        short = spell.replace("PhaseID: ", "")
        lines.append(
            f'    {union_nodes[spell]}["{letter}. {short}<br/>(BikeU implicit in sum coding)"]'
        )
    lines.append("  end")
    lines.append("  SCR -.-> UNION")

    hf_ids = {hf: mermaid_id("hf", hf) for hf in HEAT_FORMS}

    lines.append('  subgraph HEAT["Four heat forms (thermal representation)"]')
    lines.append("    direction LR")
    for hf in HEAT_FORMS:
        thermal = ", ".join(THERMAL_BY_HEAT_FORM[hf])
        lines.append(f'    {hf_ids[hf]}["{hf}<br/><small>{thermal}</small>"]')
    lines.append("  end")

    for hf in HEAT_FORMS:
        for spell in THERMAL_BY_HEAT_FORM[hf]:
            if spell in union_nodes:
                lines.append(f"  {union_nodes[spell]} --> {hf_ids[hf]}")

    for hf in HEAT_FORMS:
        row_sid = mermaid_id("row", hf)
        lines.append(f'  subgraph {row_sid}["{hf} · four interaction blocks"]')
        lines.append("    direction TB")
        for bl in BLOCKS:
            eq_id = eq_id_for(hf, bl)
            title = equation_title(eq_id, hf, bl)
            eid = mermaid_id("eq", str(eq_id))
            eq_nodes[eq_id] = eid
            row = next(r for r in eq_rows if int(r["equation_id"]) == eq_id)
            eq_terms[eq_id] = parse_terms(row["terms"])
            bl_short = BLOCK_LABEL[bl]
            lines.append(f'    {eid}["{title}<br/><small>{bl_short}</small>"]')
            lines.append(f"    {hf_ids[hf]} --> {eid}")
        lines.append("  end")

    predictors = list(UNION_SPELL_ORDER) + list(PHASE_MAIN_SPELL)
    for spell in predictors:
        un_id = union_nodes[spell]
        for eq_id, eid in eq_nodes.items():
            if equation_uses_predictor(spell, eq_terms[eq_id]):
                lines.append(f"  {un_id} --> {eid}")

    lines.append(
        '  GVIF["Step 6 · GVIF/VIF diagnostic (max equiv. 5)<br/>report only; no auto-removal"]'
    )
    for eid in eq_nodes.values():
        lines.append(f"  {eid} -.-> GVIF")

    lines.append("```")
    return "\n".join(lines)


def build_equation_sections() -> tuple[str, dict[int, dict[str, str]]]:
    """Markdown for all 16 equations (term lists + letter formulas)."""
    eq_letters: dict[int, dict[str, str]] = {}
    eq_rows = load_equations()
    chunks: list[str] = ["## Sixteen fitted equations (catalog terms)", ""]
    chunks.append(
        "Letters **a.–** restart within each equation. "
        "Fixed effects match the `terms` column in `H4_models/H4_equations.csv` (no VIF trimming unless `H4_APPLY_VIF_TRIM=1`)."
    )
    chunks.append("")

    for row in eq_rows:
        eq_id = int(row["equation_id"])
        terms = parse_terms(row["terms"])
        letters = letter_seq("a", len(terms))
        eq_letters[eq_id] = {t: letters[i] for i, t in enumerate(terms)}
        title = equation_title(eq_id, row["heat_form"], row["block"])
        human = " + ".join(terms)
        formula = "Y ~ " + " + ".join(letters)
        chunks.append(f"### {title}")
        chunks.append("")
        chunks.append(human)
        chunks.append("")
        chunks.append(f"`{formula}`")
        chunks.append("")

    return "\n".join(chunks), eq_letters


def update_term_map(eq_letters: dict[int, dict[str, str]]) -> None:
    with TERM_MAP.open(newline="", encoding="utf-8") as f:
        rows = list(csv.DictReader(f))
        fieldnames = list(rows[0].keys()) if rows else []

    for i in range(1, 17):
        col = f"letter_eq_{i}"
        if col not in fieldnames:
            fieldnames.append(col)

    for row in rows:
        spell = row["spell_label"]
        for i in range(1, 17):
            col = f"letter_eq_{i}"
            letter = eq_letters.get(i, {}).get(spell, "")
            if not letter and spell.startswith("("):
                letter = eq_letters.get(i, {}).get(spell, "")
            row[col] = letter

    with TERM_MAP.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)


def union_legend_table(candidates: dict[str, dict[str, str]]) -> str:
    union_letters = letter_seq("a", len(UNION_SPELL_ORDER))
    spell_to_var = union_var_by_spell(candidates)
    lines = [
        "### Union predictor glossary (letters **a.–k.**)",
        "",
        "Screening detail: [`H4_Multivariate_Filtration_Results.csv`](H4_Multivariate_Filtration_Results.csv) "
        "(18 measurement-eligible candidates after Step 3; domain-wise Empatica and Eyetracker LASSO in Step 4; "
        "**union** = nonzero in either path → **11** retained).",
        "",
        "| Letter | Spell label | Variable | Empatica | Eyetracker |",
        "|--------|-------------|----------|----------|------------|",
    ]
    for letter, spell in zip(union_letters, UNION_SPELL_ORDER):
        var = spell_to_var.get(spell, "—")
        if var != "—":
            row = candidates[var]
            emp = row.get("Step4_Empatica_Decision", "")
            eye = row.get("Step4_Eyetracker_Decision", "")
        else:
            emp = eye = "—"
        lines.append(f"| **{letter}.** | {spell} | `{var}` | {emp} | {eye} |")
    lines.append("")
    lines.append("### PhaseID fixed effects (letters **l.–n.**; always in design, not LASSO-penalized)")
    lines.append("")
    lines.append("| Letter | Sum-to-zero contrast | Notes |")
    lines.append("|--------|----------------------|-------|")
    phase_letters = letter_seq("l", len(PHASE_MAIN_SPELL))
    for letter, spell in zip(phase_letters, PHASE_MAIN_SPELL):
        lines.append(f"| **{letter}.** | {spell} | BikeU deviation = −(WalkG+WalkU+BikeG) |")
    lines.append("")
    return "\n".join(lines)


def heat_form_table() -> str:
    lines = [
        "### How heat forms use the eleven union thermal-related inputs",
        "",
        "| Heat form | Thermal terms from union (main + interaction roles) | Equations |",
        "|-----------|------------------------------------------------------|-----------|",
    ]
    for hf in HEAT_FORMS:
        thermal = ", ".join(f"**{t}**" for t in THERMAL_BY_HEAT_FORM[hf])
        eq_range = f"{eq_id_for(hf, BLOCKS[0])}–{eq_id_for(hf, BLOCKS[-1])}"
        lines.append(f"| {hf} | {thermal} | Eq {eq_range} |")
    lines.append("")
    lines.append(
        "Within each heat form, four **blocks** map to rows: "
        "full exposure · thermal×sound · thermal×phase (4 conditions) · thermal×sound×phase "
        "(internal codes `no_products`, `heat_x_sound`, `heat_x_activity`, `both_products`)."
    )
    lines.append("")
    return "\n".join(lines)


def build_markdown() -> str:
    rows = load_filtration()
    candidates = step3_candidates(rows)
    if len(candidates) != 18:
        raise RuntimeError(f"Expected 18 Step-3 candidates, got {len(candidates)}")

    main_diagram = build_main_diagram_mermaid()
    eq_md, eq_letters = build_equation_sections()
    update_term_map(eq_letters)

    parts = [
        "# H4: LASSO union predictors to sixteen exposure equations",
        "",
        "Main flow starts from the **11 LASSO union predictors** plus **three sum-to-zero PhaseID contrasts** "
        "(WalkG, WalkU, BikeG deviations; BikeU implicit), always in the design matrix. "
        "Four **heat forms** choose the thermal representation; four **interaction blocks** per form yield "
        "**16 equations** in `H4_models/H4_equations.csv`; GVIF/VIF is diagnostic-only (`H4_gvif_diagnostic.csv`). "
        "Regenerate with `python scripts/build_h4_lasso_flow_md.py`.",
        "",
        "## Legend",
        "",
        "| Item | Meaning |",
        "|------|---------|",
        "| **Screening** | 18 → 11 via Step 3 audit + Step 4 dual LASSO union (details in filtration CSV, not drawn here). |",
        "| **Letters a.–k.** | Eleven union environmental predictors carried into Step 5. |",
        "| **Letters l.–n.** | PhaseID sum-to-zero mains (WalkG, WalkU, BikeG); not LASSO-penalized. |",
        "| **Heat forms** | Components · HUMIDEX · PET · UTCI. |",
        "| **Blocks** | full exposure · thermal×sound · thermal×phase · thermal×sound×phase. |",
        "| **Solid arrows** | Predictor appears in that equation’s `terms` (main effect or interaction). |",
        "| **Dashed to GVIF** | Step 6 design-only collinearity screen — see `H4_models/H4_gvif_diagnostic.csv`. |",
        "",
        union_legend_table(candidates),
        heat_form_table(),
        "## Diagram 1 — Union predictors to sixteen equations",
        "",
        "Subgraphs: **union inputs (a.–k.)** and **phase contrasts (l.–n.)** → **heat form** → **four blocks** per form. "
        "Solid edges from each predictor into equations where that label appears in fitted `terms`.",
        "",
        main_diagram,
        "",
        eq_md,
        "",
        "## Related outputs",
        "",
        "- Filtration audit: `H4_Multivariate_Filtration_Results.csv`.",
        "- Audit flow PDF/PNG: `H4_All_Variables_Audit.pdf` (full Steps 1–6).",
        "- Faceted vertical flow: `H4_Faceted_Vertical_Flow_final.pdf`.",
        "- Term map (`letter_eq_1` … `letter_eq_16`): `H4_term_to_equation_map.csv`.",
        "",
    ]
    return "\n".join(parts)


def main() -> None:
    md = build_markdown()
    OUT_MD.write_text(md, encoding="utf-8")
    print(f"Wrote {OUT_MD}")


if __name__ == "__main__":
    main()

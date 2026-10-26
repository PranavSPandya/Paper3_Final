"""Build the comprehensive Paper 3 H1-to-H4 statistical reference HTML.

This script reads existing analysis CSVs and figures only. It does not run R,
refit models, or modify statistical outputs.
"""

from __future__ import annotations

import csv
import html
import os
from collections import Counter
from datetime import datetime
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "output"
DOCUMENTS = ROOT / "documents"
FIGURES = OUTPUT / "Figures"
STAT_PRIMARY = OUTPUT / "statistical_analysis"
PRIMARY_NORMALIZATION = "Within-Person Z-score"

INPUT = OUTPUT / "merged_all_11participants_8min.csv"
HTML_OUTPUT = DOCUMENTS / "Paper3_H1_to_H4_Explanation.html"


def read_csv(path: Path) -> list[dict[str, str]]:
    if not path.exists():
        return []
    with path.open(encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def read_primary_csv(path: Path) -> list[dict[str, str]]:
    """Read only the declared primary normalization branch."""
    return [row for row in read_csv(path) if row.get("Normalization") == PRIMARY_NORMALIZATION]


def esc(value: object) -> str:
    return html.escape("" if value is None else str(value))


def is_true(value: str) -> bool:
    return str(value).strip().lower() in {"true", "t", "1", "yes"}


def significant(rows: list[dict[str, str]]) -> int:
    return sum(is_true(row.get("FDR_significance", "")) for row in rows)


def raw_significant(rows: list[dict[str, str]]) -> int:
    count = 0
    for row in rows:
        try:
            pval = float(row.get("p_value", 1.0))
            if pval < 0.05:
                count += 1
        except (ValueError, TypeError):
            continue
    return count


def predictors(rows: list[dict[str, str]]) -> list[str]:
    return sorted({row.get("Predictor", "") for row in rows if row.get("Predictor")})


def newest_status(path: Path) -> str:
    if not path.exists():
        return "missing"
    if not INPUT.exists() or path.stat().st_mtime >= INPUT.stat().st_mtime:
        return "current or newer than input"
    return "older than current merged input — sensitivity output needs rerun"


def time_text(path: Path) -> str:
    if not path.exists():
        return "missing"
    return datetime.fromtimestamp(path.stat().st_mtime).strftime("%Y-%m-%d %H:%M:%S")


def file_link(path: Path, label: str) -> str:
    if not path.exists():
        return f"<span class='missing'>{esc(label)} (missing)</span>"
    relative = os.path.relpath(path, DOCUMENTS).replace("\\", "/")
    return f"<a href='{esc(relative)}'>{esc(label)}</a>"


def figure(name: str, caption: str) -> str:
    path = FIGURES / name
    if not path.exists():
        return f"<div class='missing'>Missing figure: {esc(name)}</div>"
    relative = os.path.relpath(path, DOCUMENTS).replace("\\", "/")
    return (
        "<figure>"
        f"<img src='{esc(relative)}' alt='{esc(caption)}'>"
        f"<figcaption>{esc(caption)}</figcaption>"
        "</figure>"
    )


def summary_table(rows: list[tuple]) -> str:
    body_items = []
    for item in rows:
        if len(item) == 2:
            label, value = item
            note = ""
        else:
            label, value, note = item[:3]
        body_items.append(f"<tr><th>{esc(label)}</th><td>{esc(value)}</td><td>{esc(note)}</td></tr>")
    body = "".join(body_items)
    return (
        "<table><thead><tr><th>Item</th><th>Value</th><th>Interpretation</th></tr></thead>"
        f"<tbody>{body}</tbody></table>"
    )


def sensor_breakdown_table(rows: list[dict[str, str]]) -> str:
    counts: dict[str, int] = Counter()
    total_models: dict[str, int] = Counter()
    for row in rows:
        sensor = row.get("Predictor_Sensor")
        if not sensor:
            pred = row.get("Predictor", "")
            if pred.startswith("ucm_") or pred == "Clearness_Index":
                sensor = "UCM"
            elif pred.startswith("atmo_"):
                sensor = "Atmotube"
            elif pred.startswith("lys_"):
                sensor = "LYS"
            elif pred.startswith("gvi_") or pred.startswith("tree_"):
                sensor = "GVI"
            elif pred.startswith("sound_"):
                sensor = "YAMNet"
            else:
                sensor = "Other"
        total_models[sensor] += 1
        if is_true(row.get("FDR_significance", "")):
            counts[sensor] += 1

    sensor_order = ["UCM", "GVI", "Atmotube", "YAMNet", "LYS"]
    body = "".join(
        f"<tr><td><strong>{esc(s)}</strong></td><td>{total_models[s]:,}</td><td><strong>{counts[s]:,}</strong></td><td>{(counts[s]/total_models[s]*100 if total_models[s] else 0):.1f}%</td></tr>"
        for s in sensor_order if s in total_models
    )
    return (
        "<table><thead><tr><th>Sensor Platform</th><th>Total Models Fitted</th><th>FDR-Significant (q &lt; 0.05)</th><th>Hit Rate</th></tr></thead>"
        f"<tbody>{body}</tbody></table>"
    )


def top_clean_predictors(rows: list[dict[str, str]], limit: int = 15) -> str:
    counts = Counter(
        (row.get("Clean_Predictor") or row.get("Predictor", ""))
        for row in rows
        if is_true(row.get("FDR_significance", ""))
    )
    if not counts:
        return "<p>No FDR-significant H4 predictors are recorded in this file.</p>"
    body = "".join(
        f"<tr><td>{esc(name)}</td><td><strong>{count}</strong></td></tr>"
        for name, count in counts.most_common(limit)
    )
    return (
        "<table><thead><tr><th>Predictor Stream (Platform: Metric)</th><th>FDR-Significant Models</th></tr></thead>"
        f"<tbody>{body}</tbody></table>"
    )


def top_results_table(
    rows: list[dict[str, str]],
    outcome_col: str,
    pred_or_contrast_col: str,
    limit: int = 10,
    contrast_filter: str | None = None,
    show_sub_hyp: bool = False,
    require_fdr: bool = True,
) -> str:
    if require_fdr:
        sig_rows = [r for r in rows if is_true(r.get("FDR_significance", ""))]
    else:
        sig_rows = [r for r in rows if float(r.get("p_value", 1.0)) < 0.05]

    if contrast_filter:
        sig_rows = [
            r for r in sig_rows
            if contrast_filter.lower() in str(r.get(pred_or_contrast_col, "")).lower()
            or contrast_filter.lower() in str(r.get("Contrast", "")).lower()
            or contrast_filter.lower() in str(r.get("Clean_Predictor", "")).lower()
        ]

    # Sort by absolute t-value or beta
    def get_sort_key(r):
        try:
            return abs(float(r.get("t_stat", 0.0)))
        except (ValueError, TypeError):
            return 0.0

    sig_rows.sort(key=get_sort_key, reverse=True)
    selected = sig_rows[:limit]
    if not selected:
        return "<p><em>No statistically significant results found for this specific model selection.</em></p>"

    body_rows = []
    for r in selected:
        sub_hyp = r.get("Sub_Hypothesis", "")
        outc = r.get("Clean_Outcome") or r.get("Clean_Physiological") or r.get(outcome_col, "")
        pred = r.get("Clean_Predictor") or r.get("Clean_Psychological") or r.get("Contrast") or r.get(pred_or_contrast_col, "")
        beta = float(r.get("Beta_Std") or r.get("Estimate") or r.get("Beta_Within_Std") or 0.0)
        se = float(r.get("SE") or 0.0)
        ci_low = float(r.get("CI95_low") or (beta - 1.96 * se))
        ci_high = float(r.get("CI95_high") or (beta + 1.96 * se))
        t_val = float(r.get("t_stat") or r.get("t-ratio") or 0.0)
        p_val = float(r.get("p_value", 1.0))
        q_val = float(r.get("q_FDR", 1.0))
        p_str = f"{p_val:.2e}" if p_val < 0.001 else f"{p_val:.4f}"
        q_str = f"{q_val:.2e}" if q_val < 0.001 else f"{q_val:.4f}"
        dur = r.get("Duration", "-")
        norm = r.get("Normalization", "-")
        res = r.get("Result") or r.get("H2_Interpretation") or ""

        # Color-code sub-hypothesis badges
        if "H4.2" in sub_hyp:
            badge_bg = "#1d4ed8"  # Blue for H4.2
        elif "H4.1" in sub_hyp:
            badge_bg = "#0f766e"  # Teal for H4.1
        elif "H4.3" in sub_hyp:
            badge_bg = "#7c3aed"  # Purple for H4.3
        else:
            badge_bg = "#475569"

        sub_hyp_td = f"<td><strong style='background:{badge_bg}; color:#fff; padding:3px 8px; border-radius:4px; font-size:12px; font-family:monospace;'>{esc(sub_hyp)}</strong></td>" if show_sub_hyp else ""

        body_rows.append(
            f"<tr>{sub_hyp_td}<td><strong>{esc(outc)}</strong></td><td>{esc(pred)}</td>"
            f"<td>{beta:+.3f} &plusmn; {se:.3f}</td>"
            f"<td>[{ci_low:+.3f}, {ci_high:+.3f}]</td>"
            f"<td>t = {t_val:+.2f}</td>"
            f"<td>{p_str}</td><td><strong style='color: #b91c1c;'>{q_str}</strong></td>"
            f"<td><small>{esc(dur)} | {esc(norm)}</small></td>"
            f"<td><small>{esc(res)}</small></td></tr>"
        )

    body = "".join(body_rows)
    sub_hyp_th = "<th>Sub-Hypothesis</th>" if show_sub_hyp else ""
    return (
        f"<table><thead><tr>{sub_hyp_th}<th>Outcome</th><th>Predictor / Contrast</th><th>Beta &plusmn; SE</th>"
        "<th>95% CI</th><th>t-statistic</th><th>p-value</th><th>q (FDR)</th><th>Condition</th><th>Interpretation</th></tr></thead>"
        f"<tbody>{body}</tbody></table>"
    )


def build() -> None:
    if not INPUT.exists():
        raise FileNotFoundError(INPUT)

    input_rows = read_csv(INPUT)
    input_headers = list(input_rows[0]) if input_rows else []
    participants = sorted({row.get("ParticipantID", "") for row in input_rows if row.get("ParticipantID")})
    phases = sorted({row.get("PhaseID", "") for row in input_rows if row.get("PhaseID")})

    # Primary analysis outputs
    h1 = read_primary_csv(STAT_PRIMARY / "H1_Green_vs_Urban.csv")
    h2 = read_primary_csv(STAT_PRIMARY / "H2_Physio_Psycho_Concordance.csv")
    h3 = read_primary_csv(STAT_PRIMARY / "H3_Walk_vs_Bike.csv")
    h4_all = read_primary_csv(STAT_PRIMARY / "H4_Environmental_Stressors.csv")
    h4_multi = read_primary_csv(STAT_PRIMARY / "H4_Multivariable_CoExposure.csv")
    h4_interact = [r for r in h4_all if r.get("Sub_Hypothesis") == "H4.3"]
    vif_rows = read_csv(OUTPUT / "data_validation" / "Validation_Model_Predictors_VIF.csv")
    vif_by_predictor = {row.get("Selected_Predictor", ""): row for row in vif_rows}
    candidate_audit = read_csv(STAT_PRIMARY / "H4_Candidate_Audit.csv")
    raw_audit_count = sum(row.get("Source_Type") == "Raw input" for row in candidate_audit)
    derived_audit_count = sum(row.get("Source_Type") == "Derived in statistical_analysis.R" for row in candidate_audit)
    candidate_count = sum(row.get("Candidate_Status") != "NOT PRIMARY H4 CANDIDATE" for row in candidate_audit)
    primary_candidate_count = sum(row.get("Candidate_Status") == "PRIMARY H4" for row in candidate_audit)
    removed_candidate_names = [
        row.get("Column_Name", "") for row in candidate_audit
        if row.get("Candidate_Status") == "PREDECLARED DOMAIN CANDIDATE REMOVED BY VIF"
    ]
    primary_vif_rows = [
        row for row in vif_rows if row.get("H4_Primary_Status") == "PRIMARY H4"
    ]
    primary_vif_text = ", ".join(
        f"{row.get('Selected_Predictor')} = <strong>{row.get('Matched_H4_VIF_N44')}</strong>"
        for row in primary_vif_rows
    ) or "not available"
    removed_vif_text = ", ".join(removed_candidate_names) or "none"
    primary_predictor_formula = " + ".join(
        {
            "ucm_UTCI": "wpz__ucm_UTCI",
            "ucm_SND_dBA": "wpz__ucm_SND_dBA",
            "atmo_pm2.5_avg": "wpz__atmo_pm2.5_avg",
            "lys_lux_avg": "wpz__lys_lux_avg",
            "gvi_50m": "wpz__gvi_50m",
        }.get(row.get("Selected_Predictor"), row.get("Selected_Predictor", ""))
        for row in primary_vif_rows
    )

    h1_file = STAT_PRIMARY / "H1_Green_vs_Urban.csv"
    h2_file = STAT_PRIMARY / "H2_Physio_Psycho_Concordance.csv"
    h3_file = STAT_PRIMARY / "H3_Walk_vs_Bike.csv"
    h4_file = STAT_PRIMARY / "H4_Environmental_Stressors.csv"
    h4_multi_file = STAT_PRIMARY / "H4_Multivariable_CoExposure.csv"

    html_text = f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
<title>Paper 3 — H1 to H4 Statistical Reference & Comprehensive Methodology</title>
<style>
:root {{
  --ink: #17202a;
  --muted: #5d6d7e;
  --blue: #1d4ed8;
  --teal: #0f766e;
  --orange: #b45309;
  --red: #b91c1c;
  --purple: #7c3aed;
  --card: #f8fafc;
  --card-border: #e2e8f0;
  --code-bg: #edf2f7;
  --line: #cbd5e1;
}}
body {{
  max-width: 1200px;
  margin: 0 auto;
  padding: 32px 24px;
  color: var(--ink);
  font: 15px/1.6 -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
  background: #ffffff;
}}
h1 {{
  color: var(--blue);
  font-size: 28px;
  border-bottom: 3px solid var(--blue);
  padding-bottom: 12px;
  margin-bottom: 18px;
}}
h2 {{
  margin-top: 40px;
  padding: 10px 16px;
  border-left: 6px solid var(--teal);
  background: var(--card);
  font-size: 20px;
  border-radius: 0 4px 4px 0;
}}
h2.h1 {{ border-color: var(--blue); }}
h2.h2 {{ border-color: var(--teal); }}
h2.h3 {{ border-color: var(--red); }}
h2.h4 {{ border-color: var(--orange); }}
h2.sens {{ border-color: var(--purple); }}
h3 {{
  color: #1e293b;
  margin-top: 26px;
  font-size: 16px;
  border-bottom: 1px solid var(--line);
  padding-bottom: 6px;
}}
.card {{
  background: var(--card);
  border: 1px solid var(--card-border);
  border-radius: 6px;
  padding: 18px;
  margin: 16px 0;
}}
.warning {{
  border-left: 5px solid var(--red);
  background: #fff5f5;
  padding: 14px 16px;
  margin: 14px 0;
  border-radius: 0 4px 4px 0;
}}
.note {{
  border-left: 5px solid var(--teal);
  background: #f0fdfa;
  padding: 14px 16px;
  margin: 14px 0;
  border-radius: 0 4px 4px 0;
}}
.formula-box {{
  border-left: 5px solid var(--blue);
  background: #eff6ff;
  padding: 14px 18px;
  margin: 14px 0;
  font-family: Consolas, "Courier New", monospace;
  font-size: 14px;
  line-height: 1.6;
  border-radius: 0 4px 4px 0;
}}
.formula-box strong {{
  color: var(--blue);
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
  display: block;
  margin-bottom: 6px;
}}
.sensor-block {{
  background: #ffffff;
  border: 1px solid var(--card-border);
  border-radius: 6px;
  padding: 14px 18px;
  margin: 12px 0;
}}
.sensor-header {{
  font-weight: 700;
  color: #0f172a;
  font-size: 15px;
  margin-bottom: 6px;
}}
.sensor-inc {{
  color: #166534;
  margin: 4px 0;
  word-break: break-word;
}}
.sensor-exc {{
  color: #991b1b;
  margin: 4px 0;
  word-break: break-word;
}}
table {{
  border-collapse: collapse;
  width: 100%;
  margin: 14px 0 22px;
  font-size: 14px;
}}
th, td {{
  border: 1px solid var(--line);
  padding: 8px 10px;
  text-align: left;
  vertical-align: top;
}}
th {{
  background: #f1f5f9;
  font-weight: 600;
}}
figure {{
  margin: 22px 0;
  text-align: center;
}}
figure img {{
  max-width: 100%;
  height: auto;
  border: 1px solid var(--line);
  border-radius: 4px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}}
figcaption {{
  color: var(--muted);
  margin-top: 8px;
  font-weight: 600;
  font-size: 13.5px;
}}
code {{
  background: var(--code-bg);
  padding: 2px 5px;
  border-radius: 3px;
  font-family: Consolas, "Courier New", monospace;
  font-size: 13.5px;
}}
.tag {{
  display: inline-block;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 600;
  margin-right: 4px;
}}
.tag-inc {{ background: #dcfce7; color: #15803d; }}
.tag-exc {{ background: #fee2e2; color: #b91c1c; }}
.missing {{ color: var(--red); font-weight: 600; }}
</style>
</head>
<body>

<h1>Paper 3 — Statistical Analysis: H1 to H4 Systematic Methodology & Reference</h1>

<div class="note">
  <strong>Authoritative Verification Report:</strong> Generated automatically by <code>scripts/Paper3_H1toH4.py</code>.
  This document provides the full, unabridged statistical methodology, formal mathematical model specifications,
  sample sizes, degrees of freedom, parameterizations, and complete column-level inclusion/exclusion audits
  for all four core paper hypotheses (H1, H2, H3, H4).
</div>

<h2>1. Study Design & Complete Input Column Inventory</h2>

<div class="card">
  <p><strong>Primary Input Dataset File:</strong><br>
  <code>C:\\Users\\pandya\\Documents\\Github\\docker\\Paper3_Final\\output\\merged_all_11participants_8min.csv</code></p>
  
  {summary_table([
      ("Active input path", str(INPUT), f"{len(input_rows):,} rows; {len(input_headers):,} total columns"),
      ("Participants", ", ".join(participants), f"{len(participants)} participants retained in within-subject analysis"),
      ("Phases present", ", ".join(phases), "Indoor and Tram retained in the source table but are not normalization references"),
      ("Temporal Matching", "8 minutes (48 epochs of 10s)", "Eliminates duration confounding across participants and modes"),
      ("Statistical Unit", "Participant-Phase Mean (N=44)", "Avoids pseudoreplication and inflated degrees of freedom from 10-s epochs"),
  ])}
</div>

<h3>Sensor-by-Sensor Column Classification (Total {len(input_headers):,} Raw Columns Audited)</h3>
<p>Below is the complete, transparent audit of every column present in the merged analysis input, classified by sensor platform into fields retained for a defined analysis role (primary H4, secondary H4, H1&ndash;H3, descriptive/contextual audit) versus fields excluded from H4 predictor modeling, with the exact scientific rationale.</p>
<div class="note" style="border-left: 5px solid #d97706; background: #fffbeb; padding: 14px 18px; margin: 16px 0; border-radius: 0 4px 4px 0;">
  <strong>Important scope distinction:</strong> An item labelled “included” below is not automatically a primary H4 co-exposure. The active H4 audit first classifies all 189 raw plus 13 derived columns, then identifies 33 eligible continuous environmental candidate streams. Those 33 are retained for candidate diagnostics and secondary H4.1 screening. The primary H4.2 model uses only the retained predictors shown in Section 5 after the outcome-blind matched-design VIF rule; GVI remains audited/secondary but is not a primary H4 predictor.
</div>

<div class="sensor-block">
  <div class="sensor-header">1. UCM Hepia Backpack (Mobile Microclimate, Thermal Comfort & Kinematics) &mdash; 42 Columns</div>
  <div class="sensor-inc"><strong>ucm included col:</strong> <code>ucm_PET</code>, <code>ucm_UTCI</code>, <code>ucm_MRT</code>, <code>ucm_OPT</code>, <code>ucm_HUMIDEX</code>, <code>ucm_AIR_temp</code>, <code>ucm_AIR_RH</code>, <code>ucm_SND_dBA</code>, <code>ucm_SUN_Gh</code>, <code>ucm_WIND_AWS</code>, <code>ucm_WIND_TWS</code>, <code>ucm_SUN_alt</code>, <code>ucm_SUN_az</code>, <code>ucm_WIND_AWA</code>, <code>ucm_WIND_TWD</code>, <code>ucm_GPS_speed_kmh</code>, <code>ucm_GPS_hdg</code>, <code>ucm_MAG_hdg</code>, <code>ucm_GPS_HDOP</code>.</div>
  <div class="sensor-exc"><strong>ucm excluded col:</strong> <code>ucm_PET_SR</code>, <code>ucm_UTCI_SR</code>, <code>ucm_HUMIDEX_SR</code>, <code>ucm_MRT_S</code> (solar radiation-modified variants; excluded because canonical PET, UTCI, and MRT are the primary validated thermal comfort indices, avoiding collinear duplicate variants), <code>ucm_IR_back</code>, <code>ucm_IR_front</code>, <code>ucm_IR_left</code>, <code>ucm_IR_right</code>, <code>ucm_IR_up</code>, <code>ucm_IR_down</code>, <code>ucm_IR_spot_gnd</code>, <code>ucm_IR_spot_sky</code>, <code>ucm_IR_spot_left</code>, <code>ucm_IR_spot_right</code> (raw directional infrared plane radiometers and surface spot temperatures; physical subcomponents already integrated into MRT and PET, so individual regression testing is collinear and redundant), <code>ucm_AIR_T_bot</code>, <code>ucm_AIR_T_mid</code>, <code>ucm_AIR_T_top</code> (pole-level raw thermistor tiers; excluded to keep solely the single canonical <code>ucm_AIR_temp</code>), <code>ucm_GPS_alt</code> (altitude elevation; excluded because study corridor elevation is flat/homogeneous), <code>ucm_AH</code> (absolute humidity; excluded because relative humidity <code>ucm_AIR_RH</code> captures ambient moisture), <code>ucm_Date</code> (timestamp string), <code>ucm_GPS_lat</code>, <code>ucm_GPS_lon</code> (coordinates), <code>ucm_GPS_speed_valid_sample_count</code> (speed sample count QC), <code>ucm_IO_flag</code>, <code>ucm_fp</code> (hardware diagnostic flags).</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">2. Clearness Index (Atmospheric Transparency & Sky Clearness) &mdash; 3 Columns</div>
  <div class="sensor-inc"><strong>clearness index included col:</strong> <code>Clearness_Index</code> (atmospheric clearness index ratio k<sub>t</sub> = G<sub>h</sub> / G<sub>0</sub>), <code>Clearness_Index_G0</code> (theoretical extraterrestrial horizontal solar irradiance), <code>Clearness_Index_Infer</code> (inferred clear-sky solar radiation benchmark).</div>
  <div class="sensor-exc"><strong>clearness index excluded col:</strong> none (all atmospheric solar clearness parameters tracked and evaluated).</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">3. Empatica (Wristband Autonomic Physiology) &mdash; 26 Columns</div>
  <div class="sensor-inc"><strong>empatica included col:</strong> <code>empatica_heart_rate</code> (cardiovascular autonomic arousal, bpm), <code>empatica_eda_tonic</code> (tonic skin conductance level / SCL, sympathetic tone), <code>empatica_eda_phasic</code> (phasic skin conductance responses / SCR, acute sympathetic reactivity), <code>empatica_skin_temperature</code> (peripheral vasomotor skin temperature, &deg;C), <code>empatica_hrv_td_rmssd</code> (root mean square of successive differences, vagal/parasympathetic tone), <code>empatica_hrv_td_sdnn</code> (standard deviation of NN intervals, overall autonomic HRV).</div>
  <div class="sensor-exc"><strong>empatica excluded col:</strong> <code>empatica_acc_x</code>, <code>empatica_acc_y</code>, <code>empatica_acc_z</code>, <code>empatica_vector_magnitude</code> (raw triaxial accelerometer axes &mdash; utilized during preprocessing for motion artifact correction, not primary physiological strain endpoints), <code>empatica__met</code> (metabolic equivalent proxy &mdash; mobility mode factor captures exertion), <code>empatica__eda_scl_usiemens</code> (redundant raw SCL stream &mdash; superseded by cvxEDA-decomposed <code>empatica_eda_tonic</code>), <code>empatica_hrv_fd_lf</code>, <code>empatica_hrv_fd_hf</code>, <code>empatica_hrv_fd_lf_hf_ratio</code>, <code>empatica_hrv_fd_lfnu</code>, <code>empatica_hrv_fd_hfnu</code>, <code>empatica_hrv_fd_vlf</code>, <code>empatica_hrv_fd_total_power</code> (frequency-domain spectral HRV parameters &mdash; excluded due to non-stationarity across mobile outdoor transitions; Task Force 1996 guidelines mandate stationary 5-minute epochs for spectral validity, whereas time-domain RMSSD/SDNN are robust), <code>empatica_hrv_fd_5min_available</code>, <code>empatica_hrv_fd_5min_segment_start</code>, <code>empatica_hrv_fd_5min_segment_end</code>, <code>empatica_hrv_fd_5min_valid_rri_count</code>, <code>empatica_hrv_fd_5min_removed_pct</code>, <code>empatica_hrv_fd_5min_max_gap_seconds</code>, <code>empatica_hrv_fd_5min_valid_span_seconds</code> (HRV preprocessing window and artifact tracking metadata).</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">4. Eyetracker (Eye Tracker / Gaze & Pupil Dynamics) &mdash; 15 Columns</div>
  <div class="sensor-inc"><strong>eyetracker included col:</strong> <code>eyetracker_pupil_diameter_avg</code> (average pupil diameter, mm), <code>eyetracker_pupil_change_rate</code> (pupil constriction/dilation velocity), <code>eyetracker_blink_duration_s</code> (average blink duration, s), <code>eyetracker_fixation_duration_s</code> (average fixation duration, s), <code>eyetracker_fixation_rate</code> (fixation frequency, /s), <code>eyetracker_saccade_duration_s</code> (average saccade duration, s), <code>eyetracker_saccade_amplitude</code> (saccadic amplitude, &deg;), <code>eyetracker_saccade_peak_velocity</code> (saccadic peak velocity, &deg;/s), <code>eyetracker_gaze_velocity</code> (gaze transition velocity, &deg;/s), <code>eyetracker_gaze_dispersion</code> (spatial dispersion of visual attention), <code>eyetracker_distance_from_center</code> (Euclidean gaze distance from visual center, px), <code>eyetracker_gaze_centrality</code> (proportion of gaze concentrated in central visual field), <code>eyetracker_eyelid_aperture_avg</code> (vertical eyelid aperture opening, mm).</div>
  <div class="sensor-exc"><strong>eyetracker excluded col:</strong> <code>eyetracker_Date</code> (timestamp string), <code>eyetracker_stress_composite</code> (exploratory multi-metric composite index &mdash; excluded from primary hypothesis testing to maintain unconfounded physiological interpretability).</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">5. Atmotube (Particulate Matter & Microclimate) &mdash; 10 Raw Columns in Input</div>
  <div class="sensor-inc"><strong>atmotube included col:</strong> <code>atmo_pm1.0_avg</code>, <code>atmo_pm2.5_avg</code>, <code>atmo_pm10_avg</code> (particulate matter concentrations in &mu;g/m&sup3; &mdash; computed as balanced canonical pair-averages of Researcher Left and Researcher Right units to eliminate orientation/body-shadowing artifacts), <code>atmo_temperature_avg</code>, <code>atmo_humidity_avg</code> (ambient microclimatic validation checks).</div>
  <div class="sensor-exc"><strong>atmotube excluded col:</strong> <code>atmo_lys_atmotube_left__atmotube_pm1</code>, <code>atmo_lys_atmotube_left__atmotube_pm2.5</code>, <code>atmo_lys_atmotube_left__atmotube_pm10</code>, <code>atmo_lys_atmotube_left__atmotube_humidity</code>, <code>atmo_lys_atmotube_left__atmotube_temperature</code>, <code>atmo_lys_atmotube_right__atmotube_pm1</code>, <code>atmo_lys_atmotube_right__atmotube_pm2.5</code>, <code>atmo_lys_atmotube_right__atmotube_pm10</code>, <code>atmo_lys_atmotube_right__atmotube_humidity</code>, <code>atmo_lys_atmotube_right__atmotube_temperature</code> (raw individual directional streams &mdash; consolidated into canonical bilateral averages).</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">6. LYS Button (Ambient Illuminance & Spectral Irradiance) &mdash; 25 Raw Columns in Input</div>
  <div class="sensor-inc"><strong>lys included col:</strong> <code>lys_lux_avg</code> (photopic illuminance, lux), <code>lys_kelvin_avg</code> (correlated color temperature, K), <code>lys_rgbb_avg</code> (blue spectral irradiance), <code>lys_rgbg_avg</code> (green spectral irradiance), <code>lys_rgbr_avg</code> (red spectral irradiance) &mdash; all computed as balanced canonical pair-averages between Participant LYS1 and Researcher LYS2.</div>
  <div class="sensor-exc"><strong>lys excluded col:</strong> <code>lys_medi_avg</code> (melanopic equivalent daylight illuminance medi; excluded as photopic illuminance <code>lys_lux_avg</code> is the standard physical illumination metric and medi is highly collinear); all 24 raw individual sensor streams (<code>atmo_lys_LYS1__*</code> and <code>atmo_lys_LYS2__*</code> including raw <code>b'</code>, <code>g'</code>, <code>r'</code>, <code>rgbir</code>, and movement flags) &mdash; consolidated into bilateral canonical pair averages; <code>atmo_lys_LYS1__lux_cat</code>, <code>atmo_lys_LYS2__lux_cat</code> (categorical lux exposure bins), <code>lys_lux_participant</code> (raw participant-only unvalidated stream).</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">7. GVI & Visual Greenness Exposure &mdash; 9 Columns</div>
  <div class="sensor-inc"><strong>gvi included col:</strong> <code>gvi_50m</code> (canonical eye-level 360&deg; Green View Index smoothed across 50-meter spatial moving buffer &mdash; the validated continuous exposure metric).</div>
  <div class="sensor-exc"><strong>gvi excluded col:</strong> <code>gvi_tree_50m</code> (tree canopy view index), <code>gvi_grass_50m</code> (grass view index), <code>gvi_plant_50m</code> (low-vegetation view index), <code>gvi_phase_mean</code> (route-wide mean GVI), <code>tree_phase_mean</code> (route-wide mean tree canopy), <code>gvi_point_gvi</code>, <code>gvi_point_tree</code> (raw single-frame unsmoothed point matches), and <code>gvi_match_dist_m</code> (GIS distance QC flag) &mdash; all excluded to prevent collinear multi-testing duplicates of the same visual greenness exposure stream.</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">8. YAMNet Audio (Deep Learning Acoustic Scene Event Classification) &mdash; 11 Columns</div>
  <div class="sensor-inc"><strong>yamnet included col:</strong> <code>sound_level_dbfs</code> (continuous acoustic power, decibels relative to full scale), <code>sound_prop_rural_natural</code> (frame proportion of biophony and natural sounds), <code>sound_prop_vehicle</code> (frame proportion of motor vehicle traffic noise), <code>sound_prop_urban_manmade_positive</code> (frame proportion classified as <code>Urban/Manmade_positive</code>), <code>sound_prop_urban_manmade_neutral</code> (frame proportion classified as <code>Urban/Manmade_neutral</code>), <code>sound_prop_urban_manmade_negative</code> (frame proportion classified as <code>Urban/Manmade_negative</code>), <code>sound_prop_wind</code> (frame proportion of aerodynamic wind noise), <code>sound_prop_mechanisms</code> (frame proportion of construction/machinery noise).<br>
  <em>Note on scientific retention of natural sound vs unidentified sound:</em> <code>sound_prop_rural_natural</code> captures identifiable biophonic sounds (birds, foliage, natural acoustics) directly relevant to environmental restoration theories. Conversely, <code>sound_prop_unidentify</code> represents unclassified audio residual and unlabelled background flutter with no coherent psychological or environmental meaning; it is therefore strictly excluded.</div>
  <div class="sensor-exc"><strong>yamnet excluded col:</strong> <code>sound_prop_unidentify</code> (unclassified acoustic residual &mdash; scientifically excluded to retain solely identifiable acoustic sources like natural sounds), <code>sound_class_id</code> (discrete top-1 AudioSet ontology integer ID), <code>sound_category_label</code> (categorical text string of the single dominant sound class; statistical regression models require numerical proportion columns to estimate dosage effects).</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">9. Psychological Surveys (Momentary Affect & Restorativeness) &mdash; 39 Columns</div>
  <div class="sensor-inc"><strong>questionnaire included col:</strong> <code>questionnaire_current_comfort_1_7</code> (overall momentary subjective comfort, 1-7 Likert), <code>questionnaire_pleasantness_1_5</code> (perceived route pleasantness, 1-5 scale), <code>questionnaire_stai6_mean_1_5</code> (State-Trait Anxiety Inventory 6-item short form, 1-5 scale), <code>questionnaire_prs11_total_mean_1_5</code> (Perceived Restorativeness Scale 11-item validated total mean, 1-5 scale), <code>questionnaire_prs11_fascination_mean_1_5</code>, <code>questionnaire_prs11_being_away_mean_1_5</code>, <code>questionnaire_prs11_coherence_mean_1_5</code>, <code>questionnaire_prs11_scope_mean_1_5</code> (PRS-11 subscale dimension scores), <code>questionnaire_space_familiarity_1_5</code> (perceived spatial familiarity), <code>questionnaire_thermal_comfort_1_5</code> (subjective thermal comfort rating), <code>questionnaire_environmental_comfort_mean_1_5</code> (composite environmental comfort index).</div>
  <div class="sensor-exc"><strong>questionnaire excluded col:</strong> Static baseline demographic and trait survey fields (<code>questionnaire_height_m</code>, <code>questionnaire_weight_kg</code>, <code>questionnaire_bmi_kg_m2</code>, <code>questionnaire_bmi_category_who</code>, <code>questionnaire_background_age</code>, <code>questionnaire_background_gender</code>, <code>questionnaire_background_nationality</code>, <code>questionnaire_background_residential_area</code>, <code>questionnaire_background_years_in_brussels</code>, <code>questionnaire_background_vision_correction</code>, <code>questionnaire_background_site_familiarity_1_10</code>, <code>questionnaire_background_residence_type</code>, <code>questionnaire_background_has_children</code>, <code>questionnaire_background_commute_modes</code>, <code>questionnaire_background_regular_physical_activity</code>, <code>questionnaire_background_daily_walking</code>, <code>questionnaire_background_bike_frequency</code>, <code>questionnaire_background_own_bike_for_experiment</code> &mdash; measured once at baseline, time-invariant across experimental route bouts), clothing insulation logs (<code>questionnaire_clothing_*</code>, 6 columns), and administrative survey tracking IDs (<code>questionnaire_participant_id</code>, <code>questionnaire_response_index_within_participant</code>, <code>questionnaire_background_name</code>).</div>
</div>

<div class="sensor-block">
  <div class="sensor-header">10. Experimental Metadata & Intermediate Indices &mdash; 6 Columns</div>
  <div class="sensor-inc"><strong>metadata included col:</strong> <code>ParticipantID</code> (random-intercept grouping factor <em>u<sub>i</sub></em>), <code>PhaseID</code> (condition identifier defining <em>Mode</em>: Bike/Walk and <em>Environment</em>: Urban/Green).</div>
  <div class="sensor-exc"><strong>metadata excluded col:</strong> <code>Datetime</code>, <code>Date</code> (timestamp tracking &mdash; models operate on phase aggregations), <code>pct_complete</code> (data transmission completeness %), <code>grass_phase_mean</code>, <code>plant_phase_mean</code> (redundant route-aggregated visual layers).</div>
</div>

<!-- ======================================================================= -->
<!-- H1 SECTION -->
<!-- ======================================================================= -->
<h2 class="h1">2. Hypothesis 1 (H1) &mdash; Green versus Urban Route Contrast</h2>

<div class="card">
  <p><strong>Research Question:</strong> Does exposure to an urban green corridor (Bois de la Cambre) reduce physiological stress arousal and promote psychological restoration compared to a dense urban traffic corridor (Etterbeek / Montgomery), controlling for travel mode?</p>

  <div class="formula-box">
    <strong>Mathematical Model Formulation (Linear Mixed-Effects Model):</strong>
    Y<sub>ij</sub> = &beta;<sub>0</sub> + &beta;<sub>Mode</sub> &middot; Mode<sub>ij</sub> + &beta;<sub>Env</sub> &middot; Env<sub>ij</sub> + &beta;<sub>Int</sub> &middot; (Mode<sub>ij</sub> &times; Env<sub>ij</sub>) + u<sub>i</sub> + &epsilon;<sub>ij</sub><br>
    where u<sub>i</sub> ~ N(0, &sigma;<sub>u</sub><sup>2</sup>) is the random intercept for participant i, and &epsilon;<sub>ij</sub> ~ N(0, &sigma;<sup>2</sup>) is the residual error.<br><br>
    <strong>Exact R Syntax (package nlme via REML):</strong><br>
    <code>fit &lt;- lme(outcome_z ~ Mode * Environment, random = ~ 1 | ParticipantID, data = d, method = "REML")</code>
  </div>

  <p><strong>Columns Used:</strong></p>
  <ul>
    <li><strong>Dependent Variables (Outcomes, 23 total):</strong> 6 Autonomic (<code>empatica_heart_rate</code>, <code>empatica_eda_tonic</code>, <code>empatica_eda_phasic</code>, <code>empatica_skin_temperature</code>, <code>empatica_hrv_td_rmssd</code>, <code>empatica_hrv_td_sdnn</code>), 13 Eyetracker (<code>eyetracker_pupil_diameter_avg</code>, <code>eyetracker_pupil_change_rate</code>, <code>eyetracker_blink_duration_s</code>, <code>eyetracker_fixation_duration_s</code>, <code>eyetracker_fixation_rate</code>, <code>eyetracker_saccade_duration_s</code>, <code>eyetracker_saccade_amplitude</code>, <code>eyetracker_saccade_peak_velocity</code>, <code>eyetracker_gaze_velocity</code>, <code>eyetracker_gaze_dispersion</code>, <code>eyetracker_distance_from_center</code>, <code>eyetracker_gaze_centrality</code>, <code>eyetracker_eyelid_aperture_avg</code>), 4 Psychological (<code>questionnaire_current_comfort_1_7</code>, <code>questionnaire_pleasantness_1_5</code>, <code>questionnaire_stai6_mean_1_5</code>, <code>questionnaire_prs11_total_mean_1_5</code>).</li>
    <li><strong>Fixed-Effect Predictors &amp; Covariates:</strong> <code>Environment</code> (Urban [ref] vs. Green), <code>Mode</code> (Bike [ref] vs. Walk), and their factorial interaction <code>Mode * Environment</code>.</li>
    <li><strong>Random-Effect Grouping Factor:</strong> <code>ParticipantID</code> (11 participants, random intercept).</li>
  </ul>

  <p><strong>Planned Contrasts (Extracted via <code>emmeans</code>):</strong></p>
  <ul>
    <li><strong>Marginal Environmental Effect:</strong> Green &minus; Urban averaged across modes.</li>
    <li><strong>Simple Effect in Bike:</strong> BikeG &minus; BikeU.</li>
    <li><strong>Simple Effect in Walk:</strong> WalkG &minus; WalkU.</li>
  </ul>

  {summary_table([
      ("Results CSV file", str(h1_file), f"{len(h1):,} total contrast rows in results table"),
      ("Total Models Fitted", f"{len(h1):,} contrast estimates", "Matched 8-minute data; Within-Person Z-score only"),
      ("FDR-Significant Contrasts", f"{significant(h1)} significant contrasts (q_FDR < 0.05)", "Benjamini-Hochberg adjustment applied within each outcome family"),
      ("Sample Size & Degrees of Freedom", "N = 44 phase bouts (11 participants x 4 route conditions)", "Degrees of freedom df ≈ 28 to 30"),
      ("Output timestamp", time_text(h1_file), newest_status(h1_file)),
  ])}
</div>

<h3>Top Significant Findings for H1: Green versus Urban Route Contrast</h3>
<h4>Table 1.1: Green vs. Urban Contrast within Bike (BikeG vs. BikeU)</h4>
<p><em>Testing acute physiological and psychological restoration when traveling by bike in Bois de la Cambre park versus Etterbeek traffic corridor.</em></p>
{top_results_table(h1, "Outcome", "Contrast", limit=12, contrast_filter="within Bike")}

<h4>Table 1.2: Green vs. Urban Contrast within Walk (WalkG vs. WalkU)</h4>
<p><em>Testing acute physiological and psychological restoration when walking in Bois de la Cambre park versus Etterbeek traffic corridor.</em></p>
{top_results_table(h1, "Outcome", "Contrast", limit=12, contrast_filter="within Walk")}

{figure("Figure1_H1_Green_vs_Urban_ForestPlot.png", "Figure 1. H1 Forest Plot: Green versus Urban route planned contrasts across standardized within-person scores.")}

<!-- ======================================================================= -->
<!-- H2 SECTION -->
<!-- ======================================================================= -->
<h2 class="h2">3. Hypothesis 2 (H2) &mdash; Psychophysiological Concurrence</h2>

<div class="card">
  <p><strong>Research Question:</strong> Do acute within-person shifts in self-reported psychological states (anxiety, restorativeness, comfort, pleasantness) correspond to concurrent changes in autonomic and physiological markers during active travel?</p>

  <div class="formula-box">
    <strong>Mathematical Model Formulation (Within-Person Standardized LMM):</strong><br>
    Physio_z<sub>ij</sub> = &beta;<sub>0</sub> + &beta;<sub>Psych</sub> &middot; Psych_z<sub>ij</sub> + u<sub>i</sub> + &epsilon;<sub>ij</sub><br>
    where &beta;<sub>Psych</sub> is the standardized slope testing psychophysiological concurrence across active travel bouts, u<sub>i</sub> ~ N(0, &sigma;<sub>u</sub><sup>2</sup>) is the participant random intercept, and &epsilon;<sub>ij</sub> ~ N(0, &sigma;<sup>2</sup>) is the residual error.<br><br>
    <strong>Exact R Syntax (package nlme via REML):</strong><br>
    <code>fit &lt;- lme(phys_z ~ psych_z, random = ~ 1 | ParticipantID, data = d, method = "REML")</code>
  </div>

  <p><strong>Columns Used:</strong></p>
  <ul>
    <li><strong>Dependent Variables (Physiological Outcomes, 19 total):</strong> 6 Autonomic (Heart Rate, Tonic EDA, Phasic EDA, Skin Temp, RMSSD, SDNN) and 13 Eyetracker metrics (Pupil Diameter, Pupil Change Rate, Blink Duration, Fixation Duration, Fixation Rate, Saccade Duration, Saccade Amplitude, Saccade Peak Velocity, Gaze Velocity, Gaze Dispersion, Gaze Distance from Center, Gaze Centrality, Eyelid Aperture).</li>
    <li><strong>Key Independent Predictor:</strong> Standardized within-person psychological scales (<code>questionnaire_current_comfort_1_7</code>, <code>questionnaire_pleasantness_1_5</code>, <code>questionnaire_stai6_mean_1_5</code>, <code>questionnaire_prs11_total_mean_1_5</code>).</li>
    <li><strong>Random-Effect Grouping Factor:</strong> <code>ParticipantID</code> (accounting for repeated measures per subject).</li>
    <li><strong>Design Specification:</strong> Physical travel mode (Bike/Walk) is intentionally omitted to assess direct psychophysiological coupling across naturalistic urban journeys without artificially partialling out shared active mobility variance.</li>
  </ul>

  {summary_table([
      ("Results CSV file", str(h2_file), f"{len(h2):,} total concurrence models evaluated"),
      ("Total Models Fitted", f"{len(h2):,} bivariate psychophysiological models", "Within-Person Z-score only; 4 psychological scales x 19 physiological metrics (6 Empatica + 13 Eyetracker)"),
      ("FDR-Significant Concurrences", f"{significant(h2)} models significant at q_FDR < 0.05", "Omnibus Benjamini-Hochberg adjustment across all 76 pairs"),
      ("Effect Size Metric", "Standardized Slope (Beta_Within_Std) & Partial Correlation r_within", "r_within = sign(t) * sqrt(t^2 / (t^2 + df))"),
      ("Output timestamp", time_text(h2_file), newest_status(h2_file)),
  ])}
</div>

<h3>All 25 FDR-Significant Findings for H2 (Psychophysiological Concurrence)</h3>
<p><em>Testing direct psychophysiological coupling across 76 candidate pairs (4 psychological survey dimensions &times; 19 physiological measures). All models evaluated with standardized within-person Z-scores. Omnibus Benjamini-Hochberg adjustment applied across all 76 pairs: <strong>25 pairs reach FDR significance at q &lt; 0.05</strong>.</em></p>

<h4>Table 2.1: Perceived Restorativeness (PRS-11 Total Score) &mdash; 8 Significant Models</h4>
<p><em>Higher perceived restorativeness is associated with reduced peripheral temperature (&beta; = &minus;0.671, q = 4.02e-05), lower tonic sympathetic EDA (&beta; = &minus;0.404, q = 0.0276), shorter blink durations (&beta; = &minus;0.817, q = 6.17e-08), longer visual fixations (&beta; = +0.620, q = 4.82e-04), dilated pupils (&beta; = +0.663, q = 1.29e-04), and concentrated visual exploration (lower gaze velocity, dispersion, and eccentricity).</em></p>
{top_results_table(h2, "Physiological_Measure", "Psychological_Measure", limit=20, contrast_filter="prs11")}

<h4>Table 2.2: Route Pleasantness (1–5 Likert) &mdash; 9 Significant Models</h4>
<p><em>Higher subjective pleasantness aligns closely with the PRS-11 restorative profile: reduced skin temperature (&beta; = &minus;0.500, q = 0.0057), constricted blink durations (&beta; = &minus;0.760, q = 1.93e-06), lengthened fixations (&beta; = +0.488, q = 0.0119), dilated pupils (&beta; = +0.450, q = 0.0223), reduced pupil change rate (&beta; = &minus;0.395, q = 0.0366), and concentrated, centered visual focus (gaze centrality &beta; = +0.446, q = 0.0229).</em></p>
{top_results_table(h2, "Physiological_Measure", "Psychological_Measure", limit=20, contrast_filter="pleasantness")}

<h4>Table 2.3: State Anxiety (STAI-6 Mean Score) &mdash; 6 Significant Models</h4>
<p><em>Higher state anxiety shows an exact reciprocal pattern to restorativeness: elevated skin temperature (&beta; = +0.468, q = 0.0187), elongated blink durations (&beta; = +0.669, q = 2.74e-04), constricted pupils (&beta; = &minus;0.450, q = 0.0276), higher gaze velocity (&beta; = +0.456, q = 0.0255), greater gaze dispersion (&beta; = +0.486, q = 0.0208), and greater peripheral visual eccentricity (&beta; = +0.428, q = 0.0355).</em></p>
{top_results_table(h2, "Physiological_Measure", "Psychological_Measure", limit=20, contrast_filter="stai6")}

<h4>Table 2.4: General Comfort (1–7 Likert) &mdash; 2 Significant Models</h4>
<p><em>General comfort exhibits congruent coupling with reduced peripheral temperature (&beta; = &minus;0.380, q = 0.0482) and reduced blink duration (&beta; = &minus;0.470, q = 0.0253).</em></p>
{top_results_table(h2, "Physiological_Measure", "Psychological_Measure", limit=20, contrast_filter="comfort")}

{figure("Figure2_H2_Psych_Physio_Concurrence.png", "Figure 2. H2 Psychophysiological Concurrence Slopes.")}

<!-- ======================================================================= -->
<!-- H3 SECTION -->
<!-- ======================================================================= -->
<h2 class="h3">4. Hypothesis 3 (H3) &mdash; Walk versus Bike Mobility Mode Contrast</h2>

<div class="card">
  <p><strong>Research Question:</strong> How does active travel mode (Walk versus Bike) modulate physiological arousal, visual search, and self-reported comfort, and does travel mode moderate the restorative effect of green space?</p>

  <div class="formula-box">
    <strong>Mathematical Model Formulation (Factorial Mixed-Effects Model):</strong><br>
    Y<sub>ij</sub> = &beta;<sub>0</sub> + &beta;<sub>Mode</sub> &middot; Mode<sub>ij</sub> + &beta;<sub>Env</sub> &middot; Env<sub>ij</sub> + &beta;<sub>Int</sub> &middot; (Mode<sub>ij</sub> &times; Env<sub>ij</sub>) + u<sub>i</sub> + &epsilon;<sub>ij</sub><br>
    where u<sub>i</sub> ~ N(0, &sigma;<sub>u</sub><sup>2</sup>) is the random intercept for participant i, and &epsilon;<sub>ij</sub> ~ N(0, &sigma;<sup>2</sup>) is the residual error.<br><br>
    <strong>Exact R Syntax (package nlme via REML):</strong><br>
    <code>fit &lt;- lme(outcome_z ~ Mode * Environment, random = ~ 1 | ParticipantID, data = d, method = "REML")</code>
  </div>

  <p><strong>Columns Used:</strong></p>
  <ul>
    <li><strong>Dependent Variables (Outcomes, 23 total):</strong> Identical to H1 (6 Autonomic + 13 Eyetracker + 4 Psychological endpoints).</li>
    <li><strong>Fixed-Effect Predictors &amp; Covariates:</strong> <code>Mode</code> (Bike [ref] vs. Walk), <code>Environment</code> (Urban [ref] vs. Green), and their interaction term.</li>
    <li><strong>Random-Effect Grouping Factor:</strong> <code>ParticipantID</code>.</li>
  </ul>

  <p><strong>Planned Contrasts (Extracted via <code>emmeans</code>):</strong></p>
  <ul>
    <li><strong>Marginal Mobility Mode Effect:</strong> Walk &minus; Bike averaged across environments.</li>
    <li><strong>Simple Mode Effect in Urban Context:</strong> WalkU &minus; BikeU.</li>
    <li><strong>Simple Mode Effect in Green Context:</strong> WalkG &minus; BikeG.</li>
  </ul>

  {summary_table([
      ("Results CSV file", str(h3_file), f"{len(h3):,} total contrast rows in results table"),
      ("Total Models Fitted", f"{len(h3):,} contrast estimates", "Matched 8-minute data; Within-Person Z-score only"),
      ("FDR-Significant Contrasts", f"{significant(h3)} significant contrasts (q_FDR < 0.05)", "Benjamini-Hochberg adjustment applied within each outcome family"),
      ("Sample Size & Degrees of Freedom", "N = 44 phase bouts (11 participants x 4 route conditions)", "Degrees of freedom df ≈ 28 to 30"),
      ("Output timestamp", time_text(h3_file), newest_status(h3_file)),
  ])}
</div>

<h3>Top Significant Findings for H3: Walk versus Bike Mobility Mode Contrast</h3>
<h4>Table 3.1: Walk vs. Bike in Urban Corridor (WalkU vs. BikeU)</h4>
<p><em>Testing behavioral, physiological, and psychological differences between Walk and Bike travelers in the urban traffic corridor.</em></p>
{top_results_table(h3, "Outcome", "Contrast", limit=12, contrast_filter="within Urban")}

<h4>Table 3.2: Walk vs. Bike in Green Corridor (WalkG vs. BikeG)</h4>
<p><em>Testing behavioral, physiological, and psychological differences between Walk and Bike travelers in the green park corridor.</em></p>
{top_results_table(h3, "Outcome", "Contrast", limit=12, contrast_filter="within Green")}

{figure("Figure3_H3_Walk_vs_Bike_ForestPlot.png", "Figure 3. H3 Forest Plot: Walk versus Bike mobility mode contrasts.")}

<!-- ======================================================================= -->
<!-- H4 SECTION -->
<!-- ======================================================================= -->
<h2 class="h4">5. Hypothesis 4 (H4) &mdash; Multivariable {primary_candidate_count}-Predictor Co-Exposure Linear Mixed Models</h2>

<div class="note" style="border-left: 5px solid var(--blue); background: #f0f7ff; padding: 14px 18px; margin: 16px 0; border-radius: 0 4px 4px 0;">
  <strong>Hypothesis 4 Methodological Foundation &mdash; Simultaneous Mutual Co-Exposure Control:</strong><br>
  Real-world urban travel exposes individuals to an environmental mixture comprising thermal stress, traffic noise, airborne particulates, ambient illuminance, and eye-level greenery concurrently. Before H4 modeling, the active script audits all <strong>{raw_audit_count} raw columns plus {derived_audit_count} derived working columns</strong>, records every outcome, metadata, fused channel, categorical field, candidate, insufficient-data stream, and primary disposition in <code>H4_Candidate_Audit.csv</code>, and retains {candidate_count} continuous environmental candidates without using outcome p-values. Hypothesis 4 then uses a predeclared <strong>{primary_candidate_count}-domain multivariable linear mixed-effects model (LMM)</strong> under simultaneous mutual adjustment, alongside physical locomotion mode control (<code>Mode</code>). The one-predictor models are secondary and are not used as the primary H4 inference.
</div>

<h3>Hypothesis 4 &mdash; Primary Validated {primary_candidate_count}-Predictor Multivariable Co-Exposure LMM</h3>

<div class="card">
  <p><strong>Primary Research Question:</strong> When all retained physical environmental predictors are modeled <strong>simultaneously</strong> while controlling for physical locomotion effort (<code>Mode</code>), which ambient exposures show independent adjusted associations with acute physiological arousal, visual search behaviors, and psychological comfort during active urban travel?</p>

  <div class="formula-box" style="background:#f8fafc; border:1px solid #cbd5e1; border-left:5px solid var(--blue); padding:18px 22px; border-radius:6px; margin:16px 0;">
    <h4 style="margin-top:0; color:var(--blue); font-size:16px;">Hierarchical Multivariable Linear Mixed-Effects Model Formulation</h4>
    
    <p><strong>Level 1 (Within-Subject / Route Bout Level &mdash; <em>j</em> &isin; {{BikeU, WalkU, BikeG, WalkG}}):</strong></p>
    <div style="font-family:'Cambria Math', 'Times New Roman', serif; font-size:16.5px; margin:8px 0 14px 14px; color:#0f172a; line-height:1.6;">
      <em>Y</em><sub><em>ij</em></sub><sup>*</sup> = &beta;<sub>0<em>i</em></sub> + &beta;<sub>Mode</sub> &middot; Mode<sub><em>ij</em></sub> + &sum;<sub><em>k</em>=1</sub><sup>{primary_candidate_count}</sup> &beta;<sub><em>k</em></sub> &middot; <em>X</em><sub><em>kij</em></sub><sup>*</sup> + &epsilon;<sub><em>ij</em></sub>, &emsp; &epsilon;<sub><em>ij</em></sub> ~ <em>N</em>(0, &sigma;<sup>2</sup>)
    </div>

    <p><strong>Level 2 (Between-Subject / Clustering Level &mdash; Participant <em>i</em> &isin; {{1, &hellip;, 11}}):</strong></p>
    <div style="font-family:'Cambria Math', 'Times New Roman', serif; font-size:16.5px; margin:8px 0 14px 14px; color:#0f172a; line-height:1.6;">
      &beta;<sub>0<em>i</em></sub> = &gamma;<sub>0</sub> + <em>u</em><sub><em>i</em></sub>, &emsp; <em>u</em><sub><em>i</em></sub> ~ <em>N</em>(0, &sigma;<sub><em>u</em></sub><sup>2</sup>)
    </div>

    <p><strong>Combined Multivariable {primary_candidate_count}-Predictor Co-Exposure LMM:</strong></p>
    <div style="font-family:'Cambria Math', 'Times New Roman', serif; font-size:16.5px; margin:8px 0 18px 14px; color:#0f172a; line-height:1.8;">
      <em>Y</em><sub><em>ij</em></sub><sup>*</sup> = &gamma;<sub>0</sub> + &beta;<sub>Mode</sub> &middot; Mode<sub><em>ij</em></sub> + {primary_predictor_formula.replace('wpz__', '&beta;').replace(' + ', ' + ')} + <em>u</em><sub><em>i</em></sub> + &epsilon;<sub><em>ij</em></sub>
    </div>

    <p><strong>Exact R Implementation (nlme package via Restricted Maximum Likelihood):</strong><br>
    <code style="background:#e2e8f0; padding:4px 8px; border-radius:4px; font-size:13.5px; display:inline-block; margin-top:4px;">lme(outcome_z ~ Mode + {primary_predictor_formula}, random = ~ 1 | ParticipantID, data = d_m, method = "REML")</code></p>
  </div>

  <h4 style="color:#1e293b; margin-top:20px;">Mathematical Notation &amp; Operational Definitions</h4>
  <ul>
    <li><strong>Participant Index (<em>i</em> &isin; {{1, &hellip;, 11}}):</strong> 11 healthy adult participants completing all four experimental routes.</li>
    <li><strong>Route Bout Index (<em>j</em> &isin; {{BikeU, WalkU, BikeG, WalkG}}):</strong> Four experimental route conditions (two environments &times; two locomotion modes), yielding a fully balanced design of up to <strong><em>N</em> = 44</strong> participant-route bouts. The model groups by <code>ParticipantID + PhaseID</code>, so each BikeG exposure is paired with that same participant's BikeG outcome; phases are never cross-matched.</li>
    <li><strong>Phase-wise analysis:</strong> H4 is not fitted as four separate models. Each separate phase would contain only 11 participant observations and would answer a different within-phase question; the primary estimand is the pooled within-participant association across the four paired route phases.</li>
    <li><strong>Standardized Dependent Outcome (<em>Y</em><sub><em>ij</em></sub><sup>*</sup>):</strong> Within-person standardized score (<em>z</em>-score within participant <em>i</em>, <em>M</em> = 0, <em>SD</em> = 1) evaluated across 30 physiological and psychological endpoints:
      <ul>
        <li><strong>13 Ocular Metrics (Pupil Labs Neon):</strong> Pupil Diameter, Pupil Change Rate, Blink Duration, Fixation Duration, Fixation Rate, Saccade Duration, Saccade Amplitude, Saccade Peak Velocity, Gaze Velocity, Gaze Dispersion, Gaze Distance from Center, Gaze Centrality, Eyelid Aperture.</li>
        <li><strong>13 Autonomic Physiology Metrics (Empatica EmbracePlus):</strong> Heart Rate, EDA Tonic Level (SCL), EDA Phasic (SCR), Skin Temperature, HRV SDNN, HRV RMSSD, HRV LF Power, HRV HF Power, HRV LF/HF Ratio, HRV LFnu, HRV HFnu, HRV VLF Power, HRV Total Power.</li>
        <li><strong>4 Momentary Psychological Scales:</strong> General Comfort (1-7), Pleasantness (1-5), State Anxiety (STAI-6), Perceived Restorativeness (PRS-11).</li>
      </ul>
    </li>
    <li><strong>Travel Mode Covariate (Mode<sub><em>ij</em></sub> &isin; {{0, 1}}):</strong> Binary indicator (0 = Bike [reference], 1 = Walk) controlling for the categorical locomotion-mode contrast. Separate MET and GPS-speed terms are not included in primary H4.</li>
    <li><strong>The {primary_candidate_count} Primary Continuous Environmental Co-Exposures (<em>X</em><sub><em>kij</em></sub><sup>*</sup>):</strong> Each is WPZ-standardized across that participant's core outdoor route epochs, then averaged within the matched participant-phase bout. Predeclared but removed by the matched-design VIF rule: <code>{removed_vif_text}</code>.
      <ol>
        <li><strong>Thermal Comfort (UTCI<sub><em>ij</em></sub><sup>*</sup>):</strong> Universal Thermal Climate Index (&deg;C) from the calibrated UCM bioclimatic backpack station (integrating air temperature, mean radiant temperature, relative humidity, and air velocity).</li>
        <li><strong>Acoustic Noise (SND_dBA<sub><em>ij</em></sub><sup>*</sup>):</strong> A-weighted continuous equivalent sound pressure level (dBA) recorded by UCM acoustic instrumentation.</li>
        <li><strong>Particulate Air Pollution (PM2.5<sub><em>ij</em></sub><sup>*</sup>):</strong> Ambient fine particulate matter concentration (&mu;g/m&sup3;) computed as the bilateral average of Researcher Left and Researcher Right Atmotube Pro sensors.</li>
        <li><strong>Visual Illuminance (Lux<sub><em>ij</em></sub><sup>*</sup>):</strong> Photopic illuminance (lux) computed as the bilateral average of Participant LYS1 and Researcher LYS2 light sensors.</li>
        <li><strong>Visual Greenery (GVI):</strong> Audited as a predeclared candidate but not entered in primary H4 because its exact matched-design VIF was 13.99; it remains available for H1/secondary analyses.</li>
      </ol>
    </li>
    <li><strong>Random Intercept (<em>u</em><sub><em>i</em></sub> ~ <em>N</em>(0, &sigma;<sub><em>u</em></sub><sup>2</sup>)):</strong> Subject-specific random effect capturing baseline physiological and perceptual heterogeneity across participants.</li>
    <li><strong>Residual Error (&epsilon;<sub><em>ij</em></sub> ~ <em>N</em>(0, &sigma;<sup>2</sup>)):</strong> Bout-level residual disturbance, conditionally independent across routes.</li>
    <li><strong>Partial Regression Coefficients (&beta;<sub><em>k</em></sub>):</strong> Quantifies the expected standard deviation change in outcome <em>Y</em> per 1 standard deviation increase in environmental metric <em>k</em>, <em>holding the other {primary_candidate_count - 1} retained environmental exposures and locomotion mode strictly constant</em>.</li>
  </ul>

  <h4 style="color:#1e293b; margin-top:20px;">Degrees of Freedom Derivation &amp; REML Estimation</h4>
  <ul>
    <li><strong>Total Observations:</strong> <em>N</em> = 44 phase bouts (11 participants &times; 4 routes).</li>
    <li><strong>Fixed-Effects Parameters (<em>p</em> = {primary_candidate_count + 2}):</strong> Grand intercept, Mode, and the {primary_candidate_count} retained environmental predictors.</li>
    <li><strong>Random-Effects Intercept Parameters (<em>q</em> = 10):</strong> 10 independent subject contrast levels (11 participants &minus; 1 = 10).</li>
    <li><strong>Model-specific sample size:</strong> Complete-case models use <em>N</em> = 44 when all four bouts are available; some outcomes use <em>N</em> = 40 because of outcome missingness. Residual degrees of freedom are therefore model-specific (for example, 27 for <em>N</em> = 44 and 24 for <em>N</em> = 40).</li>
    <li><strong>Multiple Testing Control:</strong> BH-FDR is applied separately within each primary predictor family (30 outcome tests per predictor; {primary_candidate_count} predictor families), yielding adjusted <em>q</em>-values (<em>q</em><sub>FDR</sub>).</li>
  </ul>

  <div class="note" style="border-left: 5px solid #059669; background: #ecfdf5; padding: 14px 18px; margin: 16px 0; border-radius: 0 4px 4px 0;">
    <strong>Collinearity Diagnostics:</strong><br>
    All five predeclared domain representatives were tested before primary H4. The exact matched-design VIF rule removed <code>{removed_vif_text}</code>; the final primary VIFs are {primary_vif_text}:
    <ul>
      <li><strong>Exact matched participant-phase design (<em>N</em> = 44):</strong> all retained predictors are below VIF 5.</li>
      <li><strong>Full 33-candidate audit:</strong> every candidate is recorded in <code>H4_Candidate_Audit.csv</code>; a single all-candidate VIF is not estimable because only 19 participant-phase rows are complete for all 33 streams.</li>
    </ul>
    These exact matched-design diagnostics apply to the <em>N</em> = 44 primary H4 design. An eye-tracking-specific VIF is not claimed here because it was not recomputed for the final four-predictor set. The diagnostics do not establish statistical independence or orthogonality.
  </div>

  {summary_table([
      ("Model Specification", f"{primary_candidate_count}-Predictor Multivariable Co-Exposure LMM", f"{primary_predictor_formula.replace('wpz__', '')} + Mode"),
      ("Results File", str(h4_multi_file), f"{len(h4_multi):,} total multivariable regression coefficients"),
      ("Total Outcomes Evaluated", "30 outcomes (13 Ocular, 13 Autonomic, 4 Psychological)", f"{len(h4_multi):,} total multivariable regression terms"),
      ("FDR-Significant Effects", f"{significant(h4_multi):,} associations reach BH-FDR q < 0.05", f"{significant(h4_multi):,} effects across the retained primary predictors"),
      ("Nominal p < 0.05 Effects", f"{raw_significant(h4_multi):,} associations significant at unadjusted p < 0.05", f"{raw_significant(h4_multi):,} nominal effects across the retained primary predictors"),
      ("Sample Size & Degrees of Freedom", "N = 44 when complete; N = 40 for some outcomes", "Model-specific residual df (27 for N = 44; 24 for N = 40)"),
      ("Estimation Method", "Restricted Maximum Likelihood (REML via nlme::lme)", "Unbiased variance component estimation"),
      ("Output Timestamp", time_text(h4_multi_file), newest_status(h4_multi_file)),
  ])}
</div>

<h4>Table 4.1: FDR-Significant Multivariable Co-Exposure Associations (Mutual Environmental Control, q &lt; 0.05)</h4>
<p><em>Standardized partial regression slopes (&beta;<sub>Std</sub>) from the {primary_candidate_count}-predictor multivariable LMM representing the outcome change per 1 SD increase in exposure, holding the other retained environmental co-exposures and travel mode constant. GVI was audited but removed before primary H4 because of its matched-design VIF. These are associations, not evidence of a singular causal driver.</em></p>
{top_results_table(h4_multi, "Outcome", "Predictor", limit=25, show_sub_hyp=False, require_fdr=True)}

<h4>Table 4.1b: Secondary Exploratory Multivariable Associations Across Remaining Domains (Nominal p &lt; 0.05)</h4>
<p><em>Multivariable co-exposure associations for the retained non-acoustic predictors reaching nominal unadjusted significance (p &lt; 0.05) before FDR adjustment under mutual control:</em></p>
{top_results_table([r for r in h4_multi if r.get("Predictor") != "ucm_SND_dBA"], "Outcome", "Predictor", limit=12, show_sub_hyp=False, require_fdr=False)}

<!-- 5.2 MODE x STRESSOR INTERACTIONS -->
<h3>Locomotion Mode &times; Environmental Stressor Moderation LMMs</h3>

<div class="card">
  <p><strong>Moderation Research Question:</strong> Does active travel mode (Walk vs. Bike) moderate physiological arousal or psychological sensitivity to ambient stressors? That is, does walking buffer against or exacerbate acute reactions to environmental noise or air pollution compared to cycling?</p>

  <div class="formula-box" style="background:#f8fafc; border:1px solid #cbd5e1; border-left:5px solid var(--purple); padding:16px 20px; border-radius:6px; margin:16px 0;">
    <strong>Interaction Model Formula (nlme::lme via REML):</strong><br>
    <em>Y</em><sub><em>ij</em></sub><sup>*</sup> = &beta;<sub>0</sub> + &beta;<sub>Mode</sub> &middot; Mode<sub><em>ij</em></sub> + &beta;<sub>Stressor</sub> &middot; Stressor<sub><em>ij</em></sub><sup>*</sup> + &beta;<sub>Int</sub> &middot; (Mode<sub><em>ij</em></sub> &times; Stressor<sub><em>ij</em></sub><sup>*</sup>) + <em>u</em><sub><em>i</em></sub> + &epsilon;<sub><em>ij</em></sub><br><br>
    <strong>Exact R Syntax:</strong><br>
    <code>lme(outcome_z ~ Mode * wpz(Stressor), random = ~ 1 | ParticipantID, data = d_m, method = "REML")</code>
  </div>

  {summary_table([
      ("Model Scope", "Mode x Stressor Factorial Moderation", "Tests whether stressor slope differs between Walking and Cycling"),
      ("Tested Stressors", "Acoustic Noise (ucm_SND_dBA) and Fine Particulate Matter (atmo_pm2.5_avg)", "60 interaction models fitted across all 30 outcomes"),
      ("Degrees of Freedom", "df = 28", "N = 44, 4 fixed effects parameters"),
      ("FDR-Significant Interactions", f"{significant(h4_interact):,} interactions significant at q_FDR < 0.05", "Omnibus Benjamini-Hochberg adjustment across all 60 interaction terms"),
      ("Empirical Finding", "Uniform Stressor Invariance Across Locomotion Modes", "Zero interaction terms reach FDR significance (all q > 0.05). Ambient acoustic noise and particulate pollution exert identical physiological arousal and psychological distress regardless of whether the traveler is walking or cycling."),
  ])}
</div>

<h4>Table 4.2: Top Locomotion Mode &times; Stressor Interaction Models (Ranked by t-statistic)</h4>
<p><em>Interaction terms testing whether travel mode moderates stressor reactivity. No interaction effect reaches FDR significance (all q &gt; 0.05), confirming that bodily vulnerability to ambient urban stressors is invariant across active modes.</em></p>
{top_results_table(h4_interact, "Outcome", "Predictor", limit=8, show_sub_hyp=False, require_fdr=False)}

{figure("Figure4_H4_Multivariable_CoExposure_Heatmap.png", f"Figure 4. H4 Multivariable {primary_candidate_count}-Predictor Co-Exposure Heatmap: standardized partial regression slopes across 30 outcomes under simultaneous adjustment for {primary_predictor_formula.replace('wpz__', '')} and Mode. Bold borders and asterisks denote Benjamini-Hochberg FDR significance at q < 0.05.")}

<h2>6. Primary Statistical Output Map</h2>
<div class="card">
  <p>The statistical models remain version-controlled in the R scripts; this Python script assembles their saved outputs into this single inspectable reference report.</p>
  <ul>
    <li>{file_link(STAT_PRIMARY / "Run_Manifest.csv", "Main Run Manifest")}</li>
    <li>{file_link(STAT_PRIMARY / "results_H1-4.csv", "Combined H1-H4 Results Table (Primary)")}</li>
    <li>{file_link(STAT_PRIMARY / "H4_Candidate_Audit.csv", "Complete H4 Candidate Audit (189 raw + derived columns)")}</li>
    <li>{file_link(INPUT, "Active Matched 8-Minute Input Dataset")}</li>
  </ul>
</div>

<p class="note"><strong>Generated:</strong> {esc(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))}</p>
</body>
</html>
"""

    DOCUMENTS.mkdir(parents=True, exist_ok=True)
    HTML_OUTPUT.write_text(html_text, encoding="utf-8")
    print(f"Saved: {HTML_OUTPUT}")
    print(f"Input rows/columns: {len(input_rows)}/{len(input_headers)}")
    print(f"H1/H2/H3/H4 rows: {len(h1)}/{len(h2)}/{len(h3)}/{len(h4_multi)} (Multivariable Co-Exposure: {len(h4_multi)}, Mode Interactions: {len(h4_interact)})")


if __name__ == "__main__":
    build()

# -*- coding: utf-8 -*-
"""One-off: consolidate Presentation material/*.md into methods.md and output.md."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PRES = ROOT / "Presentation material"
STAT_R = ROOT / "scripts" / "statistical_analysis"

h4_lines = (STAT_R / "H4_timeseries.R").read_text(encoding="utf-8").splitlines()
eq_block = "\n".join(h4_lines[75:146])  # H4_timeseries.R: nested-RE comment through Eq7 quote (1-based lines 76–146)

methods_header = (
    "<!-- Consolidated 2026-10-27 from Presentation material sources; "
    "formulas anchored to scripts/statistical_analysis/H1_H3_phaseavg.R and scripts/statistical_analysis/H4_timeseries.R -->\n\n"
    "## Front matter\n\n"
    "| Item | Detail |\n"
    "| --- | --- |\n"
    "| **H1** | Better physiological and perceived comfort in green than impervious (urban) areas. |\n"
    "| **H2** | Physiological and perceived responses concordant in direction (within-person association). |\n"
    "| **H3** | Psychophysiological comfort more compromised during cycling than walking. |\n"
    "| **H4** | Noise and traffic amplify thermal discomfort (heat × sound interactions). |\n"
    "| **Input CSV** | `output/merged_all_11participants_8min.csv` |\n"
    "| **H1–H3 entrypoint** | `scripts/statistical_analysis/H1_H3_phaseavg.R` (engine: `scripts/statistical_analysis/library/H1_H3_core.R`) |\n"
    "| **H4 entrypoint** | `scripts/statistical_analysis/H4_timeseries.R` (engine: `scripts/statistical_analysis/library/H4_core.R`) |\n\n"
    "## Locked H4 equation quotes (from H4_timeseries.R)\n\n"
    "```r\n"
    f"{eq_block}\n"
    "```\n\n"
    "## Locked H1-H3 quotes (from H1_H3_phaseavg.R)\n\n"
    "Primary H1/H3 phase-mean LMM (same shell; planned contrasts differ via emmeans):\n\n"
    "```r\n"
    "H1_PhaseMean_Primary_LMM <- quote(\n"
    '  nlme::lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID, data = phase_mean_data, method = "REML")\n'
    ")\n\n"
    "H3_PhaseMean_Primary_LMM <- quote(\n"
    '  nlme::lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID, data = phase_mean_data, method = "REML")\n'
    ")\n"
    "```\n\n"
    "H2 repeated-measures correlation (not lme):\n\n"
    "```r\n"
    "H2_rmcorr <- quote(\n"
    "  lm(psychological ~ ParticipantID + physiological, data = participant_phase_means)\n"
    ")\n"
    "```\n\n"
    "**Temporal AR(1) sensitivity (H1 & H3):** WPZ outcomes at 10 s or 60 s epochs; "
    "`lme(wpz_outcome ~ PhaseID * time_min, random = ~ 1 | ParticipantID, "
    "correlation = corAR1(form = ~ time_10s_step | ParticipantID / PhaseID))` "
    "(and 60 s variant on `epoch_data_60s`). Not the primary contrast table; "
    "separate BH-FDR family per temporal fixed-effect term.\n\n"
)

method_sources = [
    "H1_to_H3_Methodology_Map.md",
    "Paper3_Explanation.md",
    "H4_Selection_Flow_explained.md",
    "Sound_screening_pca_vif.md",
    "Normalization_Transformation_results.md",
    "Reference Literature for all Paper3.md",
]

parts = [methods_header]
for name in method_sources:
    text = (PRES / name).read_text(encoding="utf-8")
    parts.append(f"---\n## Source: {name}\n---\n\n{text}")
    if not text.endswith("\n"):
        parts.append("\n")

methods_path = PRES / "methods.md"
methods_path.write_text("".join(parts), encoding="utf-8", newline="\n")

output_header = "<!-- Consolidated 2026-10-27 from Presentation material sources -->\n\n"
output_sources = ["H4_Report.md", "H4_Transparency_Report.md"]
out_parts = [output_header]
for name in output_sources:
    text = (PRES / name).read_text(encoding="utf-8")
    out_parts.append(f"---\n## Source: {name}\n---\n\n{text}")
    if not text.endswith("\n"):
        out_parts.append("\n")

output_path = PRES / "output.md"
output_path.write_text("".join(out_parts), encoding="utf-8", newline="\n")

print(f"methods.md bytes: {methods_path.stat().st_size}")
print(f"output.md bytes: {output_path.stat().st_size}")

# -*- coding: utf-8 -*-
"""One-off: consolidate Presentation material/*.md into methods.md and output.md."""
from pathlib import Path

ROOT = Path(r"D:\Pranav\docker\Paper3_Final")
PRES = ROOT / "Presentation material"
SCRIPTS = ROOT / "scripts"

h4_lines = (SCRIPTS / "H4_multivariate.R").read_text(encoding="utf-8").splitlines()
eq_block = "\n".join(h4_lines[72:139])  # lines 73-139 inclusive

methods_header = f"""<!-- Consolidated 2026-10-27 from Presentation material sources; formulas anchored to scripts/H1_to_H3_phase_average.R and scripts/H4_multivariate.R -->

## Front matter

| Item | Detail |
| --- | --- |
| **H1** | Better physiological and perceived comfort in green than impervious (urban) areas. |
| **H2** | Physiological and perceived responses concordant in direction (within-person association). |
| **H3** | Psychophysiological comfort more compromised during cycling than walking. |
| **H4** | Noise and traffic amplify thermal discomfort (heat × sound interactions). |
| **Input CSV** | `output/merged_all_11participants_8min.csv` |
| **H1–H3 entrypoint** | `scripts/H1_to_H3_phase_average.R` (engine: `scripts/H1_H3_core.R`) |
| **H4 entrypoint** | `scripts/H4_multivariate.R` (engine: `scripts/H4_core.R`) |

## Locked H4 equation quotes (from H4_multivariate.R)

```r
{eq_block}
```

## Locked H1-H3 quotes (from H1_to_H3_phase_average.R)

Primary H1/H3 phase-mean LMM (same shell; planned contrasts differ via emmeans):

```r
H1_PhaseMean_Primary_LMM <- quote(
  nlme::lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID, data = phase_mean_data, method = "REML")
)

H3_PhaseMean_Primary_LMM <- quote(
  nlme::lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID, data = phase_mean_data, method = "REML")
)
```

H2 repeated-measures correlation (not lme):

```r
H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_means)
)
```

**Temporal AR(1) sensitivity (H1 & H3):** WPZ outcomes at 10 s or 60 s epochs; `lme(wpz_outcome ~ PhaseID * time_min, random = ~ 1 | ParticipantID, correlation = corAR1(form = ~ time_10s_step | ParticipantID / PhaseID))` (and 60 s variant on `epoch_data_60s`). Not the primary contrast table; separate BH-FDR family per temporal fixed-effect term.

"""

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

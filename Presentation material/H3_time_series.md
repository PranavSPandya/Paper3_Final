# H3 — time-series variant (outcome-only)

Bibliography: [Reference Literature for all Paper3.md](Reference%20Literature%20for%20all%20Paper3.md).

**Authoritative code anchors:** `scripts/H1_to_H3_phase_average.R`, `scripts/H1_H3_core.R`. **H4 shell reference:** `scripts/H4_time_series.R` (nested bout AR(1); no environmental terms here).

---

## Purpose vs primary phase-mean H3

| Layer | Question | Unit | Role |
| --- | --- | --- | --- |
| **Primary H3** | Is comfort **more compromised when cycling than walking** within each environment? | Participant × `PhaseID` phase mean | Confirmatory **H3.1** (`WalkU` − `BikeU`) and **H3.2** (`WalkG` − `BikeG`) on `lme(outcome ~ PhaseID, random = ~ 1 \| ParticipantID)` |
| **H3 time series (this document)** | Do **walking vs cycling** differences emerge in **intra-bout trajectories** (levels, slopes, serial dependence) rather than only in averaged endpoints? | 10 s epochs within bout | **Sensitivity** parallel to H1 TS; same estimation engine as H1 temporal in code |

H3 shares the **identical** LMM and temporal shells as H1 (`H3_*` quotes are byte-identical to `H1_*` temporal quotes in `H1_to_H3_phase_average.R`). Hypothesis attribution is by **contrast interpretation**, not by a different formula.

---

## Data grain and input

Same as H1 time series:

- **CSV:** `output/merged_all_11participants_8min.csv`
- **Phases:** `BikeU`, `WalkU`, `BikeG`, `WalkG`
- **Window:** matched first **8 min** per bout
- **Grid:** 10 s primary (`time_10s_step`, `time_min`); 60 s aggregation sensitivity

---

## Outcome set

**26 physiological outcomes** (`H3_SPEC$outcomes` = `H1_SPEC$outcomes`). Temporal fits use **WPZ** (`wpz__*`) in the implemented pipeline; ln-transform rules match primary H3.

---

## Model formulas (nlme quote style)

### Implemented (`H3_Temporal_AR1_10s_LMM` / `H3_Temporal_AR1_60s_LMM`)

```r
H3_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
    data = epoch_data,
    method = "REML"
  )
)

H3_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_60s_step | ParticipantID / PhaseID),
    data = epoch_data_60s,
    method = "REML"
  )
)
```

Reference: **`BikeU`**. Interaction structure allows **steeper or flatter** comfort drift when cycling (`Bike*`) vs walking (`Walk*`) within urban and green cells.

### Outcome-only H4-parity shell (specification)

```r
H3_TS_OutcomeOnly_H4Shell <- quote(
  nlme::lme(
    Y ~ PhaseID * time_min,
    data = model_data,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step | ParticipantID / PhaseID),
    method = "REML",
    na.action = na.fail
  )
)
```

Same shell as H1 TS H4-parity quote; H3 interpretation attaches to **mode** contrasts (below).

---

## Planned H3 contrasts vs temporal coefficients

**Primary H3 contrasts (`H3_SPEC$contrasts`):**

| Sub-hypothesis | Contrast | Interpretation |
| --- | --- | --- |
| H3.1 | `WalkU` − `BikeU` | Walking vs cycling in **urban** |
| H3.2 | `WalkG` − `BikeG` | Walking vs cycling in **green** |

**Temporal model readout:** phase main effects and `PhaseID:time_min` interactions encode a **2×2** layout; they do **not** equal H3.1/H3.2 without emmeans translation. Recommended alignment steps (exploratory relative to preregistered phase-mean H3):

1. **emmeans** `WalkU` vs `BikeU` and `WalkG` vs `BikeG` on predicted WPZ (or Y) at `time_min = 0` or averaged over epochs.
2. Compare **urban vs green difference in mode gap:** `(WalkU − BikeU) − (WalkG − BikeG)` on predicted means or slopes (mode × environment on dynamics).
3. Cross-check: bout **integral** (mean over epochs) of WPZ should correlate with primary phase-mean estimates.

**Implemented export:** one shared table `H1_H3_Temporal_TimeSeries_AR1.csv` serves **both** H1 and H3 temporal sensitivity; assign rows to H3 by interpreting terms that separate **Walk vs Bike** within matched environment levels. Comments in `H1_to_H3_phase_average.R`: temporal phase coefficients are **not** the four primary planned comparisons.

---

## Temporal covariance

Identical machinery to H1 TS:

- **AR(1)** within `ParticipantID / PhaseID` on the epoch index
- φ (`AR1_phi`) and 60 s robustness columns in `H1_H3_Temporal_AR1_Sensitivity.csv`
- **Cross-outcome** co-evolution over time: exploratory (correlation matrices / multivariate extensions); **not** exported separately for H3 today

For H3, pay special attention to **phase-specific slopes** (`PhaseIDWalkU:time_min`, `PhaseIDBikeG:time_min`, …): a significant slope difference can indicate **mode-dependent fatigue or adaptation** during the 8 min window even when phase means overlap.

---

## FDR families

Same as H1 temporal layer:

- **One BH family per fixed-effect Term** across **26** outcomes (10 s primary)
- Separate 60 s Term-wise families in the sensitivity CSV
- **Independent** from primary H3 contrast families on phase-mean LMM (`Primary` / `Sensitivity_WPZ`)

Do not interpret temporal q-values as confirmatory H3.1/H3.2 tests without explicit contrast derivation.

---

## Relationship to H4

H3 time series uses the **H4 bout correlation template** (AR(1) within participant-phase) but **drops** all exposure covariates and heat × sound terms. Where H4 asks whether noise **amplifies** thermal discomfort over time, H3 TS asks whether **cycling vs walking** shifts **outcome trajectories** holding the outcome-only fixed block.

| H4 | H3 TS (outcome-only) |
| --- | --- |
| `Y ~ exposures + PhaseSum* + …` | `wpz_outcome ~ PhaseID * time_min` (implemented) |
| Nested `(1 \| ParticipantID / PhaseID)` in Eq quotes | Nested AR(1) yes; random intercept **ParticipantID only** in implemented H1/H3 temporal |
| Hypothesis: noise × heat | Hypothesis: mode within environment (via contrast mapping) |

---

## Not in scope

- Environmental predictors and H4 equation catalog (Eq 1–7)
- Psychophysiological concordance (H2)
- Replacing primary H3.1/H3.2 inference with uncorrected temporal interaction p-values

---

## Expected outputs

Shared with H1 temporal run:

| Artifact | Path |
| --- | --- |
| 10 s temporal terms | `output/statistical_analysis/results/H1_H3_Temporal_TimeSeries_AR1.csv` |
| 60 s sensitivity | `output/statistical_analysis/results/H1_H3_Temporal_AR1_Sensitivity.csv` |
| Primary H3 contrasts | `output/statistical_analysis/results/H1_H3_Contrasts.csv` (filter `Hypothesis == "H3"`) |

Future split: `output/statistical_analysis/results/H3_time_series/` (placeholder in `output.md`).

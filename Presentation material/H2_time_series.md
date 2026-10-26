# H2 — time-series variant (outcome-only concordance over time)

Bibliography: [Reference Literature for all Paper3.md](Reference%20Literature%20for%20all%20Paper3.md).

**Authoritative code anchors:** `scripts/H1_to_H3_phase_average.R` (primary H2), `scripts/H1_H3_core.R` (rmcorr fit). **H4 reference:** multivariate 10 s loop over 26 physiological outcomes (`scripts/H4_time_series.R`) without environmental fixed effects.

---

## Purpose vs primary phase-mean H2

| Layer | Question | Data pairing | Role |
| --- | --- | --- | --- |
| **Primary H2** | Are psychological and physiological responses **concordant in direction** within person? | **One** questionnaire value × **one** phase-mean physiological value per participant × `PhaseID` (44 rows) | `lm(psychological ~ ParticipantID + physiological)` — repeated-measures correlation (Bakdash & Marusich, 2017) |
| **H2 time series (this document)** | Does **concordance hold when physiology is observed at 10 s resolution** while psychology remains **sparse**? | Time-aligned **physio series** vs **phase-end psych** | **Specification** for temporal concordance; **not** a second 10 s LMM on questionnaires |

Primary H2 is implemented and exported to `H2_Physio_Psycho_Concordance.csv`. H2 time series addresses a design fact: **questionnaires are not repeated every 10 s**.

---

## Data grain and input

| Stream | Grain | Source |
| --- | --- | --- |
| Physiological | 10 s epochs, matched **8 min**, same CSV as H4 | `output/merged_all_11participants_8min.csv` |
| Psychological | **Once per participant × phase** (end-of-phase surveys) | Same CSV columns: `questionnaire_current_comfort_1_7`, `questionnaire_pleasantness_1_5`, `questionnaire_stai6_mean_1_5`, `questionnaire_prs11_total_mean_1_5` (`H2_SPEC$psychological_outcomes`) |

**Honest constraint:** there is **no** 10 s psychological outcome vector. H2 TS methods must **link** a single psych score to an entire bout trajectory (or epoch subset), not fit `psych ~ time_min` with AR(1) on psych.

---

## Outcome pairing set

- **Physiological:** 26 time-series outcomes (same as H1/H3/H4 physio block).
- **Psychological:** 4 scales × 26 physio measures = **104** pairs in primary H2 (one rmcorr family).

For temporal concordance, pairs are the same **104** combinations, but the physiological side is summarized or aligned **over time** within each participant × `PhaseID` cell.

---

## Primary H2 (reference quote)

```r
H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_means)
)
```

Phase means use notebook transforms (ln for designated HRV). This remains the **confirmatory** H2 estimand.

---

## Proposed time-series concordance strategies (specification)

All variants below are **outcome-only** (no UTCI, sound, PM, etc.). None are separate locked quotes in `H1_to_H3_phase_average.R` today; choose one primary TS strategy before pipeline implementation.

### Strategy A — Phase-level psych ~ physiological trajectory summary (recommended first)

For each participant × `PhaseID` × psych × physio:

1. Fit the **same** outcome-only AR(1) physio model as H1/H3 on `wpz__physio` (or native `Y`) over epochs in that bout only (or reuse coefficients from the global fit).
2. Construct **trajectory summaries**, e.g.:
   - epoch mean WPZ (should match primary physio mean up to weighting),
   - **slope** of WPZ on `time_min`,
   - **AUC** or last-minus-first contrast over 8 min,
   - **residual variance** or mean |Δ| between consecutive epochs (volatility).
3. Regress **psych** on **summary** with participant fixed effects or mixed model `(1 | ParticipantID)`:

```r
H2_TS_PhasePsych_TrajSummary <- quote(
  lm(
    psychological ~ ParticipantID + trajectory_summary,
    data = participant_phase_traj_features
  )
)
```

**Interpretation:** concordance of **overall** or **dynamic** physiology with **remembered** comfort at phase end. Direction of `trajectory_summary` coefficient maps to H2 “concordant in direction” language with explicit labeling (level vs slope vs volatility).

### Strategy B — Epoch-level cross-correlation within phase (exploratory)

Within each participant × `PhaseID` bout:

- Align psych constant across epochs (repeated value) **only for correlation**, or correlate **detrended** physio with a step function at phase end (weak).
- Prefer **intra-class correlation** or correlation between physio and **linear time** partialled by phase mean — still awkward because psych has **one** degree of freedom per cell.

Report as **descriptive** unless sample size and multiplicity control are pre-specified. **Not** equivalent to rmcorr on phase means.

### Strategy C — Multivariate physio trajectory vs psych (H4-style loop, outcome-only)

Parallel to H4’s per-outcome 10 s LMM loop:

- For each physio outcome, store bout-level **slope** and **intercept** from `wpz ~ time_min` with AR(1).
- Stack **4 × 26** slope (or intercept) estimates; correlate or rmcorr with psych across the 44 phase rows.

**Cross-outcome correlation:** correlation matrix of **slopes** across 26 outcomes within urban vs green phases — describes **co-evolution** of physiological systems over time; compare to psych scales in a second step. Exploratory; FDR strategy must be declared (e.g. one family per psych scale × summary type).

### Strategy D — Time-lagged concordance (future)

Cross-correlation function between detrended physio series and a **proxy** for instantaneous comfort (none measured). **Not recommended** without new data; document as out of scope for current instruments.

---

## Model formulas aligned with H1/H3 temporal shell (physio leg only)

Physio bout model (shared with H1/H3 TS):

```r
H2_TS_Physio_AR1_10s <- quote(
  nlme::lme(
    wpz_outcome ~ time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
    data = epoch_data_within_phase,
    method = "REML"
  )
)
```

Optional **stratified** fits (separate slope per `PhaseID`) match H1/H3 when trajectory summaries must respect the 2×2 design. **Psych enters only in the second-stage** regression (Strategy A), not inside the nlme formula.

H4-parity nested intercept variant:

```r
H2_TS_Physio_AR1_H4Shell <- quote(
  nlme::lme(
    Y ~ time_min,
    data = model_data,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step | ParticipantID / PhaseID),
    method = "REML",
    na.action = na.fail
  )
)
```

---

## Temporal covariance

- **Within physio outcome:** AR(1) across 10 s epochs (same as H1/H3).
- **Across outcomes at each epoch:** exploratory correlation / partial correlation matrix by `PhaseID` (descriptive heatmaps); optional multivariate normal model **not implemented**.
- **Psych:** no serial model (scalar per bout).

---

## FDR families (proposed)

| Analysis | Proposed family |
| --- | --- |
| Primary H2 rmcorr | **104** pairs, one BH (implemented) |
| H2 TS Strategy A | e.g. 4 psych × 26 physio × **K** summary types → declare **one family per (psych, summary_type)** or per psych across physio |
| Cross-outcome slope correlation (Strategy C) | Separate descriptive tier; avoid merging with primary H2 q-values |

Until implementation, treat all H2 TS q-values as **non-reportable** in the main H2 narrative.

---

## Relationship to H4

| H4 | H2 time series |
| --- | --- |
| 26-outcome 10 s LMM with exposures | 26-outcome 10 s LMM **without** exposures; psych linked **post hoc** |
| Bout AR(1) on physio | Same AR(1) on physio leg |
| Inference on heat × sound | Inference on **psych ~ physio trajectory** concordance |

Same **correlation shell** on the physiological block; fixed effects differ (H4: environment; H2 TS: time-only or H1/H3 phase×time for summarization).

---

## Not in scope

- Treating questionnaires as 10 s repeated measures in nlme
- Environmental predictors (H4 exposure block)
- Replacing Bakdash–Marusich rmcorr on phase means as confirmatory H2

---

## Expected outputs

| Status | Path |
| --- | --- |
| **Implemented (primary H2)** | `output/statistical_analysis/results/H2_Physio_Psycho_Concordance.csv` |
| **H2 TS (spec only)** | `output/statistical_analysis/results/H2_time_series/H2_TS_concordance.csv` (placeholder) |
| **Supporting physio trajectories** | Reuse `H1_H3_Temporal_TimeSeries_AR1.csv` or future bout-summary export |

See `Presentation material/output.md` for specification-only status.

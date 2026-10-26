# H1 — time-series variant (outcome-only)

Bibliography: [Reference Literature for all Paper3.md](Reference%20Literature%20for%20all%20Paper3.md).

**Authoritative code anchors:** `scripts/H1_to_H3_phase_average.R` (model quotes), `scripts/H1_H3_core.R` (fit, FDR, CSV export). **H4 shell reference:** `scripts/H4_time_series.R` (nested AR(1) bout structure; environmental fixed effects removed here).

---

## Purpose vs primary phase-mean H1

| Layer | Question | Unit | Role |
| --- | --- | --- | --- |
| **Primary H1** | Is comfort *better in green than urban* within each mode? | One value per participant × `PhaseID` (phase mean of each physiological outcome) | Confirmatory planned contrasts **H1.1** (`BikeG` − `BikeU`) and **H1.2** (`WalkG` − `WalkU`) on `lme(outcome ~ PhaseID, random = ~ 1 \| ParticipantID)` |
| **H1 time series (this document)** | How do outcomes **evolve during the matched bout**, and do **green vs urban differences** appear in **levels, slopes, or lag structure** rather than only in collapsed means? | Repeated 10 s epochs within each participant × bout | **Sensitivity / mechanistic supplement** to primary H1; same 26 outcomes, same four core phases, **no environmental predictors** |

Primary inference for H1 remains participant–phase means and emmeans simple contrasts (`H1_SPEC$contrasts` in `H1_to_H3_phase_average.R`). The time-series layer tests whether green–urban separation is visible in **temporal dynamics** (main effects of `PhaseID`, `PhaseID × time_min`, and AR(1) residual correlation) without conditioning on UTCI, sound, PM, or other exposure covariates.

---

## Data grain and input

| Item | Specification |
| --- | --- |
| **Input CSV** | `output/merged_all_11participants_8min.csv` (same matched file as H4: `paper3_merged_8min_path()`) |
| **Cohort** | `PAPER3_PARTICIPANTS` (11 participants); core phases `BikeU`, `WalkU`, `BikeG`, `WalkG` |
| **Window** | First **8 min** per bout (`PAPER3_MATCHED_CAP_SEC = 480`); object `route_ar1` / `epoch_data` in `H1_H3_core.R` |
| **Epoch grid** | **10 s** steps: `time_10s_step = round(time_in_phase_sec / 10)`; continuous time `time_min = time_in_phase_sec / 60` |
| **Robustness grid** | **60 s** epoch means (six 10 s bins per minute); `epoch_data_60s` / aggregated table in core |

Rows are **participant × PhaseID × epoch**. Duplicate `(ParticipantID, PhaseID, time_10s_step)` keys are treated as upstream errors (hard stop in core).

---

## Outcome set

**26 physiological time-series outcomes** — `paper3_physiological_outcomes()` / `H1_SPEC$outcomes`: 13 Empatica + 13 eye-tracker columns. Natural-log transforms for designated HRV (and related) terms follow `paper3_log_outcomes()` before WPZ standardization in the temporal pipeline.

**Normalization for implemented temporal fits:** within-person **z-scores** across the four core phases (`wpz__<outcome>`), computed per participant after notebook transforms. This matches the existing temporal sensitivity in `H1_H3_core.R` and parallels the WPZ phase-mean sensitivity for primary H1.

Questionnaire (psychological) outcomes are **not** part of H1 time series.

---

## Model formulas (nlme quote style)

### Implemented primary temporal sensitivity (`H1_Temporal_AR1_10s_LMM`)

Locked in `scripts/H1_to_H3_phase_average.R` (identical shell for H3 temporal quotes):

```r
H1_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
    data = epoch_data,
    method = "REML"
  )
)
```

60 s robustness:

```r
H1_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_60s_step | ParticipantID / PhaseID),
    data = epoch_data_60s,
    method = "REML"
  )
)
```

**Reference level:** `PhaseID = BikeU` (first level in `PAPER3_CORE_PHASES`). **`PhaseID * time_min`** expands to phase main effects, a global linear time trend, and phase-specific slopes.

**Fitting notes (core):** primary optimizer `optim`; on failure, `nlminb` then `optim` with `corAR1(value = 0.2, …)` fallback aligned with H4 practice (`H1_H3_core.R` comments).

### Outcome-only H4-parity shell (specification; not separate env block)

H4 bout models use nested random intercepts and AR(1) on the 10 s index (`Time10` in H4; `time_10s_step` here). For **outcome-only** H1 time series with the **same correlation / nesting shell** as Eq 1–7 but **without** any exposure fixed effects:

```r
H1_TS_OutcomeOnly_H4Shell <- quote(
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

Here `Y` is the analysis-scale physiological outcome (notebook transform, including ln where defined), **not** WPZ. This quote is the **H1 analogue** of H4’s random/AR(1) machinery with fixed effects restricted to the outcome block (`PhaseID`, time, interaction). The **implemented** pipeline currently uses participant-only random intercepts plus WPZ outcomes; converged runs live under `H1_H3_Temporal_*.csv`. Adopting `H1_TS_OutcomeOnly_H4Shell` would be a sensitivity labeled explicitly in outputs (nested intercept + native-scale Y).

---

## Planned H1 contrasts vs temporal coefficients

**Primary H1 contrasts (phase-mean LMM):**

| Sub-hypothesis | Contrast | Interpretation |
| --- | --- | --- |
| H1.1 | `BikeG` − `BikeU` | Green vs urban while **cycling** |
| H1.2 | `WalkG` − `WalkU` | Green vs urban while **walking** |

**From the time-series model:** coefficients are **not** automatically the same estimands as H1.1/H1.2. The AR(1) model reports:

- Phase **main effects** at `time_min = 0` (relative to `BikeU`)
- **Common** `time_min` slope and **phase-specific** `PhaseID:time_min` interactions
- Residual **lag-1 correlation** φ within bout

To align temporal results with H1.1/H1.2 **post hoc** (exploratory unless preregistered):

1. **emmeans** on `PhaseID` at bout start (`time_min = 0`) or at the **mean** epoch time, then `BikeG` vs `BikeU` and `WalkG` vs `WalkU` — same contrast names as `H1_SPEC$contrasts`.
2. **Difference-of-differences on slopes:** compare `(BikeG − BikeU)` slope minus `(WalkG − WalkU)` slope if the scientific question shifts to *faster deterioration in urban routes*.
3. **Phase-mean recovery:** predicted marginal mean over observed epoch times per phase compared to primary phase-mean LMM (consistency check).

The **implemented** temporal export (`H1_H3_Temporal_TimeSeries_AR1.csv`) reports **fixed-effect terms** (`PhaseIDWalkU`, `PhaseIDWalkG`, `time_min`, interactions, etc.) with **BH-FDR per Term across 26 outcomes**, not the two H1.1/H1.2 contrast rows. Interpret H1 green–urban claims from **primary** tables first; use temporal terms as **supporting dynamics**.

---

## Temporal covariance and cross-outcome structure

**Within-outcome serial correlation:** `corAR1(form = ~ time_10s_step | ParticipantID / PhaseID)` models exponential decay of residual correlation across consecutive 10 s epochs **within** each participant × bout. φ is exported as `AR1_phi`; `Stability_Flag` warns when φ > 0.95 (near-random-walk residuals; interpret fixed effects cautiously).

**Lag structure:** AR(1) is a **first-order** specification; 60 s aggregation sensitivity (`H1_Temporal_AR1_60s_LMM`) checks whether inference survives a coarser grid (eight epochs per 8 min bout).

**Cross-outcome correlation (exploratory, not in current R export):**

- **Descriptive:** epoch-level or phase-mean correlation matrix across the 26 outcomes (possibly by `PhaseID` or time window).
- **Multivariate normal / joint modeling:** co-evolution of outcomes over time within bout (e.g. stacked outcomes with unstructured or factor-analytic correlation). **Not implemented** in `H1_H3_core.R`; document as future extension sharing H4’s “26 outcomes loop” pattern but with outcome-only fixed effects.

---

## FDR families

| Family | Scope | Rule |
| --- | --- | --- |
| H1 primary | 26 outcomes × 2 planned contrasts (+ DiD) | BH within `Family_Set = Primary` |
| H1 WPZ sensitivity | Same contrasts on WPZ phase means | Separate BH family (`Sensitivity_WPZ`) |
| **H1 temporal (10 s)** | All **26** sensor outcomes × each **fixed-effect Term** in `PhaseID * time_min` | **One BH family per Term** (`TEMPORAL_FAMILY_N = 26` in core) |
| H1 temporal (60 s) | Same Term-wise families on 60 s grid | Separate q columns in sensitivity CSV |

Temporal families are **distinct** from primary H1 contrast families. Do not pool q-values across primary and temporal layers.

---

## Relationship to H4

| Component | H4 multivariate bout LMM | H1 time series (outcome-only) |
| --- | --- | --- |
| Data file & 10 s grain | `merged_all_11participants_8min.csv` | Same |
| Outcomes | 26 physiological | Same set |
| Random / AR(1) | `~ 1 \| ParticipantID / PhaseID`, `corAR1(~ Time10 \| …)` | Same **correlation** grouping; implemented H1 temporal uses **flat** participant random intercept (see above) |
| Fixed effects | Heat × sound, MRT × sound, SVF, PM, lux, GVI, `PhaseSum*` | **`PhaseID * time_min` only** — no `ucm_UTCI`, `ucm_SND_dBA`, or other exposures |
| Phase adjustment | Sum-to-zero `PhaseSumWalkG`, … | Treatment coding on `PhaseID` (BikeU reference) |
| Inference target | Environmental amplification (H4) | Green vs urban **comfort dynamics** (H1) |

Same **correlation shell**, different **fixed-effect block**: H1 TS isolates how outcomes move over time across route types without attributing variance to measured environment.

---

## Not in scope

- **Environmental predictors:** UTCI, sound (`ucm_SND_dBA`), PM, solar, SVF, GVI, LYS, wind, or any ucm/atmospheric column used in H4 Eq 1–7.
- **Heat × sound interactions** and equation catalog (Eq 2–7 sensitivities).
- **Psychological questionnaires** (reserved for H2).
- **Confirmatory replacement** of primary H1.1/H1.2 phase-mean contrasts by temporal term FDR alone.

---

## Expected outputs (pipeline)

When run via `scripts/H1_to_H3_phase_average.R` → `H1_H3_core.R`:

| Artifact | Path |
| --- | --- |
| Temporal fixed effects (10 s) | `output/statistical_analysis/results/H1_H3_Temporal_TimeSeries_AR1.csv` |
| 60 s robustness | `output/statistical_analysis/results/H1_H3_Temporal_AR1_Sensitivity.csv` |
| Primary H1 contrasts (reference) | `output/statistical_analysis/results/H1_H3_Contrasts.csv` |

Dedicated **H1-only** filename splits under `output/statistical_analysis/results/H1_time_series/` are **specification placeholders** until a partitioned export is added (see `Presentation material/output.md`).

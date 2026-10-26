<!-- Consolidated 2026-10-27 from Presentation material sources; formulas anchored to scripts/H1_to_H3_phase_average.R and scripts/H4_time_series.R -->

## Front matter

| Item | Detail |
| --- | --- |
| **H1** | Better physiological and perceived comfort in green than impervious (urban) areas. |
| **H2** | Physiological and perceived responses concordant in direction (within-person association). |
| **H3** | Psychophysiological comfort more compromised during cycling than walking. |
| **H4** | Noise and traffic amplify thermal discomfort (heat × sound interactions). |
| **Input CSV** | `output/merged_all_11participants_8min.csv` |
| **H1–H3 entrypoint** | `scripts/H1_to_H3_phase_average.R` (engine: `scripts/H1_H3_core.R`) |
| **H4 entrypoint** | `scripts/H4_time_series.R` (engine: `scripts/H4_core.R`) |

## Locked H4 equation quotes (from H4_time_series.R)

```r
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 2 (Sound sensitivity): Eq 1 + five family-wise PCA-screened sound mains (traffic, low-freq band, wind, spectral centroid, mechanisms)
Eq2 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + vehicle_proportion + freq_proportion_20_to_200Hz + wind_proportion + spectral_centroid_hz + mechanisms_proportion + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 3 (Heat sensitivity — mid air temp, RH, wind): AIR_T_mid * Sound + RH * Sound + wind * Sound + MRT * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq3 <- quote(nlme::lme(
  Y ~ ucm_AIR_T_mid * ucm_SND_dBA + ucm_AIR_RH * ucm_SND_dBA + ucm_WIND_AWS * ucm_SND_dBA + ucm_MRT * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 4 (Heat sensitivity — HUMIDEX): HUMIDEX * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq4 <- quote(nlme::lme(
  Y ~ ucm_HUMIDEX * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 5 (Heat sensitivity — PET): PET * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq5 <- quote(nlme::lme(
  Y ~ ucm_PET * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 6 (PM size sensitivity — PM1): UTCI * Sound + solar irradiance + SVF (sky view) + PM1 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq6 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm1_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 7 (PM size sensitivity — PM10): UTCI * Sound + solar irradiance + SVF (sky view) + PM10 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq7 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm10_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))
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

## H1–H3 time series variants (outcome-only)

**Run:** `scripts/H1_to_H3_time_series.R` (engine `scripts/H1_to_H3_time_series_core.R`; explicit `H1_TS_*` / `H2_TS_*` / `H3_TS_*` and `H2_rmcorr` quotes in the meeting file). No environmental predictors; H4-style sum-to-zero `PhaseSum*` and 10 s AR(1) within `ParticipantID / PhaseID`.

Reference prose (not executable): `Presentation material/H1_time_series.md`, `H2_time_series.md`, `H3_time_series.md` (full pastes below). Scripts supersede “spec-only” / placeholder language in those pastes where it conflicts.

Summary:

- **Grain:** 10 s epochs, matched first 8 min, input `output/merged_all_11participants_8min.csv` (same as H4).
- **Outcomes:** 26 physiological WPZ series for H1/H3; H2 adds phase-level psych–phys rmcorr (104 pairs) because questionnaires are not repeated at 10 s.
- **Models:** `wpz_outcome ~ PhaseID * time_min`, random `~ 1 | ParticipantID`, `corAR1(~ time_10s_step | ParticipantID/PhaseID)`; 60 s sensitivity aggregation in engine.
- **Outputs:** `output/statistical_analysis/results/H1_to_H3_time_series/` with `H1_`/`H2_`/`H3_`-prefixed CSVs, e.g. `H1_Temporal_TimeSeries_AR1_10s.csv`, `H3_Temporal_AR1_Sensitivity_60s.csv`, `H2_Physio_Psycho_Concordance.csv` (see `Presentation material/output.md`). Phase-average run (`scripts/H1_to_H3_phase_average.R`) writes to `output/statistical_analysis/results/H1_to_H3_phase_average/` as `H1_Temporal_*.csv` / `H3_Temporal_*.csv` (identical shared temporal fit, one copy per prefix).

---
## Source: H1_time_series.md
---
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

Here `Y` is the analysis-scale physiological outcome (notebook transform, including ln where defined), **not** WPZ. This quote is the **H1 analogue** of H4’s random/AR(1) machinery with fixed effects restricted to the outcome block (`PhaseID`, time, interaction). The **implemented** pipeline currently uses participant-only random intercepts plus WPZ outcomes; converged runs live under `results/H1_to_H3_phase_average/H1_Temporal_*.csv`. Adopting `H1_TS_OutcomeOnly_H4Shell` would be a sensitivity labeled explicitly in outputs (nested intercept + native-scale Y).

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

The **implemented** temporal export (`H1_Temporal_TimeSeries_AR1.csv`) reports **fixed-effect terms** (`PhaseIDWalkU`, `PhaseIDWalkG`, `time_min`, interactions, etc.) with **BH-FDR per Term across 26 outcomes**, not the two H1.1/H1.2 contrast rows. Interpret H1 green–urban claims from **primary** tables first; use temporal terms as **supporting dynamics**.

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
| Temporal fixed effects (10 s) | `output/statistical_analysis/results/H1_to_H3_phase_average/H1_Temporal_TimeSeries_AR1.csv` |
| 60 s robustness | `output/statistical_analysis/results/H1_to_H3_phase_average/H1_Temporal_AR1_Sensitivity.csv` |
| Primary H1 contrasts (reference) | `output/statistical_analysis/results/H1_to_H3_phase_average/H1_Contrasts.csv` |

H1-only time-series exports are now implemented as `H1_`-prefixed CSVs in `output/statistical_analysis/results/H1_to_H3_time_series/` (see `Presentation material/output.md`).

---
## Source: H2_time_series.md
---

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
| **Implemented (primary H2)** | `output/statistical_analysis/results/H1_to_H3_phase_average/H2_Physio_Psycho_Concordance.csv` |
| **H2 TS (spec only)** | `output/statistical_analysis/results/H1_to_H3_time_series/H2_Physio_Psycho_Concordance.csv` (phase-level rmcorr; trajectory-level strategies not implemented) |
| **Supporting physio trajectories** | Reuse `H1_Temporal_TimeSeries_AR1.csv` (phase-average folder) or future bout-summary export |

See `Presentation material/output.md` for specification-only status.

---
## Source: H3_time_series.md
---

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

**Implemented export:** one shared temporal fit (written as `H1_Temporal_TimeSeries_AR1.csv` and an identical `H3_Temporal_TimeSeries_AR1.csv`) serves **both** H1 and H3 temporal sensitivity; assign rows to H3 by interpreting terms that separate **Walk vs Bike** within matched environment levels. Comments in `H1_to_H3_phase_average.R`: temporal phase coefficients are **not** the four primary planned comparisons.

---

## Temporal covariance

Identical machinery to H1 TS:

- **AR(1)** within `ParticipantID / PhaseID` on the epoch index
- φ (`AR1_phi`) and 60 s robustness columns in `H1_Temporal_AR1_Sensitivity.csv`
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
| 10 s temporal terms | `output/statistical_analysis/results/H1_to_H3_phase_average/H3_Temporal_TimeSeries_AR1.csv` |
| 60 s sensitivity | `output/statistical_analysis/results/H1_to_H3_phase_average/H3_Temporal_AR1_Sensitivity.csv` |
| Primary H3 contrasts | `output/statistical_analysis/results/H1_to_H3_phase_average/H3_Contrasts.csv` |

H3-only time-series exports: `H3_`-prefixed CSVs in `output/statistical_analysis/results/H1_to_H3_time_series/` (see `output.md`).

---
## Source: H1_to_H3_Methodology_Map.md
---

# H1 to H3: Code & Methodology Design Map
## Environmental Comfort, Psychophysiological Concordance, and Mobility Mode Dynamics

Bibliography (methods, formulas, instruments): [Reference Literature for all Paper3.md](<../../../Presentation material/Reference Literature for all Paper3.md>).

---

### Core Scientific Questions & Hypotheses
Source: study hypothesis definitions and current `scripts/H1_to_H3_phase_average.R`; this document does not establish preregistration.

* **Hypothesis 1 (H1) — Environmental Setting:**
  > *Participants will show better physiological and perceived comfort in green than in impervious (urban) areas.*
* **Hypothesis 2 (H2) — Psychophysiological Concordance:**
  > *Physiological and perceived responses will be concordant (i.e., they correlate in direction).*
* **Hypothesis 3 (H3) — Active Mobility Exertion:**
  > *Psychophysiological comfort will be more compromised during cycling than during walking.*

---

## Statistical model equations (paper form vs fitted form)

The factorial layout is **Mode** (Walking, Cycling) × **Environment** (Urban/impervious, Green/park). In code, the four cells are a single factor **`PhaseID`** with levels `BikeU`, `WalkU`, `BikeG`, `WalkG` (reference level for treatment coding: **`BikeU`**, first in `PAPER3_CORE_PHASES`). Random intercepts use **`ParticipantID`** (11 participants; 44 participant–phase rows in primary H1/H3 fits).

| Hypothesis | Match to code? | Summary |
| :--- | :---: | :--- |
| **H1** | **Yes** (conceptual; same LMM as H3) | Mode × Environment structure and `(1 \| Participant)` match; inference is **planned contrasts** (green vs urban within mode), not a single interaction *F*-test. **All 26 physiological outcomes** are fitted—not skin temperature alone. |
| **H2** | **Partial** | Direction **Psychological ~ Physiological** matches; **not** a mixed model with `(1 \| Participant)`. Fitted as **rmcorr**: `lm(psychological ~ ParticipantID + physiological)` (participant fixed effects; Bakdash & Marusich, 2017). |
| **H3** | **Yes** (conceptual; same LMM as H1) | Same primary LMM shell as H1; inference is **planned contrasts** (walking vs cycling within environment). **All 26 physiological outcomes**—not pupil diameter alone. |

### Paper form (factorial notation)

Primary H1 and H3 tests use **participant–phase means** (one value per person × route). Let *Y* denote any of the 26 physiological/ocular time-series outcomes (after epoch aggregation and, where specified, ln-transform for HRV power terms). Subscripts: participant *i*, phase cell *j*.

**H1 & H3 (same structural model; different planned contrasts):**

```
Y_ij = β₀ + β_mode·Mode_j + β_env·Environment_j + β_int·(Mode × Environment)_j + u_i + ε_ij
```

Equivalent readable formula (main effects + interaction):

```
Y ~ Mode + Environment + Mode:Environment + (1 | Participant)
```

Examples (illustrative outcomes only):

* **H1:** `SkinTemperature ~ Mode + Environment + Mode:Environment + (1 | Participant)`
* **H3:** `PupilDiameter ~ Mode + Environment + Mode:Environment + (1 | Participant)`

**H2 (psychophysiological concurrence):**

```
PsychologicalOutcome_ij = γ₀ + γ·PhysiologicalOutcome_ij + u_i + ε_ij
```

Readable form:

```
PsychologicalOutcome ~ PhysiologicalOutcome + (1 | Participant)
```

*PsychologicalOutcome* = one of four end-of-phase questionnaires; *PhysiologicalOutcome* = matching participant–phase mean of a physiological measure (26 pairs × 4 scales = 104 tests).

### Concrete examples (filled)

Illustrative outcomes use the **same factorial shell** as all 26 physiological/ocular measures in `paper3_physiological_outcomes()`; H1 and H3 differ only in which **planned contrasts** are reported from the shared cell means.

**H1 (environment; example outcome: Empatica skin temperature)**

```
empatica_skin_temperature ~ Mode + Environment + Mode:Environment + (1 | Participant)
```

* **Mode:** Walking (`WalkU`, `WalkG`) vs Cycling (`BikeU`, `BikeG`).
* **Environment:** Green / park (`BikeG`, `WalkG`) vs Urban / impervious (`BikeU`, `WalkU`).
* **Mode × Environment:** four route cells — `BikeU` (cycling, urban), `WalkU` (walking, urban), `BikeG` (cycling, green), `WalkG` (walking, green).
* **Primary inference (not the interaction *F*-test):** H1.1 `BikeG − BikeU`; H1.2 `WalkG − WalkU` (difference-in-differences `(BikeG − BikeU) − (WalkG − WalkU)` also computed).
* **Fitted in code:** `lme(empatica_skin_temperature ~ PhaseID, random = ~ 1 | ParticipantID, method = "REML")` on participant–phase means (`PhaseID` = those four levels; reference `BikeU`).

**H3 (mode; example outcome: eyetracker mean pupil diameter)**

```
eyetracker_pupil_diameter_avg ~ Mode + Environment + Mode:Environment + (1 | Participant)
```

* Same **Mode**, **Environment**, and four **PhaseID** cells as H1.
* **Primary inference:** H3.1 `WalkU − BikeU` (walking vs cycling, urban); H3.2 `WalkG − BikeG` (walking vs cycling, green).
* **Fitted in code:** `lme(eyetracker_pupil_diameter_avg ~ PhaseID, random = ~ 1 | ParticipantID, method = "REML")` (identical LMM shell to H1; contrasts swapped).

**H2 (psychophysiological concurrence; one of 104 pairs)**

Paper-readable direction (psychological response regressed on concurrent physiological phase mean, participant-specific baselines removed):

```
questionnaire_prs11_total_mean_1_5 ~ empatica_skin_temperature + (1 | Participant)
```

* **Psychological column (4 scales, each tested against all 26 physiological means):** `questionnaire_current_comfort_1_7`, `questionnaire_pleasantness_1_5`, `questionnaire_stai6_mean_1_5`, `questionnaire_prs11_total_mean_1_5`.
* **Physiological column:** participant–phase mean of any outcome in the H1/H3 battery (e.g. `empatica_skin_temperature`, `empatica_heart_rate`, `eyetracker_pupil_diameter_avg`, …).
* **Fitted in code (rmcorr, not `lme`):** `lm(questionnaire_prs11_total_mean_1_5 ~ ParticipantID + empatica_skin_temperature, data = participant_phase_means)` — common within-person slope on the physiological predictor.

### Fitted form (`scripts/H1_to_H3_phase_average.R` → `H1_H3_core.R`)

**H1 & H3 — primary (native units or within-person *z* sensitivity):**

```
lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID, method = "REML")
```

`PhaseID` encodes the same four cells as Mode × Environment (no separate Mode/Environment columns in the formula). Contrasts are extracted with **`emmeans`** (e.g. H1.1 `BikeG − BikeU`, H1.2 `WalkG − WalkU`, H3.1 `WalkU − BikeU`, H3.2 `WalkG − BikeG`).

**H1 & H3 — temporal sensitivity (robustness; not the primary contrast table):**

```
lme(wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = corAR1(~ time_step | ParticipantID / PhaseID),
    method = "REML")
```

Within-person standardized outcomes (`wpz__*`) and AR(1) residual correlation within each participant–phase series.

**H2 — rmcorr (not `lme`):**

```
lm(psychological ~ ParticipantID + physiological, data = participant_phase_means)
```

The common within-person slope on *physiological* is the rmcorr coefficient; adjusting for **`ParticipantID`** as fixed effects implements the rmcorr decomposition (equivalent intent to removing between-person mean differences before correlating within-person deviations).

### Full expanded equations (plain text)

**Shared design:** PhaseID levels (reference first) = `BikeU`, `WalkU`, `BikeG`, `WalkG` (`PAPER3_CORE_PHASES`). R treatment coding: intercept = BikeU cell mean; other coefficients are differences vs BikeU. Indicators: `Mode_Walk = 1` for WalkU/WalkG else 0; `Env_Green = 1` for BikeG/WalkG else 0. Subscripts: participant i, phase bout j. Random intercept u_i ~ N(0, sigma_u^2); residual epsilon_ij ~ N(0, sigma^2). Planned contrasts (Beta = Comparison - Reference): H1.1 `BikeG_BikeU`, H1.2 `WalkG_WalkU`, H3.1 `WalkU_BikeU`, H3.2 `WalkG_BikeG`.

**H1 example (`empatica_skin_temperature`):** (a) Y_ij = b0 + b_M*Mode_Walk_j + b_E*Env_Green_j + b_ME*(Mode_Walk_j*Env_Green_j) + u_i + e_ij. (b) Y_ij = mu_BikeU + d_WU*I(WalkU) + d_BG*I(BikeG) + d_WG*I(WalkG) + u_i + e_ij with mu_WalkU = mu_BikeU + d_WU, etc. (c) `lme(empatica_skin_temperature ~ PhaseID, random = ~ 1 | ParticipantID, method = "REML")` on participant-phase means.

**H3 example (`eyetracker_pupil_diameter_avg`):** same (a)(b)(c) with outcome name swapped; inference H3.1/H3.2 from same fit.

**H2 example pair:** `questionnaire_prs11_total_mean_1_5` ~ `empatica_skin_temperature`: Y_ip = a0 + sum_{p!=P4} a_p*I(Participant=P) + gamma*X_ip + e_ip (44 bouts; P4 reference level).

**Temporal (sensitivity):** wpz_Y_ij(t) = intercept + PhaseID contrasts + time_min + PhaseID:time_min + u_i + e_ij(t); AR(1) on e within ParticipantID/PhaseID; `wpz__*` outcome; reference PhaseID = BikeU.

---

## 1. Study Design & Phase Panel Structure

The experiment follows a within-subject repeated-measures crossover design across four outdoor environmental routes (matched to the first 480 seconds / 8 minutes of exposure):

```
                        ENVIRONMENTAL CONTEXT
                     Urban / Impervious      Green / Park
                 ┌───────────────────────┬───────────────────────┐
       Walking   │        WalkU          │        WalkG          │
  MODE           │ (Etterbeek/Usquare)   │ (Bois de la Cambre)   │
                 ├───────────────────────┼───────────────────────┤
       Cycling   │        BikeU          │        BikeG          │
                 │ (Etterbeek/Usquare)   │ (Bois de la Cambre)   │
                 └───────────────────────┴───────────────────────┘
```

* **Cohort:** 11 retained participants (`P4`, `P8`, `P9`, `P10`–`P17`) completing all four conditions (*N* = 44 participant-phase bouts).
* **Outcome battery (30 columns in the merged table):**
  * **4 psychological scales (H2 only — one value per participant × phase; not H1/H3 time-series LMM *Y*):**
    * General Comfort: 7-point scale (`questionnaire_current_comfort_1_7`, 1 = very uncomfortable, 7 = very comfortable)
    * Pleasantness: 5-point scale (`questionnaire_pleasantness_1_5`)
    * State Anxiety: STAI-6 item mean (`questionnaire_stai6_mean_1_5`)
    * Perceived Restorativeness: PRS-11 item mean (`questionnaire_prs11_total_mean_1_5`)
  * **26 Objective Physiological & Ocular Outcomes:**
    * 13 Autonomic Sensor Metrics: Heart Rate (bpm), EDA tonic level (SCL, µS), EDA phasic rate (SCR, µS), Skin Temperature (°C), and 9 HRV time/frequency parameters (SDNN, RMSSD, LF, HF, LF/HF, LFnu, HFnu, VLF, Total Power).
    * 13 Ocular Sensor Metrics: Pupil diameter (mm), pupil change rate, blink duration, fixation duration, fixation rate, saccade duration, saccade amplitude, saccade peak velocity, gaze velocity, gaze dispersion, gaze centrality, gaze distance from center, and eyelid aperture.
  * **Transformations:** Logarithmic transformation ln(*x*) applied to skewed HRV power parameters (`SDNN`, `RMSSD`, `LF`, `HF`, `LF/HF`, `VLF`, `Total Power`) per Task Force (1996) and Laborde et al. (2017); native physical units retained for all other physiological measures. This is the current specification; it does not establish that residual assumptions hold for every outcome.

---

## 2. Methodology for H1 & H3: Linear Mixed Models & Planned Contrasts

### Model Specification
For each of the **26 physiological time-series outcomes** (participant-phase means from matched 10 s epochs), a Linear Mixed-Effects Model (LMM) is fitted via Restricted Maximum Likelihood (REML) using `nlme::lme`. The four questionnaire scales enter **H2 rmcorr** only, not this H1/H3 LMM loop:

```
Outcome[ij] = β₀ + Σ(β_p · PhaseID[p, j]) + u[i] + ε[ij]
```
*where:*
* `u[i] ~ N(0, σ_u²)` is the participant-level random intercept accounting for between-subject baseline variability.
* `ε[ij] ~ N(0, σ²)` is the residual error.

---

### Planned Contrast Matrix
Hypotheses 1 and 3 are evaluated using four planned pairwise contrasts (not mutually orthogonal) plus a difference-in-differences contrast among estimated marginal means (`emmeans`):

| Hypothesis | Sub-Hypothesis | Contrast Definition | Reference Phase | Comparison Phase | Expected Direction for Greater Comfort |
| :--- | :---: | :--- | :---: | :---: | :--- |
| **H1 (Environment)** | **H1.1** | Green vs. Urban during Cycling | `BikeU` | `BikeG` | ΔHR < 0, ΔSTAI < 0, ΔComfort > 0 |
| **H1 (Environment)** | **H1.2** | Green vs. Urban during Walking | `WalkU` | `WalkG` | ΔHR < 0, ΔSTAI < 0, ΔComfort > 0 |
| **H3 (Mode)** | **H3.1** | Walking vs. Cycling in Urban | `BikeU` | `WalkU` | ΔHR < 0, ΔPupil < 0, ΔComfort > 0 |
| **H3 (Mode)** | **H3.2** | Walking vs. Cycling in Green | `BikeG` | `WalkG` | ΔHR < 0, ΔPupil < 0, ΔComfort > 0 |
| **Interaction** | **DiD** | Difference-in-Differences | — | — | (BikeG - BikeU) - (WalkG - WalkU) |

### Effect Sizes & Multiplicity Control
* **Paired Standardized Mean Differences (Bonett, 2008):**
  Paired SMD values and exact 95% confidence intervals are computed via `statpsych::ci.stdmean.ps()` to provide scale-free effect sizes for meta-comparison across physiological systems.
* **Benjamini-Hochberg (BH, 1995) FDR Adjustment:**
  Contrasts are adjusted for multiple testing within each planned hypothesis family across all outcomes. Primary models (native units) and within-person standardized sensitivities (`Sensitivity_WPZ`) are evaluated in separate FDR families.

---

## 3. Methodology for H2: Psychophysiological Concordance

### Repeated Measures Correlation (`rmcorr`)
Hypothesis 2 tests whether within-individual changes in physiological activation covary with subjective perceived comfort ratings across environmental transitions:

```
r_rm = Σ Σ ((X[ij] - Mean_i(X)) · (Y[ij] - Mean_i(Y))) /
       sqrt( Σ Σ (X[ij] - Mean_i(X))² · Σ Σ (Y[ij] - Mean_i(Y))² )
```

* **Implementation:** Repeated-measures correlation following **Bakdash & Marusich (2017)** (`rmcorr`), which isolates intra-individual variance without violating independence assumptions or committing ecological fallacies.
* **Matrix Dimension:** 4 Survey Metrics × 26 Physiological Metrics = **104 pairwise concordance tests**.
* **Hypothesis Evaluation:**
  * **Concordance:** Significant correlation in the physiologically expected direction (e.g., higher general comfort associating with lower heart rate, lower EDA tonic level, or higher HRV parasympathetic power).
  * **No evidence of association:** A non-significant result does not establish discordance. An opposite-direction association requires its own uncertainty and interpretability assessment.
* **Multiplicity Adjustment:** BH-FDR applied across all 104 concordance pairs (*m* = 104).

---

## 4. Execution & Artifacts

| Component | Path / Location | Description |
| :--- | :--- | :--- |
| **Meeting spec** | `scripts/H1_to_H3_phase_average.R` | `GLOBAL_SPEC`, separate `H1_SPEC` / `H2_SPEC` / `H3_SPEC`, explicit H1/H3/H2 model quotes; sources `H1_H3_core.R`. |
| **Engine** | `scripts/H1_H3_core.R` | Input paths (`RAW_PATH`, `KEY_PATH`, `OUT_DIR`), load, fit, FDR, CSVs, forest plot (not shared with H4). |
| **Analysis Input** | `output/merged_all_11participants_8min.csv` | Canonical 11-participant matched 8-minute dataset. |
| **Contrast Results** | `output/statistical_analysis/results/H1_to_H3_phase_average/H1_Contrasts.csv`, `H3_Contrasts.csv` | Full table of estimates, SE, *t*-values, Bonett SMDs, *p*-values, and FDR *q*-values. |
| **Concordance Results** | `output/statistical_analysis/results/H1_to_H3_phase_average/H2_Physio_Psycho_Concordance.csv` | rmcorr coefficients (*r_rm*), 95% CIs, *p*-values, and FDR *q*-values. |
| **Forest Plot** | `output/statistical_analysis/results/H1_to_H3_phase_average/H1_to_H3_Statistical_Results_ForestPlot.jpg` | Publication-ready forest plot illustrating paired SMDs across all four contrasts. |
| **Execution Command** | `Rscript scripts/H1_to_H3_phase_average.R` | Runs complete inferential pipeline and updates result tables and figures. |


## Saved result snapshot

Saved run: **2026-10-12 17:04:59**. The manifest input is 5077 x 232; the current input is 5077 x 224. Input contents match: **False**. These counts describe saved outputs, not a fresh execution of today's code/input. No models were rerun for this document move.

| Saved family   | Hypothesis   |   Tests |   q < 0.05 |
|:---------------|:-------------|--------:|-----------:|
| Primary        | H1.1         |      26 |          5 |
| Primary        | H1.2         |      26 |          6 |
| Primary        | H3.1         |      26 |          6 |
| Primary        | H3.2         |      26 |          4 |
| Sensitivity    | H1.1         |      26 |          5 |
| Sensitivity    | H1.2         |      26 |          7 |
| Sensitivity    | H3.1         |      26 |          6 |
| Sensitivity    | H3.2         |      26 |          5 |

H2: **5/104** saved associations have q < 0.05:

| Questionnaire_Label              | Physio_Label                      |   r_rmcorr |   q_FDR |
|:---------------------------------|:----------------------------------|-----------:|--------:|
| Survey: Pleasantness (1-5)       | Eyetracker: Blink Duration (s)    |    -0.6489 |  0.0027 |
| Survey: Restorativeness (PRS-11) | Empatica: Skin Temperature (°C)   |    -0.6278 |  0.0024 |
| Survey: Restorativeness (PRS-11) | Eyetracker: Pupil Diameter (mm)   |     0.6617 |  0.0024 |
| Survey: Restorativeness (PRS-11) | Eyetracker: Blink Duration (s)    |    -0.7612 |  0.0001 |
| Survey: Restorativeness (PRS-11) | Eyetracker: Fixation Duration (s) |     0.5542 |  0.0309 |

Current normalization tables and method qualifications: [Normalization_results.md](<../../../Presentation material/Normalization_results.md>). Saved significance counts are not confirmation of model assumptions or causal hypotheses.
---
## Source: Paper3_Explanation.md
---

# Paper 3 — Study Design and Analytical Framework

This chapter states the locked experimental design and the hypothesis-specific statistical specifications implemented in `Paper3_Final`. It is methods and design only: model forms and processing rules are complete; coefficient tables and FDR counts live under `output/statistical_analysis/` and are not restated unless verified against a current run.

**Scripts.** H1–H3 (including H2): `scripts/H1_to_H3_phase_average.R` with engine `scripts/H1_H3_core.R`. H4: `scripts/H4_time_series.R` with engine `scripts/H4_core.R`. Shared helpers: `scripts/Paper3_common.R`, `scripts/H1_to_H4_common.R`. Matched analysis input: `output/merged_all_11participants_8min.csv`. H4 selection narrative: `Presentation material/H4_Selection_Flow.md`, `H4_Selection_Flow_explained.md`. Sound PCA report: `Presentation material/Sound_screening_pca_vif.md`. Master bibliography: `Presentation material/Reference Literature for all Paper3.md`; sibling PDF root `Paper3_Github/Experiment papers/`.

Paper 3 examines psychophysiological comfort during active urban mobility under contrasting green and impervious settings, with synchronous wearable physiology, ocular measures, hyper-local environmental sensing, and post-phase questionnaires. Confirmed hypothesis wording (user confirmation 2026-10-13; text only):

- **H1.** Participants will show better physiological and perceived comfort in green than in impervious areas.
- **H2.** Physiological and perceived responses will be concordant (i.e., they correlate in direction).
- **H3.** Psychophysiological comfort will be more compromised during cycling than during walking.
- **H4.** The presence of noise and traffic will amplify thermal discomfort.

Operational mapping: H1 and H3 share participant-phase `PhaseID` linear mixed models with planned simple contrasts; H2 is repeated-measures correlation across participant-phase means; H4 is a set of 10-second multivariate LMEs with heat × sound interactions and declared covariates. The analytical order below follows H1 → H2 → H3 → H4.

---

## Experimental frame (shared by all hypotheses)

Field campaign: Brussels, Belgium, 3 July–27 August 2025. Ethics planning allowed up to 30 participants; 18 were tested; the locked analysis cohort is **11 participants** with complete multi-sensor coverage on the four core outdoor phases — `P4`, `P8`, `P9`, `P10`, `P11`, `P12`, `P13`, `P14`, `P15`, `P16`, `P17` (`PAPER3_PARTICIPANTS` in `scripts/H1_to_H4_common.R`). Participants `P2`, `P3`, `P5`, `P6`, `P7`, and `P18` are outside this set. No dated QC/protocol document in-repo yet justifies those six omissions; cohort composition is therefore an analysis-scope definition until that record exists.

Within-subject design. Each retained participant contributes the four **core active phases** (`PAPER3_CORE_PHASES`): `BikeU` / `WalkU` (cycling / walking on the Etterbeek–Usquare → Montgomery urban corridor) and `BikeG` / `WalkG` (same modes on the Bois de la Cambre park loop). Additional recorded phases (`Tram`, `Indoor`, `Reststop`) are outside the four-route primary H1–H4 contrast set and do not enter H1–H3/H4 exposure centering baselines. `PhaseID` is the Mode × Environment cell and the matching key for participant-phase aggregation.

Core outdoor phases differ in travel speed and duration. All primary inferential work for H1–H4 uses the **matched first 8 minutes** from phase start (0–480 s; `PAPER3_MATCHED_CAP_SEC = 480`). Documented row count for the matched product is **5,077** ten-second rows. Column count has grown with sound/SVF/GVI integration (historical pre-integration roster 189; post-integration audits 228 without full YAMNet expansion; later rebuild 1,252 including 521 YAMNet class fields). Analyses must bind to the file on disk for the run being reported. Expected matched windows per participant-phase for H4 coverage denominators: **49** ten-second epochs (`H4_SPEC$expected_epochs = 49L`).

**Instruments.** The urban Climate Monitor (uCM / CityFeel) backpack on the trailing researcher records air temperature, RH, wind, global horizontal irradiance (`ucm_SUN_Gh`), sound level (`ucm_SND_dBA`), multi-plane IR → mean radiant temperature (`ucm_MRT`), GPS, and derived thermal indices including UTCI, PET, and HUMIDEX (CityFeel / UCM; doi:10.1016/j.egypro.2017.07.427). UTCI is the outdoor equivalent temperature of a reference environment that elicits the same dynamic physiological response as the actual meteorological state (Bröde et al., 2012); Paper 3 uses the UCM-computed series `ucm_UTCI` (operational polynomial approximation in Bröde et al., not re-derived here). Empatica EmbracePlus (participant wrist) yields heart rate, EDA tonic/phasic, skin temperature, and time- and frequency-domain HRV. Pupil Labs Neon supplies pupil, blink, fixation, saccade, and gaze metrics. Bilateral Atmotube devices yield PM1/PM2.5/PM10 averages; LYS1 (participant) and LYS2 (researcher) yield bilateral lux and Kelvin averages. Post-phase questionnaires include comfort, pleasantness, STAI-6, and PRS-11.

**Declared outcomes.** Psychological scales for H2 (not H4 environmental predictors): `questionnaire_current_comfort_1_7`, `questionnaire_pleasantness_1_5`, `questionnaire_stai6_mean_1_5`, `questionnaire_prs11_total_mean_1_5`. Physiological outcomes for H1, H3, and H4 — denoted $Y$ below — are 26 series from `paper3_physiological_outcomes()` (13 Empatica and 13 eye-tracker). HRV natural-log subset (`hrv_log`): SDNN, RMSSD, LF, HF, LF/HF, VLF, total power (Laborde et al., 2017; Task Force ESC/NASPE, 1996, as mapped in project normalization votes). Heart rate, skin temperature, EDA tonic/phasic, LFnu, HFnu, and all eye-tracker outcomes remain on native scale in the locked Step 5 contract (EDA literature often prefers log/√ transforms; that preference does not override the locked native-scale rule).

**CamUp annular view factors versus Mapillary GVI.** Two greenery/openness products must not be conflated. CamUp upward fisheye → DeepLabV3+ Xception/ADE20K segmentation → Holmer (1992) annular view factors (`scripts/SVF Computation/compute_svf_camup.py`, `SkyViewFactorCalculator.compute_factor`; 10 s aggregation via `scripts/SVF_10sec.py` / `SVF Computation/SVF_10sec.py`); street-view SVF estimation context also draws on Qiu et al. (2017). Declared annular factors (Gong et al., 2018 class roles; Holmer annular geometry): sky view factor (SVF; primary H4 sky-openness covariate), tree/vegetation view factor (TVF; Tree ∪ Plant ∪ Grass), and building view factor (BVF; Building ∪ Wall; ceiling excluded). With $n$ concentric rings (`DEFAULT_SVF_RINGS = 120`) and $\alpha_r \in [0, 2\pi]$ the angular occupancy of the target class in ring $r$, the Holmer annular view factor is

$$
VF
=
\frac{1}{2\pi}\sin\!\left(\frac{\pi}{2n}\right)
\sum_{r=1}^{n}
\sin\!\left(\frac{\pi(2r-1)}{2n}\right)\,\alpha_r
$$

(`compute_svf` in `compute_svf_camup.py`; Holmer, 1992). The same operator is applied to three binary masks within the fisheye circle: sky → SVF; Tree ∪ Plant ∪ Grass → TVF; Building ∪ Wall → BVF (Gong et al., 2018 naming). Ceiling enters scene `%` / `Total_Builtup_%` only, not BVF. Frames enter a 10 s window mean only if the sum of seven retained class percentages is **≥ 50%**. Mapillary Graph API v4 panoramas within a search radius (default 50 m), then DeepLabV3+ Xception-65 ADE20K segmentation (`scripts/GVI Computation/`), yield green view index $GVI$ as the sum of Tree, Grass, and Plant class percentages. Canonical H4 greenery covariate: **`gvi_50m`**. Scene-% / TVF / BVF are not co-entered as SVF substitutes; GVI components and phase means are not co-entered with `gvi_50m`.

**Processing.** Continuous streams synchronize to UTC and aggregate to non-overlapping **10-second epochs**. H1–H3 primary inference collapses physiology (and, for H2, questionnaires) to one participant × PhaseID mean (at most 11 × 4 = **44** bouts) to avoid pseudoreplication. H4 keeps the 10 s series and models within-bout dependence explicitly. Atmotube and LYS bilateral channels are averaged before exposure use; raw unilateral channels are not co-entered with averages. Atmotube T/RH are not H4 thermal predictors when UCM AIR already represents those constructs. Calibrated intensity is `ucm_SND_dBA`; semantic/spectral descriptors feed Eq2 screening only (below). H4 accepts finite UTCI within the UCM plausibility range (−50 to 60 °C); a 2026-10-07 reconciliation noted zero negative UTCI in the rebuilt matched 8-minute H4 input after averaging and windowing. Phase-level questionnaires require one unique finite response per participant-phase.

**Shared statistical engines.** Mixed models use `nlme::lme` with REML (Pinheiro & Bates, 2000). Multiple testing uses Benjamini–Hochberg false discovery rate (FDR) within declared families at $q < 0.05$ (Benjamini & Hochberg, 1995): for ordered raw $p$-values $p_{(1)} \le \cdots \le p_{(m)}$, the FDR-adjusted $q$-values are

$$
q_{(k)} = \min_{\ell \ge k}\!\left(\frac{m}{\ell}\,p_{(\ell)},\,1\right)
$$

(`p.adjust(..., method = "BH")`), where $m$ is the family size, $k = 1,\ldots,m$, and $\ell$ runs over ranks at or above $k$. H1/H3 effect sizes on phase-mean contrasts: bias-adjusted paired standardized mean difference (SMD; Bonett, 2008) via `statpsych::ci.stdmean.ps` on participant-phase means in analysis units,

$$
SMD
=
\frac{\bar{Y}_{C}-\bar{Y}_{R}}{\sqrt{(s_{C}^{2}+s_{R}^{2})/2}}
$$

where $C$ and $R$ are the comparison and reference PhaseID arms, $\bar{Y}_{C}$ and $\bar{Y}_{R}$ their means, and $s_{C}$ and $s_{R}$ the corresponding sample standard deviations (bias-adjusted estimate and CI from `ci.stdmean.ps`). Temporal H1/H3 and all H4 fits use AR(1) residuals within bout (Pinheiro & Bates, 2000):

$$
\varepsilon_{ijt} = \phi\,\varepsilon_{ij,t-1} + \eta_{ijt}
$$

where $\phi$ is the autoregressive coefficient and $\eta_{ijt}$ is white noise (`corAR1`; H1/H3 on `time_*_step | ParticipantID/PhaseID`; H4 on `Time10 | ParticipantID/PhaseID`).

---

## Hypothesis 1 — green versus urban

**Question.** Do green-park phases differ from urban-corridor phases within the same mobility mode?

Primary model (26 physiological outcomes; participant-phase means; `H1_PhaseMean_Primary_LMM`):

$$
Y_{ij} = \beta_0 + \beta_j + u_i + \varepsilon_{ij},\qquad
u_i \sim \mathcal{N}(0,\sigma_u^2),\quad \varepsilon_{ij} \sim \mathcal{N}(0,\sigma^2)
$$

Here $Y_{ij}$ is the physiological phase mean for participant $i$ in PhaseID $j$; $i$ indexes participants (`ParticipantID`); $j$ indexes the four core PhaseID cells (one mean per participant × phase; at most $11 \times 4 = 44$ rows); $\beta_0$ is the intercept; $\beta_j$ are fixed effects for the four-level PhaseID factor (treatment coding; `CORE_PHASES` / `PAPER3_CORE_PHASES` order starts at BikeU as reference); $u_i$ is the participant random intercept; and $\varepsilon_{ij}$ is the residual. Equivalent R form: `lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID)` — no nested phase random effect at this grain (one observation per $i,j$).

Planned simple contrasts (comparison − reference): **H1.1** BikeG − BikeU; **H1.2** WalkG − WalkU (estimated marginal means; Lenth, 2023). Sensitivity: same contrasts on phase means of the within-participant z-scored (WPZ) 10 s series (`H1_PhaseMean_Sensitivity_WPZ_LMM`; Ben-Shakhar, 1985). Temporal sensitivity (`H1_Temporal_AR1_*`): outcome $Y_{ijt}$ is the WPZ series at 10 s epoch $t$ within bout. The R interaction `PhaseID * time_min` expands to PhaseID main effects, a common time slope, and PhaseID × time interactions:

$$
Y_{ijt}
=
\beta_0 + \beta_j + \gamma\, t_{ijt} + \delta_j\, t_{ijt}
+ u_i + \varepsilon_{ijt}
$$

where $t_{ijt}$ is elapsed time within bout in minutes (script column `time_min`); $\gamma$ is the common time slope; $\delta_j$ are PhaseID-specific time interactions; and $\varepsilon_{ijt}$ follows AR(1) within `ParticipantID/PhaseID` (random intercept on $i$ only; Pinheiro & Bates, 2000). Difference-of-differences on the 2×2 layout is reported alongside planned contrasts: (BikeG − BikeU) − (WalkG − WalkU). FDR families: H1 primary and H1 WPZ (26 outcomes × 2 contrasts within each). Contextual urban-nature walking evidence informing the contrast design includes Gidlow et al. (2016) and Hunter et al. (2019); restorative-framework background includes Kaplan (1995).

---

## Hypothesis 2 — psychophysiological concordance

**Question.** Across the four core phases, do within-person associations between physiological phase means and end-of-phase questionnaire scores share direction?

Model (Bakdash & Marusich, 2017, rmcorr implementation; `H2_rmcorr`). Let $Q_{ij}$ be the questionnaire score and $P_{ij}$ the physiological phase mean for participant $i$ in PhaseID $j$ (participant-phase means — the same bout grain as H1/H3 means, not 10 s epochs):

$$
Q_{ij} = \alpha_i + \beta \, P_{ij} + \varepsilon_{ij}
$$

Here $\alpha_i$ are participant fixed intercepts (R: `ParticipantID` as a factor); $\beta$ is the common within-person slope; and $\varepsilon_{ij}$ is the residual. Equivalent R form: `lm(psychological ~ ParticipantID + physiological, data = participant_phase_means)`. Inputs are participant-phase means (HRV log transforms already applied). Family: **4 questionnaires × 26 physiological outcomes = 104 pairs**, one BH-FDR family. Partial within-person correlation $r$ from the physiological $t$-statistic and residual degrees of freedom $\nu$ (`H1_H3_core.R`):

$$
r = \operatorname{sign}(t)\sqrt{\frac{t^{2}}{t^{2}+\nu}},\qquad
z = \operatorname{atanh}(r),\quad
z \pm \frac{1.96}{\sqrt{\nu-1}}
$$

then back-transform with $\tanh$ for the 95% CI (Bakdash & Marusich, 2017). Literature expected signs for positive/restorative states are attached in the H2 output dictionary (sympathetic indicators expected negative with comfort/PRS; parasympathetic HRV expected positive; skin temperature and many ocular metrics context-dependent; see `H1_H3_core.R` `LIT` table and Cuve et al., 2023). Questionnaires are not modelled as 10-second repeated H4-style outcomes under this hypothesis.

---

## Hypothesis 3 — walking versus cycling

**Question.** Do walking phases differ from cycling phases within the same environment?

Primary model (`H3_PhaseMean_Primary_LMM`; identical shell to H1):

$$
Y_{ij} = \beta_0 + \beta_j + u_i + \varepsilon_{ij},\qquad
u_i \sim \mathcal{N}(0,\sigma_u^2),\quad \varepsilon_{ij} \sim \mathcal{N}(0,\sigma^2)
$$

Symbols match H1: $Y_{ij}$ is the physiological phase mean for participant $i$ in PhaseID $j$; $\beta_j$ are PhaseID fixed effects; $u_i$ is the participant random intercept. emmeans extracts **H3.1** WalkU − BikeU and **H3.2** WalkG − BikeG. WPZ sensitivity and temporal AR(1) specifications mirror H1 (`H3_PhaseMean_Sensitivity_WPZ_LMM`, `H3_Temporal_AR1_*`): for temporal models, $Y_{ijt}$ is again the WPZ series with $t$ indexing time within bout. FDR families: H3 primary and H3 WPZ, parallel to H1. Statistical citations are those of H1 (Pinheiro & Bates; Lenth; Bonett; Ben-Shakhar; Benjamini–Hochberg).

---

## Hypothesis 4 — noise amplification of thermal discomfort

**Question.** Within outdoor active travel, do thermal–physiology associations depend on acoustic level (and related co-exposures), consistent with noise/traffic amplifying thermal discomfort?

**Authoritative sources.** `Presentation material/H4_Selection_Flow.md`, `H4_Selection_Flow_explained.md`, `scripts/H4_time_series.R`, `scripts/H4_core.R`. **Data grain:** 10-second windows in the matched 8-minute file for the 11 × 4 core design. **Flag:** `H4_SPEC$fit_sound_sensitivity = TRUE` in `H4_time_series.R` (Eq2 is fitted in Step 5 when this flag is `TRUE`). Competing heat or PM formulations never share one equation with the primary UTCI + PM2.5 specification. “Derived” status (e.g. UTCI, SVF, GVI) is never an inclusion or exclusion rule. Acute co-exposure of pollutants and noise is a motivating context (e.g. Biel et al., 2020); mixtures redundancy arguments for not co-entering overlapping derived exposures follow Zhu et al. (2024) and related screening notes.

The selection flow below is chronological: inventory → declared exposures → domain grouping with sound PCA inside Step 2 → seven equations and design VIF → exposure preparation → fit, FDR, and AR(1) structure.

### Step 1 — Inventory and declared exposures

The selection-flow inventory catalogues every column available to H4 by sensor family (UCM, Atmo raw/average, LYS1/LYS2/average, GVI imagery, SVF imagery, sound, solar, Empatica, eye-tracker, questionnaire, metadata/QC). The inventory accounts for candidates and non-candidates; it does not yet choose equation terms. Outcomes, demographics, clothing, GPS/QC, and movement fields remain for role assignment later.

Selection is **one row per exposure**, by sensor; UCM and Atmo are never merged into the same row.

| Sensor | Role in H4 | Chosen | How alternatives are handled |
|---|---|---|---|
| UCM | Primary heat (Eq 1, 6, 7) | `ucm_UTCI` | Not co-entered with PET, HUMIDEX, OPT, or Eq3 components |
| UCM | Heat sensitivity (Eq 5) | `ucm_PET` | Separate equation only |
| UCM | Heat sensitivity (Eq 4) | `ucm_HUMIDEX` | Separate equation only |
| UCM | Heat sensitivity (Eq 3) | `ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_WIND_AWS` | Height tiers, AH, TWS/direction not co-entered |
| UCM | Hypothesis moderator | `ucm_SND_dBA` | Extra frequency/semantic fields only in Eq 2 |
| UCM | Covariates | `ucm_MRT`, `ucm_SUN_Gh` | IR / MRT S / clearness / solar geometry not co-entered |
| Atmo | Primary pollution | `atmo_pm2.5_avg` | Raw left/right not co-entered with average |
| Atmo | PM size (Eq 6 / 7) | `atmo_pm1_avg` / `atmo_pm10_avg` | Separate equations; not co-entered with each other or PM2.5 |
| LYS | Covariates | `lys_lux_avg`, `lys_kelvin_avg` | Categories and medi not used; raw LYS1/LYS2 not co-entered with averages |
| SVF imagery | Covariate | `SVF` (Holmer) | Scene % / TVF / BVF not co-entered as substitutes |
| GVI imagery | Covariate | `gvi_50m` | Other buffers/components/phase means not co-entered |

Rules when a column is not entered: same construct already represented; alternate heat/PM formulation reserved for its own equation; bilateral aggregation replaces raw channels; not an H4 exposure (outcome, QC, metadata, movement); Eq2-only / model scope; measurement suitability (no calibrated continuous H4 exposure); or PCA-informed Eq2 candidate (next step). Compact exclusions include AH → AIR RH; AIR T bot/mid/top → AIR temp; `*_SR` / MRT S → unsuffixed measures; IR planes → MRT; OPT not co-entered with AIR temp + MRT; wind direction/TWS → AWS; clearness indices → SUN Gh; GVI components/phase means → `gvi_50m`; SVF scene % → Holmer SVF; Atmo T/RH → UCM AIR; Empatica/eye-tracker and questionnaires as outcomes, not predictors.

### Step 2 — Domain grouping and PCA-informed sound structure

Core physical candidates for equation assembly group as: thermal components (`ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_WIND_AWS`); heat indices (`ucm_HUMIDEX`, `ucm_PET`, `ucm_UTCI`); acoustic level (`ucm_SND_dBA`) plus Eq2 sound structure; radiation / sky (`ucm_MRT`, `ucm_SUN_Gh`, `SVF`); pollution (`atmo_pm1_avg`, `atmo_pm2.5_avg`, `atmo_pm10_avg`); light (`lys_lux_avg`, `lys_kelvin_avg`); greenery (`gvi_50m`).

**Sound PCA (only account in this chapter).** Script: `scripts/Normalization & Parameter Screening/PCA-informed_sound_frequency.py`. Report: `Presentation material/Sound_screening_pca_vif.md`. Constants: `VARIANCE_TARGET = 0.80`, `MIN_PCS_B4 = 10`, `VIF_THRESHOLD = 5.0`.

Scope: 11 participants × 4 core phases; windows with elapsed time from bout start under 480 s; documented complete-case count **2,111 / 2,112** outdoor windows. **32 numeric sound fields** enter within-bout standardized correlation PCA (`PCA_COLUMNS`), including calibrated `ucm_SND_dBA`, frequency/spectral descriptors, and semantic score/proportion pairs. Excluded before PCA: nominal `category` and diagnostic `unidentify_prop`. For each numeric input, subtract the participant-phase mean, then divide by the pooled within-bout SD (`standardized_matrix`) — the same within-bout centering logic later used for H4 exposures, applied here to the sound block.

Jolliffe (2002) describes selecting a cumulative proportion of total variance in the range **70–90%** as a standard, albeit subjective, procedure for deciding how many principal components to retain, and notes that **80%** is frequently used as a practical baseline in applied work. This project implements that baseline explicitly (`VARIANCE_TARGET = 0.80`). King & Jackson (1999) evaluated cumulative-variance criteria including **80%** and **90%** in environmental applications; Jolliffe & Cadima (2016) review standardized PCA practice. On the locked merge, the **80% rule alone** retains **9 PCs** (cumulative **81.155%**); the code then applies $k = \max(k_v, 10)$, where $k_v$ is the count meeting the 80% variance target and 10 is `MIN_PCS_B4`, so operational retention is **10 PCs** (cumulative **84.037%**). PCA is correlation-PCA on the within-bout standardized matrix (`sklearn.decomposition.PCA`). Component signs are oriented so the largest absolute loading is positive. Leave-one-participant-out refits check subspace stability for the retained $k$.

For each retained PC, one distinct original column is chosen by largest absolute loading among columns not already selected (Jolliffe B4-style sequential representatives; `representatives()` in the script). The resulting **ten candidates**, locked as `H4_EQ2_SOUND_MAIN_TERMS` in `H4_time_series.R`, are:

`freq_prop_20_125`, `urban_manmade_positive_prop`, `vehicle_prop`, `wind_prop`, `freq_prop_8000_20000`, `mechanisms_prop`, `octave_prop_125_0_hz`, `urban_manmade_neutral_prop`, `freq_prop_4000_8000`, `dominant_frequency_hz`

Low-frequency (20–125 Hz) and mid-high band sensitivity motivate retaining frequency structure alongside overall level (Hamida et al., 2024). PCA nominates candidates; it does not replace `ucm_SND_dBA` in heat × sound interactions. Original columns do not inherit PC explained-variance percentages. Overlapping spectral/category representations remain a limitation of the sound block. Sound-only maximum VIF among these ten: **2.11** (none exceed VIF 5; none removed). When the same ten mains are co-entered with the Eq1 fixed-effect design, maximum design VIF is **3.092** (full rank; no VIF removals). Collinearity screening after PCA uses the project VIF rule stated in the next step (Dormann et al., 2013).

### Step 3 — Seven equations and design VIF

All seven formulas are defined as `nlme::lme` quotes in `H4_time_series.R`. Each equation includes phase sum-to-zero contrasts `PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG` (BikeU implicit). In R, `A * B` expands to main effects of A and B plus the A:B interaction.

| Equation | Role | Maximum design VIF |
|---|---|---|
| Eq 1 | Primary: UTCI × SND_dBA + MRT × SND_dBA + SUN_Gh + SVF + PM2.5 + lux + kelvin + GVI | 3.07 |
| Eq 2 | Sound sensitivity: Eq 1 + ten PCA-selected sound mains | 3.09 |
| Eq 3 | Heat sensitivity: AIR_temp × SND + AIR_RH × SND + WIND_AWS × SND + MRT × SND + shared covariates | 2.55 |
| Eq 4 | Heat sensitivity: HUMIDEX × SND + MRT × SND + shared covariates | 2.50 |
| Eq 5 | Heat sensitivity: PET × SND + MRT × SND + shared covariates | 3.02 |
| Eq 6 | PM size: UTCI × SND + MRT × SND + PM1 + shared non-PM covariates | 3.06 |
| Eq 7 | PM size: UTCI × SND + MRT × SND + PM10 + shared non-PM covariates | 3.07 |

**General LMM (Eqs 1–7 share nesting).** For the 10 s physiological outcome $Y_{ijt}$ (`H4_time_series.R` / `H4_core.R`):

$$
Y_{ijt} = x_{ijt}^{\top}\beta + u_i + v_{ij} + \varepsilon_{ijt}
$$

Here $i$ indexes participants (`ParticipantID`); $j$ indexes PhaseID; $t$ indexes the 10 s epoch within bout (`Time10`); $x_{ijt}$ is the fixed-effect design row for that equation; $\beta$ the corresponding coefficients; $u_i$ and $v_{ij}$ are nested random intercepts (`random = ~ 1 | ParticipantID / PhaseID`); and $\varepsilon_{ijt}$ follows AR(1) within bout as above (`corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID)`, REML; Pinheiro & Bates, 2000). Eqs 2–7 keep this random/AR(1) structure and change only the contents of $x_{ijt}$.

**Equation 1 (primary) — contents of $x_{ijt}$.** Predictors are Step-4 centered/scaled exposures (script column names in parentheses). In R, `A * B` expands to main effects of A and B plus the A:B interaction:

- UTCI (`ucm_UTCI`) and calibrated sound level (`ucm_SND_dBA`), plus UTCI × sound
- Mean radiant temperature (`ucm_MRT`), plus MRT × sound
- Global horizontal irradiance (`ucm_SUN_Gh`)
- Sky view factor (`SVF`)
- PM2.5 (`atmo_pm2.5_avg`)
- Light: lux and kelvin averages (`lys_lux_avg`, `lys_kelvin_avg`)
- Green view index (`gvi_50m`)
- Phase sum-to-zero contrasts: WalkG, WalkU, BikeG (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit)

R quote (`Eq1`):

```text
Y ~ ucm_UTCI * ucm_SND_dBA + ucm_MRT * ucm_SND_dBA + ucm_SUN_Gh + SVF
    + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m
    + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG
```

**Equation 2** (`fit_sound_sensitivity = TRUE`): Eq1 plus the ten Step-2 sound mains. Original heat × sound and MRT × sound interactions remain; Eq2 does not replace `ucm_SND_dBA`. Equations 3–7 are as quoted in `H4_time_series.R` (Eq3 air/RH/wind; Eq4 HUMIDEX; Eq5 PET; Eq6 PM1; Eq7 PM10).

**VIF rule.** Design screening uses variance inflation factor (VIF) threshold **5** (`H4_SPEC$vif_threshold = 5`; `VIF_THRESHOLD = 5.0` in the sound PCA script). Ordinary VIF for a single-df continuous term $k$, and Fox & Monette (1992) generalized VIF (GVIF) for multi-df blocks (via `car::vif`):

$$
VIF_k = \frac{1}{1-R_k^{2}},\qquad
VIF^{*} = GVIF^{1/d}
$$

where $R_k^{2}$ is the coefficient of determination from regressing term $k$ on the other fixed effects, $d$ is the term degrees of freedom, and $VIF^{*}$ is the Fox–Monette equivalent VIF used for multi-df blocks. Locked decision rule (`documents/data_validation.md`): VIF under 5 pass / VIF ≥ 5 fail for joint co-exposure estimability ($VIF^{*}$ compared to 5). Flags do **not** trigger automatic predictor deletion in the current H4 pipeline; outcome-specific rank/VIF preflight can block a fit. O’Brien (2007) is the project’s foundational caution against treating any VIF cutoff as an automatic validity test; Dormann et al. (2013) support combining subject knowledge with collinearity diagnostics; Zuur et al. (2010) describe iterative VIF removal as a related (but not identical) workflow used in earlier screening comparisons. All seven equation design maxima above are under 5.

### Step 4 — Exposure preparation (centering, scaling, interactions)

Implemented in `h4_step4_exposure_prep()` in `H4_core.R`. For each continuous exposure: restrict to `H4_SPEC` participants and phases; apply frequency-domain HRV availability mask before fitting FD outcomes; ensure bilateral averages exist; optionally carry forward SVF endpoints within bout when coded; collect equation-eligible covariates. **Within-bout centering + common-SD scaling.** Let $x_{ijt}$ be a continuous exposure for participant $i$, PhaseID $j$, and epoch $t$ within bout. The scaled predictor is

$$
\tilde{x}_{ijt}
=
\frac{x_{ijt}-\bar{x}_{ij}}{s_{x}}
$$

where $\bar{x}_{ij}$ is the bout mean and $s_x$ is the pooled within-bout standard deviation of the centered values $\{x_{ijt}-\bar{x}_{ij}\}$ over all finite epochs (not person-specific SD from four phase means; not ordinary whole-sample z-scoring). Phase contrast indicators are not standardized. Means/SDs are computed before outcome-specific complete-case filtering, so scale is shared across equations. Thermal × sound (and MRT × sound) products are built from the centered/scaled columns (**center first, multiply second**). Lag-60 s exposure matrices match timestamps within bout (`stamp - 60`), not by row offset.

**Estimand.** Main effects are conditional on the interacting exposure at its bout mean. The specification estimates associations with **within-bout** exposure deviations; it does not by itself recover associations with between-bout mean differences. Phase fixed effects do not restore removed bout means. Methodological anchors for centering (not claimed as identical designs): Enders & Tofighi (2007); Curran & Bauer (2011). Interaction construction (center then multiply) is consistent with the lower-level interaction form discussed by Loeys et al. (2018).

### Step 5 — Outcomes, fitting, FDR, and pipeline

**Outcomes.** $Y_{ijt}$ denotes each of the 26 physiological 10 s series (13 Empatica + 13 eye-tracker), with the HRV log / native rules stated in the experimental frame.

**Model structure.** For each outcome × equation: `nlme::lme` with REML, nested random intercepts `(1 | ParticipantID / PhaseID)`, AR(1) residuals within bout (`Time10`), and cluster-robust CR2 standard errors (`clubSandwich`; Pustejovsky & Tipton, 2018; Tipton, 2015). Design VIF screening uses threshold 5 as above.

**Equation catalog vs fit.** All seven equations are always defined. Step 5 fits Eq2 only when `H4_SPEC$fit_sound_sensitivity` is `TRUE` (currently `TRUE` in `H4_time_series.R`). Coefficient artifacts from a six-equation run must not be treated as Eq2 results.

**FDR.** Benjamini–Hochberg per fixed-effect term within each equation across the 26 outcomes (`h4_1_publish_fits`; Benjamini & Hochberg, 1995). Primary q-value emphasis: thermal main effects and thermal × sound interactions. Eq2-only sound mains, when fitted, form a separate exploratory BH family. Lag-60 s heat (and heat × sound) sensitivity uses exposures shifted one epoch earlier and has its own BH family (`H4_lag60_sensitivity.csv`).

**Pipeline entry points (`H4_core.R`).** `h4_run_audit` → role/representation filtration and candidate CSV; `h4_step4_exposure_prep` → centering/scaling/design; `h4_fit` / `h4_run_models` → GVIF diagnostic, preflight, fits, publish; `h4_dispatch_run` → full pipeline. Fingerprints hash script + merge (+ audit CSV / spec) so a changed input cannot silently reuse an old run.

**Design notes (estimand, not filters).** Mode is absorbed into PhaseID sum-to-zero contrasts rather than a separate Bike/Walk fixed factor beside Environment. Broad Urban/Green labels are not added as covariates in primary H4 because the estimand decomposes environment into measured continuous exposures; an Environment-adjusted H4 would be a separately labelled sensitivity with its own VIF check. `PhaseID` is not a random effect at the phase-mean grain; at 10 s it appears in the nested random-intercept path.

**Historical note.** An earlier phase-mean co-exposure specification (`Outcome ~ Mode + centered UTCI + dBA + PM2.5 + logLux + GVI + (1|ID)`) and the associated VIF/GVI-removal audit in `documents/data_validation.md` describe a superseded H4 formulation. The authoritative equation set is Eqs 1–7 in `H4_time_series.R`. Legacy CSV coefficient tables that lack a current input hash or that predate the nested AR(1) specification are not reportable as current H4 findings.

**Pending items (selection-flow).** (i) Confirm whether inference targets within-bout fluctuations only, between-bout differences, or both. (ii) Complete-case filter that currently requires Eq2-only sound fields for other equations can drop observations unnecessarily — not resolved by a documented refit in the selection-flow update.

---

## Reproducibility paths

| Product | Path |
|---|---|
| Matched merge | `output/merged_all_11participants_8min.csv` |
| H1–H3 / H2 outputs | `output/statistical_analysis/results/` (and/or `output/statistical_analysis/` for older runs) |
| H4 work products | `output/statistical_analysis/results/H4_time_series/` (files `H4_time_series_*`; `scripts/H4_time_series.R`) and `output/statistical_analysis/results/H4_phase_average/` (files `H4_phase_average_*`; `scripts/H4_phase_average.R`) |
| H4 selection narrative | `Presentation material/H4_Selection_Flow.md`, `H4_Selection_Flow_explained.md` |
| Sound PCA/VIF | `Presentation material/Sound_screening_pca_vif.md` |
| Normalization votes | `Presentation material/Normalization_Transformation_results.md` |
| Variable audit history | `documents/data_validation.md` |
| Reference bibliography | `Presentation material/Reference Literature for all Paper3.md` |

Run metadata (MD5 of script + merge, fit counts, skips) should be taken from the manifest written by the analysis run being cited.

---

## Documented factual gaps

1. **Cohort exclusion protocol:** No dated QC/protocol document in-repo justifies omitting P2, P3, P5, P6, P7, and P18 from the locked 11-person set despite earlier coverage checks noting core-route data for some omitted IDs.
2. **H4 Eq2 fit artifacts vs flag:** `fit_sound_sensitivity` is `TRUE` in `H4_time_series.R`; coefficient tables and reports must be checked against a run executed under that flag before citing Eq2 results. This chapter does not invent those coefficients.
3. **H4 estimand clarification (pending):** whether inference targets within-bout fluctuations only, between-bout exposure differences, or both remains flagged; centering removes bout means from the exposure variation used in the slope.
4. **Complete-case filter side effect (pending):** preparation that requires Eq2-only sound fields for other equations can drop observations unnecessarily; not resolved by a documented refit in the selection-flow update.
5. **`Presentation material/Normalization_Process.md`:** empty; normalization facts were taken from the PCA script, `Normalization_Transformation_results.md`, and analysis scripts instead.
6. **Participant demographics for the thesis text** (e.g. sex ratio, mean age) appear in the manuscript outline but are not re-validated here against questionnaire exports.

---

## References

Bakdash, J. Z., & Marusich, L. R. (2017). Repeated measures correlation. *Frontiers in Psychology*, *8*, 456. https://doi.org/10.3389/fpsyg.2017.00456

Ben-Shakhar, G. (1985). Standardization within individuals: A simple method to neutralize individual differences in skin conductance. *Psychophysiology*, *22*(3), 292–299. https://doi.org/10.1111/j.1469-8986.1985.tb01603.x

Benjamini, Y., & Hochberg, Y. (1995). Controlling the false discovery rate: A practical and powerful approach to multiple testing. *Journal of the Royal Statistical Society: Series B*, *57*(1), 289–300. https://doi.org/10.1111/j.2517-6161.1995.tb02031.x

Biel, R., et al. (2020). Acute cardiovascular effects of air pollutants and noise. *Scientific Reports* (project PDF: `Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf`). https://doi.org/10.1038/s41598-020-73412-6

Bonett, D. G. (2008). Confidence intervals for standardized linear contrasts of means. *Psychological Methods*, *13*(2), 99–109. https://doi.org/10.1037/1082-989X.13.2.99

Bröde, P., et al. (2012). Deriving the operational procedure for the Universal Thermal Climate Index (UTCI). *International Journal of Biometeorology*, *56*, 481–494. https://doi.org/10.1007/s00484-011-0454-1

CityFeel / UCM backpack (2017). doi:10.1016/j.egypro.2017.07.427

Curran, P. J., & Bauer, D. J. (2011). The disaggregation of within-person and between-person effects in longitudinal models of change. *Annual Review of Psychology*, *62*, 583–619. https://doi.org/10.1146/annurev.psych.093008.100356

Cuve, H. C., et al. (2023). Coherence and divergence in autonomic–subjective affective space (project PDF under Experiment papers H2). 

Dormann, C. F., et al. (2013). Collinearity: A review of methods to deal with it and a simulation study evaluating their performance. *Ecography*, *36*(1), 27–46. https://doi.org/10.1111/j.1600-0587.2012.07348.x

Enders, C. K., & Tofighi, D. (2007). Centering predictor variables in cross-sectional multilevel models: A new look at an old issue. *Psychological Methods*, *12*(2), 121–138. https://doi.org/10.1037/1082-989X.12.2.121

Fox, J., & Monette, G. (1992). Generalized collinearity diagnostics. *Journal of the American Statistical Association*, *87*(417), 178–183. https://doi.org/10.1080/01621459.1992.10475190

Gidlow, C. J., et al. (2016). Where to put your best foot forward: Psycho-physiological responses to walking in natural and urban environments. (project PDF: `Experiment papers/...Gidlow et al 2016 - Walking Natural Urban Environments.pdf`).

Gong, F.-Y., Zeng, Z.-C., Zhang, F., Li, X., Ng, E., & Norford, L. K. (2018). Mapping sky, tree, and building view factors of street canyons in a high-density urban environment. *Building and Environment*, *134*, 155–167. https://doi.org/10.1016/j.buildenv.2018.02.042 (project PDF: `Experiment papers/SVF TVF BVF - Mapping sky, tree, and building view factors of street canyons in a high-density urban environment.pdf`).

Hamida, A., Eijkelenboom, A., & Bluyssen, P. M. (2024). Guidance to investigate university students’ bodily responses and perceptual assessments in sound exposure experiments. *Indoor Environments*. https://doi.org/10.1016/j.indenv.2024.100066

Holmer, B. (1992). A simple operative method for determination of sky view factors in complex urban canyons from fisheye photographs. *Meteorologische Zeitschrift*, *1*(5), 236–239. https://doi.org/10.1127/metz/1/1992/236 (implementation basis for CamUp annular VF; method string `Holmer_1992_Annular` in `compute_svf_camup.py`).

Hunter, R. F., et al. (2019). Urban nature experiences reduce stress. (project PDF under Experiment papers Statistics / Hunter et al 2019).

Jolliffe, I. T. (2002). *Principal Component Analysis* (2nd ed.). Springer.

Jolliffe, I. T., & Cadima, J. (2016). Principal component analysis: A review and recent developments. *Philosophical Transactions of the Royal Society A*, *374*(2065), 20150202. https://doi.org/10.1098/rsta.2015.0202

Kaplan, S. (1995). The restorative benefits of nature: Toward an integrative framework. *Journal of Environmental Psychology*, *15*(3), 169–182.

King, J. R., & Jackson, D. A. (1999). Variable selection in large environmental data sets using principal components analysis. *Environmetrics*, *10*(1), 67–77. https://doi.org/10.1002/(SICI)1099-095X(199901/02)10:1%3C67::AID-ENV336%3E3.0.CO;2-0

Laborde, S., Mosley, E., & Thayer, J. F. (2017). Heart rate variability and cardiac vagal tone in psychophysiological research — Recommendations for experiment planning, data analysis, and data reporting. *Frontiers in Psychology*, *8*, 213. https://doi.org/10.3389/fpsyg.2017.00213

Lenth, R. (2023). *emmeans: Estimated Marginal Means, aka Least-Squares Means*. R package. https://CRAN.R-project.org/package=emmeans

Loeys, T., Josephy, H., & Dewitte, M. (2018). More precise estimation of lower-level interaction effects in multilevel models. *Multivariate Behavioral Research*, *53*(5), 627–649. https://doi.org/10.1080/00273171.2018.1444975

O’Brien, R. M. (2007). A caution regarding rules of thumb for variance inflation factors. *Quality & Quantity*, *41*, 673–690. https://doi.org/10.1007/s11135-006-9018-6

Pinheiro, J. C., & Bates, D. M. (2000). *Mixed-Effects Models in S and S-PLUS*. Springer. https://doi.org/10.1007/b98882

Pustejovsky, J. E., & Tipton, E. (2018). Small-sample methods for cluster-robust variance estimation and hypothesis testing in fixed effects models. *Journal of Business & Economic Statistics*, *36*(4), 672–683.

Qiu, Y., et al. (2017). Automatic sky view factor estimation from street view photographs. (project PDF: `Experiment papers/SVF - Qiu et al 2017 - Automatic Sky View Factor Estimation from Street View Photographs.pdf`).

Task Force of the European Society of Cardiology and the North American Society of Pacing and Electrophysiology. (1996). Heart rate variability: Standards of measurement, physiological interpretation and clinical use. *Circulation*, *93*(5), 1043–1065.

Tipton, E. (2015). Small sample adjustments for robust variance estimation with meta-regression. *Psychological Methods*, *20*(3), 375–393.

Zhu, Y., et al. (2024). A review of common statistical methods for dealing with multiple pollutant mixtures and multiple exposures. (project PDF under Experiment papers H1 to H4 / Methodology).

Zuur, A. F., Ieno, E. N., & Elphick, C. S. (2010). A protocol for data exploration to avoid common statistical problems. *Methods in Ecology and Evolution*, *1*(1), 3–14. https://doi.org/10.1111/j.2041-210X.2009.00001.x
---
## Source: H4_Selection_Flow_explained.md
---

## STEP 1 — Inventory (230)


| UCM                                                                                                         | Atmo raw                                                                                                                        | Atmo average                                                | LYS1 raw                                                                                                                       | LYS2 raw                   | LYS average                                                                                                                | GVI imagery                                                                                                                | SVF imagery                 | Sound                                                                                                             | Solar                                                                              | Empatica                                                                                                                                                                                                                                                                                                                                        | Eye-tracker                                                                                                                                                                                                                                                                                                                                              | Questionnaire                                                                | Metadata / QC                                            |                                                                                                                                                                 |                                                                |                                                                                                                                                                                                                                                            |                                                                                                                                                                                                                                                      |                                                                                                                                                                                    |                                                                                                                                                                                                                                                |                                                                                                                                                                                                                                 |                                                                                                                                                                                                                                  |                   |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | -------------------------- | -------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| AIR RH AIR temp HUMIDEX MRT PET SND dBA SUN Gh UTCI WIND AWS AH AIR T bot AIR T mid AIR T top GPS speed kmh | HUMIDEX SR IO flag IR back IR down IR front IR left IR right IR spot gnd IR spot left IR spot right IR spot sky IR up MRT S OPT | PET SR SUN alt SUN az UTCI SR WIND AWA WIND TWD WIND TWS fp | left pm1 left pm10 left pm2.5 right pm1 right pm10 right pm2.5 left humidity left temperature right humidity right temperature | pm1 avg pm10 avg pm2.5 avg | LYS1 kelvin LYS1 lux LYS1 lux cat LYS1 b' LYS1 g' LYS1 medi LYS1 movement LYS1 r' LYS1 rgbb LYS1 rgbg LYS1 rgbir LYS1 rgbr | LYS2 kelvin LYS2 lux LYS2 lux cat LYS2 b' LYS2 g' LYS2 medi LYS2 movement LYS2 r' LYS2 rgbb LYS2 rgbg LYS2 rgbir LYS2 rgbr | kelvin avg lux avg medi avg | GVI 50m GVI grass 50m GVI phase mean GVI plant 50m GVI tree 50m Grass phase mean Plant phase mean Tree phase mean | SVF TVF BVF Building % Ceiling % Total Vegetation % Total Builtup % Grass % Plant % Sky % Tree % Wall % | band proportion 1000-4000 Hz band proportion 125-1000 Hz band proportion 20-125 Hz band proportion 4000-8000 Hz band proportion 8000-20000 Hz category dominant frequency (Hz) mechanisms prop mechanisms score octave proportion 1000 Hz octave proportion 125 Hz octave proportion 2000 Hz octave proportion 250 Hz octave proportion 31.5 Hz | octave proportion 4000 Hz octave proportion 500 Hz octave proportion 63 Hz octave proportion 8000 Hz rural natural prop rural natural score spectral centroid (Hz) spectral rolloff 85% (Hz) unidentify prop urban manmade negative prop urban manmade negative score urban manmade neutral prop urban manmade neutral score urban manmade positive prop | urban manmade positive score vehicle prop vehicle score wind prop wind score | Clearness Index Clearness Index G0 Clearness Index Infer | acc x acc y acc z eda phasic eda scl usiemens eda tonic heart rate hrv fd hf hrv fd hfnu hrv fd lf hrv fd lf hf ratio hrv fd lfnu hrv fd total power hrv fd vlf | hrv td rmssd hrv td sdnn met skin temperature vector magnitude | blink duration s distance from center eyelid aperture avg fixation duration s fixation rate gaze centrality gaze dispersion gaze velocity pupil change rate pupil diameter avg saccade amplitude saccade duration s saccade peak velocity stress composite | current comfort 1 7 environmental comfort mean 1 5 pleasantness 1 5 prs11 being away mean 1 5 prs11 coherence mean 1 5 prs11 fascination mean 1 5 prs11 scope mean 1 5 prs11 total mean 1 5 space familiarity 1 5 stai6 mean 1 5 thermal comfort 1 5 | Date Date (Atmo/LYS) Date (UCM) Date (eye) Datetime GPS HDOP GPS alt GPS hdg GPS lat GPS lon GPS speed valid sample count GVI match dist m HRV 5min available HRV 5min max gap (s) | HRV 5min removed pct HRV 5min segment end HRV 5min segment start HRV 5min valid rri count HRV 5min valid span (s) MAG hdg ParticipantID PhaseID SVF Frames In Window SVF Status age bike frequency | bmi category who bmi kg m2 clothing accessories clothing footwear clothing height raw clothing lower body clothing skin tone clothing upper body clothing weight raw commute modes daily walking end time s gender has children | height m nationality own bike for experiment participant id pct complete phase start offset s regular physical activity residence type residential area response index segment site familiarity 1 10 vision correction weight kg | years in brussels |


---


### H4 specification

**Hypothesis:** Noise and traffic amplify thermal discomfort.

**Primary model (Eq 1):** UTCI × sound, with MRT × sound, solar irradiance (SUN Gh), SVF, PM2.5, lux, kelvin, and GVI as covariates, plus phase sum-to-zero contrasts.

**Sensitivities:** alternate heat formulations (Eq 3–5), PM size (Eq 6–7), and optional Eq 2 sound block. Competing heat formulations are never co-entered in one equation.

Selection method: one row per exposure (not one bundled “heat” row), by sensor; then check design VIF/rank. *Available cols* are inventory names for that exposure; *Chosen* is what enters the equations. "Derived" only describes how a field is produced — it is never an inclusion or exclusion rule.

Equations live in `scripts/H4_time_series.R`.


### Declared exposures (by sensor)

One row per exposure. UCM and Atmo are never merged into the same row.


| Sensor | Role in H4 | Available cols | Chosen | How alternatives are handled |
| ------ | ---------- | -------------- | ------ | ---------------------------- |
| UCM | Primary heat (Eq 1, 6, 7) | UTCI; UTCI SR | **UTCI** | Not co-entered with PET, HUMIDEX, OPT, or Eq3 components |
| UCM | Heat sensitivity (Eq 5) | PET; PET SR | **PET** | Separate equation only |
| UCM | Heat sensitivity (Eq 4) | HUMIDEX; HUMIDEX SR | **HUMIDEX** | Separate equation only |
| UCM | Heat sensitivity (Eq 3) | AIR temp; AIR T bot; AIR T mid; AIR T top | **AIR temp** | Height tiers not co-entered |
| UCM | Heat sensitivity (Eq 3) | AIR RH; AH | **AIR RH** | AH not co-entered |
| UCM | Heat sensitivity (Eq 3) | WIND AWS; WIND TWS; WIND AWA; WIND TWD | **WIND AWS** | TWS / direction not co-entered |
| UCM | Not entered | OPT | — | Operative temperature not co-entered with AIR temp + MRT |
| UCM | Hypothesis moderator | SND dBA; band proportion 1000-4000 Hz; band proportion 125-1000 Hz; band proportion 20-125 Hz; band proportion 4000-8000 Hz; band proportion 8000-20000 Hz; category; dominant frequency (Hz); mechanisms prop; mechanisms score; octave proportion 1000 Hz; octave proportion 125 Hz; octave proportion 2000 Hz; octave proportion 250 Hz; octave proportion 31.5 Hz; octave proportion 4000 Hz; octave proportion 500 Hz; octave proportion 63 Hz; octave proportion 8000 Hz; rural natural prop; rural natural score; spectral centroid (Hz); spectral rolloff 85% (Hz); unidentify prop; urban manmade negative prop; urban manmade negative score; urban manmade neutral prop; urban manmade neutral score; urban manmade positive prop; urban manmade positive score; vehicle prop; vehicle score; wind prop; wind score | **SND dBA** | Extra frequency/semantic fields only in Eq 2 |
| UCM | Covariate | MRT; MRT S; IR back; IR down; IR front; IR left; IR right; IR spot gnd; IR spot left; IR spot right; IR spot sky; IR up | **MRT** | IR channels and MRT S not co-entered |
| UCM | Covariate | SUN Gh; SUN alt; SUN az; Clearness Index; Clearness Index G0; Clearness Index Infer | **SUN Gh** | Clearness / solar geometry not co-entered |
| Atmo | Covariate (primary pollution) | left pm2.5; right pm2.5; pm2.5 avg | **pm2.5 avg** | Raw left/right not co-entered with average |
| Atmo | PM size sensitivity (Eq 6) | left pm1; right pm1; pm1 avg | **pm1 avg** | Separate equation; not co-entered with PM2.5/PM10 |
| Atmo | PM size sensitivity (Eq 7) | left pm10; right pm10; pm10 avg | **pm10 avg** | Separate equation; not co-entered with PM2.5/PM1 |
| Atmo | Not entered | left temperature; right temperature | — | Use UCM AIR temp (separate sensor row) |
| Atmo | Not entered | left humidity; right humidity | — | Use UCM AIR RH (separate sensor row) |
| LYS | Covariate | LYS1 lux; LYS2 lux; LYS1 lux cat; LYS2 lux cat; lux avg | **lux avg** | Categories not used; raw LYS1/LYS2 not co-entered with average |
| LYS | Covariate | LYS1 kelvin; LYS2 kelvin; kelvin avg | **kelvin avg** | Raw LYS1/LYS2 not co-entered with average |
| LYS | Not entered | LYS1 medi; LYS2 medi; medi avg | — | Not used as H4 light exposure |
| SVF imagery | Covariate | SVF; TVF; BVF; Building %; Ceiling %; Total Vegetation %; Total Builtup %; Grass %; Plant %; Sky %; Tree %; Wall % | **SVF (Holmer)** | Scene % / TVF / BVF not co-entered as SVF substitutes |
| GVI imagery | Covariate | GVI 50m; GVI grass 50m; GVI phase mean; GVI plant 50m; GVI tree 50m; Grass phase mean; Plant phase mean; Tree phase mean | **GVI 50m Buffer** | Other buffers/components/phase means not co-entered |


**Rules used when a column is not entered**


| Rule                            | Meaning                                                                                          |
| ------------------------------- | ------------------------------------------------------------------------------------------------ |
| Same construct, not co-entered  | Another retained field already represents this exposure (or is a deterministic transform of it). |
| Alternate heat / PM formulation | Valid for H4, but only in its own equation.                                                      |
| Aggregation                     | Raw bilateral channels replaced by the declared average.                                         |
| Not an H4 exposure              | Outcome, QC, metadata, movement, or undocumented field.                                          |
| Eq2-only / model scope          | Outside the primary equation; optional sensitivity only.                                         |
| Measurement suitability         | No calibrated continuous H4 exposure declared.                                                   |
| PCA-informed (Eq 2)             | Sound sensitivity candidate list; see [Sound_screening_pca_vif.md](Sound_screening_pca_vif.md).  |


---

## STEP 2 — Domain grouping (16 core candidates + 10 Eq2 sound candidates)


| Thermal                  | Index            | Acoustic                                                                                                                                                                                                                           | Radiation      | Pollution                  | Light              | Greenery |
| ------------------------ | ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | -------------------------- | ------------------ | -------- |
| AIR temp AIR RH WIND AWS | HUMIDEX PET UTCI | SND dBA Eq2 additions: freq_prop_20_125, vehicle_prop, wind_prop, freq_prop_8000_20000, mechanisms_prop, octave_prop_125_0_hz, urban_manmade_neutral_prop, freq_prop_4000_8000, urban_manmade_positive_prop, dominant_frequency_hz | MRT SUN Gh SVF | pm1 avg pm2.5 avg pm10 avg | lux avg kelvin avg | GVI 50m  |


---



## STEP 3 — Equations + design VIF (7 equations)


| Equation                                                                                                                                                                                                                                                                  | Maximum VIF |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| Eq 1 (Primary Model): UTCI * Sound + MRT * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery)                                                                                                                                      | 3.07        |
| Eq 2 (Sound sensitivity): Eq 1 + `freq_prop_20_125` + `vehicle_prop` + `wind_prop` + `freq_prop_8000_20000` + `mechanisms_prop` + `octave_prop_125_0_hz` + `urban_manmade_neutral_prop` + `freq_prop_4000_8000` + `urban_manmade_positive_prop` + `dominant_frequency_hz` | 3.09        |
| Eq 3 (Heat sensitivity — air temp, RH, wind): air temp * Sound + RH * Sound + wind * Sound + MRT * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery)                                                                              | 2.55        |
| Eq 4 (Heat sensitivity — HUMIDEX): HUMIDEX * Sound + MRT * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery)                                                                                                                      | 2.50        |
| Eq 5 (Heat sensitivity — PET): PET * Sound + MRT * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery)                                                                                                                              | 3.02        |
| Eq 6 (PM size sensitivity — PM1): UTCI * Sound + MRT * Sound + solar irradiance + SVF (sky view) + PM1 + lux + kelvin (light) + GVI (greenery)                                                                                                                            | 3.06        |
| Eq 7 (PM size sensitivity — PM10): UTCI * Sound + MRT * Sound + solar irradiance + SVF (sky view) + PM10 + lux + kelvin (light) + GVI (greenery)                                                                                                                          | 3.07        |


Eq2 adds 10 sound main effects; original interactions and phase adjustment remain. The full design has been checked for all 26 outcome-specific samples. `scripts/H4_time_series.R` defines all seven equations; Step 5 fits Eq2 only when `H4_SPEC$fit_sound_sensitivity` is TRUE (default FALSE). Published fit artifacts remain from the last six-equation run until rerun.

Each fitted equation also includes phase sum-to-zero contrasts (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit) and nested random structure (see Step 5). In R formula notation, heat–sound interactions are written with `*` (e.g. `ucm_UTCI * ucm_SND_dBA`), which expands to main effects plus the product term.

**Eq2 sound note:** Within-participant-phase centering and unit-SD scaling precede PCA. B4 selection uses 10 PCs (84.04% cumulative; 80% rule alone → 9 PCs at 81.15%). Ten original-variable candidates; sound-only max VIF 2.11; full Eq1+10 mains max VIF 2.884–3.092; full rank; no VIF removals. Method: [Sound_screening_pca_vif.md](Sound_screening_pca_vif.md).

---



## STEP 4 — Centering, scaling, and interaction construction

All seven equation designs use the same exposure-preparation rule in `h4_step4_exposure_prep()` in `scripts/H4_core.R`. For each continuous exposure, subtract its mean within each participant-phase bout, then divide the deviations by their sample SD across the prepared analysis data. This is within-bout centering followed by common-SD scaling, rather than ordinary whole-sample z-scoring or a separate z-score within every bout. Phase contrast indicators are not standardized.

`Scaled exposure = (measurement - participant-phase mean) / SD of all available centered deviations for that exposure`

The means and SDs are calculated before outcome-specific complete-case filtering. Consequently, a variable uses the same scale across equations, but its mean and SD need not remain exactly zero and one in every fitted subset. Missing values are retained as missing during scaling.


| Temperature measurement | Participant-phase average | Centered temperature |
| ----------------------- | ------------------------- | -------------------- |
| 25 deg C                | 23 deg C                  | +2 deg C             |
| 32 deg C                | 30 deg C                  | +2 deg C             |


Both observations represent the same deviation from their bout average, despite their different absolute temperatures. Dividing by a common SD changes units; subtracting the bout mean changes the exposure variation used to estimate the association. Scaling does not make the data normally distributed or correct measurement error.

Thermal–sound interactions are products of the centered, scaled thermal and SND dBA columns (center first, multiply second). Their intended question is: **within a participant-phase, does the thermal–physiology association depend on sound being above or below that bout's usual level?** Main effects are conditional on the other interacting exposure being at its bout mean. Outcomes retain their measurement units, except the specified HRV outcomes receive a natural log (Step 5).

This specification does not directly estimate how differences in absolute average temperature and sound between bouts relate to physiology. Phase fixed effects do not restore the removed participant-phase exposure means. If H4 is intended to estimate within-bout and between-bout exposure associations, those components require explicit specification; ordinary z-scoring alone does not separate them.


| Reference                                                                                                                                                                       | What it supports                                                                                                                              | Limit of the comparison                                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Enders and Tofighi (2007), Centering Predictor Variables in Cross-Sectional Multilevel Models: A New Look at an Old Issue](https://doi.org/10.1037/1082-989X.12.2.121)         | Group-mean centering and the interpretation of within-cluster and between-cluster effects.                                                    | General methodological support; not a replication of this participant-phase design.                                                                               |
| [Curran and Bauer (2011), The Disaggregation of Within-Person and Between-Person Effects in Longitudinal Models of Change](https://doi.org/10.1146/annurev.psych.093008.100356) | Separating fluctuations within a person from differences in average exposure between people.                                                  | The participant-phase centering unit and common-SD scaling used here are study specifications.                                                                    |
| [Loeys, Josephy and Dewitte (2018), More Precise Estimation of Lower-Level Interaction Effects in Multilevel Models](https://doi.org/10.1080/00273171.2018.1444975)             | Equation 11 explicitly uses centered predictors and their product: center first, multiply second, matching the interaction construction here. | The paper also examines cluster means and cross-level interactions; the construction alone does not establish that omitting those components is appropriate here. |


The common-SD-scaled coefficients are changes in outcome units per common SD of exposure deviations, not average person-specific standardized effects or correlations. The exact nested random-effects and residual-correlation specification is not validated merely by citing a centering paper.

---



## STEP 5 — Outcomes, model fit, and FDR

**Outcomes (Y):** 26 physiological sensor time series at 10 s resolution — 13 Empatica and 13 eye-tracker columns (`H4_SPEC$outcomes$physiological` in `scripts/H4_time_series.R`). Questionnaire fields are psychological outcomes and are not entered as environmental predictors. Specified HRV frequency-domain outcomes are analyzed on the natural log scale; HRV time-domain and other outcomes use native units where applicable.

**Model structure:** For each outcome and equation, `nlme::lme` with REML, nested random intercepts `(1 | ParticipantID / PhaseID)`, and AR(1) residual correlation within bout (`Time10`). Inference uses cluster-robust CR2 standard errors (`clubSandwich`). Design VIF screening uses threshold 5; grouped VIF-equivalent maxima for fitted designs are reported in `H4_time_series_gvif_diagnostic.md` / `H4_time_series_Report.md`.

**Equation catalog vs default fit:** All seven equations are defined in `scripts/H4_time_series.R` (Eq1–Eq7 quotes). Step 5 fits Eq2 only when `H4_SPEC$fit_sound_sensitivity` is TRUE (default FALSE), so published coefficient tables may reflect six equations until a seven-equation rerun.

**FDR:** Benjamini–Hochberg adjustment is applied per fixed-effect term within each equation across the 26 outcomes (`h4_1_publish_fits` in `scripts/H4_core.R`). Primary q-values cover thermal main effects and thermal × sound interaction terms. Eq2-only sound main effects, when fitted, form a separate exploratory BH family across outcomes. Lag-60 s heat (and heat × sound) sensitivity uses exposures shifted one epoch earlier and has its own BH family (`H4_lag60_sensitivity.csv`).

**Deliverables:** `H4_time_series_Heat_Noise_Exposures.csv` and `H4_time_series_Covariates_and_Phases.csv`; full coefficient and status tables under `results/H4_time_series/` (`H4_time_series_coefficients.csv`, `H4_time_series_fit_status.csv`). The phase-average sensitivity has corresponding outputs under `results/H4_phase_average/` with the `H4_phase_average_` prefix (e.g. `H4_phase_average_coefficients.csv`). The phase-average run reuses the time-series Step 1–4 audit (`H4_time_series_Multivariate_Filtration_Results.csv`), so run `H4_time_series.R` first. Each folder has its own `H4_<variant>_Report.md` with sample sizes, fit counts and diagnostics.

**Pending specification checks:** Confirm whether H4 targets within-bout fluctuations, between-bout exposure differences, or both; review the treatment of interaction components accordingly. Also check the complete-case filter, which currently requires all selected exposures, including Eq2-only sound fields, for other equations — this can exclude observations unnecessarily. These issues have not been resolved or tested by refitting models as part of this diagram update.

---



## APPENDIX B — Fields not entered (by rule)

Compact audit of inventory fields that are not H4 environmental predictors. Reasons use the declared-exposure rule table only.

**Same construct, not co-entered**

- AH → humidity is AIR RH.
- AIR T bot / mid / top → air temperature is AIR temp.
- HUMIDEX SR, MRT S, PET SR, UTCI SR → unsuffixed UCM measures.
- IR channels → MRT.
- OPT → not co-entered with air temperature and MRT.
- WIND TWS, WIND AWA, WIND TWD → wind speed is WIND AWS.
- Clearness Index, Clearness Index G0, Clearness Index Infer → solar is SUN Gh.
- GVI grass/plant/tree / phase means → greenery is GVI 50m.
- SVF scene percentages → sky openness is SVF Holmer.
- Atmo left/right humidity and temperature → UCM AIR RH / AIR temp.
- lux cat → continuous lux.
- medi (raw and avg) → not used; light representatives are lux avg and kelvin avg.

**Aggregation**

- Atmo left/right PM1/PM2.5/PM10 → pm1/pm2.5/pm10 avg.
- LYS1/LYS2 kelvin and lux → kelvin avg, lux avg.

**Alternate heat / PM formulation**

- AIR temp, AIR RH, WIND AWS, HUMIDEX, PET, PM1, PM10 — retained as candidates; enter only via Eq 3–7, not beside UTCI+PM2.5 in Eq 1.

**Eq2-only / model scope**

- Ten PCA-selected sound fields (Eq 2 only); other numeric sound fields not selected by that rule.
- GPS speed, LYS movement, Empatica movement/MET — movement, not environmental predictors.
- SUN alt, SUN az, IO flag, fp — outside declared H4 exposure set.

**Measurement suitability**

- LYS RGB / r'g'b' / IR export channels — no calibrated H4 average declared.

**Not an H4 exposure**

- Empatica and eye-tracker physiological/ocular series → outcomes (Y), not predictors.
- eda scl → input to phasic/tonic.
- stress composite → ocular composite, not an environmental predictor.
- Questionnaire comfort/PRS/STAI fields → psychological outcomes.
- All Date/GPS/QC/clothing/demographics/metadata fields → design or QC only.

---
## Source: Sound_screening_pca_vif.md
---

# Sound screening: family-wise PCA and VIF

**Status: done.** Family-wise PCA screening finished; Eq2 sound mains locked in `scripts/H4_time_series.R`. H4 already refit with these terms.

**Read these only** (live PCA folder is wiped each run):
1. This report - `Presentation material/Sound_screening_pca_vif.md`
2. PC check - `.../sound_pca_pc_check.csv` (every Family x PC x Term; `Is_representative=Yes` is the variable chosen for that PC; `Measure` is Loading or Correlation)
3. Terms table - `.../sound_pca_terms.csv` (one row = one PCA survivor; `Kept_in_Eq2=Yes` are the final Eq2 sound mains; `VIF_max_within_this_family_so_far` and `VIF_max_all_rows_above_so_far` are the two cumulative VIF columns)
4. Scree - `.../family_screes.png`
5. Biplots - `.../family_biplots.png` (bold = PCA survivor; boxed = Kept_in_Eq2)

**Eq2 sound mains (locked):** Eq1 + `vehicle_prop` + `freq_prop_20_125` + `wind_prop` + `spectral_centroid_hz` + `mechanisms_prop`. `ucm_SND_dBA` stays in heat x sound. Eqs 1 and 3-7 unchanged.

|   order | column               | family_label          |   PC |   loading_or_corr |   LOPO |
|--------:|:---------------------|:----------------------|-----:|------------------:|-------:|
|       1 | vehicle_prop         | YAMNet proportions    |    2 |             0.564 |  0.909 |
|       2 | freq_prop_20_125     | Broad frequency bands |    1 |             0.630 |  1.000 |
|       3 | wind_prop            | YAMNet proportions    |    3 |             0.746 |  1.000 |
|       4 | spectral_centroid_hz | Spectral descriptors  |    1 |             0.696 |  1.000 |
|       5 | mechanisms_prop      | YAMNet proportions    |    4 |             0.806 |  1.000 |

**VIF:** Eq2 sound-mains max 1.739; full Eq2 design max 2.990 on `ucm_UTCI` (n=2056; full_rank=True). Cutoff 5.

## Method (short)

11 participants, 44 bouts, windows < 480 s. Five family PCAs (YAMNet proportions, YAMNet scores, broad bands, octave bands, spectral descriptors). Within-bout center + pooled-SD scale. Broad bands use ILR when closed and positive; octave composition checked. Retain PCs >=80% variance (no minimum-PC floor). One original representative per PC; LOPO stability; then scientific slots + |r|>=0.7 / VIF prune to 3-5 terms. Excluded from PCA: `category`, `unidentify_prop`, `ucm_SND_dBA`.

## Family summary

| family                |   n | ILR   | PCs       | representatives                                                                                     | closed_composition   |
|:----------------------|----:|:------|:----------|:----------------------------------------------------------------------------------------------------|:---------------------|
| YAMNet proportions    |   7 | no    | 5 (88.6%) | `urban_manmade_positive_prop`, `vehicle_prop`, `wind_prop`, `mechanisms_prop`, `rural_natural_prop` | False                |
| YAMNet scores         |   7 | no    | 4 (85.3%) | `urban_manmade_positive_score`, `urban_manmade_negative_score`, `wind_score`, `mechanisms_score`    | False                |
| Broad frequency bands |   5 | yes   | 2 (84.4%) | `freq_prop_20_125`, `freq_prop_125_1000`                                                            | True                 |
| Octave bands          |   9 | no    | 4 (81.1%) | `octave_prop_2000_0_hz`, `octave_prop_125_0_hz`, `octave_prop_8000_0_hz`, `octave_prop_63_0_hz`     | False                |
| Spectral descriptors  |   3 | no    | 2 (95.0%) | `spectral_centroid_hz`, `dominant_frequency_hz`                                                     | False                |

## Why these five

- Slot traffic: keep vehicle_prop from YAMNet proportions PC2 (LOPO=0.91; scientific priority).
- Slot low_frequency: keep freq_prop_20_125 from Broad frequency bands PC1 (LOPO=1.00; scientific priority).
- Slot semantic_other: keep wind_prop from YAMNet proportions PC3 (LOPO=1.00; scientific priority).
- Slot spectral_shape: keep spectral_centroid_hz from Spectral descriptors PC1 (LOPO=1.00; scientific priority).
- Fill keep mechanisms_prop from YAMNet proportions PC4 (LOPO=1.00).

## Air-temperature alternatives (separate PCA)

Within-bout standardized correlation PCA on `ucm_AIR_temp`, `ucm_AIR_T_bot`, `ucm_AIR_T_top`, `ucm_AIR_T_mid`. Retain PCs to >=80% variance (no minimum-PC floor); one original representative per retained PC (largest |loading|).

**Result:** 1 PC(s), 88.75% cumulative; selected: `ucm_AIR_T_mid`.

Outputs (prefix `air_temp_`): `air_temp_pca_candidates.csv`, `air_temp_pca_variance_explained.csv`, `air_temp_pca_loadings.csv`, `air_temp_pca_scree.png`, `air_temp_pca_loadings_pc1_pc2.png`.

**References:** [Jolliffe & Cadima (2016)](https://doi.org/10.1098/rsta.2015.0202), [Egozcue et al. (2003)](https://doi.org/10.1023/A:1023818214614), [Dormann et al. (2013)](https://doi.org/10.1111/j.1600-0587.2012.07348.x).

Input: C:\Users\pandya\Documents\Github\docker\Paper3_Final\output\merged_all_11participants_8min.csv
SHA-256: `dbe5baa98ecddd311bb18c9710da2e7595a4a733e8866df9be2ad303c627746a`
---
## Source: Normalization_Transformation_results.md
---

# Normalization results

**Physiological transformations: verified references, not votes**

Citation repair: 20 October 2026. The existing CSV is authoritative for physiology: 41 fields, 27 reference-mapped measures and 13 verified full texts. Seven HRV log rules and all other model treatments are unchanged. The cited papers provide conditional transformation guidance or measurement context; counts are not endorsements of the selected transformation. Invalid/placeholder sources are excluded. The environmental sections below were not re-audited in this repair.

| Parameter | Current model transformation | References | Evidence status |
| --- | --- | --- | --- |
| Skin conductance level | Not applicable | [6], [7] | Not a fitted outcome; measurement context only |
| Skin conductance, phasic | No transformation | [6], [7] | Alternative transformations documented; native-scale choice not validated |
| Skin conductance, tonic | No transformation | [6], [7] | Alternative transformations documented; native-scale choice not validated |
| Heart rate | No transformation | [1], [2], [3] | Measurement/method context only; no direct endorsement of transformation choice |
| HF power | Natural log | [8], [9] | Conditional/general HRV rationale; current-model choice not validated |
| HF normalized | No transformation | [10], [8] | Quantity definition; no direct endorsement of transformation choice |
| LF power | Natural log | [8], [9] | Conditional/general HRV rationale; current-model choice not validated |
| LF/HF ratio | Natural log | [8], [9] | Conditional/general HRV rationale; current-model choice not validated |
| LF normalized | No transformation | [10], [8] | Quantity definition; no direct endorsement of transformation choice |
| Total power | Natural log | [8], [9] | Conditional/general HRV rationale; current-model choice not validated |
| VLF power | Natural log | [8], [9] | Conditional/general HRV rationale; current-model choice not validated |
| RMSSD | Natural log | [8], [9] | Conditional/general HRV rationale; current-model choice not validated |
| SDNN | Natural log | [8], [9] | Conditional/general HRV rationale; current-model choice not validated |
| Skin temperature | No transformation | [1], [4], [5] | Measurement/method context only; no direct endorsement of transformation choice |
| Blink duration | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Distance from center | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Eyelid aperture | No transformation | [11] | Measurement/method context only; no direct endorsement of transformation choice |
| Fixation duration | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Fixation rate | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Gaze centrality | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Gaze dispersion | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Gaze velocity | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Pupil change rate | No transformation | [11] | Measurement/method context only; no direct endorsement of transformation choice |
| Pupil diameter | No transformation | [11], [2] | Measurement/method context only; no direct endorsement of transformation choice |
| Saccade amplitude | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Saccade duration | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |
| Saccade peak velocity | No transformation | [11], [12], [13] | Measurement/method context only; no direct endorsement of transformation choice |

EDA native-scale choices still require outcome-specific diagnostics. HRV log guidance is conditional; eye-tracking sources do not establish that every derived metric needs no transformation. Full evidence notes and PDF pages are retained in Normalization_H1toH4_all_parameters.csv.

**Literature-based transformation voting (environment)**

Nonlinear exposure treatments from checked papers (`ENVIRONMENT_LITERATURE`). Centering/scaling is separate. Current H4 uses native scale for entered continuous channels unless noted in the complete mapping table.

| Exposure group   | Literature winner (nonlinear)                                                                                                                                                                 |   Winning paper count | Current H4 nonlinear rule              | Aligned                                          |
|:-----------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------:|:---------------------------------------|:-------------------------------------------------|
| Thermal          | Categorical experimental levels                                                                                                                                                               |                     5 | None; native scale                     | Partial — group-level; see per-parameter mapping |
| Pollution        | Natural log                                                                                                                                                                                   |                     8 | None; native scale (PM mass fractions) | Partial — group-level; see per-parameter mapping |
| Light            | Logarithmic predictor; exact bases and metrics differ by paper                                                                                                                                |                     5 | None; native scale (lux / Kelvin)      | Partial — group-level; see per-parameter mapping |
| Sound            | dBA-scale exposure without additional log specified; includes piecewise forms                                                                                                                 |                     5 | None; native dBA (no additional log)   | Partial — group-level; see per-parameter mapping |
| SVF / greenery   | Tie: Categorical low/medium/high levels; Linear association in primary abstract; preprocessing not verified; Multilevel regression / separate curvilinear assessment; log/logit not specified |                     1 | None; native bounded scale             | Partial — group-level; see per-parameter mapping |

| Exposure group   | Candidate treatment                                                               |   Paper count | Paper IDs                         | Is literature winner   |
|:-----------------|:----------------------------------------------------------------------------------|--------------:|:----------------------------------|:-----------------------|
| Thermal          | Categorical experimental levels                                                   |             5 | T2, T3, T4, T6, T7                | True                   |
| Thermal          | Spline exposure-response                                                          |             1 | T1                                | False                  |
| Thermal          | Z-score scaling                                                                   |             1 | T5                                | False                  |
| Pollution        | Natural log                                                                       |             8 | P1, P6, P7, P8, P9, P10, P13, P14 | True                   |
| Pollution        | Natural log; related particle-count metrics                                       |             3 | P9, P11, P12                      | False                  |
| Pollution        | Native-unit / IQR exposure reporting; exposure log not specified                  |             2 | P4, P5                            | False                  |
| Pollution        | Log base 10                                                                       |             1 | P2                                | False                  |
| Pollution        | Log base 5                                                                        |             1 | P1                                | False                  |
| Pollution        | No transformation explicitly stated                                               |             1 | P3                                | False                  |
| Light            | Logarithmic predictor; exact bases and metrics differ by paper                    |             5 | L4, L7, L8, L9, L10               | True                   |
| Light            | Categorical experimental levels                                                   |             2 | L1, L2                            | False                  |
| Light            | Log transformation (base not established in this review)                          |             2 | L4, L8                            | False                  |
| Light            | Categorical experimental levels; not continuous Kelvin                            |             1 | L6                                | False                  |
| Light            | Comparison of log/zero-handling methods; not one adopted predictor transformation |             1 | L3                                | False                  |
| Light            | Log base 10                                                                       |             1 | L7                                | False                  |
| Light            | Log transformation (not a physiological-predictor precedent)                      |             1 | L5                                | False                  |
| Sound            | dBA-scale exposure without additional log specified; includes piecewise forms     |             5 | S1, S3, S6, S7, S8                | True                   |
| Sound            | Categorical groups                                                                |             1 | S4                                | False                  |
| Sound            | Continuous dBA; additional exposure log not specified                             |             1 | S1                                | False                  |
| Sound            | Log base 10                                                                       |             1 | S2                                | False                  |
| Sound            | Piecewise linear dBA                                                              |             1 | S3                                | False                  |
| Sound            | Z-score scaling                                                                   |             1 | S5                                | False                  |
| SVF / greenery   | Categorical low/medium/high levels                                                |             1 | G5                                | False                  |
| SVF / greenery   | Linear association in primary abstract; preprocessing not verified                |             1 | G4                                | False                  |
| SVF / greenery   | Multilevel regression / separate curvilinear assessment; log/logit not specified  |             1 | G1                                | False                  |
| SVF / greenery   | Quadratic exposure-response                                                       |             1 | G3                                | False                  |
| SVF / greenery   | Z-score scaling                                                                   |             1 | G2                                | False                  |

**Environmental transformations**

| Group     | Parameter counted                                                   | Treatment in the papers                                                       |   Number of papers | Papers                       |
|:----------|:--------------------------------------------------------------------|:------------------------------------------------------------------------------|-------------------:|:-----------------------------|
| Thermal   | Air temperature                                                     | Categorical experimental levels                                               |                  5 | T2, T3, T4, T6, T7           |
| Pollution | Black carbon                                                        | Natural log                                                                   |                  7 | P1, P6, P7, P8, P9, P10, P14 |
| Pollution | PM2.5 as health predictor                                           | Natural log                                                                   |                  5 | P6, P7, P10, P13, P14        |
| Light     | Light exposure as health predictor (photopic and melanopic metrics) | Logarithmic predictor; exact bases and metrics differ by paper                |                  5 | L4, L7, L8, L9, L10          |
| Sound     | Noise level as predictor / covariate                                | dBA-scale exposure without additional log specified; includes piecewise forms |                  5 | S1, S3, S6, S7, S8           |

**Additional exact treatments and evidence gaps**

| Group          | Parameter counted                                  | Treatment in the papers                                                           |   Number of papers | Papers       |
|:---------------|:---------------------------------------------------|:----------------------------------------------------------------------------------|-------------------:|:-------------|
| Thermal        | Air temperature; RH                                | Spline exposure-response                                                          |                  1 | T1           |
| Thermal        | Temperature/environmental predictors               | Z-score scaling                                                                   |                  1 | T5           |
| Pollution      | UFP                                                | Log base 5                                                                        |                  1 | P1           |
| Pollution      | PM2.5; NOx                                         | Log base 10                                                                       |                  1 | P2           |
| Pollution      | PM2.5 / pollutant predictors                       | No transformation explicitly stated                                               |                  1 | P3           |
| Pollution      | PM2.5                                              | Native-unit / IQR exposure reporting; exposure log not specified                  |                  2 | P4, P5       |
| Light          | Illuminance                                        | Categorical experimental levels                                                   |                  2 | L1, L2       |
| Light          | Personal light exposure / melanopic EDI            | Comparison of log/zero-handling methods; not one adopted predictor transformation |                  1 | L3           |
| Light          | Illuminance as predictor                           | Log transformation (base not established in this review)                          |                  2 | L4, L8       |
| Light          | Illuminance as measured response                   | Log transformation (not a physiological-predictor precedent)                      |                  1 | L5           |
| Light          | Glazing colour                                     | Categorical experimental levels; not continuous Kelvin                            |                  1 | L6           |
| Sound          | Noise level                                        | Continuous dBA; additional exposure log not specified                             |                  1 | S1           |
| Sound          | Noise level                                        | Log base 10                                                                       |                  1 | S2           |
| Sound          | Noise level                                        | Piecewise linear dBA                                                              |                  1 | S3           |
| Sound          | Noise type                                         | Categorical groups                                                                |                  1 | S4           |
| Sound          | Noise/environmental predictors                     | Z-score scaling                                                                   |                  1 | S5           |
| SVF / greenery | SVF; GVI                                           | Multilevel regression / separate curvilinear assessment; log/logit not specified  |                  1 | G1           |
| SVF / greenery | Vegetation; sky visibility; NDVI                   | Z-score scaling                                                                   |                  1 | G2           |
| SVF / greenery | Tree-cover percentage                              | Quadratic exposure-response                                                       |                  1 | G3           |
| SVF / greenery | Tree-cover percentage                              | Linear association in primary abstract; preprocessing not verified                |                  1 | G4           |
| SVF / greenery | SVF; GVI                                           | Categorical low/medium/high levels                                                |                  1 | G5           |
| Pollution      | UFP / particle-number exposure as health predictor | Natural log; related particle-count metrics                                       |                  3 | P9, P11, P12 |
| Light          | Melanopic EDI / photopic illuminance as predictor  | Log base 10                                                                       |                  1 | L7           |

Counts refer to the treatment of the named environmental parameter, not to transformations of HRV or other outcomes. Z-score scaling, exposure-response shape, categorical coding and logarithms are kept separate. A paper may contribute to more than one parameter row; counts must not be summed as unique papers. IDs link these counts to the paper-by-paper tables below.

**Current environmental treatment and literature interpretation**

| Group          |   Papers reviewed | Literature finding                                                                                                                                             | Current H4                                                                     |
|:---------------|------------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------|
| Thermal        |                 7 | Temperature splines, experimental levels and z-scores are all used. These papers do not establish one rule for every heat index, wind or radiation channel.    | Native units, then within-bout centering / pooled-SD scaling for entered terms |
| Pollution      |                14 | Native PM exposure / IQR reporting and selected pollutant logs both occur; logging an HRV outcome is not logging its PM predictor.                             | Native PM, then within-bout centering / pooled-SD scaling                      |
| Light          |                10 | Continuous log-lux and categorical illuminance designs both occur. Evidence for log-lux does not establish log-Kelvin or log-RGB transformations.              | Native lux and Kelvin, then within-bout centering / pooled-SD scaling          |
| Sound          |                 8 | Studies use dBA, piecewise dBA, log10 noise, standardized exposures or sound-type groups. These are not validations of all YAMNet / frequency transformations. | dBA and selected sound descriptors centered within bout and pooled-SD scaled   |
| SVF / greenery |                 5 | Published models use standardized visual indicators, linear or quadratic tree cover, and categorical SVF/GVI scenarios; no universal logit rule follows.       | Native bounded exposures, then within-bout centering / pooled-SD scaling       |

These are group-level reviewed-paper counts, not votes for one transformation or five exact-method endorsements for every raw channel. Full-text methods were checked where available; the Jiang 2016 entry is explicitly abstract-only. Current H4 transformations are unchanged. Five-paper support is now documented for temperature condition comparisons, natural-log PM2.5, natural-log black carbon, logarithmic light predictors and dBA-scale noise predictors. Exact log bases, photopic versus melanopic light, and linear versus piecewise dBA are identified per paper; these are not five replications of the full H4 method. Other exact treatments remain below five and are listed separately. Black-carbon and particle-number studies are related evidence, not substitutes for PM1/PM2.5/PM10 evidence.

**Thermal: checked papers**

| ID   | Paper                                                                                                                                                                                  | Parameters                            | Reported treatment                                                                                                                           | Scope / limitation                                                                                                   | Checked source                                                                                                        |
|:-----|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------|
| T1   | [Madaniyazi et al. (2016): Outdoor Temperature, Heart Rate and Blood Pressure in Chinese Adults: Effect Modification by Individual Characteristics](https://doi.org/10.1038/srep21003) | Air temperature; RH                   | Temperature modelled with a natural cubic spline (3 df); RH with a cubic spline (4 df).                                                      | Nonlinear exposure-response precedent; not support for a mandatory temperature logarithm.                            | Local PDF, p.7, Statistical analysis; publisher full text.                                                            |
| T2   | [Chinazzo et al. (2019): Daylight affects human thermal perception](https://doi.org/10.1038/s41598-019-48963-y)                                                                        | Temperature; daylight levels          | Three designed temperature levels and three daylight conditions entered as experimental fixed factors, including their interaction.          | Factor-level experiment; not evidence for logging continuous temperature or lux.                                     | Local PDF, pp.5-6, Data processing and statistical analyses.                                                          |
| T3   | [Chinazzo et al. (2020): Influence of indoor temperature and daylight illuminance on visual perception](https://doi.org/10.1177/1477153519859609)                                      | Temperature; daylight levels          | Three temperature and three illuminance levels analysed as experimental factors; deviations from designed conditions included as covariates. | Level comparisons differ from continuous within-bout exposure slopes.                                                | Local PDF, pp.7-8, analysis methods; publisher record.                                                                |
| T4   | [Chinazzo et al. (2020): Effect of Indoor Temperature and Glazing with Saturated Color on Visual Perception of Daylight](https://doi.org/10.1080/15502724.2020.1726182)                | Temperature; glazing colour           | Temperature and glazing colour explicitly treated as categorical fixed factors in mixed models.                                              | Supports categorical experimental coding, not logging temperature or Kelvin.                                         | Local PDF, p.10, section 3.6.                                                                                         |
| T5   | [Rodrigues et al. (2026): The Influence of Urban Context on Emotions and Bodily Responses During Walking](https://doi.org/10.1007/s11524-025-01051-1)                                  | Temperature; environmental indicators | Environmental predictors standardized before mixed-effects modelling; coefficients interpreted per one-SD increase.                          | Trip-level z-scores; does not establish our participant-phase centering rule.                                        | Local PDF, pp.5-7, Statistical Analysis and coefficient interpretation.                                               |
| T6   | [Effects of Indoor Thermal Environment on Human Food Intake, Productivity, and Comfort: Pilot, Randomized, Crossover Trial](https://doi.org/10.1002/oby.22328)                         | Air temperature conditions            | Categorical experimental thermal conditions                                                                                                  | 25 women; 19?20 versus 26?27 deg C, randomized crossover; not continuous exposure-response inference.                | Primary PubMed abstract PMID30426700 explicitly identifies conditions and mixed-effects thermal-condition comparison. |
| T7   | [The Effects of High-Temperature Weather on Human Sleep Quality and Appetite](https://doi.org/10.3390/ijerph16020270)                                                                  | Daily maximum temperature conditions  | Comparisons across four experimental temperature levels                                                                                      | Ten students; 28,32,36,38 deg C; a controlled-level comparison, not continuous H4 temperature or heat-index scaling. | Primary publisher and PubMed PMID30669302: four temperature conditions; categorical condition design confirmed.       |

**Pollution: checked papers**

| ID   | Paper                                                                                                                                                                                                                                                       | Parameters                                           | Reported treatment                                                                                                                                      | Scope / limitation                                                                                                      | Checked source                                                                                                                     |
|:-----|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| P1   | [Biel et al. (2020): Acute cardiovascular health effects in a panel study of personal exposure to traffic-related air pollutants and noise in Toronto, Canada](https://doi.org/10.1038/s41598-020-73412-6)                                                  | UFP; black carbon; PM2.5                             | UFP exposure log base 5; black-carbon exposure natural log; selected HRV outcomes separately natural-log transformed.                                   | Different pollutants received different treatments; UFP/BC rules cannot automatically be transferred to PM1/PM2.5/PM10. | Local H4 Biel PDF and full-text Statistical analysis.                                                                              |
| P2   | [Chang et al. (2015): Short-term exposure to noise, fine particulate matter and nitrogen oxides on ambulatory blood pressure: A repeated-measure study](https://doi.org/10.1016/j.envres.2015.06.004)                                                       | PM2.5; NOx; noise                                    | Methods report base-10 logs of non-normally distributed continuous variables before regression; smoothing splines also examined exposure-response form. | Reported method, not a rule that predictor marginal normality is required.                                              | Local PDF, p.2, section 2.5; publisher metadata.                                                                                   |
| P3   | [Shields et al. (2013): Traffic-related air pollution exposures and changes in heart rate variability in Mexico City: a panel study](https://doi.org/10.1186/1476-069X-12-7)                                                                                | PM2.5; gaseous pollutants                            | Methods explicitly state no predictors were transformed; HRV outcomes used natural logs; effects reported per IQR exposure increase.                    | Direct native-predictor precedent, conditional on their model assumptions.                                              | Full-text Statistical analysis; PubMed/publisher identification.                                                                   |
| P4   | [Huang et al. (2014): Personal Exposure to Household Particulate Matter, Household Activities and Heart Rate Variability among Housewives](https://doi.org/10.1371/journal.pone.0089969)                                                                    | PM2.5                                                | PM2.5 moving averages used as exposure; effects expressed per IQR increase. HRV outcomes were log10-transformed.                                        | Exposure scaling and outcome transformation are separate; no exposure logarithm specified in the checked methods.       | Publisher full text, Statistical analysis.                                                                                         |
| P5   | [Li et al. (2021): Effect of short-term exposure to particulate air pollution on heart rate variability in normal-weight and obese adults](https://doi.org/10.1186/s12940-021-00707-0)                                                                      | PM2.5; black carbon                                  | Moving-average pollutant exposures entered mixed models and results reported per IQR increase; HRV and HR outcomes log10-transformed.                   | No exposure log specified in the checked methods; not evidence for transforming every PM fraction.                      | Full-text Statistical analysis and PubMed/publisher record.                                                                        |
| P6   | [Contribution of Long-Term Exposure to Outdoor Black Carbon to the Carcinogenicity of Air Pollution: Evidence regarding Risk of Cancer in the Gazel Cohort](https://doi.org/10.1289/EHP8719)                                                                | Black carbon; PM2.5                                  | Natural-log exposure predictors in Cox models                                                                                                           | Long-term cumulative exposure and cancer; not short-term wearable physiology.                                           | Primary full-text statistical methods; PMC7989243.                                                                                 |
| P7   | [Association between personal exposure to household air pollution and gestational blood pressure among women using solid cooking fuels in rural Tamil Nadu, India](https://doi.org/10.1016/j.envres.2022.112756)                                            | PM2.5; black carbon; CO                              | Natural-log exposure predictors; functional form assessed with partial residual plots                                                                   | Pregnancy and household exposure; quartile and smooth-model alternatives also examined.                                 | Primary full-text methods; PMC8935388.                                                                                             |
| P8   | [Long-term Exposure to Black Carbon and Carotid Intima-Media Thickness: The Normative Aging Study](https://doi.org/10.1289/ehp.1104845)                                                                                                                     | Black carbon                                         | Natural-log black-carbon predictor in primary mixed models                                                                                              | Annual exposure in older men; CIMT outcome also logged separately. Not PM mass-fraction evidence.                       | Primary author manuscript, statistical methods; PMC3764069.                                                                        |
| P9   | [Concentration?Response Functions Relating Concentration and Duration of Ambient Traffic-Related Air Pollution Exposure to Systolic Blood Pressure](https://doi.org/10.1289/EHP13854)                                                                       | Black carbon; particle number concentration          | Natural-log concentration and duration predictors in concentration-response functions                                                                   | Particle number is related to UFP, not interchangeable with PM2.5 mass.                                                 | Primary published concentration-response equations; PMC11068155.                                                                   |
| P10  | [Baseline exposure-response assessment of metals from dried blood spots and personal household air pollution concentrations among pregnant women in Rwanda: household air pollution intervention network trial](https://doi.org/10.1186/s41043-025-01178-6) | PM2.5; black carbon; CO                              | Natural-log 24-hour exposure predictors                                                                                                                 | Pregnancy blood-metal outcomes; explicit abstract methods checked, full text not retrieved.                             | Primary PubMed abstract, PMID41420186.                                                                                             |
| P11  | [Relationship of Time-Activity-Adjusted Particle Number Concentration with Blood Pressure](https://doi.org/10.3390/ijerph15092036)                                                                                                                          | Time-activity-adjusted particle number concentration | Natural-log exposure predictor                                                                                                                          | Particle-number proxy for UFP; not PM2.5 mass or log-base-5 precedent.                                                  | Primary publisher methods, PMC6165221.                                                                                             |
| P12  | [Respiratory outcomes of ultrafine particulate matter (UFPM) as a surrogate measure of near-roadway exposures among bicyclists](https://doi.org/10.1186/s12940-017-0212-x)                                                                                  | Ultrafine particle concentration                     | Natural-log median exposure predictor in mixed models                                                                                                   | Cyclist lung-function response; not the same outcome or time scale as H4.                                               | Primary full-text statistical methods, PMC5299642.                                                                                 |
| P13  | [Exposure to mobile source air pollution in early life and childhood asthma incidence: The Kaiser Air Pollution and Pediatric Asthma Study](https://doi.org/10.1097/EDE.0000000000000754)                                                                   | PM2.5; NOx; CO                                       | Natural-log exposure predictors                                                                                                                         | Long-term early-life mobile-source pollution; childhood asthma, not ten-second physiology.                              | Primary author manuscript / CDC PDF, PMC5718963; exposure-response results per natural-log increase.                               |
| P14  | [Association between early life constituent-specific PM2.5 exposure and child development and the moderating role of greenness: a nationwide study in China](https://doi.org/10.1186/s12916-026-04750-x)                                                    | PM2.5 and constituents, including black carbon       | Natural-log exposure predictors before regression                                                                                                       | Developmental outcomes and long-term early-life exposure; not the H4 repeated-measures design.                          | Primary published statistical methods / results; PMC13077890; concentrations explicitly natural-log transformed before regression. |

**Light: checked papers**

| ID   | Paper                                                                                                                                                                                                                                      | Parameters                                   | Reported treatment                                                                                                                           | Scope / limitation                                                                                                                                | Checked source                                                                                                                                       |
|:-----|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------|
| L1   | [Chinazzo et al. (2019): Daylight affects human thermal perception](https://doi.org/10.1038/s41598-019-48963-y)                                                                                                                            | Illuminance                                  | Designed daylight levels used as experimental fixed factors with temperature.                                                                | Categorical dose design; not a continuous log-lux model.                                                                                          | Local PDF, pp.5-6.                                                                                                                                   |
| L2   | [Chinazzo et al. (2020): Influence of indoor temperature and daylight illuminance on visual perception](https://doi.org/10.1177/1477153519859609)                                                                                          | Illuminance                                  | Three daylight levels analysed with mixed models and pairwise factor-level comparisons.                                                      | No continuous logarithm established by this experimental design.                                                                                  | Local PDF, pp.7-8.                                                                                                                                   |
| L3   | [Zauner et al. (2025): How to Deal With Darkness: Modeling and Visualization of Zero-Inflated Personal Light Exposure Data on a Logarithmic Scale](https://doi.org/10.1177/07487304251336624)                                              | Personal light exposure; melanopic EDI       | Compares logarithmic/linear/hybrid/symlog visualization and GAM approaches including zero removal, offsets and a Tweedie error distribution. | Light is modelled/visualized as exposure data; not a universal prescription for lux as a physiological predictor.                                 | Publisher full text and institutional full-text PDF.                                                                                                 |
| L4   | [Smolders et al. (2018): Investigation of Dose-Response Relationships for Effects of White Light Exposure on Correlates of Alertness and Executive Control during Regular Daytime Working Hours](https://doi.org/10.1177/0748730418796438) | Illuminance                                  | Continuous log-transformed illuminance used in dose-response analyses of alertness and lighting appraisals.                                  | Direct log-illuminance predictor precedent; does not establish the optimal form for our outcomes or for Kelvin.                                   | Publisher text and author-institution full text.                                                                                                     |
| L5   | [Peeters et al. (2020): What you set is (not) what you get: How a light intervention in the field translates to personal light exposure](https://doi.org/10.1016/j.buildenv.2020.107288)                                                   | Personal illuminance                         | Log-transformed illuminance aggregated in 10-minute bins and analysed using linear mixed models.                                             | Illuminance is the measured response to an intervention; averaging logs differs from logging an arithmetic mean.                                  | Publisher full text, section 2.5 and Tables 4-5; institutional thesis reproducing the paper.                                                         |
| L6   | [Chinazzo et al. (2020): Effect of Indoor Temperature and Glazing with Saturated Color on Visual Perception of Daylight](https://doi.org/10.1080/15502724.2020.1726182)                                                                    | Glazing colour; visual light characteristics | Glazing colour represented by three categories in mixed models.                                                                              | Colour categories are not continuous CCT in Kelvin; no log-Kelvin rule established.                                                               | Local PDF, p.10, section 3.6.                                                                                                                        |
| L7   | [Melanopic irradiance defines the impact of evening display light on sleep latency, melatonin and alertness](https://doi.org/10.1038/s42003-023-04598-4)                                                                                   | Melanopic EDI; photopic illuminance          | Log-base-10 exposure-response predictors                                                                                                     | Evening display exposure; melanopic and photopic metrics are distinguished from Kelvin.                                                           | Primary published dose-response methods and tables, PMC9974389.                                                                                      |
| L8   | [A higher illuminance reduces momentary exhaustion in exhausted employees: results from a field study](https://doi.org/10.1016/j.jenvp.2025.102543)                                                                                        | Hourly personal illuminance                  | Log illuminance; person-mean-centered hourly exposure and grand-mean-centered person mean in multilevel models                               | Separates within- and between-person light exposure; not participant-phase centering or the exact H4 scaling rule. Log base not established here. | Author-hosted published PDF, methods p5 and model tables p7?8; https://pure.tue.nl/ws/portalfiles/portal/355235424/1-s2.0-S027249442500026X-main.pdf |
| L9   | [Evening home lighting adversely impacts the circadian system and sleep](https://doi.org/10.1038/s41598-020-75622-4)                                                                                                                       | Melanopic illuminance                        | Log exposure predictors: individual mean and deviation from individual mean                                                                  | Sleep wakefulness GLMM; melanopic rather than photopic illuminance; log base not established here.                                                | Primary publisher Methods, Sleep variables; within-person mean and deviation of log-transformed melanopic illuminance.                               |
| L10  | [Associations between light exposure and sleep timing and sleepiness while awake in a sample of UK adults in everyday life](https://doi.org/10.1073/pnas.2301608120)                                                                       | Melanopic EDI; photopic illuminance          | Log-base-10 lux in statistical analyses; log melanopic exposure/history predictors in mixed models                                           | Field sleep and sleepiness outcomes; different light metric and time scale from H4.                                                               | Primary PNAS Statistical Analysis: log10 lux, acute exposure and 30-minute-to-eight-hour light histories.                                            |

**Sound: checked papers**

| ID   | Paper                                                                                                                                                                                                      | Parameters                                    | Reported treatment                                                                                                                    | Scope / limitation                                                                                           | Checked source                                                                         |
|:-----|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------|
| S1   | [Biel et al. (2020): Acute cardiovascular health effects in a panel study of personal exposure to traffic-related air pollutants and noise in Toronto, Canada](https://doi.org/10.1038/s41598-020-73412-6) | Personal noise level                          | Continuous noise exposure included in mixed models; selected exposure logs are specified for UFP and BC, not noise.                   | dBA-level precedent; does not validate semantic scores or spectral proportions.                              | Local H4 Biel PDF and full-text Statistical analysis.                                  |
| S2   | [Chang et al. (2015): Short-term exposure to noise, fine particulate matter and nitrogen oxides on ambulatory blood pressure: A repeated-measure study](https://doi.org/10.1016/j.envres.2015.06.004)      | Noise level                                   | Methods include noise among continuous variables receiving base-10 logs before regression.                                            | Contrasting published treatment; not proof that an additional dBA log is needed here.                        | Local PDF, p.2, section 2.5.                                                           |
| S3   | [Kraus et al. (2013): Individual Daytime Noise Exposure during Routine Activities and Heart Rate Variability in Adults: A Repeated Measures Study](https://doi.org/10.1289/ehp.1205606)                    | A-weighted equivalent noise level             | Noise modelled in dBA with piecewise linear exposure-response functions at 65 dBA; effects per 5 dBA. HRV outcomes separately logged. | Nonlinear function of native dBA; not additional log-dBA scaling.                                            | Full-text Statistical analyses and primary abstract.                                   |
| S4   | [Sim et al. (2015): The Effects of Different Noise Types on Heart Rate Variability in Men](https://doi.org/10.3349/ymj.2015.56.1.235)                                                                      | Noise type at controlled levels               | Background, traffic, speech and mixed noise treated as exposure groups; group tests and an adjusted general linear model.             | Sound-type contrast; does not validate transformations of YAMNet scores or frequency proportions.            | Local PDF, p.3, Statistical analysis.                                                  |
| S5   | [Rodrigues et al. (2026): The Influence of Urban Context on Emotions and Bodily Responses During Walking](https://doi.org/10.1007/s11524-025-01051-1)                                                      | Noise; environmental predictors               | Predictors, including the noise block, standardized before mixed-effects modelling.                                                   | General z-score precedent; not our exact PCA or within-bout standardization method.                          | Local PDF, pp.5-7.                                                                     |
| S6   | [Effects of Aircraft Noise Exposure on Heart Rate during Sleep in the Population Living Near Airports](https://doi.org/10.3390/ijerph16020269)                                                             | A-weighted sound levels: LAeq, LA90 and LAmax | Continuous dBA-scale predictors; effects per 10 dBA, no extra exposure log specified                                                  | Sleep and aircraft noise; 15-second energy indicators and separate event models, not source-category scores. | Primary full text section2.4 and coefficient tables; PMC6352139.                       |
| S7   | [Personal Exposure to Household Particulate Matter, Household Activities and Heart Rate Variability among Housewives](https://doi.org/10.1371/journal.pone.0089969)                                        | Noise level                                   | Noise dBA covariate in mixed-effects models; additional noise log not specified                                                       | HRV outcome log10 does not imply log10 noise. Same publication as P4, counted once within Sound.             | Primary full text statistical methods and Table3; PMC3940710.                          |
| S8   | [Short-term association between personal exposure to noise and heart rate variability: The RECORD MultiSensor Study](https://doi.org/10.1016/j.envpol.2017.08.031)                                         | Personal noise Leq                            | Continuous dBA and piecewise dBA with 65 dBA breakpoint                                                                               | Five-minute windows, 75 participants; mixed effects and temporal autocorrelation; HRV logged separately.     | Primary publisher abstract and Results: per-one-dBA effects and piecewise regressions. |

**SVF / greenery: checked papers**

| ID   | Paper                                                                                                                                                                                 | Parameters                       | Reported treatment                                                                                                                      | Scope / limitation                                                                                   | Checked source                                                        |
|:-----|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------|
| G1   | [Effects of Environmental Features in Small Public Urban Green Spaces on Older Adults’ Mental Restoration: Evidence from Tokyo (2022)](https://doi.org/10.3390/ijerph19095477)        | SVF; GVI; PET                    | SVF/GVI included in multilevel regression; separate curvilinear exposure-response plots examined SVF, GVI and PET.                      | No universal log/logit transformation established; perceptual restoration outcomes differ from ours. | Publisher regression tables and primary PubMed figure descriptions.   |
| G2   | [Rodrigues et al. (2026): The Influence of Urban Context on Emotions and Bodily Responses During Walking](https://doi.org/10.1007/s11524-025-01051-1)                                 | Vegetation; sky visibility; NDVI | Continuous environmental indicators standardized as z-scores for mixed-effects analyses.                                                | Trip-level visual indicators differ from calibrated Holmer SVF and our within-bout SD convention.    | Local PDF, pp.5-7.                                                    |
| G3   | [Jiang et al. (2014): A dose of nature: Tree cover, stress reduction, and gender differences](https://doi.org/10.1016/j.landurbplan.2014.08.005)                                      | Visible tree-cover percentage    | Tree-cover density varied continuously; a quadratic regression described the male stress-recovery response.                             | Visible-tree dose precedent, not a Holmer SVF transformation study.                                  | US Forest Service author full text and primary abstract.              |
| G4   | [Jiang et al. (2016): A Dose-Response Curve Describing the Relationship Between Urban Tree Cover Density and Self-Reported Stress Recovery](https://doi.org/10.1177/0013916514552321) | Visible tree-cover percentage    | Primary abstract reports a positive linear relationship between tree-cover density and self-reported recovery, adjusted for covariates. | Primary abstract checked; detailed preprocessing/logging cannot be established from the abstract.    | Author-institution repository abstract; not full-method verification. |
| G5   | [Assessing the restorative benefits of open rooftop green spaces characteristics using virtual reality and EEG analysis (2026)](https://doi.org/10.3389/fpsyg.2026.1807425)           | GVI; SVF                         | GVI and SVF divided into low/medium/high design levels in virtual-reality scenarios.                                                    | Categorical scenario design; not a continuous SVF logit or native-linear validation.                 | Publisher full text, sections 2 and 3.1.                              |

**Complete environmental parameter mapping**

| Column                                        | Nonlinear transformation   | Centering / scaling                                                                                 | Condition / reason                                                                 | Candidate alternative                                    |
|:----------------------------------------------|:---------------------------|:----------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------|:---------------------------------------------------------|
| ucm_AIR_temp                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_AIR_RH                                    | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_AIR_T_bot                                 | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_AIR_T_mid                                 | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_AIR_T_top                                 | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_back                                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_front                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_left                                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_right                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_up                                     | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_down                                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_spot_gnd                               | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_spot_sky                               | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_spot_left                              | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IR_spot_right                             | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_SUN_Gh                                    | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_SND_dBA                                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Already logarithmic dBA; no additional log applied                                 | No additional nonlinear transform proposed automatically |
| ucm_WIND_AWS                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_WIND_AWA                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_WIND_TWS                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_WIND_TWD                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_IO_flag                                   | Not applicable             | No continuous scaling specified                                                                     | Use category coding; numeric codes are not continuous measurements                 | No additional nonlinear transform proposed automatically |
| ucm_AH                                        | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_SUN_alt                                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_SUN_az                                    | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_fp                                        | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_MRT                                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_MRT_S                                     | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_OPT                                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_HUMIDEX                                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_HUMIDEX_SR                                | Not applicable             | No continuous scaling specified                                                                     | Use category coding; numeric codes are not continuous measurements                 | No additional nonlinear transform proposed automatically |
| ucm_UTCI                                      | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_UTCI_SR                                   | Not applicable             | No continuous scaling specified                                                                     | Use category coding; numeric codes are not continuous measurements                 | No additional nonlinear transform proposed automatically |
| ucm_PET                                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| ucm_PET_SR                                    | Not applicable             | No continuous scaling specified                                                                     | Use category coding; numeric codes are not continuous measurements                 | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_b'                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_g'                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_kelvin                     | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_lux                        | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_LYS1__lys_medi                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_LYS1__lys_movement                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_r'                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_rgbb                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_rgbg                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_rgbir                      | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lys_rgbr                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_b'                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_g'                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_kelvin                     | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_lux                        | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_LYS2__lys_medi                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_LYS2__lys_movement                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_r'                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_rgbb                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_rgbg                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_rgbir                      | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lys_rgbr                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_atmotube_left__atmotube_pm10         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_atmotube_left__atmotube_pm1          | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_atmotube_left__atmotube_pm2.5        | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_atmotube_left__atmotube_humidity     | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_atmotube_left__atmotube_temperature  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_atmotube_right__atmotube_pm10        | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_atmotube_right__atmotube_pm1         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_atmotube_right__atmotube_pm2.5       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_lys_atmotube_right__atmotube_humidity    | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_atmotube_right__atmotube_temperature | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS1__lux_cat                        | Not applicable             | No continuous scaling specified                                                                     | Use category coding; numeric codes are not continuous measurements                 | No additional nonlinear transform proposed automatically |
| atmo_lys_LYS2__lux_cat                        | Not applicable             | No continuous scaling specified                                                                     | Use category coding; numeric codes are not continuous measurements                 | No additional nonlinear transform proposed automatically |
| gvi_tree_50m                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| gvi_phase_mean                                | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| plant_phase_mean                              | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| gvi_50m                                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| grass_phase_mean                              | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| tree_phase_mean                               | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| gvi_grass_50m                                 | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| gvi_plant_50m                                 | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| Sky_%                                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| SVF                                    | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| TVF                                           | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| BVF                                           | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| Tree_%                                        | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| Plant_%                                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| Grass_%                                       | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| Total_Vegetation_%                            | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| Building_%                                    | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| Wall_%                                        | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| Ceiling_%                                     | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| Total_Builtup_%                               | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| wind_score                                    | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| rural_natural_score                           | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| vehicle_score                                 | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| urban_manmade_neutral_score                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| urban_manmade_positive_score                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| urban_manmade_negative_score                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| mechanisms_score                              | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| wind_prop                                     | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| rural_natural_prop                            | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| vehicle_prop                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| urban_manmade_neutral_prop                    | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| urban_manmade_positive_prop                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| urban_manmade_negative_prop                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| mechanisms_prop                               | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| unidentify_prop                               | Not applicable             | No continuous scaling specified                                                                     | Classification review only; excluded before sound PCA                              | No additional nonlinear transform proposed automatically |
| dominant_frequency_hz                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| spectral_centroid_hz                          | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| spectral_rolloff85_hz                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |
| freq_prop_20_125                              | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| freq_prop_125_1000                            | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| freq_prop_1000_4000                           | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| freq_prop_4000_8000                           | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| freq_prop_8000_20000                          | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_31_5_hz                           | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_63_0_hz                           | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_125_0_hz                          | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_250_0_hz                          | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_500_0_hz                          | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_1000_0_hz                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_2000_0_hz                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_4000_0_hz                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| octave_prop_8000_0_hz                         | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4; same centering/scaling in sound PCA | Bounded exposure; native-scale zeros allowed; no automatic log/logit               | No additional nonlinear transform proposed automatically |
| atmo_pm1_avg                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_pm2.5_avg                                | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| atmo_pm10_avg                                 | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| lys_lux_avg                                   | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| lys_medi_avg                                  | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | ln(x) model-form sensitivity; not applied                |
| lys_kelvin_avg                                | None; native scale         | Within-bout centering and pooled-SD scaling when entered in H4                                      | Current specification; model form and residual assumptions require separate checks | No additional nonlinear transform proposed automatically |

**Method and literature**

Distinguish (1) nonlinear changes such as ln(x), (2) within-bout centering/scaling, and (3) role/categorical exclusions. [NIST](https://www.itl.nist.gov/div898/handbook/pmd/section6/pmd624.htm) relates transformations to regression form and error variance. Predictor skewness is a diagnostic, not proof that a transform is required or sufficient. [Enders & Tofighi (2007)](https://doi.org/10.1037/1082-989X.12.2.121) explain group-mean centering; the participant-phase grouping and pooled-SD scaling are this study's specifications.

**Paper index: current physiology citations**

| ID | Citation | DOI | File under Experiment papers | PDF evidence pages |
| --- | --- | --- | --- | --- |
| [1] | Romine et al. (2020). Using Machine Learning to Train a Wearable Device for Measuring Students' Cognitive Load during Problem-Solving Activities Based on Electrodermal Activity, Body Temperature, and Heart Rate: Development of a Cognitive Load Tracker for Both Personal and Classroom Use. Sensors, 20(17), 4833. | 10.3390/s20174833 | LMM_transform_evidence/Normalization - Romine et al 2020 - Wearable cognitive load tracker.pdf | 5 |
| [2] | Beggiato, Hartwich & Krems (2018). Using Smartbands, Pupillometry and Body Motion to Detect Discomfort in Automated Driving. Frontiers in Human Neuroscience, 12, 338. | 10.3389/fnhum.2018.00338 | LMM_transform_evidence/Normalization - Beggiato et al 2018 - Smartbands pupillometry and body motion.pdf | 7-8 |
| [3] | Madaniyazi et al. (2016). Outdoor Temperature, Heart Rate and Blood Pressure in Chinese Adults: Effect Modification by Individual Characteristics. Scientific Reports, 6, 21003. | 10.1038/srep21003 | Air temp - Outdoor temperature heart rate and blood pressure in Chinese adults.pdf | 1 |
| [4] | Liu, Schiavon, Das, Jin & Spanos (2019). Personal thermal comfort models with wearable sensors. Building and Environment, 162, 106281. | 10.1016/j.buildenv.2019.106281 | LMM_transform_evidence/Personal_thermal_comfort_wearable_sensors_2018.pdf | 1-2 |
| [5] | Mansi, Pigliautile, Arnesano & Pisello (2022). A novel methodology for human thermal comfort decoding via physiological signals measurement and analysis. Building and Environment, 222, 109385. | 10.1016/j.buildenv.2022.109385 | Empatica - A novel methodology for human thermal comfort decoding via physiological signals.pdf | 1 |
| [6] | Boucsein et al. (2012). Publication recommendations for electrodermal measurements. Psychophysiology, 49(8), 1017-1034. | 10.1111/j.1469-8986.2012.01384.x | LMM_transform_evidence/EDA_recommendations_BIOPAC_Psychophysiology_2012.pdf | 9 |
| [7] | Knejzlikova et al. (2021). Electrodermal Response to Mirror Exposure in Relation to Subjective Emotional Responses, Emotional Competences and Affectivity in Adolescent Girls With Restrictive Anorexia and Healthy Controls. Frontiers in Psychology, 12, 673597. | 10.3389/fpsyg.2021.673597 | LMM_transform_evidence/EDA - Vocks et al 2021 - Electrodermal Response to Mirror Exposure in Restrictive Anorexia.pdf | 5 |
| [8] | Laborde, Mosley & Thayer (2017). Heart Rate Variability and Cardiac Vagal Tone in Psychophysiological Research - Recommendations for Experiment Planning, Data Analysis, and Data Reporting. Frontiers in Psychology, 8, 213. | 10.3389/fpsyg.2017.00213 | LMM_transform_evidence/HRV - Laborde Mosley Thayer 2017 - Heart Rate Variability and Cardiac Vagal Tone in Psychophysiological Research Recommendations.pdf | 12 |
| [9] | Shaffer & Ginsberg (2017). An Overview of Heart Rate Variability Metrics and Norms. Frontiers in Public Health, 5, 258. | 10.3389/fpubh.2017.00258 | Empatica - Duration - An Overview of Heart Rate Variability Metrics and Norms.pdf | 2 |
| [10] | Task Force of the ESC and NASPE (1996). Heart rate variability: Standards of measurement, physiological interpretation, and clinical use. European Heart Journal, 17(3), 354-381. | 10.1093/oxfordjournals.eurheartj.a014868 | Empatica - HRV_task_force_team_europe_1996-1.pdf | 6 |
| [11] | Mahanama et al. (2022). Eye Movement and Pupil Measures: A Review. Frontiers in Computer Science, 3, 733531. | 10.3389/fcomp.2021.733531 | Eyetracker - Mahanama et al 2021 - Eye movement and pupil measures review.pdf | 1-4 |
| [12] | Evans, Jacobs, Tarduno & Pelz (2012). Collecting and Analyzing Eye-Tracking Data in Outdoor Environments. Journal of Eye Movement Research, 5(2), 6, 1-19. | 10.16910/jemr.5.2.6 | Eyetracker - Evans et al 2012 - Collecting and analyzing eye-tracking data in outdoor environments.pdf | 12 |
| [13] | Kchour, Cafiso & Pappalardo (2025). Understanding Cyclists' Visual Behavior Using Eye-Tracking Technology: A Systematic Review. Sensors, 25(1), 22. Published online 24 December 2024; issue year 2025. | 10.3390/s25010022 | LMM_transform_evidence/Normalization - Kchour et al 2025 - Cyclists visual behavior systematic review.pdf | 1 |

**Checked literature findings**

| Mapped source              | Verified scope / correction                                                                                                                                                             |
|:---------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Vocks et al 2021           | File attribution is incorrect: Knejzlikova et al. (2021), doi:10.3389/fpsyg.2021.673597. SCR used a log transform and SCL a square root; not evidence for blanket native-scale EDA.     |
| Figner_Murphy_2010         | Local full text discusses log or square-root treatment of skewed SCR and within-participant standardization; a conditional method discussion, not proof that no transformation is best. |
| EDA_recommendations_BIOPAC | Local 2012 recommendations discuss logarithmic or square-root SCR amplitudes; recording in microsiemens is not the same as analysing untransformed values.                              |
| Laborde Mosley Thayer 2017 | Normality of HRV Parameters discusses natural-log RMSSD and absolute powers for non-normal HRV; this is general rationale, not variable-by-variable validation of our full model.       |

The local file labelled Vocks 2021 is actually [Knejzlikova et al. (2021)](https://doi.org/10.3389/fpsyg.2021.673597). Its main EDA analysis used log-transformed SCR and square-root SCL. It cannot be counted as support for blanket no-transformation EDA. Current H4 EDA rules are not silently changed by this documentation correction.

| Exposure group | Current treatment | Literature and decision |
|---|---|---|
| PM1/PM2.5/PM10 | Native scale in current H4; ln(x) is a candidate sensitivity, not yet applied | [Biel et al. (2020)](https://doi.org/10.1038/s41598-020-73412-6) transformed UFP and black carbon selectively. That is not evidence for universally logging our PM size fractions. Compare physiological model form/residuals before changing equations. |
| Lux / melanopic illuminance | Native scale currently; ln(x) candidate where positive | [Zauner et al. (2025)](https://doi.org/10.1177/07487304251336624) specifically addresses logarithmic light modelling and zeros. Their light-response examples do not mandate the same transform when lux predicts physiology. Do not add an arbitrary constant for zeros. |
| Sound level | Calibrated dBA retained; no extra log | dBA already expresses a logarithmic level; standardizing is not another logarithm. |
| Sound scores, proportions and Hz descriptors | Current correlation-PCA uses native values centered within bout and pooled-SD scaled | [Jolliffe & Cadima (2016)](https://doi.org/10.1098/rsta.2015.0202) supports standardized PCA; it does not prove native/log alternatives are equivalent. Overlapping representations remain a limitation. |
| SVF / percentages / greenery | Native bounded predictors, then model-specific centering/scaling | Being bounded does not itself require a logit predictor. Endpoint and exposure-response checks are still needed; no universal SVF-transform claim is made. |
| Temperature, indices, radiation and other physical predictors | Native units in current equations | Choose functional form for the scientific exposure-response relationship, not from a normality test on the predictor alone ([NIST](https://itl.nist.gov/div898/handbook/pmd/section4/pmd453.htm)). |
| Diagnostic / category codes | Keep for review or use category coding; do not continuously standardize | Unidentified sound share is excluded before PCA. Ordinal codes are not made continuous by numeric storage. |

Detailed CSVs retain the observation counts and distribution diagnostics; they are not repeated here.
---
## Source: Reference Literature for all Paper3.md
---

# Paper3 — reference bibliography

> Normalization citation correction (20 October 2026): use Normalization_H1toH4_all_parameters.csv for the current 41-field physiology inventory and its 13 verified full texts. Legacy counts and deleted paper_roles/transformation_votes tables below are historical, not current evidence. PDF filenames labelled Zhang 2020, Wang 2024/2025, Imburgio 2024 and Kyriakou 2019 are excluded from the current mapping; do not use those legacy files as validated citations. Current references, correct authors/years, DOI, local PDF paths and evidence limitations are in the CSV and Normalization_Transformation_results.md.

**Scope:** Literature and local PDFs cited by Paper3_Final code, screening reports, and normalization notebooks (existing bibliography; not a newly verified count of distinct works). **Sibling PDF root:** `Paper3_Github/Experiment papers/` — paths below as `[cite: Experiment papers/…]`.

**Also see (detailed cites / machine indexes):** `output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_paper_roles.csv` (152 parameter-reference mappings; not 152 distinct PDFs); `scripts/H1_H3_core.R` (`CITE_*`, H2 `LIT` table); `scripts/H4_core.R` (Step 2 keys, GVIF, centering); sibling `Experiment papers/H1 to H4/H4_Screening_Literature_Guide.md`; `documents/Statistical_Analysis_Reference.html`; `Presentation material/Sound_screening_pca_vif.md`; `Presentation material/H4_Selection_Flow_explained.md`.

---

## Environmental measures & formulas

### SVF (sky view factor)

- **Construct:** exposure column `SVF` (0–1); scene `Sky_%`, vegetation/building percentages are segmentation components, not co-entered equivalents (`H4_core.R`, `H4_Selection_Flow_explained.md` §8).
- **Pipeline:** CamUp hemispherical imagery → DeepLabV3+ (Xception65) segmentation → merged bout windows (`SVF - Chen et al 2018 - DeepLabv3+…pdf`).
- Qiu et al. 2017 — automatic SVF from street-view / panoramic segmentation context — [cite: Experiment papers/SVF - Qiu et al 2017 - Automatic Sky View Factor Estimation from Street View Photographs.pdf] (`H4_core.R` `[Qiu17]`).

### Sound

- **Overall level:** `ucm_SND_dBA` — CityFeel / UCM backpack sensor table; doi:10.1016/j.egypro.2017.07.427 (`H4_core.R` `[CityFeel17]`; `Sound_screening_pca_vif.md`).
- **Frequency bands (five broad proportions, sum to 1):** 20–125, 125–1000, 1000–4000, 4000–8000, 8000–20000 Hz — Welch PSD partition in `scripts/Updated_JOS_Environmental_sound_classification_with_YAMNet_yenshuo.ipynb` (`AUDIO_MIN_HZ`/`AUDIO_MAX_HZ`, `freq_prop_*`); The current all-numeric sound PCA includes these fields; see `Sound_screening_pca_vif.md`.
- **Current sound PCA:** 32 numeric sound exposure inputs after excluding category text and unidentified proportion; within-bout centering and unit-SD scaling; current minimum-10-PC setting gives 84.037%, while the 80% criterion alone gives nine PCs, B4-style candidate selection, then separate full-equation VIF screening — Jolliffe & Cadima 2016; King & Jackson 1999. Aitchison 1983 describes the earlier compositional alternative (`Sound_screening_pca_vif.md`, `H4_Selection_Flow_explained.md`).
- Hamida, Eijkelenboom & Bluyssen 2024 — **p. 3:** low-frequency annoyance/stress **20–125 Hz** and mid-high sensitivity **3000–5000 Hz**; **p. 8:** sound types/levels at different frequencies; doi:10.1016/j.indenv.2024.100066 — [cite: Experiment papers/H1 to H4/H2 & H4 - Hamida et al 2024 - Guidance…sound exposure experiments.pdf]. Construct separation from dBA/type: `H4_Screening_Literature_Guide.md`; pipeline docstring in YAMNet sound notebook.
- Hamida 2023 — acoustical preferences review — [cite: Experiment papers/Hamida_2023_acoustical_preferences_review.pdf].
- Salamon 2014 — urban sound taxonomy/dataset — [cite: Experiment papers/Sound - Salamon 2014 - A Dataset and Taxonomy for Urban Sound Research.pdf].
- Cartwright et al. 2019 — SONYC urban sound tagging — [cite: Experiment papers/Sound - Cartwright et al. 2019 - SONYC Urban Sound Tagging taxonomy.pdf].
- Gemmeke et al. 2017 — AudioSet / YAMNet event ontology — [cite: Experiment papers/YAMNet - AudioSet Gemmeke 2017 - An ontology and human-labeled dataset for audio events.pdf].
- XTRACK — live-music segmentation with YAMNet — [cite: Experiment papers/Yamnet_threshold - XTRACK - Automatic Segmentation of Live Music with YAMNET.pdf].
- Affective acoustic scene / semantic-gap (YAMNet threshold QC) — [cite: Experiment papers/Yamnet_threshold - Bridging the Semantic Gap with Affective Acoustic Scene Analysis - an Information Retrieval-based Approach.pdf].
- Noise type ↔ HRV — [cite: Experiment papers/Sound - Effects of different noise types on heart rate variability in men.pdf].

### Clearness index (solar)

- **Formulas (`H4_core.R`, `[ClearCI]`):** clearness index **k_t = G_h / G_0** (eq. 2, p. 3); **G_0** = extraterrestrial irradiance from date/time/location only (denominator, not a personal exposure); measured solar exposure representative = **`ucm_SUN_Gh`**. Step 2 excludes derived `Clearness_Index`, `Clearness_Index_G0` (redundant with G_h; Zhu et al. 2024 mixtures logic).
- Adaptive design / daily clearness state (k_t definition) — [cite: Experiment papers/Clearness_Index - Adaptive Design of Solar-Powered Energy Systems Based on Daily Clearness State Evolution.pdf].
- Hourly solar radiation models (G_0 estimation context) — [cite: Experiment papers/Clearness_Index - Evaluation of Hourly Solar Radiation Models to Estimate Radiation on Inclined Surfaces in Dry Zone of Sri Lanka.pdf].

### Thermal / UCM (PET, UTCI, MRT, Humidex)

- CityFeel / UCM 2017 — `ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_WIND_AWS`, IR channels → **`ucm_MRT`**, `ucm_SUN_Gh`, derived **`ucm_PET`**, **`ucm_UTCI`**, **`ucm_HUMIDEX`**; doi:10.1016/j.egypro.2017.07.427 (`H4_core.R`).
- Brode et al. 2012 — UTCI outdoor thermal stress; doi:10.1007/s00484-011-0454-1 (sibling `H4_Screening_Literature_Guide.md`).
- Matzarakis & Mayer — UTCI/PET/mPET comfort ranges — [cite: Experiment papers/Air temp - Defining thermal comfort range of UTCI PET and mPET.pdf]; PET stress categories — [cite: Experiment papers/Air temp - PET thermal stress thresholds Matzarakis Mayer categories.pdf]; unverified copy — [cite: Experiment papers/H1 to H4/H4 - UNVERIFIED - Matzarakis & Mayer 1999 - …pdf].
- Outdoor temperature ↔ HR/BP — [cite: Experiment papers/Air temp - Outdoor temperature heart rate and blood pressure in Chinese adults.pdf].
- Music/temperature ↔ HR — [cite: Experiment papers/Air temp - Effects of music and temperature changes on heart function and human error.pdf].
- Empatica thermal comfort decoding — [cite: Experiment papers/Empatica - A novel methodology for human thermal comfort decoding via physiological signals.pdf].
- Personal thermal comfort wearables 2018 — [cite: Experiment papers/LMM_transform_evidence/Personal_thermal_comfort_wearable_sensors_2018.pdf].
- DTU thermal comfort physiological sensing 2025 — [cite: Experiment papers/LMM_transform_evidence/Thermal_comfort_physiological_sensing_DTU_2025.pdf].
- Outdoor small-n wearable thermal studies (MD) — [cite: Experiment papers/outdoor_small_n_wearable_thermal_studies.md].
- Nikolopoulou et al. 2001 — outdoor thermal comfort (`Paper3_outline_ml.md`).
- Mansi et al. 2022 — outdoor thermal comfort methodology (`Paper3_outline_ml.md`).

### Air quality / PM

- **`atmo_pm1_avg`, `atmo_pm2.5_avg`, `atmo_pm10_avg`** — row-wise bilateral means; participant-phase mean centered and pooled-SD scaled in H4 (`H4_core.R`).
- Biel et al. 2020 — acute cardiovascular effects of air pollutants and noise — [cite: Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf].
- Short-term noise, PM, NOx ↔ ambulatory BP — [cite: Experiment papers/Short-term exposure to noise, fine particulate matter and nitrogen oxides on ambulatory blood pressure A repeated-measure study_similar.pdf].
- Traffic exposures 2015 — inflammation, BP, HRV — [cite: Experiment papers/H1 to H4/H4 - Traffic exposures 2015 - Repeated inflammation blood pressure and HRV.pdf].
- Zhu et al. 2024 — multiple pollutant mixtures / redundant derived exposures — [cite: Experiment papers/H1 to H4/H4 - Zhu et al 2024 - A review of common statistical methods…pdf] (`H4_core.R` `[Zhu24]`).

### GVI (greenery)

- **Construct:** `gvi_50m` (0–100%) retained; alternate buffers/components excluded (`H4_core.R`); eye-level panoramic imagery merge.
- (No dedicated GVI-methods PDF in roles CSV; construct documented in `H4_Selection_Flow_explained.md` and merge provenance in `H4_core.R`.)

### Light / LYS (lux, kelvin, melanopic)

- **`lys_lux_avg`, `lys_kelvin_avg`** retained; derived **`lys_medi_avg`** excluded (RGB-estimated melanopic EDI) — Beiglary et al. 2025 JMIR Aging e72338; Ishihara et al. 2025 *SLEEP* zsaf358 (`H4_core.R` `[Beiglary25]`, `[Ishihara25]`).
- CIE S 026/E:2018 — photopic vs melanopic metrology (sibling screening guide).
- Stevenson et al. — LYS / correlated colour temperature; doi:10.1177/14771535251338582 (`H4_Transparency_Report.md`).
- Sonneborn & Voss — field light-exposure methods — [cite: Experiment papers/LYS ranges - FIELD STUDIES OF HUMAN LIGHT EXPOSURE DURING EVERYDAY ACTIVITIES – METHODOLOGICAL ASPECTS AND INITIAL RESULTS.pdf] (`H4_core.R` `[Sonneborn]`).
- Chinazzo et al. 2019 — daylight ↔ thermal perception — [cite: Experiment papers/Atmo LYS - Daylight affects human thermal perception.pdf].
- Indoor temperature/glazing/colour ↔ daylight perception — [cite: Experiment papers/Atmo LYS - Effect of Indoor Temperature and Glazing with Saturated Color on Visual Perception of Daylight.pdf].
- Indoor temperature/illuminance ↔ visual perception — [cite: Experiment papers/Atmo LYS - Influence of indoor temperature and daylight illuminance on visual perception.pdf].
- Obeng-Gyasi et al. 2025 — naturalistic illuminance patterns — [cite: Experiment papers/LMM_transform_evidence/Illuminance - Obeng-Gyasi et al 2025 - …pdf].

---

## Normalization & Parameter Screening
From `output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_paper_roles.csv` + `scripts/Normalization & Parameter Screening/Normalization_H1toH4.ipynb`.

### exposure_center (15)
- [cite: Experiment papers/Air temp - Defining thermal comfort range of UTCI PET and mPET.pdf]
- [cite: Experiment papers/Air temp - Effects of music and temperature changes on heart function and human error.pdf]
- [cite: Experiment papers/Air temp - Outdoor temperature heart rate and blood pressure in Chinese adults.pdf]
- [cite: Experiment papers/Air temp - PET thermal stress thresholds Matzarakis Mayer categories.pdf]
- [cite: Experiment papers/Atmo LYS - Daylight affects human thermal perception.pdf]
- [cite: Experiment papers/Empatica - A novel methodology for human thermal comfort decoding via physiological signals.pdf]
- [cite: Experiment papers/H1 to H4/H2 & H4 - Hamida et al 2024 - Guidance to investigate university students' bodily responses and perceptual assessments in sound exposure experiments.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf]
- [cite: Experiment papers/H1 to H4/H4 - UNVERIFIED - Matzarakis & Mayer 1999 - PET thermal stress thresholds categories.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Zhu et al 2024 - A review of common statistical methods for dealing with multiple pollutant mixtures and multiple exposures.pdf]
- [cite: Experiment papers/Hamida_2023_acoustical_preferences_review.pdf]
- [cite: Experiment papers/Methodology - A review of common statistical methods for dealing with multiple pollutant mixtures and multiple exposures.pdf]
- [cite: Experiment papers/outdoor_small_n_wearable_thermal_studies.md]
- [cite: Experiment papers/Short-term exposure to noise, fine particulate matter and nitrogen oxides on ambulatory blood pressure A repeated-measure study_similar.pdf]
- [cite: Experiment papers/Sound - Effects of different noise types on heart rate variability in men.pdf]

### light_exposure (7)
- [cite: Experiment papers/Atmo LYS - Effect of Indoor Temperature and Glazing with Saturated Color on Visual Perception of Daylight.pdf]
- [cite: Experiment papers/Atmo LYS - Influence of indoor temperature and daylight illuminance on visual perception.pdf]
- [cite: Experiment papers/Clearness_Index - Adaptive Design of Solar-Powered Energy Systems Based on Daily Clearness State Evolution.pdf]
- [cite: Experiment papers/Clearness_Index - Evaluation of Hourly Solar Radiation Models to Estimate Radiation on Inclined Surfaces in Dry Zone of Sri Lanka.pdf]
- [cite: Experiment papers/H1 to H4/H1-H4 - Cnaan, Laird & Slasor 1997 - Using the general linear mixed model to analyse unbalanced repeated measures and longitudinal data.pdf]
- [cite: Experiment papers/LYS ranges - FIELD STUDIES OF HUMAN LIGHT EXPOSURE DURING EVERYDAY ACTIVITIES – METHODOLOGICAL ASPECTS AND INITIAL RESULTS.pdf]
- [cite: Experiment papers/Yamnet_threshold - Bridging the Semantic Gap with Affective Acoustic Scene Analysis - an Information Retrieval-based Approach.pdf]

### transform (8)
- [cite: Experiment papers/Empatica - HRV_task_force_team_europe_1996-1.pdf]
- [cite: Experiment papers/H1 to H4/H2 & H4 - Enders & Tofighi 2007 - Centering Predictor Variables.pdf]
- [cite: Experiment papers/Normalization - ANCOVA - Vickers 2001 - Analysing controlled trials with baseline and follow up measurements.pdf]
- [cite: Experiment papers/Normalization - Vickers 2001 - Analysing controlled trials with baseline and follow up measurements.md]
- [cite: Experiment papers/Normalization - Zscored - Bush 1993 - Transformations for within-subject designs A Monte Carlo investigation.pdf]
- [cite: Experiment papers/Normalization - Zscored - Lykken 1971 - Direct measurement of skin conductance A proposal for standardization.pdf]
- [cite: Experiment papers/Psychophysiology - May 1981 - Fowles - Publication Recommendations for Electrodermal Measurements.pdf]
- [cite: Experiment papers/Statistics - Enders & Tofighi 2007 - Centering Predictor Variables.pdf]

### native_physio (26)
- [cite: Experiment papers/Empatica - A foundation model for electrodermal activity data.pdf]
- [cite: Experiment papers/Empatica - Duration - An Overview of Heart Rate Variability Metrics and Norms.pdf]
- [cite: Experiment papers/Empatica - Duration - Heart rate variability stabilization in athletes towards more convenient data acquisition.pdf]
- [cite: Experiment papers/Empatica - Electrodermal Activity as a Unimodal Signal for Aerobic Exercise Detection in Wearable Sensors.pdf]
- [cite: Experiment papers/Empatica - Evaluating Biosignals for Stress Detection in Ambulatory Settings.pdf]
- [cite: Experiment papers/Empatica - Extending Stress Detection Reproducibility to Consumer Wearable Sensors.pdf]
- [cite: Experiment papers/Empatica - Kyriakou et al 2019 - An Individual-Oriented Algorithm for Stress Detection in Wearable Sensor Measurements.pdf]
- [cite: Experiment papers/Empatica - Stress in the City Multimodal Biosensing of Urban Stress.pdf]
- [cite: Experiment papers/Empatica_data_manual.pdf]
- [cite: Experiment papers/Eyetracker - Enhancing mobile eye tracking in extreme urban lighting conditions.pdf]
- [cite: Experiment papers/Eyetracker - Evans et al 2012 - Collecting and analyzing eye-tracking data in outdoor environments.pdf]
- [cite: Experiment papers/Eyetracker - Fleming et al 2024 - The nature gaze outdoor eye tracking wellbeing.pdf]
- [cite: Experiment papers/Eyetracker - Mahanama et al 2021 - Eye movement and pupil measures review.pdf]
- [cite: Experiment papers/Eyetracker - Rupi and Krizek 2019 - Visual eye gaze while cycling urban intersections.pdf]
- [cite: Experiment papers/Eyetracker - Tomasi et al 2016 - Mobile gaze tracking outdoor walking behavioral studies.pdf]
- [cite: Experiment papers/Eyetracker - Trefzger et al 2018 - Visual comparison gaze pedestrians cyclists.pdf]
- [cite: Experiment papers/Eyetracker - Vansteenkiste et al 2014 - Cycling around a curve gaze behavior.pdf]
- [cite: Experiment papers/Eyetracker - Wang et al 2024 - Eye tracking measures of bicyclists behavior and perception A systematic review.pdf]
- [cite: Experiment papers/H1 to H4/H1 & H3 - Chrisinger & King 2018 - SENSE Citizen Science Empatica.pdf]
- [cite: Experiment papers/H1 to H4/H1 - Gidlow et al 2016 - Walking Natural Urban Environments.pdf]
- [cite: Experiment papers/Statistics - Chrisinger & King 2018 - SENSE Citizen Science Empatica.pdf]
- [cite: Experiment papers/Statistics - Gidlow et al 2016 - Walking Natural Urban Environments.pdf]
- [cite: Experiment papers/Statistics - Hunter et al 2019 - Urban Nature Experiences Reduce Stress.pdf]
- [cite: Experiment papers/Statistics - Kim et al 2023 - Location-based Collective Distress Biosignals.pdf]
- [cite: Experiment papers/Statistics - Torku et al 2023 - Older Pedestrians Urban Stress Empatica.pdf]
- [cite: Experiment papers/The Influence of Urban Context on Emotions and Bodily Responses During Walking_similar.pdf]

### hrv_qc (9)
- [cite: Experiment papers/Empatica - Artefact - A continuous wavelet transform-based method for time-frequency analysis of artefact-corrected heart rate variability data.pdf]
- [cite: Experiment papers/Empatica - Artefact - Publication guidelines for human heart rate and heartrate variability studies in psychophysiology—Part1 Physiological underpinnings and foundations ofmeasurement.pdf]
- [cite: Experiment papers/Empatica - Duration - A Critical Review of Ultra-Short-Term Heart Rate Variability Norms Research.pdf]
- [cite: Experiment papers/Empatica - Duration - Minimal Window Duration for Accurate HRV Recording in Athletes.pdf]
- [cite: Experiment papers/Empatica - Reliability of Ultra-Short-Term Analysis as a Surrogate of Standard 5-Min Analysis of Heart Rate Variability.pdf]
- [cite: Experiment papers/Empatica - Validity of the Empatica E4 wristband to estimate resting-state heart rate variability in a lab-based context.pdf]
- [cite: Experiment papers/Empatica - Wearable Electrodermal Activity Signal Quality and Artifact Detection.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Traffic exposures 2015 - Repeated inflammation blood pressure and HRV.pdf]
- [cite: Experiment papers/Impact of Using Different Levels of Threshold-Based Artefact Correction on the Quantification of Heart Rate Variability in Three Independent Human Cohorts.pdf]

### lmm_physio (15)
- [cite: Experiment papers/LMM_transform_evidence/EDA - Vocks et al 2021 - Electrodermal Response to Mirror Exposure in Restrictive Anorexia.pdf] ? filename attribution is incorrect: Knejzlikova et al. (2021), [doi:10.3389/fpsyg.2021.673597](https://doi.org/10.3389/fpsyg.2021.673597). Main EDA analyses used log SCR and square-root SCL; this is not evidence for blanket no transformation.
- [cite: Experiment papers/LMM_transform_evidence/EDA_recommendations_BIOPAC_Psychophysiology_2012.pdf]
- [cite: Experiment papers/LMM_transform_evidence/EDA_SCL_square_root_Nature_2025_self_harm.pdf]
- [cite: Experiment papers/LMM_transform_evidence/EDA_transform_BIOPAC_EDA_SCR_Analysis.pdf]
- [cite: Experiment papers/LMM_transform_evidence/EDA_transform_Figner_Murphy_2010_skin_conductance.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Eyetracker - Wang et al 2025 - Understanding Cyclists Visual Behavior Using Eye-Tracking Technology A Systematic Review.pdf]
- [cite: Experiment papers/LMM_transform_evidence/HR_EDA - Beggiato et al 2018 - Using Smartbands Pupillometry and Body Motion to Detect Discomfort in Automated Driving.pdf]
- [cite: Experiment papers/LMM_transform_evidence/HRV - Laborde Mosley Thayer 2017 - Heart Rate Variability and Cardiac Vagal Tone in Psychophysiological Research Recommendations.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Illuminance - Obeng-Gyasi et al 2025 - Characteristics of objectively-measured naturalistic light exposure patterns in US adults.pdf]
- [cite: Experiment papers/LMM_transform_evidence/LMM_physio_stress_Frontiers_2023_Tervonen.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Personal_thermal_comfort_wearable_sensors_2018.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Pupil - Imburgio et al 2024 - Electrocortical Responses in Anticipation of Avoidable and Inevitable Threats A Multisite Study.pdf]
- [cite: Experiment papers/LMM_transform_evidence/TEMP_EDA_HR - Zhang et al 2020 - Wearable Device for Measuring Students Cognitive Load based on EDA Body Temperature and HR.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Thermal_comfort_physiological_sensing_DTU_2025.pdf]
- [cite: Experiment papers/LMM_transform_evidence/WPZ - Wang et al 2019 - On Standardizing Within-Person Effects Potential Problems of Global Standardization.pdf]

### not_physiology (7)
- [cite: Experiment papers/Sound - Cartwright et al. 2019 - SONYC Urban Sound Tagging taxonomy.pdf]
- [cite: Experiment papers/Sound - Salamon 2014 - A Dataset and Taxonomy for Urban Sound Research.pdf]
- [cite: Experiment papers/SVF - Chen et al 2018 - DeepLabv3+ Encoder-Decoder with Atrous Separable Convolution.pdf]
- [cite: Experiment papers/SVF - Qiu et al 2017 - Automatic Sky View Factor Estimation from Street View Photographs.pdf]
- [cite: Experiment papers/YAMNet - AudioSet Gemmeke 2017 - An ontology and human-labeled dataset for audio events.pdf]
- [cite: Experiment papers/Yamnet - Guidance to investigate university students bodily responses and perceptual assessments in sound exposure experiments.pdf]
- [cite: Experiment papers/Yamnet_threshold - XTRACK - Automatic Segmentation of Live Music with YAMNET.pdf]

### model (14)
- [cite: Experiment papers/H1 to H4/H1-H4 - Benjamini & Hochberg 1995 - Controlling the FDR.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Friedman Hastie Tibshirani 2010 - Regularization Paths for Generalized Linear Models via Coordinate Descent.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Hamra & Buckley 2018 - Environmental exposure mixtures questions and methods.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Heinze Wallisch Dunkler 2018 - Variable selection review and recommendations.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Lee et al 2016 - Exact post selection inference with LASSO.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Model choice 2021 - Chemical mixtures simulation study.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Naimi - usdm package vignette and stepwise VIF.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Sauerbrei et al 2020 - Selection of variables and functional forms.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Schelldorfer Buhlmann van de Geer 2011 - Penalized Linear Mixed Effects Models.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Zou Hastie 2005 - Regularization and variable selection via the elastic net.pdf]
- [cite: Experiment papers/H1 to H4/H4_Screening_Literature_Guide.md]
- [cite: Experiment papers/Methodology - Environmental exposure mixtures questions and methods to address them.pdf]
- [cite: Experiment papers/Statistics - Benjamini & Hochberg 1995 - Controlling the FDR.pdf]
- [cite: Experiment papers/Statistics - Cnaan Laird & Slasor 1997 - GLMM for Unbalanced Repeated Measures.pdf]

### context (4)
- [cite: Experiment papers/H2 - Coherence and divergence in autonomic-subjective affective space - Cuve 2023.pdf]
- [cite: Experiment papers/H1 to H4/H2 - Cuve 2023 - Coherence and divergence in autonomic-subjective affective space.pdf]
- [cite: Experiment papers/Normalization - Methodological Foundations and Papers Guide.md]
- [cite: Experiment papers/Statistics - Bibliography and Justification.md]

### model — sibling screening guide DOIs (not duplicated as PDF rows)
- O'Brien 2007 — VIF cutoff caution; doi:10.1007/s11135-006-9018-6
- Dormann et al. 2013 — collinearity; doi:10.1111/j.1600-0587.2012.07348.x
- Zuur et al. 2010 — iterative VIF; doi:10.1111/j.2041-210X.2009.00001.x
- Jolliffe & Cadima 2016 — PCA review; doi:10.1098/rsta.2015.0202
- Horn 1965 — parallel analysis; doi:10.1007/BF02289447
- Glorfeld 1995 — Monte Carlo PCA retention; doi:10.1177/0013164495055003002
- Agier et al. 2016 — exposure selection; doi:10.1289/EHP172
- Brode et al. 2012 — UTCI; doi:10.1007/s00484-011-0454-1
- Joubert et al. 2026 — mixtures workflow (`H4_core.R`)

### Code / manuscript only (132-audit items not in roles CSV)
- Pinheiro & Bates 2000 — mixed-effects / AR(1); doi:10.1007/b98882 (`H1_H3_core.R`, H4)
- Lenth 2023 — emmeans (`H1_H3_core.R`)
- Bonett 2008 — paired SMD; doi:10.1037/1082-989X.13.2.99 (`H1_H3_core.R`)
- Bakdash & Marusich 2017 — rmcorr; doi:10.3389/fpsyg.2017.00456 (`H1_H3_core.R`)
- Ben-Shakhar 1985 — WPZ; doi:10.1111/j.1469-8986.1985.tb01603.x (`H1_H3_core.R`)
- Curran & Bauer 2011 — multilevel centering (`H4_core.R`)
- Fox & Monette 1992 — GVIF; doi:10.1080/01621459.1992.10475190 (`H4_core.R`)
- Pustejovsky & Tipton 2018; Tipton 2015 — CR2 small-cluster df (`H4_core.R`)
- CityFeel / UCM 2017 — doi:10.1016/j.egypro.2017.07.427
- Beiglary et al. 2025; Ishihara et al. 2025 — melanopic EDI exclusion (`H4_core.R`)
- Stevenson et al. — LYS CCT; doi:10.1177/14771535251338582
- CIE S 026/E:2018 — ipRGC metrology (screening guide)
- Aitchison 1983 — clr PCA; doi:10.2307/2335943
- Stuyck et al. 2022; Quigley et al. 2024 — E4/HRV reporting (`Paper3_outline_ml.md`)
- Kaplan 1995; Nikolopoulou et al. 2001; Mansi et al. 2022 — urban/thermal context (`Paper3_outline_ml.md`)
- H2 `LIT` (no local PDF): Boucsein 2012; Dawson et al. 2017; Shaffer & Ginsberg 2017; Billman 2013; Van Doren et al. 2021; Ulrich et al. 1991; Romanovsky 2014; Charkoudian 2010; Mathot 2018; Rayner 1998; Schleicher et al. 2008; Bentivoglio et al. 1997; Berto et al. 2008; Franconeri et al. 2013; Valtchanov & Ellard 2015; Tatler 2007; Stern et al. 1994

### PCA (sound frequency) — method refs only
- Aitchison 1983 clr-PCA; Hamida 2024 (20–125 Hz; 3000–5000 Hz; frequency vs level); Jolliffe & Cadima 2016 (PCA overview); King & Jackson 1999 (evaluated 80/90% criteria); CityFeel dBA separation — **`Presentation material/Sound_screening_pca_vif.md`**; script `scripts/Normalization & Parameter Screening/PCA-informed_sound_frequency.py`.

---

## Hypothesis testing

### H1 — green infrastructure vs reference routes

- **Question:** Do physiological outcomes differ between green and reference routes within bike (H1.1 BikeG−BikeU) and walk (H1.2 WalkG−WalkU) modes?
- **Formulas (`H1_to_H3_phase_average.R`):** `H1_PhaseMean_Primary_LMM` — `lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID)`; `H1_PhaseMean_Sensitivity_WPZ_LMM` — same with within-person z-scored outcome; `H1_Temporal_AR1_10s_LMM` / `H1_Temporal_AR1_60s_LMM` — `lme(wpz_outcome ~ PhaseID * time_min, random = ~ 1 | ParticipantID, correlation = corAR1(~ time_step | ParticipantID / PhaseID))`; difference-of-differences `(BikeG − BikeU) − (WalkG − WalkU)` reported alongside planned contrasts; paired SMD via `statpsych::ci.stdmean.ps`.
- **References:** Pinheiro & Bates 2000 (`nlme`, REML, `corAR1`); Lenth 2023 `emmeans` phase contrasts; Bonett 2008 paired SMD CIs; Ben-Shakhar 1985 WPZ sensitivity; Benjamini & Hochberg 1995 BH-FDR (families: primary / WPZ / temporal per term); Gidlow et al. 2016; Hunter et al. 2019; Kaplan 1995 restorative framework (`Paper3_outline_ml.md`).

### H3 — active travel mode contrasts

- **Question:** Walking vs biking on reference (H3.1 WalkU−BikeU) and green (H3.2 WalkG−BikeG) routes?
- **Formulas:** `H3_PhaseMean_Primary_LMM`, `H3_PhaseMean_Sensitivity_WPZ_LMM`, `H3_Temporal_AR1_10s_LMM`, `H3_Temporal_AR1_60s_LMM` — same shells as H1 (`H1_to_H3_phase_average.R`); emmeans reference level BikeU.
- **References:** Same statistical core as H1 (Pinheiro & Bates; Lenth `emmeans`; Bonett; Ben-Shakhar WPZ; BH-FDR).

### H2 — psychophysiological concordance

- **Question:** Within-person association between end-of-phase questionnaires and phase-mean physiological outcomes across four mobility conditions?
- **Formulas:** `H2_rmcorr` — `lm(psychological ~ ParticipantID + physiological)` (common within-person slope; Bakdash & Marusich 2017); 4 × 26 = 104 pairs; one BH-FDR family.
- **References:** Bakdash & Marusich 2017 rmcorr; BH-FDR; Cuve et al. 2023 pupil/autonomic context; **`H1_H3_core.R` `LIT` table** — Boucsein 2012; Dawson et al. 2017; Laborde et al. 2017; Shaffer & Ginsberg 2017; Task Force ESC/NASPE 1996; Billman 2013 LF/HF; Van Doren et al. 2021; Ulrich et al. 1991; Romanovsky 2014; Charkoudian 2010; Mathot 2018; Rayner 1998; Schleicher et al. 2008; Bentivoglio et al. 1997; Berto et al. 2008; Franconeri et al. 2013; Valtchanov & Ellard 2015; Tatler 2007; Stern et al. 1994; Kim et al. 2023; Torku et al. 2023.

### H4 — noise amplification on thermal discomfort (multivariate bout LMM)

- **Question:** Within 10 s bout windows, do heat × sound interactions and covariates (MRT, solar, SVF, PM, light, GVI, phase) associate with physiological/ocular outcomes (exploratory secondary models)?
- **Formulas (`H4_time_series.R` — six meeting-spec equations; names match `H4_Selection_Flow_explained.md` table):**
  - **Eq1 (Primary):** UTCI × Sound + MRT × Sound + `ucm_SUN_Gh` + `SVF` + PM2.5 + lux + kelvin + GVI + sum-to-zero phase (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`); `random = ~ 1 | ParticipantID / PhaseID`; `corAR1(~ Time10 | ParticipantID / PhaseID)`.
  - **Eq2 (Heat sensitivity — air temp, RH, wind):** AIR_temp × Sound + RH × Sound + wind × Sound + MRT × Sound + shared covariates/phases/AR(1).
  - **Eq3 (Heat sensitivity — HUMIDEX):** HUMIDEX × Sound + MRT × Sound + shared block.
  - **Eq4 (Heat sensitivity — PET):** PET × Sound + MRT × Sound + shared block.
  - **Eq5 (PM size — PM1):** UTCI × Sound + MRT × Sound + PM1 + shared block.
  - **Eq6 (PM size — PM10):** UTCI × Sound + MRT × Sound + PM10 + shared block.
  - **Prep:** within-bout exposure centering (Enders & Tofighi 2007; Curran & Bauer 2011); forced exertion `empatica_vector_magnitude`; optional 60 s lag sensitivity; ARMA(2,0) when AR(1) ρ > 0.95 (`H4_core.R`).
- **References:** Pinheiro & Bates 2000 (`nlme` REML, nested random, AR(1)); **clubSandwich** CR2 cluster-robust SEs, Satterthwaite df, HTZ Wald phase contrasts (Pustejovsky & Tipton 2018; Tipton 2015 low-df flag); Fox & Monette 1992 GVIF / `car::vif` (threshold 5, design-only); Benjamini & Hochberg 1995 (thermal terms per equation × 26 outcomes; phase contrasts separate family); CityFeel17; ClearCI k_t; Qiu17 SVF; Beiglary25 / Ishihara25 / Sonneborn light; Zhu24 / Joubert26 mixtures redundancy; Brode UTCI; sibling **H4_Screening_Literature_Guide.md** (O'Brien, Dormann, Zuur, Jolliffe, Horn, Glorfeld, Agier); Hamida24 sound bands; Aitchison clr-PCA for frequency screening.

---

## Reference index (repo paths)

| File path | What references it holds |
| --- | --- |
| `Presentation material/Reference Literature for all Paper3.md` | This master bibliography |
| `scripts/H1_H3_core.R` | `CITE_*` strings; H2 `LIT` expectation citations |
| `scripts/H1_to_H3_phase_average.R` | Named H1/H2/H3 model quotes and contrast specs |
| `scripts/H4_time_series.R` | Eq1–Eq6 LMM formulas and equation metadata |
| `scripts/H4_core.R` | Exposure definitions, Step 2 keys, GVIF, CR2 inference, centering |
| `output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_paper_roles.csv` | Experiment-papers PDF inventory by normalization role |
| `output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_transformation_votes.csv` | Literature vote counts by physiology vote group and environmental exposure group |
| `scripts/Normalization & Parameter Screening/Normalization_H1toH4.ipynb` | Per-column reference index → PDF paths; `PHYSIO_LITERATURE_VOTES` and environment roll-ups |
| `Presentation material/Sound_screening_pca_vif.md` | Sound PCA candidate selection and separate VIF screening |
| `Presentation material/H4_Selection_Flow_explained.md` | H4 retention narrative, Eq1–6 labels, SVF/GVI rules |
| `output/statistical_analysis/results/H4_time_series/H4_time_series_gvif_diagnostic.md` | Fox & Monette GVIF diagnostic |
| `Presentation material/H4_Transparency_Report.md` | CityFeel, Stevenson, Beiglary/Ishihara evidence |
| `documents/Statistical_Analysis_Reference.html` | Method cards (EDA, HRV window, Cuve, Chrisinger, Enders, …) |
| `documents/Paper3_outline_ml.md` | Manuscript-level refs (Kaplan, Nikolopoulou, Stuyck, Quigley, …) |
| `Paper3_Github/Experiment papers/H1 to H4/H4_Screening_Literature_Guide.md` | Screening policy, PCA/VIF/mixtures DOIs |
| `Paper3_Github/Experiment papers/Statistics - Bibliography and Justification.md` | Cross-hypothesis statistics PDF index |


## Current evidence and output status

| Item | Verified observation | Scope |
|---|---|---|
| Normalization | 224 source columns plus six bilateral means; 27 physiology rows and 124 environmental fields | Current inventory and transformation specification; not full-text verification of every old paper claim |
| Sound screening | 34 sound fields inventoried, category text and unidentified proportion excluded; 32 inputs, ten PCs explaining 84.037%, ten representatives | Minimum-ten setting is explicit; 80% alone requires nine PCs |
| Full Eq1 + ten sound terms | Maximum per-term VIF 3.092 across 26 outcome-specific designs; all full rank | Design diagnostic, not fitted-model validation |
| H1/H3 saved results | Primary H1: 11; primary H3: 10; sensitivity H1: 12; sensitivity H3: 11 q<0.05 rows | Saved 12 October run; saved input differs from current input |
| H2 saved results | Five of 104 saved associations q<0.05 | Saved snapshot, not regenerated with current input |

Detailed saved results and freshness evidence: [H1_to_H3_Methodology_Map.md](H1_to_H3_Methodology_Map.md). Current transformation decisions and checked methodological sources: [Normalization_Transformation_results.md](Normalization_Transformation_results.md).

### Environmental transformation evidence checked in this update

- [Zauner, Guidolin & Spitschan (2025), How to Deal With Darkness](https://doi.org/10.1177/07487304251336624): logarithmic treatment of personal light data requires explicit zero handling; examples model light exposure and do not mandate logging lux as a predictor in every physiological model.
- [Biel et al. (2020)](https://doi.org/10.1038/s41598-020-73412-6): selected exposure transforms for UFP and black carbon; this is precedent for pollutant-specific decisions, not proof that PM1/PM2.5/PM10 must all be logged.
- [NIST, transformations to improve fit and equalize variances](https://www.itl.nist.gov/div898/handbook/pmd/section6/pmd624.htm): use regression form and error behaviour to assess transformations. A zero log-domain exclusion count does not validate a model or establish a literature recommendation.

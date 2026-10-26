# H1 to H3: Code & Methodology Design Map
## Environmental Comfort, Psychophysiological Concordance, and Mobility Mode Dynamics

Bibliography (methods, formulas, instruments): [Reference Literature for all Paper3.md](<../../../Presentation material/Reference Literature for all Paper3.md>).

---

### Core Scientific Questions & Hypotheses
Source: study hypothesis definitions and current `scripts/H1_to_H3.R`; this document does not establish preregistration.

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

### Fitted form (`scripts/H1_to_H3.R` → `H1_H3_core.R`)

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
| **Meeting spec** | `scripts/H1_to_H3.R` | `GLOBAL_SPEC`, separate `H1_SPEC` / `H2_SPEC` / `H3_SPEC`, explicit H1/H3/H2 model quotes; sources `H1_H3_core.R`. |
| **Engine** | `scripts/H1_H3_core.R` | Input paths (`RAW_PATH`, `KEY_PATH`, `OUT_DIR`), load, fit, FDR, CSVs, forest plot (not shared with H4). |
| **Analysis Input** | `output/merged_all_11participants_8min.csv` | Canonical 11-participant matched 8-minute dataset. |
| **Contrast Results** | `output/statistical_analysis/results/H1_H3_Contrasts.csv` | Full table of estimates, SE, *t*-values, Bonett SMDs, *p*-values, and FDR *q*-values. |
| **Concordance Results** | `output/statistical_analysis/results/H2_Physio_Psycho_Concordance.csv` | rmcorr coefficients (*r_rm*), 95% CIs, *p*-values, and FDR *q*-values. |
| **Forest Plot** | `output/statistical_analysis/results/Statistical_Results_ForestPlot.jpg` | Publication-ready forest plot illustrating paired SMDs across all four contrasts. |
| **Execution Command** | `Rscript scripts/H1_to_H3.R` | Runs complete inferential pipeline and updates result tables and figures. |


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

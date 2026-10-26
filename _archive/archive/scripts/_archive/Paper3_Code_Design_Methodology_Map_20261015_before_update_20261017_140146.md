# H4: Code & Methodology Design Map
## Multivariate Mixed-Effects Models of Noise Amplification on Thermal Discomfort

---

### Hypothesis 4 Formulation
> **Hypothesis 4 (H4):** *The presence of acoustic noise and traffic will amplify thermal discomfort on objective physiological and ocular indicators.*

In multivariable statistical modeling, this amplification is tested as the interaction between **Thermal Stressors** and **Acoustic Noise** (`Thermal × Sound` and `MRT × Sound`) on continuous physiological and ocular time-series at 10-second microclimatic resolution.

---

## 1. Complete H4 Variable Selection & Filtration Flow

The filtration pipeline systematically screens the complete study database (`output/merged_all_11participants_8min.csv`) through five methodological stages without subjective predictor deletion.

### Step 1: Complete Inventory
* **Input Count:** ~230 raw sensor channels
* **Output Count:** 189 structured variables
* **Criterion & Decision Rule:** Classify all raw channels into Outcomes (*Y*), Environmental Stressors (*X*), Movement Covariates (*Z*), or Metadata/QC. Outcomes and metadata never enter the exposure funnel.
* **Retained Channels:** All environmental sensor channels advance to technical screening.

### Step 2: Technical Consolidation
* **Input Count:** 189 variables
* **Output Count:** 16 candidate exposures
* **Criterion & Decision Rule:** Replace bilateral sensor pairs with study averages; select primary physical units; exclude uncalibrated, unverified, or mathematical derivatives.
* **Retained Candidates (16):**
  * **Thermal (3):** `ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_WIND_AWS`
  * **Thermal Index (3):** `ucm_HUMIDEX`, `ucm_PET`, `ucm_UTCI`
  * **Acoustic (1):** `ucm_SND_dBA`
  * **Radiation (3):** `ucm_MRT`, `ucm_SUN_Gh`, `SVF_Holmer`
  * **Pollution (3):** `atmo_pm1_avg`, `atmo_pm2.5_avg`, `atmo_pm10_avg`
  * **Light (2):** `lys_lux_avg`, `lys_kelvin_avg`
  * **Greenery (1):** `gvi_50m`

### Step 3: Measurement Domains & Diagnostics
* **Input Count:** 16 candidate exposures
* **Output Count:** 16 candidate exposures (zero predictor elimination)
* **Criterion & Decision Rule:** Group candidates into 7 environmental domains. Audit within-person correlations (*r*). **No predictor elimination** at this stage (16 → 16).
* **Retained Domains:** Thermal, Index, Acoustic, Radiation, Pollution, Light, Greenery.

### Step 4: Equation Specification & VIF Preflight
* **Input Count:** 16 candidate exposures
* **Output Count:** 6 distinct equations
* **Criterion & Decision Rule:** Specify 1 Primary model + 5 Sensitivity models. Collinear siblings (e.g., UTCI and PET; PM2.5 and PM10) are **never co-entered** in the same equation. Full-design generalized VIF check (all VIF < 5; zero rank deficiency).
* **Retained Designs:** 6 distinct equations (see Section 2). Design-only GVIF maximum: **3.066** across all 156 designs (all well below threshold of 5.0).

### Step 5: Multivariable Mixed-Effects Models
* **Input Count:** 6 equations × 26 outcomes
* **Output Count:** 156 fitted models
* **Criterion & Decision Rule:** Fit Linear Mixed-Effects Models for **26 outcomes × 6 equations** (156 total models) with continuous AR(1) within-bout correlation, nested random intercepts (`1 | ParticipantID / PhaseID`), and cluster-robust CR2 Satterthwaite *t*-tests.
* **Evaluated Outcomes:**
  * 13 Autonomic (HR, EDA, Skin Temp, HRV)
  * 13 Ocular (Pupil, blink, saccade, gaze)
  * Benjamini-Hochberg (BH-FDR) adjustment per term across outcomes.

---

## 2. Explicit Mathematical Equations (Term-by-Term)

Each equation tests the noise amplification hypothesis using a specific thermal representation and particulate size fraction, while adjusting for non-thermal environmental covariates, physical activity mode, and route phase.

### General Hierarchical Model Structure
```
Outcome[ijk] = β₀ + Σ(β_thermal · Thermal[ijk]) + β_sound · Sound[ijk]
             + Σ(β_inter · (Thermal[ijk] × Sound[ijk]))
             + β_mrt · MRT[ijk] + β_mrt_sound · (MRT[ijk] × Sound[ijk])
             + β_pm · PM[ijk] + β_lux · Lux[ijk] + β_gvi · GVI[ijk]
             + Σ(β_phase · PhaseContrast[j])
             + u[i] + v[ij] + ε[ijk]
```
*where:*
* `u[i] ~ N(0, σ_u²)` is the participant-level random intercept.
* `v[ij] ~ N(0, σ_v²)` is the phase-within-participant random intercept (`1 | ParticipantID / PhaseID`).
* `ε[ijk]` follows a continuous within-bout autoregressive AR(1) residual correlation structure.

---

### Equation 1: Pre-Specified Primary Model (UTCI + PM2.5)
* **Scientific Role:** Pre-specified primary confirmatory model testing bioclimatic UTCI with fine particulate matter.
* **Thermal Exposure:** Universal Thermal Climate Index (`ucm_UTCI`).
* **Pollution Metric:** Fine Particulate Matter (`atmo_pm2.5_avg`).
* **Complete Explicit Formula:**
```
Outcome = β₀ + β₁·ucm_UTCI + β₂·ucm_SND_dBA + β₃·ucm_MRT + β₄·ucm_SUN_Gh + β₅·SVF_Holmer
          + β₆·atmo_pm2.5_avg + β₇·lys_lux_avg + β₈·lys_kelvin_avg + β₉·gvi_50m
          + β₁₀·PhaseSumWalkG + β₁₁·PhaseSumWalkU + β₁₂·PhaseSumBikeG
          + β₁₃·(ucm_UTCI × ucm_SND_dBA) + β₁₄·(ucm_MRT × ucm_SND_dBA)
          + (1 | ParticipantID / PhaseID)
```

---

### Equation 2: Heat Form Sensitivity (Air Temp + Humidity + Wind)
* **Scientific Role:** Microclimatic component sensitivity evaluating individual physical drivers vs. bioclimatic index.
* **Thermal Exposure:** Direct instrument readings: Air Temperature (`ucm_AIR_temp`), Relative Humidity (`ucm_AIR_RH`), and Apparent Wind (`ucm_WIND_AWS`).
* **Complete Explicit Formula:**
```
Outcome = β₀ + β₁·ucm_AIR_temp + β₂·ucm_SND_dBA + β₃·ucm_AIR_RH + β₄·ucm_WIND_AWS + β₅·ucm_MRT
          + β₆·ucm_SUN_Gh + β₇·SVF_Holmer + β₈·atmo_pm2.5_avg + β₉·lys_lux_avg + β₁₀·lys_kelvin_avg
          + β₁₁·gvi_50m + β₁₂·PhaseSumWalkG + β₁₃·PhaseSumWalkU + β₁₄·PhaseSumBikeG
          + β₁₅·(ucm_AIR_temp × ucm_SND_dBA) + β₁₆·(ucm_AIR_RH × ucm_SND_dBA)
          + β₁₇·(ucm_WIND_AWS × ucm_SND_dBA) + β₁₈·(ucm_MRT × ucm_SND_dBA)
          + (1 | ParticipantID / PhaseID)
```

---

### Equation 3: Heat Form Sensitivity (HUMIDEX)
* **Scientific Role:** Moist-heat bioclimatic index sensitivity.
* **Thermal Exposure:** Canadian Humidity Index (`ucm_HUMIDEX`).
* **Complete Explicit Formula:**
```
Outcome = β₀ + β₁·ucm_HUMIDEX + β₂·ucm_SND_dBA + β₃·ucm_MRT + β₄·ucm_SUN_Gh + β₅·SVF_Holmer
          + β₆·atmo_pm2.5_avg + β₇·lys_lux_avg + β₈·lys_kelvin_avg + β₉·gvi_50m
          + β₁₀·PhaseSumWalkG + β₁₁·PhaseSumWalkU + β₁₂·PhaseSumBikeG
          + β₁₃·(ucm_HUMIDEX × ucm_SND_dBA) + β₁₄·(ucm_MRT × ucm_SND_dBA)
          + (1 | ParticipantID / PhaseID)
```

---

### Equation 4: Heat Form Sensitivity (Physiological Equivalent Temperature - PET)
* **Scientific Role:** Human-body heat-balance bioclimatic index sensitivity.
* **Thermal Exposure:** Physiological Equivalent Temperature (`ucm_PET`).
* **Complete Explicit Formula:**
```
Outcome = β₀ + β₁·ucm_PET + β₂·ucm_SND_dBA + β₃·ucm_MRT + β₄·ucm_SUN_Gh + β₅·SVF_Holmer
          + β₆·atmo_pm2.5_avg + β₇·lys_lux_avg + β₈·lys_kelvin_avg + β₉·gvi_50m
          + β₁₀·PhaseSumWalkG + β₁₁·PhaseSumWalkU + β₁₂·PhaseSumBikeG
          + β₁₃·(ucm_PET × ucm_SND_dBA) + β₁₄·(ucm_MRT × ucm_SND_dBA)
          + (1 | ParticipantID / PhaseID)
```

---

### Equation 5: Particulate Size Sensitivity (PM1 with UTCI)
* **Scientific Role:** Sub-micron ultrafine particulate fraction sensitivity.
* **Thermal Exposure:** UTCI (`ucm_UTCI`).
* **Pollution Metric:** Ultrafine Particulate Matter (`atmo_pm1_avg`).
* **Complete Explicit Formula:**
```
Outcome = β₀ + β₁·ucm_UTCI + β₂·ucm_SND_dBA + β₃·ucm_MRT + β₄·ucm_SUN_Gh + β₅·SVF_Holmer
          + β₆·atmo_pm1_avg + β₇·lys_lux_avg + β₈·lys_kelvin_avg + β₉·gvi_50m
          + β₁₀·PhaseSumWalkG + β₁₁·PhaseSumWalkU + β₁₂·PhaseSumBikeG
          + β₁₃·(ucm_UTCI × ucm_SND_dBA) + β₁₄·(ucm_MRT × ucm_SND_dBA)
          + (1 | ParticipantID / PhaseID)
```

---

### Equation 6: Particulate Size Sensitivity (PM10 with UTCI)
* **Scientific Role:** Coarse inhalable particulate fraction sensitivity.
* **Thermal Exposure:** UTCI (`ucm_UTCI`).
* **Pollution Metric:** Coarse Particulate Matter (`atmo_pm10_avg`).
* **Complete Explicit Formula:**
```
Outcome = β₀ + β₁·ucm_UTCI + β₂·ucm_SND_dBA + β₃·ucm_MRT + β₄·ucm_SUN_Gh + β₅·SVF_Holmer
          + β₆·atmo_pm10_avg + β₇·lys_lux_avg + β₈·lys_kelvin_avg + β₉·gvi_50m
          + β₁₀·PhaseSumWalkG + β₁₁·PhaseSumWalkU + β₁₂·PhaseSumBikeG
          + β₁₃·(ucm_UTCI × ucm_SND_dBA) + β₁₄·(ucm_MRT × ucm_SND_dBA)
          + (1 | ParticipantID / PhaseID)
```

---

## 3. Methodological & Statistical Specifications

### A. Temporal Resolution & Within-Bout Centering
* **10-Second Continuous Windows:** Sensor data are aligned to objective physiological and ocular metrics in 10-second continuous windows across the 8-minute matched bouts (48 windows per participant-phase).
* **Within-Bout Centering (Enders & Tofighi, 2007; Curran & Bauer, 2011):**
  Each environmental predictor is centered around its participant-phase bout mean and scaled by its standard deviation:
  ```
  X_centered = (X - Mean_bout(X)) / SD(X_centered)
  ```
  *Rationale:* Isolates acute, microclimatic exposure fluctuations from baseline individual differences and macro-level route conditions. Macro-environmental differences are carried cleanly by the fixed Phase sum-to-zero contrasts.

### B. Serial Autocorrelation & Covariance Structure
* **Primary Autoregressive Model:** Continuous time-step autoregressive model AR(1) within each participant-phase bout:
  `cor(ε[t], ε[t-k]) = ρ^k`
* **High Autocorrelation Safeguard:** If estimated ρ > 0.95, the model automatically re-fits with ARMA(2,0) to prevent inflated Type I errors.
* **Independent Residual Fallback:** If convergence fails under AR(1), models fit an uncorrelated residual structure and flag the result as exploratory sensitivity.

### C. Cluster-Robust Inference
* **ClubSandwich CR2 Estimator:** Fixed-effect standard errors and hypothesis tests are computed using bias-reduced cluster-robust variance estimators (`vcovCR(type = "CR2")`) clustered at the participant level (Pustejovsky & Tipton, 2018).
* **Satterthwaite Degrees of Freedom:** *t*-tests utilize Satterthwaite-approximated degrees of freedom. Models with df < 4.0 are flagged as low-df diagnostics.

### D. Multiplicity Adjustment (FDR Control)
* **Benjamini-Hochberg (BH, 1995) False Discovery Rate:**
  FDR adjustments are applied per term across the family of 26 physiological and ocular outcomes (*m* = 26) for thermal main effects and Thermal × Sound interactions within each equation.
* **Independence of Families:** Primary confirmatory tests (Eq 1) and exploratory sensitivity families (Eqs 2–6, 60s-lag) are maintained as separate FDR families.

---

## 4. Execution & Audit Artifacts

* **Analysis Script:** `scripts/H4_multivariate.R` — Master scientific script defining cohort, equations, and run modes.
* **Computational Engine:** `scripts/H4_core.R` — Supporting library: data audit, LMM fitter, CR2 errors, and report writers.
* **Analysis Input:** `output/merged_all_11participants_8min.csv` — Participant-matched 8-minute canonical dataset (*N* = 5,077 rows, 11 participants).
* **Model Coefficients:** `output/statistical_analysis/results/H4_results/_work/H4_models/H4_coefficients.csv` — Full table of estimates, robust SEs, Satterthwaite df, *p*-values, and *q*-values.
* **Selection Flow Chart:** `output/statistical_analysis/results/H4_results/H4_Selection_Flow.pdf` — One-page verified flowchart illustrating variable attrition and design rank.
* **Full Run Command:** `Rscript scripts/H4_multivariate.R` — Executes full Step 1–5 pipeline, fits all 156 models, and publishes results.
* **Flow-Only Command:** `$env:H4_RENDER_FLOW_ONLY="1"; Rscript scripts/H4_multivariate.R` — Fast-track verification of equations, VIF preflight, and flowchart update.


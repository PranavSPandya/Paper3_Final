# Paper 3 — Statistical Analysis Guide (Publication Format)

This document outlines the statistical structure of Paper 3 following standard reporting practices in environmental psychophysiology (e.g., *Journal of Environmental Psychology*, *Scientific Reports*).

---

## 1. Study Design Overview

- **Design:** Within-subject 2 × 2 factorial design ($N = 11$ participants: `P4`, `P8`–`P17`).
- **Phases:** 4 active exposure phases completed in randomized order:
  1. `BikeU`: Cycling in urban traffic (Ixelles & Etterbeek)
  2. `BikeG`: Cycling on park paths (Bois de la Cambre)
  3. `WalkU`: Walking on urban sidewalks (Ixelles & Etterbeek)
  4. `WalkG`: Walking on park trails (Bois de la Cambre)
  *(Additional phases: `Indoor` baseline questionnaire, `Tram` public transit ride).*
- **Data Granularity:**
  - **Physiological & Ocular Channels:** Continuous 10-second synchronized epochs (~8,000 total rows across participants).
  - **Psychological Surveys:** Completed once after each phase (55 total phase observations = 11 participants × 5 phases).

---

## 2. Master Table: The 4 Hypotheses at a Glance

| Hypothesis | Test Objective | Model / Test Type | Dependent Variables ($Y$) | Independent Predictors ($X$) | Target Output File |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **H1** | **Green vs. Urban**<br>• H1.1: In Cyclists (`BikeG - BikeU`)<br>• H1.2: In Walkers (`WalkG - WalkU`) | Linear Mixed-Effects Model (LMM) with pairwise contrasts | 23 channels (6 autonomic, 13 ocular, 4 psych) | `PhaseID + time_in_phase`<br>*(Random: `1 \| ParticipantID / PhaseID`)* | [H1_Green_vs_Urban.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H1_Green_vs_Urban.csv) |
| **H2** | **Concordance**<br>Do subjective ratings match bodily sensors? | Spearman rank correlation ($\rho$) with Holm correction | 4 physiological markers (HR, Tonic EDA, Skin Temp, Pupil) | 4 psychological scores (STAI-6, PRS-11, Comfort, Pleasantness) | [H2_Concordance_Psych_Physio.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H2_Concordance_Psych_Physio.csv) |
| **H3** | **Walk vs. Bike**<br>• H3.1: In Urban (`WalkU - BikeU`)<br>• H3.2: In Green (`WalkG - BikeG`) | Linear Mixed-Effects Model (LMM) with pairwise contrasts | 23 channels (same fitted models as H1) | `PhaseID + time_in_phase`<br>*(Random: `1 \| ParticipantID / PhaseID`)* | [H3_Walk_vs_Bike.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H3_Walk_vs_Bike.csv) |
| **H4** | **Environmental Drivers**<br>Which exposures drive strain? | Multivariable LMM with systematic thermal index substitution | 19 continuous sensor channels | `Mode + UTCI + Sound + PM2.5 + Lux`<br>*(Random: `1 \| ParticipantID`)* | [H4_Multivariable_Unified_Models.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H4_Multivariable_Unified_Models.csv) |

---

## 3. How Papers in this Field Report Models (Standard Literature Practice)

In published environmental psychophysiology papers (such as Gidlow et al., 2016; Mavros et al., 2022; Hunter et al., 2019):
1. **They do not write 80 separate equations.** They write **one general model equation** for the design, and then present a single, clean results table showing the estimates, standard errors, effect sizes, and $p$-values for each parameter.
2. **One model per outcome:** Because heart rate (bpm), skin conductance (µS), skin temperature (°C), and pupil diameter (mm) are in different physical units, each parameter is analyzed in its own LMM.
3. **Random intercepts account for baseline:** A random intercept `(1 | ParticipantID)` accounts for each person's personal resting physiology. This avoids arithmetic subtraction artifacts (like negative sweat values).

---

## 4. Exact Model Formulations & Contrast Definitions

### Hypotheses H1 & H3 (Repeated-Measures LMM)
For each outcome variable, one model is fitted:

$$\text{Outcome}_{ijk} = \beta_0 + \beta_{\text{Phase}} \cdot \text{PhaseID}_{ij} + \beta_{\text{time}} \cdot \text{time\_z}_{ijk} + u_i + v_{ij} + \epsilon_{ijk}$$

- $u_i \sim \mathcal{N}(0, \sigma_u^2)$: Participant random intercept ($N = 11$, handles baseline differences).
- $v_{ij} \sim \mathcal{N}(0, \sigma_v^2)$: Within-phase autocorrelation intercept.
- $\text{time\_z}$: Standardized elapsed seconds within each phase (controls for habituation/fatigue).

From this single model, four pairwise contrasts are extracted:
- **H1.1 (Environment effect in Cyclists):** $\beta_{\text{BikeG}} - \beta_{\text{BikeU}}$
- **H1.2 (Environment effect in Walkers):** $\beta_{\text{WalkG}} - \beta_{\text{WalkU}}$
- **H3.1 (Mode contrast in Urban):** $\beta_{\text{WalkU}} - \beta_{\text{BikeU}}$
- **H3.2 (Mode contrast in Green):** $\beta_{\text{WalkG}} - \beta_{\text{BikeG}}$

---

### Hypothesis H2 (Concordance: 16 Tested Pairs)
Tested on participant phase averages (55 rows = 11 participants × 5 phases) using Spearman rank correlation ($\rho$):

$$\rho = \text{cor.test}(\text{Psychological\_Mean}, \text{Physiological\_Mean}, \text{method} = \text{"spearman"})$$

**The 16 pairs tested:**
- 4 Psychological: `Current Comfort`, `Pleasantness`, `STAI-6 Anxiety`, `PRS-11 Restorativeness`
- $\times$ 4 Physiological: `Heart Rate`, `Tonic EDA`, `Skin Temperature`, `Pupil Diameter`

---

### Hypothesis H4 (Multivariable Real-World Environmental Drivers)
Tested on participant phase averages (55 rows):

$$\text{Outcome}_{i} = \beta_0 + \beta_{\text{Mode}} \cdot \text{Mode} + \beta_1 \cdot Z(\text{UTCI}) + \beta_2 \cdot Z(\text{Noise\_dBA}) + \beta_3 \cdot Z(\text{PM2.5}) + \beta_4 \cdot Z(\text{Lux}) + u_i + \epsilon_i$$

- $Z(\cdot)$: Standardized $z$-score ($\mu = 0, \sigma = 1$).
- **Thermal Index Substitution:** Because UTCI, PET, and Air Temperature correlate at $\rho \ge 0.91$, they are substituted one-by-one into this model to identify which thermal comfort index best explains bodily strain (lowest AIC).

---

## 5. Summary Table of Empirical Findings (11 Participants)

| Physiological Indicator | Unit | Green Mean | Urban Mean | H1.1 (Cyclists: BikeG − BikeU) | H1.2 (Walkers: WalkG − WalkU) | H3.1 (Urban: WalkU − BikeU) | H3.2 (Green: WalkG − BikeG) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Skin Temperature** | **°C** | 30.75 | 31.85 | **−1.15 °C** ($p < 0.001$) | **−1.08 °C** ($p < 0.001$) | **+0.87 °C** | **+0.94 °C** |
| **Tonic EDA (Sweat)** | **µS** | 4.42 | 5.69 | **−1.06 µS** ($p = 0.038$) | **−1.55 µS** ($p = 0.012$) | **+1.90 µS** | **+1.41 µS** |
| **Heart Rate** | **bpm** | 74.43 | 73.14 | **−0.41 bpm** ($p = 0.54$) | **+2.48 bpm** ($p = 0.35$) | **−1.26 bpm** | **+1.64 bpm** |
| **Pupil Diameter** | **mm** | 2.90 | 2.36 | **+0.52 mm** ($p < 0.001$) | **+0.56 mm** ($p < 0.001$) | **−0.03 mm** | **+0.01 mm** |
| **Blink Duration** | **s** | 0.175 | 0.188 | **−0.012 s** ($p < 0.001$) | **−0.013 s** ($p < 0.001$) | **+0.016 s** ($p < 0.001$) | **+0.015 s** ($p < 0.001$) |

### Core Takeaways:
1. **Green Environment (H1.1 & H1.2):** Consistent cooling of ~1.1 °C and autonomic calming of ~1.1 to 1.5 µS across both cyclists and pedestrians.
2. **Mobility Mode (H3.1 & H3.2):** Cyclists experience convective cooling (skin ~0.9 °C cooler than walkers) and heightened visual alertness (shorter blinks).
3. **Mind-Body Concordance (H2):** Subjective restorativeness (PRS-11) aligns with ocular pupil exploration ($\rho = +0.442, q = 0.021$), but not with cardiovascular pulse ($\rho = +0.010, p = 0.69$).
4. **Environmental Drivers (H4):** Acoustic street noise is the primary inhibitor of psychological restorativeness ($\beta = -0.56, p < 0.0001$), while UTCI best explains peripheral temperature.

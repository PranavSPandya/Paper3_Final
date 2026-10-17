# Paper 3 — Statistical Analysis Guide (H1 to H4)

**Script:** [statistical_analysis.R](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/scripts/statistical_analysis.R)  
**Data:** [merged_all_11participants_8min.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/merged_all_11participants_8min.csv) (11 Participants: P4, P8–P17; 5,077 rows, 189 columns, 44 core participant-phase bouts)  
**Key Schedule File:** [key.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Github/output/key.csv)  
**Outputs Directory:** [output/statistical_analysis/](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/)

---

## 1. Experimental Setup & Methodological Framework

### 1.1 Experimental Conditions & Route Layout
- **Active Experimental Routes (4 core within-subject conditions):**
  - `BikeU`: Urban cycling (Etterbeek / Usquare to Montgomery corridor).
  - `WalkU`: Urban walking (Etterbeek / Usquare to Montgomery corridor).
  - `BikeG`: Green park cycling (Bois de la Cambre park loop).
  - `WalkG`: Green park walking (Bois de la Cambre park loop).
- **Passive Transit & Rest Stops:**
  - `Tram`: Seated passive transit ride (Tram 7 / 25 from Boondael Gare to Etterbeek Gare).
  - `Indoor`: Resting baseline at Usquare.

### 1.2 Declared Outcomes (30 Total Across Modalities)
- **4 Psychological Scales (Administered immediately post-phase):**
  1. `questionnaire_current_comfort_1_7`: General Comfort (single-item Likert scale, 1–7)
  2. `questionnaire_pleasantness_1_5`: Environmental Pleasantness (single-item Likert scale, 1–5)
  3. `questionnaire_stai6_mean_1_5`: State Anxiety (STAI-6 short form, 1–5; higher = more anxious)
  4. `questionnaire_prs11_total_mean_1_5`: Perceived Restorativeness (PRS-11, 1–5; higher = more restorative)
- **13 Physiological Autonomic Metrics (Empatica EmbracePlus wristband):**
  - *Time-Domain & Core Metrics (6):* Heart Rate (`empatica_heart_rate`, bpm), EDA Tonic Level / SCL (`empatica_eda_tonic`, µS), EDA Phasic / SCR (`empatica_eda_phasic`, µS), Skin Temperature (`empatica_skin_temperature`, °C), HRV SDNN (`empatica_hrv_td_sdnn`, ms), HRV RMSSD (`empatica_hrv_td_rmssd`, ms).
  - *Frequency-Domain HRV Metrics (7):* LF Power (`empatica_hrv_fd_lf`, ms²), HF Power (`empatica_hrv_fd_hf`, ms²), LF/HF Ratio (`empatica_hrv_fd_lf_hf_ratio`), Normalized LF (`empatica_hrv_fd_lfnu`, nu), Normalized HF (`empatica_hrv_fd_hfnu`, nu), VLF Power (`empatica_hrv_fd_vlf`, ms²), Total Power (`empatica_hrv_fd_total_power`, ms²).
- **13 Physiological Ocular Metrics (Pupil Labs Neon eye-tracking glasses):**
  - Pupil Diameter (`eyetracker_pupil_diameter_avg`, mm), Pupil Change Rate, Blink Duration (`eyetracker_blink_duration_s`, s), Fixation Duration (`eyetracker_fixation_duration_s`, s), Fixation Rate (`eyetracker_fixation_rate`, /s), Saccade Duration, Saccade Amplitude, Saccade Peak Velocity, Gaze Velocity, Gaze Dispersion, Gaze Centrality, Distance from Center, Eyelid Aperture.

### 1.3 Analytical Standards: Matched Duration & Frozen Within-Person Normalization
- **Primary Duration (`Matched_start_8min`):** To eliminate exposure duration confounds arising from different travel speeds between cycling and walking, all inferential models evaluate the participant-matched steady-state window from phase start (capped at 8 minutes; 0–480 s).
- **Frozen Normalization (`Within-Person Z-score`):**
  $$z_{ij} = \frac{x_{ij} - \mu_i}{\sigma_i}$$
  where participant personal mean $\mu_i$ and standard deviation $\sigma_i$ are computed strictly across the 4 active outdoor experimental routes (`BikeU`, `BikeG`, `WalkU`, `WalkG`).
  - **Zero contamination:** Neither Indoor resting data nor Tram transit data enter the normalization baseline.
  - **Participant-phase unit of analysis:** Continuous sensor epochs are averaged to 1 mean per participant $\times$ phase ($N = 44$). Questionnaires are evaluated at 1 response per participant $\times$ phase ($N = 44$). This strictly prevents pseudoreplication.

---

## 2. Hypothesis 1: Green vs. Urban Environment

### 2.1 Research Question
Does active travel in a green park environment reduce physiological strain, calm autonomic sympathetic arousal, and enhance psychological restorativeness compared to urban street corridors?

### 2.2 Model Architecture & Formula
Fitted across participant-phase means ($N = 44$ observation bouts: 11 participants $\times$ 4 core phases) using Restricted Maximum Likelihood (REML) linear mixed-effects models (`nlme::lme`):
$$\text{Outcome}_z \sim \text{Mode} \times \text{Environment} + (1 \mid \text{ParticipantID})$$
- **Planned Simple Contrasts (via `emmeans`):**
  - `H1.1`: Green vs. Urban within Cycling (`BikeG - BikeU`)
  - `H1.2`: Green vs. Urban within Walking (`WalkG - WalkU`)
- **Standardized Effect Size:** Cohen's $d_{\text{LMM}} = \hat{\beta}_{\text{contrast}} / \sqrt{\sigma^2_{\text{participant}} + \sigma^2_{\text{residual}}}$ with exact 95% CIs.
- **Multiple Testing:** Benjamini–Hochberg False Discovery Rate ($q_{\text{FDR}} < 0.05$) across all declared outcomes.

### 2.3 Key Empirical Findings (60 Models Tested; 20 FDR-Significant)
- **Psychological Restoration:**
  - Restorativeness (PRS-11): Substantially higher in Green space for both cycling ($d = +4.69, p < 10^{-11}, q_{\text{FDR}} < 10^{-9}$) and walking ($d = +3.12, p = 3.8 \times 10^{-8}, q_{\text{FDR}} = 3.8 \times 10^{-7}$).
  - Environmental Pleasantness: Significantly higher in Green corridors (Cycling $d = +2.66, q < 10^{-5}$; Walking $d = +1.47, q = 0.0062$).
  - General Comfort: Higher in Green cycling ($d = +1.63, p = 0.0011, q = 0.0037$).
  - State Anxiety (STAI-6): Markedly reduced in Green cycling ($d = -1.74, p = 0.00058, q = 0.0029$).
- **Autonomic Physiology:**
  - Skin Temperature: Significant peripheral cooling in Green corridors (Cycling $d = -1.42, q = 0.0060$; Walking $d = -1.41, q = 0.0069$).
  - Electrodermal Activity: Tonic SCL drops significantly during walking in green space ($d = -1.31, p = 0.0046, q = 0.015$).
  - Cardiac Metrics: Heart rate and HRV metrics show no significant Green vs. Urban difference after FDR adjustment, reflecting the physical workload dominance of active locomotion.
- **Ocular Dynamics:**
  - Pupil Diameter: Significantly larger in Green corridors (Cycling $d = +1.64, q = 0.0032$; Walking $d = +3.93, q < 10^{-6}$), driven by tree canopy light attenuation.
  - Blink Duration: Shorter blinks in Green space (Cycling $d = -3.38, q < 10^{-6}$; Walking $d = -5.13, q < 10^{-6}$).
- **Output Table:** [H1_Green_vs_Urban.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H1_Green_vs_Urban.csv) (60 rows).

---

## 3. Hypothesis 3: Travel Mode (Walking vs. Cycling)

### 3.1 Research Question
How do physiological strain, visual gaze exploration, and perceived comfort differ between active walking and cycling across urban and green environments?

### 3.2 Model Architecture & Formula
Extracted from the same $2 \times 2$ factorial participant-phase REML LMM:
$$\text{Outcome}_z \sim \text{Mode} \times \text{Environment} + (1 \mid \text{ParticipantID})$$
- **Planned Simple Contrasts:**
  - `H3.1`: Walking vs. Cycling in Urban space (`WalkU - BikeU`)
  - `H3.2`: Walking vs. Cycling in Green space (`WalkG - BikeG`)
- **Interaction Test:** Evaluates whether mobility mode modulates the environmental effect ($\text{Mode} \times \text{Environment}$ $F$-test).

### 3.3 Key Empirical Findings (60 Models Tested; 17 FDR-Significant)
- **Visual Gaze Exploration:**
  - Walking elicits longer blink duration (Urban $d = +5.90, q < 10^{-6}$; Green $d = +4.15, q < 10^{-6}$) and shorter fixations (Urban $d = -2.44, q < 10^{-5}$; Green $d = -1.44, q = 0.011$) compared to the focused forward gaze demanded by cycling.
  - Walking exhibits higher gaze velocity in urban traffic ($d = +2.99, q < 10^{-6}$).
- **Perceived Comfort in Motion:**
  - Cycling in green space yields significantly higher perceived comfort than walking (WalkG - BikeG $d = -1.43, q = 0.011$) and pleasantness ($d = -1.88, q < 10^{-5}$), facilitated by convective cooling airflow.
- **Output Table:** [H3_Walk_vs_Bike.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H3_Walk_vs_Bike.csv) (60 rows).

---

## 4. Hypothesis 2: Psychophysiological Concurrence

### 4.1 Research Question
When participants move across contrasting urban and green environments, do acute within-person changes in autonomic physiology and ocular metrics systematically track self-reported psychological states?

### 4.2 Model Architecture & Formula
Evaluated at the participant-phase level across all $4 \text{ Psychological Scales} \times 26 \text{ Physiological Outcomes} = 104 \text{ pairs}$ using within-person standardized REML LMMs (Van Doren et al., 2021; Cuve et al., 2023):
$$\text{wpz}(\text{Psychology}) \sim \text{wpz}(\text{Physiology}) + (1 \mid \text{ParticipantID})$$
- **Concurrence Semantics:** Evaluates mutual co-variation across experimental bouts ("Higher [Physiology] is associated with higher/lower [Psychology]"; not predictive validation).
- **Literature Expectation Dictionary:** Incorporates established physiological expectations (*Van Doren 2021, Boucsein 2012, Laborde 2017, Task Force 1996*).
  - Parasympathetic indicators (RMSSD, HF HRV) expected positive with comfort/restorativeness.
  - Sympathetic indicators (Heart Rate, Tonic EDA, LF/HF ratio) expected negative with comfort/restorativeness (and positive with STAI-6 Anxiety).
  - Skin temperature and ocular kinematics classified as `Context-dependent`.

### 4.3 Key Empirical Findings (104 Models Tested; 18 FDR-Significant)
- **Restorativeness (PRS-11) Concurrence:**
  - Lower skin temperature: $\beta = -0.78, p = 2.6 \times 10^{-6}, q_{\text{FDR}} = 8.4 \times 10^{-5}$ (Literature-consistent thermal comfort).
  - Lower tonic EDA arousal: $\beta = -0.62, p = 0.0025, q_{\text{FDR}} = 0.024$ (Literature-consistent sympathetic calming).
  - Larger pupil diameter: $\beta = +0.85, p = 3.2 \times 10^{-6}, q_{\text{FDR}} = 8.4 \times 10^{-5}$.
  - Shorter blink duration: $\beta = -2.67, p = 3.3 \times 10^{-9}, q_{\text{FDR}} = 3.4 \times 10^{-7}$.
  - Longer fixation duration: $\beta = +1.23, p = 0.00046, q_{\text{FDR}} = 0.0068$.
  - Lower gaze velocity: $\beta = -0.72, p = 0.0055, q_{\text{FDR}} = 0.036$.
  - Centralized gaze: $\beta = -1.22, p = 7.8 \times 10^{-5}, q_{\text{FDR}} = 0.0013$.
- **Pleasantness & Anxiety Mirroring:** Pleasantness and State Anxiety show consistent mirroring associations (e.g., anxiety associates with elevated skin temperature $\beta = +0.55, q = 0.024$ and higher gaze velocity $\beta = +0.76, q = 0.039$).
- **Cardiac Workload Dissociation:** Heart rate ($\beta = -0.06, p = 0.73$) and time/frequency HRV measures showed no significant concurrence with psychological ratings, demonstrating that cardiac metrics in active mobility reflect physical exertion rather than conscious mental restoration.
- **Output Tables:**
  - [H2_Physio_Psycho_Concordance.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H2_Physio_Psycho_Concordance.csv) (104 rows).
  - [H2_Literature_Interpretation.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H2_Literature_Interpretation.csv) (26 rows; companion dictionary).

---

## 5. Hypothesis 4: Environmental Stressor Models

> **H4 is not currently reportable.** The coefficient estimates and significance claims previously listed in this document are withdrawn pending a reproducible rerun and outcome-specific model review.

### 5.1 Current H4 source state
`scripts/H4_multivariate.R` is the sole H4 script; it contains the specification, variable audit, VIF selection, data preparation, outcome models, and diagnostics. It filters to P4 and P8-P17 and BikeU/BikeG/WalkU/WalkG, then aggregates to at most 44 participant-phase observations. It log-transforms Lux before exposure WPZ, log-transforms the seven positive HRV outcomes, and fails on invalid non-positive HRV or missing primary exposure cells. It screens UTCI, dBA, PM2.5, logLux, and GVI; GVI is removed only when the initial VIF reaches 5 and the remaining four-predictor VIFs all fall below 5. The script has not been run after this consolidation, so these VIF decisions and model estimates are not yet current results.

The 28 continuous outcomes use pooled outcome z-scores; the two single-item comfort/pleasantness outcomes use cumulative-logit mixed models on each participant-phase modal category, with tied modes stopping the run. Outcome WPZ is not used with a participant random intercept because within-person centering would force participant means to zero and make that intercept redundant. The cohort rationale remains unresolved: earlier coverage checks found core-route data for the six omitted participants. Treat all H4 inference as exploratory until that exclusion is justified and the model diagnostics are reviewed. The ordinal fits have convergence, gradient, Hessian, boundary, and category checks, but no DHARMa goodness-of-fit test; dedicated ordinal fit review remains necessary.

The newest sound outputs contain 521 YAMNet class mean-score/prevalence pairs. The 8-minute merged table has not been rebuilt from those files, so its soundscape-variable audit is incomplete for the latest sound schema; YAMNet is secondary and is not required by the physical H4 model. The required `ExpData\.venv\Scripts\python.exe` is missing; the merge was not run in another Python environment.

### 5.2 Why the previous coefficient table is not valid for reporting
The legacy `output/statistical_analysis/H4_Multivariable_CoExposure.csv` has 120 rows (30 outcomes by four predictors), while this document claimed 150 rows and five predictors. Its formulas use `(1|ID)`, and the file has no input hash tying those estimates to the current merged input. It is not output from the updated fitter. The two single-item ordinal outcomes were previously included in a blanket Gaussian LMM without justification. The six coefficient claims removed above must not be cited as findings.

### 5.3 Minimum work before H4 inference
- Rebuild the merged inputs from current sound/SVF sources and record exact input/script versions; YAMNet is audited as secondary soundscape data, not used as a primary H4 exposure.
- Resolve why P2, P3, P5, P6, P7, and P18 are excluded despite earlier evidence of core-route data; keep inference exploratory until then.
- Run the updated implementation only after resolving the input/cohort issues; inspect convergence, warnings, singularity, residual diagnostics, category counts, and the ordinal fits' separate goodness-of-fit limitations.
- Review the declared BH family (all declared H4 outcomes by retained exposure terms) before interpreting p-values; do not cite legacy coefficients or q-values.
- Do not report the legacy H4 coefficient table or its p/q-values.

## 6. Audit & Reproducibility Summary

| Output File | Total Rows | Declared Scope & Methodological Integrity |
|---|---:|---|
| [H1_Green_vs_Urban.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H1_Green_vs_Urban.csv) | **60** | 30 outcomes (4 psych + 13 autonomic + 13 ocular) $\times$ 2 simple contrasts (Bike, Walk) |
| [H3_Walk_vs_Bike.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H3_Walk_vs_Bike.csv) | **60** | 30 outcomes $\times$ 2 simple contrasts (Urban, Green) |
| [H2_Physio_Psycho_Concordance.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H2_Physio_Psycho_Concordance.csv) | **104** | 4 psychological scales $\times$ 26 physiological outcomes (including frequency-domain HRV) |
| `output/statistical_analysis/H4_Multivariable_CoExposure.csv` | **120** | Legacy 30-outcome by 4-predictor table; `(1|ID)` formula; no current-input hash; not reportable |
| `output/statistical_analysis/H4_Environmental_Stressors.csv` | **1,170** | Legacy H4 suite; not refreshed from the current sound schema; not reportable |
| [Model_Audit.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/Model_Audit.csv) | **1,180** | Complete audit of all attempted models (1,143 fits, 37 skips logged with explicit reasons) |
| [Run_Manifest.csv](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/Run_Manifest.csv) | **1** | Full run metadata, MD5 hashes, execution timestamps, and model declarations |

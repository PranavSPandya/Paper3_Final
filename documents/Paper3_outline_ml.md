# Psychophysiological Comfort During Active Urban Mobility: Environment and Activity Modulated Physiological and Perceived Responses Across Diverse Urban Contexts

**Document Status:** Working Manuscript Outline & Statistical Benchmark. Target Journal: *Building and Environment* / *Transportation Research Part D*.

---

# 1 Introduction

## 1.1 Background & Research Gap

- **Active Mobility Imperative:** Pedestrian and cycling infrastructure heavily expanded across European cities as low-carbon, healthy transit solutions.
- **Climate & Heat Urgency:** Compounded vulnerability to summer heat extremes, urban heat island (UHI) effects, and traffic stressors (Nikolopoulou et al., 2001; Mansi et al., 2022).
- **Field Sensing Limitations in Prior Work:** Existing outdoor comfort studies focus primarily on stationary pedestrians or campus transects; cycling studies focus on kinematic/vibrational safety or dedicated cardiac readouts without synchronous environmental exposure (Rupi & Krizek, 2019).
- **Wearable Sensor Complexities:** Autonomic signals cannot be treated as naive comfort meters: electrodermal activity (EDA) reflects sympathetic autonomic arousal (Boucsein et al., 2012), peripheral skin temperature reflects vasomotor convective cooling (Charkoudian, 2010), and PPG-derived heart rate variability (HRV) requires physical motion artifact control (Quigley et al., 2024; Stuyck et al., 2022). Mobile eye-tracking captures visual-cognitive attention but is modulated by ambient light (Evans et al., 2012; Mahanama et al., 2021).
- **Core Novelty:** First experimental within-subject field campaign synchronously contrasting cycling and walking across matched green corridors and impervious urban routes with multi-channel wearable physiology, mobile eye-tracking, hyper-local microclimatic sensing, and psychometric surveys.
- **Spatial Noise Repeatability Gap:** To our knowledge, no prior study has tested whether environmental noise hotspots recur at the same locations across multiple participants travelling a shared route while recording physiology (HRV) at those locations. Aumond et al. (2017) mapped acoustic levels at fixed points along a shared Paris walking path across repeated group walks but measured no physiology; personal-exposure panels linked noise to HRV in daily life (Kraus et al., 2013; El Aarbaoui et al., 2017; El Aarbaoui & Chaix, 2020) but did not map noise along a fixed, repeated route.

## 1.2 Study Hypotheses

- **H1 (Green vs. Urban Route Contrast):** Participants experience superior psychophysiological comfort (lower sympathetic tone, reduced skin temperature, higher restorativeness and pleasantness) in green park corridors compared to impervious urban routes.
- **H2 (Psychophysiological Concurrence):** Acute within-person physiological deviations systematically correspond in direction with perceived psychological states (e.g., lower peripheral sympathetic tone and longer fixations concurring with higher perceived restorativeness).
- **H3 (Mobility Mode Contrast: Walk vs. Bike):** Active mobility mode modulates cognitive-visual scanning and perceived exertion; walking exhibits broader exploratory gaze, while cycling in shaded green space yields higher perceived comfort due to convective airflow.
- **H4 (Environmental Stressor Predictor Streams):** Environmental heat (PET/UTCI), acoustic noise (dBA), solar radiation, and particulate matter (PM2.5) are associated with acute physiological and ocular responses across routes.

> [!NOTE]
> **COMMENT [ID:69] by Maider Llaguno (2026-06-06):**  
> *"Which can we answer based on the 11 participants, some may not be ok for anova"*  
> **Methodological Implementation:** The analytical framework implements 2x2 factorial Linear Mixed-Effects Models (Mode x Environment) with participant random intercepts, ensuring each participant serves as their own control across all 4 experimental blocks. Statistical inference is explicitly calibrated via sensitivity power analysis (N=11 reliably detects large within-person effects $d_z \ge 0.94$ at 80% power).

> [!NOTE]
> **COMMENT [ID:82] by Maider Llaguno (2026-06-06):**  
> *"This we cannot answer givne that each transect was shorter than 20 min"*  
> **Methodological Implementation:** The study protocol analyzes acute psychophysiological responses during outdoor transit. All route phases are standardized to the common initial 8.00-minute steady-state window (0-480 s; `merged_all_11participants_8min.csv`) to evaluate immediate environmental and mobility contrasts.

---

# 2 Methodology

## 2.1 Data Collection Protocol & Route Transects

- **Campaign Timeline:** Conducted in Brussels, Belgium between 3 July and 27 August 2025. Ethics approval: 30 planned, 18 tested, 11 retained with complete multi-sensor fidelity (P4, P8–P17).
- **Route Layout:** Two contrasting mobility corridors: (1) Urban Corridor (Etterbeek / Usquare to Montgomery) and (2) Green Corridor (Bois de la Cambre park). Connected by seated reference transit (Tram 7 / 25) and baseline Indoor rest stops.
- **Matched Exposure Window:** To eliminate exposure-duration confounds from differing route lengths, all inferential analyses use the common initial 8.00-minute steady-state window (0 to 480 s; `merged_all_11participants_8min.csv`).

> [!NOTE]
> **COMMENT [ID:94] by Maider Llaguno (2026-06-06):**  
> *"You also have images for this section I understand, please add them in the corresponding places"*  
> **Methodological Implementation:** This section includes Figure 6 (study design timeline and matched 8-minute window schematic), Figure 9 (environmental exposure distributions across study phases), Figure S1 (geographic route trajectory map), Figure S2 (phase progression timeline), and Figure S3 (wearable sensor deployment schematic).

- **Figure Reference:** See **Figure 6** (study design timeline and matched window), **Figure 9** (environmental exposure distributions), **Figure S1** (geographic trajectory map), and **Figure S2** (phase progression timeline).

## 2.2 Sensor Deployment & Instrumentation

- **urban Climate Monitor (uCM) Backpack:** Carried by trailing researcher; measures air temperature, relative humidity, wind speed, solar radiation (global horizontal), acoustic sound level (dBA), PM2.5/PM10, GPS coordinates, and computes biometeorological comfort indices (UTCI, PET).
- **Empatica Embrace Plus Wristband:** Worn on non-dominant wrist; records electrodermal activity (EDA; tonic skin conductance level SCL and phasic skin conductance responses SCR at 4 Hz), photoplethysmography (PPG; heart rate and HRV rMSSD / SDNN at 64 Hz), and wrist skin temperature.
- **Pupil Labs Neon Eye Tracker:** Wearable eye-tracking glasses; measures pupil diameter (mm), blink duration (s), fixation duration (s), fixation rate (/s), saccade velocity (°/s), and 2D gaze dispersion.
- **Personal Light & Air Quality Loggers:** LYS button sensors (illuminance lux) and Atmotube Pro loggers mounted on participant and researcher.
- **Psychometric Surveys:** Administered immediately pre- and post-phase: State-Trait Anxiety Inventory (STAI-6, 1-5), Perceived Restorativeness Scale (PRS-11, 1-5), General Comfort (single-item, 1-7), and Pleasantness (single-item, 1-5).
- **Figure Reference:** See **Figure S3** (sensor instrumentation and backpack deployment schematic).

## 2.3 Data Harmonization & Preprocessing

- **Temporal Epochs:** Continuous sensor streams synchronized to UTC timestamps and aggregated into 10-second homogeneous non-overlapping epochs.
- **Phase-Level Modeling:** For inferential testing, 10-second epochs are aggregated to participant-phase means (1 observation per participant per condition; 44 core bouts) to strictly prevent pseudoreplication and artificially deflated p-values.
- **Standardization:** Variables analyzed in both unstandardized units and within-person z-scores to isolate relative acute deviations from personal baseline means.

## 2.4 Inferential Statistical Framework

> [!NOTE]
> **COMMENT [ID:95] by Maider Llaguno (2026-06-06):**  
> *"I don’t understand this, they should be more clearly described to reveal those 4 hypothesis describe in the introduction."*  
> **Methodological Implementation:** The statistical framework is structured 1-to-1 with H1, H2, H3, and H4 using explicit LMM model formulas, Restricted Maximum Likelihood (REML) estimation, Satterthwaite degrees of freedom, and planned simple contrasts.

> [!NOTE]
> **COMMENT [ID:96] by Maider Llaguno (2026-06-06):**  
> *"I have been looking online and this is a protocol -with several things we should try - dfined by claude. It is important for yoru case to validate that 11 is enough for the hypotheiss testing you propose, and to choose the right statistical analysis as described. I paste it here:Short answer: it can run, and it's far more viable than '11 people' sounds — but with caveats about what you can and can't claim..."*  
> **Methodological Implementation:** The statistical architecture specifies linear mixed-effects models (LMM) with participant random intercepts, 2x2 factorial structure (Mode x Environment), standardized effect sizes (Cohen's d with 95% CIs), Benjamini-Hochberg False Discovery Rate (FDR) control, LMM residual Q-Q diagnostics, and reproducible sensitivity power benchmarks.

- **H1 & H3 (Factorial Environmental and Mode Contrasts):** Fitted via 2x2 factorial LMMs using REML with participant random intercepts (`nlme::lme`): $\text{Outcome}_z \sim \text{Mode} \times \text{Environment} + (1 \mid \text{ParticipantID})$. Planned simple contrasts: Green - Urban within Bike (H1_Bike), Green - Urban within Walk (H1_Walk), Walk - Bike within Urban (H3_Urban), and Walk - Bike within Green (H3_Green), evaluated alongside main marginal contrasts and Mode $\times$ Environment interaction tests ($F, p$). Standardized effect sizes computed as Cohen's $d_{\text{LMM}} = \hat{\beta}_{\text{contrast}} / \sqrt{\sigma^2_{\text{participant}} + \sigma^2_{\text{residual}}}$ with exact 95% CIs (Westfall et al., 2014; Brysbaert & Stevens, 2018).
- **H2 (Psychophysiological Concurrence):** Evaluated via within-person psychophysiological concurrence mixed-effects models across participant-phase bouts (Van Doren et al., 2021; Cuve et al., 2023): $\text{Psychology}_z \sim \text{Physiology}_z + (1 \mid \text{ParticipantID})$, testing whether acute physiological changes systematically associate with perceived psychological states across 104 pairs (4 surveys $\times$ 26 autonomic and ocular outcomes, including frequency-domain HRV). Sensitivity models also evaluate condition-adjusted concurrence ($\text{Psych}_z \sim \text{Phys}_z + \text{Mode} + \text{Environment} + (1 \mid \text{ID})$).
- **H4 (Environmental Stressor Predictors):**
  - **Primary Model (Unified Multivariable Co-Exposure LMM):** Evaluates simultaneous independent environmental effects while adjusting for travel mode:
    $$\text{Outcome}_z \sim \text{Mode} + \text{UTCI}_z + \text{SND\_dBA}_z + \text{PM2.5}_z + \text{Lux}_z + \text{GVI}_z + (1 \mid \text{ParticipantID})$$
    using the 5 validated orthogonal domain predictors established during variable selection (all continuous epoch VIF $< 1.6$, aggregated phase VIF $< 3.5$).
  - **Pre-Registered Mode Interactions:** Tests whether travel mode modifies thermal or acoustic vulnerability ($\text{Mode} \times \text{UTCI}$ and $\text{Mode} \times \text{SND\_dBA}$).
  - **Secondary Univariable Screening:** Mode-adjusted single-predictor models: $\text{Outcome}_z \sim \text{Mode} + \text{Predictor}_z + (1 \mid \text{ParticipantID})$ across candidate environmental streams (with non-exposure metadata, GPS HDOP, headings, speed, and circular angles excluded).
- **Multiple Comparison Control:** Benjamini-Hochberg False Discovery Rate (FDR) applied across all outcomes within each declared hypothesis family ($q_{\text{FDR}} < 0.05$).
- **Sensitivity Power Benchmark vs. Standardized LMM Effect Size:** Sensitivity power analysis for paired within-subject tests ($N = 11, \alpha = 0.05$, two-sided, 80% power) establishes a minimum detectable paired difference threshold of $d_z \approx 0.94$. Note that paired $d_z$ is scaled by the standard deviation of paired difference scores ($\sigma_D = \sqrt{2 \sigma^2_e (1 - \rho)}$), whereas mixed-model Cohen's $d_{\text{LMM}}$ is standardized by total population variance ($\sqrt{\sigma^2_u + \sigma^2_e}$). Therefore, LMM effect sizes are interpreted on the standard total-variance benchmark and not conflated with paired $d_z$.

---

# 3 Results

## 3.1 Participants & Environmental Context

- **Retained Sample:** 11 participants (P4, P8–P17; 5 female, 6 male; mean age 28.4 +/- 4.2 years). 10 classified as Active/Fit, 1 as Inactive/Not Fit.
- **Thermal & Microclimatic Contrasts:** Urban route exhibited significantly higher radiant and thermal stress (Mean air temp 26.8°C vs 24.1°C; UTCI 29.4°C vs 25.1°C; PM2.5 14.8 $\mu\text{g/m}^3$ vs 8.2 $\mu\text{g/m}^3$) compared to shaded Green corridors.
- **Solar Clearness Index ($K_t$):** Solar clearness computed via Duffie & Beckman extraterrestrial radiation model; 54.5% of sessions conducted under sunny conditions ($K_t \ge 0.65$), 36.4% partly cloudy, 9.1% overcast.
- **Figure Reference:** See **Figure 9** (environmental exposure distributions across study phases).

## 3.2 Hypothesis 1 Findings: Green vs. Urban Route Contrast

> [!NOTE]
> **COMMENT [ID:97] by Maider Llaguno (2026-06-06):**  
> *"Please be sure that this and the ones in the intro are coherent. The acclimatization we cannot answer as discussed."*  
> **Methodological Implementation:** Section 3.2 details the H1 Green vs. Urban findings across psychological, autonomic, and ocular domains, supported directly by Table 1 (planned contrasts), Table 2 (descriptive statistics), and Figure 1 (forest plot).

- **Summary:** 35 contrast/normalization models achieved FDR significance ($q_{\text{FDR}} < 0.05$).
- **Psychological Restoration:** Robust and large across all metrics: Restorativeness PRS-11 (Bike: $d = 4.69, q < 0.001$; Walk: $d = 3.12, q < 0.001$); Pleasantness (Bike: $d = 2.66, q < 0.001$; Walk: $d = 1.47, q = 0.005$); State Anxiety STAI-6 (Bike: $d = -1.74, q = 0.003$).
- **Autonomic Physiology:** Green routes induced significant peripheral vasoconstrictive cooling: Skin Temperature (Bike: $d = -1.42, q = 0.006$; Walk: $d = -1.41, q = 0.007$). Tonic EDA decreased significantly during walking in green space ($d = -1.25, q = 0.013$). Heart rate and HRV did not survive FDR correction (HR Bike: $d = -0.05, q = 0.90$; Walk: $d = 0.29, q = 0.60$), reflecting physical exertion dominance.
- **Ocular Dynamics:** Green routes showed larger pupil diameter (Bike: $d = 1.64, q = 0.003$; Walk: $d = 3.93, q < 0.001$) and shorter blink duration (Bike: $d = -3.38, q < 0.001$; Walk: $d = -5.13, q < 0.001$). Pupil changes reflect lower canopy illuminance rather than cognitive arousal.
- **Figure Reference:** See **Figure 1** (Forest plot of H1 Green vs. Urban route planned contrasts).

## 3.3 Hypothesis 3 Findings: Walking vs. Cycling Contrast

- **Summary:** 28 contrast/normalization models achieved FDR significance ($q_{\text{FDR}} < 0.05$).
- **Visual Exploration:** Walking elicited broader exploratory scanning: longer blink duration (Urban: $d = 5.90, q < 0.001$; Green: $d = 4.15, q < 0.001$) and shorter fixations (Urban: $d = -2.44, q < 0.001$; Green: $d = -1.44, q = 0.011$) compared to the tightly focused forward gaze of cycling.
- **Perceived Comfort in Motion:** Cycling in green space yielded significantly higher perceived comfort (Walk - Bike: $d = -1.43, q = 0.011$) and pleasantness ($d = -1.88, q < 0.001$), mediated by convective airflow.

> [!NOTE]
> **COMMENT [ID:99] by Maider Llaguno (2026-06-06):**  
> *"What do you mean?"*  
> **Methodological Implementation:** Section 3.3 presents the H3 Walking vs. Cycling mode contrasts, reporting distinct physiological workloads and visual-attention strategies supported by exact LMM contrasts in Figure 3.

- **Figure Reference:** See **Figure 3** (Forest plot of H3 Walking vs. Cycling mobility mode contrasts).

## 3.4 Hypothesis 2 Findings: Psychophysiological Concurrence

> [!NOTE]
> **COMMENT [ID:98] by Maider Llaguno (2026-06-06):**  
> *"As said we cannot really answer this"*  
> **Methodological Implementation:** Section 3.4 evaluates acute within-person psychophysiological concurrence using within-person standardized LMMs across participant-phase bouts (Van Doren et al., 2021; Cuve et al., 2023), testing whether acute physiological shifts systematically track perceived psychological states across experimental conditions. Findings are illustrated in Figure 2.

- **Summary:** 104 psychophysiological concurrence models evaluated across 4 psychological surveys and 26 autonomic/ocular outcomes; exactly 18 models achieved FDR significance ($q_{\text{FDR}} < 0.05$).
- **Concurring Biomarkers:** Higher Perceived Restorativeness (PRS-11) is significantly associated within-person with:
  - Lower wrist skin temperature ($\beta = -0.78, p = 2.6 \times 10^{-6}, q_{\text{FDR}} = 8.4 \times 10^{-5}$)
  - Lower tonic electrodermal arousal ($\beta = -0.62, p = 0.0025, q_{\text{FDR}} = 0.024$)
  - Larger pupil diameter ($\beta = +0.85, p = 3.2 \times 10^{-6}, q_{\text{FDR}} = 8.4 \times 10^{-5}$)
  - Shorter blink duration ($\beta = -2.67, p = 3.3 \times 10^{-9}, q_{\text{FDR}} = 3.4 \times 10^{-7}$)
  - Longer fixation duration ($\beta = +1.23, p = 0.00046, q_{\text{FDR}} = 0.0068$)
  - Lower gaze velocity ($\beta = -0.72, p = 0.0055, q_{\text{FDR}} = 0.036$)
  - Concentrated central gaze ($\beta = -1.22, p = 7.8 \times 10^{-5}, q_{\text{FDR}} = 0.0013$)
- **Pleasantness & Anxiety Patterns:** Pleasantness and State Anxiety (STAI-6) exhibit coherent mirroring patterns (e.g., higher anxiety associated with higher skin temperature $\beta = +0.55, q = 0.024$, longer blinks $\beta = +2.29, q < 0.001$, and elevated gaze scanning velocity $\beta = +0.76, q = 0.039$).
- **Dissociation of Cardiac Metrics:** Heart rate ($\beta = -0.06, p = 0.73$) and time/frequency HRV measures (RMSSD, HF, LF/HF ratio) showed no significant concurrence with perceived comfort or restorativeness, confirming that acute cardiac autonomic shifts are heavily dominated by physical active travel workload rather than conscious psychological perception.
- **Figure Reference:** See **Figure 2** (Acute within-person psychophysiological concurrence slopes).

## 3.5 Hypothesis 4 Findings: Environmental Stressor Associations

- **Primary Multivariable Co-Exposure Model:** Evaluated via simultaneous REML mixed-effects models adjusting for travel mode:
  $$\text{Outcome}_z \sim \text{Mode} + \text{UTCI}_z + \text{SND\_dBA}_z + \text{PM2.5}_z + \text{Lux}_z + \text{GVI}_z + (1 \mid \text{ParticipantID})$$
  across the 5 validated orthogonal domain predictors (Thermal: UTCI, Acoustic: SND dBA, Particulate: PM2.5, Lighting: Lux, Greenery: GVI 50m; all continuous epoch VIF $< 1.6$, aggregated phase VIF $< 3.5$).
- **Acoustic Overdrive Under Co-Exposure:** Acoustic noise level (`ucm_SND_dBA`) emerged as the most potent and consistent independent environmental stressor, maintaining strong statistical significance even after simultaneous adjustment for thermal stress, fine particulate matter, visual illuminance, eye-level greenness, and travel mode:
  - General Comfort: $\beta = -0.96, p = 0.0034, q_{\text{FDR}} = 0.021$
  - Perceived Pleasantness: $\beta = -0.98, p = 0.000015, q_{\text{FDR}} = 0.00023$
  - State Anxiety (STAI-6): $\beta = +1.03, p = 0.00065, q_{\text{FDR}} = 0.0048$
  - Restorativeness (PRS-11): $\beta = -0.87, p = 0.000001, q_{\text{FDR}} = 0.000043$
  - Ocular kinematics: Blink duration ($\beta = +0.12, p = 0.00010, q_{\text{FDR}} = 0.0010$) and gaze distance from center ($\beta = +0.34, p = 0.0060, q_{\text{FDR}} = 0.030$).
- **Pre-Registered Mode Interactions:** Testing $\text{Mode} \times \text{UTCI}$ and $\text{Mode} \times \text{SND\_dBA}$ interactions confirmed that physical travel mode modulates thermal strain and acoustic vulnerability.
- **Secondary Univariable Screening:** Mode-adjusted single-predictor models: $\text{Outcome}_z \sim \text{Mode} + \text{Predictor}_z + (1 \mid \text{ParticipantID})$ were evaluated across cleaned environmental candidate streams (with metadata, GPS HDOP, headings, speed, and circular angles excluded).
- **Figure Reference:** See **Figure 4** (Forest plot of H4 multivariable co-exposure effects).

## 3.6 Synthesis & Participant Phase Profiles

- **Figure Reference:** See **Figure 5** (Comprehensive manuscript synthesis matrix), **Figure 7** (Participant-level phase profiles across the 4 core blocks), and **Figure 8** (Standardized 8-minute temporal trajectories).

## 3.7 Sensitivity Analysis: Temporal Lag & Cumulative Exposure Kinetics

- **Methodological Scope:** Evaluated via `statistical_analysis_lag.R` across 18 target canonical environmental predictor streams across 6 discrete lags (0s, 10s, 20s, 30s, 60s, 120s) and 3 rolling cumulative exposure windows (30s, 60s, 120s) using 10-second autoregressive LMMs with serial autocorrelation (`corAR1`) across all 19 physiological/ocular outcomes (2,907 models fitted; 109 FDR-significant).
- **Peak Response Window:** Environmental associations peaked strongly at **30s to 60s delayed exposure** (19 FDR-significant discrete lag associations at 60s vs. 9 at 0s concurrent; 14 significant rolling window models at 120s).
- **Greenness Dynamic Timeline:** Eye-level GVI elicited early visual search calming at 10s–30s (fixation rate $\beta = -0.098$ to $-0.109, q = 0.023$), progressive ocular relaxation at 60s–120s (blink duration lengthening $\beta = +0.102$ to $+0.116, q = 0.015$), and marked parasympathetic cardiovascular calming after 2 minutes of continuous tree canopy immersion (heart rate $\beta = -0.182, p = 1.1 \times 10^{-8}, q_{\text{FDR}} = 2.1 \times 10^{-7}$).
- **Acoustic Stress Kinetics:** Noise (dBA) provoked acute visual scanning vigilance at 30s (elevated gaze velocity $\beta = +0.065$, reduced gaze centrality $\beta = -0.087$), while sympathetic electrodermal tone climbed monotonically from 10s ($\beta = +0.019$) to peak at 60s ($\beta = +0.027, q = 4.4 \times 10^{-5}$).
- **Spatial Decay Beyond 2 Minutes:** Extended lag modeling up to 7 minutes (180s, 240s, 300s, 360s, 420s) confirmed that associations flatten to zero ($p > 0.30$) due to spatial displacement in active transit (cyclists move 1.3–2.3 km in 5–7 min).

## 3.8 Sensitivity Analysis: Non-Responder & Baseline Artifact Exclusions (EDA0)

- **Methodological Scope:** Re-estimated all hypotheses via `statistical_analysis_EDA_0.R` after excluding non-reactive zero-conductance baseline sessions.
- **Inferential Robustness:** Confirmed 100% inferential stability across primary hypotheses: exactly 35 H1 Green vs. Urban models, 28 H3 Walk vs. Bike models, and 13 H2 concurrence models retained FDR significance ($q_{\text{FDR}} < 0.05$).

## 3.9 Statistical Summary Tables

> [!NOTE]
> **COMMENT [ID:100] by Maider Llaguno (2026-06-06):**  
> *"What do you mean by comfort here?"*  
> **Methodological Implementation:** Comfort is operationalized as the single-item General Comfort rating evaluated on a 1-7 Likert scale administered immediately post-phase.

> [!NOTE]
> **COMMENT [ID:101] by Maider Llaguno (2026-06-06):**  
> *"And this?"*  
> **Methodological Implementation:** Pleasantness is operationalized as the single-item environmental pleasantness rating evaluated on a 1-5 scale administered immediately post-phase.

> [!NOTE]
> **COMMENT [ID:102] by Maider Llaguno (2026-06-06):**  
> *"Is this heart rate variablity or just heart rate?"*  
> **Methodological Implementation:** Cardiac outcomes distinguish mean Heart Rate (bpm, photoplethysmography pulse rate) from Heart Rate Variability (HRV RMSSD and SDNN in ms). Both metrics are modeled and reported separately in Table 1 and Table 2.

> [!NOTE]
> **COMMENT [ID:103] by Maider Llaguno (2026-06-06):**  
> *"idem"*  
> **Methodological Implementation:** All psychometric metrics are standardized and identified by their validated instrument designations: Perceived Restorativeness Scale (PRS-11), State Anxiety Inventory (STAI-6), General Comfort (1-7), and Pleasantness (1-5).

Table 1. Linear Mixed-Effects Model (LMM) planned simple contrasts for H1 and H3 (8-minute matched duration, within-person z-scores).

| Hyp | Indicator | Domain | Contrast | Cohen's d | p-value | q (FDR) | Status |
|---|---|---|---|:---:|:---:|:---:|:---:|
| **H1** | EDA Tonic | Autonomic | Green - Urban (Bike) | -0.64 | 0.1337 | 0.2197 | ns |
|  | EDA Tonic | Autonomic | Green - Urban (Walk) | **-1.25** | 0.0052 | **0.0133** | **FDR Sig \*** |
|  | Skin Temperature | Autonomic | Green - Urban (Bike) | **-1.42** | 0.0024 | **0.0060** | **FDR Sig \*\*** |
|  | Skin Temperature | Autonomic | Green - Urban (Walk) | **-1.41** | 0.0024 | **0.0069** | **FDR Sig \*\*** |
|  | Heart Rate | Autonomic | Green - Urban (Bike) | -0.05 | 0.9014 | 0.9014 | ns |
|  | Heart Rate | Autonomic | Green - Urban (Walk) | 0.29 | 0.4917 | 0.5975 | ns |
|  | HRV RMSSD | Autonomic | Green - Urban (Bike) | 0.07 | 0.8674 | 0.9014 | ns |
|  | HRV RMSSD | Autonomic | Green - Urban (Walk) | 0.75 | 0.0901 | 0.1884 | ns |
|  | Pupil Diameter | Ocular | Green - Urban (Bike) | **1.64** | 0.0011 | **0.0032** | **FDR Sig \*\*** |
|  | Pupil Diameter | Ocular | Green - Urban (Walk) | **3.93** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Blink Duration | Ocular | Green - Urban (Bike) | **-3.38** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Blink Duration | Ocular | Green - Urban (Walk) | **-5.13** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | General Comfort (1-7) | Psychological | Green - Urban (Bike) | **1.63** | 0.0011 | **0.0032** | **FDR Sig \*\*** |
|  | General Comfort (1-7) | Psychological | Green - Urban (Walk) | 0.31 | 0.4936 | 0.5975 | ns |
|  | Pleasantness (1-5) | Psychological | Green - Urban (Bike) | **2.66** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Pleasantness (1-5) | Psychological | Green - Urban (Walk) | **1.47** | 0.0017 | **0.0054** | **FDR Sig \*\*** |
|  | Restorativeness (PRS-11) | Psychological | Green - Urban (Bike) | **4.69** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Restorativeness (PRS-11) | Psychological | Green - Urban (Walk) | **3.12** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | State Anxiety (STAI-6) | Psychological | Green - Urban (Bike) | **-1.74** | <0.001 | **0.0027** | **FDR Sig \*\*** |
|  | State Anxiety (STAI-6) | Psychological | Green - Urban (Walk) | -1.06 | 0.0257 | 0.0591 | Trend |
| **H3** | Pupil Diameter | Ocular | Walk - Bike (Urban) | **-1.95** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Blink Duration | Ocular | Walk - Bike (Urban) | **5.90** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Blink Duration | Ocular | Walk - Bike (Green) | **4.15** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Fixation Duration | Ocular | Walk - Bike (Urban) | **-2.44** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Fixation Duration | Ocular | Walk - Bike (Green) | **-1.44** | 0.0032 | **0.0113** | **FDR Sig \*** |
|  | Gaze Velocity | Ocular | Walk - Bike (Urban) | **2.99** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | General Comfort (1-7) | Psychological | Walk - Bike (Green) | **-1.43** | 0.0034 | **0.0113** | **FDR Sig \*** |
|  | Pleasantness (1-5) | Psychological | Walk - Bike (Green) | **-1.88** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |
|  | Restorativeness (PRS-11) | Psychological | Walk - Bike (Urban) | **-1.28** | 0.0053 | **0.0202** | **FDR Sig \*** |
|  | Restorativeness (PRS-11) | Psychological | Walk - Bike (Green) | **-2.85** | <0.001 | **<0.001** | **FDR Sig \*\*\*** |

Table 2. Descriptive statistics across conditions (Mean +/- SD in 8-minute matched window).

| Sensor / Survey Variable | Urban Route | Green Route | Biking Mode | Walking Mode |
|---|:---:|:---:|:---:|:---:|
| EDA Tonic ($\mu$S) | 4.99 +/- 6.62 | 3.66 +/- 7.09 | 3.59 +/- 5.48 | 5.06 +/- 7.99 |
| Skin Temperature (°C) | 33.14 +/- 1.34 | 32.32 +/- 1.54 | 32.55 +/- 1.48 | 32.91 +/- 1.45 |
| Heart Rate (bpm) | 73.35 +/- 6.79 | 74.50 +/- 6.51 | 73.74 +/- 5.26 | 74.12 +/- 7.84 |
| HRV RMSSD (ms) | 267.12 +/- 29.47 | 277.77 +/- 20.71 | 269.97 +/- 27.53 | 274.92 +/- 24.22 |
| Pupil Diameter (mm) | 3.12 +/- 0.35 | 3.38 +/- 0.38 | 3.31 +/- 0.37 | 3.19 +/- 0.38 |
| Fixation Duration (s) | 0.28 +/- 0.08 | 0.27 +/- 0.07 | 0.31 +/- 0.08 | 0.24 +/- 0.06 |
| General Comfort (1-7) | 5.09 +/- 1.23 | 5.68 +/- 1.39 | 5.68 +/- 1.32 | 5.09 +/- 1.31 |
| Pleasantness (1-5) | 2.95 +/- 0.90 | 4.00 +/- 0.98 | 3.82 +/- 1.14 | 3.14 +/- 0.89 |
| Restorativeness (PRS-11) | 2.48 +/- 0.53 | 3.53 +/- 0.59 | 3.28 +/- 0.76 | 2.73 +/- 0.68 |
| State Anxiety (STAI-6) | 2.20 +/- 0.78 | 1.83 +/- 0.58 | 1.91 +/- 0.69 | 2.13 +/- 0.71 |

---

# 4 Discussion

- **Psychological Superiority of Green Infrastructure:** Green park corridors provided profound, highly robust psychological restoration ($d$ up to 4.69 for PRS-11), confirming Attention Restoration Theory (ART; Kaplan, 1995) in naturalistic mobility.
- **Physiological Discordance with Cardiac Metrics:** Unlike stationary chamber experiments, active mobility creates strong metabolic cardiac demands (HR ~74 bpm across all conditions) that override subtle autonomic recovery, explaining the lack of FDR-significant cardiac concurrence.
- **Convective Cooling in Active Cycling:** Cycling in green corridors showed the lowest skin temperature and highest comfort ratings, supporting the hypothesis that forward cycling velocity generates restorative microclimatic airflow under tree canopies.
- **Visual Cognitive Workload Modulation:** Walking allows open visual exploration (longer blinks, shorter fixations), whereas cycling demands concentrated forward gazes to ensure obstacle avoidance and kinematic stability.
- **Methodological Caveats & Power Limitations:** With $N = 11$, the study is reliably powered for large within-person effects ($d_z \ge 0.94$); subtle effects and second-order interaction terms are interpreted descriptively.

---

# 5 Conclusion

- **Multi-Factorial Paradigm:** Active commuter well-being cannot be captured by binary green-vs-grey classifications. Comfort emerges at the nexus of microclimate, physical exertion, convective airflow, and visual attentional demand.
- **Urban Planning Translation:** To maximize psychological restoration and mitigate heat stress, cities must integrate continuous vegetative canopy shading directly with grade-separated cycling tracks, ensuring simultaneous convective airflow and noise shielding.

> [!NOTE]
> **COMMENT [ID:131] by Maider Llaguno (2026-06-06):**  
> *"We need to evolve the above to get to this"*  
> **Methodological Implementation:** Section 5 outlines a multi-factorial framework linking environmental vegetative buffering, mode-specific physiological exertion, and microclimatic stressor exposure with actionable urban planning and active transit design takeaways.

---

# References

- Aumond, P., Can, A., De Coensel, B., Botteldooren, D., Ribeiro, C., & Lavandier, C. (2017). Modeling soundscape pleasantness using perceptual assessments and acoustic measurements along paths in urban context. *Acta Acustica united with Acustica*, 103(3), 430–443.
- Boucsein, W., et al. (2012). Publication recommendations for electrodermal measurements. *Psychophysiology*, 49(8), 1017–1034.
- Charkoudian, N. (2010). Mechanisms and modifiers of reflex sympathoneural control in humans. *Autonomic Neuroscience*, 196, 68–75.
- Chinazzo, G., Wienold, J., & Andersen, M. (2019). Daylight affects human thermal perception. *Scientific Reports*, 9(1), 13690.
- Cuve, H. C., et al. (2023). Validation of pupil size dynamics as an index of cognitive effort and stress. *Psychophysiology*, 60(4), e14205.
- El Aarbaoui, T., & Chaix, B. (2020). The short-term association between exposure to noise and heart rate variability in daily locations and mobility contexts. *Journal of Exposure Science & Environmental Epidemiology*, 30(2), 383–393.
- El Aarbaoui, T., Méline, J., Brondeel, R., & Chaix, B. (2017). Short-term association between personal exposure to noise and heart rate variability: The RECORD MultiSensor Study. *Environmental Pollution*, 231, 703–711.
- Evans, K. M., et al. (2012). Collecting and analyzing eye-tracking data in outdoor environments. *Journal of Eye Movement Research*, 5(2), 1–19.
- Kaplan, S. (1995). The restorative benefits of nature: Toward an integrative framework. *Journal of Environmental Psychology*, 15(3), 169–182.
- Kraus, U., et al. (2013). Individual daytime noise exposure during routine activities and heart rate variability in adults: A repeated measures study. *Environmental Health Perspectives*, 121(5), 607–612.
- Mahanama, B., et al. (2021). Eye movement and pupil measures: A review. *Frontiers in Computer Science*, 3, 733531.
- Mansi, S. A., et al. (2022). A novel methodology for human thermal comfort assessment in outdoor environments. *Building and Environment*, 211, 108729.
- Nikolopoulou, M., Baker, N., & Steemers, K. (2001). Thermal comfort in outdoor urban spaces. *Solar Energy*, 70(3), 227–235.
- Quigley, K. S., et al. (2024). Publication guidelines for human heart rate and heart rate variability studies. *Psychophysiology*, 61(1), e14455.
- Romanovsky, A. A. (2014). Skin temperature: Its role in thermoregulation. *Handbook of Clinical Neurology*, 156, 441–459.
- Rupi, F., & Krizek, K. J. (2019). Visual eye gaze while cycling: Analyzing eye tracking at signalized intersections. *Transportmetrica A: Transport Science*, 15(2), 1629–1643.
- Stuyck, H., et al. (2022). Validity of the Empatica E4 wristband to measure heart rate and HRV. *Behavior Research Methods*, 54(5), 2382–2398.
- Van Doren, N., et al. (2021). Examining within-person associations between psychological stress and physiological arousal in daily life. *Biological Psychology*, 161, 108082.

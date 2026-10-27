# Paper3 outline — **after** track changes (Copy.docx insertions kept)

## Psychophysiological comfort during active urban mobility: Environment and activity modulated physiological and perceived responses across diverse urban contexts

### Abstract

Urban active travel exposes people simultaneously to thermal, acoustic, visual and physical demands, yet these exposures are rarely studied together under naturalistic conditions. This repeated-measures field study examined psychophysiological comfort across cycling and walking phases in impervious urban and green environments in Brussels. Eleven participants completed route phases while wearable physiological, mobile eye-tracking and environmental data were synchronized to 10-second epochs. Linear mixed models tested environment, mode and within-day thermal-stress-by-noise interactions, with repeated measures accounted for and Benjamini-Hochberg correction applied within hypothesis families. Green phases were associated with lower square-root-transformed tonic electrodermal activity, lower skin temperature and larger pupil diameter. Walking versus cycling was associated with tonic electrodermal activity, skin temperature, fixation rate and gaze velocity. Thermal-stress-by-noise interactions were retained for skin temperature, pupil diameter and saccade peak velocity. Phase-level physiological-perceptual correlations did not survive false-discovery-rate correction. These findings indicate distinct physiological and visual-attention signatures across mobility contexts, while the small sample, model diagnostics and observational field exposures limit causal and population-level claims.

Keywords: active mobility; green infrastructure; thermal comfort; wearable sensing; mobile eye tracking; linear mixed models

## 1 Introduction

### Background and research gap

Active mobility is increasingly promoted as part of low-carbon and healthy urban transport, but route choice also determines exposure to heat, noise, traffic and visual complexity. Outdoor comfort is adaptive and context-dependent rather than a direct function of meteorological conditions alone (Nikolopoulou et al., 2001).

Naturalistic mobility studies must consider environmental exposure and physical travel demands together. Physiological measures can complement self-report, but they are not direct or unique readouts of comfort: electrodermal activity reflects sympathetic arousal, skin temperature is influenced by thermoregulation and movement, and wrist-derived heart-rate variability requires careful measurement and interpretation (Boucsein et al., 2012; Quigley et al., 2024; Stuyck et al., 2022).

Existing field studies commonly examine walking or cycling separately. Mobile eye tracking is feasible outdoors but remains sensitive to illumination, motion, calibration and scene complexity (Evans et al., 2012; Mahanama et al., 2021). Cycling studies further show that gaze allocation changes with task and road context (Rupi & Krizek, 2019).

Wearable physiological sensing can support thermal-comfort research, but much of the evidence comes from controlled or indoor exposures (Mansi et al., 2022). Cross-domain effects are plausible: daylight can alter thermal perception even under controlled thermal conditions (Chinazzo et al., 2019), illustrating why field responses should not be assigned to a single exposure in isolation.

A central evidence gap is the within-person comparison of walking and cycling across contrasting urban and green route phases while environmental, physiological, eye-tracking and perceived responses are measured together.

This study addresses that gap using repeated phase blocks in one field protocol. The design supports within-participant association estimates across the observed routes; it does not establish that greenery, mode or individual stressors independently caused the responses.

The contribution is the integrated comparison of environment and mobility mode, separation of primary and sensitivity analyses, and joint examination of thermal and acoustic exposure in a naturalistic active-mobility setting.

The study asks whether response profiles differ between green and impervious urban phases, between walking and cycling, whether physiological and perceived responses covary, and whether the thermal association changes with concurrent noise.

The results can inform hypotheses and measurement priorities for larger urban-mobility studies and, cautiously, route designs intended to reduce combined environmental burden.

Field campaign in Brussels, 3 July–27 August 2025. Ethics protocol: 30 planned; 18 tested; 11 retained (P4, P8–P17). Eligibility: age 18–40, Brussels resident, able to sit/walk/cycle, and eye-tracking-compatible vision. Signed ethics application: 28 May 2025; official approval reference number is not shown in the available PDF. Demographics, weather range and exact phase order remain to be added from campaign records.

The hypotheses on which the campaign was based were:

H1: Participants will show better physiological and perceived comfort in green than in impervious areas.

H2: Physiological and perceived responses will be concordant (i.e., they correlate in direction).

H3: Psychophysiological comfort will be more compromised during cycling than during walking.

H4: The presence of noise will amplify thermal discomfort.

The following sections describe the repeated-measures field protocol, synchronized sensing workflow, hypothesis-specific analyses and distinction between primary and exploratory evidence.

Figure : Sensors used in experiment

## 2 Methodology

### Data collection process

> [!NOTE]
> **Comment [9] Maider Llaguno (2026-06-06):** 

Within-participant field campaign in Brussels; each participant completed cycling and walking phases in impervious urban and green environments, plus a seated tram phase.

Surveys were administered before/after exposure according to the ethics protocol; sensors were checked during breaks and the researcher carried the environmental backpack. Exact per-phase timing and phase-order/counterbalancing remain to be verified.

### Experiment plan and phases

Primary factorial contrasts: Green minus Urban and Walk minus Bike. Tram was not included in the primary 2 x 2 environment-by-mode contrast.

Phases: Biking in Urban (BikeU), Walking in Urban (WalkU), Biking in Green (BikeG), Walking in Green (WalkG) and Tram.

Figure : Experiment timeline

Figure : Experiment trajectory

### Sensors and questionnaires

urban Climate Monitor (uCM) backpack: air temperature, humidity, radiation, wind, sound level, Global Positioning System (GPS) and comfort indices that include Universal Thermal Climate Index (UTCI)/Physiological Equivalent Temperature (PET).

Empatica Embrace Plus: electrodermal activity (EDA) tonic/phasic, photoplethysmography (PPG) heart rate, heart rate variability (HRV) root mean square of successive differences (rMSSD) and wrist temperature; physiological stream averaged to 10-sec epochs.

Questionnaires: State-Trait Anxiety Inventory (STAI-6), Perceived Restorativeness Scale (PRS-11), Comfort Sensation Vote (CSV), Thermal Sensation Vote (TSV), Environmental Stressor [Temperature, Lighting, Noise, Air Quality, Crowding], Pleasantness.

Continuous recordings: Empatica, Atmotube Pro, LYS. Phase recordings: uCM, Eyetracker. Questionnaires.

### Data analysis and correction

Sensor streams were synchronized, path-matched, quality-checked and aggregated to 10-second epochs. Active analysis: N = 11 (P4, P8–P17), 44 core participant-phase cells. Add the sensor-specific missingness summary before submission.

Because the same participants completed all five phases, the omnibus phase effect was assessed as a repeated-measures within-subject design. A G*Power sensitivity analysis for repeated-measures ANOVA with 5 measurements, n = 11, α = .05, power = .80, correlation among repeated measures = .50, and ε = 1 indicated a minimum detectable effect of f = 0.52, equivalent to partial η² ≈ 0.11.

### Hypothesis testing strategy

> [!NOTE]
> **Comment [23] Maider Llaguno (2026-06-06):** 

> [!NOTE]
> **Comment [24] Maider Llaguno (2026-06-06):** 

H1/H3: participant-phase mean LMMs on matched 8-minute routes, Outcome ~ Mode * Environment + (1|ParticipantID); 10-second epochs were aggregated before testing.

H2: person-mean-centred participant-phase LMMs. H4: single-predictor REML LMMs for PET, UTCI, noise, light and air quality; correlated associations, not a unified causal model.

Primary: common matched 8-minute window. Indoor/Tram subtraction and within-person z-score analyses were sensitivity branches where supported; Benjamini–Hochberg FDR was applied within prespecified families.

## 3 Results

Primary hypothesis findings

Primary analysis: matched 8-minute dataset, N = 11; full-duration and baseline-subtraction branches are sensitivities.

Across models, estimates describe associations conditional on the fitted covariates and reference levels. The number of 10-second rows must not be interpreted as the independent sample size.

H1: current primary output has 35 FDR-significant contrast/normalization results involving selected EDA, skin-temperature, ocular and questionnaire outcomes. Pupil results remain illumination-sensitive.

H2: current output has 152 psychophysiological models; 13 survived FDR (5 unstandardized and 8 within-person z-score results). These are within-person associations, not causal effects.

H3: current primary output has 28 FDR-significant contrast/normalization results involving selected skin-temperature, ocular and questionnaire outcomes. These are mode differences, not a simple comfort ranking.

H4: the primary matched 8-minute within-person z-score branch contains 1,501 single-predictor models; 254 survived FDR across 50 predictor streams. These are correlated associations, not causal or unified-model effects.

Sensitivity: Indoor/Tram subtraction and within-person z-score branches were retained where coverage supported them; 13 Indoor-baseline eye-tracking models were not estimable because of insufficient baseline coverage.

Table 1. Selected H1/H3/H4 results; displayed legacy values require synchronization with current CSV outputs before submission.

| H | Outcome | Contrast/term | Estimate | SE | 95% CI | p_value | p_value_FDR | eta_squared |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| H1 | empatica_skin_temperature | H1_Green_minus_Urban | -1.358 | 0.175 | [-1.702, -1.014] | <0.001 | <0.001 | 0.0827 |
| H1 | empatica_sqrt_eda_tonic | H1_Green_minus_Urban | -0.357 | 0.136 | [-0.624, -0.089] | 0.009 | 0.021 | 0.0153 |
| H1 | eyetracker_pupil_diameter_avg | H1_Green_minus_Urban | 0.498 | 0.076 | [0.348, 0.647] | <0.001 | <0.001 | 0.2385 |
| H3 | empatica_skin_temperature | H3_Walk_minus_Bike | 0.986 | 0.175 | [0.643, 1.329] | <0.001 | <0.001 | 0.0462 |
| H3 | empatica_sqrt_eda_tonic | H3_Walk_minus_Bike | 0.367 | 0.136 | [0.100, 0.634] | 0.007 | 0.012 | 0.0170 |
| H3 | eyetracker_fixation_rate | H3_Walk_minus_Bike | 0.236 | 0.061 | [0.115, 0.356] | <0.001 | <0.001 | 0.0674 |
| H3 | eyetracker_gaze_velocity | H3_Walk_minus_Bike | 354.515 | 90.773 | [176.600, 532.429] | <0.001 | <0.001 | 0.3971 |
| H4 | empatica_skin_temperature | H4_UTCI_within_day_x_SND_within_day | 0.052 | 0.011 | [0.031, 0.074] | <0.001 | <0.001 | <0.001 |
| H4 | eyetracker_pupil_diameter_avg | H4_UTCI_within_day_x_SND_within_day | 0.016 | 0.004 | [0.008, 0.025] | <0.001 | <0.001 | <0.001 |
| H4 | eyetracker_saccade_peak_velocity | H4_UTCI_within_day_x_SND_within_day | -30.199 | 5.973 | [-41.905, -18.493] | <0.001 | <0.001 | <0.001 |

Table 2. Legacy Spearman table; superseded by the current H2 participant-phase LMM output.

| Outcome | Questionnaire | Spearman r | 95% CI | p_value | p_value_FDR | Interpretation |
| --- | --- | --- | --- | --- | --- | --- |
| empatica_skin_temperature | questionnaire_prs11_total_mean_1_5 | -0.359 | [-0.593, -0.070] | 0.017 | 0.146 | raw p < 0.05 only; not FDR-significant |
| eyetracker_pupil_diameter_avg | questionnaire_environmental_comfort_mean_1_5 | 0.479 | [0.197, 0.688] | 0.002 | 0.061 | raw p < 0.05 only; not FDR-significant |
| eyetracker_pupil_diameter_avg | questionnaire_prs11_total_mean_1_5 | 0.418 | [0.123, 0.646] | 0.007 | 0.085 | raw p < 0.05 only; not FDR-significant |
| eyetracker_pupil_diameter_avg | questionnaire_thermal_comfort_1_5 | 0.419 | [0.123, 0.646] | 0.007 | 0.085 | raw p < 0.05 only; not FDR-significant |

Diagnostics: 71 models fitted; 13 Indoor-baseline models not fit for insufficient baseline coverage. A secondary AR(1) analysis quantified temporal dependence; residual cautions remain for selected outcomes.

### Phase-block descriptive profile

The merged 10-second dataset can support participant-weighted phase profiles, within-participant trajectories, distributions and confidence intervals for BikeU, WalkU, BikeG, WalkG and Tram. These summaries should be labelled exploratory and used to explain heterogeneity or generate future hypotheses. New tests selected after viewing these data must not be presented as confirmatory hypotheses.

## 4 Discussion

Environment contrast: green phases showed lower square-root-transformed tonic EDA and lower skin temperature, together with larger pupil diameter. Their co-occurrence is best described as a distinct response profile rather than proof of restoration. Lower tonic EDA is compatible with lower sympathetic arousal, but effort, temperature, sensor contact and motion remain plausible contributors (Boucsein et al., 2012). Pupil diameter cannot be interpreted as improved comfort without accounting for ambient illumination (Mahanama et al., 2021).

Mobility contrast: walking versus cycling was associated with tonic EDA, skin temperature, fixation rate and gaze velocity. Walking and cycling impose different speed, stabilization and hazard-monitoring demands, so the visual-attention findings should not be framed as a simple comfort ranking (Rupi & Krizek, 2019).

Combined thermal and acoustic exposure: within-day UTCI x sound interactions were FDR-significant for skin temperature, pupil diameter and saccade peak velocity in Condition 1. An interaction means that the association with one exposure changed across levels of the other; it does not by itself show that noise amplified discomfort. That wording requires the interaction sign, predicted-value plots over observed ranges and consistency with a comfort outcome.

What about EDA etc? which are the ones to underline? And are they mode specific?

What is the role of movement air flow/wind? I thought it would help biking to feel more comfortable.

What about the interactions?

Limitations: N = 11, one city and season, and route, mode and environment were not fully separable from location, order, illumination, workload and other co-exposures. Primary models used participant-phase means; AR(1) was a secondary temporal diagnostic. Wearable EDA, wrist temperature, HRV and mobile eye tracking remain vulnerable to motion and environmental artefacts; multiple-outcome interpretation remains exploratory. These limitations preclude causal claims.

## 5 Conclusion

Urban active-mobility exposure produced distinct physiological and visual-attention profiles across environment and travel mode. Green phases differed from impervious urban phases in tonic EDA, skin temperature and pupil diameter, while walking differed from cycling in tonic EDA, skin temperature, fixation rate and gaze velocity.

The primary evidence supports context-dependent psychophysiological associations, not a universal ranking of green versus urban or walking versus cycling. Physiological-perceptual concordance was not confirmed after FDR correction, and heat-noise interactions require predicted-value visualization before being described as amplification. Larger counterbalanced studies with explicit temporal correlation structures are needed.

## References

Boucsein, W., et al. (2012). Publication recommendations for electrodermal measurements. Psychophysiology, 49(8), 1017-1034. https://doi.org/10.1111/j.1469-8986.2012.01384.x

Chinazzo, G., Wienold, J., & Andersen, M. (2019). Daylight affects human thermal perception. Scientific Reports, 9, 13690. https://doi.org/10.1038/s41598-019-48963-y

Evans, K. M., Jacobs, R. A., Tarduno, J. A., & Pelz, J. B. (2012). Collecting and analyzing eye-tracking data in outdoor environments. Journal of Eye Movement Research, 5(2), Article 6.

Mahanama, B., et al. (2021). Eye movement and pupil measures: A review. Frontiers in Computer Science, 3, 733531. https://doi.org/10.3389/fcomp.2021.733531

Mansi, S. A., Pigliautile, I., Arnesano, M., & Pisello, A. L. (2022). A novel methodology for human thermal comfort decoding via physiological signals measurement and analysis. Building and Environment, 222, 109385. https://doi.org/10.1016/j.buildenv.2022.109385

Nikolopoulou, M., Baker, N., & Steemers, K. (2001). Thermal comfort in outdoor urban spaces: Understanding the human parameter. Solar Energy, 70(3), 227-235. https://doi.org/10.1016/S0038-092X(00)00093-1

Quigley, K. S., et al. (2024). Publication guidelines for human heart rate and heart rate variability studies in psychophysiology - Part 1. Psychophysiology, 61, e14604. https://doi.org/10.1111/psyp.14604

Rupi, F., & Krizek, K. J. (2019). Visual eye gaze while cycling: Analyzing eye tracking at signalized intersections in urban conditions. Sustainability, 11(21), 6089. https://doi.org/10.3390/su11216089

Stuyck, H., Dalla Costa, L., Cleeremans, A., & Van den Bussche, E. (2022). Validity of the Empatica E4 wristband to estimate resting-state heart rate variability in a lab-based context. International Journal of Psychophysiology, 182, 105-118. https://doi.org/10.1016/j.ijpsycho.2022.10.003


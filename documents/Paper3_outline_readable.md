# Psychophysiological comfort during walking and cycling: Physiological responses and perceived comfort on green and impervious urban routes

*Outline: full reference list and complete Tables 4–9 and Appendix grids are in `Paper3_outline_readable_full.md`.*

## Highlights

- Participants had lower skin temperatures and larger pupils on green routes.
- Comfort ratings were associated with blink duration, pupil diameter and skin temperature.
- Ten European sources provide context for the sound analyses; local applications are source-informed adaptations rather than exact replications.
- Higher thermal exposure was associated with higher wrist skin temperature and electrodermal activity; higher sound levels were associated with lower acoustic comfort, pleasantness and restoration.
- Thermal and acoustic comfort ratings were correlated across participants, but no test established that sound becomes more harmful as thermal conditions worsen.
- Additive mixed models assessed physiological associations with environmental exposures considered together.

## Abstract

Previous research shows that outdoor thermal comfort depends on both microclimate and psychological context. However, how perceived comfort aligns with physiological and visual responses during walking and cycling across contrasting urban environments remains unclear. This study integrates environmental monitoring, wearable physiology, mobile eye tracking and questionnaires to examine these relationships during active urban mobility.

Eleven adults completed eight-minute walking and cycling bouts in green and impervious corridors in Brussels during summer 2025. Synchronized ten-second observations were analysed using phase-average and time-series mixed models and repeated-measures correlations, with analysis-specific Benjamini–Hochberg false-discovery-rate correction for H1–H3 and H5. H4 uses a two-exposure mixed model on bout-mean comfort votes, with nominal p-values and no false-discovery-rate correction.

Compared with impervious routes, green routes were associated with wrist skin temperatures 1.12 °C lower during cycling and 1.16 °C lower during walking, alongside thermal-comfort ratings 0.64 and 1.09 points higher on the green corridor in the cycling and walking contrasts, respectively, on a five-point scale. Pupil diameter was larger in both modes. Walking–cycling contrasts passing correction involved eye measures and, on the green route, pleasantness and restorativeness ratings. Twenty-one of 468 questionnaire–physiology associations survived correction, involving skin temperature, pupil diameter, blinks and fixation duration. For H4, the test is the 22 walking bouts, matching the European outdoor-walk sources. In `Y ~ dBA_z + UTCI_z + (1 | participant)`, sound was associated with thermal comfort (β = −0.564, p = 0.031). UTCI on that same vote, after dBA, was not (p = 0.838). Thermal and acoustic comfort correlated at ρ = 0.713; that coupling is context, not H4. The sound association was nominal and route co-exposure limits its interpretation. Urban walking bouts were warmer than green walking bouts for every participant.

The findings show that route-related differences in perceived comfort coincide with specific physiological and visual responses. They support integrated assessment of thermal conditions, light and acoustic character when evaluating walking and cycling environments.

Keywords: active mobility; green infrastructure; thermal comfort; wearable sensing; mobile eye tracking; linear mixed models

# 1 Introduction

## 1.1 Background and research gap

Walking and cycling are promoted as healthy, low-carbon forms of urban transport. However, people using these modes are exposed involuntarily to heat, noise, traffic and complex visual surroundings. Outdoor comfort depends on both the person and the environment, rather than air temperature alone (Nikolopoulou et al., 2001). Often times an individual transitioning from one mode and environment to another has very little control over the environment, let alone the perception of environment. The mode of commute can change in short durations but it can leave a lasting impact on cumulative environmental and psycho-physiological comfort of individuals.

Previous outdoor comfort studies have examined walking and cycling separately. Park walks have been linked to physiological and psychological responses (Song et al., 2013, 2014), and urban walks to emotions and bodily responses (Rodrigues et al., 2026). Cycling comfort has been linked to micrometeorology and location (Pandya et al., 2026), and cycling gaze to the road task (Rupi & Krizek, 2019). A person’s movement/activity itself changes outdoor thermal comfort (Lin et al., 2022).

There are also gaps in measurement processes used for capturing environment, physiological and psychological data. Much of the evidence for thermal and physiological comfort comes from stationary or indoor exposures (Mansi et al., 2022). Electrodermal activity tracks sympathetic arousal, wrist skin temperature tracks local heat exchange, and wrist heart-rate variability is sensitive to motion and contact (Boucsein et al., 2012; Quigley et al., 2024; Stuyck et al., 2022). Mobile eye tracking is feasible outdoors and is sensitive to illumination, motion, calibration and scene complexity (Evans et al., 2012; Mahanama et al., 2021). Daylight can shift thermal perception when the thermal conditions themselves are held fixed (Chinazzo et al., 2019). In urban nature, vision and sound act together with the thermal setting (Zheng et al., 2024). People walking or cycling are therefore exposed to several environmental conditions at the same time.

Ma et al. (2024) called for cycling eye tracking to be combined with physiological measures. We address that measurement gap by recording gaze, electrodermal activity, wrist skin temperature, heart rate and heart-rate variability while the same participants walk and cycle on a park corridor and a built street corridor. The moving measurements provide time-aligned exposures along each bout, and the post-bout questionnaires cover thermal, acoustic, visual and air-quality comfort. This extends the multi-domain park assessment of Cureau et al. (2022) to an impervious street and includes a direct comparison of travel modes within participants.

This study makes that comparison in Brussels in summer 2025. Each participant walks and cycles matched bouts in an impervious corridor, from Etterbeek toward Montgomery, and in a green corridor, the Bois de la Cambre. Physiological measurements, mobile eye-tracking data, microclimate measurements collected by a following researcher and short questionnaires are synchronised. The comparisons are green versus impervious, walking versus cycling, the relationship between physiological measurements and questionnaire ratings, and the associations of measured thermal exposure and sound level with reported comfort. A complementary analysis assesses thermal conditions, sound, radiation and air pollution together.

![Study area](../Figures/Figure1_study_area.png)

Figure 1. Study area.

## 1.2 Hypotheses

The study addresses four hypotheses (H1–H4). H5 denotes a complementary analysis of environmental exposures considered together.

1. H1: Participants will show better physiological and perceived comfort in green than in impervious areas.
2. H2: Physiological and perceived responses will be concordant (i.e., they correlate in direction).
3. H3: Psychophysiological comfort will be more compromised during cycling than during walking.
4. H4: The presence of noise will increase thermal discomfort.
5. H5: Additive models describe adjusted associations of co-occurring thermal, acoustic, radiative, pollution, and route-context terms with physiological responses.

# 2 Methods

The following sections describe the study design, measurements and statistical analysis.

## 2.1 Study design

A repeated-measures field campaign was conducted in Brussels, Belgium, from 3 July to 27 August 2025 (Figure 2). Each participant completed four core outdoor mobility phases—cycling and walking in an impervious corridor, from Etterbeek toward Montgomery, and in a green corridor, the Bois de la Cambre—plus a seated tram journey between the two locations (Figure 3). Phase labels were BikeU, WalkU, WalkG, BikeG and Tram.

The afternoon window is based on Pandya et al. (2026), in which UTCI and PET peaked between 14:00 and 16:00 in the summers of 2022–2024. Sessions ran from 13:30 to 17:30, the block shown on the same timeline (Figure 2). This schedule followed the ethics protocol and allowed consent and sensor fitting to be completed before the afternoon peak in the comfort indices.

Randomization of route order was planned. Participants completed questionnaires before and after each block. The participant wore the wristband, the eye-tracking glasses, and the light and air-quality loggers, and the trailing researcher carried the microclimate backpack (Figure 4); both were checked at breaks. H1 and H3 are within-person comparisons of environment and of mode under naturalistic active mobility; route location, workload, illumination and co-exposures co-vary with phase, so inferential models estimate associations, not single-stressor causation.

State anxiety is the STAI-6 short form (Marteau & Bekker, 1992). Perceived restorativeness is the PRS-11 (Pasini et al., 2014). Comfort, pleasantness and familiarity are on the same end-of-phase form. The word anchors, the numeric scores and the phase assignment are in §2.2.5.

![Campaign timeline](../Figures/Experiment campaign timeline.svg)

Figure 2. Experiment campaign timeline.

![Route plan](../Figures/Route Plan for Experiment_05Nov.svg)

Figure 3. Route plan for the experiment.

![Sensor setup](../Figures/Experiment Sensor Setup Participant-01.svg)

Figure 4. Sensors worn by the participant.

### 2.1.1 Participants

Eighteen volunteers took part; the ethics protocol had planned for 30. The analysis included eleven participants with usable recordings across the four core phases (P4, P8–P17); outcome-specific missingness reduced the number contributing to some tests. Figure 5 shows data coverage for these eleven participants during the matched 8-minute segments used in the phase-mean models. Inclusion criteria were age 18–60 years, ability to walk and cycle the study routes, and vision compatible with mobile eye tracking. The IPSY ethics committee approved the study on 13 June 2025. For a two-sided paired comparison with 11 complete pairs, 80% power at an unadjusted α = 0.05 requires a standardised paired effect of approximately d_z = 0.94. This sensitivity calculation is not the power of every mixed-model coefficient or an FDR-adjusted test.

The analysed sample comprises eleven participants (three women, eight men) aged 24–58 years (mean 35.2 years, SD 9.5), within the 18–60 year inclusion range. Self-reported height and weight yield BMI 20.5–33.0 kg·m⁻² (mean 23.8 kg·m⁻², SD 3.8): eight meet WHO normal weight (18.5–24.9 kg·m⁻²), two are overweight, and one has obesity. Descriptive case-study groups comprise eight participants with normal-range BMI and three in other BMI categories, and six in the higher daily-walking-duration group and five in the lower group. BMI grouping is not a measurement of physical fitness. Self-reported skin-tone categories were very fair (n = 1), fair (n = 6), medium (n = 2), olive (n = 1) and brown (n = 1). These shade categories were not treated as Fitzpatrick phototypes, which require sun-reactivity information (Fitzpatrick, 1988). Skin pigmentation is relevant to optical wearable measurement performance (Bent et al., 2020). Seven participants normally wear glasses; four report no vision correction. These descriptive BMI and activity groups are not entered in the primary models.

![Matched 8 min coverage](../Figures/Participants matched_8min.png)

Figure 5. Participants on the matched 8-minute segments.

## 2.2 Data compilation

Sensor data are summarised at 10-second intervals. The UCM backpack records microclimate, position and sound data at one-second intervals. Appendix Table 1 lists the measurements and derived variables from each source, with units in brackets.

Units are shown where they are specified in the source data. All sensor records are aligned to a common 10-second timeline. Time between phases is labelled as rest and excluded from the planned comparisons. The phase-mean models compute a mean value for each route phase, which is 48 ten-second epoch. Indoor and rest rows are excluded from the eight minutes durations of each phase.

### 2.2.1 Wrist physiology

The wrist wearable records wrist skin temperature, electrodermal activity, pulse rate, heart-rate variability and acceleration. It also provides an estimated metabolic equivalent. This estimate is a proxy for activity load and varies with travel mode.

### 2.2.2 Microclimate, radiation and sound

The trailing-researcher mobile station measures air temperature, humidity, solar radiation, wind, mean radiant temperature, UTCI, PET, position and A-weighted sound level. It also measures sky view, tree view and building view, and the share of wind, nature, vehicle and man-made sound (Figure 6).

![Type score and proportion in one 10 s epoch](../Figures/score_vs_proportion_10s.png)

Figure 6. Type score and type proportion in one 10 s epoch.

### 2.2.3 Personal air quality and ambient light

Personal loggers on the participant and researcher measure particulate matter, illuminance and colour temperature.

### 2.2.4 Mobile eye tracking

The mobile eye tracker measures pupil diameter, eyelid aperture, blinks, fixations, saccades and gaze.

### 2.2.5 Questionnaire

At the end of each phase, participants complete a questionnaire on comfort, pleasantness, familiarity, state anxiety and how restorative they find the environment. A higher comfort, pleasantness or restorativeness score means more of that quality. Calm, relaxed and content are reversed, so a higher score means more state anxiety.

### 2.2.6 Visible greenery along the route

Street-level imagery is used to estimate visible greenery along each route.

## 2.3 Testing of Hypothesis

Phase-mean contrasts use REML linear mixed models (Pinheiro & Bates, 2000) on the participant × phase means, so that the comparison is within person and the 10-second counts are not treated as independent observations (Cnaan et al., 1997; Enders & Tofighi, 2007). Planned contrasts are estimated marginal means (Lenth, 2023). Relationships between questionnaire ratings and physiological measurements are assessed using repeated-measures correlation (Bakdash & Marusich, 2017). Benjamini–Hochberg correction (α = 0.05; Benjamini & Hochberg, 1995) is applied within the specified H1–H3 and H5 families; H4 nominal analyses are distinguished below. The repeated-measures field design follows ambulatory precedent (Rodrigues et al., 2026; Korkmaz et al., 2025).

Table 2. Analysis questions and temporal resolutions.

| Hypothesis | Phaseavg | Time series |
| ---------- | --- | --- |
| H1 | Within one person, does the 8-minute green bout differ from the 8-minute impervious bout on the 26 physiological outcomes? Cycling is BikeG − BikeU. Walking is WalkG − WalkU. | Within one person, does a 10-second epoch in the green corridor differ from a 10-second epoch in the impervious corridor on the 26 physiological outcomes? Cycling is BikeG − BikeU. Walking is WalkG − WalkU. Epochs within a bout are autocorrelated. |
| H2 | Within one person, does a higher end-of-phase questionnaire score go together with a higher or lower phase-mean physiological value? The statistic is the repeated-measures correlation across the four phases. | The questionnaire is completed at the end of the phase, so it is not computed on 10-second epochs. |
| H3 | Within one person, does the 8-minute walking bout differ from the 8-minute cycling bout on the 26 physiological outcomes? Impervious is WalkU − BikeU. Green is WalkG − BikeG. | Within one person, does a 10-second walking epoch differ from a 10-second cycling epoch on the 26 physiological outcomes? Impervious is WalkU − BikeU. Green is WalkG − BikeG. Epochs within a bout are autocorrelated. |
| H4 | The presence of noise will increase thermal discomfort. The test is `Y ~ dBA_z + UTCI_z + (1 \| participant)` on bout-mean thermal, acoustic and overall comfort for the 22 walking bouts. The H4 coefficient is the dBA slope on thermal comfort conditional on UTCI. | No epoch-level H4 comfort model: one questionnaire response is available per bout. |

### Hypothesis 1

H1, green versus urban.

Y_ij = β_0 + Phase_ij + u_i + ε_ij, (1)
where i is the participant, j is the phase, u_i is the participant intercept, and Phase is the bout. The two contrasts are cycling (BikeG − BikeU) and walking (WalkG − WalkU). Each contrast is its own Benjamini–Hochberg family of 26 physiological outcomes. Questionnaire items use their own families. A sensitivity analysis repeats the contrasts on outcomes standardised within person.

### Hypothesis 2

H2, physiological and perceived concordance, is the repeated-measures correlation (Bakdash & Marusich, 2017), fitted on the phase means as

vote_ij = α_i + β physiology_ij + ε_ij. (2)
Each person has a separate intercept and the slope is shared. That slope is the change in rating points for a 1-unit increase in the physiological measure. From its t statistic,

r = sign(t) × √(t² / (t² + ν)), (3)
where ν is the residual degrees of freedom. The interval for r is the Fisher-z interval of Bakdash & Marusich (2017). A pair is estimated when it has at least 20 complete means from at least 8 participants. The grid is 18 questionnaire scores by 26 physiological outcomes, and those pairs form one family. The rating is collected at the end of the phase, so this correlation is not computed on 10-second epochs.

### Hypothesis 3

H3, cycling versus walking, uses equation (1). The two contrasts are impervious (WalkU − BikeU) and green (WalkG − BikeG), and each is its own family of 26 outcomes. Questionnaire items use their own families, as in H1.

On the 10-second epochs, H1 and H3 use the same contrasts on the within-person standardised outcome,

Y_ijt = β_0 + Phase_ijt + u_i + ε_ijt, (4)
where t is the epoch and the errors within a bout follow a first-order autoregressive correlation.

### Hypothesis 4

Outdoor European studies that measured heat and sound do not estimate a sound × heat product on discomfort. They use additive or separate heat and noise models on walking (Cureau et al., 2022; Rodrigues et al., 2026; Grapas et al., 2026; Peng et al., 2025; Baquero Larriva & Higueras García, 2019). H4 follows that European walk design.

H4: The presence of noise will increase thermal discomfort. The test is

Y_ij ∼ dBA_z + UTCI_z + (1|participant), (5)

on bout-mean thermal, acoustic and overall comfort. dBA is the energy-mean A-weighted level of each bout and UTCI its mean; both are z-scored across the 22 walking bouts. Cycling is not an H4 extension. Tram is not in H4. The predicted dBA slope for thermal comfort is negative. The UTCI coefficient describes the conditional thermal association. No false-discovery-rate correction is applied to H4.

None of the European sources is equation (5) on a comfort vote. Peng et al. (2025) fit five separate one-predictor models (`TSV ~ LAeq`; `TSV ~ ASV`; `ASV ~ UTCI`; `ASV ~ LAeq`; `ASV ~ TSV`), not `TSV ~ LAeq + UTCI`. Cureau et al. (2022) predict overall comfort from thermal, visual and acoustic ratings, not from UTCI and dBA. The Cureau rating-on-rating analogue is reported as context; it is not H4.

Table. Unique Brussels equations for the European methods. Citations [1]–[5] are Grapas 2026; Cureau 2022; Rodrigues 2026; Peng 2025; Baquero 2019. Two citations in one cell are the same equation, not two tests. Full *p* tables are in `H4_report.md`.

| Eq | Equation | Citations | H4? |
| --- | --- | --- | --- |
| A | `Y = b0 + b1 dBA_z + b2 UTCI_z + (1\|participant)` | this study | **Yes**, if Y is a comfort vote |
| B | `Y = b0 + b1 X + (1\|participant)` (five separate X) | [4] | No |
| C | `Y = b0 + b1 Noise_max_z + b2 Noise_sd_z + (1\|participant)` | [3] | No |
| D | `Y = b0 + b1 Temp_max_z + b2 Temp_mean_z + (1\|participant)` | [3] | No |
| E | `delay = b0 + b1 dBA_z + (1\|participant)` | [1] | No |
| F | `delay = b0 + b1 UTCI_z + (1\|participant)` | [1] | No |
| H | Wilcoxon signed-rank on `d = Y_urban − Y_green` | [2] | No (H1) |
| J | Pearson r(overall, environment) | [5] | No |
| K | `overall = b0 + b1 Ta_z + b2 RH_z + b3 dBA_z + b4 wind_z + (1\|participant)` | [5] | No |
| M | Fisher exact, vote × vote, per phase | [2] | No |
| N | multinomial overall from thermal+visual+acoustic ratings | [2] | No |
| O | `overall = b0 + b1 thermal + b2 acoustic + (1\|participant)` | [2] | No |

Pigliautile (2021), Cureau (2023), Kraus (2013), Ueberham (2019), Korpilo (2024), Moshammer (2019), Grapas Rome (2026) and Chiucchiù (2026, NEXT.ROOM indoor chamber) are excluded. Newcastle 2020 and Zouad & Baron 2026 were read and not ported.

Urban was warmer than green for all 11 walking participants and 10 of 11 cycling participants (P10's BikeU was 0.38 °C cooler than BikeG; by UTCI, 9 of 11), and louder for all 11 in both modes. Heat and sound therefore rise with the same route. All 11 participants completed all four phases, so each person contributes two bouts per mode.

### H5 — Combined-exposure analysis

The combined-exposure analysis fits seven additive mixed models, at 10 seconds and at phase means (Hamra & Buckley, 2018). It is a complementary analysis of adjusted exposure associations, separate from H1–H4. Each equation has the form

Y = β_0 + Thermal + co-exposures + route contrasts + u_i + ε, (6)
where u_i is the participant intercept. The thermal predictor varies across the seven equations (UTCI, air temperature with humidity and wind, mean radiant temperature, HUMIDEX, PET, then UTCI again with PM1 or PM10 in place of PM2.5). The co-exposures are A-weighted sound, sky view, PM2.5, illuminance and colour temperature. The 10-second equations also include solar irradiance and green view, except the mean-radiant-temperature equation, which omits direct solar irradiance and sky view because mean radiant temperature is already the radiation term. Green view is retained in that equation. The phase-mean form of the air-temperature equation omits sound. A term is screened by

VIF = 1 / (1 − R²), (7)
with the Fox–Monette factor for the route block (Marquardt, 1970; Fox & Monette, 1992; James et al., 2013). The factor is reported with the fitted specification. Specifications with a maximum variance inflation factor above 10 are flagged for substantial collinearity; their individual exposure coefficients are interpreted cautiously. For each exposure specification and predictor, BH correction is applied across the 26 physiological outcomes; phase contrasts use separate families. Exposure predictors are participant-centred at phase means or bout-centred at ten seconds and divided by their pooled centred standard deviation. Exposure coefficients are therefore per one standard-deviation increase, on the modelled outcome scale.

Descriptive pooled associations use Pearson’s coefficient,

r = covariance(x, y) / (s_x s_y). (8)
Pooling combines within- and between-participant variation. These descriptive coefficients are distinct from the participant-adjusted H2 correlations. The multimodal evidence map displays the four planned H1/H3 contrasts and the 468 H2 pairs as separate panels, using their saved estimates and BH families; it does not estimate a mediation pathway or a new pooled significance network.

- Specification 1 uses UTCI, sound, sky view, PM2.5, illuminance, colour temperature and the route contrasts. The 10-second form also includes solar irradiance and green view. The phase-mean form leaves those two out.
- Specification 2 replaces the UTCI in specification 1 with air temperature, humidity and wind.
- Specification 3 replaces the UTCI in specification 1 with mean radiant temperature, and leaves out the solar irradiance and sky view.
- Specification 4 replaces the UTCI in specification 1 with HUMIDEX.
- Specification 5 replaces the UTCI in specification 1 with PET.
- Specification 6 replaces the PM2.5 in specification 1 with PM1.
- Specification 7 replaces the PM2.5 in specification 1 with PM10.

Table 3. Maximum variance inflation factors by exposure specification and time resolution.

| Specification | Thermal predictor; particulate variant | Time series | Phase average |
| --- | --- | --- | --- |
| 1 | UTCI; PM2.5 | 2.52 | 7.95 |
| 2 | Air temperature, humidity and wind; PM2.5 | 1.88 | 9.29 |
| 3 | Mean radiant temperature; PM2.5 | 1.14 | 80.24 |
| 4 | HUMIDEX; PM2.5 | 1.41 | 5.52 |
| 5 | PET; PM2.5 | 2.36 | 6.58 |
| 6 | UTCI; PM1 | 2.52 | 7.73 |
| 7 | UTCI; PM10 | 2.52 | 8.28 |

Other predictors follow the time-resolution-specific definitions above; in particular, phase-average specification 2 omits sound, whereas its ten-second counterpart includes it.

# 3 Results

## 3.1 Microclimate of the green and impervious routes

Figure 7 compares the 10-second rows across the four core phases for UTCI, air temperature, mean radiant temperature, sound, PM2.5, illuminance, sky view and green view. The green routes were generally cooler, quieter and less exposed to sunlight than the impervious routes. For these exposures, the median of the eleven participants’ phase medians was lower on the green routes. UTCI was 25.1 °C during green cycling and 23.8 °C during green walking, against 27.0 °C and 32.0 °C. Sound was 59.5 and 61.5 dB(A), against 71.8 and 67.8 dB(A). Solar irradiance was 123 and 57 W m⁻², against 162 and 686 W m⁻². Figure 8 gives the same sound exposure as a count of 10-second rows in level bands, providing a separate summary of sound exposure.

![Exposures by phase](../Figures/Figure5_exposures_by_phase.svg)

Figure 7. Microclimate and co-exposures by phase.

![Sound level bands by participant and phase](../Figures/Figure12_sound_level_bands.svg)

Figure 8. A-weighted sound level by participant and phase.

## 3.2 H1 — Green versus impervious comfort

Phase-mean models (§2.3). Figure 9 shows each green-minus-impervious comparison twice, the phase-mean estimate on the left and the 10-second estimate on the right, on one axis from −5 to 5 standard deviations. A filled point, with its q printed, is a contrast that passed correction. Green phases were associated with lower skin temperature and with larger pupil diameter (pupil is illumination-sensitive), and the other filled points are the eye-movement contrasts in Table 4. Eighteen comparisons of end-of-phase ratings remained significant after correction for multiple testing, using test families separate from those in §3.3. Thermal comfort was 0.64 points higher during green cycling and 1.09 points higher during green walking. The other significant rating differences indicated greater comfort or restorativeness on the green route, and reversed calm was 0.91 points lower on both modes.

![H1 phase-mean and 10 s contrasts](../Figures/Figure6_H1_forest.svg)

Figure 9. H1 green versus impervious contrasts.

Table 4. Physiological contrasts with q < 0.05. These rows are the filled points in Figure 9. The estimate column is the phase-mean model estimate in the outcome’s own units. The 10-second model is fitted on standardised outcomes, so those rows are in SD units.

## 3.3 H2 — Relationships between physiological responses and perceived comfort

The repeated-measures correlation uses the four phase means of each person (Figure 10). Each cell is the correlation of one end-of-phase rating with one phase-mean physiological measure. A positive r means that, within a person, a higher rating is associated with a higher physiological value, and a black box is q < 0.05. Significant correlations involved skin temperature, pupil diameter, blink duration and fixation duration. No correlations involving heart rate or tonic electrodermal activity remained significant after correction. H2 uses phase averages because questionnaire ratings are collected once per phase. Calm, relaxed and content are the only reversed questionnaire scores in this figure. Tense, upset and worried already point toward more anxiety, so they are not reversed. The PRS subscales, pleasantness and the comfort items are not reversed: a higher score means more fascination, being away, coherence, scope, pleasantness or comfort.

![H2 correlations](../Figures/Figure8_H2_rmcorr.svg)

Figure 10. Repeated-measures correlation between the end-of-phase rating and the phase-mean physiology.

Table 5. The 21 pairs with q < 0.05. These are the black boxes in Figure 10. r and q are the fitted repeated-measures correlation and its Benjamini–Hochberg value (Bakdash & Marusich, 2017). The rating-change column for skin temperature and pupil diameter is the exported slope per 1 °C and per 1 mm. For blink duration the exported slope is per 1 s; the cell is that slope multiplied by 0.01, which is the rating change for a 0.01 s increase. For fixation duration the cell is the exported per-1 s slope multiplied by 0.1. r and q are not affected by that multiplication. H2 was not assessed at 10-second intervals.

## 3.4 H3 — Cycling versus walking

Phase-mean contrasts (§2.3). Figure 11 uses the same two-panel layout as Figure 9, and a filled point is q < 0.05. Walking versus cycling showed 8 FDR-significant primary physiological contrasts, all in eye movements: blinks, fixations, gaze and pupil. Tonic electrodermal activity, fixation rate and skin temperature did not survive correction, and are therefore shown as open points. Three questionnaire comparisons remained significant, all on the green corridor and separate from §3.3: pleasantness was 1.09 points lower, fascination 0.79 points lower and being away 0.97 points lower while walking than while cycling.

![H3 phase-mean and 10 s contrasts](../Figures/Figure7_H3_forest.svg)

Figure 11. H3 walking versus cycling contrasts.

Table 6. Physiological contrasts with q < 0.05. These rows are the filled points in Figure 11. The estimate column is the phase-mean model estimate in the outcome’s own units. The 10-second rows are in SD units.

## 3.5 H4 — The presence of noise will increase thermal discomfort

Analyses used bout means from 11 participants (22 walking bouts). Equation (5) is the H4 test.

![H4 coefficients](../Figures/H4_coefficients.svg)

H4 coefficients. `Y ~ dBA_z + UTCI_z + (1 | participant)` on bout-mean walking comfort. Filled points are nominal *p* < 0.05; bars are 95% intervals. The dBA slope on thermal comfort addresses H4.

Table 7. Additive two-exposure mixed model `Y ~ dBA_z + UTCI_z + (1 | participant)` on bout-mean comfort. The dBA slope on thermal comfort is the H4 estimate. The points are those in `H4_coefficients`.

**Context, not H4.** Spearman thermal_comfort ~ acoustic_comfort on 11 person-means: ρ = 0.713 (*p* = 0.014). The Cureau analogue `overall_comfort ~ thermal_comfort + acoustic_comfort + (1 | participant)` was not significant (acoustic vote *p* = 0.088; thermal vote *p* = 0.491). Coupled ratings do not substitute for both measured exposures on the same vote.

**H4 outcome.** The walking model provides nominal evidence of a negative sound–thermal comfort association after adjustment for UTCI. The UTCI estimate was uncertain, and the route contrast limits attribution.

## 3.6 H5 — Combined exposure

Additive models at 10 s and at phase means (§2.3). Of 2,184 ten-second coefficients, 152 have q < 0.05; of 1,846 phase-mean coefficients, 30 do. The mean-radiant-temperature specification, combined-exposure model 3, has a maximum variance inflation factor of 1.14 at 10 s and 80.24 at phase means.

Of the 30 phase-mean and 152 ten-second coefficients with q < 0.05, 16 and 126, respectively, compare an individual phase with the average of all four phases. The following tables summarise the other 14 and 26 exposure associations; phase-indicator coefficients are omitted from this summary. Each slope estimates an association while adjusting for the other variables in the model. None of these exposure associations remains significant after false-discovery-rate correction at both time scales. Four of the 14 phase-mean rows are model 3. That phase-mean fit has a maximum variance inflation factor of 80.24. Severe collinearity in the phase-mean mean-radiant-temperature model limits attribution of its associations to individual predictors. The ten phase-mean slopes that remain are higher heart-rate variability with higher UTCI or air temperature, and higher gaze velocity with air temperature. The 26 ten-second slopes are ocular, mostly pupil diameter and pupil change rate with sky view factor or solar radiation.

Table 8. Phase-average exposure coefficients with q < 0.05. Estimates are per one-SD increase in the participant-centred exposure, on the modelled outcome scale; natural-log outcomes are not in native HRV units.

Table 9. Twenty-six ten-second exposure slopes with q < 0.05, per one-SD increase in the bout-centred exposure on the modelled outcome scale.

# 4 Discussion

## 4.1 H1 — Green versus impervious comfort

Wrist skin temperature was 1.12 °C lower during green cycling than during impervious urban cycling, and 1.16 °C lower during green walking than during impervious urban walking. Thermal comfort was 0.64 points higher during green cycling and 1.09 points higher during green walking. The cycling difference in wrist temperature was also present in the ten-second model. The walking difference was not. No differences in heart rate, heart-rate variability or tonic electrodermal activity remained significant after correction. Lower wrist skin temperature is consistent with vegetation reducing radiant and convective heat exposure (Nikolopoulou et al., 2001; Fahy et al., 2025).

Pupil diameter was 0.393 mm larger during green cycling and 0.949 mm larger during green walking. Pupil size varies with illuminance and with arousal (Mahanama et al., 2022), and the urban and green corridors differ in both the light and the scene. The green-versus-impervious difference is more than twice as large while walking (0.949 mm) as while cycling (0.393 mm). On the impervious corridor, the pupil was 0.465 mm smaller while walking than while cycling (§4.3).

Blinks were 0.0092 s shorter during green cycling and 0.0133 s shorter during green walking. During green cycling, gaze was 38.1 px closer to the centre of the scene and the eyelid aperture was 0.877 mm larger. During green walking, fixations were 0.0266 s longer, gaze dispersion was 0.0111 lower on its recorded scale, and gaze velocity was 378 px s⁻¹ lower. Shorter blinks on both modes, and longer fixations with a slower gaze on foot, suggest that participants looked at the green corridor differently.

## 4.2 H2 — Relationships between physiological responses and perceived comfort

Higher wrist skin temperature was associated with lower end-of-phase ratings. Per 1 °C, acoustic comfort was 0.54 points lower, air-quality comfort 0.51 points lower, visual comfort 0.38 points lower, being away 0.58 points lower and fascination 0.46 points lower. The five slopes lie between about 0.4 and 0.6 points per degree. For context, applying these slopes to the approximately 1.1 °C route difference in §4.1 corresponds to roughly half a rating point; this is an association, not an estimated causal effect. Heart rate, heart-rate variability and tonic electrodermal activity were not significantly associated with the same ratings. In this study, end-of-phase ratings were more closely associated with wrist skin temperature than with cardiac or electrodermal measurements. The questionnaire is one score for the whole phase, so it summarises the bout rather than the fluctuations inside it.

A 1 mm larger pupil was associated with higher ratings: air-quality comfort by 1.15 points, thermal comfort by 0.74 points, being away by 1.39 points, fascination by 1.31 points and scope by 1.33 points. The reversed calm score was 0.88 points lower. That item is scored so that a higher value means more state anxiety, and the larger pupil was associated with a lower value. Pupil diameter also tracks light (Mahanama et al., 2022), and green and impervious corridors differ in illuminance.

A 0.01 s longer blink was associated with lower ratings: acoustic comfort by 0.67 points, air-quality comfort by 0.54 points, pleasantness by 0.68 points, thermal comfort by 0.41 points, visual comfort by 0.44 points, being away by 0.85 points, fascination by 0.59 points and scope by 0.63 points. Reversed calm was 0.42 points higher. A 0.1 s longer fixation was associated with visual comfort 1.96 points higher. Longer blinks and higher wrist skin temperature were associated with lower comfort ratings. Larger pupils and longer fixations were associated with higher visual comfort. These findings suggest distinct relationships between perceived comfort, eye movements and pupil size. There is no ten-second version of this test, because the rating is taken once, at the end of the phase.

## 4.3 H3 — Cycling versus walking

Walking and cycling differed in eye movements, and the size of the difference depended on the corridor. During green walking, compared with green cycling, blinks were 0.0110 s longer and gaze was 52.8 px farther from the centre of the scene. Gaze centrality was 0.0928 lower. Fixation duration on the green corridor differed only in the ten-second model, where it was 0.43 standard deviations shorter while walking. During impervious walking, compared with impervious cycling, blinks were 0.0151 s longer, fixations were 0.0343 s shorter, gaze dispersion was 0.0189 higher, gaze velocity was 609 px s⁻¹ higher, and the pupil was 0.465 mm smaller. Eyelid aperture on the impervious corridor differed only in the ten-second model, where it was 0.92 standard deviations larger while walking.

Estimated wrist temperature was 0.91 °C higher during impervious walking than impervious cycling, and 0.88 °C higher during green walking than green cycling. Neither contrast passed correction. On the green corridor, pleasantness was 1.09 points lower, fascination 0.79 points lower and being away 0.97 points lower while walking. No differences in heart rate, heart-rate variability or tonic electrodermal activity between the two modes remained significant after correction. The two modes differ in speed and in how much of the carriageway has to be watched (Rupi & Krizek, 2019).

## 4.4 H4 — The presence of noise will increase thermal discomfort

In the 22 walking bouts, higher A-weighted sound level was associated with lower thermal comfort after adjustment for UTCI (β = −0.564 per standard deviation of sound level, nominal *p* = 0.031). The UTCI slope was uncertain (*p* = 0.838). The result provides nominal evidence for the updated sound hypothesis. The original sound-by-heat interaction and the independent contributions of both exposures to the same vote remain unresolved. Thermal and acoustic ratings covaried (ρ = 0.713), which describes how the ratings moved together.

Cureau et al. (2022) modelled overall comfort from domain ratings. Peng et al. (2025) examined thermal and acoustic perception in separate models. The Brussels walking model extends these questions by including measured UTCI and dBA together. The urban corridor was both louder and warmer, which limits attribution to either exposure independently of route. The median of participant medians was 23.8 °C UTCI and 61.5 dB(A) during green walking, compared with 32.0 °C and 67.8 dB(A) during urban walking.

Cureau et al. (2022) called for acoustic assessment beyond sound pressure level. Figure 12 adds source and spectral information to the route contrasts. Green bouts were quieter and had a higher classifier-estimated rural/natural sound share in both modes. Compared with urban cycling, green cycling had lower wind, negative man-made and vehicle shares. Green walking had a higher spectral centroid and a lower low-frequency share than urban walking. The walking vehicle-share contrast did not pass correction. These comparisons characterize recorded sound composition alongside dB(A). They provide context for the walking comfort model.

![Sound composition](../Figures/Figure9_sound_composition.svg)

Figure 12. Sound composition along the routes.

## 4.5 H5 — Combined exposure

The seven additive models address the co-exposure question described by Hamra and Buckley (2018). They estimate how each exposure relates to an outcome conditional on the measured covariates in that model. In the phase-mean models, higher UTCI or air temperature was associated with higher heart-rate variability, and gaze velocity was 320.6 px s⁻¹ higher per one-SD increase in participant-centred air temperature. In the ten-second models, the slopes that remained were mostly a smaller pupil, and a slower change in pupil diameter, when sky view or solar radiation was higher. Direct solar irradiance and sky view were left out of the mean-radiant-temperature specification because that temperature already represents radiation. The phase-mean fit of that specification has a maximum variance inflation factor of 80.24, on green view. Severe collinearity limits attribution of its associations to individual predictors. The ten-second fit of the same specification has a maximum of 1.14.

## 4.6 Multimodal evidence map

The evidence map brings together the four planned environment and mode contrasts and the H2 within-person concordance results. The 21 corrected questionnaire–physiology associations illustrate how synchronized sensing can relate end-of-bout experience to physiological and eye measures. It shows all tested physiological outcomes, including nonsignificant results, with separate scales for paired standardised differences and repeated-measures correlations. Selected native-unit estimates and 95% intervals illustrate uncertainty. The environmental, physiological and psychological domains organise separate analyses; no mediation model is fitted.

![Multimodal evidence map](../Figures/Figure11_multimodal_evidence_map.svg)

Figure 13. Multimodal evidence map of primary phase-average H1/H3 contrasts and H2 within-person concordance. Outlined coloured dots indicate BH q < 0.05; grey dots indicate tested nonsignificant results. Effect scales and correction families are separate. The domains organise measured variables without establishing temporal ordering or mediation.

## 4.7 Limitations

The analysis covers 11 adults in Brussels from 3 July to 27 August 2025. The sample and summer schedule limit inference across demographic groups, seasons and times of day. Participants completed two bouts per travel mode and provided one rating per bout. This design leaves short-lived changes in perception unresolved. The assigned corridors standardize the route comparison, while heat, noise, vegetation, light and traffic still vary together. The contrasts therefore describe these corridors and cannot isolate the causal contribution of green infrastructure. A trailing researcher carried the microclimate backpack. Their presence may have influenced behaviour, and conditions at the backpack can differ from conditions at the participant.

Wrist measurements are sensitive to movement and contact, and the device-derived activity estimate varies with travel mode. Illuminance and colour temperature describe the lighting environment but do not quantify glare, a gap identified by Cureau et al. (2022). The eye-tracking analysis summarizes pupil size and eye movements without coding which scene elements participants looked at. Scene-linked areas of interest would distinguish attention to vegetation from attention to built elements, as in Fleming et al. (2024). Acoustic spectra and classifier-estimated source shares describe the recordings. A future campaign could add psychoacoustic loudness and sharpness, a wind-protected reference measurement, and a measure of participant noise sensitivity.

Future work should repeat the walking and cycling bouts across a wider range of participants and seasons. Routes with different combinations of heat and sound would help distinguish their associations. More frequent brief ratings and scene-coded gaze would also help link changing conditions to reported experience.

# 5 Conclusion

The same participants walked and cycled both corridors while microclimate, acoustics, physiology and eye movements were recorded and comfort was rated after each bout. On the green corridor, participants had lower wrist skin temperatures, larger pupils and higher thermal comfort ratings. Travel-mode contrasts passing correction involved eye measures and, on the green corridor, pleasantness, fascination and being away. Wrist skin temperature was higher while walking on both corridors, with neither contrast passing correction. Twenty-one within-person questionnaire–physiology associations passed correction. Walking sound level had a nominal negative association with thermal comfort after adjustment for UTCI. Route co-exposure limits interpretation of that association. The source and spectral contrasts show what broadband level alone leaves unspecified about the recorded soundscape.

# Declarations

## Ethics approval and consent

The IPSY ethics committee approved the study on 13 June 2025 (reference Project2025-49). Each volunteer gave written informed consent. Eighteen volunteers were tested.

## Funding

This work was supported by the Fonds de la Recherche Scientifique (FNRS) [grant numbers - 1.A.891.23, T.0137.23] and SNSF Weave/Lead Agency funding scheme [grant number - 213995].

## Competing interests

The author declares no competing interests.

## CRediT authorship contribution statement

Pranav S. Pandya: Conceptualization, Methodology, Software, Formal analysis, Investigation, Data curation, Visualization, Writing – original draft. Yen-Shuo Huang: Writing – review & editing, Data curation. Maider Llaguno-Munitxa: Writing – review & editing, Supervision, Methodology, Funding acquisition, Conceptualization. Gabriele Manoli: Writing – review & editing, Funding acquisition. Peter Gallinelli - Technological support.

## Data availability

The wearable, eye-tracking and questionnaire records are not publicly archived because they can identify participants. De-identified data that the ethics approval allows to be shared are available from the corresponding author on reasonable request. The analysis scripts that produced the reported models are in the project repository.

*(References: see Paper3_outline_readable_full.md, §6.)*

# Appendix

The scores entered in the models use the administered wording and anchors in §2.2.5. Tables 10 and 11 are the approved protocol forms (Annex 3). Table 1 lists the sensor parameters compiled for the analysis.

Table 10. Participant background questionnaire from the approved ethics form (Annex 3, Table 1: identity, demographics, residence, physical characteristics, familiarity, living environment, household, mobility and physical activity).

Table 11. Experimental campaign questionnaire (`Recurring questionnaire.csv`): **7-point overall comfort** (“How comfortable do you feel right now?”) and a **5-point comfort grid** for Thermal, Acoustic, Visual, Air, and Odors (Comfortable → Extremely uncomfortable). Scoring: `05_questionnaire_build.py`; literature-test mapping: `H4_papers_screened_final.md` §2 (local thermal-comfort adaptations use this row; thermal sensation is not interchangeable with thermal comfort).

Table 1. Parameters compiled from each sensor.

*(Full table rows: Paper3_outline_readable_full.md, Appendix.)*

## Additional references

- Ma, S., Zhang, W., Noland, R. B., & Andrews, C. J. (2024). Eye tracking measures of bicyclists’ behavior and perception: A systematic review. *Transportation Research Part F: Traffic Psychology and Behaviour*, 107, 52–68. https://doi.org/10.1016/j.trf.2024.08.026
- Fleming, W., Rizowy, B., & Shwartz, A. (2024). The nature gaze: Eye-tracking experiment reveals well-being benefits derived from directing visual attention towards elements of nature. *People and Nature*. https://doi.org/10.1002/pan3.10648


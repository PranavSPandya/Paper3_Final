# Psychophysiological comfort during active urban mobility: Environment and activity modulated physiological and perceived responses across diverse urban contexts

Pranav S. Pandya (corresponding author)

[Institution, city, country]

Email: [corresponding author email]

## Highlights

- Green phases showed cooler wrist skin and larger pupils.
- Walking differed from cycling in eye movements and, on the green route, in three votes.
- Comfort votes tracked blinks, pupils and skin temperature.
- Noise did not amplify thermal discomfort after correction.
- Exposures were estimated together in additive mixed models.

## Abstract

Previous research shows that outdoor thermal comfort depends on both microclimate and psychological context. However, how perceived comfort aligns with physiological and visual responses during walking and cycling across contrasting urban environments remains unclear. This study integrates environmental monitoring, wearable physiology, mobile eye tracking and questionnaires to examine these relationships during active urban mobility.

Eleven adults completed eight-minute walking and cycling bouts in green and impervious corridors in Brussels during summer 2025. Synchronized ten-second observations were analysed using phase-average and time-series mixed models, repeated-measures correlations and literature-adapted sound models, with Benjamini–Hochberg false-discovery-rate correction.

Compared with impervious routes, green routes were associated with wrist skin temperatures 1.12 °C lower during cycling and 1.16 °C lower during walking, alongside thermal-comfort ratings 0.64 and 1.09 points higher, respectively, on a five-point scale. Pupil diameter was larger in both modes. Walking–cycling contrasts passing correction involved eye measures and, on the green route, pleasantness and restorativeness ratings. Twenty-one of 468 questionnaire–physiology associations survived correction, involving skin temperature, pupil diameter, blinks and fixation duration. No heat-by-sound interaction survived correction, although supplementary sound-source and frequency analyses identified associations with cardiac measures.

The findings show that route-related differences in perceived comfort coincide with specific physiological and visual responses. They support integrated assessment of thermal conditions, light and acoustic character when evaluating walking and cycling environments.

Keywords: active mobility; green infrastructure; thermal comfort; wearable sensing; mobile eye tracking; linear mixed models

# 1 Introduction

## 1.1 Background and research gap

Active mobility is promoted as low-carbon and healthy urban transport, but the route still sets the heat, noise, traffic and visual complexity a person meets. Outdoor comfort is adaptive. It depends on the person and the place, not on air temperature alone (Nikolopoulou et al., 2001). In summer those route conditions coincide with the hottest part of the afternoon, which is when this campaign was run.

Field studies of that comfort have usually taken one mode at a time. Park walks have been linked to physiological and psychological responses (Song et al., 2013, 2014), and urban walks to emotions and bodily responses (Rodrigues et al., 2026). Cycling comfort has been linked to micrometeorology and location (Pandya et al., 2026), and cycling gaze to the road task (Rupi & Krizek, 2019). The type of exercise itself changes outdoor thermal comfort (Lin et al., 2022). Walking and cycling were studied in separate designs, so the two modes have not been placed on one within-person scale.

The same limit applies to the measurements. Much of the physiological evidence for thermal comfort comes from stationary or indoor exposures (Mansi et al., 2022). Electrodermal activity tracks sympathetic arousal, wrist skin temperature tracks local heat exchange, and wrist heart-rate variability is sensitive to motion and contact (Boucsein et al., 2012; Quigley et al., 2024; Stuyck et al., 2022). Mobile eye tracking is feasible outdoors and is sensitive to illumination, motion, calibration and scene complexity (Evans et al., 2012; Mahanama et al., 2021). Daylight can shift thermal perception when the thermal conditions themselves are held fixed (Chinazzo et al., 2019). In urban nature, vision and sound act together with the thermal setting (Zheng et al., 2024; Korpilo et al., 2024). A moving person therefore meets several exposures at once.

The missing comparison is within one person: walking versus cycling, on a green corridor and on an impervious urban corridor, with the microclimate, the wearable record, gaze and the end-of-phase ratings taken in the same protocol.

This study makes that comparison in Brussels in summer 2025. Each participant walks and cycles matched bouts in an impervious corridor, from Etterbeek toward Montgomery, and in a green corridor, the Bois de la Cambre. Wearable physiology, mobile eye tracking, a trailing microclimate record and short questionnaires are placed on one clock. The comparisons are green versus impervious, walking versus cycling, the agreement of the physiological record with the votes, and the thermal association in the presence of noise. A complementary block then estimates the thermal, acoustic, radiative and pollution terms together.

## 1.2 Hypotheses

The campaign was built around four hypotheses. A fifth block estimates the co-occurring exposures and is separate from the four tests.

1. H1 — Green versus impervious comfort. Participants show better physiological and perceived comfort in green than in impervious areas.
2. H2 — Physiological and perceived concordance. Physiological and perceived responses are concordant.
3. H3 — Cycling versus walking. Psychophysiological comfort is more compromised during cycling than during walking.
4. H4 — Noise and thermal discomfort. Noise and traffic-related sound amplify thermal discomfort.
5. Analysis — Combined exposure. Additive models describe adjusted associations when thermal, acoustic, radiative, pollution, and route-context terms co-occur. This block is a complementary analysis of adjusted exposure associations, separate from H1–H4.

# 2 Methods

The protocol is a within-person field comparison of route type and travel mode. The design, the sensors and the analysis follow in that order.

## 2.1 Study design

A repeated-measures field campaign was conducted in Brussels, Belgium, from 3 July to 27 August 2025 (Figure 1). Each participant completed four core outdoor mobility phases—cycling and walking in an impervious corridor, from Etterbeek toward Montgomery, and in a green corridor, the Bois de la Cambre—plus a seated tram phase that links the two (Figure 2). Phase labels were BikeU, WalkU, WalkG, BikeG and Tram; tram was excluded from the primary 2 × 2 environment-by-mode contrasts.

The afternoon window follows Pandya et al. (2026), in which UTCI and PET peaked between 14:00 and 16:00 in the summers of 2022–2024. Sessions ran from 13:30 to 17:30, the block shown on the same timeline (Figure 1). That window is the one set in the ethics protocol, so that consent and fitting were finished before the afternoon peak of the comfort indices.

Randomization of route order was planned. Participants completed questionnaires before and after each block. The participant wore the wristband, the eye-tracking glasses, and the light and air-quality loggers, and the trailing researcher carried the microclimate backpack (Figure 3); both were checked at breaks. The design targets within-person comparisons of environment and mode under naturalistic active mobility; route location, workload, illumination and co-exposures co-vary with phase, so inferential models estimate associations, not single-stressor causation.

State anxiety is the STAI-6 short form (Marteau & Bekker, 1992). Perceived restorativeness is the PRS-11 (Pasini et al., 2014). Comfort, pleasantness and familiarity are on the same end-of-phase form. The word anchors, the numeric scores and the phase assignment are in §2.2.5.

![Campaign timeline](../Figures/Experiment campaign timeline.svg)

Figure 1. Experiment campaign timeline.

![Route plan](../Figures/Route Plan for Experiment_05Nov.svg)

Figure 2. Route plan for the experiment.

![Sensor setup](../Figures/Experiment Sensor Setup Participant-01.svg)

Figure 3. Sensors worn by the participant.

### 2.1.1 Participants

Eighteen volunteers were tested (30 planned under ethics). Eleven with complete multi-sensor coverage on the four core phases were analysed (P4, P8–P17). Figure 4 marks these eleven on the matched 8-minute segment of each core phase, the segment used in the phase-mean models. Inclusion criteria were age 18–60 years, ability to walk and cycle the study routes, and vision compatible with mobile eye tracking. The IPSY ethics committee approved the study on 13 June 2025. With n = 11 and four repeated phase cells, a post hoc sensitivity calculation (α = 0.05, power = 0.80, r = 0.50) gave a minimum detectable f of about 0.52, equivalent to a partial η² of about 0.21.

The analysed sample comprises eleven participants (three women, eight men) aged 24–58 years (mean 35.2 years, SD 9.5), within the 18–60 year inclusion range. Self-reported height and weight yield BMI 20.5–33.0 kg·m⁻² (mean 23.8 kg·m⁻², SD 3.8): eight meet WHO normal weight (18.5–24.9 kg·m⁻²), two are overweight, and one has obesity. Project case-study labels classify eight as Fit and three as Not Fit and six as Active and five as Inactive (BMI- and daily-walking–based rules applied to the same eleven IDs). Clothing-questionnaire skin tone (Very fair, Fair, Medium, Olive, Brown) is mapped to Fitzpatrick types I–V by ascending shade (I, n = 1; II, n = 6; III, n = 2; IV, n = 1; V, n = 1; no type VI), covering the range where wrist photoplethysmography and optical heart rate on Empatica wearables may perform unevenly across pigmentation (Bent et al., 2020). Seven participants normally wear glasses; four report no vision correction. Fit/Not Fit and Active/Inactive labels are not entered in the primary models.

![Matched 8 min coverage](../Figures/Participants matched_8min.png)

Figure 4. Participants on the matched 8-minute segments.

## 2.2 Data compilation

Six sensors are recorded and reduced to 10-second tables. The backpack is a one-second microclimate and position record. Sound is one field in that record. Table 2.1 puts one sensor in each column. Each row under that sensor is one parameter, with the unit in brackets.

Table 2.1. Parameters compiled from each sensor.

| Empatica EmbracePlus | UCM backpack | Sound Spectrum | Sky view factor | Atmotube | LYS | Eye tracker | Questionnaire | Mapillary |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Pulse rate (beats min⁻¹) | Latitude (°) | Power share, 20–200 Hz (fraction) | Sky share (%) | PM1 (µg m⁻³) | Illuminance (lx) | Pupil diameter (mm) | Current comfort (1–7) | Green view (%) |
| Heart rate, same series stored again (beats min⁻¹) | Longitude (°) | Power share, 200–2000 Hz (fraction) | Tree share (%) | PM2.5 (µg m⁻³) | Colour temperature (K) | Pupil change rate (mm s⁻¹) | Familiarity with the place (1–5) | Tree share of the panorama (%) |
| Metabolic equivalent (MET) | Altitude (m) | Power share, 2000–20000 Hz (fraction) | Plant share (%) | PM10 (µg m⁻³) | Melanopic equivalent daylight illuminance | Blink duration (s) | Pleasantness (1–5) | Grass share of the panorama (%) |
| Skin conductance, raw (µS) | Horizontal dilution of precision | Power share, octave band 31.5 Hz (fraction) | Grass share (%) | Humidity (%) | Movement | Fixation duration (s) | Thermal comfort (1–5) | Plant share of the panorama (%) |
| Skin conductance, tonic (µS) | GPS heading (°) | Power share, octave band 63 Hz (fraction) | Building share (%) | Temperature (°C) | Blue, green and red channels | Fixation rate (s⁻¹) | Acoustic comfort (1–5) |  |
| Skin conductance, phasic (µS) | Magnetic heading (°) | Power share, octave band 125 Hz (fraction) | Wall share (%) |  | Red, green, blue and infrared colour record | Saccade duration (s) | Visual comfort (1–5) |  |
| Skin temperature (°C) | Receiver fix flag (code) | Power share, octave band 250 Hz (fraction) | Ceiling share (%) |  | Illuminance label (label) | Saccade amplitude (°) | Air-quality comfort (1–5) |  |
| Acceleration, x (g) | Count of valid speed samples (count) | Power share, octave band 500 Hz (fraction) | Vegetation share (%) |  |  | Saccade peak velocity (px s⁻¹) | Odour comfort (1–5) |  |
| Acceleration, y (g) | Speed (km h⁻¹) | Power share, octave band 1000 Hz (fraction) | Built-up share (%) |  |  | Gaze velocity (px s⁻¹) | Calm, reversed (1–5) |  |
| Acceleration, z (g) | Air temperature (°C) | Power share, octave band 2000 Hz (fraction) | Sky view factor |  |  | Gaze dispersion | Tense (1–5) |  |
| Acceleration magnitude (g) | Relative humidity (%) | Power share, octave band 4000 Hz (fraction) | Tree view factor |  |  | Distance from the centre (px) | Upset (1–5) |  |
| RMSSD (ms) | Absolute humidity (g m⁻³) | Power share, octave band 8000 Hz (fraction) | Building view factor |  |  | Gaze centrality | Relaxed, reversed (1–5) |  |
| SDNN (ms) | Air temperature, mast bottom (°C) | Peak frequency (Hz) |  |  |  | Eyelid aperture (mm) | Content, reversed (1–5) |  |
| Low-frequency power (ms²) | Air temperature, mast middle (°C) | Power-weighted mean frequency (Hz) |  |  |  | Stress composite | Worried (1–5) |  |
| High-frequency power (ms²) | Air temperature, mast top (°C) | Frequency below 85% of power (Hz) |  |  |  |  | Fascination (1–5) |  |
| Very-low-frequency power (ms²) | Infrared temperature, back (°C) | Wind type score (score) |  |  |  |  | Being away (1–5) |  |
| Total power (ms²) | Infrared temperature, front (°C) | Rural or natural type score (score) |  |  |  |  | Coherence (1–5) |  |
| Low-frequency / high-frequency ratio | Infrared temperature, left (°C) | Vehicle type score (score) |  |  |  |  | Scope (1–5) |  |
| Normalised low frequency (%) | Infrared temperature, right (°C) | Neutral man-made type score (score) |  |  |  |  | Height (m) |  |
| Normalised high frequency (%) | Infrared temperature, upward (°C) | Pleasant man-made type score (score) |  |  |  |  | Weight (kg) |  |
|  | Infrared temperature, downward (°C) | Unpleasant man-made type score (score) |  |  |  |  | Body mass index (kg m⁻²) |  |
|  | Spot temperature, ground (°C) | Mechanisms type score (score) |  |  |  |  |  |  |
|  | Spot temperature, sky (°C) | Wind proportion (fraction) |  |  |  |  |  |  |
|  | Spot temperature, left (°C) | Rural or natural proportion (fraction) |  |  |  |  |  |  |
|  | Spot temperature, right (°C) | Vehicle proportion (fraction) |  |  |  |  |  |  |
|  | Global horizontal irradiance (W m⁻²) | Neutral man-made proportion (fraction) |  |  |  |  |  |  |
|  | Solar altitude (°) | Pleasant man-made proportion (fraction) |  |  |  |  |  |  |
|  | Solar azimuth (°) | Unpleasant man-made proportion (fraction) |  |  |  |  |  |  |
|  | Recorded factor fp | Mechanisms proportion (fraction) |  |  |  |  |  |  |
|  | Extraterrestrial irradiance (W m⁻²) | Unidentified proportion (fraction) |  |  |  |  |  |  |
|  | Clearness index |  |  |  |  |  |  |  |
|  | A-weighted sound level (dB(A)) |  |  |  |  |  |  |  |
|  | Apparent wind speed (m s⁻¹) |  |  |  |  |  |  |  |
|  | Apparent wind angle (°) |  |  |  |  |  |  |  |
|  | True wind speed (m s⁻¹) |  |  |  |  |  |  |  |
|  | True wind direction (°) |  |  |  |  |  |  |  |
|  | Mean radiant temperature (°C) |  |  |  |  |  |  |  |
|  | Solar-modified mean radiant temperature (°C) |  |  |  |  |  |  |  |
|  | Operative temperature (°C) |  |  |  |  |  |  |  |
|  | HUMIDEX (index) |  |  |  |  |  |  |  |
|  | Solar-modified HUMIDEX |  |  |  |  |  |  |  |
|  | UTCI (°C) |  |  |  |  |  |  |  |
|  | Solar-modified UTCI (°C) |  |  |  |  |  |  |  |
|  | PET (°C) |  |  |  |  |  |  |  |
|  | Solar-modified PET (°C) |  |  |  |  |  |  |  |

Where no unit is shown in brackets, the recording does not state one. Every sensor is placed on one 10-second clock. The session key stores UTC. Those times are shifted by two hours onto Brussels local time, and each phase start is floored and each phase end is ceiled onto that clock. The clock runs from the first phase start to the last phase end of the session, including the indoor period and the gaps. Time between phases is labelled rest and is not a contrast. A missing sample stays missing. No value is interpolated or carried into the next bin, except the last sky-view value of a bout, which is copied from the previous row when the gap is exactly 10 s. The phase-mean models use the first eight minutes of each route phase, which is 49 rows from 0 through 480 s, for the eleven analysed participants (44 participant × phase cells). Indoor and rest rows are not cut to eight minutes.

### 2.2.1 Empatica

Empatica measures wrist skin temperature, electrodermal activity, pulse rate, heart-rate variability, acceleration and metabolic equivalent.

### 2.2.2 UCM backpack

The UCM backpack measures air temperature, humidity, solar radiation, wind, mean radiant temperature, UTCI, PET, position and A-weighted sound level. It also measures sky view, tree view and building view, and the share of wind, nature, vehicle and man-made sound (Figure 5).

![Type score and proportion in one 10 s epoch](../Figures/score_vs_proportion_10s.png)

Figure 5. Type score and type proportion in one 10 s epoch.

### 2.2.3 Atmotube and LYS

Atmotube measures particulate matter. LYS measures illuminance and colour temperature.

### 2.2.4 Eye tracker

The eye tracker measures pupil diameter, eyelid aperture, blinks, fixations, saccades and gaze.

### 2.2.5 Questionnaire

The questionnaire measures comfort, pleasantness, familiarity, state anxiety and perceived restorativeness at the end of each phase. A higher comfort, pleasantness or restorativeness score means more of that quality. Calm, relaxed and content are reversed, so a higher score means more state anxiety.

### 2.2.6 Mapillary

Mapillary measures green view along each route.

## 2.3 Statistical analysis

Phase-mean contrasts use restricted maximum likelihood (REML) linear mixed models (Pinheiro & Bates, 2000) on the participant × phase means, so that the comparison is within person and the 10-second counts are not treated as independent observations (Cnaan et al., 1997; Enders & Tofighi, 2007). Planned contrasts are estimated marginal means (Lenth, 2023). Questionnaire–physiology coupling uses the repeated-measures correlation (Bakdash & Marusich, 2017). Benjamini–Hochberg correction (α = 0.05; Benjamini & Hochberg, 1995) is applied inside each prespecified family. The repeated-measures field design follows ambulatory precedent (Rodrigues et al., 2026; Korkmaz et al., 2025).

| Hypothesis | Phaseavg | Timeseries |
| --- | --- | --- |
| H1 | Within one person, does the 8-minute green bout differ from the 8-minute impervious bout on the 26 physiological outcomes? Cycling is BikeG − BikeU. Walking is WalkG − WalkU. | Within one person, does a 10-second epoch in the green corridor differ from a 10-second epoch in the impervious corridor on the 26 physiological outcomes? Cycling is BikeG − BikeU. Walking is WalkG − WalkU. Epochs within a bout are autocorrelated. |
| H2 | Within one person, does a higher end-of-phase questionnaire score go together with a higher or lower phase-mean physiological value? The statistic is the repeated-measures correlation across the four phases. | The questionnaire is completed at the end of the phase, so it is not computed on 10-second epochs. |
| H3 | Within one person, does the 8-minute walking bout differ from the 8-minute cycling bout on the 26 physiological outcomes? Impervious is WalkU − BikeU. Green is WalkG − BikeG. | Within one person, does a 10-second walking epoch differ from a 10-second cycling epoch on the 26 physiological outcomes? Impervious is WalkU − BikeU. Green is WalkG − BikeG. Epochs within a bout are autocorrelated. |
| H4 | On the phase or block used by each source paper, is a higher A-weighted sound level associated with greater thermal discomfort? | No separate 10-second H4 model is fitted. The literature tests use the phase mean, the 5-minute block, or the end-of-phase vote specified by each paper. |

H1, green versus impervious comfort, uses the phase-mean model

Y_ij = β_0 + Phase_ij + u_i + ε_ij, (1)

where i is the participant, j is the phase, u_i is the participant intercept, and Phase is the bout. The two contrasts are cycling (BikeG − BikeU) and walking (WalkG − WalkU). Each contrast is its own Benjamini–Hochberg family of 26 physiological outcomes. Questionnaire items use their own families. A sensitivity repeats the contrasts on outcomes standardised within person.

H3, cycling versus walking, uses equation (1). The two contrasts are impervious (WalkU − BikeU) and green (WalkG − BikeG), and each is its own family of 26 outcomes. Questionnaire items use their own families, as in H1.

On the 10-second epochs, H1 and H3 use the same contrasts on the within-person standardised outcome,

Y_ijt = β_0 + Phase_ijt + u_i + ε_ijt, (2)

where t is the epoch and the errors within a bout follow a first-order autoregressive correlation.

H2, physiological and perceived concordance, is the repeated-measures correlation (Bakdash & Marusich, 2017), fitted on the phase means as

vote_ij = α_i + β physiology_ij + ε_ij. (3)

Each person has a separate intercept and the slope is shared. That slope is the change in vote points for a 1-unit increase in the physiological measure. From its t statistic,

r = sign(t) × √(t² / (t² + ν)), (4)

where ν is the residual degrees of freedom. The interval for r is the Fisher-z interval of Bakdash & Marusich (2017). A pair is estimated when it has at least 20 complete means from at least 8 participants. The grid is 18 questionnaire scores by 26 physiological outcomes, and those pairs form one family. The vote is taken at the end of the phase, so this correlation is not computed on 10-second epochs.

H4, noise and thermal discomfort, adapts each included source model to the 8-minute bouts. Moshammer, Jin, Rodrigues, Biel and Korpilo include a sound term and a thermal term. Kraus is included as the published piecewise personal-noise model. Song et al. (2013, 2014) is not fitted: that comparison is park versus city and has neither a sound level nor a thermal term. Heat and noise are observed, not assigned. Benjamini–Hochberg correction is applied within each source’s own family of tests.

1. Moshammer et al. (2019). Random-effects generalised least squares. The source uses consecutive 15-minute intervals. Here the preceding exposure is the energy-mean sound level of the first 5 minutes, L_prev, and the outcome is heart rate and heart-rate variability over minutes 5–8, recomputed from the beat intervals in that window. The model is fitted on all phases and on the walking phases,

Y_i = β_0 + β_1 L_prev,i + u_i + ε_i, (5)

and again with air temperature added.
2. Jin, Jin and Kang (2020). Two-way analysis of variance of 5 dB sound-level bands by UTCI heat-stress categories, for thermal comfort and overall comfort,

Comfort = μ + LAeq band + UTCI category + LAeq band × UTCI category + ε. (6)

Main effects and the interaction use Type II sums of squares, without a participant block, as in the source.
3. Biel et al. (2020). A linear mixed model of heart rate and heart-rate variability on concurrent personal noise, scaled per interquartile range, with air temperature,

Y_ij = β_0 + β_1 noise_ij + β_2 T_ij + u_i + ε_ij. (7)

Relative humidity is kept only when it changes the noise coefficient by at least 10%. The same model is fitted to the phase means and to consecutive 2-minute windows with a first-order autoregressive error.
4. Korpilo et al. (2024). The logarithm of phase-mean tonic electrodermal activity is regressed on an analogue of the normalised difference soundscape index, air temperature, relative humidity and phase, with a participant intercept,

ln(EDA_ij) = β_0 + β_1 NDSI_ij + β_2 T_ij + β_3 RH_ij + Phase_ij + u_i + ε_ij. (8)
5. Rodrigues et al. (2026). On the walking bouts, skin temperature and heart-rate summaries are regressed on the maximum and the standard deviation of sound, and, separately, on the maximum and the mean of temperature. Both predictors are standardised,

Y_ij = β_0 + β_1 z_max,ij + β_2 z_mean or sd,ij + u_i + ε_ij. (9)

A coefficient meets the source rule when the rounded p-value is below 0.05 and the absolute rounded coefficient exceeds 0.1.
6. Kraus et al. (2013). An additive mixed model on the first 5 minutes of each bout, with a piecewise slope at 65 dB(A), activity (walk or cycle), and a compound-symmetry correlation,

Y = β_0 + β_below L_below + β_above L_above + activity + u_i + ε, (10)

where L_below = (min(L, 65) − 65) / 5 and L_above = (max(L, 65) − 65) / 5, in dB(A). Heart rate is included when the outcome is heart-rate variability.
7. Each sound-dependent model is repeated after the A-weighted level is replaced by one descriptor defined in §2.2.2. The value entered is the arithmetic mean of that descriptor over the window used by the source paper. Bins that were defined in decibels are replaced: Jin uses quartiles of the phase means, Kraus uses a median knot and a slope per 1 standard deviation, Biel uses the interquartile range, Moshammer uses a slope per unit, and Rodrigues uses the maximum and the standard deviation, each standardised. Korpilo is not repeated, because its sound term is already a band index. Correction stays inside each source and each descriptor.

The combined-exposure analysis fits seven additive mixed models, at 10 seconds and at phase means (Hamra & Buckley, 2018). It is a complementary analysis of adjusted exposure associations, separate from H1–H4. Each equation has the form

Y = β_0 + Thermal + co-exposures + route contrasts + u_i + ε, (11)

where u_i is the participant intercept. The thermal term rotates across the seven equations (UTCI, air temperature with humidity and wind, mean radiant temperature, HUMIDEX, PET, then UTCI again with PM1 or PM10 in place of PM2.5). The co-exposures are A-weighted sound, sky view, PM2.5, illuminance and colour temperature. The 10-second equations also include solar irradiance and green view, except the mean-radiant-temperature equation, which omits direct solar irradiance and sky view because mean radiant temperature is already the radiation term. Green view stays in that equation. The phase-mean form of the air-temperature equation omits sound. A term is screened by

VIF = 1 / (1 − R²), (12)

with the Fox–Monette factor for the route block (Marquardt, 1970; Fox & Monette, 1992; James et al., 2013). The factor is reported with the fitted specification. Specifications with a maximum variance inflation factor above 10 are flagged for substantial collinearity; their individual exposure coefficients are interpreted cautiously. Correction is applied to the coefficients within each equation.

The cross-system network computes Pearson’s r on the 44 phase means,

r = covariance(x, y) / (s_x s_y). (13)

Three blocks share one Benjamini–Hochberg family: exposure with biomarker, biomarker with the end-of-phase vote, and exposure with the vote. A pair is tested when both variables are present for at least 15 means. The candidates are the view factors, the thermal and acoustic exposures, particulate matter and illuminance; skin temperature, heart rate, heart-rate variability, electrodermal activity and the ocular measures; and the STAI-6 mean, the PRS-11 mean, the comfort votes and pleasantness. The person mean is not removed, so this is not equation (4). A pair is retained when q < 0.05.

# 3 Results

## 3.1 Microclimate of the green and impervious routes

Figure 6 compares the 10-second rows across the four core phases for UTCI, air temperature, mean radiant temperature, sound, PM2.5, illuminance, sky view and green view. The green phases sit cooler, quieter and less sunlit than the impervious phases. The median of the eleven phase medians was lower on the green routes than on the impervious routes. UTCI was 25.1 °C during green cycling and 23.8 °C during green walking, against 27.0 °C and 32.0 °C. Sound was 59.5 and 61.5 dB(A), against 71.8 and 67.8 dB(A). Solar irradiance was 123 and 57 W m⁻², against 162 and 686 W m⁻². Figure 7 gives the same sound exposure as a count of 10-second rows in level bands, which is a different summary.

![Exposures by phase](../Figures/Figure5_exposures_by_phase.svg)

Figure 6. Microclimate and co-exposures by phase.

![Sound level bands by participant and phase](../Figures/Figure12_sound_level_bands.svg)

Figure 7. A-weighted sound level by participant and phase.

## 3.2 H1 — Green versus impervious comfort

Phase-mean models (§2.3). Figure 8 draws each green-minus-impervious contrast twice, the phase-mean estimate on the left and the 10-second estimate on the right, on one axis from −5 to 5 standard deviations. A filled point, with its q printed, is a contrast that passed correction. Green phases were associated with lower skin temperature and with larger pupil diameter (pupil is illumination-sensitive), and the other filled points are the eye-movement contrasts in Table 3.2. On the end-of-phase votes, 18 contrasts passed correction, in families separate from §3.3. Thermal comfort was 0.64 points higher during green cycling and 1.09 points higher during green walking. The other retained votes were higher comfort or restorativeness on the green phase, and reversed calm was 0.91 points lower on both modes.

![H1 phase-mean and 10 s contrasts](../Figures/Figure6_H1_forest.svg)

Figure 8. H1 green versus impervious contrasts.

Table 3.2. Physiological contrasts with q < 0.05. These rows are the filled points in Figure 8. The estimate column is the phase-mean model estimate in the outcome’s own units. The 10-second model is fitted on standardised outcomes, so those rows are in SD units.

| Method | Contrast | Outcome | Estimate | q |
| --- | --- | --- | --- | --- |
| Phaseavg | BikeG − BikeU | Skin temperature | −1.12 °C | 0.0178 |
| Phaseavg | BikeG − BikeU | Blink duration | −0.0092 s | 4.55e-06 |
| Phaseavg | BikeG − BikeU | Distance from centre | −38.1 px | 0.0159 |
| Phaseavg | BikeG − BikeU | Eyelid aperture | 0.877 mm | 0.0336 |
| Phaseavg | BikeG − BikeU | Pupil diameter | 0.393 mm | 0.0178 |
| Phaseavg | WalkG − WalkU | Skin temperature | −1.16 °C | 0.00916 |
| Phaseavg | WalkG − WalkU | Blink duration | −0.0133 s | 6.72e-09 |
| Phaseavg | WalkG − WalkU | Fixation duration | 0.0266 s | 0.00236 |
| Phaseavg | WalkG − WalkU | Gaze dispersion | −0.0111 (dimensionless) | 0.00810 |
| Phaseavg | WalkG − WalkU | Gaze velocity | −378 px s⁻¹ | 0.00838 |
| Phaseavg | WalkG − WalkU | Pupil diameter | 0.949 mm | 3.64e-07 |
| Timeseries | BikeG − BikeU | Skin temperature | −1.03 SD | 0.0187 |
| Timeseries | BikeG − BikeU | Blink duration | −0.30 SD | 0.00123 |
| Timeseries | BikeG − BikeU | Distance from centre | −0.63 SD | 0.00123 |
| Timeseries | BikeG − BikeU | Eyelid aperture | 0.90 SD | 0.00145 |
| Timeseries | BikeG − BikeU | Pupil diameter | 0.72 SD | 0.00205 |
| Timeseries | WalkG − WalkU | Blink duration | −0.41 SD | 5.95e-05 |
| Timeseries | WalkG − WalkU | Fixation duration | 0.58 SD | 0.00108 |
| Timeseries | WalkG − WalkU | Gaze dispersion | −0.51 SD | 0.00205 |
| Timeseries | WalkG − WalkU | Gaze velocity | −0.67 SD | 0.00858 |
| Timeseries | WalkG − WalkU | Pupil diameter | 1.63 SD | 5.94e-08 |

## 3.3 H2 — Physiological and perceived concordance

The repeated-measures correlation uses the four phase means of each person (Figure 9). Each cell is the correlation of one end-of-phase vote with one phase-mean physiological measure. A positive r means that, within a person, a higher vote goes with a higher physiological value, and a black box is q < 0.05. The boxed cells are skin temperature, pupil diameter, blink duration and fixation duration. Heart rate and tonic electrodermal activity have no box. It is not a 10-second correlation, and there is no Timeseries H2. Calm, relaxed and content are the only reversed questionnaire scores in this figure. Tense, upset and worried already point toward more anxiety, so they are not reversed. The PRS subscales, pleasantness and the comfort items are not reversed: a higher score means more fascination, being away, coherence, scope, pleasantness or comfort.

![H2 correlations](../Figures/Figure8_H2_rmcorr.svg)

Figure 9. Repeated-measures correlation between the end-of-phase vote and the phase-mean physiology.

| Item | Reversed in the model | Higher score means |
| --- | --- | --- |
| STAI calm, relaxed, content | Yes | More state anxiety |
| STAI tense, upset, worried | No | More state anxiety |
| PRS fascination, being away, coherence, scope | No | More of that restorative quality |
| Pleasantness and comfort items | No | More pleasant, or more comfort |

Table 3.3. The 21 pairs with q < 0.05. These are the black boxes in Figure 9. r and q are the fitted repeated-measures correlation and its Benjamini–Hochberg value (Bakdash & Marusich, 2017). The vote-change column for skin temperature and pupil diameter is the exported slope per 1 °C and per 1 mm. For blink duration the exported slope is per 1 s; the cell is that slope multiplied by 0.01, which is the vote change for a 0.01 s increase. For fixation duration the cell is the exported per-1 s slope multiplied by 0.1. r and q are not affected by that multiplication. There is no 10-second H2.

| Method | Questionnaire | Physiological outcome | Vote change | r | q |
| --- | --- | --- | --- | --- | --- |
| Phaseavg | Acoustic comfort | Skin temperature | −0.54 points per 1 °C | −0.564 | 0.0310 |
| Phaseavg | Acoustic comfort | Blink duration | −0.67 points per 0.01 s | −0.673 | 0.00711 |
| Phaseavg | Air-quality comfort | Skin temperature | −0.51 points per 1 °C | −0.537 | 0.0377 |
| Phaseavg | Air-quality comfort | Blink duration | −0.54 points per 0.01 s | −0.558 | 0.0377 |
| Phaseavg | Air-quality comfort | Pupil diameter | +1.15 points per 1 mm | 0.581 | 0.0359 |
| Phaseavg | Pleasantness | Blink duration | −0.68 points per 0.01 s | −0.658 | 0.00711 |
| Phaseavg | PRS being away | Skin temperature | −0.58 points per 1 °C | −0.513 | 0.0439 |
| Phaseavg | PRS being away | Blink duration | −0.85 points per 0.01 s | −0.683 | 0.00711 |
| Phaseavg | PRS being away | Pupil diameter | +1.39 points per 1 mm | 0.542 | 0.0439 |
| Phaseavg | PRS fascination | Skin temperature | −0.46 points per 1 °C | −0.559 | 0.0310 |
| Phaseavg | PRS fascination | Blink duration | −0.59 points per 0.01 s | −0.665 | 0.00711 |
| Phaseavg | PRS fascination | Pupil diameter | +1.31 points per 1 mm | 0.715 | 0.00426 |
| Phaseavg | PRS scope | Blink duration | −0.63 points per 0.01 s | −0.571 | 0.0377 |
| Phaseavg | PRS scope | Pupil diameter | +1.33 points per 1 mm | 0.592 | 0.0310 |
| Phaseavg | STAI calm (reversed) | Blink duration | +0.42 points per 0.01 s | 0.560 | 0.0377 |
| Phaseavg | STAI calm (reversed) | Pupil diameter | −0.88 points per 1 mm | −0.562 | 0.0377 |
| Phaseavg | Thermal comfort | Blink duration | −0.41 points per 0.01 s | −0.653 | 0.00711 |
| Phaseavg | Thermal comfort | Pupil diameter | +0.74 points per 1 mm | 0.569 | 0.0377 |
| Phaseavg | Visual comfort | Skin temperature | −0.38 points per 1 °C | −0.517 | 0.0426 |
| Phaseavg | Visual comfort | Blink duration | −0.44 points per 0.01 s | −0.559 | 0.0377 |
| Phaseavg | Visual comfort | Fixation duration | +1.96 points per 0.1 s | 0.553 | 0.0396 |

## 3.4 H3 — Cycling versus walking

Phase-mean contrasts (§2.3). Figure 10 uses the same two-panel layout as Figure 8, and a filled point is q < 0.05. Walking versus cycling showed 8 FDR-significant primary physiological contrasts, all in eye movements: blinks, fixations, gaze and pupil. Tonic electrodermal activity, fixation rate and skin temperature did not survive correction, so those points stay open. Three vote contrasts did, all on the green corridor and separate from §3.3: pleasantness was 1.09 points lower, fascination 0.79 points lower and being away 0.97 points lower while walking than while cycling.

![H3 phase-mean and 10 s contrasts](../Figures/Figure7_H3_forest.svg)

Figure 10. H3 walking versus cycling contrasts.

Table 3.4. Physiological contrasts with q < 0.05. These rows are the filled points in Figure 10. The estimate column is the phase-mean model estimate in the outcome’s own units. The 10-second rows are in SD units.

| Method | Contrast | Outcome | Estimate | q |
| --- | --- | --- | --- | --- |
| Phaseavg | WalkG − BikeG | Blink duration | 0.0110 s | 1.89e-07 |
| Phaseavg | WalkG − BikeG | Distance from centre | 52.8 px | 0.000275 |
| Phaseavg | WalkG − BikeG | Gaze centrality | −0.0928 (dimensionless) | 0.000275 |
| Phaseavg | WalkU − BikeU | Blink duration | 0.0151 s | 4.95e-10 |
| Phaseavg | WalkU − BikeU | Fixation duration | −0.0343 s | 7.20e-05 |
| Phaseavg | WalkU − BikeU | Gaze dispersion | 0.0189 (dimensionless) | 2.04e-05 |
| Phaseavg | WalkU − BikeU | Gaze velocity | 609 px s⁻¹ | 5.05e-05 |
| Phaseavg | WalkU − BikeU | Pupil diameter | −0.465 mm | 0.00385 |
| Timeseries | WalkG − BikeG | Blink duration | 0.37 SD | 6.14e-05 |
| Timeseries | WalkG − BikeG | Distance from centre | 0.90 SD | 1.07e-05 |
| Timeseries | WalkG − BikeG | Fixation duration | −0.43 SD | 0.00654 |
| Timeseries | WalkG − BikeG | Gaze centrality | −0.82 SD | 2.66e-05 |
| Timeseries | WalkU − BikeU | Blink duration | 0.48 SD | 4.13e-06 |
| Timeseries | WalkU − BikeU | Eyelid aperture | 0.92 SD | 0.000961 |
| Timeseries | WalkU − BikeU | Fixation duration | −0.78 SD | 1.07e-05 |
| Timeseries | WalkU − BikeU | Gaze dispersion | 0.89 SD | 4.13e-06 |
| Timeseries | WalkU − BikeU | Gaze velocity | 1.19 SD | 1.14e-05 |
| Timeseries | WalkU − BikeU | Pupil diameter | −0.76 SD | 0.00118 |

## 3.5 H4 — Noise and thermal discomfort

Benjamini–Hochberg correction (q < 0.05) is applied within each paper’s test family. Each author’s own unadjusted rule is also recorded. The first table is the calibrated A-weighted level. The same models are then repeated with the sound-type proportions and the frequency shares defined in §2.2.2. Korpilo’s sound term is its own band index, so that test is not repeated. Song et al. (2013, 2014) is not fitted. Before those tests, Figure 7 counts the matched 10-second rows in each sound-level band, out of 48, by participant and phase. The bands are below 55, 55–65, 65–70, 70–75 and at least 75 dB(A). The green phases fall in the lower bands: the panel medians are 60.5 dB(A) on WalkG and 59.0 on BikeG, against 67.5 on WalkU and 71.2 on BikeU. The figure itself fits no model.

On the calibrated A-weighted level:

| Source | Primary tests | Paper decision rule | Paper rule met | Primary q < 0.05 | Supplementary q < 0.05 (YAMNet & Spectral) |
| --- | --- | --- | --- | --- | --- |
| Jin et al. (2020) | 6 | p < 0.05 | 0 | 0 | 4 |
| Moshammer et al. (2019) | 20 | p < 0.05 (Table A2 bold) | 1 (RR distance, unadjusted) | 0 | 17 |
| Kraus et al. (2013) (5-min lag 0) | 10 | 95% CI excludes 0 (p < 0.05) | 0 | 0 | 15 |
| Rodrigues et al. (2026) | 60 | round(p,4) < 0.05 & \|beta\| > 0.1 | 9 (2 noise, 7 temp) | 6 (1 noise, 5 temp) | 22 |
| Biel et al. (2020) | 10 | p < 0.05 (LMM Wald) | 0 | 0 | 3 |
| Korpilo et al. (2024) (NDSI analogue) | 1 | p < 0.05 (GLMM Wald) | 0 | 0 | none fitted |

Stopping or omitting the false-discovery-rate correction does not produce significance on the calibrated decibel level for Jin, Kraus, Biel, or Korpilo:

1. Jin et al. (2020): Two-way ANOVA revealed no significant LAeq level main effect on Thermal Comfort Vote (TCV: F = 0.441, p = 0.648) or Overall Comfort Vote (OCV: F = 0.354, p = 0.705). The heat-by-sound interaction was explicitly null for both comfort votes: TCV interaction F(3, 30) = 0.270, p = 0.846; OCV interaction F(3, 30) = 0.062, p = 0.980.
2. Moshammer et al. (2019): In the unadjusted noise-only model across all phases, mean RR distance rose by +3.373 ms per dB(A) (SE = 1.690, z = 1.996, p = 0.0459). This met Moshammer's raw p < 0.05 rule, but did not survive Benjamini–Hochberg correction across the 5 cardiovascular outcomes (q = 0.230). Controlling for mean air temperature widened the standard error and moved the term to non-significance (+3.134 ms/dB, SE = 1.797, z = 1.744, p = 0.0811). All other cardiovascular outcomes (SDNN, RMSSD, LF, HF) had standard errors as large as or larger than the estimated slopes (e.g. unadjusted SDNN: +0.429 ms/dB, SE = 0.658, p = 0.514; RMSSD: -0.064 ms/dB, SE = 0.777, p = 0.934).
3. Kraus et al. (2013): In non-overlapping 5-minute intervals (lag 0), the heart-rate slope below 65 dB(A) was -2.063% per 5 dB increase (SE = 3.949, t = -0.387, p = 0.701). The 95% confidence interval (-12.99% to +8.86%) broadly spans zero. Piecewise slopes for heart rate and all HRV metrics (SDNN, LFnu, HFnu, LF/HF) showed p > 0.35.
4. Biel et al. (2020): Phase-mean heart rate changed by -0.584 bpm per IQR of sound (5.24 dB; SE = 1.066, t = -0.548, p = 0.588). Phase-mean HRV outcomes likewise yielded large uncertainty (SDNN: +1.744 ms/IQR, SE = 3.069, p = 0.574; RMSSD: +2.929 ms/IQR, SE = 4.159, p = 0.487). Repeated 2-minute short-window models with corAR1 errors confirmed this null pattern.
5. Korpilo et al. (2024): The NDSI analogue regressed on ln phase-mean tonic EDA was non-significant (-2.508 ln µS per 1 NDSI unit, SE = 3.864, t = -0.649, p = 0.525).
6. Rodrigues et al. (2026): Out of 60 total tests, 9 met the paper's retention rule (2 noise block, 7 temperature block), and 6 survived BH FDR (1 noise block, 5 temperature block). The surviving noise association was minimum wrist skin temperature regressed on trip maximum sound level (+0.874 °C per 1 SD, SE = 0.150, z = 5.828, q = 8.30e-08).

Replacing the A-weighted level with those proportions and frequency shares leaves 61 coefficients with q < 0.05. Fifty-eight are sound-descriptor terms. Three are Jin UTCI-category effects on thermal comfort. None is a heat-by-sound interaction. The rows below are examples.

| Acoustic Descriptor | Type / Category | Source Model | FDR-Significant Outcome(s) (q < 0.05) | Scientific Finding |
| --- | --- | --- | --- | --- |
| rural_natural_proportion | YAMNet Nature / Birdsong | Moshammer 2019 (GLS) | RMSSD_ms (q = 0.041); HF_power (q = 0.041) | RMSSD +118 ms and HF power +26615 per unit, walking phases. |
| rural_natural_proportion | YAMNet Nature / Birdsong | Jin et al. 2020 (ANOVA) | Not q < 0.05. Thermal comfort p = 0.046 | Uncorrected only. Not one of the 61. |
| rural_natural_proportion | YAMNet Nature / Birdsong | Rodrigues 2026 (MixedLM) | MEAN_LF_HF_ratio (q = 0.038) | Mean LF/HF +0.22 per 1 SD of the maximum and −0.25 per 1 SD of the standard deviation. |
| vehicle_proportion | YAMNet Traffic Noise | Jin et al. 2020 (ANOVA) | TCV_thermal_comfort, UTCI-category main effect (q = 0.00366) | The surviving term is the heat category, not a vehicle-sound slope. |
| urban_manmade_positive | YAMNet Pedestrian Ambiance | Moshammer 2019 (GLS) | RR_distance_ms −486 ms per unit (q = 0.000568) | A higher proportion shortened the RR interval. |
| urban_manmade_positive | YAMNet Pedestrian Ambiance | Rodrigues 2026 (MixedLM) | STD_LF_HF_ratio (q = 0.024); MAX_LF_HF_ratio; MEAN_bpm | Lower LF/HF dispersion and mean heart rate +4.0 bpm per 1 SD of the maximum. |
| urban_manmade_negative | YAMNet Horns / Sirens | Moshammer 2019 (GLS) | RR_distance_ms (q = 0.048); LF_power (q = 0.048) | Longer RR interval and lower LF power. |
| freq_2000_to_20000Hz | High-frequency share | Biel 2020 (repeated window) | Heart rate +2.30 bpm per IQR (q = 0.0489) | A higher share went with a higher heart rate. |
| freq_2000_to_20000Hz | High-frequency share | Kraus 2013 | Heart rate +6.96% per 1 SD above the median knot (q = 0.0234) | A higher share went with a higher heart rate. |
| octave_250_Hz | Spectral Low-Mid Frequency | Moshammer 2019 (GLS) | SDNN_ms (q = 0.028); RMSSD_ms (q = 0.045) | Higher SDNN and RMSSD. |

## 3.6 Analysis — Combined exposure

Additive models at 10 s and at phase means (§2.3). Of 2,184 ten-second coefficients, 152 have q < 0.05; of 1,846 phase-mean coefficients, 30 do. The mean-radiant-temperature specification, combined-exposure model 3, has a maximum variance inflation factor of 1.14 at 10 s and 80.24 at phase means.

Of the 30 phase-mean and 152 ten-second coefficients with q < 0.05, 16 and 126 are a bout versus the average of the four bouts. The following tables summarise the other 14 and 26 exposure associations; phase-indicator coefficients are omitted from this summary. Each slope has the other terms in its equation held constant. None of these slopes is FDR-significant at both grains. Four of the 14 phase-mean rows are model 3. That phase-mean fit has a maximum variance inflation factor of 80.24. Severe collinearity in the phase-mean mean-radiant-temperature model limits attribution of its associations to individual predictors. The ten phase-mean slopes that remain are higher heart-rate variability with higher UTCI or air temperature, and higher gaze velocity with air temperature. The 26 ten-second slopes are ocular, mostly pupil diameter and pupil change rate with sky view factor or solar radiation.

| Eq | Outcome | Term | Estimate | q |
| --- | --- | --- | --- | --- |
| 1 | HRV total power | UTCI | 0.3355 | 0.04484 |
| 1 | HRV VLF | UTCI | 0.5933 | 0.04484 |
| 2 | HRV HF | Air temperature | 0.274 | 0.0407 |
| 2 | HRV LF | Air temperature | 0.4018 | 0.04855 |
| 2 | HRV total power | Air temperature | 0.3526 | 0.03928 |
| 2 | HRV VLF | Air temperature | 0.5656 | 0.04855 |
| 2 | HRV SDNN | Air temperature | 0.1604 | 0.04921 |
| 2 | Gaze velocity | Air temperature | 320.6 | 0.03928 |
| 3 | HRV HF | Mean radiant temperature | 0.4026 | 0.02872 |
| 3 | HRV LF | Mean radiant temperature | 0.5841 | 0.02872 |
| 3 | HRV total power | Mean radiant temperature | 0.5198 | 0.03956 |
| 3 | HRV SDNN | Mean radiant temperature | 0.2268 | 0.03956 |
| 7 | HRV total power | UTCI | 0.3378 | 0.04953 |
| 7 | HRV VLF | UTCI | 0.6043 | 0.04953 |

10-second table. Twenty-six exposure slopes with q < 0.05.

| Eq | Outcome | Term | Estimate | q |
| --- | --- | --- | --- | --- |
| 1 | Pupil change rate | Sky view factor | -0.002212 | 0.02702 |
| 1 | Pupil diameter | Sky view factor | -0.05292 | 0.02939 |
| 2 | Fixation duration (s) | Solar radiation | -0.00776 | 0.02658 |
| 2 | Pupil change rate | Sky view factor | -0.002213 | 0.01716 |
| 2 | Pupil change rate | Air temperature | 0.004486 | 0.001037 |
| 2 | Pupil diameter | Sky view factor | -0.05492 | 0.01716 |
| 2 | Pupil diameter | Solar radiation | -0.0757 | 0.02187 |
| 3 | Fixation duration (s) | Mean radiant temperature | -0.006009 | 0.04385 |
| 3 | Pupil diameter | Mean radiant temperature | -0.08943 | 0.0002146 |
| 4 | Fixation duration (s) | Solar radiation | -0.007048 | 0.02821 |
| 4 | Pupil change rate | Sky view factor | -0.001954 | 0.04 |
| 4 | Pupil change rate | Humidex | 0.002731 | 0.01141 |
| 4 | Pupil diameter | Sky view factor | -0.05503 | 0.03378 |
| 4 | Pupil diameter | Solar radiation | -0.07723 | 0.0177 |
| 5 | Fixation duration (s) | Solar radiation | -0.00755 | 0.02937 |
| 5 | Fixation rate | Green view | 0.02716 | 0.04942 |
| 5 | Pupil change rate | Sky view factor | -0.002144 | 0.01847 |
| 5 | Pupil change rate | Green view | -0.001921 | 0.04942 |
| 5 | Pupil diameter | Sky view factor | -0.05493 | 0.01847 |
| 5 | Pupil diameter | Solar radiation | -0.0769 | 0.01871 |
| 6 | Pupil change rate | Sky view factor | -0.002203 | 0.03041 |
| 6 | Pupil change rate | Solar radiation | -0.003402 | 0.04979 |
| 6 | Pupil diameter | Sky view factor | -0.05286 | 0.03056 |
| 6 | Pupil diameter | Solar radiation | -0.06062 | 0.04979 |
| 7 | Pupil change rate | Sky view factor | -0.002217 | 0.02528 |
| 7 | Pupil diameter | Sky view factor | -0.05288 | 0.02957 |

## 3.7 Cross-system correlations

Figure 11 applies the stimulus–organism–response arrangement of Grapas et al. (2026, their Fig. 5) to the 44 participant × phase means. Each line is a Pearson correlation. Of 457 pairs, 67 have q < 0.05: 30 from an exposure to a biomarker, 16 from a biomarker to a vote, and 21 from an exposure directly to a vote. Thirty correlations are positive and 37 are negative. These are not the repeated-measures correlations in §3.3, which remove the person mean. The strongest line is air temperature with wrist skin temperature (r = 0.871, q = 6.85e-12). UTCI (r = 0.789, q = 4.52e-08) and mean radiant temperature (r = 0.684, q = 2.76e-05) show the same positive link with skin temperature, and air temperature is also positively related to tonic electrodermal activity (r = 0.586, q = 0.00103). Building view factor is positively related to blink duration (r = 0.773, q = 1.19e-06), whereas tree view factor is negatively related to it (r = −0.674, q = 1.69e-04). Longer blinks go with lower restorativeness (r = −0.700, q = 5.43e-05), lower acoustic comfort (r = −0.599, q = 0.00136) and lower pleasantness (r = −0.597, q = 0.00136). Solar radiation goes with a smaller pupil (r = −0.724, q = 2.14e-05) and faster gaze (r = 0.623, q = 8.56e-04). A-weighted sound goes with lower restorativeness (r = −0.628, q = 2.74e-04). Particulate matter, heart rate and heart-rate variability have no line: their smallest q values in this family are above 0.05.

![Stimulus–organism–response network](../Figures/literature_fig2_multisystem_network.svg)

Figure 11. Correlations with q < 0.05 among physical exposures, wearable and ocular biomarkers, and end-of-phase votes (n = 11). A solid line is positive and a cased line is negative. Line width follows the absolute correlation. The arrangement follows Grapas et al. (2026) and Korkmaz et al. (2025).

# 4 Discussion

## 4.1 H1 — Green versus impervious comfort

Wrist skin temperature was 1.12 °C lower during green cycling than during impervious urban cycling, and 1.16 °C lower during green walking than during impervious urban walking. Thermal comfort was 0.64 points higher during green cycling and 1.09 points higher during green walking. The cycling difference in wrist temperature was also present in the ten-second model. The walking difference was not. Heart rate, heart-rate variability and tonic electrodermal activity were unchanged after correction. A cooler wrist is the expected direction if vegetation lowers the radiant and convective load on the person (Nikolopoulou et al., 2001; Fahy et al., 2025). Figure 12 shows the same outcomes by phase: a grey mark is one participant, the black square is the mean across participants, and a bracket marks an H1 or H3 contrast that passed correction.

![Outcomes by phase](../Figures/Figure6_outcomes_by_phase.svg)

Figure 12. Physiological and ocular outcomes by phase.

Pupil diameter was 0.393 mm larger during green cycling and 0.949 mm larger during green walking. Pupil size varies with illuminance and with arousal (Mahanama et al., 2021), and the urban and green corridors differ in both the light and the scene. The green-versus-impervious difference is more than twice as large while walking (0.949 mm) as while cycling (0.393 mm). On the impervious corridor, the pupil was 0.465 mm smaller while walking than while cycling (§4.3).

Blinks were 0.0092 s shorter during green cycling and 0.0133 s shorter during green walking. During green cycling, gaze sat 38.1 px closer to the centre of the scene and the eyelid aperture was 0.877 mm larger. During green walking, fixations were 0.0266 s longer, gaze dispersion was 0.0111 lower on its recorded scale, and gaze velocity was 378 px s⁻¹ lower. Shorter blinks on both modes, and longer fixations with a slower gaze on foot, describe a different visual sampling of the green corridor.

## 4.2 H2 — Physiological and perceived concordance

A warmer wrist went with lower end-of-phase ratings. Per 1 °C, acoustic comfort was 0.54 points lower, air-quality comfort 0.51 points lower, visual comfort 0.38 points lower, being away 0.58 points lower and fascination 0.46 points lower. The five slopes lie between about 0.4 and 0.6 points per degree. The route difference of about 1.1 °C in §4.1 is therefore large enough to shift these votes by roughly half a point. Heart rate, heart-rate variability and tonic electrodermal activity did not track the same votes. In this campaign the finished-phase rating followed the thermal signal at the wrist more closely than the cardiac or electrodermal channels. The questionnaire is one score for the whole phase, so it summarises the bout rather than the fluctuations inside it.

A 1 mm larger pupil went with higher ratings: air-quality comfort by 1.15 points, thermal comfort by 0.74 points, being away by 1.39 points, fascination by 1.31 points and scope by 1.33 points. The reversed calm score was 0.88 points lower. That item is scored so that a higher value means more state anxiety, and the larger pupil went with a lower value. Pupil diameter also tracks light (Mahanama et al., 2021), and green and impervious corridors differ in illuminance.

A 0.01 s longer blink went with lower ratings: acoustic comfort by 0.67 points, air-quality comfort by 0.54 points, pleasantness by 0.68 points, thermal comfort by 0.41 points, visual comfort by 0.44 points, being away by 0.85 points, fascination by 0.59 points and scope by 0.63 points. Reversed calm was 0.42 points higher. A 0.1 s longer fixation went with visual comfort 1.96 points higher. Longer blinks line up with the warmer wrist, toward lower comfort, whereas a larger pupil and a longer fixation line up with higher visual comfort. Eye-movement timing and pupil size are separate concordance patterns. There is no ten-second version of this test, because the vote is taken once, at the end of the phase.

## 4.3 H3 — Cycling versus walking

Walking and cycling differed in eye movements, and the size of the difference depended on the corridor. During green walking, compared with green cycling, blinks were 0.0110 s longer and gaze was 52.8 px farther from the centre of the scene. Gaze centrality was 0.0928 lower. Fixation duration on the green corridor differed only in the ten-second model, where it was 0.43 standard deviations shorter while walking. During impervious walking, compared with impervious cycling, blinks were 0.0151 s longer, fixations were 0.0343 s shorter, gaze dispersion was 0.0189 higher, gaze velocity was 609 px s⁻¹ higher, and the pupil was 0.465 mm smaller. Eyelid aperture on the impervious corridor differed only in the ten-second model, where it was 0.92 standard deviations larger while walking.

Estimated wrist temperature was 0.91 °C higher during impervious walking than impervious cycling, and 0.88 °C higher during green walking than green cycling. Neither contrast passed correction. On the green corridor, pleasantness was 1.09 points lower, fascination 0.79 points lower and being away 0.97 points lower while walking. Heart rate, heart-rate variability and tonic electrodermal activity were the same for both modes. The two modes differ in speed and in how much of the carriageway has to be watched (Rupi & Krizek, 2019).

## 4.4 H4 — Noise and thermal discomfort

Adapted models from Kraus et al. (2013), Biel et al. (2020), Jin et al. (2020), Moshammer et al. (2019), Korpilo et al. (2024) and Rodrigues et al. (2026) were fitted to the calibrated A-weighted level. A-weighted level did not amplify thermal discomfort. In the Jin model the heat-by-sound term was absent for thermal comfort and for overall comfort. Our eight-minute bouts provide shorter observation periods than the 24–48-hour personal-noise studies (Kraus et al., 2013), limiting direct comparison across exposure durations. Each model here uses 11 participants and four bouts, 44 observations. A noise-only slope for the RR interval, 3.373 ms per dB(A), did not remain once air temperature was included. The A-weighted association that did remain was the Rodrigues specification: minimum wrist temperature was 0.874 °C higher per 1 standard deviation of the trip-maximum sound level. A higher peak level went with a warmer minimum at the wrist.

Frequency-domain heart-rate variability in these tests uses the phase and the non-overlapping 5-minute block. Short-term spectral estimates need a window of about 2–5 minutes (Task Force of the European Society of Cardiology and the North American Society of Pacing and Electrophysiology, 1996). A shorter slice of the same bout does not supply an independent sample.

Sound type and frequency content showed sound effects on heart rate and heart-rate variability (Figure 13). A nature-sound share and a vehicle share are different exposures even when the A-weighted level is similar. The signs do not form one pattern.

![Sound composition](../Figures/Figure4_sound_composition.svg)

Figure 13. Sound composition along the routes.

On the walking phases, a 10 percentage-point higher nature-sound proportion went with RMSSD 11.8 ms higher and high-frequency power 2661.5 higher. Those figures are one tenth of the per-unit slopes, 118 ms and 26615. Both are larger beat-to-beat and high-frequency variation. The nature-sound term in the Jin model of thermal comfort did not remain after correction.

A 10 percentage-point higher pleasant man-made proportion went with an RR interval 48.6 ms shorter, one tenth of the per-unit slope of 486 ms. A shorter interval is a faster rhythm in that window. The coefficient does not identify the source as stress or as effort.

A larger share of energy from 2 to 20 kHz went with a higher heart rate: 2.30 bpm per interquartile range of that share in the Biel model, and 6.96% per 1 standard deviation above the median knot in the Kraus model. The increments differ, so the two numbers are not interchangeable. Both associate more high-frequency energy with a faster heart rate.

The vehicle-proportion term that remains in the Jin model is the UTCI heat-category effect on thermal comfort. The comfort difference sits with the heat category.

For urban exposure, an A-weighted level alone did not recover the combined heat-and-noise associations reported for longer panels and for outdoor squares (Jin et al., 2020; Kraus et al., 2013). The associations that did appear split by what the sound contained. A route assessment that records only loudness treats a nature-sound share and a high-frequency share as the same exposure. Here they lined up with different cardiac measures.

## 4.5 Analysis — Combined exposure

The seven additive models are a complementary analysis of adjusted exposure associations, separate from H1–H4. In the phase-mean models, higher UTCI or air temperature went with higher heart-rate variability, and gaze velocity was 320.6 px s⁻¹ higher per °C of air temperature. In the ten-second models, the slopes that remained were mostly a smaller pupil, and a slower change in pupil diameter, when sky view or solar radiation was higher. Direct solar irradiance and sky view were left out of the mean-radiant-temperature specification because that temperature already represents radiation. The phase-mean fit of that specification has a maximum variance inflation factor of 80.24, on green view. Severe collinearity limits attribution of its associations to individual predictors. The ten-second fit of the same specification has a maximum of 1.14.

## 4.6 Limitations

The sample is 11 adults in one city over one summer (3 July to 27 August 2025). Environment type and travel mode are confounded with location, illuminance, metabolic rate, and co-exposures. Wrist temperature and electrodermal activity are sensitive to contact and motion. Because environmental characteristics co-varied across routes, the observed associations cannot isolate the causal contribution of green infrastructure.

# 5 Conclusion

Green routes had a cooler wrist, larger pupils and higher thermal comfort. Walking and cycling differed in eye movements, and on the green route in pleasantness, fascination and being away. Wrist temperature was higher while walking on both corridors, and neither contrast passed correction. End-of-phase ratings tracked blinks, pupil diameter and skin temperature in 21 of 468 pairs. A-weighted sound did not amplify thermal discomfort. Sound type and frequency content were associated with heart rate and heart-rate variability.

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

# 6 References

Bakdash, J. Z., & Marusich, L. R. (2017). Repeated measures correlation. Frontiers in Psychology, 8, 456. https://doi.org/10.3389/fpsyg.2017.00456

Benjamini, Y., & Hochberg, Y. (1995). Controlling the false discovery rate: A practical and powerful approach to multiple testing. Journal of the Royal Statistical Society: Series B (Methodological), 57(1), 289–300.

Bent, B., Goldstein, B. A., Kibbe, W. A., & Dunn, J. P. (2020). Investigating sources of inaccuracy in wearable optical heart rate sensors. npj Digital Medicine, 3, 18. https://doi.org/10.1038/s41746-020-0226-6

Biel, R., Danieli, C., Shekarrizfard, M., Minet, L., Abrahamowicz, M., Baumgartner, J., Liu, R., Hatzopoulou, M., & Weichenthal, S. (2020). Acute cardiovascular health effects in a panel study of personal exposure to traffic-related air pollutants and noise in Toronto, Canada. Scientific Reports, 10, 16703. https://doi.org/10.1038/s41598-020-73412-6

Boucsein, W., et al. (2012). Publication recommendations for electrodermal measurements. Psychophysiology, 49(8), 1017–1034. https://doi.org/10.1111/j.1469-8986.2012.01384.x

Chen, L.-C., Zhu, Y., Papandreou, G., Schroff, F., & Adam, H. (2018). Encoder-decoder with atrous separable convolution for semantic image segmentation. In Proceedings of the European Conference on Computer Vision (pp. 833–851).

Chinazzo, G., Wienold, J., & Andersen, M. (2019). Daylight affects human thermal perception. Scientific Reports, 9, 13690. https://doi.org/10.1038/s41598-019-48963-y

Cnaan, A., Laird, N. M., & Slasor, P. (1997). Using the general linear mixed model to analyse unbalanced repeated measures and longitudinal data. Statistics in Medicine, 16(20), 2349–2380.

Cooper, J., & Evans, T. (2015). Microphone wind speed limits during wind farm noise measurements. Proceedings of the Australian Acoustical Society Conference, Hunter Valley.

Di, G., Li, Z., Zhang, B., & Shi, Y. (2018). Adjustment on subjective annoyance of low frequency noise by adding additional sound. International Journal of Environmental Research and Public Health, 15(3), 474. https://doi.org/10.3390/ijerph15030474

Duffie, J. A., & Beckman, W. A. (2013). Solar engineering of thermal processes (4th ed.). Wiley.

Empatica. (2024). Empatica Health Monitoring Platform: Data access (PRS-0000205, Rev. 17.0). Empatica Inc.

Enders, C. K., & Tofighi, D. (2007). Centering predictor variables in cross-sectional multilevel models: A new look at an old issue. Psychological Methods, 12(2), 121–138. https://doi.org/10.1037/1082-989X.12.2.121

Evans, K. M., Jacobs, R. A., Tarduno, J. A., & Pelz, J. B. (2012). Collecting and analyzing eye-tracking data in outdoor environments. Journal of Eye Movement Research, 5(2), Article 6.

Fahy, J. C., Bachofen, C., Camponovo, R., Gallinelli, P., & Schlaepfer, M. A. (2025). Beyond land surface temperature: Identifying areas of daytime thermal discomfort in cities by combining remote sensing and field measurements. Urban Climate, 61, 102460. https://doi.org/10.1016/j.uclim.2025.102460

Federal Highway Administration. (n.d.). Highway traffic noise. https://www.fhwa.dot.gov/environment/noise/

Fox, J., & Monette, G. (1992). Generalized collinearity diagnostics. Journal of the American Statistical Association, 87(417), 178–183. https://doi.org/10.1080/01621459.1992.10475190

Gemmeke, J. F., Ellis, D. P. W., Freedman, D., Jansen, A., Lawrence, W., Moore, R. C., Plakal, M., & Ritter, M. (2017). Audio Set: An ontology and human-labeled dataset for audio events. Proceedings of the IEEE International Conference on Acoustics, Speech and Signal Processing, 776–780. https://doi.org/10.1109/ICASSP.2017.7952261

Gong, F.-Y., et al. (2018). Mapping sky, tree, and building view factors of street canyons. Building and Environment, 134, 155–167. https://doi.org/10.1016/j.buildenv.2018.02.042

Grapas, C., Llaguno-Munitxa, M., Pisello, A. L., & Irajpour, A. (2026). Urban chronotypes as climate vulnerability indicators: Safety-modulated bioclimatic responses and adaptive behavior across diurnal urban contexts. Urban Climate, 67, 102906. https://doi.org/10.1016/j.uclim.2026.102906

Hamra, G. B., & Buckley, J. P. (2018). Environmental exposure mixtures: Questions and methods to address them. Current Epidemiology Reports, 5(2), 160–165. https://doi.org/10.1007/s40471-018-0145-0

Holmer, B. (1992). A simple operative method for determination of sky view factors in complex urban canyons from fisheye photographs. Meteorologische Zeitschrift, 1, 236–239.

Hershey, S., Chaudhuri, S., Ellis, D. P. W., Gemmeke, J. F., Jansen, A., Moore, R. C., Plakal, M., Platt, D., Saurous, R. A., Seybold, B., Slaney, M., Weiss, R. J., & Wilson, K. (2017). CNN architectures for large-scale audio classification. Proceedings of the IEEE International Conference on Acoustics, Speech and Signal Processing, 131–135. https://doi.org/10.1109/ICASSP.2017.7952132

International Organization for Standardization. (2017). ISO 1996-2:2017. Acoustics — Description, measurement and assessment of environmental noise — Part 2: Determination of sound pressure levels.

James, G., Witten, D., Hastie, T., & Tibshirani, R. (2013). An introduction to statistical learning: With applications in R. Springer.

Jin, Y., Jin, H., & Kang, J. (2020). Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares. Building and Environment, 168, 106517. https://doi.org/10.1016/j.buildenv.2019.106517

Korkmaz, D., Knauth, K., Brands, A., Schmeck, M., Büning, P., & Peters, J. (2025). Ambulatory physiological measures obtained under naturalistic urban mobility conditions have acceptable reliability. Scientific Reports, 15, 28940. https://doi.org/10.1038/s41598-025-13216-8

Korpilo, S., Nyberg, E., Vierikko, K., Ojala, A., Kaseva, J., Lehtimäki, J., Kopperoinen, L., Cerwén, G., Hedblom, M., Castellazzi, E., & Raymond, C. M. (2024). Landscape and soundscape quality promote stress recovery in nearby urban nature: A multisensory field experiment. Urban Forestry & Urban Greening, 95, 128286. https://doi.org/10.1016/j.ufug.2024.128286

Kraus, U., Schneider, A., Breitner, S., Hampel, R., Rückerl, R., Pitz, M., Geruschkat, U., Belcredi, P., Radon, K., & Peters, A. (2013). Individual daytime noise exposure during routine activities and heart rate variability in adults: A repeated measures study. Environmental Health Perspectives, 121(5), 607–612. https://doi.org/10.1289/ehp.1205606

Lenth, R. V. (2023). emmeans: Estimated marginal means, aka least-squares means (R package). https://CRAN.R-project.org/package=emmeans

Lin, Y., Jin, Y., & Jin, H. (2022). Effects of different exercise types on outdoor thermal comfort in a severe cold city. Journal of Thermal Biology, 109, 103330. https://doi.org/10.1016/j.jtherbio.2022.103330

Mahanama, B., et al. (2021). Eye movement and pupil measures: A review. Frontiers in Computer Science, 3, 733531. https://doi.org/10.3389/fcomp.2021.733531

Mansi, S. A., Pigliautile, I., Arnesano, M., & Pisello, A. L. (2022). A novel methodology for human thermal comfort decoding via physiological signals measurement and analysis. Building and Environment, 222, 109385. https://doi.org/10.1016/j.buildenv.2022.109385

Marquardt, D. W. (1970). Generalized inverses, ridge regression, biased linear estimation, and nonlinear estimation. Technometrics, 12(3), 591–612.

Marteau, T. M., & Bekker, H. (1992). The development of a six-item short-form of the state scale of the Spielberger State-Trait Anxiety Inventory (STAI). British Journal of Clinical Psychology, 31(3), 301–306. https://doi.org/10.1111/j.2044-8260.1992.tb00997.x

Moshammer, H., Panholzer, J., Ulbing, L., Udvarhelyi, E., Ebenbauer, B., & Peter, S. (2019). Acute effects of air pollution and noise from road traffic in a panel of young healthy adults. International Journal of Environmental Research and Public Health, 16(5), 788. https://doi.org/10.3390/ijerph16050788

Nikolopoulou, M., Baker, N., & Steemers, K. (2001). Thermal comfort in outdoor urban spaces: Understanding the human parameter. Solar Energy, 70(3), 227–235. https://doi.org/10.1016/S0038-092X(00)00093-1

Pandya, P., Huang, Y.-S., Ritter, C., Bou-Zeid, E. R., Manoli, G., & Llaguno-Munitxa, M. (2026). Environmental comfort and urban biking: Linking ridership to micrometeorological indicators and location characteristics. Sustainable Cities and Society, 151, 108048. https://doi.org/10.1016/j.scs.2026.108048

Pasini, M., Berto, R., Brondino, M., Hall, R., & Ortner, C. (2014). How to measure the restorative quality of environments: The PRS-11. Procedia - Social and Behavioral Sciences, 159, 293–297. https://doi.org/10.1016/j.sbspro.2014.12.375

Pinheiro, J. C., & Bates, D. M. (2000). Mixed-effects models in S and S-PLUS. Springer.

Quigley, K. S., et al. (2024). Publication guidelines for human heart rate and heart rate variability studies in psychophysiology—Part 1. Psychophysiology, 61, e14604. https://doi.org/10.1111/psyp.14604

Rodrigues, A. L., da Conceição, M. S. A., Ramusga, R. A. L., Lima Azevedo, C., & Morgado, P. (2026). The influence of urban context on emotions and bodily responses during walking. Journal of Urban Health, 103, 344–356. https://doi.org/10.1007/s11524-025-01051-1

Rupi, F., & Krizek, K. J. (2019). Visual eye gaze while cycling: Analyzing eye tracking at signalized intersections in urban conditions. Sustainability, 11(21), 6089. https://doi.org/10.3390/su11216089

Song, C., Joung, D., Ikei, H., Igarashi, M., Aga, M., Park, B.-J., Miwa, M., Takagaki, M., & Miyazaki, Y. (2013). Physiological and psychological effects of walking on young males in urban parks in winter. Journal of Physiological Anthropology, 32, 18. http://www.jphysiolanthropol.com/content/32/1/18

Song, C., Ikei, H., Igarashi, M., Miwa, M., Takagaki, M., & Miyazaki, Y. (2014). Physiological and psychological responses of young males during spring-time walks in urban parks. Journal of Physiological Anthropology, 33, 8. http://www.jphysiolanthropol.com/content/33/1/8

Stuyck, H., Dalla Costa, L., Cleeremans, A., & Van den Bussche, E. (2022). Validity of the Empatica E4 wristband to estimate resting-state heart rate variability in a lab-based context. International Journal of Psychophysiology, 182, 105–118. https://doi.org/10.1016/j.ijpsycho.2022.10.003

Task Force of the European Society of Cardiology and the North American Society of Pacing and Electrophysiology. (1996). Heart rate variability: Standards of measurement, physiological interpretation and clinical use. Circulation, 93(5), 1043–1065. https://doi.org/10.1161/01.CIR.93.5.1043

Welch, P. D. (1967). The use of fast Fourier transform for the estimation of power spectra: A method based on time averaging over short, modified periodograms. IEEE Transactions on Audio and Electroacoustics, 15(2), 70–73. https://doi.org/10.1109/TAU.1967.1161901

Zheng, H., Luo, M., Wang, Y., & Wei, Y. (2024). Multi-sensory interaction and spatial perception in urban microgreen spaces: A focus on vision, auditory, and olfaction. Sustainability, 16, 8809. https://doi.org/10.3390/su16208809

Zhou, B., Zhao, H., Puig, X., Fidler, S., Barriuso, A., & Torralba, A. (2017). Scene parsing through ADE20K dataset. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (pp. 633–641).

Zuo, J., Xia, H., Liu, S., & Qiao, Y. (2016). Mapping urban environmental noise using smartphones. Sensors, 16(10), 1692. https://doi.org/10.3390/s16101692

# Appendix

The two tables below are the approved protocol forms (Annex 3). The scores entered in the models use the administered wording and anchors in §2.2.5.

Table A.1. Participant background questionnaire from the approved ethics form (Annex 3, Table 1: identity, demographics, residence, physical characteristics, familiarity, living environment, household, mobility and physical activity).

| Category | Questions | Response type |
| --- | --- | --- |
| Identity | 1. What is your name? | Text field |
| Demographics | 2. What is your age? | Text field |
| Demographics | 3. What is your gender? | Multiple choice: Male/ Female/ Prefer not to say |
| Demographics | 4. What is your nationality or country of origin? | Text field |
| Residence | 5. Where do you live in Brussels? | Text field |
| Residence | 6. How long have you been living in Brussels? | Text field |
| Physical characteristics | 7. What is your laterality? (Are you left or right-handed?) | Binary choice: Left / Right |
| Physical characteristics | 8. What is your current body weight? In Kg. | Text field |
| Physical characteristics | 9. What is your height? In cm. | Text field |
| Physical characteristics | 10. What are you currently wearing? Please describe your outfit as precisely as possible including the color (e.g., short-sleeved shirt, jeans, sandals, light jacket, etc.). | Text field |
| Physical characteristics | 11. What do you normally use for vision correction? | Multiple choice: Normal vision/ Wear glasses/ Wear contact lens / Uncorrected vision impairment/ Prefer not to say |
| Familiarity | 12. How well do you know the streets and surroundings where the experiment is in Brussels? | Linear scale 1–10: Not at all familiar (1) / Extremely familiar (10) |
| Living environment | 13. What is your type of residence? | Binary choice: City / Suburban environment |
| Household | 14. Do you have children? | Multiple choice: Yes / No |
| Mobility | 15. How do you commute to work? | Multiple choice: Walk/ Bike/ Train/ Metro/ Tram |
| Physical activity | 16. Is there any sport or physical activity you practice regularly? Name it. Else write no. | Text field |
| Physical activity | 17. How frequently do you bike? | Multiple choice: Daily/ Few times per week/ Few times per month/ Rarely/ Never |
| Physical activity | 18. On average how much do you walk every day? | Multiple choice: <15 min/ 15 to 30 min/ 30 min to 1 hour/ 1 to 2 hours/ > 2 hours |

Table A.2. Experimental-campaign questionnaire from the approved ethics form (Annex 3, Table 2: comfort sensation, thermal sensation, environmental stressor, STAI items, PRS items and place pleasantness). The administered thermal, acoustic, visual, air-quality and odour items use the five anchors in §2.2.5, and the state-anxiety anchors differ from this approved list.

| Item | Question | Response format | Source framework |
| --- | --- | --- | --- |
| 1 | How comfortable do you feel right now? | Very uncomfortable / Uncomfortable / Slightly uncomfortable / Neutral / Slightly comfortable / Comfortable / Very comfortable | Comfort Sensation Vote |
| 2 | Please describe your thermal sensation | Cold / Cool / Slightly cool / Neutral / Slightly warm / Warm / Hot | Thermal Sensation Vote |
| 3 | Which environmental factor is most affecting you right now? | □ Temperature □ Lighting □ Noise □ Air Quality □ Crowding | Environmental Stressor |
| 4 | I feel calm | Not at all / A little / Moderately / Quite a lot / Extremely | STAI |
| 5 | I feel tense | Not at all / A little / Moderately / Quite a lot / Extremely | STAI |
| 6 | I feel upset | Not at all / A little / Moderately / Quite a lot / Extremely | STAI |
| 7 | I feel relaxed | Not at all / A little / Moderately / Quite a lot / Extremely | STAI |
| 8 | I feel content | Not at all / A little / Moderately / Quite a lot / Extremely | STAI |
| 9 | I feel worried | Not at all / A little / Moderately / Quite a lot / Extremely | STAI |
| 10 | Places like that are fascinating | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 11 | In places like this my attention is drawn to many interesting things | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 12 | In places like this it is hard to be bored | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 13 | Places like that are a refuge from nuisances | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 14 | To get away from things that usually demand my attention I like to go to places like this | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 15 | To stop thinking about the things that I must get done I like to go to places like this | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 16 | There is a clear order in the physical arrangement of places like this | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 17 | In places like this it is easy to see how things are organised | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 18 | In places like this everything seems to have its proper place | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 19 | That place is large enough to allow exploration in many directions | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 20 | In places like that there are few boundaries to limit my possibility for moving about | Not at all / A little / Moderately / Quite a lot / Extremely | PRS |
| 21 | How pleasant do you feel in this place? | Not at all / A little / Moderately / Quite a lot / Extremely | Greenness |

## Psychophysiological comfort during active urban mobility: Environment and activity modulated physiological and perceived responses across diverse urban contexts

### Abstract

Urban active travel exposes people simultaneously to thermal, acoustic, visual and physical demands, yet these exposures are rarely studied together under naturalistic conditions. This repeated-measures field study examined psychophysiological comfort across cycling and walking phases in impervious urban and green environments in Brussels. Eleven participants completed route phases while wearable physiological, mobile eye-tracking and environmental data were synchronized to 10-second epochs. Linear mixed models tested environment and mode, literature-based tests examined whether noise amplifies thermal stress, and an additive mixed model estimated all exposures together, with repeated measures accounted for and Benjamini-Hochberg correction applied within hypothesis families. Green phases were associated with **lower square-root-transformed tonic electrodermal activity**, lower skin temperature and larger pupil diameter. Walking versus cycling was associated with **tonic electrodermal activity, skin temperature, fixation rate** and gaze velocity. No heat-by-noise interaction survived false-discovery-rate correction in any literature-based test. **Phase-level physiological-perceptual correlations did not survive false-discovery-rate correction**. These findings indicate distinct physiological and visual-attention signatures across mobility contexts, while the small sample, model diagnostics and observational field exposures limit causal and population-level claims.

Keywords: active mobility; green infrastructure; thermal comfort; wearable sensing; mobile eye tracking; linear mixed models

## 1 Introduction

### 1.1 Background and research gap

Active mobility is increasingly promoted as part of low-carbon and healthy urban transport, but route choice also determines exposure to heat, noise, traffic and visual complexity. Outdoor comfort is adaptive and context-dependent rather than a direct function of meteorological conditions alone (Nikolopoulou et al., 2001).

Naturalistic mobility studies must consider environmental exposure and physical travel demands together. Physiological measures can complement self-report, but they are not direct or unique readouts of comfort: electrodermal activity reflects sympathetic arousal, skin temperature is influenced by thermoregulation and movement, and wrist-derived heart-rate variability requires careful measurement and interpretation (Boucsein et al., 2012; Quigley et al., 2024; Stuyck et al., 2022).

Existing field studies commonly examine walking or cycling separately. Mobile eye tracking is feasible outdoors but remains sensitive to illumination, motion, calibration and scene complexity (Evans et al., 2012; Mahanama et al., 2021). Cycling studies further show that gaze allocation changes with task and road context (Rupi & Krizek, 2019).

Wearable physiological sensing can support thermal-comfort research, but much of the evidence comes from controlled or indoor exposures (Mansi et al., 2022). Cross-domain effects are plausible: daylight can alter thermal perception even under controlled thermal conditions (Chinazzo et al., 2019), illustrating why field responses should not be assigned to a single exposure in isolation.

A central evidence gap is the within-person comparison of walking and cycling across contrasting urban and green route phases while environmental, physiological, eye-tracking and perceived responses are measured together.

This study addresses that gap using repeated phase blocks in one field protocol. The design supports within-participant association estimates across the observed routes; it does not establish that greenery, mode or individual stressors independently caused the responses.

The contribution is the integrated comparison of environment and mobility mode, separation of primary and sensitivity analyses, and joint examination of thermal and acoustic exposure in a naturalistic active-mobility setting.

The study asks whether response profiles differ between green and impervious urban phases, between walking and cycling, whether physiological and perceived responses covary, and whether the thermal association changes with concurrent noise.

The results can inform hypotheses and measurement priorities for larger urban-mobility studies and, cautiously, route designs intended to reduce combined environmental burden.

### 1.2 Hypotheses

We hypothesise that:

1. **H1** — Participants show better physiological **and perceived comfort** in green than in impervious areas.
2. **H2** — Physiological and perceived responses are concordant.
3. **H3** — Psychophysiological comfort is more compromised during cycling than during walking.
4. **H4** — Noise and traffic-related sound amplify thermal discomfort.
5. **H5** — Within-person physiological responses change with shared places along the route and with local thermal stress.
6. **H6** — Within-person coupling of environmental load, autonomic/ocular markers, and selected questionnaire constructs co-varies across matched mobility phases (prespecified LMMs; exploratory).
7. **Analysis** — Additive combined-exposure models describe adjusted associations when thermal, acoustic, radiative, pollution, and route-context terms co-occur. This block is not a hypothesis test.

## 2 Methods

Urban-comfort and mobile-exposure papers typically combine design, measurements and analysis in one flow rather than separate “instruments” and “procedure” sections. Measurements are described where they support the analysis grain (here: matched route phases and 10-second epochs). The subsections below follow that convention.

### 2.1 Study design

A repeated-measures field campaign was conducted in Brussels, Belgium, from **3 July to 27 August 2025**. Each participant completed four core outdoor mobility phases—cycling and walking in impervious urban corridors and in green-park corridors—plus a seated tram phase (descriptive only). Phase labels were BikeU, WalkU, WalkG, **WalkG** and Tram; tram was excluded from the primary 2 × 2 environment-by-mode contrasts.

Participants followed **counterbalanced** routes with questionnaires before and after each block; wearables and the trailing-researcher uCM backpack were checked at breaks. All streams were time-aligned to **UTC**. The design targets within-person comparisons of environment and mode under naturalistic active mobility; route location, workload, illumination and co-exposures co-vary with phase, so inferential models estimate associations, not single-stressor causation.

**Figure: Experiment timeline**

**Figure: Experiment trajectory**

**Figure: Sensors used in the experiment**

#### 2.1.1 Participants

Eighteen volunteers were tested (30 planned under ethics). Eleven with complete multi-sensor coverage on the four core phases were analysed (P4, P8–P17). Prespecified inclusion criteria were age 18–40 years, Brussels residence, ability to walk and cycle the study routes, and vision compatible with mobile eye tracking. Ethics application signed 28 May 2025 (approval reference from approved PDF). With n = 11 and four repeated phase cells, post hoc sensitivity (GPower, α = 0.05, power = 0.80, r = 0.50) suggested minimum detectable f ≈ 0.52 (partial η² ≈ 0.11).

The analysed sample comprises eleven participants (three women, eight men) aged 24–58 years (mean 35.2 years, SD 9.5). Nine fall within the prespecified 18–40 year band; two report ages above 40 years (50 and 58 years). Self-reported height and weight yield BMI 20.5–33.0 kg·m⁻² (mean 23.8 kg·m⁻², SD 3.8): eight meet WHO normal weight (18.5–24.9 kg·m⁻²), two are overweight, and one has obesity. Project case-study labels classify eight as Fit and three as Not Fit and six as Active and five as Inactive (BMI- and daily-walking–based rules applied to the same eleven IDs). Clothing-questionnaire skin tone (Very fair, Fair, Medium, Olive, Brown) is mapped to Fitzpatrick types I–V by ascending shade (I, n = 1; II, n = 6; III, n = 2; IV, n = 1; V, n = 1; no type VI), covering the range where wrist photoplethysmography and optical heart rate on Empatica wearables may perform unevenly across pigmentation (Bent et al., 2020). Seven participants normally wear glasses; four report no vision correction.

Archived mixed models that enter those Fit/Not Fit and Active/Inactive labels as person-level factors are sensitivity analyses only; none of their coefficients survive Benjamini–Hochberg FDR control in the primary hypothesis families reported here.

### 2.2 Data preparation

Micrometeorology and context (uCM, 10 s): air temperature, humidity, mean radiant temperature, global horizontal irradiance, wind, A-weighted sound (dBA), GPS, UTCI and PET. Air quality and light: PM (Atmotube means), lux and colour temperature (LYS means). Scene openness (CamUp / Mapillary pipelines): Holmer annular sky view factor (SVF) for inferential models; tree view factor (TVF) and building view factor (BVF) computed alongside SVF but not co-entered with SVF or GVI in the combined-exposure model (Gong et al., 2018). Greenery: eye-level GVI (`gvi_50m`). Physiology (Empatica): EDA tonic/phasic, heart rate, HRV, wrist temperature. Vision (eye tracker): pupil, blink, fixation and gaze kinematics; proprietary `eyetracker_stress_composite` retained in the merge for exploration only (§9). Perception: end-of-phase comfort and environmental-comfort items, STAI-6 item scores, PRS-11 subscale means (18 questionnaire columns in H2/H1–H3 exports).

Streams were synchronized, path-matched and quality-checked, aggregated to 10-second epochs, then—for the phase-mean analyses (H1–H3, H6 and the phase-mean combined-exposure model)—collapsed to participant × phase means on matched **eight-minute segments** (44 cells). Clearness index (k_t) was computed for solar QC; measured irradiance (`ucm_SUN_Gh`) entered models, not derived k_t. Transformations followed the locked normalization CSV.

Sound exposure (two streams): Primary loudness is the uCM calibrated A-weighted level `ucm_SND_dBA` (10 s medians on the backpack stream). Supplementary descriptors from phase WAVs include YAMNet source-type proportions/scores, Welch band energy shares, octave summaries, and spectral centroids (`Sound spectrum in field experiment.md`). These are not interchangeable with calibrated dBA; low-frequency band fractions can correlate with classifier “wind” labels and with apparent wind on the body during cycling—interpret as type/frequency structure, not as a second loudness standard.

Wind and microphones: Outdoor noise guidance (FHWA field measurement practice; ISO 1996-2:2017 measurement context; mobile mapping: Zuo et al., 2016) treats high wind as a measurement-condition issue even with windscreens. A 5 m/s apparent-wind exclusion on `ucm_WIND_AWS` was implemented as an optional sensitivity for supplementary sound models only (not a decibel correction). Literature (Cooper & Evans, 2015) cautions that a 5 m/s cutoff alone does not guarantee absence of wind-on-microphone artefacts. Windscreen type and microphone placement on the uCM should be stated from field notes in the final manuscript.

### 2.3 Statistical analysis

Primary inference used REML linear mixed models (Pinheiro & Bates, 2000) on participant × phase means to target within-person contrasts and limit pseudo-replication from epoch-level counts (Cnaan et al., 1997; Enders & Tofighi, 2007), with planned contrasts from estimated marginal means (Lenth, 2023) and questionnaire–physiology coupling via repeated-measures correlation (Bakdash & Marusich, 2017). Benjamini–Hochberg FDR (α = 0.05; Benjamini & Hochberg, 1995) was applied within prespecified hypothesis families. Unbalanced repeated-measures field designs follow ambulatory precedent (Rodrigues et al., 2026; Korkmaz et al., 2025).

1. **H1**:
   - Citation: Pinheiro & Bates (2000); Cnaan et al. (1997); Enders & Tofighi (2007); Lenth (2023); Benjamini & Hochberg (1995); Rodrigues et al. (2026); Korkmaz et al. (2025).
   - Model: Phase-mean REML LMM: `Y ~ PhaseID + (1 | ParticipantID)`; emmeans contrasts; BH FDR within 26 outcomes × contrast family. Sensitivity: within-person z-scored phase means; optional 10 s / 60 s AR(1) (`H1_H3_timeseries.R`).
   - Description & sub-parts: **H1.1** BikeG − BikeU (green vs impervious, cycling). **H1.2** WalkG − WalkU (green vs impervious, walking). Primary grain: participant × phase means on matched 8 min segments (44 cells); 26 physiological and ocular outcomes. Script: `H1_H3_phaseavg.R`; exports `H1_H3_Contrasts.csv`, `H1_H3_Temporal_AR1.csv`.
2. **H2**:
   - Citation: Bakdash & Marusich (2017); Benjamini & Hochberg (1995).
   - Model: rmcorr; one BH family over **468** prespecified pairs (18 end-of-phase questionnaire items × 26 phase-mean physiological outcomes; no scale roll-ups).
   - Description & sub-parts: Phase-mean concordance between comfort, environmental comfort, STAI-6 items, PRS-11 subscales and the same 26 outcomes used in H1. Fitted jointly with H1 in `H1_H3_phaseavg.R`; export `H2_Concordance.csv`.
3. **H3**:
   - Citation: Pinheiro & Bates (2000); Cnaan et al. (1997); Enders & Tofighi (2007); Lenth (2023); Benjamini & Hochberg (1995).
   - Model: Same phase-mean LMM shell as H1; emmeans; BH FDR within 26 outcomes × contrast family.
   - Description & sub-parts: **H3.1** WalkU − BikeU (mode contrast, impervious urban). **H3.2** WalkG − BikeG (mode contrast, green). **Descriptive (not confirmatory):** difference-of-differences (BikeG − BikeU) − (WalkG − WalkU). Exports: `H1_H3_Contrasts.csv` (Hypothesis = H3); sensitivities as H1.
4. **H4**:
   - Citation: Moshammer et al. (2019); Song et al. (2013, 2014); Jin, Jin and Kang (2020); Rodrigues et al. (2026); Benjamini & Hochberg (1995); Mansi et al. (2022); Chinazzo et al. (2019).
   - Model: Literature-adapted tests from the four included sources on field data; screening list below with [Included] / [Excluded] per paper. Script: `H4_sound_literature_test.R`. BH FDR within each included paper’s own test × outcome family (not one family across papers).
   - Description & sub-parts: Four papers included. Thirty-five excluded because outdoor, sound, thermal, or the outcome is missing.
5. **H5**:
   - Citation: Nikolopoulou et al. (2001); Fahy et al. (2025); Korkmaz et al. (2025); Gong et al. (2018); Pinheiro & Bates (2000); Benjamini & Hochberg (1995).
   - Model: Exploratory REML LMMs; separate FDR families from H1–H4. Hotspot design: fixed-route buffer cells (walk 11 m, bike 35 m; §8.0). Script: `H5_hotspot_weather.R`.
   - Description & sub-parts: **H5.1 (hotspot thermal):** 10 s epochs → participant × hotspot × day medians; `median_center_Y ~ env_ucm_UTCI_c + hotspot_f + (1 | ParticipantID)` per PhaseID × outcome. **H5.2 (view context):** same grain; centred outcome ~ UTCI + log10(lux + 1) + SVF, TVF, BVF or Gong dominance class; random intercept + AR(1) along route position.
6. **H6**:
   - Citation: Mansi et al. (2022); Chinazzo et al. (2019); Pinheiro & Bates (2000); Benjamini & Hochberg (1995).
   - Model: Prespecified exploratory coupling LMMs (`library/H6_coupling_core.R`); separate BH families **H6_A_env_physio** and **H6_B_psych_physio_given_env**. Not in H1–H4 or combined-exposure model.
   - Description & sub-parts: **H6-A:** Three env→physio models per outcome (9 tests): `out_{physio} ~ idx_{index} + PhaseID + (1 | ParticipantID)`, one index at a time. Indices are stress-oriented within-person *z* (WPZ): **thermal load** (`idx_thermal_load` ← `ucm_UTCI`); **acoustic load** (`idx_acoustic_load` ← `ucm_SND_dBA`); **restorative stress** (`idx_restorative_stress` ← equal-weight WPZ of inverted sky view, tree view, and 50 m GVI: `SVF`, `TVF`, `gvi_50m`). Outcomes: CSV-transformed tonic EDA and RMSSD plus equal-weight transparent ocular index (fixation rate, fixation duration, pupil diameter, blink duration). **H6-B:** Nine psych→physio models (env-adjusted): `out_{physio} ~ psy_{scale} + idx_thermal_load + idx_acoustic_load + PhaseID + (1 | ParticipantID)`, where `psy_{scale}` is WPZ of **PRS-11 fascination** (`questionnaire_prs11_fascination_mean_1_5`), **STAI tense** (`questionnaire_stai_tense_1_5`), or **acoustic comfort** (`questionnaire_acoustic_comfort_1_5`). **Grain:** phase means — `H6_stress_composite_phaseavg.R` (44 cells); 10 s — `H6_stress_composite_timeseries.R` (+ AR(1)).
7. **Analysis** (combined exposure model):
   - Citation: Mansi et al. (2022); Chinazzo et al. (2019); Rodrigues et al. (2026); Hamra & Buckley (2018); Marquardt (1970); James et al. (2013); Fox & Monette (1992); Pinheiro & Bates (2000); Benjamini & Hochberg (1995).
   - Model: Additive REML LMMs (main effects only); **not a hypothesis test**. Collinearity: VIF = 1/(1 − R²); Fox–Monette block VIF for PhaseSum route block. Screen max VIF < 10 on heart-rate complete cases per fitted grain (`Analysis_combined_gvif_summary_both_grains.csv`); drop predictors only where that grain fails screening.
   - Description & sub-parts: **Analysis — timeseries (10 s):** `Analysis_combined_timeseries.R`; one additive LMM per outcome × **Eq1–7**; BH *q* per fixed term within equation × 26 outcomes; includes `ucm_SUN_Gh` and `gvi_50m` where listed; Eq3 primary at this grain (phase Eq3 excluded at max VIF 22.48). **Analysis — phaseavg (phase means):** `Analysis_combined_phaseavg.R`; same Eq1–7 structure on participant × phase means; omits SUN and GVI on all equations; Eq2 phase spec: `ucm_AIR_T_mid`, `ucm_AIR_RH`, `ucm_WIND_AWS` + **SVF** + PM2.5/lux/kelvin + PhaseSum (**no SND**; max VIF 9.29 vs 10 s Eq2 1.61). Shared non-thermal core: sound (10 s only), SVF, PM, lux/kelvin, PhaseSumWalkG/U/BikeG; thermal term rotates (UTCI, air T/RH/wind, MRT, HUMIDEX, PET; Eq6–7 swap PM fraction).

**H4 papers screened.** One numbered entry per paper; under each citation, sub-bullets for Measured, Outdoor/Sound/Thermal/Outcome, and Reason, then [Included] or [Excluded] on the citation line. Four included, thirty-five excluded. A missing thermal term is enough to exclude, including Kraus et al. (2013).

1. Moshammer et al. (2019) [Included]:
   - Measured: ambulatory ECG on a road and in a park, personal Leq, air temperature, MET, and blood pressure.
   - Outdoor: present. Sound: present (Leq). Thermal: present (air temperature). Outcome: present (heart rate, HRV, and blood pressure).
   - Reason: Missing: blood pressure in this campaign. Heart rate, HRV, Leq, and air temperature are present, so those terms were tested.

2. Song et al. (2013, 2014) [Included]:
   - Measured: HRV on a park walk and a city-street walk.
   - Outdoor: present. Sound: missing (no dBA). Thermal: missing. Outcome: present (SDNN and RMSSD).
   - Reason: Missing: sound level and a thermal term. Kept only as a two-outcome sensitivity of the Moshammer walk contrast.

3. Jin, Jin and Kang (2020) [Included]:
   - Measured: sound level, UTCI, and thermal and environmental comfort in outdoor squares.
   - Outdoor: present. Sound: present (dBA). Thermal: present (UTCI). Outcome: present (those two comfort items).
   - Reason: Missing: none. Outdoor, dBA, UTCI, and the two comfort items are all present.

4. Rodrigues et al. (2026) [Included]:
   - Measured: trip noise, heat, HRV, EDA, skin temperature, and gaze while walking.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (physiology and gaze).
   - Reason: Missing: none. Outdoor, trip noise, heat, and physiology/gaze are all present.

5. Kraus et al. (2013) [Excluded]:
   - Measured: personal Leq and HRV, with a slope change at 65 dBA. Their model uses activity and time of day.
   - Outdoor: present (daily life). Sound: present (Leq). Thermal: missing. Outcome: present (heart rate and HRV).
   - Reason: Missing: thermal term. Air temperature was offered to the model and was not kept for any of the five outcomes, so the slope has no thermal term.

6. Mahecha Nuñez et al. (2018) [Excluded]:
   - Measured: a smartband stress event from skin conductance and skin temperature on cycle paths.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (their stress-event score).
   - Reason: Missing: that stress-event score. This campaign has the two signals, not their algorithm.

7. Teixeira et al. (2020) [Excluded]:
   - Measured: the same smartband stress event while cycling in five cities.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (their stress-event score).
   - Reason: Missing: that stress-event score. Same gap as Mahecha Nuñez et al. (2018).

8. Korpilo et al. (2024) [Excluded]:
   - Measured: NDSI from audio and normalized EDA.
   - Outdoor: present. Sound: present (NDSI, not dBA). Thermal: not in the paper. Outcome: present (normalized EDA).
   - Reason: Missing: thermal discomfort. They did not test sound under high thermal discomfort.

9. Burns et al. (2016) [Excluded]:
   - Measured: personal noise and heart rate.
   - Outdoor: present. Sound: present. Thermal: missing. Outcome: present (heart rate).
   - Reason: Missing: thermal term.

10. Tartarini et al. (2023) [Excluded]:
    - Measured: watch sound level and thermal-comfort micro-surveys.
    - Outdoor: present. Sound: present. Thermal: present as a survey. Outcome: missing (no heat–noise test).
    - Reason: Missing: a heat-by-noise test. Sound and comfort surveys are present, with no model that joins them.

11. Schaupp et al. (2025) [Excluded]:
    - Measured: dBA on forest and urban walks, cortisol, an attention test, and questionnaires.
    - Outdoor: present. Sound: present. Thermal: not in the model. Outcome: present (cortisol).
    - Reason: Missing: a thermal term, and cortisol was not collected here.

12. Jafari et al. (2021) [Excluded]:
    - Measured: salivary cortisol under a sound or heat contrast.
    - Outdoor: present. Sound: present in the sound arm. Thermal: present in the heat arm. Outcome: present (cortisol).
    - Reason: Missing: cortisol. It was not collected here.

13. Lan et al. (2024) [Excluded]:
    - Measured: physiology in a park versus an urban setting.
    - Outdoor: present. Sound: missing as a dose. Thermal: present as place climate. Outcome: present.
    - Reason: Missing: a sound-level term. Park versus urban is already the Moshammer walk contrast.

14. Zhang et al. (2026) [Excluded]:
    - Measured: aesthetic and environmental-quality ratings outdoors.
    - Outdoor: present. Sound: present as perception. Thermal: present as perception. Outcome: missing (those scales).
    - Reason: Missing: their aesthetic and environmental-quality items.

15. Lam et al. (2024) [Excluded]:
    - Measured: perceived environmental quality outdoors.
    - Outdoor: present. Sound: present as perception. Thermal: present as perception. Outcome: missing (those scales).
    - Reason: Missing: their perceived-environmental-quality items.

16. Tu et al. (2026) [Excluded]:
    - Measured: a multi-pathway mediation of outdoor exposures.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: present in kind.
    - Reason: Missing: enough cells for their mediation paths. Outdoor, sound, and thermal are present.

17. Li et al. (2026) [Excluded]:
    - Measured: EEG and an odor condition.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: present (EEG and odor).
    - Reason: Missing: EEG and the odor condition. Neither was recorded here.

18. Li, Li and Wang (2025) [Excluded]:
    - Measured: sound level, air temperature, and walking-comfort surveys on a greenway.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (those surveys; no wearable model).
    - Reason: Missing: a wearable outcome. Sound, air temperature, and comfort surveys are present; the comfort test already run is Jin.

19. Li et al. (2025) [Excluded]:
    - Measured: noise or heat with hypertension as the endpoint.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: present (hypertension).
    - Reason: Missing: blood pressure. It was not recorded here.

20. Chen (2007) [Excluded]:
    - Measured: hearing threshold under noise.
    - Outdoor: not a walked route. Sound: present (noise). Thermal: not in the paper. Outcome: present (hearing threshold).
    - Reason: Missing: a thermal term. Hearing threshold was not recorded here.

21. Bidel et al. (2022) [Excluded]:
    - Measured: EMG. This screening note does not have a walked route, a dBA term, or a thermal term for this paper.
    - Outdoor: not in the paper. Sound: not in the paper. Thermal: not in the paper. Outcome: present (EMG).
    - Reason: Missing: a thermal term. EMG is their outcome and was not recorded here.

22. He et al. (2025) [Excluded]:
    - Measured: responses near 90 dB.
    - Outdoor: not this walking exposure. Sound: present, at about 90 dB. Thermal: not in the paper. Outcome: present in the paper.
    - Reason: Missing: a thermal term. These routes do not reach 90 dB.

23. El Aarbaoui et al. (2017) [Excluded]:
    - Measured: personal Leq and SDNN, LF, HF, and LF/HF, adjusted for heart rate and activity.
    - Outdoor: present (daily life). Sound: present. Thermal: missing. Outcome: present (HRV).
    - Reason: Missing: thermal term.

24. El Aarbaoui and Chaix (2020) [Excluded]:
    - Measured: the same Leq–HRV link split by home and transport.
    - Outdoor: present. Sound: present. Thermal: missing. Outcome: present (HRV).
    - Reason: Missing: thermal term. Their contrast is also home versus transport, which these four phases are not.

25. Huang et al. (2013) [Excluded]:
    - Measured: sitting in traffic versus a park; noise as a modifier of the particle effect on HF.
    - Outdoor: present. Sound: present as a modifier. Thermal: missing. Outcome: present (HF).
    - Reason: Missing: thermal term. Noise only modifies the particle effect.

26. Biel et al. (2020) [Excluded]:
    - Measured: personal noise and SDNN, RMSSD, and HF, with air temperature.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: present (those three HRV terms).
    - Reason: Missing: none. The same noise slopes with air temperature are already inside the Moshammer family, which had no raw p < 0.05.

27. Buregeya, Apparicio and Gelb (2020) [Excluded]:
    - Measured: cycling change in heart rate and HRV versus a percent noise dose, in four riders.
    - Outdoor: present. Sound: missing as Leq (percent dose). Thermal: missing. Outcome: present (heart rate and HRV).
    - Reason: Missing: Leq (they use a percent noise dose) and a thermal term.

28. Schnell et al. (2015) [Excluded]:
    - Measured: body-worn noise, CO, and thermal load versus place discomfort.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (place-discomfort rating).
    - Reason: Missing: an HRV outcome. They model place discomfort.

29. Krüger et al. (2025) [Excluded]:
    - Measured: climate walks, skin temperature, and questionnaires, with noise noted near roads.
    - Outdoor: present. Sound: missing as a model term. Thermal: present. Outcome: present (skin temperature and questionnaires).
    - Reason: Missing: a sound term in the model. Noise is only described.

30. Cureau et al. (2022) [Excluded]:
    - Measured: sound level on park walks and comfort surveys.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (survey logistics; no wearable model).
    - Reason: Missing: a wearable outcome. Sound and thermal comfort surveys are present.

31. Franěk et al. (2018) [Excluded]:
    - Measured: walking speed under headphone traffic noise or birdsong.
    - Outdoor: present. Sound: present as headphone playback, not route Leq. Thermal: not in the paper. Outcome: present (walking speed).
    - Reason: Missing: a thermal term and route Leq. Walking speed was not the H4 outcome.

32. Alvarsson et al. (2010) [Excluded]:
    - Measured: skin conductance and HF under played nature sound or traffic noise.
    - Outdoor: missing (laboratory). Sound: present as playback. Thermal: missing. Outcome: present (skin conductance and HF).
    - Reason: Missing: outdoor exposure and a thermal term.

33. Hedblom et al. (2019) [Excluded]:
    - Measured: skin conductance under virtual-reality bird song or traffic noise.
    - Outdoor: missing. Sound: present as playback. Thermal: missing. Outcome: present (skin conductance).
    - Reason: Missing: outdoor exposure and a thermal term. Sound is playback.

34. Cai et al. (2021) [Excluded]:
    - Measured: SDNN, LF/HF, and heart rate at assigned levels from 35 to 65 dBA.
    - Outdoor: missing. Sound: present as assigned levels. Thermal: missing (room held near 25 °C). Outcome: present (heart rate and HRV).
    - Reason: Missing: outdoor exposure and a thermal term. The room was held near 25 °C.

35. Barros et al. (2025) [Excluded]:
    - Measured: skin conductance, heart rate, and HF while auralized traffic changed.
    - Outdoor: missing. Sound: present as playback. Thermal: missing. Outcome: present (skin conductance, heart rate, HF).
    - Reason: Missing: outdoor walked Leq and a thermal term. Sound is indoor playback.

36. Yousefinezhad et al. (2026) [Excluded]:
    - Measured: heart rate and body temperature under assigned heat and 75 dBA.
    - Outdoor: missing (laboratory). Sound: present as an assigned level. Thermal: present as assigned heat. Outcome: partly present (heart rate and skin temperature; blood pressure is missing).
    - Reason: Missing: outdoor exposure. Heat and 75 dBA were assigned in a laboratory.

37. Chiu et al. (2021) [Excluded]:
    - Measured: wind-turbine low-frequency noise and SDNN, with ambient temperature.
    - Outdoor: partly (home sites). Sound: missing (not route A-weighted Leq). Thermal: present. Outcome: present (SDNN).
    - Reason: Missing: route A-weighted Leq. Their sound is residential low-frequency wind-turbine noise.

38. Li et al. (2023) [Excluded]:
    - Measured: HRV, skin conductance, and weather on a planned route chosen to be quiet.
    - Outdoor: present. Sound: missing. Thermal: present. Outcome: present (HRV and skin conductance).
    - Reason: Missing: a sound term. The route was chosen to be quiet.

39. Temperature and vehicle flow (2021) [Excluded]:
    - Measured: how air and pavement temperature change noise emitted by traffic.
    - Outdoor: present (roadside). Sound: present as an emission. Thermal: present. Outcome: missing (no person).
    - Reason: Missing: a person-level outcome. The paper models emitted traffic noise.

Benjamini–Hochberg FDR (α = 0.05) was applied within prespecified families for H1–H6 (including separate H6-A and H6-B families and H4 families per literature source). The **Analysis** block fits additive combined-exposure LMMs (Eq1–7) with VIF screening; it is descriptive association modelling, not a confirmatory hypothesis test.

#### 2.3.1 H1 — environment within mode

H1 (green vs impervious urban): Primary inference used participant × phase means on matched ~8 min segments (44 cells) rather than treating every 10 s epoch as an independent unit, so tests target phase-level within-person contrasts and limit pseudo-replication as above. Each of 26 physiological and ocular outcomes was fit with a REML LMM `Y ~ PhaseID + (1 | ParticipantID)` and a random intercept by participant. Planned contrasts BikeG − BikeU and WalkG − WalkU used estimated marginal means and prespecified pairwise comparisons; same Benjamini–Hochberg FDR within each contrast family across outcomes. Sensitivity: within-person z-scored phase means; optional 10 s / 60 s AR(1) time series to acknowledge serial correlation along the route without changing the primary phase-mean estimand (`H1_H3_phaseavg.R`, `H1_H3_timeseries.R`; `H1_H3_Contrasts.csv`, `H1_H3_Temporal_AR1.csv`).

#### 2.3.2 H2 — psychophysiological concordance

H2: Repeated-measures correlation (rmcorr) estimates the common within-person slope between questionnaire and physiological phase means, using each participant’s repeated phase cells as the pairing structure—Pearson *r* on the same 44 rows would treat phases as independent and misstate the effective sample for concordance. rmcorr was applied between 18 end-of-phase questionnaire items (comfort, environmental comfort, STAI-6 items, PRS-11 subscales—no scale roll-ups) and the same 26 physiological phase means as H1 (**468 prespecified pairs**; one BH family over all pairs). Fitted with H1 in `H1_H3_phaseavg.R`; export `H2_Concordance.csv`.

#### 2.3.3 H3 — mode within environment

H3 (walking vs cycling): Mode contrasts reuse the H1 phase-mean REML shell and participant random intercept so walking and cycling are compared at the same participant × phase grain as environment tests. Confirmatory contrasts WalkU − BikeU and WalkG − BikeG used emmeans with the same FDR family rule within the H3 contrast family over 26 outcomes. The difference-of-differences (BikeG − BikeU) − (WalkG − WalkU) is descriptive only—mode × environment interaction was not a prespecified confirmatory contrast (`H1_H3_Contrasts.csv`, Hypothesis = H3).

#### 2.3.4 H4 — sound and heat-plus-sound tests from previous literature

H4 applies published outdoor heat–noise test designs to field data (`H4_sound_literature_tests.R`; 11 participants, four core phases, 26 outcomes). The search was limited to outdoor and naturalistic studies. Climate-chamber experiments were excluded. These are adaptations, not replications: heat and noise are observed (UTCI > 26 °C; dBA ≥ 65), not assigned. Rodrigues et al. (2026) and Kraus et al. (2013) are the ambulatory anchors (Mansi et al., 2022). Because thermal, acoustic and visual context co-vary outdoors, a significant adapted test is an association under naturalistic confounding, not a causal noise effect (Chinazzo et al., 2019).

| Source | Test as applied here | Sound term(s) tested |
| --- | --- | --- |
| Moshammer et al. (2019) | (a) Phase-level LMM per 8 cardiovascular outcomes: outcome ~ phase Leq per 5 dB + MET (+ air temperature) + (1 \| Participant), slope reported with and without the temperature term (source robustness claim); (b) road-vs-park analogue: paired WalkG − WalkU phase-mean contrast, unadjusted and adjusted for Δ air temperature (ANCOVA intercept); source BP endpoint unavailable | Per-5 dB Leq slope (2 specifications × 8 outcomes); WalkG − WalkU contrast (2 × 8) |
| Song et al. (2013, 2014) | Family-size sensitivity of the same WalkG − WalkU contrast, restricted to SDNN and RMSSD (the two outcomes with raw p < 0.05 on the temperature-adjusted contrast in the eight-outcome screen). Two-sided tests. Source used a one-sided unadjusted paired t and did not measure sound level. Not an independent confirmatory test | Unadjusted paired difference; temperature-adjusted intercept (2 outcomes each) |
| Jin, Jin & Kang (2020) | **Perception family** (separate from the 26 physio outcomes): end-of-phase thermal comfort and environmental comfort ~ dBA bin (≥ 65) × UTCI bin (> 26), participant-blocked ANOVA on 44 phase cells; bins observational, quiet × hot cell n = 3 | dBA main effect; dBA × UTCI interaction |
| Rodrigues et al. (2026) | Trip-level mixed model with noise block (max and SD of dBA, z-scored; published script), extended with mean for our personal-exposure stream; REML, Wald tests; retention rule p < 0.05 and \|β\| > 0.1 plus our BH-FDR (source Lden map vs logged uCM dBA) | Each noise term |
| Kraus et al. (2013) | Phase-level summaries with Leq piecewise slopes at 65 dBA per 5 dB above/below; MET and HR adjustment; trend form by AIC; outcomes HR, SDNN, LFnu, HFnu, LF/HF | Per 5 dB above and below 65 dBA |

FDR: same Benjamini–Hochberg rule within each source’s prespecified sound-term family (8 cardiovascular outcomes for Moshammer; 2 outcomes for the Song sensitivity; 2 perception items for Jin; 26 outcomes for Rodrigues; 5 for Kraus), controlling false discoveries across parallel outcome tests without assuming independence across families. Raw *p* and *q* reported. Which papers were included or excluded, and why, is the numbered screening list under the H1–H6 framework above. Adaptation notes: `METHODS_NOTES.md`. Kraus DOI **10.1289/ehp.1205606**.

#### 2.3.5 H5 — shared places and local thermal stress (exploratory)

H5 is exploratory: it asks whether within-person responses differ at GPS-linked corridor cells that repeat on the fixed protocol, extending phase-mean outdoor exposure profiling (Nikolopoulou et al., 2001; Fahy et al., 2025) to local thermal pockets during the same memorized routes (Korkmaz et al., 2025).

**H5.1 (hotspot thermal):** 10 s epochs assigned to fixed-route buffer cells (walk 11 m, bike 35 m; §8), collapsed to participant × hotspot × day medians; per phase × outcome, `median_center_Y ~ env_ucm_UTCI_c + hotspot_f + (1 | ParticipantID)`.

**H5.2 (view context):** same grain; centred outcome ~ UTCI + log10(lux + 1) + one site SVF, TVF or BVF (metric definitions: Gong et al., 2018) or Gong dominance class; random intercept by participant, AR(1) along route position. FDR families separate from H1–H4. `H5_hotspot_weather.R`; design detail §7–§8.

#### 2.3.6 H6 — composite load concordance (exploratory)

Prespecified exploratory coupling only (§9—not confirmatory H1–H4 or the combined-exposure block). Phase means or capped 10 s epochs (`H6_stress_composite_phaseavg.R` / `...timeseries.R`). **Environmental load indices** (each = stress-oriented WPZ, then used as a single predictor): thermal load from UTCI; acoustic load from backpack A-weighted level (`ucm_SND_dBA`); restorative stress as the equal-weight mean of WPZ for inverted SVF, inverted TVF, and inverted 50 m GVI (`gvi_50m`). **Physiological outcomes:** CSV-transformed tonic EDA and RMSSD plus a transparent four-feature ocular stress index (not the proprietary two-feature score). Composite loads summarize co-occurring microclimate and morphology pressures in line with field comfort work that treats physiology as a multi-exposure readout rather than a single-index response (Mansi et al., 2022; Chinazzo et al., 2019). **H6-A:** `out_{physio} ~ idx_{thermal|acoustic|restorative} + PhaseID + (1 | ParticipantID)` — three indices × three outcomes (9 tests, family `H6_A_env_physio`). **H6-B:** `out_{physio} ~ psy_{scale} + idx_thermal_load + idx_acoustic_load + PhaseID + (1 | ParticipantID)` for WPZ of PRS-11 fascination, STAI tense, and acoustic comfort (three scales × three outcomes; 9 tests, family `H6_B_psych_physio_given_env`); time-series shells add AR(1).

#### 2.3.7 Combined-exposure model (not a hypothesis test)

One **additive** LMM per outcome × **Eq1–7** (main effects only) to describe adjusted associations when thermal, acoustic, radiative, pollution and route-context terms co-occur during active mobility—motivated by the evidence gap that naturalistic studies rarely partition joint exposures (Mansi et al., 2022; Chinazzo et al., 2019) and by ambulatory models that enter environmental blocks together (Rodrigues et al., 2026). This block is descriptive association modelling, not a confirmatory hypothesis test; correlated exposures are reported transparently rather than interpreted as independent causal drivers (Hamra & Buckley, 2018). Primary grain: `Analysis_combined_timeseries.R` (10 s); sensitivity: `Analysis_combined_phaseavg.R` (phase means). BH **q** per fixed term within equation × 26 outcomes, as above.

**VIF screening** (heart-rate complete cases; `Analysis_combined_gvif_summary_both_grains.csv`): variance inflation factor VIF = 1/(1 − R²) for each fixed effect regressed on the others (Marquardt, 1970; James et al., 2013); the multi-column **PhaseSum** route block uses the Fox–Monette block VIF (Fox & Monette, 1992). We follow James et al. (2013) and screen on **maximum term (or block) VIF < 10** in the design actually fitted. We report that maximum at each grain in the table below; predictors were dropped **only where screening failed for that grain’s fitted model**, not globally across grains.

Collinearity is defined relative to **which design matrix is fit** (James et al., 2013): aggregating to phase means changes *n* and the covariance among exposures and route contrasts, so **10 s and phase-mean specifications may legitimately differ in which covariates enter** (e.g. phase Eq3 excluded at max VIF 22.48 while the 10 s Eq3 remains estimable), with VIF computed only on the terms present in each fitted equation—not as proof that one grain is “more correct.”

**Fitted specifications (shared non-thermal core unless noted):** sound `ucm_SND_dBA`, morphology `SVF`, pollution/light `atmo_pm2.5_avg`, `lys_lux_avg`, `lys_kelvin_avg`, route `PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`. **10 s** adds `ucm_SUN_Gh` and `gvi_50m` where listed; **phase means** omit SUN and GVI on all equations.

- **Eq1:** `ucm_UTCI` + shared core + (10 s: SUN, GVI).
- **Eq2:** `ucm_AIR_T_mid`, `ucm_AIR_RH`, `ucm_WIND_AWS` + `SVF` + PM2.5/lux/kelvin + PhaseSum + (10 s: SND, SUN, GVI; phase: no SND — max VIF **9.29** vs 10 s **1.61**).
- **Eq3:** `ucm_MRT` + SND + PM2.5/lux/kelvin + PhaseSum only (no SVF, GVI, or SUN at either grain; phase max VIF **22.48**, 10 s **1.04** — **10 s inference only**).
- **Eq4:** `ucm_HUMIDEX` + shared core + (10 s: SUN, GVI).
- **Eq5:** `ucm_PET` + same non-thermal set as Eq4 + (10 s: SUN, GVI).
- **Eq6:** as Eq1 with `atmo_pm1_avg` in place of PM2.5 + (10 s: SUN, GVI).
- **Eq7:** as Eq1 with `atmo_pm10_avg` in place of PM2.5 + (10 s: SUN, GVI).

| Eq  | Terms                                                                                                                                                                                  | VIF_timeseries | VIF_phaseavg |
| --- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------: | -----------: |
| 1   | `ucm_UTCI + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                  | 1.18           | 7.98         |
| 2   | `ucm_AIR_T_mid + ucm_AIR_RH + ucm_WIND_AWS + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                      | 1.61           | 9.29         |
| 3   | `ucm_MRT + ucm_SND_dBA + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                                                 | 1.04           | 22.48        |
| 4   | `ucm_HUMIDEX + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                               | 1.03           | 5.54         |
| 5   | `ucm_PET + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                   | 1.14           | 6.59         |
| 6   | `ucm_UTCI + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm1_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                    | 1.18           | 7.75         |
| 7   | `ucm_UTCI + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm10_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                   | 1.18           | 8.32         |

† **Terms** list 10 s predictors except **Eq2** (row = phase-mean Eq2 without SND/SUN/GVI; 10 s Eq2 adds them). VIF columns: max term or PhaseSum-block VIF on heart-rate complete cases for the design in that row.

## 3 Results

### 3.1 Microclimate of the green and impervious routes

Participant-weighted phase profiles on the merged 10-second dataset: UTCI/PET, sound, radiation, PM and wind across BikeU, WalkU, BikeG, WalkG (Tram descriptive only). These are the measured exposures for the response contrasts in §3.2–§3.8. Precedent for a walking-transect mixed model of PET: Fahy et al. (2025) — local climate zone and solar energy, not land-surface temperature, explained daytime PET in Geneva; open lawns were hotter than shade under trees or compact streets (`D:\Pranav\docker\Paper3_Github\Experiment papers\Urban Climate Literature\ucm paper - urban walk LCZ.pdf`).

### 3.2 H1 — environment within mode

Phase-mean models (§2.3.1); estimates from `H1_H3_Contrasts.csv` (Hypothesis H1). Green phases were associated with **lower square-root-transformed tonic EDA** and skin temperature and with larger pupil diameter (pupil is illumination-sensitive).

Table 3.2. H1 FDR-significant phase-mean contrasts (primary analysis units; `H1_H3_Contrasts.csv`, BH within 26 outcomes × contrast family).

| Tests (primary) | FDR q < 0.05 | Representative FDR hits (green − urban direction) |
| --- | --- | --- |
| 52 (26 outcomes × BikeG−BikeU and WalkG−WalkU) | **11** | Lower skin temperature (both modes); larger pupil diameter (both); shorter blink duration (both); longer fixation duration (WalkG−WalkU); lower gaze velocity and dispersion (WalkG−WalkU); gaze-centre shift (distance from center, BikeG−BikeU); larger eyelid aperture (BikeG−BikeU). Tonic EDA contrasts did not survive FDR in this export. |

| Outcome | Contrast | β | q~FDR~ |
| --- | --- | --- | --- |
| empatica_skin_temperature | BikeG − BikeU | −1.12 | 0.018 |
| empatica_skin_temperature | WalkG − WalkU | −1.16 | 0.009 |
| eyetracker_pupil_diameter_avg | BikeG − BikeU | 0.39 | 0.018 |
| eyetracker_pupil_diameter_avg | WalkG − WalkU | 0.95 | <0.001 |
| eyetracker_blink_duration_s | BikeG − BikeU | −0.009 | <0.001 |
| eyetracker_blink_duration_s | WalkG − WalkU | −0.013 | <0.001 |


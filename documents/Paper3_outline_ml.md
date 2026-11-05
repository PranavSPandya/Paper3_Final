## Psychophysiological comfort during active urban mobility: Environment and activity modulated physiological and perceived responses across diverse urban contexts

### Abstract

Urban active travel exposes people simultaneously to thermal, acoustic, visual and physical demands, yet these exposures are rarely studied together under naturalistic conditions. This repeated-measures field study examined psychophysiological comfort across cycling and walking phases in impervious urban and green environments in Brussels. Eleven participants completed route phases while wearable physiological, mobile eye-tracking and environmental data were synchronized to 10-second epochs. Linear mixed models tested environment and mode, literature-based tests examined whether noise amplifies thermal stress, and an additive mixed model estimated all exposures together, with repeated measures accounted for and Benjamini-Hochberg correction applied within hypothesis families. Green phases were associated with **lower skin temperature** and **larger pupil diameter** (pupil is illumination-sensitive). Walking versus cycling differed mainly in **ocular kinematics** (pupil, blink, fixation, gaze velocity, dispersion, and gaze position) in the phase-mean models. No heat-by-noise interaction survived false-discovery-rate correction in any literature-based H4 test on calibrated **ucm_SND_dBA**. **21 of 468** questionnaire–physiology pairs reached q_FDR < 0.05 in H2 (`H2_Concordance.csv`; prespecified grid 18×26, all fitted; one BH family), all with ocular or skin-temperature outcomes; broad psychophysiological concordance was not supported. These findings indicate distinct physiological and visual-attention signatures across mobility contexts, while the small sample, model diagnostics and observational field exposures limit causal and population-level claims.

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

1. **H1 — Green versus impervious comfort.** Participants show better physiological and perceived comfort in green than in impervious areas.
2. **H2 — Physiological and perceived concordance.** Physiological and perceived responses are concordant.
3. **H3 — Cycling versus walking.** Psychophysiological comfort is more compromised during cycling than during walking.
4. **H4 — Noise and thermal discomfort.** Noise and traffic-related sound amplify thermal discomfort.
5. **Analysis — Combined exposure.** Additive models describe adjusted associations when thermal, acoustic, radiative, pollution, and route-context terms co-occur. This block is not a hypothesis test.

## 2 Methods

Urban-comfort and mobile-exposure papers typically combine design, measurements and analysis in one flow rather than separate “instruments” and “procedure” sections. Measurements are described where they support the analysis grain (here: matched route phases and 10-second epochs). The subsections below follow that convention.

### 2.1 Study design

A repeated-measures field campaign was conducted in Brussels, Belgium, from **3 July to 27 August 2025**. Each participant completed four core outdoor mobility phases—cycling and walking in impervious urban corridors and in green-park corridors—plus a seated tram phase (descriptive only). Phase labels were BikeU, WalkU, WalkG, BikeG and Tram; tram was excluded from the primary 2 × 2 environment-by-mode contrasts.

Randomization of route order was planned. Participants completed questionnaires before and after each block; wearables and the trailing-researcher uCM backpack were checked at breaks. All streams were time-aligned to **UTC**. The design targets within-person comparisons of environment and mode under naturalistic active mobility; route location, workload, illumination and co-exposures co-vary with phase, so inferential models estimate associations, not single-stressor causation.

#### 2.1.1 Participants

Eighteen volunteers were tested (30 planned under ethics). Eleven with complete multi-sensor coverage on the four core phases were analysed (P4, P8–P17). Inclusion criteria were age 18–60 years, Brussels residence, ability to walk and cycle the study routes, and vision compatible with mobile eye tracking. Ethics application signed 28 May 2025 (approval reference from approved PDF). With n = 11 and four repeated phase cells, post hoc sensitivity (GPower, α = 0.05, power = 0.80, r = 0.50) suggested minimum detectable f ≈ 0.52. Using partial η² = f² / (1 + f²), that f is about 0.21, not 0.11.

The analysed sample comprises eleven participants (three women, eight men) aged 24–58 years (mean 35.2 years, SD 9.5), within the 18–60 year inclusion range. Self-reported height and weight yield BMI 20.5–33.0 kg·m⁻² (mean 23.8 kg·m⁻², SD 3.8): eight meet WHO normal weight (18.5–24.9 kg·m⁻²), two are overweight, and one has obesity. Project case-study labels classify eight as Fit and three as Not Fit and six as Active and five as Inactive (BMI- and daily-walking–based rules applied to the same eleven IDs). Clothing-questionnaire skin tone (Very fair, Fair, Medium, Olive, Brown) is mapped to Fitzpatrick types I–V by ascending shade (I, n = 1; II, n = 6; III, n = 2; IV, n = 1; V, n = 1; no type VI), covering the range where wrist photoplethysmography and optical heart rate on Empatica wearables may perform unevenly across pigmentation (Bent et al., 2020). Seven participants normally wear glasses; four report no vision correction.

Archived mixed models that enter those Fit/Not Fit and Active/Inactive labels as person-level factors are sensitivity analyses only; none of their coefficients survive Benjamini–Hochberg FDR control in the primary hypothesis families reported here.

### 2.2 Data preparation

Micrometeorology and context (uCM, 10 s): air temperature, humidity, mean radiant temperature, global horizontal irradiance, wind, A-weighted sound (dBA), GPS, UTCI and PET. Air quality and light: PM (Atmotube means), lux and colour temperature (LYS means). Scene openness (CamUp / Mapillary pipelines): Holmer annular sky view factor (SVF) for inferential models; tree view factor (TVF) and building view factor (BVF) computed alongside SVF but not co-entered with SVF or GVI in the combined-exposure model (Gong et al., 2018). Greenery: eye-level GVI (`gvi_50m`). Physiology (Empatica): EDA tonic/phasic, heart rate, HRV, wrist temperature. Vision (eye tracker): pupil, blink, fixation and gaze kinematics; proprietary `eyetracker_stress_composite` retained in the merge for exploration only. Perception: end-of-phase comfort and environmental-comfort items, STAI-6 item scores, PRS-11 subscale means (18 questionnaire columns in H2/H1–H3 exports).

Streams were synchronized, path-matched and quality-checked, aggregated to 10-second epochs, then—for the phase-mean analyses (H1–H3 and the phase-mean combined-exposure model)—collapsed to participant × phase means on matched **eight-minute segments** (44 cells). Clearness index (k_t) was computed for solar QC; measured irradiance (`ucm_SUN_Gh`) entered models, not derived k_t. Transformations followed the normalization CSV and were applied to the 10 s rows before phase averaging, so phase means are means of transformed values (H1–H3 and the phase-mean combined-exposure model).

Sound exposure (two streams): Primary loudness is the uCM calibrated A-weighted level `ucm_SND_dBA` (10 s medians on the backpack stream). Supplementary descriptors from phase WAVs include YAMNet source-type proportions/scores, Welch band energy shares, octave summaries, and spectral centroids (`Sound spectrum in field experiment.md`). These are not interchangeable with calibrated dBA; low-frequency band fractions can correlate with classifier “wind” labels and with apparent wind on the body during cycling—interpret as type/frequency structure, not as a second loudness standard.

Wind and microphones: Outdoor noise guidance treats high wind as a measurement-condition issue even with windscreens (Federal Highway Administration, n.d.; International Organization for Standardization, 2017; Zuo et al., 2016). A 5 m/s apparent-wind exclusion on `ucm_WIND_AWS` was implemented as an optional sensitivity for supplementary sound models only (not a decibel correction). Literature (Cooper & Evans, 2015) cautions that a 5 m/s cutoff alone does not guarantee absence of wind-on-microphone artefacts. Windscreen type and microphone placement on the uCM should be stated from field notes in the final manuscript.

### 2.3 Statistical analysis

Primary inference used REML linear mixed models (Pinheiro & Bates, 2000) on participant × phase means to target within-person contrasts and limit pseudo-replication from epoch-level counts (Cnaan et al., 1997; Enders & Tofighi, 2007), with planned contrasts from estimated marginal means (Lenth, 2023) and questionnaire–physiology coupling via repeated-measures correlation (Bakdash & Marusich, 2017). Benjamini–Hochberg FDR (α = 0.05; Benjamini & Hochberg, 1995) was applied within prespecified hypothesis families. Unbalanced repeated-measures field designs follow ambulatory precedent (Rodrigues et al., 2026; Korkmaz et al., 2025).

1. **H1 — Green versus impervious comfort**:
   - Model: Phase-mean REML LMM: `Y ~ PhaseID + (1 | ParticipantID)`; emmeans contrasts; BH FDR within **each** contrast over **26** physiological outcomes (H1.1 and H1.2 are **separate** families, n = 26 each—not one pooled family of 52). Questionnaire contrasts use **separate** BH families (18 items × contrast). Sensitivity: within-person z-scored (WPZ) repeats the same family structure. Optional 10 s / 60 s AR(1) models: `H1_H3_timeseries.R`. In `H1_H3_Temporal_AR1_10s.csv`, 14 of 182 coefficient rows (tonic EDA and skin temperature) are flagged `rho > 0.95`, and the 7 heart-rate rows are a degenerate fit (phase-term standard errors about 3.8 × 10⁶ on the z scale), reported without *p* or *q*. Do not quote those rows. Phase-mean H1 does not use this file.
   - Description & sub-parts: **H1.1** BikeG − BikeU (green vs impervious, cycling). **H1.2** WalkG − WalkU (green vs impervious, walking). Primary grain: participant × phase means on matched 8 min segments (44 cells); 26 physiological and ocular outcomes. Script: `H1_H3_phaseavg.R`; exports `H1_H3_Contrasts.csv`, `H1_H3_Temporal_AR1.csv`.
2. **H2 — Physiological and perceived concordance**:
   - Model: rmcorr; prespecified grid **18 × 26 = 468** pairs (18 questionnaire items × 26 physiological outcomes); one BH family over **fitted** pairs only (a pair needs ≥ 20 participant × phase means from ≥ 8 participants; all 468 are fitted; `H2_Concordance.csv`).
   - Description & sub-parts: Phase-mean concordance between 18 questionnaire items (current comfort, space familiarity, pleasantness; five environmental comfort dimensions: thermal, acoustic, visual, air quality, odour; six oriented STAI-6 items; four PRS-11 subscale means; no roll-up means) and the same 26 outcomes used in H1. Fitted jointly with H1 in `H1_H3_phaseavg.R`; export `H2_Concordance.csv`.
3. **H3 — Cycling versus walking**:
   - Model: Same phase-mean LMM shell as H1; emmeans; BH FDR within **each** mode contrast over **26** physiological outcomes (H3.1 and H3.2 separate families, n = 26 each); questionnaire and WPZ families as for H1.
   - Description & sub-parts: **H3.1** WalkU − BikeU (mode contrast, impervious urban). **H3.2** WalkG − BikeG (mode contrast, green). **Descriptive (not confirmatory):** difference-of-differences (BikeG − BikeU) − (WalkG − WalkU). Exports: `H1_H3_Contrasts.csv` (Hypothesis = H3); sensitivities as H1.
4. **H4 — Noise and thermal discomfort**:
   - Model: Literature-derived tests in `H4_sound_literature_test.R` (not a preregistered protocol). BH FDR within each paper’s own test × outcome family. Screening (`documents/H4_papers_screened.md`): four papers included under the thermal-and-sound rule (Moshammer, Song, Jin, Rodrigues); Kraus excluded from that rule for lacking a thermal term but its Leq piecewise slopes are still fitted and reported separately.
   - Description & sub-parts: Moshammer, Song (park-versus-city one-sided paired t-test on HR, ln HF and ln LF/HF; no dBA term in the source), Jin (the heat × sound ANOVA), Rodrigues (noise-block mixed model), Kraus (piecewise Leq slopes). Heat × noise claims use Jin on `**ucm_SND_dBA**`. Jin’s ANOVA has no participant block, matching the source paper’s independent-respondent analysis; that is written on the test label.
   - **Not part of H4:** the Eq1–7 combined-exposure models (`Analysis_combined_timeseries.R`, `Analysis_combined_phaseavg.R`) are the exploratory **Analysis** block (§2.3 item 5), not a literature test.
5. **Analysis — Combined exposure**:
   - Model: Additive REML LMMs, main effects only (Hamra & Buckley, 2018); not a hypothesis test. Collinearity: `car::vif` GVIF^(1/Df) per term (equal to VIF = 1/(1 − R²) for one-column terms; the three PhaseSum columns are one route term; GVIF^(1/Df) is the square of Fox–Monette GVIF^(1/(2Df))). Screen max VIF < 10 on heart-rate complete cases per fitted grain (`Analysis_combined_gvif_summary_both_grains.csv`); drop predictors only where that grain fails screening.
   - Description & sub-parts: **Analysis — timeseries (10 s):** `Analysis_combined_timeseries.R`; one additive LMM per outcome × **Eq1–7**; BH *q* per fixed term within equation over the 26 outcomes (`library/Analysis_combined_core.R`: one family per equation × term, n = 26); the supplementary blocks in `Analysis_combined_timeseries_supplementary_blocks.csv` have their own BH families (lagged 10 s first-difference correlations: 3 exposure–outcome pairs × 4 lags = 12 rows; sound-source-adjusted slopes: 4 rows); includes `ucm_SUN_Gh` and `gvi_50m` where listed; Eq3 primary at this grain (phase Eq3 excluded at max VIF 22.48). Quote coefficient rows only when the standard error and the low-df and boundary-variance flags are usable. **Analysis — phaseavg (phase means):** `Analysis_combined_phaseavg.R`; same Eq1–7 structure on participant × phase means (all **182** outcome × equation models fitted; many low effective-df coefficient flags—**exploratory**, not confirmatory); omits SUN and GVI on all equations; Eq2 phase spec: `ucm_AIR_T_mid`, `ucm_AIR_RH`, `ucm_WIND_AWS` + **SVF** + PM2.5/lux/kelvin + PhaseSum (**no SND**; max VIF 9.29 vs 10 s Eq2 1.88). Shared non-thermal core: sound (10 s only), SVF, PM, lux/kelvin, PhaseSumWalkG/U/BikeG; thermal term rotates (UTCI, air T/RH/wind, MRT, HUMIDEX, PET; Eq6–7 swap PM fraction). 

H4 paper-by-paper screening (included and excluded) is in `documents/H4_Screening_Literature_Guide.md`.

**H4 tests applied** (`H4_sound_literature_test.R`; adaptations, not replications; heat/noise observed not assigned):

| Source | Test as applied here | Sound term(s) tested |
| --- | --- | --- |
| Moshammer et al. (2019) | Random-effects GLS (Stata xtreg re): outcome mean over 5–8 min ~ energy-mean Leq of the first 5 min per 1 dB(A), unadjusted and + mean air temperature of the outcome window; 5 outcomes (RR distance, SDNN, RMSSD, LF, HF power); all phases and walking phases only. All HRV outcomes (LF and HF power, SDNN, RMSSD, and mean RR distance) are recomputed per phase from the native beat-to-beat intervals in 5–8 min only (180 s, strictly after the 0–5 min exposure and inside the matched bout) with the Empatica build method (beats 250–2500 ms; beats > 0.45 s from the centred 11-beat median removed; ≥ 40 valid beats, ≤ 25 % removed; NeuroKit2 `hrv_frequency` for LF/HF; sample SD and RMSSD on filtered intervals), eliminating exposure overlap; 43 of 44 phases have values. 180 s meets the Task Force (1996) minimums (about 1 min for HF, 2 min for LF); VLF is dropped because it needs more than 5 min. | Per-dB Leq slope (2 specifications × 2 phase sets × 5 outcomes) |
| Song et al. (2013, 2014) | One-sided paired t-test, park (WalkG) vs city (WalkU), on heart rate, ln HF and ln LF/HF (1-min means over the walk) | Setting contrast (no sound-level term) |
| Jin et al. (2020) | Thermal comfort and general comfort ~ LAeq level (55–60, 60–65, 65–70, 70–75 dB(A)) × UTCI category (9–26, 26–32, 32–38, 38–46 °C), two-way ANOVA with no participant block on phase cells inside those ranges; Type II main effects, all F tests against the full-model residual mean square | LAeq main effect; UTCI main effect; LAeq × UTCI interaction |
| Rodrigues et al. (2026) | Trip-level mixed model with noise block (max and SD of dBA, z-scored); REML Wald tests + BH-FDR | Each noise term |
| Kraus et al. (2013) | Additive mixed model on the first complete 5-min interval of each phase (Leq lag 0 only; no lagged outcome): piecewise Leq at 65 dB(A) per 5 dB, activity category, HR adjustment for HRV, AIC-selected time trends, compound symmetry; outcomes HR, SDNN, LFnu, HFnu, LF/HF (log except HR) | Per 5 dB below and above 65 dB(A) |

FDR: Benjamini–Hochberg within each source’s prespecified sound-term family (not pooled across sources). Raw *p* and *q* in `output/statistical_analysis/results/H4_sound_literature_test/`.

Benjamini–Hochberg FDR (α = 0.05) was applied within prespecified families for H1–H4 (including H4 families per literature source). The **Analysis** block fits additive combined-exposure LMMs (Eq1–7) with VIF screening; BH *q* per **fixed term within equation** across **26** physiological outcomes (10 s and phase-mean grains separately)—descriptive association modelling, **not** a confirmatory hypothesis test. At 10 s every exported *q* was rechecked against its BH family at export; AR(1) fits with rho > 0.95 were refitted with ARMA(2,0), and a row would be left untested if rho > 0.95 remained (none in the current export: all 2,158 rows tested). Rows flagged rho > 0.95 in the H1/H3 10 s AR(1) tables are interpreted cautiously (§2.3 item 1).

**H1/H3 primary physiological FDR (`H1_H3_core.R`):** BH within **each** contrast over **26** outcomes—**two families of n = 26** (H1.1 vs H1.2; H3.1 vs H3.2), **not** one pooled family of 52. **Sensitivity only:** pooling all 52 contrast rows into one BH family yields **11** H1 and **9** H3 FDR hits (e.g. WalkG − WalkU fixation duration *q* = **0.004** pooled vs **0.002** under separate families)—does **not** replace the primary rule.

**FDR reporting in §3:** Main text uses **summary counts** plus **small example tables** for confirmatory H1–H3 (primary physiological families) and the **full** table of H2 FDR hits (21 rows). H4 and Analysis coefficient screens are **too numerous** for main-text tables (full *q* in CSV exports / supplement).

#### 2.3.1 Combined-exposure equations and VIF (heart-rate complete cases; `Analysis_combined_gvif_summary_both_grains.csv`): variance inflation factor VIF = 1/(1 − R²) for each fixed effect regressed on the others (Marquardt, 1970; James et al., 2013); the multi-column **PhaseSum** route block is one term scored with the generalized VIF as GVIF^(1/Df) (Fox & Monette, 1992; the square of their GVIF^(1/(2Df)), so it is on the VIF scale). We follow James et al. (2013) and screen on **maximum term (or block) VIF < 10** in the design actually fitted. We report that maximum at each grain in the table below; predictors were dropped **only where screening failed for that grain’s fitted model**, not globally across grains.

Collinearity is defined relative to **which design matrix is fit** (James et al., 2013): aggregating to phase means changes *n* and the covariance among exposures and route contrasts, so **10 s and phase-mean specifications may legitimately differ in which covariates enter** (e.g. phase Eq3 excluded at max VIF 22.48 while the 10 s Eq3 remains estimable), with VIF computed only on the terms present in each fitted equation—not as proof that one grain is “more correct.”

**Fitted specifications (shared non-thermal core unless noted):** sound `ucm_SND_dBA`, morphology `SVF`, pollution/light `atmo_pm2.5_avg`, `lys_lux_avg`, `lys_kelvin_avg`, route `PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`. **10 s** adds `ucm_SUN_Gh` and `gvi_50m` where listed; **phase means** omit SUN and GVI on all equations.

- **Eq1:** `ucm_UTCI` + shared core + (10 s: SUN, GVI).
- **Eq2:** `ucm_AIR_T_mid`, `ucm_AIR_RH`, `ucm_WIND_AWS` + `SVF` + PM2.5/lux/kelvin + PhaseSum + (10 s: SND, SUN, GVI; phase: no SND — max VIF **9.29** vs 10 s **1.88**).
- **Eq3:** `ucm_MRT` + SND + PM2.5/lux/kelvin + PhaseSum only (no SVF, GVI, or SUN at either grain; phase max VIF **22.48**, 10 s **1.04** — **10 s inference only**).
- **Eq4:** `ucm_HUMIDEX` + shared core + (10 s: SUN, GVI).
- **Eq5:** `ucm_PET` + same non-thermal set as Eq4 + (10 s: SUN, GVI).
- **Eq6:** as Eq1 with `atmo_pm1_avg` in place of PM2.5 + (10 s: SUN, GVI).
- **Eq7:** as Eq1 with `atmo_pm10_avg` in place of PM2.5 + (10 s: SUN, GVI).
-

| Eq  | Terms                                                                                                                                                                                  | VIF_timeseries | VIF_phaseavg |
| --- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------: | -----------: |
| 1   | `ucm_UTCI + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                  | 2.52           | 7.95         |
| 2   | `ucm_AIR_T_mid + ucm_AIR_RH + ucm_WIND_AWS + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                      | 1.88           | 9.29         |
| 3   | `ucm_MRT + ucm_SND_dBA + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                                                 | 1.04           | 22.48        |
| 4   | `ucm_HUMIDEX + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                               | 1.41           | 5.52         |
| 5   | `ucm_PET + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                   | 2.36           | 6.58         |
| 6   | `ucm_UTCI + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm1_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                    | 2.52           | 7.73         |
| 7   | `ucm_UTCI + ucm_SND_dBA + ucm_SUN_Gh + SVF + atmo_pm10_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG`                                   | 2.52           | 8.28         |

† **Terms** list 10 s predictors except **Eq2** (row = phase-mean Eq2 without SND/SUN/GVI; 10 s Eq2 adds them). VIF columns: max GVIF^(1/Df) (term or PhaseSum route block) on heart-rate complete cases for the design in that row (10 s n = 2,060 rows; Eq3 2,073; phase means n = 44).

## 3 Results

### 3.1 Microclimate of the green and impervious routes

Participant-weighted phase profiles on the merged 10-second dataset: UTCI/PET, sound, radiation, PM and wind across BikeU, WalkU, BikeG, WalkG (Tram descriptive only). These are the measured exposures for the response contrasts in §3.2–§3.7. Precedent for a walking-transect mixed model of PET: Fahy et al. (2025) — local climate zone and solar energy, not land-surface temperature, explained daytime PET in Geneva; open lawns were hotter than shade under trees or compact streets (`D:\Pranav\docker\Paper3_Github\Experiment papers\Urban Climate Literature\ucm paper - urban walk LCZ.pdf`).

### 3.2 H1 — Green versus impervious comfort

Phase-mean models (§2.3.1); estimates from `H1_H3_Contrasts.csv` (Hypothesis H1). Green phases were associated with **lower skin temperature** and with larger pupil diameter (pupil is illumination-sensitive).

Table 3.2. H1 FDR-significant phase-mean contrasts (primary physiological panel; `H1_H3_Contrasts.csv`, BH within **each** contrast over 26 outcomes).

| Tests (primary physio) | FDR q < 0.05 | Representative FDR hits (green − urban direction) |
| --- | --- | --- |
| 52 rows (2 contrasts × 26 outcomes; **two** BH families of n = 26) | **11** | Lower skin temperature (both modes); larger pupil diameter (both); shorter blink duration (both); longer fixation duration (WalkG−WalkU); lower gaze velocity and dispersion (WalkG−WalkU); gaze-centre shift (distance from center, BikeG−BikeU); larger eyelid aperture (BikeG−BikeU). Square-root tonic EDA contrasts did not survive FDR in primary physio families. Pooled 52-test sensitivity: still **11** H1 hits (not the primary rule; §2.3). |

*Sensitivity:* **61** q < 0.05 across **all** H1 rows in the export (primary + WPZ physio + questionnaire families)—report in supplement, not pooled with the primary physio count above.

| Outcome | Contrast | β | q~FDR~ |
| --- | --- | --- | --- |
| empatica_skin_temperature | BikeG − BikeU | −1.12 | 0.018 |
| empatica_skin_temperature | WalkG − WalkU | −1.16 | 0.009 |
| eyetracker_pupil_diameter_avg | BikeG − BikeU | 0.39 | 0.018 |
| eyetracker_pupil_diameter_avg | WalkG − WalkU | 0.95 | <0.001 |
| eyetracker_blink_duration_s | BikeG − BikeU | −0.009 | <0.001 |
| eyetracker_blink_duration_s | WalkG − WalkU | −0.013 | <0.001 |

### 3.3 H2 — Physiological and perceived concordance

Repeated-measures correlation (§2.3 item 2); export `H2_Concordance.csv` (all **468** pairs of the prespecified 18×26 grid fitted; one BH family). **21** pairs reached q_FDR < 0.05, all with blink duration (9), pupil diameter (6), skin temperature (5) or fixation duration (1)—not broad concordance.

| Tests | FDR q < 0.05 |
| --- | --- |
| 468 fitted (468 prespecified) | **21** |

| Questionnaire | Physiological outcome | r~rmcorr~ | q~FDR~ |
| --- | --- | --- | --- |
| PRS-11 fascination (1–5) | Pupil diameter | 0.71 | 0.004 |
| Pleasantness (1–5) | Blink duration | −0.66 | 0.007 |
| Acoustic comfort (1–5) | Blink duration | −0.67 | 0.007 |
| Thermal comfort (1–5) | Blink duration | −0.65 | 0.007 |
| PRS-11 fascination (1–5) | Blink duration | −0.66 | 0.007 |
| PRS-11 being away (1–5) | Blink duration | −0.68 | 0.007 |
| Acoustic comfort (1–5) | Skin temperature | −0.56 | 0.031 |
| PRS-11 fascination (1–5) | Skin temperature | −0.56 | 0.031 |
| PRS-11 scope (1–5) | Pupil diameter | 0.59 | 0.031 |
| Air quality comfort (1–5) | Pupil diameter | 0.58 | 0.036 |
| STAI calm, reversed (1–5) | Pupil diameter | −0.56 | 0.038 |
| Air quality comfort (1–5) | Blink duration | −0.56 | 0.038 |
| Air quality comfort (1–5) | Skin temperature | −0.54 | 0.038 |
| STAI calm, reversed (1–5) | Blink duration | 0.56 | 0.038 |
| Visual comfort (1–5) | Blink duration | −0.56 | 0.038 |
| Thermal comfort (1–5) | Pupil diameter | 0.57 | 0.038 |
| PRS-11 scope (1–5) | Blink duration | −0.57 | 0.038 |
| Visual comfort (1–5) | Fixation duration | 0.55 | 0.040 |
| Visual comfort (1–5) | Skin temperature | −0.52 | 0.043 |
| PRS-11 being away (1–5) | Pupil diameter | 0.54 | 0.044 |
| PRS-11 being away (1–5) | Skin temperature | −0.51 | 0.044 |

### 3.4 H3 — Cycling versus walking

Phase-mean contrasts (§2.3 item 3); `H1_H3_Contrasts.csv` (Hypothesis H3, normalization Primary). Walking versus cycling showed **8** FDR-significant primary physiological contrasts, all ocular. Tonic EDA, fixation rate, and skin temperature did not survive FDR in this family.

| Tests (primary physio) | FDR q < 0.05 |
| --- | --- |
| 52 rows (2 contrasts × 26 outcomes; two BH families of n = 26) | **8** |

| Outcome | Contrast | β | q~FDR~ |
| --- | --- | --- | --- |
| eyetracker_gaze_velocity | WalkU − BikeU | 609 | <0.001 |
| eyetracker_gaze_dispersion | WalkU − BikeU | 0.019 | <0.001 |
| eyetracker_blink_duration_s | WalkU − BikeU | 0.015 | <0.001 |
| eyetracker_blink_duration_s | WalkG − BikeG | 0.011 | <0.001 |
| eyetracker_fixation_duration_s | WalkU − BikeU | −0.034 | <0.001 |
| eyetracker_distance_from_center | WalkG − BikeG | 52.8 | <0.001 |
| eyetracker_gaze_centrality | WalkG − BikeG | −0.093 | <0.001 |
| eyetracker_pupil_diameter_avg | WalkU − BikeU | −0.46 | 0.004 |

### 3.5 H4 — Noise and thermal discomfort

**Primary H4:** `H4_sound_literature_test.R` → `output/statistical_analysis/results/H4_sound_literature_test/` (the Eq1–7 combined-exposure models are not H4; §3.6).

On primary `**ucm_SND_dBA**`, no Jin dBA × UTCI interaction survived FDR (0/2 perception items). Moshammer Leq slopes and Song walk sensitivity had **0** FDR hits. Rodrigues noise block: under their retention rule (round(p, 4) < 0.05 and |round(β, 4)| > 0.1), `NOISE_max` was retained for 2 of 15 outcomes (maximum and minimum skin temperature, `MAX_Values`, `MIN_Values`); after BH within the test, **1** survived (`NOISE_max` on `MIN_Values`); `NOISE_std` had none. The other five Rodrigues q < 0.05 rows on primary dBA are in the temperature block, which has no sound term (`Temp_max`: `STD_Values`, `MAX_Values`; `Temp_mean`: `STD_bpm`, `STD_Values`, `MAX_Values`). Kraus piecewise slopes: **0** FDR hits on five HRV outcomes. Supplementary sound-class substitutions in the same pipeline are exploratory and not interpreted as calibrated loudness.

Full counts: `output/statistical_analysis/results/H4_sound_literature_test/SUMMARY_sound_tests_p_and_FDR.csv` (filter `sound_variable == ucm_SND_dBA (primary)` for manuscript claims).

### 3.6 Analysis — Combined exposure

Additive Eq1–7 LMMs at 10 s and at phase means (§2.3 item 5). Current exports: **151 / 2158** coefficient rows with q < 0.05 at 10 s (`Analysis_combined_timeseries_hypothesis.csv`); **45 / 1820** at phase means (`Analysis_combined_phaseavg_Heat_Noise_Exposures.csv`). Phase Eq3 was not used (maximum VIF 22.48). The 10 s Eq3 was kept.

## 4 Discussion

### 4.1 H1 — Green versus impervious comfort

Within each travel mode, green-corridor phases were associated with lower wrist skin temperature and larger pupil diameter, together with shorter blink duration. On foot, the green phase also showed longer fixations and lower gaze velocity and dispersion; while cycling, gaze position shifted toward the visual centre and eyelid aperture increased. Eleven of 52 primary physiological contrasts remained after Benjamini–Hochberg correction within each contrast family. Tonic electrodermal activity did not. The skin-temperature contrast is consistent with a **lower radiant and convective load under higher sky and vegetation cover**, not with a restoration effect (Boucsein et al., 2012). Pupil diameter **co-varies with illuminance as well as with arousal** (Mahanama et al., 2021), and the two route types differ in both. Hypothesis 1 is therefore supported for **peripheral temperature and selected gaze metrics**, and is **not supported as a general reduction in autonomic strain**.

### 4.2 H2 — Physiological and perceived concordance

Twenty-one of 468 repeated-measures correlations remained after correction. The surviving pairs couple end-of-phase pleasantness, environmental comfort (thermal, acoustic, visual, air quality), calmness and perceived restorativeness (PRS-11 fascination, being away, scope) with blink duration, pupil diameter, wrist skin temperature, and fixation duration. Heart rate, heart-rate variability, and tonic electrodermal activity did not show a corresponding pattern. Because the questionnaires summarise the completed phase, they are not contemporaneous with the sensor means, and **a single comfort vote cannot be expected to track every autonomic channel** (Nikolopoulou et al., 2001). Hypothesis 2, a broad concordance between perceived comfort and physiology, is not supported.

### 4.3 H3 — Cycling versus walking

All eight primary physiological contrasts that survived correction were ocular: gaze velocity and dispersion, blink duration, fixation duration, distance from centre, gaze centrality, and pupil diameter. Wrist skin temperature, tonic electrodermal activity, and fixation rate did not differ between modes after correction. The two modes differ in travel speed, **metabolic demand**, and **the visual demand of monitoring the carriageway** (Rupi & Krizek, 2019). The gaze differences are therefore read as **mode-specific attentional load, not as a ranking of thermal comfort**. Hypothesis 3, that cycling would be **more thermally and physiologically compromised** than walking, is not established.

### 4.4 H4 — Noise and thermal discomfort

On calibrated A-weighted level, the Jin heat-by-sound interaction was not significant after correction for either comfort item (0/2). The Moshammer equivalent-level slopes, the Song park-versus-street sensitivity, and the Kraus piecewise slopes likewise yielded no corrected associations on that loudness measure. The Rodrigues noise block retained two noise-term associations under that study’s retention rule, one of which survived correction; neither is a heat-by-noise interaction. Song’s source comparison contains no sound-level term, and the Jin ANOVA omits a participant effect, so its uncorrected *p*-values are **anti-conservative for repeated phases**. Heat and sound were **co-occurring route exposures rather than assigned treatments**, which limits the power to detect an interaction of the magnitude reported in outdoor-square and laboratory studies. Hypothesis 4 is not supported. The result is **an absence of evidence in this summer field design**, not a demonstration that **acoustic load is irrelevant to outdoor thermal discomfort**.

### 4.5 Analysis — Combined exposure

The additive Eq1–7 models describe **co-occurring microclimatic, acoustic, and morphological exposures**. They are not a hypothesis test. At the 10 s grain, 151 of 2,158 coefficient rows had q < 0.05; at phase means, 45 of 1,820 did. The phase-mean specification that included the full thermal block (Eq3) was excluded because the maximum variance inflation factor was 22.48, so **collinear radiant, air, and humidity terms are not interpreted as separate effects** at that grain. These family counts are not read term by term in the main text.

### 4.6 Limitations

The sample is 11 adults in one city over one summer (3 July to 27 August 2025). Environment type and travel mode are confounded with location, sequence, illuminance, **metabolic rate**, and co-exposures; randomization of route order was planned and **is not verified here as a realised counterbalanced sequence**. Wrist temperature and electrodermal activity are sensitive to contact and motion, and apparent wind mixes ambient flow with **movement-induced airflow at the microphone**. **No causal attribution of comfort to green infrastructure** is made.

## 5 Conclusion

Phase-mean models of a Brussels summer active-mobility campaign show **environment-specific differences in wrist skin temperature and visual attention**, and **mode-specific differences that are confined to ocular kinematics**. Broad concordance between end-of-phase comfort ratings and autonomic physiology was not confirmed (21 of 468 pairs), and no heat-by-noise amplification survived correction in the literature-adapted tests on calibrated A-weighted sound. The findings support **context-dependent psychophysiological responses to outdoor microclimate and route type**, not a general ranking of green versus impervious corridors or of walking versus cycling. **Larger multi-season samples, with exposures that are less collinear than the observed summer routes**, are required before combined-exposure interactions can be treated as **design evidence**.

## 6 References

Bakdash, J. Z., & Marusich, L. R. (2017). Repeated measures correlation. Frontiers in Psychology, 8, 456. https://doi.org/10.3389/fpsyg.2017.00456

Benjamini, Y., & Hochberg, Y. (1995). Controlling the false discovery rate: A practical and powerful approach to multiple testing. Journal of the Royal Statistical Society: Series B (Methodological), 57(1), 289–300.

Bent, B., Goldstein, B. A., Kibbe, W. A., & Dunn, J. P. (2020). Investigating sources of inaccuracy in wearable optical heart rate sensors. npj Digital Medicine, 3, 18. https://doi.org/10.1038/s41746-020-0226-6

Boucsein, W., et al. (2012). Publication recommendations for electrodermal measurements. Psychophysiology, 49(8), 1017–1034. https://doi.org/10.1111/j.1469-8986.2012.01384.x

Chinazzo, G., Wienold, J., & Andersen, M. (2019). Daylight affects human thermal perception. Scientific Reports, 9, 13690. https://doi.org/10.1038/s41598-019-48963-y

Cnaan, A., Laird, N. M., & Slasor, P. (1997). Using the general linear mixed model to analyse unbalanced repeated measures and longitudinal data. Statistics in Medicine, 16(20), 2349–2380.

Cooper, J., & Evans, T. (2015). Microphone wind speed limits during wind farm noise measurements. Proceedings of the Australian Acoustical Society Conference, Hunter Valley.

Enders, C. K., & Tofighi, D. (2007). Centering predictor variables in cross-sectional multilevel models: A new look at an old issue. Psychological Methods, 12(2), 121–138. https://doi.org/10.1037/1082-989X.12.2.121

Evans, K. M., Jacobs, R. A., Tarduno, J. A., & Pelz, J. B. (2012). Collecting and analyzing eye-tracking data in outdoor environments. Journal of Eye Movement Research, 5(2), Article 6.

Fahy, J. C., Bachofen, C., Camponovo, R., Gallinelli, P., & Schlaepfer, M. A. (2025). Beyond land surface temperature: Identifying areas of daytime thermal discomfort in cities by combining remote sensing and field measurements. Urban Climate, 61, 102460. https://doi.org/10.1016/j.uclim.2025.102460

Federal Highway Administration. (n.d.). Highway traffic noise. https://www.fhwa.dot.gov/environment/noise/

Fox, J., & Monette, G. (1992). Generalized collinearity diagnostics. Journal of the American Statistical Association, 87(417), 178–183. https://doi.org/10.1080/01621459.1992.10475190

Gong, F.-Y., et al. (2018). Mapping sky, tree, and building view factors of street canyons. Building and Environment, 134, 155–167. https://doi.org/10.1016/j.buildenv.2018.02.042

Hamra, G. B., & Buckley, J. P. (2018). Environmental exposure mixtures: Questions and methods to address them. Current Epidemiology Reports, 5(2), 160–165. https://doi.org/10.1007/s40471-018-0145-0

International Organization for Standardization. (2017). ISO 1996-2:2017. Acoustics — Description, measurement and assessment of environmental noise — Part 2: Determination of sound pressure levels.

James, G., Witten, D., Hastie, T., & Tibshirani, R. (2013). An introduction to statistical learning: With applications in R. Springer.

Jin, Y., Jin, H., & Kang, J. (2020). Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares. Building and Environment, 168, 106517. https://doi.org/10.1016/j.buildenv.2019.106517

Korkmaz, D., Knauth, K., Brands, A., Schmeck, M., Büning, P., & Peters, J. (2025). Ambulatory physiological measures obtained under naturalistic urban mobility conditions have acceptable reliability. Scientific Reports, 15, 28940. https://doi.org/10.1038/s41598-025-13216-8

Kraus, U., Schneider, A., Breitner, S., Hampel, R., Rückerl, R., Pitz, M., Geruschkat, U., Belcredi, P., Radon, K., & Peters, A. (2013). Individual daytime noise exposure during routine activities and heart rate variability in adults: A repeated measures study. Environmental Health Perspectives, 121(5), 607–612. https://doi.org/10.1289/ehp.1205606

Lenth, R. V. (2023). emmeans: Estimated marginal means, aka least-squares means (R package). https://CRAN.R-project.org/package=emmeans

Mahanama, B., et al. (2021). Eye movement and pupil measures: A review. Frontiers in Computer Science, 3, 733531. https://doi.org/10.3389/fcomp.2021.733531

Mansi, S. A., Pigliautile, I., Arnesano, M., & Pisello, A. L. (2022). A novel methodology for human thermal comfort decoding via physiological signals measurement and analysis. Building and Environment, 222, 109385. https://doi.org/10.1016/j.buildenv.2022.109385

Marquardt, D. W. (1970). Generalized inverses, ridge regression, biased linear estimation, and nonlinear estimation. Technometrics, 12(3), 591–612.

Moshammer, H., Panholzer, J., Ulbing, L., Udvarhelyi, E., Ebenbauer, B., & Peter, S. (2019). Acute effects of air pollution and noise from road traffic in a panel of young healthy adults. International Journal of Environmental Research and Public Health, 16(5), 788. https://doi.org/10.3390/ijerph16050788

Nikolopoulou, M., Baker, N., & Steemers, K. (2001). Thermal comfort in outdoor urban spaces: Understanding the human parameter. Solar Energy, 70(3), 227–235. https://doi.org/10.1016/S0038-092X(00)00093-1

Pinheiro, J. C., & Bates, D. M. (2000). Mixed-effects models in S and S-PLUS. Springer.

Quigley, K. S., et al. (2024). Publication guidelines for human heart rate and heart rate variability studies in psychophysiology—Part 1. Psychophysiology, 61, e14604. https://doi.org/10.1111/psyp.14604

Rodrigues, A. L., da Conceição, M. S. A., Ramusga, R. A. L., Lima Azevedo, C., & Morgado, P. (2026). The influence of urban context on emotions and bodily responses during walking. Journal of Urban Health, 103, 344–356. https://doi.org/10.1007/s11524-025-01051-1

Rupi, F., & Krizek, K. J. (2019). Visual eye gaze while cycling: Analyzing eye tracking at signalized intersections in urban conditions. Sustainability, 11(21), 6089. https://doi.org/10.3390/su11216089

Song, C., Joung, D., Ikei, H., Igarashi, M., Aga, M., Park, B.-J., Miwa, M., Takagaki, M., & Miyazaki, Y. (2013). Physiological and psychological effects of walking on young males in urban parks in winter. Journal of Physiological Anthropology, 32, 18. http://www.jphysiolanthropol.com/content/32/1/18

Song, C., Ikei, H., Igarashi, M., Miwa, M., Takagaki, M., & Miyazaki, Y. (2014). Physiological and psychological responses of young males during spring-time walks in urban parks. Journal of Physiological Anthropology, 33, 8. http://www.jphysiolanthropol.com/content/33/1/8

Stuyck, H., Dalla Costa, L., Cleeremans, A., & Van den Bussche, E. (2022). Validity of the Empatica E4 wristband to estimate resting-state heart rate variability in a lab-based context. International Journal of Psychophysiology, 182, 105–118. https://doi.org/10.1016/j.ijpsycho.2022.10.003

Zuo, J., Xia, H., Liu, S., & Qiao, Y. (2016). Mapping urban environmental noise using smartphones. Sensors, 16(10), 1692. https://doi.org/10.3390/s16101692


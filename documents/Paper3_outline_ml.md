## Psychophysiological comfort during active urban mobility: Environment and activity modulated physiological and perceived responses across diverse urban contexts

### Abstract

Urban active travel exposes people simultaneously to thermal, acoustic, visual and physical demands, yet these exposures are rarely studied together under naturalistic conditions. This repeated-measures field study examined psychophysiological comfort across cycling and walking phases in impervious urban and green environments in Brussels. Eleven participants completed route phases while wearable physiological, mobile eye-tracking and environmental data were synchronized to 10-second epochs. Linear mixed models tested environment and mode, literature-based tests examined whether noise amplifies thermal stress, and an additive mixed model estimated all exposures together, with repeated measures accounted for and Benjamini-Hochberg correction applied within hypothesis families. Green phases were associated with **lower skin temperature** and **larger pupil diameter** (pupil is illumination-sensitive). Walking versus cycling differed mainly in **ocular kinematics** (pupil, blink, fixation, gaze velocity, dispersion, and gaze position) in the locked phase-mean export. No heat-by-noise interaction survived false-discovery-rate correction in any literature-based H4 test on calibrated **ucm_SND_dBA**. **Five of 110** fitted questionnaire–physiology pairs reached q_FDR < 0.05 in H2 (`H2_Concordance.csv`; prespecified grid 18×26 = 468; BH within fitted pairs only); broad psychophysiological concordance was not supported. These findings indicate distinct physiological and visual-attention signatures across mobility contexts, while the small sample, model diagnostics and observational field exposures limit causal and population-level claims.

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

A repeated-measures field campaign was conducted in Brussels, Belgium, from **3 July to 27 August 2025**. Each participant completed four core outdoor mobility phases—cycling and walking in impervious urban corridors and in green-park corridors—plus a seated tram phase (descriptive only). Phase labels were BikeU, WalkU, WalkG, BikeG and Tram; tram was excluded from the primary 2 × 2 environment-by-mode contrasts.

Randomization of route order was planned. Participants completed questionnaires before and after each block; wearables and the trailing-researcher uCM backpack were checked at breaks. All streams were time-aligned to **UTC**. The design targets within-person comparisons of environment and mode under naturalistic active mobility; route location, workload, illumination and co-exposures co-vary with phase, so inferential models estimate associations, not single-stressor causation.

#### 2.1.1 Participants

Eighteen volunteers were tested (30 planned under ethics). Eleven with complete multi-sensor coverage on the four core phases were analysed (P4, P8–P17). Inclusion criteria were age 18–60 years, Brussels residence, ability to walk and cycle the study routes, and vision compatible with mobile eye tracking. Ethics application signed 28 May 2025 (approval reference from approved PDF). With n = 11 and four repeated phase cells, post hoc sensitivity (GPower, α = 0.05, power = 0.80, r = 0.50) suggested minimum detectable f ≈ 0.52. Using partial η² = f² / (1 + f²), that f is about 0.21, not 0.11.

The analysed sample comprises eleven participants (three women, eight men) aged 24–58 years (mean 35.2 years, SD 9.5), within the 18–60 year inclusion range. Self-reported height and weight yield BMI 20.5–33.0 kg·m⁻² (mean 23.8 kg·m⁻², SD 3.8): eight meet WHO normal weight (18.5–24.9 kg·m⁻²), two are overweight, and one has obesity. Project case-study labels classify eight as Fit and three as Not Fit and six as Active and five as Inactive (BMI- and daily-walking–based rules applied to the same eleven IDs). Clothing-questionnaire skin tone (Very fair, Fair, Medium, Olive, Brown) is mapped to Fitzpatrick types I–V by ascending shade (I, n = 1; II, n = 6; III, n = 2; IV, n = 1; V, n = 1; no type VI), covering the range where wrist photoplethysmography and optical heart rate on Empatica wearables may perform unevenly across pigmentation (Bent et al., 2020). Seven participants normally wear glasses; four report no vision correction.

Archived mixed models that enter those Fit/Not Fit and Active/Inactive labels as person-level factors are sensitivity analyses only; none of their coefficients survive Benjamini–Hochberg FDR control in the primary hypothesis families reported here.

### 2.2 Data preparation

Micrometeorology and context (uCM, 10 s): air temperature, humidity, mean radiant temperature, global horizontal irradiance, wind, A-weighted sound (dBA), GPS, UTCI and PET. Air quality and light: PM (Atmotube means), lux and colour temperature (LYS means). Scene openness (CamUp / Mapillary pipelines): Holmer annular sky view factor (SVF) for inferential models; tree view factor (TVF) and building view factor (BVF) computed alongside SVF but not co-entered with SVF or GVI in the combined-exposure model (Gong et al., 2018). Greenery: eye-level GVI (`gvi_50m`). Physiology (Empatica): EDA tonic/phasic, heart rate, HRV, wrist temperature. Vision (eye tracker): pupil, blink, fixation and gaze kinematics; proprietary `eyetracker_stress_composite` retained in the merge for exploration only. Perception: end-of-phase comfort and environmental-comfort items, STAI-6 item scores, PRS-11 subscale means (18 questionnaire columns in H2/H1–H3 exports).

Streams were synchronized, path-matched and quality-checked, aggregated to 10-second epochs, then—for the phase-mean analyses (H1–H3, H6 and the phase-mean combined-exposure model)—collapsed to participant × phase means on matched **eight-minute segments** (44 cells). Clearness index (k_t) was computed for solar QC; measured irradiance (`ucm_SUN_Gh`) entered models, not derived k_t. Transformations followed the locked normalization CSV.

Sound exposure (two streams): Primary loudness is the uCM calibrated A-weighted level `ucm_SND_dBA` (10 s medians on the backpack stream). Supplementary descriptors from phase WAVs include YAMNet source-type proportions/scores, Welch band energy shares, octave summaries, and spectral centroids (`Sound spectrum in field experiment.md`). These are not interchangeable with calibrated dBA; low-frequency band fractions can correlate with classifier “wind” labels and with apparent wind on the body during cycling—interpret as type/frequency structure, not as a second loudness standard.

Wind and microphones: Outdoor noise guidance (FHWA field measurement practice; ISO 1996-2:2017 measurement context; mobile mapping: Zuo et al., 2016) treats high wind as a measurement-condition issue even with windscreens. A 5 m/s apparent-wind exclusion on `ucm_WIND_AWS` was implemented as an optional sensitivity for supplementary sound models only (not a decibel correction). Literature (Cooper & Evans, 2015) cautions that a 5 m/s cutoff alone does not guarantee absence of wind-on-microphone artefacts. Windscreen type and microphone placement on the uCM should be stated from field notes in the final manuscript.

### 2.3 Statistical analysis

Primary inference used REML linear mixed models (Pinheiro & Bates, 2000) on participant × phase means to target within-person contrasts and limit pseudo-replication from epoch-level counts (Cnaan et al., 1997; Enders & Tofighi, 2007), with planned contrasts from estimated marginal means (Lenth, 2023) and questionnaire–physiology coupling via repeated-measures correlation (Bakdash & Marusich, 2017). Benjamini–Hochberg FDR (α = 0.05; Benjamini & Hochberg, 1995) was applied within prespecified hypothesis families. Unbalanced repeated-measures field designs follow ambulatory precedent (Rodrigues et al., 2026; Korkmaz et al., 2025).

1. **H1**:
   - Citation: Pinheiro & Bates (2000); Cnaan et al. (1997); Enders & Tofighi (2007); Lenth (2023); Benjamini & Hochberg (1995); Rodrigues et al. (2026); Korkmaz et al. (2025).
   - Model: Phase-mean REML LMM: `Y ~ PhaseID + (1 | ParticipantID)`; emmeans contrasts; BH FDR within **each** contrast over **26** physiological outcomes (H1.1 and H1.2 are **separate** families, n = 26 each—not one pooled family of 52). Questionnaire contrasts use **separate** BH families (18 items × contrast). Sensitivity: within-person z-scored (WPZ) repeats the same family structure. Optional 10 s / 60 s AR(1) (`H1_H3_timeseries.R`) does **not** include `grid_f`. In `H1_H3_Temporal_AR1_10s.csv`, 63 of 546 coefficient rows are flagged `rho > 0.95`, and the heart-rate phase terms have standard errors in the millions (the same three terms repeated). Do not quote those rows. Phase-mean H1 does not use this file (§3.9).
   - Description & sub-parts: **H1.1** BikeG − BikeU (green vs impervious, cycling). **H1.2** WalkG − WalkU (green vs impervious, walking). Primary grain: participant × phase means on matched 8 min segments (44 cells); 26 physiological and ocular outcomes. Script: `H1_H3_phaseavg.R`; exports `H1_H3_Contrasts.csv`, `H1_H3_Temporal_AR1.csv`.
2. **H2**:
   - Citation: Bakdash & Marusich (2017); Benjamini & Hochberg (1995).
   - Model: rmcorr; prespecified grid **18 × 26 = 468** pairs; one BH family over **fitted** pairs only (110 in current export when bout/participant rules pass; `H2_Concordance.csv`).
   - Description & sub-parts: Phase-mean concordance between comfort, environmental comfort, STAI-6 items, PRS-11 subscales and the same 26 outcomes used in H1. Fitted jointly with H1 in `H1_H3_phaseavg.R`; export `H2_Concordance.csv`.
3. **H3**:
   - Citation: Pinheiro & Bates (2000); Cnaan et al. (1997); Enders & Tofighi (2007); Lenth (2023); Benjamini & Hochberg (1995).
   - Model: Same phase-mean LMM shell as H1; emmeans; BH FDR within **each** mode contrast over **26** physiological outcomes (H3.1 and H3.2 separate families, n = 26 each); questionnaire and WPZ families as for H1.
   - Description & sub-parts: **H3.1** WalkU − BikeU (mode contrast, impervious urban). **H3.2** WalkG − BikeG (mode contrast, green). **Descriptive (not confirmatory):** difference-of-differences (BikeG − BikeU) − (WalkG − WalkU). Exports: `H1_H3_Contrasts.csv` (Hypothesis = H3); sensitivities as H1.
4. **H4**:
   - Citation: Moshammer et al. (2019); Song et al. (2013, 2014); Jin, Jin and Kang (2020); Rodrigues et al. (2026); Kraus et al. (2013); Benjamini & Hochberg (1995); Mansi et al. (2022); Chinazzo et al. (2019).
   - Model: Literature-derived tests in `H4_sound_literature_test.R` (not a preregistered protocol). BH FDR within each paper’s own test × outcome family. Screening rule in `METHODS_NOTES.md`: four papers included; Kraus excluded from that rule because the source model has no thermal term, while the Leq slope is still fitted and reported separately.
   - Description & sub-parts: Moshammer, Song (park-versus-street HRV sensitivity; no dBA term in the source), Jin (the heat × sound ANOVA), Rodrigues (noise-block mixed model). Kraus slope is extra. Heat × noise claims use Jin on `**ucm_SND_dBA**`. Jin’s ANOVA has no participant block, matching the source paper’s independent-respondent analysis; that is written on the test label.
   - **Not confirmatory H4:** Superseded Eq1–7 sensitivity pipelines (`Analysis_combined_timeseries.R`, `Analysis_combined_phaseavg.R`; archive names `H4_timeseries.R`, `H4_phaseavg.R`) differ by grain in predictors and VIF—exploratory **Analysis** only (§2.3 item 7), not literature-test H4.
5. **H5**:
   - Citation: Nikolopoulou et al. (2001); Fahy et al. (2025); Korkmaz et al. (2025); Gong et al. (2018); Pinheiro & Bates (2000); Benjamini & Hochberg (1995).
   - Model: Exploratory REML LMMs; separate FDR families from H1–H4. Hotspot design: fixed-route buffer cells (walk 11 m, bike 35 m). Script: `H5_hotspot_weather.R`.
   - Description & sub-parts: **H5.1 — implemented RH1 (hotspot thermal):** 10 s epochs → fixed-route buffer cells (walk 11 m, bike 35 m) → participant × hotspot × day medians; `median_center_Y ~ env_ucm_UTCI_c + hotspot_f + (1 | ParticipantID)` per PhaseID × outcome (`H5_hotspot_weather.R`). **RH2–RH4** (weather moderation, random slopes) are design notes only—not in locked exports. **H5.2 (view context):** same grain; centred outcome ~ UTCI + log10(lux + 1) + SVF, TVF, BVF **or Gong dominance class as a morphology predictor** (not hotspot identity); random intercept + AR(1) along route position.
6. **H6**:
   - Citation: Mansi et al. (2022); Chinazzo et al. (2019); Pinheiro & Bates (2000); Benjamini & Hochberg (1995).
   - Model: Prespecified exploratory coupling LMMs (`library/H6_coupling_core.R`); separate BH families **H6_A_env_physio** and **H6_B_psych_physio_given_env**. Not in H1–H4 or combined-exposure model.
   - Description & sub-parts: **H6-A:** Three env→physio models per outcome (9 tests): `out_{physio} ~ idx_{index} + PhaseID + (1 | ParticipantID)`, one index at a time. Indices are stress-oriented within-person *z* (WPZ): **thermal load** (`idx_thermal_load` ← `ucm_UTCI`); **acoustic load** (`idx_acoustic_load` ← `ucm_SND_dBA`); **restorative stress** (`idx_restorative_stress` ← equal-weight WPZ of inverted sky view, tree view, and 50 m GVI: `SVF`, `TVF`, `gvi_50m`). Outcomes: CSV-transformed tonic EDA and RMSSD plus equal-weight transparent ocular index (fixation rate, fixation duration, pupil diameter, blink duration). **H6-B:** Nine psych→physio models (env-adjusted): `out_{physio} ~ psy_{scale} + idx_thermal_load + idx_acoustic_load + PhaseID + (1 | ParticipantID)`, where `psy_{scale}` is WPZ of **PRS-11 fascination** (`questionnaire_prs11_fascination_mean_1_5`), **STAI tense** (`questionnaire_stai_tense_1_5`), or **acoustic comfort** (`questionnaire_acoustic_comfort_1_5`). **Grain:** phase means — `H6_stress_composite_phaseavg.R` (44 cells; **403 / 1378** exploratory FDR pairs—confirmatory manuscript cites this path only); 10 s — `H6_stress_composite_timeseries.R` (+ AR(1), exploratory; same epoch identifiability caveats as §3.9). Retired **H9** label: any five-participant or case-study **H9** export is **invalid** for full-cohort claims—use `**H6_stress_composite/`** on **n = 11** only (Appendix B).
7. **Analysis** (combined exposure model):
   - Citation: Mansi et al. (2022); Chinazzo et al. (2019); Rodrigues et al. (2026); Hamra & Buckley (2018); Marquardt (1970); James et al. (2013); Fox & Monette (1992); Pinheiro & Bates (2000); Benjamini & Hochberg (1995).
   - Model: Additive REML LMMs (main effects only); **not a hypothesis test**. Collinearity: VIF = 1/(1 − R²); Fox–Monette block VIF for PhaseSum route block. Screen max VIF < 10 on heart-rate complete cases per fitted grain (`Analysis_combined_gvif_summary_both_grains.csv`); drop predictors only where that grain fails screening.
   - Description & sub-parts: **Analysis — timeseries (10 s):** `Analysis_combined_timeseries.R`; one additive LMM per outcome × **Eq1–7**; BH *q* per fixed term within equation × 26 outcomes (separate families per contrast × outcome set in code—**not verified** for manuscript; §3.9); includes `ucm_SUN_Gh` and `gvi_50m` where listed; Eq3 primary at this grain (phase Eq3 excluded at max VIF 22.48). Current 10 s equations do **not** include `grid_f`. Do not describe them as rank-deficient for that reason. Quote coefficient rows only when the standard error and AR(1) flag are usable. **Analysis — phaseavg (phase means):** `Analysis_combined_phaseavg.R`; same Eq1–7 structure on participant × phase means (**182 / 182** fitted in audit; many low effective-df coefficient flags—**exploratory**, not confirmatory); omits SUN and GVI on all equations; Eq2 phase spec: `ucm_AIR_T_mid`, `ucm_AIR_RH`, `ucm_WIND_AWS` + **SVF** + PM2.5/lux/kelvin + PhaseSum (**no SND**; max VIF 9.29 vs 10 s Eq2 1.61). Shared non-thermal core: sound (10 s only), SVF, PM, lux/kelvin, PhaseSumWalkG/U/BikeG; thermal term rotates (UTCI, air T/RH/wind, MRT, HUMIDEX, PET; Eq6–7 swap PM fraction). Fixing aliasing requires a **new estimand** (e.g. phase contrasts without phase-specific grid FE, or spatial model without PhaseSum)—not dropping failed coefficients.

H4 paper-by-paper screening (included and excluded) is in `documents/H4_Screening_Literature_Guide.md`.

**H4 tests applied** (`H4_sound_literature_test.R`; adaptations, not replications; heat/noise observed not assigned):

| Source | Test as applied here | Sound term(s) tested |
| --- | --- | --- |
| Moshammer et al. (2019) | (a) Phase-level LMM per 8 cardiovascular outcomes: outcome ~ phase Leq per 5 dB + MET (+ air temperature) + (1 \| Participant); (b) road-vs-park analogue: paired WalkG − WalkU phase-mean contrast, unadjusted and adjusted for Δ air temperature | Per-5 dB Leq slope (2 specifications × 8 outcomes); WalkG − WalkU contrast (2 × 8) |
| Song et al. (2013, 2014) | Two-outcome sensitivity (SDNN, RMSSD) on the temperature-adjusted WalkG − WalkU contrast | Unadjusted paired difference; temperature-adjusted intercept |
| Jin, Jin & Kang (2020) | End-of-phase thermal and environmental comfort ~ dBA bin (≥ 65) × UTCI bin (> 26), participant-blocked ANOVA on 44 cells | dBA main effect; dBA × UTCI interaction |
| Rodrigues et al. (2026) | Trip-level mixed model with noise block (max, mean, SD of dBA, z-scored); REML Wald tests + BH-FDR | Each noise term |
| Kraus et al. (2013) | Phase-level Leq piecewise slopes at 65 dBA per 5 dB; MET and HR adjustment; outcomes HR, SDNN, LFnu, HFnu, LF/HF | Per 5 dB above and below 65 dBA |

FDR: Benjamini–Hochberg within each source’s prespecified sound-term family (not pooled across sources). Raw *p* and *q* in `output/statistical_analysis/results/H4_sound_literature_test/`.

Benjamini–Hochberg FDR (α = 0.05) was applied within prespecified families for H1–H6 (including separate H6-A and H6-B families and H4 families per literature source). The **Analysis** block fits additive combined-exposure LMMs (Eq1–7) with VIF screening; BH *q* per **fixed term within equation** across **26** outcomes (10 s and phase-mean grains separately)—descriptive association modelling, **not** a confirmatory hypothesis test; **10 s Analysis FDR row counts are not verified inference** (§3.9).

**H1/H3 primary physiological FDR (locked, `H1_H3_core.R`):** BH within **each** contrast over **26** outcomes—**two families of n = 26** (H1.1 vs H1.2; H3.1 vs H3.2), **not** one pooled family of 52. Inline comments that treat “26 × two contrasts” as a single family are inconsistent with this rule. **Sensitivity only:** pooling all 52 contrast rows into one BH family yields **11** H1 and **9** H3 FDR hits (e.g. WalkG − WalkU fixation duration *q* ≈ **0.045** pooled vs **0.051** under separate families)—does **not** replace the primary rule.

**FDR reporting in §3:** Main text uses **summary counts** plus **small example tables** for confirmatory H1–H3 (primary physiological families) and the **full five-row** H2 table. H4, H5, H6 composites, and Analysis coefficient screens are **too numerous** for main-text tables (full *q* in CSV exports / supplement)—**excluding verified epoch-level H1/H3 and Analysis 10 s FDR** (§3.9).

#### 2.3.1 Combined-exposure equations and VIF (heart-rate complete cases; `Analysis_combined_gvif_summary_both_grains.csv`): variance inflation factor VIF = 1/(1 − R²) for each fixed effect regressed on the others (Marquardt, 1970; James et al., 2013); the multi-column **PhaseSum** route block uses the Fox–Monette block VIF (Fox & Monette, 1992). We follow James et al. (2013) and screen on **maximum term (or block) VIF < 10** in the design actually fitted. We report that maximum at each grain in the table below; predictors were dropped **only where screening failed for that grain’s fitted model**, not globally across grains.

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

Phase-mean models (§2.3.1); estimates from `H1_H3_Contrasts.csv` (Hypothesis H1). Green phases were associated with **lower skin temperature** and with larger pupil diameter (pupil is illumination-sensitive).

Table 3.2. H1 FDR-significant phase-mean contrasts (primary physiological panel; `H1_H3_Contrasts.csv`, BH within **each** contrast over 26 outcomes).

| Tests (primary physio) | FDR q < 0.05 | Representative FDR hits (green − urban direction) |
| --- | --- | --- |
| 52 rows (2 contrasts × 26 outcomes; **two** BH families of n = 26) | **11** | Lower skin temperature (both modes); larger pupil diameter (both); shorter blink duration (both); longer fixation duration (WalkG−WalkU); lower gaze velocity and dispersion (WalkG−WalkU); gaze-centre shift (distance from center, BikeG−BikeU); larger eyelid aperture (BikeG−BikeU). Square-root tonic EDA contrasts did not survive FDR in primary physio families. Pooled 52-test sensitivity: still **11** H1 hits (not the primary rule; §2.3). |

*Sensitivity:* **33** q < 0.05 across **all** H1 rows in the export (primary + WPZ physio + questionnaire families)—report in supplement, not pooled with the primary physio count above.

| Outcome | Contrast | β | q~FDR~ |
| --- | --- | --- | --- |
| empatica_skin_temperature | BikeG − BikeU | −1.12 | 0.018 |
| empatica_skin_temperature | WalkG − WalkU | −1.16 | 0.009 |
| eyetracker_pupil_diameter_avg | BikeG − BikeU | 0.39 | 0.018 |
| eyetracker_pupil_diameter_avg | WalkG − WalkU | 0.95 | <0.001 |
| eyetracker_blink_duration_s | BikeG − BikeU | −0.009 | <0.001 |
| eyetracker_blink_duration_s | WalkG − WalkU | −0.013 | <0.001 |

### 3.3 H2 — psychophysiological concordance

Repeated-measures correlation (§2.3 item 2); export `H2_Concordance.csv` (**110** fitted pairs of prespecified 18×26 grid; one BH family over fitted rows). **Five** pairs reached q_FDR < 0.05—mainly PRS-11 total and pleasantness with ocular and skin outcomes—not broad concordance.

| Tests | FDR q < 0.05 |
| --- | --- |
| 110 fitted (468 prespecified) | **5** |

| Questionnaire | Physiological outcome | r~rmcorr~ | q~FDR~ |
| --- | --- | --- | --- |
| Pleasantness (1–5) | Blink duration | −0.66 | 0.002 |
| PRS-11 total (1–5) | Skin temperature | −0.63 | 0.002 |
| PRS-11 total (1–5) | Pupil diameter | 0.67 | 0.002 |
| PRS-11 total (1–5) | Blink duration | −0.77 | <0.001 |
| PRS-11 total (1–5) | Fixation duration | 0.56 | 0.029 |

### 3.4 H3 — mode within environment

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

### 3.5 H4 — sound and heat-plus-sound tests from previous literature

**Primary H4 (locked):** `H4_sound_literature_test.R` → `output/statistical_analysis/results/H4_sound_literature_test/` only—not archived `H4_phaseavg` / `H4_timeseries` Eq1–7 exports.

On primary `**ucm_SND_dBA**`, no Jin dBA × UTCI interaction survived FDR (0/2 perception items). Moshammer Leq slopes and Song walk sensitivity had **0** FDR hits. Rodrigues noise block: **1** FDR-adjusted hit (`NOISE_max` on `MIN_Values` under their retention rule). Kraus piecewise slopes: **0** FDR hits on five HRV outcomes. Supplementary sound-class substitutions in the same pipeline are exploratory and not interpreted as calibrated loudness.

Full counts: `output/statistical_analysis/results/H4_sound_literature_test/SUMMARY_sound_tests_p_and_FDR.csv` (filter `sound_variable == ucm_SND_dBA (primary)` for manuscript claims).

### 3.6 H5 — shared places and local thermal stress (exploratory)

**Implemented RH1 only** (`H5_hotspot_weather.R`; `run_rh1_only = TRUE`): fixed-route **corridor-buffer** cells from local GPKG (walk **11 m**, bike **35 m**)—not 20 m GPS arc bins, k-means, or HDBSCAN IDs. Model `median_center_Y ~ env_ucm_UTCI_c + hotspot_f + (1|ParticipantID)` by PhaseID × outcome on participant × hotspot × day medians. In `H5_RH1_hotspot_FDR_all_tests.csv`, **640** contrasts have `FDR_significant = TRUE` (**981** raw p < 0.05; BH within outcome × phase)—exploratory family separate from H1–H4. **RH2–RH4** are not locked. `H5_hotspot_cell_audit.csv` reports `**n_participant_hotspot_with_2plus_dates = 0`**—no verified same-person multi-day hotspot revisit for moderation claims.

**H5.2 view models:** dominance class and continuous SVF/TVF/BVF as predictors (`H5_view_model_coefficients.csv`)—distinct from hotspot bin identity.

### 3.7 H6 — composite load concordance (exploratory)

Prespecified coupling LMMs (§2.3 item 6) and stress-composite rmcorr (`H6_stress_composite/`). Pairwise composite concordance: **403** of **1,378** fitted pairs with q_FDR < 0.05 (one exploratory family). Composites do not enter H1–H4 or the combined-exposure block.

### 3.8 Combined-exposure model (not a hypothesis test)

Additive Eq1–7 LMMs at 10 s and at phase means (§2.3 item 7). Current exports: **151 / 2158** coefficient rows with q < 0.05 at 10 s (`Analysis_combined_timeseries_hypothesis.csv`); **45 / 1820** at phase means (`Analysis_combined_phaseavg_Heat_Noise_Exposures.csv`). Phase Eq3 was not used (maximum VIF 22.48). The 10 s Eq3 was kept.

## 4 Discussion

### 4.1 H1 — green versus impervious phases

Within each mode, green phases were associated with lower wrist skin temperature and larger pupil diameter, plus shorter blinks. Walking in green also showed longer fixations and slower, less dispersed gaze; cycling in green showed a shift in gaze position and a larger eyelid opening. Eleven of 52 primary physiological contrasts met the false-discovery-rate threshold. Tonic electrodermal activity did not. Lower skin temperature is a thermal contrast, not evidence of restoration (Boucsein et al., 2012). Pupil size tracks light as well as arousal (Mahanama et al., 2021). Hypothesis 1 is supported for skin temperature and several gaze measures, not for a general improvement in autonomic comfort.

### 4.2 H2 — perception and physiology

Five of 110 fitted pairs remained after correction. They link pleasantness and perceived restoration with blink timing, skin temperature, pupil size, and fixation duration. Heart rate, heart-rate variability, and tonic electrodermal activity did not show that pattern. Questionnaires were taken at the end of the phase, so they are not simultaneous with the sensor means. Hypothesis 2, broad concordance, is not supported.

### 4.3 H3 — walking versus cycling

All eight primary physiological contrasts that survived correction were ocular: gaze speed and spread, blink duration, fixation duration, gaze position, and pupil size. Skin temperature, tonic electrodermal activity, and fixation rate did not. Walking and cycling differ in speed and in how much the rider must look ahead (Rupi & Krizek, 2019), so these gaze differences are not a comfort ranking. Hypothesis 3, that cycling would be more compromised than walking, is not established.

### 4.4 H4 — heat and noise

On calibrated A-weighted sound, Jin’s heat-by-noise test was not significant after correction for either comfort item. Moshammer, Song, and Kraus adaptations had no corrected hits on that loudness measure. Rodrigues’ noise block retained one noise association under that paper’s rule. It is not a heat-by-noise interaction. Song’s source comparison has no sound-level term. Jin’s test has no participant effect, so its *p*-values can look too small for repeated phases. Sound and heat were whatever the route produced. Hypothesis 4 is not supported. That is an absence of evidence in this design, not proof that noise never affects thermal discomfort.

### 4.5 H5 — places along the route

Corridor cells (about 11 m on foot and 35 m by bicycle) produced many corrected place-level tests (640 of the grid). Those tests are a large exploratory family, not a short list of confirmed hotspots. No participant was recorded at the same cell on two calendar days, so a same-person change from one day to the next cannot be discussed. View factors and dominance class describe the cell. They do not define it.

### 4.6 H6 — composite indices

Of 1,378 fitted composite pairs, 403 met the corrected threshold. The composites share variables, so that count is not 403 separate discoveries. Six of nine models that linked selected questionnaire scores to physiology after thermal and acoustic adjustment did not converge. The pairs that did fit do not replace the outcome-specific tests in H1–H4.

### 4.7 Combined-exposure analysis

The additive models are a description of co-occurring exposures, not a hypothesis test. At 10 seconds, 151 of 2,158 coefficient rows had q < 0.05. At phase means, 45 of 1,820 did. One phase-mean specification was dropped because the maximum variance inflation factor was 22.48. These counts are not interpreted term by term in the main text.

### 4.8 Limitations

Eleven people, one city, and one summer (3 July to 27 August 2025). Environment and mode are tied to place, order, light, and effort. Randomization of route order was planned. Wrist and eye-tracking signals are affected by motion and contact. Apparent wind mixes ambient wind with movement. No causal claim is made.

## 5 Conclusion

Urban active-mobility exposure produced distinct physiological and visual-attention profiles across environment and travel mode. Green phases differed from impervious urban phases in **skin temperature** and **pupil diameter**; walking differed from cycling mainly in **ocular kinematics** in the primary phase-mean models.

The primary evidence supports context-dependent psychophysiological associations, not a universal ranking of green versus urban or walking versus cycling. **Broad physiological-perceptual concordance was not confirmed** (five of 110 fitted pairs q_FDR < 0.05), and no heat-noise amplification survived FDR correction in any literature-based test. Larger studies with explicit temporal correlation structures are needed.

## 6 References

Boucsein, W., et al. (2012). Publication recommendations for electrodermal measurements. Psychophysiology, 49(8), 1017-1034. https://doi.org/10.1111/j.1469-8986.2012.01384.x

Chinazzo, G., Wienold, J., & Andersen, M. (2019). Daylight affects human thermal perception. Scientific Reports, 9, 13690. https://doi.org/10.1038/s41598-019-48963-y

Evans, K. M., Jacobs, R. A., Tarduno, J. A., & Pelz, J. B. (2012). Collecting and analyzing eye-tracking data in outdoor environments. Journal of Eye Movement Research, 5(2), Article 6.

Fahy, J. C., Bachofen, C., Camponovo, R., Gallinelli, P., & Schlaepfer, M. A. (2025). Beyond land surface temperature: Identifying areas of daytime thermal discomfort in cities by combining remote sensing and field measurements. Urban Climate, 61, 102460. https://doi.org/10.1016/j.uclim.2025.102460

Mahanama, B., et al. (2021). Eye movement and pupil measures: A review. Frontiers in Computer Science, 3, 733531. https://doi.org/10.3389/fcomp.2021.733531

Mansi, S. A., Pigliautile, I., Arnesano, M., & Pisello, A. L. (2022). A novel methodology for human thermal comfort decoding via physiological signals measurement and analysis. Building and Environment, 222, 109385. https://doi.org/10.1016/j.buildenv.2022.109385

Nikolopoulou, M., Baker, N., & Steemers, K. (2001). Thermal comfort in outdoor urban spaces: Understanding the human parameter. Solar Energy, 70(3), 227-235. https://doi.org/10.1016/S0038-092X(00)00093-1

Quigley, K. S., et al. (2024). Publication guidelines for human heart rate and heart rate variability studies in psychophysiology - Part 1. Psychophysiology, 61, e14604. https://doi.org/10.1111/psyp.14604

Rupi, F., & Krizek, K. J. (2019). Visual eye gaze while cycling: Analyzing eye tracking at signalized intersections in urban conditions. Sustainability, 11(21), 6089. https://doi.org/10.3390/su11216089

Stuyck, H., Dalla Costa, L., Cleeremans, A., & Van den Bussche, E. (2022). Validity of the Empatica E4 wristband to estimate resting-state heart rate variability in a lab-based context. International Journal of Psychophysiology, 182, 105-118. https://doi.org/10.1016/j.ijpsycho.2022.10.003

Cooper, J., & Evans, T. (2015). Microphone wind speed limits during wind farm noise measurements. Proceedings of the Australian Acoustical Society Conference, Hunter Valley. (Wind-on-microphone limits; 5 m/s exclusion not sufficient alone.)

Zuo, J., Xia, H., Liu, S., & Qiao, Y. (2016). Mapping urban environmental noise using smartphones. Sensors, 16(10), 1692. https://doi.org/10.3390/s16101692 (Mobile noise mapping; windscreens; avoid measurement above ~5 m/s.)

ISO 1996-2:2017. Acoustics — Description, measurement and assessment of environmental noise — Part 2: Determination of sound pressure levels. (Outdoor measurement conditions; local preview in Experiment papers.)

Federal Highway Administration. Noise barrier design / field measurement guidance. https://www.fhwa.dot.gov/environment/noise/ (Windscreens; do not measure when wind at microphone exceeds ~5 m/s.)

Gong, F.-Y., et al. (2018). Mapping sky, tree, and building view factors of street canyons. Building and Environment, 134, 155–167. https://doi.org/10.1016/j.buildenv.2018.02.042

Gong, Z., Ma, Q., Kan, C., & Qi, Q. (2019). Classifying street spaces with street view images for a spatial indicator of urban functions. Sustainability, 11(22), 6424. https://doi.org/10.3390/su11226424


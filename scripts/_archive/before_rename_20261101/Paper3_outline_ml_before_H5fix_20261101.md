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

H1. Participants show better physiological **and perceived comfort** in green than in impervious areas.

H2. Physiological and perceived responses are concordant.

H3. Psychophysiological comfort is more compromised during cycling than during walking.

H4. Noise and traffic-related sound amplify thermal discomfort.

H5. Within-person physiological responses change with shared places along the route and with local thermal stress.

H6. Composite indices of environmental, physiological, and visual load are concordant within person.

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

Micrometeorology and context (uCM, 10 s): air temperature, humidity, mean radiant temperature, global horizontal irradiance, wind, A-weighted sound (dBA), GPS, UTCI and PET. Air quality and light: PM (Atmotube means), lux and colour temperature (LYS means). Scene openness (CamUp / Mapillary pipelines): Holmer annular sky view factor (SVF) for inferential models; tree view factor (TVF) and building view factor (BVF) computed alongside SVF but not co-entered with SVF or GVI in the combined-exposure model (Gong et al., 2018). Greenery: eye-level GVI (`gvi_50m`). Physiology (Empatica): EDA tonic/phasic, heart rate, HRV, wrist temperature. Vision (eye tracker): pupil, blink, fixation and gaze kinematics; proprietary `eyetracker_stress_composite` retained in the merge for exploration only (§9). Perception: STAI-6, PRS-11, comfort, pleasantness and multi-item environmental stressor ratings (temperature, lighting, noise, air quality, crowding).

Streams were synchronized, path-matched and quality-checked, aggregated to 10-second epochs, then—for the phase-mean analyses (H1–H3, H6 and the phase-mean combined-exposure model)—collapsed to participant × phase means on matched **eight-minute segments** (44 cells). Clearness index (k_t) was computed for solar QC; measured irradiance (`ucm_SUN_Gh`) entered models, not derived k_t. Transformations followed the locked normalization CSV.

Sound exposure (two streams): Primary loudness is the uCM calibrated A-weighted level `ucm_SND_dBA` (10 s medians on the backpack stream). Supplementary descriptors from phase WAVs include YAMNet source-type proportions/scores, Welch band energy shares, octave summaries, and spectral centroids (`Sound spectrum in field experiment.md`). These are not interchangeable with calibrated dBA; low-frequency band fractions can correlate with classifier “wind” labels and with apparent wind on the body during cycling—interpret as type/frequency structure, not as a second loudness standard.

Wind and microphones: Outdoor noise guidance (FHWA field measurement practice; ISO 1996-2:2017 measurement context; mobile mapping: Zuo et al., 2016) treats high wind as a measurement-condition issue even with windscreens. A 5 m/s apparent-wind exclusion on `ucm_WIND_AWS` was implemented as an optional sensitivity for supplementary sound models only (not a decibel correction). Literature (Cooper & Evans, 2015) cautions that a 5 m/s cutoff alone does not guarantee absence of wind-on-microphone artefacts. Windscreen type and microphone placement on the uCM should be stated from field notes in the final manuscript.

### 2.3 Statistical analysis

All primary tests used restricted maximum likelihood mixed models or repeated-measures correlation with Benjamini–Hochberg false-discovery-rate control within prespecified families (α = 0.05). Estimates are reported as within-person associations; 10-second epoch counts were not treated as independent observations in primary inference.

#### 2.3.1 H1 — environment within mode

H1 (green vs impervious urban): Phase-mean linear mixed model `Y ~ PhaseID + (1 | ParticipantID)` fitted to 26 physiological and ocular outcomes; planned contrasts BikeG − BikeU and WalkG − WalkU (emmeans). Sensitivity: within-person z-scored outcomes on phase means; optional 10 s / 60 s AR(1) temporal models.

#### 2.3.2 H2 — psychophysiological concordance

H2 (psychophysiological concordance): Repeated-measures correlation (Bakdash & Marusich, 2017) across four questionnaires and 26 physiological phase means (104 pairs; one FDR family).

#### 2.3.3 H3 — mode within environment

H3 (walking vs cycling): Same phase-mean mixed-model shell as H1; planned contrasts WalkU − BikeU and WalkG − BikeG; difference-of-differences (BikeG − BikeU) − (WalkG − WalkU) reported descriptively.

#### 2.3.4 H4 — sound and heat-plus-sound tests from previous literature

H4 (noise amplifies thermal discomfort) is tested by applying the test designs of previous heat–noise and noise–physiology studies to our field data (`scripts/statistical_analysis/H4_sound_literature_tests.R`; input `merged_all_11participants_8min.csv`, 11 participants, 4 core phases, 26 physiological outcomes). These are field adaptations, not exact replications: exposures were observed, not assigned, so heat and noise conditions are defined by cut-offs (heat = UTCI > 26 °C, noise = dBA ≥ 65) or by the nearest source level.

| Source | Test as applied here | Sound term(s) tested |
| --- | --- | --- |
| Jo et al. (2019) | Paired one-sided t-tests, green vs urban phases, on HR, ln HF and ln LF/HF | Green vs urban (6 tests) |
| Yousefinezhad et al. (2026) | Four conditions (Control, Heat, Noise, Heat+Noise); RM-ANOVA (Mauchly, Greenhouse–Geisser) or Friedman; Wilcoxon post hoc counted only when omnibus p < 0.05 | Condition differences |
| Dehghan et al. (2017) | Friedman test across the same four conditions | Condition differences |
| Molaeifar et al. (2020) | Paired t-test, Hot+Loud vs Cool+Quiet | Condition difference |
| Tohidi et al. (2025) | Two-way repeated-measures ANOVA (Type II) on participant cell means; air temperature 20/25/30 °C × noise 55/65/75/85 dBA (nearest level) | Noise main effect; temperature × noise |
| Abbasi et al. (2020) | Same design at 22/26/30 °C × 55/75 dBA | Noise main effect; temperature × noise |
| Rodrigues et al. (2026) | Trip-level mixed model with a noise block (mean, max and SD of dBA, z-scored) on trip mean and trip SD outcomes; REML, Wald tests | Each noise term |
| Kraus et al. (2013) | One non-overlapping 5-min window per participant × phase (n = 44); Leq piecewise at 65 dBA per 5 dB; MET and HR adjustment for HRV; outcomes HR, SDNN, LFnu, HFnu, LF/HF | Per 5 dB above and below 65 dBA |

FDR: Benjamini–Hochberg within each test family (one source test across its 26 outcomes; 5 for Kraus), sound terms only, not pooled across sources. Raw p and q are both reported. Not testable with these data: Li 2025 (hypertension), Chen 2007 (hearing threshold), Bidel 2022 (EMG), Jafari 2021 (cortisol, blood pressure), He 2025 (90 dB) and the 95 dB levels of Molaeifar. Adaptation details are in `METHODS_NOTES.md`.

Outputs: `output/statistical_analysis/results/H4_sound_literature_tests/` (`SUMMARY_sound_tests_p_and_FDR.csv`, `9_FDR_all_tests_p_and_q.csv`, `METHODS_NOTES.md`, `run_manifest.csv`).

#### 2.3.5 H5 — shared places and local thermal stress (exploratory)

Grain: 10 s epochs or GPS-defined route bins (shared hotspots where multiple participants traverse the same segment within a phase). Model: linear mixed models with reactivity outcomes (deviation from within-phase or campaign baseline), visual morphology (dominance classes or continuous SVF/TVF/BVF), person-centred thermal and acoustic load, optional day-level weather, and participant random intercepts. FDR: separate from H1–H4, scoped per analysis block (e.g. outcomes × phase × hotspot contrasts). Operational definitions and staged sensitivities are in §7–§8.

#### 2.3.6 H6 — composite load concordance (exploratory)

Grain: participant × phase means on the matched **eight-minute merge**. Model: repeated-measures correlation among stress-oriented composites—environmental (thermal, acoustic, air-quality, light, morphology groups and single factors), physiological (Empatica and ocular channels with stress-oriented within-person z-scores), and proprietary or transparent ocular stress indices. FDR: one exploratory Benjamini–Hochberg family over all fitted composite pairs. No composite enters the H1–H4 tests or the combined-exposure model (§9).

Implementation: `scripts/statistical_analysis/H6_stress_composite.R` (engine `library/H6_stress_composite_core.R`); outputs under `output/statistical_analysis/results/H6_stress_composite/`.

#### 2.3.7 Combined-exposure model (not a hypothesis test)

All measured exposures enter one additive multivariable mixed model per outcome, so each exposure's association is reported adjusted for the others. No hypothesis is tested here.

Primary: 10 s time series (`scripts/statistical_analysis/Analysis_combined_timeseries.R`); exposures centred within bout and standardised; random intercepts for participant and phase within participant; AR(1) within bout; CR2 inference. Eq1: Y ~ UTCI + dBA + solar irradiance (`ucm_SUN_Gh`) + SVF + PM2.5 + lux + colour temperature + GVI + phase (sum-to-zero). Eq2–Eq6 change only the heat form or PM size: Eq2 air temperature (mid height) + RH + apparent wind + MRT; Eq3 HUMIDEX; Eq4 PET; Eq5 UTCI with PM1; Eq6 UTCI with PM10.

Sensitivity: participant × phase means (44 cells; `scripts/statistical_analysis/Analysis_combined_phaseavg.R`) with the same six equations, but without solar irradiance and GVI. Both scripts share `library/Analysis_combined_core.R`; design VIF screening (limit 10) without automatic term deletion.

FDR: Benjamini–Hochberg per term within each equation across 26 outcomes (q), plus q_equation pooling all non-intercept terms within one equation; no correction across equations.

Heat × dBA interactions were removed on 1 Nov 2026. They had been tested in the earlier interaction model and were null after FDR (§3.8), so they are reported once as a tested null and not carried forward.

Outputs: `output/statistical_analysis/results/Analysis_combined_timeseries/` and `.../Analysis_combined_phaseavg/` (files prefixed `Analysis_combined_*`). The time-series script must run first, because the phase-mean script reads its filtration results.

#### 2.3.8 Restoration, lag and sound-source analyses (formerly H6; not a hypothesis)

The former H6 script `H6_exploratory.R` was retired on 31 Oct 2026 (archived as `scripts/_archive/H6_exploratory_final_20261031.R`) and is no longer a hypothesis. Its parts now run elsewhere: the sign-flip check (former H6.1a) and restoration concordance (former H6.1b, section 5a; `H2_Restoration_Concordance_DeltaPRS.csv`) in `library/H1_H3_core.R`; lagged first-difference profiles (former H6.2) and sound-source slopes adjusted for dBA, UTCI and lux (former H6.3) as `Analysis_combined_timeseries.R --lagdiff-only` and `--sourceadj-only` (outputs `Analysis_combined_timeseries_lagdiff/` and `Analysis_combined_timeseries_sourceadj/`). Earlier outputs remain in `output/statistical_analysis/results/H5_exploratory/` (`H6_*.csv`, `H6_README.txt`). FDR: one family per analysis block, not merged with H1–H6.

#### 2.3.9 Archived sound pipelines (superseded 1 Nov 2026)

The sound-substitution pipelines (`H4_timeseries_sound.R`, `H4_phaseavg_sound.R`, `library/H4_sound_core.R`), the earlier exact-literature scripts (`H4_Sound_exactliterature.R`, `H4_Sound_exactliterature_C_tempadj.R`) and the 24 `Jo_*.R` scripts were archived to `scripts/_archive/superseded_sound_20261101/`, with outputs in `output/statistical_analysis/results/archive/superseded_sound_20261101/`. They are not part of the current analysis; their results are kept for the record in §3.11. The 22 sound-class features they used (YAMNet categories and spectral descriptors) are currently unused; testing sound type at equal dBA is a candidate separate analysis (work diary, 1 Nov 2026). `H4_minimal_utci_dba.R`, listed in earlier drafts, is not present in the project.

Wind QC in those pipelines excluded 10 s windows with `ucm_WIND_AWS` > 5 m/s (FHWA/state DOT field practice, Zuo et al., 2016; Cooper & Evans, 2015 as caveat); 2110 of 2112 core windows were retained. Method memo (local): **`D:\Pranav\docker\Paper3_Github\Experiment papers\Wind Correction for sound - .md`**.

## 3 Results

### 3.1 Microclimate of the green and impervious routes

Participant-weighted phase profiles on the merged 10-second dataset: UTCI/PET, sound, radiation, PM and wind across BikeU, WalkU, BikeG, WalkG (Tram descriptive only). These are the measured exposures for the response contrasts in §3.2–§3.8. Precedent for a walking-transect mixed model of PET: Fahy et al. (2025) — local climate zone and solar energy, not land-surface temperature, explained daytime PET in Geneva; open lawns were hotter than shade under trees or compact streets (**`D:\Pranav\docker\Paper3_Github\Experiment papers\Urban Climate Literature\ucm paper - urban walk LCZ.pdf`**).

### 3.2 H1 — environment within mode

Phase-mean models (§2.3.1); estimates from `H1_Contrasts.csv`. Green phases were associated with **lower square-root-transformed tonic EDA** and skin temperature and with larger pupil diameter (pupil is illumination-sensitive).

Table 3.2. H1 FDR-significant phase-mean contrasts (primary analysis units; `H1_Contrasts.csv`, BH within 26 outcomes × contrast family).

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

### 3.3 H2 — psychophysiological concordance

Repeated-measures correlation (§2.3.2); estimates from `H2_Physio_Psycho_Concordance.csv`. Within-person concordance was weak after FDR correction at participant-phase means (five q < 0.05 pairs in the locked export). Associations are not interpreted as causation.

Table 3.3. H2 FDR-significant psychophysiological pairs (`H2_Physio_Psycho_Concordance.csv`, one BH family over 104 pairs).

| Tests | FDR q < 0.05 | |
| --- | --- | --- |
| 104 questionnaire × physio pairs | 5 | |

| Questionnaire | Physiological outcome | r~rmcorr~ | q~FDR~ |
| --- | --- | --- | --- |
| Pleasantness (1–5) | Blink duration | −0.66 | 0.002 |
| PRS-11 total (1–5) | Skin temperature | −0.63 | 0.002 |
| PRS-11 total (1–5) | Pupil diameter | 0.67 | 0.002 |
| PRS-11 total (1–5) | Blink duration | −0.77 | <0.001 |
| PRS-11 total (1–5) | Fixation duration | 0.56 | 0.029 |

### 3.4 H3 — mode within environment

Same phase-mean model shell as H1 (§2.3.3); estimates from `H3_Contrasts.csv`. Walking versus cycling differed in **tonic EDA, skin temperature, fixation rate** and gaze velocity. Results are reported as planned contrasts, not as a global ranking of mode comfort.

Table 3.4. H3 FDR-significant phase-mean contrasts (primary analysis units; `H3_Contrasts.csv`, BH within 26 outcomes × contrast family).

| Tests (primary) | FDR q < 0.05 | Representative FDR hits (walk − bike) |
| --- | --- | --- |
| 52 (26 outcomes × WalkU−BikeU and WalkG−BikeG) | 8 | Gaze/eye-tracking: pupil, blink duration, fixation duration, gaze velocity, dispersion, distance from center, gaze centrality (mode-specific contrasts as in CSV). Tonic EDA, skin temperature and fixation rate did not reach FDR q < 0.05 in this export. |

| Outcome | Contrast | β | q~FDR~ |
| --- | --- | --- | --- |
| eyetracker_gaze_velocity | WalkU − BikeU | 609.0 | <0.001 |
| eyetracker_blink_duration_s | WalkU − BikeU | 0.015 | <0.001 |
| eyetracker_blink_duration_s | WalkG − BikeG | 0.011 | <0.001 |
| eyetracker_pupil_diameter_avg | WalkU − BikeU | −0.46 | 0.004 |
| eyetracker_fixation_duration_s | WalkU − BikeU | −0.034 | <0.001 |

### 3.5 H4 — sound and heat-plus-sound tests from previous literature

H4 was not supported. No heat × noise interaction survived FDR in any test (Tohidi temperature × noise 0/26; Abbasi temperature × noise 0/26; Yousefinezhad Heat+Noise vs Heat 0/5 even at p < 0.05). A few sound main effects survived FDR: Rodrigues trip-mean noise (fixation rate and gaze distance from centre, both higher on louder trips) and the Tohidi noise main effect (skin temperature and pupil diameter). Hits from the four-condition comparisons (Yousefinezhad omnibus, Dehghan, Molaeifar) compare combined heat-and-noise conditions, mainly on skin temperature, so they cannot be attributed to sound. Kraus per 5 dB above 65 dBA: 3 of 5 at p < 0.05 (LFnu, HFnu, LF/HF), 0 of 5 after FDR.

Table 3.5. H4 literature tests — p and FDR counts per test family (`SUMMARY_sound_tests_p_and_FDR.csv`, 1 Nov 2026 run; currently in `output/statistical_analysis/results/archive/before_rename_20261101/Sound_previous_literature_tests/` until the renamed script is rerun).

| Source | Test | Tests | p < 0.05 | q < 0.05 | Outcomes with q < 0.05 |
| --- | --- | --- | --- | --- | --- |
| Jo 2019 | paired one-sided t (green vs urban) | 6 | 0 | 0 | — |
| Yousefinezhad 2026 | global 4-condition test | 26 | 5 | 3 | skin_temperature; blink_duration_s; gaze_dispersion |
| Yousefinezhad 2026 | Wilcoxon Heat vs Control | 5 | 2 | 0 | — |
| Yousefinezhad 2026 | Wilcoxon Noise vs Control | 5 | 2 | 0 | — |
| Yousefinezhad 2026 | Wilcoxon Heat+Noise vs Control | 5 | 3 | 0 | — |
| Yousefinezhad 2026 | Wilcoxon Noise vs Heat | 5 | 1 | 0 | — |
| Yousefinezhad 2026 | Wilcoxon Heat+Noise vs Heat | 5 | 0 | 0 | — |
| Yousefinezhad 2026 | Wilcoxon Heat+Noise vs Noise | 5 | 5 | 0 | — |
| Dehghan 2017 | Friedman 4 conditions | 26 | 5 | 1 | skin_temperature |
| Molaeifar 2020 | paired t Hot+Loud vs Cool+Quiet | 26 | 5 | 3 | skin_temperature; pupil_diameter_avg; gaze_dispersion |
| Tohidi2025 | two-way ANOVA noise main effect | 26 | 4 | 2 | skin_temperature; pupil_diameter_avg |
| Tohidi2025 | two-way ANOVA temperature x noise | 26 | 0 | 0 | — |
| Abbasi2020 | two-way ANOVA noise main effect | 26 | 2 | 0 | — |
| Abbasi2020 | two-way ANOVA temperature x noise | 26 | 0 | 0 | — |
| Rodrigues 2026 | trip mean noise_max_z | 26 | 2 | 0 | — |
| Rodrigues 2026 | trip mean noise_mean_z | 26 | 2 | 2 | fixation_rate; distance_from_center |
| Rodrigues 2026 | trip mean noise_sd_z | 26 | 1 | 0 | — |
| Rodrigues 2026 | trip sd noise_max_z | 26 | 1 | 0 | — |
| Rodrigues 2026 | trip sd noise_mean_z | 26 | 5 | 0 | — |
| Rodrigues 2026 | trip sd noise_sd_z | 26 | 0 | 0 | — |
| Kraus 2013 | L_above65_per5 | 5 | 3 | 0 | — |
| Kraus 2013 | L_below65_per5 | 5 | 0 | 0 | — |

### 3.6 H5 — shared places and local thermal stress (exploratory)

Shared 20 m route hotspots and RH1 hotspot-day models (§2.3.5; `output/statistical_analysis/results/H5_exploratory/`). `median_center_Y ~ env_ucm_UTCI_c + hotspot_f + (1|ParticipantID)`, fit separately by PhaseID × outcome, yielded 294 FDR-significant `hotspot_f` contrasts in the locked primary panel (`H5_RH1_hotspot_FDR_summary.csv`; BH within outcome × phase; coefficient listing in `H5_RH1_hotspot_FDR_locked_family_significant.csv`). RH2–RH4 remain paused in the current export.

Table 3.6. H5 RH1 hotspot `hotspot_f` FDR (`H5_RH1_hotspot_FDR_summary.csv`; locked family within outcome × PhaseID).

| `hotspot_f` tests (all phases/outcomes) | Raw p < 0.05 | FDR q < 0.05 (locked primary panel) | Export rows in `H5_RH1_hotspot_FDR_locked_family_significant.csv` |
| --- | --- | --- | --- |
| 5605 | 981 | 294 | 83 coefficient rows (subset table for manuscript) |

| PhaseID | Outcomes with ≥1 locked FDR hotspot contrast (count of export rows) |
| --- | --- |
| WalkU | skin temperature (19), EDA tonic (10), pupil change rate (26) |
| WalkG | skin temperature (23), pupil change rate (3) |
| BikeU | skin temperature (1), EDA tonic (1) |

Footnote: SVF-class sensitivity (`H5_hotspot_weather_svfclasses.R`) is not in the primary `H5_exploratory/` export tree used here.

### 3.7 H6 — composite load concordance (exploratory)

Repeated-measures correlation among stress-oriented composites (§2.3.6; `H6_stress_composite/`). 403 of 1,378 fitted composite pairs reached q_FDR < 0.05 in one Benjamini–Hochberg family over 55 composites (`H6_run_manifest.csv`; 1,485 pairs attempted). Pairwise detail is in §9; composites do not enter the H1–H4 tests or the combined-exposure model.

Table 3.7. H6 pairwise rmcorr FDR summary (`H6_pairwise_rmcorr.csv`, `H6_run_manifest.csv`).

| Metric | Value |
| --- | --- |
| Composites | 55 |
| Pairs attempted / fitted | 1485 / 1378 |
| FDR q < 0.05 | 403 |

| Domain_X → Domain_Y (pair category) | FDR-significant pairs |
| --- | --- |
| environmental × environmental | 101 |
| physiological × environmental | 100 |
| environmental × environmental_group | 68 |
| physiological × physiological | 53 |
| physiological × environmental_group | 31 |
| environmental × ocular_proprietary | 12 |
| physiological × ocular_proprietary | 12 |
| All other cross-domain cells | 26 combined |

### 3.8 Combined-exposure model (not a hypothesis test)

Additive-model results are pending the rerun of `Analysis_combined_timeseries.R` and then `Analysis_combined_phaseavg.R` (interaction terms removed 1 Nov 2026). In the earlier interaction-model export, UTCI × dBA passed FDR for 0 of 104 phase-mean tests, which is why the interaction is reported once as a tested null and not carried forward. Sound p < 0.05 counts in that export were at chance level (phase means 17 of 390, time series 27 of 390, with about 20 expected by chance; 0 with q < 0.05).

Table 3.8. Earlier interaction-model phase-mean export (seven equations; archived in `output/statistical_analysis/results/archive/before_rename_20261101/H4_phaseavg/`, files `H4_phaseavg_coefficients.csv` / `FDR_summary_phaseavg_by_outcome.csv`; to be replaced after the additive rerun; BH per term within equation across 26 outcomes).

| Term family | Coefficient tests (non-intercept, tested) | FDR q < 0.05 | Representative findings |
| --- | --- | --- | --- |
| UTCI × `ucm_SND_dBA` (`ucm_UTCI:ucm_SND_dBA`) | 104 (26 outcomes × 4 Eq1-style interaction slots) | 0 | No thermal×sound interaction survived FDR in the locked phase-mean export. |
| UTCI main (`ucm_UTCI`) | 104 | 6 | Mostly HRV frequency-domain outcomes (e.g. LF, VLF, total power) in Eq1–2. |
| Sound main (`ucm_SND_dBA`) | 182 | 0 | — |
| Phase contrasts (vs mean of phases) | 728 | 18 | e.g. WalkU vs mean on blink duration and several HRV FD terms (Eq3-heavy). |
| Other covariates (**irradiance**, SVF, PM, light, **GVI**, phase sums) | 728 | 0 | — |
| All tested terms | 2236 | 24 | Matches 24 rows with q < 0.05 in `FDR_summary_phaseavg_by_outcome.csv`. |

### 3.9 Restoration, lag and sound-source analyses (formerly H6; not a hypothesis)

Exploratory participant-paired and lagged models (§2.3.8; `H5_exploratory/H6_`, `H6_README.txt`). Green-minus-urban paired contrasts (`H6_1_green_urban_contrasts.csv`) yielded 4 BH-FDR hits; delta-PRS concordance with gaze or EDA (`H6_1_restoration_concordance.csv`) did not reach q < 0.05 (lowest delta-PRS association q ≈ 0.09). Lag profiles (`H6_2_`) and sound-source slopes adjusted for dBA, UTCI and lux (`H6_3_`) are reported for hypothesis generation only.

Table 3.9a. Former H6~1~ green − urban paired contrasts — FDR hits (`H6_1_green_urban_contrasts.csv`).

| Mode | Outcome | Green − urban estimate | q~FDR~ |
| --- | --- | --- | --- |
| Bike | PRS-11 total (1–5) | 1.26 | 0.008 |
| Bike | Fixation duration (s) | 0.010 | 0.035 |
| Walk | PRS-11 total (1–5) | 0.83 | 0.008 |
| Walk | Fixation duration (s) | 0.026 | 0.010 |

Table 3.9b. Former H6~1~ delta-PRS concordance — FDR (`H6_1_restoration_concordance.csv`).

| Tests | FDR q < 0.05 | Lowest q |
| --- | --- | --- |
| Delta-PRS × delta physio/gaze pairs | 0 | ≈ 0.09 (delta-PRS × delta fixation rate, Walk) |

### 3.10 Sensitivity and model diagnostics

WPZ and AR(1) branches (H1–H3 sensitivities in §2.3.1 and §2.3.3); Indoor/Tram baseline where estimable (13 Indoor-baseline eye models not fit for insufficient coverage). **Residual and low-df flags from pipeline audits.**

### 3.11 Archived supplementary sound analyses (Oct 2026 exports)

These results come from pipelines archived on 1 Nov 2026 (§2.3.9; outputs in `output/statistical_analysis/results/archive/superseded_sound_20261101/`). They are kept for the record and are not part of the H4 tests or the combined-exposure model.

Sound-substitution Eq1 (**780 models** per mode at 10 s): In the archived `H4_timeseries_sound/` and `H4_phaseavg_sound/`, zero FDR-significant sound or UTCI × sound coefficients after BH across the **598-test** families (Oct 2026). A few raw p < 0.05 interaction terms appear (e.g. low-frequency or wind-related descriptors at 10 s); these are exploratory and should not be ranked by smallest p-value.

Wind exclusion (5 m/s on `ucm_WIND_AWS`): Sensitivity runs under `wind_aws_le_5ms/` dropped two bike-phase 10 s windows; **598/598 models** still fitted; no change in FDR-significant sound/interaction rows vs unscreened trees.

Wider temporal bins (30 / 60 / 300 s): Colleague-requested aggregation of 10 s rows before bout-centered LME; archived outputs under `H4_timeseries_sound/epoch_`. Use for method comparison, not as a second confirmatory claim without pre-registration.

Manuscript stance: Report calibrated uCM dBA for loudness; report 5 m/s wind screening as optional QC showing stability; discuss WAV/spectral and wind_proportion results with microphone/airflow caveats—not as wind-corrected dBA.

Table 1. Selected H1 and H3 results, plus three legacy UTCI × dBA rows from an earlier H4 interaction export (superseded; the interaction is not in the current models) **(illustrative; confirm against current CSV exports for submission)**.

| H | Outcome | Contrast/term | Estimate | SE | 95% CI | p_value | p_value_FDR | eta_squared |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| H1 | empatica_skin_temperature | H1_Green_minus_Urban | -1.358 | 0.175 | [-1.702, -1.014] | <0.001 | <0.001 | 0.0827 |
| H1 | **empatica_sqrt_eda_tonic** | H1_Green_minus_Urban | -0.357 | 0.136 | [-0.624, -0.089] | 0.009 | 0.146 | 0.0153 |
| H1 | eyetracker_pupil_diameter_avg | H1_Green_minus_Urban | 0.498 | 0.076 | [0.348, 0.647] | <0.001 | <0.001 | 0.2385 |
| H3 | empatica_skin_temperature | H3_Walk_minus_Bike | 0.986 | 0.175 | [0.643, 1.329] | <0.001 | 0.056 | 0.0462 |
| H3 | **empatica_sqrt_eda_tonic** | H3_Walk_minus_Bike | 0.367 | 0.136 | [0.100, 0.634] | 0.007 | 0.349 | 0.0170 |
| H3 | eyetracker_fixation_rate | H3_Walk_minus_Bike | 0.236 | 0.061 | [0.115, 0.356] | <0.001 | 0.878 | 0.0674 |
| H3 | eyetracker_gaze_velocity | H3_Walk_minus_Bike | 354.515 | 90.773 | [176.600, 532.429] | <0.001 | <0.001 | 0.3971 |
| Legacy | empatica_skin_temperature | H4_UTCI_within_day_x_SND_within_day | 0.052 | 0.011 | [0.031, 0.074] | <0.001 | 0.995 | <0.001 |
| Legacy | eyetracker_pupil_diameter_avg | H4_UTCI_within_day_x_SND_within_day | 0.016 | 0.004 | [0.008, 0.025] | <0.001 | 0.995 | <0.001 |
| Legacy | eyetracker_saccade_peak_velocity | H4_UTCI_within_day_x_SND_within_day | -30.199 | 5.973 | [-41.905, -18.493] | <0.001 | 0.995 | <0.001 |

Table 2. **Legacy Spearman table; superseded by the current H2 repeated-measures correlation output.**

| Outcome | Questionnaire | Spearman r | 95% CI | p_value | p_value_FDR | Interpretation |
| --- | --- | --- | --- | --- | --- | --- |
| empatica_skin_temperature | questionnaire_prs11_total_mean_1_5 | -0.359 | [-0.593, -0.070] | 0.017 | 0.146 | raw p < 0.05 only; not FDR-significant |
| eyetracker_pupil_diameter_avg | questionnaire_environmental_comfort_mean_1_5 | 0.479 | [0.197, 0.688] | 0.002 | 0.061 | raw p < 0.05 only; not FDR-significant |
| eyetracker_pupil_diameter_avg | questionnaire_prs11_total_mean_1_5 | 0.418 | [0.123, 0.646] | 0.007 | 0.085 | raw p < 0.05 only; not FDR-significant |
| eyetracker_pupil_diameter_avg | questionnaire_thermal_comfort_1_5 | 0.419 | [0.123, 0.646] | 0.007 | 0.085 | raw p < 0.05 only; not FDR-significant |

## 4 Discussion

### 4.1 Green versus impervious routes

Green phases showed **lower square-root-transformed tonic EDA** and lower skin temperature, together with larger pupil diameter. Their co-occurrence is a response profile, not proof of restoration. Lower tonic EDA is compatible with lower sympathetic arousal, but effort, temperature, sensor contact and motion remain plausible (Boucsein et al., 2012). Pupil diameter cannot be read as comfort without ambient light (Mahanama et al., 2021).

### 4.2 Walking versus cycling

Walking versus cycling was associated with **tonic EDA, skin temperature, fixation rate** and gaze velocity. The two modes differ in speed, stabilisation and hazard monitoring, so gaze metrics are not interpreted as direct comfort scores (Rupi & Krizek, 2019). Lower skin temperature during cycling in green corridors may partly reflect convective airflow rather than preference alone.

### 4.3 Physiology and perceived comfort

Phase-level concordance is weak after FDR. Discuss questionnaire timing, scale grain, and sympathetic signals versus a single comfort vote.

### 4.4 Heat and noise together

**No heat × noise amplification was found.** Every literature-based heat × noise test (H4) had 0 of 26 outcomes after FDR, and the earlier UTCI × dBA terms of the combined model had 0 of 104. Sound alone showed a few FDR-surviving associations (fixation rate and gaze distance from centre for Rodrigues trip-mean noise; skin temperature and pupil diameter for the Tohidi noise main effect). Hits from four-condition comparisons (Yousefinezhad, Dehghan, Molaeifar) mix heat and noise and cannot be attributed to sound. Exposures were observed, not assigned, which limits power to detect an interaction.

### 4.5 Limitations

N = 11, one city and season. Route, mode and environment are confounded with location, order, illumination, workload and co-exposures. **Primary models used participant-phase means; AR(1) was secondary.** Wearable and eye-tracking artefacts remain. Multi-outcome testing is exploratory. Sound: uCM dBA is calibrated, but apparent wind (`ucm_WIND_AWS`) mixes ambient and movement-induced airflow; WAV/YAMNet features from the archived sound pipelines are not level-calibrated like dBA. Wind QC in those pipelines excludes high-AWS epochs only—it is not a validated decibel correction. No causal claims.

## 5 Conclusion

Urban active-mobility exposure produced distinct physiological and visual-attention profiles across environment and travel mode. Green phases differed from impervious urban phases in **tonic EDA**, skin temperature and pupil diameter, while walking differed from cycling in **tonic EDA, skin temperature, fixation rate** and gaze velocity.

The primary evidence supports context-dependent psychophysiological associations, not a universal ranking of green versus urban or walking versus cycling. **Physiological-perceptual concordance was not confirmed after FDR correction**, and no heat-noise amplification survived FDR correction in any literature-based test. Larger counterbalanced studies with explicit temporal correlation structures are needed.

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

---

## 7 Exploratory directions — micro-mobility weather zones and stress reactivity (not in confirmatory H1–H4)

This section records a follow-on research idea for the thesis or a second paper. It is not part of the locked confirmatory pipeline (`H1_H3_phaseavg.R`, `H4_sound_literature_tests.R`, `Analysis_combined_phaseavg.R`).

### 7.1 Motivation and fit with urban-climate literature

Fixed-route mobile campaigns often report phase-mean or transect-mean UTCI, PET, sound and radiation (Nikolopoulou et al., 2001; mobile backpack studies, e.g. CityFeel / uCM tradition). A complementary question is whether short segments along the same trajectory behave as repeatable micro-mobility weather zones—locations where combinations of SVF, TVF, BVF, GVI, UTCI and dBA cluster—and whether physiological or visual reactivity spikes when a person enters such a zone relative to their own baseline on that day.

Novelty (if feasible): map GPS-linked 10 s archetypes (e.g. high BVF + low SVF + elevated UTCI vs canopy + high TVF + lower dBA) that recur across participants on shared route geometry, then test whether within-person deviations in EDA, skin temperature, pupil or gaze occur in the seconds after entering an archetype. Extrapolation to high-traffic corridors would remain hypothetical until the same archetypes are sampled under higher pedestrian/cyclist flows; the current study offers proof-of-concept on designed routes only.

### 7.2 Why confirmatory H1–H4 did not answer this

| Mechanism | Effect |
|-----------|--------|
| Primary grain | Participant × phase means (**8 min**) average away short-lived zone entry effects. |
| n = 11 | Weak power for episode-level triggers and for between-participant zone matching. |
| Confounding | Mode, speed, light and workload change at the same GPS locations. |
| SVF/TVF/BVF in models | Only SVF and GVI enter the combined-exposure model; TVF/BVF are available in the merge but excluded to avoid redundant geometry (Gong et al., 2018; `library/Analysis_combined_core.R` Step 2). |
| No event definition | No pre-specified rule for “stress episode” vs tram/indoor baseline or vs rolling within-phase median. |

### 7.3 Candidate hypothesis (H5 — exploratory)

H5 (draft) — psychological comfort and reactivity, not Gong validation: At 10 s epoch grain along GPS-linked transects, in-study CamUp–derived SVF, TVF, and BVF (metric definitions: Gong, F.-Y., et al., 2018) describe visual–morphological exposure while participants move through green-park vs impervious-urban phases (WalkG/BikeG vs WalkU/BikeU). The exploratory question is whether physiological (Empatica: HR/HRV, EDA, skin temperature) and psychological (STAI-6, PRS-11, comfort and stressor items, phase-linked where epoch mapping is weak) outcomes covary with that exposure and with paired microclimate (UTCI stress category, dBA, GVI, LCZ-style context)—i.e. within-person stress/comfort reactivity to environment type and short-lived exposure pockets, not replication of Gong (2018) histograms or proof that Gong, Z., et al. (2019) dominance classes generalize globally.

Operational exposure typing: Normalized sky–tree–building shares may be summarized with Gong, Z., et al. (2019) dominance rules (S, B, T, BS, TS, TB, A) as one defensible historic method option alongside UTCI stress bins and GVI fallback—not as the hypothesis under test. Confirmatory H1–H4 remain phase-mean contrasts; H5 shifts to epoch- or zone-conditioned dynamics and shared map locations across participants.

### 7.4 Operational definitions to prototype

1. Micro-mobility zone: Cluster 10 s epochs in GPS × PhaseID space on standardized (UTCI, dBA, SVF, TVF, BVF, GVI, PM, lux) using e.g. k-means or HDBSCAN within route template; label clusters C1…Ck; require ≥2 participants with epochs in the same cluster centroid (map snapping tolerance, e.g. 15–25 m).

2. Visual stress composite (existing): Defined and concordance-tested in §9 (min–max fixation count + inverted fixation duration; merge column `eyetracker_stress_composite`). Test as outcome or exploratory index, not as a predictor in the H4 tests or the combined-exposure model.

3. Questionnaire stressor composite (idea): End-of-phase yes/no or severity items (temperature, lighting, noise, air quality, crowding) → count or weighted burden; for epoch work, carry backward only as weak label (phase-level) or collect momentary ratings in a future protocol.

4. Reactivity vs baseline: For each participant and outcome Y, define ΔY_ijt = Y_ijt − median(Y within same PhaseID) or ΔY vs seated tram/indoor where available; align ΔY to zone entry times (first epoch in cluster Ck).

### 7.4a Defensible zone typing — historic reference (exploratory / draft)

Draft note for H5 methods: The combined-exposure model uses SVF and GVI only; exploratory H5 re-enters TVF/BVF at epoch grain and therefore needs a published logic for interpreting sky–tree–building composition, not k-means labels alone.

- Metric definitions: Gong, F.-Y., et al. (2018) (Building and Environment) define SVF, TVF, and BVF as hemispherical view factors for sky, vegetation, and built form—the same metric roles as CamUp Holmer annular outputs in this project (see §2 / methods). Gong (2018) does not publish normative low/mid/high cut points for TVF/BVF; it maps continuous factors on Hong Kong street-network GSV.
- Classification logic: Gong, Z., Ma, Q., Kan, C., & Qi, Q. (2019) (Sustainability, 11(22), 6424) is the closest published dominance-based streetscape typology: seven rule-based classes S, B, T, BS, TS, TB, A from relative sky (openness), building (enclosure), and tree (greenery) proportions (2× dominance rules). That paper demonstrates the scheme in Beijing street-view grids; it is not the same author team or city as Gong (2018).
- Literature gap (2019 → present, draft claim): Direct applications or extensions of the 2019 seven-class dominance rules remain sparse; no prior study applies that typology to in-study mobile fisheye SVF/TVF/BVF on designed green vs urban transects in a Northwest European setting. H5 may use the 2019 rules as exposure labels on CamUp epochs; the scientific objective is comfort/reactivity (§7.4b), not validating those classes.

### 7.4b Psychological comfort literature — SVF/TVF/BVF with physio and psycho (H5 framing)

Objective (explicit): H5 is a psychological comfort / stress-reactivity exploratory track. Gong (2018–2019) supplies metric and optional classification heritage; it is not the study’s endpoint to show that Gong’s street-network or Beijing dominance scheme “works” in Brussels greenways.

Literature intersection (honest): Few papers combine hemispherical or street-view sky–tree–building geometry with wearable physiology and standardized psychological surveys on the same participants in mobile field designs. Partial precedents:

| Source | Geometric exposure | Physiology | Psychology | Mobile / field |
|--------|-------------------|------------|------------|----------------|
| Cai, M., Xiang, L., & Ng, E. (2023). Sustainable Cities and Society, 96, 104695. https://doi.org/10.1016/j.scs.2023.104695 | Street-view / isovist tree, sky, building fractions (Gong-line TVF family); lagged visual exposure | Ambulatory skin conductance level | Limited questionnaire battery in same paper | High-density walking routes |
| Cai, X., Ren, M., & Ng, E. (2021). Building and Environment, 205, 108273. https://doi.org/10.1016/j.buildenv.2021.108273 | Isovist + street-view visual factors | Wearable arousal | Subjective emotion / preference | Ambulatory HK pedestrians |
| Benita, F., & Tunçer, B. (2019). Urban Forestry & Urban Greening, 43, 126365. https://doi.org/10.1016/j.ufug.2019.126365 | GIS sky exposure, green, built-up (not full SVF/TVF/BVF triple) | SCR, skin temperature | Perceived restorativeness | Real-world multi-sensor walk |
| Nakayoshi, M., et al. (2015). International Journal of Biometeorology, **59(12), 1781–1791**. https://doi.org/10.1007/s00484-015-0978-9 | No view factors; pathway microclimate | Skin temperature, pulse-related measures | Thermal sensation | Mobile pathway transects |

Gap → Paper 3 niche: No study was identified that combines all three Gong factors (SVF, TVF, BVF) from in-study upward fisheye with Empatica + mobile eye tracking and STAI-/PRS-style surveys across multiple participants on green vs urban mobility phases. H5 documents that integrated question at epoch grain; confirmatory H1–H4 already establish phase-level physio and ocular contrasts—H5 adds morphology-conditioned reactivity and psycho linkage where the merge supports it.

### 7.5 Statistical approaches to investigate (literature-aligned)

| Question | Candidate test | Notes |
|----------|----------------|-------|
| Do zones differ in exposure? | Multivariate profile by cluster; PERMANOVA or mixed MANOVA on epoch metrics | Descriptive first; Gong et al. (2018) for SVF/TVF/BVF interpretation |
| Same zone, same response pattern across people? | Mixed model: ΔY ~ zone + (1\|Participant) + (1\|PhaseID); or alignment to route-distance spline | Requires enough epochs per zone per person |
| Short-term trigger after zone entry | Distributed lag mixed model (0–30 s lags) or changepoint / joinpoint on ΔY vs distance | Similar spirit to lag sensitivity archived in old outline; not in current repo scripts |
| Shared spatial pattern | Functional data or heatmap of median ΔY by arc-length along canonical trajectory | Qualitative + inferential supplement |
| Stress index → physiology | Epoch LMM with person-centred UTCI, dBA, SVF, stress_composite; FDR across outcomes | Extension of the 10 s combined-exposure model |
| Visual exposure → physio and psycho | Epoch or zone LMM: ΔY ~ SVF/TVF/BVF (continuous or dominance class) × PhaseID + UTCI/dBA; separate models for questionnaire-derived phase labels carried weakly to epochs | Aligns with Cai et al. (2021, 2023) ambulatory visual–stress spirit; outcomes include comfort/STAI/PRS where linked (§7.4b), not Gong class accuracy |

Key references when implementing: Gong, F.-Y., et al. (2018); Gong, Z., et al. (2019) (§7.4a); comfort / ambulatory precedents Cai et al. (2021, 2023), Benita & Tunçer (2019), Nakayoshi et al. (2015) (§7.4b); Qiu et al. (2017) street-view SVF; Nikolopoulou et al. (2001); Erell & Williamson; Broder et al. (UTCI); Hamra & Buckley (2018); Gregorich et al. (2021); O’Brien (2017) on co-occurring exposures and model influence.

### 7.6 H5 sensitivity models (design note — not implemented in locked scripts)

Grain and notation: 10 s epochs with within-phase reactivity `delta_Y` = `Y − median(Y | ParticipantID, PhaseID)` (same construction as current `H5_core.R`). Primary visual IV: `dominance_class` (S, B, T, BS, TS, TB, A). Route context: `PhaseID` (reference BikeU, as H1). Environmental covariates: person-centred within participant-day where noted (`_c`) to mirror H4 co-exposure spirit without re-estimating confirmatory phase means. Engine: `nlme::lme(..., random = ~ 1 | ParticipantID, method = "REML")` (Pinheiro & Bates; same family as H1–H3). Outcomes: primary panel = H5 reactivity outcomes (`empatica_eda_tonic`, `empatica_skin_temperature`, `eyetracker_pupil_diameter_avg`, `eyetracker_fixation_rate`, `eyetracker_stress_composite`, `eyetracker_gaze_velocity`); psycho = same `delta_` or phase-level scores for `questionnaire_stai6_mean_1_5`, `questionnaire_environmental_comfort_mean_1_5`, `questionnaire_prs11_total_mean_1_5` where epoch merge supports them (interpret as exploratory, weak time alignment). FDR: separate H5 family across outcomes × dominance terms; sensitivities are not merged with H1–H4.

| ID | Model (R / nlme) | Enables vs primary P0 |
|----|------------------|---------------------------|
| P0 — primary | `lme(delta_Y ~ dominance_class + PhaseID, random = ~1 \| ParticipantID)` | Baseline visual-morphology → reactivity association, adjusting designed mode × environment phase only. Descriptive UTCI stress × dominance cells (§7.4a) stratify exposure; not a substitute for covariate adjustment. |
| S1 — + thermal | `lme(delta_Y ~ dominance_class + PhaseID + ucm_UTCI_c, random = ~1 \| ParticipantID)` | Tests whether dominance contrasts persist after person-centred thermal load (links to the combined-exposure model / Benita immediate-environment layer). |
| S2 — + noise | `lme(delta_Y ~ dominance_class + PhaseID + ucm_SND_dBA_c, random = ~1 \| ParticipantID)` | Isolates visual class from concurrent A-weighted sound on the same epochs. |
| S3 — + air & light | `lme(delta_Y ~ dominance_class + PhaseID + atmo_pm2.5_avg_c + lys_lux_avg_c, random = ~1 \| ParticipantID)` | Checks PM₂.₅ and illuminance co-exposure (pupil-sensitive outcomes especially). |
| S4 — full environment | `lme(delta_Y ~ dominance_class + PhaseID + ucm_UTCI_c + ucm_SND_dBA_c + atmo_pm2.5_avg_c + lys_lux_avg_c + gvi_50m_c, random = ~1 \| ParticipantID)` | Multivariable co-exposure benchmark; dominance terms are partial associations given H4-like covariates at epoch grain (expect wider SEs if collinear). |
| S5 — morphology × route | `lme(delta_Y ~ dominance_class  green_phase + PhaseID, random = ~1 \| ParticipantID)` with `green_phase = PhaseID %in% c("WalkG","BikeG")` | Tests whether dominance → reactivity differs green-park vs impervious-urban phases (H1 environment moderation of visual exposure). |
| S6 — continuous / composite geometry | S6a: `lme(delta_Y ~ TVF_c + BVF_c + SVF_c + PhaseID, random = ~1 \| ParticipantID)` (compositional — interpret jointly, not as independent effects). S6b (preferred robustness): PCA on `(SVF, TVF, BVF)` → `lme(delta_Y ~ morph_PC1 + morph_PC2 + PhaseID, random = ~1 \| ParticipantID)`. S6c: `lme(delta_Y ~ TVF_c + PhaseID, ...)` single continuous tree exposure (Cai et al. 2023 parallel). | Assesses whether class-based P0 findings are artifacts of binning; agreement of sign and rank of green- vs built-dominated contrasts supports dominance typing. |

Comparisons: For each sensitivity, contrast dominance_class coefficients (or pre-specified pairs, e.g. T vs BS, TS vs BS) against P0 using model influence (O’Brien): report Δ estimate, Δ SE, and whether inferential conclusion (sign / ordering) is unchanged. Optional nested-model LR test P0 vs S1–S4 for a single focal contrast is secondary to robustness of dominance terms.

Sensitivity “pass” (exploratory): For outcomes with a FDR-significant dominance term in P0, pass if (i) the same term (or pre-specified contrast) remains q < 0.05 in S1–S4 or (ii) raw p < 0.05 with same sign and estimated contrast magnitude ≥ 50% of P0 after adding covariates; for S5, pass if interaction is interpretable (significant `dominance_class:green_phase` or stable simple slopes within green vs urban); for S6, pass if tree-/canopy-dominated vs built-dominated direction matches P0 (class T/TS vs B/BS) even if bin-wise levels differ. Fail = sign flip or contrast driven solely by a covariate with dominance terms unstable (large Δβ per Gregorich/O’Brien). Non-significant P0 terms: sensitivities reported descriptively only.

### 7.7 Deliverables if pursued

- Canonical route-distance axis (0–480 s) with zone polygons on the trajectory figure.  
- Table: cluster labels × median UTCI, dBA, SVF, TVF, BVF, GVI.  
- Figure: ΔEDA / Δpupil / stress_composite aligned to zone boundaries (participant lines + median).  
- Pre-register H5 separately; do not merge FDR families with H1–H4.

### 7.8 Honest feasibility (current data)

With 11 participants and designed routes, zone-level inference may remain descriptive or supplementary unless many 10 s epochs fall in shared clusters. High-traffic extrapolation is a discussion point only. Priority for the current manuscript remains §3.1 phase exposure profiles plus H1–H4; §7 is the documented novelty track for psychological comfort reactivity under CamUp SVF/TVF/BVF exposure (see `H5_exploratory.R` outputs), not Gong validation and not a promise in the abstract.

### 7.9 Limitations and honest scope (H5 / §7 narrative)

§7 is exploratory only—not confirmatory, not a Gong (2018–2019) validation study, and not a claim of causal environment → comfort chains. The following constraints should appear explicitly in thesis or follow-on paper discussion.

1. Geometry → microclimate is already well modelled. SOLWEIG, RayMan, and ENVI-met already link urban geometry / SVF to mean radiant temperature, PET, and UTCI. Fahy et al. (2025) already fit walking-transect PET with a linear mixed model (random effects: date and transect) and tell future work to cross-check SOLWEIG / ENVI-met. Predicting uCM UTCI from CamUp SVF/TVF/BVF on the same walk repeats that step. Their result also splits “green”: open lawns were hot; shade under trees was cool.

2. Visual exposure → physiology / perception has precedents. Cai et al. (2021, 2023), Benita & Tunçer (2019), and Nakayoshi et al. (2015) already connect street-view or GIS visual context (tree/sky/building or microclimate) to skin conductance, thermal sensation, restorativeness, or emotion. Paper 3’s contribution is the integrated mobile stack (CamUp triple + uCM + Empatica + eye tracking + surveys on designed green vs urban phases), not proof that “visuals affect stress” in isolation.

3. No clean causal chain (TVF/BVF → environment → physiological response). A two-stage story (morphology → UTCI/dBA → ΔEDA/pupil) cannot be validated as attribution here: stacked regressions ≠ mediation/causation; mode, speed, route location, and workload co-vary with morphology; and UTCI is computed from the same meteorological inputs (Ta, humidity, radiation, wind) that also enter outcome models—risking circularity if UTCI is both “environmental consequence of geometry” and “predictor of physiology” without a strictly external thermal reference.

4. Psychological measures are phase-grained. STAI-6, PRS-11, comfort and stressor items are end-of-phase (or block-level), not second-by-second. Epoch-level H5 models therefore align physiology and CamUp exposure at 10 s with questionnaire labels only weakly (carry-back or phase fixed effects)—limiting temporal psycho–physio linkage.

5. Sample size. n = 11 with complete multi-sensor coverage restricts zone clustering, between-participant archetype matching, and interaction models; many §7 tests remain descriptive or supplementary (§7.8).

6. Eye tracking. Gaze and fixation are sparse and uneven outdoors (motion, calibration, blink loss, scene complexity); gaze fraction on green or restoration-style metrics may be underpowered or missing for long arc-length segments—not a drop-in substitute for CamUp TVF at every epoch.

7. Downward fisheye (CamDown). Nadir / ground-facing views do not yield SVF/TVF/BVF; backpack, body, and bag occlusion dominates; surface class largely duplicates PhaseID and CamUp TVF/GVI on green routes. Literature uses downward cameras for terrain/pavement HAR, not comfort—low priority for H5 (see call notes).

8. Gong, Z., et al. (2019) dominance classes are an adaptation, not a forest standard. The seven-class rules were developed on Beijing street-view grids (street canyons), not park trails or canopy-dominated greenways. No identified paper validates those classes on Northwest European forest/green transects; H5 uses them as defensible exposure labels only (§7.4a).

9. Framing. Report H5 as within-person reactivity and association under naturalistic confounding; do not imply global Gong replication, causal mediation of morphology through UTCI, or confirmatory hypothesis status in the main manuscript abstract.

Gong, F.-Y., et al. (2018). Mapping sky, tree, and building view factors of street canyons. Building and Environment, 134, 155–167. https://doi.org/10.1016/j.buildenv.2018.02.042

Gong, Z., Ma, Q., Kan, C., & Qi, Q. (2019). Classifying street spaces with street view images for a spatial indicator of urban functions. Sustainability, 11(22), 6424. https://doi.org/10.3390/su11226424

---

## 8 Repeated-measure exposure design — strength, not a sample-size workaround

This section reframes what §7.8 and §7.9 list as “thin power for between-person zones.” The primary inferential leverage in Paper 3 is not a cross-sectional comparison of eleven independent pedestrians at different map coordinates—it is repeated measurement of the same individuals at recurring exposure contexts along a fixed, **counterbalanced** route, with synchronized CamUp, uCM, wearables, and (where available) eye tracking at 10 s resolution.

### 8.0 Operational hotspot definition and characteristics (H5)

What counts as a hotspot: A hotspot is a 20 m GPS bin along the fixed study route within a given PhaseID (walk/bike × urban/green). Bins are indexed by cumulative haversine distance from the phase start (`route_distance_bin_m = 20` in `H5_hotspot_weather.R`). A bin enters shared-hotspot analysis when **≥2 participants** occupy the same bin within that phase (same `hotspot_id` = `{PhaseID}_bin{k}`). Analysis rows are participant × hotspot × day (and phase), built only from `merged_all_11participants_8min.csv`—no external weather or map layers for defining the hotspot.

Place-intrinsic characteristics (define the hotspot as a location on the protocol): These are stable geometry / terrain descriptors tied to in-study sensing, aggregated to the hotspot (typically median over 10 s epochs in the bin, then summarized across visits in `H5_hotspot_exposure_stability.csv`):

| Characteristic | Variable(s) | Source | Role in H5 |
|----------------|-------------|--------|------------|
| Sky / canopy / ground openness | SVF, TVF, BVF (continuous [0, 1]) | CamUp fisheye, Holmer annular view factors from in-campaign images—not external GIS or Mapillary | Hotspot profile (morphology pocket) |
| Along-route grade | `gps_segment_slope_pct` (median per hotspot) | Derived point-to-point from uCM `ucm_GPS_alt` and GPS step length (100 × Δelevation / horizontal m); no dedicated slope column in the merge file | Hotspot profile (terrain) |

Not hotspot definitions — momentary / passage-specific exposure (models only): Backpack and sensor readings that change with time, weather, and behaviour characterize the exposure during that pass, not the identity of the place. They enter RH1–RH4 and staged sensitivity models as grand-mean-centered hotspot-day medians (moderators or +1 covariate per sensitivity run), not as definitional hotspot labels:

- Thermal / acoustic / air quality (uCM & Atmotube/LYS): `ucm_UTCI`, `ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_WIND_AWS`, `ucm_SUN_Gh`, `ucm_SND_dBA`, `ucm_PET`, `ucm_MRT`, `atmo_pm2.5_avg`, `lys_lux_avg`.

Explicitly excluded from hotspot definition: `gvi_50m` (and related Mapillary / streetscape GVI fields)—external, static greenness matched to route context; may appear as an exploratory model covariate but must not be used to define what the hotspot is. Dominance-class labels (legacy Gong-style) are likewise not the operational hotspot identity in the current `H5_hotspot_` pipeline; GPS bin + CamUp SVF/TVF/BVF + derived slope are.

Modelling note: RH1 primary conditions on `hotspot_f` (fixed effect for bin) so place-intrinsic morphology and slope are partially absorbed by bin; UTCI and other momentary fields test within-hotspot / across-day co-exposure and moderation. RH3 adds participant-specific slope along route position (`route_bin_num | ParticipantID`), distinct from terrain grade in the hotspot profile.

### 8.1 What the design actually repeats

| Unit | What is repeated | What varies |
|------|------------------|-------------|
| Participant | Same 11 people traverse the same phase geometry (BikeU, WalkU, BikeG, WalkG) | Day (campaign dates **July–August 2025**), meteorology, within-day thermal and acoustic trajectory |
| Hotspot / exposure pocket | GPS-linked segments where morphology and microclimate cluster (canopy gap, canyon, open plain, green corridor)—the “micro-mobility weather zones” of §7.1 | Weather on that day (Ta, RH, wind, radiation from station or campaign reference), time of day, mode (walk vs bike on shared alignment) |
| Epoch | Thousands of within-person 10 s rows per participant × phase | Dominance class, UTCI stress bin, dBA, GVI at that instant |

With one designed route, between-participant spatial novelty (many independent walkers at different addresses) is intentionally limited. That is not a failed city-wide sample—it matches a within-subject environmental challenge design: each person is their own control when they re-encounter the same hotspot under different synoptic or mesoscale weather.

Contrast with Geneva walking-transect mapping: Fahy et al. (2025) (Urban Climate) model PET along walks with LMM random effects for Date and Transect—exposure mapping, no recruited participants, no physiology. Paper 3 adds repeated personal passage through fixed hotspots plus physiological and perceptual outcomes; the repeated unit is person × hotspot × day, not pixel × transect alone.

### 8.2 Why day-to-day weather becomes a feature, not noise

When route geometry is fixed, spatial variation across people at the same coordinate is zero by design. The main orthogonal contrast for “same place, different experience” is then:

- Meteorological day (and within-day trend): station or reference Ta, RH, wind speed, global radiation, heatwave vs moderate summer day.  
- Person-centred reactivity (§7.4, §7.6): ΔY relative to within-phase median or tram baseline, so physiology is read as deviation from that person’s norm, not population mean comfort.

Testable exploratory question (H5-aligned): At hotspot h, does ΔEDA, Δpupil, or stress_composite on day d covary with day-level weather (or UTCI at h on d) after accounting for dominance class and PhaseID? That is within-person repeated exposure: the same individual meets the same SVF/TVF/BVF pocket again with different thermal load—closer to longitudinal microclimate response than to n = 11 independent zone means.

This is cleaner than §7.1’s “≥2 participants in the same k-means cluster” for population zone typing, because it does not require between-person replication at every coordinate; it requires within-person replication across days or passes where route design brings them back to similar arc-length / GPS bins.

### 8.3 How this strengthens H5 (build on repeated exposure)

1. Hotspot aggregation: For each participant, collapse 10 s epochs to hotspot × day (or hotspot × phase × day) summaries: median SVF, TVF, BVF, dominance_class, UTCI, dBA, GVI, and median ΔY for each outcome in the H5 panel (§7.6).

2. Day-level covariates: Merge official or campaign weather-station (or fixed reference) daily / sub-daily Ta, RH, wind, radiation; optionally person-day means of uCM for sanity checks. Use as fixed effects or moderators of hotspot effects—not as a substitute for in-situ uCM at the pocket, but to separate synoptic from local mismatch (“same canyon, hotter regional day”).

3. Within-person models (exploratory):  
   `lme(delta_Y ~ dominance_class + PhaseID + weather_day + hotspot_id, random = ~1 | ParticipantID)`  
   or, with richer replication,  
   `lme(delta_Y ~ dominance_class  weather_day_c + PhaseID, random = ~1 | ParticipantID)`  
   with hotspot_id as repeated context (fixed effect or stratifier). Random intercepts for ParticipantID retain the confirmatory H1–H3 spirit; hotspot encodes repeated environmental challenge, not a second population.

4. Advantage over cross-sectional comfort studies: Many ambulatory papers (Cai et al., Benita & Tunçer) compare routes or individuals at one time. Paper 3 can argue designed recurrence: fixed alignment → comparable morphology at hotspot h → weather-modulated reactivity is identifiable within person, supporting comfort dynamics rather than a one-shot street-average association.

5. Link to confirmatory H1–H4: Phase-mean green vs urban and walk vs bike remain the locked manuscript core; §8 explains why epoch / hotspot H5 is the same participants pushed through repeated exposure cells, not a separate “small n” study.

### 8.4 Novelty claim (explicit — addresses “why say it’s not novel?”)

§7.9 limits incremental claims (geometry→UTCI simulation literature; visual→SCL precedents; no causal mediation). Those limits apply to mechanistic novelty, not to design novelty. The documented contribution that is novel in the current evidence base (§7.4b gap) remains:

- Integrated mobile stack on the same participants: CamUp SVF/TVF/BVF, uCM UTCI/dBA, Empatica, pupil/gaze, surveys, both walking and cycling on green and urban phases—repeated measures on a fixed Brussels protocol, not a one-time Hong Kong walk (Cai) or Geneva PET-only transect (Fahy et al., 2025).

- Repeated-measure exposure as the inferential object: testing whether stable hotspots produce different within-person reactivity when regional weather or within-day thermal trajectory shifts—exposure replication with meteorological contrast, which single-day cross-sections cannot do.

Do not sell this as “discovering new physics” or “first proof that trees calm people.” Do sell it as within-person psychophysiological comfort under repeated, GPS-anchored environmental challenge, with mode (walk/bike) and phase (green/urban) as designed factors—a structure most cited papers do not implement together.

### 8.4b H5 framing — empirical hotspot reactivity, not thermoregulation-model validation

H5 must not be written as a validation or calibration study of standardized human thermoregulation / thermal comfort simulators, including Gagge two-node (Gagge, Stolwijk, Nishi; SET/ET/DISC lineage), JOS-3, Fiala / UTCI-Fiala, Stolwijk multi-node, Berkeley (CBE) comfort, COMFA, RayMan / PET, or PMV/PPD. Those tools predict core/skin temperature, sweating, or index-valued sensation from weather and clothing inputs; a paper whose main logic is “run the model with uCM meteorology and compare to wearables” invites validation review (RMSE on Tsk, vote agreement)—a different genre from Paper 3’s confirmatory H1–H4 and exploratory H5.

H5 focus (strictly empirical): Repeated hotspot exposure on the fixed protocol—GPS-anchored bins (e.g. 20 m along arc length within PhaseID) where backpack microclimate (UTCI, Ta, dBA, PM, lux) and CamUp morphology (SVF/TVF/BVF) characterize hotspot conditions, plus reference-station day covariates (Ta, RH, wind, radiation) where available. Outcomes are observed short-term reactivity: campaign- or phase-centered EDA, pupil, skin temperature, HR/HRV, gaze metrics, and phase-level questionnaires (STAI/PRS/comfort)—not model-predicted physiology.

Research question: Do real participants show differential immediate reactivity when they re-enter the same hotspot under different hotspot-level and day-level conditions (and walk vs bike where bins align)—i.e. associations between hotspot-conditioned exposure and deviation from person baseline, optionally heterogeneous across participants (outlier hotspots, random slopes)—not whether a physics-based comfort model correctly predicts their bodies. uCM UTCI may enter as measured co-exposure at the hotspot; it is not the endpoint to validate against Fiala/Gagge outputs (§7.9.3).

Implementation alignment: Exploratory pipeline `H5_hotspot_weather.R` / `H5_hotspot_core.R`—hotspot-day aggregation, cell-count audit, RH1/RH2 weather models, participant campaign baselines—supports this framing only.

### 8.5 Honest limitations (same design, transparent)

- Fixed route: Hotspots are protocol-defined, not a random sample of the city; extrapolation to all Brussels or high-traffic corridors stays discussion-only (§7.8).  
- n = 11: Between-hotspot population inference remains weak; within-person day/hotspot replication is the defensible axis—report how many person × hotspot × day cells exist per dominance class.  
- No randomization of hotspot order across days: **phase order is counterbalanced**, but weather is not assigned; treat day as observational moderator, not RCT.  
- Questionnaires stay phase-level (§7.9.4); hotspot × day psycho models may rely on physio and ocular outcomes first.  
- UTCI circularity caution (§7.9.3) still applies when day weather and uCM UTCI are both predictors—prefer external station variables for day-level moderation where possible.

Implementation note: Hotspot labelling can start from GPS bin × dominance_class × PhaseID (or §7.4 k-means within route template) without new confirmatory commits; align with existing `H5_exploratory.R` / dominance outputs before adding weather_day merges in a future script pass.

### 8.6 Literature precedents — repeated exposure, weather, and mixed models

Partial precedents for §8 (none replicate the full Paper 3 stack: fixed protocol, CamUp SVF/TVF/BVF, uCM, walk + bike, hotspot × day × person reactivity). PDFs stored under `Experiment papers/Repeated hotspot exposures and reactivity/` (Paper3_Github).

| Citation | Design gist | Weather / day contrast | Route / hotspot | Physio + model | Gap vs Paper 3 |
|----------|-------------|------------------------|-----------------|----------------|----------------|
| Rodrigues, A. R., da Conceição, M. S. A., Ramusga, R., Azevedo, C. L., & Morgado, P. (2026). The influence of urban context on emotions and bodily responses during walking. Journal of Urban Health. https://doi.org/10.1007/s11524-025-01051-1 | 90 participants, 2,207 app-logged walking trips (Lisbon); Empatica E4; post-trip emotion scales; Mapillary / NDVI / noise | Daily IPMA temperature and precipitation matched to trip date | Self-selected routes (25 m buffer)—not fixed study hotspots | Linear mixed models, random intercept participant; heat → EDA amplitude | No designed recurrence at GPS bins; walking only; no CamUp triple |
| Korkmaz, D., Knauth, K., Brands, A., Schmeck, M., Büning, P., & Peters, J. (2025). Ambulatory physiological measures obtained under naturalistic urban mobility conditions have acceptable reliability. Scientific Reports, 15, 13216. https://doi.org/10.1038/s41598-025-13216-8 | 26 participants, same ~2.2 km urban walk on two days (6–8 d apart); GPS + EDA/HR/HRV | Narrow T range (≈16–21 °C); question = fasted vs sated, not weather moderation | Fixed memorized route | Test–retest reliability (bootstrap r), not LMM ΔY ~ weather × location | Same route repeat exists; weather contrast underused; no microclimate backpack / morphology |
| Fahy, J. C., Bachofen, C., Camponovo, R., Gallinelli, P., & Schlaepfer, M. A. (2025). Beyond land surface temperature: Identifying areas of daytime thermal discomfort in cities by combining remote sensing and field measurements. Urban Climate, 61, 102460. https://doi.org/10.1016/j.uclim.2025.102460 | Eight Geneva walking transects; microclimate-meter PET; multiple dates | Date random effect in GAM/LMM | Same transect lines | GAM + LMM (predictors: LCZ, LST, albedo, …); no human subjects | Exposure mapping only; Paper 3 adds wearables + psycho on same people |
| Nakayoshi, M., Kanda, M., & Oke, T. R. (2014). Outdoor thermal physiology along human pathways: a study using a wearable measurement system. International Journal of Biometeorology, **58(7), 1781–1791**. https://doi.org/10.1007/s00484-014-0864-y | Mobile pathway Tajimi; wearable GAR + physiology; Aug 22–24 | Different calendar days; different age cohorts per day (not full within-person repeat) | Shared observational route textures | Field sync microclimate + physiology; not mixed models on person × hotspot × day | Multi-day campaign DNA; not same individuals all days for weather contrast |
| Cai, M., Xiang, L., & Ng, E. (2023). How does the visual environment influence pedestrian physiological stress? Evidence from high-density cities using ambulatory technology and spatial machine learning. Sustainable Cities and Society, 96, 104695. https://doi.org/10.1016/j.scs.2023.104695 | Predefined HK walking routes; ambulatory SCL + lagged street-view / isovist visuals | Single-campaign ambulatory exposure (not hotspot × day weather design) | Fixed walk paths per study | MLR / GRF on SCL; not participant LMM with day weather | Visual→SCL precedent; no repeated-day weather moderation at fixed hotspots |

Synthesis for thesis text: Rodrigues et al. (2026) is the closest Empatica + LMM + daily weather precedent but on free routes. Korkmaz et al. (2025) validates same-route, two-day ambulatory physiology. Fahy et al. (2025) validates Date × transect mixed modelling for PET without participants. Paper 3 §8/H5 targets the intersection not yet published: protocol-fixed hotspots, within-person ΔY, dominance / CamUp morphology, optional station weather moderation, walk and bike.

### 8.7 H5 extension — repeated hotspot reactivity (design note; not in locked scripts)

Objective: Extend exploratory H5 from epoch dominance → ΔY (current `H5_core.R` P0) to person × hotspot × day cells where the same GPS bin (or arc-length bin within PhaseID) is revisited across campaign dates, testing weather-modulated reactivity without changing confirmatory H1–H4.

Data prerequisites (inventory before coding):

| Layer | Source | Grain | Notes |
|-------|--------|-------|-------|
| Epoch merge | Existing Paper3 merge CSV | 10 s | `ParticipantID`, `PhaseID`, `datetime_utc`, GPS, CamUp SVF/TVF/BVF, dominance_class, uCM UTCI, SND, GVI, Empatica, pupil |
| Hotspot ID | Derive | Bin label | e.g. `hotspot_id = paste(PhaseID, floor(route_distance_m / 50))` or H3-aligned GPS cluster within route template; require ≥ K epochs per bin per pass |
| Campaign day | `datetime_utc` → Date | Day | One row per participant-day for station merge |
| Station weather | RMI / MeteoBelgium or fixed reference station | Daily (or 3-hourly → daily max/mean) | Ta, RH, wind, GHI or sunshine—prefer for day moderator over uCM-only (§7.9.3 circularity) |
| Person-day pass | Count | Diagnostic | Table: n cells with same participant + same hotspot_id on ≥2 distinct dates (if 0, weather×hotspot interaction is descriptive only) |

Analysis stages (proposed order):

1. Descriptive replication map: For each hotspot_id × PhaseID, plot median dominance_class, UTCI, SVF/TVF/BVF across all passes (check stability of morphology label).  
2. Build analysis table `H5_hotspot_day`: One row per ParticipantID × hotspot_id × Date × PhaseID (optionally × mode if walk/bike share bin): medians of exposure + median ΔY per outcome (same Δ definition as §7.6).  
3. Primary repeated-exposure model (RH1):  
   `lme(median_delta_Y ~ dominance_class + PhaseID + weather_day_c + hotspot_id, random = ~1 | ParticipantID, method = "REML")`  
   where weather_day_c is person-centred or study-wide centred station Tmax (or heatwave bin). Interpretation: association of day-level thermal context with within-person reactivity averaged over hotspots, adjusting morphology and phase.  
4. Hotspot moderation (RH2 — core §8 question):  
   `lme(median_delta_Y ~ dominance_class  weather_day_c + PhaseID + hotspot_id, random = ~1 | ParticipantID)`  
   or stratify: fit within hotspot_id where ≥ N person-days exist. Positive signal (exploratory): interaction or consistent sign that ΔEDA / Δpupil is higher on hotter regional days in built-dominated hotspots but flat or reversed under T/TS dominance (hypothesis-generating, not pre-registered confirmatory).  
5. Bridge to existing P0: Epoch-level P0 (`delta_Y ~ dominance_class + PhaseID`) remains baseline; RH2 is supplementary H5 family with separate FDR (§7.6).  
6. Mode extension (Paper 3 unique vs precedents): Where WalkG and BikeG share hotspot_id, contrast ΔY with `PhaseID` or `mode` fixed effect—documents walk vs bike at same morphological pocket under same weather_day.

What counts as a “positive” exploratory result (pre-specify in thesis methods):

- Replication: ≥ 5 participants with ≥ 2 days passing the same hotspot_id (report exact n).  
- RH1: FDR-q < 0.05 for weather_day_c on ≥ 1 **physio/oclar** outcome with expected sign (e.g. higher Tmax → higher ΔEDA or Δskin temp), or raw p < 0.05 with |β| stable when adding dominance_class.  
- RH2: dominance_class × weather_day_c interpretable or within-hotspot slope of ΔY ~ weather_day_c same sign in ≥ 60% of hotspots with adequate n.  
- Discriminant validity: Effect weakens when weather_day replaced by within-pass mean UTCI only—supports synoptic moderation narrative (optional robustness).  
- Negative result still publishable: “Fixed hotspots show stable dominance; day weather explains little extra ΔY after PhaseID”—constrains over-claiming §8 novelty.

Non-goals (this extension): Causal mediation morphology → UTCI → ΔY; Gong class validation; merging FDR with H1–H4.

Implemented (exploratory; `H5_hotspot_weather.R` / `H5_hotspot_core.R`): 20 m route bins; shared place = **≥9/11 participants** with bin median GPS within 30 m (haversine); campaign-centered median outcomes on hotspot-day rows. RH1 (active, `run_rh1_only`): one LMM per PhaseID × outcome — `median_center_Y ~ env_ucm_UTCI_c + hotspot_f + (1|ParticipantID)` (phase-stratified to avoid `PhaseID + hotspot_f` aliasing). 26 physiological outcomes (H1–H3 list). Hotspot-level FDR (exploratory): Benjamini–Hochberg within outcome × phase on `hotspot_f` contrasts (locked family); pooled 1321-test BH reported as conservative audit only. Outputs: `output/statistical_analysis/results/H5_exploratory/` (`H5_RH1_hotspot_FDR_locked_family_significant.csv`, inclusion comparison CSV). RH2–RH4 paused until `run_rh1_only` is lifted.

## 9 Stress composites — ocular, environmental and physiological concordance (exploratory)

This section documents stress-oriented composite indices that sit outside confirmatory H1–H4. It aligns with the exploratory framing in §7–§8 (epoch reactivity, hotspot models) but uses participant × phase means on the matched **eight-minute merge** (`output/merged_all_11participants_8min.csv`) for primary concordance tests, mirroring H2’s repeated-measures correlation spirit (Bakdash & Marusich, 2017). No composite enters locked hypothesis equations; FDR for §9 is a separate exploratory family from H1–H4 (`H6_stress_composite.R`).

### 9.1 Scope and data grain

| Element | Convention |
|---------|------------|
| Input | Synchronized 10 s epochs, capped per participant at the common matched route duration (**480 s** on four core phases). |
| Aggregation for §9 primary tests | Participant × phase means (44 cells on four core phases when complete; proprietary ocular composite N = 39 person-phases when eye-tracker coverage gaps apply, e.g. P13). |
| Multiplicity (current H6 run) | 55 stress-oriented composites → 1,485 ordered pairs attempted, 1,378 rmcorr fits, 403 pairs with q_FDR < 0.05 (one BH family over all fitted pairs; `H6_run_manifest.csv`). |
| Implementation | `scripts/statistical_analysis/H6_stress_composite.R` (engine: `library/H6_stress_composite_core.R`); outputs under `output/statistical_analysis/results/H6_stress_composite/`. |

### 9.2 Proprietary ocular stress composite (`eyetracker_stress_composite`)

The merge carries a study-defined visual stress index computed during Pupil Labs Neon aggregation (not a vendor black-box score in confirmatory models). For each participant, across all processed phases:

- Fixation count (FC) and fixation duration (FD) are min–max scaled to [0, 1] using that participant’s min and max over phases.
- Duration is inverted so that shorter fixations (higher scanning load) contribute in the same direction as higher fixation counts.

\[
\text{FC\_scaled} = \frac{FC - FC_{\min}}{FC_{\max} - FC_{\min}}, \quad
\text{FD\_scaled} = 1 - \frac{FD - FD_{\min}}{FD_{\max} - FD_{\min}}, \quad
\text{eyetracker\_stress\_composite} = \frac{\text{FC\_scaled} + \text{FD\_scaled}}{2}
\]

Constant inputs map to 0.5; values are bounded in (0, 1) when both components vary (project email 07 Oct 2026; `Brain/email/Pranav replies 07 Oct 2026.txt`). P13 has no usable eye-tracker stress values on core phases in the current merge. Descriptive phase ordering (participant-balanced means on the 8 min file): WalkU highest, then Tram, WalkG, BikeU, BikeG lowest (`Brain/WORK_DIARY.md`, 2026-10-27 entry).

### 9.3 Transparent ocular stress index (project-defined alternative)

To avoid relying solely on the two-feature proprietary score, H6 builds a four-feature transparent ocular index from merge columns, with the same stress direction logic as physiological outcomes:

- +1 (higher → more stress-oriented): `eyetracker_fixation_rate`, `eyetracker_pupil_diameter_avg`, `eyetracker_blink_duration_s`
- −1 (lower → more stress-oriented): `eyetracker_fixation_duration_s` (inverted after within-person z-scoring)

For each feature: apply the locked normalization CSV transform when the column is in the physiological outcome set (`output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_all_parameters.csv`), then within-person z across the four phase means, multiply by stress direction, and take the equal-weight mean. Proprietary and transparent indices are strongly concordant at phase grain (rmcorr r ≈ 0.85, q_FDR < 0.001; `H6_pairwise_rmcorr.csv`).

### 9.4 Environmental stress composites (single factors and groups)

Available environmental fields in the merge (uCM backpack, Atmotube, LYS, CamUp / GVI pipelines), as used in H5 hotspot profiling (`H5_hotspot_weather.R`):

| Domain | Merge columns (10 s) | Bilateral means used in H6/H5 |
|--------|----------------------|-------------------------------|
| uCM thermal / heat stress | `ucm_UTCI`, `ucm_PET`, `ucm_MRT`, `ucm_AIR_temp`, `ucm_HUMIDEX`, `ucm_AIR_RH` | — |
| uCM radiation & wind | `ucm_SUN_Gh`, `ucm_WIND_AWS` | — |
| uCM sound | `ucm_SND_dBA` | — |
| uCM motion context | `ucm_GPS_speed_kmh` | — |
| Atmotube (air quality) | left/right PM → `atmo_pm2.5_avg` (also pm1/pm10 pairs in core) | mean of left/right tubes |
| LYS (ambient light) | LYS1/LYS2 lux and kelvin → `lys_lux_avg`, `lys_kelvin_avg` | mean of researcher + participant buttons |
| Greenery (Mapillary GVI) | `gvi_50m` | — |
| Morphology (CamUp Holmer) | `SVF`, `TVF`, `BVF` | — |
| Terrain (derived) | `gps_segment_slope_pct` from `ucm_GPS_alt` | H5 hotspot engine only |

Single-factor composite (default): For each environmental column above, H6 defines one composite equal to stress-oriented within-person z at phase mean: z(`Y`) within participant across the four core phases, times stress_direction (+1 if higher raw values imply higher environmental load, −1 for “protective” geometry such as higher SVF/TVF/GVI). This parallels the proprietary ocular scaling goal (higher composite → higher stress-relevant exposure) while staying on the same z-scale as H1–H3 sensitivity models.

Optional multi-indicator groups (equal-weight mean of constituent single-factor composites after orientation):

| Group ID | Constituents | Interpretation |
|----------|--------------|----------------|
| `env_group_thermal` | UTCI, PET, MRT, HUMIDEX, air temperature | Thermal load bundle |
| `env_group_acoustic` | SND dBA | Sound exposure |
| `env_group_air_quality` | PM2.5 mean | Particulate exposure |
| `env_group_light` | lux + colour temperature means | Ambient light |
| `env_group_morphology` | SVF, TVF, BVF, GVI (oriented) | Sky–tree–building + greenery |
| `env_group_motion` | GPS speed | Travel pace / workload context |

Definitions are exported in `H6_composite_definitions.csv`.

### 9.5 Physiological stress composites (Empatica and ocular channels)

Confirmatory models use individual outcomes with CSV-specified transforms (e.g. **square root on tonic EDA**). For exploratory concordance, H6 treats each of the 26 locked physiological columns as a univariate stress composite: within-person z on phase means, stress-oriented sign, and optional log transform from `Normalization_H1toH4_all_parameters.csv` before z-scoring.

| System | Example columns | Typical stress_direction in H6 |
|--------|-----------------|--------------------------------|
| Sympathetic / arousal | `empatica_eda_tonic`, `empatica_eda_phasic`, `empatica_heart_rate` | +1 |
| Thermoregulation | `empatica_skin_temperature` | +1 (exploratory heat-load read) |
| Parasympathetic / recovery (HRV) | `empatica_hrv_td_sdnn`, `empatica_hrv_td_rmssd`, HF power, total power | −1 (lower variability → higher stress-oriented score) |
| Ocular workload | fixation rate, gaze velocity, dispersion (+); pupil diameter and fixation duration signed per literature alignment in H6 spec | mixed |

A multivariate physiological stress index (equal-weight mean across selected Empatica + ocular features) is not prespecified here; H6 reports pairwise concordance so collinearity among EDA, temperature and HRV remains visible. H5’s epoch-level microclimate stress index (MCSI) in `H5_core.R` (`h5_microclimate_stress_index`) combines person-centred UTCI and dBA with study-wide z of ocular composite and questionnaire stressor count — a separate exploratory construct for zone profiles, not duplicated in H6.

### 9.6 Concordance: ocular stress vs environmental composites

Primary analysis (H6): Repeated-measures correlation via `lm(composite_y ~ ParticipantID + composite_x)` on phase-mean tables (`H6_pairwise_rmcorr.csv`); Benjamini–Hochberg q = 0.05 over all fitted pairs (1,378 fit of 1,485 attempted; 403 q-significant per `H6_run_manifest.csv`—many are within-domain redundancies such as UTCI vs thermal group).

Proprietary `eyetracker_stress_composite` vs environmental single-factor composites (rmcorr r, 95% CI, q_FDR):

| Environmental composite | r_rm | q_FDR | Note |
|-------------------------|------|-------|------|
| GVI (`gvi_50m`, stress-oriented −1) | 0.68 | <0.001 | Higher proprietary ocular composite when lower greenery share |
| MRT | 0.65 | <0.001 | |
| UTCI | 0.64 | <0.001 | |
| PET | 0.64 | 0.001 | |
| TVF (stress-oriented −1) | 0.60 | 0.003 | |
| GPS speed | −0.59 | 0.003 | Faster matched phases → lower proprietary ocular composite |
| Air temperature (`ucm_AIR_temp`) | 0.59 | 0.003 | |
| Relative humidity | −0.57 | 0.006 | Higher ocular composite when drier person-centred phases |
| Building view factor | 0.52 | 0.016 | |
| Global horizontal irradiance | 0.48 | 0.034 | |
| HUMIDEX | 0.47 | 0.033 | |
| SVF (stress-oriented −1) | −0.44 | 0.052 | Raw p < 0.05; q slightly above 0.05 |
| SND dBA | 0.41 | 0.073 | Not FDR-significant |
| PM2.5 | 0.30 | 0.25 | |
| Lux / kelvin | 0.18 / 0.11 | >0.5 | Weak |

Environmental groups vs proprietary ocular composite: thermal group r = 0.58 (q ≈ 0.001); morphology group r = 0.32 (q ≈ 0.001); motion group r = −0.59 (q ≈ 0.003); acoustic, air-quality and light groups not FDR-significant.

Ocular vs physiological (selected): Proprietary composite correlates with person-centred fixation duration (r ≈ 0.84), blink duration (r ≈ 0.76), fixation rate (r ≈ 0.58), EDA tonic (r ≈ 0.63), and skin temperature (r ≈ 0.54) — several q_FDR < 0.05; pupil diameter shows negative r ≈ −0.53 (q ≈ 0.012), consistent with confirmatory H1 pupil contrasts not mapping one-to-one onto the fixation-based stress score.

Cross-domain examples (physio × env, q_FDR < 0.05): person-centred blink duration tracks thermal and morphology composites (e.g. vs PET r_rm ≈ 0.82, q < 10⁻⁶; vs GVI r_rm ≈ 0.81, q < 10⁻⁶); pupil diameter shows negative concordance with GVI/MRT (r_rm ≈ −0.81, q < 10⁻⁶), paralleling the proprietary ocular–greenery pattern above. Full pairwise table: `H6_pairwise_rmcorr.csv`.

### 9.7 Limitations

1. Exploratory multiplicity — Pairwise rmcorr across tens of composites inflates discovery risk; q_FDR is reported but does not upgrade findings to confirmatory claims.
2. Construct validity — Neither proprietary nor transparent ocular indices are validated clinical stress scales; they summarize visual sampling behaviour under outdoor motion.
3. Co-exposure — Environmental composites covary along routes (§3.1); partial correlations are not reported in H6.
4. Eye-tracker dropout — Missing phases (e.g. P13) reduce n; epoch and phase tables differ slightly.
5. Direction labels — Stress_orientation for humidity, greenery and HRV is heuristic for concordance display; thermal signs align with UTCI/PET literature but do not imply causal stress.

Honest scope: §9 supports hypothesis generation for §7–§8 epoch models (e.g. whether hotspot-level UTCI moderation of `delta_eyetracker_stress_composite` is worth pre-registering), not replacement of outcome-specific H1–H4 inference.

Cross-domain examples (proprietary ocular vs physiology / environment): thermal group ↔ skin temperature r<sub>rm</sub> ≈ 0.68 (q<sub>FDR</sub> < 0.001); thermal group ↔ blink duration r ≈ 0.79; thermal group ↔ pupil r ≈ −0.74. Full pairwise table: `H6_pairwise_rmcorr.csv`; 55 composite indices per `H6_run_manifest.csv`.


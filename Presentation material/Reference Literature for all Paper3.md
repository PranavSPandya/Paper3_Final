# Paper3 — reference bibliography

**Scope:** Literature and local PDFs cited by Paper3_Final code, screening reports, and normalization notebooks (existing bibliography; not a newly verified count of distinct works). **Sibling PDF root:** `Paper3_Github/Experiment papers/` — paths below as `[cite: Experiment papers/…]`.

**Also see (detailed cites / machine indexes):** `output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_paper_roles.csv` (152 parameter-reference mappings; not 152 distinct PDFs); `scripts/H1_H3_core.R` (`CITE_*`, H2 `LIT` table); `scripts/H4_core.R` (Step 2 keys, GVIF, centering); sibling `Experiment papers/H1 to H4/H4_Screening_Literature_Guide.md`; `documents/Statistical_Analysis_Reference.html`; `Presentation material/Sound_screening_pca_vif.md`; `Presentation material/H4_Selection_Flow.md`.

---

## Environmental measures & formulas

### SVF (sky view factor)

- **Construct:** exposure column `SVF` (0–1); scene `Sky_%`, vegetation/building percentages are segmentation components, not co-entered equivalents (`H4_core.R`, `H4_Selection_Flow.md` §8).
- **Pipeline:** CamUp hemispherical imagery → DeepLabV3+ (Xception65) segmentation → merged bout windows (`SVF - Chen et al 2018 - DeepLabv3+…pdf`).
- Qiu et al. 2017 — automatic SVF from street-view / panoramic segmentation context — [cite: Experiment papers/SVF - Qiu et al 2017 - Automatic Sky View Factor Estimation from Street View Photographs.pdf] (`H4_core.R` `[Qiu17]`).

### Sound

- **Overall level:** `ucm_SND_dBA` — CityFeel / UCM backpack sensor table; doi:10.1016/j.egypro.2017.07.427 (`H4_core.R` `[CityFeel17]`; `Sound_screening_pca_vif.md`).
- **Frequency bands (five broad proportions, sum to 1):** 20–125, 125–1000, 1000–4000, 4000–8000, 8000–20000 Hz — Welch PSD partition in `scripts/Updated_JOS_Environmental_sound_classification_with_YAMNet_yenshuo.ipynb` (`AUDIO_MIN_HZ`/`AUDIO_MAX_HZ`, `freq_prop_*`); The current all-numeric sound PCA includes these fields; see `Sound_screening_pca_vif.md`.
- **Current sound PCA:** 32 numeric sound exposure inputs after excluding category text and unidentified proportion; within-bout centering and unit-SD scaling; current minimum-10-PC setting gives 84.037%, while the 80% criterion alone gives nine PCs, B4-style candidate selection, then separate full-equation VIF screening — Jolliffe & Cadima 2016; King & Jackson 1999. Aitchison 1983 describes the earlier compositional alternative (`Sound_screening_pca_vif.md`, `H4_Selection_Flow.md`).
- Hamida, Eijkelenboom & Bluyssen 2024 — **p. 3:** low-frequency annoyance/stress **20–125 Hz** and mid-high sensitivity **3000–5000 Hz**; **p. 8:** sound types/levels at different frequencies; doi:10.1016/j.indenv.2024.100066 — [cite: Experiment papers/H1 to H4/H2 & H4 - Hamida et al 2024 - Guidance…sound exposure experiments.pdf]. Construct separation from dBA/type: `H4_Screening_Literature_Guide.md`; pipeline docstring in YAMNet sound notebook.
- Hamida 2023 — acoustical preferences review — [cite: Experiment papers/Hamida_2023_acoustical_preferences_review.pdf].
- Salamon 2014 — urban sound taxonomy/dataset — [cite: Experiment papers/Sound - Salamon 2014 - A Dataset and Taxonomy for Urban Sound Research.pdf].
- Cartwright et al. 2019 — SONYC urban sound tagging — [cite: Experiment papers/Sound - Cartwright et al. 2019 - SONYC Urban Sound Tagging taxonomy.pdf].
- Gemmeke et al. 2017 — AudioSet / YAMNet event ontology — [cite: Experiment papers/YAMNet - AudioSet Gemmeke 2017 - An ontology and human-labeled dataset for audio events.pdf].
- XTRACK — live-music segmentation with YAMNet — [cite: Experiment papers/Yamnet_threshold - XTRACK - Automatic Segmentation of Live Music with YAMNET.pdf].
- Affective acoustic scene / semantic-gap (YAMNet threshold QC) — [cite: Experiment papers/Yamnet_threshold - Bridging the Semantic Gap with Affective Acoustic Scene Analysis - an Information Retrieval-based Approach.pdf].
- Noise type ↔ HRV — [cite: Experiment papers/Sound - Effects of different noise types on heart rate variability in men.pdf].

### Clearness index (solar)

- **Formulas (`H4_core.R`, `[ClearCI]`):** clearness index **k_t = G_h / G_0** (eq. 2, p. 3); **G_0** = extraterrestrial irradiance from date/time/location only (denominator, not a personal exposure); measured solar exposure representative = **`ucm_SUN_Gh`**. Step 2 excludes derived `Clearness_Index`, `Clearness_Index_G0` (redundant with G_h; Zhu et al. 2024 mixtures logic).
- Adaptive design / daily clearness state (k_t definition) — [cite: Experiment papers/Clearness_Index - Adaptive Design of Solar-Powered Energy Systems Based on Daily Clearness State Evolution.pdf].
- Hourly solar radiation models (G_0 estimation context) — [cite: Experiment papers/Clearness_Index - Evaluation of Hourly Solar Radiation Models to Estimate Radiation on Inclined Surfaces in Dry Zone of Sri Lanka.pdf].

### Thermal / UCM (PET, UTCI, MRT, Humidex)

- CityFeel / UCM 2017 — `ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_WIND_AWS`, IR channels → **`ucm_MRT`**, `ucm_SUN_Gh`, derived **`ucm_PET`**, **`ucm_UTCI`**, **`ucm_HUMIDEX`**; doi:10.1016/j.egypro.2017.07.427 (`H4_core.R`).
- Brode et al. 2012 — UTCI outdoor thermal stress; doi:10.1007/s00484-011-0454-1 (sibling `H4_Screening_Literature_Guide.md`).
- Matzarakis & Mayer — UTCI/PET/mPET comfort ranges — [cite: Experiment papers/Air temp - Defining thermal comfort range of UTCI PET and mPET.pdf]; PET stress categories — [cite: Experiment papers/Air temp - PET thermal stress thresholds Matzarakis Mayer categories.pdf]; unverified copy — [cite: Experiment papers/H1 to H4/H4 - UNVERIFIED - Matzarakis & Mayer 1999 - …pdf].
- Outdoor temperature ↔ HR/BP — [cite: Experiment papers/Air temp - Outdoor temperature heart rate and blood pressure in Chinese adults.pdf].
- Music/temperature ↔ HR — [cite: Experiment papers/Air temp - Effects of music and temperature changes on heart function and human error.pdf].
- Empatica thermal comfort decoding — [cite: Experiment papers/Empatica - A novel methodology for human thermal comfort decoding via physiological signals.pdf].
- Personal thermal comfort wearables 2018 — [cite: Experiment papers/LMM_transform_evidence/Personal_thermal_comfort_wearable_sensors_2018.pdf].
- DTU thermal comfort physiological sensing 2025 — [cite: Experiment papers/LMM_transform_evidence/Thermal_comfort_physiological_sensing_DTU_2025.pdf].
- Outdoor small-n wearable thermal studies (MD) — [cite: Experiment papers/outdoor_small_n_wearable_thermal_studies.md].
- Nikolopoulou et al. 2001 — outdoor thermal comfort (`Paper3_outline_ml.md`).
- Mansi et al. 2022 — outdoor thermal comfort methodology (`Paper3_outline_ml.md`).

### Air quality / PM

- **`atmo_pm1_avg`, `atmo_pm2.5_avg`, `atmo_pm10_avg`** — row-wise bilateral means; participant-phase mean centered and pooled-SD scaled in H4 (`H4_core.R`).
- Biel et al. 2020 — acute cardiovascular effects of air pollutants and noise — [cite: Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf].
- Short-term noise, PM, NOx ↔ ambulatory BP — [cite: Experiment papers/Short-term exposure to noise, fine particulate matter and nitrogen oxides on ambulatory blood pressure A repeated-measure study_similar.pdf].
- Traffic exposures 2015 — inflammation, BP, HRV — [cite: Experiment papers/H1 to H4/H4 - Traffic exposures 2015 - Repeated inflammation blood pressure and HRV.pdf].
- Zhu et al. 2024 — multiple pollutant mixtures / redundant derived exposures — [cite: Experiment papers/H1 to H4/H4 - Zhu et al 2024 - A review of common statistical methods…pdf] (`H4_core.R` `[Zhu24]`).

### GVI (greenery)

- **Construct:** `gvi_50m` (0–100%) retained; alternate buffers/components excluded (`H4_core.R`); eye-level panoramic imagery merge.
- (No dedicated GVI-methods PDF in roles CSV; construct documented in `H4_Selection_Flow.md` and merge provenance in `H4_core.R`.)

### Light / LYS (lux, kelvin, melanopic)

- **`lys_lux_avg`, `lys_kelvin_avg`** retained; derived **`lys_medi_avg`** excluded (RGB-estimated melanopic EDI) — Beiglary et al. 2025 JMIR Aging e72338; Ishihara et al. 2025 *SLEEP* zsaf358 (`H4_core.R` `[Beiglary25]`, `[Ishihara25]`).
- CIE S 026/E:2018 — photopic vs melanopic metrology (sibling screening guide).
- Stevenson et al. — LYS / correlated colour temperature; doi:10.1177/14771535251338582 (`H4_Transparency_Report.md`).
- Sonneborn & Voss — field light-exposure methods — [cite: Experiment papers/LYS ranges - FIELD STUDIES OF HUMAN LIGHT EXPOSURE DURING EVERYDAY ACTIVITIES – METHODOLOGICAL ASPECTS AND INITIAL RESULTS.pdf] (`H4_core.R` `[Sonneborn]`).
- Chinazzo et al. 2019 — daylight ↔ thermal perception — [cite: Experiment papers/Atmo LYS - Daylight affects human thermal perception.pdf].
- Indoor temperature/glazing/colour ↔ daylight perception — [cite: Experiment papers/Atmo LYS - Effect of Indoor Temperature and Glazing with Saturated Color on Visual Perception of Daylight.pdf].
- Indoor temperature/illuminance ↔ visual perception — [cite: Experiment papers/Atmo LYS - Influence of indoor temperature and daylight illuminance on visual perception.pdf].
- Obeng-Gyasi et al. 2025 — naturalistic illuminance patterns — [cite: Experiment papers/LMM_transform_evidence/Illuminance - Obeng-Gyasi et al 2025 - …pdf].

---

## Normalization & Parameter Screening
From `output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_paper_roles.csv` + `scripts/Normalization & Parameter Screening/Normalization_H1toH4.ipynb`.

### exposure_center (15)
- [cite: Experiment papers/Air temp - Defining thermal comfort range of UTCI PET and mPET.pdf]
- [cite: Experiment papers/Air temp - Effects of music and temperature changes on heart function and human error.pdf]
- [cite: Experiment papers/Air temp - Outdoor temperature heart rate and blood pressure in Chinese adults.pdf]
- [cite: Experiment papers/Air temp - PET thermal stress thresholds Matzarakis Mayer categories.pdf]
- [cite: Experiment papers/Atmo LYS - Daylight affects human thermal perception.pdf]
- [cite: Experiment papers/Empatica - A novel methodology for human thermal comfort decoding via physiological signals.pdf]
- [cite: Experiment papers/H1 to H4/H2 & H4 - Hamida et al 2024 - Guidance to investigate university students' bodily responses and perceptual assessments in sound exposure experiments.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf]
- [cite: Experiment papers/H1 to H4/H4 - UNVERIFIED - Matzarakis & Mayer 1999 - PET thermal stress thresholds categories.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Zhu et al 2024 - A review of common statistical methods for dealing with multiple pollutant mixtures and multiple exposures.pdf]
- [cite: Experiment papers/Hamida_2023_acoustical_preferences_review.pdf]
- [cite: Experiment papers/Methodology - A review of common statistical methods for dealing with multiple pollutant mixtures and multiple exposures.pdf]
- [cite: Experiment papers/outdoor_small_n_wearable_thermal_studies.md]
- [cite: Experiment papers/Short-term exposure to noise, fine particulate matter and nitrogen oxides on ambulatory blood pressure A repeated-measure study_similar.pdf]
- [cite: Experiment papers/Sound - Effects of different noise types on heart rate variability in men.pdf]

### light_exposure (7)
- [cite: Experiment papers/Atmo LYS - Effect of Indoor Temperature and Glazing with Saturated Color on Visual Perception of Daylight.pdf]
- [cite: Experiment papers/Atmo LYS - Influence of indoor temperature and daylight illuminance on visual perception.pdf]
- [cite: Experiment papers/Clearness_Index - Adaptive Design of Solar-Powered Energy Systems Based on Daily Clearness State Evolution.pdf]
- [cite: Experiment papers/Clearness_Index - Evaluation of Hourly Solar Radiation Models to Estimate Radiation on Inclined Surfaces in Dry Zone of Sri Lanka.pdf]
- [cite: Experiment papers/H1 to H4/H1-H4 - Cnaan, Laird & Slasor 1997 - Using the general linear mixed model to analyse unbalanced repeated measures and longitudinal data.pdf]
- [cite: Experiment papers/LYS ranges - FIELD STUDIES OF HUMAN LIGHT EXPOSURE DURING EVERYDAY ACTIVITIES – METHODOLOGICAL ASPECTS AND INITIAL RESULTS.pdf]
- [cite: Experiment papers/Yamnet_threshold - Bridging the Semantic Gap with Affective Acoustic Scene Analysis - an Information Retrieval-based Approach.pdf]

### transform (8)
- [cite: Experiment papers/Empatica - HRV_task_force_team_europe_1996-1.pdf]
- [cite: Experiment papers/H1 to H4/H2 & H4 - Enders & Tofighi 2007 - Centering Predictor Variables.pdf]
- [cite: Experiment papers/Normalization - ANCOVA - Vickers 2001 - Analysing controlled trials with baseline and follow up measurements.pdf]
- [cite: Experiment papers/Normalization - Vickers 2001 - Analysing controlled trials with baseline and follow up measurements.md]
- [cite: Experiment papers/Normalization - Zscored - Bush 1993 - Transformations for within-subject designs A Monte Carlo investigation.pdf]
- [cite: Experiment papers/Normalization - Zscored - Lykken 1971 - Direct measurement of skin conductance A proposal for standardization.pdf]
- [cite: Experiment papers/Psychophysiology - May 1981 - Fowles - Publication Recommendations for Electrodermal Measurements.pdf]
- [cite: Experiment papers/Statistics - Enders & Tofighi 2007 - Centering Predictor Variables.pdf]

### native_physio (26)
- [cite: Experiment papers/Empatica - A foundation model for electrodermal activity data.pdf]
- [cite: Experiment papers/Empatica - Duration - An Overview of Heart Rate Variability Metrics and Norms.pdf]
- [cite: Experiment papers/Empatica - Duration - Heart rate variability stabilization in athletes towards more convenient data acquisition.pdf]
- [cite: Experiment papers/Empatica - Electrodermal Activity as a Unimodal Signal for Aerobic Exercise Detection in Wearable Sensors.pdf]
- [cite: Experiment papers/Empatica - Evaluating Biosignals for Stress Detection in Ambulatory Settings.pdf]
- [cite: Experiment papers/Empatica - Extending Stress Detection Reproducibility to Consumer Wearable Sensors.pdf]
- [cite: Experiment papers/Empatica - Kyriakou et al 2019 - An Individual-Oriented Algorithm for Stress Detection in Wearable Sensor Measurements.pdf]
- [cite: Experiment papers/Empatica - Stress in the City Multimodal Biosensing of Urban Stress.pdf]
- [cite: Experiment papers/Empatica_data_manual.pdf]
- [cite: Experiment papers/Eyetracker - Enhancing mobile eye tracking in extreme urban lighting conditions.pdf]
- [cite: Experiment papers/Eyetracker - Evans et al 2012 - Collecting and analyzing eye-tracking data in outdoor environments.pdf]
- [cite: Experiment papers/Eyetracker - Fleming et al 2024 - The nature gaze outdoor eye tracking wellbeing.pdf]
- [cite: Experiment papers/Eyetracker - Mahanama et al 2021 - Eye movement and pupil measures review.pdf]
- [cite: Experiment papers/Eyetracker - Rupi and Krizek 2019 - Visual eye gaze while cycling urban intersections.pdf]
- [cite: Experiment papers/Eyetracker - Tomasi et al 2016 - Mobile gaze tracking outdoor walking behavioral studies.pdf]
- [cite: Experiment papers/Eyetracker - Trefzger et al 2018 - Visual comparison gaze pedestrians cyclists.pdf]
- [cite: Experiment papers/Eyetracker - Vansteenkiste et al 2014 - Cycling around a curve gaze behavior.pdf]
- [cite: Experiment papers/Eyetracker - Wang et al 2024 - Eye tracking measures of bicyclists behavior and perception A systematic review.pdf]
- [cite: Experiment papers/H1 to H4/H1 & H3 - Chrisinger & King 2018 - SENSE Citizen Science Empatica.pdf]
- [cite: Experiment papers/H1 to H4/H1 - Gidlow et al 2016 - Walking Natural Urban Environments.pdf]
- [cite: Experiment papers/Statistics - Chrisinger & King 2018 - SENSE Citizen Science Empatica.pdf]
- [cite: Experiment papers/Statistics - Gidlow et al 2016 - Walking Natural Urban Environments.pdf]
- [cite: Experiment papers/Statistics - Hunter et al 2019 - Urban Nature Experiences Reduce Stress.pdf]
- [cite: Experiment papers/Statistics - Kim et al 2023 - Location-based Collective Distress Biosignals.pdf]
- [cite: Experiment papers/Statistics - Torku et al 2023 - Older Pedestrians Urban Stress Empatica.pdf]
- [cite: Experiment papers/The Influence of Urban Context on Emotions and Bodily Responses During Walking_similar.pdf]

### hrv_qc (9)
- [cite: Experiment papers/Empatica - Artefact - A continuous wavelet transform-based method for time-frequency analysis of artefact-corrected heart rate variability data.pdf]
- [cite: Experiment papers/Empatica - Artefact - Publication guidelines for human heart rate and heartrate variability studies in psychophysiology—Part1 Physiological underpinnings and foundations ofmeasurement.pdf]
- [cite: Experiment papers/Empatica - Duration - A Critical Review of Ultra-Short-Term Heart Rate Variability Norms Research.pdf]
- [cite: Experiment papers/Empatica - Duration - Minimal Window Duration for Accurate HRV Recording in Athletes.pdf]
- [cite: Experiment papers/Empatica - Reliability of Ultra-Short-Term Analysis as a Surrogate of Standard 5-Min Analysis of Heart Rate Variability.pdf]
- [cite: Experiment papers/Empatica - Validity of the Empatica E4 wristband to estimate resting-state heart rate variability in a lab-based context.pdf]
- [cite: Experiment papers/Empatica - Wearable Electrodermal Activity Signal Quality and Artifact Detection.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Traffic exposures 2015 - Repeated inflammation blood pressure and HRV.pdf]
- [cite: Experiment papers/Impact of Using Different Levels of Threshold-Based Artefact Correction on the Quantification of Heart Rate Variability in Three Independent Human Cohorts.pdf]

### lmm_physio (15)
- [cite: Experiment papers/LMM_transform_evidence/EDA - Vocks et al 2021 - Electrodermal Response to Mirror Exposure in Restrictive Anorexia.pdf] ? filename attribution is incorrect: Knejzlikova et al. (2021), [doi:10.3389/fpsyg.2021.673597](https://doi.org/10.3389/fpsyg.2021.673597). Main EDA analyses used log SCR and square-root SCL; this is not evidence for blanket no transformation.
- [cite: Experiment papers/LMM_transform_evidence/EDA_recommendations_BIOPAC_Psychophysiology_2012.pdf]
- [cite: Experiment papers/LMM_transform_evidence/EDA_SCL_square_root_Nature_2025_self_harm.pdf]
- [cite: Experiment papers/LMM_transform_evidence/EDA_transform_BIOPAC_EDA_SCR_Analysis.pdf]
- [cite: Experiment papers/LMM_transform_evidence/EDA_transform_Figner_Murphy_2010_skin_conductance.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Eyetracker - Wang et al 2025 - Understanding Cyclists Visual Behavior Using Eye-Tracking Technology A Systematic Review.pdf]
- [cite: Experiment papers/LMM_transform_evidence/HR_EDA - Beggiato et al 2018 - Using Smartbands Pupillometry and Body Motion to Detect Discomfort in Automated Driving.pdf]
- [cite: Experiment papers/LMM_transform_evidence/HRV - Laborde Mosley Thayer 2017 - Heart Rate Variability and Cardiac Vagal Tone in Psychophysiological Research Recommendations.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Illuminance - Obeng-Gyasi et al 2025 - Characteristics of objectively-measured naturalistic light exposure patterns in US adults.pdf]
- [cite: Experiment papers/LMM_transform_evidence/LMM_physio_stress_Frontiers_2023_Tervonen.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Personal_thermal_comfort_wearable_sensors_2018.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Pupil - Imburgio et al 2024 - Electrocortical Responses in Anticipation of Avoidable and Inevitable Threats A Multisite Study.pdf]
- [cite: Experiment papers/LMM_transform_evidence/TEMP_EDA_HR - Zhang et al 2020 - Wearable Device for Measuring Students Cognitive Load based on EDA Body Temperature and HR.pdf]
- [cite: Experiment papers/LMM_transform_evidence/Thermal_comfort_physiological_sensing_DTU_2025.pdf]
- [cite: Experiment papers/LMM_transform_evidence/WPZ - Wang et al 2019 - On Standardizing Within-Person Effects Potential Problems of Global Standardization.pdf]

### not_physiology (7)
- [cite: Experiment papers/Sound - Cartwright et al. 2019 - SONYC Urban Sound Tagging taxonomy.pdf]
- [cite: Experiment papers/Sound - Salamon 2014 - A Dataset and Taxonomy for Urban Sound Research.pdf]
- [cite: Experiment papers/SVF - Chen et al 2018 - DeepLabv3+ Encoder-Decoder with Atrous Separable Convolution.pdf]
- [cite: Experiment papers/SVF - Qiu et al 2017 - Automatic Sky View Factor Estimation from Street View Photographs.pdf]
- [cite: Experiment papers/YAMNet - AudioSet Gemmeke 2017 - An ontology and human-labeled dataset for audio events.pdf]
- [cite: Experiment papers/Yamnet - Guidance to investigate university students bodily responses and perceptual assessments in sound exposure experiments.pdf]
- [cite: Experiment papers/Yamnet_threshold - XTRACK - Automatic Segmentation of Live Music with YAMNET.pdf]

### model (14)
- [cite: Experiment papers/H1 to H4/H1-H4 - Benjamini & Hochberg 1995 - Controlling the FDR.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Friedman Hastie Tibshirani 2010 - Regularization Paths for Generalized Linear Models via Coordinate Descent.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Hamra & Buckley 2018 - Environmental exposure mixtures questions and methods.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Heinze Wallisch Dunkler 2018 - Variable selection review and recommendations.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Lee et al 2016 - Exact post selection inference with LASSO.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Model choice 2021 - Chemical mixtures simulation study.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Naimi - usdm package vignette and stepwise VIF.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Sauerbrei et al 2020 - Selection of variables and functional forms.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Schelldorfer Buhlmann van de Geer 2011 - Penalized Linear Mixed Effects Models.pdf]
- [cite: Experiment papers/H1 to H4/H4 - Zou Hastie 2005 - Regularization and variable selection via the elastic net.pdf]
- [cite: Experiment papers/H1 to H4/H4_Screening_Literature_Guide.md]
- [cite: Experiment papers/Methodology - Environmental exposure mixtures questions and methods to address them.pdf]
- [cite: Experiment papers/Statistics - Benjamini & Hochberg 1995 - Controlling the FDR.pdf]
- [cite: Experiment papers/Statistics - Cnaan Laird & Slasor 1997 - GLMM for Unbalanced Repeated Measures.pdf]

### context (4)
- [cite: Experiment papers/H2 - Coherence and divergence in autonomic-subjective affective space - Cuve 2023.pdf]
- [cite: Experiment papers/H1 to H4/H2 - Cuve 2023 - Coherence and divergence in autonomic-subjective affective space.pdf]
- [cite: Experiment papers/Normalization - Methodological Foundations and Papers Guide.md]
- [cite: Experiment papers/Statistics - Bibliography and Justification.md]

### model — sibling screening guide DOIs (not duplicated as PDF rows)
- O'Brien 2007 — VIF cutoff caution; doi:10.1007/s11135-006-9018-6
- Dormann et al. 2013 — collinearity; doi:10.1111/j.1600-0587.2012.07348.x
- Zuur et al. 2010 — iterative VIF; doi:10.1111/j.2041-210X.2009.00001.x
- Jolliffe & Cadima 2016 — PCA review; doi:10.1098/rsta.2015.0202
- Horn 1965 — parallel analysis; doi:10.1007/BF02289447
- Glorfeld 1995 — Monte Carlo PCA retention; doi:10.1177/0013164495055003002
- Agier et al. 2016 — exposure selection; doi:10.1289/EHP172
- Brode et al. 2012 — UTCI; doi:10.1007/s00484-011-0454-1
- Joubert et al. 2026 — mixtures workflow (`H4_core.R`)

### Code / manuscript only (132-audit items not in roles CSV)
- Pinheiro & Bates 2000 — mixed-effects / AR(1); doi:10.1007/b98882 (`H1_H3_core.R`, H4)
- Lenth 2023 — emmeans (`H1_H3_core.R`)
- Bonett 2008 — paired SMD; doi:10.1037/1082-989X.13.2.99 (`H1_H3_core.R`)
- Bakdash & Marusich 2017 — rmcorr; doi:10.3389/fpsyg.2017.00456 (`H1_H3_core.R`)
- Ben-Shakhar 1985 — WPZ; doi:10.1111/j.1469-8986.1985.tb01603.x (`H1_H3_core.R`)
- Curran & Bauer 2011 — multilevel centering (`H4_core.R`)
- Fox & Monette 1992 — GVIF; doi:10.1080/01621459.1992.10475190 (`H4_core.R`)
- Pustejovsky & Tipton 2018; Tipton 2015 — CR2 small-cluster df (`H4_core.R`)
- CityFeel / UCM 2017 — doi:10.1016/j.egypro.2017.07.427
- Beiglary et al. 2025; Ishihara et al. 2025 — melanopic EDI exclusion (`H4_core.R`)
- Stevenson et al. — LYS CCT; doi:10.1177/14771535251338582
- CIE S 026/E:2018 — ipRGC metrology (screening guide)
- Aitchison 1983 — clr PCA; doi:10.2307/2335943
- Stuyck et al. 2022; Quigley et al. 2024 — E4/HRV reporting (`Paper3_outline_ml.md`)
- Kaplan 1995; Nikolopoulou et al. 2001; Mansi et al. 2022 — urban/thermal context (`Paper3_outline_ml.md`)
- H2 `LIT` (no local PDF): Boucsein 2012; Dawson et al. 2017; Shaffer & Ginsberg 2017; Billman 2013; Van Doren et al. 2021; Ulrich et al. 1991; Romanovsky 2014; Charkoudian 2010; Mathot 2018; Rayner 1998; Schleicher et al. 2008; Bentivoglio et al. 1997; Berto et al. 2008; Franconeri et al. 2013; Valtchanov & Ellard 2015; Tatler 2007; Stern et al. 1994

### PCA (sound frequency) — method refs only
- Aitchison 1983 clr-PCA; Hamida 2024 (20–125 Hz; 3000–5000 Hz; frequency vs level); Jolliffe & Cadima 2016 (PCA overview); King & Jackson 1999 (evaluated 80/90% criteria); CityFeel dBA separation — **`Presentation material/Sound_screening_pca_vif.md`**; script `scripts/Normalization & Parameter Screening/PCA-informed_sound_frequency.py`.

---

## Hypothesis testing

### H1 — green infrastructure vs reference routes

- **Question:** Do physiological outcomes differ between green and reference routes within bike (H1.1 BikeG−BikeU) and walk (H1.2 WalkG−WalkU) modes?
- **Formulas (`H1_to_H3.R`):** `H1_PhaseMean_Primary_LMM` — `lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID)`; `H1_PhaseMean_Sensitivity_WPZ_LMM` — same with within-person z-scored outcome; `H1_Temporal_AR1_10s_LMM` / `H1_Temporal_AR1_60s_LMM` — `lme(wpz_outcome ~ PhaseID * time_min, random = ~ 1 | ParticipantID, correlation = corAR1(~ time_step | ParticipantID / PhaseID))`; difference-of-differences `(BikeG − BikeU) − (WalkG − WalkU)` reported alongside planned contrasts; paired SMD via `statpsych::ci.stdmean.ps`.
- **References:** Pinheiro & Bates 2000 (`nlme`, REML, `corAR1`); Lenth 2023 `emmeans` phase contrasts; Bonett 2008 paired SMD CIs; Ben-Shakhar 1985 WPZ sensitivity; Benjamini & Hochberg 1995 BH-FDR (families: primary / WPZ / temporal per term); Gidlow et al. 2016; Hunter et al. 2019; Kaplan 1995 restorative framework (`Paper3_outline_ml.md`).

### H3 — active travel mode contrasts

- **Question:** Walking vs biking on reference (H3.1 WalkU−BikeU) and green (H3.2 WalkG−BikeG) routes?
- **Formulas:** `H3_PhaseMean_Primary_LMM`, `H3_PhaseMean_Sensitivity_WPZ_LMM`, `H3_Temporal_AR1_10s_LMM`, `H3_Temporal_AR1_60s_LMM` — same shells as H1 (`H1_to_H3.R`); emmeans reference level BikeU.
- **References:** Same statistical core as H1 (Pinheiro & Bates; Lenth `emmeans`; Bonett; Ben-Shakhar WPZ; BH-FDR).

### H2 — psychophysiological concordance

- **Question:** Within-person association between end-of-phase questionnaires and phase-mean physiological outcomes across four mobility conditions?
- **Formulas:** `H2_rmcorr` — `lm(psychological ~ ParticipantID + physiological)` (common within-person slope; Bakdash & Marusich 2017); 4 × 26 = 104 pairs; one BH-FDR family.
- **References:** Bakdash & Marusich 2017 rmcorr; BH-FDR; Cuve et al. 2023 pupil/autonomic context; **`H1_H3_core.R` `LIT` table** — Boucsein 2012; Dawson et al. 2017; Laborde et al. 2017; Shaffer & Ginsberg 2017; Task Force ESC/NASPE 1996; Billman 2013 LF/HF; Van Doren et al. 2021; Ulrich et al. 1991; Romanovsky 2014; Charkoudian 2010; Mathot 2018; Rayner 1998; Schleicher et al. 2008; Bentivoglio et al. 1997; Berto et al. 2008; Franconeri et al. 2013; Valtchanov & Ellard 2015; Tatler 2007; Stern et al. 1994; Kim et al. 2023; Torku et al. 2023.

### H4 — noise amplification on thermal discomfort (multivariate bout LMM)

- **Question:** Within 10 s bout windows, do heat × sound interactions and covariates (MRT, solar, SVF, PM, light, GVI, phase) associate with physiological/ocular outcomes (exploratory secondary models)?
- **Formulas (`H4_multivariate.R` — six meeting-spec equations; names match `H4_Selection_Flow.md` table):**
  - **Eq1 (Primary):** UTCI × Sound + MRT × Sound + `ucm_SUN_Gh` + `SVF` + PM2.5 + lux + kelvin + GVI + sum-to-zero phase (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`); `random = ~ 1 | ParticipantID / PhaseID`; `corAR1(~ Time10 | ParticipantID / PhaseID)`.
  - **Eq2 (Heat sensitivity — air temp, RH, wind):** AIR_temp × Sound + RH × Sound + wind × Sound + MRT × Sound + shared covariates/phases/AR(1).
  - **Eq3 (Heat sensitivity — HUMIDEX):** HUMIDEX × Sound + MRT × Sound + shared block.
  - **Eq4 (Heat sensitivity — PET):** PET × Sound + MRT × Sound + shared block.
  - **Eq5 (PM size — PM1):** UTCI × Sound + MRT × Sound + PM1 + shared block.
  - **Eq6 (PM size — PM10):** UTCI × Sound + MRT × Sound + PM10 + shared block.
  - **Prep:** within-bout exposure centering (Enders & Tofighi 2007; Curran & Bauer 2011); forced exertion `empatica_vector_magnitude`; optional 60 s lag sensitivity; ARMA(2,0) when AR(1) ρ > 0.95 (`H4_core.R`).
- **References:** Pinheiro & Bates 2000 (`nlme` REML, nested random, AR(1)); **clubSandwich** CR2 cluster-robust SEs, Satterthwaite df, HTZ Wald phase contrasts (Pustejovsky & Tipton 2018; Tipton 2015 low-df flag); Fox & Monette 1992 GVIF / `car::vif` (threshold 5, design-only); Benjamini & Hochberg 1995 (thermal terms per equation × 26 outcomes; phase contrasts separate family); CityFeel17; ClearCI k_t; Qiu17 SVF; Beiglary25 / Ishihara25 / Sonneborn light; Zhu24 / Joubert26 mixtures redundancy; Brode UTCI; sibling **H4_Screening_Literature_Guide.md** (O'Brien, Dormann, Zuur, Jolliffe, Horn, Glorfeld, Agier); Hamida24 sound bands; Aitchison clr-PCA for frequency screening.

---

## Reference index (repo paths)

| File path | What references it holds |
| --- | --- |
| `Presentation material/Reference Literature for all Paper3.md` | This master bibliography |
| `scripts/H1_H3_core.R` | `CITE_*` strings; H2 `LIT` expectation citations |
| `scripts/H1_to_H3.R` | Named H1/H2/H3 model quotes and contrast specs |
| `scripts/H4_multivariate.R` | Eq1–Eq6 LMM formulas and equation metadata |
| `scripts/H4_core.R` | Exposure definitions, Step 2 keys, GVIF, CR2 inference, centering |
| `output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_paper_roles.csv` | Experiment-papers PDF inventory by normalization role |
| `output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_transformation_votes.csv` | Literature vote counts by physiology vote group and environmental exposure group |
| `scripts/Normalization & Parameter Screening/Normalization_H1toH4.ipynb` | Per-column reference index → PDF paths; `PHYSIO_LITERATURE_VOTES` and environment roll-ups |
| `Presentation material/Sound_screening_pca_vif.md` | Sound PCA candidate selection and separate VIF screening |
| `Presentation material/H4_Selection_Flow.md` | H4 retention narrative, Eq1–6 labels, SVF/GVI rules |
| `output/statistical_analysis/results/H4_results/_work/H4_models/H4_gvif_diagnostic.md` | Fox & Monette GVIF diagnostic |
| `output/statistical_analysis/results/H4_results/_work/H4_Transparency_Report.md` | CityFeel, Stevenson, Beiglary/Ishihara evidence |
| `documents/Statistical_Analysis_Reference.html` | Method cards (EDA, HRV window, Cuve, Chrisinger, Enders, …) |
| `documents/Paper3_outline_ml.md` | Manuscript-level refs (Kaplan, Nikolopoulou, Stuyck, Quigley, …) |
| `Paper3_Github/Experiment papers/H1 to H4/H4_Screening_Literature_Guide.md` | Screening policy, PCA/VIF/mixtures DOIs |
| `Paper3_Github/Experiment papers/Statistics - Bibliography and Justification.md` | Cross-hypothesis statistics PDF index |


## Current evidence and output status

| Item | Verified observation | Scope |
|---|---|---|
| Normalization | 224 source columns plus six bilateral means; 27 physiology rows and 124 environmental fields | Current inventory and transformation specification; not full-text verification of every old paper claim |
| Sound screening | 34 sound fields inventoried, category text and unidentified proportion excluded; 32 inputs, ten PCs explaining 84.037%, ten representatives | Minimum-ten setting is explicit; 80% alone requires nine PCs |
| Full Eq1 + ten sound terms | Maximum per-term VIF 3.092 across 26 outcome-specific designs; all full rank | Design diagnostic, not fitted-model validation |
| H1/H3 saved results | Primary H1: 11; primary H3: 10; sensitivity H1: 12; sensitivity H3: 11 q<0.05 rows | Saved 12 October run; saved input differs from current input |
| H2 saved results | Five of 104 saved associations q<0.05 | Saved snapshot, not regenerated with current input |

Detailed saved results and freshness evidence: [H1_to_H3_Methodology_Map.md](../output/statistical_analysis/results/H1_to_H3_Methodology_Map.md). Current transformation decisions and checked methodological sources: [Normalization_results.md](Normalization_results.md).

### Environmental transformation evidence checked in this update

- [Zauner, Guidolin & Spitschan (2025), How to Deal With Darkness](https://doi.org/10.1177/07487304251336624): logarithmic treatment of personal light data requires explicit zero handling; examples model light exposure and do not mandate logging lux as a predictor in every physiological model.
- [Biel et al. (2020)](https://doi.org/10.1038/s41598-020-73412-6): selected exposure transforms for UFP and black carbon; this is precedent for pollutant-specific decisions, not proof that PM1/PM2.5/PM10 must all be logged.
- [NIST, transformations to improve fit and equalize variances](https://www.itl.nist.gov/div898/handbook/pmd/section6/pmd624.htm): use regression form and error behaviour to assess transformations. A zero log-domain exclusion count does not validate a model or establish a literature recommendation.

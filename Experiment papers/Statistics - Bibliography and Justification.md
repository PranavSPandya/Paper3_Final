# Statistics – Bibliography and Justification

This document lists the research papers collected to defend the statistical methods, model choices and sensor methodology used in `script\Paper3_H1 to H4.ipynb`. All downloaded PDFs are saved in this folder with the prefix `Statistics - `. Papers that could not be retrieved as open-access PDFs are listed as **Citation only** with a DOI/URL.

---

## 1. Core statistical methods

| Paper | Citation | Relevance to notebook | File saved |
|---|---|---|---|
| Controlling the false discovery rate | Benjamini, Y., & Hochberg, Y. (1995). *Journal of the Royal Statistical Society: Series B (Methodological)*, 57(1), 289–300. doi:10.1111/j.2517-6161.1995.tb02031.x | Justifies the Benjamini–Hochberg FDR correction applied within each `Condition × Hypothesis` family. | `Statistics - Benjamini & Hochberg 1995 - Controlling the FDR.pdf` |
| Centering predictor variables in cross-sectional multilevel models | Enders, C. K., & Tofighi, D. (2007). *Psychological Methods*, 12(2), 121–138. doi:10.1037/1082-989X.12.2.121 | Defends the person-mean / within-cluster centering of `UTCI` and `SND` into `*_within_day_z` and `*_day_mean_z` components. | `Statistics - Enders & Tofighi 2007 - Centering Predictor Variables.pdf` |
| Tutorial in biostatistics: Using the general linear mixed model to analyse unbalanced repeated measures and longitudinal data | Cnaan, A., Laird, N. M., & Slasor, P. (1997). *Statistics in Medicine*, 16(20), 2349–2380. doi:10.1002/(SICI)1097-0258(19971030)16:20<2349::AID-SIM667>3.0.CO;2-E | Key reference for choosing LMM over repeated-measures ANOVA when participant-phase cells are unbalanced (e.g., 49–199 rows per cell). | `Statistics - Cnaan Laird & Slasor 1997 - GLMM for Unbalanced Repeated Measures.pdf` |
| Residual analysis for linear mixed models | Nobre, J. S., & Singer, J. M. (2007). *Biometrical Journal*, 49(6), 863–875. doi:10.1002/bimj.200610341 | Supports the residual screening and diagnostics reported in the notebook (conditional/marginal residuals, normality and homoscedasticity checks). Cited in the notebook. | **Citation only** (not open-access) |

---

## 2. Outdoor / wearable-sensor methodology

These papers show that Empatica E4 wristbands, GPS tracking, mobile eye tracking and outdoor physiological monitoring are established approaches for studying urban/green-space effects, directly supporting the experimental and sensor choices in Paper 3.

| Paper | Citation | Relevance to notebook | File saved |
|---|---|---|---|
| Where to put your best foot forward: Psycho-physiological responses to walking in natural and urban environments | Gidlow, C. J., Jones, M. V., Hurst, G., Masterson, D., Clark-Carter, D., Tarvainen, M. P., Smith, G., & Nieuwenhuijsen, M. (2016). *Journal of Environmental Psychology*, 45, 22–29. doi:10.1016/j.jenvp.2015.11.003 | Randomised crossover field trial comparing walking in green, blue and urban environments using salivary cortisol and HRV. Supports the outdoor walking paradigm and use of HRV/cortisol-like stress markers. | `Statistics - Gidlow et al 2016 - Walking Natural Urban Environments.pdf` |
| Urban nature experiences reduce stress in the context of daily life based on salivary biomarkers | Hunter, M. R., Gillespie, B. W., & Chen, S. Y.-P. (2019). *Frontiers in Psychology*, 10, 722. doi:10.3389/fpsyg.2019.00722 | Uses linear mixed models to analyse repeated real-life nature exposures and cortisol; supports both the outdoor ecological approach and the LMM analytical choice. | `Statistics - Hunter et al 2019 - Urban Nature Experiences Reduce Stress.pdf` |
| Older pedestrians' physiological reactions are indicative of stressful and non-stressful urban built environment conditions | Torku, A., Chan, A. P. C., Yung, E. H. K., & Seo, J. O. (2023). *Proceedings of the 6th Healthy City Design 2022*. doi:10.36820/2604-1983/2022/07.1 (eprint) | Outdoor walking study with older adults using Empatica E4 (EDA, PPG/HRV) and GPS in an urban built environment; supports the use of E4 for detecting environmental stressors. | `Statistics - Torku et al 2023 - Older Pedestrians Urban Stress Empatica.pdf` |
| Location-based collective distress using large-scale biosignals in real life for walkable built environments | Kim, J., Nirjhar, E. H., Lee, H., Chaspari, T., Lee, C., Ham, Y., Winslow, J. F., & Ahn, C. R. (2023). *Scientific Reports*, 13, 5940. doi:10.1038/s41598-023-33132-z | Large-scale real-life study using Empatica E4 (EDA, HR, IMU) and GPS; uses linear mixed-effects models. Supports ambulatory biosensing and LMM for environmental-stress analysis. | `Statistics - Kim et al 2023 - Location-based Collective Distress Biosignals.pdf` |
| Stress experiences in neighborhood and social environments (SENSE): A pilot study to integrate the quantified self with citizen science to improve the built environment and health | Chrisinger, B. W., & King, A. C. (2018). *International Journal of Health Geographics*, 17, 17. doi:10.1186/s12942-018-0140-1 | Pilot outdoor walking study using Empatica E4 + GPS + smartphone-based citizen science; reports associations between EDA and street/land-use characteristics using linear mixed models. | `Statistics - Chrisinger & King 2018 - SENSE Citizen Science Empatica.pdf` |
| Assessing the association between urban features and human physiological stress response using wearable sensors in different urban contexts | Zhang, Z., Amegbor, P. M., Sigsgaard, T., & Sabel, C. E. (2022). *Health & Place*, 78, 102924. doi:10.1016/j.healthplace.2022.102924 | Uses Empatica 4 wristband, wearable camera and GPS in urban public open spaces to link urban features (greenery, water, traffic) with GSR and skin-temperature stress responses. | **Citation only** (Elsevier) |
| The feasibility of integrating wearable cameras and health trackers for measuring personal exposure to urban features | Zhang, Z., Amegbor, P. M., & Sabel, C. E. (2022). *International Journal of E-Planning Research*, 11(1), 1–21. doi:10.4018/IJEPR.313181 | Pilot in Roskilde combining FrontRow wearable camera, GPS and Empatica 4 for personal urban exposure; defends the multi-sensor outdoor methodology. | **Citation only** (IGI Global / repository blocked by Cloudflare) |
| The urban brain: Analysing outdoor physical activity with mobile EEG | Aspinall, P., Mavros, P., Coyne, R., & Roe, J. (2015). *British Journal of Sports Medicine*, 49(4), 272–276. doi:10.1136/bjsports-2012-091877 | Landmark outdoor mobile EEG study comparing brain activity across green and urban walking routes; supports outdoor neurophysiological assessment of environmental quality. | **Citation only** (BMJ) |
| The restorative benefits of walking in urban and rural settings in adults with good and poor mental health | Roe, J., & Aspinall, P. (2011). *Health & Place*, 17(1), 103–113. doi:10.1016/j.healthplace.2010.09.003 | Quasi-experimental walking study comparing urban vs. rural environments; provides theoretical and empirical grounding for the Green vs. Urban environment contrast (H1). | **Citation only** (Elsevier) |

---

## 3. Sensor-specific references already present in `Experiment papers`

The following previously downloaded papers also support the sensor and transformation choices in the notebook; they are not duplicated here but are part of the complete evidence base.

| File(s) in `Experiment papers` | What they defend |
|---|---|
| `Empatica - HRV_task_force_team_europe_1996-1.pdf` | Task Force (1996) standards for HRV measurement and reporting; supports RMSSD/IBI processing. |
| `Empatica - Validity of the Empatica E4 wristband to estimate resting-state heart rate variability in a lab-based context.pdf` | Empatica E4 HRV validity. |
| `Empatica - Duration - An Overview of Heart Rate Variability Metrics and Norms.pdf` | HRV metric norms and short-duration recording considerations. |
| `Empatica - Electrodermal Activity as a Unimodal Signal for Aerobic Exercise Detection in Wearable Sensors.pdf` | EDA measurement with wearable sensors. |
| `LMM_transform_evidence/EDA_SCL_square_root_Frontiers_2021_mirror_exposure.html` and `EDA_transform_Figner_Murphy_2010_skin_conductance.pdf` | Rationale for square-root / log transformations of EDA and skin-conductance data. |
| `LMM_transform_evidence/LMM_physio_stress_Frontiers_2023_Tervonen.pdf` | LMM applied to physiological stress data. |
| `Eyetracker - Evans et al 2012 - Collecting and analyzing eye-tracking data in outdoor environments.pdf` | Outdoor eye-tracking methodology. |
| `Eyetracker - Fleming et al 2024 - The nature gaze outdoor eye tracking wellbeing.pdf` | Outdoor eye tracking and nature/wellbeing. |
| `Eyetracker - Tomasi et al 2016 - Mobile gaze tracking outdoor walking behavioral studies.pdf` | Mobile gaze tracking during outdoor walking. |

---

## 4. How each notebook method is covered

| Notebook element | Defended by |
|---|---|
| `statsmodels MixedLM` with random intercept + `PhaseBlock` variance component | Cnaan et al. (1997); Nobre & Singer (2007); Chrisinger & King (2018); Kim et al. (2023) |
| FDR correction (`benjamini_hochberg`) | Benjamini & Hochberg (1995) |
| Person-mean centering of `UTCI` / `SND` | Enders & Tofighi (2007) |
| Spearman rank correlation for H2 | Standard non-parametric method; see e.g. Bocianowski et al. (2024/2025) in `Biometrical Letters` for recent applications. |
| Residual diagnostics (Shapiro–Wilk, absolute residual-vs-fitted correlation) | Nobre & Singer (2007) |
| Model-based eta-squared effect size | Generalized eta-squared literature; see e.g. Olejnik & Algina (2003), *Educational and Psychological Measurement*. |
| Log / sqrt transformations of `empatica_log_hrv_td_rmssd` and `empatica_sqrt_eda_tonic` | Existing `LMM_transform_evidence/` files; Task Force (1996) for HRV standardisation. |
| Empatica E4 outdoor use | Torku et al. (2023); Kim et al. (2023); Chrisinger & King (2018); Zhang et al. (2022) |
| Outdoor eye tracking | Existing `Eyetracker - *.pdf` files; Aspinall et al. (2015) for mobile neurophysiology in outdoor settings. |
| Green vs. Urban / Walk vs. Bike environmental contrasts | Gidlow et al. (2016); Hunter et al. (2019); Roe & Aspinall (2011); Aspinall et al. (2015) |

---

## 5. Download notes

- All PDFs retrieved are open-access versions or author/publisher PDFs made available through institutional repositories (White Rose, Frontiers, Springer Nature, McMaster, University of Oslo, etc.).
- Some papers (Nobre & Singer 2007; Aspinall et al. 2015; Roe & Aspinall 2011; Zhang et al. 2022) are behind publisher paywalls and are therefore provided as citations with DOIs. They can be accessed through a university library or inter-library loan.

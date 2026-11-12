Paper screening list: documents/H4_papers_screened.md
Analysis phases: BikeU, WalkU, BikeG, WalkG, Tram
Tram is an additional passenger-exposure sensitivity. Walking-specific source methods retain WalkG/WalkU. Source descriptions of 44 bouts refer to the original core analysis, not this 55-bout sensitivity.

## Additional outdoor papers (verified 2026-11-06)
- Cureau2022: original Fisher exact comfort-domain method implemented separately by phase/site analogue. Seven-point overall comfort differs from source five-point item. No independent-local-sample Mann-Whitney test: this cohort is paired.
- Cureau2022 multinomial models NOT copied: complete original predictor panel / independent local respondents absent; tiny per-site cohort cannot support the source multivariable categorical models.
- Chen2023: original balanced RM factorial ANOVA with ranked source factor cannot be reconstructed from observational phases. Explicitly labelled continuous participant-LMM adaptation: rating ~ zUTCI * zdBA + zNaturalShare + (1|ParticipantID). This is not the published equation and does not reproduce its GG/HF corrections.
- Ueberham2019: no subjective noise-exposure/loudness item or equivalent subjective temperature-exposure item in this merged schema. Acoustic/thermal comfort are not equivalent. Original objective-versus-subjective exposure correlations / ordinal regressions NOT fitted.
- Li2025 DOI 10.1007/s00484-024-02790-7: publisher exposes abstract only. Exact model, arrival/departure matching and questionnaire definitions unverified; NOT fitted from abstract.
- New model and outcome choices are post-hoc additions. BH within paper/test; source p<.05 decision rule retained, not a confirmatory claim.

# H4 sound literature tests
Each block fits the source paper's own model. Where the 8-min / 11-participant data cannot support a step, the closest literal step is used and the limitation is listed here. q_BH (Benjamini-Hochberg within paper x test) is an extra column; each paper's own decision rule is reported separately (inference_note).

## Moshammer et al. 2019 (random-effects GLS, Stata xtreg re)
- Implemented: outcome in a sub-period ~ noise Leq (energy mean) of the PRECEDING sub-period per 1 dB(A) (Table A2, unadjusted) and + mean air temperature of the outcome sub-period (Methods: temperature as confounder); Stata default Swamy-Arora variance components, GLS transform, conventional VCE, z tests. Raw outcomes, no activity term, no centring.
- Window mapping: the paper uses consecutive 15-min periods with noise from the preceding 15 min; that cannot be fit within one 8-min bout. Here: energy-mean Leq of the first 5 min as exposure and phase-mean outcomes over the remainder (5-8 min), one row per phase (up to 44 rows). A window needs >= 2/3 of its expected 10-s rows (exposure 30 rows, outcome 18 rows). Fitted on all four phases and, separately, on walking phases only.
- All HRV outcomes (LF and HF power, SDNN, RMSSD, and mean RR distance) are recomputed per phase from the native beat-to-beat intervals (01_empatica_rri_native.csv) in the outcome window only (5-8 min of the matched bout, strictly after the 0-5 min exposure window), with the Empatica build method: beats 250-2500 ms, beats more than 0.45 s from the centred 11-beat median removed, >= 40 valid beats and <= 25 % removed. Resampling at 4 Hz quadratic-spline and Welch PSD for LF/HF; sample SD and RMSSD on the filtered beat intervals. This eliminates any overlap with the exposure window for all outcomes. 180 s exceeds the Task Force (1996) minimums (about 1 min for HF, 2 min for LF). VLF is dropped: it needs more than 5 min.
- The paper models no autocorrelation beyond the participant random effect; none is added here. Serial correlation within a participant may remain; standard errors may be optimistic.
- Dust: personal PM2.5 exists (Atmotube), but Table A2 reports single-exposure models, so PM is not added to the noise model.
- Temperature: the paper used a stationary meteorological station; here the mobile air temperature (ucm_AIR_temp).
- Outcomes: RR distance (mean RR from native beats), SDNN, RMSSD, LF and HF power (VLF dropped, see above). TINN and blood pressure are not in the dataset.

## Jin, Jin & Kang 2020 (two-way ANOVA)
- Implemented: two-way ANOVA LAeq level x UTCI category with interaction, no participant block. The paper does not state its SS type; because several LAeq x UTCI cells are empty, Type III marginal hypotheses are not uniquely defined, so main effects are Type II (each adjusted for the other main effect) and the interaction is tested against the additive model (the same F under Type II and Type III). All F tests use the full (interaction) model residual mean square and df as error term, as car::Anova(type = 2).
- Sound and UTCI are quartiles of the 44 phase means. The paper's 55-75 dB(A) and 9-46 C bins would drop quiet or cool bouts; those bouts are kept.
- 0 of 44 phase cells have missing sound or UTCI and cannot enter the ANOVA.
- Outcomes: TCV analogue = questionnaire_thermal_comfort_1_5 (5-point; paper 7-point); OCV analogue = questionnaire_current_comfort_1_7 (General Comfort, 7-point). TSV, subjective loudness and acoustic comfort were not collected. Paper unit = independent respondents; here 44 phase cells from 11 participants (repeated measures, not modelled, as in the paper: no participant block).
- Cell counts (all 44 phase cells, sound quartile x UTCI quartile):
  - Q1 | T1: n = 6
  - Q2 | T1: n = 4
  - Q3 | T1: n = 2
  - Q4 | T1: n = 2
  - Q1 | T2: n = 4
  - Q2 | T2: n = 5
  - Q3 | T2: n = 2
  - Q4 | T2: n = 3
  - Q1 | T3: n = 3
  - Q2 | T3: n = 4
  - Q3 | T3: n = 2
  - Q4 | T3: n = 4
  - Q1 | T4: n = 1
  - Q2 | T4: n = 1
  - Q3 | T4: n = 7
  - Q4 | T4: n = 5
- Empty or small cells are reported as they are; levels are not collapsed.

## Song et al. 2013 (winter) / 2014 (spring)
- Not fitted. documents/H4_papers_screened.md records no sound level and no thermal term. The source test is park versus city on heart rate and HRV, so there is no sound column to substitute.

## Rodrigues et al. 2026 (7.Model_H2.py)
- Implemented: Noise block [NOISE_max, NOISE_std] and Temperature block [Temp_max, Temp_mean], each in its own model; predictors fillna(0) then StandardScaler (population SD); REML mixed model with participant intercept; Wald z p; retention rule round(p,4) < 0.05 and |round(beta,4)| > 0.1.
- Outcomes (their code order): STD/MAX/MEAN/MIN of bpm, LF_HF_ratio, RMSSD and STD/MAX/MIN of skin temperature, raw (no transformation), over walking trips (WalkG, WalkU; 22 trips).
- Not available: EDA SCR amplitude and rise-time features (9 variables) and pNN50 (STD/MAX/MEAN/MIN): not in the merged dataset ; blocks Infrastructure, Functional POIs and Mapillary Visuals (Mapillary/OSM features not in the dataset).
- Exposure source differs: their NOISE from the Lisbon Lden map along the route and Temp from the IPMA daily station; here personal dBA and mobile air temperature per trip.

## Biel et al. 2020 (Scientific Reports 10:16703)
- Phase-mean specification: HR, SDNN, RMSSD (raw) and ln LF, ln HF, ln LF:HF at phase means ~ phase energy-mean personal dBA (per IQR) + phase-mean air temperature (+ phase-mean relative humidity when it changes the noise coefficient by >= 10%, their confounder rule); REML LMM, random participant intercept; Wald t.
- Repeated-window specification (their design at this grain): consecutive 2-min windows inside each 8-min bout (a window needs >= 2/3 of the expected 10-s rows), window-mean dBA and air temperature, random participant intercept plus nlme::corAR1() with the window index as the time variable; noise per IQR of the window means; same outcome transforms. This is the same repeated-short-window question as their 30-min models, at 2 min instead of 30 min.
- Window mapping: the source models 30-min mean personal exposures with random intercepts and slopes and AR(1). Random slopes are not fitted because a person has at most four windows here. Caffeine and alcohol were not recorded. Frequency-domain outcomes are means of the 5-min window estimates.

## Korpilo et al. 2024 (Urban Forestry & Urban Greening 95:128286)
- Implemented: ln phase-mean tonic EDA ~ NDSI analogue + phase-mean air temperature + phase-mean relative humidity + PhaseID; REML LMM, random participant intercept; Wald t on the NDSI term.
- NDSI analogue: (freq_proportion_2000_to_20000Hz - freq_proportion_200_to_2000Hz) / (their sum), phase mean of the 10-s rows; the source computes NDSI from 5-min recordings with 2-8 kHz as biophonic and 1-2 kHz as anthrophonic.
- Deviations: source uses a beta-logit GLMM on a normalised EDA index with respondent, group and order random effects; this campaign has no group or stop-order structure and tonic EDA in uS, so a Gaussian LMM on ln tonic EDA with a participant intercept is fitted. Their stops (forest, beach, park) have no counterpart; PhaseID is the phase factor. NDSI is this paper's own index, so this block is not repeated per alternative sound descriptor.

## Kraus et al. 2013 (additive mixed models)
- Implemented: outcomes HR, SDNN, LF (normalized units), HF (normalized units) and LF:HF; log except HR; piecewise Leq at 65 dB(A) per 5 dB; categorical physical activity (walk = 3 very light to light exertion, bike = 4 moderate exertion); HR adjustment for HRV models; long-term and daily time trends forced in, each linear, polynomial 2-4 or penalized spline by AIC; weekday tested by AIC; random participant intercept plus compound symmetry (nlme corCompSymm).
- Window mapping: the paper's non-overlapping 5-min intervals with Leq lags 0-5, 5-10 and 10-15 min. An 8-min bout yields one complete 5-min interval (0-5 min); only lag 0 is estimable. Lags 5-10 and 10-15 min require longer bouts and are not run. Lagged outcome (previous interval) is omitted because there is no prior 5-min interval within the bout. Validity: >= 2/3 valid 10-s rows per 5-min interval for Leq, HR and SDNN. LF_nu, HF_nu and LF_HF are themselves 5-min window estimates present only on rows whose window is complete (about half the rows of 0-5 min), so instead of the row rule they take the dataset's 5-min window that starts in the interval and ends within one 10-s epoch of its end (windows sit on a 10-s grid offset by one epoch), requiring >= 300 valid beats as in the paper.
- Autocorrelation: compound symmetry and participant random effect as in the paper; without a lagged outcome term, autocorrelation structure differs from the published model.
- Trend forms and weekday are selected by AIC (ML) on the lag-0 model and reused for each lag. AIC for spline candidates comes from the mgcv::gamm mixed-model representation (lme object, ML).
- Season is one summer (campaign 3 July to 27 August 2025), not a within-campaign season contrast; weekday is constant within each participant (one session each).
- Effect scale as the paper: percent change in the outcome mean per 5 dB(A) (HR: 100*beta/mean HR).
- AIC selection per outcome:
  - HR: trend forms: study_day=poly2, daily_time_h=linear; AIC(ML) base=394.754, +weekday=379.198 -> weekday kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=55 5-min intervals (interval 1 per phase)
  - SDNN: trend forms: study_day=linear, daily_time_h=linear; AIC(ML) base=-26.659, +weekday=-37.163 -> weekday kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=55 5-min intervals (interval 1 per phase)
  - LF_nu: trend forms: study_day=linear, daily_time_h=poly4; AIC(ML) base=-184.251, +weekday=-174.178 -> weekday not kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=38 5-min intervals (interval 1 per phase)
  - HF_nu: trend forms: study_day=linear, daily_time_h=poly4; AIC(ML) base=-206.596, +weekday=-185.424 -> weekday not kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=38 5-min intervals (interval 1 per phase)
  - LF_HF: trend forms: study_day=linear, daily_time_h=poly4; AIC(ML) base=-142.272, +weekday=-145.521 -> weekday kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=38 5-min intervals (interval 1 per phase)
- Kraus 5-min intervals built: 55 (interval 1 of 55 phases).

## Pigliautile et al. 2021 (CISBAT / J. Phys. Conf. Ser. 2042 012136)
- Source: NEXT.ROOM, 40 people sitting; C0 about 21 C then C1 about 23 C; seven headphone recordings; 5-point thermal, visual, acoustic and air-quality votes plus eight ISO soundscape descriptors. The paper plots C0 vs C1 means (Fig 3a) and woodland (#2) vs busy street (#7) at each temperature (Fig 3b). It does not report an LMM, ANOVA, or interaction coefficient. No 65 dB(A) or 26 C row drop.
- Implemented: (1) paired t-test of person-mean votes, warmer minus cooler, for thermal, visual, acoustic and air-quality comfort (Fig 3a analogue); (2) paired t-test of traffic minus nature person-mean pleasantness and acoustic comfort, separately at cooler and at warmer (Fig 3b analogue). Thermal is cooler vs warmer than that person's own mean air temperature. Soundscape is nature vs traffic from phase-mean YAMNet rural_natural_proportion vs vehicle_proportion. All 44 bouts. Headphones, assigned 21/23 C, and the eight ISO descriptors are not available.
- Field limitation: 0 of 11 people have all four thermal x soundscape cells, because cooler bouts are mostly nature/green and warmer bouts are mostly traffic/urban. The lab protocol crossed temperature with recording; this analogue cannot.
- Not repeated per alternative sound descriptor: the sound factor is already nature vs traffic share.

## Chiucchiù, Gnecco, Pigliautile & Pisello 2026 (Building and Environment 290:114140)
- Source: same NEXT.ROOM protocol, 25 complete sessions. Statistics that are not the CISBAT plots: Shapiro-Wilk (used only to choose methods, not reported as an H4 row); paired t-test plus Cohen d on mean Empatica EDAt, HR and skin temperature at C0 vs C1; paired C0 vs C1 on thermal sensation; Spearman among perceptual domains (thermal vs acoustic); C0-C1 deltas of eight soundscape descriptors for each of seven recordings (Table 5 / Fig 7); k-means on IPIP-NEO-120 then Spearman within personality cluster. No 65 dB(A) or 26 C row drop. No LMM.
- Implemented on all 44 bouts: (1) paired t-test plus Cohen d, warmer minus cooler person means, for heart rate, tonic EDA and skin temperature; (2) the same paired t on thermal_comfort_1_5 (TSV was not collected); (3) Spearman of thermal_comfort with acoustic_comfort and with pleasantness on the 44 phase cells; (4) paired t warmer minus cooler on pleasantness and acoustic comfort, separately within nature bouts and within traffic bouts (Table 5 analogue for #2 and #7).
- Not fitted: Big Five / IPIP-NEO-120 (not recorded), k-means personality clusters, PMV (source assumed 1.2 MET sitting; these bouts are walking and cycling), the eight ISO soundscape descriptors, EEG.
- Not repeated per alternative sound descriptor: the sound factor is already nature vs traffic share.

## Data source
- All blocks use the 10-s time-series rows of output/merged_all_11participants_8min.csv (the same input as H5_combined_timeseries.R). Rodrigues trip MEAN/STD/MAX/MIN are computed from those 10-s rows; Jin uses all 44 phases.

## Alternative sound variables
- 23 descriptors (8 YAMNet sound-category proportions, 15 spectral descriptors), as named in the merged CSV, each substituted for ucm_SND_dBA in every sound-dependent test: wind_proportion, rural_natural_proportion, vehicle_proportion, urban_manmade_neutral_proportion, urban_manmade_positive_proportion, urban_manmade_negative_proportion, mechanisms_proportion, unidentify_proportion, dominant_frequency_Hz, spectral_centroid_Hz, spectral_rolloff85_Hz, freq_proportion_20_to_200Hz, freq_proportion_200_to_2000Hz, freq_proportion_2000_to_20000Hz, octave_proportion_31_5_Hz, octave_proportion_63_0_Hz, octave_proportion_125_0_Hz, octave_proportion_250_0_Hz, octave_proportion_500_0_Hz, octave_proportion_1000_0_Hz, octave_proportion_2000_0_Hz, octave_proportion_4000_0_Hz, octave_proportion_8000_0_Hz.
- Aggregation: dBA uses the energy mean; descriptors use the arithmetic mean, and max/SD for the Rodrigues NOISE_max/NOISE_std terms.
- The dB(A) thresholds of the papers do not apply to these descriptors, so they are replaced: Kraus 65 dB(A) knot -> the descriptor's median 5-min value, slope per 5 dB -> per 1 SD of the 5-min values; Jin sound and UTCI -> quartiles of the 44 phase means; Moshammer slope per 1 unit of the descriptor (Hz or proportion 0-1).
- Not repeated: the Rodrigues Temperature block (no sound term), Korpilo (its sound term is the NDSI analogue), Pigliautile and Chiucchiù (sound factor is nature vs traffic share). Song is not fitted at all. No 65 dB(A) or 26 C row drop in any block.
- FDR: Benjamini-Hochberg within paper x test x sound variable (the sound variable is part of the test label), i.e. the same outcome families as the dBA analysis, applied separately per descriptor. No correction across the 24 sound variables.
- Rows: the test label carries [descriptor] for the alternatives (dBA rows have no suffix); SUMMARY has a sound_variable column.
- Per-descriptor Kraus knot, scale and AIC trend choices:
  - wind_proportion (sound_category_proportion): Kraus knot = median 0.006667, slope per 1 SD = 0.1608; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly4 | HF_nu trend forms: study_day=linear, daily_time_h=poly3 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - rural_natural_proportion (sound_category_proportion): Kraus knot = median 0.08833, slope per 1 SD = 0.09747; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly4 | HF_nu trend forms: study_day=linear, daily_time_h=poly3 | LF_HF trend forms: study_day=linear, daily_time_h=poly4
  - vehicle_proportion (sound_category_proportion): Kraus knot = median 0.1033, slope per 1 SD = 0.101; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=poly4, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly3 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - urban_manmade_neutral_proportion (sound_category_proportion): Kraus knot = median 0.02833, slope per 1 SD = 0.09285; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=poly3, daily_time_h=poly3 | HF_nu trend forms: study_day=poly3, daily_time_h=linear | LF_HF trend forms: study_day=poly3, daily_time_h=poly3
  - urban_manmade_positive_proportion (sound_category_proportion): Kraus knot = median 0.5617, slope per 1 SD = 0.2642; AIC: HR trend forms: study_day=linear, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=linear | LF_HF trend forms: study_day=linear, daily_time_h=linear
  - urban_manmade_negative_proportion (sound_category_proportion): Kraus knot = median 0.07833, slope per 1 SD = 0.09628; AIC: HR trend forms: study_day=poly3, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly2 | LF_HF trend forms: study_day=linear, daily_time_h=poly4
  - mechanisms_proportion (sound_category_proportion): Kraus knot = median 0.045, slope per 1 SD = 0.04795; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly2 | HF_nu trend forms: study_day=linear, daily_time_h=poly3 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - unidentify_proportion (sound_category_proportion): Kraus knot = median 0.1183, slope per 1 SD = 0.1067; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly3 | LF_HF trend forms: study_day=poly3, daily_time_h=poly4
  - dominant_frequency_Hz (sound_spectral_descriptor): Kraus knot = median 46, slope per 1 SD = 30.16; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=poly2 | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly4 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - spectral_centroid_Hz (sound_spectral_descriptor): Kraus knot = median 220.8, slope per 1 SD = 201.5; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=poly4, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly3 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - spectral_rolloff85_Hz (sound_spectral_descriptor): Kraus knot = median 404.5, slope per 1 SD = 318.4; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly4 | HF_nu trend forms: study_day=linear, daily_time_h=poly2 | LF_HF trend forms: study_day=linear, daily_time_h=poly4
  - freq_proportion_20_to_200Hz (sound_spectral_descriptor): Kraus knot = median 0.8523, slope per 1 SD = 0.1755; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly3 | LF_HF trend forms: study_day=poly4, daily_time_h=poly2
  - freq_proportion_200_to_2000Hz (sound_spectral_descriptor): Kraus knot = median 0.1342, slope per 1 SD = 0.1612; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=poly2, daily_time_h=poly3 | HF_nu trend forms: study_day=poly2, daily_time_h=poly4 | LF_HF trend forms: study_day=poly2, daily_time_h=poly2
  - freq_proportion_2000_to_20000Hz (sound_spectral_descriptor): Kraus knot = median 0.02363, slope per 1 SD = 0.02126; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly4 | HF_nu trend forms: study_day=linear, daily_time_h=poly4 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - octave_proportion_31_5_Hz (sound_spectral_descriptor): Kraus knot = median 0.2056, slope per 1 SD = 0.1135; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly3 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - octave_proportion_63_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.3117, slope per 1 SD = 0.08428; AIC: HR trend forms: study_day=linear, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=poly2, daily_time_h=poly2 | HF_nu trend forms: study_day=poly2, daily_time_h=poly4 | LF_HF trend forms: study_day=poly2, daily_time_h=poly3
  - octave_proportion_125_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.1628, slope per 1 SD = 0.06644; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=poly3, daily_time_h=poly3 | HF_nu trend forms: study_day=pspline, daily_time_h=poly3 | LF_HF trend forms: study_day=linear, daily_time_h=poly2
  - octave_proportion_250_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.06422, slope per 1 SD = 0.02895; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=poly4, daily_time_h=poly2 | LF_HF trend forms: study_day=linear, daily_time_h=poly4
  - octave_proportion_500_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.04849, slope per 1 SD = 0.08092; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly2 | HF_nu trend forms: study_day=linear, daily_time_h=linear | LF_HF trend forms: study_day=linear, daily_time_h=poly2
  - octave_proportion_1000_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.03404, slope per 1 SD = 0.05864; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly4 | LF_HF trend forms: study_day=linear, daily_time_h=poly4
  - octave_proportion_2000_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.02324, slope per 1 SD = 0.01688; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly4 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - octave_proportion_4000_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.004751, slope per 1 SD = 0.007346; AIC: HR trend forms: study_day=poly2, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=linear, daily_time_h=poly4 | LF_HF trend forms: study_day=linear, daily_time_h=poly3
  - octave_proportion_8000_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.001591, slope per 1 SD = 0.006018; AIC: HR trend forms: study_day=linear, daily_time_h=linear | SDNN trend forms: study_day=linear, daily_time_h=linear | LF_nu trend forms: study_day=linear, daily_time_h=poly3 | HF_nu trend forms: study_day=poly4, daily_time_h=poly3 | LF_HF trend forms: study_day=poly3, daily_time_h=poly2

## Not estimable (removed from the results CSV; no p value, so no q value)
- 75 planned tests returned no p value:
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term | LF_HF_ratio | n=158 | not estimable
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | thermal_comfort | n=11 | not estimable
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | acoustic_comfort | n=11 | not estimable
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | visual_comfort | n=11 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [wind_proportion] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [wind_proportion] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [wind_proportion] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [rural_natural_proportion] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [rural_natural_proportion] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [rural_natural_proportion] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [vehicle_proportion] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [vehicle_proportion] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [vehicle_proportion] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_neutral_proportion] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_neutral_proportion] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_neutral_proportion] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_positive_proportion] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_positive_proportion] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_positive_proportion] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_negative_proportion] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_negative_proportion] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [urban_manmade_negative_proportion] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [mechanisms_proportion] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [mechanisms_proportion] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [mechanisms_proportion] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [unidentify_proportion] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [unidentify_proportion] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [unidentify_proportion] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [dominant_frequency_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [dominant_frequency_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [dominant_frequency_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [spectral_centroid_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [spectral_centroid_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [spectral_centroid_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [spectral_rolloff85_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [spectral_rolloff85_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [spectral_rolloff85_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_20_to_200Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_20_to_200Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_20_to_200Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_200_to_2000Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_200_to_2000Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_200_to_2000Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_2000_to_20000Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_2000_to_20000Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [freq_proportion_2000_to_20000Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_31_5_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_31_5_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_31_5_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_63_0_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_63_0_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_63_0_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_125_0_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_125_0_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_125_0_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_250_0_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_250_0_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_250_0_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_500_0_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_500_0_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_500_0_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_1000_0_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_1000_0_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_1000_0_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_2000_0_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_2000_0_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_2000_0_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_4000_0_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_4000_0_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_4000_0_Hz] | LF_HF_ratio | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_8000_0_Hz] | LF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_8000_0_Hz] | HF_power | n=158 | not estimable
  - Biel 2020 | repeated 2-min window LMM with AR(1) (per IQR), air temperature term [octave_proportion_8000_0_Hz] | LF_HF_ratio | n=158 | not estimable

Input MD5: A3C4F9388B61DEF82E5B97B4232315BE
H4 helper MD5: F2FF5BC523A2B9ECC6DB3AC76D7DF996
Additional-method helper MD5: C0A0BF4ED972A3E6EC2A579028C54E62

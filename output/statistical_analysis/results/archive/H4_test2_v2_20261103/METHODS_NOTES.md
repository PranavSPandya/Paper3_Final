# H4 sound literature tests - exact-method rewrite (2026-11-03)
Each block fits the source paper's own model. Where the 8-min / 11-participant data cannot support a step, the closest literal step is used and the limitation is listed here. q_BH (Benjamini-Hochberg within paper x test) is an extra column; each paper's own decision rule is reported separately (inference_note).

## Moshammer et al. 2019 (random-effects GLS, Stata xtreg re)
- Implemented: outcome in a sub-period ~ noise Leq (energy mean) of the PRECEDING sub-period per 1 dB(A) (Table A2, unadjusted) and + mean air temperature of the outcome sub-period (Methods: temperature as confounder); Stata default Swamy-Arora variance components, GLS transform, conventional VCE, z tests. Raw outcomes, no activity term, no centring.
- Window mapping: the paper's consecutive 15-min periods are scaled to consecutive 2-min sub-periods (12 rows of 10 s; 4 per 8-min phase). Sub-periods 2-4 are outcomes with sub-periods 1-3 as the preceding noise period (up to 132 observations). A sub-period value needs >= 2/3 valid 10-s rows. Fitted on all four phases (walk and bike) and, separately, on walking phases only (the paper's setting).
- The paper models no autocorrelation beyond the participant random effect; none is added here. Sub-periods within a phase are serially correlated, and the HRV values are means of 5-min-window estimates (the dataset's rolling windows), so consecutive 2-min sub-periods share data; standard errors are therefore optimistic.
- Dust: personal PM2.5 exists (Atmotube), but Table A2 reports single-exposure models, so PM is not added to the noise model.
- Temperature: the paper used a stationary meteorological station; here the mobile air temperature (ucm_AIR_temp).
- Outcomes: RR distance (derived row-wise as 60000 / empatica_heart_rate), SDNN, RMSSD, VLF, LF and HF power. TINN and blood pressure are not in the dataset.

## Jin, Jin & Kang 2020 (two-way ANOVA)
- Implemented: two-way ANOVA LAeq level x UTCI category with interaction, no participant block. The paper does not state its SS type; because several LAeq x UTCI cells are empty, Type III marginal hypotheses are not uniquely defined, so main effects are Type II (each adjusted for the other main effect) and the interaction is tested against the additive model (the same F under Type II and Type III).
- Levels exactly as the paper: LAeq 55-60, 60-65, 65-70, 70-75 dB(A); UTCI summer stress categories 9-26, 26-32, 32-38, 38-46 C (single season: all sessions in August 2025, analysed as the paper's summer).
- 5 of 44 phase cells fall outside the paper's LAeq (55-75 dB(A)) or UTCI (9-46 C) ranges and are excluded, not reassigned.
- Outcomes: TCV analogue = questionnaire_thermal_comfort_1_5 (5-point; paper 7-point); OCV analogue = questionnaire_current_comfort_1_7 (General Comfort, 7-point). TSV, subjective loudness and acoustic comfort were not collected. Paper unit = independent respondents; here 44 phase cells from 11 participants (repeated measures, not modelled, as instructed: no block).
- Cell counts (phase cells with phase LAeq and UTCI inside the ranges):
  - 55-60 dB(A) | No thermal stress (9-26 C): n = 3
  - 60-65 dB(A) | No thermal stress (9-26 C): n = 5
  - 65-70 dB(A) | No thermal stress (9-26 C): n = 7
  - 70-75 dB(A) | No thermal stress (9-26 C): n = 2
  - 55-60 dB(A) | Moderate heat stress (26-32 C): n = 0
  - 60-65 dB(A) | Moderate heat stress (26-32 C): n = 3
  - 65-70 dB(A) | Moderate heat stress (26-32 C): n = 9
  - 70-75 dB(A) | Moderate heat stress (26-32 C): n = 4
  - 55-60 dB(A) | Strong heat stress (32-38 C): n = 0
  - 60-65 dB(A) | Strong heat stress (32-38 C): n = 0
  - 65-70 dB(A) | Strong heat stress (32-38 C): n = 4
  - 70-75 dB(A) | Strong heat stress (32-38 C): n = 2
  - 55-60 dB(A) | Very strong heat stress (38-46 C): n = 0
  - 60-65 dB(A) | Very strong heat stress (38-46 C): n = 0
  - 65-70 dB(A) | Very strong heat stress (38-46 C): n = 0
  - 70-75 dB(A) | Very strong heat stress (38-46 C): n = 0
- Empty or small cells are reported as they are; levels are not collapsed.

## Song et al. 2013 (winter) / 2014 (spring) (one-sided paired t-test)
- Source: J Physiol Anthropol 32:18 and 33:8 (open access; PDFs saved in Experiment papers/H4 Sound literature test/).
- Implemented: heart rate, ln(HF), ln(LF/HF); 1-min values averaged over the walk; one-sided paired t-test park (WalkG) vs city (WalkU), P < 0.05 one-sided. Direction as in the papers: HR lower, ln(HF) higher, ln(LF/HF) lower in the park.
- Limitations: walks are 8 min, not 15 min; 1-min HRV values are means of the dataset's 10-s rows of 5-min-window estimates (MemCalc beat-to-beat analysis not available); Song is a park-vs-city setting contrast, not a sound-level test.

## Rodrigues et al. 2026 (7.Model_H2.py)
- Implemented: Noise block [NOISE_max, NOISE_std] and Temperature block [Temp_max, Temp_mean], each in its own model; predictors fillna(0) then StandardScaler (population SD); REML mixed model with participant intercept; Wald z p; retention rule round(p,4) < 0.05 and |round(beta,4)| > 0.1.
- Outcomes (their code order): STD/MAX/MEAN/MIN of bpm, LF_HF_ratio, RMSSD and STD/MAX/MIN of skin temperature, raw (no transformation), over walking trips (WalkG, WalkU; 22 trips).
- Not available: EDA SCR amplitude and rise-time features (9 variables) and pNN50 (STD/MAX/MEAN/MIN): not in the merged dataset ; blocks Infrastructure, Functional POIs and Mapillary Visuals (Mapillary/OSM features not in the dataset).
- Exposure source differs: their NOISE from the Lisbon Lden map along the route and Temp from the IPMA daily station; here personal dBA and mobile air temperature per trip.

## Kraus et al. 2013 (additive mixed models)
- Implemented: outcomes HR, SDNN, LF (normalized units), HF (normalized units) and LF:HF; log except HR; lagged outcome (previous interval); piecewise Leq at 65 dB(A) per 5 dB; categorical physical activity (walk = 3 very light to light exertion, bike = 4 moderate exertion); HR adjustment for HRV models; long-term and daily time trends forced in, each linear, polynomial 2-4 or penalized spline by AIC; weekday tested by AIC; random participant intercept plus compound symmetry (nlme corCompSymm).
- Window mapping: the paper's 5-min intervals are scaled to consecutive 1-min intervals (6 rows of 10 s; 8 per phase, all 44 phases). Leq lags of 0, 1, 2 and 3 min are the analogues of the paper's 0-5, 5-10 and 10-15 min lags; each lag is a separate model. Intervals 4-8 of each phase are used so that all lag models share the same rows. Validity: >= 2/3 valid 10-s rows per interval (the paper's Leq rule; the 200/300-beat rule cannot be applied to 1-min means).
- Autocorrelation: as in the paper, handled by the lagged outcome plus participant random effect and compound symmetry. HRV values per minute are means of the dataset's 5-min rolling-window estimates, so they overlap adjacent minutes; a 1-min lag is partly contemporaneous for HRV.
- Trend forms and weekday are selected by AIC (ML) on the lag-0 model and reused for each lag. AIC for spline candidates comes from the mgcv::gamm mixed-model representation (lme object, ML).
- Season is constant (August 2025); weekday is constant within each participant (one session each).
- Effect scale as the paper: percent change in the outcome mean per 5 dB(A) (HR: 100*beta/mean HR).
- AIC selection per outcome:
  - HR: trend forms: study_day=linear, daily_time_h=linear; AIC(ML) base=1458.725, +weekday=1459.046 -> weekday not kept; season: single season (August), not evaluable; n=220 1-min intervals
  - SDNN: trend forms: study_day=poly3, daily_time_h=linear; AIC(ML) base=-440.585, +weekday=-636.011 -> weekday kept; season: single season (August), not evaluable; n=214 1-min intervals
  - LF_nu: trend forms: study_day=linear, daily_time_h=linear; AIC(ML) base=-260.721, +weekday=not estimable (weekday aliased with participant/day trend) -> weekday not kept; season: single season (August), not evaluable; n=164 1-min intervals
  - HF_nu: trend forms: study_day=linear, daily_time_h=linear; AIC(ML) base=-246.548, +weekday=-390.946 -> weekday kept; season: single season (August), not evaluable; n=164 1-min intervals
  - LF_HF: trend forms: study_day=linear, daily_time_h=linear; AIC(ML) base=-24.112, +weekday=not estimable (weekday aliased with participant/day trend) -> weekday not kept; season: single season (August), not evaluable; n=164 1-min intervals
- Kraus 1-min intervals built: 220 (intervals 4-8 of 44 phases).

## Data source
- All blocks use the 10-s time-series rows of output/merged_all_11participants_8min.csv (the same input as Analysis_combined_timeseries.R). Song 1-min means and Rodrigues trip MEAN/STD/MAX/MIN are computed from those 10-s rows; Jin uses all 44 phases.

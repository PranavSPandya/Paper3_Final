# H4 sound literature tests - exact-method rewrite (2026-11-03)
Each block fits the source paper's own model. Where the 8-min / 11-participant data cannot support a step, the closest literal step is used and the limitation is listed here. q_BH (Benjamini-Hochberg within paper x test) is an extra column; each paper's own decision rule is reported separately (inference_note).

## Moshammer et al. 2019 (random-effects GLS, Stata xtreg re)
- Implemented: outcome ~ noise Leq per 1 dB(A) (Table A2, unadjusted) and outcome ~ noise + air temperature (Methods: temperature as confounder); Stata default Swamy-Arora variance components, GLS transform, conventional VCE, z tests. Raw outcomes, no activity term, no centring.
- Walking bouts only (WalkG, WalkU; 22 periods, 11 participants), because all source exposures were walks.
- "Preceding 15 min": the paper averages noise over each 15-min period and reads ECG over that same period (Figure 3 caption). Here one period = one 8-min walking bout (noise Leq and HRV over the same bout). Periods are not 15 min, and only one period per bout exists, so the paper's separate after-15/30/45/60-min models reduce to one model.
- Dust: personal PM2.5 exists (Atmotube), but Table A2 reports single-exposure models ("Unadjusted effect estimates"), so PM is not added to the noise model. PM-only models are air-pollution tests and are out of the H4 sound scope.
- Temperature: the paper used a stationary meteorological station; here the mobile air temperature (ucm_AIR_temp) bout mean.
- Outcomes available: RR distance (derived row-wise as 60000 / empatica_heart_rate, then bout mean), SDNN, RMSSD, VLF, LF and HF power. TINN and blood pressure are not in the dataset. HRV values are bout means of the dataset's 5-min-window estimates (frequency-domain values masked where the 5-min window is unavailable), not Kubios over the full period.

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
- Implemented: outcomes HR, SDNN, LF (normalized units), HF (normalized units) and LF:HF; log except HR; piecewise Leq at 65 dB(A) per 5 dB; categorical physical activity (walk = 3 very light to light exertion, bike = 4 moderate exertion, the paper's own category examples); HR adjustment for HRV models; long-term and daily time trends forced in, each modelled as linear, polynomial 2-4 or penalized spline chosen by AIC; weekday tested by AIC; random participant intercept plus compound-symmetry correlation (nlme corCompSymm).
- One 5-min interval per bout: the last dataset 5-min HRV window lying fully inside the bout; HR and SDNN averaged over that window (>= 200 beats), frequency-domain values from that window (>= 300 beats), Leq from >= 2/3 valid 10-s values.
- Not supportable: lagged outcome and Leq lags 0-5, 5-10 and 10-15 min. An 8-min bout holds one complete 5-min interval; the preceding 3 min fall below the paper's 2/3 availability rule; adjacent bouts are 12-40 min apart and in another mode. Season is constant (August 2025). Weekday is constant within each participant (one session each).
- With one session per participant, compound symmetry within participant duplicates the random intercept (rho near 0); it is kept because the paper specifies both.
- AIC for penalized-spline candidates is taken from the mixed-model representation fitted by mgcv::gamm (its lme object, ML); polynomial and linear candidates from nlme::lme (ML).
- Effect scale as the paper: percent change in the outcome mean per 5 dB(A) (HR: 100*beta/mean HR).
- AIC selection per outcome:
  - HR: trend forms: study_day=poly2, daily_time_h=linear; AIC(ML) base=305.337, +weekday=not estimable (weekday aliased with participant/day trend) -> weekday not kept; season: single season (August), not evaluable
  - SDNN: trend forms: study_day=poly3, daily_time_h=poly2; AIC(ML) base=-92.481, +weekday=not estimable (weekday aliased with participant/day trend) -> weekday not kept; season: single season (August), not evaluable
  - LF_nu: trend forms: study_day=linear, daily_time_h=linear; AIC(ML) base=-21.243, +weekday=not estimable (weekday aliased with participant/day trend) -> weekday not kept; season: single season (August), not evaluable
  - HF_nu: trend forms: study_day=pspline, daily_time_h=linear; AIC(ML) base=-53.779, +weekday=-64.213 -> weekday kept; season: single season (August), not evaluable
  - LF_HF: trend forms: study_day=poly3, daily_time_h=linear; AIC(ML) base=-18.126, +weekday=not estimable (weekday aliased with participant/day trend) -> weekday not kept; season: single season (August), not evaluable
- Kraus intervals with a complete 5-min window: 44 of 44 bouts.

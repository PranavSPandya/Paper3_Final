# H4 results report

## Physiological sensor models (10-second time series)
Outcomes: 26 empatica + eyetracker columns (see H4_SPEC$outcomes$physiological). Nested (1 | ParticipantID / PhaseID) with AR(1) within bout.
Sample sizes (Eq 1): see H4_hypothesis_readme.txt and 1363-2101 rows per outcome.

## Files
- H4_Heat_Noise_Exposures.csv / H4_Covariates_and_Phases.csv: H4.1 only
- H4_Variable_Selection.csv, H4_Selection_Flow.pdf; working fits under H4_results/timeseries/

H4.1 Physiological Sensor Time-Series Models
Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md
Equations (catalog ids): 1, 2, 3, 4, 5, 6, 7 — primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.
Sample: 10 s windows; 1328-2101 rows per outcome-equation (median 1807); 26 outcomes; participants 10-11 per model.
Design VIF (threshold 5): max grouped VIF-equiv = 2.96; 0 design(s) >= 5. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.
Fits: 182/182 successful outcome-equation models. All non-intercept coefficients have BH q across planned outcomes per term/equation, plus q_equation across all non-intercept terms/outcomes within equation. Intercepts and invalid inference have explicit status text. Equations are not pooled into one correction family.
SVF endpoint carry-forward rows: 44.
Covariates retained after Step 4: SVF, atmo_pm10_avg, atmo_pm1_avg, atmo_pm2.5_avg, gvi_50m, lys_kelvin_avg, lys_lux_avg, ucm_MRT, ucm_SND_dBA, ucm_SUN_Gh.
Thermal q<0.05: 6 thermal q<0.05 row(s); see H4_coefficients.csv. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).
All non-intercept coefficients: 145 per-term q<0.05 and 93 equation-wide q<0.05. These include exploratory adjustment/phase effects and repeated sensitivity specifications, not independent H4 discoveries.
Sound main effects: 0 per-term q<0.05. Sound interactions: 0. Phase contrasts and other adjustments are fully reported in the coefficient tables.
Generated: 2026-10-19 23:41:47 UTC | code_md5 00f996bc87595f52a02d6d71dffb818c | input_md5 1b661e6201d4317a21389ca8a3580e23 | audit_md5 1e8ef55e91de7a5de6ddcec29b0c6917 | spec_md5 dcb08a6c8a7ef09fba042a841088f599

# H4 design-only GVIF / VIF diagnostic

Reference complete-case outcome: **empatica_heart_rate** (n = 2101). Other outcomes use different row sets; see `H4_design_redundancy_by_outcome.csv`.

## PhaseID vs single continuous predictors

PhaseID enters as **three** sum-to-zero contrasts (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit).
In `car::vif`, that span is one **Df = 3** term with a generalized VIF (GVIF).
- **GVIF^(1/(2*Df))** is what `car::vif` prints for multi-df terms (Fox & Monette 1992; [car::vif](https://rdrr.io/cran/car/man/vif.html)).
- **VIF_equivalent = GVIF^(1/Df)** is the square of that root; we compare **VIF_equivalent** to 
5
 for the PhaseID block.
- Continuous **Df = 1** columns use ordinary VIF (= VIF_equivalent). Values above the threshold are **flagged only**; no predictor is dropped.

## Equation summaries (heart rate complete cases)

| Eq | Heat form | Block | n | Max VIF-equiv | Worst term | Phase GVIF | Phase VIF-equiv |
|----|-----------|-------|---|---------------|------------|------------|-----------------|
| 1 | UTCI / atmo_pm2.5_avg | heat_x_sound | 2101 | 2.563 | ucm_SUN_Gh | 1.006 | 1.002 |
| 2 | UTCI / atmo_pm2.5_avg (sound sensitivity) | heat_x_sound | 2056 | 2.573 | ucm_SUN_Gh | 1.007 | 1.002 |
| 3 | AIR_T_mid + AIR_RH + WIND_AWS / atmo_pm2.5_avg | heat_x_sound | 2101 | 2.889 | ucm_MRT | 1.188 | 1.059 |
| 4 | HUMIDEX / atmo_pm2.5_avg | heat_x_sound | 2101 | 1.386 | SVF | 1.035 | 1.012 |
| 5 | PET / atmo_pm2.5_avg | heat_x_sound | 2101 | 2.372 | ucm_SUN_Gh | 1.009 | 1.003 |
| 6 | UTCI / atmo_pm1_avg | heat_x_sound | 2101 | 2.566 | ucm_SUN_Gh | 1.006 | 1.002 |
| 7 | UTCI / atmo_pm10_avg | heat_x_sound | 2101 | 2.567 | ucm_SUN_Gh | 1.006 | 1.002 |

Generated UTC: 2026-10-19 22:56:53

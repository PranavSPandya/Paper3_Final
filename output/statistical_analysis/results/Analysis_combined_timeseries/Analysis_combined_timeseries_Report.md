# H4 results report

## Physiological sensor models (10-second time series)
Outcomes: 26 empatica + eyetracker columns (see h4_study_spec$physiological_outcome_names). Nested (1 | ParticipantID / PhaseID) with AR(1) within bout.
Sample sizes (Eq 1): see the readme section below and 1330-2060 rows per outcome.

## Files
- Saved in results/Analysis_combined_timeseries/: Analysis_combined_timeseries_hypothesis.csv (heat and sound exposure terms, H4.1); Analysis_combined_timeseries_fit_status.csv (fit status per outcome x equation); Analysis_combined_timeseries_run_complete.csv (file MD5 manifest); Analysis_combined_timeseries_Multivariate_Filtration_Results.csv (Steps 1-4 variable audit, input to the phase-average run); Analysis_combined_timeseries_fit_records.rds (Step 5 resume checkpoint); this report.
- Not saved by default (rerun with PAPER3_WRITE_DETAILS=1 to write them): coefficients, Heat_Noise_Exposures, Covariates_and_Phases, Variable_Selection, phase_contrasts, covariance and lag-60 sensitivity, GVIF and design-redundancy diagnostics, audit step tables, Selection_Flow.pdf, hypothesis_readme, session_info. Detail file names mentioned below refer to that mode.

H4.1 Physiological Sensor Time-Series Models
Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md
Equations (catalog ids): 1, 2, 3, 4, 5, 6 â€” primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.
Sample: 10 s windows; 1330-2060 rows per outcome-equation (median 1774); 26 outcomes; participants 10-11 per model.
Design VIF (threshold 5): max grouped VIF-equiv = 2.88; 0 design(s) >= 5. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.
Fits: 156/156 successful outcome-equation models. All non-intercept coefficients have BH q across planned outcomes per term/equation, plus q_equation across all non-intercept terms/outcomes within equation. Intercepts and invalid inference have explicit status text. Equations are not pooled into one correction family.
SVF endpoint carry-forward rows: 0.
Covariates retained after Step 4: atmo_pm1_avg, atmo_pm10_avg, atmo_pm2.5_avg, gvi_50m, lys_kelvin_avg, lys_lux_avg, SVF, ucm_MRT, ucm_SND_dBA, ucm_SUN_Gh.
Thermal q<0.05: 3 thermal q<0.05 row(s); see H4_coefficients.csv. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).
All non-intercept coefficients: 131 per-term q<0.05 and 109 equation-wide q<0.05. These include exploratory adjustment/phase effects and repeated sensitivity specifications, not independent H4 discoveries.
Sound main effects: 0 per-term q<0.05. Sound interactions: 0. Phase contrasts and other adjustments are fully reported in the coefficient tables.
Generated: 2026-11-01 15:21:52 UTC | code_md5 77e9cf05420fa3fcb55e2ee15be71883 | input_md5 d1566f55ce744035511d5bf17c7d8114 | audit_md5 f1e031222fcdd84de813c942677593a1 | spec_md5 45c279c02a92a5c2abbd84b718ad27d4

# H4 design-only GVIF / VIF diagnostic

Reference complete-case outcome: **empatica_heart_rate** (n = 2060). Other outcomes use different row sets; see `Analysis_combined_timeseries_design_redundancy_by_outcome.csv`.

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
| 1 | Eq1: heat = UTCI, PM = PM2.5 | heat_x_sound | 2060 | 2.521 | ucm_SUN_Gh | 1.003 | 1.001 |
| 2 | Eq2: heat = AIR_T_mid + AIR_RH + WIND_AWS, PM = PM2.5 | heat_x_sound | 2060 | 2.833 | ucm_MRT | 1.004 | 1.001 |
| 3 | Eq3: heat = HUMIDEX, PM = PM2.5 | heat_x_sound | 2060 | 1.407 | SVF | 1.003 | 1.001 |
| 4 | Eq4: heat = PET, PM = PM2.5 | heat_x_sound | 2060 | 2.356 | ucm_SUN_Gh | 1.003 | 1.001 |
| 5 | Eq5: heat = UTCI, PM = PM1 | heat_x_sound | 2060 | 2.522 | ucm_SUN_Gh | 1.003 | 1.001 |
| 6 | Eq6: heat = UTCI, PM = PM10 | heat_x_sound | 2060 | 2.524 | ucm_SUN_Gh | 1.003 | 1.001 |

Generated UTC: 2026-11-01 15:08:47

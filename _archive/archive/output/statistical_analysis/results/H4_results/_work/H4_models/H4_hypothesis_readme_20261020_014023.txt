H4.1 Physiological Sensor Time-Series Models
Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md
<<<<<<<< HEAD:_archive/archive/output/statistical_analysis/results/H4_results/_work/H4_models/H4_hypothesis_readme_20261020_014023.txt
Equations (catalog ids): 1, 2, 3, 4, 5, 6, 7 — primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.
Sample: 10 s windows; 1328-2101 rows per outcome-equation (median 1807); 26 outcomes; participants 10-11 per model.
Design VIF (threshold 5): max grouped VIF-equiv = 2.96; 0 design(s) >= 5. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.
Fits: 182/182 successful outcome-equation models. FDR: BH per term within equation across outcomes (thermal + thermal x sound).
SVF endpoint carry-forward rows: 44.
Covariates retained after Step 4: SVF, atmo_pm10_avg, atmo_pm1_avg, atmo_pm2.5_avg, gvi_50m, lys_kelvin_avg, lys_lux_avg, ucm_MRT, ucm_SND_dBA, ucm_SUN_Gh.
Thermal q<0.05: 6 thermal q<0.05 row(s); see H4_coefficients.csv. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).
Generated: 2026-10-19 23:07:03 UTC | code_md5 00f996bc87595f52a02d6d71dffb818c | input_md5 1b661e6201d4317a21389ca8a3580e23 | audit_md5 1e8ef55e91de7a5de6ddcec29b0c6917 | spec_md5 dcb08a6c8a7ef09fba042a841088f599
========
Equations (catalog ids): 1, 2, 3, 4, 5, 6, 7 â€” primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.
Sample: 10 s windows; 1330-2060 rows per outcome-equation (median 1774); 26 outcomes; participants 10-11 per model.
Design VIF (threshold 5): max grouped VIF-equiv = 2.91; 0 design(s) >= 5. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.
Fits: 182/182 successful outcome-equation models. All non-intercept coefficients have BH q across planned outcomes per term/equation, plus q_equation across all non-intercept terms/outcomes within equation. Intercepts and invalid inference have explicit status text. Equations are not pooled into one correction family.
SVF endpoint carry-forward rows: 0.
Covariates retained after Step 4: SVF, atmo_pm10_avg, atmo_pm1_avg, atmo_pm2.5_avg, gvi_50m, lys_kelvin_avg, lys_lux_avg, ucm_MRT, ucm_SND_dBA, ucm_SUN_Gh.
Thermal q<0.05: 3 thermal q<0.05 row(s); see H4_coefficients.csv. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).
All non-intercept coefficients: 155 per-term q<0.05 and 107 equation-wide q<0.05. These include exploratory adjustment/phase effects and repeated sensitivity specifications, not independent H4 discoveries.
Sound main effects: 0 per-term q<0.05. Sound interactions: 0. Phase contrasts and other adjustments are fully reported in the coefficient tables.
Generated: 2026-10-27 00:40:07 UTC | code_md5 086f5f05b90de6414d498a6340f0b677 | input_md5 b9425c325974bcc05627383a97a6a066 | audit_md5 4da819b52a7c77db936b339119e300f1 | spec_md5 a49b25997102f96e72f0f8abc4e38ae1
>>>>>>>> 935dd64e099e80dbb9d1f58a4c53b5d2b3adfc96:output/statistical_analysis/results/H4_timeseries/H4_timeseries_hypothesis_readme.txt

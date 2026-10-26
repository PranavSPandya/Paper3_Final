H4.1 Physiological Sensor Time-Series Models
Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md
Equations (catalog ids): 1, 2, 3, 4, 5, 6, 7 — primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.
Sample: 10 s windows; 1328-2101 rows per outcome-equation (median 1807); 26 outcomes; participants 10-11 per model.
Design VIF (threshold 5): max grouped VIF-equiv = 3.07; 0 design(s) >= 5. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.
Fits: 182/182 successful outcome-equation models. FDR: BH per term within equation across outcomes (thermal + thermal x sound).
SVF endpoint carry-forward rows: 44.
Covariates retained after Step 4: SVF, atmo_pm10_avg, atmo_pm1_avg, atmo_pm2.5_avg, gvi_50m, lys_kelvin_avg, lys_lux_avg, ucm_MRT, ucm_SND_dBA, ucm_SUN_Gh.
Thermal q<0.05: 1 thermal q<0.05 row(s); see H4_coefficients.csv. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).
Generated: 2026-10-19 21:43:27 UTC | code_md5 5fa4911b4933649be224243b6771a834 | input_md5 1b661e6201d4317a21389ca8a3580e23 | audit_md5 9b8cfed4ea7fb6a8567af4459bb3ec39 | spec_md5 dcb08a6c8a7ef09fba042a841088f599

H4.1 Physiological Sensor Time-Series Models
Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md
Equations (catalog ids): 1, 2, 3, 4, 5, 6 â€” primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.
Sample: 10 s windows; 1330-2060 rows per outcome-equation (median 1774); 26 outcomes; participants 10-11 per model.
Design VIF (threshold 5): max grouped VIF-equiv = 2.91; 0 design(s) >= 5. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.
Fits: 156/156 successful outcome-equation models. All non-intercept coefficients have BH q across planned outcomes per term/equation, plus q_equation across all non-intercept terms/outcomes within equation. Intercepts and invalid inference have explicit status text. Equations are not pooled into one correction family.
SVF endpoint carry-forward rows: 0.
Covariates retained after Step 4: atmo_pm1_avg, atmo_pm10_avg, atmo_pm2.5_avg, gvi_50m, lys_kelvin_avg, lys_lux_avg, SVF, ucm_MRT, ucm_SND_dBA, ucm_SUN_Gh.
Thermal q<0.05: 3 thermal q<0.05 row(s); see H4_coefficients.csv. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).
All non-intercept coefficients: 135 per-term q<0.05 and 100 equation-wide q<0.05. These include exploratory adjustment/phase effects and repeated sensitivity specifications, not independent H4 discoveries.
Sound main effects: 0 per-term q<0.05. Sound interactions: 0. Phase contrasts and other adjustments are fully reported in the coefficient tables.
Generated: 2026-10-31 16:03:21 UTC | code_md5 f1ed5073f8ae09e8149c1aa1e280a045 | input_md5 d1566f55ce744035511d5bf17c7d8114 | audit_md5 f1e031222fcdd84de813c942677593a1 | spec_md5 45c279c02a92a5c2abbd84b718ad27d4

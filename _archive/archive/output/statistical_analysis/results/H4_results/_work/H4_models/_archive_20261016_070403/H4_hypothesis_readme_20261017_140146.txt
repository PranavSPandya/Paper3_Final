H4.1 Physiological Sensor Time-Series Models
Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md
Equations (catalog ids): 1, 2, 3, 4, 5, 6, 7 — primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.
Sample: 10 s windows; 1328-2056 rows per outcome-equation (median 1770); 26 outcomes; participants 10-11 per model.
Design VIF (threshold 5): max grouped VIF-equiv = 3.04; 0 design(s) >= 5. See H4_gvif_diagnostic.csv, H4_design_redundancy_by_outcome.csv.
Fits: 156/156 successful outcome-equation models. FDR: BH per term within equation across outcomes (thermal + thermal x sound).
SVF endpoint carry-forward rows: 44.
Covariates retained after Step 4: atmo_pm1_avg, atmo_pm10_avg, atmo_pm2.5_avg, gvi_50m, lys_kelvin_avg, lys_lux_avg, SVF_Holmer, ucm_MRT, ucm_SND_dBA, ucm_SUN_Gh.
Thermal q<0.05: 1 thermal q<0.05 row(s); see H4_coefficients.csv. Lag-60 s: H4_lag60_sensitivity.csv (separate BH family).
Generated: 2026-10-16 04:31:13 UTC | code_md5 8864624405a843b462d98105c810faa9 | input_md5 76288a0718fd8d709eee47cc4276afda | audit_md5 8210d96880128dccac36a5d74212853c | spec_md5 bb0489542ad3740bc24f03e026039b40

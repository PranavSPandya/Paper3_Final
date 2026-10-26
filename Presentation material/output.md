<!-- Consolidated 2026-10-27 from Presentation material sources -->

---
## Source: H4_Report.md
---

# H4 results report

## Physiological sensor models (10-second time series)
Outcomes: 26 empatica + eyetracker columns (see H4_SPEC$outcomes$physiological). Nested (1 | ParticipantID / PhaseID) with AR(1) within bout.
Sample sizes (Eq 1): see H4_time_series_hypothesis_readme.txt and 1363-2101 rows per outcome.

## Files
- H4_time_series_Heat_Noise_Exposures.csv / H4_time_series_Covariates_and_Phases.csv: H4.1 only
- H4_time_series_Variable_Selection.csv, H4_time_series_Selection_Flow.pdf; working fits in results/H4_time_series/ (phase-average variant: results/H4_phase_average/, files prefixed H4_phase_average_)

H4.1 Physiological Sensor Time-Series Models
Full methods: scripts/Paper3_Code_Design_Methodology_Map.md and scripts/Paper3_Methods_Plain.md
Equations (catalog ids): 1, 2, 3, 4, 5, 6, 7 — primary UTCI+PM2.5; heat-form sensitivities on PM2.5; PM1/PM10 with UTCI only.
Sample: 10 s windows; 1328-2101 rows per outcome-equation (median 1807); 26 outcomes; participants 10-11 per model.
Design VIF (threshold 5): max grouped VIF-equiv = 2.96; 0 design(s) >= 5. See H4_time_series_gvif_diagnostic.csv, H4_time_series_design_redundancy_by_outcome.csv.
Fits: 182/182 successful outcome-equation models. All non-intercept coefficients have BH q across planned outcomes per term/equation, plus q_equation across all non-intercept terms/outcomes within equation. Intercepts and invalid inference have explicit status text. Equations are not pooled into one correction family.
SVF endpoint carry-forward rows: 44.
Covariates retained after Step 4: SVF, atmo_pm10_avg, atmo_pm1_avg, atmo_pm2.5_avg, gvi_50m, lys_kelvin_avg, lys_lux_avg, ucm_MRT, ucm_SND_dBA, ucm_SUN_Gh.
Thermal q<0.05: 6 thermal q<0.05 row(s); see H4_time_series_coefficients.csv. Lag-60 s: H4_time_series_lag60_sensitivity.csv (separate BH family).
All non-intercept coefficients: 145 per-term q<0.05 and 93 equation-wide q<0.05. These include exploratory adjustment/phase effects and repeated sensitivity specifications, not independent H4 discoveries.
Sound main effects: 0 per-term q<0.05. Sound interactions: 0. Phase contrasts and other adjustments are fully reported in the coefficient tables.
Generated: 2026-10-19 23:41:47 UTC | code_md5 00f996bc87595f52a02d6d71dffb818c | input_md5 1b661e6201d4317a21389ca8a3580e23 | audit_md5 1e8ef55e91de7a5de6ddcec29b0c6917 | spec_md5 dcb08a6c8a7ef09fba042a841088f599

# H4 design-only GVIF / VIF diagnostic

Reference complete-case outcome: **empatica_heart_rate** (n = 2101). Other outcomes use different row sets; see `H4_time_series_design_redundancy_by_outcome.csv`.

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
---
## Source: H4_Transparency_Report.md
---

# H4 measurement audit
Steps 1-2 retain the complete inventory and declared exposure representations. Step 3 groups candidates without outcome-based deletion.
Step 4 retains all 16 eligible candidates, specifies alternative heat/PM equations, and checks full-design VIF/rank; no automatic deletion.
Participant is the independent cluster. Step 4 defines seven equations (primary UTCI + PM2.5; optional Eq 2 sound-structure sensitivity; heat-form sensitivities on PM2.5; PM1/PM10 only with UTCI) including heat x sound and MRT x sound. Step 5 fits six by default (Eq 2 when H4_SPEC$fit_sound_sensitivity is TRUE). Earlier model outputs are historical until a verified rerun succeeds.
## Stage totals
| Stage | Entering | Retained | Not_Advanced |
| --- | --- | --- | --- |
| Step 1 | 230 | 126 | 104 |
| Step 2 | 126 |  16 | 110 |
| Step 3 |  16 |  16 |   0 |
## Measurement definitions and dependencies
| Variable_Name | Measurement_Code | Measurement_Type | Inputs_or_Definition | Evidence |
| --- | --- | --- | --- | --- |
| ucm_AIR_T_mid | M | Instrument | [UCM T_mid] | [CityFeel17] |
| ucm_AIR_RH | M | Instrument | [UCM] | [CityFeel17] |
| ucm_SND_dBA | M | Instrument | [dBA] | [CityFeel17] |
| ucm_SUN_Gh | M | Instrument | [Gh] | [CityFeel17] |
| atmo_pm1_avg | A | Average | [PM1 avg] | [avg_sources] |
| atmo_pm2.5_avg | A | Average | [PM25 avg] | [avg_sources] |
| atmo_pm10_avg | A | Average | [PM10 avg] | [avg_sources] |
| lys_lux_avg | A | Average | [Lux avg] | [avg_sources] |
| lys_medi_avg | D | Derived | [Medi derived] | [MediRGB] |
| lys_kelvin_avg | D | Derived | [Kelvin avg] | [LYS] |
| ucm_MRT | D | Derived | [MRT] | [CityFeel17] |
| ucm_PET | D | Derived | [PET] | [CityFeel17] |
| ucm_UTCI | D | Derived | [UTCI] | [CityFeel17] |
| ucm_HUMIDEX | D | Derived | [HUMIDEX] | [CityFeel17] |
| Clearness_Index | D | Derived | [kt derived] | [ClearCI] |
| Clearness_Index_G0 | D | Derived | [G0 calc] | [ClearCI] |
| gvi_50m | D | Derived | [GVI] | [GVI merge] |
| ucm_WIND_AWS | M | Wind | [AWS] | [AWS] |
| ucm_fp | U | Unverified | [fp unverified] | [fp] |
| SVF | D | SVF | [SVF Holmer] | [SVF Qiu17] |
Step 2 representatives and averages are study choices, not automatic literature rules. LYS1 and LYS2 represent different wearers.
fp remains unverified; true wind speed (TWS) excluded (gaps, undocumented correction); SVF from CamUp merge in merged_all_11participants_8min.csv (Step 2 Retained when coverage passes).
## Within-person design diagnostics
(none)
| Field1 | Field2 | Pearson_r | Spearman_rho | N_phase_cells |
| --- | --- | --- | --- | --- |
| ucm_PET | ucm_UTCI |  0.98786484 |  0.975439586 | 44 |
| ucm_AIR_T_mid | ucm_MRT |  0.95111834 |  0.962367865 | 44 |
| gvi_50m | ucm_MRT | -0.94826080 | -0.902325581 | 44 |
| ucm_MRT | ucm_UTCI |  0.94700053 |  0.850599013 | 44 |
| gvi_50m | ucm_AIR_T_mid | -0.92822765 | -0.886962650 | 44 |
| ucm_MRT | ucm_PET |  0.92763126 |  0.824905741 | 44 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.91076582 |  0.801578633 | 44 |
| ucm_SUN_Gh | ucm_UTCI |  0.90266681 |  0.760394644 | 44 |
| ucm_AIR_T_mid | ucm_UTCI |  0.90041390 |  0.809725159 | 44 |
| gvi_50m | ucm_UTCI | -0.90004304 | -0.776462297 | 44 |
| ucm_MRT | ucm_SUN_Gh |  0.89089165 |  0.755602537 | 44 |
| ucm_AIR_T_mid | ucm_PET |  0.88564469 |  0.796081610 | 44 |
| ucm_PET | ucm_SUN_Gh |  0.88503288 |  0.755488214 | 44 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.88501994 |  0.422551092 | 44 |
| gvi_50m | ucm_PET | -0.88184790 | -0.757320554 | 44 |
| ucm_AIR_T_mid | ucm_HUMIDEX |  0.87273504 |  0.891613813 | 44 |
| gvi_50m | ucm_AIR_RH |  0.84493213 |  0.840169133 | 44 |
| ucm_AIR_RH | ucm_AIR_T_mid | -0.83770155 | -0.842706131 | 44 |
| ucm_HUMIDEX | ucm_MRT |  0.82080114 |  0.864552502 | 44 |
| ucm_AIR_T_mid | ucm_SUN_Gh |  0.79667475 |  0.673431994 | 44 |
| ucm_HUMIDEX | ucm_UTCI |  0.78876478 |  0.764763918 | 44 |
| gvi_50m | ucm_HUMIDEX | -0.78710041 | -0.799013390 | 44 |
| ucm_AIR_RH | ucm_MRT | -0.76581163 | -0.843128964 | 44 |
| gvi_50m | ucm_SUN_Gh | -0.76574916 | -0.625088090 | 44 |
| ucm_AIR_RH | ucm_SND_dBA | -0.76214471 | -0.747665528 | 44 |
| SVF | ucm_AIR_RH | -0.75646391 | -0.742353770 | 44 |
| ucm_HUMIDEX | ucm_PET |  0.74962151 |  0.729624018 | 44 |
| SVF | ucm_AIR_T_mid |  0.73305150 |  0.731360113 | 44 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.73266020 | -0.732064834 | 44 |
| ucm_AIR_RH | ucm_UTCI | -0.73264194 | -0.776180409 | 44 |
| SVF | gvi_50m | -0.72418903 | -0.773502467 | 44 |
| ucm_AIR_RH | ucm_PET | -0.70356267 | -0.768807922 | 44 |
| SVF | ucm_MRT |  0.69279830 |  0.805073996 | 44 |
| atmo_pm10_avg | atmo_pm1_avg |  0.68660155 |  0.172733359 | 44 |
| SVF | ucm_HUMIDEX |  0.65642464 |  0.675405215 | 44 |
| SVF | ucm_UTCI |  0.64959899 |  0.662438337 | 44 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.64713532 |  0.513178295 | 44 |
| SVF | ucm_SUN_Gh |  0.63166147 |  0.635095137 | 44 |
| gvi_50m | ucm_SND_dBA | -0.60895015 | -0.707072131 | 44 |
| SVF | ucm_SND_dBA |  0.60454859 |  0.622995878 | 44 |
| ucm_AIR_T_mid | ucm_SND_dBA |  0.59641208 |  0.673878573 | 44 |
| SVF | ucm_PET |  0.59433567 |  0.634271821 | 44 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.59096328 |  0.627858628 | 44 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.56374030 | -0.576603242 | 44 |
| lys_lux_avg | ucm_AIR_RH | -0.52412201 | -0.564482030 | 44 |
| lys_lux_avg | ucm_AIR_T_mid |  0.51623956 |  0.507681466 | 44 |
| gvi_50m | lys_lux_avg | -0.51600285 | -0.485976039 | 44 |
| lys_lux_avg | ucm_UTCI |  0.50638958 |  0.440310078 | 44 |
| SVF | atmo_pm1_avg |  0.49858668 |  0.613199902 | 44 |
| lys_lux_avg | ucm_SUN_Gh |  0.49634607 |  0.521494010 | 44 |
| lys_lux_avg | ucm_MRT |  0.49078068 |  0.502466526 | 44 |
| lys_lux_avg | ucm_PET |  0.47857485 |  0.440677966 | 44 |
| ucm_MRT | ucm_SND_dBA |  0.47176981 |  0.677825153 | 44 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.46927284 |  0.355474118 | 44 |
| atmo_pm2.5_avg | ucm_MRT |  0.44790356 |  0.587315011 | 44 |
| atmo_pm1_avg | ucm_MRT |  0.44696049 |  0.573029353 | 44 |
| SVF | lys_lux_avg |  0.43753260 |  0.450035236 | 44 |
| atmo_pm1_avg | ucm_AIR_T_mid |  0.42988938 |  0.551957434 | 44 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.41657665 |  0.440451022 | 44 |
| SVF | atmo_pm2.5_avg |  0.40961857 |  0.533756166 | 44 |
| ucm_SND_dBA | ucm_UTCI |  0.40449555 |  0.575566440 | 44 |
| atmo_pm1_avg | ucm_SND_dBA |  0.40286857 |  0.545845373 | 44 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.39955925 |  0.407977730 | 44 |
| atmo_pm2.5_avg | ucm_AIR_T_mid |  0.39915478 |  0.576039464 | 44 |
| atmo_pm1_avg | gvi_50m | -0.39641999 | -0.497691956 | 44 |
| lys_lux_avg | ucm_HUMIDEX |  0.39306558 |  0.345736434 | 44 |
| ucm_PET | ucm_SND_dBA |  0.37242555 |  0.566847558 | 44 |
| atmo_pm2.5_avg | ucm_UTCI |  0.36687421 |  0.350669486 | 44 |
| atmo_pm1_avg | ucm_UTCI |  0.36677418 |  0.392684732 | 44 |
| lys_kelvin_avg | ucm_AIR_RH | -0.35985728 | -0.389006342 | 44 |
| lys_lux_avg | ucm_SND_dBA |  0.35566632 |  0.391275239 | 44 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.34829820 |  0.448062016 | 44 |
| atmo_pm1_avg | ucm_AIR_RH | -0.34585888 | -0.528771275 | 44 |
| atmo_pm2.5_avg | gvi_50m | -0.34478408 | -0.480338266 | 44 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.34012708 |  0.322057787 | 44 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.33880859 |  0.415588992 | 44 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.33160934 |  0.236927414 | 44 |
| atmo_pm2.5_avg | ucm_PET |  0.32674463 |  0.327425209 | 44 |
| atmo_pm1_avg | ucm_PET |  0.32473776 |  0.354640919 | 44 |
| atmo_pm10_avg | lys_kelvin_avg | -0.30348248 | -0.251162791 | 44 |
| lys_kelvin_avg | ucm_SND_dBA |  0.29147426 |  0.294513549 | 44 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.27722936 |  0.291190980 | 44 |
| ucm_PET | ucm_WIND_AWS | -0.27703924 | -0.100849220 | 44 |
| SVF | lys_kelvin_avg |  0.27407879 |  0.297392530 | 44 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.27330055 |  0.432643857 | 44 |
| atmo_pm10_avg | ucm_MRT |  0.26954487 |  0.074418605 | 44 |
| ucm_UTCI | ucm_WIND_AWS | -0.25891354 | -0.111909796 | 44 |
| atmo_pm2.5_avg | lys_kelvin_avg | -0.25757388 |  0.064975335 | 44 |
| SVF | ucm_WIND_AWS |  0.24661748 |  0.257364341 | 44 |
| gvi_50m | lys_kelvin_avg | -0.23855029 | -0.339957717 | 44 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.23783953 | -0.238900634 | 44 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.23447637 |  0.279502449 | 44 |
| atmo_pm10_avg | ucm_UTCI |  0.22480579 |  0.038759690 | 44 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.21054789 | -0.395348837 | 44 |
| atmo_pm10_avg | ucm_PET |  0.19149205 | -0.014235879 | 44 |
| lys_kelvin_avg | ucm_AIR_T_mid |  0.18431290 |  0.276109937 | 44 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.18007254 | -0.104157858 | 44 |
| SVF | atmo_pm10_avg |  0.17694353 |  0.093587033 | 44 |
| atmo_pm10_avg | ucm_AIR_T_mid |  0.17131253 |  0.008738548 | 44 |
| lys_kelvin_avg | ucm_MRT |  0.17021846 |  0.319238901 | 44 |
| atmo_pm1_avg | lys_kelvin_avg | -0.16409646 |  0.082384862 | 44 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.16158467 |  0.058773784 | 44 |
| atmo_pm10_avg | ucm_HUMIDEX |  0.14325574 |  0.080761099 | 44 |
| ucm_MRT | ucm_WIND_AWS | -0.14005856 |  0.128541226 | 44 |
| lys_kelvin_avg | ucm_UTCI |  0.13555108 |  0.225088090 | 44 |
| lys_kelvin_avg | ucm_PET |  0.11061857 |  0.216427640 | 44 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.09915449 |  0.187315011 | 44 |
| atmo_pm10_avg | gvi_50m | -0.09562257 |  0.077237491 | 44 |
| lys_kelvin_avg | lys_lux_avg |  0.08722126 |  0.276391825 | 44 |
| atmo_pm1_avg | lys_lux_avg |  0.08553791 |  0.269635999 | 44 |
| lys_lux_avg | ucm_WIND_AWS |  0.07820608 |  0.268217054 | 44 |
| gvi_50m | ucm_WIND_AWS |  0.07017958 | -0.082734320 | 44 |
| atmo_pm2.5_avg | ucm_WIND_AWS | -0.06470749 |  0.132064834 | 44 |
| ucm_AIR_T_mid | ucm_WIND_AWS | -0.06320397 |  0.056236786 | 44 |
| atmo_pm10_avg | lys_lux_avg | -0.05841274 | -0.054545455 | 44 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.04678522 |  0.215440995 | 44 |
| atmo_pm10_avg | ucm_AIR_RH |  0.04552501 |  0.159830867 | 44 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.04401701 | -0.036081748 | 44 |
| atmo_pm10_avg | ucm_SND_dBA | -0.02662553 | -0.201487015 | 44 |
| atmo_pm2.5_avg | lys_lux_avg |  0.02129100 |  0.323890063 | 44 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

---

## H1–H3 time series variants (scripts and outputs)

**Canonical entry point:** `scripts/H1_to_H3_time_series.R` (meeting spec; engine `scripts/H1_to_H3_time_series_core.R`). Defines `H1_TS_*`, `H2_TS_*`, `H3_TS_*` temporal quotes plus `H2_rmcorr`. Default run: all three hypotheses; single hypothesis: `PAPER3_TIME_SERIES_HYPOTHESIS=H1` (or H2/H3) or call `run_h1_time_series()` / `run_h2_time_series()` / `run_h3_time_series()` after sourcing. Narrative specs in `Presentation material/H1_time_series.md`, `H2_time_series.md`, and `H3_time_series.md` remain reference only (also pasted in `methods.md`).

**Single output folder:** `output/statistical_analysis/results/H1_to_H3_time_series/`. All three hypotheses write here; every file is prefixed with the active hypothesis (`H1_`, `H2_`, `H3_`). The former separate folders `H1_time_series/`, `H2_time_series/`, `H3_time_series/` are no longer written.

| Variant | Dispatch | File prefix |
| --- | --- | --- |
| H1 TS | `run_h1_time_series()` or env `PAPER3_TIME_SERIES_HYPOTHESIS=H1` | `H1_` |
| H2 TS | `run_h2_time_series()` or env `PAPER3_TIME_SERIES_HYPOTHESIS=H2` | `H2_` |
| H3 TS | `run_h3_time_series()` or env `PAPER3_TIME_SERIES_HYPOTHESIS=H3` | `H3_` |

**CSVs per hypothesis (`{H}` = H1, H2, H3):** `{H}_Temporal_TimeSeries_AR1_10s.csv`, `{H}_Temporal_AR1_Sensitivity_60s.csv`, `{H}_Model_Audit.csv`, `{H}_Run_Manifest.csv`. H2 also writes `H2_Physio_Psycho_Concordance.csv` (phase-level rmcorr; questionnaires are not repeated at 10 s). H2 trajectory concordance strategies in the spec MD are not implemented. Total: 13 files (4 each for H1 and H3, 5 for H2).

## H1–H3 phase-average run (scripts and outputs)

**Entry point:** `scripts/H1_to_H3_phase_average.R` (renamed from `H1_to_H3.R`; engine `scripts/H1_H3_core.R`). Run: `Rscript scripts/H1_to_H3_phase_average.R`.

**Single output folder:** `output/statistical_analysis/results/H1_to_H3_phase_average/` (override with env `PAPER3_OUT_DIR`). Files are prefixed with the hypothesis (`H1_`, `H2_`, `H3_`); run-level files shared by all three use the `H1_to_H3_` prefix. The earlier flat layout (`results/H1_H3_Contrasts.csv`, `H1_H3_Temporal_*.csv`, `H2_Physio_Psycho_Concordance.csv`, `Model_Audit.csv`, `Run_Manifest.csv`, `Statistical_Results_ForestPlot.jpg` directly in `results/`) is no longer written. The time-series engine keeps its own `H1_to_H3_time_series/` folder.

| File | Content |
| --- | --- |
| `H1_Contrasts.csv` | Phase-mean LMM contrasts H1.1 (BikeG−BikeU), H1.2 (WalkG−WalkU); Primary + Sensitivity_WPZ |
| `H3_Contrasts.csv` | Phase-mean LMM contrasts H3.1 (WalkU−BikeU), H3.2 (WalkG−BikeG); Primary + Sensitivity_WPZ |
| `H2_Physio_Psycho_Concordance.csv` | rmcorr, 4 questionnaires × 26 physiological outcomes |
| `H1_Temporal_TimeSeries_AR1.csv`, `H1_Temporal_AR1_Sensitivity.csv` | 10 s / 60 s AR(1) temporal LMM (WPZ) |
| `H3_Temporal_TimeSeries_AR1.csv`, `H3_Temporal_AR1_Sensitivity.csv` | Same tables as H1 (H1 and H3 share identical temporal shells; one fit, written under both prefixes) |
| `H1_to_H3_Model_Audit.csv`, `H1_to_H3_Run_Manifest.csv` | Run-level audit and manifest (all hypotheses) |
| `H1_to_H3_Statistical_Results_ForestPlot.jpg` | Paired-SMD forest plot (H1 and H3 contrasts) |

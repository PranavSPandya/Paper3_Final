# H4 / H5 analysis discrepancy resolution

**Audit date:** 2026-11-03  
**Scope:** Reconcile `documents/Paper3_outline_ml.md` with active scripts and locked CSV exports for seven previously flagged issues.

---

## 1. Executive summary

| Layer | Role in manuscript |
|--------|-------------------|
| **Primary H4** | `H4_sound_literature_test.R` — five outdoor literature families on field data; FDR within each paper’s own sound-term family; primary exposure **`ucm_SND_dBA`**. |
| **Exploratory / sensitivity** | **H5** (`H5_hotspot_weather.R`, RH1 only while `run_rh1_only = TRUE`); **H6** composites and coupling LMMs; **Analysis** block (`Analysis_combined_timeseries.R`, `Analysis_combined_phaseavg.R` — legacy names `H4_timeseries.R` / `H4_phaseavg.R` in archive). |
| **Not H4 hypothesis** | Additive Eq1–7 combined-exposure LMMs are labeled **Analysis** in the outline (§2.3 item 7, §3.8), not confirmatory H4. Phase-average combined models are explicitly **exploratory sensitivity** in script console output. |

**Outline status:** Discrepancies reconciled against locked exports (2026-11-03). `Paper3_outline_ml.md` was updated in **§2.3 item 4 (H4)**, **§3.5**, **§3.6**, **§3.8–§3.9**, **§4.4**, **Appendix A**, and **Appendix B** (prior pass plus this pass).

---

## 2. Per-issue resolution table

| # | Issue | Was problem? | Current truth (script + export) | Outline status | Resolution |
|---|--------|--------------|----------------------------------|----------------|------------|
| **H1** | H4_phaseavg labeled exploratory vs outline primary H4 | **Was** (older outline) | Primary H4 = `scripts/statistical_analysis/H4_sound_literature_test.R` → `output/statistical_analysis/results/H4_sound_literature_test/`. Phaseavg pipeline = `scripts/statistical_analysis/Analysis_combined_phaseavg.R` (archive: `H4_phaseavg.R`); logs *"Phase-average sensitivity (exploratory multivariate LME)"* and sets `catalog$primary <- FALSE`. | §2.3 item **4** cites `H4_sound_literature_test.R` only for H4. No grep hit for `H4_phaseavg` as primary. | **No further change.** Documented as exploratory Analysis grain, not H4. |
| **H2** | H5 hotspot: corridor_buffer + GPKG vs outline 20 m GPS bins | **Was** | `H5_hotspot_weather.R`: `hotspot_definition = "corridor_buffer"`, `buffer_gpkg_dir = .../data/h5_buffers`, walk **11 m** / bike **35 m** seg cells; `route_distance_bin_m = NULL`. `H5_exploratory_run_info.csv`: `hotspot_definition = corridor_buffer`. | §2.3 item **5**, §3.6, Appendix A: 11 m / 35 m, not k-means/20 m bins. | **Already fixed.** |
| **H3** | RH2–RH4 disabled (`run_rh1_only`) vs outline | **Was** | `H5_hotspot_weather.R`: `run_rh1_only = TRUE`. `H5_hotspot_core.R` skips RH2–RH4 when flag set. | RH2–RH4 = design notes only; §3.6 and Appendix A. | **Already fixed.** |
| **M4** | H4_phaseavg vs H4_timeseries same model two grains | **Was** | Separate scripts/specs: 10 s `Analysis_combined_timeseries.R` (SUN, GVI, SND on Eq1–2, etc.) vs phase `Analysis_combined_phaseavg.R` (no SUN/GVI; phase Eq2 = air T/RH/wind + SVF, **no SND**; different max VIF). Shared engine: `Analysis_combined_core.R` (legacy `H4_core.R`). | §2.3 item **7** and §3.8 describe grain-specific specs. | **Clarified in §3.8** (rename + “not confirmatory H4”; separate VIF). |
| **C5** | H4_timeseries singularity, missing coef table, “155” FDR | **Active audit concern (2026-11-03)** | Archived `.../H4_timeseries/H4_timeseries_fit_status.csv`: **156** rows (config **182** jobs → **26** unaccounted); CSV `success=TRUE` but widespread low **min_cr2_df** and **grid_f + PhaseSum** rank deficiency—**151/2158** and **155** historical FDR **not verified** for manuscript. Active hypothesis CSV counts are descriptive only. | §3.8–§3.9 downgraded; `timeseries_design_audit_notes.md`. | **Outline updated:** no verified Analysis 10 s FDR; ban **155**. |
| **C6** | H9 manifest vs outline 403/1378 | **Naming / dead pipeline label** | Active: `output/.../H6_stress_composite/` — `H6_stress_composite_run_info.csv` manifest: **`n_pairs_fit = 1378`**, **`n_fdr_significant_q05 = 403`**. Archived `H9_run_manifest.csv` (same folder under `results/archive/before_rename_20261101/H9_stress_composite/`) repeats those counts. No live `scripts/.../H9_stress_composite.R` or `results/H9_stress_composite/` export tree—**H9 is a retired label**; do not headline composite results as “H9”. Engine: `library/H6_stress_composite_core.R`; runners `H6_stress_composite_phaseavg.R`, `H6_stress_composite_timeseries.R`. | §3.7 and Appendix B cite 403/1378 on **`H6_stress_composite/`** only. | **Appendix B updated** (H9 = archive naming only). |
| **C7** | `H5_hotspot_cell_audit.csv` — same person multi-day = 0 | **Was** (over-strong moderation claims) | Archived export `.../H5_exploratory/H5_hotspot_cell_audit.csv`: **`n_participant_hotspot_with_2plus_dates = 0`**, `n_participants_with_2plus_campaign_dates = 0`. Not regenerated in current slim `H5_exploratory/` folder; metrics unchanged in archived audit. | §3.6 cautions RH2–RH4 / multi-day replication. | **Appendix A updated** with explicit audit metric. |

---

## 3. What we report correctly (manuscript-ready)

### Methods

- **H4 (confirmatory sound literature):** We test five pre-registered outdoor sound literature families on 11 participants × four phases using `H4_sound_literature_test.R`, with Benjamini–Hochberg adjustment **within each source’s own test × outcome family**. Manuscript sound claims use primary **`ucm_SND_dBA`**; alternative descriptors are exploratory sensitivity in the same export folder.
- **H5 (exploratory hotspots):** Hotspots are **fixed-route corridor buffer cells** (walk 11 m, bike 35 m half-width from local GPKG), assigned via `H5_hotspot_weather.R` / `H5_hotspot_core.R`. **RH1 only** is locked (`run_rh1_only = TRUE`): participant × hotspot × day medians, `median_center_Y ~ env_ucm_UTCI_c + hotspot_f + (1 | ParticipantID)` stratified by phase and outcome. **RH2–RH4** (weather moderation, random slopes) are not reported as verified results.
- **Repeated exposure limits:** Cell audit documents **no** participant × hotspot cells with **≥2 calendar days**; do not claim multi-day within-person hotspot replication or locked weather-moderation effects.
- **Combined exposure (Analysis, not H4):** Additive Eq1–7 LMMs at **10 s** (`Analysis_combined_timeseries.R`) and **phase means** (`Analysis_combined_phaseavg.R`) are **descriptive collinearity-screened models** with separate predictor sets and VIF screening per grain. **Do not cite 10 s or phase FDR row counts as verified confirmatory evidence** (grid–phase aliasing on 10 s; phase **182/182** exploratory with low-df flags). Audit reference: `documents/timeseries_design_audit_notes.md`.
- **H6 composites:** Exploratory pairwise rmcorr among 55 stress-oriented composites (**1378** fitted pairs, **403** q < 0.05, one BH family) under `H6_stress_composite/`; prespecified H6-A/B coupling LMMs are separate scripts/families.

### Results (where to point reviewers)

- H4 sound: `output/statistical_analysis/results/H4_sound_literature_test/SUMMARY_sound_tests_p_and_FDR.csv` (filter `ucm_SND_dBA (primary)`).
- H5 RH1: `output/statistical_analysis/results/H5_exploratory/H5_RH1_hotspot_FDR_all_tests.csv` (`FDR_significant`, **640** / **981** raw p); cell audit metric in `H5_hotspot_cell_audit.csv` (regenerated on full H5 runs; archived copy under `results/archive/before_output_reduction_20261101/H5_exploratory/`).
- H6 composites: `H6_pairwise_rmcorr.csv`, manifest fields in `H6_stress_composite_run_info.csv`.
- Combined exposure: hypothesis / exposure CSVs under `Analysis_combined_timeseries/` and `Analysis_combined_phaseavg/`.

---

## 4. File reference (quick)

| Topic | Active script | Primary export folder |
|--------|---------------|------------------------|
| H4 primary | `H4_sound_literature_test.R` | `H4_sound_literature_test/` |
| H5 | `H5_hotspot_weather.R`, `library/H5_hotspot_core.R` | `H5_exploratory/` |
| Analysis 10 s | `Analysis_combined_timeseries.R` | `Analysis_combined_timeseries/` |
| Analysis phase | `Analysis_combined_phaseavg.R` | `Analysis_combined_phaseavg/` |
| H6 rmcorr | `library/H6_stress_composite_core.R` | `H6_stress_composite/` |
| Legacy names | `scripts/_archive/before_rename_20261101/H4_*.R`, `H9_stress_composite/` | `results/archive/before_rename_20261101/` |

---

## 5. Outline sections touched in this audit

| Section | Change |
|---------|--------|
| **§2.3 item 4 (H4)** | Explicit split: literature-test H4 vs archived Eq1–7 **Analysis** sensitivity. |
| **§3.5** | Locked primary export path; not `H4_phaseavg` / `H4_timeseries`. |
| **§3.6** | Corridor GPKG 11 m / 35 m; RH1-only; `FDR_significant`; cell audit **0** multi-day cells. |
| **§3.8** | Analysis exploratory only; CSV FDR counts not verified; grid–phase aliasing. |
| **§3.9** | **Not publication-ready — do not send time-series claims**; H1 26/26 fail audit; 155 FDR ban. |
| **§4.4** | Name archived `H4_phaseavg` interaction null (0/104), not “combined-model” primary H4. |
| **§4.5** | Epoch models not publication-ready; phase-mean primary only. |
| **Appendix A** | Cell audit metric; RH2–RH4 paused with `run_rh1_only`. |
| **Appendix B** | H6 only; invalid five-participant H9 exports. |

---

## 6. Time-series design audit (2026-11-03)

See **`documents/timeseries_design_audit_notes.md`** for full text. Summary for manuscript guardrails:

1. **Grid–phase aliasing:** `Paper3_corridor_grid.R` phase-embedded grid labels + **PhaseSum** in the same 10 s formula → rank-deficient; not fixed by dropping coefficients.
2. **H1/H3 time-series:** User audit **26/26** failed jobs for aliased design—no verified epoch FDR for H1/H3.
3. **Analysis 10 s:** **156** fit_status rows vs **182** jobs; **155** / **151/2158** FDR **not verified**.
4. **Analysis phaseavg:** **182/182** fitted, exploratory (low-df flags).
5. **H1/H3 FDR families:** two × **n = 26** primary rule; pooled 52-test sensitivity (11 H1 / 9 H3 hits) sensitivity only.

*Generated by discrepancy audit; aligned with `Paper3_outline_ml.md` and locked CSV exports.*

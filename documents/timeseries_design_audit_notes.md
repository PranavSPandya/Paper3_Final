# Time-series design audit (read-only; md-only record)

**Date:** 2026-11-03  
**Scope:** Epoch-level (10 s) LMMs for H1/H3, Analysis Eq1–7, and related exports—not phase-mean confirmatory H1–H3.

---

## 1. Grid–phase aliasing — not in the current formulas

- Corridor labels such as `BikeG_grid1` exist for **H5** (`H5_corridor_grid_label_map.csv`). They are not a fixed effect in the active `Analysis_combined_timeseries.R` or `H1_H3_timeseries.R` equations. Those files were checked on 3 Nov 2026: no `grid_f` term.
- An older audit that treated current 10 s models as rank-deficient because of `grid_f` + `PhaseSum` is **out of date**.
- What the current 10 s H1/H3 export does show: in `H1_H3_Temporal_AR1_10s.csv`, **63 / 546** rows have `stability_flag=rho > 0.95`, and **nine** rows (three heart-rate phase coefficients, repeated) have standard errors above 1,000. Those rows should not be quoted. `success=TRUE` on an Analysis fit-status file does not clear that.

---

## 2. Fit status and FDR (audit findings)

| Pipeline | Audit finding | Manuscript rule |
|----------|---------------|-----------------|
| **H1/H3 time-series** (`H1_H3_timeseries.R`) | User audit: **26 / 26** jobs for the grid+PhaseSum-style epoch specification **failed**; no verified inference export for manuscript. | Do **not** report H1/H3 **10 s** FDR or contrasts as verified. Phase-mean `H1_H3_phaseavg.R` remains primary. |
| **Analysis / archived H4 time-series** | Config **182** jobs (26 outcomes × 7 Eq); archived `H4_timeseries_fit_status.csv` has **156** rows; **26** jobs unaccounted vs config. User audit: **156** recorded **inference failures** (rank/low df)—`success=TRUE` in CSV does **not** mean publishable inference (many **min_cr2_df ≈ 1**). | Do **not** cite **151/2158** or historical **155** FDR as verified confirmatory evidence. |
| **Analysis phaseavg** | **182 / 182** models may fit; many **low effective df** / coefficient flags in fit_status. | Exploratory descriptive only—not confirmatory. |
| **H5 RH1** | **640** exploratory FDR contrasts; **0** same-person multi-day hotspot cells. | Keep exploratory; no multi-day moderation claims. |
| **H6 composites** | Phase-mean **403 / 1378** exploratory; **H9** label retired. | Cite **H6** paths only; invalid any five-participant **H9** export for full cohort. |

Quick file spot-check (2026-11-03): archived `output/.../before_rename_20261101/H4_timeseries/H4_timeseries_fit_status.csv` — 156 rows, all `success=TRUE`, widespread low `min_cr2_df`; aligns with “optimizer succeeded, inference not verified.”

---

## 3. FDR family consistency (H1/H3 phase-mean)

- **Primary (locked, `H1_H3_core.R`):** BH **within each** green-route contrast over **26** primary physiological outcomes → **two families of n = 26** (H1.1 and H1.2 separate; same for H3).
- Some code comments describe “26 × two contrasts” as **one** family—that is **inconsistent** with the locked rule; manuscript follows **separate** families.
- **Sensitivity only:** one pooled BH family over all **52** contrast rows → H1 **11** FDR hits, H3 **9** (e.g. WalkG−WalkU fixation duration *q* ≈ **0.045** pooled vs **0.051** separate)—does **not** replace the primary rule.

---

## 4. Outline cross-references

- Confirmatory core: phase-mean H1–H3, H2 (five FDR pairs—not “zero concordance”), literature H4 on `ucm_SND_dBA`.
- **§3.9** and **§4.5** in `Paper3_outline_ml.md`: **Not publication-ready — do not send time-series claims.**

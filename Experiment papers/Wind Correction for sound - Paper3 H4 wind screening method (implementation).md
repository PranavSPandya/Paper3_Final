# Wind Correction for sound — Paper3 H4 wind screening method (implementation)

**Status:** Implemented in the H4 **sound substitution** pipeline only.  
**Important:** This is **not** a decibel correction. We do **not** subtract dB, apply a wind-speed regression on `ucm_SND_dBA`, or rebuild LAeq from WAV after high-pass removal.

## What we do (exact algorithm)

1. **Input wind field:** `ucm_WIND_AWS` on each **10 s** row of `output/merged_all_11participants_8min.csv` (uCM apparent wind speed, m/s).
2. **Threshold:** Default **5 m/s** (`--wind-max-aws=`, overridable).
3. **Rule (`h4s_wind_keep_mask`):** Keep row if `is.finite(ucm_WIND_AWS)` and `ucm_WIND_AWS <= threshold`; otherwise **exclude that 10 s window** from the analysis dataset for that run.
4. **When applied:** Before bout-centering and before epoch aggregation (30/60/300 s) or phase means. Eligibility for LME uses the screened rows only.
5. **Outputs:** Parallel result trees under `wind_aws_le_5ms/` (name includes threshold). Screening tables:
   - `H4_sound_wind_screening_summary.csv`
   - `H4_sound_wind_screening_by_phase.csv`
6. **Primary (unscreened) sound results are unchanged** unless you explicitly run `--wind-sensitivity`.

## Scientific intent

- **Goal:** Sensitivity analysis for **microphone / outdoor measurement quality**, aligned with common **field-measurement exclusion** practice when wind is high (FHWA; ISO 1996-2 context; mobile mapping literature).
- **Not claimed:** That 5 m/s fully removes wind contamination on body-worn uCM + cycling self-generated airflow (see Cooper & Evans 2015; Zuo et al. 2016).
- **Separate issue:** Eq3 in main H4 (`ucm_WIND_AWS × ucm_SND_dBA`) models **environmental co-exposure**, not microphone QC — not listed below.

## Scripts and files (wind screening only)

| Role | Path |
|------|------|
| **Core logic** | `Paper3_Final/scripts/statistical_analysis/library/H4_sound_core.R` — `h4s_wind_keep_mask`, `h4s_write_wind_screening_report`, `h4s_model_data`, `h4s_outdir`, `h4s_run` |
| **Time series entry** | `Paper3_Final/scripts/statistical_analysis/H4_timeseries_sound.R` — flag `--wind-sensitivity` |
| **Phase-average entry** | `Paper3_Final/scripts/statistical_analysis/H4_phaseavg_sound.R` — flag `--wind-sensitivity` |

**Not using wind screening today:** `H4_timeseries.R`, `H4_phaseavg.R`, `H4_minimal_utci_dba.R`, sound processing / YAMNet notebooks.

## How to run

```text
Rscript scripts/statistical_analysis/H4_timeseries_sound.R --workers=4 --wind-sensitivity
Rscript scripts/statistical_analysis/H4_phaseavg_sound.R --workers=4 --wind-sensitivity
Optional: --wind-max-aws=4
```

## Paper3 results (5 m/s, Oct 2026)

- Core cohort: **2112** ten-second windows; **2110** kept (**99.9%**); two bike-phase windows excluded.
- Sound FDR conclusions **unchanged** vs unscreened (stability check, not a new corrected exposure).

## Related method notes in this folder

- `Wind Correction for sound - FHWA highway noise field measurement wind limit 5 ms.md`
- `Wind Correction for sound - ISO 1996-2 2017 environmental noise measurement wind context.md`
- `Wind Correction for sound - Cooper and Evans 2015 microphone wind speed limits.md`
- `Wind Correction for sound - Zuo et al 2016 Mapping Urban Environmental Noise Using Smartphones.md`

## Field documentation still required (not in repo)

- Windscreen type and condition on uCM sound microphone and WAV recorder.
- Microphone placement relative to body and airflow when walking vs cycling.
- Whether `ucm_WIND_AWS` is measured at the same exposure point as the sound microphone.

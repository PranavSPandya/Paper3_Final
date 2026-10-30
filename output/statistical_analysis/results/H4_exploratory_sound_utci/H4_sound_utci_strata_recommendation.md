# H4 sound × UTCI strata — methods recommendation

## UTCI stress categories (Blazejczyk / UTCI-FEBS)

Use the standard **10-category** UTCI heat-stress scale (not informal “>26 = moderate” shorthand alone):

| UTCI (°C) | Stress category |
|-----------|-----------------|
| 9–26 | No thermal stress |
| **26–32** | **Moderate** heat stress |
| **32–38** | **Strong** heat stress |
| 38–46 | Very strong heat stress |
| >46 | Extreme heat stress |

Exploratory strata in `H4_sound_utci_exposure_explore.R`:

- **A:** UTCI &lt; 26 (no thermal stress)
- **B:** 26 ≤ UTCI &lt; 32 (moderate heat stress)
- **C:** UTCI ≥ 32 (strong and above — combines strong, very strong, and extreme bands)

Sound bands: &lt;60, 60–64, 65–69, 70–74, ≥75 dBA (`ucm_SND_dBA`).

---

## Primary inference (unchanged)

- **Full cohort** `H4_phaseavg_sound.R` and `H4_timeseries_sound.R` remain the **primary** H4 sound analyses.
- Models use **continuous** bout- or phase-scaled `ucm_UTCI` and a substituted acoustic predictor (Eq1 only), with no UTCI hard filter.
- Do **not** rerun the full 26-outcome × all-sound-substitute grid for every dBA × UTCI descriptive cell — insufficient power and massive multiplicity.

---

## Suggested workflow

1. **Descriptive strata (this explore script)**  
   Run `Rscript scripts/statistical_analysis/H4_sound_utci_exposure_explore.R`  
   Outputs under `output/statistical_analysis/results/H4_exploratory_sound_utci/` and figures under `output/Figures/H4_exploratory_sound_utci/`:
   - `H4_sound_dba_bands_by_utci_stratum_participant_phase.csv` — counts / % dBA bands within A/B/C per participant × phase
   - `H4_coexposure_dba70_utci_B_vs_C_*` — loud (≥70 dBA) epochs in moderate (B) vs strong+ (C) thermal strata
   - Cohort summary: `H4_coexposure_dba70_utci_B_vs_C_summary.txt`

2. **Participant-phase screening (existing)**  
   Column `suggested_for_H4_sound` in `H4_sound_utci_exposure_by_participant_phase.csv` flags cells with enough **joint** high sound + UTCI ≥ 26 °C for *optional* supplementary runs — not a replacement for full-cohort inference.

3. **Optional epoch-filter sensitivity (supplementary only)**  
   To ask “under strong heat only, does the Eq1 UTCI × sound interaction differ?” prefer **epoch filtering** over dropping participants:
   - **Epoch filter:** keep rows where `ucm_UTCI >= 32` (and optionally `ucm_SND_dBA >= 70`) before eligibility in `h4s_model_data()` — same 11 participants, fewer rows per bout.
   - **Participant filter:** subset `PAPER3_PARTICIPANTS` or merge a CSV of allowed participant-phases — changes generalizability; use only if pre-registered.

   **What would change in `H4_*_sound.R` / `H4_sound_core.R` (high level):**
   - In `h4s_load()` or early in `h4s_model_data()`, apply an optional mask, e.g. read `Sys.getenv("H4S_UTCI_MIN")` (empty = no filter) and set `valid <- valid & d$ucm_UTCI >= utci_min` (and similarly `H4S_DBA_MIN` for sound).
   - Wind QC already uses `h4s_wind_keep_mask()` via `--wind-sensitivity` / `wind_max_aws`; UTCI/dBA filters would follow the same pattern (environment variables or CLI flags parsed in `h4s_run()`).
   - Re-centering (`h4s_center`) should run **after** filtering so z-scores reflect the subset — important for interpretability of supplementary runs.
   - Write outputs to a **separate** results subfolder (e.g. `H4_timeseries_sound/utci_ge32_dba_ge70/`) so primary results are never overwritten.

4. **When to use UTCI ≥ 26 vs B (26–32) vs C (≥ 32)**  
   - **≥ 26:** inclusive “any heat stress” co-exposure screen (includes comfortable-to-warm epochs near 26 and all moderate heat).
   - **B (26–32):** isolates **moderate** heat stress co-exposure with loud sound — often more epochs than C in this cohort.
   - **≥ 32 (C):** stricter **strong+** heat — fewer epochs, clearer physiological stress, but sparse for stable LME fits unless pooled across participants/phases.

   Compare B vs C using the co-exposure summary CSV/txt before committing to a filtered model run.

---

## How `H4_*_sound.R` runs (plain language)

1. Entry script (`H4_timeseries_sound.R` or `H4_phaseavg_sound.R`) defines **Eq1** with placeholder `SOUND_bout_z` / `SOUND_phase_z` and a numbered list of **23 acoustic columns** that replace dBA one at a time.
2. `H4_sound_core.R` loads the merged 8-min matched CSV, applies bilateral PM/lux/kelvin means, HRV window masking, SVF carry-forward, and builds `Time10` within each participant-phase bout.
3. For each (sound substitute × physiological outcome) job, `h4s_model_data()` keeps epochs with finite outcome and all Eq1 predictors, optionally drops windy 10 s windows (`--wind-sensitivity`), then either:
   - **Timeseries:** bout-centers predictors (or aggregates to 30/60/300 s bins first), fits nested `(1 | ParticipantID/PhaseID)` LME with AR(1) on time.
   - **Phaseavg:** phase-means on eligible epochs, participant-centered phase z-scores, random intercept by participant.
4. Results go to `output/statistical_analysis/results/H4_timeseries_sound/` (or `H4_phaseavg_sound/`), with FDR across outcomes within coefficient type — **separate** from primary `H4_timeseries/` dBA models.

Default command (wider epochs, preserves existing 10 s root outputs):

```text
Rscript scripts/statistical_analysis/H4_timeseries_sound.R --workers=4
```

Phase-average analogue: `Rscript scripts/statistical_analysis/H4_phaseavg_sound.R`

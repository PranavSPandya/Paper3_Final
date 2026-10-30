# H4 time-series equations — FDR review summary

Concise review of Benjamini–Hochberg FDR results for the seven bout-level H4 time-series models (Eq1–Eq7 in `H4_timeseries.R` / `h4_equation_table`).

## Findings

- **All seven equations** have at least one FDR-significant row (**155** FDR rows total in the main coefficients file).
- **No FDR on primary exposure terms:** zero hits on bout **UTCI**, **SND_dBA**, or **UTCI × sound** (and no other thermal × sound interaction) in the main exposure columns.
- **Most FDR signal is phase and covariates:** mainly **phase contrasts** (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`) and **bout covariates**; **pupil outcomes** account for much of the non-phase FDR (typically six or seven FDR rows per equation on pupil measures).
- **Eq3 and Eq4 only** add **heat-term FDRs on pupil** via pupil-adjustment copies of heat predictors (`ucm_*`), not on UTCI/dBA/interaction in the UTCI-based equations.

## FDR rule

A row is FDR-significant when **`FDR_significant`** = `TRUE` in the export. Correction is **BH per term within each equation across the 26 planned outcomes** (see **`FDR_scope`**). Intercepts are not FDR-tested.

## Per-equation FDR counts (main run)

| Eq | Model (heat / PM) | FDR rows | Exposure-term FDR? |
|----|-------------------|----------|--------------------|
| 1 | UTCI / PM2.5 (primary) | 22 | No |
| 2 | UTCI / PM2.5 (sound sensitivity) | 20 | No |
| 3 | AIR_T + RH + wind / PM2.5 | 24 | Yes — 2 pupil heat terms |
| 4 | HUMIDEX / PM2.5 | 23 | Yes — 1 pupil heat term |
| 5 | PET / PM2.5 | 22 | No |
| 6 | UTCI / PM1 | 22 | No |
| 7 | UTCI / PM10 | 22 | No |

**Eq3 pupil heat FDRs:** `ucm_MRT` → pupil diameter avg; `ucm_AIR_T_mid` → pupil change rate.

**Eq4 pupil heat FDR:** `ucm_HUMIDEX` → pupil change rate.

Across the main file, **3** FDR rows have `term_type` = thermal exposure (all three are these pupil `ucm_*` terms). **Zero** FDR for sound exposure or thermal × sound interaction.

## Sound-only substitution run (Eq1 variants)

From **`H4_sound_coefficients.csv`**: **508** FDR-significant rows across alternative sound measures, **zero** on exposure-class terms (thermal, sound, thermal × sound).

## Source paths

- `d:\Pranav\docker\Paper3_Final\output\statistical_analysis\results\H4_timeseries\H4_timeseries_coefficients.csv`
- `d:\Pranav\docker\Paper3_Final\output\statistical_analysis\results\H4_timeseries_sound\H4_sound_coefficients.csv`
- `d:\Pranav\docker\Paper3_Final\scripts\statistical_analysis\H4_timeseries.R` (Eq1–7 definitions)

Verified from **`FDR_significant`** and **`term_type`** columns in the two coefficient CSVs (2026-10-29).

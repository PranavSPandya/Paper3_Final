# H4 time-series equations: FDR summary

Plain-language summary of false-discovery-rate (FDR) results for the seven pre-specified H4 bout-level time-series models (Eq1–Eq7 in `H4_timeseries.R` / `h4_equation_table`).

## Headline

- **All seven equations** have at least one FDR-significant coefficient row (155 FDR rows total in the main run).
- **Primary exposure terms do not survive FDR:** no hits on bout-level **UTCI** (Eq1, 2, 6, 7), **SND_dBA** (all equations), or **UTCI × sound** (or other heat × sound interaction) terms in the fitted exposure columns (`term_type`: thermal exposure, sound exposure, thermal × sound interaction) when those terms are the main (non-pupil) predictors.
- **Most FDR signal is elsewhere:** mainly **phase contrasts** (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`) and **covariates** (especially **SVF**, **solar** `ucm_SUN_Gh`, and related bout covariates), not thermal or acoustic exposure.
- **Eq3 and Eq4 only** add a small number of **heat-related FDRs on pupil outcomes** via the pupil-adjustment (`ucm_*`) copies of heat terms (see below)—still not on the primary UTCI/dBA/interaction exposure terms in the UTCI-based equations.

## FDR rule (as recorded in outputs)

Significance is flagged in **`FDR_significant`** in the coefficients export. Correction is **Benjamini–Hochberg (BH) per term within each equation across the 26 planned outcomes** (see `FDR_scope` in the same file). Intercepts are not tested for FDR.

## Main seven-equation run

| Eq | Model label (heat / PM) | FDR row count | Any heat or sound **exposure** FDR? |
|----|-------------------------|---------------|-------------------------------------|
| 1 | UTCI / PM2.5 (primary) | 22 | No |
| 2 | UTCI / PM2.5 (sound sensitivity) | 20 | No |
| 3 | AIR_T_mid + RH + wind / PM2.5 | 24 | Yes — 2 pupil heat terms (see note) |
| 4 | HUMIDEX / PM2.5 | 23 | Yes — 1 pupil heat term |
| 5 | PET / PM2.5 | 22 | No |
| 6 | UTCI / PM1 | 22 | No |
| 7 | UTCI / PM10 | 22 | No |

**Eq3 pupil heat FDRs (2 rows):** `ucm_AIR_T_mid` → pupil change rate; `ucm_MRT` → pupil diameter avg.

**Eq4 pupil heat FDR (1 row):** `ucm_HUMIDEX` → pupil change rate.

Across the full main coefficients file there are **3** FDR rows with `term_type` = thermal exposure; all three are these pupil `ucm_*` heat terms. **Zero** FDR rows for sound exposure or thermal × sound interaction.

## Sound-only substitution run (Eq1 variants)

Exploratory **Eq1-only** models that swap alternative sound measures for dBA (`H4_timeseries_sound.R` / `H4_sound_coefficients.csv`):

- **508** FDR-significant rows in total.
- **Zero** FDR on exposure-class terms (thermal, sound, or thermal × sound interaction)—same pattern as the main run for hypothesis-relevant exposure.

## Primary source files

- `d:\Pranav\docker\Paper3_Final\output\statistical_analysis\results\H4_timeseries\H4_timeseries_coefficients.csv`
- `d:\Pranav\docker\Paper3_Final\output\statistical_analysis\results\H4_timeseries\H4_timeseries_hypothesis.csv` (hypothesis-focused companion)
- `d:\Pranav\docker\Paper3_Final\output\statistical_analysis\results\H4_timeseries_sound\H4_sound_coefficients.csv`
- `d:\Pranav\docker\Paper3_Final\scripts\statistical_analysis\H4_timeseries.R` (Eq1–7 definitions and `h4_equation_table`)

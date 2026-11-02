# Reading the Paper 3 statistical code

Start with an entry script in this directory. It specifies the cohort, outcomes, transformations, hypotheses/equations and run entry. Shared engines are in library/. Run entry scripts in a fresh R session with Rscript; avoid sourcing multiple analyses into the same global environment.

| Entry script | Shared engine / purpose |
|---|---|
| Analysis_combined_phaseavg.R | Analysis_combined_core.R; additive exposure models on participant-phase averages |
| Analysis_combined_timeseries.R | Analysis_combined_core.R; additive exposure models with within-phase temporal dependence; optional lag/source-adjusted blocks |
| H1_H3_phaseavg.R | H1_H3_core.R; participant-phase contrasts and physiology/questionnaire concordance |
| H1_H3_timeseries.R | H1_H3_core.R; time-series counterparts; public run functions also support individual hypotheses |
| H4_sound_literature_tests.R | `library/H4_sound_literature_helpers.R`; literature-inspired field adaptations; sections named for the source method |
| H5_hotspot_weather.R | H5_hotspot_core.R; hotspot and urban-form analyses |
| H6_stress_composite_phaseavg.R | H6_coupling_core.R; prespecified env/psych→physio coupling LMMs on phase means |
| H6_stress_composite_timeseries.R | H6_coupling_core.R; same H6-A/H6-B grid on 10 s epochs with AR(1) |

Paper3_common.R defines shared cohort, normalization and path helpers. Paper3_output_names.R handles published CSV names, correction-family checks, consolidated metadata and the maximum-five-file publication guard. Review OUTPUT_NAMING_STANDARD.md for the column vocabulary.

H5 corridor buffer GeoPackages live in `data/h5_buffers/` (copied from `D:/Pranav/docker/ExpData/Experiment path_8min_buffer`); `H5_hotspot_weather.R` resolves `buffer_gpkg_dir` there via `paper3_statistical_script_dir()`.

Internal h4_/H4_ identifiers in the combined-analysis engine are legacy identifiers. They do not refer to the current H4 literature script. They remain stable to avoid changing checkpoint and dispatch interfaces. Sensor variable names retain the input schema.

The explicit Eq1-Eq6 quotes in the combined entry scripts are the source of truth: current equations use additive exposure terms, not heat-by-sound interactions. The engines contain reusable interaction-handling code; its presence does not mean the current equations contain interactions.

Read results with their inference/reporting status and METHODS_NOTES. A schema validation pass does not establish scientific validity of a model. Public run functions are intentionally retained; a function without an internal caller is not necessarily dead code.

2026-11-01 readability cleanup: conflicting equation comments corrected; obsolete filename references clarified; unused literature helpers/columns removed; main literature result objects renamed; repeated H1-H3 setup extracted. Model expressions and output schemas preserved. No model refit or runtime benchmark was performed for this cleanup.

## Merge published outputs

Run `Rscript scripts/statistical_analysis/Merge_statistical_outputs.R` to refresh four CSVs in `output/merged`. This collects rows without refitting models or recalculating FDR. Each source script stays in one merged file.

| Analysis script | Merged CSV |
|---|---|
| Analysis_combined_phaseavg.R | Analysis_combined_merged.csv |
| Analysis_combined_timeseries.R | Analysis_combined_merged.csv |
| H1_H3_phaseavg.R | H1_H3_H6_merged.csv |
| H1_H3_timeseries.R | H1_H3_H6_merged.csv |
| H6_stress_composite_phaseavg.R | H1_H3_H6_merged.csv |
| H6_stress_composite_timeseries.R | H1_H3_H6_merged.csv |
| H4_sound_literature_tests.R | H4_sound_results.csv |
| H5_hotspot_weather.R | H5_grid_results.csv |

Every inferential export uses the shared compact schema from library/Paper3_output_names.R. script_name and source_table retain provenance. The only primary significance columns are p_value, q_value (original primary BH adjustment), and FDR_significant (q_value < 0.05). Equation-adjusted alternatives are excluded from statistical tables. Existing run_info files retain correction families and source context for auditing and figure readers. Support data, summaries and diagnostics have their own appropriate schemas; they are not concatenated as statistical tests.

Entirely empty columns are omitted. An individual cell may remain empty when that test does not supply the quantity; nothing is invented to fill it. Numeric test statistics use test_statistic; readable test names use statistic_test. Predictor and comparison are separate fields. Human-facing spatial identifiers use grid_id/grid_label. Literal script and source filenames retain their actual on-disk names for provenance.

Published results retain the existing maximum-five-file guard. The compact exporter is transactional and idempotent. Naming consistency does not change inference/reporting eligibility or establish scientific validity. Literature branches marked for review remain marked in inference_note.

Follow-up audit clarification (2026-11-01): the 60-s sensitivity CSV now contains the actual 60-s estimates/p/q, not the 10-s reference columns. References remain in run_info for plotting. If a q-value is unavailable, FDR_significant is blank, never FALSE. Temporal result rows repeated under H1/H2/H3 describe the same fitted coefficients; do not count them as independent results (63 significant60-s rows represent21 distinct coefficient results). Existing saved60-s df/CIs and H4 sample/uncertainty fields may be unavailable; the exporter does not borrow them from another model. Future temporal runs retain the actual60-s df/statistic/participant count. Current merged column counts are20,27,14,23 respectively.


## Code readability conventions — 2026-11-02

Use descriptive English names for data tables, file paths, metadata, row selections and callbacks. Reserve p, q, n, df, t, r and z for statistical quantities. In particular, df denotes degrees of freedom; table arguments use descriptive data names. Preserve published sensor/CSV field names and the legacy h4_ interfaces used by checkpoints. A shorter implementation must keep the existing model specification, inference family, exclusion rules, validation and error handling.

The H5 BH helper now delegates to stats::p.adjust on finite p-values. Comparisons against the previous implementation passed for edge cases and every current H5 correction family, with unchanged significance decisions. Removed unused local calculations and corrected obsolete internal-function comments. Existing mathematical x/y notation remains where appropriate.

The active H6 entry scripts use H6_coupling_core.R. H6_stress_composite_core.R is retained for legacy/archived callers; it is not the active coupling engine. Archived scripts were not edited. Existing result and checkpoint code hashes retain their historical fitting provenance; a source cleanup does not rewrite those records.

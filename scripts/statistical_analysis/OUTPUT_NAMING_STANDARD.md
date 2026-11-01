# Statistical output naming

All analysis entries share library/Paper3_output_names.R. Internal model objects retain their original names; inferential CSVs are compacted at publication.

Primary significance: p_value (raw), q_value (existing primary Benjamini-Hochberg adjusted p), FDR_significant (TRUE if q_value < 0.05; unavailable when q is unavailable). No equation-adjusted p/q alternatives are exported in statistical tables. Here q_value names a BH-adjusted p, not a Storey q-value.

Provenance: script_name, source_table; model_id/context and outcome identify the question. predictor identifies a regression coefficient; comparison identifies a comparison. test_statistic is numeric and statistic_test names the test in words.

Retain available effect estimates, std_error, ci_lower/ci_upper; correlation and standardized differences use their own named intervals. Keep df and available n_participants/n_observations/n_pairs/n_grids, which are not substitutes for df. phase_id and grid_id/grid_label are retained where applicable. scale identifies transformations/units and inference_note retains warnings and reporting restrictions.

Entirely blank nonessential columns are removed per table and after merging. Missing cells reflect genuinely unavailable or inapplicable quantities. Do not fill a missing coefficient CI with a correlation CI or use a test statistic as an effect estimate.

The existing run_info CSV stores compacted source context, correction family/method/size, dictionary and final checksums. These audit records and support tables are not additional statistical result rows. Notebook readers recover context from run_info without expanding public statistical CSVs. Source values and original FDR families are validated before transactional publication; repeated normalization must be byte-identical.

Four collected outputs go in output/merged; see README.md for the complete script mapping. No model refitting or adjustment recalculation occurs during collection.

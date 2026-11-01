# Statistical output naming

Presentation-only normalization runs after each entry script completes. Model formulas, raw sensor schemas, transformations, p-values and correction families are unchanged. Diagnostic/cache tables without inference are left in their native schema.

Core columns: outcome, term, contrast, participant_id, phase_id, model_id, estimate, estimate_type, std_error, ci_lower, ci_upper, confidence_level, statistic, statistic_type, df, p_value, p_value_adjusted, adjustment_method, adjustment_family, adjustment_family_size, significant_unadjusted, significant_adjusted.

BH values are adjusted p-values, not universally Storey q-values. Adjustment method is explicit. Unknown planned family sizes remain blank and source-defined families are marked for reference to source methods rather than guessed. Existing scope/size fields are retained when present.

Correlation confidence intervals are correlation_ci_lower/upper; SMD intervals are smd_ci_lower/upper. Generic estimate_type values explicitly request test-definition interpretation where a source table mixes effects. Undefined inference flags are blank, with status text retained separately.

Duplicate aliases merge only when observed values agree or are missing in complementary rows. Conflicting duplicates stop normalization. Existing numerical values are preserved, including p/q values that may require scientific review. Naming is not model validation.

Source: https://stat.ethz.ch/R-manual/R-devel/library/stats/html/p.adjust.html
Source: https://www.itl.nist.gov/div898/handbook/prc/section1/prc14.htm

Validation: all edited R files parse; 17 active inference CSVs checked for unchanged row counts and original nonmissing numeric/text values, allowing documented separation of F statistics and unavailable-inference flags. Models were not refitted.

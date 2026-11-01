# Verification of Sound_previous_literature_tests.R

The analysis script and existing results were not changed. This audit distinguishes published methods from adaptations to Paper 3. Six full texts were inspected; two are abstract-only pending full-text access.

| Paper | Evidence available | Verified method | Recommended script action |
|---|---|---|---|
| Jo 2019, DOI 10.3390/ijerph16152649 | Downloaded full PDF, Methods 2.4 and 2.6 | Paired one-sided t-tests of 60-s physiological averages; ln(HF), ln(LF/HF). Wilcoxon for psychological ratings. | Keep paired tests and directions for matching endpoints. Label full-phase and additional-outcome tests as extensions. Do not label 5-minute HRV as 60-s HRV. |
| Yousefinezhad 2026, DOI 10.1038/s41598-026-41251-6 | Existing full PDF, Methods pp. 4-6 | Balanced four-condition crossover; RM-ANOVA, sphericity correction, Friedman fallback; Wilcoxon post hoc after significant omnibus. Baseline, initial and final physiological measurements. | Keep test framework. Document field cutoffs as adaptations: UTCI>26 is not their WBGT 30.62; dBA>=65 is not their 75-dBA exposure. Separate condition averages from baseline/time comparisons. Gate post-hoc claims and summary by omnibus significance. |
| Dehghan 2017, DOI 10.4103/jehp.jehp_107_15 | Downloaded PMC full HTML | Friedman on blood-pressure measurements under heat/noise conditions; 75/85/95 dB and heat 40 C, RH30%. | Keep Friedman as a methodological extension to our outcomes. Do not call our four categories or 26 outcomes an exact replication; BP is unavailable. |
| Molaeifar 2020, DOI 10.32604/sv.2020.08810 | Downloaded full PDF, Methods and Tables 3-5 | Five exposure/workload modes; repeated baseline/5/10/20-min measurements; linear mixed model and paired t-tests. Tables also mention ANCOVA. | Current single Hot+Loud vs Cool+Quiet comparison reproduces only the generic paired-test idea. State this explicitly; do not invent unreported full mixed-model formula. Do not require all four categories for a two-category contrast unless scientifically intended. |
| Tohidi 2025, DOI 10.1016/j.exger.2025.112829 | Primary abstract only; full-text download blocked (403) | Three-way ANOVA: temperature, sound type, sound level; 216 elderly men. | Current two-way ANOVA omits sound type: not an exact replication. Do not change to three-way until full Methods and sound-type mapping are verified. Our repeated participant cells also require a dependency-aware analysis; exact original random/repeated structure remains unverified. |
| Abbasi 2020, DOI 10.1016/j.apergo.2020.103189 | Primary abstract only; full-text download blocked (403) | 35 men, eight sessions, four air temperatures 18/22/26/30 C and two sound levels 55/75 dBA. | Restore accurate source description: script omits 18 C. Full ANOVA structure and workload treatment remain unverified. Nearest-level field binning must be described as our adaptation, not experimentally assigned levels. |
| Rodrigues 2026, DOI 10.1007/s11524-025-01051-1 | Existing full PDF, Statistical Analysis pp.5-6 | Trip-level participant random-intercept mixed models; standardized predictors; five blocks fitted separately; p<.05 and absolute beta>.1. | Keep separate sound and temperature blocks and participant intercept. Verify exact mean/max/SD predictor sets, outcome transformations and Wald-z implementation against the cited 7.Model_H2.py repository before calling them exact. The main text does not justify claiming a fully identical formula. |
| Kraus 2013, DOI 10.1289/ehp.1205606 | Existing full PDF, pp.608-609 | Five-minute aligned exposure/outcome windows; random participant effect, compound-symmetry structure, lagged outcome; HRV logged, HR adjustment, forced activity/time trends; AIC choices; noise lags to15min; piecewise at65dBA. | Change the stated/source-matching window from60s to5min. Keep piecewise65, log-HRV and activity/HR adjustment. The existing random intercept already implies an exchangeable covariance component; do not automatically add redundant corCompSymm. Check exact covariance against supplement. Current minute lag and absent lagged sound are different; our8-min phases cannot support their full within-phase15-min lag design. |

## Specific code corrections that preserve questions

1. Export post-hoc FDR and Friedman FDR columns after they are computed (currently saved too early).
2. Preserve paper-style unadjusted p columns and label added q columns separately. State all family definitions and the full analysis search.
3. The Yousefinezhad condition indexing correctly labels Heat and Noise; no relabelling correction is needed.
4. Factorial ANOVA currently omits participant despite repeated participant cell means. Preserve the temperature/noise questions but document and implement dependency handling if this branch is retained. This is an adaptation required by our data, not a criticism of the source study.
5. Gate post-hoc significance counts by the significant omnibus test when following the Yousefinezhad rule.
6. Reject non-estimable/degenerate designs, record failed fits, cell counts, informative repeated participants and model diagnostics. A near-zero random intercept alone does not invalidate a model.
7. Check constant paired differences and all-missing outcome cells; t.test may otherwise stop the complete run.
8. Label nearest-level temperature/noise categories honestly and report observed ranges. Do not portray them as the source's controlled chamber settings.
9. Keep Rodrigues's original Wald-style output if confirmed by source code; add a separately labelled small-sample sensitivity rather than silently replacing its method.
10. Save a source-method table with each output. Use 'adapted from' unless exposure design, measurement windows, endpoints and inference match.

## Access status

Full texts present/obtained: Jo, Yousefinezhad, Dehghan (HTML), Molaeifar, Rodrigues, Kraus.
Not obtained: Tohidi and Abbasi full PDFs. Primary citation/abstract evidence is recorded separately; it is not a substitute for verified Methods. No blocked page or abstract is disguised as a PDF.

## Sources
- https://pmc.ncbi.nlm.nih.gov/articles/PMC6695879/
- https://www.nature.com/articles/s41598-026-41251-6
- https://pmc.ncbi.nlm.nih.gov/articles/PMC5441193/
- https://www.techscience.com/sv/v54n3/40076
- https://pubmed.ncbi.nlm.nih.gov/40651671/
- https://pubmed.ncbi.nlm.nih.gov/32678791/
- https://doi.org/10.1007/s11524-025-01051-1
- https://pmc.ncbi.nlm.nih.gov/articles/PMC3672128/


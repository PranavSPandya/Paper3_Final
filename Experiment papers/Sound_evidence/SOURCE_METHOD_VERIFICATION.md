# Verification of Sound_previous_literature_tests.R

The analysis script and existing results were not changed. This audit distinguishes published methods from adaptations to Paper 3. Six full texts were inspected; two are abstract-only pending full-text access.

| Paper | Evidence available | Verified method | Recommended script action |
|---|---|---|---|
| Jo 2019, DOI 10.3390/ijerph16152649 | Downloaded full PDF, Methods 2.4 and 2.6 | Paired one-sided t-tests of 60-s physiological averages; ln(HF), ln(LF/HF). Wilcoxon for psychological ratings. | Keep paired tests and directions for matching endpoints. Label full-phase and additional-outcome tests as extensions. Do not label 5-minute HRV as 60-s HRV. |
| Yousefinezhad 2026, DOI 10.1038/s41598-026-41251-6 | Existing full PDF, Methods pp. 4-6 | Balanced four-condition crossover; RM-ANOVA, sphericity correction, Friedman fallback; Wilcoxon post hoc after significant omnibus. Baseline, initial and final physiological measurements. | Keep test framework. Document field cutoffs as adaptations: UTCI>26 is not their WBGT 30.62; dBA>=65 is not their 75-dBA exposure. Separate condition averages from baseline/time comparisons. Gate post-hoc claims and summary by omnibus significance. |
| Dehghan 2017, DOI 10.4103/jehp.jehp_107_15 | Local publisher PDF + PMC HTML | Friedman on blood-pressure measurements under heat/noise conditions; 75/85/95 dB and heat 40 C, RH30%. | Keep Friedman as a methodological extension to our outcomes. Do not call our four categories or 26 outcomes an exact replication; BP is unavailable. |
| Molaeifar 2020, DOI 10.32604/sv.2020.08810 | Downloaded full PDF, Methods and Tables 3-5 | Five exposure/workload modes; repeated baseline/5/10/20-min measurements; linear mixed model and paired t-tests. Tables also mention ANCOVA. | Current single Hot+Loud vs Cool+Quiet comparison reproduces only the generic paired-test idea. State this explicitly; do not invent unreported full mixed-model formula. Do not require all four categories for a two-category contrast unless scientifically intended. |
| Tohidi 2025, DOI 10.1016/j.exger.2025.112829 | Local full PDF, Methods §2 and Results §3 | Three-way ANOVA (temperature × sound type × noise level); 216 elderly men; 20/25/30 C; music/traffic/crowd; 55–85 dBA. Also reports two-way ANOVAs with sound type held constant. | Current two-way ANOVA omits sound type: not an exact replication. Three-way extension needs field mapping for sound *type*, not only level. Repeated participant cells require dependency-aware analysis; between-subjects cell structure differs from our repeated walks. |
| Abbasi 2020, DOI 10.1016/j.apergo.2020.103189 | Local full PDF, Methods §2.2–2.3.3 | 35 men, eight within-subject sessions, temperatures 18/22/26/30 C and 55/75 dBA; repeated-measures ANOVA (Huynh–Feldt), Tukey, ES; N-back + EEG/ECG/HRV. | Restore accurate source description: script omits 18 C. RM-ANOVA on chamber neurophysiology/working memory is an adaptation template for our field HRV categories, not a literal endpoint match. Nearest-level field binning must be described as our adaptation. |
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

## Field evidence set (2026-11-02): chamber sources archived, outdoor blocks active

The six chamber templates above (Jo 2019, Yousefinezhad 2026, Dehghan 2017, Molaeifar 2020, Tohidi 2025, Abbasi 2020) were removed from the active `H4_sound_literature_tests.R` pipeline on 2026-11-02 and archived at `scripts/statistical_analysis/_archive/H4_sound_literature_tests_chamber_blocks_20261102.R` (tier `lab_precedent_archived`; results preserved at `output/statistical_analysis/results/archive/H4_sound_literature_tests_chamber_blocks_20261102/`). The verification rows above remain valid for citing them as **laboratory precedent**, not as H4 field tests. Replacement ranking: `documents/H4_outdoor_replacement_papers.md`. Active blocks, verified against local PDFs:

| Paper | Evidence available | Verified method | Script action |
|---|---|---|---|
| Moshammer 2019, DOI 10.3390/ijerph16050788 | Local MDPI PDF | Outdoor 1-h walks (Vienna road vs park, plus earplug/playback settings); class-1 SLM LAeq per 15 min; ambulatory ECG-HRV + BP; air temperature retained as a dominant model covariate; noise effects robust to temperature adjustment. | (a) Phase LMM per 8 cardiovascular outcomes: outcome ~ phase Leq/5 dB + MET (+ air temp) + (1\|Participant), slope reported with and without the temperature term. (b) Road-vs-park analogue: paired WalkG−WalkU contrast, unadjusted and delta-temperature adjusted (ANCOVA intercept). BP endpoint unavailable; quasi-2×2 earplug/playback design not reproduced. |
| Mahecha 2018, DOI 10.3390/su10072379 | Local PDF (`Sound - The influence of noise, vibration, cycle paths...`) | Naturalistic cycling (São Carlos); backpack noise sensor; smartband SCL + skin-temperature stress events; logit models; period-of-day effects. | Epoch binomial GLMM: EDA stress event ~ loud (≥65 dBA) + PhaseID + (1\|Participant), Bike phases only. EDA event definition is ours (phasic > 0 or participant top-decile tonic), not their SCL algorithm; ambient thermal not modelled in source. Exploratory tier. |
| Teixeira 2020, DOI 10.1016/j.jtrangeo.2020.102830 | Local PDF (`Sound - Does cycling infrastructure reduce stress biomarkers...`) | 6-km routes, 5 European cities, 70 cyclists; same smartband noise/stress-biomarker stack; multilevel logit; noisier places ↑ stress in all cities. | Same GLMM family on all four core phases (multi-route comparison analogue). Same event-definition and thermal caveats as Mahecha. Exploratory tier. |
| Jin, Jin & Kang 2020, DOI 10.1016/j.buildenv.2019.106517 | Local PDF (`Sound - Combined effects of the thermal-acoustic environment...`) | Urban squares, 3 seasons; on-site LAeq + air temperature; subjective votes; temperature × traffic-noise interaction tested; higher traffic noise lowered thermal comfort in all seasons. | Perception family (separate from the 26 physio outcomes): end-of-phase thermal comfort + environmental comfort ~ dBA bin (≥65) × UTCI bin (>26), participant-blocked ANOVA on 44 phase cells. Bins observational, not chamber levels; quiet×hot cell n=3 (imbalance documented). |
| Burns 2016, DOI 10.3390/ijerph13010140 | Local MDPI PDF | 24-h personal noise dosimetry + continuous ambulatory HR, outdoor e-waste workers (Ghana); HR ~ noise dose-response; thermal not modelled. | Phase LMM HR ~ Leq/5 dB + MET + (1\|Participant); cardiovascular-only echo of the Kraus anchor. |
| Korpilo 2024, DOI 10.1016/j.ufug.2024.128286 | Local OA PDF | Outdoor walking field RCT (n=45; beach/forest/urban park); continuous EDA; NDSI soundscape classes from 5-min audio; beta GLMM with temperature + RH covariates. | Simplified LMM on phase means: EDA (CSV transform) ~ Leq/5 dB × PhaseID + UTCI + RH + (1\|Participant); personal dBA replaces NDSI (not measured); PhaseID replaces setting classes. Sound family = Leq main + 3 interaction terms. |
| Rodrigues 2026 / Kraus 2013 (anchors) | see rows above | unchanged | Blocks, review-pending gating and FDR families unchanged. |

**Screened, not coded (documented in METHODS_NOTES.md):** Tartarini 2023 Cozie (descriptive; superseded by Korpilo), Schaupp 2025 (green-vs-urban physio contrast covered by anchors; cortisol unavailable), Lan 2024 (same contrast), Zhang 2026 + Lam 2024 (aesthetic/PEQ scales not collected; Jin block is the perception analogue), Tu 2026 (multi-pathway mediation not replicable on 44 phase cells; EDA template overlaps Korpilo), Li 2026 (EEG + odor manipulation unavailable).

## Access status

Full texts present/obtained: Jo, Yousefinezhad, Dehghan (PDF+HTML), Molaeifar, Rodrigues, Kraus, Tohidi, Abbasi, Korpilo (field replacement), Moshammer, Mahecha, Teixeira, Jin, Burns, Tartarini, Lan, Schaupp, Lam, Zhang, Tu, Li, Qin.
Not obtained: none of the H4 primary/field-replacement targets listed in `H4_PDF_inventory.md` remain PDF-missing as of 2026-11-02.

## Sources
- https://pmc.ncbi.nlm.nih.gov/articles/PMC6695879/
- https://www.nature.com/articles/s41598-026-41251-6
- https://pmc.ncbi.nlm.nih.gov/articles/PMC5441193/
- https://www.techscience.com/sv/v54n3/40076
- https://pubmed.ncbi.nlm.nih.gov/40651671/
- https://pubmed.ncbi.nlm.nih.gov/32678791/
- https://doi.org/10.1007/s11524-025-01051-1
- https://pmc.ncbi.nlm.nih.gov/articles/PMC3672128/


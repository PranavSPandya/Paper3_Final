# H4 source-informed analyses and direct H4 test
Run UTC: 2026-11-12 08:48:00 UTC
Input MD5: a3c4f9388b61def82e5b97b4232315be
Code MD5: H4_sound_literature_test.R cf1fa4ccbfa155e91710f065f7ffa0fe
Code MD5: Paper3_common.R bf327b3e8430d19f54d1c3bf27b3a0f8
Code MD5: H4_sound_literature_helpers.R b15c9216b9ea5167159ad104c52209c8

## Purpose
Screened sources provide methodological precedents; local applications are adaptations, not exact replications.
Outcome, instrument, timing, scope and formula differences are documented separately from the source procedures.

## Local formulas (included sources)
- Cureau 2022      : Fisher exact on comfort-domain contingency table, computed separately per park/walk
                    Wilcoxon signed-rank on d_i = Y_i,urban - Y_i,green (paired; source used Mann-Whitney U between parks)
- Grapas 2026      : delay_ij = b0 + b1*exposure_z_ij + (1 | participant)   [delay = lag of peak |cross-correlation|, 0-180 s; no mode term in the source]
- Rodrigues 2026   : Y_ij = b0 + b1*z(NOISE_max_ij) + b2*z(NOISE_sd_ij) + u_0i + e_ij
- Peng 2025        : Y_ij = b0 + b1*X_ij + u_0i + e_ij ; five models: TSV ~ LAeq, TSV ~ ASV, ASV ~ UTCI, ASV ~ LAeq, ASV ~ TSV
- Baquero 2019     : Pearson: stay ~ Ta, RH, dB, wind; Spearman: stay ~ TSV, noise; stay = b0 + b1*Ta + b2*RH + b3*dB + b4*wind   [local stay -> overall_comfort]
Excluded (not run): Pigliautile 2021 (no test), Cureau 2023 (no test), Kraus 2013 (no thermal variable), Ueberham 2019 (perceived exposure, not comfort), Korpilo 2024 (soundscape quality to restoration, not discomfort), Moshammer 2019 (noise and PM on HRV, temperature as weather covariate, not thermal-acoustic discomfort), Grapas Rome 2026 (HR/EDA vs environment; physiology, not thermal-vote H4), Chiucchiù 2026 (NEXT.ROOM indoor chamber; not outdoor walking H4).

## Direct H4 test (H4 conditional slope block)
- Interaction : Y_ij = b0 + b1*dBA_z + b2*UTCI_z + b3*(dBA_z x UTCI_z) (+ Mode when both modes pooled) + u_0i + e_ij ; H4 = b3 in the predicted direction (negative for ratings, positive for HR/EDA/skin temperature)
  8 outcomes on walking bouts (source design). Each is reported at nominal p
  with its predicted sign stated; no multiplicity correction is applied.
  Predicted sign: negative for ratings (comfort, pleasantness, PRS) and HRV; positive for heart rate, EDA, skin temperature.
- Stratified : Descriptive: within thermal half s: Y_i = b0_s + b1_s*dBA_z_i (+ Mode + u_0i when both modes pooled); between-person slope, no inferential contrast between halves
  With 2 bouts per person per mode each thermal half holds 1 bout per person, so the half slopes are
  between-person and descriptive; the earlier Wald slope-difference test was removed.

## Fixes applied 2026-11-10 (H4 audit)
- A1 predicted sign per outcome (predicted_direction, in_predicted_direction).
- A2 Chiucchiu C0/C1 labelled as green/urban route contrast (urban is not warmer for every cyclist).
- A3 slope-difference test removed; stratified slopes descriptive; Mode added when modes are pooled.
- A4 Chiucchiu Table 5 per-soundscape delta removed: lookup never matched and both groups would be the same people.
- A5 Grapas: person-mean Pearson rows replaced by delay ~ exposure + Mode + (1|participant) on a cross-correlation latency proxy.
- A6 Rodrigues TEMP_max = within-bout max of 10 s air temperature (was the mean); NOISE_max already the within-bout max.
- B7 Cureau 2022: paired Wilcoxon signed-rank replaces Mann-Whitney; Fisher exact (seeded Monte Carlo fallback).
- B8 Cureau 2022 multinomial logit: p not reported when LR df >= n/2 (overfitted).
- B11 all models reported; the Moshammer SDNN comparison is selected post hoc for reporting, not preregistered.
- B12 Korpilo crowd proxy renamed urban_negative_sound_share_z (YAMNet share, not a headcount).

## Fixes applied 2026-11-10 (exact-source pass: replications repeat the published methods as-is)
- C1 Moshammer: Mode covariate REMOVED (source is a walking study, no mode term); PM2.5 confounder RESTORED per the source formula; walk = source design.
- C2 Rodrigues: Mode covariate REMOVED (source is walking trips only); walk = source design.
- C3 Korpilo: Mode covariate REMOVED (source is group walks only); walk = source design.
- C4 Grapas: Mode covariate REMOVED (source is walk sessions only); walk = source design.
- D1 Pigliautile 2021, Cureau 2023, Kraus 2013, Ueberham 2019, Korpilo 2024, Moshammer 2019, Grapas Rome 2026 and Chiucchiù 2026 excluded from H4: they do not test thermal discomfort on measured outdoor noise (no test / no thermal variable / perceived exposure, not comfort / restoration / noise-PM HRV / physiology not a thermal vote / indoor NEXT.ROOM chamber).
- Cureau 2022 already matched the source design and is unchanged.
- No included source uses a thermal x sound product term as the test of H4.

## Present study's own model (NOT a paper replication)
- H4 continuous (own model) : Y_ij = b0 + b1*UTCI_z + b2*dBA_z + b3*(UTCI_z x dBA_z) + u_0i + e_ij
- No screened source provides an identical UTCI x personal-dBA model for these local comfort outcomes. This block is reported
  separately and must not be described as a ported source test.

## Inference
- Nominal p for every row. Each source keeps its own published decision rule; no BH/FDR correction is applied.
- paper_rule/source_reference_rule_met describe reference cutoffs only where applicable; analysis_rule/analysis_rule_met record the local decision. No source-replication success flag is exported.

## H4 relevance filter
Source-informed adaptations and the separate present-study model are tagged
in `h4_relevance` with why it does or does not bear on H4:
- `direct`     : the walking dBA x UTCI interactions (is_direct_h4_test = TRUE).
- `contextual` : other thermal-acoustic associations; not direct amplification tests.
- `supporting` : supplies a needed component (sound main effect or thermal
                 main effect) but cannot establish amplification alone.
- `not_h4`     : no thermal term, no sound term, or a non-comfort estimand.
`H4_tests_relevant_to_hypothesis.csv` contains the direct, contextual and supporting rows; is_direct_h4_test identifies the walking interaction rows.

## Scope
Walking bouts only, matching the published European source designs. Cycling is not an H4 extension. Tram is not in H4.

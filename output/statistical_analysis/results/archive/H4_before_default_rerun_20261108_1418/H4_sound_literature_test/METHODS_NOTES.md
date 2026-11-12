# H4 verified source methods: feasible components only
Source PDFs were read directly on 8 November 2026; screened MD was not used as sole evidence.
This does not reproduce any entire experiment. Repeated-measures, phase/site, instrument and rating-scale adaptations are explicit in each result row.
Analysis phases: BikeU, WalkU, BikeG, WalkG
Input MD5: a3c4f9388b61def82e5b97b4232315be
Code MD5: H4_sound_literature_test.R 338eb529f287c7da51cd4b8c9a2fea97
Code MD5: Paper3_common.R 9ef655eb6b642504cb9c4b0503353e0e
Code MD5: H4_sound_literature_helpers.R 6b9bde20e17c64b83d44b322bfe786cd
Source PDF MD5: H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf 4d68efe729200a15976f6033e481781b
Source PDF MD5: H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf 37a32046416c89267ade534dff21d769
Source PDF MD5: Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf bcd044129f93e4b9983482e6e3653913
Source PDF MD5: Sound_evidence/Sound - Wu2025 - thermal acoustic overall comfort cold-region parks.pdf ee86c1a2e569271b2a3ea5546356715d
Source PDF MD5: Sound_evidence/Sound - Xu2026 - threshold thermal-acoustic urban public spaces.pdf 4a8cab2dea323557aee7447e3b1cd9a2

## Rules
- No universal UTCI/dBA/temperature filter, threshold search, majority-source proxy, category proportion or spectrum substitution.
- Missing required values and original physiological QC are retained as necessary exclusions; exposure level alone does not exclude a row.
- Recorded dBA is an energy aggregation of 10-s UCM medians, not a certified native LAeq. This measurement difference remains.
- Raw p applies the source decision rule; BH q is an additional correction, not falsely attributed to the original paper.
- One phase rating per participant/bout; repeated 10-s copies are never treated as independent votes.
- Jin retains physical 5-dB spacing and UTCI stress categories, extending the dBA range when necessary. Rank-aware Type-II F tests; empty cells reduce the interaction to its estimable part; no quartile fallback.
- Cureau: Fisher exact within phase. Wu: separate source objective/subjective additive predictor sets with participant intercept. Xu: source Pearson test within phase.
- No publication-level equivalence, causal sound effect or predictive validation is asserted.

## Source tests not reproduced (reason)
- Moshammer 2019: published preceding 15-min exposure/outcome periods cannot be recreated within an 8-min phase; the former 5+3-min split is removed.
- Biel 2020: published baseline-to-follow-up changes and 30-min exposures/random slopes are not reproduced by 8-min phase means or invented 2-min windows.
- Kraus 2013: published 5-min lagged outcomes/exposures through 15 min and HR adjustment are not reproduced by one interval per 8-min phase. Its 65-dBA knot was source-based, not an exclusion, but the truncated analogue is removed.
- Korpilo 2024: original PDF not located in Experiment papers; the former log-EDA/broad-band NDSI model is not independently source-verified.
- Pigliautile 2021: controlled-room sound/thermal conditions are not available; phase-majority classifier labels cannot replace assigned source conditions.
- Chiucchiu 2026: not selected for this source-method analysis (full text is available locally). Its paired tests compare assigned headphone soundscapes and room temperatures in a test room, with personality clusters; our field phases do not reproduce those conditions.
- Chen 2023: source section 2.7 uses repeated-measures ANOVA/sphericity corrections and ranked source type. The continuous LMM plus classifier natural share is not that test; exact factor specification and source-ranking data are unavailable.
- Qin 2024: source uses PET/TSV, humidity grades and 20-dB sound grades, not the continuous TC ~ sound*RH mixed model. Its Table 2 does not identify the correlation estimator in the inspected text; no guessed Pearson/Spearman test or interaction is substituted.
- Mohammadzadeh 2023: source acoustic outcomes are soundscape quality, reported loudness, overall impression and perceived natural-source proportion. Generic AC and UTCI do not replace those outcomes or PET.
- Gao 2025: source restoration outcome is ROS, not our perceived-restorativeness PRS-11. No PRS substitution or quartile ANOVA is fitted under the source name.
- Zhen 2025: source sections 3.3.1-3.3.4 use 1-degree UTCI means and source/vote strata with fitted curves. The former raw TC ~ UTCI*dBA LMM is not its published test; source-type/ASV strata are unavailable.
- Zhang 2026 Scientific Reports: source ordered logistic models use PET, aesthetic perception and stated covariates. A Gaussian AC*UTCI mixed model is not a reproduction.
- Zhang 2026 Building Simulation: source Spearman tests in section 3.2.1.1 concern TSV versus meteorological variables; our TC/AC/OC-versus-dBA tests were not established by that source and are removed.
- Song 2013/2014 and Jo 2019: environment/playback contrasts are not isolated measured-sound tests in our field design; no forest/urban sound treatment is invented.
- Ueberham 2019, Li 2025 and Jin 2020 chamber: required questionnaire items, arrival/departure measurements or assigned sound/temperature treatments are unavailable.

## Fit and support notes
Jin observed sound x UTCI category counts:
         
          [9,26) [26,32) [32,38)
  [55,60)      3       0       0
  [60,65)      5       3       0
  [65,70)      7       9       4
  [70,75)      2       4       2
  [75,80)      1       2       0
  [80,85]      1       1       0

## Not estimable (removed from the results CSV; no p value, so no q value)
- 3 planned tests returned no p value:
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | thermal_comfort | n=11 | not estimable
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | acoustic_comfort | n=11 | not estimable
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | visual_comfort | n=11 | not estimable

# H4 sound evidence: current tests and checked results

Updated 8 November 2026 after checking the current H4 script and its saved core, outdoor-subset and Tram outputs. This is the active guide. Superseded model descriptions, category/spectrum substitutions and their results have been removed from this document. Original PDFs and archived outputs remain available; they are not current H4 results.

## 1. Current scope and data

Script: [`H4_sound_literature_test.R`](../scripts/statistical_analysis/H4_sound_literature_test.R).
Input: [`merged_all_11participants_8min.csv`](../output/merged_all_11participants_8min.csv), MD5 `a3c4f9388b61def82e5b97b4232315be`.

| Run | Participants | Participant-phase ratings | Ten-second input rows | Result rows | Rows with q < .05 |
| --- | ---: | ---: | ---: | ---: | ---: |
| Core: BikeU, WalkU, BikeG, WalkG | 11 | 44 | 2,112 | 102 | 6 |
| `--additional-only`: Cureau, Wu, Xu on the same core data | 11 | 44 | 2,112 | 33 | 0 |
| `--include-tram`: four core phases plus Tram | 11 | 55 | 2,637 | 110 | 9 |

The outdoor-subset rows match the corresponding 33 core rows numerically. They are not additional evidence. The Tram run reuses the core observations and adds a passenger condition; it is a sensitivity analysis, not independent replication. Rodrigues always uses the same 22 walking trips, including in the Tram run.

Sound exposure is recorded `ucm_SND_dBA`. Phase levels are energy means of the available ten-second values. The input ten-second values were compiled as UCM medians; this does not establish equivalence to the original papers' native LAeq measurements. Core phase levels span 55.86–81.15 dB(A), and phase-mean UTCI spans 20.61–35.71 °C.

There is **no universal dBA, UTCI or air-temperature exclusion**, no search across thresholds, and no automatic replacement of dBA by corridor labels, classifier proportions or spectral measures. Missing required measurements and the original physiological quality-control flags still apply. Jin uses physical sound bands and UTCI stress categories, with the sound range extended to retain our louder observations.

### Questionnaire outcomes

| Outcome | Merged column | Interpretation |
| --- | --- | --- |
| Thermal comfort (TC) | `questionnaire_thermal_comfort_1_5` | Reported thermal comfort, not hot/cold sensation |
| Acoustic comfort (AC) | `questionnaire_acoustic_comfort_1_5` | Reported acoustic comfort, not loudness or measured dBA |
| Visual comfort | `questionnaire_visual_comfort_1_5` | Reported visual comfort |
| Overall comfort (OC) | `questionnaire_current_comfort_1_7` | Current overall comfort |

The five-point domain scale is: 1 extremely uncomfortable; 2 very uncomfortable; 3 non comfortable; 4 slightly non comfortable; 5 comfortable. It is not a bipolar scale with neutral at 3. Each rating occurs once per participant-phase and is repeated in the ten-second input rows. H4 uses one rating per bout, not 48 independent votes. Physiological outcomes remain bodily measurements; they are not renamed discomfort scores.

## 2. Tests retained from the original papers

These are feasible components of the published methods, with adaptations stated below. None reproduces an entire experiment. Original PDFs were read directly; the screened guide was not the sole evidence.

| Paper | Published component retained | Implementation with our data | Core tests: raw p < .05 / q < .05 |
| --- | --- | --- | ---: |
| Rodrigues 2026 | Separate thematic mixed regressions for trip-level physiology; standardized predictors and participant intercept | Walking only; noise maximum + noise SD, and separately maximum + mean air temperature; 15 available physiological summaries | 60: **9 / 6** |
| Jin 2020, outdoor squares | Two-way ANOVA: LAeq band × UTCI stress category on comfort | TC, AC and OC; physical 5-dB bands and UTCI categories; participant blocking for our repeated ratings | 9: **1 / 0** |
| Cureau 2022 | Fisher exact associations between comfort domains, separately by park | Six domain pairs within each phase; one response per person | 21 estimable: **2 / 0** |
| Wu 2025 | Separate additive regressions using objective conditions or subjective votes | `OC ~ UTCI + dBA` and `OC ~ TC + AC`, with participant intercept | 4: **1 / 0** |
| Xu 2026 | Pearson associations between environmental measurements and votes, Table 3 | dBA versus TC and AC within each phase, 11 independent people per correlation | 8: **0 / 0** |

### 2.1 Rodrigues 2026 — walking physiology

**Source:** Statistical Analysis and H2 thematic blocks, Journal of Urban Health, [original PDF](<../Experiment papers/H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf>), DOI `10.1007/s11524-025-01051-1`.

The source fits environmental predictors in separate thematic mixed models. Our noise model is:

`Physiological trip summary ~ standardized maximum dBA + standardized dBA SD + participant random intercept`

The separate temperature model replaces those predictors with standardized maximum and mean air temperature. There are 22 WalkU/WalkG trips from 11 people. Available outcomes are trip summaries of heart rate, RMSSD, LF/HF and wrist skin temperature. These are our eight-minute, Empatica-derived counterparts, not identical source instruments or recordings. The source-code decision rule combines raw p < .05 and |standardized-predictor coefficient| > 0.1; the exported BH q is additional.

**Current FDR results:** one noise association and five temperature associations, listed in §3. The noise model does not adjust for temperature, mode or other environmental blocks. It therefore does not establish an independent sound effect after thermal adjustment, nor a sound × heat interaction.

**Collinearity check:** across the 22 trips, maximum and SD of dBA have r = 0.482 and conventional two-predictor VIF = 1.30. Maximum and mean air temperature have r = 0.993 and VIF = 74.02. The latter is a severe collinearity warning: the temperature coefficients condition on nearly the same exposure summary and should not be interpreted as separate stable thermal effects. These VIFs describe the fixed predictor pairs; they are not a complete mixed-model diagnostic.

### 2.2 Jin 2020 — thermal/acoustic comfort ANOVA

**Source:** Tables 3–7 and sections 3.1–3.3, Building and Environment 168:106517, [original PDF](<../Experiment papers/H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf>), DOI `10.1016/j.buildenv.2019.106517`.

`Comfort rating ~ participant block + sound band × UTCI stress category`

The source used 5-dB sound bands over its observed 55–75 dBA range. Our bands continue the same spacing through 85 dBA, retaining all 44 core cells rather than excluding or clamping louder observations. UTCI categories retain physical stress boundaries; neither factor uses sample quartiles. Participant blocking and Type-II sums of squares are our adaptations; the source does not specify its SS type. Our rating scales also differ.

The core data occupy 13 of 18 combinations (six sound bands × three UTCI categories). The rank-aware tests use F(5,21) for sound, F(2,21) for UTCI and F(5,21) for the interaction. Only five of the nominal ten interaction degrees of freedom are estimable. The interaction is therefore a test of the estimable contrasts, not the complete factorial interaction.

**Core result:** no q < .05. Sound has p = .182 for TC, .588 for AC and .872 for OC. The sound × UTCI interaction has p = .804, .716 and .762, respectively. UTCI on AC has raw p = .0308 but q = .278.

**With Tram:** UTCI category passes for TC (q = .0271) and AC (q = .0408). Neither is a sound effect. Four of 18 combinations are empty; interaction rank is six, with 31 residual df.

### 2.3 Cureau 2022 — associations between comfort domains

**Source:** Data analysis, p. 2037, International Journal of Biometeorology 66:2033–2045, [original PDF](<../Experiment papers/Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf>), DOI `10.1007/s00484-022-02338-7`.

Fisher's exact test is applied to each pair of TC, AC, visual comfort and OC, separately by phase. This retains the source's test type; treating phase as the site analogue and using our rating scales are adaptations. Each table contains 11 participants.

Of 24 planned core tests, 21 are estimable. The three BikeG pairs involving visual comfort are unavailable because every visual rating is 5. No core or Tram association passes BH correction. This analysis concerns relationships between ratings; it does not test measured dBA.

### 2.4 Wu 2025 — objective conditions versus subjective comfort

**Source:** Section 4.4, summer equations 1 and 4, Energy and Buildings 347:116329, [original PDF](<../Experiment papers/Sound_evidence/Sound - Wu2025 - thermal acoustic overall comfort cold-region parks.pdf>), DOI `10.1016/j.enbuild.2025.116329`.

The two published predictor sets are kept separate:

- Objective: `OC ~ UTCI + dBA + participant random intercept`.
- Subjective: `OC ~ TC + AC + participant random intercept`.

The source uses ordinary multiple regression; adding a participant intercept accounts for our repeated phase ratings. Predictors remain in raw units. No 60-dBA split or extra interaction is fitted. Core models use 44 ratings from 11 people; Tram models use 55 ratings from the same 11 people. Walking and cycling are pooled without a mode term.

**Core objective model:** dBA coefficient −0.0192 OC points per dB, 95% CI [−0.0835, +0.0452], p = .548, q = .548. This does not support a measured-sound association with overall comfort in this model. It is not a direct test of TC as the outcome.

**Core subjective model:** AC coefficient +0.394 OC points per AC point, p = .0333, q = .0666. With Tram, AC is +0.412 [0.106, 0.718], p = .00945, q = .0189. That sensitivity result links perceived acoustic and overall comfort; it is not a measured-dBA effect or evidence that sound worsens thermal comfort.

### 2.5 Xu 2026 — sound–comfort correlations

**Source:** Section 4.1 / Table 3, Environment, Development and Sustainability, [original PDF](<../Experiment papers/Sound_evidence/Sound - Xu2026 - threshold thermal-acoustic urban public spaces.pdf>), DOI `10.1007/s10668-026-08213-4`.

Pearson r is computed between phase dBA and TC, and between phase dBA and AC. Each phase has 11 people. Phase stratification is our adaptation to avoid treating repeated ratings as independent participants; our five-point outcomes differ from the source seven-point scales. These are bivariate associations without thermal adjustment.

No core correlation has raw p < .05 or q < .05. The lowest core p is for WalkG acoustic comfort: r = −0.579, p = .0619, q = .496. No Tram-run correlation passes either threshold. The source's breakpoint estimation, machine-learning analyses and discovered temperature/sound thresholds are not reproduced by these Pearson tests.

## 3. What currently passes FDR

The six core rows below belong to Rodrigues. Coefficients are outcome units per one population SD of the stated trip-level predictor, conditional on the other predictor in that block.

| Block / predictor | Outcome | Coefficient [95% CI] | p | q |
| --- | --- | ---: | ---: | ---: |
| Noise / maximum dBA | Minimum wrist skin temperature, °C | +0.874 [0.580, 1.168] | 5.53e−9 | 8.30e−8 |
| Temperature / maximum air temperature | SD of wrist skin temperature, °C | +1.918 [1.088, 2.747] | 5.87e−6 | 4.40e−5 |
| Temperature / mean air temperature | SD of wrist skin temperature, °C | −1.978 [−2.802, −1.154] | 2.55e−6 | 3.82e−5 |
| Temperature / maximum air temperature | Maximum wrist skin temperature, °C | +8.119 [5.006, 11.231] | 3.17e−7 | 4.76e−6 |
| Temperature / mean air temperature | Maximum wrist skin temperature, °C | −6.183 [−9.286, −3.079] | 9.46e−5 | .000709 |
| Temperature / mean air temperature | SD of heart rate, bpm | −13.586 [−23.717, −3.454] | .00858 | .0429 |

The five temperature rows carry the severe collinearity limitation in §2.1; significance does not resolve it. The maximum-dBA row is an active source-model result, not stale material, and is retained with its correct meaning. A wrist-temperature association is not a thermal-comfort vote or proof of physiological harm.

The nine Tram-run FDR rows consist of these same six walking rows plus two Jin UTCI effects and one Wu perceived-AC coefficient. Do not add core and Tram counts as independent discoveries. **No current core or Tram result establishes that measured sound makes thermal comfort worse.** Lack of significance also does not establish that the association is absent.

### How p and q are used

`p_value` is the unadjusted test p-value. `q_value` is the additional Benjamini–Hochberg adjusted p-value within **paper × named analysis block**; `FDR_significant` is TRUE exactly when q < .05. These are not corrections across the entire H4 catalogue. For example, each Rodrigues predictor has a family of 15 outcomes, Jin has nine tests, each Wu model has two coefficients and Xu has eight core correlations. The original papers' raw-p decision rules are recorded separately. A q-value is not the probability that a particular result is false.

## 4. Papers no longer fitted

These remain literature sources, not current result blocks. No replacement test is fitted merely to retain their paper labels.

| Paper(s) | Reason the former H4 block is not retained |
| --- | --- |
| Moshammer 2019 | Source preceding 15-min periods cannot be reproduced by a 5+3-min split inside an eight-minute phase. |
| Biel 2020 | Source baseline changes, 30-min windows and repeated-model specification are not reproduced by the former phase/2-min substitutes. |
| Kraus 2013 | The one-interval adaptation omitted the source lag structure through 15 min and other adjustments. Its 65-dBA knot was source-based, not a universal exclusion. |
| Korpilo 2024 | Original PDF not located during source verification; the former log-EDA / broad-band NDSI proxy model was not independently verified. |
| Pigliautile 2021; Chiucchiù 2026 | Assigned test-room/headphone conditions are not our field-phase labels. Chiucchiù full text is available locally; its omission is a design issue, not a missing-PDF claim. |
| Chen 2023 | Published repeated-measures ANOVA and source-ranking information are not the former continuous LMM with classifier natural share. |
| Qin 2024 | Published PET/TSV and physical humidity/sound-grade analyses do not justify the former continuous sound × RH LMM. A Table 2 correlation estimator was not identified in the inspected text. |
| Mohammadzadeh 2023 | Source soundscape quality, perceived loudness and related acoustic outcomes are not interchangeable with our generic acoustic-comfort score. |
| Gao 2025 | ROS restorative outcomes are not our PRS-11 perceived-restorativeness scores. The former substitution and quartile models are removed. |
| Zhen 2025 | Source binned curves and sound/vote strata are not the former continuous TC ~ UTCI × dBA mixed model. |
| Zhang 2026, Scientific Reports | Source ordered-logistic specification and required measures are not the former Gaussian AC × UTCI model. |
| Zhang 2026, Building Simulation | Source TSV–meteorology Spearman tests do not establish the former TC/AC/OC–dBA test set. |
| Song 2013/2014; Jo 2019 | Green/urban field differences cannot be labelled isolated sound-treatment effects. |
| Ueberham 2019; Li 2025; Jin 2020 chamber | Required questionnaire timing/items or assigned exposure conditions are unavailable for the proposed replication. |

Category-conditioned dBA, classifier source substitutions and spectral substitutions are not part of the current H4 tests. Their earlier results are not carried into the current evidence summary. Figure13_C and the Updated2 branch have been removed; original sound measurements and retained source PDFs remain.

## 5. Output locations and verification

Each active run folder contains three files: `H4_sound_literature_tests.csv`, `SUMMARY_sound_tests_p_and_FDR.csv` and `METHODS_NOTES.md`.

- [Core results](../output/statistical_analysis/results/H4_sound_literature_test/H4_sound_literature_tests.csv).
- [Outdoor subset](../output/statistical_analysis/results/H4_sound_literature_test_outdoor/H4_sound_literature_tests.csv).
- [Tram sensitivity](../output/statistical_analysis/results/H4_sound_literature_test_tram/H4_sound_literature_tests.csv).

Checks performed for this update:

- Code/input MD5 fingerprints match all three runs; all p/q fields are finite and the result identifiers have no duplicates.
- BH q-values independently recalculated for every family: maximum absolute difference 2.0e−15; every FDR flag agrees.
- Core and Tram Jin F-statistics/p-values recomputed using separate nested `lm()` fits: maximum absolute difference 4.9e−15. This checks numerical computation, not equivalence of incomplete-cell hypotheses to a complete source design.
- Every estimable core/Tram Cureau Fisher p-value and every Xu correlation/p-value recomputed from the merged data and matched.
- All core/Tram Rodrigues coefficients and SEs recomputed from independently rebuilt trip summaries (maximum difference 1.1e−9); all Wu coefficients and p-values matched within 1e−6.
- All 33 outdoor-subset rows match their core counterparts for estimates, uncertainty, p, q, sample counts and test statistics.

The audit did not replace result files or rerun the official H4 entry script. The screened MD is updated to describe the user's saved runs. Remaining scientific limitations are the repeated/observational design, 11 people, source-measurement differences, pooled activity modes in Jin/Wu, incomplete Jin factorial support and Rodrigues temperature collinearity.

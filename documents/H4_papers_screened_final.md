# H4 literature screening and analysis guide

This guide records source methods, the adaptations actually fitted to Paper 3 and their limitations. It is a method-provenance catalogue, not a score of how many papers support H4.

## 0. Scientific interpretation and reporting

### 0.1 Question and scope

H4 asks whether noise and traffic amplify thermal discomfort. An additive sound coefficient, a sound–acoustic-comfort correlation, a comfort-domain association and a warm–cool comparison do not all test that hypothesis. Amplification as effect modification requires an identifiable thermal–acoustic interaction or another explicitly justified estimand. The selected reporting rows do not collectively establish such an interaction.

The catalogue covers **fourteen** source entries in §3.1–§3.14: Christos Grapas (Brussels), Anna Laura / Pisello network, other European field studies, and documented non-European ports (Jin, Biel; Song not fitted). Geographic scope is a literature-organising choice, not a criterion of statistical validity. Excluded non-European studies remain documented in `_archive/H4_papers_screened_non_europe_removed_20261109.md`; their exclusion does not strengthen the evidence from retained studies.

### 0.2 Historical output names and analysis roles

| Output | What it contains | How to use it |
| --- | --- | --- |
| `H4_sound_literature_tests.csv` | Full current catalogue of §3.1–§3.11 adapted analyses | **Primary reporting surface.** Group by `paper` / screened-guide §3 block; apply each source’s `paper_rule`. Not independent replications across labels. |
| `SUMMARY_sound_tests_paper_rule.csv` | Nominal rule indicators grouped by source label | Bookkeeping only; not a count of independent H4 confirmations. |
| `METHODS_NOTES.md` | Generated execution and adaptation notes | Check against code and this guide. Historical “primary”, “pre-specified” and “source rule” labels do not establish registration or source fidelity. |

All paths above are under `../output/statistical_analysis/results/H4_sound_literature_test/`.

### 0.3 Verified overlap and selected results

All eleven participants have a higher phase-mean air temperature on WalkU than on WalkG. The runner’s warm–cool labels use **`H4_AL$bout_frame`**: each walk bout is **cooler** or **warmer** than that person’s **mean** phase air temperature (not a sample-wide median). With only two walks per person, that split coincides with WalkG vs WalkU in the current file. The thermal paired estimate is −1.0909 points (95% CI −1.8542 to −0.3276; nominal p = 0.009745) under IBPC and Chiucchiù warm–cool ports (one test). Report this result once. It does not independently identify a thermal effect or an acoustic effect.

| Selected analysis | Verified output | Interpretation |
| --- | --- | --- |
| IBPC / Chiucchiù warm–cool thermal comparison | Identical paired difference and p-value | One urban–green walking comparison, motivated by two sources. |
| Cureau thermal versus acoustic comfort within WalkU | Fisher p = 0.060606; 11 people | Rating-domain association; neither measured sound nor heat enters the test. |
| Grapas-inspired pooled dBA versus acoustic comfort | r = −0.47947; ordinary p = 0.02395 | Descriptive only: ordinary Pearson inference treats 22 repeated bouts as independent. Participant-aware inference is required before an inferential claim. |
| Moshammer-inspired acoustic-comfort model | dBA coefficient −0.14695; nominal p = 0.08110, with UTCI and participant intercept | New comfort-outcome adaptation; the source physiological model is not replicated by changing its outcome to comfort. |
| Rodrigues-inspired acoustic-comfort noise block | Maximum-noise coefficient −0.60832 per SD; nominal p = 0.009557 | Does not adjust for thermal exposure and does not test interaction. |

Do not replace an old headline row count with another success fraction. The manuscript highlight rows still reuse the same participants, differ in question and include descriptive analyses.

### 0.4 Source rules, multiplicity and timing

The selected H4 rows currently contain nominal p-values, with no BH q-values. State that explicitly. The manuscript's BH statement applies to its specified H1–H3/H5 families, not automatically to H4. Reproducing a source's unadjusted threshold does not justify the choice or multiplicity of new outcomes and analyses in this dataset.

The IBPC poster and Pigliautile descriptive comparisons do not supply a formal p < 0.05 test to replicate: paired t-tests are analysis-added. The Grapas-inspired row explicitly uses an exploratory unadjusted edge criterion whereas the source network uses FDR; these procedures are not interchangeable. Where a source does report an inferential rule, distinguish that rule from our adapted outcome, sample and exposure definition.

The reporting subset was assembled after earlier analyses of these data. Do not call it “pre-specified”, “registered” or confirmatory without a dated plan established before inspecting the relevant results. Preserve the full analysis history and catalogue. A nominal result can be reported as an association with its limitations; a significance tally is not a test of the composite H4 hypothesis.

### 0.5 Current robustness coverage

The saved November 7 robustness run predates this redesigned walking-only H4 catalogue. Its stored fingerprints no longer match `H4_sound_literature_test.R` or `library/H4_sound_literature_helpers.R`. Do not cite that run as validation of the current H4 reporting rows. It remains evidence for the versions and hypotheses it actually fitted; current H4 inference requires version-matched participant-level checks.

### 0.6 Screening and source adaptation

The recorded search used Scopus title/abstract/keywords `therm* AND outdoor AND sound*` (209 documents; export `../scripts/_scopus_export_text.txt`). This guide documents selected method precedents rather than claiming a systematic, exhaustive review. Source-specific §3 entries retain the study, sensors, sample, original statistical procedure, our data mapping and unmatched components. A source containing sound and temperature does not by itself validate a different comfort-outcome regression.

Outdoor field methods and indoor headphone experiments are distinguished throughout. Thermal sensation, thermal comfort, acoustic comfort and perceived loudness are different constructs. Label substitutions as adaptations, not identical scales or experiments. A publication in a different setting can motivate a statistical family without validating a causal interpretation in our observational field design.

### 0.7 Data lattice and code references

There are 11 participants and four core phases (44 participant–phase cells), each with 48 ten-second epoch starts over an eight-minute window. Walking-only ports use 22 cells from 11 people; phase-specific Fisher tables contain at most 11 independent responses. No analysis may treat the 1,056 walking epochs as 1,056 questionnaire responses. Optional tram outputs are separate from the core comparisons.

The canonical input is `../output/merged_all_11participants_8min.csv`; the current runner is `../scripts/statistical_analysis/H4_sound_literature_test.R`, with helpers in its `library/` directory. Source-specific procedures are the helper blocks documented in §3. The `H4_PRIMARY$mask` function tags §0.3 manuscript highlight rows in generated `METHODS_NOTES.md` only (not a separate CSV). There is **no** standalone Paper 3 WalkU−WalkG export in the runner.

### 0.8 Reporting checklist

1. Preserve the original H4 question and state what each fitted model actually estimates.
2. Report the IBPC/Chiucchiù warm–cool port once (identical estimate in this cohort); state urban–green co-exposure confounding — do not add a separate “route contrast” table.
3. Keep pooled Pearson r descriptive until repeated-participant inference is supplied.
4. Label H4 p-values nominal and unadjusted; distinguish source-reported and analysis-added procedures.
5. Retain null, non-estimable and alternative analyses in the audit; do not select a primary family from significance.
6. Do not claim the old robustness run validates the redesigned H4 catalogue.

## 1. Data available to H4

| Available analysis data | Four active phases | With Tram |
| --- | ---: | ---: |
| Independent participants | 11 | 11 |
| Participant × phase cells (bouts) | 44 | 55 |
| Ten-second rows in those phases | 2,112 (48 per bout) | 2,637 |
| Rows with finite `ucm_SND_dBA` and `ucm_UTCI` | 2,112 | 2,629 |
| Rows with finite YAMNet class and spectral columns | 2,111 | 2,634 |
| Cells with each of thermal, acoustic and overall-comfort ratings | 44 | 55 |
| People with both green (WalkG, BikeG) and urban (WalkU, BikeU) corridors | **11** | **11** |
| People with both YAMNet vehicle>rural nature and traffic phase labels | **9** | **10** |
| Sound representations considered (estimability varies by method) | four (dBA, corridor, vehicle vs rural_natural, 8 class proportions) | same four |

**Where 2,112 versus 2,111 comes from.** The four core phases contain exactly 44 bouts × 48 ten-second rows = 2,112 rows. Sound level, UTCI, air temperature, RH, heart rate, skin temperature and the listed comfort/PRS scores are finite on all 2,112 rows. One ten-second row (P13, BikeG, 2025-08-13 14:22:40) has no YAMNet class proportions and no spectral descriptors, so those columns have 2,111 finite rows. That bout's phase-mean proportions use its other 47 rows. Physiological 10-s columns have their own coverage: SDNN 1,782, RMSSD 1,945, 5-min LF 1,334 and tonic EDA 1,843 of 2,112 rows.

Sound and temperature vary: the core phase-energy-mean dBA ranges from **55.86 to 81.15 dB(A)** and phase-mean UTCI from **20.61 to 35.71 °C**. Phase-mean air temperature ranges from 21.42 to 32.08 °C. Individual physiological models have their own missingness and sample counts (given per paper in §3).

### 1.1 Four sound representations, where supported by the method

H4 does **not** use only a majority cut. The four representations are attempted in the compatible measured-sound blocks, using the same 10 s / 8-min data. Some fits are not estimable; vote-to-vote, thermal-only and site-specific blocks do not use every representation. Corridor represents environmental context, not an isolated sound exposure. **Each encoding is a separate predictor and a separate adapted hypothesis, not an exact replication of the source exposure.** Report these analyses separately.

| Encoding | What it is | Scale |
| --- | --- | --- |
| 1. Recorded A-weighted sound level | `ucm_SND_dBA`, energy-aggregated within the analysis window; native LAeq/calibration provenance remains unverified (the 10-s value is a median of the UCM samples) | continuous dB(A) |
| 2. Corridor / phaseavg | WalkG and BikeG vs WalkU and BikeU | binary; 11 of 11 people have both |
| 3. YAMNet vehicle vs rural_natural | per 10-s row, traffic if `vehicle_proportion` > `rural_natural_proportion` (744 of 2,111 core rows); at phase level this becomes the **share** of traffic rows (27 distinct values, 0–0.83) or, in Pigliautile/Chiucchiù, a phase label | two-minority head-to-head, **not** 8-class majority. Urban/man-made positive wins ~63% of 10 s rows; vehicle wins ~6.5%. Do not use “all other classes” as the base (0 walking phases would be traffic). Label occupancy: 9 of 11 people have both phase labels (P10 all traffic, P16 all nature); 10 of 11 with Tram |
| 4. YAMNet class proportions | each of eight category columns, phase or window mean | continuous 0–1: `wind_proportion`, `rural_natural_proportion`, `vehicle_proportion`, `urban_manmade_neutral_proportion`, `urban_manmade_positive_proportion`, `urban_manmade_negative_proportion`, `mechanisms_proportion`, `unidentify_proportion` |

Papers and how the four encodings enter (details and data per paper in §3):

- **Moshammer, Kraus, Rodrigues:** substitute the representation for sound level in the explicitly adapted source-inspired model. For Rodrigues, within-trip corridor SD is zero, making the joint max+SD model singular; the max still varies between trips. The Kraus two-segment corridor fit is also singular.
- **Korpilo:** source run keeps the NDSI analogue; the same LMM is also fitted with each other encoding in place of NDSI (corridor is aliased with PhaseID and not estimable).
- **Pigliautile:** paired traffic-minus-nature person means for encodings 2–3, and thermal-stratum person-mean Spearman for encodings 1 and 4. Full-session vote–sound Spearman is fitted once under Chiucchiù, not repeated under a second family.
- **Chiucchiù:** paired physiological warmer/cooler means; Table 5 analogue for encodings 2–3; full-session person-mean Spearman of thermal/pleasantness/acoustic votes against encodings 1 and 4. Where the source uses **TSV**, the runner uses **`questionnaire_thermal_comfort_1_5`** (§2).
- **Cureau / Grapas:** Fisher vote–vote (Cureau) and phase-mean Pearson webs (Grapas); no encoding sweep on vote–vote blocks.
- **Ueberham:** Spearman within each cycling phase only (**BikeG / BikeU**); encodings 2–4 not duplicated for bike-only source.

Fifteen spectral descriptors are an extra substitution on **Moshammer, Rodrigues, Kraus,** and **Korpilo** only. They are not one of the four encodings.

Walking is the more stable loudness pair (energy-mean **64.4 dB(A)** WalkG vs **69.4** WalkU). Cycling is louder and more variable (**65.8** BikeG vs **76.3** BikeU). **dBA label trap:** those §1 walk/cycle numbers pool **all 10-s rows** within each `PhaseID`; many §3 walk-only tables (**61.7 / 67.6**) are **means of 11 bout energy-means** (one value per person×phase)—same column, different aggregation, not a pipeline bug. Encoding 3 seconds: of 2,111 core 10 s rows, WalkG is 28% vehicle>rural, BikeG 25%, BikeU 54%, WalkU **34% vehicle / 66% nature**. The previously cited native 1-s output path is absent; see **§6** (measurement provenance).

### 1.2 What the YAMNet proportion columns are, and their mapping limitation

The proportion columns were produced by an external YAMNet batch notebook (path varies by machine; not versioned in this repo). They are merged into `output/merged_all_11participants_8min.csv` for H4. A proportion is the **share of YAMNet frames** (about 20 per 10-s window) in which any class mapped to that category scores ≥ 0.20. Categories overlap, so the eight columns can sum to more than 1; `unidentify` is the share of frames with no category. These are thresholded frame-detection prevalences, not exact sound durations, energy shares, calibrated levels or classifier confidence. Peak normalisation removes the absolute amplitude reference; the proportions cannot recover calibrated sound level, although they may correlate with recorded dBA.

**Known category-mapping errors:** categories are assigned by case-insensitive substring matching. 42 YAMNet classes fall into more than one category. Examples: "Train" also counts as Rural/Natural ("rain" is inside "train"); "Crowd" counts as Rural/Natural ("crow"); "Rain", "Water", "Fire" and some music classes count as Vehicle; the generic "Noise" class and "Owl" count as Wind; "Traffic noise, roadway noise" is in Urban negative but **not** in Vehicle; and the generic "Vehicle" class is in both Vehicle and Urban negative. This limitation applies to every analysis below that uses encodings 3 or 4. **The proportion columns have not been regenerated with a corrected mapping**, so current results use the mapping as described. These known semantic mapping errors prevent interpreting the exported labels as validated natural/vehicle exposure. Until correction and regeneration, report associations with the exported labels only; source-specific design recommendations are not supported by them.

### 1.3 Units of independent information, and what "sparse" means here

- **Comfort, pleasantness, visual-comfort and PRS ratings were asked once per phase.** Every 10-s row in a bout repeats the same rating (at most one distinct value per bout). The 2,112 ten-second rows therefore give **44 phase ratings from 11 people**, not 2,112 ratings. Every comfort-outcome model below uses **44 phase cells** when item 6 includes all four phases, **22 walk cells** when item 6 is WalkG+WalkU only, or **11 participant means** when the helper collapses paired walks (`H4_AL$spearman_row`, vote–vote Spearman)—never 10-s rows as fake *n*.
- **§1 vs §3 counts:** tables and bullets above that say **44** describe the **full four-phase merged file**. Walk-only method ports (most §3 blocks) use **22** questionnaire cells unless stated otherwise; do not read §1.3 “44 cells” as the *n* for Pigliautile, Moshammer, etc.
- Physiological outcomes vary within a bout, so some physiology blocks use sub-bout windows (Kraus 5-min interval, Moshammer 5-min/3-min split). These windows are serially correlated repeated observations, not new people.
- Tram adds another repeated condition, not new participants. These observations permit model fitting. They do not turn 11 people into 44 or 55 independent people. The headphone experiments cannot be reconstructed, because temperature and route travel together. Short recordings also prevent several source lag/window analyses. Statistical significance is not a data-sufficiency certificate.
- **Continuous predictors versus thresholds.** A continuous predictor uses all 44 cells when it varies within people. Across the 44 core cells, the share of predictor variance that lies within persons is 0.89 for dBA, 0.81 for the vehicle-vs-rural share and 0.57–0.91 for the eight class proportions. Median splits of encodings 2–4 give about 22/22 cells, with 9–11 people having both levels. A fixed published threshold can instead leave almost no data on one side. **"Sparse" in this guide is not a universal minimum.** It means that a specific contrast is supported by so few cells or people (for example 0–3) that the coefficient is unidentifiable or rests on one or two people.
- **Walking-only thermal–corridor overlap.** Warm–cool uses each person’s **mean** walk air temperature (`H4_AL$bout_frame`). Each participant has one cooler and one warmer walk; in the current input, cooler = WalkG and warmer = WalkU for all 11. Do not apply a separate four-phase thermal split to these 22 cells. Within-stratum traffic–nature comparisons can remain sparse or unidentifiable; a chamber factorial design is not reproduced.

### 1.4 Inference and results reporting

The catalogue and paper-rule summary are defined in §0.2. No output file establishes H4 support by a MET tally. Report the coefficient or contrast, its scale, sample size, uncertainty where available, and whether the p-value is nominal or adjusted. State participant clustering and the distinction between source-reported and analysis-added procedures.

The current H4 exports may retain empty `q_value` and `FDR_significant` schema fields; these do not mean that BH was applied. Nominal `paper_rule_met` flags are bookkeeping and are not FDR findings. A descriptive source has no formal significance rule to copy. Existing `METHODS_NOTES.md` is generated from the script and can still contain historical labels that this guide corrects.

Outputs: [catalogue](../output/statistical_analysis/results/H4_sound_literature_test/H4_sound_literature_tests.csv), [paper-rule summary](../output/statistical_analysis/results/H4_sound_literature_test/SUMMARY_sound_tests_paper_rule.csv), [run notes](../output/statistical_analysis/results/H4_sound_literature_test/METHODS_NOTES.md). The older November 7 robustness checks do not cover the current H4 version (§0.5).

## 2. Questionnaire and indices used in H4

Scored from `Recurring questionnaire.csv` via `05_questionnaire_build.py` → merged `questionnaire_*` columns (one rating per phase, repeated on 10 s rows).

| What we collected | Question (short) | Merged column | Scale |
| --- | --- | --- | --- |
| Thermal comfort | Please describe your comfort **[Thermal]** | `questionnaire_thermal_comfort_1_5` | 1–5, higher = more comfortable |
| Acoustic comfort | … **[Acoustic (Urban Noise)]** | `questionnaire_acoustic_comfort_1_5` | 1–5 |
| Visual / air / odour | … **[Visual / Air / Odors]** | `questionnaire_visual_comfort_1_5`, etc. | 1–5 |
| Overall comfort | How comfortable do you feel right now? | `questionnaire_current_comfort_1_7` | 1–7 |

Thermal row anchors: Extremely uncomfortable → … → Comfortable (`COMFORT_MAP_5`).

### 2.1 Mapping source paper constructs → our columns

| When the source paper uses… | H4 column | Rule |
| --- | --- | --- |
| **TCV** (thermal comfort vote) | `questionnaire_thermal_comfort_1_5` | Same test family as the paper on this column |
| **TSV** (thermal sensation in tables) | **`questionnaire_thermal_comfort_1_5`** | **Adaptation:** same test as the source; outcome is domain thermal comfort (subjective thermal response). Do not rescale or label results as TSV. |
| **ACV** | `questionnaire_acoustic_comfort_1_5` | Direct |
| **OCV** (overall comfort) | `questionnaire_current_comfort_1_7` | When the source outcome is overall / 7-point comfort |
| **PET** | **`ucm_PET`** phase mean | When the source used PET |
| **UTCI** | **`ucm_UTCI`** phase mean | When the source used UTCI |

**Index rule:** PDF says PET → `ucm_PET`; PDF says UTCI → `ucm_UTCI`. Both are finite on all **44** core phase cells.

Optional monotone rescores (sensitivity; ranks unchanged): `comfort_5_centered = 2 × (thermal_comfort_1_5 − 3)`; `comfort_7_centered = current_comfort_1_7 − 4`. Constants: `H4_QUESTIONNAIRE` in `Paper3_common.R`.

Models use **raw scores** unless item **9** names a rescore. **Audit:** 55 thermal + 55 acoustic + 55 overall phase ratings checked against raw export and build script.

## 3. Paper by paper (numbered story)

### 3.0 Quick audit — what each block measures (for thesis Tables / Appendix)

| § | Source (short) | Source design (timing) | Our outcome focus | Comfort votes in port? |
| ---: | --- | --- | --- | ---: |
| **3.1** | Grapas 2026 (Christos) | Brussels walks; wearable multimodal | SOR-style **Pearson** exposure→vote web | Votes + physio (supplementary catalogue) |
| **3.2** | Pigliautile 2021 | Chamber; votes after each playback / temp step | Votes + warm−cool / traffic−nature analogues | Yes (1×/phase) |
| **3.3** | IBPC 2018 poster | Chamber NEXT.ROOM (poster) | Thermal × soundscape perception (descriptive) | Yes (chamber analogue) |
| **3.4** | Chiucchiù 2026 | Chamber; physiology + votes | Physiology warm−cool + vote Spearman | Yes |
| **3.5** | Cureau 2022 | ~55 min park walk; votes at end | Vote–vote associations by walk phase | Yes — **Methods anchor #5** |
| **3.6** | Cureau FA 2023 | Outdoor comfort walk (Perugia) | Lineage only (Fisher in §3.5) | Citation only |
| **3.7** | Moshammer 2019 | 1 h outdoor road vs park | HRV + additive comfort on walks | Comfort + **physio** |
| **3.8** | Rodrigues 2026 | Trip-level walking panel | Noise / temp blocks | Comfort + **physio** |
| **3.9** | Kraus 2013 | 24–48 h personal noise | Piecewise dBA on HR/HRV | **Physio only** |
| **3.10** | Korpilo 2024 | Park/beach visits | EDA on soundscape index | **Physio only** |
| **3.11** | Ueberham 2019 | Cycling routes | Sound–thermal on cycling | Bike phases (Spearman) |
| **3.12** | Jin 2020 | Harbin urban squares; stand/sit | LAeq band × UTCI ANOVA (comfort) | Yes (legacy pipeline) |
| **3.13** | Biel 2020 | Toronto free-living panel | Noise + Ta LMM on HRV | **Physio only** (legacy) |
| **3.14** | Song 2013/2014 | Japan park vs city walks | Park vs city HR/HRV (no sound×thermal model) | **No** (not fitted) |

*(Pisello **material-acoustics** PDFs — lab impedance / transmission loss — are documented **outside §3**; no human walk port.)*

*(Item 7 counts audited from `output/merged_all_11participants_8min.csv` core phases WalkG, WalkU, BikeG, BikeU — run `python scripts/h4_sample_size_audit.py` to refresh.)*

Default file: `output/merged_all_11participants_8min.csv`; 11 participants (P4, P8–P17); four scheduled phases exist (BikeU, WalkU, BikeG, WalkG), but **item 6** per paper restricts which phases enter each method port (**WalkG/WalkU** for walk-only sources; **BikeU/BikeG** for §3.11 only; **all four** for Kraus mixed-mobility). Each bout has **48 ten-second rows** (full series available where window logic needs them).

Each subsection: **1** citation (local PDF at end of item 1) → **11** what cannot be matched (item **3** = **Study area:** city/region, country, continent). **Order:** **§3.1** Christos **Grapas** (Brussels); **§3.2–§3.6** Anna Laura / Pisello network (NEXT.ROOM + Perugia walks); **§3.7–§3.11** other **European** field ports; **§3.12–§3.14** **outside Europe** (Jin, Biel, Song). `---` separates papers. **Setting:** **indoor chamber:** §3.2–§3.4; **outdoor field or mixed mobility:** §3.1, §3.5–§3.14. Our measured data are **outdoor walk/cycle bouts**; chamber playbacks are not reproduced.

### 3.1 Grapas et al. 2026 — outdoor Brussels walks (multimodal SOR)

1. **Citation.** Grapas C, Llaguno-Munitxa M, **Pisello AL**, Irajpour A. Urban chronotypes as climate vulnerability indicators: Safety-modulated bioclimatic responses and adaptive behavior across diurnal urban contexts. *Urban Climate* 2026;67:102906. Local PDF: [Grapas et al. 2026](../Experiment papers/Urban Climate Literature/Sound - Grapas et al 2026 - Urban chronotypes climate vulnerability safety-modulated bioclimatic responses.pdf).
2. **Objective.** Ambulatory **stimulus–organism–response** networks linking **acoustic, thermal, visual, air-quality** exposures to physiology and behavior on **Brussels walks** (safety × day/night).
3. **Study area.** **Brussels, Belgium** (**Europe**) — **outdoor** urban walking routes (wearable multimodal campaign; day/night × safety strata in source).
4. **Instruments and sensors (source study).** Wearable **sound (dBA)**, **UTCI / thermal**, visual exposure, air quality, Empatica physiology, eye-tracking; GPS behaviour.
5. **Data they collected (type, timing, resolution, sample).** *n* = 18 participants, 36 walk sessions; synchronized time series and session summaries.
6. **Statistical test in the source paper.** **Bootstrap pathway strength**, **Granger-style latency**, mixed-effects on **response delays** — **not** comfort-vote × UTCI × LAeq ANOVA/LMM.
7. **Mode/Environment.** **Source:** **outdoor walk** in Brussels (day/night × high/low safety). **Our phases:** **WalkG + WalkU** as green vs urban walk bouts (**8 min**).
8. **Sample size (for test).** **11** people × 2 walk phases = **22** cells for phase-mean SOR analogue; full latency models **not** estimable on one vote per bout.
9. **Our data for method port.** Phase-mean **dBA, UTCI**, domain comfort votes, **HR / EDA** on **WalkG + WalkU**. The runner exports **Pearson edges** from that web only (`H4_EUROPE_PORTS$grapas_pearson`); bootstrap pathways and Granger machinery are **not** ported. This block is descriptive catalogue analysis, not a causal network claim.
10. **Our statistical test (closest family).** **Pearson** (or Spearman) **participant × phase mean** web among exposures, biomarkers, votes — **descriptive catalogue analysis** (`paper_rule`: analysis-added exploratory p; not the source FDR procedure); **no** pathway bootstrap port.
11. **What cannot be matched.** Safety × chronotype factorial, Granger lags, 36-session design, eye-tracking graphs, full *n* = 18 Brussels cohort.
---

### 3.2 Pigliautile 2021 — indoor NEXT.ROOM / headphones

1. **Citation.** Pigliautile I, Fusaro G, Kang J, Chang WS, **Pisello AL**. Environmental thermal influence over soundscape perception (NEXT.ROOM). *J. Phys.: Conf. Ser.* 2021;2042:012136. Local PDF: [Pigliautile et al. 2021](../Experiment papers/Sound_evidence/Sound - Environmental thermal influence over soundscape perception - a test room experimental campaign involving the psychological and physiological.pdf).
2. **Objective.** Cross-modal effect of warming the room on soundscape evaluation (pp. 1–2).
3. **Study area.** **Perugia, Umbria, Italy** (**Europe**) — indoor **NEXT.ROOM** test chamber (UCLab / University of Perugia network).
4. **Instruments and sensors (source study).** Sony WH-1000XM4; seven fixed playbacks; room Ta ±0.2 °C at 1.10 m; 10dB SOLO background grid (pp. 2–3). No physiology in text checked.
5. **Data they collected (type, timing, resolution, sample).** *n* = 40; C0 **21 °C** then C1 **~23 °C**; 5-point thermal/visual/acoustic/air-quality votes; identical thermal order for all.
6. **Statistical test in the source paper.** The paper reports **descriptive mean comparisons** of thermal, visual, acoustic and air-quality votes between **C0 (21 °C)** and **C1 (~23 °C)** and between **assigned soundscape playbacks** (e.g. woodland vs busy street); Figures 3a–3b. No formal inferential model is reported in the conference text we checked.
7. **Mode/Environment.** **Source:** seated **indoor NEXT.ROOM**; no locomotion—**headphone soundscape playbacks** (e.g. woodland vs busy street) at **C0 21 °C / C1 ~23 °C**. **Our phases:** thermal strata on **WalkG + WalkU** only (**no BikeG/BikeU**—source did not walk or cycle). **WalkG** ≈ greener / nature-associated soundscape; **WalkU** ≈ urban traffic context. **Ten-second data:** all **48 rows × 11 participants** per included walk phase (up to **1,056** rows on WalkG+WalkU).

8. **Sample size (for test).** **WalkG 11 + WalkU 11 = 22** questionnaire cells (§1.3 **44** = full four-phase file only). **Within-person paired walks:** **11/11** people with both phases. **Cooler vs warmer** (`H4_AL`: bout air temp vs that person’s **mean** on walks): **11 cooler / 11 warmer** labels (coincides with WalkG/WalkU here). **10 s rows:** **1056** on WalkG∪WalkU. **Flag:** Fig. 3b **within-stratum** traffic vs nature often **not estimable**; Spearman in a thermal half uses **≤11 participant means**; source **n=40** chamber.

9. **Our data for method port.** Input: `output/merged_all_11participants_8min.csv` → **WalkG + WalkU** cells (item 6) via `H4_AL$bout_frame()`. **Thermal analogue:** **cooler vs warmer** vs each person’s **mean** phase `ucm_AIR_temp` on their walks (C0/C1 substitute). **Sound analogue:** **traffic vs nature** from YAMNet vehicle vs rural_natural **share**, optional **corridor** label (WalkG/WalkU), plus continuous `ucm_SND_dBA` and class proportions. Outcomes: thermal, visual, acoustic, air-quality comfort, pleasantness (§2 columns).
10. **Our statistical test (closest family).** (`H4_PIGLIAUTILE` in `H4_sound_literature_helpers.R`.) **(a)** Paired *t*-test on **person means**: warmer minus cooler for **thermal, visual, acoustic, air-quality** votes (Fig. 3a analogue; air-quality is our item, not a source ISO scale). **(b)** Paired *t* on person means **traffic minus nature** for pleasantness and acoustic comfort, **overall** (11 pairs when both walks exist). **Within each thermal stratum**, the same traffic-vs-nature paired *t* (Fig. 3b) is usually **not estimable** on walk-only data (corridor and YAMNet labels align with temperature—often **≤2** people with both labels in one half); those rows are **dropped from the CSV** and listed under **not estimable** in `METHODS_NOTES.md`—that is data geometry, not a code bug. **(c)** **Spearman** ρ (vote vs continuous sound) **within** cooler and within warmer strata; `H4_AL$spearman_row` uses **participant means inside the stratum** (at most **n = 11**), not 22 pooled phase rows. Any inferential threshold here is analysis-added; descriptive source differences do not supply a formal test.
11. **What cannot be matched.** No test room, no Sony headphone playbacks, no fixed +2 °C step for everyone, no 10 dB SOLO grid, no eight ISO soundscape descriptor scales.
---

### 3.3 IBPC 2018 — NEXT.ROOM thermal × soundscape (poster)

1. **Citation.** **Pisello AL**, Pigliautile I, Fusaro G, et al. NEXT.ROOM: thermal influence on soundscape perception (IBPC 2018 poster). Local PDF: [IBPC 2018 poster](../Experiment papers/Anna Laura/Sound - IBPC 2018 poster - NEXT.ROOM thermal soundscape perception.pdf).
2. **Objective.** Introduce the **NEXT.ROOM** test-room line: how **indoor temperature** modulates **headphone soundscape** evaluation (poster figures; precursor to Pigliautile 2021, §3.2).
3. **Study area.** **Perugia, Umbria, Italy** (**Europe**) — indoor **NEXT.ROOM** (IBPC 2018 poster campaign; same facility lineage as §3.2).
4. **Instruments and sensors (source study).** Controlled test room; **Sony WH-1000XM4** playbacks; room temperature steps; **measured sound levels** of calibrated playbacks (poster diagrams).
5. **Data they collected (type, timing, resolution, sample).** Pilot / campaign visuals; multi-domain perceptual votes under **warm vs cool** room conditions and **contrasting soundscapes** (e.g. green vs traffic-associated clips).
6. **Statistical test in the source paper.** **Descriptive** means and graphics; **no peer-reviewed inferential table** on the poster sheet we archive.
7. **Mode/Environment.** **Source:** seated **indoor NEXT.ROOM** (same lineage as §3.2). **Our phases:** **WalkG + WalkU** as **field** green vs urban sound/thermal analogues only (**no headphones**).
8. **Sample size (for test).** Same lattice as §3.2: **22** walk questionnaire cells; paired warm−cool on **11** people when both thermal halves exist.
9. **Our data for method port.** **`H4_IBPC$run()`** on **WalkG + WalkU** (`H4_AL$bout_frame`): warmer vs cooler person means on **thermal, visual, acoustic, pleasantness** votes (poster domains). **Not** shared with Pigliautile CSV rows.
10. **Our statistical test (closest family).** Paired *t* on person means; `paper = IBPC 2018 poster`. Pigliautile §3.2 keeps **air-quality** warm−cool + traffic−nature + stratum Spearman only.
11. **What cannot be matched.** No poster sample *n* table, no full ISO descriptor battery, no chamber reproduction on Brussels walks.
---

### 3.4 Chiucchiù et al. 2026 — indoor NEXT.ROOM / headphones

1. **Citation.** Chiucchiù A, Gnecco VM, Pigliautile I, **Pisello AL**. The role of personality in multi-domain environmental perception. *Building and Environment* 2026;290:114140. Local PDF: [Chiucchiù et al. 2026](../Experiment papers/Anna Laura/Sound - The role of personality in multi-domain environmental perception An occupant-centric approach.pdf).
2. **Objective.** Cross-domain thermal–acoustic perception and personality (abstract). Same NEXT.ROOM campaign as Pigliautile; *n* = 25 analysed sessions.
3. **Study area.** **Perugia, Umbria, Italy** (**Europe**) — indoor **NEXT.ROOM** chamber (controlled temperature + headphone soundscapes).
4. **Instruments and sensors (source study).** Empatica E4 (EDA, HR, skin T, **1 min**); Sony WH-1000XM4; PT100 / Delta OHM room sensors; IPIP-NEO-120 personality (source paper §2).
5. **Data they collected (type, timing, resolution, sample).** C0 21 °C / C1 23 °C; seven randomised soundscapes; paired physiology C0 vs C1; Spearman across domains; Table 5 descriptor deltas within assigned soundscapes.
6. **Statistical test in the source paper.** **Paired *t*-tests** (and Cohen’s *d*) on Empatica **EDA tonic, HR, skin temperature** between **C0 (21 °C)** and **C1 (23 °C)** across assigned soundscapes (§2.4). **Spearman** correlations among perceptual domains (thermal, acoustic, pleasantness). **Table 5 analogue:** within each assigned soundscape, paired C0 vs C1 deltas on votes. **K-means** on **IPIP-NEO-120** personality (five profiles); physiology–personality links not repeated here.
7. **Mode/Environment.** **Source:** same **indoor NEXT.ROOM / headphone** campaign as §3.2 (C0/C1, randomised soundscapes). **Our phases:** votes and physiology on **WalkG + WalkU** for field sound/thermal analogues (**no cycling**). **Ten-second data:** **48 rows × 11** per walk phase used in each test.

8. **Sample size (for test).** **22** walk **bouts** for phase-mean physiology; **11** independent people for vote–vote Spearman and paired *t*. Physiology finite walk: **HR / tonic EDA / skin T 22/22** each (no SDNN/RMSSD in `H4_CHIUCCHIU`). **Paired warm−cool (walk):** **11/11** people. **Flag:** no personality inventory; Table 5 / nature-only or traffic-only warm−cool pairs often need **≥3** people with both thermal halves in one sound stratum—many are sparse.

9. **Our data for method port.** Same **WalkG + WalkU** cells as §3.2 item 6. Physiology phase means: `empatica_eda_tonic`, `empatica_heart_rate`, `empatica_skin_temperature`. Votes: thermal, acoustic, pleasantness. Thermal/sound strata as in §3.2. No personality columns in merged file.
10. **Our statistical test (closest family).** (`H4_CHIUCCHIU` on **WalkG/WalkU** only — **22** bout rows in frame, **11** people.) **(a)** Paired *t* **warmer − cooler** person means on **HR, tonic EDA, skin temperature** (C0/C1 analogue) and on **`thermal_comfort`** (source **TSV** paired test with our thermal-comfort item substituted (not an equivalent sensation scale); §2). **(b)** Spearman on **n = 11 participant means** (one mean per person across their two walks): thermal vs acoustic comfort; thermal vs pleasantness—**not** a 22-cell correlation (that would double-count people). **(c)** Within **nature-only** or **traffic-only** subsets, paired *t* **warmer − cooler** on pleasantness and acoustic comfort (Table 5 analogue; encodings 2–3); sparse cells → not estimable. **(d)** Spearman votes vs `ucm_SND_dBA` / YAMNet proportions via the same **participant-mean** rule (`H4_AL$spearman_row`). Personality k-means **not** run (inventory absent).
11. **What cannot be matched.** No chamber, no randomised seven headphone soundscapes, no 1-min Empatica cadence as in NEXT.ROOM, no Big Five inventory. Source **TSV** paired block uses domain thermal comfort (§2).
---

### 3.5 Cureau et al. 2022 — outdoor park walks

1. **Citation.** Cureau RJ, Pigliautile I, Kousis I, **Pisello AL**. Multi-domain human-oriented approach to evaluate human comfort in outdoor environments. *Int. J. Biometeorol.* 2022;66:2033–2045. Local PDF: [Cureau et al. 2022](../Experiment papers/Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf).
2. **Objective.** Evaluate outdoor park comfort across thermal, visual, acoustic and air-quality domains (abstract).
3. **Study area.** **Perugia, Italy** (**Europe**) — **outdoor** field campaign between two **urban parks** (local-user comfort walks).
4. **Instruments and sensors (source study).** Backpack wearable (GPS, Ta, RH, wind, radiation, illuminance, CO2, PM); C.A. 832 sonometer at response time; fixed weather station (p. 2036).
5. **Data they collected (type, timing, resolution, sample).** 24 walkers (3/walk, 8 walks) plus local park users; walk Park 1 → Park 2, ~55 min + surveys; 5-point ISO / soundscape votes.
6. **Statistical test in the source paper.** **Fisher exact** associations between comfort-domain answer categories **separately by park** (p. 2037); also Mann–Whitney and multinomial models on other samples.
7. **Mode/Environment.** **Source:** **outdoor walk** between two Perugia **parks** (~55 min). **Our phases:** **WalkG** and **WalkU** as two park-walk contexts (**walking only**; **no bikes**). **Ten-second data:** **11 × 48** rows per phase (**22** bouts total).

8. **Sample size (for test).** **WalkG 11 + WalkU 11 = 22** cells. Fisher tables **11** responses per walk phase. **Flag:** **n=11** per table is small; source multi-walker parks not reproduced.

9. **Our data for method port.** **WalkG** and **WalkU** as park analogue (item 6); **11 people per walk phase**, one rating each. Pairs: thermal vs acoustic, thermal vs visual, thermal vs overall, acoustic vs visual, acoustic vs overall, visual vs overall via **`h4_additional_outdoor_tests(..., papers = "Cureau")`** in `H4_sound_literature_helpers.R`. No measured dBA in this test.
10. **Our statistical test (same family, closest timing).** Fisher exact on contingency of ordinal comfort categories, **per WalkG and per WalkU** (item 6; **no Bike phases**).
11. **What cannot be matched.** Not two Perugia parks; not independent local-user tables; multinomial comfort models not replicated.
---

### 3.6 Cureau et al. 2023 — Forum Acusticum comfort walk (conference contribution)

1. **Citation.** Cureau RJ, Domenighini L, Pigliautile I, Cotana F, **Pisello AL**. A multi-domain comfort walk: cross-modal interactions on acoustic perception. *Forum Acusticum* 2023. Local PDF: [Cureau et al. 2023](../Experiment papers/Sound_evidence/Sound - A multi-domain comfort walk - cross-modal interactions on acoustic perception.pdf).
2. **Objective.** Outdoor **comfort walk** with environmental monitoring and **acoustic perception** ratings during urban mobility (conference paper; journal version = §3.5).
3. **Study area.** **Perugia, Italy** (**Europe**) — **outdoor** urban walk segments (Forum Acusticum / comfort-walk conference contribution).
4. **Instruments and sensors (source study).** Wearable / portable environmental monitoring on walk; **measured sound level** alongside thermal and other domains during **Perugia** urban walk segments.
5. **Data they collected (type, timing, resolution, sample).** Walk segments with synchronized **dBA (or equivalent)** and comfort-domain responses; cross-modal acoustic perception emphasis.
6. **Statistical test in the source paper.** **Descriptive / survey** associations during walks; supplements the journal **Fisher / multinomial** suite (§3.5).
7. **Mode/Environment.** **Source:** **outdoor on-foot** comfort walk. **Our phases:** **WalkG + WalkU** (green vs urban corridor), walking only.
8. **Sample size (for test).** **22** bout-level comfort cells (11 per phase).
9. **Our data for method port.** **Citation / lineage only** for Forum Acusticum paper; **no duplicate CSV block** (journal §3.5 Fisher rows are the single port).
10. **Our statistical test (closest family).** See §3.5 — `H4_sound_literature_test.R` does **not** re-run Fisher under a second paper label.
11. **What cannot be matched.** Conference *n* and segment timing differ; use §3.5 results for inference on this cohort.
---

### 3.7 Moshammer 2019 — outdoor road/park walks

1. **Citation.** Moshammer H, Panholzer J, Ulbing L, Udvarhelyi E, Ebenbauer B, Peter S. Acute effects of air pollution and noise from road traffic in a panel of young healthy adults. *International Journal of Environmental Research and Public Health* 2019;16:788. Local PDF: [Moshammer et al. 2019](../Experiment papers/H4 Sound literature test/Included - Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf).
2. **Objective.** Whether acute respiratory and cardiovascular reactions to everyday urban traffic air pollution occur, and whether noise can be separated from particle exposure when both come from road traffic (p. 2).
3. **Study area.** **Vienna, Austria** (**Europe**) — **outdoor** busy-road vs urban-park walking loops (1 h per setting).
4. **Instruments and sensors (source study).** Grimm Portable Laser Aerosol Spectrometer 1.108 (PM2.5, PM1); miniDiSC (particle number, **6 s** averages); Brüel & Kjær type 2236 (**Leq every 15 min**); EasyOne spirometer; NObreath (exhaled NO); eMotion Faros ECG (**15-min** HRV, Kubios 2.2); blood pressure at end of each 15-min period (device not named); fixed stations (PM10, temperature).
5. **Data they collected (type, timing, resolution, sample).** *n* = 24 non-smoking students, Vienna (20 then +4 women); ≥4 walks per setting, **1 h** per walk. Settings: busy road; road + ear plugs; park; park + **65 dB** recorded traffic in headphones. BP and HRV **every 15 min** (4 periods/walk); lung function and exhaled NO at pre/post/1 h/24 h. Exposure for each CV period = **Leq of the preceding 15 min**; ECG over that 15 min; BP at period end. Descriptive LAeq: road ~56, park ~46, headphones 65, ear-plugs ~30 dB lower (p. 4).
6. **Statistical test in the source paper.** Stata 13.1 `xtreg`, random-effects GLS. Outcome in 15-min period ~ preceding 15-min Leq (+ particles; + temperature in adjusted runs). Appendix Table A2 = noise-only. Unit: 15-min period × walk × person. Example finding: SDNN −1.87 ms per dB (15-min lag), *p* = 0.001.
7. **Mode/Environment.** **Source:** **1 h outdoor walks**—**busy road**, road with earplugs, **urban park**, park with recorded traffic in headphones (Vienna). **Our phases:** **WalkU** ≈ road/traffic; **WalkG** ≈ park; **WalkG + WalkU only** (source panel walked; we do not use Bike*). **Ten-second data:** full **48 × 11** series per bout; physiology blocks may use **5 min exposure + 3 min outcome** windows within those rows.

8. **Sample size (for test).** **22** walk bouts; **1056** ten-second rows. **GLS/LMM rows:** **22** (physiology above). **Mean energy dBA:** WalkU **67.6** (11 cells), WalkG **61.7** (11). **Flag:** source **1 h×4** settings ≫ **8 min×2** routes.

9. **Our data for method port.** Input: `output/merged_all_11participants_8min.csv` + `output/empatica_files/01_empatica_rri_native.csv`. Phases: **WalkU + WalkG only** (item 6). 11 people; one row per participant×phase (8 min, **48 × 10 s** per bout). Exposure: energy-mean `ucm_SND_dBA`, **first 5 min** only. Outcomes **5–8 min**: RR, SDNN, RMSSD, LF, HF from native beats. Optional: mean `ucm_AIR_temp` on outcome window. **22** walk bouts.
10. **Our statistical test (same family, closest timing).** **(A) Physiology (walk GLS):** noise only: `outcome_5to8min ~ noise_leq_first5min + (1|ParticipantID)`, Swamy–Arora GLS (`xtreg, re`), per 1 dB(A), Wald *z*, *p* < 0.05 as in Table A2; optional `air_temp_outcome_window`. No particles, settings, or 15/30/45/60 min lags. **(B) Comfort (catalogue label `Moshammer 2019 (comfort adaptation)`):** additive LMM `acoustic_comfort ~ dba + utci + (1|ParticipantID)` on walk phase cells (`H4_EUROPE_PORTS$additive_comfort_lmm`) — comfort-outcome **adaptation**, not Table A2 HRV.
11. **What cannot be matched.** No 1 h / four 15-min periods; we use **5 min exposure + 3 min outcome**. No lung function, exhaled NO, BP, or particles. No plug/headphone routes. Their Table A2 coefficients are for their panel and timing only.
---

### 3.8 Rodrigues 2026 — outdoor walking

1. **Citation.** Rodrigues AL, da Conceição MSA, Ramusga RAL, Lima Azevedo C, Morgado P. The influence of urban context on emotions and bodily responses during walking. *Journal of Urban Health* 2026;103:344–356. Local PDF: [Rodrigues et al. 2026](../Experiment papers/H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf).
2. **Objective.** How urban features (noise, heat, vegetation, infrastructure) relate to physiology and post-trip emotion during everyday walking; H2: stressors increase physiological activation (pp. 345, 348).
3. **Study area.** **Lisbon, Portugal** (**Europe**) — **outdoor** everyday walking trips (app-logged urban context).
4. **Instruments and sensors (source study).** Empatica E4 (HR, RMSSD, EDA, skin T; HRV in **10 s** windows, trip summaries); X-ing app + GPS; **Lden noise map** in 25 m buffer (mean/min/max/SD); IPMA daily weather (pp. 347–348).
5. **Data they collected (type, timing, resolution, sample).** *n* = 90 residents, 2,207 walking trips, Aug–Dec 2024; trip kept if ≥2 min valid sensor contact. Predictors standardised; separate **Noise** and **Temperature** thematic blocks, 27 physiological indicators.
6. **Statistical test in the source paper.** Trip-level **MixedLM**, participant random intercept; each block tested separately; retain if *p* < 0.05 and |β| > 0.1. Noise block: e.g. physiology ~ z(max noise) + z(SD noise). No sound×temperature in H2 blocks.
7. **Mode/Environment.** **Source:** **walking trips** in urban Lisbon (app-logged). **Our phases:** **WalkU + WalkG only** (**22** trips; **no cycling**). **Ten-second data:** **48 × 11** per trip for trip-level min/max/SD summaries.

8. **Sample size (for test).** **22** walking trips (**WalkG 11**, **WalkU 11**); **11/11** people with both. **LMM rows:** **22**.

9. **Our data for method port.** WalkU + WalkG only: **22 trips**, 11 people, 8-min bout → trip summaries (mean/min/max/SD HR, HRV, wrist T). Sound: personal `ucm_SND_dBA` trip max and SD. Temperature: trip max and mean `ucm_AIR_temp`. Separate noise and temperature blocks as in source.
10. **Our statistical test (same family, closest timing).** **(A) Physiology:** `Y_trip ~ z(dBA_max) + z(dBA_SD) + (1|participant)` and `Y_trip ~ z(Ta_max) + z(Ta_mean) + (1|participant)`; Wald *z*; source rule *p* < 0.05 and |β| > 0.1. **(B) Comfort (`Rodrigues 2026 (comfort adaptation)`):** noise and temperature **blocks on comfort votes** (`H4_EUROPE_PORTS$rodrigues_comfort_blocks`) — separate paper label in the catalogue.
11. **What cannot be matched.** Worn dBA is not mapped Lden; trip weather is not daily station summary; cycling phases excluded; no post-trip emotion app items.
---

### 3.9 Kraus 2013 — mixed indoor/outdoor daily life

1. **Citation.** Kraus U, Schneider A, Breitner S, Hampel R, Rückerl R, Pitz M, Geruschkat U, Belcredi P, Radon K, Peters A. Individual daytime noise exposure during routine activities and heart rate variability in adults. *Environmental Health Perspectives* 2013;121:607–612. Local PDF: [Kraus et al. 2013](../Experiment papers/Sound_evidence/Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf).
2. **Objective.** Association between individual daytime noise and HRV as a cardiovascular-risk mechanism (p. 607).
3. **Study area.** **Augsburg, Bavaria, Germany** (**Europe**) — **routine daytime** activities (collar dosimetry; indoor/outdoor mix).
4. **Instruments and sensors (source study).** Mortara H12 Holter; Larson Davis Spark 703 collar dosimeter (A-weighted Leq, **5-min** aligns); particle counter (p. 608).
5. **Data they collected (type, timing, resolution, sample).** *n* = 110 adults, Augsburg; up to 6 h recordings, ~20,000 **5-min segments**; activity diaries; piecewise Leq at **65 dB(A)**; lags 0–15 min; compound symmetry + lagged outcome.
6. **Statistical test in the source paper.** Additive mixed models; log outcomes except HR; activity and time trends; HRV models adjust for HR; SAS 9.2.
7. **Mode/Environment.** **Source:** **routine daytime activities** (collar dosimeter; walking, home, work, etc.). **Our phases:** **all four phases**; **PhaseID** encodes **walk vs cycle** as activity analogue. **Ten-second data:** **5-min intervals** built from rows inside each bout when interval coverage rules are met.

8. **Sample size (for test).** **44** phase cells. **dBA ≥65 dB(A):** **23 yes / 21 no**. Walk **22** / Bike **22**. **5-min interval rows:** ≤**44** (often **0–1** per bout). **Flag:** no 15-min lags.

9. **Our data for method port.** Input: merged 10-s rows + `01_empatica_rri_native.csv`. Build **5-min interval** records inside each 8-min bout when ≥⅔ of interval 10-s rows exist (`H4_KRAUS$interval_frame`): interval energy-mean dBA as **Leq**; outcomes HR (raw), SDNN, ln LF/HF/LF:HF from native beats at interval end. Attach `study_day`, simplified **activity** from `PhaseID` (walk vs cycle). Only **lag 0** and one interval per bout are reliably populated (no 15-min lag chain).
10. **Our statistical test (closest family).** (`H4_KRAUS$run`.) Additive **mixed model** per outcome: piecewise **Leq at 65 dB(A)** (`L0_below65_per5`, `L0_above65_per5` per 1 SD increase above knot); optional **lag-0** duplicate; **time trend** chosen by AIC among linear/poly/spline forms on interval index; **`weekday`** if it improves AIC vs base; **lagged outcome** term only if a prior interval exists (usually omitted here). HR untransformed; HRV powers log-transformed. SAS-style compound symmetry approximated via **`lme` random intercept + correlation structure** as coded in helper; Wald *t* on sound terms.
11. **What cannot be matched.** No 6 h collar dosimeter with 20 000 five-minute segments, no activity diary codes, no lags 5–15 min, no particle adjustment, no prior-day rest reference.
---

### 3.10 Korpilo 2024 — outdoor visits to nearby forest/beach/park

1. **Citation.** Korpilo S, Nyberg E, Vierikko K, Ojala A, Kaseva J, Lehtimäki J, Kopperoinen L, Cerwén G, Hedblom M, Castellazzi E, Raymond CM. Landscape and soundscape quality promote stress recovery in nearby urban nature. *Urban Forestry & Urban Greening* 2024;95:128286. Local PDF: [Korpilo et al. 2024](../Experiment papers/Sound_evidence/Sound - Korpilo2024 - Landscape soundscape quality stress recovery urban nature.pdf).
2. **Objective.** The authors asked whether stress recovery after exposure to nearby urban nature depends on stop type (forest, beach, park) and on measured landscape and soundscape quality.
3. **Study area.** **Helsinki metropolitan area, Finland** (**Europe**) — **outdoor** visits to nearby urban **forest, beach, and park** stops.
4. **Instruments and sensors (source study).** A smart ring recorded electrodermal activity at 3 Hz. A Zoom H4n Pro captured 5-minute sound clips (44.1 kHz). They also used a Flow particulate monitor, GPS, and FMI weather data at 10-minute resolution. Soundscape quality used the Normalized Difference Soundscape Index (NDSI), with anthropogenic sound in 1–2 kHz and biophonic sound in 2–8 kHz. The methods text we checked does not name a separate sound level meter.
5. **Data they collected (type, timing, resolution, sample).** Forty-five participants made group walks with planned visits to three environments: forest, beach, and park. Each person contributed restorative outcome (ROS) scores and an EDA-derived stress index. In Model 1, stop type was the main predictor; Model 2 added continuous measures, including NDSI.
6. **Statistical test in the source paper.** Generalized linear mixed models: beta regression with logit link for the EDA outcome and Gaussian models for ROS; Kenward–Roger adjustment for degrees of freedom. In the source, predictors could enter the model when *p* < 0.10.
7. **Mode/Environment.** **Source:** **outdoor group walks** with planned stops at **forest, beach, park**. **Our phases:** **WalkG** ≈ forest/park/nature stop; **WalkU** ≈ more urban/traffic context; **WalkG + WalkU only**. **Ten-second data:** **11 × 48** per walk phase (one phase cell per person×route).

8. **Sample size (for test).** **22** walk cells. **WalkG** mean dBA **61.7**; **WalkU** **67.6**. **LMM:** **22** rows.

9. **Our data for method port.** One row per **WalkG or WalkU** bout (item 6): **ln(mean `empatica_eda_tonic`)** when >0; **NDSI analogue** = phase mean of \((f_{2000–20k} - f_{200–2k})/(f_{2000–20k} + f_{200–2k})\) from merged frequency proportions (or substitute each of the **four sound encodings** for `sound_x`). Covariates: phase-mean `ucm_AIR_temp`, `ucm_AIR_RH`; route (**WalkG** vs **WalkU**). No ROS questionnaire.
10. **Our statistical test (closest family).** (`H4_KORPILO$run`.) **Gaussian LMM** (source used **beta-logit** on a normalised stress index): `eda_ln ~ sound_x + air_temp_c + air_rh + PhaseID + (1|ParticipantID)`, REML; report Wald *t* on `sound_x` (NDSI or encoding). Repeat with dBA, corridor, vehicle share, each class proportion. Source also modelled **ROS** with Kenward–Roger — not replicated (no ROS).
11. **What cannot be matched.** No randomised forest/beach/park stops or group order; no Zoom H4n stop recordings; no beta-logit on their normalised EDA index; PRS/ROS not collected.
---

### 3.11 Ueberham et al. 2019 — outdoor cycling

1. **Citation.** Ueberham M, Schlink U, Dijst M, Weiland U. Cyclists' multiple environmental urban exposures—comparing subjective and objective measurements. *Sustainability* 2019;11:1412. Local PDF: [Ueberham et al. 2019](../Experiment papers/Sound_evidence/Ueberham2019_Cyclists_multiple_environmental_exposures.pdf).
2. **Objective.** Compare cyclists' objective vs perceived noise, particles and heat (abstract).
3. **Study area.** **Leipzig, Saxony, Germany** (**Europe**) — **outdoor** urban cycling routes.
4. **Instruments and sensors (source study).** Dylos PNC (60 s); HOBO temperature; smartphone + Edutige mic, noise and heat **every 2 s** (§2.2).
5. **Data they collected (type, timing, resolution, sample).** *n* = 66 cyclists, Leipzig; 730 routes; post-trip **perceived noise / PNC / heat** (1–5), not comfort.
6. **Statistical test in the source paper.** **Spearman** ρ between **objective route means** (personal noise dBA, particle counts, temperature) and **post-trip subjective ratings** of noise intensity, particle annoyance, and heat (1–5) (§2.3). **Ordinal (proportional odds) regression** of subjective class on objective exposure class after categorising both into ordered groups.
7. **Mode/Environment.** **Source:** **cyclists only** (Leipzig route archive). **Our phases:** **BikeU + BikeG only**—**do not use WalkG or WalkU**. **Ten-second data:** **11 × 48** per cycling phase (**22** cells).

8. **Sample size (for test).** **BikeG 11 + BikeU 11 = 22** cells; **11/11** cyclists both routes. Mean dBA **BikeU 71.6** vs **BikeG 60.6**. **Spearman per phase:** **n=11** each.

9. **Our data for method port.** No subjective noise/heat **intensity** items. **Partial analogue:** **22** cells (**BikeU + BikeG** only; item 6) with objective energy-mean `ucm_SND_dBA`, `ucm_UTCI`, `ucm_AIR_temp`; subjective **`questionnaire_acoustic_comfort_1_5`** and **`questionnaire_thermal_comfort_1_5`** (comfort, not intensity). **BikeU** vs **BikeG** as urban vs green route.
10. **Our statistical test (closest family).** **Spearman** `cor.test` within each cycling phase (`H4_sound_literature_test.R`): phase-mean **`dba`** vs **`acoustic_comfort`**; phase-mean **`utci`** vs **`thermal_comfort`** — **BikeG** and **BikeU** separately (*n* = 11 each). Source **polr** on intensity scales **not fitted** (intensity items not collected).
11. **What cannot be matched.** No cyclists-only sample, no Dylos PNC, no 730 route archive, no perceived loudness/PNC/heat intensity scales; comfort votes are not the source outcomes.
---

### 3.12 Jin, Jin & Kang 2020 — outdoor squares, respondents standing/sitting

1. **Citation.** Jin Y, Jin H, Kang J. Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares. *Building and Environment* 2020;168:106517. Local PDF: [Jin et al. 2020](../Experiment papers/H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf).
2. **Objective.** How the thermal-acoustic environment of Harbin urban squares affects thermal, acoustic and overall comfort, and how to predict equivalent overall comfort (pp. 1–3).
3. **Study area.** **Harbin, Heilongjiang, China** (**Asia**) — **outdoor urban squares** (cold continental climate; winter, transitional, and summer campaigns).
4. **Instruments and sensors (source study).** BSWA801 (LAeq, 30 s samples, 19–137 dB(A)); BES-01 globe (0.08 m), BES-02 T/RH, Kestrel 5500 wind; tripod ~1.2 m, ISO 7726 (p. 4).
5. **Data they collected (type, timing, resolution, sample).** *N* = 1,495 valid questionnaires in three squares (P1–P4 sites), winter / transitional / summer; volunteers standing or sitting; concurrent measurement. Votes: TSV (−4…+4), TCV/ACV/OCV (−3…+3). LAeq in **5 dB bands** 55–60 / 60–65 / 65–70 / 70–75 dB(A); UTCI **stress categories** by season (Tables 3–4).
6. **Statistical test in the source paper.** Two-way **ANOVA** of each vote on **LAeq level × UTCI category**, by season (Tables 5–7). Unit: one independent respondent per questionnaire. **SOURCE FORMULA:** \(Y_{k} \sim \mu + \alpha_{i}^{\mathrm{LAeq}} + \beta_{j}^{\mathrm{UTCI}} + (\alpha\beta)_{ij}^{\mathrm{LAeq}\times\mathrm{UTCI}} + \varepsilon\) for each vote \(Y_k \in \{\mathrm{TSV,TCV,ACV,OCV}\}\); fitted **by season** on **independent** questionnaires (not repeated measures). Type II sums of squares in the source tables.
7. **Mode/Environment.** **Source:** respondents **standing or sitting** in Harbin **urban squares** (pedestrian, not cycling). **Our phases:** **WalkG + WalkU** as square-exposure analogues (**22** cells; **no BikeG/BikeU**). **Ten-second data:** **11 × 48** per phase for objective dBA/UTCI.
8. **Sample size (for test).** **Source:** **N = 1,495** independent square questionnaires; **no** pre-filter to “hot and loud” rows—the full **LAeq band × UTCI category** grid is analysed **by season** (Tables 5–7). **Our port (if enabled):** **22** walk cells (**WalkG + WalkU**, item 7). **5 dB-spaced** `sound_level` × **UTCI stress-category** `thermal_level`; many factor cells **empty or rank-deficient** on *n* = 22. Alternate **`H4_JIN$run`** uses **sample quartiles** (adaptation, not the source’s fixed bands). **Flag:** min cell **1** (<5) on some crossed tables here; not comparable to source cell counts.
9. **Our data for method port.** `output/merged_all_11participants_8min.csv` → **WalkG + WalkU** only (item 6). One thermal / acoustic / overall comfort rating per cell (§2). Phase energy-mean `ucm_SND_dBA` binned at **5 dB** spacing; phase-mean `ucm_UTCI` cut with **published-style stress breakpoints** (retain quiet/cool bouts as factor levels—do **not** drop them before ANOVA). **Substitute encodings:** `H4_JIN$run` quartiles of sound and UTCI; outcomes **`H4_JIN$outcomes`**. Code: **`H4_JIN`** in `library/H4_sound_literature_helpers.R`. **Not run** by `H4_sound_literature_test.R` (§3.1–§3.11 only).
10. **Our statistical test (same family, closest timing).** If enabled: participant-blocked Type-II two-way ANOVA — `outcome ~ ParticipantID + sound_level * thermal_level` for **`thermal_comfort`**, **`acoustic_comfort`**, **`overall_comfort`** (`H4_JIN$anova_type2`); encodings 2–4 via `H4_JIN$run` with quartile factors. Source *p* < 0.05 where applicable.
11. **What cannot be matched.** Not 1,495 independent square respondents; three-season field design; sparse cells in band×category tables on *n* = **22**. **5-point comfort scores** are not relabelled as bipolar −3…+3 TCV categories.
---

### 3.13 Biel et al. 2020 — mixed indoor/outdoor daily activity

1. **Citation.** Biel R, Danieli C, Shekarrizfard M, Minet L, Abrahamowicz M, Baumgartner J, Liu R, Hatzopoulou M, Weichenthal S. Acute cardiovascular health effects in a panel study of personal exposure to traffic-related air pollutants and noise in Toronto. *Scientific Reports* 2020;10:16703. Local PDF: [Biel et al. 2020](../Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf).
2. **Objective.** Acute cardiovascular responses to personal air pollution and whether personal noise confounds them (abstract).
3. **Study area.** **Toronto, Ontario, Canada** (**North America**) — **free-living** urban region (personal dosimetry; indoor/outdoor mix, May–August).
4. **Instruments and sensors (source study).** DiSCmini (UFP, 1 s); MicroAeth (BC); Brüel & Kjær 4448 dosimeter (**dBA, 1 min**); HOBO Ta/RH; Space Labs BP; EndoPAT; Holter; fixed-site PM2.5/NO2/O3 hourly (p. 7).
5. **Data they collected (type, timing, resolution, sample).** *n* = 46 adults, Toronto, May–August 2016; up to 7 h/day, mean 4.9 h monitored; HRV Holter every **30 min**, HRV from **last 5 min** of each 30-min window; baseline and post-exposure BP/RHI same day.
6. **Statistical test in the source paper.** LMM with subject random intercepts **and slopes**, **AR(1)** on repeated 30-min windows; `g(Y) ~ personal_noise + Ta` (+ pollutants, RH/caffeine/alcohol if ≥10% coefficient change). Noise scaled per **interquartile range** of personal Leq.
7. **Mode/Environment.** **Source:** **free-living daytime** in Toronto (indoor/outdoor mix; personal dosimeter on **walk, transit, other activities**). **Our phases:** **all four**—**WalkU, WalkG, BikeU, BikeG**—because the source mixed mobility modes (**11** per phase). **Ten-second data:** phase aggregates or **2-min windows** over rows inside each 8-min bout.
8. **Sample size (for test).** **All four phases 44** cells (**11** each). **Source:** up to 7 h/day personal monitoring, not a hot–loud phase subset. **Our port (if enabled):** **2-min windows** inside each 8-min bout ⇒ up to **~3** per bout (**≤132** correlated sub-rows, not independent people). **Flag:** no full-day panel.
9. **Our data for method port.** **All four phases** (item 6). Input: merged 11 + Empatica columns. **Phase-level set:** one row per participant×phase; exposure = energy-mean `ucm_SND_dBA`; covariate = phase-mean `ucm_AIR_temp`, optional `ucm_AIR_RH`. Outcomes phase-mean: HR, SDNN, RMSSD; ln phase-mean LF, HF, LF/HF (`H4_BIEL$outcomes`). **Repeated-window set:** consecutive **2-min** windows inside each 8-min bout (`H4_BIEL_REPEATED`). BH **within Biel test family** in legacy pipeline.
10. **Our statistical test (closest family).** If enabled (`H4_BIEL` / `H4_BIEL_REPEATED` in `library/H4_sound_literature_helpers.R`): **Phase LMM** `Y ~ noise + air_temp_c [+ air_rh if RH changes noise β by ≥10%] + (1|ParticipantID)`; **repeated 2-min LMM** with `corCAR1`. **Not run** by `H4_sound_literature_test.R` (§3.1–§3.11 only).
11. **What cannot be matched.** No 30-min Holter windows, no baseline/post RHI or office BP, no caffeine/alcohol diaries, no MicroAeth/DiSCmini, no day-long dosimetry beyond one 8-min bout per phase.
---

### 3.14 Song et al. (2013, 2014) — outdoor park vs city walks

1. **Citation.** Song C, Joung D, Ikei H, Igarashi M, Aga M, Park B.-J, Miwa M, Takagaki M, & Miyazaki Y. (2013). Physiological and psychological effects of walking on young males in urban parks in winter. *Journal of Physiological Anthropology*, 32, 18. Song C, Ikei H, Igarashi M, Miwa M, Takagaki M, & Miyazaki Y. (2014). Physiological and psychological responses of young males during spring-time walks in urban parks. *Journal of Physiological Anthropology*, 33, 8. Local PDF: [Song et al. 2013](../Experiment papers/H4 Sound literature test/Included - Sound - Song2013 - winter urban park vs city walk HRV J Physiol Anthropol 32-18.pdf); [Song et al. 2014](../Experiment papers/H4 Sound literature test/Included - Sound - Song2014 - spring urban park vs city walk HRV J Physiol Anthropol 33-8.pdf).
2. **Objective.** Compare physiology and psychology during **park** versus **built-environment** walking (winter and spring campaigns in the source papers).
3. **Study area.** **Japan** (**Asia**) — **outdoor** urban **park vs city** walking routes (season-specific campaigns in the two papers).
4. **Instruments and sensors (source study).** Physiological monitoring (HR/HRV and related indices) and psychological scales as reported in the park–city walk papers; **no LAeq × temperature comfort model** in the block cited for H4 Methods.
5. **Data they collected (type, timing, resolution, sample).** Young male walkers; repeated **park vs city** walks; physiology and questionnaire outcomes per walk type.
6. **Statistical test in the source paper.** **Between-route** comparisons of HR/HRV and psychological scores (paired or independent tests as reported); **no LAeq × UTCI comfort model** in these papers’ methods.
7. **Mode/Environment.** **Source:** **park walk vs city walk**. **Our analogue:** **WalkG** vs **WalkU**, walking only.
8. **Sample size (for test).** **11** paired people, **22** walk cells if both routes exist.
9. **Our data for method port.** Not used in the current `H4_sound_literature_test.R` catalogue. A park-vs-city paired physiology contrast would omit measured **dBA** and **UTCI** terms to stay faithful to the source absence.
10. **Our statistical test (closest family).** **Not fitted** in `H4_sound_literature_test.R`. A faithful port would be park vs city physiology/psychology **without** measured dBA or UTCI terms — not the thermo-acoustic **comfort** family used in §3.1–§3.11.
11. **What cannot be matched.** Japanese park–city sites; full walk duration and season design; adding dBA/UTCI would depart from the cited Methods block.
---

## 4. Cross-paper limitations of the data used

- **Catalogue deduplication.** Pigliautile vs Chiucchiù: full-session vote–sound Spearman rows are **canonical under Chiucchiù**; Pigliautile keeps thermal-stratum Spearman and paired contrasts (§1.1). Encodings 1–4 are separate source-inspired blocks; each row keeps its nominal rule label, but the encodings are dependent alternatives rather than independent confirmations.
- **Same data, many adaptations.** Every port reuses the same 11 people and 44 bouts (22 walk cells where walk-only). Results under different paper labels are **not independent** and **do not** stack as H4 evidence. Duplicate computations must be identified explicitly; the IBPC/Chiucchiù thermal rows remain in the catalogue and must not be counted twice. **No headline MET tally** is inferred from a highlight subset. See §0.3–§0.4: the two warm–cool rows are one statistical test, and source labels do not create replication.
- **Potential mode confounding.** Moshammer all-phase and vote models without mode adjustment can mix within-mode and between-mode associations. Kraus does include a mode-derived activity covariate; Rodrigues and Moshammer walking-only restrict the mode. A mode-driven explanation has not been established by these fits.
- **Temperature–corridor coupling.** All 11 urban walks are warmer than their paired green walks in the current input. This affects Rodrigues (noise block without temperature), the Pigliautile/Chiucchiù stratum tests and any corridor-labelled sound analogue.
- **Rodrigues** uses asymptotic Wald z and zero-imputes missing predictors before scaling. **Source rule:** *p* < 0.05 and |β| > 0.1 on the retained term — not a global FDR rule across the catalogue.
- **Kraus** has redundant participant/CS variance parameters under the stated homogeneous specification (§3.9); study day supplies between-person information only.
- **Thresholds / sparse cells.** Fixed published cutpoints and band×stress grids can leave **0–3** cells per level on *n* = 22 walk bouts; judge estimability per block (§1.3).
- **YAMNet mapping** (§1.2): substring matching places 42 classes in more than one category and misroutes some (e.g. Train → Rural/Natural; Traffic noise not in Vehicle). This applies to encodings 3–4; the columns have not been regenerated. YAMNet proportions also cannot be split into a dBA per sound source: only the dBA of 10-s rows in which a class is present (a mixture level) can be computed.
- **Sound-level provenance**: see **§6** (10-s `ucm_SND_dBA` is not certified LAeq).

## 5. Differences from the selected source studies and candidate contributions

These bullets identify differences relevant to the selected analysis blocks, not exhaustive summaries of each paper or proof of a gap across the entire field. A different measurement is not automatically a novel contribution or a valid substitute. In particular, different paper labels and standardized versus unstandardized versions do not create independent **samples**; see **§4** catalogue deduplication. Nominal source-shaped rules are recorded for transparency; they do not supply a confirmatory H4 decision or replace multiplicity and dependence considerations.

- **Moshammer 2019:** Studied air pollution as well as noise and cardiovascular/respiratory outcomes; it was not limited to Leq and air temperature. Our selected noise-model adaptation adds source/context representations not used in that selected block.
- **Rodrigues 2026:** Mapped Lden and station weather, additive blocks, no interaction, no classifier.
- **Kraus 2013:** Piecewise Leq at 65 dB on 5 min HRV in daily life. No thermal-comfort votes, no source classification.
- **Korpilo 2024:** NDSI from 1–2 vs 2–8 kHz band energy, not a sound-event classifier. Frequency ratio ≠ YAMNet vehicle vs rural_natural.
- **Pigliautile 2021 / Chiucchiù 2026 / IBPC 2018:** NEXT.ROOM chamber lineage; headphone woodland vs street at two room temperatures (poster = descriptive only). No field dBA, no YAMNet, no mobility.
- **Cureau 2022 / FA 2023:** The selected Fisher tests concern comfort-domain associations; the journal source also used multinomial models. Our Fisher block is not a measured dBA effect test.
- **Grapas et al. 2026:** Brussels ambulatory SOR and pathway latency; we port **Pearson phase-mean web** only, not bootstrap/Granger machinery.
- **Pisello material panels (outside §3):** Laboratory acoustic indices with thermal conductivity; **no** human walk port.
- **Ueberham 2019:** Subjective loudness/exposure intensity (not collected here). No YAMNet.

Method descriptions in §3 are reconstructions aligned to the local PDFs linked in each **item 1**, not verbatim quotations.

## 6. Measurement provenance (sound level and classifiers)

- **`ucm_SND_dBA`:** per 10-s row, a **median** of UCM sound samples in that window (not a laboratory-certified LAeq chain documented here). Phase-level values used in H4 are **energy means** of those 10-s medians across each 8-min bout.
- **Native 1-s LAeq export path** referenced in earlier drafts is **not** present in the current pipeline; do not cite it as the H4 exposure definition.
- **YAMNet proportions** come from the analysis notebook named in §1.2; they are frame-detection shares, not calibrated level or duration (§1.2).

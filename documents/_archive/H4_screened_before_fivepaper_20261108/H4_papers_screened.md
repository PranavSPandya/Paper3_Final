# H4 sound evidence: what the papers tested and what we actually fitted

Updated 8 November 2026 (results summary added; data-used audit from 7 November retained). **This is the one active H4 methods guide.** It replaces the three older screening/replacement/discrepancy documents, now retained under `documents/_archive/H4_methods_20261107/`. Original papers are evidence; this guide records their mapping to our data. H5 is now the combined-exposure analysis, not the retired grid analysis.

**How to read the paper sections (§3).** Each paper has the source test as previously recorded in this guide, our implemented test, a **Data used** block (our data only), a **Result** block, and limitations. **Result** is from the official four-phase CSV (`H4_sound_literature_tests.csv`); q is BH within paper × test × sound variable. Coefficients are on that block's modelled scale. The source-paper descriptions and source sample sizes were **not independently re-verified in this edit**. They are carried over from earlier checks and from the run's `METHODS_NOTES.md`. Every "Data used" count below comes from the current official outputs in `output/statistical_analysis/results/H4_sound_literature_test/`, or from a read-only recount of the merged input; §1.4 was checked against the current core CSV on 8 November 2026. Those outputs carry code and input MD5 fingerprints that match the current scripts and `output/merged_all_11participants_8min.csv` (input MD5 `a3c4f9388b61def82e5b97b4232315be`). If the scripts change again, these counts must be rechecked.

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

- **Moshammer, Biel, Kraus, Rodrigues:** substitute the representation for sound level in the explicitly adapted source-inspired model. **Jin** uses two ANOVA levels when the encoding is binary, otherwise quartiles. For Rodrigues, within-trip corridor SD is zero, making the joint max+SD model singular; the max still varies between trips. The Kraus two-segment corridor fit is also singular.
- **Korpilo:** source run keeps the NDSI analogue; the same LMM is also fitted with each other encoding in place of NDSI (corridor is aliased with PhaseID and not estimable).
- **Pigliautile:** paired traffic-minus-nature person means for encodings 2–3, and thermal-stratum person-mean Spearman for encodings 1 and 4. Full-session vote–sound Spearman is fitted once under Chiucchiù, not repeated under a second family.
- **Chiucchiù:** paired physiological warmer/cooler means; Table 5 analogue for encodings 2–3; full-session person-mean Spearman of thermal/pleasantness/acoustic votes against encodings 1 and 4. The source TSV paired test is not fitted because TSV is absent; TC warmer/cooler is already in Pigliautile.
- **Chen:** `rating ~ zUTCI * zSound + (1|participant)` for each encoding. Primary dBA also includes `zNaturalShare`.
- **Qin:** `TC ~ zSound * zRH` on all four encodings (humidity, not UTCI).
- **Gao:** `PRS ~ zUTCI * zSound` on all four encodings; two-way ANOVA of PRS on dBA × UTCI quartiles.
- **Wu:** `OC ~ zUTCI + zSound` on all four encodings; `TC ~ I(dBA≥60) * zUTCI`; median-split analogue on encodings 2–4.
- **Xu:** thermally unadjusted linear `AC ~ zSound` (not a threshold); combined `TC ~ I(air_temp_c>32) * I(dBA>65)` only if all four cells are observed (not in core; §3.17). Air temperature, not UTCI. The ASV 64.8 dB knot is not imposed on AC.
- **Zhen:** unstandardized `TC ~ UTCI * dBA` sensitivity without Chen’s natural-share covariate. Alternative encodings are not refitted because they reparameterize Chen TC. TSV/NUTCI remain unavailable.
- **Mohammadzadeh:** `AC ~ zUTCI`, `AC ~ TC`, and the primary dBA interaction without Chen’s natural-share covariate. Alternative-encoding AC interactions are canonical Chen fits, not duplicated.
- **Cureau:** no sound exposure (vote vs vote by phase). **Zhang SciRep:** perceived AC × UTCI, not a measured encoding. **Zhang BSim:** Spearman vs dBA by phase. **Song, Ueberham, Li 2025, Jin 2020 chamber:** not fitted.

Fifteen spectral descriptors are an extra substitution on Moshammer, Jin, Biel, Rodrigues, Kraus and Korpilo only. They are not one of the four encodings. (Earlier text listed five papers; Korpilo also fits them as NDSI substitutes.)

Walking is the more stable loudness pair (energy-mean **64.4 dB(A)** WalkG vs **69.4** WalkU). Cycling is louder and more variable (**65.8** BikeG vs **76.3** BikeU). Encoding 3 seconds: of 2,111 core 10 s rows, WalkG is 28% vehicle>rural, BikeG 25%, BikeU 54%, WalkU **34% vehicle / 66% nature**. The previously cited native 1-s output path is absent; see the measurement-provenance limit in §10.

### 1.2 What the YAMNet proportion columns are, and their mapping limitation

The proportion columns come from `D:\Pranav\docker\Analysis\analysis_scripts\Updated_JOS_Environmental_sound_classification_with_YAMNet_yenshuo.ipynb` (outputs in `Analysis\analysis_output\Sound_ucm`, dated 24 October 2026). That is the version read on 7 November. A slightly different copy in `D:\Pranav\docker\Paper3_Final\scripts` was not compared. A proportion is the **share of YAMNet frames** (about 20 per 10-s window) in which any class mapped to that category scores ≥ 0.20. Categories overlap, so the eight columns can sum to more than 1; `unidentify` is the share of frames with no category. These are thresholded frame-detection prevalences, not exact sound durations, energy shares, calibrated levels or classifier confidence. Peak normalisation removes the absolute amplitude reference; the proportions cannot recover calibrated sound level, although they may correlate with recorded dBA.

**Known category-mapping errors (checked against the public YAMNet class map on 7 November):** categories are assigned by case-insensitive substring matching. 42 YAMNet classes fall into more than one category. Examples: "Train" also counts as Rural/Natural ("rain" is inside "train"); "Crowd" counts as Rural/Natural ("crow"); "Rain", "Water", "Fire" and some music classes count as Vehicle; the generic "Noise" class and "Owl" count as Wind; "Traffic noise, roadway noise" is in Urban negative but **not** in Vehicle; and the generic "Vehicle" class is in both Vehicle and Urban negative. This limitation applies to every analysis below that uses encodings 3 or 4 (and Chen's natural share). **The proportion columns have not been regenerated with a corrected mapping**, so current results use the mapping as described. These known semantic mapping errors prevent interpreting the exported labels as validated natural/vehicle exposure. Until correction and regeneration, report associations with the exported labels only; source-specific design recommendations are not supported by them.

### 1.3 Units of independent information, and what "sparse" means here

- **Comfort, pleasantness, visual-comfort and PRS ratings were asked once per phase.** Every 10-s row in a bout repeats the same rating (at most one distinct value per bout). The 2,112 ten-second rows therefore give **44 phase ratings from 11 people**, not 2,112 ratings. Every comfort-outcome model below uses 44 phase cells (or 11 participant means), never 10-s rows.
- Physiological outcomes vary within a bout, so some physiology blocks use sub-bout windows (Biel 2-min windows, Kraus 5-min interval, Moshammer 5-min/3-min split). These windows are serially correlated repeated observations, not new people.
- Tram adds another repeated condition, not new participants. These observations permit model fitting. They do not turn 11 people into 44 or 55 independent people. The headphone experiments cannot be reconstructed, because temperature and route travel together. Short recordings also prevent several source lag/window analyses. Statistical significance is not a data-sufficiency certificate.
- **Continuous predictors versus thresholds.** A continuous predictor uses all 44 cells when it varies within people. Across the 44 core cells, the share of predictor variance that lies within persons is 0.89 for dBA, 0.81 for the vehicle-vs-rural share and 0.57–0.91 for the eight class proportions. Median splits of encodings 2–4 give about 22/22 cells, with 9–11 people having both levels. A fixed published threshold can instead leave almost no data on one side. **"Sparse" in this guide is not a universal minimum.** It means that a specific contrast is supported by so few cells or people (for example 0–3) that the coefficient is unidentifiable or rests on one or two people.
- Corridor and the YAMNet label are tied to temperature: when each person's own phases are split into cooler and warmer by air temperature, corridor gives cooler 21 green + 2 urban and warmer 1 green + 20 urban. The YAMNet phase label gives cooler 16 nature / 7 traffic and warmer 5 / 16. That does not remove the 11-person corridor contrast, but nature-versus-traffic **within** a thermal stratum has only 1–3 people with both levels (Pigliautile and Chiucchiù below).

### 1.4 Results by sound representation — checked 8 November 2026

These are **H4 results from the four active phases**, read from the [official results CSV](../output/statistical_analysis/results/H4_sound_literature_test/H4_sound_literature_tests.csv). They are not the H5 combined-exposure tables. Phase averaging describes the observation unit; it is not another sound representation. No tests were rerun for this document edit. Model definitions and data support remain in §3.

**1. Recorded dBA.** The following are all six direct dBA coefficient rows passing their stated FDR families in the core catalogue. Temperature-only coefficients and other covariates from dBA models are excluded.

| Implemented source adaptation | Outcome | β [95% CI] | p | q |
| --- | --- | ---: | ---: | ---: |
| Rodrigues adaptation | Minimum wrist skin temperature (°C) | +0.874 [+0.580, +1.168] | 5.53e-09 | 8.30e-08 |
| Gao adaptation | PRS fascination | -0.365 [-0.625, -0.104] | 0.00775 | 0.00969 |
| Gao adaptation | PRS being away | -0.593 [-0.958, -0.227] | 0.00244 | 0.00705 |
| Gao adaptation | PRS scope | -0.503 [-0.834, -0.171] | 0.00423 | 0.00705 |
| Gao adaptation | Mean of four PRS subscales | -0.314 [-0.512, -0.116] | 0.00297 | 0.00705 |
| Xu adaptation | Acoustic comfort | -0.378 [-0.702, -0.054] | 0.0236 | 0.0236 |

Rodrigues uses one SD of **trip-maximum dBA**; its response is minimum wrist temperature. Gao and Xu use one SD of **phase-aggregated dBA**; their coefficients are score points. Gao's sound main effects are evaluated at mean UTCI in the interaction model: higher dBA accompanies lower values on three PRS subscales and their four-subscale mean. These related outcomes are not four independent discoveries; coherence does not pass FDR (q=.222). Xu's association is thermally unadjusted. None establishes a causal sound effect or a physiological discomfort score.

**2–4. Corridor and classifier representations.** To make these interpretable, the next table holds the outcome and model family fixed: the Chen adaptation of **thermal comfort ~ zUTCI × zRepresentation + participant intercept**. The class-proportion row is a rural/natural example, not a summary of all eight categories; the remaining category and spectrum results remain in the full CSV.

| Representation | Association at mean UTCI | β [95% CI] | p | q |
| --- | --- | ---: | ---: | ---: |
| 2. Green/urban corridor | Urban context associated with lower thermal comfort | -0.392 [-0.614, -0.170] | 0.00112 | 0.00336 |
| 3. Vehicle-over-rural share | Larger exported traffic-share measure associated with lower thermal comfort | -0.321 [-0.523, -0.119] | 0.00293 | 0.0088 |
| 4. Class proportions: rural/natural example | Higher exported `rural_natural_proportion` associated with higher thermal comfort | +0.430 [+0.189, +0.672] | 0.00101 | 0.00303 |

Each β is per one SD of that predictor. For corridor, this is a standardized binary coefficient, **not the full urban-minus-green difference**. The corresponding UTCI interaction does not pass FDR for corridor (q=0.0527), vehicle-over-rural share (q=0.12) or rural/natural proportion (q=0.0682). Thus the supported main associations must not be presented as heat–sound interactions. The known mapping errors in §1.2 prevent interpreting the classifier rows as validated natural/vehicle exposure effects.

**dBA when a class is present:** no such conditional-dBA test/result is implemented in this catalogue. It is a proposed mixture-level calculation (§4), not one of the four representations. Do not describe the tables above as results of that test.

The exported q-values use their existing **paper × test × sound-variable** families (§6); they do not correct across the whole catalogue. In Xu's one-outcome family q equals p. Do not rank representations by their q-values: source blocks and covariate sets differ, and the same participants recur across them. All other tested rows, including nonsignificant results, remain accessible in the linked CSV.

## 2. What does “discomfort” mean here?

| Construct | Exact merged column | Recorded meaning | What it does **not** measure |
| --- | --- | --- | --- |
| Thermal comfort | `questionnaire_thermal_comfort_1_5` | Answer to “Please describe your comfort [Thermal]” | Not hot/cold thermal sensation; not a physiological stress score |
| Acoustic comfort | `questionnaire_acoustic_comfort_1_5` | Answer to “Please describe your comfort [Acoustic (Urban Noise)]” | Not measured dBA and not a subjective loudness/intensity vote |
| Overall/current comfort | `questionnaire_current_comfort_1_7` | Answer to “How comfortable do you feel right now?” | Not acoustic-specific or thermal-specific |
| Physiological response | HR, HRV, tonic EDA, wrist skin temperature | Measured bodily response; outcome and transformation depend on the paper block | Not a direct report of comfort, and not an isolated sound-induced stress measure |

The thermal/acoustic scale is exactly: **1 extremely uncomfortable; 2 very uncomfortable; 3 non comfortable; 4 slightly non comfortable; 5 comfortable.** It is not a bipolar five-point scale with “neutral” at 3. Overall comfort runs from 1 to 7; higher means more comfortable according to the questionnaire framework.

The script models the original comfort scores. It does **not** construct a separate discomfort variable. For a regression on thermal comfort, a negative coefficient means lower reported thermal comfort. An omnibus F-test only establishes some difference between groups; it does not establish a decreasing trend or that higher dBA causes discomfort. Higher skin temperature or altered HRV must be reported as that physiological association, not renamed “discomfort.”

Audit: all **55 thermal + 55 acoustic + 55 overall** phase ratings matched their raw responses and scoring, using participant and within-participant response order. Raw source: `D:/Pranav/docker/Paper3_Github/rawdata/05_questionnaire/Recurring questionnaire.csv`; scoring map: `D:/Pranav/docker/ExpData/scripts/05_questionnaire_build.py`. This checks scores/response identity; it is not a fresh independent audit of phase-schedule assignment. The current analysis input remains the Desktop project's merged CSV.

## 3. Paper by paper: source test, our test, data used

Common to all fitted papers unless stated: input `output/merged_all_11participants_8min.csv`, four core phases (BikeU, WalkU, BikeG, WalkG), 11 participants (P4, P8–P17), one matched 8-min bout per participant-phase (0–480 s, 48 ten-second rows). Row counts are per test row in the results CSV. "Not estimable" tests are listed in the run's `METHODS_NOTES.md` (56 planned tests returned no p value) and are not in the results CSV. **No mode (walk/bike) or phase term** is included unless stated. Without mode adjustment, a pooled sound association may mix within-mode and between-mode patterns; the present fits do not establish how much is attributable to mode.

<!-- Result bullets added 8 Nov 2026 from H4_sound_literature_tests.csv; q is BH within paper × test × sound variable. -->

### 3.1 Moshammer 2019 — outdoor road/park walks

- **Source test:** Cardiovascular measurements every 15 minutes and preceding-period Leq; random-effects GLS, temperature adjustment. Schematic: `Y ~ L_previous15min + Ta + u_i`. Appendix A2 also reports noise-only associations. ECG spans the 15-minute recording period.
- **Our test:** `Y ~ energy_mean_dBA_first5min [+ Ta_outcome_window] + u_i`; Swamy–Arora random-effects GLS / Wald z. Y is mean RR, SDNN, RMSSD, LF or HF **recomputed from native beats in minutes 5–8**. All-phase and walking-only sets are separate. Function: `H4_MOSHAMMER`.
- **Data used:**
  - Unit: one row per participant-phase bout. Exposure is the first 5 min (0–300 s, 30 ten-second rows); outcome is HRV recomputed from native RR intervals in minutes 5–8 (300–480 s).
  - All-phase set: **43 bouts from 11 people** (44 available; one cycling bout fails the beat-quality rule). Walking-only set: **22 bouts from 11 people**.
  - 5 outcomes × 2 specifications (noise only; noise + air temperature) × 2 phase sets × 26 sound variables (dBA, corridor, vehicle-vs-rural share, 8 class proportions, 15 spectral descriptors) = **520 result rows**, 17 with q<.05. The 20 dBA rows have 0 q<.05.
  - Continuous exposure; no thresholds or cell counts.
- **Result:**
  - **dBA, noise-only GLS, all phases:** no q<.05 (lowest p: mean RR +3.37 ms per dB, p=.046, q=.23).
  - **dBA, noise+Ta GLS, all phases:** no q<.05.
  - **dBA, walking-only (noise-only and +Ta):** no q<.05.
  - **Corridor and encoding 3 (all four GLS specs):** no q<.05.
  - **Class/spectral substitutions:** 17 q<.05, none on dBA. All-phase: 250 Hz octave vs SDNN (noise-only q=.014; +Ta q=.031). Walking +Ta examples: urban-positive share vs RR −486 ms (q=.00057); unidentify share vs RR +902 ms (q=.0027). These are exported-label/spectrum associations (§1.2), not calibrated source effects.
- **Fidelity and limits:** **Adapted timing, same model family.** Our imposed non-overlapping 5→3-minute split is not their 15-minute observation design. No blood-pressure/lung-function replication. A sound–cardiac association, not a comfort-vote result. **Mode is omitted from the all-phase fit** (§4); the walking-only set avoids between-mode mixing.

### 3.2 Jin, Jin & Kang 2020 — outdoor squares, respondents standing/sitting

- **Source test:** Two-way ANOVA of measured **5-dB LAeq bands** and **UTCI stress categories**, by season: `rating ~ sound_band * thermal_category`. Thermal/acoustic/overall comfort are seven-point −3…+3; thermal sensation is nine-point −4…+4.
- **Our test:** `TC or OC ~ ParticipantID + quartile(phase_energy_dBA) * quartile(phase_mean_UTCI)`. Participant-blocked Type-II main-effect F-tests; interaction compared with the blocked additive model. TC is our five-point comfort vote; OC our seven-point current comfort. Function: `H4_JIN`.
- **Data used:**
  - Unit: **44 phase cells from 11 people**, one comfort rating per cell (the 48 ten-second rows in a bout share that rating). No missing TC or OC.
  - dBA quartile × UTCI quartile cell counts (sound Q1–Q4 within UTCI T1/T2/T3/T4): T1 4, 4, 1, 2; T2 4, 3, 1, 3; T3 3, 2, 3, 3; T4 0, 2, 6, 3. One cell is empty, so the interaction has 8 rather than 9 numerator df. The tests use F(3, 19) for the main effects and F(8, 19) for the interaction.
  - 2 outcomes × 3 effects × 26 sound variables = **156 rows**, 11 with q<.05. dBA rows: 6, 0 with q<.05. Binary encodings (corridor) use two levels instead of quartiles.
- **Result:**
  - **Sound-level main effect:** dBA not q<.05 (TC p=.115, q=.23). Corridor TC q=.045; encoding-3 TC q=.029; 1000 Hz octave TC q=.015. OC not q<.05 on these.
  - **UTCI-category main effect:** dBA and corridor not q<.05. Encoding-3 TC q=.011; six class/octave substitutions on TC q<.05 (vehicle, mechanisms, urban-negative, 125/1000/2000 Hz octaves); spectral rolloff TC q=.036.
  - **Sound × UTCI interaction:** no q<.05 on any encoding (dBA TC p=.83, q=.88).
- **Fidelity and limits:** **Substantial adaptation:** quartiles replace published physical bands, scales differ, summer only, and 44/55 repeated cells replace the source independent respondent sample. Our ANOVA adds **participant fixed intercepts** for repeated observations; its residual covariance assumptions still apply. AC exists but is not an outcome in this Jin block. Quartile cells hold 0–6 cells each, so the interaction F test is weak.

### 3.3 Biel 2020 — mixed indoor/outdoor daily activity

- **Source test:** Daily and repeated 30-minute personal-noise models. Repeated-window HRV uses the last five minutes of the exposure interval; LMM with participant intercepts **and slopes**, AR(1), Ta, and assessed RH/caffeine/alcohol confounding. Schematic: `g(Y) ~ L + Ta [+ confounders] + participant effects`.
- **Our test:** Phase version: `g(Y_phase) ~ L_phase + Ta [+ RH] + u_i`; RH retained if it changes the noise coefficient ≥10%. Repeated version uses **two-minute windows**, participant intercept and continuous-time AR(1), without random slopes. HR/SDNN/RMSSD raw; LF/HF/LF:HF logged. Effects per exposure IQR. Functions: `H4_BIEL`, `H4_BIEL_REPEATED`.
- **Data used:**
  - Phase version: **44 bouts from 11 people** for all six outcomes.
  - Repeated version: four 2-min windows per bout. HR, SDNN and RMSSD use **176 windows** (44 × 4). LF, HF and LF:HF use **128 windows**, because a 5-min frequency estimate exists only where the full 300 s lies inside the phase.
  - 26 sound variables; 312 result rows in total, 0 with q<.05.
  - Continuous exposure; no thresholds.
- **Result:**
  - **Phase-mean LMM (per IQR, +Ta):** no q<.05 on dBA, corridor, encoding 3, class proportions or spectra. Lowest dBA p: RMSSD +2.93 ms per IQR, p=.49, q=.91.
  - **Repeated 2-min AR(1) LMM (per IQR, +Ta):** no q<.05. Lowest dBA p: HF p=.53, q=.99.
- **Fidelity and limits:** **Adapted sampling/covariance**, not an exact replication. We do not have 30-minute bouts, caffeine/alcohol, or their daily baseline-change design. Frequency outcomes in two-minute blocks are averages of existing five-minute centred HRV-window estimates, **not independently computed two-minute spectral HRV**. Neighbouring 2-min LF/HF values therefore share most of their data. A cardiac response, not perceived discomfort. **No mode term** (same mode confounding as Moshammer all-phase).

### 3.4 Rodrigues 2026 — outdoor walking

- **Source test:** Participant-intercept mixed models of trip physiological summaries; separate **noise** and **temperature** predictor blocks. Noise derives from mapped Lden along routes; weather from daily station summaries. Code block uses maximum/SD noise and maximum/mean temperature. No sound×temperature interaction in these blocks.
- **Our test:** WalkU/WalkG only. `Y_trip ~ z(L_max) + z(L_SD) + u_i`, separately `Y_trip ~ z(Ta_max) + z(Ta_mean) + u_i`. We use personal ten-second dBA/Ta and trip mean/min/max/SD HR/HRV/wrist-temperature summaries. Wald z; source code's rounded-p and absolute-beta rule retained. Function: `H4_RODRIGUES`.
- **Data used:**
  - Unit: **22 walking trips (WalkG + WalkU) from 11 people**, one summary row per trip; 15 trip-summary outcomes. Cycling bouts are excluded by design.
  - Noise block: 15 outcomes × 2 terms (max, SD) × 25 sound variables = 750 rows. Temperature block: 15 × 2 = 30 rows, fitted once. Total **780 rows**, 28 with q<.05; 68 meet the source rounded-p/|β| rule.
  - dBA noise block: 30 rows, 1 with q<.05 (maximum dBA vs minimum wrist skin temperature, +0.874 °C per SD, q=8.30e-8) and 2 meeting the source rule.
  - The 30 corridor rows are **not estimable**: the within-trip corridor SD is zero, making the joint max+SD model singular. Corridor max does vary between green and urban trips; a separate max-only contrast was not fitted.
  - Missing predictor values are set to 0 before scaling (the source `standard_scaler` step).
- **Result:**
  - **Noise max, dBA:** min wrist skin temperature +0.874 °C per SD of trip-max dBA (95% CI +0.580 to +1.168, q=8.3e-8). Other 14 trip summaries not q<.05.
  - **Noise SD, dBA:** no q<.05 (lowest p: min HR p=.070, q=.49).
  - **Noise max/SD, encoding 3:** no q<.05.
  - **Noise max/SD, class/spectral substitutions:** 22 q<.05 among trip HR/HRV/skin-T summaries (CSV). Not dBA and not encoding 3.
  - **Temperature block (no sound term):** 5 q<.05 (max/mean air temperature vs skin-T SD/max and HR SD). This is not a sound result.
- **Fidelity and limits:** **Close predictor/model structure; different exposure measurements.** Personal dBA is not mapped Lden; within-bout temperature is not daily weather. Temperature-block significance is not sound significance. Minimum skin-temperature association is not proof of discomfort. **The noise block has no temperature term** (as in the source), and urban walks are warmer, so the skin-temperature hit may reflect ambient temperature or corridor rather than sound. Wald z relies on a large-sample approximation; its small-cohort calibration has not been established and p-values may be overoptimistic. The source retention rule and our BH q are different decisions (68 rule-met vs 28 q<.05 rows).

### 3.5 Kraus 2013 — mixed daily-life activity, not exclusively outdoors

- **Source test:** Five-minute HR/SDNN/**absolute LF and HF power**/LF:HF models, piecewise Leq at 65 dBA, activity and time trends, participant effects/compound symmetry, lagged outcome and exposure lags up to 15 min. Schematic: `g(Y_t) ~ L_below65 + L_above65 + activity + time + prior_Y [+ HR] + u_i`.
- **Our test:** First complete five-minute interval per bout; only lag0. HR, SDNN, **absolute LF and HF powers**, LF:HF; log all except HR. Same 65 dBA knot, activity categories, AIC-selected time trends, HR adjustment for HRV; random intercept/compound symmetry. Function: `H4_KRAUS`.
- **Data used:**
  - Unit: one 5-min interval per bout. HR and SDNN: **44 intervals from 11 people**. LF, HF and LF:HF: **31 intervals from 11 people**, because a frequency value needs ≥300 beats and a 5-min window inside interval 1.
  - 25 sound variables × 2 piecewise terms × 5 outcomes, minus failures = **248 rows**, 13 with q<.05. dBA: 10 rows, 0 q<.05.
  - 65 dBA knot: at phase level 33 of 44 cells are above 65 dB(A) and 11 below (interval-level values differ slightly), so the below-knot slope rests on fewer cells. Alternatives use a median knot.
  - Not estimable: all 10 corridor rows (singular design) and octave_1000 Hz HF (2 rows, non-convergence).
- **Result:**
  - **dBA, 5 dB below 65:** no q<.05 (HF p=.030, q=.15).
  - **dBA, 5 dB at/above 65:** no q<.05.
  - **Encoding 3, both knots:** no q<.05. Corridor not estimable.
  - **Class/spectral substitutions:** 13 q<.05, all on median-knot models (3 below-median, 10 at/above-median), including rural-natural vs HF below the knot (q=.0083) and several octave/high-band vs HR or SDNN above the knot. Not dBA.
- **Fidelity and limits:** **Corrected and rerun:** absolute LF/HF now match the source outcome type. Eight-minute bouts cannot provide source 15-min lags/prior full intervals; activity is assigned from mode, not source activity diaries. Not a thermal-comfort test. **Under the specified homogeneous covariance model, the participant random-intercept and residual compound-symmetry parameters are not separately identifiable**: only their combined within-participant covariance is identified. Study day varies between people only, so its association is inseparable from other person/day differences in this one-session-per-person design. AIC time-trend selection uses few independent participants.

### 3.6 Korpilo 2024 — randomized visits to nearby forest/beach/park

- **Source test:** Normalized EDA index modelled with **beta/logit GLMM**; walking EDA baseline and environmental/personal predictors. Source NDSI uses **1–2 kHz versus 2–8 kHz**. Source model selection retained effects at alpha **0.10**; Table 2 EDA–NDSI p=0.055.
- **Our test:** `ln(mean tonic EDA) ~ NDSI_proxy + Ta + RH + PhaseID + u_i`; Gaussian REML LMM. Proxy is `(P_2–20kHz − P_0.2–2kHz)/(their sum)`, then averaged by phase. The same model is refitted with each other sound variable in place of the NDSI proxy. Function: `H4_KORPILO`.
- **Data used:**
  - Unit: **44 bouts from 11 people**; tonic EDA is finite on 1,843 of 2,112 ten-second rows, and every bout keeps a phase mean.
  - **26 rows** (NDSI proxy, dBA and 24 alternatives), 0 with q<.05. Corridor is not estimable (aliased with PhaseID).
- **Result:**
  - **NDSI analogue:** no q<.05 (ln tonic EDA β=−2.51, p=.53, q=.53).
  - **dBA substitute:** no q<.05 (β=+0.016 per dB, p=.80, q=.80).
  - **Encoding 3 and the other 23 substitutes:** no q<.05. Corridor not estimable.
- **Fidelity and limits:** **Different index, response and likelihood.** Our bands (0.2–2 vs 2–20 kHz) are not the source 1–2 vs 2–8 kHz. Missing their baseline/index, group/order structure and several covariates; PhaseID is not their source Model-2 specification. Treat as a clearly labelled NDSI-inspired EDA analysis, **not the same GLMM**. Existing p<.05/BH reporting is our rule, not their .10 selection rule.

### 3.7 Pigliautile 2021 — indoor NEXT.ROOM / headphones

- **Source test:** Descriptive comfort comparisons under assigned room temperatures and woodland/street playback; source did not report our inferential tests.
- **Our test:** Paired person means for thermal/corridor/source comparisons; person-mean vote–sound Spearman within cooler/warmer strata. Full-session correlations are canonical Chiucchiù rows. Function: `H4_PIGLIAUTILE`.
- **Data used:**
  - Unit: participant means of phase votes (44 cells → at most 11 pairs). "Cooler" and "warmer" are each person's own phases split by air temperature.
  - Warmer vs cooler on thermal, visual, acoustic and air-quality comfort: **11 pairs**; 4 rows, all q<.05.
  - Nature vs traffic (pleasantness, acoustic comfort) by corridor: **11 pairs**; 2 rows, 2 q<.05. By YAMNet phase label: **9 pairs** (P10 and P16 lack one label); 2 rows, 1 q<.05.
  - Nature vs traffic within a thermal stratum: YAMNet label within warmer, **3 pairs** (2 rows, 0 q<.05); within cooler only 2 people have both labels (**not estimable**). Corridor within cooler 2 people and within warmer 1 person (**not estimable**). Stratum counts: corridor cooler 21 green + 2 urban, warmer 1 green + 20 urban.
  - Stratum Spearman of pleasantness and acoustic comfort against dBA and the 8 class proportions, at cooler and at warmer: 36 rows, **11 person means** per test.
  - In total 46 rows, 7 with q<.05.
- **Result:**
  - **Warmer vs cooler (comfort votes, no sound term):** all 4 q<.05. TC −0.833 (q=.0053); visual −1.000 (q=.0053); AC −1.045 (q=.0053); air-quality −1.242 (q=.0038). Thermal contrast, not sound.
  - **Corridor, nature vs traffic:** pleasantness −1.045 (q=.0015); AC −1.000 (q=.0067). 11 pairs.
  - **Encoding 3 (YAMNet phase label), nature vs traffic:** pleasantness −0.704 (q=.020); AC not q<.05. 9 pairs.
  - **Encoding 3 within the warmer stratum:** no q<.05 (3 pairs). Cooler YAMNet and both corridor-within-stratum contrasts not estimable.
  - **Stratum Spearman vs dBA and 8 class proportions:** no q<.05 (36 rows).
- **Fidelity and limits:** Analyst-added tests inspired by descriptive comparisons, not source inferential replication. No duplicate full-session correlation families; environment contrasts do not isolate sound. The within-stratum nature/traffic comparison is the "sparse" case: corridor and temperature are almost the same split.

### 3.8 Chiucchiù et al. 2026 — indoor NEXT.ROOM / headphones

- **Source test:** Paired physiological means; Spearman among perceptual/personality domains; thermal comparisons within assigned soundscapes.
- **Our test:** Paired HR/EDA/skin-temperature means; Table 5 analogue; full-session independent person-mean vote–sound and domain correlations. Function: `H4_CHIUCCHIU`.
- **Data used:**
  - Paired warmer vs cooler physiology (HR, tonic EDA, skin temperature): **11 pairs**; 3 rows, 1 q<.05 (skin temperature).
  - Domain Spearman (TC vs AC; TC vs pleasantness) and full-session vote–sound Spearman (thermal, pleasantness and acoustic votes vs dBA and 8 class proportions): **11 person means** per test.
  - Table 5 analogue by YAMNet label: within nature **3 pairs**, within traffic **4 pairs**. By corridor: within nature 1 and within traffic 2 people have both thermal levels (**not estimable**).
  - In total 36 rows, 2 with q<.05.
- **Result:**
  - **Paired warmer vs cooler physiology:** skin temperature +1.114 °C (q=.0018). HR −3.51 bpm (p=.15, q=.23) and tonic EDA (p=.28, q=.28) not q<.05.
  - **Domain Spearman:** TC vs AC ρ=0.728 (q=.022). TC vs pleasantness ρ=0.549 (p=.081, q=.081).
  - **Table 5 analogue (YAMNet, warmer vs cooler within nature/traffic):** no q<.05 (lowest: AC within nature p=.035, q=.053; AC within traffic p=.031, q=.061). Corridor analogue not estimable.
  - **Full-session vote–sound Spearman (dBA and 8 class proportions):** no q<.05.
- **Fidelity and limits:** Source TSV paired test not fitted because TSV is absent; its TC substitution would duplicate Pigliautile. No personality/PMV/headphone replication. Person-mean correlations estimate between-person associations, not within-person effects.

### 3.9 Cureau et al. 2022 — outdoor park walks

- **Source test:** Fisher exact associations between comfort-domain survey categories separately by park; additional independent-local-sample tests and multinomial models.
- **Our test:** **Fisher exact test** between TC/AC/visual/OC categories, separately by phase/site analogue; one row per participant within each table. Six domain pairs per phase. Function: `h4_additional_outdoor_tests`.
- **Data used:**
  - Unit: **11 people per phase table** (one phase rating each); no sound variable.
  - BikeU, WalkG and WalkU: 6 pairs each. BikeG: 3 pairs, because every participant rated visual comfort 5 in BikeG and the three visual pairs are **not estimable**. **21 rows**, 0 with q<.05.
- **Result:**
  - **Fisher exact, BikeG:** no q<.05 (lowest: AC vs OC p=.018, q=.055).
  - **Fisher exact, BikeU:** no q<.05.
  - **Fisher exact, WalkG:** no q<.05.
  - **Fisher exact, WalkU:** no q<.05 (lowest: AC vs visual p=.036, q=.16).
- **Fidelity and limits:** **Statistical test matched, sites/sample/scales adapted.** No independent-local-sample Mann–Whitney or full multinomial replication. Association between ratings, **not measured dBA→thermal discomfort**. Eleven ratings per table gives very little power.

### 3.10 Chen et al. 2023 — outdoor sensory walks / stops

- **Source test:** ANOVA of thermal/acoustic/source-type factors and ratings; sphericity assessment and GG/HF corrections. Their repeated factor/source-ranking structure is not reconstructable here.
- **Our test:** Explicitly named **adaptation**: `TC/AC/OC ~ zU * zL + zNaturalShare + u_i`; Gaussian participant-intercept LMM; no source factorial or GG/HF replication. For other encodings, `rating ~ zUTCI * zSound + u_i`. Function: `h4_additional_outdoor_tests`.
- **Data used:**
  - Unit: **44 phase cells from 11 people** for each of TC, AC and OC; all complete. Natural share is the phase mean of `rural_natural_proportion` (P13 BikeG uses 47 of 48 rows).
  - dBA model: 4 terms × 3 outcomes = 12 rows. 10 other encodings × 3 terms × 3 outcomes = 90 rows. **102 rows**, 15 with q<.05; dBA rows 0.
  - Continuous predictors; corridor is a 22/22 binary with all 11 people on both levels.
- **Result:**
  - **dBA model (`zUTCI * zdBA + zNaturalShare`):** no q<.05 on dBA, UTCI, interaction or natural share. Closest: nature_z vs TC +0.291 (p=.020, q=.061).
  - **Corridor sound_z:** TC −0.392 (q=.0034); AC −0.469 (q=.017). OC sound_z not q<.05. UTCI × sound not q<.05 (TC interaction p=.018, q=.053).
  - **Encoding 3 sound_z:** TC −0.321 (q=.0088). AC/OC sound_z not q<.05. UTCI × sound not q<.05.
  - **Class-proportion sound_z:** rural-natural vs TC +0.430 (q=.0030) and vs AC +0.507 (q=.016); mechanisms vs TC −0.326 (q=.018). Other class sound_z and all UTCI × sound terms not q<.05.
  - **UTCI main effects in encoding-3/4 models:** 9 q<.05 (TC/AC), not a measured-sound coefficient.
- **Fidelity and limits:** **Different model.** The change is to use observable continuous exposure variables and account for repeated participants; source source-type ranking is unavailable. Do not call this “Chen's exact equation.” Alternative-encoding TC rows are the canonical fits that Zhen used to duplicate (§6.1). No mode term.

### 3.11 Ueberham et al. 2019 — outdoor cycling

- **Source test:** Spearman objective-versus-subjective **exposure-intensity** comparisons and ordinal regressions.
- **Our test:** **Not fitted:** matching subjective exposure-intensity/loudness items absent.
- **Data used:** **None.** No analysis rows; no result rows. Our AC/TC items are comfort, not exposure intensity.
- **Result:** none (not fitted).
- **Fidelity and limits:** AC/TC are comfort, not exposure intensity. We cannot substitute them and claim replication. Full PDF saved.

### 3.12 Li, Li & Wang 2025 — outdoor greenway walking

- **Source test:** Mobile noise/thermal measurements with **arrival vs departure** questionnaires; subjective loudness (SLV) and ASL; walking-state-dependent ASL→TSV/TCV.
- **Our test:** **Not fitted:** arrival/departure pair and SLV were not collected. First/last minutes of a bout are not their protocol. Function: none.
- **Data used:** **None.** No analysis rows; we have one rating per bout, not an arrival/departure pair.
- **Result:** none (not fitted).
- **Fidelity and limits:** Full PDF now saved. Missing: walking-state questionnaires. Not a reason to copy Jin.

### 3.13 Qin et al. 2024 — Xi’an campus, sound × humidity on TC

- **Source test:** Humidity-stratified LAeq bins (20–40 / 40–60 / 60–80 dB) and RH grades; TSV/TCV vs PET within each humidity × sound cell.
- **Our test:** `TC ~ zSound * zRH + (1|participant)` on all four encodings. Function: `h4_scopus_outdoor_tests`.
- **Data used:**
  - **44 phase cells from 11 people**; TC and phase-mean RH are complete (RH finite on all 2,112 rows).
  - 11 sound variables × 3 terms = **33 rows**, 15 with q<.05 (dBA: 1 of 3).
  - Continuous RH and sound; no bins. Our dBA range (55.86–81.15) covers only the source top bin (60–80) plus a few cells below 60.
- **Result:**
  - **dBA:** RH main +0.497 (q=.00023). Sound_z and sound×RH not q<.05.
  - **Corridor:** sound_z −0.238 (q=.044); RH main +0.380 (q=.0046). Interaction not q<.05.
  - **Encoding 3:** RH main +0.486 (q=.00034). Sound_z and interaction not q<.05.
  - **Class proportions:** 4 sound FDR hits — mechanisms sound_z −0.362 (q=.00050); rural-natural sound_z +0.330 (q=.0018) and sound×RH −0.243 (q=.032). Remaining 8 of 11 enc-4 FDR hits are RH mains, not sound.
- **Fidelity and limits:** **Different X from Jin/Chen (RH, not UTCI).** TSV/PET and 20 dB bins not reproduced. Summer only. No mode term.

### 3.14 Mohammadzadeh, Karimi & Brown 2023 — El Goli park, thermal → acoustic

- **Source test:** Pearson/regression of thermal perception/PET against acoustic quality, loudness and related ratings.
- **Our test:** `AC ~ zUTCI`; `AC ~ TC`; primary `AC ~ zUTCI * zdBA`, all with participant intercepts. Function: `h4_scopus_outdoor_tests`.
- **Data used:**
  - **44 phase cells from 11 people**; AC, TC, UTCI and dBA complete.
  - **5 rows** (1 + 1 + 3 interaction terms), 2 with q<.05; dBA interaction rows 0.
- **Result:**
  - **AC ~ zUTCI:** −0.435 (q=.020). Thermal-to-acoustic, not a sound term.
  - **AC ~ TC:** +0.921 (q=1.8e-6). Vote-on-vote.
  - **AC ~ zUTCI × zdBA:** no q<.05 (lowest: sound_z −0.347, p=.071, q=.071).
- **Fidelity and limits:** AC is the outcome; source SQ/OI/RL/%RNDS and TSV/PET are absent. The primary dBA sensitivity differs from Chen’s primary model by omitting natural share. Alternative-encoding AC interactions are fitted once under Chen.

### 3.15 Gao & Zhu 2025 — greenway restoration

- **Source test:** ROS ~ UTCI and LAeq; two-way ANOVA of restoration on thermal × acoustic categories; veto-probability of TCV/ACV.
- **Our test:** `PRS-11 subscale or mean ~ zUTCI * zSound + (1|participant)` on four encodings; participant-blocked two-way ANOVA of PRS on dBA × UTCI quartiles. Function: `h4_scopus_outdoor_tests`.
- **Data used:**
  - **44 phase cells from 11 people**; PRS items complete for all 44 cells.
  - LMM: 11 sound variables × 5 PRS outcomes (four subscales, mean) × 3 terms = 165 rows. ANOVA: 5 outcomes × 3 effects = 15 rows, on the same dBA × UTCI quartile cells as Jin (one empty cell; F(3, 19) and F(8, 19)).
  - **180 rows**, 35 with q<.05, all from the LMM (0 among the 15 ANOVA rows; dBA LMM rows 8 of 15).
- **Result:**
  - **LMM, dBA sound_z:** being-away −0.593 (q=.0071); scope −0.503 (q=.0071); mean −0.314 (q=.0071); fascination −0.365 (q=.0097). Coherence sound_z not q<.05. UTCI mains also q<.05 on four PRS scores; UTCI × dBA not q<.05.
  - **LMM, corridor sound_z:** mean −0.471 (q=7.3e-5); scope −0.720 (q=9.6e-5); being-away −0.742 (q=.00011); fascination −0.506 (q=.00061). UTCI × corridor not q<.05.
  - **LMM, encoding 3:** no sound_z q<.05. Four UTCI mains q<.05. UTCI × encoding 3 not q<.05.
  - **LMM, rural-natural sound_z:** mean +0.470 (q=.00037); scope +0.717 (q=.00037); being-away +0.708 (q=.0012); fascination +0.416 (q=.012). Other class sound_z not q<.05; remaining enc-4 hits are UTCI mains.
  - **Participant-blocked ANOVA (dBA × UTCI quartiles):** no q<.05 on LAeq level, UTCI category or interaction (lowest: LAeq vs PRS scope p=.021, q=.11).
- **Fidelity and limits:** **Restoration outcome, not TC.** ROS 6-item scale replaced by PRS-11 means. Veto-probability cut not fitted. No mode term.

### 3.16 Wu, Yuan, Xue & Yan 2025 — Zhangjiakou parks

- **Source test:** ANOVA/regression: OCV ~ UTCI + LAeq (+ TCV + ACV); LAeq ≥ 60 dB(A) worsens thermal votes; sound type (natural/human/artificial) × UTCI on TSV.
- **Our test:** `OC ~ zUTCI + zSound`; `TC ~ I(dBA≥60) * zUTCI`; median-split analogue on other encodings. Function: `h4_scopus_outdoor_tests`.
- **Data used:**
  - **44 phase cells from 11 people**; OC, TC, UTCI and dBA complete.
  - Additive OC model: 11 sound variables × 2 terms = 22 rows, 0 with q<.05. Continuous, so all 44 cells contribute.
  - **60 dB(A) threshold: 41 cells ≥60 and 3 cells <60** (P8 WalkG, P8 BikeG, P15 WalkG). Only **2 people** have cells on both sides. The model is fitted (3 rows, 0 q<.05; loud60 estimate +0.68, 95% CI −1.08 to 2.44), but the "below 60" side is three cells from two people, so the fitted contrast has very limited support and wide uncertainty. It is estimable; this is not the same as Xu’s rank-deficient interaction.
  - Median-split analogue on encodings 2–4: 10 encodings × 3 terms = 30 rows, 10 with q<.05. Splits are about 22/22 (23/21 for two), with 9–11 people on both levels.
  - **55 rows**, 10 with q<.05.
- **Result:**
  - **Additive OC ~ zUTCI + zSound:** no q<.05 on dBA, corridor, encoding 3 or class proportions.
  - **TC ~ I(dBA≥60) × zUTCI:** no q<.05 (loud60 +0.68, p=.44, q=.44; interaction p=.21, q=.21). The below-60 side is 3 cells from 2 people.
  - **Median-split analogue, corridor:** loud −0.774 (q=.0011); loud×UTCI −0.526 (q=.018).
  - **Median-split analogue, encoding 3:** UTCI main −0.487 (q=.0052). Loud and interaction not q<.05.
  - **Median-split analogue, class proportions:** rural-natural loud +0.690 (q=.0051). Other 6 q<.05 are UTCI mains (vehicle, urban-negative, urban-neutral, wind, unidentify, rural-natural).
- **Fidelity and limits:** Source TCV/ACV as OCV predictors omitted (vote-on-vote). TSV and winter/transition seasons absent. 60 dB cutoff is theirs, not 65. Our walks are mostly above 60, so this threshold is uninformative here.

### 3.17 Xu et al. 2026 — Xi’an plaza thresholds

- **Source test:** ASV breakpoint 64.8 dB; no significant ACV breakpoint. TCV breakpoint near 29.95 °C did not beat linear (p=.056). Combined high-T/high-sound TCV was 0.63 below additive. **§6.2 uses air temperature >32 °C and sound >65 dB** for that TCV finding. The paper also names a separate combined-stress scenario **T>30 °C + N>65 dB** (TCV = 0.9). Source sample as previously recorded: 975 plaza questionnaires.
- **Our test:** Linear `AC ~ zSound + participant intercept`; source-condition sensitivity `TC ~ I(air_temp_c>32) * I(dBA>65) + participant intercept`, if identifiable. Function: `h4_scopus_outdoor_tests`.
- **Data used:**
  - Linear AC: **44 phase cells from 11 people**; 11 sound variables → **11 rows**, 6 with q<.05 (dBA: 1 of 1). Encodings 2–4 here are our extensions of that linear AC model, not source thresholds.
  - Combined condition, core: cool-quiet **11**, cool-loud **32**, hot-quiet **0**, hot-loud **1** cells (phase-mean air temperature 21.42–32.08 °C; only one cell above 32 °C). **Not fitted; no rows.** An empty cell aliases the factorial coefficients. This is "not identifiable", not a null result.
  - With Tram (55 cells): 11 / 42 / 1 / 1. The two hot cells come from two people (P10 Tram, P13 BikeU). It is fitted in `_tram` only as a very sparse sensitivity.
  - No alternative cutoff was searched. A previous >30 °C / >64.8 dB cut (10 / 27 / 1 / 6) is superseded; it mixed the ASV knot with a different temperature cut and was not used to recover estimability.
- **Result:**
  - **Linear AC ~ zdBA:** −0.378 (q=.024).
  - **Linear AC ~ corridor:** −0.506 (q=.0011).
  - **Linear AC ~ encoding 3:** not q<.05 (−0.135, p=.43, q=.43).
  - **Linear AC ~ class proportions:** rural-natural +0.446 (q=.0063); urban-positive −0.437 (q=.011); urban-neutral +0.370 (q=.028); unidentify +0.369 (q=.036). Vehicle/wind/mechanisms/urban-negative not q<.05.
  - **TC ~ I(air_temp>32) × I(dBA>65):** not fitted in core (empty hot-quiet cell).
- **Fidelity and limits:** No UTCI substitution and no ASV-derived knot on AC. The linear AC model is thermally unadjusted, not a threshold or causal effect. Core interaction unidentifiable; the Tram sensitivity rests on two hot cells from two people. CART/SHAP not reproduced.

### 3.18 Zhen et al. 2025 — Datang plaza

- **Source test:** TSV–UTCI slope / NUTCI by perceived sound type (positive/neutral/negative).
- **Our test:** Unstandardized `TC ~ UTCI * dBA` only. Encodings 2–4 are **not fitted** (they reparameterize Chen `TC ~ zUTCI * zSound`). Function: `h4_scopus_outdoor_tests`.
- **Data used:**
  - **44 phase cells from 11 people**; TC, UTCI and dBA complete. **3 rows**, 0 with q<.05.
  - Encodings 2–4: no rows (duplicates of Chen; see §6.1).
- **Result:**
  - **TC ~ UTCI × dBA, UTCI main:** not q<.05 (p=.42, q=.42).
  - **dBA main:** not q<.05 (+0.134 per dB, p=.40, q=.40).
  - **UTCI × dBA:** not q<.05 (−0.0065, p=.30, q=.30).
- **Fidelity and limits:** TSV absent; NUTCI at TSV=0 not computed. Source sound types were respondent rankings, not YAMNet. Chen’s primary dBA model still includes a natural-share covariate; Zhen dBA does not.

### 3.19 Zhang, Uchiyama & Sato 2026 — parks, Sci Rep

- **Source test:** Ordered logit TCV ~ AcCV × PET; aesthetic satisfaction; acoustic comfort effect on TCV disappears under strong heat.
- **Our test:** `TC ~ zAC * zUTCI + (1|participant)`. Function: `h4_scopus_outdoor_tests`.
- **Data used:** **44 phase cells from 11 people**; TC, AC and UTCI complete. **3 rows**, 2 with q<.05. No measured sound variable.
- **Result:**
  - **TC ~ zAC:** +0.379 (q=.00048). Vote-on-vote, not measured sound.
  - **TC ~ zUTCI:** not q<.05 (−0.192, p=.056, q=.056).
  - **zAC × zUTCI:** +0.232 (q=.0077).
- **Fidelity and limits:** Aesthetic items not collected. Ordered logit → Gaussian LMM. PET → UTCI. Vote×thermal, not measured dBA; both votes come from the same questionnaire.

### 3.20 Zhang et al. 2026 — Jinci Temple, Building Simulation

- **Source test:** Spearman of comfort vs thermal/acoustic by historic-space type; perceived source classed positive/neutral/negative; ENVI-met + CadnaA + HIA.
- **Our test:** Spearman of TC/AC/OC vs dBA within each phase (site analogue). Function: `h4_scopus_outdoor_tests`.
- **Data used:** **11 people per phase** (one cell each), 4 phases × 3 votes = **12 rows**, 0 with q<.05. Each correlation is between-person across 11 values.
- **Result:**
  - **Spearman vs dBA, BikeG:** no q<.05 (TC ρ=−0.06; AC ρ=+0.34; OC ρ=+0.42).
  - **Spearman vs dBA, BikeU:** no q<.05 (TC ρ=+0.18; AC ρ=−0.46; OC ρ=+0.35).
  - **Spearman vs dBA, WalkG:** no q<.05 (TC ρ=−0.29; AC ρ=−0.42; OC ρ=+0.17).
  - **Spearman vs dBA, WalkU:** no q<.05 (TC ρ=−0.10; AC ρ=−0.11; OC ρ=+0.04).
- **Fidelity and limits:** **ENVI-met, CadnaA and HIA not fitted.** Perceived source ranking not collected; YAMNet is not their method.

### 3.21 Jin, Jin & Kang 2020 — chamber (sound types × levels at 0/20/30 °C)

- **Source test:** Assigned headphone files (birdsong, traffic, conversation, dog, dance music) at 0/20/30 °C.
- **Our test:** **Not fitted.**
- **Data used:** **None.** We have no assigned playback or controlled temperature levels.
- **Result:** none (not fitted).
- **Fidelity and limits:** Listed only for context (§11).

### 3.22 Song — park vs city HR/HRV

- **Source test (as recorded in the run's METHODS_NOTES only):** park vs city heart rate/HRV comparison, with no sound level and no thermal term. Not listed in §7; source details were not rechecked in this edit.
- **Our test:** **Not fitted.**
- **Data used:** **None.** No analysis rows.
- **Result:** none (not fitted).
- **Fidelity and limits:** Without a sound or thermal term it does not answer H4.

**No entire source study is replicated exactly.** Some statistical procedures match, but our design/measurements differ. This is not a reason to abandon the data; it determines the claim and the adaptations that must be reported. The direct question “does sound worsen perceived thermal comfort?” uses **TC as outcome**. A physiology model answers a different question.

## 4. Cross-paper limitations of the data used

- **Same data, many adaptations.** Every fitted paper reuses the same 11 people and 44 bouts (22 walking trips for Rodrigues and Moshammer walking-only). Results under different paper labels are not independent replications, and each encoding is a separate adapted hypothesis. Chen/Zhen and Chen/Mohammadzadeh duplicates were removed (§6.1).
- **Potential mode confounding.** Moshammer all-phase, Biel and vote models without mode adjustment can mix within-mode and between-mode associations. Kraus does include a mode-derived activity covariate; Rodrigues and Moshammer walking-only restrict the mode. A mode-driven explanation has not been established by these fits.
- **Temperature–corridor coupling.** Urban bouts are almost always the warmer ones. This affects Rodrigues (noise block without temperature), the Pigliautile/Chiucchiù stratum tests and every corridor contrast.
- **Rodrigues** uses asymptotic Wald z and zero-imputes missing predictors before scaling. Its source retention rule and BH q answer different decision rules; unequal passing counts are not a calculation inconsistency.
- **Kraus** has redundant participant/CS variance parameters under the stated homogeneous specification (§3.5); study day supplies between-person information only.
- **Biel FD windows** are averages of overlapping centred 5-min estimates, so 2-min LF/HF values are not independent spectral measurements.
- **Thresholds.** Wu 60 dB(A) has 3 cells from 2 people below it. Xu >32 °C × >65 dB(A) has an empty cell (not fitted). Jin/Gao quartile cells hold 0–6 cells each.
- **YAMNet mapping** (§1.2): substring matching places 42 classes in more than one category and misroutes some (e.g. Train → Rural/Natural; Traffic noise not in Vehicle). This applies to encodings 3–4 and the Chen natural share; the columns have not been regenerated. YAMNet proportions also cannot be split into a dBA per sound source: only the dBA of 10-s rows in which a class is present (a mixture level) can be computed.
- **Sound-level provenance**: the 10-s dBA is a median, and phase values are energy means of medians, not certified LAeq (§10).

## 5. Differences from the selected source studies and candidate contributions

These bullets identify differences relevant to the selected analysis blocks, not exhaustive summaries of each paper or proof of a gap across the entire field. A different measurement is not automatically a novel contribution or a valid substitute. In particular, different paper labels and standardized versus unstandardized versions do not create independent tests (§6.1).

- **Moshammer 2019:** Studied air pollution as well as noise and cardiovascular/respiratory outcomes; it was not limited to Leq and air temperature. Our selected noise-model adaptation adds source/context representations not used in that selected block.
- **Jin, Jin & Kang 2020 (squares):** LAeq 5 dB bands × UTCI stress categories on standing/sitting respondents. No wearable physiology, no YAMNet/source classifier, no within-person repeated mobility, no humidity×sound term.
- **Jin, Jin & Kang 2020 (chamber):** Assigned headphone files (birdsong, traffic, conversation, dog, dance music) at 0/20/30 °C. Not fitted here. Still no field classifier and no personal dBA on a walked route.
- **Biel 2020:** Studied air pollutants, noise and cardiovascular outcomes in daily activity. Our noise-only adaptation and source-class substitutions are extensions, not a complete reproduction of its pollutant/noise models.
- **Rodrigues 2026:** Mapped Lden and station weather, additive blocks, no interaction, no classifier.
- **Kraus 2013:** Piecewise Leq at 65 dB on 5 min HRV in daily life. No thermal-comfort votes, no source classification.
- **Korpilo 2024:** NDSI from 1–2 vs 2–8 kHz band energy, not a sound-event classifier. Frequency ratio ≠ YAMNet vehicle vs rural_natural.
- **Pigliautile 2021 / Chiucchiù 2026:** Headphone woodland vs street at two room temperatures. No field dBA, no YAMNet, no mobility.
- **Cureau 2022:** The selected Fisher tests concern comfort-domain associations; the source also used other analyses, including multinomial models. Our Fisher block is not a measured dBA effect test.
- **Chen 2023:** Respondent ranking of dominant sources at stops, then RM-ANOVA. Respondent source rankings are not equivalent to classifier-derived proportions.
- **Ueberham 2019:** Subjective loudness/exposure intensity (not collected here). No YAMNet.
- **Li, Li & Wang 2025:** Arrival vs departure + subjective loudness. Not fitted. Mobile ASL is not a classifier.
- **Qin 2024:** LAeq bins × RH grades on TSV/TCV. No source classifier, no YAMNet, no wearable physiology, no repeated within-person mobility design.
- **Mohammadzadeh 2023:** Thermal votes → acoustic quality/loudness. No YAMNet. Plant-community labels are not sound-event classes. No wearable physiology.
- **Gao & Zhu 2025:** ROS vs UTCI/LAeq; LAeq in 5 dB bins. No classifier. Restoration scale is ROS, not PRS-11. No wearable physiology.
- **Wu 2025:** Field-noted natural/human/artificial sound types + LAeq. Those labels are site notes, not YAMNet. No wearable physiology, no class proportions.
- **Xu 2026:** Piecewise/CART/SHAP on 975 plaza questionnaires. No classifier, no YAMNet, no within-person repeated bouts, no wearable physiology.
- **Zhen 2025:** Perceived positive/neutral/negative source type (respondent report). Not YAMNet. TSV–UTCI slopes, no wearable physiology.
- **Zhang, Uchiyama & Sato 2026:** Perceived acoustic comfort and aesthetic satisfaction; PET. Its acoustic models also included measured LAeq and dominant sound type. The vote×thermal interaction selected for our adaptation must not be taken as a complete account of the source models.
- **Zhang et al. 2026 (Building Simulation):** Perceived source classed positive/neutral/negative; ENVI-met/CadnaA. Perception ranking is not YAMNet. No wearable physiology.

## 6. Source papers — open the actual methods

Local PDF links below open the saved source files in this project. The cited sections were checked in earlier passes against the available PDFs/code and helper definitions; **they were not independently re-verified in the 7 November data-used edit**. The formulas above are method reconstructions, not verbatim quotations. Song (§3.22) has no saved source entry here.

| Source             | PDF / primary link                                                                                                                                                                                                                                                                                        | Methods to inspect                                                                                                                                                                                |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Moshammer 2019     | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 Sound literature test/Included - Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf); [DOI](https://doi.org/10.3390/ijerph16050788)                                                     | PDF p4 statistical methods; p6 recording period; Appendix A2                                                                                                                                      |
| Jin 2020           | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2019.106517)                          | PDF p5 Table1 scales; p6–7 procedures/categories; Table5 tests                                                                                                                                    |
| Biel 2020          | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf); [DOI](https://doi.org/10.1038/s41598-020-73412-6)                                                                                 | PDF p8–9 exposure/HRV windows and statistical analysis                                                                                                                                            |
| Rodrigues 2026     | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - The Influence of Urban Context on Emotions and Bodily Responses During Walking.pdf); [DOI](https://doi.org/10.1007/s11524-025-01051-1)                                                                    | Methods/data exposure definitions; authors' `7.Model_H2.py` block mapping recorded in H4 helper. This pass checks our implementation; source-repository identity/version is not newly reverified. |
| Korpilo 2024       | [Full paper, institutional repository](https://pub.epsilon.slu.se/34864/1/korpilo-s-et-al-20240827.pdf); [DOI](https://doi.org/10.1016/j.ufug.2024.128286)                                                                                                                                                | Statistical-analysis Models1/2; Table2. Full text verified via indexed primary-repository extract; direct PDF download returned non-PDF content, not saved as a fake PDF.                         |
| Kraus 2013         | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf); [Full text](https://pmc.ncbi.nlm.nih.gov/articles/PMC3672128/)         | Methods, five-minute windows, activity/time adjustment, 65dBA piecewise model and lags                                                                                                            |
| Pigliautile 2021   | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Environmental thermal influence over soundscape perception - a test room experimental campaign involving the psychological and physiological.pdf); [DOI](https://doi.org/10.1088/1742-6596/2042/1/012136) | NEXT.ROOM protocol; Fig3a/3b descriptive comparisons                                                                                                                                              |
| Chiucchiù 2026     | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Anna Laura/Sound - The role of personality in multi-domain environmental perception An occupant-centric approach.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2025.114140)                                                     | PDF p4 §2.4; Table5/Fig7. Physiological paired tests versus subjective/personality analyses are separate.                                                                                         |
| Cureau 2022        | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf); [Full text](https://doi.org/10.1007/s00484-022-02338-7)                                                      | Data-analysis section: Fisher, independent local respondents, multinomial models                                                                                                                  |
| Chen 2023          | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Chen2023_Sensory_walking_thermal_acoustic.pdf); [Full text](https://doi.org/10.3390/f14061161)                                                                                                                    | §§2.5–2.7, sample, stopping protocol, ANOVA and sphericity                                                                                                                                        |
| Ueberham 2019      | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Ueberham2019_Cyclists_multiple_environmental_exposures.pdf); [Full text](https://doi.org/10.3390/su11051412)                                                                                                      | Objective/subjective exposure comparison, route means, ordinal regressions                                                                                                                        |
| Li 2025            | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Li2025 - autumn greenway noise thermal walking.pdf); [DOI](https://doi.org/10.1007/s00484-024-02790-7)                                                                                                    | Arrival/departure + SLV protocol; not fitted                                                                                                                                                      |
| Qin 2024           | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Qin2024 - sound humidity outdoor thermal comfort cold regions.pdf); [DOI](https://doi.org/10.1016/j.uclim.2024.101967)                                                                                    | Humidity grades, LAeq bins, TSV/TCV vs PET                                                                                                                                                        |
| Mohammadzadeh 2023 | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Mohammadzadeh2023 - thermal on acoustic comfort urban parks.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2022.109884)                                                                                   | Pearson TSV/TCV/PET vs acoustic quality; reverse arrow                                                                                                                                            |
| Gao 2025           | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - GaoZhu2025 - thermal-acoustic psychological restoration greenways.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2025.113269)                                                                             | ROS ANOVA/regression; veto probability                                                                                                                                                            |
| Wu 2025            | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Wu2025 - thermal acoustic overall comfort cold-region parks.pdf); [DOI](https://doi.org/10.1016/j.enbuild.2025.116329)                                                                                    | OCV regression; LAeq ≥ 60 dB; sound-type × UTCI                                                                                                                                                   |
| Xu 2026            | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Xu2026 - threshold thermal-acoustic urban public spaces.pdf); [DOI](https://doi.org/10.1007/s10668-026-08213-4)                                                                                           | Piecewise 64.8 dB; CART/SHAP (not fitted)                                                                                                                                                         |
| Zhen 2025          | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Zhen2025 - plaza OTC thermoacoustic Datang.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2024.112327)                                                                                                    | TSV–UTCI / NUTCI by perceived sound type                                                                                                                                                          |
| Zhang 2026 SciRep  | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - ZhangUchiyamaSato2026 - thermal acoustic aesthetic parks.pdf); [DOI](https://doi.org/10.1038/s41598-026-39787-8)                                                                                          | Ordered logit TCV ~ AcCV × PET; aesthetics omitted                                                                                                                                                |
| Zhang 2026 BSim    | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Zhang2026 - historic spaces thermoacoustic Building Simulation.pdf); [DOI](https://doi.org/10.1007/s12273-026-1507-z)                                                                                     | Spearman by site; ENVI-met/CadnaA not fitted                                                                                                                                                      |
| Jin 2020 chamber   | [Local PDF](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/Sound_evidence/Sound - Jin2020 - sound types sound levels seasons chamber.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2020.107215)                                                                                            | Headphone sound-type × level at 0/20/30 °C; not fitted                                                                                                                                            |

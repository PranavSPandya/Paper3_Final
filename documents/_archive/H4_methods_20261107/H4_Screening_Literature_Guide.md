# H4 screening: published evidence and study-specific choices

Corrected 8 October 2026 against Paper3_Analysis/scripts/H4_multivariate.R. The earlier claims that literature mandates bilateral fusion, eliminates body shielding, excludes every infrared channel, or selects exactly one predictor per domain are withdrawn: no verified support for those claims was established.

## Step 1: roles and design

The independent sampling units are 11 participants, with four repeated H4 routes giving 44 participant-phase cells. The 2,156 matched epochs are not independent subjects. Separate outcomes, environmental exposures, movement, metadata and QC. LYS movement is a covariate candidate; lux_cat is a derived light category, not an extra continuous illuminance measure.

## Step 2: actual measurements and availability

Six study averages are implemented: Atmotube PM1/PM2.5/PM10 from left/right researcher devices, and LYS lux/MEDI/Kelvin from participant LYS1 and researcher LYS2. Only 12 raw columns feed these averages. The other 22 comprise four temperature/humidity, two movement, two lux-category and 14 RGB/IR/r'/g'/b' channels.

Averaging does not prove correction of placement bias. Averaging LYS devices on different people is an unresolved personal-exposure limitation, not a CIE-mandated procedure. Colour channels require documented units/calibration and a specific exposure hypothesis; they are not claimed to be replaced by lux.

Active declared representation policy: exclude UCM _S/_SR and IR; use unsuffixed UTCI, TWS for wind, AIR_RH rather than AH, AIR_temp rather than temperature tiers, and GVI50m for vegetation. SVF_Holmer represents sky openness, not vegetation. dBA is the core sound-level measure; frequency and semantic source-type remain separate secondary analyses. IO_flag does not enter the exposure funnel. These are stated measurement/analysis choices, not universal literature mandates or evidence that distinct constructs are interchangeable.

All eight SVF/scene exposures remain planned H4 candidates. Current coverage is a temporary processing/merge status, NOT a permanent scientific exclusion. At this audit they have 48 finite 10-second rows in P9 WalkG only; broader completed runs will be reassessed automatically after merging. A within-person effect cannot yet be estimated from one observed phase. The merger skips pilot/PARTIAL files rather than treating them as completed runs.

Updated preferred faceted PDF: 78 displayed inventory fields ->20 observed eligible representatives ->5 existing model variables ->5 VIF-retained. SVF_Holmer is additionally shown as planned, awaiting completed merging, not permanently excluded. The full audit has24 observed Step2 fields because four raw Atmotube humidity/temperature channels are inventoried but hidden from this averages-only figure. Frequency/type outputs remain available separately. The reduced five-variable model is unchanged and must not be described as the result of automatic screening of all20.

## Earlier merged-only screening comparison (superseded by declared Step2 policy)

This supersedes the earlier 68/72-candidate pair-pruning diagnostic. Executed existing `Paper3_Analysis/temp/h4_preselection_audit.R`, reading only `output/merged_all_11participants_8min.csv`; the former H4 configuration, manually chosen averages and five-name shortlist are not imported. One consolidated output: `temp/h4_preselection_audit.html`. Production outcome models and figures are unchanged.

1. Inventory every one of 202 source columns. There are 85 environmental measurement fields: 76 eligible numeric within-person-varying measurements, eight SVF/scene fields pending broader completed merging, and one nonnumeric clearness descriptor. Fifteen auxiliary colour/IR/formula channels are tested in a separate inclusive sensitivity pool, not silently erased.
2. Summarize finite exported observations to participant-phase means; circular directions use phase-mean sine/cosine pairs. These are descriptive summaries, not recalculated raw-sensor LAeq. Freeze common complete observations and re-center within participant. No imputation or outcome associations enter screening. LYS1/LYS2 and left/right Atmotube channels remain separate; averaging distinct placements is not presumed valid.
3. Compare hierarchical correlation clustering with a central representative per cluster, using highest mean squared association within that cluster and alphabetical exact ties. Pearson/Spearman average linkage uses maximum average silhouette to choose cluster count; Pearson complete linkage at 0.7/0.8 provides threshold sensitivity. [Dormann et al. 2013](https://doi.org/10.1111/j.1600-0587.2012.07348.x) supports comparing clustering/representative approaches; [Rousseeuw's silhouette criterion](https://stat.ethz.ch/R-manual/R-devel/library/cluster/html/silhouette.html) supports assessing separation. The exact combination and grouped canonical correlation for directions are disclosed implementation adaptations, not a universal protocol.
4. Sequentially remove the highest exposure VIF/GVIF-scale term and recalculate, protecting Mode and movement. Compare cutoffs 3 and 5. [Zuur et al. 2010](https://doi.org/10.1111/j.2041-210X.2009.00001.x) describes iterative VIF removal; [Fox and Monette 1992](https://doi.org/10.1080/01621459.1992.10475190) supports joint GVIF. Applying variance-scale GVIF^(1/df) thresholds to circular pairs is an explicit adaptation. Rank-deficient designs stop, with no false final formula.
5. Independently compare standardized PCA of the whole eligible pool: [Jolliffe and Cadima 2016](https://doi.org/10.1098/rsta.2015.0202). Retain leading components above the 95th-percentile reference from 499 within-participant permutations, seed20261008, keeping angular pairs together. [Horn 1965](https://doi.org/10.1007/BF02289447) and [Glorfeld 1995](https://doi.org/10.1177/0013164495055003002) support random-eigenvalue/upper-percentile comparisons; this repeated-design null is a declared adaptation, not a validated causal test.
6. Report every cluster member, representative, removal, final variable, rank, covariate flag, PCA loading and leave-participant-out result. No threshold is chosen by a health p-value.

Actual observed sample: 44 phase cells from 11 independent participants; 42 common cells because WIND_TWS is unavailable in P16 BikeU and P17 WalkG. Person-centering leaves 31 within-person contrasts. The whole 76-measurement design has 79 encoded exposure columns and is rank deficient; estimating every original coefficient simultaneously is not identifiable.

| Eligible measured pool | Step 3 clusters | Step 4 measurements at VIF3 | Interpretation |
| --- | ---: | ---: | --- |
| Pearson / average / maximum silhouette | 16 | 11 | Exposure max2.091556; protected max2.273493 |
| Spearman / average / maximum silhouette | 18 | 12 | Includes one circular pair; exposure max2.528952; protected max2.678592 |
| Pearson / complete / r0.7 | 19 | 12 | Exposure max2.465110; protected max2.603823 |
| Pearson / complete / r0.8 | 30 | Not identifiable | Rank deficiency stops VIF pruning |

Reference Pearson/silhouette/VIF3 survivors: LYS1 Kelvin, lux and MEDI; left Atmotube humidity, PM1 and temperature; right Atmotube PM2.5; UCM AH, HUMIDEX_SR, solar altitude and true wind speed. Across all 11 leave-participant-out runs, each survives in 9-11 runs. This is stability of a diagnostic, not proof of causal importance. VIF5 retains14 but protected Mode VIF6.338733 remains flagged.

Why sound/greenery disappeared: the cluster procedure represents most spectral fields by spectral centroid, and dBA by octave125Hz. Subsequent VIF3 removals are MRT13.3207, spectral centroid10.0525, grassGVI4.9994, octave125Hz4.0875 and skyIR3.1470. Strong cross-domain co-occurrence is not physical equivalence: an MRT proxy cannot establish a unique greenery effect, and one octave descriptor cannot establish the dBA effect. Do not present omitted fields as biologically irrelevant.

PCA retains2 components explaining61.81% of measured-pool variance, but adding Mode gives ModeVIF12.0300 and PC2VIF9.1899. Therefore PCA orthogonality alone does not solve covariate collinearity. Six, ten and fourteen components are needed for80%,90%,95% variance respectively; these are descriptive targets, not another outcome-driven selection. Inclusive auxiliary sensitivity uses91 measurements/94 encoded columns, reference18 clusters ->13 measurements; PCA3 explains62.72% with ModeVIF10.9443 still flagged.

[Agier et al. 2016](https://doi.org/10.1289/EHP172) compared regression-based selection/shrinkage approaches with237 exposures and1200 simulated participants. It does not validate fitting dozens of health-effect coefficients in11 participants. [O'Brien 2007](https://doi.org/10.1007/s11135-006-9018-6) cautions against treating VIF cutoffs as automatic validity tests.

Meeting conclusion: the reproducible screening comparison and exact alternatives are available; neither the old five nor this automated11-variable proxy set is automatically a confirmatory H4 model. Choose the estimand explicitly: named exposure associations require measurement/construct decisions, while PCA estimates mixture-pattern associations and needs the Mode-overlap issue addressed. New screening is post-inspection, not preregistered or zero-bias. Broader SVF/scene coverage remains a processing requirement and will be automatically reassessed after merging. Installed stats/car/cluster provide established implementations, not scientific certification.

## Existing Step 3: reduced provisional construct model

The existing reduced set is UTCI, dBA, PM2.5 average, log10(phase-mean LYS-average lux + 1) and 50 m GVI. It is NOT the result of VIF-pruning all available variables. No dated prespecification was located. Alternatives remain available for separately specified diagnostic/substitution analyses; do not choose them by outcome significance.

Published support and limits:
- [Brode et al., 2012](https://doi.org/10.1007/s00484-011-0454-1): UTCI represents outdoor thermal stress integrating meteorological inputs; does not ban component measurements from every model.
- [CIE S 026/E:2018](https://cie.co.at/publications/cie-system-metrology-optical-radiation-iprgc-influenced-responses-light-0): photopic and melanopic light quantify different constructs; MEDI/Kelvin are not subsumed by choosing lux.
- [Dormann et al., 2013](https://doi.org/10.1111/j.1600-0587.2012.07348.x): combine subject knowledge with collinearity diagnostics and acknowledge omitted-variable limitations; does not mandate this shortlist.
- Frequency descriptors and sound categories differ from overall dBA. PM size fractions and vegetation components are also distinct measurements. Their omission from the reduced model is not proof that they are useless or equivalent.
- H4 averages GVI over the phase; it does not estimate instantaneous micro-spatial effects.

Local Hamra/Buckley, Zhu and Hamida papers are background reading, not verified mandates for hardware fusion or an exact one-per-domain rule. The zero-page/unverified Matzarakis/Mayer file cannot support any processing or regression exclusion claim.

## Step 4: diagnostics and cutoff sensitivity

Active exposure-only cutoff: 10. VIFs: UTCI 6.741; dBA 2.098; PM2.5 1.278; logLux 1.359; GVI 8.495. All five are retained. The earlier GVI-removal/VIF13.99 claim is obsolete.

Full design including Mode and PC_Movement: UTCI 7.293; dBA 2.300; PM2.5 1.321; logLux 1.714; GVI 9.097; Mode 1.837; movement 1.132. These values use all 44 exposure-complete cells. Recheck on each outcome's actual fitted sample.

[O'Brien, 2007](https://doi.org/10.1007/s11135-006-9018-6) cautions against universal VIF rules. Passing 10 does not prove independent precision or causality. Cutoff 5 is diagnostic sensitivity; it removes GVI here. Highest-VIF pruning of all UCM measurements does not reproduce the construct shortlist.

Existing Naimi/usdm reading illustrates an algorithm, not a universal gold standard. Enders/Tofighi discusses centering; within-person centering is not within-person SD scaling. Cnaan/Laird/Slasor provides repeated-measures context, and Benjamini/Hochberg provides multiple-testing context; none certifies every fitted model.

## Reporting gate

Actual formula: outcome ~ Mode + PC_Movement + PC_UTCI + PC_dBA + PC_PM25 + PC_logLux + PC_GVI + (1 | ParticipantID).

Continuous and ordinal outcomes need different likelihoods. Review coverage, singularity, convergence, residuals, collinearity and multiplicity before reporting. The current reduced model remains provisional; sound-frequency and SVF effects are not present in its fitted formula. The temporary audit has no production-pipeline dependency.

---

# H4 sound and thermal literature (verified from PDFs)

Purpose: document that Paper 3 H4 sound/thermal methods and claims rest on published work present in `C:\Users\sanga\Desktop\Pranav Paper3_Final\Experiment papers\` (cited as EP\ below). Every number below was re-checked against pdftotext of the PDF. `[pN]` = PDF page. Flagged items are inconsistencies inside a paper or gaps in the text. ASCII only (C for Celsius, x for multiplication).

## A. Sound and thermal together, physiological outcomes

### A1. Wang, Li & Shi 2026, Buildings 16:1389
- **File:** `EP\Sound_evidence\Sound - An Experimental Study on the Effects of Natural Visual and Auditory Stimuli on Human Physiological and Psychological Responses.pdf`
- **Setting:** climatic chamber, Changsha/China (Hunan University).
- **Thermal:** operative temperatures 26 C, 28 C, 32 C.
- **Sound:** natural auditory stimuli (among visual and audio-visual); design uses three stimulus types under each temperature.
- **Participants:** abstract states 24 participants; later body text also refers to recruited students (re-check N if citing). Age not extracted as a single mean from the abstract block.
- **Design / unit:** between conditions (stimulus x temperature); physiological sampling includes HRV, SCL, skin temperature, BP; psychological TSV/TCV/VCV/ACV.
- **Stats:** within-temperature paired comparisons (no formal sound x thermal interaction term stated in the abstract).
- **Key result:** auditory stimuli did not show a clear acoustic-comfort benefit at all temperatures; patterns differed by temperature (benefit absent at 32 C). Exact ACV p-values were non-significant in several temperature cells (paper claims improvement in places where p is NS: inconsistency).
- **Basis:** between conditions.
- **Flag:** claim of auditory improvement vs non-significant ACV results; fixed condition order is a possible confound.

### A2. Yousefinezhad et al. 2026, Scientific Reports
- **File:** `EP\Sound_evidence\Sound - Impact of thermal-acoustic exposure on human performance of healthy adults - simulation of traffic noise and thermal conditions.pdf`
- **Setting:** controlled lab, traffic noise + heat simulation (Iran, Mazandaran University of Medical Sciences affiliation).
- **Thermal:** WBGT = 30.62 C (thermal and combined arms); control = comfort.
- **Sound:** traffic noise 75 dBA (noise-only and combined).
- **Participants:** abstract: 80 healthy participants, mean age 25.3 +/- 2.8 years. Methods: 40 males, 40 females; mean age 26.9 +/- 2.8 years, range 22-28. **Inconsistency: 25.3 vs 26.9.**
- **Design / unit:** crossover; four conditions (control, thermal, noise, combined); RM-ANOVA; one mean per condition.
- **Outcomes:** HR, BP, tympanic and mean skin temperature; cognitive (CPT, n-back).
- **Key results:** core temperature rose during noise (p = 0.008) and combined (p = 0.007); DBP rose under thermal (p = 0.001) and combined (p < 0.001); HR elevated during combined (p = 0.032). Table 2 mapping for noise-only HR vs comfort is unclear (possible p = 0.717). Discussion mentions HRV though HRV was not measured.
- **Basis:** between conditions. No formal interaction term; combined arm is a fourth condition.
- **Flag:** age mismatch; HRV mentioned without measurement; Table 2 header alignment unclear for some rows.

### A3. Bhattacharya, Pradhan, Tripathi & Kashyap 1991, Industrial Health 29:129-138
- **File:** `EP\Sound_evidence\Sound - Human Performance Capability in Psychomotor Tasks at Variable Difficulty Levels and Physiological Reactions under Noise and Heat.pdf`
- **Setting:** climatic chamber, Ahmedabad, India (NIOH).
- **Thermal:** 28 C (comfortable), 35 C (heat).
- **Sound:** white noise 70 dB(A) quiet vs 100 dB(A); ~1.5 h per combination.
- **Participants:** 24 young healthy volunteers, 4 groups of 6; each tested under two combinations.
- **Design / unit:** 2 x 2 ANOVA (noise x heat); between-condition means of HR, BP, body temperature.
- **Key result (verbatim, Discussion):** "noise singly caused elevations to 83.50 beats/min from 78.01 beats/min and heat to 83.95 beats/min from 78.25 beats/min" [p6]. Noise and heat each raised HR independently; HR interaction absent. Systolic BP: interaction significant, main effects NS. Body temperature: heat main effect and noise x heat interaction significant.
- **Basis:** between conditions.
- **Re-verified:** 78.01->83.50 (noise) and 78.25->83.95 (heat).

### A4. Ahmadinejad et al. 2024, JEHSD
- **File:** `EP\Air temp - Effects of music and temperature changes on heart function and human error.pdf`
- **Setting:** acoustic room with HVAC, Iran.
- **Thermal:** 20, 25, 30 C.
- **Sound:** Rock, Rap, Pop, Iranian traditional at 75 dB.
- **Participants:** 14 (7 men, 7 women).
- **Design / unit:** interventional factorial; HR and spelling-error counts per condition.
- **Key result:** traditional and rock music did not significantly affect HR across 20/25/30 C (p > 0.05); errors rose with traditional/rock when temperature was +/-5 C from 25 C (p < 0.05). Conclusion claims a "positive and constructive effect on HR" despite null HR tests: inconsistency.
- **Basis:** between conditions.

### A5. Rodrigues et al. 2026, J Urban Health 103:344-356
- **File:** `EP\Sound_evidence\Sound - The Influence of Urban Context on Emotions and Bodily Responses During Walking.pdf` (byte-identical copy also under `EP\Repeated hotspot exposures and reactivity\Repeated hotspot - Rodrigues et al 2026 J Urban Health Lisbon walks LMM weather.pdf`)
- **Setting:** Lisbon, Portugal; real walking trips.
- **Thermal:** daily IPMA max/mean/min temperature matched by date (not within-city spatial); precipitation likewise.
- **Sound:** Lden noise map, 25 m buffers around GPS tracks (mean/min/max/SD per route).
- **Participants:** 90; 2,207 walking trips.
- **Design / unit:** Empatica E4; HRV (RMSSD, pNN50, mean HR) from **10-s windows**, then summarised per trip; LMM with random intercept for participant.
- **Key pattern:** noise, heat and technical infrastructure associated with higher physiological activation / lower parasympathetic indices in block models; temperature is daily, noise is static map; no UTCI x sound interaction term.
- **Flag:** text describes RMSSD both as slightly higher and as reduced parasympathetic control in places: wording inconsistency. Age not clearly stated as a single mean in the opening pages.
- **Basis:** between trips (route-level summaries), not continuous within-trip sound x thermal LMM.

### A6. Li et al. 2025, BMC Public Health 25:3533
- **File:** `EP\Sound_evidence\Sound - Co-exposure to heat and noise on workers' health - evidence from a large-scale cross-sectional surveillance study in China.pdf`
- **Setting:** Fujian workplaces, China; occupational surveillance 2020-2022.
- **Thermal / sound:** occupational heat and noise co-exposure (categorical exposure from workplace assessments; exact dBA/WBGT cut-points in methods).
- **Participants:** 10,275 manufacturing workers.
- **Design / unit:** cross-sectional; logistic models; RERI for synergy; WBC as inflammation mediator.
- **Key result:** co-exposure associated with multi-system outcomes beyond single exposures; synergistic pattern reported via RERI for selected outcomes (hypertension among them in the abstract framing).
- **Basis:** between workers/conditions (cross-sectional), not time series.

### A7. Chen, Dai, Sun, Lin & Juang 2007, Industrial Health 45:527-534
- **File:** `EP\Sound_evidence\Sound - Evaluation of Auditory Fatigue in Combined Noise, Heat and Workload Exposure.pdf`
- **Setting:** climatic chamber, Taiwan.
- **Thermal / sound / workload:** combined noise, heat and workload; TTS (temporary threshold shift) as auditory fatigue.
- **Design / unit:** chamber factorial; between conditions.
- **Key pattern:** combined stressors increased auditory fatigue relative to single stressors (Taguchi-style combined-effects framing). Exact dBA/C levels: see paper tables.
- **Basis:** between conditions.

## B. Sound and thermal together, perception outcomes

### B1. Jin, Jin & Kang 2020, Building and Environment (DOI 10.1016/j.buildenv.2019.106517)
- **File:** `EP\Sound_evidence\Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf`
- **Setting:** urban squares, Harbin, China; summer and winter field surveys.
- **Thermal / sound:** measured air temperature and traffic noise levels in situ (ranges in paper tables).
- **Design / unit:** subjective acoustic comfort (ACV), thermal and overall comfort; ANOVA for interaction.
- **Key result:** temperature x traffic noise interaction on acoustic comfort in summer; overall comfort interaction in winter (abstract). One winter cell (65-75 dB(A) as "slightly comfortable" ACV) looks odd and should be treated carefully.
- **Basis:** between conditions / survey cells.

### B2. Jin, Ji & Kang 2020, Building and Environment (DOI 10.1016/j.buildenv.2020.107215)
- **File:** `EP\Sound_evidence\Sound - Effects of sound types and sound levels on subjective environmental evaluations in different seasons.pdf`
- **Setting:** lab listening with season-specific thermal context (China).
- **Design / unit:** sound type x sound level within season; separate subject pools per season (no formal cross-season sound x temperature interaction).
- **Key pattern:** summer birdsong improved thermal evaluations; sound type x level effects within season.
- **Basis:** between conditions within season.

### B3. Nagano & Horikoshi (summer), Archives of Complex Environmental Studies 13(3-4) 2001 (as cited from related PDF; confirm imprint on cover if needed)
- **File:** `EP\Sound_evidence\Sound - New index of combined effect of temperature and noise on human comfort - summer experiments on hot ambient temperature and traffic noise.pdf`
- **Setting:** lab, Japan; 29 male students.
- **Thermal:** operative temperatures 27, 30, 33, 36, 39 C.
- **Sound:** 46.8 LAeq (AC noise), 59.2, 73.1, 80.0, 95.4 LAeq (traffic).
- **Key result:** auditory condition affected thermal sensation; combined comfort index proposed. Hot-sensation interaction with noise was the formal test of interest; cold sensation NS for noise in the paired winter paper framing.
- **Basis:** between conditions.

### B4. Nagano & Horikoshi (cool/cold), Applied Acoustics (PDF imprint unclear on first page; treat journal as unverified if imprint missing)
- **File:** `EP\Sound_evidence\Sound - New comfort index during combined conditions of moderate low ambient temperature and traffic noise.pdf`
- **Setting:** lab, Japan; 22 male students; 20 combined conditions (4 temperatures x 5 noises).
- **Key result:** auditory condition significantly affected hot sensation and noise sensation; thermal condition affected noise sensation. Formal interactions on noisy/quiet/auditory discomfort scales.
- **Basis:** between conditions.
- **Flag:** journal name not clearly printed on the PDF first page.

### B5. Pigliautile et al. 2021, J Phys Conf Ser 2042:012136
- **File:** `EP\Sound_evidence\Sound - Environmental thermal influence over soundscape perception - a test room experimental campaign involving the psychological and physiological.pdf`
- **Setting:** test room; psychological and claimed physiological description.
- **Flag:** title promises physiological results; body does not report physiological statistics or measured dBA tables in the extracted pages. Treat as qualitative / perception-focused only.
- **Basis:** between conditions (descriptive).

### B6. Cureau, Domenighini, Pigliautile, Cotana & Pisello 2023, Forum Acusticum (DOI 10.61782/fa.2023.1153)
- **File:** `EP\Sound_evidence\Sound - A multi-domain comfort walk - cross-modal interactions on acoustic perception.pdf`
- **Setting:** urban comfort walks, Perugia, Italy.
- **Design / unit:** multi-domain environmental monitoring + acoustic perception ratings.
- **Key pattern:** cross-modal effects on acoustic perception during walks (descriptive / survey). Exact Ta and dBA ranges in paper figures/tables.
- **Basis:** between conditions / walk segments (descriptive).

### B7. Multi-domain outdoor comfort (s16 PDF; authors/year from PDF header: verify imprint)
- **File:** `EP\Sound_evidence\Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf`
- **Setting:** outdoor multi-domain comfort evaluation.
- **Flag:** air temperature values appear mainly in figures; text extraction did not yield explicit numeric Ta ranges. Include as multi-domain background, not as a numeric thermal x sound effect paper.
- **Basis:** between conditions / sites (descriptive).

## C. Sound and physiology (thermal measured as covariate or not manipulated)

### C1. Kraus et al. 2013, Environ Health Perspect (Augsburg panel)
- **File:** `EP\Sound_evidence\Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf`
- **Setting:** Augsburg, Germany; daily routines; personal noise dosimeter + Holter ECG.
- **Participants:** 110 individuals; 326 ECG recordings; mean duration ~6 h.
- **Sound:** personal Leq; piecewise at 65 dB(A).
- **Thermal:** models adjusted for time trends and activity; temperature as covariate in related Augsburg work (confirm exact covariate list in methods).
- **Design / unit:** 5-min HRV averages; additive mixed models with random participant effect; lags 0 and 5-15 min.
- **Key result:** concurrent +5 dB(A) for Leq < 65 associated with HR +1.48% (95% CI 1.37, 1.60), LF/HF +4.89%, LF -3.77%, HF -8.56%; SDNN +5.74% concurrent but -0.53% to -0.69% at lags 5-15 min [p1].
- **Basis:** continuous time series (5-min epochs, lagged exposure).

### C2. Zhang et al. (Apple Hearing Study), Environmental Health / related imprint on PDF
- **File:** `EP\Sound_evidence\Sound - Association between environmental and headphone noise and heart rate variability - observations from Apple Hearing Study cohort.pdf`
- **Setting:** USA nationwide smartwatch/smartphone cohort.
- **Participants:** stratified samples ~980-1180 per analysis.
- **Design / unit:** 1-min SDNN; distributed lag nonlinear hierarchical Bayesian models over prior 120 min.
- **Key result:** overall SDNN reduction 6.8% (short-term) to 16.0% (long-term) per +10 dB environmental noise; 7.1% to 7.4% for headphone sound [p1].
- **Basis:** continuous time series (1-min SDNN, DLM lags).

### C3. Rink et al. (e-waste), Int J Environ Res Public Health
- **File:** `EP\Sound_evidence\Sound - Heart Rate, Stress, and Occupational Noise Exposure among Electronic Waste Recycling Workers.pdf`
- **Setting:** Accra, Ghana e-waste site.
- **Participants:** 57 workers; up to 24 h noise + HR.
- **Key result:** Spearman rho 0.46 (p < 0.001) noise-HR; mixed-effects: +1 dB -> +0.17 bpm HR (p = 0.01) after covariates [p1]. Time resolution of continuous series ~ minutes (device logging).
- **Basis:** continuous time series within workday.

### C4. Teixeira et al., comparison of five European cities (journal imprint on PDF: check cover)
- **File:** `EP\Sound_evidence\Sound - Does cycling infrastructure reduce stress biomarkers in commuting cyclists - A comparison of five European cities.pdf`
- **Setting:** Oxford, London, Amsterdam, Houten, Groningen; 70 young adults; Smartband stress + noise sensor.
- **Sound:** LAeq,1sec along route.
- **Design / unit:** 1 observation per second; multilevel logistic regression for stressful events.
- **Key result:** higher stress probability in noisier places; segregated paths lower stress than on-street paths [p1].
- **Cites Nunez 2018 as linking high noise to stress while cycling** (see C5 flag).
- **Basis:** continuous time series (1-s).

### C5. Nunez, Teixeira, Rodrigues da Silva, Zeile, Dekoninck & Botteldooren 2018, Sustainability
- **File:** `EP\Sound_evidence\Sound - The influence of noise, vibration, cycle paths, and period of day on stress experienced by cyclists.pdf`
- **Setting:** Sao Carlos, Brazil.
- **Key result (verbatim sense):** high noise raised odds of stress by 4%, uncomfortable vibration by 14%, cycle paths reduced odds by 8%, but **only period of day was significant at 95% CI**; afternoon rush +24% vs morning [p1]. Noise itself was NOT significant.
- **Flag:** Teixeira (C4) cites this paper as showing a noise effect; the paper's own inference says noise was not confirmed at 95% confidence.
- **Basis:** between segments / logistic model on continuous route data.

### C6. Alvarsson, Wiens & Nilsson 2010, Int J Environ Res Public Health 7:1036-1046
- **File:** `EP\Sound_evidence\Sound - Stress recovery during exposure to nature sound and environmental noise.pdf`
- **Setting:** lab, Stockholm University.
- **Participants:** abstract: 40 subjects. Methods: "Forty university students... (24 women and 18 men, mean age = 27..." = 42. **Inconsistency 40 vs 42.** Three later dropped for electrode failure.
- **Sound:** nature vs noisy environments after stressor; SPL controlled across conditions.
- **Outcomes:** SCL (sympathetic), HF HRV (parasympathetic); recovery over time (10-s periods in analysis).
- **Key result:** SCL recovery tended to be faster during nature sound; HF HRV no effect [p1].
- **Basis:** between sound conditions, with within-recovery time series (partial continuous).

### C7. Manohare, Garg, Rajasekar & Parida 2022, Noise Mapping 9:234-248
- **File:** `EP\Sound_evidence\Sound - Evaluation of change in heart rate variability due to different soundscapes.pdf`
- **Setting:** lab listening, stimuli from New Delhi; 25 healthy participants (text also says "averaged across all 24": inconsistency).
- **Sound:** 40 stimuli clustered Loud/Active/Silent; short clips (about 15 s in methods).
- **Key result:** significant SDNN decrease for high noise-sensitivity participants; frequency-domain HRV NS [p1].
- **Flag:** LAeq vs loudness ranking contradiction for some clips; N 25 vs 24; frequency-domain HRV from ~15 s clips is methodologically weak per Task Force window guidance.
- **Basis:** between conditions.

### C8. Sim et al. 2015, Yonsei Med J 56:235-243
- **File:** `EP\Sound - Effects of different noise types on heart rate variability in men.pdf`
- **Setting:** lab, Korea; 40 college men in 4 noise-type groups.
- **Sound:** background 35 dB; traffic/speech/mixed at 45 dB; 1 h exposure.
- **Key result:** only speech noise reduced LF; between-group differences otherwise limited.
- **Basis:** between conditions (within speech group effect).

### C9. Biel et al. 2020, Scientific Reports 10:16703
- **File:** `EP\H1 to H4\H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf`
- **Setting:** Toronto, Canada; outdoor panel; May-Aug 2016.
- **Participants:** 46 adults (33 women, 13 men); mean age 24; 87 visits; mean monitoring 4.9 h.
- **Sound:** personal noise mean **66.9 (sd 3.9) dBA** daily average [p3 Table].
- **Thermal:** temperature mean 23.4 C (sd 3.3); used as continuous covariate in LMMs, not as a manipulated factor.
- **Design / unit:** linear mixed-effects with random subject intercepts; 30-min windows; weighted cumulative exposure lasting up to ~2 h.
- **Key result:** higher 30-min noise associated with lower concurrent SDNN, RMSSD, LF, HF and higher HR and LF:HF; women RMSSD change -8.9 ms (95% CI -11.3 to -6.48) per 8.4 dBA vs men -5.25 ms (-8.37 to -2.13) [p4]. Daily-average noise not associated with same-day endothelial function change.
- **Re-verified:** 66.9 dBA.
- **Basis:** continuous time series (30-min) and daily averages.

### C10. Chang et al. 2015, Environmental Research 140:634-640
- **File:** `EP\Short-term exposure to noise, fine particulate matter and nitrogen oxides on ambulatory blood pressure A repeated-measure study_similar.pdf`
- **Setting:** Taiwan; 66 adults (33 M, 33 F), ages 18-32; 24-h ambulatory BP + personal noise.
- **Key result:** current noise +5 dBA associated with SBP +1.44 (1.16, 1.71) and DBP +1.40 (1.18, 1.61) mmHg after joint adjustment with PM2.5 and NOx [p1].
- **Note:** this is BP, not HRV; daily noise associations with BP/HR/RHI in other panels can be null (do not conflate).
- **Basis:** continuous ambulatory time series.

### C11. Hamida, D'Amico, Eijkelenboom & Bluyssen 2024, Indoor Environments 1:100066
- **File:** `EP\H1 to H4\H2 & H4 - Hamida et al 2024 - Guidance to investigate university students' bodily responses and perceptual assessments in sound exposure experiments.pdf`
- **Setting:** lab sound-exposure guidance study, TU Delft / Sapienza; 15 students.
- **Sound:** four sound conditions; wearable AL, MRL, HR, RR.
- **Key result:** "Bodily responses showed no strong nor significant correlations with perceptual assessments" [p2]. HR rose in 6 students with low-frequency hearing loss under LF sound.
- **Basis:** between conditions.

## Effect summary (for H4 framing)

- **(a) Sound effect between conditions:** A1, A2 (within-condition contrasts), A3, A5 (between trips), A6, A7, B1-B4, C6, C7, C8 (speech group).
- **(b) Sound effect in a continuous time series:** C1, C2, C3, C4, C9, C10; C6 partial (sound x recovery time). None of these modelled thermal x sound in continuous time.
- **(c) Thermal x sound interaction (formal):** B1 (ACV summer; overall comfort winter), B3 (hot sensation), B4 (noisy/quiet/auditory discomfort), A3 (systolic BP and body temperature, not HR), A6 (RERI). Pattern/claim only: A1, A2, A7, B5. **None in continuous time series.**
- **(d) No / null sound effect (selected):** A4 HR; A2 between-condition HR (unclear); C5 noise (NS at 95%); C6 HF HRV; C7 frequency-domain; C11 bodily-perceptual correlations; B3/B4 cold or hot sensation nulls as stated.

## Methods support for Paper 3 H4 (verified in EP\ PDFs)

Each entry cites a PDF that exists under `C:\Users\sanga\Desktop\Pranav Paper3_Final\Experiment papers\`.

1. **Linear mixed models with random intercept per participant.** Biel 2020 [p1, p4-5]: LMMs with random subject intercepts for noise/HRV. Kraus 2013 [p2]: additive mixed models with random participant effect. Rodrigues 2026 [p5]: LMMs with random intercepts for participant ID. Cnaan, Laird & Slasor 1997 (`EP\Statistics - Cnaan Laird & Slasor 1997 - GLMM for Unbalanced Repeated Measures.pdf`): GLMM for unbalanced repeated measures.
2. **Within-participant (within-cluster) centering.** Enders & Tofighi 2007 (`EP\Statistics - Enders & Tofighi 2007 - Centering Predictor Variables.pdf`): centering within cluster (CWC) for Level-1 predictors in MLMs [p1].
3. **Benjamini-Hochberg FDR.** Benjamini & Hochberg 1995 (`EP\Statistics - Benjamini & Hochberg 1995 - Controlling the FDR.pdf`); also `EP\H1 to H4\H1-H4 - Benjamini & Hochberg 1995 - Controlling the FDR.pdf`.
4. **Distributed lags / lagged exposure.** Kraus 2013: noise lags 5-15 min on SDNN [p1]. Zhang (Apple Hearing): DLM over prior 120 min for 1-min SDNN [p1-2]. Biel 2020: weighted cumulative exposure effects lasting up to ~2 h [p4, Fig. 3].
5. **Short physiological epochs.** Rodrigues 2026: HRV from **10-s windows** [p4]. Zhang: **1-min SDNN**. Teixeira: **LAeq,1sec** [p9]. Kraus: **5-min** HRV averages. Task Force 1996 (`EP\Empatica - HRV_task_force_team_europe_1996-1.pdf`): short-term HRV standards; HF needs ~1 min, LF ~2 min, 5-min preferred. Shaffer & Ginsberg 2017 (`EP\Empatica - Duration - An Overview of Heart Rate Variability Metrics and Norms.pdf`): ultra-short norms (HR ~10 s; RMSSD/SDNN longer). Laborde, Mosley & Thayer 2017 (`EP\LMM_transform_evidence\HRV - Laborde Mosley Thayer 2017 - Heart Rate Variability and Cardiac Vagal Tone in Psychophysiological Research Recommendations.pdf`): 5 min recommended; RMSSD tolerates shorter windows than frequency indices.
6. **Repeated measures correlation (rmcorr).** Bakdash & Marusich 2017 (`EP\Presentation\H2_Bakdash_Marusich_2017_Repeated_Measures_Correlation.pdf`); also `EP\H1 to H4\H2 concurdence - Repeated Measures Correlation.pdf`.
7. **UTCI as outdoor thermal index.** Blazejczyk et al. 2012 (`EP\H1 to H4\Equation formation - Blazejczyk et al 2012 - Comparison of UTCI to selected thermal indices.pdf`); Urban et al. 2014 in same folder; Brode et al. already cited in Step 3 of this guide.
8. **YAMNet / sound-event categories.** Hershey et al. 2017 (`EP\YAMNet - Hershey et al 2017 - CNN Architectures for Large-Scale Audio Classification.pdf`); Gemmeke et al. 2017 AudioSet (`EP\YAMNet - AudioSet Gemmeke 2017 - An ontology and human-labeled dataset for audio events.pdf`).
9. **Empatica / ambulatory wrist physiology precedent.** Rodrigues 2026 Empatica E4 ambulatory HRV/EDA/skin temperature [p2, p4]. Biel 2020 personal noise + HRV panel. Validity/HRV-duration PDFs under `EP\Empatica - ...` and `EP\Empatica - Duration - ...` (Baek ultra-short; Task Force; Shaffer).

### Not yet supported by a paper in the Sangarani Experiment papers folder
- **AR(1) residual correlation** for repeated physiological time series: no dedicated PDF located in EP\.
- **Cluster-robust CR2 / Satterthwaite** small-sample inference: no dedicated PDF located in EP\.
- **Bonett 2008 paired standardized mean difference:** no PDF located in EP\.
- **Neale 2022 30-s RMSSD windows:** no PDF located in EP\.
- **Anusha 2018 tonic EDA drift on dry wrist electrodes:** cited in the box-only workbook (see below); PDF not in EP\ on Sangarani.
- **Marins 2014 infrared thermography acclimatisation:** cited in the box-only workbook; PDF not in EP\ on Sangarani. Note: Marins is about infrared imaging rest acclimatisation, not Empatica contact skin temperature.

### Box-only duration/sensor sources (NOT on Sangarani; do not copy)
Folder `C:\Users\sanga\Desktop\Pranav Paper3_Final\Experiment papers\Paper3 Limitations\` does **not** exist on Sangarani. The same material is on the box at `/workspace/Experiment papers/Paper3 Limitations/` including:
- `Du 2014 - Thermal sensation and skin temperature step-change.pdf` - Table 4: mean skin temperature stabilisation times **11-29 min** across the nine stages (down-steps 18-29 min, up-steps 11-18 min; 11 min is the 17-22-17 C up-step) [p5]. Cite as box-only until a Sangarani copy exists.
- `Paper3_Limitations_min_duration.xlsx` - page-ready duration findings (Munoz, Esco, Baek, Task Force, Shaffer, Laborde, Boucsein, Anusha, Marins, Du, Ulrich, Hedblom, etc.).
- Boucsein 2012, Esco 2014, Munoz 2015, Ulrich 1991, Hedblom 2019 and others in that box folder.

Several Empatica Duration / Task Force / Shaffer PDFs **do** exist on Sangarani under `EP\Empatica - ...` and were used above.

## Brussels conditions vs literature

Paper 3 H4 phases: Aug 3-26 2025, ~13:30-15:20, first 8 min per phase, 11 participants.

| Phase | UTCI (C) | Air (C) | dBA |
| --- | ---: | ---: | ---: |
| WalkU | 31.5 | 27.7 | 67.5 |
| BikeU | 26.5 | 27.0 | 71.4 |
| WalkG | 25.0 | 25.3 | 61.6 |
| BikeG | 25.0 | 25.5 | 60.3 |

Urban-green gaps: 5.9 dBA walking, 11.1 dBA cycling; UTCI gap 6.5 C walking, 1.5 C cycling (air-temp gap also 1.5 C).

Compared with literature levels above: Brussels dBA (60-71) sits near Biel's personal mean 66.9 dBA and Kraus's <65 / >=65 split; well below occupational 75-100 dBA arms (A2, A3, A7). UTCI 25-31.5 C is warmer than Biel's covariate mean air 23.4 C and overlaps hot outdoor / chamber ranges used in perception papers (B1-B4) more than cool chamber arms.

**H4 time-series results (do not add phase-mean H4 numbers):** 22 sounds x 26 outcomes, AR1 LMM, CR2, BH FDR over 572 tests: **0 q < 0.05** for sound and for UTCI x sound at 10/30/60/300 s epochs and at lag 30/60 s (10 s and 30 s epochs) and lag 60 s at 60 s epoch.

## Paper-level inconsistencies (checklist)
- Alvarsson: abstract N=40 vs methods 24 women + 18 men (=42).
- Yousefinezhad: mean age 25.3 (abstract) vs 26.9 (methods).
- Nunez 2018: noise not significant at 95% CI, yet Teixeira cites it as a noise-stress finding.
- Bhattacharya numbers: verified 78.01->83.50 (noise), 78.25->83.95 (heat).
- Biel noise: verified 66.9 dBA.
- Wang: auditory-comfort improvement claims vs NS p-values in several cells.
- Ahmadinejad: conclusion claims positive HR effect; HR tests NS.
- Rodrigues: RMSSD wording ("slightly higher" vs "reduced parasympathetic") inconsistent; daily temperature + static noise map; no interaction term.
- Manohare: N 25 vs 24; loudness vs LAeq ranking contradiction; short-clip frequency-domain HRV.
- Pigliautile: physiological results missing despite title.
- Empatica "Stress in the City" PDF in EP\ contains a traffic-sign paper (wrong content).

---
End of H4 sound/thermal literature section. Existing Steps 1-4 and Reporting gate above are retained.

---

## Screening decisions moved from Paper3_outline_ml.md

**Update 2026-11-05:** the current screening is `documents/H4_papers_screened.md` — **five** included (Moshammer, Jin, Rodrigues, Biel, Korpilo); **Song** removed (no sound level and no thermal term, not fitted in `H4_sound_literature_test.R`); **Biel** and **Korpilo** promoted to their own H4 blocks. The numbered list below is the earlier decision record.

**H4 papers screened.** One numbered entry per paper. **Four** included under the thermal-and-sound rule (items 1–4). **Kraus** is marked excluded in `METHODS_NOTES.md` for a missing thermal term and is still run as a separate Leq-slope adaptation (item 5).

1. Moshammer et al. (2019) [Included]:
   - Measured: ambulatory ECG on a road and in a park, personal Leq, air temperature, MET, and blood pressure.
   - Outdoor: present. Sound: present (Leq). Thermal: present (air temperature). Outcome: present (heart rate, HRV, and blood pressure).
   - Reason: Missing: blood pressure in this campaign. Heart rate, HRV, Leq, and air temperature are present, so those terms were tested.
2. Song et al. (2013, 2014) [Included]:
   - Measured: HRV on a park walk and a city-street walk.
   - Outdoor: present. Sound: missing (no dBA). Thermal: missing. Outcome: present (SDNN and RMSSD).
   - Reason: Missing: sound level and a thermal term. Kept only as a two-outcome sensitivity of the Moshammer walk contrast.
3. Jin, Jin and Kang (2020) [Included]:
   - Measured: sound level, UTCI, and thermal and environmental comfort in outdoor squares.
   - Outdoor: present. Sound: present (dBA). Thermal: present (UTCI). Outcome: present (those two comfort items).
   - Reason: Missing: none. Outdoor, dBA, UTCI, and the two comfort items are all present.
4. Rodrigues et al. (2026) [Included]:
   - Measured: trip noise, heat, HRV, EDA, skin temperature, and gaze while walking.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (physiology and gaze).
   - Reason: Missing: none. Outdoor, trip noise, heat, and physiology/gaze are all present.
5. Kraus et al. (2013) [Excluded from the four-paper rule — Leq slope still fitted]:
   - Measured: personal Leq and HRV, with a slope change at 65 dBA. Their model uses activity and time of day.
   - Outdoor: present (daily life). Sound: present (Leq). Thermal: missing in source model. Outcome: present (heart rate and HRV).
   - Reason: Thermal term absent in source; Leq piecewise slopes at 65 dBA are still adapted on field Leq (five HRV outcomes)—not pooled with the four heat-and-noise families above.
6. Mahecha Nuñez et al. (2018) [Excluded]:
   - Measured: a smartband stress event from skin conductance and skin temperature on cycle paths.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (their stress-event score).
   - Reason: Missing: that stress-event score. This campaign has the two signals, not their algorithm.
7. Teixeira et al. (2020) [Excluded]:
   - Measured: the same smartband stress event while cycling in five cities.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (their stress-event score).
   - Reason: Missing: that stress-event score. Same gap as Mahecha Nuñez et al. (2018).
8. Korpilo et al. (2024) [Excluded]:
   - Measured: NDSI from audio and normalized EDA.
   - Outdoor: present. Sound: present (NDSI, not dBA). Thermal: not in the paper. Outcome: present (normalized EDA).
   - Reason: Missing: thermal discomfort. They did not test sound under high thermal discomfort.
9. Burns et al. (2016) [Excluded]:
   - Measured: personal noise and heart rate.
   - Outdoor: present. Sound: present. Thermal: missing. Outcome: present (heart rate).
   - Reason: Missing: thermal term.
10. Tartarini et al. (2023) [Excluded]:
    - Measured: watch sound level and thermal-comfort micro-surveys.
      - Outdoor: present. Sound: present. Thermal: present as a survey. Outcome: missing (no heat–noise test).
      - Reason: Missing: a heat-by-noise test. Sound and comfort surveys are present, with no model that joins them.
11. Schaupp et al. (2025) [Excluded]:
    - Measured: dBA on forest and urban walks, cortisol, an attention test, and questionnaires.
      - Outdoor: present. Sound: present. Thermal: not in the model. Outcome: present (cortisol).
      - Reason: Missing: a thermal term, and cortisol was not collected here.
12. Jafari et al. (2021) [Excluded]:
    - Measured: salivary cortisol under a sound or heat contrast.
      - Outdoor: present. Sound: present in the sound arm. Thermal: present in the heat arm. Outcome: present (cortisol).
      - Reason: Missing: cortisol. It was not collected here.
13. Lan et al. (2024) [Excluded]:
    - Measured: physiology in a park versus an urban setting.
      - Outdoor: present. Sound: missing as a dose. Thermal: present as place climate. Outcome: present.
      - Reason: Missing: a sound-level term. Park versus urban is already the Moshammer walk contrast.
14. Zhang et al. (2026) [Excluded]:
    - Measured: aesthetic and environmental-quality ratings outdoors.
      - Outdoor: present. Sound: present as perception. Thermal: present as perception. Outcome: missing (those scales).
      - Reason: Missing: their aesthetic and environmental-quality items.
15. Lam et al. (2024) [Excluded]:
    - Measured: perceived environmental quality outdoors.
      - Outdoor: present. Sound: present as perception. Thermal: present as perception. Outcome: missing (those scales).
      - Reason: Missing: their perceived-environmental-quality items.
16. Tu et al. (2026) [Excluded]:
    - Measured: a multi-pathway mediation of outdoor exposures.
      - Outdoor: present. Sound: present. Thermal: present. Outcome: present in kind.
      - Reason: Missing: enough cells for their mediation paths. Outdoor, sound, and thermal are present.
17. Li et al. (2026) [Excluded]:
    - Measured: EEG and an odor condition.
      - Outdoor: present. Sound: present. Thermal: present. Outcome: present (EEG and odor).
      - Reason: Missing: EEG and the odor condition. Neither was recorded here.
18. Li, Li and Wang (2025) [Excluded]:
    - Measured: sound level, air temperature, and walking-comfort surveys on a greenway.
      - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (those surveys; no wearable model).
      - Reason: Missing: a wearable outcome. Sound, air temperature, and comfort surveys are present; the comfort test already run is Jin.
19. Li et al. (2025) [Excluded]:
    - Measured: noise or heat with hypertension as the endpoint.
      - Outdoor: present. Sound: present. Thermal: present. Outcome: present (hypertension).
      - Reason: Missing: blood pressure. It was not recorded here.
20. Chen (2007) [Excluded]:
    - Measured: hearing threshold under noise.
      - Outdoor: not a walked route. Sound: present (noise). Thermal: not in the paper. Outcome: present (hearing threshold).
      - Reason: Missing: a thermal term. Hearing threshold was not recorded here.
21. Bidel et al. (2022) [Excluded]:
    - Measured: EMG. This screening note does not have a walked route, a dBA term, or a thermal term for this paper.
      - Outdoor: not in the paper. Sound: not in the paper. Thermal: not in the paper. Outcome: present (EMG).
      - Reason: Missing: a thermal term. EMG is their outcome and was not recorded here.
22. He et al. (2025) [Excluded]:
    - Measured: responses near 90 dB.
      - Outdoor: not this walking exposure. Sound: present, at about 90 dB. Thermal: not in the paper. Outcome: present in the paper.
      - Reason: Missing: a thermal term. These routes do not reach 90 dB.
23. El Aarbaoui et al. (2017) [Excluded]:
    - Measured: personal Leq and SDNN, LF, HF, and LF/HF, adjusted for heart rate and activity.
      - Outdoor: present (daily life). Sound: present. Thermal: missing. Outcome: present (HRV).
      - Reason: Missing: thermal term.
24. El Aarbaoui and Chaix (2020) [Excluded]:
    - Measured: the same Leq–HRV link split by home and transport.
      - Outdoor: present. Sound: present. Thermal: missing. Outcome: present (HRV).
      - Reason: Missing: thermal term. Their contrast is also home versus transport, which these four phases are not.
25. Huang et al. (2013) [Excluded]:
    - Measured: sitting in traffic versus a park; noise as a modifier of the particle effect on HF.
      - Outdoor: present. Sound: present as a modifier. Thermal: missing. Outcome: present (HF).
      - Reason: Missing: thermal term. Noise only modifies the particle effect.
26. Biel et al. (2020) [Excluded]:
    - Measured: personal noise and SDNN, RMSSD, and HF, with air temperature.
      - Outdoor: present. Sound: present. Thermal: present. Outcome: present (those three HRV terms).
      - Reason: Missing: none. The same noise slopes with air temperature are already inside the Moshammer family, which had no raw p < 0.05.
27. Buregeya, Apparicio and Gelb (2020) [Excluded]:
    - Measured: cycling change in heart rate and HRV versus a percent noise dose, in four riders.
      - Outdoor: present. Sound: missing as Leq (percent dose). Thermal: missing. Outcome: present (heart rate and HRV).
      - Reason: Missing: Leq (they use a percent noise dose) and a thermal term.
28. Schnell et al. (2015) [Excluded]:
    - Measured: body-worn noise, CO, and thermal load versus place discomfort.
      - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (place-discomfort rating).
      - Reason: Missing: an HRV outcome. They model place discomfort.
29. Krüger et al. (2025) [Excluded]:
    - Measured: climate walks, skin temperature, and questionnaires, with noise noted near roads.
      - Outdoor: present. Sound: missing as a model term. Thermal: present. Outcome: present (skin temperature and questionnaires).
      - Reason: Missing: a sound term in the model. Noise is only described.
30. Cureau et al. (2022) [Excluded]:
    - Measured: sound level on park walks and comfort surveys.
      - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (survey logistics; no wearable model).
      - Reason: Missing: a wearable outcome. Sound and thermal comfort surveys are present.
31. Franěk et al. (2018) [Excluded]:
    - Measured: walking speed under headphone traffic noise or birdsong.
      - Outdoor: present. Sound: present as headphone playback, not route Leq. Thermal: not in the paper. Outcome: present (walking speed).
      - Reason: Missing: a thermal term and route Leq. Walking speed was not the H4 outcome.
32. Alvarsson et al. (2010) [Excluded]:
    - Measured: skin conductance and HF under played nature sound or traffic noise.
      - Outdoor: missing (laboratory). Sound: present as playback. Thermal: missing. Outcome: present (skin conductance and HF).
      - Reason: Missing: outdoor exposure and a thermal term.
33. Hedblom et al. (2019) [Excluded]:
    - Measured: skin conductance under virtual-reality bird song or traffic noise.
      - Outdoor: missing. Sound: present as playback. Thermal: missing. Outcome: present (skin conductance).
      - Reason: Missing: outdoor exposure and a thermal term. Sound is playback.
34. Cai et al. (2021) [Excluded]:
    - Measured: SDNN, LF/HF, and heart rate at assigned levels from 35 to 65 dBA.
      - Outdoor: missing. Sound: present as assigned levels. Thermal: missing (room held near 25 °C). Outcome: present (heart rate and HRV).
      - Reason: Missing: outdoor exposure and a thermal term. The room was held near 25 °C.
35. Barros et al. (2025) [Excluded]:
    - Measured: skin conductance, heart rate, and HF while auralized traffic changed.
      - Outdoor: missing. Sound: present as playback. Thermal: missing. Outcome: present (skin conductance, heart rate, HF).
      - Reason: Missing: outdoor walked Leq and a thermal term. Sound is indoor playback.
36. Yousefinezhad et al. (2026) [Excluded]:
    - Measured: heart rate and body temperature under assigned heat and 75 dBA.
      - Outdoor: missing (laboratory). Sound: present as an assigned level. Thermal: present as assigned heat. Outcome: partly present (heart rate and skin temperature; blood pressure is missing).
      - Reason: Missing: outdoor exposure. Heat and 75 dBA were assigned in a laboratory.
37. Chiu et al. (2021) [Excluded]:
    - Measured: wind-turbine low-frequency noise and SDNN, with ambient temperature.
      - Outdoor: partly (home sites). Sound: missing (not route A-weighted Leq). Thermal: present. Outcome: present (SDNN).
      - Reason: Missing: route A-weighted Leq. Their sound is residential low-frequency wind-turbine noise.
38. Li et al. (2023) [Excluded]:
    - Measured: HRV, skin conductance, and weather on a planned route chosen to be quiet.
      - Outdoor: present. Sound: missing. Thermal: present. Outcome: present (HRV and skin conductance).
      - Reason: Missing: a sound term. The route was chosen to be quiet.
39. Temperature and vehicle flow (2021) [Excluded]:
    - Measured: how air and pavement temperature change noise emitted by traffic.
      - Outdoor: present (roadside). Sound: present as an emission. Thermal: present. Outcome: missing (no person).
      - Reason: Missing: a person-level outcome. The paper models emitted traffic noise.

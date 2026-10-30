# H4 screening: published evidence and study-specific choices

Corrected 8 October 2026 against Paper3_Analysis/scripts/H4_multivariate.R. The earlier claims that literature mandates bilateral fusion, eliminates body shielding, excludes every infrared channel, or selects exactly one predictor per domain are withdrawn: no verified support for those claims was established.

## Step 1: roles and design

The independent sampling units are 11 participants, with four repeated H4 routes giving 44 participant-phase cells. The 2,156 matched epochs are not independent subjects. Separate outcomes, environmental exposures, movement, metadata and QC. LYS movement is a covariate candidate; lux_cat is a derived light category, not an extra continuous illuminance measure.

## Step 2: actual measurements and availability

Six study averages are implemented: Atmotube PM1/PM2.5/PM10 from left/right researcher devices, and LYS lux/MEDI/Kelvin from participant LYS1 and researcher LYS2. Only 12 raw columns feed these averages. The other 22 comprise four temperature/humidity, two movement, two lux-category and 14 RGB/IR/r'/g'/b' channels.

Averaging does not prove correction of placement bias. Averaging LYS devices on different people is an unresolved personal-exposure limitation, not a CIE-mandated procedure. Colour channels require documented units/calibration and a specific exposure hypothesis; they are not claimed to be replaced by lux.

Active declared representation policy: exclude UCM _S/_SR and IR; use unsuffixed UTCI, TWS for wind, AIR_RH rather than AH, AIR_temp rather than temperature tiers, and GVI50m for vegetation. SVF_Holmer represents sky openness, not vegetation. dBA is the core sound-level measure; frequency and semantic source-type remain separate secondary analyses. IO_flag does not enter the exposure funnel. These are stated measurement/analysis choices, not universal literature mandates or evidence that distinct constructs are interchangeable.

All eight SVF/scene exposures remain planned H4 candidates. Current coverage is a temporary processing/merge status, NOT a permanent scientific exclusion. At this audit they have 48 finite 10-second rows in P9 WalkG only; broader completed runs will be reassessed automatically after merging. A within-person effect cannot yet be estimated from one observed phase. The merger skips pilot/PARTIAL files rather than treating them as completed runs.

Updated preferred faceted PDF: 78 displayed inventory fields ->20 observed eligible representatives ->5 existing exploratory model variables ->5 VIF-retained. SVF_Holmer is additionally shown as planned, awaiting completed merging, not permanently excluded. The full audit has24 observed Step2 fields because four raw Atmotube humidity/temperature channels are inventoried but hidden from this averages-only figure. Frequency/type outputs remain available separately. The reduced five-variable model is unchanged and must not be described as the result of automatic screening of all20.

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

Meeting conclusion: the reproducible screening comparison and exact alternatives are available; neither the old five nor this automated11-variable proxy set is automatically a confirmatory H4 model. Choose the estimand explicitly: named exposure associations require measurement/construct decisions, while PCA estimates mixture-pattern associations and needs the Mode-overlap issue addressed. New screening is post-inspection exploratory, not preregistered or zero-bias. Broader SVF/scene coverage remains a processing requirement and will be automatically reassessed after merging. Installed stats/car/cluster provide established implementations, not scientific certification.

## Existing Step 3: reduced exploratory construct model

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

Continuous and ordinal outcomes need different likelihoods. Review coverage, singularity, convergence, residuals, collinearity and multiplicity before reporting. The current reduced model remains exploratory; sound-frequency and SVF effects are not present in its fitted formula. The temporary audit has no production-pipeline dependency.

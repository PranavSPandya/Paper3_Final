# Sound variable screening: PCA and VIF

## Data and scope

Input: C:\Users\pandya\Documents\Github\docker\Paper3_Final\output\merged_all_11participants_8min.csv

11 participants, 44 participant-phase groups, 2112 ten-second windows (48-48 per group). The participant is the independent sampling unit; windows are repeated measurements. Use elapsed seconds on the matched input's existing ten-second phase grid; the 480-second endpoint is excluded. Each available window has equal weight. These are descriptive, outcome-independent screening results, not hypothesis tests.

Software: scikit-learn 1.9.0, NumPy 2.4.6, pandas 2.3.3; full SVD is deterministic.

## Candidate variables

- YAMNet proportions: wind_prop, rural_natural_prop, vehicle_prop, urban_manmade_neutral_prop, urban_manmade_positive_prop, urban_manmade_negative_prop, mechanisms_prop.
- YAMNet scores: wind_score, rural_natural_score, vehicle_score, urban_manmade_neutral_score, urban_manmade_positive_score, urban_manmade_negative_score, mechanisms_score.
- Broad frequency bands: freq_prop_20_125, freq_prop_125_1000, freq_prop_1000_4000, freq_prop_4000_8000, freq_prop_8000_20000.
- Octave bands: octave_prop_31_5_hz, octave_prop_63_0_hz, octave_prop_125_0_hz, octave_prop_250_0_hz, octave_prop_500_0_hz, octave_prop_1000_0_hz, octave_prop_2000_0_hz, octave_prop_4000_0_hz, octave_prop_8000_0_hz.
- Spectral descriptors: dominant_frequency_hz, spectral_centroid_hz, spectral_rolloff85_hz.

ucm_SND_dBA is retained separately because it is the calibrated level term already specified in Eq1; PCA does not decide whether to retain it. The nominal category label and unidentify_prop are excluded from candidate selection. YAMNet proportions are overlapping frame-detection proportions, not mutually exclusive compositional parts; YAMNet scores are classifier scores, not calibrated probabilities. Octave-band shares are not treated as a closed composition. Broadband shares form a positive unit-sum composition.

## PCA procedure

Five separate PCAs are fitted with scikit-learn using full singular value decomposition. For scores, overlapping proportions, octave shares, and spectral descriptors, subtract each participant-phase mean and divide by the pooled sample SD of those deviations. For the five broadband shares, apply orthonormal ILR coordinates, subtract participant-phase coordinate means, and use covariance PCA without coordinate-wise SD scaling. This preserves log-ratio geometry. No pseudocounts, imputation, or outcome-based selection are used. Complete cases are selected separately for each variable group.

Retain the smallest number of PCs whose cumulative explained variance reaches 80%. The 80% target is a declared analysis choice, not a universal or validated cutoff. Separate PCAs describe variation within each group and do not establish a common 80% target across all sound variables.

| Group                 |   Variables |   Complete_windows | Transformation                     |   Retained_PCs |   Cumulative_variance_percent |
|:----------------------|------------:|-------------------:|:-----------------------------------|---------------:|------------------------------:|
| YAMNet proportions    |           7 |               2111 | Within-group centering; SD scaling |              5 |                        88.561 |
| YAMNet scores         |           7 |               2111 | Within-group centering; SD scaling |              4 |                        85.256 |
| Broad frequency bands |           5 |               2111 | ILR; covariance PCA                |              2 |                        85.569 |
| Octave bands          |           9 |               2111 | Within-group centering; SD scaling |              4 |                        81.067 |
| Spectral descriptors  |           3 |               2111 | Within-group centering; SD scaling |              2 |                        94.957 |

For each retained PC in order, select the as-yet unselected original variable with the largest absolute Pearson correlation with its scores. This is a PCA-informed heuristic for choosing interpretable variables, adapted from PCA variable-selection approaches; an original variable is not a PC. The representative subset does not inherit the PCs' explained-variance percentage. Weak representative correlations must be reported rather than interpreted as adequate replacement.

Leave one participant out at a time, hold the full-data number of retained PCs fixed, refit all transformations and PCA, and match only the retained components one-to-one by maximum absolute cosine similarity. Recompute candidate correlations using the matched components. Selection fractions and minimum component similarities describe participant-omission stability, not external validation or p-values. Near-equal eigenvalues may make individual-PC representatives unstable.

| Group                 |   PC | Term                         |   PC_correlation |   Participant_omission_selection_fraction |   Minimum_component_similarity | Retained_after_VIF   |
|:----------------------|-----:|:-----------------------------|-----------------:|------------------------------------------:|-------------------------------:|:---------------------|
| YAMNet proportions    |    1 | urban_manmade_positive_prop  |            0.907 |                                     1.000 |                          0.997 | False                |
| YAMNet proportions    |    2 | vehicle_prop                 |            0.697 |                                     0.909 |                          0.995 | True                 |
| YAMNet proportions    |    3 | wind_prop                    |            0.764 |                                     1.000 |                          0.868 | True                 |
| YAMNet proportions    |    4 | mechanisms_prop              |            0.801 |                                     1.000 |                          0.863 | True                 |
| YAMNet proportions    |    5 | rural_natural_prop           |            0.493 |                                     0.909 |                          0.988 | True                 |
| YAMNet scores         |    1 | urban_manmade_positive_score |            0.916 |                                     1.000 |                          0.998 | True                 |
| YAMNet scores         |    2 | urban_manmade_negative_score |            0.743 |                                     1.000 |                          0.998 | True                 |
| YAMNet scores         |    3 | wind_score                   |            0.853 |                                     1.000 |                          0.996 | False                |
| YAMNet scores         |    4 | mechanisms_score             |            0.674 |                                     1.000 |                          0.997 | False                |
| Broad frequency bands |    1 | freq_prop_20_125             |            0.582 |                                     1.000 |                          1.000 | False                |
| Broad frequency bands |    2 | freq_prop_125_1000           |            0.537 |                                     1.000 |                          0.999 | True                 |
| Octave bands          |    1 | octave_prop_2000_0_hz        |            0.825 |                                     1.000 |                          0.999 | True                 |
| Octave bands          |    2 | octave_prop_125_0_hz         |            0.643 |                                     0.909 |                          0.985 | True                 |
| Octave bands          |    3 | octave_prop_8000_0_hz        |            0.630 |                                     0.909 |                          0.983 | True                 |
| Octave bands          |    4 | octave_prop_63_0_hz          |            0.604 |                                     1.000 |                          0.993 | True                 |
| Spectral descriptors  |    1 | spectral_centroid_hz         |            0.956 |                                     1.000 |                          1.000 | True                 |
| Spectral descriptors  |    2 | dominant_frequency_hz        |            0.956 |                                     1.000 |                          1.000 | True                 |

## VIF screening

The fixed Eq1 predictor structure is UTCI * SND dBA + MRT * SND dBA + solar irradiance + SVF + PM2.5 + lux + colour temperature + GVI + sum-coded phase. Add all group representatives, then use the same 2056 complete-predictor rows in every iteration. Center and scale predictors before complete-case selection. VIF is calculated separately for each design column as 1/(1-R-squared), with an intercept in its auxiliary regression. Maximum VIF summarizes these individual values; there is no combined VIF.

While an added sound term has VIF > 5, remove the added term with the highest VIF and recompute. Eq1 terms are never removed. Ties remove the less stable representative, then the later PC, then alphabetical order. There is no desired final variable count and no relaxed threshold to force inclusion.

|   Step | Removed_term                |   VIF_before_removal |   Remaining_terms |
|-------:|:----------------------------|---------------------:|------------------:|
|      1 | freq_prop_20_125            |              117.776 |                16 |
|      2 | urban_manmade_positive_prop |               18.872 |                15 |
|      3 | wind_score                  |                9.628 |                14 |
|      4 | mechanisms_score            |                5.656 |                13 |

Final full-design maximum VIF: 3.022 (ucm_UTCI); full rank including intercept: True. This predictor-only check does not establish residual assumptions, convergence, or causality. Actual outcome-specific H4 designs need their own rank and VIF checks because their available rows can differ.

| Term                         |   Initial_VIF |   Final_VIF |
|:-----------------------------|--------------:|------------:|
| PhaseSumBikeG                |         1.507 |       1.507 |
| PhaseSumWalkG                |         1.504 |       1.504 |
| PhaseSumWalkU                |         1.497 |       1.497 |
| SVF                          |         1.452 |       1.446 |
| atmo_pm2.5_avg               |         1.045 |       1.040 |
| dominant_frequency_hz        |         1.170 |       1.163 |
| freq_prop_125_1000           |        80.967 |       2.992 |
| freq_prop_20_125             |       117.776 |     nan     |
| gvi_50m                      |         1.303 |       1.301 |
| lys_kelvin_avg               |         1.066 |       1.063 |
| lys_lux_avg                  |         1.042 |       1.040 |
| mechanisms_prop              |         4.394 |       1.325 |
| mechanisms_score             |         5.898 |     nan     |
| octave_prop_125_0_hz         |         1.207 |       1.180 |
| octave_prop_2000_0_hz        |         4.777 |       2.118 |
| octave_prop_63_0_hz          |         2.238 |       2.178 |
| octave_prop_8000_0_hz        |         1.560 |       1.532 |
| rural_natural_prop           |         1.691 |       1.501 |
| spectral_centroid_hz         |         4.263 |       2.411 |
| ucm_MRT                      |         2.925 |       2.916 |
| ucm_MRT:ucm_SND_dBA          |         2.441 |       2.434 |
| ucm_SND_dBA                  |         1.483 |       1.449 |
| ucm_SUN_Gh                   |         2.959 |       2.955 |
| ucm_UTCI                     |         3.034 |       3.022 |
| ucm_UTCI:ucm_SND_dBA         |         2.431 |       2.426 |
| urban_manmade_negative_score |         1.678 |       1.621 |
| urban_manmade_positive_prop  |        18.950 |     nan     |
| urban_manmade_positive_score |        18.671 |       2.656 |
| vehicle_prop                 |         2.714 |       2.441 |
| wind_prop                    |         9.403 |       1.735 |
| wind_score                   |         9.651 |     nan     |

## Existing H4 specification

Current H4 sound terms: vehicle_prop, freq_prop_20_125, wind_prop, spectral_centroid_hz, mechanisms_prop.

PCA/VIF retained candidates: vehicle_prop, wind_prop, mechanisms_prop, rural_natural_prop, urban_manmade_positive_score, urban_manmade_negative_score, freq_prop_125_1000, octave_prop_2000_0_hz, octave_prop_125_0_hz, octave_prop_8000_0_hz, octave_prop_63_0_hz, spectral_centroid_hz, dominant_frequency_hz.

The sets differ. This script has not changed or refitted H4. The current H4 results must not be presented as results from this screening specification.

The sound model remains a sensitivity analysis. Choosing terms from the current predictors does not validate the classifier, eliminate measurement error, or establish confirmatory inference. Lower VIF and higher explained variance do not imply more significant or less biased health associations.

## References

- Jolliffe & Cadima (2016). Principal component analysis: a review and recent developments. https://doi.org/10.1098/rsta.2015.0202 (PCA and its interpretation; not an exact 80% mandate).
- Jolliffe (1972). Discarding Variables in a Principal Component Analysis. I: Artificial Data. https://doi.org/10.2307/2346488 (PCA-informed original-variable selection; not proof that representatives preserve the retained PCs' variance).
- Egozcue et al. (2003). Isometric Logratio Transformations for Compositional Data Analysis. https://doi.org/10.1023/A:1023818214614 (orthonormal log-ratio coordinates).
- Curran & Bauer (2011). The Disaggregation of Within-Person and Between-Person Effects in Longitudinal Models of Change. https://doi.org/10.1146/annurev.psych.093008.100356 (within-person versus between-person variation; participant-phase centering is this study's extension).
- statsmodels documentation. Variance inflation factor. https://www.statsmodels.org/stable/generated/statsmodels.stats.outliers_influence.variance_inflation_factor.html (per-variable VIF and the conventional threshold of five).

## Outputs

- sound_pca_pc_check.csv: correlations for every original variable and every estimable PC.
- sound_pca_terms.csv: representatives, cumulative sound-set VIFs, and full-design VIFs.
- family_screes.png: individual and cumulative explained variance by group.
- family_biplots.png: original-variable correlations with PC1 and PC2; bold marks group representatives and boxes mark candidates retained after VIF screening.

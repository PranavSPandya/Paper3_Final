# Sound screening: family-wise PCA and VIF

**Status: done.** Family-wise PCA screening finished; Eq2 sound mains locked in `scripts/H4_multivariate.R`. H4 already refit with these terms.

**Read these only** (live PCA folder is wiped each run):
1. This report - `Presentation material/Sound_screening_pca_vif.md`
2. PC check - `.../sound_pca_pc_check.csv` (every Family x PC x Term; `Is_representative=Yes` is the variable chosen for that PC; `Measure` is Loading or Correlation)
3. Terms table - `.../sound_pca_terms.csv` (one row = one PCA survivor; `Kept_in_Eq2=Yes` are the final Eq2 sound mains; `VIF_max_within_this_family_so_far` and `VIF_max_all_rows_above_so_far` are the two cumulative VIF columns)
4. Scree - `.../family_screes.png`
5. Biplots - `.../family_biplots.png` (bold = PCA survivor; boxed = Kept_in_Eq2)

**Eq2 sound mains (locked):** Eq1 + `vehicle_prop` + `freq_prop_20_125` + `wind_prop` + `spectral_centroid_hz` + `mechanisms_prop`. `ucm_SND_dBA` stays in heat x sound. Eqs 1 and 3-7 unchanged.

|   order | column               | family_label          |   PC |   loading_or_corr |   LOPO |
|--------:|:---------------------|:----------------------|-----:|------------------:|-------:|
|       1 | vehicle_prop         | YAMNet proportions    |    2 |             0.564 |  0.909 |
|       2 | freq_prop_20_125     | Broad frequency bands |    1 |             0.630 |  1.000 |
|       3 | wind_prop            | YAMNet proportions    |    3 |             0.746 |  1.000 |
|       4 | spectral_centroid_hz | Spectral descriptors  |    1 |             0.696 |  1.000 |
|       5 | mechanisms_prop      | YAMNet proportions    |    4 |             0.806 |  1.000 |

**VIF:** Eq2 sound-mains max 1.739; full Eq2 design max 2.990 on `ucm_UTCI` (n=2056; full_rank=True). Cutoff 5.

## Method (short)

11 participants, 44 bouts, windows < 480 s. Five family PCAs (YAMNet proportions, YAMNet scores, broad bands, octave bands, spectral descriptors). Within-bout center + pooled-SD scale. Broad bands use ILR when closed and positive; octave composition checked. Retain PCs >=80% variance (no minimum-PC floor). One original representative per PC; LOPO stability; then scientific slots + |r|>=0.7 / VIF prune to 3-5 terms. Excluded from PCA: `category`, `unidentify_prop`, `ucm_SND_dBA`.

## Family summary

| family                |   n | ILR   | PCs       | representatives                                                                                     | closed_composition   |
|:----------------------|----:|:------|:----------|:----------------------------------------------------------------------------------------------------|:---------------------|
| YAMNet proportions    |   7 | no    | 5 (88.6%) | `urban_manmade_positive_prop`, `vehicle_prop`, `wind_prop`, `mechanisms_prop`, `rural_natural_prop` | False                |
| YAMNet scores         |   7 | no    | 4 (85.3%) | `urban_manmade_positive_score`, `urban_manmade_negative_score`, `wind_score`, `mechanisms_score`    | False                |
| Broad frequency bands |   5 | yes   | 2 (84.4%) | `freq_prop_20_125`, `freq_prop_125_1000`                                                            | True                 |
| Octave bands          |   9 | no    | 4 (81.1%) | `octave_prop_2000_0_hz`, `octave_prop_125_0_hz`, `octave_prop_8000_0_hz`, `octave_prop_63_0_hz`     | False                |
| Spectral descriptors  |   3 | no    | 2 (95.0%) | `spectral_centroid_hz`, `dominant_frequency_hz`                                                     | False                |

## Why these five

- Slot traffic: keep vehicle_prop from YAMNet proportions PC2 (LOPO=0.91; scientific priority).
- Slot low_frequency: keep freq_prop_20_125 from Broad frequency bands PC1 (LOPO=1.00; scientific priority).
- Slot semantic_other: keep wind_prop from YAMNet proportions PC3 (LOPO=1.00; scientific priority).
- Slot spectral_shape: keep spectral_centroid_hz from Spectral descriptors PC1 (LOPO=1.00; scientific priority).
- Fill keep mechanisms_prop from YAMNet proportions PC4 (LOPO=1.00).

## Air-temperature alternatives (separate PCA)

Within-bout standardized correlation PCA on `ucm_AIR_temp`, `ucm_AIR_T_bot`, `ucm_AIR_T_top`, `ucm_AIR_T_mid`. Retain PCs to >=80% variance (no minimum-PC floor); one original representative per retained PC (largest |loading|).

**Result:** 1 PC(s), 88.75% cumulative; selected: `ucm_AIR_T_mid`.

Outputs (prefix `air_temp_`): `air_temp_pca_candidates.csv`, `air_temp_pca_variance_explained.csv`, `air_temp_pca_loadings.csv`, `air_temp_pca_scree.png`, `air_temp_pca_loadings_pc1_pc2.png`.

**References:** [Jolliffe & Cadima (2016)](https://doi.org/10.1098/rsta.2015.0202), [Egozcue et al. (2003)](https://doi.org/10.1023/A:1023818214614), [Dormann et al. (2013)](https://doi.org/10.1111/j.1600-0587.2012.07348.x).

Input: C:\Users\pandya\Documents\Github\docker\Paper3_Final\output\merged_all_11participants_8min.csv
SHA-256: `dbe5baa98ecddd311bb18c9710da2e7595a4a733e8866df9be2ad303c627746a`

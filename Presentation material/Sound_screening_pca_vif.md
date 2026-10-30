# Sound screening: family-wise PCA and VIF

**Status: done.** Family-wise PCA screening finished; Eq2 sound mains locked in `scripts/H4_timeseries.R`. H4 already refit with these terms.

**Read these only** (live PCA folder is wiped each run):
1. This report - `Presentation material/Sound_screening_pca_vif.md`
2. PC check - `.../sound_pca_pc_check.csv` (every Family x PC x Term; `Is_representative=Yes` is the variable chosen for that PC; `Measure` is Loading or Correlation)
3. Terms table - `.../sound_pca_terms.csv` (one row = one PCA survivor; `Kept_in_Eq2=Yes` are the final Eq2 sound mains; `VIF_max_within_this_family_so_far` and `VIF_max_all_rows_above_so_far` are the two cumulative VIF columns)
4. Scree - `.../family_screes.png`
5. Biplots - `.../family_biplots.png` (bold = PCA survivor; boxed = Kept_in_Eq2)

**Eq2 sound mains (locked):** Eq1 + `vehicle_proportion` + `freq_proportion_20_to_200Hz` + `wind_proportion` + `spectral_centroid_Hz` + `mechanisms_proportion`. `ucm_SND_dBA` stays in heat x sound. Eqs 1 and 3-7 unchanged.

|   order | column                      | family_label          |   PC |   loading_or_corr |   LOPO |
|--------:|:----------------------------|:----------------------|-----:|------------------:|-------:|
|       1 | vehicle_proportion          | YAMNet proportions    |    1 |             0.585 |  1.000 |
|       2 | freq_proportion_20_to_200Hz | Broad frequency bands |    1 |             0.806 |  1.000 |
|       3 | wind_proportion             | YAMNet proportions    |    3 |             0.781 |  1.000 |
|       4 | spectral_centroid_Hz        | Spectral descriptors  |    1 |             0.696 |  1.000 |
|       5 | mechanisms_proportion       | YAMNet proportions    |    4 |             0.848 |  1.000 |

**VIF:** Eq2 sound-mains max 1.971; full Eq2 design max 2.922 on `ucm_UTCI` (n=2059; full_rank=True). Cutoff 5.

## Method (short)

11 participants, 44 bouts, windows < 480 s. Five family PCAs (YAMNet proportions, YAMNet scores, broad bands, octave bands, spectral descriptors). Within-bout center + pooled-SD scale. Broad bands use ILR when closed and positive; octave composition checked. Retain PCs >=80% variance (no minimum-PC floor). One original representative per PC; LOPO stability; then scientific slots + |r|>=0.7 / VIF prune to 3-5 terms. Excluded from PCA: `category`, `unidentify_proportion`, `ucm_SND_dBA`.

## Family summary

| family                |   n | ILR   | PCs        | representatives                                                                                                         | closed_composition   |
|:----------------------|----:|:------|:-----------|:------------------------------------------------------------------------------------------------------------------------|:---------------------|
| YAMNet proportions    |   7 | no    | 4 (85.9%)  | `vehicle_proportion`, `rural_natural_proportion`, `wind_proportion`, `mechanisms_proportion`                            | False                |
| YAMNet scores         |   7 | no    | 4 (87.8%)  | `vehicle_score`, `rural_natural_score`, `mechanisms_score`, `wind_score`                                                | False                |
| Broad frequency bands |   3 | yes   | 2 (100.0%) | `freq_proportion_20_to_200Hz`, `freq_proportion_200_to_2000Hz`                                                          | True                 |
| Octave bands          |   9 | no    | 4 (81.0%)  | `octave_proportion_2000_0_Hz`, `octave_proportion_125_0_Hz`, `octave_proportion_8000_0_Hz`, `octave_proportion_63_0_Hz` | False                |
| Spectral descriptors  |   3 | no    | 2 (95.1%)  | `spectral_centroid_Hz`, `dominant_frequency_Hz`                                                                         | False                |

## Why these five

- Slot traffic: keep vehicle_proportion from YAMNet proportions PC1 (LOPO=1.00; scientific priority).
- Slot low_frequency: keep freq_proportion_20_to_200Hz from Broad frequency bands PC1 (LOPO=1.00; scientific priority).
- Slot semantic_other: keep wind_proportion from YAMNet proportions PC3 (LOPO=1.00; scientific priority).
- Slot spectral_shape: keep spectral_centroid_Hz from Spectral descriptors PC1 (LOPO=1.00; scientific priority).
- Fill keep mechanisms_proportion from YAMNet proportions PC4 (LOPO=1.00).

## Air-temperature alternatives (separate PCA)

Within-bout standardized correlation PCA on `ucm_AIR_temp`, `ucm_AIR_T_bot`, `ucm_AIR_T_top`, `ucm_AIR_T_mid`. Retain PCs to >=80% variance (no minimum-PC floor); one original representative per retained PC (largest |loading|).

**Result:** 1 PC(s), 88.75% cumulative; selected: `ucm_AIR_T_mid`.

Outputs (prefix `air_temp_`): `air_temp_pca_candidates.csv`, `air_temp_pca_variance_explained.csv`, `air_temp_pca_loadings.csv`, `air_temp_pca_scree.png`, `air_temp_pca_loadings_pc1_pc2.png`.

**References:** [Jolliffe & Cadima (2016)](https://doi.org/10.1098/rsta.2015.0202), [Egozcue et al. (2003)](https://doi.org/10.1023/A:1023818214614), [Dormann et al. (2013)](https://doi.org/10.1111/j.1600-0587.2012.07348.x).

Input: D:\Pranav\docker\Paper3_Final\output\merged_all_11participants_8min.csv
SHA-256: `911a7a15a7be792f62dcd5d29c23389e77c7f4f8659f780719e367fdfe33cd8d`

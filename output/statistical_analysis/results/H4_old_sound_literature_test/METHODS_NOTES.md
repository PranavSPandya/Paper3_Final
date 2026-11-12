# H4_old source-informed product tests
Run UTC: 2026-11-11 20:58:51 UTC
Input MD5: a3c4f9388b61def82e5b97b4232315be
Code MD5: H4_old_sound_literature_test.R 0facb60453f42accbc4da7f8687ec01f
Code MD5: Paper3_common.R bf327b3e8430d19f54d1c3bf27b3a0f8
Code MD5: H4_old_sound_literature_helpers.R c594f1ee480eb3e766ff6716686c0f70

## Purpose
Old H4: exposure to sound amplifies discomfort under thermally uncomfortable outdoor conditions.
Each row is the local product-term test on 22 walking bouts (11 people x WalkG/WalkU).
Assigned laboratory or occupational arms are not available; those papers use a median-split or continuous product analogue.
Nominal p < 0.05. No BH/FDR.

## Papers (amplification only)
- Jin 2020: Type II ANOVA LAeq quartile x UTCI quartile on three comfort votes; continuous fallback if rank-deficient.
- Chen 2023, Li 2025: Y ~ UTCI_z * dBA_z on three comfort votes.
- Wu 2025: I(dBA>=60) x UTCI on overall_comfort (OCV); continuous fallback if the 60 dB split is empty.
- Xu 2026: I(Ta>32) x I(dBA>65) on thermal comfort; continuous Ta x dBA if a 2x2 cell is empty.
- Yousefinezhad, Dehghan: I(UTCI >= median) * I(dBA >= median) on comfort (and heart rate for Dehghan).
- Bhattacharya, Abbasi, Molaeifar: Ta_z * dBA_z on comfort and/or heart rate.
- Tohidi: heart rate ~ Ta_z * dBA_z.
- Not run (thermal-acoustic screen, not amplification): Mohammadzadeh 2023, Gao 2025, Zhen 2025, Tang 2026, Wang 2026.

## Local result
k/n = significant interaction rows / interaction rows fitted for that paper.

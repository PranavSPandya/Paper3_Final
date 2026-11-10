# H4 method adaptation run (documents/H4_papers_screened_final.md sections 0.8 and 3)
Phases: BikeU, WalkU, BikeG, WalkG ; walk-only papers use WalkG, WalkU ; Kraus uses all four core phases; Ueberham uses BikeG, BikeU
Input MD5: a3c4f9388b61def82e5b97b4232315be
Code MD5: H4_sound_literature_test.R ebf4c2ffc9c25d27c8270b2d97424674
Code MD5: Paper3_common.R 7fa3ade8ce9cd75817e27462e0610b42
Code MD5: H4_sound_literature_helpers.R 1f8983485f6df127ead6985d77821cf2
Source PDF MD5: H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf 4d68efe729200a15976f6033e481781b
Source PDF MD5: Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf bcd044129f93e4b9983482e6e3653913
Source PDF MD5: Sound_evidence/Sound - Environmental thermal influence over soundscape perception - a test room experimental campaign involving the psychological and physiological.pdf 986251e01a1932abb717eb875eff08ae
Source PDF MD5: Urban Climate Literature/Sound - Grapas et al 2026 - Urban chronotypes climate vulnerability safety-modulated bioclimatic responses.pdf c5c069fb3ae82e128dce1d781dde856c
Source PDF MD5: H4 Sound literature test/Included - Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf 8eafe01c4f63a1c3b785b49e20713866
Source PDF MD5: Sound_evidence/Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf 8024c3a99f26363ba12d37c54eff2cd2
Source PDF MD5: Anna Laura/Sound - The role of personality in multi-domain environmental perception An occupant-centric approach.pdf 57175d975bd9a7f2784c235261a75b3c
Source PDF MD5: Sound_evidence/Ueberham2019_Cyclists_multiple_environmental_exposures.pdf 8c9d3c20af67ece6ce1bedfdfb9d231b
Source PDF MD5: Sound_evidence/Sound - Korpilo2024 - Landscape soundscape quality stress recovery urban nature.pdf 3425ace54dd07890a3b507114ebf8d1f
Run time: 10.8 s

## Rows per paper (finite p)
- Grapas 2026: 3
- Pigliautile 2021: 41
- IBPC 2018 poster: 4
- Chiucchiù 2026: 33
- Cureau 2022: 12
- Moshammer 2019: 10
- Moshammer 2019 (comfort adaptation): 6
- Rodrigues 2026: 60
- Rodrigues 2026 (comfort adaptation): 12
- Kraus 2013: 10
- Korpilo 2024: 1
- Ueberham 2019: 4

## Methods (see documents/H4_papers_screened_final.md section 1.1 and section 3 item 9)
- Catalogue run order: §3.1 Grapas → §3.2–§3.4 Anna Laura (Pigliautile, IBPC, Chiucchiù) → §3.5 Cureau → §3.7–§3.11 European field (§3.6 FA citation only; §3.12–§3.14 not run).
- Grapas §3.1: Pearson dBA vs comfort on walk phase cells.
- Pigliautile §3.2 / Chiucchiù §3.4: person-mean paired t and participant-mean Spearman on WalkG/WalkU (thermal split within person).
- IBPC §3.3: warm–cool paired vote analogue (`H4_IBPC`); Pigliautile keeps traffic–nature + stratum Spearman + air-quality warm–cool.
- Cureau 2022 §3.5: Fisher exact comfort-domain contrasts by walk phase (§3.6 FA preprint = citation, no duplicate CSV).
- Moshammer §3.7 comfort: additive LMM dBA + UTCI; Rodrigues §3.8 comfort: noise/temperature blocks.
- Moshammer HRV: walking-phase xtreg-re GLS; Kraus: 5-min piecewise Leq on HRV (all four phases); Korpilo: EDA ~ NDSI + temp.
- Ueberham: Spearman within BikeG and BikeU (objective dBA/UTCI vs comfort votes).
- Inference: each row's paper_rule only (documents/H4_papers_screened_final.md §1.4); no catalogue-wide BH/FDR in this run.
- Output: H4_sound_literature_tests.csv = full §3 method ports (report by source paper). §0.3 manuscript highlights listed below only.

## Manuscript highlight rows (§0.3; same tests as catalogue, not a separate tier)
- Comfort-shaped §3 ports cited in the manuscript: IBPC warm-cool, Chiucchiù warm-cool, Cureau Fisher WalkU, Grapas dBA Pearson, Moshammer additive dBA, Rodrigues noise block.
- Rows matching H4_PRIMARY$mask in this run: 6 (expect up to 6).
- Nominal paper_rule MET among highlights: 4 / 6

### Highlight rows
- #1 IBPC 2018 poster | thermal_comfort | warmer minus cooler | p=0.009745 | MET
- #2 Chiucchiù 2026 | thermal_comfort | warmer minus cooler | p=0.009745 | MET
- #3 Cureau 2022 | thermal_comfort | acoustic_comfort | p=0.06061 | not met
- #4 Grapas 2026 | acoustic_comfort | Pearson r | p=0.02395 | MET
- #5 Moshammer 2019 (comfort adaptation) | acoustic_comfort | dba | p=0.0811 | not met
- #6 Rodrigues 2026 (comfort adaptation) | acoustic_comfort | NOISE_max | p=0.009557 | MET

## Fit and support notes

## Cureau §3.5 port (screened guide)
- Fisher exact comfort-domain cross-tabs per WalkG and WalkU.
- Seven-point overall comfort here vs five-point items in source.
- Multinomial comfort models not ported; per-row paper_rule only (no catalogue FDR).

## Not estimable (removed from the results CSV; no finite p value)
- 16 planned tests returned no p value:
  - Pigliautile 2021 | nature vs traffic at cooler (Fig 3b analogue, YAMNet vehicle vs rural_natural) | pleasantness | n=0 | not estimable
  - Pigliautile 2021 | nature vs traffic at cooler (Fig 3b analogue, YAMNet vehicle vs rural_natural) | acoustic_comfort | n=0 | not estimable
  - Pigliautile 2021 | nature vs traffic at warmer (Fig 3b analogue, YAMNet vehicle vs rural_natural) | pleasantness | n=0 | not estimable
  - Pigliautile 2021 | nature vs traffic at warmer (Fig 3b analogue, YAMNet vehicle vs rural_natural) | acoustic_comfort | n=0 | not estimable
  - Pigliautile 2021 | nature vs traffic at cooler (Fig 3b analogue, green vs urban corridor) | pleasantness | n=0 | not estimable
  - Pigliautile 2021 | nature vs traffic at cooler (Fig 3b analogue, green vs urban corridor) | acoustic_comfort | n=0 | not estimable
  - Pigliautile 2021 | nature vs traffic at warmer (Fig 3b analogue, green vs urban corridor) | pleasantness | n=0 | not estimable
  - Pigliautile 2021 | nature vs traffic at warmer (Fig 3b analogue, green vs urban corridor) | acoustic_comfort | n=0 | not estimable
  - Chiucchiù 2026 | paired C0 vs C1 analogue within nature (Table 5 analogue, YAMNet vehicle vs rural_natural) | pleasantness | n=2 | not estimable
  - Chiucchiù 2026 | paired C0 vs C1 analogue within nature (Table 5 analogue, YAMNet vehicle vs rural_natural) | acoustic_comfort | n=2 | not estimable
  - Chiucchiù 2026 | paired C0 vs C1 analogue within traffic (Table 5 analogue, YAMNet vehicle vs rural_natural) | pleasantness | n=2 | not estimable
  - Chiucchiù 2026 | paired C0 vs C1 analogue within traffic (Table 5 analogue, YAMNet vehicle vs rural_natural) | acoustic_comfort | n=2 | not estimable
  - Chiucchiù 2026 | paired C0 vs C1 analogue within nature (Table 5 analogue, green vs urban corridor) | pleasantness | n=0 | not estimable
  - Chiucchiù 2026 | paired C0 vs C1 analogue within nature (Table 5 analogue, green vs urban corridor) | acoustic_comfort | n=0 | not estimable
  - Chiucchiù 2026 | paired C0 vs C1 analogue within traffic (Table 5 analogue, green vs urban corridor) | pleasantness | n=0 | not estimable
  - Chiucchiù 2026 | paired C0 vs C1 analogue within traffic (Table 5 analogue, green vs urban corridor) | acoustic_comfort | n=0 | not estimable

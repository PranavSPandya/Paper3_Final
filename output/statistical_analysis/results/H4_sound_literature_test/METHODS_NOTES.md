# H4 literature-aligned partial ports (documents/H4_papers_screened_final.md sections 0.6 and 3)
Phases: BikeU, WalkU, BikeG, WalkG ; walk-only papers use WalkG, WalkU ; Biel/Kraus use all four; Ueberham uses BikeG, BikeU
Input MD5: a3c4f9388b61def82e5b97b4232315be
Code MD5: H4_sound_literature_test.R e9ed5c811524a64a9bd2c6a7d2c8f775
Code MD5: Paper3_common.R 2fd13e4345abd183a405f5d1d9f0f324
Code MD5: H4_sound_literature_helpers.R a650d52a88ed95eaac5d35077c667feb
Source PDF MD5: H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf 4d68efe729200a15976f6033e481781b
Source PDF MD5: H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf 37a32046416c89267ade534dff21d769
Source PDF MD5: Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf bcd044129f93e4b9983482e6e3653913
Source PDF MD5: Sound_evidence/Sound - Wu2025 - thermal acoustic overall comfort cold-region parks.pdf ee86c1a2e569271b2a3ea5546356715d
Source PDF MD5: Sound_evidence/Sound - Xu2026 - threshold thermal-acoustic urban public spaces.pdf 4a8cab2dea323557aee7447e3b1cd9a2
Source PDF MD5: Sound_evidence/Sound - Environmental thermal influence over soundscape perception - a test room experimental campaign involving the psychological and physiological.pdf 986251e01a1932abb717eb875eff08ae
Source PDF MD5: H4 Sound literature test/Included - Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf 8eafe01c4f63a1c3b785b49e20713866
Source PDF MD5: H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf 44f5da3d0ad06d380a488f900cd11330
Source PDF MD5: Sound_evidence/Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf 8024c3a99f26363ba12d37c54eff2cd2
Source PDF MD5: Anna Laura/Sound - The role of personality in multi-domain environmental perception An occupant-centric approach.pdf 57175d975bd9a7f2784c235261a75b3c
Source PDF MD5: Sound_evidence/Chen2023_Sensory_walking_thermal_acoustic.pdf b01bacbfc4980df825f7f2db45f2e510
Source PDF MD5: Sound_evidence/Ueberham2019_Cyclists_multiple_environmental_exposures.pdf 8c9d3c20af67ece6ce1bedfdfb9d231b
Source PDF MD5: Sound_evidence/Sound - Li2025 - autumn greenway noise thermal walking.pdf 0cc1b80f6097fc360da1c0282ad4721e
Source PDF MD5: Sound_evidence/Sound - Qin2024 - sound humidity outdoor thermal comfort cold regions.pdf 8057aedf553e590c2ff8efedc7ce9568
Source PDF MD5: Sound_evidence/Sound - Mohammadzadeh2023 - thermal on acoustic comfort urban parks.pdf 23a877945b6652020ea77b45e1a60446
Source PDF MD5: Sound_evidence/Sound - GaoZhu2025 - thermal-acoustic psychological restoration greenways.pdf dbb737418951ab6dee594205a7caeaac
Source PDF MD5: Sound_evidence/Sound - Zhen2025 - plaza OTC thermoacoustic Datang.pdf 046c3dd68d2d9a78ca6c12e3b3eeae06
Source PDF MD5: Sound_evidence/Sound - ZhangUchiyamaSato2026 - thermal acoustic aesthetic parks.pdf d3cb430f77510b80cb75115cbecb6c5d
Source PDF MD5: Sound_evidence/Sound - Zhang2026 - historic spaces thermoacoustic Building Simulation.pdf 64e2dbfd551af4abde1f04194c35577b
Source PDF MD5: Sound_evidence/Sound - Tang2026 - soundscape diversity thermo physiological sex dimorphic.pdf ac1b73fbac9ad5fe5356c2f998c24ef4
Source PDF MD5: Sound_evidence/Sound - Peng2026 - Multisensory greenway plazas openness.pdf 336eb1dad640d4728e0cb66c278a46e2
Source PDF MD5: Sound_evidence/Sound - Simsek2026 - auditory comfort thermal visual urban parks.pdf 59ff2b0bf16bfb48ceb1b0a8a240593a
Run time: 109.8 s

## Rows per paper (finite p)
- Pigliautile 2021: 44
- Cureau 2022: 12
- Chiucchiù 2026: 33
- Moshammer 2019: 260
- Jin 2020: 135
- Biel 2020: 312
- Rodrigues 2026: 780
- Kraus 2013: 248
- Korpilo 2024: 26
- Chen 2023 (adapted): 102
- Ueberham 2019: 4
- Li 2025: 21
- Qin 2024: 39
- Mohammadzadeh 2023: 9
- Gao 2025: 165
- Wu 2025: 56
- Xu 2026: 15
- Zhen 2025: 8
- Zhang 2026 SciRep: 7
- Zhang 2026 BSim: 14
- Song: 4
- Tang 2026: 24
- Peng 2026: 14
- Simsek 2026: 12

## Methods (see documents/H4_papers_screened_final.md section 1.1 and section 3 item 9)
- Pigliautile/Chiucchiu: person-mean paired t and participant-mean Spearman on WalkG/WalkU (thermal split within person).
- Moshammer: walking-phase xtreg-re GLS, first-5-min Leq exposure, 5-8 min native-beat outcomes.
- Jin/Cureau/Wu/Xu/Chen/Li/Qin/Mohammadzadeh/Gao/Zhen/Zhang/Song/Tang/Peng/Simsek/Korpilo/Rodrigues: WalkG/WalkU only.
- Biel (phase LMM + repeated 2-min CAR1) and Kraus (5-min additive mixed model) on all four core phases.
- Ueberham: Spearman within BikeG and within BikeU; optional polr not fitted.
- Encodings 2-4 and 15 spectral descriptors substituted on Moshammer, Jin, Biel, Rodrigues, Kraus, and Korpilo (§1.1).
- Inference: each row's paper_rule only (documents/H4_papers_screened_final.md §1.4); no catalogue-wide BH/FDR in this run.
- Outputs: H4_primary_estimands_results.csv = Paper 3 H4 layer A (§0.3); H4_sound_literature_tests.csv = full catalogue layer B.

## Paper 3 H4 primary estimands (layer A; partial literature port, not full study replication)
- Guide: documents/H4_papers_screened_final.md section 0.3, 0.6.
- Literature search: Scopus title/abstract/keywords therm* AND outdoor AND sound* (see scripts/_scopus_export_text.txt).
- Each included source: closest feasible test family only; omitted source analyses listed in screened guide section 3 item 10.
- Primary interaction rows in this run: 10 (expect 10 if all estimable).
- Paper-rule MET: 0 / 10

### Primary rows (pre-specified interactions on comfort votes)
- # 1 Jin 2020 | thermal_comfort | LAeq x UTCI | p=0.5565 | not met
- # 2 Jin 2020 | acoustic_comfort | LAeq x UTCI | p=0.6775 | not met
- # 3 Jin 2020 | overall_comfort | LAeq x UTCI | p=0.5851 | not met
- # 4 Chen 2023 (adapted) | thermal_comfort | utci_z:dba_z | p=0.1102 | not met
- # 5 Wu 2025 | thermal_comfort | loud60:utci_z | p=0.605 | not met
- # 6 Mohammadzadeh 2023 | acoustic_comfort | utci_z:sound_z | p=0.5808 | not met
- # 7 Li 2025 | thermal_comfort | utci:dba | p=0.3733 | not met
- # 8 Li 2025 | acoustic_comfort | utci:dba | p=0.5808 | not met
- # 9 Li 2025 | overall_comfort | utci:dba | p=0.5805 | not met
- #10 Zhen 2025 | thermal_comfort | utci:dba | p=0.3733 | not met

## Fit and support notes
Jin observed sound x UTCI category counts (walk only):
         
          [9,26) [26,32) [32,38)
  [55,60)      2       0       0
  [60,65)      2       1       0
  [65,70)      3       7       4
  [70,75]      0       1       2
Kraus 2013 AIC selection per outcome:
  - HR: trend forms: study_day=poly2, daily_time_h=linear; AIC(ML) base=317.968, +weekday=300.848 -> weekday kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=44 5-min intervals (interval 1 per phase)
  - SDNN: trend forms: study_day=linear, daily_time_h=poly2; AIC(ML) base=-64.325, +weekday=not estimable (weekday aliased with participant/day trend) -> weekday not kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=44 5-min intervals (interval 1 per phase)
  - LF_power: trend forms: study_day=pspline, daily_time_h=poly2; AIC(ML) base=1.504, +weekday=-2.664 -> weekday kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=31 5-min intervals (interval 1 per phase)
  - HF_power: trend forms: study_day=linear, daily_time_h=poly3; AIC(ML) base=2.357, +weekday=not estimable (weekday aliased with participant/day trend) -> weekday not kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=31 5-min intervals (interval 1 per phase)
  - LF_HF: trend forms: study_day=linear, daily_time_h=poly2; AIC(ML) base=39.551, +weekday=-34.483 -> weekday kept; season: one summer (3 July to 27 August 2025), not a multi-season contrast; Leq lags 5-10 and 10-15 min not estimable in 8-min bout; lagged outcome omitted (no prior 5-min interval within 8-min bout); n=31 5-min intervals (interval 1 per phase)
Kraus 2013 alternative sound variables (knot and SD per descriptor):
  - sound_corridor_urban (sound_corridor): Kraus knot = median 0.5, slope per 1 SD = 0.5058
  - sound_yamnet_majority_traffic (sound_yamnet_vehicle_vs_rural): Kraus knot = median 0.3333, slope per 1 SD = 0.2128
  - wind_proportion (sound_category_proportion): Kraus knot = median 0.0325, slope per 1 SD = 0.1743
  - rural_natural_proportion (sound_category_proportion): Kraus knot = median 0.1208, slope per 1 SD = 0.09913
  - vehicle_proportion (sound_category_proportion): Kraus knot = median 0.09833, slope per 1 SD = 0.1046
  - urban_manmade_neutral_proportion (sound_category_proportion): Kraus knot = median 0.035, slope per 1 SD = 0.09889
  - urban_manmade_positive_proportion (sound_category_proportion): Kraus knot = median 0.5642, slope per 1 SD = 0.2829
  - urban_manmade_negative_proportion (sound_category_proportion): Kraus knot = median 0.06, slope per 1 SD = 0.101
  - mechanisms_proportion (sound_category_proportion): Kraus knot = median 0.04, slope per 1 SD = 0.04937
  - unidentify_proportion (sound_category_proportion): Kraus knot = median 0.1025, slope per 1 SD = 0.09216
  - dominant_frequency_Hz (sound_spectral_descriptor): Kraus knot = median 45.67, slope per 1 SD = 29.26
  - spectral_centroid_Hz (sound_spectral_descriptor): Kraus knot = median 315.2, slope per 1 SD = 215.3
  - spectral_rolloff85_Hz (sound_spectral_descriptor): Kraus knot = median 532.4, slope per 1 SD = 344.4
  - freq_proportion_20_to_200Hz (sound_spectral_descriptor): Kraus knot = median 0.7404, slope per 1 SD = 0.1813
  - freq_proportion_200_to_2000Hz (sound_spectral_descriptor): Kraus knot = median 0.237, slope per 1 SD = 0.1624
  - freq_proportion_2000_to_20000Hz (sound_spectral_descriptor): Kraus knot = median 0.01952, slope per 1 SD = 0.0227
  - octave_proportion_31_5_Hz (sound_spectral_descriptor): Kraus knot = median 0.2479, slope per 1 SD = 0.1122
  - octave_proportion_63_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.3002, slope per 1 SD = 0.06729
  - octave_proportion_125_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.1496, slope per 1 SD = 0.03781
  - octave_proportion_250_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.0674, slope per 1 SD = 0.02939
  - octave_proportion_500_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.08992, slope per 1 SD = 0.08268
  - octave_proportion_1000_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.06447, slope per 1 SD = 0.05859
  - octave_proportion_2000_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.02227, slope per 1 SD = 0.01756
  - octave_proportion_4000_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.007679, slope per 1 SD = 0.007783
  - octave_proportion_8000_0_Hz (sound_spectral_descriptor): Kraus knot = median 0.002071, slope per 1 SD = 0.006533
Qin 2024 descriptive mean TC by RH quartile (rows) x dBA quartile (columns), walk cells; no inferential test (cell n < 5):
            [57.7,65.3] (65.3,67.6] (67.6,69.4] (69.4,70.9]
[34.8,42]            NA         4.0         3.0        3.67
(42,45.6]            NA         4.5         3.0        3.00
(45.6,51.9]        4.33          NA         4.5        3.00
(51.9,59.1]        5.00         4.5          NA          NA
Cell counts:
             
              [57.7,65.3] (65.3,67.6] (67.6,69.4] (69.4,70.9]
  [34.8,42]             0           1           2           3
  (42,45.6]             0           2           1           2
  (45.6,51.9]           3           0           2           1
  (51.9,59.1]           3           2           0           0
Gao 2025 veto analogue (descriptive only; walk cells): counts and mean PRS (four-subscale mean):
        
         AC low AC ok
  TC low      4     1
  TC ok       6    11
       AC low AC ok
TC low   2.36  1.75
TC ok    2.53  3.11
Xu 2026 combined condition (all 44 core cells): air_temp>32 1 yes / 43 no; dBA>65 33 yes / 11 no; both 1. Interaction not fitted (item 7).
- Tang2026: WalkG/WalkU. LMM physiology ~ z(dBA)*z(PET) and ~ z(Shannon diversity)*z(PET); Kruskal-Wallis dBA quartiles within median PET half.
- Peng2026: WalkG/WalkU. Kruskal-Wallis; Spearman among votes and dBA; LMM OC ~ thermal + acoustic + visual.
- Simsek2026: WalkG/WalkU. Pearson AC vs dBA/UTCI/RH/wind within phase; LMM AC ~ z(env predictors).

## Additional outdoor papers (verified 2026-11-06)
- Cureau2022: Fisher exact comfort-domain method by phase/site analogue. Seven-point overall comfort differs from source five-point item. No independent-local-sample Mann-Whitney; this cohort is paired.
- Cureau2022 multinomial models NOT copied.
- Chen2023: continuous participant-LMM adaptation rating ~ zUTCI * zdBA + zNaturalShare + (1|ParticipantID), plus encodings 2-4 without the nature-share term. Not the published ANOVA.
- Ueberham2019: subjective exposure-intensity items absent; NOT fitted.
- Li2025: arrival/departure and subjective loudness not collected; NOT fitted.
- New model and outcome choices are post-hoc additions; source p<.05 decision rule per row (no catalogue-wide BH in H4_sound_literature_test.R).

## Not estimable (removed from the results CSV; no finite p value)
- 173 planned tests returned no p value:
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
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [sound_yamnet_majority_traffic] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [sound_yamnet_majority_traffic] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [sound_yamnet_majority_traffic] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [sound_yamnet_majority_traffic] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [sound_yamnet_majority_traffic] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [sound_yamnet_majority_traffic] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [sound_yamnet_majority_traffic] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [sound_yamnet_majority_traffic] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [sound_yamnet_majority_traffic] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [vehicle_proportion] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [vehicle_proportion] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [vehicle_proportion] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [vehicle_proportion] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [vehicle_proportion] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [vehicle_proportion] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [vehicle_proportion] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [vehicle_proportion] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [vehicle_proportion] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [dominant_frequency_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [dominant_frequency_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [dominant_frequency_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [dominant_frequency_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [dominant_frequency_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [dominant_frequency_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [dominant_frequency_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [dominant_frequency_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [dominant_frequency_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [spectral_centroid_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [spectral_centroid_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [spectral_centroid_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [spectral_centroid_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [spectral_centroid_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [spectral_centroid_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [spectral_centroid_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [spectral_centroid_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [spectral_centroid_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [spectral_rolloff85_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [spectral_rolloff85_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [spectral_rolloff85_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [spectral_rolloff85_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [spectral_rolloff85_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [spectral_rolloff85_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [spectral_rolloff85_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [spectral_rolloff85_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [spectral_rolloff85_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_20_to_200Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_20_to_200Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_20_to_200Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_20_to_200Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_20_to_200Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_20_to_200Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_20_to_200Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_20_to_200Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_20_to_200Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_200_to_2000Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_200_to_2000Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_200_to_2000Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_200_to_2000Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_200_to_2000Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_200_to_2000Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_200_to_2000Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_200_to_2000Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_200_to_2000Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_2000_to_20000Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_2000_to_20000Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_2000_to_20000Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_2000_to_20000Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_2000_to_20000Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_2000_to_20000Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [freq_proportion_2000_to_20000Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [freq_proportion_2000_to_20000Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [freq_proportion_2000_to_20000Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_250_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_250_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_250_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_250_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_250_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_250_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_250_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_250_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_250_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_1000_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_1000_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_1000_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_1000_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_1000_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_1000_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_1000_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_1000_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_1000_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_4000_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_4000_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_4000_0_Hz] | TCV_thermal_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_4000_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_4000_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_4000_0_Hz] | ACV_acoustic_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq level [octave_proportion_4000_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, UTCI category [octave_proportion_4000_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Jin 2020 | participant-blocked two-way ANOVA, LAeq x UTCI [octave_proportion_4000_0_Hz] | OCV_overall_comfort | n=22 | not estimable
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | STD_bpm | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | STD_bpm | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | STD_LF_HF_ratio | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | STD_LF_HF_ratio | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | STD_RMSSD | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | STD_RMSSD | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MAX_bpm | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MAX_bpm | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MAX_LF_HF_ratio | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MAX_LF_HF_ratio | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MAX_RMSSD | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MAX_RMSSD | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MEAN_bpm | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MEAN_bpm | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MEAN_LF_HF_ratio | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MEAN_LF_HF_ratio | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MEAN_RMSSD | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MEAN_RMSSD | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MIN_bpm | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MIN_bpm | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MIN_LF_HF_ratio | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MIN_LF_HF_ratio | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MIN_RMSSD | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MIN_RMSSD | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | STD_Values | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | STD_Values | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MAX_Values | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MAX_Values | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_max [sound_corridor_urban] | MIN_Values | n=22 | fit error: missing values in object
  - Rodrigues 2026 | Noise block (7.Model_H2.py): NOISE_std [sound_corridor_urban] | MIN_Values | n=22 | fit error: missing values in object
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase below median knot [sound_corridor_urban] | HR | n=44 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase at/above median knot [sound_corridor_urban] | HR | n=44 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase below median knot [sound_corridor_urban] | SDNN | n=44 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase at/above median knot [sound_corridor_urban] | SDNN | n=44 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase below median knot [sound_corridor_urban] | LF_power | n=31 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase at/above median knot [sound_corridor_urban] | LF_power | n=31 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase below median knot [sound_corridor_urban] | HF_power | n=31 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase at/above median knot [sound_corridor_urban] | HF_power | n=31 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase below median knot [sound_corridor_urban] | LF_HF | n=31 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase at/above median knot [sound_corridor_urban] | LF_HF | n=31 | fit error: Singularity in backsolve at level 0, block 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase below median knot [octave_proportion_1000_0_Hz] | HF_power | n=31 | fit error: optim problem, convergence error code = 1
  - Kraus 2013 | additive mixed model, 5-min intervals, sound lag 0 (0-5 min), 1-SD increase at/above median knot [octave_proportion_1000_0_Hz] | HF_power | n=31 | fit error: optim problem, convergence error code = 1
  - Korpilo 2024 | EDA level GLMM analogue (sound_corridor_urban + temperature + RH + phase) | ln tonic EDA | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq level | prs_fascination | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, UTCI category | prs_fascination | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq x UTCI | prs_fascination | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq level | prs_being_away | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, UTCI category | prs_being_away | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq x UTCI | prs_being_away | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq level | prs_coherence | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, UTCI category | prs_coherence | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq x UTCI | prs_coherence | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq level | prs_scope | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, UTCI category | prs_scope | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq x UTCI | prs_scope | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq level | prs_mean | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, UTCI category | prs_mean | n=22 | not estimable
  - Gao 2025 | participant-blocked two-way ANOVA on PRS, LAeq x UTCI | prs_mean | n=22 | not estimable

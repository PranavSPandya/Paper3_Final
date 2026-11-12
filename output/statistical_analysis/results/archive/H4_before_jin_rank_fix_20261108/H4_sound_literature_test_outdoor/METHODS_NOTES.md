# H4 source-inspired analyses
Methods guide: documents/H4_papers_screened.md
Analysis phases: BikeU, WalkU, BikeG, WalkG
Input MD5: a3c4f9388b61def82e5b97b4232315be
Code MD5: H4_sound_literature_test.R 12b3024f10ae4b0c277c94b8e3bea941
Code MD5: Paper3_common.R 9ef655eb6b642504cb9c4b0503353e0e
Code MD5: H4_sound_literature_helpers.R 6b9bde20e17c64b83d44b322bfe786cd
Code MD5: H4_additional_outdoor_methods.R 2e3f92bc520e2c42d491c1bd32116b15
Code MD5: H4_scopus_outdoor_methods.R 1ac0a5cb591ce3673ff20339bd8386a8
- Recorded dBA summaries are not certified native LAeq; calibration/source-classification provenance is not established by this run.
- Corridor is a context proxy; thermal-only and vote-to-vote tests are not measured-sound effects.
- Source designs, scales and windows differ. No entire source experiment is replicated.
- BH families are paper x test x sound variable, not all rows or encodings together.
- Equivalent alternative-encoding Chen/Zhen and Mohammadzadeh models have one canonical Chen fit/family; paper labels do not create replication.
- Xu combined condition uses AIR TEMPERATURE >32 C and sound >65 dB, not UTCI>30 or the 64.8-dB ASV breakpoint.

## Additional outdoor papers (verified 2026-11-06)
- Cureau2022: Fisher exact comfort-domain method by phase/site analogue. Seven-point overall comfort differs from source five-point item. No independent-local-sample Mann-Whitney; this cohort is paired.
- Cureau2022 multinomial models NOT copied.
- Chen2023: continuous participant-LMM adaptation rating ~ zUTCI * zdBA + zNaturalShare + (1|ParticipantID), plus encodings 2-4 without the nature-share term. Not the published ANOVA.
- Ueberham2019: subjective exposure-intensity items absent; NOT fitted.
- Li2025: arrival/departure and subjective loudness not collected; NOT fitted.
- New model and outcome choices are post-hoc additions. BH within paper/test; source p<.05 decision rule retained.
## Scopus outdoor additions (verified 2026-11-07 from saved PDFs)
- Qin2024: TC ~ sound x RH. Humidity intervals 25-40/40-55/55-70/70-85 % and 20 dB LAeq bins not reproduced; continuous z-scores with participant intercepts. TSV/PET absent.
- Mohammadzadeh2023: AC~UTCI, AC~TC and primary dBA interaction retained. Alternative-encoding AC interactions are canonical Chen fits, not independent replications. Source quality/loudness measures absent.
- Gao2025: PRS-11 subscales / mean replace ROS. Two-way ANOVA of restoration on UTCI x dBA quartiles, plus LMM PRS ~ zUTCI * zSound. Veto-probability analysis not fitted (needs their uncomfortable/APR cut on ROS).
- Wu2025: OC ~ zUTCI + zSound; TC ~ I(dBA>=60)*zUTCI. Source also entered TCV and ACV into the OCV regression; those vote predictors are omitted. Winter/transition seasons absent. Human/artificial/natural field labels replaced by encodings 3-4.
- Xu2026: linear AC association; ASV unrecorded so no ASV knot imposed on AC. Combined condition uses source air temperature >32 C and dBA >65; an empty factorial cell is reported as not estimable. CART/SHAP not fitted.
- Zhen2025: primary unstandardized TC~UTCI*dBA sensitivity retained without Chen natural-share adjustment; no TSV/NUTCI replication. Alternative encodings would reparameterize Chen and are omitted. Do not interpret raw main effects at zero of the other predictor as average exposure effects.
- Zhang2026 SciRep: TC ~ zAC * zUTCI. Aesthetic satisfaction omitted (not collected). Ordered logit replaced by Gaussian LMM.
- Zhang2026 Building Simulation: Spearman of comfort vs dBA within each phase/site analogue. ENVI-met, CadnaA and HIA ranking NOT fitted.
- Li2025: NOT fitted. Arrival vs departure questionnaires and subjective loudness (SLV) were not collected; first/last minutes of a bout are not their walking-state protocol.
- Jin2020 chamber (sound types x levels at 0/20/30 C): NOT fitted. Assigned headphone files and chamber seasons are not reconstructable; Pigliautile/Chiucchiù already cover playback-style indoor analogues.
Xu >32 C air temperature x >65 dBA cell counts (rows cool/hot, columns quieter/louder): 11, 32, 0, 1 ; interaction NOT ESTIMABLE: an empty 2x2 cell aliases the factorial coefficients. No substituted cutoff was searched.

## Not estimable (removed from the results CSV; no p value, so no q value)
- 3 planned tests returned no p value:
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | thermal_comfort | n=11 | not estimable
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | acoustic_comfort | n=11 | not estimable
  - Cureau 2022 | Fisher exact comfort-domain association, phase BikeG | visual_comfort | n=11 | not estimable

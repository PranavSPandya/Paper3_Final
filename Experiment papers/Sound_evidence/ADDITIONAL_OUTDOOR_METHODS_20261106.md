# Added outdoor sound/thermal papers — 2026-11-06

Full PDFs downloaded and readable:
- Chen2023_Sensory_walking_thermal_acoustic.pdf — https://doi.org/10.3390/f14061161
- Ueberham2019_Cyclists_multiple_environmental_exposures.pdf — https://doi.org/10.3390/su11051412
- Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf (already present; identical new download removed) — https://doi.org/10.1007/s00484-022-02338-7

Li, Li & Wang (2025), Enhancing autumn greenway walking experience:
https://doi.org/10.1007/s00484-024-02790-7
Publisher PDF request returned non-PDF access content; no fake PDF saved. Abstract accessible. Full methods unavailable; no equation invented and no claimed replication.

Implemented in library/H4_additional_outdoor_methods.R:
- Cureau Fisher exact cross-domain associations, separately by phase/site analogue.
- Chen continuous participant-intercept LMM adaptation, explicitly NOT their balanced factorial/RM ANOVA. Observational UTCI and sound are continuous; natural-source share replaces unavailable dominant-source rank. Model: rating ~ zUTCI * zdBA + zNaturalShare + (1|ParticipantID). Three available comfort outcomes. This changes the original method and is labelled accordingly.
Not fitted:
- Cureau independent-local-sample Mann-Whitney and multinomial model suite: independent local respondents and full original scale/predictor panel absent; source overall comfort 5-point versus our 7-point current comfort.
- Ueberham objective-vs-subjective exposure Spearman/ordinal regression: subjective exposure intensity/loudness items absent. Comfort is not substituted for exposure intensity.
- Li: full model unverified and no arrival/departure pairing here.

Tram runs preserve original core results:
Rscript scripts/statistical_analysis/H4_sound_literature_test.R --include-tram
Rscript scripts/statistical_analysis/H5_combined_tram.R --grain=phaseavg
Rscript scripts/statistical_analysis/H5_combined_tram.R --grain=timeseries
Tram has its own passenger/activity and phase indicator. Walking-specific models remain walking-only. Assigned route GVI for Tram does not measure the passenger view.

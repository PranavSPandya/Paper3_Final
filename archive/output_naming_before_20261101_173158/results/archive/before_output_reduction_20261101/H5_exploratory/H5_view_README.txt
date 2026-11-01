H5 view-factor models (merged into H5_hotspot_weather.R on 1 Nov 2026; formerly H5_hotspot_weather_svfclasses.R).
Class labels use Gong et al. 2019 dominance ratios applied to upward camera view factors; an adaptation, not a validated thermal threshold. ST = Gong TS (alphabetical order).
Each site factor is the median across visits to the same hotspot; separate models for SVF, TVF and BVF.
Per phase and outcome: participant-centered response ~ UTCI_c + log10(lux + 1)_c + one site view factor OR class; random participant intercept; AR1 along route positions; ML.
No hotspot fixed effects: site form and hotspot indicators are not separately identifiable.
Class comparisons include only classes with >= 3 hotspots; reference class alphabetically first.
Continuous view-factor coefficients are per 0.1 increase; some phase ranges are smaller than 0.1, so compare over observed ranges.
FDR: BH across all continuous view-factor tests; separate BH across class omnibus LRTs; class level p values unadjusted, descriptive only. Not merged with RH1 FDR.
Baseline for LRT and AIC = UTCI + lux model with the same rows and structure.
Pupil outcomes may still reflect illumination not captured by the person-worn lux sensor.
Input MD5:
14d90d7e409ad466622908340ea72a77

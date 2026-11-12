Exploratory H5 urban-form adaptation, using the previously generated H5 hotspot-day data.
Class labels use Gong et al. 2019 dominance ratios applied to upward camera view factors; this is an adaptation, not a validated thermal threshold.
Each site factor is the median across visits to the same hotspot; separate models for SVF, TVF and BVF avoid assuming independent compositional factors.
Per phase and outcome: participant-centered response ~ UTCI + one site view factor OR class; random participant intercept and AR1 correlation along route positions. No hotspot fixed effects: site form and fixed hotspot indicators are not separately identifiable when site form is constant within hotspot.
Class comparisons include only classes represented by >=3 hotspots; reference class alphabetically first, not a healthy or optimal baseline.
Coefficients for continuous view factors correspond to a 0.1 increase in factor (10 percentage points if factors are 0-1).
FDR for all continuous exposure tests across outcomes, phases and factors; separate FDR family for class omnibus likelihood-ratio tests. Class individual p values are unadjusted, descriptive only.
Model-based uncertainty does not fully account for spatial correlation between adjacent hotspots, systematic phase/route/time confounding, 11 participants, measurement error, or uncertainty in site estimates; significance is exploratory and not evidence of causality.
Input: H5_exploratory/H5_hotspot_day.csv, which is a cached prior H5 run; refresh original data preparation first if inputs have changed.
AIC comparisons have identical rows within each model pair, baseline is UTCI-only with the same AR1 and participant structure; not a comparison against the hotspot fixed-effect model.
Input MD5:
14d90d7e409ad466622908340ea72a77
ST in class labels is the same sky-tree pairing labelled TS in Gong; alphabetical ordering is used in this output.
Some phase-specific ranges are much smaller than 0.1 (notably green-route building view); corresponding 0.1-unit coefficients extrapolate beyond observed support. Compare effects over actual observed ranges instead.
Pupil outcomes may reflect illumination and eye-tracker conditions; UTCI adjustment does not adjust for light or establish a stress response.

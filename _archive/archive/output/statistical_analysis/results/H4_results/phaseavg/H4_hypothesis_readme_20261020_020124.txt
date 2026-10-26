# H4 phase-average sensitivity

All seven fixed-effect equations are read directly from H4_multivariate.R. No terms are selected using these results.
The same matched eight-minute input as H4_multivariate.R is averaged over each participant-phase; this does not change to the full-duration input. Participant random intercept, REML, participant-cluster CR2/Satterthwaite inference; no temporal AR(1).
Epoch eligibility and SVF endpoint carry-forward follow H4 time-series preparation. Each model averages predictors and outcome over identical observed epochs.
Natural-log HRV outcomes are logged before averaging. Exposures are centered within participant across phase means and scaled by pooled SD before forming interactions.
These are phase-mean associations, not within-bout fluctuations. Interactions are products of phase means, not means of epoch interaction products.
q: BH across 26 planned outcomes per term/equation. q_equation: BH across all non-intercept terms and outcomes within equation. No correction across equations.
High VIF, boundary variance, low df, missing phases and warnings remain visible; no automatic variable removal or uncorrelated fallback.

Models with estimates: 182/182; high-VIF designs: 182; low-df coefficient rows: 650.
Per-term q<.05: 0; equation-wide q<.05: 0. Counts include exploratory adjustment/phase terms.
Separate exploratory phase contrasts: 1 per-contrast q<.05 and 0 equation-wide contrast q<.05; these are phase comparisons, not heat/sound exposure findings.

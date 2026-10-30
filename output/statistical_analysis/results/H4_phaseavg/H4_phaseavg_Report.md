# H4 phase-average sensitivity

These exploratory models use the seven explicit phase-average formulas in H4_phaseavg.R. Each includes sum-to-zero phase adjustment; solar irradiance and GVI are omitted from this variant.
The declared formulas are fixed across all 26 outcomes. Outcome-specific phase-mean design rank and VIF are reported; VIF flags do not automatically remove variables.
All seven equations include the three sum-to-zero phase contrasts and a participant random intercept.
The same matched eight-minute input as H4_timeseries.R is averaged over each participant-phase; this does not change to the full-duration input. Participant random intercept, REML, participant-cluster CR2/Satterthwaite inference; no temporal AR(1).
Epoch eligibility uses each original complete equation, preserving the screening comparison sample. SVF endpoint carry-forward follows H4 time-series preparation. Each model averages predictors and outcome over identical observed epochs.
Natural-log outcomes (HRV, EDA tonic) are logged before averaging. Exposures are centered within participant across phase means and scaled by pooled SD before forming interactions.
These are phase-mean associations, not within-bout fluctuations. Interactions are products of phase means, not means of epoch interaction products.
q: BH across 26 planned outcomes per term/equation. q_equation: BH across all non-intercept terms and outcomes within equation. No correction across equations.
Boundary variance, low df, missing phases and warnings remain visible; no automatic variable removal or uncorrelated fallback.

Models with estimates: 182/182; low-df coefficient rows: 489.
Per-term q<.05: 24; equation-wide q<.05: 2. Counts include exploratory adjustment/phase terms.
Separate exploratory phase contrasts: 22 per-contrast q<.05 and 12 equation-wide contrast q<.05; these are phase comparisons, not heat/sound exposure findings.

Eq1: 39-44 phase observations; full rank yes.
Eq2: 39-44 phase observations; full rank yes.
Eq3: 39-44 phase observations; full rank yes.
Eq4: 39-44 phase observations; full rank yes.
Eq5: 39-44 phase observations; full rank yes.
Eq6: 39-44 phase observations; full rank yes.
Eq7: 39-44 phase observations; full rank yes.

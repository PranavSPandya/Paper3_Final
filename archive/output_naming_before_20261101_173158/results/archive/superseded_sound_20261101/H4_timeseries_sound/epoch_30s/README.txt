Eq1-only exploratory sound substitutions: timeseries
Input: C:/Users/sanga/Desktop/Pranav Paper3_Final/output/merged_all_11participants_8min.csv
Each of 22 numeric acoustic measures separately replaces dBA in BOTH the main effect and UTCI interaction; dBA is absent from every fitted fixed-effect equation.
No sound variables enter together. No other heat/PM equations or lag models are run.
Original H4 outcome transformations, HRV-window mask, bilateral means, one-step SVF endpoint carry and sum-to-zero phase contrasts retained.
Timeseries epoch width (seconds): 30 (10 s uses original bout centering; wider bins mean-aggregate 10 s rows then center). Nested participant/phase intercepts; AR1 on the time-bin index within each bout; no fallback, fits where AR1 fails are reported as not fitted.
Does not write to H4_timeseries/ or H4_phaseavg/ (primary seven-equation H4 only).
Wind screening: none (all eligible 10 s windows by ucm_WIND_AWS).
Phaseavg: matched-epoch eligibility on the complete time-series predictor set, transform Y before means, participant-centered phase means/shared sample SD; participant intercept.
Participant CR2/Satterthwaite inference. Low df<4, boundary variance, residual correlation and VIF flags retained, never used for automatic variable removal.
q_FDR: the only adjusted-p column. BH across all572planned tests (22sounds x26outcomes) separately for each coefficient type: sound main, UTCI x sound, UTCI main, and each named adjustment coefficient. Not pooled with original H4 or the other analysis mode.
FDR_significant: TRUE exactly when q_FDR < 0.05; FALSE otherwise. A blank q_FDR means untested/unavailable, not evidence of no association; inspect inference_eligible.
Column guide: outcome = physiological dependent measure; term = individual coefficient tested; sound_variable = the acoustic replacement used in that fitted model. Beta = adjusted coefficient in transformed outcome units per scaled predictor unit; SE = robust standard error; df = Satterthwaite degrees of freedom; p = unadjusted p-value; ci_low/ci_high = unadjusted 95% limits. *_phase_z means participant-centered phase means divided by a shared SD; *_bout_z means whole-bout-centered epochs divided by a shared SD. PhaseSum terms adjust for experimental phase; Intercept is the reference predicted outcome.
H4 amplification is tested by term_type=thermal_x_sound (a colon in term). A significant UTCI main effect describes the thermal slope at centered sound=0; it does not establish a sound effect or sound amplification.
All planned failures remain explicit; missing tests count in multiplicity denominators. CIs are unadjusted 95% intervals.
YAMNet mapping limitations and positive/negative labels remain as audited; these are source classification/spectral descriptors, not calibrated dBA replacements.
Completed models: 572 of 572
Fits with CR2: 570
Output: C:/Users/sanga/Desktop/Pranav Paper3_Final/output/statistical_analysis/results/H4_timeseries_sound/epoch_30s

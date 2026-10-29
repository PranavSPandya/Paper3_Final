Eq1-only exploratory sound substitutions: phaseavg
Input: D:/Pranav/docker/Paper3_Final/output/merged_all_11participants_8min.csv
Each of 30 numeric acoustic measures separately replaces dBA in BOTH the main effect and UTCI interaction; dBA is absent from every fitted fixed-effect equation.
No sound variables enter together. No other heat/PM equations or lag models are run.
Original H4 outcome transformations, HRV-window mask, bilateral means, one-step SVF endpoint carry and sum-to-zero phase contrasts retained.
Timeseries: whole-bout predictor centering/shared sample SD before outcome filtering; nested participant/phase intercepts; AR1 then existing ARMA20 rule at rho>.95; independent fallback p-values withheld.
Phaseavg: matched-epoch eligibility on the complete time-series predictor set, transform Y before means, participant-centered phase means/shared sample SD; participant intercept.
Participant CR2/Satterthwaite inference. Low df<4, boundary variance, residual correlation and VIF flags retained, never used for automatic variable removal.
q_FDR: the only adjusted-p column. BH across all 780 planned tests (30 sounds x 26 outcomes) separately for each coefficient type: sound main, UTCI x sound, UTCI main, and each named adjustment coefficient. Not pooled with original H4 or the other analysis mode.
FDR_significant: TRUE exactly when q_FDR < 0.05; FALSE otherwise. A blank q_FDR means untested/unavailable, not evidence of no association; inspect inference_eligible.
Column guide: outcome = physiological dependent measure; term = individual coefficient tested; sound_variable = the acoustic replacement used in that fitted model. Beta = adjusted coefficient in transformed outcome units per scaled predictor unit; SE = robust standard error; df = Satterthwaite degrees of freedom; p = unadjusted p-value; ci_low/ci_high = unadjusted 95% limits. *_phase_z means participant-centered phase means divided by a shared SD; *_bout_z means whole-bout-centered epochs divided by a shared SD. PhaseSum terms adjust for experimental phase; Intercept is the reference predicted outcome.
H4 amplification is tested by term_type=thermal_x_sound (a colon in term). A significant UTCI main effect describes the thermal slope at centered sound=0; it does not establish a sound effect or sound amplification.
All planned failures remain explicit; missing tests count in multiplicity denominators. CIs are unadjusted 95% intervals.
YAMNet mapping limitations and positive/negative labels remain as audited; these are source classification/spectral descriptors, not calibrated dBA replacements.
Completed models: 780 of 780
Fits with CR2: 780
Output: D:/Pranav/docker/Paper3_Final/output/statistical_analysis/results/H4_phaseavg_sound

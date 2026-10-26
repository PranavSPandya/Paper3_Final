# Statistical analysis correction audit — 21 September 2026

This note accompanies `scripts/statistical_analysis.R` on branch
`fix/statistical-analysis-audit-2026-09-21`.

## Verified source input

The GitHub source repository was made available for verification. The committed
input used by this analysis is:

`Paper3_Github/data/mergeddata_all.csv`

Direct inspection of that file found:

- 7,999 data rows and 155 columns;
- exactly the 11 planned participants: P4 and P8-P17;
- all four active phases (BikeU, BikeG, WalkU, WalkG) present for every participant;
- Tram present for every participant;
- zero duplicated ParticipantID/PhaseID/Datetime keys in active/Tram data;
- original/raw column names such as `heart_rate`, `UTCI`, and
  `pupil_diameter_avg`, so the script now harmonizes these names internally;
- `empatica_hrv_td_sdnn` is not present in the committed merged input and is
  explicitly reported as unavailable rather than fabricated.

The companion `data/key.csv` contains the Indoor timing windows. The merged
10-second file does not store Indoor as an explicit PhaseID. The corrected script
therefore reconstructs Indoor only from blank-phase rows whose clock times match
the key-file Indoor window after estimating each participant's clock offset from
already-labelled Bike/Walk/Tram starts.

The observed route-to-key clock offsets were approximately +2 hours and were
internally consistent within each participant (spread <= 9 seconds in the
verified committed input). The script now requires at least three reference
phases and an offset spread <= 30 seconds before any blank row can be relabelled
Indoor.

Indoor sensor availability is uneven: some participants have no usable Indoor
sensor epochs and some have only a very short baseline. This is why Indoor and
Indoor+Tram normalization remain sensitivity analyses rather than the primary
analysis. Baseline availability is summarized inside `Model_Audit.csv`.

## Corrections made

1. **H1/H3 planned contrasts**
   - H1 overall: Green - Urban, averaged across mode.
   - H1.1: BikeG - BikeU.
   - H1.2: WalkG - WalkU.
   - H3 overall: Walk - Bike, averaged across environment.
   - H3.1: WalkU - BikeU.
   - H3.2: WalkG - BikeG.
   - Holm correction is applied within each planned contrast family using the
     planned number of available outcomes, so a failed model cannot reduce the
     correction family.

2. **Questionnaire outcomes**
   - Questionnaires are analysed once per participant-phase.
   - Questionnaire values are not treated as 10-second repeated measurements.
   - Model: `outcome_z ~ Mode * Environment + (1 | ParticipantID)`.

3. **10-second physiological/ocular outcomes**
   - Primary model keeps the 10-second data.
   - Participant and participant-phase random intercepts are retained.
   - Continuous-time AR(1) residual correlation is added within each nested
     participant-phase using `nlme::corCAR1`.
   - Condition-specific residual variance remains allowed with `varIdent`.
   - Failed or unstable fits are written to `Model_Audit.csv`, not silently
     removed.

4. **Martin duration sensitivity**
   - The primary full-duration analysis is retained.
   - The duration sensitivity uses one participant-specific common duration
     across BikeU, BikeG, WalkU and WalkG, capped at 8 minutes.
   - In the verified input those common caps range from 420 to 480 seconds.
   - This makes both environment and mode contrasts duration-balanced.

5. **Indoor / Tram baseline sensitivity**
   - Sensitivity analyses are calculated from the common-duration active-phase
     means.
   - Three definitions are produced when enough data exist:
     - active phase mean - Indoor mean;
     - active phase mean - Tram mean;
     - active phase mean - mean(Indoor, Tram).
   - Negative change scores are valid and mean the active-phase value is below
     baseline; they are not interpreted as negative physical conductance.
   - Short or unavailable Indoor baselines are flagged in `Model_Audit.csv`.

6. **H2 mind-body association**
   - The primary association is participant-aware.
   - Psychological and physiological values are rank transformed.
   - The predictor is decomposed into within-person and between-person
     components; the reported primary effect is the within-person concordance
     across phases.
   - A partial-r equivalent is derived from the fixed-effect t statistic.
   - Pooled ordinary Spearman rho is retained only as a descriptive sensitivity.
   - Holm correction remains across the 16 prespecified psychophysiological
     pairs.

7. **H4 environmental model**
   - Unified coefficients are estimated with REML at participant-phase level.
   - Thermal-index AIC comparison uses ML, not REML.
   - UTCI, PET, MRT_S and air-temperature candidates use identical complete-case
     rows within each outcome.
   - Thermal AIC candidates use the same LMM random-effects structure; the AIC
     comparison does not mix LMM and GLS fallbacks.
   - Holm correction is not tied to figure generation.

8. **Light and air-quality sensor handling**
   - The source README states that LYS1 was participant-worn and LYS2 was
     researcher-worn. They are no longer averaged together.
   - H4 primary light exposure uses participant-worn LYS1.
   - Atmotube left/right remain averaged because both were carried by the
     researcher and represent contextual air quality.

9. **Schema and transformation safeguards**
   - The script accepts the committed raw schema and the later prefixed schema
     without changing source values.
   - Raw RMSSD is log transformed once.
   - Ocular variables explicitly named `log_...` or `sqrt_...` are not
     transformed a second time.
   - Missing declared outcomes are explicitly recorded.

10. **Run safeguards**
    - The script checks for all 11 participants.
    - It checks every participant has all four core phases.
    - It stops on duplicate active/Tram time keys.
    - It stops on unparseable core Datetime values.
    - Figures are disabled by default. Set `PAPER3_MAKE_FIGURES=true` only if
      figures are intentionally wanted.

## Local rerun

From the `Paper3_Final` repository root:

```bash
Rscript scripts/statistical_analysis.R
```

The script should automatically find the sibling
`Paper3_Github/data/mergeddata_all.csv` and `data/key.csv`.

Before interpreting results, inspect:

1. `Model_Audit.csv`
2. `Run_Manifest.csv`
3. `H1_Green_vs_Urban.csv`
4. `H3_Walk_vs_Bike.csv`
5. `H1_H3_Baseline_Sensitivity.csv`
6. `H2_Physio_Psycho_Concordance.csv`
7. `H4_Thermal_Comparison_ML.csv`

Do not use the pre-fix CSV results as results from the corrected models.

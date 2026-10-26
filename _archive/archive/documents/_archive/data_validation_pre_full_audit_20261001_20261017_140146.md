1. Load all 189 columns from `merged_all_11participants_8min.csv`.

2. Classify columns as metadata, QC, outcomes, covariates, or environmental variables.

3. Remove only metadata, IDs, QC fields, duplicate channels, and technically redundant variables from the predictor pool.

4. Combine bilateral sensor channels where required.

5. Check missingness, participant coverage, and usable participant-phase rows.

6. Check correlations and VIF among all eligible environmental candidates.

7. Check ICC to justify the participant random intercept.

8. Keep five pre-specified domain representatives: `UTCI`, `SND_dBA`, `PM2.5`, `Lux`, and `GVI`.

   Do not select predictors using outcome significance or FDR.

   The number is fixed before outcome testing: one representative per domain. VIF validates this set; it does not choose variables.

9. Fit one mixed-effects model per outcome:

```text
wpz(Outcome) ~ Mode + wpz(UTCI) + wpz(SND_dBA) + wpz(PM2.5) + wpz(Lux) + wpz(GVI) + (1 | ParticipantID)
```

10. Check convergence and residuals.

11. Apply FDR correction to the model results.

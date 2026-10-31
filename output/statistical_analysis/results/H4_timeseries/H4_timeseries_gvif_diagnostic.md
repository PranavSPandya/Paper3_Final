# H4 design-only GVIF / VIF diagnostic

Reference complete-case outcome: **empatica_heart_rate** (n = 2060). Other outcomes use different row sets; see `H4_timeseries_design_redundancy_by_outcome.csv`.

## PhaseID vs single continuous predictors

PhaseID enters as **three** sum-to-zero contrasts (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit).
In `car::vif`, that span is one **Df = 3** term with a generalized VIF (GVIF).
- **GVIF^(1/(2*Df))** is what `car::vif` prints for multi-df terms (Fox & Monette 1992; [car::vif](https://rdrr.io/cran/car/man/vif.html)).
- **VIF_equivalent = GVIF^(1/Df)** is the square of that root; we compare **VIF_equivalent** to 
5
 for the PhaseID block.
- Continuous **Df = 1** columns use ordinary VIF (= VIF_equivalent). Values above the threshold are **flagged only**; no predictor is dropped.

## Equation summaries (heart rate complete cases)

| Eq | Heat form | Block | n | Max VIF-equiv | Worst term | Phase GVIF | Phase VIF-equiv |
|----|-----------|-------|---|---------------|------------|------------|-----------------|
| 1 | Eq1: heat = UTCI, PM = PM2.5 | heat_x_sound | 2060 | 2.534 | ucm_SUN_Gh | 1.006 | 1.002 |
| 2 | Eq2: heat = AIR_T_mid + AIR_RH + WIND_AWS, PM = PM2.5 | heat_x_sound | 2060 | 2.857 | ucm_MRT | 1.192 | 1.060 |
| 3 | Eq3: heat = HUMIDEX, PM = PM2.5 | heat_x_sound | 2060 | 1.408 | SVF | 1.038 | 1.012 |
| 4 | Eq4: heat = PET, PM = PM2.5 | heat_x_sound | 2060 | 2.357 | ucm_SUN_Gh | 1.010 | 1.003 |
| 5 | Eq5: heat = UTCI, PM = PM1 | heat_x_sound | 2060 | 2.534 | ucm_SUN_Gh | 1.006 | 1.002 |
| 6 | Eq6: heat = UTCI, PM = PM10 | heat_x_sound | 2060 | 2.538 | ucm_SUN_Gh | 1.006 | 1.002 |

Generated UTC: 2026-10-31 15:49:31

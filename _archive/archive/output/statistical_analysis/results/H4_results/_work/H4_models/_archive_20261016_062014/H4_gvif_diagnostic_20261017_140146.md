# H4 design-only GVIF / VIF diagnostic

Reference complete-case outcome: **empatica_heart_rate** (n = 2101). Other outcomes use different row sets; see `H4_design_redundancy_by_outcome.csv`.

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
| 1 | AIR_temp + AIR_RH + WIND_AWS / atmo_pm1_avg | heat_x_sound | 2101 | 2.507 | ucm_MRT | 1.200 | 1.063 |
| 2 | AIR_temp + AIR_RH + WIND_AWS / atmo_pm2.5_avg | heat_x_sound | 2101 | 2.508 | ucm_MRT | 1.200 | 1.063 |
| 3 | AIR_temp + AIR_RH + WIND_AWS / atmo_pm10_avg | heat_x_sound | 2101 | 2.508 | ucm_MRT | 1.200 | 1.063 |
| 4 | HUMIDEX / atmo_pm1_avg | heat_x_sound | 2101 | 2.455 | ucm_MRT | 1.039 | 1.013 |
| 5 | HUMIDEX / atmo_pm2.5_avg | heat_x_sound | 2101 | 2.455 | ucm_MRT | 1.039 | 1.013 |
| 6 | HUMIDEX / atmo_pm10_avg | heat_x_sound | 2101 | 2.455 | ucm_MRT | 1.039 | 1.013 |
| 7 | PET / atmo_pm1_avg | heat_x_sound | 2101 | 2.937 | ucm_SUN_Gh | 1.015 | 1.005 |
| 8 | PET / atmo_pm2.5_avg | heat_x_sound | 2101 | 2.939 | ucm_SUN_Gh | 1.015 | 1.005 |
| 9 | PET / atmo_pm10_avg | heat_x_sound | 2101 | 2.946 | ucm_SUN_Gh | 1.015 | 1.005 |
| 10 | UTCI / atmo_pm1_avg | heat_x_sound | 2101 | 2.942 | ucm_UTCI | 1.015 | 1.005 |
| 11 | UTCI / atmo_pm2.5_avg | heat_x_sound | 2101 | 2.933 | ucm_UTCI | 1.015 | 1.005 |
| 12 | UTCI / atmo_pm10_avg | heat_x_sound | 2101 | 2.940 | ucm_UTCI | 1.014 | 1.005 |

Generated UTC: 2026-10-13 08:32:03

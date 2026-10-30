# H4 measurement audit
Steps 1-2 retain the complete inventory and declared exposure representations. Step 3 groups candidates without outcome-based deletion.
Step 4 retains all 16 eligible candidates, specifies alternative heat/PM equations, and checks full-design VIF/rank; no automatic deletion.
Participant is the independent cluster. Step 4 defines seven equations (primary UTCI + PM2.5; optional Eq 2 sound-structure sensitivity; heat-form sensitivities on PM2.5; PM1/PM10 only with UTCI) including heat x sound and MRT x sound. Step 5 fits six by default (Eq 2 when h4_study_spec$include_sound_sensitivity_equation is TRUE). Earlier model outputs are historical until a verified rerun succeeds.
## Stage totals
| Stage | Entering | Retained | Not_Advanced |
| --- | --- | --- | --- |
| Step 1 | 231 | 128 | 103 |
| Step 2 | 128 |  16 | 112 |
| Step 3 |  16 |  16 |   0 |
## Measurement definitions and dependencies
| Variable_Name | Measurement_Code | Measurement_Type | Inputs_or_Definition | Evidence |
| --- | --- | --- | --- | --- |
| ucm_AIR_T_mid | M | Instrument | [UCM T_mid] | [CityFeel17] |
| ucm_AIR_RH | M | Instrument | [UCM] | [CityFeel17] |
| ucm_SND_dBA | M | Instrument | [dBA] | [CityFeel17] |
| ucm_SUN_Gh | M | Instrument | [Gh] | [CityFeel17] |
| atmo_pm1_avg | A | Average | [PM1 avg] | [avg_sources] |
| atmo_pm2.5_avg | A | Average | [PM25 avg] | [avg_sources] |
| atmo_pm10_avg | A | Average | [PM10 avg] | [avg_sources] |
| lys_lux_avg | A | Average | [Lux avg] | [avg_sources] |
| lys_medi_avg | D | Derived | [Medi derived] | [MediRGB] |
| lys_kelvin_avg | D | Derived | [Kelvin avg] | [LYS] |
| ucm_MRT | D | Derived | [MRT] | [CityFeel17] |
| ucm_PET | D | Derived | [PET] | [CityFeel17] |
| ucm_UTCI | D | Derived | [UTCI] | [CityFeel17] |
| ucm_HUMIDEX | D | Derived | [HUMIDEX] | [CityFeel17] |
| Clearness_Index | D | Derived | [kt derived] | [ClearCI] |
| Clearness_Index_G0 | D | Derived | [G0 calc] | [ClearCI] |
| gvi_50m | D | Derived | [GVI] | [GVI merge] |
| ucm_WIND_AWS | M | Wind | [AWS] | [AWS] |
| ucm_fp | U | Unverified | [fp unverified] | [fp] |
| SVF | D | SVF | [SVF Holmer] | [SVF Qiu17] |
Step 2 representatives and averages are study choices, not automatic literature rules. LYS1 and LYS2 represent different wearers.
fp remains unverified; true wind speed (TWS) excluded (gaps, undocumented correction); SVF from CamUp merge in merged_all_11participants_8min.csv (Step 2 Retained when coverage passes).
## Within-person design diagnostics
(none)
| Field1 | Field2 | Pearson_r | Spearman_rho | N_phase_cells |
| --- | --- | --- | --- | --- |
| ucm_PET | ucm_UTCI |  0.98925651 |  0.98020528 | 32 |
| gvi_50m | ucm_MRT | -0.94952578 | -0.90432551 | 32 |
| ucm_MRT | ucm_UTCI |  0.94675820 |  0.85190616 | 32 |
| ucm_AIR_T_mid | ucm_MRT |  0.94215319 |  0.97287390 | 32 |
| ucm_MRT | ucm_PET |  0.93617577 |  0.82697947 | 32 |
| gvi_50m | ucm_AIR_T_mid | -0.92129383 | -0.89039589 | 32 |
| ucm_AIR_T_mid | ucm_HUMIDEX |  0.90727014 |  0.90505865 | 32 |
| gvi_50m | ucm_PET | -0.90180452 | -0.74780059 | 32 |
| gvi_50m | ucm_UTCI | -0.90075363 | -0.76612903 | 32 |
| ucm_SUN_Gh | ucm_UTCI |  0.89769630 |  0.80755132 | 32 |
| ucm_PET | ucm_SUN_Gh |  0.87579143 |  0.79362170 | 32 |
| ucm_HUMIDEX | ucm_MRT |  0.87214914 |  0.89332845 | 32 |
| ucm_AIR_RH | ucm_AIR_T_mid | -0.87121583 | -0.85520528 | 32 |
| ucm_AIR_T_mid | ucm_UTCI |  0.86726830 |  0.78702346 | 32 |
| ucm_AIR_T_mid | ucm_PET |  0.85236238 |  0.77492669 | 32 |
| ucm_MRT | ucm_SUN_Gh |  0.84862671 |  0.71920821 | 32 |
| gvi_50m | ucm_AIR_RH |  0.84570489 |  0.81781525 | 32 |
| gvi_50m | ucm_HUMIDEX | -0.80664621 | -0.82221408 | 32 |
| ucm_HUMIDEX | ucm_UTCI |  0.80113879 |  0.70894428 | 32 |
| ucm_AIR_RH | ucm_MRT | -0.79844921 | -0.85923754 | 32 |
| ucm_HUMIDEX | ucm_PET |  0.76329722 |  0.67045455 | 32 |
| ucm_AIR_RH | ucm_UTCI | -0.76191765 | -0.80938416 | 32 |
| ucm_AIR_RH | ucm_PET | -0.74534049 | -0.81781525 | 32 |
| ucm_AIR_T_mid | ucm_SUN_Gh |  0.73846530 |  0.66385630 | 32 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.72961938 | -0.72030792 | 32 |
| ucm_AIR_RH | ucm_SND_dBA | -0.72577304 | -0.72763930 | 32 |
| SVF | ucm_AIR_T_mid |  0.72102197 |  0.74743402 | 32 |
| SVF | ucm_AIR_RH | -0.72039318 | -0.71700880 | 32 |
| gvi_50m | ucm_SUN_Gh | -0.71613683 | -0.58651026 | 32 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.70577111 |  0.53739003 | 32 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.67615779 |  0.68768328 | 32 |
| SVF | ucm_HUMIDEX |  0.64002776 |  0.68731672 | 32 |
| gvi_50m | SVF | -0.63474022 | -0.70307918 | 32 |
| SVF | ucm_MRT |  0.62236582 |  0.75403226 | 32 |
| SVF | ucm_UTCI |  0.61511765 |  0.61143695 | 32 |
| ucm_AIR_T_mid | ucm_SND_dBA |  0.60915671 |  0.68218475 | 32 |
| SVF | ucm_SUN_Gh |  0.59865387 |  0.59054252 | 32 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.58856813 |  0.64222874 | 32 |
| lys_lux_avg | ucm_UTCI |  0.57915927 |  0.52749267 | 32 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.57645628 | -0.60850440 | 32 |
| gvi_50m | ucm_SND_dBA | -0.57330819 | -0.71041056 | 32 |
| SVF | ucm_PET |  0.57304545 |  0.60007331 | 32 |
| lys_lux_avg | ucm_AIR_T_mid |  0.56729769 |  0.58137830 | 32 |
| lys_lux_avg | ucm_SUN_Gh |  0.55757901 |  0.57697947 | 32 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.54926273 |  0.55388563 | 32 |
| lys_lux_avg | ucm_PET |  0.54538597 |  0.53042522 | 32 |
| lys_lux_avg | ucm_MRT |  0.54432753 |  0.57258065 | 32 |
| gvi_50m | lys_lux_avg | -0.53797711 | -0.50623167 | 32 |
| SVF | ucm_SND_dBA |  0.53716952 |  0.56964809 | 32 |
| lys_lux_avg | ucm_AIR_RH | -0.51209755 | -0.58247801 | 32 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.49210105 |  0.44904692 | 32 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.48240402 |  0.34860704 | 32 |
| lys_kelvin_avg | ucm_MRT |  0.47414064 |  0.56195015 | 32 |
| atmo_pm1_avg | ucm_SND_dBA |  0.47209202 |  0.58064516 | 32 |
| lys_lux_avg | SVF |  0.46613419 |  0.51319648 | 32 |
| lys_kelvin_avg | ucm_AIR_T_mid |  0.46238632 |  0.52016129 | 32 |
| atmo_pm1_avg | ucm_AIR_RH | -0.46002368 | -0.56891496 | 32 |
| atmo_pm1_avg | SVF |  0.45931961 |  0.63892962 | 32 |
| ucm_MRT | ucm_SND_dBA |  0.45660859 |  0.67155425 | 32 |
| lys_lux_avg | ucm_HUMIDEX |  0.45120409 |  0.40652493 | 32 |
| lys_kelvin_avg | ucm_UTCI |  0.42849650 |  0.43511730 | 32 |
| lys_kelvin_avg | ucm_PET |  0.42460136 |  0.41165689 | 32 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.42293783 |  0.43951613 | 32 |
| gvi_50m | lys_kelvin_avg | -0.41460762 | -0.51173021 | 32 |
| lys_kelvin_avg | ucm_AIR_RH | -0.41078468 | -0.43768328 | 32 |
| atmo_pm1_avg | ucm_AIR_T_mid |  0.40416595 |  0.58577713 | 32 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.39106549 |  0.51466276 | 32 |
| lys_kelvin_avg | SVF |  0.38129197 |  0.36913490 | 32 |
| ucm_SND_dBA | ucm_UTCI |  0.37209876 |  0.52859238 | 32 |
| atmo_pm2.5_avg | SVF |  0.37205861 |  0.47580645 | 32 |
| lys_lux_avg | ucm_SND_dBA |  0.35959780 |  0.42412023 | 32 |
| ucm_PET | ucm_SND_dBA |  0.35525952 |  0.53042522 | 32 |
| atmo_pm2.5_avg | ucm_AIR_T_mid |  0.34878965 |  0.55205279 | 32 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.33418999 |  0.51942815 | 32 |
| atmo_pm10_avg | ucm_SND_dBA | -0.32398903 | -0.19978006 | 32 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.31276306 |  0.41019062 | 32 |
| atmo_pm1_avg | gvi_50m | -0.30551295 | -0.46554252 | 32 |
| atmo_pm2.5_avg | lys_lux_avg |  0.30325713 |  0.43914956 | 32 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.28253526 | -0.39112903 | 32 |
| atmo_pm10_avg | gvi_50m |  0.27848400 |  0.17558651 | 32 |
| atmo_pm1_avg | ucm_MRT |  0.27576275 |  0.53042522 | 32 |
| atmo_pm1_avg | lys_lux_avg |  0.27334160 |  0.38819648 | 32 |
| SVF | ucm_WIND_AWS |  0.27236878 |  0.30791789 | 32 |
| lys_kelvin_avg | ucm_SND_dBA |  0.24565386 |  0.30608504 | 32 |
| atmo_pm2.5_avg | ucm_MRT |  0.23878261 |  0.49670088 | 32 |
| atmo_pm1_avg | ucm_UTCI |  0.22347846 |  0.36070381 | 32 |
| ucm_PET | ucm_WIND_AWS | -0.22079390 | -0.03629032 | 32 |
| atmo_pm10_avg | ucm_AIR_RH |  0.22048125 |  0.08614370 | 32 |
| ucm_UTCI | ucm_WIND_AWS | -0.21589431 | -0.04582111 | 32 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.20805470 |  0.30828446 | 32 |
| atmo_pm1_avg | ucm_PET |  0.19995008 |  0.34494135 | 32 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.19817241 |  0.23790323 | 32 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.19315316 | -0.18071848 | 32 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.19107410 |  0.31085044 | 32 |
| atmo_pm2.5_avg | lys_kelvin_avg |  0.16636843 |  0.23497067 | 32 |
| atmo_pm2.5_avg | gvi_50m | -0.16239102 | -0.38196481 | 32 |
| atmo_pm2.5_avg | ucm_WIND_AWS |  0.14947537 |  0.20124633 | 32 |
| atmo_pm2.5_avg | ucm_UTCI |  0.14787930 |  0.25073314 | 32 |
| atmo_pm1_avg | lys_kelvin_avg |  0.14581924 |  0.20087977 | 32 |
| atmo_pm10_avg | ucm_AIR_T_mid | -0.13940475 |  0.01576246 | 32 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.13626888 |  0.14112903 | 32 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.11310682 |  0.22543988 | 32 |
| atmo_pm1_avg | atmo_pm10_avg | -0.10967145 |  0.09420821 | 32 |
| atmo_pm2.5_avg | ucm_PET |  0.10445706 |  0.24010264 | 32 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.10328277 |  0.05608504 | 32 |
| ucm_MRT | ucm_WIND_AWS | -0.09860834 |  0.13599707 | 32 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.08811109 |  0.26466276 | 32 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.08696352 |  0.09567449 | 32 |
| atmo_pm10_avg | SVF | -0.08694841 |  0.12500000 | 32 |
| atmo_pm10_avg | ucm_MRT | -0.08441944 |  0.04582111 | 32 |
| gvi_50m | ucm_WIND_AWS |  0.08224077 | -0.06048387 | 32 |
| atmo_pm10_avg | lys_lux_avg |  0.06550690 |  0.16165689 | 32 |
| atmo_pm10_avg | ucm_PET | -0.06029389 |  0.03775660 | 32 |
| atmo_pm10_avg | ucm_HUMIDEX | -0.05561685 |  0.08944282 | 32 |
| atmo_pm10_avg | ucm_UTCI | -0.04358808 |  0.06928152 | 32 |
| ucm_HUMIDEX | ucm_WIND_AWS |  0.02682329 |  0.02822581 | 32 |
| ucm_AIR_T_mid | ucm_WIND_AWS |  0.01380499 |  0.11693548 | 32 |
| lys_lux_avg | ucm_WIND_AWS |  0.01098971 |  0.18145161 | 32 |
| lys_kelvin_avg | lys_lux_avg |  0.00509492 |  0.21847507 | 32 |
| atmo_pm10_avg | lys_kelvin_avg | -0.00329004 | -0.09860704 | 32 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

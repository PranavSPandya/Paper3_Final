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
| ucm_PET | ucm_UTCI |  0.98885077 |  0.97902098 | 12 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.97502632 |  0.51748252 | 12 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.97213181 |  0.92307692 | 12 |
| ucm_AIR_T_mid | ucm_MRT |  0.96558692 |  0.90209790 | 12 |
| ucm_MRT | ucm_SUN_Gh |  0.96385544 |  0.74125874 | 12 |
| gvi_50m | ucm_MRT | -0.96067314 | -0.95104895 | 12 |
| ucm_AIR_T_mid | ucm_UTCI |  0.95802841 |  0.81118881 | 12 |
| gvi_50m | ucm_AIR_T_mid | -0.95557727 | -0.88811189 | 12 |
| ucm_MRT | ucm_UTCI |  0.94861965 |  0.81118881 | 12 |
| ucm_AIR_T_mid | ucm_PET |  0.94087144 |  0.83216783 | 12 |
| atmo_pm1_avg | atmo_pm10_avg |  0.92874363 |  0.51748252 | 12 |
| ucm_MRT | ucm_PET |  0.92044838 |  0.81118881 | 12 |
| gvi_50m | ucm_UTCI | -0.91719959 | -0.77622378 | 12 |
| ucm_SUN_Gh | ucm_UTCI |  0.91043652 |  0.56643357 | 12 |
| ucm_PET | ucm_SUN_Gh |  0.89796797 |  0.58741259 | 12 |
| ucm_AIR_T_mid | ucm_SUN_Gh |  0.89102324 |  0.55244755 | 12 |
| gvi_50m | ucm_SUN_Gh | -0.88617259 | -0.62237762 | 12 |
| gvi_50m | ucm_PET | -0.88026483 | -0.77622378 | 12 |
| ucm_AIR_RH | ucm_SND_dBA | -0.87488303 | -0.82517483 | 12 |
| gvi_50m | SVF | -0.84291776 | -0.83916084 | 12 |
| gvi_50m | ucm_AIR_RH |  0.84155340 |  0.79020979 | 12 |
| ucm_AIR_T_mid | ucm_HUMIDEX |  0.80512342 |  0.82517483 | 12 |
| ucm_AIR_RH | ucm_AIR_T_mid | -0.79612721 | -0.85314685 | 12 |
| SVF | ucm_AIR_RH | -0.78846350 | -0.69230769 | 12 |
| SVF | ucm_MRT |  0.77081157 |  0.88111888 | 12 |
| ucm_HUMIDEX | ucm_UTCI |  0.75942901 |  0.83216783 | 12 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.75087629 | -0.72727273 | 12 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.74062290 |  0.69230769 | 12 |
| gvi_50m | ucm_HUMIDEX | -0.73475757 | -0.72727273 | 12 |
| ucm_HUMIDEX | ucm_PET |  0.72723155 |  0.79720280 | 12 |
| ucm_AIR_RH | ucm_MRT | -0.71276564 | -0.83916084 | 12 |
| ucm_HUMIDEX | ucm_MRT |  0.71218513 |  0.76923077 | 12 |
| SVF | ucm_AIR_T_mid |  0.70260472 |  0.65034965 | 12 |
| gvi_50m | ucm_SND_dBA | -0.69936918 | -0.81118881 | 12 |
| SVF | ucm_SND_dBA |  0.69322891 |  0.71328671 | 12 |
| atmo_pm2.5_avg | ucm_MRT |  0.69168360 |  0.76923077 | 12 |
| SVF | ucm_SUN_Gh |  0.69143283 |  0.79020979 | 12 |
| ucm_AIR_RH | ucm_UTCI | -0.69034495 | -0.72727273 | 12 |
| atmo_pm1_avg | SVF |  0.66846434 |  0.62937063 | 12 |
| ucm_AIR_RH | ucm_PET | -0.66342688 | -0.76223776 | 12 |
| atmo_pm1_avg | ucm_MRT |  0.65659530 |  0.68531469 | 12 |
| lys_lux_avg | ucm_AIR_RH | -0.64895132 | -0.58041958 | 12 |
| SVF | ucm_UTCI |  0.64298417 |  0.63636364 | 12 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.63398577 |  0.68531469 | 12 |
| atmo_pm2.5_avg | SVF |  0.61734997 |  0.65734266 | 12 |
| atmo_pm2.5_avg | gvi_50m | -0.61123419 | -0.74825175 | 12 |
| atmo_pm1_avg | gvi_50m | -0.59768681 | -0.62237762 | 12 |
| atmo_pm10_avg | lys_kelvin_avg | -0.59356661 | -0.53146853 | 12 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.59346721 |  0.64335664 | 12 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.59277368 |  0.61538462 | 12 |
| atmo_pm2.5_avg | ucm_UTCI |  0.58570479 |  0.55244755 | 12 |
| atmo_pm10_avg | ucm_MRT |  0.58546716 |  0.20979021 | 12 |
| ucm_AIR_T_mid | ucm_SND_dBA |  0.57774123 |  0.67132867 | 12 |
| SVF | ucm_PET |  0.57597290 |  0.62937063 | 12 |
| SVF | ucm_HUMIDEX |  0.57051673 |  0.50349650 | 12 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.55887724 |  0.20979021 | 12 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.55572663 | -0.48251748 | 12 |
| atmo_pm2.5_avg | ucm_AIR_T_mid |  0.55486096 |  0.62237762 | 12 |
| atmo_pm1_avg | ucm_UTCI |  0.53993468 |  0.40559441 | 12 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.53615871 |  0.26573427 | 12 |
| atmo_pm2.5_avg | lys_kelvin_avg | -0.52402832 | -0.26573427 | 12 |
| atmo_pm1_avg | ucm_AIR_T_mid |  0.52059845 |  0.46153846 | 12 |
| ucm_MRT | ucm_SND_dBA |  0.51489448 |  0.74825175 | 12 |
| gvi_50m | lys_lux_avg | -0.50952203 | -0.36363636 | 12 |
| atmo_pm2.5_avg | ucm_PET |  0.49842235 |  0.50349650 | 12 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.48209970 |  0.43356643 | 12 |
| ucm_SND_dBA | ucm_UTCI |  0.47786292 |  0.63636364 | 12 |
| atmo_pm1_avg | ucm_SND_dBA |  0.47377250 |  0.52447552 | 12 |
| atmo_pm10_avg | ucm_UTCI |  0.47251869 | -0.01398601 | 12 |
| lys_lux_avg | ucm_AIR_T_mid |  0.46984522 |  0.40559441 | 12 |
| lys_kelvin_avg | ucm_SUN_Gh | -0.46724926 | -0.25874126 | 12 |
| atmo_pm10_avg | gvi_50m | -0.46479572 | -0.20279720 | 12 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.45945952 |  0.39160839 | 12 |
| atmo_pm1_avg | ucm_PET |  0.45186409 |  0.37062937 | 12 |
| atmo_pm10_avg | SVF |  0.45092692 |  0.18881119 | 12 |
| lys_lux_avg | SVF |  0.44971383 |  0.37762238 | 12 |
| lys_lux_avg | ucm_SUN_Gh |  0.44587411 |  0.48251748 | 12 |
| lys_lux_avg | ucm_PET |  0.44011911 |  0.44755245 | 12 |
| atmo_pm10_avg | ucm_AIR_T_mid |  0.42990560 | -0.02097902 | 12 |
| lys_lux_avg | ucm_MRT |  0.42948996 |  0.37762238 | 12 |
| lys_kelvin_avg | lys_lux_avg |  0.42414061 |  0.36363636 | 12 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.41649445 |  0.30069930 | 12 |
| lys_kelvin_avg | ucm_PET | -0.41530568 | -0.09790210 | 12 |
| ucm_PET | ucm_SND_dBA |  0.41529010 |  0.65034965 | 12 |
| lys_kelvin_avg | ucm_UTCI | -0.41292259 | -0.13986014 | 12 |
| atmo_pm1_avg | lys_kelvin_avg | -0.41290366 | -0.11188811 | 12 |
| lys_kelvin_avg | ucm_MRT | -0.40212983 | -0.09090909 | 12 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.40134072 |  0.48951049 | 12 |
| lys_kelvin_avg | ucm_SND_dBA |  0.39934138 |  0.44755245 | 12 |
| lys_lux_avg | ucm_UTCI |  0.39251763 |  0.36363636 | 12 |
| atmo_pm10_avg | ucm_PET |  0.38902351 | -0.11888112 | 12 |
| atmo_pm1_avg | ucm_AIR_RH | -0.38136924 | -0.50349650 | 12 |
| lys_lux_avg | ucm_SND_dBA |  0.37577137 |  0.27272727 | 12 |
| ucm_PET | ucm_WIND_AWS | -0.36929989 | -0.10489510 | 12 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.36315675 | -0.40559441 | 12 |
| atmo_pm10_avg | ucm_HUMIDEX |  0.34895521 |  0.04895105 | 12 |
| lys_lux_avg | ucm_WIND_AWS |  0.34713280 |  0.30069930 | 12 |
| SVF | ucm_WIND_AWS |  0.34157004 |  0.38461538 | 12 |
| ucm_UTCI | ucm_WIND_AWS | -0.33327724 | -0.17482517 | 12 |
| lys_kelvin_avg | ucm_AIR_T_mid | -0.32272983 | -0.09790210 | 12 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.32059365 | -0.49650350 | 12 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.31874012 |  0.27972028 | 12 |
| atmo_pm10_avg | lys_lux_avg | -0.29483828 | -0.46153846 | 12 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.29056509 |  0.13286713 | 12 |
| lys_kelvin_avg | ucm_HUMIDEX | -0.26554657 | -0.18881119 | 12 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.25840605 | -0.25874126 | 12 |
| lys_lux_avg | ucm_HUMIDEX |  0.23724379 |  0.13986014 | 12 |
| atmo_pm10_avg | ucm_SND_dBA |  0.23237869 | -0.06293706 | 12 |
| lys_kelvin_avg | ucm_AIR_RH | -0.23112164 | -0.28671329 | 12 |
| ucm_MRT | ucm_WIND_AWS | -0.20663199 |  0.16783217 | 12 |
| ucm_AIR_T_mid | ucm_WIND_AWS | -0.19971981 |  0.02797203 | 12 |
| atmo_pm2.5_avg | lys_lux_avg | -0.17981559 |  0.04195804 | 12 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.17123424 | -0.16083916 | 12 |
| gvi_50m | lys_kelvin_avg |  0.16957070 | -0.04195804 | 12 |
| atmo_pm2.5_avg | ucm_WIND_AWS | -0.16193339 | -0.01398601 | 12 |
| atmo_pm1_avg | lys_lux_avg | -0.12835506 |  0.02797203 | 12 |
| atmo_pm10_avg | ucm_AIR_RH | -0.12818547 |  0.23776224 | 12 |
| gvi_50m | ucm_WIND_AWS |  0.04186372 | -0.11888112 | 12 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.03190701 |  0.24475524 | 12 |
| lys_kelvin_avg | SVF | -0.01447865 |  0.11888112 | 12 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

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
| ucm_PET | ucm_UTCI |  0.98766361 |  0.97477097 | 44 |
| ucm_AIR_T_mid | ucm_MRT |  0.95064954 |  0.96124031 | 44 |
| gvi_50m | ucm_MRT | -0.94919803 | -0.90894996 | 44 |
| ucm_MRT | ucm_UTCI |  0.94739647 |  0.85355884 | 44 |
| ucm_MRT | ucm_PET |  0.92819918 |  0.82875264 | 44 |
| gvi_50m | ucm_AIR_T_mid | -0.92751676 | -0.89048626 | 44 |
| ucm_SUN_Gh | ucm_UTCI |  0.90233767 |  0.76532770 | 44 |
| gvi_50m | ucm_UTCI | -0.90157936 | -0.78435518 | 44 |
| ucm_AIR_T_mid | ucm_UTCI |  0.90082026 |  0.81367160 | 44 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.89302159 |  0.79844961 | 44 |
| ucm_MRT | ucm_SUN_Gh |  0.89130152 |  0.76279070 | 44 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.88864433 |  0.42889359 | 44 |
| ucm_AIR_T_mid | ucm_PET |  0.88621758 |  0.80155039 | 44 |
| ucm_PET | ucm_SUN_Gh |  0.88423993 |  0.76617336 | 44 |
| gvi_50m | ucm_PET | -0.88393327 | -0.76983791 | 44 |
| ucm_AIR_T_mid | ucm_HUMIDEX |  0.87076353 |  0.89302326 | 44 |
| gvi_50m | ucm_AIR_RH |  0.84250570 |  0.83833686 | 44 |
| ucm_AIR_RH | ucm_AIR_T_mid | -0.83696117 | -0.83974630 | 44 |
| ucm_HUMIDEX | ucm_MRT |  0.81694897 |  0.86116984 | 44 |
| ucm_AIR_T_mid | ucm_SUN_Gh |  0.79619877 |  0.67921071 | 44 |
| ucm_HUMIDEX | ucm_UTCI |  0.78583746 |  0.76701903 | 44 |
| gvi_50m | ucm_HUMIDEX | -0.78409024 | -0.81127555 | 44 |
| gvi_50m | ucm_SUN_Gh | -0.76671506 | -0.62142354 | 44 |
| ucm_AIR_RH | ucm_MRT | -0.76421232 | -0.84016913 | 44 |
| ucm_AIR_RH | ucm_SND_dBA | -0.75991576 | -0.75137421 | 44 |
| ucm_HUMIDEX | ucm_PET |  0.74607461 |  0.73009161 | 44 |
| SVF | ucm_AIR_RH | -0.73398270 | -0.71515152 | 44 |
| ucm_AIR_RH | ucm_UTCI | -0.73068186 | -0.77181113 | 44 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.72964820 | -0.72501762 | 44 |
| SVF | ucm_AIR_T_mid |  0.71301878 |  0.73192389 | 44 |
| ucm_AIR_RH | ucm_PET | -0.70196122 | -0.77152925 | 44 |
| gvi_50m | SVF | -0.69473209 | -0.74799154 | 44 |
| SVF | ucm_MRT |  0.67033369 |  0.79746300 | 44 |
| atmo_pm1_avg | atmo_pm10_avg |  0.66483642 |  0.17519380 | 44 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.64413223 |  0.51627907 | 44 |
| SVF | ucm_SUN_Gh |  0.62815526 |  0.63664553 | 44 |
| SVF | ucm_UTCI |  0.62299252 |  0.63368569 | 44 |
| SVF | ucm_HUMIDEX |  0.61809906 |  0.64848485 | 44 |
| gvi_50m | ucm_SND_dBA | -0.60697898 | -0.71881607 | 44 |
| ucm_AIR_T_mid | ucm_SND_dBA |  0.59503082 |  0.66807611 | 44 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.58854861 |  0.61789993 | 44 |
| SVF | ucm_SND_dBA |  0.58037546 |  0.60183228 | 44 |
| SVF | ucm_PET |  0.56980027 |  0.61494010 | 44 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.56002660 | -0.58336857 | 44 |
| lys_lux_avg | ucm_AIR_RH | -0.52514125 | -0.58083157 | 44 |
| gvi_50m | lys_lux_avg | -0.51852086 | -0.48019732 | 44 |
| lys_lux_avg | ucm_AIR_T_mid |  0.51690850 |  0.51120507 | 44 |
| atmo_pm1_avg | SVF |  0.51564326 |  0.61930937 | 44 |
| lys_lux_avg | ucm_UTCI |  0.51168756 |  0.45102185 | 44 |
| lys_lux_avg | ucm_SUN_Gh |  0.50129813 |  0.52840028 | 44 |
| lys_lux_avg | ucm_MRT |  0.49429364 |  0.50951374 | 44 |
| lys_lux_avg | ucm_PET |  0.48349470 |  0.46229739 | 44 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.47366391 |  0.35503876 | 44 |
| ucm_MRT | ucm_SND_dBA |  0.47175457 |  0.67202255 | 44 |
| atmo_pm2.5_avg | ucm_MRT |  0.45268478 |  0.58844257 | 44 |
| atmo_pm1_avg | ucm_MRT |  0.45088103 |  0.57392530 | 44 |
| lys_lux_avg | SVF |  0.44698245 |  0.47258633 | 44 |
| atmo_pm1_avg | ucm_AIR_T_mid |  0.43884085 |  0.55419309 | 44 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.42121434 |  0.44087385 | 44 |
| atmo_pm1_avg | ucm_SND_dBA |  0.42023240 |  0.54883721 | 44 |
| atmo_pm2.5_avg | SVF |  0.41644463 |  0.54362227 | 44 |
| atmo_pm2.5_avg | ucm_AIR_T_mid |  0.40429042 |  0.57618041 | 44 |
| atmo_pm1_avg | gvi_50m | -0.40412752 | -0.50810430 | 44 |
| ucm_SND_dBA | ucm_UTCI |  0.40226629 |  0.57406624 | 44 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.39919546 |  0.40338266 | 44 |
| lys_lux_avg | ucm_HUMIDEX |  0.39472469 |  0.35644820 | 44 |
| atmo_pm2.5_avg | ucm_UTCI |  0.37439143 |  0.36081748 | 44 |
| atmo_pm1_avg | ucm_UTCI |  0.37205389 |  0.39436223 | 44 |
| ucm_PET | ucm_SND_dBA |  0.36992103 |  0.56532770 | 44 |
| atmo_pm1_avg | ucm_AIR_RH | -0.36601939 | -0.52980973 | 44 |
| lys_kelvin_avg | ucm_AIR_RH | -0.35803737 | -0.38830162 | 44 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.35657462 |  0.45059901 | 44 |
| lys_lux_avg | ucm_SND_dBA |  0.35377595 |  0.40352361 | 44 |
| atmo_pm2.5_avg | gvi_50m | -0.34759476 | -0.47343199 | 44 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.34662315 |  0.41634954 | 44 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.34250044 |  0.33037350 | 44 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.33887832 |  0.24721635 | 44 |
| atmo_pm2.5_avg | ucm_PET |  0.33251930 |  0.34066244 | 44 |
| atmo_pm1_avg | ucm_PET |  0.32926800 |  0.36631431 | 44 |
| atmo_pm10_avg | lys_kelvin_avg | -0.30629174 | -0.26892178 | 44 |
| SVF | ucm_WIND_AWS |  0.29442930 |  0.30556730 | 44 |
| lys_kelvin_avg | ucm_SND_dBA |  0.29044877 |  0.30429880 | 44 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.27850241 |  0.29358703 | 44 |
| atmo_pm10_avg | ucm_MRT |  0.27679688 |  0.09203665 | 44 |
| ucm_PET | ucm_WIND_AWS | -0.27634482 | -0.09443270 | 44 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.27462755 |  0.41254405 | 44 |
| ucm_UTCI | ucm_WIND_AWS | -0.25743478 | -0.10909091 | 44 |
| lys_kelvin_avg | SVF |  0.25357328 |  0.28329810 | 44 |
| atmo_pm2.5_avg | lys_kelvin_avg | -0.25291076 |  0.05313601 | 44 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.23716571 | -0.23932347 | 44 |
| atmo_pm10_avg | ucm_UTCI |  0.23587735 |  0.05665962 | 44 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.23457763 |  0.28146582 | 44 |
| gvi_50m | lys_kelvin_avg | -0.23427071 | -0.36363636 | 44 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.21544532 | -0.39577167 | 44 |
| atmo_pm10_avg | ucm_PET |  0.20027655 | -0.00324172 | 44 |
| atmo_pm10_avg | SVF |  0.18413205 |  0.12586328 | 44 |
| lys_kelvin_avg | ucm_AIR_T_mid |  0.18286244 |  0.28400282 | 44 |
| atmo_pm10_avg | ucm_AIR_T_mid |  0.17775392 |  0.02170543 | 44 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.17265844 | -0.08809020 | 44 |
| lys_kelvin_avg | ucm_MRT |  0.16704921 |  0.32332629 | 44 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.16091184 |  0.07202255 | 44 |
| atmo_pm10_avg | ucm_HUMIDEX |  0.15281943 |  0.09485553 | 44 |
| atmo_pm1_avg | lys_kelvin_avg | -0.14162305 |  0.09415081 | 44 |
| ucm_MRT | ucm_WIND_AWS | -0.13643918 |  0.13009161 | 44 |
| lys_kelvin_avg | ucm_UTCI |  0.12995046 |  0.21832276 | 44 |
| lys_kelvin_avg | ucm_PET |  0.10477992 |  0.21719521 | 44 |
| atmo_pm1_avg | lys_lux_avg |  0.10371619 |  0.26863989 | 44 |
| atmo_pm10_avg | gvi_50m | -0.10219317 |  0.08583510 | 44 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.09871552 |  0.20281889 | 44 |
| lys_kelvin_avg | lys_lux_avg |  0.08146938 |  0.27667371 | 44 |
| lys_lux_avg | ucm_WIND_AWS |  0.07193977 |  0.25680056 | 44 |
| gvi_50m | ucm_WIND_AWS |  0.06964157 | -0.08357999 | 44 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.06451352 |  0.22353770 | 44 |
| ucm_AIR_T_mid | ucm_WIND_AWS | -0.06216841 |  0.05482734 | 44 |
| atmo_pm2.5_avg | ucm_WIND_AWS | -0.05477384 |  0.13051445 | 44 |
| atmo_pm10_avg | lys_lux_avg | -0.05159662 | -0.04806202 | 44 |
| atmo_pm10_avg | ucm_AIR_RH |  0.04072436 |  0.15729387 | 44 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.03897735 | -0.03608175 | 44 |
| atmo_pm2.5_avg | lys_lux_avg |  0.03084078 |  0.31881607 | 44 |
| atmo_pm10_avg | ucm_SND_dBA | -0.02831725 | -0.21367160 | 44 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

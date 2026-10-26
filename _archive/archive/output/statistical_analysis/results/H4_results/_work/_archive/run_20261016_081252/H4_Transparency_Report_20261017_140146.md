# H4 measurement audit
Steps 1-2 retain the complete inventory and declared exposure representations. Step 3 groups candidates without outcome-based deletion.
Step 4 retains all 16 eligible candidates, specifies alternative heat/PM equations, and checks full-design VIF/rank; no automatic deletion.
Participant is the independent cluster. Step 4 defines seven equations (primary UTCI + PM2.5; optional Eq 2 sound-structure sensitivity; heat-form sensitivities on PM2.5; PM1/PM10 only with UTCI) including heat x sound and MRT x sound. Step 5 fits six by default (Eq 2 when H4_SPEC$fit_sound_sensitivity is TRUE). Earlier model outputs are historical until a verified rerun succeeds.
## Stage totals
| Stage | Entering | Retained | Not_Advanced |
| --- | --- | --- | --- |
| Step 1 | 230 | 124 | 106 |
| Step 2 | 124 |  16 | 108 |
| Step 3 |  16 |  16 |   0 |
## Measurement definitions and dependencies
| Variable_Name | Measurement_Code | Measurement_Type | Inputs_or_Definition | Evidence |
| --- | --- | --- | --- | --- |
| ucm_AIR_temp | M | Instrument | [UCM] | [CityFeel17] |
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
| SVF_Holmer | D | SVF | [SVF Holmer] | [SVF Qiu17] |
Step 2 representatives and averages are study choices, not automatic literature rules. LYS1 and LYS2 represent different wearers.
fp remains unverified; true wind speed (TWS) excluded (gaps, undocumented correction); SVF_Holmer from CamUp merge in merged_all_11participants_8min.csv (Step 2 Retained when coverage passes).
## Within-person design diagnostics
(none)
| Field1 | Field2 | Pearson_r | Spearman_rho | N_phase_cells |
| --- | --- | --- | --- | --- |
| ucm_PET | ucm_UTCI |  0.98786484 |  0.975439586 | 44 |
| ucm_AIR_temp | ucm_HUMIDEX |  0.95782379 |  0.961663143 | 44 |
| gvi_50m | ucm_MRT | -0.94826080 | -0.902325581 | 44 |
| ucm_MRT | ucm_UTCI |  0.94700053 |  0.850599013 | 44 |
| ucm_MRT | ucm_PET |  0.92763126 |  0.824905741 | 44 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.91076582 |  0.801578633 | 44 |
| ucm_SUN_Gh | ucm_UTCI |  0.90266681 |  0.760394644 | 44 |
| gvi_50m | ucm_UTCI | -0.90004304 | -0.776462297 | 44 |
| ucm_AIR_RH | ucm_AIR_temp | -0.89463989 | -0.858491896 | 44 |
| ucm_MRT | ucm_SUN_Gh |  0.89089165 |  0.755602537 | 44 |
| ucm_PET | ucm_SUN_Gh |  0.88503288 |  0.755488214 | 44 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.88501994 |  0.422551092 | 44 |
| gvi_50m | ucm_PET | -0.88184790 | -0.757320554 | 44 |
| gvi_50m | ucm_AIR_temp | -0.86393366 | -0.854968288 | 44 |
| ucm_AIR_temp | ucm_MRT |  0.85487909 |  0.919943622 | 44 |
| gvi_50m | ucm_AIR_RH |  0.84493213 |  0.840169133 | 44 |
| ucm_HUMIDEX | ucm_MRT |  0.82080114 |  0.864552502 | 44 |
| ucm_AIR_temp | ucm_UTCI |  0.81790518 |  0.808879493 | 44 |
| ucm_HUMIDEX | ucm_UTCI |  0.78876478 |  0.764763918 | 44 |
| gvi_50m | ucm_HUMIDEX | -0.78710041 | -0.799013390 | 44 |
| ucm_AIR_temp | ucm_PET |  0.77974774 |  0.775291589 | 44 |
| ucm_AIR_RH | ucm_MRT | -0.76581163 | -0.843128964 | 44 |
| gvi_50m | ucm_SUN_Gh | -0.76574916 | -0.625088090 | 44 |
| ucm_AIR_RH | ucm_SND_dBA | -0.76214471 | -0.747665528 | 44 |
| SVF_Holmer | ucm_AIR_RH | -0.75646391 | -0.742353770 | 44 |
| ucm_HUMIDEX | ucm_PET |  0.74962151 |  0.729624018 | 44 |
| SVF_Holmer | ucm_AIR_temp |  0.74407590 |  0.727977449 | 44 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.73266020 | -0.732064834 | 44 |
| ucm_AIR_RH | ucm_UTCI | -0.73264194 | -0.776180409 | 44 |
| gvi_50m | SVF_Holmer | -0.72418903 | -0.773502467 | 44 |
| ucm_AIR_temp | ucm_SND_dBA |  0.70374048 |  0.710807288 | 44 |
| ucm_AIR_RH | ucm_PET | -0.70356267 | -0.768807922 | 44 |
| SVF_Holmer | ucm_MRT |  0.69279830 |  0.805073996 | 44 |
| atmo_pm1_avg | atmo_pm10_avg |  0.68660155 |  0.172733359 | 44 |
| SVF_Holmer | ucm_HUMIDEX |  0.65642464 |  0.675405215 | 44 |
| ucm_AIR_temp | ucm_SUN_Gh |  0.65352894 |  0.564200141 | 44 |
| SVF_Holmer | ucm_UTCI |  0.64959899 |  0.662438337 | 44 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.64713532 |  0.513178295 | 44 |
| SVF_Holmer | ucm_SUN_Gh |  0.63166147 |  0.635095137 | 44 |
| gvi_50m | ucm_SND_dBA | -0.60895015 | -0.707072131 | 44 |
| SVF_Holmer | ucm_SND_dBA |  0.60454859 |  0.622995878 | 44 |
| SVF_Holmer | ucm_PET |  0.59433567 |  0.634271821 | 44 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.59096328 |  0.627858628 | 44 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.56374030 | -0.576603242 | 44 |
| lys_lux_avg | ucm_AIR_RH | -0.52412201 | -0.564482030 | 44 |
| gvi_50m | lys_lux_avg | -0.51600285 | -0.485976039 | 44 |
| lys_lux_avg | ucm_UTCI |  0.50638958 |  0.440310078 | 44 |
| atmo_pm1_avg | SVF_Holmer |  0.49858668 |  0.613199902 | 44 |
| lys_lux_avg | ucm_SUN_Gh |  0.49634607 |  0.521494010 | 44 |
| lys_lux_avg | ucm_MRT |  0.49078068 |  0.502466526 | 44 |
| lys_lux_avg | ucm_PET |  0.47857485 |  0.440677966 | 44 |
| ucm_MRT | ucm_SND_dBA |  0.47176981 |  0.677825153 | 44 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.46927284 |  0.355474118 | 44 |
| lys_lux_avg | ucm_AIR_temp |  0.45857114 |  0.464411557 | 44 |
| atmo_pm2.5_avg | ucm_MRT |  0.44790356 |  0.587315011 | 44 |
| atmo_pm1_avg | ucm_MRT |  0.44696049 |  0.573029353 | 44 |
| lys_lux_avg | SVF_Holmer |  0.43753260 |  0.450035236 | 44 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.41657665 |  0.440451022 | 44 |
| atmo_pm2.5_avg | SVF_Holmer |  0.40961857 |  0.533756166 | 44 |
| ucm_SND_dBA | ucm_UTCI |  0.40449555 |  0.575566440 | 44 |
| atmo_pm1_avg | ucm_SND_dBA |  0.40286857 |  0.545845373 | 44 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.39955925 |  0.407977730 | 44 |
| atmo_pm1_avg | gvi_50m | -0.39641999 | -0.497691956 | 44 |
| lys_lux_avg | ucm_HUMIDEX |  0.39306558 |  0.345736434 | 44 |
| atmo_pm1_avg | ucm_AIR_temp |  0.37516432 |  0.485076994 | 44 |
| ucm_PET | ucm_SND_dBA |  0.37242555 |  0.566847558 | 44 |
| atmo_pm2.5_avg | ucm_UTCI |  0.36687421 |  0.350669486 | 44 |
| atmo_pm1_avg | ucm_UTCI |  0.36677418 |  0.392684732 | 44 |
| lys_kelvin_avg | ucm_AIR_RH | -0.35985728 | -0.389006342 | 44 |
| lys_lux_avg | ucm_SND_dBA |  0.35566632 |  0.391275239 | 44 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.34829820 |  0.448062016 | 44 |
| atmo_pm1_avg | ucm_AIR_RH | -0.34585888 | -0.528771275 | 44 |
| atmo_pm2.5_avg | gvi_50m | -0.34478408 | -0.480338266 | 44 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.34012708 |  0.322057787 | 44 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.33880859 |  0.415588992 | 44 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.33160934 |  0.236927414 | 44 |
| atmo_pm2.5_avg | ucm_AIR_temp |  0.32883380 |  0.484707541 | 44 |
| atmo_pm2.5_avg | ucm_PET |  0.32674463 |  0.327425209 | 44 |
| lys_kelvin_avg | ucm_AIR_temp |  0.32550192 |  0.347568710 | 44 |
| atmo_pm1_avg | ucm_PET |  0.32473776 |  0.354640919 | 44 |
| atmo_pm10_avg | lys_kelvin_avg | -0.30348248 | -0.251162791 | 44 |
| lys_kelvin_avg | ucm_SND_dBA |  0.29147426 |  0.294513549 | 44 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.27722936 |  0.291190980 | 44 |
| ucm_PET | ucm_WIND_AWS | -0.27703924 | -0.100849220 | 44 |
| lys_kelvin_avg | SVF_Holmer |  0.27407879 |  0.297392530 | 44 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.27330055 |  0.432643857 | 44 |
| atmo_pm10_avg | ucm_MRT |  0.26954487 |  0.074418605 | 44 |
| ucm_UTCI | ucm_WIND_AWS | -0.25891354 | -0.111909796 | 44 |
| atmo_pm2.5_avg | lys_kelvin_avg | -0.25757388 |  0.064975335 | 44 |
| SVF_Holmer | ucm_WIND_AWS |  0.24661748 |  0.257364341 | 44 |
| gvi_50m | lys_kelvin_avg | -0.23855029 | -0.339957717 | 44 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.23783953 | -0.238900634 | 44 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.23447637 |  0.279502449 | 44 |
| atmo_pm10_avg | ucm_UTCI |  0.22480579 |  0.038759690 | 44 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.21054789 | -0.395348837 | 44 |
| atmo_pm10_avg | ucm_PET |  0.19149205 | -0.014235879 | 44 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.18007254 | -0.104157858 | 44 |
| atmo_pm10_avg | SVF_Holmer |  0.17694353 |  0.093587033 | 44 |
| lys_kelvin_avg | ucm_MRT |  0.17021846 |  0.319238901 | 44 |
| atmo_pm1_avg | lys_kelvin_avg | -0.16409646 |  0.082384862 | 44 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.16158467 |  0.058773784 | 44 |
| atmo_pm10_avg | ucm_HUMIDEX |  0.14325574 |  0.080761099 | 44 |
| ucm_MRT | ucm_WIND_AWS | -0.14005856 |  0.128541226 | 44 |
| lys_kelvin_avg | ucm_UTCI |  0.13555108 |  0.225088090 | 44 |
| lys_kelvin_avg | ucm_PET |  0.11061857 |  0.216427640 | 44 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.09915449 |  0.187315011 | 44 |
| atmo_pm10_avg | gvi_50m | -0.09562257 |  0.077237491 | 44 |
| lys_kelvin_avg | lys_lux_avg |  0.08722126 |  0.276391825 | 44 |
| atmo_pm1_avg | lys_lux_avg |  0.08553791 |  0.269635999 | 44 |
| atmo_pm10_avg | ucm_AIR_temp |  0.08358951 |  0.007751938 | 44 |
| lys_lux_avg | ucm_WIND_AWS |  0.07820608 |  0.268217054 | 44 |
| ucm_AIR_temp | ucm_WIND_AWS |  0.07225603 |  0.055532065 | 44 |
| gvi_50m | ucm_WIND_AWS |  0.07017958 | -0.082734320 | 44 |
| atmo_pm2.5_avg | ucm_WIND_AWS | -0.06470749 |  0.132064834 | 44 |
| atmo_pm10_avg | lys_lux_avg | -0.05841274 | -0.054545455 | 44 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.04678522 |  0.215440995 | 44 |
| atmo_pm10_avg | ucm_AIR_RH |  0.04552501 |  0.159830867 | 44 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.04401701 | -0.036081748 | 44 |
| atmo_pm10_avg | ucm_SND_dBA | -0.02662553 | -0.201487015 | 44 |
| atmo_pm2.5_avg | lys_lux_avg |  0.02129100 |  0.323890063 | 44 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

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
| ucm_PET | ucm_UTCI |  0.988419035 |  0.99248120 | 20 |
| gvi_50m | ucm_MRT | -0.959401827 | -0.86165414 | 20 |
| ucm_MRT | ucm_UTCI |  0.939244610 |  0.88270677 | 20 |
| ucm_AIR_T_mid | ucm_MRT |  0.939003346 |  0.96090226 | 20 |
| ucm_MRT | ucm_PET |  0.935991695 |  0.86466165 | 20 |
| ucm_AIR_RH | ucm_AIR_T_mid | -0.925483131 | -0.92180451 | 20 |
| gvi_50m | ucm_UTCI | -0.923688848 | -0.78496241 | 20 |
| gvi_50m | ucm_PET | -0.913969061 | -0.75789474 | 20 |
| ucm_AIR_T_mid | ucm_UTCI |  0.906978722 |  0.84360902 | 20 |
| ucm_AIR_T_mid | ucm_HUMIDEX |  0.906556598 |  0.79248120 | 20 |
| gvi_50m | ucm_AIR_T_mid | -0.902843128 | -0.86917293 | 20 |
| ucm_AIR_T_mid | ucm_PET |  0.889325361 |  0.82556391 | 20 |
| ucm_AIR_RH | ucm_MRT | -0.855724163 | -0.91428571 | 20 |
| gvi_50m | ucm_AIR_RH |  0.843131895 |  0.81804511 | 20 |
| ucm_AIR_RH | ucm_UTCI | -0.823618633 | -0.85864662 | 20 |
| ucm_AIR_RH | ucm_SND_dBA | -0.820647425 | -0.75939850 | 20 |
| ucm_HUMIDEX | ucm_UTCI |  0.814858019 |  0.65263158 | 20 |
| ucm_HUMIDEX | ucm_MRT |  0.809201852 |  0.75939850 | 20 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.800532452 | -0.68721805 | 20 |
| ucm_SUN_Gh | ucm_UTCI |  0.798588212 |  0.67819549 | 20 |
| ucm_HUMIDEX | ucm_PET |  0.788934648 |  0.64661654 | 20 |
| ucm_PET | ucm_SUN_Gh |  0.784393198 |  0.67819549 | 20 |
| ucm_AIR_RH | ucm_PET | -0.768803202 | -0.82706767 | 20 |
| gvi_50m | ucm_HUMIDEX | -0.764926200 | -0.61353383 | 20 |
| ucm_MRT | ucm_SUN_Gh |  0.731704880 |  0.69022556 | 20 |
| SVF | ucm_SUN_Gh |  0.709629224 |  0.69774436 | 20 |
| ucm_AIR_T_mid | ucm_SUN_Gh |  0.708032846 |  0.63909774 | 20 |
| ucm_AIR_T_mid | ucm_SND_dBA |  0.701950505 |  0.71127820 | 20 |
| SVF | ucm_AIR_RH | -0.671661771 | -0.72481203 | 20 |
| gvi_50m | ucm_SND_dBA | -0.665155008 | -0.67218045 | 20 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.647448615 |  0.62255639 | 20 |
| gvi_50m | ucm_SUN_Gh | -0.639366441 | -0.56842105 | 20 |
| SVF | ucm_AIR_T_mid |  0.623147239 |  0.66315789 | 20 |
| SVF | ucm_UTCI |  0.614502816 |  0.63308271 | 20 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.605811266 | -0.67669173 | 20 |
| ucm_SND_dBA | ucm_UTCI |  0.603196883 |  0.72481203 | 20 |
| lys_lux_avg | ucm_SUN_Gh |  0.590545168 |  0.57894737 | 20 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.578612336 |  0.38045113 | 20 |
| ucm_MRT | ucm_SND_dBA |  0.575113517 |  0.66165414 | 20 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.565139692 |  0.52330827 | 20 |
| lys_lux_avg | ucm_SND_dBA |  0.563125601 |  0.63007519 | 20 |
| lys_lux_avg | ucm_AIR_T_mid |  0.555892546 |  0.60000000 | 20 |
| ucm_PET | ucm_SND_dBA |  0.549123011 |  0.70827068 | 20 |
| SVF | ucm_PET |  0.548535853 |  0.59248120 | 20 |
| SVF | ucm_MRT |  0.543985290 |  0.68270677 | 20 |
| lys_lux_avg | ucm_UTCI |  0.539178567 |  0.56090226 | 20 |
| gvi_50m | SVF | -0.535918985 | -0.63609023 | 20 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.523192004 |  0.47819549 | 20 |
| lys_lux_avg | ucm_AIR_RH | -0.521320105 | -0.60451128 | 20 |
| SVF | ucm_HUMIDEX |  0.520609628 |  0.52781955 | 20 |
| lys_lux_avg | ucm_MRT |  0.510852031 |  0.59097744 | 20 |
| lys_lux_avg | ucm_PET |  0.493615691 |  0.56390977 | 20 |
| gvi_50m | lys_lux_avg | -0.477075450 | -0.56992481 | 20 |
| SVF | ucm_SND_dBA |  0.471207472 |  0.50827068 | 20 |
| atmo_pm1_avg | ucm_SND_dBA |  0.468474559 |  0.49022556 | 20 |
| atmo_pm10_avg | ucm_SND_dBA | -0.441371076 | -0.33233083 | 20 |
| lys_lux_avg | SVF |  0.398288383 |  0.52330827 | 20 |
| atmo_pm1_avg | ucm_AIR_RH | -0.393071939 | -0.50977444 | 20 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.385494608 |  0.36240602 | 20 |
| atmo_pm10_avg | gvi_50m |  0.385024567 |  0.46616541 | 20 |
| SVF | ucm_WIND_AWS |  0.384965538 |  0.39097744 | 20 |
| atmo_pm1_avg | SVF |  0.376945106 |  0.58796992 | 20 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.373831299 |  0.35037594 | 20 |
| lys_lux_avg | ucm_HUMIDEX |  0.370111135 |  0.20150376 | 20 |
| atmo_pm1_avg | ucm_AIR_T_mid |  0.316579807 |  0.51428571 | 20 |
| lys_kelvin_avg | ucm_AIR_RH | -0.263752835 | -0.31879699 | 20 |
| lys_kelvin_avg | ucm_MRT |  0.260605717 |  0.42857143 | 20 |
| atmo_pm10_avg | ucm_AIR_RH |  0.257243961 |  0.17293233 | 20 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.256657227 |  0.29022556 | 20 |
| lys_kelvin_avg | ucm_PET |  0.254323650 |  0.24360902 | 20 |
| lys_kelvin_avg | ucm_AIR_T_mid |  0.250748698 |  0.34887218 | 20 |
| atmo_pm10_avg | ucm_AIR_T_mid | -0.245016104 | -0.25413534 | 20 |
| atmo_pm2.5_avg | lys_lux_avg |  0.240670075 |  0.38195489 | 20 |
| atmo_pm1_avg | lys_lux_avg |  0.238601829 |  0.37744361 | 20 |
| lys_kelvin_avg | ucm_UTCI |  0.238277005 |  0.24812030 | 20 |
| lys_kelvin_avg | SVF |  0.231764798 |  0.19548872 | 20 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.229905529 |  0.32631579 | 20 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.225992834 | -0.27969925 | 20 |
| lys_kelvin_avg | lys_lux_avg | -0.224105734 |  0.06165414 | 20 |
| atmo_pm1_avg | gvi_50m | -0.217345821 | -0.43007519 | 20 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.216200877 |  0.21804511 | 20 |
| ucm_SUN_Gh | ucm_WIND_AWS |  0.211394163 |  0.32180451 | 20 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.203815007 |  0.36541353 | 20 |
| atmo_pm1_avg | ucm_MRT |  0.199402656 |  0.43308271 | 20 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.199126740 |  0.22857143 | 20 |
| gvi_50m | lys_kelvin_avg | -0.197151563 | -0.34887218 | 20 |
| atmo_pm10_avg | ucm_MRT | -0.192224527 | -0.22255639 | 20 |
| atmo_pm2.5_avg | SVF |  0.185786095 |  0.27368421 | 20 |
| atmo_pm1_avg | ucm_UTCI |  0.185124439 |  0.32481203 | 20 |
| lys_lux_avg | ucm_WIND_AWS |  0.184608402 |  0.36090226 | 20 |
| atmo_pm10_avg | ucm_HUMIDEX | -0.181776638 | -0.03759398 | 20 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.160540141 |  0.35939850 | 20 |
| atmo_pm1_avg | ucm_PET |  0.159437424 |  0.31729323 | 20 |
| ucm_PET | ucm_WIND_AWS | -0.156127198 | -0.02556391 | 20 |
| atmo_pm10_avg | ucm_UTCI | -0.155834981 | -0.22857143 | 20 |
| atmo_pm10_avg | ucm_PET | -0.153949749 | -0.22255639 | 20 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.149810612 |  0.30075188 | 20 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.147559441 | -0.32030075 | 20 |
| atmo_pm10_avg | SVF | -0.140218426 | -0.06315789 | 20 |
| atmo_pm2.5_avg | ucm_AIR_T_mid |  0.133737828 |  0.37443609 | 20 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.128351677 | -0.09624060 | 20 |
| atmo_pm1_avg | atmo_pm10_avg | -0.113108319 |  0.07368421 | 20 |
| ucm_UTCI | ucm_WIND_AWS | -0.108244605 |  0.02556391 | 20 |
| gvi_50m | ucm_WIND_AWS |  0.091409132 | -0.07969925 | 20 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.078414567 |  0.21654135 | 20 |
| atmo_pm2.5_avg | gvi_50m |  0.058928279 | -0.15789474 | 20 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.057151030 | -0.01353383 | 20 |
| atmo_pm2.5_avg | ucm_WIND_AWS |  0.051634865 |  0.14436090 | 20 |
| atmo_pm2.5_avg | ucm_MRT |  0.048449614 |  0.30526316 | 20 |
| lys_kelvin_avg | ucm_SND_dBA |  0.047216143 |  0.10075188 | 20 |
| ucm_AIR_T_mid | ucm_WIND_AWS |  0.046276306 |  0.13082707 | 20 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.044724374 |  0.03609023 | 20 |
| ucm_MRT | ucm_WIND_AWS | -0.038314383 |  0.20300752 | 20 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.036937182 |  0.14436090 | 20 |
| atmo_pm1_avg | lys_kelvin_avg |  0.030172681 |  0.01954887 | 20 |
| atmo_pm2.5_avg | ucm_PET | -0.017164128 |  0.19248120 | 20 |
| atmo_pm2.5_avg | ucm_UTCI |  0.015989541 |  0.19097744 | 20 |
| atmo_pm2.5_avg | lys_kelvin_avg |  0.008521425 |  0.05263158 | 20 |
| atmo_pm10_avg | lys_kelvin_avg | -0.006500972 | -0.22255639 | 20 |
| atmo_pm10_avg | lys_lux_avg |  0.001457208 | -0.09323308 | 20 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

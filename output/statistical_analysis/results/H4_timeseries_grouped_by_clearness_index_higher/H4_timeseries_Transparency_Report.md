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
| ucm_PET | ucm_UTCI |  0.987891830 |  0.972173913 | 24 |
| gvi_50m | ucm_MRT | -0.967667976 | -0.917391304 | 24 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.964610566 |  0.883478261 | 24 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.959667627 |  0.361739130 | 24 |
| gvi_50m | ucm_AIR_T_mid | -0.957360425 | -0.869565217 | 24 |
| ucm_AIR_T_mid | ucm_MRT |  0.956444876 |  0.933043478 | 24 |
| ucm_MRT | ucm_UTCI |  0.950830164 |  0.832173913 | 24 |
| ucm_MRT | ucm_SUN_Gh |  0.945786198 |  0.763478261 | 24 |
| ucm_SUN_Gh | ucm_UTCI |  0.941811893 |  0.721739130 | 24 |
| ucm_PET | ucm_SUN_Gh |  0.927893421 |  0.724347826 | 24 |
| ucm_MRT | ucm_PET |  0.926317473 |  0.831304348 | 24 |
| gvi_50m | ucm_UTCI | -0.907633633 | -0.756521739 | 24 |
| ucm_AIR_T_mid | ucm_UTCI |  0.898439352 |  0.799130435 | 24 |
| atmo_pm1_avg | atmo_pm10_avg |  0.897389143 |  0.248695652 | 24 |
| ucm_AIR_T_mid | ucm_PET |  0.884835626 |  0.811304348 | 24 |
| ucm_AIR_T_mid | ucm_HUMIDEX |  0.884649696 |  0.901739130 | 24 |
| gvi_50m | ucm_PET | -0.878372894 | -0.778260870 | 24 |
| gvi_50m | ucm_AIR_RH |  0.864354096 |  0.869565217 | 24 |
| gvi_50m | ucm_SUN_Gh | -0.862461012 | -0.631304348 | 24 |
| gvi_50m | ucm_HUMIDEX | -0.858563453 | -0.820869565 | 24 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.850062462 | -0.811304348 | 24 |
| gvi_50m | SVF | -0.838946537 | -0.826956522 | 24 |
| ucm_AIR_RH | ucm_AIR_T_mid | -0.835080132 | -0.833913043 | 24 |
| ucm_AIR_T_mid | ucm_SUN_Gh |  0.833409388 |  0.632173913 | 24 |
| ucm_HUMIDEX | ucm_MRT |  0.833212463 |  0.883478261 | 24 |
| SVF | ucm_AIR_RH | -0.820085628 | -0.757391304 | 24 |
| SVF | ucm_AIR_T_mid |  0.795848596 |  0.760869565 | 24 |
| ucm_HUMIDEX | ucm_UTCI |  0.795358186 |  0.828695652 | 24 |
| ucm_AIR_RH | ucm_SND_dBA | -0.778805521 | -0.761739130 | 24 |
| SVF | ucm_MRT |  0.777862207 |  0.879130435 | 24 |
| ucm_AIR_RH | ucm_MRT | -0.775283949 | -0.855652174 | 24 |
| ucm_HUMIDEX | ucm_PET |  0.756114938 |  0.797391304 | 24 |
| SVF | ucm_HUMIDEX |  0.731484381 |  0.692173913 | 24 |
| ucm_AIR_RH | ucm_UTCI | -0.727153378 | -0.750434783 | 24 |
| ucm_AIR_RH | ucm_PET | -0.702871724 | -0.786086957 | 24 |
| SVF | ucm_SND_dBA |  0.672100528 |  0.707826087 | 24 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.661932104 |  0.547826087 | 24 |
| SVF | ucm_UTCI |  0.652308421 |  0.612173913 | 24 |
| SVF | ucm_SUN_Gh |  0.630210642 |  0.653043478 | 24 |
| atmo_pm1_avg | SVF |  0.624135152 |  0.660869565 | 24 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.620582353 |  0.645217391 | 24 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.612097036 | -0.578260870 | 24 |
| SVF | ucm_PET |  0.601086027 |  0.623478261 | 24 |
| gvi_50m | ucm_SND_dBA | -0.583569385 | -0.723478261 | 24 |
| gvi_50m | lys_lux_avg | -0.577359454 | -0.491304348 | 24 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.576636227 |  0.474782609 | 24 |
| atmo_pm2.5_avg | SVF |  0.559401210 |  0.736521739 | 24 |
| ucm_AIR_T_mid | ucm_SND_dBA |  0.547904834 |  0.641739130 | 24 |
| atmo_pm2.5_avg | ucm_MRT |  0.542572758 |  0.746956522 | 24 |
| atmo_pm1_avg | ucm_MRT |  0.539283950 |  0.658260870 | 24 |
| lys_lux_avg | ucm_UTCI |  0.537828619 |  0.398260870 | 24 |
| lys_lux_avg | ucm_MRT |  0.532654308 |  0.442608696 | 24 |
| lys_lux_avg | ucm_AIR_RH | -0.530940161 | -0.579130435 | 24 |
| lys_lux_avg | ucm_AIR_T_mid |  0.527712302 |  0.477391304 | 24 |
| lys_lux_avg | ucm_SUN_Gh |  0.515335421 |  0.501739130 | 24 |
| atmo_pm1_avg | gvi_50m | -0.513880557 | -0.596521739 | 24 |
| lys_lux_avg | ucm_PET |  0.513274995 |  0.432173913 | 24 |
| lys_lux_avg | SVF |  0.511798918 |  0.500000000 | 24 |
| atmo_pm2.5_avg | gvi_50m | -0.498053020 | -0.706086957 | 24 |
| atmo_pm10_avg | lys_kelvin_avg | -0.495070480 | -0.336521739 | 24 |
| lys_lux_avg | ucm_HUMIDEX |  0.489785244 |  0.418260870 | 24 |
| atmo_pm1_avg | ucm_AIR_T_mid |  0.487052882 |  0.544347826 | 24 |
| lys_kelvin_avg | ucm_AIR_RH | -0.481993125 | -0.501739130 | 24 |
| atmo_pm2.5_avg | ucm_AIR_T_mid |  0.479903311 |  0.662608696 | 24 |
| lys_kelvin_avg | lys_lux_avg |  0.470945484 |  0.530434783 | 24 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.470116069 |  0.480869565 | 24 |
| lys_kelvin_avg | ucm_SND_dBA |  0.468793144 |  0.472173913 | 24 |
| atmo_pm2.5_avg | ucm_UTCI |  0.457761694 |  0.435652174 | 24 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.451875349 |  0.404347826 | 24 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.450028279 |  0.403478261 | 24 |
| atmo_pm1_avg | ucm_UTCI |  0.440859293 |  0.380869565 | 24 |
| ucm_MRT | ucm_SND_dBA |  0.430133476 |  0.693913043 | 24 |
| atmo_pm10_avg | ucm_MRT |  0.429545278 |  0.241739130 | 24 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.420176353 |  0.313043478 | 24 |
| atmo_pm2.5_avg | ucm_PET |  0.419808485 |  0.443478261 | 24 |
| atmo_pm1_avg | ucm_SND_dBA |  0.403450605 |  0.580000000 | 24 |
| atmo_pm1_avg | ucm_PET |  0.396533592 |  0.385217391 | 24 |
| atmo_pm1_avg | ucm_AIR_RH | -0.393284378 | -0.575652174 | 24 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.383224892 |  0.450434783 | 24 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.382161539 |  0.514782609 | 24 |
| atmo_pm2.5_avg | lys_kelvin_avg | -0.379749409 |  0.036521739 | 24 |
| atmo_pm10_avg | ucm_UTCI |  0.369047740 |  0.161739130 | 24 |
| atmo_pm10_avg | SVF |  0.367382035 |  0.234782609 | 24 |
| atmo_pm10_avg | gvi_50m | -0.336957386 | -0.154782609 | 24 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.333847669 |  0.615652174 | 24 |
| atmo_pm10_avg | ucm_PET |  0.328930280 |  0.058260870 | 24 |
| atmo_pm10_avg | ucm_AIR_T_mid |  0.328050448 |  0.113913043 | 24 |
| ucm_PET | ucm_WIND_AWS | -0.326503553 | -0.086956522 | 24 |
| ucm_SND_dBA | ucm_UTCI |  0.317530074 |  0.493913043 | 24 |
| ucm_UTCI | ucm_WIND_AWS | -0.315453607 | -0.162608696 | 24 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.305644224 | -0.536521739 | 24 |
| ucm_PET | ucm_SND_dBA |  0.289632082 |  0.546956522 | 24 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.279804494 |  0.070434783 | 24 |
| lys_kelvin_avg | SVF |  0.276255640 |  0.352173913 | 24 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.271665350 | -0.267826087 | 24 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.270706908 |  0.307826087 | 24 |
| gvi_50m | lys_kelvin_avg | -0.270051453 | -0.416521739 | 24 |
| SVF | ucm_WIND_AWS |  0.253711054 |  0.304347826 | 24 |
| atmo_pm1_avg | lys_kelvin_avg | -0.252477997 |  0.131304348 | 24 |
| atmo_pm10_avg | ucm_HUMIDEX |  0.225124833 |  0.186956522 | 24 |
| lys_lux_avg | ucm_SND_dBA |  0.215762133 |  0.273043478 | 24 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.209799848 | -0.177391304 | 24 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.187898187 |  0.252173913 | 24 |
| ucm_MRT | ucm_WIND_AWS | -0.173043195 |  0.134782609 | 24 |
| lys_kelvin_avg | ucm_AIR_T_mid |  0.142825379 |  0.246086957 | 24 |
| lys_kelvin_avg | ucm_MRT |  0.116113127 |  0.259130435 | 24 |
| atmo_pm10_avg | ucm_SND_dBA |  0.114278230 | -0.116521739 | 24 |
| ucm_AIR_T_mid | ucm_WIND_AWS | -0.106257910 |  0.029565217 | 24 |
| atmo_pm10_avg | ucm_AIR_RH | -0.093879179 |  0.137391304 | 24 |
| atmo_pm10_avg | lys_lux_avg | -0.093165023 | -0.089565217 | 24 |
| atmo_pm2.5_avg | ucm_WIND_AWS | -0.074677464 |  0.144347826 | 24 |
| lys_kelvin_avg | ucm_UTCI |  0.063907670 |  0.204347826 | 24 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.059770407 |  0.226086957 | 24 |
| gvi_50m | ucm_WIND_AWS |  0.059730163 | -0.080869565 | 24 |
| atmo_pm2.5_avg | lys_lux_avg | -0.028703135 |  0.251304348 | 24 |
| atmo_pm1_avg | lys_lux_avg |  0.022584294 |  0.219130435 | 24 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.020646337 |  0.155652174 | 24 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.017622930 | -0.002608696 | 24 |
| lys_lux_avg | ucm_WIND_AWS | -0.003940436 |  0.221739130 | 24 |
| lys_kelvin_avg | ucm_PET |  0.002855965 |  0.239130435 | 24 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

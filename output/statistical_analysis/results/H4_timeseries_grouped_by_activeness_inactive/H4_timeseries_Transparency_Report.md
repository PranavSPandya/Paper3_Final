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
| ucm_PET | ucm_UTCI |  0.987609487 |  0.977443609 | 20 |
| gvi_50m | ucm_MRT | -0.948559659 | -0.885714286 | 20 |
| ucm_MRT | ucm_UTCI |  0.940209770 |  0.790977444 | 20 |
| ucm_AIR_T_mid | ucm_MRT |  0.935254067 |  0.951879699 | 20 |
| ucm_SUN_Gh | ucm_UTCI |  0.923639098 |  0.690225564 | 20 |
| ucm_MRT | ucm_PET |  0.922298413 |  0.815037594 | 20 |
| gvi_50m | ucm_AIR_T_mid | -0.919817805 | -0.861654135 | 20 |
| ucm_MRT | ucm_SUN_Gh |  0.915576504 |  0.741353383 | 20 |
| ucm_PET | ucm_SUN_Gh |  0.914125723 |  0.723308271 | 20 |
| gvi_50m | ucm_AIR_RH |  0.903831499 |  0.956390977 | 20 |
| ucm_AIR_T_mid | ucm_UTCI |  0.872044647 |  0.754887218 | 20 |
| ucm_AIR_T_mid | ucm_PET |  0.863781747 |  0.780451128 | 20 |
| ucm_AIR_T_mid | ucm_HUMIDEX |  0.862140293 |  0.893233083 | 20 |
| ucm_AIR_RH | ucm_AIR_T_mid | -0.859734041 | -0.845112782 | 20 |
| gvi_50m | ucm_UTCI | -0.855159136 | -0.691729323 | 20 |
| gvi_50m | ucm_PET | -0.828131452 | -0.712781955 | 20 |
| SVF | ucm_AIR_RH | -0.827858601 | -0.753383459 | 20 |
| gvi_50m | SVF | -0.806622703 | -0.804511278 | 20 |
| ucm_AIR_RH | ucm_MRT | -0.803235758 | -0.888721805 | 20 |
| ucm_HUMIDEX | ucm_MRT |  0.800015498 |  0.851127820 | 20 |
| ucm_AIR_RH | ucm_SND_dBA | -0.795803302 | -0.765413534 | 20 |
| SVF | ucm_AIR_T_mid |  0.781232240 |  0.753383459 | 20 |
| ucm_HUMIDEX | ucm_UTCI |  0.779339481 |  0.732330827 | 20 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.779339140 | -0.789473684 | 20 |
| atmo_pm1_avg | SVF |  0.779092564 |  0.834586466 | 20 |
| gvi_50m | ucm_SUN_Gh | -0.778447578 | -0.554887218 | 20 |
| ucm_AIR_T_mid | ucm_SUN_Gh |  0.777904390 |  0.618045113 | 20 |
| lys_lux_avg | ucm_SUN_Gh |  0.759385368 |  0.759398496 | 20 |
| gvi_50m | ucm_HUMIDEX | -0.751568549 | -0.765413534 | 20 |
| SVF | ucm_MRT |  0.747864249 |  0.833082707 | 20 |
| ucm_HUMIDEX | ucm_PET |  0.744398884 |  0.732330827 | 20 |
| lys_lux_avg | ucm_MRT |  0.742799268 |  0.657142857 | 20 |
| lys_lux_avg | ucm_UTCI |  0.716838860 |  0.562406015 | 20 |
| ucm_AIR_RH | ucm_UTCI | -0.695663475 | -0.691729323 | 20 |
| atmo_pm1_avg | ucm_SND_dBA |  0.694216118 |  0.706766917 | 20 |
| atmo_pm1_avg | ucm_AIR_RH | -0.690311320 | -0.685714286 | 20 |
| lys_lux_avg | ucm_AIR_T_mid |  0.680959158 |  0.581954887 | 20 |
| gvi_50m | lys_lux_avg | -0.671749492 | -0.601503759 | 20 |
| ucm_AIR_RH | ucm_PET | -0.669926413 | -0.709774436 | 20 |
| lys_lux_avg | ucm_PET |  0.660948179 |  0.587969925 | 20 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.640946894 |  0.463157895 | 20 |
| lys_lux_avg | ucm_HUMIDEX |  0.631065430 |  0.559398496 | 20 |
| lys_lux_avg | SVF |  0.627051128 |  0.578947368 | 20 |
| SVF | ucm_SND_dBA |  0.589362143 |  0.652631579 | 20 |
| SVF | ucm_HUMIDEX |  0.588480840 |  0.574436090 | 20 |
| SVF | ucm_SUN_Gh |  0.586510719 |  0.592481203 | 20 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.582538053 |  0.430075188 | 20 |
| gvi_50m | ucm_SND_dBA | -0.581484032 | -0.735338346 | 20 |
| SVF | ucm_UTCI |  0.579839064 |  0.526315789 | 20 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.559977543 | -0.503759398 | 20 |
| atmo_pm2.5_avg | SVF |  0.549924168 |  0.700751880 | 20 |
| ucm_AIR_T_mid | ucm_SND_dBA |  0.545337515 |  0.584962406 | 20 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.544544432 |  0.600000000 | 20 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.544414565 |  0.052631579 | 20 |
| SVF | ucm_PET |  0.539652220 |  0.535338346 | 20 |
| lys_kelvin_avg | ucm_SND_dBA |  0.539326948 |  0.499248120 | 20 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.538847115 |  0.536842105 | 20 |
| atmo_pm1_avg | gvi_50m | -0.530777064 | -0.639097744 | 20 |
| lys_kelvin_avg | lys_lux_avg |  0.525721480 |  0.559398496 | 20 |
| lys_lux_avg | ucm_AIR_RH | -0.525068950 | -0.553383459 | 20 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.515508585 |  0.705263158 | 20 |
| atmo_pm1_avg | lys_kelvin_avg |  0.480270558 |  0.517293233 | 20 |
| atmo_pm1_avg | ucm_AIR_T_mid |  0.477709133 |  0.575939850 | 20 |
| atmo_pm10_avg | ucm_SND_dBA | -0.477172976 | -0.606015038 | 20 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.473083728 |  0.424060150 | 20 |
| atmo_pm10_avg | ucm_AIR_RH |  0.467433642 |  0.494736842 | 20 |
| lys_kelvin_avg | ucm_AIR_RH | -0.441847028 | -0.403007519 | 20 |
| lys_kelvin_avg | SVF |  0.431697258 |  0.430075188 | 20 |
| atmo_pm10_avg | gvi_50m |  0.405513905 |  0.455639098 | 20 |
| ucm_MRT | ucm_SND_dBA |  0.404267496 |  0.648120301 | 20 |
| atmo_pm1_avg | ucm_MRT |  0.400926898 |  0.693233083 | 20 |
| atmo_pm2.5_avg | lys_lux_avg |  0.400641478 |  0.532330827 | 20 |
| atmo_pm2.5_avg | ucm_AIR_T_mid |  0.399103170 |  0.535338346 | 20 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.381022454 |  0.502255639 | 20 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.366571834 |  0.479699248 | 20 |
| atmo_pm2.5_avg | ucm_MRT |  0.350534356 |  0.606015038 | 20 |
| atmo_pm2.5_avg | lys_kelvin_avg |  0.349456842 |  0.416541353 | 20 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.343269056 |  0.454135338 | 20 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.342527947 |  0.339849624 | 20 |
| atmo_pm1_avg | lys_lux_avg |  0.339549961 |  0.442105263 | 20 |
| ucm_UTCI | ucm_WIND_AWS | -0.331522136 | -0.276691729 | 20 |
| ucm_PET | ucm_WIND_AWS | -0.328514962 | -0.192481203 | 20 |
| SVF | ucm_WIND_AWS |  0.302354550 |  0.272180451 | 20 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.301084349 | -0.427067669 | 20 |
| gvi_50m | lys_kelvin_avg | -0.290713924 | -0.416541353 | 20 |
| atmo_pm2.5_avg | ucm_PET |  0.284957018 |  0.272180451 | 20 |
| atmo_pm2.5_avg | ucm_UTCI |  0.284652387 |  0.213533835 | 20 |
| atmo_pm1_avg | atmo_pm10_avg | -0.275423348 | -0.369924812 | 20 |
| ucm_SND_dBA | ucm_UTCI |  0.273544365 |  0.418045113 | 20 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.272615713 | -0.206015038 | 20 |
| atmo_pm2.5_avg | ucm_WIND_AWS |  0.265684666 |  0.363909774 | 20 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.265167319 |  0.001503759 | 20 |
| atmo_pm10_avg | ucm_AIR_T_mid | -0.262432369 | -0.276691729 | 20 |
| atmo_pm1_avg | ucm_UTCI |  0.260259717 |  0.282706767 | 20 |
| ucm_PET | ucm_SND_dBA |  0.259227802 |  0.437593985 | 20 |
| atmo_pm10_avg | SVF | -0.243377738 | -0.282706767 | 20 |
| atmo_pm2.5_avg | gvi_50m | -0.240539628 | -0.424060150 | 20 |
| lys_kelvin_avg | ucm_AIR_T_mid |  0.230226354 |  0.216541353 | 20 |
| atmo_pm1_avg | ucm_PET |  0.229214972 |  0.303759398 | 20 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.224993736 |  0.363909774 | 20 |
| lys_kelvin_avg | ucm_MRT |  0.211936156 |  0.321804511 | 20 |
| lys_lux_avg | ucm_SND_dBA |  0.183603731 |  0.255639098 | 20 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.177905058 |  0.209022556 | 20 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.174713025 |  0.350375940 | 20 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.166923860 | -0.236090226 | 20 |
| atmo_pm10_avg | ucm_MRT | -0.165263619 | -0.270676692 | 20 |
| lys_kelvin_avg | ucm_UTCI |  0.162617665 |  0.187969925 | 20 |
| atmo_pm10_avg | ucm_HUMIDEX | -0.148344079 | -0.181954887 | 20 |
| ucm_MRT | ucm_WIND_AWS | -0.140350652 |  0.123308271 | 20 |
| lys_lux_avg | ucm_WIND_AWS | -0.134687583 |  0.121804511 | 20 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.114862176 |  0.138345865 | 20 |
| atmo_pm10_avg | ucm_PET | -0.113504817 | -0.200000000 | 20 |
| atmo_pm10_avg | ucm_UTCI | -0.110117202 | -0.187969925 | 20 |
| lys_kelvin_avg | ucm_PET |  0.077360213 |  0.196992481 | 20 |
| atmo_pm10_avg | lys_lux_avg |  0.063477985 |  0.049624060 | 20 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.059837185 |  0.115789474 | 20 |
| ucm_AIR_T_mid | ucm_WIND_AWS | -0.056160135 |  0.009022556 | 20 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.041084686 | -0.012030075 | 20 |
| atmo_pm10_avg | lys_kelvin_avg | -0.016854656 | -0.145864662 | 20 |
| gvi_50m | ucm_WIND_AWS |  0.004477486 | -0.112781955 | 20 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

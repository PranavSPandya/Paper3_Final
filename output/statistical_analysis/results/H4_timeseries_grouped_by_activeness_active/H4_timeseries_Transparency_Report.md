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
| ucm_PET | ucm_UTCI |  0.98814362 |  0.98434783 | 24 |
| ucm_AIR_T_mid | ucm_MRT |  0.96673721 |  0.97565217 | 24 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.96614968 |  0.70695652 | 24 |
| ucm_MRT | ucm_UTCI |  0.95792030 |  0.88956522 | 24 |
| gvi_50m | ucm_UTCI | -0.95029752 | -0.86695652 | 24 |
| gvi_50m | ucm_MRT | -0.94981593 | -0.92000000 | 24 |
| gvi_50m | ucm_PET | -0.94660845 | -0.83130435 | 24 |
| ucm_MRT | ucm_PET |  0.94036550 |  0.84521739 | 24 |
| gvi_50m | ucm_AIR_T_mid | -0.93701454 | -0.89565217 | 24 |
| ucm_AIR_T_mid | ucm_UTCI |  0.93161282 |  0.86782609 | 24 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.92925863 |  0.90608696 | 24 |
| ucm_AIR_T_mid | ucm_PET |  0.91233048 |  0.83304348 | 24 |
| ucm_AIR_T_mid | ucm_HUMIDEX |  0.88524422 |  0.88521739 | 24 |
| ucm_SUN_Gh | ucm_UTCI |  0.87926619 |  0.80956522 | 24 |
| ucm_MRT | ucm_SUN_Gh |  0.87065301 |  0.76782609 | 24 |
| ucm_PET | ucm_SUN_Gh |  0.85115380 |  0.80086957 | 24 |
| atmo_pm1_avg | atmo_pm10_avg |  0.84844174 |  0.58173913 | 24 |
| ucm_HUMIDEX | ucm_MRT |  0.84558618 |  0.88173913 | 24 |
| gvi_50m | ucm_HUMIDEX | -0.83007424 | -0.80173913 | 24 |
| ucm_AIR_RH | ucm_AIR_T_mid | -0.82732921 | -0.82000000 | 24 |
| ucm_AIR_T_mid | ucm_SUN_Gh |  0.81543677 |  0.73217391 | 24 |
| gvi_50m | ucm_AIR_RH |  0.79958511 |  0.78173913 | 24 |
| ucm_HUMIDEX | ucm_UTCI |  0.79584721 |  0.76434783 | 24 |
| ucm_AIR_RH | ucm_UTCI | -0.77152679 | -0.83565217 | 24 |
| gvi_50m | ucm_SUN_Gh | -0.75877330 | -0.70260870 | 24 |
| ucm_HUMIDEX | ucm_PET |  0.74892591 |  0.70434783 | 24 |
| ucm_AIR_RH | ucm_PET | -0.74480939 | -0.85652174 | 24 |
| ucm_AIR_RH | ucm_SND_dBA | -0.74088540 | -0.74347826 | 24 |
| ucm_AIR_RH | ucm_MRT | -0.73777645 | -0.82434783 | 24 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.70537422 | -0.65478261 | 24 |
| SVF | ucm_AIR_T_mid |  0.68718878 |  0.70956522 | 24 |
| SVF | ucm_AIR_RH | -0.68514327 | -0.67739130 | 24 |
| SVF | ucm_SUN_Gh |  0.67963960 |  0.65913043 | 24 |
| SVF | ucm_HUMIDEX |  0.67902291 |  0.70173913 | 24 |
| SVF | ucm_UTCI |  0.67737379 |  0.72434783 | 24 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.65016457 |  0.54260870 | 24 |
| ucm_AIR_T_mid | ucm_SND_dBA |  0.64785778 |  0.73826087 | 24 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.64355797 |  0.63478261 | 24 |
| gvi_50m | SVF | -0.63513028 | -0.71304348 | 24 |
| gvi_50m | ucm_SND_dBA | -0.63428962 | -0.71391304 | 24 |
| SVF | ucm_MRT |  0.63249754 |  0.76260870 | 24 |
| SVF | ucm_PET |  0.61851959 |  0.69043478 | 24 |
| SVF | ucm_SND_dBA |  0.59555087 |  0.58434783 | 24 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.56764126 | -0.70260870 | 24 |
| atmo_pm2.5_avg | ucm_MRT |  0.56059443 |  0.59217391 | 24 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.54536071 |  0.52000000 | 24 |
| ucm_SND_dBA | ucm_UTCI |  0.54377476 |  0.70695652 | 24 |
| ucm_MRT | ucm_SND_dBA |  0.53911582 |  0.68869565 | 24 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.53723905 |  0.43478261 | 24 |
| lys_lux_avg | ucm_AIR_RH | -0.52542986 | -0.58347826 | 24 |
| atmo_pm1_avg | ucm_MRT |  0.52113715 |  0.52695652 | 24 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.51900563 |  0.28608696 | 24 |
| atmo_pm10_avg | ucm_MRT |  0.50818792 |  0.34956522 | 24 |
| atmo_pm2.5_avg | ucm_AIR_T_mid |  0.49967722 |  0.62173913 | 24 |
| lys_lux_avg | ucm_SND_dBA |  0.49901476 |  0.51217391 | 24 |
| ucm_PET | ucm_SND_dBA |  0.49671145 |  0.68086957 | 24 |
| atmo_pm1_avg | ucm_AIR_T_mid |  0.49162799 |  0.54086957 | 24 |
| atmo_pm2.5_avg | ucm_UTCI |  0.48980586 |  0.45652174 | 24 |
| atmo_pm1_avg | ucm_UTCI |  0.47553051 |  0.47739130 | 24 |
| atmo_pm1_avg | SVF |  0.47518835 |  0.51391304 | 24 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.47118809 |  0.51826087 | 24 |
| atmo_pm10_avg | ucm_UTCI |  0.44782865 |  0.25304348 | 24 |
| atmo_pm10_avg | lys_kelvin_avg | -0.43617563 | -0.31478261 | 24 |
| atmo_pm2.5_avg | ucm_PET |  0.43554682 |  0.41913043 | 24 |
| atmo_pm2.5_avg | SVF |  0.43440618 |  0.45217391 | 24 |
| atmo_pm2.5_avg | gvi_50m | -0.43298060 | -0.53913043 | 24 |
| atmo_pm1_avg | ucm_PET |  0.42868849 |  0.46173913 | 24 |
| atmo_pm10_avg | ucm_AIR_T_mid |  0.42610937 |  0.30521739 | 24 |
| gvi_50m | lys_lux_avg | -0.41371581 | -0.39478261 | 24 |
| atmo_pm1_avg | gvi_50m | -0.40949697 | -0.47130435 | 24 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.40716534 |  0.38782609 | 24 |
| atmo_pm10_avg | ucm_PET |  0.40095766 |  0.17217391 | 24 |
| lys_lux_avg | ucm_AIR_T_mid |  0.39707706 |  0.37391304 | 24 |
| atmo_pm2.5_avg | lys_kelvin_avg | -0.39247640 | -0.17217391 | 24 |
| atmo_pm1_avg | ucm_SND_dBA |  0.38980324 |  0.44869565 | 24 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.36448070 |  0.42956522 | 24 |
| lys_lux_avg | ucm_UTCI |  0.35622206 |  0.28260870 | 24 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.35555893 |  0.46260870 | 24 |
| atmo_pm10_avg | ucm_HUMIDEX |  0.35547606 |  0.38956522 | 24 |
| lys_lux_avg | SVF |  0.35230022 |  0.37217391 | 24 |
| atmo_pm10_avg | gvi_50m | -0.35155136 | -0.22086957 | 24 |
| lys_lux_avg | ucm_PET |  0.34713489 |  0.30608696 | 24 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.34269379 |  0.33739130 | 24 |
| atmo_pm10_avg | SVF |  0.34156749 |  0.37565217 | 24 |
| atmo_pm1_avg | lys_kelvin_avg | -0.32643576 | -0.14434783 | 24 |
| lys_lux_avg | ucm_MRT |  0.31975247 |  0.34173913 | 24 |
| SVF | ucm_WIND_AWS |  0.30594648 |  0.36782609 | 24 |
| lys_lux_avg | ucm_SUN_Gh |  0.30450996 |  0.31739130 | 24 |
| lys_kelvin_avg | ucm_AIR_RH | -0.30382598 | -0.38434783 | 24 |
| atmo_pm1_avg | ucm_AIR_RH | -0.30293595 | -0.43565217 | 24 |
| lys_lux_avg | ucm_WIND_AWS |  0.25969251 |  0.47565217 | 24 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.23333708 |  0.23565217 | 24 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.23036853 | -0.40086957 | 24 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.22869681 |  0.32000000 | 24 |
| atmo_pm10_avg | ucm_SND_dBA |  0.21845345 |  0.13739130 | 24 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.21115454 | -0.28347826 | 24 |
| ucm_PET | ucm_WIND_AWS | -0.21066959 |  0.08956522 | 24 |
| lys_lux_avg | ucm_HUMIDEX |  0.19863738 |  0.10086957 | 24 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.19661248 |  0.08347826 | 24 |
| gvi_50m | lys_kelvin_avg | -0.19417994 | -0.33043478 | 24 |
| lys_kelvin_avg | lys_lux_avg | -0.19222756 |  0.04086957 | 24 |
| ucm_UTCI | ucm_WIND_AWS | -0.16813568 |  0.11913043 | 24 |
| lys_kelvin_avg | SVF |  0.15679855 |  0.24956522 | 24 |
| atmo_pm2.5_avg | ucm_WIND_AWS | -0.15349582 |  0.00173913 | 24 |
| lys_kelvin_avg | ucm_AIR_T_mid |  0.14699296 |  0.29739130 | 24 |
| atmo_pm10_avg | ucm_AIR_RH | -0.14144577 | -0.13826087 | 24 |
| gvi_50m | ucm_WIND_AWS |  0.13935831 | -0.09739130 | 24 |
| lys_kelvin_avg | ucm_MRT |  0.13466569 |  0.34521739 | 24 |
| ucm_MRT | ucm_WIND_AWS | -0.13399654 |  0.19130435 | 24 |
| lys_kelvin_avg | ucm_PET |  0.13103945 |  0.23130435 | 24 |
| atmo_pm1_avg | ucm_WIND_AWS | -0.11450808 |  0.06869565 | 24 |
| lys_kelvin_avg | ucm_UTCI |  0.10485183 |  0.19739130 | 24 |
| atmo_pm10_avg | lys_lux_avg | -0.09973519 | -0.11913043 | 24 |
| lys_kelvin_avg | ucm_SND_dBA |  0.08728904 |  0.14000000 | 24 |
| ucm_AIR_T_mid | ucm_WIND_AWS | -0.06951505 |  0.13913043 | 24 |
| atmo_pm1_avg | lys_lux_avg |  0.04682487 |  0.22608696 | 24 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.03646917 |  0.21565217 | 24 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.03615026 |  0.03913043 | 24 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.03487546 |  0.20695652 | 24 |
| atmo_pm2.5_avg | lys_lux_avg | -0.02812616 |  0.17739130 | 24 |
Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427

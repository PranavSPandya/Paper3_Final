# H4 measurement audit
Steps 1-2 retain the complete inventory and declared exposure representations. Step 3 groups candidates without outcome-based deletion.
Step 4 uses separate Empatica and ocular domain-wise LASSOs; the combined candidate set is their union. Pooled-response fits are diagnostic.
Participant-held-out tuning with training-only standardisation. No forced winner; zero or multiple selections are allowed.
Participant is the independent cluster. Step 5 defines five thermal-by-sound equations (AIR_temp + AIR_RH + WIND_AWS, MRT, HUMIDEX, PET, UTCI); see H4_models/H4_equations.csv. Earlier model outputs are historical until a verified rerun succeeds.
## Stage totals
| Stage | Entering | Retained | Not_Advanced |
| --- | --- | --- | --- |
| Step 1 | 208 | 107 | 101 |
| Step 2 | 107 |  16 |  91 |
| Step 3 |  16 |  16 |   0 |
## Measurement definitions and dependencies
| Variable_Name | Measurement_Code | Measurement_Type | Inputs_or_Definition | Evidence |
| --- | --- | --- | --- | --- |
| ucm_AIR_temp | M | Instrument-reported measurement | Air-temperature sensor output | CityFeel 2017 sensor table; doi:10.1016/j.egypro.2017.07.427 |
| ucm_AIR_RH | M | Instrument-reported measurement | Relative-humidity sensor output | CityFeel 2017 sensor table; doi:10.1016/j.egypro.2017.07.427 |
| ucm_SND_dBA | M | Instrument-reported measurement | A-weighted sound-pressure level; calibrated acoustic measurement | CityFeel 2017 sensor table; doi:10.1016/j.egypro.2017.07.427 |
| ucm_SUN_Gh | M | Instrument-reported measurement | Measured global horizontal solar irradiance | CityFeel 2017 sensor table; doi:10.1016/j.egypro.2017.07.427 |
| atmo_pm1_avg | A | Averaged instrument measurement | Arithmetic average of left/right Atmotube PM1 outputs | Existing bilateral average_sources mapping |
| atmo_pm2.5_avg | A | Averaged instrument measurement | Arithmetic average of left/right Atmotube PM2.5 outputs | Existing bilateral average_sources mapping |
| atmo_pm10_avg | A | Averaged instrument measurement | Arithmetic average of left/right Atmotube PM10 outputs | Existing bilateral average_sources mapping |
| lys_lux_avg | A | Averaged instrument measurement | Arithmetic average of LYS1/LYS2 photopic illuminance; spectral calibration upstream | Existing bilateral average_sources mapping |
| lys_medi_avg | D | Derived metric | Melanopic EDI estimated from LYS RGB channels, not measured spectrally; excluded at Step 2 [Beiglary25 p.5; Ishihara25 p.1, p.7, p.10] | Beiglary25 p.5; Ishihara25 p.1, p.7, p.10 (see Step 1/2 reference block) |
| lys_kelvin_avg | D | Derived metric | Correlated colour temperature derived from spectral/chromaticity channels, then LYS1/LYS2 average | LYS manufacturer help; Stevenson et al. doi:10.1177/14771535251338582; existing average mapping |
| ucm_MRT | D | Derived metric | Calculated mean radiant temperature from radiative sensor inputs; deployed UCM algorithm not reproduced here | CityFeel 2017 section 2.3; exact deployed calculation external |
| ucm_PET | D | Derived metric | Human heat-balance index using air temperature, radiation/MRT, humidity, wind and person/clothing/metabolic assumptions; deployed assumptions need UCM documentation | CityFeel 2017 section 2.3; exact deployed calculation external |
| ucm_UTCI | D | Derived metric | Thermal index using air temperature, radiation/MRT, humidity and wind with reference physiological/clothing assumptions; deployed wind correction needs UCM documentation | CityFeel 2017 section 2.3; exact deployed calculation external |
| ucm_HUMIDEX | D | Derived metric | Humidity index combining air temperature and vapour pressure derived from humidity | CityFeel 2017 section 2.3; exact deployed calculation external |
| Clearness_Index | D | Derived metric | Measured SUN_Gh / calculated G0 (kt = Gh/G0); excluded at Step 2 as derived from ucm_SUN_Gh [ClearCI p.3 eq.2]; exact code in scripts/compute_clearness_index.py | scripts/compute_clearness_index.py |
| Clearness_Index_G0 | D | Derived metric | 1367 * (1 + 0.033*cos(2*pi*day_of_year/365)) * sin(solar_altitude); calculated extraterrestrial irradiance, not another clearness index | scripts/compute_clearness_index.py |
| gvi_50m | D | Derived metric | Image-derived vegetation fraction with spatial matching; see canonical GVI source mapping | scripts/merge_11participant_statistical_inputs.py GVI_SOURCE_ALIASES |
| ucm_WIND_AWS | M | Instrument-reported apparent wind speed (moving platform) | Apparent wind speed: airflow at the body including own movement, the convective-cooling-relevant exposure; complete in all core phases | Export name and available pipeline only; exact upstream formula pending |
| ucm_fp | U | Definition unverified | Exported UCM fp field; acronym and formula not verified against a current source manual | Current source manual not found; no inferred expansion asserted |
Step 2 representatives and averages are study choices, not automatic literature rules. LYS1 and LYS2 represent different wearers.
fp remains unverified; true wind speed (TWS) excluded (gaps, undocumented correction); SVF remains planned pending processing/merge.
## Current Step 5 specification
Generated from the saved Step 4 union; inspect H4_Step5_Equations_Checks.txt for the actual fitted run and diagnostics.
## Within-person design diagnostics
(none)
| Field1 | Field2 | Pearson_r | Spearman_rho | N_phase_cells |
| --- | --- | --- | --- | --- |
| ucm_PET | ucm_UTCI |  0.987924142 |  0.974452941 | 44 |
| ucm_AIR_temp | ucm_HUMIDEX |  0.957823792 |  0.961663143 | 44 |
| gvi_50m | ucm_MRT | -0.948260800 | -0.902325581 | 44 |
| ucm_MRT | ucm_UTCI |  0.946743921 |  0.849753347 | 44 |
| ucm_MRT | ucm_PET |  0.927631262 |  0.824905741 | 44 |
| atmo_pm1_avg | atmo_pm2.5_avg |  0.910765825 |  0.801578633 | 44 |
| ucm_SUN_Gh | ucm_UTCI |  0.902369566 |  0.760676533 | 44 |
| gvi_50m | ucm_UTCI | -0.900072257 | -0.777589852 | 44 |
| ucm_AIR_RH | ucm_AIR_temp | -0.894639890 | -0.858491896 | 44 |
| ucm_MRT | ucm_SUN_Gh |  0.890891651 |  0.755602537 | 44 |
| ucm_PET | ucm_SUN_Gh |  0.885032878 |  0.755488214 | 44 |
| atmo_pm10_avg | atmo_pm2.5_avg |  0.885019939 |  0.422551092 | 44 |
| gvi_50m | ucm_PET | -0.881847895 | -0.757320554 | 44 |
| gvi_50m | ucm_AIR_temp | -0.863933662 | -0.854968288 | 44 |
| ucm_AIR_temp | ucm_MRT |  0.854879092 |  0.919943622 | 44 |
| gvi_50m | ucm_AIR_RH |  0.844932133 |  0.840169133 | 44 |
| ucm_HUMIDEX | ucm_MRT |  0.820801139 |  0.864552502 | 44 |
| ucm_AIR_temp | ucm_UTCI |  0.817550209 |  0.808033827 | 44 |
| ucm_HUMIDEX | ucm_UTCI |  0.788087548 |  0.764482030 | 44 |
| gvi_50m | ucm_HUMIDEX | -0.787100408 | -0.799013390 | 44 |
| ucm_AIR_temp | ucm_PET |  0.779747744 |  0.775291589 | 44 |
| ucm_AIR_RH | ucm_MRT | -0.765811625 | -0.843128964 | 44 |
| gvi_50m | ucm_SUN_Gh | -0.765749156 | -0.625088090 | 44 |
| ucm_AIR_RH | ucm_SND_dBA | -0.762144708 | -0.747665528 | 44 |
| ucm_HUMIDEX | ucm_PET |  0.749621510 |  0.729624018 | 44 |
| ucm_AIR_RH | ucm_UTCI | -0.732830524 | -0.775616631 | 44 |
| ucm_AIR_RH | ucm_HUMIDEX | -0.732660199 | -0.732064834 | 44 |
| ucm_AIR_temp | ucm_SND_dBA |  0.703740476 |  0.710807288 | 44 |
| ucm_AIR_RH | ucm_PET | -0.703562670 | -0.768807922 | 44 |
| atmo_pm1_avg | atmo_pm10_avg |  0.686601553 |  0.172733359 | 44 |
| ucm_AIR_temp | ucm_SUN_Gh |  0.653528945 |  0.564200141 | 44 |
| ucm_HUMIDEX | ucm_SUN_Gh |  0.647135318 |  0.513178295 | 44 |
| gvi_50m | ucm_SND_dBA | -0.608950147 | -0.707072131 | 44 |
| ucm_HUMIDEX | ucm_SND_dBA |  0.590963279 |  0.627858628 | 44 |
| ucm_AIR_RH | ucm_SUN_Gh | -0.563740298 | -0.576603242 | 44 |
| lys_lux_avg | ucm_AIR_RH | -0.524122009 | -0.564482030 | 44 |
| gvi_50m | lys_lux_avg | -0.516002848 | -0.485976039 | 44 |
| lys_lux_avg | ucm_UTCI |  0.506207388 |  0.441860465 | 44 |
| Clearness_Index_G0 | ucm_HUMIDEX | -0.503314450 | -0.514239411 | 44 |
| lys_lux_avg | ucm_SUN_Gh |  0.496346066 |  0.521494010 | 44 |
| lys_lux_avg | ucm_MRT |  0.490780680 |  0.502466526 | 44 |
| lys_lux_avg | ucm_PET |  0.478574846 |  0.440677966 | 44 |
| ucm_MRT | ucm_SND_dBA |  0.471769813 |  0.677825153 | 44 |
| ucm_SND_dBA | ucm_WIND_AWS |  0.469272843 |  0.355474118 | 44 |
| lys_lux_avg | ucm_AIR_temp |  0.458571144 |  0.464411557 | 44 |
| atmo_pm2.5_avg | ucm_MRT |  0.447903558 |  0.587315011 | 44 |
| atmo_pm1_avg | ucm_MRT |  0.446960489 |  0.573029353 | 44 |
| atmo_pm2.5_avg | ucm_SUN_Gh |  0.416576652 |  0.440451022 | 44 |
| Clearness_Index_G0 | ucm_AIR_temp | -0.416238808 | -0.427463714 | 44 |
| ucm_SND_dBA | ucm_UTCI |  0.404666875 |  0.575989288 | 44 |
| atmo_pm1_avg | ucm_SND_dBA |  0.402868566 |  0.545845373 | 44 |
| atmo_pm1_avg | ucm_SUN_Gh |  0.399559247 |  0.407977730 | 44 |
| atmo_pm1_avg | gvi_50m | -0.396419989 | -0.497691956 | 44 |
| lys_lux_avg | ucm_HUMIDEX |  0.393065577 |  0.345736434 | 44 |
| atmo_pm1_avg | ucm_AIR_temp |  0.375164324 |  0.485076994 | 44 |
| ucm_PET | ucm_SND_dBA |  0.372425546 |  0.566847558 | 44 |
| atmo_pm2.5_avg | ucm_UTCI |  0.365840922 |  0.348273432 | 44 |
| atmo_pm1_avg | ucm_UTCI |  0.365138930 |  0.390006695 | 44 |
| lys_kelvin_avg | ucm_AIR_RH | -0.359857280 | -0.389006342 | 44 |
| lys_lux_avg | ucm_SND_dBA |  0.355666324 |  0.391275239 | 44 |
| atmo_pm2.5_avg | ucm_HUMIDEX |  0.348298197 |  0.448062016 | 44 |
| atmo_pm1_avg | ucm_AIR_RH | -0.345858875 | -0.528771275 | 44 |
| atmo_pm2.5_avg | gvi_50m | -0.344784082 | -0.480338266 | 44 |
| lys_kelvin_avg | ucm_WIND_AWS |  0.340127078 |  0.322057787 | 44 |
| atmo_pm1_avg | ucm_HUMIDEX |  0.338808586 |  0.415588992 | 44 |
| atmo_pm10_avg | ucm_SUN_Gh |  0.331609341 |  0.236927414 | 44 |
| atmo_pm2.5_avg | ucm_AIR_temp |  0.328833799 |  0.484707541 | 44 |
| atmo_pm2.5_avg | ucm_PET |  0.326744631 |  0.327425209 | 44 |
| lys_kelvin_avg | ucm_AIR_temp |  0.325501919 |  0.347568710 | 44 |
| atmo_pm1_avg | ucm_PET |  0.324737759 |  0.354640919 | 44 |
| atmo_pm10_avg | lys_kelvin_avg | -0.303482477 | -0.251162791 | 44 |
| lys_kelvin_avg | ucm_SND_dBA |  0.291474258 |  0.294513549 | 44 |
| Clearness_Index_G0 | ucm_MRT | -0.279854331 | -0.357394629 | 44 |
| lys_kelvin_avg | ucm_HUMIDEX |  0.277229361 |  0.291190980 | 44 |
| ucm_PET | ucm_WIND_AWS | -0.277039243 | -0.100849220 | 44 |
| atmo_pm2.5_avg | ucm_SND_dBA |  0.273300550 |  0.432643857 | 44 |
| atmo_pm2.5_avg | Clearness_Index_G0 | -0.271515333 | -0.338361779 | 44 |
| atmo_pm10_avg | ucm_MRT |  0.269544866 |  0.074418605 | 44 |
| ucm_UTCI | ucm_WIND_AWS | -0.257661099 | -0.112191684 | 44 |
| atmo_pm2.5_avg | lys_kelvin_avg | -0.257573883 |  0.064975335 | 44 |
| Clearness_Index_G0 | gvi_50m |  0.256684630 |  0.263851695 | 44 |
| Clearness_Index_G0 | ucm_SND_dBA | -0.251820705 | -0.247647253 | 44 |
| gvi_50m | lys_kelvin_avg | -0.238550285 | -0.339957717 | 44 |
| ucm_AIR_RH | ucm_WIND_AWS | -0.237839533 | -0.238900634 | 44 |
| ucm_SND_dBA | ucm_SUN_Gh |  0.234476370 |  0.279502449 | 44 |
| atmo_pm1_avg | Clearness_Index_G0 | -0.231523919 | -0.238764943 | 44 |
| atmo_pm10_avg | ucm_UTCI |  0.224494079 |  0.041296688 | 44 |
| atmo_pm2.5_avg | ucm_AIR_RH | -0.210547891 | -0.395348837 | 44 |
| Clearness_Index_G0 | ucm_AIR_RH |  0.202423919 |  0.176230093 | 44 |
| atmo_pm10_avg | ucm_PET |  0.191492051 | -0.014235879 | 44 |
| atmo_pm10_avg | ucm_WIND_AWS | -0.180072539 | -0.104157858 | 44 |
| lys_kelvin_avg | ucm_MRT |  0.170218457 |  0.319238901 | 44 |
| atmo_pm1_avg | lys_kelvin_avg | -0.164096459 |  0.082384862 | 44 |
| ucm_SUN_Gh | ucm_WIND_AWS | -0.161584670 |  0.058773784 | 44 |
| Clearness_Index_G0 | ucm_UTCI | -0.153376081 | -0.106936420 | 44 |
| atmo_pm10_avg | ucm_HUMIDEX |  0.143255742 |  0.080761099 | 44 |
| ucm_MRT | ucm_WIND_AWS | -0.140058555 |  0.128541226 | 44 |
| lys_kelvin_avg | ucm_UTCI |  0.136023164 |  0.221282593 | 44 |
| Clearness_Index_G0 | ucm_PET | -0.134227830 | -0.083888480 | 44 |
| Clearness_Index_G0 | lys_kelvin_avg | -0.129758808 | -0.133088966 | 44 |
| lys_kelvin_avg | ucm_PET |  0.110618571 |  0.216427640 | 44 |
| Clearness_Index_G0 | lys_lux_avg | -0.107174633 | -0.121739748 | 44 |
| atmo_pm10_avg | Clearness_Index_G0 | -0.107068570 | -0.159171020 | 44 |
| lys_kelvin_avg | ucm_SUN_Gh |  0.099154494 |  0.187315011 | 44 |
| atmo_pm10_avg | gvi_50m | -0.095622570 |  0.077237491 | 44 |
| lys_kelvin_avg | lys_lux_avg |  0.087221263 |  0.276391825 | 44 |
| atmo_pm1_avg | lys_lux_avg |  0.085537913 |  0.269635999 | 44 |
| atmo_pm10_avg | ucm_AIR_temp |  0.083589511 |  0.007751938 | 44 |
| lys_lux_avg | ucm_WIND_AWS |  0.078206083 |  0.268217054 | 44 |
| ucm_AIR_temp | ucm_WIND_AWS |  0.072256026 |  0.055532065 | 44 |
| gvi_50m | ucm_WIND_AWS |  0.070179579 | -0.082734320 | 44 |
| atmo_pm2.5_avg | ucm_WIND_AWS | -0.064707490 |  0.132064834 | 44 |
| atmo_pm10_avg | lys_lux_avg | -0.058412739 | -0.054545455 | 44 |
| atmo_pm1_avg | ucm_WIND_AWS |  0.046785215 |  0.215440995 | 44 |
| atmo_pm10_avg | ucm_AIR_RH |  0.045525010 |  0.159830867 | 44 |
| ucm_HUMIDEX | ucm_WIND_AWS | -0.044017015 | -0.036081748 | 44 |
| atmo_pm10_avg | ucm_SND_dBA | -0.026625533 | -0.201487015 | 44 |
| Clearness_Index_G0 | ucm_SUN_Gh | -0.026406704 |  0.046736221 | 44 |
| atmo_pm2.5_avg | lys_lux_avg |  0.021290995 |  0.323890063 | 44 |
| Clearness_Index_G0 | ucm_WIND_AWS | -0.001101828 | -0.021711547 | 44 |
Domain-wise selection does not adjust exposures across domains. Same-data selection and fitting do not provide confirmatory inference.
Sources: https://doi.org/10.1016/j.egypro.2017.07.427 ; https://glmnet.stanford.edu/articles/glmnet.html ; https://doi.org/10.2202/1557-4679.1353

## Response family: Empatica

## Step 4: exploratory domain-wise multi-response LASSO
glmnet version: 4.1.10
Input is matched 10-second windows; 13 response columns; declared HRV log transforms and availability flags respected when applicable.
Leave one participant out. Exposures are participant-mean centered, not global z-scored. After centering, each environmental column is z-scored with the unweighted training-row mean and SD; a non-finite or zero SD drops that column. glmnet standardize=FALSE because those z-scores are already applied. Held-out rows are centered on the held-out participant and then scaled with the training mean and SD. Three sum-to-zero PhaseID contrasts are unscaled and unpenalised; every training fold must span all four conditions. Outcomes are training-fold standardized. Each participant has equal training weight and equal validation weight.
Tune a 60-point relative lambda path (1 to 0.001) by minimum held-out participant MSE. One-SE is sensitivity only. Zero/multiple selections allowed; no forced winner.
Domains are declared measurement groups, not learned groups. Each domain is fitted separately, so retained variables are not mutually adjusted across domains.
Complete cases across the specified response family are required per domain. Samples can differ across families/domains; no imputation.
Exploratory predictive screening only. No mixed-model inference, causal interpretation, unbiased external performance estimate, or post-selection p-values.
Response columns: empatica_heart_rate, empatica_eda_tonic, empatica_eda_phasic, empatica_skin_temperature, empatica_hrv_td_sdnn, empatica_hrv_td_rmssd, empatica_hrv_fd_lf, empatica_hrv_fd_hf, empatica_hrv_fd_lf_hf_ratio, empatica_hrv_fd_lfnu, empatica_hrv_fd_hfnu, empatica_hrv_fd_vlf, empatica_hrv_fd_total_power
Missing/non-finite response rows after existing HRV QC: empatica_heart_rate=0; empatica_eda_tonic=274; empatica_eda_phasic=0; empatica_skin_temperature=0; empatica_hrv_td_sdnn=335; empatica_hrv_td_rmssd=169; empatica_hrv_fd_lf=787; empatica_hrv_fd_hf=787; empatica_hrv_fd_lf_hf_ratio=787; empatica_hrv_fd_lfnu=787; empatica_hrv_fd_hfnu=787; empatica_hrv_fd_vlf=787; empatica_hrv_fd_total_power=787
Acoustic: 1132/2156 complete windows; 11 participants; 13 responses.
Included participants: P10, P11, P12, P13, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: 
Acoustic: minimum-error ratio 0.703814 (MSE 1.30517; SE 0.227568); one-SE ratio 1 (MSE 1.30574; SE 0.227593). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.305741 0.2275928
  0.889513497 1.305412 0.2275863
  0.791234262 1.305234 0.2275784
  0.703813555 1.305166 0.2275679
  0.626051657 1.305175 0.2275573
  0.556881399 1.305239 0.2275456
  0.495353521 1.305341 0.2275341
  0.440623643 1.305466 0.2275226
  0.391940677 1.305605 0.2275116
  0.348636523 1.305749 0.2275012
  0.310116893 1.305896 0.2274913
  0.275853162 1.306041 0.2274824
  0.245375111 1.306179 0.2274738
  0.218264473 1.306312 0.2274660
  0.194149195 1.306434 0.2274588
  0.172698329 1.306551 0.2274525
  0.153617495 1.306658 0.2274469
  0.136644835 1.306758 0.2274412
  0.121547425 1.306849 0.2274364
  0.108118075 1.306932 0.2274321
  0.096172487 1.307004 0.2274284
  0.085546725 1.307073 0.2274251
  0.076094967 1.307137 0.2274216
  0.067687500 1.307193 0.2274186
  0.060208945 1.307242 0.2274157
  0.053556669 1.307285 0.2274144
  0.047639380 1.307325 0.2274128
  0.042375872 1.307361 0.2274115
  0.037693910 1.307393 0.2274098
  0.033529241 1.307425 0.2274081
  0.029824713 1.307452 0.2274066
  0.026529485 1.307477 0.2274054
  0.023598335 1.307499 0.2274040
  0.020991037 1.307517 0.2274032
  0.018671811 1.307529 0.2274029
  0.016608828 1.307544 0.2274022
  0.014773777 1.307558 0.2274013
  0.013141474 1.307571 0.2274005
  0.011689518 1.307583 0.2273998
  0.010397984 1.307593 0.2273992
  0.009249147 1.307602 0.2273987
  0.008227241 1.307610 0.2273982
  0.007318242 1.307617 0.2273978
  0.006509675 1.307623 0.2273974
  0.005790444 1.307629 0.2273971
  0.005150678 1.307634 0.2273968
  0.004581598 1.307638 0.2273965
  0.004075393 1.307642 0.2273963
  0.003625117 1.307646 0.2273961
  0.003224591 1.307649 0.2273959
  0.002868317 1.307652 0.2273957
  0.002551407 1.307654 0.2273955
  0.002269511 1.307656 0.2273954
  0.002018760 1.307658 0.2273953
  0.001795714 1.307660 0.2273952
  0.001597312 1.307662 0.2273951
  0.001420831 1.307663 0.2273950
  0.001263848 1.307664 0.2273949
  0.001124210 1.307665 0.2273949
  0.001000000 1.307666 0.2273948
Acoustic selected: ucm_SND_dBA
Thermal: 1132/2156 complete windows; 11 participants; 13 responses.
Included participants: P10, P11, P12, P13, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: 
Thermal: minimum-error ratio 0.172698 (MSE 1.26582; SE 0.21809); one-SE ratio 1 (MSE 1.30574; SE 0.227593). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.305741 0.2275927
  0.889513497 1.295629 0.2258332
  0.791234262 1.287604 0.2244261
  0.703813555 1.281383 0.2233254
  0.626051657 1.276547 0.2224600
  0.556881399 1.272820 0.2217813
  0.495353521 1.270193 0.2211930
  0.440623643 1.268802 0.2206833
  0.391940677 1.267928 0.2203168
  0.348636523 1.267432 0.2199678
  0.310116893 1.266896 0.2196135
  0.275853162 1.266676 0.2193424
  0.245375111 1.266531 0.2191227
  0.218264473 1.266055 0.2187052
  0.194149195 1.265849 0.2183658
  0.172698329 1.265816 0.2180899
  0.153617495 1.265940 0.2178654
  0.136644835 1.266161 0.2176884
  0.121547425 1.266453 0.2175431
  0.108118075 1.266798 0.2174263
  0.096172487 1.267168 0.2173340
  0.085546725 1.267553 0.2172573
  0.076094967 1.267940 0.2171959
  0.067687500 1.268315 0.2171455
  0.060208945 1.268678 0.2171048
  0.053556669 1.269024 0.2170706
  0.047639380 1.269350 0.2170427
  0.042375872 1.269653 0.2170191
  0.037693910 1.269935 0.2170001
  0.033529241 1.270191 0.2169846
  0.029824713 1.270432 0.2169705
  0.026529485 1.270647 0.2169595
  0.023598335 1.270847 0.2169495
  0.020991037 1.271025 0.2169415
  0.018671811 1.271189 0.2169345
  0.016608828 1.271336 0.2169283
  0.014773777 1.271469 0.2169233
  0.013141474 1.271585 0.2169191
  0.011689518 1.271694 0.2169152
  0.010397984 1.271791 0.2169122
  0.009249147 1.271877 0.2169092
  0.008227241 1.271957 0.2169066
  0.007318242 1.272024 0.2169042
  0.006509675 1.272086 0.2169023
  0.005790444 1.272142 0.2169008
  0.005150678 1.272190 0.2168990
  0.004581598 1.272236 0.2168974
  0.004075393 1.272274 0.2168965
  0.003625117 1.272308 0.2168957
  0.003224591 1.272341 0.2168946
  0.002868317 1.272369 0.2168936
  0.002551407 1.272393 0.2168933
  0.002269511 1.272417 0.2168926
  0.002018760 1.272438 0.2168924
  0.001795714 1.272457 0.2168921
  0.001597312 1.272476 0.2168917
  0.001420831 1.272493 0.2168913
  0.001263848 1.272508 0.2168909
  0.001124210 1.272522 0.2168905
  0.001000000 1.272535 0.2168901
Thermal selected: ucm_AIR_temp, ucm_AIR_RH, ucm_WIND_AWS
Index: 1132/2156 complete windows; 11 participants; 13 responses.
Included participants: P10, P11, P12, P13, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: 
Index: minimum-error ratio 0.0186718 (MSE 1.27361; SE 0.226453); one-SE ratio 1 (MSE 1.30574; SE 0.227591). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.305738 0.2275911
  0.889513497 1.297684 0.2269274
  0.791234262 1.291393 0.2264013
  0.703813555 1.286547 0.2259885
  0.626051657 1.282819 0.2256599
  0.556881399 1.279962 0.2254003
  0.495353521 1.277974 0.2252274
  0.440623643 1.276659 0.2250887
  0.391940677 1.275609 0.2250542
  0.348636523 1.274897 0.2250394
  0.310116893 1.274367 0.2250685
  0.275853162 1.274042 0.2251033
  0.245375111 1.273831 0.2251512
  0.218264473 1.273764 0.2251967
  0.194149195 1.273744 0.2252400
  0.172698329 1.273702 0.2253053
  0.153617495 1.273653 0.2253758
  0.136644835 1.273657 0.2254415
  0.121547425 1.273677 0.2255051
  0.108118075 1.273707 0.2255679
  0.096172487 1.273740 0.2256308
  0.085546725 1.273772 0.2256939
  0.076094967 1.273798 0.2257593
  0.067687500 1.273818 0.2258257
  0.060208945 1.273825 0.2258939
  0.053556669 1.273818 0.2259620
  0.047639380 1.273797 0.2260306
  0.042375872 1.273767 0.2260975
  0.037693910 1.273731 0.2261620
  0.033529241 1.273695 0.2262228
  0.029824713 1.273664 0.2262788
  0.026529485 1.273639 0.2263296
  0.023598335 1.273624 0.2263758
  0.020991037 1.273616 0.2264165
  0.018671811 1.273615 0.2264531
  0.016608828 1.273620 0.2264852
  0.014773777 1.273629 0.2265138
  0.013141474 1.273640 0.2265392
  0.011689518 1.273656 0.2265613
  0.010397984 1.273671 0.2265803
  0.009249147 1.273688 0.2265978
  0.008227241 1.273703 0.2266130
  0.007318242 1.273721 0.2266262
  0.006509675 1.273737 0.2266381
  0.005790444 1.273752 0.2266485
  0.005150678 1.273767 0.2266576
  0.004581598 1.273781 0.2266655
  0.004075393 1.273792 0.2266732
  0.003625117 1.273806 0.2266789
  0.003224591 1.273816 0.2266848
  0.002868317 1.273829 0.2266890
  0.002551407 1.273837 0.2266939
  0.002269511 1.273846 0.2266976
  0.002018760 1.273853 0.2267009
  0.001795714 1.273862 0.2267037
  0.001597312 1.273865 0.2267068
  0.001420831 1.273873 0.2267087
  0.001263848 1.273878 0.2267113
  0.001124210 1.273884 0.2267126
  0.001000000 1.273887 0.2267147
Index selected: ucm_HUMIDEX, ucm_PET, ucm_UTCI
Radiation: 1132/2156 complete windows; 11 participants; 13 responses.
Included participants: P10, P11, P12, P13, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: 
Radiation: minimum-error ratio 0.136645 (MSE 1.27955; SE 0.224802); one-SE ratio 1 (MSE 1.30574; SE 0.227593). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.305741 0.2275929
  0.889513497 1.302549 0.2279094
  0.791234262 1.298848 0.2281193
  0.703813555 1.295489 0.2281912
  0.626051657 1.291880 0.2278211
  0.556881399 1.288674 0.2274658
  0.495353521 1.286162 0.2271678
  0.440623643 1.284241 0.2269081
  0.391940677 1.282785 0.2266708
  0.348636523 1.281714 0.2264479
  0.310116893 1.280934 0.2262331
  0.275853162 1.280392 0.2260206
  0.245375111 1.280024 0.2258126
  0.218264473 1.279794 0.2256033
  0.194149195 1.279652 0.2253972
  0.172698329 1.279580 0.2251935
  0.153617495 1.279554 0.2249938
  0.136644835 1.279554 0.2248021
  0.121547425 1.279578 0.2246179
  0.108118075 1.279609 0.2244419
  0.096172487 1.279647 0.2242776
  0.085546725 1.279694 0.2241229
  0.076094967 1.279742 0.2239781
  0.067687500 1.279784 0.2238470
  0.060208945 1.279834 0.2237230
  0.053556669 1.279879 0.2236126
  0.047639380 1.279917 0.2235118
  0.042375872 1.279962 0.2234196
  0.037693910 1.280003 0.2233374
  0.033529241 1.280035 0.2232632
  0.029824713 1.280073 0.2231956
  0.026529485 1.280105 0.2231348
  0.023598335 1.280134 0.2230818
  0.020991037 1.280164 0.2230338
  0.018671811 1.280189 0.2229904
  0.016608828 1.280209 0.2229529
  0.014773777 1.280234 0.2229189
  0.013141474 1.280252 0.2228883
  0.011689518 1.280272 0.2228611
  0.010397984 1.280285 0.2228367
  0.009249147 1.280304 0.2228148
  0.008227241 1.280317 0.2227948
  0.007318242 1.280326 0.2227771
  0.006509675 1.280338 0.2227620
  0.005790444 1.280344 0.2227488
  0.005150678 1.280353 0.2227375
  0.004581598 1.280362 0.2227267
  0.004075393 1.280367 0.2227168
  0.003625117 1.280373 0.2227093
  0.003224591 1.280379 0.2227018
  0.002868317 1.280387 0.2226943
  0.002551407 1.280394 0.2226887
  0.002269511 1.280403 0.2226831
  0.002018760 1.280410 0.2226776
  0.001795714 1.280416 0.2226724
  0.001597312 1.280421 0.2226674
  0.001420831 1.280425 0.2226627
  0.001263848 1.280429 0.2226583
  0.001124210 1.280432 0.2226542
  0.001000000 1.280434 0.2226503
Radiation selected: ucm_MRT, ucm_SUN_Gh
Pollution: 1132/2156 complete windows; 11 participants; 13 responses.
Included participants: P10, P11, P12, P13, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: 
Pollution: minimum-error ratio 1 (MSE 1.30574; SE 0.227591); one-SE ratio 1 (MSE 1.30574; SE 0.227591). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.305738 0.2275912
  0.889513497 1.306975 0.2275839
  0.791234262 1.308587 0.2275352
  0.703813555 1.310434 0.2274942
  0.626051657 1.312431 0.2275048
  0.556881399 1.314431 0.2275344
  0.495353521 1.316463 0.2275700
  0.440623643 1.318439 0.2276015
  0.391940677 1.320329 0.2276393
  0.348636523 1.322148 0.2276834
  0.310116893 1.323866 0.2277346
  0.275853162 1.325493 0.2277886
  0.245375111 1.327012 0.2278366
  0.218264473 1.328441 0.2278759
  0.194149195 1.329771 0.2279073
  0.172698329 1.331004 0.2279307
  0.153617495 1.332146 0.2279455
  0.136644835 1.333190 0.2279549
  0.121547425 1.334146 0.2279584
  0.108118075 1.335021 0.2279525
  0.096172487 1.335819 0.2279475
  0.085546725 1.336545 0.2279392
  0.076094967 1.337199 0.2279304
  0.067687500 1.337796 0.2279184
  0.060208945 1.338338 0.2279056
  0.053556669 1.338828 0.2278930
  0.047639380 1.339264 0.2278778
  0.042375872 1.339654 0.2278664
  0.037693910 1.340011 0.2278546
  0.033529241 1.340333 0.2278430
  0.029824713 1.340615 0.2278345
  0.026529485 1.340870 0.2278225
  0.023598335 1.341101 0.2278129
  0.020991037 1.341310 0.2278042
  0.018671811 1.341488 0.2277983
  0.016608828 1.341650 0.2277898
  0.014773777 1.341798 0.2277828
  0.013141474 1.341933 0.2277768
  0.011689518 1.342045 0.2277734
  0.010397984 1.342150 0.2277690
  0.009249147 1.342247 0.2277654
  0.008227241 1.342321 0.2277608
  0.007318242 1.342402 0.2277553
  0.006509675 1.342464 0.2277534
  0.005790444 1.342526 0.2277505
  0.005150678 1.342578 0.2277485
  0.004581598 1.342620 0.2277478
  0.004075393 1.342667 0.2277452
  0.003625117 1.342704 0.2277440
  0.003224591 1.342737 0.2277428
  0.002868317 1.342768 0.2277413
  0.002551407 1.342797 0.2277399
  0.002269511 1.342823 0.2277385
  0.002018760 1.342847 0.2277372
  0.001795714 1.342868 0.2277359
  0.001597312 1.342887 0.2277348
  0.001420831 1.342904 0.2277338
  0.001263848 1.342919 0.2277329
  0.001124210 1.342932 0.2277321
  0.001000000 1.342944 0.2277313
Pollution selected: NONE
Light: 1132/2156 complete windows; 11 participants; 13 responses.
Included participants: P10, P11, P12, P13, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: 
Light: minimum-error ratio 1 (MSE 1.30574; SE 0.227591); one-SE ratio 1 (MSE 1.30574; SE 0.227591). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.305737 0.2275913
  0.889513497 1.306826 0.2276030
  0.791234262 1.307962 0.2275823
  0.703813555 1.308678 0.2276015
  0.626051657 1.309647 0.2275876
  0.556881399 1.310628 0.2275663
  0.495353521 1.311284 0.2275723
  0.440623643 1.312065 0.2275576
  0.391940677 1.312844 0.2275338
  0.348636523 1.313555 0.2275078
  0.310116893 1.314296 0.2274746
  0.275853162 1.315047 0.2274365
  0.245375111 1.315790 0.2273957
  0.218264473 1.316506 0.2273544
  0.194149195 1.317191 0.2273128
  0.172698329 1.317840 0.2272722
  0.153617495 1.318450 0.2272330
  0.136644835 1.319014 0.2271960
  0.121547425 1.319534 0.2271624
  0.108118075 1.320014 0.2271303
  0.096172487 1.320454 0.2271006
  0.085546725 1.320855 0.2270732
  0.076094967 1.321217 0.2270483
  0.067687500 1.321550 0.2270251
  0.060208945 1.321848 0.2270054
  0.053556669 1.322119 0.2269865
  0.047639380 1.322363 0.2269694
  0.042375872 1.322582 0.2269539
  0.037693910 1.322778 0.2269398
  0.033529241 1.322957 0.2269272
  0.029824713 1.323114 0.2269171
  0.026529485 1.323255 0.2269072
  0.023598335 1.323383 0.2268981
  0.020991037 1.323493 0.2268903
  0.018671811 1.323595 0.2268830
  0.016608828 1.323686 0.2268764
  0.014773777 1.323768 0.2268705
  0.013141474 1.323841 0.2268652
  0.011689518 1.323905 0.2268606
  0.010397984 1.323964 0.2268559
  0.009249147 1.324018 0.2268528
  0.008227241 1.324061 0.2268500
  0.007318242 1.324101 0.2268471
  0.006509675 1.324138 0.2268444
  0.005790444 1.324171 0.2268419
  0.005150678 1.324200 0.2268397
  0.004581598 1.324226 0.2268378
  0.004075393 1.324250 0.2268360
  0.003625117 1.324271 0.2268344
  0.003224591 1.324289 0.2268331
  0.002868317 1.324306 0.2268318
  0.002551407 1.324320 0.2268307
  0.002269511 1.324334 0.2268297
  0.002018760 1.324345 0.2268289
  0.001795714 1.324356 0.2268281
  0.001597312 1.324365 0.2268274
  0.001420831 1.324373 0.2268268
  0.001263848 1.324380 0.2268263
  0.001124210 1.324387 0.2268258
  0.001000000 1.324393 0.2268253
Light selected: lys_lux_avg
Greenery: 1131/2156 complete windows; 11 participants; 13 responses.
Included participants: P10, P11, P12, P13, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: 
Greenery: minimum-error ratio 1 (MSE 1.3055; SE 0.227377); one-SE ratio 1 (MSE 1.3055; SE 0.227377). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.305500 0.2273767
  0.889513497 1.305583 0.2272855
  0.791234262 1.305752 0.2272065
  0.703813555 1.305983 0.2271365
  0.626051657 1.306258 0.2270772
  0.556881399 1.306558 0.2270273
  0.495353521 1.306866 0.2269819
  0.440623643 1.307172 0.2269456
  0.391940677 1.307468 0.2269117
  0.348636523 1.307757 0.2268830
  0.310116893 1.308028 0.2268597
  0.275853162 1.308281 0.2268371
  0.245375111 1.308520 0.2268191
  0.218264473 1.308737 0.2268020
  0.194149195 1.308940 0.2267874
  0.172698329 1.309123 0.2267766
  0.153617495 1.309289 0.2267646
  0.136644835 1.309444 0.2267544
  0.121547425 1.309580 0.2267476
  0.108118075 1.309704 0.2267392
  0.096172487 1.309820 0.2267320
  0.085546725 1.309919 0.2267279
  0.076094967 1.310009 0.2267219
  0.067687500 1.310094 0.2267168
  0.060208945 1.310167 0.2267140
  0.053556669 1.310231 0.2267098
  0.047639380 1.310293 0.2267063
  0.042375872 1.310341 0.2267048
  0.037693910 1.310387 0.2267014
  0.033529241 1.310430 0.2266990
  0.029824713 1.310468 0.2266973
  0.026529485 1.310504 0.2266960
  0.023598335 1.310533 0.2266953
  0.020991037 1.310557 0.2266936
  0.018671811 1.310581 0.2266919
  0.016608828 1.310602 0.2266905
  0.014773777 1.310621 0.2266893
  0.013141474 1.310640 0.2266882
  0.011689518 1.310657 0.2266873
  0.010397984 1.310672 0.2266864
  0.009249147 1.310686 0.2266857
  0.008227241 1.310698 0.2266850
  0.007318242 1.310709 0.2266844
  0.006509675 1.310719 0.2266839
  0.005790444 1.310727 0.2266835
  0.005150678 1.310735 0.2266830
  0.004581598 1.310742 0.2266827
  0.004075393 1.310748 0.2266824
  0.003625117 1.310754 0.2266821
  0.003224591 1.310759 0.2266818
  0.002868317 1.310763 0.2266816
  0.002551407 1.310767 0.2266814
  0.002269511 1.310770 0.2266812
  0.002018760 1.310773 0.2266810
  0.001795714 1.310776 0.2266809
  0.001597312 1.310779 0.2266808
  0.001420831 1.310781 0.2266807
  0.001263848 1.310783 0.2266806
  0.001124210 1.310784 0.2266805
  0.001000000 1.310786 0.2266804
Greenery selected: gvi_50m
## Response family: Eyetracker

## Step 4: exploratory domain-wise multi-response LASSO
glmnet version: 4.1.10
Input is matched 10-second windows; 13 response columns; declared HRV log transforms and availability flags respected when applicable.
Leave one participant out. Exposures are participant-mean centered, not global z-scored. After centering, each environmental column is z-scored with the unweighted training-row mean and SD; a non-finite or zero SD drops that column. glmnet standardize=FALSE because those z-scores are already applied. Held-out rows are centered on the held-out participant and then scaled with the training mean and SD. Three sum-to-zero PhaseID contrasts are unscaled and unpenalised; every training fold must span all four conditions. Outcomes are training-fold standardized. Each participant has equal training weight and equal validation weight.
Tune a 60-point relative lambda path (1 to 0.001) by minimum held-out participant MSE. One-SE is sensitivity only. Zero/multiple selections allowed; no forced winner.
Domains are declared measurement groups, not learned groups. Each domain is fitted separately, so retained variables are not mutually adjusted across domains.
Complete cases across the specified response family are required per domain. Samples can differ across families/domains; no imputation.
Exploratory predictive screening only. No mixed-model inference, causal interpretation, unbiased external performance estimate, or post-selection p-values.
Response columns: eyetracker_pupil_diameter_avg, eyetracker_pupil_change_rate, eyetracker_blink_duration_s, eyetracker_fixation_duration_s, eyetracker_fixation_rate, eyetracker_saccade_duration_s, eyetracker_saccade_amplitude, eyetracker_saccade_peak_velocity, eyetracker_gaze_velocity, eyetracker_gaze_dispersion, eyetracker_distance_from_center, eyetracker_gaze_centrality, eyetracker_eyelid_aperture_avg
Missing/non-finite response rows after existing HRV QC: eyetracker_pupil_diameter_avg=307; eyetracker_pupil_change_rate=346; eyetracker_blink_duration_s=391; eyetracker_fixation_duration_s=307; eyetracker_fixation_rate=307; eyetracker_saccade_duration_s=309; eyetracker_saccade_amplitude=309; eyetracker_saccade_peak_velocity=309; eyetracker_gaze_velocity=307; eyetracker_gaze_dispersion=307; eyetracker_distance_from_center=307; eyetracker_gaze_centrality=307; eyetracker_eyelid_aperture_avg=307
Acoustic: 1725/2156 complete windows; 10 participants; 13 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Acoustic: minimum-error ratio 0.310117 (MSE 1.04125; SE 0.113629); one-SE ratio 1 (MSE 1.04278; SE 0.11383). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.042777 0.1138296
  0.889513497 1.042339 0.1137981
  0.791234262 1.042006 0.1137718
  0.703813555 1.041762 0.1137486
  0.626051657 1.041584 0.1137270
  0.556881399 1.041459 0.1137069
  0.495353521 1.041373 0.1136887
  0.440623643 1.041314 0.1136707
  0.391940677 1.041280 0.1136554
  0.348636523 1.041261 0.1136418
  0.310116893 1.041254 0.1136295
  0.275853162 1.041256 0.1136183
  0.245375111 1.041263 0.1136083
  0.218264473 1.041276 0.1135992
  0.194149195 1.041290 0.1135899
  0.172698329 1.041306 0.1135825
  0.153617495 1.041323 0.1135761
  0.136644835 1.041340 0.1135703
  0.121547425 1.041356 0.1135654
  0.108118075 1.041373 0.1135606
  0.096172487 1.041387 0.1135554
  0.085546725 1.041401 0.1135518
  0.076094967 1.041413 0.1135487
  0.067687500 1.041427 0.1135458
  0.060208945 1.041437 0.1135424
  0.053556669 1.041447 0.1135400
  0.047639380 1.041456 0.1135381
  0.042375872 1.041465 0.1135364
  0.037693910 1.041472 0.1135350
  0.033529241 1.041480 0.1135336
  0.029824713 1.041487 0.1135324
  0.026529485 1.041492 0.1135308
  0.023598335 1.041497 0.1135295
  0.020991037 1.041501 0.1135286
  0.018671811 1.041506 0.1135280
  0.016608828 1.041509 0.1135274
  0.014773777 1.041513 0.1135268
  0.013141474 1.041516 0.1135264
  0.011689518 1.041518 0.1135259
  0.010397984 1.041521 0.1135256
  0.009249147 1.041523 0.1135252
  0.008227241 1.041525 0.1135249
  0.007318242 1.041527 0.1135247
  0.006509675 1.041528 0.1135245
  0.005790444 1.041529 0.1135242
  0.005150678 1.041531 0.1135241
  0.004581598 1.041532 0.1135239
  0.004075393 1.041533 0.1135238
  0.003625117 1.041534 0.1135236
  0.003224591 1.041534 0.1135235
  0.002868317 1.041535 0.1135234
  0.002551407 1.041536 0.1135233
  0.002269511 1.041536 0.1135232
  0.002018760 1.041537 0.1135232
  0.001795714 1.041537 0.1135231
  0.001597312 1.041538 0.1135230
  0.001420831 1.041538 0.1135230
  0.001263848 1.041538 0.1135229
  0.001124210 1.041538 0.1135229
  0.001000000 1.041539 0.1135229
Acoustic selected: ucm_SND_dBA
Thermal: 1725/2156 complete windows; 10 participants; 13 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Thermal: minimum-error ratio 0.556881 (MSE 1.0413; SE 0.112391); one-SE ratio 1 (MSE 1.04278; SE 0.113831). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.042775 0.1138312
  0.889513497 1.042161 0.1134814
  0.791234262 1.041733 0.1131747
  0.703813555 1.041485 0.1128843
  0.626051657 1.041342 0.1126317
  0.556881399 1.041299 0.1123907
  0.495353521 1.041422 0.1121519
  0.440623643 1.041820 0.1119087
  0.391940677 1.042313 0.1116786
  0.348636523 1.042865 0.1114905
  0.310116893 1.043446 0.1113381
  0.275853162 1.044034 0.1112177
  0.245375111 1.044613 0.1111184
  0.218264473 1.045175 0.1110346
  0.194149195 1.045707 0.1109645
  0.172698329 1.046212 0.1109040
  0.153617495 1.046682 0.1108520
  0.136644835 1.047118 0.1108075
  0.121547425 1.047513 0.1107696
  0.108118075 1.047880 0.1107360
  0.096172487 1.048215 0.1107071
  0.085546725 1.048516 0.1106821
  0.076094967 1.048792 0.1106596
  0.067687500 1.049041 0.1106404
  0.060208945 1.049263 0.1106234
  0.053556669 1.049467 0.1106082
  0.047639380 1.049646 0.1105955
  0.042375872 1.049810 0.1105836
  0.037693910 1.049956 0.1105734
  0.033529241 1.050086 0.1105646
  0.029824713 1.050205 0.1105561
  0.026529485 1.050308 0.1105495
  0.023598335 1.050402 0.1105432
  0.020991037 1.050489 0.1105371
  0.018671811 1.050561 0.1105327
  0.016608828 1.050628 0.1105283
  0.014773777 1.050689 0.1105241
  0.013141474 1.050741 0.1105210
  0.011689518 1.050789 0.1105180
  0.010397984 1.050831 0.1105151
  0.009249147 1.050868 0.1105129
  0.008227241 1.050902 0.1105109
  0.007318242 1.050932 0.1105090
  0.006509675 1.050960 0.1105070
  0.005790444 1.050985 0.1105058
  0.005150678 1.051007 0.1105044
  0.004581598 1.051027 0.1105029
  0.004075393 1.051046 0.1105016
  0.003625117 1.051064 0.1105003
  0.003224591 1.051079 0.1104991
  0.002868317 1.051093 0.1104981
  0.002551407 1.051106 0.1104971
  0.002269511 1.051117 0.1104963
  0.002018760 1.051127 0.1104955
  0.001795714 1.051136 0.1104949
  0.001597312 1.051144 0.1104943
  0.001420831 1.051151 0.1104937
  0.001263848 1.051158 0.1104933
  0.001124210 1.051163 0.1104928
  0.001000000 1.051168 0.1104925
Thermal selected: ucm_AIR_temp, ucm_WIND_AWS
Index: 1725/2156 complete windows; 10 participants; 13 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Index: minimum-error ratio 0.194149 (MSE 1.03349; SE 0.108738); one-SE ratio 1 (MSE 1.04276; SE 0.113825). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.042764 0.1138254
  0.889513497 1.040715 0.1132404
  0.791234262 1.039159 0.1126695
  0.703813555 1.037955 0.1121583
  0.626051657 1.036809 0.1117106
  0.556881399 1.035845 0.1113164
  0.495353521 1.035130 0.1109623
  0.440623643 1.034590 0.1106160
  0.391940677 1.034173 0.1102639
  0.348636523 1.033889 0.1099483
  0.310116893 1.033703 0.1096627
  0.275853162 1.033589 0.1094008
  0.245375111 1.033525 0.1091619
  0.218264473 1.033496 0.1089417
  0.194149195 1.033489 0.1087383
  0.172698329 1.033496 0.1085495
  0.153617495 1.033510 0.1083717
  0.136644835 1.033530 0.1082020
  0.121547425 1.033553 0.1080381
  0.108118075 1.033584 0.1078816
  0.096172487 1.033622 0.1077304
  0.085546725 1.033671 0.1075871
  0.076094967 1.033732 0.1074530
  0.067687500 1.033801 0.1073258
  0.060208945 1.033878 0.1072088
  0.053556669 1.033960 0.1071011
  0.047639380 1.034046 0.1070024
  0.042375872 1.034133 0.1069128
  0.037693910 1.034220 0.1068332
  0.033529241 1.034306 0.1067618
  0.029824713 1.034388 0.1066963
  0.026529485 1.034467 0.1066387
  0.023598335 1.034542 0.1065874
  0.020991037 1.034611 0.1065419
  0.018671811 1.034676 0.1065011
  0.016608828 1.034734 0.1064638
  0.014773777 1.034791 0.1064323
  0.013141474 1.034840 0.1064029
  0.011689518 1.034886 0.1063772
  0.010397984 1.034928 0.1063546
  0.009249147 1.034966 0.1063349
  0.008227241 1.035000 0.1063163
  0.007318242 1.035030 0.1063004
  0.006509675 1.035057 0.1062869
  0.005790444 1.035082 0.1062737
  0.005150678 1.035105 0.1062629
  0.004581598 1.035123 0.1062526
  0.004075393 1.035142 0.1062442
  0.003625117 1.035158 0.1062359
  0.003224591 1.035172 0.1062282
  0.002868317 1.035185 0.1062224
  0.002551407 1.035197 0.1062167
  0.002269511 1.035208 0.1062125
  0.002018760 1.035216 0.1062072
  0.001795714 1.035224 0.1062034
  0.001597312 1.035232 0.1061997
  0.001420831 1.035238 0.1061962
  0.001263848 1.035244 0.1061928
  0.001124210 1.035250 0.1061896
  0.001000000 1.035256 0.1061865
Index selected: ucm_HUMIDEX, ucm_PET, ucm_UTCI
Radiation: 1725/2156 complete windows; 10 participants; 13 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Radiation: minimum-error ratio 0.172698 (MSE 1.02833; SE 0.109577); one-SE ratio 1 (MSE 1.04277; SE 0.113827). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.042772 0.1138269
  0.889513497 1.039525 0.1133018
  0.791234262 1.036992 0.1128636
  0.703813555 1.035032 0.1124959
  0.626051657 1.033519 0.1121864
  0.556881399 1.032357 0.1119249
  0.495353521 1.031466 0.1117031
  0.440623643 1.030816 0.1115067
  0.391940677 1.030348 0.1112630
  0.348636523 1.029796 0.1109551
  0.310116893 1.029259 0.1106642
  0.275853162 1.028864 0.1104032
  0.245375111 1.028599 0.1101668
  0.218264473 1.028435 0.1099521
  0.194149195 1.028352 0.1097560
  0.172698329 1.028329 0.1095769
  0.153617495 1.028353 0.1094131
  0.136644835 1.028414 0.1092628
  0.121547425 1.028499 0.1091256
  0.108118075 1.028606 0.1089988
  0.096172487 1.028725 0.1088833
  0.085546725 1.028853 0.1087775
  0.076094967 1.028987 0.1086809
  0.067687500 1.029123 0.1085924
  0.060208945 1.029254 0.1085126
  0.053556669 1.029382 0.1084401
  0.047639380 1.029504 0.1083745
  0.042375872 1.029621 0.1083153
  0.037693910 1.029731 0.1082617
  0.033529241 1.029833 0.1082138
  0.029824713 1.029929 0.1081702
  0.026529485 1.030015 0.1081318
  0.023598335 1.030096 0.1080968
  0.020991037 1.030170 0.1080659
  0.018671811 1.030237 0.1080377
  0.016608828 1.030297 0.1080132
  0.014773777 1.030353 0.1079905
  0.013141474 1.030403 0.1079707
  0.011689518 1.030447 0.1079534
  0.010397984 1.030487 0.1079376
  0.009249147 1.030525 0.1079236
  0.008227241 1.030558 0.1079107
  0.007318242 1.030588 0.1078993
  0.006509675 1.030614 0.1078898
  0.005790444 1.030638 0.1078806
  0.005150678 1.030655 0.1078733
  0.004581598 1.030676 0.1078665
  0.004075393 1.030690 0.1078595
  0.003625117 1.030705 0.1078545
  0.003224591 1.030718 0.1078498
  0.002868317 1.030731 0.1078452
  0.002551407 1.030743 0.1078409
  0.002269511 1.030754 0.1078369
  0.002018760 1.030765 0.1078332
  0.001795714 1.030775 0.1078299
  0.001597312 1.030784 0.1078269
  0.001420831 1.030793 0.1078241
  0.001263848 1.030800 0.1078217
  0.001124210 1.030807 0.1078194
  0.001000000 1.030814 0.1078174
Radiation selected: ucm_MRT, ucm_SUN_Gh
Pollution: 1707/2156 complete windows; 10 participants; 13 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Pollution: minimum-error ratio 1 (MSE 1.04148; SE 0.112706); one-SE ratio 1 (MSE 1.04148; SE 0.112706). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.041485 0.1127058
  0.889513497 1.042557 0.1124017
  0.791234262 1.044408 0.1118725
  0.703813555 1.047206 0.1111113
  0.626051657 1.050598 0.1102683
  0.556881399 1.054275 0.1094601
  0.495353521 1.058049 0.1087482
  0.440623643 1.061791 0.1081632
  0.391940677 1.065416 0.1077138
  0.348636523 1.068866 0.1073946
  0.310116893 1.072054 0.1071951
  0.275853162 1.074896 0.1070957
  0.245375111 1.077566 0.1070700
  0.218264473 1.080058 0.1071054
  0.194149195 1.082384 0.1071903
  0.172698329 1.084562 0.1073150
  0.153617495 1.086607 0.1074719
  0.136644835 1.088540 0.1076547
  0.121547425 1.090383 0.1078596
  0.108118075 1.092147 0.1080817
  0.096172487 1.093831 0.1083162
  0.085546725 1.095412 0.1085554
  0.076094967 1.096902 0.1087971
  0.067687500 1.098267 0.1090324
  0.060208945 1.099515 0.1092583
  0.053556669 1.100648 0.1094725
  0.047639380 1.101672 0.1096731
  0.042375872 1.102583 0.1098562
  0.037693910 1.103409 0.1100269
  0.033529241 1.104150 0.1101837
  0.029824713 1.104801 0.1103237
  0.026529485 1.105391 0.1104529
  0.023598335 1.105922 0.1105703
  0.020991037 1.106384 0.1106737
  0.018671811 1.106801 0.1107688
  0.016608828 1.107167 0.1108520
  0.014773777 1.107501 0.1109287
  0.013141474 1.107788 0.1109954
  0.011689518 1.108052 0.1110570
  0.010397984 1.108279 0.1111101
  0.009249147 1.108486 0.1111593
  0.008227241 1.108675 0.1112040
  0.007318242 1.108835 0.1112416
  0.006509675 1.108981 0.1112766
  0.005790444 1.109116 0.1113086
  0.005150678 1.109224 0.1113347
  0.004581598 1.109328 0.1113593
  0.004075393 1.109409 0.1113783
  0.003625117 1.109486 0.1113972
  0.003224591 1.109560 0.1114146
  0.002868317 1.109626 0.1114309
  0.002551407 1.109687 0.1114458
  0.002269511 1.109742 0.1114593
  0.002018760 1.109793 0.1114717
  0.001795714 1.109837 0.1114829
  0.001597312 1.109879 0.1114927
  0.001420831 1.109915 0.1115018
  0.001263848 1.109948 0.1115099
  0.001124210 1.109978 0.1115172
  0.001000000 1.110004 0.1115237
Pollution selected: NONE
Light: 1707/2156 complete windows; 10 participants; 13 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Light: minimum-error ratio 0.703814 (MSE 1.04084; SE 0.112664); one-SE ratio 1 (MSE 1.04148; SE 0.112706). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.041484 0.1127058
  0.889513497 1.041087 0.1126794
  0.791234262 1.040893 0.1126711
  0.703813555 1.040836 0.1126645
  0.626051657 1.041035 0.1126743
  0.556881399 1.041404 0.1126936
  0.495353521 1.041818 0.1127208
  0.440623643 1.042204 0.1127625
  0.391940677 1.042611 0.1128075
  0.348636523 1.043020 0.1128546
  0.310116893 1.043422 0.1129019
  0.275853162 1.043810 0.1129483
  0.245375111 1.044177 0.1129904
  0.218264473 1.044526 0.1130331
  0.194149195 1.044852 0.1130735
  0.172698329 1.045155 0.1131106
  0.153617495 1.045433 0.1131456
  0.136644835 1.045688 0.1131778
  0.121547425 1.045922 0.1132074
  0.108118075 1.046134 0.1132344
  0.096172487 1.046327 0.1132591
  0.085546725 1.046501 0.1132814
  0.076094967 1.046659 0.1133016
  0.067687500 1.046801 0.1133184
  0.060208945 1.046928 0.1133350
  0.053556669 1.047044 0.1133500
  0.047639380 1.047147 0.1133635
  0.042375872 1.047240 0.1133756
  0.037693910 1.047323 0.1133865
  0.033529241 1.047398 0.1133962
  0.029824713 1.047464 0.1134049
  0.026529485 1.047524 0.1134127
  0.023598335 1.047577 0.1134197
  0.020991037 1.047624 0.1134259
  0.018671811 1.047667 0.1134315
  0.016608828 1.047704 0.1134357
  0.014773777 1.047738 0.1134400
  0.013141474 1.047768 0.1134440
  0.011689518 1.047794 0.1134476
  0.010397984 1.047818 0.1134508
  0.009249147 1.047840 0.1134537
  0.008227241 1.047859 0.1134563
  0.007318242 1.047876 0.1134586
  0.006509675 1.047891 0.1134606
  0.005790444 1.047904 0.1134624
  0.005150678 1.047916 0.1134641
  0.004581598 1.047927 0.1134655
  0.004075393 1.047936 0.1134668
  0.003625117 1.047945 0.1134679
  0.003224591 1.047952 0.1134689
  0.002868317 1.047959 0.1134699
  0.002551407 1.047965 0.1134707
  0.002269511 1.047970 0.1134714
  0.002018760 1.047975 0.1134720
  0.001795714 1.047979 0.1134726
  0.001597312 1.047983 0.1134731
  0.001420831 1.047986 0.1134735
  0.001263848 1.047989 0.1134739
  0.001124210 1.047992 0.1134743
  0.001000000 1.047994 0.1134746
Light selected: lys_lux_avg
Greenery: 1715/2156 complete windows; 10 participants; 13 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Greenery: minimum-error ratio 0.556881 (MSE 1.04102; SE 0.114366); one-SE ratio 1 (MSE 1.04165; SE 0.114673). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.041653 0.1146732
  0.889513497 1.041394 0.1145959
  0.791234262 1.041219 0.1145310
  0.703813555 1.041110 0.1144714
  0.626051657 1.041048 0.1144156
  0.556881399 1.041022 0.1143656
  0.495353521 1.041023 0.1143202
  0.440623643 1.041040 0.1142778
  0.391940677 1.041071 0.1142406
  0.348636523 1.041110 0.1142069
  0.310116893 1.041152 0.1141754
  0.275853162 1.041197 0.1141483
  0.245375111 1.041243 0.1141238
  0.218264473 1.041288 0.1141007
  0.194149195 1.041331 0.1140812
  0.172698329 1.041374 0.1140636
  0.153617495 1.041412 0.1140468
  0.136644835 1.041449 0.1140329
  0.121547425 1.041483 0.1140204
  0.108118075 1.041514 0.1140082
  0.096172487 1.041542 0.1139983
  0.085546725 1.041569 0.1139895
  0.076094967 1.041592 0.1139806
  0.067687500 1.041614 0.1139737
  0.060208945 1.041634 0.1139675
  0.053556669 1.041651 0.1139610
  0.047639380 1.041667 0.1139561
  0.042375872 1.041681 0.1139519
  0.037693910 1.041692 0.1139473
  0.033529241 1.041705 0.1139435
  0.029824713 1.041715 0.1139407
  0.026529485 1.041725 0.1139381
  0.023598335 1.041734 0.1139358
  0.020991037 1.041741 0.1139332
  0.018671811 1.041747 0.1139311
  0.016608828 1.041753 0.1139295
  0.014773777 1.041759 0.1139280
  0.013141474 1.041764 0.1139268
  0.011689518 1.041769 0.1139257
  0.010397984 1.041774 0.1139248
  0.009249147 1.041778 0.1139239
  0.008227241 1.041781 0.1139232
  0.007318242 1.041785 0.1139225
  0.006509675 1.041788 0.1139219
  0.005790444 1.041790 0.1139214
  0.005150678 1.041792 0.1139209
  0.004581598 1.041795 0.1139205
  0.004075393 1.041796 0.1139202
  0.003625117 1.041798 0.1139198
  0.003224591 1.041799 0.1139196
  0.002868317 1.041801 0.1139193
  0.002551407 1.041802 0.1139191
  0.002269511 1.041803 0.1139189
  0.002018760 1.041804 0.1139187
  0.001795714 1.041805 0.1139185
  0.001597312 1.041805 0.1139184
  0.001420831 1.041806 0.1139182
  0.001263848 1.041807 0.1139181
  0.001124210 1.041807 0.1139180
  0.001000000 1.041808 0.1139179
Greenery selected: gvi_50m
## Response family: Combined

## Step 4: exploratory domain-wise multi-response LASSO
glmnet version: 4.1.10
Input is matched 10-second windows; 26 response columns; declared HRV log transforms and availability flags respected when applicable.
Leave one participant out. Exposures are participant-mean centered, not global z-scored. After centering, each environmental column is z-scored with the unweighted training-row mean and SD; a non-finite or zero SD drops that column. glmnet standardize=FALSE because those z-scores are already applied. Held-out rows are centered on the held-out participant and then scaled with the training mean and SD. Three sum-to-zero PhaseID contrasts are unscaled and unpenalised; every training fold must span all four conditions. Outcomes are training-fold standardized. Each participant has equal training weight and equal validation weight.
Tune a 60-point relative lambda path (1 to 0.001) by minimum held-out participant MSE. One-SE is sensitivity only. Zero/multiple selections allowed; no forced winner.
Domains are declared measurement groups, not learned groups. Each domain is fitted separately, so retained variables are not mutually adjusted across domains.
Complete cases across the specified response family are required per domain. Samples can differ across families/domains; no imputation.
Exploratory predictive screening only. No mixed-model inference, causal interpretation, unbiased external performance estimate, or post-selection p-values.
Response columns: empatica_heart_rate, empatica_eda_tonic, empatica_eda_phasic, empatica_skin_temperature, empatica_hrv_td_sdnn, empatica_hrv_td_rmssd, empatica_hrv_fd_lf, empatica_hrv_fd_hf, empatica_hrv_fd_lf_hf_ratio, empatica_hrv_fd_lfnu, empatica_hrv_fd_hfnu, empatica_hrv_fd_vlf, empatica_hrv_fd_total_power, eyetracker_pupil_diameter_avg, eyetracker_pupil_change_rate, eyetracker_blink_duration_s, eyetracker_fixation_duration_s, eyetracker_fixation_rate, eyetracker_saccade_duration_s, eyetracker_saccade_amplitude, eyetracker_saccade_peak_velocity, eyetracker_gaze_velocity, eyetracker_gaze_dispersion, eyetracker_distance_from_center, eyetracker_gaze_centrality, eyetracker_eyelid_aperture_avg
Missing/non-finite response rows after existing HRV QC: empatica_heart_rate=0; empatica_eda_tonic=274; empatica_eda_phasic=0; empatica_skin_temperature=0; empatica_hrv_td_sdnn=335; empatica_hrv_td_rmssd=169; empatica_hrv_fd_lf=787; empatica_hrv_fd_hf=787; empatica_hrv_fd_lf_hf_ratio=787; empatica_hrv_fd_lfnu=787; empatica_hrv_fd_hfnu=787; empatica_hrv_fd_vlf=787; empatica_hrv_fd_total_power=787; eyetracker_pupil_diameter_avg=307; eyetracker_pupil_change_rate=346; eyetracker_blink_duration_s=391; eyetracker_fixation_duration_s=307; eyetracker_fixation_rate=307; eyetracker_saccade_duration_s=309; eyetracker_saccade_amplitude=309; eyetracker_saccade_peak_velocity=309; eyetracker_gaze_velocity=307; eyetracker_gaze_dispersion=307; eyetracker_distance_from_center=307; eyetracker_gaze_centrality=307; eyetracker_eyelid_aperture_avg=307
Acoustic: 949/2156 complete windows; 10 participants; 26 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Acoustic: minimum-error ratio 0.391941 (MSE 1.13304; SE 0.116589); one-SE ratio 1 (MSE 1.13535; SE 0.117357). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.135349 0.1173569
  0.889513497 1.134577 0.1172303
  0.791234262 1.134015 0.1171130
  0.703813555 1.133623 0.1170048
  0.626051657 1.133358 0.1169056
  0.556881399 1.133189 0.1168148
  0.495353521 1.133093 0.1167319
  0.440623643 1.133049 0.1166570
  0.391940677 1.133043 0.1165890
  0.348636523 1.133064 0.1165276
  0.310116893 1.133103 0.1164721
  0.275853162 1.133155 0.1164222
  0.245375111 1.133214 0.1163773
  0.218264473 1.133277 0.1163371
  0.194149195 1.133340 0.1163010
  0.172698329 1.133404 0.1162686
  0.153617495 1.133465 0.1162395
  0.136644835 1.133523 0.1162134
  0.121547425 1.133579 0.1161904
  0.108118075 1.133631 0.1161697
  0.096172487 1.133679 0.1161513
  0.085546725 1.133723 0.1161345
  0.076094967 1.133764 0.1161197
  0.067687500 1.133800 0.1161068
  0.060208945 1.133835 0.1160950
  0.053556669 1.133865 0.1160843
  0.047639380 1.133894 0.1160749
  0.042375872 1.133917 0.1160665
  0.037693910 1.133941 0.1160595
  0.033529241 1.133961 0.1160532
  0.029824713 1.133978 0.1160469
  0.026529485 1.133993 0.1160420
  0.023598335 1.134010 0.1160373
  0.020991037 1.134023 0.1160332
  0.018671811 1.134036 0.1160299
  0.016608828 1.134048 0.1160263
  0.014773777 1.134055 0.1160233
  0.013141474 1.134062 0.1160211
  0.011689518 1.134071 0.1160188
  0.010397984 1.134078 0.1160168
  0.009249147 1.134084 0.1160149
  0.008227241 1.134090 0.1160132
  0.007318242 1.134095 0.1160118
  0.006509675 1.134099 0.1160105
  0.005790444 1.134103 0.1160093
  0.005150678 1.134107 0.1160082
  0.004581598 1.134110 0.1160073
  0.004075393 1.134113 0.1160065
  0.003625117 1.134115 0.1160058
  0.003224591 1.134117 0.1160051
  0.002868317 1.134119 0.1160045
  0.002551407 1.134121 0.1160040
  0.002269511 1.134123 0.1160036
  0.002018760 1.134124 0.1160032
  0.001795714 1.134125 0.1160028
  0.001597312 1.134126 0.1160025
  0.001420831 1.134127 0.1160022
  0.001263848 1.134128 0.1160019
  0.001124210 1.134129 0.1160017
  0.001000000 1.134130 0.1160015
Acoustic selected: ucm_SND_dBA
Thermal: 949/2156 complete windows; 10 participants; 26 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Thermal: minimum-error ratio 0.391941 (MSE 1.11585; SE 0.111478); one-SE ratio 1 (MSE 1.13528; SE 0.117336). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.135285 0.1173363
  0.889513497 1.129794 0.1160378
  0.791234262 1.125494 0.1149708
  0.703813555 1.122238 0.1141236
  0.626051657 1.119791 0.1134494
  0.556881399 1.117952 0.1129071
  0.495353521 1.116684 0.1124505
  0.440623643 1.115940 0.1119939
  0.391940677 1.115853 0.1114783
  0.348636523 1.116092 0.1109910
  0.310116893 1.116514 0.1105816
  0.275853162 1.117069 0.1102363
  0.245375111 1.117688 0.1099442
  0.218264473 1.118423 0.1097105
  0.194149195 1.119237 0.1095237
  0.172698329 1.120085 0.1093759
  0.153617495 1.120950 0.1092583
  0.136644835 1.121800 0.1091661
  0.121547425 1.122633 0.1090915
  0.108118075 1.123426 0.1090346
  0.096172487 1.124174 0.1089887
  0.085546725 1.124880 0.1089505
  0.076094967 1.125534 0.1089213
  0.067687500 1.126138 0.1088991
  0.060208945 1.126693 0.1088809
  0.053556669 1.127207 0.1088659
  0.047639380 1.127671 0.1088538
  0.042375872 1.128093 0.1088456
  0.037693910 1.128477 0.1088366
  0.033529241 1.128830 0.1088295
  0.029824713 1.129140 0.1088245
  0.026529485 1.129427 0.1088202
  0.023598335 1.129677 0.1088166
  0.020991037 1.129908 0.1088139
  0.018671811 1.130110 0.1088113
  0.016608828 1.130296 0.1088095
  0.014773777 1.130463 0.1088074
  0.013141474 1.130608 0.1088061
  0.011689518 1.130741 0.1088050
  0.010397984 1.130855 0.1088038
  0.009249147 1.130963 0.1088026
  0.008227241 1.131060 0.1088020
  0.007318242 1.131139 0.1088014
  0.006509675 1.131214 0.1088010
  0.005790444 1.131283 0.1088006
  0.005150678 1.131340 0.1087997
  0.004581598 1.131392 0.1087993
  0.004075393 1.131441 0.1087997
  0.003625117 1.131485 0.1087975
  0.003224591 1.131518 0.1087977
  0.002868317 1.131551 0.1087982
  0.002551407 1.131581 0.1087986
  0.002269511 1.131610 0.1087989
  0.002018760 1.131638 0.1087991
  0.001795714 1.131663 0.1087992
  0.001597312 1.131686 0.1087992
  0.001420831 1.131708 0.1087993
  0.001263848 1.131727 0.1087993
  0.001124210 1.131744 0.1087993
  0.001000000 1.131759 0.1087992
Thermal selected: ucm_AIR_temp, ucm_WIND_AWS
Index: 949/2156 complete windows; 10 participants; 26 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Index: minimum-error ratio 0.172698 (MSE 1.11127; SE 0.11369); one-SE ratio 1 (MSE 1.13534; SE 0.117357). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.135342 0.1173566
  0.889513497 1.130673 0.1165783
  0.791234262 1.126392 0.1159014
  0.703813555 1.122643 0.1154778
  0.626051657 1.119365 0.1151050
  0.556881399 1.116945 0.1147875
  0.495353521 1.115180 0.1145407
  0.440623643 1.113919 0.1143490
  0.391940677 1.113047 0.1141998
  0.348636523 1.112448 0.1140853
  0.310116893 1.112008 0.1140036
  0.275853162 1.111749 0.1139400
  0.245375111 1.111525 0.1138659
  0.218264473 1.111368 0.1137952
  0.194149195 1.111292 0.1137379
  0.172698329 1.111269 0.1136899
  0.153617495 1.111276 0.1136488
  0.136644835 1.111301 0.1136122
  0.121547425 1.111334 0.1135806
  0.108118075 1.111367 0.1135527
  0.096172487 1.111393 0.1135260
  0.085546725 1.111415 0.1135013
  0.076094967 1.111434 0.1134781
  0.067687500 1.111452 0.1134550
  0.060208945 1.111473 0.1134324
  0.053556669 1.111501 0.1134094
  0.047639380 1.111535 0.1133860
  0.042375872 1.111579 0.1133621
  0.037693910 1.111633 0.1133383
  0.033529241 1.111693 0.1133148
  0.029824713 1.111759 0.1132920
  0.026529485 1.111829 0.1132703
  0.023598335 1.111902 0.1132498
  0.020991037 1.111975 0.1132303
  0.018671811 1.112047 0.1132129
  0.016608828 1.112117 0.1131963
  0.014773777 1.112184 0.1131810
  0.013141474 1.112248 0.1131669
  0.011689518 1.112306 0.1131542
  0.010397984 1.112363 0.1131422
  0.009249147 1.112414 0.1131318
  0.008227241 1.112461 0.1131222
  0.007318242 1.112504 0.1131135
  0.006509675 1.112544 0.1131057
  0.005790444 1.112581 0.1130985
  0.005150678 1.112613 0.1130926
  0.004581598 1.112643 0.1130864
  0.004075393 1.112670 0.1130816
  0.003625117 1.112693 0.1130771
  0.003224591 1.112716 0.1130724
  0.002868317 1.112734 0.1130680
  0.002551407 1.112750 0.1130647
  0.002269511 1.112763 0.1130599
  0.002018760 1.112776 0.1130562
  0.001795714 1.112788 0.1130532
  0.001597312 1.112799 0.1130517
  0.001420831 1.112811 0.1130497
  0.001263848 1.112819 0.1130481
  0.001124210 1.112827 0.1130470
  0.001000000 1.112835 0.1130450
Index selected: ucm_HUMIDEX, ucm_PET, ucm_UTCI
Radiation: 949/2156 complete windows; 10 participants; 26 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Radiation: minimum-error ratio 0.153617 (MSE 1.11136; SE 0.114217); one-SE ratio 1 (MSE 1.13535; SE 0.117357). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.135350 0.1173570
  0.889513497 1.131198 0.1172179
  0.791234262 1.127984 0.1171133
  0.703813555 1.125517 0.1170341
  0.626051657 1.123469 0.1169764
  0.556881399 1.121341 0.1169623
  0.495353521 1.119122 0.1168421
  0.440623643 1.116947 0.1164490
  0.391940677 1.115293 0.1161007
  0.348636523 1.114048 0.1157905
  0.310116893 1.113128 0.1155098
  0.275853162 1.112460 0.1152533
  0.245375111 1.111987 0.1150159
  0.218264473 1.111673 0.1147960
  0.194149195 1.111479 0.1145909
  0.172698329 1.111383 0.1143976
  0.153617495 1.111357 0.1142167
  0.136644835 1.111384 0.1140473
  0.121547425 1.111452 0.1138901
  0.108118075 1.111552 0.1137420
  0.096172487 1.111667 0.1136057
  0.085546725 1.111795 0.1134804
  0.076094967 1.111931 0.1133643
  0.067687500 1.112071 0.1132586
  0.060208945 1.112207 0.1131620
  0.053556669 1.112341 0.1130732
  0.047639380 1.112469 0.1129941
  0.042375872 1.112593 0.1129225
  0.037693910 1.112707 0.1128567
  0.033529241 1.112815 0.1127984
  0.029824713 1.112917 0.1127451
  0.026529485 1.113008 0.1126978
  0.023598335 1.113094 0.1126551
  0.020991037 1.113171 0.1126169
  0.018671811 1.113240 0.1125830
  0.016608828 1.113309 0.1125526
  0.014773777 1.113366 0.1125258
  0.013141474 1.113420 0.1125014
  0.011689518 1.113467 0.1124799
  0.010397984 1.113511 0.1124604
  0.009249147 1.113550 0.1124425
  0.008227241 1.113584 0.1124276
  0.007318242 1.113616 0.1124136
  0.006509675 1.113642 0.1124016
  0.005790444 1.113668 0.1123907
  0.005150678 1.113692 0.1123809
  0.004581598 1.113711 0.1123724
  0.004075393 1.113729 0.1123647
  0.003625117 1.113745 0.1123582
  0.003224591 1.113760 0.1123517
  0.002868317 1.113773 0.1123468
  0.002551407 1.113784 0.1123417
  0.002269511 1.113794 0.1123376
  0.002018760 1.113801 0.1123345
  0.001795714 1.113809 0.1123313
  0.001597312 1.113816 0.1123281
  0.001420831 1.113822 0.1123250
  0.001263848 1.113828 0.1123220
  0.001124210 1.113834 0.1123191
  0.001000000 1.113840 0.1123164
Radiation selected: ucm_MRT, ucm_SUN_Gh
Pollution: 949/2156 complete windows; 10 participants; 26 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Pollution: minimum-error ratio 1 (MSE 1.13536; SE 0.117357); one-SE ratio 1 (MSE 1.13536; SE 0.117357). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.135356 0.1173567
  0.889513497 1.137167 0.1171320
  0.791234262 1.139765 0.1167544
  0.703813555 1.142936 0.1163365
  0.626051657 1.146540 0.1160174
  0.556881399 1.150301 0.1157775
  0.495353521 1.154039 0.1156167
  0.440623643 1.157758 0.1155284
  0.391940677 1.161317 0.1155173
  0.348636523 1.164742 0.1155637
  0.310116893 1.167947 0.1156532
  0.275853162 1.170951 0.1157848
  0.245375111 1.173778 0.1159464
  0.218264473 1.176407 0.1161277
  0.194149195 1.178838 0.1163200
  0.172698329 1.181074 0.1165165
  0.153617495 1.183122 0.1167117
  0.136644835 1.184992 0.1169017
  0.121547425 1.186692 0.1170843
  0.108118075 1.188234 0.1172577
  0.096172487 1.189630 0.1174209
  0.085546725 1.190889 0.1175717
  0.076094967 1.192027 0.1177131
  0.067687500 1.193053 0.1178437
  0.060208945 1.193974 0.1179639
  0.053556669 1.194787 0.1180721
  0.047639380 1.195530 0.1181725
  0.042375872 1.196194 0.1182628
  0.037693910 1.196790 0.1183461
  0.033529241 1.197325 0.1184215
  0.029824713 1.197790 0.1184875
  0.026529485 1.198215 0.1185475
  0.023598335 1.198598 0.1186033
  0.020991037 1.198925 0.1186511
  0.018671811 1.199230 0.1186959
  0.016608828 1.199505 0.1187363
  0.014773777 1.199747 0.1187719
  0.013141474 1.199950 0.1188021
  0.011689518 1.200143 0.1188310
  0.010397984 1.200318 0.1188572
  0.009249147 1.200472 0.1188815
  0.008227241 1.200598 0.1189004
  0.007318242 1.200717 0.1189176
  0.006509675 1.200827 0.1189340
  0.005790444 1.200926 0.1189498
  0.005150678 1.201014 0.1189638
  0.004581598 1.201084 0.1189739
  0.004075393 1.201160 0.1189865
  0.003625117 1.201217 0.1189950
  0.003224591 1.201269 0.1190032
  0.002868317 1.201319 0.1190109
  0.002551407 1.201364 0.1190178
  0.002269511 1.201405 0.1190241
  0.002018760 1.201442 0.1190297
  0.001795714 1.201476 0.1190348
  0.001597312 1.201506 0.1190393
  0.001420831 1.201532 0.1190433
  0.001263848 1.201556 0.1190469
  0.001124210 1.201578 0.1190501
  0.001000000 1.201597 0.1190529
Pollution selected: NONE
Light: 949/2156 complete windows; 10 participants; 26 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Light: minimum-error ratio 0.791234 (MSE 1.13508; SE 0.117736); one-SE ratio 1 (MSE 1.13536; SE 0.117357). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.135356 0.1173569
  0.889513497 1.135262 0.1175336
  0.791234262 1.135080 0.1177360
  0.703813555 1.135305 0.1178844
  0.626051657 1.135749 0.1180093
  0.556881399 1.136286 0.1180942
  0.495353521 1.136887 0.1181538
  0.440623643 1.137545 0.1182059
  0.391940677 1.138225 0.1182521
  0.348636523 1.138910 0.1182932
  0.310116893 1.139581 0.1183300
  0.275853162 1.140227 0.1183633
  0.245375111 1.140840 0.1183939
  0.218264473 1.141415 0.1184213
  0.194149195 1.141950 0.1184463
  0.172698329 1.142446 0.1184690
  0.153617495 1.142904 0.1184898
  0.136644835 1.143323 0.1185086
  0.121547425 1.143706 0.1185255
  0.108118075 1.144054 0.1185412
  0.096172487 1.144369 0.1185552
  0.085546725 1.144652 0.1185681
  0.076094967 1.144910 0.1185794
  0.067687500 1.145143 0.1185896
  0.060208945 1.145352 0.1185987
  0.053556669 1.145540 0.1186069
  0.047639380 1.145706 0.1186142
  0.042375872 1.145857 0.1186217
  0.037693910 1.145993 0.1186276
  0.033529241 1.146115 0.1186328
  0.029824713 1.146223 0.1186375
  0.026529485 1.146320 0.1186417
  0.023598335 1.146407 0.1186454
  0.020991037 1.146485 0.1186488
  0.018671811 1.146554 0.1186517
  0.016608828 1.146614 0.1186545
  0.014773777 1.146669 0.1186569
  0.013141474 1.146718 0.1186589
  0.011689518 1.146761 0.1186608
  0.010397984 1.146800 0.1186627
  0.009249147 1.146835 0.1186644
  0.008227241 1.146866 0.1186657
  0.007318242 1.146894 0.1186669
  0.006509675 1.146919 0.1186679
  0.005790444 1.146941 0.1186688
  0.005150678 1.146960 0.1186696
  0.004581598 1.146978 0.1186704
  0.004075393 1.146993 0.1186710
  0.003625117 1.147007 0.1186716
  0.003224591 1.147019 0.1186721
  0.002868317 1.147030 0.1186725
  0.002551407 1.147040 0.1186729
  0.002269511 1.147049 0.1186733
  0.002018760 1.147056 0.1186736
  0.001795714 1.147063 0.1186739
  0.001597312 1.147069 0.1186742
  0.001420831 1.147075 0.1186744
  0.001263848 1.147080 0.1186746
  0.001124210 1.147084 0.1186748
  0.001000000 1.147088 0.1186749
Light selected: lys_kelvin_avg
Greenery: 949/2156 complete windows; 10 participants; 26 responses.
Included participants: P10, P11, P12, P14, P15, P16, P17, P4, P8, P9
Participants with no complete windows: P13
Greenery: minimum-error ratio 0.703814 (MSE 1.13474; SE 0.116358); one-SE ratio 1 (MSE 1.13535; SE 0.117351). SE is a fold-based tuning heuristic, not an inferential CI.
 Lambda_Ratio   CV_MSE     CV_SE
  1.000000000 1.135352 0.1173511
  0.889513497 1.134995 0.1169982
  0.791234262 1.134805 0.1166631
  0.703813555 1.134740 0.1163577
  0.626051657 1.134760 0.1160782
  0.556881399 1.134847 0.1158250
  0.495353521 1.134975 0.1155952
  0.440623643 1.135126 0.1153874
  0.391940677 1.135298 0.1152011
  0.348636523 1.135474 0.1150320
  0.310116893 1.135648 0.1148810
  0.275853162 1.135823 0.1147452
  0.245375111 1.135986 0.1146235
  0.218264473 1.136145 0.1145140
  0.194149195 1.136296 0.1144163
  0.172698329 1.136432 0.1143291
  0.153617495 1.136561 0.1142514
  0.136644835 1.136680 0.1141810
  0.121547425 1.136785 0.1141188
  0.108118075 1.136885 0.1140637
  0.096172487 1.136974 0.1140144
  0.085546725 1.137054 0.1139695
  0.076094967 1.137129 0.1139304
  0.067687500 1.137194 0.1138956
  0.060208945 1.137253 0.1138637
  0.053556669 1.137308 0.1138361
  0.047639380 1.137356 0.1138116
  0.042375872 1.137400 0.1137890
  0.037693910 1.137438 0.1137696
  0.033529241 1.137472 0.1137525
  0.029824713 1.137502 0.1137366
  0.026529485 1.137532 0.1137228
  0.023598335 1.137554 0.1137109
  0.020991037 1.137577 0.1136998
  0.018671811 1.137598 0.1136894
  0.016608828 1.137617 0.1136800
  0.014773777 1.137630 0.1136735
  0.013141474 1.137644 0.1136669
  0.011689518 1.137657 0.1136605
  0.010397984 1.137669 0.1136545
  0.009249147 1.137680 0.1136490
  0.008227241 1.137690 0.1136440
  0.007318242 1.137700 0.1136396
  0.006509675 1.137708 0.1136355
  0.005790444 1.137715 0.1136320
  0.005150678 1.137722 0.1136287
  0.004581598 1.137728 0.1136259
  0.004075393 1.137733 0.1136234
  0.003625117 1.137738 0.1136211
  0.003224591 1.137742 0.1136191
  0.002868317 1.137745 0.1136173
  0.002551407 1.137749 0.1136157
  0.002269511 1.137752 0.1136143
  0.002018760 1.137754 0.1136130
  0.001795714 1.137757 0.1136119
  0.001597312 1.137759 0.1136109
  0.001420831 1.137760 0.1136100
  0.001263848 1.137762 0.1136092
  0.001124210 1.137764 0.1136085
  0.001000000 1.137765 0.1136079
Greenery selected: gvi_50m
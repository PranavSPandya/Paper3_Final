# Environmental Comfort and Urban Biking: Linking Ridership to Micrometeorological Indicators and Location Characteristics

# Abstract

Understanding how environmental conditions and urban design characteristics influence bike ridership is essential for promoting sustainable urban mobility; however, most studies focus on city-wide trends and overlook local variations in microclimate and context. This paper presents a methodology that integrates automated bike count data with high-resolution micrometeorological modeling and urban spatial indicators to quantify how thermal comfort, weather conditions, and streetscape characteristics affect bike ridership at hourly and seasonal timescales.

The methodology addresses two critical data limitations in bike count analysis: (i) short temporal gaps due to sensor malfunctions, and (ii) spatial coverage constraints. We develop a temporal count prediction model to impute missing data and a new station prediction model to estimate counts at unmonitored locations.

The proposed methodology demonstrates the benefits of using bike counter data and enables cities with different urban contexts to quantify local environmental barriers to biking, predict usage at potential counter locations.

Applied to the Brussels Capital Region (BCR) using data from 18 bike counters (2022-2024), the study focuses on weekend biking to isolate environmental comfort effects from commuting patterns. Statistical analysis reveals that rain and wind conditions suppress biking by (−7.40% to −15.38%), while combined rain and wind conditions suppress biking (−2.18% to −16.15%), cold stress showed stronger reductions in biking activity than heat stress (−6.19% to −8.49% vs. −3.35% to −3.66%), while greenness alone shows small independent effects (−6.23% to +8.02%). Shade was not reportable due to insufficient exposed observations, while during heat stress periods greenness shows small effects (−5.53% to +2.11%).

Keywords: Urban Thermal Comfort, Automated Bike Counters, Micrometeorological Modeling, Sustainable Urban Mobility, Predictive Modeling, Environmental Comfort

# Introduction

Many cities are promoting biking through infrastructure and bike-friendly policies to address traffic challenges and pursue sustainable urban mobility solutions [1]. Yet psychophysiological comfort often remains a barrier to bike adoption [2]. If biking environments are not comfortable and pleasant, promotion alone will not translate into actual bike ridership [3–6]. While municipal policies frequently prioritize utilitarian commuting, environmental microclimate barriers uniquely affect weekend riders with choices of when and where to bike compared to rigidly scheduled weekday commuters.

Several data sources have been used to document bike ridership in urban areas and to examine its relationship with environmental conditions, with docking station data, bike-sharing trip data, and automatic bike counter data among the most commonly used.

(1) Docking station data (which record shared bike pick-ups and drop-offs at fixed locations) have primarily been used in city-scale analyses. Using such data, previous studies have shown that environmental factors influence bike ridership [7,8]. For example, Willberg et al. [7] combined bike docking station data with a spatial pathfinding model incorporating environmental factors such as noise, air quality, and green spaces to estimate environmental exposure. Tang et al. [9] analyzed the association between docked bike-sharing demand and the built environment across land use, density, and network characteristics. These approaches demonstrate the potential of docking data for integrating environmental characteristics into biking analyses, while representing bikers’ movements across the city through modeled paths rather than directly observed trajectories, with route choice informed by environmental and urban characteristics.

(2) Bike-sharing trip data (i.e., GPS-based bike trajectory data capturing individual trip paths) enable the analysis of bike ridership at finer spatial and temporal resolutions. For example, using data from Boston’s Blue bikes program, Young et al. [10] modeled outdoor thermal comfort along three biking routes to predict ridership. Betkier et al. [11] and Li et al. [12] applied spatio-temporal deep-learning frameworks to predict short-term ridership demand across street networks, while Wang et al. [13] used bike sharing trip data to evaluate bikeability. However, bike-sharing trip data are representative of shared-bike users and may exhibit systematic differences from weekend biking patterns, particularly regarding weekend usage and sensitivity to comfort-related factors.

(3) Automatic bike counters (devices that record bike passages, commonly using induction-loop detectors embedded beneath bike lanes or infrared sensors mounted along biking infrastructure) have been used to quantify biking volumes and examine their relationships with environmental conditions [14]. For example, Ermagun et al. [15] and Nosal and Miranda-Moreno [16] used automatic bike counter data to examine the effects of weather on bike ridership, quantifying the impacts of temperature, precipitation, wind, and humidity, as reflected in changes in biking demand. In these studies, meteorological variables were represented at the city scale using data from nearby regulatory weather stations, while bike count data were aggregated to daily totals. This level of temporal and spatial aggregation enabled comparisons across multiple cities, rather than analyses of intra-city variability, which would require consideration of local urban context and city-specific spatiotemporal patterns at finer temporal resolutions. Given the automated counters are sparsely distributed, recent studies have started to examine spatial extrapolation and transferability methods to estimate biking volumes across unmonitored sites [17].

In the past few years, automatic bike counters have been installed in several cities including – Brussels, New York, Helsinki, Paris, Strasbourg, Bern, Hamburg, Bonn, Heidelberg amongst others [6,18]. When analyzed in conjunction with high–spatiotemporal-resolution urban and micrometeorological data, automatic bike counter data offer an opportunity to evaluate how local urban design and environmental conditions surrounding each counter shape bike ridership at that location, enabling intra-urban comparisons across multiple counter sites within the same city. Yet, to the authors’ knowledge, no prior work has integrated such data with micrometeorological and urban indicators to examine how environmental comfort is associated with bike ridership across hourly, diurnal, and seasonal timescales—hence the focus of this study.

As stated before, this paper relates environmental comfort to bike counts. Here, environmental comfort refers to the quality of outdoor conditions as experienced by people in urban spaces. It is understood as a combination of thermal comfort, weather-related comfort, and urban environmental conditions, all of which are influenced by the interaction between climate and urban form. Bike counts are hourly measures of passage at distinct locations. The locations are sparse and counters may fail or counting locations may undergo changes.

Before meaningful relationships can be explored both data sources have to be validated and, if necessary, corrected. The paper therefore starts by addressing challenges related to data availability in automatic bike count records. Such limitations affect the spatial and temporal completeness of observed counts and raise concerns about data reliability and their usefulness for examining city-wide bike ridership [17]. Specifically, (i) bike count data are often incomplete due to sensor malfunctions, power outages, and temporary road blockages such as maintenance works or diversions,  which are issues that are difficult to avoid in practice [19]. (ii) In addition, the number of bike counters that can be deployed within a city is inherently limited by financial and implementation constraints, resulting in sparse spatial coverage [20,21]. In this context, the paper presents two models: (i) a temporal count prediction model to complete missing bike count data, and (ii) a new station count prediction model that leverages station typologies to estimate counts at locations where a counting station is unavailable. This paper then proposes a methodology to assess how bike ridership is associated with environmental comfort by studying variations across hourly, diurnal, and seasonal timescales, considering local micrometeorological conditions (e.g., rain, wind, solar radiation, mean radiant temperature, air temperature, and relative humidity) and urban design characteristics (such as greenness and shading from green infrastructure and buildings), using automatic bike counter data together with detailed urban and environmental datasets.

Thermal comfort is assessed using the Universal Thermal Climate Index (UTCI), where thresholds encompass moderate heat stress (26°C ≤ UTCI < 32°C), strong heat stress (UTCI ≥ 32°C), moderate cold stress (-13°C < UTCI ≤ 0°C), and strong cold stress (UTCI < -13°C) [22].

A methodology that combines environmental, urban, and automatic bike counter data, and processes these datasets using thermal comfort, vegetation classification, spatial analysis, and prediction models is proposed to assess bike ridership. This methodology is applied to a case study in the Brussels Capital Region (BCR), selected for its extensive bike counter infrastructure, dedicated biking network, and strong public engagement in biking. First, a temporal count prediction model is applied to impute missing bike count data. The three components have distinct roles: temporal prediction addresses data gaps, the primary analysis evaluates environmental associations, and the new-station model addresses spatial coverage. The resulting complete dataset is then used to quantitatively test seven research hypotheses (H1–H7, described below) focusing on ridership during weekend, which is the most representative of personal biking preferences rather than commute to work. H1–H4 addresses environmental conditions and H5–H7 addresses urban design characteristics. Finally, the new station count prediction model is implemented to assess its potential for estimating bike counts at unmonitored locations:

- H1 (Rain): When it rains, the number of bikers will be significantly lower than on dry days.

- H2 (Rain + Wind): When it is windy (wind speed > 7 m/s) and raining, the number of bikers will be lower than on calm, dry (no wind, no rain) days.

- H3 (Heat Stress): In strong UTCI-based heat stress conditions (UTCI ≥ 32°C), biking counts will be significantly lower than on moderate (26°C ≤ UTCI < 32°C) UTCI conditions.

- H4 (Cold Stress): In strong UTCI-based cold stress conditions (UTCI < -13°C), biking counts will be significantly lower than moderate (-13°C < UTCI ≤ 0°C) UTCI conditions

- H5: Bike ridership (counts) will be significantly lower on no-green streets compared to green spaces.

- H6: On slight or higher thermal discomfort days (based on UTCI), bike ridership will be significantly higher in shaded routes than non-shaded routes.

- H7: At green stations the negative effect of heat stress will be lower than no-green ones.

# Methodology

The proposed methodology to assess bike ridership requires the compilation of various data, including environmental, urban, and automatic bike counter datasets, and the processing of these data using thermal comfort, vegetation classification, spatial analysis, and prediction models. For the automatic bike counter data, considering the missing values due to equipment outages or malfunctions, the methodology also checks and imputes missing data at existing counter locations using the temporal count prediction model described in section 2.5.1. Additionally, considering that it may not be possible to install bike counters in all areas of interest, the methodology includes a new station count prediction model to estimate bike counts at locations without counters using data from nearby similar stations described in section 2.5.2. The data gathered, the methods used, and the indicators generated for this study are presented in Figure 1 and a description of indicators is given in Appendix Table A.1, with more detailed explanations in sections 2.1 to 2.7, and Figure 2 shows the full methodology described in the following sections.


Figure 1: Raw data inputs, processing tools and methods, and output indicators for the bike ridership analysis methodology (at 1 hour resolution).

The data compilation and processing tools & methods generated 20 indicators, as shown in Figure 1, with their description given in Appendix Table A.1.


Figure 2: Methodology Flowchart with data processed at 1 hour resolution

## Data compilation

### Bike counter data

Automated bike counting stations employ various detection technologies that include inductive loop detectors, passive infrared sensors, and pneumatic tubes [14,23,24]. Inductive loop detectors are most commonly used; they work by sensing changes in the electromagnetic field caused by the metal frame of a bike passing over the inductive loop [14]. Passive infrared sensors detect heat signatures from moving objects, such as the body heat of bikers [23]. Pneumatic tubes measure air pressure changes from tire compression as bikes roll over them [24]. Bike count data are available at different resolutions – 15 minutes to 1 hour, sometimes the data include speed [25].

### Urban Data

High spatial resolution datasets, including a Digital Elevation Model (DEM) and Digital Terrain Model (DTM), provide the topographic baseline for the study area. Morphological parameters such as Sky View Factor (SVF), building and vegetation layers, wall heights, and wall aspects are derived from DEM and DTM to characterize urban geometry. Additionally, 360-degree panorama images are captured at each counter location.

### Environmental Data

Needed meteorological variables including air temperature (Ta), relative humidity (RH), wind speed (v), and air pressure, which should be sourced at hourly resolution to evaluate micrometeorological conditions. Detailed solar radiation components—Global Horizontal Irradiance (GHI), Direct Horizontal Irradiance (DHI), and Diffuse Normal Irradiance (DNI) are required to compute thermal comfort.

## Computing Bike Count

Biking data from 2.1.1 are processed by temporally aggregating bike counts to hourly resolution and classifying data based on month, day of year, type of day (weekdays/weekends) and distinguishing holiday days as shown in Appendix Table A.1.

## Computing Urban Indicators

### Building Density at 125m

Building densities are computed using a 125m × 125m buffer—a resolution representative for characterizing urban environmental neighborhoods [26]. Building Density 125m is defined as the ratio of the total building layer’s surface area (obtained in section 2.1.2) to the total area of the 125 m × 125 m buffer (=15,625 m2).

### Green View Index (GVI)

360-degree panorama images as described in section 2.1.2 are captured at every bike counter location and are inputted into the Xception deep learning image segmentation model [27,28], to compute the Green View Index (GVI), a metric measuring the percentage of visible green vegetation pixels in each image. Then GVI is computed using the modified GVI calculation formula from Li et al. [29] as shown below:

GVI=i=16j=13Areagiji=16j=13Areatij×100#1

where i = 1, …, 6 denotes the six horizontal viewing directions; j = 1, 2, 3 denotes the three vertical view angles (-45°, 0°, +45°); Areag,ij is the number of green vegetation pixels (trees, grass, and plants) classified in image (i, j); and Areat,ij is the total number of pixels in that image, giving 18 images per counter location in total. Bike counter locations with GVI values >10% are classified as "Green," else "No-Green". GVI is computed separately from summer and winter panoramic images at each station. Summer GVI (captured in May 2025) is used for further analysis; winter GVI (captured in Dec 2024) is retained for comparison.

### Distance From Center

- For each bike counter, the Euclidean distance is measured from the city center using a geospatial processing tool available in Quantum Geographic Information System (QGIS).

### Road Type

Road Type is a five-category variable that distinguishes the city's road network [30]: (1) Central Transit Corridor, (2) Highway, (3) Local Access Road, (4) Outer Urban Ring, (5) Peripheral Connector Road.

### Directionality

- Directionality is defined as a categorical variable representing the lane coverage of each bike counter. Based on visual inspection of counter locations [30], counters measuring bike flow on a single bike lane are classified as unidirectional (“mono”), whereas counters measuring flow on both sides of the roadway are classified as bidirectional (“bi”).

## Computing Environmental Indicators

Using urban data from 2.1.2 and environmental and meteorological data from 2.1.3, thermal comfort and weather comfort indicators are computed.

The methodology implements the Solar and LongWave Environmental Irradiance Geometry (SOLWEIG) model [31] to compute the mean radiant temperature (Tmrt), which represents the integrated radiant temperature of surrounding surfaces. SOLWEIG requires urban geometry data from building and vegetation layers, Sky View Factor (SVF), wall height, and wall aspect ratio, and meteorological data in EnergyPlus Weather (EPW) format. Urban geometry data are processed from the urban data described in section 2.1.2 using tools within Urban Multi-scale Environmental Predictor (UMEP) [31], an integrated platform for urban climate modeling. Meteorological data (air temperature (Ta), relative humidity (RH), wind speed (v), and solar radiation), as described in section 2.1.3, are combined with solar radiation components (GHI, DNI, DHI) to prepare an EPW file as input for SOLWEIG. Using this EPW file together with high-resolution urban geometry inputs (building and vegetation layers, DSM, DTM), SOLWEIG simulates Tmrt across the study area using Höppe et al. [32] formula for Tmrt computation as:

Tmrt = Sstr(εpσ)1/4-273.15#2

where Tmrt is mean radiant temperature (°C), Sstr is the mean radiant flux density (W m⁻²), representing the sum of all short and longwave radiation fluxes from six directions (up, down, and four cardinal directions) weighted by angular view factors to the person; εp is the emissivity of the human body (standard value 0.97); σ is the Stefan-Boltzmann constant (5.67×10–8 Wm-2 K-4 ).

Tmrt, Ta, RH, and v are then used to compute Universal Thermal Climate Index (UTCI) on a 25-m resolution grid in the vicinity of each bike counter, using the multi-node thermoregulatory model Blazejczyk et al. [22] through the pythermalcomfort python package [33] as follows:

UTCI=fTa;Tmrt;v;vp=Ta+OffsetTa;Tmrt;v;vp#3

where UTCI is expressed in equivalent temperature (°C); Ta is air temperature (°C); Tmrt is mean radiant temperature (°C); v is wind speed at 10 m height (m s⁻¹); vp is vapour pressure (hPa); and Offset represents the dynamic physiological response of a standing person based on a multi-node human energy balance and thermoregulation model, calculated from the combined effects of all input parameters. Vapor pressure (vp) is derived internally from Ta and RH using standard psychrometric conversion formula implemented in the pythermalcomfort package [33].

Strong heat stress is defined as UTCI > 32°C, moderate heat stress as 26°C < UTCI ≤ 32°C, strong cold stress as UTCI < -13°C, and moderate cold stress as -13°C < UTCI ≤ 0°C, based on standard UTCI classifications [22]. In this study strong heat stress is referred to as hot, and strong cold stress is referred to as cold, moderate cold stress and moderate heat stress are referred as moderate.

Shading, rainfall, and wind conditions are represented using categorical indicators. Shading effects on bike ridership is derived from the shadow output of SOLWEIG [31], which is used to characterize solar exposure at each counter location. In this paper it is referred to as shade indicator (1 = shade; 0 = unshaded). Rain is treated as a categorical indicator, with each hour classified as rain or non-rain according to an hourly precipitation threshold (rain > 0.01 mm/h). Wind conditions are also represented categorically, with hours classified as wind or no-wind based on hourly wind speeds exceeding 7 m/s. Rain and wind conditions together are represented with categorical variable (rain_wind), having four distinct levels: no wind no-rain, wind with no-rain, no-wind and rain, and wind and rain.

## Prediction Models

Two prediction models are developed: one for filling the missing data (for periods < 6 hours) using historic data, and another for predicting counts at locations without bike counters.

### Temporal Count Prediction Model

A multi-linear regression model is trained using historic data to predict and fill missing counts. The model is fitted by weighted regression (weights = log(fit + 1)) with iterative outlier removal (five iterations; |residual| > 1). Counts with more than six consecutive zeros (i.e., no counts are measured for at least 6 hours) are considered station outages and treated as missing data.  To evaluate the incremental benefit of adding meteorological data, three model configurations are prepared. The indicators used in the three model configurations, each trained per station (i) and hour (t), are: temporal features only (Day of Year, IsWeekend, Month, Holiday) for Model 1, which is used as the baseline for imputing missing counts. City-averaged uniform meteorological variables (Ta, RH, v, Tmrt, UTCI, Rain, Hot, Cold) are then added for Model 2. For Model 3, station-specific micrometeorological variables are used, as detailed in the model formulations below:

Model 1: Multi-linear Regression model used as baseline with no-meteorological data

logCounti,t+1=β0+β1·DayofYeari,t+β2·IsWeekendi,t+β3·Holidayi,t+

β4·Monthi,t+εt#4

Model 2: Multi-linear Regression baseline model with city-averaged meteorological data

logCounti,t+1 = β0+β1·DayofYeart+β2·IsWeekendt+β3·Holidayt+

β4·Montht+β5·Tat+β6·RHt+β7·Windt+β8·Tmrtt+β9·UTCIt+β10·Raint +

β12·Hott+β13·Coldt+εt#5

Model 3: Multi-linear Regression baseline model with micro-meteorological data

logCounti,t+1=β0+β1·DayofYeart+β2·IsWeekendt+β3·Holidayt+

β4·Montht+β5·Tai,t+β6·RHi,t+β7·Windi,t+β8·Tmrti,t+β9·UTCIi,t+

β10·Raini,t+β11·Shadei,t+β12·Hoti,t+β13·Coldi,t+εt#6

where Counti,t is the hourly bike count at station i at hour t.

Temporal variables DayofYeart, IsWeekendt, Holidayt, Montht carry only subscript t because they are uniform across all stations at a given hour. Tat,RHt,Windt,Tmrtt,UTCIt,Raint,Hott

and Coldt (Model 2) are meteorological variables. Tai,t,RHi,t,Windi,t,Tmrti,t,UTCIi,t,Raini,t,

Shadei,t,Hoti,t and Coldi,t (Model 3) are the corresponding station-specific micrometeorological variables.β0 is the intercept, β1 to β13 are their respective coefficients, and εt is the error term.


### New Station Count Prediction Model

A new station count prediction model is prepared for estimating counts at locations where a counting station is unavailable. This is a random forest model that uses the 20 indicators (shown in figure 1) for training (excluding Day of Year because Month, Hour, IsWeekend, and Holiday together provide sufficient seasonal and diurnal context for cross-station generalization).

The urban indicators - distance from center, summer GVI and Building Density at 125m, were selected for clustering because they are readily computable for any city, making the approach transferable. These three urban indicators are standardized (z-scored) to ensure equal contribution despite different units & ranges and then subjected to Principal Component Analysis (PCA) to reduce dimensional redundancy and improve clustering interpretability. PC1–PC2 scores from the PCA are then used for k-means clustering. The total number of bike counting stations are divided into clusters to make groups of similar urban typologies, that can help predict data for any new location that are within the cluster. The optimal number of clusters is determined using silhouette analysis [34]; and the highest silhouette score is used to conclude the total number of clusters for a given city.

Random forest model is preferred over multi-linear regression because it automatically handles non-linear relationships and multicollinearity without requiring manual variable selection or transformation, allowing all 20 indicators to be used effectively.

To predict data for a new location without local historical data, the following procedure is implemented: First, the temporal bike ridership pattern is derived from stations within the same cluster by training on the volume profile (hourly count divided by station mean). A cross-validation strategy is implemented where the model for each location is trained by completely excluding that specific station from the entire training set, ensuring predictions are generalized purely based on other stations within cluster. To prevent data leakage, feature scaling, PCA, and k-means clustering are repeated entirely within each leave-one-station-out (LOSO) [35] training fold (Table 3).

Then, this learned normalized pattern is multiplied by the mean annual count of neighboring stations within the same cluster, used as a proxy for the new location's expected volume. Final predictions are thus computed as: Predicted Count = Volume Profile × Cluster Mean Annual Count.

To evaluate the incremental benefit of adding meteorological data, three model configurations are prepared, for which the indicators include - temporal and urban features only (Hour, Day of Year, IsWeekend, Month, Holiday, Distance From Center, Road Type, Directionality, Building Density 125m, summer GVI) for Model 4; to which are then added city- averaged uniform meteorological variables (Ta, RH, Wind, Tmrt, UTCI, Rain, Hot, Cold, Shade) for Model 5; or local station specific values of the same meteorological variables for Model 6, as formulated below:

Model 4: New station count prediction model with no meteorological data

Counti,t =f(Montht,Hourt,IsWeekendt,Holidayt,DistanceFromCenteri,RoadTypei,

Directionalityi, BuildingDensity125mi,GVIi)+εi,t#7

Model 5: New station count prediction model with city-averaged meteorological data

Counti,t=f(Montht,Hourt,Holidayt, IsWeekendt, Tat, RHt, Windt, Tmrtt, UTCIt,

Rain_t, Hott, Coldt,DistanceFromCenteri,RoadTypei,Directionalityi,

BuildingDensity125mi,GVIi)+εi,t#8

Model 6: New station count prediction model with location-specific meteorological data

Counti,t=f(Montht,Hourt,Holidayt, IsWeekendt, Tai,t, RHi,t, Windt, Tmrti,t, UTCIi,t,

Raini,t,Hoti,t, Coldi,t,Shadei,t,DistanceFromCenteri,RoadTypei,Directionalityi

BuildingDensity125mi,GVIi)+εi,t#9

where Counti,t is the predicted bike count produced by Volume Profile × Cluster Mean Annual Count, at location i at hour t.

f is the Random Forest ensemble function; temporal indicators Montht, Hourt, IsWeekendt, Holidayt; urban indicators DistanceFromCenteri,RoadTypei,Directionalityi,

BuildingDensity125mi,GVIi; (Model 5) meteorological variables are Tat,RHt,Windt,Tmrtt,

UTCIt,Raint,Hott, and Coldt; (Model 6) micro-meteorological variables are; Tai,t,RHi,t,Windi,t,Tmrti,t,UTCIi,t,Raini,t,Shadei,t, Hoti,t and Coldi,t;

and εi, t is the prediction error.

## Statistical analysis

Bike ridership is evaluated using a mixed-effects model to estimate both fixed effects of the environmental exposures and random station effects that account for repeated observations within counters. A negative-binomial type-2 (NB2) specification is selected because hourly counts are over-dispersed (variance exceeding the mean); its quadratic mean–variance relationship can handle this overdispersion [36]. Hourly counts at the same station are often similar from one hour to another, for this an AR(1) working correlation is specified for consecutive hours at each station on the same day [37]. A NB2 model is fitted for each hypothesis per quarter.

The association between each environmental condition (rain, wind, heat, cold, greenness, shade) and bike counts is reported as a Incident Rate Ratio (IRR) derived from estimated marginal means with proportional covariate weighting. The corresponding coefficient β is exponentiated, IRR = exp(β). IRR < 1 indicates lower expected counts; IRR > 1 indicates higher expected counts. Percentage change is 100 × (IRR − 1), with 95% Wald confidence intervals derived on the log scale and exponentiated. P-values are adjusted across the 28 planned comparisons using the Holm procedure [38].

For winter (Q1 and Q4) and for summer (Q2 and Q3), models are fitted as below:

| Count ~ rain_wind + cold + Green + Shade + Hour + Year +  (1 \| station) + ar1hour+0∣station-day | (10) |
| --- | --- |
| Count∼rain_wind+hot×Green+Shade+Hour+Year+1∣station +ar1hour+0∣station-day | (11) |

where Count is the observed hourly bike count; rain_wind, Hot, Cold, Green and Shade are defined in sections 2.2 and 2.4; Hour and Year are temporal controls; 1∣station is the station-level random intercept Stationi∼N0,σb2;FeatureID; and the AR(1) term models consecutive hours within each station-day. If an AR(1) fit encounters convergence failure or a non-positive-definite Hessian, the model defaults to the station random-intercept specification (1 \mid Station_i). To evaluate the unconfounded rain main effect (H1), an additive specification (rain + windy) is fitted in place of rain_wind.

Sensitivity analyses evaluate continuous exposure models for rain, wind, UTCI, and summer GVI, fine-grained threshold grids across environmental cut-offs (evaluated at 0.1 mm/h intervals for rain, 0.5 m/s for wind, 0.5 °C for UTCI, and 5% for GVI), and seasonal comparisons between summer and winter GVI.

Model performance is evaluated separately from the NB2 analysis, on the original bike-count scale, using the coefficient of determination (R²), Root Mean Square Error (RMSE), Mean Absolute Error (MAE), symmetric Mean Absolute Percentage Error (sMAPE), and Bias, obtained through cross-validation [35,39–41] as shown in equations below.

Here at is the observed count, pt is the predicted count (bikes/hour), ā is the mean of the observed counts, and n is the number of out-of-sample hours.

R2=1-tat-pt2tat-a2#12

RMSE=1ntat-pt2#13


| MAE=1nt=1nat-pt#14 | (14) |
| --- | --- |
| sMAPE=100nt=1n2at-ptat+pt,at+pt>00,at+pt=0#15 | (15) |
| Bias=1nt=1npt-at #16 | (16) |

where at is the observed bike count on the original count scale, pt is the predicted bike count (bikes/hour) after conversion from the log-scale fit, ā is the mean of the observed counts, n is the number of out-of-sample hours, and t indexes those hours; sMAPE is set to 0 when both at and pt are zero.

Linear models were fitted on log(Count + 1); predictions were back-transformed as pt=max0,expŷt-1 before metrics were computed. RF predictions were likewise converted back to counts. For the new-station model, performance under the excluded-station cross-validation is also compared with baselines (city-hour mean, cluster-hour mean, and geographic nearest-station hour mean).

## Case Study BCR

The proposed methodology (sections 2.1–2.6) was applied to the case study of BCR for the years 2022–24.

Datasets mentioned in section 2.1.3, were sourced from the Royal Meteorological Institute of Belgium (RMI) [42], European Centre for Medium-Range Weather Forecasts (ECMWF) Reanalysis v5 (ERA5) [43], and Copernicus Atmosphere Monitoring Service (CAMS) [44].  RMI data was retrieved for weather station location in BCR, CAMS was retrieved at 0.4° resolution and ERA5 at 31 km resolution. The parameters collected from RMI included air temperature, relative humidity, air pressure, wind speed, wind direction, and rain; parameters from CAMS included hourly solar radiation components—global horizontal irradiance (GHI), direct normal irradiance (DNI), and diffuse horizontal irradiance (DHI), parameters from ERA5 included snow depth and total cloud cover in NetCDF format. These datasets were processed and aggregated to hourly resolution for consistency. Urban spatial data (DEM, DTM, and land cover) were obtained from the BCR Urban Information System (UrbIS) [30] at 0.5 m resolution; all these datasets were resampled to 25 m prior to SOLWEIG simulation (section 2.4).

Bike count data were collected at 15-minute intervals and processed to 1-hour. Holidays were marked for Flanders and Brussels (two provinces of Belgium that were in proximity to BCR) [45,46].

Using these data, all indicators listed in Figure 1 were computed for each of the 18 bike counting stations, as illustrated on the map in Figure 3. Each counter was documented using the 360 panorama images shown in Figure 4 and an image of bike counter as shown in Figure 5. The statistical analysis described in section 2.6 were then used for testing of hypothesis H1–H7, with a focus on weekend bike ridership. For relative change and IRR estimation, bike counts are analyzed using only the weekend daytime hours (9–16h) across the entire study period (2022-2024).


Figure 3: Map showing locations of the 18 counting stations





Figure 4: 360 panorama images for the 18 counting stations


Figure 5: Bike counter photo with tubes embedded in road

# Results

## Role of environmental characteristics in bike ridership

Bike ridership in the BCR was examined across all four quarters (Q1 to Q4) of the year 2022 to 2024, with each quarter representing a three-month period. Q1 – January to March, Q2 – April to June, Q3 – July to September and Q4 – October to December. Focusing only on weekend biking (weekend), the hypotheses 1 to 7 (H1 to H7) were tested using statistical analysis as described in section 2.6, with results shown in Figure 6. Effects are reported as incidence rate ratios (IRR) with 95% confidence intervals and Holm-adjusted p-values (Table 1):

### H1 - Impact of Rainfall on Bike ridership

Rain is analyzed as a binary variable (rain vs. no-rain) to isolate its independent effect from wind interactions. As shown in Figure 6(a), across all four quarters, average bike counts were significantly lower during rain compared to no-rain. On rain days, the reduction was most prominent during midday in Q2, with a noticeable flattening of the peak, indicating a drop of approximately 25%. Statistical analysis shows rain significantly reduces bike counts across all four quarters after Holm adjustment in Q1 (−7.40%), Q2 (−11.64%), Q3 (−15.38%), and Q4 (−14.20%) (as reported in Table 1).

### H2 - Influence of Rain and Wind on Bike ridership

As shown in Figure 6(b), on dry days, strong wind reduces biking activity across all quarters, with notably declining late-morning peaks in Q2 and Q3. On rainy days, the combined effect of rain and wind further suppresses bike ridership. Statistical analysis shows combined rain and wind significantly reduces bike counts after Holm adjustment Q1 (−12.27%) and Q4 (−16.15%), while Q3 (−2.18%) was not statistically significant, and Q2 was unsupported due to insufficient concurrent conditions (as reported in Table 1).

### H3 - Influence of Heat Stress on Bike ridership

As shown in Figure 6(c), a slight decrease in bike counts was observed during peak heat hours (12–14h). In Q2 and Q3, the difference between “hot” and “moderate” days was marginal. Statistical analysis shows heat stress reduces bike counts modestly in Q2 (−3.35%) and Q3 (−3.66%). Q3 was significant prior to adjustment but didn’t reach statistical significance after Holm adjustment, and Q2 was not statistically significant. Q1 and Q4 were excluded as no hot days were recorded (as mentioned in Table 1).

### H4 - Influence of Cold Stress on Bike ridership

As shown in Figure 6(d), during “cold” days, the peak volumes of bike ridership remained lower than on “moderate” days. Statistical analysis shows cold stress reduces bike counts in Q1 (−6.19%) and Q4 (−8.49%), both remaining statistically significant after Holm adjustment, while Q2 and Q3 had no cold days (as reported in Table 1).

### H5 - Effect of Summer GVI on Bike ridership

As shown in Figure 6(e), bike counts along stations classified as “green” were marginally higher than those in “no-green” areas across all quarters. Statistical analysis shows stations classified as green with summer GVI exhibited non-significant count differences after Holm adjustment, relative to no-green stations Q1 (−5.45%), Q2 (+6.12%), Q3 (+8.02%), and Q4 (−6.23%) with wide confidence intervals (as reported in Table 1).

### H6 - Effect of Shade (Urban Morphology) on Bike Ridership

As shown in Figure 6(f), the shade contrast under strong heat conditions was not sufficiently supported by the available data. In Q2, no Shade=1 observations were available, so the contrast was not estimated. In Q3, only five Shade=1 observations were available; the resulting point estimate of +15.91% was treated as insufficiently supported and was not interpreted as evidence of a shade effect, while Q1 and Q4 had no hot days (as reported in Table 1).

### H7 - Combined Effect of Summer GVI and Heat Stress

As shown in Figure 6(g), bike ridership in green was slightly higher as compared to non-green biking routes during hot conditions. Statistical analysis shows the combined effect of summer GVI and heat stress are non-significant in Q2 (−5.53%) and Q3 (+2.11%) after Holm adjustment. Q1 and Q4 were excluded as they recorded no hot days (as mentioned in Table 1).



Figure 6: Mean diurnal biking count profiles (represented by lines) across seasonal quarters (Q1–Q4) comparing average hourly behavioral responses to urban and environmental stressors. Each row illustrates the comparative usage: Row 1 (a) no-rain (orange) vs. rain (yellow) days; Row 2 (b) calm (light blue) vs. wind (blue) days; Row 3 (c) “moderate” (light red) vs. “hot” (red) conditions; Row 4 (d) “moderate” (light blue) vs. “cold” (dark blue) conditions; Row 5 (e) “green” (light green) vs. “no-green” (dark green) station areas; Row 6 (f) shaded (black) vs. unshaded (grey). And hot Row 7 (g) green (light green) vs. no-green (dark green) bike routes.

Table 1: Percentage Change in Bike ridership

| Sr. | N exp | N Ref | Rate_ratio | Change% | AR1 alpha | P value | P Holm adjusted |
| --- | --- | --- | --- | --- | --- | --- | --- |
| H1 (Q1) | 3877 | 7211 | 0.93 ( 0.91 - 0.95) | -7.40 | 0.96 | <0.001 | <0.001 |
| H1 (Q2) | 2473 | 8759 | 0.88 ( 0.86 - 0.91) | -11.64 | 0.95 | <0.001 | <0.001 |
| H1 (Q3) | 2449 | 8927 | 0.85 ( 0.82 - 0.87) | -15.38 | 0.99 | <0.001 | <0.001 |
| H1 (Q4) | 4230 | 7290 | 0.86 ( 0.84 - 0.87) | -14.20 | 0.96 | <0.001 | <0.001 |
| H2 (Q1) | 958 | 6900 | 0.88 ( 0.85 - 0.91) | -12.27 | 0.96 | <0.001 | <0.001 |
| H2 (Q2) | 6 | 8427 | Insufficient data |  | 0.95 |  |  |
| H2 (Q3) | 162 | 8891 | 0.98 ( 0.93 - 1.02) | -2.18 | 0.99 | 0.35 | 1.00 |
| H2 (Q4) | 846 | 6759 | 0.84 ( 0.81 - 0.86) | -16.15 | 0.96 | <0.001 | <0.001 |
| H3 (Q1) |  |  | No hot days |  |  |  |  |
| H3 (Q2) | 233 | 1053 | 0.97 ( 0.93 - 1.01) | -3.35 | 0.87 | 0.13 | 1.00 |
| H3 (Q3) | 555 | 2195 | 0.96 ( 0.93 - 1) | -3.66 | 0.99 | 0.02 | 0.47 |
| H3 (Q4) |  |  | No hot days |  |  |  |  |
| H4 (Q1) | 625 | 5091 | 0.94 ( 0.9 - 0.97) | -6.19 | 0.95 | <0.001 | 0.02 |
| H4 (Q2) |  |  | No cold days |  |  |  |  |
| H4 (Q3) |  |  | No cold days |  |  |  |  |
| H4 (Q4) | 340 | 4875 | 0.92 ( 0.87 - 0.96) | -8.49 | 0.89 | <0.001 | 0.01 |
| H5 (Q1) | 6160 | 4928 | 0.95 ( 0.5 - 1.78) | -5.45 | 0.96 | 0.86 | 1.00 |
| H5 (Q2) | 6240 | 4992 | 1.06 ( 0.56 - 2.01) | 6.12 | 0.95 | 0.86 | 1.00 |
| H5 (Q3) | 6320 | 5056 | 1.08 ( 0.58 - 2) | 8.02 | 0.99 | 0.81 | 1.00 |
| H5 (Q4) | 6400 | 5120 | 0.94 ( 0.49 - 1.78) | -6.23 | 0.96 | 0.84 | 1.00 |
| H6 (Q1) |  |  | No hot days |  |  |  |  |
| H6 (Q2) | 0 | 233 | Insufficient data |  |  |  |  |
| H6 (Q3) | 5 | 550 | 1.16 ( 0.96 - 1.4) | 15.91 | 1.00 | 0.12 |  |
| H6 (Q4) |  |  | No hot days |  |  |  |  |
| H7 (Q1) |  |  | No hot days |  |  |  |  |
| H7 (Q2) | 71 | 162 | 0.94 ( 0.84 - 1.06) | -5.53 | 0.95 | 0.33 | 1.00 |
| H7 (Q3) | 210 | 345 | 1.02 ( 0.96 - 1.09) | 2.11 | 0.99 | 0.51 | 1.00 |
| H7 (Q4) |  |  | No hot days |  |  |  |  |


### Sensitivity Analysis

Summer GVI is the primary greenness classifier (Table 1). Substituting winter GVI for the H5 and H7 green/no-green (and Green×heat) contrast flipped only CJM90 as No-Green (17 of 18 stations unchanged). Under that alternative, green stations exhibited non-significant count differences relative to no-green stations in Q1 (−42.64%), Q2 (−34.26%), Q3 (−33.18%), and Q4 (−42.89%), with wide confidence intervals spanning values below and above unity; H7 was not significant after Holm in Q2 (−7.85%) and Q3 (+0.78%). Sensitivity analysis is shown in Appendix Table A.4.

## Data completion with the temporal count prediction model

The temporal count prediction (from 2.5.1) model 1 was used to fill station outage gaps (defined as 0 counts for more than 6 consecutive hours). The station-level information of filled data counts is provided in Appendix Table A.2. Data gaps represented only 1.09% of the total study period (2022-24) across all 18 stations. Since the missing data was about 1%, sensitivity models excluding imputed records were used and they confirmed that primary NB2 estimates were unaffected. Contiguous block-masking simulations (3–72 h) confirmed stable recovery on the original count scale. The temporal model was only used to fill missing data gaps, no other changes were made in data.

Model performance for temporal count prediction model was evaluated using out-of-sample testing across three configurations — Model 1 (no-meteorology), Model 2 (meteorology), and Model 3 (micro-meteorology), where each model was trained on historical data for both weekday and weekend for years 2022 and 2023, and tested against real observed (non-missing) counts from 2024. Table 2 summarizes the predictive performance for each model configuration on original count scale across all stations.

Table 2: Station-wise results for 2024 at 18 BCR bike-counting stations with the temporal count prediction model 1, 2 and 3.

| FeatureID | R2 no-meteo | R2 meteo | R2 micro-meteo | RMSE no-meteo bikes/hour | RMSE meteo bikes/hour | RMSE micro-meteo bikes/hour |
| --- | --- | --- | --- | --- | --- | --- |
| CAT17 | 0.85 | 0.85 | 0.89 | 27.58 | 26.88 | 23.92 |
| CB02411 | 0.88 | 0.88 | 0.90 | 43.21 | 42.41 | 38.76 |
| CB1101 | 0.84 | 0.84 | 0.84 | 63.37 | 63.12 | 62.20 |
| CB1142 | 0.83 | 0.83 | 0.84 | 46.98 | 46.91 | 45.73 |
| CB1143 | 0.90 | 0.90 | 0.91 | 43.48 | 42.81 | 40.48 |
| CB1599 | 0.87 | 0.87 | 0.90 | 13.44 | 13.13 | 11.87 |
| CB1699 | 0.87 | 0.87 | 0.89 | 11.98 | 11.76 | 10.83 |
| CB2105 | 0.83 | 0.83 | 0.84 | 25.93 | 25.65 | 24.49 |
| CEE016 | 0.89 | 0.90 | 0.92 | 18.84 | 18.33 | 16.76 |
| CEK049 | 0.91 | 0.91 | 0.93 | 23.95 | 23.41 | 21.05 |
| CEK18 | 0.78 | 0.78 | 0.79 | 35.60 | 35.57 | 34.91 |
| CEK31 | 0.91 | 0.91 | 0.93 | 28.35 | 27.82 | 25.93 |
| CEV011 | 0.88 | 0.88 | 0.89 | 11.00 | 10.86 | 10.34 |
| CJE181 | 0.80 | 0.81 | 0.83 | 5.64 | 5.58 | 5.32 |
| CJM90 | 0.92 | 0.93 | 0.94 | 45.58 | 44.26 | 40.11 |
| CLW239 | 0.83 | 0.83 | 0.86 | 11.31 | 11.09 | 10.12 |
| COM205 | 0.73 | 0.74 | 0.76 | 24.21 | 23.90 | 22.62 |
| CVT387 | 0.85 | 0.85 | 0.87 | 9.89 | 9.74 | 9.15 |
| Average | 0.85 | 0.86 | 0.87 | 27.24 | 26.85 | 25.25 |


The baseline model (Model 1), using only temporal features, achieved an overall R² = 0.85 and RMSE = 27.24 bikes/hour. Adding meteorological variables (Model 2) improved overall performance to R² = 0.86 and RMSE = 26.85 bikes/hour. The further inclusion of micro-meteorological data (Model 3) improved performance to R² = 0.87 and RMSE = 25.25 bikes/hour. The highest R² values with micro-meteorological data were recorded at CJM90 (R²=0.94 | RMSE = 40.1 bikes/hour), while the lowest were at COM205 (R²=0.76 | RMSE=22.6 bikes/hour), shown in Appendix Figure A.1. Since Model 1 provides strong generalizability without requiring meteorological inputs, it is used as the imputation model for missing data.

## New station count prediction model

The new station count prediction model was not used to generate data for H1-H7 hypothesis testing; it is presented as a separate prediction application for estimating counts at unmonitored locations. The optimal number of clusters required for new station count prediction model was determined using silhouette analysis (as shown in Appendix Figure A.2), which measures cluster cohesion and separation. Clusters k = 4 achieved the highest silhouette score (0.58) compared to k=2 to k=10. Although silhouette scores for k=2–4 are comparable (0.47, 0.57, and 0.58 respectively), k=4 was selected because scores decline consistently from k=5 onward, and because the four-cluster solution yields the most interpretable grouping of station typologies. The indicators distance from center, summer GVI, Building Density at 125m were standardized (z-scored) to ensure equal contribution despite different units and ranges, and subjected to PCA; PC1–PC2 (which together explained 84.6% of the total variance, with PC1 at 55.8% and PC2 at 28.8%) were clustered using k-means (k=4) as shown in Appendix Figure A.2, resulting in the 4 clusters as below:

1. Cluster 1 – CAT17, CB02411, CEK049, CEK31 (4 stations)

2. Cluster 2 – CJE181, CLW239, COM205 (3 stations)

3. Cluster 3 – CB1599, CB1699, CEE016, CEK18, CEV011, CVT387 (6 stations)

4. Cluster 4 – CB1101, CB1142, CB1143, CB2105, CJM90 (5 stations)

The benchmark ranges for each cluster, defining the characteristic ranges of distance from center, summer GVI, building density at 125m that identify each cluster are shown in Appendix Figure A.2 and Appendix Table A.3. Pairwise scatter plots of these three features, colored by cluster, are shown in Appendix Figure A.3, illustrating the separation and overlap structure in the original feature space. These are descriptive summaries in the original feature space; as clusters are defined by joint PC1-PC2 position, ranges overlap across clusters. Assignment for a new site should follow the decision tree (Figure 7).


Figure 7: Decision Tree for Cluster Assignment

The decision tree as shown in Figure 7, guides the cluster assignment process by comparing the new location’s local features - distance from center, building density 125m and summer GVI. Following this approach, cluster assignment (Clusters 1 to 4) can be performed for a new station, and thereafter, the new station count prediction model can be implemented.

Model performance for new station count prediction model was evaluated using 18-fold leave-one-station-out testing across the available 2022–2024 station-hour rows across three configurations — Model 4 (no-meteorology), Model 5 (city-averaged meteorology), and Model 6 (station-specific meteorology). The held-out station was excluded from training in each fold. Table 3 summarizes the predictive performance (R² and RMSE) for each model configuration across all stations.

Table 3: 18-fold leave-one-station-out results across the available 2022–2024 data at 18 BCR bike-counting stations with the new station count prediction model

| Model | MAE (95% CI) [bikes/h] | RMSE (95% CI) [bikes/h] | sMAPE (95% CI) [%] | Bias (95% CI) [bikes/h] | R² (95% CI) |
| --- | --- | --- | --- | --- | --- |
| City baseline | 55.05 (41.84–68.27) | 80.96 (60.84–101.08) | 84.64 (70.05–99.24)% | −0.05 (−26.71–26.62) | −2.773 (−6.944–1.397) |
| Cluster baseline | 42.69 (30.27–55.12) | 66.27 (46.90–85.63) | 67.70 (60.68–74.71)% | 0.88 (−15.74–17.49) | −0.069 (−0.622–0.485) |
| Geographic nearest station baseline | 63.66 (42.07–85.26) | 92.65 (65.74–119.56) | 84.73 (67.58–101.88)% | 6.91 (−28.27–42.10) | −16.540 (−49.154–16.075) |
| RF Model 4 (No-meteo) | 33.24 (21.29–45.18) | 53.16 (35.75–70.57) | 58.46 (51.09–65.83)% | −9.79 (−26.35–6.77) | 0.305 (−0.091–0.702) |
| RF Model 5 (Meteo) | 34.20 (22.17–46.24) | 55.08 (37.39–72.76) | 60.15 (53.18–67.12)% | −9.70 (−26.25–6.85) | 0.244 (−0.193–0.682) |
| RF Model 6 (Micro-meteo) | 33.12 (21.47–44.78) | 53.52 (36.41–70.63) | 58.07 (50.19–65.94)% | −8.99 (−25.55–7.58) | 0.258 (−0.224–0.740) |


The highest R² values with micro-meteorological data were recorded at CLW239 (R²=0.85 | RMSE=11.45 bikes/hour), while the lowest were at CJE181 (R²=-3.97 | RMSE=28.43 bikes/hour), shown in Appendix Figure A.4.

Compared with the city-hour baseline (RMSE =91.57 bikes/hour), Model 4 had RMSE = 64.94 bikes/hour, Model 5 had RMSE = 65.71 bikes/hour, and Model 6 RMSE = 60.96 bikes/hour.

### Observations from new station count prediction model

Station-level individual patterns: CB2105 (Cluster 4, near city center at distance 1137 m) showed lower cross-station fit in the new station count prediction model with micro-meteorological data (R² = 0.61). This is due to proximity to railway station and transport hub [47], where a large share of trips terminate at rail, metro, tram, and bus connections rather than continuing by bike, depressing observed counts relative to cluster peers and leading to over-prediction. CJE181 (R² = 0.65, Cluster 1, northwestern periphery at 5,140 m from center, mean 13.8 bikes/hr) records persistently low counts due to its location in a low-density municipality, with its surroundings include the expositions and cultural institutions, neither of which generate regular bike ridership, leading cluster peers in more urbanized neighborhoods to systematically overpredict this station [48]. CJM90 (R² = 0.57, Cluster 4, 1,143 m from center, mean 194.2 bikes/hr) is located near a river, which is a public attraction. This bike path broke 1 million count record, and displays the highest mean count in the network, driven by mixed commuter and recreational flows [49]. Cluster peers with more typical bike ridership therefore systematically underpredict at this high-volume location.

Morning and evening peaks: The model tended to underestimate afternoon return peaks at CAT17 (local access road, 4597 m from center, R² = 0.69) and CB1101 (outer urban ring, 1139 m, R² = 0.80). At profile level, CEK18 showed lower-than-expected evening peaks, while CB1143, CEE016, and CJM90 showed evening peaks higher than morning peaks. It was observed that multiple route alternatives redistribute bikers away from counters and is not represented by current station-level predictors, which contributes lower bike counts for CAT17.

Station-level disruptions: The proportion of missing data on average per station was 1.09% for the 3 year study period (2022-24), individually CVT387 recorded 53.6% zero counts in September 2024 (vs typical 5–15%), with zero counts in February 2024 (19.6%) and October 2022 (21%), due to temporary closure or counter malfunction. CB1143 experienced a prolonged shutdown (73% zeros in July 2024, 100% in August, 72% in September) linked to road works. These periods led to uncaptured bike ridership, which resulted in underprediction of bike counts.

# Discussion

The presented methodology leverages bike count data—now increasingly available across cities—together with high-resolution micro-meteorological and urban data to examine how bike ridership varies in relation to environmental comfort conditions. Temporal indicators capturing diurnal, weekly, and seasonal patterns, as well as holiday-related effects, are jointly encoded with environmental and urban variables. This integrated methodology enables the construction of interactive statistical analyses that support both visual and quantitative assessment of the environmental comfort factors governing bike ridership.

## Case study BCR

In the BCR, periods characterized by combined rain and wind are associated with sharp declines in biking activity, potentially due to increased surface splashing, slip risk, and reduced visibility at exposed intersections. This sensitivity to adverse weather is likely reinforced by urban and environmental context: the predominantly deciduous street canopy results in reduced shelter following leaf fall, increasing exposure to rain and wind. While leaf loss does increase solar access during winter, this benefit is limited in practice by Brussels' characteristically overcast skies, which average fewer than two sunshine hours per day in December and January. Local infrastructure characteristics—such as open junctions and limited drainage—further exacerbate these conditions. Together, these factors may compound bikers’ vulnerability during rain and wind periods.

Thermal stress shows asymmetric associations with bike ridership. Cold conditions are associated with broader and more persistent reductions in bike use, whereas warmer conditions correspond to increased biking activity, indicating that cold–rain conditions may represent a stronger constraint on sustained biking. Statistical analysis showed that greenness contrasts had wide confidence intervals. While greenery may enhance route appeal, its independent effect on bike ridership is secondary to dominant thermal and weather-related constraints.

These findings indicate that, within the BCR, cold and rain conditions represent a stronger constraint on sustained biking than warmer conditions. However, the relative importance of environmental stressors is likely to vary across climatic and sociocultural contexts. Further studies across diverse environments would help determine how these relationships change under different thermal and urban conditions.

## Temporal count prediction model and new station count prediction models

The temporal count prediction model demonstrated strong predictive performance, indicating its suitability for imputing missing bike count data, including cases where data gaps extended over prolonged periods. This supports the robustness of temporally informed approaches for maintaining continuity in urban biking datasets.

In contrast, the new-station prediction model performed lower (as reported in Table 2 and Table 3), mainly because predictions rely entirely on cross-station transfer — the target station's own historical count data is not used in training. By design, the model is trained solely on urban typology indicators and does not account for non-urban factors such as commuting patterns and the presence of key attractor points within the city. Furthermore, in the BCR case, the clustering resulted in groups containing only 3–6 stations, and the accuracy remained lower than that of the temporal model. This trade-off between spatial transferability and temporal count prediction model accuracy reflects a known limitation of cross-station transfer approaches with sparse station networks. Nevertheless, model 6 achieved an RMSE of 53.52 bikes/h, compared with 80.96 bikes/h for the city-hour baseline, represents that relies on purely cross-station transfer indicates the practical utility of the approach for estimating biking activity at unmonitored locations.

### Improvement in model performance with micrometeorological data

For the temporal count prediction model, adding meteorological data improved the fitted-series output by ΔR² = +0.004 and ΔRMSE = −0.39 bikes/hour over Model 1; adding micro-meteorological data improved it by ΔR² = +0.021 and ΔRMSE = −1.99 bikes/hour over Model 1. For the new-station count-prediction model, adding meteorological data increased LOSO RMSE by 1.92 bikes/hour (ΔMAE +0.96) relative to Model 4, whereas adding micro-meteorological data increased LOSO RMSE by 0.36 bikes/hour (ΔMAE −0.12). Mean R² was 0.305 in Model 4, 0.244 in Model 5, and 0.258 in Model 6, remaining positive in all three configurations.

The RMSE reduction observed in the new station count prediction model when using micro-meteorological data can be attributed to its reliance on cross-station transfer, as it does not use station-specific historical count data. In this context, incorporating micro-meteorological variables—particularly those capturing local exposure—introduces additional relevant information which enhance predictive performance. In contrast, the temporal count prediction model already captures strong station-specific temporal patterns through historical bike count data and associated temporal features. As a result, the incremental benefit of adding micro-meteorological data is comparatively smaller.

Based on literature, automated bike counters are well-calibrated, established instruments producing reliable hourly counts; a RMSE 2.99 bikes/hour reduction attributable to micro-meteorology represents a non-negligible benefit to bike ridership prediction. For city planners evaluating infrastructure investments or environmental comfort along bike corridors, this added precision can be useful in long-term decision making.

### Extension of clustering indicators with broader urban context

The three urban design characteristics used for clustering — distance from center, GVI, and Building Density at 125m — differentiate broad station typologies but do not account for the presence of key attractor points in a station's surroundings. Extending the clustering feature set to include such proximity-based indicators would improve both cluster quality and prediction accuracy

Stations adjacent to major transit interchanges serve predominantly as trip-termination points where a large share of bike trips end at public transport connections. Their bike ridership is governed by transit schedules rather than neighborhood typology, producing count volumes and diurnal profiles distinct from other stations.

Stations located near water bodies or large recreational green spaces attract bike ridership with a pronounced weekend component, differing structurally from stations with similar urban design characteristics situated in standard residential or commercial settings.

Two stations sharing comparable values of distance from center, Building Density at 125m, and summer GVI can therefore exhibit markedly different bike ridership solely by virtue of proximity to such key attractor points — a distinction the current clustering does not capture.

Including proximity to key attractor points as a clustering indicator would group stations by behavioral similarity more precisely, reducing within-cluster variation in biking activity and strengthening the cross-station transfer underlying the new station count prediction model.

This extension would require compilation of additional urban indicator datasets, increasing the initial data requirements — a trade-off between model informativeness and methodological transferability to be considered in future studies.

## Limitations of this study

### General limitations of the methodology:

- A further limitation of this study is the absence of explicit traffic dynamics, which also influence bike ridership. While bikers may benefit from increased relative mobility during peak vehicular congestion, higher traffic volumes can simultaneously intensify environmental stressors such as noise emissions, and air pollution, potentially offsetting these advantages. Future research could integrate traffic-related data (e.g., vehicle counts or congestion levels) to better assess how traffic exposure interacts with environmental comfort, and to support targeted interventions—such as traffic calming or protected biking infrastructure—in high-traffic areas.

- Elevation and slopes were not considered in this study.

- The current feature set also does not explicitly capture route-choice accessibility (e.g., number of alternative paths, network connectivity, and detour potential). This likely contributes to underestimation of morning and return peaks at stations where bikers can redistribute across nearby corridors.

- Wind exposure represents an additional methodological limitation. Although wind speed is included as a predictor based on available meteorological data, spatial variability in wind conditions is not explicitly modeled using Computational Fluid Dynamics (CFD). Wind exposure is therefore assumed to be uniform across the city, overlooking localized effects driven by urban morphology, building configurations, and topography. Future work could integrate microscale wind modeling approaches, such as computational fluid dynamics, to better capture street-level wind variability and identify wind-vulnerable corridors, thereby informing targeted design interventions to improve biking comfort under wind conditions.

- While imputing missing bike count data for sensor malfunctions or power outages is justified as traffic still occurs, gaps caused by temporary road blockages—such as maintenance works or diversion may render the location inaccessible. In such cases, traffic is often diverted to parallel routes rather than lost. Imputation model predicts the traffic that would have occurred if the road was not blocked. Road blockage or sensor malfunction are identical from the analysis perspective. making imputed values  potentially misleading. In this study models do not account for road works schedules, sensor malfunction and road divergence and data for all of these scenarios are imputed.

### Limitations specific to the case study of BCR:

- Bike count data is only available for 18 locations in BCR.

- While referred to as bike counters, these sensors record all soft mobility vehicles using biking infrastructure, including conventional and electric bikes, scooters, delivery bikes, and e-scooters. At present, it is not possible to distinguish between these vehicle types within the available data.

- The BCR study area is largely flat with low levels of slopes, resulting in a predominantly flat urban environment.

- GVI was measured during summer (May 2025) and winter (Dec 2024). Summer GVI was the primary classifier; winter GVI was used only for comparison.

# Conclusion

This paper introduced an integrated methodology that combines bike count data with high-resolution micro-meteorological and urban spatial information to assess how environmental comfort shapes bike ridership across time and space. Applied to the BCR, the approach demonstrates how temporally structured indicators and statistical analysis can be used to interpret both general patterns and context-specific responses to environmental conditions.

Using automated bike count data from 18 counting stations across the BCR for the period 2022–2024, this study evaluated how environmental conditions and urban design characteristics influence bike ridership. Rainfall, wind, temperature extremes, and street-level urban characteristics were examined, with rainfall and wind showing the clearest reductions in biking activity. Rain and wind were consistently associated with reduced bike use, with the strongest declines observed during typical peak hours. Thermal discomfort exhibited asymmetric effects: cold conditions suppressed bike ridership more strongly and persistently than heat. Statistical analysis revealed that the proportional effect of summer GVI alone is very small, indicating that it is secondary to the primary weather-related stressors. A robust mitigating shade effect was not established.

Two complementary predictive models were developed. The temporal count prediction model demonstrated strong performance in imputing missing bike count data at existing stations, ensuring continuity of time series even during extended data gaps. The new station count prediction model, based on a four-cluster typology derived from PCA of urban design characteristics and operationalized through decision tree classification rules, enabled the transfer of information across behaviorally similar locations to estimate counts at unmonitored sites. While new station count prediction model performance was constrained by the limited number of available stations (18 total), with only 3-6 stations per cluster, it nevertheless illustrated the potential for spatial generalization when behavioral similarity is explicitly accounted for through principled clustering and rule-based assignment. The effect of incorporating meteorological and urban micro-meteorological data was evaluated for both models. In the temporal fitted-series output, RMSE decreased from 27.24 to 25.25 bikes/hour between Models 1 and 3. In the LOSO new-station evaluation, Model 6 had the lowest MAE (33.12 bikes/hour), whereas Model 4 had the lowest RMSE (53.16 bikes/hour). Adding city-wide meteorological inputs (Model 5) increased MAE to 34.20 and RMSE to 55.08 bikes/hour. Adding station-specific micro-meteorological inputs (Model 6) gave an MAE of 33.12 and RMSE of 53.52 bikes/hour. Mean R² was positive in all three configurations (0.305, 0.244, and 0.258, respectively).

The results can be useful for cities such that cold, rain, and wind dominate ridership suppression, pointing to covered infrastructure and winter-cycling interventions as potential investments; shading along high-use corridors can mitigate heat-stress effects. The station typology and decision tree allows transport authorities to benchmark a candidate counter site — using only distance from center, greenness, and building density — without prior deployment. The temporal model ensures uninterrupted monitoring during data gaps. The methodology is transferable: any city with automated counters and urban data can apply this framework to guide counter placement, estimate demand at unmonitored sites, and evaluate environmental interventions.


# Author Declarations

This work was supported by the Fonds de la Recherche Scientifique (FNRS) [grant numbers - 1.A.891.23, T.0137.23]


# References

1. Handy S, Wee B van, Kroesen M. Promoting Cycling for Transport: Research Needs and Challenges. Transp Rev. 2014;34(1):4–24.

2. Kane C, Kythreotis S. Relationships Between Weather and Cycling. Liik-Vuosik. 2024 Feb 9;6. doi:10.58956/liikenne.142999

3. Gao J, Kamphuis CBM, Dijst M, Helbich M. The role of the natural and built environment in cycling duration in the Netherlands. Int J Behav Nutr Phys Act. 2018 Aug 29;15(1):82. doi:10.1186/s12966-018-0715-z

4. Li Z, Wang W, Liu P, Ragland DR. Physical environments influencing bicyclists’ perception of comfort on separated and on-street bicycle facilities. Transp Res Part Transp Environ. 2012 May 1;17(3):256–61. doi:10.1016/j.trd.2011.12.001

5. Khalid A, Ermagun A. Weather alerts reduce bikeshare trips but not equally across communities. Sustain Cities Soc. 2026 May 1;141:107282. doi:10.1016/j.scs.2026.107282

6. Tin S, Woodward A, Robinson E, Ameratunga S. Temporal, seasonal and weather effects on cycle volume: an ecological study. Environ Health. 2012 Dec;11(1):12. doi:10.1186/1476-069X-11-12

7. Willberg E, Poom A, Helle J, Toivonen T. Cyclists’ exposure to air pollution, noise, and greenery: a population-level spatial analysis approach. Int J Health Geogr. 2023 Feb 10;22(1):5. doi:10.1186/s12942-023-00326-7

8. Bakke EL, Torset T. How does the weather affect the shared bicycle usage? Dan J Transp Res – Dan Tidsskr Transp. 2019 Nov 28;1:13–29. doi:10.5278/ojs.djtr.v1i0.3560

9. Tang JHCG, Huang Y, Zhu Y, Yang X, Zhuge C. The association between travel demand of docked bike-sharing and the built environment: Evidence from seven US cities. Sustain Cities Soc. 2024 Jul 1;106:105325. doi:10.1016/j.scs.2024.105325

10. Young E, Kastner P, Dogan T, Chokhachian A, Mokhtar S, Reinhart C. Modeling outdoor thermal comfort along cycling routes at varying levels of physical accuracy to predict bike ridership in Cambridge, MA. Build Environ. 2022;208. Located at: Scopus. doi:10.1016/j.buildenv.2021.108577

11. Betkier I, Oszczypała M, Dawid W. Bike-sharing systems for sustainable cities: Demand prediction using graph neural networks and spatial aggregation. Sustain Cities Soc. 2025 Jun 15;128:106479. doi:10.1016/j.scs.2025.106479

12. Li W, Zhang X, Zou G, Liu W. Collaborative prediction of bike-sharing demand around metro stations using spatiotemporal neural network. Transp Res Part Transp Environ. 2026 Mar 1;152:105188. doi:10.1016/j.trd.2025.105188

13. Wang D, Jin M, Tong D, Chang X, Gong Y, Liu Y. Evaluating the bikeability of urban streets using dockless shared bike trajectory data. Sustain Cities Soc. 2024 Feb 1;101:105181. doi:10.1016/j.scs.2024.105181

14. Nordback K, Janson BN. Automated Bicycle Counts: Lessons from Boulder, Colorado. Transp Res Rec. 2010 Jan 1;2190(1):11–8. doi:10.3141/2190-02

15. Ermagun A, Lindsey G, Loh TH. Urban trails and demand response to weather variations. Transp Res Part Transp Environ. 2018 Aug 1;63:404–20. doi:10.1016/j.trd.2018.05.016

16. Nosal T, Miranda-Moreno LF. The effect of weather on the use of North American bicycle facilities: A multi-city analysis using automatic counts. Transp Res Part Policy Pract. 2014 Aug 1;66:213–25. doi:10.1016/j.tra.2014.04.012

17. Kaiser SK, Klein N, Kaack LH. From counting stations to city-wide estimates: data-driven bicycle volume extrapolation. Environ Data Sci. 2025 Jan;4:e13. doi:10.1017/eds.2025.5

18. Bruns C. Effectiveness of Measuring Pedestrian and Bicycle Traffic Volumes Using Eco-Counter Passive Infrared Counting Technology [Internet]. 2018 [cited 2025 Dec 9]. Available from: https://repository.lsu.edu/cgi/viewcontent.cgi?article=1228&context=honors_etd

19. El Esawey M. Impact of data gaps on the accuracy of annual and monthly average daily bicycle volume calculation at permanent count stations. Comput Environ Urban Syst. 2018 Jul 1;70:125–37. doi:10.1016/j.compenvurbsys.2018.03.002

20. Beitel D, McNee S, McLaughlin F, Miranda-Moreno LF. Automated Validation and Interpolation of Long-Duration Bicycle Counting Data. Transp Res Rec. 2018 Dec 1;2672(43):75–86. doi:10.1177/0361198118783123

21. Skupień ET, Fierek S. Sources and Use of Bicycle Traffic Data in Research and Urban Mobility Management. Urban Sci. 2025 Apr;9(4):127. doi:10.3390/urbansci9040127

22. Błażejczyk K, Jendritzky G, Bröde P, Fiala D, Havenith G, Epstein Y, Psikuta A, Kampmann B. An introduction to the Universal Thermal Climate Index (UTCI). Geogr Pol. 2013;86(1):5–10. doi:10.7163/GPol.2013.1

23. Proulx F, Schneider R, Miranda-Moreno L. Performance Evaluation and Correction Functions for Automated Pedestrian and Bicycle Counting Technologies. J Transp Eng. 2016 Jan 6;142:04016002. doi:10.1061/(ASCE)TE.1943-5436.0000828

24. Dharmaraju R, Noyce D, Lehman J. An evaluation of technologies for automated detection and classification of pedestrians and bicycles. Mass Highw Dep Rep. 2002 Jan 1.

25. Rowangould G, Fox E, O’Brien R, Clarke J. CCRPC Bicycle Count Data Analysis and Count Program Design Strategies. 2022.

26. Llaguno-Munitxa M, Bou-Zeid E. The environmental neighborhoods of cities and their spatial extent. Environ Res Lett. 2020 Jul;15(7):074034. doi:10.1088/1748-9326/ab8d7e

27. Chollet F. Xception: Deep Learning with Depthwise Separable Convolutions. 2017 IEEE Conf Comput Vis Pattern Recognit CVPR. 2017 Jul;1800–7. doi:10.1109/CVPR.2017.195

28. Llaguno-Munitxa M, Edwards M, Grade S, Vander Meulen M, Letesson C, Agudo Sierra E, Altomonte S, Lacroix E, Bogosian B, Mun K. 360° image and video urban scene immersions to evaluate the role of urban green infrastructure in stress level reduction. In: AUM2022 [Internet]. 2022 [cited 2024 Feb 4]. Available from: https://dial.uclouvain.be/pr/boreal/object/boreal:262922

29. Li X, Zhang C, Li W, Ricard R, Meng Q, Zhang W. Assessing street-level urban greenery using Google Street View and a modified green view index. Urban For Urban Green. 2015 Jan 1;14(3):675–85. doi:10.1016/j.ufug.2015.06.006

30. Paradigm Brussels. Brussels-Capital Region [Internet]. 2025 [cited 2025 Dec 27]. Transport, Mobility. Available from: https://be.brussels/en/transport-mobility

31. Lindberg F, Holmer B, Thorsson S. SOLWEIG 1.0 – Modelling spatial variations of 3D radiant fluxes and mean radiant temperature in complex urban settings. Int J Biometeorol. 2008 Sep 1;52(7):697–713. doi:10.1007/s00484-008-0162-7

32. Höppe P. A new procedure to determine the mean radiant temperature outdoors. Wetter Leben. 1992;44:147–51.

33. Tartarini F, Schiavon S. pythermalcomfort: A Python package for thermal comfort research. SoftwareX. 2020 Jul 1;12:100578. doi:10.1016/j.softx.2020.100578

34. Rousseeuw PJ. Silhouettes: A graphical aid to the interpretation and validation of cluster analysis. J Comput Appl Math. 1987 Nov 1;20:53–65. doi:10.1016/0377-0427(87)90125-7

35. Stone M. Cross-Validatory Choice and Assessment of Statistical Predictions. J R Stat Soc Ser B Stat Methodol. 1974 Jan 1;36(2):111–33. doi:10.1111/j.2517-6161.1974.tb00994.x

36. Cameron AC, Trivedi PK. Regression Analysis of Count Data [Internet]. 2nd ed. Cambridge University Press; 2013 [cited 2026 Sep 11]. Available from: https://www.cambridge.org/core/product/identifier/9781139013567/type/book doi:10.1017/CBO9781139013567

37. LIANG KY, ZEGER SL. Longitudinal data analysis using generalized linear models. Biometrika. 1986 Apr 1;73(1):13–22. doi:10.1093/biomet/73.1.13

38. Holm S. A Simple Sequentially Rejective Multiple Test Procedure. Scand J Stat. 1979;6(2):65–70.

39. C. F. Gauss. Theoria motus corporum coelestium in sectionibus conicis solem ambientium [Internet]. 1809 [cited 2026 Apr 13]. 269 p. Available from: http://archive.org/details/bub_gb_ORUOAAAAQAAJ

40. Stigler SM. Gauss and the Invention of Least Squares. Ann Stat. 1981;9(3):465–74.

41. Kohavi R. A study of cross-validation and bootstrap for accuracy estimation and model selection. In: Ijcai [Internet]. Montreal, Canada; 1995 [cited 2026 Apr 15]. p. 1137–45. Available from: https://www.researchgate.net/profile/Ron-Kohavi/publication/2352264_A_Study_of_Cross-Validation_and_Bootstrap_for_Accuracy_Estimation_and_Model_Selection/links/02e7e51bcc14c5e91c000000/A-Study-of-Cross-Validation-and-Bootstrap-for-Accuracy-Estimation-and-Model-Selection.pdf

42. NICOLET M. Royal Meteorological Institute of Belgium. Geophys Res Pap. 1952;263.

43. Hersbach H, Bell B, Berrisford P, Hirahara S, Horányi A, Muñoz-Sabater J, Nicolas J, Peubey C, Radu R, Schepers D, Simmons A, Soci C, Abdalla S, Abellan X, Balsamo G, Bechtold P, Biavati G, Bidlot J, Bonavita M, De Chiara G, Dahlgren P, Dee D, Diamantakis M, Dragani R, Flemming J, Forbes R, Fuentes M, Geer A, Haimberger L, Healy S, Hogan RJ, Hólm E, Janisková M, Keeley S, Laloyaux P, Lopez P, Lupu C, Radnoti G, de Rosnay P, Rozum I, Vamborg F, Villaume S, Thépaut JN. The ERA5 global reanalysis. Q J R Meteorol Soc. 2020;146(730):1999–2049. doi:10.1002/qj.3803

44. Inness A, Ades M, Agustí-Panareda A, Barré J, Benedictow A, Blechschmidt AM, Dominguez JJ, Engelen R, Eskes H, Flemming J, Huijnen V, Jones L, Kipling Z, Massart S, Parrington M, Peuch VH, Razinger M, Remy S, Schulz M, Suttie M. The CAMS reanalysis of atmospheric composition. Atmospheric Chem Phys. 2019 Mar 20;19(6):3515–56. doi:10.5194/acp-19-3515-2019

45. Schoolvakanties. Vlaanderen.be [Internet]. 2025 [cited 2025 Dec 27]. Schoolvakanties. Available from: https://www.vlaanderen.be/onderwijs-en-vorming/wat-mag-en-moet-op-school/schoolvakanties-vrije-dagen-en-afwezigheden/schoolvakanties

46. Portal of the Wallonia-Brussels Federation. FW-B Portal - Portal of the Wallonia-Brussels Federation [Internet]. 2025 [cited 2025 Dec 27]. Available from: https://www.federation-wallonie-bruxelles.be/

47. railwaytraveller123. Brussels Midi/Zuid Station Guide: Trains, Facilities, Where to Eat. Railway Traveller [Internet]. 2020 Aug 18 [cited 2026 Apr 14]. Available from: https://railwaytraveller.com/station-guides/brussels-midi

48. Institut Bruxellois de Statistique et d’Analyse (IBSA). Jette (Édition 2024). Région de Bruxelles-Capitale. [Internet]. 2024. Available from: https://www.vivalis.brussels/sites/default/files/2024-04/Jette_FR_cor.pdf

49. Federation EEC. Ecf [Internet]. ecf.com; 2022 [cited 2026 Apr 15]. New studies, new plan: Brussels aims even higher after cycling grows by 20% and road fatalities decrease. Available from: https://www.ecf.com/en/news/new-studies-new-plan-brussels-aims-even-higher-after-cycling-grows-by-20-and-road-fatalities-decrease/

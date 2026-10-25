# Abstract

Understanding how environmental conditions and urban design characteristics influence bike ridership is essential for promoting sustainable urban mobility; however, most studies focus on city-wide trends and overlook local variations in microclimate and context. This paper presents a methodology that integrates automated bike count data with high-resolution micrometeorological modeling and urban spatial indicators to quantify how thermal comfort, weather conditions, and streetscape characteristics affect bike ridership at hourly and seasonal timescales.

The methodology addresses two critical data limitations in bike count analysis: (i) short temporal gaps due to sensor malfunctions, and (ii) spatial coverage constraints. We develop a temporal count prediction model to impute missing data and a new station prediction model to estimate counts at unmonitored locations.

The proposed methodology demonstrates the benefits of using bike counter data and enables cities with different urban contexts to quantify local environmental barriers to biking, predict usage at potential counter locations.

Applied to the Brussels Capital Region (BCR) using data from 18 bike counters (2022-2024), the study focuses on **weekend biking** to isolate environmental comfort effects from commuting patterns. Statistical analysis reveals that rain strongly suppresses biking (**−7 to −15%**), wet–wind conditions reduce counts where estimable (**−12 to −16%**), cold stress has larger suppressing effects than heat stress (**about −5 to −6% vs. about −3 to −4%** in the heat season), while greenness alone remains uncertain after Holm adjustment (wide confidence intervals), shade shows modest effects in spring and summer (**−5 to −9%**), and the hot×green interaction is small and non-significant after Holm adjustment.

**Keywords:** Urban Thermal Comfort, Automated Bike Counters, Micrometeorological Modeling, Sustainable Urban Mobility, Predictive Modeling, Environmental Comfort

# Introduction

Many cities are promoting biking through infrastructure and bike-friendly policies to address traffic challenges and pursue sustainable urban mobility solutions \[1\]. Yet psychophysiological comfort often remains a barrier to bike adoption \[2\]. If biking environments are not comfortable and pleasant, promotion alone will not translate into actual bike ridership \[3–6\].

Several data sources have been used to document bike ridership in urban areas and to examine its relationship with environmental conditions, with docking station data, bike-sharing trip data, and automatic bike counter data among the most commonly used.

\(1\) Docking station data *(which record shared bike pick-ups and drop-offs at fixed locations)* have primarily been used in city-scale analyses. Using such data, previous studies have shown that environmental factors influence bike ridership \[7,8\]. For example, Willberg et al. \[7\] combined bike docking station data with a spatial pathfinding model incorporating environmental factors such as noise, air quality, and green spaces to estimate environmental exposure. Tang et al. \[9\] analyzed the association between docked bike-sharing demand and the built environment across land use, density, and network characteristics. These approaches demonstrate the potential of docking data for integrating environmental characteristics into biking analyses, while representing bikers’ movements across the city through modeled paths rather than directly observed trajectories, with route choice informed by environmental and urban characteristics.

\(2\) Bike-sharing trip data *(i.e., GPS-based bike trajectory data capturing individual trip paths)* enable the analysis of bike ridership at finer spatial and temporal resolutions. For example, using data from Boston’s Blue bikes program, Young et al. \[10\] modeled outdoor thermal comfort along three biking routes to predict ridership. Betkier et al. \[11\] used bike sharing trip data to predict demand, and Wang et al. \[12\] used bike sharing trip data to evaluate bikeability. However, bike-sharing trip data are representative of shared-bike users and may exhibit systematic differences from **weekend biking** patterns, particularly regarding weekend usage and sensitivity to comfort-related factors.

\(3\) Automatic bike counters (devices that record bike passages, commonly using induction-loop detectors embedded beneath bike lanes or infrared sensors mounted along biking infrastructure) have been used to quantify biking volumes and examine their relationships with environmental conditions \[13\]. For example, Ermagun et al. \[14\] and Nosal and Miranda-Moreno \[15\] used automatic bike counter data to examine the effects of weather on bike ridership, quantifying the impacts of temperature, precipitation, wind, and humidity, as reflected in changes in biking demand. In these studies, meteorological variables were represented at the city scale using data from nearby regulatory weather stations, while bike count data were aggregated to daily totals. This level of temporal and spatial aggregation enabled comparisons across multiple cities, rather than analyses of intra-city variability, which would require consideration of local urban context and city-specific spatiotemporal patterns at finer temporal resolutions.

In the past few years, automatic bike counters have been installed in several cities including – Brussels, New York, Helsinki, Paris, Strasbourg, Bern, Hamburg, Bonn, Heidelberg amongst others \[6,16\]. When analyzed in conjunction with high–spatiotemporal-resolution urban and micrometeorological data, automatic bike counter data offer an opportunity to evaluate how local urban design and environmental conditions surrounding each counter shape bike ridership at that location, enabling intra-urban comparisons across multiple counter sites within the same city. Yet, to the authors’ knowledge, no prior work has integrated such data with micrometeorological and urban indicators to examine how environmental comfort is associated with bike ridership across hourly, diurnal, and seasonal timescales—hence the focus of this study.

As stated before, this paper relates environmental comfort to bike counts. Here, environmental comfort refers to the quality of outdoor conditions as experienced by people in urban spaces. It is understood as a combination of thermal comfort, weather-related comfort, and urban environmental conditions, all of which are influenced by the interaction between climate and urban form. Bike counts are hourly measures of passage at distinct locations. The locations are sparse and counters may fail or counting locations may undergo changes.

Before meaningful relationships can be explored both data sources have to be validated and, if necessary, corrected. The paper therefore starts by addressing challenges related to data availability in automatic bike count records. Such limitations affect the spatial and temporal completeness of observed counts and raise concerns about data reliability and their usefulness for examining city-wide bike ridership\[17\]. Specifically, (i) bike count data are often incomplete due to sensor malfunctions, power outages, and temporary road blockages such as maintenance works or diversions, which are issues that are difficult to avoid in practice \[18\]. (ii) In addition, the number of bike counters that can be deployed within a city is inherently limited by financial and implementation constraints, resulting in sparse spatial coverage \[19,20\]. In this context, the paper presents two models: (i) a temporal count prediction model to complete missing bike count data, and (ii) a new station count prediction model that leverages station typologies to estimate counts at locations where a counting station is unavailable. This paper then proposes a methodology to assess how bike ridership is associated with environmental comfort by studying variations across hourly, diurnal, and seasonal timescales, considering local micrometeorological conditions (e.g., rain, wind, solar radiation, mean radiant temperature, air temperature, and relative humidity) and urban design characteristics (such as greenness and shading from green infrastructure and buildings), using automatic bike counter data together with detailed urban and environmental datasets.

Thermal comfort is assessed using the Universal Thermal Climate Index (UTCI), where thresholds encompass moderate heat stress (26°C ≤ UTCI \< 32°C), strong heat stress (UTCI ≥ 32°C), moderate cold stress (-13°C \< UTCI ≤ 0°C), and strong cold stress (UTCI \< -13°C) \[21\].

A methodology that combines environmental, urban, and automatic bike counter data, and processes these datasets using thermal comfort, vegetation classification, spatial analysis, and prediction models is proposed to assess bike ridership. This methodology is applied to a case study in the Brussels Capital Region (BCR), selected for its extensive bike counter infrastructure, dedicated biking network, and strong public engagement in biking**.** First, a temporal count prediction model is applied to impute missing bike count data. The analysis focuses on **weekend biking, used to reduce weekday commuting dominance without inferring trip purpose from counter data**. H1–H4 addresses environmental conditions and H5–H7 addresses urban design characteristics. Finally, the new station count prediction model is implemented to assess its potential for estimating bike counts at unmonitored locations:

1.  H1 (Rain): When it rains, the number of bikers will be significantly lower than on dry days.

2.  H2 (Rain + Wind): When it is windy (wind speed \> 7 m/s) and raining, the number of bikers will be lower than on calm, dry (no wind, no rain) days.

3.  H3 (Heat Stress): In strong UTCI-based heat stress conditions (UTCI ≥ 32°C), biking counts will be significantly lower than on moderate (26°C ≤ UTCI \< 32°C) UTCI conditions.

4.  H4 (Cold Stress): In strong UTCI-based cold stress conditions (UTCI \< -13°C), biking counts will be significantly lower than moderate (-13°C \< UTCI ≤ 0°C) UTCI conditions

5.  H5: Bike ridership (counts) will be significantly lower on no-green streets compared to green spaces.

6.  H6: On slight or higher thermal discomfort days (based on UTCI), bike ridership will be significantly higher in shaded routes than non-shaded routes.

7.  H7: At green stations the negative effect of heat stress will be lower than no-green ones.

# Methodology

The proposed methodology to assess bike ridership requires the compilation of various data, including environmental, urban, and automatic bike counter datasets, and the processing of these data using thermal comfort, vegetation classification, spatial analysis, and prediction models. For the automatic bike counter data, considering the missing values due to equipment outages or malfunctions, the methodology also checks and imputes missing data at existing counter locations using the *temporal count prediction model* described in section 2.5.1. Additionally, considering that it may not be possible to install bike counters in all areas of interest, the methodology includes *a new station count prediction model* to estimate bike counts at locations without counters using data from nearby similar stations described in section 2.5.2. **The primary contribution is the H1–H7 environmental-comfort analysis (section 2.6); imputation and new-station prediction support counter data completeness and spatial coverage but do not replace the primary NB2 estimands.** The data gathered, the methods used, and the indicators generated for this study are presented in Figure 1 and a description of indicators is given in Appendix Table A.1, with more detailed explanations in sections 2.1 to 2.7, and Figure 2 shows the full methodology described in the following sections.

<figure>
<img src="media/image2.svg" style="width:6.39192in;height:3.10777in" />
<figcaption><p>: Raw data inputs, processing tools and methods, and output indicators for the bike ridership analysis methodology (at 1 hour resolution).</p></figcaption>
</figure>

The data compilation and processing tools & methods generated 20 indicators, as shown in Figure 1, with their description given in Appendix Table A.1.

<img src="media/image4.svg" style="width:8.33065in;height:6.28174in" />

Figure : Methodology Flowchart with data processed at 1 hour resolution

## Data compilation

### Bike counter data

Automated bike counting stations employ various detection technologies that include inductive loop detectors, passive infrared sensors, and pneumatic tubes \[13,22,23\]. Inductive loop detectors are most commonly used; they work by sensing changes in the electromagnetic field caused by the metal frame of a bike passing over the inductive loop \[13\]. Passive infrared sensors detect heat signatures from moving objects, such as the body heat of bikers \[22\]. Pneumatic tubes measure air pressure changes from tire compression as bikes roll over them \[23\]. Bike count data are available at different resolutions – 15 minutes to 1 hour, sometimes the data include speed \[24\].

### Urban Data

High spatial resolution datasets, including a Digital Elevation Model (DEM) and Digital Terrain Model (DTM), provide the topographic baseline for the study area. Morphological parameters such as Sky View Factor (SVF), building and vegetation layers, wall heights, and wall aspects are derived from DEM and DTM to characterize urban geometry. Additionally, 360-degree panorama images are captured at each counter location.

### Environmental Data 

Needed meteorological variables including air temperature (Ta), relative humidity (RH), wind speed (v), and air pressure, which should be sourced at hourly resolution to evaluate micrometeorological conditions. Detailed solar radiation components—Global Horizontal Irradiance (GHI), Direct Horizontal Irradiance (DHI), and Diffuse Normal Irradiance (DNI) are required to compute thermal comfort.

## Computing Bike Count

Biking data from 2.1.3 are processed by temporally aggregating bike counts to hourly resolution and classifying data based on month, day of year, type of day (weekdays/weekends) and distinguishing holiday days.

## Computing Urban Indicators

### Building Density at 125m

Building densities are computed using a 125m × 125m buffer—a resolution representative for characterizing urban environmental neighborhoods \[25\]. Building Density 125m is defined as the ratio of the total building layer’s surface area (obtained in section 2.1.2) to the total area of the 125 m × 125 m buffer (=15,625 m<sup>2</sup>).

### Green View Index (GVI)

360-degree panorama images as described in section 2.1.2 are captured at every bike counter location and are inputted into the Xception deep learning image segmentation model \[26,27\], to compute the Green View Index (GVI), a metric measuring the percentage of visible green vegetation pixels in each image. Then GVI is computed using the modified GVI calculation formula from Li et al. \[28\] as shown below:

``` math
\begin{array}{r}
GVI = \frac{\sum_{i = 1}^{6}{\sum_{j = 1}^{3}{Area}_{g_{i}j}}}{\sum_{i = 1}^{6}{\sum_{j = 1}^{3}{Area}_{t_{i}j}}} \times 100\#(1)
\end{array}
```

where *i* = 1, …, 6 denotes the six horizontal viewing directions; *j* = 1, 2, 3 denotes the three vertical view angles (-45°, 0°, +45°); $`Area_{g,ij}`$ is the number of green vegetation pixels (trees, grass, and plants) classified in image (*i*, *j*); and $`Area_{t,ij}`$ is the total number of pixels in that image, giving 18 images per counter location in total. Bike counter locations with GVI values \>10% are classified as "Green," else "No-Green". **Summer and winter GVI values were computed for each station. Summer GVI was used as the primary greenness measure for H1–H7, clustering, and prediction; winter GVI was retained only for comparison.**

### Distance From Center

For each bike counter, the Euclidean distance is measured from the city center using a geospatial processing tool available in Quantum Geographic Information System (QGIS).

### Road Type

Road Type is a five-category variable that distinguishes the city's road network \[29\]: (1) Central Transit Corridor, (2) Highway, (3) Local Access Road, (4) Outer Urban Ring, (5) Peripheral Connector Road.

### Directionality

Directionality is defined as a categorical variable representing the lane coverage of each bike counter. Based on visual inspection of counter locations \[29\], counters measuring bike flow on a single bike lane are classified as unidirectional (“mono”), whereas counters measuring flow on both sides of the roadway are classified as bidirectional (“bi”).

## Computing Environmental Indicators

Using urban data from 2.1.2 and environmental and meteorological data from 2.1.3, thermal comfort and weather comfort indicators are computed.

The methodology implements the Solar and LongWave Environmental Irradiance Geometry (SOLWEIG) model \[30\] to compute the mean radiant temperature (Tmrt), which represents the integrated radiant temperature of surrounding surfaces. SOLWEIG requires urban geometry data from building and vegetation layers, Sky View Factor (SVF), wall height, and wall aspect ratio, and meteorological data in EnergyPlus Weather (EPW) format. Urban geometry data are processed from the urban data described in section 2.1.2 using tools within Urban Multi-scale Environmental Predictor (UMEP) \[30\], an integrated platform for urban climate modeling. Meteorological data (air temperature (*Ta*), relative humidity (*RH*), wind speed (*v*), and solar radiation), as described in section 2.1.3, are combined with solar radiation components (GHI, DNI, DHI) to prepare an EPW file as input for SOLWEIG. Using this EPW file together with high-resolution urban geometry inputs (building and vegetation layers, DSM, DTM), SOLWEIG simulates Tmrt across the study area using Höppe et al. \[31\] formula for *Tmrt* computation as:

``` math
\begin{array}{r}
Tmrt\  = \ \left( \frac{S_{str}}{(\varepsilon_{p}\sigma}) \right)^{1\text{/}4} - 273.15\#(2)
\end{array}
```

where Tmrt is mean radiant temperature (°C), *S<sub>str</sub>* is the mean radiant flux density (W m⁻²), representing the sum of all short and longwave radiation fluxes from six directions (up, down, and four cardinal directions) weighted by angular view factors to the person; *ε<sub>p</sub>* is the emissivity of the human body (standard value 0.97); *σ* is the Stefan-Boltzmann constant (5.67×10<sup>–8</sup> Wm<sup>-2</sup> K<sup>-4</sup> ).

*Tmrt*, *Ta*, *RH*, and *v* are then used to compute Universal Thermal Climate Index (UTCI) on a 25-m resolution grid in the vicinity of each bike counter, using the multi-node thermoregulatory model Blazejczyk et al. \[21\] through the pythermalcomfort python package \[32\] as follows:

``` math
\begin{array}{r}
UTCI = f(Ta;Tmrt;v;vp) = Ta + Offset(Ta;Tmrt;v;vp)\#(3)
\end{array}
```

where UTCI is expressed in equivalent temperature (°C); *Ta* is air temperature (°C); *Tmrt* is mean radiant temperature (°C); *v* is wind speed at 10 m height (m s⁻¹); *vp* is vapour pressure (hPa); and Offset represents the dynamic physiological response of a standing person based on a multi-node human energy balance and thermoregulation model, calculated from the combined effects of all input parameters. Vapor pressure (*vp*) is derived internally from *Ta* and *RH* using standard psychrometric conversion formula implemented in the pythermalcomfort package \[32\].

Strong heat stress is defined as UTCI \> 32°C, moderate heat stress as 26°C \< UTCI ≤ 32°C, strong cold stress as UTCI \< -13°C, and moderate cold stress as -13°C \< UTCI ≤ 0°C, based on standard UTCI classifications \[21\]. In this study strong heat stress is referred to as hot, and strong cold stress is referred to as cold, moderate cold stress and moderate heat stress are referred as moderate.

Shading, rainfall, and wind conditions are represented using categorical indicators. Shading effects on bike ridership is derived from the shadow output of SOLWEIG \[30\], which is used to characterize solar exposure at each counter location. In this paper it is referred to as shade indicator (1 = shade; 0 = unshaded). Rain is treated as a categorical indicator, with each hour classified as rain or non-rain according to an hourly precipitation threshold (rain \> 0.01 mm/h). Wind conditions are also represented categorically, with hours classified as wind or no-wind based on hourly wind speeds exceeding 7 m/s. Rain and wind conditions together are represented with categorical variable (rain_wind), having four distinct levels: no wind no-rain, wind with no-rain, no-wind and rain, and wind and rain.

## Prediction Models

Two prediction models are developed: one for filling the missing data (for periods \< 6 hours) using historic data, and another for predicting counts at locations without bike counters.

### Temporal Count Prediction Model

A multi-linear regression model is trained using historic data to predict and fill missing counts. The model is fitted by weighted regression (weights = log(fit + 1)) with iterative outlier removal (five iterations; \|residual\| \> 1). Counts with more than six consecutive zeros (i.e., no counts are measured for more than 6 hours) are considered station outages and treated as missing data. To evaluate the incremental benefit of adding meteorological data, three model configurations are prepared. The indicators used in the three model configurations, each trained per station (*i*) and hour (*t*), are: temporal features only (Day of Year, IsWeekend, Month, Holiday) for Model 1, which is used as the baseline for imputing missing counts. City-averaged uniform meteorological variables (*Ta*, *RH*, *v*, *Tmrt*, UTCI, Rain, Hot, Cold) are then added for Model 2. For Model 3, station-specific micrometeorological variables are used, as detailed in the model formulations below:

Model 1: Multi-linear Regression model used as baseline with no-meteorological data

``` math
\log\left( Count_{i,t} + 1 \right) = \beta_{0} + \beta_{1} \cdot {DayofYear}_{i,t} + \beta_{2} \cdot {IsWeekend}_{i,t} + \beta_{3} \cdot {Holiday}_{i,t} +
```

``` math
\begin{array}{r}
\beta_{4} \cdot {Month}_{i,t} + \varepsilon_{t}\#(4)
\end{array}
```

Model 2: Multi-linear Regression baseline model with city-averaged meteorological data

``` math
\log\left( Count_{i,t} + 1 \right)\  = \ \beta_{0} + \beta_{1} \cdot DayofYear_{t} + \beta_{2} \cdot IsWeekend_{t} + \beta_{3} \cdot Holiday_{t} +
```

``` math
\beta_{4} \cdot Month_{t} + \beta_{5} \cdot Ta_{t} + \beta_{6} \cdot RH_{t} + \beta_{7} \cdot Wind_{t} + \beta_{8} \cdot Tmrt_{t} + \beta_{9} \cdot UTCI_{t} + \beta_{10} \cdot Rain_{t}\  +
```

``` math
\begin{array}{r}
\beta_{11} \cdot Shade_{t} + \beta_{12} \cdot Hot_{t} + \beta_{13} \cdot Cold_{t} + \varepsilon_{t}\#(5)
\end{array}
```

Model 3: Multi-linear Regression baseline model with micro-meteorological data

``` math
\log\left( Count_{i,t} + 1 \right) = \beta_{0} + \beta_{1} \cdot DayofYear_{t} + \beta_{2} \cdot IsWeekend_{t} + \beta_{3} \cdot Holiday_{t} +
```

``` math
\beta_{4} \cdot Month_{t} + \beta_{5} \cdot Ta_{i,t} + \beta_{6} \cdot RH_{i,t} + \beta_{7} \cdot Wind_{i,t} + \beta_{8} \cdot Tmrt_{i,t} + \beta_{9} \cdot UTCI_{i,t} +
```

``` math
\begin{array}{r}
\beta_{10} \cdot Rain_{i,t} + \beta_{11} \cdot Shade_{i,t} + \beta_{12} \cdot Hot_{i,t} + \beta_{13} \cdot Cold_{i,t} + \varepsilon_{t}\#(6)
\end{array}
```

where $`Count_{i,t}`$ is the hourly bike count at station *i* at hour *t*.

Temporal variables $`DayofYear_{t},`$ $`IsWeekend_{t}`$, $`Holiday_{t},`$ $`Month_{t}`$ carry only subscript *t* because they are uniform across all stations at a given hour. $`Ta_{t},RH_{t},Wind_{t},Tmrt_{t},UTCI_{t},Rain_{t},Hot_{t}\ `$

and $`Cold_{t}`$ (Model 2) are meteorological variables. $`Ta_{i,t},RH_{i,t},Wind_{i,t},Tmrt_{i,t},UTCI_{i,t},Rain_{i,t},`$

$`Shade_{i,t},Hot_{i,t}\ and\ Cold_{i,t}`$ (Model 3) are the corresponding station-specific micrometeorological variables$`.\beta_{0}`$ is the intercept, $`\beta_{1}`$ to $`\beta_{13}`$ are their respective coefficients, and $`\varepsilon_{t}`$ is the error term.

### New Station Count Prediction Model

A new station count prediction model is prepared for estimating counts at locations where a counting station is unavailable. This is a random forest model that uses the 20 indicators (shown in figure 1) for training (excluding Day of Year because Month, Hour, IsWeekend, and Holiday together provide sufficient seasonal and diurnal context for cross-station generalization).

The urban indicators - distance from center, GVI and Building Density at 125m, were selected for clustering because they are readily computable for any city, making the approach transferable. These three urban indicators are standardized (z-scored) to ensure equal contribution despite different units & ranges and then subjected to Principal Component Analysis (PCA) to reduce dimensional redundancy and improve clustering interpretability. PC1–PC2 scores from the PCA are then used for *k*-means clustering. The total number of bike counting stations are divided into clusters to make groups of similar urban typologies, that can help predict data for any new location that are within the cluster. The optimal number of clusters is determined using silhouette analysis \[33\]; and the highest silhouette score is used to conclude the total number of clusters for a given city.

Random forest model is preferred over multi-linear regression because it automatically handles non-linear relationships and multicollinearity without requiring manual variable selection or transformation, allowing all 20 indicators to be used effectively.

To predict data for a new location without local historical data, the following procedure is implemented: First, the temporal bike ridership pattern is derived from stations within the same cluster by training on the volume profile (hourly count divided by station mean). A cross-validation strategy is implemented where the model for each location is trained by completely excluding that specific station from the entire training set, ensuring predictions are generalized purely based on other stations within cluster. **To prevent data leakage, feature scaling, PCA, and k-means clustering are repeated entirely within each leave-one-station-out training fold, ensuring the held-out station cannot influence typology construction (Appendix Table A.5).**

Then, this learned normalized pattern is multiplied by the mean annual count of neighboring stations within the same cluster, used as a proxy for the new location's expected volume. Final predictions are thus computed as: Predicted Count = Volume Profile × Cluster Mean Annual Count.

To evaluate the incremental benefit of adding meteorological data, three model configurations are prepared, for which the indicators include - temporal and urban features only (Hour, Day of Year, IsWeekend, Month, Holiday, Distance From Center, Road Type, Directionality, Building Density 125m, GVI) for Model 4; to which are then added city- averaged uniform meteorological variables (*Ta, RH, Wind, Tmrt*, UTCI, Rain, Hot, Cold, Shade) for Model 5; or local station specific values of the same meteorological variables for Model 6, as formulated below:

Model 4: New station count prediction model with no meteorological data

``` math
Count_{i,t}\  = f(Month_{t},Hour_{t},IsWeekend_{t},Holiday_{t},DistanceFromCenter_{i},RoadType_{i},
```

``` math
\begin{array}{r}
Directionality_{i},\, BuildingDensity125m_{i},GVI_{i}) + \varepsilon_{i,t}\#(7)
\end{array}
```

Model 5: New station count prediction model with city-averaged meteorological data

``` math
Count_{i,t} = f(Month_{t},{Hour}_{t},{Holiday}_{t},\ {IsWeekend}_{t},\ Ta_{t},\ RH_{t},\ Wind_{t},\ Tmrt_{t},\ UTCI_{t},\ 
```

``` math
Rain\_ t,\, Hot_{t},\, Cold_{t},Shade_{i,t},DistanceFromCenter_{i},RoadType_{i},Directionality_{i},
```

``` math
\begin{array}{r}
BuildingDensity125m_{i},GVI_{i}) + \varepsilon_{i,t}\#(8)
\end{array}
```

Model 6: New station count prediction model with location-specific meteorological data

``` math
Count_{i,t} = f(Month_{t},{Hour}_{t},{Holiday}_{t},\ {IsWeekend}_{t},\ Ta_{i,t},\ RH_{i,t},\ Wind_{t},\ Tmrt_{i,t},\ UTCI_{i,t},
```

``` math
Rain_{i,t},Hot_{i,t},\, Cold_{i,t},Shade_{i,t},DistanceFromCenter_{i},RoadType_{i},Directionality_{i}
```

``` math
\begin{array}{r}
BuildingDensity125m_{i},GVI_{i}) + \varepsilon_{i,t}\#(9)
\end{array}
```

where $`Count_{i,t}`$ is the predicted bike count produced by Volume Profile × Cluster Mean Annual Count, at location $`i`$ at hour $`t`$.

*f* is the Random Forest ensemble function; temporal indicators $`Month_{t}`$, $`{Hour}_{t}`$, $`{IsWeekend}_{t}`$, $`{Holiday}_{t}`$; urban indicators $`DistanceFromCenter_{i},RoadType_{i},Directionality_{i},`$

$`BuildingDensity125m_{i},GVI_{i}`$; (Model 5) meteorological variables are $`Ta_{t},RH_{t},Wind_{t},Tmrt_{t},`$

$`UTCI_{t},Rain_{t},Hot_{t}`$, and $`Cold_{t}`$; (Model 6) micro-meteorological variables are; $`Ta_{i,t},RH_{i,t},Wind_{i,t},Tmrt_{i,t},UTCI_{i,t},Rain_{i,t},Shade_{i,t}`$, $`Hot_{i,t}`$ and $`Cold_{i,t}`$;

and $`\varepsilon_{i,\ t}`$ is the prediction error.

## Statistical analysis

Bike ridership is evaluated using a mixed-effects model to estimate both fixed effects of the environmental exposures and random station effects that account for repeated observations within counters \[49\]. A negative-binomial type-2 (NB2) specification is selected because hourly counts are over-dispersed (variance exceeding the mean); its quadratic mean–variance relationship can handle this overdispersion \[50\]. Hourly counts at the same station are often similar from one hour to another; for this, an AR(1) working correlation is specified for consecutive hours at each station on the same day \[51\].

A joint NB2 model is fitted for each quarter (Q1–Q4) in glmmTMB (family = nbinom2, log link). Cold quarters (Q1, Q4) use cold + Green (no Cold×Green interaction); warm quarters (Q2, Q3) use hot × Green. H1 uses the same structure with separate Rain and Wind terms in place of rain_wind. Planned contrasts are reported as rate ratios RR = exp(β). RR < 1 indicates lower expected counts; RR > 1 indicates higher expected counts. Percentage change is 100 × (RR − 1). P-values are adjusted across the 28 planned comparisons using the Holm procedure.

``` math
\begin{array}{r}
\mathrm{Count} \sim \mathrm{rain\_wind} + \mathrm{cold} + \mathrm{Green} + \mathrm{Shade} + \mathrm{Hour} + \mathrm{Year} + (1\mid\mathrm{station}) + \mathrm{ar1}(\mathrm{hour}+0\mid\mathrm{station\text{-}day}),\quad q\in\{1,4\}\#(11)\\[0.4em]
\mathrm{Count} \sim \mathrm{rain\_wind} + \mathrm{hot}\times\mathrm{Green} + \mathrm{Shade} + \mathrm{Hour} + \mathrm{Year} + (1\mid\mathrm{station}) + \mathrm{ar1}(\mathrm{hour}+0\mid\mathrm{station\text{-}day}),\quad q\in\{2,3\}\#(12)
\end{array}
```

where Count is the observed hourly bike count (not log-transformed); rain_wind, hot, cold, Green and Shade are defined in sections 2.2 and 2.4; Hour and Year are temporal controls; (1|station) is the station-level random intercept (Station_i ~ N(0, σ_b²); FeatureID); and the AR(1) term models consecutive hours within each station-day \[51\]. Where the AR(1) fit fails convergence checks, the random-intercept model without AR(1) is the labelled fallback. Unsupported H1–H7 contrasts were labelled unsupported.

**As sensitivity checks, the NB2 models were refitted using filled counts from temporal Model 1, continuous exposures (rain, wind, UTCI, GVI), and alternative operational cut-offs; combinations without adequate support were not interpreted.**

Model performance is evaluated separately from the NB2 analysis, on the original bike-count scale, using R² \[38\], RMSE \[39,40\], MAE, sMAPE, and Bias under cross-validation \[34–37\]. **Temporal imputation was additionally validated by masking contiguous blocks of 3, 6, 12, 24, and 72 hours across low, median, and high demand tertiles. For the new-station model, performance under the excluded-station cross-validation is compared with city-hour, cluster-hour, and geographic nearest-station baselines.** Linear models were fitted on log(Count + 1); predictions were back-transformed as p_t = max(0, exp(ŷ_t) − 1) before metrics were computed, where ŷ_t is the fitted value on the log scale. RF was fitted on log(volume profile + 0.01) and converted back to counts as p_t = max(0, (exp(ŷ_t) − 0.01) × cluster mean count).

``` math
\begin{array}{r}
\mathrm{MAE} = \frac{1}{n}\sum_{t=1}^{n}|a_{t}-p_{t}|\#(13)
\end{array}
```

``` math
\begin{array}{r}
\mathrm{sMAPE} = \frac{100}{n}\sum_{t=1}^{n}\begin{cases}
\frac{2|a_{t}-p_{t}|}{|a_{t}|+|p_{t}|}, & |a_{t}|+|p_{t}|>0\\
0, & |a_{t}|+|p_{t}|=0
\end{cases}\#(14)
\end{array}
```

``` math
\begin{array}{r}
\mathrm{Bias} = \frac{1}{n}\sum_{t=1}^{n}(p_{t}-a_{t})\#(15)
\end{array}
```

``` math
\begin{array}{r}
R^{2} = 1-\frac{\sum_{t=1}^{n}(a_{t}-p_{t})^{2}}{\sum_{t=1}^{n}(a_{t}-\overline{a})^{2}}\#(16)
\end{array}
```

``` math
\begin{array}{r}
\mathrm{RMSE} = \sqrt{\frac{1}{n}\sum_{t=1}^{n}(a_{t}-p_{t})^{2}}\#(17)
\end{array}
```

where a_t is the observed bike count on the original count scale, p_t is the predicted bike count (bikes/hour) after conversion from the corresponding log-scale fit, ā is the mean of the observed counts, n is the total number of hourly observations in the out-of-sample test set for each station, and t indexes those observations; sMAPE is set to 0 when both a_t and p_t are zero.


## Case study BCR

The proposed methodology (sections 2.1–2.6) was applied to the case study of BCR for the years 2022–24.

Datasets mentioned in section 2.1.1, were sourced from the Royal Meteorological Institute of Belgium (RMI) \[38\], European Centre for Medium-Range Weather Forecasts (ECMWF) Reanalysis v5 (ERA5) \[39\], and Copernicus Atmosphere Monitoring Service (CAMS) \[40\]. RMI data was retrieved for weather station location in BCR, CAMS was retrieved at 0.4° resolution and ERA5 at 31 km resolution. The parameters collected from RMI included air temperature, relative humidity, air pressure, wind speed, wind direction, and rain; parameters from CAMS included hourly solar radiation components—global horizontal irradiance (GHI), direct normal irradiance (DNI), and diffuse horizontal irradiance (DHI), parameters from ERA5 included snow depth and total cloud cover in NetCDF format. These datasets were processed and aggregated to hourly resolution for consistency. Urban spatial data (DEM, DTM, and land cover) were obtained from the BCR Urban Information System (UrbIS) \[29\] at 0.5 m resolution; all these datasets were resampled to 25 m prior to SOLWEIG simulation (section 2.4).

Bike count data were collected at 15-minute intervals and processed to 1-hour. Holidays were marked for Flanders and Brussels (two provinces of Belgium that were in proximity to BCR) \[41,42\].

Using these data, all indicators listed in Figure 1 were computed for each of the 18 bike counting stations, as illustrated on the map in Figure 3. Each counter was documented using the 360 panorama images shown in Figure 4 and an image of bike counter as shown in Figure 5. The statistical analysis described in section 2.6 were then used for testing of hypothesis H1–H7, with a focus on **weekend bike ridership**. For NB2 estimation, bike counts are analyzed using only the weekend daytime hours (9–16h) across the entire study period (2022-2024).

<img src="media/image6.svg" style="width:5.40845in;height:3.92146in" />

Figure 3: Map showing locations of the 18 counting stations

<figure>
<img src="media/image7.jpeg" style="width:6.5in;height:6.69911in" />
<figcaption><p>: 360 panorama images for the 18 counting stations</p></figcaption>
</figure>

<img src="media/image8.jpeg" style="width:6.44in;height:3.57in" />Figure 5: Bike counter photo with tubes embedded in road

# Results

## Role of environmental characteristics in bike ridership

Bike ridership in the BCR was examined across all four quarters (Q1 to Q4) of the year 2022 to 2024, with each quarter representing a three-month period. Q1 – January to March, Q2 – April to June, Q3 – July to September and Q4 – October to December. **Focusing on weekend daytime hours (9–16h), hypotheses 1 to 7 (H1 to H7) were tested using the NB2 mixed-effects models described in section 2.6, with results shown in Figure 6.** The reported quantities are the NB2 rate ratio, 95% confidence interval, percentage change in expected counts (100 × (RR − 1)), and Holm-adjusted p-value. **Primary estimates use prepared non-imputed counts with summer GVI retained as the greenness indicator; filled-count and threshold sensitivities are summarized after Table 1.**

### H1 - Impact of Rainfall on Bike ridership

Rain is analyzed as a binary variable (rain vs. no-rain) to isolate its independent effect from wind interactions. As shown in Figure 6(a), average bike counts were lower during rain than no-rain. The summer-GVI NB2 analysis estimated count changes of **−7.43%, −10.94%, −15.00%, and −13.94%** in Q1–Q4, respectively; all four Holm-adjusted p-values were below 1 × 10−11 (Table 1).

### H2 - Influence of Rain and Wind on Bike ridership

As shown in Figure 6(b), wet–wind conditions further suppress ridership where estimable. The summer-GVI NB2 analysis estimated **−12.22%** in Q1, **−2.28%** in Q3 (Holm p = 1.000), and **−16.00%** in Q4. Q2 was not reportable (Table 1).

### H3 - Influence of Heat Stress on Bike ridership

As shown in Figure 6(c), differences between hot and moderate-heat hours were modest. The summer-GVI NB2 analysis estimated **−2.65%** in Q2 and **−3.64%** in Q3 (Holm p = 1.000 and 0.447). Q1 and Q4 were unsupported because the heat contrast was structurally absent (Table 1).

### H4 - Influence of Cold Stress on Bike ridership

As shown in Figure 6(d), cold hours had lower peaks than moderate-cold hours. The summer-GVI NB2 analysis estimated **−5.40%** in Q1 (Holm p = 0.093) and **−6.07%** in Q4 (Holm p = 0.215). Q2 and Q3 were unsupported because the cold contrast was structurally absent (Table 1).

### H5 - Effect of GVI on Bike ridership

As shown in Figure 6(e), green vs no-green differences remained uncertain after station random effects. The summer-GVI NB2 analysis estimated **−26.74%, −16.34%, −25.45%, and −24.48%** in Q1–Q4; all Holm-adjusted p-values were 1.000, with wide confidence intervals. GVI is a station-level characteristic (Table 1).

### H6 - Effect of Shade (Urban Morphology) on Bike Ridership

As shown in Figure 6(f), shade effects were evaluated in the heat-season quarters. The summer-GVI NB2 analysis estimated **−5.13%** in Q2 (Holm p = 1.000) and **−8.55%** in Q3 (Holm p = 0.006). Q1 and Q4 were unsupported because H6 is defined for heat-season quarters only (Table 1).

### H7 - Combined Effect of GVI and Heat Stress

As shown in Figure 6(g), the hot × green interaction was estimable in Q2 and Q3. The summer-GVI NB2 analysis estimated **+6.48%** in Q2 and **−0.72%** in Q3; both Holm-adjusted p-values were 1.000. Q1 and Q4 were unsupported because the heat interaction is not defined in winter/autumn (Table 1).


<figure>
<img src="media/image10.svg" style="width:4.79243in;height:7.83476in" />
<figcaption><p>Figure 6: Mean diurnal biking count profiles (represented by lines) across seasonal quarters (Q1–Q4) comparing average hourly behavioral responses to urban and environmental stressors. Each row illustrates the comparative usage: Row 1 (a) no-rain (orange) vs. rain (yellow) days; Row 2 (b) calm (light blue) vs. wind (blue) days; Row 3 (c) “moderate” (light red) vs. “hot” (red) conditions; Row 4 (d) “moderate” (light blue) vs. “cold” (dark blue) conditions; Row 5 (e) “green” (light green) vs. “no-green” (dark green) station areas; Row 6 (f) shaded (black) vs. unshaded (grey). And hot Row 7 (g) green (light green) vs. no-green (dark green) bike routes.</p></figcaption>
</figure>

<table>
<caption><p>Table 1: Summer-GVI NB2 rate ratios, percentage change, and Holm-adjusted p-values (weekend 9–16h)</p></caption>
<thead>
<tr>
<th style="text-align: center;">Hypothesis</th>
<th style="text-align: center;">Quarter</th>
<th style="text-align: center;">Contrast</th>
<th style="text-align: center;">Status</th>
<th style="text-align: center;">RR (95% CI)</th>
<th style="text-align: center;">Change %</th>
<th style="text-align: center;">P (Holm)</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;">H1</td>
<td style="text-align: center;">Q1</td>
<td style="text-align: center;">rain vs no rain (adjusted for wind)</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.926 (0.907–0.945)</td>
<td style="text-align: center;">-7.43</td>
<td style="text-align: center;">9.07e-12</td>
</tr>
<tr>
<td style="text-align: center;">H2</td>
<td style="text-align: center;">Q1</td>
<td style="text-align: center;">wind and rain vs no wind no rain</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.878 (0.849–0.907)</td>
<td style="text-align: center;">-12.22</td>
<td style="text-align: center;">3.23e-13</td>
</tr>
<tr>
<td style="text-align: center;">H3</td>
<td style="text-align: center;">Q1</td>
<td style="text-align: center;">hot vs moderate heat (26–32°C)</td>
<td style="text-align: center;">Unsupported</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
<tr>
<td style="text-align: center;">H4</td>
<td style="text-align: center;">Q1</td>
<td style="text-align: center;">cold vs moderate cold (−13 to 0°C)</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.946 (0.911–0.983)</td>
<td style="text-align: center;">-5.40</td>
<td style="text-align: center;">0.093</td>
</tr>
<tr>
<td style="text-align: center;">H5</td>
<td style="text-align: center;">Q1</td>
<td style="text-align: center;">green vs no-green</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.733 (0.381–1.408)</td>
<td style="text-align: center;">-26.74</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H6</td>
<td style="text-align: center;">Q1</td>
<td style="text-align: center;">shade vs unshaded</td>
<td style="text-align: center;">Unsupported</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
<tr>
<td style="text-align: center;">H7</td>
<td style="text-align: center;">Q1</td>
<td style="text-align: center;">hot × green interaction</td>
<td style="text-align: center;">Unsupported</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
<tr>
<td style="text-align: center;">H1</td>
<td style="text-align: center;">Q2</td>
<td style="text-align: center;">rain vs no rain (adjusted for wind)</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.891 (0.868–0.913)</td>
<td style="text-align: center;">-10.94</td>
<td style="text-align: center;">6.55e-18</td>
</tr>
<tr>
<td style="text-align: center;">H2</td>
<td style="text-align: center;">Q2</td>
<td style="text-align: center;">wind and rain vs no wind no rain</td>
<td style="text-align: center;">Not reportable</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
<tr>
<td style="text-align: center;">H3</td>
<td style="text-align: center;">Q2</td>
<td style="text-align: center;">hot vs moderate heat (26–32°C)</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.973 (0.932–1.016)</td>
<td style="text-align: center;">-2.65</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H4</td>
<td style="text-align: center;">Q2</td>
<td style="text-align: center;">cold vs moderate cold (−13 to 0°C)</td>
<td style="text-align: center;">Unsupported</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
<tr>
<td style="text-align: center;">H5</td>
<td style="text-align: center;">Q2</td>
<td style="text-align: center;">green vs no-green</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.837 (0.428–1.637)</td>
<td style="text-align: center;">-16.34</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H6</td>
<td style="text-align: center;">Q2</td>
<td style="text-align: center;">shade vs unshaded</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.949 (0.892–1.009)</td>
<td style="text-align: center;">-5.13</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H7</td>
<td style="text-align: center;">Q2</td>
<td style="text-align: center;">hot × green interaction</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">1.065 (0.955–1.187)</td>
<td style="text-align: center;">6.48</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H1</td>
<td style="text-align: center;">Q3</td>
<td style="text-align: center;">rain vs no rain (adjusted for wind)</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.850 (0.827–0.873)</td>
<td style="text-align: center;">-15.00</td>
<td style="text-align: center;">1.57e-30</td>
</tr>
<tr>
<td style="text-align: center;">H2</td>
<td style="text-align: center;">Q3</td>
<td style="text-align: center;">wind and rain vs no wind no rain</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.977 (0.934–1.023)</td>
<td style="text-align: center;">-2.28</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H3</td>
<td style="text-align: center;">Q3</td>
<td style="text-align: center;">hot vs moderate heat (26–32°C)</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.964 (0.933–0.995)</td>
<td style="text-align: center;">-3.64</td>
<td style="text-align: center;">0.447</td>
</tr>
<tr>
<td style="text-align: center;">H4</td>
<td style="text-align: center;">Q3</td>
<td style="text-align: center;">cold vs moderate cold (−13 to 0°C)</td>
<td style="text-align: center;">Unsupported</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
<tr>
<td style="text-align: center;">H5</td>
<td style="text-align: center;">Q3</td>
<td style="text-align: center;">green vs no-green</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.746 (0.383–1.453)</td>
<td style="text-align: center;">-25.45</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H6</td>
<td style="text-align: center;">Q3</td>
<td style="text-align: center;">shade vs unshaded</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.915 (0.872–0.960)</td>
<td style="text-align: center;">-8.55</td>
<td style="text-align: center;">0.006</td>
</tr>
<tr>
<td style="text-align: center;">H7</td>
<td style="text-align: center;">Q3</td>
<td style="text-align: center;">hot × green interaction</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.993 (0.932–1.058)</td>
<td style="text-align: center;">-0.72</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H1</td>
<td style="text-align: center;">Q4</td>
<td style="text-align: center;">rain vs no rain (adjusted for wind)</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.861 (0.844–0.878)</td>
<td style="text-align: center;">-13.94</td>
<td style="text-align: center;">2.09e-49</td>
</tr>
<tr>
<td style="text-align: center;">H2</td>
<td style="text-align: center;">Q4</td>
<td style="text-align: center;">wind and rain vs no wind no rain</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.840 (0.815–0.865)</td>
<td style="text-align: center;">-16.00</td>
<td style="text-align: center;">2.76e-29</td>
</tr>
<tr>
<td style="text-align: center;">H3</td>
<td style="text-align: center;">Q4</td>
<td style="text-align: center;">hot vs moderate heat (26–32°C)</td>
<td style="text-align: center;">Unsupported</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
<tr>
<td style="text-align: center;">H4</td>
<td style="text-align: center;">Q4</td>
<td style="text-align: center;">cold vs moderate cold (−13 to 0°C)</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.939 (0.895–0.986)</td>
<td style="text-align: center;">-6.07</td>
<td style="text-align: center;">0.215</td>
</tr>
<tr>
<td style="text-align: center;">H5</td>
<td style="text-align: center;">Q4</td>
<td style="text-align: center;">green vs no-green</td>
<td style="text-align: center;">Fitted</td>
<td style="text-align: center;">0.755 (0.389–1.466)</td>
<td style="text-align: center;">-24.48</td>
<td style="text-align: center;">1.000</td>
</tr>
<tr>
<td style="text-align: center;">H6</td>
<td style="text-align: center;">Q4</td>
<td style="text-align: center;">shade vs unshaded</td>
<td style="text-align: center;">Unsupported</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
<tr>
<td style="text-align: center;">H7</td>
<td style="text-align: center;">Q4</td>
<td style="text-align: center;">hot × green interaction</td>
<td style="text-align: center;">Unsupported</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
<td style="text-align: center;">—</td>
</tr>
</tbody>
</table>

**Threshold and continuous-exposure sensitivity checks supported the same directional conclusions as Table 1 for rain and wet–wind where contrasts remained estimable: alternative rain cut-offs generally retained negative rate ratios, while continuous rain and UTCI retained significant associations; continuous wind and GVI did not after Holm adjustment. Combinations with insufficient exposed or reference support were labelled unsupported and not interpreted. Refitting H1–H7 on filled (imputed) counts produced only small shifts relative to the prepared primary estimates, consistent with the low outage share (~1%). Table 1 and the primary narrative therefore retain summer GVI; winter GVI remains available for seasonal comparison only.**

## Data completion with the temporal count prediction model

The temporal count prediction (from 2.5.1) model 1 was used to fill station outage gaps (defined as 0 counts for more than 6 consecutive hours). The station-level information of filled data counts is provided in Appendix Table A.2. Data gaps represented only 1.09% of the total study period (2022-24) across all 18 stations.

**In addition to the 2024 hold-out in Table 2, contiguous block-masking validation was applied to observed hours: 50 blocks at each of 3, 6, 12, 24, and 72 hours, stratified across low, median, and high demand, with Model 1 refitted and metrics reported on the count scale. Mean MAE across blocks was about 18–22 bikes/hour depending on block length (mean RMSE about 21–33), confirming usable recovery under sensor-like outages without treating exp(RMSE) − 1 as a percentage error.**

Model performance for temporal count prediction model was evaluated using out-of-sample testing across three configurations — Model 1 (no-meteorology), Model 2 (meteorology), and Model 3 (micro-meteorology), where each model was trained on historical data for both weekday and weekend for years 2022 and 2023, and tested against real observed (non-missing) counts from 2024. Table 2 summarizes count-scale MAE, RMSE and R² for each model configuration across all stations.

Table 2: Station-wise 2024 performance for temporal Models 1–3 on the original count scale (MAE and RMSE in bikes/hour).

| FeatureID | MAE M1 | RMSE M1 | R² M1 | MAE M2 | RMSE M2 | R² M2 | MAE M3 | RMSE M3 | R² M3 |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| CAT17 | 17.10 | 28.57 | 0.851 | 16.45 | 27.80 | 0.859 | 14.58 | 24.83 | 0.887 |
| CB02411 | 26.92 | 47.42 | 0.878 | 26.41 | 46.73 | 0.882 | 24.72 | 43.49 | 0.898 |
| CB1101 | 30.68 | 50.27 | 0.900 | 29.98 | 49.08 | 0.904 | 27.86 | 45.64 | 0.917 |
| CB1142 | 19.10 | 43.41 | 0.894 | 19.85 | 42.81 | 0.896 | 19.71 | 42.03 | 0.900 |
| CB1143 | 26.45 | 51.18 | 0.833 | 26.39 | 51.18 | 0.833 | 26.77 | 52.17 | 0.827 |
| CB1599 | 8.93 | 14.42 | 0.872 | 8.64 | 14.06 | 0.879 | 7.91 | 12.86 | 0.898 |
| CB1699 | 8.10 | 12.91 | 0.862 | 7.96 | 12.72 | 0.866 | 7.38 | 11.84 | 0.884 |
| CB2105 | 20.06 | 28.43 | 0.771 | 19.72 | 28.04 | 0.778 | 18.99 | 27.04 | 0.793 |
| CEE016 | 11.93 | 18.99 | 0.900 | 11.73 | 18.42 | 0.906 | 10.82 | 16.92 | 0.920 |
| CEK049 | 15.58 | 24.06 | 0.904 | 15.14 | 23.49 | 0.909 | 13.79 | 21.36 | 0.925 |
| CEK18 | 13.27 | 26.94 | 0.881 | 12.86 | 26.45 | 0.886 | 11.76 | 24.27 | 0.904 |
| CEK31 | 17.47 | 30.62 | 0.911 | 17.09 | 30.00 | 0.914 | 15.96 | 28.25 | 0.924 |
| CEV011 | 6.71 | 12.08 | 0.835 | 6.63 | 12.03 | 0.836 | 6.36 | 11.68 | 0.846 |
| CJE181 | 3.53 | 5.51 | 0.815 | 3.48 | 5.43 | 0.820 | 3.33 | 5.23 | 0.833 |
| CJM90 | 30.45 | 46.19 | 0.924 | 29.45 | 44.69 | 0.929 | 27.14 | 41.10 | 0.940 |
| CLW239 | 6.68 | 10.97 | 0.826 | 6.53 | 10.74 | 0.833 | 6.02 | 9.90 | 0.858 |
| COM205 | 14.55 | 23.94 | 0.775 | 14.29 | 23.70 | 0.779 | 13.23 | 22.18 | 0.807 |
| CVT387 | 5.60 | 9.50 | 0.856 | 5.56 | 9.38 | 0.860 | 5.35 | 8.94 | 0.873 |
| Average | 15.73 | 26.97 | 0.860 | 15.45 | 26.49 | 0.865 | 14.54 | 24.98 | 0.880 |

The baseline model (Model 1), using only temporal features, achieved overall **MAE = 15.73**, **RMSE = 26.97**, and **R² = 0.860**. Adding meteorological variables (Model 2) gave **MAE = 15.45**, **RMSE = 26.49**, **R² = 0.865**. Adding micro-meteorological data (Model 3) gave **MAE = 14.54**, **RMSE = 24.98**, **R² = 0.880**. The highest R² with micro-meteorological data was at CJM90; the lowest was at CB1143 (Appendix Figure A.1).

Metrics are reported on the original count scale after predictions are converted back to counts (section 2.6); RMSE% = (e^RMSE − 1)×100 is not used. Since Model 1 provides strong generalizability without requiring meteorological inputs, it is used as the imputation model for missing data.

## New station count prediction model

The new station count prediction model was not used to generate data for H1-H7 hypothesis testing; it is presented as a separate prediction application for estimating counts at unmonitored locations. The optimal number of clusters required for new station count prediction model was determined using silhouette analysis (as shown in Appendix Figure A.2), which measures cluster cohesion and separation. Clusters k = 4 achieved the highest silhouette score (0.53) compared to k=2 to k=10. Although silhouette scores for k=2–4 are comparable (0.44, 0.52, and 0.53 respectively), k=4 was selected because scores decline consistently from k=5 onward, and because the four-cluster solution yields the most interpretable grouping of station typologies. The indicators distance from center, GVI, Building Density at 125m were standardized (z-scored) to ensure equal contribution despite different units and ranges, and subjected to PCA; PC1–PC2 (which together explained 85.7% of the total variance, with PC1 at 59.1% and PC2 at 26.6%) were clustered using k-means (k=4) as shown in Appendix Figure A.2, resulting in the 4 clusters as below:

> 1\. Cluster 1 – CJE181, CLW239, COM205, CVT387 (4 stations)
>
> 2\. Cluster 2 – CB1101, CB1142, CB1143, CB2105, CJM90 (5 stations)
>
> 3\. Cluster 3 – CAT17, CB02411, CEK049, CEK31 (4 stations)
>
> 4\. Cluster 4 – CB1599, CB1699, CEE016, CEK18, CEV011 (5 stations)

The benchmark ranges for each cluster, defining the characteristic ranges of distance from center, GVI, building density at 125m that identify each cluster are shown in Appendix Figure A.2 and Appendix Table A.3. Pairwise scatter plots of these three features, colored by cluster, are shown in Appendix Figure A.3, illustrating the separation and overlap structure in the original feature space. These are descriptive summaries in the original feature space; as clusters are defined by joint PC1-PC2 position, ranges overlap across clusters. Assignment for a new site should follow the decision tree (Figure 7).

<figure>
<img src="media/image12.svg" style="width:6.375in;height:4.25837in" />
<figcaption><p>: Decision Tree for Cluster Assignment</p></figcaption>
</figure>

The decision tree as shown in Figure 7, guides the cluster assignment process by comparing the new location’s local features - distance from center, building density 125m and GVI. Following this approach, cluster assignment (Clusters 1 to 4) can be performed for a new station, and thereafter, the new station count prediction model can be implemented.

Model performance for new station count prediction model was evaluated using out-of-sample testing across three configurations — Model 4 (no-meteorology), Model 5 (city-averaged meteorology), and Model 6 (station-specific meteorology), where each model was trained on historical data for both weekday and weekend for year 2022 to 2023 and tested against observed counts from 2024. Table 3 summarizes count-scale MAE, RMSE and R² for each model configuration across all stations.

Table 3: Station-wise 2024 performance for new-station Models 4–6 on the original count scale (MAE and RMSE in bikes/hour).

| FeatureID | MAE M4 | RMSE M4 | R² M4 | MAE M5 | RMSE M5 | R² M5 | MAE M6 | RMSE M6 | R² M6 |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| CAT17 | 33.86 | 49.41 | 0.554 | 32.50 | 47.59 | 0.586 | 33.24 | 47.57 | 0.587 |
| CB02411 | 50.81 | 86.36 | 0.596 | 51.14 | 87.60 | 0.585 | 47.53 | 79.75 | 0.656 |
| CB1101 | 56.75 | 94.52 | 0.645 | 59.63 | 100.02 | 0.603 | 53.85 | 91.46 | 0.668 |
| CB1142 | 46.58 | 83.98 | 0.602 | 46.80 | 85.41 | 0.588 | 47.14 | 83.21 | 0.609 |
| CB1143 | 36.15 | 65.33 | 0.728 | 38.07 | 69.33 | 0.694 | 37.02 | 67.15 | 0.713 |
| CB1599 | 11.20 | 19.75 | 0.760 | 11.35 | 20.26 | 0.748 | 9.91 | 17.52 | 0.811 |
| CB1699 | 10.99 | 18.64 | 0.713 | 10.73 | 18.25 | 0.725 | 10.22 | 17.75 | 0.740 |
| CB2105 | 53.35 | 93.92 | -1.495 | 50.17 | 87.55 | -1.167 | 53.37 | 94.08 | -1.503 |
| CEE016 | 34.03 | 51.85 | 0.253 | 35.12 | 53.14 | 0.215 | 34.13 | 51.26 | 0.270 |
| CEK049 | 27.60 | 40.32 | 0.732 | 28.34 | 41.77 | 0.712 | 26.48 | 39.92 | 0.737 |
| CEK18 | 23.29 | 62.93 | 0.353 | 23.07 | 62.57 | 0.360 | 21.57 | 60.46 | 0.403 |
| CEK31 | 29.40 | 49.61 | 0.765 | 29.18 | 50.64 | 0.755 | 27.00 | 43.80 | 0.817 |
| CEV011 | 18.28 | 26.06 | 0.231 | 18.30 | 26.43 | 0.210 | 19.19 | 27.54 | 0.142 |
| CJE181 | 11.09 | 15.79 | -0.522 | 10.89 | 15.86 | -0.535 | 12.54 | 18.00 | -0.977 |
| CJM90 | 86.34 | 119.24 | 0.493 | 88.75 | 121.90 | 0.470 | 82.57 | 111.59 | 0.556 |
| CLW239 | 7.88 | 12.56 | 0.772 | 7.95 | 12.87 | 0.760 | 6.54 | 10.57 | 0.838 |
| COM205 | 27.07 | 42.34 | 0.295 | 27.41 | 42.65 | 0.285 | 27.26 | 41.59 | 0.319 |
| CVT387 | 7.62 | 12.42 | 0.754 | 7.64 | 12.57 | 0.749 | 6.97 | 10.91 | 0.810 |
| Average | 31.79 | 52.50 | 0.402 | 32.06 | 53.13 | 0.408 | 30.92 | 50.78 | 0.400 |

On the count scale, mean R² for Models 4–6 is positive but modest (**about 0.40**), with two stations (**CB2105, CJE181**) remaining negative under Model 6. Model 6 had the lowest mean MAE (**30.92**) and RMSE (**50.78**). Station-level patterns are shown in Appendix Figure A.4.

**Complementary leakage-controlled excluded-station cross-validation (section 2.5.2) repeated scaling, PCA, clustering, and fitting for each of the 18 training folds. The microclimate random-forest configuration achieved mean MAE = 35.48 bikes/hour. Paired RMSE was lower than the cluster-hour baseline (mean ΔRMSE = −9.63; 95% CI −13.36 to −5.91), the geographic nearest-station baseline (−35.09; −56.78 to −13.40), and the city-hour baseline (−23.43; −33.48 to −13.37). Count-scale R² was negative for 2 of 18 held-out stations.**

### Observations from new station count prediction model

Station-level individual patterns: CB2105 (Cluster 2, near city center at distance 1137 m) showed weaker cross-station fit with micro-meteorology (**Model 6 R² = −1.50; MAE = 53.37**). This is due to proximity to railway station and transport hub \[44\], where a large share of trips terminate at rail, metro, tram, and bus connections rather than continuing by bike, depressing observed counts relative to cluster peers and leading to over-prediction. CJE181 (**Model 6 R² = −0.98**; Cluster 1, northwestern periphery at 5,140 m from center, mean 13.8 bikes/hr) records persistently low counts due to its location in a low-density municipality, with its surroundings including expositions and cultural institutions, neither of which generate regular bike ridership, leading cluster peers in more urbanized neighborhoods to systematically overpredict this station \[45\]. CJM90 (**Model 6 R² = 0.56**; Cluster 2, 1,143 m from center, mean 194.2 bikes/hr) is located near a river, which is a public attraction. This bike path broke 1 million count record, and displays the highest mean count in the network, driven by mixed commuter and recreational flows \[46\]. Cluster peers with more typical bike ridership therefore systematically underpredict at this high-volume location.

Morning and evening peaks: The model tended to underestimate afternoon return peaks at CAT17 (local access road, 4597 m from center, **Model 6 R² = 0.59**) and CB1101 (outer urban ring, 1139 m, **Model 6 R² = 0.67**). At profile level, CEK18 showed lower-than-expected evening peaks, while CB1143, CEE016, and CJM90 showed evening peaks higher than morning peaks. It was observed that multiple route alternatives redistribute bikers away from counters and is not represented by current station-level predictors, which contributes lower bike counts for CAT17.

Station-level disruptions: The proportion of missing data on average per station was 1.09% for the 3 year study period (2022-24), individually CVT387 recorded 53.6% zero counts in September 2024 (vs typical 5–15%), with zero counts in February 2024 (19.6%) and October 2022 (21%), due to temporary closure or counter malfunction. CB1143 experienced a prolonged shutdown (73% zeros in July 2024, 100% in August, 72% in September) linked to road works. These periods led to uncaptured bike ridership, which resulted in underprediction of bike counts.

# Discussion

The presented methodology leverages bike count data—now increasingly available across cities—together with high-resolution micro-meteorological and urban data to examine how bike ridership varies in relation to environmental comfort conditions. Temporal indicators capturing diurnal, weekly, and seasonal patterns, as well as holiday-related effects, are jointly encoded with environmental and urban variables. This integrated methodology enables the construction of interactive statistical analyses that support both visual and quantitative assessment of the environmental comfort factors governing bike ridership.

## Case study BCR

In the BCR, periods characterized by combined rain and wind are associated with sharp declines in biking activity, potentially due to increased surface splashing, slip risk, and reduced visibility at exposed intersections. This sensitivity to adverse weather is likely reinforced by urban and environmental context: the predominantly deciduous street canopy results in reduced shelter following leaf fall, increasing exposure to rain and wind. While leaf loss does increase solar access during winter, this benefit is limited in practice by Brussels' characteristically overcast skies, which average fewer than two sunshine hours per day in December and January. Local infrastructure characteristics—such as open junctions and limited drainage—further exacerbate these conditions. Together, these factors may compound bikers’ vulnerability during rain and wind periods.

Thermal stress shows asymmetric associations with bike ridership. Cold conditions are associated with broader reductions in bike use than heat, while greenness alone remains uncertain after accounting for station baselines. While greenery may enhance route appeal, its independent effect on bike ridership is secondary to dominant thermal and weather-related constraints.

These findings indicate that, within the BCR, rain, wet–wind, and cold conditions represent stronger constraints on sustained weekend biking than heat or greenness alone. However, the relative importance of environmental stressors is likely to vary across climatic and sociocultural contexts. Further studies across diverse environments would help determine how these relationships change under different thermal and urban conditions.

## Temporal count prediction model and new station count prediction models

The temporal count prediction model demonstrated strong predictive performance, indicating its suitability for imputing missing bike count data, including cases where data gaps extended over prolonged periods. **Block-masking recovery under demand-stratified outages further supports this use for maintaining continuity in urban biking datasets.**

In contrast, the new-station prediction model performed lower, as reported in Table 3 and the paired cross-validation comparisons. By design, predictions rely entirely on cross-station transfer without target-station historical counts. The model is trained on urban typology indicators and cannot capture unobserved non-urban attractors or transit interchange dynamics. Furthermore, clustering 18 stations yielded groups of only 3–5 stations, limiting cross-station transfer accuracy. **Count-scale mean R² across folds was modest (~0.40 in Table 3 and 0.10 under LOSO) and remained negative for 2 of 18 held-out stations (CB2105, CJE181), demonstrating that spatial transfer without local volume baselines remains constrained even when MAE/RMSE comparisons against simple baselines remain informative for planning.**

### Improvement in model performance with micrometeorological data

For the temporal count prediction model, adding meteorological data changed performance by **ΔR² = +0.005** and **ΔRMSE = −0.48**; adding micro-meteorological data changed it by **ΔR² = +0.020** and **ΔRMSE = −1.99** (count-scale RMSE). For the new-station model, meteorological data gave **ΔR² = +0.006** and **ΔRMSE = +0.63**; micro-meteorology gave **ΔR² = −0.002** and **ΔRMSE = −1.72** relative to Model 4.

The RMSE reduction observed for Model 6 versus Model 4 can be attributed to local exposure information under cross-station transfer. In contrast, the temporal model already captures strong station-specific temporal patterns, so the incremental benefit of micro-meteorology is smaller.

Based on literature, automated bike counters are well-calibrated instruments producing reliable hourly counts; a count-scale RMSE reduction of **about 1.7 bikes/hour (Model 4 to Model 6)** is modest for ridership prediction, but can still matter for comparing candidate counter sites.

### Extension of clustering indicators with broader urban context

The three urban design characteristics used for clustering — distance from center, GVI, and Building Density at 125m — differentiate broad station typologies but do not account for the presence of key attractor points in a station's surroundings. Extending the clustering feature set to include such proximity-based indicators would improve both cluster quality and prediction accuracy:

Stations adjacent to major transit interchanges serve predominantly as trip-termination points where a large share of bike trips end at public transport connections. Their bike ridership is governed by transit schedules rather than neighborhood typology, producing count volumes and diurnal profiles distinct from other stations.

Stations located near water bodies or large recreational green spaces **attract weekend bike ridership** with a pronounced weekend component, differing structurally from stations with similar urban design characteristics situated in standard residential or commercial settings.

Two stations sharing comparable values of distance from center, Building Density at 125m, and GVI can therefore exhibit markedly different bike ridership solely by virtue of proximity to such key attractor points — a distinction the current clustering does not capture.

Including proximity to key attractor points as a clustering indicator would group stations by behavioral similarity more precisely, reducing within-cluster variation in biking activity and strengthening the cross-station transfer underlying the new station count prediction model.

This extension would require compilation of additional urban indicator datasets, increasing the initial data requirements — a trade-off between model informativeness and methodological transferability to be considered in future studies.

## Limitations of this study

### General limitations of the methodology:

1.  A further limitation of this study is the absence of explicit traffic dynamics, which also influence bike ridership. While bikers may benefit from increased relative mobility during peak vehicular congestion, higher traffic volumes can simultaneously intensify environmental stressors such as noise emissions, and air pollution, potentially offsetting these advantages. Future research could integrate traffic-related data (e.g., vehicle counts or congestion levels) to better assess how traffic exposure interacts with environmental comfort, and to support targeted interventions—such as traffic calming or protected biking infrastructure—in high-traffic areas.

2.  Elevation and slopes were not considered in this study.

3.  The current feature set also does not explicitly capture route-choice accessibility (e.g., number of alternative paths, network connectivity, and detour potential). This likely contributes to underestimation of morning and return peaks at stations where bikers can redistribute across nearby corridors.

4.  Wind exposure represents an additional methodological limitation. Although wind speed is included as a predictor based on available meteorological data, spatial variability in wind conditions is not explicitly modeled. Wind exposure is therefore assumed to be uniform across the city, overlooking localized effects driven by urban morphology, building configurations, and topography. Future work could integrate microscale wind modeling approaches, such as computational fluid dynamics, to better capture street-level wind variability and identify wind-vulnerable corridors, thereby informing targeted design interventions to improve biking comfort under wind conditions.

5.  While imputing missing bike count data for sensor malfunctions or power outages is justified as traffic still occurs, gaps caused by temporary road blockages—such as maintenance works or diversion may render the location inaccessible. In such cases, traffic is often diverted to parallel routes rather than lost. Imputation model predicts the traffic that would have occurred if the road was not blocked. Road blockage or sensor malfunction are identical from the analysis perspective. making imputation potentially misleading. In this study models do not account for road works schedules, sensor malfunction and road divergence and data for all of these scenarios are imputed.

### Limitations specific to the case study of BCR:

1.  Bike count data is only available for 18 locations in BCR.

2.  While referred to as bike counters, these sensors record all soft mobility vehicles using biking infrastructure, including bikes, scooters, delivery bikes, and e-scooters. At present, it is not possible to distinguish between these vehicle types within the available data. **Counters also do not record trip purpose; weekend daytime hours reduce commuting peaks but cannot identify leisure versus other weekend trips.**

3.  The BCR study area is largely flat with low levels of slopes, resulting in a predominantly flat urban environment.

4.  **Both summer and winter panorama-based GVI were computed at each station; summer GVI is retained as the primary greenness measure for analysis. Imagery was captured after the 2022–2024 count window (summer 2025 and a winter campaign), so year-to-year streetscape change relative to the count years remains a limitation.**

# Conclusion

This paper introduced an integrated methodology that combines bike count data with high-resolution micro-meteorological and urban spatial information to assess how environmental comfort shapes bike ridership across time and space. Applied to the BCR, the approach demonstrates how temporally structured indicators and statistical analysis can be used to interpret both general patterns and context-specific responses to environmental conditions.

Using automated bike count data from 18 counting stations across the BCR for the period 2022–2024, this study evaluated how environmental conditions and urban design characteristics influence weekend bike ridership. Rainfall and wet–wind conditions were associated with reduced bike use (about −7 to −16% where estimable). Thermal discomfort was asymmetric: cold suppressed ridership more clearly than heat in the NB2 results, while greenness alone was uncertain after station random effects and Holm adjustment. Shade showed a modest reducing association in summer after Holm adjustment.

Two complementary predictive models were developed. **The temporal count prediction model demonstrated strong count-scale performance for imputing missing bike count data at existing stations, including under contiguous block-masking. The new-station model, based on a four-cluster typology from PCA of urban design characteristics and validated with excluded-station cross-validation that rebuilds typology on each training fold, enabled cross-station transfer to unmonitored sites but with lower accuracy and modest mean count-scale R².** Adding meteorological and micro-meteorological predictors reduced temporal-model RMSE by **about 2 bikes/hour** (Model 1 to Model 3) and new-station RMSE by **about 1.7 bikes/hour** (Model 4 to Model 6).

The results offer actionable guidance for cities. Cold, rain, and wind dominate ridership suppression, pointing to covered infrastructure and winter-cycling interventions as priority investments. The station typology and decision tree allow transport authorities to benchmark a candidate counter site using distance from center, greenness, and building density. The temporal model supports uninterrupted monitoring during data gaps. The methodology is transferable to cities with automated counters and comparable urban data.

# Author Declarations

This work was supported by the Fonds de la Recherche Scientifique (FNRS) \[grant numbers - 1.A.891.23, T.0137.23\]

# References

1\. Handy S, Wee B van, Kroesen M. Promoting Cycling for Transport: Research Needs and Challenges. Transp Rev. 2014;34(1):4–24.

2\. Kane C, Kythreotis S. Relationships Between Weather and Cycling. Liik-Vuosik. 2024 Feb 9;6. doi:10.58956/liikenne.142999

3\. Gao J, Kamphuis CBM, Dijst M, Helbich M. The role of the natural and built environment in cycling duration in the Netherlands. Int J Behav Nutr Phys Act. 2018 Aug 29;15(1):82. doi:10.1186/s12966-018-0715-z

4\. Li Z, Wang W, Liu P, Ragland DR. Physical environments influencing bicyclists’ perception of comfort on separated and on-street bicycle facilities. Transp Res Part Transp Environ. 2012 May 1;17(3):256–61. doi:10.1016/j.trd.2011.12.001

5\. Khalid A, Ermagun A. Weather alerts reduce bikeshare trips but not equally across communities. Sustain Cities Soc. 2026 May 1;141:107282. doi:10.1016/j.scs.2026.107282

6\. Tin S, Woodward A, Robinson E, Ameratunga S. Temporal, seasonal and weather effects on cycle volume: an ecological study. Environ Health. 2012 Dec;11(1):12. doi:10.1186/1476-069X-11-12

7\. Willberg E, Poom A, Helle J, Toivonen T. Cyclists’ exposure to air pollution, noise, and greenery: a population-level spatial analysis approach. Int J Health Geogr. 2023 Feb 10;22(1):5. doi:10.1186/s12942-023-00326-7

8\. Bakke EL, Torset T. How does the weather affect the shared bicycle usage? Dan J Transp Res – Dan Tidsskr Transp. 2019 Nov 28;1:13–29. doi:10.5278/ojs.djtr.v1i0.3560

9\. Tang JHCG, Huang Y, Zhu Y, Yang X, Zhuge C. The association between travel demand of docked bike-sharing and the built environment: Evidence from seven US cities. Sustain Cities Soc. 2024 Jul 1;106:105325. doi:10.1016/j.scs.2024.105325

10\. Young E, Kastner P, Dogan T, Chokhachian A, Mokhtar S, Reinhart C. Modeling outdoor thermal comfort along cycling routes at varying levels of physical accuracy to predict bike ridership in Cambridge, MA. Build Environ. 2022;208. Located at: Scopus. doi:10.1016/j.buildenv.2021.108577

11\. Betkier I, Oszczypała M, Dawid W. Bike-sharing systems for sustainable cities: Demand prediction using graph neural networks and spatial aggregation. Sustain Cities Soc. 2025 Jun 15;128:106479. doi:10.1016/j.scs.2025.106479

12\. Wang D, Jin M, Tong D, Chang X, Gong Y, Liu Y. Evaluating the bikeability of urban streets using dockless shared bike trajectory data. Sustain Cities Soc. 2024 Feb 1;101:105181. doi:10.1016/j.scs.2024.105181

13\. Nordback K, Janson BN. Automated Bicycle Counts: Lessons from Boulder, Colorado. Transp Res Rec. 2010 Jan 1;2190(1):11–8. doi:10.3141/2190-02

14\. Ermagun A, Lindsey G, Loh TH. Urban trails and demand response to weather variations. Transp Res Part Transp Environ. 2018 Aug 1;63:404–20. doi:10.1016/j.trd.2018.05.016

15\. Nosal T, Miranda-Moreno LF. The effect of weather on the use of North American bicycle facilities: A multi-city analysis using automatic counts. Transp Res Part Policy Pract. 2014 Aug 1;66:213–25. doi:10.1016/j.tra.2014.04.012

16\. Bruns C. Effectiveness of Measuring Pedestrian and Bicycle Traffic Volumes Using Eco-Counter Passive Infrared Counting Technology \[Internet\]. 2018 \[cited 2025 Dec 9\]. Available from: https://repository.lsu.edu/cgi/viewcontent.cgi?article=1228&context=honors_etd

17\. Kaiser SK, Klein N, Kaack LH. From counting stations to city-wide estimates: data-driven bicycle volume extrapolation. Environ Data Sci. 2025 Jan;4:e13. doi:10.1017/eds.2025.5

18\. El Esawey M. Impact of data gaps on the accuracy of annual and monthly average daily bicycle volume calculation at permanent count stations. Comput Environ Urban Syst. 2018 Jul 1;70:125–37. doi:10.1016/j.compenvurbsys.2018.03.002

19\. Beitel D, McNee S, McLaughlin F, Miranda-Moreno LF. Automated Validation and Interpolation of Long-Duration Bicycle Counting Data. Transp Res Rec. 2018 Dec 1;2672(43):75–86. doi:10.1177/0361198118783123

20\. Skupień ET, Fierek S. Sources and Use of Bicycle Traffic Data in Research and Urban Mobility Management. Urban Sci. 2025 Apr;9(4):127. doi:10.3390/urbansci9040127

21\. Błażejczyk K, Jendritzky G, Bröde P, Fiala D, Havenith G, Epstein Y, Psikuta A, Kampmann B. An introduction to the Universal Thermal Climate Index (UTCI). Geogr Pol. 2013;86(1):5–10. doi:10.7163/GPol.2013.1

22\. Proulx F, Schneider R, Miranda-Moreno L. Performance Evaluation and Correction Functions for Automated Pedestrian and Bicycle Counting Technologies. J Transp Eng. 2016 Jan 6;142:04016002. doi:10.1061/(ASCE)TE.1943-5436.0000828

23\. Dharmaraju R, Noyce D, Lehman J. An evaluation of technologies for automated detection and classification of pedestrians and bicycles. Mass Highw Dep Rep. 2002 Jan 1.

24\. Rowangould G, Fox E, O’Brien R, Clarke J. CCRPC Bicycle Count Data Analysis and Count Program Design Strategies. 2022.

25\. Llaguno-Munitxa M, Bou-Zeid E. The environmental neighborhoods of cities and their spatial extent. Environ Res Lett. 2020 Jul;15(7):074034. doi:10.1088/1748-9326/ab8d7e

26\. Chollet F. Xception: Deep Learning with Depthwise Separable Convolutions. 2017 IEEE Conf Comput Vis Pattern Recognit CVPR. 2017 Jul;1800–7. doi:10.1109/CVPR.2017.195

27\. Llaguno-Munitxa M, Edwards M, Grade S, Vander Meulen M, Letesson C, Agudo Sierra E, Altomonte S, Lacroix E, Bogosian B, Mun K. 360° image and video urban scene immersions to evaluate the role of urban green infrastructure in stress level reduction. In: AUM2022 \[Internet\]. 2022 \[cited 2024 Feb 4\]. Available from: https://dial.uclouvain.be/pr/boreal/object/boreal:262922

28\. Li X, Zhang C, Li W, Ricard R, Meng Q, Zhang W. Assessing street-level urban greenery using Google Street View and a modified green view index. Urban For Urban Green. 2015 Jan 1;14(3):675–85. doi:10.1016/j.ufug.2015.06.006

29\. Paradigm Brussels. Brussels-Capital Region \[Internet\]. 2025 \[cited 2025 Dec 27\]. Transport, Mobility. Available from: https://be.brussels/en/transport-mobility

30\. Lindberg F, Holmer B, Thorsson S. SOLWEIG 1.0 – Modelling spatial variations of 3D radiant fluxes and mean radiant temperature in complex urban settings. Int J Biometeorol. 2008 Sep 1;52(7):697–713. doi:10.1007/s00484-008-0162-7

31\. Höppe P. A new procedure to determine the mean radiant temperature outdoors. Wetter Leben. 1992;44:147–51.

32\. Tartarini F, Schiavon S. pythermalcomfort: A Python package for thermal comfort research. SoftwareX. 2020 Jul 1;12:100578. doi:10.1016/j.softx.2020.100578

33\. Rousseeuw PJ. Silhouettes: A graphical aid to the interpretation and validation of cluster analysis. J Comput Appl Math. 1987 Nov 1;20:53–65. doi:10.1016/0377-0427(87)90125-7

34\. C. F. Gauss. Theoria motus corporum coelestium in sectionibus conicis solem ambientium \[Internet\]. 1809 \[cited 2026 Apr 13\]. 269 p. Available from: http://archive.org/details/bub_gb_ORUOAAAAQAAJ

35\. Stigler SM. Gauss and the Invention of Least Squares. Ann Stat. 1981;9(3):465–74.

36\. Kohavi R. A study of cross-validation and bootstrap for accuracy estimation and model selection. In: Ijcai \[Internet\]. Montreal, Canada; 1995 \[cited 2026 Apr 15\]. p. 1137–45. Available from: https://www.researchgate.net/profile/Ron-Kohavi/publication/2352264_A_Study_of_Cross-Validation_and_Bootstrap_for_Accuracy_Estimation_and_Model_Selection/links/02e7e51bcc14c5e91c000000/A-Study-of-Cross-Validation-and-Bootstrap-for-Accuracy-Estimation-and-Model-Selection.pdf

37\. Stone M. Cross-Validatory Choice and Assessment of Statistical Predictions. J R Stat Soc Ser B Stat Methodol. 1974 Jan 1;36(2):111–33. doi:10.1111/j.2517-6161.1974.tb00994.x

38\. NICOLET M. Royal Meteorological Institute of Belgium. Geophys Res Pap. 1952;263.

39\. Hersbach H, Bell B, Berrisford P, Hirahara S, Horányi A, Muñoz-Sabater J, Nicolas J, Peubey C, Radu R, Schepers D, Simmons A, Soci C, Abdalla S, Abellan X, Balsamo G, Bechtold P, Biavati G, Bidlot J, Bonavita M, De Chiara G, Dahlgren P, Dee D, Diamantakis M, Dragani R, Flemming J, Forbes R, Fuentes M, Geer A, Haimberger L, Healy S, Hogan RJ, Hólm E, Janisková M, Keeley S, Laloyaux P, Lopez P, Lupu C, Radnoti G, de Rosnay P, Rozum I, Vamborg F, Villaume S, Thépaut JN. The ERA5 global reanalysis. Q J R Meteorol Soc. 2020;146(730):1999–2049. doi:10.1002/qj.3803

40\. Inness A, Ades M, Agustí-Panareda A, Barré J, Benedictow A, Blechschmidt AM, Dominguez JJ, Engelen R, Eskes H, Flemming J, Huijnen V, Jones L, Kipling Z, Massart S, Parrington M, Peuch VH, Razinger M, Remy S, Schulz M, Suttie M. The CAMS reanalysis of atmospheric composition. Atmospheric Chem Phys. 2019 Mar 20;19(6):3515–56. doi:10.5194/acp-19-3515-2019

41\. Schoolvakanties. Vlaanderen.be \[Internet\]. 2025 \[cited 2025 Dec 27\]. Schoolvakanties. Available from: https://www.vlaanderen.be/onderwijs-en-vorming/wat-mag-en-moet-op-school/schoolvakanties-vrije-dagen-en-afwezigheden/schoolvakanties

42\. Portal of the Wallonia-Brussels Federation. FW-B Portal - Portal of the Wallonia-Brussels Federation \[Internet\]. 2025 \[cited 2025 Dec 27\]. Available from: https://www.federation-wallonie-bruxelles.be/

43\. Cohen J. Statistical Power Analysis for the Behavioral Sciences. 2nd ed. New York: Routledge; 2013. 567 p. doi:10.4324/9780203771587

44\. railwaytraveller123. Brussels Midi/Zuid Station Guide: Trains, Facilities, Where to Eat. Railway Traveller \[Internet\]. 2020 Aug 18 \[cited 2026 Apr 14\]. Available from: https://railwaytraveller.com/station-guides/brussels-midi

45\. Institut Bruxellois de Statistique et d’Analyse (IBSA). Jette (Édition 2024). Région de Bruxelles-Capitale. \[Internet\]. 2024. Available from: https://www.vivalis.brussels/sites/default/files/2024-04/Jette_FR_cor.pdf

46\. Federation EEC. Ecf \[Internet\]. ecf.com; 2022 \[cited 2026 Apr 15\]. New studies, new plan: Brussels aims even higher after cycling grows by 20% and road fatalities decrease. Available from: https://www.ecf.com/en/news/new-studies-new-plan-brussels-aims-even-higher-after-cycling-grows-by-20-and-road-fatalities-decrease/

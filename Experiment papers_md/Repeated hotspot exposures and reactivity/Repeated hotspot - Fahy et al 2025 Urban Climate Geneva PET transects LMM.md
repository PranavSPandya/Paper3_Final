Urban Climate 61 (2025) 102460
Contents lists available at ScienceDirect
Urban Climate
journal homepage: www.elsevier.com/locate/uclim
Beyond land surface temperature: Identifying areas of daytime
thermal discomfort in cities by combining remote sensing and
field measurements
Julie C. Fahya,b, Christoph Bachofenc,d, Reto Camponovoe, Peter Gallinellie, Martin
A. Schlaepfera,*
aInstitute for Environmental Sciences, University of Geneva, Geneva, Switzerland
bEcology and Aquatic Systems Engineering Group, HEPIA, University of Applied Sciences and Arts Western Switzerland, Lullier, Switzerland
cPlant Ecology Research Laboratory PERL, School of Architecture, Civil and Environmental Engineering, EPFL, Lausanne, Switzerland
dFunctional Plant Ecology, Community Ecology Unit, Swiss Federal Institute for Forest, Snow and Landscape WSL, Lausanne, Switzerland
eEnvironment, Climate, Energy and Architecture Laboratory, HEPIA, University of Applied Sciences and Arts Western Switzerland, Geneva,
Switzerland
A R T I C L E I N F O A B S T R A C T
Keywords: Satellite images of land surface temperatures (LST) are commonly used to identify areas within
Generalised additive model cities most prone to diurnal thermal discomfort, but they may not reflect the experiences of pe-
Landsat destrians. Here, we developed predictive statistical models for Physiological Equivalent Tem-
Sentinel-2
perature (PET), an indicator of thermal discomfort, with easily accessible spatial predictors. For
Land surface temperature this, we measured PET (n =4472) along eight transects (range: 700–5000 m) using a multi-sensor
NDVI
Thermal comfort instrument in the urban fabric of Geneva, Switzerland during periods of summer heat. We par-
Urban heat island ametrised generalised additive models (GAM) and linear mixed models (LMM) with six commonly
Physiological equivalent temperature available predictor variables [solar energy, Local Climate Zone (LCZ), albedo, LST, Normalized
Difference Moisture Index (NDMI) and canopy cover]. We found that LST, alone, explained <2 % of
observed variation in PET, whereas the GAM with all the 6 predictor variables had R2 =0.43. LCZ
and solar energy explained most of the variability of PET across the city. PET values were lower in
the densely built city centre than in the peri-urban environment. LST is poorly correlated with air
temperature and PET in urban settings, and thus should not be used alone to predict outdoor
thermal discomfort.
1. Introduction
The air temperature in urban ecosystems is several degrees Celsius higher than in the non-urban environment (Urban Heat Island,
UHI)(Oke, 1982; Oke et al., 2017). The higher air temperatures are caused by large energy outputs from combustion engines and
energy-storing building materials that capture and subsequently release heat and trapped radiation (Stewart and Oke, 2012). Global
warming, combined with increased densification of urban centres, will likely exacerbate the magnitude of the UHI in the future (Kundu
and Pandey, 2020). This is expected to have occasional positive effects such as reduced heating needs and lower cold-related mortality
in winters, but also negative effects such as increased energy demand for cooling and thermal discomfort during summer heatwaves
* Corresponding author.
E-mail address: martin.schlaepfer@unige.ch(M.A. Schlaepfer).
https://doi.org/10.1016/j.uclim.2025.102460
Received 8 July 2024; Received in revised form 12 March 2025; Accepted 20 May 2025
Available online 28 May 2025
2212-0955/© 2025 The Authors. Published by Elsevier B.V. This is an open access article under the CC BY-NC license
(h ttp://creativecommons.org/licenses/by-nc/4.0/ ).

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
(Huang et al., 2023; Iungman et al., 2023).
The consequences of thermal discomfort during periods of prolonged heat can range from a mild nuisance to death, depending on
the severity of the phenomenon and the susceptibility of the individual (Armstrong et al., 2019; Ragettli et al., 2017). For instance, the
extreme 2003 heatwave led to an increase of 141 % mortality in Paris, whereas smaller towns in France had a 40 % excess mortality
(Dousset et al., 2011). A demographic shift towards elderly age-classes in numerous cities of industrialised countries (Anderson and
Hussey, 2000) is expected to make the urban population generally more vulnerable to thermal discomfort. Consequently, mitigation of
thermal discomfort has become a major public health issue (Armstrong et al., 2019; Ragettli et al., 2017).
Thermal discomfort includes the perceived physiological and psychological stress caused by heat. Several indices have been
developed to calculate thermal discomfort, such as the Universal Thermal Climate Index (UTCI Bro¨de et al., 2012; Fiala et al., 2012)
and the Physiological Equivalent Temperature (PET Ho¨ppe, 1999). The theoretical framework of thermal discomfort indices differ
slightly, but both rely on similar environmental factors (ambient air temperature, wind speed, solar radiance, and relative humidity)
and are strongly correlated with one another (Blazejczyk et al., 2012; Fang et al., 2019; Lai et al., 2020; Zare et al., 2018). Thermal
discomfort indices are, in theory, better suited for predicting the sub-lethal undesirable effects of heat than air temperature alone (Lai
et al., 2020; Zhang et al., 2014) but see (Armstrong et al., 2019) regarding the specific case of predicting heat-related mortality.
Cities are spatially heterogeneous with regard to thermal discomfort, and urban planners therefore will need to focus mitigation
efforts in neighbourhoods or micro-environments that generate the greatest thermal discomfort (Makido et al., 2019). Mean air
temperature and PET values can vary by >10 ◦C both across neighbourhoods and on smaller spatial scales (Klok et al., 2019; Liu et al.,
2018). Although indoor and nocturnal thermal discomfort likely also play an important role from a public health perspective
(Ormandy and Ezratty, 2016; van Hove et al., 2015), it will be useful, as a first step, to identify parts of a city that are most likely to
experience extreme thermal discomfort outdoors during the day.
Several environmental factors can potentially attenuate thermal discomfort in cities. Shading of solar irradiance can result in
decreases in 15–20 ◦C PET (Gulya´s et al., 2006; Klok et al., 2019) within a city depending on the extent of shading from buildings and
vegetation. Other studies have suggested that air temperature or thermal discomfort are positively correlated with materials with low
albedo (Santamouris, 2014), high air humidity (Shashua-Bar and Hoffman, 2000), low tree coverage (Bowler et al., 2010; Lehmann
et al., 2014; Shashua-Bar and Hoffman, 2000), the aspect-ratio of buildings (the height of buildings in relation to their spacing)
(Bartesaghi-Koc et al., 2019; Kakon et al., 2010), sky-view factor (He et al., 2015) and the proportion of sealed surfaces (Lehmann
et al., 2014). Missing, to date, is a relatively simple, spatially explicit statistical model that integrates key predictors of thermal
discomfort over an entire urban area and that can be potentially implemented by non-specialists.
Land surface temperature (LST) has been proposed a suitable urban indicator with a “direct relationship with human health and
living comfort” (Chaudhuri and Kumar, 2020). LST is calculated from radiation measured by satellite, is freely available, regularly
updated and presents the advantage of covering entire cities. It has therefore been frequently used as a proxy for urban air temper-
atures and thermal discomfort (Chaudhuri and Kumar, 2020; Deilami et al., 2018; Tomlinson et al., 2011; Venter et al., 2020; Weng
et al., 2004). For instance, among the 75 studies on UHI reviewed by Deilami et al. (2018), 44 % used satellite-derived LST alone to
characterise the UHI effect. LST has also been used to measure the putative effects of different types of vegetation on air temperature
(Schwaab et al., 2020) and along with surface albedo and imperviousness or urban density as a proxy for thermal comfort
(Chrysoulakis et al., 2014). A theoretical limitation is that LST only accounts for surface radiation (Voogt and Oke, 2003). While
radiation can increase air temperatures above the surface, this effect quickly decreases within a few centimetres above the surface, so
that temperatures measured at human height are significantly lower than near-surface measurements (May and Oliphant, 2023). In
addition, a low spatial resolution of 100 m (downscaled to 30 m with Landsat 8) implies that measurements may be influenced by
adjacent rooftops, solar panels, or canopy tops, which could result in an overestimation of the temperature experienced by pedestrians
at street level (Kamath et al., 2023; Parlow et al., 2014).
To refine thermal climate predictions within urban settings the Local Climate Zones (LCZ) framework was developed (Stewart and
Oke, 2012). LCZ categories include 10 different built types that capture variation in density, height, and spacing of buildings. These
categories can be further sub-divided into seven land-cover types that vary in extent and height of vegetation, extent of impervious
surfaces and presence of water (e.g., Oke et al., 2017). Although several studies have reported significant differences in mean air
temperature between LCZ categories (Alexander and Mills, 2014; Aminipouri et al., 2019; Geletiˇc et al., 2018; Liu et al., 2018; Stewart
et al., 2014) the ranking of LCZ categories by mean temperature have been inconsistent. LCZ categories are quantified at the scale of
city blocks, and as such, indirectly capture the effects of vegetation, impervious surfaces, etc. at a larger scale (e.g., the cumulative
cooling effects that arise from high tree density in each neighbourhood).
Here, we question whether LST and LCZ estimates, alone, are sufficient to predict PET within an urbanised setting, and assess the
extent to which available remote sensing information [albedo, Normalized Difference Moisture Index (NDMI), Normalized Difference
Vegetation Index (NDVI), canopy cover, surface imperviousness, and solar energy] can improve such PET predictions. To test this, we
developed spatially explicit regression models of thermal discomfort by leveraging detailed, publicly available geospatial information
for the city of Geneva (Switzerland) and fine-scale field measurements of climate variables necessary to calculate PET. The goal was
therefore to generate a spatially explicit representation of PET that will indicate which parts of the city are typically the most likely to
generate situations of thermal discomfort.
2

J.C. Fahy et al.                                                                                                                                                                                   U   r b a  n    C  l i m   a t e    61 (2025) 102460
Fig. 1. A. Portable climate station; B. Study area, with the location of transects (black lines), LCZ categories (described in Table 3) and the position
of Geneva (arrow pointing to red dot) and Switzerland (black outline) within Europe (inset). (For interpretation of the references to colour in this
figure legend, the reader is referred to the web version of this article.)
Table 1
Transect characteristics.
Transect Date Start time End time Length (m) Min PET (◦C) Max PET (◦C)
| Acacias-Aire | 13.06.19 | 13:10 | 14:15 | 5849   | 23.2 | 35.9 |
| ------------ | -------- | ----- | ----- | ------ | ---- | ---- |
| Bastions     | 26.07.18 | 16:44 | 17:18 | 1916   | 29   | 48.6 |
| EV-Cologny   | 13.06.19 | 11:26 | 12:30 | 5760   | 16.5 | 33.3 |
| Fontaines    | 27.07.18 | 14:16 | 15:17 | 10,347 | 23.8 | 41.8 |
| Parcs        | 26.07.18 | 14:30 | 15:13 | 2581   | 25.9 | 40.8 |
| Plainpalais  | 26.07.18 | 16:45 | 17:18 | 2164   | 28.7 | 47.2 |
| StJean       | 19.07.18 | 14:42 | 16:38 | 4746   | 24.8 | 42.8 |
| StJean       | 20.07.18 | 13:10 | 14:25 | 4400   | 25.1 | 40.9 |
| Vernets      | 27.07.18 | 14:08 | 14:54 | 4650   | 23.0 | 43.4 |
| Vernets      | 08.08.18 | 13:31 | 14:36 | 4119   | 25.8 | 43.0 |
2. Methods
2.1. Study area
The study area focuses on the urban component of Geneva, Switzerland (46◦12′ N, 6◦09′ E). The climate in Geneva is a temperate
oceanic climate (Ko¨ppen classification: Cfb) with cool winters and warm summers (mean annual temperature: 11.0 ◦C, mean annual
precipitation 946 mm, years 1991–2020, Cointrin weather station, www.meteosuisse.admin.ch). The city is located where the Rhone
River exits Lake Geneva and is surrounded by low mountain ranges to the north, west and south. The city centre is characterised by the
old town, with narrow shaded cobbled streets, and by a peri-urban ring composed of more recent neighbourhoods with residential and
business buildings, small parks and a limited number of large open areas.
2.2. Field and remote sensing data
2.2.1. Field assessments of thermal discomfort
We calculated the thermal discomfort based on fine-scale measurements of air temperature (Tair), relative air humidity (RH),
surface temperature (Tsurf), solar energy (Gh) and windspeed (WS) that were collected with a portable climate station, the
microclimate-meter (Table S1, Fig. 1). Details regarding sensors are found in the Supplementary Materials and Gallinelli et al. (2017).
3

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
Table 2
Source and spatial resolution of all nine explanatory variables initially considered for PET.
Variable Source Unit [range] Spatial resolution (m)
Albedo Estimation with Sentinel-2 unitless [0,1] 20
Mean summer LST Estimation with data from Landsat 8 ◦C [20, 44] 30 (resampled from 100
m)
Normalized Difference Moisture Index Estimation with data from Sentinel-2 Unitless [(cid:0) 1,1] 20
(NDMI)
Normalized Difference Vegetation Index Estimation with data from Sentinel-2 Unitless [(cid:0) 1,1] 20
(NDVI)
Percentage of canopy cover per 100 m2 Local canopy model obtained from LiDAR % [0(cid:0) 100] 10
Percentage of impervious surfaces per 100 Public GIS repository (https://ge.ch/sitg/) % [0–100] 10
m2
Solar energy (sum of irradiance in July) Public GIS repository (https://ge.ch/sitg/) kWh m(cid:0)2 [0, 188] 0.5
Local Climate Zones (LCZ) Manually designated using the typology by Stewart and Oke Categorical (n = 0.02–67 ha
(2012) 9)
Table 3
LCZ Number, LCZ types defined in Stewart and Oke (2012), and the corresponding surface area in the study perimeter, Geneva Switzerland.
Number LCZ type Descriptor Sum of surfaces (ha; % total)
1 A +G Dense trees and Water 141 (7.59)
2 B +BC +BD Scattered trees; Scattered trees, bush and shrub; Scattered trees and low plants 72 (3.90)
3 D +C Low plants; Shrub and scrub 8 (0.42)
4 9 Sparsely built 186 (10.01)
5 6 +8D Open low-rise; Large low-rise and low plants 126 (6.78)
6 5 +2 A+2B Open mid-rise; Compact mid-rise and dense trees; Compact mid-rise and scattered trees 786 (42.29)
7 4 Open high-rise 6 (0.30)
8 1 +2 Compact high-rise; Compact mid-rise 363 (19.50)
9 8 +E Large low-rise; Bare rock or paved 171 (9.21)
Sensor measurements took place each second (i.e., roughly once per meter at a walking pace) to provide a detailed spatial repre-
sentation of area on the scale of the street to the neighbourhood. Measurements were collected along eight transects across the city of
Geneva during hot summer days in 2018 and 2019, between midday and 5 pm (Fig. 1,
Table 1) and lasted roughly 1–1.5 h each. Some transects were spatially similar but walked on different days to capture within-site
variability.
As an index for thermal discomfort, we selected the Physiological Equivalent Temperature (PET), which has been used in a variety
of situations and regions (Potchter et al., 2018; Walther and Goestchel, 2018) and shows good correspondence between simulations
and ground truthing (Coccolo et al., 2016). The PET index was calculated based on Ho¨ppe (Ho¨ppe, 1999; Sadeghipour Roudsari, 2024)
for an average middle-aged (40 yrs., 1 m80) man walking along the street in summer clothes.
2.2.2. Remote sensing data
As spatial predictors of PET we selected eight remote sensing variables that (i) had supporting evidence of a functional link with
thermal discomfort and ii) covered the entire urban area of the centre of Geneva (Table 2, and see maps of each indicator Fig. S1).
Details on data acquisition and methodological choices for each geospatial layer is provided in the Supplementary Materials (Notes
S1). LST is the mean value of satellite measurements made on 14 cloudless, warm summer days, always at 12 h22, which falls within
the range of transect times (11 h26-17 h18). LST is thus an asynchronous, spatially explicit predictor and we assume that the spatial
variation in PET remains constant between 11 h26 and 17 h18. Local climate zones (LCZ) were generated for the entire canton of
Geneva following Stewart and Oke (2012). 18 LCZ types were initially identified in the study area. Following Liu et al. (2018), some
LCZ categories were merged based on their similar phenotypes or shared thermal properties to limit the number of categories (Table 3).
The variable Solar Energy is the output of an independent 3D model that captures in the influence of topography, slope, standing
vegetation and buildings. Thus, it captures the key role of shading (Supplementary Materials, Note S1).
Explanatory variables were prepared in ArcGIS Pro (Version 2.5.1) to be combined into a table with an output resolution of 10 m to
be later used for the prediction of PET over the entire study area. Values from all raster data were extracted onto points forming a
10*10 m grid. For each raster, the value of the unique cell in which the grid point was located was attributed to that point. All variables
were linearly interpolated to downscale to a 10 m resolution. Evapotranspiration (from MODIS) was not integrated because it was
considered unreliable in urban environments.
2.3. PET predictions using regression models
To predict PET across the urban component of Geneva, we parametrised Generalised Additive Models (GAMs) and Linear Mixed
Models (LMMs) of measured PET with the remote sensing data using R functions gam and lmer, respectively (R core team, 2023). GAMs
4

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
Table 4
Summary of Goodness-of-Fit for General Additive Models (GAMs) to predict Physiological Equivalent Temperature (PET).
Model Name Variables Goodness-of-Fit
R2 RMSE Percent Bias NS efficiency
Selected GAM Fixed effects: Albedo, Canopy Cover, Solar Energy, LST, NDMI, LCZ 42.8 % 3.57 0.01 0.36
Random effects: Date, Transect
Easy access GAM Fixed effects: Albedo, LST, NDMI, LCZ 41 % 3.65 0.01 0.33
Random effects: Date, Transect
LCZ GAM Fixed effect: LCZ 34.7 % 3.78 0.01 0.28
Random effects: Date, Transect
LST GAM Fixed effect: LST 30.5 % 3.77 0.01 0.28
Random effects: Date, Transect
Selected LMM Fixed effects: Albedo, Canopy Cover, Solar Energy, LST, NDMI, LCZ fixed effects: 11.1 % 3.61 0.01 0.34
Random effects: Date, Transect random effects: 48.0 %
Easy access LMM Fixed effects: Albedo, LST, NDMI, LCZ fixed effects: 9.3 % 3.66 0.01 0.33
Random effects: Date, Transect random effects: 47.1 %
LCZ LMM Fixed effect: LCZ fixed effects: 5.4 % 3.78 0.01 0.28
Random effects: Date, Transect random effects: 45.9 %
LST LMM Fixed effect: LST fixed effects: <1 % 3.77 0.01 0.28
Random effects: Date, Transect random effects: 41.9 %
allow for non-linear relationships between predictor variables and the measured PET. To limit overfitting, we restricted the degrees of
freedom for the regression spline to k =4. Linear mixed models (LMMs) may explain less of the observed variation if relationships are
non-linear, but they present the advantage that parameters can be provided for predictive equations. For both GAM and LMM we used
the same predictors and model structure, except for Albedo, which was log-transformed for the LMM to reduce the heteroscedasticity.
LCZ categories were treated as non-ordered factors. The variables Transect and Date were used as random effects to account for dif-
ferences in meteorological conditions. Moreover, we examined if the addition of tensor splines that account for spatial autocorrelation
between measurements improved the prediction. The R function yhat was used for variance partitioning of predictor variables (Ray-
Mukherjee et al., 2014).
As the highest resolution of remote sensing data was 10 m (Table 2), we averaged the measured PET to the same spatial resolution.
This resulted in 4472 observations of PET across all transects. We used a random sample of 80 % of the measured PET for parametrising
the regression models, and the remaining 20 % for validation.
Four a priori models were compared: a full model composed of all the significant predictor variables after model selection
(“Selected” model); a reduced model composed solely of predictor variables that are generally readily available via remote sensing
(“Easy-access” model); a model with only LCZ as predictor variable (“LCZ”) and a model with only LST as predictor variable (“LST”).
We performed model selection of the “Selected model” based on the AIC using the step function. The four models were compared with
the goodness of fit of the 20 % of validation data. As Goodness-of-Fit indicators, we used the percentage of bias between measured and
predicted PET, the nash-sutcliffe efficiency (NS efficiency) and the root mean squared error (RMSE). The NS efficiency ranges from -∞
to 1, with 1 being a perfect fit of predicted and measured PET, 0 indicating that the simulated data are as accurate as the mean of the
measured data, and values below 0 indicating that the predicted data are less accurate than the mean of the measured data. The spatial
prediction from each model was visually assessed for plausibility considering the authors' personal knowledge of the city's
microclimate.
3. Results
3.1. Thermal discomfort (PET) variation across the city
Across all transects, PET ranged from 16.5 to 48.6 ◦C and varied by 12.7–20.4 ◦C within transects (.
Table 1), indicating high variance of thermal discomfort within the urban centre of Geneva on any given day. Within transects, PET
measurements were highly correlated with air temperature measurements (mean across transects and dates: ρ =0.43) but only weakly
correlated with LST (ρ =0.06, Fig. S2).
3.2. GAM and LMM performance
The NDVI and the proportion of Impervious Surfaces did not significantly contribute to explaining the variability of PET during
model selection and were therefore removed from the GAM and LMM. NDVI was highly correlated with NDMI (ρ =0.51; Fig. S3),
which explained a higher fraction of the variability and was therefore selected for the model. As a result, the “Selected” model included
six predictor variables and the “Easy access” model four predictor variables (Table 4).
The Selected model (R2 =0.42) and Easy-access model (R2 =0.41) performed almost equally well in capturing the variation of PET
measured along the transects. The spatial representation of predicted PET values across the city are nearly identical (Table S2).
Validation with the 20 % of remaining PET measurements showed that the Selected model was able to predict PET relatively well (NS-
efficiency of 36 %), had an extremely low bias (1 %), and it had the lowest RMSE of all models (Table 4). The Goodness-of-Fit is slightly
5

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
Table 5
Variance partitioning of significant factors in Selected GAM model
of PET.
Factor Relative Importance [%]
LCZ 7.32
Solar Energy 3.58
Albedo 2.44
Canopy Cover 1.61
NDMI 1.54
LST 0.13
Fig. 2. Predicted PET over the range of the six explanatory variables (prediction standard error in grey) for the Selected GAM. The blue areas show
the density distribution of the predictors across their interval. Letters indicate pairwise comparisons of the effect of LCZ (p <0.05). Note that the y
axis differs for albedo and LCZ, and that LCZ category numbers differ from Stewart and Oke (2012)(see Table 3). (For interpretation of the ref-
erences to colour in this figure legend, the reader is referred to the web version of this article.)
lower in the Easy-access model, with a slightly lower NS-efficiency (33 %) and a slightly higher RMSE (3.65). By contrast, the models
with only LST and only LCZ perform relatively poorly (Table 4). Most of the variation was contained in the random effect for these last
two models.
Variance partitioning of the Selected GAM illustrates that PET is explained primarily by LCZ and Solar Energy in July. Albedo,
Canopy Cover and NDMI have a more modest explanatory power, whereas LST is marginal (Table 5).
3.3. Model structure: Random effects and tensor spline
As expected, the random effects Date and Transect explained a large proportion of the observed variability of PET in the GAM
models because they capture the important temporal and spatial variations in air temperature, humidity and radiation. The tensor
spline captured patterns of spatial autocorrelation and significantly improved the model fit of both the parametrisation and validation
data (R2 values were roughly 10 % higher), but visual inspection of its graphical representation strongly suggests that the tensor spline
overfit the data. Indeed, predicted values rapidly became unrealistic within the study perimeter with increased distance from sampled
transects (Table S3). We therefore did not include a tensor spline in the final model comparisons.
3.4. Relationship between measured PET and model predictors
The functional response curves of individual predictor variables generally match the expected theoretical relationship with PET (.
Fig. 2). PET correlates negatively with increasing Canopy Cover and NDMI, and correlates positively with Solar Energy in July. As
expected, LCZ 7 (Open High Rise) and 5 (Open Low Rise, Large Low Rise with low plants) were associated with high PET, whereas LCZ
8 (Compact High Rise and Compact Mid Rise) was associated with low PET (Fig. 4). LCZ 3 (Low Plants) had a large variation. LST
6

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
Fig. 3. Predicted Physiological equivalent temperature (PET) across the urban fabric of Geneva during daytime in summer using the “Selected”
GAM model. Letters refer to panels in Fig. 4.
correlates negatively with PET, which, at first glance, is unexpected and appears contradictory, but likely reflects that some of the
highest LST values occur in the old town where the satellite measurement may capture high roof-top temperatures, whereas PET at
pedestrian height within the narrow, shaded, cobble-stone roads is relatively cool. The functional response between Albedo and PET is
positive in the range of values where most observations occur, but then decreasing, somewhat surprisingly, with an increasing standard
error (Fig. 2).
3.5. Spatial predictions of PET in urban sections of Geneva
The PET predicted with the Selected GAM for the urban part of Geneva (.
Fig. 3) not only shows a good correspondence with field measurements along transects (Table S2), but also conforms with our
experience of the micro-climatic variations within the city. For example, PET is predicted to be relatively low in the narrow streets of
the old town (a), the dense Pˆaquis neighbourhood (b), and sections along the large Rhoˆne and Arve rivers (c). Conversely, PET values
are predicted to be relatively high in the large, unshaded, barren Plaine de Plainpalais (d), the industrial zone of La Praille (e), and
along the railway tracks near the main train station (f). The model also performs well at a smaller spatial scale: within a park (Parc des
Eaux-Vives, Fig. 5) it captures the relatively hot clay tennis courts (where Tomas Machac famously defeated Novak Djokovic on 24 May
2024) (g), a hot adjacent street (Quai Gustave Ador; h), relatively warm open, sunny lawn areas (i), and cool areas under the large trees
(j). PET within the Eaux-Vives park ranges from 27.3 to 37.3 ◦C (Fig. 5).
The Selected Model's spatial predictions yielded superior results to other simpler models (Fig. 6). The LCZ model is spatially coarse,
but qualitatively captures thermal discomfort at the scale of neighbourhoods (Fig. 6b). The LST Model has low statistical explanatory
power, which translates into reduced spatial variation of predicted PET relative to the Selected Model (Fig. 6a vs 6c). The LST Model
only captures the relative cool thermal comfort adjacent to the large rivers. Finally, LST satellite measurements reveal a pattern that
shares some similarity with the PET predicted by the Selected Model, notably in areas adjacent to the large rivers and areas composed
of mostly sealed surfaces, but also markedly divergent in other areas such as the old town (Fig. 6a vs 6d).
As expected, the spatial distribution of predicted PET from the Selected LMM is very similar to that of the GAM but with a lower
explanatory power (Table 4). Just as with the GAMs, PET correlated negatively with LST, NDMI and Canopy cover, and positively with
Albedo (Table 4, Table S5). The advantage of the LMM is that it provides an equation for predicting PET (R2 =47 %), allowing to
estimate PET for a city with similar structure as Geneva based on four readily available remote sensing variables (Albedo, LCZ, LST and
NDMI; Table S5).
7

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
Fig. 4. Predicted Physiological equivalent temperature (PET) in selected locations in the city of Geneva during daytime in summer: a) old town with
narrow streets, b) the dense Pˆaquis neighbourhood, c) the junction of the Rhone and Arve rivers, d) the large, unshaded, Plaine de Plainpalais, e) the
industrial zone of La Praille, and f) railways near the main train station.
Fig. 5. Predicted Physiological equivalent temperature (PET) in the Parc des Eaux-Vives in Geneva during daytime in summer, overlayed on spatial
features of the park. g) relatively hot tennis courts, h) hot adjacent street, i) warm open sunny lawns, j) cool areas under large trees.
4. Discussion
Reliable predictions of thermal discomfort in urban areas are becoming increasingly important as the fraction of elderly persons
increases, and cities are heating up due to densification and climate warming. Here, we show that the spatial variability of PET is large
and can be predicted with accuracy in an urban environment using easily accessible remote sensing data. The regression models were
constrained and validated using field data gathered with a novel multi-sensor, portable weather instrument that provides an improved
estimate of thermal discomfort over air temperature measurements.
The Selected GAM statistically explained the most variance and yielded credible prediction maps of PET in the urban sector for
Geneva. According to the variance partitioning, the LCZ and Solar Energy explained most of the observed variance. The predicted PET
in the city centre of Geneva, dominated by LCZ 8 (compact high- and mid-rise buildings, Fig. 4) was lower than in the surrounding
suburbs (Fig. 6a). Neighbourhoods with dense buildings thus provide the greatest thermal comfort during the day, outdoors (Shashua-
Bar et al., 2012), which contradicts the impression, solely based on LST measurements, that densely built-up urban centres are the
warmest and most uncomfortable locations within a city (Fig. 6d). The contrasts between PET (Fig. 6a) and LST (Fig. 6d) also illustrate
why LST should not be used to identify and prioritise places subject to diurnal thermal discomfort. For city planning purposes, this
8

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
Fig. 6. a) Physiological equivalent temperature (PET) based on the Selected GAM, b) predicted with LCZ alone, c) predicted with LST alone, d)
measured land surface temperature (LST; average of 14 summer dates, 2015–2018, calculated from Landsat 8 images) in the urban portion
of Geneva.
suggests that a key pathway for improving well-being in urban environments is increasing the amount of shade through increasing
building aspect ratio (building height: street width) (Klok et al., 2019; Lai et al., 2020) – as seen in the old city sections of Mediter-
ranean and North African cities (Negev et al., 2020; Shashua-Bar et al., 2012).
Canopy cover and NDMI (Fig. S1) also attenuate thermal discomfort (Table 4) (Klok et al., 2019; Lai et al., 2020; Negev et al., 2020;
Shashua-Bar et al., 2012). The variance partitioning of the Selected GAM model, however, indicates that in Geneva vegetation provides
a significant but modest effect on attenuating thermal discomfort, in addition to shading. This suggests that the recent push to increase
9

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
the total canopy cover within urban centres will likely help attenuate diurnal thermal comfort while simultaneously adding ecosystem
services associated with trees, such as biodiversity support, micro-pollutant interception, reduction of soil erosion and cultural values
(Schlaepfer et al., 2020). From a strictly thermal perspective, however, an urban structure with High (>25 m tall) to Medium (10-25 m
tall) buildings (Stewart and Oke, 2012) in close proximity to one another may yield greater results. Our results confirm that areas with
low shade due to an absence of building or tall trees do not provide relief from daytime thermal discomfort, even in the presence of low
vegetation (LCZ 3, Fig. 2)(Klok et al., 2019).
The transects used to collect the PET data were not designed for the purpose of capturing the full variation of PET across the urban
fabric and did not include the full urban-rural gradient. Future studies should take care to stratify transects both across and within the
most prevalent LCZ types of a given city and a greater diversity of non-urban habitats, and across multiple city morphologies. Indeed,
we currently do not know the extent to which these results can be applied to other European and non-European cities. As remote
sensing data become increasingly readily available (Skidmore et al., 2021; Vihervaara et al., 2017) field data that can calibrate and
validate models will become the limiting factor for developing robust models that can be applied more broadly. It will also be
interesting to cross-validate such results with outputs from models predicting urban heat based on physical parameters (e.g., SOLWEIG
or ENVI-met).
5. Conclusions
Our study shows that thermal discomfort (PET) can be modelled from readily available remote sensing information. Our statistical
analyses show that Local Climate Zones (LCZ) and solar energy are the strongest predictors of thermal discomfort (Table 5). LCZ
categories incorporate building topography (spacing, height) and the presence of vegetation, so the effects of LCZ are partially
confounded with those of Solar Energy, NDMI and Canopy Cover. But globally our results suggest that shading, of any origin, is a key
component to reducing thermal discomfort. Importantly, LST (both as direct measurements and as a predictor variable) is poorly
correlated with daytime outdoor PET (Fig. 6). Even in full models where LST is a significant predictor, its relative contribution is
modest (less than 1 % of variance partitioning, Table 5) and the weakest of all predictors. LST captures the first encountered surface by
satellites, including roof tops and tree canopies. As such, LST measures occasionally do not capture the thermal experience of pe-
destrians. Our assessment is that LST should not be used to identify neighbourhoods with the highest daytime outdoor thermal
discomfort (Fig. 6). In the absence of field measurements, authorities can use linear mixed models based on remote sensing predictors
(Solar Energy, Albedo, Canopy Cover, NDMI and LST) and proxies such as LCZ (Table S5) to target neighbourhoods or micro-
environments for remedial measures against thermal discomfort.
CRediT authorship contribution statement
Julie C. Fahy: Writing – review & editing, Writing – original draft, Visualization, Methodology, Formal analysis, Data curation.
Christoph Bachofen: Writing – review & editing, Visualization, Formal analysis. Reto Camponovo: Writing – review & editing,
Validation, Funding acquisition, Data curation, Conceptualization. Peter Gallinelli: Writing – review & editing, Software, Data
curation. Martin A. Schlaepfer: Writing – review & editing, Validation, Project administration, Methodology, Funding acquisition,
Conceptualization.
Funding
This work was supported by the Swiss Federal Office for the Environment, which provided funding for this work through the project
COOL-CITY as part of the pilot programme “Adaptation to Climate Change”. Additional financial support was provided by the Office of
Agriculture and Nature (canton of Geneva).
Declaration of competing interest
The authors declare that they have no known competing financial interests or personal relationships that could have appeared to
influence the work reported in this paper.
Acknowledgements
We sincerely thank three anonymous reviewers for their constructive comments. We would like to thank Jos´e Ferro Pinto for taking
part in field data collection on the two synchronous transects in June 2019. We also thank Benjamin Guinaudeau for his technical help
with accessing satellite data and Tess Figols for the photo of the mobile weather station. Artificial Intelligence tools were not used in
analyses of the data nor in the writing of this manuscript.
Appendix A. Supplementary data
Supplementary data to this article can be found online at https://doi.org/10.1016/j.uclim.2025.102460.
10

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
Data availability
Field measurements used to generate PET along transects will be made available on a data repository. All remote sensing data is
publicly available.
References
Alexander, P., Mills, G., 2014. Local climate classification and Dublin’s urban Heat Island. Atmosphere 5, 755–774. https://doi.org/10.3390/atmos5040755.
Aminipouri, M., Rayner, D., Lindberg, F., Thorsson, S., Knudby, A.J., Zickfeld, K., Middel, A., Krayenhoff, E.S., 2019. Urban tree planting to maintain outdoor thermal
comfort under climate change: the case of Vancouver’s local climate zones. Build. Environ. 158, 226–236. https://doi.org/10.1016/j.buildenv.2019.05.022.
Anderson, G.F., Hussey, P.S., 2000. Population aging: a comparison among industrialized countries. Health Aff. 19, 191–203. https://doi.org/10.1377/
hlthaff.19.3.191.
Armstrong, B., et al., 2019. The role of humidity in associations of high temperature with mortality: a multicountry, multicity study. Environ. Health Perspect. 127,
097007. https://doi.org/10.1289/EHP5430.
Bartesaghi-Koc, C., Osmond, P., Peters, A., 2019. Mapping and classifying green infrastructure typologies for climate-related studies based on remote sensing data.
Urban For. Urban Green. 37, 154–167. https://doi.org/10.1016/j.ufug.2018.11.008.
Blazejczyk, K., Epstein, Y., Jendritzky, G., Staiger, H., Tinz, B., 2012. Comparison of UTCI to selected thermal indices. Int. J. Biometeorol. 56, 515–535. https://doi.
org/10.1007/s00484-011-0453-2.
Bowler, D.E., Buyung-Ali, L., Knight, T.M., Pullin, A.S., 2010. Urban greening to cool towns and cities: a systematic review of the empirical evidence. Landsc. Urban
Plan. 97, 147–155. https://doi.org/10.1016/j.landurbplan.2010.05.006.
Bro¨de, P., Fiala, D., Błaz˙ejczyk, K., Holm´er, I., Jendritzky, G., Kampmann, B., Tinz, B., Havenith, G., 2012. Deriving the operational procedure for the universal
thermal climate index (UTCI). Int. J. Biometeorol. 56, 481–494. https://doi.org/10.1007/s00484-011-0454-1.
Chaudhuri, S., Kumar, A., 2020. Evaluating the contribution of urban ecosystem services in regulating thermal comfort. Spat. Inf. Res. 29, 71–82. https://doi.org/
10.1007/s41324-020-00336-8.
Chrysoulakis, N., et al., 2014. A conceptual list of indicators for urban planning and management based on earth observation. ISPRS Int. J. Geo Inf. 3, 980–1002.
https://doi.org/10.3390/ijgi3030980.
Coccolo, S., Ka¨mpf, J., Scartezzini, J.-L., Pearlmutter, D., 2016. Outdoor human comfort and thermal stress: a comprehensive review on models and standards. Urban
Clim. 18, 33–57. https://doi.org/10.1016/j.uclim.2016.08.004.
Deilami, K., Kamruzzaman, M., Liu, Y., 2018. Urban heat island effect: a systematic review of spatio-temporal factors, data, methods, and mitigation measures. Int. J.
Appl. Earth Obs. Geoinf. 67, 30–42. https://doi.org/10.1016/j.jag.2017.12.009.
Dousset, B., Gourmelon, F., Laaidi, K., Zeghnoun, A., Giraudet, E., Bretin, P., Mauri, E., Vandentorren, S., 2011. Satellite monitoring of summer heat waves in the Paris
metropolitan area. Int. J. Climatol. 31, 313–323. https://doi.org/10.1002/joc.2222.
Fang, Z., Feng, X., Liu, J., Lin, Z., Mak, C.M., Niu, J., Tse, K.-T., Xu, X., 2019. Investigation into the differences among several outdoor thermal comfort indices against
field survey in subtropics. Sustain. Cities Soc. 44, 676–690. https://doi.org/10.1016/j.scs.2018.10.022.
Fiala, D., Havenith, G., Bro¨de, P., Kampmann, B., Jendritzky, G., 2012. UTCI-Fiala multi-node model of human heat transfer and temperature regulation. Int. J.
Biometeorol. 56, 429–441. https://doi.org/10.1007/s00484-011-0424-7.
Gallinelli, P., Camponovo, R., Guillot, V., 2017. CityFeel - micro climate monitoring for climate mitigation and urban design. Energy Procedia 122, 391–396. https://
doi.org/10.1016/j.egypro.2017.07.427.
Geletiˇc, J., Lehnert, M., Savi´c, S., Miloˇsevi´c, D., 2018. Modelled spatiotemporal variability of outdoor thermal comfort in local climate zones of the city of Brno, Czech
Republic. Sci. Total Environ. 624, 385–395. https://doi.org/10.1016/j.scitotenv.2017.12.076.
Guly´as, A ´ ., Unger, J., Matzarakis, A., 2006. Assessment of the microclimatic and human comfort conditions in a complex urban environment: modelling and
measurements. Build. Environ. 41, 1713–1722. https://doi.org/10.1016/j.buildenv.2005.07.001.
He, X., Miao, S., Shen, S., Li, J., Zhang, B., Zhang, Z., Chen, X., 2015. Influence of sky view factor on outdoor thermal environment and physiological equivalent
temperature. Int. J. Biometeorol. 59, 285–297. https://doi.org/10.1007/s00484-014-0841-5.
Ho¨ppe, P., 1999. The physiological equivalent temperature – a universal index for the biometeorological assessment of the thermal environment. Int. J. Biometeorol.
43, 71–75. https://doi.org/10.1007/s004840050118.
Huang, W.T.K., Masselot, P., Bou-Zeid, E., Fatichi, S., Paschalis, A., Sun, T., Gasparrini, A., Manoli, G., 2023. Economic valuation of temperature-related mortality
attributed to urban heat islands in European cities. Nat. Commun. 14, 7438. https://doi.org/10.1038/s41467-023-43135-z.
Iungman, T., et al., 2023. Cooling cities through urban green infrastructure: a health impact assessment of European cities. Lancet. https://doi.org/10.1016/S0140-
6736(22)02585-5.
Kakon, A.N., Nobuo, M., Kojima, S., Yoko, T., 2010. Assessment of thermal comfort in respect to building height in a high-Density City in the tropics. Am. J. Eng. Appl.
Sci. 3. https://doi.org/10.3844/ajeassp.2010.545.551.
Kamath, H.G., Martilli, A., Singh, M., Brooks, T., Lanza, K., Bixler, R.P., Coudert, M., Yang, Z.-L., Niyogi, D., 2023. Human heat health index (H3I) for holistic
assessment of heat hazard and mitigation strategies beyond urban heat islands. Urban Clim. 52, 101675. https://doi.org/10.1016/j.uclim.2023.101675.
Klok, L., Rood, N., Kluck, J., Kleerekoper, L., 2019. Assessment of thermally comfortable urban spaces in Amsterdam during hot summer days. Int. J. Biometeorol. 63,
129–141. https://doi.org/10.1007/s00484-018-1644-x.
Kundu, D., Pandey, A.K., 2020. World urbanisation: Trends and patterns. In: Kundu, D., Sietchiping, R., Kinyanjui, M. (Eds.), Developing National Urban Policies:
Ways Forward to Green and Smart Cities (10.1007/978-981-15-3738-7_2). Springer Nature Singapore, pp. 13–49. https://doi.org/10.1007/978-981-15-3738-7_
2.
Lai, D., Lian, Z., Liu, W., Guo, C., Liu, W., Liu, K., Chen, Q., 2020. A comprehensive review of thermal comfort studies in urban open spaces. Sci. Total Environ. 742,
140092. https://doi.org/10.1016/j.scitotenv.2020.140092.
Lehmann, I., Mathey, J., Rossler, S., Brauer, A., Goldberg, V., 2014. Urban vegetation structure types as a methodological approach for identifying ecosystem services -
application to the analysis of micro-climatic effects. Ecol. Indic. 42, 58–72. https://doi.org/10.1016/j.ecolind.2014.02.036.
Liu, L., Lin, Y., Xiao, Y., Xue, P., Shi, L., Chen, X., Liu, J., 2018. Quantitative effects of urban spatial characteristics on outdoor thermal comfort based on the LCZ
scheme. Build. Environ. 143, 443–460. https://doi.org/10.1016/j.buildenv.2018.07.019.
Makido, Y., Hellman, D., Shandas, V., 2019. Nature-based designs to mitigate urban heat: the efficacy of green infrastructure treatments in Portland, Oregon.
Atmosphere 10, 282. https://doi.org/10.3390/atmos10050282.
May, S., Oliphant, A.J., 2023. Characteristics of the park cool island in Golden Gate Park, San Francisco. Theor. Appl. Climatol. 151, 1269–1282. https://doi.org/
10.1007/s00704-022-04296-x.
Negev, M., Khreis, H., Rogers, B.C., Shaheen, M., Erell, E., 2020. City design for health and resilience in hot and dry climates. BMJ 371, m3000. https://doi.org/
10.1136/bmj.m3000.
Oke, T.R., 1982. The energetic basis of the urban heat island. Q. J. R. Meteorol. Soc. 108, 1–24. https://doi.org/10.1002/qj.49710845502.
Oke, T.R., Mills, G., Christen, A., Voogt, J.A., 2017. Urban Climates. Cambridge University Press. https://doi.org/10.1017/9781139016476.
Ormandy, D., Ezratty, V., 2016. Thermal discomfort and health: protecting the susceptible from excess cold and excess heat in housing. Adv. Build. Energy Res. 10,
84–98. https://doi.org/10.1080/17512549.2015.1014845.
Parlow, E., Vogt, R., Feigenwinter, C., 2014. The urban heat island of Basel – seen from different perspectives. DIE ERDE – J. Geograph. Soc. Berlin 145, 96–110.
https://doi.org/10.12854/erde-145-8.
11

J.C. Fahy et al. U r b a n C l i m a t e 61 (2025) 102460
Potchter, O., Cohen, P., Lin, T.-P., Matzarakis, A., 2018. Outdoor human thermal perception in various climates: a comprehensive review of approaches, methods and
quantification. Sci. Total Environ. 631-632, 390–406. https://doi.org/10.1016/j.scitotenv.2018.02.276.
R Core Team, 2023. R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing.
Ragettli, M.S., Vicedo-Cabrera, A.M., Schindler, C., Ro¨o¨sli, M., 2017. Exploring the association between heat and mortality in Switzerland between 1995 and 2013.
Environ. Res. 158, 703–709. https://doi.org/10.1016/j.envres.2017.07.021.
Ray-Mukherjee, J., Nimon, K., Mukherjee, S., Morris, D.W., Slotow, R., Hamer, M., 2014. Using commonality analysis in multiple regressions: a tool to decompose
regression effects in the face of multicollinearity. Methods Ecol. Evol. 5, 320–328. https://doi.org/10.1111/2041-210X.12166.
Sadeghipour Roudsari, M., 2024. PET Comfort. Retrieved 12 june 2024 from. https://docs.ladybug.tools/ladybug-primer/components/1_analyzedata/pet_comfort.
Santamouris, M., 2014. Cooling the cities – a review of reflective and green roof mitigation technologies to fight heat island and improve comfort in urban
environments. Sol. Energy 103, 682–703. https://doi.org/10.1016/j.solener.2012.07.003.
Schlaepfer, M.A., Guinaudeau, B.P., Martin, P., Wyler, N., 2020. Quantifying the contributions of native and non-native trees to a city’s biodiversity and ecosystem
services. Urban For. Urban Green. 56, 126861. https://doi.org/10.1016/j.ufug.2020.126861.
Schwaab, J., Davin, E.L., Bebi, P., Duguay-Tetzlaff, A., Waser, L.T., Haeni, M., Meier, R., 2020. Increasing the broad-leaved tree fraction in European forests mitigates
hot temperature extremes. Sci. Rep. 10, 14153. https://doi.org/10.1038/s41598-020-71055-1.
Shashua-Bar, L., Hoffman, M.E., 2000. Vegetation as a climatic component in the design of an urban street: an empirical model for predicting the cooling effect of
urban green areas with trees. Energ. Buildin. 31, 221–235. https://doi.org/10.1016/S0378-7788(99)00018-3.
Shashua-Bar, L., Tsiros, I.X., Hoffman, M., 2012. Passive cooling design options to ameliorate thermal comfort in urban streets of a Mediterranean climate (Athens)
under hot summer conditions. Build. Environ. 57, 110–119. https://doi.org/10.1016/j.buildenv.2012.04.019.
Skidmore, A.K., et al., 2021. Priority list of biodiversity metrics to observe from space. Nat. Ecol. Evol. https://doi.org/10.1038/s41559-021-01451-x.
Stewart, I.D., Oke, T.R., 2012. Local climate zones for urban temperature studies. Bull. Am. Meteorol. Soc. 93, 1879–1900. https://doi.org/10.1175/bams-d-11-
00019.1.
Stewart, I.D., Oke, T.R., Krayenhoff, E.S., 2014. Evaluation of the ‘local climate zone’ scheme using temperature observations and model simulations. Int. J. Climatol.
34, 1062–1080. https://doi.org/10.1002/joc.3746.
Tomlinson, C.J., Chapman, L., Thornes, J.E., Baker, C., 2011. Remote sensing land surface temperature for meteorology and climatology: a review. Meteorol. Appl. 18,
296–306. https://doi.org/10.1002/met.287.
van Hove, L.W.A., Jacobs, C.M.J., Heusinkveld, B.G., Elbers, J.A., van Driel, B.L., Holtslag, A.A.M., 2015. Temporal and spatial variability of urban heat island and
thermal comfort within the Rotterdam agglomeration. Build. Environ. 83, 91–103. https://doi.org/10.1016/j.buildenv.2014.08.029.
Venter, Z.S., Krog, N.H., Barton, D.N., 2020. Linking green infrastructure to urban heat and human health risk mitigation in Oslo, Norway. Sci. Total Environ. 709,
136193. https://doi.org/10.1016/j.scitotenv.2019.136193.
Vihervaara, P., et al., 2017. How essential biodiversity variables and remote sensing can help national biodiversity monitoring. Glob. Ecol. Conservat. 10, 43–59.
https://doi.org/10.1016/j.gecco.2017.01.007.
Voogt, J.A., Oke, T.R., 2003. Thermal remote sensing of urban climates. Remote Sens. Environ. 86, 370–384. https://doi.org/10.1016/S0034-4257(03)00079-8.
Walther, E., Goestchel, Q., 2018. The P.E.T. Comfort index: questioning the model. Build. Environ. 137, 1–10. https://doi.org/10.1016/j.buildenv.2018.03.054.
Weng, Q., Lu, D., Schubring, J., 2004. Estimation of land surface temperature–vegetation abundance relationship for urban heat island studies. Remote Sens. Environ.
89, 467–483. https://doi.org/10.1016/j.rse.2003.11.005.
Zare, S., Hasheminejad, N., Shirvan, H.E., Hemmatjo, R., Sarebanzadeh, K., Ahmadi, S., 2018. Comparing universal thermal climate index (UTCI) with selected
thermal indices/environmental parameters during 12 months of the year. Weath. Clim. Extrem. 19, 49–57. https://doi.org/10.1016/j.wace.2018.01.004.
Zhang, K., Li, Y., Schwartz, J.D., O’Neill, M.S., 2014. What weather variables are important in predicting heat-related mortality? A new application of statistical
learning methods. Environ. Res. 132, 350–359. https://doi.org/10.1016/j.envres.2014.04.004.
12
Contents lists available at ScienceDirect

Building and Environment

journal homepage: www.elsevier.com/locate/buildenv

A hybrid Python approach to assess microscale human thermal stress in
urban environments

Mansoureh Gholami a, Ariane Middel b, Daniele Torreggiani a, Patrizia Tassinari a,
Alberto Barbaresi a, *
a Department of Agricultural and Food Sciences University of Bologna, Italy
b School of Arts, Media and Engineering School of Computing and Augmented Intelligence Arizona State University, United States

A R T I C L E  I N F O

A B S T R A C T

Keywords:
Microclimate model
Mean radiant temperature (MRT)
Universal thermal climate index (UTCI)
Urban archetypes
Building and tree density
Urban design and planning
Nature-based solutions

Microclimate  simulations  are  in  high  demand  to  assess  the  thermal  impacts  of  urban  design  and  vegetation
changes.  Modeling  accurate  microclimate  dynamics  in  complex  urban  settings  requires  extensive  computing
power. A hybrid Python approach is introduced to simulate human thermal exposure (mean radiant temperature,
MRT)  and  comfort  (Universal  Thermal  Climate  Index,  UTCI)  in  cities.  The proposed  model  combines  various
engines in Rhinoceros to account for interactions between urban surfaces, tree canopies, and the atmosphere. The
model  was  validated  in  hot,  dry  Tempe,  USA,  using  in-situ  human-biometeorological  observations  and  then
applied to urban archetypes in Bologna and Imola, Italy. MRT and UTCI were simulated at five sites in Bologna,
four in Imola, and four in Tempe, with varying building heights and canopy cover for the climatologically hottest
◦
week of the year (August 3–9). The model performed well with an RMSE of 5.4
C, an index of agreement of 0.96,
and outperformed existing models for tree-shaded sites. MRT and UTCI were driven mainly by shade from dense
urban  forms  and  trees.  Highrise,  medium-to-high  tree  canopy  cover  archetypes  were  the  coolest  concerning
thermal exposure and comfort. Sites in Tempe exceeded the UTCI categories for Very Strong or Extreme Heat
Stress  independent  of  archetype.  The  model  enables  fast  and  accurate  assessment  of  urban  tree  planting
strategies.

1. Introduction

Urbanization combined with climate change impacts has prompted
researchers  to  develop  mitigation  strategies  to  protect  cities  from
overheating [1] and design models to assess potential mitigation stra-
tegies [2]. Climate-sensitive urban design (CSUD) is a design strategy to
reduce urban heat; it involves urban landscape planning and design that
aims to create more sustainable and thermally comfortable urban en-
vironments [3,4]. Street trees are considered an essential factor in CSUD
and, specifically, in relieving heat stress in cities ([5–10]; X. [11]). Tree
canopies  block  shortwave  solar  radiation  and  decrease  heat  stress
[12–15].  Designing  accurate  models  for  urban  environments  is
extremely  difficult  because  tree  canopies  and  buildings  significantly
differ in their radiative, thermal, and drag properties. In addition, there
is radiation exchange between buildings and trees ([16–18]; [19]. [20]).
In comparison to ground surfaces, tree canopies can transfer more
radiative  or  thermodynamic  flows  into  the  air  above  the  ground  and
cause new flows ([6,21]; Z. [22]; [23]C. [24]). Urban canopy models

(UCMs) simplify morphological and micrometeorological characteristics
and come in single-layer and multi-layer. The former type calculates the
effect of a given urban canopy on either temperature, wind, or humidity
(P.  [25];  C.  [24]),  while  the  latter  allows  the  simulation  of  multiple
vertical  urban  canopy  layers  as  well  as  the  variables  of  each  layer,
producing  more  detailed  street-level  microclimate  dispersion  outputs
(R. [22,26]).

Urban vegetation has been considered in many studies on a variety of
levels, from microscale to mesoscale [7,27–33]. Developing models for
simulating  the  impact  of  street  trees  started  several  decades  ago.  For
example,  Dupont  et  al.  [34]  initiated  the  integration  of  street  tree
modeling into DA-SM2-U, which is based on multi-layer urban canopies,
and were able to simulate dynamic and turbulent interactions between
buildings  and  vegetation.  In  2008,  a  vegetated  urban  canopy  model
(VUCM) for single-layer canopies, capable of modeling detailed canopy
properties, was developed [35]. Later, in 2011, the model was improved
by including a lawn in the canyon [36]. Krayenhoff et al. [37] employed
the Weather Research and Forecasting (WRF) model and a single-layer
urban  canopy  model  to  calculate  the  air  temperature  in  different

* Corresponding author.

E-mail address: alberto.barbaresi@unibo.it (A. Barbaresi).

https://doi.org/10.1016/j.buildenv.2023.111054
Received 5 April 2023; Received in revised form 20 September 2023; Accepted 10 October 2023

BuildingandEnvironment248(2024)111054Availableonline24November20230360-1323/©2023TheAuthors.PublishedbyElsevierLtd.ThisisanopenaccessarticleundertheCCBYlicense(http://creativecommons.org/licenses/by/4.0/).M. Gholami et al.

List of abbreviations

CFD
CSUD
d
εg
εw
εp
DSM
LCZ
LiDAR
MAE
MBE
MRT
PET
PMV
RH

Computational Fluid Dynamics
Climate Sensitive Urban Design
index of agreement
Emissivity of the ground
Emissivity of the wall
Emissivity of the human body
Digital Surface Model
Local Climate Zone
Light Detection and Ranging
Mean Absolute Error
Mean Bias Error
Mean Radiant Temperature
Physiological Equivalent Temperature
Predicted Mean Vote
Relative humidity

Root Mean Square Error
Air temperature
Urban Canopy Model
Urban Heat Island
Universal Thermal Climate Index
wind speed
Weather Research and Forecasting model

RMSE
Tair
UCM
UHI
UTCI
v
WRF
LR-HCC  Lowrise Blocks with High Canopy Cover
LR-LCC  Lowrise Blocks with Low Canopy Cover
LR-MCC Lowrise Blocks with Medium Canopy Cover
MR-LCC Mid-Rise Blocks with Low Canopy Cover
MR-MCC Mid-Rise Blocks with Medium Canopy Cover
MR-HCC Mid-Rise Blocks with High Canopy Cover
HR-LCC  Highrise Blocks with Low Canopy Cover
HR-MCC Highrise Blocks with Medium Canopy Cover
HR-HCC Highrise Blocks with High Canopy Cover

scenarios that involved planting street trees as a mitigation measure for
current and future climate change in the United States.

In 2020, the Building Effect Parameterization with Trees (BEP-Tree)
model,  which  had  distinct  street  tree  simulation  features,  was  intro-
duced as a multi-layer urban canopy model. It was evaluated using ra-
diation and turbulent exchanges, air temperature, and humidity of an
urban canopy layer [38]. Mussetti et al. [31] developed a model based
on  the  BEP-Tree  to  extend  its  functionality  for  nocturnal  radiation
simulation.  Various  simulation  tools  have  been  developed  to  model
human thermal exposure (driven by mean radiant temperature, MRT) in
complex  built  environments,  including  trees.  Ladybug  and  Honeybee
[39] hosted in the Rhinoceros platform can analyze complex 3D models
based on surface temperatures and sky view factors. ENVI-Met [40], a
3D computational fluid dynamics model, has become popular over the
last decade for calculating MRT. However, ENVI-Met is computationally
expensive  and  can  require  weeks  to  run.  Ladybug  tools  can  simulate
various  complex  geometries  at  a  shorter  simulation  time  but  do  not
include  airflow.  RayMan  [41]  models  MRT  based  on  hemispherical
photos  and  standard  meteorological  information  but  is  point-based.
SOLWEIG  [42]  simulates  MRT  through  the  simulation  of  shortwave
and longwave radiation fluxes in six directions (upward, downward, and
from the four cardinal points) and angular factors, but it is limited in
simulating longwave exchanges between trees and urban materials and
their  effects  on  the  flow  field  ([43];  C.  [44]).  Thus,  developing  a
methodology  to  comprehensively  model  all  complex  interactions  be-
tween  trees  and  surfaces  on  a  neighborhood  scale  is  necessary.  The
approach  should  be  precise  and  computationally  efficient  enough  to
simulate  urban  canopies.  Here,  a  hybrid  Python-based  human--
biometeorological  model  was  developed  to  evaluate  pedestrian-level
thermal exposure and comfort in neighborhoods with varying tree and
building densities. The model accounts for multi-layer urban canopies,
e.g., street trees and shrubs, and how they interact with built environ-
ment surfaces and the overlying atmosphere. Model simulations yield
hourly MRT and UTCI maps at fine resolution. The model was validated
using  human-biometeorological  street-level  observations  and  used  to
assess the effect of building and tree density in various urban archetypes
in Bologna (Italy), Imola (Italy), and Tempe (USA) neighborhoods.

2. Methodology

2.1. Hybrid Python approach

The  model  presented  here  is  a  hybrid  model  in  Grasshopper/Rhi-
noceros  developed  in  Python  3.8.1  to  combine  three  engines:  Ener-
gyPlus,  QGIS,  and  OpenFOAM.  Each  engine  simulates  a  subset  of

parameters for thermal comfort calculations. The interrelations of those
parameters are modeled using a comprehensive Python script (Fig. 1). In
the  first  simulation  step,  input  weather  data  for  model  forcing  is
generated from standard meteorological information. Hourly dew point
temperature,  global  solar  radiation,  and  direct/diffuse  decomposition
models  are  generated  based  on  dry  bulb  temperature  (Tair),  relative
humidity (RH), wind speed (v), and sky cover from a weather station in
the  Urbana  Bologna  neighborhood  [45]  and  https://mesowest.utah.
edu/for the Tempe campus (nearby Phoenix Sky Harbor airport). The
built  environment  for  Bologna  is  represented  in  Rhinoceros  using
various sources. A digital surface model (DSM) was created in SOLWEIG
[46] based on a 0.5-m-resolution LiDAR dataset. Geometric input data
for buildings and topographic data for land cover types were imported
from vector layers provided by the Municipality of Bologna using QGIS.
These layers were created for two neighborhoods with a resolution of 1
m.  3D  trees  in  the  neighborhoods  were  defined  by  trunk  and  canopy
diameters  and  simulated  using  3D  models  of  trees  that  most  closely
matched the canopy shape and height with a transmissivity of 0.02. For
the  Tempe  area,  the  3D  built  environment  was  generated  manually.
Trees were placed based on a processed 2014 LiDAR point cloud. For all
sites, the built-up area surrounding the studied zone is modeled as far as
500 m to minimize boundary effects during the simulation. Finally, MRT
maps were generated using the Grasshopper/Ladybug MRT calculator.
The  Universal  Thermal  Climate  Index  (UTCI)  is  calculated  using  the
Grasshopper/Ladybug Outdoor Comfort Calculator.

2.2. Study sites

The  model  was  validated  for  a  study  area  (four  sites)  in  Tempe,
Arizona, USA (Fig. 2), and then applied to two neighborhoods (9 sites) in
two  cities  (Bologna,  Imola)  in  the  Bologna  metropolitan  area,  Italy
◦
◦
56′18.6″W) is a city in the
25′28.6″N, 111
(Figs. 3 and 4). Tempe (33
Phoenix  metropolitan  area  in  the  Southwestern  United  States  with  a
population of 192,000.  Tempe has an arid subtropical climate with a
◦
summer daytime maximum air Temperature of 50
C (period of record:
1953–2013) and overnight lows between 27
C during the
summer months [47]. June is the driest month, with an average annual
rainfall of 2 mm, low relative humidity (13.28 %), and an average of
12.61 h of sunshine. The study area in Tempe includes the main campus
of Arizona State University and the adjacent Mill Avenue district (Tempe
downtown area). Buildings are primarily three-to four-story office and
commercial  buildings  and  mixed-use,  highrise  apartments  currently
under construction. The area can be characterized as an open midrise
Local Climate Zone (LCZ) transitioning to an open highrise LCZ.

C and 29

◦

◦

The Bologna metropolitan area (44

◦

◦
29′ 56.2380″ N, 11

19′ 39.3276″

BuildingandEnvironment248(2024)1110542M. Gholami et al.

Fig. 1. Flowchart of the presented hybrid Python approach and interrelation between parameters.

◦

◦
C or above 35.5

E)  has  an  extent  of  3700  km2  and  a  population  of  approximately
1,000,000.  The  region  has  a  mid-latitude,  humid  subtropical  climate
characterized by cold winters and hot, humid summers. Summers are
warm  and  mostly  clear,  and  winters  are  cold  and  partly  cloudy.
Throughout the year, air temperature typically varies from (cid:0) 0.5
C to
◦
◦
C and is rarely below (cid:0) 5
31.11
C. July has an average
◦
maximum temperature of 30
C. The coldest month is January, with an
average  minimum  temperature  of  (cid:0) 1
C.  The  wettest  month  is
November, with 95 mm of rainfall. The sunniest month is August, with
approximately 11 h of sunshine. The driest month is July, with 43 mm of
precipitation. The City of Bologna has about 26,600 urban trees and 11
km2 of green space over its total 140 km2 area. Street tree canopy covers
6 % of the City of Bologna, varying from 0 % to 70 % per block. The
Bologna neighborhood selected for the study has an area of 1450 m ×
600 m and features highrise, midrise, and lowrise buildings [49] with
varying canopy cover. The neighborhood in Imola, a city with a 204 km2
area and a population of approximately 70,000, has a size of 900 m ×
500 m with a 9 % street tree canopy cover and lowrise buildings.

◦

2.3. Urban form archetype classification

In  each  city,  a  few  main  urban  morphological  archetypes[]  were
selected to measure the effect of heterogeneous urban forms on micro-
climate parameters. The archetypes are similar to the LCZ classification
scheme but are smaller in length scale (building blocks, not neighbor-
hood scale) [50] and include information on tree canopy cover density
(medium, low, or high). Bologna features five archetypes (Fig. 2a): a)
lowrise blocks with high canopy cover (LR-HCC), b) highrise blocks with
low canopy cover (HR-LCC), c) mid-rise blocks with low canopy cover
(MD-LCC), d) highrise blocks with medium canopy cover (HR-MCC), e)
lowrise blocks with low canopy cover (LR-LCC). Imola has four arche-
types (Fig. 2b): a) lowrise blocks with high canopy cover (LR-HCC), b)
mid-rise  blocks  with  medium  canopy  cover  (MR-MCC),  c)  mid-rise
blocks with low canopy cover (MR-LCC), d) highrise blocks with high
canopy  cover  (HR-HCC).  In  Tempe,  the  selected  archetypes  are  pri-
marily open (Fig. 2c): a) lowrise blocks with low canopy cover (LR-LCC),
b)  lowrise  blocks  with  medium  canopy  cover  (LR-MCC),  c)  highrise
blocks with low canopy cover (HR-LCC), and d) midrise blocks with high
canopy cover (MR-HCC).

3. Model validation

Model  performance  was  assessed  in  Tempe,  Arizona,  USA,  where
instrumentation for in-situ human-biometeorological observations was

available. The model was validated using fieldwork campaign data from
MaRTy,  a  mobile  human-biometeorological  weather  station.  Hourly
transects were conducted on June 7 and 8, 2018, from 8:30h to 20:30h
and  on  July  3  and  8,  2019,  at  12:30h  (peak  solar  radiation),  15:30h
(peak Tair), and 20:30h (after sunset), traversing the Tempe Mill Avenue
District and Arizona State University’s main campus (Fig. 3). The tran-
sect  followed  the  procedure  outlined  in  [48]  to  minimize  sensor  lag
[51]. Five validation sites were selected that represent distinct micro-
climate zones (MCZs) [52]: two open sites with sky view factor (SVF) of
0.93  and  0.80  over  asphalt  and  grass,  respectively;  one  enclosed  site
(SVF = 0.13) in an urban canyon over concrete; and two tree-shaded
sites  (SVF  = 0.33  and  SVF  = 0.02)  over  concrete  and  grass,  respec-
tively.  MaRTy  observed  georeferenced  6-directional  longwave  and
shortwave radiation flux densities with three Hukseflux 4-Component
Net Radiometers to calculate MRT and also observed Tair, RH, and v at
pedestrian height.

◦
C–69.4

◦
C–40.9

◦
C, and peak MRT of 64.8

◦
C and a larger unsystematic RMSE of 4.6

Validation days were hot, clear sky summer days with light winds
(cid:0) 1  on  average),  low  RH  (11.1  %  on  average),  peak  Tair  of
(0.7  ms
◦
39.0
C (Fig. 4). Overall, the
◦
C
model performed well with a Root Mean Square error (RMSE) of 5.37
and an index of agreement d = 0.96. The model has a small systematic
◦
RMSE of 0.6
C, indicating that
model parameters are appropriate and most of the error is random. The
C,  meaning  the  model  over-
overall  Mean  Bias  Error  (MBE)  is  3.5
◦
estimates MRT. The Mean Absolute Error (MAE) is 4.5
C. The model
◦
C and performs better
performs best for open sites with an RMSE of 5.1
◦
than most existing tree models (see discussion) with an RMSE of 5.4
C,
◦
which is close to the accuracy requirement of ±5
C set in the ISO 7226
standard [53] for heat stress studies.

◦

4. Results

After successful validation, the model was applied in Bologna, Imola,
and Tempe to simulate MRT and UTCI in four to five building archetypes
with  varying  tree  canopy  cover  (Fig.  2).  The  climatologically  hottest
week  of  the  year  was  simulated  in  Bologna  (August  3–9)  for  all  sites
using data from the Urban Weather Generator as forcing (Figures Supp.
1–4).  Hourly  MRT  was  spatially  averaged  for  all  archetypes  (Fig.  5,
section 4.1), and intra-archetype MRT distributions were averaged over
the week (Fig. 6, section 4.1). UTCI was investigated for all archetypes
(Fig.  7,  section  4.2),  which  allows  the  comparison  of  hot  and  humid
conditions  in  Bologna and  Imola  to  hot and  dry  conditions in  Tempe
because UTCI combines Tair, RH, v, and MRT in a comprehensive index.

BuildingandEnvironment248(2024)1110543M. Gholami et al.

Fig. 2. Study areas and urban form archetype classifications in a) Bologna, Italy; b) Imola, Italy; and c) Temp, Arizona USA; Source: Google Maps.

4.1. Mean radiant temperature simulations for archetypes

Fig. 5 shows hourly, diurnal MRT under clear sky conditions during
the one-week study period (August 3–9) in Bologna (a), Imola (b), and
Tempe  (c)  archetypes.  In  Bologna,  MRT  varies  significantly  between

◦

sites, with a difference of up to 20
C between HR-MCC and HR-LCC.
Although  MR-LCC  has  low  tree  canopy  cover,  building  walls  prevent
shortwave  radiation  from  reaching  the  ground  between  densely  ar-
ranged buildings, and spatially averaged MRT stays below 40
C at all
times. MR-LCC features dense urban forms and would be classified as a

◦

BuildingandEnvironment248(2024)1110544M. Gholami et al.

Fig. 3. Map of validation sites on and near Arizona State University’s main campus in Tempe, Arizona. Fisheye photos represent hemispherical views of the sky with
the sky view factor noted in the fisheye. Photos were taken at 1.1 m height with a Canon EOS 6D and Canon EF 8–15-mm f/4 Fisheye USM Ultra-Wide Zoom lens.
Photo borders denote the ground cover of the location (green = grass, grey = impervious). Human-biometeorological sensor setup MaRTy to the right [48]. (For
interpretation of the references to color in this figure legend, the reader is referred to the Web version of this article.)

Fig. 4. Comparison of model output and MaRTy measurements at the validation sites in Tempe, Arizona, USA (Fig. 3).

◦

compact mid-rise Local Climate Zone (LCZ) [54] at the neighborhood
level. The two archetypes in Bologna with the highest average MRT are
HR-MCC  (62.0
C  on  August  5).
C  on  August  5)  and  LR-HCC  (53.8
Large, open, sun-exposed spaces and longwave trapping between close
midrise buildings mostly drive high MRT. Fig. 6 illustrates the impact of
shade on the spatial distribution of MRT. While HR-LCC exhibits lower
MRT values around the C-shaped, 24-m-tall building and the trees in this
archetype,  most  areas  are  exposed  to  intense  shortwave  radiation  for
most of the day.

◦

In Imola, a small community-scale park representing archetype LR-
HCC  experiences  the  highest  spatially  averaged  MRT  values  (65.1
C
on August 5). The park has a sparse canopy cover with few trees spread
out  across  an  extensive  lawn.  In  contrast,  archetype  HR-HCC  is  the
coolest overall, with average MRT peaking at 45.9
C on August 5 and
not exceeding Tair  by more than 10
C. HR-HCC has tall buildings sur-
rounded by closed tree canopy cover, with almost all areas shaded by
buildings or trees (Fig. 5 b). Archetype MR-LCC is an excellent example
of effective shade from urban form that creates cool pedestrian spaces,

◦

◦

◦

◦
with average MRT only exceeding 50
despite low tree canopy cover.

C twice (August 3 and August 5)

Tempe  Downtown  and  Arizona  State  University’s  campus  can  be
classified as open midrise LCZ. Archetype HR-LCC north of campus has
highrise  buildings  and  a  multi-story  parking  structure  surrounded  by
large, open spaces to the south (Figs. 2 and 5 c), yielding the highest
MRT average of 66.8
C on August 8. The coolest archetypes are MR-
◦
MCC (peaks at 59.5
C on
August 8). MR-MCC has dense midrise buildings arranged in a courtyard
formation, providing ample shade for most of the day, while LR-HCC
achieves cooling through shade from mature trees.

C on August 8) and LR-HCC (peaks at 59.5

◦

◦

4.2. Thermal stress simulations for archetypes

To compare the thermal performance of urban form archetypes in
Bologna, Imola, and Tempe, differences in dry vs. humid climate must be
considered using a comprehensive thermal comfort index because MRT
does  not  consider  humidity.  The  UTCI  spatial  distribution  was

BuildingandEnvironment248(2024)1110545M. Gholami et al.

Fig. 5. A week of simulated diurnal Mean Radiant Temperature (MRT) spatial averages of investigated archetypes in (a) Bologna, Italy; (b) Imola, Italy; and (c)
Tempe, Arizona, USA. Archetypes are a combination of lowrise (LR), midrise (MR), and highrise (HR) buildings surrounded by low tree canopy cover (LCC), medium
tree canopy cover (MCC), and high tree canopy cover (HCC). Hourly air temperature at the nearest airport is provided as a reference (dashed line).

calculated  at  the  pedestrian  level  for  all  archetypes  for  August  3–9
(Fig. 7). UTCI and MRT display similar diurnal curves, keeping the order
from  the  coolest  to  hottest  archetypes  but  exhibiting  different
magnitudes.

In Bologna, thermal stress in archetypes LR-HCC and HR-MCC falls in
the “very strong heat stress” category (Table 1) on the hottest day of the
◦
year, August 4, when Tair is 39.6
C at noon. Conversely, with a UTCI of
◦
32.3
C at noon on the same day, archetype MR-LCC exhibits moderate
heat stress and is the most thermally comfortable archetype in Bologna
due to ample shade from dense midrise buildings.

◦

In Imola, heat stress is generally higher than in Bologna. With a UTCI
of 43.4
C (very strong heat stress) at noon on August 4, the archetype
LR-HCC is the hottest and most uncomfortable urban form. Meanwhile,
HR-HCC is the coolest archetype, with a mean UTCI of 37.5
C on the
same day. Areas close to buildings are 1–2
C warmer than open sun-
exposed areas due to added longwave radiation from vertical surfaces.
Similarly,  tree-shaded  areas  are  0.5–1.5
C  cooler  than  shaded  areas
close to buildings.

◦

◦

◦

Most  of  Arizona  State  University’s  campus  is  a  “walk-only  zone”
designed for pedestrians, but UTCI falls in the category of “Extreme Heat
Stress” in most archetypes. On August 8, an extreme heat day with Tair
C in the HR-LCC archetype. MR-
peaking at 45
MCC is the coolest archetype due to the courtyard-like arrangement of
dense midrise buildings, yet UTCI still falls into the “Very strong heat
stress” category for all days except August 8 (“Extreme heat stress”).

C, UTCI surpasses 53

◦

◦

A comparison across study sites reveals that trees and taller buildings
can  lower  UTCI  to  the  “Strong  heat  stress”  category  in  Bologna  and
Imola but not Tempe. Although conditions in the Italian archetypes are
more humid than in Tempe, the intense solar  radiation is the biggest
driver  of  UTCI  in  the  dry  Southwestern  US  and  elevates  heat  stress
conditions by two categories. In addition, archetypes in Tempe are more
open with more sun-exposed areas than in Bologna and Imola due to
higher street-to-width ratios and more parking lots.

BuildingandEnvironment248(2024)1110546M. Gholami et al.

Fig. 6. Spatial variations in MRT (hourly averages for a time period from August 3–9) for archetypes in a) Bologna, Italy; b) Imola, Italy; c) Tempe, USA. Note that
the color scale for Tempe differs from that for Bologna and Imola due to extreme MRT values. (For interpretation of the references to color in this figure legend, the
reader is referred to the Web version of this article.)

5. Discussion

◦

The proposed model performed well with an overall RMSE of just
over 5
C for MRT, which is the acceptable error margin for heat stress
studies  according  to  ISO  7226,  as  used  in  prior  studies[56–60].  Most
studies  have  reported  larger  MRT  discrepancies  for  existing  models,
especially  when  simulating  tree-shaded  locations  [61].  and  G´al  and
K´antor  [56]  assessed  the  performance  of  RayMan  and  ENVI-met  in
Tempe,  USA  (hot  and  dry  climate)  and  Szeged,  Hungary  (warm  and
◦
temperate climate), respectively. RayMan produced an RMSE of 8
C for
◦
five sites at an urban square in Szeged and an error of 12.4
C for seven
sites  in  Tempe  Downtown  (a  similar  study  area  as  this  study).  For

◦

ENVI-met, G´al and K´antor found a lower RMSE of 6.9
C, while Crank
◦
C. Both author teams note that the
et al. reported an RMSE of up to 16.1
most  common  reason  for  MRT  discrepancies  is  shading  mismatches
caused  by  the  spatial  coarseness  of  the  models.  These  findings  are
further corroborated by Acero et al. [62], who found RMSE ranges of
7.4
C for MRT modeled with ENVI-met in a neighborhood in
Bilbao, Spain (temperate oceanic climate). Future ENVI-met studies may
report  smaller  errors  due  to  improvements  in  the  model’s  radiation
scheme, which  further increase  computational complexity  but signifi-
cantly improve accuracy [63,64].

C–19.0

◦

◦

Colter  et  al.  [65]  investigated  the  impact  of  tree  and  engineered
shade on MRT in Phoenix, USA urban parks (hot and dry climate) using

BuildingandEnvironment248(2024)1110547M. Gholami et al.

Fig. 7. A week of simulated UTCI spatial averages of investigated archetypes in (a) Bologna, Italy; (b) Imola, Italy; and (c) Tempe, Arizona, USA. Archetypes are a
combination of lowrise (LR), midrise (MR), and highrise (HR) buildings surrounded by low tree canopy cover (LCC), medium tree canopy cover (MCC), and high tree
canopy cover (HCC). Hourly air temperature at the nearest airport is provided as a reference (dashed line).

Table 1
UTCI categories for thermal stress (“[55]).

◦
UTCI (

C) range

Above +46
+38 to +46
+32 to +38
+26 to +32
+9 to +26

Stress Category

Extreme heat stress
Very strong heat stress
Strong heat stress
Moderate heat stress
No thermal stress

in-situ  observations  and  RayMan  simulations.  They  pointed  out  that
RayMan overestimates MRT for tree-shaded sites due to errors in long-
wave radiation estimates that stem from assuming homogeneous surface
materials.  The  model  proposed  in  this  study  uses  the  Grass-
hopper/Ladybug  MRT  calculator,  which  considers  different  surface
temperatures  of  the  surroundings  depending  on  the  materials  and
vegetation  specified  in  the  model.  This  is  evidenced  in  the  small  sys-
◦
tematic RMSE of 0.6
C. Correct estimates of longwave radiative fluxes,

including those from vertical surfaces, are critical in dense urban forms
where incoming solar radiation is reduced [66,67].

Microclimate models are frequently used to investigate the thermal
exposure  and  comfort  benefits  of  trees  for  pedestrians.  (Aminipouri,
Knudby et al. [16] simulated the effect of adding street trees to Van-
couver,  Canada  (temperate  oceanic  climate)  neighborhoods  with  the
C for various
SOLWEIG model. They reported an RMSE of 3.5
LCZs with larger errors for highrise urban forms. While SOLWEIG per-
forms similarly to our model in terms of accuracy, it does not allow users
to customize tree shapes and LAI. Instead, trees are represented in a 2.5D
raster  format  with a  fixed,  default transmissivity  of  0.03 %,  affecting
model accuracy for tree-shaded locations.

C–6.9

◦

◦

Few  studies  have  used  the  Ladybug  and  Honeybee  Grasshopper
plugins for Rhinoceros to model outdoor thermal exposure and comfort,
similar to our approach [68]. calculated MRT and UTCI for three urban
forms  in  Tehran  (Mediterranean  climate)  and  validated  their  model
using globe temperature measurements. They reported a RMSE range of
1.4
C (organically grown neighborhood) [69].

C (apartments) to 4.5

◦

◦

BuildingandEnvironment248(2024)1110548M. Gholami et al.

also employed the Ladybug tools to model MRT in an urban canyon in
Catania, Sicily (Mediterranean climate). In accordance with the results
presented here, they found that the model tends to overestimate MRT,
especially  at  noon,  and  point  to  possible  inaccuracies  in  modeling
ground surface temperatures in Grasshopper.

In summary, this hybrid Python approach that links various engines
in Rhinoceros is comparable to other Ladybug tool studies in terms of
model  accuracy  but  outperforms  microscale  models  such  as  RayMan,
ENVI-met,  and  SOLWEIG,  especially  for  tree-shaded  locations.  The
proposed  model  has  several  limitations  concerning  atmospheric  pa-
rameters. First, the MRT calculations do not include reflected shortwave
radiation from facades, which is particularly important in open highrise
LCZs. Second, incoming shortwave radiation is currently overestimated
due to simplifications in the SolarCal algorithm. Lastly, the method ig-
nores evapotranspiration from trees, contributing to the overestimation
of  heat  in  the  study  domain.  However,  since  trees  in  Tempe  stop
evapotranspiration  in  hot  weather  conditions,  the  impact  of  this
assumption is minimal. Naboni et al. [70] provide a comprehensive list
of imitations.

To demonstrate the application of this model, the spatial distribution
of  MRT  and  UTCI  was  analyzed  in  neighborhood  archetypes  with
varying building heights and tree canopy cover. It was found that both
parameters  are  primarily  driven  by  shade  from  buildings  and  trees.
Highrise, medium-to-high tree canopy cover archetypes were the coolest
urban forms, confirming previous findings that densely built environ-
ments can create local cool islands during the day [71,72].

Future research should focus on developing simulation tools that are
more computationally efficient while retaining precision and reducing
resource requirements. The reliability of any model depends on the ac-
curacy of its inputs, which can be limited by data availability and the
complexity  of  analyzing  microclimates  in  real  neighborhoods.  For
example,  accurately  simulating  wind  patterns  at  the  pedestrian  level
requires realistic wind speed data. The current model relies on weather
data files obtained at 10 m and does not accurately represent the con-
ditions  experienced  at  the  pedestrian  level.  To  enhance  the  model,
further  studies  can  explore  integrating  additional  factors  and  co-
simulations, such as walkability criteria, different greening strategies,
and  local  greenhouse  gas  emissions.  Fast  and  easy-to-use  models  will
assist urban planners and designers determine optimal spaces for tree
planting (see two examples in Supplemental Materials) [16]. found that
the  cooling  potential  of  added  street  trees  is  greater  in  lower-density
residential neighborhoods compared to areas with highrise or mid-rise
buildings. The proposed hybrid approach can be used to further deter-
mine the optimal type of tree spacing (clustered vs. dispersed), leaf area
density, and crown size in various urban archetypes.

6. Conclusions

Urbanization  and  climate  change  increasingly  cause  overheating,
negatively impacting cities and urban planning procedures. As a heat
mitigation strategy, tree planting requires human-centric, place-based
microclimate knowledge of urban spaces to determine the best place-
ment  strategy  for  trees  and  the  best  tree  size  and  species  based  on
hyperlocal  contexts.  Simulating  microclimate  benefits  from  tree
planting facilitates the planning and design process to reduce MRT and
heat stress but requires computationally expensive simulation tools.

The  presented  hybrid  model  is  a  cohesive  approach  that  employs
various engines and uses the output of one step as input for the next step
in an integrated fashion. It is easy to use for non-experts and builds on
accurate  3D  models  of  buildings  and  trees  on  top  of  a  DSM.  It  can
manage complex geometries of the built environment and trees, which
overcomes inaccuracies of gridded models.

Street  trees  are  now  more  valuable  than  ever  for  our  urban  envi-
ronments,  given  how  extreme  heat  in  cities  has  reached  concerning
levels in recent decades. The number of trees must increase to counteract
urban overheating, and microclimate simulation tools are essential for

optimizing the distribution and placement of trees. A balance must also
be  created  between  urban  management  and  urban  engineering  to
maximize the benefits of trees in retrofitting strategies. The proposed
model can provide urban planners and policymakers with a precise and
valuable methodology for simulating the effects of trees on the human
scale,  pedestrian-level  thermal  exposure,  and  comfort  and  also  help
them guarantee the functionality of policies in different urban settings.

CRediT authorship contribution statement

Mansoureh Gholami: Writing –  original draft, Visualization, Vali-
dation,  Software,  Methodology,  Investigation,  Formal  analysis,  Data
curation, Conceptualization.  Ariane Middel:  Writing –  original  draft,
Visualization,  Supervision,  Resources,  Methodology,  Investigation,
Conceptualization.  Daniele  Torreggiani:  Supervision,  Resources,
Funding acquisition. Patrizia Tassinari: Supervision, Resources, Proj-
ect administration. Alberto Barbaresi: Writing – original draft, Super-
vision, Investigation, Conceptualization.

Declaration of competing interest

The authors declare that they have no known competing financial
interests or personal relationships that could have appeared to influence
the work reported in this paper.

Data availability

Data will be made available on request.

Appendix A. Supplementary data

Supplementary data to this article can be found online at https://doi.

org/10.1016/j.buildenv.2023.111054.

References

[1] N. Nazarian, E.S. Krayenhoff, B. Bechtel, D.M. Hondula, R. Paolini, J. Vanos,

T. Cheung, W.T.L. Chow, R. de Dear, O. Jay, J.K.W. Lee, A. Martilli, A. Middel, L.
K. Norford, M. Sadeghi, S. Schiavon, M. Santamouris, Integrated assessment of
urban overheating impacts on human life, Earth’s Future 10 (8) (2022),
e2022EF002682, https://doi.org/10.1029/2022EF002682.

[2] E.S. Krayenhoff, A.M. Broadbent, L. Zhao, M. Georgescu, A. Middel, J.A. Voogt,

A. Martilli, D.J. Sailor, E. Erell, Cooling hot cities: a systematic and critical review
of the numerical modelling literature, Environ. Res. Lett. 16 (5) (2021), 053007,
https://doi.org/10.1088/1748-9326/ABDCF1.

[3] A.M. Coutts, N.J. Tapper, J. Beringer, M. Loughnan, M. Demuzere, Watering our
cities, Prog. Phys. Geogr. Earth Environ. 37 (1) (2013) 2–28, https://doi.org/
10.1177/0309133312461032.

[4] M. Gholami, Analyzing Urban Green Adaptation Opportunities: Concepts,

Approaches, & Strategies for Existing Neighborhoods, 2022.

[5] A.M. Coutts, E.C. White, N.J. Tapper, J. Beringer, S.J. Livesley, Temperature and
human thermal comfort effects of street trees across three contrasting street canyon
environments, Theor. Appl. Climatol. 124 (1–2) (2016) 55–68, https://doi.org/
10.1007/s00704-015-1409-y.

[6] M. Gholami, M. Mofidi Shemirani, R. Fayaz, A modelling methodology for a solar

energy-efficient neighbourhood, Smart and Sustainable Built Environment 7 (1)
(2018), https://doi.org/10.1108/SASBE-10-2017-0044.

[7] M. Gholami, D. Torreggiani, P. Tassinari, A. Barbaresi, Developing a 3D city digital
twin: enhancing walkability through a green pedestrian network (GPN) in the city
of Imola, Italy, Land 2022 11 (11) (2022) 1917, https://doi.org/10.3390/
LAND11111917. Vol. 11, Page 1917.

[8] L. Manickathan, T. Defraeye, J. Allegrini, D. Derome, J. Carmeliet, Parametric
study of the influence of environmental factors and tree properties on the
transpirative cooling effect of trees, Agric. For. Meteorol. 248 (2018) 259–274,
https://doi.org/10.1016/j.agrformet.2017.10.014.

[9] M. Sadeghi, T. Chaston, I. Hanigan, R. de Dear, M. Santamouris, B. Jalaludin, G.
G. Morgan, The health benefits of greening strategies to cool urban environments –
a heat health impact method, Build. Environ. 207 (2022), 108546, https://doi.org/
10.1016/J.BUILDENV.2021.108546.

[10] Y. Shi, Y. Zhang, Urban morphological indicators of urban heat and moisture

islands under various sky conditions in a humid subtropical region, Build. Environ.
214 (2022), 108906, https://doi.org/10.1016/J.BUILDENV.2022.108906.
[11] X. Wang, H. Li, S. Sodoudi, The effectiveness of cool and green roofs in mitigating

urban heat island and improving human thermal comfort, Build. Environ. 217
(2022), https://doi.org/10.1016/J.BUILDENV.2022.109082.

BuildingandEnvironment248(2024)1110549M. Gholami et al.

[12] D. Armson, P. Stringer, A.R. Ennos, The effect of tree shade and grass on surface
and globe temperatures in an urban area, Urban For. Urban Green. 11 (3) (2012)
245–255, https://doi.org/10.1016/j.ufug.2012.05.002.

[13] J. Geletiˇc, M. Lehnert, J. Resler, P. Krˇc, A. Middel, E.S. Krayenhoff, E. Krüger, High-
fidelity simulation of the effects of street trees, green roofs and green walls on the
distribution of thermal exposure in Prague-Dejvice, Build. Environ. 223 (2022),
109484, https://doi.org/10.1016/J.BUILDENV.2022.109484.

[14] P. Luo, B. Yu, P. Li, P. Liang, Y. Liang, L. Yang, How 2D and 3D built environments
impact urban surface temperature under extreme heat: a study in Chengdu, China,
Build. Environ. (2023), 110035, https://doi.org/10.1016/J.
BUILDENV.2023.110035.

[15] M.A. Rahman, L.M.F. Stratopoulos, A. Moser-Reischl, T. Z¨olch, K.H. H¨aberle,

T. R¨otzer, H. Pretzsch, S. Pauleit, Traits of trees for cooling urban heat islands: a
meta-analysis, Build. Environ. 170 (2020), 106606, https://doi.org/10.1016/J.
BUILDENV.2019.106606.

[36] S.H. Lee, Further Development of the vegetated urban canopy model including a
grass-covered surface Parametrization and photosynthesis effects, Boundary-Layer
Meteorol. 140 (2) (2011) 315–342, https://doi.org/10.1007/s10546-011-9603-7.
[37] E.S. Krayenhoff, M. Moustaoui, A.M. Broadbent, V. Gupta, M. Georgescu, Diurnal
interaction between urban expansion, climate change and adaptation in US cities,
Nat. Clim. Change 8 (12) (2018) 1097–1103, https://doi.org/10.1038/s41558-
018-0320-9.

[38] E.S. Krayenhoff, T. Jiang, A. Christen, A. Martilli, T.R. Oke, B.N. Bailey,

N. Nazarian, J.A. Voogt, M.G. Giometto, A. Stastny, B.R. Crawford, A multi-layer
urban canopy meteorological model with trees (BEP-Tree): street tree impacts on
pedestrian-level climate, Urban Clim. 32 (July 2019) (2020) 1–26, https://doi.org/
10.1016/j.uclim.2020.100590.

[39] M. Pak, A. Smith, G. Gill, Ladybug : a parametric environmental plugin for
grasshopper to help designers create an environmentally-conscious design,
Computer Science (2013).

[16] M. Aminipouri, A.J. Knudby, E.S. Krayenhoff, K. Zickfeld, A. Middel, Modelling the

[40] M. Bruse, H. Fleer, Simulating surface-plant-air interactions inside urban

impact of increased street tree cover on mean radiant temperature across
Vancouver’s local climate zones, Urban For. Urban Green. 39 (2019) 9–17, https://
doi.org/10.1016/J.UFUG.2019.01.016.

[17] L. Feng, S. Yang, Y. Zhou, L. Shuai, Exploring the effects of the spatial arrangement

and leaf area density of trees on building wall temperature, Build. Environ. 205
(2021), 108295, https://doi.org/10.1016/J.BUILDENV.2021.108295.

[18] J.A. Lachapelle, E.S. Krayenhoff, A. Middel, S. Meltzer, A.M. Broadbent,

M. Georgescu, A microscale three-dimensional model of urban outdoor thermal
exposure (TUF-Pedestrian), Int. J. Biometeorol. 66 (4) (2022) 833–848, https://
doi.org/10.1007/S00484-022-02241-1/FIGURES/9.

[19] M. Aminipouri, D. Rayner, F. Lindberg, S. Thorsson, A.J. Knudby, K. Zickfeld,
A. Middel, E.S. Krayenhoff, Urban Tree Planting to Maintain Outdoor Thermal
Comfort under Climate Change: the Case of Vancouver’s Local Climate Zones,
2019, https://doi.org/10.1016/j.buildenv.2019.05.022.

[20] C. Wang, Z.-H. Wang, Y.-H. Ryu, A Single-Layer Urban Canopy Model with
Transmissive Radiation Exchange between Trees and Street Canyons, 2021.
[21] J. Deng, B.J. Pickles, S.T. Smith, L. Shao, Infrared radiative performance of urban
trees: spatial distribution and interspecific comparison among ten species in the UK
by in-situ spectroscopy, Build. Environ. 172 (2020), 106682, https://doi.org/
10.1016/J.BUILDENV.2020.106682.

[22] R. Li, F. Zeng, Y. Zhao, Y. Wu, J. Niu, L. Wang, Leon), N. Gao, X. Shi, CFD

simulations of the tree effect on the outdoor microclimate by coupling the canopy
energy balance model, Build. Environ. 230 (2023), 109995, https://doi.org/
10.1016/J.BUILDENV.2023.109995.

[23] Z. Li, X. Feng, J. Sun, C. Li, W. Yu, Z. Fang, STMRT: a simple tree canopy radiative
transfer model for outdoor mean radiant temperature, Build. Environ. 228 (2023),
109846, https://doi.org/10.1016/J.BUILDENV.2022.109846.

[24] C. Wang, Z.H. Wang, Y.H. Ryu, A single-layer urban canopy model with

transmissive radiation exchange between trees and street canyons, Build. Environ.
191 (2021), 107593, https://doi.org/10.1016/J.BUILDENV.2021.107593.
[25] P. Li, Z.H. Wang, Modeling carbon dioxide exchange in a single-layer urban canopy

model, Build. Environ. 184 (2020), 107243, https://doi.org/10.1016/J.
BUILDENV.2020.107243.

environments with a three dimensional numerical modelEnviron, Model. Softw. 13
(1998) 373–384, https://doi.org/10.1016/S1364-8152(98)00042-5.

[41] A. Matzarakis, F. Rutz, H. Mayer, Modelling radiation fluxes in simple and complex

environments: basics of the RayMan model, Int. J. Biometeorol. 54 (2) (2009)
131–139, https://doi.org/10.1007/S00484-009-0261-0, 2009 54:2.

[42] F. Lindberg, B. Holmer, S. Thorsson, Solweig 1.0 – modelling spatial variations of
3D radiant fluxes and mean radiant temperature in complex urban settings, Int. J.
Biometeorol. 52 (7) (2008) 697–713, https://doi.org/10.1007/S00484-008-0162-
7, 2008 52:7.

[43] E.S. Krayenhoff, M. Moustaoui, A.M. Broadbent, V. Gupta, M. Georgescu, Diurnal
interaction between urban expansion, climate change and adaptation in US cities,
Nat. Clim. Change 8 (12) (2018) 1097–1103, https://doi.org/10.1038/s41558-
018-0320-9.

[44] C. Wang, Z. Wang, J. Yang, Cooling effect of urban trees on the built environment
of contiguous United States, Earth’s Future 6 (8) (2018) 1066–1081, https://doi.
org/10.1029/2018EF000891.

[45] M. Gholami, D. Torreggiani, A. Barbaresi, P. Tassinari, Smart Green Planning for
Urban Environments: The City Digital Twin of Imola, in: F. Belaïd, A. Arora (Eds.),
Smart Cities. Studies in Energy, Resource and Environmental Economics, Springer,
Cham, 2024. https://doi.org/10.1007/978-3-031-35664-3_10.

[46] F. Lindberg, B. Holmer, S. Thorsson, Solweig 1.0 - modelling spatial variations of
3D radiant fluxes and mean radiant temperature in complex urban settings, Int. J.
Biometeorol. 52 (7) (2008) 697–713, https://doi.org/10.1007/S00484-008-0162-
7/FIGURES/12.

[47] Western Regional Climate Center. https://wrcc.dri.edu/.
[48] A. Middel, E.S. Krayenhoff, Micrometeorological determinants of pedestrian

thermal exposure during record-breaking heat in Tempe, Arizona: introducing the
MaRTy observational platform, Sci. Total Environ. 687 (2019), https://doi.org/
10.1016/j.scitotenv.2019.06.085.

[49] M. Gholami, D. Torreggiani, P. Tassinari, A. Barbaresi, Narrowing uncertainties in
forecasting urban building energy demand through an optimal archetyping
method, Renew. Sustain. Energy Rev. 148 (2021), 111312, https://doi.org/
10.1016/J.RSER.2021.111312.

[26] H. Yu, T. Zhang, H. Fukuda, X. Ma, The effect of landscape configuration on

[50] M. Gholami, A. Barbaresi, D. Torreggiani, P. Tassinari, Upscaling of spatial energy

outdoor thermal environment: a case of urban Plaza in Xi’an, China, Build.
Environ. (2023), 110027, https://doi.org/10.1016/J.BUILDENV.2023.110027.

[27] C. de Munck, A. Lemonsu, V. Masson, J. Le Bras, M. Bonhomme, Evaluating the
impacts of greening scenarios on thermal comfort and energy and water
consumptions for adapting Paris city to climate change, Urban Clim. 23 (2018)
260–286, https://doi.org/10.1016/j.uclim.2017.01.003.

[28] S. Erlwein, T. Z¨olch, S. Pauleit, Regulating the microclimate with urban green in
densifiying cities: joint assessment on two scales, Build. Environ. 205 (2021),
108233, https://doi.org/10.1016/J.BUILDENV.2021.108233.

[29] X. He, W. Gao, R. Wang, Impact of urban morphology on the microclimate around
elementary schools: a case study from Japan, Build. Environ. 206 (2021), 108383,
https://doi.org/10.1016/J.BUILDENV.2021.108383.

[30] E.S. Krayenhoff, T. Jiang, A. Christen, A. Martilli, T.R. Oke, B.N. Bailey,

N. Nazarian, J.A. Voogt, M.G. Giometto, A. Stastny, B.R. Crawford, A multi-layer
urban canopy meteorological model with trees (BEP-Tree): street tree impacts on
pedestrian-level climate, Urban Clim. 32 (July 2019) (2020) 1–26, https://doi.org/
10.1016/j.uclim.2020.100590.

[31] G. Mussetti, D. Brunner, S. Henne, J. Allegrini, E. Scott Krayenhoff, S. Schubert,

C. Feigenwinter, R. Vogt, A. Wicki, J. Carmeliet, COSMO-BEP-Tree v1.0: a coupled
urban climate model with explicit representation of street trees, Geosci. Model Dev.
(GMD) 13 (3) (2020) 1685–1710, https://doi.org/10.5194/gmd-13-1685-2020.

[32] H. Yu, T. Zhang, H. Fukuda, X. Ma, The effect of landscape configuration on

outdoor thermal environment: a case of urban Plaza in Xi’an, China, Build.
Environ. (2023), 110027, https://doi.org/10.1016/J.BUILDENV.2023.110027.

[33] M. Gholami, A. Barbaresi, P. Tassinari, M. Bovo, D. Torreggiani, A comparison of
energy and thermal performance of rooftop greenhouses and green roofs in
mediterranean climate: a hygrothermal assessment in WUFI, Energies 13 (8)
(2020) 2030, https://doi.org/10.3390/en13082030.

[34] S. Dupont, T.L. Otte, J.K.S. Ching, Simulation of meteorological fields within and
above urban and rural canopies with a mesoscale model, Boundary-Layer Meteorol.
113 (1) (2004) 111–158, https://doi.org/10.1023/B:BOUN.0000037327.19159.
ac.

[35] S.H. Lee, S.U. Park, A vegetated urban canopy model for meteorological and
environmental modelling, Boundary-Layer Meteorol. 126 (1) (2008) 73–102,
https://doi.org/10.1007/s10546-007-9221-6.

planning, phases, methods, and techniques: a systematic review through meta-
analysis, in: Renewable and Sustainable Energy Reviews, vol. 132, Elsevier Ltd,
2020, https://doi.org/10.1016/j.rser.2020.110036.

[51] K. H¨ab, B.L. Ruddell, A. Middel, Sensor lag correction for mobile urban

microclimate measurements, Urban Clim. 14 (2015) 622–635, https://doi.org/
10.1016/J.UCLIM.2015.10.003.

[52] A. Middel, S. AlKhaled, F.A. Schneider, B. Hagen, P. Coseo, 50 Grades of shade,
Bull. Am. Meteorol. Soc. 1–35 (2021), https://doi.org/10.1175/BAMS-D-20-
0193.1.

[53] ISO 7726, Ergonomics of the thermal environment — Instruments for measuring
physical quantities 1998, https://www.iso.org/obp/ui/#iso:std:iso:7726:ed-2:v1:
en.

[54] I.D. Stewart, T.R. Oke, Local climate zones for urban temperature studies, Bull. Am.
Meteorol. Soc. 93 (12) (2012) 1879–1900, https://doi.org/10.1175/BAMS-D-11-
00019.1.

[55] The Commission for Thermal Physiology of the International Union of

Physiological Sciences (IUPS Thermal Commission). Glossary of terms for thermal
physiology, Pflugers Arch 410 (1987) 567–587. https://doi.org/10.1007/B
F00586542.

[56] C.V. G´al, N. K´antor, Modeling mean radiant temperature in outdoor spaces, A

comparative numerical simulation and validation study, Urban Clim. 32 (2020),
100571, https://doi.org/10.1016/J.UCLIM.2019.100571.

[57] I. Buo, V. Sagris, J. Jaagus, A. Middel, High-resolution thermal exposure and shade
maps for cool corridor planning, Sustain. Cities Soc. 93 (2023), 104499, https://
doi.org/10.1016/J.SCS.2023.104499.

[58] Z. Fang, H. He, Y. Mao, X. Feng, Z. Zheng, Z. Guo, Investigating an accurate method

for measuring the outdoor mean radiation temperature, Int. J. Therm. Sci. 188
(2023), 108219, https://doi.org/10.1016/J.IJTHERMALSCI.2023.108219.
[59] H. Staiger, A. Matzarakis, Accuracy of mean radiant temperature derived from
active and passive radiometry, Atmosphere 11 (8) (2020) 805, https://doi.org/
10.3390/ATMOS11080805, 2020, Vol. 11, Page 805.

[60] Z. Guo, Investigating an accurate method for measuring the outdoor mean

radiation temperature, International Journal of Thermal Sciences 188 (2023)
108219.

[61] P.J. Crank, A. Middel, M. Wagner, D. Hoots, M. Smith, A. Brazel, Validation of
seasonal mean radiant temperature simulations in hot arid urban climates, Sci.

BuildingandEnvironment248(2024)11105410M. Gholami et al.

Total Environ. 749 (2020), 141392, https://doi.org/10.1016/j.
scitotenv.2020.141392.

[62] J.A. Acero, J. Arrizabalaga, Evaluating the performance of ENVI-met model in
diurnal cycles for different meteorological conditions, Theor Appl Climatol 131
(2018) 455–469. https://doi.org/10.1007/s00704-016-1971-y.

[63] Helge Simon, Tim Sinsel, Bruse Michael, Advances in Simulating Radiative

Transfer in Complex Environments, Applied Sciences 11 (12) (2021) 5449. https://
doi.org/10.3390/app11125449.

[68] R. Aghamolaei, M.M. Azizi, B. Aminzadeh, P.A. Mirzaei, A tempo-spatial modelling
framework to assess outdoor thermal comfort of complex urban neighbourhoods,
Urban Clim. 33 (June) (2020), 100665, https://doi.org/10.1016/j.
uclim.2020.100665.

[69] G. Evola, V. Costanzo, C. Magrì, G. Margani, L. Marletta, E. Naboni, A novel
comprehensive workflow for modelling outdoor thermal comfort and energy
demand in urban canyons: results and critical issues, Energy Build. 216 (2020),
109946, https://doi.org/10.1016/j.enbuild.2020.109946.

[64] Z. Ouyang, P. Sciusco, T. Jiao, et al., Albedo changes caused by future urbanization

[70] Naboni E, Meloni M, Coccolo S, Kaempf J, Scartezzini JL. An overview of

contribute to global warming, Nat Commun 13 (2022) 3800. https://doi.
org/10.1038/s41467-022-31558-z.

[65] Colter et al., 2019K.R. Colter, A.C. Middel, C.A. Martin, Effects of natural and

artificial shade on human thermal comfort in residential neighborhood parks of
Phoenix, Arizona, USAUrban For. Urban Green., 44 (2019), Article 126429, htt
ps://doi.org/10.1016/j.ufug.2019.126429.

[66] F. Lindberg, B. Holmer, S. Thorsson, et al., Characteristics of the mean radiant
temperature in high latitude cities—implications for sensitive climate planning
applications, Int J Biometeorol 58 (2014) 613–627. https://doi.org/10.1007/s00
484-013-0638-y.

[67] Zhongjun Zhang, Yufeng Zhang, Adnan Khan, Thermal comfort of people from two
types of air-conditioned buildings - Evidences from chamber experiments, Building
and Environment, Volume 162, 2019, 106287, ISSN 0360-1323, https://doi.
org/10.1016/j.buildenv.2019.106287.

simulation tools for predicting the mean radiant temperature in an outdoor space
Volume 122, September 2017, Pages 1111-1116 ISSN: 1876-6102 (2017a). https
://doi.org/10.1016/j.egypro.2017.07.471.

[71] Ariane Middel, Kathrin H¨ab, Anthony J. Brazel, Chris A. Martin, Subhrajit

Guhathakurta, Impact of urban form and design on mid-afternoon microclimate in
Phoenix Local Climate Zones, Landscape and Urban Planning, Volume 122, 2014,
Pages 16-28, ISSN 0169-2046, https://doi.org/10.1016/j.landurbplan.2013.11.00
4.

[72] Heris, M. P., Muller, B., & Wilson, A. M. (2019). Why does planning matter in
microclimate management and urban heat mitigation? Journal of Planning
Education and Research. Advance online publication. https://doi.org/10.11
77/0739456X19883000.

BuildingandEnvironment248(2024)11105411
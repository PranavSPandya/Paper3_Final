Vol. 54: 21–34, 2012
doi: 10.3354/cr01103

CLIMATE RESEARCH
Clim Res

Published online August 3

OPENPEN
 ACCESS
CCESS

Daytime cooling efficiency and diurnal energy
 balance in Phoenix, Arizona, USA

Ariane Middel1,*, Anthony J. Brazel2, Shai Kaplan2, Soe W. Myint2

1Decision Center for a Desert City, Arizona State University, Tempe, Arizona 85287-8209, USA
2School of Geographical Sciences and Urban Planning, Arizona State University, Tempe, Arizona 85287-5302, USA

ABSTRACT: Summer daytime cooling efficiency of various land cover is investigated for the urban
core of Phoenix, Arizona, using the Local-Scale Urban Meteorological Parameterization Scheme
(LUMPS). We examined the urban energy balance for 2 summer days in 2005 to analyze the day-
time cooling-water use tradeoff and the timing of sensible heat reversal at night. The plausibility
of  the  LUMPS  model  results  was  tested  using  remotely  sensed  surface  temperatures  from
Advanced Spaceborne Thermal Emission and Reflection Radiometer (ASTER) imagery and refer-
ence  evapotranspiration  values  from  a  meteorological  station.  Cooling  efficiency  was  derived
from sensible and latent heat flux differences. The time when the sensible heat flux turns negative
(sensible heat flux transition) was calculated from LUMPS simulated hourly fluxes. Results indi-
cate that the time when the sensible heat flux changes direction at night is strongly influenced by
the heat storage capacity of different land cover types and by the amount of vegetation. Higher
heat storage delayed the transition up to 3 h in the study area, while vegetation expedited the sen-
sible heat reversal by 2 h. Cooling efficiency index results suggest that overall, the Phoenix urban
core is slightly more efficient at cooling than the desert, but efficiencies do not increase much with
wet fractions higher than 20%. Industrial sites with high impervious surface cover and low wet
fraction have negative cooling efficiencies. Findings indicate that drier neighborhoods with het-
erogeneous  land  uses  are  the  most  efficient  landscapes  in  balancing  cooling  and  water  use  in
Phoenix. However, further factors such as energy use and human vulnerability to extreme heat
have  to  be  considered  in  the  cooling-water  use  tradeoff,  especially  under  the  uncertainties  of
future climate change.

KEY  WORDS:    Urban  climate  ·  Sensible  heat  flux  transition  ·  Cooling  efficiency  ·  LUMPS  ·
Remote sensing · Land cover · Urban heat island · Phoenix

Resale or republication not permitted without written consent of the publisher

1.  INTRODUCTION

The urban heat island (UHI) effect is probably the
most intensively studied anthropogenic local change
in  climate  (Arnfield  2003).  Heat  islands  form  when
natural landscapes are urbanized. Impervious mate-
rials  store  a  large  amount  of  heat  during  the  day
and release it slowly at night, increasing the disparity
between rural and urban temperatures, especially at
night. The UHI effect has significant implications for
urban residents, particularly in arid regions. Ampli-
fied local temperatures increase energy demand for

air conditioning in the summer, contribute to air pol-
lution, re duce human comfort, and increase vulnera-
bility  to  ex treme  heat  events  (Harlan  et  al.  2006,
 Sarrat  et  al.  2006,  Grimmond  2007,  Hart  &  Sailor
2009).  Mitigating  the  UHI  effect  is  vital  to  enhance
the adaptive capacity of cities in arid regions and will
become  increasingly  important  in  the  future  with
continued  urban  expansion  and  population  growth
under global climate uncertainty.

A substantial body of literature has focused on UHI
mitigation strategies over the past decade and using
urban design as an effective measure has been pro-

*Email: ariane.middel@asu.edu

© Inter-Research 2012 · www.int-res.com

22

Clim Res 54: 21–34, 2012

posed by various studies (Baker et al. 2002, Stone &
Norman 2006, Coutts et al. 2007, Middel et al. 2011).
An important design strategy to improve local climate
in  places  with  dry  hot  summers  is  cooling  through
vegetation, because evapotranspiration (ET ) is an im-
portant  cooling  agent  in  arid  environments  (Bonan
2000). Pearlmutter et al. (2009) quantified the relation
between vegetative surface area and corresponding
latent  heat  flux  and  found  that  the  relationship  was
nearly linear. Gober et al. (in press) analyzed the ef-
fects of vegetation on nighttime cooling at the Census
block  group  scale  and  found  that  cooling  rates  of
air temperatures  at  the  boundary  layer  height  in
Phoenix, Arizona, double when the amount of vege-
tation is increased by 10%. Buyantuyev & Wu (2010)
report  nighttime  surface  temperature  differences  of
up to 9°C between paved surfaces and vegetation in
the  Phoenix  metropolitan  area  at  Advanced  Space-
borne  Thermal  Emission  and  Reflection  Radiometer
(ASTER) image scale (90 m resolution).

Previous  research  has  shown  that  land  cover
changes can purposefully alter the thermal environ-
ment, but adding vegetation in arid regions increases
irrigation  requirements  and  raises  concerns  about
water  scarcity  and  conservation.  Finding  a  balance
between  temperature  amelioration  and  water  con-
servation  in  mitigating  heat  islands  is  crucial  to
developing  more  sustainable  landscape  practices.
This tradeoff was investigated by Gober et al. (2009)
for  selected  areas  in  Phoenix  under  different  land
cover  scenarios.  Results  suggest  that  there  is  a
threshold  beyond  which  increased  vegetative  cover
does not significantly decrease UHI effects. Shashua-
Bar et al. (2009) conducted a controlled experiment to
analyze the cooling efficiency of different landscape
strategies in the arid Negev Highlands. They chose 2
adjacent  courtyard  spaces  with  a  similar  geometry
and materials, but different landscaping. The authors
set up 2 irrigation systems to provide each courtyard
with  sufficient  water  and  investigated  the  cooling
impact  of  6  combinations  of  trees,  grass,  and  shade
mesh. They found a combination of shade trees over
grass to be the most effective strategy.

Here, we build upon this cooling-water use tradeoff
research and systematically analyze the cooling char-
acteristics of various landscapes in Phoenix. Specifi-
cally, we address the question: How does land cover
influence  the  daytime  cooling  efficiency  in  the
Phoenix  urban  core  and  the  timing  of  sensible  heat
flux reversal at night? We used the Local-Scale Urban
Meteorological  Parameterization  Scheme  (LUMPS)
(Grimmond & Oke 2002, Loridan et al. 2011) to model
the surface energy balance above canopy as the basis

for our analysis. We tested the plausibility of our mod-
eling results with daytime and nighttime surface tem-
peratures from ASTER imagery and validated latent
heat fluxes using reference evapotranspiration values
from a nearby meteorological weather station. To in-
vestigate  the  daytime  tradeoff  between  water  de -
mand  of  irrigated  landscapes  and  the  amount  of
 cooling achieved, we adopted the cooling efficiency
index developed by Shashua-Bar et al. (2009, 2011).
Furthermore,  we  calculated  the  sensible  heat  flux
transition  time  (t0)  when  the  sensible  heat  flux
changes its direction from upwards to downwards at
night to investigate the variability of this timing and
its relation to the magnitude of the daytime integrated
heat storage. Our analysis of t0 at night and the day-
time  cooling  efficiency  of  different  landscapes  in
Phoenix will give vital insights to water stakeholders
and urban planners on how vegetation can be effec-
tively used to mitigate UHI effects under water con-
servation constraints.

2.  STUDY AREA

The Phoenix metropolitan area is a rapidly urban-
izing region in the Sonoran Desert of the southwest-
ern United States. It is an excellent site for investigat-
ing impacts of the UHI, because it is characterized by
growth  and  urban  development  (Gammage  2003).
From  2000  to  2010,  the  population  in  metropolitan
Phoenix grew by 29% to 4.1 million people (US Cen-
sus  Bureau  2010)  with  a  low  population  density  of
about  111  people  km−2,  making  it  the  13th  largest
metropolitan  area  in  the  United  States,  covering  an
area of 37 744 km2. Phoenix has an arid climate with
mean  maximum  air  temperatures  over  40°C  in  July
and average daily high air temperatures above 13°C
in  the  winter  (AZMET  2011).  Land  use  transforma-
tions  due  to  rapid  population  growth  over  the  past
50 yr have increased average daily air temperatures
in  the  Phoenix  core  by  almost  3.5°C  (Western  Re -
gional Climate Center 2011) and steadily de creased
nighttime  cooling.  Brazel  et  al.  (2000) documented
average minimum air temperature differences of up
to  6°C  between  rural  and  urban  sites  for  the  year
1995. More recent studies reported variations in the
Phoenix UHI effect between 6 and 13°C on a rural to
urban  gradient  (Hawkins  et  al.  2004,  Brazel  et  al.
2007). Urban development and associated land cover
changes  in  Phoenix  also  significantly  contribute  to
high  air  temperatures  in  extreme  heat  events  and
thus increase human vulnerability (Grossman-Clarke
et al. 2010).

Middel et al.: Diurnal energy balance in Phoenix

23

This study concentrates on a square area covering
approximately 51 census tracts in and around down-
town Phoenix (Fig. 1). The study area is composed of
diverse  land  use  and  land  cover  classes  (for  more
details  see  Fig.  2).  It  includes  urban  and  suburban
neighborhoods (commercial, industrial, and residen-
tial segments with different densities, see Fig. 5a) as
well as desert landscape, unmanaged soil, and unde-
veloped areas. Altogether, the study area is a repre-
sentative  cross-section  of  typical  land  cover  in  the
city of Phoenix.

3.  METHODS AND MATERIALS

We use the LUMPS version 5.3 developed by Grim-
mond & Oke (2002) to simulate the hourly urban sur-
face energy balance for the study area at the inertial
sub-layer. LUMPS models heat fluxes by partitioning

Fig. 1. Study area in the urban core of the city of Phoenix,
Arizona  (Phoenix  Downtown  33° 26’ 54’’ N,  112° 4’ 24’’ W)

the net all-wave radiation Q* into sensible heat flux
Q H, latent heat flux Q E, and heat storage ΔQ S:

Q* = Q E + Q H + ΔQ S

(1)

The  model  runs  at  a  local  or  neighborhood  scale
(0.01  to  100  km2)  with  few  input  requirements,  i.e.
basic  land  cover  information  (buildings,  impervious
surfaces,  soil,  grass,  trees  and  shrubs,  water)  and
standard weather observations (air temperature, rel-
ative  humidity,  incoming  solar  radiation,  precipita-
tion,  air  pressure)  at  flux  tower  height  (30  m).  To
 calculate the energy budget partitioning, LUMPS in -
corporates  the  Objective  Hysteresis  Model  (Grim-
mond  et  al.  1991)  for  heat  storage  parameterization
and  the  Net  All-wave  Radiation  Parameterization
(Offerle  et  al.  2003)  for  estimation  of  Q*.  Outputs
include  the  hourly  energy  budget  components  of
sensible and latent heat fluxes, heat storage, and net
all-wave radiation for the modeling period.

LUMPS  is  a  relatively  simple  model.  It  does  not
take  into  account  advection  processes  and  anthro-
pogenic heat, which are both assumed to be inherent
in  the  parameterization.  Yet,  LUMPS  has  been
proven to perform well in urban areas at a local scale.
The  model  was  evaluated  through  extensive  field
observations in 8 North American cities and 2 Euro-
pean cities (Grimmond 1992, Grimmond & Oke 1995,
1999, 2002, Offerle et al. 2006, Loridan et al. 2011).
LUMPS was further validated using airborne hyper-
spectral  images  of  Shanghai  (Xu  et  al.  2008).  More
recently, the model has been successfully applied in
Phoenix  and  Portland  to  analyze  summer  atmos-
pheric heating (Middel et al. 2011), climate variabil-
ity  and  evapotranspiration  (Middel  et  al.  in  press),
and cooling under different land cover scenarios and
future  climate  change  (Gober  et  al.  2009,  in  press,
House-Peters & Chang 2011).

3.1.  Land cover data

LUMPS 5.3 requires input for 6 land cover classes
per  unit  of  analysis:  buildings,  impervious  surfaces,
trees  and  shrubs,  unmanaged  soil,  grass,  and  water
bodies.  For  this  study,  we  derived  land  cover  from
Quickbird  imagery  (Fig.  2a)  with  4  multi-spectral
bands  (blue:  0.45− 0.52  µm,  green:  0.52−0.60  µm,
red: 0.63− 0.69 µm, near infrared: 0.76−0.90 µm) and
3 PCA  (Principal  Component  Analysis)  bands.  The
aerial image was acquired May 29, 2007 at a spatial
resolution  of  2.4  m.  It  covers  approxi mate ly  89 km2
of the central portion of the City of Phoenix. The re-
quired land cover classes (Fig. 2b) were de rived using

24

Clim Res 54: 21–34, 2012

Fig. 2. Land cover classification in the study area: (a) Quickbird aerial image acquired May 29, 2007 (vegetation is displayed
in red); (b) land cover classification derived from Quickbird imagery

an object-based approach developed by Myint et al.
(2011) at  an  overall  accuracy  of  89.9%.  The  results
were  aggregated  to  areas  of  90  m  ×  90  m  resulting
in a  total  number  of  11 025  grid  squares  to  satisfy
LUMPS  minimum  spatial  scale  and  to  match  the
 resolution  of  the  ASTER  image  used  for  plausibility
testing purposes. Fig. 3 summarizes the classification
results for the study area. ‘Impervious surfaces’ is the
prevailing land cover class with almost 28%. On av-
erage, buildings, soil, and grass amount to about 20%
each of the total area, while trees and shrubs are less
predominant,  adding  up  to  10%.  Water  bodies only
make up for 0.2% of the total land cover and mainly
represent swimming pools in the study area.

Fig. 3. Average land cover characteristics for the study area,
based on a sample of 11025 squares of 90 m × 90 m

3.2.  Weather data

To satisfy LUMPS weather input requirements, we
obtained  meteorological  observations  at  an  hourly
scale  from  the  Arizona  Meteorological  Network
(AZMET  2011).  The  AZMET  Encanto  Park  weather
station  is  located  roughly  in  the  center  of  the  study
area  and  is  assumed  to  be  representative  of  the
whole area, since detailed meteorological data were
not available at a fine spatial resolution. The 1 km2
area around the weather station has a building frac-
tion of 11.6%, encompasses 8.6% soil, 20.3% imper-
vious surfaces, and an overall wet fraction, i.e. grass,
trees,  and  water  bodies,  of  59.5%.  We  chose  July  6
and August 22, 2005 to test our LUMPS results, be -
cause  thermal  surface  remote  sensing  data  were
available to us for these dates. Local weather condi-
tions were optimal for our modeling approach: clear
skies, light or no wind, no precipitation, and typical
summer  air  temperatures  for  Phoenix  with  lows  of
between 23 and 27°C and afternoon highs between
40 and 42°C (Fig. 4).

3.3.  Q H transition time and cooling efficiency

We  calculated  t0 (when  the  sensible  heat  flux
changes its direction, in other words where Q H = 0)
from LUMPS hourly output. To determine the cooling

Middel et al.: Diurnal energy balance in Phoenix

=

f

25

(2)

·(–100)

Δ
Δ

Q
H
Q

E

We chose the desert as basic land cover, because it
is the natural landscape of the study area and allows
us to analyze the effects of anthropogenic changes on
the  urban  heat  and  water  balance.  The  amount  of
cooling  per  water  use  is  calculated  for  each  urban
area from differences in average daytime Q E, repre-
senting  water  use,  and  Q H between  each  LUMPS
run and a desert run.

As  fractions  for  the  desert,  we  used  95%  unman-
aged soil and 5% wet fraction to estimate desert-like
conditions  for  comparison  to  our  urban  locations.
Buyantuyev & Wu (2010) indicate the natural vegeta-
tion  cover  of  the  Sonoran  Desert  surrounding  the
Phoenix  area  is  Larrea-Ambrosia (a  creosote/white
bursage  series)  and  a  saltbush  series  of  Sonoran
Desert  scrub,  which  experience  significant  inter-
annual  variability  in  primary  productivity,  spatially
and temporally. Using data and results from Myint &
Okin  (2009),  we  analyzed  a  controlled  desert  scrub
sample  at  the  Desert  Botanical  Gardens  just  east  of
our study area (see Fig. 1) by estimating vegetation
cover  from  Landsat  imagery  (30  m  resolution)  for
June 2000, a drought year, in a preserved 0.25 km2
area.  Our  sample  estimate  yielded  6%  vegetative
cover.  Thus,  the  findings  shown  here  probably
underestimate  Q E and  overestimate  Q H slightly  for
the desert for 2005.

4.  MODEL TESTING

4.1.  Sensible heat flux

Surface  remote  sensing  has  been  widely  used  in
the  past  to  validate  flux  models  and  assess  UHI
effects (Weng 2009). Thermal infrared remote sens-
ing  sensors  employed  to  retrieve  land  surface  tem-
peratures  include  Landsat  TM/EMT+  (Chen  et  al.
2006), MODIS (Imhoff et al. 2010) to OMIS (Xu et al.
2008) and ASTER (Nichol et al. 2009, Cao et al. 2010,
Cai  et  al.  2011).  We  chose  ASTER  imagery  for  our
plausibility analysis, because ASTER provides more
bands in the long wave and short wave infrared than
other thermal sensors while still providing high spa-
tial resolution in the visible bands. Altogether, ASTER
images  contain  bands  in  the  electromagnetic  spec-
trum with a spatial resolution between 15 and 90 m.
We obtained ASTER images for the Phoenix metro-
politan  area  for  July  6,  2005  (daytime,  10:00  h)  and
August  22,  2005  (nighttime,  22:00  h)  with  a  spatial
resolution of 90 m. The weather conditions for these

Fig. 4. Hourly meteorological observations from the AZMET
(2011) Encanto Park weather station for July 6, 2005 and Au-
gust  22,  2005:  (a)  air  temperature  (°C);  (b)  incoming  solar
radiation (W m−2); (c) relative humidity (%)

efficiency of different landscape strategies, we adop -
ted  the  evaporative  cooling  efficiency  index  f from
Shashua-Bar et al. (2009, 2011). The efficiency index
f describes  the  ratio  (percent)  of  differences  in  Q E
and  Q H given  in  W  m−2 between  a  site  and  a  base
configuration:

26

Clim Res 54: 21–34, 2012

acquired  dates  were  typical  for  summer  days  in
Phoenix with no rainfall and mostly cloud-free condi-
tions. We calculated per-pixel land surface tempera-
tures  (°C)  from  the  5  ASTER  long  wave  infrared
channels  scaling  measured  radiances  by  per-pixel
emissivity,  which  is  calculated  with  the  Normalized
Emissivity Method (Gillespie et al. 1999, JPL 2001) as
part  of  a  Temperature  Emissivity  Separation  (TES)
algorithm.  This  algorithm  works  on  ‘land-leaving
thermal infrared (TIR) radiance’ ASTER data, which
have  already  been  corrected  for  atmospheric  trans-
missivity  and  upwelling  atmospheric  path  radiance
(Palluconi et al. 1994).

Fig. 5a−c illustrates general characteristics of land
use and day and night ASTER surface temperatures.
Land  use  characteristics  were  mapped  from  Mari-
copa  Association  of  Governments  (MAG)  2009  land
use  data.  Three  golf  courses  and  a  large  cemetery
highlight the coolest areas both day and night. Dur-
ing daytime these locales are some 22°C cooler than
commercial and downtown urban surfaces, and have
the  highest  NDVI  (Normalized  Difference  Vegeta-
tion Index) values. The more mesic neighborhoods in
the north of the scene, around Encanto Park, and to

Fig. 5. (a) Land use in the study area and ASTER images (resolution = 90 m) for (b) July 6, 2005, 10:20 h and (c) August 22,
2005, 22:20 h. O1 AZMET weather station; O2 downtown Phoenix; O3 Phoenix Sky Harbor International Airport

Middel et al.: Diurnal energy balance in Phoenix

27

the northeast and east are also cooler than downtown
by some 10 to 15°C. The nighttime image shows, as
expected, very warm features of the downtown and
mid-town area, the commercial strip to the west, air-
port  premises  to  the  extreme  southeast  corner,  and
areas  adjacent  to  and  along  major  transportation
streets,  such  as  shopping  malls  and  commercial
developments.  These  areas  are  8  to  12°C  warmer
than residential, cemetery, and golf course locations,
with the extreme case of the airport runway being in
excess of 12°C difference.

The LUMPS Q H was correlated with daytime and
nighttime ASTER surface temperatures as shown in
Fig.  6,  and  yielded  R2 values  of  0.53.  Note  for  the
nighttime graph, a cluster of points exceeding 35°C is
associated with positive Q H values. These values are
related to the high impervious surfaces areas in the
image. This delay of t0 has been reported by Grim-
mond & Oke (2002) and Harman & Belcher (2006). In
the daytime graph, a group of points have lower Q H,
yet  very  high  surface  temperatures.  We  found  that
these data result from points centered on very large,
homogeneous impervious areas (airport, transporta-
tion  center,  extensive  shopping  parking  areas).  It  is
possible  that  the  anthropogenic  heat  flux  (Q F),  not
included  in  the  LUMPS  version  we  used,  and  the
very  high  fraction  of  one  land  cover  type  (> 75%
impervious) could account for the outlying points in
Fig. 6. Comparing Shanghai surface temperatures to
LUMPS outputs and outputs from a model using the
aerodynamic  resistance  method  (ARM),  Xu  et  al.
(2008)  found  a  similar  anomaly  for  industrial  areas
whereby  the  anthropogenic  heat  flux  Q F appeared
to elevate  surface  temperatures  by  10  K  and  the
LUMPS model yielded values 140 W m−2 lower than

the ARM me thod. Phoenix typically experiences only
ca. 30 to 35 W m−2 for Q F in the summer (Grossman-
Clarke et al. 2005), which could account for some, but
not  all,  of  the  anomaly  of  Q H versus  temperatures
shown in Fig. 6 (which approaches 60 W m−2). This
highly  ano ma lous  value  is  understandable  in  the
context of the extreme heat source area noted above.
Another  possible  explanation  for  the  unexpected
deviations is that the Encanto Park AZMET weather
station is located in a greener neighborhood. The sta-
tion  data  do  not  reflect  the  atmospheric  conditions
over  ex tended  areas  with  high  heat  capacity  and
conductivity very well. Overall, Fig. 6 suggests that
there  is  an  association  between  sensible  heating  of
the  atmosphere  and  variations  in  surface  tempera-
tures across the urban area both day and night. The
relationship,  however,  is  not  exclusive,  because
urban surfaces and atmospheric processes are com-
plex, but we have no means of analyzing these with
LUMPS.

4.2 Latent heat flux

The  AZMET  network  offers  procedures  to  water
users and turf managers for calculating estimates of
properly watered Bermuda grass turf based on crop
coefficients KC for warm season grass and reference
 Penman-
evapotranspiration  ET0 derived
Monteith equations (Brown 1998). We determined a
turf  watered  scenario  from  the  AZMET  July  6  and
August  22,  2005  data  for  Encanto  Park  using  KC =
0.6  (properly  watered)  and  the  standard  value  of
ET0 provided  for  both  days.  The  AZMET  value
refers  to  a  uniform  grass  surface.  We  also  assumed

from

Fig. 6. Correlations between temperature and sensible heat flux (QH) in the study area for July 6, 2005, daytime (R2 = 0.53) and
August 22, 2005, nighttime (R2 = 0.53). Temperatures are based on ASTER images and QH on LUMPS model simulation of the
urban surface energy balance

28

Clim Res 54: 21–34, 2012

the  biweekly (once  every  2  wk)  flood  irrigation
schedule  maintained  properly  watered  landscapes.
This yielded values for ET of 4.41 and 3.96 mm d−1
for July 6 and August 22 respectively, with lowered
ET resulting from the cooler, more humid day of the
August  22  with  its  lower  solar  radiation.  We  deter-
mined LUMPS Q E estimates converted to ET in mm
d−1 for a ca. 0.16 km2 area (nine 90 m pixels) around
the station. Adjusting the AZMET turf estimates by
the  vegetation  fraction  of  the  area  under  investiga-
tion  (vegetation  fraction  ranges  from  0.69  to  0.89)
yields a range of 3.04 to 3.92 mm d−1 for July 6 and
2.73  to  3.52  mm  d−1 for  August  22.  Although  cer-
tainly not a definitive test of the LUMPS model, for
areas of high vegetation fraction the model appears
to  perform  well,  capturing  the  magnitude  and  tem-
poral variability, which is between 1  and  4%  of  the
AZMET estimates.

5.  RESULTS AND DISCUSSION

5.1.  Sensible heat flux transition time

In July, t0 ranges from 18:45 to 22:00 h. The sensi-
ble heat reversal in August starts later (20:00 h) and
the time frame is smaller. Our simulation results sug-
gest  that  t0 is  highly  correlated  to  the  daytime  total
heat  storage  be tween  05:00  and  19:00  h  (Fig.  7).
Areas with high impervious surface fraction build up
more heat storage during the day, which delays the
Q H transition at night. Daytime total integrated heat
storage and t0 are highly correlated with R2 = 0.97 in
July and R2 = 0.89 in August.

The time at which the sensible heat flux becomes
negative is delayed in areas with high storage heat,
but  accelerated  in  highly  vegetated  areas  (Fig.  8).
The relationship between wet fraction and Q H transi-
tion  times  t0 is  influenced  by  other  land  cover  frac-
tions  (impervious,  soil,  and  buildings)  in  the  mix
(Middel et al. in press). On average, the Q H transition
starts up to 2 h earlier in July for areas with a high
wet  fraction  and  up  to  1  h  earlier  in  August.  Fig.  8
suggests  that  the  cooling  capacity  of  vegetation
depends  on  atmospheric  conditions  and  is  reduced
in August  compared  to  July.  August  is  later  in  the
summer, incoming solar radiation is lower, and days
are  moister.  Therefore,  the  wet  fraction  shows  less
influence on the timing of Q H transition.

5.2.  Energy budget

Tables 1 & 2 summarize the mean, maximum and
minimum land cover fractions, flux partitioning, and
daily ET for the entire study area (N = 11 025 pixels).
For this older, central core area of the city of Phoenix,
the average wet fraction is 32%, of which an average
of 10% is trees and 22% is grass. We chose July 6,
2005  to  analyze  hourly  energy  fluxes  and  the  flux
ratios of Q E, Q H, and ΔQs to Q* for 3 types of energy
regimes in our study area in comparison to the desert
scenario. These 3 sample areas, marked on Fig. 9 and
listed  in  Table  3,  group  into  distinct  regimes  in  the
urban  environment  and  can  be  classified  into  local
climate  zones  (LCZ)  according  to  Stewart  &  Oke
(2010). Sample area 1 (mesic, open-set, low-rise LCZ)
is in a residential location with flood irrigation adja-

Fig. 7. Daytime total heat storage (ΔQS) vs. sensible heat flux transition time (t0) in the study area for July 6, 2005 (R2 = 0.97) and
August 22, 2005 (R2 = 0.89). Values for ΔQS are integrated for 05:00−19:00 h, when net all-wave radiation Q* > 0

Middel et al.: Diurnal energy balance in Phoenix

29

Fig. 8. Wet fraction (grass, trees, and water bodies) vs. sensible heat flux transition time (t0) in the study area for July 6, 2005
(R2 = 0.78) and August 22, 2005 (R2 = 0.76)

Table 1. Land cover characteristics, evapotranspiration (ET ), and heat flux partitioning for the study area, based on a sample of
11025 squares of 90 m × 90 m, for July 6, 2005. Q*: Net all-wave radiation; QH: sensible heat flux; QE: latent heat flux; ΔQS:
heat storage

               Buildings        Soil          Grass      Impervious      Water       Trees      Daily ET (mm)   Q H

(cid:2)Q*       Q E

(cid:2)Q*       Q S

(cid:2)Q*

Mean           0.200          0.195         0.221           0.279            0.002        0.102             1.734            0.382          0.225          0.394
Max.            0.732          0.797         0.847           0.948            0.053        0.461             3.743            0.550          0.520          0.660
Min.             0.000          0.016         0.000           0.003            0.000        0.000             0.664            0.210          0.060          0.250

Table 2. Land cover characteristics, ET, and heat flux partitioning for the study area, based on a sample of 11025 squares of
90 m × 90 m2, for August 22, 2005. See Table 1 legend for explanation of symbols

                Buildings        Soil          Grass      Impervious      Water       Trees      Daily ET (mm)   Q H

(cid:2)Q*       Q E

(cid:2)Q*       Q S

(cid:2)Q*

Mean           0.200          0.195         0.221           0.279            0.002        0.102             1.620            0.431          0.252          0.317
Max.            0.732          0.797         0.847           0.948            0.053        0.461             3.457            0.546          0.532          0.574
Min.             0.000          0.016         0.000           0.003            0.000        0.000             0.645            0.246          0.087          0.200

cent  to  a  golf  course.  Sample  area  2  (dry,  open-set,
low-rise LCZ) resembles many sites of urban, dry res-
idential  areas  near  commercial,  transportation,  and
downtown locations, and has been the focus of con-
cerns  about  heat  vulnerability;  greening  has  been
suggested  as  a  mitigative  measure  against  the  heat
(Harlan  et  al.  2006,  Chow  &  Brazel  2012).  Sample
area  3  (bare  concrete  LCZ)  is  Sky  Harbor  Airport.
This site has of 80.9% impervious surface cover and
19.1%  soil,  no  buildings  or  vegetation.  In  compari-
son, the desert site (sample area 4) can be classified
as  bare  soil  LCZ  with  95%  soil  and  only  5%  trees
(Table 3).

Figs. 10 & 11 show the LUMPS energy budget re -
sults for the 3 chosen landscapes, in comparison with

the desert.  The results for the urban landscapes are
what would be expected, given the extremes of lush,
flood irrigated, older residential landscapes in Phoenix
with wet fractions > 0.6 versus open paved urban sur-
faces with high impervious cover (0.81) at the airport.
Compared to the airport, the mesic open-set low-rise
LCZ site has almost an order of magnitude higher Q E
(Fig. 10) with a Q E to Q* ratio of 0.41 (Fig. 11), similar
to Grimmond & Oke’s (1999) Chicago and Sacramento
values  (C95  =  0.37  and  S91  =  0.33,  respectively).
Moreover,  the  area  has  half  the  heat  storage  ΔQ S,
considerably less Q H during the daytime, and slightly
less Q* (Fig. 10). The daytime ET estimates converted
from  Q E range  from  0.63  to  3.81  mm  d−1.  The  bare
concrete  LCZ  site  does  have  some  soil,  but  a  wet

30

Clim Res 54: 21–34, 2012

Fig. 9. Spatial distribution of cooling efficiency indices in the
study area: (a) July 6, 2005; (b) August 22, 2005. Circled num-
bers indicate location of representative sample sites: O1 mesic
open-set  low-rise  local  climate  zone  (LCZ); O2 dry  open-set
low-rise LCZ; O3 bare concrete LCZ (airport)

Table 3. Characteristics of 3 sample landscapes (see Fig. 9 for location) in comparison to the desert (see Fig. 1 for location),
showing land cover fractions, day and nighttime surface temperatures (°C) and calculated cooling efficiency. Sample land-
scape temperatures are based on ASTER images for the Phoenix metropolitan area at 10:00 h on July 6, 2005 and 22:00 h
on August 22, 2005; values for desert are extrapolated

                                 Buildings       Impervious         Soil           Trees         Grass         Water         Tday        Tnight         Cooling
                                                                                                                                                                                           efficiency

Mesic (1)                     0.115                0.095            0.076          0.286          0.426          0.002          45.7        30.4           3.381
Dry (2)                         0.210                0.318            0.383          0.025          0.064          0.000          58.5        37.4           57.632
Bare concrete (3)        0.000                0.809            0.191          0.000          0.000          0.000          58.7        34.1          −13.049
Desert (4)                    0.000                0.000            0.950          0.050          0.000          0.000        > 62.0      < 28.0              –

 fraction of zero. The resultant Q E to Q* ratio of 0.07
(Fig. 11) is similar to a Grimmond & Oke’s (1999) ratio
for their Mexico City urban site measurements (Me93)
of 0.04. The dry open-set low-rise LCZ site represents
more balance between Q H and Q E. Q H is lower, Q E is
slightly higher, and ΔQ S is higher compared to corre-
sponding fluxes of the desert (Fig. 10). Q E of the dry
site is almost 4 times lower than for the mesic site, and
Q H is correspondingly higher. From 08:00 to 22:00 h,
the mainly impervious site shows continued positive
Q H, whereas the mesic and desert sites cool down and
the dry area shows negative Q H at this time. ASTER
surface  temperatures  from  Fig.  5b−c  for  the  sample
areas show that the mainly impervious area and the
dry  neighborhood  are  indeed  warmer  at  night  than

the mesic and desert sites (Table 3), but a huge reduc-
tion  in  daytime  water  use  is  realized.  The  general
tradeoff for daytime is indicated by comparing values
of  Q E and  temperature  for  mesic  (Q E =  245  W  m−2;
45.7°C), impervious (Q E = 42 W m−2; 58.5°C), dry (Q E =
75  W  m−2;  58.7°C),  and  desert  (Q E =  73  W  m−2;
> 62.0°C) sites.

5.3.  Cooling efficiency

Using  the  cooling  efficiency  index  after  Shashua-
Bar et al. (2009, 2011) we estimated the ratio between
the sensible heat removed from the atmosphere and
the  amount  of  water  supplied  to  it  for  each  study

Middel et al.: Diurnal energy balance in Phoenix

31

Fig. 10. Diurnal heat fluxes for 3 representative sample sites and the desert for July 6, 2005

area.  Mathematically,  the  cooling  efficiency  index  f
is an asymptotic function. The curve increases or de -
creases until it approximates a certain value where it
levels off and grows without bounds. In our case, the
asymptote is the desert scenario. As wet fraction de -
creases, Q E is reduced towards the reference desert
Q E and eventually |ΔQ E| < 1. With ΔQ E getting infini-
tesimally  small  and  |ΔQ H| ≥  1,  the  efficiency  index

approaches  + ∞ or  −∞.  This  singularity  in  the  equa-
tion leads to difficulties when Q E approaches the ref-
erence Q E for sites that have a similar wet fraction as
our desert site, because f then becomes independent
of ΔQ H. We amplify on the utility of f and use it over
the  entire  range  of  possible  outcomes  for  Phoenix,
whereas Shashua-Bar et al. (2009, 2011) only investi-
gated a certain a range.

Fig. 11. Heat flux partitioning for representative sample sites in different local climate zones (LCZ) and the desert

32

Clim Res 54: 21–34, 2012

Fig.  12  shows  the  efficiency  index  graph  for  our
11 025  study  sites.  The  data  separate  into  2  curves:
points  that  have  a  higher  cooling  efficiency  index
than  the  desert  and  points  with  negative  efficiency
compared  to  the  desert.  The  cluster  of  points  with
less  cooling  efficiency  consists  of  study  sites  with
high  impervious  surface  cover  (> 0.6)  and  low  wet
fraction. These sites are mainly located in the indus-
trial zones of the study area and at the Phoenix air-
port,  Sample  site  3  (Fig.  9).  Most  parts  of  the  study
area have a positive efficiency index, but cooling effi-
ciencies  do  not  increase  with  wet  fractions  higher
than  0.2  and  asymptotically  approach  a  horizontal
line  (f  ~ 3.0).  The  graph  suggests  that  overall,  the
Phoenix urban core is slightly more cooling efficient
than  the  desert,  but  adding  vegetation  to  already
mesic neighborhoods does not increase efficiency. In
fact, the most efficient sites at cooling with minimal
water  consumption  are  dry  areas  such  as  Sample
site 2. These sites are mainly located in areas of high
land use mix (compare Figs. 9 & 5a).

Findings suggest that dry neighborhoods with het-
erogeneous  land  uses  are  the  most  efficient  land-
scapes in balancing cooling and water use. However,
the efficiency index is not a measure of absolute tem-
peratures. Although from a climatic water-tempera-
ture tradeoff aspect, dry landscaping is more efficient
than high water demand mesic land cover, tempera-
tures  in  drier  neighborhoods  are  much  higher  and
may  extend  beyond  an  unacceptable  temperature
comfort threshold (see Table 3). Thus, another trade-
off problem that remains to be solved from an urban
design perspective is the balance between the cool-
ing  efficiency  of  landscapes  determined  here  and
human vulnerability effects of extreme temperatures.

6.  CONCLUSIONS

The cooling efficiency index of Shashua-Bar et al.
(2009, 2011) provides a concept to compare ET and
atmospheric heating or cooling from the flux balance
between  Q E and  Q H in  the  context  of  a  tradeoff  of
water application to landscapes and the response of
sensible heating of the atmosphere contrasted with,
in  our  case,  a  natural  desert  setting.  We  realize  the
index was developed under a small-scale, controlled
experiment,  but  it  appears  useful  for  these  urban
scale analyses as well. However, future refinement of
the  efficiency  index  should  include  ΔQ S in  the  effi-
ciency  estimation  to  account  for  heat  retention  that
leads to warming the atmosphere at night.

We have established the general correspondence of
surface satellite-derived temperatures to outcomes of
Q H from the LUMPS model at a fine spatial resolution,
resulting  in  statistically  significant  relationships.  We
recognize  that  the  new  Surface  Urban  Energy  and
Water  Balance  Scheme  (SUEWS)  (Järvi  et  al.  2011)
would  provide  better  evaluations  of  the  Q E flux  for
Phoenix. This approach remains for further study, but
it is encouraging that fine resolution output of LUMPS
for the well-watered case generally compares well to
estimates of ET0 from standard water user approaches
that have been developed for this area. At this time,
we do not have the means of  testing the model over a
large range of vegetative fractions in the study area,
especially for the drier, more variable landscapes. To
a degree, comparison of Q H versus ASTER tempera-
tures indirectly tests the model. A thorough test of the
LUMPS models is  forthcoming with the new position-
ing of a flux tower in a drier neighborhood of central
Phoenix. We also acknowledge that we only use one

Fig. 12. Cooling efficiency index for all sites in the study area and representative sample sites: O1 mesic open-set low-rise LCZ;
O2 dry open-set low-rise LCZ; O3 bare concrete LCZ. A rational equation curve fit yields R2 = 0.68 for July 6 and R2 = 0.72 for
August 22

Middel et al.: Diurnal energy balance in Phoenix

33

weather station that is assumed to be representative
of the study area. The weather station is located near
a park and thus its measurements are influenced by a
greener  neighborhood.  By  using  the  same  input  air
temperatures for all sites, we neglect the feedback of
the  heat  fluxes  on  atmospheric  conditions.  In  that
sense, our analysis is a sensitivity study regarding the
influence of land cover variability in Phoenix on the
LUMPS modeling results.

Our results indicate that the nighttime Q H transition
in the inertial sub-layer is directly related to ΔQ S and
inversely related to the wet fraction of the landscape.
In  addition,  the  relationship  between  cooling  effi-
ciency and wet fraction reveals imbalances of cooling
relative  to  water  transferred  into  the  atmosphere
across  the  study  area.  Drier  areas  have  the  highest
cooling  efficiency,  i.e.  the  optimal  tradeoff  between
cooling  and  water  use,  and  are  mainly  located  in
areas  of  high  land  use  mix.  However,  Ruddell  et  al.
(2010) and Chow et al. (2012) revealed that drier land-
scapes in Phoenix are areas of high heat vulnerability,
considering  that  these  neighborhoods  are  inhabited
mainly by elderly, minority, and low-income residents.
When  only  cooling  efficiency  is  analyzed,  dry  areas
prove to be the most efficient; yet, when considering
human vulnerability, residents of dry areas are at risk
because  they  do  not  have  the  monetary  resources
needed  to  combat  dangerous  heat  waves.  Since  the
Phoenix summer is already uncomfortably hot, track-
ing  heat  intensity  patterns  is  very  important  to  help
avoid human health risks (Harlan & Ruddell 2011). In
addition to these multiple tradeoffs, there are further
factors to consider, such as energy use and costs, and
the effects of future climate change that may exacer-
bate the tradeoffs of heat vulnerability and water use,
particularly with the impending drier, warmer climate
predicted  for  the  southwest  USA  (Karl  et  al.  2009).
Multiple, perhaps contrasting, policies may be proposed
for these scenarios and decision makers will have to
determine  optimal  approaches  for  the  future  of  the
Phoenix  metropolitan  area,  assessing  the  tradeoff  of
cooling-water use while considering vulnerability.

Acknowledgements.  This  research  was  supported  by  the
National Science Foundation (Grant SES-0951366, Decision
Center for a Desert City II: Urban Climate Adaptation) and
by  the  German  Science  Foundation  (DFG,  grant  number
1131) as part of the International Graduate School (IRTG) at
University of Kaiserslautern, Germany. Any opinions, find-
ings, and conclusions or recommendations expressed in this
material  are  those  of  the  authors  and  do  not  necessarily
reflect the views of the sponsoring agencies. We gratefully
acknowledge Sue Grimmond and Leena Järvi for providing
the LUMPS model for use in Phoenix and Sally Wittlinger for
editorial support.

LITERATURE CITED

Arnfield AJ (2003) Two decades of urban climate research:  a
review  of  turbulence,  exchanges  of  energy  and  water,
and the urban heat island. Int J Climatol 23: 1−26

AZMET (The Arizona Meteorological Network) (2011)  http: //

ag. arizona.edu/azmet/

Baker LA, Brazel AJ, Selover N, Martin C and others (2002)
Urbanization  and  warming  of  Phoenix  (Arizona,  USA):
impacts,  feedbacks  and  mitigation. Urban  Ecosyst 6:
183−203

Bonan GB (2000) The microclimates of a suburban Colorado
(USA)  landscape  and  implications  for  planning  and
design. Landsc Urban Plan 49: 97−114

Brazel AJ, Selover N, Vose R, Heisler G (2000) The tale of
two cities:  Phoenix and Baltimore urban LTERs. Clim Res
15: 123−135

Brazel AJ, Gober P, Lee SH, Grossman-Clarke S, Zehnder J,
Hedquist B, Comparri E (2007) Determinants of changes
in  the  regional  urban  heat  island  in  Metropolitan
Phoenix  (Arizona,  USA)  between  1990  and  2004.  Clim
Res 33: 171−182

Brown PW (1998)  AZMET  computation  of  reference  crop

evapotranspiration. ag.arizona.edu/azmet/et2.htm

Buyantuyev A,  Wu J (2010)  Urban  heat  islands  and  land-
scape heterogeneity:  linking spatiotemporal variations in
surface  temperatures  to  land-cover  and  socioeconomic
patterns. Landscape Ecol 25: 17−33

Cai G, Du M, Xue Y (2011) Monitoring of urban heat island
effect  in  Beijing  combining  ASTER  and  TM  data. Int  J
Remote Sens 32: 1213−1232

Cao X,  Onishi A,  Chen J,  Imura H (2010)  Quantifying  the
cool  island  intensity  of  urban  parks  using  ASTER  and
IKONOS data. Landsc Urban Plan 96: 224−231

Chen X, Zhao H, Li P, Yin Z (2006) Remote sensing image-
based  analysis  of  the  relationship  between  urban  heat
island and land use/cover changes. Remote Sens Environ
104: 133−146

Chow WTL, Brazel AJ (2012) Assessing xeriscaping as a sus-
tainable heat island mitigation approach for a desert city.
Build Environ 47:170–181

Chow WTL,  Chuang WC,  Gober P (2012)  Vulnerability  to
extreme heat in metropolitan Phoenix:  Spatial, temporal,
and demographic dimensions. Prof Geogr 64:286–302
Coutts AM, Beringer J, Tapper NJ (2007) Impact of increas-
ing urban density on local climate:  spatial and temporal
variations  in  the  surface  energy  balance  in  Melbourne,
Australia. J Appl Meteorol Climatol 46: 477−493

Gammage G Jr (2003) Phoenix in perspective:  reflections of
developing  the  desert,  2nd  edn.  Herberger  Center  for
Design Excellence, Arizona State University, Tempe, AZ
Gillespie AR,  Rokugawa S,  Hook SJ,  Matsunaga T,  Kahle
AB (1999)  Temperature/emissivity  separation  algorithm
theoretical basis document, Version 2.4. prepared under
NASA Contract NAS5-31372, NASA, Washington, DC
Gober P,  Brazel A,  Quay R,  Myint S,  Grossman-Clarke S,
Miller A,  Rossi S (2009)  Using  watered  landscapes  to
manipulate urban heat island effects. J Am Plann Assoc
76: 109−121

Gober P, Middel A, Brazel AJ, Myint SW, Chang H, Duh JD,
House-Peters L (in press) Tradeoffs between water conser-
vation and temperature amelioration in Phoenix and Port-
land:  implications for urban sustainability. Urban Geogr
Grimmond CS (1992)  The  suburban  energy  balance:
methodological  considerations  and  results  for  a  mid-

34

Clim Res 54: 21–34, 2012

 latitude  west  coast  city  under  winter  and  spring  condi-
tions. Int J Climatol 12: 481−497

Grimmond CSB (2007)  Urbanization  and  global  environ-
mental change:  local effects of urban warming. Geogr J
173: 83−88

Grimmond CS,  Oke TR (1995)  Comparison  of  heat  fluxes
from  summertime  observations  in  the  suburbs  of  four
North American cities. J Appl Meteorol 34: 873−889

Grimmond CSB, Oke TR (1999) Heat storage in urban areas:
local-scale  observations  and  evaluation  of  a  simple
model. J Appl Meteorol 38: 922−940

Grimmond CSB,  Oke TR (2002)  Turbulent  heat  fluxes  in
urban areas:  observations and a local-scale urban meteo -
ro logical  parameterization  scheme  (LUMPS). J  Appl
Meteorol 41: 792−810

Grimmond CSB,  Cleugh HA,  Oke TR (1991)  An  objective
urban heat storage model and its comparison with other
schemes. Atmos Environ 25B: 311−326

Grossman-Clarke S,  Zehnder JA,  Stefanov WL,  Liu Y,
Zoldak MA (2005)  Urban  modifications  in  a  mesoscale
meteorological  model  and  the  effects  on  near-surface
variables in an arid metropolitan region. J Appl Meteorol
44: 1281−1297

Grossman-Clarke S, Zehnder JA, Loridan T, Grimmond CSB
(2010) Contribution of land use changes to near-surface
air  temperatures  during  recent  summer  extreme  heat
events in the Phoenix metropolitan area. J Appl Meteorol
Climatol 49: 1649−1664

Harlan S, Ruddell DM (2011) Climate change and health in
cities:  impacts of heat and air pollution and potential co-
benefits from mitigation and adaptation. Curr Opin Env-
iron Sustain 3: 126−134

Harlan S,  Brazel AJ,  Prashad L,  Stefanov WL,  Larsen L
(2006) Neighborhood microclimates and vulnerability to
heat stress. Soc Sci Med 63: 2847−2863

Harman IN, Belcher SE (2006) The surface energy balance
and  boundary  layer  over  urban  street  canyons. Q  J  R
Meteorol Soc 132: 2749−2768

Hart MA, Sailor DJ (2009) Quantifying the influence of land-
use  and  surface  characteristics  on  spatial  variability  in
the urban heat island. Theor Appl Climatol 95: 397−406
Hawkins TW, Brazel AJ, Stefanov WL, Bigler W, Saffell EM
(2004)  The  role  of  rural  variability  in  urban  heat  island
determination for Phoenix, Arizona. J Appl Meteorol 43:
476−486

House-Peters L,  Chang H (2011)  Modeling  the  impact  of
land  use  and  climate  change  on  neighborhood-scale
evaporation and nighttime cooling:  a surface energy bal-
ance  approach,  landscape  and  urban  planning. Landsc
Urban Plan 103:139–155

Imhoff ML,  Zhang P,  Wolfe RE,  Bounoua L (2010)  Remote
sensing of the urban heat island effect across biomes in
the continental USA. Remote Sens Environ 114: 504−513
Järvi L,  Grimmond CSB,  Christen A (2011)  The  surface
urban energy and water balance scheme (SUEWS). Eval-
uation  in  Los  Angeles  and  Vancouver.  J  Hydrol  411:
219–237

JPL (Jet Propulsion Laboratory) (2001) ASTER higher-level
product  user  guide.  California  Institute  of  Technology,
Pasadena, CA

Karl TR, Melillo JM, Peterson TC (eds) (2009) Global climate
change impacts in the United States. Cambridge Univer-
sity Press, New York, NY

Loridan T, Grimmond CSB, Offerle BD, Young DT, Smith T,
Järvi L (2011)  Local-scale  urban  meteorological  para -
meterization scheme (LUMPS):  longwave radiation para-
meterization  and  seasonality  related  developments.

J Appl Meteorol Climatol 50: 185−202

Middel A, Brazel A, Hagen B, Myint SW (2011) Land cover
modification scenarios and their effects on daytime heat-
ing  in  the  inner  core  residential  neighborhoods  of
Phoenix, AZ, USA. J Urban Technol 18: 61−79

Middel A, Brazel AJ, Gober P, Myint SW, Chang H, Duh JD
(in  press)  Land  cover,  climate,  and  the  summer  surface
energy  balance  in  Phoenix,  AZ  and  Portland,  OR.  Int  J
Climatol

Myint SW,  Okin GS (2009)  Modelling  land-cover  types
using multiple endmember spectral mixture analysis in a
desert city. Int J Remote Sens 30: 2237−2257

Myint SW, Gober P, Brazel A, Grossman-Clarke S, Weng Q
(2011)  Per-pixel  vs.  object-based  classification  of  urban
land  cover  extraction  using  high  spatial  resolution
imagery. Remote Sens Environ 115: 1145−1161

Nichol JE, Fung WY, Lam K, Wong MS (2009) Urban heat
island  diagnosis  using  ASTER  satellite  images  and  ‘in
situ’ air temperature. Atmos Res 94: 276−284

Offerle BD,  Grimmond CSB,  Oke TR (2003)  Parameteriza-
tion  of  net  all-wave  radiation  for  urban  areas. J  Appl
Meteorol 42: 1157−1173

Offerle B,  Grimmond CSB,  Fortuniak K,  Pawlak W (2006)
Intraurban differences of surface energy fluxes in a cen-
tral European city. J Appl Meteorol Climatol 45: 125−136
Palluconi FD,  Hoover G,  Alley R,  Jentoft-Nilsen M (1994)
Atmospheric  correction  method  for  ASTER  thermal
radiometry over land. Jet Propulsion Laboratory, Califor-
nia Institute of Technology, Pasadena, CA

Pearlmutter D,  Krüger EL,  Berliner P (2009)  The  role  of
evaporation in the energy balance of an open-air scaled
urban surface. Int J Climatol 29: 911−920

Ruddell DM, Harlan SL, Grossman-Clarke S, Buyantuyev A
(2010)  Risk  and  exposure  to  extreme  heat  in  micro -
climates  of  Phoenix,  AZ.  In:   Showalter  PS,  Lu  Y  (eds)
Geospatial  techniques  in  urban  hazard  and  disaster
analysis. Springer, New York, NY, p 179−202

Sarrat C, Lemonsu A, Masson V, Guedalia D (2006) Impact
of  urban  heat  island  on  regional  atmospheric  pollution.
Atmos Environ 40: 1743−1758

Shashua-Bar L,  Pearlmutter D,  Erell E (2009)  The  cooling
efficiency of urban landscape strategies in a hot dry cli-
mate. Landsc Urban Plan 92: 179−186

Shashua-Bar L, Pearlmutter D, Erell E (2011) The influence
of trees and grass on outdoor thermal comfort in a hot-
arid environment. Int J Climatol 31: 1498−1506

Stewart ID, Oke TR (2010) Thermal differentiation of local
climate  zones  using  temperature  observations  from
urban  and  rural  field  sites.  In:  Proc  Ninth  Symp  Urban
Environ, August 2010, Keystone, CO. AMS, p 1–7, http://
ams.confex.com/ams/19Ag19BLT9Urban/webprogram/
Paper173127.html

Stone B, Norman JM (2006) Land use planning and surface
heat  island  formation:   a  parcel-based  radiation  flux
approach. Atmos Environ 40: 3561−3573

US  Census  Bureau (2010)  2010  census  data.  http://2010.

census. gov/ 2010census/data/

Weng Q (2009) Thermal infrared remote sensing for urban
climate  and  environmental  studies:   Methods,  applica-
tions, and trends. ISPRS J Photogramm 64: 335−344

Western Regional Climate Center (2011) Recent climate in

the west. www.wrcc.dri.edu/

Xu W,  Wooster MJ,  Grimmond CS (2008)  Modelling  of
urban  sensible  heat  flux  at  multiple  spatial  scales:   a
demonstration  using  airborne  hyperspectral  imagery  of
Shanghai  and  a  temperature−emissivity  separation  ap -
proach. Remote Sens Environ 112: 3493−3510

Editorial responsibility: Helmut Mayer,
Freiburg, Germany

Submitted: September 29, 2011; Accepted: March 22, 2012
Proofs received from author(s): July 20, 2012


HHS Public Access
Author manuscript
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Published in final edited form as:
Int J Biometeorol. 2025 November ; 69(11): 2855–2869. doi:10.1007/s00484-024-02766-7.
The Development of an adaptive Heat Stress Compensability
Classification applied to the United States
Gisel Guzman-Echavarriaa,*, Ariane Middelb,c, Daniel J. Vecelliod, Jennifer Vanose
aSchool of Geographical Sciences and Urban Planning, Arizona State University, Tempe, AZ
85287-5302, USA.
bSchool of Arts, Media and Engineering, Arizona State University, Tempe, AZ 85287-5802, USA.
cSchool of Computing and Augmented Intelligence, Tempe, AZ 85287-8809, USA.
dDepartment of Geography/Geology, University of Nebraska at Omaha, Fairfax, NE 68182-0199,
USA
eSchool of Sustainability, Arizona State University, Tempe, AZ 85287-7904, USA
Abstract
Traditional climate classification and weather typing systems are not designed to understand
and prevent heat illness, or to design effective cooling strategies during extreme heat. Thus,
we developed the Heat Stress Compensability Classification (HSCC) combining open-source
historical weather data (2005–2020) with biophysical modeling of a standard human in the
sun or shade during peak city-specific hot hours on the top 10th percentile hottest days in 96
U.S. cities. Four categories of uncompensable heat stress (UHS)––which can result in rising
core temperature––were established based on the relative constraints of dry and evaporative
heat exchanges for achieving heat balance in proportion to constant metabolic heat production
(112Wm−2). Results show that 88.7% of these peak-hot hours met the UHS criterion, and 41%
presented a dry heat gain of 70 to 150Wm−2 while allowing a maximum evaporative loss between
90 and 140Wm−2. Evaporative heat loss constraints dominate the eastern U.S. Dry heat gain was
widespread, yet particularly high in the south and southwest. Full shade reduces UHS frequency to
7.6%, highlighting the importance of quality shade access and accounting for radiative load in heat
stress assessments. Although there are five distinct categories (one compensable and four UHS),
the HSCC is dynamic and customizable, providing actionable information on thermal variations
within a given category. These variations depict the reason for UHS (e.g., limited evaporative
cooling) and, thus, how to concentrate cooling efforts, particularly at the limits of physiological
adaptability. Findings facilitate developing targeted criteria for heat stress reduction with potential
global applications.
*Address correspondence to: Gisel Guzman-Echavarria, School of Geographical Sciences and Urban Planning, Arizona State
University, P.O. Box 875302 Tempe, AZ 85287-5302, gguzma20@asu.edu.
7Statements and Declarations
7All authors declare that they have no conflicts of interest.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 2
Keywords
Heat Stress Compensability Classification (HSCC); Extreme heat; Uncompensable Heat Stress;
Climate Classification; Mean Radiant Temperature; Biophysical heat-exchange model
1. Introduction
Various classification or categorization systems are used to identify climate regions
connected to vegetation and hydrology (Holdridge, 1947; Köppen, 1884; Thornthwaite,
1948), building energy use (Bai et al., 2020; Walsh et al., 2017b, 2017a), and various
public health applications (Liss et al., 2014). These systems explain expected environmental
conditions using select climate variables across a year/season (Gupta et al., 2023) and their
effects on various human or natural systems. Climate classification systems guide regional
building design by distributing spatial energy and water efficiency criteria, upholding indoor
comfort. For the specific case of the United States (U.S.), based on the International Energy
Conservation Code zoning, the Building America program updates climate zone designation
(Antonopoulos, C., T. Gilbride, E. Margiotta, 2022; Lstiburek, 2000). Yet, no system exists
to express weather or climate variables for environmental health applications, such as to
analyze extreme heat by location and identify the environmental heat stress and associated
physiological strain.
Extreme heat is a well-known and increasing physical hazard globally, with increased
prevalence linked to climate change and urban growth (Perkins-Kirkpatrick & Lewis, 2020),
further challenging the ability to cope with anomalous heat extremes (Krayenhoff et al.,
2018; Nazarian et al., 2022; Vecellio et al., 2023). Like other hazards, extreme heat events
are described in intensity, scale, timing (i.e., seasonally), and duration based on local
climatology (e.g., see Table 1 in Barriopedro et al. 2023). Health impacts of heat are often
recorded daily or across a heatwave, yet physiological effects from high heat exposure
can occur on sub-daily and hourly time scales (Baldwin et al., 2023). These impacts will
differ based on a person’s exposure to temperature, humidity, sunlight, and airflow, as well
as their activity levels and clothing. Moreover, research highlights that the physiological
underpinnings of heat strain in a humid heat versus a dry heat differ (Foster et al., 2021,
2022a, 2022b; Vanos et al., 2023; Vecellio et al., 2022). Finally, heat impacts are more
dangerous for certain groups of people, such as those more sensitive due to older age, lack
of acclimatization, low fitness, medication usage, and/or co-morbidities (Ebi et al., 2021;
Larose et al., 2013; Wolf et al., 2023).
Hence, climates can be classified not only by their impacts on environmental and built
systems (Gupta et al., 2023) but also by their probable physiological effects on humans,
supporting an improved understanding of health outcomes and suitable behaviors by sub-
population, time of year, location, intensity, etc. For example, specific behavioral adaptations
for heat relief (e.g., fan use) across varying climates and cultures require explicitly
characterizing the thermal environment and exposure for particular populations (Manu et
al., 2016; Morris et al., 2021). Such behavioral adaptations are increasingly necessary when
the body cannot physiologically cope with heat (i.e., under uncompensable heat stress -
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 3
UHS). Nevertheless, few studies differentiate “types” of heat geographically applied to
people’s health and potential physiological responses. Weather typing systems, such as
the Spatial Synoptic Classification (SSC) (Sheridan, 2002) and the Global Weather Typing
Classification (Lee, 2020), categorize daily weather by temperature and humidity, yet are not
applied to individual physiology. In the SSC, the “plus” categories (or warmer than normal)
have even been added to the tropical categories to delineate “extreme” conditions (Sheridan,
2002). The spatiotemporal relativity of these systems provides indirect measures of seasonal
and regional acclimatization for localized populations during extreme events, thus helping
to describe weather and health interactions (e.g., Greene et al. 2011, Vanos et al. 2015, and
Fonseca-Rodríguez et al. 2023). However, such studies are more epidemiological in nature,
and the classification systems were not created with any direct physiological implications in
mind.
Several heat or thermal stress indices have historically provided numerical representations
of thermal stress using meteorological inputs (de Freitas & Grigorieva, 2015, 2017; Ioannou
et al., 2022). Yet many metrics are static in their application over space and time and do
not allow for the inclusion of personal attributes complexities (as outlined in Grundstein &
Vanos (2020), Guzman-Echavarria et al. (2022) and Simpson (2024)). Further, those indices
do not provide information on reasons for heat loss restriction from the body and thus do
not support the implementation of effective cooling strategies. Instead, a biophysical human
heat exchange approach allows the determination of UHS by partitioning the different heat
avenues to and from the body. UHS is a condition that occurs when the body’s evaporative
cooling requirements cannot be supported due to environmental or other factors (including
low sweat production) impeding the body’s ability to cool (Bouchama et al., 2022; Leon &
Bouchama, 2015). Importantly, this approach can be applied across diverse subpopulations
and climates, both indoors and outdoors.
Thus, we introduce a new classification system––the Heat Stress Compensability
Classification (HSCC)––a weather-based characterization of extreme heat using the
biophysical heat exchange principles underpinning UHS. The system is applied to 96 cities
in the U.S. during the peak hot hours for the city-specific hottest 10% of days, as defined
by the 90th percentiles exceedance of daily maximums of dry-bulb (T ) and wet-bulb (T )
db w
temperatures from 2005–2020. The classification goes beyond a unidimensional “yes/no”
for extreme heat by discriminating between different types of “hot days” based on the
factors contributing to UHS. Therefore, this approach serves as a bridge, translating extreme
heat exposure into actionable knowledge by identifying the primary causes of unsafe heat
gain leading to UHS (such as high humidity or excessive radiative load) and providing direct
guidance to minimize the risk of people reaching a non-compensable state.
2. Materials and methods
In this study, we developed and applied a UHS classification using open-source long-term
weather data from 96 U.S. cities. We categorized the hottest hours of the 10% hottest days
as defined by both and T between 2005 and 2020 for a person with body characteristics
Tdb w
equivalent to the Universal Thermal Climate Index (UTCI) assumptions (details in section
2.3.2) while sun-exposed or in the shade. The cities were first selected to capture the most
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 4
populated metropolitan areas in the U.S. (>1M population) and later based on nationwide
geographical coverage. See Table S1 and Figure S1 for city metadata. The methods used
in this study are divided into three main steps: data preprocessing, data filtering (i.e.,
subsetting) to apply the categorization, and the HSCC categorization itself.
2.1 Climatic data preprocessing
Inputs of , atmospheric moisture ( , water vapor pressure), wind speed ( ), and
Tdb Pv ws
mean radiant temperature ( ) reaching an individual must be known to discern if
TMRT
the exposure to that thermal environment leads to UHS and within what UHS category
(Figure 2). Additionally, we included T to identify hot days, as we are interested in the
w
most oppressively hot conditions beyond (Section 2.2). Intending to use long-term
Tdb
weather records and freely available data, we combined airport weather station data and
estimated from modeled solar radiation (outlined below). , relative humidity
TMRT Tdb
and atmospheric pressure were taken from HadISD.3.3.0- global sub-daily station dataset
version v331_202301p (Dunn, 2019), available at https://www.metoffice.gov.uk/hadobs/
hadisd/. These values were used to estimate T with the Davies-Jones method (Davies-
w
Jones, 2008) and as our humidity metric (Baldwin et al., 2024). We assumed a constant
Pv
wind speed of 0.3 m/s to isolate differences in UHS from temperature, humidity, and solar
radiation. Future work will assess the sensitivity of UHS upon changing wind speeds (e.g.,
Foster et al. (2022); Morris et al. (2021)).
Global horizontal irradiation (GHI), direct normal irradiation ( ), and diffuse horizontal
DNI
irradiation ( ) were obtained from the National Solar Radiation Database (NSRDB)
DHI
(Sengupta et al., 2018), given that standard weather stations do not provide solar radiation
or in their records. NSRDB dataset is obtained from satellite-derived atmospheric
TMRT
and land surface properties using NREL’s Physical Solar Model (PSM). We used the
PSM V3.1 (4×4 km grid) version available at https://developer.nrel.gov/docs/solar/nsrdb/
psm3-download/.
2.1.1 Mean radiant temperature estimation: We calculated assuming that
TMRT
estimates will be representative of an open space with no close obstacles (sky view factor
= 1) over a flat weathered concrete surface with albedo , similar to the concrete
α = 0.186
roof surface in Vanos et al. (2021) and emissivity , like the C002 material in
εg= 0.92
Kotthaus et al. (2014). estimates were obtained from a mean radiant flux density
TMRT
approach as a weighted combination of 6-directional short- and long-wave radiant fluxes
to a standing man using the Stefan-Boltzmann law (Höppe, 1994; VID, 1994)(VID, 1994)
adapted as Middel et al. (2023).
Appendix A describes the process to estimate and Figure S2 displays the model
TMRT
performance of the radiative flux budget and the surface energy balance. This method
used NSRDB data, sun elevation, and azimuth angle for shortwave radiation estimates. In
this model, the incoming long-wave radiation ( ) applies the Stefan-Boltzmann law using
L
, shortwave estimates, and Prata's (1996) sky emissivity equation. For outgoing
Tdb, Pv
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 5
long-wave radiation, the Stefan-Boltzmann law and a surface energy balance solution for
urban areas were used (Oke et al. 2017), in which the net heat storage (or ground soil flux
in this case) was calculated using the Objective Hysteresis Model (Grimmond et al. 1991),
assuming coefficients for concrete urban facets (e.g., walls, ground) (Asaeda and Ca 1993).
In that approach, the surface temperature was derived from the energy heat balance at urban
facets (i.e., road), taking a bulk approach.
The estimation method for was calibrated using observations from Vanos et al. (2021)
TMRT
in Tempe, Arizona, U.S. (33.426°N, 111.940°W) from Aug 21st through Nov 8th, 2016, with
predominantly low cloud cover, obtaining an RMSE of 2.95°C. Errors in data
TMRT L
are similar to those reported by Lindberg et al. (2008) with a RMSE error of 23.15 Wm−2
(Figure S2). However, due to the sensible heat flux overestimation caused by assuming clear
sky conditions, estimates are expected to be slightly higher than otherwise observed.
TMRT
2.2 Hot days selection
To select the top 10% of hottest days in each city, we chose not to rely merely upon
Tdb
because the cause of heat stress would be biased towards dry-weather cities (Morris et
al., 2021). Therefore, we include to ensure that we also incorporate input data from
Tw
environments that lead to high heat stress in humid places. To select the most oppressive
conditions for and separately (Figure 1a and 1b, respectively), we aggregated
Tdb Tw
the hourly data to daily data based on the maximum daily temperature value (T )
max
for both metrics. Then, the hottest day samples for each city were determined based
on the exceedance of the 90th percentile. The final dataset thus represents the weather
corresponding to the days and hours from the joined sample of and (Figure 1c),
Tdb Tw
where repeated temporal records were included only once. Note that HSCC in the following
steps was applied only for the weather during those hottest hours of the day. Figure S3
displays the variability of , relative humidity, , and per city during the top
Tdb, Tw Pv TMRT
10% of hottest days.
2.3 Heat Stress Categorization
2.3.1 The rationale behind the different types of uncompensable heat stress:
From a biophysical perspective, heat stress is compensable when the heat produced by
the body’s metabolic processes and gained from the environment is ultimately offset
through increased evaporative heat loss (and, to a lesser extent, dry heat loss if T >T ),
sk db
enabling the human body to keep a stable internal temperature (Cramer et al., 2022).
This compensability can be expressed using human-environment heat exchange models
comparing the rate of evaporative heat loss required for heat balance ( ) and the
Ereq
maximum capacity for evaporative heat loss given a set of environmental and clothing
settings ( ). Thus, when , one experiences compensable heat stress (CHS),
Emax Ereq<Emax
and vice versa, when , UHS is experienced. can be expressed using
Ereq>Emax Ereq
the human heat balance equation (Eq.1) assuming null heat storage and negligible
mechanical work (i.e., the energy transferred to a force) and conductive heat exchange (i.e.,
):
S, K, Wk= 0 W
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 6
| Author Manuscript |                      |            |          | −2            |                   |
| ----------------- | -------------------- | ---------- | -------- | ------------- | ----------------- |
|                   | Ereq= M−Rskin−Cskin− | Cres− Eres | W, or Wm | if divided by | body surface area |
(Eq. 1)
| The assumption of negligible  |     |  is used to express that internal metabolic heat  |     |     |     |
| ----------------------------- | --- | ------------------------------------------------- | --- | --- | --- |
Wk=0
production ( Hprod ) is equivalent to metabolic rate ( M ).  Rskin  and  Cskin  represent rates of
dry heat exchange by radiation and convection through the skin and can be negative or
positive depending on whether there is heat loss or gain. That heat gain/loss relies on the
gradient between the skin temperature ( Tsk ) and operative temperature  t0  (i.e., a temperature
| value that combines the effect of T |     |  and radiant heat over a surface), in °C. |     |     |     |
| ----------------------------------- | --- | ----------------------------------------- | --- | --- | --- |
db
Tsk−t0
| Author Manuscript |     | Rskin+Cskin= |     | (Wm −2 ) |     |
| ----------------- | --- | ------------ | --- | -------- | --- |
1
Rcl+
|     |     |     | ℎc+r | + fcl |     |
| --- | --- | --- | ---- | ----- | --- |
(Eq. 2)
|     |  is the dry heat transfer resistance of clothing (m2 °C W−1),  |     |     |  is the combined  |     |
| --- | -------------------------------------------------------------- | --- | --- | ----------------- | --- |
| Rcl |                                                                |     |     | ℎc+r              |     |
convective heat transfer coefficient (Wm2°C−1)––or the sum of the convective ( ) and
ℎc
radiative ( ℎr ) heat transfer coefficients for airflow around humans–– and  fcl  is the clothing
area factor. For equations  ,  ,  , and  , see Cramer & Jay (2019) and Vanos et
|     |     | t0, Rcl ℎc ℎr, | fcl Ad |     |     |
| --- | --- | -------------- | ------ | --- | --- |
al. (2023). T  is held constant at 36°C (Parsons, 2014).
sk
In Equation 1,   and   represent the convective and evaporative heat exchange in the
|                                      | Cres | Eres |     |     |     |
| ------------------------------------ | ---- | ---- | --- | --- | --- |
| Author Manuscript respiratory tract: |      |      |     |     |     |
−2
|     |     | Cres= 0.0014·M | 34−Tair | Wm  |     |
| --- | --- | -------------- | ------- | --- | --- |
(Eq. 3)
−2
|     |     | Eres=0.0173·M | 5.87−Pv | Wm  |     |
| --- | --- | ------------- | ------- | --- | --- |
(Eq. 4)
Conversely,   accounts for environmental and clothing restrictions to body heat loss
Emax
via sweat evaporation (Eq.5). To consider the physiological capacity to wet the skin and
Author Manuscript
distribute sweat across the skin surface in humid environments,   is constrained to the
Emax
maximum skin wettedness (ωmax ). ωmax  represents the maximum percentage of the body
that can be covered by sweat, ranging from 0.85 for fully heat-acclimatized to 0.65 for
not heat-acclimatized or individuals older than 65 years (Candas et al., 1979; Morris et al.,
2021). In this application of the HSCC, we used an intermediate value of 0.7.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.

Guzman-Echavarria et al. Page 7
Psk,sat−Pv −2
Emaxenv =
1
(Wm )
Re,cl+
ℎe · fcl
(Eq. 5)
is the water vapor pressure at the skin surface when saturated with sweat (kPa),
Psksat Re,cl
is the evaporative resistance of clothing (m2kPa/W), and is the evaporative heat transfer
he
coefficient (Wm−2/kPa). The is calculated from T . For the equation for , see
Psksat sk ℎe
Cramer & Jay (2019).
Taking the heat compensability limit when equals the body’s capacity to lose heat via
Ereq
sweat evaporation (i.e., ), we replace terms from Equations 1 and 5 and
Ereq=ωmax·Emaxenv
rearrange the equation as a function of metabolic heat (Eq.6). Hence, from Equation 6, the
physiological problem of heat compensability can be seen as the possibility of overcoming
the internal heat production by achieving enough heat loss while considering the combined
environmental, clothing, and physical effect on heat balance. In turn, this formulation allows
us to group heat avenues into dry and evaporative heat balance components in proportion to
a constant value of , which is the foundation for categorizing the different types of UHS,
M
explained below.
−2
M= ωmax·Emax+ Eres + Rskin+Cskin+ Cres Wm
(Eq. 6)
Having the compensability/uncompensability limit at a fixed level of allows us to
M
describe extreme heat using UHS explained in terms of the main constraints in heat loss
by environmental conditions (i.e., constraints due to evaporative heat loss, dry heat loss, or
both). Graphically, this problem is shown in Figure 2.
Thus, the five categories of HSCC classification were established based on the relative
contributions of dry and evaporative heat exchanges in proportion to the internal metabolic
heat production to dissipate:
Category 0 Compensable heat stress (CHS): Heat stress is compensable because
total heat loss is equal to or greater than the metabolic heat production
( ). All conditions close to heat balance are
M< ω
max
·Emax+ Eres + Rskin+Cskin+ Cres
at the edge of the transition from CHS to UHS, exerting high heat stress on people.
Category 1 Low dry and evaporative heat losses: UHS occurs because evaporative
heat loss is not possible , and dry heat loss is small
ω
max
·Emax+ Eres <M
. This condition typically occurs in environments with high
0<Rskin+Cskin+ Cres<M
humidity (moisture) and air temperatures.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 8
Category 2 Dry heat gain with restricted evaporative heat loss: UHS occurs because
evaporative heat loss is not possible , and the body gains heat via
ω
max
·Emax+ Eres <M
convection and radiation . This condition typically occurs in
−M<Rskin+Cskin+ Cres<0
an environment with high humidity, air temperature, and solar radiation.
Category 3 Dry heat gain outweighs evaporative loss: UHS occurs despite possible
evaporative heat loss , but the heat gain via convection and radiation
M<ω
max
·Emax+ Eres
outweighs the evaporative heat loss .
ω
max
·Emax+ Eres + Rskin+Cskin+ Cres <M
This condition typically occurs in drier environments with high air temperatures and solar
radiation.
Category 4 Excessive dry heat gain: UHS occurs due to excessive heat gain (greater
than , whether or not evaporative heat loss is possible.
M Rskin+Cskin+ Cres< −M
This condition is common in arid environments with exceedingly high air temperatures and
intense solar radiation. This category is the most severe in this classification, adding that
sweat rate limits do not restrain evaporative loss, as in Vanos et al. (2023).
The HSCC system reports three types of results. First, a binary outcome describes whether
heat stress is compensable or uncompensable (Figure 3a). Second, heat stress typology is
defined when heat is uncompensable (Figure 3b and c, Table S3). Third, within UCH, we
can directly compare dry against evaporative heat losses, as summarized in the 2D histogram
of the human heat balance (Figure 5).
This third report type delineates the reasons for UHS grouping observations according to
their potential evaporative heat flux on the x-axis and dry heat exchange
ω
max
·Emax+ Eres
(loss or gain) on the y-axis, both in Wm−2. Given the fixed value of
Rskin+Cskin+ Cres
metabolic heat production, a diagonal line (Figure 5) expresses heat balance (total heat loss
= metabolic internal heat). In the same plots, the grey line indicates a null dry heat exchange
, the red line indicates where dry heat gain equals metabolic heat
Rskin+Cskin+ Cres=0
production , and the blue line separates conditions where
Rskin+Cskin+ Cres= −M
evaporative heat loss could surpass metabolic heat production .
ω
max
·Emax+ Eres =M
Note that the absolute values of heat flux thresholds from all categories depend on metabolic
heat production.
2.3.2 Physiological details for categorization application: To apply the HSCC,
we must specify an individual’s personal characteristics. For this initial iteration of the
HSCC, we adopt UTCI operational set-up characteristics (Bröde et al., 2012) representing a
healthy “average” adult male walking with a speed of 4km.h−1 (1.1ms−1) at ,
M= 2.3MET
wearing light clothes, with a mass of 73.4kg and height of 1.85m2 (Fiala et al., 2012),
resulting in or 111.79Wm−2 after a mass-based factor conversion. The human- M=206.8W
environment heat exchange estimations were done using the PyHHB module (Guzman-
Echavarria & Vanos, 2023) and UTCI adaptative clothing scheme capped at a minimum of
0.31CLO (Havenith et al., 2012; Vanos et al., 2012). Future work with this categorization
can use multiple physiological settings.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 9
3. Results
Results display the application of the HSCC during extreme heat conditions for 96
U.S. cities and demonstrate the importance of accounting for the radiative load in
biometeorological applications for heat stress. In addition, we provide examples of various
reporting methods possible with this system, highlighting the types of thermal environments
captured by each category given the personal profile used (which can be customized in
further applications).
3.1 Input data: weather during peak heat hours on the top 10% of warmest days
The environmental input data for the classification comprises 105,981 hourly observations
during the top 10% of the warmest days of each city based on and daily maximums.
Tdb Tw
exhibits a median (and interquartile range: IQR) of 32.8°C (30.0–34.6°C), ranging from
Tdb
a minimum of 15.0 to a maximum of 50.1°C. The mean is 65.9°C (60–70.1°C),
TMRT
ranging from 10.4 to 91.1°C, while has a mean of 21.3hPa (14.5–26.7hPa), ranging
Pv
from 0.5 to 47.7hPa. Relative humidity has a median of 44.6 (29.2–58.0%), ranging from
0 to 100%. The majority of peak hottest hours in each city occurred between June and
August (maximum in July) from 2:00–3:00pm local time, except San Juan-PR, Honolulu-
HI, Miami-FL, Melbourne-FL, and some cities along the Pacific Coast where peak heat
hours occurred mostly between 12:00–2:00pm. The hottest hours of occurrence from those
time frames along the Pacific Coast is mainly related to high . Appendix B in the
Tw
Supplemental Material describes weather variability between (Figure S3) and within all
cities (Figure S4, Table S2).
3.2 HSCC Heat Stress Categorization Results
We found that 88.7% of input data met the UHS criterion (Figure 3a), meaning that at least
during ~94,000 days weighted by city, people might be exposed to conditions in which they
had to engage in cool-seeking behavior to keep safe from the regional heat. However, there
is substantial heterogeneity in UHS typology across the cities studied (Figure 3b). Only nine
cities have more than 20% of observations within CHS, mainly in the northern U.S., while
26 present UHS conditions >95% of the time. The higher UHS frequencies are found in San
Juan (99.87%), Stockton-CA (93.37%), Melbourne-FL (98.13%), Orlando-FL (98.1%), and
Cape Coral-FL (98%).
Figure 3b shows the categorization results grouping the extreme heat values for all 96 cities.
Category 1 (low dry and evaporative heat losses) was assigned to only 0.46% of the
data, where only three cities reported >2% frequency (i.e., Monroe-MO, New Orleans-LA,
and Jacksonville-FL). Category 2 (Dry heat gain with restrictive evaporative heat loss)
accounts for 13.1% of data, with 36 cities, all concentrated in the east, having more than
20% of observations. San Juan (Figure 5c), Omaha-NE, Melbourne, New Orleans (Figure
5f) and Miami (5e) have the highest frequency of Category 2 (>34% observations), all
presenting low evaporative heat loss capacity values (<M) during extreme heat. Category
3 (dry heat gain outweighs evaporative loss) represents 30.7% of data, with higher
frequencies found in cities along the Pacific coast. For example, Santa Barbara-CA, San
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 10
Francisco-CA, and San Diego-CA present >75% of observations in Category 3. Category
4 (Excessive dry heat gain) is found in 44.5% of the cities, being the most frequent
category in the sample, with five having >75% observations in this category (Needles-CA,
Mc Allen-TX, Las Vegas-NV, Phoenix-AZ, and Dallas-TX) and 43 cities with >50%.
3.3 Weather conditions and personal heat loads by category
This section describes the weather conditions captured within each category (Figure 4d-f), as
well as heat loads and heat compensability in terms of the required skin wettedness ( ) to
ωreq
achieve heat balance (Figure 4a-c).
Category 0 has wider variations due to the CHS possibility under thermal environments that
lead to either high evaporative heat loss (dry environments) or higher dry heat loss (colder
temperatures) (see Table S4). As a result, possible dry and evaporative heat fluxes were the
widest compared to all categories (a median (IQR) of 30.2Wm−2 (−8.53, 56.67Wm−2) for
dry and 167.8Wm−2 (137.71, 193.82Wm−2) for evaporative heat fluxes). A slight variation
is found in the weather parameters in Category 1, shown by the smaller IQRs in Figure 5.
Although UHS is in this category, the median (0.76) is the lowest (hence, this is the
ωreq
least stressful category). Category 2 presents characteristics similar to Category 1, yet with
lower moisture levels and considerably higher ones (23.8°C greater based on median
TMRT
values). The higher moisture and are largely responsible for almost double (1.44)
TMRT ωreq
compared to category 1. The dry heat gain in Category 3 outweighs the evaporative heat
loss yet does not exceed metabolic heat production, resulting in a median of ~1.0.
ωreq
Category 4 presents the highest values of , and , yet a wide variation in
Tdb, TMRT GHI
moisture levels; hence, this category brings the possible occurrence of both very hot and
humid heat stress. As a result, the ranges of possible dry heat gain with a median (IQR) of
−133.82Wm−2 (−150.5, −122.23Wm−2) and the highest median (1.47), thus being the
ωmax
most severe HSCC category.
Overall, results from Categories 1–4 can be interpreted as the amount of cooling that
is possible for a group of sun-exposed people with average body characteristics and
clothing (i.e., UTCI profile) to keep them into CHS (Figure 5a). Beyond observations being
categorized, the histogram 2D shows that ~41% of the hottest hours of the 10% hottest
days from 2005–2020 exerted dry heat gain from 70 to 150Wm−2, allowing a maximum
evaporative loss between 90 and 140Wm−2. Thus, heat gain must be limited to these
thresholds while enhancing the evaporative heat flux to keep heat stress compensable.
3.4 Within-city variability in heat loads
As depicted in Section 3.2, a given city can present different types of (or reasons for)
UHS based on high heat that arises due to diverse synoptic genesis. This section presents
the possible heat loads on a person during extreme heat in U.S cities with the highest air
temperature combined with extremely high or low moisture levels, as well as some with the
coolest conditions (see Figure 5). We also present results from cities with the narrowest and
widest variability in and (Appendix B).
Tdb, TMRT Pv
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 11
San Juan (Figure 5c), located in the north of Puerto Rico with a tropical rainforest climate
(Köppen Af class), has the highest frequency of UHS, demonstrating high dry heat gains (up
to ~220Wm−2) in combination with low evaporative heat fluxes (~70–110Wm−2). Honolulu
(Figure 5k) (with a similar latitude as San Juan yet a semi-arid climate (Köppen BSh) has
most of its extreme heat days in category 3, where dry heat gain outweighs evaporative heat
loss (around 120–140Wm−2).
In the East, New York (Figure 5d) displays highly heterogeneous UHS behavior (spread
among numerous categories with no distinct clustering), which differs from Florida cities
and New Orleans, in which dry heat gain was often around 100Wm−2 (up to 200 Wm−2) yet
with low and narrow evaporative heat loss variations around 80 to 100Wm−2.
Cities located in the South and Southwest (highest and ) reveal the highest dry
Tdb TMRT
heat gains (~150Wm−2), reaching values of 240Wm−2 (see Phoenix and Tucson in Figure
5). Arizona cities also display the greatest values in maximum possible evaporative heat
losses (up to ~200Wm−2), which could even demand nonfeasible sweat rates for people with
impaired sweating. Another aspect relevant in Southwest cities is the apparent bimodality
in UHS, with high frequency at lower evaporative heat fluxes values (100–120Wm−2) that
should be associated with T inclusion in a hot day selection and, therefore, summer
w
monsoon days. Finally, the Pacific coast has more instances of CHS; when UHS occurs, it
is dominated by high values of evaporative heat loss and low dry heat gain (< ~150Wm−2)
when within Category 4 (Figure 5i-j).
3.5 The role of radiative heat load and uncompensable heat stress
The inclusion of radiant load in heat stress was tested by assuming a change from the
estimated initially (open, sun-exposed) versus full shade, wherein .
TMRT TMRT = Tdb
While maintaining maximum evaporative loss between 90 and 140W/m2, the overall effect
of shade shifts the dry heat gain into possible heat loss. This shift results in low dry heat
loss values from 5 to 50W/m2 (Figure5b) ~40% of the time, which could be enhanced
with increased wind speed to support further convective heat loss. This change represents
a reduction in the frequency of UHS to 7.62% (Figure3c and 5b) across all input data
(comprised of 3.27% in Category 1, 1.39% in Category 2, 2.96% in Category 3, and 0% in
Category 4).
4. Discussion
We report on the development and application of the Heat Stress Compensability
Classification (HSCC), which combines historical weather data with biophysical modeling
during peak city-specific hot hours, as defined by the 90th percentiles of daily maximums
for T and T over 15 years in 96 U.S cities. The classification uniquely uses fundamental
db w
principles from thermal physiology and human biophysics to determine the main avenues for
heat gain and loss to describe UHS on extreme heat days. In the long term, this knowledge
can support cooling procedures by category based on the heat flux values that best achieve
heat balance, adopting a similar standpoint as in building sciences to estimate cooling loads
(Mao et al., 2018).
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 12
The HSCC is the first climate-based classification system to focus on human heat health
from a person-centric approach because, unlike other systems and heat stress related
metrics (like the UTCI itself), it provides actionable data to support decisions on personal
heat-specific adaptations. Having a strong focus on human physiology, the HSCC can
act as a baseline to mitigate and adapt to extreme temperatures. The HSCC is dynamic
and customizable, allowing for more than just a categorical description of environmental
conditions, but information on thermal variations within a given category that informs
users about the reason for UHS (or dangerous heat) and, thus, how to change personal
cooling strategies or behaviors. The HSCC approach also overcomes drawbacks of common
bioclimatic models wherein solar radiation is not considered (e.g., NOAA’s Heat Index,
Humidex, T ), and its flexibility allows for future work adjusting metabolic heat loads along
w
with environmental factors (e.g., airflow).
4.1 Insights from HSCC to mitigate UHS
It is well-known that seeking shade is one of the top forms of human agency for reducing
heat exposure through behavioral adaptation (de Freitas, 2015; Horton et al., 2021). In
hot conditions, minimizing radiative heat sources is crucial to reduce heat stress, as
demonstrated in this research (Section 3.5). For the personal characteristics simulated in
this study, exposure to UHS conditions would occur only during 7.6% of days if people
stayed indoors or in the shade, as opposed to 88.7% of days when solar radiation exposure
is considered. Assuming implies no radiant thermal load contribution, which
TMRT = Tdb
is the most favorable scenario within shade effectiveness. However, some people may not
have the choice (e.g., working outdoors) or the ability to seek shade/indoors. For example, in
Phoenix (Figure 5f), on an average peak heat summer hour (3:30pm), dry heat gain is around
~153.5Wm−2. If a person stands outdoors in the shade (no change of T ), under a tree or
db
a lightweight engineered structure, the ΔT will be −22°C (Middel et al. 2021); hence, the
mrt
dry heat gain will reduce to 66Wm−2. The reduction would be even more (42.1Wm−2) if
covered by an urban form/building (ΔT = −28°C, Middel et al. (2021)). In such cases,
mrt
with evaporative losses between 120 and 180Wm−2, heat stress will be closer to, but not
quite compensable, requiring additional cooling actions to keep safe.
Several optimal low-cost personal cooling strategies are being tested to overcome the
dependency on mechanical cooling (air conditioning). For detailed information on the
benefits of individual cooling strategies, see Jay et al. (2021). Under non-extreme heat
conditions, when T is less than skin temperature, using fans simultaneously enhances
db
evaporative and convective heat fluxes. However, fan impact is strongly determined by air
temperature and humidity. Recent empirical and modeling studies have provided critical
insight into the optimal conditions for fan use across different populations and climates
(Foster et al., 2022; Morris et al., 2021; Ravanelli et al., 2017). Within the HSCC system, it
is implicit that beyond moisture levels linked to evaporative possible heat losses, the cooling
suggestions (e.g., cooling amount) per category will vary according to the magnitude of dry
heat exchanges and the metabolic load of the chosen sub-population-group (see Table 1).
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 13
4.2 Future Opportunities for Use
Although this initial HSCC application is delineated for U.S. cities and only one set of
personal characteristics, the method can be replicated using any set of weather observations,
physiological measurements, and metabolic workloads. The contextual findings for the
United States are comparable to other hot and dry/humid locations. However, the within-
city variability in many locations (e.g., coastal to inland regions; parks to open fields)
demonstrates that one “type” (or category) of extreme heat does not define a place. Thus,
heat mitigation strategies should be focused beyond the predominant type of climate and
understand the variability across the summer season and a region.
Unlike other heat stress assessment methods, the practical utility of the HSCC stems from
the limits of physiological adaptation. This categorization can evaluate diverse populations
performing different activities to determine their customized HSCC. For example, empirical
research reveals average dry heat exchanges from −1.5Wm−2 (humid experiments) to
76.9Wm−2 (dry experiments) in young, healthy adults without added radiant heat load in
their limits to physiologically adapt to heat (Vecellio et al., 2022), which are plausible values
in the current study (Figure 5b). Also, current research has shown that environmental limits
for heat adaptability decrease with moisture, activity, and age (Vecellio et al., 2022; Wolf
et al., 2021; Wolf et al., 2023). A calibrated HSCC by sub-population can give a more
nuanced understanding (yet improved guidance) for different populations experiencing high
heat loads. For example, modeling older adults (Vanos et al., 2023) and outdoor workers
with a higher metabolic load would increase the frequency of UHS across the map. Overall,
methods here can be expanded and improved based human-environmental heat exchange
models in interdisciplinary research (see Table 3 in Vanos et al. (2023)).
The HSCC model and data from other scientific fields can be used as actionable information
to guide extreme heat management, highlighting the role of personal cooling behavioral
adaptations for safety in different indoor or outdoor contexts (Baniassadi et al., 2019; Jay et
al., 2021; Larsen et al., 2022; Nazarian et al., 2022; Rempel et al., 2022; Samuelson et al.,
2020). There are also potential applications in heat planning and disaster preparedness (e.g.,
compounding disasters, blackouts), design of infrastructure and public spaces to withstand
extreme heat, and design, testing, and implementation of personal cooling strategies and
clothing.
4.3 Limitations
The initial HSCC formulation has assumptions regarding the type of human (based on
the UTCI-like average person), calm airflow, and unacclimatized humans, yet humans can
adapt through physiological adjustments, such as increasing sweating capacity (Périard et
al., 2015). Still, the model allows for size, shape, clothing, metabolic rate adjustments,
variations for acclimatization, and for medications that affect sweat rate. The main limitation
of this biophysical modeling approach are comprehensively outlined in Vanos et al. (2023)
in Table 3, including holding skin temperature constant at 36°C or the skin wettedness
values constant. As in Vanos et al. (2023), this method is able to represent exclusively
heat strain that leads to hyperthermia and not to cardiovascular collapse or renal failure,
acknowledging that heat stroke deaths are a fraction of total excess heat-related deaths (Ebi
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 14
et al., 2021; MCDPH, 2024; NYC Department of Health, 2024). We also acknowledge that
thermal environments at typical airport weather observation stations differ from people’s
daily experience (Kuras et al., 2017; Nazarian & Lee, 2021). Yet, these stations provide
long-term, consistent records and are helpful for city-wide, national-level surveillance
applications, as well as baseline data to model mitigation strategies and heat in indoor
environments.
5. Conclusions
This research introduces a novel classification system––the Heat Stress Compensability
Classification (HSCC)––to describe uncompensable heat stress, which may result in
rising core body temperature without altering one’s heat stress conditions. The HSCC
classification system is based on biophysical principles and thermal physiology, providing
relevant information about the type of heat stress experienced by a person as a function
of internal metabolic heat production. Using open-source historical weather data (2005–
2020), this new classification system is successfully applied across 96 U.S. cities for the
hottest hours in the hottest 10th of days (city-specific). In addition, this study introduces an
approach to estimate using weather station and radiation-modeled data to account for
TMRT
the importance of radiative load on heat stress.
Results from the HSCC are reported in three ways: 1) a binary compensable heat stress
outcome, 2) uncompensable, describing the typology, and 3) disaggregating the category
results within the human heat balance in a 2D histogram. Results show that 88.7% of the
evaluated city-hours met the UHS criterion. Said differently, people may have been exposed
to conditions in which they had to engage in cool-seeking behavior to keep safe (prevent
rising core temperature) for ~94,000 hours. Full shade reduced UHS frequency to 7.6%,
highlighting the importance of quality shade access and including radiative load in heat
stress assessments. The results from UHS categories help support decisions on changing a
thermal environment. The practical utility of this system over other traditional methods (like
UTCI or heat index) comes from its dynamic and customizable nature by 1) being adaptable
to determine limits for various populations and target activities in heat stress assessments,
and 2) providing graphical outputs showing how much heat needs to be mitigated to keep a
specific population group in a thermally compensable condition based on their activity (e.g.,
a person walking in this application).
At the limits of physiological adaptability or survivability, these findings align with
physiological theory and produce actionable information through the different ways of
communicating the results and facilitating the development of targeted criteria for heat stress
mitigation strategies with potential global applications. Finally, the HSCC demonstrates that
heat mitigation strategies should, and can, be focused beyond viability for the predominant
type of climate (place-specific) and account for the variability across the summer season and
on people (time- and person-specific).
Supplementary Material
Refer to Web version on PubMed Central for supplementary material.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 15
Acknowledgments
E.G. and JKV acknowledge funding from the National Science Foundation (NSF) Award #CMMI-2045663; AM
also acknowledges funding from NSF Award #CMMI-1942805.
DJV acknowledges funding from the National Institute on Aging Grant T32 AG049676
We thank the climate modeling and research groups of HadISD and NSRDB for producing and making available
their datasets. Data analysis and visualization code was developed using Python 3.8.8 and authors thank the teams
behind this open-source project, as well as NumPy, Matplotlib, Seaborn, Pandas, Folium, and Cartopy developers.
Bibliography
Antonopoulos C, Gilbride T, Margiotta E, and K C. (2022). Guide to Determining Climate Zone by
County: IECC and Building America 2021 Updates.
Bai L, Yang L, Song B, & Liu N (2020). A new approach to develop a climate classification for
building energy efficiency addressing Chinese climate characteristics. Energy, 195, 116982.
Baldwin J, Tarik B, Ebi KL, Ollie J, Lutsko N, & Vanos JK (2024). Humidity’s Role in Heat-Related
Health Outcomes: A Heated Debate. Environmental Health Perspectives, 131(5), 55001. 10.1289/
EHP11807
Baniassadi A, Sailor DJ, Scott Krayenhoff E, Broadbent AM, & Georgescu M (2019). Passive
survivability of buildings under changing urban climates across eight US cities. Environmental
Research Letters, 14(7). 10.1088/1748-9326/ab28ba
Barriopedro D, Ordóñez C, & Miralles DG (2023). Heat Waves : Physical Understanding and
Scientific Challenges. Reviews of Geophysics, 61(2). 10.1029/2022RG000780
Bernhard MC, Kent ST, Sloan ME, Evans MB, McClure LA, & Gohlke JM (2015). Measuring
personal heat exposure in an urban and rural environment. Environmental Research, 137, 410–418.
10.1016/j.envres.2014.11.002 [PubMed: 25617601]
Bouchama A, Abuyassin B, Lehe C, Laitano O, Jay O, O’Connor FG, & Leon LR (2022). Classic and
exertional heatstroke. Nature Reviews Disease Primers, 8(1). 10.1038/s41572-021-00334-6
Bröde P, Fiala D, Błażejczyk K, Holmér I, Jendritzky G, Kampmann B, Tinz B, & Havenith G (2012).
Deriving the operational procedure for the Universal Thermal Climate Index (UTCI). International
Journal of Biometeorology, 56(3), 481–494. 10.1007/s00484-011-0454-1 [PubMed: 21626294]
Candas V, Libert J, & Vogt J (1979). Human skin wettedness and evaporative efficiency of sweating.
Journal of Applied Physiology, 43(3), 522–528.
Cramer MN, Gagnon D, Laitano O, & Crandall CG (2022). Human Temperature Regulation Under
Heat Stress in Health, Disease, and Injury. Physiological Reviews, 102(4), 1907–1989. 10.1152/
PHYSREV.00047.2021 [PubMed: 35679471]
Cramer MN, Huang M, Moralez G, & Crandall CG (2020). Keeping older individuals cool in hot and
moderately humid conditions: wetted clothing with and without an electric fan. Journal of Applied
Physiology, 128(3), 604–611. 10.1152/japplphysiol.00786.2019 [PubMed: 32027545]
Cramer MN, & Jay O (2019). Cores of reproducibility in physiology partitional calorimetry. Journal of
Applied Physiology, 126(2), 267–277. 10.1152/japplphysiol.00191.2018 [PubMed: 30496710]
Davies-Jones R (2008). An Efficient and Accurate Method for Computing the Wet-Bulb Temperature
along Pseudoadiabats. Monthly Weather Review, 136(7), 2764–2785. 10.1175/2007MWR2224.1
de Freitas CR (2015). Weather and place-based human behavior: recreational preferences and
sensitivity. International Journal of Biometeorology, 59(1), 55–63. 10.1007/s00484-014-0824-6
[PubMed: 24710802]
de Freitas CR, & Grigorieva EA (2015). A comprehensive catalogue and classification of human
thermal climate indices. International Journal of Biometeorology, 59(1), 109–120. 10.1007/
s00484-014-0819-3 [PubMed: 24682541]
de Freitas CR, & Grigorieva EA (2017). A comparison and appraisal of a comprehensive range of
human thermal climate indices. International Journal of Biometeorology, 61(3), 487–512. 10.1007/
s00484-016-1228-6 [PubMed: 27568190]
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 16
Dunn RJH (2019). HadISD version 3: monthly updates. https://digital.nmla.metoffice.gov.uk/
digitalFile_13890750-fb6f-42c7-92df-1c4504621fae/
Ebi KL, Capon A, Berry P, Broderick C, de Dear R, Havenith G, Honda Y, Kovats RS, Ma W, Malik
A, Morris NB, Nybo L, Seneviratne SI, Vanos J, & Jay O (2021). Hot weather and heat extremes:
health risks. The Lancet, 398(10301), 698–708. 10.1016/S0140-6736(21)01208-3
Fiala D, Havenith G, Bröde P, Kampmann B, & Jendritzky G (2012). UTCI-Fiala multi-node model
of human heat transfer and temperature regulation. International Journal of Biometeorology, 56(3),
429–441. 10.1007/s00484-011-0424-7 [PubMed: 21503622]
Fonseca-Rodríguez O, Adams RE, Sheridan SC, & Schumann B (2023). Projection of extreme heat-
and cold-related mortality in Sweden based on the spatial synoptic classification. Environmental
Research, 239(Pt 2), 117359. 10.1016/j.envres.2023.117359 [PubMed: 37863163]
Foster J, Smallcombe J, Hodder S, Jay O, Flouris A, Nybo L, & Havenith G (2021). An
advanced empirical model for quantifying the impact of heat and climate change on human
physical work capacity. International Journal of Biometeorology, 65(7), 1215–1229. 10.1007/
s00484-021-02105-0 [PubMed: 33674931]
Foster J, Smallcombe J, Hodder S, Jay O, Flouris A, Nybo L, & Havenith G (2022). Quantifying the
impact of heat on human physical work capacity; part III: the impact of solar radiation varies with
air temperature, humidity, and clothing coverage. International Journal of Biometeorology, 66(1),
175–188. 10.1007/s00484-021-02205-x [PubMed: 34709466]
Foster Josh, Smallcombe JW, Hodder S, Jay O, Flouris AD, & Havenith G. (2022). Quantifying the
impact of heat on human physical work capacity; part II: the observed interaction of air velocity
with temperature, humidity, sweat rate, and clothing is not captured by most heat stress indices.
International Journal of Biometeorology, 66(3), 507–520. 10.1007/s00484-021-02212-y [PubMed:
34743228]
Greene S, Kalkstein LS, Mills DM, & Samenow J (2011). An Examination of Climate Change on
Extreme Heat Events and Climate–Mortality Relationships in Large U.S. Cities. Weather, Climate,
and Society, 3(4), 281–292. 10.1175/WCAS-D-11-00055.1
Grundstein A, & Vanos J (2020). There is no ‘Swiss Army Knife’ of thermal indices: the importance
of considering ‘why?’ and ‘for whom?’ when modelling heat stress in sport. British Journal of
Sports Medicine, bjsports-102920. 10.1136/bjsports-2020-102920
Gupta R, Mathur J, & Garg V (2023). Assessment of climate classification methodologies used in
building energy efficiency sector. Energy and Buildings, 113549.
Guzman-Echavarria G, Middel A, & Vanos J (2022). Beyond heat exposure — new
methods to quantify and link personal heat exposure, stress, and strain in diverse
populations and climates: The journal temperature toolbox. Temperature, 10(03), 358–378.
10.1080/23328940.2022.2149024
Guzman-Echavarria G, & Vanos J (2023). PyHHB: Physiological-based estimations of human
survivability and liveability to heat in a changing climate (Nature communications (1.0.0)).
Zenodo. 10.5281/zenodo.10020137
Hass AL, McCanless K, Cooper W, Ellis K, Fuhrmann C, Kintziger KW, Sugg M, & Runkle J (2022).
Heat exposure misclassification : Do current methods of classifying diurnal range in individually
experienced temperatures and heat indices accurately reflect personal exposure ? International
Journal of Biometeorology, 66(7), 1339–1348. 10.1007/s00484-022-02280-8 [PubMed: 35378617]
Havenith G, Fiala D, Błazejczyk K, Richards M, Bröde P, Holmér I, Rintamaki H, Benshabat Y, &
Jendritzky G (2012). The UTCI-clothing model. International Journal of Biometeorology, 56(3),
461–470. 10.1007/s00484-011-0451-4 [PubMed: 21607531]
Holdridge LR (1947). Determination of World Plant Formations From Simple Climatic Data. Science
(New York, N.Y.), 105(2727), 367–368. 10.1126/science.105.2727.367 [PubMed: 17800882]
Hondula DM, Kuras ER, Betzel S, Drake L, Eneboe J, Kaml M, Munoz M, Sevig M, Singh M,
Ruddell BL, & Harlan L (2021). Novel metrics for relating personal heat exposure to social
risk factors and outdoor ambient temperature. Environment International, 146, 106271. 10.1016/
j.envint.2020.106271 [PubMed: 33395929]
Höppe P (1994). A new procedure to determine the mean radiant temperature outdoors. Wetter Unt
Leben, 44, 147–151.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 17
Horton RM, de Sherbinin A, Wrathall D, & Oppenheimer M (2021). Assessing human habitability and
migration. Science, 372(6548), 1279–1283. 10.1126/science.abi8603 [PubMed: 34140379]
Ioannou LG, Mantzios K, Tsoutsoubi L, Notley SR, Dinas PC, Brearley M, Epstein Y, Havenith
G, Sawka MN, Bröde P, Mekjavic IB, Kenny GP, Bernard TE, Nybo L, & Flouris AD (2022).
Indicators to assess physiological heat strain–Part 1: Systematic review. Temperature, 00(00), 1–
36. 10.1080/23328940.2022.2037376
Jay O, Capon A, Berry P, Broderick C, de Dear R, Havenith G, Honda Y, Kovats RS, Ma W, Malik
A, Morris NB, Nybo L, Seneviratne SI, Vanos J, & Ebi KL (2021). Reducing the health effects
of hot weather and heat extremes: from personal cooling strategies to green cities. The Lancet,
398(10301), 709–724. 10.1016/S0140-6736(21)01209-5
Khomenok GA, Hadid A, Preiss-Bloom O, Yanovich R, Erlich T, Ron-Tal O, Peled A, Epstein Y, &
Moran DS (2008). Hand immersion in cold water alleviating physiological strain and increasing
tolerance to uncompensable heat stress. European Journal of Applied Physiology, 104(2), 303–
309. 10.1007/s00421-008-0693-y [PubMed: 18478254]
Köppen W (1884). Die Wärmezonen der Erde, nach der Dauer der heissen, gemässigten und kalten
Zeit und nach der Wirkung der Wärme auf die organische Welt betrachtet. Meteorologische
Zeitschrift, 1(21), 5–226.
Kotthaus S, Smith TEL, Wooster MJ, & Grimmond CSB (2014). Derivation of an urban materials
spectral library through emittance and reflectance spectroscopy. ISPRS Journal of Photogrammetry
and Remote Sensing, 94, 194–212. 10.1016/j.isprsjprs.2014.05.005
Krayenhoff ES, Moustaoui M, Broadbent AM, Gupta V, & Georgescu M (2018). Diurnal interaction
between urban expansion, climate change and adaptation in US cities. Nature Climate Change,
8(12), 1097–1103.
Kuras E, Richardson MB, Calkins MM, Ebi KL, Hess JJ, Kintziger KW, Jagger MA, Middel
A, Scott AA, Spector JT, Uejio CK, Vanos JK, Zaitchik BF, Gohlke JM, & Hondula DM
(2017). Opportunities and challenges for personal heat exposure research. Environmental Health
Perspectives, 125(8). 10.1289/EHP556
Larose J, Boulay P, Sigal RJ, Wright HE, & Kenny GP (2013). Age-related decrements in heat
dissipation during physical activity occur as early as the age of 40. PloS One, 8(12), e83148.
10.1371/journal.pone.0083148 [PubMed: 24349447]
Larsen L, Gronlund CJ, Ketenci KC, Harlan SL, Hondula DM, Stone B, Lanza K, Mallen E,
Wright MK, & O’Neill MS (2022). Safe at Home?: A Comparison of Factors Influencing Indoor
Residential Temperatures During Warm Weather Among Three Cities. Journal of the American
Planning Association, 0(0), 1–13. 10.1080/01944363.2022.2087724
Lee CC (2020). The gridded weather typing classification version 2: A global-scale expansion.
International Journal of Climatology, 40(2), 1178–1196.
Leon LR, & Bouchama A (2015). Heat stroke. Comprehensive Physiology, 5(2), 611–647. 10.1002/
cphy.c140017 [PubMed: 25880507]
Lindberg F, Holmer B, & Thorsson S (2008). SOLWEIG 1.0 - Modelling spatial variations of 3D
radiant fluxes and mean radiant temperature in complex urban settings. International Journal of
Biometeorology, 52(7), 697–713. 10.1007/s00484-008-0162-7 [PubMed: 18523814]
Liss A, Koch M, & Naumova EN (2014). Redefining climate regions in the United States of America
using satellite remote sensing and machine learning for public health applications. Geospatial
Health, 8(3), S467–S659.
Lstiburek JW (2000). Environmental Loads. Eighth Canadian Building Science Technology
Conference.
Manu S, Shukla Y, Rawal R, Thomas LE, & de Dear R (2016). Field studies of thermal comfort across
multiple climate zones for the subcontinent: India Model for Adaptive Comfort (IMAC). Building
and Environment, 98, 55–70. 10.1016/j.buildenv.2015.12.019
Mao C, Baltazar JC, & Haberl JS (2018). Literature review of building peak cooling load methods
in the United States. Science and Technology for the Built Environment, 24(3), 228–237.
10.1080/23744731.2017.1373700
MCDPH. (2024). 2023 Heat Related Deaths Report. www.maricopa.gov/ArchiveCenter/ViewFile/
Item/5820#:~:text=Maricopa County identified a total,related deaths were heat caused
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 18
Middel A, AlkhaLed S, Schneider FA, Hagen B, & Coseo P (2021). 50 Grades of Shade. Bulletin of
the American Meteorological Society, 102(9), E1805–E1820. 10.1175/BAMS-D-20-0193.1
Middel A, Huff M, Krayenhoff ES, Udupa A, & Schneider FA (2023). PanoMRT: Panoramic infrared
thermography to model human thermal exposure and comfort. Science of The Total Environment,
859, 160301. 10.1016/J.SCITOTENV.2022.160301 [PubMed: 36410476]
Morris NB, Chaseling GK, English T, Gruss F, Maideen M. F. Bin, Capon A, & Jay O. (2021). Electric
fan use for cooling during hot weather: a biophysical modelling study. The Lancet Planetary
Health, 5(6), e368–e377. 10.1016/S2542-5196(21)00136-4 [PubMed: 34119011]
Nazarian N, Krayenhoff ES, Bechtel B, Hondula DM, Paolini R, Vanos J, Cheung T, Chow WTL,
de Dear R, Jay O, Lee JKW, Martilli A, Middel A, Norford LK, Sadeghi M, Schiavon S, &
Santamouris M (2022). Integrated Assessment of Urban Overheating Impacts on Human Life.
Earth’s Future, 10(8). 10.1029/2022EF002682
NYC Department of Health. (2024). 2023 NYC Heat-Related Mortality Report. https://a816-
dohbesp.nyc.gov/IndicatorPublic/data-features/heat-report-archive/2023/
Parsons K (2014). Human Thermal Environments (Third edit). CRC Press. 10.1201/b16750
Périard JD, Racinais S, & Sawka MN (2015). Adaptations and mechanisms of human heat
acclimation: Applications for competitive athletes and sports. Scandinavian Journal of Medicine
and Science in Sports, 25(S1), 20–38. 10.1111/sms.12408 [PubMed: 25943654]
Perkins-Kirkpatrick SE, & Lewis SC (2020). Increasing trends in regional heatwaves. Nature
Communications, 11(1), 1–8. 10.1038/s41467-020-16970-7
Prata AJ (1996). A new long-wave formula for estimating downward clear-sky radiation at the
surface. Quarterly Journal of the Royal Meteorological Society, 122(533), 1127–1151. 10.1002/
qj.49712253306
Ravanelli NM, Gagnon D, Hodder SG, Havenith G, & Jay O (2017). The biophysical and
physiological basis for mitigated elevations in heart rate with electric fan use in extreme heat and
humidity. International Journal of Biometeorology, 61(2), 313–323. 10.1007/s00484-016-1213-0
[PubMed: 27473105]
Rempel AR, Danis J, Rempel AW, Fowler M, & Mishra S (2022). Improving the passive survivability
of residential buildings during extreme heat events in the Pacific Northwest. Applied Energy,
321(May), 119323. 10.1016/j.apenergy.2022.119323
Samuelson H, Baniassadi A, Lin A, Izaga González P, Brawley T, & Narula T (2020). Housing as
a critical determinant of heat vulnerability and health. Science of the Total Environment, 720.
10.1016/j.scitotenv.2020.137296
Sengupta M, Xie Y, Lopez A, Habte A, Maclaurin G, & Shelby J (2018). The National Solar
Radiation Data Base (NSRDB). Renewable and Sustainable Energy Reviews, 89(March 2018),
51–60. 10.1016/j.rser.2018.03.003
Sheridan SC (2002). The redevelopment of a weather-type classification scheme for North America.
Int J Climatol, 22(1), 51–68.
Simpson CH (2024). Comment on Havenga et al.(2022): Standard heat stress indices may not be
appropriate for assessing marathons. South African Journal of Science, 120(1/2).
Thornthwaite CW (1948). An Approach toward a Rational Classification of Climate. Geographical
Review, 38(1), 55–94. http://www.jstor.org/stable/210739
Tony Wolf S, Cottle RM, Fisher KG, Vecellio DJ, & Larry Kenney W (2023). Heat stress vulnerability
and critical environmental limits for older adults. Communications Earth & Environment, 4(1),
486. 10.1038/s43247-023-01159-9 [PubMed: 38293008]
Vanos JK, Kalkstein LS, & Sanford TJ. (2015). Detecting synoptic warming trends across the US
Midwest and implications to human health and heat-related mortality. International Journal of
Climatology, 35(1), 85–96. 10.1002/joc.3964
Vanos J, Warland J, Gillespie T, & Kenny N (2012). Improved predictive ability of climate-
human-behaviour interactions with modifications to the COMFA outdoor energy budget
model. International Journal of Biometeorology, 56(6), 1065–1074. 10.1007/s00484-012-0522-1
[PubMed: 22350422]
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 19
Vanos Jennifer, Guzman-Echavarria G, Baldwin JW, Bongers C, Ebi KL, & Jay O. (2023). A
physiological approach for assessing human survivability and liveability to heat in a changing
climate. Nature Communications, 14(1), 1–14. 10.1038/s41467-023-43121-5
Vanos Jennifer K, Rykaczewski K, Middel A, Vecellio DJ, Brown RD, & Gillespie TJ. (2021).
Improved methods for estimating mean radiant temperature in hot and sunny outdoor settings.
International Journal of Biometeorology, 65(6), 967–983. 10.1007/s00484-021-02131-y [PubMed:
33909138]
Vecellio DJ, Kong Q, Kenney WL, & Huber M (2023). Greatly enhanced risk to humans as a
consequence of empirically determined lower moist heat stress tolerance. Proceedings of the
National Academy of Sciences, 120(42), e2305427120. 10.1073/pnas.2305427120
Vecellio DJ, Wolf ST, Cottle RM, & Kenney WL (2022). Evaluating the 35°C wet-bulb temperature
adaptability threshold for young, healthy subjects (PSU HEAT Project). Journal of Applied
Physiology, 132(2), 340–345. 10.1152/japplphysiol.00738.2021 [PubMed: 34913738]
VID. (1994). Part 2: environmental meteorology, interactions between atmosphere and surface;
calculation ofshort-and long wave radiation. In VDI 3789.
Walsh A, Cóstola D, & Labaki LC (2017a). Comparison of three climatic zoning methodologies for
building energy efficiency applications. Energy and Buildings, 146, 111–121.
Walsh A, Cóstola D, & Labaki LC (2017b). Review of methods for climatic zoning for building energy
efficiency programs. Building and Environment, 112, 337–350.
Wolf ST, Folkerts MA, Cottle RM, Daanen HAM, & Kenney WL (2021). Metabolism- And sex-
dependent critical WBGT limits at rest and during exercise in the heat. American Journal of
Physiology - Regulatory Integrative and Comparative Physiology, 321(3), R295–R302. 10.1152/
ajpregu.00101.2021 [PubMed: 34259026]
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 20
Fig. 1.
The resulting temperature sample from all 96 cities with the associated time-matching
moisture levels during the daily T above the 90th percentile for (a) , (b) , and (c)
max Tdb Tw
the joined dataset of (a) and (b). For the number of observations in the joined dataset, if an
observation and match in day and time of day, it is counted once. If the same day is
Tdb Tw
identified but and peak at different times, those observations are treated separately
Tdb Tw
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 21
Fig 2.
Schema of compensable vs uncompensable heat stress (UHS) and different categories of
UHS based on the relative contributions of dry and evaporative heat
Rskin+Cskin+ Cres
exchanges in proportion to a fixed value of internal metabolic heat
ω
max
·Emax+ Eres
production ( ). The green line divides compensable (light green area) from uncompensable
M
heat stress (light red area); the grey line indicates the limit between dry heat loss/gain; the
blue line divides the area where evaporative heat loss is enough to dissipate metabolic heat;
and the red line delineates when dry heat gain is higher than metabolic heat production
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 22
Fig. 3.
Proportion of days with compensable and uncompensable heat stress from the top 10th
percentile of hottest days in 96 U.S cities based on the peak and from 2005–2020. (a)
Tdb Tw
Display results as a binary compensable-uncompensable heat stress outcome, while (b and
c) detail the type of UHS (Categories 1 to 4). For (b) the categorization is applied for heat
exposures with an estimated as sun-exposed conditions, whereas in (c) the results
TMRT
applied for a person is entirely shaded ( ). An interactive version of the (b) plot
TMRT = Tdb
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 23
is available in https://zenodo.org/records/10899894, along with 2D histograms (as in Figure
5) with the heat balance results for each city. Input data for these graphics are in Table S3.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 24
Fig. 4.
Variability per category of (a) potential evaporative heat loss, (b) dry heat exchanges
(positive = loss, negative = gain, grey line: null heat dry exchanges), (c) required skin
wettedness ( ) to achieve heat balance (green line = , the grey background indicates
ωreq ωmax
values above 1 (or 100% of skin surface) which are not physically feasible), (d) , (e)
ωreq Tdb
, and (f) . Boxes indicate IQR with the median marked by a black inside line, with
Vp TMRT
whiskers indicating the 5th and 95th percentile. Minimum and maximum values are shown as
points. Median and IQR from a-f subplots are reported in Table S4 in the S.M.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Guzman-Echavarria et al. Page 25
Fig 5.
2D histograms displaying the relative frequency of observations disaggregated into bins
of 10 Wm−2, indicating the relative contributions of evaporative (x-axis) and dry (y-axis)
heat exchanges in proportion to a fixed value of internal metabolic heat production
(M=111.8Wm−2). Data are provided for all input data (a, b) and select city examples: San
Juan (c), New York (d), Miami (e), New Orleans (f), Phoenix (g), Tucson (h), Santa Barbara
(i), Seattle (j), and Honolulu (k). In (a) heat fluxes represent heat exposures with estimated
as sun-exposed conditions, and (b) heat exposures for a person who is fully shaded
TMRT
( ). The histogram plots for all cities are shown in the interactive version of
TMRT = Tdb
Figure 3 in https://zenodo.org/records/10899894.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript

Author
Manuscript
Author
Manuscript
Author
Manuscript
Author
Manuscript
Guzman-Echavarria et al. Page 26
Table 1.
Insight from this first HSCC application for the different categories and appropriate heat strain mitigation
strategies beyond air conditioning. Note that the evidence stated here comes from both empirical and
theoretical studies, and that strategies that might work as heat stress relief upon compensable heat stress might
only work for the delay or relief on heat strain, and thus require further cooling for keeping people safe during
long heat exposures.
Category Actions
Moving out of direct sunlight significantly lessens overall heat load (see Section 3.5) and should be the first action
For all categories taken. Regardless of humidity and clothing, if air temperature ≤ 30°C at moderate exercise, fans will increase the
benefits from convective heat loss (Foster et al., 2022), although their effectiveness can extend at rest to 39°C for
young adults, 38°C for older, and 37°C for older adults taking anticholinergic medication (Morris et al., 2021). Other
options include optimizing clothing to avoid heat gain while allowing sweat evaporation and conductive heat loss
strategies to alleviate heat strain as cold water immersion of extremities (Khomenok et al., 2008) and the use of wet
clothing (Cramer et al., 2020). Maintaining hydration is paramount to avoid additional strain across all categories.
Category 0 People are safely able to balance in the given conditions, yet if they are near the UHS limit, they might feel
(Compensable heat some thermal discomfort, thus people may actively seek various forms of cooling to keep safe and achieve thermal
stress) comfort.
Category 1 (Low dry In this least serious of categories, people can focus on increasing the dry and evaporative heat losses, for example,
and evaporative heat by using fans (depending on the air temperature) and enhancing cooling by reducing clothing amount or insulation.
losses) Given low evaporative heat losses, it is suggested to avoid evaporative coolers or misting, particularly without
additional airflow.
Category 2 (Dry heat Actions should be taken to reduce or reverse dry heat gain. With high moisture in the air, even if T db is around 36°C,
gain with restricted the effect of fan use may help delay heart rate increase in the heat due to enhancing evaporative heat loss (Ravanelli
evaporative heat loss) et al., 2017). Cooling methods, like evaporative coolers or misters, that add moisture to the air should not be used,
particularly without additional airflow.
Category 3 (Dry Actions should be taken to reduce or reverse dry heat gain. For example, dousing skin and/or clothing with water;
heat gain outweighs use misters, wet towels, and evaporative cooling. However, take caution with the use of fans without adding water
evaporative loss) to the skin/clothing as it can worsen dry heat gain (Foster et al., 2022; Morris et al., 2021). For T db ≥ 35°C, fans are
ineffective and potentially harmful when relative humidity is below 50% (Foster et al., 2022). For example, At T =
db
42°C, 34 hPa heat gain with fans increased ~70 Wm−2 (Ravanelli et al., 2017).
Category 4 (Excessive This category exhibits the most severe heat stress with excessive dry heat gain and can become very dangerous
dry heat gain rapidly if sweating shuts down. Here, heat strain mitigation might be most effective through misting, wet towels or
shirts soaked in cold water and evaporative coolers, along with water dousing, given the high evaporative capacity
of the air. However, combining strategies does not always maximize benefit. Empirical evidence in Cramer et al.,
(2020) for older adults at 42.4°C air temperature and 34.2% relative humidity shows that electric fan use coupled
with a wet t-shirt exacerbates sweat losses without mitigating heat strain. Still, using only wet t-shirts without a fan
instead alleviates sweat loss and heat strain. Overall, it is paramount to reverse dry heat gain to keep people safe and
leverage the dry air for evaporation.
Int J Biometeorol. Author manuscript; available in PMC 2026 September 13.
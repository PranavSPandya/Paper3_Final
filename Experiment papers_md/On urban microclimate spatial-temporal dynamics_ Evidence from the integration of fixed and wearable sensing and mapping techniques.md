Environmental Research 262 (2024) 119795
Contents lists available at ScienceDirect
Environmental Research
journal homepage: www.elsevier.com/locate/envres
On urban microclimate spatial-temporal dynamics: Evidence from the
integration of fixed and wearable sensing and mapping techniques
Roberta Jacoby Cureaua,b, Carla Baloccoc, Ilaria Pigliautilea,b, Cristina Pisellic,
Claudia Fabiania,b, Franco Cotanaa,b, Cristina Carlettic, Fabio Sciurpic,
Anna Laura Piselloa,b,d,*
aEAPLAB at CIRIAF - Interuniversity Research Center, University of Perugia, Via G. Duranti 67, 06125, Perugia, Italy
bDepartment of Engineering, University of Perugia, Via G. Duranti 63, 06125, Perugia, Italy
cDepartment of Architecture (DIDA), University of Florence, Via della Mattonaia 8, 50121, Florence, Italy
dThe Department of Civil and Environmental Engineering, E209A Engineering Quadrangle Princeton, New Jersey, 08544, USA
A R T I C L E I N F O A B S T R A C T
Keywords: Urban Heat Island (UHI) is acknowledged to generate harmful consequences on human health, and it is one of the
Urban heat island main anthropogenic challenges to face in modern cities. Due to the urban dynamic complexity, a full micro-
Microclimate climate decoding is required to design tailored mitigation strategies for reducing heat-related vulnerability. This
Mobile monitoring
study proposes a new method to assess intra-urban microclimate variability by combining for the first time two
Physiological equivalent temperature
dedicated monitoring systems consisting of fixed and mobile techniques. Data from three fixed weather stations
Wearable sensing
Environmental comfort were used to analyze long-term trends, while mobile devices (a vehicle and a wearable) were used in short-term
Urban overheating monitoring campaigns conducted in summer and winter to assess and geo-locate microclimate spatial variations.
Vulnerability Additionally, data from mobile devices were used as input for Kriging interpolation in the urban area of Florence
(Italy) as case study. Mobile monitoring sessions provided high-resolution spatial data, enabling the detection of
hyperlocal variations in air temperature. The maximum air temperature amplitudes were verified with the
wearable system: 3.3 ◦C in summer midday and 4.3 ◦C in winter morning. Physiological Equivalent Temperature
(PET) demonstrated to be similar when comparing green areas and their adjacent built-up zone, showing up the
microclimate mitigation contribution of greenery in its surrounding. Results also showed that mixing the two
data acquisition and varied analysis techniques succeeded in investigating the UHI and the site-specific role of
potential mitigation actions. Moreover, mobile dataset was reliable for elaborating maps by interpolating the
monitored parameters. Interpolation results demonstrated the possibility of optimizing mobile monitoring
campaigns by focusing on targeted streets and times of day since interpolation errors increased by 10% only with
properly reduced and simplified input samples. This allowed an enhanced detection of the site-specific granu-
larity, which is important for urban planning and policymaking, adaptation, and risk mitigation actions to
overcome the UHI and anthropogenic climate change effects.
1. Introduction one of the biggest issues currently faced in urban environments due to its
several consequences, like enlarged heat-related health risks, compro-
The constant increase in the urban population and the consequent mised air quality, and higher energy consumption for cooling indoor
cities expansion (United Nations Human Settlements Programme, 2020) environments (Buchin et al., 2016; Li et al., 2018; Morakinyo et al.,
is accompanied by changes in the landscape, from natural surfaces to 2018; Zhang, 2020; Paolini et al., 2017. UHI becomes even more chal-
impervious ones, and by anthropogenic activities growth in these areas lenging under the climate change context considering the projections of
(Siddiqui et al., 2021). These alterations affect the urban microclimate, more intense, frequent, and longer extreme heat events like heatwaves
making cities warmer than their surroundings, which is known as the (Maggiotto et al., 2021). In detail, UHI has already been demonstrated to
Urban Heat Island (UHI) phenomenon (Santamouris, 2020). The UHI is influence the magnitude and duration of heatwaves (Tan et al., 2010),
* Corresponding author. CIRIAF - Interuniversity Research Center, University of Perugia, via G. Duranti 67, 06125, Perugia, Italy.
E-mail address: anna.pisello@unipg.it(A.L. Pisello).
https://doi.org/10.1016/j.envres.2024.119795
Received 19 January 2023; Received in revised form 31 July 2024; Accepted 12 August 2024
Available online 13 August 2024
0013-9351/© 2024 Published by Elsevier Inc.

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
and the combined effect of these two phenomena intensifies the heat environmental data acquisition techniques: fixed and mobile experi-
stress, implying higher risk and vulnerability for the urban population mental monitoring systems. The main objective was to verify whether
(Founda and Santamouris, 2017; He et al., 2021). and how the granular mobile monitoring data complements the
Given the adverse implications of UHI and human health risks continuous, but less granular, information from fixed-weather stations,
associated with urban overheating (Santamouris, 2020), the imple- for assessing microclimate and heat stress variability. In addition, the
mentation of effective mitigation strategies is urgent (Pisello et al., study aimed to verify whether mobile monitoring data could be useful as
2013). In particular, Tsoka et al. (2018)have obtained maximum surface input for spatial interpolation methods. To reach these aims, the analysis
and air temperature drops by 9.0 ◦C and 0.85 ◦C by increasing the albedo of retrieved data focused on the air temperature signal processing by
of ground surfaces. Kolokotsa et al. (2018)have found a reduction in the taking advantage of the pros of both the adopted techniques: (i) long-
superficial temperature by 10 K by replacing conventional pavements term data history and complete daily profiles in a single point from
with cool paving stones (higher albedo), and Kyriakodis and Santa- the fixed weather stations; (ii) high spatial granularity in short-term
mouris (2018)reduced air and surface temperatures up to 1.5 ◦C and monitoring from the mobile systems. Two different mobile systems (a
11.5 ◦C, respectively, using cool asphaltic and concrete pavements. vehicle-based system and a wearable device) were used to verify
Additionally, it is widely demonstrated that greenery is capable to hyperlocal variations in the microclimate within the urban area in
alleviate urban overheating and reduce heat vulnerability and summer and winter to access strategic parts of the inner city that are not
heat-related mortality (Adnan et al., 2022; Chang and Li, 2014; He, reached by car. Air temperature values retrieved by the mobile systems
2019; Mahmoud, 2011; Pantavou et al., 2013; Son et al., 2016). Ch`afer were thus corrected to neglect the variation component due to elapsed
et al. (2022)found a 4 ◦C difference in air temperature between green time. The same corrected data were used to map air temperature spatial
and non-green areas of Singapore, while Pioppi et al. (2022) demon- variation in the whole area within the monitoring path by means of the
strated that small urban parks can reduce air temperature by 3–7 ◦C in Kriging interpolation method. Finally, data retrieved by mobile systems
New York City. within the urban canopy were used to quantify the heat stress in the
Urban environments are characterized by complex morphologies urban environment by means of the Physiological Equivalent Temper-
that lead to high heterogeneity and microclimate variations (Pigliautile ature (PET), its spatial distribution analysis, and the influence of urban
and Pisello, 2020). Therefore, any application of mitigation strategy greenery on it. Florence (Italy) was selected as case study representative
requires a specific methodological and experimental approach. Further of Italian big historical cities. The Florentine historical center is char-
comprehension of hyperlocal variations in the urban microclimate is acterized by a highly variable urban form, including high and narrow
needed to propose tailored mitigation actions that account for urban canyons in the most central area with surrounding green areas.
site-specific characteristics (Pigliautile et al., 2021). Usually, urban Moreover, because the city has an enormous flow of tourists, the
microclimate assessments are made by means of satellite images (Halder knowledge of thermal map and air temperature distribution is crucial to
et al., 2021) or data retrieved from fixed weather stations (Cui et al., identify the potential zones of discomfort.
2017). Satellite remote sensing has the advantages of large spatial
coverage and repetitive data acquisition (Halder et al., 2021). However, 2. Methods
the large coverage compromises retrieving data with a high level of
spatial details, and even though images are obtained repeatedly, this The high microclimate heterogeneity of urban areas, due to the
process is not continuous. This implies that the time range acquisition massive variety of their forms, fabrics, and functions, requires an
for the same picture could be more than one day. On the contrary, fixed approach of data gathering and analysis capable of combining multiple
weather stations guarantee continuous long-term monitoring allowing scales and differentiated big data sources. The new procedure presented
the identification of temporal variations of environmental parameters, in this research combines two techniques for microclimatic data
but they have limitations to evaluating individual exposure on a collection: fixed weather stations network and a variety of interoperat-
microclimate level (Bailey et al., 2020) as a huge number of systems is ing mobile devices. The latter further differs in terms of proposed vectors
needed to catch spatial variabilities (Pigliautile and Pisello, 2020). Af- for data collection, namely a vehicle-based and a wearable system.
terwards, the use of mobile monitoring systems is an alternative or
complementary solution to retrieve environmental data with the tem- 2.1. Monitoring campaign
poral and spatial granularities required to detect intra-urban microcli-
mate variations at strategic times during the course of the year and with The urban microclimate characterization is provided through both
relatively low cost compared to high maintenance-needing stations’ long-term and short-term monitoring. The long-term analysis relies
diffuse network. These systems can equip vehicles (Hart and Sailor, upon five years long data series that were collected by fixed weather
2009; Kousis et al., 2021; Yadav and Sharma, 2018) or portable devices stations located in the studied area. The short-term monitoring consisted
known as wearables (Chokhachian et al., 2018; Cureau et al., 2022; of a dedicated campaign carried out by mobile monitoring systems.
Pigliautile and Pisello, 2020). Their difference is that the vehicle-based Despite many cities worldwide already presenting a dedicated weather
systems are limited to roadways and parking areas, while wearable station network made by fixed monitoring setup (sometimes located
systems overcome this restriction (Cureau et al., 2022). Differently from above the urban canopy or in areas where microclimatic variables are
remote sensing and fixed weather stations, the use of mobile systems not affected by urban peculiarities like airports), it is not common to
implies short monitoring campaigns due to limitations in systems au- acquire data from environmental transects. Since this infrastructure is
tonomy and error minimization due to the combination of spatial and missing, dedicated campaigns must be carefully designed in time and
temporal data variability. A crucial result is that long-term changes in space to provide meaningful insights into the microclimate heteroge-
environmental parameters cannot be identified by this technique. neity of the investigated city. In this research, two different routes were
Nevertheless, the huge advantage of using this system is that it monitors defined accounting for the two different vectors available for data
the most realistic environment to which people are exposed since they collection: a motorized vehicle and a walking person. Both paths were
record data within the urban canopy, and, in the case of wearables, designed to last around 1.5 h. The pedestrian route was internal to the
according with pedestrians’ perspective. Therefore, each technique has vehicular one, covering a smaller area due to differences in vector speed.
its positive and negative aspects, and for this reason, the ideal approach They were assumed to be equal to 1.4 m/s for the walking person and
to assessing urban microclimate is the optimal combination of them. between 5.5 and 8.3 m/s (20–30 km/h) for the vehicle at the design
Starting from the aforementioned research and from their further stage. The proposed limitation in vehicle speed is in line with previous
extension, this study proposes a novel methodology to evaluate intra- tested protocols involving motorized vectors for mobile transects, as
urban microclimate variability by combining two distinguished reported by Kousis et al. (2021). Furthermore, both routes were circular
2

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
to start and conclude environmental data collection in the same area. monitoring, as a reference, assuming that this trend was linear. Single
Therefore, the short-term monitoring campaign consisted of simulta- temperature observations retrieved by the mobile system at the time i
neously repeating the predefined strategic paths with the two mobile were modified to be comparable with data retrieved by the same system
systems three times per day in different seasons. The initial time of each at the time zero of the experimental campaign, i.e.:
m
m
.
o n
lo
it
c
o
a
r
l
i n
ti
g
m
s
e
e
.
ssion was established at 8:00 a.m., 12:00 p.m., and 4:30 p.
Tmi,corrected fix =Tmi +
Tf0 (cid:0)
f
Tff•i[◦
C],0<i≤f
2.2. Experimental setup
where Tmi is the retrieved temperature data at the time i by the mobile
system, Tf0 and Tff are temperature values gathered by the fixed station
In this research, two mobile monitoring systems developed at the
at the beginning and the end of the route, f is the specific short-term
University of Perugia were used: a vehicle-based system (Kousis et al.,
monitoring duration.
2021) and a wearable device (Cureau et al., 2022). As explained by
The same air temperature data collected by the mobile monitoring
Kousis et al. (2021), the monitoring setup on the vehicle comprises three
systems and corrected in time were used to compute the air temperature
air temperature probes on its top (accuracy: ±0.5 ◦C) and the compact
spatial variation in the monitored area by means of the ordinary Kriging
miniaturized weather station GMX501 which embeds a GPS unit and
interpolation method. Kriging is a geostatistics method for spatial
monitors the following environmental data: air temperature (±0.3 ◦ C),
interpolation based on semi-variograms, which considers the statistical
relative humidity (±2%), wind velocity (±3% @40 m/s) and direction
relationship between measured points to determine the parameters in
(±3 deg @40 m/s), atmospheric pressure (±0.5 hPa @25 ◦C), and
the non-monitored points in a spatial grid (Baykal et al., 2022; Yadav
incoming solar radiation (spectral range 300 ÷ 3000 nm). The moni-
and Sharma, 2018). Even though ordinary Kriging is a simplified method
toring system settled on the motorized vehicle retrieved instantaneous
that assumes the mean and variance of the values are constant through
values of the listed parameters every 10 s (technical details about the
the considered area, it has been largely used for air temperature spatial
system and its reliability are presented in Kousis et al. (2021)). The
interpolation due to its relatively fast computation and acceptable ac-
wearable monitoring system consists of a set of miniaturized sensors
curacy, while accounting for the spatial dependence between observa-
settled on a backpack retrieved and sent to a device directly associated
tions taken nearby. In this view, Yadav and Sharma (2018)achieved a
with the same system. In addition to the GPS signal, the system collects maximum error of 0.5 ◦C, Rosillon et al. (2024)reported a mean error of
the following environmental parameters: air temperature (±1 ◦C), 0.71 ◦C, and Wang et al. (2017)observed a mean error of 1.56 ◦C, all
relative humidity (±3%), atmospheric pressure (±0.25%), wind velocity
using ordinary Kriging for interpolating air temperature. In this study,
and direction, and incoming solar radiation (±5%). These parameters
the interpolation procedure was replicated for every monitoring session.
are retrieved every 5 s by the system. The wearable system validation is
First, Kriging was performed using all temperature data for the session
detailed in Cureau et al. (2022).
(about 1,500 values each). Then, the same procedure was done using
Furthermore, the urban microclimate assessment combined the in-
one-fifth of these data to verify how using a smaller sample affects the
formation retrieved by the two mobile systems with a five-year-long
accuracy of the interpolation. The comparison between the model using
data series gathered from fixed weather stations located in the area of
all the data and that one using the one-fifth sample was made consid-
interest. A detailed description of the identified fixed weather stations is
ering their Root Mean Square Error (RMSE). Kriging was done in R
provided in Section 3.
version 4.1.2 (R Core Team, 2021) with the RStudio development
environment (RStudio Team, 2021), using the package gstat (Gra¨ler
2.3. Data analysis
et al., 2016; Pebesma, 2004).
Finally, the impact of urban microclimate on thermal comfort and
Long-term data from fixed weather stations and short-term data
potential thermal stress zones were analyzed by computing the PET,
retrieved in dedicated campaigns through mobile systems were analyzed defined as “the air temperature at which, in a typical indoor setting
to provide a comprehensive picture of the microclimate heterogeneity of
(without wind and solar radiation), the heat budget of the human body
the city. The data analysis process can be summarized in three phases. is balanced with the same core and skin temperature as under the
complex outdoor conditions” (Ho¨ppe, 1999). PET was determined in the
(i) comparison of long-term data series retrieved by fixed weather software RayMan (Matzarakis et al., 2007) along the monitoring paths
stations to verify the existence of the UHI phenomenon;
for a standard person (characteristics proposed by the software, i.e., a
(ii) spatial distribution of air temperature data in the area enclosed man, 35 years old, 1.75 m height and 75.0 kg weight, wearing garments
by the mobile monitoring paths relying upon data retrieved
equivalent to 0.9 clo and with an internal heat production of 80 W) by
within the urban canopy by both the mobile systems just after a considering retrieved data of air temperature, relative humidity, solar
data series correction in time, accounting for the temporal trend
radiation, and wind velocity. The standard person used for PET calcu-
observed by the closest fixed weather station; lation was selected to make the results comparable with the ranges of
(iii) spatial distribution of PET computed within the urban canopy as
physiological stress proposed by Matzarakis et al. (1999)and presented
an index of pedestrian exposure to thermal stress conditions.
The analysis of the UHI was based on a statistical description of the Table 1
Ranges of PET and the corresponding thermal perception and physiological
five-year-long database from different fixed weather stations that were
stress, considering internal heat production of 80 W and heat transfer resistance
characterized according to their distance from the city core and differ-
of the clothing equal to 0.9 clo (Matzarakis et al., 1999).
ence in height. Furthermore, monthly profiles of 24 h air temperature
trends (minimum, maximum, and average values) were derived for all PET (◦C) Thermal perception Grade of physiological stress
the stations and compared through the assessment of the Full Width at <4 Very cold Extreme cold stress
Half Maximum (FWHM), that is, the range between the two points on a 4–8 Cold Strong cold stress
curve where the function reaches 50% of its amplitude. 8–13 Cool Moderate cold stress
13–18 Slightly cool Slight cold stress
By zooming into the city, below the urban canopy, the microclimate 18–23 Comfortable No thermal stress
heterogeneity could be expressed by air temperature spatial variation, as 23–29 Slightly warm Slight heat stress
collected by the mobile systems, while accounting for the influence of 29–35 Warm Moderate heat stress
elapsed time. The time-correction process was faced considering the 35–41 Hot Strong heat stress
>41 Very hot Extreme heat stress
temporal trend retrieved by the fixed system during the short-term
3

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
in Table 1, which used the same characteristics presented above. second one (Station II) is located at the Engineering campus of the
University of Florence (Banca dati SIR Regione Toscana, 2022), up to a
3. The case study hill at about 95 m a.s.l. in a rather green area just outside the city center
(Fig. 1c), gathering data every 15 min. The third one (Station III) is
The city center of Florence (Italy) represents the case study. Florence located inside the city center of Florence (Fondazione Osservatorio
is among the ten largest cities in Italy, with around 368,000 inhabitants Ximeniano di Firenze, 2022), about 51 m a.s.l., near the main square of
according to the Italian National Institute of Statistics for 2021 (Italian the city (Fig. 1d), and retrieves air temperature and relative humidity
National Institute of Statistics, 2021). Moreover, the city center of data every 30 min.
Florence has a high historical value and is full of monuments and cul- Mobile monitoring sessions were used to complement the data from
tural heritage sites as worldwide acknowledged. The historical city the three fixed weather stations, allowing for evaluating intra-urban
center presents diverse urban forms with high and narrow urban can- variability on environmental parameters. The monitoring paths were
yons in the most central area and variable distribution of green areas. designed to cross the city center, passing through areas with different
The city is visited by more than ten million tourists every year, especially characteristics in terms of geometry, morphology, materials, building
in the summer season. Therefore, the heat stress and thermal discomfort density, and expected crowd. In fact, the purpose of short-term mobile
are more intense exactly during the busiest travel period. transects below the urban canopy is to catch hyperlocal peculiarities
The year-round microclimate conditions in different areas of the city that could be generated by differences in forms, fabrics, and functions.
center, which are expected to be affected by the UHI phenomenon, were Nevertheless, dedicated campaigns need to account for the vector ty-
investigated. In particular, areas of touristic flows were preferred since pology of the monitoring system and its characteristics, e.g., data
they are often the most crowded. To this aim, data collected within the collection frequency rate, system velocity, and restrictions in urban
city through fixed and portable microclimate monitoring stations – areas. The two monitoring systems followed two different paths that
described in the previous section – were considered. In detail, three fixed crossed each other in some spots starting and finishing always at the
weather stations located in different zones of the city were used. The same place (the triangular shape in Fig. 2). The vehicle monitored the
first one (hereinafter Station I) is located near the airport of Florence area just around the historical city center, passing through residential
Peretola (Consorzio Lamma, 2022), in the sub-urban area of Sesto zones and large green areas. In the end, the vehicle also crossed the
Fiorentino, just outside the city (about 10 km distance) at about 40 m a. historical center (Fig. 2a). The wearable station was focused on moni-
s.l. (Fig. 1b), and retrieves air temperature data every 60 min. The toring the paths described by typical tourist flows since it went through
Fig. 1. Location of the three fixed weather stations (dots) within the city: a) overview map, b) sub-urban area (Station I), c) uphill green area (Station II), and d) city
center (Station III) (source: Google Earth).
4

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
Fig. 2. Monitoring path: a) vehicle, b) pedestrian.
the most important touristic spots and squares of Florence, which are station every month for five years. The air temperature distribution is
mainly located in the inner-city center (Fig. 2b). The total pedestrian similar for all the stations when analyzed month by month except for
route covered approximately 7.5 km and took about 80 min to complete, Station I data from May to December in 2018 and 2021, due to data
while the vehicle route was approximately 25.7 km and required about logging and acquisition problems. In Station II (green area), the air
100 min. temperature distribution has lower medians than the other two stations.
The vehicle and pedestrian paths (Fig. 2) starting and ending points No trends related to air temperature increases were identified over the
were at the University (zones V1 and P1 on the maps). Thereafter, the monitored years. On the other hand, if a 5-years period cannot be a
vehicle moved just outside the city center passing by an uphill road (V2), reference for the air temperature increase, it can be significant for the
reaching up to 130 m a.s.l. in a mainly green area, and went along a fluctuations linked to the combination between microclimatic parame-
downhill road (V3), going back down to 50 m a.s.l., as the city center. ters and different ground uses, citizens’ and tourists’ behavior, and
Then, it passed by the main train station of the city (V4) and finally building features (changes in materials, installed HVAC systems, archi-
crossed the inner-city center (V5), as shown in Fig. 3a, where it crossed tectural features, etc.).
the pedestrian path in various spots. Instead, the pedestrian path, after An in-depth comparison between the fixed weather stations was
leaving the University, reached an area characterized by medieval made by determining the minimum, maximum, and average daily pro-
streets and Piazza Santa Croce (P2), one of the most important squares in files of the air temperature for every month. Fig. 5shows an example of
the city. Thereafter, it followed through three of the most important these profiles for the year 2020. The daily profiles are comparable
touristic spots: Piazza della Signoria (Fig. 3b), Ponte Vecchio (P3), and among the stations. It can be noted that at Station I, the temperature
Piazza San Giovanni, i.e., the main square of the city where Santa Maria begins to rise earlier in the day during the hot season (from May to
del Fiore Cathedral is located (P4). Finally, the path moved near the main August). Since this station is located in an open area, it is fully exposed to
train station (P5), San Lorenzo (P6), the main historical market of the solar radiation early in the morning and, consequently, it registers an air
city, and the historical residential areas with large streets and gardens temperature increase before the other stations. In contrast, the air
(P7). temperature decreases later at Station III because it is the one in the city
As above-mentioned, two monitoring campaigns were carried out, (i. center. This is an outcome of the UHI phenomenon, i.e., the heat stored
e., in summer and winter), taking into account warm and cold season during the day is gradually released at night depending on the thermal
conditions, when UHI presents different characteristics. In particular, a capacity of different materials combined with local heat/mass exchange
sunny day at the end of summer (September 15th, 2021) and a clear sky and urban porosity, which causes a lower urban nocturnal cooling rate
day at the end of winter (March 11th, 2022) were selected. These days in urban environments than in non-urban ones. These results are in
were both typical working days with open schools and routine compliance with Oliveira et al. (2022). The same trends were observed
schedules. during the 5-year period of available data.
These profiles were compared by means of the FWHM evaluation.
4. Results This metric was calculated for the average daily profile, and as these
curves are not exactly symmetrical, the extreme points that delimit the
4.1. Long-term analysis FWHM were also determined. Table 2 presents an example of these
values for the year 2020. Despite the FWHM being similar among the
This section presents the long-term monitoring results, based on 5- stations, the one located in the city center (Station III) always presented
year data (from 2017 to 2021) collected from the three fixed weather a higher right limit (0.71 h higher on average), which means that its
stations. Fig. 4 shows the air temperature values recorded by each nocturnal cooling rate is lower than the other two stations, confirming
5

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
Fig. 3. Monitoring systems: a and b) vehicle-based system, c and d) wearable device.
the UHI effects in the historical city center. Stations I and II had similar data registered by the vehicle-based system were higher than those
right limits, indicating that they have similar cooling rates. Conversely, collected by the wearable system (except for the winter morning
the left limit was lower at Station I from April to September, which is a monitoring). This can be a result of the different monitored paths
result of the incidence of solar radiation that occurs earlier in the because as the van crossed a longer path covering a larger area, the
morning in its location and accelerates its heating rate during this time variation in the environmental parameters registered was generally
of the year. A trend in FWHM increase was not detected. higher. In addition, wind speed had the highest errors, which occurs as a
function of the high variability of this parameter. Indeed, wind speed
4.2. Mobile environmental monitoring can be considerably different when comparing two subsequent records,
while air temperature and relative humidity vary progressively. The
The confirmation of the UHI effects in the city center intensifies the same was observed when analyzing solar radiation, as it can change
demand for focusing on the microclimate analysis below the urban significantly due to solar availability and shading. In detail, solar radi-
canopy to understand the UHI impacts on people well-being and sus- ation varied from 0 W/m2 (shaded zones) to 769 W/m2 (area with direct
tainable environmental conditions. This could be addressed by carrying radiation at the midday monitoring) in the vehicle path during winter,
out environmental transects through mobile monitoring systems as the and from 0 W/m2 to 817 W/m2 in the pedestrian path during the same
two simultaneously used in this study (a vehicle-based system and a season and time of the day. In summer, zero radiation was registered in
wearable device). A preliminary analysis of the gathered datasets was both paths in the shaded areas, while the maximum values were regis-
carried out in terms of retrieved parameters minimum and maximum tered during the midday monitoring (731 W/m2 in the vehicle path and
values, median, and mean percentage error (calculated considering the 662 W/m2 in the pedestrian path). The maximum values are comparable
median as reference), as reported in Table 3. In general, the errors of the with the ones registered at midday by the fixed weather station located
6

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
Fig. 4. Air temperature values: assessment from data of the three fixed weather stations over five years.
in the city center (757 W/m2 in winter and 642 W/m2 in summer), but and both V1 and V4 at 4:30 p.m. These are the areas with the highest
the high variability in the parameters identified with the mobile systems concentration of anthropogenic activities due to the existing plenty of
enhances the importance of applying this monitoring method to catch facilities and services, releasing significant amount of anthropogenic
the real exposure within urban areas. heat. Some specific spots in the inner city (V5) also had high tempera-
Therefore, the hyperlocal intra-urban microclimate variation was tures at 12:00 p.m. and 4:30 p.m., possibly associated with the crowd.
investigated through the air temperature registered by the two different The lowest temperatures were identified in zones V2 and V3. Notably,
mobile systems after correcting these values for the elapsed time. Along the section at V2 crosses a green area and, as previously stated, greenery
the pedestrian path, on the summer day at 8:00 a.m., the highest tem- has a significant mitigating effect. Altogether, in the vehicle-based path,
perature was registered in the craft markets (San Lorenzo historical the temperature varied by 2.6 ◦C at 8:00 a.m., 2.7 ◦C at 12:00 p.m., and
market zone, P6 in Fig. 2), followed by the main station area (P5), and 3.0 ◦C at 4:30 p.m.
the lowest, occurred in the main square (Piazza San Giovanni, zone P4). In the pedestrian path during winter, the maximum temperature
Zones P5 and P6 during this period of the day are distinguished by a values were registered in P7 at 8:00 a.m. and in P1 and P5 at 12:00 p.m.
larger people concentration that can justify the higher temperatures, and 4:30 p.m. P1 and P5 are not touristic areas but have a high flux of
while P5 is mostly shaded at this time, which delays the air temperature people and vehicles due to the university and train station. The lowest
increase. The difference between the maximum and minimum temper- temperature values were identified in the Piazza San Giovanni (P4)
atures in this route was 0.9 ◦C. At 12:00 p.m. and 4:30 p.m., the lowest during the three walks. At 8:00 a.m. and 12:00 p.m., P2 and P3 had low
temperatures were verified in zone P1 and the highest in P7. Even temperatures similar to those recorded in P4. These two areas are
though zone P7 is not touristic, so potentially less crowded, it is char- distinguished by several touristic spaces and a high people concentra-
acterized by high vehicle traffic, which releases a notable amount of tion (except at 8:00 a.m.). As a consequence, the lower temperatures are
heat. At 4:30 p.m., zones P3, P4, P5, and P6 also presented high air strictly connected to the lower exposure to solar radiation. The absolute
temperatures, connected to the highest crowds at this time. The air value of the air temperature variation identified in the pedestrian path
temperature amplitude was higher during the midday and afternoon was 4.3 ◦C at 8:00 a.m., 3.2 ◦C at 12:00 p.m., and 1.8 ◦C at 4:30 p.m. As
routes: 3.3 ◦C at 12:00 p.m. and 2.5 ◦C at 4:30 p.m. Zone P7 was one of in summer, the urban park located in P7 caused an air temperature
the hottest during the three walks, and despite that, it was observed a reduction inside its area and in the immediate surrounding, even at 8:00
reduction in air temperature around an urban park (approximately a.m., when this zone was the hottest.
25,000 m2) located in this area. Indeed, other studies already demon- Concerning the vehicle-based monitoring in winter, the highest
strated the cooling effects of greenery in urban environments (Ch`afer temperatures were verified in V1 at 8:00 a.m. and 12:00 p.m., and in V5
et al., 2022; Wong et al., 2021). at 4:30 p.m. In contrast, at 8:00 a.m. and midday, V5 was the coolest
Relating to the vehicle-based path during summer, the hottest zone zone, and at 4:30 p.m., V2 was. Along this path, the temperature value
was V4 (main train station) at 8:00 a.m., V1 (University) at 12:00 p.m., amplitude was around 2.7 ◦C in all the sessions.
7

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
Fig. 5. Minimum, maximum, and average daily profiles of the air temperature registered by the three weather stations in 2020.
Air temperatures from the mobile monitoring systems were shaded and unshaded areas. In winter, both wearable and vehicle
compared to Station III, the station located in the area where wearable registered higher air temperatures than Station III throughout the day,
and vehicle systems collected data. A difference between fixed station with mean differences of 0.80 ◦C for the wearable and 0.21 ◦C for the
and transects was anticipated because while the first is positioned above vehicle. In summer, the wearable had varied patterns: lower tempera-
the urban canyon, the second catches human’s real exposure since tures in the morning (mean difference = 0.33 ◦C) and higher in the
measurements are taken closer to people. Temperature inside the street midday and afternoon sessions (1.04 ◦C) compared to Station III. The
canyon (measured by mobile systems) could be higher due to heat vehicle recorded lower temperatures in this season (on average, 1.35 ◦C
accumulation during the daytime and anthropogenic heat release, while lower than the fixed station). This higher difference observed between
fixed stations could also record higher temperatures because of greater vehicle and Station III could be attributed to the longer path traversed by
solar radiation exposure compared to mobile systems, which traverse the vehicle, which includes a large green area, probably cooling the
8

R.J. Cureau et al.                                                                                                                                                                                             E  n v  i r o  n  m  e  n  t a  l  R   e s e  a  r c h   262 (2024) 119795
Table 2
FWHM and its delimiting points (time of the day) for the air temperature average daily profiles during 2020.
| Month | Left limit (hour) |       |       | Right limit (hour) |       |       | FWHM (hour) |       |       |
| ----- | ----------------- | ----- | ----- | ------------------ | ----- | ----- | ----------- | ----- | ----- |
|       | I                 | II    | III   | I                  | II    | III   | I           | II    | III   |
| Jan   | 10.38             | 10.40 | 10.88 | 19.74              | 19.48 | 20.25 | 9.36        | 9.08  | 9.37  |
| Feb   | 10.16             | 10.04 | 10.56 | 19.49              | 19.46 | 20.23 | 9.33        | 9.42  | 9.67  |
| Mar   | 9.62              | 9.57  | 10.18 | 19.76              | 19.64 | 20.39 | 10.14       | 10.07 | 10.21 |
| Apr   | 9.06              | 9.20  | 9.81  | 19.99              | 20.03 | 20.69 | 10.93       | 10.83 | 10.88 |
| May   | 8.28              | 8.59  | 9.21  | 20.30              | 20.23 | 21.12 | 12.02       | 11.64 | 11.91 |
| Jun   | 8.20              | 8.48  | 9.11  | 20.02              | 20.26 | 21.10 | 11.82       | 11.78 | 11.99 |
| Jul   | 8.44              | 8.86  | 9.45  | 20.32              | 20.37 | 21.21 | 11.88       | 11.51 | 11.76 |
| Aug   | 8.81              | 9.10  | 9.69  | 19.60              | 19.77 | 20.47 | 10.79       | 10.67 | 10.78 |
| Sep   | 8.90              | 9.12  | 9.81  | 19.70              | 19.51 | 20.23 | 10.80       | 10.39 | 10.42 |
| Oct   | 9.64              | 9.60  | 10.16 | 19.32              | 19.18 | 19.79 | 9.68        | 9.58  | 9.63  |
| Nov   | 9.96              | 9.85  | 10.49 | 19.12              | 19.06 | 19.54 | 9.16        | 9.21  | 9.05  |
| Dec   | 10.15             | 9.98  | 10.55 | 19.23              | 19.05 | 19.79 | 9.08        | 9.07  | 9.24  |
Table 3
Minimum, maximum, median and mean percentage error for air temperature (◦C), relative humidity (%), and wind speed (m/s) for data retrieved from the mobile
monitoring systems.
| Route | Parameter |     | Vehicle-based system |     |     | Wearable device |     |     |     |
| ----- | --------- | --- | -------------------- | --- | --- | --------------- | --- | --- | --- |
Min Max Median Percentage error [%] Min Max Median Percentage error [%]
Winter morning Air temperature [◦C] 4.9 10.4 7.5 16.1 4.3 12.6 6.5 28.6
|     | Relative humidity [%] |     | 52.0 73.0 | 58.0 | 9.2  | 38.8 | 59.4 52.7 | 9.3  |     |
| --- | --------------------- | --- | --------- | ---- | ---- | ---- | --------- | ---- | --- |
|     | Wind speed [m/s]      |     | 0.1 9.4   | 1.6  | 66.9 | 0.0  | 4.0 1.4   | 36.8 |     |
Air temperature [◦C]
| Winter midday |     |     | 13.2 15.7 | 14.3 | 3.5 | 13.9 | 17.8 15.1 | 5.6 |     |
| ------------- | --- | --- | --------- | ---- | --- | ---- | --------- | --- | --- |
Relative humidity [%] 21.0 36.0 29.0 11.0 19.1 30.6 26.0 10.0
|     | Wind speed [m/s] |     | 0.1 6.9 | 1.8 | 56.3 | 0.0 | 5.4 1.9 | 42.0 |     |
| --- | ---------------- | --- | ------- | --- | ---- | --- | ------- | ---- | --- |
Air temperature [◦C]
| Winter afternoon |                       |     | 12.3 17.3 | 14.7 | 4.0  | 14.0 | 17.0 15.0 | 3.4  |     |
| ---------------- | --------------------- | --- | --------- | ---- | ---- | ---- | --------- | ---- | --- |
|                  | Relative humidity [%] |     | 31.0 40.0 | 36.0 | 4.4  | 26.1 | 33.9 31.2 | 4.1  |     |
|                  | Wind speed [m/s]      |     | 0.0 39.0  | 2.0  | 54.1 | 0.0  | 7.6 1.9   | 49.6 |     |
Air temperature [◦C]
| Summer morning |                       |     | 18.2 22.1 | 20.5 | 4.1  | 19.3 | 21.8 20.4 | 3.4  |     |
| -------------- | --------------------- | --- | --------- | ---- | ---- | ---- | --------- | ---- | --- |
|                | Relative humidity [%] |     | 58.0 71.0 | 63.0 | 4.8  | 55.4 | 61.3 58.8 | 2.8  |     |
|                | Wind speed [m/s]      |     | 0.1 8.3   | 1.4  | 67.5 | 0.0  | 3.9 1.6   | 34.4 |     |
Summer midday Air temperature [◦C] 23.9 26.8 25.6 2.6 27.0 29.5 28.4 1.8
|     | Relative humidity [%] |     | 44.0 52.0 | 48.0 | 4.0  | 37.6 | 44.2 40.8 | 3.1  |     |
| --- | --------------------- | --- | --------- | ---- | ---- | ---- | --------- | ---- | --- |
|     | Wind speed [m/s]      |     | 0.1 11.0  | 1.4  | 66.1 | 0.0  | 4.8 1.7   | 41.6 |     |
Summer morning Air temperature [◦C] 25.5 28.7 26.7 1.8 27.5 28.7 28.2 0.8
|     | Relative humidity [%] |     | 38.0 49.0 | 43.0 | 5.1  | 34.8 | 43.6 37.5 | 4.8  |     |
| --- | --------------------- | --- | --------- | ---- | ---- | ---- | --------- | ---- | --- |
|     | Wind speed [m/s]      |     | 0.1 6.9   | 1.6  | 57.2 | 0.0  | 7.9 1.8   | 53.3 |     |
environment and leading to lower average temperatures. This effect was  without monitoring the entire zone. Moreover, reducing considerably
possibly not observed during winter because the cooling effect of urban  the number of monitored points did not cause a significant error in-
greenery is less pronounced in this season (Bartesaghi-Koc et al., 2020;  crease. Therefore, one can achieve similar results with less monitoring
Hamada and Ohta, 2010). effort and, consequently, lower economic investment.
Given the retrieved observations along the monitoring route, an
overview of temperature distribution in the whole area enclosed by the  4.3. Physiological Equivalent Temperature (PET)
same path is given thanks to the Kriging interpolation analysis. Fig. 6
presents the obtained results using all data available for each session for
Thermal comfort along the paths was assessed by means of the
the three monitoring periods on the summer day, as representative  evaluation of the PET and the grade of physiological stress proposed by
example of the method outcomes. Table 4 shows the RMSE of each  Matzarakis et al. (1999). In this analysis, no time correction was applied
interpolation model, comparing it when using the entire and one-fifth of  to the air temperature since PET includes solar radiation, a parameter
the data sample. that changes over time and cannot be adjusted. As an example, in Fig. 7,
In both seasons, the air temperature pattern computed with the  the PET variation map along the pedestrian and vehicle routes is shown.
entire and one-fifth of the data sample is comparable. However, using all  During summer, on both pedestrian and vehicle paths, the zones with
data allowed identifying more extreme values of air temperature. The  the higher air temperature values were not necessarily the ones with
amplitude of the temperature computed for the non-monitored points  higher heat stress. This highlights that solar radiation and wind velocity
was indeed slightly higher when using the entire sample. This was ex- can increase or attenuate the stress level. In the pedestrian path, the
pected as the Kriging method considers the statistical relationship be-
most critical routes were the ones at 12:00 p.m. and 4:30, when most
tween the measured points: the larger the number of monitored points  parts of the path were under moderate heat stress (78% at midday and
available, the more probable it will be to distinguish extreme air tem- 65% at 4:30 p.m.). At midday, 11% of the route was under strong heat
perature values. However, this difference did not compromise the reli- stress. The areas under the worst thermal conditions were P2, P3, P4,
ability of the method when using a smaller sample (about 300 input  and P6, which are the ones with the highest tourist flux. Less thermal
points) as the RMSE is very similar to the one considering all data  stress condition was identified along the vehicle path, with most parts of
(differences lower than 0.1, i.e., about 10%). the route being in the comfortable range (18–23 ◦C) at 12:00 p.m. and
| Therefore, these results demonstrate that mobile monitoring is reli- |     |     |     |     | 4:30 p.m. |     |     |     |     |
| -------------------------------------------------------------------- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
able for this interpolation method, which is an essential tool for  In winter, most parts of the two routes were in the range of extreme
analyzing and scaling up the UHI variation within the same urban area  cold stress at 8:00 a.m. For the other periods, the condition was less
9

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
Fig. 6. Air temperature (◦C) computed through the Kriging interpolation method on the summer monitoring day at a) 8:00 a.m., b) 12:00 p.m., and c) 4:30 p.m.
10

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
Table 4 wind velocity to increase or alleviate heat stress was conducted by
RMSE resulted from the Kriging interpolation method. comparing a green and a built-up section for each path. In the pedestrian
Session RMSE route, the urban park at the end of zone P7 and the street section
immediately before the park were compared. Along the vehicle route,
All data One-fifth sample
the green area crossed in V2 was compared with a densely built street in
Summer 8:00 a.m. 0.589 0.631 V3. Short sections (3 min each for the pedestrian path and 6 min for the
Summer 12:00 p.m. 0.285 0.373
vehicle one) were selected to guarantee that air temperature and relative
Summer 4:30 p.m. 0.294 0.303
Winter 8:00 a.m. 0.542 0.602 humidity had lower variation so that the PET variations were due to
Winter 12:00 p.m. 0.538 0.589 changes in solar radiation and wind velocity.
Winter 4:30 p.m. 0.359 0.407 Fig. 8shows the link between PET, solar radiation, and wind velocity
in the compared areas during the summer monitoring at 12:00 p.m. In
difficult since no extreme thermal stress (below 4 ◦C or above 41 ◦C) was this figure, it is notable that the built-up area had higher PETs than the
green area in the pedestrian route. The higher PETs are connected to
identified, but the entire paths were under some type of cold stress
(between 4 ◦C and 18 ◦C), with exception of the pedestrian route at higher solar radiation and lower wind velocity in the built-up section,
while the green area had faster wind that reduced the PET. In the vehicle
midday when 10% of it was within the comfort limits. The PET variation
path, PET was similar in both areas. Higher solar radiation was regis-
in the same route was higher in winter than in summer, with amplitudes
higher than 20 ◦C at 8:00 a.m. and 12:00 p.m. tered in the green section, but at the same time, this area reported higher
wind velocity, resulting in an alike PET when compared with the built-
A more in-depth analysis of the contribution of solar radiation and
Fig. 7. PET (◦C) for the summer monitoring at 12:00 p.m.: a) pedestrian path and b) vehicle path.
Fig. 8. PET correlations with solar radiation and wind velocity in a green and a built-up area during the summer monitoring at 12:00 p.m.: a) pedestrian path and b)
vehicle path.
11

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
up area. the generalizability of findings related to morphological impact on the
The R2 for these correlations was determined. In this case, a higher observed microclimate. In this specific study, mobile monitoring cam-
R2 could indicate that PET is more affected by a main parameter under paigns were conducted solely in Florence during summer and winter,
the considered conditions. In summer, at 8:00 a.m. and 12:00 p.m., it potentially capturing specific characteristics of this location, acknowl-
was verified a better correlation between PET and solar radiation both in edged to provide for the targeted urban complexity. However, the pre-
green and built-up areas, while at 4:30 p.m., PET was more related to sented framework, combining both long-term monitoring from fixed
wind velocity. During this season, the R2 was higher in the built-up area, weather stations and mobile monitoring sessions with two different
suggesting that green zones are less influenced by these parameters. transects, proved to be effective and reliable in capturing the UHI effect
In winter, the same pattern was identified in the built section: better over the years and its intra-urban variations, identifying precise triggers
association between PET and solar radiation at 8:00 a.m. and 12:00 p. for human heat stress, and assessing the specific impact of mitigation
m., and with wind velocity at 4:30 p.m. On the contrary, PET in the strategies, like urban greenery, on improving comfort and well-being. In
green area presented a better correlation with wind velocity during all particular, data from fixed weather stations, besides being long-term,
sessions. are also useful to overcome data gaps of mobile monitoring sessions
PET did not vary considerably among the built-up and green areas due to technical issues, providing records continuity. On the other hand,
selected for this analysis. Most probably, this was imputable to the mobile monitoring captures the spatial variability in environmental
greenery, which contributes to the UHI reduction also in its surrounding. parameters, complementing data from fixed weather stations which are
This effect was also observed in the air temperature variation along the usually a few within the city (just three in this case study). Furthermore,
paths. As the areas selected for comparison are near to each other, the periodic repetitions of these campaigns permit assessing the impacts on
green area could have an effect also in the built-up area nearby and no the microclimate of urban dynamics, mostly related to anthropogenic
important differences in PET were observed when comparing them. The activities, and verifying how these alterations affect heat stress on
observed cooling effect along both the pedestrian and vehicle paths hyperlocal scales, which is not possible with fixed weather stations alone
suggests that the urban park, despite its smaller size, provides cooling as since they are usually placed above the urban canopy. Moreover, the
the larger green area traversed by the vehicle. This finding indicates that combination of the wearable system with the vehicle one enables
even small green spaces can mitigate urban overheating in their im- monitoring different areas, even streets that are not accessible by car,
mediate vicinity, even if the cooling intensity and extent may be lower which is the case of P3 and P4 areas (Fig. 2) in the pedestrian monitoring
compared to larger areas. path. Thus, the combination of different techniques provides significant
benefits to urban microclimate analyses.
5. Discussion Scaling up the proposed framework may require additional resources
due to the need for more fixed weather stations and mobile monitoring
Results showed a higher air temperature variability registered by the sessions. Conversely, the combined approach using both fixed and mo-
vehicle in summer and in the pedestrian path during winter. Similarly to bile monitoring potentially reduces the overall number of sensors
these findings, previous microclimate studies using mobile monitoring needed compared to relying solely on either method. Consequently,
under diverse climate conditions have documented significant air tem- targeted and strategically planned mobile monitoring sessions com-
perature variability within the same city, such as in Vancouver (Tsin plementing long-term data collection can diminish the dependence on
et al., 2016), Phoenix (Sun et al., 2009), New York City (Pioppi et al., fixed stations and possibly lessen costs associated with extensive fixed-
2022), and Singapore (Ch`afer et al., 2022). These differences observed station networks.
in Florence are due to the weight of solar radiation and mutual heat Another limitation concerns the proposed temporal correction of the
radiative exchange that mobile systems experienced along specific air temperature retrieved by mobile systems, based on the simplified
routes. The higher variability registered with the vehicle-based system assumption of a linear variation occurring equally across the city that
can also be attributed, in a lesser extent, to other characteristics, like the could not capture some complex temporal dynamics of air temperature.
longer paths and altitude variation crossed by vehicle (pedestrian path is Even though time correction could not be perfectly accurate, the effects
shorter and flat). On the other hand, important research on the subject of elapsed time on air temperature cannot be disregarded to evaluate the
(Huang et al., 2022; Zhang and Gao, 2021) showed that the geometry of intra-urban spatial variability of this parameter, especially considering
the urban built-up areas, compared with sub-urban small or large clus- the long mobile monitoring sessions performed in this study (more than
ters, usually assessed by porosity and/or density index, has a significant 1 h). Then, regardless of this, the time correction was performed to
impact on the thermal balance of the area. Therefore, this is closely reduce this effect. The fact that just one fixed station (the only one on the
connected to the mutual heat radiative exchange and the radiant city center) was used to evaluate the air temperature variation on time
asymmetry. Results analysis showed that the effect of radiation trapping implies in assuming the same trend across the area of interest. On the
by vertical walls becomes more significant in those areas characterized other hand, the application of a consistent temporal trend to the whole
by regular geometry and medium density and porosity (i.e., the ratio of path makes very time-specific changes in air temperature identified with
air volume within an urban canopy). These deduced interacting factors the transects still noticeable. Therefore, this preliminary proposal
follow crucial recent literature evidence (Kinnunen et al., 2022; demonstrated to be particularly valuable for the specific case, effectively
Lopez-Cabeza et al., 2022). Combining urban geometry with sky view capturing air temperature variations along the paths.
factor and comparing those results obtained by vehicle with those Despite these limitations, the outcomes presented reveal the
coming from pedestrian paths allows showing how the surface temper- robustness and potentialities of the proposed framework combining
ature of the streets and multiple reflections of various surfaces/materials fixed and mobile monitoring techniques to evaluate urban microclimate
affects the mean radiant temperature variation. These combined effects and thermal stress, taking into account the impact of urban settings on
are even more evident if the presence of intensive/extensive greenery is them on a hyperlocal scale. This paper presents a real-world application
considered (e.g., a strong cooling effect in summer, and during winter of this framework through a case study, but the proposed approach is
only in the pedestrian path but in the short afternoon time also for the flexible and adaptable to be employed in different scenarios. In this
vehicle). view, as a future development to evolve the proposed framework, it is
important to apply it to varied urban contexts, climate conditions, and
6. Limitations and future developments different seasons to potentially generalize the results, as well as scale it
up to verify its effectiveness when implemented in larger urban envi-
While this study provides valuable insights, it is important to ronments. This method showed to be valuable for assessing the effect of
acknowledge a few limitations specific to the case study that may affect diverse urban configurations and mitigation actions, like urban
12

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
greenery, in the microclimate. Therefore, future studies could take Investigation, Methodology, Software, Visualization, Writing – original
advantage of this approach to investigate the impact of varied settings draft. Carla Balocco: Investigation, Writing – review & editing, Su-
on the microclimate on a hyperlocal scale. Moreover, the results of the pervision. Ilaria Pigliautile: Conceptualization, Data curation, Formal
Kriging interpolation revealed the possibility of optimizing the mobile analysis, Investigation, Methodology, Supervision, Writing – review &
monitoring campaigns since acceptable errors were achieved with editing. Cristina Piselli: Formal analysis, Investigation, Writing – re-
reduced samples. Finally, future advances of this framework involve view & editing, Methodology. Claudia Fabiani: Data curation, Formal
including other thermal-related parameters like surface temperature, as analysis, Investigation, Writing – review & editing. Franco Cotana:
well as additional domains, such as air quality, to evaluate the corre- Supervision. Cristina Carletti: Formal analysis, Writing – review &
lation of air pollution with the thermal issues here identified and pro- editing. Fabio Sciurpi: Investigation, Methodology, Writing – review &
pose mitigation actions for both domains. editing. Anna Laura Pisello: Conceptualization, Funding acquisition,
Investigation, Methodology, Project administration, Resources, Super-
7. Conclusions vision, Writing – review & editing.
Our research develops and implements a systemic approach to urban Declaration of competing interest
microclimate monitoring. Urban areas are indeed complex systems
where buildings, energy systems, activities, various services and func- The authors declare that they have no known competing financial
tions, people, and the surrounding global environment represent dy- interests or personal relationships that could have appeared to influence
namic players of this multifunctional ecosystem in relation to natural the work reported in this paper.
and anthropic impacts. Findings demonstrated that the advanced pro-
totyped monitoring technologies and methods integration (monitoring Data availability
using weather fixed stations and mobile systems) could be an effective
tool for studying and better managing the potential UHI mitigation. Data Data will be made available on request.
from networks of fixed weather stations provide main microclimate
parameters variation in the long-term that could be detailed in daily and Acknowledgments
seasonal fluctuations. These profiles analysis is of utmost importance for
understanding the impact of different ground uses and activities on Authors from the University of Perugia thank the Horizon Europe
climate. On the other hand, mobile systems address the needed spatial programme under grant agreement no. 101137507 (SONATA), the
granularity for assessing the livability of cities and citizens’ exposure to Ministry of University and Research (MUR) for supporting the young
potentially temporary and harmful conditions, e.g., heat waves and local researcher PRIN project WePOP (Prot.2022RKLB3J), and the European
thermal emissions. The performed comparison of air temperature spatial Union - NextGenerationEU - for supporting the Italian Ministry of Uni-
distribution given by applying the Kriging method with the full retrieved versity and Research (MUR) National Innovation Ecosystem grant
dataset and only one-fifth of its content provides interesting insights on ECS00000041 - VITALITY - CUP I33C2200133000. R.J. Cureau and A.L.
the amount of needed data from mobile transects to get reliable results. Pisello also thank the Italian Ministry of University and Research (MUR)
Future studies should explore optimizing mobile monitoring by strate- for supporting the project “THE-UNKNOWN” - equivalent THErmo-
gically reducing the number of measured points and focusing on key physical properties for UNKNOWN composition of building walls
driving paths, possibly setting miniaturized monitoring setups on public (PRIN 2022 PNRR - P2022NM5L7). I. Pigliautile and C. Piselli research
transportation vehicles. contracts are co-financed by the European Union - PON Ricerca e
The comprehensive understanding of urban microclimate guaran- Innovazione 2014–2020 ai sensi dell’art. 24, comma 3, lett. a), della
teed by the proposed approach can support urban planners and policy- Legge 30 dicembre 2010, n. 240 e s.m.i. e del D.M. 10 agosto 2021 n.
makers in proposing targeted and efficient strategies for enhancing 1062 through the projects “Red-To-Green” and “Efficientamento ener-
cities’ livability regarding their environmental conditions. In detail, our getico e rinnovabili nella catena del freddo e nel sistema edificio-
methodological approach can increase the effectiveness of environment impianto”, respectively. The authors also thank the Municipality of
conservation interventions, restoration, and adaptation to climate Florence and the Technological Infrastructure Development Service In-
change; improve the interoperability of information of environmental formation System Directorate. Finally, the authors thank Dr. Luca Fibbi
and microclimatic interest also between local, regional and national of Consortium LAMMA-CNR-IBINET Environmental Monitoring and
levels; facilitate the access to national environmental information Modeling Laboratory for sustainable development, Dr. Paolo Del Santo
guaranteeing a more effective support for multi-level institutional of Regional Hydrological and Geological Sector of Tuscany Region and
reporting; strengthen and support territorial and urban planning taking Foundation Ximeniano Observatory of Florence, for providing the data
into account integrated renewable sources and energy cascade man- of the fixed weather stations.
agement with local climate change projection; help identify priority
areas for conservation, restoration, retrofitting, refurbishment, green References
transition, and sustainable energy design.
Finally, our findings provide critical information on the strategic Adnan, M.S.G., Dewan, A., Botje, D., Shahid, S., Hassan, Q.K., 2022. Vulnerability of
Australia to heatwaves: a systematic review on influencing factors, impacts, and
spatial resolution for terrestrial and urban monitoring of most systems
mitigation options. Environ. Res. 213, 113703 https://doi.org/10.1016/J.
and ecosystems, suggesting important insights regarding adaptive ENVRES.2022.113703.
governance models aimed at nature-based solutions, environmental Bailey, E., Fuhrmann, C., Runkle, J., Stevens, S., Brown, M., Sugg, M., 2020. Wearable
sensors for personal temperature exposure assessments: a comparative study.
energy sustainability, human health, green economy, and energy tran-
Environ. Res. 180, 108858 https://doi.org/10.1016/J.ENVRES.2019.108858.
sition, which at the moment still lacks. Our study can be also an oper- Banca dati SIR Regione Toscana, 2022. Servizio Idrologico e Geologico Regionale [WWW
ative tool for providing environmental/urban thermal maps, always Document]. URL. http://www.sir.toscana.it/.
Bartesaghi-Koc, C., Osmond, P., Peters, A., 2020. Quantifying the seasonal cooling
updatable, that can be useful for the public administration with the
capacity of ‘green infrastructure types’ (GITs): an approach to assess and mitigate
perspective of conservation and protection of biodiversity, green land- surface urban heat island in Sydney, Australia. Landsc. Urban Plan. 203, 103893
scape, historic buildings and areas, and cultural heritage. https://doi.org/10.1016/J.LANDURBPLAN.2020.103893.
Baykal, T.M., Colak, H.E., Kılınc, C., 2022. Forecasting future climate boundary maps
(2021–2060) using exponential smoothing method and GIS. Sci. Total Environ. 848,
CRediT authorship contribution statement 157633 https://doi.org/10.1016/J.SCITOTENV.2022.157633.
Roberta Jacoby Cureau: Data curation, Formal analysis,
13

R.J. Cureau et al. E n v i r o n m e n t a l R e s e a r c h 262 (2024) 119795
Buchin, O., Hoelscher, M.T., Meier, F., Nehls, T., Ziegler, F., 2016. Evaluation of the Morakinyo, T.E., Lau, K.K.L., Ren, C., Ng, E., 2018. Performance of Hong Kong’s common
health-risk reduction potential of countermeasures to urban heat islands. Energy trees species for outdoor temperature regulation, thermal comfort and energy
Build. 114, 27–37. https://doi.org/10.1016/J.ENBUILD.2015.06.038. saving. Build. Environ. 137, 157–170. https://doi.org/10.1016/J.
Ch`afer, M., Tan, C.L., Cureau, R.J., Hien, W.N., Pisello, A.L., Cabeza, L.F., 2022. Mobile BUILDENV.2018.04.012.
measurements of microclimatic variables through the central area of Singapore: an Oliveira, A., Lopes, A., Niza, S., Soares, A., 2022. An urban energy balance-guided
analysis from the pedestrian perspective. Sustain. Cities Soc. 83, 103986 https://doi. machine learning approach for synthetic nocturnal surface Urban Heat Island
org/10.1016/J.SCS.2022.103986. prediction: a heatwave event in Naples. Sci. Total Environ. 805, 150130 https://doi.
Chang, C.R., Li, M.H., 2014. Effects of urban parks on the local urban thermal org/10.1016/J.SCITOTENV.2021.150130.
environment. Urban For. Urban Green. 13, 672–681. https://doi.org/10.1016/J. Pantavou, K., Theoharatos, G., Santamouris, M., Asimakopoulos, D., 2013. Outdoor
UFUG.2014.08.001. thermal sensation of pedestrians in a Mediterranean climate and a comparison with
Chokhachian, A., Ka-Lun Lau, K., Perini, K., Auer, T., 2018. Sensing transient outdoor UTCI. Build. Environ. 66, 82–95. https://doi.org/10.1016/J.
comfort: a georeferenced method to monitor and map microclimate. J. Build. Eng. BUILDENV.2013.02.014.
20, 94–104. https://doi.org/10.1016/j.jobe.2018.07.003. Paolini, R., Zani, A., MeshkinKiya, M., Castaldo, V.L., Pisello, A.L., Antretter, F., Poli, T.,
Consorzio Lamma, 2022. Consorzio LAMMA Toscana [WWW Document]. URL. http Cotana, F., 2017. The hygrothermal performance of residential buildings at urban
://www.lamma.rete.toscana.it/. and rural sites: Sensible and latent energy loads and indoor environmental
Cui, Y., Yan, D., Hong, T., Ma, J., 2017. Temporal and spatial characteristics of the urban conditions. Energy and Buildings 152, 792–803. https://doi.org/10.1016/j.
heat island in Beijing and the impact on building design and energy performance. enbuild.2016.11.018.
Energy 130, 286–297. https://doi.org/10.1016/J.ENERGY.2017.04.053. Pebesma, E.J., 2004. Multivariable geostatistics in S: the gstat package. Comput. Geosci.
Cureau, R.J., Pigliautile, I., Pisello, A.L., 2022. A new wearable system for sensing 30, 683–691. https://doi.org/10.1016/j.cageo.2004.03.012.
outdoor environmental conditions for monitoring hyper-microclimate. Sensors. Pigliautile, I., D’Eramo, S., Pisello, A.L., 2021. Intra-urban microclimate mapping for
https://doi.org/10.3390/s22020502. citizens’ wellbeing: novel wearable sensing techniques and automatized data-
Fondazione Osservatorio Ximeniano di Firenze, 2022. Fondazione Osservatorio processing. J. Clean. Prod. 279 https://doi.org/10.1016/J.JCLEPRO.2020.123748.
Ximeniano di Firenze [WWW Document]. URL. https://ximeniano.it/. Pigliautile, I., Pisello, A.L., 2020. Environmental data clustering analysis through
Founda, D., Santamouris, M., 2017. Synergies between urban heat island and heat waves wearable sensing techniques: new bottom-up process aimed to identify intra-urban
in athens (Greece), during an extremely hot summer (2012). Sci. Rep. 7, 10973 granular morphologies from pedestrian transects. Build. Environ. 171 https://doi.
https://doi.org/10.1038/s41598-017-11407-6. org/10.1016/J.BUILDENV.2019.106641.
Gr¨aler, B., Pebesma, E., Heuvelink, G., 2016. Spatio-Temporal Interpolation using gstat. Pioppi, B., Pisello, A.L., Ramamurthy, P., 2022. Wearable sensing techniques to
R J 8, 204–218. https://doi.org/10.32614/RJ-2016-014. understand pedestrian-level outdoor microclimate affecting heat related risk in
Halder, B., Bandyopadhyay, J., Banik, P., 2021. Evaluation of the climate change impact urban parks. Sol. Energy 242, 397–412. https://doi.org/10.1016/J.
on urban heat island based on land surface temperature and geospatial indicators. SOLENER.2021.05.076.
Int. J. Environ. Res. 15, 819–835. https://doi.org/10.1007/s41742-021-00356-8. Pisello, A.L., Cotana, F., Nicolini, A., Brinchi, L., 2013. Development of clay tile coatings
Hamada, S., Ohta, T., 2010. Seasonal variations in the cooling effect of urban green areas for steep-sloped cool roofs. Energies 6 (8), 3637–3653. https://doi.org/10.3390/
on surrounding urban areas. Urban For. Urban Green. 9, 15–24. https://doi.org/ en6083637.
10.1016/J.UFUG.2009.10.002. R Core Team, 2021. R: A Language and Environment for Statistical Computing. R
Hart, M.A., Sailor, D.J., 2009. Quantifying the influence of land-use and surface Foundation for Statistical Computing, Vienna, Austria. URL. https://www.R-project.
characteristics on spatial variability in the urban heat island. Theor. Appl. Climatol. org/.
95, 397–406. https://doi.org/10.1007/s00704-008-0017-5. Rosillon, D.J., Jago, A., Huart, J.P., Bogaert, P., Journ´ee, M., Dandrifosse, S.,
He, B.J., 2019. Towards the next generation of green building for urban heat island Planchon, V., 2024. Near real-time spatial interpolation of hourly air temperature
mitigation: zero UHI impact building. Sustain. Cities Soc. 50, 101647 https://doi. and humidity for agricultural decision support systems. Comput. Electron. Agric.
org/10.1016/J.SCS.2019.101647. 223, 109093 https://doi.org/10.1016/J.COMPAG.2024.109093.
He, B.J., Wang, J., Liu, H., Ulpiani, G., 2021. Localized synergies between heat waves RStudio Team, 2021. RStudio: Integrated Development Environment for R. RStudio. PBC,
and urban heat islands: implications on human thermal comfort and urban heat Boston, MA. URL. http://www.rstudio.com/.
management. Environ. Res. 193, 110584 https://doi.org/10.1016/J. Santamouris, M., 2020. Recent progress on urban overheating and heat island research.
ENVRES.2020.110584. Integrated assessment of the energy, environmental, vulnerability and health impact.
Ho¨ppe, P., 1999. The physiological equivalent temperature - a universal index for the Synergies with the global climate change. Energy Build. 207, 109482 https://doi.
biometeorological assessment of the thermal environment. Int. J. Biometeorol. 43, org/10.1016/J.ENBUILD.2019.109482.
71–75. https://doi.org/10.1007/s004840050118. Siddiqui, A., Kushwaha, G., Nikam, B., Srivastav, S.K., Shelar, A., Kumar, P., 2021.
Huang, J., Hao, T., Wang, Y., Jones, P., 2022. A street-scale simulation model for the Analysing the day/night seasonal and annual changes and trends in land surface
cooling performance of urban greenery: evidence from a high-density city. Sustain. temperature and surface urban heat island intensity (SUHII) for Indian cities.
Cities Soc. 82, 103908 https://doi.org/10.1016/J.SCS.2022.103908. Sustain. Cities Soc. 75, 103374 https://doi.org/10.1016/J.SCS.2021.103374.
Italian National Institute of Statistics, 2021. Italian national Institute of Statistics (istat) Son, J.Y., Lane, K.J., Lee, J.T., Bell, M.L., 2016. Urban vegetation and heat-related
[WWW Document]. URL. https://www.istat.it/en/. mortality in Seoul, Korea. Environ. Res. 151, 728–733. https://doi.org/10.1016/J.
Kinnunen, A., Talvitie, I., Ottelin, J., Heinonen, J., Junnila, S., 2022. Carbon ENVRES.2016.09.001.
sequestration and storage potential of urban residential environment – a review. Sun, C.-Y., Brazel, A.J., Chow, W.T.L., Hedquist, B.C., Prashad, L., 2009. Desert heat
Sustain. Cities Soc. 84, 104027 https://doi.org/10.1016/J.SCS.2022.104027. island study in winter by mobile transect and remote sensing techniques. Theor.
Kolokotsa, D.D., Giannariakis, G., Gobakis, K., Giannarakis, G., Synnefa, A., Appl. Climatol. 98, 323–335. https://doi.org/10.1007/s00704-009-0120-2.
Santamouris, M., 2018. Cool roofs and cool pavements application in Acharnes, Tan, J., Zheng, Y., Tang, X., Guo, C., Li, L., Song, G., Zhen, X., Yuan, D., Kalkstein, A.J.,
Greece. Sustain. Cities Soc. 37, 466–474. https://doi.org/10.1016/J. Li, F., Chen, & H., 2010. The urban heat island and its impact on heat waves and
SCS.2017.11.035. human health in Shanghai. Int. J. Biometeorol. 54, 75–84. https://doi.org/10.1007/
Kousis, I., Pigliautile, I., Pisello, A.L., 2021. Intra-urban microclimate investigation in s00484-009-0256-x.
urban heat island through a novel mobile monitoring system. Sci. Rep. 11, 9732. Tsin, P.K., Knudby, A., Krayenhoff, E.S., Ho, H.C., Brauer, M., Henderson, S.B., 2016.
https://doi.org/10.1038/s41598-021-88344-y. Microscale mobile monitoring of urban air temperature. Urban Clim. 18, 58–72.
Kyriakodis, G.E., Santamouris, M., 2018. Using reflective pavements to mitigate urban https://doi.org/10.1016/j.uclim.2016.10.001.
heat island in warm climates - results from a large scale urban mitigation project. Tsoka, S., Theodosiou, T., Tsikaloudaki, K., Flourentzou, F., 2018. Modeling the
Urban Clim. 24, 326–339. https://doi.org/10.1016/J.UCLIM.2017.02.002. performance of cool pavements and the effect of their aging on outdoor surface and
Li, H., Meier, F., Lee, X., Chakraborty, T., Liu, J., Schaap, M., Sodoudi, S., 2018. air temperatures. Sustain. Cities Soc. 42, 276–288. https://doi.org/10.1016/J.
Interaction between urban heat island and urban pollution island during summer in SCS.2018.07.016.
Berlin. Sci. Total Environ. 636, 818–828. https://doi.org/10.1016/J. United Nations Human Settlements Programme, 2020. World Cities Report 2020: the
SCITOTENV.2018.04.254. Value of Sustainable Urbanization.
Lopez-Cabeza, V.P., Alzate-Gaviria, S., Diz-Mellado, E., Rivera-Gomez, C., Galan- Wang, M., He, G., Zhang, Zhaoming, Wang, G., Zhang, Zhengjia, Cao, X., Wu, Z., Liu, X.,
Marin, C., 2022. Albedo influence on the microclimate and thermal comfort of 2017. Comparison of spatial interpolation and regression analysis models for an
courtyards under Mediterranean hot summer climate conditions. Sustain. Cities Soc. estimation of monthly near surface air temperature in China. Remote Sens 9. https://
81, 103872 https://doi.org/10.1016/J.SCS.2022.103872. doi.org/10.3390/rs9121278.
Maggiotto, G., Miani, A., Rizzo, E., Castellone, M.D., Piscitelli, P., 2021. Heat waves and Wong, N.H., Tan, C.L., Kolokotsa, D.D., Takebayashi, H., 2021. Greenery as a mitigation
adaptation strategies in a mediterranean urban context. Environ. Res. 197, 111066 and adaptation strategy to urban heat. Nat. Rev. Earth Environ. 2, 166–181. https://
https://doi.org/10.1016/J.ENVRES.2021.111066. doi.org/10.1038/s43017-020-00129-5.
Mahmoud, A.H.A., 2011. Analysis of the microclimatic and human comfort conditions in Yadav, N., Sharma, C., 2018. Spatial variations of intra-city urban heat island in
an urban park in hot and arid regions. Build. Environ. 46, 2641–2656. https://doi. megacity Delhi. Sustain. Cities Soc. 37, 298–306. https://doi.org/10.1016/J.
org/10.1016/J.BUILDENV.2011.06.025. SCS.2017.11.026.
Matzarakis, A., Mayer, H., Iziomon, M.G., 1999. Applications of a universal thermal Zhang, M., Gao, Z., 2021. Effect of urban form on microclimate and energy loads: case
index: physiological equivalent temperature. Int. J. Biometeorol. 43, 76–84. https:// study of generic residential district prototypes in Nanjing, China. Sustain. Cities Soc.
doi.org/10.1007/s004840050119. 70, 102930 https://doi.org/10.1016/J.SCS.2021.102930.
Matzarakis, A., Rutz, F., Mayer, H., 2007. Modelling radiation fluxes in simple and Zhang, R., 2020. Cooling effect and control factors of common shrubs on the urban heat
complex environments-application of the RayMan model. Int. J. Biometeorol. 51, island effect in a southern city in China. Sci. Rep. 10 https://doi.org/10.1038/
323–334. https://doi.org/10.1007/s00484-006-0061-8. s41598-020-74559-y.
14
TYPE OriginalResearch
PUBLISHED 09March2023
DOI 10.3389/frsc.2023.1129388
Effectiveness of travel behavior
and infrastructure change to
OPENACCESS
EDITEDBY mitigate heat exposure
YangZhou,
ShenzhenUniversity,China
REVIEWEDBY
AugustaWilliams, RuiLi1*,MikhailV.Chester1,2,3,4,ArianeMiddel4,5,6,
UpstateMedicalUniversity,UnitedStates
JenniferK.Vanos3,DanaeHernandez-Cortes3,7,IsaacBuo8 and
JinxinZhu,
SunYat-senUniversity,China DavidM.Hondula4,5
*CORRESPONDENCE
RuiLi 1SchoolofSustainableEngineeringandBuiltEnvironment,ArizonaStateUniversity,Tempe,AZ,
ruili11@asu.edu UnitedStates,2MetisCenterforInfrastructureandSustainableEngineering,ArizonaStateUniversity,
Tempe,AZ,UnitedStates,3SchoolofSustainability,ArizonaStateUniversity,Tempe,AZ,UnitedStates,
SPECIALTYSECTION 4GlobalInstituteofSustainabilityandInnovation,ArizonaStateUniversity,Tempe,AZ,UnitedStates,
Thisarticlewassubmittedto
5SchoolofGeographicalSciencesandUrbanPlanning,ArizonaStateUniversity,Tempe,AZ,
UrbanResourceManagement,
UnitedStates,6SchoolofArts,MediaandEngineeringandSchoolofComputing,Informatics,and
asectionofthejournal
DecisionSystemsEngineering,ArizonaStateUniversity,Tempe,AZ,UnitedStates,7SchoolfortheFuture
FrontiersinSustainableCities
ofInnovationinSociety,ArizonaStateUniversity,Tempe,AZ,UnitedStates,8DepartmentofGeography,
RECEIVED21December2022 UniversityofTartu,Tartu,Estonia
ACCEPTED08February2023
PUBLISHED09March2023
CITATION Urban heat exposure is an increasing health risk among urban dwellers. Many
LiR,ChesterMV,MiddelA,VanosJK, cities are considering accommodating active mobility, especially walking and
Hernandez-CortesD,BuoIandHondulaDM
biking,toreducegreenhousegasemissions.However,promotingactivemobility
(2023)Effectivenessoftravelbehaviorand
infrastructurechangetomitigateheat withoutproperplanningandtransportationinfrastructuretocombatextremeheat
exposure.Front.Sustain.Cities5:1129388.
exposure may cause more heat-related morbidity and mortality, particularly in
doi:10.3389/frsc.2023.1129388
future with projected climate change. This study estimated the effectiveness of
COPYRIGHT activetripheatexposuremitigationunderbuiltenvironmentandtravelbehavior
©2023 Li,Chester,Middel,Vanos,
change. Simulations of the Phoenix metro region’s 624,987 active trips were
Hernandez-Cortes,BuoandHondula.Thisisan
open-accessarticledistributedundertheterms conductedusingtheactivity-basedtravelmodel(ABM),meanradianttemperature
oftheCreativeCommonsAttributionLicense (T ,nethumanradiationexposure),transportationnetwork,andlocalclimate
(CCBY).Theuse,distributionorreproduction MRT
zones.Twoscenariosweredesignedtoreducetravelerexposure:onethatfocuses
inotherforumsispermitted,providedthe
originalauthor(s)andthecopyrightowner(s) on built environment change (making neighborhoods cooler) and the other on
arecreditedandthattheoriginalpublicationin travelbehavior(switchingfromshortertraveltimebuthigherexposureroutesto
thisjournaliscited,inaccordancewith
longer travel time but cooler routes) change. Travelers experienced T heat
acceptedacademicpractice.Nouse, MRT
distributionorreproductionispermittedwhich exposure ranging from 29◦C to 76◦C (84◦F to 168◦F) without environmental or
doesnotcomplywiththeseterms. behavioral change. Active trip T exposures were reduced by an average of
MRT
1.2–3.7◦C when the built environment was changed from a hotter to cooler
design.Behavioralchangescooledupto10timesmoretripsthanchangesinbuilt
environmentchanges.Themarginalbenefitofcoolingdecreasedasthenumber
of cooled corridors transformed increased. When the most traveled 10km of
corridorswerecooled,themarginalbenefitaffectedover1,000trips/km.However,
cooling all corridors results in marginal benefits as low as 1 trip/km. The results
revealthatheavilytraveledcorridorsshouldbeprioritizedwithlimitedresources,
andthebestcoolingresultscomefromenvironmentandtravelbehaviorchange
together. The results show how to surgically invest in travel behavior and built
environmentchangetomosteffectivelyprotectactivetravelers.
KEYWORDS
personalheatexposure,heatmitigation,activetransportation,urban,climate
FrontiersinSustainableCities 01 frontiersin.org

Lietal. 10.3389/frsc.2023.1129388
1. Introduction
whetherchangingthebuiltenvironmenttowardlow-temperature
configurationscansignificantlyreduceheatexposureforwalking
Heat exposure is an increasing health risk in many cities. and biking travelers, (2) estimate whether changing the travel
Maricopa County, Arizona, a rapidly expanding region in the behavior—reroutingpeopletocoolercorridors—canreducetheir
hot and arid Sonoran Desert of the Southwest United States, has heat exposure, and (3) find the marginal cooling benefits of
been a harbinger of cities with changing climates. In 2021, there both built environment and travel behavior change. To achieve
were104daysover38◦C(100◦F)and22daysover43◦C(110◦F) these objectives, simulations of the Phoenix metropolitan area’s
(NOAA, 2021). Maricopa County reported 339 heat-associated daily travel are conducted using a mesoscale travel behavior
deaths in 2021, a 220% increase from 2011 (Maricopa County and exposure model (Icarus) to test how changing the built
Public Health, 2021). Rising summer temperatures, extended environmentandbehaviorcanreduceheatexposure.
heatwavedurations,andincreasingpopulationdensitycontribute
to the region’s increasing heat morbidity and mortality (Hajat
2. Methodology
andKosatky,2010;Eisenmanetal.,2016;Perkins-Kirkpatrickand
Gibson,2017).Climatechangeisexpectedtoincreaseurbanheat,
Threesetsofsimulationsweredesignedforthisstudytoassess
exacerbatingheat-relatedriskstohealthandqualityoflifeamong
heat mitigation effects—a baseline simulation, a simulation of a
urbandwellers.
built environment change, and a simulation of travel behavior
Promotingactivetripshasbeenusedasatooltocurbclimate
change (Figure1). All simulations are conducted in Icarus, a
change and reduce urban heat. Many cities have recognized that
personal daily heat exposure simulation platform that estimates
accommodating active mobility is necessary to reduce urban-
exposureconsideringeachindividual’sactivityandtravelschedule,
induced anthropogenic greenhouse gas (GHG) emissions, which
transportationinfrastructure,environmentaltemperature,andthe
driveglobalclimatechange(Maizlishetal.,2013;Bhatetal.,2022;
indoor/outdoor environment (Li et al., 2023). Two scenarios
BraunandFraser,2022).InadditiontopotentiallyreducingGHG,
are designed to test the cooling effects of changing the built
encouragingactivemobilitycanproduceco-benefitsforresidents
environmentandtravelbehavior.Localclimatezones(LCZ),which
byincreasingphysicalactivitiesandreducingchronicdisease(de
describe the built environment by characterizing geometric and
Nazelleetal.,2010).However,activetravelersaredirectlyexposed
land-cover patterns (Stewart and Oke, 2012), are introduced to
to the outdoor thermal environment and have higher physical
identify the roadways with lower temperatures in each cooling
exertion compared with drivers (Hoehne et al., 2018), which
scenario. This section describes the tool, datasets, scenario
increases the likelihood of heat stress. Promoting walking and
configurations, and analysis used. We first introduce Icarus, the
bikingwithoutproperplanningandtransportationinfrastructure
adjustments made to the platform, and the data selected for this
tocombatextremeheatexposuremayincreasefutureheat-related
studybeforeintroducingthesimulationscenarioconfigurations.
morbidityandmortality.
Considerable research has proved the local cooling effects
of heat mitigation strategies. Heat mitigation strategies, such as
2.1. Icarus model overview
increasesingreenspace(Tanetal.,2017;Aminipourietal.,2019;
Yin et al., 2022), reflective and permeable pavements (Qin and
Hiller,2014),andcoolroofs(Middeletal.,2015),havebeenshown The Icarus model is an environmentally augmented
toimproveoutdoorthermalcomfortbyreducingtheneighborhood travel and activity simulation model developed to estimate
air temperature (Tair) and environmental radiation. The heat people’s heat exposure during a typical workday (Li et al.,
mitigation strategies are carried out in areas with a high-heat 2023). When data are inputted, Icarus first constructs a
vulnerabilityindexorwithhighambienttemperaturereadings(Sun transportation network with the spatial–temporal temperature
et al., 2021), and simulations show that pedestrians get thermal information and then extracts each person’s daily travel and
comfort from the application of these mitigation strategies in activity schedule in the simulation. Based on the travel
the local environment (Taleghani et al., 2016). Previous research schedule, Icarus routes trips in the transportation network.
has shown that corridors with high ambient temperatures do Then, personal heat exposures are calculated based on the
not necessarily correspond to where people travel the most (Li environmental temperature (air and radiant) at the location
et al., 2023), and travelers can get some relief from the heat by where the activities and trips occur. The population-scale
rerouting their travel path to be longer but cooler (Middel et al., results describe population demographic, behavior, and
2014). However, estimating the cooling benefits for active trips infrastructurecharacteristics.
consideringtravelbehavior,includingtraveltime,mode,androute Icarus requires activity-based model (ABM) output from
choice, is still a rare topic. As cities with limited budgets aim metropolitanplanningorganizationtravelmodels.First,theABM
to redesign the built environment to reduce urban dwellers’ heat data are used to describe travel-activity chains, agents, trips, and
exposure and encourage outdoor active trips, there are lingering locations. The ABM data provide trip origins and destinations
questionsaboutwheretoimplementcoolingstrategiessothatthe (O/D) described through either traffic or micro-analysis spatial
mostvulnerabletripsreceivethemostsignificantbenefit. zones(TAZorMAZ).AMAZorTAZcontainsdozenstohundreds
This study estimates the effectiveness of personal outdoor of buildings, and the routing of trips requires precise start and
activetripheatexposuremitigationatthenexusofenvironmental end locations. As such, a building parcel dataset, which provides
temperature, travel behavior, and the urban built environment. thelocationandland-useinformation,isintroducedtodownscale
The specific objectives of this article are to (1) determine theO/DfromtheTAZorMAZleveltotheparcellevel.However,
FrontiersinSustainableCities 02 frontiersin.org

| Lietal. |     |     |     |     |     |     |     |     |     |     |     | 10.3389/frsc.2023.1129388 |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- |
FIGURE1
Simulationsandscenarios.
a transportation network dataset, which contains the location of (wij) for each edge (i, j) in the network, the path choice follows
| the roadway | and allowed | travel | mode, | is used | as the | base | for (Equations1–3), |     |     |     |     |     |     |     |
| ----------- | ----------- | ------ | ----- | ------- | ------ | ---- | ------------------- | --- | --- | --- | --- | --- | --- | --- |
routingthetrips.Environmentaltemperaturedatasetswithspatial–
| temporal | readings are | needed | to calculate | the | heat | exposure. |     |     |     |     |     |     |     |     |
| -------- | ------------ | ------ | ------------ | --- | ---- | --------- | --- | --- | --- | --- | --- | --- | --- | --- |
I c a r us in g e st s va ri o u s c o m m o n ly u se d t em p e ra t u r e m e a s ur e m e n ts , ω ≥0andforalli
|              |                     |               |             |                 |              |            |       | min | ijxij, | subjecttoxij |     |     |     | (1) |
| ------------ | ------------------- | ------------- | ----------- | --------------- | ------------ | ---------- | ----- | --- | ------ | ------------ | --- | --- | --- | --- |
| s u c h as a | i r t em p e r at u | r e , m e a n | ra d ia n t | te m p e r      | at u r e ( T | ),         | a n d |     | X      |              |     |     |     |     |
|              |                     |               |             |                 |              | M R T      |       |     | ij∈A   |              |     |     |     |     |
| wet-bulb     | globe temperature   | (WBGT).       |             | Air temperature |              | quantifies |       |     |        |              |     |     |     |     |
1, if i=s
e x p o s u r e w it ho u t c o n sid e ri n g w i n d , ra di a n ce ,a nd h u m i d it y . TM R T 
|     |     |     |     |     |     |     |     |     |     | xij − | xji =  | −1, if | i=t | (2) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | -------- | ------ | --- | --- |
m e a s u r e s te m p er a t u re b y c o n si d e r in g t h e su m o f a ll s h o r t- an d X X
|     |     |     |     |     |     |     |     |     | j   | j   |     | 0, otherwise |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | --- |
long-wave radiations exposed to a human body (Lindberg et al., 
2 0 08 ; M i d de l a n d K r a y e n h o ff , 2 0 1 9 ). F in al ly , W B G T , w h ic h i s ω (TMRT,ij,t)aLij
|     |     |     |     |     |     |     |     |     |     | ij  | =   |     |     | (3) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
w id el y us e d in h e a ts tr e s s i n d e xe s, i n c lu de s th e im pa ct s o fh u m i dit y X
t∈H
| and wind | in addition | to air | temperature | (Budd, | 2008; | OSHA, |     |     |     |     |     |     |     |     |
| -------- | ----------- | ------ | ----------- | ------ | ----- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
2015).
|     |     |     |     |     |     |     | where | H is      | the time | stamp. | In this | study,  | H ranges      | from 7 |
| --- | --- | --- | --- | --- | --- | --- | ----- | --------- | -------- | ------ | ------- | ------- | ------------- | ------ |
|     |     |     |     |     |     |     | am to | 8 pm with | a 15-min | time   | step,   | and Lij | is the length | of     |
edgeij.A“comfortoverdistance”parameteraisintroducedfrom
|     |     |     |     |     |     |     | the study | by Middel | et  | al. (2017) | to control | for | the importance |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | --------- | --- | ---------- | ---------- | --- | -------------- | --- |
2.2. Simulation configuration of thermal comfort in routing. This study sets a equal to 1
|     |     |     |     |     |     |     | if the | pathfinding | considers | thermal | comfort, |     | thus minimizing |     |
| --- | --- | --- | --- | --- | --- | --- | ------ | ----------- | --------- | ------- | -------- | --- | --------------- | --- |
Only outdoor trips are considered as this is when travelers averageTMRTexposure.Alternatively,aequals0ifthepathfinding
directly interact with environmental heat, whereas in-vehicle minimizes physical distance regardless of exposure. The shortest
trips are more likely to have an air-conditioning controlled pathisthecollectionofedgeswherexijequals1.Theheatexposure
temperature. TMRT is used to calculate personal heat exposure calculation considers the average TMRT a trip experiences along
during these outdoor trips. Compared with air temperature theroute.Throughoutthearticle,weusetheterm“heatexposure”
and WBGT, TMRT more accurately describes the physiological torefertotheTMRT exposureofanindividual.Finally, LCZsfor
impacts of heat that people experience in a hot, dry outdoor thePhoenixmetropolitanareaareintroducedtoidentifyroadways
environment (Middel and Krayenhoff, 2019). Temperature- withloworhighTMRT ineachclimatezone.LCZsareareaswith
weighted pathfinding is then used to allow agents reroute to similarfeatures,suchaslandsurfacecoverandmaterial,building
cooler corridors. With the origin (s), target (t), and the cost structure, and population activity (Stewart and Oke, 2012). Each
| FrontiersinSustainableCities |     |     |     |     |     |     | 03  |     |     |     |     |     | frontiersin.org |     |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

| Lietal. |     |     |     |     |     |     |     |     |     |     |     |     | 10.3389/frsc.2023.1129388 |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- |
LCZclassdescribeseitherthebuiltenvironmenttypeortheland- 2.2.1.3.Localclimatezonesdata
cover type of the area (Wang et al., 2018). The data used in this A 100-m resolution local climate zones (LCZ) raster layer
studyaredetailedinthefollowingsections. createdbyWangetal.(2018)isusedtocharacterizearchetypical
infrastructuredesignsandtheireffectsonheat.Usingthedefinition
andsurfacepropertyvaluesofLCZsproposedbyStewartandOke
(2012),thePhoenixmetropolitanareaisclassifiedintosevenbuilt
|     |     |     |     |     |     |     |     | environment | type | LCZs | and seven | land-cover |     | type LCZs | using |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ---- | ---- | --------- | ---------- | --- | --------- | ----- |
2.2.1.Data
|     |     |     |     |     |     |     |     | Google Earth, |     | Saga GIS, | and Landsat |     | eight scenes | data | (Wang |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | --------- | ----------- | --- | ------------ | ---- | ----- |
2.2.1.1.ABMandassessorparceldata
etal.,2018).BuiltenvironmenttypeLCZsidentifiedinthePhoenix
| The | Maricopa | Association |     | of Governments |     | (MAG) | (Vovsha |     |     |     |     |     |     |     |     |
| --- | -------- | ----------- | --- | -------------- | --- | ----- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
metropolitanareaincludeLCZ4(openhighrise),5(openmidrise),
| et al., 2011) | provided  |     | the ABM | for a synthetic |              | population | of      |         |            |                |     |            |          |     |          |
| ------------- | --------- | --- | ------- | --------------- | ------------ | ---------- | ------- | ------- | ---------- | -------------- | --- | ---------- | -------- | --- | -------- |
|               |           |     |         |                 |              |            |         | 6 (open | low rise), | 7 (lightweight |     | low rise), | 8 (large | low | rise), 9 |
| 3.8 million   | travelers | and | 18.6    | million trips   | for Maricopa |            | County, |         |            |                |     |            |          |     |          |
(sparselybuilt),and10(heavyindustry).Theland-covertypeLCZs
| Arizona. | In general, | 13% | (504,961) | of the | 3.8 million | people | in  |     |     |     |     |     |     |     |     |
| -------- | ----------- | --- | --------- | ------ | ----------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
identifiedareA(densetrees),B(scatteredtrees),C(bush,scrub),
theABMhadwalkingorbikingtripsintheirdailyschedule.The
D(lowplants),E(barerockorpaved),F(baresoilorsand),and
ABMisgeneratedfromthe2010NationalHouseholdTravelSurvey
|     |     |     |     |     |     |     |     | G (water). | In general, | 46.7% | of  | the Phoenix | metropolitan |     | area is |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ----------- | ----- | --- | ----------- | ------------ | --- | ------- |
(ParsonsBrinckerhoff,2010).IntheABM,93.61%(17.41million)
baresoilorsand(LCZF),and33.1%areopenlow-risebuildings
ofthetripswerein-vehicle,5.6%(1.05million)werewalking,and
(LCZ6).
| 0.79% (148,541) |     | were | biking. | The MAG | ABM gives | the | activity |     |     |     |     |     |     |     |     |
| --------------- | --- | ---- | ------- | ------- | --------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
locationinthemicro-analysiszone(MAZs).
The Maricopa County assessor database (Maricopa County 2.2.1.4.Streetnetwork
Assessor’sOffice,2018)isintroducedtodownscalethetriporigin A roadway network of 32,047km is extracted from
|     |     |     |     |     |     |     |     | OpenStreetMap |     | (OpenStreetMap |     | Contributors, |     | 2015) | and |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | -------------- | --- | ------------- | --- | ----- | --- |
anddestinationfromtheMAZstoparcels.Theassessordatabase
providesdetailedinformationregardingthelocationandfunction ingestedinthesimulation.Thenetworkconsistsofarterials,local
ofeachparcel.TheparcelsaretaggedwiththeMAZinformationby roads,andbikeandpedestriantrails.
spatiallyjoiningfine-scaleassessordatawiththeMAZmap.Icarus
randomlyassignsO/D,markedasMAZinABM,toparcelswithin
thesameMAZ.
2.2.2.Studyarea
|     |     |     |     |     |     |     |     | This      | study   | focuses on | 2,070   | km2 (800 | square | miles) | of the  |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ---------- | ------- | -------- | ------ | ------ | ------- |
|     |     |     |     |     |     |     |     | urbanized | Phoenix | metro      | region, | a 6%     | area   | of the | Phoenix |
2.2.1.2.Temperaturedata
metropolitanarea(Figure2).Ingeneral,48%ofthestudyareais
| Hourly         | 1-m | resolution | TMRT   | raster layers | provided |     | by Buo,  |               |           |         |          |         |       |                    |         |
| -------------- | --- | ---------- | ------ | ------------- | -------- | --- | -------- | ------------- | --------- | ------- | -------- | ------- | ----- | ------------------ | ------- |
|                |     |            |        |               |          |     |          | open low-rise | buildings |         | (LCZ 6), | 15% is  | large | low-rise buildings |         |
| Sagris, Jaagus | and | Middel     | (under | review)       | are used | to  | estimate |               |           |         |          |         |       |                    |         |
|                |     |            |        |               |          |     |          | (LCZ 8),      | and 27%   | is bare | soil     | or sand | (LCZ  | F) (Wang           | et al., |
exposures at fine scales during travel. As explained earlier, TMRT 2018).Thestudyareacovers54%(271,272)ofthepopulationwho
| represents | the total | heat | load | on the human | body | (Middel | and |              |     |        |          |               |     |         |        |
| ---------- | --------- | ---- | ---- | ------------ | ---- | ------- | --- | ------------ | --- | ------ | -------- | ------------- | --- | ------- | ------ |
|            |           |      |      |              |      |         |     | have walking | or  | biking | trips on | their agenda, | and | 624,987 | active |
Krayenhoff, 2019). It is a critical parameter that controls the trips are considered in the simulation. The simulation date is 27
| thermal   | comfort | of humans |     | and the human |           | energy | balance   |            |         |         |            |           |        |                  |     |
| --------- | ------- | --------- | --- | ------------- | --------- | ------ | --------- | ---------- | ------- | ------- | ---------- | --------- | ------ | ---------------- | --- |
|           |         |           |     |               |           |        |           | June 2012, | the     | same as | the TMRT   | simulated | date.  | Moreover,        | the |
| (Lindberg | et al., | 2008).    | The | probability   | of humans |        | suffering |            |         |         |            |           |        |                  |     |
|           |         |           |     |               |           |        |           | simulation | assumes | the     | population | and       | travel | pattern remained |     |
from heat stress is higher when TMRT at a location is higher the same in 2012, although the MAG ABM is based on the
| than air | temperature |     | due to | direct sun | exposure. | TMRT | was |     |     |     |     |     |     |     |     |
| -------- | ----------- | --- | ------ | ---------- | --------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
2010survey.
|           |        |      |           |             |      | 29◦C | (84◦F) |     |     |     |     |     |     |     |     |
| --------- | ------ | ---- | --------- | ----------- | ---- | ---- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
| simulated | for 27 | June | 2012, and | TMRT ranges | from |      |        |     |     |     |     |     |     |     |     |
85◦C (185◦F).
| to  |     | The | layers | were modeled |     | using the | solar |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------ | ------------ | --- | --------- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
longwaveenvironmentalirradiancegeometry(SOLWEIG)model
|          |             |     |                |     |         |       |         | 2.3. Simulations |     |     |     |     |     |     |     |
| -------- | ----------- | --- | -------------- | --- | ------- | ----- | ------- | ---------------- | --- | --- | --- | --- | --- | --- | --- |
| proposed | by Lindberg |     | et al. (2008). | The | primary | input | for the |                  |     |     |     |     |     |     |     |
modelwasdigitalsurfacemodelsandmeteorologicalforcingdata
fromtheArizonaMeteorologicalNetworkEncantoParkweather Three simulations were conducted to assess heat mitigation
station (AZMet, 2022). The digital surface models were created effects—thebaseline,builtenvironmentchange,andtravelbehavior
using the triangulated irregular networks algorithm with high- change.Thebaselinesimulationprofilesthecurrentheatexposure
resolution light detection and ranging (LiDAR) point cloud data and travel behavior, while the changing built environment and
from the United States Geological Services (USGS). SOLWEIG behavior simulations are considered to compare their heat
models radiation in six directions (up, down, and the four reductionbenefits.Thebaselinesimulationcapturesheatexposure
cardinaldirections)accordingtotheconceptsestablishedbyHöppe of active (walking and biking) trips as they prioritize the
(1992). The suitability of SOLWEIG to make TMRT estimations shortest travel distance. Two cooling scenarios are selected in
in complex urban configurations with acceptable accuracies for the changing environment simulation to compare the different
thermal comfort studies is well documented. TMRT values before levelsofheatmitigationintensities.Travelerscanalsoreducetheir
sunriseandaftersunsetareassumedtobeequaltoairtemperature heat exposure by changing their travel behavior and rerouting
extrapolatedfromDaymet(Thorntonetal.,2016;Lietal.,2023). to a cooler path with some extra distance. The rerouting is
Theairtemperatureonthesimulationdayrangedbetween29◦C achieved by applying the temperature-weighted shortest distance
(84◦F)and43◦C(110◦F).
pathfindingalgorithm.
| FrontiersinSustainableCities |     |     |     |     |     |     |     | 04  |     |     |     |     |     | frontiersin.org |     |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

| Lietal. |     |     |     |     |     | 10.3389/frsc.2023.1129388 |     |
| ------- | --- | --- | --- | --- | --- | ------------------------- | --- |
FIGURE2
Studyarea(A)andtheLCZsinthestudyarea(B).
2.3.1.Simulation1—Baseline exposures after a proportion of the street-built environment
Thebaselinesimulationprofilesthesyntheticpopulation’sheat changes. Thehigh-resolutionTMRT capturestheheterogeneityof
exposureandidentifieswherepeopletravelinthecurrentnetwork. temperaturewithinthestreetnetwork.FromtheTMRT,LCZ,and
Icarus simulates travelers’ heat exposure by extracting trips and roadway data, each corridor’s temperature in the same LCZ is a
their O/D from the MAG ABM and Maricopa County assessor statistical distribution at a given time. Built environment change
database, then routing the shortest distance path of trips on the embraces the following assumptions. First, roadways with high
roadwaynetwork(Lietal.,2023).TheTMRT andairtemperature temperaturescanbecooleddowntothelow-temperaturecorridors
areparsedtothestreetsbyspatiallyjoiningthetemperatureraster inthesameLCZ.Second,whencorridorsareselectedforcooling,
layers to the transportation network. The temperature on each theirTMRTcanbecooledtothemeanTMRTofthelow-temperature
street is a sequence of readings in 15-min intervals for a total of corridors in the same LCZ. Third, trips still chose the shortest
24h. Trip heat exposure is calculated as the average temperature distancepathbetweentheO/D.
alongthepath. The environmental change simulations first identify the cool
Thebaselinesimulationrepresentsthecurrentenvironmental corridors that are the roadway sections with the lowest TMRT in
condition, and the calculated heat exposure results are used to eachLCZ.TheLCZsareassignedtostreetsectionsbyoverlaying
comparethecoolingeffectsinchangingenvironmentsandtravel the LCZ raster layer over the transportation network. At the
| behavior simulation. | The | shortest distance | path generated | in the                           |     |                  |     |
| -------------------- | --- | ----------------- | -------------- | -------------------------------- | --- | ---------------- | --- |
|                      |     |                   |                | sametime,thecorridorsaverageTMRT |     | from7amto8pmwhen |     |
baselinesimulationisusedtoidentifythenetwork’slinkflow,which the TMRT is available is calculated. The reason to consider the
| is the number | of trips passing | through | a section of the | roadway      |                         |          |                   |
| ------------- | ---------------- | ------- | ---------------- | ------------ | ----------------------- | -------- | ----------------- |
|               |                  |         |                  | average TMRT | is that the temperature | readings | fluctuated during |
during the simulation day. The link flow is used to identify the the day. Two scenarios are considered when choosing the low-
corridorstocooldowninthechangingenvironmentsimulation.
|     |     |     |     | temperature | corridors in each LCZ          | to resemble | different cooling |
| --- | --- | --- | --- | ----------- | ------------------------------ | ----------- | ----------------- |
|     |     |     |     | levels. In  | scenario 1, the cool corridors | are the     | coolest 10% of    |
roadwaysineachLCZ.Inscenario2,roadwayswiththelowest50%
2.3.2.Simulation2—Builtenvironmentchange averageTMRT areselectedascoolcorridors.Theselectionofcool
Simulation 2 assumes that neighborhoods can be converted corridorsexcludesoutliersidentifiedwiththe1.5xIQRrulewhere
to low-temperature configurations and calculates personal heat a numerical fence was built by taking 1.5 times the interquartile
| FrontiersinSustainableCities |     |     |     | 05  |     |     | frontiersin.org |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --------------- |

Lietal. 10.3389/frsc.2023.1129388
3. Results
range. The mean TMRT of the identified cool corridors subset is
calculatedandassumedtobethetargettemperaturefornon-cool
3.1. Baseline simulation and current build
corridorstoachieve.
environment
After identifying the cool corridors, the rest of the roadway
networkisevaluatedfortransformation.Anincrementalapproach
is used to transform the network from non-cool to cool. We Travelers were under high TMRT exposure in the baseline
only convert 1km of the most traveled non-cool network in simulation. Trip heat exposure ranged from 29◦C to 76◦C (84◦F
the first increment. In subsequent increments, we increase the to 168◦F) with a median temperature of 61◦C (142◦F). The
lengthofnon-coolcorridortoperformtheenvironmentalchange. heat exposure represents the average TMRT traveler experienced
All non-cool corridors used in the baseline simulation will have duringactiveoutdoortrips.Mostsimulatedactivetripsexperienced
environmental change. The candidate non-cool roadways are high TMRT, and 20% were above 66.5◦C (151◦F). The reasons
chosen according to the link flow in the baseline simulation and for high trip heat exposures were that the TMRT considered the
prioritizingthemosttraveledlinks.TheTMRTofselectednon-cool environmental radiance, such as solar radiation, on the human
corridorsisconvertedtothetargettemperaturecalculatedinthe body,andmoretripshappeningduringthedaytime(Lietal.,2023)
cool corridor identification process based on the LCZ. Trip heat whensolarradiationwashigh.TheTMRTequaledairtemperature
exposureisthencalculatedusingtheupdatedTMRT. as29◦C(84◦F)afterduskandbeforedawnwhentherewasnodirect
sunlight.Themediumsimulatedwalkingandbikingtripdistances
are1.6km(1mile).
2.3.3.Simulation3—Travelbehaviorchange Considering the imbalance of usage within the network and
In a heterogeneous local heat environment, where the acrosstheLCZs,coolingdownthemosttraveledcorridorscould
built environment could impact the street temperature, active benefit more people and trips. The active outdoor trips were
travelers may choose a longer but cooler route to avoid concentrated in a small portion of the network. The 624,987
excessive heat exposure. The behavior change is simulated activetripsutilized62%(19,863km)ofroadwaylinks.Only10%
by rerouting travelers on the temperature-weighted network. (3,178km) of the network had over 100 trips in the simulation.
The simulation starts with creating a temperature-weighted The busiest 200-m corridors in Tempe, where the Arizona State
network. The temperature used in the weighted network is the UniversityCampusislocated,had7,000to7,700tripsperday.The
sum of TMRT from 7 am to 8 pm on each roadway. The selectionofhotcorridorsconsideredroadwaytemperatureandthe
rerouting process is carried out on the baseline simulation, network’susageinthebaselinesimulation.Inscenario1(cooledto
and a section of the network is cooled every time. The thecoolest10thpercentileintheLCZ),18,411kmofroadwayswere
heat exposure is calculated after each round of behavior- candidates for environmental change, as they have been visited
changingrouting. atleastonceinbaselinesimulationandwerenotincludedinthe
coolcorridorselections.Inscenario2(cooledtothecoolest50th
percentileintheLCZ),10,409kmofthenetworkwerecandidates
2.4. Cooling benefits analysis forenvironmentalchange.
Roadways in the study area are mainly located in LCZs with
Thecoolingbenefitsofenvironmentandtravelbehaviorchange buildings.Thebuild-typeLCZs,suchasLCZ6(openlowrise)and
aremeasuredbycomparingpopulationheatexposureamongthe LCZ8(largelowrise),accountfor65%ofthestudyregionbuthave
three simulations. The number of cooled trips and the average over87%oftheroadwaysinthem(Table1).Thenaturalland-cover
temperature reduction are considered. Two more concepts are climatezones,suchasLCZF(baresoilorsand)andLCZD(low
introduced to quantify the cooling benefit—the marginal benefit plants),occupy35%ofthestudyregion,butonly12%ofroadways
and the magnitude of cooling for the hottest 20% trips. The are identified in these LCZs (Table1). This aligns with the trend
marginal benefits, which are used to evaluate the effectiveness ofurbanization,wheremoreroadwaysarebuiltinthedeveloped
of the infrastructure improvement, consider the number of trips regionwithbuildings.Comparedwithbaresoil,sand,orsparsely
that get cooled for every kilometer of the roadway network builtLCZs(LCZFandLCZ9),moretripshappenedonroadways
improvement.Themarginalbenefitsarecalculatedasthechange inregionswithmidriseorlow-risebuildings(LCZ5,LCZ6,and
in the total number of trips cooled divided by the change in LCZ8)orplants(LCZD)(Table1).Activetravelersonlyused5%of
the length of the network cooled. High-temperature exposure roadwaysinLCZ9and29%ofroadwaysinLCZF,buttheyvisited
is highly related to health risks, and the cooling benefits of asmuchas66%ofnetworksinLCZ6,61%inLCZD,50%inLCZ
high-heat exposure trips are important to consider. This study 5,and48%inLCZ8.
classifies the hottest 20% of trips in the baseline simulation as The TMRT in regions with middle- to low-rise buildings and
high exposure. The minimum temperature of the high-exposure plants (LCZ 5, LCZ 6, LCZ 8, and LCZ D) is lower than in
trips is selected as the hottest trip threshold. The effectiveness regions with sparse buildings or bare soil (LCZ 9 and LCZ F)
of cooling down the current hottest trips in the changing (Table1). The TMRT was simulated with the shading from trees,
environmentandthroughtravelbehaviorischeckedbycomparing buildings, and pavement environmental radiations. The higher
the ratio of trips with heat exposure surpassing the hottest shading ratio is linked to lower TMRT (Middel et al., 2021),
tripthreshold. and in LCZs with buildings present (5, 6, and 8), the shading
FrontiersinSustainableCities 06 frontiersin.org

| Lietal. |     |     |     |     |     |     |     |     |     |     | 10.3389/frsc.2023.1129388 |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- |
TABLE1 Proportionofland,corridors,current,andtargetTMRTineachLCZ.
at5PM(◦C)
| LCZname |     | Total | Ratioofroadway |     |     | %ofland |     | %ofroad |     | T   |     |     |     |
| ------- | --- | ----- | -------------- | --- | --- | ------- | --- | ------- | --- | --- | --- | --- | --- |
MRT
|     |     | roadway    | visitedbyactive |       |     |     | inthis | inthis |        |                          |     |     |     |
| --- | --- | ---------- | --------------- | ----- | --- | --- | ------ | ------ | ------ | ------------------------ | --- | --- | --- |
|     |     | length(km) |                 | trips |     |     | LCZ    | LCZ    |        |                          |     |     |     |
|     |     |            |                 |       |     |     |        |        | Median | Targetcoolingtemperature |     |     |     |
(5%,95%)
|              |     |        |     |      |     |     |     |     |           | Scenario1∗ |     | Scenario2∗∗ |     |
| ------------ | --- | ------ | --- | ---- | --- | --- | --- | --- | --------- | ---------- | --- | ----------- | --- |
| Openlow-rise |     | 18,606 |     | 0.66 |     |     | 48% | 58% | 67(58,78) |            | 60  |             | 65  |
(LCZ6)
| Largelow-rise |     | 8,258 |     | 0.48 |     |     | 15% | 26% | 67(58,73) |     | 60  |     | 65  |
| ------------- | --- | ----- | --- | ---- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
(LCZ8)
| Baresoilor |     | 3,431 |     | 0.29 |     |     | 27% | 11% | 71(61,73) |     | 64  |     | 68  |
| ---------- | --- | ----- | --- | ---- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
sand(LCZF)
| Sparselybuilt |     | 647 |     | 0.05 |     |     | 0%  | 2%  | 71(59,73) |     | 61  |     | 68  |
| ------------- | --- | --- | --- | ---- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
(LCZ9)
| Lowplants |     | 202 |     | 0.61 |     |     | 6%  | 1%  | 68(62,72) |     | 65  |     | 67  |
| --------- | --- | --- | --- | ---- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
(LCZD)
| Openmidrise |     | 562 |     | 0.50 |     |     | 1%  | 1%  | 64(53,71) |     | 56  |     | 61  |
| ----------- | --- | --- | --- | ---- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
(LCZ5)
∗Scenario1selectscoolcorridorsasthecoolest10%ofroadwaysineachLCZ.∗∗Scenario2selectscoolcorridorsasthecoolest50%ofroadwaysineachLCZ.
from buildings or trees significantly reduces the local TMRT. number of trips that got heat mitigation. As the total length of
The median TMRT value in these LCZs at the hottest time (5 cooled corridors increased, the number of trips cooled increased
7◦C
PM) was 4 to cooler than LCZs with little vegetation and (Figure3). However, 70% of trips got cooled when changing all
few buildings (F and 9). On the contrary, the LCZ with no traveled roadways to scenario 2 (where corridors are cooled to
buildings or sparse building present had a high median TMRT. the coolest 50th percentile in the LCZ). An additional 6% of
Cool corridor selection was purely based on the statistics of trips had exposure reduction when all traveled roadways were
TMRT in each LCZ, regardless of the usage of corridors in the converted to scenario 1 (cooled to the coolest 10th percentile in
| baselinesimulation.Coolcorridorsinscenario1(thecoolest10% |     |     |     |     |     |     |     | theLCZ). |     |     |     |     |     |
| --------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- | --- |
corridors)hadalowerTMRTcomparedwithscenario2(thecoolest
| 50%corridors).SincetheTMRT |         |              | valueisrelatedtoenvironmental |            |      |              |      |           |             |     |           |     |     |
| -------------------------- | ------- | ------------ | ----------------------------- | ---------- | ---- | ------------ | ---- | --------- | ----------- | --- | --------- | --- | --- |
| factors that               | impact  | the radiant, | such                          | as shading |      | and pavement |      |           |             |     |           |     |     |
|                            |         |              |                               |            |      |              |      | 3.3. Trip | temperature |     | reduction |     |     |
| types, more                | efforts | would be     | needed                        | to cool    | the  | corridors    | from |           |             |     |           |     |     |
| scenario                   | 2 to    | scenario 1,  | such as                       | increasing | tree | planting     | or   |           |             |     |           |     |     |
Underthesamecoolingscenario,thelengthofcorridorscooled
permeablepavement.
significantlyimpactstheheatexposurereduction.Theaveragetrip’s
|          |        |     |        |       |     |     |     | heat exposure  | reduction  | was nearly | zero when        | the       | most traveled |
| -------- | ------ | --- | ------ | ----- | --- | --- | --- | -------------- | ---------- | ---------- | ---------------- | --------- | ------------- |
|          |        |     |        |       |     |     |     | 2km roadways   | got cooled | and        | travelers stayed | on        | the shortest  |
| 3.2. The | number | of  | cooled | trips |     |     |     |                |            |            |                  |           |               |
|          |        |     |        |       |     |     |     | distance path. | The heat   | exposure   | of active        | trips was | reduced by    |
0.25◦Cwhentravelerswereroutedinthe2kmcoolednetwork.The
In the same cooling scenario, behavioral change cooled as heat exposure reduction increased as more corridors got cooled.
Whenallcorridorswerecooled,tripsgotanaverageof3.7◦Cheat
| much as | 10 times | more trips | than | built | environment |     | change |     |     |     |     |     |     |
| ------- | -------- | ---------- | ---- | ----- | ----------- | --- | ------ | --- | --- | --- | --- | --- | --- |
and the best temperature reduction comes from changing both exposure reduction in scenario 1 and 1.2◦C in scenario 2. The
the environment and travel behavior. The behavioral change average heat exposure reduction was higher in behavior change
simulations, marked as the solid lines in Figure3, supposed that simulationscomparedwithenvironmentalchangesimulations.In
thetravelerdetouredtoacoolertemperaturebutlongerdistance Figure4,thisisshownasthesolidlinesabovethedashedlinesin
| path. Approximately |     | 2–4% | of the | active trips | got | a temperature |     | thesamescenario. |     |     |     |     |     |
| ------------------- | --- | ---- | ------ | ------------ | --- | ------------- | --- | ---------------- | --- | --- | --- | --- | --- |
reduction from environment change when converting the most Comparingthetwocoolingscenarios,heatexposurereduction
traveled2kminthenetworktocoolerconfigurations(dashedlines wasmoresignificantinscenario1thanscenario2,especiallywhen
in Figure3). In general, 36–37% of trips got reduced exposure the environment change was carried out over a long network
from changing behavior, and the average trip distance increased distance. When all roadways cooled, trips’ heat exposure was
by 10.5m on the 2km cooled network (solid lines in Figure3). reduced in scenario 1 by three times more than in scenario 2.
However, the behavior change cooled a similar number of trips However,thebehavioralchangesimulationsinscenario2(redsolid
compared with environment change when cooled all corridors. lineinFigure4)producedmoreheatexposurereductioncompared
Therefore, 76% of trips were cooled from environmental and to scenario 1 with the built environment changing (blue dashed
behavior change in scenario 1 (blue dashed and solid lines in line in Figure4) when <80km of the network got shifted to a
Figure3).Thelengthofcorridorscooledsignificantlyimpactedthe coolerenvironment.
| FrontiersinSustainableCities |     |     |     |     |     |     |     | 07  |     |     |     |     | frontiersin.org |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- |

Lietal. 10.3389/frsc.2023.1129388
FIGURE3
Numberofactivetripscooledbyenvironmentalandbehavioralchange.Thex-axisrepresentsthetotallengthofthenetworkselectedtoobtain
environmentchange.They-axisrepresentsthetotalnumberoftripstoobtainheatexposuremitigation.Thebluelinesrepresentthestreet’scooling
conditioninscenario1wheretheroadways’temperatureisreducedtothelowest10%.Theredlinesrepresentthestreet’scoolingconditionin
scenario2wheretheroadways’temperatureisreducedtothelowest50%.
FIGURE4
Averagetrips’heatexposurereductionbychangingenvironmentandtravelbehavior.Thex-axisrepresentsthetotallengthofthenetworkselected
togetenvironmentchange.They-axisrepresentstheaveragetemperaturereducedforalltrips.Thebluelinesrepresentthestreet’scooling
conditioninscenario1wheretheroadways’temperatureisreducedtothelowest10%.Theredlinesrepresentthestreet’scoolingconditionin
scenario2wheretheroadways’temperatureisreducedtothelowest50%.
3.4. Cooling benefits of behavioral change shortest path to get heat exposure mitigation. By examining the
ratio of trips that got heat exposure mitigation from behavior
The behavioral change simulations resulted in more benefits change,93–94%ofthesetripsbenefitedfromdetouringthenearby
to active travelers than the environmental change when part of cooler corridors when the 1km network switched to a cooled
the network became cooler. Cooling down the network partially environment(Figure5).Thedominantcoolingbenefitsofbehavior
createdlow-temperaturespotsinthetransportationsystem.These changewerealsodemonstratedastheirheatexposuremitigation
low-temperature corridors attracted agents who traveled on the curves(solidlinesinFigures2,3)outperformedtheenvironment
nearby roadways in the baseline simulation to detour from their change (dashedlines inFigures2, 3)in thesame scenarioswhen
FrontiersinSustainableCities 08 frontiersin.org

| Lietal. |     |     |     |     |     |     |     |     | 10.3389/frsc.2023.1129388 |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- |
FIGURE5
Ratiooftripscooledbyreroutingunderdifferentcoolednetworks.Thex-axisrepresentsthetotallengthofthenetworkselectedtogetenvironment
change.They-axisrepresentstheratiooftripsthatgetheatmitigationbenefitsfromrerouting.Thebluelinerepresentsthestreetcoolingcondition
inscenario1wheretheroadways’temperatureisreducedtothelowest10%.Theredlinerepresentsthestreet’scoolingconditioninscenario2
wheretheroadways’temperatureisreducedtothelowest50%.
|     |     |     |     | 3.6. Heat | exposure |     | mitigation |     | of  | very hot |     |
| --- | --- | --- | --- | --------- | -------- | --- | ---------- | --- | --- | -------- | --- |
thenetworkgotpartiallycooled.Theenvironmentaltemperature
| becamehomogenousinthesameLCZwhenallnon-coolcorridors |     |     |     | trips |     |     |     |     |     |     |     |
| ---------------------------------------------------- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
weretransformedaccordingtothesetting.Atthispoint,onlyatiny
portionoftrips(<1%)wasstillreroutingacrosstheLCZs,butmost The cooling effects were especially effective in reducing the
agentsstoppeddetouringtotheneighborhoodcorridorsandstayed
|     |     |     |     | heat exposure | of  | the hottest | 20% | of trips. | In total, | 20% | of active |
| --- | --- | --- | --- | ------------- | --- | ----------- | --- | --------- | --------- | --- | --------- |
on the shortest distance route (Figure4). This is demonstrated trips were exposed to 66.5–76◦C (151–168◦F) TMRT degrees in
| as the heat exposure | mitigation from | behavior change | became |     |     |     |     |     |     |     |     |
| -------------------- | --------------- | --------------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
thebaselinescenario.Changingthebuiltenvironmentandtravel
closetotheenvironmentchangeinFigures2,3whenallnon-cool behavior reduced the ratio of very hot trips from 20% to 13%
corridorsweretransformed.Halfofthecooledtripsbenefitedfrom (Figure7)inscenario2.Inscenario1,whereallnon-coolcorridors
reroutingwhen80kmofthenetworkshiftstoacoolenvironment 66.5◦C (151◦F).
|     |     |     |     | were converted, |     | all trips’ | exposures | were | below |     |     |
| --- | --- | --- | --- | --------------- | --- | ---------- | --------- | ---- | ----- | --- | --- |
(Figure5). Combiningreroutingwithacooledenvironmentcancreatemore
opportunitiesforhottripstogetcooledunderthehigh-exposure
|               |                     |                 |     | threshold                       | (Figure7). | When       | the      | total length | of        | corridors | cooled   |
| ------------- | ------------------- | --------------- | --- | ------------------------------- | ---------- | ---------- | -------- | ------------ | --------- | --------- | -------- |
|               |                     |                 |     | down is                         | less than  | 80km,      | behavior | change       | in        | scenario  | 2 was    |
| 3.5. Marginal | benefits from       | changing        |     |                                 |            |            |          |              |           |           |          |
|               |                     |                 |     | more effective                  | in         | mitigating | very     | hot          | exposures | than      | just the |
| environment   | and behavior        |                 |     | environmentalchangeinscenario1. |            |            |          |              |           |           |          |
| The marginal  | benefit of changing | the environment |     | and                             |            |            |          |              |           |           |          |
travel behavior, shown in Figure6, is the number of trips 4. Discussions and conclusion
| that cooled down | for every kilometer | of additional | length | of  |     |     |     |     |     |     |     |
| ---------------- | ------------------- | ------------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
roadways transformed. The marginal benefit of the number We developed a methodology to estimate personal heat
of trips that got heat mitigation decreased as more of the exposuremitigationbasedonthecombinedheat-travelmodeling
network was cooled, revealing that limited resources might be forurbantrips.Ourapproachisnovelinthatitcombinesthestate-
prioritized on heavily traveled corridors. Over 1,000 to 10,000 of-the-art mesoscale traffic model, TMRT estimations, urban land
trips got cooled for every kilometer of corridor environment classifications,andland-usedatatoestimatepersonalheatexposure
change when <10km of corridors was converted to a cool forentirepopulations.Personalheatexposureestimates,presented
environment(Figure6).Whenthetotallengthofcooledcorridors astheaverageTMRT atravelerexperiencesduringthetrip,canbe
was above 1,500km, the marginal benefits quickly dropped to used to derive the population-scale cooling benefits when joined
below 100 trips and got cooled per kilometer of corridors’ withtransportationnetworkchangestoalowertemperaturebuilt
environment change. Ultimately, the marginal benefit reached 1 environment,ortravelers’routetolow-temperaturecorridors.
trip/kmwhenallcorridorstransformedintoacoolenvironment. The results confirm prior efforts in personal heat exposure
The diminished marginal benefit curves demonstrated that studies that individual-level heat exposure provides more precise
switching long-distance corridors to cool was not as effective insightsintohowpeopleencounterheatconditions(Kurasetal.,
as changing the most traveled portion of the network to 2017; Hondula et al., 2021). Previously, population-level heat
coolerenvironment. exposure studies focused on thermal temperatures and heat
| FrontiersinSustainableCities |     |     |     | 09  |     |     |     |     |     | frontiersin.org |     |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

| Lietal. |     |     |     |     |     |     | 10.3389/frsc.2023.1129388 |     |
| ------- | --- | --- | --- | --- | --- | --- | ------------------------- | --- |
tripsutilized48%to66%ofnetworksinLCZswithbuildings(LCZ
5,LCZ6,andLCZ8)orplants(LCZD),whichalsohavealower
|     |     |     |     | thermal temperature | than | LCZ 9 and | LCZ F in the | region. The |
| --- | --- | --- | --- | ------------------- | ---- | --------- | ------------ | ----------- |
personalheatexposurestudyalsoopensopportunitiestocompare
|     |     |     |     | the heat   | mitigation benefits | of changing        | the built     | environment |
| --- | --- | --- | --- | ---------- | ------------------- | ------------------ | ------------- | ----------- |
|     |     |     |     | and travel | behavior and        | suggests combining | environmental | with        |
behavioralchangetogetthegreatestheatmitigationbenefits.
Despitethenovelty,thisresearchcontainsseverallimitations.
|     |     |     |     | Due to population      | growth,                | the 2010        | ABM data        | used for the |
| --- | --- | --- | --- | ---------------------- | ---------------------- | --------------- | --------------- | ------------ |
|     |     |     |     | analysis underestimate |                        | the number      | of active trips | and the      |
|     |     |     |     | cooling benefit        | from changing          | behavior        | and built       | environment. |
|     |     |     |     | While the              | ABM estimated          | 3.8 million     | travelers       | in Maricopa  |
|     |     |     |     | County,                | the current population | of              | Maricopa        | County has   |
|     |     |     |     | grown to               | 4.5 million in         | 2022 (United    | States Census   | Bureau,      |
|     |     |     |     | 2022). In              | addition, travel       | behavior shifts | during the      | COVID-19     |
pandemic,suchasmorefrequentactivetripsforpleasure(Matson
|     |     |     |     | et al., 2022), | are not considered | in   | this study.   | The personal |
| --- | --- | --- | --- | -------------- | ------------------ | ---- | ------------- | ------------ |
|     |     |     |     | heat exposure  | in the model       | only | considers the | temperature  |
FIGURE6
Marginalbenefitsofchangingenvironmentandtravelbehavior.The exposure and the heat stress from the environment but
x-axisrepresentsthetotallengthofthenetworkselectedtoget
|     |     |     |     | neglects | individual strain. | The personal | heat | strain results |
| --- | --- | --- | --- | -------- | ------------------ | ------------ | ---- | -------------- |
environmentchange.They-axisrepresentsthetotalnumberoftrips
|     |     |     |     | from the | physiological responses | to  | heat stress (ACGIH, | 2019). |
| --- | --- | --- | --- | -------- | ----------------------- | --- | ------------------- | ------ |
togetheatexposuremitigation.Thebluelinesrepresentthestreet
coolingconditioninscenario1wheretheroadways’temperatureis Acclimation, clothing, gender, age, and health conditions affect
reducedtothelowest10%.Theredlinesrepresentthestreet’s heat strain (Glass et al., 2015; ACGIH, 2019). Considering
coolingconditioninscenario2wheretheroadways’temperatureis
reducedtothelowest50%. such sociological matrices would be essential to understand
|     |     |     |     | people’s resilience | when        | facing heat   | hazards and           | could be |
| --- | --- | --- | --- | ------------------- | ----------- | ------------- | --------------------- | -------- |
|     |     |     |     | incorporated        | into Icarus | in future.    | Mechanistic           | models,  |
|     |     |     |     | which simulate      | human       | physiological | and thermoregulation— |          |
vulnerability indexes (Conlon et al., 2020; Sun et al., 2021), considering individual activities, gender, race/ethnicity, and
regardlessofpeopleandinfrastructureinteractions.Thepersonal age—would be valuable tools for estimating personal heat
heat exposure analysis in this study found that the high thermal strain (Glass et al., 2015). In addition to the limitations of
|                    |                    |               |             | the personal | heat exposure | model, | the built environmental |     |
| ------------------ | ------------------ | ------------- | ----------- | ------------ | ------------- | ------ | ----------------------- | --- |
| temperature lands, | such as the sparse | building (LCZ | 9) and bare |              |               |        |                         |     |
soilorsand(LCZF),arelessvisitedbytravelers.Meanwhile,active change simulations in this study only considered the simulated
FIGURE7
Coolingofthehottest20%trips.Hottesttripsaredefinedasheatexposureover66.5◦C.They-axisrepresentsthepercentageoftripsthathavetheir
heatexposureover66.5◦C.Thebluelinesrepresentthestreet’scoolingconditioninscenario1wheretheroadways’temperatureisreducedtothe
lowest10%.Theredlinesrepresentthestreet’scoolingconditioninscenario2wheretheroadways’temperatureisreducedtothelowest50%.
| FrontiersinSustainableCities |     |     |     | 10  |     |     |     | frontiersin.org |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --------------- |

| Lietal.         |           |        |                |          |        |                     |          |         |     |     |     | 10.3389/frsc.2023.1129388 |     |     |
| --------------- | --------- | ------ | -------------- | -------- | ------ | ------------------- | -------- | ------- | --- | --- | --- | ------------------------- | --- | --- |
| TMRT regardless |           | of the | configurations |          | of     | the infrastructure, |          | Funding |     |     |     |                           |     |     |
| such as         | the ratio | of     | trees,         | pavement | types, | and                 | building |         |     |     |     |                           |     |     |
types. Knowing the street configuration of the infrastructure ThisresearchwasfundedbytheNationalScienceFoundation,
would be useful to estimate the budget for transforming the award numbers 1635490 (A Simulation Platform to Enhance
corridors into a cooler environment and will be included in InfrastructureandCommunityResiliencetoExtremeHeatEvents)
futureresearch.
|     |     |     |     |     |     |     |     | and CMMI-1942805 |     | (CAREER: | Human | Thermal | Exposure | in  |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | -------- | ----- | ------- | -------- | --- |
Active travel has been considered the most sustainable Cities—NovelSensingandModelingtoBuildHeat-Resilience).
| transportation | mode | and | has been | emphasized |     | to shift | travelers |     |     |     |     |     |     |     |
| -------------- | ---- | --- | -------- | ---------- | --- | -------- | --------- | --- | --- | --- | --- | --- | --- | --- |
away from automobiles (Nahlik and Chester, 2014; Matute Acknowledgments
| and Chester, | 2015).    | Cities | with        | heavy     | car | dependence |           | have |     |     |     |     |     |     |
| ------------ | --------- | ------ | ----------- | --------- | --- | ---------- | --------- | ---- | --- | --- | --- | --- | --- | --- |
| significant  | potential | to     | incentivize | residents |     | to shift   | to active |      |     |     |     |     |     |     |
WewouldliketoexpressourgratitudetoMAGforproviding
| trips (Kimball |     | et al., 2013). | However, |     | the extreme |     | heat during |     |     |     |     |     |     |     |
| -------------- | --- | -------------- | -------- | --- | ----------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
theABMdata.
| the summer      | in  | cities, such | as Phoenix, |           | limits people’s |     | willingness |     |     |     |     |     |     |     |
| --------------- | --- | ------------ | ----------- | --------- | --------------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
| to go outdoors. |     | In addition, |             | traveling | in extreme      |     | heat poses  |     |     |     |     |     |     |     |
public health risks (Putnam et al., 2018). Cities in arid and Conflict of interest
| hot areas | have | implemented | heat | exposure | mitigation |     | initiatives |     |     |     |     |     |     |     |
| --------- | ---- | ----------- | ---- | -------- | ---------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
to combat the increasing heat-related illness and discomfort The authors declare that the research was conducted in the
amongresidents(CityofMesa,2014;Phoenix,2021).Ourresults
absenceofanycommercialorfinancialrelationshipsthatcouldbe
can provide critical information for cities to carry out heat construedasapotentialconflictofinterest.
mitigationplans.
|      |              |     |           |     |     |     |     | Publisher’s | note      |     |              |            |       |        |
| ---- | ------------ | --- | --------- | --- | --- | --- | --- | ----------- | --------- | --- | ------------ | ---------- | ----- | ------ |
| Data | availability |     | statement |     |     |     |     |             |           |     |              |            |       |        |
|      |              |     |           |     |     |     |     | All claims  | expressed | in  | this article | are solely | those | of the |
Therawdatasupportingtheconclusionsofthisarticlewillbe authors and do not necessarily represent those of their affiliated
madeavailablebytheauthors,withoutunduereservation. organizations, or those of the publisher, the editors and the
|     |     |     |     |     |     |     |     | reviewers. | Any product | that | may be | evaluated | in this article, | or  |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ----------- | ---- | ------ | --------- | ---------------- | --- |
claimthatmaybemadebyitsmanufacturer,isnotguaranteedor
| Author | contributions |     |     |     |     |     |     |     |     |     |     |     |     |     |
| ------ | ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
endorsedbythepublisher.
| RL,           | MC, AM,      | JV,     | and DH: | conceptualization. |          |        | RL,         | MC,    |            |     |     |     |     |     |
| ------------- | ------------ | ------- | ------- | ------------------ | -------- | ------ | ----------- | ------ | ---------- | --- | --- | --- | --- | --- |
|               |              |         |         |                    |          |        |             | Author | disclaimer |     |     |     |     |     |
| and AM:       | methodology. |         | RL, AM, | IB,                | and MC:  | data   | collection. |        |            |     |     |     |     |     |
| RL: analysis. | RL           | and IB: | writing | of the             | original | draft. | RL,         | MC,    |            |     |     |     |     |     |
AM, JV, DH-C, and DH: writing, reviewing, and editing. Any opinions, findings, and conclusion or recommendations
All authors contributed to the article and approved the expressed in this material are those of the authors and do not
necessarilyreflecttheviewsofthesponsoringorganizations.
submittedversion.
References
ACGIH(2019).TLVsandBEIs:BasedontheDocumentationoftheThresholdLimit City of Mesa (2014). Mesa 2040 General Plan. City of Mesa. Available online
ValuesforChemicalSubstancesandPhysicalAgentsandBiologicalExposureIndices. at: https://www.mesaaz.gov/home/showdocument?id=12298 (accessed November 2,
| Cincinnati,OH:ACGIH. |     |     |     |     |     |     |     | 2022). |     |     |     |     |     |     |
| -------------------- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- |
Aminipouri, M., Knudby, A. J., Krayenhoff, E. S., Zickfeld, K., and Middel, Conlon, K. C., Mallen, E., Gronlund, C. J., Berrocal, V. J., Larsen, L.,
A. (2019). Modelling the impact of increased street tree cover on mean radiant O’neill, M. S., et al. (2020). Mapping human vulnerability to extreme heat:
temperatureacrossVancouver’slocalclimatezones.UrbanFor.UrbanGreen.39,9–17. a critical assessment of heat vulnerability indices created using principal
|     |     |     |     |     |     |     |     | components | analysis. Environ. | Health | Perspect. | 128, | 1–14. doi: | 10.1289/ |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ------------------ | ------ | --------- | ---- | ---------- | -------- |
doi:10.1016/j.ufug.2019.01.016
EHP4030
AZMet(2022).StateWeatherSummary.Availableonlineat:https://azmet.arizona.
deNazelle,A.,Morton,B.J.,Jerrett,M.,andCrawford-Brown,D.(2010).Short
edu/azmet/data/00sum.htm(accessedDecember14,2022).
|     |     |     |     |     |     |     |     | trips: an opportunity | for | reducing | mobile-source | emissions? | Transp. Res. | Part D |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------- | --- | -------- | ------------- | ---------- | ------------ | ------ |
Bhat,T.H.,Farzaneh,H.,andToosty,N.T.(2022).Co-benefitassessmentofactive
Transp.Environ.15,451–457.doi:10.1016/j.trd.2010.04.012
transportationindelhi,estimatingthewillingnesstousenonmotorizedmodeandnear-
|     |     |     |     |     |     |     |     | Eisenman, | D. P., Wilhalme, |     | H., Tseng, | C.-H., Chester, | M., | English, |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ---------------- | --- | ---------- | --------------- | --- | -------- |
roadway-avoidedPM2.5exposure.Int.J.Environ.Res.PublicHealth19,Article22.
doi:10.3390/ijerph192214974 P., Pincetl, S., et al. (2016). Heat death associations with the built
|     |     |     |     |     |     |     |     | environment, | social vulnerability |     | and | their interactions | with | rising |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | -------------------- | --- | --- | ------------------ | ---- | ------ |
Braun,R.A.,andFraser,M.P.(2022).extremeheatimpactsontheviabilityof temperature. Health Place 41, 89–99. doi: 10.1016/j.healthplace.2016.
| alternativetransportationforreducingozonepollution:acasestudyfromMaricopa |     |     |     |     |     |     |     | 08.007 |     |     |     |     |     |     |
| ------------------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- |
County,Arizona.WeatherClimSoc.14,905–917.doi:10.1175/WCAS-D-21-0158.1
Glass,K.,Tait,P.W.,Hanna,E.G.,andDear,K.(2015).Estimatingrisksofheat
Budd,G.M.(2008).Wet-bulb globetemperature (WBGT)—its history andits strainbyageandsex:apopulation-levelsimulationmodel.Int.J.Environ.Res.Public
limitations.J.Sci.Med.Sport11,20–32.doi:10.1016/j.jsams.2007.07.003 Health12,Article5.doi:10.3390/ijerph120505241
Buo, I. N., Sagris, V., Jaagus, J., and Middel, A. (under review). High- Hajat, S., and Kosatky, T. (2010). Heat-related mortality: a review and
resolution thermal exposure and shade maps for cool corridor planning. Sustain. exploration of heterogeneity. J. Epidemiol. Commun. Health 64, 753–760.
CitiesSoc.inpress.
doi:10.1136/jech.2009.087999
| FrontiersinSustainableCities |     |     |     |     |     |     |     | 11  |     |     |     |     | frontiersin.org |     |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

| Lietal. |     |     |     |     |     |     |     |     |     | 10.3389/frsc.2023.1129388 |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- |
Hoehne, C. G., Hondula, D. M., Chester, M. V., Eisenman, D. P., Middel, Nahlik,M.J.,andChester,M.V.(2014).Transit-orientedsmartgrowthcanreduce
A., Fraser, A. M., et al. (2018). Heat exposure during outdoor activities in the life-cycleenvironmentalimpactsandhouseholdcostsinLosAngeles.Transp.Policy
US varies significantly by city, demography, and activity. Health Place 54, 1–10. 35,21–30.doi:10.1016/j.tranpol.2014.05.004
doi:10.1016/j.healthplace.2018.08.014
NOAA(2021).2021ClimateYearinReviewforPhoenix,Yuma,andElCentro.
Hondula,D.M.,Kuras,E.R.,Betzel,S.,Drake,L.,Eneboe,J.,Kaml,M.,etal.(2021). National Weather Service; NOAA’s National Weather Service. Available online
Novelmetricsforrelatingpersonalheatexposuretosocialriskfactorsandoutdoor at:https://www.weather.gov/psr/yearinreview2021(accessedNovember30,2022).
ambienttemperature.Environ.Int.146,106271.doi:10.1016/j.envint.2020.106271
OpenStreetMapContributors(2015).PlanetDumpRetrievedFromhttps://planet.
Höppe, P. (1992). Ein neues Verfahren zur Bestimmung der mittleren osm.org.OpenStreetMap.Availableonlineat:https://www.openstreetmap.org/
| Strahlungstemperatur |     | im Freien | [a new | method to determine | the | mean radiation |      |                        |        |               |      |           |
| -------------------- | --- | --------- | ------ | ------------------- | --- | -------------- | ---- | ---------------------- | ------ | ------------- | ---- | --------- |
|                      |     |           |        |                     |     |                | OSHA | (2015). OSHA Technical | Manual | (OTM)—Section | III: | Chapter 4 |
temperatureoutdoors].WetterUndLeben44,147–151. Occupational Safety and Health Administration. Available online at: https://www.
Kimball, M., Chester, M., Gino, C., and Reyna, J. (2013). Assessing the osha.gov/otm/section-3-health-hazards/chapter-4
potential for reducing life-cycle environmental impacts through transit-oriented ParsonsBrinckerhoff,A.(2010).DesignandDevelopmentPlanfortheMAGCT-
developmentinfillalongexistinglightrailinPhoenix.J.Plan.Educ.Res.33,395–410.
RAMPActivity-BasedModel(ABM).Arizona:MaricopaAssociationofGovernments.
doi:10.1177/0739456X13507485
Perkins-Kirkpatrick,S.E.,andGibson,P.B.(2017).Changesinregionalheatwave
Kuras,E.R.,Richardson,M.B.,Calkins,M.M.,Ebi,K.L.,Hess,J.J.,Kintziger,K.
characteristicsasafunctionofincreasingglobaltemperature.Sci.Rep.7,Article1.
W.,etal.(2017).Opportunitiesandchallengesforpersonalheatexposureresearch.
Environ.HealthPerspect.125,085001.doi:10.1289/EHP556 doi:10.1038/s41598-017-12520-2
Phoenix(2021).ClimateActionPlan.CityofPhoenix.
Li,R.,Chester,M.V.,Hondula,D.M.,Middel,A.,Vanos,J.K.,andWatkins,L.
(2023).Repurposingmesoscaletrafficmodelsforinsightsintotravelerheatexposure. Putnam, H., Hondula, D. M., Urban, A., Berisha, V., Iñiguez, P., and Roach,
Transp.Res.PartDTransp.Environ.114,103548.doi:10.1016/j.trd.2022.103548 M. (2018). It’s not the heat, it’s the vulnerability: attribution of the 2016 spike in
Lindberg,F.,Holmer,B.,andThorsson,S.(2008).SOLWEIG1.0—Modellingspatial heat-associated deaths in Maricopa County, Arizona. Environ. Res. Lett. 13:1–10.
doi:10.1088/1748-9326/aadb44
| variations of | 3D radiant | fluxes | and mean | radiant temperature | in  | complex | urban |     |     |     |     |     |
| ------------- | ---------- | ------ | -------- | ------------------- | --- | ------- | ----- | --- | --- | --- | --- | --- |
settings.Int.J.Biometeorol.52,697–713.doi:10.1007/s00484-008-0162-7 Qin,Y.,andHiller,J.E.(2014).Understandingpavement-surfaceenergybalance
|           |               |     |         |                       |     |              | and its implications | on cool | pavement | development. | Energy Build. | 85, 389–399. |
| --------- | ------------- | --- | ------- | --------------------- | --- | ------------ | -------------------- | ------- | -------- | ------------ | ------------- | ------------ |
| Maizlish, | N., Woodcock, |     | J., Co, | S., Ostro, B., Fanai, | A., | and Fairley, | D.                   |         |          |              |               |              |
doi:10.1016/j.enbuild.2014.09.076
| (2013). Health | cobenefits | and | transportation-related | reductions | in  | greenhouse | gas |     |     |     |     |     |
| -------------- | ---------- | --- | ---------------------- | ---------- | --- | ---------- | --- | --- | --- | --- | --- | --- |
emissions in the San Francisco Bay Area. Am. J. Public Health 103, 703–709. Stewart,I.D.,andOke,T.R.(2012).Localclimatezonesforurbantemperature
doi:10.2105/AJPH.2012.300939 studies.Bull.Am.Meteorol.Soc.93,1879–1900.doi:10.1175/BAMS-D-11-00019.1
MaricopaCountyAssessor’sOffice(2018).MaricopaCountyParcelData.Available Sun,Q.,Macleod,T.,Both,A.,Hurley,J.,Butt,A.,andAmati,M.(2021).Ahuman-
onlineat:https://maps.mcassessor.maricopa.gov/(accessedApril8,2022). centredassessmentframeworktoprioritiseheatmitigationeffortsforactivetravelat
cityscale.Sci.TotalEnviron.763,143033–143033.doi:10.1016/j.scitotenv.2020.143033
| Maricopa | County | Public Health | (2021). | Heat-Associated | Death | in Maricopa |     |     |     |     |     |     |
| -------- | ------ | ------------- | ------- | --------------- | ----- | ----------- | --- | --- | --- | --- | --- | --- |
County,AZ.MaricopaCounty:MaricopaCountyPublicHealth Taleghani, M., Sailor, D., and Ban-Weiss, G. A. (2016). Micrometeorological
|         |              |     |          |               |            |              | simulations     | to predict the impacts | of            | heat mitigation | strategies on | pedestrian  |
| ------- | ------------ | --- | -------- | ------------- | ---------- | ------------ | --------------- | ---------------------- | ------------- | --------------- | ------------- | ----------- |
| Matson, | G., McElroy, | S., | Lee, Y., | and Circella, | G. (2022). | Longitudinal |                 |                        |               |                 |               |             |
|         |              |     |          |               |            |              | thermal comfort | in a Los Angeles       | neighborhood. | Environ.        | Res. Lett.    | 11, 024003. |
analysis of COVID-19 impacts on mobility: an early snapshot of the emerging doi:10.1088/1748-9326/11/2/024003
| changes in | travel | behavior. | Transp. | Res. Rec. 2022, | 03611981221090241. |     |     |     |     |     |     |     |
| ---------- | ------ | --------- | ------- | --------------- | ------------------ | --- | --- | --- | --- | --- | --- | --- |
doi:10.1177/03611981221090241 Tan,Z.,Lau,K.K.L.,andNg,E.(2017).Planningstrategiesforroadsidetree
plantingandoutdoorcomfortenhancementinsubtropicalhigh-densityurbanareas.
| Matute, | J. M., and | Chester, | M. V. | (2015). Cost-effectiveness |     | of reductions | in  |     |     |     |     |     |
| ------- | ---------- | -------- | ----- | -------------------------- | --- | ------------- | --- | --- | --- | --- | --- | --- |
Build.Environ.120,93–109.doi:10.1016/j.buildenv.2017.05.017
greenhousegasemissionsfromHigh-SpeedRailandurbantransportationprojectsin
California.Transp.Res.DTransp.Environ.40,104–113.doi:10.1016/j.trd.2015.08.008 Thornton,P.E.,Thornton,M.M.,andVose,R.S.(2016).Daymet:AnnualTile
SummaryCross-ValidationStatisticsforNorthAmerica,Version3.Availableonline
Middel,A.,AlKhaled,S.,Schneider,F.A.,Hagen,B.,andCoseo,P.(2021).50Grades
ofShade.Bull.Am.Meteorol.Soc.102,E1805–E1820.doi:10.1175/BAMS-D-20-0193.1 at:https://daac.ornl.gov/cgi-bin/dsviewer.pl?ds_id=1348(accessedMarch3,2021).
UnitedStatesCensusBureau(2022).U.S.CensusBureauQuickFacts:Maricopa
| Middel, | A., Chhetri, | N., and | Quay, | R. (2015). Urban | forestry | and cool | roofs: |     |     |     |     |     |
| ------- | ------------ | ------- | ----- | ---------------- | -------- | -------- | ------ | --- | --- | --- | --- | --- |
assessmentofheatmitigationstrategiesinPhoenixresidentialneighborhoods.Urban County, Arizona. Available omline at: https://www.census.gov/quickfacts/
maricopacountyarizona(accessedJanuary31,2023).
For.UrbanGreening14,178–186.doi:10.1016/j.ufug.2014.09.010
Middel,A.,Häb,K.,Brazel,A.J.,Martin,C.A.,andGuhathakurta,S.(2014).Impact Vovsha, P., Freedman, J., Livshits, V., and Sun, W. (2011). Design features
|     |     |     |     |     |     |     | of activity-based | models | in practice | coordinated | travel–regional | activity |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | ------ | ----------- | ----------- | --------------- | -------- |
ofurbanformanddesignonmid-afternoonmicroclimateinPhoenixLocalClimate
|                                                                        |                     |     |       |                             |     |              | modeling platform. | Transp. Res.       | Record | J. Transp. Res.     | 300, 19–27. | doi: 10.3141/ |
| ---------------------------------------------------------------------- | ------------------- | --- | ----- | --------------------------- | --- | ------------ | ------------------ | ------------------ | ------ | ------------------- | ----------- | ------------- |
| Zones.Landsc.UrbanPlan.122,16–28.doi:10.1016/j.landurbplan.2013.11.004 |                     |     |       |                             |     |              | 2254-03            |                    |        |                     |             |               |
| Middel,                                                                | A., and Krayenhoff, |     | E. S. | (2019). Micrometeorological |     | determinants |                    |                    |        |                     |             |               |
|                                                                        |                     |     |       |                             |     |              | Wang, C.,          | Middel, A., Myint, | S. W., | Kaplan, S., Brazel, | A. J., and  | Lukasczyk,    |
of pedestrian thermal exposure during record-breaking heat in Tempe, Arizona: J. (2018). Assessing local climate zones in arid cities: the case of Phoenix,
Introducing the MaRTy observational platform. Sci. Total Environ. 687, 137–151. Arizona and Las Vegas, Nevada. ISPRS J. Photogram. Remote Sens. 141, 59–71.
doi:10.1016/j.scitotenv.2019.06.085
doi:10.1016/j.isprsjprs.2018.04.009
Middel, A., Lukasczyk, J., and Maciejewski, R. (2017). Sky view factors from Yin,S.,Peng,L.L.H.,Feng,N.,Wen,H.,Ling,Z.,Yang,X.,etal.(2022).Spatial-
synthetic fisheye photos for thermal comfort routing—a case study in Phoenix, temporalpatterninthecoolingeffectofalargeurbanforestandthefactorsdrivingit.
Arizona.UrbanPlan.2,19–30.doi:10.17645/up.v2i1.855 Build.Environ.209,108676.doi:10.1016/j.buildenv.2021.108676
| FrontiersinSustainableCities |     |     |     |     |     |     | 12  |     |     |     | frontiersin.org |     |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |
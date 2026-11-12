PERSPECTIVE
published:02May2022
doi:10.3389/fenvs.2022.867434
Urban Climate Informatics: An
Emerging Research Field
Ariane Middel1,2,3*,Negin Nazarian4,5,6, Matthias Demuzere7andBenjamin Bechtel7
1SchoolofArts,MediaandEngineering(AME),ArizonaStateUniversity,Tempe,AZ,UnitedStates,2SchoolofComputingand
AugmentedIntelligence(SCAI),ArizonaStateUniversity,Tempe,AZ,UnitedStates,3UrbanClimateResearchCenter(UCRC),
ArizonaStateUniversity,Tempe,AZ,UnitedStates,4SchoolofBuiltEnvironment,UniversityofNewSouthWales,Sydney,NSW,
Australia,5CityFuturesResearchCentre,UniversityofNewSouthWales,Sydney,NSW,Australia,6ARCCentreofExcellencefor
ClimateExtreme,Sydney,NSW,Australia,7DepartmentofGeography,UrbanClimatologyGroup,Ruhr-UniversityBochum,
Bochum,Germany
The scientific field of urban climatology has long investigated the two-way interactions
between cities and their overlying atmosphere through in-situ observations and climate
simulations at various scales. Novel research directions now emerge through recent
advancements in sensing and communication technologies, algorithms, and data
sources. Coupled with rapid growth in computing power, those advancements augment
traditional urban climate methods and provide unprecedented insights into urban
Editedby: atmospheric states and dynamics. The emerging field introduced and discussed here as
MarcoCasazza,
Urban Climate Informatics (UCI) takes on a multidisciplinary approach to urban climate
UniversityofSalerno,Italy
analysesbysynthesizingtwo established domains: urbanclimate and climate informatics.
Reviewedby:
IrynaDronova, UCI is a rapidly evolving field that takes advantage of four technological trends to answer
UniversityofCalifornia,Berkeley, contemporary climate challenges in cities: advances in sensors, improved digital
UnitedStates
infrastructure (e.g., cloud computing), novel data sources (e.g., crowdsourced or big
LyndonMarkOlaguera,
AteneodeManilaUniversity, data), and leading-edge analytical algorithms and platforms (e.g., machine learning, deep
Philippines
learning). This paper outlines the history and development of UCI, reviews recent
JenniferAnnSalmond,
TheUniversityofAuckland, technological and methodological advances, and highlights various applications that
NewZealand benefit from novel UCI methods and datasets.
*Correspondence:
ArianeMiddel Keywords:urbanclimateinformatics(UCI),researchagenda,noveldatasourcesandsensors,bigdata,artificial
Ariane.middel@asu.edu intelligence
Specialtysection:
Thisarticlewassubmittedto
EnvironmentalInformaticsandRemote 1 INTRODUCTION
Sensing,
From Thermometers to Big Data: The Rise of Urban Climate
asectionofthejournal
FrontiersinEnvironmentalScience Informatics
Received:01February2022 Rapidurbanizationisoneofthedefiningfeaturesofthe21stcenturywithsubstantialglobal
Accepted:13April2022
environmental impact compounded by climate change (Georgescu et al., 2013; Krayenhoff
Published:02May2022
et al., 2018; Masson et al., 2020b; Zhao et al., 2021). In cities, the combined effects of
Citation: populationgrowthandclimaticchangesthreatenurbanlivabilitythroughurbanoverheating
MiddelA,NazarianN,DemuzereMand (Nazarian et al., under review), hazardous air quality (Chapman S. et al., 2017; Broadbent
BechtelB(2022)UrbanClimate
et al., 2020), increased energy consumption, and extreme weather (Willems et al., 2012) (Li
Informatics:AnEmerging
etal.,2020b)withwidespreadhealth,socioeconomic,andecologicalimpacts.Inresponseto
ResearchField.
thesechallenges,numeroussubfieldsofurbanclimatologyhaveevolvedoverthelastcentury
Front.Environ.Sci.10:867434.
doi:10.3389/fenvs.2022.867434 to carefully document, examine, and model urban climate at various scales.
FrontiersinEnvironmentalScience|www.frontiersin.org 1 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
Sensors and observational methods have traditionally been lead to personal exposures to environmental stressors (Kuras
developed to assess built environment impacts on local air etal.,2017;Okokonetal.,2017;NazarianandLee,2021).Lastly,
temperature (Stewart, 2019) and quantify intra- and inter- the risks for people and infrastructure are arguably more
urban variability in the urban canopy layer (Núñez-Peiró important than the geographic extent and magnitude of the
et al., 2021; Potgieter et al., 2021). Early weather and climate hazard for planning and emergency response purposes, thus
observationsweremotivatedbypragmaticneeds,e.g.,tosupport requiring direct access to highly localized information on
agricultureorshipping,whiletheinventionofthethermometer human mobility (Moore and Obradovich, 2020).
and the barometer in the early 17th century enabled systematic
recording of weather conditions. In the late 18th century, the
The Cornerstones of Urban Climate
Societas Meteorologica Palatina established an observational
network of calibrated instruments and an observation protocol Informatics
(“Mannheimer Stunden”), which enabled scientific climatic Urban Climate Informatics (UCI) is an evolving research field
studies. The approach aimed to encourage collaborative data that originates from two established domains: Urban Climate
collection by providing calibrated sensors at no cost (Neves (concernedwithinteractionsbetweenacityandtheatmosphere)
et al., 2017). Although participation was limited to academic and Climate Informatics (research combining climate science
institutions and companies, the philosophy resonates with with approaches from statistics, machine learning, and data
modern crowdsourcing and citizen science projects. Synoptic mining) (Monteleoni et al., 2016). While Climate Informatics
weather analysis required real-time data exchange, which focuses on computational approaches in climate science, UCI
became possible 50years later with the invention of the takesabroader,multidisciplinaryapproach.UCIaimstoexplore
telegraph. The first weather map with data from 22 stations and understand complex urban climate systems and human-
was displayed at the World Exhibition in London in 1851. environment interactions through new technological,
Temperaturemapsbecamewidelyavailablewithadvancesin methodological, and systems thinking approaches. It
thermalremotesensing, whichprovides high-resolution surface embraces more integrated and human-centric methods to
temperature distributions (Voogt and Oke, 2003; Zhan et al., address urban climate challenges that are enabled by novel
2013;Stewartetal.,2021).Inthe20thcentury,advancementsin sensing, non-traditional datasets, crowdsourcing, big data,
aviationpermittedunprecedentedatmospheric3Dobservations, digital infrastructure, advanced analytics, and artificial
and in 1960, the launch of the first weather satellite TIROS intelligence.
(Television and InfraRed Observation Satellite) opened a new Fouremergingtechnologiesandmethodscanbenotedasthe
age of meteorology. cornerstones of UCI (Figure 1). First, recent advancements in
Technological progress has also impacted the field of urban environmental sensing have resulted in lower sensor size and
climatology. While research in the early 20th century power consumption atreduced sensor costs. More importantly,
concentrated on Europe and was mostly descriptive, rapidly improvements in wireless data transmission (using various
increasing computational power in the late 20th and early 21st methods such as Wifi, 5G, and LoRaWAN) and location
century significantly advanced quantitative and systematic awareness of devices have enabled Internet-of-Things (IoT)
scientific approaches in the Anglo-American realm (Mills, sensing, contributing to real-time and ubiquitous data
2014). Numerical and climate modeling at building to regional collection. Second, in addition to environmental datasets that
scales produced urban climate parameters at high spatial and areactivelycollectedbysensors,newurbandatasetsfromvarious
temporal resolution/coverage and facilitated what-if analyses sources emerge. These novel datasets include detailed
(Hamdi et al., 2020). At the same time, model outputs and information on three-dimensional and heterogeneous urban
their availability to the research community increased with configurations as well as incidental and public domain data
computing and storage capacity. that can be extracted from social media or the web. The
Most certainly, big and fine-resolution urban datasets have availability of organic datasets, such as mobility patterns in
rapidly evolved with transmission rates exceeding 0.1 Petabyte cities, further contributed to understanding the population
per day (Reichstein et al., 2019). This trend was driven by exposure and impact of urban climate challenges (Li and
increased availability, accuracy, and resolution of sensors and Wang, 2021). At the same time, a stronger emphasis on
datasetsaswellaschangesindatapolicy.Inremotesensing,for citizen engagement and technology-use in daily activities has
instance, NASA and ESA granted free access to data archives, evolvedoverthelastdecade.Drivenbycommercialtrends(e.g.,
which enabled new techniques such as time series analysis and home automation sensors, smartwatches, wearables) and
multi-sensor data fusion (Wulder et al., 2012). solutions that are non-expert friendly, citizen science data
Despite tremendous technological progress in research, the collection has become mainstream and is implemented in
application of traditional micrometeorological theory to urban education, entertainment, and social activities (Caluwaerts
areas is still limited by the complexity and heterogeneity of the et al., 2021). This contributes to ubiquitous and crowdsourced
built environment (Mills, 2014). Conventional observation data collection beyond the academic community (Irwin, 2018),
methods often fall short in providing fine-resolution spatial further enabling more realistic and human-centric solutions to
and temporal urban data, which highlights the need for denser urban climate challenges. Third, state-of-the-art analytical
observationnetworksandnoveldatasources.Additionally,urban algorithms and computer systems have entered urban climate
climate studies have traditionally ignored “human factors” that analytics, providing an opportunity for more sophisticated data
FrontiersinEnvironmentalScience|www.frontiersin.org 2 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
FIGURE1|ThefourcornerstonesofUrbanClimateInformatics(UCI):AdvancesinSensors(Section2),NovelDataSources(Section2),AdvancesinDigital
Infrastructure(Section3),andAdvancesinAnalyticalAlgorithmsandPlatforms(Section3).IncreasedaccessibilitytofourpillarsenablesawiderangeofUCI
applications(center).
analyses, computational methods, and modeling approaches. dynamics of urban climate and human-environment
Artificial Intelligence (AI, including Machine and Deep interactions at fine temporal and spatial scales; 2) the research
Learning) has been instrumental in characterizing urban areas focus has shifted from an assessment of local atmospheric
into local climate zones or climatic maps (Bechtel and Daneke, conditions in a city vs its rural surroundings (traditional UHI
2012; Xu et al., 2019; Demuzere et al., 2021; Demuzere et al., definition) towards intra-urban hazard distribution and human
2022), which are paramount for observational and modeling thermal exposure assessments; 3) highly accurate, expensive,
efforts in urban climatology. Lastly, the accessibility of digital high-maintenance weather stations and air quality sensors
infrastructures for storage, analytics, and communication of operated by experts are complemented by educational or
results have transformed various approaches, enabling global- operational, lower-cost tools and data that were acquired for
scaleanalysesofurbanclimateparameterssuchassurfaceandair non-urban climate purposes; 4) urban climate research teams
temperatures (Peng et al., 2012; Chakraborty and Lee, 2019; havebecomeinterdisciplinaryspanningawiderangeofexpertise,
Venter et al., 2021). from architects and engineers to urban planners, computer
Collectively, novel data sources, sensors, and computing scientists, and local government representatives, which allows
methods have led to a paradigm shift in urban climate morecomplex, solutions-orientedanalysesfromhealthsciences
analyses, significantly changing “how” we do science and to social justice and equity; and 5) research results are better
expanding research questions directed at the urban communicated to non-experts through new platforms and
atmosphere and its residents. This shift includes moving visualizations (e.g., websites, social media, dashboards) to
beyond the traditional focus on city-atmosphere interactions maximize broader societal impact.
and tackling challenges of the Anthropocene, including climate UCIhasthepotentialtoovercomecurrentgapsandchallenges
change,urbanoverheating,poorairquality,andclimateinjustice. in urban climatology, which include but are not limited to 1) a
Most notably, four trends can be observed: 1) urban climate lack of human processes (e.g., anthropogenic heat, people’s
research has moved towards comprehensive analyses of the movement) in urban modeling; 2) observations that are not
FrontiersinEnvironmentalScience|www.frontiersin.org 3 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
representative of atmospheric processes and human exposures Internet of Everything (IoE), with all-round connectivity,
across space and time (e.g., for long-term climate studies or intelligence, and cognition beyond computers, tablets and
model validation); and 3) limited data availability (e.g., urban smartphones.
canopy parameters, urban morphology) and computing power Advances in sensors and communication methods greatly
forurbanclimatemodeling(Massonetal.,2020a;Gonzálezetal., contribute to observational studies in UCI. Low-cost sensors
2021).Thispaperoutlinesthekeytrendsinthedevelopmentof with seamless data communication allow scientists,
UCI, discussing novel technological and methodological practitioners, and citizens to utilize numerous sensors in a
advances that enable future directions in urban climate variety of urban spaces with different user behaviors. Instead
research. The following sections provide a general overview of of using sparsely-placed outdoor sensors to determine heat,
theUCIfieldaswellasexamplesanddiscussionsofnovelsensing weather, or air quality, fine-grained and multi-parameter IoT
and data sources (Section 2) as well as advancement in data sensornetworkshavebeensuccessfulindepictingthespatialand
processing (Section 3). temporalheterogeneityofenvironmentalqualityineducational,
commercial, and residential buildings and their outdoor
surroundings (Palacios Temprano et al., 2020; Luo et al., 2021;
2 NOVEL SENSORS AND DATA SOURCES Ulpianietal.,2021).Inadditiontocoveringalargerspatialarea
anddetermininghotspotsofenvironmentalstressors(Schneider
OneofthekeycatalystsfortheUCIfieldistheemergenceofnovel etal.,2017),IoTsensornetworkscontributetopredictivemodels
and more expansive datasets resulting from several for weather (Chavan and Momin, 2017), energy consumptions
interconnected developments, most importantly advances in (Cheng et al., 2021) and air pollution exposures (Xiaojun et al.,
sensor solutions, communication technologies, and data 2015;ZhangandWoo,2020);assistindeterminingtheimpactof
acquisition methods. Here, we detail how advancements in surface cover and urban design on microclimate (Pfautsch and
sensors (Section 2.1), ensuing novel acquisition methods Tjoelker, 2020); and further raise citizen awareness on urban
(Section 2.2), and datasets (Section 2.3) have been used to environmental challenges. Lastly, advancement in sensor
understand and address urban climate challenges. solutions and communication methods lead to novel data
acquisition methods in cities.
2.1 Advancement in Sensors and 2.2 Data Acquisition Methods
Communication Technologies As existing sensing technologies improve over time, urban
Advances in environmental sensing have greatly increased the climate science further benefits from emerging data acquisition
availability, resolution, and quality of observational data for techniques. Novel observation methods take advantage of new
urban climate research. In the last decade, a major shift was sensorsanddigitalliteracyofurbanresidents.Observationsrange
seenfromresearch-gradesensorsoperatedbyexpertstolow-cost frommobilesensorsmountedonvariousdevicesandhumansto
devices, e.g., for citizen-scientists. New technologies not only crowdsourcing and volunteered geographic information (VGI),
allowed sensing units to record a more comprehensive set of wherecitizensanddistributedprivatesensorsprovideasourceof
parameters (suchasstandardmeteorology,airquality,UV,and geographic and environmental data (See et al., 2016). These
noise), but also removed limiting factors in continuously methods have long been neglected in atmospheric sciences,
monitoring the built environment, such as power supply mostly due to knowledge gaps and justified concerns in data
(source and consumption) and sensor size. The sensor qualityandstandardization(Mulleretal.,2015).However,these
technology revolution resulted in smaller sensors that could novel data sources are predestined for urban analyses because
easily be mounted to existing structures, required less energy they are typically collected in the most populated places: cities.
(or were sustained through solar panels), and eventually, were
cheaper.Thisprocessissimilarlyseeninsatellite/remotesensing, Mobile Sensing and “Humans as Sensors”
where the emergence of CubeSats has led to miniaturized Traditional urban climate research uses observational datasets
satellites for space research that have high potential to that determine inter- and intra-urban variabilities of climatic
enhance observations for urban climate applications (González parameters.Assensorshavebecomesmaller,wireless,andmore
et al., 2021). power-efficient, it is more feasible to gather such data through
Suchadvancesarefurthercomplementedwithnovelwireless mobilesensing,wheretheprimarygoalisincreasedcoverageat
andubiquitouscommunicationtechnologies,suchasWiFi,3G/ reduced costs. This has led to four measurement categories: 1)
4G/5G, and LoRaWan. While previous data-loggers required a portable weather stations, 2) vehicle-based sensors, 3)
techniciantoconnecttothesensorand(oftenmanually)transfer smartphones, and 4) wearable and nearable devices.
thedataforfurtherprocessing,wirelesscommunicationenables Portable weather stations are moved through urban
automaticandseamlesstransitionsofdatafrommultipledevices environments using garden carts (Middel and Krayenhoff,
toservers.Removingthecommunicationandscalingbarrierhas 2019; Middel et al., 2021), golf carts (Häb et al., 2015), or
ledtotheemergenceofInternet-of-Things(IoT),wherephysical cargo bikes (Heusinkveld et al., 2014; Rajkovich and Larsen,
sensors are connected to digital infrastructure and real-time 2016). Measurement campaigns often utilize research-grade
analytics (Sections 2.1 and 2.2); Web-of-Things (WoT), where weather stations and monitor a comprehensive set of
sensorsandeverydayobjectsarefullyintegratedintotheweb;and parameters, providing valuable spatial data particularly in the
FrontiersinEnvironmentalScience|www.frontiersin.org 4 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
face of extreme heat events. However, mobile sensors lack the and palms, and are also influenced by the device CPU load,
medium-orlong-termtemporalresolutionoffixedsensorsand, interpretationofthedata requiresmorein-depthinvestigations.
more importantly, need post-processing methods to address
prolonged sensor response time in common weather stations Crowdsourcing and Citizen Science
(Häb et al., 2015). Additionally, data outputs of mobile Crowdsourcing, i.e., collection of atmospheric data from non-
measurements are often in time-series format, while the traditional distributed sources, has evolved as a cost-efficient
sensors are non-stationary. The changing atmospheric alternative for monitoring urban climates. While the use of
conditions impact observations that should be corrected crowdsourced data in atmospheric sciences was in its infancy
through time-detrending (Parlow and Foken, 2021). Lastly, halfadecadeago(Mulleretal.,2015),ithasreachedadolescence
mobile sensors are subject to anthropogenic influences such as quickly.Since2015,agrowingbodyofcrowdsourcingliterature
heat from traffic and space heating/cooling equipment. has focused on citizen weather station (CWS) data from
Accordingly, mobile data should be enriched with detailed privately-owned, non-professional, low-cost stations connected
metadata to comprehensively interpret the observations. totheInternet.Earlystudiesfocusedonnetworkairtemperature
Similar to portable weather stations, sensors mounted on (Bell et al., 2015; Chapman L. et al., 2017; Fenner et al., 2017;
vehicles such as buses (Kang et al., 2016; Seidel et al., 2016), Meier et al., 2017), but more recent analyses added other
trashtrucks(deSouzaetal.,2020),andcars(Ferwatietal.,2018) atmospheric parameters including precipitation (De Vos et al.,
havebeenusedtotraversecities.Vehicle-baseddataareproneto 2017;Bardossyetal.,2021),airpressure(deVosetal.,2020),and
thesamechallengesasportableweatherstations.Low-cost(and wind speed (Droste et al., 2020). While the data quality of
therefore less accurate) sensors are frequently deployed due to individual stations remains low, many insights have been
sizeandcommunicationlimits,yettheyallowtoassessbehavioral gained on error sources, quality control, and filtering
patternsandhuman-centricexposuretoenvironmentalstressors algorithms (Meier et al., 2017; Hammerberg et al., 2018;
such as air quality and heat (Fugiglando et al., 2018). Napoly et al., 2018; de Vos et al., 2019; Mandement and
Mobile phones have become an attractive data source for Caumont, 2020; Fenner et al., 2021). This development is
human-scale urban climate information, as there are currently dynamic, and the uncertainty in crowdsourced CWS data
6.64billionsmartphoneusersintheworldtoday.Variousstudies much depends on the parameter of interest and the network
have used phone battery temperature as a proxy for air density,butconfidenceincreasesthatrobustparameterestimates
temperature to map thermal conditions in cities (Overeem can be derived for spatial averages or climatology. Other
et al., 2013; Droste et al., 2017b). Data uncertainty increases crowdsourcing sensors of high interest are cars (Bröring et al.,
withsolarradiationexposure(Cabreraetal.,2021),moreextreme 2015; Bonczak and Kontokosta, 2019) and smartphones, which
weather,andprecipitation,becausethesmartphoneismostlikely havebeenusedtoobserveairpressure(MassandMadaus,2014;
enclosed. Although smartphone data for environmental de Vos et al., 2020) and air temperature (Overeem et al., 2013;
modeling are yet to be validated and scaled beyond academic Droste et al., 2017a), amongst others (see previous section).
assessments, the importance of gathering continuous, real-time Amajordriverofadvancementsincrowdsourcingisthegrowing
feedback from urban dwellers should not be underestimated. numberofapplications.CWShavebeenusedtoanalyzeurbanheat
Assessingurbanclimateimpactrequiresmorein-depthfocuson islands(Meieretal.,2017;Varentsovetal.,2021;Venteretal.,2021),
humans exposed to environmental stressors in cities. hailstorms (Clark et al., 2018), and deep convection (Mandement
Accordingly, smartphone applications collecting data on the and Caumont, 2020); for high-resolution mapping of air
human experience (e.g., thermal comfort vote and noise/ temperature (Venter et al., 2020; Vulova et al., 2020; Zumwald
pollution discomfort) can obtain critical data points to etal.,2021);toderiveboundaryconditionsforurban-climatemodels
augment environmental parameters (Lassen et al., 2021). (Jinetal.,2021);andforoperationalweatherforecasts(Nipenetal.,
Recenturbanclimatestudieshaveusedwearablesandnearable 2020). Furthermore, CWS data have been combined with novel
sensors for data collection. Here, we define wearables as smart datasetsemerginginUCI(Section2.3)suchashigh-resolution3D
devices (e.g., smart watches, sensor patches, smart clothing) that urban models, such that we better understand the role of urban
arewornbyparticipantstoobtainenvironmentalparameters(e.g., designandlandcoveronurbanmicroclimate(Potgieteretal.,2021).
air temperature and humidity) and physiological responses or Sincecrowdsourceddataallownewtypesofanalysesandimprove
behavioral patterns and activities. Nearables refer to (low-cost) the accuracy of short-term forecasts, they have slowly gained
sensors carried by individuals or placed in the immediate acceptance in the climatology community, but concerns about
environment of people. The National Science Experiment in data quality remain. For centuries, climatologists have developed
Singapore(low-costwirelessSENSgdevices(Wilhelmetal.,2016) and advanced standards and protocols to make observations
isprobablythelargestdeploymentsofwearables,with50,000sensors comparable between places and decades; in the future, much of
carriedbystudentsforassessmentofthermalcomfortamongother this rigor must be applied to the quality control and filtering
objectives (Monnot et al., 2016; Happle et al., 2017). Wearable algorithmsofcrowdsourceddata.
sensors have been used to combine all three (environmental,
physiological, and behavioral) factors and have shown promising Unmanned Aerial Vehicles
resultsinpredictingheatstress(Nazarianetal.,2021)andobtaining Observations from unmanned aerial vehicles (UAVs) are atthe
non-obtrusive,real-timefeedback(Jayathissaetal.,2019).Assensors smallest scale of remote sensing for monitoring land surface
arefrequentlymovedbetweenindoorandoutdoorsettings,pocket dynamics. Unmanned aerial systems (UASs) produce high
FrontiersinEnvironmentalScience|www.frontiersin.org 5 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
spatial resolution data, sufficiently detailed to make field-level activatedforuseinclimateanalyses(i.e.,usedtodevelopinsights
decisions, and fill the gap between satellite and in-situ, near- or devise action). While the unprecedented volume of data is
ground observations (Emilien et al., 2021). The genesis of UAS offering exciting opportunities for better understanding and
dates back to 1849 and was, for a long time, driven by military quantifying urban climate challenges, the velocity (rate at
needs(RakhaandGorodetsky,2018).Intheearly1970s,Konrad which the data are generated), veracity (truthfulness, accuracy,
etal.(1970)pioneeredtheuseofUAVsinmeteorologytostudy andqualityofdata),andownership(accessto,possessionof,and
thedynamicsoftheconvectiveprocess,whichrequiresfine-scale responsibilityfordata)createssignificantchallengesfordatause
dataonthetemporalandspatialstructureoftheatmosphere.To in climate research and application. For instance, while data
overcome limitations of available platforms at that time (e.g., policies of authorities have become considerably more open
balloons, towers, and full-sized aircraft), the authors developed over the past decade, data generated by citizens are often
andtestedasmall,radio-controlledaircraftwithmeteorological legally “owned” by private companies, thus their long-term
sensing instrumentation as a versatile measurement platform. availability depends on business interests and success. The
Over the next decades, technical developments facilitated more challenges of data ownership are manifested in access to 3D
frequent uses of UAVs in atmospheric research. For example, urbanmodels,wherethedevelopmentofDataasaService(DaaS)
Leuenbergeretal.(2020)evaluatedtheassimilationofboundary prohibits their dissemination for modeling or observational
layerobservationsgatheredby“Meteodrones”intothenumerical studies. Lastly, new datasets raise novel challenges with respect
weather prediction system at Meteoswiss and found that the to privacy, most seen in human-scale data collection. Here, we
droneobservationsimprovedfogprediction.Chilsonetal.(2019) detailthreenoveldatatypesthathavebeensuccessfullycollected
proposedanautomated3DmesonetbasedonautonomousUAS and used for urban climate analyses and discuss limitations in
stations to observe atmospheric profiles similar to standard research and application.
“mesonets”, which consist of surface-based, in-situ stations.
Although this work is in its infancy, a 3D network could Big Data
significantly enhance our monitoring capacity of Detailed, accurate 3D information on a city’s composition,
environmental variables in the lower atmosphere, improve our configuration, and morphology is key for urban climate
understanding of atmospheric boundary layer processes, and analyses and applications. The wide variety of building types,
improve high-impact numerical weather prediction. Despite architectural features, construction materials, and the
the low cost and resolution advantages, drones still have distribution of vegetation govern the interactions between the
limited use in climatology, because they require additional city and its surrounding atmosphere (Middel et al., 2014; Oke
sensors beyond RGB imagery, and flight durations are short etal.,2017;Chingetal.,2018).Traditionally,3Dcitymodelsand
(Yavaşlı, 2020). urban form parameters have been established using
Yet, UAVs have proven to be useful in an urban climate photogrammetry (processing optical stereo imagery) or high-
context, as shown by Rakha and Gorodetsky (2018). Their resolution satellite images (Masson et al., 2020a). More recent
comprehensive review of thermal drones for energy audits approaches use large point clouds (next section) or procedural
highlights that the increased accessibility, efficiency, and safety modeling (Nishida et al., 2018) to automatically generate
of drones expedites the improvement and retrofitting of aging cityscapes (Ching et al., 2019a). In the advent of big data,
and energy-inefficient building stock and infrastructure. This researchers started to repurpose large datasets that were
finding is corroborated by Bayomi et al. (2021), who collected originally collected for non-urban-climate purposes, such as
thermal drone data to calibrate a building energy model for street level photography. Street View image repositories from
improved performance and to assess building material Google, Baidu, Mapillary, Tencent have increasingly become
degradation, thermal bridging, and insulation failures. In available and been used to characterize the built environment
recent years, UAVs have been increasingly deployed to using machine learning (feature detection and image
measure 3D urban form (Gevaert et al., 2017) and to monitor segmentation) (Keralis et al., 2020). A street canyon
in-situairquality(Kuuluvainenetal.,2018),butlimitationssuch perspective is more human-centric than bird’s eye view
as flight duration, payload capacity, and sensor dimensions, imagery, which is particularly important for human thermal
accuracy, and sensitivity remain (Villa et al., 2016). comfort, health, and behavioral studies (Middel et al., 2019).
Past research has used Street View images to quantify street
2.3 Datasets greenery(Lietal.,2017;Lu,2019),buildingage(Lietal.,2018),
New emerging datasets are key for representing realistic, building floor count (Iannelli and Dell’Acqua, 2017), sidewalks
heterogeneous urban environments while driving insight into andcrosswalks(Haraetal.,2013;Berrieletal.,2017),urbanland
the exposure of urban residents to climate challenges. These use(Zhangetal.,2017),andskyviewfactors(Middeletal.,2018;
datasets are obtained through planned processes gathering Zengetal.,2018;Niceetal.,2020).Streetlevelimageshavealso
information on defined research questions (purposeful data) been used to conduct virtual neighborhood audits to assess
such as LiDAR point clouds, or secondary outcomes of walkability (Yin and Wang, 2016), bikeability (Arellana et al.,
technological processes and platforms used in urban areas 2020),trafficsafety(Mooneyetal.,2016),physicalactivity(Griew
(organic data) such as social media data. The source, etal.,2013),andhumanhealth(Keralisetal.,2020).Lastly,Street
intention, and method of data collection further dominate Viewimageshavebeenlinkedtourbanclimateparameterssuch
whether the dataset is structured, or more importantly, can be assurfacetemperature(Zhangetal.,2019)andairquality(Apte
FrontiersinEnvironmentalScience|www.frontiersin.org 6 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
et al., 2017). While street level imagery offers remote access to (Klingberg et al., 2017), thereby indicating the important
urbanform,design,andfunction,manyprovidershaverecently ecological characteristics of urban vegetation that influence
restricted free image downloads. Other known constraints urban climate through shading and transpiration cooling and
include limited spatial and temporal availability (i.e., the user air quality through air pollutant deposition. The Urban Multi-
doesnothavecontroloverimageacquisitionseason,date,time, scaleEnvironmentalPredictor(UMEP),anurbanclimateservice
andlocation),imagesareusuallytakeninthecenteroftheroad, tool(Lindbergetal.,2018),combinesmodelsandapproachesfor
not on the sidewalk, and they do not provide insight into fine-scale climate simulations. The tool includes modules to
backyards. Yet, with more and more users volunteering derive digital surface models (DSM) and canopy digital surface
geographic information, uploading crowdsourced photography, models (CDSM) from airborne LiDAR and has recently been
andmorecompaniesenteringthemappingmarket,StreetView used in various heat exposure and mitigation studies across the
productswillremainavaluablebigdatasourceforurbanclimates globe (Aminipouri et al., 2019; Kong et al., 2022).
studies. Reviewing the latest advances of LiDAR-based mobile
mapping systems, Wang et al. (2020) identified challenges
LiDAR Point Clouds related to reliable positioning, the need for more sophisticated
Urban areas affect the atmosphere via their built materials, deep-learning architectures to classify point clouds, and AI
distinct surface cover and urban structure. The latter refers to challenges to comprehensively understand semantics of
the3Durbanmorphology,orurbanform,thatdeterminesalbedo complex urban streetscapes. Nevertheless, the authors envision
andaerodynamicroughness,andcontrolsradiativeexchangeand thatpointcloudswillgiverisetoanewcategoryofgeo-bigdata
airflow (Oke et al., 2017). With advances in remote sensing, andwillplayanimportantroleinfuturemonitoring,detection,
LiDAR (Light Detection And Ranging) systems have become a and modeling tasks.
well-established alternative to stereo photogrammetry for
generating digital urban models. Point clouds from airborne, Social Media
mobile, or terrestrial LiDAR yield 3D urban form at DataIntheeraofinformationandcommunicationstechnology,
unprecedented spatial resolution (Yan et al., 2015; Bonczak urban geolocated social media data (SMD) offer new
and Kontokosta, 2019). Wang et al. (2018) reviewed urban opportunities to indirectly measure the impact of hazards on
reconstruction algorithms for point cloud data, evaluated their society, to advance understanding of complex urban dynamics,
performanceinmodelingarchitecturalelements(e.g.,buildings, and to support decision-making for sustainability
roads,bridges,powerlines,trees),andhighlightedthegeneration transformations (Ilieva and McPhearson, 2018; Creutzig et al.,
of 3D city models with multiple levels of detail (LoDs). In this 2019). SMD from Flickr, Twitter, Foursquare, Facebook,
context, CityGML by the Open Geospatial Consortium has Instagram, etc. have the potential to fill important data gaps
emerged as a widely accepted standard for describing the that prevent researchers and practitioners from understanding
representation, storage, and exchange of digital 3D city and human-environment interactions. During the first IPCC Cities
landscape models (Gröger and Plümer, 2012). Higher levels of andClimateScienceConferenceinEdmonton,Canada(Baietal.,
detail require more data storage, and as such, pathways are 2018; Frantzeskaki et al., 2019), SMD indicators of social,
currently explored on how to represent multiple levels of ecological, and infrastructural change were highlighted in a
detail (LoDs) while optimizing storage. This relates to the series of synthesis statements on the role, potential, and
urban-scale space exploration (Lafarge, 2015) and the concept research gaps of nature-based solutions for climate adaptation
of“fit-for-purpose”urbandataasadvertisedbytheWorldUrban and mitigation. Grasso et al. (2017) argue that micro-blogging
Database and Access Portal Tools project (WUDAPT, Ching platformssuchasTwittermaybeusedasadistributednetworkof
etal.,2018,2019;Bechteletal.,2019)thataimstofindanoptimal mobile sensors that react to external events by exchanging
solutionacrossscalesasatradeoffbetweendatacomplexityand messages. They found significant associations between the
model accuracy. daily increase in tweets and extreme temperatures during a
Point clouds have myriad urban climate applications. Urech 2015 summer heat wave in Italy, indicating that the daily
etal.(2020)usedLiDARtoreconstructdigital3Dlandscapesand volume of Twitter messages can indicate local heatwave
devised a framework to generate future landscape scenarios by impacts, improve preparedness measures at the regional and
manipulatingthepointcloud.Thisinformationwassubsequently local level, and thus reduce heat vulnerability. Young et al.
used to inform the Discrete Anisotropic Radiative Transfer (2021) came to a similar conclusion when studying Twitter
(DART) model that estimates the 3D radiative budget of data to detect different scales of response and varying attitudes
urban and natural landscapes, and to assess changes in towardsheat waves in theUnited Kingdom(United Kingdom),
thermal comfort in a neighborhood in Singapore. Dissegna the United States of America (US), and Australia. They
et al. (2019) calculated the leaf area density (LAD) of urban performed a sentiment analysis, i.e., the field of natural
treesfromterrestrialLiDARscanstoquantifythecontributionof language processing that aims to extract the attitude conveyed
vegetationtotheradiativebudgetofacity,whichcanmitigatethe inabodyoftext.TheUnitedKingdomandUShadsimilarlevels
urban heat island (UHI) effect and ultimately contribute to the of positivity during the heatwave, while Australians were more
developmentofclimateresilienturbanspaces.Otherstudiesused negative, with a significant sentiment increase as temperature
airborne LiDAR data to map urban vegetation and LAD in decreased. By quantitatively reviewing 169 studies that use data
Vienna, Austria (Höfle et al., 2012) and Gothenburg, Sweden from social media and social networking sites to better
FrontiersinEnvironmentalScience|www.frontiersin.org 7 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
understand human-environment interactions (Ghermandi and distribution concluding that the resulting maps can
Sinclair, 2019), suggest that SMD offers unprecedented complement and validate traditional urban canopy models.
opportunities in terms of data volume, scale of analysis, and
real-time monitoring. At the same time, challenges remain, 3.2 Digital Infrastructure and Platforms
including the integration of different types of information in Platforms for Big Earth Observation Data
datamatching,thedevelopmentofqualityassuranceprocedures Asdiscussedintheintroduction,manyurbanclimatestudiesrely
andethicalcodes,animprovedintegrationwithexistingmethods, on remotely sensed Earth Observation (EO) data, which has
andtheassuranceoflong-term,free,andeasy-to-accessprovision becomeincreasinglymoreavailable,accurate,andfine-scaled.EO
of public social media data (Ghermandi and Sinclair, 2019). products are frequently used to assess the surface urban heat
island (SUHI), perform land cover classifications, and provide
inputformodelsofurbansurface-atmosphereexchange(Voogt
3 ADVANCEMENTS IN DATA PROCESSING andOke,2003).ManyEOdatasetsaredeliveredonadailybasis,
providingamassiveamountofremotelysenseddatathatplaces
The emergence of new digital infrastructure and analytics usinanageofbigEOdata(Chietal.,2016).Overthelastdecade,
algorithms and platforms is a major driver of UCI. Cloud cutting-edge platforms have been developed to support a new
storage and computing allow bigger data volumes to be stored generation of spatial data infrastructure based on cloud
outsideofthesphereofphysicalstorageandprocesseddirectlyin computing, distributed systems, MapReduce systems, and web
thecloud.Furthermore,novelanalysismethods(e.g.,AIoredge services.ThesesystemsaddresschallengesrelatedtobigEOdata
computing) complement previous advancements and remove management heterogeneity, storage, processing, analytics,
some privacy and security concerns of previous approaches visualization, sharing, and applications (Li et al., 2020c)
that analyzed the impact of urban climate on residents. Importantly, the development of data infrastructure enables
the application of data standards to data layers developed by
3.1 Algorithms diverse stakeholders and addresses challenges regarding data
Climate is increasingly becoming a data problem (Jones, 2017). interoperability and integration. In their review, Gomes et al.
Forexample,thecompressedclimatemodeloutputforthesixth (2020) define “platforms for big EO data management and
CoupledModelIntercomparisonProject(CMIP6)isestimatedat analysis” as computational solutions that provide
18PetaBytes,whichisfivetimesthesizeoftheCMIP5archive functionalities for data management, storage, and access; that
(Balaji et al., 2018). The research field “Climate Informatics” allowprocessingontheserversidewithouthavingtodownload
encourages collaborations between climate scientists and large datasets; and that provide a certain level of data and
machine learning researchers to help bridge the gap between processing abstractions for EO community users and
data and understanding and to accelerate discovery in climate researchers. Seven platforms currently match this definition:
science (Monteleoni et al., 2016; Huntingford et al., 2019). Google Earth Engine (GEE) (Gorelick et al., 2017), Sentinel
Machine Learning (ML) techniques have been used to find Hub (Sinergise, 2018), Open Data Cube (Open Data Cube,
complex patterns and networks in large data, insights that 2021), System for Earth Observation Data Access, Processing
might otherwise depend on expert judgment or physical-based andAnalysisforLandMonitoring(SEPAL,FAO,2021),OpenEO
rules (Jones, 2017). ML also speeds up the development of (Pebesma et al., 2017), the JRC Earth Observation Data and
parameterizations in weather and climate models (or their ProcessingPlatform(JEODPP,Soilleetal.,2018),andpipsCloud
sub-components, e.g., land surface models), either by (Wang L. et al., 2018; Gomes et al., 2020). GEE is probably the
completely replacing physically-based parameterizations by most widely used platform in urban climate studies.
data-driven neural networks or by harnessing ML to calibrate Amanietal.(2020)reviewed450GEE-relatedjournalarticles
or“tune”themanyfreeparametersinvolvedintheirformulation andfound40papersonurbantopics,includingurbanplanning,
(Couvreux et al., 2021; Hourdin et al., 2021; Pal and Sharma, development and extent; urban morphology; and urban
2021).Inurbanclimatestudies,theuseofMLorotherartificial temperature and heat island studies. For example, Cheng et al.
intelligence (AI) techniques such as deep learning has been (2018)andZhangetal.(2020)usedGEEtodevelopglobalmaps
primarily used to derive urban form and land cover from ofmanmadeimperviousareas.LiM.etal.(2020)mappedurban
image datasets. Ma et al. (2019) reviewed 200 remote sensing 3Dbuildingstructure,i.e.,buildingfootprint,height,andvolume,
studiesandfoundthatdeeplearningwaspredominantlyusedin for Europe, the United States, and China using random forest
urban applications. Xu et al. (2019) employed convolutional modelsinGEE.Huangetal.(2018)andDuanetal.(2019)used
neural networks (CNNs) and ground-level images to classify GEEtomapurbangreenspacesandurbanforestsinChinausing
urban areas into climate zones, while Zhou et al. (2021) and LandsatandSentinel-2imagery,respectively.Inaseriesofpapers,
Yooetal.(2019)useddeeplearning,CNN,andrandomforestto Demuzereetal.(2019a,2019b,2020,2021)convertedtheoff-line
mapLCZsfromremotelysensedimages.Deeplearninghasalso single-cityLocalClimateZone(LCZ)mappingstrategy(Stewart
been used to predict air pollution in urban areas using satellite andOke,2012;Bechteletal.,2015)intoaGEE-basedprocedure
data(Leeetal.,2021)andStreetViewimages(Sueletal.,under that allows for the creation of continental-scale LCZ maps,
review). Venter et al. (2020) applied a random forest model to including a web-application (LCZ generator, https://lcz-
Sentinel, Landsat, LiDAR, and crowd-sourced air temperature generator.rub.de/) that makes LCZ mapping fast and easy.
measurements to model hyper-local urban air temperature Bechtel et al. (2019b) assessed the SUHI from MODIS and
FrontiersinEnvironmentalScience|www.frontiersin.org 8 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
LandsatagainstLCZmapsfor50globalcities,andChakraborty research in the past decade has integrated multidisciplinary
andLee(2019)computedtheSUHIfromMODISforover9500 methods and practices complementing the core principles in
urban clusters and examined how vegetation controls atmospheric science. UCI parallels this development,
spatiotemporal SUHI variability. Benz et al. (2017) analyzed embracing various scientific disciplines such as data science,
global shallow groundwater temperatures by processing and geospatial analyses, urban design, health, and policy. A clear
integrating land surface temperatures, evapotranspiration data, paradigm shift can be seen from focusing on city-atmosphere
andsnowcoverinGEE.TheavailabilityofLCZmappinghasalso interactions to tackling grand challenges of the Anthropocene,
enabled a consistent comparison with three-dimensional urban including climate change, urban overheating, poor air quality,
data (Section 2.3) for different cities, providing detailed city- and climate injustice. New advancements enabled by UCI offer
descriptive input parameters for climate models (Lipson et al., unprecedentedopportunitiestounderstandthesegraveproblems
under review). and support a variety of applications.
Big Earth data and related platforms introduced disruptive UCI facilitates the development of adaptation and
changesinEOdatamanagementandanalysis(Sudmannsetal., mitigation strategies for urban climate challenges by
2019). Yet, despite their advancements, challenges remain. For pushing the boundaries of observational networks, model
example,Gomesetal.(2020)reportthatnoneoftheinvestigated resolution, and domain size to yield unprecedented details
platforms offer all ten required EO capabilities presented by on hazard distribution. High resolution 3D city data paired
Camara et al. (2016) and Ariza-Porras et al. (2017). Besides with detailed thermal properties of the urban fabric enable
technical challenges, organizational and political challenges urban climatologists to answer questions about optimal tree
exist that are partly unsolved or not discussed, such as security placement, the amount of available shade, and heat retention
issues (e.g., storing datasets or algorithms on non-proprietary inurbancanyons.Digitaltwins–virtualcitymodelsintegrating
platforms) or increasing costs for developing and maintaining various datasets, real-time sensing, and predictive models of
suchplatforms.TheseissuesleadtothequestionwhetherBigEO underlying atmospheric processes–are on the rise and will
dataplatformswillcontinuetoprovidereliabledataandservices eventually allow analyses of complex city-atmosphere
in the future (Sudmanns et al., 2019). interactions at fine temporal and spatial scales. Although
still in their infancy, Digital Twins have already been used
Cloud Computing tosupportcollaborativeandparticipatoryurbanplanningand
In recent years, cloud computing services have become aid in hyper-local air pollution mitigation (Dembski et al.,
increasingly affordable. Third-party providers such as Amazon 2020).TheCityofZurichusesDigitalTwinstosimulateurban
Web Services (AWS), Microsoft Azure, and Google Cloud host climate, noise, air pollution, and create future scenarios for
and maintain scalable computing infrastructure, i.e., customers decision-making (Schrotter and Hürzeler, 2020).
are only charged for the infrastructure they use. Several recent Computational steering (interactively changing parameters
urban climate studies have used cloud computing for modeling during simulation) has the potential to transform how we
skyviewfactors(Dirksenetal.,2019),torunWRF(Gogaetal., parameterize and run urban climate models. The future of
2018),simulatemicroclimatewithENVI-met(Cranketal.,under urban climate may even be in the cloud! In parallel, as sensing
review),andpredictneighborhoodairpollution(Trisconeetal., capabilities grow, cities will become smarter through sensors
2016).Cloudservicesalsogainpopularityincrowdsourcingand embedded in the urban fabric. These future directions in UCI
IoT applications. For example, Fauzandi et al. (2021) designed researchandapplicationareinstrumentalinachievingthevision
andimplementedalow-costsensorsystemforUHIobservations of climate-sensitive urban design and planning.
using AWS, and Kulkarni et al. (under review) used an AWS In recent years, the focus of urban climate has shifted from
database to store biometeorological observations and people UHIstudiestowardsintra-urbanhazarddistributionandhuman
counts from an IoT device in a public park. Similar to Big EO thermal exposure assessments. Emerging research aims to
dataplatforms,cloudcomputinghaslimitationsrelatedtoserver combine climate analyses with various urban data layers to
availability(e.g.,downtimeduringserviceoutages),security,and achieve more comprehensive vulnerability and inequity
privacy. Cloud computing also offers limited control and analyses. For example, Harlan et al. (2006) investigated heat-
flexibility because the infrastructure is managed by the service related health inequalities related to microclimate considering
provider,nottheurbanclimateresearcher,andisoftentiedtoa socioeconomic status, ethnicity data, and urban form and
specificvendor(theserviceprovider).Despitetheselimitations,it configuration descriptors. Results showed that residents in
isexpectedthatcloudcomputingwillplayamajorroleinUCIas hotter neighborhoods were more vulnerable because of fewer
simulationsbecomemorecomplexanddatasetsincreaseinsize. resourcestocopewithheat.Servadioetal.(2019)analyzedhealth
outcomes and air pollution exposure in Atlanta using various
datalayersandfoundthatareaswithmajorityAfrican-American
4 CONCLUSION AND OUTLOOK populations exhibited significantly higher exposure to poor air
quality. Considering the social dimensions of atmospheric
The field of urban climate has greatly advanced our impacts in neighborhoods allows to further identify “hotspots”
understanding of city-atmosphere interactions since the first withvulnerablepopulationsthatareunproportionallyaffectedby
weather map was created in the mid-19th century. Driven by hazards.Thisisfurtherenabledbynoveldigitalcommunication
sensing and modeling physical phenomena, urban climate platforms (such as public data dashboards) that use simplified
FrontiersinEnvironmentalScience|www.frontiersin.org 9 May2022|Volume10|Article867434

| Middeletal. |     |     |     |     |     |     |     |     |     | UrbanClimateInformatics |     |     |
| ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | --- |
data visualizations as well as easily comprehensible metrics and Citiesareliving,breathingecosystemsthatincludephysical,
indicatorstocommunicatetherelevanceofurbanclimatedatafor socio-economical, and behavioral processes. UCI seeks to
urbandwellers.ThecontributionsofUCItopublicengagement understand and respond to such complex, dynamic human-
not only bridge the communication gap and inform residents environment interactions through novel technological,
about the extent of urban climate challenges, but also enable methodological, and systems thinking approaches, achieving
peopletomakeindividualdecisionsthatcanminimizeexposure more integrated and human-centric assessments of urban
to environmental stressors in cities. Lastly, the emergence of climate challenges in future research and application.
“humansassensors”andcitizenscienceinUCIiskeytonotonly Moving forward, UCI will undoubtedly shape the urban
informurbandwellers,butalsodevisethemosteffectivesolutions climate research agenda for upcoming decades and
for improving human health and wellbeing in the face of positively impact fundamental, applied, and policy-relevant
| increased | climate    | challenges. |            |          |           |          | research. |     |     |     |     |     |
| --------- | ---------- | ----------- | ---------- | -------- | --------- | -------- | --------- | --- | --- | --- | --- | --- |
| Novel     | approaches | always      | entail     | barriers | that need | to be    |           |     |     |     |     |     |
| overcome, | and UCI    | is no       | exception. | With     | respect   | to novel |           |     |     |     |     |     |
sensors and data sources, guidelines and best practices must DATA AVAILABILITY STATEMENT
| be established |     | to guarantee |     | standardized | methods | for |     |     |     |     |     |     |
| -------------- | --- | ------------ | --- | ------------ | ------- | --- | --- | --- | --- | --- | --- | --- |
crowdsourcing, IoT sensing, data curation, processing, storage, Theoriginalcontributionspresentedinthestudyareincludedin
andmetadatadocumentation.Inaddition,long-termavailability the article/Supplementary Material, further inquiries can be
of data must be secured. While public entities have recently directed to the corresponding author.
| adopted more | open  | data          | policies, | citizen-science | generated |     |     |     |     |     |     |     |
| ------------ | ----- | ------------- | --------- | --------------- | --------- | --- | --- | --- | --- | --- | --- | --- |
| data are     | often | legally owned |           | by private      | companies | and |     |     |     |     |     |     |
dependent on short-term business interests. Another emerging AUTHOR CONTRIBUTIONS
concernisdataprivacy,whichneedscarefulconsiderationatthe
design phase of any implementation. AMconceivedtheideaandpresenteditasakeynoteatEGU.All
While big, unprecedented data sets offer exciting authors refined the definition of UCI, reviewed and organized
opportunities to better understand the Earth System, our data literature, developed the UCI figure, and wrote and edited the
final
| collection    | ability    | currently | outweighs | our      | usage and  | analysis | manuscript. |     |     |     |     |     |
| ------------- | ---------- | --------- | --------- | -------- | ---------- | -------- | ----------- | --- | --- | --- | --- | --- |
| capacity. Too | often,     | available | data      | are not  | activated, | leaving  |             |     |     |     |     |     |
| behind unused | potential. |           | Moving    | forward, | the focus  | should   |             |     |     |     |     |     |
FUNDING
| not only   | be on   | new       | data collection |                    | but also | drawing |     |     |     |     |     |     |
| ---------- | ------- | --------- | --------------- | ------------------ | -------- | ------- | --- | --- | --- | --- | --- | --- |
| meaningful | insight | from data | sets            | already available. | Also,    | with    |     |     |     |     |     |     |
inflating raw data, processing chains require higher attention, This research was funded by the National Science Foundation,
highlighting the important role of open-source quality control grant number CMMI-1942805 (CAREER: Human Thermal
packages. Exposure in Cities - Novel Sensing and Modeling to Build
Finally, as human-centric data collection through mobile Heat-Resilience). MD and BB are supported by the ENLIGHT
devices becomes more mainstream, the digital divide must be project, funded by the German Research Foundation (DFG)
|            |       |                  |     |         |             |        | under grant | No. 437467569. | Any | opinions, | findings, | and |
| ---------- | ----- | ---------------- | --- | ------- | ----------- | ------ | ----------- | -------------- | --- | --------- | --------- | --- |
| addressed. | While | smart technology |     | enables | wide-scale, | human- |             |                |     |           |           |     |
centricdatacollection,moreaffluentareaswillhavemoreaccess
|     |     |     |     |     |     |     | conclusions | or recommendations | expressed | in  | this material | are |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ------------------ | --------- | --- | ------------- | --- |
to those technologies, further contributing to urban climate thoseoftheauthorsanddonotnecessarilyreflecttheviewsofthe
| inequity. |     |     |     |     |     |     | sponsoring | organizations. |     |     |     |     |
| --------- | --- | --- | --- | --- | --- | --- | ---------- | -------------- | --- | --- | --- | --- |
REFERENCES Arellana,J.,Saltarín,M.,Larrañaga,A.M.,González,V.I.,andHenao,C.A.(2020).
DevelopinganUrbanBikeabilityIndexforDifferentTypesofCyclistsasaTool
|     |     |     |     |     |     |     | to Prioritise | Bicycle Infrastructure | Investments. | Transp. | Res. Part | A Policy |
| --- | --- | --- | --- | --- | --- | --- | ------------- | ---------------------- | ------------ | ------- | --------- | -------- |
Alvarez-Vanhard,E.,Corpetti,T.,andHouet,T.(2021).UAV&SatelliteSynergies Pract.139,310–334.doi:10.1016/j.tra.2020.07.010
forOpticalRemoteSensingApplications:ALiteratureReview.Sci.RemoteSens. Ariza-Porras,C.,Bravo,G.,Villamizar,M.,Moreno,A.,Castro,H.,Galindo,G.,
3,100019.doi:10.1016/j.srs.2021.100019 etal.(2017).CDCol:AGeoscienceDataCubethatMeetsColombianNeeds.
Amani, M., Ghorbanian, A., Ahmadi, S. A., Kakooei, M., Moghimi, A., Commun. Comput. Inf. Sci. 735, 87–99. doi:10.1007/978-3-319-66562-7_7/
| Mirmazloumi, | S. M., | et al. (2020). | Google | Earth Engine | Cloud Computing |     | FIGURES/3 |     |     |     |     |     |
| ------------ | ------ | -------------- | ------ | ------------ | --------------- | --- | --------- | --- | --- | --- | --- | --- |
PlatformforRemoteSensingBigDataApplications:AComprehensiveReview. Bai,X.,Dawson,R.J.,Ürge-Vorsatz,D.,Delgado,G.C.,SalisuBarau,A.,Dhakal,S.,
IEEEJ.Sel.Top.Appl.EarthObs.RemoteSens.13,5326–5350.doi:10.1109/
etal.(2018).SixResearchPrioritiesforCitiesandClimateChange.Nature555,
23–25.doi:10.1038/d41586-018-02409-z
JSTARS.2020.3021052
Aminipouri,M.,Knudby,A.J., Krayenhoff, E. S.,Zickfeld, K.,andMiddel, A. Balaji, V., Taylor, K. E., Juckes, M., Lawrence, B. N., Durack, P. J.,
(2019).ModellingtheImpactofIncreasedStreetTreeCoveronMeanRadiant Lautenschlager, M., et al. (2018). Requirements for a Global Data
Temperature across Vancouver’s Local Climate Zones. Urban For. Urban Infrastructure in Support of Cmip6. Geosci. Model Dev. 11, 3659–3680.
Green.39,9–17.doi:10.1016/j.ufug.2019.01.016 doi:10.5194/gmd-11-3659-2018
Apte,J.S.,Messier,K.P.,Gani,S.,Brauer,M.,Kirchstetter,T.W.,Lunden,M.M., Bárdossy, A., Seidel, J., and El Hachem, A. (2021). The Use of Personal
etal.(2017).High-ResolutionAirPollutionMappingwithGoogleStreetView Weather Station Observations to Improve Precipitation Estimation and
Cars:ExploitingBigData.Environ.Sci.Technol.51,6999–7008.doi:10.1021/ Interpolation.Hydrol.EarthSyst.Sci.25,583–601.doi:10.5194/HESS-25-
| acs.est.7b00891 |     |     |     |     |     |     | 583-2021 |     |     |     |     |     |
| --------------- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- | --- |
FrontiersinEnvironmentalScience|www.frontiersin.org 10 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
Bayomi,N.,Nagpal,S.,Rakha,T.,andFernandez,J.E.(2021).BuildingEnvelope Chi,M.,Plaza,A.,Benediktsson,J.A.,Sun,Z.,Shen,J.,andZhu,Y.(2016).BigData
ModelingCalibrationUsingAerialThermography.EnergyBuild.233,110648. forRemoteSensing:ChallengesandOpportunities.Proc.IEEE104,2207–2219.
doi:10.1016/j.enbuild.2020.110648 doi:10.1109/JPROC.2016.2598228
Bechtel,B.,Alexander, P.,Böhner,J.,Ching,J.,Conrad,O.,Feddema, J.,etal. Chilson,P.B.,Bell,T.M.,Brewster,K.A.,BrittoHupseldeAzevedo,G.,Carr,F.H.,
(2015).MappingLocalClimateZonesforaWorldwideDatabaseoftheForm Carson, K., et al. (2019). Moving towards a Network of Autonomous UAS
andFunctionofCities.Ijgi4,199–219.doi:10.3390/ijgi4010199 Atmospheric Profiling Stations for Observations in the Earth’s Lower
Bechtel, B., Alexander, P. J., Beck, C., Böhner, J., Brousse, O., Ching, J., et al. Atmosphere: The 3D Mesonet Concept. Sensors 19, 2720. doi:10.3390/
(2019a).GeneratingWUDAPTLevel0Data-CurrentStatusofProductionand s19122720
Evaluation.UrbanClim.27,24–45.doi:10.1016/j.uclim.2018.10.001 Ching,J.,Aliaga,D.,Mills,G.,Masson,V.,See,L.,Neophytou,M.,etal.(2019a).
Bechtel,B.,andDaneke,C.(2012).ClassificationofLocalClimateZonesBasedon PathwayUsingWUDAPT’sDigitalSyntheticCityTooltowardsGenerating
MultipleEarthObservationData.IEEEJ.Sel.Top.Appl.EarthObs.Remote Urban Canopy Parameters for Multi-Scale Urban Atmospheric Modeling.
Sens.5,1191–1202.doi:10.1109/JSTARS.2012.2189873 UrbanClim.30,100459.doi:10.1016/j.uclim.2019.100527
Bechtel,B.,Demuzere,M.,Mills,G.,Zhan,W.,Sismanidis,P.,Small,C.,etal. Ching,J.,Aliaga,D.,Mills,G.,Masson,V.,See,L.,Neophytou,M.,etal.(2019b).
(2019b).SUHIAnalysisUsingLocalClimateZones-AComparisonof50Cities. PathwayUsingWUDAPT’sDigitalSyntheticCityTooltowardsGenerating
UrbanClim.28,100451.doi:10.1016/j.uclim.2019.01.005 Urban Canopy Parameters for Multi-Scale Urban Atmospheric Modeling.
Bell, S., Cornford, D., and Bastin, L. (2015). How Good Are Citizen Weather UrbanClim.28,100459.doi:10.1016/j.uclim.2019.100459
Stations?AddressingaBiasedOpinion.Weather70,75–84.doi:10.1002/wea. Ching, J., Mills, G., Bechtel, B., See, L., Feddema, J., Wang, X., et al. (2018).
2316 WUDAPT: An Urban Weather, Climate, and Environmental Modeling
Benz,S.A.,Bayer,P.,andBlum,P.(2017).GlobalPatternsofShallowGroundwater Infrastructure for the Anthropocene. Bull. Am. Meteorol. Soc. 99,
Temperatures.Environ.Res.Lett.12,034005.doi:10.1088/1748-9326/aa5fb0 1907–1924.doi:10.1175/BAMS-D-16-0236.1
Berriel,R.F.,Rossi,F.S.,deSouza,A.F.,andOliveira-Santos,T.(2017).Automatic Clark,M.R.,Webb,J.D.C.,andKirk,P.J.(2018).Fine-scaleAnalysisofaSevere
Large-ScaleDataAcquisitionviaCrowdsourcingforCrosswalkClassification: HailstormUsingCrowd-SourcedandConventionalObservations.Mater.Apps
ADeepLearningApproach.Comput.Graph.68,32–42.doi:10.1016/j.cag.2017. 25,472–492.doi:10.1002/met.1715
08.004 Couvreux,F.,Hourdin,F.,Williamson,D.,Roehrig,R.,Volodina,V.,Villefranque,
Bonczak,B.,andKontokosta,C.E.(2019).Large-scaleParameterizationof3D N., et al. (2021). Process-Based Climate Model Development Harnessing
BuildingMorphologyinComplexUrbanLandscapesUsingAerialLiDARand MachineLearning:I.ACalibrationToolforParameterizationImprovement.
CityAdministrativeData.Comput.Environ.UrbanSyst.73,126–142.doi:10. J.Adv.Model.EarthSyst.13,e2020MS002217.doi:10.1029/2020MS002217
1016/j.compenvurbsys.2018.09.004 Creutzig,F.,Lohrey,S.,Bai,X.,Baklanov,A.,Dawson,R.,Dhakal,S.,etal.(2019).
Broadbent,A.M.,Krayenhoff,E.S.,andGeorgescu,M.(2020).TheMotleyDrivers UpscalingUrbanDataScienceforGlobalClimateSolutions.Glob.Sustain.2.
ofHeatandColdExposurein21stCenturyUSCities.Proc.Natl.Acad.Sci. doi:10.1017/sus.2018.16
U.S.A.117,21108–21117.doi:10.1073/pnas.2005492117 DeVos,L.,Leijnse,H.,Overeem,A.,andUijlenhoet,R.(2017).ThePotential
Bröring,A.,Remke,A.,Stasch,C.,Autermann,C.,Rieke,M.,andMöllers,J.(2015). of Urban Rainfall Monitoring with Crowdsourced Automatic Weather
enviroCar: A Citizen Science Platform for Analyzing and Mapping Crowd- Stations in Amsterdam. Hydrol. Earth Syst. Sci. 21, 765–777. doi:10.
SourcedCarSensorData.Trans.GIS19,362–376.doi:10.1111/tgis.12155 5194/hess-21-765-2017
Cabrera,A.N.,Droste,A.,Heusinkveld,B.G.,andSteeneveld,G.-J.(2021).The deVos,L.W.,Droste,A.M.,Zander,M.J.,Overeem,A.,Leijnse,H.,Heusinkveld,
Potential of a Smartphone as an Urban Weather Station-An Exploratory B. G., et al. (2020). Hydrometeorological Monitoring Using Opportunistic
Analysis.Front.Environ.Sci.9,344.doi:10.3389/fenvs.2021.673937 SensingNetworksintheAmsterdamMetropolitanArea.Bull.Am.Meteorol.
Caluwaerts,S.,Top,S.,Vergauwen,T.,Wauters,G.,DeRidder,K.,Hamdi,R.,etal. Soc.101,E167–E185.doi:10.1175/BAMS-D-19-0091.1
(2021).EngagingSchoolstoExploreMeteorologicalObservationalGaps.Bull. Dembski,F.,Wössner,U.,Letzgus,M.,Ruddat,M.,andYamu,C.(2020).Urban
Am.Meteorol.Soc.102,E1126–E1132.doi:10.1175/BAMS-D-20-0051.1 DigitalTwinsforSmartCitiesandCitizens:TheCaseStudyofHerrenberg,
Camara,G.,Assis,L.F.,Ribeiro,G.,Ferreira,K.R.,Llapa,E.,Vinhas,L.,etal. Germany.Sustainability202012,2307.doi:10.3390/SU12062307
(20162016). Big Earth Observation Data Analytics. Proc. 5th ACM Demuzere,M.,Bechtel,B.,Middel,A.,andMills,G.(2019a).MappingEuropeinto
SIGSPATIAL Int. Work. Anal. Big Geospatial Data, BigSpatial, 1–6. doi:10. Local Climate Zones. PLoS One 14, e0214474. doi:10.1371/journal.pone.
1145/3006386.3006393 0214474
Chakraborty, T., and Lee, X. (2019). A Simplified Urban-Extent Algorithm to Demuzere,M.,Bechtel,B.,andMills,G.(2019b).GlobalTransferabilityofLocal
Characterize Surface Urban Heat Islands on a Global Scale and Examine ClimateZoneModels.UrbanClim.27,46–63.doi:10.1016/j.uclim.2018.11.001
Vegetation Control on Their Spatiotemporal Variability. Int. J. Appl. Earth Demuzere,M.,Hankey,S.,Mills,G.,Zhang,W.,Lu,T.,andBechtel,B.(2020).
ObservationGeoinformation74,269–280.doi:10.1016/j.jag.2018.09.015 CombiningExpertandCrowd-SourcedTrainingDatatoMapUrbanFormand
Chapman,L.,Bell,C.,andBell,S.(2017a).CantheCrowdsourcingDataParadigm FunctionsfortheContinentalUS.Sci.Data7,1–13.doi:10.1038/s41597-020-
TakeAtmosphericSciencetoaNewLevel?ACaseStudyoftheUrbanHeat 00605-z
IslandofLondonQuantifiedUsingNetatmoWeatherStations.Int.J.Climatol. Demuzere, M., Kittner, J., and Bechtel, B. (2021). LCZ Generator: A Web
37,3597–3605.doi:10.1002/joc.4940 Application to Create Local Climate Zone Maps. Front. Environ. Sci. 9,
Chapman,S.,Watson,J.E.M.,Salazar,A.,Thatcher,M.,andMcAlpine,C.A. 637455.doi:10.3389/fenvs.2021.637455
(2017b). The Impact of Urbanization and Climate Change on Urban Demuzere,M.,Kittner,J.,Martilli,A.,Mills,G.,Moede,C.,Stewart,I.D.,etal.
Temperatures: a Systematic Review. Landsc. Ecol. 32, 1921–1935. doi:10. (2022). A Global Map of Local Climate Zones to Support Earth System
1007/s10980-017-0561-4 Modelling and Urban Scale Environmental Science. Earth Syst. Sci. Data
Chavan,G.,andMomin,B.(20172017).AnIntegratedApproachforWeather Discuss.[Preprint].doi:10.5194/essd-2022-92
ForecastingoverInternetofThings:ABriefReview.Proc.Int.Conf.IoT deSouza,P.,Anjomshoaa,A.,Duarte,F.,Kahn,R.,Kumar,P.,andRatti,C.(2020).
Soc. Mob. Anal. Cloud, I-SMAC, 83–88. doi:10.1109/I-SMAC.2017. AirQualityMonitoringUsingMobileLow-CostSensorsMountedonTrash-
8058291 Trucks:MethodsDevelopmentandLessonsLearned.Sustain.CitiesSoc.60,
Cheng,G.,Yang,C.,Yao,X.,Guo,L.,andHan,J.(2018).WhenDeepLearning 102239.doi:10.1016/j.scs.2020.102239
Meets Metric Learning: Remote Sensing Image Scene Classification via Dirksen,M.,Ronda,R.J.,Theeuwes,N.E.,andPagani,G.A.(2019).SkyView
Learning Discriminative CNNs. IEEE Trans. Geosci. Remote Sens. 56, FactorCalculationsanditsApplicationinUrbanHeatIslandStudies.Urban
2811–2821.doi:10.1109/TGRS.2017.2783902 Clim.30,100498.doi:10.1016/j.uclim.2019.100498
Cheng,Y.L.,Lim,M.H.,andHui,K.H.(2022).ImpactofInternetofThings Dissegna,M.A.,Yin,T.,Wei,S.,Richards,D.,andGrêt-Regamey,A.(2019).3-D
ParadigmtowardsEnergyConsumptionPrediction:ASystematicLiterature ReconstructionofanUrbanLandscapetoAssesstheInfluenceofVegetationin
Review.Sustain.CitiesSoc.78,103624.doi:10.1016/j.scs.2021.103624 theRadiativeBudget.Forests10,700.doi:10.3390/f10080700
FrontiersinEnvironmentalScience|www.frontiersin.org 11 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
Droste, A. M., Heusinkveld, B. G., Fenner, D., and Steeneveld, G. J. (2020). Measure Environmental Supportiveness for Physical Activity. Int. J. Behav.
Assessing the Potential and Application of Crowdsourced Urban Wind Nutr.Phys.Act.10,1–7.doi:10.1186/1479-5868-10-103
Data.QJRMeteorol.Soc.146,2671–2688.doi:10.1002/qj.3811 Gröger,G.,andPlümer,L.(2012).CityGML-InteroperableSemantic3DCity
Droste,A.M.,Pape,J.J.,Overeem,A.,Leijnse,H.,Steeneveld,G.J.,VanDelden,A. Models. ISPRS J. Photogrammetry Remote Sens. 71, 12–33. doi:10.1016/j.
J.,etal.(2017a).CrowdsourcingUrbanAirTemperaturesthroughSmartphone isprsjprs.2012.04.004
Battery Temperatures in São Paulo, Brazil. J. Atmos. Ocean. Technol. 34, Hab,K.,Middel,A.,Ruddell,B.L.,andHagen,H.(2015).TraVis-AVisualization
1853–1866.doi:10.1175/JTECH-D-16-0150.1 FrameworkforMobileTransectDataSetsinanUrbanMicroclimateContext.
Droste,A.M.,Pape,J.J.,Overeem,A.,Leijnse,H.,Steeneveld,G.J.,VanDelden,A. IEEEPac.Vis.Symp.2015,167–174.doi:10.1109/PACIFICVIS.2015.7156374
J.,etal.(2017b).CrowdsourcingUrbanAirTemperaturesthroughSmartphone Häb,K.,Ruddell,B.L.,andMiddel,A.(2015).SensorLagCorrectionforMobile
Battery Temperatures in São Paulo, Brazil. J. Atmos. Ocean. Technol. 34, UrbanMicroclimateMeasurements.UrbanClim.14,622–635.doi:10.1016/j.
1853–1866.doi:10.1175/JTECH-D-16-0150.1 uclim.2015.10.003
Duan,Q.,Tan,M.,Guo,Y.,Wang,X.,andXin,L.(2019).Understandingthe Hamdi,R.,Kusaka,H.,Doan,Q.-V.,Cai,P.,He,H.,Luo,G.,etal.(2020).TheState-
SpatialDistributionofUrbanForestsinChinaUsingSentinel-2Imageswith Of-The-ArtofUrbanClimateChangeModelingandObservations.EarthSyst.
GoogleEarthEngine.Forests10,729.doi:10.3390/f10090729 Environ.4,631–646.doi:10.1007/s41748-020-00193-3
Fauzandi,F.I.,Retnowati,Y.,Tamba,J.D.,Husni,E.M.,Yusuf,R.,andYahya,B. Hammerberg,K.,Brousse,O.,Martilli,A.,andMahdavi,A.(2018).Implicationsof
N.(2021).“DesignandImplementationofLowCostIoTSensorSystemfor Employing Detailed Urban Canopy Parameters for Mesoscale Climate
UrbanHeatIslandObservation,”inDesignandImplementationofLowCostIoT Modelling: a Comparison between WUDAPT and GIS Databases over
SensorSystemforUrbanHeatIslandObservation,1–6.doi:10.1109/iceei52609. Vienna,Austria.Int.J.Climatol.38,e1241–e1257.doi:10.1002/joc.5447
2021.9611099 Happle,G.,Wilhelm,E.,Fonseca,J.A.,andSchlueter,A.(2017).DeterminingAir-
Fenner, D., Bechtel, B., Demuzere, M., Kittner, J., and Meier, F. (2021). ConditioningUsagePatternsinSingaporefromDistributed,PortableSensors.
CrowdQC+-A Quality-Control for Crowdsourced Air-Temperature EnergyProcedia122,313–318.doi:10.1016/j.egypro.2017.07.328
Observations Enabling World-wide Urban Climate Applications. Front. Hara,K.,Le,V.,andFroehlich,J.(2013).CombiningCrowdsourcingandGoogle
Environ.Sci.9,553.doi:10.3389/fenvs.2021.720747 StreetViewtoIdentifyStreet-LevelAccessibilityProblems.Conf.Hum.Factors
Fenner,D.,Meier,F.,Bechtel,B.,Otto,M.,andScherer,D.(2017).IntraandInter Comput.Syst.-Proc.,631–640.doi:10.1145/2470654.2470744
’local Climate Zone’ Variability of Air Temperature as Observed by Harlan,S.L.,Brazel,A.J.,Prashad,L.,Stefanov,W.L.,andLarsen,L.(2006).
Crowdsourced Citizen Weather Stations in Berlin, Germany. metz 26, NeighborhoodMicroclimatesandVulnerabilitytoHeatStress.Soc.Sci.Med.
525–547.doi:10.1127/metz/2017/0861 63,2847–2863.doi:10.1016/j.socscimed.2006.07.030
Ferwati,S.,Skelhorn,C.,Shandas,V.,Voelkel,J.,Shawish,A.,andGhanim,M. Heusinkveld,B.G.,Steeneveld,G.J.,VanHove,L.W.A.,Jacobs,C.M.J.,and
(2018).AnalysisofUrbanHeatinaCorridorEnvironment-theCaseofDoha, Holtslag,A.A.M.(2014).SpatialVariabilityoftheRotterdamUrbanHeat
Qatar.UrbanClim.24,692–702.doi:10.1016/j.uclim.2017.08.008 IslandasInfluencedbyUrbanLandUse.J.Geophys.Res.Atmos.119,677–692.
Frantzeskaki, N., McPhearson, T., Collier, M. J., Kendal, D., Bulkeley, H., doi:10.1002/2012JD019399
Dumitru, A., et al. (2019). Nature-based Solutions for Urban Climate Höfle, B., Hollaus, M., and Hagenauer, J. (2012). Urban Vegetation Detection
Change Adaptation: Linking Science, Policy, and Practice Communities Using Radiometrically Calibrated Small-Footprint Full-Waveform Airborne
forEvidence-BasedDecision-Making.Bioscience69,455–466.doi:10.1093/ LiDARData.ISPRSJ.PhotogrammetryRemoteSens.67,134–147.doi:10.1016/j.
biosci/biz042 isprsjprs.2011.12.003
Fugiglando,U.,Santucci,D.,Bojic,I.,Santi,P.,Cheung,T.C.T.,Schiavon,S.,etal. Hourdin,F.,Williamson,D.,Rio,C.,Couvreux,F.,Roehrig,R.,Villefranque,N.,
(2018). “Developing Personal Thermal Comfort Models for the Control of etal.(2021).Process-BasedClimateModelDevelopmentHarnessingMachine
HVACinCarsUsingFieldData,”inProceedingsof10thWindsorConference: Learning:II.ModelCalibrationfromSingleColumntoGlobal.J.Adv.Model.
Rethinking Comfort, 442–450. Available at: https://escholarship.org/uc/item/ EarthSyst.13,e2020MS002225.doi:10.1029/2020MS002225
7vj0s2ht(AccessedJanuary30,2022). Huang,C.,Yang,J.,andJiang,P.(2018).AssessingImpactsofUrbanFormon
Georgescu,M.,Moustaoui,M.,Mahalov,A.,andDudhia,J.(2013).Summer-time LandscapeStructureofUrbanGreenSpacesinChinaUsingLandsatImages
ClimateImpactsofProjectedMegapolitanExpansioninArizona.Nat.Clim. BasedonGoogleEarthEngine.RemoteSens.10,1569.doi:10.3390/rs10101569
Change3,37–41.doi:10.1038/nclimate1656 Huntingford,C.,Jeffers,E.S.,Bonsall,M.B.,Christensen,H.M.,Lees,T.,and
Gevaert, C. M., Persello, C., Sliuzas, R., and Vosselman, G. (2017). Informal Yang,H.(2019).MachineLearningandArtificialIntelligencetoAidClimate
SettlementClassificationUsingPoint-CloudandImage-BasedFeaturesfrom ChangeResearchandPreparedness.Environ.Res.Lett.14,124007.doi:10.1088/
UAVData.ISPRSJ.PhotogrammetryRemoteSens.125,225–236.doi:10.1016/j. 1748-9326/ab4e55
isprsjprs.2017.01.017 Iannelli, G., andDell’Acqua, F.(2017).Extensive Exposure Mappingin Urban
Ghermandi,A.,andSinclair,M.(2019).PassiveCrowdsourcingofSocialMediain Areas through Deep Analysis of Street-Level Pictures for Floor Count
EnvironmentalResearch:ASystematicMap.Glob.Environ.Change55,36–47. Determination.UrbanSci.1,16.doi:10.3390/urbansci1020016
doi:10.1016/J.GLOENVCHA.2019.02.003 Ilieva, R. T., and McPhearson, T. (2018). Social-media Data for Urban
Goga,K.,Parodi,A.,Ruiu,P.,andTerzo,O.(2018).PerformanceAnalysisofWRF Sustainability.Nat.Sustain.1,553–565.doi:10.1038/s41893-018-0153-6
SimulationsinaPublicCloudandHPCEnvironment.Adv.Intell.Syst.Comput. Irwin,A.(2018).NoPhDsNeeded:HowCitizenScienceIsTransformingResearch.
611,384–396.doi:10.1007/978-3-319-61566-0_35 Nature562,480–482.doi:10.1038/d41586-018-07106-5
Gomes,V.,Queiroz,G.,andFerreira,K.(2020).AnOverviewofPlatformsforBig Jayathissa,P.,Quintana,M.,Sood,T.,Nazarian,N.,andMiller,C.(2019).IsYour
Earth Observation Data Management and Analysis. Remote Sens. 12, 1253. Clock-FaceCozie?ASmartwatchMethodologyfortheIn-SituCollectionof
doi:10.3390/RS12081253 OccupantComfortData.J.Phys.Conf.Ser.1343,012145.doi:10.1088/1742-
González, J. E., Ramamurthy, P., Bornstein, R. D., Chen, F., Bou-Zeid, E. R., 6596/1343/1/012145
Ghandehari, M., et al. (2021). Urban Climate and Resiliency: A Synthesis Jin,L.,Schubert,S.,Fenner,D.,Meier,F.,andSchneider,C.(2021).Integrationofa
ReportofStateoftheArtandFutureResearchDirections.UrbanClim.38, Building Energy Model in an Urban Climate Model and its Application.
100858.doi:10.1016/J.UCLIM.2021.100858 Boundary-LayerMeteorol.178,249–281.doi:10.1007/s10546-020-00569-y
Gorelick,N.,Hancher,M.,Dixon,M.,Ilyushchenko,S.,Thau,D.,andMoore,R. Jones, N. (2017). How Machine Learning Could Help to Improve Climate
(2017).GoogleEarthEngine:Planetary-ScaleGeospatialAnalysisforEveryone. Forecasts.Nature548,379.doi:10.1038/548379a
RemoteSens.Environ.202,18–27.doi:10.1016/j.rse.2017.06.031 Kang,L.,Poslad,S.,Wang,W.,Li,X.,Zhang,Y.,andWang,C.(20162016).A
Grasso, V., Crisci, A., Morabito, M., Nesi, P., and Pantaleo, G. (2017). Public PublicTransportBusasaFlexibleMobileSmartEnvironmentSensingPlatform
CrowdsensingofHeatWavesbySocialMediaData.Adv.Sci.Res.14,217–226. forIoT.Proc.-12thInt.Conf.Intell.Environ.IE,1–8.doi:10.1109/IE.2016.10
doi:10.5194/asr-14-217-2017 Keralis,J.M.,Javanmardi,M.,Khanna,S.,Dwivedi,P.,Huang,D.,Tasdizen,T.,
Griew, P., Hillsdon, M., Foster, C., Coombes, E., Jones, A., and Wilkinson, P. et al. (2020). Health and the Built Environment in United States Cities:
(2013).DevelopingandTestingaStreetAuditToolUsingGoogleStreetViewto MeasuringAssociationsUsingGoogleStreetView-DerivedIndicatorsofthe
FrontiersinEnvironmentalScience|www.frontiersin.org 12 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
Built Environment. BMC Public Health 20, 1–10. doi:10.1186/s12889-020- Prediction? Bull. Am. Meteorol. Soc. 95, 1343–1349. doi:10.1175/BAMS-D-
8300-1 13-00188.1
Klingberg,J.,Konarska,J.,Lindberg,F.,Johansson,L.,andThorsson,S.(2017). Masson,V.,Heldens,W.,Bocher,E.,Bonhomme,M.,Bucher,B.,Burmeister,C.,
MappingLeafAreaofUrbanGreeneryUsingAerialLiDARandGround-Based etal.(2020a).City-descriptiveInputDataforUrbanClimateModels:Model
MeasurementsinGothenburg,Sweden.UrbanFor.UrbanGreen.26,31–40. Requirements,DataSourcesandChallenges.UrbanClim.31,100536.doi:10.
doi:10.1016/j.ufug.2017.05.011 1016/j.uclim.2019.100536
Konrad,T.G.,Hill,M.L.,Rowland,J.R.,andMeyer,J.H.(1970).ASmall,Radio- Masson,V.,Lemonsu,A.,Hidalgo,J.,andVoogt,J.(2020b).UrbanClimatesand
ControlledAircraftasAPlatformforMeteorlogicalSensors.Apl.Tech.Dig., Climate Change. Annu. Rev. Environ. Resour. 45, 411–444. doi:10.1146/
11–19. annurev-environ-012320-083623
Krayenhoff,E.S.,Moustaoui,M.,Broadbent,A.M.,Gupta,V.,andGeorgescu,M. Meier, F., Fenner, D., Grassmann, T., Otto, M., and Scherer, D. (2017).
(2018).DiurnalInteractionbetweenUrbanExpansion,ClimateChangeand Crowdsourcing Air Temperature from Citizen Weather Stations for Urban
AdaptationinUSCities.Nat.Clim.Change8,1097–1103.doi:10.1038/s41558- ClimateResearch.UrbanClim.19,170–191.doi:10.1016/j.uclim.2017.01.006
018-0320-9 Middel,A.,AlKhaled,S.,Schneider,F.A.,Hagen,B.,andCoseo,P.(2021).50
Kuras,E.R.,Richardson,M.B.,Calkins,M.M.,Ebi,K.L.,Hess,J.J.,Kintziger,K. GradesofShade.Bull.Am.Meteorol.Soc.,1–35.doi:10.1175/bams-d-20-0193.1
W.,etal.(2017).OpportunitiesandChallengesforPersonalHeatExposure Middel, A., Häb, K.,Brazel, A.J., Martin, C.A., and Guhathakurta,S. (2014).
Research.Environ.HealthPerspect.125,085001.doi:10.1289/EHP556 ImpactofUrbanFormandDesignonMid-afternoonMicroclimateinPhoenix
Kuuluvainen,H.,Poikkimäki,M.,Järvinen,A.,Kuula,J.,Irjala,M.,DalMaso,M., Local Climate Zones. Landsc. Urban Plan. 122, 16–28. doi:10.1016/j.
etal.(2018).VerticalProfilesofLungDepositedSurfaceAreaConcentrationof landurbplan.2013.11.004
ParticulateMatterMeasuredwithaDroneinaStreetCanyon.Environ.Pollut. Middel,A.,andKrayenhoff,E.S.(2019).MicrometeorologicalDeterminantsof
241,96–105.doi:10.1016/j.envpol.2018.04.100 Pedestrian Thermal Exposure during Record-Breaking Heat in Tempe,
Lafarge, F. (2015). “Some New Research Directions to Explore in Urban Arizona:IntroducingtheMaRTyObservationalPlatform.Sci.TotalEnviron.
Reconstruction,” 2015 Joint Urban Remote Sensing Event (JURSE), 1–4. 687,137–151.doi:10.1016/j.scitotenv.2019.06.085
doi:10.1109/JURSE.2015.7120488 Middel,A.,Lukasczyk,J.,Maciejewski,R.,Demuzere,M.,andRoth,M.(2018).Sky
Lassen,N.,Josefsen,T.,andGoia,F.(2021).DesignandIn-FieldTestingofaMulti- ViewFactorFootprintsforUrbanClimateModeling.UrbanClim.25,120–134.
LevelSystemforContinuousSubjectiveOccupantFeedbackonIndoorClimate. doi:10.1016/j.uclim.2018.05.004
Build.Environ.189,107535.doi:10.1016/j.buildenv.2020.107535 Middel,A.,Lukasczyk,J.,Zakrzewski,S.,Arnold,M.,andMaciejewski,R.(2019).
Lee,A.,Jeong,S.,Joo,J.,Park,C.-R.,Kim,J.,andKim,S.(2021).PotentialRoleof UrbanFormandCompositionofStreetCanyons:AHuman-CentricBigData
UrbanForestinRemovingPM2.5:ACaseStudyinSeoulbyDeepLearning andDeepLearningApproach.Landsc.UrbanPlan.183,122–132.doi:10.1016/j.
withSatelliteData.UrbanClim.36,100795.doi:10.1016/j.uclim.2021.100795 landurbplan.2018.12.001
Leuenberger,D.,Haefele,A.,Omanovic,N.,Fengler,M.,Martucci,G.,Calpini,B., Mills,G.(2014).UrbanClimatology:History,StatusandProspects.UrbanClim.
etal.(2020).ImprovingHigh-ImpactNumericalWeatherPredictionwithLidar 10,479–489.doi:10.1016/j.uclim.2014.06.004
andDroneObservations.Bull.Am.Meteorol.Soc.101,E1036–E1051.doi:10. Monnot,B.,Wilhelm,E.,Piliouras,G.,Zhou,Y.,Dahlmeier,D.,Lu,H.Y.,etal.
1175/BAMS-D-19-0119.1 (2016). Inferring Activities and Optimal Trips: Lessons from Singapore’s
Li, M., Koks, E., Taubenböck, H., and van Vliet, J. (2020a). Continental-scale National Science Experiment. Adv. Intell. Syst. Comput. 426, 247–264.
MappingandAnalysisof3DBuildingStructure.RemoteSens.Environ.245, doi:10.1007/978-3-319-29643-2_19
111859.doi:10.1016/j.rse.2020.111859 Monteleoni,C.,Schmidt,G.A.,Alexander,F.,Niculescu-Mizil,A.,Steinhaeuser,
Li,X.,Ratti,C.,andSeiferling,I.(2017).MappingUrbanLandscapesalongStreets K.,Tippett,M.,etal.(2016).ClimateInformatics.Comput.Intell.DataAnal.
UsingGoogleStreetView.Lect.NotesGeoinf.Cartogr.,341–356.doi:10.1007/ Sustain.Dev.,81–126.doi:10.1201/b14799-8
978-3-319-57336-6_24 Mooney,S.J.,DiMaggio,C.J.,Lovasi,G.S.,Neckerman,K.M.,Bader,M.D.M.,
Li,X.,andWang,G.(2021).ExaminingRunner’sOutdoorHeatExposureUsing Teitler,J.O.,etal.(2016).UseofGoogleStreetViewtoAssessEnvironmental
UrbanMicroclimateModelingandGPSTrajectoryMining.Comput.Environ. ContributionstoPedestrianInjury.Am.J.PublicHealth106,462–469.doi:10.
UrbanSyst.89,101678.doi:10.1016/j.compenvurbsys.2021.101678 2105/AJPH.2015.302978
Li, Y., Chen, Y., Rajabifard, A., Khoshelham, K., and Aleksandrov, M. (2018). Moore,F.C.,andObradovich,N.(2020).UsingRemarkabilitytoDefineCoastal
EstimatingBuildingAgefromGoogleStreetViewImagesUsingDeepLearning. FloodingThresholds.Nat.Commun.11,1–8.doi:10.1038/s41467-019-13935-3
LeibnizInt.Proc.Inf.LIPIcs114.doi:10.4230/LIPIcs.GIScience.2018.40 Muller,C.L.,Chapman,L.,Johnston,S.,Kidd,C.,Illingworth,S.,Foody,G.,etal.
Li,Y.,Fowler,H.J.,Argüeso,D.,Blenkinsop,S.,Evans,J.P.,Lenderink,G.,etal. (2015).CrowdsourcingforClimateandAtmosphericSciences:CurrentStatus
(2020b).StrongIntensificationofHourlyRainfallExtremesbyUrbanization. andFuturePotential.Int.J.Climatol.35,3185–3203.doi:10.1002/joc.4210
Geophys.Res.Lett.47,e2020GL088758.doi:10.1029/2020GL088758 Napoly,A.,Grassmann,T.,Meier,F.,andFenner,D.(2018).Developmentand
Li,Y.,Yu,M.,Xu,M.,Yang,J.,Sha,D.,Liu,Q.,etal.(2020c).BigDataandCloud Application of a Statistically-Based Quality Control for Crowdsourced Air
Computing.Man.Digit.Earth,325–355.doi:10.1007/978-981-32-9915-3_9 TemperatureData.Front.EarthSci.6,118.doi:10.3389/feart.2018.00118
Lindberg,F.,Grimmond,C.S.B.,Gabey,A.,Huang,B.,Kent,C.W.,Sun,T.,etal. Nazarian,N.,andLee,J.K.(2021).PersonalAssessmentofUrbanHeatExposure:
(2018).UrbanMulti-ScaleEnvironmentalPredictor(UMEP):AnIntegrated ASystematicReview.Environ.Res.Lett.16,033005.doi:10.1088/1748-9326/
ToolforCity-BasedClimateServices.Environ.Model.Softw.99,70–87.doi:10. abd350
1016/j.envsoft.2017.09.020 Nazarian,N.,Liu,S.,Kohler,M.,Lee,J.K.W.,Miller,C.,Chow,W.T.L.,etal.
Lu,Y.(2019).UsingGoogleStreetViewtoInvestigatetheAssociationbetween (2021). Project Coolbit: Can Your Watch Predict Heat Stress and Thermal
StreetGreeneryandPhysicalActivity.Landsc.UrbanPlan.191,103435.doi:10. Comfort Sensation? Environ. Res. Lett. 16, 034031. doi:10.1088/1748-9326/
1016/j.landurbplan.2018.08.029 abd130
Luo, M., Hong, Y., and Pantelic, J. (2021). Determining Building Natural Nice,K.A.,Wijnands,J.S.,Middel,A.,Wang,J.,Qiu,Y.,Zhao,N.,etal.(2020).Sky
VentilationPotentialviaIoT-BasedAirQualitySensors.Front.Environ.Sci. Pixel Detection in Outdoor Imagery Using an Adaptive Algorithm and
9,144.doi:10.3389/fenvs.2021.634570 MachineLearning.UrbanClim.31,100572.doi:10.1016/j.uclim.2019.100572
Ma,K.,Tang,X.,Ren,Y.,andWang,Y.(2019).ResearchontheSpatialPattern Nipen, T. N., Seierstad, I. A., Lussana, C., Kristiansen, J., and Hov,Ø. (2020).
CharacteristicsoftheTaihuLake“DockVillage”BasedonMicroclimate:A AdoptingCitizenObservationsinOperationalWeatherPrediction.Bull.Am.
CaseStudyofTangliVillage.Sustainability11,368.doi:10.3390/su11020368 Meteorol.Soc.101,E43–E57.doi:10.1175/BAMS-D-18-0237.1
Mandement, M., and Caumont, O. (2020). Contribution of Personal Weather Nishida,G.,Bousseau, A.,andAliaga,D.G.(2018).ProceduralModelingofa
StationstotheObservationofDeep-ConvectionFeaturesNeartheGround. BuildingfromaSingleImage.Comput.Graph.Forum37,415–429.doi:10.1111/
Nat.HazardsEarthSyst.Sci.20,299–322.doi:10.5194/nhess-20-299-2020 cgf.13372
Mass, C. F., and Madaus, L. E. (2014). Surface Pressure Observations from Núñez-Peiró,M.,Sánchez-GuevaraSánchez,C.,andNeilaGonzález,F.J.(2021).
Smartphones: A Potential Revolution for High-Resolution Weather Hourly Evolution of Intra-urban Temperature Variability across the Local
FrontiersinEnvironmentalScience|www.frontiersin.org 13 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
ClimateZones.TheCaseofMadrid.UrbanClim.39,100921.doi:10.1016/j. Sinergise(2018).SentinelHub.EoBrows.Availableat:https://apps.sentinel-hub.
uclim.2021.100921 com/eo-browser/?lat=41.9000&lng=12.5000&zoom=10(AccessedJanuary30,
Oke,T.R.,Mills,G.,Christen,A.,andVoogt,J.A.(2017).UrbanClimates.Online 2022).
Publication:CambridgeUniversityPress,1–525.doi:10.1017/9781139016476 Soille,P.,Burger,A.,DeMarchi,D.,Kempeneers,P.,Rodriguez,D.,Syrris,V.,etal.
Okokon, E. O., Yli-Tuomi, T., Turunen, A. W., Taimisto, P., Pennanen, A., (2018). A Versatile Data-Intensive Computing Platform for Information
Vouitsis, I., et al. (2017). Particulates and Noise Exposure during Bicycle, RetrievalfromBigGeospatialData.FutureGener.Comput.Syst.81,30–40.
BusandCarCommuting:AStudyinThreeEuropeanCities.Environ.Res.154, doi:10.1016/j.future.2017.11.007
181–189.doi:10.1016/j.envres.2016.12.012 Stewart,I.D.,Krayenhoff,E.S.,Voogt,J.A.,Lachapelle,J.A.,Allen,M.A.,and
OpenDataCube(2022).OpenSource.Availableat:https://www.opendatacube. Broadbent,A.M.(2021).TimeEvolutionoftheSurfaceUrbanHeatIsland.
org/(AccessedJanuary30,2022). Earth’sFuture9,e2021EF002178.doi:10.1029/2021EF002178
Overeem,A.,R.Robinson,J.C.,Steeneveld,G.J.,P.Horn,B.K.,Uijlenhoet,R.,and Stewart,I.D.,andOke,T.R.(2012).LocalClimateZonesforUrbanTemperature
Uijlenhoet, R. (2013). Crowdsourcing Urban Air Temperatures from Studies. Bull. Am. Meteorol. Soc. 93, 1879–1900. doi:10.1175/BAMS-D-11-
Smartphone Battery Temperatures. Geophys. Res. Lett. 40, 4081–4085. 00019.1
doi:10.1002/grl.50786 Stewart,I.D.(2019).WhyShouldUrbanHeatIslandResearchersStudyHistory?
Pal,S.,andSharma,P.(2021).AReviewofMachineLearningApplicationsinLand UrbanClim.30,100484.doi:10.1016/j.uclim.2019.100484
SurfaceModeling.Earth2,174–190.doi:10.3390/earth2010011 Sudmanns,M.,Tiede,D.,Lang,S.,Bergstedt,H.,Trost,G.,Augustin,H.,etal.
PalaciosTemprano,J.,Eichholtz,P.,Willeboordse,M.,andKok,N.(2020).Indoor (2019). Big Earth Data: Disruptive Changes in Earth Observation Data
Environmental Quality and Learning Outcomes: Protocol on Large-Scale ManagementandAnalysis?13,832–850.doi:10.1080/17538947.2019.1585976
Sensor Deployment in Schools. BMJ Open 10, e031233. doi:10.1136/ Triscone,G.,Abdennadher,N.,Balistreri,C.,Donzé,O.,Greco,D.,Haas,P.,etal.
bmjopen-2019-031233 (2016).ComputationalFluidDynamicsasaTooltoPredicttheAirPollution
Parlow, E., and Foken, T. (2021). Ground-based Mobile Measurement Systems. DispersioninaNeighborhood-aResearchProjecttoImprovetheQualityof
SpringerHandbooks,1351–1367.doi:10.1007/978-3-030-52171-4_50Ground- LifeinCities.Int.J.SDP11,546–557.doi:10.2495/SDP-V11-N4-546-557
basedMobileMeasurementSystems Ulpiani,G.,Nazarian,N.,Zhang,F.,andPettit,C.J.(2021).TowardsaLivingLab
Pebesma,E.,Wagner,W.,Schramm,M.,VonBeringe,A.,Paulik,C.,Neteler,M., for Enhanced Thermal Comfort and Air Quality: Analyses of Standard
et al. (2017). OpenEO - a Common, Open Source Interface between Earth Occupancy, Weather Extremes, and COVID-19 Pandemic. Front. Environ.
ObservationDataInfrastructuresandFront-EndApplications.57.[Accessed Sci.9,556.doi:10.3389/fenvs.2021.725974
January31,2022].doi:10.5281/zenodo.1065474 Urech,P.R.W.,Dissegna,M.A.,Girot,C.,andGrêt-Regamey,A.(2020).Point
Peng,S.,Piao,S.,Ciais,P.,Friedlingstein,P.,Ottle,C.,Bréon,F.-M.,etal.(2012). CloudModelingasaBridgebetweenLandscapeDesignandPlanning.Landsc.
SurfaceUrbanHeatIslandacross419GlobalBigCities.Environ.Sci.Technol. UrbanPlan.203,103903.doi:10.1016/j.landurbplan.2020.103903
46,696–703.doi:10.1021/es2030438 Varentsov,M.,Fenner,D.,Meier,F.,Samsonov,T.,andDemuzere,M.(2021).
Pfautsch,S.,andTjoelker,A.R.(2020).TheImpactofSurfaceCoverandTree QuantifyingLocalandMesoscaleDriversoftheUrbanHeatIslandofMoscow
CanopyonAirTemperatureinWesternSydney140.doi:10.26183/BK6D-1466 withReferenceandCrowdsourcedObservations.Front.Environ.Sci.9,543.
Potgieter,J.,Nazarian,N.,Lipson,M.J.,Hart,M.A.,Ulpiani,G.,Morrison,W., doi:10.3389/fenvs.2021.716968
etal.(2021).CombiningHigh-ResolutionLandUseDatawithCrowdsourced Venter,Z.S.,Brousse,O.,Esau,I.,andMeier,F.(2020).HyperlocalMappingof
AirTemperaturetoInvestigateIntra-urbanMicroclimate.Front.Environ.Sci. UrbanAirTemperatureUsingRemoteSensingandCrowdsourcedWeather
9,385.doi:10.3389/fenvs.2021.720323 Data.RemoteSens.Environ.242,111791.doi:10.1016/j.rse.2020.111791
Rajkovich,N.,andLarsen,L.(2016).ABicycle-BasedFieldMeasurementSystem Venter,Z.S.,Chakraborty,T.,andLee,X.(2021).CrowdsourcedAirTemperatures
fortheStudyofThermalExposureinCuyahogaCounty,Ohio,USA.Ijerph13, ContrastSatelliteMeasuresoftheUrbanHeatIslandanditsMechanisms.Sci.
159.doi:10.3390/ijerph13020159 Adv.7.doi:10.1126/sciadv.abb9569
Rakha,T.,andGorodetsky,A.(2018).ReviewofUnmannedAerialSystem(UAS) Villa,T.,Gonzalez,F.,Miljievic,B.,Ristovski,Z.,andMorawska,L.(2016).An
Applications in the Built Environment: Towards Automated Building OverviewofSmallUnmannedAerialVehiclesforAirQualityMeasurements:
Inspection Procedures Using Drones. Automation Constr. 93, 252–264. PresentApplicationsandFutureProspectives.Sensors16,1072.doi:10.3390/
doi:10.1016/j.autcon.2018.05.002 s16071072
Reichstein,M.,Camps-Valls,G.,Stevens,B.,Jung,M.,Denzler,J.,Carvalhais,N., Voogt,J.A.,andOke,T.R.(2003).ThermalRemoteSensingofUrbanClimates.
etal.(2019).DeepLearningandProcessUnderstandingforData-DrivenEarth RemoteSens.Environ.86,370–384.doi:10.1016/S0034-4257(03)00079-8
SystemScience.Nature566,195–204.doi:10.1038/s41586-019-0912-1 Vos,L.W.,Leijnse,H.,Overeem,A.,andUijlenhoet,R.(2019).QualityControlfor
Schneider,P.,Castell,N.,Vogt,M.,Dauge,F.R.,Lahoz,W.A.,andBartonova,A. Crowdsourced Personal Weather Stations to Enable Operational Rainfall
(2017).MappingUrbanAirQualityinNearReal-TimeUsingObservations Monitoring.Geophys.Res.Lett.46,8820–8829.doi:10.1029/2019GL083731
fromLow-CostSensorsandModelInformation.Environ.Int.106,234–247. Vulova,S.,Meier,F.,Fenner,D.,Nouri,H.,andKleinschmit,B.(2020).Summer
doi:10.1016/j.envint.2017.05.005 NightsinBerlin,Germany:ModelingAirTemperatureSpatiallywithRemote
Schrotter,G.,andHürzeler,C.(2020).TheDigitalTwinoftheCityofZurichfor Sensing,CrowdsourcedWeatherData,andMachineLearning.IEEEJ.Sel.Top.
Urban Planning. Pfg 88, 99–112. doi:10.1007/S41064-020-00092-2/ Appl. Earth Obs. Remote Sens. 13, 5074–5087. doi:10.1109/JSTARS.2020.
FIGURES/14 3019696
See,L.,Mooney,P.,Foody,G.,Bastin,L.,Comber,A.,Estima,J.,etal.(2016). Wang,C.,Wen,C.,Dai,Y.,Yu,S.,andLiu,M.(2020).Urban3DModelingwith
Crowdsourcing,CitizenScienceorVolunteeredGeographicInformation?the MobileLaserScanning:aReview.VirtualReal.IntelligentHardw.2,175–212.
Current State of Crowdsourced Geographic Information. ISPRS Int. J. Geo- doi:10.1016/j.vrih.2020.05.003
Information5,55.doi:10.3390/ijgi5050055 Wang,L.,Ma,Y.,Yan,J.,Chang,V.,andZomaya,A.Y.(2018a).pipsCloud:High
Seidel,J.,Ketzler,G.,Bechtel,B.,Thies,B.,Philipp,A.,Böhner,J.,etal.(2016). PerformanceCloudComputingforRemoteSensingBigDataManagementand
MobileMeasurementTechniquesforLocalandMicro-scaleStudiesinUrban Processing.FutureGener.Comput.Syst.78,353–368.doi:10.1016/j.future.2016.
andTopo-Climatology.Erde147,15–39.doi:10.12854/erde-147-2 06.009
SEPAL(2022).FAO. Available at:https://github.com/openforis/sepal (Accessed Wang,R.,Peethambaran,J.,andChen,D.(2018b).LiDARPointCloudsto3-D
January30,2022). UrbanModels$:$AReview.IEEEJ.Sel.Top.Appl.EarthObs.RemoteSens.11,
Servadio,J.L.,Lawal,A.S.,Davis,T.,Bates,J.,Russell,A.G.,Ramaswami,A., 606–627.doi:10.1109/JSTARS.2017.2781132
et al. (2019). Demographic Inequities in Health Outcomes and Air Wilhelm,E.,Siby,S.,Zhou,Y.,Ashok,X.J.S.,Jayasuriya,M.,Foong,S.,etal.
Pollution Exposure in the Atlanta Area and its Relationship to Urban (2016).WearableEnvironmentalSensorsandInfrastructureforMobileLarge-
Infrastructure. J. Urban Health 96, 219–234. doi:10.1007/S11524-018- ScaleUrbanDeployment.IEEESensors J.16,8111–8123.doi:10.1109/JSEN.
0318-7/TABLES/4 2016.2603158
FrontiersinEnvironmentalScience|www.frontiersin.org 14 May2022|Volume10|Article867434

Middeletal. UrbanClimateInformatics
Willems,P.,Arnbjerg-Nielsen,K.,Olsson,J.,andNguyen,V.T.V.(2012).Climate Zhang,W.,Li,W.,Zhang,C.,Hanink,D.M.,Li,X.,andWang,W.(2017).Parcel-
ChangeImpactAssessmentonUrbanRainfallExtremesandUrbanDrainage: basedUrbanLandUseClassificationinMegacityUsingAirborneLiDAR,High
MethodsandShortcomings.Atmos.Res.103,106–118.doi:10.1016/j.atmosres. ResolutionOrthoimagery,andGoogleStreetView.Comput.Environ.Urban
2011.04.003 Syst.64,215–228.doi:10.1016/j.compenvurbsys.2017.03.001
Wulder,M.A.,Masek,J.G.,Cohen,W.B.,Loveland,T.R.,andWoodcock,C.E. Zhang,X.,Liu,L.,Wu,C.,Chen,X.,Gao,Y.,Xie,S.,etal.(2020).Developmentofa
(2012).Opening theArchive: HowFreeDataHasEnabledtheScienceand Global30MImperviousSurfaceMapUsingMultisourceandMultitemporal
MonitoringPromiseofLandsat.RemoteSens.Environ.122,2–10.doi:10.1016/j. RemoteSensingDatasetswiththeGoogleEarthEnginePlatform.EarthSyst.
rse.2012.01.010 Sci.Data12,1625–1648.doi:10.5194/essd-12-1625-2020
Xiaojun, C., Xianpeng, L., and Peng, X. (2015). IOT-based Air Pollution Zhang,Y.,Middel,A.,andTurner,B.L.(2019).EvaluatingtheEffectof3DUrban
Monitoring and Forecasting System. Int. Conf. Comput. Comput. Sci. FormonNeighborhoodLandSurfaceTemperatureUsingGoogleStreetView
ICCCS,257–260.doi:10.1109/ICCACS.2015.7361361 andGeographicallyWeightedRegression.Landsc.Ecol.34,681–697.doi:10.
Xu, G., Zhu, X., Tapper, N., and Bechtel, B. (2019). Urban Climate Zone 1007/s10980-019-00794-y
Classification Using Convolutional Neural Network and Ground-Level Zhao,L.,Oleson,K.,Bou-Zeid,E.,Krayenhoff,E.S.,Bray,A.,Zhu,Q.,etal.(2021).
Images. Prog. Phys. Geogr. Earth Environ. 43, 410–424. doi:10.1177/ GlobalMulti-ModelProjectionsofLocalUrbanClimates.Nat.Clim.Chang.11,
0309133319837711 152–157.doi:10.1038/s41558-020-00958-8
Yan, W. Y., Shaker, A., and El-Ashmawy, N. (2015). Urban Land Cover Zhou,Y.,Wei,T.,Zhu,X.,andCollin,M.(2021).AParcel-BasedDeep-Learning
Classification Using Airborne LiDAR Data: A Review. Remote Sens. ClassificationtoMapLocalClimateZonesfromSentinel-2Images.IEEEJ.Sel.
Environ.158,295–310.doi:10.1016/j.rse.2014.11.001 Top.Appl.EarthObs.RemoteSens.14,4194–4204.doi:10.1109/JSTARS.2021.
Yavaşlı,D.D.(2020).DroneApplicationsinGeography:GameofDrones.Curr.Stud. 3071577
Soc.Sci.II8,117.Availableat:https://www.researchgate.net/publication/344839834_ Zumwald,M.,Knüsel,B.,Bresch,D.N.,andKnutti,R.(2021).MappingUrban
Drone_Applications_in_Geography_Game_of_Drones(AccessedJanuary30,2022). TemperatureUsingCrowd-SensingDataandMachineLearning.UrbanClim.
Yin,L.,andWang,Z.(2016).MeasuringVisualEnclosureforStreetWalkability: 35,100739.doi:10.1016/j.uclim.2020.100739
UsingMachineLearningAlgorithmsandGoogleStreetViewImagery.Appl.
Geogr.76,147–153.doi:10.1016/j.apgeog.2016.09.024 ConflictofInterest:Theauthorsdeclarethattheresearchwasconductedinthe
Yoo,C.,Han,D.,Im,J.,andBechtel,B.(2019).ComparisonbetweenConvolutional absenceofanycommercialorfinancialrelationshipsthatcouldbeconstruedasa
NeuralNetworksandRandomForestforLocalClimateZoneClassificationinMega potentialconflictofinterest.
UrbanAreasUsingLandsatImages.ISPRSJ.PhotogrammetryRemoteSens.157,
155–170.doi:10.1016/j.isprsjprs.2019.09.009 Publisher’sNote:Allclaimsexpressedinthisarticlearesolelythoseoftheauthors
Young,J.C.,Arthur,R.,Spruce,M.,andWilliams,H.T.P.(2021).SocialSensingof anddonotnecessarilyrepresentthoseoftheiraffiliatedorganizations,orthoseof
Heatwaves.Sensors21,3717.doi:10.3390/s21113717 thepublisher,theeditorsandthereviewers.Anyproductthatmaybeevaluatedin
Zeng,L.,Lu,J.,Li,W.,andLi,Y.(2018).AFastApproachforLarge-ScaleSkyView thisarticle,orclaimthatmaybemadebyitsmanufacturer,isnotguaranteedor
FactorEstimationUsingStreetViewImages.Build.Environ.135,74–84.doi:10. endorsedbythepublisher.
1016/j.buildenv.2018.03.009
Zhan, W., Chen, Y., Zhou, J., Wang, J., Liu, W., Voogt, J., et al. (2013). Copyright©2022Middel,Nazarian,DemuzereandBechtel.Thisisanopen-access
Disaggregation of Remotely Sensed Land Surface Temperature: Literature articledistributedunderthetermsoftheCreativeCommonsAttributionLicense(CC
Survey, Taxonomy, Issues, and Caveats. Remote Sens. Environ. 131, BY).Theuse,distributionorreproductioninotherforumsispermitted,providedthe
119–139.doi:10.1016/j.rse.2012.12.014 original author(s) andthecopyright owner(s) arecredited andthattheoriginal
Zhang,D.,andWoo,S.S.(2020).RealTimeLocalizedAirQualityMonitoringand publicationinthisjournaliscited,inaccordancewithacceptedacademicpractice.
Prediction through Mobile and Fixed IoT Sensing Network. IEEE Access 8, No use, distribution or reproduction is permitted which does not comply with
89584–89594.doi:10.1109/ACCESS.2020.2993547 theseterms.
FrontiersinEnvironmentalScience|www.frontiersin.org 15 May2022|Volume10|Article867434
ORIGINALRESEARCH
published:12May2022
doi:10.3389/fenvs.2022.866240
—
MaRTiny A Low-Cost
Biometeorological Sensing Device
With Embedded Computer Vision for
Urban Climate Research
Karthik K. Kulkarni1,Florian A. Schneider2,TejaswiGowda3,Suren Jayasuriya1,3* and
Ariane Middel3,4
1SchoolofElectrical,ComputerandEnergyEngineering,ArizonaStateUniversity,Tempe,AZ,UnitedStates,2Schoolof
Sustainability,CollegeofGlobalFutures,ArizonaStateUniversity,Tempe,AZ,UnitedStates,3SchoolofArts,Mediaand
Engineering,ArizonaStateUniversity,Tempe,AZ,UnitedStates,4SchoolofComputingandAugmentedIntelligence,Arizona
StateUniversity,Tempe,AZ,UnitedStates
Editedby: Extremeheatputstremendousstressonhumanhealthandlimitspeople’sabilitytowork,
AdamSchlosser,
MassachusettsInstituteof travel,andsocializeoutdoors.Tomitigateheatinpublicspaces,thermalconditionsmust
Technology,UnitedStates beassessedinthecontextofhumanexposureandspaceuse.MeanRadiantTemperature
Reviewedby: (MRT)isanintegratedradiationmetricthatquantifiesthetotalheatloadonthehumanbody
GiuseppeRiccio,
and is a driving parameter in many thermal comfort indices. Current sensor systems to
UniversityofNaplesFedericoII,Italy
JuanAngelAceroAlejandro, measureMRTareexpensiveandbulky(6-directionalsetup)orslowandinaccurate(globe
Singapore-MITAllianceforResearch
thermometers) anddonotsensespaceuse.Thisengineeringsystemspaperintroduces
andTechnology(SMART),Singapore
the hardware and software setup of a novel, low-cost thermal and visual sensing device
*Correspondence:
SurenJayasuriya (MaRTiny). The system collects meteorological data, concurrently counts the number of
sjayasur@asu.edu peopleintheshadeandsun,andstreamstheresultstoanAmazonWebServices(AWS)
server. MaRTiny integrates various micro-controllers to collect weather data relevant to
Specialtysection:
humanthermalexposure:airtemperature,humidity,windspeed,globetemperature,and
Thisarticlewassubmittedto
InterdisciplinaryClimateStudies, UV radiation. To detect people in the shade and Sun, we implemented state of the art
asectionofthejournal
objectdetectionandshadedetectionmodelsonanNVIDIAJetsonNano.Thesystemwas
FrontiersinEnvironmentalScience
testedinthefield,showingthatmeteorologicalobservationscomparedreasonablywellto
Received:31January2022
Accepted:15April2022 MaRTy observations (high-end human-biometeorological station) when both sensor
Published:12May2022
systems were fully sun-exposed. To overcome potential sensing errors due to different
Citation:
exposure levels, we estimated MRT from MaRTiny weather observations using machine
KulkarniKK,SchneiderFA,GowdaT,
learning (SVM), which improved RMSE. This paper focuses on the development of the
JayasuriyaSandMiddelA(2022)
MaRTiny—ALow-Cost MaRTinysystemandlaysthefoundationforfundamentalresearchinurbanclimatescience
BiometeorologicalSensingDevice
to investigate how people use public spaces under extreme heat to inform active shade
WithEmbeddedComputerVisionfor
UrbanClimateResearch. management and urban design in cities.
Front.Environ.Sci.10:866240.
doi:10.3389/fenvs.2022.866240 Keywords:meanradianttemperature(MRT),thermalsensing,shadedetection,urbanmicroclimate,urbanheat
FrontiersinEnvironmentalScience|www.frontiersin.org 1 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
1 INTRODUCTION While a large body of literature has investigated shade and
microclimate in hot regions (Ali-Toudert and Mayer, 2007;
Theyear2020markstheEarth’swarmest10-yearperiodwithan Emmanuel et al., 2007; Shashua-Bar et al., 2009; Coutts et al.,
average increase in global temperature of 1.3 °C above pre- 2016), littleinformation exists onhowpeople use publicspaces
industrial levels. Extreme heat and related heat waves put andwhenandwheretheyareexposedtooutdoorheat.Weclose
tremendous stress on individuals’ health and well-being and this gap by developing a novel low-cost, portable, smart IoT
limits their ability to work, travel, and socialize in outdoor weatherstation(MaRTiny)thatcanmeasurepassivelythelocal
settings. Globally, extreme heat and associated heat wave meteorologicalconditions,theheatexposureatthegivenlocation
events are occurring more frequently and longer (Masson- and count people in the shade and Sun. Connecting hyperlocal
Delmotte et al., 2021). Future trends of urban warming meteorological conditions with space use data captured by a
indicate the need for adaption measures to promote resilience camerarevealsbehavioralpatternsofshadeandSunpreferences
inthepopulation.Theoutdoorurbanenvironmentisacomplex that vary by time of day, location, and ambient conditions.
arrangementofurbanformsandmaterialsthatimpacthowheat MaRTiny, as a passive sensor package, designed for hot, dry
isexperiencedbypedestriansatthemicroscale.Inhot,drycities climates,canprovidelocalheatexposure,suchasMRT,andspace
pedestriancomfortisstronglydictatedbytheavailabilityofshade use data without using external database.
(Middeletal.,2014;Colteretal.,2019).Pedestrianmayrespond Our contributions can be summarized as follows:
tomicroscaleoutdoorconditionsbychangingtheirwalkingpath
from Sun to shade or vice versa based on their heat exposure. 1. MaRTiny Weather Station—A low-cost and compact IoT
The most common way to report urban heat is air weather station that records air temperature, relative
temperature, which has been shown to be insufficient to humidity, globe temperature, and wind speed at 1-min
quantify personal heat exposure (Harlan et al., 2006; Kuras intervals. Globe temperature was converted to MRT using
et al., 2017). A more human-centric metric that emphasizes anempiricalmodelintheliteratureandcomparedwithhigh-
the heat load on the human body is the Mean Radiant endMRTmeasurements,resultinginarootmeansquareerror
Temperature (MRT). MRT objectively quantifies the total (RMSE)of10.0°Cforobserved6-directionalmeasurementsvs
short- and longwave radiation the human body is exposed to globe temperature measurements.
at a given location and time (Kántor and Unger, 2011). This 2. MaRTinyVisionSystem—Alow-cost,low-powered,compact
includeslongwaveradiationemittedfromsurroundingsurfaces, and smart vision system driven by state-of-the-art AI
such as asphalt parking lots or concrete walls, and shortwave algorithms. This system counts pedestrian and is also
radiationfromtheSun.MRTroughlyequalsairtemperaturein capable of identifying if a pedestrian is under the cooling
theshadebutcanbe30°ChigherintheSun,makingapersonfeel effectofshade.Fromourobservations,wecalculateaprecision
muchlesscomfortablewhenitishot.Inwarm,dryclimatessuch of 95% for pedestrian detection and an accuracy of 80% for
asthedesertcityofPhoenix,ArizonaintheUSA,MRTistheheat shade detection.
metric that best describes how people experience heat (Middel 3. Machine Learning based MRT—We developed a novel
etal.,2016).MRTisalsoacrucialinputparameterforcalculating machine learning model that relies only on a few
outdoor human thermal comfort indices such as PET (Höppe, meteorological parameters and is robust to changes in its
1999) and UTCI (Jendritzky et al., 2012). surrounding environment. This model corrects errors
MRThasbeensuccessfullyusedinurbanclimateandhuman introduced by the low-cost IoT sensor, such as slow
biometeorology research to predict heat-related mortality and response time, shape, color and material inconsistencies,
outperformed air temperature as predictor (Thorsson et al., etc., and predicts MRT with an accuracy of RMSE = 4°C.
2014). Using computer simulations, MRT was estimated to
assess the impact of tree planting strategies on human thermal This research paper is focused on the engineering and
exposure under climate change in Vancouver, Canada development of a low-cost, portable IoT weather stations for
(Aminipouri et al., 2019) and to perform thermal comfort MRT measurement. The study does not focus on a large-scale
routing in Tempe, Arizona, USA (Middel et al., 2017). scientificstudyofhumanexposureinoutdoorspaces,butrather
Observational studies have quantified the benefit of shade for the engineering and data science challenges of estimating MRT
thermal comfort of different shade types including trees, with a combined hardware-software system.
engineered structures, and urban form (Lee et al., 2018;
Middel et al., 2021). Accurate, high resolution MRT
measurements require expensive equipment, such as the 2 BACKGROUND AND RELATED WORK
biometeorological instrument platform MaRTy (Middel and
Krayenhoff, 2019), but lower-cost alternatives such as the gray 2.1 Mean Radiant Temperature Sensing
38mm globe thermometers and cylindrical thermometers have MRT is typically determined with integral radiation
beendeveloped(Thorssonetal.,2006;Brown,2019;Vanosetal., measurements using the so-called 6-directional method
2021). (Höppe, 1992). Three net radiometers are orthogonally setup
Activeshademanagementincitiesisimportant,especiallyin to measure the longwave and shortwave radiation in six
theSouthwesternUS,toprovideshadewherepeoplework,travel, directions. The radiative fluxes are then summarized into a
and socialize outdoors, because cooling benefits are hyperlocal. temperature value using the Stefan-Boltzmann Law:
FrontiersinEnvironmentalScience|www.frontiersin.org 2 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
(cid:4)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)
4(cid:3)6 W(a K +aL) (2014) found that all approaches discussed above (ENVI-met,
MRT(cid:1) i(cid:1)1 i k i l i −273.15 (1)
RayMan, and globe thermometer observations) overestimate
aσ
l MRT when compared to ISO calculations. Currently, no model
where K and L are the directional shortwave and longwave canaccuratelyestimateMRTintheabsenceofdetailedurbanform
i i
radiationfluxes,respectively;a anda areabsorptioncoefficients parameters.
k l
for short- and long wave radiation fluxes, respectively; σ is the
2.3 Pedestrian Counting
Stefan-Boltzmann constant; and W are factors that weigh the
i
directional fluxes to match the cylindrical shape of the human Much researchhasbeen developed forpedestrian counting and
standing body (0.06 is used for sensors pointing up and down, crowd estimation. Sensor-based techniques (Zappi et al., 2010;
0.22forlateralsensors).Thismethodislimitedbycostwiththree Wahletal.,2012;Raykovetal.,2016;Lauetal.,2018)usepassive
net radiometers that cost $5k each. infrared (PIR) and proximity sensors to monitor moving
AmoreaffordablebutlessaccuratemethodtoestimateMRTis pedestrians. Although these setups are compact and low-cost,
usingablackglobethermometer.Globethermometerssuchasthe they have a low accuracy and misclassify often, and work best
KestrelHeatStressmeter($500)havebeenusedtoquantifytheheat only under certain environmental conditions. Alternatively,
loadofpedestrians,athletes,andoutdoorworkersinvariousstudies network-based techniques (Kjærgaard et al., 2012; Weppner
(Johanssonetal.,2014).Thorssonetal.(2006)developedalow-cost and Lukowicz, 2013; Depatla et al., 2015) use Bluetooth and
globethermometerusingathermocoupleinagraypingpongball WiFi networks for crowd sensing.
(<$100). The acrylic gray color of the globe almost matches the Recently,machinelearningtechniqueslow-levelimagefeature
averagealbedoofthecombinationofthehumanskinandclothingto extraction methods (Chen et al., 2013, 2012), such as Haar
reliably estimate MRT (Olesen et al., 1989; Thorsson et al., 2006). cascade (Viola and Jones, 2001) and HOG (Histogram of
Albedovariationsbasedonclothingandskincolorarelargebetween Oriented Gradient) (Dalal and Triggs, 2005; Yao et al., 2020)
peopleandcannotsimplyberepresentedbyonecoloralone,hence combined with regression models like SVM (Support Vector
this gray globe can provide an accurate estimate for the average Machine) (Yao et al., 2020) or detectors like AdaBoost (Viola
combinedalbedowhichcanbeusedasareference. and Snow, 2003). State-of-the-art methods leverage deep
Variousconvectioncoefficientshavebeendevelopedforglobe convolutional neural networks for crowd estimation using
thermometers to improve MRT estimations from globe individual detection (Wu and Nevatia, 2005; Brostow and
temperature (Oliveira et al., 2019; Manavvi and Rajasekar, Cipolla, 2006; Wang and Wang, 2011; Stewart et al., 2016; Liu
2020; Acero et al., 2021; Alfano et al., 2021). Those coefficients et al., 2019) and using perspective maps (Chan et al., 2008;
areusuallyderivedunderspecificoutdoorconditionsandcannot Lempitsky and Zisserman, 2010; Zhang et al., 2015).
be generalized easily. Here, we will use an empirical model for Further, there are works revolving around analysis of crowd
acrylic gray globe temperature T developed by Vanos et al. behaviour in urban areas (Hoogendoorn and Bovy, 2004;
g
(2021) in Phoenix, AZ based on air temperature T , wind Hashimoto et al., 2016; Lee, 2020) and their relation with
a
speed V , globe thermometer diameter D = 38mm, and thermal comfort (Arens and Bosselmann, 1989; Givoni et al.,
a
emissivity ϵ = 0.97 of the globe: 2003;Eliassonetal.,2007;EomandNishihori,2021).Wedonot
aimtooutperformanyexistingpedestriancountingtechniques,
MRT(cid:1)(cid:7)(cid:5)1.6Tg −0.339Ta −8.69+273.15(cid:6)4+ but to combine them with a weather station as a single setup.
(cid:8)0.24+2.08Va 0.5+1.14Va 0.667(cid:9)
(cid:5)1.6Tg −0.339Ta −8.69−Ta (cid:6)108(cid:6)(cid:10)1/4−273.15 2.4 Research Gaps
(2)
Insummary,thermalexposuremeasurementsintandemwithpublic
space use assessments are crucial for active shade management in
2.2 MRT Modeling cities, but accurate MRT measurement setups are expensive and
Duetolimitedsensingresources,MRTmeasurementsacrossspace bulky.Low-costsystemssuchasgrayglobethermometershavebeen
andtimeareusuallysparse.Toaddressthisgap,microclimateand developedbutarenotconnectedtothecloudforeasydatastorage
radiationmodelscalculateMRTusinginformationonthebuiltform andanalysis.Inaddition,suchlow-costsensorscansufferfromover-
and meteorological data. For example, RayMan (Matzarakis et al., andunder-estimationofMRTatvarioustimesofthedayasnotedin
2010) is a point-based, single location model that requires previousliterature.NoneoftheexistingMRTsensingplatformshave
hemispherical fisheye photos as input and calculates MRT based vision capabilities, and space use is often assessed through time-
onthehorizonlimitationandstandardweatherinformation.ENVI- consuming manual observations. Finally, physics-based MRT
met (Bruse and Fleer, 1998) is a 3D gridded computational fluid models require detailed 3D data of the urban environment to
dynamics(CFD)modelinurbanclimatesstudiestoassessheatatthe model radiation flux densities and sun-exposure. Our MaRTiny
neighborhoodlevel.ENVI-metandRayMancalculateMRTbased systemaimstoaddressallthesegaps.
on Sun position to calculate the direct solar radiation and other
radiative fluxes. However, Crank et al. (2020) found that both
models do not perform well in extreme heat cases and struggle 3 SYSTEM OVERVIEW
withcomplexurbanforms.AceroandHerranz-Pascual(2015)also
report deviations in MRT simulations from globe thermometer The MaRTiny system is a compact, Internet-of-Things (IoT),
readings, especially under clear sky conditions, and Krüger et al. low-cost sensing and vision/recording/surveying platform (see
FrontiersinEnvironmentalScience|www.frontiersin.org 3 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
Figure1).ItsprimaryfunctionalityistomeasureMRTforagiven function of radiation, air temperature, and velocity, and thus
sun-exposed location using off-the-shelf meteorological sensors are an accurate low-cost solution to net radiometers (Thorsson
and a custom-made globethermometer. MaRTiny measures air et al., 2006). Air temperature is measured using a downward
temperature, relative humidity, wind speed, and globe hanging white cup that shades the attached temperature probe.
temperature, which are used to calculate MRT (see Eq. (2)). The white cup reflects most of the solar radiation instead of
In addition, MaRTiny is outfitted with a camera to detect and absorbing it to provide an air temperature “free” from the
count people in the shade and Sun. This data helps analyze influence of solar radiations. The UV sensor is used to
pedestrianbehaviorinpublicspaces(e.g.identifyingthenumber measure the UV intensity and train the machine learning
ofpeoplewhoutilizeshade,umbrella,bicyclesandtransportation model to estimate MRT based on all measured parameters.
etc).Privacyispreservedbyonlystoringquantitativemetrics(e.g. MaRTiny is powered by a DC adapter of 5V/4A, which is
pedestrian count) and discarding the captured images after shared by both systems (weather station and vision system).
analysis. The anemometer is supplied with 9V power by stepping up
TheentiresystemtransmitsdatatoaclouddatabaseviaWiFi. theprimaryvoltagesource.Thissetupcanbeeasilyscaledwith
It is powered by a single power source of 20W which is split more sensors without compromising on space and power. In
among different components according to their power ratings. practice, low-cost sensors are subject to noise and variation,
MaRTinywasbuiltunder$200usingdifferentmicro-controllers which can yield errors in MRT estimation using Eq. (2) as we
and AI edge devices. MaRTiny is envisioned to be a useful show later in Section 5. To solve this problem, we introduce a
scientific platform to capture MRT data and correlate it with machinelearningmodeltorobustlyestimateMRTdespitethese
pedestrianbehaviorinoutdoorsettingsatafractionofthesize/ inaccuracies.
cost of existing solutions. No active human labor is needed for
datacollection whichhelpssavefunds,time,andheatexposure 3.2 MaRTiny Vision
for researchers. Alongwithmeteorologicalparameters,MaRTinyrequiresvision
capabilitiesincludingobjectdetectionandidentificationaswellas
3.1 MaRTiny Weather Station shadedetectioninoutdoorareas.WeleveragetheNVIDIAJetson
MaRTinyhasfourtypesofsensorstocollectmeteorologicaldata Nano, a low-cost and low-powered edge device to run state-of-
every minute—multiple temperature probes/thermometers, UV the-artdeeplearningmodels.TheJetsonNanofeaturesanARM-
sensor, humidity sensor, and anemometer (wind speed sensor) based micro-processor built with a Nvidia V100 GPU
(see Figure 2 and Table 1 and Table 2 for details). Two programmed through Nvidia’s low level API TensorRT engine.
temperature probes are utilized for globe and air temperature Ithasconfigurablepowerconsumptionmodesof5Wand10W.
respectively. Globe temperature is measured using a gray ping- Asweperformcomputationallyheavytasks,wehaveconfigured
pong ball attached on top of its probe. The globe’s gray color the Jetson Nano to 10W mode. To capture video, we utilize a
almost matches the albedo of the human skin. The globe compactMIPI(MobileIndustryProcessorInterface)cameraand
thermometer and the derived MRT emulate the stream the data to the Jetson Nano using a gstreamer pipeline.
omnidirectional thermal exposure for a human body as a VisiondataissenttoAWSviaanexternalUSBWiFion-board.In
FIGURE1|TopviewofMaRTinysetup.JetsonNanoisattachedwithcoolingFanalongwithcameraandWiFimodule.Arduinoboardsareconnectedtodifferent
meteorologicalsensors.
FrontiersinEnvironmentalScience|www.frontiersin.org 4 May2022|Volume10|Article866240

| Kulkarnietal. |     |     |     |     |     |     |     | MaRTiny |
| ------------- | --- | --- | --- | --- | --- | --- | --- | ------- |
FIGURE2|BlockDiagramoftheMaRTinysetupalongwithcommunicationprotocols.FivesensorsareconfiguredtoArduinoUnoandthecollecteddatais
transmittedtoNodeMCUusingSerialCommunicationwhichisfurthersenttoAWSdatabaseusingMQTTProtocol.
TABLE1|ListofmeteorologicalparametersmeasuredbyMaRTiny. TABLE2|ListofelectricalMaRTinyparts,costs,andmeteorologicalsensor
accuracies.
Meteorologicalparameters
PartList
| Parameter |                                | Description |     | Unit |        |        |         |          |
| --------- | ------------------------------ | ----------- | --- | ---- | ------ | ------ | ------- | -------- |
|           |                                |             |     |      | Sensor | Partno | Cost($) | Accuracy |
| Ta        | Temperatureofthesurroundingair |             |     | °C   |        |        |         |          |
Tg Temperatureinthegrayglobe °C TemperatureProbe DS18B20 9 ±0.5°Cfrom-10°Cto+85°C
UV MediumandlongwaveUVradiation mW/cm2 HumiditySensor DHT22 5 2–5%from0to100%
| RH  | RelativeHumidity |     |     | %   | UVSensor   | ML8511   | 5 1%             |     |
| --- | ---------------- | --- | --- | --- | ---------- | -------- | ---------------- | --- |
| WS  | Windspeed        |     |     | m/s | Anemometer | Adafruit | 40 worstcase1m/s |     |
|     |                  |     |     |     | Arduino    | Uno      | 20               |     |
|     |                  |     |     |     | NodeMCU    | ESP8266  | 7                |     |
|     |                  |     |     |     | CSICamera  | IMX219   | 20               |     |
thenextsection,wedescribeindetailourdeeplearningnetworks
|                       |     |        |     |     | NvidiaJetson | JetsonNano | 108 |     |
| --------------------- | --- | ------ | --- | --- | ------------ | ---------- | --- | --- |
| to detect pedestrians | in  | shade. |     |     |              |            |     |     |
3.3 Data Logging and Communication designed for IoT. Once the communication is established, Node
To read meteorological sensor data, we use an Arduino Uno MCU waits for bytes of data to be received from the Uno board.
microcontroller. The Uno board communicates with a Sensor data collected by Uno is sent to NodeMCU via serial
NodeMCU micro-controller featuring an ESP8266 architecture communication every minute, which is then transmitted to
thathasaninbuiltWiFimodule,flashmemory,andsupportsthe DynamoDBusingtheMQTTprotocol.
PEM(PrivacyEnhancedMail)filesystem(seeFigure2).Sensor
dataarecontinuouslyreadinaloopbytheUnowithasmall1ms
delaytoavoidoverheating.Dataarecollectedinabuffer,andan 4 MACHINE LEARNING ALGORITHM
averageiscalculatedforeveryminute,whichisthentransmitted
DEVELOPMENT
| to the NodeMCU | board.   | The Uno            | acquires around | 80 readings    |             |          |              |     |
| -------------- | -------- | ------------------ | --------------- | -------------- | ----------- | -------- | ------------ | --- |
|                |          |                    |                 |                | 4.1 Machine | Learning | for Accurate | MRT |
| per minute.    | Both     | boards communicate |                 | via the serial |             |          |              |     |
| communication  | protocol | UART               | (universal      | Asynchronus    | Estimation  |          |              |     |
Receiver/Transmitter). As MaRTiny is a low-cost, compact alternative to the MaRTy
TheNodeMCUcommunicatessecurelywiththeonlinedatabase. sensing platform (Middel and Krayenhoff, 2019; Middel et al.,
We utilize AWS DynamoDB, a NoSQL flexible database that can 2020, 2021), the replacement of highly accurate sensors has
handle unstructured data. All thenecessarysecurityPEM files are drawbacks including less accuracy and sensor lag (Häb et al.,
|     | NodeMCU’s | flash |     |     |     |     |     |     |
| --- | --------- | ----- | --- | --- | --- | --- | --- | --- |
stored in the memory for authentication of 2015).Wenoticedtheseinaccuraciescausedseriouserrorsinthe
MaRTiny. Using these files, NodeMCU establishes a calculated MRT values (Figure 7). In particular, MRT was
communication path with AWS through the MQTT protocol, an sensitive to the positioning and orientation of the MaRTiny
extremely lightweight publish/subscribe messaging protocol relative to MaRTy (e.g the MaRTiny was shaded in one of the
FrontiersinEnvironmentalScience|www.frontiersin.org 5 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
test, which resulted in lower MRT values, while MaRTy’s net local context for these feature maps. The features captured by
radiometers were partially sun-exposed). shallowlayersexploitshadowdetailsinthelocalregionsandthe
Toovercomethislimitation,weformulateMRTestimationas featurescapturedbydeeplayersunderstandstheoverallshadow
a supervised learning problem. This requires labeled ground- region of the image. Figure 4 provides an example of shadow
truthMRTvaluestobeprovidedincorrespondencewithourless maps produced by the network.
robustmeteorologicalsensordata.InSection5,wediscussdata
collection consisting of paired MaRTy and MaRTiny 4.2.2 Object Detection
measurements to create this labeled data. This allows us to For object detection, we utilize the state-of-the-art YOLOv3
train a machine learning model to estimate MRT accurately network (AlexyAB, 2016) visualized in the lower branch of
from MaRTiny sensor data. We explored both traditional Figure 3. The model is trained on 80 different classes of the
machine learning methods using a support vector machine Microsoft COCO dataset. The YOLOv3 algorithm can be built
(SVM) as well as a deep learning-based artifical neural using two different frameworks - DarkNet and MobileNet
network. These two algorithms are versatile and well-known (Redmon et al., 2016). The MobileNet framework is
in machine learning as they satisfy universal approximation computationally light but has low accuracy, hence we decided
theorems (Cybenko, 1989; Hammer and Gersmann, 2002). In to use the Darknet framework. YOLOv3 has a mAP (mean
particular,weobservedanSVMwithRBF(RadialBasisFunction) Average purpose) of around 57 (Redmon and Farhadi, 2018)
kernelachievedthehighestaccuracyonourevaluationdatasetin and has been proven to be efficient in crowd places (Hsu et al.,
Section 5.Thismethodisalso computationallylightweight and 2020). Since the YOLOv3-darknet model is large and
can be easily deployed on the Jetson Nano for performing computationally expensive to run on the NVIDIA Jetson
inference, i.e. the process of using a trained machine learning Nano, we converted it into a simple neural graph using
algorithm to make a prediction. Nvidia’s TensorRT. This allowed the model to run successfully
on the Nano with a application-sufficient frame-rate of 4fps.
4.2 People and Shade Detection
4.2.1 Shadow Detection 4.2.3 Pedestrian in Shade Detection
To perform shadow detection in an image, we use the deep Animageisa2Drepresentationofthe3Dworld,soitisdifficult
learning model Bi-directional Feature Pyramid with Recurrent todeterminetheexactlocationofapedestrianonthegroundand
Attention Residual Modules (BDRAR) (Zhu et al., 2018), theirdistancefromthecamera.Weintroduceasimpleapproach
visualized in the upper branch of Figure 3. BDRAR network to identify pedestrians in shade without determining their
takesasingleimageasinputandoutputsabinaryshadowmapas position in 3D space. First, a binary shadow map from
output in an end-to-end manner. First, it leverages a BDRAR indicating the presence of shade per pixel is
convolutional neural network (CNN) to extract feature maps computed periodically (in our case, every 15min as shade
at different spatial resolutions. It then employs two series of does not vary significantly). For every MIPI camera frame,
recurrent attention residual modules to fully exploit global and YOLOv3 outputs objects with their bounding boxes consisting
FIGURE3|SystemOverviewoftheMaRTinyVisionusingdifferenttypesofNeuralNetworks.ThetopnetworkrepresentsBDRARnetwork,responsibleforshade
detectionandthebottomnetworkrepresentsYolov3.Shademapandboundingboxofpedestrianisfedintothepedestrianalgorithmtochecknumberofpeoplein
shadeandsun.
FrontiersinEnvironmentalScience|www.frontiersin.org 6 May2022|Volume10|Article866240

| Kulkarnietal. |     |     |     |     |     |     |     | MaRTiny |
| ------------- | --- | --- | --- | --- | --- | --- | --- | ------- |
FIGURE4|ExamplesofshadowmapsproducedbyBDRARnetwork.Notehowthenetworkworkswellfordarkpixelswithoutmistakingthemforshadeeffect.
ofpixelcoordinatesforthecorners.Ouralgorithmcalculatesthe Tempe, Arizona, United States. For validation purposes, the
IOU (Intersection over Union) of the bounding box with the MaRTy human-biometeorological platform (Middel and
shade map. We consider a person to be in shade if 40% of the Krayenhoff, 2019) was paired with the MaRTiny system for
bounding box region is inside the shade map (i.e. IOU = 0.4). simultaneous data logging. Figure 6 illustrates the paired
pedestrian’s
Calculating IOU without considering the setup, the top box corresponding to MaRTiny and the bottom
position with respect to shade can lead to errors. For setupcorrespondstoMaRTy.Wecanclearlyseethedifferencein
example, in Figure 5, one person is sun-exposed and the scalebetweenboththesetups.Inaddition,animagedatasetwas
other person is in the shade. The IOU of the bounding box collectedforevaluatingobjectandshadedetection.Imagesfrom
equals60%inthefirstcaseand
with theshadow map 40%in theMIPIcamerawerestoredatrandomintervalsalongwiththe
the second case. The IOU for the first case is high due to boundingboxesoftheinterestedobjects.Groundtruthbounding
backgroundshadeandshadowcastbytheperson’sbody.This boxesweredrawnmanuallyusingtoolssuchasAlexyAB,(2016);
is the most common type of error that occurs at different Tosmonav,(2020)for30imagesconsistingofaround50different
orientations of a person; therefore, it is necessary to objects.PrecisionandRecallforeachobjectwerecalculatedand
distinguish between shade from a person and shade from thenusedtocalculatemAP(meanAveragePrecision).Thesame
the surroundings. Our algorithm first checks if the images were used to evaluate shade detection using IOU
bounding box edge is in the shade. A person does not have (Intersection Over Union) metrics. Small video snippets were
to be completely in shade to feel the cooling effect, hence we stored at random intervals which helped to cross-verify the
consideronlythebottomhalfi.e.50%oftheboundingboxasa number of people in a given time frame. All the images and
ROI(RegionofInterest).WethencalculatetheIOUbetween videoswerestoredinanAWSS3bucketandweredeletedafter
| this region    | and the shadow | map. An IOU     | of 80% (which    | testing. |            |     |     |     |
| -------------- | -------------- | --------------- | ---------------- | -------- | ---------- | --- | --- | --- |
| implies an IOU | of 40%         | of the complete | bounding box) is |          |            |     |     |     |
|                |                |                 |                  | 5.2 MRT  | Estimation |     |     |     |
consideredastheoptimumvalueforapersontoexperiencethe
first
cooling effects of shade. The ROI and IOU can change based We evaluated the performance of MaRTiny in estimating
on the environment and application. Pedestrian count under MRT values. We utilize Eq. 2 with the sensor data on-board to
Sun and shade along with other relevant counts (umbrellas, calculateMRT.MaRTylogsdataevery2s,andMaRTinystores
pets,andbicycles)arereportedtotheonlinedatabase,andthe data every minute, hence we calculated 1-min averages for
frame with identifying features is discarded. This allows our comparison. Ground truth MRT was calculated using Eq. 1.
devicetopreservetheprivacyoftheindividualsbeingobserved Figure 7 shows MaRTiny MRT results in green and MaRTy’s
groundtruthcalculationinred.AsignificanterrorinMaRTiny’s
| which is necessary | for public | deployment. |     |                 |          |               |             |     |
| ------------------ | ---------- | ----------- | --- | --------------- | -------- | ------------- | ----------- | --- |
|                    |            |             |     | estimationofMRT | wasfound | inthemornings | withanMSEof |     |
around10°C.Theerrorisduetothespatialoffsetbetweenthetwo
5 SYSTEM EVALUATION devices, which caused the gray globe thermometer of the
|          |            |     |     | MaRTiny sensor  | to be partially | shaded by       | a nearby palm | tree |
| -------- | ---------- | --- | --- | --------------- | --------------- | --------------- | ------------- | ---- |
| 5.1 Data | Collection |     |     |                 |                 |                 |               |      |
|          |            |     |     | in the mornings | while MaRTy’s   | net radiometers | were          | sun- |
For evaluation, we collected a custom dataset of ground truth exposed. A palm tree has a narrow shadow pattern covering
MRTvaluesfortwosun-exposedoutdoorlocationsfor3daysin only portions of the whole MaRTy and MaRTiny setup (see
FrontiersinEnvironmentalScience|www.frontiersin.org 7 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
FIGURE5|Imagesofapersonwithboundingboxandshadowmapofthesurrounding.Usingouralgorithm,wecandetectthatthepersoninthefirstimageissun-
exposedandthepersoninthesecondscenarioisinshade.
Figure 6). For a detailed discussion of limitations, please see Sincethereisanon-linearrelationofglobetemperatureand
section 6 (Discussion and Limitations). air temperature with MRT given in Eq. 2, machine learning
To overcome these issues, we utilized our supervised modelsneedtounderstandcomplexnon-linearrelationsbetween
learning approach using both SVM and ANN. Machine theseparameters.ASVMwithRBFkernelandaneuralnetwork
learning models were trained on selected meteorological with ReLU (Rectified Linear Unit) activation function are
parameters - air temperature, globe temperature, humidity example of such models. In Table 3, we present a comparison
and UV intensity, which were comparatively more accurate of SVMs with three different kernels and a traditional artificial
andlesspronetonoise.Weusedaround12,000datapointsfor neuralnetwork(ANN).WereporttheRootMeanSquareError
trainingand3,000fortestingfromarangeofdates,times,and (RMSE)forboththetestingandevaluationdatasets.Notethatthe
locationsinthesensingperiod.Thesetrainingpointswerefed results of linear and polynomial SVMkernels justifyour earlier
as vectors into the scikit-learn package in Python for training assumptionandtheresultsofSVMwithRBFkernelaswellasthe
SVMs and ANNs. 5-fold cross-validation was used to tune ANN achieved the best performance in quantitative metrics.
model hyperparameters such as learning rate. A separate From Figure 8 we can see the performance of SVM with RBF
dataset for evaluation consisted of around 700 data points kernel, which is almost linear with the ground truth.
from a single location collected in a day as is the usual WetrainedourANNonai7CPU.Wesetourlearningrateα
application for this algorithm. to0.001,whichtookaround5minand300epochstoconverge.
FrontiersinEnvironmentalScience|www.frontiersin.org 8 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
FIGURE6|MaRTyandMaRTinysetup.ThetopwhiteboxcorrespondstoMaRTinyandtheentirebottomsetupcorrespondstoMaRTy.
FIGURE7|PartI:PerformanceofMaRTinyweatherstationalongwithtrainedMLmodeltestedbetween05-21-2021to05-23-2021inTempe,Arizona.
ComparisonofcalculatedMRTvalueswithSVMmodel.NotethedipsinthecalculationduetotheshadingeffectsoftheenvironmentexperiencedbytheMaRTiny
system,whichiscorrectedbytheSVMModel.
FrontiersinEnvironmentalScience|www.frontiersin.org 9 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
TABLE3|PerformanceofdifferentsupervisedmachinelearningmodelsforMRT the object detector needed to be compatible with both the
estimation. TensorRT engine which we utilize on the NVIDIA Jetson
MachineLearningAlgorithmsforMRT board as well as the Python dependencies and packages
necessary to run BDRAR as well as itself. Future research
Algorithm RMS-Test RMS-Eval
could investigate the optimal choice of object detector with
SVM-Linear 16.8 20.2 shade detection (or a joint-model) for enhanced application
SVM-Poly 12.0 10.0
performance. Although the model is out-of-box, we wanted to
SVM-RBF 4.6 3.9
evaluate its performance in the environment suitable for the
ANN 3.2 3.8
MaRTinydeviceandhence,wecollectedasmallcustomdataset
andevaluatedperformanceontheseimages.Thisevaluationon
custom dataset should only be considered as a secondary
Althoughthismodelperformsslightlybetteronthetestdataset evaluation while we still refer the reader to the main
than the SVM-RBF model, performance is identical on the evaluation mentioned in the original study (Redmon and
evaluation dataset. The SVM model is also computationally Farhadi, 2018) for the full performance of the object detector.
lighter and can be easily trained and deployed on edge devices Thestandardevaluationmetricusedforanyobjectdetectionis
such as Jetson Nano. mAP(meanAveragePrecision).Boundingboxesweremanually
5.3 Shade and Object Detection drawnusingthetoolforthedatasetconsistingof30imagesand
IOU was calculated with the bounding boxes predicted by our
For object detection, we leverage the YOLOv3 architecture
model.Precision and recalliscalculated for aseries of different
(Redmon and Farhadi, 2018). While not a state-of-the-art
IOUthresholdsrangingfrom0.5to0.95.Aprecision-recallgraph
object detector, this model is computationally lightweight in
isconstructedandtheareaunderthisgraphprovidesusthemAP
comparison to more modern object detection models. Further,
valueofaround55%,whichisclosetothevaluereportedintheir
study (Redmon and Farhadi, 2018). For our application IOU
thresholdof0.5givesustheoptimalresults.Wealsoachievedan
AveragePrecisionofmorethan85%fortheclassofPedestrian,
which is important for our application (Figure 9).
Evaluationofshadowdetectionisdoneonaperpixelbasis,
whichisabinaryevaluationmethod.Adatasetconsistingof
30 shade images was collected from different location and
time. We manually annotated these images using the tool
Tosmonav,(2020).Weusethepre-trainedBDRARmodelto
evaluatetheseimagesandcalculatedIOUoftheshadowmap
with the ground truth and found a precision of 90%. This is
not the most effective method to calculate model accuracy
due to the irregular shapes, human error in annotation and
smalldatasetandhencewealsoreferreaderstotheevaluation
metrics of the original paper (Zhu et al., 2018). We evaluate
our pedestrian in shade detection algorithm on a custom
dataset of 50 images collected using MaRTiny. We have
manually compared the detected values from our
FIGURE8|PartII:PerformanceofMaRTinyweatherstationalongwith
trainedMLmodeltestedbetween05-21-2021to05-23-2021inTempe,
Arizona.PerformanceofSVMModelontestdataset,whichisalmostlinear FIGURE9|Thegraphshowstheperformanceofobjectdetectionon
withgroundtruth. differentclassesofimagescollectedduringevaluation.
FrontiersinEnvironmentalScience|www.frontiersin.org 10 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
FIGURE10|ExampleofPedestriandetectionalongwithmasksusingYolov3algorithm(left)andMaRTinyperformingpedestriandetectioninshadeandsun(right).
algorithm with the ground truth and plotted a confusion 6 DISCUSSION AND LIMITATIONS
matrix to obtain an accuracy of around 80%. Test data
consisted of different shading effects and relative positions This systems engineering study introduced a novel low-cost
of pedestrian. Since this kind of testing has not been carried device that combines meteorological sensing with computer
outbefore,ourresultcanactasabaselineforfuturetests.The vision to estimate MRT and space use. While previous work
accuracy can be improved on edge cases where pedestrian is has mainly focused on assessing the accuracy and precision of
partially exposed to Sun at different orientations. Figure 10 various sensors and on advancing MRT simulation tools, our
and Figure 11 provides examples of MaRTiny Vision where contribution focuses on developing a low-cost hardware and
YOLOv3 detects different objects and works along with software setup that can be used by non-experts such as city
BDRAR to determine if a pedestrian is in shade or sun. staffandcitizenscientists.Wealsoexploredtheuseofstate-of-
FIGURE11|SampleimagesofShadeDetectionandPedestrianCounting.Thetoptworowsareexampleofshademapestimationcarriedatdifferenttimeand
environments(Trees,Buildings,EmptySpaces)andlastrowhassampleimagescapturedbyMaRTinyforObjectDetection(PedestrianandBike).
FrontiersinEnvironmentalScience|www.frontiersin.org 11 May2022|Volume10|Article866240

| Kulkarnietal. |     |     |     |     |     |     |     |     |     |     | MaRTiny |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------- |
the-artmachinelearningtechniquestoimproveMRTestimation Yolov3.Althoughitperformswellwhendetectingpedestriansin
from low-cost sensors. crowds,itstruggleswhenanindividualpersonoccludesanother
ThisarticleintroducesthesetupofthenovelMaRTinysystem personinthevideofeed.Theshadedetectionworkswellbutcan
to monitor biometeorological conditions and people’s use of misclassifyapersonasshadedorsun-exposedwhenintersecting
public spaces with changing weather conditions. An empirical the position of a person with the shadow mask, because the
studymustfollowtocollectrobustdataoveralongperiodoftime algorithmdoesnottakeintoaccountthe3-dimensionalnatureof
to systematically analyze the relationship between thermal the shade and person in the scene.
| conditions        |     | and space | usage. | In       | addition,  | the     | MaRTiny |     |     |     |     |
| ----------------- | --- | --------- | ------ | -------- | ---------- | ------- | ------- | --- | --- | --- | --- |
| biometeorological |     | setup     | must   | be fully | calibrated | against | NIST    |     |     |     |     |
certified
|       | sensors | before   | deployment, |      | as it is  | built using | off-the- | 7 CONCLUSION |     |     |     |
| ----- | ------- | -------- | ----------- | ---- | --------- | ----------- | -------- | ------------ | --- | --- | --- |
| shelf | sensors | with low | accuracy    | (see | Table 2). |             |          |              |     |     |     |
°C
While an RMSE of 10 between 6-directional MRT Advancements in sensor technology have led to smaller, more
observations and globe temperature derived MRT may seem portable, and more affordable sensors that facilitate low-cost
large, it is on the order of magnitude of errors reported by sensing for many applications. In the domain of urban
other authors and quite common for outdoor MRT climate, low-cost sensing has gained popularity for
measurements in heterogeneous built environments. Acero crowdsourcing and citizen science studies, but is also
et al. (2021) found an RMSE of 7.4 °C for the standard increasingly used to build IoT sensor networks, for example,
ISO7726 coefficient between the 6-directional setup and a to monitor air pollution (Xiaojun et al., 2015) or thermal
standard black globe. Vanos et al. (2021) found an average conditions in occupational settings (Sulzer et al., 2022).
difference of -1.6 ± 7.2 °C between an acrylic gray globe and MaRTiny leverages edge devices that are low-cost, low-
integral radiation measurements on a solar roof that was not powered, and yet computationally capable of running state-of-
subjecttoshadingfromthesurroundingbuiltenvironment.Most the-artmachinelearningalgorithms.Integratingavisionsystem
recently, Lee et al. (2022) reported a large mean difference of and people detection into the biometeorological sensing system
13.2–21.6°ConsunnydaysbetweenglobethermometerMRTand enables in-depth analyses of how weather and microclimate
traditional MRT measurements. conditions impact people’s walking behavior in public spaces,
Globe thermometers have various shortcomings, mostly including the use of shaded and sun-exposed areas. Once
related to the indirect measurement of incident radiative calibrated, the system will be deployed in City of Tempe parks
fluxes, which is highly sensitive to globe size, shape, material and at playgrounds to inform municipal decision-making on
|                         |     |     |        |     |            |        |         | targeted investmentsfor |     | coolinginfrastructure | inpublic spaces. |
| ----------------------- | --- | --- | ------ | --- | ---------- | ------ | ------- | ----------------------- | --- | --------------------- | ---------------- |
| properties/assumptions, |     |     | color, | and | wind speed | (Vanos | et al., |                         |     |                       |                  |
TheMaRTinysystemisanexampleofhowtheemergingfieldof
| 2021). | Guo | et al. | (2018) | and Chen | et  | al. (2014) | found |     |     |     |     |
| ------ | --- | ------ | ------ | -------- | --- | ---------- | ----- | --- | --- | --- | --- |
significant impacts of wind speed on MRT obtained from Urban Climate Informatics can support heat mitigation efforts
globe thermometers, and Teitelbaum et al. (2020) point to through non-traditional observational methodologies.
| errors | from     | free convection. |               | Globe | thermometers |      | also have a |     |     |     |     |
| ------ | -------- | ---------------- | ------------- | ----- | ------------ | ---- | ----------- | --- | --- | --- | --- |
| long   | response | time             | (Nikolopoulou | et    | al., 1999)   | that | grows with  |     |     |     |     |
globe diameter. MaRTinies are operated in stationary settings, DATA AVAILABILITY STATEMENT
| which | reduces | the | error, but | they will | not | be able | to respond |     |     |     |     |
| ----- | ------- | --- | ---------- | --------- | --- | ------- | ---------- | --- | --- | --- | --- |
quicklytochangingcloudconditions.Lastly,globethermometers The raw data supporting the conclusions of this article will be
are known to overestimate MRT during high incoming solar made available by the authors, without undue reservation.
| radiation | periods | and | an underestimate |     | at  | low solar | elevation |     |     |     |     |
| --------- | ------- | --- | ---------------- | --- | --- | --------- | --------- | --- | --- | --- | --- |
(Thorssonetal.,2006;AceroandHerranz-Pascual,2015;Vanos
| et al., | 2021). |     |     |     |     |     |     | AUTHOR | CONTRIBUTIONS |     |     |
| ------- | ------ | --- | --- | --- | --- | --- | --- | ------ | ------------- | --- | --- |
Thepresentedmachinelearningmodelisaproof-of-concept
andisnotareliableMRTpredictorinitscurrentstate.Ourwork KK designed and built the system, designed the algorithms and
demonstratesthepotentialofSVMmodelsforMRTestimation software,analyzeddatafromexperiments,andhelpedwriteandedit
but requires future data collection with identical the manuscript. FS assisted with hardware prototyping and data
micrometeorological conditions for all sensors, ideally for a collection for both the MaRTiny and MaRTy setups as well as
full year, to build a robust model. The RMSE we calculated for writing/revising the paper. TG helped with initial project
our two testing days is high due to a palm tree that shaded the discussions/conception. SJ helped supervise the project especially
globe thermometer during the morning hours. RMSE is <4°C withmachinelearningandcomputervisionalgorithmsandhelped
whenthemorninghoursarediscarded.Weincludedthosehours write and edit the paper. AM conceived of the project idea,
in our proof-of-concept to illustrate that a SVM model can supervisedtheproject,andhelpedwriteandeditthepaper.
| overcome |     | errors that | are introduced |     | by sensor | setup. | However, |     |     |     |     |
| -------- | --- | ----------- | -------------- | --- | --------- | ------ | -------- | --- | --- | --- | --- |
forarobustSVMmodelthatcanbeusedinascientificstudy,all
| sensors | should | be  | subject | to the | same micrometeorological |     |     | FUNDING |     |     |     |
| ------- | ------ | --- | ------- | ------ | ------------------------ | --- | --- | ------- | --- | --- | --- |
(shading) conditions.
With respect to the vision system, the BDRAR network ThisresearchwasfundedbytheNationalScienceFoundation
exhibits minor inaccuracies in the shadow map estimation and (NSF), grant number CMMI-1942805 (CAREER: Human
FrontiersinEnvironmentalScience|www.frontiersin.org 12 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
Thermal Exposure in Cities - Novel Sensing and Modeling to Long-Term Ecological Research Program CAP LTER). Any
Build Heat-Resilience), NSF CNS-1951928 (Understanding opinions, findings, and conclusions or recommendations
Heat Resiliency via Physiological, Mental, and Behavioral expressed in this material are those of the authors and do
Health Factors for Indoor and Outdoor Urban not necessarily reflect the views of the sponsoring
Environments), and DEB-1832016 (Central Arizona-Phoenix organizations.
REFERENCES Cybenko,G.(1989).ApproximationbySuperpositionsofaSigmoidalFunction.
Math.ControlSignalSyst.2,303–314.doi:10.1007/BF02551274
Dalal,N.,andTriggs,B.(2005).“HistogramsofOrientedGradientsforHuman
Acero, J. A., Dissegna, A., Tan, Y. S., Tan, A., and Norford, L. K. (2021). Detection,”in2005IEEEComputerSocietyConferenceonComputerVision
OutdoorPerformanceoftheBlackGlobeTemperatureSensoronaHotand andPatternRecognition(CVPR’05),886–893.doi:10.1109/CVPR.2005.177
Humid Tropical Region. Environ. Technol., 1–13. doi:10.1080/09593330. Depatla,S.,Muralidharan,A.,andMostofi,Y.(2015).OccupancyEstimationUsing
2021.1989057 OnlyWifiPowerMeasurements.IEEEJ.Sel.AreasCommun.33,1381–1393.
Acero,J.A.,andHerranz-Pascual,K.(2015).AComparisonofThermalComfort doi:10.1109/JSAC.2015.2430272
ConditionsinFourUrbanSpacesbyMeansofMeasurementsandModelling Eliasson,I.,Knez,I.,Westerberg,U.,Thorsson,S.,andLindberg,F.(2007).Climate
Techniques.Build.Environ.93,245–257.doi:10.1016/j.buildenv.2015.06.028 andBehaviourinaNordicCity.Landsc.UrbanPlan.82,72–84.doi:10.1016/j.
[Dataset] AlexyAB (2016). YOLO_mark. Available at: https://github.com/ landurbplan.2007.01.020
AlexeyAB/Yolo_mark. Emmanuel,R.,Rosenlund,H.,andJohansson,E.(2007).UrbanShading-ADesign
Alfano,F.R.D.,Dell’isola,M.,Ficco,G.,Palella,B.I.,andRiccio,G.(2021).Onthe OptionfortheTropics?AStudyinColombo,SriLanka.Int.J.Climatol.27,
Measurement of the Mean Radiant Temperature by Means of Globes: An 1995–2004.doi:10.1002/joc.1609
ExperimentalInvestigationunderBlackEnclosureConditions.Build.Environ. Eom, S., and Nishihori, Y. (2021). How Weather and Special Events Affect
193,107655.doi:10.1016/j.buildenv.2021.107655 Pedestrian Activities: Volume, Space, and Time. Int. J. Sustain. Transp. 0,
Ali-Toudert,F.,andMayer,H.(2007).ThermalComfortinanEast–WestOriented 1–31.doi:10.1080/15568318.2021.1897907
StreetCanyoninFreiburg(Germany)UnderHotSummerConditions.Theor. Givoni, B., Noguchi, M., Saaroni, H., Pochter, O., Yaacov, Y., Feller, N., et al.
Appl.Climatol.87,223–237.doi:10.1007/s00704-005-0194-4 (2003). Outdoor Comfort Research Issues. Energy Build. 35, 77–86. doi:10.
Aminipouri,M.,Rayner,D.,Lindberg,F.,Thorsson,S.,Knudby,A.J.,Zickfeld,K., 1016/S0378-7788(02)00082-8
et al. (2019). Urban Tree Planting to Maintain Outdoor Thermal Comfort Guo, H., Teitelbaum, E., Houchois, N., Bozlar, M., and Meggers, F. (2018).
UnderClimateChange:TheCaseofVancouver’sLocalClimateZones.Build. Revisiting the Use of Globe Thermometers to Estimate Radiant
Environ.158,226–236.doi:10.1016/j.buildenv.2019.05.022 Temperature in Studies of Heating and Ventilation. Energy Build. 180,
Arens,E.,andBosselmann,P.(1989).Wind,SunandTemperature-Predictingthe 83–94.doi:10.1016/j.enbuild.2018.08.029
ThermalComforfofPeopleinOutdoorSpaces.Build.Environ.24,315–320. Häb,K.,Ruddell,B.L.,andMiddel,A.(2015).SensorLagCorrectionforMobile
doi:10.1016/0360-1323(89)90025-5 UrbanMicroclimateMeasurements.UrbanClim.14,622–635.doi:10.1016/j.
Brostow, G. J., and Cipolla, R. (2006). Unsupervised Bayesian Detection of uclim.2015.10.003
IndependentMotioninCrowds.USA:IEEEComputerSociety. Hammer,B.,andGersmann,K.(2003).ANoteontheUniversalApproximation
Brown,R.D.(2019).CorrectingtheErrorinMeasuringRadiationReceivedbya CapabilityofSupportVectorMachines.NeuralProcess.Lett.17,43–53.doi:10.
Person: Introducing Cylindrical Radiometers. Sensors 19,5085.doi:10.3390/ 1023/A:1022936519097
s19235085 Harlan,S.L.,Brazel,A.J.,Prashad,L.,Stefanov,W.L.,andLarsen,L.(2006).
Bruse,M.,andFleer,H.(1998).SimulatingSurface-Plant-AirInteractionsinside NeighborhoodMicroclimatesandVulnerabilitytoHeatStress.Soc.Sci.Med.
UrbanEnvironmentswithaThreeDimensionalNumericalModel.Environ. 63,2847–2863.doi:10.1016/j.socscimed.2006.07.030
Model.Softw.13,373–384.doi:10.1016/S1364-8152(98)00042-5 Hashimoto, Y., Gu, Y., Hsu, L.-T., Iryo-Asano, M., and Kamijo, S. (2016). A
Chan,A.B.,Zhang-ShengJohnLiang,J.,andVasconcelos,N.(2008).“Privacy ProbabilisticModelofPedestrianCrossingBehavioratSignalizedIntersections
Preserving Crowd Monitoring: Counting People without People Models or for Connected Vehicles. Transp. Res. Part C Emerg. Technol. 71, 164–181.
Tracking,” in Computer Vision andPattern Recognition. doi:10.1109/CVPR. doi:10.1016/j.trc.2016.07.011
2008.4587569 Hoogendoorn, S. P., and Bovy, P. H. L. (2004). Pedestrian Route-Choice and
Chen,K.,Gong,S.,Xiang,T.,andChangeLoy,C.(2013).“CumulativeAttribute Activity Scheduling Theory and Models. Transp. Res. Part B Methodol. 38,
SpaceforAgeandCrowdDensityEstimation,” inProceedingsoftheIEEE 169–190.doi:10.1016/S0191-2615(03)00007-9
Conference on Computer Vision and Pattern Recognition (CVPR). doi:10. Höppe,P.(1992).ANewProceduretoDeterminetheMeanRadiantTemperature
1109/cvpr.2013.319 Outdoors.WetterundLeben44,147–151.
Chen,K.,Loy,C.C.,Gong,S.,andXiang,T.(2012).“FeatureMiningforLocalised Höppe,P.(1999).ThePhysiologicalEquivalentTemperature-aUniversalIndex
CrowdCounting,”inProceedingsoftheBritishMachineVisionConference for the Biometeorological Assessment of the Thermal Environment. Int.
(BMVAPress),21.doi:10.5244/C.26.21 J.Biometeorology43,71–75.doi:10.1007/s004840050118
Chen,Y.-C.,Lin,T.-P.,andMatzarakis,A.(2014).ComparisonofMeanRadiant Hsu,Y.W.,Chen,Y.W.,andPerng,J.W.(2020).EstimationoftheNumberof
TemperaturefromFieldExperimentandModelling:aCaseStudyinFreiburg, PassengersinaBusUsingDeepLearning.Sensors(Basel)20,2178.doi:10.3390/
germany.Theor.Appl.Climatol.118,535–551.doi:10.1007/s00704-013-1081-z s20082178
Colter, K. R., Middel, A. C., and Martin, C. A. (2019). Effects of Natural and Jendritzky,G.,deDear,R.,andHavenith,G.(2012).UTCI-whyAnotherThermal
Artificial Shade on Human Thermal Comfort in Residential Neighborhood Index?Int.J.Biometeorol.56,421–428.doi:10.1007/s00484-011-0513-7
ParksofPhoenix,arizona,usa.UrbanFor.UrbanGreen.44,126429.doi:10. Johansson,E.,Thorsson,S.,Emmanuel,R.,andKrüger,E.(2014).Instrumentsand
1016/j.ufug.2019.126429 MethodsinOutdoorThermalComfortStudies-theNeedforStandardization.
Coutts,A.M.,White,E.C.,Tapper,N.J.,Beringer,J.,andLivesley,S.J.(2016). UrbanClim.10,346–366.doi:10.1016/j.uclim.2013.12.002
TemperatureandHumanThermalComfortEffectsofStreetTreesacrossThree Kántor,N.,andUnger,J.(2011).TheMostProblematicVariableintheCourseof
ContrastingStreetCanyonEnvironments.Theor.Appl.Climatol.124,55–68. Human-BiometeorologicalComfortAssessment-theMeanRadiantTemperature.
doi:10.1007/s00704-015-1409-y CentralEur.J.Geosciences3,90–100.doi:10.2478/s13533-011-0010-x
Crank,P.J.,Middel,A.,Wagner,M.,Hoots,D.,Smith,M.,andBrazel,A.(2020). Kjaergaard,M.B.,Wirz,M.,Roggen,D.,andTroster,G.(2012).“MobileSensingof
ValidationofSeasonalMeanRadiantTemperatureSimulationsinHotArid PedestrianFlocksinIndoorEnvironmentsUsingWiFiSignals,”in2012IEEE
UrbanClimates.Sci.TotalEnviron.749,141392.doi:10.1016/j.scitotenv.2020. International Conference on Pervasive Computing and Communications,
141392 PerCom.doi:10.1109/PerCom.2012.6199854
FrontiersinEnvironmentalScience|www.frontiersin.org 13 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
Krüger,E.L.,Minella,F.O.,andMatzarakis,A.(2014).ComparisonofDifferent ACM),1016–1027.2016ACMInternationalJointConferenceonPervasiveand
MethodsofEstimatingtheMeanRadiantTemperatureinOutdoorThermal Ubiquitous Computing, UbiComp 2016 ; Conference date: 12-09-2016
ComfortStudies.Int.J.Biometeorol.58,1727–1737.doi:10.1007/s00484-013- Through16-09-2016.
0777-1 Redmon,J.,Divvala,S.K.,Girshick,R.B.,andFarhadi,A.(2016).“YouOnlyLook
Kuras,E.R.,Richardson,M.B.,Calkins,M.M.,Ebi,K.L.,Hess,J.J.,Kintziger,K. once: Unified, Real-Time Object Detection,” in 2016 IEEE Conference on
W.,etal.(2017).OpportunitiesandChallengesforPersonalHeatExposure Computer Vision and Pattern Recognition (CVPR), 779. doi:10.1109/cvpr.
Research.Environ.HealthPerspect.125,085001.doi:10.1289/EHP556 2016.91
Lau,B.P.L.,Wijerathne,N.,Ng,B.K.K.,andYuen,C.(2018).SensorFusionfor Redmon,J.,andFarhadi,A.(2018).YOLOv3:AnIncrementalImprovement.
PublicSpaceUtilizationMonitoringinaSmartCity.IEEEInternetThingsJ.5, arXiv,ArXivabs/1804.02767.doi:10.48550/ARXIV.1804.02767
473–481.doi:10.1109/JIOT.2017.2748987 Shashua-Bar,L.,Pearlmutter,D.,andErell,E.(2009).TheCoolingEfficiencyof
Lee,H.,Jo,S.,andPark,S.(2022).ASimpleTechniquefortheTraditionalMethod Urban Landscape Strategies in aHot DryClimate. Landsc. urban Plan. 92,
toEstimateMeanRadiantTemperature.Int.J.Biometeorol.66,521–533.doi:10. 179–186.doi:10.1016/j.landurbplan.2009.04.005
1007/s00484-021-02213-x Stewart, R., Andriluka, M., and Ng, A. Y. (2016). “End-to-End People
Lee,I.,Voogt,J.,andGillespie,T.(2018).AnalysisandComparisonofShading Detection in Crowded Scenes,” in Proceedings of the IEEE Conference
StrategiestoIncreaseHumanThermalComfortinUrbanAreas.Atmosphere9, onComputerVisionandPatternRecognition(CVPR).doi:10.1109/cvpr.
91.doi:10.3390/atmos9030091 2016.255
Lee,J.M.(2020).ExploringWalkingBehaviorintheStreetsofnewyorkCity Sulzer,M.,Christen,A.,andMatzarakis,A.(2022).ALow-CostSensorNetwork
UsingHourlyPedestrianCountData.Sustainability12,7863.doi:10.3390/ for Real-Time Thermal Stress Monitoring and Communication in
su12197863 OccupationalContexts.Sensors22,1828.doi:10.3390/s22051828
Lempitsky,V.,andZisserman,A.(2010).“LearningtoCountObjectsinImages,”. Teitelbaum,E.,Chen,K.W.,Meggers,F.,Guo,H.,Houchois,N.,Pantelic,J.,etal.
AdvancesinNeuralInformationProcessingSystems.EditorsJ.Lafferty,C.Williams, (2020). Globe Thermometer Free Convection Error Potentials. Sci. Rep. 10,
J.Shawe-Taylor,R.Zemel,andA.Culotta(CurranAssociates,Inc.),23. 2652–2713.doi:10.1038/s41598-020-59441-1
Liu,W.,Salzmann,M.,andFua,P.(2019).“Context-awareCrowdCounting,”in Thorsson,S.,Honjo,T.,Lindberg,F.,Eliasson,I.,andLim,E.-M.(2007).Thermal
ProceedingsoftheIEEE/CVFConferenceonComputerVisionandPattern Comfort and Outdoor Activity in Japanese Urban Public Places. Environ.
Recognition(CVPR).doi:10.1109/cvpr.2019.00524 Behav.39,660–684.doi:10.1177/0013916506294937
Manavvi, S., and Rajasekar, E. (2020). Estimating Outdoor Mean Radiant Thorsson,S.,Rocklöv,J.,Konarska,J.,Lindberg,F.,Holmer,B.,Dousset,B.,
Temperature inaHumid SubtropicalClimate. Build. Environ. 171,106658. etal.(2014).MeanRadiantTemperature-APredictorofHeatRelated
doi:10.1016/j.buildenv.2020.106658 Mortality.UrbanClim.10,332–345.doi:10.1016/j.uclim.2014.01.004
Masson-Delmotte,V.,Zhai,P.,Pirani,A.,Connors,S.,Péan,C.,Berger,S.,etal. [Dataset] Tosmonav (2020). Cvat. Available at: https://github.com/
(2021).Ipcc,2021:ClimateChange2021:ThePhysicalScienceBasis.Contribution openvinotoolkit/cvat.
ofWorkingGroupItotheSixthAssessmentReportoftheIntergovernmentalPanel Vanos, J. K., Rykaczewski, K., Middel, A., Vecellio, D. J., Brown, R. D., and
onClimateChange.CambridgeUniversityPress.Availableat:https://www.ipcc. Gillespie, T. J. (2021). Improved Methods for Estimating Mean Radiant
ch/report/sixth-assessment-report-working-group-i/ Temperature in Hot and Sunny Outdoor Settings. Int. J. Biometeorol. 65,
Matzarakis, A., Rutz, F., and Mayer, H. (2010). ModellingRadiation Fluxes in 967–983.doi:10.1007/s00484-021-02131-y
Simple and Complex Environments: Basics of the RayMan Model. Int. Viola, P., Jones, M. J., and Snow, D. (2003). “Detecting Pedestrians Using
J.Biometeorol.54,131–139.doi:10.1007/s00484-009-0261-0 Patterns of Motion and Appearance,” in Proceedings Ninth IEEE
Middel,A.,AlKhaled,S.,Schneider,F.A.,Hagen,B.,andCoseo,P.(2021).50Gradesof International Conference on Computer Vision, 734. doi:10.1109/ICCV.
Shade.Bull.Am.MeteorologicalSoc.1,1–35.doi:10.1175/bams-d-20-0193.1 2003.1238422
Middel, A., Häb, K.,Brazel, A.J., Martin, C.A., and Guhathakurta,S. (2014). Viola,P.,andJones,M.(2001).“RapidObjectDetectionUsingaBoostedCascade
ImpactofUrbanFormandDesignonMid-afternoonMicroclimateinPhoenix of Simple Features,” in Proceedings of the 2001 IEEE Computer Society
Local Climate Zones. Landsc. Urban Plan. 122, 16–28. doi:10.1016/j. Conference on Computer Vision and Pattern Recognition. CVPR. doi:10.
landurbplan.2013.11.004 1109/CVPR.2001.990517
Middel,A.,andKrayenhoff,E.S.(2019).MicrometeorologicalDeterminantsof Wahl,F.,Milenkovic,M.,andAmft,O.(2012).“ADistributedPir-BasedApproach
PedestrianThermalExposureduringRecord-BreakingHeatinTempe,arizona: for Estimating People Count in Office Environments,” in 2012 IEEE 15th
Introducing the Marty Observational Platform. Sci. Total Environ. 687, InternationalConferenceonComputationalScienceandEngineering,640–647.
137–151.doi:10.1016/j.scitotenv.2019.06.085 doi:10.1109/ICCSE.2012.92
Middel, A., Lukasczyk, J., and Maciejewski, R. (2017). Sky View Factors from Wang,M.,andWang,X.(2011).AutomaticAdaptationofaGenericPedestrian
Synthetic Fisheye Photos for Thermal Comfort Routing-A Case Study in Detector to a Specific Traffic Scene. CVPR, 3401–3408. doi:10.1109/CVPR.
Phoenix,Arizona.UrbanPlanning2,19–30.doi:10.17645/up.v2i1.855 2011.5995698
Middel,A.,Selover,N.,Hagen,B.,andChhetri,N.(2016).ImpactofShadeon Weppner, J., and Lukowicz, P. (2013). “Bluetooth Based Collaborative Crowd
Outdoor Thermal Comfort-A Seasonal Field Study in Tempe,Arizona. Int. Density Estimation with Mobile Phones,” in 2013 IEEE International
J.Biometeorol.60,1849–1861.doi:10.1007/s00484-016-1172-5 Conference on Pervasive Computing and Communications, PerCom,
Middel,A.,Turner,V.K.,Schneider,F.A.,Zhang,Y.,andStiller,M.(2020).Solar 193–200.doi:10.1109/PerCom.2013.6526732
ReflectivePavements-APolicyPanaceatoHeatMitigation?Environ.Res.Lett. Wu, B., and Nevatia, R. (2005). Detection of Multiple, Partially Occluded
15,064016.doi:10.1088/1748-9326/ab87d4 Humans in a Single Image by Bayesian Combination of Edgelet Part
Nikolopoulou,M.,Baker,N.,andSteemers,K.(1999).ImprovementstotheGlobe Detectors. Tenth IEEE Int. Conf. Comput. Vis. 1, 90–97. doi:10.1109/
Thermometer for Outdoor Use. Archit. Sci. Rev. 42, 27–34. doi:10.1080/ iccv.2005.74
00038628.1999.9696845 Xiaojun, C., Xianpeng, L., and Peng, X. (2015). “Iot-based Air Pollution
Olesen,B.,Rosendahl,J.,Kalisperis,L.,Summers,L.H.,andSteinman,M.(1989). Monitoring and Forecasting System,” in 2015 International Conference on
Methods for Measuring and Evaluating the Thermal Radiation in a Room. ComputerandComputationalSciences(ICCCS),257–260.doi:10.1109/iccacs.
AshraeTrans.95,1028–1044. 2015.7361361
Oliveira,A.V.M.,Raimundo,A.M.,Gaspar,A.R.,andQuintela,D.A.(2019). Yao,Y.,Zhang,X.,Liang,Y.,Zhang,X.,Shen,F.,andZhao,J.(2020).“AReal-Time
GlobeTemperatureanditsMeasurement:RequirementsandLimitations.Ann. Pedestrian Counting System Based on Rgb-D,” in 2020 12th International
WorkExpo.Health63,743–758.doi:10.1093/annweh/wxz042 Conference on Advanced Computational Intelligence (ICACI), 110. doi:10.
Raykov,Y.,Ozer,E.,Dasika,G.,Boukouvalas,A.,andLittle,M.(2016).“Predicting 1109/ICACI49185.2020.9177816
RoomOccupancywithaSinglePassiveInfrared(Pir)SensorthroughBehavior Zappi, P., Farella, E., and Benini, L. (2010). Tracking Motion Direction and
Extraction,”inUbiComp2016-Proceedingsofthe2016ACMInternational DistancewithPyroelectricIrSensors.IEEESensorsJ.10,1486–1494.doi:10.
Joint Conference on Pervasive and Ubiquitous Computing (United States: 1109/JSEN.2009.2039792
FrontiersinEnvironmentalScience|www.frontiersin.org 14 May2022|Volume10|Article866240

Kulkarnietal. MaRTiny
Zhang,C.,Li,H.,Wang,X.,andYang,X.(2015).“Cross-sceneCrowdCountingvia Publisher’sNote:Allclaimsexpressedinthisarticlearesolelythoseoftheauthors
DeepConvolutionalNeuralNetworks,”inProceedingsoftheIEEEConference anddonotnecessarilyrepresentthoseoftheiraffiliatedorganizations,orthoseof
onComputerVisionandPatternRecognition(CVPR).doi:10.1109/cvpr.2015. thepublisher,theeditorsandthereviewers.Anyproductthatmaybeevaluatedin
7298684 thisarticle,orclaimthatmaybemadebyitsmanufacturer,isnotguaranteedor
Zhu,L.,Deng,Z.,Hu,X.,Fu,C.-W.,Xu,X.,Qin,J.,etal.(2018).“Bidirectional endorsedbythepublisher.
Feature Pyramid Network with Recurrent Attention Residual Modules for
ShadowDetection,”inECCV2018.LectureNotesinComputerScience.doi:10. Copyright©2022Kulkarni,Schneider,Gowda,JayasuriyaandMiddel.Thisisan
1007/978-3-030-01231-1_8 open-accessarticledistributedunderthetermsoftheCreativeCommonsAttribution
License(CCBY).Theuse,distributionorreproductioninotherforumsispermitted,
ConflictofInterest:Theauthorsdeclarethattheresearchwasconductedinthe providedtheoriginalauthor(s)andthecopyrightowner(s)arecreditedandthatthe
absenceofanycommercialorfinancialrelationshipsthatcouldbeconstruedasa originalpublicationinthisjournaliscited,inaccordancewithacceptedacademicpractice.
potentialconflictofinterest. Nouse,distributionorreproductionispermittedwhichdoesnotcomplywiththeseterms.
FrontiersinEnvironmentalScience|www.frontiersin.org 15 May2022|Volume10|Article866240
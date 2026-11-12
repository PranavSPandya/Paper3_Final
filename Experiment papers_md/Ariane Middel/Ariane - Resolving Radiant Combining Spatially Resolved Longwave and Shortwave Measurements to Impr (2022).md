METHODS
published:22July2022
doi:10.3389/frsc.2022.869743
Resolving Radiant: Combining
Spatially Resolved Longwave and
Shortwave Measurements to Improve
the Understanding of Radiant Heat
Flux Reflections and Heterogeneity
ColemanMerchant1*,ForrestMeggers1*,MiaomiaoHou2,3,DoritAviv2,
FlorianArwedSchneider4andArianeMiddel5,6
1PrincetonSchoolofArchitectureandtheAndlingerCenterforEnergyandtheEnvironment,PrincetonUniversity,Princeton,
NJ,UnitedStates,2WeitzmanSchoolofDesign,UniversityofPennsylvania,Philadelphia,PA,UnitedStates,3Collegeof
ArchitectureandUrbanPlanning,TongjiUniversity,Shanghai,China,4SchoolofSustainability,ArizonaStateUniversity,
Tempe,AZ,UnitedStates,5SchoolofArts,MediaandEngineering,ArizonaStateUniversity,Tempe,AZ,UnitedStates,
6SchoolofComputingandAugmentedIntelligence,ArizonaStateUniversity,Tempe,AZ,UnitedStates
We introduce and demonstrate new measurement and modeling techniques to fully
resolve the spatial variation in shortwave and longwave radiant heat transfer in the
outdoor environment. We demonstrate for the first time a way to directly resolve the
Editedby:
JenniferAnnSalmond, shortwave radiant heat transfer from terrestrial reflected and diffuse sky components
TheUniversityofAuckland, along with the standard direct solar radiation using an adapted thermopile array and
NewZealand
ray-tracing modeling techniques validated by 6-direction net radiometer. Radiant heat
Reviewedby:
transfer is a major component of heat experienced in cities. It has significant spatial
DahaiQi,
UniversitédeSherbrooke,Canada variability that is most easily noticed as one moves between shade and direct solar
XiangfeiKong,
exposure. But even on a cloudy and warm day the invisible longwave infrared thermal
HebeiUniversityofTechnology,China
radiation from warm surfaces makes up a larger fraction of heat experienced than that
*Correspondence:
ColemanMerchant caused by convection with surrounding air. Under warm or hot climate conditions in
cbm5@princeton.edu cities,radiantheattransfergenerallyaccountsforthemajorityofheattransfertopeople.
ForrestMeggers
Both the shortwave (visible/solar) and the longwave (infrared/thermal) have significant
fmeggers@princeton.edu
spatial variation. We demonstrate sensor methods and data analysis techniques to
Specialtysection: resolvehowtheseradiantfluxescanchangetheheatexperiencedby>1kWm−2across
Thisarticlewassubmittedto
smalldistances.Theintensesolarshortwaveradiationiseasilyrecognizedoutdoors,but
HealthandCities,
asectionofthejournal longwave is often considered negligible. Longwave radiation from heat stored in urban
FrontiersinSustainableCities
surfacesismoreinsidiousasitcancausechangesinvisibletotheeye.Weshowhowit
Received:04February2022 changesheatexperiencedby>200Wm−2.Thesevariationsareverycommonandalso
Accepted:17May2022
Published:22July2022 occuratthescaleofafewmeters.
Citation: Keywords:radiantheattransfer,thermalsensors,urbanheat,longwave,shortwave,thermopilearray
MerchantC,MeggersF,HouM,
AvivD,SchneiderFAandMiddelA
(2022)ResolvingRadiant:Combining INTRODUCTION AND BACKGROUND
SpatiallyResolvedLongwaveand
ShortwaveMeasurementstoImprove
Themeasurementofheatimpactsonpeopleinthebuiltenvironmentiscriticaltounderstanding
theUnderstandingofRadiantHeat
and addressing issues of human health, climate, and urban design. Climate change is increasing
FluxReflectionsandHeterogeneity.
Front.Sustain.Cities4:869743. averagetemperaturesacrosstheglobe,withthemostrecentIntergovernmentalPanelonClimate
doi:10.3389/frsc.2022.869743 Change(IPCC)assessmentreportingahigheraveragetemperatureincreaseacrossthelastcentury
FrontiersinSustainableCities|www.frontiersin.org 1 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
◦
of 1.59 C over land compared to ocean, and additionally surfacesandtheirvaryingtemperaturescriticalinunderstanding
statingthatcitieswillintensifyhuman-inducedwarminglocally radiant heat impacts. While finding shade from the sun is an
(IPCC, 2021). Heat is also increasing even more in urban obviousstrategytoreduceradiantheat,itisnearlyimpossiblefor
areas due to radiative trapping and anthropogenic emissions ahumantoadapttothediffuselongwaveheatsurroundingthem
of heat (Oke, 1982). These temperature increases all represent in the urban environment. In addition, even in the shade the
surfaceairtemperatures.Asweandothershaveshown,surface diffuseshortwaveradiationthatdiffuselyreflectsoffhigh-albedo
temperaturescaneasilybe>30 ◦ Cwarmerthanairtemperatures surfacesisalsonon-trivial.
◦
reaching extremes above 60 C (Yang and Li, 2015; Meggers In this paper we build on previous work that strives
et al., 2016; Middel and Krayenhoff, 2019; Aviv et al., 2021). to better characterize the invisible longwave radiant heat
We argue that the direct radiant heat transfer from these hot along with the shortwave components coming from all
surfaces not only add to the heat experienced from warmer directions. As demonstrated by the work of the mobile
urban air temperatures, but actually have significantly larger human-biometeorological station (MaRTy cart) experimentally
impacts than the warmer air on urban dwellers. In this paper in previous work at Arizona State University (ASU) in Tempe,
we will demonstrate new techniques that produce novel results Arizona (Middel and Krayenhoff, 2019), we can measure
describing the complex longwave, shortwave, and reflecting precisely the longwave and shortwave radiation using the 6-
components of radiant heat transfer as it bounces through the direction net radiometer setup, and move through a variety of
urbanenvironmentindependentofairtemperature. locations demonstrating that lateral longwave and shortwave
The general population largely associates heat with air radiation dominate heat experienced with invisible longwave
temperatures, but in warm climates the majority of heat being the dominant flux. This work showed that MRT reached
◦
experiencedbypeopleintheurbanenvironmentisintheform above75 C,andthatthesesiteswereaboveasphaltorconcrete.
of radiant heat transfer (Hoppe, 1992; Thorsson et al., 2007; It also demonstrated the benefits of green surfaces like trees
Johanssonetal.,2014;Middeletal.,2014;Lindbergetal.,2016). in reducing sky view factor and Mean Radiant Temperature
We have built human body heat models (Teitelbaum et al., (MRT). The 6-direction radiometer method provides averaged
2020), and built experimental radiant pavilions (Chen et al., directional readings of the Wm
−2
of radiation, but does not
2020; Teitelbaum et al., 2022), which have both demonstrated resolve the specific surfaces. In previous work at Princeton the
how as air temperatures approach skin temperature the body’s SphericalMotionAverageRadiantTemperature(SMaRT)sensor
necessarymetabolicheatrejectioncanbecomealmostcompletely wasdevelopedtoscanandmaplongwaveradiantheatemission
dependent on radiant heat heat transfer. We argue it is fromsurfaceswithahighresolutionthermalarray,whichenabled
therefore critical to explore new ways to model and measure analysis of the exact sources of radiant heat and resolving the
radiant heat transfer that include its complex geometric and exact location of hot surfaces and their geometry relative to
spectralproperties. potential occupants in space (Teitelbaum et al., 2016, 2017;
Houchois et al., 2019). With this work we were able to show
Background howradiantheatcanvarysignificantlyacrosssurfaces,andalso
Radiant heat transfer is the exchange of heat by the emission to calculate the distribution of MRT at any point in space as a
and absorption of electromagnetic radiation between surfaces. functionofthehighlyresolvedsurroundingsurfacetemperatures
Governed by blackbody radiation physics described by Planck, andgeometriesmeasuredbythesensor.Thisshowedthatindoor
◦
the temperature of surfaces drives the emission of thermal surfaces often varied by more than 10 C and MRT could vary
radiation, including between people and their surroundings. by > 2 ◦ C when moving just 2 feet (60cm) in a standard
Radiantheattransferoccursacrossthefullspectrumofradiation, heated office. The Princeton and ASU team initially brought
and as the emission is related to temperatures there are two the MaRTy cart and the SMaRT sensor platforms together to
dominant modes of radiant heat experienced: solar shortwave explore potential methods combining the high precision and
radiationandterrestriallongwaveradiation.Thesun,ataround high resolution aspects of each system in a 1-day experimental
5000K, emits shortwave light peeking around 0.5–1 micron campaign in Philadelphia on the Temple University campus
wavelengthsthatwehaveevolvedtoseewithoureyes,butthat (Aviv et al., 2021). As there were gaps in data produced by the
also brings around 1 kWm
−2
to the surface of the Earth. The systems, a simulation technique was added from collaborators
Earth,includingthoseofusexistingonit,areonlyaround300K at Penn that was informed by the results from both systems
andthereforeemitlargelyinthelongwavewavelengthsof8–15 to create spatial characterizations of the urban environment
micron, creating a dynamic exchange between surfaces on the that built on previous ray tracing techniques for longwave
planetthatisinvisibletothehumaneye. heat transfer (Aviv, 2019; Aviv et al., 2022). The modeling
For shortwave radiation there is an intuitive association techniques became integrated as a tool for data reduction and
of heat felt from the intense solar direct beam, and an analysisfromthetwosensorplatforms,whichhelpedtogenerate
understanding that black materials (low albedo and heat results that created a data-driven mapping of varying MRT
absorption) will absorb more of this heat than white materials throughout an outdoor space in the collaborative paper that
(high albedo and heat reflection). The longwave radiation is showed for the first time a method to combine high resolution
not visible to the human eye and it is not transmitted via an surface temperatures showing variations in MRT in space that
intensedirectbeam,butratherisdiffuselyemittedandexchanged couldbevalidatedagainstprecisenetradiometermeasurements
between surfaces, which makes the view factor to surrounding (Avivetal.,2021).
FrontiersinSustainableCities|www.frontiersin.org 2 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
The measurement and modeling of shortwave are both improvements to the methods. A significant limitation in
improved in this paper. Modeling the radiative exchanges on the first study was the inability of the SMaRT sensor to
and within urban surfaces can be done several ways. Some resolve any shortwave radiation as well as to record high
studiesonurbanclimatehaveintegratedraytracingtechniques resolution longwave scans in a short enough time period
into the urban canopy model. A neighborhood-scale multi- for the 1-day campaign, which resulted in significantly lower
layerurbancanopymodel(MUCM)combinedwithraytracing resolutionimages.
methodswasdevelopedtoaccountforshortwaveandlongwave ThisstudyusesanupdatedversionoftheSMaRTsensor,the
◦
radiation exchange in the urban canyon, but it is based on SMaRTShortwaveandLongwave(SMaRT-SL)thatrecords360
the two-dimensional canyon geometry and thus not feasible to shortwave and longwave panoramic images, which is deployed
use a detailed three-dimensional geometry model as the input alongside the MaRTy cart across locations at ASU in Tempe,
(Krayenhoff et al., 2013). Doan and Kusaka (2019) introduced Arizona for two hot clear days. It uses an updated modeling
a new MUCM also combined with a ray-tracing algorithm to technique to better address shortwave sky radiation as well
represent both shortwave and longwave radiative processes on as reflections. We aimed to produce results that help better
urban surfaces. The urban geometry model considers buildings characterize through measurement and modeling the relevance
and vegetation land as bulks with thermal properties. Based ofboththediffuseshortwavereflectionsalongwiththelongwave
on the urban canyon model, Rosado et al. (2017) proposed an emissions at a high geometric resolution. We hope this will
urban canyon albedo model (UCAM) to calculate the amount provide a more clear picture of how the built environment,
of radiantfluxaccountingfor threereflectionbounces, andthe and its planned and designed landscapes and buildings, have
resultsdemonstratedtheneedtousetheactualurbangeometry easily-overlooked radiant relationships to the heat experienced
formoreaccuratestudies.Anotherapproachisusingaraytracing byurbandwellers.
modeldirectly.Athree-dimensionalnumericalmodelbasedon Measuring radiant heat transfer is critical to understanding
ray tracing methods was developed by Yang and Li (2015) to urban heat, yet this highly variable phenomenon remains
predict a detailed urban surface temperature distribution. The often unexamined and underappreciated in its role affecting
urbangeometrymodelconsistsofnormalizedcells,representing people. Improving characterization of this phenomenon
different abstracted scenarios of building density, height and and moreover, making new tools and techniques more
arrangements. The aforementioned work took reflection and available to urban planners, designers, and architects will
urban albedo as important parameters when testing different create new opportunities to better address challenges of
scenarios. There are also studies investigating the influence of urban heat. We argue these exchanges have many nuances
shortwavereflectionsontheenergybalance(Vallatietal.,2018; including highly complex and variable heat impacts
Ali-Toudert, 2021). As an approach that can support detailed on people as they move through the geometry of the
urban geometry model, the solar and longwave environmental urbanfabric.
irradiance geometry (SOLWEIG) model can simulate spatial
variations of three-dimensional radiation fluxes in complex METHODOLOGY
urban settings with building digital elevation model as input
(Lindbergetal.,2008;LindbergandGrimmond,2011)andhas Experimental Setup and Locations
been testedin casesof different cities. For example, Chen et al. Experiments were carried out on May 18 and 19, 2021 on the
(2016) employed the SOLWEIG model to simulate the radiant ASU campus in Tempe Arizona. On each day the MaRTy cart
heat flux densities in several urban settings in Shanghai, which andSMaRT-SLsensorplatformsweresetupatdifferentlocations
showed good agreement with the six directional radiant flux in∼2hincrementsbetween8:00amand5:30pm.Readingswere
density measurements. Research on more land cover types and recordedfromeachdevice,panoramicphotos(seeFigure1)were
the exact contribution of reflection on the radiant heat flux takenofthesites,andthealbedoandemissivityofthesurfaces
arerequired. wereestimated.
Inthefieldofsolarradiationmeasurementstudieshavebeen There were five sites tested (see Figure1). These varied in
carriedoutusingnovelcombinationsofsensorstobetterresolve conditions from grass to concrete with varying levels of sky
sky radiation as demonstrated in published work (Blum et al., exposure. These were selected to try to achieve a variety of
2022). Here a precise pyranometer was combined with a sky representativescenarioswithvaryingsky,sun,horizon,ground
imager to improve the resolution of the precise data from the cover,andgroundtemperature.Thefivesitesweretestedacross
pyranometer. These sky imagers are inherently limited in their 2days.Onesitewasmeasuredonbothdaystohaveareference
accuracy due to their use of a CMOS sensor which does not (HaydenLawn).
respondproportionallytoWm
−2
ofirradiancebecauseoftheir First,theSMaRT-SLsensortookonecompletemeasurement
limitedspectralresponse. which took ∼16–17min to complete. Second, MaRTy is placed
at the same location and measures for ∼1min which includes
Objective 20s to account for the sensor lag of the net radiometers and
Theobjectiveofthispaperwastoaddresssomeofthelimitations temperaturesensor.DeployingandmeasuringwithbothMaRTy
of the initial collaboration combining the MaRTy, SMaRT, cart and SMaRT-SL sensor requires just below 20min per
and ray tracing simulations (Aviv et al., 2021), and to carry location.Measuringthreelocationsrequires∼1hincludingthe
out a more extensive field campaign to test and demonstrate walkbetweenlocations.
FrontiersinSustainableCities|www.frontiersin.org 3 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
FIGURE1|ExperimentlocationsonASUTempecampus.Panoramaimagesofeachlocationshowingthesurroundingsanddifferentconditions.
Onthefirstday,May18th,thesensorsweredeployedinthree
locations (1) The Hayden Lawn, a large open grass field, (2)
TheMUPVCanopy,anoutdoorseatingareaunderalargePV
shadestructure;(3)TheForestAveCOOR,aconcreteopenarea
in front of the Lattie F. Coor Hall at ASU. Five measurements
weremadeatHaydenlawn,SixattheMUPVCanopy,andfour
measurementsweremadeatForestAveCOORallspaced∼2h
apartwiththeHaydenandMUPVstartingbetween8and9am
withtheMUPVhavinganadditionaldatacollectionbetween9
and10amduetodatalossbetween8and9am.
On the second day, May 19th, the sensors were rotated
through three locations, again (1) Hayden Lawn (reference
location), (2) Parking lot, an open area dominated by asphalt
concrete, and (3) COOR canyon, a concrete walkway between
buildingsneartheCoorHall.
MaRTy Cart Mobile Net Radiometer
Platform
TheMaRTycartsetupisthesameasdescribedinourprevious
collaboration (Aviv et al., 2021), and as detailed in a first
experiment at ASU in Tempe (Middel and Krayenhoff, 2019).
Itisahuman-biometeorologicalplatform(Figure2),whichwas
custom-builttobeamobileplatformthatiseasilymovedfrom
FIGURE2|TheMaRTycartsensorplatform.
locationtolocation.
◦
The MaRTy sensor platform records location (lat/lon, ), air
temperature( ◦ C);relativehumidity(RH%);windspeed(m·s −1); determines MRT from combining net radiometer readings of
longwave(Wm
−2)andshortwave(Wm −2)radiantfluxdensities
directional shortwave and longwave radiation, weighting each
in a 6-directional Hukseflux NR-01 net radiometer setup. It directionaccordingtoangularfactorsofastandingpersonasper
FrontiersinSustainableCities|www.frontiersin.org 4 July2022|Volume4|Article869743

| Merchantetal. |     |     |     |     |     |     |     |     |     |     | ResolvingRadiant |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- |
TABLE1|Apogeesensorspecifications. The Apogee Instruments pyranometer and pyrgeometer are
|     |     |        |     |        | measured | using | an ADS1115 |     | 16 bit precision, | differential | ADC |
| --- | --- | ------ | --- | ------ | -------- | ----- | ---------- | --- | ----------------- | ------------ | --- |
|     |     | SL-510 |     | SP-510 |          |       |            |     |                   |              |     |
witharesolutionof3.9µV.Thepyrgeometerthermistorchannel
|     |     | Pyrgeometer |     | Pyranometer |              |     |          |        |           |            |           |
| --- | --- | ----------- | --- | ----------- | ------------ | --- | -------- | ------ | --------- | ---------- | --------- |
|     |     |             |     |             | is read with | a   | standard | 12-bit | ADC for a | resolution | of 0.8mV. |
Calibrationuncertainty 5% 5% ThesensorspecificationsanderrorsareshowninTable1.
|                          |     | <1% |     |     | The | Heimann | HTPA | 80x64d | R2  | L10.5/0.95 | F7.7HiC |
| ------------------------ | --- | --- | --- | --- | --- | ------- | ---- | ------ | --- | ---------- | ------- |
| Measurementrepeatability |     |     |     | 1%  |     |         |      |        |     |            |         |
thermopilearrayhas5,120elements,andafieldofviewof∼39
| Long-termdrift |     | <2%peryear |     | <2%peryear |     |     |     |     |     |     |     |
| -------------- | --- | ---------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
Non-linearity <1% <1% by31degrees.Thef/0.95lenshasaLWPcoatingwithacut-on
|                     |     |          |     |           | (Tr: 5%)    | at 7.7µm     | ± 0.3µm.   |      | The accuracy            | is ±3% | |TO – TA|   |
| ------------------- | --- | -------- | --- | --------- | ----------- | ------------ | ---------- | ---- | ----------------------- | ------ | ----------- |
| Spectralrange       |     | 5–30µm   |     | 385–2,105 |             |              |            |      |                         |        |             |
|                     |     |          |     | nm        | or ± 3K     | (whatever    | is larger) |      | for object temperatures |        | < 300 ◦ C   |
|                     |     |          |     |           | and ambient | temperatures |            | from | 5 to 50 ◦               | C, and | the NETD is |
| Temperatureresponse |     | <5%from  |     | <5%from   |             |              |            |      |                         |        |             |
|                     |     | −15to45C |     | −15–45C   | 140mK@1Hz.  |              |            |      |                         |        |             |
Windowheatingoffset <10W*m−2 <2W·m−2 The shortwave thermopile array sensor combines a lensless,
Uncertaintyindailytotal 5% 5% unfiltered thermopile array with a VIS-NIR coated achromatic
opticalfloatglasslenspair.Theresultisalow-resolutioncamera
withnear-flatspectralresponsefrom375to2500nm.TheHTPA
|     |     |     |     |     | 80x64d | R2 L0 | FCaF2 | thermopile | sensor | has an | ∼1mm thick |
| --- | --- | --- | --- | --- | ------ | ----- | ----- | ---------- | ------ | ------ | ---------- |
Equation1: CaF2 window to seal the device, which provides nearly flat
bandpassresponseacrossthe200µmto∼10,000µmrange.The
|     | 6   |        |     |     | focusinglensisaN-BAF10/N-SF5achromaticpairwith14mm |     |     |     |     |     |     |
| --- | --- | ------ | --- | --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- |
|     | W   | (a K + | aL) |     |                                                    |     |     |     |     |     |     |
T = 4 i=1 i k i i i −273.15K (1) focal length and 12.5mm diameter for an f-number of 1.15. A
| MRT |     | ∗     |     |     |     |     |     |     |     |     |     |
| --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     | s   | a l σ |     |     |     |     |     |     |     |     |     |
P VIS-NIR (400–1,000nm) anti-reflection coating reduces glare
acrosstheprimaryportionofthespectrum,andhasa50%signal
|     | =   | =   |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
where a k 0.70 and a i 0.97 are the unitless absorption range from 375 to 2,650nm. A rectangular lens hood further
coefficientsforshort-waveandlongwaveradiantfluxdensities,σ
|                                   |     |     |                       |     | reduces | lens flare, | an on-going |     | issue due | to the strength | of the |
| --------------------------------- | --- | --- | --------------------- | --- | ------- | ----------- | ----------- | --- | --------- | --------------- | ------ |
| istheStefan-BoltzmannconstantinWm |     |     | −2K −4,andtheunitless |     |         |             |             |     |           |                 |        |
directbeamsun.Finally,aservoactuatedshutter-flapisusedto
=
angular weighting factors of W i 0.06 for the up and down darkenthedeviceforzeroingandcalibrationofthermaloffsets.
facing sensors and W = 0.22 for the sensors pointing in each SeeFigure3foracutaway3-Dmodeloftheshortwavesensor.
i
cardinaldirection.
TheSMaRT-SLcancompleteafullsetofmeasurementsovera
15minperiod.Uponpowerup,thetripodbaseisusedtoalignthe
SMaRT-SL Short and Longwave Mapping sensorintheNorthdirection.Next,thesensorrotatestotheUp,
Webuildonpreviousworkdevelopingascanningmeanradiant North,East,South,WestandDowndirections,pausingateach
temperaturesensor(SMaRT)sensor.Thenewexpandedversion for ∼30s to record the Apogee Instruments Pyranometer and
includes short and longwave (SMaRT-SL) thermopile array Pyrgeometerreadings,creatingafull6-directionnetradiometer
detectors. It is composed of four directional radiative energy measurement with only two sensors. After this 6 direction
sensors mounted on a 2-axis rotation stage, capable of 360 measurement is completed, the shutter is closed on the SW
degrees of motion in the azimuthal direction and 180 degrees thermopilecameraandtherawvoltageoutputsofthethermopile
of motion in elevation for on-demand full spherical coverage are read and averaged over ∼30s. This provides the baseline
of all four sensors. In this implementation, servos are used to signal level offset due to the temperature dependent longwave
drive reduction gears on each rotation stage, allowing for high IRemissionoftheopticalelements.Afterthiscalibrationisrun,
directionalaccuracyandpowerandcommunicationcablepass- the device begins the panoramic scan, achieving full spherical
throughsinsidethecentersofthereductiongears.Thesystemis coveragefrom70imageswithsmalloverlapsoverabout8min.
controlledbyanArduinoDUEmicrocontroller. After the panorama is completed, a followup SWIR camera
The sensor package consists of: an Apogee Instruments SP- calibrationand6directionnetradiometryistaken.
| 510 Thermopile | pyranometer,      | an Apogee | Instruments         | SL-510 |          |     |        |       |            |     |     |
| -------------- | ----------------- | --------- | ------------------- | ------ | -------- | --- | ------ | ----- | ---------- | --- | --- |
|                |                   |           |                     |        | SMaRT-SL |     | Sensor | Image | Processing |     |     |
| pyrgeometer,a  | HeimannHTPA80x64d |           | R2L10.5/0.95F7.7HiC |        |          |     |        |       |            |     |     |
thermopile array thermal camera, and a novel custom-made The SMaRT-SL sensor raw data, in the form of a collection
thermopilearrayshortwavecamerausingaHTPA80x64dR2L0 of images, is post-processed to create a Lambert cylindrical
FCaF2thermopilesensor.Thenoveladditionofthisshortwave equal-areaprojectionofthefullscene.Thisprocessdistributes,
(here meaning UV to SWIR sensitivity) thermopile camera to upscales, smooths and averages the overlapping images, and
theconventionallongwaveIRthermalcameraallowsforexplicit also serves the important role of evenly distributing pixel data
directional and spatial quantification of all significant radiative points to have equal solid-angle view factors. The image pixels
components of thermal comfort. The single-value pyranometer are binned and spaced at integer values in a discrete uniform
and pyrgeometer measurements are then used as comparative distributioninthehorizontalandverticaldimensionsinthefinal
referencesignals,andthepyranometerwasadditionallyusedfor projection, assuring that in 3D vector space every pixel value
initial calibration of the sensitivity coefficient of the shortwave in the projection image has an equal solid-angle view factor.
thermopilesensor. Amatrixofcorresponding 3Dvectorcoordinatesissavedwith
FrontiersinSustainableCities|www.frontiersin.org 5 July2022|Volume4|Article869743

| Merchantetal. |     |     |     |     |     |     |     |     |     |     |     | ResolvingRadiant |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- |
FIGURE3|Shortwavesensorcrosssection,withshutterinclosedposition.Adaptablesystemusingc-mountcomponents,and3Dprintedlensshade.
| the image, | allowing | further | calculations | to  | then | be done in the |     |     |     |     |     |     |     |
| ---------- | -------- | ------- | ------------ | --- | ---- | -------------- | --- | --- | --- | --- | --- | --- | --- |
projectionspaceutilizingthisevenpointspread.
Togeneratetheplanarirradiancevaluesforagivendirection
fromtheSMaRT-SLdata,virtualpyranometerandpyrgeometer
modelswereusedtogeneratesingularnumbers.The3Dvector
| coordinates | of the | pixels were | used | to apply | Lambert’s | cosine |     |     |     |     |     |     |     |
| ----------- | ------ | ----------- | ---- | -------- | --------- | ------ | --- | --- | --- | --- | --- | --- | --- |
lawtoweightthedatapointswithinviewofthesimulatedplane.
Thisallowedthegenerationofnotonlycardinaldirectionplanar
| irradiance | values to | match | the experimental |     | pyranometer | and |     |     |     |     |     |     |     |
| ---------- | --------- | ----- | ---------------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
FIGURE4|DemonstrationofpixelcategorizationatHaydenLawnon
pyrgeometerdata,butofanyarbitraryplanedirectionaswell.
summedlongwaveandshortwaveirradianceimagewherepixelsclassifiedas
Afurtherinsightmadepossiblebyboththeuniqueresolution
“ground”areblackedout.
| and paired   | sensor         | setup  | of the       | SMaRT-SL | allowed | for very        |     |     |     |     |     |     |     |
| ------------ | -------------- | ------ | ------------ | -------- | ------- | --------------- | --- | --- | --- | --- | --- | --- | --- |
| accurate     | classification | of     | any given    | pixel    | in      | the projection  |     |     |     |     |     |     |     |
| of the scene | as having      | either | terrestrial, |          | sky,    | or direct solar |     |     |     |     |     |     |     |
origins. This was made possible by using logic that paired the experiments (8 am-4 pm, May 18th and 19th, 2021), and the
|          |               |         |     |        |          |             | direct normal | irradiance |     | and diffuse | horizontal | irradiance, | the |
| -------- | ------------- | ------- | --- | ------ | -------- | ----------- | ------------- | ---------- | --- | ----------- | ---------- | ----------- | --- |
| longwave | and shortwave | images: |     | if the | longwave | reading was |               |            |     |             |            |             |     |
◦
more than 25 C below ambient temperature the reading was model firstly generates the sky matrix for each simulation case.
classifiedas“sky,”iftheshortwavewasabove1,000W·sr −1·m −2 The resolution for determining the sun’s location is 1 hour.
|                 |                |     |            |        |         |               | The sun  | path and  | the sun | location | during | the experiments       | are |
| --------------- | -------------- | --- | ---------- | ------ | ------- | ------------- | -------- | --------- | ------- | -------- | ------ | --------------------- | --- |
| the reading     | was classified |     | as “direct | sun,”  | and all | other points  |          |           |         |          |        |                       |     |
|                 |                |     |            |        |         |               | shown as | Figure5A. | The     | hourly   | global | horizontal irradiance |     |
| were classified | as “ground.”   |     | This       | method | proved  | quite robust, |          |           |         |          |        |                       |     |
however further testing and refinement of the process may wascollectedinaweatherstationoftheArizonaMeteorological
be required for scenes with significant cloud cover. Figure4 Network, which is located in the central Phoenix and around
|              |                 |     |         |             |     |                  | 16 kilometers | away | from | the experimental |     | sites. However, | the |
| ------------ | --------------- | --- | ------- | ----------- | --- | ---------------- | ------------- | ---- | ---- | ---------------- | --- | --------------- | --- |
| demonstrates | the technique’s |     | ability | to classify |     | trees, buildings |               |      |      |                  |     |                 |     |
and the overall varying horizon line. This classification allows meteorological data does not include direct normal irradiance
for both the quantification in any given measurement of the and diffuse horizontal irradiance. In order to estimate the
|            |               |     |        |               |          |         | aforementioned | two | parameters, |     | the | Typical Meteorological |     |
| ---------- | ------------- | --- | ------ | ------------- | -------- | ------- | -------------- | --- | ----------- | --- | --- | ---------------------- | --- |
| individual | contributions | of  | direct | and reflected | sources, | as well |                |     |             |     |     |                        |     |
ascalculationofstatisticssuchasDiffuseHorizontalIrradiance Years (TMY) dataset provided by ISD (US NOAA’s Integrated
(DHI)andDirectNormalIrradiance(DNI). Surface Database) contains the irradiance data and was used
|     |     |     |     |     |     |     | as reference. | Based | on  | the combination |     | of the two | sources, |
| --- | --- | --- | --- | --- | --- | --- | ------------- | ----- | --- | --------------- | --- | ---------- | -------- |
Simulation Methods the estimated direct normal irradiance and diffuse horizontal
For shortwave irradiance simulation, a ray-tracing model irradiancewerecalibrated.
was constructed using Honeybee (version 0.66), a validated For the geometric modeling, the 3D model of buildings,
environmentalpluginintheRhino/Grasshopperalgorithmic3D land surfaces of different types and trees were built and the
modeling platform. With the inputs of the location (Phoenix, reflectivity coefficients of all surfaces were assigned based on
|     | ◦   | ◦   |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
USA, 33 25’ N, 111 56’ W), the dates and times of the measurements at each site after experiments with an ASD
FrontiersinSustainableCities|www.frontiersin.org 6 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
FIGURE5|(A)Thesunpathandsunlocationsduringthemeasurements;(B)SamplepointsdistributionofForestAvesite.
FieldSpec4Spectroradiometer,withreflectivityvaluesaveraged (Figure5B). Based on these inputs, the RADIANCE engine
overthe350–2,500nmwavelengthmeasurementrange:0.11for embedded in Honeybee was used to build a ray-tracing model
asphalt ground, 0.2–0.25 for pavement, 0.5 for vegetation, 0.3 forirradiancesimulation(Ward,1994).Theplaneirradianceof
for gravel, 0.4 for photovoltaic panels, 0.3 for concrete, 0.15 alltestingboxes’surfacescanbecalculated,basedonwhichthe
for brick, 0.2 for trees. For each simulation case, a spatial map meansphericalirradiancewascalculatedusingacubicmethod.
showing the mean spherical irradiance variation was created This simulation technique has been developed in our previous
with a testing plane at the height of 1.1m above the ground studies(Houetal.,2021).
representing the centroid of humans and the testing points In order to investigate the reflectivity of the surrounding
were generated in the resolution of 1m. Boxes centered on environmentanditsinfluenceontheirradiancereceivedonthe
the testing points were separated into six surfaces for plane ground,aparallelsetofsimulationswasconductedforeachcase
irradiancecalculationandtheresultscorrespondtotheeast,west, with the reflectivity coefficients of all surrounding surfaces as
south, north, upward and downward orientations, respectively 0 while keeping other settings unchanged. The parallel test still
FrontiersinSustainableCities|www.frontiersin.org 7 July2022|Volume4|Article869743

| Merchantetal. |     |     |     |     |     |     |     |     |     |     |     |     | ResolvingRadiant |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- |
includes the indirect irradiance from the sky rather than from temperaturechangingbyseveraldegrees.TheSMaRT-SLsensor
thesurfacesinthebuiltenvironmentsuchasbuildingenvelopes, dataallowsustonotonlycalculatetheradianttemperaturefields
sincethemaximumnumberofdiffusebouncescomputedbythe inmaindirections,buttonowvisualizetherolethatalldesigned
indirectcalculationwerefourforallcases. surfaces in an environment play in the thermal load placed on
peopleusingthespaces.
|     |     |     |     |     |     |     | The MUPV |     | canopy | presents | one | of the | most interesting |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | ------ | -------- | --- | ------ | ---------------- |
RESULTS
radiantdatasetsforourhighresolutionmeasurementcasestudy.
|                   |                  |               |        |          |              |         | The variation | of     | openings    | in    | the canopy       | and       | the significant |
| ----------------- | ---------------- | ------------- | ------ | -------- | ------------ | ------- | ------------- | ------ | ----------- | ----- | ---------------- | --------- | --------------- |
| We have           | selected sets of | results       | from   | the five | locations    | to best |               |        |             |       |                  |           |                 |
|                   |                  |               |        |          |              |         | heating       | of the | panels      | cause | unique shortwave |           | and longwave    |
| illustrate        | the novel data   | that          | can be | resolved | by combining |         |               |        |             |       |                  |           |                 |
|                   |                  |               |        |          |              |         | conditions.   | While  | the overall |       | amount of        | shortwave | is certainly    |
| these techniques. | The              | full datasets | will   | be made  | available    | and     |               |        |             |       |                  |           |                 |
reducedbythecanopyshading,thereisstillsignificantamounts
| submitted | as data-in-brief | and | posted | to a | github repository |     |     |     |     |     |     |     |     |
| --------- | ---------------- | --- | ------ | ---- | ----------------- | --- | --- | --- | --- | --- | --- | --- | --- |
ofshortwavethatarrivesthroughthegapsinthecanopy.Thiscan
| (chaos-laboratory/Resolving-Radiant-2022-Paper-Data). |     |     |     |     |     | We  |     |     |     |     |     |     |     |
| ----------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
largelybeavoidedbyusersasneededbecausethehotspotsclearly
| selected illustrative | datasets | collected |     | from the | Forest | Ave site |     |     |     |     |     |     |     |
| --------------------- | -------- | --------- | --- | -------- | ------ | -------- | --- | --- | --- | --- | --- | --- | --- |
registerinthevisibleimage,butwenotedthatourmeasurements
| next to theCOOR | building, | the | HaydenLawn,and |     | theMUPV |     |             |       |        |       |                 |     |               |
| --------------- | --------- | --- | -------------- | --- | ------- | --- | ----------- | ----- | ------ | ----- | --------------- | --- | ------------- |
|                 |           |     |                |     |         |     | even across | a few | inches | could | be dramatically |     | influenced by |
shadecanopy.Theseprovidearangeofshortwaveandlongwave
|            |             |          |             |     |           |     | the highly | variable | shadows |     | cast by the | system, | and passing |
| ---------- | ----------- | -------- | ----------- | --- | --------- | --- | ---------- | -------- | ------- | --- | ----------- | ------- | ----------- |
| conditions | that expose | the role | of longwave |     | outdoors, | and |            |          |         |     |             |         |             |
throughthespaceuserswouldstillexperiencethesesmallspaces
terrestrialsourcesofreflectedshortwave,bothofwhichareoften
ofshortwaveradiationaswellasthereflectionsfromthemwhich
| assumed | to be small relative |     | to direct | sky solar | radiation. | We  |               |     |            |      |        |                  |      |
| ------- | -------------------- | --- | --------- | --------- | ---------- | --- | ------------- | --- | ---------- | ---- | ------ | ---------------- | ---- |
|         |                      |     |           |           |            |     | are generally | not | considered | heat | source | but nevertheless | have |
showthattheyarenotonlysignificant,butthattheyhavehighly
aneffect.
variabledistributionsthataffecttheheatexperiencedbypeople
Whatismorecriticalandfullyunseenistheaddedlongwave
acrossshortareas,andmakeshadedareascapableofsignificant
|     |     |     |     |     |     |     | heat emitted | by  | the panels | as  | they are | heated | in the sun and |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ---------- | --- | -------- | ------ | -------------- |
heatstress.
radiatedowninthelongwave.Theshadedcanopyactuallyblocks
outtheskywithasurfacethatisashotashotpavement.While
| Longwave | and Shortwave |     |     | Radiant | Energy |     |     |     |     |     |     |     |     |
| -------- | ------------- | --- | --- | ------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
blockingthesuniscriticaltomitigateshortwave,therestofthe
| Spherical | Panoramas |     |     |     |     |     |     |     |     |     |     |     |     |
| --------- | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
skyactsasanimportantlongwaveradiantheatsink.TheSMaRT-
Wefirstpresenttheresultsofthelongwaveandshortwavehigh SL system can clearly display both the significant longwave
resolution scans collected by the SMaRT-SL platform. We have radiantheatfromthepanels,andthenalsoshowhowthesky’s
false-coloredtheimagessimilartothermalimaging,butinthis potentialasalongwaveradiantsink,orcooler,isalsoobstructed
|                   |                 |     |       | −1   | −2  |        |              |     |     |     |     |     |     |
| ----------------- | --------------- | --- | ----- | ---- | --- | ------ | ------------ | --- | --- | --- | --- | --- | --- |
| case the gradient | is representing |     | the W | · sr | · m | coming | bythepanels. |     |     |     |     |     |     |
fromthatdirection.Foreachsite,ForestAveinFigure6,Hayden
|         |              |      |            |     |                 |     | Longwave |     | Directional |     | Irradiance |     |     |
| ------- | ------------ | ---- | ---------- | --- | --------------- | --- | -------- | --- | ----------- | --- | ---------- | --- | --- |
| Lawn in | Figure7, and | MUPV | in Figure8 |     | we also include |     | a        |     |             |     |            |     |     |
visiblepanoramaforreferencetomakeiteasiertointerpretthe Next we present the results for the longwave data resolved
sources and structures that appear in the radiant panoramas. across principle directions for the various instruments for
Each image is a full 360 degree panorama, and the significant comparison in Figure9. We acquired longwave data similar
variationinthermalradiationisclear.InthecaseofForestAve to our previous work (Aviv et al., 2021) taking readings using
inFigure6thereareimagesfortwotimes,oneat11amandone the standard net radiometer measurements from MaRTy. For
at 3 pm. The shortwave changes dramatically from 11 am to 3 theSMaRT-SLsensoranimprovedarraydetectorenabledmore
pm as the sun passes behind the COOR building and creates a rapidacquisitionofhighresolutionlongwavepanoramas,which
largeshadedarea.Stillthereremainnon-insignificantsourcesof addressedoneoftheissuesinthefirstcollaborationwithMaRTy
reflectedshortwavethatareofsimilar,andinsomeareasgreater, where the SMaRT-SL scans took more than 30min and had
than the diffuse sky intensity. The longwave image is also very limitedresolution.ThelongwaveresultsareinFigure9fordata
interestingforForestAveasthebuildingplaysasignificantroleas fromtheMaRTycartandfromtheprocessedSMaRT-SLsensor
aheatsourceasdoesthehotconcreteontheground.At2pmthe longwave array, with the fraction from the sky and from the
shade creates an obvious reduction in shortwave, but although groundillustratedinastackedbar.TheApogeePyrgometerthat
the longwave has reduced without the direct heating from the was mounted on SMaRT-SL for additional verification did not
sunonthesurfaces,itstillrepresentsasignificantlyhighsource produceaccuratedata,mostlikelyduetooverheatinginthehot
ofradiantheat,andinthecaseofthebuilding,itisblockingwhat Arizonatemperatures.
wouldotherwisebethermallycoollongwavesky. The longwave data shows consistently higher values for the
· −2
The Hayden lawn data is representative of large open areas. terrestrial down direction, up to 615W m for the ground
The shortwave data again illustrates the significant reflection onForestAve,andtheskyintheupdirectionhaslowervalues
fromthesurroundingsurfaces.Herethelongwavecomponentis as expected, at 366W · m −2 for the sky on Forest Ave. This
moresignificantasthemajorshiftintemperaturefromthegrass MUPVcanopysignificantlyincreasestheupdirectionslongwave
to the concrete causes a major change in the radiant heat. The irradianceduetothehightemperaturePVpanelcanopy.Sowhile
radiantheatfromthegrasssurfacesisabout10–20%lowerthan providingshade,thePVcanopyactuallyhasthehighestlongwave
theconcretesurfaces.Thisshiftinheatofgoingfromstandingon heatimpactinthescene.Onecanalsoseetemporallytheeffect
thelawntostandingonconcretewouldbeequivalenttotheair of the Forest Ave COOR building shading the ground in the
FrontiersinSustainableCities|www.frontiersin.org 8 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
FIGURE6|ForestAveShortwave0.3–3µm(top)andLongwave7.7–20µm(middle)panoramaat11amfromtheSMaRT-SLsensorscan,(right)11amscanand
(left)3pmscan(bottom).Visualpanoramaat11amshowingtheCOORbuildingandmixtureofconcreteandgrasssurfaces.Lambertcylindricalequalareaprojection
used.
FIGURE7|(left)HaydenlawnShortwave(top)andLongwave(bottom)radiantenergypanoramaat2pmfromtheSMaRT-SLsensorscan.(right)Haydenlawnvisible
panoramaphotoat10am,showinggrasssurfaces,sidewalks,andconcretebuildings.Lambertcylindricalequalareaprojectionused.
afternoon causing a reduction in the longwave, while similarly ThereisgoodagreementbetweentheMaRTyandSMaRT-SL
to the MUPV canopy causing increased longwave in the UP data,withthebiggestdiscrepancycomingfromtheupdirection
direction due to the presence of the hot building and reduced wherethesignificantskyportionmaynotbereadwiththesame
viewtothecoolersky. spectral sensitivity by the detectors due to filter cutoffs of the
FrontiersinSustainableCities|www.frontiersin.org 9 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
FIGURE8|(left)MUPVcanopyshortwave(top)andlongwave(bottom)radiantenergypanoramaat2pmfromSMaRT-SLsensorscan,showingthesignificant
longwaveheat.(right)MUPVcanopyvisiblepanoramaphotoat10am.Lambertcylindricalequalareaprojectionused.
FIGURE9|Longwaveradiation,W·m−2,measuredat11amand3pmatForestAvebytheCOOR,andat2pmattheHaydenLawnandattheMUPVCanopy.
PlanarIrradiancevaluesarefromeachdirectionandtheoverallaverage,fromtheMaRTycart(leftbar)andtheSMaRT-SLarray(rightbar).TheSMaRTdataisbroken
intoskyandgroundcomponentsbyutilizingitsgreaterdegreeofresolution.
longwave sensors components, as well as differing error modes Shortwave Directional and Total Irradiance
suchasselfheating.Generallyanincreasedskyfractioncaused Theshortwaveimagingdatapresentanotherimportantextension
the SMaRT-SL reading to be reduced compared to the MaRTy from our previous work. The results of the new SMaRT-SL
reading.Still,theresultsareasignificantimprovementoverour shortwavearraysensoralsoshowrelativelygoodagreementfor
previousworkwiththetwosystems(Avivetal.,2021). Forest Ave at 10 am and Hayden lawn at 2 pm as shown in
FrontiersinSustainableCities|www.frontiersin.org 10 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
Figure10.Inthiscasewealsohaveadditionalcomparativedata sky radiation. The reflected sources of radiation ranged from
from the Apogee Pyrometer mounted on SMaRT-SL and from 10 to 70% of the total, with the open Hayden lawn receiving
theshortwavesimulationcarriedouttocompareresultsfromthe a more consistent range of 25–35%. In addition, one can see
SMaRT-SL array broken down into sky and reflected surfaces. boththetemporalanddirectionaldependenciesofthereflected
TheForestAve3pmandMUPVdataarebothshownondifferent shortwave.Acrossthethreelocations,reflectedshortwavewasa
scales because there was not direct sunlight, and in particular strong component of the total radiative heat load, with certain
that limited the shortwave intensity for the Forest Ave 3 pm localconditionslikehighlyreflectivebuildingscausingittoeven
data. It has a maximum of just over 100W · m −2, but in the become the dominant portion. By breaking the data down by
morninginthesunitwasnearly1,000W·m −2intheupwardsky direction,onecanseethatasimpleaccountingoftheshortwave
direction.TheMUPVdataillustratestheintenselocalvariations assimplybeingdrivenbydirectradiationfromtheskyishighly
possible due to the PV panel shading—small differences in the incomplete. Furthermore, the significant variations seen in this
physical size and location of the sensors yields highly variable datashowtheimportanceofmoreaccurateandspatiallyresolved
results.HaydenLawnillustrateshowthereflectedportionisboth accountingsprovidedbytheSMaRT-SLandsimulationmethods
dominatingandsignificantinthenorthandeastdirections—due to better understand the complex influences of the reflected
the clear skies, the diffuse shortwave radiation from the sky is radiativesources.
quite low. The comparison of Forest Ave at 11 am and 3 pm The north, south, east, and west directions provide insights
shows the significant differences of shading. On Forest Ave the intohowthesunreflectsoffofdifferentsurfacesthroughoutthe
sun went behind the building at 3 pm. both in the upwards day, and to the high variability of heat experienced from the
and downwards directions, with a further marked change of non-directsourcesofshortwaveradiation.Inallcasesthedown
thereflectedportionsinthecardinaldirectionsdominatingthe direction clearly only provided reflection, but interestingly the
overallradiativeload.ThevariationamongthedataatForestAve updirectionwasnotjustdirectandincludedreflectionsaswell.
at3pmislikelyduetotheincreaseddifficultyofparsingoutthe ThesewerecausedbyadjacentbuildingsandinparticularthePV
much lower overall signals from an accurate accounting of the canopysitehadsignificantreflection.
roughly 450W · m −2 incident on the thermopile sensors due ForFigure11AatForestAve,themeansphericalirradiance
totheradianttemperatureofthelongwave-emitting,shortwave keepsdecreasingfrom11am(whenitreachesthepeak320.4W·
transparent lens system. A similar error mode can be found in m
−2).Thepercentageofreflectedportioninthemeanspherical
lowintensitypyranometermeasurements. irradiance remains around 30%, with the highest as 32.9% at 3
A significant conclusion borne out by both the simulation pmandlowestas26.5%at5pm.Theavenueinthesouth-north
and the SMaRT-SL sensor data is in the significance of the direction has a high H/W ratio with buildings on both sides.
reflectedportionofthespectrumtotheoverallradiativeload.For Clusters of trees are on the north side. The concrete pavement
therespectivedatasetsshowninFigure10,asimpleaccounting and grass are reflective. From the east the reflected percentage
comparing the up and down pyranometer data shows the increases and reachesthe peak 83.2% (58.1W · m −2) at3 pm,
downwards reflected portion as 22.5, 18.2, 21, and 2.8% of the whenthedirectsunraycomesfromthesouthwestdirectionand
upwards direction, compared to a more accurate accounting of is reflected by the brick buildings, trees, grass and the concrete
the ratio of the total spherical irradiance as 32.4, 45.9, 33.5, pavement.Fromthewestthereflectedpercentageishighinthe
and36.7%byanaverageoftheSMaRT-SLandsimulationdata. morningandreachesthepeak91.6%(119.8W·m −2)at11am,
The simple pyranometer comparison belies the significance of and keeps decreasing after that, when the direct sun ray comes
the reflections to the overall radiative heat transfer in lacking fromthesoutheastdirectionandisreflectedbythebuildingwith
a more precise way of accounting for reflections. Furthermore, glass facade and the concrete pavement on the west side. From
theaccountingofreflectionsnotjustinthedownwardsdirection the north the irradiance reaches the peak 88.0 % (110.5W · m
holdssignificanceforhumanthermalcomfort,asthedownwards
−2)alsoat11am,andhasadecreasingtrendafterwards.From
direction has lesser impact on a standing human form (Rizzo the south the reflection percentage decreases to the lowest at 1
etal.,1991). pm,andincreasesafterthat.Thereflectionpercentageataround
4pm(∼47%)islowerthanthatinthelawn(51.3%)andunderthe
Shortwave Reflected Radiant Heat PV(62.3%).Forthetwoopensites,thereflectanceoftheconcrete
Figure11 shows the variation in the fraction of reflected pavementintheavenueislowerthanthatofgrassinthelawn.
shortwave. Here we have data taken directly from the SMaRT- The space under the PV shading structure has a brick building
SL as well as from the simulation, which were both able to andtreesonthesouthsidewhichmaycontributetoirradiance
resolve shortwave arriving from the sky and direct sun as well fromthesouthdirectionthroughmultiplebounces,resultingin
as shortwave reflected off terrestrial surfaces. There is again ahigherreflectionpercentage.
relatively good agreement between simulation and the sensor. ForFigure11BattheMUPV,theMeansphericalirradiance
The discrepancies arise when the scene is shaded and there is does not fluctuate much during the day, with the highest as
moresignificantvariationatthesiteofthemeasurement. 89.1W · m −2 at 12 pm and lowest as 56.9W · m −2 at 4
Improvingthemeasurementandunderstandingofshortwave pm. The percentage of reflected portion in the mean spherical
reflections is of particular interest because in practice the irradiancedoesnotvarymucheither,withthehighestas37.4%
reflection of shortwave radiation off of terrestrial surfaces is at12pmandlowestas30.3%at8am.Theirradiancefromthe
often considered insignificant relative to the direct solar and upwarddirection(224.4W·m −2)islowerthanthatinthelawn
FrontiersinSustainableCities|www.frontiersin.org 11 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
FIGURE10|Shortwaveradiation,W·m−2,measuredat11amand3pmatForestAvebytheCOOR,andat2pmattheHaydenLawnandattheMUPVCanopy.
Planarirradiancevaluesarefromeachdirectionandtheoverallaverage,fromtheMaRTycart(leftbar),theApogeePyranometer(middle-leftbar),SMaRTarray
(middle-rightbar),andthesimulationdata(rightbar).TheSMaRT-SLandsimulationdataarebrokenintodirectskyandreflectedgroundcomponentsbyutilizingtheir
greaterdegreeofresolution.
FIGURE11|ReflectedshortwavevariationacrosstimeandplanardirectionatForestAve(A),MUPV(B),andHaydenLawn(C).Solidlinesareproducedfromthe
simulationdata,anddashedlinesareproducedfromtheratioofreflectedgroundtodirectskymeasurementstakenfromtheSMaRT-SLsensor.
(797.6W·m −2)withoutshadeabove.BecauseofthePVpanels directsunraycomesfromthesouthwestdirectionandisreflected
shading above with only some gaps between panels allowing bythecolumnsmadeofbrickandsemi-transparentglassandthe
direct sunlight, the shortwave irradiance received from every pavement.Fromthewestthereflectedpercentageishighinthe
directionislowerthanthatintheopenspacesuchasthelawn. morningandreachesthepeak91.9%(35.3W·m −2)at12pm,
Fromtheeastdirectionthereflectedpercentageincreasesfrom8 andtheirradiancefromthenorthdirectionisrelativelyhighand
amandreachesthepeak87.6%(30.8W·m −2)at2pm,whenthe reachesthepeak94.2%(41.5W·m −2)alsoat12pm,whenthe
FrontiersinSustainableCities|www.frontiersin.org 12 July2022|Volume4|Article869743

| Merchantetal. |     |     |     |     |     |     |     |     |     |     |     |     | ResolvingRadiant |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- |
FIGURE12|[(A),left]SimulatedmeansphericalirradiancemapofForestAvesiteusingmodeledsitegeometry(top)simulatingwithinterreflections(left)orwithout
(right)surroundinginterreflectionsat3pm,May18.[(B),middle]Simulatedfromlocalgeometry(top)ofmeansphericalirradiancemapforHaydenLawnwith(left)or
without(right)surroundinginterreflectionsatHaydenLawnat10amonMay18.[(C),right]SimulationusinggeometryofMUPVsite(top)showingmeanspherical
irradiancemapwith(left)orwithout(right)surroundinginterreflectionsat12pm,May18.
direct sun ray comes from the south direction and is reflected TABLE2|Height-to-widthratio.
bythebrickbuilding,treesandthepavementonthenorthside.
The canyon in the west-east direction has a larger height-to- H/W Lawn MUPV ForestAvenue COOR Parkinglot
widthratio,whichresultsinhigherreflectionpercentageforthe
|     |     |     |     |     |     |     | East | 0.19 | /   | 0.23 |     | /   |     | 0.07 |
| --- | --- | --- | --- | --- | --- | --- | ---- | ---- | --- | ---- | --- | --- | --- | ---- |
northdirection.TheSouthreflectionpercentagedecreasesfrom
|          |            |        |       |         |           |             | West  | 0.1 | /    | 1.1 |     | /   |     | 0.04 |
| -------- | ---------- | ------ | ----- | ------- | --------- | ----------- | ----- | --- | ---- | --- | --- | --- | --- | ---- |
| 8 am and | reachesthe | lowest | at 12 | pm, and | increases | after that. |       |     |      |     |     |     |     |      |
|          |            |        |       |         |           |             | North | /   | 0.38 |     | /   | 0.8 |     | 0.1  |
Itisaround40–60%withmoredirectraysreceivedandmainly
|     |     |     |     |     |     |     | South | /   | 0.39 |     | /   | 0.4/2.1 |     | 0.5 |
| --- | --- | --- | --- | --- | --- | --- | ----- | --- | ---- | --- | --- | ------- | --- | --- |
reflectedfromthepavement.
| For Figure11C |     | at  | Hayden | Lawn the | mean | spherical |     |     |     |     |     |     |     |     |
| ------------- | --- | --- | ------ | -------- | ---- | --------- | --- | --- | --- | --- | --- | --- | --- | --- |
irradiancereachesthehighestataround12pm.Theirradiance
coming from the up direction makes the largest contribution. Simulation of Radiant Heat Variation
| The second | highest | is from | the south | direction | in compliance |     |            |     |              |     |     |     |     |     |
| ---------- | ------- | ------- | --------- | --------- | ------------- | --- | ---------- | --- | ------------ | --- | --- | --- | --- | --- |
|            |         |         |           |           |               |     | Reflection |     | Contribution |     |     |     |     |     |
withthedirectsunlightdirection.Thereflectedportionreaches
|               |            |           |              |           |             |           | A further     | ability      | of the | simulation      | method  | is         | to create | 2D      |
| ------------- | ---------- | --------- | ------------ | --------- | ----------- | --------- | ------------- | ------------ | ------ | --------------- | ------- | ---------- | --------- | ------- |
| the highest   | as 33%     | at around | 12–2         | pm. For   | the east    | direction |               |              |        |                 |         |            |           |         |
|               |            |           |              |           |             |           | spatial heat  | maps         | of the | total spherical |         | Irradiance | across    | a site  |
| the reflected | percentage |           | increases    | from 8 am | and reaches | the       |               |              |        |                 |         |            |           |         |
|               |            |           |              |           |             |           | as shown      | in Figure12. | These  | maps            | provide | useful     | context   | for     |
| peak 86.6%    | (107W      | · m       | −2) at 2 pm, | when      | the direct  | sun ray   |               |              |        |                 |         |            |           |         |
|               |            |           |              |           |             |           | the reflected | shortwave    | data   | points          | shown   | prior.     | One       | can see |
comesfromthesouthwestdirectionandisreflectedbythebrick
boththesignificantdifferenceinintensitybetweenjustthedirect
building,treesandgrassontheeastside.Forthewestdirectionit
incidentradiationcomparedtoafullaccountingwithreflections.
ishighinthemorningandreachesthepeak89.9%(119.8W·m
Thereflectedportioncanalsobeclearlyseenasastrongdriverof
−2)ataround10am-12pm,whenthedirectsunraycomesfrom
increasedspatialvariationintheoverallIrradianceacrossthesite.
| the southeast | direction |           | and is reflected | by         | the brick  | building, |            |     |              |     |            |     |     |     |
| ------------- | --------- | --------- | ---------------- | ---------- | ---------- | --------- | ---------- | --- | ------------ | --- | ---------- | --- | --- | --- |
| grass on      | the west  | side.     | From the         | north it   | is high at | 10 am     | -          |     |              |     |            |     |     |     |
|               |           |           |                  |            |            |           | Reflection |     | and Geometry |     | Comparison |     |     |     |
| 2 pm with     | the       | peak over | 90%, when        | the direct | sun ray    | comes     |            |     |              |     |            |     |     |     |
from the southeast/south/southwest direction and is reflected Between All Sites
by the trees on the north side. From the south there are less Table2providesanoverviewofthegeometryofthesiterelatedto
obstacles for the direct sunlight from the south direction, the theheightofsurroundinginfrastructure,terrain,orplantsforall
| reflection | percentage | is  | around 40–60%, | mainly | reflected | from |     |     |     |     |     |     |     |     |
| ---------- | ---------- | --- | -------------- | ------ | --------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
sitesinthefourhorizontaldirections.Table3givestheaverage
| thegrass. |     |     |     |     |     |     | reflectedfractionofshortwaveradiationforeverysite. |     |     |     |     |     |     |     |
| --------- | --- | --- | --- | --- | --- | --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
FrontiersinSustainableCities|www.frontiersin.org 13 July2022|Volume4|Article869743

| Merchantetal. |     |     |     |     |     |     |     |     |     |     |     |     |     | ResolvingRadiant |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- |
TABLE3|Averageofreflection. We have validated both the longwave and shortwave systems
|               |       |      |       |              |       |     |            | against           | simulation | with           | results     | from            | a precise   | pyrometer   |         |
| ------------- | ----- | ---- | ----- | ------------ | ----- | --- | ---------- | ----------------- | ---------- | -------------- | ----------- | --------------- | ----------- | ----------- | ------- |
|               |       | Lawn | MUPV  | Forestavenue | COOR  |     | Parkinglot |                   |            |                |             |                 |             |             |         |
|               |       |      |       |              |       |     |            | and pygometer     |            | net radiometer |             | setup. Compared |             | to a        | typical |
|               |       |      |       |              |       |     |            | globe thermometer |            | whose          | ISO 7726    | standard        | even        | recognizes  |         |
| MeanSpherical | 31.4% |      | 34.5% | 30.5%        | 25.9% |     | 18.1%      |                   |            |                |             |                 |             |             |         |
|               |       |      |       |              |       |     |            | that convective   |            | flows around   | the         | analog          | device      | don’t       | allow   |
| East          | 59.2% |      | 61.1% | 61.3%        | 63.7% |     | 57.4%      |                   |            |                | ◦           |                 |             |             |         |
|               |       |      |       |              |       |     |            | measurement       | better     | than           | ± 2 C,      | the systems     | we          | demonstrate |         |
| West          | 51.7% |      | 54.1% | 41.6%        | 39.4% |     | 28.7%      |                   |            |                |             |                 |             |             |         |
|               |       |      |       |              |       |     |            | can all           | produce    | radiant        | temperature | values          | independent |             | of      |
| North         | 79.8% |      | 83.1% | 70.0%        | 77.9% |     | 56.4%      |                   |            |                |             |                 |             |             |         |
◦
|       |       |     |       |       |       |     |       | convection | with | results | within | 1 C of | each other | across | the |
| ----- | ----- | --- | ----- | ----- | ----- | --- | ----- | ---------- | ---- | ------- | ------ | ------ | ---------- | ------ | --- |
| South | 41.3% |     | 44.9% | 41.5% | 39.7% |     | 34.8% |            |      |         |        |        |            |        |     |
platformstested.
| Up  |     | 1.6% | 6.9% | 2.8% |     | 4.0% | 1.1% |     |     |     |     |     |     |     |     |
| --- | --- | ---- | ---- | ---- | --- | ---- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
Theprinciplesetofresultsproducedfromtheexperimentsis
| Down | 99.9% |     | 100.0% | 100.0% | 100.0% |     | 99.9% |                    |     |     |                                  |     |     |     |     |
| ---- | ----- | --- | ------ | ------ | ------ | --- | ----- | ------------------ | --- | --- | -------------------------------- | --- | --- | --- | --- |
|      |       |     |        |        |        |     |       | asetofdataontheW·m |     |     | −2ofirradianceinbothshortwaveand |     |     |     |     |
Theboldvaluesindicatethehighestreflectedpercentageforagivendirectionacrossthe longwavefromtwodifferentsensorplatformsandasimulation.
differentsites. In contrast to many studies on radiant heat, we do not focus
|     |     |     |     |     |     |     |     | on translating | this      | into | a proxy of | Meat | Radiant     | Temperature. |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | --------- | ---- | ---------- | ---- | ----------- | ------------ | --- |
|     |     |     |     |     |     |     |     | While we       | recognize | the  | importance | of   | temperature | proxy        | to  |
Asummaryoftheoverallresultsofthereflectionsacrossall
|     |     |     |     |     |     |     |     | interpret | heat, | the directional | and | geometric | nature | of  | radiant |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ----- | --------------- | --- | --------- | ------ | --- | ------- |
sitesisasfollows:
heattransferisactuallylostwhenusingatemperatureproxythat
• leads most to an association with air temperature. The W · m
| Open | spaces | such | as the | Parking | Lot have | a relatively | low |     |     |     |     |     |     |     |     |
| ---- | ------ | ---- | ------ | ------- | -------- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
−2
percentage,whiletheLawnhasahighpercentagebecauseof coming from each direction represent important drivers of
−2has
reflectedradiation,thegrass. sensationfromradiantasymmetry,andtheoverallW·m
| •       |       |       |       |          |          |     |         | amoredirectrelationshiptoviewfactorandsurfacearea,which |     |     |     |     |     |     |     |
| ------- | ----- | ----- | ----- | -------- | -------- | --- | ------- | ------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| For the | other | three | sites | in urban | canyons, | the | shading |                                                         |     |     |     |     |     |     |     |
structure increases the reflection percentage of MUPV, arebothaspectsofradiantheattransferthatcanbeacteduponby
while its H/W ratio is lower than that of Forest Avenue urbandesignersforthecaseofsurfacesizes,andalsosomething
|     |     |     |     |     |     |     |     | that urban | dwellers | can | act upon | by being | either | informed | or  |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | -------- | --- | -------- | -------- | ------ | -------- | --- |
andCOOR.
•
ForestAvenuehasahighaveragereflectionpercentageinthe guided by program to areas where the less direct sources of
Eastdirection,duetotheconcretefacadeofthebuildingson radiantheatlikereflectedshortwaveandinfraredlongwavecan
| theeastsidenexttothereflectiveground. |     |             |     |            |            |     |          | beminimized. |           |               |     |         |         |      |        |
| ------------------------------------- | --- | ----------- | --- | ---------- | ---------- | --- | -------- | ------------ | --------- | ------------- | --- | ------- | ------- | ---- | ------ |
| •                                     |     |             |     |            |            |     |          | One          | challenge | of presenting |     | radiant | results | as W | · m −2 |
| MUPV                                  | has | the highest |     | reflection | percentage | in  | general, |              |           |               |     |         |         |      |        |
however the mean spherical irradiance is the lowest during is that since all surfaces are emitting, the positive values for
the day among all sites, which is attributed to the PV panels surfaces like the sky or cooler plants are counterintuitive. They
areemittingwatts,butcoolingbecausetheiremissionislessthan
| shading | above | with | only some | gaps | between | panels | allowing |     |     |     |     |     |     |     |     |
| ------- | ----- | ---- | --------- | ---- | ------- | ------ | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
directsunlight. thetemperatureofthereceivinghumanbody.Inouranalysiswe
• The reflection percentage of COOR is high especially in the intentionallyleftoutthetemperatureofthereceiver.Inthecase
Eastdirection,becausetheconcretefacadeofthebuildingon of the human body, the temperature is in the range of 30 ◦ C,
|           |      |             |     |         |                |     |            | andthusitisitselfemittingontheorderof500W·m |     |     |     |     |     |     | −2.Itis |
| --------- | ---- | ----------- | --- | ------- | -------------- | --- | ---------- | ------------------------------------------- | --- | --- | --- | --- | --- | --- | ------- |
| the north | side | contributes |     | much to | the reflection |     | especially |                                             |     |     |     |     |     |     |         |
when the sun ray comes in from the South direction. Even thenetnegativeexchangewithcoolersurfacesthatmakesthem
though the average reflection percentage of COOR in each cold.Butthisanalysisofnetexchangecanleadtoafocusonthe
longwaveexchangesandMRTanalysisthataretypicallydonefor
| direction | is  | not always | the | highest, | its peak | during | the day |     |     |     |     |     |     |     |     |
| --------- | --- | ---------- | --- | -------- | -------- | ------ | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
is always higher than that of other sites. Since there is indoorthermalcomfortinbuildings.Wearguethatbothindoors
less surface facing East or West, the reflection percentage andoutdoorsanindependentaccountingofthespatiallyresolved
is not always high during the day, resulting in the not so shortwaveandlongwaveradiantheatcanprovidemorespecific
andactionableinformationabouthowthesurroundingsurfaces
highaverage.
areimpartingWattsofheatuponalocation.Forexample,inthe
DISCUSSION AND FUTURE WORK caseofthePVcanopy,thetotalsphericallongwaveWattsarriving
|     |     |     |     |     |     |     |     | at a point | below | the panels | has | about double |     | the heat | being |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ----- | ---------- | --- | ------------ | --- | -------- | ----- |
As compared to the recent work evaluating longwave (Vanos deliveredinthelongwaveemissionfromthehotPVpanelsabove
et al., 2021), we have shown an alternative method to resolve than whatwould be delivered by thecool and clear skyhidden
behindthem,butstillonlyabouthalfofwhattheunshadeddirect
| longwave | radiation |     | with a | thermopile | array | system | using |     |     |     |     |     |     |     |     |
| -------- | --------- | --- | ------ | ---------- | ----- | ------ | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
moderate cost sensors that are not sensitive to convection sunintheshortwavewouldbe.However,ratherthandiminishing
as with analog devices such as black globe thermometers. theeffectofthelongwaveheatingofthepanels,thisfurtherbegs
|             |       |        |             |           |           |     |             | the question | of  | whether     | the geometry | of   | the shading | structure |     |
| ----------- | ----- | ------ | ----------- | --------- | --------- | --- | ----------- | ------------ | --- | ----------- | ------------ | ---- | ----------- | --------- | --- |
| Comparing   | the   | recent | work        | combining | pyrometer |     | data with   |              |     |             |              |      |             |           |     |
|             |       |        |             |           |           |     |             | could have   | had | less random | and          | more | strategic   | placement | of  |
| sky imaging | (Blum | et     | al., 2022), | we have   | shown     | an  | alternative |              |     |             |              |      |             |           |     |
method using a custom shortwave thermopile sensor that holes to both shade from the direct path of the sun path while
unlike a standard CMOS camera sensor provides an accurate exposingmoreclearskytocoolinthelongwave.Infuturework,
|          |          |             |     |     |               |             |     | we hope | to use | these tools | of analysis | to  | make | more informed |     |
| -------- | -------- | ----------- | --- | --- | ------------- | ----------- | --- | ------- | ------ | ----------- | ----------- | --- | ---- | ------------- | --- |
| and full | spectrum | measurement |     | of  | the shortwave | irradiance. |     |         |        |             |             |     |      |               |     |
FrontiersinSustainableCities|www.frontiersin.org 14 July2022|Volume4|Article869743

| Merchantetal. |     |     |     |     |     |     |     |     |     |     | ResolvingRadiant |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- |
physicaldesignandurbanplanningdecisionsbasednotjuston nuances of short and longwave radiant heat variation around
averagetemperatureproxies,butinformedbyahighlyresolved the hot Tempe, Arizona ASU campus, and in concert with a
understandingofradiantfluxes. scanning thermopile array detector we can further resolve the
As we have mentioned, we neglect the temperature of the precise sources of short and longwave heat across the exact
person, but that can be simply added in to estimate the net geometryofthesite.Thehighresolutiondatahasbeenvalidated
exchanges. What must also be recognized is the significance of throughdirectionalaveragingagainstthenetradiometerandalso
theformofthepersonorotherradiantreceiver.Thedirectional for the total spherical irradiance at the measurement location
resultsareallforplanarradiantfluxes,andourtotalresultsare withgoodagreementwithvariationrangingfrom10to20%for
−2,andmoresignificantrelativedifferenceat
for a spherical source receiving radiation from all directions. values>100W·m
In other work indoors we have modeled the human body lowervalueswheretheinternaldevicetemperatureshadamore
(Aviv et al., 2022), and we are working to better integrate the significantimpactontherelativelysmallmeasuredvalues.
geometryofthehumanbodyasitisinsertedintothesecomplex By resolving the shortwave radiation sources we can also
radiant fields. With modern computing power it is possible to differentiatethereflectedsourcesfromthegroundvsthedirect
use the ray tracing techniques used to simulate reflections to and diffuse sources from the sky. This was also validated using
include net interactions with more complex geometries of the a simulation to consider how interreflections of shortwave
actual person who may experience heat stress or significant contribute to the total radiant heat experienced at a location.
discomfort due to localized heating of different body parts, We were able to show the sensor could accurately measure the
and the higher resolution data provided by the SMaRT-SL is reflectedshortwaveandalsoshowthatitwasabove30%forthree
criticaltotheusethesetechniqueswhichbetteraccountforthe out of five sites when averaging the 4–5 measurements taken
| humanform. |     |     |     |     |     |     | throughouttheday. |     |     |     |     |     |
| ---------- | --- | --- | --- | --- | --- | --- | ----------------- | --- | --- | --- | --- | --- |
While our aim was to study the significance of shortwave In closing, we believe there is significant potential to better
reflections,wehavealsoshownthesignificanceofreflectionsin evaluate radiant heat fluxes as they affect urban dwellers in a
thelongwaveaswell(Avivetal.,2022).Thesebecomeevenmore varietyofways.Inthefuturewehopetheseimprovedtechniques
complexthoughbecausesurfaceemissivityandreflectivityinthe cancontributetobettercharacterizationandideallytoexposing
longwavecanbeevenmoredifficulttoevaluate.Still,reflections opportunitiestobetterrespondtothechallengespresentedinour
in the longwave offer yet another opportunity to engage with everwarmingurbanclimates.
radiantheat.
Lastly, all of this analysis is inherently dependent on an DATA AVAILABILITY STATEMENT
| understanding | of  | the surface | and | sky | properties. | This includes |     |     |     |     |     |     |
| ------------- | --- | ----------- | --- | --- | ----------- | ------------- | --- | --- | --- | --- | --- | --- |
shortwave reflectivities that were estimated, but also longwave The datasets presented in this study can be found in online
emissivities. There are also some spectral effects that may not repositories. The names of the repository/repositories and
beaccuratelycapturedwhereblackorgreybodyassumptionsare accessionnumber(s)canbefoundat:https://github.com/chaos-
made.WebelieveinfutureiterationsoftheSMaRT-SLwewillbe laboratory/Resolving-Radiant-2022-Paper-Data.
abletousethescanningofsurfacestonotonlycaptureradiant
| heat fluxes | from     | resolved | surfaces,  | but | to also      | capture     | surface |               |     |     |     |     |
| ----------- | -------- | -------- | ---------- | --- | ------------ | ----------- | ------- | ------------- | --- | --- | --- | --- |
|             |          |          |            |     |              |             | AUTHOR  | CONTRIBUTIONS |     |     |     |     |
| types and   | evaluate | the      | emissivity | and | reflectivity | of surfaces |         |               |     |     |     |     |
insitu.Thiswouldthenfeedforwardtoallowsimulationstobe CM, FM, MH, DA, FS, and AM planned the experiments
donequicklytodeterminetheradiantfluxatanypointinspace
|     |     |     |     |     |     |     | and contributed | to the interpretation |     | of  | the results. | FS and |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --------------------- | --- | --- | ------------ | ------ |
while accurately accounting for all reflections with measured AM carried out the experiments and provided and operated
materialproperties. their SMARTY cart sensor system. MH and DA planned and
|     |     |     |     |     |     |     | carried out | the simulations | and | corresponding | analysis. | CM  |
| --- | --- | --- | --- | --- | --- | --- | ----------- | --------------- | --- | ------------- | --------- | --- |
CONCLUSION conceived and built the novel scanning array sensor SMART-
|     |     |     |     |     |     |     | LS and planned | and carried | out | the novel | analysis | methods |
| --- | --- | --- | --- | --- | --- | --- | -------------- | ----------- | --- | --------- | -------- | ------- |
We have demonstrated a new method to improve how on the SMART-LS data. FM and CM took the lead in writing
| radiant heat | transfer | is  | resolved | in  | both the | shortwave | and             |         |           |                |     |             |
| ------------ | -------- | --- | -------- | --- | -------- | --------- | --------------- | ------- | --------- | -------------- | --- | ----------- |
|              |          |     |          |     |          |           | the manuscript, | with MH | providing | contributions. |     | All authors |
longwave spectral domains. It has long been recognized provided critical feedback and helped shape the research,
that the direct shortwave intense light from the sun causes analysis, and manuscript. All authors contributed to the article
significant heat, and that large warm surfaces can cause andapprovedthesubmittedversion.
| significant   | radiant     | heat    | in the    | longwave. |             | In combination |                |     |     |     |     |     |
| ------------- | ----------- | ------- | --------- | --------- | ----------- | -------------- | -------------- | --- | --- | --- | --- | --- |
| these present | significant |         | potential | risk      | for outdoor | heat           | stress FUNDING |     |     |     |     |     |
| and add       | to the      | thermal | burden    | and       | energy      | demand         | of             |     |     |     |     |     |
urbaninfrastructure.
|     |     |     |     |     |     |     | This study | was funded in | part | by the | US National | Science |
| --- | --- | --- | --- | --- | --- | --- | ---------- | ------------- | ---- | ------ | ----------- | ------- |
Thecombinationofnoveltoolsillustratehowhighprecision Foundation’s Sustainability Research Network Cooperative
net radiometry on a mobile platform can quickly evaluate Agreement#1444758.
FrontiersinSustainableCities|www.frontiersin.org 15 July2022|Volume4|Article869743

Merchantetal. ResolvingRadiant
REFERENCES
Middel, A., Häb, K., Brazel, A. J., Martin, C. A., and Guhathakurta, S.
(2014). Impact of urban form and design on mid-afternoon microclimate
Ali-Toudert, F. (2021). Exploration of the thermal behaviour and energy in Phoenix Local Climate Zones. Landsc. Urban Plan. 110, 113–122.
balance of urban canyons in relation to their geometrical and constructive doi:10.1016/j.landurbplan.2013.11.004
properties. Build. Environ. 188, 107466. doi: 10.1016/j.buildenv.2020. Middel,A.,andKrayenhoff,E.S.(2019).Micrometeorologicaldeterminantsof
107466 pedestrianthermalexposureduringrecord-breakingheatinTempe,Arizona:
Aviv,D.,Gros,J.,Alsaad,H.,Teitelbaum,E.,Voelker,C.,Pantelic,J.,etal.(2022). introducing the MaRTy observational platform. Sci. Total Environ. 687,
Adata-drivenraytracingsimulationformeanradianttemperatureandspatial 137–151.doi:10.1016/j.scitotenv.2019.06.085
variations in the indoor radiant field with experimental validation. Energy Oke,T.R.(1982).Theenergeticbasisoftheurbanheatisland.Q.J.R.Meteorol.
Buildings.254,111585.doi:10.1016/j.enbuild.2021.111585 Soc.108,1–24.doi:10.1002/qj.49710845502
Aviv,D.,Guo,H.,Middel,A.,andMeggers,F.(2021).Evaluatingradiantheatin Rizzo,G.,Franzitta,G.,andCannistraro,G.(1991).Algorithmsforthecalculation
anoutdoorurbanenvironment:Resolvingspatialandtemporalvariationswith ofthemeanprojectedareafactorsofseatedandstandingpersons.EnergyBuild.
twosensingplatformsanddata-drivensimulation.UrbanClimate35,100745. 17,221–230.doi:10.1016/0378-7788(91)90109-G
doi:10.1016/j.uclim.2020.100745 Rosado,P.J.,Ban-Weiss,G.,Mohegh,A.,andLevinson,R.M.(2017).Influenceof
Aviv, D. H. (2019). “Thermal reality capture. ACADIA 19:UBIQUITY AND streetsetbacksonsolarreflectionandaircoolingbyreflectivestreetsinurban
AUTONOMY,”inProceedingsofthe39thAnnualConferenceoftheAssociation canyons.SolarEnergy144,144–157.doi:10.1016/j.solener.2016.12.026
for Computer Aided Design in Architecture (ACADIA) (Austin, TC: The Teitelbaum,E.,Alsaad,H.,Aviv,D.,Kim,A.,Voelker,C.,Meggers,F.,etal.(2022).
UniversityofTexasatAustinSchoolofArchitecture),338–345.Availableonline Addressingasystematicerrorcorrectingforfreeandmixedconvectionwhen
at:http://papers.cumincad.org/cgi-bin/works/paper/acadia19_338 measuringmeanradianttemperaturewithglobethermometers.Sci.Rep.12,
Blum, N. B., Wilbert, S., Nouri, B., Lezaca, J., Huckebrink, D., Kazantzidis, 6473.doi:10.1038/s41598-022-10172-5
A., et al. (2022). Measurement of diffuse and plane of array irradiance by Teitelbaum,E.,Chen,K.W.,Aviv,D.,Bradford,K.,Ruefenacht,L.,Sheppard,
a combination of a pyranometer and an all-sky imager. Solar Energy 232, D.,etal.(2020).Membrane-assistedradiantcoolingforexpandingthermal
232–247.doi:10.1016/j.solener.2021.11.064 comfortzonesgloballywithoutairconditioning.Proc.Nat.Acad.Sci.U.S.A.
Chen,K.W.,Teitelbaum,E.,Meggers,F.,Pantelic,J.,andRysanek,A.(2020). 117:21162–21169.doi:10.36227/techrxiv.12034971
Exploring membrane-assisted radiant cooling for designing comfortable Teitelbaum, E., Guo, H., Read, J., and Meggers, F. (2017). “Mapping comfort
naturally ventilated spaces in the tropics. Build. Res. Infm. 49, 483–495. withtheSMART(SphericalMotionAverageRadiantTemperature)sensor,”in
doi:10.1080/09613218.2020.1847025 Proceedingsofthe15thIBPSAConference.Availableonlineat:http://www.ibpsa.
Chen,L.,Yu,B.,Yang,F.,andMayer,H.(2016).Intra-urbandifferencesofmean org/proceedings/BS2017/BS2017_644.pdf(accessedMay30,2022).
radianttemperatureindifferenturbansettingsinShanghaiandimplicationsfor Teitelbaum,E.,Read,J.,andMeggers,F.(2016).SphericalMotionAverageRadiant
heatstressunderheatwaves:aGIS-basedapproach.EnergyBuild.130,829–842. TemperatureSensor(SMARTSensor).ExpandingBoundaries:SystemsThinking
doi:10.1016/j.enbuild.2016.09.014 fortheBuiltEnvironment.(Zurich).
Doan, Q.-V., and Kusaka, H. (2019). Development of a multilayer urban Thorsson,S.,Lindberg,F.,Eliasson,I.,andHolmer,B.(2007).Differentmethods
canopy model combined with a ray tracing algorithm. SOLA 15, 37–40. forestimatingthemeanradianttemperatureinanoutdoorurbansetting.Int.
doi:10.2151/sola.2019-008 J.Climatol.27,1983–1993.doi:10.1002/joc.1537
Hoppe,H.(1992).Anewproceduretodeterminethemeanradianttemperature Vallati, A., Mauri, L., and Colucci, C. (2018). Impact of shortwave multiple
outdoors.WetterUntLeben44,147–151. reflectionsinanurbanstreetcanyononbuildingthermalenergydemands.
Hou,M.,Pantelic,J.,andAviv,D.(2021).SpatialanalysisoftheimpactofUVGI EnergyBuild.174,77–84.doi:10.1016/j.enbuild.2018.06.037
technologyinoccupiedroomsusingray-tracingsimulation.IndoorAir.31, Vanos, J. K., Rykaczewski, K., Middel, A., Vecellio, D. J., Brown, R. D., and
1625–1638. Gillespie, T. J. (2021). Improved methods for estimating mean radiant
Houchois, N., Teitelbaum, E., Chen, K. W., Rucewicz, S., and Meggers, F. temperatureinhotandsunnyoutdoorsettings.Int.J.Biometeorol.65,967–983.
(2019).TheSMARTsensor:fullycharacterizingradiantheattransferinthe doi:10.1007/s00484-021-02131-y
built environment. J. Phys.s 1343, 012073. doi: 10.1088/1742-6596/1343/1/ Ward, G. J. (1994). “The Radiance lighting simulation and rendering system,”
012073 in Proceedings of the 21st Annual Conference on Computer Graphics and
IPCC. (2021). Summary for Policymakers. Climate Change 2021: The Physical InteractiveTechniques.(NewYork,NY).doi:10.1145/192161.192286
Science Basis. Contribution of Working Group I to the Sixth Assessment Yang,X.,andLi,Y.(2015).Theimpactofbuildingdensityandbuildingheight
Report of the Intergovernmental Panel on Climate Change. IPCC. Available heterogeneityonaverageurbanalbedoandstreetsurfacetemperature.Build.
onlineat:https://www.ipcc.ch/report/ar6/wg1/downloads/report/IPCC_AR6_ Environ.90,146–156.doi:10.1016/j.buildenv.2015.03.037
WGI_SPM_final.pdf(accessedMay30,2022).
Johansson,E.,Thorsson,S.,Emmanuel,R.,andKrüger,E.(2014).Instrumentsand Conflict of Interest: CM and FM are working to potentially commercialize
methodsinoutdoorthermalcomfortstudies–theneedforstandardization. technologybasedonandrelatedtosensorsdevelopedaspartofthiswork.
UrbanClimate10,346–366.doi:10.1016/j.uclim.2013.12.002
Krayenhoff, E., Christen, A., Martilli, A., and Oke, T. (2013). A multi-layer Theremainingauthorsdeclarethattheresearchwasconductedintheabsenceof
radiationmodelforurbanneighbourhoodswithtrees.UrbanClimateNews anycommercialorfinancialrelationshipsthatcouldbeconstruedasapotential
151,139–178.doi:10.1007/s10546-013-9883-1 conflictofinterest.
Lindberg,F.,andGrimmond,C.S.B.(2011).Theinfluenceofvegetationand
buildingmorphologyonshadowpatternsandmeanradianttemperaturesin Publisher’sNote:Allclaimsexpressedinthisarticlearesolelythoseoftheauthors
urbanareas:modeldevelopmentandevaluation.Theor.Appl.Climatol.105, anddonotnecessarilyrepresentthoseoftheiraffiliatedorganizations,orthoseof
311–323.doi:10.1007/s00704-010-0382-8
thepublisher,theeditorsandthereviewers.Anyproductthatmaybeevaluatedin
Lindberg, F., Holmer, B., and Thorsson, S. (2008). SOLWEIG 1.0 –
thisarticle,orclaimthatmaybemadebyitsmanufacturer,isnotguaranteedor
modelling spatial variations of 3D radiant fluxes and mean radiant
endorsedbythepublisher.
temperature in complex urban settings. Int. J. Biometeorol. 52, 697–713.
doi:10.1007/s00484-008-0162-7
Lindberg,F.,Onomura,S.,andGrimmond,C.S.B.(2016).Influenceofground Copyright©2022Merchant,Meggers,Hou,Aviv,SchneiderandMiddel.Thisisan
surfacecharacteristicsonthemeanradianttemperatureinurbanareas.Int.J. open-accessarticledistributedunderthetermsoftheCreativeCommonsAttribution
Biometeorol.60,1439–1452.doi:10.1007/s00484-016-1135-x License(CCBY).Theuse,distributionorreproductioninotherforumsispermitted,
Meggers, F., Aschwanden, G., Teitelbaum, E., Guo, H., Salazar, L., and providedtheoriginalauthor(s)andthecopyrightowner(s)arecreditedandthatthe
Bruelisauer, M. (2016). Urban cooling primary energy reduction potential: originalpublicationinthisjournaliscited,inaccordancewithacceptedacademic
system losses caused by microclimates. Sustai. Cities Soc. 27, 315–323. practice.Nouse,distributionorreproductionispermittedwhichdoesnotcomply
doi:10.1016/j.scs.2016.08.007 withtheseterms.
FrontiersinSustainableCities|www.frontiersin.org 16 July2022|Volume4|Article869743
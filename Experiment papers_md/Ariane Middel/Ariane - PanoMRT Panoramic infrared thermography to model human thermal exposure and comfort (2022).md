ScienceoftheTotalEnvironment859(2023)160301
ContentslistsavailableatScienceDirect
Science of the Total Environment
journal homepage: www.elsevier.com/locate/scitotenv
PanoMRT: Panoramic infrared thermography to model human thermal
exposure and comfort
⁎
ArianeMiddela,b, ,MatthewHuffb,E.ScottKrayenhoffc,AnanthUdupad,FlorianA.Schneidere
aSchoolofArts,MediaandEngineering,ArizonaStateUniversity,USA
bSchoolofComputingandAugmentedIntelligence,ArizonaStateUniversity,USA
cSchoolofEnvironmentalSciences,UniversityofGuelph,Canada
dTheDesignSchool,ArizonaStateUniversity,USA
eSchoolofSustainability,ArizonaStateUniversity,USA
H I G H L I G H T S G R A P H I C A L A B S T R A C T
• PanoMRTcalculatesoutdoorthermalex-
posureandcomfortfrompanoramicinfra-
redthermography.
• Surfacetemperaturesincitiesvarywidely
duetoheterogeneousmaterialsandshade
patterns.
• 3Dsurfacetemperatureinformationsig-
nificantlyimprovesmeanradianttemper-
aturemodels.
A R T I C L E I N F O A B S T R A C T
Editor:ScottSheridan Assummerheatwavesbecomethenewnormalworldwide,modelinghumanthermalexposureandcomforttoassess
andmitigateurbanoverheatingiscrucialtoupholdlivabilityincities.WeintroducePanoMRT,anopensourcehuman-
Keywords: biometeorologicalmodeltocalculateMeanRadiantTemperature(T ),PhysiologicallyEquivalentTemperature
MRT
Thermalexposure (PET),andtheUniversalThermalClimateIndex(UTCI)fromthermalequirectangular360°panoramasandstandard
Meanradianttemperature
weatherinformation(airtemperature,relativehumidity,windspeed).Wevalidatedthemodelforhot,dry,clearsum-
Infraredthermalpanoramas
merdaysinTempe,Arizona,USAwithin-situobservationsusingaFLIRDuoProRthermalcameraonarotatingarm
Human-biometeorologicalobservationsand
modeling andthemobilehuman-biometeorologicalinstrumentplatformMaRTy.WeobservedandmodeledT MRT andthermal
comfortfor19siteswithvaryinggroundcover(grass,concrete,asphalt),skyviewfactor,exposure(sun,shade),
andshadetype(engineered,natural)sixtimesperday.PanoMRTperformedwellwithaRootMeanSquareError
(RMSE)of4.1°CforT ,2.6°CforPET,and1.2°CforUTCI,meetingtheaccuracyrequirementof±5°Csetin
MRT
theISO7726standardforheatandcoldstressstudies.RayManreferencemodelrunswithoutmeasuredsurfacetem-
peratureforcingrevealthataccuratelongwaveradiativefluxestimationsarecrucialtomeetthe±5°Cthreshold,par-
ticularlyforshadedlocationsandduringmiddaywhensurfacetemperaturespeakandlongwavemodelingerrorsare
largest.Thisstudydemonstratestheimportanceofspatiallyresolved3Dsurfacetemperaturedataforthermalexposure
andcomfortmodelingtocapturecomplexlongwaveradiationexposurepatternsresultingfromheterogeneityinbuilt
configurationandmaterialradiativeandthermalpropertiesinthebuiltenvironment.
⁎
Correspondingauthorat:SchoolofArts,MediaandEngineering,SchoolofComputingandAugmentedIntelligence,ArizonaStateUniversity,950S.ForestMall,StaufferB,Tempe,AZ85281,
USA.
E-mailaddresses:ariane.middel@asu.edu(A.Middel),mwhuff@asu.edu(M.Huff),skrayenh@uoguelph.ca(E.S.Krayenhoff),audupa@asu.edu(A.Udupa),florian.schneider@asu.edu
(F.A.Schneider).
http://dx.doi.org/10.1016/j.scitotenv.2022.160301
Received16August2022;Receivedinrevisedform25October2022;Accepted15November2022
Availableonline18November2022
0048-9697/©2022TheAuthors.PublishedbyElsevierB.V.ThisisanopenaccessarticleundertheCCBY-NC-NDlicense(http://creativecommons.org/licenses/by-nc-nd/4.0/).

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
Abbreviations and negatively impacts the economy (Xia et al., 2018; Zander et al.,
2015).Hotterweatherisexpectedinthefuture(Russoetal.,2014),with
A atmosphericradiation[Wm−2] morefrequentandintenseheatwavesthatmayjeopardizethelivability
D diffuseshortwaveradiation[Wm−2] andsustainabilityofcities.Keepingpeoplecoolthroughtargetedheat
D isotropicdiffuseshortwaveradiation[Wm−2] mitigationinterventionsisapriorityofthe21stcentury(Broadbentetal.,
iso
D anisotropicdiffuseshortwaveradiation[Wm−2] 2022;Jayetal.,2021).
aniso
f skyviewfactor[−] Whileheatcanbequantifiedusingvarioustemperaturemetrics,oneof
SVF
F angular weighting factor for standing reference person for themostrelevantmetricstoassesshumanthermalexposureistheMean
i
radiationincidentfromdirectioni(0.22forN,E,S,W;0.06for RadiantTemperature(T ),asitprovidesanimportantsummaryassess-
MRT
up/down)[−] mentoftheradiationexchangebetweenthehumanbodyandthebuilt
G globalshortwaveradiation,f =1,cloudless[Wm−2] environment(ISO,1998;Johanssonetal.,2014;KántorandUnger,2011;
0 SVF
i indexthatdenotesdirections(N,E,S,W,up,down) Middeletal.,2016).T isasyntheticparameterthatquantifiesthe
MRT
I directshortwaveradiationonahorizontalsurface[Wm−2] heatloadonthehumanbodythroughweightedomnidirectionalshortwave
I′ directshortwaveradiationonasurfaceperpendiculartothe andlongwaveradiationfluxdensities.Underhot,dry,clear-skyweather
Sun[Wm−2] conditions, T is the main meteorological factor that drives spatial
MRT
I solarconstant(1367)[Wm−2] variationofhumanthermalcomfort(Linetal.,2010)andanimportant
0
I extraterrestrialradiation[Wm−2] parameterinmanythermalcomfortindicesthatincorporateradiative
0
K directionalshortwaveradiation(idenotesN,E,S,W,up,down) exposure, such as the Physiological Equivalent Temperature (PET)
i
[Wm−2] (Höppe,1999)andUniversalThermalComfortIndex(UTCI)(Blazejczyk
K↓,K↑,K→ directionalshortwaveradiation(arrowindicatesdirection) etal.,2012;Fialaetal.,2012;Jendritzkyetal.,2012).
[Wm−2] T
MRT
variessignificantlyinthebuiltenvironmentwithreporteddiffer-
L directionallongwaveradiation(idenotesN,E,S,W,up,down) encesofover35°Cintheafternoonshadeandsun(Middeletal.,2021).
i
[Wm−2] WhilespatialandtemporalvariationofT
MRT
ismostlydrivenbyshortwave
L sky longwaveradiationforskypixelsinthermalpanorama[Wm−2] radiation,laterallongwaveradiationisthelargestcontributortoT MRT in
L longwave radiation for non-sky pixels in thermal panorama warmclimates(MiddelandKrayenhoff,2019).Lindbergetal.(2014)
pixel
[Wm−2] showed that longwave fluxes become increasingly important in dense
m relativeopticalairmass builtenvironmentswithincreasedradiantfluxesfromwalls,highlighting
RO
N degreeofcloudiness[octas] theimportanceofverticalsurfacetemperatures(T s )forhumanthermal
PET physiologicallyequivalenttemperature[°C] exposure.Stewartetal.(2021)introducedtheconceptofpedestrian
R meanradiantfluxdensity[Wm−2] surfacetemperature(T ped ),whichistheweightedaverageofallsurfaces
RH relativehumidity[%] surroundingastreet-levelpedestrianandismorerelevanttohuman
T a airtemperature[°C] thermalexposurethanhorizontalT s observedfromaboveusingsatellite
T Linketurbidityfactor(4.2)[−] thermalimagery.
L
T pedestriansurfacetemperatureatstreetlevel[°C] Thebuiltenvironmentisacomplexpatchworkofdifferentlyoriented
ped
T surfacetemperature[°C] surfacetypeswithvaryingdiurnalsun-exposureandradiative,thermal,
s
T meanradianttemperature[°C] roughness,andmoisturecharacteristics,whichleadstosignificantvaria-
MRT
UTCI UniversalThermalClimateIndex tionsofT s patchesthatcontributetoT ped intheurbancanopylayer.Accu-
v windvelocity[ms−1] rate T s estimates are important forthermal exposureassessments, but
V p vaporpressure[hPa] spatiallyexplicitT s havenottraditionallybeenobservedinurbanclimate
z altitude[m] studiesandaredifficulttomodelwithoutdetailed3-dimensionalinforma-
α albedo(0.15)[−] tiononthecompositionandconfigurationofthoseT
s
patches.
δ opticalthickness TheemergingfieldofUrbanClimateInformatics(Middeletal.,2022)
RO
ε standardemissivity(0.95[−] offers novel sensing techniques and embraces more integrated and
ε emissivityofthehumanbody(0.97)[−] human-centricmethods,includingapproachestosensespatiallyresolved
p
η Sun'saltitude(elevation)angleabovethehorizon[°] T s intheurbancanopylayer.Forexample,Avivetal.(2021)usedarotating
ϕ solarzenithangle[°] non-contactinginfraredT s sensorandLiDARtocreate3-dimensionalT s
θ azimuthangle[°] pointclouds.Merchantetal.(2022)developedacamerasystemthatre-
ξ absorptioncoefficientforshortwaveradiation(0.7)[−] cords360°shortwaveandlongwavepanoramicimagestofullyresolve
k
ρ localatmosphericpressure[hPa] thespatialvariationinshortwaveandlongwaveradiantheattransferin
ρ atmosphericpressureatsealevel(1013)[hPa] theoutdoorenvironment.
0
σ Stefan-Boltzmanconstant(5.670367∙10−8)[Wm−2K−4] WepresentaninstrumentsetuptomeasureanapproximationofT
ped
in
τ transmittanceofdirectsolarradiation[−] the form of thermal equirectangular 360° panoramas and introduce
PanoMRT,anopensourcehumanthermalexposureandcomfortmodel
thatcalculatesT ,PET,andUTCfromstandardmeteorologicalinforma-
MRT
tionanddetailedT observations.Modelresultsarevalidatedusingthe
s
1.Introduction mobile6-directionalinstrumentsetupMaRTy(MiddelandKrayenhoff,
2019)andcomparedtoRayManT calculationswithoutT forcingto
MRT s
Landuseandlandcoverchangefromurbanizationcoupledwithclimate demonstratetheimportanceofspatiallyexplicit,human-centricT data
s
changeleadstourbanoverheating,i.e.thermalconditionsincitiesthatare forhumanthermalexposureandcomfortmodeling.
hazardoustopeopleandassociatedurbansystems(Nazarianetal.,2022).
Heathasmyriadnegativeimpactsonhumanhealth(Gasparrinietal., 2.Methods
2015;LuberandMcGeehin,2008),comfort(Kurasetal.,2017;Middel
etal., 2016),productivity (Dunneetal., 2013;KjellstromandCrowe, PanoMRTisaPython-basedsoftwarethatcalculatesT fromob-
MRT
2011),andperformance(Alhadadetal.,2019;Kosakaetal.,2018).It servedlongwaveradiationfluxesandmodeledshortwaveradiationfluxes
alsoincreasescoolingenergyuse(Lietal.,2012),wateruseforirrigation simulatinga6-directionalnetradiometersetupforintegralradiationmea-
(Jeneretteetal.,2011),stressesurbaninfrastructure(Clarketal.,2019), surements.TomodelT foragivenlocation,time,andday,PanoMRT
MRT
2

| A.Middeletal. |     |     |     |     |     | ScienceoftheTotalEnvironment859(2023)160301 |     |
| ------------- | --- | --- | --- | --- | --- | ------------------------------------------- | --- |
requiresa360°equirectangularthermalpanoramaofthelocationand I iscalculatedusingthesolarconstantI =1367Wm−2anddayofyear
|     |     |     |     | 0   |     | 0   |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
standardweatherinformation(Fig.1).Thethermalpanoramaisprojected (DOY)todeterminethelengthofthepath(theairmass)theradiation
intosixfisheyeimagestocalculateintegrallongwaveradiationfluxesfrom musttravel.Toconsideratmosphericabsorptionandscatteringofthein-
pixelsurfacetemperaturesT anddeterminetheskyviewfactor(f )ofthe comingsolarradiation,Icanthenbeformulatedas(Jendritzky,1990):
|     | s   |     | SVF |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
location.Thesunposition(i.e.,solarazimuthθandzenithϕ)iscalculated
from the latitude, date, and time of panorama acquisition. Standard I¼I ∙sinηeð(cid:3)TL∙δ RO ∙m RO ∙ρ=ρ0Þ∙ð1(cid:3)N=8Þ (4)
0
| weatherdata(airtemperatureT | ,relativehumidityRH,andwindspeed |     |     |     |     |     |     |
| --------------------------- | -------------------------------- | --- | --- | --- | --- | --- | --- |
a
whereT istheLinkeTurbidityfactor(denotesthetransparencyofthe
| v)canbeinputfromin-situobservationsorautomaticallyretrievedfrom |     |     |     | L                        |                                       |     |     |
| --------------------------------------------------------------- | --- | --- | --- | ------------------------ | ------------------------------------- | --- | --- |
|                                                                 |     |     |     | cloudlessatmosphere);ρ/ρ | isthepressurecorrectionforreducingthe |     |     |
theclosestairportviatheOpenWeatherApplicationProgrammingInter- 0
opticalthicknessofthestandardatmosphereatsealevel(1013.25hPa)to
face(API).6-directionalcontributionsofdirectanddiffuseshortwaveradi-
thecurrentatmosphericpressure:
ationarethenestimatedfromatmosphericconditions.Additionalinput
parameterscapturingcharacteristicsofthepedestrianareusedtocalculate (cid:3) (cid:4)
|     |     |     |     | ρ¼101325∙ | 1−2:25577∙10−5∙z 5:25588 |     | ð5Þ |
| --- | --- | --- | --- | --------- | ------------------------ | --- | --- |
thethermalindicesPETandUTCI.
Nisdegreeofcloudinessinoctas;δ
2.1.Meanradianttemperaturemodeling RO istheopticalthickness(Kasten,
1980):
T isdefinedasthe“uniformtemperatureofanimaginaryenclosure
| MRT                                                           |     |     |     | δ ¼1=ð0:9m | þ0:94Þ |     | (6) |
| ------------------------------------------------------------- | --- | --- | --- | ---------- | ------ | --- | --- |
| inwhichtheradiantheattransferfromthehumanbodyequalstheradiant |     |     |     | RO         | RO     |     |     |
heattransferintheactualnon-uniformenclosure”(ISO,1998).Itiscalcu-
m istherelativeopticalairmassforagivensunelevationangleη(Kasten
| latedfromthemeanradiantfluxdensityRusingtheStefan-Boltzmannlaw: |     |     |     | RO  |     |     |     |
| --------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
andYoung,1989):
qffiffiffiffiffiffiffiffiffiffiffiffiffi
|     |     |     |     | (cid:5) |     | (cid:6) |     |
| --- | --- | --- | --- | ------- | --- | ------- | --- |
T ¼ 4 R=ε σ−273:15½°C(cid:2) ð1Þ ¼1= sinηþ0:50572∙ðηþ6:07995°Þ−1:6364 ð7Þ
| MRT p |     |     |     | m RO |     |     |     |
| ----- | --- | --- | --- | ---- | --- | --- | --- |
Rsummarizesthelong-(L )andshortwave(K )radiationfluxesthehuman Eq.(7)onlyholdsforη>5°;forlowersunelevationangles,δ hastobe
|     | i   | i   |     |     |     |     | RO  |
| --- | --- | --- | --- | --- | --- | --- | --- |
bodyisexposedtofromsixdirections(i)(VDI,1994)andcanbeobserved retrievedfromalook-uptable(Matzarakisetal.,2010).
|     |     |     |     | ThediffuseshortwaveradiationDiscomposedofanisotropic(D |     |     | )and |
| --- | --- | --- | --- | ------------------------------------------------------ | --- | --- | ---- |
usinga6-directionalsetuporintegralradiationmeasurements(Höppe, iso
1992): anisotropic(D aniso )componentandinterpolatedlinearlybetweencloudless
(N=0)andovercast(N=8)weatherconditions(Matzarakisetal.,2010):
| R¼ξ ∑6 K F | þε ∑6 L F |     |     |         |                  |         |     |
| ---------- | --------- | --- | --- | ------- | ---------------- | ------- | --- |
| k i¼1 i i  | p i¼1 i i |     | (2) |         |                  |         |     |
|            |           |     |     | D¼ðD þD | Þ∙ð1−N=8Þþ0:28G0 | ∙f ∙N=8 | ð8Þ |
|            |           |     |     | iso     | aniso            | SVF     |     |
F areangularweightingfactorsforastandingpersonandsetto0.22forlat-
i TheisotropiccomponentD dependsontheskyviewfactorf ,thedirect
eralradiationfluxesand0.06forupwardsanddownwardsdirectedfluxes iso SVF
|     |     |     |     | shortwaveradiationIonahorizontalsurface,theglobalradiationG |     |     | for |
| --- | --- | --- | --- | ----------------------------------------------------------- | --- | --- | --- |
toapproximatetheelongatedbodyshape(Fanger,1972).ξ isanabsorp- 0
|                                                |     |     | k                 | f =1andcloudlessconditions,andthetransmittanceofdirectsolar |     |     |     |
| ---------------------------------------------- | --- | --- | ----------------- | ----------------------------------------------------------- | --- | --- | --- |
| tioncoefficientforshortwaveradiation(0.7),andε |     |     |                   | S V F                                                       |     |     |     |
|                                                |     | p   | istheemissivityof | r a d iationτ:                                              |     |     |     |
thehumanbody(0.97)(VDI,1994).
WhilePanoMRTestimatesthelongwavecomponentsofRfromob- D ¼ðG0 −IðN¼0ÞÞ∙ð1−τÞ∙f ð9Þ
|     |     |     |     | iso | SVF |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
served,pixel-basedT s inthermalpanoramas,itusesahybridradiation (cid:5) (cid:6)
| fluxdensitymodelingapproachthatdrawsfromexistingT |     |     | modelsto |          |                         |      |      |
| ------------------------------------------------- | --- | --- | -------- | -------- | ----------------------- | ---- | ---- |
|                                                   |     |     | M R T    | ¼0:84∙I0 | ∙cosϕ∙e −0:027∙ ρ ρ ∙ T | L sϕ | ð10Þ |
calculatediffuseandglobalshortwaveradiationanddirectio n a lshortwave G0 0 c o
radiation(Lindbergetal.,2008;LindbergandGrimmond,2011).
|     |     |     |     | τ¼IðN¼0Þ=ðI | 0cosϕÞ |     |     |
| --- | --- | --- | --- | ----------- | ------ | --- | --- |
(11)
2.1.1.Shortwaveradiation
TheshortwaveradiationK foreachofthesixdirectionsdependsonthe Forshadedlocations,theanisotropiccomponentD aniso isomitted;forsun-
i
sunpositionandhasadirect(I)anddiffuse(D)component.Thedirect exposedlocations,itiscalculatedasfollows:
shortwaveradiationIonahorizontalsurfacecanbecalculatedasthepor- D ¼ðG0 −IðN¼0ÞÞ∙τ ð12Þ
aniso
| tionofextraterrestrialsolarradiationI |     | 0 thattravelsthroughtheatmo- |     |     |     |     |     |
| ------------------------------------- | --- | ---------------------------- | --- | --- | --- | --- | --- |
sphere(VDI,1994): Theskyviewfactorf iscalculatedfromindividualthermalpanoramas
SVF
|     |     |     |     | assumingthatallpixelswithT | <4°Careskypixelstodistinguishthem |     |     |
| --- | --- | --- | --- | -------------------------- | --------------------------------- | --- | --- |
S
I 0 ¼I 0 ∙ð1þ0:03344∙cosððDOY∙0:9856(cid:3)2:72Þ∙π=180(cid:4)ÞÞ (3) fromurbansurfacepixels—at hresholdthatshouldberefinedforother
Fig.1.PanoMRTmodelworkflowincludinginput(360°equirectangularthermalpanorama,standardweatherinformation,latitude/longitude,date,time,personal
| characteristics)andoutput(T | ,UTCI,PET). |     |     |     |     |     |     |
| --------------------------- | ----------- | --- | --- | --- | --- | --- | --- |
MRT
3

| A.Middeletal. |     |     |     |     |     |     |     | ScienceoftheTotalEnvironment859(2023)160301 |     |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- | --- |
geographiclocationsandweatherconditions.Thepanoramasareprojected assumingthat all ground surfacesinthesurroundingare sun-exposed
intohemisphericalviews,andeachthermalfisheyeispartitionedintonan- (viewfactorofthegroundis0.5inlateralfisheyeviews).Theincominglat-
nularrings(n=32)tocalculatef bysummingupthecontributionof eralshortwaveradiationdependsonthecardinaldirection(N,E,S,W)and
SVF
non-skypixelsineachring: willonlybecalculatedforthetwodirectionsinwhichthesunisvisiblein
|         |            | (cid:7) | (cid:8)(cid:7) (cid:8) |      | thelateralfisheyeprojection,i.e., |     |     |                        |     |     |      |
| ------- | ---------- | ------- | ---------------------- | ---- | --------------------------------- | --- | --- | ---------------------- | --- | --- | ---- |
| π       |            | πð2 −1Þ |                        |      |                                   |     |     |                        |     |     |      |
|         |            | j       | p j                    |      |                                   |     |     |                        |     |     |      |
| f ¼     | ∑n j¼1 sin |         |                        | ð13Þ |                                   |     |     |                        |     |     |      |
| SVF 2 n |            | 2 n     | t                      |      | N:θ≥270°                          |     | K→  | ¼I0∙cosη∙sinðθ−270°ÞþD |     |     | ð16Þ |
j
wherep /t istheratiobetweenthenumberofskypixelstothetotal N:θ<90° K→ ¼I0∙cosη∙sinðθþ90°ÞþD ð17Þ
j j
numberofpixelsinringj(Middeletal.,2017,2018;Steyn,1980).
Thehemisphericalfisheyeisfurtherusedtodetermineifapositionis E:0°≤θ<180° ¼I0∙cosη∙sinθþD ð18Þ
K→
shadedorsun-exposedatanygiventimebydeterminingthesunposi-
tioninthefisheyeandcalculatingthepercentskyvs.non-skypixelsin S:90°≤θ<270° ¼I0∙cosη∙sinðθ−90°ÞþD ð19Þ
K→
a3-by-3pixelneighborhood.
¼I0∙cosη∙sinðθ−180°ÞþD
TocalculatethetotalshortwaveradiationKincludingdirectanddiffuse W:180°≤θ<360° K→ ð20Þ
radiation,weconsidereachofthesixdirectionsseparatelyanduseasimpli-
fiedformulationbyLindbergandGrimmond(2011).Theincomingshort-
Ifθfallsoutsidethegivenrangeorthelocationisshaded,I′=0.
waveradiationK↓fromtheupperhemisphereisafunctionofthedirect
solarradiationontheplanenormaltothedirectionofincidenceI′=I/
2.1.2.Longwaveradiation
sinηandthediffuseradiationD(ignoringreflectionsfromsurfacesinthe fluxes
|     |     |     |     |     | Longwave | radiation |     | L i in | six directions | are calculated | from |
| --- | --- | --- | --- | --- | -------- | --------- | --- | ------ | -------------- | -------------- | ---- |
surroundings):
equirectangularthermalpanoramas.Tomirrora6-directionalnetradiom-
etersetup,thepanoramasareprojectedintosixfisheyeviews(Fig.2)byre-
K ¼I′∙ sinηþD¼IþD
| ↓   |     |     |     | (14) |     |     |     |     |     |     |     |
| --- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
latingpixels(x,y)ofaWxHsizedpanoramatopixels(x,y)ofafisheye
|     |     |     |     |     |     | p p |     |     |     |     | f f |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
viewwithcenterpixels(C,C)usingthefollowingtransformation:
TheoutgoingshortwaveradiationK↑iscalculatedasafractionofthein- x y
|     |     |     |     |     | 8 (cid:5) |     | h(cid:5) | (cid:6) | (cid:4)i(cid:6) |     |     |
| --- | --- | --- | --- | --- | --------- | --- | -------- | ------- | --------------- | --- | --- |
coming shortwave, assuming that all surrounding surfaces are sun- (cid:3)
|     |     |     |     |     | < π=2þ | tan−1 | y −C | = x | −C  | ∙W=2π;x | <C  |
| --- | --- | --- | --- | --- | ------ | ----- | ---- | --- | --- | ------- | --- |
exposedandhaveanaveragealbedoofα=0.20: (cid:5) h(cid:5) f y(cid:6) f x (cid:4)i(cid:6) f x
|         |     |     |     |      | x ¼       |       |      | (cid:3) |     |         | ð21Þ |
| ------- | --- | --- | --- | ---- | --------- | ----- | ---- | ------- | --- | ------- | ---- |
|         |     |     |     |      | p : 3π=2þ | tan−1 | y −C | = x     | −C  | ∙W=2π;x | >C   |
| K ¼K ∙α |     |     |     |      |           |       | f    | y       | f x | f       | x    |
| " ↓     |     |     |     | (15) |           |       |      |         |     |         |      |
(cid:7)qffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffi(cid:8)
ThelateralreflectedshortwaveradiationiscalculatedasK→=K↓ ∙α∙0.5 (cid:3) (cid:4) 2þ (cid:3) (cid:4) 2
|     |     |     |     |     | y ¼H∙W=2π | x   | (cid:3)C | y (cid:3)C |     |     | (22) |
| --- | --- | --- | --- | --- | --------- | --- | -------- | ---------- | --- | --- | ---- |
forsun-exposedlocations,ignoringreflectionsfromverticalfeaturesand p f x f y
Fig.2.Thermalpanoramaprojectioninto6-directionalfisheyeviews;skydetectioninthermalfisheyesusingathresholdofT <4°C;andskyviewfactor(f )calculation
|     |     |     |     |     |     |     |     | S   |     |     | SVF |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
using32annulusrings.
4

| A.Middeletal. |     |     |     |     |     |     |     |     |     | ScienceoftheTotalEnvironment859(2023)160301 |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- |
Foreachdirectionalthermalfisheye,T ofnon-skypixelsisconvertedtoa Tempecampusthatarewithinwalkingdistancefromeachothertoallow
s
longwaveradiationfluxassumingastandardemissivityofε=0.95and fortransectobservations(Fig.3).Thecampusisa2.6-km2areaofintercon-
atmosphericradiationAasfollows: nected pedestrian malls and can be considered an open midrise local
|     |     |     |     |     |     |     |     | climate zone | (Stewart and Oke, | 2012). We | selected | diverse sites with |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ----------------- | --------- | -------- | ------------------ |
L ¼εσðT þ273:15Þ4þð1(cid:3)εÞ∙A (23) respecttogroundcover(asphalt,concrete,grass),skyviewfactor(f ),
| pixel | s   |     |     |     |         |     |         |             |                  |                    |       | SVF             |
| ----- | --- | --- | --- | --- | ------- | --- | ------- | ----------- | ---------------- | ------------------ | ----- | --------------- |
|       |     |     |     |     |         |     |         | and shading | (trees, building | tunnel, engineered | shade | canopies, fully |
|       |     |     |     |     | (cid:5) |     | (cid:6) |             |                  |                    |       |                 |
(cid:3) (cid:4) exposed).Inaddition,weconductedfieldobservationsonthePhoenix
| A¼σ∙ðT | þ273:15Þ4∙ | 0:82−0:25∙10−0:0945∙Vp |     |     | ∙   | 1þ0:21∙ðN=8Þ2:5 |     |     |     |     |     |     |
| ------ | ---------- | ---------------------- | --- | --- | --- | --------------- | --- | --- | --- | --- | --- | --- |
a
Zoomainparkinglot,whichislocated5kmnorthofcampusandhas
ð24Þ
|                                               |     |     |     |     |     |                  |     | minimalhorizonlimitation(f       | SVF | =0.98).          |     |     |
| --------------------------------------------- | --- | --- | --- | --- | --- | ---------------- | --- | -------------------------------- | --- | ---------------- | --- | --- |
| LongwaveradiationforskypixelsisestimatedfromT |     |     |     |     |     | andskyemissivity |     |                                  |     |                  |     |     |
|                                               |     |     |     |     |     | a                |     | 3.2.ThermalpanoramaretrievalandT |     | MRT observations |     |     |
ε
| sky ,whichisafunctionofvaporpressureV |     |     |     |     | p andT a | (Lindbergetal.,2008): |     |     |     |     |     |     |
| ------------------------------------- | --- | --- | --- | --- | -------- | --------------------- | --- | --- | --- | --- | --- | --- |
Thermalpanoramaswereacquiredoncampusalongwithin-situobser-
| L   | ¼ε σðT | þ273:15Þ4 |     |     |     |     |     |     |     |     |     |     |
| --- | ------ | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
sky sky a (25) vationsofhuman-biometeorologicaldataonthreehot,dry,clearsummer
daysinsummer2020:May27,May28,andJune16.Observationalwalk-
|     | (cid:7) |     | (cid:8) | (cid:3) |     | (cid:4) |     |     |     |     |     |     |
| --- | ------- | --- | ------- | ------- | --- | ------- | --- | --- | --- | --- | --- | --- |
V −ð1:2þ3:0∙46:5 V Þ0:5 i n g t r a n se c t sw e r e c o n d u c te d e ve r y 3 h fr o m 6 :0 0 h to 2 0 :0 0 h l oc a l t i m e
| ε ¼1− | 1þ46:5 |     | p ∙e |     | Taþ | 2 p 73:15 | ð26Þ |     |     |     |     |     |
| ----- | ------ | --- | ---- | --- | --- | --------- | ---- | --- | --- | --- | --- | --- |
sky T þ 2 73:15 c o ve r i n g fi v e to s i x lo c a t io n s pe r d a y. T he P h oe n ix Z oo p a rk in g lo t lo c a t i on
a
wasmonitoredhourlyonJune3,2020from7:00hto17:00h.
Finally,Liscalculatedforeachdirectionalthermalfisheyebysummarizing
|     | i   |     |     |     |     |     |     | AFLIRDuoProRDual-Sensor4KThermalCamera(640×512pixels, |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------------------------------------------- | --- | --- | --- | --- |
45°horizontalfieldofview)wasattachedtoaGigapanosrotationalarmon
averagelongwaveradiationvaluesover32annulusrings(analogousto
thef SVF calculation)andinsertedinEq.(2)alongwiththedirectional atripodtoautomaticallycaptureamatrixof8×10visualandthermal
| shortwaveradiationfluxesK |     |     | (Eqs.(14)–(20))toyieldthemeanradiant |     |     |     |     |                                                          |     |     |     |     |
| ------------------------- | --- | --- | ------------------------------------ | --- | --- | --- | --- | -------------------------------------------------------- | --- | --- | --- | --- |
|                           |     |     | i                                    |     |     |     |     | imageswith25%overlapateachlocation(Fig.4b).Acomplete360° |     |     |     |     |
fluxdensityRandsubsequentlyT . scantookabout5min.Inpost-processing,thesetsofvisualimageswere
MRT
arrangedinagridandstitchedintoanequirectangularpanoramausing
2.2.Thermalcomfortindexcalculations thestitchingsoftwarePTGUI.Thestitchingparametersthenservedasa
templateforcreatingthecorrespondingthermalpanoramas(Fig.5).
Thermal comfort is a complex function of environmental factors T wasobservedateachlocationusingthemobileweatherstation
MRT
determiningthermalexposureandphysiological,psychological,andbe- MaRTy(Middeletal.,2021;MiddelandKrayenhoff,2019).MaRTyisa
havioral factors (Chen and Ng, 2012; Johansson et al., 2014; Middel human-biometeorologicalinstrumentplatformthatrecords6-directional
radiationfluxdensities(L
etal.,2016;NikolopoulouandLykoudis,2006).Numerousthermalcom- i andK),T,horizontalwindspeed(v),andrela- i a
fortindiceshavebeendevelopedtointegrateenvironmentalandpersonal tivehumidity(RH)at2sintervals(Fig.4a).Theplatformwasplacedinthe
factorsintoanexperiencedtemperaturevalue(Potchteretal.,2018).The centerofthepanoramatripodlocationimmediatelyaftereachthermalscan
tocollecthuman-biometeorologicaldatafor1–2min.Thefirst15recordsat
currentimplementationofPanoMRTcalculatesPET(Höppe,1999)and
UTCI(Blazejczyketal.,2012;Fialaetal.,2012;Jendritzkyetal.,2012) eachlocationwereremovedtoaccountfortheresponsetimeoftheT/RH
a
basedonuser-configuredpersonalcharacteristics(age,gender,height, probe(sensortimeconstant22s,63%stepchange)andminimizetheim-
weight),metabolicrate,andclothinginsulation. pactofsensorlag(Häbetal.,2015);theremainingrecordswereaveraged
|                   |     |               |          |            |              |                       |        | for each location             | and time to | provide localized | forcing | data for the |
| ----------------- | --- | ------------- | -------- | ---------- | ------------ | --------------------- | ------ | ----------------------------- | ----------- | ----------------- | ------- | ------------ |
| 3.Modelvalidation |     |               |          |            |              |                       |        | PanoMRTvalidation(T,RH,v)andT |             | groundtruth.      |         |              |
|                   |     |               |          |            |              |                       |        |                               | a           | MRT               |         |              |
| PanoMRT           |     | was validated | through  | in-situ    | observations | of                    | human- | 3.3.Results                   |             |                   |         |              |
| biometeorological |     | data at       | the time | of thermal |              | panorama acquisition. |        |                               |             |                   |         |              |
Modelperformancewasassessedusingstandardmodelstatisticssuchas 3.3.1.Meteorologicalconditionsandin-situobservations
Meteorologicalconditionsweresimilaracrossfieldworkdayswithmin-
| theRootMeanSquare |     | Error(RMSE),MeanBiasError(MBE),andthe |     |     |     |     |     |     |     |     |     |     |
| ----------------- | --- | ------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
indexofagreement(d)(Willmott,1982).Inaddition,PanoMRTresults imumT between24°Cand31°C,maximumT between41°Cand43°C,
|     |     |     |     |     |     |     |     | a   |     |     | a   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
werecomparedtoRayMan(Matzarakisetal.,2010)simulationstoassess andclear,sunnyskies.RHrangedbetween21%and25%at6:00hand
thebenefitofspatiallyexplicitT observationsforlocation-basedT below10%duringtheafternoonhours.Windspeedwasgenerallylow
|     |     |     | s   |     |     |     | MRT |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
modeling. For this comparison, RayMan was run with hemispherical (<1.0ms−1onaverageacrossallobservations)withpeakgustsofupto
| blackandwhiteimagesgeneratedfromthethermalpanoramas(assuming |     |     |     |     |     |     |     | 4.3ms−1. |     |     |     |     |
| ------------------------------------------------------------ | --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- |
athresholdof4°Cforskypixels)andthesamemeteorologicalforcingas T variedconsiderablyacrosslocationsandtimesofday,especially
MRT
PanoMRT(observedT andRHbutnotT).Lastly,PETandUTCIwerecal- betweensun-exposedandshadedsites(Fig.6).T peakedintheafter-
|     |     | a   |     | s   |     |     |     |     |     |     | MRT |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
culatedfromhuman-biometeorologicalobservations(T,T ,RH,v)and noon(between15:00hand16:00h)atopenlocationswithhighf ,
|     |     |     |     |     |     | a MRT |     |     |     |     |     | SVF |
| --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- |
defaultparametersforpersonalcharacteristicsforPET(35-yearoldmale, such as the sun-exposed parking lot location 10 (f SVF = 0.84) with
1.75m,75kg,clothinginsulation0.5clo,metabolicrate80Wm−2)for
|     |     |     |     |     |     |     |     | 72.3°Candtheconcretepathintersection12(f |     |     | SVF =0.81)with71.0°C. |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------------------------------- | --- | --- | --------------------- | --- |
comparisontoPanoMRTandRayManresultstodeterminetheimpactof Incontrast,T MRT wasclosetoT a duringthedayunderlarge,denseshade
spatiallyexplicitT onthermalindexcalculations. trees(locations4,16,and2)andbelowT insideatunnelthroughaparking
|     |     | s   |     |     |     |     |     |                                 |     | a                            |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------- | --- | ---------------------------- | --- | --- |
|     |     |     |     |     |     |     |     | garage(location8).Aftersunset,T |     | washighestinanarroweast-west |     |     |
MRT
3.1.Studysite canyonenclosedbyconcretewalls(location6,35.6°C),underametal
|     |     |     |     |     |     |     |     | shade structure | (location 1, | 35.6 °C), and | inside | the tunnel (location |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | ------------ | ------------- | ------ | -------------------- |
PanoMRTwasdeveloped,tested,andvalidatedinhotanddryTempe, 8,36.9°C).CoolestT wasrecordedovergrassaftersunset(location
MRT
Arizona,USA.TempeissituatedintheEastValleyofthePhoenixmetropol- 11,f =0.93,22.9°C).
SVF
itanarea,aregionintheSonoranDesertoftheU.S.Southwestwithlow Surfacesshowedthegreatestvariabilityintemperatureacrosssurface
annual rainfall (237 mm) and lowrelative humidity(Köppen Climate types,sunexposurelevel,andtimesofday.Irrigatedgrassexhibitedthe
ClassificationsubtypeBwh).Withanaverageof300clear,sunnydaysper
|     |     |     |     |     |     |     |     | lowestT s at6:00hwith19.8°C(location3)and19.2°C(location11) |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------------------------------------------------- | --- | --- | --- | --- |
year,airtemperaturepeaksatorabove32°Cforanaverageof175days, anddidnotexceedT a throughouttheday.ThehottestgroundT s inexcess
andmaximumairtemperaturesfrequentlysurpass43°CinJune.Totest of60°Cwasrecordedmiddayoveraconcretepath(location12),anasphalt
andvalidatePanoMRT,wechose18locationsonArizonaStateUniversity's road(location9),andthePhoenixZooasphaltparkinglot(location10).
5

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
Fig.3.Equirectangularpanoramasof18observationsitesonArizonaStateUniversity'sTempecampusandonesiteonthePhoenixZooparkinglot(upperleftpanorama,
locationoutsidemap5kmnorthofcampus).Forsitemetadata(fisheyephotos,exposure,groundcover,skyviewfactor)seeSupp.Table1.
ThethermalpanoramasillustratetheT distributionofsurfacesinthe360° (ISO,1998)forheatandcoldstressstudies.Themodelexhibitsanunsys-
s
surroundingsofeachlocation(Fig.7). tematicRMSEof4.5°CandasystematicRMSEof0.7°C,indicatingthat
modelparametersarewell-specifiedandthemajorityoftheerrorresults
3.3.2.PanoMRTandRayManmodelperformance fromprocessesormodel-observationdifferencesbeyondthescopeofthe
PanoMRTperformswell overall(Supp.Table3)withaRootMean currentmodel.Thisincludeserrorsassociatedwithobservationprocedures
Square Error (RMSE) of 4.1 °C for all observations (N = 145), which andinstrumentationsetup:human-biometeorologicalobservationsand
meetstheaccuracyrequirementof±5°CsetintheISO7726standard thermalpanoramaswerenottakenatthesametimebutsuccessively,and
Fig.4.a)Mobilehuman-biometeorologicalinstrumentplatformMaRTy(Middeletal.,2021;MiddelandKrayenhoff,2019);b)FLIRDuoProRDual-Sensor4KThermal
CameraonaGigapanosrotationalarm.ForinstrumentspecificationsseeSupp.Table2.
6

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
Fig.5.a)Matrixof8×10overlappingphotosfrompanoramascanatlocation12;b)stitchedvisualpanorama;c)correspondingstitchedthermalpanorama.
MaRTy'snetradiometersaresubjecttovaryingspatialexposure,because 17(photovoltaicshadestructure,f =0.04)at12:00h.Thedifference
SVF
theyare0.6–1.0mapart.TheMeanBiasError(MBE)capturestheaverage inmodeledandobservedT of−10.8°Cforlocation11isduetothe
MRT
biasinthepredictionandisnegative(−1.9°C),meaningthatPanoMRT lowsunelevationanglethatleadstounderestimatedincomingshortwave
tends to underestimate T . The slope of the regression line (Supp. radiationinthemodel.T estimationerrorsunderengineeredshade
MRT MRT
Fig.1)supportsthisobservation.TheMeanAbsoluteError(MAE),i.e.the resultfrominadvertentsunexposureofanetradiometerduetotheoff-
sumofabsoluteerrorsdividedbythesamplesize,is3.2°C,andtheindex centerplacementofthesensors.Overall,themostchallenginglocation
ofagreement(d),i.e.astandardizedmeasureofthedegreeofmodelpredic- for PanoMRT to estimate T is 19 (f = 0.37), which is a plaza
MRT SVF
tionerror,showsexcellentagreementwithd=0.98. surroundedbytallpalmtrees.Themodelisunabletohandlesemi-shade
PanoMRTperformancevariesbytimeofday(6:00h,9:00h,12:00h, ordappledshadeandunderestimatesT by−5.6°Cto−7.6°Cwhen
MRT
15:00h,18:00h,20:00h),exposure(sun/shade),andshadetype(tree/ thesunisnotvisibleintheupperhemisphere(obstructedbypalmleaves,
engineered)(Fig.8).ThelowestRMSE(3.3°C)isobservedat20:00h shaded)andoverestimatesT by5.8°Cforthesun-exposedcaseat
MRT
whenincomingshortwaveradiationiszeroandthemodelsolelyrelieson 12:00h.
themeasuredthermalpanoramainput.Atthistimeofday,errorscanbeat- RayManhasanoverallRMSEof9.0°C(Supp.Table3)withanunsys-
tributedtoanassumedfixedemissivity(0.95)forthethermalimages,the tematicRMSEof7.8°C(mostlyduetoobservationproceduresandinstru-
assumptionthatreflectedlongwavefromsurfacesoriginatesfromthesky mentation setup) and a systematic RMSE of 4.4 °C. The MBE for all
only,inaccuraciesintheskydetectionatthetransitionbetweenthebuilt observations (N = 145) is positive, indicating that RayMan tends to
environmentandsky,andthetripodsurfacetemperature,whichisinthe overestimateT .TheMAEis7°C,andtheindexofagreementshows
MRT
fieldofviewofthecameraandobstructspartsoftheground.Inaddition, goodoverallmodelperformance(d=0.89).
themodeltendstounderestimateT forskypixelsandthereforeLfor RayManperformancevariessignificantlybytimeofday,exposure,and
s
opensiteswithalargef (overallRMSE=3.8°C,MAE3.0°C,d= shadetype(Fig.8).ThelowestRMSEisobservedaftersunset(3.2°C).
SVF
0.93). Model results after sunrise (6:00 h) exhibit the highest RMSE Modelresultsat12:00hand15:00hexhibitthehighestRMSE(11.0°C
(5.0°C)withanegativeMBE(−2.3°C).PanoMRTunderestimatesincom- and 11.4 °C), the highest MAE (8.5 °Cand 10.6 °C), and the lowest d
ingsolarradiationatlowsunangles,andmeteorologicalconditionschange (0.42and0.51).Duringmid-day,IandT peak,thereforemodelingerrors
s
quicklyaftersunrise,whichintroducesdifferencesinMaRTyandthermog- inemittedlongwaveradiationareexpectedtobelargest.Withrespectto
raphyobservationsthatimpactmodelvalidationandaddtounsystematic exposure,theMBEshowsthatRayManoverestimatesshadedlocations
errors.Themodelperformsequallywellforengineeredshade(RMSE= and underestimates sun-exposed locations. In the shade, the RMSE is
4.2°C)andtreeshade(RMSE=4.1°C)duetoavailablesurfacetempera- 11.8°Cfortreesand9.2°Cforengineeredshade,respectively,duetoover-
tureobservationsforbothshadetypesfromthermalpanoramas.Systematic estimationofsurroundingT.Inthesun,theRMSEamountsto8.2°C.The
s
errorsarelowforalltimesofday,exposures,andshadetypes.Thelargest absenceofreflectedshortwaveradiationinthemodelislikelyacontribut-
RMSEsisobservedatnoonwith3.1°C,otherwiseRMSEsrangesbetween ingfactortounderestimatedT valuesinsun-exposedlocations.
MRT
0.7°Cand1.6°C. RayManperformancevariessignificantlybylocation.Simulationsare
PanoMRTperformancealsovariesbylocationduetoheterogeneous mostaccurateforopensiteswithhighf .Halfofthemodelingresults
SVF
urbanforms.Amajorityofsites(120of145observationsacrossspace are within5 °Cof T observations, while only 46 model runs yield
MRT
and time) exhibit a <5 °C difference between modeled and observed T results within 3 °C of MaRTy observations. Locations 8 (tunnel,
MRT
T ,andmorethanhalf(75)ofthemodelingresultsarewithin3°C f =0.00),7(densetreecanopycover,f =0.02),2(densetreecanopy
MRT SVF SVF
of theMaRTyobservations. Two sitesshowlargediscrepanciesin the cover,f =0.02),and4(mediumdensetreecanopycover,f =0.32)
SVF SVF
morning:T atlocation18(underaPaloVerdetree,f =0.17)is exhibitthelargestT errorofupto−24.9°C,−19.3°C,−18.1°C,
MRT SVF MRT
overestimatedby11.2°Cduringthe9:00htransect,andT atlocation and − 17.2 °C respectively, during the 12:00 h transect. T is
MRT MRT
15 (sun-exposed concrete crossing, f = 0.87) is overestimated by overestimatedatalltimesatthefourlocationsduetoamodelingerror
SVF
11.2°Cduringthe6:00htransect.Bothobservationsaresubjecttomea- ofshadedT ofupto8.8°C,whichtranslatesintooverestimatedlongwave
s
surement errors as one of MaRTy's net radiometers was inadvertently emission.
shaded.Incontrast,PanoMRTsignificantlyunderestimatesT forloca- Incontrast,RayManunderestimatesT byupto−17°Cforopenlo-
MRT MRT
tions11(lawnnexttoArizonaStateUniversity'sHaydenlibrary,f = cations13(lawnnexttoArizonaStateUniversity'sOldMaine,f =0.84)
SVF SVF
0.85)at18:00h,1(metalshadestructure,f =0.10)at16:00h,and and12(sun-exposedconcretecrossing,f =0.87)atlowsunangles
SVF SVF
7

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
Fig.6.In-situmeanradianttemperatureobservationswithMaRTyforallfieldworkdaysandlocations:a)May27,2020;b)May28,2020;c)June16,2020;d)June3,2020.
duringthe6:00htransect.Someoftheseerrorsareduetoinaccuraciesin oneofMaRTy'snetradiometersledtoinadvertentdifferencesinmodeled
thefisheyephotowherethepixelofthecalculatedsunpositionisblack andobservedT forlocations18,15,17,and1.
MRT
(i.e.thelocationisshaded)buttheneighboringpixelsarewhite,andthe
observationsareactuallysun-exposed(orviceversa,RayManmodelssun- 3.3.3.Meanradianttemperatureerrorpropagationintothermalindices
exposureforashadedlocation).AnalogoustoPanoMRT,RayManstruggled SincePETandUTCIaredrivenbyT ,modelingerrorsrelatedto
MRT
tomodelthesemi-shadeoflocation19(plazawithtallpalmtrees,f = radiativeheatfluxespropagateintoPETandUTCIoutcomes.Here,temper-
SVF
0.37),andmeasurementerrorsduetoaccidentalsunorshadeexposureof ature, humidity, and wind speed are provided by the MaRTy
8

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
Fig.7.ThermalpanoramasforalllocationsobservedonJune16,2020:aftersunrise(6:00h),mid-morning(9:00h),midday(12:00h),midafternoon(15:00h),beforesunset
(18:00h),aftersunset(20:00h).
9

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
Fig.8.ModelperformancestatisticsforPanoMRTandRayManincludingRootMeanSquareError(RMSE),unsystematicRMSE(RMSEu),systematicRMSE(RMSEs),indexof
agreement(d),andMeanBiasError(MBE).R2valuesareillustratedinSuppl.Fig.1–3.ViolinplotsofPanoMRTmodelerrorsareshowninSuppl.Fig.4.Performancestatistics
aresummarizedinsuppl.Table3.
biometeorologicalstation,andthereforeallerrorsinPETandUTCIderive Mayer, 2016). While sun exposure is themain driver of variabilityin
fromT modeling.PanoMRTresultsforPETyieldanoverallRMSEof T underclearskyconditions(Leeetal.,2014;Lindbergetal.,2016),
MRT MRT
2.6°CwithanMAEof2.2°C,MBEof−1.53(modeltendstounderestimate longwavefluxesgainimportanceindenserbuiltenvironments(Lindberg
PET),anddof0.97.ReferenceRayMansimulationswithoutT forcinghave etal.,2014).MiddelandKrayenhoff(2019)foundthatlateralcomponents
s
anRMSEof6.4°CwithanMAEof5.3°C,MBEof4.80(modeltendstoover- ofthelongwavefluxarethelargestcontributiontoT ,renderingT ofthe
MRT s
estimatePET),anddof0.85.ConcurrentwithT estimates,modelresults surroundingbuiltenvironmentthesecondmostimportantinputvariable
MRT
forPETmeettheaccuracyrequirementof±5°CsetintheISO7726stan- aftersunexposureforaccurateT modelingasevidencedintheperfor-
MRT
dardforheatandcoldstressstudieswhenspatiallyexplicitT areusedas manceimprovementreportedhere.SpatiallyexplicitT forcingalsoen-
s s
modelinput.UTCIislesssensitivetoT andT ofthebuiltenvironment. hancesPETandUTCIcalculations,butPETismoresensitivetoaccurate
MRT s
PanoMRTmodelsUTCIwithanRMSEof1.22°CandRayManwithanRMSE T inputthanUTCI.
s
of2.31°C. AsforallimagebasedT models,PanoMRTandRayManaresensitive
MRT
tothelocationofphotoacquisition(fisheyeimageorpanorama)incom-
4.Discussion plexurbangeometries.Sunexposuremaybemiscalculatedduetopixel
misalignment,especiallyatthetransitionfromhorizonlimitationtosky
SincePanoMRTandRayManhavesimilarprocedurestocalculatein- andintreecanopies.Forsomelocations,ourmodelevaluationwasfurther
comingshortwaveradiation,forcingbothmodelswithMaRTyobserved impactedbyobservationproceduresandinstrumentationsetup.MaRTy
human-biometeorologicaldataandcomparingresultsallowstoquantify observationsweretakenafterthethermalpanoramawasacquired,not
thebenefitofusingspatiallyexplicit,human-centric,3-dimensionalT concurrently,andinafewinstances,oneofMaRTy'snetradiometerswas
s
(T )forT modeling.RayManexhibitslargererrorsthanPanoMRT inadvertently exposed to the sun or shade. Those observational flaws
ped MRT
foralltimes,exposures,andshadetypesexceptat20:00hwhenRMSEis contributetotheunsystematicerrorinbothmodelsanddonotbiasthe
similar(3.2 °C and 3.3 °C). Overall, thermal panoramas reduce RMSE modelresults.
from9.0°Cto4.1°C,whichmeetstheaccuracyrequirementof±5°Cset PanoMRTisnotthefirstT modelbasedonthermalphotography.
MRT
intheISO7726standard.Thebiggestmodelperformanceboostisobserved Severalapproacheshavebeendevelopedinrecentyears,mostofwhich
at12:00hwhenT arehighest.RMSEimprovesfrom11.0°Cto4.0°Cwhile arerestrictedtoindoorsettings.Lee etal.(2019)developedasystem
s
dincreasesfrom0.42to0.97.PreviousstudiesconfirmthatRayManover- usinganglefactorsandaninfraredthermalcameratomodelT for
MRT
estimatesT forenclosedsites,especiallyduringthesummer,whichresults largestadiums.TheirsetupoverestimatedT by0.9°CwithR2=0.83
s MRT
inalargepositiveMBEforshadedsiteswithlowf (Colteretal.,2019; comparedtoglobethermometerobservationsandwassubsequentlyim-
SVF
Cranketal.,2020;GálandKántor,2020;Krügeretal.,2014;Leeand provedtoapan-tiltscanningsystem(LeeandJo,2021).Initialtestsof
10

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
thesysteminindoorandlongwave-dominatedoutdoorsettingsyieldedan Lastly,PanoMRTcannotmodeldappledorpartialshadebecausesun
R2of0.80(LeeandJo,2022).Natephraetal.(2017)integratedthermalim- exposure is modeled in a true/false fashion with no option to define
ageswith3-dimensionalBuildingInformationModels(BIMs)toinvestigate shadetransmissivity.ThisleadstoinaccurateT estimatesundertrees
MRT
theperformanceofbuildingenvelopesandoccupancycomfortlevelsbut withlowleafareadensityandengineeredstructuressuchasphotovoltaic
didnotprovideperformancestatistics.Morerecently,AcuñaPazyMiño canopiesandclothumbrellas.Konarskaetal.(2014)measuredthetrans-
etal.(2020)developedthe“4π”methodtoevaluateoutdoorradiantenvi- missivityoftotalanddirectsolarradiationthroughfoliatedandleafless
ronments using photographic high dynamic range (HDR) images and treecrownsinGöteborg,Swedenandfoundawidetransmissivityrange
longwaveinfraredimages.Theresultingshort-andlongwaveradiance from 1.3 % to 51.9 %. Results were incorporated into the SOLWEIG
mapsyieldedT valueswithin2°Cofglobetemperaturereadingsfor model(Lindbergetal.,2008)toimproveT calculations.Transmissivity
MRT MRT
15observationsthatwereconductedinFranceandSpainduringmostly estimatescould beincorporated into PanoMRT by detectingoverhead
cloudywinterconditionsandatnight,soimpactsofdirectshortwaveradi- obstructionsinthephotographsandestimatingtransmissivityusingsky
ationwereminimal.Incontrast,Merchantetal.(2022)collectedlongwave versusnon-skypixelsoftheobstruction.
andshortwavepanoramasunderclearsky,hot,dryconditionsinTempe, PanoMRTisahybridmodelingapproachthatreliesonT observations
s
ArizonausingaSMaRT-SLsensorplatformandreportasignificantim- tocalculatelongwaveradiationandmodelsshortwaveradiationbasedon
provementoverthepreviousversionofthesystem,whichreliedonthermal thesunpositionandsimplemeteorologicalforcing.Asitmeetstheaccuracy
pointclouds(Avivetal.,2021).Theiranalysismainlyfocusedoncompar- requirementof±5°CsetintheISO7726standard,ithasthepotentialtobe
ingdirectionalshort-andlongwavepanoramastoa6-directionalnetradi- usedinplaceofthe6-directionalsetup,whichisconsideredthegoldstan-
ometersetupbutfindingssuggestthatintegratingthosefluxesintoT dardtomeasureT butisamajorresearchexpense(>$20k).Globether-
MRT MRT
wouldyieldaccurateresults. mometerstomeasureT aremoreaffordable($500)buthaveaslow
MRT
PanoMRTisindevelopmentandhasseverallimitationswithrespectto responsetimeandrequirepreciseheatlossestimates(Vanosetal.,2021).
shortwaveandlongwavecalculations.Themodelcurrentlyunderestimates The current thermal panorama setup measures the surroundings in
longwaveradiationforskypixels,i.e.T isunderestimatedforsiteswith 2–3minandcouldbeimprovedfurther,e.g.,byusingaFLIRONEcamera
MRT
highf .Inaddition,thethresholdtodetermineskypixels(4°C)works attachmentforphonesthatdirectlycapturespanoramaswithouttheneed
SVF
wellforclearhotdrysummerconditionsbutneedstobeadjustedfor forstitching.Insummary,PanoMRTconstitutesanaffordable,practical
othermeteorologicalconditions,seasons,andgeographiclocations.For alternativetocurrentT acquisitionandmodelingapproaches.
MRT
example,Asawaetal.(2022)manuallydetermined10°Cand18°Cas
appropriateskypixelthresholdsforathermalimagingsysteminTokyo.
Alternatively,skypixelscouldbedetectedautomaticallyfromthevisible 5.Conclusions
photographsthatareusedtodeterminethestitchingparameterforthe
thermalimages.Imagesegmentationapproachesusingconvolutionalneu- Mitigating urban overheating through urban design interventions
ralnetworkstoidentifyskypixelshavegainedpopularityinrecentyears (e.g.,trees,coolpavement)isatoppriorityofthe21stcenturyforcities
andcanalsohandlecloudyconditions(Middeletal.,2019;Niceetal., aroundtheworld.Assessingtheimpactsofdesignchangesonhumanther-
2020;Zengetal.,2018). malexposurerequiresfine-scaleinformationonradiativeheatfluxesinthe
Atsun-exposedlocations,PanoMRTassumesanaveragealbedoof0.20 builtenvironment.Wedemonstratedtheimportanceofhuman-centric,spa-
forthesurroundingsurfacestocalculatereflectedshortwaveradiation. tiallyexplicitT
s
data,i.e.,approximatedT
ped
observationsusingpanoramic
Reflectedshortwavecontributionsarelikelyoverestimated,becausethe thermography,forcapturingcomplexlongwaveradiationpatternsthatre-
model assumes equal reflection from all solid surfaces, even shaded sultfromapatchworkofsurfacetypeswithvaryingorientation,diurnal
surfaces,when thelocationissunexposed. This yieldsa“worst-case” sun-exposure,andmaterialcharacteristics.PanoMRTmodelresultsshow
T MRT forsun-exposedlocations.Similarly,reflectedshortwaveradiationis thatT ped measurementsaremostimportantduringmidday(peakT s )and
assumedtobezeroforshadedlocationsandthereforeunderestimated. forshadedlocations,becauseT ped capturesT s underneaththeshadein
Whilethisapproachsimplifiesexposureofthecomplexbuiltenvironment contrasttohorizontalT
s
fromthermalsatelliteimagery.Theuseofspatially
(e.g.inreality,parallelbuildingwallsarenotsimultaneouslyexposed), explicitT s asmodelinputimprovedT MRT estimatessuchthattheymetthe
theimpactofT is<1°C.LongwaveradiationinPhoenixisthelargest accuracyrequirementof±5°CsetintheISO7726standardforheatand
MRT
contributortoT MRT (MiddelandKrayenhoff,2019),andtheimpactof coldstressstudies.T MRT modelingerrorspropagatedintothermalcomfort
sunexposureonsurfacetemperaturesisdirectlycapturedthroughthe indexcalculationsmorestronglyforPETthanUTCIbutsignificantlyim-
thermalpanoramas.Merchantetal.(2022)observedreflectedshortwave provedmodelingaccuracyforbothindices,indicatingthatT
ped
isalso
radiationinthebuiltenvironmentusingaSMaRT-SLshortwavearray highlyrelevanttohumanthermalcomfortassessments.T s haslongbeen
sensorthatproducespanoramicviewsofshortwaveradiantheatfluxes recognizedaskeyparameterinurbanclimate,buttraditionalacquisition
and found that reflected shortwave radiation can be on the order of methodslackspatialresolutionanddonotcapturepedestrian-relevantsur-
100Wm−2duringmidday.Mostmicroclimatemodelsthatdoaccountfor facespatches.Ourworkelevatestheimportanceofhuman-centric,street-
reflectionuseraytracingandviewfactorsofsurfacepatchestoestimate levelT
s
measurementsforthermalexposureassessments.
reflectedshortwaveradiation(KrayenhoffandVoogt,2007;Lachapelle
etal.,2022;Lindbergetal.,2016;Simonetal.,2021).Asimilarapproach
couldbeincorporatedintoPanoMRTusingimagesegmentationtodetect CRediTauthorshipcontributionstatement
varioussurfacetypesandassignappropriateradiativeandthermalproper-
ties to each pixel. Classified surface types would also be required to AM:Conceptualization,Methodology,Validation,FormalAnalysis,
estimateviewfactorsofbuildingsandvegetationineachdirectiontorefine Writing,Writing-OriginalDraft,Writing-Review&Editing,Visualization,
thecalculationofD(Eqs.(16)–(20))asimplementedby(Lindbergetal., Supervision,ProjectAdministration,FundingAcquisition.MH:Software,
2008).
Methodology,Validation,Writing-Review&Editing.FAS:Investigation,
Currently, PanoMRT assumes that the thermal panoramas are Data Curation, Writing - Review & Editing. AU: Investigation, Data
correctedforemissivity.Anappropriatecorrectionfortargetemissivity Curation, Writing - Review & Editing. ESK: Methodology, Validation,
isrequiredforaccurateT measurements,becauseT ofanobjectmay
Writing-Review&Editing.
s s
appeartobeemittingmoreradiationthanitreallyis,forexample,a
metalbench.Ourvalidationsiteswerechosentonothaveextensivesur- Dataavailability
faceswithlowemissivityinthesurroundingtominimizetheimpactof
emissivityontheresults. Datawillbemadeavailableonrequest.
11

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
Declarationofcompetinginterest ISO,1998.ISO7726,ErgonomicsoftheThermalEnvironment,InstrumentsforMeasuring
PhysicalQuantities.GenevaInt.Stand.Organ.doi:ISO7726:1998(E).
Jay,O.,Capon,A.,Berry,P.,Broderick,C.,deDear,R.,Havenith,G.,Honda,Y.,Kovats,R.S.,Ma,
Theauthorsdeclarethattheyhavenoknowncompetingfinancialinter-
W.,Malik,A.,Morris,N.B.,Nybo,L.,Seneviratne,S.I.,Vanos,J.,Ebi,K.L.,2021.Reducing
estsorpersonalrelationshipsthatcouldhaveappearedtoinfluencethe thehealtheffectsofhotweatherandheatextremes:frompersonalcoolingstrategiesto
greencities.Lancet398,709–724.https://doi.org/10.1016/S0140-6736(21)01209-5.
workreportedinthispaper.
Jendritzky,G.,1990.BioklimatischeBewertungsgrundlagederRaumeamBeispielvon
mesoskaligenBioklimakarten.AkadfRaumforschuLandesplanung114,7–69.
Acknowledgments Jendritzky,G.,deDear,R.,Havenith,G.,2012.UTCI-whyanotherthermalindex?Int.
J.Biometeorol.https://doi.org/10.1007/s00484-011-0513-7.
Jenerette,G.D.,Harlan,S.L.,Stefanov,W.L.,Martin,C.L.,2011.Ecosystemservicesandurban
ThisresearchwasfundedbytheNationalScienceFoundation,grant heatriskscapemoderation:water,greenspaces,andsocialinequalityinPhoenix,USA.
numberCMMI-1942805(CAREER:HumanThermalExposureinCities- Ecol.Appl.21,2637–2651.https://doi.org/10.1890/10-1493.1.
NovelSensingandModelingtoBuildHeat-Resilience).Itwasfurthersup- Johansson,E.,Thorsson,S.,Emmanuel,R.,Krüger,E.,2014.Instrumentsandmethodsinout-
doorthermalcomfortstudies–theneedforstandardization.UrbanClim.10,346–366.
portedbytheHealthyUrbanEnvironment(HUE)initiative(whoisgrateful
https://doi.org/10.1016/j.uclim.2013.12.002.
forthesupportfromtheMaricopaCountyIndustrialDevelopmentAuthor- Kántor,N., Unger,J., 2011.The most problematicvariable inthe courseofhuman-
ity(MCIDA)Award#AWD00033817).Thisresearchwasalsosupportedby
biometeorologicalcomfortassessment—themeanradianttemperature.Cent.Eur.
J.Geosci.3,90–100.https://doi.org/10.2478/s13533-011-0010-x.
aNaturalSciencesandEngineeringResearchCouncilofCanadaDiscovery
Kasten,F.,1980.Asimpleparameterizationofthepyrheliometricformulafordeterminingthe
GranttoESK.Anyopinions,findings,andconclusionsorrecommendations Linketurbidityfactor.Meteorol.Rundschau33,124–127.
expressedinthismaterialarethoseoftheauthorsanddonotnecessarilyre- Kasten,F.,Young,A.T.,1989.Revisedopticalairmasstablesandapproximationformula.
flecttheviewsofthesponsoringorganizations. Appl.Opt.28,4735.https://doi.org/10.1364/ao.28.004735.
Kjellstrom,T.,Crowe,J.,2011.Climatechange,workplaceheatexposure,andoccupational
healthandproductivityincentralAmerica.Int.J.Occup.Environ.Health17,270–281.
AppendixA.Supplementarydata https://doi.org/10.1179/107735211799041931.
Konarska,J.,Lindberg,F.,Larsson,A.,Thorsson,S.,Holmer,B.,2014.Transmissivityofsolarra-
diationthroughcrownsofsingleurbantrees-applicationforoutdoorthermalcomfortmodel-
Supplementarydatatothisarticlecanbefoundonlineathttps://doi. ling.Theor.Appl.Climatol.117,363–376.https://doi.org/10.1007/s00704-013-1000-3.
org/10.1016/j.scitotenv.2022.160301. Kosaka,E.,Iida,A.,Vanos,J.,Middel,A.,Yokohari,M.,Brown,R.,2018.Microclimatevariation
andestimatedheatstressofrunnersinthe2020TokyoOlympicMarathon.Atmosphere9.
https://doi.org/10.3390/atmos9050192(Basel).
References Krayenhoff,S.E.,Voogt,J.A.,2007.Amicroscalethree-dimensionalurbanenergybalance
model for studying surface temperatures. Bound.-Layer Meteorol. 123, 433–461.
https://doi.org/10.1007/s10546-006-9153-6.
AcuñaPazyMiño,J.,Lawrence,C.,Beckers,B.,2020.Visualmeteringoftheurbanradiative Krüger,E.L.,Minella,F.O.,Matzarakis,A.,2014.Comparisonofdifferentmethodsofestimat-
environmentthrough4πimagery.InfraredPhys.Technol.110,103463.https://doi.org/ ingthemeanradianttemperatureinoutdoorthermalcomfortstudies.Int.J.Biometeorol.
10.1016/j.infrared.2020.103463. 58,1727–1737.https://doi.org/10.1007/s00484-013-0777-1.
Alhadad,S.B.,Tan,P.M.S.,Lee,J.K.W.,2019.Efficacyofheatmitigationstrategiesoncore Kuras,E.R.,Richardson,M.B.,Calkins,M.M.,Ebi,K.L.,Hess,J.J.,Kintziger,K.W.,Jagger,
temperatureandenduranceexercise:ameta-analysis.Front.Physiol.10,71.https:// M.A.,Middel,A.,Scott,A.A.,Spector,J.T.,Uejio,C.K.,Vanos,J.K.,Zaitchik,B.F.,
doi.org/10.3389/fphys.2019.00071. Gohlke,J.M.,Hondula,D.M.,2017.Opportunitiesandchallengesforpersonalheatexposure
Asawa,T.,Oshio,H.,Tanaka,K.,2022.Portablerecordingsystemforsphericalthermography research.Environ.HealthPerspect.125.https://doi.org/10.1289/EHP556.
anditsapplicationtolongwavemeanradianttemperatureestimation.Build.Environ. Lachapelle,J.A.,Krayenhoff,E.S.,Middel,A.,Meltzer,S.,Broadbent,A.M.,Georgescu,M.,2022.
222,109412.https://doi.org/10.1016/J.BUILDENV.2022.109412. Amicroscalethree-dimensionalmodelofurbanoutdoorthermalexposure(TUF-Pedestrian).
Aviv,D.,Guo,H.,Middel,A.,Meggers,F.,2021.Evaluatingradiantheatinanoutdoorurban Int.J.Biometeorol.66,833–848.https://doi.org/10.1007/s00484-022-02241-1.
environment:resolvingspatialandtemporalvariationswithtwosensingplatformsand Lee,D.S.,Jo,J.H.,2021.Pan–tiltirscanningmethodfortheremotemeasurementofmeanradi-
data-drivensimulation.UrbanClim.35,100745.https://doi.org/10.1016/j.uclim. anttemperaturesatmulti-locationinbuildings.RemoteSens.13,2158.https://doi.org/10.
2020.100745. 3390/rs13112158.
Blazejczyk,K.,Epstein,Y.,Jendritzky,G.,Staiger,H.,Tinz,B.,2012.ComparisonofUTCIto Lee,D.S.,Jo,J.H.,2022.ApplicationofIRcameraandpyranometerforestimationof
selectedthermalindices.Int.J.Biometeorol.56,515–535.https://doi.org/10.1007/ longwaveandshortwavemeanradianttemperaturesatmultiplelocations.Build.Envi-
s00484-011-0453-2. ron.207,108423.https://doi.org/10.1016/j.buildenv.2021.108423.
Broadbent,A.M.,Declet-Barreto,J.,Krayenhoff,E.S.,Harlan,S.L.,Georgescu,M.,2022. Lee,H.,Mayer,H.,2016.Validationofthemeanradianttemperaturesimulatedbythe
Targetedimplementationofcoolroofsforequitableurbanadaptationtoextremeheat. RayMansoftwareinurbanenvironments.Int.J.Biometeorol.60,1775–1785.https://
Sci.TotalEnviron.811.https://doi.org/10.1016/j.scitotenv.2021.151326. doi.org/10.1007/s00484-016-1166-3.
Chen,L.,Ng,E.,2012.Outdoorthermalcomfortandoutdooractivities:areviewofresearch Lee,H.,Mayer,H.,Schindler,D.,2014.Importanceof3-Dradiantfluxdensitiesforoutdoor
inthepastdecade.Cities29,118–125. humanthermalcomfortonclear-skysummerdaysinFreiburg,SouthwestGermany.
Clark,S.S.,Chester,M.V.,Seager,T.P.,Eisenberg,D.A.,2019.Thevulnerabilityofinterdepen- Meteorol.Z.23,315–330.https://doi.org/10.1127/0941-2948/2014/0536.
denturbaninfrastructuresystemstoclimatechange:couldPhoenixexperienceaKatrina Lee,D.S.,Kim,E.J.,Cho,Y.H.,Kang,J.W.,Jo,J.H.,2019.Afieldstudyonapplicationofinfrared
ofextremeheat?Sustain.ResilientInfrastruct.4,21–35.https://doi.org/10.1080/ thermographyforestimatingmeanradianttemperaturesinlargestadiums.EnergyBuild.
23789689.2018.1448668. 202,109360.https://doi.org/10.1016/j.enbuild.2019.109360.
Colter,K.R.,Middel,A.C.,Martin,C.A.,2019.Effectsofnaturalandartificialshadeonhuman Li,D.H.W.,Yang,L.,Lam,J.C.,2012.Impactofclimatechangeonenergyuseinthebuiltenvi-
thermalcomfortinresidentialneighborhoodparksofPhoenix,Arizona,USA.UrbanFor. ronmentindifferentclimatezones-areview.Energy42,103–112.https://doi.org/10.
UrbanGreen.44.https://doi.org/10.1016/j.ufug.2019.126429. 1016/j.energy.2012.03.044.
Crank,P.J.,Middel,A.,Wagner,M.,Hoots,D.,Smith,M.,Brazel,A.,2020.Validationof Lin,T.-P.,Matzarakis,A.,Hwang,R.-L.,2010.Shadingeffectonlong-termoutdoorthermal
seasonalmeanradianttemperaturesimulationsinhotaridurbanclimates.Sci.TotalEn- comfort.Build.Environ.45,213–221.
viron.749.https://doi.org/10.1016/j.scitotenv.2020.141392. Lindberg,F.,Grimmond,C.S.B.,2011.Theinfluenceofvegetationandbuildingmorphology
Dunne,J.P.,Stouffer,R.J.,John,J.G.,2013.Reductionsinlabourcapacityfromheatstressunder onshadowpatternsandmeanradianttemperaturesinurbanareas:modeldevelopment
climatewarming.Nat.Clim.Chang.3,563–566.https://doi.org/10.1038/nclimate1827. andevaluation.Theor.Appl.Climatol.105,311–323.
Fanger,P.O.,1972.Thermalcomfort:analysisandapplicationsinenvironmentalengineering. Lindberg,F.,Holmer,B.,Thorsson,S.,2008.SOLWEIG1.0–modellingspatialvariationsof3Dra-
Appl.Ergon.3,181.https://doi.org/10.1016/s0003-6870(72)80074-7. diantfluxesandmeanradianttemperatureincomplexurbansettings.Int.J.Biometeorol.
Fiala,D.,Havenith,G.,Bröde,P.,Kampmann,B.,Jendritzky,G.,2012.UTCI-Fialamulti-node 52,697–713.
modelofhumanheattransferandtemperatureregulation.Int.J.Biometeorol.56, Lindberg,F.,Holmer,B.,Thorsson,S.,Rayner,D.,2014.Characteristicsofthemeanradiant
429–441.https://doi.org/10.1007/s00484-011-0424-7. temperatureinhighlatitudecities-implicationsforsensitiveclimateplanningapplica-
Gál,C.V.,Kántor,N.,2020.Modelingmeanradianttemperatureinoutdoorspaces,acompar- tions.Int.J.Biometeorol.58,613–627.https://doi.org/10.1007/s00484-013-0638-y.
ativenumericalsimulationandvalidationstudy.UrbanClim.32.https://doi.org/10. Lindberg,F.,Onomura,S.,Grimmond,C.S.B.,2016.Influenceofgroundsurfacecharacteristics
1016/j.uclim.2019.100571. onthemeanradianttemperatureinurbanareas.Int.J.Biometeorol.60,1439–1452.
Gasparrini,A.,Guo,Y.,Hashizume,M.,Lavigne,E.,Zanobetti,A.,Schwartz,J.,Tobias,A., https://doi.org/10.1007/s00484-016-1135-x.
Tong,S.,Rocklöv,J.,Forsberg,B.,2015.Mortalityriskattributabletohighandlowam- Luber,G.,McGeehin,M.,2008.Climatechangeandextremeheatevents.Am.J.Prev.Med.
bienttemperature:amulticountryobservationalstudy.Lancet386,369–375. 35,429–435.https://doi.org/10.1016/j.amepre.2008.08.021.
Häb,K.,Ruddell,B.L.,Middel,A.,2015.Sensorlagcorrectionformobileurbanmicroclimate Matzarakis,A.,Rutz,F.,Mayer,H.,2010.Modellingradiationfluxesinsimpleandcomplex
measurements.UrbanClim.14,622–635.https://doi.org/10.1016/j.uclim.2015.10.003. environments:basicsoftheRayManmodel.Int.J.Biometeorol.54,131–139.https://
Höppe,P.,1992.Anewproceduretodeterminethemeanradianttemperatureoutdoors.Wet- doi.org/10.1007/s00484-009-0261-0.
terundLeb.44,147–151. Merchant,C.,Meggers,F.,Hou,M.,Aviv,D.,Schneider,F.A.,Middel,A.,2022.Resolvingra-
Höppe,P.,1999.Thephysiologicalequivalenttemperature-auniversalindexforthebiome- diant:combiningspatiallyresolvedlongwaveandshortwavemeasurementstoimprove
teorologicalassessmentofthethermalenvironment.Int.J.Biometeorol.https://doi.org/ theunderstandingofradiantheatfluxreflectionsandheterogeneity.Front.Sustain.Cities,
10.1007/s004840050118. 82https://doi.org/10.3389/FRSC.2022.869743.
12

A.Middeletal. ScienceoftheTotalEnvironment859(2023)160301
Middel,A.,Krayenhoff,E.S.,2019.Micrometeorologicaldeterminantsofpedestrianthermal Potchter,O.,Cohen,P.,Lin,T.P.,Matzarakis,A.,2018.Outdoorhumanthermalperceptionin
exposureduringrecord-breakingheatinTempe,Arizona:introducingtheMaRTyobser- variousclimates:acomprehensivereviewofapproaches,methodsandquantification.
vational platform. Sci. Total Environ. 687, 137–151. https://doi.org/10.1016/j. Sci.TotalEnviron.https://doi.org/10.1016/j.scitotenv.2018.02.276.
scitotenv.2019.06.085. Russo,S.,Dosio,A.,Graversen,R.G.,Sillmann,J.,Carrao,H.,Dunbar,M.B.,Singleton,A.,
Middel,A.,Selover,N.,Hagen,B.,Chhetri,N.,2016.Impactofshadeonoutdoorthermal Montagna,P.,Barbola,P.,Vogt,J.V.,2014.Magnitudeofextremeheatwavesinpresent
comfort—aseasonalfieldstudyinTempe,Arizona.Int.J.Biometeorol.60,1849–1861. climate and their projection in a warming world. J. Geophys. Res. Atmos. 119,
https://doi.org/10.1007/s00484-016-1172-5. 12500–12512.https://doi.org/10.1002/2014JD022098.
Middel,A.,Lukasczyk,J.,Maciejewski,R.,2017.Skyviewfactorsfromsyntheticfisheye Simon,H.,Sinsel,T.,Bruse,M.,2021.Advancesinsimulatingradiativetransferincomplex
photosforthermalcomfortrouting—acasestudyinPhoenix,Arizona.UrbanPlan.2, environments.Appl.Sci.11,5449.https://doi.org/10.3390/app11125449.
19–30.https://doi.org/10.17645/up.v2i1.855. Stewart,I.D.,Oke,T.R.,2012.Localclimatezonesforurbantemperaturestudies.Bull.Am.
Middel,A.,Lukasczyk,J.,Maciejewski,R.,Demuzere,M.,Roth,M.,2018.SkyViewFactor Meteorol.Soc.93,1879–1900.https://doi.org/10.1175/BAMS-D-11-00019.1.
footprintsforurbanclimatemodeling.UrbanClim.25,120–134.https://doi.org/10. Stewart,I.D.,Krayenhoff,E.S.,Voogt,J.A.,Lachapelle,J.A.,Allen,M.A.,Broadbent,A.M.,
1016/j.uclim.2018.05.004. 2021.Timeevolutionofthesurfaceurbanheatisland.Earth'sFutur.9.https://doi.org/
Middel,A.,Lukasczyk,J.,Zakrzewski,S.,Arnold,M.,Maciejewski,R.,2019.Urbanformand 10.1029/2021EF002178.
compositionofstreetcanyons:ahuman-centricbigdataanddeeplearningapproach. Steyn,D.G.,1980.Thecalculationofviewfactorsfromfisheye-lensphotographs:research
Landsc.UrbanPlan.183,122–132.https://doi.org/10.1016/j.landurbplan.2018.12.001. note.Atmosphere-Oceanhttps://doi.org/10.1080/07055900.1980.9649091.
Middel,A.,AlKhaled,S.,Schneider,F.A.,Hagen,B.,Coseo,P.,2021.50gradesofshade.Bull. Vanos,J.K.,Rykaczewski,K.,Middel,A.,Vecellio,D.J.,Brown,R.D.,Gillespie,T.J.,2021.Im-
Am.Meteorol.Soc.1–35.https://doi.org/10.1175/bams-d-20-0193.1. provedmethodsforestimatingmeanradianttemperatureinhotandsunnyoutdoorset-
Middel,A.,Nazarian,N.,Demuzere,M.,Bechtel,B.,2022.Urbanclimateinformatics:anemerg- tings.Int.J.Biometeorol.https://doi.org/10.1007/s00484-021-02131-y.
ingresearchfield.Front.Environ.Sci.10,532.https://doi.org/10.3389/fenvs.2022. VDI,1994.VDI3789Part2:environmentalmeteorology,interactionsbetweenatmosphere
867434. andsurfaces;calculationoftheshort-andlongwaveradiation.VDIGuide.
Natephra,W.,Motamedi,A.,Yabuki,N.,Fukuda,T.,2017.Integrating4Dthermalinforma- Willmott,C.J.,1982.Somecommentsontheevaluationofmodelperformance.Bull.Am.
tionwithBIMforbuildingenvelopethermalperformanceanalysisandthermalcomfort Meteorol.Soc.63,1309–1369.
evaluationinnaturallyventilatedenvironments.Build.Environ.124,194–208.https:// Xia,Y.,Li,Y.,Guan,D.,Tinoco,D.M.,Xia,J.,Yan,Z.,Yang,J.,Liu,Q.,Huo,H.,2018.Assess-
doi.org/10.1016/j.buildenv.2017.08.004. mentoftheeconomicimpactsofheatwaves:acasestudyofNanjing,China.J.Clean.
Nazarian,N.,Krayenhoff,E.S.,Bechtel,B.,Hondula,D.,Paolini,R.,Vanos,J.,2022.Inte- Prod.171,811–819.https://doi.org/10.1016/j.jclepro.2017.10.069.
gratedassessmentofurbanoverheatingimpactsonhumanlife.Earth'sFutur.https:// Zander,K.K.,Botzen,W.J.W.,Oppermann,E.,Kjellstrom,T.,Garnett,S.T.,2015.Heatstress
doi.org/10.1002/ESSOAR.10508877.2. causessubstantiallabourproductivitylossinAustralia.Nat.Clim.Chang.5,647–651.
Nice,K.A.,Wijnands,J.S.,Middel,A.,Wang,J.,Qiu,Y.,Zhao,N.,Thompson,J.,Aschwanden, https://doi.org/10.1038/nclimate2623.
G.D.P.A.,Zhao,H.,Stevenson,M.,2020.Skypixeldetectioninoutdoorimageryusingan Zeng,L.,Lu,J.,Li,W.,Li,Y.,2018.Afastapproachforlarge-scaleSkyViewFactorestimation
adaptivealgorithmandmachinelearning.UrbanClim.31,100572.https://doi.org/10. usingstreet view images.Build.Environ. 135,74–84.https://doi.org/10.1016/j.
1016/j.uclim.2019.100572. buildenv.2018.03.009.
Nikolopoulou,M.,Lykoudis,S.,2006.Thermalcomfortinoutdoorurbanspaces:analysis
acrossdifferentEuropeancountries.Build.Environ.41,1455–1470.https://doi.org/10.
1016/j.buildenv.2005.05.031.
13
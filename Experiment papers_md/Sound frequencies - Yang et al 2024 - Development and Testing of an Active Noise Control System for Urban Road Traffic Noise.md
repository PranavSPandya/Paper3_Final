applied
sciences
Article
Development and Testing of an Active Noise Control System for
Urban Road Traffic Noise
BiyuYang1,2,JiacunYin3,ZhoujingYe3 ,SongliYang3andLinbingWang4,*
1 HighwaySchool,Chang’anUniversity,Xi’an710054,China;yang.yby@gmail.com
2 ZhaotongHighwayInvestmentDevelopmentCo.,Ltd.,Zhaotong657099,China
3 NationalCenterforMaterialsServiceSafety,UniversityofScienceandTechnologyBeijing,
Beijing100083,China;jcyin11@163.com(J.Y.);yezhoujing@ustb.edu.cn(Z.Y.);songliyang96@gmail.com(S.Y.)
4 SchoolofEnvironmental,Civil,AgriculturalandMechanicalEngineering,UniversityofGeorgia,
Athens,GA30602,USA
* Correspondence:linbing.wang@uga.edu
Abstract:Asurbanizationaccelerates,theincreasingnumberofvehiclesandtraveldemandscon-
tributetoescalatingroadtrafficnoisepollution.Althoughpassivenoisecontroltechniquessuchas
noisebarriersandgreenbeltseffectivelymitigatenoise,theyoccupyurbanspace,exacerbatingthe
scarcityandhighcostofalreadycongestedcityareas.Emergingasanovelnoisereductionstrategy,
activenoisecontrol(ANC)eliminatestheneedforphysicalisolationstructuresandaddressesthe
noisewithinspecificfrequencyrangesmoreeffectively.Thispaperinvestigatesthecharacteristicsof
urbanroadtrafficnoiseanddevelopsanANCprototype.UtilizingtheLeastMeanSquares(LMS)
algorithm,weconductactivenoisecontroltestsforvarioustypesofsingle-anddual-frequencynoise
withintheprototype’suniversalplatformtovalidateitsactualnoisereductioncapabilities. The
studydemonstratesthaturbanroadtrafficnoiseismostlyinthemid-tolow-frequencyrange(below
2000Hz).ThedevelopedANCprototypesignificantlyreducessingle-ordual-frequencynoisewithin
thisrange,achievingamaximumnoisereductionofnearly30dB(A).Futureresearchshouldexpand
noisereductiontestsacrossmorefrequencybandsandassessthenoisereductioneffectivenessagainst
realroadtrafficnoise.
Keywords: roadtrafficnoise;activenoisecontrol;prototypesystem;LMSalgorithm;single-and
dual-frequencytests
Citation:Yang,B.;Yin,J.;Ye,Z.;Yang,
S.;Wang,L.DevelopmentandTesting
ofanActiveNoiseControlSystemfor
UrbanRoadTrafficNoise.Appl.Sci.
1. Introduction
2024,14,175. https://doi.org/
10.3390/app14010175 Withthedevelopmentofurbanization,roadtrafficnoisehasbecomethemainsource
ofurbannoisepollution,accountingfor60–80%[1]. Noiseexceeding50dBaffectssleep
AcademicEditor:TaoZhu
andrest,noiseexceeding70dBtriggerspsychologicalstressanddistraction,andlivingfor
Received:16October2023 alongtimeinanoiseenvironmentofmorethan90dBcanseriouslydamagehearingand
Revised:10December2023 induceotherhealthproblems[2]. Therefore,itisnecessarytoexploreeffectiveroadtraffic
Accepted:13December2023 noisereductiontechniquestocurbroadtrafficnoisepollution.
Published:25December2023 Currently,passivenoisecontroltechniques,suchasconstructingsoundbarrierson
theroadside,aremainlyusedtoreducetheimpactofroadtrafficnoiseonpeople’sliving
areas, but the sound barriers not only obstruct the line of sight but also fail to reduce
specific-frequency noise [3,4]. In addition, by changing the texture of the road surface,
Copyright: © 2023 by the authors.
the selection of porous pavement materials and other means can effectively reduce the
Licensee MDPI, Basel, Switzerland.
high-frequency part of the traffic noise, but the low-frequency noise reduction effect is
Thisarticleisanopenaccessarticle
poor[5–9].
distributed under the terms and
Activenoisecontrol(ANC)reducesoreliminatesunwantedenvironmentalnoiseby
conditionsoftheCreativeCommons
generatingsoundwavesthatareoppositetotheexternalnoise[10]. Currently,activenoise
Attribution(CCBY)license(https://
controltechniqueshavebeenextensivelyresearchedandappliedinhoods,headphones,
creativecommons.org/licenses/by/
4.0/). pipelines,transformers,mines,andmagneticresonanceimagingequipment[11–18]. Inthe
Appl.Sci.2024,14,175.https://doi.org/10.3390/app14010175 https://www.mdpi.com/journal/applsci

Appl.Sci.2024,14,175 2of18
fieldofroadtraffic,activenoisecontroltechnologyiswidelyusedinvehiclenoisecontrol:
XuGegeetal. usedaconvolutionalneuralnetworktoclassifyroadsurfaces,improvingthe
vehiclenoisereductionbyadjustingtheLMSalgorithmbasedontheroadtype[19]. Feng
etal. experimentedwithusingANCinsidevehicles,usingalgorithmslikeTF-FxLMSand
SFxLMStolowerthecomputationaleffortsandcomparethealgorithmcomplexities[20].
Zhangetal. developedamultichanneladaptivealgorithmtocontroltheenginenoisein
vehicles, especiallythosewithprominentharmonicnoise[21]. Jiang’s groupenhanced
theSPSAalgorithmforANCinvehicles,targetinglow-frequencynoisenearthedriver’s
head,reducingtheinteriornoisebyanaverageof10dB[22]. Zhangproposedamethod
forgroupingvirtualreferencesignalsinvehicleroadnoisecontrolsystems, cuttingthe
computationalcomplexitybyabout24.4%andreducingnoisebyupto4.48dBintheroar
frequencyband[23].
The current active noise control technology has a good noise reduction effect in
closedspaceenvironments,butthenoisereductioneffectinopenspaceenvironmentswith
multiple sound sources needs to be improved [24]. As road traffic noise is affected by
manyfactorssuchastrafficflow,speed,andvehicleposition,itisnon-stationarynoise,
andvehiclesaremobilesoundsourceswithaDopplereffect. Itismuchmoredifficultto
achieveactivenoisecontrolinaspaciousopenenvironmentthaninaclosedspace[25].
Controllingroadsidetrafficnoisewithactivenoisecontrol(ANC)techniquespresents
significantchallenges. Researchershaveexploredvarioussolutions,focusingondifferent
aspectsofnoisecontrolinreal-worldsettings. OneapproachistouseANCinconfined
spacesliketunnels. Forinstance,ZhangdevelopedanANCdeviceforhighwaytunnels,
achieving up to 10.48 dB noise reduction, though the test was limited to a fixed noise
source[26]. MoonH.R.etal. expandedonthisbytestinganANCdeviceinatunnelmodel
withamorecomplexnoisesource,showingareductionof4–15dB[27].
However, in typical road traffic environments, the noise from moving vehicles is
oftendistantfromANCsystems,leadingtounstablesignals. Toaddressthis,Zhaoetal.
proposedusingafixedcoefficientfeedforwardANCsystemwithapseudo-noisesource,
demonstratingthefeasibilityofthisapproach[28]. Combiningactiveandpassivenoise
reduction techniques has also been explored. Lam et al. showed that mounting ANC
systemsontosoundbarrierscansignificantlycutdownthelow-frequencynoise[29,30].
Similarly,Denisetal.combinedsoundbarrierswithANCsystemstoidentifyeffectivenoise
reductionstrategies,includingtheplacementandnumberofmicrophonesandsecondary
soundsources[31].Tire–roadnoiseisanotherareaoffocus.Sahibetal.suggestedinstalling
ANCsystemsnearthetire–roadcontactpoint,acknowledgingthechallengesandresearch
needswiththismethod[32]. Zhangetal. exploredtheeffectofANCinsmallopenings,
findingthateffectivebroadbandnoisecontrolispossibleeveninlimitedspaces[33].
Insummary,applyingactivenoisecontrol(ANC)toroadsidetrafficnoiseischalleng-
ingandcurrentlyattheresearchstage. ThispaperaimstoadvancetheapplicationofANC
inthisfield. Ourapproachincludesanalyzingtheroadtrafficnoisecharacteristicsand
developinganANCprototypesystem. Thisdevelopmentinvolvedoptimizingthenoise
reduction algorithm parameters, understanding the ANC principles, and selecting the
appropriatesoftwareandhardware. Wealsoconductedextensivetestsonsingle-frequency,
dual-frequency,andrealtrafficnoise. Theresultsofthesetestsprovidevaluabletechnical
insightsforimplementingANCinroadsidenoisecontrol.
2. CharacterizationofRoadTrafficNoise
2.1. TrafficNoiseCollection
Tounderstandthevariationlawsofroadtrafficnoiseintermsoffrequency,intensity,
time, and different spaces, the UMIK-1 measuring microphone with a built-in sound
cardwasusedinthisexperiment,andtheoverallroadtrafficnoisewasmeasuredusing
the roadside method. The test process refers to Sound environment quality Standard
GB3096-2008[34]andTechnicalspecificationsforenvironmentalnoisemonitoringRoutine
monitoring for urban environmental noise HJ640-2012 [35]. At each monitoring point,

Appl.Sci.2024,14,175 3of18
theUMIK-1microphoneisusedtocollectthesoundintensityoftheroadtrafficnoisefor
20mincontinuously,thatis,thecurveofthesoundpressureamplitudevaryingwithtime.
FivetestpointsweresetupintheroadnetworkofBeijing;thepointswereselected
onthesideoftheroadandonthepedestrianbridgeofthestraightsectiontoavoidthe
interferenceofintersections,trafficlights,fixedsoundsources,crowds,reflectors,andother
influencingfactors. Thedistancebetweenthemicrophoneandtheroadsidewas20cm,and
theverticaldistancebetweenthemicrophoneandtheroadwas1.5m. Thespecificlocation
andenvironmentalparametersofthetestpointsareshowninFigure1.
Figure1. Roadtrafficnoisetestingsetupandlocations,temperature,wind,distance,andheight
fromroad.
After the road traffic noise is collected using the UMIK-1 measuring microphone,
the Smaart v8 software is used to analyze the data. The manufacturer of the UMIK-1
measuringmicrophoneisminiDSP,atechnologycompanyinHongKong. Thismicrophone
hasafrequencyresponserangeof20Hz–20kHzandasamplingrateof48kHz. Itisa
6mmelectretomnidirectionalmicrophone. TheSmaartv8,developedbyanacoustictest
andmeasurementcompanycalledRationalAcousticsLLCinWoodstock,CT,USA,isa
widelyusedtoolforaudiomeasurementandanalysis. Thispaperusesthelatestversion,
smaartv8. In order to analyze the frequency distribution law of road traffic noise, the
frequencyspectrumofthenoiseisanalyzed.
2.2. NoiseCharacteristicsAnalysis
2.2.1. OverallTrafficNoiseAnalysis
Continuouslycollecting20minofroadtrafficnoise,recordingvariousnoiseevents,re-
flectstheoverallnoiselevelofspecificroadsectionsorareas. Thisallowsforanassessment
oftheshort-termandlong-termimpactoftrafficnoiseonthesurroundingenvironmentand
community,enablingtheimplementationofcorrespondingnoisereductionmeasures.Road
trafficnoisetypicallycoversawidefrequencyrangeasitcomprisesvarioussoundsources,
includingnoisefromcarengines,braking,tire–roadcontact,carhorns,andaerodynamic
resistance. Thesesoundsourceshavedifferentfrequencyranges. Low-frequencynoise
typically falls within the range of 20 Hz to 200 Hz, usually including noise from large
vehicleengines. Mid-frequencynoiserangesfromapproximately200Hzto2000Hz,en-
compassingtire–roadcontactnoiseandnoisefromsomevehicleengines. High-frequency
noiseprimarilyexistsbetween2000Hzand20,000Hzandismainlycomposedofcarhorns
andbrakingnoise[36–39]. Conductingaspectrumanalysisoftheoverallnoiseallowsfor

Appl.Sci.2024,14,175 4of18
thereflectionoftheamalgamationofallnoisesources,accountingforvariousvehicletypes,
trafficflows,andvehiclespeeds. Figure2illustratestheoverallnoiselevelsatfivetesting
pointsandthespectrumanalysiswithinthe1/3octavefrequencybands.
Figure2.Noiselevelsandspectrumchartattestpoints.
Theresultsindicatethatvehiclespeedmaybeasignificantfactoraffectingthemagni-
tudeofroadtrafficnoise.Thevehiclespeedonthesecondaryhigh-speedserviceroadofthe
airport(Site5)isevidentlyhigherthanthatatSite2,Site3,andSite4,andcorrespondingly,
itsnoiselevelisalsonoticeablyhigherthanthesethreesections. ThevehiclespeedatSite1
isalsofast,butthemeasurementpointistoofarawayforadirectcomparison. Analysisof
thenoisespectrumrevealsthatwhilethespectralcharacteristicsofdifferentroadsections
generally follow the same trend, variations do exist. Peaks in the noise spectrum were
observedatfrequenciesrangingfrom50to80Hz,200to315Hz,and800to1250Hzacross
thefivetestingsites. Thisprimarilyoccursduetothediversetypesofvehiclesandnoise
sources at each test point, leading to the manifestation of multi-peak characteristics in
thefrequencyspectrum. Furthermore,atSite2,Site3,andSite4,thereisaprevalenceof
lower-frequencynoiseintherangeof20Hzto200Hz,surpassingthehigh-frequencynoise
between200Hzand2000Hz. Thisdiscrepancycanbeattributedtothefactthatthesethree
testpointsareeitherauxiliaryroadsorurbanexpressways,whereasignificantnumberof
vehiclessuchaselectricvehicles,buses,andtrucks,knowntoproducelower-frequency
noise,passthrough.Incontrast,Site1andSite5representurbanhigh-speedroadswherethe
predominantvehiclesaresmallcarswithhigherspeeds,resultinginfewerlow-frequency
noisesources. Alltestpointsexhibitpeakeffectsintherangeof800to1250Hz,mainlydue
tothefrictionnoisebetweentiresandroadsurfaces. Fastervehiclespeedsleadtomore
pronouncedeffectsoftireandroadsurfacefrictionnoise,explainingwhySite5,theairport
expressway,experiencessignificantlyhighernoiselevelsinthisfrequencyrangecompared
totheothertestpoints.
Theabovetestresultsindicatethatthetypeofvehicleanditsspeedhaveasignificant
impactonthegenerationoftrafficnoise.Therefore,anactivenoisecontrolsystemmayneed
toincorporatevehiclecharacteristicrecognitioncapabilitiestogeneratematchinganti-noise
basedonthespecificcharacteristicsandspeedsofdifferentvehicles. Alternatively,itmay
focusoncontrollingthenoisewithinacertainfrequencyrangethatisproducedbyvarious
typesofvehicles,suchasthepeaknoisewithintherangeof800to1250Hz.
2.2.2. NoiseCharacterizationofDifferentTypesofVehicles
Inresponsetocontinuouslycollectedroadtrafficnoise,noisedatafromdifferenttypes
ofvehiclespassingbywereextracted. Noisecharacteristicssuchasfrequency,duration,
andintensitywereanalyzed. Thisallowsforamorepreciseanalysisandassessmentof
the impact of individual vehicles on the overall noise level of the road section. For an
individualvehicle,thespeedatthemeasurementpointsignificantlyinfluencesthenoise

Appl.Sci.2024,14,175 5of18
generation. The experimental method in this study recorded a relatively concentrated
distributionofvehiclespeeds. Therefore,buildingupontheexperimentsanddrawingfrom
testsconductedbytheU.S.FederalHighwayAdministration[40],researchwasconducted
tosupplementandinvestigatevehiclenoisedataunderdifferentvehicletypesandspeeds.
ThevehicletypeswereclassifiedbasedonthecategorizationbytheU.S.FederalHighway
Administrationintolarge,medium,andsmallvehicles.Largevehiclesmainlyrefertotrucks
andbuses,mediumvehiclesincludesedansandSUVs,whilesmallvehiclesencompass
compactcarsandmotorcycles[41]. Figure3presentsthenoisespectrumofdifferentvehicle
typesatvariousdrivingspeeds.
Figure3.Thespectrumoftrafficnoiseatdifferentvehiclespeedsforthreevehiclecategories:small
vehicles,mediumvehicles,andlargevehicles.
Theaboveresultsindicatesignificantdifferencesinthenoisecharacteristicsamong
small, medium, and large vehicles. Vehicle noise primarily originates from the engine,
exhaust,thecontactbetweenthetiresandtheroadsurface,andaerodynamicnoise. When
comparingdifferentspeeds,atlowspeeds,thenoisefrommotorvehiclesispredominantly
enginenoise,whileathighspeeds,tirenoisebecomestheprimarycontributor[42]. Con-
sequently,asthevehiclespeedincreases,thesoundenergyofnoiseshiftstowardhigher
frequencies. However,theinfluenceofspeedonthenoisefrequencyislimited,withthe
vehicle type having a pronounced impact. In terms of the effect of the vehicle type on
noisefrequency,inthelow-frequencyrange(20–200Hz),thenoiseinthisfrequencyband
ismainlycomposedofenginenoiseandmechanicalvibrations. Smallvehiclestypically
havesmallerenginesandlighterbodystructures,resultinginlowernoiselevelsforsmall
vehicles,whilelargervehiclesgeneratemoresignificantvibrationsandenginenoise[43].
Inthe200–2000Hzfrequencyrange,theaerodynamicnoisegeneratedbyvehiclesrelative
toairmovementduringtravelismostpronounced. Asvehiclespeedincreases,thecorre-
spondingaerodynamicnoisealsorises. Duetothetypicallysuperiorbodystructureand
aerodynamicdesignofmediumandlargevehiclescomparedtosmallvehicles,theymay
producelessaerodynamicnoiseduringhigh-speeddriving[44]. Incontrast,smallervehi-
clesexhibitamorenoticeableincreaseinnoisewithinthisfrequencyrangeasspeedrises.In
the1000–4000Hzfrequencyrange,tireandroadsurfacefrictionnoisemaypredominantly
occur. Mediumandlargevehiclesoftenhavegreaterweightandalargercontactareawith
theroadsurface,leadingtostrongerinteractionswiththeroadsurfaceand,consequently,
highertire-roadcontactnoisewithinthisfrequencyrange.
Moreover, different types of vehicles generate noise with energy concentrated in
varying frequency ranges. When the driving speed exceeds 40 km/h, the peak center
frequencyofthenoisefromsmallcarsis1000Hz,withenergyprimarilyconcentratedin
the600–2000Hzrange. Thenoisefrommedium-sizedvehicleshasapeakcenterfrequency
at500Hz, withenergymainlydistributedwithin2000Hz. Forlargevehicles, thepeak
centerfrequencyis63Hz,withthemajorityofenergyspreadunder1000Hz. Researchhas

Appl.Sci.2024,14,175
6of18
shownthatonhighwayswithahighproportionoflargefreightvehicles,low-frequency
noiseismoreprominent,withthesoundenergymostlydistributedaround400Hz[45,46].
Therefore,whenformulatingnoisereductionstrategies,itisessentialtorefertotheactual
noisecharacteristicsofthetargetareaanddeterminethefrequencyrangewhereenergyis
primarilyconcentrated.
3. DevelopmentoftheActiveNoiseControlPrototypeSystem
3.1. PrinciplesofActiveNoiseControl
Activenoisecontrol(ANC)isapotentnoisereductiontechnology,operatingonthe
principleofsoundwaveinterference;thatis,whentwosoundwavesoverlapatthesame
spatiallocation,theyinteractwitheachotherbasedontheprincipleofsuperposition[47].
ANCachievesnoisereductionbygeneratingasecondarynoisesourcewithequalamplitude
andoppositephasetotheoriginalnoisesource,therebycausingthemtocanceleachother
outandeffectivelyreducingthenoiselevel.
Thisprocesscanbeexpressedmathematically. Ifthephasesoftwosoundwavesofthe
samefrequencyatacertainlocationinspaceareφ andφ ,theirsoundpressureamplitude
|     |     |     |     |     | 1   | 2   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
valuesare:
(cid:26)
|     |     |     | p   | = p cos(ωt−φ |     | )   |     |     |
| --- | --- | --- | --- | ------------ | --- | --- | --- | --- |
|     |     |     | 1   | 1a           | 1   |     |     |     |
(1)
|     |     |     | p   | = p cos(ωt−φ |     | )   |     |     |
| --- | --- | --- | --- | ------------ | --- | --- | --- | --- |
|     |     |     | 2   | 2a           | 2   |     |     |     |
Accordingtotheprincipleofsuperposition,thetotalsoundpressureisthesumof
theirindividualsoundpressures:
| =     | +p  | = cos(ωt−φ |     | )+p cos(ωt−φ |     | )=  | cos(ωt−φ) |     |
| ----- | --- | ---------- | --- | ------------ | --- | --- | --------- | --- |
| p p 1 | 2   | p 1a       |     | 1 2a         |     | 2   | p a       | (2) |
where,
(cid:40)
|     |     | p2 = | p2 +p2     | +2p      | cos(φ     | −φ  | )   |     |
| --- | --- | ---- | ---------- | -------- | --------- | --- | --- | --- |
|     |     | a    |            | 1a       | p 2a      | 2   | 1   |     |
|     |     |      | 1a         | 2a       |           |     |     | (3) |
|     |     |      | φ = arctan | p1asinφ1 | +p2asinφ2 |     |     |     |
|     |     |      |            | p1acosφ1 | +p2acosφ2 |     |     |     |
Thesoundpressureamplitudeofthecompositesoundwavedependsonthephase
differenceφ −φ ofthetwosoundwaves,andthesquareofthesoundpressureamplitude
2 1
reflectstheaveragesoundenergydensityεinthesoundfield.
p2
|     |     |     |     | = a   |     |     |     |     |
| --- | --- | --- | --- | ----- | --- | --- | --- | --- |
|     |     |     |     | ε     |     |     |     | (4) |
|     |     |     |     | 2ρ c2 |     |     |     |     |
0 0
Takingthetimeaverageoftheaboveequationyieldstheaverageenergydensityof
thecompositesoundwave,i.e.,
p p
|     |     | ε = | ε +ε | + 1a 2a | cos(φ | −φ ) |     | (5) |
| --- | --- | --- | ---- | ------- | ----- | ---- | --- | --- |
|     |     |     | 1    | 2 c2    | 2     | 1    |     |     |
ρ 0
0
Here,if p = p ,and φ −φ = ±π,±3π...equalsanyoddmultipleofπ,thenthe
| 1a  | 2a  | 2   | 1   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
compositesoundpressureamplitudeandtheaveragesoundenergydensityarezero,with
thetwosoundwavescancelingeachotherout:
(cid:40)
|     |     |        | p      | a = p 1a −p | 2a =0 |        |     |     |
| --- | --- | ------ | ------ | ----------- | ----- | ------ | --- | --- |
|     |     |        | p1ap2a | p2          | p2    | p1ap2a |     | (6) |
|     | ε   | = ε +ε | −      | = 1a        | + 2a  | −      | =0  |     |
|     |     | 1      | 2 ρ0c2 | 2ρ0c2       | 2ρ0c2 | ρ0c2   |     |     |
|     |     |        |        | 0 0         |       | 0      | 0   |     |
Whentwosoundwaveshaveequalamplitudeandtheirphasedifferenceisπ(orany
oddmultipleofπ),thetwosoundwavescompletelyinterferewitheachother,resultingin
atotalsoundpressureof0. Thismeansthatthetotalsoundenergydensityatthislocation
isalso0,i.e.,thesoundenergydensityofthecompositesoundfieldatthislocationiszero.
Toeliminatethenoiseatacertainlocation,asoundwaveoppositetothenoisecan
beemittedsothattheirphasedifferenceisπ,therebyobtainingavirtuallysilentzoneat
thatlocation. Aslow-frequencysoundwaveshavelongwavelengths,ANCsystemscan

Appl.Sci.2024,14,175 7of18
accuratelydetectandcanceloutsuchnoise,givingANCanaturaladvantageindealing
withlow-frequencynoise. Bycontrast,high-frequencynoise,withitsshorterwavelength
andrapidspatialchanges,poseschallengestothepracticalapplicationofANC.Sinceroad
trafficnoiseisprimarilylow-frequency,ANCtechnologyhasshownobviousadvantagesin
thisfield.
3.2. StructureoftheActiveNoiseControlSystem
Thedesignandimplementationofactivenoisecontrolsystemscantakemanyforms,
includingnarrowbandfeedforwardsystems,broadbandfeedforwardsystems,feedback
systems,hybridsystems,andmultichannelsystems. Consideringthesystem’sapplicability
anddevelopmentcost,weadoptedthestructureofabroadbandfeedforwardsystemfor
theresearchpresentedinthispaper,asshowninFigure4.
Figure4.Schematicdiagramofthebroadbandfeedforwardsystem[48].
The main components of the broadband feedforward active noise control system
includeareferencesensor,anerrorsensor,asecondarysoundsource,andacontroller. The
referencesensor,functioningasanon-acousticsensor,hastheprimaryroleofpredicting
andcapturingfuturenoise,i.e.,thereferencesignal. Thispredictivecapabilityenablesthe
feedforwardsystemtorespondbeforethenoisearrives. Theerrorsensor,typicallyplaced
intheareawherenoisereductionisneeded,isresponsibleforcapturingreal-timenoise
thathasnotbeeneliminated,i.e.,theso-callederrorsignal. Thecontrolleranalyzesthe
signalscollectedbythereferencesensorandtheerrorsensor,generatingasignalwithequal
amplitudeandtheoppositephasetothenoisetodrivethesecondarysoundsource. The
secondarysoundsourcethenemitstheinversesoundwavegeneratedbythecontroller,
interferingwiththeoriginalnoisetoachievenoisereductionorelimination[49].Broadband
feedforwardsystemsmainlytargetrandombroadbandnoises,suchastrafficnoiseand
wind noise. They rely on predicting the reference signal, which is crucial for handling
non-periodicandrandomnoise.
Inthedesignedadaptiveactivenoisecontrolsystem,theprimarypathandthesec-
ondary path are key components. The primary path describes the sound propagation
characteristicsfromtheoriginalnoisesourcetotheerrorsensor. Understableenvironmen-
talconditions(e.g.,enclosedindoorenvironments),theprimarypathremainsrelatively
constant. However, in practical applications, minor changes in the environment (e.g.,
openingwindows,movinglocations,theappearanceofnewobjects,etc.) canaffectthe
primarypath. Thesecondarypathdescribesthesoundpropagationcharacteristicsfrom
thesecondarysoundsourcetotheerrorsensor. Thispathinvolvescomponentssuchas
D/Aconverters,audiofilters,poweramplifiers,theacousticpathfromtheloudspeakerto
theerrorsensor,theerrorsensoritself,andA/Dconverters. Duetoitscomplexity,minor

Appl.Sci.2024,14,175
8of18
changesincomponentsordifferentimplementationmethodsmaycausechangesinthe
secondarypath[50,51].
3.3. ActiveNoiseControlSystemAlgorithm
Intherealmofactivenoisecontrolsystems,theLeastMeanSquares(LMS)algorithm
holdsafundamentalandcrucialpositionamongadaptivefilteringalgorithms. TheLMS
algorithmemploysasteepestdescentapproach,recursivelyupdatingthefiltercoefficients.
Figure5presentsanadaptivefiltermodelbasedontheLMSalgorithm:
Figure5.AdaptivefilterbasedonLeastMeanSquares(LMS)algorithm[52,53].
Inthismodel,thereferencesignal X(n),whichrepresentstheoriginalnoisesignal,
is captured by an external sensor and fed into the FIR (Finite Impulse Response) filter.
This filter creates an output signal y(n) based on its weights and X(n). Ideally, y(n)
d(n)inmagnitudebutbeinverselyphasedformanual
shouldmatchtheoriginalnoise
cancellationattheerrorsensorlocation,yieldingthesmallesterrorsignale(n). Thesystem
e(n)
strives to minimize via continuous adaptive updates, thereby achieving optimal
noisecancellation.
WefirstdefinethevectorofthereferencesignalX(n)attimenandthevectorofthe
filterweightcoefficients:
|     | X(n) = | [x(n),x(n−1),...,x(n−L+1)]T |           |            |     | (7) |
| --- | ------ | --------------------------- | --------- | ---------- | --- | --- |
|     |        | (cid:104)                   |           | (cid:105)T |     |     |
|     | W(n)   | = w (n),w                   | (n),...,w | (n)        |     | (8) |
|     |        | 0                           | 1 (L−1)   |            |     |     |
Thegoalistominimizetheerrorsignale(n),themeansquarevalueofwhichis:
|           |                     |     | (cid:20)(cid:16)   |     | (cid:21)  |     |
| --------- | ------------------- | --- | ------------------ | --- | --------- | --- |
| (cid:104) | (cid:105) (cid:104) |     | (cid:105)          |     | (cid:17)2 |     |
| E e2(n)   | = E (d(n)−y(n))2    |     | = E d(n)−WT(n)X(n) |     |           | (9) |
Next, we need to find the filter coefficients that minimize the mean square value,
e(n)
thereby minimizing the mean square value of In the LMS algorithm, the steepest
descent method is used; each step of the weight vector change is proportional to the
negativevalueofthegradientvector[54],formalizedas:
|     |     | W(n+1) | =W(n)−µ∇(n) |     |     | (10) |
| --- | --- | ------ | ----------- | --- | --- | ---- |
Here, ∇(n) denotes the gradient vector of the nth iteration, and µ represents the
iterationstepsize. Thegradientvectoriscalculatedas
(cid:2) (cid:3)
∂E e2(n)
|     | ∇(n) | =   | = −2E[e(n)X(n)] |     |     | (11) |
| --- | ---- | --- | --------------- | --- | --- | ---- |
∂W(n)
Takingthegradientofasinglesamplee2(n)asanestimateofthemeansquareerror
gradient,weobtainthegradientestimate:
∂e2(n)
∇ˆ(n)
|     |     | =   | = −2e(n)X(n) |     |     | (12) |
| --- | --- | --- | ------------ | --- | --- | ---- |
∂W

Appl.Sci.2024,14,175 9of18
Sincethegradientestimate∇ˆ(n)isanunbiasedestimationoftherealgradient∇(n),
itcanreplacetherealgradientinEquation(10),leadingtothefilterweightupdateformula:
W(n+1) =W(n)−µ∇ˆ(n) =W(n)+2µe(n)X(n) (13)
Toensurethesystemstability,therangeoftheiterationstepsizeµmustberestricted.
AccordingtotherequirementsoftheLMSalgorithm,theiterationstepsizeshouldbe:
1
0< µ < (14)
λ
max
whereλ isthelargesteigenvalueoftheautocorrelationmatrixRofthereferencesignal.
max
ThestepsforthebroadbandfeedforwardLMSalgorithmaresummarizedasfollows:
(1)ThereferencesensorcapturesthereferencesignalX(n)andfeedsitintotheadaptive
filter. The error sensor collects the error signal e(n) at the noise cancellation point and
feedsitintotheadaptivefilter. (2)TheadaptivefilterusesthereferencesignalX(n)and
theerrorsignale(n)toupdatethefilterweightW(n),accordingtoEquation(13). (3)The
updatedfilterweightisusedtogenerateanewoutputsignaly(n),andatthestartofthe
nexttimestep,steps1and2arerepeated[55,56]. Usingcontinuousadaptiveupdates,we
caneffectivelyreducethenoise.
3.4. HardwarePlatformConstruction
Theactivenoisecontrolprototypesystemiscomposedofafield-programmablegate
array(FPGA)developmentboard,twoaudiomodules,areferencesensor,anerrorsensor,
and an active loudspeaker. The overall design is depicted in Figure 6, with a detailed
breakdownofthehardwarecomponentspresentedinTable1.
Figure6.Hardwareplatformdesignofactivenoisecontrolprototypesystem.
Intheoperationofthesystem,thereferencesensorisplacedclosetothenoisesource
tocollectthereferencesignal,andtheerrorsensorisplacedinthenoisecancellationareato
collecttheerrorsignal. Eachsensorisconnectedtotheaudioinputinterfaceoftherespec-
tiveaudiomodule,enablingreal-timesignaltransmission. Theaudiomoduleperforms
analog-to-digitalconversionandfilteringamplificationbeforetransmittingthesignalto
theFPGAforalgorithmanalysis. Theresultantsecondarysourcesignal,aftertheaudio
module’s digital-to-analog conversion and filtering amplification, is transmitted to the
activeloudspeaker. Thesecondarysourcesoundwaveemittedbytheactiveloudspeaker
cancelsthenoisesourcesoundwaveinthenoisecancellationarea,reducingthenoiselevel
inthedesiredarea.

Appl.Sci.2024,14,175
10of18
Table1.Thehardwaredescriptionofactivenoisecontrolprototypesystem.
| Hardware             | Model  | Manufacturer              | Specifications    | Function         |
| -------------------- | ------ | ------------------------- | ----------------- | ---------------- |
|                      |        | AlinxElectronicTechnology | 85,000logicunits, | Codedebuggingand |
| FPGADevelopmentBoard | AX7020 |                           |                   |                  |
|                      |        | (Shanghai,China)Co.,Ltd.  | 220multipliers    | systemcontrol    |
Audiodecoding,
Samplerate:8–96KHz,
AudioModule WM8731 CirrusLogicInc.(Austin,TX,USA) analog-to-digital
datalength:16–32bit
conversion
Noiseacquisition
| ReferenceSensor |            |                                 | Frequencyresponserange:  |                       |
| --------------- | ---------- | ------------------------------- | ------------------------ | --------------------- |
|                 |            | ShenzhenHuayunZiyuanElectronics |                          | atsource              |
|                 | Microphone |                                 | 20Hz–20kHz,3.5mm         |                       |
|                 |            | Co.,Ltd.(Shenzhen,China)        |                          | Noiseacquisitioninthe |
| ErrorSensor     |            |                                 | audiojack,unidirectional |                       |
cancellationarea
|                   |         | FeixinyuanAudioCompany. | Frequencyresponserange: | Secondarysourceofin |
| ----------------- | ------- | ----------------------- | ----------------------- | ------------------- |
| ActiveLoudspeaker | SM-1800 |                         |                         |                     |
|                   |         | (Beijing,China)         | 20Hz–20kHz              | thecancellationarea |
3.5. SystemSoftwareDevelopment
Upon finalizing the hardware selection, a software system is needed to drive the
hardware platform and achieve functionalities such as audio signal transmission and
algorithmexecution.
(1)FPGADevelopmentToolsandLanguage
ThisstudyusedtheVivado2018.3softwarefordevelopment. Vivadoisoneofthe
primarydevelopmenttoolsforFPGAs,supportingvariousdatainputmethods,integrated
synthesizers, and simulators. It can complete the full development process from new
projectdesigninputtogeneratingbitstreamforFPGAdownload.Thedevelopmentprocess
utilized Verilog HDL, a hardware description language that supports hardware devel-
opment, verification, synthesis, and testing functions. The related active noise control
algorithmscanbeimplementedusingVerilogHDL.Notably,comparedtohardwarefilters,
FPGAmulti-stageadaptivefiltersimplementedviasoftwaredemonstrategreaterflexibility
andstability.
(2)AudioDataInteractionandProcessing
TheaudiodatainteractionbetweentheWM8731audiodecodingchipandtheFPGA
main chip is achieved via two serial pins, ADCDAT and DACDAT, necessitating data
parallelization. AsshowninFigure7,thedatatransmissionandprocessingofnoisesignals
includethefollowingsteps.
Figure7.Noisesignaldatatransmissionandprocessing.
Initially,theFPGAdevelopmentboardconfigurestheWM8731audiochip’ssampling
rate,dataformat,andconversioninitiationfunctionsusingtheI2Cconfigurationmodule,
setting the sampling rate at 48 KHz, and data length for conversion at 16 bits. Next,
theWM8731chipemploystheADCconversionmoduletotransformtheanalogsignal
collectedbythesensorintoadigitalsignal,inputtingthisintotheFPGA’sserial-to-parallel
conversionmodule. Thismodulethentransformstheinputserialdigitalsignalintoparallel

Appl.Sci.2024,14,175 11of18
16-bitdataandinputsitintothedatareorganizationmodule. Afterundergoingde-zeroing
andredundancyremovalinthismodule,thedataareinputintotheANCalgorithmmodule.
The ANC algorithm module employs the Least Mean Squares (LMS) algorithm, a
commonlyusedadaptivefilteringalgorithmsuitableforprocessingsignalswithunknown
attributes. Thecalculatedsecondarysourcesignalissenttotheparallel-to-serialconversion
module,whichtransformstheparalleldatabackintoserialdataandsendsittotheWM8731
chip to complete the digital-to-analog conversion. Finally, the active speaker emits the
secondarysourceaudio,completingtheactivenoisecontrol.
(3)ControlProgramandDebugging
Intheoverallsystem,FLASHisprimarilyusedforcontrolprogramstorage,whilethe
JTAGinterfaceisusedforprogramdebuggingandburning. Thesetwoelementsjointly
ensurethesystem’sstableoperationandeffectivedebugging.
4. Single-andDual-FrequencyNoiseReductionTests
4.1. Methodology
Thedevelopedactivenoisecontrol(ANC)prototypesystemconsistsofareference
speaker,acontroller,asecondarysourcespeaker,andanerrorsensor. Theexperimental
designisillustratedinFigure8.
Figure8.Schematicdiagramofthedevelopedactivenoisecontrolsystemtest.
ToevaluatetheperformanceoftheANCsystem,weconductedcomparativeindoor
testsfollowingthesesteps:
(1)ProgramBurn-in: Thecomputerisconnectedtothecontrollerthroughasimulator
forprogramburn-in. Oncetheprogramisburnedin,thecontrollercanoperateindepen-
dentlyfromthecomputer. Duringthistime,thelabenvironmentiskeptquiettoprevent
irrelevantnoisefromaffectingthetestresults.
(2)EnvironmentalNoiseMeasurement: AUMIK-1measuringmicrophoneconnected
to the first computer is used, with the REW V5.20.3 software (a professional acoustics
measuringandanalysistool)recordingthenoisedatathroughouttheexperiment. Firstly,
wemeasureandrecordtheenvironmentalnoiseinthelaboratory. Beforethemeasurement,
allotherdevicesareswitchedofftoavoidinterference.
(3)SoundPressureLevelMeasurement: WiththeANCsystemturnedoff,theUMIK-1
microphoneiscombinedwiththeerrorsensortomeasurethesoundpressurelevelofthe
areatobesilenced. Theprimarysourcespeakerisconnectedtothesecondcomputer,using
theREWV5.20.3softwaretogeneratesimulatednoisesourcesofdifferentfrequencies. For
convenienceofcomparison,thevolumeoftheprimarysourcespeakerisadjustedsothat
thesoundpressurelevelmeasuredatthemicrophoneisalwaysmaintainedat70dBA.
(4)ObservationofNoiseReductionEffectandParameterAdjustment: OncetheANC
system is activated, we can observe real-time noise reduction effects using the second
computer. Toachievethebestnoisereductioneffect,weadjusttheiterationstepsizevia
theVIOmodule(auserinterfaceforcontrollingsystemparameters),modifytheprogram

Appl.Sci.2024,14,175 12of18
toadjustthefilterorder,andchangethedistancebetweentheprimarysource,reference
speaker,secondarysource,anderrorsensortoobtaintheoptimalparametercombination.
Thepresentedmeasurementsarefrommultipletests,andweselectedtheresultswiththe
bestnoisereductioneffect.
(5)ComparisonofTestResults: Finally,wecomparethesoundpressureleveldataof
theareatobesilencedbeforeandafterturningontheANCsystemtoassesstheeffectiveness
oftheANCsystem.
4.2. Single-FrequencyTestResultAnalysis
Inlinewithourpreviousresearch,weobservedcommonalitiesintheoverallnoise
from different types of roads and vehicles. Peak effects surfaced within the frequency
rangesof50–80Hz,200–315Hz,and800–1250Hz. Thus,ournoisereductionteststargeted
thefrequencybandsof200Hz,500Hz,800Hz,1000Hz,and1200Hz.
Given the finite speed of sound propagation, it is necessary for the sound waves
emittedbythesecondarysourcetomeetthenoiseatthecorrecttimeandplacetoeffectively
canceloutthenoise. Therefore,beforestartingthetests, wefirstadjustedthedistances
between the various components of the active noise control system—primary source,
secondarysource,referencesensor,anderrorsensor—toidentifytherelativepositionsthat
yieldthemaximumnoisereduction[57]. Furthermore,duetothevaryingwavelengths
and phases of sound waves at different frequencies, the optimal distances between the
componentsforeffectivephasecancellation(i.e.,noisereduction)willdiffer.
Withtheprimarysourcesetat70dBAandtheindoorambientnoiseat39.2dBA,for
eachtestfrequency,weiterativelyadjustedthedistancesbetweentheprimarysource,sec-
ondarysource,andreferencesensortoascertainthepositionsthatproducedthemaximum
noisereduction. Multiplenoisereductiontestswereconductedatthesepositions,andthe
resultsshowedthateachtestwasverycloseinoutcome. Hence,themedianofthesetest
resultswasselectedforcomparativeanalysis,asshowninFigure9. Figure10presentsa
comparisonofthespectraldatabeforeandaftertheactivationoftheactivenoisecontrol
systemat500Hz.
Figure9.Maximumnoisereductionandrelativepositionsunderdifferentfrequencynoise.

Appl.Sci.2024,14,175 13of18
Figure10.Single-frequencytestresults.
AsdemonstratedinFigure10,theactivenoisecontrolsystemprovidedsignificant
noisereductionforsingle-frequencynoise,withareductionofaround20dBA.Notably,
the500Hznoisesawthemostsignificantreduction,at25.4dBA,bringingthenoiselevelin
thetargetareaclosetotheambientnoiselevel. Theleastreductionwasseenat1200Hz,
whichdecreasedby8.8dBA.
Usingtesting,weobservedthatthenoisereductionperformanceforextremelylow
orhighfrequencieswasrelativelyinferior. Althoughtheoreticallylower-frequencynoise
shouldbeeasiertoreduce,theactualnoisereductioneffectwashinderedduetothepoor
frequencyresponseofthespeakeratlowerfrequencies. Ontheotherhand,thereal-time
requirements of the active noise control system are higher for higher-frequency noise,
whichalsoimpactedthenoisereductioneffect. Thesefindingsindicateacloserelationship
between the noise reduction effect of the active noise control system and the choice of
hardwareandsoftwareconfiguration.
4.3. Dual-FrequencyTestResultAnalysis
Toevaluatetheperformanceofouractivenoisecontrolsystemundermorecomplex
acousticsignals,wetesteditusingtwospecificdual-frequencynoisesources,100Hz+1000Hz
and200Hz+1000Hz, with reference to the frequency range where traffic noise spikes
occur. Followingtheexperimentalstepsoutlinedearlier,weidentifiedthedistancesthat
yieldedthebestnoisereductionresultsandrepresentedtheminFigure11.
Figure11.Maximumnoisereductionandrelativepositionsunderdifferentdual-frequencynoise.

Appl.Sci.2024,14,175 14of18
AspertheresultsshowninFigure12,notablenoisereductionwasobservedatboth
frequencieswhenthenoisesourcewas200Hz+1000Hz,withanapproximatereductionof
15dB(A).However,whenthenoisesourcewas100Hz+1000Hz,wenoticedasignificant
noisereductionat1000Hz,butthenoisereductionat100Hzwaslesspronounced.
Figure12. Dual-frequencytestresults. (a)Comparisonfor100Hz+1000Hz. (b)Comparisonfor
200Hz+1000Hz.
Beforethesystemwasturnedon,thesoundpressurelevelat100Hzwasdistinctly
lowerthan70dB(A).Thisresultfurtherconfirmedthecrucialimpactofthesoundsystem
configurationontheeffectivenessofactivenoisecontrol. Factorssuchasthefrequency
responserangeofthesoundsystemandgainsettingscouldinfluencetheperformance
of noise reduction. Hence, we suggest optimizing the relevant configurations of the
soundsystem—forinstance,expandingthefrequencyresponserangeandadjustinggain
settings—toachievesuperiornoisereductionoutcomes.
5. Discussion
Inactivenoisecontroltestsforsingle-anddual-frequencynoise,thesystemdemon-
stratedsignificantnoisereductionwithintheprimaryfrequencyrangeofroadtrafficnoise.
Moreover,itexhibitedfastconvergence,stableoperation,andstrongversatility. Thispaves
thewayforthepotentialapplicationofactivenoisecontroltechnologyintherealmofroad
traffic. Intestswithactualroadtrafficnoise,wedidnotobservesignificantnoisereduction.
However,itclearlyidentifiedtheissuesthatneedtobeaddressedinfutureresearch:
(1)Theactivenoisecontrolsystemfailedtoachievesignificantnoisereductionwhen
dealingwithactualroadtrafficnoise. Thiscouldbeattributedtofactorssuchastraffic

Appl.Sci.2024,14,175 15of18
volume,vehicletypes,speed,etc.,leadingtothecomplexityoftheprimaryandsecondary
pathparametersanddiversityinnoisefrequencycomponents. Forinstance,heavyvehi-
clesmightproducemorelow-frequencynoise, whilemotorcyclesmightgeneratemore
high-frequencynoise. Thesevariationscouldleadtochangesintheprimarypathparam-
eters, secondary path parameters, etc., and with eachvehicle serving asa noise source,
differentnoisesourcesmightinterferewitheachother,makingsoundwavepredictionand
cancellationmorecomplex.
(2)Itwasfoundthatthespeakersandsensorshadpoorerfrequencyresponsetolow-
frequencynoise,whichmaypreventthesystemfromaccuratelygeneratingandmeasuring
low-frequencynoise,therebyaffectingtheaccuracyofnoisereduction. Similarly,dueto
the hardware system’s latency, real-time processing of high-frequency noise also faces
challenges,potentiallyleadingtophaseshiftsandnoiseincrease.
(3)Intheactivenoisecontrolsystem,electronicdevices,wiring,andacousticalfactors
between the secondary source and the error sensor might cause latency issues. These
issueshavenotbeenfullyconsideredinthecurrentLMSalgorithm,thusaffectingthenoise
reductionperformance. Moreover,becauseroadtrafficnoiseisbroadbandnoisewitha
widefrequencydistribution,thisleadstoasituationintheLMSalgorithmwherethelarger
thefrequencyrangeoftheinputsignal,thehigherthesignalcorrelation,andtheslower
thealgorithmconverges,therebyaffectingthenoisereductioneffect.
Toadapttothecharacteristicsofroadtrafficnoise,futureresearchcouldbebasedon
thetheoryofreferencesub-bandfilteringtoimprovethealgorithm’sconvergencespeed
andnoisereductioneffectbyprocessingtheinputsignalintoseveralnarrow-bandnoise
signals. Considerationcouldalsobegiventoenhancingthehardwareperformanceofthe
sensorsandspeakers,suchasimprovingthesensorsignal-to-noiseratio,speakerfrequency
responsecharacteristics,controllercomputationalspeed,systemintegration,andstability,
especiallyassessingtheactivenoisecontrolperformanceofspeakersinthelow-frequency
range. Furtherexplorationofactivenoisecontrolapplicationsinthetrafficdomaincanalso
becarriedout,includingacombinationwithpassivetechnologiessuchasnoisebarriers
andresearchintoactivenoisecontroltechnologyforvehicletire–roadnoise.
6. Conclusions
Athoroughanalysisofthecharacteristicsofvarioustypesofroadtrafficnoisewas
conductedinthisstudy,culminatinginthesuccessfuldevelopmentofaprototypeforan
activenoisecontrolsystemspecificallytargetingroadtrafficnoise. Activenoisecontrol
testswereperformedinalabenvironment,andtheresultsindicatedthatthesystemcould
effectivelyreducesingle-frequencyanddual-frequencynoise. Thissuggestsinnovative
ideasandstrategiesfortheapplicationofactivenoisecontroltechnologyinroadtraffic
noisemanagement. Themainfindingsareasfollows:
(1)Fieldtrafficnoisetestswereconductedusingaself-assemblednoisecollectionand
analysissystem. Thetypeandspeedofvehicleswerefoundtosignificantlyimpactthe
overalltrafficnoiseproduced. However,themixedtrafficnoisetypicallylieswithinthe
rangeof50–80Hz,200–315Hz,and800–1250Hz.
(2)Fordifferenttypesofvehicles,whenthespeedexceeds40km/h,thetrafficnoise
generated by small vehicles is concentrated around 1000 Hz, medium vehicles around
500Hz,andlargevehiclesaround63Hz.
(3)AnactivenoisecontrolprototypesystembasedonaFPGAwasconstructed,and
ingle-frequency and dual-frequency noise reduction tests were performed. The noise
reductioneffectwasfoundtobesatisfactoryforsingle-frequencynoise. Whenthenoise
frequencywas500Hz,itcouldbereducedbynearly30dBA.Fordual-frequencynoise,at
200Hz+1000Hz,areductionof15dBAwasachieved.

Appl.Sci.2024,14,175 16of18
AuthorContributions:Allauthorscontributedsignificantlytotheworkpresentedinthismanuscript.
J.Y.,B.Y.andL.W.designedandperformedtheexperiments;B.Y.,J.Y.,Z.Y.andS.Y.analyzedthedata
andwrotethismanuscript;B.Y.andL.W.providedvaluableadviceandcontributions.Allauthors
havereadandagreedtothepublishedversionofthemanuscript.
Funding:ThisworkwassupportedbytheTechnologyInnovationandDemonstrationProjectofthe
DepartmentofTransportofYunnanProvince(2021)no.25,fundedbytheDepartmentofTransport
ofYunnanProvince.ThisworkwasalsosupportedbytheNationalNaturalScienceFoundationof
China(no.52208414).
DataAvailabilityStatement: Thedatapresentedinthisstudyareavailableonrequestfromthe
correspondingauthor.Thedataarenotpubliclyavailableduetotheconfidentialityrequirementsof
theproject.
ConflictsofInterest:AuthorBiyuYangwasemployedbythecompanyZhaotongHighwayInvest-
mentDevelopmentCo.,Ltd.Theremainingauthorsdeclarethattheresearchwasconductedinthe
absenceofanycommercialorfinancialrelationshipsthatcouldbeconstruedasapotentialconflict
ofinterest.
References
1. Carter,N.L.Transportationnoise,sleep,andpossibleafter-effects.Environ.Int.1996,22,105–116.[CrossRef]
2. Öhrström,E.;Skånberg,A.;Svensson,H.;Gidlöf-Gunnarsson,A.Effectsofroadtrafficnoiseandthebenefitofaccesstoquietness.
J.SoundVib.2006,295,40–59.[CrossRef]
3. Moon,H.R.;Shon,J.G.Astudyonthecharacteristicsofapplicabilityintheactivenoisecancellationsystemandmeasurementof
theroadnoisefortrafficcalming.Trans.KoreanInst.Electr.Eng.P2013,62,111–116.[CrossRef]
4. Zhang,X.J.Studyontheformworksupportandpouringtechnologyoffullyenclosedsoundbarrierconstruction. J.Munic.
Technol.2023,41,219–224.
5. Rawool,S.;Stubstad,R.EffectofdiamondgrindingonnoisecharacteristicsofconcretepavementsinCalifornia.InProceedingsof
theNationalConferenceonPreservation,Repair,andRehabilitationofConcretePavements,St.Louis,MO,USA,22–24April2009.
6. Xu,J.;Yang,S.L.;Ye,Z.J.;Wang,L.B.;Wei,Y.;Yang,B.Y.;Meng,W.;Cui,T.;He,C.W.Analysisofdrivingnoisecharacteristicson
cementconcretepavementwithdifferentgroovetextures.J.Munic.Technol.2023,41,27–35.
7. Liu,J.;Li,J.;Li,X.Y.;Li,M.L.Determinationofelasticcomponentamountsofperforatedelasticroadsurfaceandanalysisofthe
noisereductioneffect.J.Munic.Technol.2023,41,7–11.
8. Shen,J.;Zhang,Y.D.;Huang,C.;Liu,W.;Zhao,X.T.;Hu,K.Z.Applicationofdouble-layerporousasphaltinurbanextra-long
tunnel.J.Munic.Technol.2022,40,40–46.
9. Jiang, T.H.; Ren, W.Y.; Dong, Y.S.; Hou, Y.; Yuan, J.M. Precise representation of macro-texture of pavement and effect on
anti-skiddingperformance.Munic.Eng.Technol.2022,40,24.
10. Lu,L.;Yin,K.-L.;deLamare,R.C.;Zheng,Z.;Yu,Y.;Yang,X.;Chen,B.Asurveyonactivenoisecontrolinthepastdecade—PartI:
Linearsystems.SignalProcess.2021,183,108039.[CrossRef]
11. Huang,Y.;He,S.L.;Xu,H.T.;Li,W.P.ResearchonActivateNoiseControlinHeadSpaceofEVASpacesuit.MannedSpacefl.2023,
29,186–191.
12. Zhang,L.M.;Qiu,X.J.Causalitystudyonafeedforwardactivenoisecontrolheadsetwithdifferentnoisecomingdirectionsin
freefield.Appl.Acoust.2014,80,36–44.[CrossRef]
13. Zhang,L.M.;Tao,J.C.;Qiu,X.J.Activecontroloftransformernoisewithaninternallysynthesizedreferencesignal.J.SoundVib.
2012,331,3466–3475.[CrossRef]
14. Pan,M.AdaptiveControlofaPiezoelectricValveforFluid-BorneNoiseReductioninaHydraulicBuckConverter.J.Dyn.Syst.
Meas.Control.2017,139,081007.[CrossRef]
15. Sun,Y.P.; Sun,H.L.; Zhang,W.; Wang,H.; Yang,J.Experimentalresearchintoactivecontroloflow-frequencylinespectral
disturbancesinliquid-filledpipe.J.Chin.J.ShipRes.2017,12,122–127.
16. Zhang,S.R.ApplicationResearchofMineActiveNoiseControlTechnology.Min.Saf.Environ.Prot.2016,43,4.
17. Liu,X.J.;Zhao,C.;Lei,J.U.;Jun-Cheng,X.U.;Jiang,Y.ThesecondarypathmodelingforfMRIscanningnoiseactivecontrol
system.Chin.J.Magn.Reson.Imaging2018,9,8.
18. Reddy,R.M.;Panahi,I.M.;Briggs,R.HybridFxRLS-FxNLMSAdaptiveAlgorithmforActiveNoiseControlinfMRIApplication.
IEEETrans.Control.Syst.Technol.2011,19,474–480.[CrossRef]
19. Xu,G.G.;Lu,X.;Shi,C.L.;Zhu,Y.G.;Zheng,S.Applicationofroadsurfacerecognitiontechnologyintheoptimizationofnoise
reductionperformanceofactiveroadnoisecontrol.J.ChongqingUniv.Technol.(Nat.Sci.)2022,36,74–81.
20. Feng, T.; Sun, G.H.; Li, M.F.; Lim, T.C.Multi-ReferenceTime-FrequencyActiveControlofVehicleInteriorRoadNoise. In
StructuralHealthMonitoring,DamageDetection&Mechatronics,Volume7:Proceedingsofthe34thIMAC,AConferenceandExposition
onStructuralDynamics2016;Springer:Cham,Switzerland,2016;pp.121–128.

Appl.Sci.2024,14,175 17of18
21. Zhang,S.;Zhang,L.;Meng,D.;Pi,X.Activecontrolofvehicleinteriorenginenoiseusingamulti-channeldelayedadaptivenotch
algorithmbasedonFxLMSstructure.Mech.Syst.SignalProcess.2023,186,109831.[CrossRef]
22. Jiang,H.B.;Zhang,Q.F.ResearchonactivenoisereductiontechnologyinvehiclebasedonimprovedSPSAalgorithm. Agric.
Equip.Veh.Eng.2023,61,76–80.
23. Zhang,L.J.;Ning,Y.B.;Meng,D.J.;Zhang,S.MethodofConstructingVirtualReferenceSignalsUtilizingGroupingforActive
RoadNoiseControlinVehicles.J.TongjiUniv.(Nat.Sci.)2021,49,712–720.
24. Landaluze,J.;Portilla,I.;Pagalday,J.;Martınez,A.;Reyero,R.Applicationofactivenoisecontroltoanelevatorcabin.Control.
Eng.Pract.2003,11,1423–1431.[CrossRef]
25. Guo,J.;Sun,K.;Wang,C.-S.;Fang,S.-P.;Horie,Y.;Yang,J.-Y.;Liu,Y.-Y.;Wang,F.;Liu,L.-Y.;Fan,J.-Y.;etal.Protectiveeffectsof
dihydroxylphenyllacticacidandsalvianolicacidBonLPS-inducedmesentericmicrocirculatorydisturbanceinrats.Shock2008,
29,205–211.[CrossRef][PubMed]
26. Zhang, X.F. Research on Sound Field Distribution of Active Control of Low-Frequency Traffic Noise in Highway Tunnel.
Ph.D.Thesis,BeijingJiaotongUniversity,Beijing,China,2018.
27. Moon,H.R.;Kim,S.ABasicLabStudyfortheRoadApplicationoftheActiveNoiseReductionTechnology.ATZWorldw.2016,
120,38–43.
28. Lu,L.;Yin,K.-L.;deLamareRodrigo,C.;Zheng,Z.S.;Yu,Y.;Yang,X.;Chen,B.Asurveyonactivenoisecontrolinthepast
decade–PartII:Nonlinearsystems—ScienceDirect.SignalProcess.2020,181,107929.[CrossRef]
29. Lam,B.;Gan,W.S.;Shi,D.;Nishimura,M.;Elliott,S.Tenquestionsconcerningactivenoisecontrolinthebuiltenvironment.Build.
Environ.2021,200,107928.[CrossRef]
30. Hart,C.R.;Lau,S.K.Activenoisecontrolwithlinearcontrolsourceandsensorarraysforanoisebarrier. J.SoundVib. 2012,
331,15–26.[CrossRef]
31. Duhamel,D.;Sergent,P.;Hua,C.;Cintra,D.Measurementofactivecontrolefficiencyaroundnoisebarriers—ScienceDirect.Appl.
Acoust.1998,55,217–241.[CrossRef]
32. Sahib,M.A.;Streif,S.Designofanactivenoisecontrollerforreductionoftire/roadinteractionnoiseinenvironmentallyfriendly
vehicles.InProceedingsofthe2017SignalProcessing:Algorithms,Architectures,Arrangements,andApplications(SPA),Poznan,
Poland,20–22September2017;IEEE:NewYork,NY,USA,2017.
33. Zhang,C.;Qin,M.;Zou,H.;Qiu,X.SecondarySourceandErrorSensingStrategiesfortheActiveControlofSoundTransmissionthrough
aSmallOpening;AcademicPress:Cambridge,MA,USA,2020.
34. GB3096-2008;MinistryofEcologyEnvironmentofthePeople’sRepublicofChina:EnvironmentalQualityStandardforNoise.
ChinaEnvironmentalSciencePressBeijing:Beijing,China,2008.
35. HJ460-2012;MinistryofEnvironmentalProtectionofthePeople’sRepublicofChina:TechnicalSpecificationsforEnvironmental
NoiseMonitoringRoutineMonitoringforUrbanEnvironmentalNoise.ChinaEnvironmentalSciencePublishingHouse:Beijing,
China,2012.
36. Li,T.Literaturereviewoftire-pavementinteractionnoiseandreductionapproaches.J.Vibroeng.2018,20,2424–2452.[CrossRef]
37. Ruhala, R.J.; Burroughs, C.B. Localization of tire/pavement noise source regions. Noise Control. Eng. J. 2008, 56, 318–331.
[CrossRef]
38. Ongel,A.;Harvey,J.Pavementcharacteristicsaffectingthefrequencycontentoftire/pavementnoise.NoiseControl.Eng.J.2010,
58,563–571.[CrossRef]
39. Ling,S.;Yu,F.;Sun,D.;Sun,G.;Xu,L.Acomprehensivereviewoftire-pavementnoise:Generationmechanism,measurement
methods,andquietasphaltpavement.J.Clean.Prod.2021,287,125056.[CrossRef]
40. Rasmussen, R.O.; Sohaney, R.C. Tire-Pavement and Environmental Traffic Noise Research Study; DTD Applied Research and
InnovationBranch:Denver,CO,USA,2012.
41. Luo,P.;Cai,M.;Wang,H.B.FrequencyCharacteristicsofNoisesofVariousTypesofVehiclesinDifferentSpeeds.J.NoiseVib.
Control.2013,33,86.
42. Bocharov,A.A.;Kolesnik,A.G.;Soloviev,A.V.Two-parametricmodelofthespectrumoftrafficnoiseinTomsk.Acoust.Phys.2012,
58,718–724.[CrossRef]
43. Nunez,I.G.C.;Miranda,J.G.O.;Duarte,M.V.Activenoisecontrolinacousticshutters.Appl.Acoust.2019,152,41–46.[CrossRef]
44. Piechna,J.AReviewofActiveAerodynamicSystemsforRoadVehicles.Energies2021,14,7887.[CrossRef]
45. Song,L.Z.;Feng,Q.S.;Sun,K.;Liu,Q.;Luo,Y.Testonvibrationnoiseofrailcorrugationsectiononurbanrailtransitviaduct.
J.TrafficTransp.Eng.2021,21,159–168.
46. Guo,Z.;Yi,J.;Xie,S.;Chu,J.;Feng,D.StudyontheInfluentialFactorsofNoiseCharacteristicsinDense-GradedAsphaltMixtures
andFieldAsphaltPavements.ShockVib.2018,2018,5742412.[CrossRef]
47. Zhao,H.P.;Zhou,Y.L.;Zhang,Q.Z.ActiveNoiseControlwithDoubleChannelsBasedonVirtualSensors.J.Electroacoust.2010,
34,79–84+87.
48. Zhang,S.;Zhang,L.;Meng,D.;Zhang,X.Ahybridfeedforward/feedbackmulti-channelactivecontrolsystemwithoptimization
forcancellingroadnoiseinsideavehiclecabin.Appl.Acoust.2022,201,109128.[CrossRef]
49. Park,Y.S.;Cho,M.H.;Oh,C.S.;Kang,Y.J.Coherence-basedsensorsetexpansionforoptimalsensorplacementinactiveroad
noisecontrol.Mech.Syst.SignalProcess.2022,169,108788.[CrossRef]

Appl.Sci.2024,14,175 18of18
50. Yin,L.;Zhang,Z.;Wu,M.;Wang,Z.;Ma,C.;Zhou,S.;Yang,J.Adaptiveparallelfiltermethodforactivecancellationofroadnoise
insidevehicles.Mech.Syst.SignalProcess.2023,193,110274.[CrossRef]
51. Jung,W.;Elliott,S.J.;Cheer,J.Localactivecontrolofroadnoiseinsideavehicle.Mech.Syst.SignalProcess.2019,121,144–157.
[CrossRef]
52. George,N.V.;Panda,G.Advancesinactivenoisecontrol:Asurvey,withemphasisonrecentnonlineartechniques.SignalProcess.
2013,93,363–377.[CrossRef]
53. Jia,Z.;Zheng,X.;Zhou,Q.;Hao,Z.;Qiu,Y.AHybridActiveNoiseControlSystemfortheAttenuationofRoadNoiseInsidea
VehicleCabin.Sensors2020,20,7190.[CrossRef][PubMed]
54. Zhu,L.;Qiu,X.;Mao,D.;Wu,S.;Zhong,X.Efficientsegment-updateblockLMS-Newtonalgorithmforactivecontrolofroad
noise.Mech.Syst.SignalProcess.2023,198,110436.[CrossRef]
55. Oh,C.S.; Ih,K.D.; Lee,H.M.; Jeon,J.S.Developmentofanactiveroadnoisecontrolsystem. ATZWorldw. 2015,117,36–39.
[CrossRef]
56. Chen,M.X.;Zhou,Y.L.;Zhang,Q.Z.Directionalweightedfilterwith12directionstoremoverandomvaluedimpulsenoise.Appl.
Res.Comput.2014,31,1584–1587.
57. Cheer,J.;Elliott,S.J.Activenoisecontrolofadieselgeneratorinaluxuryyacht.Appl.Acoust.2016,105,209–214.[CrossRef]
Disclaimer/Publisher’sNote: Thestatements, opinionsanddatacontainedinallpublicationsaresolelythoseoftheindividual
author(s)andcontributor(s)andnotofMDPIand/ortheeditor(s).MDPIand/ortheeditor(s)disclaimresponsibilityforanyinjuryto
peopleorpropertyresultingfromanyideas,methods,instructionsorproductsreferredtointhecontent.
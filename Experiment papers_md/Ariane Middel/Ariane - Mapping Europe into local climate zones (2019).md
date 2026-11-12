RESEARCHARTICLE
Mapping Europe into local climate zones
MatthiasDemuzereID 1,2,3*,BenjaminBechtelID 2,4,ArianeMiddelID 5,6,7,GeraldMills8
1DepartmentofEnvironment,LaboratoryofHydrologyandWaterManagement,GhentUniversity,Ghent,
Belgium,2DepartmentofGeography,Ruhr-UniversityBochum,Bochum,Germany,3KodeVOF,Ghent,
Belgium,4InstituteofGeography,UniversityofHamburg,Hamburg,Germany,5SchoolofArts,Mediaand
Engineering,ArizonaStateUniversity,Tempe,Arizona,UnitedStatesofAmerica,6SchoolofComputing,
Informatics,andDecisionSystemsEngineering,ArizonaStateUniversity,Tempe,Arizona,UnitedStatesof
America,7UrbanClimateResearchCenter,ArizonaStateUniversity,Tempe,Arizona,UnitedStatesof
America,8SchoolofGeography,UniversityCollegeDublin,Dublin,Ireland
a1111111111 *mdemuzere@gmail.com
a1111111111
a1111111111
a1111111111 Abstract
a1111111111
Citiesaremajordriversofenvironmentalchangeatallscalesandareespeciallyatriskfrom
theensuingeffects,whichincludepoorairquality,floodingandheatwaves.Typically,these
issuesarestudiedonacity-by-citybasisowingtothespatialcomplexityofbuiltlandscapes,
localtopographyandemissionpatterns.However,toensureknowledgesharingandtointe-
OPENACCESS
gratelocal-scaleprocesseswithregionalandglobalscalemodellinginitiatives,thereisa
Citation:DemuzereM,BechtelB,MiddelA,MillsG
(2019)MappingEuropeintolocalclimatezones. pressingneedforaworld-widedatabaseoncitiesthatissuitedforenvironmentalstudies.In
PLoSONE14(4):e0214474.https://doi.org/ thispaperwepresentaEuropeandatabasethathasaparticularfocusoncharacterising
10.1371/journal.pone.0214474
urbanisedlandscapes.Ithasbeenderivedusingtoolsandtechniquesdevelopedaspartof
Editor:MonjurMourshed,CardiffUniversity, theWorldUrbanDatabaseandAccessPortalTools(WUDAPT)project,whichhasthegoal
UNITEDKINGDOM
ofacquiringanddisseminatingclimate-relevantinformationoncitiesworldwide.TheEuro-
Received:October2,2018 peanmapisthefirstmajorsteptowardcreatingaglobaldatabaseoncitiesthatcanbeinte-
Accepted:March13,2019 gratedwithexistingtopographicandnaturalland-coverdatabasestosupportmodelling
initiatives.
Published:April24,2019
Copyright:©2019Demuzereetal.Thisisanopen
accessarticledistributedunderthetermsofthe
CreativeCommonsAttributionLicense,which
permitsunrestricteduse,distribution,and
reproductioninanymedium,providedtheoriginal
Introduction
authorandsourcearecredited.
Itisatruismtostatethatcitiesoccupyaverysmallproportionoftheterrestriallandscapeyet
DataAvailabilityStatement:TheEuropeanLCZ
arebothmajordriversofclimatechange[1]andafocusforassociatedrisks[2].Thereare
mapareavailablefromtheofficialWUDAPTdata
portal(http://www.wudapt.org/). manyexamplestoillustrate;forexample,theEuropeanheateventof2003(whichcaused
70,000prematuredeathsoverathreemonthperiod),mayhavebeendrivenbylargescalepro-
Funding:B.B.’sworkwassupportedthroughthe
cessescausedinpartbyclimatechange[3,4]butitsimpactwasconcentratedincitieswhere
ClusterofExcellenceCliSAP(EXC177),University
ofHamburg,fundedthroughtheGermanScience theurbanheatislandenhancedthehazardandhousingpracticeexposedthevulnerable[5,6].
Foundation(DFG).A.M.wassupportedby Dealingwithspatialhierarchiesofcauseandeffectposesarealdifficultyforglobalclimatesci-
TechnischeUniversita¨tKaiserslautern,grant ence.ThefifthphaseoftheClimateModelIntercomparisonProject(CMIP5)atmosphere-
“MicroclimateDataCollection,Analysis,and
oceanglobalclimatemodelsorearthsystemmodelshadatypicalhorizontalresolutionof150
Visualization.”A.M.wasalsosupportedbythe
km[7],1-2ordersofmagnitudelargerthanmostcities.AndeventhoughtheHighResolution
NationalScienceFoundation(NSF),AwardNumber
ModelIntercomparisonProject(HighResMIP)forCMIP6targetsresolutionsbelow100km
1635490“ASimulationPlatformtoEnhance
InfrastructureandCommunityResilienceto [8],theconsequenceremainsthatcitiesaremostlyignoredasphysicalentitiesinglobalclimate
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 1/27

MappingEuropeintolocalclimatezones
ExtremeHeatEvents.”Thefundershadnorolein models.Withtheexceptionoftheground-breakingresearchby[9]whoperformedanear-
studydesign,datacollectionandanalysis,decision globalclimatesimulationatahorizontalgridspacingof930m,mostpartoftheimpactof
topublish,orpreparationofthemanuscript.
globalclimatechangeoncitiesisinferredfrommorespatiallydetailedprojectionsusingstatis-
Competinginterests:Theauthorshavedeclared ticalordynamical‘downscaling’techniques[10–14].Atthesametime,[15]statethata‘scien-
thatnocompetinginterestsexist. tificevidencebaseineachurbancenterisessentialforeffectiveadaptationaction’(p540)while
acknowledgingthelimitsto‘understandingandpredictingimpactsofclimatechangeata
fine-grainedgeographicandsectoralscale’(p550).Animportantcomponentofthisevidence
basewouldbeaclimate-relevantdatabaseatasuitablescalethatisderivedusinganinterna-
tionallyconsistentmethodology.Thiswouldgobeyondtheurbanmaskapproachthatsimply
categorisesland-coverintourbanandnon-urban[16]andpermitsboththetransferofknowl-
edgebetweencitiesandtheapplicationofclimatemodelsaturbanscales.
TheWorldUrbanDatabaseandAccessPortalTools(WUDAPT)projecthasasitsgoalthe
acquisition,storageanddisseminationofdataoncitiesworldwideandthedevelopmentof
toolstosupportclimateresearch[17].Thesedatamustaccountforaspectsofphysicalform
(i.e.urbanland-cover,constructionmaterialsandthegeometryofbuildings)andfunctions
(i.e.thetransportation,energyusage,generationofwasteproducts)thatsustainhumanactivi-
ties.However,ittakesapragmaticapproachtotheacquisitionandorganisationofdatathat
recognisesboththegreatvariationininformationcurrentlyavailablefordifferentcitiesand
thepotentialtogenerateconsistenturbaninformationusingnovelapproaches.TheLocalCli-
mateZone(LCZ)typology[18]hasbeenadoptedasabaselinedescriptionofcitiesasitcatego-
risesdistinctlandscapesatascaleofabout1km2intorecognisabletypesthatcanbelinkedto
importantsurfaceparameters(knownasurbancanopyparameters,UCPs).SeventeenLCZ
typesexist,10ofwhichcanbedescribedas‘urban’(Fig1).Critically,eachoftheseurbantypes
isassociatedwithnumericaldescriptionsofkeyvariables(termedurbancanopyparameters,
seeTable1)thatcanbeusedtomodelatmosphericresponsestourbanisation[17,18].More-
over,becausetheLCZschemeisauniversalclassification,theWUDAPTprotocolisapplicable
toallcitiestherebyprovidingbothacommonplatformforknowledgeexchangeandapathway
tomodelapplicationsincitieswherethereislittledatainfrastructure.Thisprotocolincludes:
selectingaspatialdomainthatcontainsacityofinterest;creatingtrainingareas(TAs)that
identifyexemplarsforeachLCZtypepresentand;usingavailableLandsat8imagestoclassify
theentiredomainintoLCZtypesbasedonthetrainingareas[19,20].Tothispointthe
WUDAPTprocesshasbeenappliedtoindividualcitiesandtheirsurroundings;currently
therearealmost100citiesworldwideandonlyfewregions(e.g.Belgium[21])availableinthe
database.Inaddition,workhasbeendonetotesttheideaof‘transferability’,whereinforma-
tionfromonecityisusedtocategoriseadifferentindependentcity,therebytestingtheuniver-
salityoftheLCZframeworkasanurbantypology[22].However,thesecity-by-cityapproaches
willnotresultinadatabasethatcouldsupporturbandecision-makinggloballyinareasonable
timeframe.
ThispaperoutlinesanapproachtogenerateacontinentalscaleLCZmapthatgoesbeyond
cityboundaries,climatezonesandecoregions.Themajorcontributionofthecurrentresearch
istoupscalethecurrentcity-by-cityapproachtocontinentalscales,whichpermitsthegenera-
tionofUCPsfordomainsofchoice.Inthispaper,wepresentthemethodologyusedtogener-
ateaLCZmapforEuropeandevaluatethesedataagainstindependentlyderivedurbandata.
Materialsandmethods
ThecurrentprotocolforgeneratingLCZmapsinWUDAPTreliesonan‘off-line’workflow
thatintegratestrainingareas(TAs)andLandsat8(L8)imagerywithintheSAGAsoftware
packageoveralimitedspatialdomain[20].TheprocessreliesonwelldefinedTAsthat
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 2/27

MappingEuropeintolocalclimatezones
Fig1.Abridgeddefinitionsforlocalclimatezones[18].©AmericanMeteorologicalSociety.Usedwithpermission.
https://doi.org/10.1371/journal.pone.0214474.g001
exemplifytheLCZtypespresentinthedomain;eachTAisidentifiedusingGoogleEarth
imagesaidedbythevisualandnumericalinformationprovidedin[18].TheTAdatasetisused
toextractspectraldatafromL8imageswhichisthenusedinarandomforestclassifier[23]to
categorisetheentiredomainintoLCZtypes.
Here,wepresenttwostrategiestoexpandLCZcoveragerapidly.Thefirstrecognisesthat
muchoftheinformationcontainedintheTAdataforonecityistransferabletoothercitiesfor
whichnoTAdataisavailable[22].ThesecondemploysGoogle’sEarthEngine(EE)—acloud-
basedplatformforplanetary-scaleanalysis[24]—touseitscomputationalpower,accesstoa
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 3/27

MappingEuropeintolocalclimatezones
Table1.SomeoftheparametervaluesassociatedwithLCZtypesfrom[18].Columnsrepresentthepercentageofbuilt(λ [%],ratioofbuildingplanareatototalplan
B
area),impervious(λ [%],ratioofimperviousplanarea(paved,rock)tototalplanarea)andvegetated(λ [%],ratioofperviousplanarea(baresoil,vegetation,water)to
I V
totalplanarea)land-coverandmeanheightofroughnesselements(H[m],geometricaverageofbuildingheights(LCZs1–10)andtree/plantheights),skyviewfactor
(SVF)andanthropogenicheatflux(AHF[Wm−2]).Thelastcolumnpresentsthetotalimpervioussurfacedensity(IMD[%]),calculatedasthesumoftheouterrangesof
λ andλ.
B I
| LCZ                   | λ     | λ     | λ     | H     | SVF     | AHF    | IMD   |
| --------------------- | ----- | ----- | ----- | ----- | ------- | ------ | ----- |
|                       | B     | I     | V     |       |         |        |       |
| 1.Compacthigh-rise    | 40–60 | 40–60 | <10   | >25   | 0.2–0.4 | 50–300 | >80   |
| 2.Compactmidrise      | 40–70 | 30–50 | <20   | 10–25 | 0.3–0.6 | <75    | >70   |
| 3.Compactlow-rise     | 40–70 | 20–50 | <30   | 3–10  | 0.2–0.6 | <75    | >60   |
| 4.Openhigh-rise       | 20–40 | 30–40 | 30–40 | >25   | 0.5–0.7 | <50    | 50–80 |
| 5.Openmidrise         | 20–40 | 30–50 | 20–40 | 10–25 | 0.5–0.8 | <25    | 50–80 |
| 6.Openlow-rise        | 20–40 | 20–50 | 30–60 | 3–10  | 0.6–0.9 | <25    | 40-90 |
| 7.Lightweightlow-rise | 60–90 | <20   | <30   | 2–4   | 0.2–0.5 | <35    | >60   |
| 8.Largelow-rise       | 30–50 | 40–50 | <20   | 3–10  | >0.7    | <50    | >70   |
| 9.Sparselybuilt       | 10–20 | <20   | 60–80 | 3–10  | >0.8    | <10    | 10-40 |
| 10.Heavyindustry      | 20–30 | 20–40 | 40–50 | 5–15  | 0.6–0.9 | >300   | >40   |
| A.Densetrees          | <10   | <10   | >90   | 3–30  | <0.4    | 0      | <20   |
| B.Scatteredtrees      | <10   | <10   | >90   | 3–15  | 0.5–0.8 | 0      | <20   |
| C.Bush,scrub          | <10   | <10   | >90   | <2    | 0.7–0.9 | 0      | <20   |
| D.Lowplants           | <10   | <10   | >90   | <1    | >0.9    | 0      | <20   |
| E.Barerockorpaved     | <10   | >90   | <10   | <0.25 | >0.9    | 0      | >90   |
| F.Baresoilorsand      | <10   | <10   | >90   | <0.25 | >0.9    | 0      | <20   |
| G.Water               | <10   | <10   | >90   | –     | >0.9    | 0      | <20   |
https://doi.org/10.1371/journal.pone.0214474.t001
rangeofgeospatialdatasets(includingLandsat)andalargenumberofpredefinedfunctions
andmethods(includingarandomforestclassifier).ThesedatasetsincludeSentinel1,Sentinel
2andtheDefenseMeteorologicalProgram(DMSP)OperationalLinescanSystem(OLS)
night-timelightsproductthatwillprovideadditionalinformationfordiscriminatingLCZ
types.IncorporatingmoredatasourcesandsensorsfromEE’scloudstoragecombinedwitha
strategicuseofTAdataallowsusto‘up-scale’thecurrentWUDAPTapproachtoregionsand
continents,whilemaintainingqualityandhighspatialresolution.
Sincethematerialsandmethodsectioncontainsanextensivenumberofabbreviations
referringtodatasets,theirproviders,variablesorothersourcesofinformation,acomprehen-
sivelistofabbreviationsandtheircorrespondingexplanationisavailableinS1Table.
Trainingareas
AcriticalelementintheWUDAPTworkflowforgeneratingLCZmapsisthetrainingarea
(TA)datageneratedbyurbanexperts[17,20].CreatingsuitableTAdataisatime-demanding
procedure,bothbecauseoftheintrinsicnatureofthetask(i.e.theextentandheterogeneityof
urbanareas)andtheabilityoftheurbanexperttoidentifyanddigitiseTAsconsistently.To
evaluatethequalityoftheLCZmapthatisgeneratedfromTAdata,theWUDAPTmethod
measuresaccuracybysub-dividingthecompleteTAdataintotrainandtestsets,usingthefor-
mertopredictLCZtypesandcomparingthesetothetypespresentinthetestset.TheTAdata
issub-divided25timesbyrandomsamplingandarangeofaccuracyvaluesareobtained[17,
21].ImprovingthequalityofaLCZmapisaniterativeprocessdirectedbytheseaccuracymea-
sures,whichareimprovedbymodifyingtheTAdataandrepeatingtheprocess.Nevertheless,
experiencehasshownthattheknowledgeoftheurbanexpertiskey.Thehumaninfluence
experiment(HUMINEX,[25])foundlargediscrepanciesbetweenLCZmapsgeneratedby
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 4/27

MappingEuropeintolocalclimatezones
differenturbanexpertsbutalsothatimprovementsofupto20%inoverallaccuracywere
achievedwhenacombinedTAdatasetwascreatedfromthosegeneratedbyanumberof
experts.
OneofthedistinguishingfeaturesoftheLCZschemeisitsuniversality,thatis,itshouldbe
asapplicabletobothLagosandParis,forexample.Thismeansthat,inprinciple,itshouldbe
possibletoclassifytheurbanlandscapeforonecityusingtheTAdatageneratedforanother.
AcaveattothisstatementisthattherecognitionofLCZtypesinsatelliteimageryisbased
partlyonthebackgroundlandscapeanditsseasonalbehaviour.[22]foundthatLCZaccuracy
improvedconsiderablywhena)thesourceofthetrainingdataisfromacityinthesame
‘urbanecoregion’[26]asthecityofinterestandb)ifthetrainingareasfromseveralcitiesare
combined.
Buildingfurtheruponthesefindings,selectedTAsfromEuropeancitiesavailabletothe
authorsthatpassedWUDAPT’sautomaticqualitycontrol[21]arecombinedintoalargedata-
base(Table2andFigs2and3).Toensurecomputationalefficiencyandmorebalancedtrain-
ingareasizes,TAslargerthan1km2(typicallyhomogeneouswaterorforestedareas)were
detectedandreducedinsurfaceareatopolygonswitharadiusofapproximately300m[22].
Earthobservationdata
ThedefaultWUDAPTworkflowreliesonLandsat8(L8)dataasinputtotherandomforest
classifier[20].Incontrast,theresearchreportedherebenefitsfromEE’sclientandserver
capacities[24]thatoffersawealthofearthobservationdatainitspubliccatalogueandaclient
Table2.AvailabletrainingareasforEuropeancities.
| City         | Country        | PublishedsourceorAuthor |
| ------------ | -------------- | ----------------------- |
| Amsterdam    | TheNetherlands | RanWang                 |
| Antwerp      | Belgium        | [27]                    |
| Athens       | Greece         | [25]                    |
| Augsburg     | Germany        | [25,28]                 |
| Barcelona    | Spain          | JoanGilabertMestre      |
| Berlin       | Germany        | [25,29]                 |
| Birmingham   | UnitedKingdom  | InesFriedrich           |
| Brussels     | Belgium        | [27]                    |
| Cork         | Ireland        | PaulAlexander           |
| Dublin       | Ireland        | [20,25,30–32]           |
| Ghent        | Belgium        | [27]                    |
| Hamburg      | Germany        | M.Kottas                |
| Leuven       | Belgium        | [25]                    |
| Lisbon       | Portugal       | MaxAnjos                |
| London       | UnitedKingdom  | NiallBuckley            |
| Madrid       | Spain          | [33,34]                 |
| Manchester   | UnitedKingdom  | MichealFoley            |
| Milan        | Italy          | MariaBrovelli           |
| Paris        | France         | [35]                    |
| Rome         | Italy          | DraganMilosevic         |
| Thessaloniki | Greece         | PanagiotisSismanidis    |
| Toulouse     | France         | [35]                    |
| Vienna       | Austria        | [36]                    |
| Warsaw       | Poland         | MonikaTomaszewsk        |
https://doi.org/10.1371/journal.pone.0214474.t002
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 5/27

MappingEuropeintolocalclimatezones
Fig2.Europeantrainingareas.ColoursdepictthenumberoftrainingareasperLCZclassandcity.Valuesbetweenbracketsarethe
totalnumberoftrainingareaspercity.
https://doi.org/10.1371/journal.pone.0214474.g002
librarythatcanbeusedtocomputederivedproductssuchasseasonalormulti-annualmean
cloud-freecompositesorspectralindices.Buildingonthefindingsof[22],atotalof41input
featuresareusedinthecurrentstudy(Table3).Asummer(MaytoSeptember,MtS),winter
(NovembertoMarch,NtM)andannual(JanuarytoDecember,JtD)compositeisdeveloped
fromL8bandsblue(B2),green(B3),red(B4),nearinfrared(B5),shortwaveinfrared(B6and
B7)andthermalinfrared(B10andB11).AlsofromL8,alargenumberofspectralindicesare
derived:theminimumandmaximumNormalizedDifferenceVegetationIndex(NDVI),
theBiophysicalCompositionIndex(BCI,[37])usingtheTasseledCaptransformationcoeffi-
cientsfrom[38],themeanNormalizedDifferenceBArenessIndex(NDBAI,[39]),themean
EnhancedBuilt-upandBarelandIndex(EBBI,[40]),themeanNormalizedDifferenceWater
Index(NDWI,[41])andthemeanNormalizedDifferenceBuiltIndex(NDBI,[42]).The
Fig3.Illustrationoftrainingareas:Toulouse(France,leftpanel),Birmingham(UnitedKingdom,middlepanel),andAthens(Greece,rightpanel).Colours
denotetheLCZclasses.Sourcesbackgroundmap:Esri,DigitalGlobe,EarthstarGeographics,CNES/AirbusDS,GeoEye,USDAFSA,USGS,Aerogrid,IGN,IGP,and
theGISUserCommunity.
https://doi.org/10.1371/journal.pone.0214474.g003
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 6/27

MappingEuropeintolocalclimatezones
Table3.Descriptionoftheinputfeatures.Allproductsareselectedfortheperiod2015-01-01to2017-12-31(except
indicatedotherwise),andareresampledtoahorizontalresolutionof100m.
Inputfeatures Source
Yearly(_JtD)andseasonalcomposites(_MtS,_NtM)(B2-7,B10, Landsat8
B11)
MaximumandminimumNDVI Landsat8
BCI,NDBAI,EBBI,NDWI,NDBI Landsat8
NDUIa Landsat8andNOAADMSP-OLSNight-time
lights
S1backscatteranditsentropy(_ent)andGeary’sC(_gc) Sentinel-1
GlobalForestCanopyHeight(GFCH)b [46]
DTM,SlopeandAspect USGS/GTOPO30
DSM [47,48]
DEM(DSM-DTM)
aThemostrecentnight-timelightsproductisavailablefor2013.
bThisproductsreflectsthestateof2005.
https://doi.org/10.1371/journal.pone.0214474.t003
NormalizedDifferenceUrbanIndex(NDUI)after[43]wasintroducedbycombiningthemax-
imumofNDVI,NDWIandNDBIwiththecoarserresolutionDefenseMeteorologicalSatellite
Program/OperationalLinescanSystem(DMSP/OLS)nighttimelightimagery[44].Synthetic
apertureradar(SAR)imageryisincludedviaSentinel-1,filteredbyVVsingleco-polarisation,
theInterferometricWideswathacquisitionmodeandbothascendinganddescendingorbits,
andcompositedintoasingleimage(hereafterreferredtoS1).FromtheS1backscattercom-
posite,anentropyandGeary’sC(alocalmeasureofspatialassociation[45])imageiscalcu-
lated,usingasquaredkernelof5x5pixelsanda9x9spatialneighbourhoodkernelrespectively
[22].
Finally,someauxiliarydatasetsareincludedsuchastheGlobalForestCanopyHeight
(GFCH)productfrom[46],theGTOPO30digitalterrainmodel(DTM)andderivedslopeand
aspectfromtheU.S.GeologicalSurvey’sEarthResourcesObservationandScience(EROS)
Center,theALOSWorld3Dglobaldigitalsurfacemodel(DSM)dataset[47,48]andadigital
elevationmodel(DEM)bysubtractingtheDTMfromtheDSM.Notethatthefullsetoffea-
turesareprocessedonaresolutionof100m,followingthedefaultmappingresolutionsug-
gestedby[20].
Classificationprocedureandaccuracyassessment
Asafirststepintheclassificationprocedure,afeatureimportancerankingisperformedusing
thepermutationimportance[49]fromtherandomForestv4.16-14packageavailableinR-proj-
ect[50].Theinputfeaturesforthisprocedureareobtainedbysamplingfromthe2824poly-
gonsthatcomprisethefullTAdataset(Table2,Fig2);foreachTApolygon,10pixelswere
randomlyselectedtoensurethattherelativefrequencyofeachLCZclassinthepopulation
wasmaintained.Thisresultedin28,240pixels(hereafterreferredtoas‘All’pixels)eachcon-
taininginformationfrom41inputfeatures.Asafirstaccuracyassessment,pixelsarerandomly
splitintotrain(70%)andtest(30%)datasetswhichareclassifiedintoLCZcategoriesusingthe
randomforestclassifier[23].Initiallythisisdoneforallpixelsandinputfeaturesbutthisisat
thelimitsofcomputationalfeasibility.Consequently,thisexerciseisrepeatedtwiceusing:first,
33%ofthe28,240pixels(’Reduced’pixels)withall41inputfeaturesand;second,100%of‘All’
pixelscontainingthe10mostrelevantinputfeatures.
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 7/27

MappingEuropeintolocalclimatezones
Thetrainandtestsplitisrepeated25timesandforeachrealisationanaccuracyisassessed
accordingtothemeasuresdescribedin[22,25,51]:overallaccuracy(OA),overallaccuracyfor
theurbanLCZclassesonly(OA ),overallaccuracyofthebuiltversusnaturalLCZclassesonly
u
(OA ),aweightedaccuracy(OA )andtheclass-wisemetricF1.Theoverallaccuracydenotes
bu w
thepercentageofcorrectlyclassifiedpixels.OA reflectsthepercentageofclassifiedpixels
u
fromtheurbanLCZclassesonlyandOA istheoverallaccuracyofthebuiltversusnatural
bu
LCZclassesonly,ignoringtheirinternaldifferentiation.Theweightedaccuracy(OA )isa
w
metricthatisobtainedbyapplyingweightstotheconfusionmatrix(availableinAppendixA.
of[25])andaccountsforthe(dis)similaritybetweenLCZtypes.Forexample,LCZ4ismost
similartotheotheropenurbantypes(LCZs5and6)leavingthesepairswithhigherweights
comparedtoe.g.anurbanandnaturalLCZclasspair.Thisresultsinpenalisingconfusion
betweendissimilartypesmorethanconfusionbetweensimilarclasses.Finally,theclass-wise
accuracyisevaluatedusingtheF1metric,whichisaharmonicmeanoftheuser’sandproduc-
er’saccuracy[51].Inaddition,OA isalsousedincombinationwiththeKappacoefficient
bu
andtheTruePositiveRate(TPR,positivescorrectlyclassified/totalpositives[52])toverify
whethertheLCZmapisinlinewithastateoftheartbinary(urban/non-urban)globalland
coverproduct,describedinthesectionbelow.Finally,EE’srandomforestclassifieristrained
onallEuropeanTAscombinedandusedtocategoriseland-coveracrosstheEuropeanconti-
nentintoLocalClimateZonetypes.
Evaluatinglarge-scaleLCZmaps
EachLocalClimateZonetypeislinkedtoasetofnumericalvaluesthatdescribearangeofsur-
faceproperties(Table1)thatincludetheaverageheightbuildings(H),impervioussurface
fraction(IMD),theanthropogenicheatflux(AHF)andskyviewfactor(SVF)forthe‘urban’
types(LCZ1-10);notethatSparselybuilt(LCZ9)isdominatedbynaturalcover.Theseprop-
ertiesareespeciallyrelevantforstudyingurbanareasastheyarerelatedtothegenerationof
turbulence(H),thelackofwatersourcesforevaporation(IMD),localheatingoftheatmo-
spherebyhumanactivities(AHF),andradiativetrappingbelowrooflevel(SVF)(see[53]).
These,alongwithothers,aredescribedasurbancanopyparametersandareneededforcaptur-
ingurbanprocessesinatmosphericmodels.Inordertoevaluatethemethodologypresented
here,weneedequivalentindependentlyobtaineddatatocompareitwith.Inthefollowingwe
presentavarietyoffreelyavailablepublisheddatasourcesthatareusedtoevaluatetheEuro-
peanLCZmap.
Urbanlandcover. TheannualEuropeanSpaceAgencyClimateChangeInitiative(ESA
CCI)landcover(LC)mapsareavailableonayearlybasisfrom1992to2015ataspatialresolu-
tionof300m[54].ThesemapsdescribetheEarth’sterrestrialsurfacein37originalLCclasses
basedontheUnitedNationsLandCoverClassificationSystem(UN-LCCS;[55]).Incontrast
tothenaturalclasses,whichareobtainedusingawiderangeofsatellitesensors(e.g.AVHRR,
SPOT-VGT,MERISFR/RRandSentinel-3OLCI/SLSTR),thesingleurbanclassislargely
identifiedusingtwoexternaldatasets:theGlobalHumanSettlementLayer(GHSL)[56]and
theGlobalUrbanFootprint(GUF)[54,57].GHSLisproducedbytheEuropeanJointResearch
Center(JRC)basedonanautomatedextractionofbuilt-upareasfromglobalLandsatimagery.
Inthisdataset,thebuilt-upareaclassabstractionisdefinedastheunionofallthespatialunits
collectedbythespecificsensorandcontainingaroofedbuiltstructureoranyportionofit[58,
59].GUFisarecentlyreleasedglobalbinarysettlementmaskwitharesolutionof*12m,and
isderivedfromanautomatedUrbanFootprintProcessorusedtoanalysemorethan180,000
TanDEM-XandTerraSAR-Xradarimageswith3mgroundresolutioncollectedin2011-2012
[57].NoteherethattheSAR-basedGUFapproachmightdifferfromtheurbanmaskretrieved
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 8/27

MappingEuropeintolocalclimatezones
fromopticaldata:thelattercapturesinformationfromhorizontalsurfaces(e.g.parkinglots
androads)but,asthesefeaturesdonothaveaverticalcomponent,theyarenotdetectedin
GUF.
InordertocomparetheurbanmaskfromESACCIwiththeEuropeanLCZmap,the
latterisfirstre-projectedandre-sampledtothe300mESACCIresolutionusingamajority
approach.Afterwards,bothareconvertedintoabinaryproduct;fortheLCZmap,allbuilt
LCZs(exceptSparselybuilt(LCZ9)whichispredominantlynatural)areconvertedtoasingle
‘urban’class,andallremainingclassesareconsideredasnatural.Thesameapproachisfol-
lowedforESACCI.Aqualityassessmentisthenperformedonapixel-per-pixelbasisforthe
entireEuropeandomain,andisdescribedintermsofOA ,theKappacoefficientandthetrue
bu
positiverate.
Impervioussurfacecover(IMD)andbuildingheight(BH). TheCopernicusLand
MonitoringService(CLMS)aspartofTheEuropeanEnvironmentalAgency(EEA)recently
releasedanupdatedseriesofhighresolutionimperviousdensity(IMD)datasetsfortheyears
2006,2009,2012and2015basedoncalibratedNDVIvalues.Thesemapsprovideanestimate
ofimpermeablecoverofsoil(0-100%)at20mand100mresolutions[60].CLMShavealso
releasedbuildingheight(BH)dataforselectedcitiesintheUrbanAtlasprojectderivedfrom
IRS-P5stereoimageswhichisavailableataspatialresolutionof10m[61].
BoththeIMDandBHdatasetsareusedtoextracturbancanopyparameterinformationfor
theimpervioussurfacefractionandheightoftheroughnesselements[18],foreachLCZclass
fromtheEuropeanmap.Fortheimpervioussurfacefraction,the100mIMDproductfor2015
isused,andrangesperLCZarederivedforthefullcoverageoftheEEAIMDmap.Forthe
heightoftheroughnesselements,theLCZmapiscroppedtothecorrespondingcities’extent
oftheBHdata,andaspatialjoinisperformedtoextractthemeanbuildingheightperbuilt
LCZclass,whichisapproximatelycomparabletoHinTable1.
Anthropogenicheatflux(AHF). TheAHFassociatedwitheachLCZtype[18]canbe
usedtoderiveadatasetcomparabletotheannualAHFdatasetprovidedby[62],whichisavail-
ablegloballyataspatialresolutionof30arc-secondsandtemporalresolutionof1hour.This
productincludesfourheatingcomponents:energyloss,heatingfromthecommercial,residen-
tial,andtransportationsectors,heatingfromtheindustrialandagriculturalsectors,andheat-
ingfromhumanmetabolism.Forthecurrentstudy,theannualaverageAHFisusedforthe
EuropeanLCZdomain,andintersectedwiththe100mLCZmapafterabilinearresampling
tomatchresolutions.ThisisanapproximatematchwithAHFinTable1.
Skyviewfactor(SVF). TheSVFisapoint-basedmeasurementoftheproportionofthe
skyvaultthatisobservablefromgroundlevel.Here,theSVF(andothergeometricalproper-
ties)areobtainedforselectedEuropeancitiesusingGoogleStreetView(GSV)imagesthat
areexaminedusingabigdataanddeeplearningapproach.First,acompletesampleofGSV
locationsineachcityisretrievedthroughtheGoogleMapsAPI.Foralllocations,animage
cubeisdownloadedintheformofsix90-degreefield-of-viewimagesthatfaceupwards,
downwards,north,east,south,andwest[63].Theimagesaresegmentedbyaconvolutional
neuralnetworkthatwasfine-tunedwithGSV90-degreeimagesfromcitiesaroundtheworld
toyieldsixclasses:sky,trees,buildings,imperviousandpervioussurfaces,andnon-perma-
nentobjects[64].Subsequently,eachsegmentedimagecubeisprojectedontoasphere,and
fractionalpercentagesofeachclasscoverageonthespherearecalculated,representingthe
landcovercompositionasexperiencedbyapedestrianinastreetcanyon.Inaddition,the
segmentedupperhalfofthecubeisprojectedintoahemisphericalfish-eyetocalculate
theSVFusingskyandnon-skypixels[65].ItisimportanttobearinmindthattheGSVsam-
plesfromtheroadnetworksothatplacesthatarenotseen(e.g.parksandgardens)arenot
included.
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 9/27

MappingEuropeintolocalclimatezones
Torelatethepoint-basedsphericalfractionsandSVFstotheLCZmaps,thedatasetsare
spatiallyjoinedinArcGIS,whichyieldsaverageparametervaluesforallLCZpolygonsthat
haveprocessedGSVdata[66].Finally,thesphericalfractionsandSVFsaresummarisedby
LCZclassforeachcitytocalculatecity-specificparametermeans.Thesevaluesarecompared
withSVFvaluesfromTable1.
Results
Featureimportanceandaccuracyassessment
TheinputfeatureimportancerankingbasedonAllpixels(28,240)ispresentedinFig4.Sen-
tinel-1backscatter(S1)isbyfarthemostimportantinputfeature,followedbythosebased
onspectralratiossuchasNDUI,minimumandmaximumNDVI,NDWIandBCI.Thetop-
Fig4.Inputfeatureimportanceranking.Theverticaldashedlineseparatesthetop-10features.Theerrorbarsarederivedfromthe
bootstrappingprocedure.NotethatthespectralindicesarealsoderivedfromLandsat8;theyaregivenadifferentcolorforclarity.
https://doi.org/10.1371/journal.pone.0214474.g004
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 10/27

MappingEuropeintolocalclimatezones
Fig5.FeatureimportancerankingperLCZclass.Leftpanel:BuiltLCZs,rightpanel:NaturalLCZs.Thicklinesandshadings
respectivelypresenttheimportancemeanandstandarddeviationfromthebootstrapping.
https://doi.org/10.1371/journal.pone.0214474.g005
10listiscompletedbytheannual(JtD)andwinter(NtM)meancompositeofL8’sgreen
band(B3)andthesummermeancompositesoftheshortwaveinfraredband(B7)andther-
malinfrared(B10).Thisresultisverymuchinlinewiththeworkof[22],whichtestedthe
transferabilityofinputfeaturesandTAdatafor15citiesfromacrosstheworld;thissupports
theviewthattheurbanTAdataprovidesagreatdealofinformationthatisgenerictoall
urbanlandscapes.
WhileFig4presentstherelativeimportanceofeachinputfeatureforallavailableLCZ
typestogether,Fig5providesmorein-depthinformationontherelativeimportanceofinput
featuresforeachLCZtype.Asexpected,S1isthemostimportantfeatureformostofthebuilt-
upandnaturaltypes.ForthebuiltLCZclasses,NDWI,minimumandmaximumNDVIand
NDUIarealsorelativelystrong,althoughtheirsignalvariesdependingonthebuildingcom-
pactnessandmeanheightthatcharacteriseseachclass.Thisclass-wiseanalysisshowsboththe
featuresthatareusefulfordistinguishingamongLCZtypesand,conversely,LCZtypesthat
arenotwellcapturedbythecurrentinputfeaturespace.Forexample,theCompacthigh-rise
class(LCZ1),hasextremelylowimportancerankingsforalloftheinputfeaturesalthoughthis
maypartlybeexplainedbytheverylownumberofTAsforthisclass(Fig3)andtheirsmall
spatialextent;asimilarobservationcanbemadefortheOpenhigh-rise(LCZ4)types.The
naturalLCZtypesshowmorevariabilityacrossinputfeatures,forexample:Water(LCZG)is
bestdetectedusingL8’sinfraredandshortwaveinfraredbands(B5,B6andB7),Densetree
cover(LCZA)usingthegreenbandofL8(B3)andBush/scrubcover(LCZC)usingL8’sther-
malinfraredbands(B10,B11),NDUIandminimumNDVI.Finally,Barerockandpavedarea
(LCZE)hasstrongpeaksinBCI,NDWI,NDUI,minimumandmaximumNDVIandL8’s
greenband(B3).
ThreeexperimentsareperformedtoassesstheaccuracyoftheLCZpredictionsusingallor
partoftheTAdatasetandtheinputfeatures;accuracyscoresforeacharedepictedinFig6.In
eachexperiment,70%ofthepixelsareusedtotrainand30%totest;thesepixelsareselected
bystratified(LCZtype)randomsamplingandthisexerciseisrepeated25timesallowingusto
provideconfidenceintervalsaroundtheaccuracymetrics.
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 11/27

MappingEuropeintolocalclimatezones
Fig6.Classificationaccuracyassessment.ResultsarebasedonAllpixelsandallinputfeatures(leftpanel),Allpixelsandthetop10inputfeatures(middlepanel),andthe
reducedpixelsandallinputfeatures(rightpanel).
https://doi.org/10.1371/journal.pone.0214474.g006
Fig6(left)includesAllpixels(28,240)andAllinputfeatures(41)whichgeneratesscores
>80%forallOAmetrics.Asimilarobservationcanbemadefortheclass-wiseF1metric,with
theexceptionforLCZs4(Openhigh-rise),5(Openmid-rise)and10(Heavyindustry).LCZ1
(Compacthigh-rise)doesnotshowasthefewtestpixels(fromParisandBrussels)aremiss-
classifiedasLCZ2(Compactmid-rise).Generally,theLCZtypes1and2,4and5arecharac-
terisedbysimilarsurfacecoverfractionsanddiffermainlybytheheightoftheirroughnessfea-
tures(>25mand3-10mrespectively,seeTable1).Thispointstoacurrentlimitationofthe
inputfeaturespace:apartfromtheS1backscatterinformation,whichrespondstoverticalele-
mentsonthelandscape[67]andtheDEMinformation(subjecttoerrors[47,48]),thereisno
inputfeatureinthecurrentsuitethatdetectsheightvariations.Thisisinlinewiththeresults
ofthe2017IEEEGRSSDataFusionContest[34,68],thatfoundthattheOpenhigh-rise(LCZ
4)andOpenmid-rise(LCZ5)typesweredifficulttodistinguish.Toovercomethislimitation,
someoftheteamsintheDataFusionContestenrichedtheirremotelysensedinputfeatures
withbuildingheightsfromOpenStreetMap(OSM)resultinginhigheraccuracyscores.How-
ever,[69]reportedthatincludingheightinformationforBelgiancitiesdidnotsignificantly
improvetheLCZmappingaccuracy,mainlyduetoamismatchinspatialresolutionbetween
theinputfeaturesets.Whiletherearelimiteddomainheightdatasetsavailable(e.g.Urban
Atlasbuildingheight[61]),fullcoverageovertheareaofinterestisneededtobeincludedas
aninputfeature.
Fig6alsoshowsaccuracyscoresusingthereducedpixelsamplewithallfeatures(middle)
andAllpixelswiththetop10inputfeaturesbasedontheimportancerankinganalysis(right)
(Fig4).UsingfewerinputfeaturesreducestheOAandOA valuestobelow80%.Asbefore,
u
lowestscoresareobtainedforLCZs1,4,5and10butthereisalsomoreconfusionforLCZ3
(Compactlow-rise),LCZ9(Sparselybuilt)andLCZC(Bush/scrub).Ontheotherhand,using
asmallersetofpixelsintheTAdatasetwithall41inputfeaturesgeneratedOAscorescloseto
orabove80%,andmostF1valuesare>75%exceptforLCZs4,5and10.Fromacomputa-
tionalperspective,theseexperimentsindicatethatitisbettertosamplelessanduseallinput
featuresthantosamplemoreandusefewerinputs;thisisthepathtakenheretocreateaEuro-
peanLCZmap.
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 12/27

MappingEuropeintolocalclimatezones
Fig7.Europeanlocalclimatezonemap.AselectionofcitiesaredepictedinmoredetailsintheFiguresbelow.
https://doi.org/10.1371/journal.pone.0214474.g007
Localclimatezonemap
TheresultoftheEuropeanLCZclassification,basedonthetrainingoftherandomforestclas-
sifierinEarthEngineusingthereducedsetofpixelswithall41inputfeaturesisshowninFig
7.Themapdisplayedhereistherawoutcomeoftheclassifier,onaspatialresolutionof100m,
providedontheEuropeanETRS89/ETRS-LAEA(EPSG:3035)projection.
Asapreliminaryevaluation,abinaryurban/non-urbanlandcovercomparisonismade
withtheESACCI2015landcoverproduct,takingthisproductasthe‘true’reference.Fig8
presentsafirstvisualinterpretationforfourselectedareas:(partof)Flanders(Belgium),Lju-
bljana(Slovenia),Oslo(Norway)andPalermo(Italy).Onecanseethatingeneral,theurban
extentisverysimilarbetweenthetwoproductsandmatcheswellwiththeurbanareasas
seenonthesatelliteimagery.Ifanything,theLCZmapsseemtoproducemoreextensive
urbanareas,whichismostapparentinthescatteredurbanpixelsoftheLCZmapfor
(partof)Flanders,aswellasinthelargerurbanextenteastandsouthofthecitycentreof
Palermo(Fig8,topandbottomrowrespectively).Thesearegenerallycorrespondtolow-
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 13/27

MappingEuropeintolocalclimatezones
Fig8.BinaryurbanmapsextractedfromESACCIandLCZ.Blackreferstourban,whitetonon-urban.FortheLCZs,
classes1-10withtheexceptionof9(Sparselybuilt)areconsideredurban.Sourcesbackgroundmaps:Esri,DigitalGlobe,
EarthstarGeographics,CNES/AirbusDS,GeoEye,USDAFSA,USGS,Aerogrid,IGN,IGP,andtheGISUserCommunity.
https://doi.org/10.1371/journal.pone.0214474.g008
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 14/27

MappingEuropeintolocalclimatezones
Fig9.AccuracyassessmenturbanlandcoverforallEuropeancountries.AbbreviationsrefertoLargeScaleInternationalBoundary(LSIB)countrycodes:AL:
Albania,AN:Andorra,AU:Austria,BE:Belgium,BK:Bosnia&Herzegovina,BO:Belarus,BU:Bulgaria,CY:Cyprus,DA:Denmark,EI:Ireland,EN:Estonia,EZ:Czech
Republic,FI:Finland,FR:France,GM:Germany,GR:Greece,HR:Croatia,HU:Hungary,IC:Iceland,IT:Italy,KV:Kosovo,LG:Latvia,LH:Lithuania,LO:Slovakia,
LS:Liechtenstein,LU:Luxembourg,MD:Moldova,MJ:Montenegro,MK:Macedonia,MN:Monaco,MT:Malta,NL:TheNetherlands,NO:Norway,PL:Poland,PO:
Portugal,RI:Serbia,RO:Romania,SI:Slovenia,SM:SanMarino,SP:Spain,SW:Sweden,SZ:Switzerland,TU:Turkey,UK:UnitedKingdom,UP:Ukraine,VT:Vatican
City.
https://doi.org/10.1371/journal.pone.0214474.g009
densitylow-risebuiltupareasthatarenotcapturedbyESACCIbutthataredetectedbythe
LCZscheme.
ThespatialaccuracyoftheEuropeanmapwasexaminedbycalculatingthreeperformance
measuresfortheLCZcoverineachEuropeancountry,extractedusingtheLargeScaleInterna-
tionalBoundary(LSIB)countrycodesavailableinEE(Fig9).ForOAandKappa,mostaccu-
racyscoresarehigherthan95%,exceptforSerbia(RI),Spain(SP),UnitedKingdom(UK)and
VaticanCity(VT).Yetgiventhattherearesubstantiallymorenaturalthanurbanpixelsacross
thedomain,thetruepositiverate(TPR)isamuchmorestringentaccuracyassessmentcrite-
rionasitemphasisesthecorrectlyclassifiedurbanclassesonly.Here,TPRvaluestendtobe
lowerbutoverall>70%accuracywasobtained.Interestingly,scoresarelowestforSerbiaand
Belgium(BE)eventhoughforthelatter,fourBelgiancitieswereincludedintothetraining
process.Aftervisualinspection,itisclearthatESACCIismoreconservativeinitsurban
extentcomparedtotheLCZresult.FortheparticularcaseofBelgiancities,ESACCIunderes-
timatessomeofthescatteredurbanisationpatternthathasbeendescribedelsewhere[70](not
shown).
Urbancanopyparameters
Inthefollowing,thederivedLocalClimateZonemapisspatiallyintersectedwithindepen-
dentlyderivedurbandatasetsthatcontaincomparablecanopyparametervaluestothose
associatedwiththeLCZtypes(Table1).Thiswillallowustoa)evaluatetheLCZmapandb)
potentiallyfine-tunetheexistinggenericrangesprovidedinTable1,referredtoasLCZvalues
inthefollowingtext.
Buildingheight. Fig10depictstheLCZmapforthecityofBudapest(Hungary),together
withtheUrbanAtlasbuildingheightinformation.ThecitycentreischaracterisedbyCompact
mid-risecover(LCZ2)withcorrespondinghigherbuildings(averageof16.9m,seeTable4).
ThisareaismainlysurroundedbyOpenmid-rise(LCZ5)andthenOpenlow-rise(LCZ6)
withinterveningareasofextensiveLargelow-rise(LCZ8)associatedwithwarehousesand/or
shoppingmalls.Theaveragederivedheightsforthesezonesarerespectively10,7.6and11.6
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 15/27

MappingEuropeintolocalclimatezones
Fig10.LCZmap(leftpanel)andEUUrbanAtlasbuildingheight(rightpanel)forBudapest(Hungary).
https://doi.org/10.1371/journal.pone.0214474.g010
m.ForthecaseofBudapest,thesevaluesgenerallyfallwithintheheightoftheLCZroughness
elementranges(Table4).
Table4showstheresultsforallotherUrbanAtlascitiesthatprovideinformationonbuild-
ingheight.ThefewCompacthigh-rise(LCZ1)pixelsinBrusselsandParishaveameanbuild-
ingheightof25m,whichisinlinewiththelowerlimitofLCZvalues,showninthetoprow.
Overall,mostotherbuildingsheightsarealsoinlinewiththeLCZvalues,exceptforCompact
low-rise(LCZ3)(slightlytoohigh)andespeciallyOpenhigh-rise(LCZ4),whichhastoolow
buildingheights(11.8±3.5m)comparedtotheLCZvalue>25m.Thisisinlinewiththe
resultsofFig6thatrevealedthelowestaccuracyvaluesfortheLCZ4type,becauseofinsuffi-
cientunderlyinginputinformationonbuildingheight,andhenceageneraltendencytocon-
fusethisclasswithOpenmid-rise(LCZ5).AsimilarobservationcanbemadeforCompact
low-rise(LCZ3)anditsnearesttype(Compactmid-rise,LCZ2)withtallerbuildings.
Impervioussurfacefraction(IMD)andanthropogenicheatflux(AHF). HeretheLCZ
mapanditsassociatedpropertiesarecomparedwithimperviousdensityinformation(IMD,
[60])andtheannualmeananthropogenicheatflux(AHF,[62]).Toillustratethespatialcorre-
spondenceFig11showstheLCZmapforGermanyalongsideIMDandAHF;onecanseethat
thecompactLCZtypes(1to3and8)havehighIMDvalues(seeforexample,thecitycentres
ofHamburg,BerlinandMunich)andthatthesearealsoareasofhighAHF(±30Wm−2).
ThestatisticsforIMDandAHFacrosstheEuropeandomainaretabulatedperLCZclass
inTable5.ThemostcompactLCZtypesare1,2,3,8and10,withimperviousfractionswell
above50%whichisgenerallyinlinewiththeLCZvalues.Incontrast,thefractionsforthe
otherbuiltclassesaretypicallylower,exceptfortheSparselybuilttype(LCZ9).Forthenatural
classes,someclassesseemtosuffersomeconfusion;forexample,theimpervioussurfacefrac-
tionestimatedforBaresoil/sand(LCZF)is33.14±11.7%andthatforWater(LCZG)is
13.74±17.45%.Theseresultscouldbeabyproductofspatialresolution,forexamplesmallor
narrowwaterbodiesmaynotcapturedbythehorizontalresolutionofthe100mLCZmap
[51].
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 16/27

MappingEuropeintolocalclimatezones
Table4.Meanbuildingheight(m)perbuiltLCZclassfortheUrbanAtlascities.Referencevaluesfrom[18]areprovidedinthetoprow,meanandstandarddeviation
(St.Dev.)acrossallUrbanAtlascitiesareprovidedontopoftheindividualcitylistings.
|                | LCZ1 LCZ2 | LCZ3 LCZ4 | LCZ5 LCZ6  | LCZ7 LCZ8 | LCZ9 | LCZ10 |
| -------------- | --------- | --------- | ---------- | --------- | ---- | ----- |
| [18]           | >25 10-25 | 3-10 >25  | 10-25 3-10 | 2-4 3-10  | 3-10 | 5-15  |
| Mean           | 25.0 14.7 | 11.2 11.8 | 10.6 7.9   | - 10.5    | 7.3  | 12.0  |
| St.Dev.        | 0.5 2.5   | 2.2 3.5   | 1.9 1.3    | - 1.5     | 1.1  | 4.5   |
| Amsterdam      | - 14.1    | 11.1 12.3 | 12.1 8.2   | - 10.1    | 8.6  | 10.6  |
| Athens         | - 14.4    | 9.6 18.6  | 11.4 8.5   | - 12.4    | 7.4  | 23.3  |
| Berlin         | - 18.7    | 15.7 11.8 | 12.8 8.0   | - 11.6    | 8.0  | 10.1  |
| Bratislava     | - 15.4    | 13.6 12.6 | 11.3 7.7   | - 10.5    | 5.7  | 6.9   |
| Brussels       | 24.4 15.2 | 11.8 12.2 | 11.5 9.0   | - 11.2    | 8.9  | -     |
| Bucharest      | - 11.0    | 7.7 11.6  | 9.8 6.4    | - 9.0     | 5.9  | -     |
| Budapest       | - 16.9    | 12.8 9.7  | 10.0 7.6   | - 11.6    | 7.3  | 13.5  |
| Copenhagen     | - 12.9    | 14.3 7.3  | 7.8 6.6    | - 8.1     | 6.5  | 15.4  |
| Dublin         | - 12.2    | 8.7 9.7   | 8.8 6.4    | - 8.8     | 6.4  | 10.1  |
| Helsinki       | - 17.0    | 12.6 8.5  | 8.3 6.6    | - 10.2    | 6.2  | 16.9  |
| Lefkosia       | - 9.0     | 7.5 -     | 8.0 7.3    | - 8.1     | 7.0  | 5.8   |
| Lisbon         | - 13.5    | 9.0 21.0  | 12.3 7.6   | - 11.8    | 6.7  | 10.4  |
| Ljubljana      | - 14.1    | 11.0 7.4  | 8.0 6.1    | - 9.6     | 5.2  | -     |
| London         | - 15.4    | 7.7 13.0  | 9.5 7.1    | - 9.6     | 7.1  | 12.2  |
| LuxembourgCity | - 14.8    | 10.4 8.2  | 10.5 8.8   | - 11.5    | 9.3  | -     |
| Madrid         | - 16.8    | 11.6 18.6 | 15.0 10.6  | - 12.5    | 9.2  | 10.7  |
| Oslo           | - 14.8    | 12.0 7.1  | 7.8 6.8    | - 9.2     | 6.6  | 21.9  |
| Paris          | 25.6 17.7 | 11.5 14.8 | 12.2 8.1   | - 10.8    | 8.2  | 14.5  |
| Prague         | - 18.7    | 15.1 12.8 | 12.5 9.3   | - 11.6    | 8.0  | -     |
| Reykjavik      | - 8.2     | 6.8 6.2   | 6.8 5.5    | - 6.2     | 5.2  | 8.7   |
| Riga           | - 16.5    | 10.8 11.6 | 11.3 10.6  | - 10.7    | 8.8  | 8.0   |
| Rome           | - 17.1    | 11.1 13.9 | 13.7 9.3   | - 13.5    | 9.0  | 14.5  |
| Sofia          | - 14.6    | 12.7 13.7 | 13.1 10.2  | - 12.2    | 8.5  | 5.5   |
| Stockholm      | - 16.1    | 12.0 8.7  | 9.6 6.7    | - 10.2    | 6.4  | 11.8  |
| Tallinn        | - 14.6    | 12.2 13.7 | 11.5 8.3   | - 9.5     | 6.6  | 9.3   |
| Vienna         | - 16.7    | 11.7 12.8 | 10.4 7.1   | - 10.8    | 6.9  | -     |
| Vilnius        | - 12.0    | 11.6 12.2 | 11.3 8.7   | - 10.9    | 6.7  | -     |
| Warsaw         | - 16.0    | 12.2 10.7 | 11.0 8.2   | - 11.5    | 7.9  | -     |
| Zagreb         | - 12.8    | 8.7 9.1   | 10.4 7.6   | - 10.6    | 6.8  | -     |
https://doi.org/10.1371/journal.pone.0214474.t004
In[18]AHFrepresentsfuelcombustionandhumanactivityandtherangeprovidedfor
eachLCZtype(withtheexceptionofCompacthigh-rise,LCZ1)isonlyboundedbyanupper
thresholdvalue(Table1).Thismakesadirectcomparisonwith[62]difficult,hencethevalues
inTable5mightserveasafirst-orderapproximationfortheannualheatfluxdensity.Note
thatthesevaluesareexpressedasanannualmeanflux,eventhoughitsvaluevariessignifi-
cantlywithseasonandtimeoftheday.Totacklethisissue,onecouldeitherextractthefull
hourlydatasetfrom[62]orfollowthemethodologyasproposedby[71]andappliedbye.g.
[13,72].
Skyviewfactor(SVF). Fig12illustratestheSVFfootprintfor15Europeancitiesderived
fromGSVimagery,andcanbeviewedinrelationtotheircorrespondingLCZmapsshown
inFig13.Ingeneral,reducedSVFscanbeobservedintheurbancoreexceptforBonn(Ger-
many),whichhasarelativelylow-risecoreowingtoitshistoricaldevelopment.Barcelona,
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 17/27

MappingEuropeintolocalclimatezones
Fig11.LCZmap,imperviousdensity(IMD,%)andmeanannualanthropogenicheatflux(AHF,W/m2)forGermany.
https://doi.org/10.1371/journal.pone.0214474.g011
BrusselsandHamburgexhibitthelowestmeanSVFwith70%,whileToulouseandDublin
havethehighestmeanSVFat84%.Table6summarisesmeanSVFsforeachofthebuiltLCZ
typesforeachcity.ThecomparisonofaverageSVFsineachzonetoLCZvaluesforallcities
showsexcellentresultsconsideringthespatialscopeoftheLCZmap.ThevaluesforOpen
low-rise(LCZ6)andLargelow-rise(LCZ8)arewellwithintheLCZrangesforallcitiesbut
Table5.Imperviousdensity(IMD)andmeanannualanthropogenicheatflux(AHF)urbancanopyparameters.Meanandstandarddeviationarecalculatedoverthe
entireEuropeandomain(LCZmap)andarestratifiedperLCZclass.Referencevaluesfrom[18]areprovidedaswell.
|       | IMD   |             | AHF    |            |
| ----- | ----- | ----------- | ------ | ---------- |
|       | [18]  | LCZmap      | [18]   | LCZmap     |
| LCZ1  | >80   | 90.44       | 50–300 | 29.78      |
| LCZ2  | >70   | 71.36±8.52  | <75    | 11.24±9.27 |
| LCZ3  | >60   | 62.17±10.74 | <75    | 5.21±4.88  |
| LCZ4  | 50–80 | 39.87±3.08  | <50    | 5.81±2.02  |
| LCZ5  | 50–80 | 45.09±11.45 | <25    | 6.44±8.48  |
| LCZ6  | 40-90 | 26.83±11.55 | <25    | 2.39±3.16  |
| LCZ7  | >60   | -           | <35    | -          |
| LCZ8  | >70   | 58.53±14.22 | <50    | 3.49±5.39  |
| LCZ9  | 10-40 | 12.85±8.03  | <10    | 0.73±0.78  |
| LCZ10 | >40   | 64.40±11.76 | >300   | 1.58±0.68  |
| LCZA  | <20   | 5.71±8.1    | 0      | 0.37±0.33  |
| LCZB  | <20   | 7.60±7.79   | 0      | 0.53±0.67  |
| LCZC  | <20   | 15.83±6.51  | 0      | 0.49±0.24  |
| LCZD  | <20   | 8.76±7.96   | 0      | 0.48±0.44  |
| LCZE  | >90   | 40.93±19.87 | 0      | 0.73±0.54  |
| LCZF  | <20   | 33.14±11.7  | 0      | 0.60±0.4   |
| LCZG  | <20   | 13.74±17.45 | 0      | 0.47±0.79  |
https://doi.org/10.1371/journal.pone.0214474.t005
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 18/27

MappingEuropeintolocalclimatezones
Fig12.Skyviewfactorsfor15Europeancities.Sourcesbackgroundmap:Esri,DigitalGlobe,EarthstarGeographics,
CNES/AirbusDS,GeoEye,USDAFSA,USGS,Aerogrid,IGN,IGP,andtheGISUserCommunity.
https://doi.org/10.1371/journal.pone.0214474.g012
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 19/27

MappingEuropeintolocalclimatezones
Fig13.Localclimatezonesfor15Europeancities.Sourcesbackgroundmap:Esri,DigitalGlobe,EarthstarGeographics,
CNES/AirbusDS,GeoEye,USDAFSA,USGS,Aerogrid,IGN,IGP,andtheGISUserCommunity.
https://doi.org/10.1371/journal.pone.0214474.g013
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 20/27

MappingEuropeintolocalclimatezones
Table6.Meanskyviewfactor(%)perbuiltLCZclass.Referencevaluesfrom[18]areprovidedinthetoprow,meanandstandarddeviation(St.Dev.)acrossallselected
citiesareprovidedontopoftheindividualcitylistings.
|           | LCZ1 LCZ2   | LCZ3 LCZ4   | LCZ5 LCZ6   | LCZ7  | LCZ8 | LCZ9 | LCZ10 |
| --------- | ----------- | ----------- | ----------- | ----- | ---- | ---- | ----- |
| [18]      | 20-40 30-60 | 20-60 50-70 | 50-80 60-90 | 20-50 | >70  | >80  | 60-90 |
| Mean      | 63.8 70.1   | 74.1 69.8   | 76.3 78.2   | -     | 80.0 | 78.9 | 85.3  |
| St.Dev.   | 0.0 3.7     | 5.6 9.5     | 4.3 4.1     | -     | 3.4  | 6.8  | 5.7   |
| Barcelona | - 65.2      | 65.0 53.7   | 71.5 77.0   | -     | 75.9 | 74.9 | 77.3  |
| Belgrade  | - 71.7      | 74.7 70.0   | 75.4 79.8   | -     | 82.6 | 84.3 | -     |
| Bonn      | - 71.3      | 71.3 74.3   | 75.0 74.8   | -     | 80.2 | 73.4 | -     |
| Brussels  | 63.8 63.8   | 69.4 66.6   | 70.8 71.0   | -     | 77.0 | 67.8 | -     |
| Bucharest | - 72.4      | 83.5 64.4   | 82.9 83.6   | -     | 82.9 | 84.7 | -     |
| Dublin    | - 78.9      | 81.2 86.6   | 85.7 85.4   | -     | 87.6 | 82.8 | 85.3  |
| Frankfurt | - 67.7      | 68.1 74.4   | 74.7 78.5   | -     | 77.4 | 80.2 | -     |
| Hamburg   | - 67.0      | 73.5 76.9   | 70.6 71.8   | -     | 76.9 | 69.5 | 79.0  |
| Istanbul  | - 68.5      | 68.8 69.0   | 77.0 81.4   | -     | 76.3 | 89.4 | 83.3  |
| Kiev      | - 66.8      | 72.0 75.1   | 74.8 75.3   | -     | 77.7 | 76.2 | 89.9  |
| London    | - 71.1      | 79.9 71.9   | 78.6 75.3   | -     | 79.5 | 71.3 | 83.4  |
| Madrid    | - 72.9      | 77.1 60.5   | 74.1 79.6   | -     | 82.3 | 88.0 | 96.7  |
| Rome      | - 69.0      | 77.6 50.1   | 74.8 76.4   | -     | 77.4 | 75.2 | -     |
| Sofia     | - 73.5      | 80.9 69.6   | 76.0 80.3   | -     | 81.1 | 87.8 | 82.7  |
| Toulouse  | - 72.0      | 67.8 83.3   | 82.4 83.3   | -     | 85.1 | 78.3 | 90.0  |
https://doi.org/10.1371/journal.pone.0214474.t006
thevaluesforcompacttypesaregenerallyhigherfromGSV:23%higherforhigh-rise(LCZ1,
justoncecity)and10%and14%higherformid-andlow-rise,respectively.Thiscouldbe
linkedtotheunderestimationofbuildingheightvaluesbytheWUDAPTmethodologydis-
cussedabove,whichaffectstheLCZclassificationand,asaconsequencetheassociatedSVF
value.ThisisalsoseenintheconfusionbetweensomeLCZtypes,suchascompactandopen
mid-rise(LCZ2and5),whichmightindicatethatsomeneighbourhoodsareperceivedas
morecompactthantheyareinthecreationofTAdata.However,someofthediscrepancies
maybearesultoftheGSVmethodology,whichhasbeenshowntooverestimateSVFin
denselybuiltpartsofcitiesduetoincompletespatialsamplingthatdoesnotincludebackyards
andcourtyards[63,66].
ThesphericalfractionsdonotdirectlycorrespondtothereferencevaluesforLCZsdueto
differentviewpointsofthelandcoverfractions(withincanyonvs.bird’seyeview),yetthey
offervaluableinsightintotheurbanformandcompositionofparametersasmeasuredfrom
thestreetsineachzone.Heretheseresultsarepresentedinthesupplementarymaterialspro-
vidingaveragesphericalfractionsforbuildings,trees,imperviousandpervioussurfaces,sky,
andnon-permanentobjectsineachcity,calculatedafter[64].Insummary:
• Thesphericalbuildingfractionisbasedonwalls(ratherthanroofs)andhighlightstheverti-
caldimensionofurbanform.BarcelonaandIstanbulhavethehighestfractionsamongall
cities(S2Table),whichisindicativeoftallerbuildings,morecompactdevelopments,and/or
lesstreescomparedtotheothercitiesunderinvestigation.
• Thesphericalimperviousfractionistheleastvariableandthemoststablevalueacrossall
LCZsandcities(S3Table),becauseGSVimagelocationsarebiasedtowardsthecentreofthe
road.OnlyfewGSVimagesexistinparksandotheropenareashencetheverylowmeanper-
viousfractionsacrossallLCZtypes(S4Table).
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 21/27

MappingEuropeintolocalclimatezones
• Sparselybuiltareasgenerallyhavethehighesttreefraction,followedbyopenareas(LCZs4,
5,and6)(S5Table).Fewesttreescanbefoundincompactzones(LCZs1,2,and3)andin
Largelow-rise(LCZ8)areas,whichareusuallycommercialspaces.
• Sparselybuiltareas(LCZ9)showthebiggestvariabilityoftreecover,whichreflectsdiffer-
encesinclimateandvegetativecover.Forexample,Barcelona’sLCZ9has41.1%spherical
treecoverageinaMediterraneanclimate,whileMadridexhibitsmoreofasemi-aridclimate
andhasonly16.3%treecoverageinLCZ9.
• Finally,themovingobjectsfractionislowforallzones(S6Table).Thisclassincludesnon-
permanenturbanfeaturessuchascars,trucks,trashbins,andpedestriansandreflectsthe
levelofanthropogenicactivityinthestreetcanyonatthetimeofGSVimageacquisition.
ThefractionishighestincompactLCZs,whichareusuallyinthecitycenter(6.6%-7.6%),
andlowestinSparselybuiltareas(1.9%).
Overall,theseresultsareinlinewiththeexpectedcharacteristicsofLCZtypes.
Summaryandconclusion
Thisresearchhastakenamajorsteptowardsthecreationofaglobalscaleurbandatabase
suitedforclimatestudiesbyutilisingthecomputationalpowerandresourcesofEEandthe
experiencederivedfromcreatingcity-by-cityLCZmapsusingthestandardWUDAPTproto-
col.Thisexperiencehasinformedanurbantransferabilitystrategythat,coupledwithEE,per-
mitsthecreationofacontinentalscaleproduct.
Here,atrainingareadatasetwascarefullycompiledfromexistingWUDAPTdatagathered
byanumberofindividualsforanumberofEuropeancitiesandtheirsurroundingnatural
environments.ThesedatawereusedbyarandomforestclassifiertocreateLCZtypesfrom
inputfeaturesderivedfromgeospatialdatasets(mostly,multi-yearseriesofmultispectraland
SARsatelliteobservations).Allexperimentsreachoverallaccuracyscoresabove70%,which
fulfilstherequirementofanaverageminimumaccuracyof50%topasstheautomatedquality
controlperformedinWUDAPT[21].Thebestperformingexperimentusedalltraininginfor-
mationandallinputfeaturesandresultedinoverallaccuraciesofmorethan80%forboth
urbanandnaturalLCZtypes.Moreover,asimpleurban/non-urbanmaskshowedaveryhigh
agreementwiththemostrecentESACCIlandcovermap.Oftheinputfeatures,thosederived
fromSentinel-1SARdataandvariousspectralindiceshadthestrongestdiscriminatingpower.
Thisworkhasalsoprovidedguidanceforotherup-scalingexperiments,notablythatgreater
effortshouldbegiventoincludingmoreinputfeaturesoveracquiringmoresamplepixelsper
trainingareapolygon.
Inaddition,countryspecificparametersetsformodelapplicationsforbuildingheight,
imperviousdensity,meanannualanthropogenicheatflux,andskyviewfactorwerederived
usingtheEuropeanLCZmapandauxiliarydata,whichforsomepropertiesareonlyavailable
forselectedcities.Whilethederivedparametersmostlymatchtherangesprovidedby[18],
somedeviationsneedfurtherinvestigation.Inparticularthederivedbuildingheightsshow
considerableconfusionbetweenmid-andlow-riseclasses,butalsosomeoftheparameter
rangessuchasLCZ8buildingheightandimpervioussurfacefractionsforthecompactLCZ
classesmayneedrefinement.
ThisstudyprovedthatlargescaleLCZmappingispossibleinacloudcomputingenviron-
mentgivensufficienttrainingdatafortherespectiveregion.Subsequentstudiesneedto
addressthelackoftrainingdataforotherregionsoftheworld(suchasAfricaandIndia),that
isthecurrentimpedimenttocreatingaglobalmap.Thisworkhasshownthatitispossibleto
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 22/27

MappingEuropeintolocalclimatezones
generateaconsistentandcompletecontinental-scaleLCZmap,whichcanservetheneedsof
globalclimatescience.
Supportinginformation
S1Table.Listofabbreviations.
(PDF)
S2Table.Meanbuildingfraction(%)perbuiltLCZclass.
(PNG)
S3Table.Meanimperviousfraction(%)perbuiltLCZclass.
(PNG)
S4Table.Meanperviousfraction(%)perbuiltLCZclass.
(PNG)
S5Table.Meantreefraction(%)perbuiltLCZclass.
(PNG)
S6Table.Mean‘moving’fraction(%)perbuiltLCZclass.
(PNG)
Acknowledgments
WeacknowledgeallWUDAPTcontributorsforprovidingthetrainingareasofourcitiesof
interest.WealsoliketothankthankNoelGorelickforhiscontinuousEarthEnginetechnical
support.WethankUSGSandNASAforthefreeLandsatdata,theCopernicusprogramme
ofESAfortheSentineldataandtheNationalCentersforEnvironmentalInformationatthe
NationalOceanicandAtmosphericAdministration(NOAA)fortheDMSP-OLSdata,all
acquiredviaGoogleEarthEngine.Anyopinions,findings,andconclusionsorrecommenda-
tionsexpressedinthismaterialarethoseoftheauthorsanddonotnecessarilyreflecttheviews
ofthesponsoringorganisations.Wewouldliketothanktheanonymousreviewers,fortheir
valuablecommentsandsuggestions.
AuthorContributions
Conceptualization:MatthiasDemuzere,BenjaminBechtel.
Datacuration:MatthiasDemuzere,BenjaminBechtel,ArianeMiddel.
Formalanalysis:MatthiasDemuzere,ArianeMiddel.
Investigation:MatthiasDemuzere,BenjaminBechtel.
Methodology:MatthiasDemuzere,BenjaminBechtel,ArianeMiddel.
Projectadministration:MatthiasDemuzere.
Resources:MatthiasDemuzere.
Software:MatthiasDemuzere,ArianeMiddel.
Supervision:MatthiasDemuzere.
Validation:MatthiasDemuzere.
Visualization:MatthiasDemuzere,ArianeMiddel.
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 23/27

MappingEuropeintolocalclimatezones
Writing–originaldraft:MatthiasDemuzere,BenjaminBechtel,ArianeMiddel,GeraldMills.
Writing–review&editing:MatthiasDemuzere,ArianeMiddel,GeraldMills.
References
1. GrimmNB,FaethSH,GolubiewskiNE,RedmanCL,WuJ,BaiX,etal.GlobalChangeandtheEcology
ofCities.Science(NewYork,NY).2008;319(5864):756–760.https://doi.org/10.1126/science.1150195
2. BaklanovA,GrimmondCSB,CarlsonD,TerblancheD,TangX,BouchetV,etal.Fromurbanmeteorol-
ogy,climateandenvironmentresearchtointegratedcityservices.UrbanClimate.2017;.
3. Scha¨rC,VidalePL,Lu¨thiD,FreiC,Ha¨berliC,LinigerMA,etal.Theroleofincreasingtemperaturevari-
abilityinEuropeansummerheatwaves.Nature.2004;427(January):332–336.https://doi.org/10.1038/
nature02300PMID:14716318
4. MirallesDG,TeulingAJ,HeerwaardenCCV.Mega-heatwavetemperaturesduetocombinedsoildesic-
cationandatmosphericheataccumulation.NatureGeoscience.2014;7(5):345–349.https://doi.org/10.
1038/ngeo2141
5. RobineJM,CheungSLK,LeRoyS,VanOyenH,GriffithsC,MichelJP,etal.Deathtollexceeded
70,000inEuropeduringthesummerof2003.ComptesRendus—Biologies.2008;331(2):171–178.
https://doi.org/10.1016/j.crvi.2007.12.001PMID:18241810
6. ChristidisN,JonesGS,StottPA.Dramaticallyincreasingchanceofextremelyhotsummerssincethe
2003Europeanheatwave.NatureClimateChange.2015;5(1):46–50.https://doi.org/10.1038/
nclimate2468
7. TaylorKE,StoufferRJ,MeehlGA.AnoverviewofCMIP5andtheexperimentdesign.Bulletinofthe
AmericanMeteorologicalSociety.2012;93(4):485.https://doi.org/10.1175/BAMS-D-11-00094.1
8. HaarsmaRJ,RobertsMJ,VidalePL,CatherineA,BellucciA,BaoQ,etal.HighResolutionModelInter-
comparisonProject(HighResMIPv1.0)forCMIP6.GeoscientificModelDevelopment.2016;9
(11):4185–4208.https://doi.org/10.5194/gmd-9-4185-2016
9. FuhrerO,ChadhaT,HoeflerT,KwasniewskiG,LapillonneX,LeutwylerD,etal.Near-globalclimate
simulationat1kmresolution:Establishingaperformancebaselineon4888GPUswithCOSMO5.0.
GeoscientificModelDevelopment.2018;11(4):1665–1681.https://doi.org/10.5194/gmd-11-1665-2018
10. PreinAF,LanghansW,FosserG,FerroneA,BanN,KellerM,etal.Areviewonregionalconvection-
permittingclimatemodeling:Demonstrations,prospects,andchallenges.ReviewsofGeophysics.
2015;53:323–361.https://doi.org/10.1002/2014RG000475PMID:27478878
11. BarlowJ,BestM,BohnenstengelSI,ClarkP,GrimmondS,LeanH,etal.Developingaresearchstrat-
egytobetterunderstand,observe,andsimulateurbanatmosphericprocessesatKilometertoSubkil-
ometerScales.BulletinoftheAmericanMeteorologicalSociety.2017;98(10):ES261–ES264.https://
doi.org/10.1175/BAMS-D-17-0106.1
12. RondaRJ,SteeneveldGJ,HeusinkveldBG,AttemaJJ,HoltslagAAM.Urbanfine-scaleforecasting
revealsweatherconditionswithunprecedenteddetail.BulletinoftheAmericanMeteorologicalSociety.
2017;98(December):2675–2688.https://doi.org/10.1175/BAMS-D-16-0297.1
13. WoutersH,RidderKD,PoelmansL,WillemsP,BrouwersJ,HosseinzadehtalaeiP,etal.Heatstress
increaseunderclimatechangetwiceaslargeincitiesasinruralareas:Astudyforadenselypopulated
midlatitudemaritimeregion.GeophysicalResearchLetters.2017;44:1–11.https://doi.org/10.1002/
2017GL074889
14. KendonE,ChanS,BanN,SchLC.Pan-Europeanclimateatconvection-permittingscale:amodel
intercomparisonstudy.ClimateDynamics.2018;0(0):1–43.
15. ReviA,SatterthwaiteDE,Aragon-DurandJ,Corfee-MorlotJ,KiunsiRBR,PellingM,etal.Urbanareas.
In:ClimateChange2014:Impacts,Adaptation,andVulnerability.PartA:GlobalandSectoralAspects.
ContributionofWorkingGroupIItotheFifthAssessmentReportoftheIntergovernmentalPanelonCli-
mateChange.[Field,C.B.,V.R.Barros,D.J.Dokken,K.J.Mach,M.D.Mastrandrea,T.E.Bilir,M.Chat-
terjee,K.L.Ebi,Y.O.Estrada,R.C.Genova,B.Girma,E.S.Kissel,A.N.Levy,S.MacCracken,P.R.
Mastrandrea,andL.L.White(eds.)]CambridgeUniversityPress,Cambr;2014.p.535–612.
16. BechtelB,ConradO,TammingaM,VerdonckML,VanCoillieF,TuiaD,etal.Beyondtheurbanmask.
2017JointUrbanRemoteSensingEvent(JURSE).2017;p.1–4.
17. ChingJ,MillsG,BechtelB,SeeL,FeddemaJ,WangX,etal.WUDAPT:Anurbanweather,climate,
andenvironmentalmodelinginfrastructurefortheanthropocene.BulletinoftheAmericanMeteorologi-
calSociety.2018;99(9):1907–1924.https://doi.org/10.1175/BAMS-D-16-0236.1
18. StewartID,OkeTR.LocalClimateZonesforUrbanTemperatureStudies.BulletinoftheAmerican
MeteorologicalSociety.2012;93(12):1879–1900.https://doi.org/10.1175/BAMS-D-11-00019.1
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 24/27

MappingEuropeintolocalclimatezones
19. BechtelB,DanekeC.Classificationoflocalclimatezonesbasedonmultipleearthobservationdata.
IEEEJournalofSelectedTopicsinAppliedEarthObservationsandRemoteSensing.2012;5(4):1191–
1202.https://doi.org/10.1109/JSTARS.2012.2189873
20. BechtelB,AlexanderP,Bo¨hnerJ,ChingJ,ConradO,FeddemaJ,etal.MappingLocalClimateZones
foraWorldwideDatabaseoftheFormandFunctionofCities.ISPRSInternationalJournalofGeo-Infor-
mation.2015;4(1):199–219.https://doi.org/10.3390/ijgi4010199
21. BechtelB,AlexanderPJ,BeckC,BrousseO,ChingJ,DemuzereM,etal.GeneratingWUDAPTLevel
0data—currentstatusofproductionandevaluation.Urbanclimate.2019;27:24–45.https://doi.org/10.
1016/j.uclim.2018.10.001
22. DemuzereM,BechtelB,MillsG.GlobaltransferabilityofLocalClimateZonemodels.Urbanclimate.
2019;27:46–63.https://doi.org/10.1016/j.uclim.2018.11.001
23. BreimanL.RandomForests.MachineLearning.2001;45:5–32.
24. GorelickN,HancherM,DixonM,IlyushchenkoS,ThauD,MooreR.GoogleEarthEngine:Planetary-
scalegeospatialanalysisforeveryone.RemoteSensingofEnvironment.2017;202:18–27.https://doi.
org/10.1016/j.rse.2017.06.031
25. BechtelB,DemuzereM,SismanidisP,FennerD,BrousseO,BeckC,etal.QualityofCrowdsourced
DataonUrbanMorphology—TheHumanInfluenceExperiment(HUMINEX).UrbanScience.2017;1
(2).https://doi.org/10.3390/urbansci1020015
26. SchneiderA,FriedlMa,PotereD.MappingglobalurbanareasusingMODIS500-mdata:Newmethods
anddatasetsbasedon’urbanecoregions’.RemoteSensingofEnvironment.2010;114(8):1733–1746.
https://doi.org/10.1016/j.rse.2010.03.003
27. VerdonckML,VanCoillieF,DeWulfR,OkujeniA,VanderLindenS,DemuzereM,etal.Thermaleval-
uationoftheLocalClimateZoneschemeinBelgium.2017JointUrbanRemoteSensingEvent
(JURSE).2017;p.0–3.
28. VerdonckMl,DemuzereM,HooyberghsH,BeckC,CyrysJ,SchneiderA,etal.Thepotentialoflocal
climatezonesmapsasaheatstressassessmenttool,supportedbysimulatedairtemperaturedata.
LandscapeandUrbanPlanning.2018;178(June):183–197.https://doi.org/10.1016/j.landurbplan.2018.
06.004
29. FennerD,MeierF,BechtelB,OttoM,SchererD.Intraandinter‘localclimatezone’variabilityofairtem-
peratureasobservedbycrowdsourcedcitizenweatherstationsinBerlin,Germany.Meteorologische
Zeitschrift.2017;p.1–23.
30. AlexanderPJ,MillsG.LocalclimateclassificationandDublin’surbanheatisland.Atmosphere.2014;5
(4):755–774.https://doi.org/10.3390/atmos5040755
31. AlexanderPJ,BechtelB,ChowWTL,FealyR,MillsG.Linkingurbanclimateclassificationwithan
urbanenergyandwaterbudgetmodel:Multi-siteandmulti-seasonalevaluation.UrbanClimate.2016;
17:196–215.https://doi.org/10.1016/j.uclim.2016.08.003
32. AlexanderPJ,FealyR,MillsGM.Simulatingtheimpactofurbandevelopmentpathwaysonthelocalcli-
mate:Ascenario-basedanalysisinthegreaterDublinregion,Ireland.LandscapeandUrbanPlanning.
2016;152:72–89.https://doi.org/10.1016/j.landurbplan.2016.02.006
33. TuiaD,MoserG,LeSauxB,BechtelB,SeeL.Opendataforglobalmultimodallanduseclassification.
IEEEdatafusioncontest.2017;8(6).
34. YokoyaN,GhamisiP,XiaJ,SukhanovS,HeremansR,TankoyeuI,etal.Opendataforglobalmulti-
modallanduseclassification:Outcomeofthe2017IEEEGRSSDataFusionContest.IEEEJournalof
SelectedTopicsinAppliedEarthObservationsandRemoteSensing.2018;11(5):1–35.https://doi.org/
10.1109/JSTARS.2018.2799698
35. HidalgoJ,DumasG,MassonV,PetitG,BechtelB,BocherE,etal.Comparisonbetweenlocalclimate
zonesmapsderivedfromadministrativedatasetsandsatelliteobservations.UrbanClimate.2019;
27:64–89.https://doi.org/10.1016/j.uclim.2018.10.004
36. HammerbergK,BrousseO,MartilliA,MahdaviA.Implicationsofemployingdetailedurbancanopy
parametersformesoscaleclimatemodelling:acomparisonbetweenWUDAPTandGISdatabases
overVienna,Austria.InternationalJournalofClimatology.2018;.https://doi.org/10.1002/joc.5447
37. DengC,WuC.BCI:Abiophysicalcompositionindexforremotesensingofurbanenvironments.
RemoteSensingofEnvironment.2012;127:247–259.https://doi.org/10.1016/j.rse.2012.09.009
38. DevriesB,PratihastAK,VerbesseltJ,KooistraL,HeroldM.Characterizingforestchangeusingcom-
munity-basedmonitoringdataandlandsattimeseries.PLoSONE.2016;11(3):1–25.https://doi.org/10.
1371/journal.pone.0147121
39. LiH,WangC,ZhongC,SuA,XiongC,WangJ,etal.Mappingurbanbarelandautomatically
fromLandsatimagerywithasimpleindex.RemoteSensing.2017;9(3).https://doi.org/10.3390/
rs9030249
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 25/27

MappingEuropeintolocalclimatezones
40. As-syakurAR,AdnyanaIWS,ArthanaIW,NuarsaIW.Enhancedbuilt-UPandbarenessindex(EBBI)
formappingbuilt-UPandbarelandinanurbanarea.RemoteSensing.2012;4(10):2957–2970.https://
doi.org/10.3390/rs4102957
41. KoBC,KimHH,NamJY.Classificationofpotentialwaterbodiesusinglandsat8OLIandacombination
oftwoboostedrandomforestclassifiers.Sensors(Switzerland).2015;15(6):13763–13777.https://doi.
org/10.3390/s150613763
42. BhattiSS,TripathiNK.Built-upareaextractionusingLandsat8OLIimagery.GIScienceandRemote
Sensing.2014;51(4):445–467.https://doi.org/10.1080/15481603.2014.939539
43. ZhangH,ChenY,ZhouJ.Assessingthelong-termimpactofurbanizationonrun-offusingaremote-
sensing-supportedhydrologicalmodel.InternationalJournalofRemoteSensing.2015;1161(Octo-
ber):1–17.
44. HsuFC,BaughKE,GhoshT,ZhizhinM,ElvidgeCD.DMSP-OLSradiancecalibratednighttimelights
timeserieswithintercalibration.RemoteSensing.2015;7(2):1855–1876.https://doi.org/10.3390/
rs70201855
45. AnselinL.Localindicatorsofspatialassociation—LISA.Geographicalanalysis.1995;27(2):93–115.
https://doi.org/10.1111/j.1538-4632.1995.tb00338.x
46. SimardM,PintoN,FisherJB,BacciniA.Mappingforestcanopyheightgloballywithspacebornelidar.
JournalofGeophysicalResearch:Biogeosciences.2011;116(G4).https://doi.org/10.1029/
2011JG001708
47. TadonoT,IshidaH,OdaF,NaitoS,MinakawaK,IwamotoH.PreciseGlobalDEMGenerationby
ALOSPRISM.ISPRSAnnalsofPhotogrammetry,RemoteSensingandSpatialInformationSciences.
2014;.
48. TadonoT,NagaiH,IshidaH,OdaF,NaitoS,MinakawaK,etal.Generationofthe30M-MESHglobal
digitalsurfacemodelbyalosprism.In:InternationalArchivesofthePhotogrammetry,RemoteSensing
andSpatialInformationSciences—ISPRSArchives;2016.p.157–162.
49. LouppeG,WehenkelL,SuteraA,GeurtsP.Understandingvariableimportancesinforestsofrandom-
izedtrees.AdvancesinNeuralInformationProcessingSystems 26.2013;p.431–439.
50. LiawA.Classificationandregressionbasedonaforestoftreesusingrandominputs,basedonBreiman
(2001);2018.
51. VerdonckMl,OkujeniA,LindenSVD,DemuzereM,WulfRD,CoillieFV.Influenceofneighbourhood
informationon‘LocalClimateZone’mappinginheterogeneouscities.IntJApplEarthObsGeoinforma-
tion.2017;62(September2016):102–113.https://doi.org/10.1016/j.jag.2017.05.017
52. SokolovaM,LapalmeG.Asystematicanalysisofperformancemeasuresforclassificationtasks.
InformationProcessingandManagement.2009;45(4):427–437.https://doi.org/10.1016/j.ipm.2009.03.
002
53. OkeTR,MillsG,ChristenA,VoogtJA.Urbanclimates. CambridgeUniversityPress;2017.
54. ESA.LandCoverCCIProductUserGuideVersion2.0,availableat:http://maps.elie.ucl.ac.be/CCI/
viewer/download/ESACCI-LC-Ph2-PUGv2_2.0.pdf;2018.
55. DiGregorioA.LandCoverClassificationSystemClassificationconceptsandusermanualSoftware
version(2);2005.
56. PesaresiM,EhrlichD,FerriS,FlorczykA,FreireS,HalkiaM,etal.Operatingprocedurefortheproduc-
tionoftheGlobalHumanSettlementLayerfromLandsatdataoftheepochs1975,1990,2000,and
2014. Luxembourg: PublicationsOfficeoftheEuropeanUnion.2016;.
57. EschT,HeldensW,HirneA,KeilM,MarconciniM,RothA,etal.Breakingnewgroundinmapping
humansettlementsfromspace-TheGlobalUrbanFootprint-.ISPRSJournalofPhotogrammetryand
RemoteSensing.2017;134:30–42.https://doi.org/10.1016/j.isprsjprs.2017.10.012
58. PesaresiM,HuadongG,BlaesX,EhrlichD,FerriS,GueguenL,etal.Aglobalhumansettlementlayer
fromopticalHR/VHRRSdata:Conceptandfirstresults.IEEEJournalofSelectedTopicsinApplied
EarthObservationsandRemoteSensing.2013;6(5):2102–2131.https://doi.org/10.1109/JSTARS.
2013.2271445
59. BechtelB,PesaresiM,FlorczykAJ,MillsG.Beyondbuilt-up:Theinternalmakeupofurbanareas.In:
UrbanRemoteSensing, SecondEdition;2018.
60. EuropeanEnvironmentAgency(EEA).ImperviousnessDensity(IMD)2015;2018.Availablefrom:
https://land.copernicus.eu/pan-european/high-resolution-layers/imperviousness/status-maps/2015.
61. EuropeanEnvironmentAgency(EEA).UrbanAtlas—BuildingHeight2012;2018.Availablefrom:
https://land.copernicus.eu/local/urban-atlas/building-height-2012.
62. DongY,VarquezACG,KandaM.Globalanthropogenicheatfluxdatabasewithhighspatialresolution.
AtmosphericEnvironment.2017;150:276–294.https://doi.org/10.1016/j.atmosenv.2016.11.040
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 26/27

MappingEuropeintolocalclimatezones
63. MiddelA,LukasczykJ,MaciejewskiR,DemuzereM,RothM.SkyViewFactorFootprintsforUrbanCli-
mateModeling.Urbanclimate.2018;25(February):120–134.https://doi.org/10.1016/j.uclim.2018.05.
004
64. MiddelA,LukasczykJ,ZakrzewskiS,ArnoldM,MaciejewskiR.Urbanformandcompositionofstreet
canyons:Ahuman-centricbigdataanddeeplearningapproach.LandscapeandUrbanPlanning.2019;
183(October2017):122–132.https://doi.org/10.1016/j.landurbplan.2018.12.001
65. MiddelA,LukasczykJ,MaciejewskiR.SkyViewFactorsfromSyntheticFisheyePhotosforThermal
ComfortRouting—ACaseStudyinPhoenix,Arizona.UrbanPlanning.2017;2(1):19–30.https://doi.
org/10.17645/up.v2i1.855
66. WangC,MiddelA,MyintSW,KaplanS,BrazelAJ,LukasczykJ.Assessinglocalclimatezonesinarid
cities:ThecaseofPhoenix,ArizonaandLasVegas,Nevada.ISPRSJournalofPhotogrammetryand
RemoteSensing.2018;141:59–71.https://doi.org/10.1016/j.isprsjprs.2018.04.009
67. KoppelK,ZaliteK,VoormansikK,JagdhuberT.SensitivityofSentinel-1backscattertocharacteristics
ofbuildings.InternationalJournalofRemoteSensing.2017;38(22):6298–6318.https://doi.org/10.
1080/01431161.2017.1353160
68. SukhanovS,TankoyeuI,LouradourJ,HeremansR,TrofimovaD,DebesC.Multilevelensemblingfor
localclimatezonesclassification.InternationalGeoscienceandRemoteSensingSymposium
(IGARSS).2017;2017-July:1201–1204.
69. VerdonckML.ThepotentialofLocalClimateZonesasaheatassessmenttoolinBelgium.GhentUni-
versity.FacultyofBioscienceEngineering;2018.Availablefrom:https://biblio.ugent.be/publication/
8574887.
70. VlaanderenDepartementRuimte.Witboek:BeleidsplanRuimteVlaanderen.PeterCabus,Ruimte
Vlaanderen,KoningAlbertII-laan12,1210Brussel;2016.Availablefrom:http://ebl.vlaanderen.be/
publications/documents/97914.
71. FlannerMG.Integratinganthropogenicheatfluxwithglobalclimatemodels.GeophysicalResearchLet-
ters.2009;36(2):1–5.https://doi.org/10.1029/2008GL036465
72. WoutersH,DemuzereM,BlahakU,FortuniakK,MaiheuB,CampsJ,etal.Efficienturbancanopy
parametrizationforatmosphericmodelling:descriptionandapplicationwiththeCOSMO-CLMmodel
(version5.0_clm6)foraBelgianSummer.GeoscientificModelDevelopment.2016;9:3027–3054.
https://doi.org/10.5194/gmd-9-3027-2016
PLOSONE|https://doi.org/10.1371/journal.pone.0214474 April24,2019 27/27
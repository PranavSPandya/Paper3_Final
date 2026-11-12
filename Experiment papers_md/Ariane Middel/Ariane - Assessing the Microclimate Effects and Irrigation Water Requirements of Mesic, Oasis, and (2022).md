hydrology
Article
Assessing the Microclimate Effects and Irrigation Water
Requirements of Mesic, Oasis, and Xeric Landscapes
RubabSaher1,ArianeMiddel2 ,HaroonStephen3,* andSajjadAhmad3
1 DepartmentofHydrologicSciences,DesertResearchInstitute,LasVegas,NV89119,USA;
rubab.saher@dri.edu
2 SchoolsofArt,Media,andEngineering,ArizonaStateUniversity,Tempe,AZ85287-5802,USA;
ariane.middel@asu.edu
3 DepartmentofCivilandEnvironmentalEngineeringandConstruction,UniversityofNevada,
4505S.MarylandParkway,LasVegas,NV89119,USA;sajjad.ahmad@unlv.edu
* Correspondence:haroon.stephen@unlv.edu;Tel.:+1-702-774-1463
Abstract: Urbanirrigationisanessentialprocessinland–atmosphereinteractions. Itisoneofthe
uncertainparametersofurbanhydrologyduetovariousmicroclimates.Thisstudyinvestigatedthe
microclimateeffectsandirrigationwaterrequirementsofthreelandscapetypesinanaridregion
ofPhoenix,AZ.Themicroclimateeffectencompassedsurfacetemperature,airtemperature,and
windspeed. ThesimulationsofthethreelandscapeswereconductedusingENVI-metsoftware
forthehottestdayoftheyear(23June2011). Thesimulatedmodelwasvalidatedusingground
data. Results show that the mesic landscape induced cooling effects, both in the daytime and
nighttime,byreducingsurfaceandairtemperatures.However,themesiclandscapeshowedhigh-
water consumption because of a high leaf area density. The oasis landscape showed 2 ◦C more
daytimecoolingthanthemesiclandscape,butthenighttimewarming(surfacetemperature)was
comparabletothexericlandscape.Thepotentialirrigationwaterrequirementwas1mm/daylower
thanthemesiclandscape.Moreover,microclimateconditionsvariedspatiallyineachneighborhood.
Citation:Saher,R.;Middel,A.;
Thexericlandscapeshowedlowerwindspeedsandairtemperaturesbetweenthebuildings. The
Stephen,H.;Ahmad,S.Assessingthe
MicroclimateEffectsandIrrigation wind speed variations in the three landscapes were inconclusive due to differences in building
WaterRequirementsofMesic,Oasis, orientationsanddiscrepanciesintrees’heights.Thefindingscanhaveimplicationsforrestrictingthe
andXericLandscapes.Hydrology municipalirrigationbudget.Inaddition,theycanhelpwatermanagersinchoosingalandscapein
2022,9,104. https://doi.org/ urbanareas.UrbanscientistscanadaptthemethodologytoquantifyurbanETinaridregions.
10.3390/hydrology9060104
Keywords:microclimateeffects;urbanlandscapes;surfacetemperature;urbanevapotranspiration;
AcademicEditors:RanjanSarukkalige
andGunaAlankarageHewa urbanirrigation
Received:10May2022
Accepted:31May2022
Published:10June2022
1. Introduction
Publisher’sNote:MDPIstaysneutral Overthedecades,communitiesinaridregionshavedevisedpoliciessuchasturfgrass
withregardtojurisdictionalclaimsin removalorreplacementasaheatmitigationstrategy[1]. Thesepolicieshavebeenadopted
publishedmapsandinstitutionalaffil- inthesouthwestUnitedStatestomitigatedroughtemergencies. Recentapproachesinclude
iations.
theSouthernNevadaWaterAuthority’sWaterSmartLandscapesprogram,inwhichturf
grasslawnswereremovedforacertainamountofmoney. Inmostcases,high-water-use
plantspecies,suchasturfgrass,werereplacedbylowwaterconsumptionplantspecies.
Theprogramreportedlyreducedoutdoorwaterconsumptionby50%[2]. Anothersimilar
Copyright: © 2022 by the authors.
policywasadoptedbythemetropolitanwaterdistrictofsouthernCalifornia. Theprogram
Licensee MDPI, Basel, Switzerland.
replaced15.3millionsquaremetersofturfwithnativespecies[3,4]. Whilethesestrategies
This article is an open access article
mayseemtohaveimmediatebenefits,suchasreducedpercapitawaterconsumption,their
distributed under the terms and
long-termbenefitsarequestionable[2].
conditionsoftheCreativeCommons
Attribution(CCBY)license(https:// Replacing vegetated surfaces with impervious surfaces made out of concrete and
creativecommons.org/licenses/by/ asphaltexacerbatestemperatures,especiallyinaridregions,becauseofreducedtranspi-
4.0/). rationratesandhigherthermaladmittance[5]. Thisresultsinnighttimewarming,which
Hydrology2022,9,104.https://doi.org/10.3390/hydrology9060104 https://www.mdpi.com/journal/hydrology

Hydrology2022,9,104 2of19
hasbeenlongknownastheheatislandeffect[6]. Inurbanareas, theheatislandeffect
causesairtemperaturetobewarmerthanintheruralsurroundings[7]thusdiscourag-
ingoutdooractivitiesforresidents,andcausingdetrimentalimpactstotheirmentaland
physicalhealth[8]. Insomecases,tree–turflandscapes,alsoknownasmesiclandscapes,
havebeeninstalled,whichconsistofhighlywater-intensiveplants,includingturfgrass
and nonnative species with a high irrigation water requirement [9,10]. Recently, mesic
landscapeshavebeenunderscrutinyduetotheirinherentlyhighwaterconsumption[11].
Therefore,alternativestrategiessuchaswater-efficientlandscapeshaverecentlygained
attention in arid regions [12–14]. Water-efficient landscapes include a variety of plants
rangingfromdrought-friendlytolow-water-usingspecies[15]. Theselandscapesarecalled
xericandoasis. Thexericlandscapeincludesnativespecieswithadripirrigationsystem.
Theoasislandscapeconsistsoflow-andhigh-water-useplantshavingbothasprinklerand
dripirrigationsystem. Typically,theirrigationapplicationefficiencyofthedripirrigation
systemishigherthanwhenusingthesprinklerirrigationsystem[16].
Simulating vegetated landscapes on a finer scale has been challenging, as neither
remotesensingdatasetsnorclimatestationscaninterpretthegroundconditions[17,18].
Remotesensingdatasetshaveacoarseresolution,whichcannotcapturethespatialvari-
abilityoftheplantspecies[19]. Inaddition,weatherstationsinvolvepointmeasurements
limitingtheregionalspatialvariability[20–22].
Thesoil–atmosphere–plantinteractionhasbeenstudiedusingurbancanopymodels.
KusakaandKumara(2004)coupledasingle-layerurbancanopymodeltosimulatethe
airtemperaturebetweentwobuildings[23]. Anotherstudymodeledamulti-layerurban
canopytounderstandtheemissionsandheat-trappingbetweentwobuildings.Bothcanopy
modelsarelimitedtoafive-meterresolution[24]. Recentstudieshavecoupledtheurban
canopymodelstoNoahlandsurfacemodels(LSM)toimprovethespatialresolution[25].
TheNoahLSMmodelsvarybetween30mto100kminresolutionandaremoresuitable
foralocalscale.
The computational fluid dynamics (CFD) modeling approach has recently gained
attentiontosimulatethemicroclimateconditionsofurbanlandscapes[25–28]. TheCFD
model ENVI-met has been developed to understand the neighborhood-scale effects of
soil–atmosphere–plantinteractionsinsurfaceandatmosphericexchanges. ENVI-methas
recentlybeenrecognizedinaridclimatezonesandtemperateclimatezones. Onestudy
investigatedtheairtemperatureinthevariousurbanformsoffiveneighborhoodslocated
inPhoenix,AZ[27],reportinga95%accuracybetweenthesimulatedandobservedmodels.
Later,Cranketal.,(2020)validatedthemeanradianttemperatureofENVI-metsimulations
in five fields in Phoenix, AZ, between 2014 and 2017 with five 23-h simulations [29].
The study reported that the model should not be used under micrometeorological or
morphologicalextremeswithoutgroundvalidation. ArecentreviewbySaheretal.,(2020)
suggested ENVI-met as a microclimate evaluator for better estimating irrigation water
requirements[18].
Knowledgeofthewaterusedbyvariouslandscapesinurbanareasislacking,resulting
inwaterwastage[11,30]. Landscapes,ingeneral,arehighlyunpredictabletowaterand
energyfluxandarechallengingtoestimatebecauseofvariabilitiesinstomatalresponses
among species and their spatial placements [31]. Recent studies have highlighted the
importanceofunderstandingthebehaviorofvariouslandscapesandtherolethatmicrocli-
matesplayinsavingwater[22,32,33]. Onestudymodeledxericandmesiclandscapesin
Mesa,AZ.Xericlandscapeswereabletowithstandmoisturedeficitsbyirrigatingthem
infrequent,smallintervals. Conversely,ahighereventdepthforirrigationandslightly
longerintervalswerereportedtobeoptimalinamesiclandscapesite. Thestudydevised
the irrigation schedules based on the water needs of various landscapes and reported
50% irrigation water saving [32]. Another study devised a neighborhood scale scheme
toquantifytheurbanevapotranspirationasafunctionofplantspeciesandmicroclimate
effectsinmetropolitanLosAngeles,reporting30%watersavingbycalibratingtheirrigation
formicroclimateeffects[34]. Studieshavealsohighlightedtheimportanceofconsidering

Hydrology2022,9,104 3of19
themicroclimateconditionsofthelandscape. However,insufficientliteratureispresent
to improve the understanding of microclimates in urban irrigation [18,35]. This study
analyzedthreelandscapesinanaridneighborhoodtounderstandtheeffectsofbuildings
anddiscontinuoussurfaces,asmicroclimates,onurbanirrigation.
ThestudybuildsontwomodelingstudiesbyMiddeletal.,(2014,2015)[13,27]. The
objectiveofthestudywastoinvestigatethemicroclimateeffectsofmesic,xeric,andoasis
landscapesinanaridcity: Phoenix,Arizona. Themicroclimateeffectswereinvestigated
usingthreevariables: airtemperature,surfacetemperature,andwindspeed. Thestudy
investigated the landscapes under an open sky and between buildings to understand
theeffectsofshadeonthelandscape. Thesecondobjectivewastoanalyzethepotential
irrigationwaterrequirementsofthelandscapes. Thepotentialirrigationwaterrequire-
mentwasestimatedasafunctionofevapotranspirationoftheplantsandirrigationwater
requirementofthelandscape. Tosimulatethegroundconditions,thisstudyemployed
ENVI-metversion4.4,whichallowsformodelingtreesin3Dinsteadof2Dinversion3.5,
usedbyMiddeletal.,2014[27]. Thesimulationsforthemodelwerecarriedoutover24h.
The ENVI-met modeling is computationally cumbersome; it has a duration that varies
between6and48h[36]. Thus,theselectionoftheperiodforthestudywasjustifiable. The
evapotranspirationwasestimatedbasedonthesurfaceenergybalanceapproach,which
estimatestheresidualenergy,latentheatofevaporation,netradiation,soilheatflux,and
sensibleheatfluxdensity. Thesimulationwascarriedoutforthehottestdayoftheyear:
23June2011.
2. StudyArea
TheNorthDesertVillage(NDV)wasusedasastudyarea.ItislocatedatArizonaState
University’sPolytechniccampusandhasthreeexperimentalsiteswithmesic,oasis,and
xericlandscapes(Figure1). Theexperimentalsiteswereestablishedin2004anddesigned
toprovidetheCentralArizona–PhoenixLong-TermEcologicalResearch(CAPLTER)group
aplatformtostudytheplant–soil–waterimpactsofthermalandanthropogeniceffects[37].
Figure1.Studyareashowingthemesic,oasis,andxericlandscapewiththeirsurfacefeatures;red
starsineachlandscapeindicatetheweatherstationusedforthemodelvalidation.

Hydrology2022,9,104 4of19
The mesic landscape site includes a mix of non-native and high water-use plants,
trees,andturfgrass(greenpixels,Figure1). Theoasisandxericlandscapesusenon-native,
desert-adapted species. Both neighborhoods are close to each other and have similar
landcovers,therefore,theyfallinasimilarlocalclimatezone[38]. Themesiclandscape
site is mainly covered with turf grass and trees such as Acacia stenophylla, Malus, and
Myrtus communis. The oasis landscape encompasses a patch of turf grass, shrubs, and
treessurroundedbysingle-storyresidentialbuildings. Similarly,thexericlandscapewas
modeledwithadensityofshrubs,vines,andtreeswithasparseleafarea. Eachlandscape
hasamicrometeorologicalstationtomonitortheairtemperatureata2mheightandthe
surface temperature, soil heat flux, and volumetric water content at a 30 cm depth. As
presentedinFigure1(redstars),thethreestationsareplacedinthemiddleofthevegetated
landscape. Thestationisplacedatthetopoftheturfgrassinthemesiclandscapeandoasis
landscape. Thestationwasplacedattopofthemulchsurroundedbyshrubsandtrees
inthexericlandscape. Thethreestationswereunderanopenskywithnoobstaclesto
createbiases,however,somebiasesregardingthewindspeedareinevitablebecauseof
thepresenceofhardscapeandtrees. Themicrometeorologicalstationswereusedforthe
modelvalidation.
3. Methodology
3.1. ENVI-MetOverview
ENVI-metisathree-dimensionalCFDmodelusedtosimulatethephysicalprocesses
of surface–plant–air interactions. It can model the ground conditions at spatial resolu-
tions ranging between a 0.5 and 10 m grid cell size and a temporal resolution ranging
between 24and48h with a 1 to 5 s timestep [39]. The applications of ENVI-met range
fromsimulatingtheurbanheatislandeffectstoevaluatingvegetationdensitiesinurban
areas[36,39–42].
ENVI-metsimulates14layersbetweentheupperand2mdeeplayers. Thesoillayeris
treatedasaone-dimensionalverticalcolumnexceptfortheupperlayer,whereheattransfer
iscalculatedinthreedimensions. Themodelcalculatesheatandwaterexchangesofsoil
at0.01mdepth,closetothetoplayerofsoil,andadepthof0.5minthedeeperlayersup
to2m. Theintroducedvegetationinthemodelistreatedasaone-dimensionalcolumn
withdefinedheight. Themodelusestheleafareadensityofthevegetationtodefinethe
distribution of the leaves. The soil model also works on a similar approach where the
rootareadensity(RAD)profileestablishesthedistributionofroots. Themodels’detailed
equationsarepresentedbyBruse[42].
ENVI-metworksontheprinciplesoffluiddynamics,thefundamentallawsofatmo-
sphericphysics,andthermodynamics. Itiswidelyknowntosimulatesurface–plant–air
interactionsinurbanareasusingatmospheric,surface,vegetation,andsoilmodels. Theat-
mosphericmodelcalculatesthethree-dimensionalturbulence,airmovement,temperature,
relativehumidity,andvariationsinradiationduetoshadingandvegetatedsurfaces. The
modelsolvestheReynoldsaveragednon-hydrostaticNavier–Stokes(RANS)equationin
eachgridcellforadefinedtimestep[43]. Thesurfacemodelcalculatestheheatexchanges
ofsurfacesbasedontheresidualenergyofnetradiation,soilheatflux,andsensibleheat
fluxdensity[44]. Eachnestingcellisrepresentedbyitsthermodynamicmodel, having
seven prognostic calculation nodes. The thermal state of the nodes is calculated from
thephysicalpropertiesofthewall/roofbasedonFourier’slawofheatconduction. The
vegetatedmodeltreatstheplant’scanopyasaggregateddynamicobjectsreactingtothe
immediateenvironmentalconditions[45]. ThisisdonebymodelingtheexchangeofCO
2
and water vapor at the microscale (leaf level) using Jacob’s A-g model, which, unlike
s
Deardorff’sstomatalresistancemodel,considersthestomatalbehaviorofeachleafexposed
totheheterogeneousmicroclimateconditionsofplantandsurroundings[37]. Thisallows
anaccuratesimulationofplantphysiologicalactivityattheleafscale,consideringvarious
environmentalconditions. Anobservedrelationshipbetweenthephotosyntheticrate(A )
n
oftheplantandthestomatalconductance(g )oftheplantisusedtoobservethewateruse
s

Hydrology2022,9,104 5of19
balanceofplantsandCO assimilationtominimizethewaterlossandmaximizecarbon
2
gain[46]. Thehumidityresponseofthestomatainthemodelwasestimatedusingtheratio
ofleafinternalCO concentration(C)toexternalconcentrations(C ). Thebasicprinciple
2 i s
ofthemodelcanbemathematicallywrittenas:
A
g =1.6 n
s C −C
s i
Thevalueof1.6representsthediffusivityofCO andH Ointheair.
2 2
The physical limitation of ENVI-met regarding the vegetation modeling involves
theoversimplificationofthevegetationmodel. Thiswasdonetoimprovethecomputa-
tionalefficiency. Theignoredparametersincludetheattenuationofdiffuseradiations,the
reflectanceofgroundandvegetationsurfaces,radiationheattransferbetweentheleaf,sur-
face,andatmosphere,andtheheatconvectionbetweenthesurroundingairandthesurface
areaoftheleaf[47]. Becauseoftheoversimplification,theLAIisnotclimate-sensitiveand
hasstaticvalues.
LAIhasbeenwidelytestedforthehotdesertclimatebutnotforhot–humidclimate
zones. RecentstudieshavehighlightedthelimitedapplicationofENVI-metinhotdesert
climates. Researchinotherclimateshavereportedsignificantbiasesinvegetationmodel-
ing[48]. Astudyconductedtomodelthetreesinsub-humidpartsofGermanyreported
the underestimation of transpiration rates [49]. Another study compared the modeled
andobservedtranspirationvaluesandreportedtheimprovementinperformanceifthe
inputvaluesofphotosyntheticactiveradiation(PAR)wereretrievedwithminimalcloud
cover[50]. Otherstudieshavereportedimprovementsintheperformanceofthetreemodel
when the input LAI values were measured [51]. Therefore, this study has utilized the
measuredvalues. ThedetailsareprovidedinSection3.2.
The ENVI-met database provides soil types and their profiles, plants, walls, and
groundsurfaces. Theplantdatabaseincludesavarietyoftreespecies,hedges,andgrasses,
alongwithgenericpalm,deciduous,andconiferoustreesofdifferentsizes. Thespeciesare
classifiedintohigh-andlow-leaf-areadensity. ENVI-metallowstheusertocustomizetrees
inanAlberotooltocreatea3Dplantbasedonitsgeometry,leafareadensity,transmissivity,
andbiomass[52]. Thesoildatabaseincludesbothmarbledandnaturalsoils,including
loamysand,basalt,cementconcrete,andmanymoretypes. Thelimitationofthecurrent
ENVI-met version is that it only supports uniform building materials [29]. The profile
databasemodelsthegroundlayersusingacombinationofsoiltypes. Itmodelsa200cm
deepgroundlayer. Theprofiledatabaseincludesarangeofsurfaces,includingloamyand
sandysoilanddifferenttypesofroadsandpavements.
3.2. ModelSetup
Themodelsetuprequirestwomajorsteps. First,the3Dmodeldomainneedstobe
establishedthroughdigitizingorimportingdatafromshapefilesorOpenStreetMapsvia
Monde. Second,themeteorologicalforcingdataforthedayofinterestmustbedefinedina
simulationfile,aswellasothermodelparameters,suchasthetimestepandsimulationtime.
WhileENVI-metinputdataforbuildingsandgroundsurfaceswereadoptedfromthe
studybyMiddeletal.,2014,thevegetationlayerwasreplacedwith3DtreesinENVI-met
version4.4.TheinventoryforthespeciesineachneighborhoodislistedinTable1.Basedon
theheightandspeciesofeachtreeintheENVI-met3.5domain,anew3Dtreewasselected
fromtheENVI-metdatabasethatmostcloselyresembledtheshape,type(coniferousvs.
deciduous),andleafareadensity(LAD)ofthe2Dtree. Theplantspeciesinclude18shrubs
and25treespecies,aspresentedinTable1. Thecustomizationofeachplantspecieswas
doneinanAlberopackageofENVI-met. Themodeledtreeswerecustomizedwithalow
leafareadensityandanaverageheightof5m. Theinventoryofplantspeciesandtheir
physiologicalpropertieswasretrievedfromvariousstudies[13,53]. Thestudiesuseda
plantcanopyanalyzer,namelyLiCORLAI-2000,todeterminetheleafareaoftrees. The

Hydrology2022,9,104 6of19
LADwasextrapolatedusingaregressionmodelbetweenthetrees’totalfoliagebiomass
andleafarea.
Table1.Trees,shrubs,andvinesinthestudyareaweremodeledusing2DplantsinENVI-met3.5.
SpeciesBiologicalName MesicLandscape OasisLandscape XericLandscape
Trees
| AcaciaSalonica    |     | •   |     |
| ----------------- | --- | --- | --- |
| Acaciastenophylla | •   | •   | •   |
•
Brachychitonpopulneus
| Braheaarmata            |     |     | •   |
| ----------------------- | --- | --- | --- |
| Corymbiapapuana         |     | •   |     |
| Eucalyptuscamaldulensis | •   | •   |     |
•
Eucalyptusmicrotheca
| Eucalyptuspolyanthemos | •   |     |     |
| ---------------------- | --- | --- | --- |
| Fraxinusunder          |     | •   |     |
| Fraxinusvalutina       |     |     | •   |
•
Malus(apple)
| Melaleucaviminalis | •   | •   | •   |
| ------------------ | --- | --- | --- |
| Myrtuscommunis     | •   | •   |     |
| Parkinsoniahybrid  |     |     | •   |
|                    | •   | •   | •   |
Phoenixdactylifera
| Pinuseldarica    | •   | •   |     |
| ---------------- | --- | --- | --- |
| Pinushalepensis  |     |     | •   |
| Pistaciachinesis | •   |     |     |
•
Platanuswrightii
| Platycladusorientalis | •   | •   | •   |
| --------------------- | --- | --- | --- |
| Prosopishybrid        |     |     | •   |
| Prunuscerasifera      |     | •   |     |
|                       | •   | •   |     |
Ulmusparvifolia
| Washingtoniafilifera |     |     | •   |
| -------------------- | --- | --- | --- |
ShrubsandVines
| Bougainvilleahybrid |     | •   |     |
| ------------------- | --- | --- | --- |
•
Caesalpiniapulcherrima
| Caesalpiniagilliesii  |     |     | •   |
| --------------------- | --- | --- | --- |
| Calliandracalifornica |     |     | •   |
| Carissamacrocarpa     |     | •   |     |
•
Chamaeropshumilis
| Enceliafarinosa      |     |     | •   |
| -------------------- | --- | --- | --- |
| Hesperaloeparviflora |     |     | •   |
| Lantanahybrid        |     | •   |     |
•
Leucophyllumcandidum
| Leucophyllumfrutescens |     | •   |     |
| ---------------------- | --- | --- | --- |
| MacFadyenaunguis-cati  |     | •   |     |
| Myrtuscommunis         | •   | •   |     |
|                        |     | •   | •   |
Neriumoleander
| Rosahybrid          | •   |     |     |
| ------------------- | --- | --- | --- |
| Ruelliabrittoniana  |     | •   |     |
| Ruelliapeninsularis |     |     | •   |
•
Tacomacapensis
•modeledinthelandscape.

Hydrology2022,9,104 7of19
TheselectedsoilparameterswereretrievedfromtheNaturalResourcesConservation
Services(NRCS)databasehavingMohallLoam,consistingofclayloam,sandyloam,and
loam[54]. WeselectedloamysandfromtheENVI-met4.4databaseasthesoilinthemodel
area. Tosimulatethegroundconditions,thestudyusedmulch(decomposinggranite)for
xericandoasislandscapes. Mulchhasalonghistoryofbeingusedindesertlandscaping
to reduce soil evaporation. Therefore, the non-turf grass surfaces were covered with a
5cmlayerofmulch. Thesoilcharacteristicsofdecomposingmulchwereretrievedfrom
previousstudiesintheNorthDesertVillage[27,55]. Buildingwallsweremodeledasstucco
withasphaltshingleroofs. IncontrasttoENVI-met3.5,version4.4allowsforthehourly
forcingofairtemperatureandhumidity.
ForcingdatawereretrievedfromthenearbyMesaairport(33.3090◦ N,111.6559◦ W)
(Figure2). Theairportsiteis1.2milesawayfromthestudyarea;therefore,itwasused
asasitecontainingtheinitialboundaryconditionsforvariablessuchasairtemperature
andrelativehumidity. Nootherstationswereobservedinthesurroundingarea,making
theMesaairportstationtheonlyoptioninthevicinity. Thesurfaceelevationisthemain
variablecontributingtoaberrantairtemperatureandrelativehumidity,whichbetweenthe
studyareaandtheairportisflat,therefore,itwassafetoconsidertheMesaairportweather
stationdatasetasaninitialboundarycondition.
Figure2.ENVI-metweatherinput(hourly)for23June2011.
Thewindspeedinputsforthemodelincludethose10mabovewindspeed,which
wasdefinedas1.5m/sNEataroughnesslengthfromthereferencepointof0.01m.
3.3. ModelEvaluation
Themodelwasevaluatedbycomparingthesimulatedhourlyairtemperaturewiththe
observedvalues.Thestudyfollowedthemethodologysuggestedby[56].Theexperimental
air temperature values were observed at 2 m above the surface and were acquired by
installingaweatherstationateachlandscapeaspartoftheNorthDesertVillageexperiment
(redstarsinFigure1indicatethelocation). Thesimulatedvalueswereretrievedforthe
similarcellwheretheweatherstationwasinstalled. Themodelcalculatesthevaluesby
introducingareceptorpoint. Thedeviationbetweentheobservedandsimulatedvalues
wasreportedusingrootmeansquareerror(RMSE)andmeanabsoluteerror(MAE).The
biasinthemodelwascalculatedusingmeanbiaserror. Theindexofagreementbetween

Hydrology2022,9,104 8of19
theobservedandsimulateddatapointswascalculatedtodeterminethedegreetowhich
themodelwaserror-free. Itrangedbetweenzeroandone;avalueofd=1indicatedthat
thesimulatedandobservedvalueswereerror-free.
The simulated data were extracted at a receptor in the domain (red star, Figure 1).
Themodelwasvalidatedbycomparingtheairtemperaturetimeseriesat2mwiththe
simulateddatapoints(Figure3). Becauseofmodelspin-uptime,theliteraturesuggested
usingonlythesunshinehoursforvalidation[57–59]. Therefore,thevalidationwasdone
for15h.
Figure3.Modelevaluationsbycomparingtheobservedandsimulatedairtemperatureat2mheight
formesic(a),oasis(b),andxeric(c)landscapes.
3.4. DeterminationofMicroclimateEffects
Spatialmapsandtimeseriesplotswerecreatedtounderstandthemicroclimateeffects
for the three landscapes. In this study, the microclimate effects were limited to the air
temperature,surfacetemperature,andwindspeedpatternsinthethreelandscapes. These
effects were investigated in an open sky setting and between buildings. A random set
comprising twenty nesting grids of shrubs, turfgrass, and trees were considered. The
twentypointsaroundthelandscapewereselectedtounderstandthemicroclimateeffects
ofanopenskyandshadedspacesinaneighborhood. Thisisbecauseofthedifferencein
theradiationbudgetinbothsurfaces. Typically,areasundershadehavelimitedincident
shortwaveradiation,therefore,alowersurfacetemperature;however,somestudiescontest
thatthespacescouldexperiencehighertemperaturesbecauseofheattrappinginducedby
wallemissions[60,61]. Thesamplingwasdonefortheopenskyplantsandbetweenthe
buildingsbydefiningvariousreceptorsandre-runningthesimulations. Thetimeseriesof
thenestinggridsfordifferentlandscapeshavebeenanalyzedinthestudy.
3.5. DeterminationofPotentialIrrigationWaterRequirement
Thepotentialirrigationwaterrequirementisthefunctionofevapotranspirationand
irrigationefficiency. TheevapotranspirationwasestimatedusingtheENVI-metmodel.
Thevaluesconsideredweretheaverageofthecellsintheopensky,whiletheirrigation
efficiencywasassignedbasedonthelandscapetype. Theplantstomatainthemodelwere
givenazerovalueforthesunsethours. Thismeansthattheplantishighlystressedduring

Hydrology2022,9,104 9of19
thedaytime,whichmaynotbethecaseinthemorning. However,theENVI-metmodel
didnotrespondwelltodailypatternsotherwise,withanunknownexplanation. Future
developmentsregardingtheENVI-metmodelcanimprovethedailystomatalresponseto
waterfluxes.
Irrigationefficiencyistheratioofwaterconsumedbytheplanttothewatersupplied
through the irrigation system [62]. The xeric landscapes used drip irrigation, and its
efficiency ranged between 75 and 90%. Because of the application of reclaimed water
andleachingfactors,thestudyconsideredaconservativeapproachandassigned85%as
irrigationefficiency[1]. Themesiclandscapeusedsprinklerirrigationfortheturfgrass,
withanirrigationefficiencyof75%. Anaverageofboththeirrigationpractices(80%)was
assignedtotheoasislandscape. Becausethelandscapeutilizedshrubsandtreesandsmall
parcelsoftheturfgrass,itwasgivenadripirrigationsystem.
Thethreelandscapeswerecomparedwithcool-seasongrass,tallfescue,andBermuda
grass. Theevapotranspirationofbothgrasstypeswashigherthaninthelandscapes. The
landscapeswerecomparedtothetwotypesofgrasstounderstandthedifferencesthat
wereobservedduetothemixedspecies.
4. Results
4.1. ModelEvaluation
Overall,thethreelandscapesconformtothegroundconditions,asshowninFigure3.
The xeric landscape led to a high RMSE of 1.92 ◦C (Table 2). The second highest value
wasobservedforthemesiclandscape(1.50◦C),followedbytheoasislandscape(0.86◦C)
(Table2). TheENVI-mettoolreportedlyperformedpoorlyinthexericlandscape,which
wasdesignedfortemperateclimates[12,26].
Table2.Modelevaluationusingbasicstatisticsbetweenobservedandsimulatedairtemperaturesat
2m.
ModelParameters Mesic Xeric Oasis
RMSE 1.50 0.86 1.92
MBE 0.91 0.21 1.69
MAE 1.33 0.56 1.70
d 0.98 1.00 1.00
4.2. MicroclimateEffectsofLandscapes
Toexplainthemicroclimateconditions,thissectionisdividedintothreesubsections.
Inthefirstsubsection,variationsofsurfacetemperatureatnooninthemesic,oasis,and
xericlandscapesareexplainedthroughspatialmaps. Thesecondsubsectiondescribesthe
spatialvariationsofwindspeedsthrough3Dspatialmapsprovidedforthemesic,oasis,
andxericlandscapes. Thethirdsubsectionprovidesthediurnalairtemperaturevariation
andwindspeedattwometers. Anopen-skyvegetatedsurfaceandthevegetatedsurface
betweenthebuildingswereconsideredforthediurnaleffects. Thediurnalvariationsare
explainedusingalinegraph.
4.2.1. VariationinSurfaceTemperature
Thebuildingheight,soiltype,andsoilprofilearethesameforthethreelandscapes.
Thethreelandscapesareinthesamelocalclimatezoneandarelessthanonemilefromone
another. Therefore,itissafetoassumethatthediurnalsurfacetemperaturevariationsare
duetothesurfaceenergyexchanges. Figure4showsthesurfacetemperaturevariationsof
thethreetypesoflandscapesatnoon. Thebluecolorshowsalowertemperatures,while
redandpinkshowhighertemperatures.

Hydrology2022,9,104 10of19
Figure4.Surfacetemperaturesofthemesic(a),oasis(b),andxeric(c)landscapesatnoon.

Hydrology2022,9,104 11of19
Figure4ashowsthemesiclandscapewithelevensingle-storybuildingsofafive-meter
height,surroundedbytreesandturfgrass. Thehighesttemperatureinthelandscapewas
reportedasbeing66◦C,visibleattheborderoftheneighborhood(pinkspots). Incontrast,
thelowesttemperaturereportedwas26◦C,observedfortheshadedsurfacesbetweenthe
buildings. Amedianvalueof55.5◦Cwasobservedforthelandscape. Additionally,the
characters withtree shade(orange pixels) show a4 ◦C lowersurface temperaturethan
theturfgrasssurfaces(redpixels). Thelowesttemperaturewasobservedforthesurfaces
thathadbothengineeredshade(buildingsandoverhang)andtreeshade(cyanpixels). An
8◦Cdifferenceintemperaturewasobservedbetweenthecharactersundertreeshadeand
engineeredshade. Inaddition,adifferenceof4◦Cwasobservedbetweentheturfgrass
surfaceswithandwithouttreeshade.
Theaveragesurfacetemperatureoftheoasislandscapeiscomparabletothemesic
landscape, as shown in Figure 4b. However, the lowest temperature observed in the
landscapewas5◦Chigher(31◦C),andthemaximumtemperaturewas1◦Clower(65◦C)
thanthemesiclandscape. Thehighesttemperaturewasobservedforthehardscapes(pink
andredpixels)attheoutskirts,whilethesurfacesbetweenthebuildingsandunderthe
treeshadeshowedlowertemperatures(yellowandgreenpixels). Inaddition,thesurfaces
betweenthebuildingswere4–9◦Ccoolerthantheopen-skysurfaces,asvisibleinFigure4b.
Thexericlandscapewas1◦Cwarmerintermsofaveragesurfacetemperaturesthan
the mesic and oasis landscapes (Figure 4c). The maximum surface temperature at the
neighborhood border was 1 ◦C higher than the mesic landscape and 2 ◦C lower than
theoasislandscape. Theminimumsurfacetemperaturewas7◦Chigherthanthemesic
landscapeand3◦Chigherthantheoasislandscape.
Overall, the variations in minimum surface temperature can be inferred from the
cooling due to the different landscapes. The cooling effects were higher for the mesic
landscapebecauseofitstree/turflandscape. Thexericlandscapecontributedrelatively
lesstocoolthesurface.
4.2.2. SpatialVariationinWindSpeed
Figure5presentsa3Dviewofthelandscapeswithsurfacefeaturesandwindspeed.
Thepresenceofbuildingsandtreesreducedthewindspeedbybreakingkineticenergy,
causingturbulence[63]. Inthemesiclandscape,themaximumwindspeedwasreported
as1.20m/s(pinkandredpixels),andtheminimumwindspeedwas0.6m/s(cyanand
yellowpixels),asshowninFigure5a. Themesiclandscapewasmodeledwithhigh-leaf-
areadensityshrubsandtrees,rangingbetween15and25m. Theincreasedwindspeed
was observed at the neighborhood border, while the low wind speeds were observed
surroundingthebuildingsandtrees.
Inthecaseoftheoasislandscape,thewindspeedwashigherforthesurfacesbetween
thebuildingsandtrees,asshowninFigure5b. Thelandscapewasmodeledwithspherical
trees,havingacrownof15mandadepthof20m. Thedifferencewas0.1m/sbetweenthe
surfacesobstructedbythebuildingsandtheopensky.
Thexericlandscapewasmodeledwithlow-leaf-areadensityandsphericaltreesand
shrubsrangingbetween5and15m(Figure5c). Relativetothetwolandscapes,thexeric
landscapesshowedlowerwindspeeds. However,thewindspeedwithinthebuildings
was0.3m/shigherthantheoasislandscapeand0.1m/smorethanthemesiclandscape.
4.2.3. DiurnalVariationinAirTemperatureandWindSpeed
Figure6ashowstheaveragebehavioroftheairtemperatureforthemesic,oasis,and
xericlandscapes. Theturfgrasssurfaceswereconsideredfortheairtemperatureresponse.
Turfgrasswithintheopenskyandsurroundedbybuildingsandtreeswasreported. This
wasdonetounderstandthethermaleffectsofthepresenceofthebuildingsandtrees. The
peakairtemperaturewasobservedat15:00hwith48◦C.Thelowestairtemperaturewas
keptat6:00h(25◦C).Overall,nosignificantdifferencewasobservedforthevegetated
surfaceswithanopenskyorbetweenbuildings.

Hydrology2022,9,104 12of19
Figure5.Windspeedsformesic(a),oasis(b),andxeric(c)landscapesatnoon.

Hydrology2022,9,104 13of19
Figure6.(a)Diurnalvariationofairtemperaturesforthelandscapes;(b)diurnalvariationofwind
speedsforthelandscapes.
Thelowerairtemperaturewasobservedforthemesiclandscape. Thisbehaviorwas
expected. However, themesiclandscapeshoweda2 ◦Chigherairtemperatureduring
peakdaytimehours(11:00h–13:00h)forthesurfacesbetweenbuildings. Thiseffectcanbe
inducedbytheemissionsofthewallsurfaces,causingheat-trapping.
The oasis landscape showed a similar pattern of air temperature variation to the
mesic landscape. However, interestingly, the air temperature of the open-sky surface
between11:00–13:00hwas1◦Clowerthaninthemesiclandscape. Furthermore,adrop
inairtemperature(2◦C)wasobservedforprolongedperiods(10:00–16:00)intheoasis
neighborhoodbetweenbuildings. However,thenighttimeairtemperaturewasobserved
tobesimilartothexericlandscape.
Thexericlandscapeshowed,onaverage,a3◦Chighertemperaturethanthemesicand
xericlandscapes. Thexericlandscapeemployedlow-water-consumingplantspecieswitha
sparseleafareadensity. Thisreducesthetranspirationratesandincreasesairtemperatures.
Theairtemperatureofthexericlandscapeshowedthesamebehaviorinanopenskyand
betweensurfaces.
Figure 6b shows the overall landscapes’ wind speed. The variations in the wind
speedsareinconclusive. Anopen-skyvegetatedpatchinthemesiclandscapehasalower
windspeedthanoasisandxericlandscapes. Similarly,themesiclandscape’swindspeed
betweenthebuildings(canyoneffects)islowerthanthexericandmesiclandscapes. The
wind speeds are a function of the geometry of the structure, including the tree height,
crown cover, and canopy cover of trees and bushes, respectively, along with building
heights[21,64,65]. Therefore,lowerwindspeedratesmaybeexplainedduetothepresence
ofmoretreesbreakingthewindenergy. However,theorientationsofthethreelandscapes
areentirelydifferent,whichmakesthefindingsquestionable,henceinconclusive. Inthis
study,realneighborhoodswereconsidered;windpatternscanbeachallenge.Idealresearch
tounderstandwindvariationscanbedoneusingENVI-metbydevisingahypothetical
neighborhoodwiththesameorientation,soilprofile,andbuildingdensitytounderstand
thewindpatterns.

Hydrology2022,9,104 14of19
4.3. PotentialIrrigationWaterRequirementofLandscapes
Theirrigationwaterrequirementsofthelandscapeswereestimatedasafunctionof
evapotranspirationandirrigationefficiency. Thevaluesofevapotranspirationaretheaver-
ageoverthelandscape. Overall,themesiclandscapeshowedhigherevapotranspiration
values,followedbytheoasisandxericlandscapes,asshowninFigure7. Theevapotranspi-
rationrateswerehighestbetween11and12h,followedbyasteepdropintheafternoon
(13:00–15:00h). Thisdiurnaleffectwassimilarthroughoutthethreelandscapes. Theoasis
landscapeshowedlowerevapotranspirationrates(~0.3mm/h)thanthemesiclandscape.
Thexericlandscapeshowedoveralllowerevapotranspirationthroughouttheday,with,
on average, a 0.5 mm/h lower evapotranspiration rate than the mesic landscape and a
0.3mm/hlowerthantheoasislandscape.
Figure7. (a)Evapotranspirationratesofthelandscapes; (b)potentialirrigationwaterdepthsof
thelandscapes.
Thestudycomparedtheevapotranspirationofmesic,oasis,andxericlandscapeswith
tallfescuegrassandBermudagrasstounderstandthevariationsintheirrigationwater
compared to an entire turf landscape. The comparison of evapotranspiration with tall
fescueshoweda50%decreaseinevapotranspiration,whiletheoasisandxericlandscapes
showeda52and56%decreaseinevapotranspiration,respectively(Figure7a). Inasimilar
way,thecomparisonoflandscapeswithshortBermudagrassshowedadecreaseof43,46,
and53%inthemesic,oasis,andxericlandscapes,respectively.
Thepotentialirrigationwaterdepthswereestimatedasafunctionofevapotranspi-
rationandirrigationefficiency. Theirrigationdepthofthemesiclandscapewasslightly
higher than the oasis landscape (~0.1 mm/h), as presented in Figure 7b. However, the
xericlandscapeshowed0.5mm/hlowerirrigationwaterdepththanthexericandmesic
landscapes. Theirrigationwaterdepthoflandscapeswhencomparedtotallfescuewas
lower, with 50, 55, and 64% decreases in the mesic, oasis, and xeric landscapes, respec-
tively. Similarly,thecomparisonofirrigationwaterdepthbetweenshortBermudagrass
andlandscapesshowedarespectivereductionof43,49,and59forthemesic,oasis,and
xericlandscapes.

Hydrology2022,9,104 15of19
5. Discussion
ThisstudyhypothesizedthattheETandIWRwouldbelowerforxericlandscapes,
categorizedasalow-water-uselandscape. AsthedecreasedETinduceshigherdaytime
airtemperature, itwasassumedthathigherdaytimecoolingwouldbereportedbythe
mesiclandscape,havinghigherET.Theresultssupportthehypotheses. A5-yearstudy
bySovocool(2005)inLasVegas,NV,reportedsimilarfindings,with76%watersavingsin
single-familyhousesbecauseofthexericlandscapewhencomparedtothemesiclandscape.
AnotherhypothesiswasthattheETofturfgrasswouldbehigherthantreetranspira-
tion. BermudagrassandfescueETwere43%higherthanthemesiclandscape;therefore,
theresultsconfirmthehypothesis. Inaddition,theresultscorroboratedsufficientlywith
previousstudieswithsimilarhypotheses. Forinstance,astudyreportedthesummertime
ETofturfgrassatbetween2and6mm/day, whilethetreetranspirationremainedless
than1mm/day[21]. ThestudywasconductedintheLosAngelesmetropolitanarea,in
California,anaridregion,usingportablecuboidchambermeasurements(insituapproach).
Thefindingsreinforcethesmartwaterlandscape(WSL)programsapproach,focusedon
reducingpercapitademandbyremovingturfgrass. However,thelong-termwaterbenefits
ofreplacingtheturfgrasswithWSLandsyntheticturfgrassremainunclear. Inanother
study,twelve-yearmonthlywaterconsumptionrecordswereanalyzedfor300,000house-
holdsinLasVegas,Nevada,andestimatedtheaveragewatersavingpersquaremeterof
turfremoved[66]. Thestudyreportednoevidenceofwatersavingsperunitareabeing
influencedbytherebatevalue. Notenoughliteratureisavailabletocorroboratetheirri-
gationvaluesofthethreelandscapesinaridregions. Mostoftheliteraturequantifiesthe
irrigationwaterrequirementofindividualspecies[67,68]. However,onestudyestimated
theirrigationschedulesofxericandmesiclandscapesformonthlyuse. Bytheprocessof
deduction,thestudyfoundcomparablevaluesofirrigationformesic(4–6mm/day)and
xeric(2–3mm/day)landscapes[32].
Asignificantlimitationofthisstudywasarelativelycoarseapproachtowardsthe
irrigationsystem. Thestudyutilizedtheirrigationefficiencyvaluesfromtheliterature.
TheirrigationwaterrequirementisattributedtobothETandirrigationefficiency. One
studyhighlightsthat66%ofwatersavingsduetoxericlandscapeisattributedtoprecise
irrigationsystems[1]. Anotherlimitationistheconstantdiurnalwindregime[26]. The
ENVI-metconsidersaveragewindspeedanduseshourlyforcingtopreparedailyspatial
windprofiles. Futurestudiescanfocusonassessingmodeledandcalculatedwindspeed
accuracybyinstallingananemometerat2m. Inaddition,ENVI-metdoesnotallowfor
thecorrectdistributionofirrigationwaterrequirementsunlessthestomatalopeningatthe
daytimeissettozero,whichtranslatesintostressedplants. Thismaynotalwaysbetrue,
especiallyinclimateswithhighrelativehumiditycreatingmorebiases.
Regardlessofthelimitations,thisstudycanassistwatermanagersinunderstanding
the water requirements of mesic landscapes, compared to xeric and oasis landscapes.
In addition, the study highlights the implication of Water Smart Landscape programs
andissignificanttourbanclimatescientists. Ithighlightstheimportanceofchangesin
surfacetemperatureand airtemperature dueto mesic, xeric, andoasis landscapesand
their response to increased water requirements of plant species. In addition, the study
emphasizestheroleofbuildingsandtreesinloweringwindspeed.
6. Conclusions
This study simulated three typical landscapes in an arid region to understand the
microclimateconditionsandirrigationwaterrequirements. Thegoalwastodeterminea
microclimateandirrigationwater-efficientlandscape. Threelandscapes,includingmesic,
oasis,andxeric,werestudied. Themicroclimateeffectsweredeterminedbyanalyzingthe
spatialmapsanddiurnalplotsofsurfacetemperature,windspeed,andairtemperature.
ThelandscapesweremodeledusingtheNorthDesertVillageplantdatawithanENVI-met
tool. Previousstudieshavedeterminedthechangesinairandsurfacetemperatureinthe
landscapes;thisstudyisanextensionasitprovidedtheirrigationwaterrequirementsand

Hydrology2022,9,104 16of19
theintra-urbanmicroclimatechangesduetovegetation. Thetoolutilizesbuildingand
atmosphericphysicsalgorithmstodeterminetheplant–soil–atmosphereinteractions. The
landscapesweresimulatedfor24hforthehottestdayoftheyear,i.e.,23June2011,using
Phoenix,AZ’sclimatedata.
Eventhoughthestudyisspecifictothreelandscapes,thefindingscanbegeneralized
intoirrigationwaterresponsesoftreeturflandscapesandlowwaterusespecies. Thestudy
modeledforty-threespecies,includingtreesandshrubs. Inaddition,thestudyutilizeda
desertclimatefortheinitialboundaryconditions. Therefore,withafewexceptionssuchas
windspeedvariationsandrelativehumidity,thefindingsforirrigationwaterdepthscan
betranslatedforanaridclimatesuchasthoseinLasVegasandLosAngeles.
Findingssuggestoasislandscapesare5◦Cwarmeronaverage,concerningsurface
temperatures,thanmesiclandscapes. Thexericlandscapewas1◦Cwarmerthanthemesic
andoasislandscapesoverthehardscapes. Additionally,thevegetatedsurfacesforthexeric
landscapewere7◦Cwarmerthanthemesicandoasislandscapes.
Thefindingsregardingthewindspeeddifferencesareinconclusiveaswindspeedin-
herentlydependsonarangeoffactors. Sincethisstudyutilizedactuallandscapes,various
factorswerebeyondcontrol,includingtheorientationofthebuildingsandthetrees’geom-
etryinthelandscape(treeheightandbuildingheight). Therefore,findingssuchasthose
formesiclandscapes,withtalltrees(height-5–10m),demonstratinglowerwindspeeds,
especiallybetweenbuildingsandtrees,remaininherentlyflawed. Futurestudiescanfocus
ondevisinganexperimentusinginputsfromthestudyinahypotheticalneighborhood
withconstantgeometricalparameterstounderstandthewindspeedvariations.
Overall,themesiclandscapeinducedacoolingeffect. However,thesurfacesbetween
buildingswere2◦Cwarmerthanthesurroundingareaatnoon,indicatingheat-trapping.
On the other hand, the oasis landscape showed a 2 ◦C lower air temperature than the
mesiclandscapeatthepeakdaytime. However,theoasislandscapeshowedanighttimeair
temperaturesimilartothatofthexericlandscape.
Thepotentialevapotranspirationofthemesiclandscapewashighest,followedbythe
oasisandxericlandscapes. Theoasislandscapeshows,onaverage,a0.1mm/hreduction
inthedepthofirrigation. Thexericlandscapereportsthelowestdepthforirrigation.
Toconclude,theoasislandscapecontributestomaximumdaytimecoolingalongwith
lowerirrigationwaterrequirementswhencomparedtothemesiclandscape. Thexeric
landscapesavesirrigationwater;however,itdoesnotpromiseoutdoorthermalcomfort,
includingreducedairtemperatureordenseshading.
AuthorContributions: R.S.wasinvolvedintheconceptualization,formalanalysis,methodology,
visualization,writing-theoriginaldraft.A.M.providestheresources,supervision,andmethodsofthe
study.H.S.andS.A.participatedintheconceptualization,methodology,resources,andmanagement
ofthestudy.Allauthorshavereadandagreedtothepublishedversionofthemanuscript.
Funding: ThisresearchwasfundedbytheUniversityofNevada,LasVegas,undertheTopTier
DoctoralGraduateResearchAssistantship(TTDGRA)program.R.S.’scontributionwasalsopartly
supportedbytheMakipostdoctoralfellowshipattheDesertResearchInstitute.
DataAvailabilityStatement:Partofthedatausedisfrom[27].TheMesic,Oasis,andXericlandscape
databaseisavailableatthegivenrepository:http://doi.org/10.5281/zenodo.5015501.Thesoftware
usedfortheanalysiswasENVI-metversion4.4.1andhadrestrictedaccess.
Acknowledgments: The authors are grateful to Dale Devitt, at the Department of Life Sciences,
UniversityofNevada,LasVegas,forhisrigorousreviewsandmeaningfulcomments.
ConflictsofInterest:Theauthorsdeclarenoconflictofinterest.

Hydrology2022,9,104 17of19
References
1. Hilaire,R.S.;Arnold,M.A.;Wilkerson,D.C.;Devitt,D.A.;Hurd,B.H.;Lesikar,B.J.;Lohr,V.I.;Martin,C.A.;McDonald,G.V.;
Morris,R.L.;etal.Efficientwateruseinresidentialurbanlandscapes.HortScience2008,43,2081–2092.[CrossRef]
2. Brelsford,C.;Abbott,J.K.HowSmartAre‘WaterSmartLandscapes’?2018,pp.1–45.Availableonline:http://arxiv.org/abs/18
03.04593(accessedon13March2018).
3. Pincetl,S.;Gillespie,T.W.;Pataki,D.E.;Porse,E.;Jia,S.;Kidera,E.;Nobles,N.;Rodriguez,J.;Choi,D.A.Evaluatingtheeffectsof
turf-replacementprogramsinLosAngeles.Landsc.UrbanPlan.2019,185,210–221.[CrossRef]
4. Sovocool,K.A.XeriscapeConversionStudyFinalReportbyArea.2005,p.93.Availableonline:http://www.allianceforwaterefficiency.
org/Xeriscape_Water_Savings.aspx(accessedon10April2020).
5. Fisher,J.B.;Whittaker,R.J.;Malhi,Y.ETcomehome:Potentialevapotranspirationingeographicalecology.Glob.Ecol.Biogeogr.
2011,20,1–18.[CrossRef]
6. OKE,T.R.Theenergeticbasisoftheurbanheatisland.Q.J.R.Meteorol.Soc.1987,16,121–129.[CrossRef]
7. Saher,R.;Ahmad,S.;Stephen,H.AnalysisofchangesinsurfaceenergyfluxesduetourbanizationinLasVegas.InProceedingsof
theWorldEnvironmentalandWaterResourcesCongress2019:Groundwater,Sustainability,Hydro-Climate/ClimateChange,and
EnvironmentalEngineering,Pittsburgh,PA,USA,19–23May2019;AmericanSocietyofCivilEngineers:Reston,VA,USA,2019.
[CrossRef]
8. Wood,L.;Hooper,P.;Foster,S.;Bull,F.Publicgreenspacesandpositivementalhealth—Investigatingtherelationshipbetween
access,quantityandtypesofparksandmentalwellbeing.HealthPlace2017,48,63–71.[CrossRef][PubMed]
9. Saher,R.;Stephen,H.;Ahmad,S.Urbanevapotranspirationofgreenspacesinaridregionsthroughtwoestablishedapproaches:
Areviewofkeydrivers,advancements,limitations,andpotentialopportunities.UrbanWaterJ.2020,18,1–13.[CrossRef]
10. Smeal,D.;O’Neill,M.;Lombard,K.;Arnold,R.CropCoefficientsforDrip-IrrigatedXeriscapesandUrbanVegetableGardens;NMSU
AgriculturalScienceCenter:LosLunas,NM,USA,2009;pp.1–12.
11. Kjelgren,R.;Rupp,L.;Kilgren,D.Waterconservationinurbanlandscapes.HortScience2000,35,1037–1040.[CrossRef]
12. Chow,W.T.;Brazel,A.J.Assessingxeriscapingasasustainableheatislandmitigationapproachforadesertcity.Build.Environ.
2012,47,170–181.[CrossRef]
13. Middel,A.;Chhetri,N.;Quay,R.Urbanforestryandcoolroofs:AssessmentofheatmitigationstrategiesinPhoenixresidential
neighborhoods.UrbanFor.UrbanGreen.2015,14,178–186.[CrossRef]
14. Mitchell,D.AssessmentoftheViabilityofXeriscapingtoReduceWaterConsumptioninSacramento.Unpublishedwork.2014.
15. Overview,W.V.Offsettingwaterconservationcoststoachievenet-zerowateruse. J.Am. WaterWork. Assoc. 2013,105,62–72.
[CrossRef]
16. Saher,R.KaleidoscopeofUrbanEvapotranspiration:ExploringtheScienceandModelingApproaches.DoctoralDissertation,
UniversityofNevada,LasVegas,NV,USA,2021.
17. Nouri,H.;Beecham,S.;Kazemi,F.;Hassanli,A.M.AreviewofETmeasurementtechniquesforestimatingthewaterrequirements
ofurbanlandscapevegetation.UrbanWaterJ.2013,10,247–259.[CrossRef]
18. Saher,R.;Stephen,H.;Ahmad,S.UrbanClimate“UrbanClimateEffectoflandusechangeonsummertimesurfacetemperature,
albedo,andevapotranspirationinLasVegasValley”.UrbanClim.2021,39,100966.[CrossRef]
19. Saher,R.;Stephen,H.;Ahmad,S.UrbanClimateUnderstandingthesummertimewarmingincanyonandnon-canyonsurfaces.
UrbanClim.2021,38,100916.[CrossRef]
20. Litvak,E.;Manago,K.F.;Hogue,T.S.;Pataki,D.E.EvapotranspirationofurbanlandscapesinLosAngeles,Californiaatthe
municipalscale.WaterResour.Res.2017,53,4236–4252.[CrossRef]
21. Litvak, E.; Bijoor, N.S.; Pataki, D.E.Addingtreestoirrigatedturfgrasslawnsmaybeawater-savingmeasureinsemi-arid
environments.Ecohydrology2014,7,1314–1330.[CrossRef]
22. Litvak,E.;Pataki,D.E.Evapotranspirationofurbanlawnsinasemi-aridenvironment:Aninsituevaluationofmicroclimatic
conditionsandwateringrecommendations.J.AridEnviron.2016,134,87–96.[CrossRef]
23. Kusaka,H.;Kimura,F.CouplingaSingle-LayerUrbanCanopyModelwithaSimpleAtmosphericModel:ImpactonUrbanHeat
IslandSimulationforanIdealizedCase.J.Meteorol.Soc.Japan2004,82,67–80.[CrossRef]
24. Chen,F.;Kusaka,H.;Bornstein,R.;Ching,J.;Grimmond,C.S.B.;Grossman-Clarke,S.;Loridan,T.;Manning,K.W.;Martilli,A.;
Miao,S.;etal.TheintegratedWRF/urbanmodellingsystem:Development,evaluation,andapplicationstourbanenvironmental
problems.Int.J.Climatol.2011,31,273–288.[CrossRef]
25. Vahmani,P.;Hogue,T.S.IncorporatinganUrbanIrrigationModuleintotheNoahLandSurfaceModelCoupledwithanUrban
CanopyModel.J.Hydrometeorol.2014,15,1440–1456.[CrossRef]
26. Crank,P.J.;Middel,A.;Wagner,M.;Hoots,D.;Smith,M.;Brazel,A.Validationofseasonalmeanradianttemperaturesimulations
inhotaridurbanclimates.Sci.TotalEnviron.2020,749,141392.[CrossRef]
27. Middel,A.;Häb,K.;Brazel,A.J.;Martin,C.A.;Guhathakurta,S.Impactofurbanformanddesignonmid-afternoonmicroclimate
inPhoenixLocalClimateZones.Landsc.UrbanPlan.2014,122,16–28.[CrossRef]
28. Vahmani,P.;Sun,F.;Hall,A.;Ban-Weiss,G.Investigatingtheclimateimpactsofurbanizationandthepotentialforcoolroofsto
counterfutureclimatechangeinSouthernCalifornia.Environ.Res.Lett.2016,11,124027.[CrossRef]
29. Crank,P.J.;Sailor,D.J.;Ban-Weiss,G.;Taleghani,M.EvaluatingtheENVI-metmicro-scalemodelforsuitabilityinanalysisof
targetedurbanheatmitigationstrategies.UrbanClim.2018,26,188–197.[CrossRef]

Hydrology2022,9,104 18of19
30. Kjelgren,R.;Beeson,R.C.;Pittenger,D.P.;Montague,T.Simplifiedlandscapeirrigationdemandestimation:Sliderules.Appl.Eng.
Agric.2016,32,363–378.[CrossRef]
31. Hoedjes, J.C.B.; Chehbouni, A.; Jacob, F.; Ezzahar, J.; Boulet, G. Deriving daily evapotranspiration from remotely sensed
instantaneousevaporativefractionoveroliveorchardinsemi-aridMorocco.J.Hydrol.2008,354,53–64.[CrossRef]
32. Volo,T.J.;Vivoni,E.R.;Ruddell,B.L.Anecohydrologicalapproachtoconservingurbanwaterthroughoptimizedlandscape
irrigationschedules.Landsc.UrbanPlan.2015,133,127–132.[CrossRef]
33. Litvak,E.;McCarthy,H.R.;Pataki,D.E.Transpirationsensitivityofurbantreesinasemi-aridclimateisconstrainedbyxylem
vulnerabilitytocavitation.TreePhysiol.2012,32,373–388.[CrossRef]
34. Litvak,E.;McCarthy,H.R.;Pataki,D.E.AmethodforestimatingtranspirationofirrigatedurbantreesinCalifornia.Landsc.Urban
Plan.2017,158,48–61.[CrossRef]
35. Nouri,H.Evapotranspirationestimationinheterogeneousurbanvegetation.DoctoralDissertation,UniversityofSouthAustralia,
Adelaide,Australia,2014.
36. Ambrosini,D.;Galli,G.;Mancini,B.;Nardi,I.;Sfarra,S.Evaluatingmitigationeffectsofurbanheatislandsinahistoricalsmall
centerwiththeENVI-Met®climatemodel.Sustainability2014,6,7013–7029.[CrossRef]
37. Sarijeva,G.;Knapp,M.;Lichtenthaler,H.K.Differencesinphotosyntheticactivity,chlorophyllandcarotenoidlevels,andin
chlorophyllfluorescenceparametersingreensunandshadeleavesofGinkgoandFagus. J.PlantPhysiol. 2007,164,950–955.
[CrossRef]
38. Stewart,I.D.;Oke,T.R.Localclimatezonesforurbantemperaturestudies.Bull.Am.Meteorol.Soc.2012,93,1879–1900.[CrossRef]
39. Ozkeresteci,I.;Crewe,K.;Brazel,A.J.;Bruse,M.UseandevaluationoftheENVI-METmodelforenviromentaldesignand
planning:Anexperimentonlinearparks.InProceedingsofthe21stInternationalCartographicConference(ICC),Durban,South
Africa,10–16August2003;pp.10–16.
40. Zhao,Q.;Sailor,D.J.;Wentz,E.A.Impactoftreelocationsandarrangementsonoutdoormicroclimatesandhumanthermal
comfortinanurbanresidentialenvironment.UrbanFor.UrbanGreen.2018,32,81–91.[CrossRef]
41. Taleghani,M.;Kleerekoper,L.;Tenpierik,M.;VanDenDobbelsteen,A.Outdoorthermalcomfortwithinfivedifferenturban
formsintheNetherlands.Build.Environ.2015,83,65–78.[CrossRef]
42. Bruse,M.ENVI-met3.0:UpdatedModelOverview.System2004,1–12.
43. Berardi,U.;Jandaghian,Z.;Graham,J.ScienceoftheTotalEnvironmentEffectsofgreeneryenhancementsfortheresilience
toheatwaves:Acomparisonofanalysisperformedthroughmesoscale(WRF)andmicroscale(Envi-me)modeling.Sci.Total
Environ.2020,747,141300.[CrossRef]
44. Toparlar,Y.;Blocken,B.;Maiheu,B.;VanHeijst,G.J.F.AreviewontheCFDanalysisofurbanmicroclimate.Renew.Sustain.Energy
Rev.2017,80,1613–1640.[CrossRef]
45. Simon,H.;Lindén,J.;Hoffmann,D.;Braun,P.;Bruse,M.;Esper,J.Modelingtranspirationandleaftemperatureofurbantrees—A
casestudyevaluatingthemicroclimatemodelENVI-metagainstmeasurementdata. Landsc. UrbanPlan. 2018, 174, 33–40.
[CrossRef]
46. Gibelin,A.L.;Calvet,J.C.;Roujean,J.L.;Jarlan,L.;Los,S.O.AbilityofthelandsurfacemodelISBA-A-gstosimulateleafarea
indexattheglobalscale:Comparisonwithsatellitesproducts.J.Geophys.Res.Atmos.2006,111,1–16.[CrossRef]
47. Liu, Z.; Zheng, S.; Zhao, L. Evaluation of the ENVI-Met Vegetation Model of Four Common Tree Species in a Subtropical
Hot-HumidArea.Atmosphere2018,9,198.[CrossRef]
48. Asef,S.M.;Tolba,O.;Fahmy,A.Theeffectofleafareaindexandleafareadensityonurbanmicroclimate.J.Eng.Appl.Sci.2020,
67,427–446.
49. Simon,H.ModelingUrbanMicroclimate:Development,ImplementationandEvaluationofNewandImprovedCalculationMethodsforthe
UrbanMicroclimateModelENVI-Met;UniversitätsbibliothekMainz:Mainz,Germany,2016.
50. Lindén,J.;Simon,H.;Fonti,P.;Esper,J.;Bruse,M.ObservedandModeledtranspirationcoolingfromurbantreesinMainz,
Germany. InProceedingsoftheICUC9-9thInternationalConferenceonUrbanClimateJointlywith12thSymposiumonthe
UrbanEnvironment,Toulouse,France,20–24July2015;pp.20–24.
51. Huttner,S.FurtherDevelopmentandApplicationofthe3DMicroclimateSimulationENVI-met.DoctoralDissertation,Johannes
Gutenberg-UniversitatinMainz,Mainz,Germany,2012;p.147.Availableonline:http://ubm.opus.hbz-nrw.de/volltexte/2012
/3112/(accessedon11October2021).
52. Mohsen,H.;Raslan,R.M.;El-Bastawissi,I.OptimisingtheUrbanEnvironmentthroughHolisticMicroclimateModelling:TheCaseof
Beirut’sPeri-CenterFacultyofArchitecturalEngineering;BeirutArabUniversity,LebanonUCLInstituteforEnvironmentalDesign
andEngineering(IEDE),TheBar:Beirut,Lebanon,2015.
53. Lalic,B.;Mihailovic,D.T.Anempiricalrelationdescribingleaf-areadensityinsidetheforestforenvironmentalmodeling.J.Appl.
Meteorol.2004,43,641–645.[CrossRef]
54. SoilSurveysbyStateNRCSSoils.Availableonline:https://www.nrcs.usda.gov/wps/portal/nrcs/surveylist/soils/survey/
state/?stateId=AZ(accessedon19February2022).
55. Singer,C.K.;Martin,C.A.EffectofLandscapeMulchesandDripIrrigationonTransplantEstablishmentandGrowthofThree
NorthAmericanDesertNativePlants.J.Environ.Hortic.2009,27,166–170.[CrossRef]
56. Willmott,C.J.Onthevalidationofmodels.Phys.Geogr.1981,2,184–194.[CrossRef]

Hydrology2022,9,104 19of19
57. Battista,G.;Carnielo,E.;Vollaro,R.D.L.Thermalimpactofaredevelopedareaonlocalizedurbanmicroclimate:Acasestudyin
Rome.EnergyBuild.2016,133,446–454.[CrossRef]
58. Lin,B.S.;Lin,C.T.Preliminarystudyoftheinfluenceofthespatialarrangementofurbanparksonlocaltemperaturereduction.
UrbanFor.UrbanGreen.2016,20,348–357.[CrossRef]
59. Zhang,Y.;Murray,A.T.;TurnerIi,B.L.LandscapeandUrbanPlanningOptimizinggreenspacelocationstoreducedaytimeand
nighttimeurbanheatislandeffectsinPhoenix,Arizona.Landsc.UrbanPlan.2017,165,162–171.[CrossRef]
60. Shashua-Bar,L.;Hoffman,M.E.Geometryandorientationaspectsinpassivecoolingofcanyonstreetswithtrees.EnergyBuild.
2003,35,61–68.[CrossRef]
61. Shashua-Bar,L.;Pearlmutter,D.;Erell,E.Theinfluenceoftreesandgrassonoutdoorthermalcomfortinahot-aridenvironment.
Int.J.Climatol.2011,31,1498–1506.[CrossRef]
62. Jensen,R.R.;Hardin,P.J.;Bekker,M.;Farnes,D.S.;Lulla,V.;Hardin,A.ModelingurbanleafareaindexwithAISA+hyperspectral
data.Appl.Geogr.2009,29,320–332.[CrossRef]
63. Fisher,J.B.;Baldocchi,D.D.;Misson,L.;Dawson,T.E.;Goldstein,A.H.Whatthetowersdon’tseeatnight:Nocturnalsapflowin
treesandshrubsattwoAmeriFluxsitesinCalifornia.TreePhysiol.2007,27,597–610.[CrossRef]
64. Chatzidimitriou,A.;Yannas,S.Microclimatedesignforopenspaces:Rankingurbandesigneffectsonpedestrianthermalcomfort
insummer.Sustain.CitiesSoc.2016,26,27–47.[CrossRef]
65. Pataki,D.E.;McCarthy,H.R.;Litvak,E.;Pincetl,S.TranspirationofurbanforestsintheLosAngelesmetropolitanarea.Ecol.Appl.
2011,21,661–677.[CrossRef]
66. Brelsford,C.;Abbott,J.K.GrowingintoWaterConservation?DecomposingtheDriversofReducedWaterConsumptioninLas
Vegas,NV.Ecol.Econ.2017,133,99–110.[CrossRef]
67. Volo,T.J.;Vivoni,E.R.;Martin,C.A.;Earl,S.;Ruddell,B.L.Modellingsoilmoisture,waterpartitioning,andplantwaterstress
underirrigatedconditionsindesertUrbanareas.Ecohydrology2014,7,1297–1313.[CrossRef]
68. Kim,J.;Hogue,T.S.EvaluationofaMODIStriangle-basedevapotranspirationalgorithmforsemi-aridregions.J.Appl.Remote
Sens.2013,7,073493.[CrossRef]
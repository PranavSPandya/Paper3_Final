Shaded Route Planning Using Active Segmentation and
Identification of Satellite Images
LongchaoDa RohanChhibba RushabhJaiswal
ArizonaStateUniversity ArizonaStateUniversity ArizonaStateUniversity
longchao@asu.edu rchhibba@asu.edu rjaisw15@asu.edu
Tempe,AZ,USA Tempe,AZ,USA Tempe,AZ,USA
ArianeMiddel HuaWei∗
ArizonaStateUniversity ArizonaStateUniversity
ariane.middel@asu.edu hua.wei@asu.edu
Tempe,AZ,USA Tempe,AZ,USA
ABSTRACT 1 INTRODUCTION
Heatwavesposesignificanthealthrisks,particularlyduetopro- Theimpactofglobalwarmingisincreasinglyevidentworldwide.In
longedexposuretohighsummertemperatures.Vulnerablegroups, someregions,thenumberofdeathsrelatedtohightemperaturesis
especiallypedestriansandcyclistsonsun-exposedsidewalks,moti- alarming.Astudyby[17]reportsthat,from2000to2019,anaverage
vatethedevelopmentofarouteplanningmethodthatincorporates of178,700deathsannuallywereattributedtohightemperatures,
somatosensorytemperatureeffectsthroughshaderatioconsider- withthenumbercontinuingtoriseyearly.Theescalatingsever-
ation.Thispaperisthefirsttointroduceapipelinethatutilizes ityandfrequencyofheatwaves,exacerbatedbyclimatechange,
segmentationfoundationmodelstoextractshadedareasfromhigh- representasignificantpublichealththreat.Amoreaccessible,com-
resolutionsatelliteimages.Theseareasarethenintegratedintoa fortable,andsaferouteplanningmethodalignsasakeypriority
multi-layeredroadmap,enablinguserstocustomizeroutesbased withboththeEuropeanUnion’sGreenDeal[6]andtheUnited
onabalancebetweendistanceandshadeexposure,therebyen- NationsSustainableDevelopmentGoals[3].
hancingcomfortandhealthduringoutdooractivities.Specifically, Therearesomeliteraturethatconductedpreliminaryresearchon
weconstructagraph-basedrepresentationoftheroadmap,where thepossibilityofplanningundershadedareas.Suchas[5]proposes
linksindicateconnectivityandareupdatedwithshaderatiodata touseBOTworldtofindandvisualizeoptimalthermalcomfort
fordynamicrouteplanning.Thissystemisalreadyimplemented pathsinsquares,parks,andsmallneighborhoods,suchanagent-
online,withavideodemonstration,andwillbespecificallyadapted basedmodelactswithENVImetmicroclimate[13]simulations.[20]
toassisttravelersduringthe2024OlympicGamesinParis. investigatedthermalwalksintwoEuropeanpedestrianroutesusing
questionnairesandfieldmeasurementstoimprovemodelsofdy-
CCSCONCEPTS namicthermalcomfortperception.Inthestudyof[19],researchers
proposeanovelwaytodetectoptimalpedestrianshadedpaths
•Informationsystems→Informationsystemsapplications;
usingUMEP[11]inQGIS[18],however,thissolutionrelieson
•Computingmethodologies→Computervision;Artificialintel-
accurateterrainmaps,andreal-timebuildingheightsarenotwell-
ligence.
considered.Besides,[15],proposesamethodtoconductshaded
navigationusingacross-sourceofOpenStreetMap[2]andLiDAR
KEYWORDS
pointclouddatathatresolvesbothtreetopcanopyandbareground
TrafficSystems,RoutePlanning,FoundationModels elevationproblems,however,thisreliesonwell-collectedLiDAR
data[12]andishardtoapplydirectlytoarbitrarycities.
ACMReferenceFormat:
Inthispaper,weformallypresentShadeRouter,anovelshaded
LongchaoDa,RohanChhibba,RushabhJaiswal,ArianeMiddel,andHua
Wei∗.2018.ShadedRoutePlanningUsingActiveSegmentationandIdenti- routeplanningmethod,andprovideademotoshowcaseitsreal-
timeplanningability.Thispapercontributesinthefollowingas-
ficationofSatelliteImages.InProceedingsofMakesuretoenterthecorrect
conferencetitlefromyourrightsconfirmationemai(Conferenceacronym’XX). pects:First,thispaperintroducesacompletepipelineleveraging
ACM,NewYork,NY,USA,5pages.https://doi.org/XXXXXXX.XXXXXXX theadvancedfoundationmodeltoextractshadedinformationfrom
satelliteimages,whichcanbedirectlyappliedtoanycitywithavail-
ablesatelliteinformation.Second,thepaperproposesashadedra-
Permissiontomakedigitalorhardcopiesofallorpartofthisworkforpersonalor tiocalculationalgorithm,whichtakesthesatelliteimageandOpen-
classroomuseisgrantedwithoutfeeprovidedthatcopiesarenotmadeordistributed
StreetMapasinput,andderivesthepercentageofshade-covered
forprofitorcommercialadvantageandthatcopiesbearthisnoticeandthefullcitation
onthefirstpage.Copyrightsforcomponentsofthisworkownedbyothersthanthe lengthtothewholeroutelength.Suchshadedratioswillbeadopted
author(s)mustbehonored.Abstractingwithcreditispermitted.Tocopyotherwise,or tocreateaninformationgraphthatwillbejointlyconsideredwitha
republish,topostonserversortoredistributetolists,requirespriorspecificpermission
and/orafee.Requestpermissionsfrompermissions@acm.org. distancegraphwhenprovidingroutingplans.Third,weprovidean
Conferenceacronym’XX,June03–05,2024,NY onlinedemoforrouteplanningemployingavariantoftheDijkstra
©2018Copyrightheldbytheowner/author(s).PublicationrightslicensedtoACM. algorithmandreleasethesource-code,dataset,andcorresponding
ACMISBN978-1-4503-XXXX-X/18/06
derivedshadedratiosforotherresearchers’convenience.
https://doi.org/XXXXXXX.XXXXXXX
4202
luJ
81
]YC.sc[
1v98631.7042:viXra

| Conferenceacronym’XX,June03–05,2024,NY |     |     |     |     |     | Trovatoetal. |     |
| -------------------------------------- | --- | --- | --- | --- | --- | ------------ | --- |
Shade Ratio Derivation
|     |     |     |     |     | (      | )   |     |
| --- | --- | --- | --- | --- | ------ | --- | --- |
,
Foundation Model
|     |     |     | HSV Color Model  |     | OSM Data |     |     |
| --- | --- | --- | ---------------- | --- | -------- | --- | --- |
Segmentation
Masking
Satellite Shot
|                                     |     |     |     | Shade-Sidewalk Mapping |     | Shade Ratio |     |
| ----------------------------------- | --- | --- | --- | ---------------------- | --- | ----------- | --- |
| Multi-layer Road Graph Construction |     |     |     | Route Planning         |     |             |     |
Shortest
Shade Ratio Map
Most Shaded
| Query  |     |     |     | +   |     |     |     |
| ------ | --- | --- | --- | --- | --- | --- | --- |
Dijkstra
(O, D, Type)
Geographic Maps
|     |     |     | Type: POI/Distance |     |     |     |     |
| --- | --- | --- | ------------------ | --- | --- | --- | --- |
Type:
Figure1:Theoverviewoftheproposedpipelineforourshadedrouteplanningmethod.Theupperpartshowstheshaded
ratioderivationprocessthattakesthesatelliteimageandOSMdataasinput,andcalculatestheshadedratioforspecificvalid
walkableorbikeablelanes.Andthelowerpartshowsthemulti-layerroadgraphconstructionandrouteplanningprocess,this
revealshowShadeRouterprovidesuserpreferenceshadedrouteplanningfromderivedshadowinformation.
2 APPROACH i.e.,thepercentageofeachroadcoveredbyshade,facilitatingthe
identificationofwalkableshadedlanes.
Inthissection,wewillintroducetheproposedplanningmethod
ShadeRouter.Thedetailedpipelineincludesthreecomponents: TheFig.2showsanotherexampleofshadedratiocalculationina
ShadeRatioDerivation,Multi-layerRoadGraphConstruction,and walkablenetwork,inthisyellowcolormaskedsatelliteimage(such
maskimpliestheshadedarea),theredlineisavalidpedestrian
RoutePlanningInterface.Previousstudieshaveattemptedtouti-
routeextractedfromtheOSMfiles[14],asshownintheimage,
lizeLiDARdata[1,10,21]tosimulateshadeandenhanceroute
|     |     |     | the total pixel | 𝐿 = 400, | by image processing, | we calculate | the |
| --- | --- | --- | --------------- | -------- | -------------------- | ------------ | --- |
planning[4,19].However,thesemethodsoftenstrugglewithlo-
calizationissuesanddatasparsityforplaceswithoutLiDARdata, overlapbetweenvalidpedestrianrouteandtheactualshadedarea
is𝑆 67%×𝐿.inoursetting,eachimageisdownloadedwitha
limitingtheirapplicabilitytocertainregions.Ourapproachlever- =
zoomed-inlevelas20,resultintherangeof49.84mx49.84m.Given
ageswidelyavailablesatelliteimagerytoderiveshadeinformation
thisinformation,wecouldcalculatetheshadedratiofortheabove
globally.Thisdatasourceprovidesdetailedenvironmentalfeatures,
exampleinFig.2whichis49.84×67%≈33.39m.
suchasvegetationandbuildings,ensuringourshade-basednaviga-
tionplanningisbothversatileandreliable. Anotherchallengeintheshaderatioderivationis,thedatasetof
aplacecontainsmultipleimages,andthesameroutemayappear
multipletimesindifferentimages.Inordertodealwiththis,we
2.1 ShadeRatioDerivation taketheroadnameasthekey(K),assumewealreadyhavepartially
|                    |                   |                       | detectedshadedlengthas𝐿 |     | 𝑆ℎ𝑎𝑑𝑒𝑑,accumulatedlengthas𝐿 |     | 𝐴𝑐𝑐,and |
| ------------------ | ----------------- | --------------------- | ----------------------- | --- | --------------------------- | --- | ------- |
| This step utilizes | satellite imagery | to derive information | about                   |     |                             |     |         |
nowweconductqueryQ(𝑖𝑚𝑔
shadedareasonmaps,asillustratedinthefirstmoduleofFig.1. 𝑖,K)ineachun-visiteddatasetimage,
ifQ(𝑖𝑚𝑔 𝑖,K)=True,indicatingapositivequery,the𝐿
Theprocessbeginswiththesegmentationofrawsatelliteimages 𝑆ℎ𝑎𝑑𝑒𝑑 =
|     |     |     |     | 𝐾   | 𝐾   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
usingthefoundationmodel,SegmentAnything[7–9],whichem- 𝐿 𝑆ℎ𝑎𝑑𝑒𝑑 +𝐿 ,and𝐿 𝐴𝑐𝑐 =𝐿 𝐴𝑐𝑐 +𝐿 .Thefinalshadedratio
|                                                          |     |     |           | 𝑆 ℎ𝑎𝑑𝑒𝑑   | 𝐴 𝑐𝑐                                      |     |     |
| -------------------------------------------------------- | --- | --- | --------- | --------- | ----------------------------------------- | --- | --- |
|                                                          |     |     | forroute𝐾 | is𝑟(𝐾) 𝐿𝑆 | ℎ 𝑎 𝑑 𝑒𝑑.Ifwetraverseallinterestedroutes, |     |     |
| ployscontrastivelearningtoidentifyanddelineateeachobject |     |     |           | = 𝐿       |                                           |     |     |
|                                                          |     |     |           |           | 𝐴 𝑐 𝑐                                     |     |     |
withintheimage.Oncesegmented,theimagecomponentsareana- wecouldderiveapre-processedshadedratiomap.
lyzedforcolorhueandbrightnesstodetermineshadedareas.This
isachievedthroughchromaticsanalysis,whichidentifiesdarker
2.2 Multi-layerRoadGraphConstruction
areasasshaded.Inourempiricalstudy,thebestthresholdvalue
forselectingRGBmasksis75(maskkeepsiffRGB(mask)>=75). Followingthederivationofshaderatiodata,weemploythisdatain
Subsequently,theseshadedareasarealignedwithroaddatafrom theconstructionofaShadedRatioMap,aspartofourMulti-layer
OpenStreetMap[2].Byoverlayingtheshademapontovalidpath RoadGraphConstructionshowninFig.1.Thisconstructioncom-
coordinates,asshowninFig.1,wecandeterminetheshaderatio, prisestwoprimarylayers:theupperlayerrepresentstheshade

ShadedRoutePlanningUsingActiveSegmentationandIdentificationofSatelliteImages Conferenceacronym’XX,June03–05,2024,NY
Algorithm1ShadeRouterPlanning
|     |     |     |     |     | Require: | Graph𝐺 =(𝑉,𝐸),originvertex𝑣 |     | 𝑜,destinationvertex𝑣 | 𝑑,  |
| --- | --- | --- | --- | --- | -------- | --------------------------- | --- | -------------------- | --- |
shadedratios𝑟(𝑢,𝑣)foreachedge(𝑢,𝑣),preferenceparameter
|            |     | S= 67% |     |     | 𝛼 ∈ [0,1]      |           |     |     |     |
| ---------- | --- | ------ | --- | --- | -------------- | --------- | --- | --- | --- |
| slexip 004 |     |        |     |     | Initialize𝑑[𝑣] | ←∞forall𝑣 | ∈𝑉  |     |     |
| L          |     | L      |     |     | 1:             |           |     |     |     |
𝑑[𝑣
|     |     |     |     |     | 2: 𝑜]                       | ←0    |     |     |     |
| --- | --- | --- | --- | --- | --------------------------- | ----- | --- | --- | --- |
|     |     |     |     |     | 3: Initializepriorityqueue𝑄 |       |     |     |     |
|     |     |     |     |     | forallvertex𝑣               | ∈𝑉 do |     |     |     |
4:
Insert𝑣into𝑄withpriority𝑑[𝑣]
5:
|     |            |     |            |     | 6: endfor             |              |     |     |     |
| --- | ---------- | --- | ---------- | --- | --------------------- | ------------ | --- | --- | --- |
|     |            |     |            |     | Initialize𝑝𝑟𝑒𝑣[𝑣]     | ←nullforall𝑣 |     | ∈𝑉  |     |
|     | 400 pixels |     | 400 pixels |     | 7:                    |              |     |     |     |
|     |            |     |            |     | 8: while𝑄isnotemptydo |              |     |     |     |
Figure 2: The shaded ratio calculation, the yellow blocks 𝑢 ←Extractvertexwithminimumdistancefrom𝑄
9:
showtheshadedareas,andtheredlineshowsvalidroutes forallneighbor𝑣of𝑢do
10:
| fromOSMdata. |     |     |     |     |     | 𝑤 (𝑢,𝑣)←(1−𝛼)·𝑤(𝑢,𝑣)+𝛼·𝑟(𝑢,𝑣) |           |     |     |
| ------------ | --- | --- | --- | --- | --- | ----------------------------- | --------- | --- | --- |
|              |     |     |     |     | 11: | joint                         |           |     |     |
|              |     |     |     |     |     | if𝑑[𝑢]+𝑤 (𝑢,𝑣)                | <𝑑[𝑣]then |     |     |
|              |     |     |     |     | 12: | joint                         |           |     |     |
|              |     |     |     |     | 13: | 𝑑[𝑣] ←𝑑[𝑢]+𝑤                  | (𝑢,𝑣)     |     |     |
joint
𝑝𝑟𝑒𝑣[𝑣] ←𝑢
| ratiosderivedfromourearlierprocess,andthelowerlayerrepre- |     |     |     |     | 14: |     |     |     |     |
| --------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Decreasepriorityof𝑣in𝑄to𝑑[𝑣]
| sentsgeographicmaps,denotedasG𝑇𝑦𝑝𝑒 |     |     | (where𝑇𝑦𝑝𝑒 |     | 15: |     |     |     |     |
| ---------------------------------- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- |
iseither
|     |     |     |     |     | 16: | endif |     |     |     |
| --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- |
walkorbike),sourcedfromOpenStreetMap(OSM)data.Itisimpor-
|                                          |     |     |                     |     | 17: endfor         |      |     |     |     |
| ---------------------------------------- | --- | --- | ------------------- | --- | ------------------ | ---- | --- | --- | --- |
| tanttonotethattheconnectivityinG𝑤𝑎𝑙𝑘     |     |     | andG𝑏𝑖𝑘𝑒 maydiffer. |     |                    |      |     |     |     |
|                                          |     |     |                     |     | 18: endwhile       |      |     |     |     |
| Theshadedratiolayeractsasauniversalset,G |     |     | U,encompassing      |     |                    |      |     |     |     |
|                                          |     |     |                     |     | 19: Constructpath𝑃 | ← [] |     |     |     |
allpossiblelinks.Whilemappingtheshadedratiomaptothege-
𝑢 ←𝑣
| ographical | maps, if the connectivity | does | not exist, then | it will | 20:          | 𝑑       |     |     |     |
| ---------- | ------------------------- | ---- | --------------- | ------- | ------------ | ------- | --- | --- | --- |
|            |                           |      |                 |         | while𝑝𝑟𝑒𝑣[𝑢] | ≠nulldo |     |     |     |
21:
| beautomaticallyremovedfromconsiderationbecauseitwillbe |     |     |     |     |            | 𝑢                |     | 𝑃   |     |
| ------------------------------------------------------ | --- | --- | --- | --- | ---------- | ---------------- | --- | --- | --- |
|                                                        |     |     |     |     | 22: insert | atthebeginningof |     |     |     |
identifiedasin-accessible.Aftermappingalloftheroutevertices
|     |     |     |     |     | 23: 𝑢 | ←𝑝𝑟𝑒𝑣[𝑢] |     |     |     |
| --- | --- | --- | --- | --- | ----- | -------- | --- | --- | --- |
andlinks,well-defineddatasourcesareavailableforvariousroute
|     |     |     |     |     | 24: endwhile |     |     |     |     |
| --- | --- | --- | --- | --- | ------------ | --- | --- | --- | --- |
planningmethodsinthenextsteps.
|     |     |     |     |     | insert | 𝑣 atthebeginningof | 𝑃   |     |     |
| --- | --- | --- | --- | --- | ------ | ------------------ | --- | --- | --- |
|     |     |     |     |     | 25:    | 𝑜                  |     |     |     |
return𝑃
26:
2.3 RoutePlanningandUserInterface
Equippedwiththeroadgraphandshadedratiograph,oursystem
cannowoffercustomizableroutingrecommendationsthrougha
|     |     |     |     |     | 3 DATASETCONSTRUCTION |     |     |     |     |
| --- | --- | --- | --- | --- | --------------------- | --- | --- | --- | --- |
modifiedversionoftheDijkstra[16]algorithm.Userscaninputa
queryintheformatQuery(𝑂,𝐷,𝑇𝑦𝑝𝑒),whereOandDrepresent Whileconductingrouteplanningtasks,inthispaper,wegetridof
thelocalizedspeciallycollectedLiDARdata,instead,wepropose
thecoordinatesofthestartingpointsanddestinations,respectively,
denotedas(x,y)and(x′,y′).TheTypeparameterspecifiesthemode toadoptamoreaccessibleresource-satelliteimageasbasedata,
andwequerytheGoogleMapAPI1forthesatelliteimagesofa
oftransportation,eitherwalkorbike.Dependingontheselected
type,differentgraphsareutilized:T𝑤𝑎𝑙𝑘 uses{G𝑤𝑎𝑙𝑘 ,G },and specificcityinthedemo.Weusethe20xzoomedpileimagedata
U
T𝑏𝑖𝑘𝑒 employs{G𝑏𝑖𝑘𝑒 ,G }.Thissystemallowsforrouteplanning forprocessing,theresolutionattheequatoris0.1246metersper
U
thatistailoredtotheuser’sspecificpreferencesandneeds.Let𝛼be pixel(thereare400pixelsintotal,sotherangeinequatoris400×
thepreferenceforamoreshadedroute𝛼 [0,1],and1−𝛼 0.1246=49.84m).Toagenerallatitude,theresolution𝑅𝑒𝑠is:
|     |     | ∈   |     | would |     |     |     |     |     |
| --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- |
bethepreferenceweightforthedistance.Thus,foranyedgewith
|     |     |     |     |     |     | 𝑅𝑒𝑠 =49.84×𝐶𝑜𝑠𝑖𝑛(𝑙𝑎𝑡) |     |     | (2) |
| --- | --- | --- | --- | --- | --- | --------------------- | --- | --- | --- |
connectivity,thevalueoftheedgewillbeupdatedbytheequation:
|     |                 |         |     |     | wherethe𝑙𝑎𝑡 | isthelatitudeindegrees. |     |     |     |
| --- | --------------- | ------- | --- | --- | ----------- | ----------------------- | --- | --- | --- |
|     | 𝑤 𝑗𝑜𝑖𝑛𝑡(𝑢,𝑣)=𝛼𝑉 | +(1−𝛼)𝑉 |     | (1) |             |                         |     |     |     |
𝑠ℎ𝑎𝑑𝑒 𝑑𝑖𝑠𝑡𝑎𝑛𝑐𝑒
| wherethe𝑉 | canberepresentedas𝑟(𝑢,𝑣),giventhetwopoint |     |     |     |                                                |     |     |     |     |
| --------- | ----------------------------------------- | --- | --- | --- | ---------------------------------------------- | --- | --- | --- | --- |
|           | 𝑠ℎ𝑎𝑑𝑒                                     |     |     |     | Table1:Thedatasetstatisticsandfileinformation. |     |     |     |     |
ofinterests𝑢and𝑣,and𝑟(·)astheshaderatiocalculationfunction.
Inthealgorithm1,the𝑉
isthesetofinterestedpointsfromthe
|     |     |     |     |     | Dataset | Images Size | Latitude-LongitudeRange |     |     |
| --- | --- | --- | --- | --- | ------- | ----------- | ----------------------- | --- | --- |
OSM-filteredbikeableorwalkablegraphnetwork,and𝐸istheset
ofaccessiblelanes(edges),andafterthecalculation,thereturned𝑃 Tempe 38,796 3.67GB (33.43,33.32,-111.97,-111.89)
containsthe𝑃𝑎𝑡ℎofthesuggestedplan,whichisalistofPOIsand
|     |     |     |     |     | Paris | 26,052 2.94GB | (48.88,48.83,2.30,2.39) |     |     |
| --- | --- | --- | --- | --- | ----- | ------------- | ----------------------- | --- | --- |
canbeusedforplanningandnavigation.Alternatively,onecan Byeng 72 6.6MB (33.425,33.422,-111.941,-111.936)
easilymodifytheabovealgorithmandoutputthetop𝑘suggested
| pathsbasedontheirdifferentpreference𝛼 |     | reflectingonabalance |     |     |     |     |     |     |     |
| ------------------------------------- | --- | -------------------- | --- | --- | --- | --- | --- | --- | --- |
ofshadedareasanddistance. 1https://developers.google.com/maps/apis-by-platform

Conferenceacronym’XX,June03–05,2024,NY Trovatoetal.
Figure3:ThecomparisonbetweentwoitinerariesbyShadeRouterinParis.Theshortestrouteinorangecolorismoreexposed
toheatwavescomparedtothemostshadedroute,asshowninthesnapshotofstreetviews.
Thedataisreleasedatthelinkofthefootnote2.Inthesedatasets, visitthedeployedwebsite4 anditisalsowelcometocheckour
wecoveredtwocompletecitiesParis, FranceandTempe - AZ, releasedcodesite5.
USA.WealsoincludeacasestudydatasetByengwhichistheloca-
tionoftheBrickyardEngineeringBuilding,inTempe,AZ,No.699. 5 CONCLUSION
Inthiswork,weproposeaprototypemethodofShadeRouter,
4 DEMOPRESENTATION
whichleveragesthesatelliteimagetominetheshadedratio.By
Inthissection,weintroducethedemoprogram,therecordeddemo doingso,itprovidestherouteplanningsuggestionsforpedestrians
video3andprovideanintroductiontotheShadeRouter. andcyclistsconsideringtheshadesontheroad.Itisfeasibleto
Intheimplementedprogram,theuserinterfaceincorporates4 extendthedemotoaworldwidemapusingtheformallydesigned
textboxes,twobuttons,andonetravelmodeselector,withamap pipelinebasedonthepubliclyaccessiblesatelliteimagedata.
viewingareaatthebottom.Correspondingtotheuserinput,the Thisdemonstrationcanbefurtherimprovedbytemporalinfor-
userwouldberequiredtoinputthesourcepointanddestination mationsuchasthetimeorseasonalshadesituation.Wehopethis
point,theextratwoboxesarefortheGooglemapAPIandthe projectwillbenefitthecitizens’healthbyreducingtheheatwave
numberofsuggestedusersintendtoreceive.Oncetwovalidplaces exposureprobabilityandprovidingamorecomfortableoutdoor
aresearched,thesystemwillshowuptopkmarkedroutesand activityplan.
popupalegendexplainingeachcolor’smeaning.Thetwoimages Futuredevelopmentsincludeadaptingthecurrentmethodtoa
showninFig.3.arefromtworesults,theshortestpath,andthe moredynamicshadesimulationthatcapturesthereal-timeshadow
mostshadedpath,wecouldnoticethattheorangelinegivesthe changesincities,andoptimizestheplanningspeedtoenhancethe
fastestitinerarywithhighexposuretosunshine,andthegreenone users’experience.Ifequippedwithmoresensibledata,ormore
prefersalleythatismoreshadedandthermallycomfortable.This outdoorchoices,thealgorithmcouldevenincludewindstrength
enablesuserstofindthemostpreferredplansthatimprovethe andextremeweatherconditionsintheplanning,andprovidee-
travelexperience.Despitethedemo,formoreinteraction,please scootersandsharedbikesasalternatives,andthesewilldefinitely
providericheractivitychoicesforcity-travelers.
2https://www.dropbox.com/scl/fo/rvq0nazh7sd4qlx013l16/
ANzGN1kQIvj88Mrpc7m6-w8?rlkey=w3xml0kv75hbt80gz8km75phd&dl=0
3https://drive.google.com/drive/folders/1BvR0i0eImDb86HXiGS4hGRoFKa71DAnJ? 4https://longchaoda.github.io/ShadedPlanning.github.io/
usp=sharing 5https://github.com/LongchaoDa/Shaded_Planning.git

ShadedRoutePlanningUsingActiveSegmentationandIdentificationofSatelliteImages Conferenceacronym’XX,June03–05,2024,NY
REFERENCES
applications.In9thInternationalConferenceonUrbanClimate,Toulouse,France.
[1] AndreasBehrendt.2005.Temperaturemeasurementswithlidar.InLidar:Range- [12] XiaoyeLiu,ZhenyuZhang,JimPeterson,andShobhitChandra.2007.Theeffect
ResolvedOpticalRemoteSensingoftheAtmosphere.Springer,273–305. ofLiDARdatadensityonDEMaccuracy.InProceedingsofthe17thInternational
[2] JonathanBennett.2010.OpenStreetMap.PacktPublishingLtd. CongressonModellingandSimulation(MODSIM07).ModellingandSimulation
[3] MagdalenaBexellandKristinaJönsson.2017. ResponsibilityandtheUnited SocietyofAustraliaandNewZealand.
Nations’sustainabledevelopmentgoals.InForumfordevelopmentstudies,Vol.44. [13] ZhixinLiu,WenwenCheng,ChiYungJim,TobiEnioluMorakinyo,YuanShi,and
Taylor&Francis,13–29. EdwardNg.2021.Heatmitigationbenefitsofurbangreenandblueinfrastructures:
[4] IsaacBuo,ValentinaSagris,JaakJaagus,andArianeMiddel.2023.High-resolution Asystematicreviewofmodelingtechniques,validationandscenariosimulation
thermalexposureandshademapsforcoolcorridorplanning.SustainableCities inENVI-metV4.BuildingandEnvironment200(2021),107939.
andSociety93(2023),104499. [14] JiaweiLuandXuesongSimonZhou.2023.Virtualtracknetworks:Ahierarchical
[5] PaulDostal,AntjeKatzschner,MichaelBruse,andSebastianHuttner.2009.Quan- modelingframeworkandopen-sourcetoolsforsimplifiedandefficientconnected
tifyingthehumanthermal-heat-stressinCentralEuropeancitieswithBOTWorld andautomatedmobility(CAM)systemdesignbasedongeneralmodelingnetwork
andonsite-interviewsasanalysingtooltoestimatethethermalsensationof specification(GMNS).TransportationResearchPartC:EmergingTechnologies153
pedestrians.InProceedingsofthe7thInternationalConferenceonUrbanClimate, (2023),104223.
Vol.29. [15] KeithMa.2018.ParasolNavigation:OptimizingWalkingRoutestoKeepYouin
[6] ConstanzeFetting.2020.TheEuropeangreendeal.ESDNreport53(2020). theSunorShade.(2018).
[7] Yongcheng Jing, Xinchao Wang, and Dacheng Tao. 2023. Segment any- [16] MasatoNotoandHiroakiSato.2000. Amethodfortheshortestpathsearch
thinginnon-euclideandomains:Challengesandopportunities.arXivpreprint byextendedDijkstraalgorithm.InSmc2000conferenceproceedings.2000ieee
arXiv:2304.11595(2023). internationalconferenceonsystems,manandcybernetics.’cyberneticsevolvingto
[8] LeiKe,MingqiaoYe,MartinDanelljan,Yu-WingTai,Chi-KeungTang,FisherYu, systems,humans,organizations,andtheircomplexinteractions’(cat.no.0,Vol.3.
etal.2024.Segmentanythinginhighquality.AdvancesinNeuralInformation IEEE,2316–2320.
ProcessingSystems36(2024). [17] QiZhaoShanshanLi.2021. World’slargeststudyofglobalclimaterelated
[9] AlexanderKirillov,EricMintun,NikhilaRavi,HanziMao,ChloeRolland,Laura mortalitylinks5milliondeathsayeartoabnormaltemperatures.(2021).
Gustafson,TeteXiao,SpencerWhitehead,AlexanderCBerg,Wan-YenLo,etal. [18] QGISDevelopmentTeam.2022.QGISGeographicInformationSystem.
2023.Segmentanything.InProceedingsoftheIEEE/CVFInternationalConference [19] AristotelisVartholomaios.2023.Followtheshade:detectionofoptimallyshaded
onComputerVision.4015–4026. pedestrianpathswithinthehistoriccitycenterofThessaloniki.InIOPConference
[10] ThierryLeblanc,IStuartMcDermid,PhilippeKeckhut,AlainHauchecorne,CiaoY Series:EarthandEnvironmentalScience,Vol.1196.IOPPublishing,012070.
She,andDavidAKrueger.1998.Temperatureclimatologyofthemiddleatmo- [20] CarolinaVasilikouandMarialenaNikolopoulou.2020.Outdoorthermalcomfort
spherefromlong-termlidarmeasurementsatmiddleandlowlatitudes.Journal forpedestriansinmovement:thermalwalksincomplexurbanmorphology.
ofGeophysicalResearch:Atmospheres103,D14(1998),17191–17204. Internationaljournalofbiometeorology64(2020),277–291.
[11] FredrikLindberg,CGrimmond,ShihoOnomura,LeenaJärvi,andHWard.2015. [21] YaoWangandHongliangFang.2020.EstimationofLAIwiththeLiDARtechnol-
UMEP—anintegratedtoolforurbanclimatologyandclimatesensitiveplanning ogy:Areview.RemoteSensing12,20(2020),3457.
WorkshoponVisualisationinEnvironmentalSciences(EnvirVis)(2016) ShortPaper
A.Middel,K.Rink,andD.Zeckzer(Editors)
A Data-Driven Approach to Categorize Climatic Microenvironments
KathrinHäb†1,ArianeMiddel2,BenjaminL.Ruddell3andHansHagen1
1ComputerGraphicsandHCIGroup,UniversityofKaiserslautern,Germany
2SchoolofGeographicalSciencesandUrbanPlanning,ArizonaStateUniversity,Arizona,USA
3FultonSchoolsofEngineering,ArizonaStateUniversity,Arizona,USA
Abstract
Inurbanclimatology,identifyingareasofsimilarmicroclimaticconditionshelpstorelatefine-scaleurbanmorphologyvaria-
tionstotheirimpactonatmosphericsurroundings.Mobiletransectmeasurementsyieldhigh-resolutionmicroclimatedatathat
allowforthedelineationoftheseareasatafinescale.However,theresultingspatio-temporalmultivariatedataiscomplicated
andrequirescarefulanalysisandvisualizationtoidentifytheemergentclimaticmicroenvironments.Ourpreviousworkuseda
glyph-basedvisualizationtocomprehensivelyvisualizespatiallyaggregatedmultivariatedatafrommobilemeasurementsover
diverseroutes.Thisaggregationwasconductedoveraregulargrid,andtheutilizedglyphsencodedmultivariaterelationships,
averagewinddirectionduringdatacollection,numberoftransectstraversingagridcell,andgridcellsize.Inthispaper,we
reducethevisualcomplexityoftheresultingmapbycoloringthebackgroundofthegridcellsbasedonacomparisonofthe
glyphs.Theresultisagriddedmapthatvisuallyemphasizesspatialzonesofsimilarmultivariaterelationshipsandthattakes
theinformationencodedbytheglyphsintoaccount.Apreliminaryevaluationshowsthatthedescribedapproachyieldszones
thatlineupwiththephysicalstructureofthestudysite.
CategoriesandSubjectDescriptors(accordingtoACMCCS): ComputerGraphics[I.3.8]:Applications—;ComputerApplications
[J.2]:Earthandatmosphericsciences—
1. Introduction biletransectmeasurementscanbeusedtoretrievefine-scaledata
tocontributetosuchclassificationefforts[HSvH∗14,PLCC16].To
Classifyingaregionintoareasofsimilarclimatecharacteristicshas
derive an appropriate and general set of distinctive properties for
a long tradition in atmospheric sciences. On the global scale, the
eachclass,alargenumberofobservationsisrequired.
Köppen-Geigerclassificationstructurestheentireglobeintozones
Thespatialaggregationofmobilemeasurements,orinmoregen-
ofclearlydistinguishableenvironmentalconditions,basedonveg-
eralterms,multivariatetrajectories,isonestepintothisdirection.
etationgroups,temperatureregimes,andprecipitation[KGB∗06].
Here,thelinksbetweentrajectoryattributesandtheunderlyingspa-
Similarly,Sayreetal.[SDF∗14]delineateecologicallandunitson
tiallocationisofpredominantinterest,so,following[AA10],each
aglobalscalebyaggregatingbioclimate,landforms,lithology,and
mobilemeasurementruncanbetreatedasasequenceofindepen-
landcoverdatalayers.Atasmallerscale,theclassificationofur-
dentmeasurementevents[HMRH15,Häb15].
banareasintoso-calledclimatopesisusedtocreateurbanclimatic
Spatial aggregation becomes easy if the mobile transect mea-
maps[RNK11,RSL∗12].Here,severalinformationlayersinclud-
surements are frequently repeated over the same set of routes,
ingurbanmorphology,landuse,oratmosphericdata,arecombined
e.g., during larger campaigns using public transportation vehi-
tofacilitateclimate-sensitiveandsustainableurbanplanning.Re- cles [HSW∗14,BSK∗11], or smaller campaigns using more flex-
cently,theconceptoflocalclimatezones(LCZ)wasdevelopedby ible sensor transportation modes [EPP∗12,LBCP15]. For a fixed
StewartandOke[SO12].Inthisclassificationscheme,urbansites
route, a variable of interest can be aggregated over a set of way-
at the local scale are characterized using their morphological ap- points[BSK∗11,EPP∗12],roadsegments[LBCP15],oraregular
pearance, surface materials, and human activity – properties that grid[HSW∗14,AAS∗12].
areclimate-relevant[SO12,BAB∗15].
Notallmobilemeasurementsareconductedoverafixedroute.
For the urban microscale, typically ranging between 1 cm and
Datacrowdsourcingisanexampleforvayingroutesthatdependon
1km[EPW11],ageneralizableclimateclassificationwasnotde-
theindividualmovementoftheparticipants.Examplesforthelat-
velopedsofarduetothecomplexdynamicsofmicroclimate.Mo- tercasescanbefoundin[HSST12]and[WAK∗10]forairquality
measurements.Somemobilemeasurementcampaignsusevarying
routestoresearchdifferentclimaticphenomenaortoincreasethe
† E-mail:kathrin.haeb@cs.uni-kl.de
(cid:13)c 2016TheAuthor(s)
EurographicsProceedings(cid:13)c 2016TheEurographicsAssociation.
DOI: 10.2312/envirvis.20161105

36 K.Häbetal./AData-DrivenApproachtoCategorizeClimaticMicroenvironments
spatialcoverageofthecollecteddata,sothatalargernumberofpo-
a.
tentialclimaticmicroenvironmentsarerepresentedinthesamples.
Bothisthecaseforthesampledatasetusedinthisstudy.
| In [HMRH15], |     | we developed |     | a glyph-based | approach |     | to visu- |     |     |     |     |     |
| ------------ | --- | ------------ | --- | ------------- | -------- | --- | -------- | --- | --- | --- | --- | --- |
allydelineateareasofsimilarurbanmicroclimatebasedonmobile
transectmeasurementstraversingvaryingroutes.Sincetheglyphs
| incorporate        | complex      | information |                  | and are | thus also  | visually | com-    |     |     |     |     |     |
| ------------------ | ------------ | ----------- | ---------------- | ------- | ---------- | -------- | ------- | --- | --- | --- | --- | --- |
| plex, interpreting |              | them can    | be overwhelming. |         | This       | study    | extends |     |     |     |     |     |
| the work           | by [HMRH15], |             | comparing        | the     | glyphs and | coloring | the     |     |     |     |     |     |
backgroundofthegridcellsbasedonthiscomparisontofacilitate
| thedetectionofpotentialclimaticmicroenvironments[Häb15]. |     |     |     |     |     |     |     |     |     |     | b.  |     |
| -------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
2. MappingApproach
|     |     |     |     |     |     |     |     | Figure 1: | Glyph-based | visualization | of climatic microenviron- |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ----------- | ------------- | ------------------------- | --- |
2.1. Spatialaggregationandglyphdesign
|     |     |     |     |     |     |     |     | ments in | the Power | Ranch community, | Gilbert, AZ, USA | (back- |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | --------- | ---------------- | ---------------- | ------ |
groundmap:[Env12]).(a)encodesthemeaningofthecolorsused
Similarto[AA08],[HMRH15]spatiallyaggregatethetransectruns
intheglyphs[GCML06,VJN∗15](colorsbasedon[HB03]),while
| using a | regular | grid spanned | over | the bounding | box | of  | all tran- |     |     |     |     |     |
| ------- | ------- | ------------ | ---- | ------------ | --- | --- | --------- | --- | --- | --- | --- | --- |
sect routes. For each grid cell and individual transect run, mea- (b)showsaclose-upoftheglyphs.
suredattributesareaveragedovertheareacoveredbythegridcell
| and normalized |     | according | to their | individual | value | range. | A self- |                                                     |     |     |     |     |
| -------------- | --- | --------- | -------- | ---------- | ----- | ------ | ------- | --------------------------------------------------- | --- | --- | --- | --- |
|                |     |           |          |            |       |        |         | • NumberofSOMtrainingiterations:10xN(N=numberofsam- |     |     |     |     |
organizingmap(SOM)[Koh90]istrainedbasedontheaggregated
plesafteraggregation)
| and normalized |     | values and | partitioned | using | K-Means | Clustering |     |                                     |     |     |     |     |
| -------------- | --- | ---------- | ----------- | ----- | ------- | ---------- | --- | ----------------------------------- | --- | --- | --- | --- |
|                |     |            |             |       |         |            |     | • NumberofK-Meansclustercentroids:6 |     |     |     |     |
[VA00,WBS13].Incontrasttoourpreviouswork[HMRH15],we
donotusetheaggregatedvaluesofasingle,"representative"tran-
Fig.1revealsafirstinsightintopotentialmicroenvironmentsina
sectruntotraintheSOM.Instead,asubsetofthesamplesfromall studyarea,anddetailsaboutthemultivariatevaluedistributioncan
transectrunsareused,whileamountandlocationofthesesamples beexploredbyzoomingintolocationsofinterest.However,thedis-
dependonthegridcellsize.Inalaststep,thecategoriesdetermined
playlacksaproperguidanceonwhichglyphssharecertainproper-
bytheclusteringprocedureareappliedtotheentiresetofaggre-
ties,andastructuredcomparisonofglyphsthatarelocatedfurther
gatedandnormalizedvalues.
apartfromeachotherisdifficult.Therefore,wecolorthetraversed
Aglyph-basedvisualizationshowstheresultofthisaggregation gridcellsaccordingtoglyphsimilarityinadditiontoshowingthe
approach; each traversed grid cell is assigned one glyph (Fig. 1). glyphsattheirlocation.Thisway,thedistributionofsimilargrid
Following[HMRH15],theglyphsencode:
|     |     |     |     |     |     |     |     | cells is summarized, |     | while the advantages | of the previously | de- |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------------- | --- | -------------------- | ----------------- | --- |
• the number of transects traversing that grid cell; each transect scribedglyph-basedvisualizationarestillkept.
runisrepresentedbyoneglyphsegment Groupingtheglyphsaccordingtosimilarityiscomplexbecause
ofthecategoricalnatureoftheirappearance.Thelatterisgivenby
| • the cluster | membership |     | of the | run traversing | that | grid | cell, en- |     |     |     |     |     |
| ------------- | ---------- | --- | ------ | -------------- | ---- | ---- | --------- | --- | --- | --- | --- | --- |
theclustermembershipsoftheglyph’sindividualsegments,each
codedbythecolorofthecorrespondingglyphsegment,whose
meaning can be explored by means of a parallel coordinates representingacertaincategoryofmultivariaterelationships(e.g.,a
plot[GCML06,VJN∗15](Fig.1a) segment’sclustercanrepresent"highsurfacetemperaturesandlow
• winddirectionduringdatacollection,givenbytheorientationof humidities").Anotherproblemarisesbecausethenumberofseg-
mentsperglyphvariesbetweengridcells.Finally,asegment’sori-
thecorrespondingglyphsegment
entationand,hence,thedistributionofclustermembershipsaround
• thegridcellsize,whichisproportionaltoaglyph’sradius.
a360◦circleaddstothecomplexity.
Therefore,comparingtheglyphstoeachotherrequiresawayto
2.2. Glyphcomparisonandmappingtechnique characterizetheirproperties.Inoursolution,thisdescriptionrelies
onthesegmentationoftheglyphsintoeightsectorswithasizeof
Theresearchdescribedinthispaperisbasedonamobiletransect
45◦.Persector,thenumberofglyphsegmentsisstoredwitheach
| measurement | data | set with | 21 runs. | The | data were | recorded | in a |     |     |     |     |     |
| ----------- | ---- | -------- | -------- | --- | --------- | -------- | ---- | --- | --- | --- | --- | --- |
oftheirclustermemberships.
residentialneighborhoodinGilbert,Arizona,USAandcoverdif-
Allglyphsinthedisplayarecategorizedbasedonthisinforma-
ferenttimesofdayinthreedifferentseasons.Airtemperature(Ta)
tion.Glyphscanonlyfallintothesamecategoryifthey,foreach
andrelativehumidity(RH)wererecordedintwodifferentheights
sector,sharethesameamountofglyphsegments,andthesamedis-
(1mand2m),alongwithsurfacetemperature(Ts).Thetransects
tributionofclustermembershipsinherentinthesesegments.Each
followpartiallydivergingroutes[HMRH15].
glyphisassignedtheresultingcategory,definedbythedescription
TocreateaglyphmapasdescribedinSection2.1andasshown
explainedabove.
inFig.1,2,and3,weusedthefollowingsetup:
|     |     |     |     |     |     |     |     | The actual | comparison | is conducted | between these categories. |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ---------- | ------------ | ------------------------- | --- |
• Consideredvariables:Ts;RH 1m;T a,1m;RH 2m;T To determine the amount of similarity, a "distance" between the
a,2m
• Gridcellsize:30 glyphcategoriesisdefined.UsingthecasesshowninTable1,the
• SOMheightandwidth:20 glyphsarecompared,whilecorrespondingsimilarity"points"are
(cid:13)c 2016TheAuthor(s)
|     |     |     |     |     |     |     |     |     |     | EurographicsProceedings(cid:13)c | 2016TheEurographicsAssociation. |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------------- | ------------------------------- | --- |

K.Häbetal./AData-DrivenApproachtoCategorizeClimaticMicroenvironments 37
| Case  Description |     | Graphicalsummary | Points Points |     |     |     |     |     |
| ----------------- | --- | ---------------- | ------------- | --- | --- | --- | --- | --- |
|                   |     |                  | (per  (entire |     |     |     | a.  |     |
sector) glyph)
| 1 - containthesame amountof |     |     | 15 w*15 |     |     |     |     |     |
| --------------------------- | --- | --- | ------- | --- | --- | --- | --- | --- |
segments
- distributionofcluster
membershipsisequal
| 2 - do not containthesame |     |     | 12 w*12 |     |     |     |     |     |
| ------------------------- | --- | --- | ------- | --- | --- | --- | --- | --- |
amountofsegments
| - thesame setofdifferent  |     |     |     |     |     |     | b.  |     |
| ------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
clustermembershipsis
availablein bothglyphs.
| 3 - do not containthesame  |     |     | 10 w*10 |     |     |     |     |     |
| -------------------------- | --- | --- | ------- | --- | --- | --- | --- | --- |
amountofsegments
- thesetofclustermemberships
glyph1 isa subsetofthe
clustermembershipsin glyph2.
c.
| 4 - m | a y o r m a y n o t  c o n t ai n | t h e | 10𝑝𝑎 ** w∗10𝑝𝑎 |     |     |     |     |     |
| ----- | --------------------------------- | ----- | -------------- | --- | --- | --- | --- | --- |
| sa    | m e  a m o u n t o f s e g m e n  | t s   |                |     |     |     |     |     |
- thesetofclustermemberships
in glyph1 isdifferent fromthat
in glyph2, but thereisa
percentageofagreement Figure 2: Coloring the background of each grid cell according
| 5 - mayormaynot containthe |     |     | 0.01 0.01 |     |     |     |     |     |
| -------------------------- | --- | --- | --------- | --- | --- | --- | --- | --- |
same amountofsegments glyph similarity. In (a), the described procedure works well. In
- thereisnoagreement (b),backgroundcolorsofsimilarglyphsaretoodistinct.In(c),a
betweenglyph1 andglyph2
in termsofthecluster
memberships largevarietyofdifferentclustersrepresentedinoneglyphisshown
6 Onesectorcontainssegments,  0.01 -- (background map: [Env12]; Fig. 1a shows the meaning of glyph
whiletheotherdoesnot.
segmentcolors)
| 7 B o th | s e c t o rsdo not containany |     | 0.01 --           |                 |           | .             |                  |         |
| -------- | ----------------------------- | --- | ----------------- | --------------- | --------- | ------------- | ---------------- | ------- |
| se g m   | e n t s .                     |     |                   |                 |           |               |                  |         |
|          |                               |     |                   | inantly orange, | green and | blue segments | are consistently | colored |
| 2 ∗# 𝑠   | 𝑒 𝑔 𝑚 𝑒 𝑛 𝑡 𝑠 _𝑎 𝑔 𝑟          |     | w* = weightfactor |                 |           |               |                  |         |
** 𝑝𝑎= #𝑠𝑒𝑔 𝑚 𝑒 𝑛 𝑡 𝑠 1+ # 𝑠 𝑒 𝑔 𝑚 𝑒 𝑛𝑡𝑠2 in dark green. If the latter colors are mixed with purple or red,
|     |     |     |     | the background | color becomes | dark purple. | Grid cells | contain- |
| --- | --- | --- | --- | -------------- | ------------- | ------------ | ---------- | -------- |
#𝑠𝑒𝑔𝑚𝑒𝑛𝑡𝑠_𝑎𝑔𝑟= number of segments with agreeing cluster membership
(1 in the example given in the graphical summary of case 4)
|     |     |     |     | ing numerous | segments | with a large variety | of different | clusters, |
| --- | --- | --- | --- | ------------ | -------- | -------------------- | ------------ | --------- |
Table1: Metricappliedforglyphcomparison[Häb15]. especially those combining blue, red, and purple appear in blue
(Fig.2c).Fig.2ashowsthatdifferentcombinationsofclustermem-
bershipsleadtodifferentcolors,andsimilarglyphsreceivesimilar
summated.Thedistancebetweentwoglyphs,∆ glyph ,isthengiven backgroundcolors.Thus,themetricdescribedherecanbeuseful
by
|     |     |     |     | to highlight | patterns of similar | multivariate | relationships, | i.e. po- |
| --- | --- | --- | --- | ------------ | ------------------- | ------------ | -------------- | -------- |
tentialclimaticmicroenvironments.
1 Fig. 2b reveals cases where the background color is more dif-
|     | ∆   | glyph = | (1) |     |     |     |     |     |
| --- | --- | ------- | --- | --- | --- | --- | --- | --- |
∑Points ferent as expected. While all glyphs in this detail show orange
segmentspointingeast,differentconfigurationsofclustermember-
with∆ =0forglyphsofthesamecategory.
glyph
The comparison is conducted in two steps. First, entire glyphs shipsinthesegmentspointingwestcausethebackgroundcolorsto
arecomparedtoeachother,independentfromthedescribedsubdi- divergesignificantly.Similarly,gridcellswithonlyyellowglyphs
|     |     |     |     | appear in | turquoise, diverging | from cells | with glyphs | combining, |
| --- | --- | --- | --- | --------- | -------------------- | ---------- | ----------- | ---------- |
visionofglyphsintosectors.Thepointsreceivedforthecasesde-
e.g.,yellowandpurple.
pictedinTable1aremultipliedbyaweightfactorwthatdetermines
theimportanceofoverallsimilarity(w=10inoursolution).Then,
comparedglyphsreceiveadditionalpointsforagreementincorre-
3. ResultsandDiscussion
spondingsectors,whichareaddedtotheoverallsimilarityscore.
Both steps are necessary; comparing only sector-wise would Fig.3illustratestheresultsoftheapproach,basedonthedataset
cause large distances between glyphs with the same overall dis- and initialization described in Section 2.2. A qualitative analysis
tribution of cluster memberships, but without agreement in cor- suggests that the physical structure of the study site (Fig. 3a) is
responding sectors. On the other side, neglecting wind directions represented by the colored grid cells (Fig. 3b). Parks stand out,
wouldrenderglyphswithadivergingcircularsetupsimilar.Adding showingadistinctpatternofturquoiseandpurplegridcells("park
points for corresponding segments in a sector decreases the dis- cells").However,differentparksshowdifferentsignals,owingto
tancebetweenglyphs. differenthumidityandtemperatureregimes.Thus,intheparkon
The grid cells are colored based on the pairwise distance be- theleftsideofthestudyareaonlyfewturquoiseandpurplepark
tween glyph categories. Sammon’s mapping [Sam69] of the dis- cellsappear.Usingthecorrespondingglyphsforfurtheranalysisre-
tances into the HSL color space is used to determine the color, vealsthatpurpleglyphsegmentsareunderrepresentedifcompared
i.e. grid cells containing similar glyphs are assigned similar col- to,e.g.,theparkintheupperrightofthemap.Gridcellsdominated
ors[VJN∗15,AAS∗12,SR13].
bybuildingsandasphaltsurfacesarecoloreddarkgreen("imper-
Overall,theresultslookpromising,ascanbeobservedinFig.2. viouscells"),showinghighsurfacetemperaturesandlowrelative
For example, grid cells containing glyphs with combinations of humidity(Fig.1a).
purple, yellow and red segments consistently appear in a light to Althoughtheglyphsrevealthenumberofsamplespergridcell,
midpurplecolor,whilegridcellscontainingglyphswithpredom- their background colors alone currently do not explicitly repre-
(cid:13)c 2016TheAuthor(s)
| EurographicsProceedings(cid:13)c | 2016TheEurographicsAssociation. |     |     |     |     |     |     |     |
| -------------------------------- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- |

38 K.Häbetal./AData-DrivenApproachtoCategorizeClimaticMicroenvironments
| a.  |     |     |     |     |     | b.  |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Figure3: Coloringamapaccordingtoglyphsimilaritytohighlightzonesofsimilarmicroclimate.(a)showsthephysicalstructureofthe
studysite(GoogleEarth,2015),while(b)showsthecoloredgridcellsandthecorrespondingglyphdistribution(backgroundmap:[Env12],
seeFig.1aforthemeaningofaglyphsegment’scolor).
sent the implied notion of uncertainty. The number of segments ASU,AlanandSandraRuffalo,andthePowerRanchHomeowners
| perglyphinfluencesitspositionintheresultingdistancefieldand |     |     |     |     |     | Association. |     |     |     |     |     |
| ----------------------------------------------------------- | --- | --- | --- | --- | --- | ------------ | --- | --- | --- | --- | --- |
thereforealsoitsbackgroundcolor,butsamevisualcueisusedto
representanyotherdistanceaswell.Thiscanleadtoanambiguous
References
perception,iftheglyphsarenotshown.Therefore,forfuturework,
we plan to include an appropriate visual cue to the visualization, [AA08] ANDRIENKOG.,ANDRIENKON.:Spatio-temporalaggregation
whilealsoquantitativelyanalyzingthedescribedconceptofglyph forvisualanalysisofmovements.InVisualAnalyticsScienceandTech-
similarity.Furthermore,weplantoaddthetemporaldimensionof nology, 2008. VAST ’08. IEEE Symposium on (Oct 2008), pp. 51–58.
visualized"zones"intothedisplay. doi:10.1109/VAST.2008.4677356.2
|     |     |     |     |     |     | [AA10] ANDRIENKO      |     | G., ANDRIENKO         | N.: A       | general framework |     |
| --- | --- | --- | --- | --- | --- | --------------------- | --- | --------------------- | ----------- | ----------------- | --- |
|     |     |     |     |     |     | for using aggregation |     | in visual exploration | of movement | data.             | The |
4. Conclusion Cartographic Journal 47, 1 (2010), 22–40. doi:10.1179/
000870409X12525737905042.1
We present an approach for the spatial aggregation and visual- [AAS∗12] ANDRIENKON.,ANDRIENKOG.,STANGEH.,LIEBIGT.,
ization of mobile transect measurements conducted over diverse HECKERD.: Visualanalyticsforunderstandingspatialsituationsfrom
routes.Aglyph-basedvisualizationsummarizestheaggregationre- episodicmovementdata. KI-KünstlicheIntelligenz26,3(2012),241–
sultsforeachgridcellinaregulargridthatwasspannedoverthe 251.doi:10.1007/s13218-012-0177-4.1,3
areacoveredbytheentiresetofroutes,asdescribedinourprevious [BAB∗15] BECHTEL B., ALEXANDER P. J., BÖHNER J., CHING J.,
CONRADO.,FEDDEMAJ.,MILLSG.,SEEL.,STEWARTI.:Mapping
work[HMRH15].
localclimatezonesforaworldwidedatabaseoftheformandfunction
Tovisuallystructurethedisplay,glyphsimilarityishighlighted
|     |     |     |     |     |     | ofcities. ISPRSInternationalJournalofGeo-Information4,1(2015), |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | -------------------------------------------------------------- | --- | --- | --- | --- | --- |
bycoloringthebackgroundofthegridcellsaccordingtoametric 199–219.doi:10.3390/ijgi4010199.1
thattakestheglyphstructureintoaccount.Thisfurtherfacilitates
|     |     |     |     |     |     | [BSK∗11] BUTTSTÄDT |     | M., SACHSEN | T., KETZLER | G., MERBITZ |     |
| --- | --- | --- | --- | --- | --- | ------------------ | --- | ----------- | ----------- | ----------- | --- |
thedetectionofclimaticmicroenvironments,andrepresentsafirst
|              |             |         |            |                      |     | H., SCHNEIDER         | C.: | A new approach | for highly         | resolved    | air tem- |
| ------------ | ----------- | ------- | ---------- | -------------------- | --- | --------------------- | --- | -------------- | ------------------ | ----------- | -------- |
| step towards | delineating | climate | "zones" at | the urban microscale |     |                       |     |                |                    |             |          |
|              |             |         |            |                      |     | perature measurements |     | in urban       | areas. Atmospheric | Measurement |          |
thatarepurelybasedonmeasuredatmosphericvariables. Techniques Discussions 4, 1 (2011), 1001–1019. doi:10.5194/
amtd-4-1001-2011.1
[Env12] ENVIRONMENTALREMOTESENSINGANDGEOINFORMATICS
Acknowledgements
|     |     |     |     |     |     | LABANDCAPLTER: |     | 4bandNAIPlandclassificationofCentralAri- |     |     |     |
| --- | --- | --- | --- | --- | --- | -------------- | --- | ---------------------------------------- | --- | --- | --- |
zona,2012.ArizonaStateUniversity.2,3,4
| The authors | wish to | thank the | reviewers for | their valuable | com- |                                                     |     |     |     |     |     |
| ----------- | ------- | --------- | ------------- | -------------- | ---- | --------------------------------------------------- | --- | --- | --- | --- | --- |
|             |         |           |               |                |      | [EPP∗12] ELENB.,PETERSJ.,POPPELM.V.,BLEUXN.,THEUNIS |     |     |     |     |     |
ments,aswellastheArizonaStateUniversityEnvironmentalRe-
J.,REGGENTEM.,STANDAERTA.:TheAeroflex:Abicycleformobile
| mote Sensing | and Geoinformatics |     | Lab (ERSG) | for providing | the |                         |     |                            |     |         |     |
| ------------ | ------------------ | --- | ---------- | ------------- | --- | ----------------------- | --- | -------------------------- | --- | ------- | --- |
|              |                    |     |            |               |     | airqualitymeasurements. |     | Sensors13,1(2012),221–240. |     | doi:10. |     |
NAIPdataset(additionalsupportwasfurnishedbytheGilbertF.
3390/s130100221.1
WhiteEnvironmentandSocietyendowment.Sourcedata:National [EPW11] ERRELLE.,PEARLMUTTERD.,WILLIAMSONT.:UrbanMi-
Agriculture Imagery Program (NAIP), http://www.fsa.usda.gov). croclimate:Designingthespacesbetweenbuildings. EarthScan,Lon-
This work was supported in part by the DFG (IRTG 2057), the don,Washington,2011.1
| NSF Grant | SES-0951366, | NSF | EaSM Program | EF-1049251, | the |                                                    |     |     |     |     |     |
| --------- | ------------ | --- | ------------ | ----------- | --- | -------------------------------------------------- | --- | --- | --- | --- | --- |
|           |              |     |              |             |     | [GCML06] GUOD.,CHENJ.,MACEACHRENA.M.,LIAOK.:Avisu- |     |     |     |     |     |
NSFLTERProgramBCS-1026865,theSaltRiverProjectgrantto
alizationsystemforspace-timeandmultivariatepatterns(VIS-STAMP).
(cid:13)c 2016TheAuthor(s)
|     |     |     |     |     |     |     |     | EurographicsProceedings(cid:13)c | 2016TheEurographicsAssociation. |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------------------------- | ------------------------------- | --- | --- |

K.Häbetal./AData-DrivenApproachtoCategorizeClimaticMicroenvironments 39
IEEETransactionsonVisualizationandComputerGraphics12,6(Nov. [SO12] STEWARTI.D.,OKET.R.: Localclimatezonesforurbantem-
2006),1461–1474.doi:10.1109/TVCG.2006.84.2 peraturestudies.BulletinoftheAmericanMeteorologicalSociety93,12
(2012),1879–1900.doi:10.1175/BAMS-D-11-00019.1.1
| [Häb15] HÄBK.: |     | VisualizationandAnalysisTechniquesforUrbanMi- |     |     |     |     |     |     |     |
| -------------- | --- | --------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
croclimateDataSets.PhDthesis,UniversityofKaiserslautern,2015.1, [SR13] SARLIN P., RONNQVIST S.: Cluster coloring of the self-
2,3
organizingmap:Aninformationvisualizationperspective. InInforma-
tionVisualisation(IV),201317thInternationalConference(July2013),
| [HB03] HARROWERM.,BREWERC.: |     |     |     | ColorBrewer.org:Anonlinetool |     |     |     |     |     |
| --------------------------- | --- | --- | --- | ---------------------------- | --- | --- | --- | --- | --- |
pp.532–538.doi:10.1109/IV.2013.72.3
| forselectingcolourschemesformaps. |     |     |     | TheCartographicJournal40,1 |     |     |     |     |     |
| --------------------------------- | --- | --- | --- | -------------------------- | --- | --- | --- | --- | --- |
(Jun2003),27–37.doi:10.1179/000870403235002042.2
|     |     |     |     |     |     |     | [VA00] VESANTOJ.,ALHONIEMIE.: |     | Clusteringoftheself-organizing |
| --- | --- | --- | --- | --- | --- | --- | ----------------------------- | --- | ------------------------------ |
NeuralNetworks,IEEETransactionson11,3(May2000),586–
| [HMRH15] | HÄBK.,MIDDELA.,RUDDELLB.L.,HAGENH.: |     |     |     |     | Spa- | map. |     |     |
| -------- | ----------------------------------- | --- | --- | --- | --- | ---- | ---- | --- | --- |
600.doi:10.1109/72.846731.2
| tial Aggregation | of  | Mobile | Transect | Measurements | for the | Identifica- |     |     |     |
| ---------------- | --- | ------ | -------- | ------------ | ------- | ----------- | --- | --- | --- |
tionofClimaticMicroenvironments. InWorkshoponVisualisationin [VJN∗15] VROTSOU K., JANETZKO H., NAVARRA C., FUCHS G.,
| Environmental | Sciences | (EnvirVis) |     | (2015), Middel | A., Rink | K., We- |     |     |     |
| ------------- | -------- | ---------- | --- | -------------- | -------- | ------- | --- | --- | --- |
SPRETKED.,MANSMANNF.,ANDRIENKON.,ANDRIENKOG.:Sim-
| ber G. H., | (Eds.), | The Eurographics |     | Association, | pp. 19–23. | doi: |                       |                    |                          |
| ---------- | ------- | ---------------- | --- | ------------ | ---------- | ---- | --------------------- | ------------------ | ------------------------ |
|            |         |                  |     |              |            |      | pliFly: A methodology | for simplification | and thematic enhancement |
10.2312/envirvis.20151086.1,2,4 oftrajectories. VisualizationandComputerGraphics,IEEETransac-
|                                                                 |                                            |     |     |     |     |     | tionson21,1(Jan2015),107–121. |     | doi:10.1109/TVCG.2014. |
| --------------------------------------------------------------- | ------------------------------------------ | --- | --- | --- | --- | --- | ----------------------------- | --- | ---------------------- |
| [HSST12]                                                        | HASENFRATZD.,SAUKHO.,STURZENEGGERS.,THIELE |     |     |     |     |     |                               |     |                        |
| L.:Participatoryairpollutionmonitoringusingsmartphones.InMobile |                                            |     |     |     |     |     | 2337333.2,3                   |     |                        |
Sensing:FromSmartphonesandWearablestoBigData(Beijing,China, [WAK∗10] WILLETT W., AOKI P., KUMAR N., SUBRAMANIAN S.,
Apr2012),ACM.1 WOODRUFFA.: Commonsensecommunity:Scaffoldingmobilesens-
[HSvH∗14] ingandanalysisfornoviceusers. InPervasiveComputing,FloréenP.,
HEUSINKVELDB.G.,STEENEVELDG.J.,VANHOVEL.
W.A.,JACOBSC.M.J.,HOLTSLAGA.A.M.: Spatialvariabilityof KrügerA.,SpasojevicM.,(Eds.),vol.6030ofLectureNotesinCom-
theRotterdamurbanheatislandasinfluencedbyurbanlanduse.Journal puterScience.SpringerBerlinHeidelberg,2010,pp.301–318. doi:
10.1007/978-3-642-12654-3_18.1
| ofGeophysicalResearch:Atmospheres119,2(2014),677–692. |     |     |     |     |     | doi: |     |     |     |
| ----------------------------------------------------- | --- | --- | --- | --- | --- | ---- | --- | --- | --- |
10.1002/2012JD019399.1 [WBS13] WANG N., BIGGS T. W., SKUPIN A.: Visualizing gridded
[HSW∗14] HASENFRATZ D., SAUKH O., WALSER C., HUEGLIN C., timeseriesdatawithselforganizingmaps:Anapplicationtomulti-year
FIERZ M., THIELE L.: Pushing the spatio-temporal resolution limit snowdynamicsinthenorthernhemisphere. Computers,Environment
andUrbanSystems39,0(2013),107–120.doi:http://dx.doi.
| ofurbanairpollutionmaps. |     |     | InPervasiveComputingandCommunica- |     |     |     |     |     |     |
| ------------------------ | --- | --- | --------------------------------- | --- | --- | --- | --- | --- | --- |
org/10.1016/j.compenvurbsys.2012.10.005.2
tions(PerCom),2014IEEEInternationalConferenceon(March2014),
pp.69–77.doi:10.1109/PerCom.2014.6813946.1
| [KGB∗06]                                                | KOTTEKM.,GRIESERJ.,BECKC.,RUDOLFB.,RUBELF.: |     |     |     |                  |       |     |     |     |
| ------------------------------------------------------- | ------------------------------------------- | --- | --- | --- | ---------------- | ----- | --- | --- | --- |
| WorldmapoftheKöppen-Geigerclimateclassificationupdated. |                                             |     |     |     |                  | Mete- |     |     |     |
| orologischeZeitschrift15,3(2006),259–263.               |                                             |     |     |     | doi:doi:10.1127/ |       |     |     |     |
0941-2948/2006/0130.1
| [Koh90] KOHONEN |     | T.: The | self-organizing | map. | Proceedings | of the |     |     |     |
| --------------- | --- | ------- | --------------- | ---- | ----------- | ------ | --- | --- | --- |
IEEE78,9(Sep1990),1464–1480.doi:10.1109/5.58325.2
| [LBCP15] | LECONTEF.,BOUYERJ.,CLAVERIER.,PÉTRISSANSM.: |     |     |     |     |     |     |     |     |
| -------- | ------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
UsinglocalclimatezoneschemeforUHIassessment:Evaluationofthe
| methodusingmobilemeasurements. |     |     |     | BuildingandEnvironment83,0 |     |     |     |     |     |
| ------------------------------ | --- | --- | --- | -------------------------- | --- | --- | --- | --- | --- |
(2015),39–49.SpecialIssue:Climateadaptationincities.doi:http:
//dx.doi.org/10.1016/j.buildenv.2014.05.005.1
| [PLCC16]                                                     | PARECET.E.,LIJ.,CAMPBELLJ.B.,CARROLLD.: |      |         |                         |     | As- |     |     |     |
| ------------------------------------------------------------ | --------------------------------------- | ---- | ------- | ----------------------- | --- | --- | --- | --- | --- |
| sessingurbanlandscapevariables’contributionstomicroclimates. |                                         |      |         |                         |     | Ad- |     |     |     |
| vances in                                                    | Meteorology                             | 2016 | (2016), | 1–14. doi:10.1155/2016/ |     |     |     |     |     |
8736263.1
| [RNK11] RENC.,NGE.Y.-Y.,KATZSCHNERL.: |     |                                               |     |     | Urbanclimaticmap |     |     |     |     |
| ------------------------------------- | --- | --------------------------------------------- | --- | --- | ---------------- | --- | --- | --- | --- |
| studies:areview.                      |     | InternationalJournalofClimatology31,15(2011), |     |     |                  |     |     |     |     |
2213–2233.doi:10.1002/joc.2237.1
| [RSL∗12] | REN C., | SPIT | T., LENZHOLZER |     | S., YIM | H. L. S., |     |     |     |
| -------- | ------- | ---- | -------------- | --- | ------- | --------- | --- | --- | --- |
HEUSINKVELDB.,VANHOVEB.,CHENL.,KUPSKIS.,BURGHARDT
R.,KATZSCHNERL.:Urbanclimatemapsystemfordutchspatialplan-
ning. InternationalJournalofAppliedEarthObservationandGeoin-
| formation18(2012),207–221. |     |     | doi:http://dx.doi.org/10. |     |     |     |     |     |     |
| -------------------------- | --- | --- | ------------------------- | --- | --- | --- | --- | --- | --- |
1016/j.jag.2012.01.026.1
| [Sam69] SAMMONJ.: |     | Anonlinearmappingfordatastructureanalysis. |     |     |     |     |     |     |     |
| ----------------- | --- | ------------------------------------------ | --- | --- | --- | --- | --- | --- | --- |
Computers,IEEETransactionsonC-18,5(May1969),401–409.doi:
10.1109/T-C.1969.222678.3
| [SDF∗14]     | SAYRE      | R., DANGERMOND |        | J., FRYE    | C., VAUGHAN | R.,       |     |     |     |
| ------------ | ---------- | -------------- | ------ | ----------- | ----------- | --------- | --- | --- | --- |
| ANIELLO      | P., BREYER | S.,            | CRIBBS | D., HOPKINS | D., NAUMAN  | R.,       |     |     |     |
| DERRENBACHER |            | W., WRIGHT     | D.,    | BROWN C.,   | CONVIS      | C., SMITH |     |     |     |
J.,BENSONL.,VANSISTINED.P.,WARNERH.,CRESSJ.,DANIEL-
SONJ.,HAMANNS.,CECERET.,REDDYA.,BURTOND.,GROSSE
A.,TRUED.,METZGERM.,HARTMANNJ.,MOOSDORFN.,DÃIJRR
H.,PAGANINIM.,DEFOURNYP.,ARINOO.,MAYNARDS.,ANDER-
| SONM.,COMERP.: |     | Anewmapofglobalecologicallandunits–An |     |     |     |     |     |     |     |
| -------------- | --- | ------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
ecophysiographicstratificationapproach.AssociationofAmericanGe-
ographers,Wahington,DC,2014.1
(cid:13)c 2016TheAuthor(s)
| EurographicsProceedings(cid:13)c |     | 2016TheEurographicsAssociation. |     |     |     |     |     |     |     |
| -------------------------------- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- |
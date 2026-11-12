WorkshoponVisualisationinEnvironmentalSciences(EnvirVis)(2015)
A.MiddelandK.RinkandG.H.Weber(Editors)
Spatial Aggregation of Mobile Transect Measurements for the
Identification of Climatic Microenvironments
K.Häb†1,A.Middel2,B.L.Ruddell3andH.Hagen1
1ComputerGraphicsandHCIGroup,UniversityofKaiserslautern,Germany
2JulieAnnWrigleyGlobalInstituteofSustainability,ArizonaStateUniversity,Arizona,USA
3ThePolytechnicSchool,ArizonaStateUniversity,Arizona,USA
Abstract
Mobiletransectmeasurementsretrievehigh-resolutionobservationsrevealingthespatialvariationofatmospheric
propertiesthroughoutanurbanlandscape.Asensorplatformismovedthroughastudysitewithvaryingurban
form,collectingadatasetthatcanbeusedtoinvestigatethemultifacetedimpactsofdifferentbuildingandland-
scapeconfigurationsonatmosphericproperties.Togeneralizesuchfindings,itisimperativetoincludetransect
runsrepresentingdifferentpointsintimeandpotentiallydifferentmeteorologicalbackgroundconditions.How-
ever,theanalysisofasetofmobiletransectmeasurementrunsischallengingbecauseofthestrictspatio-temporal
dependenceandmultivariatenatureofeachrecordedsample.Inthisstudy,weprovidevisualsupportfortheiden-
tificationofcoherentclimaticmicroenvironmentswithinastudysiteusingmobiletransectmeasurementstakenat
differentpointsintimeandoverdiverseroutes.Aregulargridisusedtospatiallyaggregatethedata,andresulting
summariesareclassifiedaccordingtosimilarmultivariaterelationshipsusingclusteringtechniques.Finally,each
grid cell is visualized using a radial glyph encoding cluster membership, predominant wind direction for each
transectrun,andthenumberoftransectrunstraversingthisgridcell.Theapproachhasbeentestedusingadata
setrecordedinGilbert,Arizona,USA,anditshowspotentialtoidentifyspatiallycontiguousregionsofsimilar
microclimate.
CategoriesandSubjectDescriptors(accordingtoACMCCS): ComputerGraphics[I.3.8]:Applications—;Computer
Applications[J.2]:Earthandatmosphericsciences—
1. Introduction reasoningaboutcoherentlocalclimatezonesshowingasim-
ilarvaluedistributionovertime.Thesezonesshareacoher-
Mobiletransectmeasurementsarefrequentlyusedinurban
ent relationship between land use/land cover (LULC) and
climatology to gain insight into the spatial variation of at-
microclimate [SO12]. One approach to explore the multi-
mospheric properties. Based on the resulting observations,
variateandspatio-temporalinformationcontainedinamo-
conclusions can be drawn about the impact of urban form
biletransectdatasetcouldbetoextractamultivariatetime
onthesurroundingclimate[CPMB11,HSvH∗14,SBC∗09].
series for each sample location on a transect route, which
However,asingletransectisnotsufficienttogeneralizesuch
couldthenbeusedtopartitiontheunderlyingspaceintoseg-
findingsbecauseitrepresentsasinglemeteorologicalback-
mentsofsimilartemporalvaluedistribution.This,however,
groundcondition.Datahastobesampledrepeatedly,result-
isonlypossibleiftheobservationroutesarespatiallyidenti-
inginaspatiallydependent,multivariate,time-varyingdata
cal.
set,whichisdifficulttoanalyze.
Aggregation techniques can be used to reduce the com- This paper investigates an approach to comprehensively
plexity of a mobile measurement data set and to facilitate visualize data resulting from multiple transect runs over
diverse routes. The overall goal of the visualization is to
support the exploration of potential areas of similar multi-
† e-mail:kathrin.haeb@cs.uni-kl.de variate value behavior under varying meteorological back-
(cid:13)c TheEurographicsAssociation2015.
DOI: 10.2312/envirvis.20151086

20 K.Häbetal./SpatialAggregationofMobileTransectMeasurementsfortheIdentificationofClimaticMicroenvironments
ground conditions. The approach is based on the spatial ment data, Andrienko et al. [AAS∗12] classify spatial sit-
aggregation of multiple transect runs over a regular grid. uations by clustering feature vectors representing presence
| Multivariaterelationshipsareclassifiedseparatelyforeach |           |               |     |        |                 |     | countsperlocation. |     |     |     |     |     |
| ------------------------------------------------------- | --------- | ------------- | --- | ------ | --------------- | --- | ------------------ | --- | --- | --- | --- | --- |
| transect                                                | run using | a combination |     | of the | self-organizing |     |                    |     |     |     |     |     |
map(SOM)[Koh90]andthek-meansclusteringalgorithm
|               |     |           |            |     |        |         | 3. Methodology |     |     |     |     |     |
| ------------- | --- | --------- | ---------- | --- | ------ | ------- | -------------- | --- | --- | --- | --- | --- |
| [WBS13,VA00]. |     | Thus, per | grid cell, | we  | gain a | summary |                |     |     |     |     |     |
about the multivariate behavior of all observations taken 3.1. Spatialaggregationofmultivariatemobiletransect
measurements
withinthisspatialcompartment.Tovisuallyencodethisin-
formation,wedesignedaglyphthatrepresentsthenumber
Anaturalapproachtospatiallyaggregateasetoftrajectories
oftransectroutescrossingthegridcell,theirrespectiveclus-
istopartitionthespaceintocompartmentsandtosummarize
termembershipatthislocation,andthewinddirectionthat
datacollectedforeachofthesecompartments[AA08,Svd-
hasbeenpredominantduringdatacollectioninthefield.The
WvW14].Inoursolution,aregulargridisspannedoverthe
approachisimplementedintoTraVis,ourframeworkforthe boundingboxofalltransectroutes.Sincespatialscaleplays
visualizationofmobiletransectmeasurements[HMRH15].
|     |     |     |     |     |     |     | an important | role during | the | analysis, | the size | of the grid |
| --- | --- | --- | --- | --- | --- | --- | ------------ | ----------- | --- | --------- | -------- | ----------- |
cellscanbeadaptedtothescaleunderinvestigation(Fig.1).
2. Theoreticalbackgroundandrelatedwork The observations are averaged separately for each transect
|     |     |     |     |     |     |     | run and | each variable | over each | grid | cell. Furthermore, | to  |
| --- | --- | --- | --- | --- | --- | --- | ------- | ------------- | --------- | ---- | ------------------ | --- |
Mobiletransectmeasurementsareamultivariategeospatial guaranteecomparabilityofdatasampledatdifferentpoints
movementdataset.Thus,eachtransectisatrajectorywitha in time and data represented in different units, all samples
| setofspatiallocationsS={s |     |                         | ,...,sn},atimestampt |     |               | i ∈T |                                                    |     |     |     |     |     |
| ------------------------- | --- | ----------------------- | -------------------- | --- | ------------- | ---- | -------------------------------------------------- | --- | --- | --- | --- | --- |
|                           |     |                         | 0                    |     |               |      | belongingtoonetransectrunandonevariablearescaledto |     |     |     |     |     |
| associatedwitheachs       |     | i,andfurtherattributesA |                      |     | 0,...,m,whose |      |                                                    |     |     |     |     |     |
theinterval[0,1]basedontheirindividualvaluerange.
elementsareeitherstaticovertheentiretrajectoryorchange
| dynamicallywithSandT |     |                 | [AA08,TSAA12]. |          |              |         |     |     |     |     |     |     |
| -------------------- | --- | --------------- | -------------- | -------- | ------------ | ------- | --- | --- | --- | --- | --- | --- |
| Andrienko            | and | Andrienko       | [AA10]         | describe | a            | general |     |     |     |     |     |     |
| framework            | for | the aggregation | of             | movement | data         | sets.   |     |     |     |     |     |     |
| They distinguish     |     | two different   | views          | on       | movement:    | The     |     |     |     |     |     |     |
| trajectory-oriented  |     | view,           | which focuses  | on       | the movement |         |     |     |     |     |     |     |
ofsingleentities,andthesituation-orientedview,whichfo-
cusesonthestateoftheentitiesatoneormorepointsintime.
| For each         | of these | two views,  | they        | give recommendations |           |       |     |     |     |     |     |     |
| ---------------- | -------- | ----------- | ----------- | -------------------- | --------- | ----- | --- | --- | --- | --- | --- | --- |
| about applicable |          | aggregation | techniques, |                      | which are | again |     |     |     |     |     |     |
basedontwodifferentviewsofspace:Thespace-centered
view,focusingonthespaceinwhichthemovementoccurs,
andtheentity-centeredview,focusingonthemovementit-
|                 |     |                     |     |            |     |        | Figure1: | Aggregatingdataoveraregulargrid. |     |     |     |     |
| --------------- | --- | ------------------- | --- | ---------- | --- | ------ | -------- | -------------------------------- | --- | --- | --- | --- |
| self. According |     | to this theoretical |     | framework, | our | analy- |          |                                  |     |     |     |     |
sispurposecorrespondstothecategoryspace-centeredand
situation-oriented, since we are interested in the relation- Sincethetransectroutesvary,thenumberofmobilemea-
| ship between | trajectory | attributes |     | at certain | points | in time |     |     |     |     |     |     |
| ------------ | ---------- | ---------- | --- | ---------- | ------ | ------- | --- | --- | --- | --- | --- | --- |
surementrunstraversingagridcellalsovaries.Thus,anap-
andspace. propriateaggregationandvisualizationtechniquehastotake
thisasymmetryintoaccount.Sincetheoverallgoalofthis
| The traffic-oriented |     | view | on a | car data | set in | Milano |     |     |     |     |     |     |
| -------------------- | --- | ---- | ---- | -------- | ------ | ------ | --- | --- | --- | --- | --- | --- |
studyistoidentifyspatiallycoherentclimaticmicroenviron-
[AA08]iscloselyrelatedtoourvisualizationapproach.The
ments,dataisclusteredbasedonauser-definedsetofvari-
| authors suggest |     | to partition | the space | using | a regular | grid |     |     |     |     |     |     |
| --------------- | --- | ------------ | --------- | ----- | --------- | ---- | --- | --- | --- | --- | --- | --- |
ables.AcombinationoftheSOM[Koh90]andthek-means
andtoaggregatethedataovereachgridcell.Theaggrega-
clusteringalgorithmisappliedtofindasemanticallymean-
tionresultsarevisualizedusingeithersmallmultiplesshow-
|     |     |     |     |     |     |     | ingful structure | within | the data | set [VA00,WBS13]. |     | The |
| --- | --- | --- | --- | --- | --- | --- | ---------------- | ------ | -------- | ----------------- | --- | --- |
ingthefrequencyofcartraversespergridcellandtimestep,
SOMhasbeenimplementedroughlyfollowing[Koh90],us-
or–similartooursolution–usingradialglyphsthatencode
|             |           |              |     |            |           |     | ing a rectangular | grid. | The initial | cluster | centroids | for the |
| ----------- | --------- | ------------ | --- | ---------- | --------- | --- | ----------------- | ----- | ----------- | ------- | --------- | ------- |
| the traffic | intensity | per movement |     | direction. | Scheepens | et  |                   |       |             |         |           |         |
k-meansclusteringareselectedrandomly.
al.[SWVDWvW11,SWvdW∗11]combinemultipledensity
mapstoprovideacomprehensiveoverviewovermultivari- In previous work [HMRH15], this technique was suc-
atemovementdatasets.Inalaterstudy[SvdWvW14],they cessfully used to partition a single transect measurement
usepiechartsasglyphsontopofamaptosummarizethe run into segments of similar multivariate relationships. In
numberofcertainobjects,theirheading,andtheproportion the current study, we make use of this finding and use the
of stationary objects within a spatial compartment. Bak et cluster membership of each aggregated sample as a sum-
al. [BMJK09] aggregate their episodic movement data set mary measure for multivariate behavior at the correspond-
usinggrowth-ringmaps.Alsodealingwithepisodicmove- ingspatiallocation.SincetheSOMiscomputationallyex-
(cid:13)c TheEurographicsAssociation2015.

K.Häbetal./SpatialAggregationofMobileTransectMeasurementsfortheIdentificationofClimaticMicroenvironments 21
pensive,itistrainedbasedonone,user-definedexemplary for the appearance of a grid cell, the reliability of conclu-
transect run, and then partitioned using k-means cluster- sions drawn from this representation is reduced. Encoding
ing[VA00,WBS13].Thequalityofthepartitioncanbeex- the cluster membership for each transect traversing a grid
plored using a parallel coordinates plot, which shows the cellisalsomandatoryforthevisualization(R2)becauseit
clustering results as applied to the exemplary transect run. reveals information about multivariate relationships found
Inthisplot,classesarecolor-codedwithaqualitativecolor- at this location. The predominant wind direction for each
scheme [HB03] and can be brushed. If the user is not sat- transect traversing the grid cell (R3) can give further hints
isfiedwiththecurrentpartition,thenumberofclustercen- about the relationship between the values measured at this
troidsforthek-meansclusteringcanbeinteractivelyrefined. pointandtheLULCupwind.Thisholdsespeciallytruefor
Oncethepartitionoftheexemplarytransectrunisfinished, atmospheric attributes, whose spatial distribution is depen-
the clustering results are applied successively to all other dentonmixingprocesses[Sch94].Finally,thegridcellsize
transectsavailableinthedataset. (R4)hintsatthespatialresolutionoftheresultingaggrega-
tion.
Thedisadvantageofthisapproachliesinthepotentialsen-
sitivityoftheresultontheselectionofthefirst,"represen- Figure 2 shows our glyph design in a schematic way. A
tative"transectrun.Theoretically,ithastobechosenbased circularlayoutisused,sincethisdesignenablesustoeas-
on the number of distinct multivariate value combinations, ilyencodethepredominantwinddirectionatsamplingtime
which can then be classified appropriately and detected in (R3) by the orientation of sectors. These sectors are cre-
subsequentlyaddedruns.Apreliminarysensitivityanalysis ated by applying a fixed offset angle left and right of the
confirmedthishypothesis,andwearecurrentlyconducting vectorpointingintothewinddirection,whichisinourim-
furtherresearchonthisissue. plementationgivenbythepredominantwinddirectionmea-
sured at four weather stations surrounding the study site
[Mes15,HMRH15].Thenumberoftransectrunstraversing
3.2. Visualizationapproachandglyphdesign
thegridcellisencodedbythenumberofsectorsarranged
Tovisualizethisdataonamap,aglyphisassignedtoeach aroundaninnercircle,fulfillingR1.Colorcodingthesesec-
gridcellthathasbeencrossedatleastonce.Theglyphwas torsaccordingtotheclustermembershipfulfillsR2.Iftwo
carefullydesignedtoencodethe... sectorswouldoverlapduetosimilarwinddirectionsatsam-
pling time, the sector border between these two sectors is
• R1:...numberoftransectrunstraversingthegridcell.
movedtothehalf-anglebetweenthetworespectivewinddi-
• R2:...clustermembershipforeachtransecttraversingit.
rections.Thegridcellsize(R4)isproportionaltotheradius
• R3: ...predominant wind direction during the time the
of the circle, which also prevents spatially adjacent glyphs
transecthasbeenconducted.
fromoverlapping.
• R4:...gridcellsizeoverwhichthedatahasbeenaggre-
gated.
4. UseCase
The visualization was tested using a mobile transect mea-
surementdatasetcollectedinaresidentialneighborhoodin
Gilbert, Arizona, USA. The data set was recorded on four
differentdaysinMay2014,September2014,andFebruary
Color:
Cluster 2015.Itconsistsof21transectrunswithanaverageof4333
membership
sample points. For analysis, we considered five variables:
Surfacetemperature,1and2mairtemperature,and1and
2mrelativehumidity.
Predominantwind
direction As an exemplary transect run, we choose a run that has
beenconductedatSeptember15,2014,at0700LST.Ittra-
Fixed angle offset versesalongerroute,coveringapotentiallylargenumberof
Adaptedangle offset differentmultivariatevalueconfigurations.Thegridcellsize
ischosentobe30m.FortheSOM,weuseafieldof10x10
neuronsandletthetrainingrunoverN∗10iterations(N is
thenumberofgridcellstraversedbytheexemplarytransect
run).Then,weapplyak-meansclusteringover6clustercen-
Figure2: Glyphdesign. troids.Usingtheparallelcoordinatesplot,wefindthatthe
datawas well-partitionedintodistinctclasses ofmultivari-
aterelationships(Fig.3a).
The number of clusters (R1) has to be included into the
glyph to enhance the perception of uncertainty associated Then, we use the clustering results to classify the spa-
with the visualization. If only one sample is responsible tially aggregated data belonging to all other transect runs.
(cid:13)c TheEurographicsAssociation2015.

22 K.Häbetal./SpatialAggregationofMobileTransectMeasurementsfortheIdentificationofClimaticMicroenvironments
ad.. b.
Figure3:a.Brushedparallelcoordinatesplotstovisualizethemeaningoftheclusters.b.Theglyphscombiningtheentireset
ofmobiletransectmeasurementsonamap(backgroundmap:[Env12]).
Intheresultingvisualization(Fig.3b),wecanidentifysev- Forourfuturework,weplantoexplicitlyincorporatethe
eralpatterns:First,itisobviousthatthewindnevercomes positionofeachtransectinatemporalcycle,suchastimeof
from northerly directions. Second, red classes, associated dayortimeofyear,bothofwhicharemeteorologicallyrele-
withhighsurfacetemperatures,lowhumidities,andhighair vant.Sinceourglyphsdonotprovidesufficientspacetoad-
temperatures,appearfrequentlyoverasphaltedareasandbe- ditionallyencodethisinformation,weplantoaddafiltering
tweenarraysofhouses,aswouldbeexpectedforthiskindof capabilitythatcanbeusedtobrushtheglyphsonthemap.
environment.Third:Theyellowcluster,associatedwithlow Wearealsocurrentlyinvestigatingtheautomaticcomputa-
surfacetemperatures,highhumiditiesandrelativelylowair tionofcoherentmicroenvironmentsbasedonametricthat
temperatures,canpredominantlybefoundinparks. describes the similarity of the glyphs to each other. Based
onthismetric,wealsoaimatquantifyingthesensitivityof
Coherentclimaticmicroenvironmentscanqualitativelybe
thealgorithmtodifferentinputconfigurations.
identified by searching for patterns of predominant colors.
However,thisdoesnotnecessarilyholdtrueforglyphscom-
prisingalargenumberofdifferentcolors.Inthiscase,itis
Acknowledgements
notclear,whetherthedistinctclustersonlycorrespondtothe
wind direction alone or also to other meteorological back- The authors wish to thank the reviewers for their valuable
groundconditionsatsamplingtime,e.g.,becausethecom- comments, as well as the Arizona State University Envi-
partmentjoinsdatabelongingtodifferenttimesofadayor ronmentalRemoteSensingandGeoinformaticsLab(ERSG)
ayear. forprovidingtheNAIPdataset(additionalsupportwasfur-
nishedbytheGilbertF.WhiteEnvironmentandSocietyen-
5. ConclusionandFutureWork dowment. Source data: National Agriculture Imagery Pro-
gram(NAIP),http://www.fsa.usda.gov).Thisworkwassup-
In this paper, we described a visualization approach to vi-
ported in part by the NSF Grant SES-0951366, Decision
sually identify climatic microenvironments within a study
CenterforaDesertCityII:UrbanClimateAdaptation,NSF
site based on a number of mobile transect measurements.
EaSMProgramEF-1049251,theNSFLTERProgramBCS-
Wepartitionthespaceusingaregulargrid,beforeweaggre-
1026865,theSaltRiverProjectgranttoASU,AlanandSan-
gatethedataassociatedwitheachgridcellbyclassifyingit
draRuffalo,andthePowerRanchHomeownersAssociation.
accordingtomultivariaterelationshipsandvisualizeitusing
radialglyphs.Theglyphdesignenablesthesynchronousvi-
sualizationof(a)thenumberoftransectrunsthatcontributed
References
totheglyph,(b)thepredominantwinddirectionatrecording
time,(c)multivariaterelationships,and(d)thegridcellsize. [AA08] ANDRIENKOG.,ANDRIENKON.: Spatio-temporalag-
gregation for visual analysis of movements. In Visual Ana-
Itsupportsforminghypothesesabouttheimpactofurbande-
lytics Science and Technology, 2008. VAST ’08. IEEE Sympo-
signonmicroclimate,whilealsotakinglocaldatasparseness siumon(Oct2008),pp.51–58.doi:10.1109/VAST.2008.
intoaccount. 4677356.2
(cid:13)c TheEurographicsAssociation2015.

K.Häbetal./SpatialAggregationofMobileTransectMeasurementsfortheIdentificationofClimaticMicroenvironments 23
[AA10] ANDRIENKO G., ANDRIENKO N.: A gen- WIJK J.: Non-overlapping aggregated multivariate glyphs for
eral framework for using aggregation in visual explo- moving objects. In Pacific Visualization Symposium (Paci-
ration of movement data. The Cartographic Jour- ficVis),2014IEEE(March2014),pp.17–24. doi:10.1109/
nal 47, 1 (2010), 22–40. URL: http://dx.doi. PacificVis.2014.13.2
org/10.1179/000870409X12525737905042,
|     |     |     |     |     |     |     |     | [SWvdW∗11] | SCHEEPENSR.,WILLEMSN.,VANDEWETER- |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --------------------------------- | --- | --- | --- | --- |
doi:10.1179/000870409X12525737905042.2
INGH.,ANDRIENKOG.,ANDRIENKON.,VANWIJKJ.:Com-
[AAS∗12] ANDRIENKO N., ANDRIENKO G., STANGE H., positedensitymapsformultivariatetrajectories. Visualization
LIEBIG T., HECKER D.: Visual analytics for understand- and Computer Graphics, IEEE Transactions on 17, 12 (Dec
2011),2518–2527.doi:10.1109/TVCG.2011.181.2
| ing spatial | situations  |     | from episodic |          | movement | data. | KI -  |             |                                |     |     |     |     |
| ----------- | ----------- | --- | ------------- | -------- | -------- | ----- | ----- | ----------- | ------------------------------ | --- | --- | --- | --- |
| Künstliche  | Intelligenz |     | 26, 3 (2012), | 241–251. |          | URL:  | http: |             |                                |     |     |     |     |
|             |             |     |               |          |          |       |       | [SWVDWvW11] | SCHEEPENSR.,WILLEMSN.,VANDEWE- |     |     |     |     |
//dx.doi.org/10.1007/s13218-012-0177-4,doi:
TERINGH.,VANWIJKJ.:Interactivevisualizationofmultivari-
10.1007/s13218-012-0177-4.2
|     |     |     |     |     |     |     |     | ate trajectory | data with | density | maps. In | Pacific Visualization |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | --------- | ------- | -------- | --------------------- | --- |
[BMJK09] BAK P., MANSMANN F., JANETZKO H., KEIM D.: Symposium(PacificVis),2011IEEE(March2011),pp.147–154.
Spatiotemporalanalysisofsensorlogsusinggrowthringmaps. doi:10.1109/PACIFICVIS.2011.5742384.2
VisualizationandComputerGraphics,IEEETransactionson15,
|     |     |     |     |     |     |     |     | [TSAA12] TOMINSKI |     | C., SCHUMANN | H., | ANDRIENKO | G., |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | ------------ | --- | --------- | --- |
6(Nov2009),913–920.doi:10.1109/TVCG.2009.182.2
|     |     |     |     |     |     |     |     | ANDRIENKON.: | Stacking-basedvisualizationoftrajectoryat- |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ------------------------------------------ | --- | --- | --- | --- |
VisualizationandComputerGraphics,IEEETrans-
| [CPMB11] | CHOWW.T.,POPER.L.,MARTINC.A.,BRAZEL |     |     |     |     |     |     | tributedata. |     |     |     |     |     |
| -------- | ----------------------------------- | --- | --- | --- | --- | --- | --- | ------------ | --- | --- | --- | --- | --- |
A. J.: Observingandmodelingthenocturnalparkcoolisland actions on 18, 12 (Dec 2012), 2565–2574. doi:10.1109/
| ofanaridcity:horizontalandverticalimpacts. |     |     |     |     |     | Theoreticaland |     | TVCG.2012.265.2 |     |           |                |     |           |
| ------------------------------------------ | --- | --- | --- | --- | --- | -------------- | --- | --------------- | --- | --------- | -------------- | --- | --------- |
| AppliedClimatology103,1-2(2011),197–211.   |     |     |     |     |     | URL:http:      |     |                 |     |           |                |     |           |
|                                            |     |     |     |     |     |                |     | [VA00] VESANTO  | J., | ALHONIEMI | E.: Clustering | of  | the self- |
//dx.doi.org/10.1007/s00704-010-0293-8,doi: organizingmap. NeuralNetworks,IEEETransactionson11,3
10.1007/s00704-010-0293-8.1 (May2000),586–600.doi:10.1109/72.846731.2,3
| [Env12]   | ENVIRONMENTAL |     | REMOTE |       | SENSING |           | GEOIN- |              |     |          |            |                 |     |
| --------- | ------------- | --- | ------ | ----- | ------- | --------- | ------ | ------------ | --- | -------- | ---------- | --------------- | --- |
|           |               |     |        |       |         | AND       |        | [WBS13] WANG | N., | BIGGS T. | W., SKUPIN | A.: Visualizing |     |
| FORMATICS | LAB           | AND | CAP    | LTER: | 4 band  | NAIP land | clas-  |              |     |          |            |                 |     |
griddedtimeseriesdatawithselforganizingmaps:Anapplica-
sificationofCentralArizona,2012.ArizonaStateUniversity.4 tion to multi-year snow dynamics in the northern hemisphere.
|        |                      |     |     |     |                       |     |     | Computers, | Environment | and | Urban Systems | 39, 0 | (2013), |
| ------ | -------------------- | --- | --- | --- | --------------------- | --- | --- | ---------- | ----------- | --- | ------------- | ----- | ------- |
| [HB03] | HARROWERM.,BREWERC.: |     |     |     | ColorBrewer.org:Anon- |     |     |            |             |     |               |       |         |
line tool for selecting colour schemes for maps. The Carto- 107 – 120. URL: http://www.sciencedirect.com/
graphic Journal 40, 1 (Jun 2003), 27–37. doi:10.1179/ science/article/pii/S0198971512000919, doi:
000870403235002042.3 http://dx.doi.org/10.1016/j.compenvurbsys.
2012.10.005.2,3
| [HMRH15] | HÄBK.,MIDDELA.,RUDDELLB.L.,HAGENH.: |     |     |     |     |     |     |     |     |     |     |     |     |
| -------- | ----------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Travis–avisualizationframeworkformobiletransectdatasets
| inanurbanmicroclimatecontext. |     |     |     | InPacificVisualizationSym- |     |     |     |     |     |     |     |     |     |
| ----------------------------- | --- | --- | --- | -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
posium(PacificVis),2015IEEE(April2015).2,3
[HSvH∗14]
|                                         | HEUSINKVELD |            | B.            | G., STEENEVELD |          | G.             | J., VAN |     |     |     |     |     |     |
| --------------------------------------- | ----------- | ---------- | ------------- | -------------- | -------- | -------------- | ------- | --- | --- | --- | --- | --- | --- |
| HOVE                                    | L. W.       | A., JACOBS | C.            | M. J.,         | HOLTSLAG | A.             | A. M.:  |     |     |     |     |     |     |
| Spatial                                 | variability | of         | the Rotterdam |                | urban    | heat island    | as      |     |     |     |     |     |     |
| influenced                              | by          | urban      | land use.     |                | Journal  | of Geophysical |         |     |     |     |     |     |     |
| Research:                               | Atmospheres |            | 119,          | 2 (2014),      | 677–692. |                | URL:    |     |     |     |     |     |     |
| http://dx.doi.org/10.1002/2012JD019399, |             |            |               |                |          |                | doi:    |     |     |     |     |     |     |
10.1002/2012JD019399.1
| [Koh90]                           | KOHONEN | T.: | Theself-organizingmap. |     |                | Proceedings |     |     |     |     |     |     |     |
| --------------------------------- | ------- | --- | ---------------------- | --- | -------------- | ----------- | --- | --- | --- | --- | --- | --- | --- |
| oftheIEEE78,9(Sep1990),1464–1480. |         |     |                        |     | doi:10.1109/5. |             |     |     |     |     |     |     |     |
58325.2
| [Mes15] | MESOWEST |     | / UNIVERSITY |     | UTAH: | MesoWest |     |     |     |     |     |     |     |
| ------- | -------- | --- | ------------ | --- | ----- | -------- | --- | --- | --- | --- | --- | --- | --- |
OF
| data. | Online: | http://mesowest.utah.edu/, |     |     | 2015. | Last accessed: |     |     |     |     |     |     |     |
| ----- | ------- | -------------------------- | --- | --- | ----- | -------------- | --- | --- | --- | --- | --- | --- | --- |
02/10/2015.URL:http://mesowest.utah.edu/.3
[SBC∗09]
SUNC.-Y.,BRAZELA.J.,CHOWW.T.,HEDQUIST
| B.C.,PRASHADL.: |             |            | Desertheatislandstudyinwinterbymo- |             |          |             |       |     |     |     |     |     |     |
| --------------- | ----------- | ---------- | ---------------------------------- | ----------- | -------- | ----------- | ----- | --- | --- | --- | --- | --- | --- |
| bile transect   |             | and remote | sensing                            | techniques. |          | Theoretical | and   |     |     |     |     |     |     |
| Applied         | Climatology | 98,        | 3-4                                | (2009),     | 323–335. | URL:        | http: |     |     |     |     |     |     |
//dx.doi.org/10.1007/s00704-009-0120-2,doi:
10.1007/s00704-009-0120-2.1
| [Sch94] | SCHMID                                | H.: | Source      | areas | for scalars   | and      | scalar |     |     |     |     |     |     |
| ------- | ------------------------------------- | --- | ----------- | ----- | ------------- | -------- | ------ | --- | --- | --- | --- | --- | --- |
| fluxes. | Boundary-Layer                        |     | Meteorology |       | 67, 3 (1994), | 293–318. |        |     |     |     |     |     |     |
| URL:    | http://dx.doi.org/10.1007/BF00713146, |     |             |       |               |          |        |     |     |     |     |     |     |
doi:10.1007/BF00713146.3
| [SO12]    | STEWART     | I. D.,   | OKE        | T. R.:     | Local climate   | zones | for    |     |     |     |     |     |     |
| --------- | ----------- | -------- | ---------- | ---------- | --------------- | ----- | ------ | --- | --- | --- | --- | --- | --- |
| urban     | temperature | studies. | Bulletin   |            | of the American |       | Meteo- |     |     |     |     |     |     |
| rological | Society     | 93,      | 12 (2012), | 1879–1900. |                 | URL:  | http:  |     |     |     |     |     |     |
//dx.doi.org/10.1175/BAMS-D-11-00019.1,doi:
doi:10.1175/BAMS-D-11-00019.1.1
| [SvdWvW14] |     | SCHEEPENS | R., | VAN DE | WETERING | H., | VAN |     |     |     |     |     |     |
| ---------- | --- | --------- | --- | ------ | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:13)c TheEurographicsAssociation2015.
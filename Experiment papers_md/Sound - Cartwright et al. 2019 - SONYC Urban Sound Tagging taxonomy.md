DetectionandClassificationofAcousticScenesandEvents2019 25–26October2019,NewYork,NY,USA
SONYCURBANSOUNDTAGGING(SONYC-UST):
AMULTILABELDATASETFROMANURBANACOUSTICSENSORNETWORK
MarkCartwright1,2,3∗,AnaElisaMendezMendez1,JasonCramer1,VincentLostanlen1,2,4,
GrahamDove6,Ho-HsiangWu1,JustinSalamon5,OdedNov6,andJuanPabloBello1,2,3
|     |     | 1   | MusicandAudioResarchLab,NewYorkUniversity,NY,USA |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------------------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
2 CenterforUrbanScienceandProgress,NewYorkUniversity,NY,USA
3 DepartmentofComputerScienceandEngineering,NewYorkUniversity,NY,USA
4 CornellLabofOrnithology,CornellUniversity,NY,USA
5 AdobeResearch,SanFrancisco,CA,USA
6 DepartmentofTechnologyManagementandInnovation,NewYorkUniversity,NY,USA
ABSTRACT Oneofitsaimsistomapthespatiotemporaldistributionofnoise
|     |     |     |     |     |     |     | at the scale | of a | megacity | like | New York | City, | in real | time, and |
| --- | --- | --- | --- | --- | --- | --- | ------------ | ---- | -------- | ---- | -------- | ----- | ------- | --------- |
SONYCUrbanSoundTagging(SONYC-UST)isadatasetforthe
|     |     |     |     |     |     |     | throughout | multiple | years. | With | such | a map, city | officials | could |
| --- | --- | --- | --- | --- | --- | --- | ---------- | -------- | ------ | ---- | ---- | ----------- | --------- | ----- |
developmentandevaluationofmachinelisteningsystemsforreal-
|                            |     |     |                                 |     |     |     | better understand |                 | noise | in the      | city; more | effectively | allocate   | city    |
| -------------------------- | --- | --- | ------------------------------- | --- | --- | --- | ----------------- | --------------- | ----- | ----------- | ---------- | ----------- | ---------- | ------- |
| worldurbannoisemonitoring. |     |     | Itconsistsof3068audiorecordings |     |     |     |                   |                 |       |             |            |             |            |         |
|                            |     |     |                                 |     |     |     | resources         | for mitigation; |       | and develop |            | informed    | mitigation | strate- |
from the “Sounds of New York City” (SONYC) acoustic sensor gies while alleviating the biases inherent to complaint-driven ap-
network. Via the Zooniverse citizen science platform, volunteers proaches. To this end, SONYC has designed an acoustic sensor
taggedthepresenceof23fine-grainedclassesthatwerechosenin fornoisepollutionmonitoringthatcombinesrelativelyhighquality
consultationwiththeNewYorkCityDepartmentofEnvironmen- sound acquisition with a relatively low production cost [5]. Be-
| tal Protection. | These | 23 fine-grained |     | classes can | be grouped | into |     |     |     |     |     |     |     |     |
| --------------- | ----- | --------------- | --- | ----------- | ---------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
tween2016and2019,over50differentsensorshavebeenassem-
| eightcoarse-grainedclasses. |     |     | Inthiswork,wedescribethecollec- |     |     |     |     |     |     |     |     |     |     |     |
| --------------------------- | --- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
bledanddeployedinvariousareasofNewYorkCity.
| tionofthisdataset, |     | metricsusedtoevaluatetaggingsystems, |     |     |     | and |     |     |     |     |     |     |     |     |
| ------------------ | --- | ------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
EachSONYCsensormeasuresthesoundpressurelevel(SPL)
theresultsofasimplebaselinemodel.
ofitsimmediatevicinity,butitdoesnotinferandreportthecauses
IndexTerms— Audiodatabases,Urbannoisepollution,Sound of changes in SPL. From a perceptual standpoint, not all sources
eventdetection of outdoor noise are equally unpleasant, nor are they equally en-
|     |     |     |     |     |     |     | forcible with | respect | to  | the noise | code. | Therefore, | it is | necessary |
| --- | --- | --- | --- | --- | --- | --- | ------------- | ------- | --- | --------- | ----- | ---------- | ----- | --------- |
toresorttocomputationalmethodsfordetectionandclassification
1. INTRODUCTION ofacousticscenesandevents(DCASE)inthecontextofautomated
|     |     |     |     |     |     |     | noisepollutionmonitoring. |     |     | Toaddressthis, |     | thesensorshavealso |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- | -------------- | --- | ------------------ | --- | --- |
Noisepollutionisamajorconcernforurbanresidentsandhasneg-
|               |               |        |     |                    |     |            | been collecting |     | non-contiguous |     | 10 s audio | recordings |     | during de- |
| ------------- | ------------- | ------ | --- | ------------------ | --- | ---------- | --------------- | --- | -------------- | --- | ---------- | ---------- | --- | ---------- |
| ative effects | on residents’ | health | [1, | 2, 3] and learning |     | [2, 4]. To |                 |     |                |     |            |            |     |            |
ploymentandhavecollectivelygatheredover100Mrecordings.
| mitigate the | recurrence | of harmful |     | sounds, the City | of  | New York |     |     |     |     |     |     |     |     |
| ------------ | ---------- | ---------- | --- | ---------------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
Thereareseveralattributesofurbansoundeventdetectionthat
| employs a | legal enforcement |     | strategy | guided by | a “noise | code”. |                         |     |     |                                   |     |     |     |     |
| --------- | ----------------- | --- | -------- | --------- | -------- | ------ | ----------------------- | --- | --- | --------------------------------- | --- | --- | --- | --- |
|           |                   |     |          |           |          |        | makeitachallengingtask. |     |     | Soundsourcesofinterestareoftenfar |     |     |     |     |
Forexample,jackhammerscanonlyoperateonweekdays;petown-
awayfromthesensors.Severalsourcesofinterestmayoccursimul-
ersareheldaccountablefortheiranimals’noises;icecreamtrucks
taneously.Manysoundclassesseemquitesimilar,yetaredistinctin
| mayonlyplaytheirjingleswhileinmotion; |     |     |     | blastingacarhornis |     |     |     |     |     |     |     |     |     |     |
| ------------------------------------- | --- | --- | --- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
thenoisecodeandsoshouldbeidentifiedassuch.Manyotherdis-
| restricted | to situations | of imminent |     | danger. After | a city | resident |     |     |     |     |     |     |     |     |
| ---------- | ------------- | ----------- | --- | ------------- | ------ | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
tractorsoundsoccurwithinurbansoundrecordings.Andlastly,the
complainsaboutnoise,theNewYorkCityDepartmentofEnviron-
mentalProtection(DEP)sendsaninspectortoinvestigatethecom- acousticenvironmentchangesbylocationandbytimewithinsea-
sonalcycles.Duetothecomplexityofthisproblem,itisimportant
plaint. Iftheinspectorisabletoconfirmthattheoffendingnoise
toevaluatemachinelisteningsystemsformonitoringurbannoisein
| violates the | noise | code, they | incentivize | the manager | of  | the noise |     |     |     |     |     |     |     |     |
| ------------ | ----- | ---------- | ----------- | ----------- | --- | --------- | --- | --- | --- | --- | --- | --- | --- | --- |
realisticscenarios,usingactualrecordingsfromurbannoisesensors
sourcetoreducetheirnoisefootprintincompliancewiththecode.
andalabelspacethatmatchestheneedsofcityagencies.
Unfortunately,thiscomplaint-drivenenforcementapproachresults
|     |     |     |     |     |     |     | In this | article, | we  | present | the SONYC | Urban | Sound | Tag- |
| --- | --- | --- | --- | --- | --- | --- | ------- | -------- | --- | ------- | --------- | ----- | ----- | ---- |
inamitigationresponsebiasedtoneighborhoodswhocomplainthe
|     |     |     |     |     |     |     | ging (SONYC-UST) |     | dataset1, |     | which contains | 3068 | annotated | 10  |
| --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | --------- | --- | -------------- | ---- | --------- | --- |
most,notnecessarilytheareasinwhichnoisecausesthemostharm.
srecordingsfromtheSONYCacousticsensornetworkandwhich
Inaddition,duetothetransientnatureofsound,theoffendingnoise
|     |     |     |     |     |     |     | served as | the dataset | for | the DCASE | 2019 | Urban | Sound | Tagging |
| --- | --- | --- | --- | --- | --- | --- | --------- | ----------- | --- | --------- | ---- | ----- | ----- | ------- |
sourcemayhavealreadyceasedbythetimeaninspectorarriveson
|     |     |     |     |     |     |     | Challenge2. | Each | recording | has | been | annotated | using | a set of 23 |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ---- | --------- | --- | ---- | --------- | ----- | ----------- |
sitetoinvestigatethecomplaint.
SoundsofNewYorkCity(SONYC)isaresearchprojectinves- “tags”, which was developed in coordination with the New York
tigatingdata-drivenapproachestomitigatingurbannoisepollution. CityDepartmentofEnvironmentalProtection(DEP)andrepresents
∗ThisworkwaspartiallyfundedbyNationalScienceFoundationawards 1Downloadthedataathttps://doi.org/10.5281/zenodo.3338310
1633259and1544753 2http://dcase.community/challenge2019/task-urban-sound-tagging

DetectionandClassificationofAcousticScenesandEvents2019 25–26October2019,NewYork,NY,USA
|     |     |     |     |     |     | they were | limited | to those | that seem | likely | discernible |     | by novice |
| --- | --- | --- | --- | --- | --- | --------- | ------- | -------- | --------- | ------ | ----------- | --- | --------- |
annotators;andwekeptthenumberofcategoriessmallenoughso
thattheycanallbevisibleatonceinanannotationinterface.
3. DATACOLLECTION
|     |     |     |     |     |     | The SONYC | acoustic | sensor | network |     | consists | of more | than 50 |
| --- | --- | --- | --- | --- | --- | --------- | -------- | ------ | ------- | --- | -------- | ------- | ------- |
acousticsensorsdeployedaroundNewYorkCityandhasrecorded
|     |     |     |     |     |     | over 100M         | 10-second | audio     | clips       | since         | its launch | in 2016.    | The  |
| --- | --- | --- | --- | --- | --- | ----------------- | --------- | --------- | ----------- | ------------- | ---------- | ----------- | ---- |
|     |     |     |     |     |     | sensors are       | located   | in the    | Manhattan,  | Brooklyn,     |            | and Queens  | bor- |
|     |     |     |     |     |     | oughs of          | New York, | with      | the highest | concentration |            | around      | New  |
|     |     |     |     |     |     | York University’s |           | Manhattan | campus.     | To            | maintain   | the privacy | of   |
bystanders’conversations,thenetwork’ssensorsarepositionedfor
far-fieldrecording,15–25feetabovetheground,andrecordaudio
clipsatrandomintervals,ratherthancontinuously.
|     |     |     |     |     |     | Toannotatethesensorrecordings, |               |       |           | welaunchedanannotation |                 |     |           |
| --- | --- | --- | --- | --- | --- | ------------------------------ | ------------- | ----- | --------- | ---------------------- | --------------- | --- | --------- |
|     |     |     |     |     |     | campaign                       | on Zooniverse |       | [15, 16], | the largest            | citizen-science |     | plat-     |
|     |     |     |     |     |     | form. In                       | a previous    | study | comparing | multiple               | types           | of  | weak an-  |
|     |     |     |     |     |     | notation                       | tasks, we     | found | that full | multi-label            | annotation      |     | (i.e., an |
annotationtaskinwhichallclassesareannotatedatoncebyeach
|     |     |     |     |     |     | annotator)      | with at     | least three                                | annotators |            | per recording | resulted | in      |
| --- | --- | --- | --- | --- | --- | --------------- | ----------- | ------------------------------------------ | ---------- | ---------- | ------------- | -------- | ------- |
|     |     |     |     |     |     | high quality    | annotations |                                            | and high   | throughput | with          | citizen  | science |
|     |     |     |     |     |     | volunteers[17]. |             | Inanotherpreviousstudy,wefoundthatspectro- |            |            |               |          |         |
gramvisualizationsaidedannotatorsinproducinghighqualityan-
Figure1:HierarchicaltaxonomyoftheSONYCUrbanSoundTag-
|                         |     |                                 |     |     |     | notations[18]. | Giventhesefindings,weconfiguredtheannotation |     |     |     |     |     |     |
| ----------------------- | --- | ------------------------------- | --- | --- | --- | -------------- | -------------------------------------------- | --- | --- | --- | --- | --- | --- |
| ging(SONYC-UST)dataset. |     | Rectangularandroundboxesrespec- |     |     |     |                |                                              |     |     |     |     |     |     |
taskasamulti-label,weakannotation(i.e.,tagging)taskinwhich
tivelydenotecoarseandfineurbansoundtags.
theannotatorswerepresentedwithaspectrogramvisualizationof
theaudioclipalongwiththeaudioplayback.
|     |     |     |     |     |     | After | presenting | volunteers |     | with instructions |     | explaining | the |
| --- | --- | --- | --- | --- | --- | ----- | ---------- | ---------- | --- | ----------------- | --- | ---------- | --- |
manyofthefrequentcausesofnoisecomplaintsinNewYorkCity.
taskandafieldguidedescribingtheSONYC-USTclasses,weasked
Existingdatasetsforurbannoisemonitoringdonotaccurately
|     |     |     |     |     |     | them to annotate |     | the presence | of  | all of | the fine-level | classes | in a |
| --- | --- | --- | --- | --- | --- | ---------------- | --- | ------------ | --- | ------ | -------------- | ------- | ---- |
representtheproblemofurbannoisemonitoring.Thefreefield1010
|                 |                    |     |          |           |     | recording. | Foreverycoarse-levelclass(e.g.,alertsignal)wealso |     |     |     |     |     |     |
| --------------- | ------------------ | --- | -------- | --------- | --- | ---------- | ------------------------------------------------- | --- | --- | --- | --- | --- | --- |
| [6], UrbanSound | [7], UrbanSound8k, |     | [7], and | Urban-SED | [8] |            |                                                   |     |     |     |     |     |     |
includedafine-levelother/unknownclass(e.g.,other/unknownalert
datasetscontainrecordingscuratedfromFreesound[9]ratherthan
|                                              |     |     |     |                  |     | signal) with                                           | the | goal of | capturing | an annotator’s |     | uncertainty | in a    |
| -------------------------------------------- | --- | --- | --- | ---------------- | --- | ------------------------------------------------------ | --- | ------- | --------- | -------------- | --- | ----------- | ------- |
| recordedinarealisticnoisemonitoringscenario. |     |     |     | Inaddition,these |     |                                                        |     |         |           |                |     |             |         |
|                                              |     |     |     |                  |     | fine-leveltagwhilestillannotatingthecoarse-levelclass. |     |         |           |                |     |             | Ifanan- |
datasetsaremulti-class,inwhichonlythepredominantsoundclass
notatormarkedasoundclassaspresentintherecording,theywere
| is labeled. | The exception is | Urban-SED | [8], | which does | have |     |     |     |     |     |     |     |     |
| ----------- | ---------------- | --------- | ---- | ---------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
alsoaskedtoannotatetheproximityofthesoundevent(near,far,
strong,multi-labelannotations,butitisasyntheticdatasetthatisnot
|     |     |     |     |     |     | not sure). | Volunteers | could | annotate | as  | many recordings |     | as were |
| --- | --- | --- | --- | --- | --- | ---------- | ---------- | ----- | -------- | --- | --------------- | --- | ------- |
representativeofactualurbansoundscapes.TheTUTSoundEvents
available.
2016[10,11,12]and2017[13,14]datsetsconsistsofaudiorecord-
Manuallyannotatingall100M+oftheunlabeledsensorrecord-
ingsinrealurbanenvironmentsaswellasprovidingstrong,multi-
ingsisnotfeasible,butannotatingarandomsampleisnotefficient
labelannotations.However,thesedatasetshavelabelsetslimitedto
|     |     |     |     |     |     | sincemanyofthemmaynotcontainsoundeventsofinterest. |     |     |     |     |     |     | To  |
| --- | --- | --- | --- | --- | --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
humanpresenceandtraffic,andtheirspatiotemporalcontextislim-
addressthis,wesamplesensorrecordingsthataremostsimilarto
| ited to a handful | of times and | locations. | SONYC-UST |     | addresses |             |              |     |           |      |             |        |        |
| ----------------- | ------------ | ---------- | --------- | --- | --------- | ----------- | ------------ | --- | --------- | ---- | ----------- | ------ | ------ |
|                   |              |            |           |     |           | a small set | of exemplary |     | clips for | each | sound class | in our | taxon- |
theselimitationsbyprovidingrecordingsfromurbannoisesensors
omy.TheexemplaryclipswerecuratedfromYouTubeandselected
acrossavarietyoftimesandlocations,andbymorecloselymatch-
basedonthepresenceofthetargetclassintheaudioalongwithvi-
ingthelabelsettotheneedsofnoiseenforcementagencies.
|     |     |     |     |     |     | sualconfirmationfromthevideo. |     |     |     | Similaritytotheexemplaryclips |     |     |     |
| --- | --- | --- | --- | --- | --- | ----------------------------- | --- | --- | --- | ----------------------------- | --- | --- | --- |
wascomputedusingadistancefunctionD,whichcomparesasen-
|     |     |     |     |     |     | sorrecordingtoM |     | exemplaryclipsforaparticularclass: |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --------------- | --- | ---------------------------------- | --- | --- | --- | --- | --- |
2. SONYC-USTTAXONOMY
|     |     |     |     |     |     |     |     |     | (cid:88) 1 | (cid:88) Km |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ----------- | --- | --- | --- |
ThroughconsultationwiththeNewYorkDepartmentofEnviron- D(X(c),y )= mind(x(c) ,y )2 (1)
|     |     |     |     |     |     |     |     | n   |     |     | m,k | n,j |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
mental Protection (DEP) and the New York noise code, we con- K m j
|                                                               |                 |       |          |      |           |             |        |            | m    | k         |     |          |         |
| ------------------------------------------------------------- | --------------- | ----- | -------- | ---- | --------- | ----------- | ------ | ---------- | ---- | --------- | --- | -------- | ------- |
| structed a small,                                             | two-level urban | sound | taxonomy | (see | Figure 1) |             |        |            |      |           |     |          |         |
|                                                               |                 |       |          |      |           | where x (c) | is the | kth VGGish | [19] | embedding |     | frame of | the mth |
| consistingof8coarse-leveland23fine-levelsoundcategories,e.g., |                 |       |          |      |           | m           | ,k     |            |      |           |     |          |         |
X(c)
thecoarsealertsignalscategorycontainsfourfine-levelcategories: exampleclip(fromclassc)withK m frames, representsthe
isthejthVGGishembedding
reversebeeper,caralarm,carhorn,siren.UnliketheUrbanSound M exemplaryclipsfromclassc,y n,j
frameofthenthsensorrecordingy
Taxonomy [7], this taxonomy is not intended to provide a frame- ,anddistheEuclideandistance
n
| work for exhaustive | description | of urban | sounds. | Instead, | it was | function. |     |     |     |     |     |     |     |
| ------------------- | ----------- | -------- | ------- | -------- | ------ | --------- | --- | --- | --- | --- | --- | --- | --- |
scopedtoprovideactionableinformationtotheDEP,whilealsobe- The SONYC-UST dataset contains annotated train, validate,
ingunderstandableandmanageablefornoviceannotators.Thecho- and test splits (2351 / 443 / 274 recordings respectively). We se-
sensoundcategoriesmaptocategoriesofinterestinthenoisecode; lectedthesesplitssuchthatrecordingsfromthesamesensorswould

DetectionandClassificationofAcousticScenesandEvents2019 25–26October2019,NewYork,NY,USA
Figure 2: SONYC-USTtag distribution normalized for eachsplit, in decreasing order of frequency in thetrain split. The shadesof blue
indicatehowmanyannotatorstaggedtheclassinatrainingsetrecording,i.e.darkershadesofblueindicatehigherannotatoragreement.
|     |     |     |     |     | Estimator: |     | Annotators |     | BaselineModel |     |
| --- | --- | --- | --- | --- | ---------- | --- | ---------- | --- | ------------- | --- |
notappearinboththetrainandvalidatesets,andsuchthatthedistri-
|     |     |     |     |     | Split: |     | Validate | Test | Validate | Test |
| --- | --- | --- | --- | --- | ------ | --- | -------- | ---- | -------- | ---- |
butionsofcitizen-science-providedlabelsweresimilarforboththe
|                                   |     |     |                        |     | Level: |     | F C | F C | F   | C F C |
| --------------------------------- | --- | --- | ---------------------- | --- | ------ | --- | --- | --- | --- | ----- |
| trainandvalidatesets(seeFigure2). |     |     | Whiledoingso,weconsid- |     |        |     |     |     |     |       |
Overall
eredaclasspresentinasampleifatleastoneofthethreevolunteers
|     |     |     |     |     | AUPRC | .73 | .87 | .75 .90 | .67 .77 | .62 .76 |
| --- | --- | --- | --- | --- | ----- | --- | --- | ------- | ------- | ------- |
annotateditassuch.35sensorswereassignedtothetrainingsetand
|     |     |     |     |     | F1@0.5 | .68 | .83 | .68 .84 | .50 .70 | .43 .67 |
| --- | --- | --- | --- | --- | ------ | --- | --- | ------- | ------- | ------- |
8sensorsassignedtothevalidateset.Unlikethetrain/validatesets,
ClassF1@0.5
thetestsetisnotdisjointintermsofsensors,butratheritisdisjoint Engine .64 .94 .64 .94 .37 .79 .29 .76
intime—allrecordingsinthetestsetareposteriortothoseinthe Mech.imp. .25 .24 .32 .35 .29 .36 .62 .58
train/validatesets. Thisallowsustoevaluatemodelgeneralization Non-mech.imp. .49 .49 .60 .60 .05 .02 .00 .11
toknownlocationsatunseentimes. Poweredsaw .47 .70 .28 .62 .30 .66 .45 .66
|     |     |     |     |     | Alertsignal | .88 | .95 | .87 .92 | .48 .67 | .35 .48 |
| --- | --- | --- | --- | --- | ----------- | --- | --- | ------- | ------- | ------- |
InadditiontothecrowdsourcedannotationsfromZooniverse, Music .59 .76 .52 .76 .07 .07 .00 .00
we include “SONYC-team-verified” labels for both the valida- Humanvoice .82 .95 .82 .96 .77 .84 .63 .77
tion and test splits. To create verified labels, we first distributed Dog .74 .74 .96 .96 .00 .00 .66 .66
recordingsbasedoncoarse-levelsoundcategorytomembersofthe
SONYCresearchteamforlabeling.Todeterminewhetherarecord-
Table1:TheperformanceoftheZooniverseannotations(usingmi-
| ing belonged | to a specific | category for | the validation | process, we |     |     |     |     |     |     |
| ------------ | ------------- | ------------ | -------------- | ----------- | --- | --- | --- | --- | --- | --- |
norityvoteaggregation)andthebaselineclassifierascomparedthe
| selected | those that had been | annotated | by at least | one volunteer. |     |     |     |     |     |     |
| -------- | ------------------- | --------- | ----------- | -------------- | --- | --- | --- | --- | --- | --- |
theground-truthannotationsforbothvalidateandtestsplitsonthe
| Next, two | members of | our team labeled | each category | indepen- |            |          |             |       |            |             |
| --------- | ---------- | ---------------- | ------------- | -------- | ---------- | -------- | ----------- | ----- | ---------- | ----------- |
|           |            |                  |               |          | coarse (C) | and fine | (F) levels. | AUPRC | and F1 are | both micro- |
dently.Onceeachmemberhadfinishedlabelingtheirassignedcat-
averaged.
egories,thetwoannotatorsforeachclassdiscussedandresolvedla-
beldisagreementsthatoccurredduringtheindependentannotation
process. Weusetheseagreed-upon“SONYC-team-verified”labels
asthe“groundtruth”whenevaluatingmodels.Wealsousethesela- notations and the agreed-upon ground-truth class-presence labels
belstoevaluatetheannotationsfromZooniverse,aggregatedusing for the validate and test sets. All annotations also include identi-
minorityvote,whichwehavepreviouslyshowntobeaneffective fiersforboththeannotatorandthesensorfromwhichtheclipwas
aggregationstrategyinthiscontext[17]. Toaggregatewithminor- recorded. Thecoarse-levelindicatorsofclasspresencearealsoin-
ityvote,wesimplycountapositiveforatagifatleastoneannotator cludedandarecomputedbylogicaldisjunctionoverthefine-level
class-presencetagsassociatedwiththecoarse-levelcategory.
haslabeledtheaudioclipwiththattag.InTable1,wepresentanno-
tationaccuracyresultsusingthemetricsdescribedSection4.When
examiningtheclass-wiseF1scores,weseethatcrowdsourcedan- 4. MULTILABELCLASSIFICATIONMETRICS
notationsscorewellagainsttheground-truthformanyclasses,butit
seemstheZooniverseannotatorshavedifficultyidentifyingimpact other/unknown
|     |     |     |     |     | Due to the | presence | of  | tags, | SONYC-UST | has an |
| --- | --- | --- | --- | --- | ---------- | -------- | --- | ----- | --------- | ------ |
soundsandpoweredsaws,especiallywhendiscriminatingbetween
incompletegroundtruthatthefinetaxonomicallevel.Suchincom-
fine-levelclasses.
|     |     |     |     |     | pletenessposesaproblemforevaluatingmultilabelclassifiers. |     |     |     |     | We  |
| --- | --- | --- | --- | --- | --------------------------------------------------------- | --- | --- | --- | --- | --- |
In the SONYC-UST dataset, we include the Zooniverse vol- proposeapragmaticsolutiontothisproblem;theguidingideabe-
unteers’fine-levelmulti-labelclass-presenceandproximityannota- hindoursolutionistoevaluatethepredictionatthefinelevelonly
tions for all the audio recordings in all three data splits. We also whenpossible,andfallbacktothecoarselevelifnecessary.
provide the SONYC-team-verified multi-label class-presence an- Letacoarse-levelcategorycontainK fine-leveltags. Wede-

DetectionandClassificationofAcousticScenesandEvents2019 25–26October2019,NewYork,NY,USA
note by t ...t the indicators of presence of these tags in the fromthegroundtruth),thenwemayevaluatethesmallenginetag
|     |     | 1 K |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ground truth. For k ∈ {1...K}, the integer t is equal to 1 if atthefinelevel,andcountitasafalsepositive. Conversely,ifthe
k
thefine-leveltagkispresentinthegroundtruthandequalto0oth- coarse category of engines is incomplete (i.e. the tag “engine of
erwise. Furthermore,wedenotebyt theindicatorofpresenceof uncertainsize”ispresentinthegroundtruth),thenwefallbackto
0
theother/unknowntaginthegroundtruthforthecoarsecategoryat coarse-levelevaluationforthesampleathand,andcountthesmall
hand. Inthefollowing,weadoptthebarnotationt asashorthand engine prediction as a true positive, in aggregation with potential
k
forthelogicalnegation(1−t ). Whereasthefine-levelcomposi- predictionsofmediumenginesandlargeengines.
k
tionofthecoarsecategorycannotbeassessedwithcertainty,taking Ineachcoarsecategory,theseintegercountscanthenbetrans-
theproductofallintegerst 0 ...t k yieldsacoarseindicatorofcer- latedintowell-knowninformationretrievalmetrics: precision, re-
tainabsence,equalto1ifandonlyifnoneofthefine-leveltagsis call,F1score,andareaundertheprecisionrecallcurve(AUPRC).
present, even the uncertain one. This operation of tag coarsening Furthermore, theycanbemicro-averagedacrosscoarsecategories
allowstoevaluateanypredictiony againstthegroundtrutht. In toyieldanoverallF1scoreandanoverallAUPRC.Therepository
eachcoarsecategory,thecomparisonofyandtresultsin,either,a ofourbaselinesystemcontainsanopen-sourceimplementationof
truepositive(TP),afalsepositive(FP),orafalsenegative(FN): thesemetrics,bothfor“coarse”and“fine”formulas3.
|     |     | (cid:32) | (cid:33)   | (cid:32) | (cid:33)   |     |     |                   |     |     |
| --- | --- | -------- | ---------- | -------- | ---------- | --- | --- | ----------------- | --- | --- |
|     |     |          | (cid:89) K |          | (cid:89) K |     |     |                   |     |     |
|     | TP  | = 1−     | t          | × 1−     | y          |     |     |                   |     |     |
|     |     | coarse   | k          |          | k          |     |     | 5. BASELINESYSTEM |     |     |
|     |     |          | k=0        |          | k=0        |     |     |                   |     |     |
|     |     | (cid:32) | (cid:33)   | (cid:32) | (cid:33)   |     |     |                   |     |     |
K K Forthebaselineclassifier(cf.footnote3)weuseamulti-labellogis-
|     |     | (cid:89) |     | (cid:89) |     |     |     |     |     |     |
| --- | --- | -------- | --- | -------- | --- | --- | --- | --- | --- | --- |
FP coarse = t k × 1− y k ticregressionmodel. ThemodelusesVGGishembeddings[19]as
k=0 k=0 itsinputrepresentation,whicharecomputedfromnon-overlapping
(cid:32) K (cid:33) (cid:32) K (cid:33) 0.96-secondwindows,givingustenframesof128-dimensionalem-
(cid:89) (cid:89)
FN = 1− t × y . (2) beddings for each clip in our dataset. We train the model at the
|     |     | coarse | k   |     | k   |     |     |     |     |     |
| --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
frame-levelandusetheweaktagsfromeachaudioclipasthetargets
|     |     |     | k=0 | k=0 |     |     |                              |     |                            |     |
| --- | --- | --- | --- | --- | --- | --- | ---------------------------- | --- | -------------------------- | --- |
|     |     |     |     |     |     |     | foreachofthe10framesinaclip. |     | Toaggregatethecrowdsourced |     |
Thethreenumbersaboveareequaltozeroorone,andsumtoone
annotationsfortraining,wecountapositiveforatagifatleastone
| ineachcoarsecategory. |     |     | Althoughtheyareresilienttotheincom- |     |     |     |     |     |     |     |
| --------------------- | --- | --- | ----------------------------------- | --- | --- | --- | --- | --- | --- | --- |
annotatorhaslabeledtheaudioclipwiththattag,i.e.minorityvote.
| pletenessoftags, |     | thiscomesatthecostofthembeinginsensitive |     |     |     |     |     |     |     |     |
| ---------------- | --- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
Wetrainedthemodelusingstochasticgradientdescenttomin-
topermutationsofcompletefine-leveltagswithinthesamecoarse
|     |     |     |     |     |     |     | imizebinarycross-entropyloss. |     | Totrainthemodeltopredictfine- |     |
| --- | --- | --- | --- | --- | --- | --- | ----------------------------- | --- | ----------------------------- | --- |
category.Therefore,weproposethealternativedefinitionsbelow:
leveltags,thelossismodifiedsuchthatif“other/unknown”isan-
(cid:32) (cid:33) (cid:32) (cid:33) (cid:32) (cid:33) notatedforaparticularcoarsetag,thelossforthefinetagscorre-
|     |     | (cid:88) K |     | (cid:89) K |     | (cid:89) K |     |     |     |     |
| --- | --- | ---------- | --- | ---------- | --- | ---------- | --- | --- | --- | --- |
TP = t y +t × 1− t y × 1− y , spondingtothiscoarsetagismaskedout. Weuseearlystopping
|     | fine | k k | 0   | k   | k   | k   |                                                   |     |     |           |
| --- | ---- | --- | --- | --- | --- | --- | ------------------------------------------------- | --- | --- | --------- |
|     |      |     |     |     |     |     | basedonthevalidationsetlosstomitigateoverfitting. |     |     | Wetrained |
|     |      | k=1 |     | k=1 |     | k=0 |                                                   |     |     |           |
(cid:32) (cid:33) (cid:32) (cid:33) (cid:32) (cid:33) one model to only predict fine-level tags, and we trained another
|     |     | K   |     | K   |     | K   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:88) (cid:89) (cid:89) modeltoonlypredictcoarse-leveltags.
| FP  | fine =t | 0 × t k y k | +t  | 0 y 0 × | t k × | 1− y k | ,   |     |     |     |
| --- | ------- | ----------- | --- | ------- | ----- | ------ | --- | --- | --- | --- |
k=1 k=1 k=1 Forclip-levelinference,wepredicttagsattheframeleveland
(cid:32) K (cid:33) (cid:32) K (cid:33) (cid:32) K (cid:33) taketheaverageofoutputtagprobabilitiesastheclip-leveltagprob-
|     |     | (cid:88) |     | (cid:89) | (cid:89) |     |     |     |     |     |
| --- | --- | -------- | --- | -------- | -------- | --- | --- | --- | --- | --- |
FN = t y +t × t × y . (3) abilities. The resulting summary and class-wise metrics are pre-
|     | fine | k k | 0   | k   | k   |     |     |     |     |     |
| --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
sentedinTable1.OverallthebaselinemodelsachievedanAUPRC
|     |     | k=1 |     | k=1 | k=0 |     |             |                          |                 |                |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ------------------------ | --------------- | -------------- |
|     |     |     |     |     |     |     | of 0.62 and | 0.76 on the test split’s | fine and coarse | levels respec- |
Incontrasttotheircoarsecounterparts,thesecountersrangefrom0
tively, andperformedpoorlyonmusicandnon-machineryimpact
toK. Inthesimplecasewherethegroundtruthiscomplete(i.e.,
sounds,leavingconsiderableroomforimprovement.
t = 0),
| 0          |     | they boil down | to a one-to-one | comparison   |            | of complete |     |     |     |     |
| ---------- | --- | -------------- | --------------- | ------------ | ---------- | ----------- | --- | --- | --- | --- |
| fine-level |     | predicted tags | y k with        | the complete | fine-level | ground      |     |     |     |     |
truth tags t k , with the incomplete prediction y 0 being counted as 6. CONCLUSION
afalsepositiveifpresent.However,ifthegroundtruthcontainsthe
incomplete tag (i.e., t = 1), FP falls to zero. If, in addition, SONYC-UST is a multi-label dataset for urban sound tagging,
|     |     | 0   |     | fine |     |     |     |     |     |     |
| --- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- |
nocompletefine-levelgroundtruthtagt matchesacompletefine- recordedfromanurbanacousticsensornetworkandannotatedby
k
levelprediction(i.e.,t y = 0forallk > 0),thenthenumberof crowdsourcedvolunteers.Thisdatasetaddressesdeficienciesinthe
k k
truepositivesissettooneifthecoarsenedpredictedtagispresent currentsetofurbansounddatasetsbyprovidingreal-worldrecord-
(i.e.,y =0foranyk≥0)andzerootherwise.Lastly,ifthecoars- ings and a label set that more closely matches the needs of city
k
enedpredictedtagisabsent(i.e.,y = 0forallk ≥ 0)andifthe agenciesinchargeofnoiseabatement.Inthiswork,wepresentthe
k
groundtruthdoesnotcontainanycompletetag(i.e.,t =0forall processusedtocollectthisdata; ataxonomyofurbansoundtags
k
k>0),thenthenumberoffalsenegativesissettot . informedby theNewYork Citynoisecodeand consultationwith
0
For example, if a small engine is present in the ground truth noiseenforcementagents;metricstoevaluatetaggingsystemswith
and absent in the prediction but an other/unknown engine is pre- uncertain ground-truth data; and a baseline model demonstrating
dicted, then it is a true positive in the coarse-grained sense, but a thatthisisachallengingtaskwithconsiderableroomforimprove-
falsenegativeinthefine-grainedsense. However,ifasmallengine ment. Wehopethisdatasetwillencourageresearcherstofocuson
isabsentinthegroundtruthandpresentintheprediction,thenthe thisproblemandadvancethestateoftheartinurbansoundevent
outcomeoftheevaluationwilldependonthecompletenessofthe detection,helpingbuildtoolstomakecitiesquieter.
| groundtruthforthecoarsecategoryofengines. |     |     |     |     | Ifthiscoarsecate- |     |     |     |     |     |
| ----------------------------------------- | --- | --- | --- | --- | ----------------- | --- | --- | --- | --- | --- |
goryiscomplete(i.e. ifthetag“engineofuncertainsize”isabsent 3https://github.com/sonyc-project/urban-sound-tagging-baseline

DetectionandClassificationofAcousticScenesandEvents2019 25–26October2019,NewYork,NY,USA
7. REFERENCES [17] M.Cartwright, G.Dove, A.E.Me´ndezMe´ndez, J.P.Bello,
|     |     |     |     |     |     |     | and O. Nov, | “Crowdsourcing |     | multi-label | audio | annotation |     |
| --- | --- | --- | --- | --- | --- | --- | ----------- | -------------- | --- | ----------- | ----- | ---------- | --- |
[1] M. S. Hammer, T. K. Swinburn, and R. L. Neitzel, “Envi- taskswithcitizenscientists,”inProceedingsofthe2019CHI
ronmentalnoisepollutionintheunitedstates: developingan ConferenceonHumanFactorsinComputingSystems. ACM,
| effectivepublichealthresponse,”EnvironmentalHealthPer- |     |     |     |     |     |     | 2019,p.292. |     |     |     |     |     |     |
| ------------------------------------------------------ | --- | --- | --- | --- | --- | --- | ----------- | --- | --- | --- | --- | --- | --- |
spectives,vol.122,no.2,pp.115–119,2013.
|     |     |     |     |     |     |     | [18] M. Cartwright, | A.  | Seals, | J. Salamon, | A. Williams, |     | S. Mik- |
| --- | --- | --- | --- | --- | --- | --- | ------------------- | --- | ------ | ----------- | ------------ | --- | ------- |
[2] A.Bronzaft,“Neighborhoodnoiseanditsconsequences,”Sur- loska,D.MacConnell,E.Law,J.P.Bello,andO.Nov,“See-
veyResearchUnit,SchoolofPublicAffairs,BaruchCollege, ingsound:Investigatingtheeffectsofvisualizationsandcom-
NewYork,2007. plexity on crowdsourced audio annotations,” Proceedings of
theACMonHuman-ComputerInteraction,vol.1,no.CSCW,
[3] WorldHealthOrganization,“Burdenofdiseasefromenviron-
| mentalnoise: |     | Quantificationofhealthylifeyearslostineu- |     |     |     |     | p.29,2017. |     |     |     |     |     |     |
| ------------ | --- | ----------------------------------------- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- |
rope,”inBurdenofdiseasefromenvironmentalnoise: Quan- [19] S. Hershey, S. Chaudhuri, D. P. W. Ellis, J. F. Gemmeke,
tificationofhealthylifeyearslostinEurope,2011,pp.126–
|     |     |     |     |     |     |     | A. Jansen, | C.  | Moore, | M. Plakal, | D.  | Platt, | R. A. |
| --- | --- | --- | --- | --- | --- | --- | ---------- | --- | ------ | ---------- | --- | ------ | ----- |
126.
|     |     |     |     |     |     |     | Saurous, | B. Seybold, | M.  | Slaney, | R. Weiss, | and K. | Wilson, |
| --- | --- | --- | --- | --- | --- | --- | -------- | ----------- | --- | ------- | --------- | ------ | ------- |
[4] M. Basner, W. Babisch, A. Davis, M. Brink, C. Clark, “Cnn architectures for large-scale audio classification,”
S.Janssen, andS.Stansfeld, “Auditoryandnon-auditoryef- in International Conference on Acoustics, Speech and
fectsofnoiseonhealth,”TheLancet,vol.383,no.9925,pp. Signal Processing (ICASSP), 2017. [Online]. Available:
| 1325–1332,2014. |     |         |               |     |            |           | https://arxiv.org/abs/1609.09430 |     |     |     |     |     |     |
| --------------- | --- | ------- | ------------- | --- | ---------- | --------- | -------------------------------- | --- | --- | --- | --- | --- | --- |
| [5] C. Mydlarz, | M.  | Sharma, | Y. Lockerman, |     | B. Steers, | C. Silva, |                                  |     |     |     |     |     |     |
andJ.P.Bello,“Thelifeofanewyorkcitynoisesensornet-
work,”Sensors,vol.19,no.6,p.1415,2019.
| [6] D. Stowell | and            | M. Plumbley, | “An         | open           | dataset for        | research   |     |     |     |     |     |     |     |
| -------------- | -------------- | ------------ | ----------- | -------------- | ------------------ | ---------- | --- | --- | --- | --- | --- | --- | --- |
| on audio       | field          | recording    | archives:   |                | freefield1010,”    | in         |     |     |     |     |     |     |     |
| Audio          | Engineering    | Society      | Conference: |                | 53rd International |            |     |     |     |     |     |     |     |
| Conference:    | SemanticAudio, |              | Jan         | 2014.[Online]. |                    | Available: |     |     |     |     |     |     |     |
http://www.aes.org/e-lib/browse.cfm?elib=17095
[7] J.Salamon,C.Jacoby,andJ.P.Bello,“Adatasetandtaxon-
| omy for                                 | urban | sound | research,” | in Proceedings | of        | the 22nd |     |     |     |     |     |     |     |
| --------------------------------------- | ----- | ----- | ---------- | -------------- | --------- | -------- | --- | --- | --- | --- | --- | --- | --- |
| ACMinternationalconferenceonMultimedia. |       |       |            |                | ACM,2014, |          |     |     |     |     |     |     |     |
pp.1041–1044.
| [8] J. Salamon, | D.       | MacConnell,                           | M.  | Cartwright, | P. Li, | and J. P. |     |     |     |     |     |     |     |
| --------------- | -------- | ------------------------------------- | --- | ----------- | ------ | --------- | --- | --- | --- | --- | --- | --- | --- |
| Bello,          | “Scaper: | Alibraryforsoundscapesynthesisandaug- |     |             |        |           |     |     |     |     |     |     |     |
mentation,”in2017IEEEWorkshoponApplicationsofSignal
| ProcessingtoAudioandAcoustics(WASPAA). |     |     |     |     | IEEE,2017, |     |     |     |     |     |     |     |     |
| -------------------------------------- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
pp.344–348.
[9] F.Font,G.Roma,andX.Serra,“Freesoundtechnicaldemo,”
inProceedingsofthe21stACMinternationalconferenceon
| Multimedia.      |                         | ACM,2013,pp.411–412. |                   |           |            |             |     |     |     |     |     |     |     |
| ---------------- | ----------------------- | -------------------- | ----------------- | --------- | ---------- | ----------- | --- | --- | --- | --- | --- | --- | --- |
| [10] A. Mesaros, |                         | T. Heittola,         | and T.            | Virtanen, | “Tut       | database    |     |     |     |     |     |     |     |
| for acoustic     | scene                   | classification       |                   | and sound | event      | detection,” |     |     |     |     |     |     |     |
| in 2016          | 24th                    | European             | Signal Processing |           | Conference | (EU-        |     |     |     |     |     |     |     |
| SIPCO).          | IEEE,2016,pp.1128–1132. |                      |                   |           |            |             |     |     |     |     |     |     |     |
| [11] ——,         | “Tut sound              | events               | 2016, development |           | dataset,”  | 2016.       |     |     |     |     |     |     |     |
[Online].Available:https://zenodo.org/record/45759
| [12] ——, | “Tut sound | events | 2016, | evaluation | dataset,” | 2017. |     |     |     |     |     |     |     |
| -------- | ---------- | ------ | ----- | ---------- | --------- | ----- | --- | --- | --- | --- | --- | --- | --- |
[Online].Available:https://zenodo.org/record/996424
| [13] ——, | “Tut sound | events | 2017, development |     | dataset,” | 2017. |     |     |     |     |     |     |     |
| -------- | ---------- | ------ | ----------------- | --- | --------- | ----- | --- | --- | --- | --- | --- | --- | --- |
[Online].Available:https://zenodo.org/record/814831
| [14] ——, | “Tut sound | events | 2017, | evaluation | dataset,” | 2017. |     |     |     |     |     |     |     |
| -------- | ---------- | ------ | ----- | ---------- | --------- | ----- | --- | --- | --- | --- | --- | --- | --- |
[Online].Available:https://zenodo.org/record/1040179
| [15] R.Simpson,K.R.Page,andD.DeRoure,“Zooniverse: |     |     |     |     |     | Ob-    |     |     |     |     |     |     |     |
| ------------------------------------------------- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
| servingtheworld’slargestcitizenscienceplatform,”  |     |     |     |     |     | inPro- |     |     |     |     |     |     |     |
ceedingsofthe23rdInternationalConferenceonWorldWide
| Web, ser. | WWW | ’14 | Companion. | New | York, | NY, USA: |     |     |     |     |     |     |     |
| --------- | --- | --- | ---------- | --- | ----- | -------- | --- | --- | --- | --- | --- | --- | --- |
ACM,2014,pp.1049–1054.
[16] “Zooniverse.”[Online].Available:www.zooniverse.org
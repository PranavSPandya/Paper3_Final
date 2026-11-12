UlanAlsiyeu1,Zhasdauren Duisebekov2
1,2SDUUniversity,Kaskelen,Kazakhstan
ENHANCINGTRAFFICSIGNRECOGNITIONWITHTAILORED DATA
AUGMENTATION:ADDRESSINGCLASS IMBALANCEANDINSTANCESCARCITY
Abstract. Thispaper tacklescriticalchallenges intraffic signrecognition (TSR), which
isessentialfor road safety—specifically,class imbalanceand instancescarcityindatasets. We
introducetailored dataaugmentation techniques,includingsynthetic imagegeneration,
geometrictransformations, andanovel obstacle-basedaugmentation method toenhancedataset
qualityfor improved modelrobustness andaccuracy. Ourmethodologyincorporatesdiverse
augmentation processestoaccuratelysimulate real-worldconditions, therebyexpanding the
training data's varietyand representativeness.Ourfindingsdemonstratesubstantial
improvements inTSR models performance,offering significantimplications for trafficsign
recognition systems.This researchnotonlyaddressesdataset limitationsinTSR but also
proposes amodel for similarchallenges across differentregionsandapplications,marking astep
forward in thefieldof computer visionand trafficsignrecognition systems.
Keywords:Traffic Sign Recognition (TSR), ClassImbalance,Instance Scarcity,
SyntheticImage Generation, Geometric Transformations,ComputerVision, Dataset
Augmentation, Kazakhstan TrafficSign Dataset
***
Андатпа.Бұлмақала жолқауіпсіздігі үшін маңыздыболыптабылатынжол
белгілерін танудағы(ЖБТ)қиындықтарды қарастырады—деректержинақтарындағы
класстеңсіздігі мен мысалдардыңжетіспеушілігін. Біздеректержинағыныңсапасын
жақсартужəнемодельдің тұрақтылығымендəлдігінарттыру үшінсинтетикалық бейне
жасау,геометриялықтрансформацияларжəнежаңа кедергілернегізіндегіаугментация
əдісінқоса алғанда,арнайы деректераугментациясыəдістерін енгіздік. Біздіңəдістемеміз
əртүрлі аугментацияпроцесстерін қамтиды,бұларқылыоқыту деректерінің əртүрлілігін
жəне өкілдігін кеңейтеді.Біздіңнəтижелеріміз ЖБТ модельдерініңөнімділігінде маңызды
жақсартуларды көрсетеді,бұлжол белгілерін танужүйелеріүшін маңыздысалдарлар
ұсынады.БұлзерттеутекЖБТ деректержинақтарыныңшектеулеріншешіпқанақоймай,
соныменқатарəртүрлі аймақтар менқосымшалардағы ұқсасмəселелер үшінүлгі
ұсынады,бұлкомпьютерліккөружəнежол белгілерін танужүйелерісаласындаалға қадам
жасайды.
Түйін сөздер:Жол белгілерінтану (ЖБТ),Сынып теңсіздігі,Оқиғалартапшылығы,
Синтетикалық бейнежасау,Геометриялық трансформациялар,Компьютерлік көру,
Деректержинағынкеңейту,Қазақстан көлікбелгілері деректержинағы
***

Аннотация: Этастатья рассматриваеткритическиепроблемы в распознавании
дорожныхзнаков(РДЗ),которые являютсяважнымидлябезопасности дорожного
движения—а именно,дисбаланс классов инедостаточностьпримеровв наборахданных.
Мы вводимспециализированные методыувеличенияданных, включаягенерацию
синтетическихизображений, геометрические преобразованияиновыйметодувеличения
данных наосновепрепятствий дляулучшения качестванабораданных, повышения
устойчивостииточности моделей. Нашаметодологиявключает разнообразные процессы
увеличения данныхдляточного моделированияусловийреального мира,темсамым
расширяя разнообразиеи представительностьобучающих данных.Наши результаты
демонстрируютзначительные улучшенияв производительностимоделей РДЗ,что имеет
важные последствиядля системраспознавания дорожныхзнаков.Этоисследование не
толькоустраняетограничения наборовданных в РДЗ,ноипредлагаетмодельдля решения
аналогичныхпроблемв различных регионахиприложениях, чтоявляется шагомвперед в
областикомпьютерногозренияисистем распознаваниядорожных знаков.
Ключевыеслова: Распознаваниедорожныхзнаков(РДЗ), Дисбалансклассов,
Недостатокэкземпляров, Генерациясинтетическихизображений, Геометрические
преобразования,Компьютерноезрение, Аугментациянабораданных, набор данных
дорожныхзнаковКазахстана
I. Introduction
Theadvent of advanceddriver-assistancesystems (ADAS) hasunderscoredthe
importanceof Traffic SignRecognition (TSR) technologies. Thesesystems rely ontheaccurate
and reliableidentificationof trafficsigns toensurethe safetyandefficiency ofroad navigation.
However,theperformanceof TSR systemsis highlydependentonthe qualityand
comprehensivenessof thedatasets usedto traintherecognition models.A prevalent issuewithin
thesedatasets istheimbalance amongclasses andthe scarcityofinstances for specifictypes of
trafficsigns.JingzhanGe[1] highlightedthe limitationsinherent inavailable TSR datasets,
pointing outthat manylacksufficientinstances for effectivedeep learningapplications,a
problem intensifiedbythereal-worldfrequency of differenttrafficsign classes.Moreover,
datasets liketheDFG traffic signdataset, GTSRBandSwedishtraffic signsdataset, despitetheir
contributions,fall shortin offeringthe requisitevarietyand volumeof instances for training
modelscapable of navigatingthe complexitiesofreal-world trafficsignrecognition.
Classimbalance and instancescarcitywithin trafficsignrecognition datasets impedethe
learningprocessand degrade theperformance ofrecognition models.These issuesare
compounded indatasets pertinent tospecificgeographicalregions,where therepresentationof
certain signclassesisinherentlylimited bytheirreal-worldoccurrence andsignificance.
This studyaimstodevelop andevaluate dataaugmentation techniques specifically
tailored toaddressthechallenges ofclass imbalanceand instancescarcityintraffic sign
recognition datasets.Byfocusingonsynthetic imagegeneration, geometrictransformations,and
anovel methodof obstacle-based augmentation, weseekto enhancethediversity and

representativenessof thetraining data.Theobstacle-based augmentation isa novelapproachthat
simulatesreal-world conditions wheresigns may bepartiallyblocked, therebyimprovingthe
model's robustnessand generalizability.
Theimplications of this researchextend beyondtheimmediaterealm oftraffic sign
recognition, offeringpotentialbenefits for thebroader fieldof advanceddriver-assistance
systems.Byimproving the robustness andreliabilityof TSR datasets, thestudy contributestothe
developmentof trafficsign systemsand advanceddriver-assistancesystemsthat canoperate
effectivelyacrossdiverseenvironments. Additionally,thetailored data augmentationtechniques
proposedherein couldserveas ablueprintfor addressing similarchallenges inotherregionsand
domains,underscoringthe universalrelevanceand applicabilityofthe study'sfindings.
II. Literaturereview
Theadvancement ofTraffic Sign Recognition (TSR) technologies hasbeen significantly
influenced bythedevelopment andapplication ofmachine learninganddeep learningmethods.
However,theeffectiveness ofthesetechnologies isoftenhindered bytheinherent challengesof
class imbalanceand instance scarcitywithinthe datasets usedfor training recognitionmodels.
Addressing theseissuesnecessitatesinnovative approachesto dataaugmentation andmodel
training strategies.
Classimbalance occurs whencertaintraffic signclasses areoverrepresentedwhile others
areunderrepresented ina dataset.This imbalancecan lead tobiasedlearning,where the model
performs wellonfrequently occurring classesbut poorlyonrare ones.Instance scarcity, onthe
otherhand, refersto thelackof sufficientexamplesfor specifictraffic signclasses, which
impedes themodel'sabilityto generalizeandaccuratelyrecognize thesesigns indiverse
conditions. Bothissues areprevalent inexisting TSR datasets,includingwidely used
benchmarks suchastheGermanTraffic Sign Recognition Benchmark(GTSRB)andthe Swedish
Traffic SignsDataset .
JingzhanGe[1] highlightedthat many TSR datasetslack sufficientinstances for effective
deeplearningapplications,exacerbatingthe challengeof classimbalance. Thestandardization of
trafficsigndesignsacrossdifferent regionsandtheirvaried real-worldfrequency further
complicatethecreation of balancedandcomprehensive datasets.For instance,the DFGtraffic
signdataset,despite itscontributions,does notofferthe necessaryvarietyand volumeof
instances totrain modelscapable ofnavigatingthe complexitiesof real-worldtrafficsign
recognition .
Recentstudies haveemphasized the criticalroleofdata augmentation inaddressing these
limitations. Geproposeda uniquedata augmentation methodtailored for trafficsign datasets,
aimedatovercomingthechallengesof classimbalance andinsufficient instances.This method
leveragessyntheticimage generationto createmoreinstances of underrepresentedclasses,
enhancingthedataset'sbalance anddiversity .
AntonKonushin, Boris Faizov,andVlad Shakhuro[2] introduced methodsfor
augmenting roadimages with synthetictrafficsigns using neuralnetworks.Thisapproach

focusesongenerating synthetic imagestoenhancethe detectionand classificationofrare traffic
signclasses, directlyaddressing theissues ofclassimbalance andinstance scarcity .
Moreover,Qingchuan Li etal. [3] exploreddata augmentation fromtheperspective ofthe
frequency domain.Their work providesinsightsinto howaugmentation strategies canbe
optimizedto improvetherobustnessof CNN-basedtrafficsign detectionmodelsagainst various
types of noiseand distributional shifts.By understanding theeffectsof augmentationin different
frequency bands,researchers canselect strategiesthat enhancemodel robustnessin real-world
applications .
XinRoyLim andhis team'sexamination [4] ofensemble learningin TSR presentsa
method thatintegrates multiplepre-trained CNNmodelstoachieve highrecognition rates.This
ensembleapproach demonstratesthe importanceofleveraging collectivemodel strengths to
enhanceTSR accuracy,which isparticularly relevant inovercoming datasetlimitations .
Despitetheseadvancements,the fieldcontinuestograpple withtheissueof class
imbalance andinstancescarcity,significantly impactingthe learningprocess andmodel
performance. Theinnovativedata augmentation techniquesproposedbyGe,Konushin,and Li
[5] represent crucialstepsforward butalso highlight theongoingneed for researchinthis area.
Developing moresophisticatedaugmentation methodsandcreating morediverseand
representative datasetsremain centralchallenges for the TSR community.
Byaddressing thesechallenges through tailored dataaugmentation techniques, suchas
syntheticimagegeneration,geometrictransformations, andthe novelmethod ofobstacle-based
augmentation, thisstudyaimstoenhancethe diversity andrepresentativenessofTSR datasets.
Theseefforts aregeared towards improvingthe accuracyand generalizabilityofTSR models,
particularly inthecontext ofKazakhstan's trafficsign landscape.
III. Researchmethods
In thedevelopment ofour datasetfor this study,wemeticulouslycurated acollection of
images representingadiverse arrayof roadtraffic signs.This collectionspans across 220unique
instances whicharedivided into6classes, directly derivedfromthe comprehensivelegal
frameworkestablishedwithin theRepublic ofKazakhstan.For instance,service classincludes
food point signinstances (Figure 2.a).Specifically,our data acquisitionprocess involved
extractingvisualrepresentationsfrom theofficialdocumentation. Thelegaldocument[6], served
asthefoundational basisfor ourimagedataset.
In additionto thestructured datasetderivedfrom thelegaldocumentation, wefurther
enrichedour collection with20real-worldimages capturingvariousroad scenarios.These
images werecollected usinga cardashcam,ensuringadiverse andrealistic representationofthe
road environmentasencountered ineverydaysituations (Figure1).

|     |     | Figure 1.Real-worldbackgroundimage |     |     |     |
| --- | --- | ---------------------------------- | --- | --- | --- |
Toaddressthechallenges ofclass imbalanceand instancescarcity, andtoensure the
comprehensive representationof trafficsigns under variousconditions,weemployedan
extensiveaugmentation process for ourdataset. Eachof theseuniquetrafficsign images
underwenta seriesof transformationstoenhancethe dataset'sdiversity andrealism,ensuringa
| balanced andrepresentative |     | set ofimagesfor | each sign | class. |     |
| -------------------------- | --- | --------------- | --------- | ------ | --- |
1. Geometric Transformations andColorFilters: Utilizingthe imgaug Python package,we
applied5distinctgeometric transformationstoeach sign imageasshowninTable 1.To
further increasethe variabilityofthe dataset,colorfilters showninTable 2werealso
applied.Additionally,deformations includingpiecewiseaffine transformations(Figure
2.b), perspective transforms, andJPEGcompressionwere employed(Table3) tosimulate
| various real-world         |              | distortionsthattraffic | signsmight | undergo.   |                       |
| -------------------------- | ------------ | ---------------------- | ---------- | ---------- | --------------------- |
| Table 1.Geometric          |              | augmentations          |            |            |                       |
|                            | Augmentation | name                   |            |            | Value                 |
|                            |              | Rotation               |            |            | -25°to 25°            |
|                            |              | Shear                  |            |            | -16°to 16°            |
|                            |              | Scale                  |            |            | 80% to120%            |
|                            |              | Crop                   |            |            | Upto 30%              |
|                            | Translate    | up                     |            | 10%        | of imagedimensions    |
| Table 2.Coloraugmentations |              |                        |            |            |                       |
|                            | Augmentation | name                   |            |            | Value                 |
|                            |              | Brightness             |            | Decreasing | to50% andincreasingto |

100%
|                     |                      | Noise         |     | -80 black | and80whitenoise  |
| ------------------- | -------------------- | ------------- | --- | --------- | ---------------- |
|                     | Gaussianblur         |               |     |           | Upto 60%         |
|                     | Linearcontrast       |               |     |           | 25% to100%       |
|                     |                      | Medianblur    |     | From      | 3x3to 5x5 pixels |
| Table 3.Deformation |                      | augmentations |     |           |                  |
|                     | Augmentation         | name          |     |           | Value            |
|                     | Affinetransformation |               |     |           | Upto 90%         |
|                     | Perspectivetransform |               |     |           | Upto 90%         |
|                     | JPEG                 | compression   |     |           | Upto 85%         |
2. Integration withBackgrounds: Leveragingthecv2 Python package,eachaugmented sign
imagewas seamlessly integratedintoeach ofthe 20selected real-worldbackground
images (Figure2.c).Coordinates andsizesof signsin eachbackgroundimagewere
calculatedmanuallyusing PhotoScapeXtool. Thisstep wascrucial for simulatingthe
placement of traffic signsin diversereal-worldcontexts, rangingfromurban streetsto
rural settings,therebyenhancingthe dataset'sapplicabilityacross differentenvironments.
3. Environmental Conditions: Tofurther mimicthevariability encounteredin actualdriving
conditions, eachcomposite imagewassubjectedto weatherandlighting condition
alterationsusingthe albumentationspackage.Conditionsappliedincluderain(Figure 3),
snow,fog, sunflare,and variationsinlighting (day,night, dawneffect)(Figure2),
ensuring thatthedatasetreflects thechallenges facedbyadvanceddriving assistance
| systemsin | recognizing | trafficsigns | underadverse | conditions. |     |
| --------- | ----------- | ------------ | ------------ | ----------- | --- |
4. Obstacle-BasedAugmentation: Tofurther enhancetherealismandrobustness of the
dataset,weintroducedanobstacle-based augmentation technique.Theprocess involved
| thefollowing | steps: |     |     |     |     |
| ------------ | ------ | --- | --- | --- | --- |
a. CollectingObstacles: Weselected relevant categoriesfromthe COCOdataset,
includingcars,trucks, buses,and people.Images containingtheseobjectswere
|     | downloaded | andprocessed | toextract theobstacles. |     |     |
| --- | ---------- | ------------ | ----------------------- | --- | --- |
b. OverlayingObstacles: Usingthe cv2library, obstacleswere randomlyresized and
positioned overthe trafficsignimages tosimulate partialocclusions. The
transparency ofthe obstacleswas adjustedtomimicreal-world visibility
|     | conditions | (Figure 4). |     |     |     |
| --- | ---------- | ----------- | --- | --- | --- |

c. Randomization: Theposition,size,andtransparencyof obstacles were
randomized toensurea widevarietyof occlusionscenarios,enhancingthe
|     | model's ability | togeneralizetoreal-world | conditions. |
| --- | --------------- | ------------------------ | ----------- |
Figure2.Augmentationpipeline inanexampleof foodpoint sign: (a)initialsign, (b)
|     | geometric | augmentedsign, | (c)backgroundintegratedsign |
| --- | --------- | -------------- | --------------------------- |
Figure 3.Rainweatherconditionadded image
This methodologicalenhancement, withits focusondiversity, realism,and
representativeness,underscoresour commitmenttocreating arobustdataset thatcan
significantlyimprove theperformanceof trafficsignrecognition systems, particularlyin the
| challengingand | variedlandscapes | ofKazakhstan.    |              |
| -------------- | ---------------- | ---------------- | ------------ |
|                |                  | Figure4.Obstacle | overlaidsign |
IV. Researchresults
Theaugmentation andintegrationprocessesoutlinedinour methodology have
successfullyyieldeda comprehensivedataset designedtoaddressthe challenges oftrafficsign

recognition inthecontext ofKazakhstan.Theinitial collection of220trafficsign imagesand20
backgroundimages underwentextensive augmentation andintegration,resulting inarobust
datasetthat enhancesthediversity andrepresentativenessnecessaryfor training effective
| recognition | models. |     |     |     |     |     |     |     |
| ----------- | ------- | --- | --- | --- | --- | --- | --- | --- |
● Augmentation outcomes: Fromthe originalset of 220trafficsignimages, ourapplication
of geometrictransformations,colorfilters,and deformationsproducedatotalof 2,420
|     | uniqueaugmented |     | images. |     |     |     |     |     |
| --- | --------------- | --- | ------- | --- | --- | --- | --- | --- |
● Integration withbackgrounds:Thesubsequentintegrationof theseaugmentedimages
with the20selected real-worldbackgroundimagesresulted in48,400composite images.
● Environmental conditioning:By applying weatherandlighting conditionsweachieved a
|     | datasetsizeof | 338,520images. |     |     |     |     |     |     |
| --- | ------------- | -------------- | --- | --- | --- | --- | --- | --- |
● Obstacle-BasedAugmentation: Thenovelobstacle-based augmentation techniquefurther
enhancedthedataset's realismandrobustness. Byoverlaying variousobstacles suchas
vehicles,pedestrians, trees,and othercommonroad obstructionsontothe trafficsign
images, wesimulatedreal-worldconditions wheresigns might bepartiallyblocked. This
|     | processbringsthetotalto1015560images |     |     |     |     | asshowninTable | 4.  |     |
| --- | ------------------------------------ | --- | --- | --- | --- | -------------- | --- | --- |
Theresultantdataset standsasatestamentto thepotential oftailored data augmentation
techniquesin enhancingthecapabilities oftraffic signrecognition systems.
| Table | 1.Datasetaugmentation |         | results |           |     |            |           |           |
| ----- | --------------------- | ------- | ------- | --------- | --- | ---------- | --------- | --------- |
| Sign  | class                 | Initial |         | Geometric |     | Background | Weather / | Obstacle- |
|       | name                  | amount  |         | augmented |     | integrated | Lighting  | Based     |
|       |                       |         |         | amount    |     | amount     | augmented | amount    |
amount
| Informational |     | 88  |     | 968 |     | 19360 | 135520 | 406560 |
| ------------- | --- | --- | --- | --- | --- | ----- | ------ | ------ |
| Priority      |     | 9   |     | 99  |     | 1980  | 13860  | 41580  |
| Prohibitory   |     | 36  |     | 99  |     | 7920  | 55440  | 166320 |
| Regulatory    |     | 19  |     | 209 |     | 4180  | 28980  | 86940  |
| Service       |     | 20  |     | 220 |     | 4400  | 30800  | 92400  |
| Warning       |     | 48  |     | 528 |     | 10560 | 73920  | 221760 |
In order toassessthedataset, wepresentthe experimentalevaluation ofthe YOLOv8
model trainedontwodifferent datasets:theGermanTraffic Sign Recognition Benchmark
(GTSRB) andtheproposeddataset tailoredfor Kazakhstan's trafficsigns. Toevaluate the
performance of themodels, aseparatetestdataset wascollected manually.Thisdatasetincludes
images capturedusingacar dashcamonroadsinKazakhstan.Thetestdataset encompassesa
| varietyof | trafficsignsunder |     | diversereal-world |     | conditions. |     |     |     |
| --------- | ----------------- | --- | ----------------- | --- | ----------- | --- | --- | --- |

Theprimary metric for evaluationwasthe accuracy oftrafficsign recognition, definedas
theproportion of correctly identifiedtrafficsigns outof thetotalnumberof signsin thetest
dataset.Theaccuracy was computedfor boththeGTSRB-trained modeland themodel trained
ontheproposeddataset.
Theexperimentalresultsdemonstrate asignificantimprovementinthe accuracy oftraffic
signrecognition whenusing themodel trained ontheproposeddataset comparedtothe
GTSRB-trained model.
1. Accuracy of YOLOV8 ModelTrainedonGTSRB: Themodel trainedonthe GTSRB
datasetachieved anaccuracy of83.7% onthetestdataset.
2. Accuracy of YOLOV8 ModelTrainedonProposed Dataset: Themodeltrained onthe
proposeddatasetachieved ahigheraccuracy of89.2% onthesametestdataset.
V. Discussion
Theresults fromour studyhighlight the significantimpactof tailoreddata augmentation
techniquesontheperformance oftraffic signrecognition (TSR) systems,particularly inthe
contextof addressing class imbalanceand instancescarcity. Theimprovementsseen inour
model's accuracywhentrained ontheaugmenteddataset ascompared totraditionaldatasets like
theGermanTraffic Sign RecognitionBenchmark(GTSRB)underscorethe effectivenessofour
approach. KeyFindings:
● EnhancedDataset Diversity: Ouraugmenteddataset, whichincludessynthetic image
generation, geometric transformations,and anovelobstacle-based augmentation method,
provides amorediverseandrepresentative setof trainingimages. Thisdiversity iscrucial
for training models thatcan generalizewell toreal-worldconditions,as evidencedbythe
substantialincreaseinmodel accuracy.
● Improved Model Robustness:Theobstacle-based augmentation, inparticular,has proven
effective insimulatingreal-world scenarioswheretraffic signsmay bepartially
obstructed byvariousobjectssuch asvehicles, pedestrians,andtrees. Thistechnique
enhances themodel'srobustness, enablingitto perform betterinrecognizing partially
obscured signs,whichis acommon challengein real-worldapplications.
● Contextual Relevance:Tailoring thedataset tothespecifictraffic signsand conditions
found in Kazakhstanhas resultedin amodel thatis moreaccurateandreliablefor local
applications.This highlights theimportanceof usinggeographicallyand contextually
relevant datafor training TSR systems, asmodelstrained ondatasetsfrom different
regions maynotperform optimally inall contexts.
VI. Conclusion
In conclusion, ourstudy effectivelyaddressesthe criticalchallenges ofclass imbalance
and instancescarcityintrafficsign recognition (TSR) datasetsthrough the useof innovativedata
augmentation techniques.By incorporatingsynthetic imagegeneration,geometric
transformations,and anovel obstacle-basedaugmentation method, wehavesignificantly
enhancedthediversity and representativenessofour dataset.These tailoredaugmentation

processesaccurately simulatereal-worldconditions, therebyimprovingthe robustnessand
accuracy of TSR models.
Theexperimentalresultsdemonstrate thatmodelstrained onouraugmented dataset
exhibitsubstantialimprovementsin performancecompared tothose trainedontraditional
datasets suchastheGermanTraffic Sign Recognition Benchmark(GTSRB).Specifically,the
obstacle-based augmentation technique,whichintroduces realisticpartial occlusions oftraffic
signs, hasproveneffectivein enhancingthemodel'sability togeneralizetodiverse and
challengingreal-world scenarios.
Our findingsunderscore theimportanceof usingcontextually relevant datasetsand
advancedaugmentation strategiesto addressthe limitationsofexisting TSR datasets.This
research notonly offersa solution tothe specificchallengesfaced inKazakhstanbutalso
provides aframeworkthatcan beadaptedtosimilar problems inotherregionsand applications.
Byimproving therobustnessandreliability ofTSR systems, ourstudy contributestothe broader
field of computervisionandadvanceddriver-assistancesystems (ADAS), ultimately enhancing
road safetyandnavigation efficiency.
Future workshould focusonexpandingthe datasetto includemorediverseandextreme
conditions, further refiningaugmentation techniques,and exploringtheintegrationof additional
model architecturesto furtherimprove recognitionaccuracy androbustness. Ourresearch paves
thewayfor ongoing advancements intrafficsign recognition technology,ensuring its
applicability andeffectiveness inincreasinglycomplexreal-worldenvironments.
References
1 Geb,J. "TrafficSign Recognition DatasetandData Augmentation"// SchoolofControl
Scienceand Engineering, TiangongUniversity,Tianjin, China.-2021.
2 Konushin, A.S.;Faizov,B.V.; Shakhuro,V.I. RoadImages AugmentationwithSynthetic
Traffic Signs Using NeuralNetworks.Comput.Opt.2021,45,736–748.
3 Li, Q., Zheng,J.,Tan,W., Wang,X., &Zhao,Y. "Traffic Sign Detection:Appropriate
DataAugmentation Method fromthePerspectiveof FrequencyDomain"// Mathematical
Problems inEngineering. -2022.- Vol. 2022,ArticleID 9571513,11pages.
4 Lim, X.R.;Lee,C.P.; Lim,K.M.;Ong, T.S. "EnhancedTraffic Sign Recognition with
EnsembleLearning"// J.Sens.ActuatorNetw. - 2023.-Vol. 12,Article No.33.- pp.
1-19.
5 Lim, X.R.;Lee,C.P.; Lim,K.M.;Ong, T.S.; Alqahtani,A.;Ali,M."Recent Advances in
Traffic Sign Recognition: ApproachesandDatasets" //Sensors.- 2023.-Vol. 23,Article
No. 4674.
6 Resolution of theGovernmentof theRepublic ofKazakhstandated November13,2014
№1196.Abolishedbythe Decreeof theGovernmentof theRepublic ofKazakhstan dated
09/01/2023 No. 758
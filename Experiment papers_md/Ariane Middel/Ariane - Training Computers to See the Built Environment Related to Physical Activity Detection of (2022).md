International Journal of
Environmental Research
and Public Health
Article
Training Computers to See the Built Environment Related to
Physical Activity: Detection of Microscale Walkability Features
Using Computer Vision
MarcA.Adams1,*,†,ChristineB.Phillips2,†,AksharPatel1andArianeMiddel3
1 CollegeofHealthSolutions,ArizonaStateUniversity,Phoenix,AZ85004,USA;aksharpatel@asu.edu
2 DepartmentofPsychology,ClemsonUniversity,Clemson,SC29634,USA;cbphill@clemson.edu
3 HerbergerInstituteforDesignandtheArts,SchoolofArts,MediaandEngineering,ArizonaStateUniversity,
Phoenix,AZ85004,USA;ariane.middel@asu.edu
* Correspondence:marc.adams@asu.edu;Tel.:+1-602-827-2470
† Theseauthorscontributedequallytothiswork.
Abstract:Thestudypurposewastotrainandvalidateadeeplearningapproachtodetectmicroscale
streetscape features related to pedestrian physical activity. This work innovates by combining
computervisiontechniqueswithGoogleStreetView(GSV)imagestoovercomeimpedimentsto
conductingaudits(e.g.,time,safety,andexpertlaborcost). TheEfficientNETB5architecturewas
usedtobuilddeeplearningmodelsforeightmicroscalefeaturesguidedbytheMicroscaleAuditof
PedestrianStreetscapesMinitool:sidewalks,sidewalkbuffers,curbcuts,zebraandlinecrosswalks,
walksignals,bikesymbols,andstreetlights. Weusedatrain–correctloop,wherebyimageswere
(cid:1)(cid:2)(cid:3)(cid:1)(cid:4)(cid:5)(cid:6)(cid:7)(cid:8)(cid:1) trainedonatrainingdataset,evaluatedusingaseparatevalidationdataset,andtrainedfurtheruntil
(cid:1)(cid:2)(cid:3)(cid:4)(cid:5)(cid:6)(cid:7)
acceptableperformancemetricswereachieved.Further,weusedtrainedmodelstoauditparticipant
Citation:Adams,M.A.;Phillips,C.B.;
(N=512)neighborhoodsintheWalkITArizonatrial.Correlationswereexploredbetweenmicroscale
Patel,A.;Middel,A.Training
featuresandGIS-measuredandparticipant-reportedneighborhoodmacroscalewalkability.Classifier
ComputerstoSeetheBuilt
precision, recall, andoverallaccuracywereallover>84%. Totalmicroscalewasassociatedwith
EnvironmentRelatedtoPhysical
overallmacroscalewalkability(r=0.30,p<0.001).Positiveassociationswerefoundbetweenmodel-
Activity:DetectionofMicroscale
detectedandself-reportedsidewalks(r=0.41,p<0.001)andsidewalkbuffers(r=0.26,p<0.001).
WalkabilityFeaturesUsingComputer
Vision.Int.J.Environ.Res.Public Thecomputervisionmodelresultssuggestanalternativetotrainedhumanraters,allowingforaudits
Health2022,19,4548. https:// ofhundredsorthousandsofneighborhoodsforpopulationsurveillanceorhypothesistesting.
doi.org/10.3390/ijerph19084548
Keywords: built environment; computer vision; deep learning; Google Street View; microscale;
AcademicEditors:RebeccaE.Lee,
walkability
JennieL.HillandJacobSzeszulski
Received:1March2022
Accepted:6April2022
Published:9April2022 1. Introduction
Publisher’sNote:MDPIstaysneutral The health and wellbeing benefits of physical activity and its environmental and
withregardtojurisdictionalclaimsin economicco-benefitsarewellestablished[1]. Ecologicalmodelspositandevidenceconsis-
publishedmapsandinstitutionalaffil- tentlyshowsthatapproachesforpromotingphysicalactivitymustaddressmultiplelevels
iations. ofinfluence,includingbuiltenvironments. Featuresofthebuiltenvironmentcaninfluence
physicalactivitybehaviorsdirectlythroughaccessibility,pedestriansafety,comfort,and
theaffectiveexperiencesofwalkingandactivetravel[1–7]. Inthecontextofbehavioral
interventions,evidencesuggeststhebuiltenvironmentinteractswithinterventioncom-
Copyright: © 2022 by the authors.
ponents to impact physical activity adoption and maintenance [3,8–11]. A supportive
Licensee MDPI, Basel, Switzerland.
builtenvironmentcanfacilitatewalkingandactivetravel[6,11],whileanunsupportive
This article is an open access article
environmentmaybeabarriertophysicalactivityengagement[6,11],warrantingbehavioral
distributed under the terms and
interventiontoovercome[8,9].
conditionsoftheCreativeCommons
Featuressupportiveofwalkingandactivetravelcanbemeasuredatthemacroscale
Attribution(CCBY)license(https://
usinggeographicinformationsystems(GIS)oratthemicroscale(street-level)within-person
creativecommons.org/licenses/by/
streetscapeaudits,andeithermaybeclosertomeasuringwhatexiststhanperceptions[12].
4.0/).
Int.J.Environ.Res.PublicHealth2022,19,4548.https://doi.org/10.3390/ijerph19084548 https://www.mdpi.com/journal/ijerph

Int.J.Environ.Res.PublicHealth2022,19,4548 2of16
Featuresmeasuredonamacroscale,suchasland-usemix,intersectiondensity,park,transit,
orresidentialdensity,aregenerallydifficulttomodifybutareeasilyassessedusingpublicly
availabledatasources. Microscalebuiltenvironmentfeaturessuchaspedestrianamenities
thatincreasethesafetyandcomfortofactivetravelcanexplainfurthervarianceinphysical
activity,evenafteradjustingformacroscalewalkability[4,13].
Microscalefeaturesaremorecost-effectivelymodifiedthanmacroscalefeaturesbut
aremeasuredmuchlessoften. Thisobservationislikelyduetothelimitedfeasibilityof
conductingneighborhoodstreetscapeaudits. Traditionalin-personmicroscaleauditsare
expensive,requireextensivetravelandaudittime,andexposeauditorstocrime,traffic,
andweathersafetyconcerns. Asaresult,relationshipsamongmicroscaleneighborhood
environments,physicalactivity,andthesharedhealth,environmental,andeconomicco-
benefitsofactiveliving[1]arenotbroadlyresearched. Substantialpopulationdifferences
may be linked to relatively inexpensive and easily modifiable street-level features, but
evidencetoshowinequitiesacrossneighborhoodsislacking.
VirtualmicroscaleauditsbyhumanratersusingonlinemappingtoolssuchasGoogle
StreetView(GSV)toscrolldownandauditastreetscapearereliablealternativestotradi-
tionalin-personaudits[14–22]. Virtualauditseffectivelyeliminatetravel,weather,and
safety challenges of standard in-person audits. However, virtual audits conducted by
humancontentexpertsremaintime-intensive[23–25],arelimitedtosmallareasorshort
routes[4,21],requireextensiveauditortrainingandretraining,andaresusceptibletoaudi-
torfatigue[26]. Thus,thescalabilityofvirtualauditsremainsdependentontheamountof
availabletrainedhumanlabor. Thechallengeofscalingin-personorvirtualauditstoassess
hundredsorthousandsofneighborhoodscontinuestobeaprimaryobstacletosurveillance
(e.g.,changesovertime)orhypothesistesting.
Combiningcomputer-enableddeeplearningandcomputervisiontechniquesisan
emergingapproachforincreasingthescalabilityofcollectingstreet-levelenvironmental
data. Deeplearningisasubsetofartificialintelligencethatusesalgorithms(i.e.,neural
networks)tolearntorecognizeandinterpretpatternsindata. Thealgorithmsusedindeep
learningareself-adaptive,meaningthatthenetworksgetsmarterwhengivenmoretraining
dataortrainingtime. Computervisionisabroadtermdescribinghowcomputersseeand
understanddigitalvisualdata. Whendeeplearningiscombinedwithcomputervision,
neural network models can be trained to recognize built environment patterns in GSV
imagesforclassificationtasks[27]suchasland-use(e.g.,buildingclassification[28],scene
classification(e.g.,perceivedstreetscapesafety[29])andobjectdetection(e.g.,detecting
andclassifyingautomobiles[30]orcatalogingtrees[31]).
Amongclassificationtasks,imageclassificationusingneuralnetworkshasbeenthe
most commonlyused approachfor remotely detecting specific features present in GSV
images. Forexample,Haraandcolleaguescombinedcrowdsourcingwithdeeplearning
andcomputervisiontodetectcurbrampsinGSVimagerytoassesssidewalkaccessibility
fordisabledindividuals[32]. Sincethen,othershaveworkedtoautomatethedetection
ofcurbcuts[33],crosswalks[34],andotherbuiltenvironmentobjectsvisibleinGSVim-
ages[35–37]. Forexample,Kooetal. selectedeightof150categoriesavailablefromthe
existingPyramidSceneParsingNetwork(PSPN)modeltorepresentmesoscalestreetscapes
includingbuilding,house,sidewalk,tree,road,grass,car,andplant[38]. Theycalculated
threeindicesfromthesecategories: building-to-streetratio,greenness,andsidewalk-to-
street proportion, and they found that the building-to-street ratio and greenness were
associatedwithreportedwalkingtrips. Theseadvanceshaveledtothepromiseofdevel-
opinganautomatedorsemi-automatedapproachforconductingpedestrianstreetscape
audits. However,thedevelopmentofautomatedmicroscaletoolsremainsanopenproblem.
Existingresearchreliesheavilyondeeplearningmodelsdevelopedforbroadclassifications,
whichwerenotdevelopedorvalidatedforfeaturesrelatedtophysicalactivity. Further-
more,customtrainedmodelsforphysicalactivity-relatedbehaviorsfocusedonasmall
numberofmicroscalefeatures(e.g.,curbramps),trainedand/orvalidatedmodelsinone
geographicregion(e.g.,Atlanta),didnotexaminehowmodel-detectedfeaturesalignwith

Int.J.Environ.Res.PublicHealth2022,19,4548 3of16
perceptionsoffeatures(orfeatureindices)byindividualslivinginevaluatedneighbor-
hoods,orsufferedsomecombinationsoftheseissues. Developingareliableandvalidated
automatedtoolfordetectingmicroscalefeaturesthatreducesrelianceonhumanlaboris
crucialtoaddressingcurrentissuesofscalability. Increasingscalabilitywillenablegreater
numbersofstudiesinvestigatingtheinfluenceofmicroscalebuiltenvironmentfeatures,as
wellasincludinglargerandmorediversesamplesofparticipantsandneighborhoodsto
allowgeneralizability.
Thecurrentstudyexploreswhethereightmicroscalefeaturesselectedmainlyfroman
existingvalidatedtool,theMicroscaleAuditofPedestrianStreetscapes(MAPS)Mini[13],
couldbereliablytrainedandvalidatedusingcomputervisionanddeeplearningtechniques
from a sample of GSV images across five cities. We further inferred the presence or
absence of these microscale features in GSV images within buffers around 512 homes
for participants enrolled in the baseline phase of the WalkIT Arizona physical activity
trial. Additionally,weexaminedthecorrelationsbetweenourautomatedmicro-scaleaudit
againstmacroscalewalkabilityandparticipantperceptionsoftheseneighborhoodfeatures
andrelatedsubscales.
Thispaperisstructuredasfollows:inSection2(MaterialsandMethods),weintroduce
the study design and participant recruitment for the walkability analysis, outline how
perceivedwalkabilityismeasured,anddetailhowmacroscalewalkabilityisdetermined
usingGIS.ForthemicroscalewalkabilityassessmentusingGSVimages,wepresenthow
microscalefeaturesarederivedfromtheimagesusingtrainingandvalidationdatasetsand
outlinetheclassifiertrainingandevaluationprocess. Wethenexplainhowneighborhood
microscale features are quantified and analyzed. In Section 3 (Results), we present the
imageclassifierperformanceandthemodelinferenceresults. Lastly,wediscusstheresults
inSection4andofferconclusions.
2. MaterialsandMethods
StudyDesignandParticipantRecruitment. Thecurrentstudyuseddatacollectedfrom
participantsenrolledintheWalkITArizonatrialasdescribedbyAdamsetal.[10]. Briefly,
participantenrollmentwasbalancedacrossfourneighborhoodtypesinMaricopaCounty,
AZ,accordingtocensusblockgroupsocioeconomicstatus(SES)andGIS-measuredmacro-
levelwalkability. Forparticipantsampling,wecomputedblockgroupSESandwalkability
usingavailablecensusmedianincomedataandpublicregionaldatasetsfornetresidential
density,landuse,intersectiondensity,andpublictransitdensity. FollowingFranketal.[6],
blockgroupsinthefirstthroughfifthdecilesofSESwerecategorizedas“lowerSES”and
those in the seventh through 10th deciles were categorized as “higher SES”. The sixth
decile was omitted to minimize mis-categorization for participants on the boundaries.
Similarly,blockgroupswererankedandcategorizedinto“lowerwalkable”(firstthrough
fourthdeciles)and“higherwalkable”(sevenththrough10thdeciles)withthefifthand
sixthwalkabilitydecilesexcludedtominimizethelikelihoodofmis-categorization. Finally,
blockgroupswereclassifiedaccordingtotheircombinedwalkabilityandSESyielding
fourneighborhoodstrata: “higherSES/higherwalkable”,“lowerSES/higherwalkable”,
“higherSES/lowerwalkable”,and“lowerSES/lowerwalkable”.Studymarketingmaterials
targetedeligibleblockgroupsfromthesestrata.
Enrolledparticipants(N=512)metthefollowinginclusioncriteria: (1)livedinone
ofthefourneighborhoodstratainMaricopaCounty,(2)18–60yearsofage,(3)generally
healthy,and(4)insufficientlyactive.Thenumberofparticipantsforeachneighborhoodtype
rangedfrom108inthe“lowerwalkable/lowerSES”to136inthe“higherwalkable/higher
income”and“lowerwalkable/higherincome”neighborhoods. Themeanagewas45.5
(SD=9.1) years, with the majority of the sample reporting being female (64.3%), white
(84%),non-HispanicorLatino(81.2%),andmarriedorlivingwithapartner(67.5%). The
samplereportedamedianhouseholdincomeof60,000–79,999USD,medianeducational
attainmentofcollegegraduate,amediandistancetoworkof10.1miles(16,316m),anda

Int.J.Environ.Res.PublicHealth2022,19,4548 4of16
mediantimeatcurrentresidenceof52months(seeAdamsetal.forfullinclusion/exclusion
criteriaandsamplecharacteristics[10]).
PerceivedWalkabilityAttributes.Participantsevaluatedtheirperceivedneighborhoodat-
tributesusingtheNeighborhoodEnvironmentWalkabilityScale(NEWS)[39],completedat
thebaselineappointment. SevenNEWSsubscaleswerecomputedusingscoringguidelines
publishedathttps://drjimsallis.org/Documents/Measures_documents/NEWS_scoring.
pdf(accessedon14March2015). Theseincludedresidentialdensity,proximitytononresi-
dentiallanduses,streetconnectivity,presenceofwalkingandcyclingfacilities,aesthetics,
traffic safety, and crime safety. Higher scores on each of the subscales and index score
indicatehigherperceivedwalkability. TheNEWSsubscaleshavedemonstratedgoodtoex-
cellenttest–retestreliabilityandtheabilitytodiscriminatebetweenhighandlowwalkable
neighborhoods[40,41].
GIS-MeasuredMacroscaleWalkability. Inadditiontoblockgroupwalkabilitydescribed
aboveforrecruitmentandenrollmentpurposes,wealsocalculatedindividual-levelwalka-
bilitycomponentsandtheoverallindexaroundenrolledparticipanthomes. Participants’
homeresidentialaddressesweregeocodedusingArcGIS10.5(ESRI,Redlands,CA,USA)
withUSCensusTigerlineaddressfeature. Geocodedaddresseswereusedtocreatea500m
“individual-level”bufferthroughoutthestreetnetworkandtogeoprocessspatialdatasets
andcreate“individual-level”GISvariablesforthefollowingcomponents: netresidential
density(i.e.,numberofhousingunitsdividedbyresidentialparcellandarea),land-usemix
(i.e.,diversityofseverallanduseswithnormalizedscoresrangingfrom0forsingleuseto
1indicatinganevendistributionacrossresidential,retail,recreational,office,civic,food,
andentertainmentparcellanduses),intersectiondensity(i.e.,numberofthree-legormore
intersections),andpublictransitaccess. Acompositewalkabilityindexwascalculatedwith
thefollowingformula: walkabilityindex=[(z-scorefornetresidentialdensity)+(z-score
forland-usemix)+(z-scoreforintersectiondensity)+(z-scorefortransitaccess)]. Figure1
providesavisualexampleofthesevariables.
Figure1. Exampleofindividual-levelbuffersandmacroscalewalkabilitycomponentsandindex
valuesforasingleparticipant’sneighborhood.Note:IntheexampleinFigure1,land-usemixshows
residential,recreational,andcivicuses.Otherlandusessuchasoffice,food,entertainment,andretail
werepossiblebutnotpresentinthisexample.
MicroscaleFeaturesandTrainingandValidationDatasets. Tocurateahigh-qualitydataset
oflabeledfeaturesforthemicroscalefeaturesofinterestfortrainingandvalidation,we

Int.J.Environ.Res.PublicHealth2022,19,4548 5of16
reliedonexistingGSVimagesofstreetintersectionsfromPhoenix,AZ(133,235images),
Washington,DC(20,784images),SanDiego,CA(8000images),Seattle,WA(8000images),
andBaltimore,MD(8578images). Inaddition,wereliedonnon-intersectionimagesin
Phoenix(1,331,994images). Theimageswereretrievedbetween2018and2019forurban
climatestudies[42–44]. Becauseimagesdidnotnecessarilycontainafeatureofinterest,
we relied on a larger set of images than used for any single feature. The advantage of
dividingtheimagesintotheseintersectionandnon-intersectioncategorieswastoallowus
touseonlyimagesthatwerenecessaryforaspecificimageclassifier. Forexample,totrain
azebracrosswalkclassifier,weonlyneededintersectionimages,and,forsidewalksand
sidewalkbuffers,werequiredbothintersectionandnon-intersectionimages. Thefollowing
classes were used to create their respective image classifiers: (1) sidewalk (2) sidewalk
buffer(3)curbcut(4)zebracrosswalk(5)linecrosswalk(6)walksignal(7)bikesymbol,
and(8)streetlight.
CreatingImageClassifiers. Tostudyassociationsbetweenmodel-detectedmicroscale
streetfeaturesandGIS-measuredandperceivedneighborhoodwalkability,wewantedthe
systemtodeterminethepresenceorabsenceofeachoftheeightstreetfeaturesatevery
auditpointwithinparticipants’neighborhoodnetworkbuffers. Toaccomplishthis,we
createdaseparateimageclassifierforeachstreetfeatureusingtheEfficientNetB5neural
architecture[45]. Foreachinputimage,theclassifieroutputtheprobabilityofstreetfeature
Int. J. Environ. Res. Public Health 2022, 19 presence(i.e.,crosswalk,curbcut,etc.) usingthevisualfeaturesitidentifiedint6h oef i1m6 age.
TheclassifiertrainingandevaluationprocessconsistedofthestepsshowninFigure2and
furtherdescribedbelow.
Figure2.Classifiertrainingandevaluationprocess.
Figure 2. Classifier training and evaluation process.
CreatingInitialMaricopaDatasets. Thefirststepincreatingourclassifierswastocreate
Training and Validation Loop: Using the initial training and validation datasets in place
asetofimageslabeledwiththeappropriateclassification(i.e.,presenceorabsenceofstreet
for each street feature, we trained a classifier to recognize the presence or absence of a
feature) to train the classifier and a separate set of labeled images to validate classifier
street feature in an image. Each step in the classifier training process was one pass through
performanceaftereachstepofthetrainingprocess. WeusedourknowledgeofPhoenix
the entire training dataset. After each step, the trained classifier was saved for potential
neighborhoods to select initial GSV images from existing image datasets to be used in
future use. The training continued until the classifier started overfitting or the perfor-
thetrainingandvalidationdatasets. Tolabelthedatasets,weusedtheopenannotation
mance metrics did not improve after each step. To prevent overfitting, we tracked training
and validation error values. We determined that the classifier had overfit when the train-
ing error continued to decrease but the validation error began to increase. When training
was complete, we selected the classifier with the best performance metrics from all the
saved classifiers while making sure that the classifier had not overfit [47].
For image sets with unsatisfactory performance metrics of the trained classifier, we
visually examined the validation dataset to understand false positive and false negative
results. We then found additional images from the Phoenix dataset that were similar to
the ones where the classifier failed, labeled them, and added them to the training dataset.
With the new training dataset, we restarted the training process.
Once the trained classifier performed well, we ran inference on additional Phoenix
images to understand how the classifier was performing on those additional images. If
the classifier identified the street features in the new images well, we considered that clas-
sifier to be trained. Otherwise, we tried to understand the images where the classifier
failed, labeled the images, added those and other similar labeled images to the training
and validation datasets, and restarted the training process.
We further improved the classifier by adding images from other cities (i.e., San Di-
ego, Washington DC, Seattle, and Baltimore) to the training datasets.
Considerations in Training the Classifiers: Single vs. Multiple Classifiers. We selected an
approach using a separate classifier for each feature instead of a single classifier that
would simultaneously detect all features because it allowed us to iterate and improve on
each feature classifier effectively and efficiently. Additionally, a single classifier approach
can be problematic due to the discrepancy in prevalence across features. Training a single

Int.J.Environ.Res.PublicHealth2022,19,4548 6of16
tool,wkentaro/labelme,availableat: https://zenodo.org/record/5711226#.YhzeS-jMJaQ
(accessedon10April2018)[46].
TrainingandValidationLoop: Usingtheinitialtrainingandvalidationdatasetsinplace
for each street feature, we trained a classifier to recognize the presence or absence of a
streetfeatureinanimage. Eachstepintheclassifiertrainingprocesswasonepassthrough
theentiretrainingdataset. Aftereachstep,thetrainedclassifierwassavedforpotential
futureuse. Thetrainingcontinueduntiltheclassifierstartedoverfittingortheperformance
metricsdidnotimproveaftereachstep. Topreventoverfitting,wetrackedtrainingand
validationerrorvalues. Wedeterminedthattheclassifierhadoverfitwhenthetraining
errorcontinuedtodecreasebutthevalidationerrorbegantoincrease. Whentrainingwas
complete,weselectedtheclassifierwiththebestperformancemetricsfromallthesaved
classifierswhilemakingsurethattheclassifierhadnotoverfit[47].
Forimagesetswithunsatisfactoryperformancemetricsofthetrainedclassifier,we
visuallyexaminedthevalidationdatasettounderstandfalsepositiveandfalsenegative
results. WethenfoundadditionalimagesfromthePhoenixdatasetthatweresimilartothe
oneswheretheclassifierfailed,labeledthem,andaddedthemtothetrainingdataset. With
thenewtrainingdataset,werestartedthetrainingprocess.
Oncethetrainedclassifierperformedwell,weraninferenceonadditionalPhoenix
imagestounderstandhowtheclassifierwasperformingonthoseadditionalimages. If
the classifier identified the street features in the new images well, we considered that
classifiertobetrained. Otherwise,wetriedtounderstandtheimageswheretheclassifier
failed,labeledtheimages,addedthoseandothersimilarlabeledimagestothetrainingand
validationdatasets,andrestartedthetrainingprocess.
Wefurtherimprovedtheclassifierbyaddingimagesfromothercities(i.e.,SanDiego,
WashingtonDC,Seattle,andBaltimore)tothetrainingdatasets.
ConsiderationsinTrainingtheClassifiers: Singlevs. MultipleClassifiers. Weselectedan
approachusingaseparateclassifierforeachfeatureinsteadofasingleclassifierthatwould
simultaneouslydetectallfeaturesbecauseitallowedustoiterateandimproveoneach
featureclassifiereffectivelyandefficiently. Additionally,asingleclassifierapproachcanbe
problematicduetothediscrepancyinprevalenceacrossfeatures. Trainingasingleclassifier
toimproveonaspecificfeaturethatislessprevalentinimages,suchasazebracrosswalk,
canleadtooverfitting[47]ondetectingafeaturethatishighlyprevalentinthedatasetsuch
asacurbcut. Thus,asingle-modelapproachmayrequiresettlingonapoorer-performing
modeloveralltobalancetheseissuesacrossfeatures.
SelectingtheClassifierArchitecture. Consideringtheresultsofhowdifferentneuralnet-
workarchitecturesperformedontheImageNetchallenge[48],aswellastheavailabilityof
pretrainedweights,wedecidedtobaseourclassifierontheEfficientNetB5[45]architecture.
SelectingaDeepLearningFramework. FrameworkssuchasTensorFlow,Keras,PyTorch,
Caffe,andFast.aiarepopularinthedeeplearningfieldtocreateneuralnetworksthatsolve
a variety of computer vision problems. We evaluated the different frameworks for the
purposeofcreatingimageclassifiersandselectedFast.ai[49]duetoitseaseofuse,inbuilt
dataaugmentationcapabilities,andthesimplicityofaccomplishingtransferlearning.
TransferLearning. TrainingaclassifierasdeepasEfficientNetB5isatime-consuming
process. Toreduceclassifiertrainingtimeandquicklyiteratetoimprovemodelperfor-
mance,weusedtransferlearning. Toachievetransferlearning,weusedweightsfroma
classifierpretrainedontheImageNetdatasetastheinitialweightsfortrainingourclas-
sifiers[50]. Thepretrainedclassifierscouldidentifypatternsfor~1000differentclasses,
whichfacilitatedtrainingourimageclassifiers.
DataAugmentationTechniques. Whenselectingthedataaugmentationtechniques,an
importantconsiderationwasensuringthataugmentingdidnotresultinlosinginformation
thatwascriticalfortheclassifiertoinferafeature. Forexample,ifasidewalkwasonly
asmallsectionoftheimageatoneoftheedges,zoom,crop,warp,cutout,androtation
augmentations could completely remove the sidewalk from the image, resulting in the

Int.J.Environ.Res.PublicHealth2022,19,4548 7of16
classifierlearningincompleteinformation. Thus,weappliedonlythreedataaugmentation
techniques: (1)horizontalflip,(2)brightness,and(3)contrastadjustments.
QuantifyingNeighborhoodMicroscaleFeatures. Thetrainedmodelswereusedtoinfer
(i.e., detect) eight street features in 765,869 previously unexamined photos available in
participantbuffersinPhoenix,AZ.Theprobabilitythresholdtoclassify“presence”ofa
detectedfeatureinimageswassetto≥0.50andusedforeachcardinaldirectionassociated
witheverycoordinate(i.e.,ifthemodelprobabilityofspecificfeaturepresenceinanimage
was≥0.50,weclassifiedthefeatureaspresent). Tocapturethepresenceofsidewalksona
blockregardlessofthesideofthestreet,weaveragedthefourmodel-detectedprobabilities
fromthefourdirectionalimages. Thisapproachwasusedforsidewalkstoensurewedid
notmisssidewalksonlyononesideoftheblockorvisibleinonlyoneofthefourimages.
Forsidewalkbuffers,weestimatedthepresenceofsidewalkbuffersforcoordinateswitha
model-detectedsidewalkonly.Tosummarizeeachparticipant’sneighborhood,wesummed
thecountofcoordinateswithpositiveinstancesofeachfeaturewithintheneighborhood
buffer and divided by the count of coordinates within the buffer to obtain an average
countofneighborhoodcoordinateswithpositiveinstancesofeachfeature. Becausethe
denominator (number of coordinates) could vary by intersection vs. non-intersection
feature,theaveragesofeachfeaturewerez-scoredtocreatearankingrelativetothesample
mean. A“totalmicroscalefeaturescore”foreachparticipant’shomeneighborhoodwas
createdbysummingindividualz-scoresforeachofthemicroscalefeaturesdetectedwithin
theneighborhoodbuffer.
AnalyticPlan. Theperformanceoftheimageclassifierwasassessedusingthevalida-
tiondatasetforPhoenix,AZ.Asthetaskwasclassifyingimagesbystreetfeaturepresenceor
absence,wecalculatedprecision,recall,negativepredictivevalue,specificity,andaccuracy
foreachfeature. Precisionwastheprobabilitythat,followingapositivemodel-detected
observation,theimagetrulyhadthefeaturepresent(i.e.,truepositives/truepositives+
falsepositives). Recallwastheprobabilitythatamodel-detectedobservationwastruly
present in an image (i.e., true positives/true positives + false negatives). Negative pre-
dictivevaluewastheprobabilitythat,followinganegativemodel-detectedobservation,
theimagetrulydidnothaveafeaturepresent(i.e.,truenegatives/truenegatives+false
negatives). Specificity was the proportion of images classified as not having a feature
among all images that truly did not have the feature present (i.e., true negatives/true
negatives+falsepositives). Accuracywastheprobabilityofacorrectobservation(i.e.,true
positives+truenegatives/allobservations).
Additionally, we examined the extent to which model-detected neighborhood mi-
croscalefeaturescorrespondedwithGIS-measuredmacro-levelwalkabilityandself-reported
neighborhoodwalkabilityattributes(i.e.,convergentvalidity)byconductingSpearman
rankcorrelationsbetween(1)model-detectedmicroscaleneighborhoodfeatures(z-scored
individualfeaturesandtotalmicro-scale)andGIS-measuredneighborhoodwalkability(z-
scoredindividualcomponentsandoverallwalkability),and(2)model-detectedmicroscale
neighborhoodfeatures(z-scoredindividualandtotalmicroscale)andparticipants’NEWS
items(e.g.,sidewalks,curbcuts)andsubscales(e.g.,walkingandcyclingfacilities).
3. Results
3.1. ImageClassifierPerformance
Eight image classifiers were trained to identify their respective street features (i.e.,
sidewalk, sidewalk buffer, curb cut, zebra crosswalk, line crosswalk, walk signal, bike
symbol, and streetlight). Table 1 provides the number of images used for training and
validationforeachoftheeightclassifiers.

| Int.J.Environ.Res.PublicHealth2022,19,4548 |     |     |     |     |     |     |     |     |     |     | 8of16 |
| ------------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- |
Table1.Summaryofthenumberofimagesusedfortrainingandvalidationdatasets.
ImageCounts
|     |     |     | Present |     |     |     | Absent |     |     |     | Total |
| --- | --- | --- | ------- | --- | --- | --- | ------ | --- | --- | --- | ----- |
Street
| Feature |     |     | Phoenix | Phoenix |     |     |     | Phoenix | Phoenix |     |     |
| ------- | --- | --- | ------- | ------- | --- | --- | --- | ------- | ------- | --- | --- |
|         | All | All |         |         | All |     | All |         |         |     |     |
Training Validation Only Only Training Validation Only Only Training Validation
|          |      |      | Training | Validation |      |     |      | Training | Validation |       |      |
| -------- | ---- | ---- | -------- | ---------- | ---- | --- | ---- | -------- | ---------- | ----- | ---- |
| Sidewalk | 8868 | 2851 | 5177     | 1745       | 3702 |     | 1254 | 2298     | 429        | 12570 | 4105 |
Sidewalk
|     | 3530 | 629 | 1519 | 347 | 6066 |     | 1773 | 4461 | 1567 | 9596 | 2402 |
| --- | ---- | --- | ---- | --- | ---- | --- | ---- | ---- | ---- | ---- | ---- |
buffer
| Curbcuts | 5947 | 599 | 2406 | 268 | 6059 |     | 767 | 2459 | 599 | 12006 | 1366 |
| -------- | ---- | --- | ---- | --- | ---- | --- | --- | ---- | --- | ----- | ---- |
Zebra
|     | 1687 | 2456 | 412 | 100 | 5604 |     | 6121 | 2971 | 879 | 7291 | 8577 |
| --- | ---- | ---- | --- | --- | ---- | --- | ---- | ---- | --- | ---- | ---- |
crosswalk
Line
|     | 1762 | 1053 | 1693 | 758 | 4057 |     | 2462 | 3798 | 2257 | 5819 | 3515 |
| --- | ---- | ---- | ---- | --- | ---- | --- | ---- | ---- | ---- | ---- | ---- |
crosswalk
Walk
|     | 3126 | 509 | 1951 | 216 | 4722 |     | 1221 | 2747 | 1014 | 7848 | 1730 |
| --- | ---- | --- | ---- | --- | ---- | --- | ---- | ---- | ---- | ---- | ---- |
Signal
| Bike | 1127 | 152 | 853 | 132 | 9306 |     | 2138 | 6908 | 2078 | 10433 | 2290 |
| ---- | ---- | --- | --- | --- | ---- | --- | ---- | ---- | ---- | ----- | ---- |
Symbol
| Streetlight | 1380 | 288 | 808 | 170 | 1213 |     | 273 | 761 | 171 | 2593 | 561 |
| ----------- | ---- | --- | --- | --- | ---- | --- | --- | --- | --- | ---- | --- |
The performance metrics for each of the image classifiers using the Phoenix, AZ
validationdatasetaredisplayedinTable2. Generally,accuracywashighandrangedfrom
99.59% for zebra crosswalks to 90.03% for streetlights. The precision values (when the
modelindicatedthepresenceofafeature,howlikelywasthemodeltobecorrectcompared
tohumanraters)rangedfrom100%forzebracrosswalksto86.73%forsidewalkbuffers.
Negative predive values (i.e., when the model indicated the absence of a feature, how
likelywasthemodeltobecorrectcomparedtohumanraters)rangedfrom99.66%forbike
symbolsto89.93%forsidewalks. SeeAppendixAforatableofvalidationperformance
usingpooleddatafromallfivecities.
Table2.ValidationperformanceofimageclassifiersforPhoenix,AZ.
Performance
StreetFeature
Negative
|     |     |     |     | Precision |     | Recall |     |     |     | Specificity | Accuracy |
| --- | --- | --- | --- | --------- | --- | ------ | --- | --- | --- | ----------- | -------- |
PredictiveValue
|     |     |     | Sidewalk       | 97.93% |     | 97.48% |     | 89.93% |     | 91.61% | 96.32% |
| --- | --- | --- | -------------- | ------ | --- | ------ | --- | ------ | --- | ------ | ------ |
|     |     |     | Sidewalkbuffer | 86.73% |     | 84.73% |     | 96.63% |     | 97.13% | 94.88% |
|     |     |     | Curbcut        | 95.38% |     | 92.54% |     | 96.71% |     | 98.00% | 96.31% |
|     |     |     | Zebracrosswalk | 100%   |     | 96.00% |     | 99.55% |     | 100%   | 99.59% |
|     |     |     | Linecrosswalk  | 95.97% |     | 94.20% |     | 98.06% |     | 98.67% | 97.55% |
|     |     |     | Walksignals    | 96.77% |     | 97.22% |     | 99.41% |     | 99.31% | 98.94% |
|     |     |     | Bikesymbols    | 93.28% |     | 94.70% |     | 99.66% |     | 99.57% | 99.28% |
|     |     |     | Streetlight    | 88.64% |     | 91.76% |     | 91.52% |     | 88.30% | 90.03% |
3.2. ModelInferenceResults
Theprevalenceofmodel-detectedfeaturesacrossthe512participantneighborhoods
inPhoenix,AZwashighestforsidewalks(89.8%),followedbystreetlights(31.5%),curb
cuts(26.2%),sidewalkbuffers(15.9%),linecrosswalks(4.9%),walksignals(3.7%),bike
symbols(0.5%),andzebracrosswalks(0.3%).
3.2.1. AssociationsbetweenModel-DetectedMicroscaleFeatureandGIS-Measured
Macro-LevelWalkability
Spearmancorrelationsbetweenmodel-detectedmicroscalefeaturesandGIS-measured
walkabilityattributesarepresentedinTable3. Themacroscalewalkabilityindexcorrelated

Int.J.Environ.Res.PublicHealth2022,19,4548 9of16
withninemicroscalefeatures,whilethefourindividualmacroscalecomponentscorrelated
withsevenmicroscalefeatures. Ageneralpatternofsignificantweak-to-moderatepositive
associationsexistedbetweenGIS-measuredmacroscalewalkabilityandmicroscalefeatures
(r=0.11to0.52,p<0.05). Thereweretwoexceptionstothispattern: (1)model-detected
curbcutshadweakbutsignificantnegativerelationshipswithintersectiondensity,transit
density,andoverallmacro-levelwalkability,and(2)GIS-measuredintersectiondensityhad
weakbutsignificantnegativeassociationswithmodel-detectedsidewalkbuffers,curbcuts,
linecrosswalks,walksignals,andthetotalmicroscalefeaturescore. Overall,themagnitude
ofassociationswithmodel-detectedmicroscalefeatureswasgreatestfortransitdensity,
land-usemixdiversity,andoverallGIS-measuredwalkability. Model-detectedmicroscale
features generally showing the greatest magnitude of associations with GIS-measured
walkabilitywerecrosswalks,walksignals,bikesymbols,streetlights,andtotalmicroscale
featurescores(r=0.19–0.52,p<0.05).
3.2.2. AssociationsbetweenModel-DetectedMicroscaleFeatureandPerceived
NeighborhoodWalkability
Spearmancorrelationsbetweenmodel-detectedmicroscalefeaturesandNEWSsub-
scaleswalkabilityattributesarepresentedinTable3. Subscalesforperceivedresidential
density,land-usemixdiversity,presenceofwalkingandcyclingfacilities,andperceived
aestheticswerepositivelyassociatedwithoneormoremodel-detectedmicroscalefeatures
(r=0.11–0.31). Significantnegativeassociationswerefoundbetweenmodel-detectedcurb
cutsandperceivedresidentialdensity(r=−0.19,p=0.000)andbetweenmodel-detected
sidewalksandperceivedaesthetics(r= −0.24, p=0.000). Perceivedstreetconnectivity,
pedestrian safety, and crime safety were not related to any model-detected microscale
featureortothetotalmicroscalefeaturescore. Amongmodel-detectedmicroscalefeatures
withcorrespondingindividualNEWSitems,thereweresignificantpositiveassociations
between model-detected and perceived sidewalks (r = 0.41, p = 0.000), model-detected
sidewalk buffers and perceived grass/dirt sidewalk buffers (r = 0.26, p = 0.000), and
model-detectedandperceivedcrosswalksandwalksignals(r=0.15,p<0.01).

Int.J.Environ.Res.PublicHealth2022,19,4548 10of16
Table3.Model-detectedmicroscalefeaturecorrelationswithGIS-measuredmacro-levelwalkabilityandperceivedNEWSscales.
Model-
Detected GIS-MeasuredMacroscaleNeighborhood
PerceivedNeighborhoodWalkability
Microscale Walkability
Feature
Residential Land-Use Intersection Transit Overall Residential Land-Use Street Walkingand Pedestrian Crime
|         | Mix       |         |         | Walkability |         | Mix       |              | Cycling    | Aesthetics |        |        |
| ------- | --------- | ------- | ------- | ----------- | ------- | --------- | ------------ | ---------- | ---------- | ------ | ------ |
| Density |           | Density | Density |             | Density |           | Connectivity |            |            | Safety | Safety |
|         | Diversity |         |         | Index       |         | Diversity |              | Facilities |            |        |        |
Sidewalks 0.12** 0.05 0.18** −0.06 0.02 −0.06 −0.02 −0.03 0.11* −0.24*** 0.01 −0.02
SidewalkBuffers 0.18*** 0.30*** −0.14** 0.01 0.17*** 0.07† −0.01 0.05 0.17*** 0.19** −0.08† 0.01
CurbCuts 0.04 0.16* −0.16*** −0.20*** −0.11* −0.19*** −0.06 0.06 0.17*** −0.03 0.08† 0.04
Zebracrosswalks 0.16*** −0.07 0.04 0.37*** 0.02 0.15** 0.04 −0.01 −0.04 −0.06 −0.04 −0.07
Linecrosswalks 0.06 0.42*** −0.14** 0.13** 0.39*** 0.28*** 0.24*** 0.01 0.02 0.03 −0.01 −0.02
| 0.07† |     | −0.12** |     |     |     |     |     |     |     | −0.01 | −0.03 |
| ----- | --- | ------- | --- | --- | --- | --- | --- | --- | --- | ----- | ----- |
Allcrosswalks 0.39*** 0.38** 0.38*** 0.30*** 0.23*** 0.00 0.01 0.01
|     |     | −0.10* |     |     |     |     |     |     |     | −0.07† | −0.07 |
| --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | ------ | ----- |
WalkSignals 0.09* 0.37*** 0.52*** 0.46*** 0.31*** 0.23** 0.02 0.00 0.07
|     |     |     |     |     |     |     | −0.01 |     | −0.03 | −0.03 | −0.05 |
| --- | --- | --- | --- | --- | --- | --- | ----- | --- | ----- | ----- | ----- |
BikeSymbols 0.17** 0.22*** 0.06 0.20*** 0.28*** 0.25*** 0.15** 0.02
Streetlights 0.23*** 0.38*** 0.00 0.12** 0.35*** 0.17*** 0.07 −0.00 0.14** −0.03 −0.06 −0.07
TotalMicroscale 0.19*** 0.38*** −0.12* 0.11* 0.30*** 0.13** 0.07† 0.02 0.21*** 0.04 −0.02 −0.02
Notes:Spearmanrankcorrelationcoefficients.†p<0.10,*p<0.05,**p<0.01,***p<0.001.Model-detectedfeatureswereassessedbyz-scoringtheaveragecountofpositivefeature
instancesforcoordinateswithina500mstreetnetworkbufferaroundparticipants’homes. PerceivedneighborhoodfeatureswereassessedbytheNeighborhoodEnvironment
WalkabilityScale(NEWS).Allcrosswalks=sumofzebraandlinecrosswalks.Totalmicroscalescore=sumofz-scoreaveragesforbikesymbols,allcrosswalks,curbcuts,walksignals,
sidewalks,sidewalkbuffers,andstreetlightswithineachparticipant’s500mneighborhoodbuffer.

Int.J.Environ.Res.PublicHealth2022,19,4548 11of16
4. Discussion
Thispaperdemonstratesthattheuseofcomputervisiontodetectintersectionand
streetsegmentfeaturesthatareconceptuallyrelatedtopedestrianphysicalactivity(i.e.,
zebra and line crosswalks, curb ramps, walk signals, sidewalks, sidewalk buffers, bike
symbols, and streetlights) is feasible with high correspondence to human raters. Indi-
vidualmicroscalefeaturesandasummaryindexofmicroscalefeaturescorrelatedwith
bothGIS-measuredmacroscalewalkabilityandwithhumanparticipants’reportsoftheir
neighborhoodenvironment. Theseexpectedcorrelationsofferadegreeofvalidlytothe
computer vision models of microscale features. The development of machine learning
modelsfordetectingmicroscalefeaturesopensthepossibilityofconductingresearchacross
broadregionsandnewresearchquestions.
Computer model-detected microscale features correlated with both the individual
componentsofmacroscalewalkabilityandthemacroscalewalkabilityindexaroundpar-
ticipant neighborhoods in Phoenix. These correlations were expected, as higher levels
ofmacroscalewalkabilityareoftencomplementedbyimprovementstomoreaffordable
microscaleimprovements(e.g.,curbcuts,sidewalks)thatfurtherenhancethestreetscape.
Previousstudieshaveshownthatindividualmicroscalefeaturesandmacroscalewalkabil-
ityindicesareweaklytomoderatelycorrelated,withbothcontributinguniquemeasures
of the built environment for walking [4]. While most component correlations between
macro-andmicroscalefeatureswerepositive,themacroscalecomponentofintersection
densitywasnegativelycorrelatedwithallmicroscalefeaturesexceptsidewalks. Higher
intersectiondensitiesaretypicallyobservedindenserurbansettingswithshorter,more
connectedstreetblocks. Onecouldexpecturbansettingswithshorterblockstohavea
greaterprevalenceofsidewalksandrelatedsafetyfeaturessuchascrosswalksandcurbcuts;
however,theWalkITAZparticipants’perceptionsofstreetconnectivityandpedestrian
safetysurprisinglydidnotcorrelatewithanymodel-detectedfeatures.
Model-detectedmicroscalefeaturescorrelatedwithfourperceivedsubscalesofthe
builtenvironment,specificallyresidentialdensity,land-usemix,walkingandcyclingfacili-
ties,andaesthetics.WalkITparticipantsevaluatedtheirneighborhoodsusingthepreviously
validatedNEWS,whichhasbeenvalidatedagainstGIS-measuredmacroscalefeaturesand
used in dozens of studies as a predictor of pedestrian walking for transportation with
weaktomoderatecorrelations(i.e.,r<0.40)[40,41]. TheNEWSdoesnotofferanindexto
summarizeitssevensubscales,butourindexofmodel-detectedmicroscalefeaturesdid
correlatewithperceivedresidentialdensityandwalkingandcyclingfacilitiessubscales
(r=0.13and0.21,respectively). Thestrongestmicroscalerelationshipsoccurredfortheresi-
dentialdensitysubscale,whichhadeightsignificantcorrelations,withmodel-detectedwalk
signalsandcombinedcrosswalks(zebraandline)correlatingthestrongest(r=0.30–0.31).
Thissuggeststhathigherlevelsofmodel-detectedsafetyfeaturesforpedestrianscorrelated
withhigherlevelsofindependentperceptionsofresidentialdensity, whichalignswith
expectationsthatthesefeatureswouldbemoreprevalentinareaswithmorepeople. The
presentresultswereconsistentwithpreviousstudiesshowingweaktomodestagreement
betweenobjectiveandsubjectiveassessmentsofneighborhoodwalkabilityoverall,with
lowerconcordanceamongthosewithlessphysicalactivityandhigherBMI[12,51]. Because
the current study included only insufficiently active individuals with a median BMI of
33.0, results may not generalize to other populations. However, considering previous
research[41],wewouldexpecthighercorrespondencebetweenmodel-detectedfeatures
andperceivedneighborhoodwalkabilityinamorephysicallyactivesample.
MethodologicalConsiderations. Twomajorstrengthsshouldbenoted. First,inprevious
studies,humanratersauditedonlypartsofparticipantneighborhoods—usuallylimited
toaquartermilerouteorsampleofblocksinaneighborhood—byinpersonorvirtual
observation. The current computer vision approach was used to audit all blocks and
crossingsfortheentireneighborhoodforallparticipants,limitedonlybythenumberof
GSVphotosavailableandthetimeframeofthestudy. Second,WalkITparticipantswere
purposefullyrecruitedinsimilarnumbersfromneighborhoodshighandlowinwalkability

Int.J.Environ.Res.PublicHealth2022,19,4548 12of16
andhighandlowinneighborhoodsocioeconomicstatus. Therefore,ouranalysesinvolving
microscale,macroscale,andparticipantperceptionsreflectthefullspectrumofwalkability
andincomeenvironmentspresentinthePhoenix,AZregion.
However,ourmodelswerelimitedtosevenofthe15featuresassessedbytheMAPS
Mini roadmap. Future work will focus on developing models for detecting additional
microscalefeaturessupportiveofphysicalactivity(e.g.,benchesimportantforolderadults).
Several MAPS Mini items, such as transit stops and public parks, are now commonly
included in publicly available datasets, making it possible to conduct audits using GIS
technology. Otheritems,suchasbuildingandsidewalkdisrepairorgraffitiaredifficultto
observefromtheperspectiveofomnidirectionalcameras,requiresubjectiveorqualitative
judgement,oraremoretransientinnature. Alternativeartificialintelligencemethodologies
havebeensuggestedtoovercomethescalabilitychallengesassociatedwithassessingthese
items. For example, Athens et al. [52] applied a natural language processing approach
todetectsidewalkmaintenance,buildingsafety,andotherurbanblightindicatorsfrom
311data,whilePingetal.[53]leveragedcitygarbagetrucksequippedwithvideocameras
combinedwithedgecomputingtechnologytodevelopadeeplearningmodelfordetecting
andclassifyingstreetlitter. Acombinationofapproacheswilllikelybeneededtoprovidea
comprehensivecharacterizationofmicroscaleneighborhoodstreetscapesonalargescale.
Severalconsiderationsalsoshouldbenotedinthedevelopmentofcomputervision
models. First,weexploredexistingannotatedimagedatasetssuchasMapillary[54]and
CAMVID [55] and found that labeling did not capture the features of interest, as well
asledtoincorrectclassificationsandbucketingofcategories,whichprecludedutilizing
existingdatasetsanddevelopinggoodcomputervisionmodelsofthefeaturesofinterest.
Second,whileastandardizednumberofimagesforeachfeaturefortrainingandvalidation
datasetswouldhavebeenconceptuallyclearertoreport,wefoundthatadditionaltraining
orvalidationimageswereneededforcertainfeatures(e.g.,bikesymbols,zebracrosswalks)
becauseofthelowprevalenceofsuchfeaturesinthePhoenix,AZregion. Wealsocollected
agreaternumberoftrainingsamplestoensurethatwecapturedinherentvariabilityin
featuredesignandphotosoffeaturesthatexistintherealworldinthetrainingdataset.
Forexample,thevariabilityinthedesignofcrosswalksvariesevenbysmallgeographic
regionstoincludedifferentpatternsandcolors(e.g.,crosswalkwithLGBTrainbowflag
colors). We also considered image artefacts (e.g., shadows that appear similar to zebra
crossings,distancefromGSVcameratostreetlight)thatresultedinsmallorfuzzytraining
samples. In addition, some photo elements confused the models (e.g., actual bike vs.
painted bike symbol) and necessitated additional training samples. Although results
presentedinthecurrentanalysesusedaPhoenix,AZvalidationdataset,weexpectthatthe
generalizabilityofourtrainedclassifierswasenhancedwiththeinclusionofimagesfrom
fouradditionalgeographicallydiversecities(i.e.,Seattle,SanDiego,Washington,D.C.,and
Baltimore)intheclassifiertraining(seeAppendixATableA1). Toscaleupresultstocities
aroundtheglobe,imagesfromothercountrieswouldhavetobeincludedinthetraining
dataset,becausestreetfeaturessuchassidewalksandcrossingsdonotfollowinternational
standards.
5. Conclusions
Thecurrentresultsdemonstratethatcomputervisionmodelscanreliablyconduct
neighborhoodauditsofpedestrianstreetscapefeatures. Ourmodelresultscorrelatewith
bothobjectiveandself-reportedmacroscaleneighborhoodwalkability. Futureresearch
willexaminetherelationshipbetweenmodel-detectedmicroscalefeaturesandphysical
activityandchronicdiseaseoutcomes. Thecomputervisionapproachtoauditingneigh-
borhoodspromisestoacceleratethepaceofmicroscaleresearchandopensnewlinesof
microscaleresearchforurbanplanningandpublichealth. Resultssuggestthatautomated
virtualstreetscapeauditsmayprovideascalablealternativetohumanaudits,enabling
advancementsinthefieldcurrentlyconstrainedbytimeandcost. Reducingrelianceon
trainedauditorswillenablescalingupauditstoassesshundredsorthousandsofneighbor-

Int.J.Environ.Res.PublicHealth2022,19,4548 13of16
hoodsorevenentirecitiesforsurveillance,hypothesistesting,identifyingenvironmental
disparities,orchangedetectionresearchrelatedtopedestrianstreetscapes. Forexample,
given sufficient resources, such models could be applied at scale to map all sidewalks
intheUS,evaluatewhethermotivationalphysicalactivityinterventionsperformbetter
inneighborhoodswithmorevs. fewersidewalks,determinewhethertheprevalenceof
sidewalksdiffersbyneighborhoodsthatvarybyrace/ethnicityorincome,orevenevaluate
changeinsidewalksbeforeandafteranewdevelopmentorpassageofacompletestreet
policyortransportationinfrastructuretax. Thisworkalsohaspotentiallyimportantimpli-
cationsforurbanmunicipalitydecision-makers. Whilepreviousworkhaslargelyfocused
onmacroscalewalkabilityduetoeaseofmeasurement,itisoftennotfeasibletochange
theseaspectsofthebuiltenvironmentduetocomplexityandcost. However,microscale
featurescanbemoreeasilyandcost-effectivelymodifiedthanmacroscaleelements. Thus,
large-scalemicroscaleauditscanenablemunicipalitiestomakewell-informeddecisions
aboutstreetscapeenhancementsthatequitablypromotephysicalactivitywithinbudgetary
constraints.
AuthorContributions: Conceptualization, M.A.A.andC.B.P.; datacuration, M.A.A., C.B.P., A.P.
andA.M.;formalanalysis,M.A.A.andC.B.P.;fundingacquisition,M.A.A.andC.B.P.;investigation,
M.A.A.,C.B.P.andA.M.;methodology,M.A.A.,C.B.P.,A.P.andA.M.;projectadministration,M.A.A.,
C.B.P.andA.P.;resources,M.A.A.,C.B.P.,A.P.andA.M.;software,M.A.A.,C.B.P.,A.P.andA.M.;
supervision, C.B.P.andA.P.; validation, M.A.A., C.B.P.andA.P.; visualization, M.A.A.andA.P.;
writing—originaldraft,M.A.A.,C.B.P.andA.P.;writing—reviewandediting,A.M.Allauthorshave
readandagreedtothepublishedversionofthemanuscript.
Funding:ThisresearchwasfundedbytheNationalInstitutesofHealththroughanadministrative
supplementtotheparentgrant(#R01CA198915,PI:Adams).ItwasalsosupportedbytheNational
ScienceFoundation(#CMMI-1942805CAREER:HumanThermalExposureinCities—NovelSensing
andModelingtoBuildHeatResilience,PI:Middel). Anyopinions,findings,andconclusionsor
recommendationsexpressedinthismaterialarethoseoftheauthorsanddonotnecessarilyreflect
theviewsofthesponsoringorganizations.
InstitutionalReviewBoardStatement: ThestudywasconductedinaccordancewiththeDecla-
ration of Helsinki and approved by the Institutional Review Board of Arizona State University
(STUDY00003608approved21December2015).
InformedConsentStatement:Informedconsentwasobtainedfromallsubjectsinvolvedinthestudy.
DataAvailabilityStatement: Thedatapresentedinthisstudyareavailableonrequestfromthe
correspondingauthor.Thedataarenotpubliclyavailableduetoongoingdataanalysesrelatedto
aimsofthegrant.
Acknowledgments:TheauthorsspeciallythankAlisonCantley,HannahHook,andTsung-Yen(John)
Yufordatacollectionandprogramming,alongwithmanyundergraduateandgraduateresearch
assistantsforhelpingwithdatacollection.
ConflictsofInterest:Theauthorsdeclarenoconflictofinterest.Thefundershadnoroleinthedesign
ofthestudy;inthecollection,analyses,orinterpretationofdata;inthewritingofthemanuscript,or
inthedecisiontopublishtheresults.
AppendixA
TableA1.ValidationperformanceofimageclassifiersinpooleddatasetincludingPhoenixAZ,San
DiegoCA,WashingtonD.C.,SeattleWA,andBaltimoreMD.
Performance
StreetFeature Negative
Precision Recall Specificity Accuracy
PredictiveValue
Sidewalk 97.25% 96.81% 92.82% 93.78% 95.88%
Sidewalkbuffer 87.10% 85.85% 95.01% 95.49% 92.96%

Int.J.Environ.Res.PublicHealth2022,19,4548 14of16
TableA1.Cont.
Performance
StreetFeature Negative
Precision Recall Specificity Accuracy
PredictiveValue
Curbcut 83.21% 65.86% 52.32% 73.81% 68.54%
Zebracrosswalk 97.33% 84.97% 93.61% 98.95% 94.62%
Linecrosswalk 89.20% 75.59% 71.20% 86.83% 80.20%
Walksignals 86.00% 73.38% 68.80% 83.09% 77.40%
Bikesymbols 95.00% 95.00% 98.33% 98.33% 97.50%
Streetlight 84.30% 86.44% 83.84% 81.37% 84.09%
References
1. Sallis,J.F.;Spoon,C.;Cavill,N.;Engelberg,J.K.;Gebel,K.;Parker,M.;Thornton,C.M.;Lou,D.;Wilson,A.L.;Cutter,C.L.;etal.
Co-benefitsofdesigningcommunitiesforactiveliving:Anexplorationofliterature.Int.J.Behav.Nutr.Phys.Act.2015,12,30.
[CrossRef][PubMed]
2. Alfonzo,M.;Boarnet,M.G.;Day,K.;Mcmillan,T.;Anderson,C.L.Therelationshipofneighbourhoodbuiltenvironmentfeatures
andadultparents’walking.J.UrbanDes.2008,13,29–51.[CrossRef]
3. Sallis,J.F.;Cerin,E.;Kerr,J.;Adams,M.A.;Sugiyama,T.;Christiansen,L.B.;Schipperijn,J.;Davey,R.;Salvo,D.;Frank,L.D.;etal.
BuiltEnvironment,PhysicalActivity,andObesity:FindingsfromtheInternationalPhysicalActivityandEnvironmentNetwork
(IPEN)AdultStudy.Annu.Rev.PublicHealth2020,41,119–139.[CrossRef][PubMed]
4. Cain,K.L.;Millstein,R.A.;Sallis,J.F.;Conway,T.L.;Gavand,K.A.;Frank,L.D.;Saelens,B.E.;Geremia,C.M.;Chapman,J.;Adams,
M.A.;etal. ContributionofstreetscapeauditstoexplanationofphysicalactivityinfouragegroupsbasedontheMicroscale
AuditofPedestrianStreetscapes(MAPS).Soc.Sci.Med.2014,116,82–92.[CrossRef]
5. Casagrande,S.S.;Whitt-Glover,M.C.;Lancaster,K.J.;Odoms-Young,A.M.;Gary,T.L.Builtenvironmentandhealthbehaviors
amongAfricanAmericans:Asystematicreview.Am.J.Prev.Med.2009,36,174–181.[CrossRef]
6. Frank, L.D.; Sallis, J.F.; Saelens, B.E.; Leary, L.; Cain, K.; Conway, T.L.; Hess, P.M.Thedevelopmentofawalkabilityindex:
ApplicationtotheNeighborhoodQualityofLifeStudy.Br.J.SportsMed.2010,44,924–933.[CrossRef]
7. Bornioli,A.;Parkhurst,G.;Morgan,P.L.Affectiveexperiencesofbuiltenvironmentsandthepromotionofurbanwalking.Transp.
Res.PartAPolicyPract.2019,123,200–215.[CrossRef]
8. Kerr,J.;Norman,G.J.;Adams,M.A.;Ryan,S.;Frank,L.;Sallis,J.F.;Calfas,K.J.;Patrick,K.Doneighborhoodenvironments
moderatetheeffectofphysicalactivitylifestyleinterventionsinadults?HealthPlace2010,16,903–908.[CrossRef]
9. Adams,M.A.;Hurley,J.C.;Todd,M.;Bhuiyan,N.;Jarrett,C.L.;Tucker,W.J.;Hollingshead,K.E.;Angadi,S.S.Adaptivegoal
settingandfinancialincentives:A2×2factorialrandomizedcontrolledtrialtoincreaseadults’physicalactivity.BMCPublic
Health2017,17,286.[CrossRef]
10. Adams,M.A.;Hurley,J.C.;Phillips,C.B.;Todd,M.;Angadi,S.S.;Berardi,V.;Hovell,M.F.;Hooker,S.Rationale,design,and
baselinecharacteristicsofWalkITArizona:Afactorialrandomizedtrialtestingadaptivegoalsandfinancialreinforcementto
increasewalkingacrosshigherandlowerwalkableneighborhoods.Contemp.Clin.Trials2019,81,87–101.[CrossRef]
11. Mayne,D.J.;Morgan,G.G.;Jalaludin,B.B.;Bauman,A.E.Thecontributionofarea-levelwalkabilitytogeographicvariationin
physicalactivity:Aspatialanalysisof95,837participantsfromthe45andUpStudylivinginSydney,Australia.Popul.Health
Metr.2017,15,38.[CrossRef][PubMed]
12. Gebel,K.;Bauman,A.E.;Sugiyama,T.;Owen,N.Mismatchbetweenperceivedandobjectivelyassessedneighborhoodwalkability
attributes:Prospectiverelationshipswithwalkingandweightgain.HealthPlace2011,17,519–524.[CrossRef][PubMed]
13. Sallis,J.F.;Cain,K.L.;Conway,T.L.;Gavand,K.A.;Millstein,R.A.;Geremia,C.M.;Frank,L.D.;Saelens,B.E.;Glanz,K.;King,
A.C.Isyourneighborhooddesignedtosupportphysicalactivity?Abriefstreetscapeaudittool.Prev.ChronicDis.2015,12,E141.
[CrossRef][PubMed]
14. Phillips,C.B.;Engelberg,J.K.;Geremia,C.M.;Zhu,W.;Kurka,J.M.;Cain,K.L.;Sallis,J.F.;Conway,T.L.;Adams,M.A.Online
versusin-personcomparisonofMicroscaleAuditofPedestrianStreetscapes(MAPS)assessments:Reliabilityofalternatemethods.
Int.J.HealthGeogr.2017,16,27.[CrossRef][PubMed]
15. Ben-Joseph,E.;Lee,J.S.;Cromley,E.K.;Laden,F.;Troped,P.J.Virtualandactual: Relativeaccuracyofon-siteandweb-based
instrumentsinauditingtheenvironmentforphysicalactivity.HealthPlace2013,19,138–150.[CrossRef]
16. Kurka,J.M.;Adams,M.A.;Geremia,C.;Zhu,W.;Cain,K.L.;Conway,T.L.;Sallis,J.F.Comparisonoffieldandonlineobservations
for measuring land uses using the Microscale Audit of Pedestrian Streetscapes (MAPS). J. Transp. Health 2016, 3, 278–286.
[CrossRef]

Int.J.Environ.Res.PublicHealth2022,19,4548 15of16
17. Zhu,W.;Sun,Y.;Kurka,J.;Geremia,C.;Engelberg,J.K.;Cain,K.;Conway,T.;Sallis,J.F.;Hooker,S.P.;Adams,M.A.Reliability
betweenonlineraterswithvaryingfamiliaritiesofaregion:MicroscaleAuditofPedestrianStreetscapes(MAPS).Landsc.Urban
Plan.2017,167,240–248.[CrossRef]
18. Clarke,P.;Ailshire,J.;Melendez,R.;Bader,M.;Morenoff,J.UsingGoogleEarthtoconductaneighborhoodaudit:Reliabilityofa
virtualauditinstrument.HealthPlace2010,16,1224–1229.[CrossRef]
19. Rundle,A.G.;Bader,M.D.M.;Richards,C.A.;Neckerman,K.M.;Teitler,J.O.UsingGoogleStreetViewtoauditneighborhood
environments.Am.J.Prev.Med.2011,40,94–100.[CrossRef]
20. Silva,V.;Grande,A.J.;Rech,C.R.;Peccin,M.S.Geoprocessingviagooglemapsforassessingobesogenicbuiltenvironments
relatedtophysicalactivityandchronicnoncommunicablediseases: Validityandreliability. J.Healthc. Eng. 2015, 6, 41–54.
[CrossRef]
21. Vanwolleghem,G.;Ghekiere,A.;Cardon,G.;DeBourdeaudhuij,I.;D’Haese,S.;Geremia,C.M.;Lenoir,M.;Sallis,J.F.;Verhoeven,
H.;VanDyck,D.Usinganaudittool(MAPSGlobal)toassessthecharacteristicsofthephysicalenvironmentrelatedtowalking
fortransportinyouth:ReliabilityofBelgiandata.Int.J.HealthGeogr.2016,15,41.[CrossRef][PubMed]
22. Vanwolleghem,G.;VanDyck,D.;Ducheyne,F.;DeBourdeaudhuij,I.;Cardon,G.Assessingtheenvironmentalcharacteristicsof
cyclingroutestoschool:AstudyonthereliabilityandvalidityofaGoogleStreetView-basedaudit.Int.J.HealthGeogr.2014,13,
19.[CrossRef][PubMed]
23. Wilson,J.S.;Kelly,C.M.;Schootman,M.;Baker,E.A.;Banerjee,A.;Clennin,M.;Miller,D.K.Assessingthebuiltenvironmentusing
omnidirectionalimagery.Am.J.Prev.Med.2012,42,193–199.[CrossRef][PubMed]
24. Badland,H.M.;Opit,S.;Witten,K.;Kearns,R.A.;Mavoa,S.Canvirtualstreetscapeauditsreliablyreplacephysicalstreetscape
audits?J.UrbanHealth2010,87,1007–1016.[CrossRef][PubMed]
25. Yi, L.; Wu, T.; Luo, W.; Zhou, W.; Wu, J.Anon-invasive, rapidmethodtogenotypelate-onsetAlzheimer’sdisease-related
apolipoproteinEgenepolymorphisms.NeuralRegen.Res.2014,9,69–75.[CrossRef][PubMed]
26. Bader,M.D.M.;Mooney,S.J.;Lee,Y.J.;Sheehan,D.;Neckerman,K.M.;Rundle,A.G.;Teitler,J.O.Developmentanddeploymentof
theComputerAssistedNeighborhoodVisualAssessmentSystem(CANVAS)tomeasurehealth-relatedneighborhoodconditions.
HealthPlace2015,31,163–172.[CrossRef]
27. Ma,L.;Liu,Y.;Zhang,X.;Ye,Y.;Yin,G.;Johnson,B.A.Deeplearninginremotesensingapplications:Ameta-analysisandreview.
ISPRSJ.Photogramm.RemoteSens.2019,152,166–177.[CrossRef]
28. Kang,J.;Körner,M.;Wang,Y.;Taubenböck,H.;Zhu,X.X.Buildinginstanceclassificationusingstreetviewimages. ISPRSJ.
Photogramm.RemoteSens.2018,145,44–59.[CrossRef]
29. Naik,N.;Philipoom,J.;Raskar,R.;Hidalgo,C.Streetscore—PredictingthePerceivedSafetyofOneMillionStreetscapes. In
Proceedingsofthe2014IEEEConferenceonComputerVisionandPatternRecognitionWorkshops,Columbus,OH,USA,23–28
June2014;pp.793–799.
30. Gebru, T.; Krause, J.; Wang, Y.; Chen, D.; Deng, J.; Aiden, E.L.; Fei-Fei, L. Using deep learning and Google Street View to
estimatethedemographicmakeupofneighborhoodsacrosstheUnitedStates.Proc.Natl.Acad.Sci.USA2017,114,13108–13113.
[CrossRef]
31. Branson,S.;Wegner,J.D.;Hall,D.;Lang,N.;Schindler,K.;Perona,P.FromGoogleMapstoafine-grainedcatalogofstreettrees.
ISPRSJ.Photogramm.RemoteSens.2018,135,13–30.[CrossRef]
32. Hara,K.;Sun,J.;Moore,R.;Jacobs,D.;Froehlich,J.Tohme:Detectingcurbrampsingooglestreetviewusingcrowdsourcing,
computervision,andmachinelearning. InProceedingsofthe27thannualACMsymposiumonUserinterfacesoftwareand
technology—UIST’14,Honolulu,HI,USA,5–8October2014;ACMPress:NewYork,NY,USA,2014;pp.189–204.
33. Abbott,A.;Deshowitz,A.;Murray,D.;Larson,E.C.WalkNet:ADeepLearningApproachtoImprovingSidewalkQualityand
Accessibility.SMUDataSci.Rev.2018,1,7.
34. Berriel,R.F.;Rossi,F.S.;deSouza,A.F.;Oliveira-Santos,T.Automaticlarge-scaledataacquisitionviacrowdsourcingforcrosswalk
classification:Adeeplearningapproach.Comput.Graph.2017,68,32–42.[CrossRef]
35. Krylov,V.;Kenny,E.;Dahyot,R.AutomaticDiscoveryandGeotaggingofObjectsfromStreetViewImagery.RemoteSens.2018,
10,661.[CrossRef]
36. Balali,V.;AshouriRad,A.;Golparvar-Fard,M.Detection,classification,andmappingofU.S.trafficsignsusinggooglestreet
viewimagesforroadwayinventorymanagement.Vis.Eng.2015,3,15.[CrossRef]
37. Hebbalaguppe, R.; Garg, G.; Hassan, E.; Ghosh, H.; Verma, A. Telecom inventory management via object recognition and
localisationongooglestreetviewimages. InProceedingsofthe2017IEEEWinterConferenceonApplicationsofComputer
Vision(WACV),SantaRosa,CA,USA,24–31March2017;pp.725–733.
38. Koo,B.W.;Guhathakurta,S.;Botchwey,N.HowareNeighborhoodandStreet-LevelWalkabilityFactorsAssociatedwithWalking
Behaviors?ABigDataApproachUsingStreetViewImages.Environ.Behav.2021,54,211–241.[CrossRef]
39. Saelens, B.E.; Sallis, J.F.; Black, J.B.; Chen, D. Neighborhood-based differences in physical activity: An environment scale
evaluation.Am.J.PublicHealth2003,93,1552–1558.[CrossRef][PubMed]
40. Cerin,E.;Conway,T.L.;Saelens,B.E.;Frank,L.D.;Sallis,J.F.Cross-validationofthefactorialstructureoftheNeighborhood
EnvironmentWalkabilityScale(NEWS)anditsabbreviatedform(NEWS-A).Int.J.Behav.Nutr.Phys.Act.2009,6,32.[CrossRef]

Int.J.Environ.Res.PublicHealth2022,19,4548 16of16
41. Adams,M.A.;Ryan,S.;Kerr,J.;Sallis,J.F.;Patrick,K.;Frank,L.D.;Norman,G.J.ValidationoftheNeighborhoodEnvironment
WalkabilityScale(NEWS)itemsusinggeographicinformationsystems. J.Phys. Act. Health2009,6(Suppl. S1),S113–S123.
[CrossRef]
42. Ching,J.;Aliaga,D.;Mills,G.;Masson,V.;See,L.;Neophytou,M.;Middel,A.;Baklanov,A.;Ren,C.;Ng,E.;etal.Pathwayusing
WUDAPT’sDigitalSyntheticCitytooltowardsgeneratingurbancanopyparametersformulti-scaleurbanatmosphericmodeling.
UrbanClim.2019,28,100459.[CrossRef]
43. Middel, A.; Lukasczyk, J.; Zakrzewski, S.; Arnold, M.; Maciejewski, R. Urban form and composition of street canyons: A
human-centricbigdataanddeeplearningapproach.Landsc.UrbanPlan.2019,183,122–132.[CrossRef]
44. Middel,A.;Lukasczyk,J.;Maciejewski,R.;Demuzere,M.;Roth,M.SkyViewFactorfootprintsforurbanclimatemodeling.Urban
Clim.2018,25,120–134.[CrossRef]
45. Tan,M.;Le,Q.V.EfficientNet:RethinkingModelScalingforConvolutionalNeuralNetworks.arXiv2019,arXiv:1905.11946.
46. Wada, K.; Mpitid; Buijs, M.; Zhang, C.N.; なるみ; Kubovcˇík, B.M.; Myczko, A.; Latentix; Zhu, L.; Yamaguchi, N.; et al.
wkentaro/labelme:V4.6.0.Zenodo2021.[CrossRef]
47. Ying,X.Anoverviewofoverfittinganditssolutions.J.Phys.Conf.Ser.2019,1168,022022.[CrossRef]
48. Russakovsky, O.; Deng, J.; Su, H.; Krause, J.; Satheesh, S.; Ma, S.; Huang, Z.; Karpathy, A.; Khosla, A.; Bernstein, M.; etal.
ImageNetlargescalevisualrecognitionchallenge.Int.J.Comput.Vis.2015,115,211–252.[CrossRef]
49. Howard,J.;Gugger,S.Fastai:AlayeredAPIfordeeplearning.Information2020,11,108.[CrossRef]
50. Huh,M.;Agrawal,P.;Efros,A.A.WhatmakesImageNetgoodfortransferlearning?arXiv2016,arXiv:1608.08614.
51. Gebel,K.;Bauman,A.;Owen,N.Correlatesofnon-concordancebetweenperceivedandobjectivemeasuresofwalkability.Ann.
Behav.Med.2009,37,228–238.[CrossRef]
52. Athens,J.;Mehta,S.;Wheelock,S.;Chaudhury,N.;Zezza,M.Using311datatodevelopanalgorithmtoidentifyurbanblightfor
publichealthimprovement.PLoSONE2020,15,e0235227.[CrossRef]
53. Ping,P.;Xu,G.;Kumala,E.;Gao,J.SmartStreetLitterDetectionandClassificationBasedonFasterR-CNNandEdgeComputing.
Int.J.Soft.Eng.Knowl.Eng.2020,30,537–553.[CrossRef]
54. Neuhold,G.;Ollmann,T.;Bulo,S.R.;Kontschieder,P.Themapillaryvistasdatasetforsemanticunderstandingofstreetscenes.
In Proceedings of the 2017 IEEE International Conference on Computer Vision (ICCV), Venice, Italy, 22–29 October 2017;
pp.5000–5009.
55. Brostow,G.J.;Fauqueur,J.;Cipolla,R.Semanticobjectclassesinvideo:Ahigh-definitiongroundtruthdatabase.PatternRecognit.
Lett.2009,30,88–97.[CrossRef]
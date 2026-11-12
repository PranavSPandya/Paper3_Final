sensors
Article
Using Machine Learning to Train a Wearable Device
for Measuring Students’ Cognitive Load during
Problem-Solving Activities Based on Electrodermal
Activity, Body Temperature, and Heart Rate:
Development of a Cognitive Load Tracker for Both
Personal and Classroom Use
WilliamL.Romine1,*,NoahL.Schroeder2,JosephineGraft1,FanYang3,RezaSadeghi4 ,
MahdiehZabihimayvan5 ,DipeshKadariya3 andTanviBanerjee3
1 DepartmentofBiologicalSciences,WrightStateUniversity,Dayton,OH45435,USA;graft.2@wright.edu
2 DepartmentofLeadershipStudiesinEducationandOrganizations,WrightStateUniversity,
Dayton,OH45435,USA;noah.schroeder@wright.edu
3 DepartmentofComputerScienceandEngineering,WrightStateUniversity,Dayton,OH45435,USA;
yang.57@wright.edu(F.Y.);dipesh@knoesis.org(D.K.);tanvi@knoesis.org(T.B.)
4 DepartmentofElectrical&ComputerEngineeringandComputerScience,UniversityofNewHaven,
WestHaven,CT06516,USA;rsadeghi@newhaven.edu
5 DepartmentofComputerScience,CentralConnecticutStateUniversity,NewBritain,CT06050,USA;
zabihimayvan@ccsu.edu
* Correspondence: romine.william@gmail.com
(cid:1)(cid:2)(cid:3)(cid:1)(cid:4)(cid:5)(cid:6)(cid:7)(cid:8)(cid:1)
(cid:1)(cid:2)(cid:3)(cid:4)(cid:5)(cid:6)(cid:7)
Received: 27July2020;Accepted: 22August2020;Published: 27August2020
Abstract: Automated tracking of physical fitness has sparked a health revolution by allowing
individualstotracktheirownphysicalactivityandhealthinrealtime. Thisconceptisbeginningto
beappliedtotrackingofcognitiveload. Itiswellknownthatactivityinthebraincanbemeasured
throughchangesinthebody’sphysiology,butcurrentreal-timemeasurestendtobeunimodaland
invasive. Wethereforeproposetheconceptofawearableeducationalfitness(EduFit)tracker. Weuse
machine learning with physiological data to understand how to develop a wearable device that
trackscognitiveloadaccuratelyinrealtime. Inaninitialstudy,wefoundthatbodytemperature,
skinconductance,andheartratewereabletodistinguishbetween(i)aproblemsolvingactivity(high
cognitiveload),(ii)aleisureactivity(moderatecognitiveload),and(iii)daydreaming(lowcognitive
load)withhighaccuracyinthetestdataset. Inasecondstudy,wefoundthatthesephysiological
featurescanbeusedtopredictaccuratelyuser-reportedmentalfocusinthetestdataset,evenwhen
relatively small numbers of training data were used. We explain how these findings inform the
developmentandimplementationofawearabledevicefortemporaltrackingandloggingauser’s
learningactivitiesandcognitiveload.
Keywords: cognitiveload;machinelearning;wearablesensor;studying;learninganalytics
1. Introduction
Monitoringengagementwithlearningmaterialsinrealtimecanbechallenging. Manyofuscan
likelyrecallinstanceswherewehadtore-readaparagraphbecausewewerethinkingaboutsomething
elseandhadnorecollectionofwhattheparagraphsaid. Weenvisionasystemthathelpslearners
identifywhentheyarenotputtingappropriatementaleffortintolearning,andbelievethatreal-time
classificationofone’scognitiveloadcouldimprovestudyhabits. Wedescribethedevelopmentand
Sensors2020,20,4833;doi:10.3390/s20174833 www.mdpi.com/journal/sensors

Sensors2020,20,4833 2of14
implementationoftheEducationalFitness(EduFit)system,whichutilizesphysiologicaldatafroma
wearablesensorandmachinelearningtodifferentiatebetweendifferentlevelsofcognitiveloadfor
theuser.
Whiletheliteratureshowsanabundanceofresearchfocusedonapplyingtheconceptofcognitive
load,mentaleffort,ormentalworkloadtodifferentdomains,themeasurementofcognitiveloadhas
remainedrifewithlimitationsthroughouttheeducationalliterature[1,2].Currentpopularmeasurement
techniquesarelimitedbysubjectivityandcaninterferewithregularactivities[3],orrequiretheuseof
expensive,specializedequipment[4].Recently,theuseofbasicphysiologicalmeasuresinlearning
contextshasdrawnrenewedattentionbyresearchers,perhapsinpartduetothegrowingavailability
ofminimallyinvasivewearablesensors. Forexample,adecreaseinheartratebetweenthebeginning
andendofa60-minclassmaysuggestthatstudentslosealertnessandneurocognitiveexcitability[5].
Further,electrodermalactivity(EDA)hasdemonstratedusefulnessindistinguishingbetweenengaged
andnon-engagedstudents[6]. Recently,researchersusedamultimodalapproach,measuringEDA,
heartrate,bodytemperature,andbloodvolumepressuretocaptureastudent’sreportedlearning
experience, and then examined these data in relation to satisfaction, perceived usefulness of the
learning experience, and performance measures [7]. However, present studies do not explore the
usefulness of physiological data for real-time classification of activity or reported cognitive load,
whichwouldbenecessaryforawearablesensorthatisusefulfortrackingcognitiveload. Wetherefore
describethedevelopment,implementation,andvalidationofanon-invasivewearablemulti-modal
physiological sensor for real-time tracking and logging of cognitive load during learning tasks.
Inthisarticle, wedescribetwostudies. Inthefirststudy, weexploretheefficacyofelectrodermal
activity, skintemperature, andheartrateforclassifyingthreeactivities, whichareassociatedwith
varyinglevelsofcognitiveload. Inthesecondstudy,weevaluatetheefficacyofthesephysiological
measuresforclassificationofwhetherornotalearnerisfocusedonatask.
2. ReviewofLiterature
2.1. TheoreticalFramework
Itiswidelyacceptedthathumansengagetheirworkingmemorytoevaluatenewinformation[8,9].
This puts a cognitive burden on the working memory, a construct commonly known as cognitive
loadintheeducationliterature,andworkingmemoryloadormentalworkloadinotherfields[10,11].
Theoverallpremiseofcognitiveloadtheoryisthattheworkingmemoryonlyhasafiniteandlimited
numberofresourcesavailableatanypointintime,andtheyshouldideallybeusedforprocessing
thenecessaryinformationratherthandistractions[8,9]. Forthepurposesofthispaper,wereferto
cognitiveloadastheamountofmentaleffortbeingexpendedonthetask.
According to cognitive load theorists, mental effort can be expended in different ways when
learning. Specifically,effortdirecteddirectlytowardsthelearningtaskduetothecomplexityofthe
learningmaterialsisknownasintrinsiccognitiveload,ofwhichgermanecognitiveloadisasubtype
focusedontheconstructionofmentalmodels,whereasthementaleffortdirectedtowardslearningthat
isduetothewaythematerialsarepresentedisknownasextraneouscognitiveload[8,12]. Thegoal
ofinstructionthereforeistominimizetheextraneousloadandmoderatetheintrinsicloadtobeat
an appropriate level for the learner so one does not exceed their working memory capacity when
completingthelearningtask[8,9,12].
2.2. MeasuringCognitiveLoadandMentalWorkload
Whilecognitiveloadtheoryisconceptuallyrelatableformanywhodesigninstruction,itislimited
bytheoreticalandpracticalmeasurementissues. Self-reportandsecondarytaskmeasureshavebeen
themostcommonlyusedmethods. However,self-reportsforcethelearnertostopthelearningprocess
andrespondtoasurveyinstrument[3]. Similarly,secondarytasktechniqueshavethepotentialto
interferewiththeprimarylearningtask[13],meaningthattheymayhavetobechangeddependingon

Sensors2020,20,4833 3of14
howinstructionisbeingprovided[14],andtheymaybechallengingtomonitordependingonthetask.
Real-timephysiologicalmeasures,includingelectroencephalography(EEG)[15],eye-tracking[16],
and heart rate-related measures [4], avoid both of these problems but have often been viewed as
invasiveandlackingsensitivity[4].
Differentiatingbetweenthedifferenttypesofcognitiveloadhasalsobeenapersistentchallenge,
andsomehavesuggestedthatitmaynotbepossibletodistinguishbetweendifferentloadtypes[12].
Assuch,measuringoverallcognitiveloadmaybeamorefruitfulapproach,andthatiswhatsome
physiological measures are viewed to measure [15,17]. Accordingly, in this study we view the
physiologicaldatawecollectasanindicatorofoverallcognitiveloadanddonotclaimtobemeasuring
specifictypes(e.g.,intrinsicorextraneousload).
Asnoted,cognitiveloadandmentalworkloadaresimilarconstructs. Althoughphysiological
measurementinlearningorstudyingcontextsisrelativelynew,ithasbeenappliedmorewidelyin
otherfields. Sincetheautonomicnervoussystemsautomaticallyandunconsciouslyrespondtomental
workloaddemands[18],physiologicalmeasurescanbeusedasanindexofworkload[11]. Whilea
varietyofmeasureshavebeenusedintheliterature,wefocusonskintemperature,heartrate,andEDA
intermsofgalvanicskinresponse(GSR).
Skintemperaturehasbeenusedasanon-intrusivemeasureofmentalworkload,althoughitsuse
intheliteratureissparse. Forexample,[19]examinedhowfacialskintemperaturechangedduring
simulatedandactualdrivingtasks,findingsignificantcorrelationsbetweennosetemperatureand
asubjectiveworkloadmeasure. Meanwhile,in[20],heartratepredictedchangesincognitiveload
correctly62.5%ofthetime. InregardstoGSR,[20]foundthatGSRcouldbeusedtoclassifymental
effortwith75%accuracy. Finally,[3]examinedtheuseofGSRinrelationtoeducationallyrelevant
tasks in math and reading. Their results showed that once the data were normalized, GSR could
discriminatebetweentasksofdifferentdifficulties. However,despitethesesuccesses,GSRresultshave
notalwaysshownsuchpromise[21].
As shown, a number of different physiological measures have been used to examine mental
workloadinfieldsotherthaneducation(forreviews,see[22–24]). However,arecentsystematicreview
concluded that there was no one particular measure that may work well in all circumstances [24].
Whilemultimodalmeasureshavebeenusedtopredictcognitiveload,few,ifany,studieshaveextended
thepredictivefunctiontoanactuallearningtask. Astheubiquityofwearablefitnesssensorscontinues
toincrease,itmakessensetoexploretheefficacyofthesetypesofdataforclassificationofcognitive
loadineducationcontexts.
2.3. UsingPhysiologicalDatainEducationContexts
Theuseofphysiologicaldataineducationcontextsisrelativelylimited,especiallywhencompared
to self-report approaches to measuring cognitive load, but some promising research does exist.
Forexample,researchershaveshownthatheartrateandEDAarepromisingfeaturesforclassification
ofmentalengagement[5,6]. Specifically,inastudywith30studentsusinganArduino-basedsensor,
heartratewasshowntoprovideameasureofalertnessandneurocognitiveexcitability[5]. Meanwhile,
EmpaticaE4wearablesensordatafrom24students,9teachers,and41lecturesshowedthatEDAcan
provideausefulmeasureofemotionalarousal,whichisassociatedwithengagementornon-engagement
inclassroomcontexts[6]. Inaddition,[25]examinedEDAandskintemperatureinrelationtohigh
andlowcomplexitytasks. Usingwrist-wornwearablesandsurveymethods,theyfoundthatmean
physiologicalscoresdidnotdifferbythecomplexityoftheactivity; however, EDAwaspositively
correlatedwithself-reportedmentaleffortwhenindividualscompletedthehighcomplexitytask. Yet,
thelowcomplexitytaskdidnotshowthesamesignificantcorrelation[25].
While these individual physiological measures show interesting results, only recently have
multimodalphysiologicalmeasurementsbeenappliedineducationalresearch. Assuch,relatively
fewstudiesexist,butsomehaveshownpromisingfindings. Forexample,inastudyof31students
from 93 class sessions, [7] equated measures of heart rate, EDA, body temperature, and blood

Sensors2020,20,4833 4of14
volumepressurecollectedusingtheEmpaticaE4toself-reported7-pointLikertmeasuresofperceived
satisfaction,usefulness,andperformance. Usingtemporalfeatureswithinasupportvectormachine
withapolynomialkernel,predictionswithinoneLikertscalepointcouldbeobtainedusinganaverage
of25minofdata[7]. However,thisstudydidnotevaluatethedatainreal-timeanddidnotfocuson
cognitiveload.
2.4. ThePresentStudies
Asdiscussed,physiologicaldatahasbeenusedextensivelyformeasuringcognitiveloadoutside
ofeducationalcontexts,yettheuseofphysiologicaldataineducationcontextshasoftenbeenviewed
asproblematicforamultitudeofreasons. Researchershaverecentlybegunexploringtherelations
betweenphysiologicalmeasuresfromwearablesensorsandthelearningprocess, butthisworkis
limited. Furthermore,weareunawareofanystudiesthathaveusedmultimodalphysiologicaldatato
predictcognitiveloadinrealtime,aswouldberequiredtocreatethecognitiveloadtrackerweenvision.
Inthispaper,wedescribetwostudiesthatworktowardsanon-invasive,wearablesensorthat
can help a learner self-regulate their learning process. The first study aimed to examine if EDA,
skintemperature,andheartrateareusefulfortheclassificationofactivitieshypothesizedtorepresent
differentlevelsofcognitiveload. Thisworkisneededtohelpvalidatetheuseofthesemeasuresfor
multimodalcognitiveloadmeasurement. Buildingonthesefindings,thesecondstudyexaminedthe
efficacyofthesemeasuresfortheclassificationofalearner’sself-reportedfocusonatask. Together,
these studies provide a foundation for a wearable sensor that can monitor cognitive load using
physiologicaldatathatiseasilyobtainablefromwearablefitnesstrackers.
3. Study1
Sincefewstudieshaveexaminedtheuseofwearablesensorsforthemonitoringofcognitiveload
inlearningcontexts,andfewstudieshaveexaminedtheuseofdifferenttypesofphysiologicaldatain
thiscontext,itisimportanttofirstconfirmtheextenttowhichthesemeasuresareusefulforclassifying
activities associated with different levels of cognitive load. Above we discussed how few studies
have utilized multimodal measures in this regard. As such, in Study 1 we sought to examine the
extenttowhichthreecommonlyusedphysiologicalmeasures,specificallySkinTemperature(TEMP),
EDA,andHeartRate(HR),couldbeusedtogethertoclassifyactivitiesrepresentingvaryinglevelsof
cognitiveload.
3.1. Methods
3.1.1. MeasurementofPhysiologicalParameters
WecollectedparticipantdatawiththeEmpaticaE4,anunobtrusivewrist-wornphysiological
sensor. TheE4issimilartoatraditionalfitnesstrackerindesign[26]andmeasuresBloodVolumePulse
(BVP),HeartRate(HR),InterbeatInterval(IBI),SkinTemperature(TEMP),3-AxisAcceleration(ACC),
andElectrodermalActivity(EDA).WefocusonTEMP,EDA,andHR.EDAisthemeasurementof
electricalconductanceoftheskin,alsocalledgalvanicskinresponse(GSR),fordetectionofautonomic
nervoussystemarousal[27]. Forthisstudy,weusedtheamplitudeoftheparticipant’sEDAsignal,
whichwasoutputdirectlyfromtheE4device. ThedevicemeasuredEDAandTEMPat4Hz. HR(1Hz)
wascalculatedbasedonBVP(64Hz). Sincetherespectiveactivities,completedontheorderofminutes,
servedasthegroundtruthlabels,wedownsampledEDAandTEMPto1Hzinordertomatchthe
HRsamplingfrequency. Althoughtherewassomelossofinformationinthisdownsamplingprocess,
wefoundthispreferabletoupsampling,whichwouldaddmorenoisetothedata.

Sensors2020,20,4833 5of14
3.1.2. TransformationofPhysiologicalFeatures
Beforeusingstatisticalmodelsandmachinelearning,weputallfeaturesontothesamescalesimilar
to[3]. Withrespecttoourstudydesign,thisnormalizationprocessalsoneededtoaccountforindividual
baseline and variability differences in TEMP, EDA, and HR. We therefore used z-standardization,
whichmapsthefeaturesonascaleofstandarddeviationscenteredatthemean. Inordertoaccount
forindividualbaselineandvariability,wemappedeachparticipant’sfeaturesonascaleofhis/her
standarddeviationcenteredathis/herownmeanacrossalltrials. Thisensuredthateachparticipant’s
valuesforTEMP,EDA,andHRaccountedforhis/heruniquevariabilitywithrespecttohis/herunique
averagevalue.
3.1.3. ExperimentalDesign
InStudy1,wewereinterestedintheefficacyofTEMP,EDA,andHRinclassifyingaparticipant’s
activity. Weusedthreeactivitiescomprisingdifferenthypothesizedlevelsofcognitiveload(Table1):
(1)deepcognition—astateassociatedwithactiveproblemsolvinglikecompletingamathproblemor
solvingapuzzle;(2)leisuredcognition—astateassociatedwithpassivecognitiveactivitylikereading
a novel or browsing the internet; and (3) daydreaming—a state associated with lack of focus on a
particulartask. Torepresentthesedifferentcognitivestates,weaskedparticipantstoengageinthree
activities(Table1): (1)playingSudokuwithoutdistractions,whichrepresentsanactivitywithhigh
cognitiveload;(2)browsingtheinternetorcheckinge-mail,whichrepresentsanactivitywithmoderate
cognitiveload,and(3)sittinganddoingnothing,whichrepresentsanactivitywithlowcognitiveload.
Table1. SummaryofthethreetasksusedinStudy1,withcognitionstateandhypothesizedlevelof
cognitiveload.
CognitionState CognitiveLoad AssociatedTask
DeepCognition High PlayingSudoku
LeisuredCognition Moderate BrowsingtheInternet
Daydreaming Low SittingandDoingNothing
Sevenadults(4maleand3female),rangingfrom27–38yearsofage,participatedinthestudy
(descriptivestatisticsinTable2). Threeoftheparticipantsrangedfrom26–28yearsofage,twoofthe
participantswere32yearsofage,andoneparticipantwas38yearsofage. Eachparticipantplacedthe
E4bandonthewristapproximately3cmbelowthebaseofthehand. Afterapproximately2minof
wearingtheE4,eachparticipantwasfirstaskedtoplayagameofSudokuatthedifficultyleveloftheir
choice. ImmediatelyafterfinishingtheSudokugame,theywereaskedtospend15–20minchecking
e-mailorbrowsingsocialmedia. Afterfinishingthis,theywereaskedtospend10–15minsittingand
doingnothing,withnoexternalformsofengagement. Twooftheparticipantsdidthesethreeactivities
twice,oneparticipantdidthem4times,twoparticipantsdidthem5times,andtwoparticipantsdid
them6times. Thisresultedinatotalof30trialsforeachactivityacrossthe7participants. Onaverage,
eachSudokusessiontook18minand16s, eachcomputerbrowsingsessiontook14minand41s,
andeachperiodofnon-engagementlasted13minand18s. Acrossallsubjects,trials,andactivities,
thistotaled23hand7minand19sofsensordata.

Sensors2020,20,4833 6of14
Table2. Descriptivestatisticsforeachparticipant’sphysiologicalmeasuresacrosseachactivityinStudy
N=numberofmeasurements(1measurepersecond),EDA=electrodermalactivity,HR=heart
1.
rate,andTEMP=bodytemperature.
|        |                  |       | EDA(µS)   | HR(Beats/Minute) |       | TEMP( ◦ C) |
| ------ | ---------------- | ----- | --------- | ---------------- | ----- | ---------- |
| Person | Activity         | N     | Mean SD   | Mean             | SD    | Mean SD    |
| 1      | Sudoku           | 1198  | 0.06 0.03 | 72.61            | 10.70 | 32.32 1.67 |
|        | BrowsingInternet | 1273  | 0.04 0.02 | 81.37            | 18.26 | 31.96 1.92 |
|        | Daydreaming      | 1359  | 0.05 0.01 | 68.55            | 7.68  | 31.16 1.53 |
| 2      | Sudoku           | 9813  | 4.07 3.03 | 92.08            | 10.33 | 32.53 0.43 |
|        | BrowsingInternet | 9074  | 3.27 2.19 | 92.24            | 12.32 | 32.52 0.38 |
|        | Daydreaming      | 8860  | 2.81 2.68 | 88.74            | 12.90 | 32.55 0.33 |
| 3      | Sudoku           | 4260  | 0.17 0.03 | 78.69            | 7.62  | 30.92 1.64 |
|        | BrowsingInternet | 3900  | 0.19 0.05 | 73.42            | 8.55  | 30.92 1.58 |
|        | Daydreaming      | 3229  | 0.19 0.08 | 73.50            | 8.15  | 31.56 0.60 |
| 4      | Sudoku           | 2296  | 0.10 0.09 | 84.98            | 6.70  | 33.52 1.65 |
|        | BrowsingInternet | 2562  | 0.14 0.08 | 80.96            | 3.87  | 32.54 0.99 |
|        | Daydreaming      | 1735  | 0.09 0.01 | 89.97            | 3.85  | 34.49 0.78 |
| 5      | Sudoku           | 2227  | 0.16 0.11 | 82.92            | 14.37 | 30.05 1.30 |
|        | BrowsingInternet | 2169  | 0.11 0.06 | 74.94            | 8.83  | 33.01 0.62 |
|        | Daydreaming      | 1804  | 0.05 0.04 | 71.89            | 11.35 | 31.93 2.53 |
| 6      | Sudoku           | 2880  | 0.13 0.06 | 70.02            | 7.77  | 32.59 2.38 |
|        | BrowsingInternet | 3600  | 0.14 0.05 | 68.92            | 8.64  | 32.70 1.94 |
|        | Daydreaming      | 3420  | 0.14 0.08 | 74.29            | 7.60  | 32.06 2.61 |
| 7      | Sudoku           | 10200 | 0.38 0.23 | 75.17            | 5.32  | 32.93 0.71 |
|        | BrowsingInternet | 3840  | 0.39 0.25 | 80.10            | 16.35 | 32.65 0.42 |
|        | Daydreaming      | 3540  | 0.43 0.44 | 73.85            | 6.25  | 32.31 0.89 |
3.1.4. TrainingandTestingofClassifiers
Inordertounderstandhowmachinelearningmaybeusedinaphysiologicalsensordesigned
for detecting the type of activity, we utilized a variety of machine learning algorithms, which can
be distinguished into 3 types: (1) a constant model which uses the bias in the data as a predictor,
(2)baselinemodels,whicharedesignedtobeconceptuallysimpleandrelativelyeasytointerpret,
and(3)blackboxmodels,whichcontainmanyparametersandarecomparativelydifficulttointerpret
butcanbuildmorecomplexmodelsandtendtooutperformthebaselinemodels.
Theconstantmodel,thesimplestpossiblemodel,whichmakespredictionsbasedonthemost
commonlyoccurringoutcome,providedalowerboundforclassificationperformance. Baselinemodels
=
included logistic regression (weak L1 regularization: C 1000), naïve Bayes, k nearest neighbors
|     | =   |     |     |     | =   |     |
| --- | --- | --- | --- | --- | --- | --- |
(Euclidean distance with k 3), and decision tree (maximum depth 4, no splitting of subsets
smallerthan5,minimumnumberofinstancesinleaves=1). Blackboxmodelsincludedmulti-layer
neural network (sigmoidal activation function, 1 hidden layer with 100 neurons), support vector
machine(SVM)(sigmoidalkernel,cost=1,epsilon=0.01),AdaBoost(10estimators,learningrate=1),
andrandomforest(100trees,nosplittingofsubsetssmallerthan5). Weusedthescikit-learntoolboxin
Pythontofitthemodels. Intheinterestofevaluatingtherobustnessofthemodelswithnewdata,
weusedashuffle-splitprocessforvalidation,where100randomsamplesweredrawnwithreplacement
fromthedata. Toobtainaliberalestimateofperformance,wefirstdrew95%ofthedatawithineach
randomdrawtotrainthemodels,andthentestedthemodelsontheremaining5%withineachrandom
draw. Toobtainamoreconservativeestimate,wedrew10%ofthedatawithineachrandomdrawto
trainthemodels,andthentestedthemontheremaining90%ofthedatawithineachrandomdraw.
Strengthofclassificationofthemodelsonthetestdatasetwasassessedthroughtheaverageareaunder
thereceiveroperatorcharacteristic(ROC)curve(AUC),precision,recall,andF1score,whichisthe
harmonicmeanofprecisionandrecall[28],acrossthe100randomdraws.

Sensors2020,20,4833 7of14
3.2. Results
CognitiveTaskPrediction
DatafromthisstudyshowthatTEMP,EDA,andHRareusefulforclassifyingaparticipant’s
cognitivetaskunderbothconservativeandliberalassumptionsrelatedtothenumberoftrainingdata
available(Table3).
Table3. Classificationperformanceofthetestdataset. Modelsincludetheconstant(outcomebias),
baselinemodels(k-nearestneighbors(KNN),logisticregression,naïveBayes,decisiontree),andblack
boxmodels(supportvectormachine(SVM),neuralnetwork,AdaBoost,andrandomforest).
Activity(Resting,Web,
|     | Liberal(95%Training) |     | Conservative(10%Training) |     |
| --- | -------------------- | --- | ------------------------- | --- |
Sudoku)
| Model    | AUC F1    | Precision Recall | AUC F1    | Precision Recall |
| -------- | --------- | ---------------- | --------- | ---------------- |
| Constant | 0.49 0.22 | 0.16 0.40        | 0.50 0.22 | 0.16 0.39        |
K-NearestNeighbors(k=3)
|                    | 0.97 0.93 | 0.93 0.93 | 0.89 0.84 | 0.84 0.84 |
| ------------------ | --------- | --------- | --------- | --------- |
| LogisticRegression | 0.52 0.23 | 0.44 0.41 | 0.36 0.28 | 0.41 0.41 |
| NaïveBayes         | 0.65 0.45 | 0.46 0.47 | 0.67 0.44 | 0.45 0.46 |
DecisionTree(depth=4)
|                      | 0.68 0.43 | 0.57 0.49 | 0.67 0.45 | 0.53 0.48 |
| -------------------- | --------- | --------- | --------- | --------- |
| SupportVectorMachine | 0.50 0.31 | 0.33 0.32 | 0.44 0.28 | 0.31 0.29 |
| NeuralNetwork        | 0.79 0.61 | 0.61 0.61 | 0.33 0.45 | 0.47 0.47 |
| AdaBoost             | 0.93 0.92 | 0.92 0.92 | 0.78 0.80 | 0.80 0.80 |
| RandomForest         | 0.99 0.94 | 0.94 0.94 | 0.93 0.85 | 0.85 0.85 |
Ofthebaselinemodels,k-nearestneighbors(KNN)wasthebestperforming(AUC=0.89–0.97,
F1=0.84–0.93). Theclassificationperformanceoftheotherthreebaselinemodelswasmoderateto
poor,withAUCvaluesbelow0.7andF1valuesbelow0.5. Oftheblackboxmodels,randomforest
wasthebestperforming(AUC=0.93–0.99,F1=0.85–0.94),followedbyAdaBoost(AUC=0.78–0.93,
F1=0.80–0.92).
3.3. Discussion
We were surprised that the SVM and neural networks performed relatively poorly given
their capacity to model complex relationships between input features and the output classes,
withclassificationperformanceparallelingthatobtainedfromthebaselinemodels. Thispotentially
demonstrates the necessity of ensemble approaches such as AdaBoost and random forest for
classificationoflearningactivitieswithinthistypeofframework. Randomforestperformedquitewell
evenwhenverylittletrainingdatawereused(AUC=0.93,F1=0.85),whichdemonstratesitsutility
forprovidingusefullabelsevenwhenrelativelysmallnumbersofdataareavailable. Thisissignificant
becausemanyfactorsaffectphysiology,anditisoftendifficulttocontrolastudent’senvironmental
circumstances within a learning or studying situation. All of these aspects add noise to the data,
andensemblemethods,suchasAdaBoostandrandomforesttendtoberobusttothesetypesofnoise
bybuildingseveralweakrulesthatcanfactorinthedifferentconditionsunderwhichacertainactivity
or cognitive workload can occur. This is also a good place to point out that there is noise due to
imperfect control of the experiment itself, which mirrors what the training process for the EduFit
deviceforactivityclassificationmayentail. Namelysincecognitiveloadwasnotreporteddirectlyby
participants,thereislikelyindividualvariationinthelevelsofmentaleffortputforthintherespective
activities. Thisseemsparticularlylikelygiventhatcognitiveloadcanvarybyindividualduetotheir
priorknowledgeorfamiliaritywithatask[8]. Wedidnotsetspecificconstraintsonwhattheperson
wasdoingwhenbrowsingtheinternet,whatshewasthinkingaboutwhensittingandresting,orthe
difficultyoftheSudokupuzzle. Thedifferingperformanceoftheseclassifiersmayreflectthelimitation
thatwewerenotabletocontrolthetypesofmentalactivitiesinwhichtheparticipantswereengaging,
andcorrespondingcognitiveload,astheyweresittingatrestorbrowsingtheinternet. Anexperiment

| Sensors2020,20,4833 |     |     |     |     |     |     | 8of14 |
| ------------------- | --- | --- | --- | --- | --- | --- | ----- |
thatutilizesself-reportmeasuresofcognitiveloadinresponsetospecifictasksmayhelpovercomethis
limitationandimprovemodelclassificationperformance.
4. Study2
The results from Study 1 showed that the amplitude of a person’s electrodermal activity,
bodytemperature,andheartratecouldbeusedtoeffectivelyclassifyactivitiesrepresentingvarying
levelsofcognitiveload. However,alimitationofthisworkwasthattherewasnotaself-reported
measurefromtheparticipantsforcomparison. Toaddressthislimitation,inthesecondstudy,wewere
interestedintheefficacyofTEMP,EDA,andHRforpredictingself-reportedmentalfocusinrealtime.
4.1. Methods
4.1.1. ExperimentalDesign
We used the Empatica E4 for data collection, and measurement and transformation of the
physiologicalfeatureswassimilartoStudy1. GiventheefficacyofTEMP,EDA,andHRforpredicting
aparticipant’sactivityinStudy1,thepurposeoftheexperimentaldesigninStudy2wastoobtaina
self-reportmeasureofmentalfocusfromeachparticipantinthecontextofapre-definedsetofactivities
(descriptive statistics in Table 4). Each participant completed similar activities while wearing the
E4,andwereaskedtoratetheirlevelofmentalfocusaftereachactivity. Study2involved7adult
participants—5femaleand2male. Fouroftheparticipantswere18–19yearsofage,andoneparticipant
was23yearsofage. Theothertwoparticipantswere39and49yearsofage,respectively.
Table4. Descriptivestatisticsforeachparticipant’sphysiologicalmeasuresacrosstheactivitiesinStudy
N=numberofmeasurements(1measurepersecond),EDA=electrodermalactivity,HR=heart
2.
rate,andTEMP=bodytemperature.
|        |         |     | EDA(µS)   | HR(Beats/Minute) |       |       | ◦    |
| ------ | ------- | --- | --------- | ---------------- | ----- | ----- | ---- |
|        |         |     |           |                  |       | TEMP( | C)   |
| Person | Focused | N   | Mean SD   | Mean             | SD    | Mean  | SD   |
| 1      | No      | 60  | 0.19 0.04 | 98.18            | 15.36 | 31.84 | 0.08 |
|        | Yes     | 514 | 0.22 0.02 | 74.74            | 7.05  | 32.29 | 0.13 |
| 2      | No      | 0   |           |                  |       |       |      |
|        | Yes     | 855 | 0.09 0.03 | 97.94            | 18.28 | 33.68 | 0.43 |
| 3      | No      | 117 | 0.07 0.01 | 80.29            | 4.37  | 30.85 | 0.06 |
|        | Yes     | 880 | 0.09 0.01 | 75.10            | 5.03  | 30.48 | 0.18 |
| 4      | No      | 176 | 0.04 0.02 | 89.62            | 16.05 | 29.16 | 0.21 |
|        | Yes     | 583 | 0.05 0.02 | 90.47            | 8.59  | 30.69 | 1.44 |
| 5      | No      | 0   |           |                  |       |       |      |
|        | Yes     | 475 | 0.20 0.07 | 79.36            | 9.74  | 32.33 | 0.15 |
| 6      | No      | 293 | 0.38 0.08 | 71.40            | 10.63 | 33.53 | 0.35 |
|        | Yes     | 250 | 0.42 0.05 | 80.45            | 11.80 | 33.50 | 0.12 |
| 7      | No      | 653 | 0.11 0.03 | 96.29            | 19.11 | 33.80 | 0.27 |
|        | Yes     | 238 | 0.06 0.02 | 101.41           | 13.67 | 33.38 | 0.58 |
UsingQualtricssurveysoftware,eachparticipantwasaskedtocompletefivepuzzlesdeveloped
bytheAmericanAlzheimer’sAssociation,whichtheparticipantsreportedrangedindifficultyfrom
extremelyeasytoextremelydifficult. Thefivepuzzlestookparticipantsanaverageof10.6(SD=4.1)
minutestocomplete. Completiontimesrangedfrom6.1to16.6min. Atotalof85minofdatawere
collected,whichcomprisedasingletrialforsixoftheparticipants,andtwotrialsforoneparticipant.
Beforebeginningthepuzzles, eachparticipantwasaskedtoweartheEmpaticaE4devicefor
approximately2min. WeplacedtheE4bandonthewristapproximately3cmbelowthebaseofthe
hand. Aftertheparticipantcompletedeachpuzzle,shewasaskedtoratethelevelofmentalfocus
giventothepuzzle(notfocused,somewhatfocused,orfocused). Sinceourinterestisinadevicethat
candetectastateofhighcognitiveload,wecodedareportofhighfocusas‘1 (cid:48) andmoderatefocusor

Sensors2020,20,4833 9of14
(cid:48)
lackoffocusas‘0 (reportedinTable4). Twooftheparticipants(Table4)indicatedthattheywere
focusedtheentiredurationoftheexperiment. Althoughthislackofvarianceintheoutcomewould
contraindicatesuccessfultrainingofadeviceonthatsingleparticipant,weelectedtoretainthesedata
sinceourtrainingandtestingprocedurewasnotstratifiedattheparticipantlevel. Theseparticipants
followedtheexperimentalprocedures,andwewereinterestedinusingasmanydataaspossibleinthe
classificationmodels.
4.1.2. TrainingandTestingofClassifiers
Weutilizedthebiasinthedata,fourbaselinemodels,andfourblackboxmodels,toclassifyeach
participant’sself-reportedmentalfocus(0=notfocused;1=focused).
Baselinemodelsincludedlogisticregression(weakL1regularization: C=1000),naïveBayes,
knearestneighbors(KNN)(Euclideandistancewithk=3),anddecisiontree(maximumdepth=4,
nosplittingofsubsetssmallerthan5,minimumnumberofinstancesinleaves=1). Blackboxmodels
includedmulti-layerneuralnetwork(sigmoidalactivationfunction,1hiddenlayerwith100neurons),
supportvectormachine(SVM)(sigmoidalkernel,cost=1,epsilon=0.01),AdaBoost(10estimators,
learningrate=1),andrandomforest(100trees,nosplittingofsubsetssmallerthan5).
Sinceanindividual’sactuallevelofcognitiveloadwithinaparticularactivitywasnotquantified
inStudy1,theself-reportmeasureformentalfocuscollectedinStudy2madewayforanevaluation
ofhowcognitiveloadaffectsaperson’sTEMP,EDA,andHR.Webeganwithstudyingthelogistic
regression model to understand the relationship between the physiological features (TEMP, EDA,
andHR)andself-reportedfocus. Thisincludedtherelativeimportanceofeachofthefeaturesaswell
asthedirectionoftherelationships. Weusedbinarylogisticregressionwithamulti-levelmodeling
approachtoexploreandcontrolforindividualclustereffects[29]. UsingSPSS21.0,wefirstfitteda
maineffectsmodelthatincludedTEMP,EDA,andHRaspredictorsfortheoutcomeoffocus. Next,
we fitted an intercept-by-person model, which allowed each participant to have a unique model
interceptwhileconstrainingtheeffectsofTEMP,EDA,andHRtobesimilaracrossparticipants. Third,
wefittedanintercept-andtrend-by-personmodel,whichallowedeachparticipanttohavebotha
uniqueinterceptanduniquetrends. Weevaluatedthemaineffectsusingoddsratioswithrespectto
thebestfittingmodel(95%confidence). Theoddsratiowasdefinedastheeffectofaonestandard
deviationincreaseinapredictorontheoddsofreportingahighleveloffocus. Significanceoftheodds
ratiowasevaluatedatthe95%confidencelevel.
We used the scikit-learn toolbox in Python to fit the machine learning models. As described
previouslyforStudy1,intheinterestofevaluatingtherobustnessofthemodelswithnewdata,weused
ashuffle-splitprocessforvalidation,where100randomsamplesweredrawnwithreplacementfrom
thedata. Aliberalestimateofmodelperformancewasobtainedbydrawing95%ofthedatawithin
eachrandomdrawtotrainthemodels,andthentestingthemodelsontheremaining5%withineach
randomdraw. Toobtainamoreconservativeestimate,wedrew10%ofthedatawithineachrandom
drawtotrainthemodels,andthentestedthemontheremaining90%ofthedatawithineachrandom
draw. Theliberalapproachrepresentsascenariowheretherearemanydatafromeachindividualto
traintheclassifier. Theconservativeapproachrepresentsasituationwheretherearerelativelyfewdata
available,andwherepredictionsforoneindividualmayneedtobemadebasedonanotherindividual’s
data. Strengthofclassificationwasassessedthroughtheareaunderthereceiveroperatorcharacteristic
(ROC)curve(AUC),precision,recall,andF1score,whichwereaveragedoverthe100randomdraws.
4.2. Results
4.2.1. StatisticalModelingandInferenceforFeatureImportance
The logistic regression model containing only the main effects of EDA, HR, and TEMP fitted
the data significantly better than simply using the outcome bias as a predictor (χ2 = 28.79, df = 3,
p<<0.001). Allowingtheoutcomebiastochangebetweenparticipants(χ2=2527.09,df=10,p<<0.001)

Sensors2020,20,4833 10of14
significantlyimprovedmodelfitoverthemodelwithjustthemaineffects(differenceχ2 =2498.30,
df=7,p<<0.001).
Amodelallowingbothmodelbiasandtrendstochangebetweenparticipants
(χ2=4224.09,df=31,p<<0.001)improvedmodelfitevenfurther(differenceχ2=1697.00,df=24,
p<<0.001). Thismaydemonstratetherolethatindividualdifferencesplayinunderstandinghowthe
Itmayalsobedemonstrativeofdifferencesinhowindividuals
bodyreactstochangesincognitiveload.
perceivetheirownstateofmentalfocus,whichmayaffecttheirself-reports.
Whentheseindividualdifferenceswereaccountedfor,themodelindicatedanincreaseinheart
ratewithincreasedmentalfocus(Table5). A1standarddeviationincreaseinanindividual’sheart
=
rate was found to increase the odds of being in a focused state 1.4 times (OR 1.39). Conversely,
body temperature and EDA were found to decrease with increased cognitive load. A 1 standard
deviationincreaseinbodytemperatureandEDAreducedtheoddsofreportingafocusedstateby2.6
times(OR=0.39)and4.2times(OR=0.24),respectively.
Thesevalues(Table5)suggestthatEDAand
TEMParerelativelyimportantpredictorsincomparisontoHRwhenpredictingmentalfocusonatask.
Table5. Binarylogisticregressionmodelforpredictingauser’sreportedstateoffocusbasedonEDA,
bodytemperature,andheartrate. Thismodelcontrolsforvariationsineachparticipant’sintercepts
andtrends(χ2=4224.09,df=31,p<<0.001).
|     | Variable | B      | SE    | χ2(df=1) | p-Value | OR    |
| --- | -------- | ------ | ----- | -------- | ------- | ----- |
|     | EDA      | −1.424 | 0.114 | 157.288  | 0.000   | 0.241 |
|     | TEMP     | −0.954 | 0.098 | 94.613   | 0.000   | 0.385 |
|     | HR       | 0.332  | 0.111 | 8.941    | 0.003   | 1.394 |
4.2.2. PredictionofSelf-ReportedMentalFocus
Whenmovingtothetargetvariableofuser-reportedmentalfocus,weobserveasimilartrendas
inStudy1intermsoftheclassifierswhichperformwell,andthosethatstrugglewithclassification
Ofthebaselinemodels,KNNperformsbest(AUC=0.81–0.87,F1=0.79–0.80).
(Table6). Thesimilarity
inclassificationperformanceunderbothconservativeandliberalassumptionssuggeststhatKNN
mayalsoperformwellwithlimiteddata. AlthoughitdoesnotperformaswellasKNN,thesamecan
besaidforthedecisiontree(depth=4,AUC=0.71–0.73,F1=0.74–0.75).
Aswithclassificationof
activityinStudy1,theensemblemethodsprovidedthebestperformanceforclassifyinguser-reported
mentalfocus. Withlimiteddata,therandomforestclassifierperformedsimilarlytoKNN(AUC=0.85,
=
F1 0.81). However, its performance improved when 95% of the data were used for training
(AUC=0.96,F1=0.90).
Table6. Classificationperformanceofthetestdataset. Modelsincludetheconstant(outcomebias),
baselinemodels(k-nearestneighbors(KNN),logisticregression,naïveBayes,decisiontree),andblack
boxmodels(supportvectormachine(SVM),neuralnetwork,AdaBoost,andrandomforest).
ReportedFocus(Yes/No)
|          |     | Liberal(95%Training) |              |        | Conservative(10%Training) |                     |
| -------- | --- | -------------------- | ------------ | ------ | ------------------------- | ------------------- |
| Model    |     | AUC                  | F1 Precision | Recall | AUC                       | F1 Precision Recall |
| Constant |     | 0.46                 | 0.64 0.56    | 0.75   | 0.50                      | 0.64 0.56 0.75      |
K-NearestNeighbors(k=3) 0.87 0.80 0.80 0.80 0.81 0.79 0.79 0.79
| LogisticRegression |     | 0.54 | 0.64 0.56 | 0.75 | 0.52 | 0.64 0.69 0.75 |
| ------------------ | --- | ---- | --------- | ---- | ---- | -------------- |
| NaïveBayes         |     | 0.68 | 0.64 0.56 | 0.75 | 0.66 | 0.66 0.68 0.74 |
DecisionTree(depth=4) 0.73 0.75 0.81 0.80 0.71 0.74 0.74 0.77
| SupportVectorMachine |     | 0.51 | 0.61 0.61 | 0.61 | 0.53 | 0.64 0.62 0.67 |
| -------------------- | --- | ---- | --------- | ---- | ---- | -------------- |
| NeuralNetwork        |     | 0.54 | 0.64 0.56 | 0.75 | 0.52 | 0.64 0.68 0.75 |
| AdaBoost             |     | 0.86 | 0.90 0.90 | 0.90 | 0.72 | 0.78 0.78 0.78 |
| RandomForest         |     | 0.96 | 0.90 0.90 | 0.91 | 0.85 | 0.81 0.81 0.82 |

Sensors2020,20,4833 11of14
4.3. Discussion
In light of the challenge of controlling the level of a person’s focus on a specific activity in
Study1,weaccompaniedspecifictaskswiththeparticipant’sself-reportedmeasuresofmentalfocus
inthisstudy. Itisinterestingthatthestrongestclassifiersforuser-reportedmentalfocus(Study2)
wereverysimilartothosefortypeofactivity(Study1). Specifically,theensemblemodelswerethe
best-performingoftheblackboxmodels,withrandomforestprovidingthestrongestclassification
performance(AUC=0.85–0.96,F1=0.81–0.90). AlthoughKNNwasthebestperformingofthebaseline
models(AUC=0.81–0.87,F1=0.79–0.80),weweresurprisedthatasimpledecisiontree(depth=4)
alsoperformedmoderatelywellandwasrobusttolimiteddata(AUC=0.71–0.73,F1=0.74–0.75),
whichmaysuggestthatthistypeofmodelwouldbeusefulintheearlystagesoftraininganindividual’s
EduFitdevice.
Logisticregressiongivesdirectinsightintotherelativeimportanceofthefeaturesbytellingus
howastandarddeviationofchangeinonefeatureaffectstheoutcomewhileholdingtheotherfeatures
constant. Thelogisticregressionmodel(Table5)suggestedthatEDAwasthemostimportantfeature
(χ2(1)=157.3,OR=0.24)followedbyTEMP(χ2(1)=94.6,OR=0.39). Althoughstatisticallysignificant
(χ2(1)=8.9,OR=1.39),HRwasoflesserimportance. Thisyieldsinsightintothegeneraltrendson
howmentalfocuswasmanifestedphysiologicallyaftercontrollingforindividualdifferences. Given
thelargeindividualdifferences,thesetrendsarenotlikelytoprovideabasisforstrongclassification.
However,thesegeneraltrendsmaybeusefulasastartingpoint,orinformativeprior,inthetraining
ofanindividual’sdevice. ThefactthatdecreasedbodytemperatureandEDAwereassociatedwith
mentalfocusinourdatasuggeststhatconcentrationonamentaltaskisassociatedwithastateof
relaxation [6,30]. The association of mental focus with increased heart rate derived from the data
suggeststhattheseparticipantsconcurrentlyexperiencedahigherlevelofmentalalertnessasthey
werefocusedonthetask[5]. Bringingthistogether,wecancharacterizeuser-reportedfocusonatask
asastateofemotionalandphysicalrelaxationaccompaniedbymentalalertness,which(simplistically)
isexpressedphysiologicallybydecreasedbodytemperatureandEDAaccompaniedbyanincreasein
heartrate.
5. OverallDiscussionandLimitations
Justasphysicalfitnesstrackershaverevolutionizedtheculturearoundphysicalhealthandexercise,
theEduFitsystemmayrevolutionizestudyingbyimprovingone’sawarenessofuniquestudyhabits,
includingthelevelanddurationofcognitiveloadusedduringstudysessions. Althoughprevious
studieshaveshownthattheconceptofafitnesssensortomonitorstudyingispromising[5–7],nostudy
hasshownstrongclassificationperformanceusingthereal-timemeasuresthatcanbecollectedfrom
ubiquitouswearabletechnology. WeusedtheEmpaticaE4similarlyto[6,7],butthedatasuggestthat
anywearabletechnologythatcollectsaccurateandrepeatablereal-timemeasuresforheartrate,EDA,
andbodytemperaturecanbeusedtoprovideusefulpredictionsforboththetypeofactivityinwhich
astudentisengaged(Study1)aswellaswhetherornotthestudentisfocusedonatask(Study2).
Automated feedback provided by fitness sensors has enabled people to track their exercise,
lendingameasureofaccountabilitytotheirphysicalhealth. Inthesameway,whenstudying,itis
importantforastudenttogetfeedbackonwhetherornotsheisactuallyengagedinataskandstudying
effectively. Itiswell-knownthatthismetacognitionisessentialtoeffectivepersonaldevelopmentand
learning[31],andreal-timefeedbackprovidedbythistypeofwearabletechnologymayhelpusers
developthenecessarypersonalawarenessneededtostudymoreeffectively.
Manyaspectsofimplementationofthistypeoftechnologyarestraightforward. Similartocurrent
fitnesstrackers,datafromthewearablesensorcanbeexportedtoaserverforprocessing,andthen
sentbacktotheuser’ssmartphonewheregraphicssuchaschartsandtablesrepresentingthelevelof
cognitiveloadandtemporaltrendscanbepresentedtotheuser(Figure1).

Sensors2020,20,4833 12of14
Sensors 2020, 20, x 12 of 14
Figure 1. Conceptual diagram of the EduFit system, including the user, the wearable sensor,
Figure 1. Conceptual diagram of the EduFit system, including the user, the wearable sensor, the
thesmartphoneapp,andawebserver.
smartphone app, and a web server.
However, the models and relationships are less straightforward than with traditional fitness
However, the models and relationships are less straightforward than with traditional fitness
trackers. Modelsusingaccelerometerdatatoquantifymagnitudeanddurationofmovement,andthose
trackers. Models using accelerometer data to quantify magnitude and duration of movement, and
using heart rate to infer the aerobic activity of a person of specific gender and age, are relatively
those using heart rate to infer the aerobic activity of a person of specific gender and age, are relatively
straightforwardincomparisontoquantifyingcognitiveload. Manyconfoundingfactorsdeteriorate
straightforward in comparison to quantifying cognitive load. Many confounding factors deteriorate
thesemodels,includingtheuniquenessofhowwethinkandengagewithdifferenttasks,andreact
these models, including the uniqueness of how we think and engage with different tasks, and react
physiologically to our thought processes. To add further complexity, we have differences in how
physiologically to our thought processes. To add further complexity, we have differences in how we
we interact with other aspects of our learning environments that are external to the task. Finally,
interact with other aspects of our learning environments that are external to the task. Finally, these
thesefactorsleadtoerrorsinthetrainingprocessitself. Forexample,ourperceptionsofwhetherornot
factors lead to errors in the training process itself. For example, our perceptions of whether or not we
wearefocusedwillshiftfrompersontoperson,andevenfromdaytoday. Theextenttowhichthis
are focused will shift from person to person, and even from day to day. The extent to which this
happenswillaffectanyclassifiertrainedwithuser-reportdata. Inlieuofuser-reports,observational
happens will affect any classifier trained with user-report data. In lieu of user-reports, observational
datacouldbeusedtoinferwhetherornotapersonisfocused. However,thiswouldthencontain
data could be used to infer whether or not a person is focused. However, this would then contain
observererror,whichwouldlikelybeevengreaterthanself-reporterrorunlesstheobserverisboth
observer error, which would likely be even greater than self-report error unless the observer is both
expertly trained and knows the subject of observation well. Another option would be to go back
expertly trained and knows the subject of observation well. Another option would be to go back to a
toadesignlikeStudy1andthoughtfullylinkspecificactivitiestospecificmentaldemands. Itmay
design like Study 1 and thoughtfully link specific activities to specific mental demands. It may be
bestraightforwardtoinferthatcompletingatasklikewritinganessayorsolvingamathproblem,
straightforward to infer that completing a task like writing an essay or solving a math problem, which
whichisalignedtoaperson’sabilitylevel,wouldrequirementalfocus. However,inferringthatatask
is aligned to a person’s ability level, would require mental focus. However, inferring that a task does
doesnotsolicitmentalfocusismorechallengingunlesstheparticipantself-reportsit. Forexample,
not solicit mental focus is more challenging unless the participant self-reports it. For example, a
apersonappearingtositanddonothingmaybedaydreaming,orhemaybethinkingaboutacomplex
person appearing to sit and do nothing may be daydreaming, or he may be thinking about a complex
probleminvolvingahigherlevelofcognitiveload.
problem involving a higher level of cognitive load.
Althoughthesequestionsofexperimentaldesignandcausationpertainingtoreliablytraining
Although these questions of experimental design and causation pertaining to reliably training a
a system like EduFit will not go away anytime soon, we consider it promising that both Study 1,
system like EduFit will not go away anytime soon, we consider it promising that both Study 1, which
whichreliedonaperson’sobservedactivity,andStudy2,whichreliedonself-reportedmentalfocus,
relied on a person’s observed activity, and Study 2, which relied on self-reported mental focus, both
both demonstrated strong classification using KNN and the ensemble models, even in the case of
demonstrated strong classification using KNN and the ensemble models, even in the case of limited
limitedtrainingdata. Giventhelimitations,wefeelaneffectivewaytostartwiththistechnologyis
training data. Given the limitations, we feel an effective way to start with this technology is to rely
torelyonuser-reporteddatafromtheoutset(Figure1). Weenvisionthatinthebeginningstagesof
on user-reported data from the outset (Figure 1). We envision that in the beginning stages of
implementationofEduFitwithanindividual,theuserwillcontrolmuchofthelabeling,including
implementation of EduFit with an individual, the user will control much of the labeling, including
thetypesofactivitiesofengagementaswellasperceivedlevelofcognitiveload,therebybuildinga
the types of activities of engagement as well as perceived level of cognitive load, thereby building a
personalizedworkloadmonitoringsystem. Thesedatacanthenbeutilizedtoiterativelytweakthe
personalized workload monitoring system. These data can then be utilized to iteratively tweak the
classificationmodelsothatitprovidescontinuallystrongerpredictionsoftheindividual’slearning
classification model so that it provides continually stronger predictions of the individual’s learning
activitiesandcognitiveloadovertime.
activities and cognitive load over time.
Author Contributions: W.L.R. participated in designing the experiments, collecting and analyzing the data for
both studies, and drafting the manuscript. N.L.S. conducted and drafted the literature review. T.B. participated
in designing the experiments and data analysis procedures, and supervised data collection for Study 1. F.Y.
participated in the data analysis for Study 1. R.S., M.Z., and D.K. participated in data collection for Study 1. J.G.

Sensors2020,20,4833 13of14
AuthorContributions: W.L.R.participatedindesigningtheexperiments,collectingandanalyzingthedatafor
bothstudies,anddraftingthemanuscript. N.L.S.conductedanddraftedtheliteraturereview. T.B.participated
indesigningtheexperimentsanddataanalysisprocedures, andsuperviseddatacollectionforStudy1. F.Y.
participatedinthedataanalysisforStudy1. R.S.,M.Z.andD.K.participatedindatacollectionforStudy1. J.G.
participatedindevelopmentoftheexperimentaldesignanddatacollectionforStudy2. Allauthorshavereadand
agreedtothepublishedversionofthemanuscript.
Funding: T.B.andR.S.weresupportedbyNationalInstitutesofHealthundergrantK01LM012439–02. J.G.was
supportedbytheNationalScienceFoundationundergrant1742339.
| Acknowledgments:     | Wethanktheparticipantswhomadethisstudypossible. |     |
| -------------------- | ----------------------------------------------- | --- |
| ConflictsofInterest: | Theauthorsdeclarenoconflictofinterest.          |     |
HumanSubjects: Allstudyparticipantsgavetheirinformedconsentforinclusionbeforetheyparticipatedinthe
study. ThestudywasconductedinaccordancewiththeDeclarationofHelsinki,andtheprotocolwasapproved
bytheEthicsCommitteeofWrightStateUniversity(06046).
References
1. DeJong,T.Cognitiveloadtheory,educationalresearch,andinstructionaldesign: Somefoodforthought.
| Instr. Sci. | 2010,38,105–134. | [CrossRef] |
| ----------- | ---------------- | ---------- |
2. Zheng,R.Z.(Ed.) CognitiveLoadMeasurementandApplication: ATheoreticalFrameworkforMeaningfulResearch
| andPractice;Routledge: | NewYork,NY,USA,2018. |     |
| ---------------------- | -------------------- | --- |
3. Nourbakhsh,N.;Wang,Y.;Chen,F.;Calvo,R.A.Usinggalvanicskinresponseforcognitiveloadmeasurement
in arithmetic and reading tasks. In Proceedings of the 24th Australian Computer-Human Interaction
Conference(ACM),Melbourne,Australia,26–30November2012;pp.420–423.
4. Paas, F.; Van Merrienboer, J.J.G.; Adam, J.J. Measurement of Cognitive Load in Instructional Research.
| Percept.Mot. | Ski. 1994,79,419–430. | [CrossRef][PubMed] |
| ------------ | --------------------- | ------------------ |
5. DeAvila,U.E.R.;Campos,F.R.D.F.;DeAvila,U.E.R.;Leocadio-Miguel,M.A.;Araujo,J.F.15Minutesof
AttentioninClass: VariabilityofHeartRate, Personality, EmotionandChronotype. Creat. Educ. 2019,
| 10,2428–2447. | [CrossRef] |     |
| ------------- | ---------- | --- |
6. DiLascio,E.;Gashi,S.;Santini,S.UnobtrusiveAssessmentofStudents’EmotionalEngagementduring
LecturesUsingElectrodermalActivitySensors. Proc. ACMInteract. Mob. WearableUbiquitousTechnol. 2018,
2,103. [CrossRef]
7. Giannakos,M.N.;Sharma,K.;Papavlasopoulou,S.;Pappas,I.O.;Kostakos,V.Fitbitforlearning: Towards
capturingthelearningexperienceusingwearablesensing. Int. J.Hum. Comput. Stud. 2020,136,102384.
[CrossRef]
8. Paas, F.; Sweller, J. Implications of Cognitive Load Theory for Multimedia Learning. In The Cambridge
HandbookofMultimediaLearning;CambridgeUniversityPress(CUP):NewYork,NY,USA,2014;pp.27–42.
9. Sweller,J.;Ayers,P.;Kalyuga,S.CognitiveLoadTheory;Springer: NewYork,NY,USA,2011;pp.37–76.
10. Hart, S.G.; Staveland, L.E. Development of NASA-TLX (Task Load Index): Results of Empirical and
TheoreticalResearch. InComprehensionofGraphics;ElsevierBV:Amsterdam,TheNetherlands,1988;Volume
52,pp.139–183.
11. Young,M.S.;Brookhuis,K.A.;Wickens,C.D.;Hancock,P.A.Stateofscience: Mentalworkloadinergonomics.
| Ergonomics2014,58,1–17. |     | [CrossRef][PubMed] |
| ----------------------- | --- | ------------------ |
12. Sweller,J.ElementInteractivityandIntrinsic,Extraneous,andGermaneCognitiveLoad. Educ. Psychol. Rev.
| 2010,22,123–138. | [CrossRef] |     |
| ---------------- | ---------- | --- |
13. Brünken, R.; Plass, J.; Leutner, D. Direct Measurement of Cognitive Load in Multimedia Learning.
| Educ.Psychol. | 2003,38,53–61. | [CrossRef] |
| ------------- | -------------- | ---------- |
14. 10Park,B.;Brünken,R.Therhythmmethod: Anewmethodformeasuringcognitiveload—Anexperimental
| dual-taskstudy. | Appl. Cogn. | Psychol. 2015,29,232–243. |
| --------------- | ----------- | ------------------------- |
15. Antonenko,P.;Paas,F.;Grabner,R.;VanGog,T.Usingelectroencephalographytomeasurecognitiveload.
| Educ. Psychol. | Rev. 2010,22,425–438. | [CrossRef] |
| -------------- | --------------------- | ---------- |
16. Cook,A.E.;Wei,W.;Preziosi,M.A.TheUseofOcular-MotorMeasuresinaConvergentApproachtoStudying
CognitiveLoad. InCognitiveLoadMeasurementandApplication:ATheoreticalFrameworkforMeaningfulResearch
| andPractice;Routledge: | NewYork,NY,USA,2017;pp.112–128. |     |
| ---------------------- | ------------------------------- | --- |

| Sensors2020,20,4833 |     |     |     |     | 14of14 |
| ------------------- | --- | --- | --- | --- | ------ |
17. Zagermann, J.; Pfeil, U.; Reiterer, H. Measuring Cognitive Load using Eye Tracking Technology in
Visual Computing. In Proceedings of the Beyond Time and Errors on Novel Evaluation Methods for
Visualization—BELIV’16,Baltimore,MD,USA,24October2016;pp.78–85.
18. Wiberg,H.; Nilsson,E.; Lindén,P.; Svanberg,B.; Poom,L.Physiologicalresponsesrelatedtomoderate
mentalloadduringcardrivinginfieldconditions. Boil. Psychol. 2015,108,115–125. [CrossRef][PubMed]
19. OrCK,L.;Duffy,V.G.Developmentofafacialskintemperature-basedmethodologyfornon-intrusivemental
| workloadmeasurement. |     | Occup. Ergon. | 2007,7,83–94. |     |     |
| -------------------- | --- | ------------- | ------------- | --- | --- |
20. Zhang,H.;Zhu,Y.;Maniyeri,J.;Guan,C.Detectionofvariationsincognitiveworkloadusingmulti-modality
physiologicalsensorsandalargemarginunbiasedregressionmachine. InProceedingsofthe201436th
AnnualInternationalConferenceoftheIEEEEngineeringinMedicineandBiologySociety,Chicago,IL,USA,
26–30August2014;pp.2985–2988.
21. Haapalainen,E.;Kim,S.;Forlizzi,J.F.;Dey,A.K.Psycho-physiologicalmeasuresforassessingcognitiveload.
InProceedingsofthe12thACMInternationalConferenceonUbiquitousComputing(ACM),NewYork,NY,
USA,12–16September2010.
22. Charles, R.; Nixon, J. Measuring mental workload using physiological measures: A systematic review.
| Appl.Ergon. | 2019,74,221–232. | [CrossRef][PubMed] |     |     |     |
| ----------- | ---------------- | ------------------ | --- | --- | --- |
DeWaard,D.TheMeasurementofDrivers’MentalWorkload;GroningenUniversity,TrafficResearchCenter:
23.
Haren,TheNetherlands,1996.
24. Kramer, A.F. Physiological metrics of mental workload: A review of recent progress. In Multiple Task
| Performance;Taylor&Francis: |     | London,UK,1991;pp.279–328. |     |     |     |
| --------------------------- | --- | -------------------------- | --- | --- | --- |
25. Larmuseau,C.;Vanneste,P.;Cornelis,J.;Desmet,P.;Depaepe,F.Combiningphysiologicaldataandsubjective
Front. Learn. Res. 2019,7,57–74.
measurementstoinvestigatecognitiveloadduringcomplexlearning.
[CrossRef]
|     |     |     | E4EDA/GSRSensor. | https://www.empatica. |     |
| --- | --- | --- | ---------------- | --------------------- | --- |
26. Real-timePhysiologicalSignals. Empatica. Availableonline:
com/en-eu/research/e4/(accessedon6November2019).
| 27. Boucsein,W.ElectrodermalActivity;Plenum: |     |     | NewYork,NY,USA,1992. |     |     |
| -------------------------------------------- | --- | --- | -------------------- | --- | --- |
28. James,G.;Witten,D.;Hastie,T.;Tibshirani,R.AnIntroductiontoStatisticalLearning;SpringerScienceand
BusinessMediaLLC:NewYork,NY,USA,2013;Volume103.
Gibbons,R.D.;Hedeker,D.Applicationofrandom-effectsprobitregressionmodels.
| 29.              |                    |     |     | J.Consult. Clin. | Psychol. |
| ---------------- | ------------------ | --- | --- | ---------------- | -------- |
| 1994,62,285–296. | [CrossRef][PubMed] |     |     |                  |          |
FluffingthePhysiological
30. Campbell,S.S.;Broughton,R.J.RapidDeclineinBodyTemperatureBeforeSleep:
| Pillow? | ChronoInt. 1994,11,126–131. |     | [CrossRef][PubMed] |     |     |
| ------- | --------------------------- | --- | ------------------ | --- | --- |
31. Paris,S.G.;Winograd,P.Howmetacognitioncanpromoteacademiclearningandinstruction. Dimens. Think.
| Cogn. Instr. | 1990,1,15–51. |     |     |     |     |
| ------------ | ------------- | --- | --- | --- | --- |
©2020bytheauthors.
|     |     |     | LicenseeMDPI,Basel,Switzerland. Thisarticleisanopenaccess |     |     |
| --- | --- | --- | --------------------------------------------------------- | --- | --- |
articledistributedunderthetermsandconditionsoftheCreativeCommonsAttribution
(CCBY)license(http://creativecommons.org/licenses/by/4.0/).
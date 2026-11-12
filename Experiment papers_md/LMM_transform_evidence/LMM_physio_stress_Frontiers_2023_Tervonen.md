TYPE OriginalResearch
PUBLISHED 05December2023
DOI 10.3389/fnrgo.2023.1294286
Explainable stress type
classification captures
OPENACCESS
EDITEDBY physiologically relevant responses
MartinO.Mendez,
UniversidadAutónomadeSanLuisPotosí,
Mexico in the Maastricht Acute Stress Test
REVIEWEDBY
PatrickR.Steffen,
BrighamYoungUniversity,UnitedStates
PratushaReddy, JaakkoTervonen*,JohannaNärväinen,JaniMäntyjärviand
DrexelUniversity,UnitedStates
KatiPettersson
*CORRESPONDENCE
JaakkoTervonen VTTTechnicalResearchCentreofFinlandLtd.,Espoo,Finland
jaakko.tervonen@vtt.fi
RECEIVED14September2023
ACCEPTED15November2023 Introduction:Currentstressdetectionmethodsconcentrateonidentificationof
PUBLISHED05December2023 stress and non-stress states despite the existence of various stress types. The
CITATION present study performs a more specific, explainable stress classification, which
TervonenJ,NärväinenJ,MäntyjärviJand
couldprovidevaluableinformationonthephysiologicalstressreactions.
PetterssonK(2023)Explainablestresstype
classificationcapturesphysiologicallyrelevant Methods: PhysiologicalresponsesweremeasuredintheMaastrichtAcuteStress
responsesintheMaastrichtAcuteStressTest.
Test(MAST),comprisingalternatingtrialsofcoldpressor(inducingphysiological
Front.Neuroergon.4:1294286.
doi:10.3389/fnrgo.2023.1294286 stress and pain) and mental arithmetics (eliciting cognitive and social-evaluative
stress). The responses in these subtasks were compared to each other and to
COPYRIGHT
©2023 Tervonen,Närväinen,Mäntyjärviand the baseline through mixed model analysis. Subsequently, stress type detection
Pettersson.Thisisanopen-accessarticle was conducted with a comprehensive analysis of several machine learning
distributedunderthetermsoftheCreative
componentsaffectingclassification.Finally,explainableartificialintelligence(XAI)
CommonsAttributionLicense(CCBY).Theuse,
distributionorreproductioninotherforumsis methodswereappliedtoanalyzetheinfluenceofphysiologicalfeaturesonmodel
permitted,providedtheoriginalauthor(s)and behavior.
thecopyrightowner(s)arecreditedandthat
theoriginalpublicationinthisjournaliscited,in Results: Most of the investigated physiological reactions were specific to the
accordancewithacceptedacademicpractice. stressors,andthesubtaskscouldbedistinguishedfrombaselinewithupto86.5%
Nouse,distributionorreproductionis
balanced accuracy. The choice of the physiological signals to measure (up to
permittedwhichdoesnotcomplywiththese
terms. 25%-pointdifferenceinbalancedaccuracy)andtheselectionoffeatures(upto
7%-pointdifference)werethetwokeycomponentsinclassification.Reflectionof
theXAIanalysistomixedmodelresultsandhumanphysiologyrevealedthatthe
stressdetectionmodelconcentratedonphysiologicalfeaturesrelevantforthetwo
stressors.
Discussion: Thefindingsconfirmthatmultimodalmachinelearningclassification
can detect different types of stress reactions from baseline while focusing on
physiologicallysensiblechanges.Sincethemeasuredsignalsandfeatureselection
affected classification performance the most, data analytic choices left limited
inputinformationuncompensated.
KEYWORDS
interpretable artificial intelligence, machine learning, physiology, stress, acute stress
detection
1 Introduction
Stress affects people both positively and negatively: in some cases it helps individuals
cope while in others it paralyzes them. The human body adapts to stressful situations
efficientlybutwhenthetransientstressrepeatswithoutadequaterecovery,itcanconvert
slowly and insidiously into chronic stress that threatens health and wellbeing. Therefore,
FrontiersinNeuroergonomics 01 frontiersin.org

Tervonenetal. 10.3389/fnrgo.2023.1294286
studying stress detection methodology has received significant HR increased continuously during the 3-min CPT for 20 out of
attention in recent years. Current methods, however, are limited 39 participants and decreased for the others after a short initial
since they focus on binary detection between stress and non- increase.AsforEEG,moststudieswithCPThavebeenrelatedto
stress states (Vos et al., 2023). In addition, the various machine pain research and Chang et al. (2002) summarize these findings:
learning(ML)componentsaffectingdetectionperformanceremain decreasedalphabandandincreasedbetabandactivity.Theyalso
understudiedinconjunctionwithaphysiologicalinspectionofthe observed increased frontal theta activity and decreased posterior
mostimportantfeaturestoapply. alpha activity during a three-minute CPT. Recently, Chouchou
Theharmfuleffectsofstressaremainlyassociatedwithfrequent etal.(2021)concludedthatthedecreaseinparietalalphaactivity
activation of the hypothalamus-pituitary-adrenal (HPA), which isarobustbutunspecificmarkerofpain.
triggers a sequence of events causing the release of cortisol In earlier studies, the MAST has been mainly treated as a
in the bloodstream, increasing cortisol levels (Sharpley, 2009). single 10-min stressor that increases blood pressure and salivary
The stressful activation may also begin from the sympathetic cortisollevels(Smeetsetal.,2012;Quaedfliegetal.,2017;Shilton
nervous system through sympatho-adrenaline-medullary (SAM), etal.,2017).However,HRevidencednogroupleveleffectbetween
whichcausestheincreaseofarousallevelviaadrenaline(Sharpley, pre-MAST and post-MAST phases (Shilton et al., 2017). The
2009;Smeetsetal.,2012).Thus,twostress-responsiveaxesevoke limitedreactivitycouldmeanthattheHRreactionshavesubsided
physiological changes. These can be detected from biosignal prior to post-MAST measurements, as reported in a TSST study
features such as heart rate (HR) and heart rate variability (HellhammerandSchubert,2012).AsMASTconsistsofadynamic
(HRV)fromelectrocardiogram(ECG),skinconductanceresponses sequence of two stressor trials, it would be meaningful to treat
from electrodermal activity (EDA), spectral power parameters thestressorsastwodistinctstatesratherthanasasingleblockof
from electroencephalogram (EEG), and eye movement and blink generalstress.Verifyingwhetherthesetwostressorselicitdifferent
statistics from electro-oculogram (EOG) (Schmidt et al., 2019; types of stress either through HPA or SAM activation would be
Giannakakisetal.,2022;Vanhollebekeetal.,2022). complicatedduetotheneedforhormonalmeasurementsbetween
A vast majority of stress detection research is conducted in therepeatedtrialsandtheleakagearisingfromthemissingrecovery
laboratoryconditions,wherestressmustbeinduced.Theinduction periods. Nevertheless, the current study refers to the induced
protocolsmaycontainsocial-evaluative,mentallyandattentionally statesasstresstypessincethetwostressorsareexpectedtocause
engaging, or physically uncomfortable elements (Dickerson and varied physiological reactions in the human body. This leads to
Kemeny,2004;Schmidtetal.,2019).Severalstudies,suchasMozos stressdetectionproblemwithtwodifferentstressors,physicalstress
etal.(2017),Schmidtetal.(2018),andAristizabaletal.(2021),have (CPT) and cognitive stress with elements of social stress (MA).
employed the Trier Social Stress Test (TSST) (Kirschbaum et al., Theproblemischallenging,primarilybecausethereisnorecovery
1993),whichcomprisesapublicspeakingandamentalarithmetic between alternating MA and CPT subtasks, and there is likely to
(MA)task.Acoldpressortest(CPT),whereparticipantsholdtheir bephysiologicalleakage,especiallyaffectingtheclassificationofthe
right hand in cold water for a short period (1–3 min), has been first few subtask windows. So far, few studies have used such an
usedtodeliverphysicalstress(DanielsandGeorgiou,2019;Ghiasi approachtostudythestressandphysiologyduringtheMASTbut
etal.,2020;Mishraetal.,2020a).Theseprotocolshavetypicallyhad ithasbeenshowninPetterssonetal.(2020)andTervonenetal.
restingsessionsbetweenthedifferentstressorsandeachsubtaskhas (2021b)thatCPTandMAcanbeseparatedwithMLmethodsfrom
beencompletedjustonce.However,suchsetupsarefarfromreal biosignalmeasurements.
life situations where the various stressors offer no chance to rest A ML approach to stress detection follows a processing
andrecoverbetweenthem. pipeline with steps such as data preprocessing, feature
Incontrast,theMaastrichtAcuteStressTest(MAST)(Smeets extraction,andclassification(Schmidtetal.,2019).Preprocessing
etal.,2012)consistsofalternatingtrialsofCPTandMAsubtasks, consists of synchronization of the available data streams,
eachlasting45–90s,repeatedfor10minwithnorestingsessions filtering the raw signals to increase the signal-to-noise ratio,
between the trials. By design, MAST contains two stressors and segmenting the signals into desired lengths to enable
(cognitive MA and physical CPT), but it also contains elements classification of measurements. At feature extraction, the
of a social-evaluative stressor since the researcher pressures the filtered and segmented signals are turned into more insightful
participant to perform better and wrong answers cause a penalty features, e.g., HR is computed from the ECG signal. Finally,
in the arithmetic subtask. The different stressors cause different the features are classified with a ML algorithm combined with
physiological reactions in the human body, which are briefly proper validation procedure to ensure generalizability of the
reviewednext. model.
Stressors including social-evaluative or cognitive elements Despite the different types of stressors and resulting stress,
increasebloodpressure,HR,blinkrate,andEDAactivity,decrease existingstudiesfocusonbinarystressdetection(Vosetal.,2023).
HRV(SchuriandvonCramon,1981;HellhammerandSchubert, Evenwhenthestressinductionprotocolhasincludedavarietyof
2012;Aristizabaletal.,2021),andcausesignificantchangesinsome social-evaluativeorcognitivestressstimuli,thedivergentstressful
spectral EEG parameters (Vanhollebeke et al., 2022). Since CPT conditions have been labeled as a single stress state, e.g., Mishra
triggers a sympathetic activation (Mourot et al., 2008), it causes et al. (2020b) and Chalabianloo et al. (2022). The works with a
changes in EDA (Mourot et al., 2008; Ghiasi et al., 2020) and in non-binary setup have detected the intensity of stress (Gjoreski
blink rate (Paparella et al., 2020). However, the HR response to etal.,2017),classifiedbetweenresting,mentalstress,andphysical
the CPT varies individually: Mourot et al. (2008) reported that activity(Chalabianlooetal.,2022),orbetweenresting,stress,and
FrontiersinNeuroergonomics 02 frontiersin.org

| Tervonenetal. |     |     |     |     |     |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- |
anaffectivestate(Fengetal.,2023)insteadofdetectingthetypeof studyexaminesphysiologicalparameters’impactonclassification,
stress. both with an extensive set of features and an interpretable one
Additionally,despitethecomprehensiveandversatilereactions of a few easily interpretable features, and reflects these results to
that stress causes in the human body, the emphasis in biosignal physiology. To the best of authors knowledge, this study is the
basedstressdetectionstudiesisinHRVandEDAmeasurements firsttoextensivelyexaminethephysiologicalresponsesduringthe
(Schmidtetal.,2019;Giannakakisetal.,2022;Vosetal.,2023).The MASTwithbothastatisticalandanexplainableMLanalysis.
| studies utilizing |     | EEG often     | use spectral | analysis | of multichannel |          |             |     |             |     |     |     |     |
| ----------------- | --- | ------------- | ------------ | -------- | --------------- | -------- | ----------- | --- | ----------- | --- | --- | --- | --- |
| EEG measurements  |     | (Vanhollebeke | et al.,      | 2022),   | which           | is time- |             |     |             |     |     |     |     |
|                   |     |               |              |          |                 |          | 2 Materials |     | and methods |     |     |     |     |
consumingtosetup,computationallyheavyandinfeasibleinreal-
| life situations. | A   | more realistic | option | is to measure |     | brainbeat, |     |     |     |     |     |     |     |
| ---------------- | --- | -------------- | ------ | ------------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
a derived EEG parameter introduced by Holm et al. (2009). It The analysis in this study was conducted as follows: (1) the
is computed from the frontal and parietal signals, which can be data were collected; (2) the data were preprocessed and features
measured with simple wearable EEG devices. EOG is commonly extracted; (3) the data were analyzed with mixed models to
|     |     |     |     |     |     |     | determine | whether | the protocol | elicited | varying | reactions | to the |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ------------ | -------- | ------- | --------- | ------ |
measuredinmultichannelEEGstudiestoremoveeyemovement
andblinkartifactsfromtheEEGsignal.However,theEOGsignals MASTsubtasksandtoseehowthephysiologicalfeaturesreflected
haverarelybeenusedasaparameterinstressdetection,despitethat stress; and (4) a ML analysis was conducted to find whether the
eye movements and blinks react to changes in human cognitive stresstypescanbeclassifiedandmodelbehaviorwasexplainedto
state (Marshall, 2007; Henderson et al., 2013; Pettersson et al., seewhichexactfeaturesaffectedclassificationthemostandhow.
2020).
| Consequently, |     | the knowledge | of which | physiological |     | features |     |     |     |     |     |     |     |
| ------------- | --- | ------------- | -------- | ------------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- |
to apply in stress detection is incomplete. Despite that feature 2.1 Data collection
importanceanalysisisessentialtoproperlyinterpretandvalidate
a classification model, the exact features that were the most Study participants were healthy volunteers (N = 24, 7 male)
important are scarcely reported. This objective was progressed with a mean age of 23.5 years (sd = 3.0 years, range 19–29).
in Pettersson et al. (2020) and Tervonen et al. (2021a,b), but Thevolunteerswererequiredtoberight-handed,havenohistory
| they employed |     | large sets | of features | and feature | importance |     |            |            |           |             |     |        |             |
| ------------- | --- | ---------- | ----------- | ----------- | ---------- | --- | ---------- | ---------- | --------- | ----------- | --- | ------ | ----------- |
|               |     |            |             |             |            |     | in cardiac | disorders, | no severe | depression, |     | and no | consumption |
was computed with methods that may produce model-specific of medicines affecting the autonomous nervous system. The
or biased estimates (e.g., partial dependence plots in Tervonen participants were instructed to maintain their normal lifestyle,
etal.,2021awhichisbasedonfeaturepermutations,disregarding avoidanyatypicalactivitiesduringthe24hbeforethestudyvisit
featureintercorrelations).Shapleyadditiveexplanations(Lundberg andensuretheydonotarrivehungrynorveryfull.Allvisitswere
| and Lee, | 2017) | would be | a more robust | choice, | as  | they fairly |     |     |     |     |     |     |     |
| -------- | ----- | -------- | ------------- | ------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
hostedbythesameresearcherandtheexperimentswereconducted
assign the prediction to individual features. The approach was one participant at a time. All participants gave their informed
adopted in stress detection context in Chalabianloo et al. (2022) consentinallthestudies.Theparticipantswerealsoinformedthat
but the analysis was limited to just HRV and EDA features. The they could stop their participation at any given time and their
existinginvestigationsoffeatureimportancehavealsobeenrather participation was completely voluntary. The study proposal was
technical(Tervonenetal.,2021a,b;Chalabianlooetal.,2022)and
|     |     |     |     |     |     |     | evaluated | by the | Ethics Committee |     | in the Humanities |     | and Social |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------ | ---------------- | --- | ----------------- | --- | ---------- |
physiologicalsensibilityislittlediscussed. andBehaviouralSciencesoftheUniversityofHelsinki.
On the modeling side, the focus on stress detection has The MAST was conducted as part of a larger protocol (see
been on improving the data processing pipeline and especially Figure1). Baseline physiology was recorded for 120s before and
on conducting extensive evaluations to find the best classifier aftertheprotocolwhiletheparticipantsstayedstillandkepttheir
| and signals | to measure | (Schmidt | et al., | 2019; | Giannakakis | et al., |         |            |          |            |         |     |                |
| ----------- | ---------- | -------- | ------- | ----- | ----------- | ------- | ------- | ---------- | -------- | ---------- | ------- | --- | -------------- |
|             |            |          |         |       |             |         | eyes on | a fixation | point on | a computer | screen. |     | These baseline |
2022; Vos et al., 2023). Thus, only the results with several periodsservedasthebaselinerestingstateinthisstudy.
classifiersandsignalcombinationsareoftenreported,e.g.,Schmidt The MAST protocol consisted of 10 min of alternating trials
et al. (2018) and Pettersson et al. (2020), and little attention is ofphysical(CPT)andpsycho-social(MA)stress,eachtrialwitha
given to estimating the effect of other modeling choices, such as varyingdurationbetween45and90s.Inthecoldimmersion,the
datasegmentationandoptimizingtheclassifierhyperparameters.
participantsheldtheirhandinwaterwithaconstanttemperature
of2◦C.Theparticipantscounteddownfrom2,043instepsof17
| Therefore, | assessing | the importance | of  | conducting | those | steps | is  |     |     |     |     |     |     |
| ---------- | --------- | -------------- | --- | ---------- | ----- | ----- | --- | --- | --- | --- | --- | --- | --- |
hindered. undertimepressureandpenalizationinthearithmeticsubtaskMA;
The present study investigates the physiological responses in the researcher urged them to be fast and they had to return to
ECG,EDA,EOG,andEEGtothesubtasksoftheMASTprotocol. startwhenmakingamistake.Theinstructionsforeachsubtaskwas
Themainaimisto(1)determinewhetherreactionstothestressors
visibleonacomputerscreenduringthewholeprotocol.
deviated with a mixed model analysis, and (2) detect the stress Physiological signals were collected with NeurOne system
typesfromabaselineconditionusingaMLanalysis.Theemphasis (Bittium, Oulu, Finland). The measured signals included one-
on the ML analysis is on evaluating the necessity and effect of channel ECG between left collarbone and right lower back, EDA
different components in the pipeline, namely which signals to between the index and middle finger, 64-channel EEG placed
| measure | and classifier | to  | use, the duration | of  | feature | windows, |           |        |               |       |         |     |             |
| ------- | -------------- | --- | ----------------- | --- | ------- | -------- | --------- | ------ | ------------- | ----- | ------- | --- | ----------- |
|         |                |     |                   |     |         |          | according | to the | International | 10-20 | system, | and | two-channel |
feature selection, and hyperparameter optimization. Finally, the EOG between the electrodes placed above and beneath the left
| FrontiersinNeuroergonomics |     |     |     |     |     |     | 03  |     |     |     |     |     | frontiersin.org |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- |

| Tervonenetal. |     |     |     |     |     |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- |
FIGURE1
Thestudyprotocol.Onlythedatafrombaselines(BL1andBL2),andMASTarediscussedinthiswork.IAFstandsforthephasewhenindividualalpha
frequenciesweremeasured.
eye (vertical) and the outer corners of the eyes (horizontal). andthetarange48Hz.TheBBparameterwascomputedastheratio
ElectrodesT9andT10servedasalinkedmastoidreference.The theta(Fz)/alpha(Pz)(Holmetal.,2009).
participants held their left hand still during the experiment to To analyze the effect of the selected window duration, all
ensure undisturbed EDA signal. Each signal was sampled at a features were extracted in windows of 10,15,30, and45s with
sampling rate of 1,000Hz and low-pass filtered with a cut-off a window slide of 5,7.5,15, and15s, respectively. The window
frequencyof250Hz. durations and slides were selected to fit the length of the MAST
|     |     |     |     |     |     |     |     | subtasks to     | minimize data | loss. Shorter   | windows | than 10s were |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | ------------- | --------------- | ------- | ------------- |
|     |     |     |     |     |     |     |     | not considered, | since many    | of the features | were    | computed from |
detectedevents:e.g.,inBentivoglioetal.(1997)itwasobservedthat
| 2.2 Data | preprocessing |     |     | and | feature |     |     |     |     |     |     |     |
| -------- | ------------- | --- | --- | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
meanblinkrateinrestconditionis17blinksperminute,whichis
extraction approximately one blink every 4s. Thus, shorter windows might
|     |     |     |     |     |     |     |     | not contain | any blinks. Moreover, |     | no saccades | were detected in |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --------------------- | --- | ----------- | ---------------- |
Dataprocessingfollowedafeature-basedapproach,wherethe some, especially shorter, windows. The saccades made may have
beentoosmalltodetectthemfromtheEOGsignal,lostintransient
rawbiosignalswereprocessedintofeaturesusableforclassification
of stressful states. A total of 150 features were computed, and noise, or nonexistent, as the participants were instructed to look
|              |         |           |          |     |          |     |          | at a fixation | point in the | BL task so | they should | not have made |
| ------------ | ------- | --------- | -------- | --- | -------- | --- | -------- | ------------- | ------------ | ---------- | ----------- | ------------- |
| Table1 lists | all the | extracted | features | and | provides | the | names of |               |              |            |             |               |
featuresusedlaterintext. saccades. Windows with too few blinks or saccades were left out
Heartbeats and interbeat intervals (IBIs) were extracted from oftheanalysis.Table2liststhenumberofsamplesateachwindow
length;seeSection2.4.1foradescriptionoffeaturesets.
| the ECG | signals | with | a Matlab | toolbox | (Sedghamiz, |     | 2014) |     |     |     |     |     |
| ------- | ------- | ---- | -------- | ------- | ----------- | --- | ----- | --- | --- | --- | --- | --- |
implementingthePan-Tompkinsalgorithm.Then,HRandHRV Allthefeaturesextractedmaybeimportantforclassification,
butsomeofthefeatures,suchasstatisticsofsecondderivatives,are
| features | were computed |     | from the | IBIs. | The statistics |     | of HR and |     |     |     |     |     |
| -------- | ------------- | --- | -------- | ----- | -------------- | --- | --------- | --- | --- | --- | --- | --- |
its first derivative were calculated. HRV was extracted in time, difficulttointerpret.Therefore,aninterpretablesetoffeatureswas
frequency and non-linear domain with the Python package hrv- defined,consistingmainlyofaveragemeasures:themeanofHR,
|          |             |        |     |           |          |      |         | IBI, phasic | EDA, blink rate, | time between | blinks, | blink duration, |
| -------- | ----------- | ------ | --- | --------- | -------- | ---- | ------- | ----------- | ---------------- | ------------ | ------- | --------------- |
| analysis | (Champseix, | 2018). | In  | total, 44 | features | from | the ECG |             |                  |              |         |                 |
signalwereextracted. blinkskewness,saccaderate,timebetweensaccades,andsaccade
|     |     |     |     |     |     |     |     | duration. In | addition, root | mean square | of successive | differences |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | -------------- | ----------- | ------------- | ----------- |
SaccadesandblinkswereextractedfromtheEOGsignalswith
an automated algorithm (Pettersson et al., 2013). Once obtained, (RMSSD,aHRVmeasure),numberofSCRsandBBwereadded.
the statistics of saccade rate, time between saccades, saccade Thissetwasusedforanexplainablemachinelearninganalysisand
amixedmodelanalysis.
duration,blinkrate,timebetweenblinks,blinkduration,andblink
waveformskewnesswerecomputedforatotalof81features. To account for the subjective nature of physiological
|     |            |     |            |     |      |        |           | measurements, | the features | were normalized |     | by person specific |
| --- | ---------- | --- | ---------- | --- | ---- | ------ | --------- | ------------- | ------------ | --------------- | --- | ------------------ |
| The | EDA signal | was | decomposed |     | into | phasic | and tonic |               |              |                 |     |                    |
component using the Ledalab Matlab software (Benedek and z-scorestandardizationwhichhasbeenshowntooutperformother
Kaernbach, 2010). Then, statistics of the phasic component and normalizationstrategies(Gjoreskietal.,2020).
itstwofirstderivativeswerecomputed,alongwiththenumberof
| skin conductance |     | responses | (SCR) | and | the total | time | the phasic |           |       |          |     |     |
| ---------------- | --- | --------- | ----- | --- | --------- | ---- | ---------- | --------- | ----- | -------- | --- | --- |
|                  |     |           |       |     |           |      |            | 2.3 Mixed | model | analysis |     |     |
componentwasincreasinganddecreasing,totalling24features.
Finally,thebrainbeat(BB)wasextractedfromtheEEGsignal
asfollows.TheEEGdatawerebandbass(1−40Hz)filtered.The The physiological stress reactions during the MAST were
eyemovementartifactswereremovedbyregressionalgorithm,the explored with a linear mixed model analysis. The models were
EEGsignalwasdown-sampledto200HzandFouriertransformed applied to assess whether the protocol elicited different kinds
to yield spectra. First, individual alpha frequencies (IAFs) were of stress (rest = BL, physiological stress = CPT, psycho-social
extracted from eyes closed condition (measured right after the stress = MA) using features from the biosignals that have been
baseline in the beginning of the measurement protocol) for each foundtoreflectstressorcognitiveloading:ECG(heartrate,inter-
participantandtheindividualalphabandrangewassettoIAF2Hz beat-interval; ibi, rmssd), EDA (number of peaks, mean), EOG
| FrontiersinNeuroergonomics |     |     |     |     |     |     |     | 04  |     |     |     | frontiersin.org |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- |

| Tervonenetal. |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |
| ------------- | --- | --- | --- | --- | --- | -------------------------- | --- |
TABLE1 Listofextractedfeaturesfromeachsignal,andtheirnamingconventionusedinotherfiguresandtables.Featureswritteninbolddenote
interpretablefeatures.
| Featurenameprefix |     | Features |     |     | Description |     |     |
| ----------------- | --- | -------- | --- | --- | ----------- | --- | --- |
ecg_hr_ mean,std,lq,uq,median,min,max,range,cv StatisticsofHR
ecg_hr_d1_ mean,std,lq,uq,median,min,max,range,cv Statisticsofthe1stderivativeofHR
| ecg_hrv_ |     | ibi_mean,ibi_median,ibi_range |     |     | StatisticsofIBIs                  |     |     |
| -------- | --- | ----------------------------- | --- | --- | --------------------------------- | --- | --- |
| ecg_hrv_ |     | sdnn,sdsd                     |     |     | StdofIBIsandsuccessivedifferences |     |     |
ecg_hrv_ (p)nn20,(p)nn50 PercentageandnumberofIBIsdifferingmorethan
20ms/50ms
| ecg_hrv_ |     | rmssd      |     |     | Rootmeansquareofsuccessivedifferences    |     |     |
| -------- | --- | ---------- | --- | --- | ---------------------------------------- | --- | --- |
| ecg_hrv_ |     | cvnni,cvsd |     |     | RatioofsdnnandmeanIBI,andRMSSDandmeanIBI |     |     |
ecg_hrv_ vlf,lf,hf,total_power Powerinvery,low,highfrequencybandsandtotal
power
| ecg_hrv_ |     | lf/hf     |     |     | Ratiooflfandhf     |     |     |
| -------- | --- | --------- | --- | --- | ------------------ | --- | --- |
| ecg_hrv_ |     | lfnu,hfnu |     |     | Normalizedlfandhf  |     |     |
| ecg_hrv_ |     | hrvti     |     |     | HRVtriangularindex |     |     |
ecg_hrv_ cvi,csi,Modified_csi (Modified)cardiacsympatheticindex,cardiacvagal
index
ecg_hrv_ sd1,sd2,sd2/sd1 Poincarplotstdperpendicularandalongtheidentity
line,theirratio
eda_phasic_ mean,std,lq,uq,median,min,max StatisticsofphasicEDA
eda_phasic_d1_ mean,std,lq,uq,median,min,max Statsofthe1stdrv.ofphasicEDA
eda_phasic_d2_ mean,std,lq,uq,median,min,max Statsofthe2nddrv.ofphasicEDA
| eda_phasic_ |     | npeaks           |     |     | Numberofpeaks                 |     |     |
| ----------- | --- | ---------------- | --- | --- | ----------------------------- | --- | --- |
| eda_phasic_ |     | risetime,dectime |     |     | Timesignalincreased/decreased |     |     |
eog_blink_br_ mean,std,lq,uq,min,max,median,rmssd,cv,kurtosis,skewness,p5,p95 Statisticsofblinkrate
eog_blink_bdur_ mean,std,lq,uq,median,rmssd,cv,kurtosis,skewness,p5,p95 Statisticsofblinkduration
eog_blink_tbb_ mean,std,lq,uq,median,rmssd,cv,kurtosis,skewness,p5,p95 Statisticsoftimebetweenblinks
eog_blink_bskew_ mean,std,lq,uq,median,rmssd,cv,kurtosis,skewness,p5,p95 Statisticsofblinkwaveformskewness
eog_sac_sr_ mean,std,lq,uq,min,max,median,rmssd,cv,kurtosis,skewness,p5,p95 Statisticsofsaccaderate
eog_sac_sdur_ mean,std,lq,uq,median,rmssd,cv,kurtosis,skewness,p5,p95 Statisticsofsaccadeduration
eog_sac_tbs_ mean,std,lq,uq,median,rmssd,cv,kurtosis,skewness,p5,p95 Statisticsoftimebetweensaccades
| eeg_ |     | bb  |     |     | Brainbeat |     |     |
| ---- | --- | --- | --- | --- | --------- | --- | --- |
Std,standarddeviation;lqanduq,lowerandupperquartile;pX,theX’thpercentile;sac,saccades.
(blink rate, time between blinks, blink duration, blink skewness, andthepost-hocanalyseswereexecutedbyusingTukey’scontrasts.
saccade rate, time between saccades, saccade duration) and EEG The significance level for statistical inference was Bonferroni
| (brainbeat).   |       |                       |                     | correctedtoaccountformultipletesting. |     |     |     |
| -------------- | ----- | --------------------- | ------------------- | ------------------------------------- | --- | --- | --- |
| The subtask    | type  | represented a fixed   | effect, participant | a                                     |     |     |     |
| random effect, | and a | 45s window with a 15s | window slide        | was                                   |     |     |     |
selectedforallfeatures.ThemodelswerecomputedwithR’slmer
andglmerfunctionsfromthelme4package(Batesetal.,2015). 2.4 Machine learning analysis
| Since the | number of | EDA peaks reflects counts, | a generalized |     |     |     |     |
| --------- | --------- | -------------------------- | ------------- | --- | --- | --- | --- |
linear mixed model (glmer) with Poisson link and maximum 2.4.1 Classification
likelihood with Laplace approximation was applied in the fit for Seven classifiers commonly used in stress detection studies
itandp-valueswerecomputedusingasymptoticWaldtest.Asfor detected CPT and MA from BL: k-nearest neighbors (KNN),
| the other | features, a linear | mixed model (lmer) | with maximum |                      |                       |             |         |
| --------- | ------------------ | ------------------ | ------------ | -------------------- | --------------------- | ----------- | ------- |
|           |                    |                    |              | linear and quadratic | discriminant analysis | (LDA, QDA), | support |
likelihoodestimationwasemployedandp-valueswerecomputed vector machine (SVM), decision tree (DT), random forest (RF),
with Satterthwaite’s method (Luke, 2017). The null models were and extreme gradient boosting (XGB), each of which is shortly
comparedtostresstypemodelswithanalysisofvariance(ANOVA) describedinthenextparagraph.
| FrontiersinNeuroergonomics |     |     |     | 05  |     |     | frontiersin.org |
| -------------------------- | --- | --- | --- | --- | --- | --- | --------------- |

| Tervonenetal. |     |     |     |     |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- | --- |
TABLE2 Numberofsamplesineachfeaturesetateachwindowlength. floatingsearch(SFFS)algorithm(Pudiletal.,1994),whichaddsor
Missingvaluesoccurredmainlywhenparticipantsmadetoofewblinksor
saccadestocomputeEOGfeatures. removesfeaturesasneededonebyoneuntilconvergence.Feature
|            |     |     |                 |     |     | selection | was not | conducted | for tree-based |     | models | because | they |
| ---------- | --- | --- | --------------- | --- | --- | --------- | ------- | --------- | -------------- | --- | ------ | ------- | ---- |
| Featureset |     |     | Windowlength(s) |     |     |           |         |           |                |     |        |         |      |
cansimplyignorenon-informativefeaturesduringmodeltraining
10 15 30 45 norfortheBBfeatureset,whichconsistedofasinglefeature.
|     |     |     |             |       |     | To estimate |     | how well | the models | generalize |     | to new | users, a |
| --- | --- | --- | ----------- | ----- | --- | ----------- | --- | -------- | ---------- | ---------- | --- | ------ | -------- |
| ECG |     |     | 3,762 2,420 | 1,078 | 814 |             |     |          |            |            |     |        |          |
leave-three-outvalidationstrategywasemployed.Ateachiteration,
EDA 3,762 2,420 1,078 814 the data of three users was left out, the model was trained with
EOG 2,520 1,956 1,012 792 the rest of the users’ data and evaluated with the left-out fold.
Additionally,anestedleave-three-outvalidationloopwasincluded
| BB     |     |     | 3,762 2,419 | 1,077 | 813 |                    |            |              |              |             |           |           |           |
| ------ | --- | --- | ----------- | ----- | --- | ------------------ | ---------- | ------------ | ------------ | ----------- | --------- | --------- | --------- |
|        |     |     |             |       |     | for hyperparameter |            | optimization |              | and feature | selection |           | to ensure |
| ECGEDA |     |     | 3,762 2,420 | 1,078 | 814 |                    |            |              |              |             |           |           |           |
|        |     |     |             |       |     | that optimal       | parameters |              | and features | were        | selected  | according | to        |
validation,andnottestingdata.Thus,ateachvalidationiteration,
| EOGBB       |     |     | 2,519 1,954 | 1,010 | 790 |              |                 |          |                  |     |           |     |           |
| ----------- | --- | --- | ----------- | ----- | --- | ------------ | --------------- | -------- | ---------------- | --- | --------- | --- | --------- |
|             |     |     |             |       |     | an internal  | leave-three-out |          | validation       | was | conducted |     | to select |
| ECGEDAEOGBB |     |     | 2,519 1,954 | 1,010 | 790 |              |                 |          |                  |     |           |     |           |
|             |     |     |             |       |     | the features | and             | the best | hyperparameters. |     | Balanced  |     | accuracy, |
weightedbynumberofsamplesineachfold,servedasanoptimality
|     |     |     |     |     |     | criterion, | since | the label | distribution | was | slightly | skewed: | as  |
| --- | --- | --- | --- | --- | --- | ---------- | ----- | --------- | ------------ | --- | -------- | ------- | --- |
KNN serves as an example of a distance-based classifier. A computedfromsubtaskdurations(seeFigure1),thedataconsisted
| new observation |     | is classified | to the class, | which most K | closest |     |     |     |     |     |     |     |     |
| --------------- | --- | ------------- | ------------- | ------------ | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
of(uptoaroundingerror)28.6%BL,42.9%CPT,and28.6%MA.
trainingobservationscomefrom.LDA,QDA,andSVMconstruct Theresultsarereportedintermsofaveragebalancedaccuracyand
hyperplanestoseparatetheclasses.QDAassumesthatthefeatures itsstandarddeviationacrossthevalidationfolds.
| follow a | multivariate | Gaussian | distribution | within each | class and |          |                |     |       |                |     |           |        |
| -------- | ------------ | -------- | ------------ | ----------- | --------- | -------- | -------------- | --- | ----- | -------------- | --- | --------- | ------ |
|          |              |          |              |             |           | In terms | of computation |     | time, | one validation |     | iteration | lasted |
classifiesanewobservationtotheclasswiththehighestposterior on average for 5s with the XGB model, and 0.8s with the SVM
probability,whichgivesrisetoaquadraticdecisionboundary.LDA
modelwithoutSFFSonthecomputerusedtoruntheexperiments.
issimilartoQDA,butitfurtherassumesthatcovariancematrices However,oneiterationwithSVMmodelwhenSFFSwasusedtook
of the different classes are equal, giving rise to a linear decision on average ∼7.7 min, so SFFS added a significant computational
| boundary. | On the | other | hand, SVM | makes no assumptions | on  |     |     |     |     |     |     |     |     |
| --------- | ------ | ----- | --------- | -------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
loadtomodeltraining.
the probability distributions but instead it directly constructs an Classification experiments were conducted in Python. The
optimalhyperplanewithmaximalmargintothedifferentclasses,
xgboostpackagewasusedforXGBimplementationandthescikit-
combinedwithtransformationtoaspaceinwhichthefeaturesare learn implementation for other classifiers. Bayesian optimization
linearlyseparable.DT,RF,andXGBaretree-basedclassifiers,which wasconductedwiththehyperopt andSFFSfeatureselectionwith
| split the | data hierarchically |     | with an aim | to contain observations |     |     |     |     |     |     |     |     |     |
| --------- | ------------------- | --- | ----------- | ----------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
themlxtendpackages.
| from a single | class | only | in each leaf node. | RF consists of | several |     |     |     |     |     |     |     |     |
| ------------- | ----- | ---- | ------------------ | -------------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
independentDTs,eachofwhichistrainedonarandomsubsetof
samplesandfeatures,whereasinXGB,theDTsarenotindependent
buttrytofixtheerrorsmadebyprevioustrees.Forfurtherreading 2.4.2 Modelexplanations
ontheclassifiers,werefertoHastieetal.(2009). Theparadigmofexplainableartificialintelligence(XAI),which
Classificationwasperformedwithsevenfeaturesetstoassess aimstohelpunderstandhowopaqueMLmodelswork,hasbeen
the effects of signal types. The feature sets were formed through acknowledgedasacrucialfeatureforpracticalMLmodelsinrecent
feature-level fusion, i.e., features from individual signals were years(BarredoArrietaetal.,2020).Inthiswork,XAIwasapplied
extracted independently and fused prior to classification. First, totheMLmodelsusingfeaturerelevanceexplanationtechniques
each signal distinguished between the stress states alone (feature that described the functioning of the model by measuring the
sets ECG, EDA, EOG, BB). Next, ECG and EDA features importance each feature had to the prediction output. The
were combined (feature set ECGEDA) since many devices (e.g., importanceoffeaturesforclassificationwasassessedwithShapley
Empatica E4 and Shimmer3) enable measuring those together. additiveexplanations(SHAP).
Similarly,EOGandBBwerefused(featuresetEOGBB)sinceEOG SHAP is a local, model-agnostic explanation method based
is often measured with EEG, to remove eye movement artifacts on game theory. It has a solid mathematical background with
fromtheEEGsignal.Finally,allavailablesignalswereusedtogether desirablepropertiesforanexplanationmethod,whicharediscussed
(feature set ECGEDAEOGBB). Table2 displays the number of thoroughlyinLundbergandLee(2017).Asalocalmethod,SHAP
samplesforeachfeaturesetandwindowlength. values are computed for each observation. To draw conclusions
Classification performance is generally improved by onglobalmodelbehavior,summarystatisticsorvisualizationsare
hyperparameter optimization and feature selection. In this work, needed.AsingleSHAPvaluedescribestheeffectthatanobserved
Bayesianoptimizationwasappliedtofindoptimalhyperparameters feature value has on the model output as compared to average
for each classifier (Bergstra et al., 2013). Non-informative priors prediction(Molnar,2022).So,inthecaseofclassification,aSHAP
withreasonablevaluerangewereadoptedforeachparameter,and valueofe.g.,0.04ofafeaturewithrespecttoagivenclassdenotes
the optimization was continued for 50 iterations per classifier, thattheprobabilityofbeingclassifiedtothegivenclasswas4%-
expectforLDAandQDA,whichhavenooptimizableparameters. points higher than it was on average. The global importance of
In addition, features were selected using the sequential forward eachfeaturecanbeestimatedasanaverageabsoluteSHAPvalue,
| FrontiersinNeuroergonomics |     |     |     |     |     | 06  |     |     |     |     |     | frontiersin.org |     |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

| Tervonenetal. |     |     |     |     |     |     |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- | --- |
TABLE3 Resultsofthemixedmodelpost-hocanalyses.ThedirectionoftheeffectcanbededucedfromthesignoftheZ-value.
|             |     |         | CPT-BL |         |     |         | MA-BL |         |     |         | MA-CPT |         |        |     |     |
| ----------- | --- | ------- | ------ | ------- | --- | ------- | ----- | ------- | --- | ------- | ------ | ------- | ------ | --- | --- |
| Feature     |     | z-value |        | p-value |     | z-value |       | p-value |     | z-value |        | p-value |        |     |     |
|             |     |         |        | <0.001  |     |         |       | <0.001  |     |         |        |         | <0.001 |     |     |
| ecg_hr_mean |     | 13.14   |        |         |     |         | 25.31 |         |     |         | 14.47  |         |        |     |     |
|             |     | −14.04  |        | <0.001  |     | −25.21  |       | <0.001  |     |         | −13.58 |         | <0.001 |     |     |
ecg_hrv_ibi_mean
|                     |     |       |     |        |     |        |       | <0.001 |     |     |       |     | <0.001 |     |     |
| ------------------- | --- | ----- | --- | ------ | --- | ------ | ----- | ------ | --- | --- | ----- | --- | ------ | --- | --- |
| ecg_hrv_rmssd       |     | −3.15 |     | 0.005  |     |        | −7.22 |        |     |     | −4.66 |     |        |     |     |
| eog_blink_br_mean   |     | 10.13 |     | <0.001 |     |        | 17.14 | <0.001 |     |     | 8.73  |     | <0.001 |     |     |
| eog_blink_tbb_mean  |     | −9.89 |     | <0.001 |     | −10.79 |       | <0.001 |     |     | −2.37 |     | 0.046  |     |     |
| eog_blink_bdur_mean |     | 5.01  |     | <0.001 |     |        | 0.69  | 0.768  |     |     | −3.73 |     | <0.001 |     |     |
| eog_sac_sr_mean     |     | 1.20  |     | 0.454  |     |        | 3.72  | <0.001 |     |     | 2.78  |     | 0.0148 |     |     |
| eog_sac_sdur_mean   |     | 16.36 |     | <0.001 |     |        | 17.75 | <0.001 |     |     | 3.84  |     | <0.001 |     |     |
|                     |     |       |     |        |     |        |       | <0.001 |     |     |       |     | <0.001 |     |     |
| eda_npeaks          |     | 0.31  |     | 0.949  |     |        | 8.75  |        |     |     | 8.80  |     |        |     |     |
|                     |     |       |     | <0.001 |     |        |       | <0.001 |     |     |       |     | <0.001 |     |     |
| eda_mean            |     | 4.23  |     |        |     |        | 19.45 |        |     |     | 16.30 |     |        |     |     |
|                     |     |       |     |        |     |        |       | <0.001 |     |     |       |     | <0.001 |     |     |
| brainbeat           |     | −0.25 |     | 0.966  |     |        | 6.00  |        |     |     | 6.37  |     |        |     |     |
TheBonferronicorrectedsignificancelevelforp-valuesinthesetestswas0.005.
and investigationofthedistributionofindividualSHAPvaluesin windowlengthareshowninFigure2.Foradeeperinvestigation,
relationtofeaturevaluesallowsassessinghowchangesinfeature the classification results are available in numerical format as
valuesarerelatedtochangesinmodeloutput. Supplementarymaterial.
Thedifferencesbetweenclassifiersorfeaturesetsweremodest:
|     |     |     |     |     |     |     | average | performances |     | were | usually | within | standard | deviations, |     |
| --- | --- | --- | --- | --- | --- | --- | ------- | ------------ | --- | ---- | ------- | ------ | -------- | ----------- | --- |
3 Results except for the BB feature set and QDA classifier. This is
|           |       |         |     |     |     |     | understandable, |          | since       | the     | BB feature  | set          | consisted | of             | only a  |
| --------- | ----- | ------- | --- | --- | --- | --- | --------------- | -------- | ----------- | ------- | ----------- | ------------ | --------- | -------------- | ------- |
| 3.1 Mixed | model | results |     |     |     |     |                 |          |             |         |             |              |           |                |         |
|           |       |         |     |     |     |     | single          | feature, | as          | opposed | to multiple | features     | in        | other          | feature |
|           |       |         |     |     |     |     | sets.           | For      | most window |         | durations   | and signals, |           | QDA classifier |         |
ThephysiologicalstressreactionsduringtheCPTandMAtrials
|     |     |     |     |     |     |     | performed |     | poorly, | which | likely occurred | due | to its | sensitivity | to  |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | ------- | ----- | --------------- | --- | ------ | ----------- | --- |
oftheMASTwerestudiedwithlinearmixedmodelanalysis.The multicollinearity,ase.g.,HRVvariablestendtobecorrelated.When
resultsshowedstatisticallysignificanteffectofstresstype(BL,CPT,
SFFSwasrunwithQDA,itperformedsimilarlytootherclassifiers.
MA)onallfeatures,expectforblinkskewnessandthetimebetween Table4showstheconfusionmatricesforeachwindowduration
saccades.Theresidualnormalitywasverifiedfromthehistograms
fortheXGBmodelwithECGEDAEOGBBfeatureset.Predicting
andq-qplotsforallthemodelswithstatisticallysignificanteffect
|     |     |     |     |     |     |     | baseline | when | the | actual | observations | were | from | a stressful | state |
| --- | --- | --- | --- | --- | --- | --- | -------- | ---- | --- | ------ | ------------ | ---- | ---- | ----------- | ----- |
forthestresstype.Post-hocanalysesofallthesignificantfeatures was uncommon: 3.9 − 5.6% and 0.9 − 1.8% of observations
| are presented | in Table3. | Detailed |     | results of | the mixed | model |      |     |         |               |     |                 |     |       |         |
| ------------- | ---------- | -------- | --- | ---------- | --------- | ----- | ---- | --- | ------- | ------------- | --- | --------------- | --- | ----- | ------- |
|               |            |          |     |            |           |       | from | CPT | and MA, | respectively, |     | were classified |     | as BL | at each |
analysisincludinganalysisofvariancemodelcomparison,models window length. Similarly, the amount of BL data classified
| fixed and | random | effects as | well as | effect sizes | are included |     | in  |        |         |     |           |          |     |               |     |
| --------- | ------ | ---------- | ------- | ------------ | ------------ | --- | --- | ------ | ------- | --- | --------- | -------- | --- | ------------- | --- |
|           |        |            |         |              |              |     | as  | MA was | between | 0.4 | and 4.2%. | Instead, | the | two stressful |     |
Supplementarymaterial.
|     |     |     |     |     |     |     | states | were | increasingly | confused |     | with each | other | when window |     |
| --- | --- | --- | --- | --- | --- | --- | ------ | ---- | ------------ | -------- | --- | --------- | ----- | ----------- | --- |
durationdecreased,andsimilarlypredictingCPTinsteadofBLwas
increasinglymorecommonwithshorterwindows.
3.2 Classification results Therefore, the classifier performed well when the task was to
|     |     |     |     |     |     |     | distinguish |     | BL and | stress | or BL and | MA from | each | other, | while |
| --- | --- | --- | --- | --- | --- | --- | ----------- | --- | ------ | ------ | --------- | ------- | ---- | ------ | ----- |
3.2.1 Overallperformance classification between the two stressful states was more difficult.
Longer windows tended to perform better regardless of DetectingCPTfromBLwasalsomorechallengingthandetecting
classifiertypeandfeatureset.Thebestbalancedaccuracyata45s MA from BL, as CPT exhibited a closer physiological proximity
windowlengthwas86.5%,whichwasclearlyhigherthanthebest to BL than MA. Similar phenomenon was observed earlier in
ata 10swindowlength,74.8%.The bestsinglesignalseemedto Tervonenetal.(2021b).
beEOGforalmostallclassifiersandwindowdurationsbutfeature
setswithmultiplesignalsperformedbetterthansinglesignals.The
combinedECGEDAEOGBBperformedthebestoutofallfeature
setsacrossallclassifiers,exceptforQDA. 3.2.2 Parameteroptimization
SVMprovidedthebestperformancewith12outof28window Figure3 shows how beneficial Bayesian hyperparameter
lengthandfeaturesetcombinations,followedbyXGB(10),SVM optimizationwasascomparedtousingdefaulthyperparameters(as
with SFFS (3), DT with SFFS (2), and RF (1). The balanced determinedforeachclassifierineachofthesoftwarepackagesused)
accuracies for each set of features with each classifier and each withthe45swindowlength.
| FrontiersinNeuroergonomics |     |     |     |     |     |     | 07  |     |     |     |     |     |     | frontiersin.org |     |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

Tervonenetal. 10.3389/fnrgo.2023.1294286
FIGURE2
Averagebalancedaccuracyandstandarddeviationacrossthewindowlengths,featuresetsandclassifiers.Theaverageandstandarddeviationwere
computedacrossthevalidationfolds.The“-s”afteramodelnamedenotesscoreswithSFFSfeatureselection.
TABLE4 ConfusionmatricesoftheXGBmodelforeachwindowlength
withallavailablefeatures,valuesaspercentagesoftruelabels.
Predictedlabel
|     |     |     | BL   | MA CPT | BL       | MA   | CPT  |     |
| --- | --- | --- | ---- | ------ | -------- | ---- | ---- | --- |
|     |     |     |      | 45s    |          | 30s  |      |     |
|     |     | BL  | 89.9 | 0.4    | 9.7 85.8 | 1.0  | 13.2 |     |
|     |     | MA  | 1.6  | 80.6   | 17.8 1.8 | 82.4 | 15.8 |     |
|     |     | CPT | 3.9  | 7.2    | 88.9 5.6 | 10.1 | 84.2 |     |
Truelabel
|                    |              |            |            | 15s          |              | 10s            |        |     |
| ------------------ | ------------ | ---------- | ---------- | ------------ | ------------ | -------------- | ------ | --- |
|                    |              | BL         | 76.3       | 2.9          | 20.8 71.5    | 4.2            | 24.4   |     |
|                    |              | MA         | 1.7        | 76.8         | 21.5 0.9     | 73.5           | 25.6   |     |
|                    |              | CPT        | 4.4        | 13.6         | 82.0 4.7     | 16.4           | 78.9   |     |
| The                | optimization | improved   |            | balanced     | accuracy     | by             | 1 − 6  |     |
| percentage         | points       | for most   | models     | and          | feature      | sets.          | The DT |     |
| algorithm          | seemed       | to benefit | the        | most         | with up to   | 9.1 percentage |        |     |
| point improvement. |              | Most       | of the     | improvements |              | occurred       | within |     |
| the first          | iterations,  | and        | on average | further      | improvements |                | were   |     |
limitedto<1percentagepointafterteniterationsoftheBayesian
FIGURE3
optimizationalgorithm(datanotshown). Thedifferenceofaveragebalancedaccuracybetweenoptimized
Overall, feature sets with lower performance (e.g., BB and anddefaulthyperparameterswithallmodelsandfeaturesetsata
45swindowlength.The“-s"afteramodelnamedenotesuseof
| EDA), which | also | had more | room | for | improvement, | seemed | to  |     |
| ----------- | ---- | -------- | ---- | --- | ------------ | ------ | --- | --- |
SFFSfeatureselection.
| benefit more       | from | parameter | optimization |                | than | feature          | sets with |     |
| ------------------ | ---- | --------- | ------------ | -------------- | ---- | ---------------- | --------- | --- |
| higher performance |      | (e.g.,    | EOG).        | Interestingly, |      | the optimization |           |     |
processcouldnotdiscoverhyperparametersthatperformedbetter
than the default ones in some conditions (e.g., SVM-SFFS with increaseinbinaryworkloadclassificationaccuracy,andingeneral,
ECGEDAEOGBB features). These observations are in line with withmostdatasetsthehyperparameteroptimizationyieldslittleor
Tervonen et al. (2021a) who reported a 3.7 percentage points noimprovement(SunandPfahringer,2013;Tranetal.,2020).
| FrontiersinNeuroergonomics |     |     |     |     |     |     | 08  | frontiersin.org |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --------------- |

Tervonenetal. 10.3389/fnrgo.2023.1294286
3.2.3 Explainabilityanalysis 4.1.1 Cardiacresponses:ECG
The focus on this section is on the best performing classifier, HR and its inverse, mean of IBIs, were the most important
XGB with 45s window length and ECGEDAEOGBB feature set. featuresoftheECGparameters.Asexpected,HRwasloweratBL
PleaserefertoTable1fornamingoffeatures. and the psychosocial stressor (MA) increased it, which shows in
EvaluatingfeatureimportanceasabsoluteSHAPvalueforeach bothTable3andFigure5.Accordingtothemixedmodelresults,
classallowsanalyzingtheimpacteachfeaturehadonseparatingthe HRincreasedduringCPTascomparedtoBL,butthedirectionof
classfromothers.Figure4showstop-20mostimportantfeatures theHRchangeinCPTwaslessobviousinFigure5.Thebehavior
accordingtoabsoluteSHAPvalues.Themostinfluentialfeatures may follow from three reasons: (1) the features were normalized
wererelatedtosaccadeduration(sixfeatures)andallsignalsexcept to have zero mean on an individual level in the ML analysis, (2)
forBBhadsomefeaturesinthetop-20.Thedifferencesbetweenthe featureinteractionsaffectedtheresultsandthustheSHAPvalues
totalimportanceoffeaturesweremodest,butthefigureshowsthat in the ML analysis, and (3) features were considered separately
e.g.,featuresonsaccadedurationwereespeciallyimportantforthe withoutnormalizationinthemixedmodelanalysis.Asseenfrom
correctclassificationofBLandCPT,whileEDAfeaturesweremore Figure5,higherHRthanone’sownaverageincreasedthechance
involvedindistinguishingMA. of being classified to CPT, and lower HR, which is the case for
However, absolute SHAP values show no direction of the majorityofdataduringCPT,decreasedthischance.Theresultmay
contributions of different features and many of the features are alsoreflectindividualdifferencesinHRreactions,asMourotetal.
difficult to interpret. Therefore, the inspection is continued with (2008)reported.Theyfoundthatsomeoftheparticipantsshowed
the interpretable set of features defined in Section 2.2. First, an increasing HR trend during the 3-min CPT, while the other
classification was redone with the XGB model at 45s window participants’ HR started to decrease after a short initial increase.
length. After optimizing hyperparameters, the balanced accuracy Sendowski et al.(1997) reportedthat HR beganto decreaseafter
withtheinterpretablefeaturesetwas81.5%,whichisrathersimilar one minute of cold immersion. In the current study, little of the
to the full set of features, 86.5%, considering that only 8.7% of CPTdatacomefromtheconditionwhereCPThaslastedforovera
features were used. So, simplifying the model by reducing the minute.
number of features by a large margin and by using features that HRV,characterizedbyparameterRMSSD,classicallyindicates
are easier to understand led only to slightly lower performance. stress(Schmidtetal.,2019):stressattenuatesHRV.Interestingly,
Following the classification, SHAP values were computed and a the role of RMSSD was clear but quite modest, both in mixed
beeswarmplotoftheSHAPvalueswasdrawninFigure5tomore models (Table3) and in SHAPs (Figure5), indicating that in this
carefully assess the ways in which features affected classification, protocol, CPT was less stressful than MA. According to mixed
whichisdiscussednext. models, RMSSD was lower during MA than CPT and according
to the SHAP values, lower RMSSD values were associated with
lowerchanceofbeingclassifiedtoCPTandhigherchanceofbeing
classifiedtoMA.
4 Discussion
4.1 Physiology, feature importance and 4.1.2 Eyeparameters:EOG
contributions to classification Thesaccadedurationlinksdirectlytothemagnitudeoftheeye
movement,thelongerthedurationthelargertheeyemovement.
Figure5 supports the mixed model finding that physiological The saccade duration contributed strongly to all conditions,
reactionsbetweenthestresstypesaredifferent,andfornearlyall especially in BL and CPT. Brief saccades associated with BL and
features,thedirectionoftheimpactissimilartothedirectionof longeroneswiththestressstates.Onereasonforthisdistinction
the effect in the mixed models; Table5 summarizes the findings. mayberelatedtotheexperimentalsetup,asthevisualinformation
ThediscrepanciesbetweenmixedmodelandSHAPresultsoccur differedbetweenBLandMAST.DuringtheBL,participantskept
since the methods are overall different, SHAP (through the XGB theirgazeonafixationpointinthemiddleofascreen,whereasin
classifier)alsotakesfeaturecorrelationsintoaccount,anddespite both MAST trials the instructions (two lines of text) were visible
thatsomefeaturesmaynotshowstatisticallysignificantdifference onthescreen.AlthoughthevisualstimulusmatchedbetweenCPT
betweenconditions(i.e.,shownodifferenceinmixedmodels),they andMA,thetrialsexhibitedacleardisparity:theparticipantsmade
maydifferenoughtoimproveclassificationwhichdisplaysinthe shortersaccadesinCPT.Thismeansthatthesaccadedurationmay
SHAPvalues. alsocontaininformationaboutthetypeofstressandnotjustthe
The traditional stress-related markers such as HR and HRV visualstimulus.
parametersandmeanEDAsuggestthatMAcausedstrongereffects Saccade rate (SR) reflects eye activity: the higher the SR the
than the CPT and BL, while the CPT caused slightly more stress moreactivelythepersonscanstheenvironment(e.g.,visualsearch).
thanBL.Despitethatthereactionsvariedbetweenthesubtasks,the According to the mixed model analysis, the participants moved
currentstudyexpressesnoverificationforwhetherMAandCPT their eyes more often in MA than in BL and CPT, which is also
eliciteddifferenttypesofstresssolelythrougheithertheHPAorthe visible in Figure5: higher SR contributes to MA classification
SAM,asjustifiedintheintroduction.Next,physiologicalreactions whereasitscontributioninBLandCPTisconfusing.InMA,the
arepresentedanddiscussedinmoredetailsignalbysignal. seed number was visible on the screen and the participants may
FrontiersinNeuroergonomics 09 frontiersin.org

Tervonenetal. 10.3389/fnrgo.2023.1294286
FIGURE4
Top-20featuresaccordingtoabsoluteSHAPvaluesoftheXGBclassifierata45swindowlengthandthefeaturesetECGEDAEOGBB.Thelengthof
thebarforeachclassdescribestheclass-wiseimportanceofthefeature.
FIGURE5
BeeswarmplotoftheSHAPvaluesoftheinterpretablefeatureset.Markerscorrespondtoobservationsinthedata.Themarkercolorsreflectfeature
valuesandthelocationonthehorizontalaxisshowshowthatfeatureaffectstheprobabilityofbeingclassifiedintoeachofthethreeclasses.
FeaturesareorderedaccordingtoabsoluteSHAPvalue,descending.
FrontiersinNeuroergonomics 10 frontiersin.org

| Tervonenetal. |     |     |     |     |     |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- |
have scanned the number while performing mental calculation, usedinactualpainstudiesandcareshouldbeusedincomparing
| whichmayincreaseSRcomparedtoBLandCPT. |           |                |         |         |             |              | theresults. |     |     |     |     |     |     |
| ------------------------------------- | --------- | -------------- | ------- | ------- | ----------- | ------------ | ----------- | --- | --- | --- | --- | --- | --- |
| Blink                                 | rate (BR) | and time       | between | blinks  | (TBB)       | both reflect |             |     |     |     |     |     |     |
| how actively                          | a         | person blinks. | MA      | induced | the highest | BR,          | but         |     |     |     |     |     |     |
also CPT increased the BR compared to BL. In earlier studies, 4.1.4 Cognitiveload:EEG
| CPT and | painful | stimulation | in general | have | increased | the | BR  |     |     |     |     |     |     |
| ------- | ------- | ----------- | ---------- | ---- | --------- | --- | --- | --- | --- | --- | --- | --- | --- |
Brainbeatindicatesthelevelofcognitiveloadingandattention
(Paparella et al., 2020). Attentional engagement decreases the (Holm et al., 2009). Mixed model analysis (Table3) accentuated
numberofblinksduringcognitivelydemandingtasksthatrequire
thatonlytheMAincreasestheBB.AccordingtoFigure5,BBhad
visualattention(MaffeiandAngrilli,2019;Rantietal.,2020).Here low feature importance, but its behavior was curiously different
| MA was | cognitively | demanding | but | required | no visual | attention. |            |                |           |         |     |        |           |
| ------ | ----------- | --------- | --- | -------- | --------- | ---------- | ---------- | -------------- | --------- | ------- | --- | ------ | --------- |
|        |             |           |     |          |           |            | from other | features. High | BB values | related | to  | higher | chance of |
SimilarMAtaskshaveincreasedtheBRandgivinganswerverbally
|     |     |     |     |     |     |     | being classified | to BL and | MA, | and low | BB values | to  | CPT. MA |
| --- | --- | --- | --- | --- | --- | --- | ---------------- | --------- | --- | ------- | --------- | --- | ------- |
hasincreasedBRsignificantlycomparedtoanon-verbalcondition challengesonecognitively,butBLissupposedtobearelaxingand
| (Schuri | and von | Cramon, | 1981). | Moreover, | MA  | in this study |             |              |           |        |      |         |        |
| ------- | ------- | ------- | ------ | --------- | --- | ------------- | ----------- | ------------ | --------- | ------ | ---- | ------- | ------ |
|         |         |         |        |           |     |               | even boring | phase of the | protocol, | which, | when | looking | at HR, |
containedtimepressureandpenalizationexposingparticipantsto HRVandEDA,seemstobeso.However,thebrainseemstoremain
asocial-evaluativethreat.Thisuncomfortablesituationmighthave
relativelyactiveduringBL,whereasduringCPT,thecognitiveload
| caused anxiety |     | or even fear, | which | also increases | BR  | (Maffei | and      |                    |     |            |          |           |     |
| -------------- | --- | ------------- | ----- | -------------- | --- | ------- | -------- | ------------------ | --- | ---------- | -------- | --------- | --- |
|                |     |               |       |                |     |         | seems to | diminish, possibly | as  | a recovery | reaction | following | the |
Angrilli,2019). high-loadMAphase.IntheCPTphase,theparticipantsmentally
| Blink | duration, | i.e., the | time the | eye is | closed | while blinking, |            |               |         |         |           |      |        |
| ----- | --------- | --------- | -------- | ------ | ------ | --------------- | ---------- | ------------- | ------- | ------- | --------- | ---- | ------ |
|       |           |           |          |        |        |                 | relax from | the MA, which | is also | visible | in RMSSD, | even | if the |
contributes positively to CPT (longer blinks) and negatively to CPT itself is physically uncomfortable. Interestingly, many EEG
| BL and | MA (shorter | blinks). | Increased | blink | duration | indicates |     |     |     |     |     |     |     |
| ------ | ----------- | -------- | --------- | ----- | -------- | --------- | --- | --- | --- | --- | --- | --- | --- |
studiesofpainhaveusedCPTaspaininductionmethod(Chang
| sleepiness | (Schleicher | et al., | 2008), | however, | decreased | vigilance |     |     |     |     |     |     |     |
| ---------- | ----------- | ------- | ------ | -------- | --------- | --------- | --- | --- | --- | --- | --- | --- | --- |
etal.,2002;Chouchouetal.,2021),andthosestudieshavefound
increases especially the re-opening time of the eye, which in increased frontal theta and decreased parietal alpha activity in
turnskewstheblink’swaveform(blinkskewness).Heretheblink
|     |     |     |     |     |     |     | pain condition, | i.e., effects | that | would show | as  | increased | BB. In |
| --- | --- | --- | --- | --- | --- | --- | --------------- | ------------- | ---- | ---------- | --- | --------- | ------ |
skewnessshowednochangesindifferentstressstages,suggesting those experiments, the CPT duration has typically been longer,
| that the | blink | duration | may be | a sufficient | indicator | of  | the |     |     |     |     |     |     |
| -------- | ----- | -------- | ------ | ------------ | --------- | --- | --- | --- | --- | --- | --- | --- | --- |
cumulatingthepainsensation,andnotpreceededbyacognitively
| discomfort | and | even pain | experienced | during | the | cold pressor. |     |     |     |     |     |     |     |
| ---------- | --- | --------- | ----------- | ------ | --- | ------------- | --- | --- | --- | --- | --- | --- | --- |
stressfulphase.
However,noliteraturewasfoundaddressingthelinkbetweenblink
durationanddiscomfortorpain.
|     |     |     |     |     |     |     | 4.2 Characteristics |           | and      | consequences |     |     | of  |
| --- | --- | --- | --- | --- | --- | --- | ------------------- | --------- | -------- | ------------ | --- | --- | --- |
|     |     |     |     |     |     |     | the stress          | induction | protocol |              |     |     |     |
4.1.3 Skinconductivityresponse:EDA
The amplitude of the phasic EDA increased in both stressor WhencomparingtheMASTresultstoresultsfromprotocols
tasks (Table3), but the effect was stronger in MA, indicating inducing only one type of stress, there are some differences
higher stress, and MA and CPT indeed differed from each other to be considered. The trials in MAST last from 45 to 90s. In
significantly.Thesamewasseenevenmoreclearlyinthenumber protocols employing stressors with longer durations, adaptation
of EDA peaks: there was no difference between CPT and BL but and habituation may contribute more. On the other hand, in
bothweredifferentfromMA.Theseobservationsareinlinewith MAST, repetition introduces a learning effect, especially in MA.
SHAPvaluesinFigure5.HighervaluesinphasicEDAandnumber As MAST has no recovery delay between MA and CPT phases,
of peaks were related to higher chance of being classified into the physiological adaptation to the new stressor will take some
MA. Consequently, higher values decreased the chance of being time, and the response time will depend on the biosignal. The
classifiedintoBLandCPTandlowervaluesincreasedthischance. adaptationtime,orphysiologicalleakage,makesclassificationmore
EDA activity is linked to the arousal level and activation of challenging, especially during the first windows, which may be
thesympatheticANSbranch,suggestingthatCPTcausesslightly erroneouslyclassifiedintotheprevioussubtask.Thedynamicsof
largersympatheticactivationthanBL,andMAclearlylargerthan thephysiologicalsignalsduringMASTastimeseriesisanobvious
CPT. Recently, Lee (2021) provided a comprehensive summary researchneedarisingfromthecurrentwork.
of the connection between EDA and engagement, attention, and The CPT subtasks in MAST last for at most 90s and the
alertness:increasedEDAwaslinkedtoe.g.,cognitiveeffortduring handiswarmedupbyaheatpadduringtheinterleavedMAtrials.
solving arithmetic problems or reading a map, and state anxiety Comparedtopaininductionprotocolswherethemaximumpain
while being asked to give a public unplanned presentation. This ratingistypicallyreachedataround90sthroughthe3-minCPT
agrees with the results in this study: EDA response is strong in (Changetal.,2002),theaveragepaininMASTislikelylowerthan
MA,demandingcognitiveeffortandattention.EDAhasalsobeen inastandardpain-inductionCPT.Moreover,theCPTinthisstudy
usedinassessmentofpainperceptionandthefeasibilityofanEDA- wasappliedtotheright(dominant)hand,forpracticalpurposes,
basedalgesimeterwasintroducedinStorm(2008)withpromising asthelefthandwaskeptimmobiletoensuregoodsignalinEDA,
results. On a group level, EDA appears to be less sensitive pain andthedominanthandwasneededtooperatethequestionnaires.
marker than HR, yet on an individual level, EDA correlates with McGinley and Friedman (2015) have indicated that CPT would
painratingsbetterthanHR(Loggiaetal.,2011).However,inthe produce largereffects when appliedto theleft hand. Thisindeed
MASTprotocol,theinducedpainmaynotbecomparabletostimuli could have produced even stronger responses and in protocols
| FrontiersinNeuroergonomics |     |     |     |     |     |     | 11  |     |     |     |     | frontiersin.org |     |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

| Tervonenetal. |     |     |     |     |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- |
wherethetargethandcanbeselectedfreely,theleftoneshouldbe acrossalltheothercomponents.Theaverageappliedwasharmonic
favored. mean, since the average was taken over relative values (balanced
accuracies).Overall,theselectionofthesignalstomeasureandto
|     |     |     |     |     |     | use for classification |     | showed | the largest | effect, | whereas | the other |
| --- | --- | --- | --- | --- | --- | ---------------------- | --- | ------ | ----------- | ------- | ------- | --------- |
4.3 Machine learning pipeline components choicesresultedwithmoderatetoloweffect.
|     |     |     |     |     |     | Therefore, | practitioners |     | and | researchers | should | pay special |
| --- | --- | --- | --- | --- | --- | ---------- | ------------- | --- | --- | ----------- | ------ | ----------- |
Table6 presents a summary of the effect of different ML attentiontothechoiceofthesignalstheymeasureandconsiderthe
viabilityofmeasuringseveralfortheirapplication.Oncethesignals
| components | and | learnings | from | them. The effect | of each |     |     |     |     |     |     |     |
| ---------- | --- | --------- | ---- | ---------------- | ------- | --- | --- | --- | --- | --- | --- | --- |
componentwasassessedasdifferenceinaveragebalancedaccuracy have been selected, using longer feature windows or selecting
|     |     |     |     |     |     | features | with SFFS | seem | to be the | best | alternatives. | However, |
| --- | --- | --- | --- | --- | --- | -------- | --------- | ---- | --------- | ---- | ------------- | -------- |
SFFScomeswithanotablecomputationalload,whichmayhinder
TABLE5 SummaryoftheeffectsofCPTandMAtotheinterpretable its applicability especially with larger datasets. The choice of the
featuresascomparedtoBL. duration of feature windows was limited to at most 45s in this
studybecauseofthedatacollectionprotocol.Shortwindowsenable
| Feature |     | Mixedmodels |     | SHAP |     |     |     |     |     |     |     |     |
| ------- | --- | ----------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
closer-to-real-timestatedetection,buttheperformancedecreased
ecg_hr_mean Increasedinboth Agrees,butless as window duration decreased. The overall impression has been
obviousinCPT
notedbefore(Gjoreskietal.,2017;Siirtola,2019;Tervonenetal.,
ecg_hrv_ibi_mean Decreasedinboth Agrees,butless 2021a).Thislikelyhappenssinceshorterfeaturewindowsenclose
obviousinCPT
lessdataandthus,lessinformation,andlessphysiologicalevents
ecg_hrv_rmssd Decreasedinboth AgreesinMA than longer ones. In addition, shorter windows contain fewer
samplesandconsequently,thecontributionofnoiseandtransient
| eda_mean |     | Increasedinboth |     | AgreesinMA |     |     |     |     |     |     |     |     |
| -------- | --- | --------------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
artifactsishigherthaninlongerwindows.Consideringthatthe10s
| eda_npeaks |     | IncreasedinMA |     | AgreesinMA |     |     |     |     |     |     |     |     |
| ---------- | --- | ------------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
windowcontainedalmostfivetimeslessdatathanthe45swindow
| eog_blink_br_mean |     | Increasedinboth |     | Agrees,butless |     |     |     |     |     |     |     |     |
| ----------------- | --- | --------------- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
butstillapproximatelythreeoutoffourclassificationswerecorrect,
obviousinCPT
|     |     |     |     |     |     | shorter windows |     | may have | some | use in applications |     | where more |
| --- | --- | --- | --- | --- | --- | --------------- | --- | -------- | ---- | ------------------- | --- | ---------- |
eog_blink_bdur_mean IncreasedinCPT AgreesinCPT,but timely state detection is necessary, such as driver monitoring. In
decreasedinMA
|     |     |     |     |     |     | some other | domains, | like | chronic | stress | management, | hourly or |
| --- | --- | --- | --- | --- | --- | ---------- | -------- | ---- | ------- | ------ | ----------- | --------- |
eog_blink_tbb_mean Decreasedinboth AgreesinCPT,but evendailystressdetectionmaybesufficient.Thus,theselectionof
lessobviousinMA
windowdurationcomesdowntorequirementsoftheapplication
eog_blink_bskew_mean Nodifference IncreasedinMA, underinvestigation,whichshouldbeconsideredwheninterpreting
|     |     |     |     | decreasedinCPT |     | theresultsinthispaper. |     |     |     |     |     |     |
| --- | --- | --- | --- | -------------- | --- | ---------------------- | --- | --- | --- | --- | --- | --- |
eog_sac_sr_mean IncreasedinMA AgreesinMA,but Reducingthenumberoffeaturesdecreasedmodelperformance
decreasedinCPT by5percentagepoints.However,suchreductionallowedtostudy
eog_sac_sdur_mean Increasedinboth Agrees the features effects on classification and reflect them to human
|                  |     |              |     |              |     | physiology | (see | Section | 4.1). This | examination |     | showed that the |
| ---------------- | --- | ------------ | --- | ------------ | --- | ---------- | ---- | ------- | ---------- | ----------- | --- | --------------- |
| eog_sac_tbs_mean |     | Nodifference |     | Smalleffect, |     |            |      |         |            |             |     |                 |
modelconcentratedonphysiologicallyrelevantphenomena.Such
decreasedinCPT
|           |     |               |     |             |     | analysis gives | the     | model   | some ecological |      | validity | and helps build |
| --------- | --- | ------------- | --- | ----------- | --- | -------------- | ------- | ------- | --------------- | ---- | -------- | --------------- |
| brainbeat |     | IncreasedinMA |     | AgreesinMA, |     |                |         |         |                 |      |          |                 |
|           |     |               |     |             |     | trust to       | it. Had | it been | conducted       | with | the      | full set of 150 |
decreasedinCPT
TABLE6 ObservationsmadefromtheinvestigatedMLpipelinecomponents,andtheireffectonbalancedaccuracy.
| Choice |     |     | Observations |     |     | Comparison |     |     |     |     | Effect |     |
| ------ | --- | --- | ------------ | --- | --- | ---------- | --- | --- | --- | --- | ------ | --- |
Signalstomeasure -EOGandECGwerethebestsinglesignals -toEDAandtoBB +0.11,+0.25
|     |     |     | -Addingsignalsimprovedperformance  |     |     | -ECGEDAEOGBBtoEOG |     |     |     |     | +0.06 |     |
| --- | --- | --- | ---------------------------------- | --- | --- | ----------------- | --- | --- | --- | --- | ----- | --- |
|     |     |     | -BesttwosignalcombinationwasECGEDA |     |     | -toEOGBB          |     |     |     |     | +0.01 |     |
Lengthoffeaturewindows -Longerwindowsperformedbetter -45swindowto10swindow +0.05
Featureselection -SFFSwasusefulbutathighcomputationalcost -modelswithvs.withoutSFFS +0.07
−0.05
|     |     |     | -InterpretablesetoffeaturesbasedonSHAPvalues |     |     | -InterpretabletofullfeaturesetwithXGB |     |     |     |     |     |     |
| --- | --- | --- | -------------------------------------------- | --- | --- | ------------------------------------- | --- | --- | --- | --- | --- | --- |
|     |     |     | performednearlyaswellasthefullset            |     |     | and45swindow                          |     |     |     |     |     |     |
Classifier -XGBshowedhighestperformance -tothenextbestmodelRF +0.02
Hyperparameteroptimization -Benefitratherlimited -optimizedtodefaultparameters +0.02∗
-FewiterationsofBayesianoptimizationsuffices -50vs.5iterations +0.003∗
|     |     |     | -Modelsandfeaturesetswithpoorerperformance |     |     | -seeFigures2,3 |     |     |     |     | -   |     |
| --- | --- | --- | ------------------------------------------ | --- | --- | -------------- | --- | --- | --- | --- | --- | --- |
seemedtobenefitmore
Effectvaluesareharmonicmeansofbalancedaccuraciesobtainedacrosstheotherchoices.
∗Arithmeticmean,sincesomevalueswerenegative.
| FrontiersinNeuroergonomics |     |     |     |     |     | 12  |     |     |     |     |     | frontiersin.org |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- |

| Tervonenetal. |     |     |     |     |     |     |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- |
features, making conclusions at such detailed level would have could rely on single signal models when data from one signal is
| beenoverwhelming.Therefore,optingforfewerfeaturesinfavor |     |     |     |     |     |     |     | missing. |     |     |     |     |     |     |
| -------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- | --- | --- |
ofinterpretabilityisdesirableinanyapplicationthatrequirestrust Finally, stress reactions are subjective. The current study
totheMLmodel. acknowledged this only by normalizing feature separately for
|                 |     |     |        |     |      |     |     | each participant | before                 | classification. |            | While       | the approach     | is       |
| --------------- | --- | --- | ------ | --- | ---- | --- | --- | ---------------- | ---------------------- | --------------- | ---------- | ----------- | ---------------- | -------- |
|                 |     |     |        |     |      |     |     | common           | and shown to           | be              | effective, | it requires | a                | full set |
|                 |     |     |        |     |      |     |     | of data          | from each participant, |                 | and        | thus        | it is infeasible | in       |
|                 |     |     |        |     |      |     |     | application      | which expect           | new             | users:     | features    | could            | not be   |
| 4.4 Limitations |     | and | future |     | work |     |     |                  |                        |                 |            |             |                  |          |
normalizedforthenewpersonuntilsufficientdatawascollected.
|     |     |     |     |     |     |     |     | Furthermore, | the participant-wise |     | balanced | accuracy | varied | from |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | -------------------- | --- | -------- | -------- | ------ | ---- |
Thesamplesizeinthedatasetwasrathersmall,butcomparable 56 to 100% for the most accurate model, and so the model
tosamplesizesdocumentedinseveralreviewarticles:Giannakakis
performedpoorlyforsomepeople.Itcouldbethatthosepersons
et al. (2022) reported an average of 23 participants in stress were indeed not stressed, but to improve the performance
detectionstudies,Schmidtetal.(2019)anaverageof21participants
|     |     |     |     |     |     |     |     | and the | practical value | of  | the model, | future | work | could |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --------------- | --- | ---------- | ------ | ---- | ----- |
instressandaffectdetectionstudies,andVosetal.(2023)conveyed considerpersonalizationapproachesthatimprovetheperformance
anaveragesamplesizeof21inopenstressdetectiondatasets,and for the most difficult participants and operate on minimal
anaveragenumberofparticipantsof19instressdetectionstudies.
data.
AsnotedinVosetal.(2023),theproblemofsmallsamplesizesis
commoninmachinelearningbasedstressdetectionresearch.
|        |          |           |     |                |         |           |        | 5 Conclusions |     |     |     |     |     |     |
| ------ | -------- | --------- | --- | -------------- | ------- | --------- | ------ | ------------- | --- | --- | --- | --- | --- | --- |
| The    | critique | extends   | to  | this research. |         | Moreover, |        | the           |     |     |     |     |     |     |
| sample | analyzed | comprised |     | young and      | healthy |           | people | and           |     |     |     |     |     |     |
the measurement setup was too heavy to incorporate in real-life A set of physiological signals was successfully used to
|                |          |     |                   |     |        |               |     | distinguish | two stress conditions |     | from | each | other and | from a |
| -------------- | -------- | --- | ----------------- | --- | ------ | ------------- | --- | ----------- | --------------------- | --- | ---- | ---- | --------- | ------ |
| field studies. | However, |     | as an explorative |     | study, | a homogeneous |     |             |                       |     |      |      |           |        |
samplehelpsdiminishtheeffectsofdifferentconfoundingfactors, baselinecondition,bothusingamixedmodelanalysisandapplying
|           |            |      |              |         |         |              |           | ML methods. | Mixed model      | analysis  |        | found | that physiological |       |
| --------- | ---------- | ---- | ------------ | ------- | ------- | ------------ | --------- | ----------- | ---------------- | --------- | ------ | ----- | ------------------ | ----- |
| and the   | main goals | were | to determine |         | whether | the          | reactions | in          |                  |           |        |       |                    |       |
|           |            |      |              |         |         |              |           | responses   | to the different | stressors | varied | and   | ML models          | could |
| ECG, EDA, | EOG,       | and  | BB deviated  | between |         | the baseline |           | and         |                  |           |        |       |                    |       |
stresstypesandwhetheraMLmodelcoulddetectthestresstypes classify the stressor tasks and baseline with decent performance.
|                |     |         |          |              |     |          |         | The two | analysis methods | agreed | well | on the | importance | and |
| -------------- | --- | ------- | -------- | ------------ | --- | -------- | ------- | ------- | ---------------- | ------ | ---- | ------ | ---------- | --- |
| from baseline. | The | results | indicate | sufficiently |     | positive | outcome |         |                  |        |      |        |            |     |
to justify future studies with a larger and more diverse sample, direction of the effect of various physiological features, and
|                |      |         |          |     |          |        |      | these findings | were in line | with | the existing |     | literature | on stress |
| -------------- | ---- | ------- | -------- | --- | -------- | ------ | ---- | -------------- | ------------ | ---- | ------------ | --- | ---------- | --------- |
| or potentially | with | several | datasets | to  | increase | sample | size | and            |              |      |              |     |            |           |
psychophysiology.ThecontributionoffeaturesreflectingECGand
facilitatecross-datasetcomparisons.Asthefeaturesemployedfor
classification can also be extracted from light-weight wearable EOGoutweighedtheimpactofEDAandbrainbeat(EEG).
InstresstypeclassificationusingML,signalwindowing,feature
| devices, | semi-constrained |     | and | even real-life | studies |     | with several |     |     |     |     |     |     |     |
| -------- | ---------------- | --- | --- | -------------- | ------- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- |
typesorlevelsofstressandmoredynamicstatechangesareviable. selection, classifier choice, and hyperparameter optimization
|          |            |       |             |         |         |         |              | attenuated | in favor of the       | choice | of the | biosignals | and computed   |     |
| -------- | ---------- | ----- | ----------- | ------- | ------- | ------- | ------------ | ---------- | --------------------- | ------ | ------ | ---------- | -------------- | --- |
| The      | dynamicity | posed | a challenge |         | already | in this | study,       | as         |                       |        |        |            |                |     |
|          |            |       |             |         |         |         |              | features.  | The work demonstrated |        | that   | stress     | type detection | was |
| the MAST | protocol   | lacks | rest        | periods | between | the     | two stressor |            |                       |        |        |            |                |     |
tasks. This likely caused some physiological leakage when the feasibleusingmeasurementsthatcanbeimplementedonwearable
|     |     |     |     |     |     |     |     | devices. | The best accuracy | was | achieved | using | a multimodal |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ----------------- | --- | -------- | ----- | ------------ | --- |
taskchanged,affectingclassificationperformance.Asrestingand
recovering after each stressor is impossible in real-life, detection set of biosignals and features. Subsequently, the limited input
informationcouldnotbecompensatedbychoicesmadeinthedata
| methodologies |     | must be | able to | handle | such | complication, |     | and |     |     |     |     |     |     |
| ------------- | --- | ------- | ------- | ------ | ---- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
analysis.
futurestudiesshouldwithseveralstresstypeswouldbenefitfrom
acloseinspectionoftheamountofleakageanditsimplicationsto As the first investigation to the divergent physiological
|     |     |     |     |     |     |     |     | reactions | within the MAST, | the | study | provides | a basis | for near |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ---------------- | --- | ----- | -------- | ------- | -------- |
classification.
In the current study, missing data exhibited mainly in EOG real-time acute stress type detection with dynamic state changes.
|          |            |      |     |       |        |           |     | However, | larger cross-dataset |     | comparisons |     | are needed | before |
| -------- | ---------- | ---- | --- | ----- | ------ | --------- | --- | -------- | -------------------- | --- | ----------- | --- | ---------- | ------ |
| features | in windows | with | few | or no | blinks | conducted | and | in       |                      |     |             |     |            |        |
applyingitinreal-lifeusecases.
| windows   | with    | too few   | or too  | small | saccades, | or  | too noisy   |     |     |     |     |     |     |     |
| --------- | ------- | --------- | ------- | ----- | --------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
| signal to | extract | saccades. | Windows | with  | missing   |     | values were |     |     |     |     |     |     |     |
dropped after feature fusion to allow the models to benefit from Data availability statement
| all available | data. | This       | choice, | however, | caused | some    | variation |     |     |     |     |     |     |     |
| ------------- | ----- | ---------- | ------- | -------- | ------ | ------- | --------- | --- | --- | --- | --- | --- | --- | --- |
| in the number |       | of samples | per     | feature  | set    | at each | window    |     |     |     |     |     |     |     |
Thedatasetanalyzedinthestudycannotbemadeavailabledue
| length, displayed |     | in Table2. | Dropping |     | the values | before | feature |     |     |     |     |     |     |     |
| ----------------- | --- | ---------- | -------- | --- | ---------- | ------ | ------- | --- | --- | --- | --- | --- | --- | --- |
toethicalreasonsaspermissionwasnotobtainedfromthestudy
| fusion improved |     | classification |     | performance | on  | average | by 0.6%, |     |     |     |     |     |     |     |
| --------------- | --- | -------------- | --- | ----------- | --- | ------- | -------- | --- | --- | --- | --- | --- | --- | --- |
participants.
| so the effect      | of     | missing   | data            | handling | was rather   |            | small. Since |        |           |     |     |     |     |     |
| ------------------ | ------ | --------- | --------------- | -------- | ------------ | ---------- | ------------ | ------ | --------- | --- | --- | --- | --- | --- |
| missing            | values | are bound | to occur        | either   | randomly     |            | due to       | e.g.,  |           |     |     |     |     |     |
|                    |        |           |                 |          |              |            |              | Ethics | statement |     |     |     |     |     |
| sensor malfunction |        | or        | systematically  |          | due to       | not making |              | any    |           |     |     |     |     |     |
| blinks, handling   |        | these     | cases carefully |          | is important |            | for robust   |        |           |     |     |     |     |     |
stress detection in the field. Potential future solutions include The studies involving humans were approved by
imputation and maximum likelihood methods, or the detection Ethics Committee in the Humanities and Social and
| FrontiersinNeuroergonomics |     |     |     |     |     |     |     | 13  |     |     |     |     | frontiersin.org |     |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

| Tervonenetal. |          |     |        |            |     |           |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |     |     |
| ------------- | -------- | --- | ------ | ---------- | --- | --------- | --- | --- | --- | --- | -------------------------- | --- | --- | --- |
| Behavioural   | Sciences |     | of the | University | of  | Helsinki. | The |     |     |     |                            |     |     |     |
andtheAcademyofFinlandgrantnumbers313401,334092,and
| studies     | were  | conducted     | in       | accordance    | with | the          | local | 351282.  |             |     |     |     |     |     |
| ----------- | ----- | ------------- | -------- | ------------- | ---- | ------------ | ----- | -------- | ----------- | --- | --- | --- | --- | --- |
| legislation | and   | institutional |          | requirements. | The  | participants |       |          |             |     |     |     |     |     |
| provided    | their | written       | informed | consent       | to   | participate  | in    |          |             |     |     |     |     |     |
|             |       |               |          |               |      |              |       | Conflict | of interest |     |     |     |     |     |
thisstudy.
JT,JN,JM,andKPwereemployedbyVTTTechnicalResearch
| Author | contributions |     |     |     |     |     |     |     |     |     |     |     |     |     |
| ------ | ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
CentreofFinlandLtd.
| JT:          | Conceptualization, |     |             | Formal         | analysis, | Investigation, |     |             |      |     |     |     |     |     |
| ------------ | ------------------ | --- | ----------- | -------------- | --------- | -------------- | --- | ----------- | ---- | --- | --- | --- | --- | --- |
| Methodology, | Software,          |     | Validation, | Visualization, |           | Writing        |     | –           |      |     |     |     |     |     |
|              |                    |     |             |                |           |                |     | Publisher’s | note |     |     |     |     |     |
originaldraft,Writing–review&editing.JN:Conceptualization,
| Data curation, |            | Funding | acquisition, | Investigation, |        | Resources, |     |             |                    |           |         |            |          |            |
| -------------- | ---------- | ------- | ------------ | -------------- | ------ | ---------- | --- | ----------- | ------------------ | --------- | ------- | ---------- | -------- | ---------- |
|                |            |         |              |                |        |            |     | All claims  | expressed          | in this   | article | are solely | those    | of the     |
| Writing        | – original | draft,  | Writing      | –              | review | & editing. | JM: |             |                    |           |         |            |          |            |
|                |            |         |              |                |        |            |     | authors and | do not necessarily | represent |         | those      | of their | affiliated |
Conceptualization,Projectadministration,Resources,Supervision,
|           |          |              |          |                        |     |              |        | organizations, | or those    | of the publisher, |              | the | editors          | and the |
| --------- | -------- | ------------ | -------- | ---------------------- | --- | ------------ | ------ | -------------- | ----------- | ----------------- | ------------ | --- | ---------------- | ------- |
| Writing   | – review | &            | editing. | KP: Conceptualization, |     |              | Formal |                |             |                   |              |     |                  |         |
|           |          |              |          |                        |     |              |        | reviewers.     | Any product | that may          | be evaluated |     | in this article, | or      |
| analysis, | Funding  | acquisition, |          | Investigation,         |     | Methodology, |        |                |             |                   |              |     |                  |         |
claimthatmaybemadebyitsmanufacturer,isnotguaranteedor
| Software, | Validation, |     | Visualization, | Writing | –   | original | draft, |     |     |     |     |     |     |     |
| --------- | ----------- | --- | -------------- | ------- | --- | -------- | ------ | --- | --- | --- | --- | --- | --- | --- |
endorsedbythepublisher.
Writing–review&editing.
| Funding |     |     |     |     |     |     |     | Supplementary |     | material |     |     |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | -------- | --- | --- | --- | --- |
The author(s) declare financial support was received for The Supplementary Material for this article can be found
the research, authorship, and/or publication of this article. This online at: https://www.frontiersin.org/articles/10.3389/fnrgo.2023.
1294286/full#supplementary-material
| document | is the | results | of the | research projects |     | funded | by VTT |     |     |     |     |     |     |     |
| -------- | ------ | ------- | ------ | ----------------- | --- | ------ | ------ | --- | --- | --- | --- | --- | --- | --- |
References
Aristizabal, S., Byun, K., Wood, N., Mullan, A. F., Porter, P. M., Campanella, Daniels,J.,andGeorgiou,P.(2019).“Adata-drivendetectionsystemforpredicting
C., et al. (2021). The feasibility of wearable and self-report stress detection stresslevelsfromautonomicsignals,”in2019IEEEBiomedicalCircuitsandSystems
measures in a semi-controlled lab environment. IEEE Access 9, 102053–102068. Conference(BioCAS)(Nara),1–4.
doi:10.1109/ACCESS.2021.3097038
Dickerson,S.S.,andKemeny,M.E.(2004).Acutestressorsandcortisolresponses:a
theoreticalintegrationandsynthesisoflaboratoryresearch.Psychol.Bull.130,355–391.
| Barredo | Arrieta, | A., Díaz-Rodríguez, |     | N., Del | Ser, J., | Bennetot, | A., Tabik, |     |     |     |     |     |     |     |
| ------- | -------- | ------------------- | --- | ------- | -------- | --------- | ---------- | --- | --- | --- | --- | --- | --- | --- |
S., Barbado, A., et al. (2020). Explainable artificial intelligence (xai): concepts, doi:10.1037/0033-2909.130.3.355
taxonomies,opportunitiesandchallengestowardresponsibleai.Inf.Fusion58,82–115. Feng,M.,Fang,T.,He,C.,Li,M.,andLiu,J.(2023).Affectandstressdetection
doi:10.1016/j.inffus.2019.12.012
basedonfeaturefusionoflstmand1dcnn.Comp.MethodsBiomech.Biomed.Eng.0,
1–9.doi:10.1080/10255842.2023.2188988
Bates,D.,Mächler,M.,Bolker,B.,andWalker,S.(2015).Fittinglinearmixed-effects
modelsusinglme4.J.Statist.Softw.67,1–48.doi:10.18637/jss.v067.i01 Ghiasi, S., Greco, A., Barbieri, R., Scilingo, E. P., and Valenza, G. (2020).
|          |     |                |     |            |              |     |         | Assessing autonomic | function     | from electrodermal |     | activity   | and heart | rate      |
| -------- | --- | -------------- | --- | ---------- | ------------ | --- | ------- | ------------------- | ------------ | ------------------ | --- | ---------- | --------- | --------- |
| Benedek, | M., | and Kaernbach, |     | C. (2010). | A continuous |     | measure |                     |              |                    |     |            |           |           |
|          |     |                |     |            |              |     |         | variability during  | cold-pressor | test and emotional |     | challenge. | Sci. Rep. | 10, 5406. |
of phasic electrodermal activity. J. Neurosci. Methods 190, 80–91. doi:10.1038/s41598-020-62225-2
doi:10.1016/j.jneumeth.2010.04.028
|     |     |     |     |     |     |     |     | Giannakakis, | G., Grigoriadis, | D., Giannakaki, |     | K., Simantiraki, | O., | Roniotis, |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ---------------- | --------------- | --- | ---------------- | --- | --------- |
Bentivoglio, A. R., Bressman, S. B., Cassetta, E., Carretta, D., Tonali, P., and A., and Tsiknakis, M. (2022). Review on psychological stress detection using
Albanese,A.(1997).Analysisofblinkratepatternsinnormalsubjects.Mov.Disord.
biosignals.IEEETransact.Affect.Comp.13,440–460.doi:10.1109/TAFFC.2019.29
12,1028–1034.doi:10.1002/mds.870120629
27337
Bergstra,J.,Yamins,D.,andCox,D.(2013).“Makingascienceofmodelsearch:
|     |     |     |     |     |     |     |     | Gjoreski, | M., Luštrek, | M., Gams, M., | and Gjoreski, | H.  | (2017). Monitoring |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------------ | ------------- | ------------- | --- | ------------------ | --- |
hyperparameteroptimizationinhundredsofdimensionsforvisionarchitectures,”in
Proceedingsofthe30thInternationalConferenceonMachineLearning,Volume28of stress with a wrist device using context. J. Biomed. Inform. 73, 159–170.
doi:10.1016/j.jbi.2017.08.006
ProceedingsofMachineLearningResearch,edsS.Dasgupta,andD.McAllester(Atlanta,
GA:PMLR),115–123. Gjoreski,M.,Kolenik,T.,Knez,T.,Luštrek,M.,Gams,M.,Gjoreski,H.,etal.(2020).
Datasetsforcognitiveloadinferenceusingwearablesensorsandpsychologicaltraits.
Chalabianloo,N.,Can,Y.S.,Umair,M.,Sas,C.,andErsoy,C.(2022).Application
Appl.Sci.10.doi:10.3390/app10113843
| level performance | evaluation |     | of wearable | devices | for stress | classification | with |     |     |     |     |     |     |     |
| ----------------- | ---------- | --- | ----------- | ------- | ---------- | -------------- | ---- | --- | --- | --- | --- | --- | --- | --- |
explainableai.PervasiveMob.Comput.87,101703.doi:10.1016/j.pmcj.2022.101703 Hastie, T., Tibshirani, R., and Friedman, J. (2009). The Elements of Statistical
Learning.SpringerSeriesinStatistics,2ndEdm.NewYork,NY:Springer.
Champseix,R.(2018).HeartRateVariabilityAnalysis.Availableonlineat:https://
github.com/Aura-healthcare/hrv-analysis(accessedSeptember14,2023). Hellhammer,J.,andSchubert,M.(2012).Thephysiologicalresponsetotriersocial
stresstestrelatestosubjectivemeasuresofstressduringbutnotbeforeorafterthetest.
Chang,P.F.,Arendt-Nielsen,L.,andChen,A.C.(2002).Dynamicchangesand Psychoneuroendocrinology37,119–124.doi:10.1016/j.psyneuen.2011.05.012
spatialcorrelationofeegactivitiesduringcoldpressortestinman.BrainRes.Bull.57,
667–675.doi:10.1016/S0361-9230(01)00763-8 Henderson, J. M., Shinkareva, S. V., Wang, J., Luke, S. G., and Olejarczyk, J.
|           |     |          |     |                    |     |            |     | (2013). Predicting | cognitive | state from eye | movements. | PLoS | ONE 8, | e0064937. |
| --------- | --- | -------- | --- | ------------------ | --- | ---------- | --- | ------------------ | --------- | -------------- | ---------- | ---- | ------ | --------- |
| Chouchou, | F., | Perchet, | C., | and Garcia-Larrea, |     | L. (2021). | Eeg |                    |           |                |            |      |        |           |
doi:10.1371/journal.pone.0064937
| changes | reflecting | pain: | is alpha | suppression | better | than | gamma |     |     |     |     |     |     |     |
| ------- | ---------- | ----- | -------- | ----------- | ------ | ---- | ----- | --- | --- | --- | --- | --- | --- | --- |
enhancement? Neurophysiol. Clin. 51, 209–218. doi: 10.1016/j.neucli.2021.03 Holm,A.,Lukander,K.,Korpela,J.,Sallinen,M.,andMüller,K.M.I.(2009).
.001 EstimatingbrainloadfromtheEEG.Sci.WorldJ.9,639–651.doi:10.1100/tsw.2009.83
| FrontiersinNeuroergonomics |     |     |     |     |     |     |     | 14  |     |     |     |     | frontiersin.org |     |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |

| Tervonenetal. |     |     |     |     |     |     |     |     |     |     | 10.3389/fnrgo.2023.1294286 |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- |
Kirschbaum,C.,Pirke,K.M.,andHellhammer,D.H.(1993).The“triersocialstress Schmidt, P., Reiss, A., Dürichen, R., and Laerhoven, K. V. (2019).
test"—atoolforinvestigatingpsychobiologicalstressresponsesinalaboratorysetting. Wearable-based affect recognition–a review. Sensors 19. doi: 10.3390/s1919
| Neuropsychobiology28,76–81.doi:10.1159/000119004 |     |     |     |     |     | 4079 |     |     |     |     |     |     |     |
| ------------------------------------------------ | --- | --- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
Lee,V.R.(2021).Youthengagementduringmaking:usingelectrodermalactivity Schmidt, P., Reiss, A., Duerichen, R., Marberger, C., and Van Laerhoven, K.
dataandfirst-personvideotogenerateevidence-basedconjectures.Inf.Learn.Sci.122, (2018). “Introducing wesad, a multimodal dataset for wearable stress and affect
270–291.doi:10.1108/ILS-08-2020-0178 detection,”inProceedingsofthe20thACMInternationalConferenceonMultimodal
|     |     |     |     |     |     | Interaction, | ICMI ’18 | (New | York, NY: | Association | for Computing |     | Machinery), |
| --- | --- | --- | --- | --- | --- | ------------ | -------- | ---- | --------- | ----------- | ------------- | --- | ----------- |
Loggia,M.L.,Juneau,M.,andBushnell,C.M.(2011).Autonomicresponsestoheat
| pain:heartrate,skinconductance,andtheirrelationtoverbalratingsandstimulus |     |     |     |     |     | 400–408. |     |     |     |     |     |     |     |
| ------------------------------------------------------------------------- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- | --- | --- | --- |
intensity.Pain152,592–598.doi:10.1016/j.pain.2010.11.032 Schuri, U., and von Cramon, D. (1981). Heart rate and blink rate
Luke,S.G.(2017).Evaluatingsignificanceinlinearmixed-effectsmodelsinr.Behav. responses during mental arithmetic with and without continuous verbalization
|     |     |     |     |     |     | of results. | Psychophysiology |     | 18, 650–653. |     | doi: 10.1111/j.1469-8986.1981. |     |     |
| --- | --- | --- | --- | --- | --- | ----------- | ---------------- | --- | ------------ | --- | ------------------------------ | --- | --- |
Res.Methods49,1494–1502.doi:10.3758/s13428-016-0809-y
tb01839.x
Lundberg,S.M.,andLee,S.-I.(2017).“Aunifiedapproachtointerpretingmodel
|     |     |     |     |     |     | Sedghamiz, | H.  | (2014). | Complete | Pan-Tompkins |     | Implementation | ECG |
| --- | --- | --- | --- | --- | --- | ---------- | --- | ------- | -------- | ------------ | --- | -------------- | --- |
predictions,”inProceedingsofthe31stInternationalConferenceonNeuralInformation
|                                                                       |               |            |             |               |          | QRS Detector. | MATLAB        |     | Central, | Mathworks. | doi:       | 10.13140/RG.2.2.14202. |         |
| --------------------------------------------------------------------- | ------------- | ---------- | ----------- | ------------- | -------- | ------------- | ------------- | --- | -------- | ---------- | ---------- | ---------------------- | ------- |
| ProcessingSystems,NIPS’17(RedHook,NY:CurranAssociatesInc.),4768–4777. |               |            |             |               |          | 59841         |               |     |          |            |            |                        |         |
| Maffei, A.,                                                           | and Angrilli, | A. (2019). | Spontaneous | blink rate as | an index | of            |               |     |          |            |            |                        |         |
|                                                                       |               |            |             |               |          | Sendowski,    | I., Savourey, | G., | Besnard, | Y., and    | Bittel, J. | (1997). Cold           | induced |
attention and emotion during film clips viewing. Physiol. Behav. 204, 256–263. vasodilatationandcardiovascularresponsesinhumansduringcoldwaterimmersion
doi:10.1016/j.physbeh.2019.02.037
|                                                                         |     |     |     |     |     | of various                | upper limb | areas. | Eur. J. Appl. | Physiol. | Occup. | Physiol. 75, | 471–477. |
| ----------------------------------------------------------------------- | --- | --- | --- | --- | --- | ------------------------- | ---------- | ------ | ------------- | -------- | ------ | ------------ | -------- |
| Marshall,S.P.(2007).Identifyingcognitivestatefromeyemetrics.Aviat.Space |     |     |     |     |     | doi:10.1007/s004210050191 |            |        |               |          |        |              |          |
Environ.Med.78(5Suppl.):B165?B175.
|     |     |     |     |     |     | Sharpley, | C. F. (2009). | Neurobiological |     | pathways | between | chronic | stress and |
| --- | --- | --- | --- | --- | --- | --------- | ------------- | --------------- | --- | -------- | ------- | ------- | ---------- |
McGinley,J.J.,andFriedman,B.H.(2015).Autonomicresponsestolateralizedcold depression: dysregulated adaptive mechanisms? Clin. Med. Insights Psychiatry 2.
pressorandfacialcoolingtasks.Psychophysiology52,416–424.doi:10.1111/psyp.12332 doi:10.4137/CMPsy.S3658
Mishra, V., Sen, S., Chen, G., Hao, T., Rogers, J., Chen, C.-H., et al. (2020b). Shilton,A.L.,Laycock,R.,andCrewther,S.G.(2017).Themaastrichtacutestress
“Evaluatingthereproducibilityofphysiologicalstressdetectionmodels,”inProc.ACM test(mast):Physiologicalandsubjectiveresponsesinanticipation,andpost-stress.
Interact.Mob.WearableUbiquitousTechnol.(NewYork,NY). Front.Psychol.8,567.doi:10.3389/fpsyg.2017.00567
Mishra,V.,Pope,G.,Lord,S.,Lewia,S.,Lowens, B.,Caine,K.,etal.(2020a). Siirtola,P.(2019).“Continuousstressdetectionusingthesensorsofcommercial
Continuousdetectionofphysiologicalstresswithcommodityhardware.ACMTrans. smartwatch,”inAdjunctProceedingsofthe2019ACMInternationalJointConferenceon
Comput.Healthcare1,1–30.doi:10.1145/3361562 PervasiveandUbiquitousComputingandProceedingsofthe2019ACMInternational
|                                                    |         |               |                   |                  |            | Symposium             | on Wearable     | Computers | (New        | York, NY: | Association | for          | Computing |
| -------------------------------------------------- | ------- | ------------- | ----------------- | ---------------- | ---------- | --------------------- | --------------- | --------- | ----------- | --------- | ----------- | ------------ | --------- |
| Molnar, C.                                         | (2022). | Interpretable | Machine Learning. | 2 Edn. Available | online at: |                       |                 |           |             |           |             |              |           |
| https://christophm.github.io/interpretable-ml-book |         |               |                   |                  |            | Machinery),1198–1201. |                 |           |             |           |             |              |           |
|                                                    |         |               |                   |                  |            | Smeets,               | T., Cornelisse, | S.,       | Quaedflieg, | C. W.,    | Meyer,      | T., Jelicic, | M., and   |
Mourot, L., Bouhaddi, M., and Regnard, J. (2008). Effects of the cold pressor Merckelbach,H.(2012).Introducingthemaastrichtacutestresstest(mast):aquick
| test on cardiac | autonomic | control | in normal subjects. | Physiol. Res. | 58, 83–91. |                  |          |     |               |           |     |                |        |
| --------------- | --------- | ------- | ------------------- | ------------- | ---------- | ---------------- | -------- | --- | ------------- | --------- | --- | -------------- | ------ |
|                 |           |         |                     |               |            | and non-invasive | approach | to  | elicit robust | autonomic | and | glucocorticoid | stress |
doi:10.33549/physiolres.931360
|                                                                         |     |     |     |     |     | responses. | Psychoneuroendocrinology |     | 37, | 1998–2008. | doi: 10.1016/j.psyneuen.2012. |     |     |
| ----------------------------------------------------------------------- | --- | --- | --- | --- | --- | ---------- | ------------------------ | --- | --- | ---------- | ----------------------------- | --- | --- |
| Mozos,O.M.,Sandulescu,V.,Andrews,S.,Ellis,D.,Bellotto,N.,Dobrescu,R.,et |     |     |     |     |     | 04.012     |                          |     |     |            |                               |     |     |
al.(2017).Stressdetectionusingwearablephysiologicalandsociometricsensors.Int.J.
NeuralSyst.27,1650041.doi:10.1142/S0129065716500416 Storm, H. (2008). Changes in skin conductance as a tool to monitor
|     |     |     |     |     |     | nociceptive | stimulation | and | pain. | Curr. Opin. | Anesthesiol. | 21, | 796–804. |
| --- | --- | --- | --- | --- | --- | ----------- | ----------- | --- | ----- | ----------- | ------------ | --- | -------- |
Paparella,G.,DiStefano,G.,Fasolino,A.,DiPietro,G.,Colella,D.,Truini,A.,et doi:10.1097/ACO.0b013e3283183fe4
al.(2020).Painfulstimulationincreasesspontaneousblinkrateinhealthysubjects.Sci.
Rep.10,20014.doi:10.1038/s41598-020-76804-w Sun,Q.,andPfahringer,B.(2013).Pairwisemeta-rulesforbettermeta-learning-
basedalgorithmranking.Mach.Learn.93,141–161.doi:10.1007/s10994-013-5387-y
| Pettersson, | K., Tervonen, | J., Närväinen, | J., Henttonen, | P., Määttänen, | I., and |     |     |     |     |     |     |     |     |
| ----------- | ------------- | -------------- | -------------- | -------------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
Mäntyjärvi,J.(2020).“Selectingfeaturesetsandcomparingclassificationmethods Tervonen,J.,Närväinen,J.,Mäntyjärvi,J.,andPettersson,K.(2021b).“Insearchof
for cognitive state estimation,” in 2020 IEEE 20th International Conference on harmfulstress,”inAdjunctProceedingsofthe2021ACMInternationalJointConference
onPervasiveandUbiquitousComputingandProceedingsofthe2021ACMInternational
BioinformaticsandBioengineering(BIBE)(Cincinnati,OH),683–690.
|                    |                 |               |               |                      |         | Symposium           | on Wearable | Computers | (New | York, NY: | Association | for | Computing |
| ------------------ | --------------- | ------------- | ------------- | -------------------- | ------- | ------------------- | ----------- | --------- | ---- | --------- | ----------- | --- | --------- |
| Pettersson,        | K., Jagadeesan, | S., Lukander, | K., Henelius, | A., Hæggström,       | E., and | Machinery),215–217. |             |           |      |           |             |     |           |
| Müller, K. (2013). | Algorithm       | for automatic | analysis of   | electro-oculographic | data.   |                     |             |           |      |           |             |     |           |
Biomed.Eng.Online12.doi:10.1186/1475-925X-12-110 Tervonen,J.,Pettersson,K.,andMäntyjärvi,J.(2021a).Ultra-shortwindowlength
andfeatureimportanceanalysisforcognitiveloaddetectionfromwearablesensors.
Pudil,P.,Novovieova,J.,andKittler,J.(1994).Floatingsearchmethodsinfeature Electronics10.doi:10.3390/electronics10050613
selection.PatternRecognit.Lett.15,365–366.doi:10.1016/0167-8655(94)90127-9
|     |     |     |     |     |     | Tran, N., | Schneider, | J.-G., | Weber, | I., and Qin, | A. (2020). | Hyper-parameter |     |
| --- | --- | --- | --- | --- | --- | --------- | ---------- | ------ | ------ | ------------ | ---------- | --------------- | --- |
Quaedflieg,C.,Meyer,T.,vanRuitenbeek,P.,andSmeets,T.(2017).Examining optimization in classification: to-do or not-to-do. Pattern Recognit. 103, 107245.
habituationandsensitizationacrossrepetitivelaboratorystressinductionsusingthe doi:10.1016/j.patcog.2020.107245
MAST.Psychoneuroendocrinology77,175–181.doi:10.1016/j.psyneuen.2016.12.009
|     |     |     |     |     |     | Vanhollebeke, | G., | De Smet, | S., De Raedt, | R., Baeken, | C., | van Mierlo, | P., and |
| --- | --- | --- | --- | --- | --- | ------------- | --- | -------- | ------------- | ----------- | --- | ----------- | ------- |
Ranti,C.,Jones,W.,Klin,A.,andShultz,S.(2020).Blinkratepatternsprovide Vanderhasselt,M.-A.(2022).Theneuralcorrelatesofpsychosocialstress:asystematic
areliablemeasureofindividualengagementwithscenecontent.Sci.Rep.10,8267. reviewandmeta-analysisofspectralanalysiseegstudies.Neurobiol.Stress18,100452.
doi:10.1038/s41598-020-64999-x doi:10.1016/j.ynstr.2022.100452
Schleicher,R.,Galley,N.,Briest,S.,andGalley,L.(2008).Blinksandsaccadesas Vos, G., Trinh, K., Sarnyai, Z., and Rahimi Azghadi, M. (2023). Generalizable
indicatorsoffatigueinsleepinesswarnings:lookingtired?Ergonomics51,982–1010. machinelearningforstressmonitoringfromwearabledevices:asystematicliterature
doi:10.1080/00140130701817062 review.Int.J.Med.Inform.173,105026.doi:10.1016/j.ijmedinf.2023.105026
| FrontiersinNeuroergonomics |     |     |     |     |     | 15  |     |     |     |     |     | frontiersin.org |     |
| -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- |
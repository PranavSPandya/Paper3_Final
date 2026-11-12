ORIGINALRESEARCH
published:24September2018
doi:10.3389/fnhum.2018.00338
Using Smartbands, Pupillometry and
Body Motion to Detect Discomfort in
Automated Driving
MatthiasBeggiato*,FranziskaHartwichandJosefKrems
DepartmentofPsychology,CognitiveandEngineeringPsychology,ChemnitzUniversityofTechnology,Chemnitz,Germany
As technological advances lead to rapid progress in driving automation, human-
machine interaction (HMI) issues such as comfort in automated driving gain increasing
attention. The research project KomfoPilot at Chemnitz University of Technology
aims to assess discomfort in automated driving using physiological parameters from
commerciallyavailablesmartbands,pupillometryandbodymotion.Detecteddiscomfort
should subsequently be used to adapt driving parameters as well as information
presentation and prevent potentially safety-critical take-over situations. In an empirical
driving simulator study, 40 participants from 25 years to 84 years old experienced
two highly automated drives with three potentially critical and discomfort-inducing
approaching situations in each trip. The ego car drove in a highly automated mode
at100km/handapproachedatruckdrivingaheadwithaconstantspeedof80km/h.
Automatedbrakingstartedverylateatadistanceof9m,reachingaminimumof4.2m.
Perceiveddiscomfortwasassessedcontinuouslyusingahandsetcontrol.Physiological
Editedby:
parameters were measured by the smartband Microsoft Band 2 and included heart
KarelBrookhuis,
UniversityofGroningen,Netherlands rate (HR), heart rate variability (HRV) and skin conductance level (SCL). Eye tracking
Reviewedby: glasses recorded pupil diameter and eye blink frequency; body motion was captured
DickDeWaard,
by a motion tracking system and a seat pressure mat. Trends of all parameters were
UniversityofGroningen,Netherlands
BenjaminCowley, analyzed 10 s before, during and 10 s after reported discomfort to check for overall
UniversityofHelsinki,Finland parameter relevance, direction and strength of effects; timings of increase/decrease;
*Correspondence: variability as well as filtering, standardization and artifact removal strategies to increase
MatthiasBeggiato
matthias.beggiato@psychologie.tu- the signal-to-noise ratio. Results showed a reduced eye blink rate during discomfort
chemnitz.de as well as pupil dilation, also after correcting for ambient light influence. Contrary
to expectations, HR decreased significantly during discomfort periods, whereas HRV
Received:30April2018
Accepted:07August2018 diminished as expected. No effects could be observed for SCL. Body motion showed
Published:24September2018
theexpectedpushbackmovementduringthecloseapproachsituation.Overall,besides
Citation:
SCL,allotherparametersshowedchangesassociatedwithdiscomfortindicatedbythe
BeggiatoM,HartwichFandKremsJ
(2018)UsingSmartbands, handset control. The results serve as a basis for designing and configuring a real-time
PupillometryandBodyMotionto discomfort detection algorithm that will be implemented in the driving simulator and
DetectDiscomfortinAutomated
Driving. validatedinsubsequentstudies.
Front.Hum.Neurosci.12:338.
doi:10.3389/fnhum.2018.00338 Keywords:discomfort,automateddriving,smartband,pupillometry,psychophysiology,motiontracking
FrontiersinHumanNeuroscience|www.frontiersin.org 1 September2018|Volume12|Article338

Beggiatoetal. DiscomfortDetectioninAutomatedDriving
INTRODUCTION pupil diameter, eye blink frequency, heart rate (HR), heart
rate variability (HRV), electrodermal activity (EDA) and
Automateddrivingisexpectedtobringseveralmobilitybenefits body motion with regard to discomfort during automated
such as improved traffic safety, reduced congestions and driving in a driving simulator. Driving simulators offer an
emissions, social inclusion, accessibility and more comfort optimalenvironmentforcreatingstandardizedsituationsunder
(ERTRAC, 2017). As technological advances have enabled experimental control and applying sensors for measuring
the rapid progression in driving automation, human-machine physiological parameters (Brookhuis and de Waard, 2011),
interaction(HMI)issuesgainmoreattentionandareconsidered although with limited external validity. The presented analyses
akeyquestionforbroadpublicacceptance(BanksandStanton, aimtoprovideinformationaboutthepotentialofeachparameter
2016;Rieneretal.,2016;ERTRAC,2017).OnecentralHMIissue fordetectingdiscomfortinanapproachingautomatedsituation,
involves the question of how comfortable automated driving such as overall relevance, variability, direction and strength
can be implemented to ensure a positive driving experience of effects, timing such as increase and decrease before and
(Elbanhawi et al., 2015; ERTRAC, 2017; Bellem et al., 2018). after discomfort as well as filtering and artifact removal
Havingapositivedrivingexperienceisamainfactorfordeciding strategies.
topurchaseanduseavehicleorin-vehiclesystem(Engelbrecht, The use of these physiological parameters to infer mental
2013). In automated driving, discomfort could additionally states has a long research tradition. Despite results that are
lead to potential safety-critical situations, for example, due oftencontradictory,themainfindingsfortheseparametersare
to (non-necessary) takeover with all associated risks such as summarizedsubsequentlyandhypothesesregardingdiscomfort
reduced situation awareness (Hergeth et al., 2017). As the are derived. Pupil diameter has been studied largely as an
humanroleinautomateddrivingchangesfromactivedriverto indicator for mental effort, cognitive workload, stress, fatigue,
passenger,newandadditionaldeterminantsofdrivingcomfort information processing, affective processing and attention
arediscussed,suchasmotionsickness,apparentsafety,trustin (Andreassi, 2000; Cowley et al., 2016). One of the major
thesystem,feelingsofcontrol,familiarityofdrivingmaneuvers, challenges in interpreting pupil size changes out of controlled
andinformationaboutsystemstatesandactions(Beggiatoetal., lab studies is the heavy dependance on ambient light (Palinko
2015; Elbanhawi et al., 2015; Bellem et al., 2016). There is no andKun,2012).Despitetheseproblemsinseparatingtheeffects
agreed-upondefinitionforcomfortinthescientificcommunity of ambient factors and mental states, a central finding is that
(Hartwich et al., 2018); however, existing comfort definitions pupil diameter increases with task difficulty, mental workload,
share some central assumptions: comfort (a) is a subjective emotionality of stimuli, and information-processing demands
construct and, therefore, differs between individuals; (b) is (Andreassi, 2000; Backs and Boucsein, 2000; Cowley et al.,
affectedbyphysical,physiological,andpsychologicalfactors;and 2016). Thus, an increase in pupil diameter is expected during
(c) results from interaction with the environment (de Looze uncomfortablesituations.Eyeblinkrateisconsideredasensitive
etal.,2003).Thus,comfortisherebyunderstoodasasubjective, indicator for mental workload, mood states, fatigue and task
pleasant state of relaxation expressed through confidence and demands (Andreassi, 2000; Cowley et al., 2016). A decrease in
apparently safe vehicle operation (Constantin et al., 2014), blink rate in complex situations requiring visual attention has
‘‘whichisachievedbytheremovalorabsenceofuneasinessand been found for car driving in complex situations as well as for
distress’’(Bellemetal.,2016,p.45). fighterpilots(BacksandBoucsein,2000).Thus,adecreaseineye
The research project KomfoPilot at Chemnitz University of blinkrateisexpectedduringdiscomfortsituationsinautomated
Technology aims to investigate factors that influence comfort driving,whicharevisuallymonitoredbythedriver.
in automated driving. One objective is to find parameters that The cardiovascular parameters HR and HRV are often used
affect comfort on a general level, for example, situations and indrivingsimulationandon-roaddrivingstudiesasindicators
driving parameters such as speed, longitudinal/lateral distance, of mental effort, stress, workload, and task demands (see the
driving style familiarity, or personal characteristics (Hartwich overview of studies in Backs and Boucsein, 2000; Mulder
et al., 2015, 2018). A second objective is the development et al., 2005; Brookhuis and de Waard, 2011; Mehler et al.,
of an algorithm for real-time discomfort detection to adapt 2012; Ahonen et al., 2016; Schmidt et al., 2016). A common
driving style and information presentation at each moment finding is that with higher invested effort and stress, HR
once discomfort begins. The underlying idea is the metaphor increases and HRV decreases. The discomfort-inducing close
of a vehicle–driver–team that knows each other’s strengths, approach situation investigated in this study could be seen
limitations, and current states, and is able to react accordingly as analogous to stress situations, including the uncertainty
(Klein et al., 2004). The algorithm will be developed by project about the capability of a system to successfully complete a
partners who specialize in data fusion (FusionSystems GmbH task. Thus, an increase in HR and a decrease in HRV during
and Communication Engineering Department at Chemnitz uncomfortablesituationsareexpected.SimilartoHRandHRV,
University of Technology) and should combine data from EDA has a long tradition in psychophysiological research.
different sensors such as in-car sensors (2D and 3D cameras, Commonfindingsincludeanincreaseofskinconductancelevel
motion tracking), physiological sensors (smartband Microsoft (SCL) with higher arousal, alertness, mental effort, workload,
Band 2, eye tracking), vehicle data and environment sensors. emotionalload,stress,andtaskdifficulty(Dawsonetal.,2017).
As a basis for developing the algorithm, the present article However, as EDA is sensitive to a wide variety of stimuli,
reports the results of the psychophysiological parameters it is not a clearly interpretable measure of any particular
FrontiersinHumanNeuroscience|www.frontiersin.org 2 September2018|Volume12|Article338

Beggiatoetal. DiscomfortDetectioninAutomatedDriving
psychological process and must be interpreted by including danger of a potential rear-end collision (Figure 1). A white
the stimulus conditions (Cowley et al., 2016; Dawson et al., truck drove in front of the ego car with a constant speed of
2017). For discomfort, an increase in SCL is expected due 80 km/h, whereas the ego car approached in a fully automated
to a prediction of higher alertness and arousal. The HR, modeat100km/h.Automatedbrakingwasinitializedverylate
HRV,andEDAweremeasuredusingthesmartbandMicrosoft at a distance of 9 m, which resulted in a minimum distance of
(MS) Band 2. The use of a commercially available smartband 4.2mandminimumtimetocontactof1.1s.Aftertheapproach,
was an explicit project goal to estimate the potential and the ego car fell back at a distance of 100 m, and the approach
problems of such a psychophysiological sensor. On the one startedagain.Participantswerenotinformedaboutthesituation
hand, the market for smartbands is growing (Wade, 2017); and were instructed to press the lever of the handset control
thus, smartbands connected to vehicles could be an option for (Figure 2A) according to the extent of perceived discomfort.
assessing psychophysiological parameters inside cars. On the Thus, every participant experienced six approach situations in
other hand, the MS Band 2 has already been used in research total,whichresultedin240situationsforall40participantsand
forassessingmentalworkloadindifferentenvironments(Binsch both sessions. The main reasons for inviting the participants
et al., 2016; Cropley et al., 2017; Reinerman-Jones et al., 2017; twicewereto:(a)obtainahigheroverallnumberofdiscomfort
Schmalfuß et al., 2018), activity recognition in a home setting situations per person; and (b) assess habituation effects within
(Filippoupolitis et al., 2016), and for predicting and regulating subjectsovershortandlongertimeperiods(3minvs.2months).
personalthermalcomfortinbuildings(LaftchievandNikovski, Evaluationofhabituationeffectsresultedinsmalltoalmostno
2016;Lietal.,2017). effects,bothforshort-andlong-termperiods.Thus,allsituations
Body motion during driving has mainly been investigated wereincludedinthesubsequentanalyses.
withregardtoheadmovementsforpredictingdriverintentions
(Pech et al., 2014), hand movements for estimating driver Participants
distraction (Tran and Trivedi, 2009), trapezius muscle tension Atotalof40participants(15females,25males)tookpartinboth
asanindicatorforstress(Morrisetal.,2017),orfacialfeatures sessionsofthestudy.Agesrangedfrom25yearsto84yearswith
for monitoring driver states (Baker et al., 2004). Moreover, the twodistinctagegroups,onefrom25yearsto45years(younger
whole 3D driver posture is considered potentially useful for group,N=21,M=30years,SD=4.3)andtheotherover65years
extractinginformationrelatedtointentions,affectivestates,and (older group, N = 19, M = 72 years, SD = 6.0). All subjects
distraction(TranandTrivedi,2010).However,posturedynamics were required to currently hold a valid driver’s license, and
are strongly related to situations and should, therefore, be noneofthemhadhadpreviousexperienceofhighlyautomated
combinedwithothercontextualinformation(TranandTrivedi, drivinginthedrivingsimulator.Participantswerecompensated
2010). In the specific approach situation with the danger of a with 20 euros for participation. This study was carried out in
potential rear-end collision, a pushback movement is expected accordancewiththerecommendations,regulationsandconsent
thatshouldbereflectedinmotiontrackingandseatpressuremat templatesoftheTUChemnitzethicscommission.Theprotocol
data.Table1providesasummaryoftheexpectedeffectsduring was approved by the TU Chemnitz ethics commission. All
discomfortperiodsforallparameters. subjects gave written informed consent in accordance with the
DeclarationofHelsinki.
MATERIALS AND METHODS Material and Sensors
The study took place in a fixed-base driving simulator (SILAB
Study Design and Route 5.1 Software) with a fully equipped interior, a rear-view
The driving simulator study was composed of two separate mirror, two side mirrors and a 180◦ horizontal field of view.
drivingsessionswithanapproximate2-monthdelayinbetween. Fully automated trips were prerecorded and replayed, while
Everydrivingsessionwascomposedofa3-minhighlyautomated the participants sat in the driver’s seat. Pedals and steering
trip on a straight, single carriageway, rural road. The trip was wheelwereinoperativeduringthesetrips.Perceiveddiscomfort
prerecordedandwasexactlythesameforallparticipants;there was assessed during the whole trip by a handset control
was no possibility to intervene by pedals or steering wheel. integrated into the driving simulator (Hartwich et al., 2015,
In every session, participants experienced three identical and 2018; Figure 2A). Participants could press the lever gradually
potentially discomfort-inducing approach situations with the in accordance with the extent of perceived discomfort. The
TABLE1|Overviewofexpectedeffectsofdifferentsensorparametersduringdiscomfort.
Sensor Parameter Expectedtrendduringdiscomfort
Eyetracking Pupildiameter Dilation(increaseofdiameterduringmentaleffort/stress/attention/taskdifficulty)
Blinkrate Decrease(attention/arousal/alertness)
MSBand2 Heartrate Increase(mentalworkload/stress)
Heartratevariability Decrease(mentalworkload/stress)
Skinconductancelevel Increase(mentalworkload/arousal/alertness/emotionalresponse/stress)
Motiontracking Shoulder/headmovements Push-back/lean-back(decreaseonz-axis)
Pressuremat Pressure Push-back/lean-back(pressureincreaseatbackpositionsensor)
FrontiersinHumanNeuroscience|www.frontiersin.org 3 September2018|Volume12|Article338

Beggiatoetal. DiscomfortDetectioninAutomatedDriving
FIGURE1|Setupofthedrivingsimulatorstudyduringoneapproachsituationtothetruckdrivingahead.Leftside:motioncapturemarkersathead,rightshoulder,
andhands;handsetcontrolforreportingdiscomfortheldintherighthand.Rightside:drivercameraview(top);frontscenerycameraviewrecordedfromtheroofof
themock-up(middle);reporteddiscomfortaswellasdrivingparametersatthatparticularmomentsuchasTTC,egospeed/truckspeed/speeddifferenceand
distancetothetruck(bottom).Writteninformedconsentwasobtainedfromtheindividualforthepublicationofthisimage.
smartband Microsoft Band 2 (Figure 2B) was used to record motionwasaseatpressurematdevelopedbytheprojectpartner
the physiological parameters of HR, HRV and SCL via a FusionSystemsGmbH(Figure2E).Thematcaneasilybeplaced
Bluetooth connection. Accelerometer and gyroscope data were ontopoftheseatandincludeseightpressuresensorsatdifferent
recorded as well from the band sensors to identify and correct positions.
for hand movements. The MS Band 2 was provided with a
Software Development Kit that allowed for programming a Data Recording and Sequence Extraction
dedicated logging application. Eye tracking data were recorded Data were recorded by several independent data loggers for
by SMI Eye Tracking Glasses 2 (SMI ETG 2, Figure 2C) each sensor with different recording frequencies. System time
and included pupil diameter, fixations, saccades and blinks. for all recording devices was continuously synchronized with
Participants already wearing eyeglasses (N = 10) could not a software tool based on the network time protocol (Meinberg
wear the SMI ETG 2, which resulted in less eye tracking data. NTP Software). Recording frequencies were 60 Hz for the
In addition, the SMI ETG 2 were not applied in the whole driving simulator data, including handset control, 10 Hz for
second driving session because of testing camera-based, facial- the MS Band 2, 60 Hz for the SMI ETG 2 eye tracking data,
featurerecognitionalgorithms.Bodymotionwassimultaneously 120 Hz for motion tracking, and 10 Hz for the seat pressure
capturedbytwosensorsystems.Thefirstdevicewasamarker- mat. Raw data for each recorder were imported into a storage
basedmotiontrackingsystemfromOptiTrackcomposedoffour and analysis framework based on the relational open-source
Flex 13 infrared cameras recording with 120 fps (Figure 2D). databasemanagementsystemPostgreSQL(Beggiato,2015).The
Atotaloffourdistinctrigidbodiesweretracked(leftandright synchronization procedure was based on the timestamps of
hand,rightshoulderandhead;seeFigures1,2D).Rigidbodies the driving simulator data (60 Hz) by adding the current
are a collection of three or more markers on an undeformable value of all other sensor systems at this specific moment. To
object. These rigid bodies can be attached to tracked objects analyze changes in the sensor data with regard to perceived
(e.g.,clothes,gloves,headbands)andallowforrecordingposition discomfort, data during reported discomfort by the handset
and orientation in six degrees of freedom. Participants with control were compared with 10-s time intervals prior and after
eyeglasses worea headband withthe rigid bodyattached (asin (Figure3).
Figure1),whereastheSMIETG2allowedfordirectlyattaching Discomfortintervalswereextractedfromthestartofpressing
rigid bodies (Figure 2C). The second sensor system for body the handset control lever until releasing, independent of the
FrontiersinHumanNeuroscience|www.frontiersin.org 4 September2018|Volume12|Article338

Beggiatoetal. DiscomfortDetectioninAutomatedDriving
FIGURE2|Sensors:(A)Handsetcontrolforreportingdiscomfort;(B)smartbandMicrosoftBand2;(C)SMIEyeTrackingGlasses2;(D)cameraandrigidbodyfor
motiontracking;(E)schematiclayoutandplacementofseatpressuremat.
magnitude. However, the handset control was only pressed was created for the charts in the results section (Figure 5).
in 208 of the 240 approach situations. The distribution and As the discomfort intervals varied in duration (Figure 4), a
descriptive statistics of the 208 extracted discomfort intervals percent scale from 0% to 300% over the whole sequence was
are presented in Figure 4. In addition, single sensor channels usedtoallowfordisplayingallvaluesinthesamescale.Periods
were not recorded in some situations (e.g., no SMI ETG 2 for before and after the discomfort interval were always 10 s long;
subjectsalreadywearingeyeglassesortechnicalproblems).Thus, thus, 1% corresponds to 0.1 s. Each discomfort interval was
allchartsintheresultssectioncontaintherespectivenumberand divided into percent slices, and the mean of each parameter
meandurationofdiscomfortintervalsthatwereincludedinthe was calculated for the specific time period of the respective
analysis.Forthesubsequentresultssection,theterm‘‘sequence’’ percent slice. Finally, each percentage section before, during,
referstothewholetimeperiodincludingthediscomfortinterval and after reported discomfort was combined into one chart to
aswellasthe10sbeforehandandafterwards. show the progress of values over time. As not every sensor
was active during the trips, each chart contains the number
of sequences with mean duration and standard deviation of
Data Preparation
the included discomfort intervals in the caption. The main
CommonX-Axis reason for using the percentage scale was to strictly respect
To show the development of all assessed parameters before, thesubjectiveaspectofdiscomfortmentionedinthedefinition.
during, and after the discomfort interval, a common time axis Thus, the different durations of reported discomfort intervals
FIGURE3|Exampleofsynchronizedsensordataduringonetrip,handsetvaluesinthefirstsensorchannelandthreeextracteddiscomfortintervals(disc)with10s
before(pre)and10safter(post).
FrontiersinHumanNeuroscience|www.frontiersin.org 5 September2018|Volume12|Article338

| Beggiatoetal. |     |     |     |     |     |     | DiscomfortDetectioninAutomatedDriving |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | ------------------------------------- | --- | --- |
FIGURE4|Distributionanddescriptivestatisticsofthe208extracteddiscomfortintervals.
shouldenterwiththesameweightinallanalyses,whichcanbe overallsequencesateachsinglepercentlevelfrom0%to300%
obtainedbythepercentagescale.Inaddition,theanalysismethod and displayed as a blue line in the results charts (Figure 5).
should also be applicable in less standardized situations, which Beside these general transformations, some parameter-specific
requires a reliance on the reported handset values. However, datacorrectionmethodsandtransformationswereappliedand
using the percentage scale also has some drawbacks. It is are described for each parameter in the subsequent results
notpossibletogiveprecisetime-relatedindications,asitisnot sections. To obtain a quick estimation about the statistical
time, but the subjectively reported intervals that represent the significance of changes over time, the 95% confidence interval
unit of measurement. However, descriptive statistics about the (CI) of each of these means was calculated pointwise and
intervalspresentedinFigure4provideanindicationoftemporal plotted as a light red area around the blue means. If the 95%
dimensions.Aseconddrawbackisinregardtoshortsequences CI does not overlap between two points in time, these two
of a few seconds, in which some physiological processes such means differ in a statistically significant manner at p < 0.01
as changes in HR and SCL could hardly take effect. Similar (Field, 2013). The pointwise CI does not include multiplicity
concerns could be raised regarding longer sequences in terms correction as would be the case for simultaneous confidence
of outliers, such as the six sequences over 20 s (Figure 4). bands. Simultaneous CI bands control for the familywise error
However,asthepercentagescaleassignsthesameweighttoall in autocorrelated time series by estimating the simultaneous
sequences, excluding these six sequences does not change the coverage probability of the whole curve (Korpela et al., 2014;
results (tested for all analyses). Thus, despite these mentioned Francisco-FernándezandQuintela-del-Río,2016;Ahonenetal.,
potentialdrawbacks,allsequenceswereincludedtopresentthe 2018). As the aim of the present analyses is not to fit a
overallpicture. curve,butallowforvisualcomparisonofsinglepointsintime,
|     |     |     |     |     | pointwise | CIs were used. | Pointwise | CIs are | narrower than |
| --- | --- | --- | --- | --- | --------- | -------------- | --------- | ------- | ------------- |
Z-Standardizationand95%ConfidenceIntervals
|     |     |     |     |     | a simultaneous | CI band | would be, | and pointwise | CIs allow |
| --- | --- | --- | --- | --- | -------------- | ------- | --------- | ------------- | --------- |
An important issue in processing psychophysiological data is only for comparing single points (as an ANOVA would do),
| distinguishing | the signal     | of interest from  | noise      | (Gratton and |        |                   |         |                |            |
| -------------- | -------------- | ----------------- | ---------- | ------------ | ------ | ----------------- | ------- | -------------- | ---------- |
|                |                |                   |            |              | but do | not appropriately | reflect | the CI for the | curve as a |
| Fabiani,       | 2017). Most of | the physiological | parameters | such as      |        |                   |         |                |            |
whole.
HRorEDAhaveastrongindividualcomponent,whichmeans
| that absolute                                           | values can          | hardly be compared | between    | subjects. |         |              |     |        |     |
| ------------------------------------------------------- | ------------------- | ------------------ | ---------- | --------- | ------- | ------------ | --- | ------ | --- |
| Thus,relativechangeswithinonepersonprovidebettersignal- |                     |                    |            |           | RESULTS |              |     |        |     |
| to-noise                                                | ratio, for example, | comparing          | changes    | of HR or  |         |              |     |        |     |
|                                                         |                     |                    |            |           | Pupil   | Diameter and | Eye | Blinks |     |
| EDA before,                                             | during and          | after discomfort   | intervals. | However,  |         |              |     |        |     |
these changes need to be transformed into a common scale Raw pupil diameters for the left and right eye (mm) from
to be compared between subjects. One of the common and the SMI ETG 2 were averaged to get a single diameter from
best-performingtransformationsisthez-score,whichexpresses both eyes. To correct for signal fluctuations (especially close
all values as the distance to the mean in units of standard to blinks), a moving average over ±300 ms was calculated,
deviations with a total mean of zero and a standard deviation and a z-transformation of these values was applied for each
ofone(JenningsandAllen,2017).Z-transformationwasapplied sequence. As pupil diameter is not only dependent on mental
foreachsequence,resultingintherelativechangesovertimein states,butprimarilyonambientlight(WatsonandYellott,2012),
units of standard deviations. Resulting z-values were averaged the metric could potentially be confounded during the white
FrontiersinHumanNeuroscience|www.frontiersin.org 6 September2018|Volume12|Article338

Beggiatoetal. DiscomfortDetectioninAutomatedDriving
FIGURE5|(A)Meanluminance-adjustedz-scoreofpupildiameterbefore,duringandafterdiscomfortintervals(N=65intervals,M=7.65s,SD=4.74s).
(B)Meanz-scoreofinterblinkintervaltimebefore,duringandafterdiscomfortintervals(N=67intervals,M=7.73s,SD=4.70s).(C)Meanz-scoreofHRbefore,
duringandafterdiscomfortintervals(N=206intervals,M=8.10s,SD=5.52s).(D)Meanz-scoreofdetrendedSCLbefore,duringandafterdiscomfortintervals
(N=203intervals,M=8.16s,SD=5.51s).(E)Meanz-scoreofrightshouldermovementsonthez-axisbefore,duringandafterdiscomfortintervals
(N=114intervals,M=7.85s,SD=4.79s).(F)Meanz-scoreofpressurematsensoratthebackpositionbefore,duringandafterdiscomfortintervals
(N=202intervals,M=8.04s,SD=5.41s).Theboldbluelineshowsthemeanvalues,andthelightredareashowsthe95%pointwiseconfidenceinterval(CI)inall
charts.
truckapproachsituation.Thus,themeanluminancevalueofall η2 = 0.285). However, this representation of blink rate does
p
pixels (HSL color model) was calculated for each video frame not allow for judging timings of increase/decrease as well
of the SMI ETG 2 front camera video. A z-transformation of as significance levels over time. Thus, it does not provide
this mean luminance was applied for the whole trip in order information for parameterizing an online detection algorithm.
tosubtracttheseluminancez-scoresfromthez-scoresofpupil Therefore, a second way of obtaining a continuous blink rate
diameter. The resulting luminance-adjusted z-values of pupil wasappliedbycalculatingarunning‘‘interblinkintervaltime.’’
diameter are shown in Figure 5A. In line with the hypotheses, This timer is set to zero every time a new blink is detected
pupil diameter increased significantly during the discomfort by the eye tracker and increases until the subsequent eye blink
intervalanddecreasedsteadilyafterreporteddiscomfort.About start is detected. Blink duration is not excluded and enters the
5 s after the end of the discomfort interval (approx. 250%), running time. Z-values of this running interblink interval time
the 95% CI does not overlap anymore with the 95% CI werecalculatedforeachsequenceandaveragedforeachpercent
during the discomfort interval (side note: without correcting oftime.Figure5Bshowstheprogressofinterblinkintervaltime
for ambient luminance, the effects are the same but more z-scores with a noticeable increase during discomfort intervals
pronounced). (meaninglessblinks)andthereturntothepriorlevelafterthe
Eye blink rate recorded by the SMI ETG 2 was computed discomfortinterval.
in two different ways: first, blinks per second were calculated
for each whole interval before, during, and after reported Heart Rate and Heart Rate Variability
discomfort.Figure6Ashowstheexpecteddecreaseinblinkrate Raw HR values in beats per minute recorded by the MS Band
from 0.25 blinks per second before discomfort to 0.17 blinks 2weretransformedintoz-valuesforeachofthe206sequences.
per second during discomfort and the increase afterwards Figure5Cshowsthemeanz-scoresforHRovertime.Incontrast
to 0.37 blinks per second (F(1.37,118.57) = 26.37, p < 0.001, tothehypothesis,HRdecreasedsteadilyatthebeginningofthe
FrontiersinHumanNeuroscience|www.frontiersin.org 7 September2018|Volume12|Article338

| Beggiatoetal. |     |     |     |     |     |     |     | DiscomfortDetectioninAutomatedDriving |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------- | --- | --- |
discomfortinterval.ThebottomHRplateauwasreachedatabout z-standardizedforeachsequence.Resultsshowedacontinuous
themiddleofthediscomfortinterval(150%)andkeptuntilabout linear increase of SCL over time, independent of the situation.
5safterreporteddiscomfort(250%).Afterward,HRrapidlyrose Asthislineargrowingtrendwasprobablyrelatedtothefactthat
uptoapproximatelythepriorlevel. subjectssimplygotwarmduringdriving,adetrendingalgorithm
The HRV was computed using the interbeat interval times was applied. Thus, a linear regression was calculated for each
(IBI) in s from the MS Band 2. The HR and IBI are not sequence.TheSCLz-scoresweresubtractedfromtheregression
exact reciprocal values in the case of the MS Band 2, but values in order to obtain detrended z-scores, which are shown
IBI is recommended for HRV calculations (Cropley et al., inFigure5D.DetrendedSCLshowedalmostnochangesduring
2017). The time-domain metric root mean square successive the discomfort interval compared with the interval before and
| difference    | (RMSSD)        | was            | calculated | for      | each interval  | and       | after.         |     |     |     |
| ------------- | -------------- | -------------- | ---------- | -------- | -------------- | --------- | -------------- | --- | --- | --- |
| averaged      | over all       | 202 sequences. | The        | RMSSD    | is recommended |           |                |     |     |     |
|               |                |                |            |          |                |           | Body Movements |     |     |     |
| for measuring | high-frequency |                | HRV        | and when | time           | intervals |                |     |     |     |
to compare are not equally long (Berntson et al., 2017). Toassessbodymovements,datafromthemarker-basedmotion
Frequency domain and nonlinear HRV measures were not trackingsystemaswellastheseatpressurematwereevaluated.
|         |            |            |       |              |               |     | The position | of the right shoulder | (mm) was captured | by the |
| ------- | ---------- | ---------- | ----- | ------------ | ------------- | --- | ------------ | --------------------- | ----------------- | ------ |
| applied | due to the | relatively | short | time periods | investigated. |     |              |                       |                   |        |
In line with the hypothesis, Figure 6B shows the expected motion tracking system. As the absolute marker position in
u-shaped pattern with a decrease of HRV during reported the 3D space differed for each individual subject and each
discomfort(χ2 =40.05,p<0.001;nonparametricFriedman’s drive,differencesonthez-axispositionwerecomputedforeach
(2)
ANOVA). sequence starting with zero at the beginning of the sequence.
Thesevaluechangesweretransformedintoz-scores.Figure5E
Skin Conductance Level shows the mean z-scores of shoulder movement on the z-axis.
Two electrodes on the opposite side of the MS Band 2 display As expected, the pushback of the body was represented by
(Figure 2B) measured skin resistance level in kilo ohm. These the u-shaped decrease of the shoulder z-position during the
values were inverted and multiplied by 1,000 to obtain the discomfort interval. Shoulder movements on the x- and y-axis
SCL in micro Siemens. The SCL values were very sensitive showed similar but weaker effects; the main movement was
| to changes | in the | hand/arm | position | such | as placing | a hand | backwards. |     |     |     |
| ---------- | ------ | -------- | -------- | ---- | ---------- | ------ | ---------- | --- | --- | --- |
on the knees. Thus, SCL values were excluded (missing data) The pushback movement should also be represented in the
during high-movement episodes on the basis of the MS Band data of the seat pressure mat, which would potentially allow
2accelerometerandgyroscopedata.Theremainingvalueswere foraneasiermovementmeasurementthanmotiontracking.To
FIGURE6|(A)Meaneyeblinkratebefore,duringandafterdiscomfortintervals(N=67intervals,M=7.73s,SD=4.70s).(B)MeanHRV(RMSSD)before,during
andafterdiscomfortintervals(N=202intervals,M=8.10s,SD=5.53s).Theboldbluedotsshowthemeanvalues,andthelightredbarsshowthe
95%pointwiseCI.
FrontiersinHumanNeuroscience|www.frontiersin.org 8 September2018|Volume12|Article338

| Beggiatoetal. |     |     |     |     |     |     |     |     |     | DiscomfortDetectioninAutomatedDriving |     |     |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------- | --- | --- | --- | --- |
analyzetheseatpressurematdata,thesensoratthebackposition discomfort intervals. Thus, the low frequency of eye blinks
wastakenintoaccount.Pressurevalueswerez-transformedfor lowers the potential to serve as real-time predictor for
| eachsequence.Thez-scoresofthepressuresensor(Figure5F) |     |     |     |     |     |     | discomfort. |     |     |     |     |     |     |     |
| ----------------------------------------------------- | --- | --- | --- | --- | --- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
showedthecorrespondingpatterntothemotion-trackingresults Contrary to the expected trend, HR decreased during
with an increase of pressure during the discomfort interval discomfortperiodsandreturnedtothepriorlevelapproximately
(pushbackmovement). 5 s after reported discomfort. A possible explanation for the
|     |     |     |     |     |     |     | unexpected | decrease | could | be  | the effect | of ‘‘preparation |     | for |
| --- | --- | --- | --- | --- | --- | --- | ---------- | -------- | ----- | --- | ---------- | ---------------- | --- | --- |
DISCUSSION action,’’ which means an anticipatory deceleration of HR prior
|     |     |     |     |     |     |     | to planned | actions | (Schandry, |     | 1998; Cooke | et  | al., 2014). | The |
| --- | --- | --- | --- | --- | --- | --- | ---------- | ------- | ---------- | --- | ----------- | --- | ----------- | --- |
The present study aimed at detecting discomfort in automated effectwasreportedforsportactionssuchasgolfputting,butalso
driving by physiological parameters from smartbands, forsimplerreactiontime(RT)paradigms:‘‘Itiswellestablished
pupillometry and body motion. Discomfort is considered an that HR deceleration occurs during the fixed foreperiod of an
important issue for broad public acceptance of automated RT task’’ (Andreassi, 2000, p. 270). The HRV measured by the
|          |            |            |        |      |             |     | RMSSD | showed | the expected | u-shaped | pattern |     | with a decrease |     |
| -------- | ---------- | ---------- | ------ | ---- | ----------- | --- | ----- | ------ | ------------ | -------- | ------- | --- | --------------- | --- |
| vehicles | as well as | for safety | issues | such | as critical | and |       |        |              |          |         |     |                 |     |
not-necessarytake-oversituations.Consideringthemetaphorof duringthediscomfortintervals.
avehicle-driver-teamthatknowseachother,automatedsystems The SCL showed a linear increasing trend over time, which
could react to detected discomfort by changing driving style could probably be explained by the effect that participants
parameters and information presentation. An important basis got warm during driving. After correcting for this linear
for a real-time discomfort detection algorithm is information trend using a regression approach, SCL showed almost
about physiological sensor parameters associated with reported no situation-related changes during discomfort intervals.
|             |                 |     |            |           |     |          | The missing |     | effects | could | be related | to  | measurement |     |
| ----------- | --------------- | --- | ---------- | --------- | --- | -------- | ----------- | --- | ------- | ----- | ---------- | --- | ----------- | --- |
| discomfort, | such as overall |     | relevance, | direction | and | strength |             |     |         |       |            |     |             |     |
of effects, timings, variability as well as filtering and artifact procedures associated with the smartband. First, absolute
removalstrategies. SCL values were highly dependent on how tightly the
Overall,besidesSCL,allotherassessedparameterslikepupil band was closed. These differences could be corrected by
diameter, eye blink rate, HR, HRV and body motion showed the z-transformation; however, some bias could remain
changes associated with discomfort indicated by the handset (e.g., when the band was worn very loosely). Second, SCL
control. However, filtering and standardization procedures are measures were taken from the outer side of the wrist, which
required to increase the signal-to-noise ratio and remove is considered a much less sensitive place for SCL-changes
bias caused by individual differences. In addition, every compared with the fingers (Andreassi, 2000). Third, hand
parameter has its own specificities, which are subsequently movements partly caused strong offsets in EDA values. The
|     |     |     |     |     |     |     | simple correction |     | method | of excluding |     | these | parts from | the |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | ------ | ------------ | --- | ----- | ---------- | --- |
discussed.
Pupildiametershowedtheexpectedinverseu-shapedpattern analysis could potentially be improved by more sophisticated
| with a | dilation during | discomfort |     | and recovery |     | afterward, | algorithms. |     |     |     |     |     |     |     |
| ------ | --------------- | ---------- | --- | ------------ | --- | ---------- | ----------- | --- | --- | --- | --- | --- | --- | --- |
analogous to results regarding workload (Andreassi, 2000; The mentioned problems such as limited control on how
Cowley et al., 2016). However, pupil diameter is not only tight the band is closed are to some extent related to the
dependentonmentalstates,butalsoprimarilyonambientlight use of smartbands instead of more sophisticated measurement
conditions. Despite the fact that light conditions in the driving devices for physiological parameters. However, the aim of
|           |               |     |      |             |     |            | the KomfoPilot |     | project | was and | is to | estimate | the potential |     |
| --------- | ------------- | --- | ---- | ----------- | --- | ---------- | -------------- | --- | ------- | ------- | ----- | -------- | ------------- | --- |
| simulator | do not change | as  | much | as on-road, | a   | correction |                |     |         |         |       |          |               |     |
algorithm was applied by subtracting the z-standardized mean of existing wearable devices with all the real-world usage
pixel luminance from the z-values of pupil diameter at every challenges. Even with these problems, effects associated with
frontcameravideoframe.Evenwiththisadjustment,theeffects discomfort could be identified in the data. One of the major
are still observable. However, this quite simple adjustment challenges for using these devices will be the use of adequate
procedure has some limitations. First, the exact association signal analysis methods for gaining maximum signal-to-noise
| betweenambientlightandpupildiameterismuchmorecomplex |        |              |         |     |              |        | ratio. |           |     |          |        |          |      |     |
| ---------------------------------------------------- | ------ | ------------ | ------- | --- | ------------ | ------ | ------ | --------- | --- | -------- | ------ | -------- | ---- | --- |
|                                                      |        |              |         |     |              |        | Body   | movements |     | captured | by the | pressure | seat | mat |
| than a simple                                        | linear | relationship | (Watson |     | and Yellott, | 2012). |        |           |     |          |        |          |      |     |
Second,camerasthemselvesadapttoambientlight,whichdoes and the motion tracking of the right shoulder showed
not allow to exactly measure luminance out of a video image. the expected pushback during the close approach to the
Third, eye tracking with the front camera can be used for truck. As posture dynamics are strongly related to specific
lab experiments; in automated vehicles, luminance must be situations (Tran and Trivedi, 2010), these movement patterns
measuredbyothersensors.Despitetheselimitations,theapplied cannotautomaticallybegeneralizedacrossdifferentdiscomfort
adjustment procedure is real-time capable and will again be situations. However, discomfort associated with gaps that are
testedinsubsequentstudieswithintheproject. too close or potential rear-end collisions could be detected
Eye blink rate showed the expected u-shaped pattern with involving body motion. A potential approach for data fusion
fewer blinks during the discomfort interval (i.e., participants algorithms could be the inclusion of environment sensor
|            |           |         |             |     |          |        | information | such | as time | headway | (Leonhardt |     | et al., | 2017) |
| ---------- | --------- | ------- | ----------- | --- | -------- | ------ | ----------- | ---- | ------- | ------- | ---------- | --- | ------- | ----- |
| kept their | eyes open | in this | situation). |     | However, | as the |             |      |         |         |            |     |         |       |
baseline blink rate is about one blink every 4 s, eye and to consider the pushback motion pattern only in these
| blinks are | a ‘‘rare | event’’ | in relation | to  | the duration | of  | situations. |     |     |     |     |     |     |     |
| ---------- | -------- | ------- | ----------- | --- | ------------ | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
FrontiersinHumanNeuroscience|www.frontiersin.org 9 September2018|Volume12|Article338

| Beggiatoetal. |     |     |     |     |     |     |     |     |     |     | DiscomfortDetectioninAutomatedDriving |     |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------- | --- | --- | --- |
To sum up, the predicted mechanism of the monitored them. A limitation of this study is of course that only this
physiologicalsignalsfordesigningandconfiguringthereal-time specific truck approach situation has been investigated. The
detectionalgorithmincludesthefollowingaspects.Mostrelevant findings must be validated in other potentially discomfort-
parameterswiththehighestdiscomfort-specificchangesresulted inducing situations, which are the next steps in the project.
inambientlight-correctedpupildiameter,HRandthepushback However,theuseofthishighlystandardizedapproachsituation
movement.InterblinkintervaltimeandHRVmeasuresshowed alsoprovidessomeadvantages:(a)adistancethatisexperienced
| changes, | but could | be  | unstable | due to | the short | time | intervals. |     |     |     |     |     |     |     |
| -------- | --------- | --- | -------- | ------ | --------- | ---- | ---------- | --- | --- | --- | --- | --- | --- | --- |
astoocloseisoneofthemostmentionedissuesfordiscomfortas
TheSCLfromtheMSBand2didnotshowspecificchangesand a codriver (dpa, 2013); (b) comfortable adjustment of headway
is, therefore, not recommended for inclusion in the algorithm. distance and approach situations are not only relevant in
Regarding variability and filtering, relative changes within one conditional and high automation (SAE Levels 3 and above),
person need to be assessed due to the strong individual but also for driver assistance systems such as adaptive cruise
componentofallparameters.Thiscouldbeachievedinreal-time controlandpartialautomation(SAElevels1and2);and(c)the
by e.g., performing individual z-standardization in sliding time highstandardizationofthesituationallowedforestimatingthe
| windows | and comparing |     | the | current | signal | value with | these |     |     |     |     |     |     |     |
| ------- | ------------- | --- | --- | ------- | ------ | ---------- | ----- | --- | --- | --- | --- | --- | --- | --- |
potentialofdifferentsensorsaswellastestingdatafilteringand
scores. This comparison could include several time windows artifact-removalstrategies.Thus,theresultsserveasabasisfor
of different lengths and different onsets, e.g., with 10 s and designingandconfiguringthereal-timedetectionalgorithmthat
| 5 s duration | and | an  | onset | 3 s and | 5 s | before the | current |     |     |     |     |     |     |     |
| ------------ | --- | --- | ----- | ------- | --- | ---------- | ------- | --- | --- | --- | --- | --- | --- | --- |
isindevelopmentbytheprojectpartnerswhospecializeindata
moment. This procedure would allow one to keep trace of the fusion(FusionSystemsGmbHandCommunicationEngineering
individual parameter variability by offering, at the same time, Department at Chemnitz University of Technology). The
theapplicationofstandardizedthresholds(suchasadecreasein algorithmwillbeimplementedinthedrivingsimulationsoftware
HRby0.3SD-unitscomparedtotheslidingwindow).Threshold
andtestedinsubsequentstudies.
| values as        | well as    | timings | can                   | be obtained     |       | from the        | results in |           |                    |          |               |           |        |        |
| ---------------- | ---------- | ------- | --------------------- | --------------- | ----- | --------------- | ---------- | --------- | ------------------ | -------- | ------------- | --------- | ------ | ------ |
| Figure 5         | and can    | be      | adjusted              | to configure    |       | the sensitivity | of         |           |                    |          |               |           |        |        |
|                  |            |         |                       |                 |       |                 |            | AUTHOR    | CONTRIBUTIONS      |          |               |           |        |        |
| the detection    | algorithm. |         | To                    | combine         | these | predictions     | of each    |           |                    |          |               |           |        |        |
| single parameter |            | into    | one discomfort-score, |                 |       | probabilistic   | data       |           |                    |          |               |           |        |        |
|                  |            |         |                       |                 |       |                 |            | MB, FH    | and JK contributed |          | to conception | and       | design | of the |
| fusion methods   |            | such as | Bayesian              | Networks        |       | could be used.  | The        |           |                    |          |               |           |        |        |
|                  |            |         |                       |                 |       |                 |            | study and | also contributed   | to       | manuscript    | revision, | read   | and    |
| nodes of         | such a     | network | allow                 | for integration |       | of environment  |            |           |                    |          |               |           |        |        |
|                  |            |         |                       |                 |       |                 |            | approved  | the submitted      | version. | MB            | performed | sensor | data   |
information(suchaspresenceofavehicledrivingahead)aswell
|     |     |     |     |     |     |     |     | preparation, | setup of | the PostgreSQL |     | database | and statistical |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | -------- | -------------- | --- | -------- | --------------- | --- |
asfor‘‘inverting’’thealgorithm,oncediscomfortwasdetected,
analysesofsensordata.FHprepararedandanalyzedparticipant
| in order | to return | to  | the baseline. |     | This method | has | already |     |     |     |     |     |     |     |
| -------- | --------- | --- | ------------- | --- | ----------- | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
andquestionnairedata.MBdraftedmajorpartsof‘‘Introduction,
| been applied | by         | the Communication |               |     | Engineering   | Department |     |         |                  |           |     |                |     |        |
| ------------ | ---------- | ----------------- | ------------- | --- | ------------- | ---------- | --- | ------- | ---------------- | --------- | --- | -------------- | --- | ------ |
|              |            |                   |               |     |               |            |     | Results | and Discussion’’ | sections. |     | FH contributed |     | to the |
| at Chemnitz  | University |                   | of Technology |     | for real-time | prediction |     |         |                  |           |     |                |     |        |
‘‘Introduction’’sectionanddraftedmainpartsofthe‘‘Materials
| of lane | change | maneuvers, |     | combining | parameters |     | from the |     |     |     |     |     |     |     |
| ------- | ------ | ---------- | --- | --------- | ---------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- |
andMethods’’section.JKcontributedtothediscussionsection.
| driver, the | vehicle | and | the | environment |     | (Leonhardt | et al., |     |     |     |     |     |     |     |
| ----------- | ------- | --- | --- | ----------- | --- | ---------- | ------- | --- | --- | --- | --- | --- | --- | --- |
2017).
| In conclusion, |     | the        | assessed | parameters |        | from smartbands, |     | FUNDING |     |     |     |     |     |     |
| -------------- | --- | ---------- | -------- | ---------- | ------ | ---------------- | --- | ------- | --- | --- | --- | --- | --- | --- |
| eye tracking   |     | and motion |          | tracking   | showed | potential        | for |         |     |     |     |     |     |     |
detecting discomfort in this approach situation. Despite The research project KomfoPilot (2017–2019) is funded by the
commercially available smartbands providing less precise FederalMinistryofEducationandResearch(Bundesministerium
measures as dedicated lab devices, effects associated with fürBildungundForschung)undergrantno.16SV7690K.More
discomfort could be identified. However, wearable devices also information can be found at https://www. tu-chemnitz.de/hsw/
pose new challenges such as less control on how users apply psychologie/professuren/allpsy1/english/traffic.php.
REFERENCES
|     |     |     |     |     |     |     |     | estimation | (No. CMU-RI-TR-04–10). |     | Pittsburgh, | PA: | Carnegie | Mellon |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ---------------------- | --- | ----------- | --- | -------- | ------ |
University.Availableonlineat:http://ri.cmu.edu/pub_files/pub4/baker_simon
Ahonen, L., Cowley, B., Hellas, A., and Puolamäki, K. (2018). Biosignals _2004_1/baker_simon_2004_1.pdf
reflect pair-dynamics in collaborative work: EDA and ECG study Banks,V.A.,andStanton,N.A.(2016).Keepthedriverincontrol:automating
of pair-programming in a classroom environment. Sci. Rep. 8:3138. automobilesofthefuture.Appl.Ergon.53,389–395.doi:10.1016/j.apergo.2015.
| doi:10.1038/s41598-018-21518-3 |     |     |     |     |     |     |     | 06.020 |     |     |     |     |     |     |
| ------------------------------ | --- | --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- |
Ahonen, L., Cowley, B., Torniainen, J., Ukkonen, A., Vihavainen, A., Beggiato,M.(2015).Changesinmotivationalandhigherlevelcognitiveprocesses
Puolamäki, K., et al. (2016). Cognitive collaboration found in cardiac when interacting with in-vehicle automation (Doctoral Dissertation).
physiology: study in classroom environment. PLoS One 11:e0159178. University of Technology Chemnitz. Available online at: http://nbn-
doi:10.1371/journal.pone.0159178 resolving.de/urn:nbn:de:bsz:ch1-qucosa-167333 [Accessed 12 April
| Andreassi, | J. L. (2000). | Psychophysiology: |     | Human | Behavior | and Physiological |     | 2017]. |     |     |     |     |     |     |
| ---------- | ------------- | ----------------- | --- | ----- | -------- | ----------------- | --- | ------ | --- | --- | --- | --- | --- | --- |
Response.4thEdn.Mahwha,NJ:L.Erlbaum. Beggiato, M., Hartwich, F., Schleinitz, K., Krems, J. F., Othersen, I., and
Backs,R.W.,andBoucsein,W.(2000).EngineeringPsychophysiology:Issuesand Petermann-Stock,I.(2015).Whatwoulddriversliketoknowduringautomated
Applications.Mahwah,NJ:L.Erlbaum. driving?Informationneedsatdifferentlevelsofautomation,inProceedings
Baker, S., Matthews, I., Xiao, J., Gross, R., Ishikawa, T., and Kanade, T. ofthe7thConferenceonDriverAssistance(Munich:TechnischeUniversitat
(2004). Real-time non-rigid driver head tracking for driver mental state Munchen(TUM)).doi:10.13140/RG.2.1.2462.6007
FrontiersinHumanNeuroscience|www.frontiersin.org 10 September2018|Volume12|Article338

Beggiatoetal. DiscomfortDetectioninAutomatedDriving
Bellem, H., Schönenberg, T., Krems, J. F., and Schrauf, M. (2016). Objective Hartwich,F.,Beggiato,M.,Dettmann,A.,andKrems,J.F.(2015).‘‘Driveme
metricsofcomfort:developingadrivingstyleforhighlyautomatedvehicles. comfortable:individualcustomizedautomateddrivingstylesforyoungerand
Transp.Res.PartFTrafficPsychol.Behav.41,45–54.doi:10.1016/j.trf.2016. olderdrivers,’’inVDI(Eds.).DerFahrerim21.Jahrhundert.VDI-Berichte2264,
05.005 (Düsseldorf:VDI-Verlag),271–283.
Bellem,H.,Thiel,B.,Schrauf,M.,andKrems,J.F.(2018).Comfortinautomated Hartwich,F.,Beggiato,M.,andKrems,J.F.(2018).Drivingcomfort,enjoyment
driving:ananalysisofpreferencesfordifferentautomateddrivingstylesand andacceptanceofautomateddriving—effectsofdrivers’ageanddriving—style
their dependence on personality traits. Transp. Res. Part F Traffic Psychol. familiarity. Ergonomics 61, 1017–1032. doi: 10.1080/00140139.2018.
Behav.55,90–100.doi:10.1016/j.trf.2018.02.036 1441448
Berntson, G. G., Quigley, K. S., Norman, G. J., and Lozano, D. L. Hergeth,S.,Lorenz,L.,andKrems,J.F.(2017).Priorfamiliarizationwithtakeover
(2017).‘‘Cardiovascularpsychophysiology,’’inHandbookofPsychophysiology, requests affects drivers’ takeover performance and automation trust. Hum.
edsJ.T.Cacioppo,L.G.TassinaryandG.G.Berntson, 4thEdn.(Cambridge: Factors59,457–470.doi:10.1177/0018720816678714
CambridgeUniversityPress),183–216. Jennings, J. R., and Allen, B. (2017). ‘‘Methodology,’’ in Handbook of
Binsch, O., Wabeke, T., and Valk, P. (2016). ‘‘Comparison of three different Psychophysiology, 4th Edn, eds J. T. Cacioppo, L. G. Tassinary and
physiologicalwristbandsensorsystemsandtheirapplicabilityforresilience- G.G.Berntson(Cambridge:CambridgeUniversityPress),583–611.
and work load monitoring,’’ in Proceedings of the IEEE 13th International Klein,G.,Woods,D.,Bradshaw,J.,Hoffman,R.,andFeltovich,P.(2004).Ten
ConferenceonWearableandImplantableBodySensorNetworks(BSN),(San challenges for making automation a ‘‘team player’’ in joint human-agent
Francisco,CA),272–276. activity.IEEEIntell.Syst.19,91–95.doi:10.1109/mis.2004.74
Brookhuis,K.A.,anddeWaard,D.(2011).‘‘Measuringphysiologyinsimulators,’’ Korpela,J.,Puolamäki,K.,andGionis,A.(2014).Confidencebandsfortimeseries
inHandbookofDrivingSimulationforEngineering,MedicineandPsychology, data.DataMin.Knowl.Discov.28,1530–1553.doi:10.1007/s10618-014-0371-0
edsD.L.Fisher,M.Rizzo,J.K.CairdandJ.D.Lee(BocaRaton,FL:CRCPress), Laftchiev, E., and Nikovski, D. (2016). ‘‘An IoT system to estimate personal
17.1–17.10. thermalcomfort,’’inProceedingsoftheIEEE3rdWorldForumonInternetof
Constantin,D.,Nagi,M.,andMazilescu,C.-A.(2014).Elementsofdiscomfortin Things(WF-IoT)(Reston,VA:IEEE),672–677.
vehicles.ProcediaSoc.Behav.Sci.143,1120–1125.doi:10.1016/j.sbspro.2014. Leonhardt,V.,Pech,T.,andWanielik,G.(2017).‘‘Fusionofdriverbehaviour
07.564 analysis and situation assessment for probabilistic driving manoeuvre
Cooke,A.,Kavussanu,M.,Gallicchio,G.,Willoughby,A.,McIntyre,D.,andRing, prediction,’’inUR:BANHumanFactorsinTraffic.ApproachesforSafe,Efficient
C. (2014). Preparation for action: Psychophysiological activity preceding a andStressfreeUrbanTraffic,edsK.Bengler,S.Hoffmann,D.Manstettenand
motorskillasafunctionofexpertise,performanceoutcome,andpsychological A.Neukum(Wiesbaden:SpringerViewegVerlag),223–244.
pressure.Psychophysiology51,374–384.doi:10.1111/psyp.12182 Li,D.,Menassa,C.C.,andKamat,V.R.(2017).Personalizedhumancomfort
Cowley,B.,Filetti,M.,Lukander,K.,Torniainen,J.,Henelius,A.,andAhonen,L. in indoor building environments under diverse conditioning modes. Build
(2016).Thepsychophysiologyprimer:aguidetomethodsandabroadreview Environ.126,304–317.doi:10.1016/j.buildenv.2017.10.004
with a focus on human-computer interaction. Found. Trends Hum. Comp. Mehler, B., Reimer, B., and Coughlin, J. F. (2012). Sensitivity of
Inter.9,151–308.doi:10.1561/1100000065 physiological measures for detecting systematic variations in cognitive
Cropley,M.,Plans,D.,Morelli,D.,Sütterlin,S.,Inceoglu,I.,Thomas,G.,etal. demand from a working memory task. Hum. Factors 54, 396–412.
(2017). The association between work-related rumination and heart rate doi:10.1177/0018720812442086
variability:afieldstudy.Front.Hum.Neurosci.11:27.doi:10.3389/fnhum.2017. Morris, D. M., Erno, J. M., and Pilcher, J. J. (2017). ‘‘Electrodermal
00027 response and automation trust during simulated self-driving car use,’’ in
Dawson, M. E., Schell, A. M., and Filion, D. L. (2017). ‘‘The electrodermal Proceedings of the Human Factors and Ergonomics Society Annual Meeting
system,’’inHandbookofPsychophysiology,edsJ.T.Cacioppo,L.G.Tassinary (Clemson, SC: Clemson University), 1759–1762. doi: 10.1177/154193121
and G. G. Berntson, 4th Edn. (Cambridge: Cambridge University Press), 3601921
217–243. Mulder,L.,deWaard,D.,andBrookhuis,K.A.(2005).‘‘Estimatingmentaleffort
deLooze,M.P.,Kuijt-Evers,L.F.M.,andvanDieën,J.(2003).Sittingcomfort usingheartrateandheartratevariability,’’inHandbookofHumanFactorsand
anddiscomfortandtherelationshipswithobjectivemeasures.Ergonomics46, ErgonomicsMethods,edsN.A.Stanton,A.Hedge,K.A.Brookhuis,E.Salas
985–997.doi:10.1080/0014013031000121977 andH.Hendrick(BocaRaton,FL:CRCPress),21–28.
dpa. (2013). Viele verängstigte Beifahrer Leiden im Stillen. Welt.de. Available Palinko, O., and Kun, A. L. (2012). ‘‘Exploring the effects of visual cognitive
online at: https://www.welt.de/newsticker/dpa_nt/serviceline/auto_verkehr/ loadandilluminationonpupildiameterindrivingsimulators,’’inETRA’12,
article113657517/Viele-veraengstigte-Beifahrer-leiden-im-Stillen.html Proceedings of the Symposium on Eye Tracking Research and Applications
Elbanhawi,M.,Simic,M.,andJazar,R.(2015).Inthepassengerseat:investigating (NewYork,NY:ACM),413–416.
ridecomfortmeasuresinautonomouscars.IEEEIntell.Transp.Syst.Mag.7, Pech,T.,Lindner,P.,andWanielik,G.(2014).‘‘Headtrackingbasedglancearea
4–17.doi:10.1109/mits.2015.2405571 estimation for driver behaviour modelling during lane change execution,’’
Engelbrecht, A. (2013). Fahrkomfort und Fahrspass beim Einsatz von in Proceedings of the 17th International IEEE Conference on Intelligent
Fahrerassistenzsystemen.Hamburg:DissertaVerlag. TransportationSystems(ITSC14)(NewYork,NY:UnitedStates),655–660.
ERTRAC. (2017). Automated Driving Roadmap. European Road Transport Reinerman-Jones,L.,Harris,J.,andWatson,A.(2017).‘‘Considerationsforusing
ResearchAdvisoryCouncil.Availableonlineat:http://www.ertrac.org/uploads/ fitnesstrackersinpsychophysiologyresearch,’’inHumanInterfaceandthe
documentsearch/id48/ERTRAC_Automated_Driving_2017.pdf ManagementofInformation:Information,KnowledgeandInteractionDesign
Field,A.P.(2013).DiscoveringStatisticsUsingIBMSPSSStatistics.4thEdn.Los (LNCS10273),ed.S.Yamamoto(Cham:SpringerInternationalPublishing),
Angeles,CA:SAGE. 598–606.Availableonlineat:https://link.springer.com/chapter/10.1007/978-3-
Filippoupolitis,A.,Takand,B.,andLoukas,G.(2016).‘‘Activityrecognitionina 319-58521-5_47.
homesettingusingofftheshelfsmartwatchtechnology,’’inProceedingsofthe Riener,A.,Boll,S.,andKun,A.L.(2016).AutomotiveUserInterfacesintheAgeof
15thInternationalConferenceonUbiquitousComputingandCommunications Automation(DagstuhlReports),6,111–159.doi:10.4230/DagRep.6.6.111
and2016InternationalSymposiumonCyberspaceandSecurity(IUCC-CSS) Schandry, R. (1998). Lehrbuch Psychophysiologie: Körperliche Indikatoren
(Granada:Spain),39–44.doi:10.1109/IUCC-CSS.2016.014 PsychischenGeschehens(Studienausg).Weinheim:Beltz,PsychologieVerlags
Francisco-Fernández, M., and Quintela-del-Río, A. (2016). Comparing Union.
simultaneousandpointwiseconfidenceintervalsforhydrologicalprocesses. Schmalfuß, F., Mach, S., Klüber, K., Habelt, B., Beggiato, M., Körner, A.,
PLoSOne11:e0147505.doi:10.1371/journal.pone.0147505 et al. (2018). ‘‘Potential of wearable devices for mental workload
Gratton,G.,andFabiani,M.(2017).‘‘Biosignalprocessinginpsychophysiology: detection in different physiological activity conditions,’’ in Proceedings
principles and current developments,’’ in Handbook of Psychophysiology, of the Human Factors and Ergonomics Society Europe Chapter
edsJ.T.Cacioppo,L.G.TassinaryandG.G.Berntson,4thEdn.(Cambridge: 2017 Annual Conference, eds D. de Waard, F. Nocera, D. Coelho,
CambridgeUniversityPress),628–661. J. Edworthy, K. Brookhuis and F. Ferlazzo (Netherlands: University of
FrontiersinHumanNeuroscience|www.frontiersin.org 11 September2018|Volume12|Article338

Beggiatoetal. DiscomfortDetectioninAutomatedDriving
Groningen), 179–191. Available online at: https://www.hfes-europe.org/wp- Watson,A.B.,andYellott,J.I.(2012).Aunifiedformulaforlight-adaptedpupil
content/uploads/2017/10/Schmalfuss2017.pdf size.J.Vis.12:12.doi:10.1167/12.10.12
Schmidt,E.,Decke,R.,andRasshofer,R.(2016).‘‘Correlationbetweensubjective
driverstatemeasuresandpsychophysiologicalandvehiculardatainsimulated Conflict of Interest Statement: The authors declare that the research was
driving,’’ in Proceedings of the IEEE Intelligent Vehicles Symposium (IV), conductedintheabsenceofanycommercialorfinancialrelationshipsthatcould
(Gothenburg,Sweden),1380–1385. beconstruedasapotentialconflictofinterest.
Tran,C.,andTrivedi,M.M.(2009).‘‘Driverassistancefor‘Keepinghandson
the wheel and eyes on the road’,’’ in Proceedings of the IEEE International ThereviewerDWandhandlingEditordeclaredtheirsharedaffiliation.
ConferenceonVehicularElectronicsandSafety(ICVES),(Pune),97–101.
Tran,C.,andTrivedi,M.M.(2010).‘‘Towardsavision-basedsystemexploring Copyright©2018Beggiato,HartwichandKrems.Thisisanopen-accessarticle
3Ddriverposturedynamicsfordriverassistance:issuesandpossibilities,’’in distributedunderthetermsoftheCreativeCommonsAttributionLicense(CCBY).
ProceedingsoftheIEEEIntelligentVehiclesSymposium(IV),(SanDiego,CA), Theuse,distributionorreproductioninotherforumsispermitted,providedthe
179–184. originalauthor(s)andthecopyrightowner(s)arecreditedandthattheoriginal
Wade. (2017). Wearable technology statistics and trends 2018. Available publicationinthisjournaliscited,inaccordancewithacceptedacademicpractice.
online at: https://www.smartinsights.com/digital-marketing-strategy/wearab Nouse,distributionorreproductionispermittedwhichdoesnotcomplywiththese
les-statistics-2017/ terms.
FrontiersinHumanNeuroscience|www.frontiersin.org 12 September2018|Volume12|Article338
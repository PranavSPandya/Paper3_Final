Journal of Exposure Science & Environmental Epidemiology
www.nature.com/jes
ARTICLE OPEN
Association between environmental and headphone noise and
heart rate variability: observations from Apple Hearing
Study cohort
✉
XinZhang 1,SungKyun Park1,2,Lauren M. Smith1and Richard L.Neitzel1
©TheAuthor(s)2026
BACKGROUND:Environmental noiseis linkedto adverse cardiovascular effects.However, few studieshave examinedpeople’s
heartratevariability(HRV)changesrelatedtonoisesources,despitetheelevatedcardiovascularriskassociatedwithreducedHRV.
OBJECTIVES:WeinvestigatedHRVchangesfollowingshort-andlong-termlaggedenvironmentalandheadphonesoundexposure,
assessedusing thestandard deviation of normal-to-normal intervals (SDNN). Wealso examinedeffect modification byindividual
characteristics.
METHODS:EligibleparticipantswereasubsetofconsentedadultsfromtheAppleHearingStudy,anationwideprospectivecohort.
Analyseswere constructed into four analytical cohortsdefinedby soundsource (environmental vs.headphone) andexposure
window(short-term:20minvs.long-term:160min).Ineachcohort,twentyparticipantswererandomlysampledfromeachunique
age-sex-ethnicitygroup.Smartwatchesandsmartphonesmeasuredsoundlevelsand1-minSDNNestimates.Distributedlagnon-
linearhierarchicalBayesianmodelsestimatedlag-specificandoverallchangesinfirst-stageanalyses,adjustingfortimeofdayand
physicalactivity, with randomeffects tocapture individual-specific variation. Second-stagelinear regressionmodels summarized
theaveragechangeby age,sex,BMI, stress, self-rated hearingability, and tinnitus.
RESULTS:Thestratifiedsamplingrangedfrom980to1180participantsacrossanalyses.AnoverallSDNNreductionof6.8%(short-
term)to16.0%(long-term)wasobservedfollowinga10-decibelincreaseinenvironmentalnoiseexposure,and7.1%(short-term)to
7.4%(long-term) for headphonesound. Lag-specificprediction showed briefinitial SDNNincreases followed by sustained
reductions. Greater SDNNreductions were seenin olderadults, individuals with tinnitus, or individualswhoreported excellent
hearing(for environmental noise) orthosewhoreported poor hearing (for headphonesound).
SIGNIFICANCE: Findingssuggested noise-HRVrelationships differedby exposure window, noise source,and individual
characteristics,highlightingtheimportanceofstratifiedriskassessment,especiallyintheelderlyandindividualswithhearingloss.
However, generalizabilitymay be limitedby cohort characteristics andreliance onconsumer-grade wearables.
IMPACT:Thephysiological stress associated with noiseexposure can persist from minutestohours, asreflected by decreasing
heartrate variability associated with elevated noiseexposure levels. Giventheassociation between chronically low heart rate
variabilityandhigherriskofcardiovasculardiseases,noisesource-specificriskassessmentsandnoisecontroleffortsarewarranted
forfuture studies on thenon-auditory health effects, particularlyfor vulnerable populations.
Keywords: Personal exposure;Noise pollution; Cumulative impacts; Healthstudies; Sensors
Journalof Exposure Science& Environmental Epidemiology; https://doi.org/10.1038/s41370-026-00970-8
INTRODUCTION exposurecanleadtoneuroendocrinesystemactivation,including
Epidemiological studies have shown associations between long- an imbalance in the autonomous nervous system (ANS) and
term environmental noise exposure (especially traffic noise) and stress-hormone release[6,8],whichisconsistent withthiscausal
specific forms of cardiovascular disease (CVD), including higher conceptualization.However,questionsremainregardingthereal-
prevalenceofhypertensionandischemicheartdisease[1–4].The time ANS response under varying real-life noise exposures
generalstressmodel[5,6]conceptualizesthecausalpathwayasa measured by wearable sensors in real-world, non-experimental
chainfromsoundperceptiontoannoyance,tophysiologicalstress settings.
arousal and, over time, to altered cardiovascular risk profiles [7]. Ahealthyheartcontinuouslyadjustsitsbeat-to-beatrhythmsin
Controlled laboratory exposure studies, involving both animal response to physical and psychological stress through ANS
models and human subjects, have demonstrated that noise regulation [9,10], resulting in variations inconsecutive heartbeat
1DepartmentofEnvironmentalHealthSciences,SchoolofPublicHealth,UniversityofMichigan,AnnArbor,MI,USA.2DepartmentofEpidemiology,SchoolofPublicHealth,
✉
UniversityofMichigan,AnnArbor,MI,USA. email:rneitzel@umich.edu
Received:17February2026Revised:19August2026Accepted:20August2026
:,;)(0987654321

X.Zhangetal.
2
| timeintervals.Suchvariationsarecapturedbyheartratevariability |     |     |     |     |     |     |     | Study design |     |     |     |     |     |     |     |
| ------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- |
(HRV), a widely used non-invasive indicator of ANS activity, The primary data consisted of repeated measurements nested within
|           |     |             |       |     |                 |     |         | participating | individuals. | Four | exposure | history | tables | were | constructed |
| --------- | --- | ----------- | ----- | --- | --------------- | --- | ------- | ------------- | ------------ | ---- | -------- | ------- | ------ | ---- | ----------- |
| including | the | sympathetic | (SNS) | and | parasympathetic |     | nervous |               |              |      |          |         |        |      |             |
systems(PNS)[11–13].Thisindicatorcanbequantifiedusingtime- with time-related variables: SDNN (in milliseconds, ms); sound exposure
|        |         |         |          |           |     |                     |     | (equivalentsoundlevels,L |     | EQinA-weighteddecibels,dBA);physicalactivity |     |     |     |     |     |
| ------ | ------- | ------- | -------- | --------- | --- | ------------------- | --- | ------------------------ | --- | -------------------------------------------- | --- | --- | --- | --- | --- |
| domain | indices | such as | standard | deviation |     | of normal-to-normal |     |                          |     |                                              |     |     |     |     |     |
(energyexpenditure,inunitsofkilocaloriesperhour,kcal/h);andtimeof
| heartbeat | intervals | (SDNN) | for | overall | variation, |     | or frequency- |                                                            |     |     |     |     |     |     |     |
| --------- | --------- | ------ | --- | ------- | ---------- | --- | ------------- | ---------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|           |           |        |     |         |            |     | reflecting    | day.EachrowrepresentedoneSDNNobservationwithcolumnsofsound |     |     |     |     |     |     |     |
domain indices such as high-frequency band (HF, PNS exposure history from the latest lagged interval to the earliest lagged
influenced
activities) and low-frequency band (LF, by both PNS intervaland additionalcolumnsfor covariatesand subject ID.Additional
and SNS activity and blood pressure regulation) [14]. At the individual-level variables—age, sex assigned at birth, body mass index
(BMI),self-ratedhearing,tinnitus,andperceivedstress—wereincludedfor
| population | level, | most | time- | and frequency-domain |     |     | HRV indices |     |     |     |     |     |     |     |     |
| ---------- | ------ | ---- | ----- | -------------------- | --- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
decline with age, and females generally show lower SDNN than individual-levelvariationanalysis.
| males [15, | 16]. | Overweight, | measured |     | by body | mass | index (BMI), |         |                 |       |     |                 |     |               |     |
| ---------- | ---- | ----------- | -------- | --- | ------- | ---- | ------------ | ------- | --------------- | ----- | --- | --------------- | --- | ------------- | --- |
|            |      |             |          |     |         |      |              | HRV and | time variables. | Among | HRV | indices,SDNNwas |     | selectedasthe |     |
hasalsobeenassociatedwithreducedHRV[17].Attheindividual
|            |         |     |           |         |      |       |              | primary outcome |     | for this | study because | it  | provides | a global | measure of |
| ---------- | ------- | --- | --------- | ------- | ---- | ----- | ------------ | --------------- | --- | -------- | ------------- | --- | -------- | -------- | ---------- |
| level, HRV | follows | a   | circadian | pattern | that | peaks | in the early |                 |     |          |               |     |          |          |            |
autonomicregulationthatcapturesthenetchangesfromsympathovagal
| morning | and | drops | to its | lowest | in the | late afternoon | [15]. |                |           |             |     |       |              |               |     |
| ------- | --- | ----- | ------ | ------ | ------ | -------------- | ----- | -------------- | --------- | ----------- | --- | ----- | ------------ | ------------- | --- |
|         |     |       |        |        |        |                |       | shifts without | requiring | assumptions |     | about | the relative | contributions | of  |
Reduced HRV is associated with higher stress levels in the short individual autonomic branches, and it was directly available from the
term[18]andelevatedlong-termcardiovascularriskforischemic wearable device used in this study. SDNN was recorded through 1-min
| heart disease | and | all-cause |     | mortality | [11, | 19, 20], | making it a |     |     |     |     |     |     |     |     |
| ------------- | --- | --------- | --- | --------- | ---- | -------- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
tachogramscollectedat2-to4-hintervalswhentheparticipantwasstill,a
| suitable | biomarker | for | examining |     | the acute | physiological | con- |     |     |     |     |     |     |     |     |
| -------- | --------- | --- | --------- | --- | --------- | ------------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
conditionautomaticallyevaluatedbyAppleWatch(AppleInc.,Cupertino,CA,
| sequencesof | noiseexposure. |     |     |     |     |     |     |          |                |       |       |            |         |          |            |
| ----------- | -------------- | --- | --- | --- | --- | --- | --- | -------- | -------------- | ----- | ----- | ---------- | ------- | -------- | ---------- |
|             |                |     |     |     |     |     |     | USA) via | accelerometers | [26]. | Prior | validation | studies | reported | that Apple |
Several field studies found that higher noise levels are Watch-measuredSDNNwassystematicallylowerthanthereferencevalueup
associatedwithreducedHRV–atrendconsistentwithsympathetic to 8.31ms [27, 28]. SDNN values were log-transformed to approximate a
activation–typically within a 15-min window [21–23]. Meanwhile, normaldistributionformodelfitting.Toaccountforcircadianvariationin
evidence from exercise physiology indicates that sympathetic SDNN [29], measurement time of day was categorized into morning
activation can persist for 45 to 60min following intensive (reference level, 6am-noon), afternoon (noon-5 pm), evening (5pm-9pm),
andnight(9pm-6am).
| physiological | arousal     |     | [24]; therefore, |     | it is worth | examining  | how    |                 |        |            |               |     |       |          |                   |
| ------------- | ----------- | --- | ---------------- | --- | ----------- | ---------- | ------ | --------------- | ------ | ---------- | ------------- | --- | ----- | -------- | ----------------- |
| noise-related | autonomic   |     | response         |     | changes     | beyond     | 15min. |                 |        |            |               |     |       |          |                   |
|               |             |     |                  |     |             |            |        | Noise exposure. |        | Long-term  | environmental |     | noise | exposure | was inte-         |
| Additionally, | sensitivity |     | to noise         | may | vary under  | conditions | such   |                 |        |            |               |     |       |          |                   |
|               |             |     |                  |     |             |            |        | grated as       | 20-min | A-weighted | equivalent    |     | sound | levels   | (L EQ;20min , see |
asage,hearingability,tinnitus,andperceptionofnoise;whether
|     |     |     |     |     |     |     |     | Supplementary | File | Eq. S1) | from | Environmental |     | Sound | Levels, which |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | ---- | ------- | ---- | ------------- | --- | ----- | ------------- |
andhowthenoise-HRVrelationshipmayvarybythesefactorshas
measuredambientsoundlevelsthroughdailyactivitiesusingtheNoise
notbeenexamined. application (app) on Apple Watch (Apple Inc., Cupertino, CA, USA). A
With these considerations, this study aims to address the priorvalidationstudyreportedthattheNoiseappmeasured2.1dBand
followingquestions:(1)howthechangesinSDNNvaryovertime 3.2dBlowerthanreferencevaluesundercontrolledconditions[30].This
(fortheprior120minsofnoiseexposure),and(2)howthenoise- mayresultinaconservativenoiseestimateinthisstudy,althoughother
SDNN association varies by individual characteristics. To address artifacts (e.g., microphone rubbing against fabrics, water in the watch
|     |     |     |     |     |     |     |     | without | using the | water | lock feature) | may | result | in higher | measure- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --------- | ----- | ------------- | --- | ------ | --------- | -------- |
thesequestions,weusedadistributedlagnon-linearmodelwith
ments.ForeachSDNNobservation,laggedexposureswerematchedtoit
| random | slopes | to capture | both | the | temporal | structure | of noise |              |       |           |     |          |         |        |            |
| ------ | ------ | ---------- | ---- | --- | -------- | --------- | -------- | ------------ | ----- | --------- | --- | -------- | ------- | ------ | ---------- |
|        |        |            |      |     |          |           |          | up to 160min | prior | to create | an  | exposure | history | table. | Short-term |
effectsandindividualvariationintheexposure-responserelation-
|                  |     |          |     |            |       |        |              | environmental | noise   | exposure | history  | table  | matched | 1-min | equivalent    |
| ---------------- | --- | -------- | --- | ---------- | ----- | ------ | ------------ | ------------- | ------- | -------- | -------- | ------ | ------- | ----- | ------------- |
| ship. Exposures, |     | measured | as  | equivalent | sound | levels | (L EQ), were |               | (L      |          |          |        |         |       |               |
|                  |     |          |     |            |       |        |              | sound levels  | EQ;1min | ) up     | to 20min | in the | same    | way.  | Additionally, |
examinedseparatelybysourceandtimeframe,asdetailedinthe headphone sound exposure was integrated from Headphone Audio
Methods section. Findings from this study contribute to the Levels,whichmeasuredsoundlevelswhilestreamingvideosorlistening
understanding of the temporal dynamics and individual hetero- tomusic/podcaststhroughheadphonesusingtheHealthapponiPhone
(AppleInc.,Cupertino,CA,USA).Thedistinctionbetween“environmental
| geneity | in the | autonomic | response |     | associated | with | real-world |            |            |        |     |       |        |            |          |
| ------- | ------ | --------- | -------- | --- | ---------- | ---- | ---------- | ---------- | ---------- | ------ | --- | ----- | ------ | ---------- | -------- |
|         |        |           |          |     |            |      |            | noise” and | “headphone | sound” | is  | based | on the | assumption | that the |
noiseexposure.
|     |     |     |     |     |     |     |     | majority | of ambient | sound       | exposure | (e.g.,  | traffic, | construction) | is             |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ---------- | ----------- | -------- | ------- | -------- | ------------- | -------------- |
|     |     |     |     |     |     |     |     | unwanted | and thus   | constitutes | the      | “noise” | (aligns  | with          | the definition |
fromtheUnitedStatesEnvironmentalProtectionAgency[31]),whereas
METHODS
|     |     |     |     |     |     |     |     | headphone-delivered |     | sounds | are | predominantly |     | voluntary | and self- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------- | --- | ------ | --- | ------------- | --- | --------- | --------- |
Study population selected.Weacknowledgethatinpractice,thereisamixofwantedand
This analysis extracted observational data from consented adults unwanted sound in both categories. Nevertheless, this distinction is
enrolled in an ongoing nationwide prospective cohort from November madetoreflectthedifferentialroleofannoyance–akeycomponentin
6]–whereinvoluntary
2019 to December 2024, the overall cohort described in Neitzel et al. thegeneralstressmodel[5, environmentalnoise
[25]. All study protocols were reviewed and approved by the IRB may be more likely to trigger annoyance and subsequent stress
(Advarra, Inc, approval number Pro00037864). To be eligible in this responsesthanvoluntaryheadphoneuse.
| analysis, | participants | had | (1) | consent | to enable | and | share their |     |     |     |     |     |     |     |     |
| --------- | ------------ | --- | --- | ------- | --------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
Headphone Audio Levels (HAL) or Environmental Sound Levels (ESL) Activity covariate. To adjust for activity intensity level and heart rate,
and HRV measurement features through their iPhone; (2) contribute at whichareknownfactorstoaffectSDNN[23,32],wecalculatedconcurrent
least 20 consecutive SDNN measurements; (3) complete a baseline 5-minactiveenergyexpenditureandincludeditasacontrolvariableinthe
demographic (i.e., identified age, sex assigned at birth, ethnicity) and Apple’s
|     |     |     |     |     |     |     |     | mainmodels. | This | was derivedfrom |     |     | calorimetry | algorithms | [26], |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ---- | --------------- | --- | --- | ----------- | ---------- | ----- |
hearing status (self-reported hearing ability and tinnitus occurrence) which consider heart rate to inform activity intensity along with other
surveywithinoneweekofenrollment. variables such as age, sex, weight, and motion-related signals. The
stratified
We implemented a random sampling strategy due to valuewaslog-transformedtomatchtheoutcome’s numericscaleinthe
| demographic  | representativeness |            |      | and    | model             | computation | feasibility. | models. |     |     |     |     |     |     |     |
| ------------ | ------------------ | ---------- | ---- | ------ | ----------------- | ----------- | ------------ | ------- | --- | --- | --- | --- | --- | --- | --- |
| Participants | were               | classified | into | unique | age-sex-ethnicity |             | groups       |         |     |     |     |     |     |     |     |
(60 strata from six age groups × two sexes × five ethnicity categories Individual-level variables.
|     |     |     |     |     |     |     |     |     |     |     | Participants | provided | demographic |     | data and |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------ | -------- | ----------- | --- | -------- |
listed in Table 1). Twenty participants were drawn from each stratum completedsurveysonhearingandstress.Weight(inkilograms),height(in
fixed
using simple random sampling without replacement. A random centimeters),self-ratedhearingability(fivelevels,i.e.,excellent,verygood,
seedwassettoensurereproducibility.Stratawithfewerthan20eligible good,fair,poor),andtinnitusfrequency(fivelevels,i.e.,never,afewtimes
| participants | were | excluded; | in  | practice, | this | affected | predominantly |     |     |     |     |     |     |     |     |
| ------------ | ---- | --------- | --- | --------- | ---- | -------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
ayear/month/week/day)werecollectedatbaseline.BMIwascalculatedas
older participants. The inclusion process is demonstrated in Supple- weight=height2, and categorized into underweight, normal, overweight,
mentaryFileFig.S1. andclass1to3obesitybasedontheWorldHealthOrganizationguidance
JournalofExposureScience&EnvironmentalEpidemiology

X.Zhangetal.
3
Table1. Participantcharacteristicsbynoisetypeandexposureduration,summarizedintocountsandpercentages.
|              | EnvironmentalNoise |           | HeadphoneSound |           |
| ------------ | ------------------ | --------- | -------------- | --------- |
| Demographics | Short-term         | Long-term | Short-term     | Long-term |
|              | N=1180             | N=1180    | N=1080         | N=980     |
Age
| 18≤age<25 | 200 16.9% | 200 16.9% | 180 16.7% | 140 14.3% |
| --------- | --------- | --------- | --------- | --------- |
| 25≤age<35 | 200 16.9% | 200 16.9% | 200 18.5% | 200 20.4% |
| 35≤age<45 | 200 16.9% | 200 16.9% | 200 18.5% | 180 18.4% |
| 45≤age<55 | 200 16.9% | 200 16.9% | 200 18.5% | 180 18.4% |
| 55≤age<65 | 200 16.9% | 200 16.9% | 180 16.7% | 180 18.4% |
| age≥65    | 180 15.3% | 180 15.3% | 120 11.1% | 100 10.2% |
AssignedSex
| Female | 580 49.2% | 580 49.2% | 480 44.4% | 420 42.9% |
| ------ | --------- | --------- | --------- | --------- |
| Male   | 600 50.8% | 600 50.8% | 600 55.6% | 560 57.1% |
Ethnicity
Non-HispanicWhitealone 240 20.3% 240 20.3% 240 22.2% 240 24.5%
Non-HispanicAsianalone 220 18.6% 220 18.6% 200 18.5% 120 12.2%
Non-HispanicBlackalone 240 20.3% 240 20.3% 200 18.5% 180 18.4%
| Hispanic    | 240 20.3% | 240 20.3% | 220 20.4% | 220 22.4% |
| ----------- | --------- | --------- | --------- | --------- |
| Multiethnic | 240 20.3% | 240 20.3% | 220 20.4% | 220 22.4% |
BMIClass
| Underweight   | 22 1.9%   | 26 2.2%   | 21 1.9%   | 20 2.0%   |
| ------------- | --------- | --------- | --------- | --------- |
| Healthy       | 369 31.3% | 362 30.7% | 335 31.0% | 284 29.0% |
| Overweight    | 384 32.5% | 393 33.3% | 355 32.9% | 315 32.1% |
| Class1Obesity | 201 17.0% | 201 17.0% | 181 16.8% | 163 16.6% |
| Class2Obesity | 102 8.6%  | 96 8.1%   | 94 8.7%   | 92 9.4%   |
| Class3Obesity | 82 6.9%   | 83 7.0%   | 78 7.2%   | 89 9.1%   |
| Missing       | 20 1.7%   | 19 1.6%   | 16 1.5%   | 17 1.7%   |
StressScore
0≤score<2
|           | 164 13.9% | 174 14.7% | 170 15.7% | 144 14.7% |
| --------- | --------- | --------- | --------- | --------- |
| 2≤score<4 | 220 18.6% | 224 19.0% | 186 17.2% | 163 16.6% |
4≤score<6
|           | 228 19.3% | 225 19.1% | 204 18.9% | 194 19.8% |
| --------- | --------- | --------- | --------- | --------- |
| 6≤score<8 | 205 17.4% | 206 17.5% | 201 18.6% | 178 18.2% |
8≤score<10
|             | 181 15.3% | 176 14.9% | 159 14.7% | 141 14.4% |
| ----------- | --------- | --------- | --------- | --------- |
| 10≤score<12 | 102 8.6%  | 99 8.4%   | 88 8.1%   | 90 9.2%   |
score≥12
|         | 71 6.0% | 68 5.8% | 65 6.0% | 66 6.7% |
| ------- | ------- | ------- | ------- | ------- |
| Missing | 9 0.8%  | 8 0.7%  | 7 0.6%  | 4 0.4%  |
HearingAbility
| Excellent | 225 19.1% | 225 19.1% | 204 18.9% | 177 18.1% |
| --------- | --------- | --------- | --------- | --------- |
| Verygood  | 395 33.5% | 402 34.1% | 373 34.5% | 333 34.0% |
| Good      | 346 29.3% | 344 29.2% | 308 28.5% | 282 28.8% |
| Fair      | 169 14.3% | 163 13.8% | 150 13.9% | 141 14.4% |
| Poor      | 45 3.8%   | 46 3.9%   | 45 4.2%   | 47 4.8%   |
TinnitusOccurrence
| Never           | 276 23.4% | 276 23.4% | 261 24.2% | 230 23.5% |
| --------------- | --------- | --------- | --------- | --------- |
| Afewtimesayear  | 431 36.5% | 423 35.8% | 388 35.9% | 325 33.2% |
| Afewtimesamonth | 172 14.6% | 179 15.2% | 157 14.5% | 170 17.3% |
| Afewtimesaweek  | 111 9.4%  | 111 9.4%  | 119 11.0% | 103 10.5% |
| Afewtimesaday   | 190 16.1% | 191 16.2% | 155 14.4% | 152 15.5% |
[33]. Four weeks after enrollment, stress was self-rated using a 4-item consistentwithSchäferetal.[36]andIngrametal.[37].Bothone-andtwo-
PerceivedStressScale(PSS-4)scaledfrom0(loweststress)to16(highest factormodelswereusedinsubsequentanalysesforcomparison;however,
stress) [34, 35]. Confirmatory factor analysis supported a two-factor only one-factor model results were presented here for simplicity—two-
structure for stress (helplessness and coping, each scale from 0 to 8), factormodelresultsweresimilar.
JournalofExposureScience&EnvironmentalEpidemiology

X.Zhangetal.
4
Statistical analysis noise-SDNNvisualization,whileindividual-leveloverallchangeswereused
briefly
We describe our methodology below; additional details are forthenextstepanalysis.
| provided | in the Supplemental |     | File.    | The        | same modeling | process   | was        |                  |     |            |     |     |     |     |     |
| -------- | ------------------- | --- | -------- | ---------- | ------------- | --------- | ---------- | ---------------- | --- | ---------- | --- | --- | --- | --- | --- |
| repeated | for four analytical |     | cohorts. | All models | used          | identical | specifica- |                  |     |            |     |     |     |     |     |
|          |                     |     |          |            |               |           |            | Individual-level |     | variations |     |     |     |     |     |
tionsandprocedures.
|     |     |     |     |     |     |     |     | The | second | stage analysis | calculated | the | marginal | mean | and 95% |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ | -------------- | ---------- | --- | -------- | ---- | ------- |
AllanalyseswereconductedusingR(v4.5.0;RFoundationforStatistical confidentintervalbyagegroups,sex,BMIcategory,stressscore,hearing
Computing,Vienna,Austria)[38].Distributedlagmodelswereimplemen-
ted using dlnm (v2.4.7) package [39]. Hierarchical Bayesian models were status and tinnitus frequency using the simple linear regression models
|     |     |     |     |     |     |     |     | (Eq. | 1) conditional | on five | noise levels | (i.e., | L at | 30, 50, 60, | 70, and 80 |
| --- | --- | --- | --- | --- | --- | --- | --- | ---- | -------------- | ------- | ------------ | ------ | ---- | ----------- | ---------- |
implementedusingthebrms(v2.22.0)package[40].Marginalmeanswere EQ
dBA),respectively:
implementedusingtheemmeans(v1.11.0)package[41].
|     |     |     |     |     |     |     |     | r i | ¼α þα | 1Agei þα 2Sexi þα | 3BMIi þα | 4Stressi þα | 5Hearingi | þα 6Tinnitusi | þϵ i |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | ----------------- | -------- | ----------- | --------- | ------------- | ---- |
0
| Exposure-lag-response |     |     | models |     |     |     |     |     |     |     |     |     |     |     | (1) |
| --------------------- | --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Foreachexposurehistorytable,weappliedahierarchicalBayesianmodel
withdistributedlagnon-linearterms[42–44]toestimateassociationswith
|                  |            |     |         |            |                |        |              | wherer | wasthepercentchanges(%)inSDNNintheposteriorprediction |             |      |             |     |           |         |
| ---------------- | ---------- | --- | ------- | ---------- | -------------- | ------ | ------------ | ------ | ----------------------------------------------------- | ----------- | ---- | ----------- | --- | --------- | ------- |
| lagged sound     | exposures. | We  | assumed | that       | the noise-SDNN |        | relationship |        | i                                                     |             |      |             |     |           |         |
|                  |            |     |         |            |                |        |              | from   | Bayesian                                              | models (Eq. | S2). | We compared | the | estimated | percent |
| was time-varying | due        | to  | instant | regulation | activity       | in the | autonomic    |        |                                                       |             |      |             |     |           |         |
nervoussysteminresponsetopreviousexposuresoractivities[23],soa changes(%)atdifferentlevelsofasinglevariablewhenexposedtosame
LEQ
distributed lag model was more appropriate than a simple linear and holding other variables constant. For model simplicity, the
uncertaintywasnotpropagatedfromtheBayesianmodels(Eq.S2)tothe
| regression, | given that | previous | events | have | a carryover | effect | on how |              |     |                |            |     |          |           |             |
| ----------- | ---------- | -------- | ------ | ---- | ----------- | ------ | ------ | ------------ | --- | -------------- | ---------- | --- | -------- | --------- | ----------- |
|             |            |          |        |      |             |        |        | second-stage |     | model (Eq. 1); | the impact | of  | which is | discussed | later. Less |
thecurrenteventwillchangetheoutcome.Thelaggednoiseexposurewas
constructedasthe“crossbasis”functionfromdlnm(Eq.7inGasparrinietal. than 2% of participants have missing BMI or stress scores, and the
[45]). Models alsoincludedthe concurrent activity covariateand time of missingness appears to be at random; therefore, the regression models
| dayascontrolvariables. |     |           |        |        |           |     |          | wereconductedoncompletecases. |     |     |     |     |     |     |     |
| ---------------------- | --- | --------- | ------ | ------ | --------- | --- | -------- | ----------------------------- | --- | --- | --- | --- | --- | --- | --- |
| The hierarchical       |     | structure | of our | models | accounted | for | repeated |                               |     |     |     |     |     |     |     |
measures withinindividuals and includedrandomintercepts and slopes. Ethicalapproval
This design allows us to capture between-subject variation in baseline AllanalysesusingdatafromtheAppleHearingStudywereperformedin
| SDNN and | noise-SDNN | relationships |     | and | to account | for time-invariant |     |            |     |               |            |                      |     |     |           |
| -------- | ---------- | ------------- | --- | --- | ---------- | ------------------ | --- | ---------- | --- | ------------- | ---------- | -------------------- | --- | --- | --------- |
|          |            |               |     |     |            |                    |     | accordance |     | with relevant | guidelines | and recommendations. |     |     | The Apple |
confounders that were not directly measured (e.g., smoking, alcohol HearingStudywasapprovedbyAdvarra’sInstitutionalReviewBoard(IRB;
consumption, and pre-existing conditions). Residual confounding from Approval Number: Pro00037864). All participants provided informed
acutetime-varyingbehaviorssuchasepisodicalcohol,caffeineintake,or consentelectronicallypriortoenrollmentintheAppleHearingStudy.
| sleep status   | may         | bias estimates |              | in either | direction,   | which | remains a  |     |     |     |     |     |     |     |     |
| -------------- | ----------- | -------------- | ------------ | --------- | ------------ | ----- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
| limitation.    | Intra-class | correlation    | coefficients |           | (ICC) showed | 33    | to 40% of  |     |     |     |     |     |     |     |     |
| model variance | due         | to             | individual   | baseline  | differences, |       | suggesting |     |     |     |     |     |     |     |     |
RESULTS
| moderate-to-good |         | clustering | and | supporting | the     | use of        | hierarchical |             |            |           |                  |     |       |          |        |
| ---------------- | ------- | ---------- | --- | ---------- | ------- | ------------- | ------------ | ----------- | ---------- | --------- | ---------------- | --- | ----- | -------- | ------ |
|                  |         |            |     |            |         |               |              | Descriptive |            | summaries |                  |     |       |          |        |
| modeling.        | We used | 2 degrees  | of  | freedom    | for the | natural cubic | spline       |             |            |           |                  |     |       |          |        |
|                  |         |            |     |            |         |               |              | Four        | analytical | cohorts   | were constructed |     | based | on sound | source |
basis,chosentocapturetheessentialnon-linearstructurewiththefewest
parametersandtoavoidoverfitting.Adescriptionofmodelspecifications (environmentalvs.headphone)andexposurewindow(short-term
andpriorsettingsisincludedintheSupplementaryFile. vs. long-term). For environmental noise analyses, 59 unique
Theposteriorbaselinelog-SDNNestimatesofthestudypopulationfor demographic combinations yielded a stratified sample of 1180
morning, afternoon, evening, and night were calculated at a reference participants each (Table 1) from 49,983 (short-term) and 47,339
exposurelevelof40dBA–representativeofaquietenvironmentsuchasin
(long-term)eligibleparticipants(SupplementaryFileTableS1).The
| a library–and | at the | median | level | of observed | log-activity |     | level, then |           |     |                |          |     |     |           |            |
| ------------- | ------ | ------ | ----- | ----------- | ------------ | --- | ----------- | --------- | --- | -------------- | -------- | --- | --- | --------- | ---------- |
|               |        |        |       |             |              |     |             | headphone |     | sound datasets | included | 54  | and | 49 strata | for short- |
transformedbacktomillisecondsandsummarizedasthemedianwitha
|     |     |     |     |     |     |     |     | and | long-term | headphone | models, | respectively, |     | resulting | in a |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | --------- | ------- | ------------- | --- | --------- | ---- |
95%credibleinterval.
|             |     |                  |     |           |                  |     |             | sample |     | of 1080 from 19,006 |     | (short-term) | and | 980 from | 10,726 |
| ----------- | --- | ---------------- | --- | --------- | ---------------- | --- | ----------- | ------ | --- | ------------------- | --- | ------------ | --- | -------- | ------ |
| Population- | and | individual-level |     | posterior | effect estimates |     | at multiple |        |     |                     |     |              |     |          |        |
exposure levels (i.e., L from 30 to 80 dBA by 1dB increment) were (long-term) eligible participants. Excluded strata were kept for
EQ
computed using the crosspred function [39] from dlnm with posterior sensitivity analysis. The sampling pool for headphone data was
samplefixed effectcoefficients and the sum of fixed and randomeffect lessthanhalfthesizeofthatoftheenvironmentaldata,partially
coefficientsforsound,respectively.Theestimateswerepresentedasthe due to limited headphone use over a day. Despite differences in
posteriorsamplemedianofthepercentchanges(%)inSDNN(r
|     |     |     |     |     |     |     | i)ateach | samplesize,thefouranalyticalcohortshadsimilardistributionsof |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------------------------------------------------------------ | --- | --- | --- | --- | --- | --- | --- |
lagataspecificexposurelevelrelativetothereferenceSDNNsat40dBA.
|     |     |     |     |     |     |     |     | self-reported |     | stress, hearing | ability,and |     | tinnitus | occurrence. |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | --------------- | ----------- | --- | -------- | ----------- | --- |
Theoverallchangewasthesumofalllag-specificchangesovertheentire
|                |            |     |         |          |          |            |           |     | For time-related | variables | (Table | 2), | median | 1-min | and 20-min |
| -------------- | ---------- | --- | ------- | -------- | -------- | ---------- | --------- | --- | ---------------- | --------- | ------ | --- | ------ | ----- | ---------- |
| lagged period, | calculated |     | at each | specific | exposure | level. The | predicted |     |                  |           |        |     |        |       |            |
lag-specific averageheadphonesoundlevels(66.4and68.4dBA)werehigher
| population-level | overall | changes | and |     | changes | were | used for |     |     |     |     |     |     |     |     |
| ---------------- | ------- | ------- | --- | --- | ------- | ---- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
Table2. Descriptivesummaryforthreetime-relatedvariablesand thenumberofobservations ineachanalyticalcohort.
|           |     |     | EnvironmentalNoise |     |     |     |           |     |     | HeadphoneSound |     |     |           |     |     |
| --------- | --- | --- | ------------------ | --- | --- | --- | --------- | --- | --- | -------------- | --- | --- | --------- | --- | --- |
| Variables |     |     | Short-term         |     |     |     | Long-term |     |     | Short-term     |     |     | Long-term |     |     |
|           |     |     | N=361,629          |     |     |     | N=293,144 |     |     | N=160,389      |     |     | N=162,913 |     |     |
LEQ(dBA) 52.3(43.2,61.2) 62.0(54.2,68.4) 66.4(58.3,73.9) 68.4(60.8,75.0)
SDNN(ms) 27.4(17.0,46.8) 27.3(16.8,47.1) 29.8(19.8,45.3) 29.7(19.7,45.8)
Activity(kcal/h) 27.7(19.3,41.3) 28.0(19.5,41.8) 29.4(19.8,46.2) 31.5(21.3,49.4)
TimeofDay
Morning 91,555 (25.3%) 82,369 (28.1%) 39,094 (24.4%) 35,488 (21.8%)
Afternoon 89,306 (24.7%) 74,878 (25.5%) 44,720 (27.9%) 36,676 (22.5%)
Evening 75,946 (21.0%) 64,577 (22.0%) 29,604 (18.5%) 34,059 (20.9%)
Night 104,822 (29.0%) 71,320 (24.3%) 46,961 (29.3%) 56,690 (34.8%)
Variablesaresummarizedasmedian(1stquantile,3rdquantile)orn(%).
JournalofExposureScience&EnvironmentalEpidemiology

X.Zhangetal.
5
than those of environmental noise levels (52.3 and 62.0 dBA). environmental noise level was elevated to 50 dBA, with smaller
Median 1-min SDNN was 27.42 and 27.26ms in environmental contribution from earlier exposures (Fig. 1b), and a net overall
noise cohorts and 29.80 and 29.67ms in headphone cohorts, reductionof 16.0[13.5, 18.3]%(Fig. 2a,blue line).
respectively. The 5-min active energy expenditure followed the ThepredictedSDNNchangesintheheadphonesoundmodels
same pattern: 27.72 and 28.01kcal/h in environmental cohorts followed a slightly different temporal pattern. There was a
|     |     |     |     |     |     | 0.1–0.2% |     |     |     | first |     |     |     |
| --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | ----- | --- | --- | --- |
versus29.41 and 31.46kcal/h inheadphonecohorts. increase during the 3min, followed by no changes
0.1–0.9%
|     |     |     |     |     |     | during the | third | and fourth | minutes |     | and an | eventual |     |
| --- | --- | --- | --- | --- | --- | ---------- | ----- | ---------- | ------- | --- | ------ | -------- | --- |
Exposure-lag-response trends at the population level reductionafter 5min(Fig.3a),with anetoverall reductionof 7.1
ThepredictedmorningSDNNvaluesinmedianwith95%credible [5.0, 9.0] % at 50 dBA (Fig. 2b, red line). The prediction from the
interval at the reference condition (40 dBA, median log-activity), long-term headphone sound model showed initial SDNN reduc-
flattened
were37.5[28.7,48.8]ms,35.9[27.0,47.7]ms,39.7[29.3,47.4]ms, tions by 1.4 [0.4, 2.5] % but the changes toward zero
(–0.5 [–1.6,
and 32.7 [25.5, 41.8] ms for the short-term environmental noise, 0.5] %) in the last 20-min lag (Fig. 3b) and the net
|     |     |     |     |     |     |     |     | –7.4 | [–9.9, | –4.9] |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---- | ------ | ----- | --- | --- | --- |
long-termenvironmentalnoise,short-termheadphonesound,and overall changes were % at 50 dBA (Fig. 2b, blue
| long-term | headphone | sound exposure | cohorts | (Supplementary |     | line). |     |     |     |     |     |     |     |
| --------- | --------- | -------------- | ------- | -------------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
File,TableS2). Insensitivityanalysesrestrictedtoexcludedstrata(Supplemen-
Compared to the simple moving average models commonly tary File, Table S5), predicted morning SDNN at the reference
usedinotherliteraturefortimeseriesanalysis,thedistributedlag condition was slightly lower (median 29.58 to 36.24ms) than in
model does not assume the effect from a time further away the included population, as expected given their older age. The
contributesequallytotheresponseasmorerecentexposures[45, noise-SDNN pattern—a brief increase followed by a sustained
46]andallowstime-varyingexposure-responserelationshipstobe reduction—was consistent with that in the included population,
plotted on a bi-dimensional surface (Supplementary File Fig. S2). withno meaningfuldifferences in themagnitude ofchange.
Figure 1 shows the SDNN percent changes predicted at each Looking at the predicted overall changes across all exposure
soundleveland timelagrelative tothebaseline levelat40dBA. levels(Fig.2),greaterreductionswereobservedwithelevatedL EQ,
With environmental L elevated from 40 dBA to 50 dBA, for except that short-term environmental noise exposure showed a
EQ
example, we observed median 0.2–0.7% increases in SDNN from slightly U-shaped curve, with the largest reduction of 10.4 [8.1,
each 1-min lag during the initial 6-min window. No meaningful 12.7]%around60dBA.Thisturningpointliesclosetothe65dBA
changes were observed around 7–8min while reductions cut-off value reported in Kraus et al. 2013, where they observed
(0.2–1.4%) emerged from 8 to 20min (Fig. 1a), resulting in a net different noise-SDNN associations. The attenuated reduction at
overallreductionof6.8[5.1,8.4]%at50dBA(Fig.2a,redline).In thehighshort-term levels may relate to fewerdata points at the
comparison, the prediction showed consistent reductions upperendoftheexposurerange.Theoverallreductionwas27.4
(1.4–2.9%) in SDNN across the 160-min lag window when [24.1, 30.4] % at 60dBA for long-term exposures, more thantwo
timesthatofshort-termexposures.Forheadphonesoundmodels,
|     |     |     |     |     |     | short- and | long-term | overall | changes |     | were similar, | linked | to 14.3 |
| --- | --- | --- | --- | --- | --- | ---------- | --------- | ------- | ------- | --- | ------------- | ------ | ------- |
(a) Short-term Environmental Noise  [11.3, 17.0] % and 14.6 [11.0, 18.1] % predicted reduction at 60
dBA,respectively.
|                    | 5   |     |     |     | 0-1min |                                                            |             |        |       |           |         |             |          |
| ------------------ | --- | --- | --- | --- | ------ | ---------------------------------------------------------- | ----------- | ------ | ----- | --------- | ------- | ----------- | -------- |
|                    |     |     |     |     | 1-2min | The HMC                                                    | diagnostics |        | [47]  | indicated | good    | convergence | and      |
|                    |     |     |     |     | 2-3min | chainmixingforallfourBayesianmodels:allR^<1.01(convergence |             |        |       |           |         |             |          |
| )%( egnahC tnecreP |     |     |     |     | 3-4min |                                                            |             |        |       |           |         |             |          |
|                    |     |     |     |     | 4-5min | indicator),                                                | effective   | sample | sizes | were      | greater | than 10%    | of post- |
5-6min
0 6-7min warm-upiterations,andvisualinspectionoftraceplotsshowedno
7-8min
|     |     |     |     |     | 8-9min | concerning | patterns | among | the | chains. | Q-Q | plots showed | slight |
| --- | --- | --- | --- | --- | ------ | ---------- | -------- | ----- | --- | ------- | --- | ------------ | ------ |
9-10min
|     |     |     |     |     | 10-11min | deviation | from | normality | at each | end | and were | not | sensitive to |
| --- | --- | --- | --- | --- | -------- | --------- | ---- | --------- | ------- | --- | -------- | --- | ------------ |
-5 11-12min alternativepriors.ConditionalR2valuesmeasuretheproportionof
12-13min
|     |     |     |     |     | 13-14min | variance | explained | by  | both noise | exposure |     | levels and | variation |
| --- | --- | --- | --- | --- | -------- | -------- | --------- | --- | ---------- | -------- | --- | ---------- | --------- |
14-15min
|     |     |     |     |     | 15-16min | across individuals |     | combined, |     | and were | 0.609 | (95% | CI: [0.608, |
| --- | --- | --- | --- | --- | -------- | ------------------ | --- | --------- | --- | -------- | ----- | ---- | ----------- |
16-17min
|     |       |       |     |     | 17-18min | 0.611]),0.621[0.619,0.622],0.431[0.429,0.435],and0.441[0.438, |            |     |                |     |           |                |     |
| --- | ----- | ----- | --- | --- | -------- | ------------------------------------------------------------- | ---------- | --- | -------------- | --- | --------- | -------------- | --- |
|     | -10   |       |     |     | 18-19min |                                                               |            |     |                |     |           |                |     |
|     |       |       |     |     | 19-20min | 0.443] for                                                    | short-term |     | environmental, |     | long-term | environmental, |     |
|     | 30 40 | 50 60 | 70  | 80  |          |                                                               |            |     |                |     |           |                |     |
Noise Level (dB) short-term headphone, and long-term headphone models,
|     |     |     |     |     |     | respectively. | Marginal  |     | R2 values      | measure |          | the proportion | of         |
| --- | --- | --- | --- | --- | --- | ------------- | --------- | --- | -------------- | ------- | -------- | -------------- | ---------- |
|     |     |     |     |     |     | variance      | explained | by  | noise exposure |         | only and | were           | 0.007 (95% |
(b) Long-term Environmental Noise
|     |     |     |     |     |     | CI: [0.007,   | 0.008]), | 0.015 | [0.013,  | 0.017], | 0.018         | [0.015, | 0.019], and |
| --- | --- | --- | --- | --- | --- | ------------- | -------- | ----- | -------- | ------- | ------------- | ------- | ----------- |
|     |     |     |     |     |     | 0.013 [0.011, | 0.015]   | for   | the four | models, | respectively. |         | The small   |
5
|     |     |     |     |      |     | marginal   | R2 indicated |            | that the | noise        | exposure | alone    | explains a  |
| --- | --- | --- | --- | ---- | --- | ---------- | ------------ | ---------- | -------- | ------------ | -------- | -------- | ----------- |
|     |     |     |     | Lags |     | relatively | small        | proportion | of       | the variance |          | in SDNN. | Intra-class |
)%( egnahC tnecreP
correlationcoefficient(ICC)furthermeasuresthevariationdueto
0-20min
0 20-40min individualdifferences.ICCforrandominterceptrangedfrom0.33
|     |     |     |     |     | 40-60min | to0.40consistently(Table3),showingmoderate-to-goodcluster- |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | -------- | ---------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
60-80min
|     |     |     |     |     |     | ing by individuals |     | and | supporting | the | inclusion | of an | individual- |
| --- | --- | --- | --- | --- | --- | ------------------ | --- | --- | ---------- | --- | --------- | ----- | ----------- |
80-100min
-5 100-120min specific intercept to avoid underestimating uncertainty. The total
|     |     |     |     |     | 120-140min | ICC (i.e., | including | both | random | intercept |     | and random | slope) |
| --- | --- | --- | --- | --- | ---------- | ---------- | --------- | ---- | ------ | --------- | --- | ---------- | ------ |
140-160min
|     |     |     |     |     |     | significantly | increased |     | in long-term |     | exposure-response |     | models, |
| --- | --- | --- | --- | --- | --- | ------------- | --------- | --- | ------------ | --- | ----------------- | --- | ------- |
justifyingtheinclusionofindividual-specificsound-HRVresponses
-10
|     |       |       |       |     |     | insteadof | assuming | universaleffects |     |     | across | individuals. |     |
| --- | ----- | ----- | ----- | --- | --- | --------- | -------- | ---------------- | --- | --- | ------ | ------------ | --- |
|     | 30 40 | 50 60 | 70 80 |     |     |           |          |                  |     |     |        |              |     |
Noise Level (dB)
|     |     |     |     |     |     | Overallresponses |     | variation |     | atthe individual |     | level |     |
| --- | --- | --- | --- | --- | --- | ---------------- | --- | --------- | --- | ---------------- | --- | ----- | --- |
Fig.1 Predictedmedianlag-specificpercentchanges(%)inSDNN
|      |               |                  |           | reflect |         | Individual-specificoverallSDNNchangesinmedian,derivedfrom |               |     |           |       |     |        |             |
| ---- | ------------- | ---------------- | --------- | ------- | ------- | --------------------------------------------------------- | ------------- | --- | --------- | ----- | --- | ------ | ----------- |
| from | environmental | noise exposures. | Estimates |         | percent |                                                           |               |     |           |       |     |        |             |
|      |               |                  |           |         |         | posterior                                                 | distributions |     | with both | fixed | and | random | effects for |
changesinSDNNrelativetopredictedSDNNat40dBA.aEstimatesfor
short-term environmental noise exposure. b Estimates for long-term sound,weresummarizedintomeanand95%CIacrossparticipant
environmentalnoiseexposure. characteristics (Supplementary File, Tables S3 and S4). We
JournalofExposureScience&EnvironmentalEpidemiology

X.Zhangetal.
6
Fig.2 Predictedmedianoverallpercentchange(%)inSDNNacrossnoiselevelsfromshort-andlong-termexposuregroups,withshaded
area representing 95% credible interval. Estimates reflect percent changes in SDNN relative to predicted SDNN at 40 dBA. a Estimates for
environmentalnoiseexposure.bEstimatesforheadphonesoundexposure.
|     |     |     |     |     |     | that of the | youngest | group | (13.8 | [11.6, | 15.9] | %). Both | predicted |
| --- | --- | --- | --- | --- | --- | ----------- | -------- | ----- | ----- | ------ | ----- | -------- | --------- |
(a) Short-term Headphone Sound trends showed older individuals having more drastic changes in
|     |     |     |     |     |     | both directions. |     | Compared | to the | healthy | weight | group, | higher |
| --- | --- | --- | --- | --- | --- | ---------------- | --- | -------- | ------ | ------- | ------ | ------ | ------ |
5 0-1min BMI was also associated with larger percent changes in both
1-2min
|     |     |     |     |     | 2-3min | directions.Forinstance,Class3obesityhadachangeby23.9[21.0, |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | ------ | ---------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
)%( egnahC tnecreP 3-4min 26.8] % at 30 dBA and –29.6 [–31.8, –27.3] % at 60 dBA, the
4-5min
0 5-6min absolutevalueswerelargerthanthosewithhealthyweight(18.3
6-7min
|     |     |     |     |     | 7-8min | [16.7, 19.9] | % at | 30 dBA | and –24.9 | [–26.1, | –23.6] | %   | at 60 dBA). |
| --- | --- | --- | --- | --- | ------ | ------------ | ---- | ------ | --------- | ------- | ------ | --- | ----------- |
8-9min
|     |     |     |     |     | 9-10min | Similar differences |     | were | observed | in Class | 1 and | Class | 2 obesity |
| --- | --- | --- | --- | --- | ------- | ------------------- | --- | ---- | -------- | -------- | ----- | ----- | --------- |
10-11min
|     |     |     |     |     | 11-12min | between30dBAand70dBA.TheassociationbetweenSDNNand |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | -------- | ------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
-5
|     |     |     |     |     | 12-13min | noisewasnotdifferentbysexorstresslevel.Although,compared |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | -------- | -------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
13-14min
|     |     |     |     |     | 14-15min | to a moderate | stress | level | (scored | between | 6   | to 8), higher | stress |
| --- | --- | --- | --- | --- | -------- | ------------- | ------ | ----- | ------- | ------- | --- | ------------- | ------ |
15-16min
|     |     |     |     |     | 16-17min | (scorebetween8to12)showedaslightlylargerrelativereduction |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | -------- | --------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
17-18min
| -10 |     |     |     |     | 18-19min | giventhesame | exposure |     | levelchanges. |     |     |     |     |
| --- | --- | --- | --- | --- | -------- | ------------ | -------- | --- | ------------- | --- | --- | --- | --- |
19-20min
30 40 50 60 70 80 ThepredictedSDNNchangesdifferedacrosslevelsofself-rated
Noise Level (dB)
|     |     |     |     |     |     | hearing ability | at  | exposures   | of      | 70 dBA | and       | above. | At 70 dBA, |
| --- | --- | --- | --- | --- | --- | --------------- | --- | ----------- | ------- | ------ | --------- | ------ | ---------- |
|     |     |     |     |     |     | participants    | who | rated their | hearing | as     | excellent | (–35.4 | [–37.4,    |
(b) Long-term Headphone Sound
|     |     |     |     |     |     | –33.4] %) | exhibited    | a      | 4.9% greater |        | change | than  | those who |
| --- | --- | --- | --- | --- | --- | --------- | ------------ | ------ | ------------ | ------ | ------ | ----- | --------- |
|     |     |     |     |     |     | reported  | poor hearing | (–30.5 | [–34.3,      | –26.7] | %).    | At 80 | dBA, the  |
5
|     |     |     |     |      |     | estimated | differencewas |            | evengreater |        | (13.1%). |         |      |
| --- | --- | --- | --- | ---- | --- | --------- | ------------- | ---------- | ----------- | ------ | -------- | ------- | ---- |
|     |     |     |     | Lags |     | Reporting | tinnitus      | occurrence |             | showed | greater  | changes | com- |
)%( egnahC tnecreP
|     |     |     |     |     | 0-20min | pared to participants |     | who | never | had tinnitus. |     | For example, | at 60 |
| --- | --- | --- | --- | --- | ------- | --------------------- | --- | --- | ----- | ------------- | --- | ------------ | ----- |
0
|     |     |     |     |     | 20-40min | dBA, participants |     | whose | tinnitus | happened | a   | few times | a year |
| --- | --- | --- | --- | --- | -------- | ----------------- | --- | ----- | -------- | -------- | --- | --------- | ------ |
40-60min
(–28.1[–29.5,–26.7]%),orafewtimesaday(–28.3[–30.0,–26.7]
60-80min
|     |     |     |     |     | 80-100min  | %) had greater      | SDNN | reduction     |     | than participants |     | who | reported |
| --- | --- | --- | --- | --- | ---------- | ------------------- | ---- | ------------- | --- | ----------------- | --- | --- | -------- |
| -5  |     |     |     |     | 100-120min | neverhavingtinnitus |      | (–25.6[–27.2, |     | –24.0]%).         |     |     |          |
120-140min
|     |     |     |     |     |     | Short-term | environmentalnoise |     |     | exposure | showed | qualitatively |     |
| --- | --- | --- | --- | --- | --- | ---------- | ------------------ | --- | --- | -------- | ------ | ------------- | --- |
140-160min
|     |     |     |     |     |     | similar within-variable |     | trends |     | across | age, stress, | hearing, | and |
| --- | --- | --- | --- | --- | --- | ----------------------- | --- | ------ | --- | ------ | ------------ | -------- | --- |
-10 tinnitusgroups,butwithsmallereffectmagnitudes.Ingeneral,the
30 40 50 60 70 80 variables included in the models explained a small fraction (less
Noise Level (dB) than 20%) of between-subject variation in both models, and the
Predictedmedianlag-specificpercentchanges(%)inSDNN short-term models explained even less variation than the long-
Fig.3
|                 |             |            |           | reflect |             | termmodels. |     |     |     |     |     |     |     |
| --------------- | ----------- | ---------- | --------- | ------- | ----------- | ----------- | --- | --- | --- | --- | --- | --- | --- |
| from headphone  | sound       | exposures. | Estimates |         | percent     |             |     |     |     |     |     |     |     |
| changes in SDNN | relative to | predicted  | SDNN at   | 40 dBA. | a Estimates |             |     |     |     |     |     |     |     |
for short-term headphone sound exposure. b Estimates for long- Responses tolong-term headphone exposure
termheadphonesoundexposure. The predicted SDNN percent changes to long-term headphone
|     |     |     |     |     |     | sound exposures |     | across | age groups | and | BMI categories |     | mirrored |
| --- | --- | --- | --- | --- | --- | --------------- | --- | ------ | ---------- | --- | -------------- | --- | -------- |
comparedthemeanacrossalllevelsforeachvariablewithineach thepatternsobservedinenvironmentalnoisemodels,exceptthat
exposure level. Because the uncertainty of the relative change thechangeswerenear-zeroinyoungeradults (<25years)andat
estimate was not inherited into the individual-level model, the lowerexposurelevels(<60dBA).Notrendwasobservedbetween
Confidence
| 95% | Interval (95% | CI) | width below | may | be under- | thesexes. |     |     |     |     |     |     |     |
| --- | ------------- | --- | ----------- | --- | --------- | --------- | --- | --- | --- | --- | --- | --- | --- |
estimated, and therefore, the comparisons did not include Because headphone sound exposure is more likely to be
significancetesting.
|     |     |     |     |     |     | voluntary,    | desirable, | or beneficial   |     | (e.g., | for stress | relief) | [48] than |
| --- | --- | --- | --- | --- | --- | ------------- | ---------- | --------------- | --- | ------ | ---------- | ------- | --------- |
|     |     |     |     |     |     | environmental | noise,     | within-variable |     | trends | may        | differ  | between   |
Responses to long-termenvironmental exposure these sources. Perceived high stress showed greater percent
Older adults showed greater average changes in response to reductions in response to headphone sound. For instance, at 60
environmentalnoiseexposurecomparedtoyoungerparticipants. dBA, those scored most stressed (PSS-4 scores at 12 and above)
Forexample,at60dBA,theestimatedmeanpercentchangewas had an average percent change of –18.8 [–21.7, –16.0] %,
| –20.9% | [–22.6, –19.3] |     | 18–25 |     |     |     |     |     |     |     |     |     |     |
| ------ | -------------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(95% CI: %) in the age group, and comparedto–13.1[–15.2,–10.9]%forthoselessstressed(scores
–31.3[–33.1,–29.4]%inparticipantsaged65andolder.At30dBA,
|     |     |     |     |     |     | lower than | 2). Additionally, |     | participants |     | with | poorer | self-rated |
| --- | --- | --- | --- | --- | --- | ---------- | ----------------- | --- | ------------ | --- | ---- | ------ | ---------- |
thepercentchangeinthe65+group(26.7[24.3,29.1]%)doubled hearingstoodoutashavingmorechanges(–25.6[–28.5,–22.7]%
JournalofExposureScience&EnvironmentalEpidemiology

X.Zhangetal.
7
Table3. Intra-classcorrelationcoefficients(ICCs)consideringrandominterceptonly(ICC )versusconsideringbothrandominterceptandrandom
intercept
slope(ICC )acrossanalyticalgroups,withpointestimatesand95%ConfidenceIntervals.
total
EnvironmentalNoise HeadphoneSound
Variables Short-termN=361,629 Long-termN=293,144 Short-termN=160,389 Long-termN=162,913
ICC 0.40(0.38,0.43) 0.38(0.35,0.41) 0.37(0.35,0.40) 0.33(0.30,0.36)
intercept
ICC 0.41(0.39,0.44) 0.50(0.47,0.52) 0.40(0.38,0.43) 0.42(0.38,0.46)
total
at 70 dBA and –32.5 [–37.4, –27.7] % at 80 dBA) than excellent with poor hearing (long-term: 25.6–32.5%, short-term:
hearing participants (–22.3 [–24.0, –20.6] % at 70 dBA and –26.9 22.6–29.2%). This opposite trend may reflect differences in
[–29.7, –24.1] % at 80 dBA). This trend is the opposite of that of listeningcontext.Headphonesound,oftenassociatedwithactive
environmentalnoiseexposure.Lastly,at50to70dBA,participants listening (e.g., music, podcasts), may impose greater cognitive
whoreportedhavingtinnitus afewtimesayear, amonth, anda demand on individuals with hearing difficulties, increasing
week had a larger reduction than participants who never had listening effort, increasing stress, and reducing HRV [51, 52]. In
tinnitus orhad tinnitus a fewtimesa day. contrast, individuals with excellent hearing, or possibly hyper-
Short-termheadphoneexposuresshowedfewerclearsubgroup acusis, may respond more strongly to unwanted ambient noise,
differences. Both short- and long-term models explained up to being more easily bothered or distracted by it; however, this
23% of between-subject variability in SDNN changes, with short- hypothesis requires further investigation. Notably, the study did
termmodels explaining slightly less. not account for sound characteristics or hearing protection use
duetolimitedinformation.However,lessthan10%ofparticipants
reportedwearinghearingprotection,andthedurationofwearing
DISCUSSION was limited. The SDNN changes following the low- and high-
This analysis examined the percent SDNN changes (%) following frequency noise were not meaningfully different [18]. We
two types of sound exposures over short- and long-term lagged acknowledge their potential confounding in the noise-SDNN
periods, using real-world data from consumer wearables. Pre- relationshipbutexpectlimitedimpactinthisstudy.Futurestudies
dicted netSDNN reductions were observed at elevated exposure adding ecological momentary assessment of the two variables
levels for both environmental noise and headphone sound. Lag- wouldhelpimprove exposure characterization.
specificpredictionsshowedabriefperiodofSDNNincreaseinthe Beyond the caveats noted above, several broader limitations
first 3–6min, followed by sustained reduction. Our hierarchical apply. First, the stratified sample is composed of current Apple
Bayesian models demonstrated heterogeneity across individuals productusers,andthereforetheresultsmaynotbegeneralizable
by characteristics such as common demographics and hearing to the US population [25]. Due to small stratum sizes, some
status. subgroups (e.g., Asian females aged 65+) were excluded, which
The negative trend in predicted SDNN changes with increased may limit generalizability to these groups; however, their
noise exposure is consistent with findings by Walker et al. [18], exclusion did not materially change the observed associations.
whoreportedreduced5-minSDNNduring40-minenvironmental Second, regarding exposure and outcome measurement, the
noise exposure. Prior studies also found immediate SDNN consumer-grade wearables were also not individually calibrated,
increasesfollowedbylaggeddecreaseswithin15minwithlouder andexistingvalidationstudiescoveronlyasubsetofAppleWatch
environmental noise [21–23], a trend consistent with current models [28, 30]; development of a validation database for
results (Figs. 1b and 3b). They attributed the observed early commonly used wearables would benefit future real-world
increasetochangesinthevery-lowfrequencyband(VLF)ofHRV exposure assessment research. In addition, HRV was limited to
[23]orsuddenheartrateshifts[21].Inourcase,the1-minwindow SDNN owing to data availability, and other indices may offer a
for SDNN is too short to adequately capture VLF cycles, which richercharacterizationofautonomicnervoussystemresponsesto
requireatleast5-min[49],butsuddenheartrateshiftsarelikelyto noise. Third, regarding modeling, we only partially accounted for
drive early SDNN increase. However, our observational design heart rate changes in the model with the inclusion of active
cannotisolatethemechanism,andthishypothesiswouldbebest energyexpenditure,whileSDNNisinverselycorrelatedwithheart
addressedthrough laboratory-controlled experiments. rate.Futureworkshouldconsidersimplifyingthemodeltoinclude
A key contribution of this study is our observation of heart rate and other lifestyle factors to examine how heart rate
heterogeneous exposure-response relationships across lags and modifies the association between noise and SDNN. Lastly, to
individual-level characteristics, especially for long-term exposure include uncertainties from first-stage estimation, a meta-
(greatertotalICCgainwhenincludingrandomslopecomparedto regression approach will be explored to allow hypothesis testing
short-term,Table3).OlderadultsshowedlargerSDNNreductions foreffect modification.
comparedto younger adults withthesame L eq,whilecontrolling
for hearing ability and tinnitus. This suggests greater autonomic
disruption in older adults under noise exposure at equivalent CONCLUSION
levels. Sensorineural aging and hyperacusis, characterized by Toourknowledge,itisamongthefirsttocharacterizeshort-and
reduced sound tolerance and frequently a comorbidity with long-term sound exposure and HRV at scale using real-world
stress-related conditions, are more prevalent in older adults consumer-wearable data, capturing free-living exposures that
[50, 51], potentially increasing susceptibility to noise-related laboratory studies of brief, controlled noise cannot. The distrib-
cardiovascularstress. uted lag non-linear modeling further allowed us to resolve
The direction of the HRV changes differed between environ- heterogeneous, time-varying exposure–response relationships.
mental noise and headphone sound contexts. Among those We observed overall SDNN reductions of 6.8-16.0% for each
exposed to environmental noise (cid:2)70 dBA, the greatest SDNN 10dBincreaseinenvironmentalnoiseexposure,and7.1-7.4%for
reduction was observed in participants with excellent hearing a 10dB increase in headphone sound. Greater SDNN reduction
(long-term: 35.4–40.2%, short-term: 6.4–11.3%). For headphone wasseeninolderadultsandindividualswithtinnitus.Participants
sound, the largest reductions were observed among participants who reported excellent hearing showed greater reduction from
JournalofExposureScience&EnvironmentalEpidemiology

X.Zhangetal.
8
loud environmental noise exposure, but for headphone sound, it 17. Adam M, Imboden M, Schaffner E, Boes E, Kronenberg F, Pons M, et al. The
adverseimpactofobesityonheartratevariabilityismodifiedbyanNFE2L2gene
wasthepoorhearingparticipantswhoshowedgreaterreduction.
findings variant:TheSAPALDIAcohort.IntJCardiol.2017;228:341–6.https://doi.org/10.
| The | highlight | the role | of noise | context | (environmental |     |     |     |     |     |     |     |
| --- | --------- | -------- | -------- | ------- | -------------- | --- | --- | --- | --- | --- | --- | --- |
1016/j.ijcard.2016.11.049.
| versus headphone |     | source) in | the noise-SDNN |     | relationships | and |     |     |     |     |     |     |
| ---------------- | --- | ---------- | -------------- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- |
stratified 18. WalkerED,BrammerA,CherniackMG,LadenF,CavallariJM.Cardiovascularand
| the importance | of  |     | risk assessment, |     | especially | in older |     |     |     |     |     |     |
| -------------- | --- | --- | ---------------- | --- | ---------- | -------- | --- | --- | --- | --- | --- | --- |
stressresponsestoshort-termnoiseexposures—apanelstudyinhealthymales.
adultsandindividualswithhearingloss.However,generalizability EnvironRes.2016;150:391–7.https://doi.org/10.1016/j.envres.2016.06.016.
may be limited by cohort characteristics and uncalibrated 19. DekkerJM,CrowRS,FolsomAR,HannanPJ,LiaoD,SwenneCA,etal.Lowheart
consumer-grade wearables. Future work to include heart rate ratevariabilityina2-minuterhythmstrippredictsriskofcoronaryheartdisease
directly into the model or replace SDNN may provide additional andmortalityfromseveralcauses:theARICstudy.Circulation.2000;102:1239–44.
insight.Additionally,itwouldbeofinteresttoexaminethechronic https://doi.org/10.1161/01.CIR.102.11.1239.
association using daily average SDNN and noise exposures, with 20. VossA,SchroederR,VallverdúM,SchulzS,CygankiewiczI,VázquezR,etal.Short-
termvs.long-termheartratevariabilityinischemiccardiomyopathyriskstrati-
| careful consideration |     | of various | important | and | related | lifestyle |     |     |     |     |     |     |
| --------------------- | --- | ---------- | --------- | --- | ------- | --------- | --- | --- | --- | --- | --- | --- |
fication.FrontPhysiol.2013;4.https://doi.org/10.3389/fphys.2013.00364
factors.
|     |     |     |     |     |     |     | 21. El Aarbaoui | T, Méline J, Brondeel | R, Chaix | B. Short-term | association | between |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --------------------- | -------- | ------------- | ----------- | ------- |
personalexposuretonoiseandheartratevariability:TheRECORDMultiSensor
Study.EnvironPollut.2017;231:703–11.https://doi.org/10.1016/j.envpol.2017.08.
| DATAAVAILABILITY |               |     |     |          |     |     | 031. |     |     |     |     |     |
| ---------------- | ------------- | --- | --- | -------- | --- | --- | ---- | --- | --- | --- | --- | --- |
|                  | de-identified |     |     | findings |     |     |      |     |     |     |     |     |
Aggregated, data that support the of this study may be 22. ElAarbaouiT,ChaixB.Theshort-termassociationbetweenexposuretonoiseand
| available upon | request | from the corresponding |     | author (RLN). | All requests | will be |     |     |     |     |     |     |
| -------------- | ------- | ---------------------- | --- | ------------- | ------------ | ------- | --- | --- | --- | --- | --- | --- |
heartratevariabilityindailylocationsandmobilitycontexts.JExpoSciEnviron
reviewedandconsideredinaccordancewithpoliciesdesignedtoprotectparticipant
Epidemiol.2020;30:383–93.
| confidentiality | andtoremainconsistentwiththestudyprotocolandtheconsent |     |     |     |     |     |                                                                        |     |     |     |     |     |
| --------------- | ------------------------------------------------------ | --- | --- | --- | --- | --- | ---------------------------------------------------------------------- | --- | --- | --- | --- | --- |
|                 |                                                        |     |     |     |     |     | 23. KrausU,SchneiderA,BreitnerS,HampelR,RückerlR,PitzM,etal.Individual |     |     |     |     |     |
providedbyparticipants. daytime noise exposure during routine activities and heart rate variability in
adults:arepeatedmeasuresstudy.EnvironHealthPerspectEnvironHealthPer-
spect.2013;121:607–12.https://doi.org/10.1289/ehp.1205606.
REFERENCES
|     |     |     |     |     |     |     | 24. Terziotti | P, Schena F, Gulli G, | Cevese A. | Post-exercise | recovery | of autonomic |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --------------------- | --------- | ------------- | -------- | ------------ |
BabischW,IsingH,GallacherJEJ.Healthstatusasapotentialeffectmodifierof
1. cardiovascular control: a study by spectrum and cross-spectrum analysis in
therelationbetweennoiseannoyanceandincidenceofischaemicheartdisease. humans. Eur J Appl Physiol. 2001;84:187–94. https://doi.org/10.1007/
| OccupEnvironMed.2003;60:739–45.https://doi.org/10.1136/oem.60.10.739. |     |     |     |     |     |     | s004210170003. |     |     |     |     |     |
| --------------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | -------------- | --- | --- | --- | --- | --- |
2. BabischW,KampI.Exposure-responserelationshipoftheassociationbetween 25. NeitzelRL,SmithL,WangL,GreenG,BlockJ,CarchiaM,etal.Towardabetter
aircraftnoiseandtheriskofhypertension.NoiseHealth.2009;11:161https://doi. understanding of nonoccupational sound exposures and associated health
org/10.4103/1463-1741.53363. impacts: methods of the Apple Hearing Study. J Acoust Soc Am.
3. JarupL,BabischW,HouthuijsD,PershagenG,KatsouyanniK,CadumE,etal. 2022;151:1476–89.
Hypertension and exposure to noise near airports: the HYENA study. Environ 26. AppleInc.UsingAppleWatchtomeasureheartrate,calorimetry,andactivity.
HealthPerspect.2008;116:329–33.https://doi.org/10.1289/ehp.10775. Apple Inc.; 2024;7. https://www.apple.com/health/pdf/Heart_Rate_Calorimetry_
WorldHealthOrganization.RegionalOfficeforEurope.Burdenofdiseasefrom
| 4.  |     |                         |     |     |     |     | Activity_on_Apple_Watch_November_2024.pdf |     |     |     |     |     |
| --- | --- | ----------------------- | --- | --- | --- | --- | ----------------------------------------- | --- | --- | --- | --- | --- |
|     |     | quantificationofhealthy |     |     |     |     | O’Grady                                   |     |     |     |     |     |
environmentalnoise: lifeyearslost inEurope.World 27. B, Lambe R,BaldwinM, Acheson T,Doherty C.The validity ofApple
HealthOrganization.RegionalOfficeforEurope2011.https://iris.who.int/handle/ WatchSeries9andUltra2forserialmeasurementsofheartratevariabilityand
10665/326424 restingheartrate.Sensors.2024;24:6220.https://doi.org/10.3390/s24196220.
5. BabischW.Thenoise/stressconcept,riskassessmentandresearchneeds.Noise 28. Hernando D, Roca S, Sancho J, Alesanco Á, Bailón R. Validation of the Apple
Health.2002;4:1–11.
|     |     |     |     |     |     |     | Watch for | heart rate variability | measurements | during | relaxation | and mental |
| --- | --- | --- | --- | --- | --- | --- | --------- | ---------------------- | ------------ | ------ | ---------- | ---------- |
6. BabischW.Cardiovasculareffectsofnoise.NoiseHealth.2011;13:201https://doi. stress in healthy subjects. Sensors. 2018;18:2619. https://doi.org/10.3390/
| org/10.4103/1463-1741.80148. |     |     |     |     |     |     | s18082619. |     |     |     |     |     |
| ---------------------------- | --- | --- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | --- |
7. Eriksson C, Pershagen G, Nilsson M. Biological mechanisms related to cardio- 29. MaY,ChangM-C,LitrownikD,WaynePM,YehGY.Day–nightpatternsinheart
vascularandmetaboliceffectsbyenvironmentalnoise.WorldHealthOrganiza- ratevariabilityandcomplexity:differenceswithageandcardiopulmonarydis-
Officefor ease.JClinSleepMed.2023;19:873–82.https://doi.org/10.5664/jcsm.10434.
| tion. Regional |     | Europe,2018,p. |     | iii, 13.Report | No.: WHO/EURO:2018- |     |     |     |     |     |     |     |
| -------------- | --- | -------------- | --- | -------------- | ------------------- | --- | --- | --- | --- | --- | --- | --- |
3009-42767-59666.https://iris.who.int/handle/10665/346548 30. RobertsB,JacobsN,MathisC,ReamerH,KardousCC,GaffneyS,etal.Evaluation
8. BasnerM,BabischW,DavisA,BrinkM,ClarkC,JanssenS,etal.Auditoryandnon- of a wearable consumer noise measurement device in a laboratory setting. J
auditoryeffectsofnoiseonhealth.Lancet.2014;383:1325–32.https://doi.org/10. AcoustSocAm.2022;152:547–52.
1016/S0140-6736(13)61613-X. 31. USEPAO.CleanAirActTitleIV-NoisePollution.2015.https://www.epa.gov/
9. MalikM,HnatkovaK,HuikuriHV,LombardiF,SchmidtG,ZabelM.Rebuttalfrom clean-air-act-overview/clean-air-act-title-iv-noise-pollution.
Marek Malik, Katerina Hnatkova, Heikki V. Huikuri, Federico Lombardi, Georg 32. Sacha J. Interaction between heart rate and heart rate variability. Ann Non-
SchmidtandMarkusZabel.JPhysiol.2019;597:2603–4.https://doi.org/10.1113/ invasiveElectrocardiol.2014;19:207–16.https://doi.org/10.1111/anec.12148.
jp277962.Wiley. 33. WHO Consultation on Obesity (1999: Geneva, Switzerland) & World Health
10. Malik M, Hnatkova K, Huikuri HV, Lombardi F, Schmidt G, Zabel M. CrossTalk Organization.Obesity:preventingandmanagingtheglobalepidemic:reportofa
proposal:Heartratevariabilityisavalidmeasureofcardiacautonomicrespon- WHOconsultation.WorldHealthOrganization.WorldHealthOrganization2000.
siveness.JPhysiol.2019;597:2595–8.https://doi.org/10.1113/jp277500. https://iris.who.int/handle/10665/42330.
11. ShafferF,MeehanZM,ZerrCL.Acriticalreviewofultra-short-termheartrate 34. Cohen S, Kamarck T, Mermelstein R. A Global Measure of Perceived Stress. J
variability norms research. Front Neurosci. 2020;14:594880. https://doi.org/10. HealthSocBehav.1983;24:385–96.https://doi.org/10.2307/2136404.
3389/fnins.2020.594880. 35. SchäferSK,vonBorosL,GöritzAS,BaumannS,WessaM,TüscherO,etal.The
12. ShafferF,GinsbergJP.Anoverviewofheartratevariabilitymetricsandnorms. PerceivedStressScale2&2:atwo-factorialGermanshortversionofthePerceived
FrontPublicHealth.2017;5:258.https://doi.org/10.3389/fpubh.2017.00258. StressScale.FrontPsychiatryFrontMediaSA.2023;14:1195986.
13. MalikM,BiggerJT,CammAJ,KleigerRE,MallianiA,MossAJ,etal.Heartrate 36. IngramIVPB,ClarkeE,LichtenbergJW.ConfirmatoryfactoranalysisofthePer-
variability:Standardsofmeasurement,physiologicalinterpretation,andclinical ceivedStressScale-4inacommunitysample.StressHealthWileyOnlineLibr.
| use.EurHeartJ.1996;17:354–81. |     |     |     |     |     |     | 2016;32:173–6. |     |     |     |     |     |
| ----------------------------- | --- | --- | --- | --- | --- | --- | -------------- | --- | --- | --- | --- | --- |
MíkováM,PospíšilD,ŘehořJ,MalikM.Heartratevariabilityanalysisincongestive
14. 37. RCoreTeam.R:alanguageandenvironmentforstatisticalcomputing[Internet].
heart failure: the need for standardizedassessment protocols. Rev Cardiovasc Vienna, Austria: R Foundation for Statistical Computing; 2025. https://www.R-
| Med.2025;26.https://doi.org/10.31083/rcm36321 |     |     |     |     |     |     | project.org/ |     |     |     |     |     |
| --------------------------------------------- | --- | --- | --- | --- | --- | --- | ------------ | --- | --- | --- | --- | --- |
15. NatarajanA,PantelopoulosA,Emir-FarinasH,NatarajanP.Heartratevariability 38. GasparriniA.dlnm:Distributedlagnon-linearmodels.2024.https://cran.r-project.
org/package=dlnm
| with photoplethysmography |     | in  | 8 million | individuals: | a cross-sectional | study. |     |     |     |     |     |     |
| ------------------------- | --- | --- | --------- | ------------ | ----------------- | ------ | --- | --- | --- | --- | --- | --- |
LancetDigitalHealth.2020;2:e650–7. 39. BürknerP-C.brms:AnRpackageforBayesianmultilevelmodelsusingstan.JStat
16. UmetaniK,SingerDH,McCratyR,AtkinsonM.Twenty-four-hourtimedomain Softw.2017;80:1–28.https://doi.org/10.18637/jss.v080.i01.
heartratevariabilityandheartrate:relationstoageandgenderoverninedec- 40. LenthRV.emmeans:Estimatedmarginalmeans,akaleast-squaresmeans.2025.
ades.JAmCollCardiol.1998;31:593–601. https://CRAN.R-project.org/package=emmeans
JournalofExposureScience&EnvironmentalEpidemiology

X.Zhangetal.
9
41. AntonelliJ,WilsonA,CoullBA.Multipleexposuredistributedlagmodelswith projectadministration,resources,reviewandediting;RLN:supervision,conceptua-
variableselection.BiostatOxfEngl.2024;25:1–19. lization,validation,fundingacquisition,reviewandediting.
42. GasparriniA.Modelingexposure–lag–responseassociationswithdistributedlag
non-linearmodels.StatMed.2014;33:881–99.https://doi.org/10.1002/sim.5963.
43. SchwartzJ.Thedistributedlagbetweenairpollutionanddailydeaths.Epidemiol FUNDING
CambMassLWW.2000;11:320–6.
This study was funded by Apple Inc. The funder had no role in the design and
44. GasparriniA,ArmstrongB,KenwardMG.Distributedlagnon-linearmodels.Stat
conductofthestudy;inthecollection,analysis,andinterpretationofthedata;inthe
Med.2010;29:2224–34.https://doi.org/10.1002/sim.3940.
decision to submit the article for publication; or in the preparation, review, or
45. GasparriniA,ScheiplF,ArmstrongB,KenwardMG.Apenalizedframeworkfor
approvalofthearticle.
distributedlagnon-linearmodels.Biometrics.2017;73:938–48.https://doi.org/10.
1111/biom.12645.
46. Thomas S, Tu W. Learning Hamiltonian Monte Carlo in R. Am Stat.
COMPETINGINTERESTS
2021;75:403–13.https://doi.org/10.1080/00031305.2020.1865198.
SalariesforXZ,LMS,andRLNweresupportedbystudyfundingprovidedbyAppleInc
47. ErfanianM,MitchellAJ,KangJ,AlettaF.ThePsychophysiologicalimplicationsof
totheUniversityofMichiganasacontract.Theauthorshavenootherconflictsof
soundscape:asystematicreviewofempiricalliteratureandaresearchagenda.
Int J Environ Res Public Health. 2019;16:3533. https://doi.org/10.3390/ interesttodisclose.SKPdeclaresnopotentialcompetinginterests.
ijerph16193533.
48. NussinovitchU,ElishkevitzKP,KatzK,NussinovitchM,SegevS,VolovitzB,etal.
ADDITIONAL INFORMATION
Reliabilityofultra-shortECGindicesforheartratevariability.AnnNoninvasive
Electrocardiol.2011;16:117–22.https://doi.org/10.1111/j.1542-474X.2011.00417.x. Supplementary information The online version contains supplementary material
49. FiorettiA,PoliO,VarakliotisT,EibensteinA.Hearingdisordersandsensorineural availableathttps://doi.org/10.1038/s41370-026-00970-8.
aging.JGeriatr.2014;2014:1–6.https://doi.org/10.1155/2014/602909.
50. Paulin J, Andersson L, Nordin S. Characteristics of hyperacusis in the general Correspondenceandrequestsformaterialsshouldbeaddressedto
population. Noise Health. 2016;18:178. https://doi.org/10.4103/1463-1741. RichardL.Neitzel.
189244.
51. MackersieCL,Calderon-MoultrieN.Autonomicnervoussystemreactivityduring Reprints and permission information is available at http://www.nature.com/
speech repetition tasks: heart rate variability and skin conductance. Ear Hear. reprints
2016;37:118S–125S.https://doi.org/10.1097/AUD.0000000000000305.
52. Pichora-FullerMK,KramerSE,EckertMA,EdwardsB,HornsbyBWY,HumesLE, Publisher’snoteSpringerNatureremainsneutralwithregardtojurisdictionalclaims
et al. Hearing impairment and cognitive energy: the framework for under- inpublishedmapsandinstitutionalaffiliations.
standingeffortfullistening(FUEL).EarHear.2016;37:5S–27S.https://doi.org/10.
1097/AUD.0000000000000312.
Open Access This article is licensed under a Creative Commons
Attribution 4.0 International License, which permits use, sharing,
adaptation,distributionandreproductioninanymediumorformat,aslongasyougive
ACKNOWLEDGEMENTS appropriatecredittotheoriginalauthor(s)andthesource,providealinktotheCreative
WethanktheparticipantsoftheAppleHearingStudyfortheirparticipation,without Commonslicence,andindicateifchangesweremade.Theimagesorotherthirdparty
whichthisstudywouldnothavebeenpossible.WealsothankJoyceDanielsforher materialinthisarticleareincludedinthearticle'sCreativeCommonslicence,unless
studyadministrativeassistanceandourcolleaguesatApple,whoprovidedtechnical indicatedotherwiseinacreditlinetothematerial.Ifmaterialisnotincludedinthe
supportondatainfrastructure. article'sCreativeCommonslicenceandyourintendeduseisnotpermittedbystatutory
regulationorexceedsthepermitteduse,youwillneedtoobtainpermissiondirectly
fromthecopyrightholder.Toviewacopyofthislicence,visithttp://creativecommons.
org/licenses/by/4.0/.
AUTHORCONTRIBUTIONS
XZ: conceptualization, data curation, formal analysis, investigation, original draft
preparation,reviewandediting;SKP:resources,supervision,reviewandediting;LMS: ©TheAuthor(s)2026
JournalofExposureScience&EnvironmentalEpidemiology
Extending Stress Detection Reproducibility to
Consumer Wearable Sensors
Ohida Binte Amin1,2, Varun Mishra1,2, Tinashe M. Tapera1,2, Robert Volpe2, Aarti Sathyanarayana1,2,3
1Khoury College of Computer Sciences, Northeastern University, Boston, MA
2Bouvé College of Health Sciences, Northeastern University, Boston, MA
3Department of Biostatistics, Harvard T.H. Chan School of Public Health, Boston, MA
{amin.o, v.mishra, tapera.t, r.volpe, a.sathyanarayana}@northeastern.edu
Abstract—Wearable sensors are widely used to collect like cardiovascular disease, gastrointestinal disorders, sub-
physiological data and develop stress detection models. stanceabuse,andevenchronicconditionsincludingdiabetes,
However, most studies focus on a single dataset, rarely
and hypertension, enhancing quality of life [2]. The increas-
evaluating model reproducibility across devices, populations, ingavailabilityofwearabledeviceshasfacilitatedcontinuous
or study conditions. We previously assessed the reproducibility
of stress detection models across multiple studies, testing stress monitoring, enabling studies with minimal participant
models trained on one dataset against others using heart rate burden [1]. Physiological biomarkers such as heart rate vari-
(with R-R interval) and electrodermal activity (EDA). In this ability (HRV) and electrodermal activity (EDA), measured
study, we extended our stress detection reproducibility to
through digital devices, provide reliable indicators of stress
consumer wearable sensors. We compared validated research-
responses governed by the Autonomic Nervous System and
grade devices, to consumer wearables - Biopac MP160, Polar
H10, Empatica E4, to the Garmin Forerunner 55s, assessing the Hypothalamic-Pituitary-Adrenal axis [3].
device-specific stress detection performance by conducting a Stress assessment has evolved through both controlled
new stress study focused on solely undergraduate students at lab experiments and real-world, free-living conditions. In
Northeastern University. Thirty-five students completed three
controlledlabsettings,leveragingavarietyofwell-validated
standardized stress-induction tasks in a controlled lab setting.
tasks (such as mental arithmetic, the Stroop test, star-
Biopac MP160 performed the best, being consistent with our
expectations of it as the gold standard, though performance tle response tests, cold-pressor tests, or public speaking),
varied across devices and models. Combining heart rate prior studies were designed to elicit physiological stress
variability (HRV) and EDA enhanced stress prediction across responses under different stress conditions while incorpo-
most scenarios. However, Empatica E4 showed variability;
rating restful periods as a baseline [4], [5], [6], [7], [8],
while HRV and EDA improved stress detection in leave-
[9], [10], [11]. In contrast, stress levels were monitored in
one-subject-out (LOSO) evaluations (AUROC up to 0.953),
device-specificlimitationsledtounderperformancewhentested uncontrolled free-living situations where several contactless
with our pre-trained stress detection tool (AUROC 0.723), methods were employed for stress measurement, including
highlighting generalizability challenges related to hardware- analyzing user’s voice [12], keyboard typing behaviors [13]
model compatibility. Garmin Forerunner 55s demonstrated
or using accelerometer-based contextual modeling [14], or
strong potential for real-world stress monitoring, achieving
smartphone data like Bluetooth, app usage, and Call/SMS
the best mental arithmetic stress detection performance in
LOSO (AUROC up to 0.961) comparable to research-grade logs [15], [16], [14], [17]. Many studies used custom-built
devices like Polar H10 (AUROC 0.954), and Empatica E4 sensingsystemsforprecisecontroloversignalquality,sensor
(AUROC 0.905 with HRV-only model and AUROC 0.953 with type,andbatterylife[18],[19],[8],[11],[20],buttheselimit
HRV+EDA model), with the added advantage of consumer-
scalabilityandbroadervalidation.Alternatively,somestudies
friendlywearabilityforfree-livingcontexts.Exploringpotential
leveraged commercially available sensors, either alone or
devices that work effectively in a controlled lab setting could
significantly enhance the reliability of stress detection tools in combined with custom sensors or smartphones [16]. Wear-
real-world applications. * abletechnologyhasthepotentialtoconsistentlyobtainhigh-
quality biosignals over weeks to months and is increasingly
Index Terms— stress detection tool, research-grade vs. con-
valued for its advanced diagnostic and therapeutic potential
sumer wearables, physiological sensing, machine learning, re-
[21]. Muaremi et al. [22] monitored sleep stress using
producibility
both the Zephyr BioHarness 3.0 and an Empatica E3 [23].
I. INTRODUCTION Gjoreski et al. [7] detected stress in various environments
by employing both the Empatica E3 and E4 [24]. Egilmez
Effective stress monitoring and management are essential
et al. [6] & Mishra et al. [4] used a commodity device
for maintaining overall well-being, especially for students
the Polar H7 heart rate monitor for continuous detection of
who frequently encounter high stress due to persistent aca-
physiological stress. Pinge et al. compared the performance
demicdemandsandsocialexpectations[1].Proactivelyman-
ofaGarminVivosmart4Smartwatch[25],aPolarH10[26],
aging stress reduces the risk of stress-related health issues
and a Garmin HRM Dual [27] Heart Rate Monitor for stress
*AcceptedatIEEEEMBC2025 detection.
5202
yaM
9
]CH.sc[
1v49650.5052:viXra

Advanced machine learning and deep learning techniques undergraduate students at Northeastern University. We as-
have enhanced the effectiveness of stress detection using sessed the feasibility of different wearable devices for stress
datafromwearabledevices.Regardingadvancementinstress detectionusingourpreviouslydevelopedstressdetectiontool
detection models, Hovsepian et al. used data from a lab across multiple devices—Polar H10, Empatica E4, Garmin
study with 21 participants to build a stress-detection model, Forerunner 55s, and Biopac MP160 (as a gold-standard
cStress using a Support Vector Machine (SVM) model with medicaldevice).Wespecificallyfocusedonstudents,asthey
aRadialBasisFunction(RBF)kernel[8],whileSarkeretal. frequentlyexperienceacademicandsocialstressindailylife,
applied the same cStress model to identify stress among 38 to extend stress detection reproducibility to the consumer
polydrug users [9]. In another study, Heyat et al. developed wearables Garmin Forerunner 55s, given its increasing ac-
anautomaticstressdetectionsystemusingElectrocardiogram ceptance as a health-tracking device [32]. We assessed the
(ECG) signals from smart T-shirts with machine learning performance of devices within the study in capturing physi-
classifiers, Decision Tree (DT), Naive Bayes (NB), Random ological stress markers using leave-one-subject-out (LOSO)
Forest(RF),LogisticRegression(LR)includingdatafrom20 cross-validation and further tested the stress versus restful
subjects[28].Vitoetal.designedareal-timestressdetection periods from our 35 students with our pre-trained stress
systemapplyingLRalongwithRidgeLR,DT,RF,andSVM model[31].Thiscomparativeanalysisoffersinsightsintothe
with RBF kernel using only Heart Beats Per Minute [29]. potential of commercially available wearables, particularly
Bari et al. introduced a stress detection model using LR the Garmin Forerunner 55s, to enhance the reproducibility
and RF for conversations incorporating ECG and respiration of our stress detection tool tailored for student populations.
| sensors | to gather physiological |     | stress data, | encompassing |     |     |     |     |     |
| ------- | ----------------------- | --- | ------------ | ------------ | --- | --- | --- | --- | --- |
both controlled lab and real-world environments [30]. Re- TABLEI
searchers aimed to design a real-time method to identify SOCIO-DEMOGRAPHICSOF35UNDERGRADUATESTUDENTS
| stress episodes | from time | series | data of physiological |     | stress |                |                      |     |               |
| --------------- | --------- | ------ | --------------------- | --- | ------ | -------------- | -------------------- | --- | ------------- |
|                 |           |        |                       |     |        | Characteristic | NumberofParticipants |     | Percentage(%) |
markers,enablingthepromptinitiationofjust-in-timestress-
AgeGroup
| management | interventions. |     |     |     |     | Below20 |     | 7   | 19.4% |
| ---------- | -------------- | --- | --- | --- | --- | ------- | --- | --- | ----- |
While these works have contributed to stress detection 20to22 22 63.9%
|               |             |            |         |              |     | Above22 |     | 6   | 16.7% |
| ------------- | ----------- | ---------- | ------- | ------------ | --- | ------- | --- | --- | ----- |
| advancements, | significant | challenges | remain, | particularly | re- |         |     |     |       |
GenderIdentity
gardingreproducibilitythatmightleadtothegeneralizability Female 21 58.3%
of stress detection models. Here, reproducibility refers to a Male 13 38.9%
|          |                 |                |     |         |           | Non-Binary |     | 1   | 2.8% |
| -------- | --------------- | -------------- | --- | ------- | --------- | ---------- | --- | --- | ---- |
| scenario | in which a team | of researchers |     | applies | models or |            |     |     |      |
Hispanic/LatinoIdentity
| methods           | from a previous | study            | and achieves | similar      | results |     |     |     |       |
| ----------------- | --------------- | ---------------- | ------------ | ------------ | ------- | --- | --- | --- | ----- |
|                   |                 |                  |              |              |         | Yes |     | 6   | 16.7% |
|                   |                 |                  |              |              |         | No  |     | 29  | 83.3% |
| in an independent | study           | with a different |              | experimental | setup   |     |     |     |       |
AcademicYear
| [31]. Stress   | is inherently | subjective, | and          | its physiological |      |           |     |     |       |
| -------------- | ------------- | ----------- | ------------ | ----------------- | ---- | --------- | --- | --- | ----- |
|                |               |             |              |                   |      | Freshman  |     | 4   | 11.1% |
| manifestations | might vary    | across      | individuals. | Different         | peo- |           |     |     |       |
|                |               |             |              |                   |      | Sophomore |     | 14  | 41.7% |
ple may exhibit distinct autonomic and hormonal responses Junior 8 22.2%
|             |                  |             |                    |             |      | Senior |     | 9   | 25% |
| ----------- | ---------------- | ----------- | ------------------ | ----------- | ---- | ------ | --- | --- | --- |
| to the same | stressor,        | and their   | self-reported      | experiences |      |        |     |     |     |
| of stress   | may not always   | align       | with physiological |             | mea- |        |     |     |     |
| surements.  | This variability | complicates | the                | development | of   |        |     |     |     |
generalizablestress-detectiontools.Despiteadvancementsin
II. METHODOLOGY
| wearable-based | stress | detection, | many studies | develop | stress |     |     |     |     |
| -------------- | ------ | ---------- | ------------ | ------- | ------ | --- | --- | --- | --- |
detection models using physiological data from controlled Whilestressdetectionusingwearableshasadvanced,mod-
settings, often with custom or commercial wearables. How- elsoftenlackreproducibilityacrossstudies,populations,and
ever, these models are typically trained and validated within devicesduetovariationsindatacollection,sensorplacement,
a single study, limiting their reproducibility to new datasets, and physiological data preprocessing. To address this, we
populations, or devices. A major limitation is the lack of previously evaluated the reproducibility of stress detection
systematic efforts to assess whether models trained on one models by testing their performance across multiple studies
dataset remain effective across different studies, participant [31], assessing whether models trained on one dataset could
groups, or sensor types. Inconsistencies in data collection achieve comparable results on another with similar stressors
methods, sensor placement, and preprocessing further com- andsensormodalities.However,thesechallengescontinueto
plicate cross-study comparisons. hinder the broader applicability of stress monitoring frame-
Our prior work explored the reproducibility of stress works in real-world settings. Addressing them is crucial for
detection models by evaluating their performance across advancing digital phenotyping in stress monitoring and de-
multiplestudiesandtwodifferentsensortypes,PolarH7/H10 veloping reliable, scalable stress management interventions.
chest monitor and Empatica E4 devices [31]. We evaluated In the following section, we first briefly discuss how we
the performance of models built using data from one study built our stress detection tool evaluating reproducibility, and
and tested on data from other studies. In this study, to laterwediscusshowweextendedourstressdetectionrepro-
evaluate consumer wearable device-specific reproducibility, ducibilityacrossdiversewearablesensorsfocusingprimarily
we conducted a digital phenotyping stress study with 35 on consumer wearables, Garmin Forerunner 55s.

A. Approach & Development of Stress Prediction Tool for andnarrowingstudentswouldenhance therobustnessofour
Evaluating Reproducibility stress detection tool.
We conducted a stress study with undergraduate students
1) Physiological Signal Selection & Pre-processing: To
recruited from Northeastern University, with eligibility cri-
evaluate the reproducibility of stress detection models, we
teria requiring them to be at least 18 years old, fluent in
used heart rate (HR) and R-R interval data from Polar
English, and own an iOS 12+ smartphone. Recruitment and
H7/H10 chest monitors and EDA data from the wrist-
study protocols were approved by Northeastern University’s
worn Empatica E4s across four studies. For consistency,
InstitutionalReviewBoard(IRB#22-10-02),andparticipants
only processed HR and HRV data were used from all
were duly compensated at the end of the study. We tested
devices. Physiological data were preprocessed to remove
fourdifferentsensors:EmpaticaE4,GarminForerunner55s,
artifacts and standardize across datasets. HR values outside
Biopac MP160, and Polar H10 chest monitor.
30–220 bpm and EDA values below 0.01 µS or above
100 µS were discarded [33]. Motion artifacts from sudden
movements were handled separately: HR and HRV outliers Mental ArithmeticStartle Response Cold Pressor
Rest
were trimmed using a Median Absolute Deviation (MAD)
threshold (values beyond median ± 3×MAD were removed),
whileEDAartifactsweresmoothedusinga5-secondmedian
filter. To address inter-participant variability, HR and R-
R interval data were Z-score normalized, as recommended
[33], while EDA signals were min-max normalized to [0,1].
10 4 5 4 5 4 10
Additionally, EDA signals were decomposed into tonic and
Duration in Minutes
phasic components using the cvxEDA method, separating
sustained physiological arousal from rapid fluctuations.
Fig. 1. Lab protocol timeline for three stressor conditions in our digital
2) Feature Extraction: To extract stress-related features, phenotypingstressstudy,wherethefirsttwostresstaskswererandomized.
Thecoldpressorwasconductedattheendduetologisticalconstraints.
we used a 60-second sliding window with a 45-second
overlap. Time-domain features from HR and R-R intervals
1) In-Lab Calibration and Stress Induction Protocol:
likemean,standarddeviation,skewness,andpercentileswere
During controlled in-lab sessions, after providing informed
extracted while frequency-domain features were excluded
consent,participantswerefittedwiththreewearabledevices:
due to their limited benefit in stress classification. For EDA,
theEmpaticaE4,GarminForerunner55,andPolarH10heart
we computed statistical features from the overall signal and
rate monitor. Additionally, ECG and EDA electrodes were
its tonic and phasic components, including peak count, area
attached and connected to the Biopac MP160 system for
under the curve (AUC), etc.
high-precision physiological data collection. As illustrated
3) Machine Learning Models and Evaluation: SVM and
in Fig. 1, the session began with a 10-minute baseline
RF models are known for their ability to perform better to
rest period, followed by three stress-inducing tasks, each
detect stress in prior literature [6], [7], [8], [5] by limiting
lasting four minutes and separated by a five-minute rest
overfitting and reducing the bias and variance tradeoffs.
period. The stress tasks included: (1) a mental arithmetic
SVM also consistently performed better when using only
challenge, where participants counted backward in steps of
heart rate and R-R interval features, while RF showed
seven from a large number; (2) a startle response task,
superior performance when incorporating additional features
involving unexpected loud noises; and (3) a cold pressor
such as EDA [33]. SVM with RBF kernel (C = 107,
task, requiring participants to submerge their hands in ice
γ = 0.001) and RF with 100 trees were used for LOSO
water.
cross-validation during cross-study evaluation. To assess
reproducibility, models trained on one dataset were tested C. Comparative Analysis of Stress Detection Performance
on another without hyperparameter tuning. We found that Across Devices
modelstrainedonPolarH7/H10generalizedbetterthanthose
Biopac MP160 provided EDA and ECG data during the
trainedonEmpaticaE4,suggestingsensorvariabilityaffects
lab session, with R-R intervals calculated using AcqKnowl-
model transferability.
edge software. Following our prior work on evaluating the
reproducibility of stress detection models [31], HR (and
B. Extending Stress Detection Reproducibility with Multi-
R-R interval) data were obtained from all devices, while
Device Testing
EDA data were specifically obtained from Empatica E4 and
Our prior work on evaluating the reproducibility of stress Biopac MP160. We pre-processed these physiological data
detection models focused on only two device types (Polar and extracted useful features. Using our 35 students’ in-lab
H7/H10andEmpaticaE4)[31].Thisrestrictsdevice-specific physiologicaldata,wetestedthereproducibilityofourstress
reproducibility, as physiological stress responses might vary detection tool, which was trained on the prior dataset, and
across devices in signal quality, preprocessing, and sensor outputaprobabilityofstressbasedonthefeaturesfroma60-
placement that impact model performance. Expanding our second window. To enrich our analysis, we also compared
analysis with diverse devices including consumer wearables the performance of our prior stress detection models with

TABLEII
COMPARATIVEANALYSISOFSTRESSDETECTIONMODELSACROSSMULTIPLEDEVICES(BIOPACMP160,POLARH10,EMPATICAE4,AND
GARMINFORERUNNER55S)INLABSESSION
|     |     |     |     |     | LOSOCross-Validation |     |     |     | Pre-trainedMishraetal.Model[31] |     |     |     |     |
| --- | --- | --- | --- | --- | -------------------- | --- | --- | --- | ------------------------------- | --- | --- | --- | --- |
TrainingData
Restvs.AllStressors Rest vs. Mental Arith- Restvs.AllStressors Rest vs. Mental Arith-
|     |     |     |     |     |     | meticStressor |     |     |     |     | meticStressor |     |     |
| --- | --- | --- | --- | --- | --- | ------------- | --- | --- | --- | --- | ------------- | --- | --- |
BiopacMP160 HRV:0.776[0.566-0.834] HRV:0.755[0.50-0.918] HRV:0.762[0.523-0.867] HRV:0.794[0.314-0.926]
HRV+EDA:0.984[0.908- HRV+EDA: 1.0 [0.941 - HRV+EDA: 0.970 [0.926, HRV+EDA: 0.999 [0.929,
|     |     |     | 0.995] |     |     | 1.0] |     | 0.994] |     |     | 1.000] |     |     |
| --- | --- | --- | ------ | --- | --- | ---- | --- | ------ | --- | --- | ------ | --- | --- |
PolarH10 HRV:0.73[0.62-0.84] HRV:0.954[0.85-0.983] HRV:0.729[0.599-0.844] HRV:0.961[0.858-0.998]
EmpaticaE4 HRV:0.61[0.51-0.77] HRV:0.905[0.848-0.974] HRV:0.548[0.443-0.834] HRV:0.913[0.835-0.969]
HRV+EDA: 0.884 [0.698- HRV+EDA: 0.953 [0.606- HRV+EDA: 0.736 [0.550, HRV+EDA: 0.723 [0.401,
|     |     |     | 0.944] |     |     | 0.999] |     | 0.865] |     |     | 0.964] |     |     |
| --- | --- | --- | ------ | --- | --- | ------ | --- | ------ | --- | --- | ------ | --- | --- |
GarminForerunner55s HRV:0.73[0.51-0.81] HRV:0.961[0.899-0.998] HRV:0.748[0.509-0.842] HRV:0.968[0.886-0.998]
ThecellsdenotethemedianAUROCscoreacrossallstudents,alongwiththeinter-quartilerange.
LOSO cross-validation using physiological data collected years, making up 63.9% of the sample. Females are the pre-
frommultipledevices(EmpaticaE4,GarminForerunner55s, dominantgenderidentityrepresented,accountingfor58.3%,
Biopac MP160, and Polar H10 chest monitor). We had two whilemalesandnon-binaryindividualscomprise38.9%and
models as mentioned one was an SVM model that outputs 2.8%, respectively. A small portion of the sample identifies
a probability of stress using just heart rate and R-R interval asHispanic/Latino,at16.7%.Intermsofacademicstanding,
features; the second was an RF model, that outputs an input sophomoresformthelargestgroup(41.7%),followedclosely
sample by computing the mean predicted class probabilities by seniors (25%), juniors (22.2%), and freshmen (11.1%).
ofthetreesintheforest[31].WeemployedtheSVMmodel This demographic spread suggests a diverse sample across
for analyses focusing solely on HRV data, irrespective of genders and academic years, with a lower representation of
the device. Conversely, when incorporating both HRV and ethnic diversity and age variation.
| EDA data,     | we   | applied  | RF to        | identify    | stress          | in controlled |                |                |                   |     |                 |     |         |
| ------------- | ---- | -------- | ------------ | ----------- | --------------- | ------------- | -------------- | -------------- | ----------------- | --- | --------------- | --- | ------- |
|               |      |          |              |             |                 |               | B. Comparative |                | Stress Prediction |     | Reproducibility |     | Perfor- |
| lab settings. | We   | assessed | the          | performance | of              | these models  |                |                |                   |     |                 |     |         |
|               |      |          |              |             |                 |               | mance          | Across Devices |                   |     |                 |     |         |
| using the     | Area | Under    | the Receiver | Operator    | Characteristics |               |                |                |                   |     |                 |     |         |
(AUROC) scores, a metric that measures a model’s ability Our findings are represented in Table II, which highlights
to differentiate between two classes independent of changes the predictive capabilities of HRV and EDA in stress detec-
in class distribution within the test set. tion models. We present the median AUROC scores (along
In our analysis, we considered the following scenarios: with the Interquartile Range) across all participants.
InScenario1(Restvs.AllStressors),underLOSOcross-
| Scenario | 1: 10 | minutes | of  | the first | baseline | is considered |     |     |     |     |     |     |     |
| -------- | ----- | ------- | --- | --------- | -------- | ------------- | --- | --- | --- | --- | --- | --- | --- |
0, and all three stressors are considered 1. Scenario 2: 10 validation, Biopac MP160 achieved an AUROC of 0.776
minutes of the first baseline is considered 0, but only the with HRV-only stress detection model while adding EDA
|                   |     |               |     |       |         |              | significantly | improved | performance |     | to an | AUROC | of 0.984, |
| ----------------- | --- | ------------- | --- | ----- | ------- | ------------ | ------------- | -------- | ----------- | --- | ----- | ----- | --------- |
| mental arithmetic |     | is considered |     | 1. We | decided | to break our |               |          |             |     |       |       |           |
evaluations across the two scenarios to enable a fair com- reinforcingtheadvantageofmultimodalsensing.Whentest-
ingthepre-trainedMishraetal.modelwithourstudy’sdata,
| parison with | the | model | we developed |     | in prior | work, which |     |     |     |     |     |     |     |
| ------------ | --- | ----- | ------------ | --- | -------- | ----------- | --- | --- | --- | --- | --- | --- | --- |
was trained only using the baseline and mental arithmetic BiopacMP160exhibitedslightlylowerperformanceinHRV-
stressors. For our LOSO evaluations, we employed SVM only model with an AUROC of 0.762 but maintained a high
|            |        |          |      |     |         |              | performance | AUROC | of 0.970 | when | incorporating |     | EDA, |
| ---------- | ------ | -------- | ---- | --- | ------- | ------------ | ----------- | ----- | -------- | ---- | ------------- | --- | ---- |
| (using the | LibSVM | library) | with | RBF | kernels | and RF algo- |             |       |          |      |               |     |      |
rithm(usingtheScikit-learnlibrary)astheprimarymachine- confirmingtherobustnessofitsphysiologicalmeasurements.
|          |        |     |          |        |             |           | In Scenario | 2 (Rest | vs. Mental | Arithmetic |     | Stressor), | LOSO |
| -------- | ------ | --- | -------- | ------ | ----------- | --------- | ----------- | ------- | ---------- | ---------- | --- | ---------- | ---- |
| learning | models | due | to their | robust | performance | in stress |             |         |            |            |     |            |      |
detection following the previously mentioned architecture. results showed that Biopac MP160 achieved an AUROC of
|     |     |     |     |     |     |     | 0.755 with  | HRV-only  | stress | detection | model,  | while      | HRV &   |
| --- | --- | --- | --- | --- | --- | --- | ----------- | --------- | ------ | --------- | ------- | ---------- | ------- |
|     |     |     |     |     |     |     | EDA reached | a perfect | AUROC  |           | of 1.0, | confirming | its su- |
III. RESULTS
|                       |     |     |                 |     |            |           | perior accuracy. | The | pre-trained | Mishra | et  | al. model | yielded |
| --------------------- | --- | --- | --------------- | --- | ---------- | --------- | ---------------- | --- | ----------- | ------ | --- | --------- | ------- |
| A. Socio-demographics |     |     | of Participants |     | in Digital | Phenotyp- |                  |     |             |        |     |           |         |
similartrends,withanAUROCof0.794forHRV-onlystress
| ing Stress | Study |     |     |     |     |     |     |     |     |     |     |     |     |
| ---------- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
detectionmodelandanAUROCof0.999withHRV&EDA,
Table I presents the socio-demographic breakdown of 35 indicating strong model generalizability for Biopac MP160.
undergraduate students who participated in our study. The However,itscumbersomesetup,andlackofportabilitylimit
majority of participants are in the age group of 20 to 22 its usability for real-world continuous stress monitoring.

In Scenario 1, LOSO evaluation showed that Polar H10 IV. DISCUSSIONS
chest monitor achieved an AUROC of 0.73 with its HRV-
We observed performance variations across devices and
only stress detection model, demonstrating its effectiveness
evaluation methods. While our pre-trained model demon-
asaresearch-gradestressmonitoringdevice.Thepre-trained
strated strong generalization for certain devices, such as
Mishra et al. model achieved a nearly identical performance
Garmin Forerunner 55s, Polar H10 heart rate monitor, and
with an AUROC of 0.729, reinforcing its reliability in
the gold-standard medical device Biopac MP160, noticeable
stress detection. In Scenario 2, LOSO results demonstrated
differences emerged in AUROC scores for Empatica E4,
improved performance for HRV-only model, with Polar H10
where the model did not generalize as effectively. These
achieving an AUROC of 0.954, confirming its ability to
variationsunderscoretheimportanceofdevice-specificeval-
effectively capture stressful episodes. Similarly, the pre-
uations when assessing consumer-grade stress monitoring
trainedMishraetal.modelachievedanAUROCof0.961,as
solutions. For device-specific reproducibility, as expected,
it was originally developed using the mental arithmetic task,
whenusingbothHRVandEDAsignalsfromBiopacMP160,
furthervalidatingtheconsistencyofourpriorstressdetection
we achieved the best performance, with almost perfect AU-
tool’s reproducibility. However, Polar H10’s chest-worn de-
ROC scores. We observed that data from Garmin devices
sign may reduce long-term usability, as its fixed wearability
often led to slightly better performance than the Polar H10
positionhampersflexibility,makingitlesspracticalfordaily
chest monitor illustrated in Fig 2. Both demonstrated high
continuous stress monitoring.
AUROC in the rest vs. mental arithmetic stress task, almost
For Empatica E4, in Scenario 1, LOSO evaluation
comparable to the Biopac MP160.
showed lower HRV-only performance, an AUROC of 0.61,
but performance significantly improved when combining
1.0 HRV & EDA with an AUROC of 0.884, reinforcing the im-
portanceofmultimodalsensing,asseenwithBiopacMP160.
However, the pre-trained Mishra et al. model exhibited poor
0.8
generalization, with HRV-only model achieving an AUROC
of 0.548, which, for a binary classification task, is almost
equivalent to random guessing. While adding HRV & EDA 0.6
improvedperformancewithanAUROCof0.736,itremained
lowerthanotherHRV&EDAmodels,indicatingthemodel’s
0.4
lackofgeneralizabilitywithEmpaticaE4’sdata.InScenario
2,LOSOresultsdemonstratedstrongHRV-onlyperformance
with an AUROC of 0.905 and HRV & EDA reaching an 0.2
AUROC of 0.953, comparable to Polar H10. However, the
pre-trained Mishra et al. model again failed to generalize
w o f s is u e f e r n n 0 l t s l h o . , o 7 e t r 2 w r a 3 f i o q p t c h r u r o o e r m H e p s a t e R p i l r o - a V w n c re i o o n & d n r g s l t d u o E t m s h D it t e e s r A e ’ r s r H w e s p l R e e t i r r a a V a f b r o - c a i o r k l b m i n i l t n e y l a y g n a . o m c s M f e o it d o E d i e r r s m e l o o p p p A v r p a U i e t i m i r n R c , g a a O E ri t m C l E o y p 4 o A u a ’ f s t s U i 0 e c R E . d a 9 D O 1 f E o 3 A C 4 r , Rest vs. All Str 0 e .0 ssors R (L e O st S O vs ) . Mental Ari R th e m st e v t s ic . A (L l O l S S t O re ) ssors R (M es is t h v r s a . e M t e a n l t . a m l A od ri e th l) metic (Mishra et al. model)
research purposes and lacks widespread consumer adoption.
Lastly, for Garmin Forerunner 55s, in Scenario 1,
LOSO evaluation showed strong HRV-only stress detection
performance with an AUROC of 0.73, demonstrating its
feasibilityforstressdetection,comparabletoPolarH10.The
pre-trainedMishraetal.modelobtainedsimilarresults,with
an AUROC of 0.748 for its HRV-only model, reinforcing its
potential in real-world applications. In Scenario 2, LOSO
results showed that Garmin watches outperformed Empatica
E4’s HRV-only model and even its’ combined HRV &
EDA model, achieving an AUROC of 0.961, highlighting its
effectivenessincapturingphysiologialstress.Thepre-trained
Mishra et al. model further confirmed Garmin Forerunner
55’s robustness, obtaining an AUROC of 0.968, outper-
forming Empatica E4’s HRV and HRV & EDA models.
Unlike Empatica E4, Garmin is a commercially established
consumer wearable with a substantial market share, making
it a practical and scalable solution for real-world stress
monitoring.
erocS
CORUA
Polar difference: 0.007 difference: 0.007
Garmin
difference: 0.000 difference: 0.019
Fig. 2. Stress detection performance comparison of consumer wearable,
Garmin Forerunner 55s and the research-grade Polar H10 in a lab setting
withminimaldifferencesinAUROCscores.GarminForerunner55soffers
greaterflexibilityforreal-worlduseduetoitswrist-worndesign,whereas
PolarH10’scheststrappositioningmaylimitwearabilityandconvenience
forlong-termstressmonitoring.
The HRV data from Empatica E4 alone had noticeably
poorer performance compared to Garmin and Polar devices.
However, adding EDA data, led to a significant perfor-
mance improvement in the LOSO evaluations. While the
Mishra et al. models for HRV+EDA were trained using
Empatica E4 data from the previous study, the model does
not appear to generalize well with our Empatica E4 data
(although the model works well with the Biopac MP160
data).TheHRV-onlymodelfromMishraetal.,whenapplied
to Garmin Forerunner 55s and the Polar H10 chest monitor,
mostly outperforms the HRV+EDA model using Empatica
E4. During detecting rest vs. all stressors in LOSO cross-
validation, we found that HRV+EDA model performance

from Empatica E4 was better than Garmin Forerunner 55s includemorediversepopulationswillimprovetheinclusivity
and Polar H10’s HRV-only models. In real-world settings, and generalizability of wearable-based monitoring. Lastly,
Empatica E4 has been reported to suffer from frequent largersamplesandadditionalanalysesarenecessarytoassess
artifacts and significant data loss in EDA recordings, often statisticaldifferencesinmodelperformanceacrossindividual
| caused      | by connection | loss    | of    | the electrodes |             | to the   | skin | devices. |     |     |     |     |     |     |     |
| ----------- | ------------- | ------- | ----- | -------------- | ----------- | -------- | ---- | -------- | --- | --- | --- | --- | --- | --- | --- |
| because     | of body       | motions | [34]. | These          | limitations | reduce   | its  |          |     |     |     |     |     |     |     |
| reliability | as a data     | source  | and   | make           | it less     | suitable | for  |          |     |     |     |     |     |     |     |
V. CONCLUSIONS
| comparison | with | Garmin | Forerunner | 55s. |     |     |     |     |     |     |     |     |     |     |     |
| ---------- | ---- | ------ | ---------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
In our analysis, given that the pre-trained Mishra et al. This paper extends stress detection reproducibility to con-
model performs well, with the Biopac MP160 data, we sumerwearablesensorsbyevaluatingstressdetectionmodels
|             |          |      |         |      |          |     |         | beyond traditional |     | research-grade |     | devices. | While | prior | work |
| ----------- | -------- | ---- | ------- | ---- | -------- | --- | ------- | ------------------ | --- | -------------- | --- | -------- | ----- | ----- | ---- |
| hypothesize | that the | data | quality | from | Empatica | E4  | devices |                    |     |                |     |          |       |       |      |
couldvarysignificantlywithdeployments,whichcouldresult focusedonresearchdeviceslikePolarH7/H10andEmpatica
|        |                         |     |     |        |             |     |         | E4, this | study | assesses | Garmin | Forerunner | 55, | a consumer |     |
| ------ | ----------------------- | --- | --- | ------ | ----------- | --- | ------- | -------- | ----- | -------- | ------ | ---------- | --- | ---------- | --- |
| in the | lack of reproducibility |     |     | of the | pre-trained |     | models, |          |       |          |        |            |     |            |     |
wearablewithalargemarketshare,todetermineitspotential
| but could | obtain | robust | performance | in  | our | LOSO | evalua- |     |     |     |     |     |     |     |     |
| --------- | ------ | ------ | ----------- | --- | --- | ---- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
tions. It’s worth mentioning that no additional actions were for stress monitoring. While our prior model demonstrated
relativelyconsistentperformanceacrossmostdevicesduring
| taken on | the Empatica | E4  | data | processing, | supporting |     | our |     |     |     |     |     |     |     |     |
| -------- | ------------ | --- | ---- | ----------- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
hypothesis that its quality might vary significantly across in-labstressdetection,itdidnotgeneralizewelltoEmpatica
deployments. Additionally, it is interesting to note that the E4,highlightingdevice-specificvariationsinstressdetection.
|     |     |     |     |     |     |     |     | Key findings | reveal | that | while | combining | HRV | and | EDA |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ------ | ---- | ----- | --------- | --- | --- | --- |
performancefromGarmindevicesusingHRValone,wason
par with Empatica E4 using HRV and EDA data in most fromtheBiopacMP160deviceyieldedthehigheststresspre-
|              |              |     |               |     |          |     |        | dictions | in lab | settings, | Garmin | wearables | demonstrated |     | su- |
| ------------ | ------------ | --- | ------------- | --- | -------- | --- | ------ | -------- | ------ | --------- | ------ | --------- | ------------ | --- | --- |
| evaluations, | particularly |     | for detecting |     | the rest | vs. | mental |          |        |           |        |           |              |     |     |
arithmetic tasks, thus highlighting its effectiveness in stress perior potential in stress monitoring. Empatica E4 performs
detection. Garmin watches’ superior performance may stem well when combining HRV and EDA, however, its HRV-
|               |            |     |               |     |                  |     |       | only or | HRV+EDA | models’ | performance |     | does | not | surpass |
| ------------- | ---------- | --- | ------------- | --- | ---------------- | --- | ----- | ------- | ------- | ------- | ----------- | --- | ---- | --- | ------- |
| from devices’ | consistent |     | data validity |     | and reliability, |     | espe- |         |         |         |             |     |      |     |         |
cially for HRV, which relies on accurate heart rate measure- Garmin Forerunner 55s, and its data quality might signif-
|               |            |     |     |              |      |           |     | icantly vary | across | devices | with | deployments. |     | While | both |
| ------------- | ---------- | --- | --- | ------------ | ---- | --------- | --- | ------------ | ------ | ------- | ---- | ------------ | --- | ----- | ---- |
| ments. Garmin | Forerunner |     | 55s | are slightly | more | expensive |     |              |        |         |      |              |     |       |      |
thanthePolarH10chestmonitors,however,thelightweight, Polar chest-worn and Garmin wrist-worn devices performed
wrist-worn design of Garmin watches enhances long-term comparably, Polar’s chest-worn design poses challenges for
|     |     |     |     |     |     |     |     | long-term | stress | monitoring | due | to discomfort |     | and | limited |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------ | ---------- | --- | ------------- | --- | --- | ------- |
usabilityandparticipantcomfortcomparedtothechest-worn
Polar,whichmaybecrucialforreal-world,continuousstress wearability. Finally, Garmin Forerunner 55s demonstrated
|             |       |         |         |     |             |     |       | potential | with | improved | stress | detection | performance, |     | com- |
| ----------- | ----- | ------- | ------- | --- | ----------- | --- | ----- | --------- | ---- | -------- | ------ | --------- | ------------ | --- | ---- |
| monitoring. | These | results | support | the | feasibility | of  | using |           |      |          |        |           |              |     |      |
HRV data alone from Garmin devices for stress detection. parable to research-grade devices, with the added advantage
With Garmin ranking fifth in global shipments of activity of consumer-friendly wearability for continuous monitoring.
|          |           |                   |     |        |     |            |     | This research |     | advances | digital | phenotyping |     | for stress | by  |
| -------- | --------- | ----------------- | --- | ------ | --- | ---------- | --- | ------------- | --- | -------- | ------- | ----------- | --- | ---------- | --- |
| trackers | [32], its | consumer-friendly |     | design | and | widespread |     |               |     |          |         |             |     |            |     |
adoption highlight its potential for everyday stress monitor- demonstrating the potential of consumer wearable Garmin
|     |     |     |     |     |     |     |     | Forerunner55s |     | inimprovingstress |     | detectionreproducibility. |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ----------------- | --- | ------------------------- | --- | --- | --- |
ing applications.
|       |              |         |          |     |          |      |         | Future work | should | explore | integrating |     | wearable | and | smart- |
| ----- | ------------ | ------- | -------- | --- | -------- | ---- | ------- | ----------- | ------ | ------- | ----------- | --- | -------- | --- | ------ |
| While | our findings | provide | valuable |     | insights | into | device- |             |        |         |             |     |          |     |        |
specific performance in stress detection, several limitations phone data to enhance stress prediction models and improve
|           |                  |     |          |                 |              |        |      | generalizability |     | “in-the-wild” | settings. |     |     |     |     |
| --------- | ---------------- | --- | -------- | --------------- | ------------ | ------ | ---- | ---------------- | --- | ------------- | --------- | --- | --- | --- | --- |
| should be | acknowledged.    |     | First,   | our participant |              | sample | con- |                  |     |               |           |     |     |     |     |
| sisted of | 35 undergraduate |     | students | from            | Northeastern |        | Uni- |                  |     |               |           |     |     |     |     |
versity, which may limit the generalizability of the re- REFERENCES
| sults to | broader | populations | such | as  | working | profession- |     |     |     |     |     |     |     |     |     |
| -------- | ------- | ----------- | ---- | --- | ------- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
als, older adults, patients, or children. Stress perception, [1] C. M. Vidal Bustamante, G. Coombs 3rd, H. Rahimi-Eichi, P. Mair,
J.-P.Onnela,J.T.Baker,andR.L.Buckner,“Fluctuationsinbehavior
physiological responses, and wearability preferences may and affect in college students measured using deep phenotyping,”
differ significantly across these groups. However, in this ScientificReports,vol.12,no.1,p.1932,2022.
study,weintentionallyfocusedonundergraduatestudents,as [2] Y. S. Can, B. Arnrich, and C. Ersoy, “Stress detection in daily life
scenariosusingsmartphonesandwearablesensors:Asurvey,”Journal
they are particularly vulnerable to mental health challenges ofbiomedicalinformatics,vol.92,p.103139,2019.
stemming from sustained academic pressure and societal [3] G. Vos, K. Trinh, Z. Sarnyai, and M. R. Azghadi, “Generalizable
|               |         |          |     |              |     |           |     | machine | learning | for stress | monitoring |     | from wearable | devices: | a   |
| ------------- | ------- | -------- | --- | ------------ | --- | --------- | --- | ------- | -------- | ---------- | ---------- | --- | ------------- | -------- | --- |
| expectations. | Second, | although |     | we evaluated |     | a diverse | set |         |          |            |            |     |               |          |     |
systematicliteraturereview,”InternationalJournalofMedicalInfor-
ofdevices—includingagold-standardmedical-gradesystem,
matics,vol.173,p.105026,2023.
| a chest-worn | heart | rate | monitor, | and | two wrist-worn |     | con- |                                                            |     |     |     |     |     |     |     |
| ------------ | ----- | ---- | -------- | --- | -------------- | --- | ---- | ---------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|              |       |      |          |     |                |     |      | [4] V.Mishra,G.Pope,S.Lord,S.Lewia,B.Lowens,K.Caine,S.Sen, |     |     |     |     |     |     |     |
R.Halter,andD.Kotz,“Continuousdetectionofphysiologicalstress
| sumer wearables—we |             | did   | not include |         | other widely |     | adopted |      |           |            |     |              |     |              |     |
| ------------------ | ----------- | ----- | ----------- | ------- | ------------ | --- | ------- | ---- | --------- | ---------- | --- | ------------ | --- | ------------ | --- |
|                    |             |       |             |         |              |     |         | with | commodity | hardware,” | ACM | transactions |     | on computing | for |
| devices            | such as the | Apple | Watch,      | Fitbit, | Samsung      |     | Galaxy  |      |           |            |     |              |     |              |     |
healthcare,vol.1,no.2,pp.1–30,2020.
Watch,Huawei,orXiaomiwearables.Futureresearchshould [5] Z.D.King,J.Moskowitz,B.Egilmez,S.Zhang,L.Zhang,M.Bass,
incorporate these high-market-share consumer-grade devices J.Rogers,R.Ghaffari,L.Wakschlag,andN.Alshurafa,“Micro-stress
ema:Apassivesensingframeworkfordetectingin-the-wildstressin
toincreasethesocietalrelevanceandreal-worldapplicability
|     |     |     |     |     |     |     |     | pregnant | mothers,” | Proceedings |     | of the ACM | on  | interactive, | mobile, |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | --------- | ----------- | --- | ---------- | --- | ------------ | ------- |
of stress detection tools. Expanding the participant pool to wearableandubiquitoustechnologies,vol.3,no.3,pp.1–22,2019.

[6] B.Egilmez,E.Poyraz,W.Zhou,G.Memik,P.Dinda,andN.Alshu- “Monitoring the impact of stress on the sleep patterns of pilgrims
rafa, “Ustress: Understanding college student subjective stress using using wearable sensors,” in IEEE-EMBS international conference on
wrist-basedpassivesensing,”in2017IEEEInternationalConference biomedicalandhealthinformatics(BHI). IEEE,2014,pp.185–188.
on Pervasive Computing and Communications Workshops (PerCom [23] M. Garbarino, M. Lai, D. Bender, R. W. Picard, and S. Tognetti,
Workshops). IEEE,2017,pp.673–678. “Empatica e3—a wearable wireless multi-sensor device for real-
[7] M. Gjoreski, M. Luštrek, M. Gams, and H. Gjoreski, “Monitoring time computerized biofeedback and data acquisition,” in 2014 4th
stress with a wrist device using context,” Journal of biomedical International Conference on Wireless Mobile Communication and
informatics,vol.73,pp.159–170,2017. Healthcare-Transforming Healthcare Through Innovations in Mobile
andWirelessTechnologies(MOBIHEALTH).
[8] K. Hovsepian, M. Al’Absi, E. Ertin, T. Kamarck, M. Nakajima, and IEEE,2014,pp.39–42.
S. Kumar, “cstress: towards a gold standard for continuous stress [24] Empatica, “Empatica E4,” https://www.empatica.com/research/e4/,
assessment in the mobile environment,” in Proceedings of the 2015 2018,[Online;accessed9-September-2023].
ACM international joint conference on pervasive and ubiquitous [25] Garmin, “Garmin Vivosmart 4,” https://www.garmin.com/en-US/p/
computing,2015,pp.493–504. 605739/,2021,[Online;accessed9-September-2023].
|     |     |     |     |     |     |     |     | [26] P. | E. Oy, | “Polar: | Heart Rate | Monitors, Sports |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | ------ | ------- | ---------- | ---------------- |
[9] H.Sarker,M.Tyburski,M.M.Rahman,K.Hovsepian,M.Sharmin,
D.H.Epstein,K.L.Preston,C.D.Furr-Holden,A.Milam,I.Nahum- Watches & Fitness Trackers,” https://www.polar.
Shani et al., “Finding significant stress episodes in a discontinuous com/us-en/sensors/h10-heart-rate-sensor?srsltid=
time series of rapidly varying mobile sensor data,” in Proceedings AfmBOopon2jRRvdFZxksQjfNgpZIoSZ-jvAnnarzPJAuDgUFuFf7Cap3/,
ofthe2016CHIconferenceonhumanfactorsincomputingsystems, 2025,[Online;accessed7-February-2025].
|     |     |     |     |     |     |     |     | [27] Garmin, | “Garmin | HRM | Dual,” https://www.garmin.com/en-US/p/ |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ------- | --- | -------------------------------------- | --- |
2016,pp.4489–4501.
649059/,2021,[Online;accessed9-September-2023].
[10] G.Chen,V.Mishra,andC.-H.Chen,“Temporalfactorsoflisteningto
musiconstressreduction,”inAdjunctProceedingsofthe2019ACM [28] M. B. Bin Heyat, F. Akhtar, S. J. Abbas, M. Al-Sarem, A. Alqarafi,
InternationalJointConferenceonPervasiveandUbiquitousComput- A. Stalin, R. Abbasi, A. Y. Muaad, D. Lai, and K. Wu, “Wearable
ing and Proceedings of the 2019 ACM International Symposium on flexible electronics based cardiac electrode for researcher mental
stressdetectionsystemusingmachinelearningmodelsonsinglelead
WearableComputers,2019,pp.907–914.
electrocardiogramsignal,”Biosensors,vol.12,no.6,p.427,2022.
[11] K.Plarre,A.Raij,S.M.Hossain,A.A.Ali,M.Nakajima,M.Al’Absi,
E.Ertin,T.Kamarck,S.Kumar,M.Scottetal.,“Continuousinference [29] P.DiCampliSanVito,G.Shakeri,J.Ross,X.Yang,andS.Brewster,
of psychological stress from sensory measurements collected in the “Development of a real-time stress detection system for older adults
natural environment,” in Proceedings of the 10th ACM/IEEE inter- with heart rate data,” in Proceedings of the 16th International Con-
ferenceonPErvasiveTechnologiesRelatedtoAssistiveEnvironments,
| national | conference |     | on information | processing |     | in sensor | networks. |     |     |     |     |     |
| -------- | ---------- | --- | -------------- | ---------- | --- | --------- | --------- | --- | --- | --- | --- | --- |
2023,pp.226–236.
IEEE,2011,pp.97–108.
[12] H.Lu,D.Frauendorfer,M.Rabbi,M.S.Mast,G.T.Chittaranjan,A.T. [30] R. Bari, M. M. Rahman, N. Saleheen, M. B. Parsons, E. H. Buder,
Campbell,D.Gatica-Perez,andT.Choudhury,“Stresssense:Detecting andS.Kumar,“Automateddetectionofstressfulconversationsusing
stressinunconstrainedacousticenvironmentsusingsmartphones,”in wearablephysiologicalandinertialsensors,”ProceedingsoftheACM
oninteractive,mobile,wearableandubiquitoustechnologies,vol.4,
| Proceedings |     | of the 2012 | ACM | conference | on ubiquitous |     | computing, |     |     |     |     |     |
| ----------- | --- | ----------- | --- | ---------- | ------------- | --- | ---------- | --- | --- | --- | --- | --- |
no.4,pp.1–23,2020.
2012,pp.351–360.
[13] E. A. Sag˘bas¸, S. Korukoglu, and S. Balli, “Stress detection via [31] V. Mishra, S. Sen, G. Chen, T. Hao, J. Rogers, C.-H. Chen, and
keyboardtypingbehaviorsbyusingsmartphonesensorsandmachine D.Kotz,“Evaluatingthereproducibilityofphysiologicalstressdetec-
tionmodels,”ProceedingsoftheACMoninteractive,mobile,wearable
| learning | techniques,” |     | Journal | of medical | systems, | vol. | 44, pp. 1–12, |     |     |     |     |     |
| -------- | ------------ | --- | ------- | ---------- | -------- | ---- | ------------- | --- | --- | --- | --- | --- |
andubiquitoustechnologies,vol.4,no.4,pp.1–29,2020.
2020.
|     |     |     |     |     |     |     |     | [32] K. R. | Evenson | and C. L. | Spade, “Review | of validity and reliability |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ------- | --------- | -------------- | --------------------------- |
[14] E.Garcia-Ceja,V.Osmani,andO.Mayora,“Automaticstressdetec-
tioninworkingenvironmentsfromsmartphones’accelerometerdata:a ofgarminactivitytrackers,”Journalforthemeasurementofphysical
firststep,”IEEEjournalofbiomedicalandhealthinformatics,vol.20, behaviour,vol.3,no.2,pp.170–185,2020.
[33] V.Mishra,G.Pope,S.Lord,S.Lewia,B.Lowens,K.Caine,S.Sen,
no.4,pp.1053–1060,2015.
R.Halter,andD.Kotz,“Thecaseforacommodityhardwaresolution
| [15] A. Bogomolov, |        | B. Lepri,   | M.  | Ferron, F.      | Pianesi, | and A. | S. Pentland, |     |                    |                |        |                        |
| ------------------ | ------ | ----------- | --- | --------------- | -------- | ------ | ------------ | --- | ------------------ | -------------- | ------ | ---------------------- |
|                    |        |             |     |                 |          |        |              | for | stress detection,” | in Proceedings | of the | 2018 ACM international |
| “Pervasive         | stress | recognition |     | for sustainable | living,” | in     | 2014 IEEE    |     |                    |                |        |                        |
internationalconferenceonpervasivecomputingandcommunication jointconferenceand2018internationalsymposiumonpervasiveand
workshops(PERCOMWORKSHOPS). IEEE,2014,pp.345–350. ubiquitouscomputingandwearablecomputers,2018,pp.1717–1728.
[34] S.Böttcher,S.Vieluf,E.Bruno,B.Joseph,N.Epitashvili,A.Biondi,
[16] A.SanoandR.W.Picard,“Stressrecognitionusingwearablesensors
N.Zabler,M.Glasstetter,M.Dümpelmann,K.VanLaerhovenetal.,
| and                                          | mobile | phones,” | in 2013 | Humaine | association | conference        | on  |       |                    |     |                          |                     |
| -------------------------------------------- | ------ | -------- | ------- | ------- | ----------- | ----------------- | --- | ----- | ------------------ | --- | ------------------------ | ------------------- |
|                                              |        |          |         |         |             |                   |     | “Data | quality evaluation |     | in wearable monitoring,” | Scientific reports, |
| affectivecomputingandintelligentinteraction. |        |          |         |         |             | IEEE,2013,pp.671– |     |       |                    |     |                          |                     |
vol.12,no.1,p.21412,2022.
676.
| [17] R. Wang, | F.       | Chen, Z.      | Chen,          | T. Li, G.      | Harari, | S. Tignor, | X. Zhou,     |     |     |     |     |     |
| ------------- | -------- | ------------- | -------------- | -------------- | ------- | ---------- | ------------ | --- | --- | --- | --- | --- |
| D. Ben-Zeev,  |          | and A.        | T. Campbell,   | “Studentlife:  |         | assessing  | mental       |     |     |     |     |     |
| health,       | academic | performance   |                | and behavioral |         | trends of  | college stu- |     |     |     |     |     |
| dents         | using    | smartphones,” | in Proceedings |                | of the  | 2014       | ACM interna- |     |     |     |     |     |
tionaljointconferenceonpervasiveandubiquitouscomputing,2014,
pp.3–14.
| [18] J. Choi, | B.  | Ahmed, | and R. | Gutierrez-Osuna, |     | “Development | and |     |     |     |     |     |
| ------------- | --- | ------ | ------ | ---------------- | --- | ------------ | --- | --- | --- | --- | --- | --- |
evaluationofanambulatorystressmonitorbasedonwearablesensors,”
IEEEtransactionsoninformationtechnologyinbiomedicine,vol.16,
no.2,pp.279–286,2011.
[19] A.Greco,G.Valenza,A.Lanata,E.P.Scilingo,andL.Citi,“cvxeda:
Aconvexoptimizationapproachtoelectrodermalactivityprocessing,”
IEEEtransactionsonbiomedicalengineering,vol.63,no.4,pp.797–
804,2015.
| [20] F.-T. | Sun, | C. Kuo, | H.-T. Cheng, | S.  | Buthpitiya, | P.  | Collins, and |     |     |     |     |     |
| ---------- | ---- | ------- | ------------ | --- | ----------- | --- | ------------ | --- | --- | --- | --- | --- |
M.Griss,“Activity-awarementalstressdetectionusingphysiological
| sensors,”     | in      | Mobile Computing, |               | Applications, |       | and Services: | Second     |     |     |     |     |     |
| ------------- | ------- | ----------------- | ------------- | ------------- | ----- | ------------- | ---------- | --- | --- | --- | --- | --- |
| International |         | ICST Conference,  |               | MobiCASE      | 2010, | Santa         | Clara, CA, |     |     |     |     |     |
| USA,          | October | 25-28,            | 2010, Revised | Selected      |       | Papers 2.     | Springer,  |     |     |     |     |     |
2012,pp.282–301.
[21] T.Stuart,J.Hanna,andP.Gutruf,“Wearabledevicesforcontinuous
monitoringofbiosignals:Challengesandopportunities,”APLbioengi-
neering,vol.6,no.2,2022.
[22] A.Muaremi,A.Bexheti,F.Gravenhorst,B.Arnrich,andG.Tröster,
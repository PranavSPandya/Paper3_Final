| Journal ofVision(2016)16(3):27, |      | 1–15     |     |     |        |     |     |         |     |         |     |     |            |     | 1   |
| ------------------------------- | ---- | -------- | --- | --- | ------ | --- | --- | ------- | --- | ------- | --- | --- | ---------- | --- | --- |
| Mobile                          | gaze | tracking |     |     | system |     | for | outdoor |     | walking |     |     | behavioral |     |     |
studies
|           |           |     |     |     |     | Schepens |         | Eye Research |         | Institute, | Mass    | Eye | and Ear, |     |     |
| --------- | --------- | --- | --- | --- | --- | -------- | ------- | ------------ | ------- | ---------- | ------- | --- | -------- | --- | --- |
| Matteo    | Tomasi    |     |     |     |     |          |         |              |         |            |         |     |          |     | $   |
|           |           |     |     |     |     |          | Harvard |              | Medical | School,    | Boston, |     | MA, USA  |     |     |
|           |           |     |     |     |     | Schepens |         | Eye Research |         | Institute, | Mass    | Eye | and Ear, |     |     |
| Shrinivas | Pundlik   |     |     |     |     |          |         |              |         |            |         |     |          |     |     |
|           |           |     |     |     |     |          | Harvard |              | Medical | School,    | Boston, |     | MA, USA  |     |     |
|           |           |     |     |     |     | Schepens |         | Eye Research |         | Institute, | Mass    | Eye | and Ear, |     |     |
| Alex      | R. Bowers |     |     |     |     |          |         |              |         |            |         |     |          |     |     |
|           |           |     |     |     |     |          | Harvard |              | Medical | School,    | Boston, |     | MA, USA  |     |     |
|           |           |     |     |     |     | Schepens |         | Eye Research |         | Institute, | Mass    | Eye | and Ear, |     |     |
| Eli Peli  |           |     |     |     |     |          | Harvard |              | Medical | School,    | Boston, |     | MA, USA  |     |     |
|           |           |     |     |     |     | Schepens |         | Eye Research |         | Institute, | Mass    | Eye | and Ear, |     |     |
| Gang      | Luo       |     |     |     |     |          |         |              |         |            |         |     |          |     |     |
|           |           |     |     |     |     |          | Harvard |              | Medical | School,    | Boston, |     | MA, USA  |     |     |
Most gaze tracking techniques estimate gaze points on head and eye movements (Land, 2004). In many vision
| screens, | on scene images, |     | or in confined |     | spaces.Tracking |     |     |          |         |           |     |         |           |     |         |
| -------- | ---------------- | --- | -------------- | --- | --------------- | --- | --- | -------- | ------- | --------- | --- | ------- | --------- | --- | ------- |
|          |                  |     |                |     |                 |     |     | research | studies | involving |     | stimuli | presented | on  | a fixed |
of gaze in open-world coordinates, especially in walking display,thesubject’sheadisoftenstabilizedusingachin
situations, has rarely been addressed. We use a head- rest,unlesstheeyetrackingsystemisabletoaccountfor
| mounted     | eye tracker | combined | with     | two  | inertial    |     |     |          |           |           |      |             |       |         |      |
| ----------- | ----------- | -------- | -------- | ---- | ----------- | --- | --- | -------- | --------- | --------- | ---- | ----------- | ----- | ------- | ---- |
|             |             |          |          |      |             |     |     | the head | movement, |           | when | determining | gaze  | points  | on a |
| measurement | units       | (IMU)    | to track | gaze | orientation |     |     |          |           |           |      |             |       |         |      |
|             |             |          |          |      |             |     |     | screen   | (Barabas, | Goldstein |      | et al.,     | 2004; | Cesqui, | de   |
relativetotheheadingdirectioninoutdoorwalking.Head
|            |           |         |      |              |        |        |     | Langenberg |      | et al.,   | 2013; Johnson,   |           | Liu et   | al., 2007). |         |
| ---------- | --------- | ------- | ---- | ------------ | ------ | ------ | --- | ---------- | ---- | --------- | ---------------- | --------- | -------- | ----------- | ------- |
| movements  | relative  | to the  | body | are measured |        | by the |     |            |      |           |                  |           |          |             |         |
|            |           |         |      |              |        |        |     | In studies |      | involving | mobile           | subjects, | two      | approaches  |         |
| difference | in output | between | the  | IMUs         | on the | head   | and |            |      |           |                  |           |          |             |         |
|            |           |         |      |              |        |        |     | have been  | used | for       | gaze estimation: |           | tracking | of          | eye-in- |
bodytrunk.TheuseoftheIMUpairreducestheimpactof
|               |              |       |           |            |       |        |     | head orientationwith |     |      | registrationof |         | the    | eye positionon |     |
| ------------- | ------------ | ----- | --------- | ---------- | ----- | ------ | --- | -------------------- | --- | ---- | -------------- | ------- | ------ | -------------- | --- |
| environmental | interference |       | on each   | sensor.The |       | system |     |                      |     |      |                |         |        |                |     |
|               |              |       |           |            |       |        |     | scene images         |     | from | a head         | mounted | camera | (Fotios,       |     |
| was tested    | in busy      | urban | areas and | allowed    | drift |        |     |                      |     |      |                |         |        |                |     |
Uttleyetal.,2014;Li,Munnetal.,2008),ortrackingthe
| compensation | for long    | (up   | to 18    | min) gaze | recording. |       |     |                  |     |     |            |             |     |       |     |
| ------------ | ----------- | ----- | -------- | --------- | ---------- | ----- | --- | ---------------- | --- | --- | ---------- | ----------- | --- | ----- | --- |
|              |             |       |          |           |            |       |     | gaze orientation |     | in  | a confined | environment |     | using |     |
| Comparison   | with ground | truth | revealed |           | an average | error |     |                  |     |     |            |             |     |       |     |
of3.38whilewalkingstraightsegments.Therangeofgaze multiple cameras (Land, 2004). In the former approach,
scanning in walking is frequently larger than the the head orientation is typically not measured, and
|            |          |       |           |     |            |     |     | interpretation |     | of gaze | behaviors |     | requires | visual | exami- |
| ---------- | -------- | ----- | --------- | --- | ---------- | --- | --- | -------------- | --- | ------- | --------- | --- | -------- | ------ | ------ |
| estimation | error by | about | one order | of  | magnitude. | Our |     |                |     |         |           |     |          |        |        |
proposed method was also tested with real cases of nation of the recorded scene videos and manual data
natural walking and it was found to be suitable for the entry of head orientation. Using the latter approach,
evaluation of gaze behaviors in outdoor environments. tracking both the eye position (in head) and the head
|     |     |     |     |     |     |     |     | orientation, | makes |              | it possible | to       | measure       | the gaze   | point |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ----- | ------------ | ----------- | -------- | ------------- | ---------- | ----- |
|     |     |     |     |     |     |     |     | in real      | world | coordinates. |             | However, | this          | is usually |       |
|     |     |     |     |     |     |     |     | performed    | only  | in           | confined    | indoor   | or within-car |            |       |
Introduction
environments,wheretheheadorientation(relativetothe
|     |     |     |     |     |     |     |     | car) can | be tracked |     | by the | sensing | system | set up | in the |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ---------- | --- | ------ | ------- | ------ | ------ | ------ |
Analysis of gaze orientation is essential to answering enclosed environment (Barabas, Goldstein et al., 2004;
questions about where people look and why (Eggert, Bowers, Ananyev et al., 2014; Cesqui, de Langenberg et
2007; Godwin, Agnew et al., 2009; Hansen & Qiang al., 2013; Essig, Dornbuschet al., 2012; Grip, Jull et al.,
2010; Itti, 2005; Land & Furneaux 1997; Land, Mennie 2009; Imai, Moore et al., 2001; Kugler, Huppert et al.;
etal.1999).Whereapersonislookingisaresultofboth Land 2009; Lin, Ho et al., 2007; MacDougall & Moore
Tomasi, M., Pundlik, S., Bowers, A. R., Peli, E., & Luo, G. (2016). Mobile gaze tracking system for outdoor walking behavioral
| studies. | Journal of Vision, | 16(3):27, |     | 1–15, | doi:10.1167/16.3.27. |     |     |     |     |     |     |     |     |     |     |
| -------- | ------------------ | --------- | --- | ----- | -------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
doi: 10.1167/16.3.27 Received July13, 2015;published February 19, 2016 ISSN 1534-7362
ThisworkislicensedunderaCreativeCommonsAttribution-NonCommercial-NoDerivatives4.0InternationalLicense.
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

Journal ofVision(2016)16(3):27, 1–15 Tomasi etal. 2
2005; Proudlock, Shekhar et al., 2003). Due to technical undertheseconditions.Themainchallengeisintracking
difficulties in outdoor gaze tracking, there have been head orientation. Shoulder mounted cameras have been
only a few behavioral studies (Geruschat, Hassan et al., proposed to track the head in outdoor environments
2006; Hassan, Geruschat et al., 2005; ’t Hart & (Essig, Dornbusch et al. 2012; Imai, Moore et al. 2001).
Einhauser, 2012) that investigated gaze behaviors while However,naturalbodywobblingwhilewalkingrequires
walking in uncontrolled outdoor open spaces. Further- specialhandlingof thecamera because thesway motion
more, analyses of these studies were limited by the introduces noise that is computationally and technically
challengeofmanualprocessingoflarge volumesofgaze challengingtocancel.Swaymotioncancellationhasbeen
data. For example, in studies of gaze behaviors during performed in humanoid robots in which more informa-
street crossings at intersections (Hassan, Geruschat et tion about the self-movement is available (Dune, Herdt
al., 2005), the head mounted scene videos were visually et al. 2010) but not in real walking.
examined and gaze behaviors were manually classified Computer vision techniques for orientation estima-
coarselyasleft,center,orrightrelativetothecrosswalk. tion, such as simultaneous localization and mapping
The quantitative analysis of a large amount of gaze (SLAM; Davison, Reid et al. 2007), have been
tracking data is impractical with such a technique. proposed for robot navigation applications. However,
Quantitative analyses of gaze tracking data can be eventhelatestSLAM-basedmethodshavesomecrucial
valuable and provide important behavioral insights that limitations that make them ill suited to estimate head
eyetracking dataalone cannot.For instance,for people movement using a head-mounted scene camera. These
withperipheralvisualfieldloss,suchastunnelvisionand approaches are inherently iterative and require exten-
hemianopia, two hypotheses can be proposed regarding siveamountofpriortuning,astheyrelyonrecognition
theirgazescanningstrategies.Ononehand,accordingto of stable landmarks for localization and mapping over
a bottom-up eye movement model, they might make multipleruns,andtheestimationerrorscanaccumulate
smallergazemovementsthannormallysightedobservers over time. Such approaches face difficult challenges
due to the lack of visual stimuli from the periphery when applied to walking in natural environments (e.g.,
(Coeckelbergh,W.Cornelissenetal.,2002).Ontheother on a busy city street) characterized by uncontrolled
hand, according to a top-down eye movement model, changes, such as passing pedestrians and vehicles.
theymightmakelargegazemovementstowardtheblind To solve the problem, an existing commercial eye
area to compensate for their field loss (Martin, Riley et tracking system, EyeSeeCam (Interacoustics, Eden Prai-
al.,2007;Papageorgiou,Hardiessetal.,2012).Luoetal. rie, MN),mountsan eyetrackertogetherwith a motion
(2008) measuring only eye-in-head orientation, found sensor on the head. An application for this system was
that people with tunnel visionmade saccadesaslargeas presented by Kugler et al. (2014), who used the
normallysightedinoutdoorwalkingandtheyfrequently EyeSeeCam device for measuring the gaze-in-space of
moved their eyes to presaccadic invisible areas. This subjects standingstillon an emergencybalconyfor30s.
finding suggests that top-down mechanisms play an Motion sensor drift can present a significant problem
important role in eye movement planning. However, a whensensorsareusedinuncontrolledsituations,suchas
question remains unanswered—did the patients with outdoorwalking.Kugleretal.(2014)likelyavoidedthese
tunnel vision and the normally sighted observers look problemsbecausetherecordingtimewasveryshort.Ina
toward the same areas? For example, it is possible that similar manner, Larsson et al. (2014) proposed the
patientswithperipheralvisionlosstendtolookdownat integration of a mobile eye tracking system with one
thegroundbyloweringtheirheadorientationmorethan inertial measurement unit (IMU) for head movement
normally sighted observers while maintaining the same compensation in an indoor scenario, again avoiding the
eyescanningpatterns,ortheycouldbescanninglaterally many problems of sensor drift in outdoor recordings.
with their heads more than the normally sighted We present a novel approach for tracking gaze
observers as a compensatory strategy? Measuring eye relative to the heading direction while walking out-
movements alone will miss these behaviors. Also, when doors realized via a portable system comprised of a
considering gaze patterns in normally sighted people, head mounted eye tracker and a pair of off-the-shelf
Kinsmanetal.(2012)suggestthat,inthepresenceofthe motion sensors for head movement tracking. In
vestibular-ocular response (VOR), the head counteracts contrasttothemobiletrackingdevicesimplementedby
eye-in-head rotation and knowing the head rotation Kugler et al. (2014) and Larsson et al. (2014), which
improves the detection of fixations. To address such used only one motion sensor, we use a pair of motion
questions, gaze orientation that combines eye and head sensors to address the problem of sensor drift that
has to be measured. occurs during extended periods of outdoor recording.
A system able to record gaze orientation in natural The system was designed to measure gaze and head
walking conditions would be a useful tool for quantita- scanning behaviors of visually impaired people as well
tivestudies;yet,noneoftheexistingmethodsallowusto asnormallysightedpeople,andwastestedonbusycity
easily and reliably record and analyze gaze orientation streets in order to demonstrate its potential use for
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     |     | 1–15 |     |     |     |     | Tomasi | etal. |     |     |     |     |     | 3   |
| ------------------------------- | --- | --- | ---- | --- | --- | --- | --- | ------ | ----- | --- | --- | --- | --- | --- | --- |
Figure 1.The mobile eye and head tracking system. (a) Rear view showing the two data logging computers on the backpack for
recordingeyeandheadmovements.Theeyemovementloggeralsorecordsthevideofromthescenecamera.(b)Frontviewofthe
system showing the eye tracker headgear (eye tracking and scene cameras) and the body and head tracking sensors.
addressing the challenges in recording and analyzing tracker records two videos (one directed to the eye and
human gaze patterns in outdoor environments. theotherdirectedtotheforwardscene)andthemotion
|     |     |     |     |     |     |     |     |     | sensor    | output; all these | data | streams | are | logged | at a |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | ----------------- | ---- | ------- | --- | ------ | ---- |
|     |     |     |     |     |     |     |     |     | frequency | of 30 Hz.         |      |         |     |        |      |
Materials and methods In the following subsections we detail each part of
|             |             |               |                |            |             |           |          |      | the system  | and the integration  |          | of          | all collected |          | data     |
| ----------- | ----------- | ------------- | -------------- | ---------- | ----------- | --------- | -------- | ---- | ----------- | -------------------- | -------- | ----------- | ------------- | -------- | -------- |
|             |             |               |                |            |             |           |          |      | during      | the post-processing. |          |             |               |          |          |
| Our         | portable    | gaze          | tracking       | system     |             | includes  | a        |      |             |                      |          |             |               |          |          |
| commercial  |             | eye tracking  |                | system     | from        | Positive  | Science  |      |             |                      |          |             |               |          |          |
| (Positive   | Science,    | New           | York           | City,      | NY;         | 2013)     | and      | two  |             |                      |          |             |               |          |          |
|             |             |               |                |            |             |           |          |      | Eye tracker |                      |          |             |               |          |          |
| commercial  |             | IMUs          | from VectorNav |            | (VectorNav, |           |          | Dal- |             |                      |          |             |               |          |          |
| las, TX).   | We          | integrated    | these          | components |             |           | in a     |      |             |                      |          |             |               |          |          |
|             |             |               |                |            |             |           |          |      | The         | Positive Science     | eye      | tracker     | (Figure       | 1b)      | includes |
| lightweight | backpack    |               | system         | (Figure    |             | 1), which | is       |      |             |                      |          |             |               |          |          |
|             |             |               |                |            |             |           |          |      | an eye      | tracking camera      | and      | a scene     | (608          | field    | of view) |
| reasonably  | comfortable |               | for            | the        | wearer.     |           |          |      |             |                      |          |             |               |          |          |
|             |             |               |                |            |             |           |          |      | camera,     | bothmountedon        | oneside  |             | of aspectacle |          | frame    |
| While       | the         | head tracking |                | system     | is          | capable   | of       |      |             |                      |          |             |               |          |          |
|             |             |               |                |            |             |           |          |      | to track    | one of the eyes.     | This     | arrangement |               | enables  | the      |
| measuring   | yaw,        | pitch,        | and            | roll       | of the      | head      | relative | to   |             |                      |          |             |               |          |          |
|             |             |               |                |            |             |           |          |      | mountingof  | prescription         | lensesin |             | frontof       | botheyes | as       |
| the body    | trunk,      | in            | this paper,    | we         | focus       | on        | the yaw  |      |             |                      |          |             |               |          |          |
measurement because of its importance in street well as optical visual field expansion devices (e.g.,
|     |     |     |     |     |     |     |     |     | peripheral | prism glasses | for | hemianopia; |     | Bowers, |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ------------- | --- | ----------- | --- | ------- | --- |
walkingandroadcrossing.Itwouldbestraightforward
to extend our technique to the pitch movements Keeney et al., 2008; Giorgi, Woods et al., 2009; Peli,
(vertical movements of the head and eyes). Our gaze 2000) fitted to the other eye not being tracked.
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     |     | 1–15 |     |     | Tomasi | etal. |     |     |     |     |     | 4   |
| ------------------------------- | --- | --- | ---- | --- | --- | ------ | ----- | --- | --- | --- | --- | --- | --- |
We use a 13-point calibration for eye tracking at the sensor is secured on a hat visor that the subject wears,
beginning and the end of each recording session to while the other is attached to the belt and used as a
detect any displacement of the headgear during the reference. The sensors are connected to a laptop in the
| walk. The | calibration | is  | performed | at  | a distance | of 4 m | backpack. |     |     |     |     |     |     |
| --------- | ----------- | --- | --------- | --- | ---------- | ------ | --------- | --- | --- | --- | --- | --- | --- |
using fixation targets posted on a whiteboard covering With a two-sensor system, where one of the sensors
the full scene camera image. If the point correspon- is mounted on the waist, we are able to measure
dences between the two calibrations match, it means horizontal head rotations relative to the body by
that there were no shifts of the cameras. In such cases, computing the difference between the two sensors. For
wecanusethesamecalibrationforthewholesequence. this mode of use it is important to use sensors that are
Otherwise,thesequenceissplitintwounequalparts,in as matched as possible to reduce uncorrelated noise
which the first calibration is applied to the initial part across the sensors and benefit from the differential
ofthedata,andthesecondcalibrationtothelatterpart signal. Correlated external interference, affecting both
of the data. In order to localize the split point in the sensors in a similar manner because of their proximity,
acquired data, we perform brief calibration checks will be cancelled out when the differential signal is
along the outdoor walking route at convenient computed providing a cleaner signal of head orienta-
locations, where the subject looks at a specified point tion relative to the body (see Results).
and confirms it verbally. The experimenter asks the However, even when a differential signal is used, the
subjecttofixateonspecificpointsandaudioisrecorded outputs of both sensors may still drift relative to each
to help with identifying the calibration points when other because of uncorrelated noise. In these cases, the
playing back the scene video for postprocessing. drift is not necessarily predictable and it might depend
Whenever the eye tracker output confirms an accurate on uncontrolled external factors that affect the two
location of the point of regard (POR) we assume that sensors in a different way or internal noise, which is
the prewalk calibration is valid for the video otherwise differentinbothsensors.Inordertoreduceerrorsfrom
we verify again with the calibration performed at the uncorrelated external or internal noise, we included in
end. The best calibration is applied for the segment. If our experimental protocol several reset operations
none of the calibration is found valid, the correspond- performed at preset checkpoints along the outdoor
ing segments are discarded from analyses. route. The location of the checkpoints depends on the
|     |     |     |     |     |     |     | distance      | walked, | and    | it is  | preferable | to set checkpoints |     |
| --- | --- | --- | --- | --- | --- | --- | ------------- | ------- | ------ | ------ | ---------- | ------------------ | --- |
|     |     |     |     |     |     |     | after turning |         | points | on the | walking    | path. At the       |     |
Head tracking system checkpoints, the subject is asked to pause briefly and
lookstraightahead.Aheadingresetcommandisissued
WeuseIMUsforheadtracking,whichrequiremuch (to the logging computer) to realign the orientations of
simpler processing than video-based head tracking the two sensors and therefore minimize the impact of
cameras. The IMU is comprised of accelerometers, possible differentialdrifts. The quick verificationof the
|             |                |     |     |                    |     |     | eye tracker | calibration, |     | described |     | earlier, is performed |     |
| ----------- | -------------- | --- | --- | ------------------ | --- | --- | ----------- | ------------ | --- | --------- | --- | --------------------- | --- |
| gyroscopes, | magnetometers, |     | and | a microcontroller. |     |     |             |              |     |           |     |                       |     |
Gyroscopes are notorious for drifting over time. The at the same time.
magnetometer, acting as a reference, is used to correct With the software development kit provided for
the gyroscopic drift over time using Kalman filters. the IMUs, we have developed customized software
With sensor fusion technology, this type of IMU for logging the inertial data. This software also deals
normally can perform well without severe drifting in with basic sensor diagnostics, parameter setting, and
suitable environments. However, they are not com- user interaction. The software runs on a lightweight
|                             |     |     |            |     |                |     | ASUS | Eee PC | notebook |     | with an | Intel Atom N455 |     |
| --------------------------- | --- | --- | ---------- | --- | -------------- | --- | ---- | ------ | -------- | --- | ------- | --------------- | --- |
| pletely interference-proof, |     |     | especially |     | in complicated |     |      |        |          |     |         |                 |     |
environments, such as busy downtown areas, where a processor,mountedonthebackpack(Figure1a).The
strong presence of electromagnetic and metallic objects output provided is a text file containing timestamp in
disturbs the local Earth magnetic fields. We use a few seconds, orientation in degrees, acceleration in
strategies, described below, to address the problems of meters per second squared, and angular velocity in
|     |     |     |     |     |     |     | degrees | per second |     | for both | sensors. | The software |     |
| --- | --- | --- | --- | --- | --- | --- | ------- | ---------- | --- | -------- | -------- | ------------ | --- |
sensordriftandmagneticinterference.Specificallywith
a pair of matched IMUs, external electromagnetic keeps track of the reset points and can record a key
|                 |               |            |                     |            |            |       | code from | the | experimenter |     | to identify | significant |     |
| --------------- | ------------- | ---------- | ------------------- | ---------- | ---------- | ----- | --------- | --- | ------------ | --- | ----------- | ----------- | --- |
| interferences   | can           | be largely | canceled.           |            |            |       |           |     |              |     |             |             |     |
| After           | a qualitative | evaluation |                     | of various | commercial |       | events.   |     |              |     |             |             |     |
| IMUs in         | terms of      | accuracy   | and                 | internal   | processing |       |           |     |              |     |             |             |     |
| capabilities(as | detailedby    |            | themanufacturer),we |            |            | chose |           |     |              |     |             |             |     |
the VN-100 model (VectorNav, Dallas, TX). While the Post-processing
| results reported | here | are | associated | with | this | particular |     |     |     |     |     |     |     |
| ---------------- | ---- | --- | ---------- | ---- | ---- | ---------- | --- | --- | --- | --- | --- | --- | --- |
choice, the method we propose can be applied with We collected the data from two different computers
other commercial IMUs. As Figure 1b shows, one because of bandwidth limitations. A few steps are
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     |     | 1–15 |     |     |     | Tomasi | etal. |     |     |     |     |     | 5   |
| ------------------------------- | --- | --- | ---- | --- | --- | --- | ------ | ----- | --- | --- | --- | --- | --- | --- |
required for synchronization. Here, we briefly summa- the right and back to the left in order to create easily
rize the procedure used to generate the final gaze identifiable anchor marks for the synchronization of eye
| estimations. |      |     |         |           |     |        |     | movementoutputwiththeheadsignal.Thesharppeaksof |                   |               |           |        |        |     |
| ------------ | ---- | --- | ------- | --------- | --- | ------ | --- | ----------------------------------------------- | ----------------- | ------------- | --------- | ------ | ------ | --- |
|              |      |     |         |           |     |        |     | the head                                        | turns as observed | in            | the scene | camera | are    |     |
|              |      |     |         |           |     |        |     | represented                                     | by a unique       | indexed       | frame     | in the | video. |     |
| Eye tracking | from | raw | videos: | Eyeþscene |     | camera |     |                                                 |                   |               |           |        |        |     |
|              |      |     |         |           |     |        |     | Similarly,                                      | the peak          | corresponding | to this   | rapid  | head   |     |
Yarbus eye-tracking software (Positive Science) is movement is identified in the head sensor signal. Once
used to generate eye position coordinates for every these anchor points are manually identified, the corre-
|              |     |       |        |     |             |      |     | sponding | time offsets | from the | start in | both | the data |     |
| ------------ | --- | ----- | ------ | --- | ----------- | ---- | --- | -------- | ------------ | -------- | -------- | ---- | -------- | --- |
| scene camera |     | video | frame. | The | calibration | data | is  |          |              |          |          |      |          |     |
marked in the software by playing back the recorded streamsarefedtothecustomizedgazeprocessingsoftware
videos from both eye and scene cameras, and interac- to synchronize them with one frame precision. The
tively marking the calibration points on the scene software generates a new text file including synchronized
videos. During the playback, we confirm that the eye and head position data for further analysis.
| subject  | was looking |        | at the   | correct | calibration   |     | point |     |     |     |     |     |     |     |
| -------- | ----------- | ------ | -------- | ------- | ------------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
| with the | help        | of the | recorded | verbal  | instructions. |     | We    |     |     |     |     |     |     |     |
also ensure by visual inspection that a viable corneal Combination of synchronized and corrected output into
gaze orientation
| reflection | is present |     | in the | eye video. | The | software | then |     |     |     |     |     |     |     |
| ---------- | ---------- | --- | ------ | ---------- | --- | -------- | ---- | --- | --- | --- | --- | --- | --- | --- |
maps the eye movements in the video obtained by the Once the visual angle conversion factor is calculated,
infrared eye camera to the corresponding locations in it is applied to the entire eye position dataset to obtain
the scene video based on the above calibration. Thus, visual angles with respect to the neutral point in the
the software generates an output video and a text file scene camera frame. As there is no specific location in
whereinformationabouteyeposition(intermsofscene the scene camera that can be identified as the straight
image coordinates expressed in pixels), time, and pupil ahead orientation, the neutral point (08) for the eye
size are logged. Yarbus software also provides a positionsisarbitrarilycalculatedastheaverageofallthe
measure of reliability for each tracked point based on fixation points on the scene images recorded within 30
the presence of the corneal reflection and the quality of ms after the reset operations carried out within a
the pupil detection. recording session. Note that the subject is instructed to
|     |     |     |     |     |     |     |     | look straight | ahead | during the | reset operations. |     | During |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | ----- | ---------- | ----------------- | --- | ------ | --- |
thereset,theheadorientationsignalisalsosettozeroso
Correction of detected eye position that the neutral point is represented by the heading
The wide-angle (608) scene camera lens results in a direction. Obtaining the gaze angle is then a matter of
significantspatialdistortionofthedisplayedscene.The summing the head rotation angle estimated by the
Yarbus software does not correct for these distortions sensors and the visual angle due to the eye movements
while mapping the eye movements to the scene. The relative to the head. The headand theeye angles canbe
|        |        |              |     |        |               |     |          | directly | summed in | our application | because |     | the distance |     |
| ------ | ------ | ------------ | --- | ------ | ------------- | --- | -------- | -------- | --------- | --------------- | ------- | --- | ------------ | --- |
| output | of the | eye tracking |     | system | is calibrated |     | in terms |          |           |                 |         |     |              |     |
of pixel coordinates of fixation on the scene image between the eye and sensors center of rotation (order of
coordinates, not the actual scene or real world centimeters) is small when compared with the typical
coordinates. However, since we wish to convert the eye viewing distance used when walking (order of meters).
| position   | on the     | scene | image     | to visual   | angles  |               | in the real |        |                 |               |     |       |        |     |
| ---------- | ---------- | ----- | --------- | ----------- | ------- | ------------- | ----------- | ------ | --------------- | ------------- | --- | ----- | ------ | --- |
| world,     | the effect | of    | the image | distortion  |         | has           | to be       |        |                 |               |     |       |        |     |
|            |            |       |           |             |         |               |             | Motion | sensors drift   | correction    |     |       |        |     |
| corrected. | We         | later | correct   | for the     | optical | distortion    |             |        |                 |               |     |       |        |     |
| imposed    | to the     | scene | video     | by applying |         | a geometrical |             |        |                 |               |     |       |        |     |
|            |            |       |           |             |         |               |             | Since  | there is always | a possibility | of  | drift | in the |     |
transformation to the raw eye tracking data based on motion sensor data, we check the deviation of the head
| the intrinsic | camera |     | parameters |     | and lens | distortion |     |             |         |                       |     |     |        |     |
| ------------- | ------ | --- | ---------- | --- | -------- | ---------- | --- | ----------- | ------- | --------------------- | --- | --- | ------ | --- |
|               |        |     |            |     |          |            |     | orientation | from 08 | at reset/checkpoints. |     | We  | assume |     |
parameters, computed offline using the camera cali- that any error that we measured between a reset value
bration function provided in the OpenCV library and the following reset measure was due to an
(OpenCV Development Team, 2013). Using these accumulated drift. If this residual drift is greater than
computed parameters, the eye tracking coordinates in 108 the whole segment is considered unusable and
| the scene | camera | image | coordinates |     | (in | pixels) | are |     |     |     |     |     |     |     |
| --------- | ------ | ----- | ----------- | --- | --- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
discarded.
| transformed      | to  | their   | corresponding |      | undistorted |     | eye-in- |             |     |             |     |     |     |     |
| ---------------- | --- | ------- | ------------- | ---- | ----------- | --- | ------- | ----------- | --- | ----------- | --- | --- | --- | --- |
| head orientation |     | angular | values.       |      |             |     |         |             |     |             |     |     |     |     |
|                  |     |         |               |      |             |     |         | Experiments |     | and results |     |     |     |     |
| Synchronization  |     | of eye  | and           | head | signal      |     |         |             |     |             |     |     |     |     |
At the beginning as well as the end of the recording We conducted three experiments to evaluate the
session,weaskthepersontoperformrapidheadturnsto performance of our system. The experiments were
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     | 1–15 |     |     |     |     | Tomasi | etal.    |             |     |     |          |         |     |           | 6   |
| ------------------------------- | --- | ---- | --- | --- | --- | --- | ------ | -------- | ----------- | --- | --- | -------- | ------- | --- | --------- | --- |
|                                 |     |      |     |     |     |     |        | with the | protractor) |     | was | manually | rotated | by  | 208 every |     |
30sduringthewalk.Becausewewantedtoevaluatethe
longtermdriftoftheIMUs,wedidn’tresettheheading
|     |     |     |     |     |     |     |     | during | the test. |                |     |       |        |        |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | --------- | -------------- | --- | ----- | ------ | ------ | --- | --- |
|     |     |     |     |     |     |     |     | We     | repeated  | the experiment |     | three | times. | Figure | 3   |     |
showsthenoisiestoneoutofthethreecollecteddatasets
usingthetwo-sensorsystemshowninFigure2.InFigure
|     |     |     |     |     |     |     |     | 3b, the     | differential | signal   |        | accurately | represents |     | the       |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ------------ | -------- | ------ | ---------- | ---------- | --- | --------- | --- |
|     |     |     |     |     |     |     |     | rotation    | of the       | rotating | sensor | while      | the        | raw | data from |     |
|     |     |     |     |     |     |     |     | each sensor | were         | very     | noisy. | As         | mentioned  | in  | the       |     |
Methodssection,thenoiseacrosssensorsduetoexternal
|     |     |     |     |     |     |     |     | effects, | which is | highly | correlated, |     | can be | effectively |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | -------- | ------ | ----------- | --- | ------ | ----------- | --- | --- |
cancelledwiththedifferentialoutput.Figure3ashowsthe
differencebetweenthetwosensorsovertheentireperiod
ofonedatacollectionsessionwithaclearstepwisepattern
|     |     |     |     |     |     |     |     | in the relative |     | orientation |     | output. | The data | sample |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- | ----------- | --- | ------- | -------- | ------ | --- | --- |
(Figure3b)demonstratesrelativelystablebehaviorupto
|     |     |     |     |     |     |     |     | 300 s in | the differential |     | measure. |     | After | this point, | the |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ---------------- | --- | -------- | --- | ----- | ----------- | --- | --- |
measurestartedtodrift(thedriftsectionsarehighlighted
|     |     |     |     |     |     |     |     | with ellipses). | The | drift | error | between | protractor |        | shifts     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- | ----- | ----- | ------- | ---------- | ------ | ---------- | --- |
|     |     |     |     |     |     |     |     | was nomorethan  |     | 208.  | The   | worst   | drift      | was in | the middle |     |
Figure 2. A pair of sensors mounted on a rigid body such that of data collection (from 400 to 800 s), where the sensors
one of the sensors is fixed to the box (representing the body drifted very quickly, as shown in Figure 3a. Following
| motion sensor), | while | the other | sensor | (representing |     | the | head |               |         |     |              |     |             |         |     |     |
| --------------- | ----- | --------- | ------ | ------------- | --- | --- | ---- | ------------- | ------- | --- | ------------ | --- | ----------- | ------- | --- | --- |
|                 |       |           |        |               |     |     |      | that drifting | period, |     | the relative |     | orientation | measure |     |     |
motion sensor) can be rotated horizontally (yaw) with respect appeared to be correct again without any intervention.
| to the other. | A protractor | is  | mounted | underneath |     | the rotating |     |          |               |     |       |       |      |      |        |     |
| ------------- | ------------ | --- | ------- | ---------- | --- | ------------ | --- | -------- | ------------- | --- | ----- | ----- | ---- | ---- | ------ | --- |
|               |              |     |         |            |     |              |     | We think | this residual |     | drift | might | have | been | caused | by  |
sensor to indicate the amount of rotation (performed unpredictablemagneticinterferencesthataffectedthetwo
manually). sensors in a different way (i.e., the body sensor received
|     |     |     |     |     |     |     |     | stronger | interference |     | from | the ground | than | the | head |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ------------ | --- | ---- | ---------- | ---- | --- | ---- | --- |
designed to test each component in isolation. First we sensor). Because the interference was uncorrelated and
testedthepairedIMUmethodandvalidatedthebenefit
|     |     |     |     |     |     |     |     | disrupted | the drift | by  | different | amounts |     | in the | two |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --------- | --- | --------- | ------- | --- | ------ | --- | --- |
and limitation of the differential signal, which allowed sensors, it was not fully cancelled by the differential
| us to determine | the | needed | frequency |     | of reset/check- |     |     |        |          |      |         |     |        |               |     |     |
| --------------- | --- | ------ | --------- | --- | --------------- | --- | --- | ------ | -------- | ---- | ------- | --- | ------ | ------------- | --- | --- |
|                 |     |        |           |     |                 |     |     | output | function | (see | example | in  | Figure | 3c). However, |     |     |
points in our protocol. The second experiment evalu- these drifts did not always happen. In another recording
ated the accuracy of the head orientation session carried out in the same environment, we did not
measurements, and the third was designed to test the observe such an event. The differential signal, shown in
combination of head orientation estimation with the Figure4,wasrelativelystableformorethan11minwith
eyetrackeroutput.Alltheexperimentswereconducted
|     |     |     |     |     |     |     |     | only small | levels | of drift | observed. |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ------ | -------- | --------- | --- | --- | --- | --- | --- |
outdoors in a busy urban environment, the Govern- This evaluation experiment underscores the need for
| ment Center | area in | Boston, | MA. |     |     |     |     |               |            |         |             |      |          |                 |              |      |
| ----------- | ------- | ------- | --- | --- | --- | --- | --- | ------------- | ---------- | ------- | ----------- | ---- | -------- | --------------- | ------------ | ---- |
|             |         |         |     |     |     |     |     | a carefully   | designed   |         | protocol    | with | frequent |                 | reset points |      |
|             |         |         |     |     |     |     |     | in order      | to limit   | the     | deleterious |      | issue    | of differential |              |      |
|             |         |         |     |     |     |     |     | sensor        | drift. For | our     | particular  |      | outdoor  | route,          | if           | we   |
| Experiment  | 1       |         |     |     |     |     |     |               |            |         |             |      |          |                 |              |      |
|             |         |         |     |     |     |     |     | had performed |            | a reset | every       | 5    | min, the | likelihood      |              | of a |
|             |         |         |     |     |     |     |     | drift-free    | recording  |         | was 70%     | for  | each     | 5-min           | segment      |      |
To evaluate the stability of the relative measurement based on data combined across the three repetitions of
betweenthetwoIMUswhilewalkingoutdoors,thetwo the experiment. We suggest that a similar test should
|         |              |     |         |           |     |      |     | always | be conducted |     | to determine |     | the | frequency | of  |     |
| ------- | ------------ | --- | ------- | --------- | --- | ---- | --- | ------ | ------------ | --- | ------------ | --- | --- | --------- | --- | --- |
| sensors | were mounted | on  | a rigid | cardboard |     | box, | as  |        |              |     |              |     |     |           |     |     |
illustrated in Figure 2. We measured a range of heading reset needed for each experimental situation
movements from(cid:2)608 (left) toþ608 (right). During the and environment.
| first experiment, | an           | experimenter |          | walked    | outdoors     |        | for |            |     |     |     |     |     |     |     |     |
| ----------------- | ------------ | ------------ | -------- | --------- | ------------ | ------ | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
| 20 min            | carrying the | entire       | assembly | in        | his          | hands. | The |            |     |     |     |     |     |     |     |     |
|                   |              |              |          |           |              |        |     | Experiment |     | 2   |     |     |     |     |     |     |
| walking           | route was    | a 150-meter  |          | straight  | section      | of     | a   |            |     |     |     |     |     |     |     |     |
| sidewalk          | in a busy    | downtown     |          | area. The | experimenter |        |     |            |     |     |     |     |     |     |     |     |
walked back and forth along the route making 1808 In the second experiment, we tested the system drift
turns of heading at both ends. Starting from the with natural head movements. The subject stood on a
beginning of data collection, the top sensor (together busy downtown sidewalk. One of the sensors was
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

Journal ofVision(2016)16(3):27, 1–15 Tomasi etal. 7
Figure3.Figure3.Relativeorientationindegreesbetweenthetwoinertialmeasurementunits(IMUs)inExperiment1a.(a)Stepsof
208 are clearly shown in the relative orientation output. Note that after 300 s the system starts drifting (experiencing uncorrelated
noise), and thereis anerrorofabout 208.Thestepinthe blueellipseshouldbe208incrementand not408, andthe sectionsofthe
outputhighlightedbytheblackellipsesshouldappearflatintheplot(constant);onlyafewofthemaremarkedforthesakeofclarity.
(b)Orientationoutputoftheheadandbodysensorsfora60-ssegmentoftherecordingaroundthepeakat140sonplot(a).Thenet
headrotationisobtainedbysubtractingtheoutputofthebodymotionsensorfromtheheadmotionsensor.Althoughbothappear
to beverynoisy,the noise is highlycorrelated,and the differentialsignalprovidesrelativeorientation,which is close tothe ground
truth.(c)Orientationoutputoftheheadandbodysensorsfora50-ssegmentoftherecording,startingat680sonplot(b),showing
details of uncorrelated noise in the two sensors. In this case, the differential output does not help, and the measured net head
rotation increases when it should have been flat.
mounted on a hat worn by him (Figure 1). The between two of the reset points (at 1200 and 2100 s).
referencesensorwasfixedonabox(astheloweronein Sixteen checkpoints are marked by red asterisks at 08.
Figure2),andwasheldsteadilyinhishandsagainsthis The large and rapid fluctuations in the relative
body. During the 13 min of data collection, the person orientation measure are due to the arbitrary head
moved his head naturally (in a random manner) and movements as well as the abrupt movement of the
watched the street scene. After about every minute he head-mountedsensorwhenitwastakenofftheheadto
took off the head-mounted sensor and manually be aligned with the reference sensor. Figure 5b shows
aligned it with the reference sensor so that the relative only the relative orientation at the 16 checkpoints. A
orientation was 08. At this point, a key was pressed to slow drift from negative to positive can be seen in the
register the moment as a checkpoint in the sensor log figure. The standard deviation of the error was 2.68,
file. No heading reset was performed at these check- with a maximum error of 10.68 and a mean of 3.58.
points. This experiment confirms the conclusion of the first
Figure 5a shows the yaw angles for the head- experimentthatthedriftneedstobeaddressedbyusing
mountedsensorextractedfrom13minofrecordeddata frequent checkpoints and reset points.
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     |     | 1–15 |     |     | Tomasi | etal.    |                 |        |          |               |            |         | 8        |
| ------------------------------- | --- | --- | ---- | --- | --- | ------ | -------- | --------------- | ------ | -------- | ------------- | ---------- | ------- | -------- |
|                                 |     |     |      |     |     |        | Data     | were collected  |        | in front | of            | a building |         | from a   |
|                                 |     |     |      |     |     |        | distance | of 5.7          | m (225 | in.).    | Five          | pillars    | of the  | building |
|                                 |     |     |      |     |     |        | served   | as the targets. |        | A person | sequentially  |            | looked  | at       |
|                                 |     |     |      |     |     |        | each of  | these pillars   |        | for a    | few seconds   |            | in turn | by       |
|                                 |     |     |      |     |     |        | making   | natural         | head   | and      | eye movements |            | (Figure | 6).      |
|                                 |     |     |      |     |     |        | When     | the subject     | was    | looking  | at            | a pillar,  | the     |          |
experimenterpressedabuttonontheloggertoflagthat
|     |     |     |     |     |     |     | time. This | enabled         | us   | to compare |              | the    | gaze tracking |          |
| --- | --- | --- | --- | --- | --- | --- | ---------- | --------------- | ---- | ---------- | ------------ | ------ | ------------- | -------- |
|     |     |     |     |     |     |     | system     | output          | with | the ground | truth        | angles |               | computed |
|     |     |     |     |     |     |     | using the  | measured        |      | distances. |              |        |               |          |
|     |     |     |     |     |     |     | Standing   | still           |      |            |              |        |               |          |
|     |     |     |     |     |     |     | The        | first condition |      | with       | the standing |        | observer      |          |
|     |     |     |     |     |     |     | consisted  | of 6            | min. | of data    | collection.  |        | The person    |          |
Figure4.RelativeorientationindegreesbetweenthetwoIMUs
|               |     |            |               |          |     |      | looked | at the | 0 position | and | reset | the | sensor, | then |
| ------------- | --- | ---------- | ------------- | -------- | --- | ---- | ------ | ------ | ---------- | --- | ----- | --- | ------- | ---- |
| in Experiment | 1b. | Repetition | of Experiment | 1a using | the | same |        |        |            |     |       |     |         |      |
lookedateachofthepillarsinapredeterminedorder0,
| conditions | on another | day | over a period | of time | of 700 | s   |         |        |         |     |           |     |     |          |
| ---------- | ---------- | --- | ------------- | ------- | ------ | --- | ------- | ------ | ------- | --- | --------- | --- | --- | -------- |
|            |            |     |               |         |        |     | L1, L2, | L1, 0, | R1, R2, | R1, | 0 (Figure | 6). | He  | repeated |
withoutaresetshowedthatthesystemismorestablethanthe
|            |                 |       |           |     |     |     | this sequence |         | and looked |        | at each   | pillar | five times.    | The |
| ---------- | --------------- | ----- | --------- | --- | --- | --- | ------------- | ------- | ---------- | ------ | --------- | ------ | -------------- | --- |
| previous   | data collection | shown | in Figure | 3.  |     |     |               |         |            |        |           |        |                |     |
|            |                 |       |           |     |     |     | reset was     | used    | only       | at the | beginning | of     | the recording. |     |
|            |                 |       |           |     |     |     | When          | looking | at each    | of the | pillars,  | the    | subject        | was |
| Experiment | 3               |       |           |     |     |     |               |         |            |        |           |        |                |     |
instructedtomovebothhisheadandhiseyesnaturally.
|      |            |        |                |      |          |     | Figure     | 7a shows |         | the plot | of the   | head  | orientation |     |
| ---- | ---------- | ------ | -------------- | ---- | -------- | --- | ---------- | -------- | ------- | -------- | -------- | ----- | ----------- | --- |
| This | experiment | tested | the integrated | gaze | tracking |     |            |          |         |          |          |       |             |     |
|      |            |        |                |      |          |     | (blue) and | the      | overall | gaze     | recorded | (red) | for         | the |
system including the eye tracker in a mobile outdoor standingobserverconditionduring6 min.The ground-
setting.Thepurposewastoevaluatetheaccuracyofthe
|     |     |     |     |     |     |     | truth values | for | the | gaze angles | at  | various | intermediate |     |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | --- | ----------- | --- | ------- | ------------ | --- |
gaze tracking system in various natural conditions that checkpoints are shown as green points. The overall
| may occur | during | outdoor | walking | scenarios. | It  |     |            |        |       |        |     |     |        |          |
| --------- | ------ | ------- | ------- | ---------- | --- | --- | ---------- | ------ | ----- | ------ | --- | --- | ------ | -------- |
|           |        |         |         |            |     |     | gaze angle | at any | given | moment | is  | the | sum of | the head |
involved three different conditions, (a) standing still, and the eye tracking system estimates. Positive values
| (b) walking | with | body | lateral shifts | only but | without |     |               |     |        |       |              |     |        |         |
| ----------- | ---- | ---- | -------------- | -------- | ------- | --- | ------------- | --- | ------ | ----- | ------------ | --- | ------ | ------- |
|             |      |      |                |          |         |     | are movements |     | to the | right | and negative |     | to the | left. A |
turns, and (c) walking with multiple body turns. staircase-likepatternisseeninthegazeorientationplot
Figure 5. Outputs for the head tracking experiment using a head mounted sensor and one stationary sensor as a reference in
Experiment2. (a)Thecontinuous dataoutputfor theheadmovementin theyawdirectionrecorded overaperiod ofabout13min
between two reset points (at 1200 and 2100 s). Also overlaid, are the ground truth orientation values at each of the recorded
checkpoints (redstars).(b) Onlythe orientationvaluescorrespondingto the checkpoints areshown.Theorientationvaluesindicate
the deviation from the ground truth values (08), and show a gradual drift from negative to positive over time. Negative values
| represent | movement | to the | left. |     |     |     |     |     |     |     |     |     |     |     |
| --------- | -------- | ------ | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     |     | 1–15 |     | Tomasi etal. |     |     |     | 9   |
| ------------------------------- | --- | --- | ---- | --- | ------------ | --- | --- | --- | --- |
Figure6.(a)SetupforExperiment3forgazetrackingwithastationary subject.(b)Thepersonlookssequentiallyand repetitivelyat
thepointsinthefollowingorder:0,L1,L2,L1,0,R1,R2,R1,0.Ateachofthefixationpoints,acheckpointisregisteredinthelog,so
| as to facilitate | the | computation | of the | ground truth. |     |     |     |     |     |
| ---------------- | --- | ----------- | ------ | ------------- | --- | --- | --- | --- | --- |
(Figure 7a) reflecting the systematic pattern of gaze was 1.48 with a standard deviation of 0.98. The system
shiftsacrossthefivepillars(Figure6).Theeyetracking behaved in a stable manner for the standing observer
| output | has a higher | variance | compared | to the head |           |             |             |                |     |
| ------ | ------------ | -------- | -------- | ----------- | --------- | ----------- | ----------- | -------------- | --- |
|        |              |          |          |             | condition | over 6 min. | The maximum | error recorded |     |
orientation output. However, the head orientation is over the full set of checkpoints (including the far
| accompanied | by  | a small     | amount | of drift (seen  |            |           |     |     |     |
| ----------- | --- | ----------- | ------ | --------------- | ---------- | --------- | --- | --- | --- |
|             |     |             |        |                 | periphery) | was 3.68. |     |     |     |
| prominently | for | the extreme | right  | and left points | in the     |           |     |     |     |
scene).
| Figure   | 7b shows    | the gaze | estimation | errors (black   |              |              |        |                  |       |
| -------- | ----------- | -------- | ---------- | --------------- | ------------ | ------------ | ------ | ---------------- | ----- |
|          |             |          |            |                 | Walking with | body lateral | shifts | only but without | turns |
| circles) | at the each | ground   | truth      | point. The gaze |              |              |        |                  |       |
estimation error is the difference of the estimated gaze In the other two experimental conditions, we
|            |          |     |            |              | evaluated | the impact of | movement | and large | body |
| ---------- | -------- | --- | ---------- | ------------ | --------- | ------------- | -------- | --------- | ---- |
| angle (red | segment) | and | the ground | truth (green |           |               |          |           |      |
crosses) angles for the scene locations. The average turns on system accuracy. Our hypothesis was that the
absolute gaze estimation error for all the checkpoints motion sensors could be adversely affected by large
Figure 7. Outputs for gaze tracking in the static observer condition of Experiment 3. (a) Continuous data output for the head
movement(blueline)andthegaze(redline)intheyawdirection.(b)Thesameoutput,butonlyatthecheckpoints.Theredsegments
represent the gaze estimation, and black circles the measurement error from the ground truth (green crosses).
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     |     | 1–15 |     |     | Tomasi | etal. |     |     |     | 10  |
| ------------------------------- | --- | --- | ---- | --- | --- | ------ | ----- | --- | --- | --- | --- |
Figure8.Outputsforthegazetrackingforthestraightwalkingcondition(withoutturns).(a)Thecontinuousdataoutputforthehead
movement(blueline)andthegaze(redline)intheyawdirection.Theverynoisyheaddataareduringthewalkingsegmentsandwere
not part of the analyses. (b) Data values at the checkpoints only: red segments represent the gaze measurements and black circles
| represent | the deviation |     | from the | ground truth | (green | crosses). |     |     |     |     |     |
| --------- | ------------- | --- | -------- | ------------ | ------ | --------- | --- | --- | --- | --- | --- |
turns and hence, the sensor drift could become worse. a total of seven times during 18 min of recording. The
We first evaluated the accuracy of gaze estimation with walks included multiple body turns, so both the head
only straight walks (condition b) in which the person sensor and the reference sensor on the waist rotated a
moved back and forth but always faced the same great deal. The natural walking behavior was reflected
direction (the wall with the pillars). In this way, we in the gaze estimation output shown in Figure 9a, in
introduced the typical oscillatory nature of body which random angles were recorded between the
movement when walking, but without any full body checkpoints and an uncontrolled walking speed was
| turns. The | subject | started | from | the same | position | as in |         |                |                     |       |     |
| ---------- | ------- | ------- | ---- | -------- | -------- | ----- | ------- | -------------- | ------------------- | ----- | --- |
|            |         |         |      |          |          |       | adopted | by the subject | between consecutive | scans |     |
Figure 6 and performed a full scan (starting from 0, (note the uneven separations of the ground truth
going to the extreme left, then back to the extreme checkpoints in the figure). The errors (black circles)
right, and then back again to 0). Between scanning from the ground truth (green crosses) are reported in
cycles, the person moved backwards for about 5 m Figure 9b. Again, no heading resets were applied
while still facing forward, and then walked back to the between loops.
original scanning position without turning to perform As expected, this condition generated a larger error
| the next | round | of scanning. |     | No resets | were | applied |             |        |                   |             |     |
| -------- | ----- | ------------ | --- | --------- | ---- | ------- | ----------- | ------ | ----------------- | ----------- | --- |
|          |       |              |     |           |      |         | as compared | to the | standing observer | and no-turn |     |
between scans. The results of 8 min of data collection walking conditions due to more unstable sensor drift.
are shown in Figure 8. For this last condition, the average absolute error was
Asexpected,thegazeestimationerrorswerelargerin 7.18 with a standard deviation of 5.28.
| this case        | than  | those   | in the       | standing observer |           | condition.  |      |       |     |     |     |
| ---------------- | ----- | ------- | ------------ | ----------------- | --------- | ----------- | ---- | ----- | --- | --- | --- |
| Compared         | with  | the     | ground-truth | values            | of        | the gaze at |      |       |     |     |     |
| the checkpoints, |       | there   | was          | an average        | absolute  | gaze        |      |       |     |     |     |
|                  |       |         |              |                   |           |             | Case | study |     |     |     |
| estimation       | error | of 3.38 | with         | a standard        | deviation | of          |      |       |     |     |     |
2.38.Themaximumabsolutecheckpointerrorwas8.88.
|     |     |     |     |     |     |     | To illustrate | the value | of the proposed | system     | the |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --------- | --------------- | ---------- | --- |
|     |     |     |     |     |     |     | gaze scanning | behaviors | of four persons | (including | one |
Walking with multiple body turns normally sighted and three visually impaired with
The last condition (c) involved arbitrary head hemianopia) walking on a busy street in downtown
movements, complete body turns, and lateral dis- Boston were recorded. Each walk session lasted for
placements. The experiment was conducted using the about 10 min with four reset points along the entire
same setup shown in Figure 6, but the subject walked length of the route; we placed checkpoints after a
around the parking lot and on the sidewalk for designated (or required) body turn.
approximately50mbeforegoingbacktothescanning From these pilot measures, we were able to quantify
position for the next scan. The sequence was repeated the contribution of head turns to the overall gaze
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

Journal ofVision(2016)16(3):27, 1–15 Tomasi etal. 11
Figure 9. Outputs for the gaze tracking experiment while walking with body turns. (a) The continuous data output for the head
movement(blueline)andthegaze(redline)intheyawdirection.Thewalkingspeedbetweencheckpointswasnotkeptconstantby
thesubject.(b)Datavaluesatthecheckpointsonly:redsegmentsrepresentthegazeestimation,andblackcirclesthedeviationfrom
the ground truth (green crosses).
orientation. Figure 10 shows a typical gaze-scanning rotation. With a conventional head-mounted eye
event for the normally sighted subject. It can be seen tracking system there would have been little or no
that the contribution of the head rotation (blue line) to information about the subject’s true gaze scanning
the total gaze orientation (red line) is large for wide behaviors because the eye is often at low deviation
quick gaze scanning (larger than 208, 0.4–1.5 s) and a positions (green line); for example, even when he
slow head turn (1.5–2.5 s), whereas the head rotation scanned to the far right side (positive values), at about
contributes much less for narrow quick gaze scanning 0.8 s, gaze shift was more than 258 but eye deviation
(less than 158, 0–0.4 s), and depends only on eye was less than 58.
Figure10.Twoexamplesofscanningbehaviorsduringa10minwalk.Head,eye,andfinalgazemovementsareshown.(a)Anexample
oflargeheadcontribution(blueline)tothefinalgazeorientation(redline).Theeyecontribution(greenline)inthiscaseissmall.If
onlyeyemovementshadbeentrackedwemighthaveerroneouslyconcludedthatthissubjectdidnotscan.(b)Theheadandtheeye
orientationmovinginoppositedirections(oppositesigns).Thegazeorientationstayspositive(rotationtotheright)between0.7and
2.6 s, although the eye tracking is showing the opposite behavior (negative, rotation to the left).
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

Journal ofVision(2016)16(3):27, 1–15 Tomasi etal. 12
Average head Opposite Total valid not be ignorable for some studies. We showed that
ID contribution behavior points points this error increases when the person is walking with
sudden changes in the heading direction. In order to
NV1 46% 5,954 (16%) 36,058
reduce this accuracy loss, it is a good strategy to plan
LV2 43% 3,763 (17%) 21,128
for frequent heading resets, especially after large
LV3 37% 7,118 (15%) 47,702
body turns. If we perform a reset after each body
LV4 46% 3,773 (16%) 23,251
turn, the segments between reset points can be
considered straight. Our experiments demonstrated
Table 1. Summary of the behaviors illustrated in Figure 10 for that the system has an average error of 3.38 for this
data collected during the 10-min walk by four subjects.The condition. In the case study for a real walk that
average head contribution is the percentage of contribution of included 1808 body turns, heading resets were always
theheadtothegazevalues.Oppositehead-eyerotationpoints executed after turns. The situation in the case study
are the number of points where the gaze orientation has a then became equivalent to the experiment without
different sign as compared to the eye position. In parentheses
body turns.
weshowthepercentageofvalidsamplesovertotalpoints(last
For all the experiments that were conducted, we
column).
reporttheresultsonlyfortheyawheadmovementbut
our method could be applied to the pitch head
movements in the same way. Our primary application
We were also able to document a behavior in which
of the mobile gaze tracking system will be for the
the eye and head turn in opposite directions. Figure 10
study of lateral gaze scanning by patients with
shows such examples: from 0.4 to 1.3 s in Figure 10a,
homonymous hemianopia (the loss of the same half of
and from 0.7 to 2.6 s in Figure 10b. The head rotation
the visual field in both eyes) when walking, hence our
appears to be positive (rotation to the right) while the
focus on yaw movements. However, for other appli-
eye direction negative (rotation to the left). If the head
cations, vertical gaze movements while walking may
movements were not considered, the eye tracking data
also be of interest.
alone could have been misleading.
We showed the large contribution of head position
In Table 1 (column 2) we report the average
to gaze position in the outdoor walking data for four
percentage of head contribution to the gaze movement
different persons. The cases demonstrate that the head
for the full 10 min walk for each subject. The average
plays a large role in the gaze scanning pattern, on
headorientationcontributionwasintherangeof37%–
average above 40% of the gaze movement. This
46%.Thiswascalculatedwiththeratiooftheheadscan
observation can be expected since people walking on
over the total gaze scan on all the valid points: valid
streets can freely move the head. This finding is
points are considered if we have both eye-in-head and consistent with a previous study by Freedman (2008)
head orientation from the system. Column 3 in Table 1 who reported that the head largely contributes to the
summarizes the number of eye/head opposite data gaze shift in cases of large movements (.308) or in a
points for the four subjects, which was more than 15% particular starting position of the eyes. These results
of the valid samples. underscoretheimportanceoftrackingheadmovements
when studying gaze behaviors in outdoor environ-
ments.
Discussion In our case study we also found an occasional
discrepancy between the orientation of the head and
the eyes. A person’s eyes might be pointing to one
Here we summarize several points that may be side, but due to the head position, the overall gaze
importantforthesuccessoffuturedatacollectionusing could still be on the opposite side. This result is in
the proposed method based on a set of evaluation line with the vestibulo-ocular reflex (VOR) and the
experiments of our gaze tracking system. compensatory rotations of eye and head while
Itis important touse at leasttwomotion sensorsfor walking (Freedman, 2008). In fact, because of the
driftandinterferencereduction.Thesensorattachedto VOR, the eyes tend to move in the opposite direction
the body trunk acts as a reference so as to enable the tothehead tostabilizetheimageon theretinaduring
computation of head movement with respect to the nonscanning head movements. Another possible
currentheadingdirection.Inthispaperweshowedhow reason accounting for the discrepancy is the presence
eachsensorisaffectedbyexternalinterferenceandhow of multiple saccades per single head movement as
the resultant drift could be corrected by the use of a previously reported by Fang, Nakashima et al.
differential output. (2015). The authors demonstrated that, during the
Although the error is reduced with the use of two same head movement, subjects can perform different
sensors, we still have some residual error that may eye movements and those are not always in the same
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

Journal ofVision(2016)16(3):27, 1–15 Tomasi etal. 13
directionastherotationofthehead.Suchdifferences Acknowledgments
between eye and head rotation patterns cannot be
easily understood without the head tracking infor-
This project was funded in part by the DoD grant
mation.
number DM090420 and NIH grants R01AG041974
Itisalsoworthmentioningthatthecharacteristicsof
and R01EY023385.
the terrain on which the person is walking may play an
important role in the gaze distribution (’t Hart &
Commercial relationships: none.
Einhauser, 2012; Vargas-Mart´ın & Peli, 2006). Hart
Corresponding author: Matteo Tomasi.
and Einhauser conclude that the contributions of eye-
Email: matteo_tomasi@meei.harvard.edu.
in-head orientation as compared to head-in-world
Address: Schepens Eye Research Institute, Boston,
orientationto gazeare complementary:eye movements
MA, USA.
are adjusted to maintain some exploratory gaze and to
compensate for head movements caused by the terrain.
This is an important motivation for the adoption of
mobile gaze trackers similar to our system in future References
studies.
We reported the results of the system evaluation
Barabas, J., Goldstein, R. B., Apfelbaum, H., Woods,
experiments with a few subjects. Based on our results
R.L.,Giorgi,R.G.,&Peli,E.(2004).Trackingthe
we hypothesize that the accuracy can be affected
line of primary gaze in a walking simulator:
primarily by interferences in the environment. The
Modeling and calibration. Behavior Research
validity of the method can be extended to all subjects
Methods, Instruments, & Computers, 36, 757–770.
with a normal gait but we foresee some problem in the
Bowers, A. R., Ananyev, E., Mandel, A. J., Goldstein,
data collection of subjects affected by abnormal hip
R. B., & Peli, E. (2014). Driving with hemianopia:
movement or mobility limitation, such as a limp.
IV. Head scanning and detection at intersections in
a simulator. Investigative Ophthalmology & Visual
Science, 55, 1540–1548. [PubMed] [Article]
Conclusion
Bowers, A. R., Keeney, K., & Peli, E. (2008).
Community-basedtrial of a peripheral prism visual
Amobilegazetrackingsystemhasbeenproposedfor field expansion device for hemianopia. Archives of
outdoor walking studies. The approach can be useful Ophthalmology, 126, 657–664.
for behavioral gaze scanning studies. There are no Cesqui, B., de Langenberg, R. v., Lacquaniti, F., &
existing commercial systems for calculating gaze (head d’Avella, A. (2013). A novel method for measuring
þeye) movements and visual angles in open outdoor gaze orientation in space in unrestrained head
environments that are using more than one motion conditions.JournalofVision,13(8):28,1–22,doi:10.
sensor to compensate for sensor drift. Gaze movement 1167/13.8.28. [PubMed] [Article]
informationintermsofvisualanglesisoftenneededfor
Coeckelbergh, T. R. M., Cornelissen, F. W., Brouwer,
scanning behavior studies. We developed a method to
W., & Kooijman, A. C. (2002). The effect of visual
calculate the headþeye orientation using off-the-shelf
fielddefectsoneyemovementsandpracticalfitness
components, a portable eye tracker, and a pair of
to drive. Vision Research, 42, 669–677.
motion sensors. We are able to merge eye orientation
Davison,A.J.,Reid,I.D.,Molton,N.D.,&Stasse,O.
with the head orientation to obtain gaze relative to the
(2007). MonoSLAM: Real-time single camera
body.Outdoortestingusingtheproposedgazetracking
SLAM. IEEE Transactions on Pattern Analysis and
system shows an average error of 3.38 6 2.3 when
Machine Intelligence, 29, 1052–1067.
walking along straight segments. When walking in-
cluded some large body turns and reset was not Dune, C., Herdt, A., Stasse, O., Wieber, P. B., Yokoi,
applied, the average error increased to 7.18. Based on K.,&Yoshida,E.(2010,Oct18–22).Cancellingthe
our experimental results, some suggestions have been swaymotionofdynamicwalkinginvisualservoing.
proposed to ensure the accuracy of gaze orientation In Ren C. Luo & Hajime Asama (Eds.), Proceed-
tracking. We conclude the system may be sufficiently ings of 2010 IEEE/RSJ International Conference on
reliable for scanning behavior studies involving large Intelligent Robots and Systems (IROS) (pp. 3175–
gaze scanning movements in open-space mobility 3180). Taipei, Taiwan: IEEE.
conditions. Eggert, T. (2007). Eye movement recordings: Methods.
Developments in Ophthalmology, 40, 15–34.
Keywords: gaze tracking, outdoor walking, head
movement Essig, K., Dornbusch, D., Prinzhorn, D., Ritter, H.,
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     |     |     | 1–15 |     |     |     | Tomasi | etal. |     |     |     |     |     |     | 14  |
| ------------------------------- | --- | --- | --- | ---- | --- | --- | --- | ------ | ----- | --- | --- | --- | --- | --- | --- | --- |
Maycock, J., & Schack, T. (2012). Automatic Johnson, J. S., Liu, L., Thomas, G., & Spencer, J. P.
analysis of 3D gaze coordinates on scene objects (2007). Calibration algorithm for eyetracking with
using data from eye-tracking and motion-capture unrestricted head movement. Behavior Research
systems. Paper presented at the Proceedings of the Methods, 39, 123–132.
| Symposium |      | on      | Eye | Tracking | Research |             | and Appli- |     |          |     |        |     |          |            |     |       |
| --------- | ---- | ------- | --- | -------- | -------- | ----------- | ---------- | --- | -------- | --- | ------ | --- | -------- | ---------- | --- | ----- |
|           |      |         |     |          |          |             |            |     | Kinsman, | T., | Evans, | K., | Sweeney, | G., Keane, |     | T., & |
| cations   | (pp. | 37–44). |     | Santa    | Barbara, | California, |            |     |          |     |        |     |          |            |     |       |
Pelz,J.(2012).Ego-motioncompensationimproves
| ACM. |     |     |     |     |     |     |     |     | fixation | detection |     | in wearable |     | eye tracking. |     | Pro- |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | --------- | --- | ----------- | --- | ------------- | --- | ---- |
Fang,Y.,Nakashima,R.,Matsumiya,K.,Kuriki,I.,& ceedings of the Symposium on Eye Tracking
Shioiri, S. (2015). Eye-head coordination for visual Research and Applications (pp. 221–224). Santa
cognitive processing. PLoS One, 10(3), e0121035. Barbara, CA: ACM.
Fotios, S., Uttley, J., Cheal, C., & Hara, N. (2014). Kugler, G., Huppert, D., Schneider, E., & Brandt, T.
|       |              |     |     |          |              |     |          |     | (2014). | Fear | of heights |     | freezes | gaze to | the | horizon. |
| ----- | ------------ | --- | --- | -------- | ------------ | --- | -------- | --- | ------- | ---- | ---------- | --- | ------- | ------- | --- | -------- |
| Using | eye-tracking |     | to  | identify | pedestrians’ |     | critical |     |         |      |            |     |         |         |     |          |
visual tasks, Part 1. Dual task approach. Lighting Journal of Vestibular Research, 24, 433–441.
| Research |     | and Technology, |     |     | doi:10.1177/ |     |     |     |          |            |     |     |              |     |           |     |
| -------- | --- | --------------- | --- | --- | ------------ | --- | --- | --- | -------- | ---------- | --- | --- | ------------ | --- | --------- | --- |
|          |     |                 |     |     |              |     |     |     | Land, M. | F. (2004). |     | The | coordination | of  | rotations | of  |
1477153514522472. theeyes,headandtrunkinsaccadicturnsproduced
Freedman, E. G. (2008). Coordination of the eyes and in natural situations. Experimental Brain Research,
|           |        |        |            |     |              |     |       |     | 159, 151–160. |            |     |         |                |     |     |     |
| --------- | ------ | ------ | ---------- | --- | ------------ | --- | ----- | --- | ------------- | ---------- | --- | ------- | -------------- | --- | --- | --- |
| head      | during | visual | orienting. |     | Experimental |     | Brain |     |               |            |     |         |                |     |     |     |
| Research, |        | 190,   | 369–387.   |     |              |     |       |     |               |            |     |         |                |     |     |     |
|           |        |        |            |     |              |     |       |     | Land, M.      | F. (2009). |     | Vision, | eye movements, |     | and |     |
Geruschat, D. R., Hassan, S. E., Turano, K. A., natural behavior. Visual Neuroscience, 26, 51–62.
Quigley, H. A., & Congdon, N. G. (2006). Gaze Land, M. F., & Furneaux, S. (1997). The knowledge
| behavior |     | of the | visually | impaired |     | during | street |     |      |        |            |     |         |               |     |     |
| -------- | --- | ------ | -------- | -------- | --- | ------ | ------ | --- | ---- | ------ | ---------- | --- | ------- | ------------- | --- | --- |
|          |     |        |          |          |     |        |        |     | base | of the | oculomotor |     | system. | Philosophical |     |     |
crossing. Optometry and Vision Science, 83, 550– Transactions of the Royal Society of London. Series
| 558.      |     |        |     |      |       |                    |     |     | B: Biological |             | Sciences, |     | 352(1358), | 1231–1239. |     |     |
| --------- | --- | ------ | --- | ---- | ----- | ------------------ | --- | --- | ------------- | ----------- | --------- | --- | ---------- | ---------- | --- | --- |
| Giorgi,R. | G., | Woods, | R.  | L.,& | Peli, | E. (2009).Clinical |     |     |               |             |           |     |            |            |     |     |
|           |     |        |     |      |       |                    |     |     | Land, M.      | F., Mennie, |           | N., | & Rusted,  | J. (1999). |     | Eye |
and laboratory evaluation of peripheral prism movements and the roles of vision in activities of
| glasses  | for | hemianopia.  |     | Optometry        |     | and | Vision |     |            |         |        |     |        |                  |     |     |
| -------- | --- | ------------ | --- | ---------------- | --- | --- | ------ | --- | ---------- | ------- | ------ | --- | ------ | ---------------- | --- | --- |
|          |     |              |     |                  |     |     |        |     | daily      | living: | Making | a   | cup of | tea. Perception, |     | 28, |
| Science, |     | 86, 492–502, |     | doi:10.1097/OPX. |     |     |        |     | 1311–1328. |         |        |     |        |                  |     |     |
0b013e31819f9e4d.
|         |     |        |     |              |     |     |         |     | Larsson, | L., Schwaller, |     | A.,     | Holmqvist,   | K., | Nystrom, |      |
| ------- | --- | ------ | --- | ------------ | --- | --- | ------- | --- | -------- | -------------- | --- | ------- | ------------ | --- | -------- | ---- |
| Godwin, | A., | Agnew, | M., | & Stevenson, |     | J.  | (2009). |     |          |                |     |         |              |     |          |      |
|         |     |        |     |              |     |     |         |     | M., &    | Stridh,        | M.  | (2014). | Compensation |     | of       | head |
Accuracy of inertial motion sensors in static, movements in mobile eye-tracking data using an
quasistatic, and complex dynamic motion. Journal Proceedings of the 2014
|     |     |     |     |     |     |     |     |     | inertial | measurement |     |     | unit. |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | ----------- | --- | --- | ----- | --- | --- | --- |
of Biomechanical Engineering, 131(11), 114501. ACM International Joint Conference on Pervasive
andUbiquitousComputing:AdjunctPublication(pp.
| Grip, H., | Jull, | G., & | Treleaven, |     | J. (2009). |     | Head eye | co- |     |     |     |     |     |     |     |     |
| --------- | ----- | ----- | ---------- | --- | ---------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ordination using simultaneous measurement of eye 1161–1167). Seattle, WA: ACM.
inheadandheadinspacemovements:Potentialfor Li, F., Munn, S., & Pelz, J. (2008). A model-based
use in subjects with a whiplash injury. Journal of approach to video-based eye tracking. Journal of
Clinical Monitoring and Computing, 23, 31–40. Modern Optics, 55, 503–531.
Hansen, D. W., & Qiang, J. (2010). In the eye of the Lin, C.-S., Ho, C.-W., Chan, C.-N., Chau, C.-R., Wu,
| beholder: |     | A survey | of  | models | for | eyes | and Gaze. |     |        |        |       |         |     |              |     |     |
| --------- | --- | -------- | --- | ------ | --- | ---- | --------- | --- | ------ | ------ | ----- | ------- | --- | ------------ | --- | --- |
|           |     |          |     |        |     |      |           |     | Y.-C., | & Yeh, | M.-S. | (2007). | An  | eye-tracking |     | and |
IEEE Transactions on Pattern Analysis and Ma- head-control system using movement increment-
chine Intelligence, 32, 478–500. coordinate method. Optics & Laser Technology, 39,
| Hassan, | S. E., | Geruschat, |     | D.  | R., & | Turano, | K.  | A.  | 1218–1225. |     |     |     |     |     |     |     |
| ------- | ------ | ---------- | --- | --- | ----- | ------- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
(2005). Head movements while crossing streets: Luo, G., Vargas-Martin, F., & Peli, E. (2008). Role of
Effect of vision impairment. Optometry and Vision peripheral vision in saccade planning and visual
Science, 82, 18–26. stability: Learning from people with tunnel vision.
|           |        |     |             |     |     |          |     |     | Journal | of  | Vision, | 8(14):25, | 1–28, | doi:10.1167/8.14. |     |     |
| --------- | ------ | --- | ----------- | --- | --- | -------- | --- | --- | ------- | --- | ------- | --------- | ----- | ----------------- | --- | --- |
| Imai, T., | Moore, | S.  | T., Raphan, |     | T., | & Cohen, | B.  |     |         |     |         |           |       |                   |     |     |
(2001). Interaction of the body, head, and eyes 25. [PubMed] [Article]
during walking and turning. Experimental Brain MacDougall,H.G.,&Moore,S.T.(2005).Functional
Research, 136, 1–18. assessment of head-eye coordination during vehicle
|          |         |             |     |     |              |     |         |     | operation. |     | Optometry |     | and Vision | Science, |     | 82, 706– |
| -------- | ------- | ----------- | --- | --- | ------------ | --- | ------- | --- | ---------- | --- | --------- | --- | ---------- | -------- | --- | -------- |
| Itti, L. | (2005). | Quantifying |     | the | contribution |     | of low- |     |            |     |           |     |            |          |     |          |
715.
| level | saliency | to  | human | eye | movements |     | in dynamic |     |     |     |     |     |     |     |     |     |
| ----- | -------- | --- | ----- | --- | --------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
scenes. Visual Cognition, 12, 1093–1123. Martin, T., Riley, M. E., Kelly, K. N., Hayhoe, M., &
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016

| Journal ofVision(2016)16(3):27, |     | 1–15 |     |     |     | Tomasi | etal. |     |     |     |     |     | 15  |
| ------------------------------- | --- | ---- | --- | --- | --- | ------ | ----- | --- | --- | --- | --- | --- | --- |
Huxlin, K. R. (2007). Visually-guided behavior of Proudlock, F. A., Shekhar, H., & Gottlob, I. (2003).
homonymous hemianopes in a naturalistic task. Coordination of eye and head movements during
Vision Research, 47, 3434–3446. reading. Investigative Ophthalmology & Visual
|                    |     |       |                     |        |      |     | Science, | 44(7), | 2991–2998.   | [PubMed] | [Article]    |     |       |
| ------------------ | --- | ----- | ------------------- | ------ | ---- | --- | -------- | ------ | ------------ | -------- | ------------ | --- | ----- |
| OpenCV Development |     | Team. | (2013).             | OpenCV | web- |     |          |        |              |          |              |     |       |
| page. Retrieved    |     | from  | http://opencv.org/. |        |      |     |          |        |              |          |              |     |       |
|                    |     |       |                     |        |      |     | ’t Hart, | B. M., | & Einhauser, | W.       | (2012). Mind | the | step: |
Papageorgiou, E., Hardiess, G., Mallot, H. A., & Complementary effects of an implicit task on eye
|           |            |      |          |            |     |     | and | head | movements | in real-life | gaze allocation. |     |     |
| --------- | ---------- | ---- | -------- | ---------- | --- | --- | --- | ---- | --------- | ------------ | ---------------- | --- | --- |
| Schiefer, | U. (2012). | Gaze | patterns | predicting |     |     |     |      |           |              |                  |     |     |
successful collision avoidance in patients with Experimental Brain Research, 223, 233–249.
homonymous visual field defects. Vision Research, Vargas-Mart´ın,F.,&Peli,E.(2006).Eyemovementsof
65, 25–37.
|     |     |     |     |     |     |     | patients | with | tunnel | vision while | walking. | Investi- |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | ---- | ------ | ------------ | -------- | -------- | --- |
Peli, E. (2000). Field expansion for homonymous gative Ophthalmology & Visual Science, 47(12),
|                   |     |           |                 |            |              |     | 5295–5302. |               | [PubMed] | [Article]. |            |         |     |
| ----------------- | --- | --------- | --------------- | ---------- | ------------ | --- | ---------- | ------------- | -------- | ---------- | ---------- | ------- | --- |
| hemianopia        | by  | optically | induced         | peripheral | exo-         |     |            |               |          |            |            |         |     |
| tropia. Optometry |     | and       | Vision Science, |            | 77, 453–464. |     |            |               |          |            |            |         |     |
|                   |     |           |                 |            |              |     | VectorNav  | Technologies. |          | (2013).    | VN100 User | Manual. |     |
Positive Science. (2013). Positive Science webpage. Retrieved from http://www.vectornav.com/
Retrieved from http://www.positivescience.com. support/manuals.
Downloaded From: http://jov.arvojournals.org/pdfaccess.ashx?url=/data/Journals/JOV/934914/ on 03/07/2016
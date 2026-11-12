Discovering Important People and Objects for Egocentric Video Summarization
|     |     |     | YongJaeLee, |     | Joydeep           | Ghosh,andKristen |           |     | Grauman |     |     |     |
| --- | --- | --- | ----------- | --- | ----------------- | ---------------- | --------- | --- | ------- | --- | --- | --- |
|     |     |     |             |     | UniversityofTexas |                  | at Austin |     |         |     |     |     |
yjlee0222@utexas.edu, joydeep@ece.utexas.edu, grauman@cs.utexas.edu
|     |     | Abstract |     |     |     |     |     |     | .   | .   | .   |     |
| --- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Wepresentavideosummarizationapproachforegocen-
| tric or | “wearable” | camera | data. | Given | hours of | video, |     |     |     |     |     |     |
| ------- | ---------- | ------ | ----- | ----- | -------- | ------ | --- | --- | --- | --- | --- | --- |
Input: Egocentric video of the camera wearer’s day
theproposedmethodproducesacompactstoryboardsum-
| maryofthecamerawearer’sday. |           |             |     | Incontrasttotraditional |         |     |     |     |     |     |     |     |
| --------------------------- | --------- | ----------- | --- | ----------------------- | ------- | --- | --- | --- | --- | --- | --- | --- |
| keyframe                    | selection | techniques, | the | resulting               | summary | fo- |     |     |     |     |     |     |
cusesonthemostimportantobjectsandpeoplewithwhich
| the camera | wearer | interacts. | To  | accomplish | this, | we de- |          |          |          |          |          |          |
| ---------- | ------ | ---------- | --- | ---------- | ----- | ------ | -------- | -------- | -------- | -------- | -------- | -------- |
|            |        |            |     |            |       |        | 1:00 pm  | 2:00 pm  | 3:00 pm  | 4:00 pm  | 5:00 pm  | 6:00 pm  |
velop region cues indicative of high-level saliency in ego- Output: Storyboard summary of important people and objects
centric video—such as the nearness to hands, gaze, and Figure 1. Our system takes as input an unannotated egocentric
frequency of occurrence—andlearn a regressor to predict video, and produces a compact storyboard visual summary that
the relative importance of any new region based on these focusesonthekeypeopleandobjectsinthevideo.
cues. Usingthesepredictionsandasimpleformoftempo-
| ral event | detection, | our method | selects | frames | for | the sto- |        |            |            |             |          |         |
| --------- | ---------- | ---------- | ------- | ------ | --- | -------- | ------ | ---------- | ---------- | ----------- | -------- | ------- |
|           |            |            |         |        |     |          | system | that lacks | high-level | information | on which | objects |
ryboardthatreflectthekeyobject-drivenhappenings.Crit-
|                  |            |            |                        |            |     |        | matter may       | produce | a summary                         | that | consists of | irrelevant |
| ---------------- | ---------- | ---------- | ---------------------- | ---------- | --- | ------ | ---------------- | ------- | --------------------------------- | ---- | ----------- | ---------- |
| ically, the      | approachis | neither    | camera-wearer-specific |            |     | nor    |                  |         |                                   |      |             |            |
|                  |            |            |                        |            |     |        | framesorregions. |         | Inotherwords,existingmethodsdonot |      |             |            |
| object-specific; |            | that means | the learned            | importance |     | metric |                  |         |                                   |      |             |            |
performobject-drivensummarizationandareindifferentto
| neednotbe | trainedfora |     | givenuserorcontext, |     | anditcan |     |     |     |     |     |     |     |
| --------- | ----------- | --- | ------------------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- |
theimpactthateachobjecthasongeneratingthe“story”of
predicttheimportanceofobjectsandpeoplethathavenever
thevideo.
| been seen | previously. | Our | results | with 17 | hours | of ego- |     |     |     |     |     |     |
| --------- | ----------- | --- | ------- | ------- | ----- | ------- | --- | --- | --- | --- | --- | --- |
centricdatashowthemethod’spromiserelativetoexisting Inthiswork,weareinterestedincreatingobject-driven
summariesforvideoscapturedfromawearablecamera.An
techniquesforsaliencyandsummarization.
egocentricvideooffersafirst-personviewoftheworldthat
|     |     |     |     |     |     |     | cannot | be captured | from | environmental | cameras. | For ex- |
| --- | --- | --- | --- | --- | --- | --- | ------ | ----------- | ---- | ------------- | -------- | ------- |
1. Introduction
ample,wecanoftenseethecamerawearer’shands,orfind
|     |         |                     |     |       |         |        | the object | of interest | centered | in the | frame. Essentially, | a   |
| --- | ------- | ------------------- | --- | ----- | ------- | ------ | ---------- | ----------- | -------- | ------ | ------------------- | --- |
| The | goal of | video summarization |     | is to | produce | a com- |            |             |          |        |                     |     |
pactvisualsummarythatencapsulatesthekeycomponents wearablecamerafocusesontheuser’sactivities, socialin-
|     |     |     |     |     |     |     | teractions,andinterests. |     |     | Weaimtoexploittheseproperties |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------ | --- | --- | ----------------------------- | --- | --- |
ofavideo.Itsmainvalueisinturninghoursofvideointoa
shortsummarythatcanbeinterpretedbyahumanviewerin foregocentricvideosummarization.
amatterofseconds.Automaticvideosummarizationmeth- Good summaries for egocentric data would have wide
odswouldbeusefulforanumberofpracticalapplications, potentialuses. Notonlywouldrecreationalusers(including
suchasanalyzingsurveillancedata,videobrowsing,action “life-loggers”)find itusefulas a video diary,but thereare
recognition,orcreatingavisualdiary.
|     |     |     |     |     |     |     | also higher-impact |     | applications | in law | enforcement, | elder |
| --- | --- | --- | --- | --- | --- | --- | ------------------ | --- | ------------ | ------ | ------------ | ----- |
Existing methods extract keyframes [29, 30, 8], create and child care, and mental health. For example, the sum-
montages of still images [2, 4], or generate compact dy- maries could facilitate police officers in reviewing impor-
namicsummaries[22,21]. Despitepromisingresults,they tantevidence,suspects,andwitnesses, oraidpatientswith
assume a static background or rely on low-level appear- memoryproblemstorememberspecificevents,objects,and
ance and motion cues to select what will go into the final people[9]. Furthermore,theegocentricviewtranslatesnat-
summary. However, in many interesting settings, such as urally to robotics applications—suggesting, for example,
egocentric videos, YouTube style videos, or feature films, thatarobotcouldsummarizewhatitencounterswhilenav-
thebackgroundismovingandchanging. Morecritically,a igatingunexploredterritory,forlaterhumanviewing.
1

| Motivated |     | by these | problems, | we  | propose | an  | approach | 2.Related | Work |     |     |     |     |     |
| --------- | --- | -------- | --------- | --- | ------- | --- | -------- | --------- | ---- | --- | --- | --- | --- | --- |
thatlearnscategory-independentimportancecuesdesigned
Inthissection,wereviewrelatedworkinvideosumma-
explicitlytotargetthekeyobjectsandpeopleinthevideo. rization,saliencydetection,andegocentricdataanalysis.
Themainideaistoleveragenovelegocentricandhigh-level
saliencyfeaturestotrainamodelthatcanpredictimportant Videosummarization Statickeyframemethodscompute
motionstabilityfromopticalflow[29]orglobalscenecolor
| regionsin | the | video, | and then | to producea |     | concise | visual |     |     |     |     |     |     |     |
| --------- | --- | ------ | -------- | ----------- | --- | ------- | ------ | --- | --- | --- | --- | --- | --- | --- |
summary that is driven by those regions (see Fig. 1). By differences[30] to select the frames that go into the sum-
mary. Thelow-levelapproachmeansthatirrelevantframes
| learningto   | predictimportantregions,we |        |             |     |          | canfocusthe | vi-        |           |              |     |               |     |               |      |
| ------------ | -------------------------- | ------ | ----------- | --- | -------- | ----------- | ---------- | --------- | ------------ | --- | ------------- | --- | ------------- | ---- |
|              |                            |        |             |     |          |             |            | can often | be selected. |     | By generating |     | object-driven | sum- |
| sual summary |                            | on the | main people | and | objects, |             | and ignore |           |              |     |               |     |               |      |
irrelevantorredundantinformation. maries,weaimtomovebeyondsuchlow-levelcues.
|                          |     |     |     |                         |     |     |     | Video | summarization |     | can also | take | the form | of a sin- |
| ------------------------ | --- | --- | --- | ----------------------- | --- | --- | --- | ----- | ------------- | --- | -------- | ---- | -------- | --------- |
| Ourmethodworksasfollows. |     |     |     | Wefirsttrainaregression |     |     |     |       |               |     |          |      |          |           |
modelfromlabeledtrainingvideosthatscoresanyregion’s gle montage of still images. Existing methods take a
|            |     |           |       |           |        |     |            | backgroundreference |                 | frame | and     | project       | in foregroundre- |          |
| ---------- | --- | --------- | ----- | --------- | ------ | --- | ---------- | ------------------- | --------------- | ----- | ------- | ------------- | ---------------- | -------- |
| likelihood | of  | belonging | to an | important | person |     | or object. |                     |                 |       |         |               |                  |          |
|            |     |           |       |           |        |     |            | gions [2],          | or sequentially |       | display | automatically |                  | selected |
Fortheinputvariables,wedevelopasetofhigh-levelcues
tocaptureegocentricimportance,suchasfrequency,prox- key-poses [4]. An interactive approach [8] takes user-
selectedframesandkeypoints,andgeneratesastoryboard
| imityto  | the camerawearer’shand, |     |        |          | andobject-likeappear- |             |      |                |     |                |     |         |                 |     |
| -------- | ----------------------- | --- | ------ | -------- | --------------------- | ----------- | ---- | -------------- | --- | -------------- | --- | ------- | --------------- | --- |
|          |                         |     |        |          |                       |             |      | thatconveysthe |     | trajectoryofan |     | object. | Theseapproaches |     |
| ance and | motion.                 | The | target | variable | is                    | the overlap | with |                |     |                |     |         |                 |     |
generallyassumeshortclipswithfewobjects,orahuman-
| ground-truthimportantregions, |     |     |     | i.e., | the importance |     | score. |     |     |     |     |     |     |     |
| ----------------------------- | --- | --- | --- | ----- | -------------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
in-the-looptoguidethesummarizationprocess.Incontrast,
| Given a | novel | video, | we use | the model | to  | predict | impor- |     |     |     |     |     |     |     |
| ------- | ----- | ------ | ------ | --------- | --- | ------- | ------ | --- | --- | --- | --- | --- | --- | --- |
tantregionsforeachframe.Wethenpartitionthevideointo we aim to summarize a camera wearer’s day containing
|     |     |     |     |     |     |     |     | hours of | continuous | video | with | hundreds | of objects, | with |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ---------- | ----- | ---- | -------- | ----------- | ---- |
uniquetemporalevents,byclusteringscenesthathavesimi-
nohumanintervention.
| larcolordistributionsandarecloseintime. |     |     |     |     |     | Foreachevent, |     |     |     |     |     |     |     |     |
| --------------------------------------- | --- | --- | --- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
Compactdynamicsummariessimultaneouslyshowsev-
| we isolate          | unique | representative |                                 | instances |     | of each | impor- |               |                            |     |     |     |                |     |
| ------------------- | ------ | -------------- | ------------------------------- | --------- | --- | ------- | ------ | ------------- | -------------------------- | --- | --- | --- | -------------- | --- |
|                     |        |                |                                 |           |     |         |        | eralspatially | non-overlappingactionsfrom |     |     |     | differenttimes |     |
| tantpersonorobject. |        |                | Finally,weproduceastoryboardvi- |           |     |         |        |               |                            |     |     |     |                |     |
sualsummarythatdisplaysthemostimportantobjectsand of the video [22, 21]. While the framework aims to
|     |     |     |     |     |     |     |     | focus on | foreground | objects, |     | it assumes | a static | camera |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ---------- | -------- | --- | ---------- | -------- | ------ |
peopleacrossalleventsinthecamerawearer’sday.
|     |     |     |     |     |     |     |     | and is therefore |     | inapplicable | to  | egocentric | video. | A re- |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | ------------ | --- | ---------- | ------ | ----- |
Weemphasizethatwedonotaimtopredictimportance
targetingapproachaimstosimultaneouslypreserveanorig-
| for any | specific | category | (e.g., | cars). | Instead, |     | we learn a |     |     |     |     |     |     |     |
| ------- | -------- | -------- | ------ | ------ | -------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
inalvideo’scontentwhilereducingartifacts[24],butunlike
| general | model | that can | predict | the | importance |     | of any ob- |     |     |     |     |     |     |     |
| ------- | ----- | -------- | ------- | --- | ---------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
ject instance, irrespective of its category. This category- our approach, does not attempt to characterize the vary-
|     |     |     |     |     |     |     |     | ing degrees | of  | object | importance. |     | In a semi-automatic |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --- | ------ | ----------- | --- | ------------------- | --- |
independenceavoidstheneedtotrainimportancepredictors
method[17],irrelevantvideoframesareremovedbydetect-
specifictoagivencamerawearer,andallowsthesystemto
recognizeasimportantsomethingithasneverseenbefore. ing the main object of interest given a few user-annotated
|              |     |       |              |      |     |      |          | training | frames. | In contrast, | our | approach | automatically |     |
| ------------ | --- | ----- | ------------ | ---- | --- | ---- | -------- | -------- | ------- | ------------ | --- | -------- | ------------- | --- |
| In addition, | it  | means | that objects | from | the | same | category |          |         |              |     |          |               |     |
can be predicted to be (un)important depending on their discoversmultipleimportantobjects.
role in the story of the video. For example, if the camera Saliency detection Early saliency detectors rely on
wearerhaslunchwithhisfriendJill, shewouldbeconsid- bottom-upimagecues (e.g.,[12]). Morerecentwork tries
| ered important, |     | whereas | people | in the | same | restaurantsit- |     |     |     |     |     |     |     |     |
| --------------- | --- | ------- | ------ | ------ | ---- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
tolearnhigh-levelsaliencymeasures,whetherforstaticim-
tingaroundthemcouldbeunimportant. Then,iftheylater ages[18,3,6]orvideo[16]. Whereastypicallysuchmet-
| attend a | party | but chat | with | different | friends, | Jill | may no |     |     |     |     |     |     |     |
| -------- | ----- | -------- | ---- | --------- | -------- | ---- | ------ | --- | --- | --- | --- | --- | --- | --- |
ricsaimtoprimeavisualsearchprocess,weareinterested
longerbeconsideredimportantinthatcontext. inhigh-levelsaliencyforthesakeofisolatingthosethings
|               |     |     |                     |     |     |                |     | worthsummarizing. |     | Researchershavealso |     |     | exploredrank- |     |
| ------------- | --- | --- | ------------------- | --- | --- | -------------- | --- | ----------------- | --- | ------------------- | --- | --- | ------------- | --- |
| Contributions |     | Our | main contributionis |     |     | a novelegocen- |     |                   |     |                     |     |     |               |     |
ingobjectimportanceinstaticimages,learningwhatpeople
| tric video                       | summarization |            | approach |          | that is          | driven   | by pre- |              |                             |            |        |            |          |             |
| -------------------------------- | ------------- | ---------- | -------- | -------- | ---------------- | -------- | ------- | ------------ | --------------------------- | ---------- | ------ | ---------- | -------- | ----------- |
|                                  |               |            |          |          |                  |          |         | mentionfirst | fromhuman-annotatedtags[25, |            |        |            |          | 11]. Incon- |
| dictedimportantpeopleandobjects. |               |            |          |          | Weapplyourmethod |          |         |              |                             |            |        |            |          |             |
|                                  |               |            |          |          |                  |          |         | trast, we    | learn the                   | importance |        | of objects | in terms | of their    |
| to challenging                   |               | real-world | videos   | captured |                  | by users | in un-  |              |                             |            |        |            |          |             |
|                                  |               |            |          |          |                  |          |         | role in a    | long-term                   | video’s    | story. | Relative   | to       | any of the  |
controlledenvironments,andprocessatotalof17hoursof
above,weintroducenovelsaliencyfeaturesamenabletothe
video—ordersofmagnitudemoredatathanpreviouswork
egocentricvideosetting.
| inegocentricanalysis. |     |     | Evaluatingthepredictedimportance |     |     |     |     |     |     |     |     |     |     |     |
| --------------------- | --- | --- | -------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
estimatesandsummaries,wefindourapproachoutperforms Egocentricvisualdataanalysis Visionresearchershave
state-of-the-art saliency measures for this task, and pro- only recently begun to explore egocentric visual analysis.
duces significantly more informative summaries than tra- Earlyworkwithwearablecamerassegmentsvisualandau-
ditionalmethodsunabletofocusontheimportantpeopleor dio data into events [5]. Recent methods explore activity
objects. recognition [7], handled object recognition [23], novelty

| detection  | [1], or      | activity | discovery  |     | for non-visual |     | sensory |     |     |     |     |     |     |     |
| ---------- | ------------ | -------- | ---------- | --- | -------------- | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
| data [10]. | Unsupervised |          | algorithms |     | are developed  |     | to dis- |     |     |     |     |     |     |     |
coverscenes[13]oractions[15]basedonlow-levelvisual
| featuresextractedfromegocentricdata. |     |     |     |     | Incontrast,weaim |     |     |     |     |     |     |     |     |     |
| ------------------------------------ | --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
tobuildavisualsummary,andmodelhigh-levelimportance
|     |     |     |     |     |     |     |     | Man wearing a blue shirt in cafe  |     | Yellow notepad on table  |     |     | Camera wearer cleaning the plates  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------------------- | --- | ------------------------ | --- | --- | ---------------------------------- | --- |
oftheobjectspresent.Toourknowledge,wearethefirstto Figure2.ExampleannotationsobtainedusingMechanicalTurk.
performvisualsummarizationforegocentricdata.
3. Approach large amounts of annotations using Amazon’s Mechanical
|     |     |     |     |     |     |     |     | Turk(MTurk). |     | Foregocentricvideos,anobject’sdegreeof |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | -------------------------------------- | --- | --- | --- | --- |
Ourgoalistocreateastoryboardsummaryofaperson’s
importancewillhighlydependonwhatthecameraweareris
| daythatisdrivenbytheimportantpeopleandobjects. |     |     |     |     |     |     | The |     |     |     |     |     |     |     |
| ---------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
doingbefore,while,andaftertheobjectorpersonappears.
videoiscapturedusingawearablecamerathatcontinuously
Inotherwords,theobjectmustbeseeninthecontextofthe
| records | what the | user | sees. | We define | importance |     | in the |     |     |     |     |     |     |     |
| ------- | -------- | ---- | ----- | --------- | ---------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
camerawearer’sactivitytoproperlygaugeitsimportance.
| scopeofegocentricvideo: |     |     | importantthingsare |     |     | thosewith |     |     |     |     |     |     |     |     |
| ----------------------- | --- | --- | ------------------ | --- | --- | --------- | --- | --- | --- | --- | --- | --- | --- | --- |
Wecarefullydesigntwoannotationtaskstocapturethis
whichthecamerawearerhassignificantinteraction.
|       |          |      |       |        |           |     |         | aspect. | In the first | task, | we ask | workers | to watch | a three |
| ----- | -------- | ---- | ----- | ------ | --------- | --- | ------- | ------- | ------------ | ----- | ------ | ------- | -------- | ------- |
| There | are four | main | steps | to our | approach: |     | (1) us- |         |              |       |        |         |          |         |
minuteacceleratedvideo(equivalentto10minutesoforig-
| ing novel | egocentric |     | saliency | cues | to train | a category- |     |     |     |     |     |     |     |     |
| --------- | ---------- | --- | -------- | ---- | -------- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
inalvideo)andtodescribeintextwhattheyperceivetobe
| independent | regression |     | model | that | predicts | how likely | an  |     |     |     |     |     |     |     |
| ----------- | ---------- | --- | ----- | ---- | -------- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
essentialpeopleorobjectsnecessarytocreateasummaryof
imageregionbelongstoanimportantpersonorobject;(2)
thevideo.Inthesecondtask,wedisplayuniformlysampled
| partitioningthevideointotemporalevents. |     |     |     |     |     | Foreachevent, |     |     |     |     |     |     |     |     |
| --------------------------------------- | --- | --- | --- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
framesfromthevideoandtheircorrespondingtextdescrip-
| (3) scoring | each      | region’s       | importance |            | using | the regressor; |        |                   |        |               |       |        |            |         |
| ----------- | --------- | -------------- | ---------- | ---------- | ----- | -------------- | ------ | ----------------- | ------ | ------------- | ----- | ------ | ---------- | ------- |
|             |           |                |            |            |       |                |        | tionsobtainedfrom |        | thefirst      | task, | andask | workersto  | draw    |
| and (4)     | selecting | representative |            | key-frames |       | for the        | story- |                   |        |               |       |        |            |         |
|             |           |                |            |            |       |                |        | polygons          | around | any described |       | person | or object. | If none |
boardbasedonthepredictedimportantpeopleandobjects.
|              |             |     |        |         |       |            |     | of the described  |     | objects  | are present | in      | a frame, | the anno-   |
| ------------ | ----------- | --- | ------ | ------- | ----- | ---------- | --- | ----------------- | --- | -------- | ----------- | ------- | -------- | ----------- |
| We first     | describe    |     | how we | collect | the   | video data | and |                   |     |          |             |         |          |             |
|              |             |     |        |         |       |            |     | tator is giventhe |     | optionto | skip        | it. See | Fig. 2   | for example |
| ground-truth | annotations |     | needed | to      | train | our model. | We  |                   |     |          |             |         |          |             |
annotations.
thendescribeeachofthemainstepsinturn.
Wefoundthistwo-stepprocessmoreeffectivethanasin-
3.1.Egocentricvideodatacollection gle task in which the same workerboth watches the video
andthenannotatestheregionss/hedeemsimportant,likely
| We use                                         | the      | Looxcie | wearable         | camera1, |     | which   | captures |                                          |             |     |          |       |       |              |
| ---------------------------------------------- | -------- | ------- | ---------------- | -------- | --- | ------- | -------- | ---------------------------------------- | ----------- | --- | -------- | ----- | ----- | ------------ |
|                                                |          |         |                  |          |     |         |          | duetothetimerequiredtocompletebothtasks. |             |     |          |       |       | Critically,  |
| videoat                                        | 15 fpsat | 320     | x 480resolution. |          | It  | is worn | around   |                                          |             |     |          |       |       |              |
|                                                |          |         |                  |          |     |         |          | the two-step                             | processalso |     | helps us | avoid | bias: | a single an- |
| theearandlooksoutattheworldatroughlyeye-level. |          |         |                  |          |     |         | We       |                                          |             |     |          |       |       |              |
notatoraskedtocompletebothtasksatoncemaybebiased
collected10videos,eachofthreetofivehoursinlength(the
topickeasierthingstoannotateratherthanthoses/hefinds
maxLooxciebatterylife),foratotalof37hoursofvideo.
|     |     |     |     |     |     |     |     | tobemostimportant. |     | Oursetupmakesiteasyforthefirst |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------ | --- | ------------------------------ | --- | --- | --- | --- |
Foursubjectsworethecameraforus:oneundergraduate
workertofreelydescribetheobjectswithoutbias,sinces/he
| student,    | two grad | students, | and      | one      | office   | worker, | ranging  |          |          |          |          |           |     |             |
| ----------- | -------- | --------- | -------- | -------- | -------- | ------- | -------- | -------- | -------- | -------- | -------- | --------- | --- | ----------- |
|             |          |           |          |          |          |         |          | only has | to enter | text. We | foundthe | resulting |     | annotations |
| in age from | early    | to        | late 20s | and both | genders. |         | The dif- |          |          |          |          |           |     |             |
quiteconsistent,andonlymanuallyprunedthosewherethe
| ferent backgrounds |     | of  | the subjects |     | ensure | diversity | in the |     |     |     |     |     |     |     |
| ------------------ | --- | --- | ------------ | --- | ------ | --------- | ------ | --- | --- | --- | --- | --- | --- | --- |
regionoutlineddidnotagreewiththefirstworker’sdescrip-
| data—not                                         | everyone’s |     | day is | the same—and |     | is critical | for |           |       |             |     |                |     |             |
| ------------------------------------------------ | ---------- | --- | ------ | ------------ | --- | ----------- | --- | --------- | ----- | ----------- | --- | -------------- | --- | ----------- |
|                                                  |            |     |        |              |     |             |     | tion. For | a 3-5 | hour video, | we  | obtain roughly |     | 35 text de- |
| validatingthecategory-independenceofourapproach. |            |     |        |              |     |             | We  |           |       |             |     |                |     |             |
scriptionsand700objectsegmentations.
askedthesubjectstorecordtheirnaturaldailyactivities,and
explicitlyinstructedthemnottostageanythingforthispur- 3.3.Learningregionimportanceinegocentricvideo
pose. Thevideoscaptureavarietyofactivitiessuchaseat-
Wenowdiscusstheproceduretotrainageneralpurpose
ing,shopping,attendingalecture,driving,andcooking.
category-independentmodelthatwillpredictimportantre-
3.2.Annotatingimportantregionsintrainingvideo
|     |     |     |     |     |     |     |     | gions in | any egocentric |          | video, independent |                          | of  | the camera |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | -------------- | -------- | ------------------ | ------------------------ | --- | ---------- |
|     |     |     |     |     |     |     |     | wearer.  | Givena         | video,we | first              | generatecandidateregions |     |            |
Totraintheimportancepredictor,wefirstneedground-
truthtrainingexamples.Ingeneral,determiningwhetheran for each frame using the segmentationmethod of [3]. We
purposefullyrepresentobjectsattheframe-level,sinceour
| objectis   | importantor |     | notcan             | be highlysubjective. |     |             | Fortu- |                       |         |         |                |          |           |            |
| ---------- | ----------- | --- | ------------------ | -------------------- | --- | ----------- | ------ | --------------------- | ------- | ------- | -------------- | -------- | --------- | ---------- |
|            |             |     |                    |                      |     |             |        | uncontrolled          | setting | usually | prohibits      | reliable |           | space-time |
| nately, an | egocentric  |     | video providesmany |                      |     | constraints | that   |                       |         |         |                |          |           |            |
|            |             |     |                    |                      |     |             |        | objectsegmentationdue |         |         | to frequentand |          | rapidhead | move-      |
aresuggestiveofanobject’simportance.
|     |     |     |     |     |     |     |     | mentsbythecamerawearer.2 |     |     | Wegenerateroughly800re- |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------ | --- | --- | ----------------------- | --- | --- | --- |
Inordertolearnmeaningfulegocentricpropertieswith-
| outoverfittingtoanyparticularcategory,we |     |     |     |     |     | crowd-source |     | gionsperframe. |     |     |     |     |     |     |
| ---------------------------------------- | --- | --- | --- | --- | --- | ------------ | --- | -------------- | --- | --- | --- | --- | --- | --- |
1http://looxcie.com/ 2Indeed,wefoundKLTtrackstolastonlyafewframesonourdata.

|     |     |     |     |     |     |     |     | andcountaspositivethosethatpasstheratiotest[19]. |         |          |       |     |        | We            |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------------ | ------- | -------- | ----- | --- | ------ | ------------- |
|     |     |     |     |     |     |     |     | repeat this                                      | process | for each | point | in  | region | r, and record |
theiraveragenumberofpositivematches:
|     |     |     |     |     |     |     |     |     |     | 1 P |     | d(p | ,pf ) |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- |
|     |     |     |     |     |     |     |     |     |     |     |     | i   | 1∗    |     |
distance to hand  distance to frame center  frequency  c point (r)= ≤θ p , (2)
|     |                                              |     |     |     |     |     |     |     |     | P      |     | "d(p | ,pf ) |     |
| --- | -------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | ---- | ----- | --- |
|     | Figure3.Illustrationofouregocentricfeatures. |     |     |     |     |     |     |     |     | i=1f∈W |     | i    | 2∗    | #   |
|     |                                              |     |     |     |     |     |     |     |     | X      | X   |      |       |     |
,pf
|     |     |     |     |     |     |     |     | where i | indexes | all detected | points | in  | region | r, d(p i 1∗ ) |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | ------- | ------------ | ------ | --- | ------ | ------------- |
Foreachregion,wecomputeasetofcandidatefeatures and d(p ,pf ) measure the Euclidean distance between p
|     |     |     |     |     |     |     |     | i   | 2∗  |     |     |     |     | i   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
that could be useful to describe its importance. Since the pf
|     |     |     |     |     |     |     |     | and its best | matching | point |     | and second |     | best matching |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | -------- | ----- | --- | ---------- | --- | ------------- |
video is captured by an active participant, we specifically 1∗
pf
|      |            |            |     |            |      |            |     | point 2∗          | in frame | f, respectively,          |     | and | θ p is | Lowe’s ratio |
| ---- | ---------- | ---------- | --- | ---------- | ---- | ---------- | --- | ----------------- | -------- | ------------------------- | --- | --- | ------ | ------------ |
| want | to exploit | egocentric |     | properties | such | as whether | the |                   |          |                           |     |     |        |              |
|      |            |            |     |            |      |            |     | test thresholdfor |          | non-ambiguousmatches[19]. |     |     |        | The value    |
object/personisinteractingwiththecamerawearer,whether
|     |     |     |     |     |     |     |     | ofc | willbehigh/lowwhentheSIFTpointsinrproduce |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------------------------------------- | --- | --- | --- | --- | --- |
point
itisthefocusofthewearer’sgaze,andwhetheritfrequently
|     |     |     |     |     |     |     |     | many/fewmatches. |     | Forbothfrequencyfeatures,wesetW |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | ------------------------------- | --- | --- | --- | --- |
appears. Inaddition,weaimtocapturehigh-levelsaliency
tospana10minutetemporalwindow.
| cues—such |     | as an | object’s | motion | and appearance, |     | or the |        |          |             |     |        |                     |     |
| --------- | --- | ----- | -------- | ------ | --------------- | --- | ------ | ------ | -------- | ----------- | --- | ------ | ------------------- | --- |
|           |     |       |          |        |                 |     |        | Object | features | In addition |     | to the | egocentric-specific |     |
likelihoodofbeingahumanface—andgenericregionprop-
ertiessharedacrosscategories,suchassizeorlocation.We features, we include three high-level (i.e., object-based)
|     |     |     |     |     |     |     |     | saliency | cues. | To model | object-like |     | appearance, | we use |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ----- | -------- | ----------- | --- | ----------- | ------ |
describeeachfeatureindetailbelow.
thelearnedregionrankingfunctionof[3].ItreflectsGestalt
| Egocentric          |     | features | Fig.                            | 3 illustrates | the | three proposed |     |                              |     |             |     |                          |         |               |
| ------------------- | --- | -------- | ------------------------------- | ------------- | --- | -------------- | --- | ---------------------------- | --- | ----------- | --- | ------------------------ | ------- | ------------- |
|                     |     |          |                                 |               |     |                |     | cues indicativeof            |     | any object, |     | such as                  | the sum | of affinities |
| egocentricfeatures. |     |          | Tomodelinteraction,wecomputethe |               |     |                |     |                              |     |             |     |                          |         |               |
|                     |     |          |                                 |               |     |                |     | alongtheregion’sboundary,its |     |             |     | perimeter,andtexturedif- |         |               |
Euclideandistanceoftheregion’scentroidtotheclosestde-
|     |     |     |     |     |     |     |     | ference | with nearby | pixels. | (Note | that | the authors | trained |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | ----------- | ------- | ----- | ---- | ----------- | ------- |
tectedhandintheframe.Givenaframeinthetestvideo,we
|     |     |     |     |     |     |     |     | their measure |     | on PASCAL | data, | which | is  | disjoint from |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | --------- | ----- | ----- | --- | ------------- |
firstclassifyeachpixelas(non-)skinusingcolorlikelihoods
|     |     |     |     |     |     |     |     | ours.) We | stress | that this | feature | estimates |     | how “object- |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------ | --------- | ------- | --------- | --- | ------------ |
andaNaiveBayesclassifier[14]trainedwithground-truth
|                                |     |     |     |     |                      |     |     | like” a region |     | is, and not | its importance. |     | It  | is useful for |
| ------------------------------ | --- | --- | --- | --- | -------------------- | --- | --- | -------------- | --- | ----------- | --------------- | --- | --- | ------------- |
| handannotationsondisjointdata. |     |     |     |     | Wethenclassifyanysu- |     |     |                |     |             |                 |     |     |               |
identifyingfullobjectsegments,asopposedtofragments.
| perpixel |     | as hand | if more | than 25% | of its | pixels are | skin. |     |     |     |     |     |     |     |
| -------- | --- | ------- | ------- | -------- | ------ | ---------- | ----- | --- | --- | --- | --- | --- | --- | --- |
Tomodelobject-likemotion,weusethefeaturedefined
Whilesimple,wefindthishanddetectorissufficientforour
|     |     |     |     |     |     |     |     | in [16]. | It looks | at the | difference | in  | motion | patterns of a |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | -------- | ------ | ---------- | --- | ------ | ------------- |
application.Moresophisticatedmethodswouldcertainlybe
|     |     |     |     |     |     |     |     | region relative |     | to its closest | surrounding |     | regions. | Similar |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- | -------------- | ----------- | --- | -------- | ------- |
possibleaswell.
|     |          |       |            |     |           |          |     | to the appearance |     | feature | above, | it is | useful | for selecting |
| --- | -------- | ----- | ---------- | --- | --------- | -------- | --- | ----------------- | --- | ------- | ------ | ----- | ------ | ------------- |
|     | To model | gaze, | we compute | the | Euclidean | distance | of  |                   |     |         |        |       |        |               |
object-likeregionsthat“stand-out”fromtheirsurroundings.
| theregion’scentroidtotheframecenter. |     |     |     |     | Sincethecamera |     |     |     |     |     |     |     |     |     |
| ------------------------------------ | --- | --- | --- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Tomodelthelikelihoodofaperson’sface,wecompute
| moveswith                             |     | the wearer’s |     | head, this | is a coarse | estimate | of  |                        |     |     |       |                      |     |     |
| ------------------------------------- | --- | ------------ | --- | ---------- | ----------- | -------- | --- | ---------------------- | --- | --- | ----- | -------------------- | --- | --- |
|                                       |     |              |     |            |             |          |     | themaximumoverlapscore |     |     | |q∩r| | betweentheregionrand |     |     |
| howlikelytheregionisbeingfocusedupon. |     |              |     |            |             |          |     |                        |     |     | |q∪r| |                      |     |     |
anydetectedfrontalfaceqintheframe,using[27].
Tomodelfrequency,werecordthenumberoftimesan
objectinstanceisdetectedwithinashorttemporalsegment Region features Finally, we compute the region’s size,
| ofthevideo. |     | We createtwofrequencyfeatures: |     |     |     | onebased |     |           |          |     |           |          |     |            |
| ----------- | --- | ------------------------------ | --- | --- | --- | -------- | --- | --------- | -------- | --- | --------- | -------- | --- | ---------- |
|             |     |                                |     |     |     |          |     | centroid, | bounding | box | centroid, | bounding |     | box width, |
on matching regions, the other based on matching points. and bounding box height. They reflect category-
Forthefirst, wecomputethecolordissimilaritybetweena independentimportance cues and are blind to the region’s
regionr andeachregionr n initssurroundingframes,and appearanceormotion.Weexpectthatimportantpeopleand
accumulatethetotalnumberofpositivematches: objects will occur at non-random scales and locations in
theframe,duetosocialandenvironmentalfactorsthatcon-
[(minχ2(r,rf))≤θ
c (r)= ], (1) strain their relative positioningto the camera wearer (e.g.,
|     |     | region |     | n   | n   | r   |     |     |     |     |     |     |     |     |
| --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
sittingacrossatablefromsomeonewhenhavinglunch,or
f∈W X
|           | f      |         |          |                 |               |       |           | handlingcookingutensilsatarm’slength). |     |            |      |                  | Ourregionfea- |         |
| --------- | ------ | ------- | -------- | --------------- | ------------- | ----- | --------- | -------------------------------------- | --- | ---------- | ---- | ---------------- | ------------- | ------- |
| where     |        | indexes | the set  | of frames       | W surrounding |       | region    |                                        |     |            |      |                  |               |         |
|           |        | χ2(r,r  |          | χ2-distance     |               |       |           | turescapturethesestatistics.           |     |            |      |                  |               |         |
| r’s       | frame, |         | ) is the |                 | between       | color | his-      |                                        |     |            |      |                  |               |         |
|           |        |         | n        |                 |               |       |           | Altogether,                            |     | these cues | form | a 14-dimensional |               | feature |
| togramsof |        | r and   | r , θ    | is the distance | threshold     |       | to deter- |                                        |     |            |      |                  |               |         |
n r
spacetodescribeeachcandidateregion(4egocentric,3ob-
| mine | a positive | match, | and | [·] denotes | the | indicator | func- |     |     |     |     |     |     |     |
| ---- | ---------- | ------ | --- | ----------- | --- | --------- | ----- | --- | --- | --- | --- | --- | --- | --- |
ject,and7regionfeaturedimensions).
| tion.Thevalueofc |     |     |     | willbehigh/lowwhenrproduces |     |     |     |     |     |     |     |     |     |     |
| ---------------- | --- | --- | --- | --------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
region
many/fewmatches(i.e.,isfrequent/infrequent). Regressor to predict region importance Using the fea-
Thesecondfrequencyfeatureiscomputedbymatching turesdefinedabove,wenexttrainamodelthatcanpredicta
DoG+SIFTinterestpoints. Foradetectedpointpinregion region’simportance.Themodelshouldbeabletolearnand
r,wematchittoalldetectedpointsineachframef ∈ W, predicta region’sdegreeofimportanceinsteadofwhether

|     |     |     |     |     |     |     | all video | frames. | We compute |     | a pairwise | distance | matrix |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ---------- | --- | ---------- | -------- | ------ |
time
|     |     |     |     |     |     |     | D betweenallframesf |     |     | ,f  | ∈V,usingthedistance: |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------- | --- | --- | --- | -------------------- | --- | --- |
|     |     |     |     |     |     |     | V                   |     |     | m n |                      |     |     |
1
|     |     |     |     |     |     |     |         |        | )=1−wt           |     |       | χ2(f             |              |
| --- | --- | --- | --- | --- | --- | --- | ------- | ------ | ---------------- | --- | ----- | ---------------- | ------------ |
|     |     |     |     |     |     |     | D(f     | m ,f n |                  |     | exp(− | m                | ,f n )), (4) |
|     |     |     |     |     |     |     |         |        |                  | m,n | Ω     |                  |              |
|     |     |     |     |     |     |     | wherewt | =      | 1max(0,t−|m−n|), |     |       | t isthesizeofthe |              |
|     |     |     |     |     |     |     |         | m,n    | t                |     |       |                  |              |
,χ2(f
|     |     |     |     |     |     |     | temporalwindowsurroundingframef |         |       |                                |     | m    | m ,f n )isthe |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------- | ------- | ----- | ------------------------------ | --- | ---- | ------------- |
|     |     |     |     |     |     |     | χ2-distance                     | between | color | histograms                     |     | of f | and f , and   |
|     |     |     |     |     |     |     |                                 |         |       |                                |     | m    | n             |
|     |     |     |     |     |     |     | denotesthemeanof                |         |       | theχ2-distancesamongallframes. |     |      |               |
Ω
time
Thus,framessimilarincolorreceivealowdistance,subject
Figure4.Distancematrixthatmeasuresglobalcolordissimilarity toaweightthatdiscouragesframestoodistantintimefrom
| between all | frames. | (Blue/red | reflects | high/low | distance.) | The |     |     |     |     |     |     |     |
| ----------- | ------- | --------- | -------- | -------- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
beinggrouped.
imagesshowrepresentativeframesofeachdiscoveredevent. We next perform complete-link agglomerative cluster-
ingwithD
V ,groupingframesuntilthesmallestmaximum
itissimply“important”or“notimportant”,sothatwecan inter-frame distance is larger than two standard deviations
meaningfullyadjustthecompactnessofthe finalsummary beyond Ω. The first and last frames in a cluster deter-
(as we demonstratein Sec. 4). Thus, we optto train a re- mine the start and end frames of an event, respectively.
gressorratherthanaclassifier. Sinceeventscanoverlap,weretain(almost)disjointevents
|       |              |     |         |       |                     |     | by eliminating | those | with | greaterthan |     | θ     | overlapwith |
| ----- | ------------ | --- | ------- | ----- | ------------------- | --- | -------------- | ----- | ---- | ----------- | --- | ----- | ----------- |
| While | the features |     | defined | above | can be individually |     |                |       |      |             |     | event |             |
meaningful,wealsoexpectsignificantinteractionsbetween events with higher silhouette-coefficients [26] in a greedy
|              |              |     |                           |     |     |     | manner. | Higher/lowerθ |     | leadstomore/fewereventsin |     |     |     |
| ------------ | ------------ | --- | ------------------------- | --- | --- | --- | ------- | ------------- | --- | ------------------------- | --- | --- | --- |
| thefeatures. | Forexample,a |     | regionthatisnearthecamera |     |     |     |         |               |     | event                     |     |     |     |
wearer’shand mightbe importantonly if it is also object- thefinalsummary. SeeFig.4forthedistancematrixcom-
like in appearance. Therefore,we train a linear regression putedfromoneofoursubject’sday,andtherepresentative
framesforeachdiscoveredevent.
| model with | pair-wise | interaction |     | terms | to predict | a region |     |     |     |     |     |     |     |
| ---------- | --------- | ----------- | --- | ----- | ---------- | -------- | --- | --- | --- | --- | --- | --- | --- |
r’simportancescore: One could further augment the distance in Eqn. 4 with
|     |     |     |     |     |     |     | GPS locations, |     | when available |     | (though | GPS | alone would |
| --- | --- | --- | --- | --- | --- | --- | -------------- | --- | -------------- | --- | ------- | --- | ----------- |
N N N be insufficientto discriminate multiple indoor positionsin
| I(r)=β | 0+  | β i x i | (r)+     |     | β i,j x i (r)x | j (r), (3) | thesamebuilding). |     |     |     |     |     |     |
| ------ | --- | ------- | -------- | --- | -------------- | ---------- | ----------------- | --- | --- | --- | --- | --- | --- |
|        |     | i=1     | i=1j=i+1 |     |                |            |                   |     |     |     |     |     |     |
|        | X   |         | X        | X   |                |            |                   |     |     |     |     |     |     |
3.5.Discoveringanevent’skeypeopleandobjects
| where the | β’s | are the learned |     | parameters, | x (r) | is the ith |     |     |     |     |     |     |     |
| --------- | --- | --------------- | --- | ----------- | ----- | ---------- | --- | --- | --- | --- | --- | --- | --- |
i
featurevalue,andN =14isthetotalnumberoffeatures. Foreachevent,weaimtoselecttheimportantpeopleand
For training, we define a region r’s target importance objectsthatwillgointothefinalsummary,whileavoiding
scorebyitsmaximumoverlap|GT∩r|
withanyground-truth redundancy. Givenanevent,wefirstscoreeachbottom-up
|GT∪r|
regionGT in a trainingvideoobtainedfromSec. 3.2. We segment in each frame using our regressor. We take the
standardizethefeaturestozero-meanandunit-variance,and highest-scored regions (where “high” depends on a user-
solvefortheβ’susingleast-squares.Fortesting,ourmodel specified summary compactness criterion, see below) and
groupinstancesofthesamepersonorobjecttogether.Since
| takesasinputaregionr’sfeatures(thex |     |     |     |     | i ’s)andpredictsits |     |     |     |     |     |     |     |     |
| ----------------------------------- | --- | --- | --- | --- | ------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
importancescoreI(r). wedonotknowapriorihowmanyimportantthingsanevent
contains,wegenerateacandidatepoolofclustersfromthe
3.4.Segmentingthevideointotemporalevents set ofhigh-scoringregions, andthen removeanyredun-
C
dantclusters,asfollows.
| Given | a new | video, | we first | partition | the video | tempo- |            |     |           |         |     |          |            |
| ----- | ----- | ------ | -------- | --------- | --------- | ------ | ---------- | --- | --------- | ------- | --- | -------- | ---------- |
|       |       |        |          |           |           |        | To extract | the | candidate | groups, |     | we first | compute an |
rallyintoevents,andthenisolatetheimportantpeopleand
|                                                    |     |             |     |                     |     |         | affinity | matrix     | K over | all        | pairs of | regions | r m ,r n ∈  |
| -------------------------------------------------- | --- | ----------- | --- | ------------------- | --- | ------- | -------- | ---------- | ------ | ---------- | -------- | ------- | ----------- |
| objectsineachevent.Eventsallowthefinalsummarytoin- |     |             |     |                     |     |         |          |            | C      |            |          |         |             |
|                                                    |     |             |     |                     |     |         | C, where | affinity   | is     | determined | by       | color   | similarity: |
| cludemultiple                                      |     | instancesof | an  | object/personthatis |     | central |          |            |        |            |          |         |             |
|                                                    |     |             |     |                     |     |         | K (r ,r  | exp(−1χ2(r |        |            | ,r       |         |             |
|                                                    |     |             |     |                     |     |         | C m      | n ) =      |        | m          | n )),    | where Γ | denotes the |
in multiple contextsin the video (e.g., the dog at home in χ2-distance Γ
|     |     |     |     |     |     |     | mean |     | among | all pairs | in  | C. We next | partition |
| --- | --- | --- | --- | --- | --- | --- | ---- | --- | ----- | --------- | --- | ---------- | --------- |
themorning,andthenthedogattheparkatnight).
K intomultiple(possiblyoverlapping)inlier/outlierclus-
C
| To detect  | egocentric |      | events, | we cluster | scenes     | in such |            |                            |     |     |     |                |     |
| ---------- | ---------- | ---- | ------- | ---------- | ---------- | ------- | ---------- | -------------------------- | --- | --- | --- | -------------- | --- |
|            |            |      |         |            |            |         | tersusinga | factorizationapproach[20]. |     |     |     | Themethodfinds |     |
| a way that | frames     | with | similar | global     | appearance | can be  |            |                            |     |     |     |                |     |
tightsub-graphswithintheinputaffinitygraphwhileresist-
| grouped | together | even | when | there are | a few | unrelated |                            |     |     |                            |     |     |     |
| ------- | -------- | ---- | ---- | --------- | ----- | --------- | -------------------------- | --- | --- | -------------------------- | --- | --- | --- |
|         |          |      |      |           |       |           | ingtheinfluenceofoutliers. |     |     | Eachresultingsub-graphcon- |     |     |     |
them.3
| frames (“gaps”) |     | between |     | Let | V denote | the set of |                                              |     |          |           |          |     |             |
| --------------- | --- | ------- | --- | --- | -------- | ---------- | -------------------------------------------- | --- | -------- | --------- | -------- | --- | ----------- |
|                 |     |         |     |     |          |            | sistsofacandidateimportantobject’sinstances. |     |          |           |          |     | Toreduce    |
|                 |     |         |     |     |          |            | redundancy,we                                |     | sort the | sub-graph | clusters | by  | the average |
3Traditionalshotdetectionisimpracticalforwearablecameradata;it
oversegmentseventsduetofrequentheadmovements. I(r) of theirmemberregions,andremovethosewith high

1 Important (Ours):  0.26  1. size  8. height  15. obj app.  22. bbox x + reg freq.
Object−like [3]:  0.14 2. size + height  9. pt freq.  16. x  23. x + reg freq.
noisicerP 3. y + face  10. size + reg freq.  17. size + x  24. obj app. + size
Object−like [6]:  0.08
Saliency [28]:  0.04 GT: Important  4. size + pt freq.  11. gaze  18. gaze + x  25. y + interaction
0.5
|     |     |     |     |     |     |     | 5. bbox y + face  | 12. face  | 19. obj app. + y  |     | 26. width + height  |     |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | --------- | ----------------- | --- | ------------------- | --- |
|     |     |     |     |     |     |     | 6. width          | 13. y     | 20. x + bbox x    |     | 27. gaze + bbox x   |     |
0   7. size + gaze  14. size + width  21. y + bbox x  28. bbox y + interaction
| 0   | 0.2 0.4 | 0.6 0.8 | 1   |     |     |     |     |     |     |     |     |     |
| --- | ------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Recall GT: Unimportant  Figure6.Top28featureswithhighestlearnedweights.
| Figure5.Precision-Recall |             | for      | important       | object | prediction | across |     |     |     |     |     |     |
| ------------------------ | ----------- | -------- | --------------- | ------ | ---------- | ------ | --- | --- | --- | --- | --- | --- |
| all splits,              | and example | selected | regions/frames. |        | Numbers    | in the |     |     |     |     |     |     |
legends denote average precision. Compared to state-of-the-art Importantregionpredictionaccuracy Wefirstevaluate
high-level[3,6]andlow-level[28]saliencymethods,ouregocen- ourmethod’sabilitytopredictimportantregions,compared
tricapproachmoreaccuratelydiscoverstheimportantregions.
to threestate-of-the-arthigh-andlow-levelsaliencymeth-
ods:(1)theobject-likescoreof[3],(2)theobject-likescore
affinitytoahigher-rankedcluster. Finally,foreachremain- of[6],and(3)thebottom-upsaliencydetectorof[28]. The
ingcluster,weselecttheregionwiththehighestimportance firsttwoarelearnedfunctionsthatpredictaregion’slikeli-
scoreasitsrepresentative. Notethatthisgroupingstepre- hoodofoverlappingatrueobject,whereasthelow-levelde-
inforcestheegocentricfrequencycuedescribedinSec.3.3. tectoraimstofindregionsthat“stand-out”. Sincethebase-
linesareallgeneral-purposemetrics(nottailoredtoegocen-
3.6.Generatingastoryboardsummary
tricdata),theyallowustogaugetheimpactofourproposed
Finally, we create a storyboard visual summary of the egocentriccuesforfindingimportantobjectsinvideo.
video. We display the eventboundariesand framesof the We use the annotations obtained on MTurk as ground
selected important people and objects (see Fig. 8). Each truth(GT) (see Sec. 3.2). Some framescontainmore than
eventcandisplayavaryingnumberofframes,dependingon one important region, and some contain none, simply de-
pendingonwhattheannotatorsdeemedimportant.Onaver-
| how many | unique | important | things | our | method | discovers. |     |     |     |     |     |     |
| -------- | ------ | --------- | ------ | --- | ------ | ---------- | --- | --- | --- | --- | --- | --- |
We automatically adjust the compactness of the summary age,eachvideocontains680annotatedframesand280,000
withselectioncriteriaontheregionimportancescoresand test regions. A regionr is consideredto be a true positive
eventoverlaps,asweillustrateinourresults. (i.e.,importantobject),ifitsoverlapscorewithanyGTre-
Inadditiontobeingacompactvideodiaryofone’sday, gionisgreaterthan0.5,followingPASCALconvention.
Fig.5(left)showsprecision-recallcurvesonalltestre-
| our storyboard | summary |     | can be | consideredas | a   | visual in- |     |     |     |     |     |     |
| -------------- | ------- | --- | ------ | ------------ | --- | ---------- | --- | --- | --- | --- | --- | --- |
dex to help a user peruse specific parts of the video. This gionsacrossalltrain/testsplits. Ourapproachpredictsim-
wouldbeusefulwhenonewantstoreliveaspecificmoment portant regions significantly better than all three existing
orsearchforlessimportantpeopleorobjectsthatoccurred methods.Thetwohigh-levelmethodscansuccessfullyfind
withthosefoundbyourmethod. prominentobject-like regions, and so they noticeably out-
performthelow-levelsaliencydetector.However,byfocus-
4. Results
ingondetectinganyprominentobject,unlikeourapproach
|     |     |     |     |     |     |     | theyare unableto | distinguishthose |     | thatmay | be  | important |
| --- | --- | --- | --- | --- | --- | --- | ---------------- | ---------------- | --- | ------- | --- | --------- |
Weanalyze(1)theperformanceofourmethod’simpor-
| tant region | prediction, | (2) | our egocentric |     | features, | and (3) | toacamerawearer. |     |     |     |     |     |
| ----------- | ----------- | --- | -------------- | --- | --------- | ------- | ---------------- | --- | --- | --- | --- | --- |
Fig. 5(right)showsexamplesthatourmethodfoundto
theaccuracyandcompactnessofourstoryboardsummaries.
|         |                    |     |     |         |              |     | be important.                      | The top | and bottom | rows                   | show correct | and |
| ------- | ------------------ | --- | --- | ------- | ------------ | --- | ---------------------------------- | ------- | ---------- | ---------------------- | ------------ | --- |
| Dataset | and implementation |     |     | details | We collected | 10  |                                    |         |            |                        |              |     |
|         |                    |     |     |         |              |     | incorrectpredictions,respectively. |         |            | Typicalfailurecasesin- |              |     |
videosfromfoursubjects,each3-5hourslong.Eachperson
|             |            |        |     |     |             |        | clude under-segmenting |     | the important |     | object if | the fore- |
| ----------- | ---------- | ------ | --- | --- | ----------- | ------ | ---------------------- | --- | ------------- | --- | --------- | --------- |
| contributed | one video, | except | one | who | contributed | seven. |                        |     |               |     |           |           |
groundandbackgroundappearanceissimilar,anddetecting
| The videos | are challenging |     | due | to frequent | camera | view- |     |     |     |     |     |     |
| ---------- | --------------- | --- | --- | ----------- | ------ | ----- | --- | --- | --- | --- | --- | --- |
frequentlyoccurringbackgroundregionstobeimportant.
point/illuminationchangesandmotionblur.Forevaluation,
we use four data splits: for each split we train with data Which cues matter most for predicting importance?
fromthreeusersandtestononevideofromthe remaining Fig. 6showsthe top28outof105(= 14+ 14 ) features
2
|              |            |     |         |        |                |     | thatreceivethehighestlearnedweights. |     |     |     | Regionsizeisthe |     |
| ------------ | ---------- | --- | ------- | ------ | -------------- | --- | ------------------------------------ | --- | --- | --- | --------------- | --- |
| user. Hence, | the camera |     | wearers | in any | given training | set |                                      |     |     |     |                 |     |
|              |            |     |         |        |                |     |                                      |     |     |     | (cid:0) (cid:1) |     |
are disjoint from those in the test set, ensuring we do not highestweightedcue, whichis reasonablesince animpor-
learnuser-orobject-specificcues. tantperson/objectislikelytoappearroughlyatafixeddis-
We use Lab space color histograms, with 23 bins per tance from the camera wearer. Amongthe egocentricfea-
channel,andopticalflowhistogramswith61binsperdirec- tures,gazeandfrequencyhavethehighestweights. Frontal
tion. Wesett =27000,i.e.,a60minutetemporalwindow. faceoverlapisalsohighlyweighted;intuitively,animpor-
Wesetθ = 10000andθ = 0.7aftervisuallyexamining tantpersonwouldlikelybefacingandconversingwiththe
|                 | r   |     | p                 |     |              |     |               |     |     |     |     |     |
| --------------- | --- | --- | ----------------- | --- | ------------ | --- | ------------- | --- | --- | --- | --- | --- |
| a few examples. | We  | fix | all parametersfor |     | all results. | For | camerawearer. |     |     |     |     |     |
efficiency,weprocessevery15thframe(i.e.,1fps). Some highly weighted pair-wise interaction terms are

stcejbo tnatropmi fo % User 1 stcejbo tnatropmi fo % User 2 stcejbo tnatropmi fo % User 3 stcejbo tnatropmi fo % User 4
80 Important (Ours)   80 Important (Ours)   100 Important (Ours)   40 Important (Ours)
|     | Uniform sampling |     |                  |     | Uniform sampling |     |     |     |                  |     |     |
| --- | ---------------- | --- | ---------------- | --- | ---------------- | --- | --- | --- | ---------------- | --- | --- |
|     |                  |     | Uniform sampling |     |                  |     |     |     | Uniform sampling |     |     |
60 Event sampling 60 Event sampling 80 Event sampling 30 Event sampling
| 40  |     |     | 40  |     | 60  |     |     |     | 20  |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
20 5   10 15 20 25 30 20 10   15 20 25 30 40 10   20 30 40 10   6 8 10 12 14 16 18
# of frames in summary # of frames in summary # of frames in summary # of frames in summary
Figure7.Comparisontoalternativesummarizationstrategies,intermsofimportantobjectrecallrateasafunctionofsummarycompactness.
|       | Event 1  | Event 2  |     | Event 3  |     |     |     |     | Event 4  |     |     |
| ----- | -------- | -------- | --- | -------- | --- | --- | --- | --- | -------- | --- | --- |
|       |          |          |     |          |     |     |     |     |          |     |     |
|       |          |          |     |          |     |     |     |     |          |     |     |
| Ours  |          |          |     |          |     |     |     |     |          |     |     |

|     |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     |     |     |     |     |     |     |     |     |     |
Uniform
sampling
Figure8.Oursummary(top)vs.uniformsampling(bottom).Oursummaryfocusesontheimportantpeopleandobjects.
alsoquiteinteresting.Thefeaturemeasuringaregion’sface required length. To vary compactness, our method varies
overlapandy-positionhasmoreimpactonimportancethan both its selection criterion on I(r) over {0,0.1,...,0.5}
face overlap alone. This suggests that an important per- andthenumberofeventsbysettingθ ={0.2,0.5},for
event
son usually appears at a fixed height relative to the cam- 12 summariesin total. We create summaries for the base-
erawearer.Similarly,thefeatureforobject-likeappearance lineswiththesamenumberofframesasthose12.Ifaframe
and y-position has high weight, suggesting that a camera containsmultipleimportantobjects,wescoreonlythemain
weareroftenadjustshisego-frameofreferenceto viewan one. Likewise,ifasummarycontainsmultipleinstancesof
importantobjectataparticularheight. thesameGTobject,itgetscreditonlyonce. Notethatthis
Surprisingly, the pairing of the interaction (distance to measureisveryfavorabletothebaselines,sinceitdoesnot
hand) and frequency cues receives the lowest weight. A considerobjectprominenceintheframe. Forexample,we
|     |     |     |     |     | givecreditforthetvinthelastframeinFig. |     |     |     |     | 8,bottomrow, |     |
| --- | --- | --- | --- | --- | -------------------------------------- | --- | --- | --- | --- | ------------ | --- |
plausibleexplanationisthatthefrequencyofahandledob-
jecthighlydependsonthecamerawearer’sactivity.Forex- even though it is only partially captured. Furthermore, by
ample,wheneating,thecamerawearer’shandwillbevisi- definition,theuniformandevent-basedbaselinesarelikely
bleandthefoodwillappearfrequently. Ontheotherhand, togetmanyhitsforthemostfrequentobjects. Thesemake
whengroceryshopping,theimportantitems/hegrabsfrom thebaselinesverystrongandmeaningfulcomparisons.
|          |                     |     |                      |       | Overall, | our | summaries | include | more | important | peo- |
| -------- | ------------------- | --- | -------------------- | ----- | -------- | --- | --------- | ------- | ---- | --------- | ---- |
| theshelf | will (likely)beseen |     | for onlya shorttime. | These |          |     |           |         |      |           |      |
conflicting signals would lead to this pair-wise term hav- ple/objects with fewer frames. For example, for User 2,
ing low weight. Another paired term with low weight is our method finds 54% of important objects in 19 frames,
an “object-like” region that is frequent; this is likely due whereastheuniformkeyframemethodrequires27frames.
to unimportant background objects (e.g., the lamp behind Withveryshortsummaries,allmethodsperformsimilarly;
|     |     |     |     |     | the selected | keyframes |     | are more | spread-out, | so they | have |
| --- | --- | --- | --- | --- | ------------ | --------- | --- | -------- | ----------- | ------- | ---- |
thecamerawearer’scompanion).Thissuggeststhathigher-
ordertermscouldyieldevenmoreinformativefeatures. higher chance of including unique people/objects. With
|     |     |     |     |     | longer | summaries, | our | method | always | outperforms | the |
| --- | --- | --- | --- | --- | ------ | ---------- | --- | ------ | ------ | ----------- | --- |
Egocentric video summarization accuracy Next we baselines, since they tend to include redundantframes re-
evaluateourmethod’ssummarizationresults. We compare peatingthesame importantperson/object. Onaverage,we
againsttwobaselines: (1)uniformkeyframesampling,and find9.13events/videoand2.05people/objectsperevent.
(2) event-based adaptive keyframe sampling. The latter The two baselines perform fairly similarly to one an-
computes events using the same procedure as our method other,thoughtheevent-basedkeyframeselectorhasaslight
(Sec. 3.4), and then divides its keyframes evenly across edgebydoing“smarter”temporalsegmentation.Still,both
events. These are natural baselines modeled after classic are indifferentto objects’ importance in creating the story
keyframe and event detection methods [29, 30], and both of the video; their summaries contain unimportant or re-
selectkeyframesthatare“spread-out”acrossthevideo.
dundantframesasaresult.
Fig.7showstheresults. Weplot%ofimportantobjects Fig.8showsanexamplefullsummaryfromourmethod
foundasafunctionof#offramesinthesummary,inorder (top)andtheuniformbaseline(bottom).Thecoloredblocks
to analyze both the recall rate of the important objects as for ours indicate the automatically discovered events. We
well as the compactnessof the summaries. Each pointon seethatoursummarynotonlyhasbetterrecallofimportant
the curve shows the result for a different summary of the objects,butitalsoselectsviewsinwhichtheyareprominent

eredimportantregions,ourapproachproducessignificantly
|     |     |     |     |     |     |     | more informativesummaries |     |     | than | traditionalmethods |     | that |
| --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- | ---- | ------------------ | --- | ---- |
oftenincludeirrelevantorredundantinformation.
[1:53 pm]
|     |     |     |     |     | [1:23 pm]  |     | Acknowledgements |     | Many      | thanks     | to    | Yaewon, | Adriana, |
| --- | --- | --- | --- | --- | ---------- | --- | ---------------- | --- | --------- | ---------- | ----- | ------- | -------- |
|     |     |     |     |     |            |     | Nona, Lucy,      | and | Jared for | collecting | data. | This    | research |
wassponsoredinpartbyONRYIPandDARPACSSG.
References
|     |     |     |     |     |     |     | [1] O.Aghazadeh,J.Sullivan,andS.Carlsson. |     |     |     | NoveltyDetectionfrom |     |     |
| --- | --- | --- | --- | --- | --- | --- | ----------------------------------------- | --- | --- | --- | -------------------- | --- | --- |
[3:11 pm]  [6:55 pm]  [7:02 pm]  anEgocentricPerspective. InCVPR,2011.
|     |     |     |     |     |     |     | [2] A.AnerandJ.R.Kender. |     |     | VideoSummariesthroughMosaic-Based |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------ | --- | --- | --------------------------------- | --- | --- | --- |
Figure9.Anapplicationofourapproach.
|     |     |     |     |     |     |     | ShotandSceneClustering.          |     |     | InECCV,2002.                  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------------------------------- | --- | --- | ----------------------------- | --- | --- | --- |
|     |     |     |     |     |     |     | [3] J.CarreiraandC.Sminchisescu. |     |     | ConstrainedParametricMin-Cuts |     |     |     |
Muchbetter Better Similar Worse Muchworse forAutomaticObjectSegmentation. InCVPR,2010.
Imp.captured 31.25% 37.5% 18.75% 12.5% 0% [4] Y.Caspi,A.Axelrod,Y.Matsushita,andA.Gamliel.DynamicStills
Overallquality 25% 43.75% 18.75% 12.5% 0% andClipTrailer. InTheVisualComputer,2006.
Table 1. User study results. Numbers indicate percentage of re- [5] B.ClarksonandA.Pentland. UnsupervisedClusteringofAmbula-
sponses for each question, always comparing our method to the toryAudioandVideo. InICASSP,1999.
|     |     |     |     |     |     |     | [6] I.EndresandD.Hoiem.CategoryIndependentObjectProposals.In |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------------------------------------ | --- | --- | --- | --- | --- | --- |
baseline(i.e.,highestvaluesin“muchbetter”areideal).
ECCV,2010.
|     |     |     |     |     |     |     | [7] A.Fathi,A.Farhadi,andJ.Rehg.UnderstandingEgocentricActivi- |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
ties. InICCV,2011.
| in the frame. | In  | this example, | our | summary | more | clearly |                                               |     |     |     |     |                 |     |
| ------------- | --- | ------------- | --- | ------- | ---- | ------- | --------------------------------------------- | --- | --- | --- | --- | --------------- | --- |
|               |     |               |     |         |      |         | [8] D.Goldman,B.Curless,D.Salesin,andS.Seitz. |     |     |     |     | SchematicStory- |     |
reveals the story: selecting an item at the supermarket → boardingforVideoVisualizationandEditing. InSIGGRAPH,2006.
drivinghome→cooking→eatingandwatchingtv. [9] S.Hodges, E.Berry,andK.Wood. Sensecam: AWearableCam-
Fig. 9 shows another example; we track the camera erawhichStimulates andRehabilitates Autobiographical Memory.
Memory,2011.
wearer’s location with a GPS receiver, and display our [10] T.Huynh,M.Fritz,andB.Schiele. DiscoveryofActivityPatterns
method’skeyframesonamapwiththetracks(purpletrajec- usingTopicModels. InUBICOMP,2008.
|     |     |     |     |     |     |     | [11] S.J.HwangandK.Grauman. |     |     | AccountingfortheRelativeImpor- |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | ------------------------------ | --- | --- | --- |
tory)andtimeline.Thisresultsuggestsanovelmulti-media
|     |     |     |     |     |     |     | tanceofObjectsinImageRetrieval. |     |     |     | InBMVC,2010. |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------- | --- | --- | --- | ------------ | --- | --- |
applicationofourvisualsummarizationalgorithm. [12] L.Itti,C.Koch,andE.Niebur.AModelofSaliency-basedVisualAt-
|     |     |     |     |     |     |     | tentionforRapidSceneAnalysis. |     |     | TPAMI,20(11),November1998. |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ----------------------------- | --- | --- | -------------------------- | --- | --- | --- |
Userstudiestoevaluatesummaries Toquantifytheper- [13] N.Jojic,A.Perina,andV.Murino. StructuralEpitome: AWayto
ceived qualityofoursummaries, we ask thecamerawear- SummarizeOne’sVisualExperience. InNIPS,2010.
|     |     |     |     |     |     |     | [14] M.JonesandJ.Rehg. |     | StatisticalColorModelswithApplicationto |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ---------------------- | --- | --------------------------------------- | --- | --- | --- | --- |
erstocompareourmethod’ssummariestothosegenerated SkinDetection. IJCV,46(1),2002.
byuniformkeyframesampling(event-basedsamplingper- [15] K.Kitani,T.Okabe,Y.Sato,andA.Sugimoto. FastUnsupervised
formssimilarly). The camera wearers are the best judges, Ego-ActionLearningforFirst-PersonSportsVideo.InCVPR,2011.
|                   |     |                   |     |           |     |         | [16] Y.J.Lee,J.Kim,andK.Grauman. |              |     |     | Key-SegmentsforVideoObject |     |     |
| ----------------- | --- | ----------------- | --- | --------- | --- | ------- | -------------------------------- | ------------ | --- | --- | -------------------------- | --- | --- |
| since theyknowthe |     | fullextentoftheir |     | daythatwe |     | are at- |                                  |              |     |     |                            |     |     |
|                   |     |                   |     |           |     |         | Segmentation.                    | InICCV,2011. |     |     |                            |     |     |
temptingtosummarize. [17] D.Liu,G.Hua,andT.Chen.AHierarchicalVisualModelforVideo
|             |     |              |               |             |              |     | ObjectSummarization.                       |     | InTPAMI,2009. |     |     |                  |     |
| ----------- | --- | ------------ | ------------- | ----------- | ------------ | --- | ------------------------------------------ | --- | ------------- | --- | --- | ---------------- | --- |
| We generate |     | four pairs   | of summaries, | each        | of different |     |                                            |     |               |     |     |                  |     |
|             |     |              |               |             |              |     | [18] T.Liu,J.Sun,N.Zheng,X.Tang,andH.Shum. |     |               |     |     | LearningtoDetect |     |
| length. We  | ask | the subjects | to view       | our summary | and          | the |                                            |     |               |     |     |                  |     |
|             |     |              |               |             |              |     | aSalientObject.                            |     | InCVPR,2007.  |     |     |                  |     |
baseline’s (in some randomorder unknownto the subject, [19] D. Lowe. Distinctive Image Features from Scale-Invariant Key-
|                                                 |     |          |               |                |     |     | points.                    | IJCV,60(2),2004. |     |                                   |     |     |     |
| ----------------------------------------------- | --- | -------- | ------------- | -------------- | --- | --- | -------------------------- | ---------------- | --- | --------------------------------- | --- | --- | --- |
| anddifferentforeachpair),andanswertwoquestions: |     |          |               |                |     | (1) |                            |                  |     |                                   |     |     |     |
|                                                 |     |          |               |                |     |     | [20] P.PeronaandW.Freeman. |                  |     | AFactorizationApproachtoGrouping. |     |     |     |
| Which summary                                   |     | captures | the important | people/objects |     | of  |                            |                  |     |                                   |     |     |     |
InECCV,1998.
| your day | better? | and (2) | Which | provides | a better | over- |                                                              |     |     |     |     |     |     |
| -------- | ------- | ------- | ----- | -------- | -------- | ----- | ------------------------------------------------------------ | --- | --- | --- | --- | --- | --- |
|          |         |         |       |          |          |       | [21] Y.Pritch,A.Rav-Acha,A.Gutman,andS.Peleg.WebcamSynopsis: |     |     |     |     |     |     |
allsummary? Thefirstspecificallyisolateshowwelleach PeekingAroundtheWorld.InICCV,2007.
|     |     |     |     |     |     |     | [22] A.Rav-Acha,Y.Pritch,andS.Peleg. |     |     |     | MakingaLongVideoShort. |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------------ | --- | --- | --- | ---------------------- | --- | --- |
methodfindsimportant,prominentobjects,andthesecond
InCVPR,2006.
addressestheoverallqualityandstoryofthesummary. [23] X.RenandC.Gu. Figure-GroundSegmentationImprovesHandled
Table1showstheresults. Inshort,outof16totalcom- ObjectRecognitioninEgocentricVideo.InCVPR,2010.
|     |     |     |     |     |     |     | [24] D.Simakov, | Y.Caspi, | E.Shechtman, |     | andM.Irani. | Summarizing |     |
| --- | --- | --- | --- | --- | --- | --- | --------------- | -------- | ------------ | --- | ----------- | ----------- | --- |
parisons,oursummarieswerefoundtobebetter68.75%of VisualDatausingBidirectionalSimilarity. InCVPR,2008.
the time. Overall, these results are a promising indication [25] M.SpainandP.Perona. SomeObjectsareMoreEqualthanOthers:
that discovering important people/objects leads to higher MeasuringandPredictingImportance. InECCV,2008.
|     |     |     |     |     |     |     | [26] Tan,Steinbach,andKumar.IntroductiontoDataMining. |     |     |     |     |     | 2005. |
| --- | --- | --- | --- | --- | --- | --- | ----------------------------------------------------- | --- | --- | --- | --- | --- | ----- |
qualitysummariesforegocentricvideo. [27] P.ViolaandM.Jones.RapidObjectDetectionusingaBoostedCas-
|     |     |     |     |     |     |     | cadeofSimpleFeatures. |     |     | InCVPR,2001. |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --------------------- | --- | --- | ------------ | --- | --- | --- |
5. Conclusion [28] D. Walther and C. Koch. Modeling Attention to Salient Proto-
|              |            |             |            |           |            |         | Objects.                                                     | NeuralNetworks,19:1395–1407,2006. |       |           |     |                  |           |
| ------------ | ---------- | ----------- | ---------- | --------- | ---------- | ------- | ------------------------------------------------------------ | --------------------------------- | ----- | --------- | --- | ---------------- | --------- |
|              |            |             |            |           |            |         | [29] W.Wolf.KeyframeSelectionbyMotionAnalysis.InICASSP,1996. |                                   |       |           |     |                  |           |
| We developed |            | an approach | to         | summarize | egocentric |         |                                                              |                                   |       |           |     |                  |           |
|              |            |             |            |           |            |         | [30] H.J.Zhang,J.Wu,D.Zhong,andS.Smoliar.                    |                                   |       |           |     | AnIntegratedSys- |           |
| video. We    | introduced | novel       | egocentric | features  | to         | train a |                                                              |                                   |       |           |     |                  |           |
|              |            |             |            |           |            |         | tem for                                                      | Content-Based                     | Video | Retrieval | and | Browsing.        | InPattern |
regressorthatpredictsimportantregions.Usingthediscov- Recognition,1997.
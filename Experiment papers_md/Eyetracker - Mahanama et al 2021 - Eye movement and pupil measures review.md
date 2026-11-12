REVIEW
published:11January2022
doi:10.3389/fcomp.2021.733531
Eye Movement and Pupil Measures: A
Review
Bhanuka Mahanama1, YasithJayawardana1, SundararamanRengarajan2,
GavindyaJayawardena1,LeanneChukoskie2,3,JosephSnider4andSampathJayarathna1*
1ComputerScience,OldDominionUniversity,Norfolk,VA,UnitedStates,2PhysicalTherapy,Movement&Rehabilitation
Sciences,NortheasternUniversity,Boston,MA,UnitedStates,3Art+Design,NortheasternUniversity,Boston,MA,
UnitedStates,4InstituteforNeuralComputation,UCSanDiego,SanDiego,CA,UnitedStates
Our subjective visual experiences involve complex interaction between our eyes, our
brain, and the surrounding world. It gives us the sense of sight, color, stereopsis,
distance,patternrecognition,motorcoordination,andmore.Theincreasingubiquityof
gaze-aware technology brings with it the ability to track gaze and pupil measures with
varying degrees of fidelity. With this in mind, a review that considers the various gaze
measures becomes increasingly relevant, especially considering our ability to make
senseofthesesignalsgivendifferentspatio-temporalsamplingcapacities.Inthispaper,
we selectively review prior work on eye movements and pupil measures. We first
describe the main oculomotor events studied in the literature, and their
characteristics exploited by different measures. Next, we review various eye
movement and pupil measures from prior literature. Finally, we discuss our
Editedby:
observations based on applications of these measures, the benefits and practical
KostasKarpouzis,
PanteionUniversity,Greece challenges involving these measures, and our recommendations on future eye-
Reviewedby: tracking research directions.
IliasMaglogiannis,
UniversityofPiraeus,Greece Keywords:eyetracking,pupillometry,visualperception,cognition,attention
MichaelJProulx,
UniversityofBath,UnitedKingdom
1 INTRODUCTION
*Correspondence:
SampathJayarathna
Thefiveprimarysensesprovidehumanswitharichperceptualexperienceoftheworld,withvision
sampath@cs.odu.edu
asthedominantsense.Earlystudiesofvisualperception(Dodge,1900;Buswell,1935;Yarbus,1967)
and its physiological underpinnings (Hubel and Wiesel, 1979; Hubel, 1995), have provided a
Specialtysection:
foundation for subtler and more sophisticated studies of the visual system and its dynamic
Thisarticlewassubmittedto
Human-MediaInteraction, interaction with the environment via the oculomotor system. The oculomotor system both
asectionofthejournal maintains visual stability and controls gaze-orienting movements (Goldberg et al., 1991; Land
FrontiersinComputerScience andFurneaux,1997).Itiscomprisedoftheefferentlimbofthevisualsystemandthevestibularsystem
Received:30June2021 (WadeandJones,1997).Theefferentlimbisresponsibleformaintainingeyepositionandexecuting
Accepted:23November2021 eyemovements.Thevestibularsystem,ontheotherhand,isresponsibleforprovidingourbrainwith
Published:11January2022
informationaboutmotion,headposition,andspatialorientation,which,inturn,facilitatesmotor
Citation: functions,suchasbalance,stabilityduringmovement,andposture(GoldbergandFernandez,1984;
MahanamaB,JayawardanaY, Wade and Jones, 1997; Day and Fitzpatrick, 2005). The sense of hearing or touch also affects eye
RengarajanS,JayawardenaG, movements (Eberhard et al., 1995; Maier and Groh, 2009). There are five distinct types of eye
ChukoskieL,SniderJand
movement, two gaze-stabilizing movements: vestibulo-ocular (VOR), opto-kinetic nystagmus
JayarathnaS(2022)EyeMovement
(OKN); and three gaze-orienting movements: saccadic, smooth pursuit, and vergence
andPupilMeasures:AReview.
(Duchowski, 2017; Hejtmancik et al., 2017). For the purposes of this review, we will focus on
Front.Comput.Sci.3:733531.
doi:10.3389/fcomp.2021.733531 gaze-orienting eye movements that place the high-resolution fovea on selected objects of interest.
FrontiersinComputerScience|www.frontiersin.org 1 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
FIGURE1|Summaryofoculomotorevents(left),analysismethods(center),andmeasures(right).
Theexistenceofthefovea,aspecializedhigh-acuityregionof discussion on applications, recent developments, limitations,
the central retina approximately 1–2mm in diameter (Dodge, and practical challenges involving these measures, and our
1903),providesexceptionallydetailedinputinasmallregionof recommendations on future eye-tracking research directions.
thevisualfield(Koster,1895),approximatelythesizeofaquarter
heldatarm’slength(Pumphrey,1948;Hejtmanciketal.,2017).
The role of gaze-orienting movements are to direct the fovea 2 OCULOMOTOR EVENTS
toward objects of interest. Our subjective perception of a stable
worldwithuniformclarityisamarvelresultingfromourvisual This section describes oculomotor events that function as the
andoculomotorsystemsworkingtogetherseamlessly,allowingus basisforseveraleyemovementandpupilmeasures.Theseevents
to engage with a complex and dynamic environment. are:1)fixationsandsaccades,2)smoothpursuit,3)fixationaleye
Recentadvancementsincomputingsuchascomputervision movements (tremors, microsaccades, drifts), 4) blinks, and 5)
(Krafkaetal.,2016;Leeetal.,2020)andimageprocessing(Pan ocular vergence.
etal.,2017;Mahanamaetal.,2020;Ansarietal.,2021)haveledto
the development of computing hardware and software that can 2.1 Fixations and Saccadic Eye Movements
extracttheseoculomotoreventsandmeasurableproperties.This Eye movement information can be interpreted as a sequence of
include eye tracking devices range from commodity hardware fixationsandsaccades.Afixationisaperiodwhereourvisualgaze
(Mania et al., 2021) capable of extracting few measures to remainsataparticularlocation.Asaccade,ontheotherhand,isa
reserach-grade eye trackers combined with sophisticated rapideyemovementbetweentwoconsecutivefixations.Typical
software capable of extracting various advance measures. As a humans perform 3–5 saccades per second, but this rate varies
result, eye movement and pupillometry have the potential for with current perceptual and cognitive demands (Fischer and
wide adoption for both in applications and research. There is a Weber, 1993). Fixations and saccades are the primary means
needforanaggregatebodyofknowledgeoneyemovementand of interacting with and perceiving the visual world. During a
pupillometry measures to provide, a.) a taxonomy of measures fixation, our visual perceptual processes unfold. Saccades guide
linkingvariousoculomotorevents,andb.)aquickreferenceguide ourfoveatoselectedregionsofthevisualfield.Weareeffectively
for eye tracking and pupillometry measures. For application blindduringsaccades(Burretal.,1994),whichallowsourgazeto
oriented literature of the eye tracking, interested reader is remain relatively stable during saccadic reorientation. Saccadic
referred to (Duchowski, 2002) for a breadth-first survey of eye eyemovementsarebrief,andhaveareliableamplitude-velocity
tracking applications. relationship(seeFigure2)knownasthemainsequence (Bahill
Inthispaper,wereviewaselectionofrelevantpriorresearch et al., 1975; Termsarasab et al., 2015). It shows that saccade
ongaze-orientingeyemovements,theperiodsofvisualstability velocityandsaccadeamplitudefollowalinearrelationship,upto
between these movements, and pupil measures to address the 15°–20°. This relationship, however, varies with age and also in
aforementionedissue(seeFigure1).First,wedescribethemain certain disorders (Choi et al., 2014; Reppert et al., 2015).
oculomotor events and their measurable properties, and Saccades are inhibited during engaged visual attention on
introduce common eye movement analysis methods. Next, we stationary stimuli, and as a result, a (nearly) steady central
review various eye movement and pupil measures. Next, we fixation is obtained (Fischer and Breitmeyer, 1987). Previous
discuss the applications of aforementioned measures in studies(Schilleretal.,1980;Wangetal.,2015)haveshownthat
domains including, but not limited to, neuroscience, human- saccadepreparationprocessescanbeanalyzedviapupilsize.In
computer interaction, and psychology, and analyze their particular, Schiller et al. (1980) showed that distinct neural
strengths and weaknesses. The paper concludes with a preparatory signals in Superior Colliculus (SC) and Frontal
FrontiersinComputerScience|www.frontiersin.org 2 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
FIGURE2|Saccadeamplitudeandpeakvelocity(A),mainsequence(B)(Reppertetal.,2015).
EyeField(FEF)arevitalforsaccadepreparation,andWangetal. or below the threshold, points are classified as fixations or
(2015) showed that the SC is associated with the pupil control saccades (Widdel, 1984). In I-MST, a minimum-spanning tree
circuit. Cortical processing is associated with saccade latency, isconstructedfromgazepoints.Edgeswithlengthsexceedinga
with shorter latency indicating advanced motor preparation predefined ratio are labeled as saccades and clusters of points
(Connolly et al., 2005). Reiterating this point, Jainta et al. connected by saccades are labeled as fixations (Salvucci and
(2011) showed a negative correlation between saccade latency Goldberg, 2000). I-AOI is an area-based algorithm that only
andpupilsizepriortoasaccade.Thus,theanalysisofmeasures identifiesfixationswithinspecifiedtargetareas(AOIs)(Salvucci
suchaspupildiameterduringfixations,fixationduration,saccade and Goldberg, 2000). If a point falls within a target area, it is
rate, saccade accuracy, and saccade latency, provide important labeled as a fixation point, and if not, it is labeled as a saccade
cumulativecluestounderstandingtheunderlyingdeploymentof point.Consecutivefixationpointsarethengroupedtogether,and
visual attention. groups that do not span a minimum duration are re-labeled as
saccade points. A systematic evaluation of the performance of
2.1.1 Identifying Fixations and Saccades these algorithms are available at Komogortsev et al. (2010).
Thereexistsseveraleyetrackingtechnologies(YoungandSheena,
1975)thatmeasureocularfeaturesovertimeandtransformthem 2.2 Smooth Pursuit Eye Movements
intoastreamofgazepositions.Thesestreamscanbeanalyzedin The smooth pursuit system is a different gaze-orienting
different ways to identify periods of fixation and saccades. movement that is deployed to keep a moving object in foveal
Salvucci and Goldberg (2000) describe five algorithms for such vision (Carl and Gellman, 1987; Barnes, 2008). Smooth pursuit
identification:VelocityThreshold Identification (I-VT),Hidden eye movements are generally made when tracking an object
Markov Model Identification (I- HMM), Dispersion Threshold moving in the visual environment (Carl and Gellman, 1987;
Identification (I-DT), Minimum Spanning Tree Identification Barnes and Asselman, 1991). A typical smooth pursuit
(I-MST), and Area-of-Interest Identification (I-AOI). I-VT and movement is usually initiated by an saccadic eye movement to
I-HMM are velocity-based algorithms. In I-VT, consecutive orient to the tracked object. The pursuit system subsequently
points are identified as fixations or saccades, based on their matches the eye velocity to target velocity (Robinson, 1965;
point-to-point velocities (Findlay et al., 1995). I-HMM, on the Barnes and Asselman, 1991). This smooth movement is
otherhand,usesatwo-stateHiddenMarkovModelwithhidden punctuated by additional saccadic movements that eliminate
states representing the velocity distributions of saccade and retinal error between the current gaze position and target. The
fixation points. Compared to fixed-threshold methods like smoothpursuitsystemhasafunctionalarchitectureverysimilar
I-VT, I-HMM performs a more robust identification (Salvucci to that of the saccadic system (Lisberger et al., 1987); however,
andGoldberg,2000),sinceitemploysaprobabilisticmodelrather smoothpursuithasalowerlatency(100–125ms)thansaccades
than a fixed velocity threshold, which allows more freedom in (200–250ms) (Meyer et al., 1985; Krauzlis, 2004). Due to the
identifying points. I-DT and I-MST are dispersion-based underlying similarity between saccades and smooth pursuits,
algorithms that use a moving window to calculate the metrics used to characterize saccades could also be used to
dispersion of points. Based on whether the dispersion is above characterize smooth pursuit behavior (Lisberger et al., 1987).
FrontiersinComputerScience|www.frontiersin.org 3 January2022|Volume3|Article733531

| Mahanamaetal. |     |     |     |     |     |     |     |     | EyeMovementandPupilMeasures |     |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- |
AccordingtoaclassicsmoothpursuitbehaviormodelRobinson Itisincreasinglyacceptedthatmicrosaccadesplayanimportant
et al. (1986), there are three aspects of pursuit to characterize: role in modulating attentional and perceptual processes (Hafed
| onset, offset | and | motor | learning. | Pursuit | onset is | the response | et al., 2015). |     |     |     |     |     |
| ------------- | --- | ----- | --------- | ------- | -------- | ------------ | -------------- | --- | --- | --- | --- | --- |
timeofthepursuitsystemtoatargetwhichmovesforacertain
2.3.3 Drift
periodoftime.Sinceitoccursafterthetargetstartstomove,this
timedelayreflectstheresponseofthepursuitsystemtothetarget
|     |     |     |     |     |     |     | A drift (or | slow drift) is | a low-frequency | eye | movement | that |
| --- | --- | --- | --- | --- | --- | --- | ----------- | -------------- | --------------- | --- | -------- | ---- |
motionwhiletheeyeswerestill(Jiang,1996).Pursuitoffsetisthe occursduringtheintervalsbetweenmicrosaccadesandsaccades
responsetimeofthepursuitsystemtoturnoffasaresponsewhen (Steinman et al., 1973). During a drift, the retinal image of a
fixated
targetstopsitsmotion.Whenthetargetisseentostop,thepursuit object moves across photoreceptors (Ratliff and Riggs,
fixation
system is turned off and replaced by (Robinson et al., 1950). Drifts have a compensatory role in maintaining accurate
1986). Motor plasticity or motor learning, as a gradual process visualfixation;theyoccureitherintheabsenceofmicrosaccades,
thatmakessmall,adaptivestepsinaconsistentdirection,wasalso or when the compensation by microsaccades is inadequate
incorporated and simulated in this model. (Ratliff and Riggs, 1950). The average size of a drift is about a
|     |     |     |     |     |     |     | 6′arc, withanaveragevelocity |     | ofabouta | 1′arc/sec | (Ratliffand |     |
| --- | --- | --- | --- | --- | --- | --- | ---------------------------- | --- | -------- | --------- | ----------- | --- |
2.3 Fixational Eye Movements Riggs, 1950; Ditchburn and Ginsborg, 1953; Cornsweet, 1956;
| Theprocessofvisualexplorationischaracterizedbyalternating |     |     |     |     |     |     | Nachmias, | 1961). |     |     |     |     |
| --------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --------- | ------ | --- | --- | --- | --- |
fixationsandsaccades(SalvucciandGoldberg,2000).However,a
| fixationdoesnotimplyastationaryeye;oureyesarecontinually |     |     |     |     |     |     | 2.4 Blinks |     |     |     |     |     |
| -------------------------------------------------------- | --- | --- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | --- |
fixation
in (involuntary) motion, even during periods of (Adler A blink is essentially the closing and reopening of the eyelids.
and Fliegelman, 1934; Ratliff and Riggs, 1950; Ditchburn and Blinks are primitive, yet widely used, in eye tracking measures.
Ginsborg,1953).Thesefixationaleyemovementsfallintooneof When the blink originates from a voluntary action, the blink
three classes: 1) tremors, 2) micro-saccades, and 3) drifts becomesavoluntaryblinkorawink(Blount,1927).Inthecaseof
(Martinez-Conde et al., 2004; Rucci and Poletti, 2015). non-voluntaryblinks,theyareoftwotypes:spontaneousblinks
|     |     |     |     |     |     |     | and reflexive | blinks. For reflexive | blinks, | external | stimuli | evoke |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --------------------- | ------- | -------- | ------- | ----- |
2.3.1 Tremor reflexive blinks as a form of protection, while any involuntary
Atremor(orocularmicro-tremor,orphysiologicalnystagmus)is blink not belonging to any of these categories is a spontaneous
an aperiodic, wavelike eye movement with a high-frequency blink (Valls-Sole, 2019). The winks or voluntary blinks are not
(∼90 Hz) (Carpenter, 1988) and low-amplitude ( ∼ the commonly adopted as a metric despite the usage as a form of
diameter of a foveal cone) (Riggs et al., 1953). Due to this interaction(Noronhaetal.,2017).Incontrast,involuntaryblinks
indicatethestateofanindividual(Sternetal.,1984)orareflex
| nature, tremors |     | fall within | the | range | of recording | noise, |     |     |     |     |     |     |
| --------------- | --- | ----------- | --- | ----- | ------------ | ------ | --- | --- | --- | --- | --- | --- |
making it challenging to record them accurately (Carpenter, action to a stimulus (Valls-Sole, 2019). Between involuntary
1988). Tremors allow the retaining of visual acuity during blinks, spontaneous blinks are the most common type of blink
fixations usedasametricduetotheircorrelationwithone’sinternalstate
| prolonged |     | (Riggs | and Ratliff, | 1951; | Riggs | et al., 1953). |     |     |     |     |     |     |
| --------- | --- | ------ | ------------ | ----- | ----- | -------------- | --- | --- | --- | --- | --- | --- |
For instance, Riggs et al. (1953) showed that when tremors are (Shin et al., 2015; Maffei and Angrilli, 2019).
| bypassed | artificially, | the | visual acuity | diminishes |     | over time. |            |          |     |     |     |     |
| -------- | ------------- | --- | ------------- | ---------- | --- | ---------- | ---------- | -------- | --- | --- | --- | --- |
|          |               |     |               |            |     |            | 2.5 Ocular | Vergence |     |     |     |     |
2.3.2 Microsaccade Upuntilthispoint,themovementsdescribedareallreferredtoas
A microsaccade (or flick, or flicker, or fixational saccade) is a conjugate or “yoked” eye movements, meaning that the eyes
small,fast,jerk–likeeyemovementthatoccursduringvoluntary moveinthesamedirectiontofixateanobject.Fortunately,wecan
fixation(Ditchburnand choosetofixateonobjectsindifferentdepthplanes,duringwhich
|     |     |     | Ginsborg,1953;Martinez-Conde |     |     | etal., |     |     |     |     |     |     |
| --- | --- | --- | ---------------------------- | --- | --- | ------ | --- | --- | --- | --- | --- | --- |
2004).Theyoccuratatypicalrateof1–3Hz,shiftingthelineof binocularvisionismaintainedbyoppositemovementsofthetwo
sight abruptly by a small amount (Ditchburn and Ginsborg, eyes. These simultaneously directly opposing movements of the
6′
1953). The average size of a microsaccade is about arc eyes result in Ocular vergence (Holmqvist et al., 2011). These
(i.e., the size of a thumb-tack head, held 2.5m away from the vergence movements can occur in either direction, resulting in
eye)(Steinmanetal.,1973).Thedynamicsofmicrosaccadesvary convergence or divergence. Far-to-near focus triggers convergent
withstimuliandviewingtask.Forinstance,thedifficultyofatask movements and near-to-far focus triggers divergent movements.
canbediscernedbythenumberofmicrosaccadesthatoccurred The ubiquitous use of screen-based eye tracking results in more
(Otero-Millan et al., 2008), and their magnitude (Krejtz et al., literaturerelatedtoconjugateeyemovementsinasingledepthplane.
| 2018). Microsaccades |             | also   | have | comparable | spatio-temporal |         |     |     |     |     |     |     |
| -------------------- | ----------- | ------ | ---- | ---------- | --------------- | ------- | --- | --- | --- | --- | --- | --- |
| properties           | as saccades | (Zuber | et   | al., 1965; | Otero-Millan    | et al., |     |     |     |     |     |     |
2008). For instance, microsaccades lie on the saccadic main 3 EYE MOVEMENT ANALYSIS
| sequence | (Zuber            | et al., | 1965). The | refractory      | periods | between       |               |              |            |           |            |     |
| -------- | ----------------- | ------- | ---------- | --------------- | ------- | ------------- | ------------- | ------------ | ---------- | --------- | ---------- | --- |
|          |                   |         |            |                 |         |               | Eye movements | are a result | of complex | cognitive | processes, |     |
| saccades | and microsaccades |         | are        | also equivalent |         | (Otero-Millan |               |              |            |           |            |     |
9′
et al., 2008). Moreover, microsaccades as small as generate a involving at the very least, target selection, movement
fieldpotentialovertheoccipitalcortexandthemid-centralscalp planning, and execution. Analysis of eye movements (see
sites 100–140ms after movement onset, which resembles the Table 1 for a list of eye movement measures) can reveal
quantifiable
visuallambdaresponseevokedbysaccades(Dimigenetal.,2009). objective and information about the quality,
FrontiersinComputerScience|www.frontiersin.org 4 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
TABLE1|Summaryofrelatedworkoneyemovementandpupilmeasures.
Fixation Relatedwork
Count Buswell(1935),Yarbus(1967),Schoonahdetal.(1973),BruttenandJanssen(1979),MegawandRichardson(1979),
Megaw(1979),GoldbergandKotval(1999),Coeckelberghetal.(2002),JacobandKarn(2003),Aresetal.(2013)
Duration YoungandSheena(1975),Rayner(1978),Rayner(1979),SalthouseandEllis(1980),KarshandBreitenbach(1983),
GoldbergandKotval(1999),Velichkovskyetal.(2000),PavlovićandJensen(2009),StaubandBenatar(2013),Aresetal.
(2013),Reingoldetal.(2012),Menonetal.(2016),Costaetal.(2018),Hendersonetal.(2018),Velichkovskyetal.(2019)
SACCADE RelatedWork
Amplitude Bahilletal.(1975),Ceder(1977),Rayner(1978),MegawandRichardson(1979),Mayetal.(1990),ZelinskyandSheinberg
(1997),PhillipsandEdelman(2008),Rayneretal.(2012),Ansonetal.(2016),Buonocoreetal.(2016),Buonocoreetal.
(2017),LeMeuretal.(2017),Mostofietal.(2020)
Direction TakedaandFunahashi(2002),Killianetal.(2015),Walkeretal.(2006),Foulshametal.(2008),Ponsodaetal.(1995),
GbadamosiandZangemeister(2001),Yuetal.(2016),Mulderetal.(2020),Andersonetal.(2020)
Velocity BeckerandFuchs(1969),Lehtinenetal.(1979),Griffithsetal.(1984),AbelandHertle(1988),Galley(1993),McGregorand
Stern(1996),Castelloetal.(1998),Russoetal.(2003),Xu-Wilsonetal.(2009),Boxeretal.(2012),Buonocoreetal.
(2016),Buonocoreetal.(2017),Mostofietal.(2020)
Latency McKeeetal.(2016),Warrenetal.(2013),Michelletal.(2006),McSorleyetal.(2012),KnoxandWolohan(2014),Ansonetal.
(2016),Laietal.(2019)
Rate Ohtani(1971),VanOrdenetal.(2000),Nakayamaetal.(2002),O’DriscollandCallahan(2008),vanTrichtetal.(2010)
Gain CoëfféandO’regan(1987),Ettingeretal.(2002),Crevitsetal.(2003),Lisietal.(2019)
SMOOTHPURSUIT RelatedWork
Direction CollewijnandTamminga(1984),Rottachetal.(1996)
Velocity Barmack(1970),Young(1971),BahillandLaritz.(1984),Meyeretal.(1985),DeBrouweretal.(2002)
Acceleration KaoandMorrow(1994),Laddaetal.(2007)
Latency Braunetal.(2006),BurkeandBarnes(2006),deHemptinneetal.(2006),SperingandGegenfurtner(2007)
RetinalPositionError deBrouweretal.(2001)
Gain Robinson(1965),ZackonandSharpe(1987),Rottachetal.(1996),ChurchlandandLisberger(2002),O’Driscolland
Callahan(2008)
BLINK RelatedWork
Rate Newhall(1932),Doughty(2001),Doughty(2002),DoughtyandNaase(2006),Ohetal.(2012),Shinetal.(2015),Jongkees
andColzato(2016),Doughty(2019),MaffeiandAngrilli(2019),Rantietal.(2020)
Amplitude Stevensonetal.(1986),Riggsetal.(1987),MorrisandMiller(1996),Galleyetal.(2004),Cardonaetal.(2011),Chuetal.
(2014)
VISUALSEARCH RelatedWork
ScanPathSimilarity Jarodzkaetal.(2010),DeBruinetal.(2013)
Time-to-First-FixationonAOI Krupinski(1996),Ellisetal.(1998),JacobandKarn(2003),Bojko(2006),Venjakobetal.(2012),DonovanandLitchfield
(2013)
DwellTime TullisandAlbert(2013),MohantyandSussman(2013),HüsserandWirth(2014),Ceravoloetal.(2019)
RevisitCount Guoetal.(2016),Meghanathanetal.(2019),Mello-Thomsetal.(2005),Motokietal.(2021)
GazeTransitionMatrix Ponsodaetal.(1995),Bednariketal.(2005)
TransitionMatrixDensity GoldbergandKotval(1999)
GazeTransitionProbability Vandebergetal.(2013),Jayawardenaetal.(2020)
GazeTransitionEntropy Krejtzetal.(2014),Krejtzetal.(2015),Shiferawetal.(2019)
VERGENCE RelatedWork
OcularVergence Daughertyetal.(2010),Essigetal.(2004),Wangetal.(2012),Mlotetal.(2016)
PUPIL RelatedWork
Diameter Grayetal.(1993),Joshietal.(2016),Rubaltellietal.(2016)
ICA Marshall(2000),Marshall(2002),Marshall(2007),AbelandHertle(1988),BartelsandMarshall(2012),Demberg(2013),
Dembergetal.(2013),Korbachetal.(2017),Korbachetal.(2018),Rerhayeetal.(2018)
IPA Duchowskietal.(2018),Krejtzetal.(2020),Fehringer(2020),Fehringer(2021)
LHIPA Duchowskietal.(2020),Krejtzetal.(2020)
predictability,andconsistencyofthesecovertprocesses(Vander movement measurement techniques, and key considerations
Stigchel et al., 2007). Holmqvist et al. (2011) and Young and for eye movement research. In this section, we introduce
Sheena (1975) discuss several eye movement measures, eye several eye movement analysis techniques from the literature.
FrontiersinComputerScience|www.frontiersin.org 5 January2022|Volume3|Article733531

| Mahanamaetal. |     |     |     |     |     |     |     |     |     |     |     | EyeMovementandPupilMeasures |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- |
3.1 Area of Interest Analysis biometric identification (Holland and Komogortsev, 2011). In
AOI analysis is a technique to analyze eye movements by cognitiveneuroscience,Parkhurstetal.(2002)andvanZoestetal.
specific
assigning them to areas (or regions) of the visual (2004) show that stimulus-driven, bottom-up attention
scene (Holmqvist et al., 2011; Hessels et al., 2016). In contrast dominates during the early phases of viewing. On the
toobtainingeyemovementmeasuresacrosstheentirescene,AOI contrary, Nyström and Holmqvist (2008) show that top-down
cognitiveprocessesguidefixationselectionthroughoutthecourse
analysisprovidessemanticallylocalizedeyemovementmeasures
thatareparticularlyusefulforattention-basedresearch(e.g.,User of viewing. They discovered that viewers eventually fixate on
Interaction research, Marketing research, and Psychology meaningful stimuli, regardless of whether that stimuli was
defining
research) (Hessels et al., 2016). In AOI analysis, the obscured or reduced in contrast.
shapeandboundsofanAOIcanbedifficult(Hesselsetal.,2016).
| Ideally, | each AOI | should | be defined | with | the | same | shape and |       |          |     |          |     |     |     |
| -------- | -------- | ------ | ---------- | ---- | --- | ---- | --------- | ----- | -------- | --- | -------- | --- | --- | --- |
|          |          |        |            |      |     |      |           | 4 EYE | MOVEMENT |     | MEASURES |     |     |     |
boundsastheactualobject.However,duetopracticallimitations,
|         | difficulty |     | defining |             |        |     |             |     |     |     |     |     |     |     |
| ------- | ---------- | --- | -------- | ----------- | ------ | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
| such as | the        | of  |          | arbitrarily | shaped |     | (and sized) |     |     |     |     |     |     |     |
AOIsineye-trackingsoftware,AOIsaremostcommonlydefined Inthissection,wediscussseveralmetricsrelevanttooculomotor
using simple shapes (rectangles, ellipses, etc.) (Holmqvist et al., behavior (Komogortsev et al., 2013) which are derived from
fixations,
2011).Recentadvancementsincomputervisionhavegivenriseto saccades, smooth pursuit, blinks, vergence, and visual
| modelsthatautomaticallyandreliablyidentifyrealworldobjects |        |        |             |        |     |                |      | search paradigm. |     |          |     |     |     |     |
| ---------------------------------------------------------- | ------ | ------ | ----------- | ------ | --- | -------------- | ---- | ---------------- | --- | -------- | --- | --- | --- | --- |
| in visual                                                  | scenes | Ren et | al. (2015), | Redmon |     | et al. (2016). | This |                  |     |          |     |     |     |     |
|                                                            |        |        |             |        |     |                |      | 4.1 Fixation     |     | Measures |     |     |     |     |
makesitpossibletoidentifyAOIsinrealworldimagesalmostas
pre-defined
readily as with stimuli presented on a computer Fixation-basedmeasuresarewidelyusedineye-trackingresearch.
screen Jayawardena and Jayarathna (2021), Zhang et al. (2018). Here,fixationsarefirstidentifiedusingalgorithmssuchasI-VT,
|          |     |          |     |     |     |     |     | I-HMM              | (velocity-based), |           | I-DT, | I-MST (dispersion-based), |        | and  |
| -------- | --- | -------- | --- | --- | --- | --- | --- | ------------------ | ----------------- | --------- | ----- | ------------------------- | ------ | ---- |
| 3.2 Heat | Map | Analysis |     |     |     |     |     |                    |                   |           |       |                           |        |      |
|          |     |          |     |     |     |     |     | I-AOI (area-based) |                   | (Salvucci |       | and Goldberg,             | 2000). | This |
Heat map analysis is a technique for analyzing the spatial information is then used to obtain different fixation measures,
distribution of eye movements across the visual scene. This as described below.
| technique     | can be  | used to       | analyze | eye | movements | of  | individual  |             |     |     |     |     |     |     |
| ------------- | ------- | ------------- | ------- | --- | --------- | --- | ----------- | ----------- | --- | --- | --- | --- | --- | --- |
| participants, | as well | as aggregated |         | eye | movements |     | of multiple | 4.1.1 Count |     |     |     |     |     |     |
participants. In general, heat maps are represented using Fixationcountisthenumberoffixationsidentifiedwithinagiven
|          |         |        |        |      |          |     |           | time period. | Fixations |     | can be | counted either | over the | entire |
| -------- | ------- | ------ | ------ | ---- | -------- | --- | --------- | ------------ | --------- | --- | ------ | -------------- | -------- | ------ |
| Gaussian | Mixture | Models | (GMMs) | that | indicate | the | frequency |              |           |     |        |                |          |        |
(orprobability)offixationlocalization.Heatmap-basedmetrics
|     |     |     |     |     |     |     |     | stimuli or | within | a single | AOI | (Holmqvist | et al., | 2011). |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ------ | -------- | --- | ---------- | ------- | ------ |
generally involve a measure of overlap between two GMMs, Fixation count has been used to determine semantic
indicating similarity of fixated regions of an image. In heat importance (Buswell, 1935; Yarbus, 1967), the efficiency and
difficulty
map analysis, the order of visitation is not captured in search (Goldberg and Kotval, 1999; Jacob and
(Grindinger et al., 2010); rather, it analyzes the spatial Karn, 2003), neurological dysfunctions (Brutten and Janssen,
distribution of fixations. When visualizing heat maps, a color- 1979; Coeckelbergh et al., 2002), and the impact of prior
fixationsisoverlaidonthestimuli
coded,spatialdistributionof experience (Schoonahd et al., 1973; Megaw, 1979; Megaw and
thatparticipantslookedat.Thecolorrepresents thequantityof Richardson, 1979).
| fixations    | at each | point on | the       | heat map. | Heat  | map            | analysis is |                |     |     |     |     |     |     |
| ------------ | ------- | -------- | --------- | --------- | ----- | -------------- | ----------- | -------------- | --- | --- | --- | --- | --- | --- |
| particularly | useful  | when     | analyzing | the       | areas | of the stimuli | that        | 4.1.2 Duration |     |     |     |     |     |     |
participantspaidmore(orless)visualattentionto,forexamplein Fixationdurationindicatesatimeperiodwheretheeyesstaystill
inoneposition(SalvucciandGoldberg,2000).Ingeneral,fixation
| driving | research | comparing | different |     | groups | and | conditions |     |     |     |     |     |     |     |
| ------- | -------- | --------- | --------- | --- | ------ | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
(Snider et al., 2021). durations are around 200–300ms long, and longer fixations
|          |      |          |     |     |     |     |     | indicate   | deeper | cognitive | processing | (Rayner,   | 1978;       | Salthouse |
| -------- | ---- | -------- | --- | --- | --- | --- | --- | ---------- | ------ | --------- | ---------- | ---------- | ----------- | --------- |
| 3.3 Scan | Path | Analysis |     |     |     |     |     |            |        |           | fixations  |            |             |           |
|          |      |          |     |     |     |     |     | and Ellis, | 1980). | Also,     |            | could last | for several | seconds   |
Ascanpathisasequenceoffixationsandsaccadesthatdescribe (YoungandSheena,1975;KarshandBreitenbach,1983)orbeas
the pattern of eye movements during a task (Salvucci and short as 30–40ms (Rayner, 1978; Rayner, 1979). Furthermore,
fixation
Goldberg, 2000). Scan paths could appear quite complex, with the distribution of duration is typically positively
frequentrevisitsandoverlappingsaccades.Ingeneral,scanpaths skewed, rather than Gaussian (Velichkovsky et al., 2000;
are visualized as a sequence of connected nodes (a fixation Staub and Benatar, 2013). The average fixation duration is
fixation
centroid) and edges (a saccade between two successive often used as a baseline to compare with duration
| fixations) |     |     |     |     |     |     |     |     |     |     |     |     |     | Pavlović |
| ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- |
displayed over the visual image of the scene data at different levels (Salthouse and Ellis, 1980;
(Heminghous and Duchowski, 2006; Goldberg and Helfman, and Jensen, 2009). By comparing average fixation duration
|              |     |          |         |      |                 |     |        | across AOIs, | one | could | distinguish | areas | that were | looked at |
| ------------ | --- | -------- | ------- | ---- | --------------- | --- | ------ | ------------ | --- | ----- | ----------- | ----- | --------- | --------- |
| 2010). Here, | the | diameter | of each | node | is proportional |     | to the |              |     |       |             |       |           |           |
fixation
duration (Goldberg and Helfman, 2010). Scan path for longer durations than others. In particular, if certain AOIs
analyses have been widely used to model the dynamics of eye were looked at longer than others, then their average fixation
movement during visual search (Walker-Smith et al., 1977; durationwouldbehigher(GoldbergandKotval,1999;Pavlović
Horley et al., 2003). It has also been used in areas like and Jensen, 2009).
FrontiersinComputerScience|www.frontiersin.org 6 January2022|Volume3|Article733531

| Mahanamaetal. |     |     |     |     |     | EyeMovementandPupilMeasures |     |
| ------------- | --- | --- | --- | --- | --- | --------------------------- | --- |
4.2 Saccade Measures Inpractice,themeasurementofthesaccadiclatencyisaffectedby
4.2.1 Amplitude
twomainfactors:Thesamplingfrequencyofthesetup,andthe
Theamplitudeofasaccade(seeFigure2)isthedistancetravelled saccade detection time. The sampling frequency refers to the
by a saccade during an eye movement. It is measured either by operational frequency of the eye tracker, where the operational
visual degrees (angular distance) or pixels, and can be frequency negatively correlates with the introduced error. The
fixation
approximated via the Euclidean distance between saccade detection time is when the device detects a saccade by
points (Megaw and Richardson, 1979; Holmqvist et al., 2011). arriving at the qualifying velocity or the criteria in the saccade
Saccade amplitudes are dependent on the nature of the visual detectionalgorithm.Inastudywithyoungandolderparticipants,
task. For instance, in reading tasks, saccade amplitudes are researchers observed the saccadic latencies to increase
|     | ≈ 7–8 |     |     | significantly |     |     |     |
| --- | ----- | --- | --- | ------------- | --- | --- | --- |
limited to 2°, i.e., letters in a standard font size (Rayner, in older participants with the decrease in the
1978). They are further limited when oral reading is involved stimulus size Warren et al. (2013). Further, in comparative
Parkinson’s
(Rayner et al., 2012). Furthermore, saccade amplitudes tend to studies between healthy subjects and subjects with
decreasewithincreasingtaskdifficulty(ZelinskyandSheinberg,
|     |     |     |     | disease with | and without | medication, saccadic | latency shows |
| --- | --- | --- | --- | ------------ | ----------- | -------------------- | ------------- |
1997;PhillipsandEdelman,2008),andwithincreasingcognitive potential as a biomarker for the disease (Michell et al., 2006).
load (May et al., 1990; Ceder, 1977). Asimilarstudywithparticipantshavingamblyopiahasfoundthe
interoculardifferencebetweensaccadiclatenciestocorrelatewith
4.2.2 Direction the difference in Snellen acuity (McKee et al., 2016).
| The direction | (or orientation,    | or trajectory)     | of a saccade | or         |     |     |     |
| ------------- | ------------------- | ------------------ | ------------ | ---------- | --- | --- | --- |
|               |                     |                    |              | 4.2.5 Rate |     |     |     |
| sequence of   | saccades is another | useful descriptive | measure.     | It         |     |     |     |
canberepresentedaseitheranabsolutevalue,arelativevalue,or Saccaderate(orsaccadefrequency)isthenumberofsaccadiceye
adiscretizedvalue.Absolutesaccadedirectioniscalculatedusing movements per unit time (Ohtani, 1971). For static stimuli,the
the coordinates of consecutive fixations. Relative saccade saccade rate is similar to the fixation rate. For dynamically
direction is calculated using the difference of absolute saccade moving stimuli, however, the saccade rate is a measure of
direction of two consecutive saccades. Discretized saccade catch-up saccades generated during smooth pursuit
directions are obtained by binning the absolute saccade (Holmqvist et al., 2011). The saccade rate decreases with
|     | pre-defined |     |     |     | difficulty |     |     |
| --- | ----------- | --- | --- | --- | ---------- | --- | --- |
direction into angular segments (e.g., compass-like increasing task (Nakayama et al., 2002) and fatigue
directions). In visual search studies, researchers have used level (Van Orden et al., 2000). Moreover, subjects with
different representations of saccade direction to analyze how neurological disorders exhibit higher saccadic rates during
(O’Driscoll
visual conditions affect eye movement behavior. For instance, smooth pursuit and Callahan, 2008; van Tricht
| absolute saccade                                         | directions | were used to  | analyze the effect     | of et al., 2010). |     |     |     |
| -------------------------------------------------------- | ---------- | ------------- | ---------------------- | ----------------- | --- | --- | --- |
| target predictability                                    | (Walker    | et al., 2006) | and visual orientation |                   |     |     |     |
| (Foulshametal.,2008)oneyemovements.Similarly,discretized |            |               |                        | 4.2.6 Gain        |     |     |     |
saccadedirectionswereusedtocompareandcontrastthevisual Saccadegain(orsaccadeaccuracy)istheratiobetweentheinitial
search strategies followed by different subjects (Ponsoda et al., saccade amplitude and the target amplitude (i.e., Euclidean
1995; Gbadamosi and Zangemeister, 2001). distance between the two stimuli among which that saccade
O’regan,
|     |     |     |     | occurred) | (Coëffé and | 1987). This | measure indicates |
| --- | --- | --- | --- | --------- | ----------- | ----------- | ----------------- |
4.2.3 Velocity howaccuratelyasaccadicmovementlandedonthetargetstimuli
Saccadevelocityiscalculatedbytakingthefirstderivativeoftime (Ettingeretal.,2002;Holmqvistetal.,2011).Whenthegainofa
series of gaze position data. Average saccadic velocity is the particular saccade is greater than 1.0, that saccade is called an
average of velocities over the duration of a saccade. Peak overshoot, or hypermetric, and when it is less than 1.0, that
saccadic velocity is the highest velocity reached during a saccade iscalled an undershoot, orhypometric. Saccadic gain is
saccade (Holmqvist et al., 2011). For a particular amplitude, probabilistic at a per-individual level; Lisi et al. (2019)
saccade velocity has been found to decrease with tiredness demonstrates that biased saccadic gains are an individualized
(Becker and Fuchs, 1969; McGregor and Stern, 1996), sleep probabilistic control strategy that adapts to different
deprivation (Russo et al., 2003), and conditions such as environmental conditions. Saccade gain is commonly used in
Alzheimer’s (Boxer et al., 2012) and AIDS (Castello et al., neurologicalstudies(Ettingeretal.,2002;Holmqvistetal.,2011).
1998). In contrast, saccade velocity has been found to increase For instance, Crevits et al.(2003) used saccade gain to quantify
with increasing task difficulty (Galley, 1993), increasing intrinsic the effects of severe sleep deprivation.
valueofvisualinformation(Xu-Wilsonetal.,2009),andincreasing
|                                                            |           |                   |              | 4.3 Smooth      | Pursuit | Measures |     |
| ---------------------------------------------------------- | --------- | ----------------- | ------------ | --------------- | ------- | -------- | --- |
| task experience                                            | (McGregor | and Stern, 1996). | Many studies | on              |         |          |     |
| neurologicalandbehavioraleffectsofdrugsandalcohol(Lehtinen |           |                   |              | 4.3.1 Direction |         |          |     |
etal.,1979;Griffithsetal.,1984;AbelandHertle,1988)haveused Smoothpursuitdirection(orsmoothpursuittrajectory)indicates
peak saccadevelocity as an oculomotor measure. the direction of smooth pursuit movement as the eyes follow a
movingstimulus(Holmqvistetal.,2011).Theabilitytopursuea
4.2.4 Latency movingobjectvarieswithitsdirectionofmotion.Rottachetal.
Saccadic latency measures the duration between the onset of a (1996) showed that smooth pursuit gain is higher during
stimulusandtheinitiationofthesaccade(Anderssonetal.,2010). horizontal pursuit than during vertical pursuit. This difference
FrontiersinComputerScience|www.frontiersin.org 7 January2022|Volume3|Article733531

| Mahanamaetal. |     |     |     |     |     |     |     |     |     | EyeMovementandPupilMeasures |     |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- |
directionandvelocityofthetargetobjectarenotpredictable,the
100–200ms
|     |     |     |     |     |     | smooth | pursuit |     | latency varies | between |     | (Burke | and |
| --- | --- | --- | --- | --- | --- | ------ | ------- | --- | -------------- | ------- | --- | ------ | --- |
Barnes,2006).Inparadigmssuchasstep-ramp(Rashbass,1961)
|     |     |     |     |     |     | thatallowforanticipation, |     |          |         | smoothpursuit | latencymay     |     | dropto   |
| --- | --- | --- | --- | --- | --- | ------------------------- | --- | -------- | ------- | ------------- | -------------- | --- | -------- |
|     |     |     |     |     |     | 0ms                       | (or | less, if | pursuit | starts before | target motion) |     | when its |
directionandvelocityarepredictable(BurkeandBarnes,2006;de
Hemptinneetal.,2006).Iftheluminanceofthemovingobjectis
thesameasthebackground,thesmoothpursuitlatencymaybe
∼50
|     |     |     |     |     |     | prolonged                                         |            | by       | ms       | (Braun et      | al., 2006).        | Smooth       | pursuit |
| --- | --- | --- | --- | --- | --- | ------------------------------------------------- | ---------- | -------- | -------- | -------------- | ------------------ | ------------ | ------- |
|     |     |     |     |     |     | latency                                           | is         | also     | affected | by distracting | motion             | (Spering     | and     |
|     |     |     |     |     |     | Gegenfurtner,                                     |            | 2007);   | latency  | was increased  | when               | a distractor |         |
|     |     |     |     |     |     | movedparalleltothepursuitdirectionbutwasdecreased |            |          |          |                |                    |              | when    |
|     |     |     |     |     |     | the                                               | distractor | moved    | opposite | to the         | pursuit direction. |              |         |
|     |     |     |     |     |     | 4.3.5                                             | Retinal    | Position |          | Error          |                    |              |         |
FIGURE3|Eyevelocity(plottedline)andvisualtargetvelocity(dotted Fixations are maintained more accurately on stationary targets
line)overtime(x-axis),alignedtopursuitonset(0ms).Smoothpursuit ratherthanmovingtargets.Duringsmoothpursuit,boththeeye
accelerationseenfrom0to140ms.Smoothpursuitlatencyseenfromorigin and the target are in motion, and lag between their positions is
| to0ms(SperingandGegenfurtner,2007). |     |     |     |     |     |          |     | (Dell’Osso |         |             |                |     |         |
| ----------------------------------- | --- | --- | --- | --- | --- | -------- | --- | ---------- | ------- | ----------- | -------------- | --- | ------- |
|                                     |     |     |     |     |     | expected |     |            | et al., | 1992). This | error is known | as  | retinal |
positionerror,andisformallydefinedasthedifferencebetween
|          |            |            |               |                    |           | eye   | and target | positions | measured | during | fixations. |     |     |
| -------- | ---------- | ---------- | ------------- | ------------------ | --------- | ----- | ---------- | --------- | -------- | ------ | ---------- | --- | --- |
| in gain  | can be     | attributed | to most       | real-world objects | naturally |       |            |           |          |        |            |     |     |
| being in | horizontal | rather     | than vertical | motion (Collewijn  | and       | 4.3.6 | Gain       |           |          |        |            |     |     |
Tamminga, 1984). Smooth pursuit gain (or smooth pursuit accuracy) is the ratio
betweensmoothpursuitvelocityandthetargetvelocity(Zackon
4.3.2 Velocity
andSharpe,1987;Holmqvistetal.,2011).Typically,thesmooth
Smoothpursuitvelocityisfirstmomentofgazepositionsduringa
pursuitgainislowerthan1.0andtendstofallevenlowerwhen
smooth pursuit. Compared to saccade velocity, the velocity of thetargetvelocityishigh(ZackonandSharpe,1987).Moreover,
20°/s–40°/s
smooth pursuits is low, typically around (Young, smooth pursuit gain is modulated by on-line gain control
specifically
1971). However, when participants are trained to (Robinson, 1965; Churchland and Lisberger, 2002). Smooth
follow moving stimuli, or are provided with accelerating pursuit gain is decreased during conditions that distract user
stimuli, higher peak smooth pursuit velocities were observed attention (Březinová and Kendell, 1977). Furthermore, smooth
(Meyer et al., 1985). For example, Barmack (1970) observed pursuit gain is also higher when tracking horizontal motion,
peak smooth pursuit velocities of 100°/s in typical participants, compared to tracking vertical motion Rottach et al. (1996).
when provided with accelerating stimuli. However, Bahill and Smooth pursuit gain has also been used in neurologically
|     |     |     |     |     | 130°/s |     |     |     |     | O’Driscoll |     |     |     |
| --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | ---------- | --- | --- | --- |
Laritz. (1984) observed peak smoothpursuit velocities of research. For instance, and Callahan (2008)
on trained baseball players. As the velocity of moving stimuli analyzed the smooth pursuit gain of individuals diagnosed
increases, the frequency of catch-up saccades increases to with schizophrenia, and observed a low smooth pursuit gain
compensate for retinal offset (De Brouwer et al., 2002). inthesepopulations.Thesmoothpursuitgaincanbequantified
bytherootmeansquareddistancebetweenthetargetpointand
4.3.3 Acceleration the gaze position (θ) over the span of the experiment of n data
| The second | moment | of  | the gaze | position trace | provides the | samples. |     |     |     |     |     |     |     |
| ---------- | ------ | --- | -------- | -------------- | ------------ | -------- | --- | --- | --- | --- | --- | --- | --- |
(cid:3)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)
| acceleration | of  | a smooth | pursuit | eye movement. | This |     |     |     |     |     |     |     |     |
| ------------ | --- | -------- | ------- | ------------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
acceleration is maintained until the eye velocity (smooth θ2+θ2+/‥+θ2
|     |     |     |     |     |     |     |     |     | θ (cid:1) | 1 2 | n   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
pursuit velocity) matches the visual target’s velocity (Kao and RMSE (1)
n
Morrow,1994).Examinationofaccelerationistypicallyapartof
determiningsmoothpursuitonset(seeFigure3).Smoothpursuit
acceleration has been used to analyze how visual cues (Ladda 4.4 Blink Measures
| et al., 2007) | and | prior knowledge | of  | a visual target’s | trajectory | 4.4.1 | Rate |     |     |     |     |     |     |
| ------------- | --- | --------------- | --- | ----------------- | ---------- | ----- | ---- | --- | --- | --- | --- | --- | --- |
(KaoandMorrow,1994)impacteyemovements.Smoothpursuit Blink rate (or spontaneous blink rate, or blink frequency) is
target’s
acceleration is higher when a visual motion was typically measured in blinks per minute. In some studies, the
unpredictable. timebetweenblinks(orblinkinterval)ismeasuredinstead(Shin
etal.,2015).Earlystudies(PetersonandAllison,1931;Newhall,
4.3.4 Latency 1932)showthatblinkrateissubjectedtofactorssuchaslighting,
Smoothpursuitlatencyisthedelaybetweenwhenatargetobject time of the day (fatigue), temperature, wind, age, and sex.
starts to move (i.e., target onset) and when the pursuit begins Moreover, while blinks are predominantly involuntary, they
(i.e., smooth pursuit onset) (Holmqvist et al., 2011). When the are inhibited during engaged visual attention to minimize any
FrontiersinComputerScience|www.frontiersin.org 8 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
blink-induced interruption to visual information (Ranti et al., obtained through following equation, where s is the starting
2020). More recent studies explore the idea of standard position of the saccade, e ending position of the saccade, and
spontaneous eye blink rate in a broader aspect; healthy and n is the total number of saccades.
non-healthy individuals under single (Doughty, 2002; Doughty (cid:7)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)
andNaase,2006;Rantietal.,2020)andmultiple(Doughty,2001; SLI (cid:1)(cid:4) n (s −e )2+(cid:5)s −e (cid:6)2 (2)
Doughty, 2019) experiment conditions. Their results Total x x y y
i(cid:1)1
demonstrate the lack of a common value for blink rate, as
they are dependent on experimental conditions. Thus, a Jarodzka et al. (2010), on the other hand, proposed
standard measure for blink rate remains illusive despite the representing scan paths as geometrical vectors, and simplifying
vast body of studies. Many studies on cognition adopt eye scanpathsbyclusteringconsecutivesaccadesdirectedatmostTϕ
blink rate as a metric due its relative ease of detection, and its radians apart.
abilitytoindicateaspectsofone’sinternalstate.Inastudyonthe
impactofblinkrateonaStrooptask,researchersfoundthatblink 4.5.2 Time-to-First-Fixation on AOI
rateincreasesduringaStrooptaskcomparedwithabaselinetask Time-to-First-FixationonAOI(ortimetofirsthit)referstothe
of resting (Oh et al., 2012). Further, a study involving movie time taken from stimulus onset up to the first fixation into a
watchingfoundtheblinkrateareliablebiomarkerforassessing particular AOI (Holmqvist et al., 2011). This measure may be
the concentration level (Shin et al., 2015; Maffei and Angrilli, usefulforbothbottom-upstimulus-drivensearches(e.g.,aflashy
2019). Studies in dopamine processes also use blink rate as a company label) as well as top-down attention driven searches
marker of dopamine function. A review on studies in cognitive (e.g., when respondents actively decide to focus on certain
dopaminefunctionsandtherelationshipwithblinkrateindicates elements or aspects on a website or picture). This metric is
varying results on blink rate in dopaminergic studies, including particularly useful for user interface evaluation, as a measure
primates (Jongkees and Colzato, 2016). ofvisualsearchefficiency(JacobandKarn,2003).Forinstance,it
hasbeenusedtoevaluatethevisualsearchefficiencyofwebpages
4.4.2 Amplitude (Ellis et al., 1998; Bojko, 2006). It is also influenced by prior
The blink amplitude is the measure of the distance traveled by knowledge,suchasdomainexpertise.Forinstance,studiesshow
(thedownwarddistanceofuppereyelid)intheeventofablink thatwhenanalyzingmedicalimages,expertradiologistsexhibita
(Stevenson et al., 1986). The amplitude measures the relative lowerTimetoFirstFixationonAOIs(lesions,tumors,etc.)than
distance of motion to the distance the eyelid travels in a novice radiologists (Krupinski, 1996; Venjakob et al., 2012;
complete blink. This measure can be obtained using a Donovan and Litchfield, 2013).
video-based eye tracker (Riggs et al., 1987) or using
electrooculography (Morris and Miller, 1996). Blink 4.5.3 Revisit Count
amplitude is often used in conjunction with research Revisit(orre-fixation,orrecheck)countindicateshowoftenthe
associated with fatigue measurement (Morris and Miller, gaze was returned to a particular AOI. It can be used to
1996; Galley et al., 2004) and task difficulty (Cardona et al., distinguish between the AOIs that were frequently revisited,
2011; Chu et al., 2014). Cardona et al. (2011) assessed the and the AOIs that were less so. A participant may be drawn
characteristicsofblinkbehaviorduringvisualtasksrequiring backtoaparticularAOIfordifferentreasons,suchasitssemantic
prolonged periods of demanding activities. During the importance (Guo et al., 2016), to refresh the memory
experiment, the authors noted a larger percentage of (Meghanathan et al., 2019), and for confirmatory purposes
incomplete blinks. Another study involving fatigued pilots (Mello-Thoms et al., 2005). The emotion perceived through
in a flight simulator showed that blink amplitude served as visual stimuli also affect the likelihood of subsequent revisits,
a promising predictor for level of fatigue (Morris and and thereby, the revisit count (Motoki et al., 2021); yet this
Miller, 1996). perceived emotion is difficult to interpret purely through
revisit count. Revisits are particularly common in social
4.5 Visual Search Measures scenes, where observers look back and forth between
Visualsearchbehaviorcombinesinstancesofsaccades,fixations interacting characters to assess their interaction (Birmingham
and possiblyalsosmoothpursuit.Themethodsusedtoanalyze et al., 2008). Overall, revisit count is indicative of user interest
such sequences of behavior are described below. towards an AOI, and can be used to optimize user experiences.
4.5 1 Scan Path Similarity 4.5.4 Dwell Time
Vectorandstring-basededitingapproacheshavebeendeveloped Dwelltimeistheintervalbetweenone’sgazeenteringanAOIand
tocomputethesimilarityofscanpaths(Jarodzkaetal.,2010;De subsequentlyexitingit(Holmqvistetal.,2011).Thisincludesthe
Bruinetal.,2013).Inparticular,DeBruinetal.(2013)introduced timespentonallfixations,saccades,andrevisitsduringthatvisit
threemetrics:1)SaccadeLengthIndex(SLI),2)SaccadeDeviation (Tullis and Albert, 2013). For a typical English reading task, a
Index(SDI)—toassistinfasteranalysisofeyetrackingdata,and lowerdwelltime(e.g., <100ms)mayimplylimitedinformation
3) Benchmark Deviation Vectors (BDV)—to highlight repetitive processing, and a higher dwell time (e.g., >500ms) may imply
path deviation in eye tracking data. The SLI is the sum of the otherwise(TullisandAlbert,2013).Dwelltimesaredependenton
distanceofallthesaccadesduringtheexperiment.TheSLIcanbe factorssuchasthesizeandcomplexityofcontentwithinanAOI
FrontiersinComputerScience|www.frontiersin.org 9 January2022|Volume3|Article733531

| Mahanamaetal. |     |     |     |     |     |     |     |     |     |     | EyeMovementandPupilMeasures |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- |
FIGURE4|AOIs,Scanpaths,andGazeTransitionMatricesfromJayawardenaetal.(2020).(A)AOIonfacestimuli.(B)ScanpathwithfixationsontheAOIs.(C)
Gazetransitionmatrix.
(GoldbergandKotval,1999),thelevelofinteresttowardsanAOI Figure 4A shows the AOIs used in this study. Figure 4B
(Fisheretal.,2017),situationalawareness(HaulandandDuijm, shows a sample scanpath of a participant, and Figure 4C
2002),andtaskdifficulty(GoldbergandKotval,1999).Insome shows its corresponding gaze transition matrix. Here, each cell
cases,ahigherdwelltimecouldbeassociatedwithmotivationand in the matrix represents the probability of gaze transition from
top-downattention,asgoal-drivenrespondentsmayrefrainfrom one AOI to another.
lookingatcontextuallyirrelevantstimuli(MohantyandSussman,
| 2013).     |            |     |        |     |     | 4.5.8       | Gaze       | Transition  |     | Entropy      |                   |           |        |
| ---------- | ---------- | --- | ------ | --- | --- | ----------- | ---------- | ----------- | --- | ------------ | ----------------- | --------- | ------ |
|            |            |     |        |     |     | Gaze        | transition | entropy     |     | is a measure | of predictability |           | in AOI |
|            |            |     |        |     |     | transitions |            | and overall |     | distribution | of eye            | movements | over   |
| 4.5.5 Gaze | Transition |     | Matrix |     |     |             |            |             |     |              |                   |           |        |
The gaze transition matrix is an adaptation of the transition stimuli (Krejtz et al., 2014; Krejtz et al., 2015). Compared to
transitionmatrixdensity,gazetransitionentropyisahistogram-
| matrix of | Markov | models | into | eye movement | analysis. In a |     |     |     |     |     |     |     |     |
| --------- | ------ | ------ | ---- | ------------ | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
basedestimation,which,ineffect,takesintoaccounttheAOIsize.
| Markov | model, | a transition | matrix | (or probability | matrix, or |     |     |     |     |     |     |     |     |
| ------ | ------ | ------------ | ------ | --------------- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
stochastic matrix, or substitution matrix) is a square matrix, Theconceptofentropyusedhereisthatofinformationtheory;it
where each entry represents the transition probability from describes the amount of information required to generate a
first particular sequence, as a measure of its uncertainty. Krejtz
| one state | to another. | This | concept | was           | applied for eye |     |             |        |     |            |          |      |            |
| --------- | ----------- | ---- | ------- | ------------- | --------------- | --- | ----------- | ------ | --- | ---------- | -------- | ---- | ---------- |
|           |             |      |         |               |                 | et  | al. (2014), | Krejtz | et  | al. (2015) | computes | gaze | transition |
| movement  | analysis    | by   | Ponsoda | et al. (1995) | to model the    |     |             |        |     |            |          |      |            |
first
transition of saccade direction during visual search. Similarly, entropy by modelling eye movements between AOIs as a
|     |     |     |     |     |     | first-order |     | Markov | chain, | and then | obtaining | its | Shannon’s |
| --- | --- | --- | --- | --- | --- | ----------- | --- | ------ | ------ | -------- | --------- | --- | --------- |
Bednariketal.(2005)usedthisconcepttomodelthetransitionof
|     |     |     |     |     |     | entropy | (Shannon, |     | 1948). | They | obtain two | forms | of entropy: |
| --- | --- | --- | --- | --- | --- | ------- | --------- | --- | ------ | ---- | ---------- | ----- | ----------- |
gazepositionamongAOIsandstudythecorrelationbetweentask
subjects’
performance and search pattern. The gaze transition matrix is 1) transition entropy H t (calculated for individual
calculated using the number of transitions from theXthAOI to transition matrices) and 2) stationary entropy H (calculated
s
| Yth            |            |            |          |             |                      | for | individual | subjects’        | stationary |         | distributions).    |     |       |
| -------------- | ---------- | ---------- | -------- | ----------- | -------------------- | --- | ---------- | ---------------- | ---------- | ------- | ------------------ | --- | ----- |
| the            | AOI. Based | on         | the gaze | transition  | matrix, several      |     |            |                  |            |         |                    |     |       |
| measures       | have been  | introduced |          | to quantify | different aspects of |     |            |                  |            |         |                    |     |       |
|                |            |            |          |             |                      |     | H          | (cid:1)−(cid:4)π | (cid:4)p   | log p   | H (cid:1)−(cid:4)π | log | π (3) |
| visual search. |            |            |          |             |                      |     |            | t                | i          | ij 2 ij | s                  | i   | 2 i   |
|                |            |            |          |             |                      |     |            | i                | j          |         |                    | i   |       |
4.5.6 Transition Matrix Density H indicates the predictability of gaze transitions; a high H
|     |     |     |     |     |     |     | t   |     |     |     |     |     | t   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Goldberg and Kotval (1999) defined transition matrix density (∀ |p →0.5)implieslowpredictability,whereasalowH (∀ |p
|     |     |     |     |     |     |     | ij ij |     |     |     |     |     | t ij ij |
| --- | --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | ------- |
(i.e.,fractionofnon-zeroentriesinthetransitionmatrix)inorder → {0, 1}) implies high predictability. It is calculated by
toanalyzetheefficiencyofvisualsearch.Here,alowertransition
|     |     |     |     |     |     | normalizing |     | the | transition | matrix | row-wise, | replacing | zero- |
| --- | --- | --- | --- | --- | --- | ----------- | --- | --- | ---------- | ------ | --------- | --------- | ----- |
matrixdensityindicatesanefficientanddirectedsearch,whereas sum rows by the uniform transition probability 1/s (Here, s is
a dense transition matrix indicates a random search. thenumberofAOIs),andobtainingitsShannon’sentropy.H,on
s
|     |     |     |     |     |     | the | other | hand, | indicates | the distribution |     | of visual | attention |
| --- | --- | --- | --- | --- | --- | --- | ----- | ----- | --------- | ---------------- | --- | --------- | --------- |
4.5.7 Gaze Transition Probability (Krejtz et al., 2014); a high H indicates that visual attention is
s
When comparing gaze transition matrices, Vandeberg et al. equally distributed across all AOIs, whereas a low H indicates
s
|                  |     |                 |     |            |               | that | visual | attention | is  | directed | towards | certain | AOIs. It is |
| ---------------- | --- | --------------- | --- | ---------- | ------------- | ---- | ------ | --------- | --- | -------- | ------- | ------- | ----------- |
| (2013) performed |     | an element-wise |     | comparison | of transition |      |        |           |     |          |         |         |             |
probabilities by modelling eye movement transitions as a estimated via eigen-analysis, and the Markov chain is assumed
multi-level Hidden Markov Model. Similarly, Jayawardena tobeinasteadystatewherethetransitionprobabilitiesconverge.
et al. (2020) utilized gaze transition matrices to analyze the In one study, Krejtz et al. (2015) showed that participants who
probabilities of transition of gaze between four AOIs. viewed artwork with a reportedly high curiosity, yielded a
FrontiersinComputerScience|www.frontiersin.org 10 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
vergencealsohasbeenthesubjectofestimating3Dgazepositions
(Mlotetal.,2016)basedon2Dpositionsprovidedbyeyetrackers.
Theperceiveddepth(Δd)canbecomputedusingthedistance
between gaze positions (Δx), the distance between the left and
right eye (a), and the distance between the user and the
screen (D′).
ΔxD′
Δd(cid:1) (4)
Δx−a
5 PUPIL MEASURES
Pupilmeasures(seeTable1foralistofpupilmeasures)capture
fluctuations in the pupil’s size and orientation to produce
measurements that provide insights into one’s internal state.
The pupil diameter is the result of tonic and phasic pupillary
responses of the eye (Sun et al., 1983; Wass et al., 2015;
Peysakhovich et al., 2017).
Thetoniccomponentreferstothepupildiameterchanges
caused by slow contractions, while the phasic refers to
the quick or transient contractions. Most of the metrics
use pupil dilation as the primary measure for the
computations in order to determine the tonic and phasic
FIGURE5|Ocularvergence(Daughertyetal.,2010;Wangetal.,2012). components.
5.1 Pupil Diameter
significantly less H t (i.e., more predictable transitions) than The most primitive metric used in pupillometry is the average
others. Moreover, participants who viewed artwork with a pupildiameter(Grayetal.,1993;Joshietal.,2016).Themeasure
reportedly high appreciation, yielded a significantly less H s capturesboththetonicandthephasiccomponentsofthepupil
(i.e., more directed visual attention) than others. In another dilation. Using the average dilation, some of the phasic and
study, Krejtz et al. (2015) showed that participants who transient features can get smoothed out. An alternative
reportedly recognized a given artwork, yielded a significantly measure to overcome the drawback of the average pupil
higher H t and H s (i.e., less predictable gaze) than others. dilation is to use the change in pupil dilation relative to a
Jayawardena et al. (2020) performed entropy-based eye baseline. The baseline is assumed to correspond to the tonic
movement analysis on neurotypical and ADHD-diagnosed component, while the relative change refers to the phasic
subjects during an audiovisual speech-in-noise task. They component. The baseline can be either derived during the
found that ADHD-diagnosed participants made unpredictable study or through a controlled environment.
gaze transitions (i.e., high entropy) at different levels of task
difficulty, whereas the neurotypical group of participants made 5.2 Index of Cognitive Activity
gaze transitions from any AOI to the mouth region (i.e., low Index of Cognitive Activity (ICA), introduced by Marshall
entropy)regardlessoftaskdifficulty.Thesefindingssuggestthat (2002), is a measure of pupil diameter fluctuation as an
H t and H s are potential indicators of curiosity, interest, picture instantaneous measure. Marshall (2000), Marshall (2007)
familiarity, and task difficulty. describes the methodology followed in computing the
ICA in an experiment setting. Furthermore, the
4.6 Vergence Measures
publications also include parameter selections when
Duetotheassociationofocularvergencewithbinocularvision, performing experiments. The process starts by eliminating
thebinoculargazedatacanbeusedtomeasureocularvergence. the pupil signal regions corresponding to blinks by either
The gaze vergence can be estimated (see Figure 5) using the removing them or replacing them through interpolation as
distance between the individual gaze positions for each eye, the the preprocessing step. The signal is then passed through
distancefromtheusertothescreen,andtheinteroculardistance wavelet decomposition to capture the pupil signal’s abrupt
(Daughertyetal.,2010;Wangetal.,2012).Acommonapplication changes through decomposing to the desired level. Finally,
of theocular vergence is assessing stereoscopic perception (Essig the decomposed signal subjects to thresholding, converting
etal., 2004; Daughertyetal., 2010; Wangetal., 2012). the decomposed signal coefficients to a binary vector of the
These studies use ocular vergence to assess the user’s depth same size; the thresholding stage acts as a de-noising
perceptionunderdifferentstimuliconditions.Further,theocular stage here.
FrontiersinComputerScience|www.frontiersin.org 11 January2022|Volume3|Article733531

| Mahanamaetal. |     |     |     |     |     |     |     |     |     |     |     | EyeMovementandPupilMeasures |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- |
FIGURE6|Visualizationoftheprocessedpupildiametersignal(yellow)andthethresholdusedforcalculatingtheLow/HighIndexofPupillaryActivity(green)
(Duchowskietal.,2020).
5.3 Index of Pupillary Activity j(cid:1)1andforthelowfrequencycomponent,theyhavechosenj(cid:1)
IndexofPupillaryactivity(IPA),introducedbyDuchowskietal. 1/2log (n),themid-levelfrequencyoctavewherelog (n)isthe
|     |     |     |     |     |     |     |     | 2   |     |     |     |     |     | 2   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(2018), is a metric inspired by ICA, with a similar underlying number of octaves. Thus, the low frequency/high frequency
| concept.StudiesonICAdonotfullydisclosetheinternalsofICA |     |     |     |     |     |     |     | ratio is: |     |     |     |     |     |     |
| ------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- | --- |
duetointellectualpropertyreasons.IPA,however,disclosesthe
|           |             |          |               |     |               |     |        |     |     | (n)(t)/x1 |     | (cid:5)21/2log2 (n)t(cid:6) |     |     |
| --------- | ----------- | -------- | ------------- | --- | ------------- | --- | ------ | --- | --- | --------- | --- | --------------------------- | --- | --- |
| internals | of its      | process. |               |     |               |     |        |     |     | x1 /2log2 |     |                             |     | (7) |
|           |             |          |               |     |               |     |        |     |     | ψ         | ψ   |                             |     |     |
| IPA       | computation | starts   | by discarding |     | pupil signals |     | around |     |     |           |     |                             |     |     |
blinksidentifiedintheexperiment.Duchowskietal.(2018)used The pupillary response increases as the cognitive load
|     |     |     |     |     |     |     |     | increases. | Since | LHIPA is | a ratio, | an increase | in  | the pupillary |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ----- | -------- | -------- | ----------- | --- | ------------- |
awindowof200msineitherdirectionduringexperiments.The
reflects
procedureforcomputingtheIPAmeasurementstartswithatwo- response a decrease in the LHIPA reading. The authors
level Symlet-16 discrete wavelet decomposition of the pupil demonstrate the metric’s applicability using a series of three
|          |        |              |          |         |          |     | ψ        | experiments | where | they | assess | the relationship |     | between the |
| -------- | ------ | ------------ | -------- | ------- | -------- | --- | -------- | ----------- | ----- | ---- | ------ | ---------------- | --- | ----------- |
| dilation | signal | by selecting | a mother | wavelet | function |     | j,k (t). |             |       |      |        |                  |     |             |
difficulty
The resulting dyadic wavelet upon the wavelet analysis of the task and the corresponding measures of IPA and
signal x(t), generates a dyadic series representation. Then the LHIPA. During the experiments, the authors determined that
theLHIPAwasabletoidentifybetweendifficulttasksandeasyor
processfollowsamulti-resolutionsignalanalysisoftheoriginal
baselinetasksthroughoutthestudy,whileIPAcoulddosoduring
signalx(t).Alevelisarbitrarilyselectedfromthemulti-resolution
decomposition to produce a smoother approximation of the only one experiment. The experiments also revealed that the
signal x(t). Finally, threshold the wavelet modulus maxima LHIPAdemonstratedcognitiveloadearlierthanIPA,indicatinga
coefficients defined faster response due to the measure being a ratio and a built-in
|     | using | a universal | threshold   |                                                   | by, |     |     |               |      |         |              |     |     |     |
| --- | ----- | ----------- | ----------- | ------------------------------------------------- | --- | --- | --- | ------------- | ---- | ------- | ------------ | --- | --- | --- |
|     |       |             |             | (cid:8)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1)(cid:1) |     |     |     |               |      | ratio’s |              |     |     |     |
|     |       |             |             |                                                   |     |     |     | ratio arising | from | the     | computation. |     |     |     |
|     |       |             | λ (cid:1)σ^ |                                                   |     |     |     |               |      |         |              |     |     |     |
|     |       |             | univ        | 2logn                                             |     |     | (5) |               |      |         |              |     |     |     |
σ^is
where the standard deviation of the noise. The number of 6 DISCUSSION
| remaining | coefficients | represents   |          | the IPA   | reading  | for the    | given |              |            |            |             |                  |           |            |
| --------- | ------------ | ------------ | -------- | --------- | -------- | ---------- | ----- | ------------ | ---------- | ---------- | ----------- | ---------------- | --------- | ---------- |
| pupil     | diameter     | signal.      |          |           |          |            |       |              |            |            |             |                  |           |            |
|           |              |              |          |           |          |            |       | Eye movement |            | and pupil  | measures    | have             | been      | applied in |
|           |              |              |          |           |          |            |       | disciplines  | including, | but        | not limited | to, neuroscience |           | (Hessels   |
| 5.4       | Low/High     | Index        | of       | Pupillary | Activity |            |       |              |            |            |             |                  |           |            |
|           |              |              |          |           |          |            |       | and Hooge,   | 2019),     | psychology | (Mele       | and              | Federici, | 2012), and |
| Low/High  | Index        | of Pupillary | Activity | (LHIPA),  |          | introduced | by    |              |            |            |             |                  |           |            |
humancomputerinteraction(Duchowski,2002).Inthissection,
Duchowski et al. (2020), is a variation of the IPA measure we collectively summarize the literature of eye movement and
identified
|     | earlier. | The computation |     | of the | metric | remains | the |              |              |     |       |           |          |             |
| --- | -------- | --------------- | --- | ------ | ------ | ------- | --- | ------------ | ------------ | --- | ----- | --------- | -------- | ----------- |
|     |          |                 |     |        |        |         |     | pupillometry | applications |     | under | different | domains, | discuss the |
sameasinIPA,exceptforcountingremnants.Insteadofcounting
limitationsthatweobserve,andbydoingso,establishavisionfor
| threshold | remnants | as in | IPA (Duchowski |     | et al., | 2018), | LHIPA |              |     |               |     |       |          |          |
| --------- | -------- | ----- | -------------- | --- | ------- | ------ | ----- | ------------ | --- | ------------- | --- | ----- | -------- | -------- |
|           |          |       |                |     |         |        |       | implementing |     | eye movements | and | pupil | measures | in these |
countsthemodulusmaximaofthelowandhigh-frequencybands application environments.
| contained | in  | the wavelet      | (see Figure | 6).       |            |     |       |                  |     |     |     |     |     |     |
| --------- | --- | ---------------- | ----------- | --------- | ---------- | --- | ----- | ---------------- | --- | --- | --- | --- | --- | --- |
| Using     | the | Discrete Wavelet |             | Transform | to analyze | the | pupil |                  |     |     |     |     |     |     |
|           |     |                  |             |           |            |     |       | 6.1 Applications |     |     |     |     |     |     |
diameter signal at multiple levels of resolution, the wavelet 6.1.1 Neuroscience
coefficients
|     | are | found by: |     |     |     |     |     |                 |     |               |             |      |         |          |
| --- | --- | --------- | --- | --- | --- | --- | --- | --------------- | --- | ------------- | ----------- | ---- | ------- | -------- |
|     |     |           |     |     |     |     |     | In eye-tracking |     | neuroscience, | researchers | have | jointly | analyzed |
( j−1 ) n eu r o n a l a c tiv i t y a n d ocu l om o tor a c tivi t y t o s t ud y t h e
|     |     | x   | (t)(cid:1)(cid:4)g | xj (2t+k) |     |     | (6) |     |     |     |     |     |     |     |
| --- | --- | --- | ------------------ | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ψ k ψ ph y s io l o gic a l o r g an iz a tion o f th e vis io n s y ste m , a n d th e i r
k
|     |     |     |     |     |     |     |     | effect on | cognition | and | behavior. | Studies | of neuronal | activity |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --------- | --- | --------- | ------- | ----------- | -------- |
istheone-dimensionalhigh-passwaveletfilter.Leveljis
whereg during phenomena such as attention (Blair et al., 2009; Kimble
k
chosenarbitrarilytoselecteitherhighorlowfrequencywavelet et al., 2010), scene perception (Duc et al., 2008), inattentional
coefficients.Forthehighfrequencycomponent,theyhavechosen blindness (Simons and Chabris, 1999), visual engagement
FrontiersinComputerScience|www.frontiersin.org 12 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
(Catherine and James, 2001), and covert attention processing Pateletal.(2012)showedthatsaccadelatencyiscorrelatedwith
(i.e.,visuallyfixatingononelocationwhiledivertingattentionto the severity of Huntington Disease (HD), and suggested its
another)(Posneretal.,1980)hadrevealedimportantfactsabout possiblity of being a biomarker of disease severity in HD. In
cognition and behavior. another study, Jensen et al. (2019) found that reduced saccade
Forinstance,studiesoncovertattentionprocessingshowthat velocity isa keyindicator of progressive supranuclear palsy and
attention cannot be inferred solely from whether an object was otherdisodersofmid-brain.Similarly,Biscaldietal.(1998)found
lookedat(HafedandClark, 2002;EbitzandMoore,2019),and thatindividualswithDyslexiahadsignificantlyhigherregressive
doing so would lead to false positives (Posner et al., 1980). saccade rate in a sequential-target task. Similarly, Termsarasab
Similarly, studies on scene perception show that information is et al. (2015) stated that abnormalities in saccade gain could aid
processed in two forms: top-down (based on semantic diagnosis of hyperkinetic and hypokinetic movement disorders.
importance) and bottom-up (based on visual significance such Similarly,Fukushimaetal.(2013)usedamemory-basedsmooth
ascolor,brightness,etc.)(Ducetal.,2008).Moreover,studieson pursuit task to examine working memory of smooth pursuit
visual attention show that attention is divided among AOIs direction in individuals with PD.
through a sustained cognitive state, from which relevant visual Certain studies performed their analysis using visual search
objects become available to influence behavior Duncan et al. measures. Rutherford and Towns (2008), for instance,
(1994). demonstrated scan path similarities and differences during
Studieshavealsorevealedthatpupillaryactivityiscorrelated emotion perception between typical individuals and
withcognitiveload(HessandPolt,1964;Hyönäetal.,1995),and individuals with ASD. Similarly, Bours et al. (2018)
also with neural gain (Eldar et al., 2013) and cortical activity demonstrated that individuals with ASD had increased time to
(Reimeretal.,2016).Whilecognitiveloadcanbeinferredfrom first fixation on the eyes of fearful faces during emotion
pupillary activity, studies show that such inference becomes recognition task. Duret et al. (1999) showed that refixation
challenging in fast-paced cognitive tasks (Wierda et al., 2012), strategies in macular disorders was dependant on location of
temporallyoverlappingcognitivetasks(Wierdaetal.,2012),and the target relative to the scotoma, spatial characteristics of the
insurroundingswithvaryingambientluminance(Zénon,2017). disease and the duration of the disorder. Guillon et al. (2015)
Cherngetal.(2020)showedthatpupildiameter isregulatedby showedthatgazetransitionmatricescouldpotentiallyrevealnew
sympathetic activation (arousal-induced pupil dilation) and strategies of visual scanning followed by individuals with ASD.
parasympathetic inhibition (saccade-induced pupil dilation), Moreover, Wainstein et al. (2017) showed that pupil diameter
both of which are affected by ambient luminance. Wierda couldbeabiomarkerinADHDbasedontheresultsfromavisuo-
et al. (2012) showed that a deconvolved pupil response signal spatial working memory task.
is indicative of cognitive load, with a high temporal resolution.
However, (Zénon, 2017), showed that this method does not 6.1.2 Human Computer Interaction
account for low-frequency pupil fluctuations and inter- In HCI research, eye tracking has been used to evaluate the
individual variability of pupil responses, and instead proposed usability of human-computer interfaces (both hardware and
using auto-regressive models (Cho et al., 2018) with exogenous software). Here, the primary eye movement measures being
inputstoanalyzepupillaryactivity.Similarly,WatsonandYellott analyzed are saccades, fixations, smooth pursuits,
(2012) proposes a generalized formula to analyze pupillary compensatory, vergence, micro-saccades, and nystagmus
activity, which accounts for ambient luminance, the size of the (Goldberg and Wichansky, 2003). For instance, Farbos et al.
adaptingfield,theage oftheobserver, andwhetherbothpupils (2000) and Dobson (1977) had attempted to correlate eye
are adapted. tracking measures with software usability metrics such as time
Researchersofeyetrackingneursciencehaveutilizedvarious taken, completion rate, and other global metrics. Similarly, Du
measurestostudyneurodevelopmentaldisorders.Someofthese and MacDonald (2014) had analyzed how visual saliency is
studiesareexclusivelybasedonfixationmeasures.Forinstance, affected by icon size. In both scenarios, eye movements were
Heetal.(2019)examinedthefixationcountandfixationduration recordedwhileusersnavigatedhuman-computerinterfaces,and
in preschoolers with Autism Spectrum Disorder (ASD), and were subsequently analyzed using fixation and scan-path
found that preschoolers with ASD had atypical gaze patterns measures.
in a facial emotion expression task compared to typical Pupil diameter measures are widely used to assess the
individuals. Moreover, they found that deficits in recognizing cognitive load of users when interacting with human-
emotions from facial expressions in ASD correlated with the computer interfaces. For instance, Bailey and Iqbal (2008)
social interaction and development quotient. In contrast, some used pupil diameter measures to demonstrate that cognitive
studiesarebasedexclusivelyonsaccadicmeasures.Forinstance, load varies while completing a goal-directed task. Adamczyk
MacAskill et al. (2002) found that the saccade amplitude was and Bailey (2004) used pupil diameter measures to
modified during adaption of memory-guided saccades and this demonstrate that the disruption caused by user interface
adaptive ability was impaired in individuals with Parkinson’s interruptions (e.g., notifications) is more pronounced during
disease. Similarly, Barbosa et al. (2019) identfied that saccadic periods of high cognitive load. Iqbal et al. (2004) used pupil
direction errors are associated with impulsive compulsive diameter measures to show that difficult tasks demand longer
behaviors of individuals with Parkinson’s Disease, as they had processing time, induces higher subjective ratings of cognitive
difficulty in suppressing automatic saccades to a given target. load, and reliably evokes greater pupillary response at salient
FrontiersinComputerScience|www.frontiersin.org 13 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
subtasks.Inadditiontopupildiametermeasures,studiessuchas relationships between the consumer decision process through
Chen andEpps(2014)havealso utilizedblinkrate measuresto fixations on different sections in the product description Ares
analyze how cognitive load (Sweller, 2011) and perceptual load etal.(2013),Menonetal.(2016).Theutilityofeye-trackingin
(MacdonaldandLavie,2011)variesacrossdifferenttasks.They marketing extends beyond product descriptions, to
claimthat pupil diameter indicates cognitive load well for tasks advertisements, brands, choice, and search patterns (Wedel
withlowperceptualload,andthatblinkrateindicatesperceptual and Pieters, 2008).
load better than cognitive load.
6.2 Recent Developments
6.1.3 Psychology Among the recent developments in eye tracking and pupil
Inpsychologyresearch,eyetrackinghasbeenusedtounderstand measures,theintroductionofaseriesofpupillometry-based
eye movements and visual cognition during naturalistic measures (ICA, IPA, and LHIPA) (Marshall, 2002;
interactions such as reading, driving, and speaking. Rayner Duchowski et al., 2018; Duchowski et al., 2020) to assess
(2012), for instance, have analyzed eye movements during thecognitiveloadisnoteworthy.Thesemeasures,ingeneral,
English reading, and observed a mean saccade duration and compute the cognitive load by processing the pupil dilation
amplitude of 200–250ms and 7–9 letters, respectively. They as a signal, and thus require frequent and precise
have also observed different eye movement patterns when measurements of pupil dilation to function. We ascribe
reading silently vs aloud, and correlations of text complexity the success of these measures to the technological
to both fixation duration (+) and saccade length (−). Three advancements in pupillometric devices, which led to
paradigms were commonly used to analyze eye movements higher sampling rates and more accurate measurement of
during reading tasks: moving window—selecting a few pupil dilation than possible before. In the future, we
characters before/after the fixated word (McConkie and anticipate the continued development of measures that
Rayner, 1975), foveal mask—masking a region around the exploit pupil dilation signals (El Haj and Moustafa, 2021;
fixated word (Bertera and Rayner, 2000), and Maier and Grueschow, 2021).
boundary—creating pre-defined boundaries (i.e., AOIs) to Another noteworthy development is the emergence of
classify fixations (Rayner, 1975). Over time, these paradigms commodity camera-based eye-tracking (Sewell and
have been extended to tasks such as scene perception. Recarte Komogortsev, 2010; Krafka et al., 2016; Semmelmann and
andNunes(2000)andStapeletal.(2020),forinstance,haveused Weigelt, 2018; Mahanama et al., 2020) systems to further
theboundarymethodtoanalyzeeyemovementsduringdriving democratize eye-tracking research and interaction. Since
tasks and thereby assess the effect of driver awareness on gaze these systems require no dedicated/specialized hardware,
behavior.Inparticular,RecarteandNunes(2000)haveobserved one could explore eye-tracking at a significantly lower
thatdistracteddrivershadhigherfixationdurations,higherpupil cost than otherwise possible. Yet the lack of specialized
dilations, and lower fixation counts in the mirror/speedometer hardware, such as IR illumination or capture, restricts
AOIs compared to control subjects. their capability to only eye tracking, and not
Inpsycholinguisticresearch,pupilmeasureshavebeenusedto pupillometry. The relatively low sampling rates of
analyze the cognitive load of participants in tasks such as commodity cameras may negatively affect the quality of
simultaneous interpretation (Russell, 2005), speech shadowing eye-tracking measures. Overall, eye tracking on
(Marslen-Wilson, 1985), and lexical translation. For instance, commodity hardware provides a cost-effective means of
SeeberandKerzel(2012)measuredthepupildiameterduring incorporating other eye-tracking measures, despite its
simultaneous interpretation tasks, and observed a larger quality being heavily device-dependent. In the future, we
average pupil diameter (indicating a higher cognitive load) anticipate cameras to have higher sampling frequencies
when translating between verb-final and verb-initial (Wang et al., 2021) and resolutions, which, in turn, would
languages, compared to translating between languages of bridge the gap between specialized eye trackers and
the same type. Moreover, Hyönä et al. (1995) measured the commodity camera-based eye tracking systems.
pupil diameter during simultaneous interpretation, speech
shadowing, and lexical translation tasks. They observed a 6.3 Limitations
larger average pupil diameter (indicating a higher cognitive Oneofthemajorlimitationweobservedisthatmoststudiesuse
load) during simultaneous interpretation than speech derivativemeasuresofonlyasingleoculomotoreventinsteadof
shadowing, and also momentary variations in pupil combinationsofmultipleevents.Forinstance,studiesthatuse
diameter (corresponding to spikes in cognitive load) during fixational eye movements generally use only measures
lexical translation. associated with fixations, despite the possible utility of
Moreover,studiesinmarketingandbehavioralfinance,have saccadic information. This limiation is exacerbated with the
used eye-tracking and pupillometric measures to understand confusion on the concepts of fixations and saccades (Hessels
the relationship between presented information and the etal.,2018).Further,moststudiesrelyonfirst-orderstatistical
decision-making process. For instance, Rubaltelli et al. (2016) features(e.g.,histogram-basedfeaturessuchasmin,max,mean,
used pupil diameter to understand investor decision-making, median, sd, and skewness) or trend analysis (e.g., trajectory-
while Ceravolo et al. (2019), Hüsser and Wirth (2014) used based features such as sharpest decrease and sharpest increase
dwell time. Further, studies in marketing have identified between consecutive samples) on the features instead of
FrontiersinComputerScience|www.frontiersin.org 14 January2022|Volume3|Article733531

| Mahanamaetal. |     |     |     |     |     |     |     |     |     | EyeMovementandPupilMeasures |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- |
employing advanced measures. Our study identified some 7 CONCLUSION
specific
| measures | to be | popular | in  |     | domains, | despite | their |     |     |     |     |     |
| -------- | ----- | ------- | --- | --- | -------- | ------- | ----- | --- | --- | --- | --- | --- |
identified,
potential applicability into other domains; for instance, In this paper, we have discussed, and reviewed
pupillary measures are extensively studied in neuroscience existing measures in eye-tracking and pupillometry.
classified
research (Schwalm and Jubal, 2017; Schwiedrzik and Further, we these measures based on the
Sudmann, 2020), but not quite so in psychology research. mechanism of vision; as eye movement, blink, and pupil-
One plausible reason is the lack of literature that aggregates based measures. For each, we provided an overview of the
eyemovementandpupillometricmeasurestoassistresearchers measure,theunderlyingeye-mechanismexploitedbyit,and
howitcanbemeasured.Further,weidentifiedaselectedset
| in identifying |     | additional | measures. |     | Through | this | paper, we |     |     |     |     |     |
| -------------- | --- | ---------- | --------- | --- | ------- | ---- | --------- | --- | --- | --- | --- | --- |
attempt to provide this missing knowledge to researchers. of studies that use each type of measure and documented
| Another | reason | could | be the | computational |     | limitations | of eye | their findings. |     |     |     |     |
| ------- | ------ | ----- | ------ | ------------- | --- | ----------- | ------ | --------------- | --- | --- | --- | --- |
tracking hardware and software. For instance, micro-saccadic This survey aims to help the researchers in two forms.
measuresoftenrequirehigh-frequencyeyetrackers(≥300Hz)
|     |     |     |     |     |     |     |     | First, due | to the utility | of eye-tracking | and | pupillometric |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | -------------- | --------------- | --- | ------------- |
(Krejtz et al., 2018) that are relatively expensive, thereby measures in a broader range ofdomains,theimplications of
imposing hardware-level restrictions. Likewise, intellectual measures/results in other domains can easily be overlooked.
property restrictions (Marshall, 2000) and the lack of public Our study helps to overcome the issue by including
implementations (Duchowski et al., 2018; Duchowski et al., applications and their indications along with each
2020) (i.e., code libraries) of eye tracking solutions impose measure. Further, we believe the body of knowledge in the
software-level restrictions. Both scenarios create an entry studywouldhelpresearcherstochooseappropriatemeasures
barrier for researchers into all applicable eye movement and forafuturestudy.Researcherscouldadaptourtaxonomyto
pupillometrymeasures.Eventhoughwesuggestalternativesfor classify eye-tracking and pupil measures based on the eye
patented measures in this paper, the lack of code libraries still mechanism and vice versa. Moreover, the researchers can
remains unaddressed. identifyparticulareyemechanismsormeasuresexploitedfor
Another limitation is the relatively unexplored research research through the presented classification. Finally, we
avenues of eye-tracking and pupillometric measures in expect this review to serve as a reference for researchers
Extended Reality (XR) environments (Rappa et al., 2019; exploring eye tracking techniques using eye movements
Renner and Pfeiffer, 2017; Clay et al., 2019; Mutasim et al., and pupil measures.
| 2020; Heilmann  |     | and     | Witte, | 2021),    | such as | Virtual | Reality |     |     |     |     |     |
| --------------- | --- | ------- | ------ | --------- | ------- | ------- | ------- | --- | --- | --- | --- | --- |
| (VR), Augmented |     | Reality |        | (AR), and | Mixed   | Reality | (MR).   |     |     |     |     |     |
These extended realities have a broad utility in simulating AUTHOR CONTRIBUTIONS
| real-world | scenarios, |     | often | eliminating | the | requirement | of  |     |     |     |     |     |
| ---------- | ---------- | --- | ----- | ----------- | --- | ----------- | --- | --- | --- | --- | --- | --- |
complex experimental environments (i.e., VR driver BM:Plannedthestructureofthepaperandcontent,carriedout
significant
behavior (Bozkir et al., 2019)). Further, the the review for the survey, organized the entire survey and
control of the reality vested to the experiment designer contributed to writing the manuscript. YJ: Planned the
enables them to simulate complex and rare real-world structure of the paper and content, carried out the review for
events. However, these extended reality scenarios require thesurvey,organizedtheentiresurveyandcontributedtowriting
additional hardware and software to perform eye-tracking. the manuscript. SR: Planned the structure of the paper and
This poses entry barriers for practitioners in the form of content, proofread, and contributed to writing the manuscript.
budgetary constraints (i.e., cost of additional hardware, and GJ: Contributed to writing the Pupillometry measures. LC:
software),knowledgeconstraints(i.e.,experience/knowledge Contributed to proofread, and supervision JS: Contributed to
on XR toolsets), and experimental design (i.e., the structure proofread, and supervision SJ: Idea formation, proofread and
of the experiment, how to simulate and integrate modalities research supervision.
| such as         | touch      | or        | haptics). | We          | suspect     | these       | factors    |         |     |     |     |     |
| --------------- | ---------- | --------- | --------- | ----------- | ----------- | ----------- | ---------- | ------- | --- | --- | --- | --- |
| collectively    | contribute |           | to        | the less    | exploratory |             | studies in |         |     |     |     |     |
| XR eye          | tracking   | research. |           | Considering | the         | possibility | of         | FUNDING |     |     |     |     |
| this technology |            | being     | more      | commonplace |             | (e.g.,      | Microsoft  |         |     |     |     |     |
Hololens21eyetrackingoptics,HTCVIVEProEye2,VARJO
|     |     |     |     |     |     |     |     | This work | is supported | in part by the | U.S. | National Science |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------------ | -------------- | ---- | ---------------- |
VReyetracking3),thiscouldbeanexcellentopportunityfor FoundationgrantCAREERIIS-2045523.Anyopinions,findings
future studies. and conclusion or recommendations expressed in this material
reflect
|     |     |     |     |     |     |     |     | are the author(s) | and | do not necessarily |     | those of the |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | ------------------ | --- | ------------ |
sponsors.
ACKNOWLEDGMENTS
1https://www.microsoft.com/en-us/hololens/hardware
|     |     |     |     |     |     |     |     | We thank | the reviewers | whose comments/suggestions |     | helped |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ------------- | -------------------------- | --- | ------ |
2https://www.vive.com/us/product/vive-pro-eye/overview/
3https://varjo.com/use-center/get-to-know-your-headset/eye-tracking/ improve and clarify this manuscript.
FrontiersinComputerScience|www.frontiersin.org 15 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
REFERENCES StimulusFeaturesinCategorization.J.Exp.Psychol.Learn.Mem.Cogn.35,
1196–1206.doi:10.1037/a0016272
Blount,W.P.(1927).StudiesoftheMovementsoftheEyelidsofAnimals:Blinking.
Abel,L.A.,andHertle,R.W.(1988).“EffectsofPsychoactiveDrugsonOcular Exp.Physiol.18,111–125.doi:10.1113/expphysiol.1927.sp000426
Motor Behavior,” in Neuropsychology of Eye Movements (Hillsdale, NJ: Bojko, A.(2006). Using EyeTracking to Compare Webpage Designs: A Case
LawrenceErlbaumAssociates),81–114. Study.J.UsabilityStud.1,112–120.
Adamczyk, P. D., and Bailey, B. P. (2004). “If Not Now, when? the Effects of Bours,C.C.A.H.,Bakker-Huvenaars,M.J.,Tramper,J.,Bielczyk,N.,Scheepers,
InterruptionatDifferentMomentswithinTaskExecution,”inProceedingsof F.,Nijhof,K.S.,etal.(2018).EmotionalFaceRecognitioninMaleAdolescents
theSIGCHIconferenceonHumanfactorsincomputingsystems,271–278. with Autism Spectrum Disorder or Disruptive Behavior Disorder: an Eye-
Adler,F.H.,andFliegelman,M.(1934).InfluenceofFixationontheVisualAcuity. Tracking Study. Eur. Child. Adolesc. Psychiatry 27, 1143–1157.doi:10.1007/
Arch.Ophthalmol.12,475–483.doi:10.1001/archopht.1934.00830170013002 s00787-018-1174-4
Anderson,N.C.,Bischof,W.F.,Foulsham,T.,andKingstone,A.(2020).Turning Boxer,A.L.,Garbutt,S.,Seeley,W.W.,Jafari,A.,Heuer,H.W.,Mirsky,J.,etal.
the(Virtual)WorldAround:PatternsinSaccadeDirectionVarywithPicture (2012).SaccadeAbnormalitiesinAutopsy-ConfirmedFrontotemporalLobar
OrientationandShapeinVirtualReality.J.Vis.20,21.doi:10.1167/jov.20.8.21 DegenerationandAlzheimerDisease.Arch.Neurol.69,509–517.doi:10.1001/
Andersson,R.,Nyström,M.,andHolmqvist,K.(2010).SamplingFrequencyand archneurol.2011.1021
Eye-TrackingMeasures:HowSpeedAffectsDurations,Latencies,andMore. Bozkir, E., Geisler, D., and Kasneci, E. (2019). “Person Independent, Privacy
J.EyeMove.Res.3.doi:10.16910/jemr.3.3.6 Preserving,andRealTimeAssessmentofCognitiveLoadUsingEyeTrackingin
Ansari,M.F.,Kasprowski,P.,andObetkal,M.(2021).GazeTrackingUsingan aVirtualRealitySetup,”in2019IEEEConferenceonVirtualRealityand3D
UnmodifiedWebCameraandConvolutionalNeuralNetwork.Appl.Sci.11, UserInterfaces(VR)(IEEE),1834–1837.doi:10.1109/vr.2019.8797758
9068.doi:10.3390/app11199068 Braun,D.I.,Pracejus,L.,andGegenfurtner,K.R.(2006).MotionAftereffectElicits
Anson,E.R.,Bigelow,R.T.,Carey,J.P.,Xue,Q.-L.,Studenski,S.,Schubert,M.C., SmoothPursuitEyeMovements.J.Vis.6,1.doi:10.1167/6.7.1
etal.(2016).AgingIncreasesCompensatorySaccadeAmplitudeintheVideo Březinová, V., and Kendell, R. (1977). Smooth Pursuit Eye Movements of
HeadImpulseTest.Front.Neurol.7,113.doi:10.3389/fneur.2016.00113 SchizophrenicsandnormalPeopleunderStress.Br.J.Psychiatry130,59–63.
Ares,G.,Giménez,A.,Bruzzone,F.,Vidal,L.,Antúnez,L.,andMaiche,A.(2013). Brutten,G.J.,andJanssen,P.(1979).AnEye-MarkingInvestigationofAnticipated
Consumer VisualProcessing ofFood Labels: Results froman Eye-Tracking andObserved Stuttering. J.SpeechLang. Hear.Res.22,20–28.doi:10.1044/
Study.J.SensStud.28,138–153.doi:10.1111/joss.12031 jshr.2201.20
Bahill,A.T.,Clark,M.R.,andStark,L.(1975).TheMainSequence,aToolfor Buonocore,A.,Chen,C.-Y.,Tian,X.,Idrees,S.,Münch,T.A.,andHafed,Z.M.
StudyingHumanEyeMovements.Math.biosciences24,191–204.doi:10.1016/ (2017). Alteration of the Microsaccadic Velocity-Amplitude Main Sequence
0025-5564(75)90075-9 Relationship after Visual Transients: Implications for Models of Saccade
Bahill,A.T.,andLaritz,T.(1984).WhyCan’tBattersKeepTheirEyesontheball. Control.J.Neurophysiol.117,1894–1910.doi:10.1152/jn.00811.2016
Am.Scientist72,249–253. Buonocore,A.,McIntosh,R.D.,andMelcher,D.(2016).BeyondthepointofNo
Bailey,B.P.,andIqbal,S.T.(2008).UnderstandingChangesinMentalWorkload Return: Effects of Visual Distractors on Saccade Amplitude and Velocity.
duringExecutionofGoal-DirectedTasksanditsApplicationforInterruption J.Neurophysiol.115,752–762.doi:10.1152/jn.00939.2015
Management. ACM Trans. Comput.-Hum. Interact. 14, 1–28. doi:10.1145/ Burke,M.R.,andBarnes,G.R.(2006).QuantitativeDifferencesinSmoothPursuit
1314683.1314689 and Saccadic Eye Movements. Exp. Brain Res. 175, 596–608. doi:10.1007/
Barbosa,P.,Kaski,D.,Castro,P.,Lees,A.J.,Warner,T.T.,andDjamshidian,A.(2019). s00221-006-0576-6
SaccadicDirectionErrorsAreAssociatedwithImpulsiveCompulsiveBehavioursin Burr, D. C., Morrone, M. C., and Ross, J. (1994). Selective Suppression of the
Parkinson’sDiseasePatients.Jpd9,625–630.doi:10.3233/jpd-181460 MagnocellularVisualPathwayduringSaccadicEyeMovements.Nature371,
Barmack,N.H.(1970).ModificationofEyeMovementsbyInstantaneousChanges 511–513.doi:10.1038/371511a0
intheVelocityofVisualTargets.Vis.Res.10,1431–1441.doi:10.1016/0042- Buswell,G.T.(1935).HowPeopleLookatPictures:AStudyofthePsychologyand
6989(70)90093-3 PerceptioninArt.Chicago:Univ.ChicagoPress.
Barnes,G.R.,andAsselman,P.T.(1991).TheMechanismofPredictioninHuman Cardona,G.,García,C.,Serés,C.,Vilaseca,M.,andGispets,J.(2011).BlinkRate,
Smooth Pursuit Eye Movements. J. Physiol. 439, 439–461. doi:10.1113/ Blink Amplitude, and Tear Film Integrity during Dynamic Visual Display
jphysiol.1991.sp018675 Terminal Tasks. Curr. Eye Res. 36, 190–197. doi:10.3109/
Barnes, G. R. (2008). Cognitive Processes Involved in Smooth Pursuit Eye 02713683.2010.544442
Movements.BrainCogn.68,309–326.doi:10.1016/j.bandc.2008.08.020 Carl,J.R.,andGellman,R.S.(1987).HumanSmoothPursuit:Stimulus-dependent
Bartels,M.,andMarshall,S.P.(2012).“MeasuringCognitiveWorkloadacross Responses.J.Neurophysiol.57,1446–1463.doi:10.1152/jn.1987.57.5.1446
DifferentEyeTrackingHardwarePlatforms,”inProceedingsofthesymposium Carpenter,R.H.(1988).MovementsoftheEyes.2ndRevPionLimited.
on eye tracking research and applications, 161–164. doi:10.1145/ Castello,E.,Baroni,N.,andPallestrini,E.(1998).NeurotologicalandAuditory
2168556.2168582 Brain Stem Response Findings in Human Immunodeficiency Virus-Positive
Becker,W.,andFuchs,A.F.(1969).FurtherPropertiesoftheHumanSaccadic PatientswithoutNeurologicManifestations.Ann.OtolRhinolLaryngol.107,
System: Eye Movements and Correction Saccades with and without Visual 1054–1060.doi:10.1177/000348949810701210
FixationPoints.Vis.Res.9,1247–1258.doi:10.1016/0042-6989(69)90112-6 Catherine,L.,andJames,M.(2001).EducatingChildrenwithAutism.Washington,
Bednarik,R.,Myller,N.,Sutinen,E.,andTukiainen,M.(2005).“ApplyingEye- DC:NationalAcademiesPress.
MovememtTrackingtoProgramVisualization,”in2005IEEESymposiumon Ceder,A.(1977).Drivers’EyeMovementsasRelatedtoAttentioninSimulated
Visual Languages and Human-Centric Computing (VL/HCC’05) (IEEE), Traffic Flow Conditions. Hum. Factors 19, 571–581. doi:10.1177/
302–304. 001872087701900606
Bertera,J.H.,andRayner,K.(2000).EyeMovementsandtheSpanoftheEffective Ceravolo,M.G.,Farina,V.,Fattobene,L.,Leonelli,L.,andRaggetti,G.(2019).
Stimulus in Visual Search. Perception & Psychophysics 62, 576–585. PresentationalFormatandFinancialConsumers’Behaviour:anEye-Tracking
doi:10.3758/bf03212109 Study.Int.J.BankMarketing37(3),821–837.doi:10.1108/ijbm-02-2018-0041
Birmingham,E.,Bischof,W.F.,andKingstone,A.(2008).SocialAttentionand Chen,S.,andEpps,J.(2014).UsingTask-InducedPupilDiameterandBlinkRate
Real-WorldScenes:TheRolesofAction,CompetitionandSocialContent.Q. to Infer Cognitive Load. Human-Computer Interaction 29, 390–413.
J.Exp.Psychol.61,986–998.doi:10.1080/17470210701410375 doi:10.1080/07370024.2014.892428
Biscaldi,M.,Gezeck,S.,andStuhr,V.(1998).PoorSaccadicControlCorrelates Cherng, Y. G., Baird, T., Chen, J. T., and Wang, C. A. (2020). Background
with Dyslexia. Neuropsychologia 36, 1189–1202. doi:10.1016/s0028-3932(97) Luminance Effects on Pupil Size Associated with Emotion and Saccade
00170-x Preparation.Sci.Rep.10,1–11.doi:10.1038/s41598-020-72954-z
Blair,M.R.,Watson,M.R.,Walshe,R.C.,andMaj,F.(2009).ExtremelySelective Cho,S.-J.,Brown-Schmidt,S.,andLee,W.-y.(2018).AutoregressiveGeneralized
Attention: Eye-Tracking Studies of the Dynamic Allocation of Attention to LinearMixedEffectModelswithCrossedRandomEffects:AnApplicationto
FrontiersinComputerScience|www.frontiersin.org 16 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
IntensiveBinaryTimeSeriesEye-TrackingData.Psychometrika83,751–771. Dodge,R.(1903).FiveTypesofEyeMovementintheHorizontalmeridianPlaneof
doi:10.1007/s11336-018-9604-2 theFieldofRegard.Am.J.physiology-legacycontent8,307–329.doi:10.1152/
Choi,J.E.S.,Vaswani,P.A.,andShadmehr,R.(2014).VigorofMovementsand ajplegacy.1903.8.4.307
theCostofTimeinDecisionMaking.J.Neurosci.34,1212–1223.doi:10.1523/ Dodge, R. (1900). Visual Perception during Eye Movement. Psychol. Rev. 7,
jneurosci.2798-13.2014 454–465.doi:10.1037/h0067215
Chu,C.A.,Rosenfield,M.,andPortello,J.K.(2014).BlinkPatterns.Optom.Vis. Donovan, T., and Litchfield, D. (2013). Looking for Cancer: Expertise Related
Sci.91,297–302.doi:10.1097/opx.0000000000000157 DifferencesinSearchingandDecisionMaking.Appl.Cognit.Psychol.27,43–49.
Churchland,A.K.,andLisberger,S.G.(2002).GainControlinHumanSmooth- doi:10.1002/acp.2869
Pursuit Eye Movements. J. Neurophysiol. 87, 2936–2945. doi:10.1152/ Doughty,M.J.(2001).ConsiderationofThreeTypesofSpontaneousEyeblink
jn.2002.87.6.2936 ActivityinnormalHumans:duringreadingandVideoDisplayTerminalUse,
Clay,V.,König,P.,andKönig,S.(2019).EyeTrackinginVirtualReality.J.EyeMov in Primary Gaze, and while in Conversation. Optom. Vis. Sci. 78, 712–725.
Res.12.doi:10.16910/jemr.12.1.3 doi:10.1097/00006324-200110000-00011
Coeckelbergh,T.R.M.,Brouwer,W.H.,Cornelissen,F.W.,VanWolffelaar,P., Doughty, M. J. (2019). Effect of Distance Vision and Refractive Error on the
andKooijman, A.C.(2002).The Effect ofVisualFieldDefects onDriving Spontaneous Eye Blink Activity in Human Subjects in Primary Eye Gaze.
Performance. Arch. Ophthalmol. 120, 1509–1516. doi:10.1001/ J.Optom.12,111–119.doi:10.1016/j.optom.2018.03.004
archopht.120.11.1509 Doughty,M.J.(2002).FurtherAssessmentofGender-andBlinkPattern-Related
Coëffé,C.,andO’regan,J.K.(1987).ReducingtheInfluenceofNon-targetStimuli DifferencesintheSpontaneousEyeblinkActivityinPrimaryGazeinYoung
onSaccadeAccuracy:PredictabilityandLatencyEffects.Vis.Res.27,227–240. Adult Humans. Optom. Vis. Sci. 79, 439–447. doi:10.1097/00006324-
doi:10.1016/0042-6989(87)90185-4 200207000-00013
Collewijn,H.,andTamminga,E.P.(1984).HumanSmoothandSaccadicEye Doughty,M.J.,andNaase,T.(2006).FurtherAnalysisoftheHumanSpontaneous
Movements during Voluntary Pursuit of Different Target Motions on EyeBlinkRatebyaClusterAnalysis-BasedApproachtoCategorizeIndividuals
Different Backgrounds. J. Physiol. 351, 217–250. doi:10.1113/ with ’Normal’ versus ’Frequent’ Eye Blink Activity. Eye & contact lens 32,
jphysiol.1984.sp015242 294–299.doi:10.1097/01.icl.0000224359.32709.4d
Connolly, J.D., Goodale, M.A., Goltz, H. C., and Munoz, D. P. (2005). Fmri Du,P.,andMacDonald,E.F.(2014).Eye-trackingDataPredictImportanceof
ActivationintheHumanFrontalEyeFieldIsCorrelatedwithSaccadicReaction ProductFeaturesandSaliencyofSizeChange.J.Mech.Des.136.doi:10.1115/
Time.J.Neurophysiol.94,605–611.doi:10.1152/jn.00830.2004 1.4027387
Cornsweet,T.N.(1956).DeterminationoftheStimuliforInvoluntaryDriftsand Duchowski,A.T.(2002).ABreadth-FirstSurveyofEye-TrackingApplications.
Saccadic Eye Movements*. J. Opt. Soc. Am. 46, 987–993. doi:10.1364/ Behav.Res.MethodsInstr.Comput.34,455–470.doi:10.3758/BF03195475
josa.46.000987 Duchowski,A.T.(2017).EyeTrackingMethodology:TheoryandPractice.Springer.
Costa,M.,Simone,A.,Vignali,V.,Lantieri,C.,andPalena,N.(2018).Fixation Duchowski,A.T.,Krejtz,K.,Gehrer,N.A.,Bafna,T.,andBækgaard,P.(2020).
DistanceandFixationDurationtoVerticalRoadSigns.Appl.Ergon.69,48–57. “TheLow/highindexofPupillaryActivity,”inProceedingsofthe2020CHI
doi:10.1016/j.apergo.2017.12.017 Conference on Human Factors in Computing Systems, 1–12. doi:10.1145/
Crevits,L.,Simons,B.,andWildenbeest,J.(2003).EffectofSleepDeprivationon 3313831.3376394
SaccadesandEyelidBlinking.Eur.Neurol.50,176–180.doi:10.1159/000073060 Duchowski,A.T.,Krejtz,K.,Krejtz,I.,Biele,C.,Niedzielska,A.,Kiefer,P.,etal.
Daugherty, B. C., Duchowski, A. T., House, D. H., and Ramasamy, C. (2010). (2018).“TheindexofPupillaryActivity:MeasuringCognitiveLoadVis-À-Vis
“MeasuringVergenceoverStereoscopicVideowithaRemoteEyeTracker,”in Task Difficulty with Pupil Oscillation,” in Proceedings of the 2018 CHI
Proceedingsofthe2010SymposiumonEye-TrackingResearch&Applications, ConferenceonHumanFactorsinComputingSystems,1–13.
97–100.doi:10.1145/1743666.1743690 Duncan,J.,Ward,R.,andShapiro,K.(1994).DirectMeasurementofAttentional
Day,B.L.,andFitzpatrick,R.C.(2005).TheVestibularSystem.Curr.Biol.15, DwellTimeinHumanVision.Nature369,313–315.doi:10.1038/369313a0
R583–R586.doi:10.1016/j.cub.2005.07.053 Duret, F., Buquet, C., Charlier, J., Mermoud, C., Viviani, P., andSafran, A.B.
de Brouwer, S., Missal, M., and Lefèvre, P. (2001). Role of Retinal Slip in the (1999).RefixationStrategiesinFourPatientswithMacularDisorders.Neuro-
Prediction of Target Motion during Smooth and Saccadic Pursuit. Ophthalmology22,209–220.doi:10.1076/noph.22.4.209.3718
J.Neurophysiol.86,550–558.doi:10.1152/jn.2001.86.2.550 Eberhard, K. M., Spivey-Knowlton, M. J., Sedivy, J. C., and Tanenhaus, M. K.
DeBrouwer,S.,Yuksel,D.,Blohm,G.,Missal,M.,andLefèvre,P.(2002).What (1995). Eye Movements as a Window into Real-Time Spoken Language
Triggers Catch-Up Saccades during Visual Tracking. J. Neurophysiol. 87, Comprehension in Natural Contexts. J. Psycholinguist Res. 24, 409–436.
1646–1650.doi:10.1152/jn.00432.2001 doi:10.1007/bf02143160
DeBruin, J.,Malan,K.,andEloff,J.(2013).“Saccade DeviationIndicatorsfor Ebitz, R. B., and Moore, T. (2019). Both a Gauge and a Filter: Cognitive
AutomatedEyeTrackingAnalysis,”inProceedingsofthe2013conferenceon ModulationsofPupilSize.Front.Neurol.9,1190.doi:10.3389/fneur.2018.01190
eyetrackingsouthafrica,47–54.doi:10.1145/2509315.2509324 ElHaj,M.,andMoustafa,A.A.(2021).PupilDilationasanIndicatorofFuture
de Hemptinne, C., Lefèvre, P., and Missal, M. (2006). Influence of Cognitive Thinking.Neurol.Sci.42,647–653.doi:10.1007/s10072-020-04533-z
Expectation on the Initiation of Anticipatory and Visual Pursuit Eye Eldar,E.,Cohen,J.D.,andNiv,Y.(2013).TheEffectsofNeuralGainonAttention
Movements in the Rhesus Monkey. J. Neurophysiol. 95, 3770–3782. andLearning.Nat.Neurosci.16,1146–1153.doi:10.1038/nn.3428
doi:10.1152/jn.00007.2006 Ellis,S.,Candrea,R.,Misner,J.,Craig,C.S.,Lankford,C.P.,andHutchinson,T.E.
Dell’Osso, L. F., Van der Steen, J., Steinman, R. M., and Collewijn, H. (1992). (1998).“WindowstotheSoul?whatEyeMovementsTellUsaboutSoftware
Foveation Dynamics in Congenital Nystagmus. II: Smooth Pursuit. Doc Usability,”inProceedingsoftheusabilityprofessionals’associationconference,
Ophthalmol.79,25–49.doi:10.1007/BF00160131 151–178.
Demberg,V.,Kiagia,E.,andSayeed,A.(2013).TheindexofCognitiveActivityasa Essig, K., Pomplun, M.,and Ritter, H. (2004). “Application ofa Novel Neural
MeasureofLinguisticProcessing.readingtime500,1500. Approach to 3d Gaze Tracking,” in Vergence Eye-Movements in
Demberg,V.(2013).“Pupillometry:theindexofCognitiveActivityinaDual-Task Autostereograms,26. eScholarship.
Study,”inProceedingsoftheAnnualMeetingoftheCognitiveScienceSociety, Ettinger,U.,Kumari,V.,Chitnis,X.A.,Corr,P.J.,Sumich,A.L.,Rabe-Hesketh,S.,
2154–2159.35 et al. (2002). Relationship between Brain Structure and Saccadic Eye
Dimigen, O., Valsecchi, M., Sommer, W., and Kliegl, R. (2009). Human Movements in Healthy Humans. Neurosci. Lett. 328, 225–228. doi:10.1016/
Microsaccade-RelatedVisualBrainResponses.J.Neurosci.29,12321–12331. s0304-3940(02)00517-7
doi:10.1523/jneurosci.0911-09.2009 Farbos,B.,Mollard,R.,Cabon,P.,andDavid,H.(2000).“MeasurementofFatigue
Ditchburn,R.W.,andGinsborg,B.L.(1953).InvoluntaryEyeMovementsduring andAdaptationinLarge-ScaleReal-TimeAtcSimulation,”inProceedingsof
Fixation.J.Physiol.119,1–17.doi:10.1113/jphysiol.1953.sp004824 theHumanFactorsandErgonomicsSocietyAnnualMeeting,LosAngeles,CA
Dobson,M.W.(1977).EyeMovementParametersandMapreading.TheAm. (Los Angeles, CA: SAGE Publications Sage CA), 3–204. doi:10.1177/
Cartographer4,39–58.doi:10.1559/152304077784080022 154193120004401905
FrontiersinComputerScience|www.frontiersin.org 17 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
Fehringer,B.C.O.F.(2021).OptimizingtheUsageofPupillaryBasedIndicators He, Y., Su, Q., Wang, L., He, W., Tan, C., Zhang, H., et al. (2019). The
forCognitiveWorkload.J.EyeMovRes.14.doi:10.16910/jemr.14.2.4 Characteristics of Intelligence Profile and Eye Gaze in Facial Emotion
Fehringer,B.C.(2020).“OneThresholdtoRuleThemAll?Modificationofthe Recognition in Mild and Moderate Preschoolers with Autism Spectrum
indexofPupillaryActivitytoOptimizetheIndicationofCognitiveLoad,”in Disorder.Front.Psychiatry10,402.doi:10.3389/fpsyt.2019.00402
ACMSymposiumonEyeTrackingResearchandApplications,1–5. Heilmann, F., and Witte, K. (2021). Perception and Action under Different
Findlay,J.M.,Walker,R.,andKentridge,R.W.(1995).EyeMovementResearch: StimulusPresentations:AReviewofEye-TrackingStudieswithanExtended
Mechanisms,ProcessesandApplications.Elsevier. View on Possibilities of Virtual Reality. Appl. Sci. 11, 5546. doi:10.3390/
Fischer,B.,andBreitmeyer,B.(1987).MechanismsofVisualAttentionRevealedby app11125546
Saccadic Eye Movements. Neuropsychologia 25, 73–83. doi:10.1016/0028- Hejtmancik,J.F.,Cabrera,P.,Chen,Y.,M’Hamdi,O.,andNickerson,J.M.(2017).
3932(87)90044-3 “Vision,”inConn’sTranslationalNeuroscience.EditorP.M.Conn(SanDiego:
Fischer,B.,andWeber,H.(1993).ExpressSaccadesandVisualAttention.Behav. AcademicPress),399–438.doi:10.1016/B978-0-12-802381-5.00031-2
BrainSci.16,553–567.doi:10.1017/s0140525x00031575 Heminghous, J., and Duchowski, A. T. (2006). “Icomp: a Tool for Scanpath
Fisher,D.F.,Monty,R.A.,andSenders,J.W.(2017).EyeMovements:Cognition Visualization and Comparison,” in Proceedings of the 3rd Symposium on
andVisualPerception,Vol.8.Oxfordshire,England,UK:Routledge. AppliedPerceptioninGraphicsandVisualization,152.
Foulsham, T., Kingstone, A., and Underwood, G. (2008). Turning the World Henderson,J.M.,Choi,W.,Luke,S.G.,andSchmidt,J.(2018).NeuralCorrelates
Around:PatternsinSaccadeDirectionVarywithPictureOrientation.Vis.Res. of Individual Differences in Fixation Duration during Natural reading. Q.
48,1777–1790.doi:10.1016/j.visres.2008.05.018 J.Exp.Psychol.71,314–323.doi:10.1080/17470218.2017.1329322
Fukushima,K.,Fukushima,J.,Warabi,T.,andBarnes,G.R.(2013).Cognitive Hess,E.H.,andPolt,J.M.(1964).PupilSizeinRelationtoMentalActivityduring
ProcessesInvolvedinSmoothPursuitEyeMovements:BehavioralEvidence, Simple Problem-Solving. Science 143, 1190–1192. doi:10.1126/
Neural Substrate and Clinical Correlation. Front. Syst. Neurosci. 7, 4. science.143.3611.1190
doi:10.3389/fnsys.2013.00004 Hessels,R.S.,andHooge,I.T.C.(2019).EyeTrackinginDevelopmentalCognitive
Galley,N.,Schleicher,R.,andGalley,L.(2004).BlinkParametersasIndicators Neuroscience - the Good, the Bad and the Ugly. Dev. Cogn. Neurosci. 40,
of Driver’s Sleepiness–Possibilities and Limitations. Vis. vehicles 10, 100710.doi:10.1016/j.dcn.2019.100710
189–196. Hessels,R.S.,Kemner,C.,vandenBoomen,C.,andHooge,I.T.C.(2016).The
Galley,N.(1993).TheEvaluationoftheElectrooculogramasaPsychophysiological Area-Of-InterestProbleminEyetrackingResearch:ANoise-RobustSolution
MeasuringInstrumentintheDriverStudyofDriverBehaviour.Ergonomics36, forFaceandSparseStimuli.Behav.Res.48,1694–1712.doi:10.3758/s13428-
1063–1070.doi:10.1080/00140139308967978 015-0676-y
Gbadamosi,J.,andZangemeister,W.H.(2001).VisualImageryinHemianopic Hessels,R.S.,Niehorster,D.C.,Nyström,M.,Andersson,R.,andHooge,I.T.C.
Patients.J.Cogn.Neurosci.13,855–866.doi:10.1162/089892901753165782 (2018).IstheEye-MovementFieldConfusedaboutFixationsandSaccades?A
Goldberg,J.H.,andHelfman,J.I.(2010).“ScanpathClusteringandAggregation,” Survey Among 124 Researchers. R. Soc. Open Sci., 180502. doi:10.1098/
inProceedingsofthe2010symposiumoneye-trackingresearch&applications, rsos.180502
227–234.doi:10.1145/1743666.1743721 HoangDuc,A.,Bays,P.,andHusain,M.(2008).EyeMovementsasaProbeof
Goldberg,J.H.,andKotval,X.P.(1999).ComputerInterfaceEvaluationUsingEye Attention.Prog.BrainRes.171,403–411.doi:10.1016/s0079-6123(08)00659-6
Movements: Methods and Constructs. Int. J. Ind. Ergon. 24, 631–645. Holland, C., andKomogortsev, O.V.(2011). “Biometric Identification viaEye
doi:10.1016/s0169-8141(98)00068-7 MovementScanpathsinreading,”in2011Internationaljointconferenceon
Goldberg, J. H., and Wichansky, A. M. (2003). “Eye Tracking in Usability biometrics(IJCB),1–8.doi:10.1109/ijcb.2011.6117536IEEE
Evaluation,”inTheMind’sEye.EditorsJ.Hyönä,R.Radach,andH.Deubel Holmqvist,K.,Nyström,M.,Andersson,R.,Dewhurst,R.,Jarodzka,H.,andVan
(Amsterdam: North-Holland), 493–516. doi:10.1016/B978-044451020-4/ deWeijer,J.(2011).EyeTracking:AComprehensiveGuidetoMethodsand
50027-X Measures.Oxford,UK:OUPOxford.
Goldberg, J. M., and Fernández, C. (1984). The Vestibular System. Handbook Horley,K.,Williams,L.M.,Gonsalvez,C.,andGordon,E.(2003).SocialPhobics
Physiol.3,977–1022.doi:10.1002/cphy.cp010321 Do Not See Eye to Eye:. J. anxiety Disord. 17, 33–44. doi:10.1016/s0887-
Goldberg, M. E., Eggers, H., and Gouras, P. (1991). The Oculomotor System. 6185(02)00180-9
PrinciplesNeuralSci.,660–676. Hubel,D.H.(1995).Eye,Brain,andVision.ScientificAmericanLibrary/Scientific
Gray,L.S.,Winn,B.,andGilmartin,B.(1993).AccommodativeMicrofluctuations AmericanBooks.
and Pupil Diameter. Vis. Res. 33, 2083–2090. doi:10.1016/0042-6989(93) Hubel,D.H.,andWiesel,T.N.(1979).BrainMechanismsofVision.Sci.Am.241,
90007-j 150–162.doi:10.1038/scientificamerican0979-150
Griffiths, A., Marshall, R., and Richens, A. (1984). Saccadic Eye Movement Hüsser,A.,andWirth,W.(2014).DoinvestorsShowanAttentionalBiastoward
Analysis as a Measure of Drug Effects on Human Psychomotor PastPerformance?anEye-TrackingexperimentonVisualAttentiontoMutual
Performance. Br. J. Clin. Pharmacol. 18, 73S–82S. doi:10.1111/j.1365- FundDisclosuresinSimplifiedFundProspectuses.J.Financ.Serv.Mark19,
2125.1984.tb02584.x 169–185.doi:10.1057/fsm.2014.20
Grindinger,T.J.,Murali,V.N.,Tetreault,S.,Duchowski,A.T.,Birchfield,S.T., Hyönä,J.,Tommola,J.,andAlaja,A.-M.(1995).PupilDilationasaMeasureof
andOrero,P.(2010).“AlgorithmforDiscriminatingAggregateGazePoints: ProcessingLoadinSimultaneousInterpretationandOtherLanguageTasks.
Comparison with Salient Regions-Of-Interest,” in Asian Conference on TheQ.J.Exp.Psychol.SectionA48,598–612.doi:10.1080/14640749508401407
ComputerVision(Springer),390–399. Iqbal,S.T.,Zheng,X.S.,andBailey,B.P.(2004).“Task-evokedPupillaryResponse
Guillon,Q.,Afzali,M.H.,Rogé,B.,Baduel,S.,Kruck,J.,andHadjikhani,N.(2015). toMentalWorkloadinHuman-ComputerInteraction,”inCHI’04Extended
The Importance of Networking in Autism Gaze Analysis. PLoS one 10, AbstractsonHumanFactorsinComputingSystems,1477–1480.doi:10.1145/
e0141191.doi:10.1371/journal.pone.0141191 985921.986094
Guo,F.,Ding,Y.,Liu,W.,Liu,C.,andZhang,X.(2016).CanEye-TrackingDataBe Jacob, R. J. K., and Karn, K. S. (2003). “Eye Tracking in Human-Computer
MeasuredtoAssessProductDesign?:VisualAttentionMechanismShouldBe Interaction and Usability Research,” in The Mind’s Eye. Editors J. Hyönä,
Considered.Int.J.Ind.Ergon.53,229–235.doi:10.1016/j.ergon.2015.12.001 R.Radach,andH.Deubel(Amsterdam:North-Holland),573–605.doi:10.1016/
Hafed,Z.M.,Chen,C.-Y.,andTian,X.(2015).Vision,Perception,andAttention B978-044451020-4/50031-1
throughtheLensofMicrosaccades:MechanismsandImplications.Front.Syst. Jainta,S.,Vernet,M.,Yang,Q.,andKapoula,Z.(2011).ThePupilReflectsMotor
Neurosci.9,167.doi:10.3389/fnsys.2015.00167 PreparationforSaccades-EvenbeforetheEyeStartstoMove.Front.Hum.
Hafed,Z.M.,andClark,J.J.(2002).MicrosaccadesasanOvertMeasureofcovert Neurosci.5,97.doi:10.3389/fnhum.2011.00097
AttentionShifts.Vis.Res.42,2533–2545.doi:10.1016/s0042-6989(02)00263-8 Jarodzka, H., Holmqvist, K., and Nyström, M. (2010). “A Vector-Based,
Hauland, G.,andDuijm, N.(2002).“EyeMovement Based MeasuresofTeam MultidimensionalScanpathSimilarityMeasure,”inProceedingsofthe2010
SituationAwareness(Tsa),”inJapan-haldenMMSWorkshop(Kyoto,Japan: symposium on eye-tracking research & applications, 211–218. doi:10.1145/
KyotoUniversity),82–85. 1743666.1743718
FrontiersinComputerScience|www.frontiersin.org 18 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
Jayawardena, G., and Jayarathna, S. (2021). “Automated Filtering of Eye Symposium on Eye Tracking Research and Applications, 159–166.
Movements Using Dynamic Aoi in Multiple Granularity Levels,” in doi:10.1145/2578153.2578176
International Journal of Multimedia Data Engineering and Management Krupinski, E. A. (1996). Visual Scanning Patterns of Radiologists Searching
(IJMDEM),12,49–64.doi:10.4018/ijmdem.2021010104 Mammograms.Acad.Radiol.3,137–144.doi:10.1016/s1076-6332(05)80381-2
Jayawardena,G.,Michalek,A.,Duchowski,A.,andJayarathna,S.(2020).“Pilot Ladda,J.,Eggert,T.,Glasauer,S.,andStraube,A.(2007).VelocityScalingofCue-
StudyofAudiovisualSpeech-In-Noise(Sin)PerformanceofYoungAdultswith InducedSmoothPursuitAccelerationObeysConstraintsofNaturalMotion.
Adhd,”inACMSymposiumonEyeTrackingResearchandApplications,1–5. Exp.BrainRes.182,343–356.doi:10.1007/s00221-007-0988-y
doi:10.1145/3379156.3391373 Lai, H. Y., Saavedra-Pena, G., Sodini, C. G., Sze, V., and Heldt, T. (2019).
Jensen,K.,Beylergil,S.B.,andShaikh,A.G.(2019).SlowSaccadesinCerebellar Measuring Saccade Latency Using Smartphone Cameras. IEEE J. Biomed.
Disease.cerebellumataxias6,1–9.doi:10.1186/s40673-018-0095-9 HealthInform.24,885–897.doi:10.1109/JBHI.2019.2913846
Jiang, M.-Q. (1996). The Role of Attention Mechanisms in Smooth Pursuit Land,M.F.,andFurneaux,S.(1997).TheKnowledgeBaseoftheOculomotor
Performance in normal and Schizophrenic Subjects. Iowa City, IA: The System.Phil.Trans.R.Soc.Lond.B352,1231–1239.doi:10.1098/rstb.1997.0105
UniversityofIowa. LeMeur,O.,Coutrot,A.,Liu,Z.,Rämä,P.,LeRoch,A.,andHelo,A.(2017).Visual
Jongkees,B.J.,andColzato,L.S.(2016).SpontaneousEyeBlinkRateasPredictor AttentionSaccadicModelsLearntoEmulateGazePatternsfromChildhoodto
ofDopamine-RelatedCognitiveFunction-AReview.Neurosci.Biobehavioral Adulthood. IEEE Trans. Image Process. 26, 4777–4789. doi:10.1109/
Rev.71,58–82.doi:10.1016/j.neubiorev.2016.08.020 tip.2017.2722238
Joshi,S.,Li,Y.,Kalwani,R.M.,andGold,J.I.(2016).Relationshipsbetween Lee,K.I.,Jeon,J.H.,andSong,B.C.(2020).“DeepLearning-BasedPupilcenter
PupilDiameterandNeuronalActivityintheLocusCoeruleus,Colliculi, DetectionforFastandAccurateEyeTrackingSystem,”inEuropeanConference
and Cingulate Cortex. Neuron 89, 221–234. doi:10.1016/ onComputerVision(Springer),36–52.doi:10.1007/978-3-030-58529-7_3
j.neuron.2015.11.028 Lehtinen, I., Lang, A. H., Jäntti, V., and Keskinen, E. (1979). Acute Effects of
Kao,G.W.,andMorrow,M.J.(1994).TheRelationshipofAnticipatorySmooth Alcohol on Saccadic Eye Movements. Psychopharmacology 63, 17–23.
Eye Movement to Smooth Pursuit Initiation. Vis. Res. 34, 3027–3036. doi:10.1007/bf00426915
doi:10.1016/0042-6989(94)90276-3 Lisberger,S.G.,Morris,E.,andTychsen,L.(1987).VisualMotionProcessingand
Karsh, R., and Breitenbach, F. (1983). Looking at Looking: The Amorphous Sensory-Motor IntegrationforSmoothPursuitEyeMovements.Annu.Rev.
Fixation Measure. Eye movements Psychol. functions: Int. views, 53–64. Neurosci.10(1),97–129.doi:10.1146/annurev.ne.10.030187.000525
doi:10.4324/9781003165538-6 Lisi,M.,Solomon,J.A.,andMorgan,M.J.(2019).GainControlofSaccadicEye
Killian,N.J.,Potter,S.M.,andBuffalo,E.A.(2015).SaccadeDirectionEncodingin Movements Is Probabilistic. Proc. Natl. Acad. Sci. USA 116, 16137–16142.
thePrimateEntorhinalCortexduringVisualExploration.Proc.Natl.Acad.Sci. doi:10.1073/pnas.1901963116
USA112,15743–15748.doi:10.1073/pnas.1417059112 MacAskill,M.R.,Anderson,T.J.,andJones,R.D.(2002).AdaptiveModificationof
Kimble, M. O., Fleming, K., Bandy, C., Kim, J., and Zambetti, A. (2010). Eye SaccadeAmplitudeinParkinson’sDisease.Brain125,1570–1582.doi:10.1093/
TrackingandVisualAttentiontoThreatingStimuliinVeteransoftheiraqWar. brain/awf168
J.anxietyDisord.24,293–299.doi:10.1016/j.janxdis.2009.12.006 Macdonald, J. S. P., and Lavie, N. (2011). Visual Perceptual Load Induces
Knox, P. C., and Wolohan, F. D. A. (2014). Cultural Diversity and Saccade Inattentional Deafness. Atten Percept Psychophys 73, 1780–1789.
Similarities:CultureDoesNotExplainSaccadeLatencyDifferencesbetween doi:10.3758/s13414-011-0144-4
Chinese and Caucasian Participants. PloS one 9, e94424. doi:10.1371/ Maffei,A.,andAngrilli,A.(2019).SpontaneousBlinkRateasanindexofAttention
journal.pone.0094424 and Emotion during Film Clips Viewing. Physiol. Behav. 204, 256–263.
Komogortsev,O.,Holland,C.,Jayarathna,S.,andKarpov,A.(2013).2DLinear doi:10.1016/j.physbeh.2019.02.037
OculomotorPlantMathematicalModel.ACMTrans.Appl.Percept.10,1–18. Mahanama,B.,Jayawardana,Y.,andJayarathna,S.(2020).“Gaze-net:Appearance-
doi:10.1145/2536764.2536774 BasedGazeEstimationUsingCapsuleNetworks,”inProceedingsofthe11th
Komogortsev, O. V., Jayarathna, S., Koh, D. H., and Gowda, S. M. (2010). AugmentedHumanInternationalConference,1–4.
“QualitativeandQuantitativeScoringandEvaluationoftheEyeMovement Maier,J.X.,andGroh,J.M.(2009).MultisensoryGuidanceofOrientingBehavior.
Classification Algorithms,” in Proceedings of the 2010 Symposium on eye- HearingRes.258,106–112.doi:10.1016/j.heares.2009.05.008
trackingresearch&applications,65–68.doi:10.1145/1743666.1743682 Maier,S.U.,andGrueschow,M.(2021).PupilDilationPredictsIndividualSelf-
Korbach,A.,Brünken,R.,andPark,B.(2018).DifferentiatingDifferentTypesof RegulationsuccessacrossDomains.Sci.Rep.11,1–18.doi:10.1038/s41598-021-
CognitiveLoad:AComparisonofDifferentMeasures.Educ.Psychol.Rev.30, 93121-y
503–529.doi:10.1007/s10648-017-9404-8 Mania,K.,McNamara,A.,andPolychronakis,A.(2021).“Gaze-awareDisplays
Korbach,A.,Brünken,R.,andPark,B.(2017).MeasurementofCognitiveLoadin and Interaction,” in ACM SIGGRAPH 2021 Courses, 1–67. doi:10.1145/
MultimediaLearning:aComparisonofDifferentObjectiveMeasures.Instr.Sci. 3450508.3464606
45,515–536.doi:10.1007/s11251-017-9413-5 Marshall,S.P.(2007).IdentifyingCognitiveStatefromEyeMetrics.AviatSpace
Koster,W.(1895).Étudesurlescônesetlesbâtonnetsdanslaregiondelafovea Environ.Med.78,B165–B175.
centralisdelarétinechezl’homme.Arch.D’opht.15,428. Marshall,S.P.(2000).MethodandApparatusforEyeTrackingandMonitoring
Krafka,K.,Khosla,A.,Kellnhofer,P.,Kannan,H.,Bhandarkar,S.,Matusik,W., PupilDilationtoEvaluateCognitiveActivity.USPatent6,051–090.[Dataset].
et al. (2016). “Eye Tracking for Everyone,” in Proceedings of the IEEE Marshall, S. P. (2002). “The index of Cognitive Activity: Measuring Cognitive
conference on computer vision and pattern recognition, 2176–2184. Workload,”inProceedingsoftheIEEE7thconferenceonHumanFactorsand
doi:10.1109/cvpr.2016.239 PowerPlants(IEEE),7.
Krauzlis, R. J. (2004). Recasting the Smooth Pursuit Eye Movement System. Marslen-Wilson,W.D.(1985).SpeechShadowingandSpeechComprehension.
J.Neurophysiol.91,591–603.doi:10.1152/jn.00801.2003 SpeechCommun.4,55–73.doi:10.1016/0167-6393(85)90036-6
Krejtz,K.,Żurawska,J.,Duchowski,A.T.,andWichary,S.(2020).Pupillaryand Martinez-Conde,S.,Macknik,S.L.,andHubel,D.H.(2004).TheRoleofFixational
MicrosaccadicResponsestoCognitiveEffortandEmotionalArousalduring Eye Movements in Visual Perception. Nat. Rev. Neurosci. 5, 229–240.
ComplexDecisionMaking.J.EyeMovRes.13.doi:10.16910/jemr.13.5.2 doi:10.1038/nrn1348
Krejtz,K.,Duchowski,A.,Szmidt,T.,Krejtz,I.,GonzálezPerilli,F.,Pires,A.,etal. May,J.G.,Kennedy,R.S.,Williams,M.C.,Dunlap,W.P.,andBrannan,J.R.
(2015). Gaze Transition Entropy. ACM Trans. Appl. Percept. 13, 1–20. (1990). Eye Movement Indices of Mental Workload. Acta psychologica 75,
doi:10.1145/2834121 75–89.doi:10.1016/0001-6918(90)90067-p
Krejtz,K.,Duchowski,A.T.,Niedzielska,A.,Biele,C.,andKrejtz,I.(2018).Eye McConkie,G.W.,andRayner,K.(1975).TheSpanoftheEffectiveStimulusduring
TrackingCognitiveLoadUsingPupilDiameterandMicrosaccadeswithFixed aFixationinreading.Perception&Psychophysics17,578–586.doi:10.3758/
Gaze.PloSone13,e0203629.doi:10.1371/journal.pone.0203629 bf03203972
Krejtz, K., Szmidt, T.,Duchowski,A.T., andKrejtz, I. (2014). “Entropy-based McGregor, D. K., and Stern, J. A. (1996). Time on Task and Blink Effects on
Statistical Analysis of Eye Movement Transitions,” in Proceedings of the SaccadeDuration.Ergonomics39,649–660.doi:10.1080/00140139608964487
FrontiersinComputerScience|www.frontiersin.org 19 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
McKee,S.P.,Levi,D.M.,Schor,C.M.,andMovshon,J.A.(2016).SaccadicLatency O’Driscoll,G.A.,andCallahan,B.L.(2008).SmoothPursuitinSchizophrenia:a
inAmblyopia.J.Vis.16,3.doi:10.1167/16.5.3 Meta-AnalyticReviewofResearchsince1993.BrainCogn.68,359–370.
McSorley, E., McCloy, R., and Lyne, C. (2012). The Spatial Impact of Visual Oh,J.,Han,M.,Peterson,B.S.,andJeong,J.(2012).SpontaneousEyeblinksAre
Distractors on Saccade Latency. Vis. Res. 60, 61–72. doi:10.1016/ Correlated with Responses during the Stroop Task. PloS one 7, e34871.
j.visres.2012.03.007 doi:10.1371/journal.pone.0034871
Megaw,E.D.(1979).FactorsAffectingVisualInspectionAccuracy.Appl.Ergon. Ohtani, A. (1971). An Analysis of Eye Movements during a Visual Task.
10,27–32.doi:10.1016/0003-6870(79)90006-1 Ergonomics14,167–174.doi:10.1080/00140137108931235
Megaw, E. D., and Richardson, J. (1979). Eye Movements and Industrial Otero-Millan, J., Troncoso, X. G., Macknik, S. L., Serrano-Pedraza, I., and
Inspection.Appl.Ergon.10,145–154.doi:10.1016/0003-6870(79)90138-8 Martinez-Conde, S. (2008). Saccades and Microsaccades during Visual
Meghanathan, R. N., Nikolaev, A. R., and van Leeuwen, C. (2019). Refixation Fixation, Exploration, and Search: Foundations for a Common Saccadic
PatternsRevealMemory-EncodingStrategiesinFreeViewing.AttenPercept Generator.J.Vis.8,21.doi:10.1167/8.14.21
Psychophys81,2499–2516.doi:10.3758/s13414-019-01735-2 Pan,J.,Ferrer,C.C.,McGuinness,K.,O’Connor,N.E.,Torres,J.,Sayrol,E.,etal.
Mele, M. L., and Federici, S. (2012). Gaze and Eye-Tracking Solutions for (2017). Salgan: Visual Saliency Prediction with Generative Adversarial
PsychologicalResearch.Cogn.Process.13,261–265.doi:10.1007/s10339-012- Networks.arXivpreprintarXiv:1701.01081
0499-z Parkhurst,D.,Law,K.,andNiebur,E.(2002).ModelingtheRoleofSalienceinthe
Mello-Thoms,C.,Hardesty,L.,Sumkin,J.,Ganott,M.,Hakim,C.,Britton,C.,etal. AllocationofOvertVisualAttention.Vis.Res.42,107–123.doi:10.1016/s0042-
(2005). Effects of Lesion Conspicuity on Visual Search in Mammogram 6989(01)00250-4
reading1.Acad.Radiol.12,830–840.doi:10.1016/j.acra.2005.03.068 Patel,S.S.,Jankovic,J.,Hood,A.J.,Jeter,C.B.,andSereno,A.B.(2012).Reflexive
Menon,R.G.V.,Sigurdsson,V.,Larsen,N.M.,Fagerstrøm,A.,andFoxall,G.R. and Volitional Saccades: Biomarkers of huntington Disease Severity and
(2016). Consumer Attention to price in Social Commerce: Eye Tracking Progression.J.Neurol.Sci.313,35–41.doi:10.1016/j.jns.2011.09.035
Patterns in Retail Clothing. J. Business Res. 69, 5008–5013. doi:10.1016/ Pavlović, N., and Jensen, K. (2009). Eye Tracking Translation Directionality.
j.jbusres.2016.04.072 TranslationRes.projects2,93–109.
Meyer, C.H., Lasker, A.G., and Robinson, D.A. (1985). The Upper Limit of Peterson, J.,andAllison, L.W.(1931). Controlsofthe Eye-WinkMechanism.
Human Smooth Pursuit Velocity. Vis. Res. 25, 561–563. doi:10.1016/0042- J.Exp.Psychol.14,144–154.doi:10.1037/h0070197
6989(85)90160-9 Peysakhovich,V.,Vachon,F.,andDehais,F.(2017).TheImpactofLuminanceon
Michell,A.W.,Xu,Z.,Fritz,D.,Lewis,S.J.G.,Foltynie,T.,Williams-Gray,C.H., Tonic and Phasic Pupillary Responses to Sustained Cognitive Load. Int.
etal.(2006).SaccadicLatencyDistributionsinParkinson’sDiseaseandthe J.Psychophysiology112,40–45.doi:10.1016/j.ijpsycho.2016.12.003
EffectsofL-Dopa.Exp.BrainRes.174,7–18.doi:10.1007/s00221-006-0412-z Phillips,M.H.,andEdelman,J.A.(2008).TheDependenceofVisualScanning
Mlot,E.G.,Bahmani,H.,Wahl,S.,andKasneci,E.(2016).“3dGazeEstimation Performance on Search Direction and Difficulty. Vis. Res. 48, 2184–2192.
UsingEyeVergence,”inProceedingsofthe9thInternationalJointConference doi:10.1016/j.visres.2008.06.025
on Biomedical Engineering Systems and Technologies (Rome, Italy: Ponsoda, V., Scott, D., and Findlay, J. M. (1995). A Probability Vector and
HEALTHINF),125–131.doi:10.5220/0005821201250131 Transition Matrix Analysis of Eye Movements during Visual Search. Acta
Mohanty,A.,andSussman,T.J.(2013).Top-downModulationofAttentionby psychologica88,167–185.doi:10.1016/0001-6918(95)94012-y
Emotion.Front.Hum.Neurosci.7,102.doi:10.3389/fnhum.2013.00102 Posner,M.I.,Snyder,C.R.,andDavidson,B.J.(1980).AttentionandtheDetection
Morris, T. L., and Miller, J. C. (1996). Electrooculographic and Performance ofSignals.J.Exp.Psychol.Gen.109,160–174.doi:10.1037/0096-3445.109.2.160
Indices of Fatigue during Simulated Flight. Biol. Psychol. 42, 343–360. Pumphrey, R. J. (1948). The Theory of the Fovea. J. Exp. Biol. 25, 299–312.
doi:10.1016/0301-0511(95)05166-x doi:10.1242/jeb.25.3.299
Mostofi, N., Zhao, Z., Intoy, J., Boi, M., Victor, J. D., and Rucci, M. (2020). Ranti,C.,Jones,W.,Klin,A.,andShultz,S.(2020).BlinkRatePatternsProvidea
Spatiotemporal Content of Saccade Transients. Curr. Biol. 30, 3999–4008. ReliableMeasureofIndividualEngagementwithSceneContent.Sci.Rep.10,
doi:10.1016/j.cub.2020.07.085 1–10.doi:10.1038/s41598-020-64999-x
Motoki,K.,Saito,T.,andOnuma,T.(2021).Eye-trackingResearchonSensoryand Rashbass,C.(1961).TheRelationshipbetweenSaccadicandSmoothTrackingEye
ConsumerScience:AReview,PitfallsandFutureDirections.FoodRes.Int.145, Movements.J.Physiol.159,326–338.doi:10.1113/jphysiol.1961.sp006811
110389.doi:10.1016/j.foodres.2021.110389 Ratliff, F., and Riggs, L. A. (1950). Involuntary Motions of the Eye during
Mulder,K.,Klugkist,I.,vanRenswoude, D.,andVisser,I.(2020).Mixtures of MonocularFixation.J.Exp.Psychol.40,687–701.doi:10.1037/h0057754
PeakedPowerBatscheletDistributionsforCircularDatawithApplicationto Rayner,K.(1979).EyeGuidanceinreading:FixationLocationswithinWords.
Saccade Directions. J. Math. Psychol. 95, 102309. doi:10.1016/ Perception8,21–30.doi:10.1068/p080021
j.jmp.2019.102309 Rayner, K.(2012).EyeMovementsandVisualCognition: Scene Perceptionand
Mutasim,A.K.,Stuerzlinger,W.,andBatmaz,A.U.(2020).“GazeTrackingfor reading.SpringerScience&BusinessMedia.
Eye-Hand Coordination Training Systems in Virtual Reality,” in Extended Rayner,K.(1978).EyeMovementsinreadingandInformationProcessing.Psychol.
Abstracts of the 2020 CHI Conference on Human Factors in Computing Bull.85,618–660.doi:10.1037/0033-2909.85.3.618
Systems,1–9.doi:10.1145/3334480.3382924 Rayner,K.,Pollatsek,A.,Ashby,J.,andClifton,C.,Jr(2012).PsychologyofReading.
Nachmias, J. (1961). Determiners of the Drift of the Eye during Monocular 1edn.Hove,EastSussex,UK:PsychologyPress.
Fixation*.J.Opt.Soc.Am.51,761–766.doi:10.1364/josa.51.000761 Rayner,K.(1975).ThePerceptualSpanandPeripheralCuesinreading.Cogn.
Nakayama,M.,Takahashi,K.,andShimizu,Y.(2002).“TheActofTaskDifficulty Psychol.7,65–81.doi:10.1016/0010-0285(75)90005-5
andEye-MovementFrequencyforThe’oculo-MotorIndices,”inProceedingsof Recarte,M.A.,andNunes,L.M.(2000).EffectsofVerbalandSpatial-Imagery
the 2002 symposium on Eye tracking research & applications, 37–42. Tasks on Eye Fixations while Driving. J. Exp. Psychol. Appl. 6, 31–43.
doi:10.1145/507072.507080 doi:10.1037/1076-898x.6.1.31
Newhall,S.M.(1932).TheControlofEyelidMovementsinVisualExperiments. Redmon,J.,Divvala,S.,Girshick,R.,andFarhadi,A.(2016).“YouOnlyLookonce:
Am.J.Psychol.44,555–570.doi:10.2307/1415357 Unified,Real-TimeObjectDetection,”inProceedingsoftheIEEEconference
Noronha, B., Dziemian, S.,Zito, G. A., Konnaris, C., and Faisal, A.A. (2017). on computer vision and pattern recognition, 779–788. doi:10.1109/
“"WinktoGrasp"-ComparingEye,Voice&EMGGestureControlofGrasp cvpr.2016.91
withSoft-RoboticGloves,”in2017InternationalConferenceonRehabilitation Reimer,J.,McGinley,M.J.,Liu,Y.,Rodenkirch,C.,Wang,Q.,McCormick,D.A.,
Robotics(ICORR)(IEEE),1043–1048.doi:10.1109/ICORR.2017.8009387IEEE et al. (2016). Pupil Fluctuations Track Rapid Changes in Adrenergic and
Int.Conf.Rehabil.Robot2017 Cholinergic Activity in Cortex. Nat. Commun. 7, 1–7. doi:10.1038/
Nyström,M.,andHolmqvist,K.(2008).SemanticOverrideofLow-LevelFeatures ncomms13289
inImageViewing–BothInitiallyandOverall.J.EyeMove.Res.2.doi:10.16910/ Reingold,E.M.,Reichle,E.D.,Glaholt,M.G.,andSheridan,H.(2012).Direct
jemr.2.2.2 Lexical Control of Eye Movements in reading: Evidence from a Survival
FrontiersinComputerScience|www.frontiersin.org 20 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
Analysis of Fixation Durations. Cogn. Psychol. 65, 177–206. doi:10.1016/ Seeber,K.G.,andKerzel,D.(2012).CognitiveLoadinSimultaneousInterpreting:
j.cogpsych.2012.03.001 Model Meets Data. Int. J. Bilingualism 16, 228–242. doi:10.1177/
Ren,S.,He,K.,Girshick,R.,andSun,J.(2015).FasterR-Cnn:TowardsReal-Time 1367006911402982
Object Detection with Region Proposal Networks. arXiv preprint arXiv: Semmelmann,K.,andWeigelt,S.(2018).OnlineWebcam-BasedEyeTrackingin
1506.01497. CognitiveScience:AFirstLook.Behav.Res.50,451–465.doi:10.3758/s13428-
Renner, P., and Pfeiffer, T. (2017). “Attention Guiding Techniques Using 017-0913-7
Peripheral Vision and Eye Tracking for Feedback in Augmented-Reality- Sewell,W.,andKomogortsev,O.(2010).“Real-timeEyeGazeTrackingwithan
BasedAssistanceSystems,”in2017IEEESymposiumon3DUserInterfaces UnmodifiedCommodityWebcamEmployingaNeuralNetwork,”inCHI’10
(3DUI)(IEEE),186–194.doi:10.1109/3dui.2017.7893338 Extended Abstracts on Human Factors in Computing Systems, 3739–3744.
Reppert, T. R., Lempert, K. M., Glimcher, P. W., and Shadmehr, R. (2015). doi:10.1145/1753846.1754048
Modulation of Saccade Vigor during Value-Based Decision Making. Shannon,C.E.(1948).AMathematicalTheoryofCommunication.BellSyst.Tech.
J.Neurosci.35,15369–15378.doi:10.1523/jneurosci.2621-15.2015 J.27,379–423.doi:10.1002/j.1538-7305.1948.tb01338.x
Rerhaye, L., Blaser, T., and Alexander, T. (2018). “Evaluation of the index of Shiferaw,B.,Downey,L.,andCrewther,D.(2019).AReviewofGazeEntropyasa
Cognitive Activity (Ica) as an Instrument to Measure Cognitive Workload Measure of Visual Scanning Efficiency. Neurosci. Biobehavioral Rev. 96,
under Differing Light Conditions,” in Congress of the International 353–366.doi:10.1016/j.neubiorev.2018.12.007
Ergonomics Association (Springer), 350–359. doi:10.1007/978-3-319- Shin,Y.S.,Chang,W.-d.,Park,J.,Im,C.-H.,Lee,S.I.,Kim,I.Y.,etal.(2015).
96059-3_38 CorrelationbetweenInter-blinkIntervalandEpisodicEncodingduringMovie
Riggs,L.A.,Kelly,J.P.,Manning,K.A.,andMoore,R.K.(1987).Blink-relatedEye Watching.PloSone10,e0141242.doi:10.1371/journal.pone.0141242
Movements.Invest.Ophthalmol.Vis.Sci.28,334–342. Simons, D. J., and Chabris, C. F. (1999). Gorillas in Our Midst: Sustained
Riggs, L. A., Ratliff, F., Cornsweet, J. C., and Cornsweet, T. N. (1953). The Inattentional Blindness for Dynamic Events. perception 28, 1059–1074.
DisappearanceofSteadilyFixatedVisualTestObjects*.J.Opt.Soc.Am.43, doi:10.1068/p2952
495–501.doi:10.1364/josa.43.000495 Snider,J.,Spence,R.J.,Engler,A.-M.,Moran,R.,Hacker,S.,Chukoskie,L.,etal.
Riggs,L.A.,andRatliff,F.(1951).VisualAcuityandthenormalTremorofthe (2021). Distraction “Hangover”: Characterization of the Delayed Return to
Eyes.Science114(2949),17–18.doi:10.1126/science.114.2949.17 Baseline Driving Risk after Distracting Behaviors. Thousand Oaks, CA:
Robinson,D.A.,Gordon,J.L.,andGordon,S.E.(1986).AModeloftheSmooth Humanfactors,00187208211012218.
Pursuit Eye Movement System. Biol. Cybern. 55, 43–57. doi:10.1007/ Spering,M.,andGegenfurtner,K.R.(2007).ContextualEffectsonSmooth-Pursuit
bf00363977 EyeMovements.J.Neurophysiol.97,1353–1367.doi:10.1152/jn.01087.2006
Robinson,D.A.(1965).TheMechanicsofHumanSmoothPursuitEyeMovement. Stapel,J.,ElHassnaoui,M.,andHappee,R.(2020).MeasuringDriverPerception:
J.Physiol.180,569–591.doi:10.1113/jphysiol.1965.sp007718 Combining Eye-Tracking and Automated Road Scene Perception. Thousand
Rottach,K.G.,Zivotofsky,A.Z.,Das,V.E.,Averbuch-Heller,L.,Discenna,A.O., Oaks,CA:Humanfactors,0018720820959958.
Poonyathalang, A., et al. (1996). Comparison of Horizontal, Vertical and Staub, A., and Benatar, A. (2013). Individual Differences in Fixation Duration
diagonal Smooth Pursuit Eye Movements in normal Human Subjects. Vis. Distributions in reading. Psychon. Bull. Rev. 20, 1304–1311. doi:10.3758/
Res.36,2189–2195.doi:10.1016/0042-6989(95)00302-9 s13423-013-0444-x
Rubaltelli, E., Agnoli, S., and Franchin, L. (2016). Sensitivity to Affective Steinman, R. M., Haddad, G. M., Skavenski, A. A., and Wyman, D. (1973).
Information and Investors’ Evaluation of Past Performance: An Eye- Miniature Eye Movement. Science 181, 810–819. doi:10.1126/
TrackingStudy.J.Behav.Dec.Making29,295–306.doi:10.1002/bdm.1885 science.181.4102.810
Rucci, M., and Poletti, M. (2015). Control and Functions of Fixational Eye Stern,J.A.,Walrath,L.C.,andGoldstein,R.(1984).TheEndogenousEyeblink.
Movements. Annu. Rev. Vis. Sci. 1, 499–518. doi:10.1146/annurev-vision- Psychophysiology21,22–33.doi:10.1111/j.1469-8986.1984.tb02312.x
082114-035742 Stevenson,S.B.,Volkmann,F.C.,Kelly,J.P.,andRiggs,L.A.(1986).Dependence
Russell, D. (2005). Consecutive and Simultaneous Interpreting. Benjamins ofVisualSuppressionontheAmplitudesofSaccadesandBlinks.Vis.Res.26,
TranslationLibr.63,135–164.doi:10.1075/btl.63.10rus 1815–1824.doi:10.1016/0042-6989(86)90133-1
Russo,M.,Thomas,M.,Thorne,D.,Sing,H.,Redmond,D.,Rowland,L.,etal. Sun,F.,Tauchi,P.,andStark,L.(1983).DynamicPupillaryResponseControlledby
(2003). Oculomotor Impairment during Chronic Partial Sleep the Pupil Size Effect. Exp. Neurol. 82, 313–324. doi:10.1016/0014-4886(83)
Deprivation. Clin. Neurophysiol. 114, 723–736. doi:10.1016/s1388- 90404-1
2457(03)00008-7 Sweller, J. (2011). “Cognitive Load Theory,” in Psychology of Learning and
Rutherford,M.D.,andTowns,A.M.(2008).ScanPathDifferencesandSimilarities Motivation(Elsevier),55,37–76.doi:10.1016/b978-0-12-387691-1.00002-8
during Emotion Perception in Those with and without Autism Spectrum Takeda, K., and Funahashi, S. (2002). Prefrontal Task-Related Activity
Disorders. J. Autism Dev. Disord. 38, 1371–1381. doi:10.1007/s10803-007- Representing Visual Cue Location orSaccadeDirection inSpatialWorking
0525-7 MemoryTasks.J.Neurophysiol.87,567–588.doi:10.1152/jn.00249.2001
Salthouse,T.A.,andEllis,C.L.(1980).DeterminantsofEye-FixationDuration. Termsarasab,P.,Thammongkolchai,T.,Rucker,J.C.,andFrucht,S.J.(2015).The
Am.J.Psychol.93,207–234.doi:10.2307/1422228 DiagnosticValueofSaccadesinMovementDisorderPatients:aPracticalGuide
Salvucci, D. D., and Goldberg, J. H. (2000). “Identifying Fixations and andReview.J.Clin.MovDisord.2,14–10.doi:10.1186/s40734-015-0025-4
Saccades in Eye-Tracking Protocols,” in Proceedings of the 2000 Tullis,T.,andAlbert,B.(2013).MeasuringtheUserExperience.Elsevier,163–186.
Symposium on Eye Tracking Research & Applications, New York, NY, chap. Behavioral and physiological metrics. doi:10.1016/b978-0-12-415781-
USA(PalmBeachGardens,FL:AssociationforComputingMachinery), 1.00007-8BehavioralandPhysiologicalMetrics
ETRA’00),71–78.doi:10.1145/355017.355028 Valls-Sole, J. (2019). Spontaneous, Voluntary, and Reflex Blinking in Clinical
Schiller,P.H.,True,S.D.,andConway,J.L.(1980).DeficitsinEyeMovements Practice. J. Clin. Neurophysiol. 36, 415–421. doi:10.1097/
FollowingFrontalEye-FieldandsuperiorColliculusAblations.J.Neurophysiol. wnp.0000000000000561
44,1175–1189.doi:10.1152/jn.1980.44.6.1175 VanderStigchel,S.,Rommelse,N.N.J.,Deijen,J.B.,Geldof,C.J.A.,Witlox,J.,
Schoonahd, J. W., Gould, J. D., and Miller, L. A. (1973). Studies of Visual Oosterlaan,J.,etal.(2007).OculomotorCaptureinAdhd.Cogn.Neuropsychol.
Inspection.Ergonomics16,365–379.doi:10.1080/00140137308924528 24,535–549.doi:10.1080/02643290701523546
Schwalm,M.,andRosalesJubal,E.(2017).BacktoPupillometry:HowCortical Van Orden, K. F., Jung, T.-P., and Makeig, S. (2000). Combined Eye Activity
NetworkStateFluctuationsTrackedbyPupilDynamicsCouldExplainNeural MeasuresAccuratelyEstimateChangesinSustainedVisualTaskPerformance.
SignalVariabilityinHumanCognitiveNeuroscience.Eneuro4.doi:10.1523/ Biol.Psychol.52,221–240.doi:10.1016/s0301-0511(99)00043-5
ENEURO.0293-16.2017 vanTricht,M.J.,Nieman,D.H.,Bour,L.J.,Boerée,T.,Koelman,J.H.T.M.,de
Schwiedrzik,C.M.,andSudmann,S.S.(2020).PupilDiameterTracksStatistical Haan,L., etal.(2010). Increased SaccadicRateduring Smooth PursuitEye
StructureintheEnvironmenttoIncreaseVisualSensitivity.J.Neurosci.40, MovementsinPatientsatUltraHighRiskforDevelopingaPsychosis.Brain
4565–4575.doi:10.1523/jneurosci.0216-20.2020 Cogn.73,215–221.doi:10.1016/j.bandc.2010.05.005
FrontiersinComputerScience|www.frontiersin.org 21 January2022|Volume3|Article733531

Mahanamaetal. EyeMovementandPupilMeasures
vanZoest,W.,Donk,M.,andTheeuwes,J.(2004).TheRoleofStimulus-Driven Wedel, M., and Pieters, R. (2008). A Review of Eye-Tracking Research in
andGoal-DrivenControlinSaccadicVisualSelection.J.Exp.Psychol.Hum. Marketing.Rev.marketingRes.,123–147.doi:10.4324/9781351550932-5
perceptionPerform.30,746–759.doi:10.1037/0096-1523.30.4.749 Widdel, H. (1984). “Operational Problems in Analysing Eye Movements,” in
Vandeberg, L., Bouwmeester, S., Bocanegra, B. R., and Zwaan, R. A. (2013). Advances in Psychology (Elsevier), 22, 21–29. doi:10.1016/s0166-4115(08)
Detecting Cognitive Interactions through Eye Movement Transitions. 61814-2
J.Mem.Lang.69,445–460.doi:10.1016/j.jml.2013.05.006 Wierda,S.M.,vanRijn,H.,Taatgen,N.A.,andMartens,S.(2012).PupilDilation
Velichkovsky,B.B.,Khromov,N.,Korotin,A.,Burnaev,E.,andSomov,A.(2019). Deconvolution Reveals the Dynamics of Attention at High Temporal
“VisualFixationsDurationasanIndicatorofSkillLevelinEsports,”inIFIP Resolution. Proc. Natl. Acad. Sci. 109, 8456–8460. doi:10.1073/
Conference on Human-Computer Interaction (Springer), 397–405. pnas.1201858109
doi:10.1007/978-3-030-29381-9_25 Xu-Wilson,M.,Zee,D.S.,andShadmehr,R.(2009).TheIntrinsicValueofVisual
Velichkovsky,B.M.,Dornhoefer,S.M.,Pannasch,S.,andUnema,P.J.(2000). Information Affects Saccade Velocities. Exp. Brain Res. 196, 475–481.
“VisualFixationsandLevelofAttentionalProcessing,”inProceedingsofthe doi:10.1007/s00221-009-1879-1
2000symposiumoneyetrackingresearch&applications,79–85.doi:10.1145/ Yarbus,A.L.(1967).EyeMovementsandVision.Springer.
355017.355029 Young,L.R.(1971).“PursuitEyeTrackingMovements,”inTheControlofEye
Venjakob,A.,Marnitz,T.,Mahler,J.,Sechelmann,S.,andRoetting,M.(2012). Movements (New York: Academic Press), 429–443. doi:10.1016/b978-0-12-
“Radiologists’EyeGazewhenreadingCranialCtImages,”inMedicalimaging 071050-8.50019-7
2012: Image perception, observer performance, and technology assessment Young,L.R.,andSheena,D.(1975).SurveyofEyeMovementRecordingMethods.
(San Diego: International Society for Optics and Photonics), 8318, 83180B. Behav.Res.MethodsInstrumentation7,397–429.doi:10.3758/bf03201553
doi:10.1117/12.913611 Yu, G., Xu, B., Zhao, Y., Zhang, B., Yang, M., Kan, J. Y. Y., et al. (2016).
Wade, M. G., and Jones, G. (1997). The Role of Vision and Spatial Microsaccade Direction Reflects the Economic Value of Potential Saccade
Orientation in the Maintenance of Posture. Phys. Ther. 77, 619–628. Goals and Predicts Saccade Choice. J. Neurophysiol. 115, 741–751.
doi:10.1093/ptj/77.6.619 doi:10.1152/jn.00987.2015
Wainstein, G.,Rojas-Líbano, D.,Crossley,N.A., Carrasco, X.,Aboitiz,F.,and Zackon,D.H.,andSharpe,J.A.(1987).SmoothPursuitinsenescence:Effectsof
Ossandón,T.(2017).PupilSizeTracksAttentionalPerformanceinAttention- Target Acceleration and Velocity. Acta oto-laryngologica 104, 290–297.
Deficit/hyperactivityDisorder.Sci.Rep.7,8228–8229.doi:10.1038/s41598-017- doi:10.3109/00016488709107331
08246-w Zelinsky,G.J.,andSheinberg,D.L.(1997).EyeMovementsduringParallel-Serial
Walker, R., McSorley, E., and Haggard, P. (2006). The Control of Saccade Visual Search. J. Exp. Psychol. Hum. perception Perform. 23, 244–262.
Trajectories:DirectionofCurvatureDependsonPriorKnowledgeofTarget doi:10.1037/0096-1523.23.1.244
Location and Saccade Latency. Perception & Psychophysics 68, 129–138. Zénon, A. (2017). Time-domain Analysis for Extracting Fast-Paced Pupil
doi:10.3758/bf03193663 Responses.Sci.Rep.7,1–10.doi:10.1038/srep41484
Walker-Smith, G. J., Gale, A. G., and Findlay, J. M. (1977). Eye Movement Zhang,X.,Yuan,S.-M.,Chen,M.-D.,andLiu,X.(2018).ACompleteSystemfor
Strategies Involved in Face Perception. Perception 6, 313–326. doi:10.1068/ AnalysisofVideoLectureBasedonEyeTracking.IEEEAccess6,49056–49066.
p060313 doi:10.1109/access.2018.2865754
Wang,C.-A.,Brien,D.C.,andMunoz,D.P.(2015).PupilSizeRevealsPreparatory Zuber, B. L., Stark, L., and Cook, G. (1965). Microsaccades and the Velocity-
ProcessesintheGenerationofPro-saccadesandAnti-saccades.Eur.J.Neurosci. AmplitudeRelationshipforSaccadicEyeMovements.Science150,1459–1460.
41,1102–1110.doi:10.1111/ejn.12883 doi:10.1126/science.150.3702.1459
Wang,R.I.,Pelfrey,B.,Duchowski,A.T.,andHouse,D.H.(2012).“Online
GazeDisparityviaBioncularEyeTrackingonStereoscopicDisplays,”in ConflictofInterest:Theauthorsdeclarethattheresearchwasconductedinthe
2012 Second International Conference on 3D Imaging, Modeling, absenceofanycommercialorfinancialrelationshipsthatcouldbeconstruedasa
Processing (Visualization & TransmissionIEEE), 184–191. doi:10.1109/ potentialconflictofinterest.
3dimpvt.2012.37
Wang,Y.,Lu,S.,andHarter,D.(2021).Multi-sensorEye-TrackingSystemsand Publisher’sNote:Allclaimsexpressedinthisarticlearesolelythoseoftheauthors
Tools for Capturing Student Attention and Understanding Engagement in anddonotnecessarilyrepresentthoseoftheiraffiliatedorganizations,orthoseof
Learning: A Review. IEEE Sensors J. 21, 22402–22413. doi:10.1109/ thepublisher,theeditorsandthereviewers.Anyproductthatmaybeevaluatedin
jsen.2021.3105706 thisarticle,orclaimthatmaybemadebyitsmanufacturer,isnotguaranteedor
Warren, D. E., Thurtell, M. J., Carroll, J. N., and Wall, M. (2013). Perimetric endorsedbythepublisher.
EvaluationofSaccadicLatency,SaccadicAccuracy,andVisualThresholdfor
Peripheral Visual Stimuli in Young Compared with Older Adults. Invest. Copyright©2022Mahanama,Jayawardana,Rengarajan,Jayawardena,Chukoskie,
Ophthalmol.Vis.Sci.54,5778–5787.doi:10.1167/iovs.13-12032 SniderandJayarathna.Thisisanopen-accessarticledistributedunderthetermsof
Wass,S.V.,deBarbaro,K.,andClackson,K.(2015).TonicandPhasicCo-variation the Creative Commons Attribution License (CC BY). The use, distribution or
ofPeripheralArousalIndicesinInfants.Biol.Psychol.111,26–39.doi:10.1016/ reproduction in other forums is permitted, provided the original author(s) and
j.biopsycho.2015.08.006 thecopyrightowner(s)arecreditedandthattheoriginalpublicationinthisjournalis
Watson,A.B.,andYellott,J.I.(2012).AUnifiedFormulaforLight-AdaptedPupil cited, in accordance with accepted academic practice. No use, distribution or
Size.J.Vis.12,12.doi:10.1167/12.10.12 reproductionispermittedwhichdoesnotcomplywiththeseterms.
FrontiersinComputerScience|www.frontiersin.org 22 January2022|Volume3|Article733531
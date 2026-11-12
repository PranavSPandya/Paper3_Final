A Dataset and Taxonomy for Urban Sound Research
Justin Salamon1,2, Christopher Jacoby1, Juan Pablo Bello1
1MusicandAudioResearchLaboratory,NewYorkUniversity
2CenterforUrbanScienceandProgress,NewYorkUniversity
{justin.salamon, cbj238, jpbello}@nyu.edu
ABSTRACT Oneofthemainchallengesandhindrancestourbansound
researchisthelackoflabeledaudiodata. Previousworkhas
Automatic urban sound classification is a growing area of
focused on audio from carefully produced movies or televi-
research with applications in multimedia retrieval and ur-
sion tracks [3]; from specific environments such as eleva-
baninformatics. Inthispaperweidentifytwomainbarriers
tors or office spaces [13, 8]; and on commercial or propri-
to research in this area – the lack of a common taxonomy
etarydatasets[11,4]. Thelargeeffortinvolvedinmanually
and the scarceness of large, real-world, annotated data. To
annotating real-world data means datasets based on field
addresstheseissueswepresentataxonomyofurbansounds
recordings tend to be relatively small (e.g. the event detec-
and a new dataset, UrbanSound, containing 27 hours of au-
tion dataset of the IEEE AASP Challenge [8] consists of
dio with 18.5 hours of annotated sound event occurrences
24 recordings per each of 17 classes). A second challenge
across 10 sound classes. The challenges presented by the
faced by the research community is the lack of a common
newdatasetare studiedthroughaseriesofexperimentsus-
vocabulary when working with urban sounds. This means
ing a baseline classification system.
the classification of sounds into semantic groups may vary
from study to study, making it hard to compare results.
CategoriesandSubjectDescriptors The goal of this paper is to address the two aforemen-
tioned challenges. In Section 2 we propose a taxonomy
H.3.1 [Information Systems]: Content Analysis and In-
for urban sound sources to facilitate a common framework
dexing; H.5.5 [Information Systems]: Sound and Music
for research. Then, in Section 3 we present UrbanSound,
Computing
a dataset of 27 hours of field recordings containing thou-
sands of labeled sound source occurrences. To the best of
Keywords
the authors’ knowledge this is the largest free dataset of
labelled urban sound events available for research. To un-
Urban sound; dataset; taxonomy; classification
derstand the complexity and challenges presented by this
new dataset, we run a series of baseline sound classification
1. INTRODUCTION
experiments, described in Section 4. The paper concludes
The automatic classification of environmental sound is a with a summary in Section 5.
growing research field with multiple applications to large-
scale,content-basedmultimediaindexingandretrieval(e.g.
2. URBANSOUNDTAXONOMY
[13,16,10]). Inparticular,thesonicanalysisofurban envi-
ronmentsisthesubjectofincreasedinterest,partlyenabled Thetaxonomicalcategorizationof environmentalsounds,
bymultimediasensornetworks[15],aswellasbylargequan- a common first step in sound classification, has been ex-
tities of online multimedia content depicting urban scenes. tensively studied in the context of perceptual soundscape
However, while there is a large body of research in related research[14]. Specificeffortstodescribeurbansoundshave
areas such as speech, music and bioacoustics, work on the oftenbeenlimitedtosubsetsofbroadertaxonomiesofacous-
analysisofurbanacousticsenvironmentsisrelativelyscarce. tic environments [2], and thus only partially address the
Furthermore,whenexistent,itmostlyfocusesontheclassi- needsofsystematicurbansoundanalysis. Foranexhaustive
ficationofauditoryscenetype,e.g. street,park,asopposed review of previous work the reader is referred to [12].
to the identification of sound sources in those scenes, e.g. Inourview,anurbansoundtaxonomyshouldsatisfythe
car horn, engine idling, bird tweet. See [5] for an example. followingthreerequirements: (1)itshouldfactorinprevious
researchandproposedtaxonomies,(2)itshouldaimtobeas
Permissiontomakedigitalorhardcopiesofallorpartofthisworkforpersonalor detailed as possible, going down to low-level sound sources
classroomuseisgrantedwithoutfeeprovidedthatcopiesarenotmadeordistributed
such as“car horn”(versus“transportation”) and“jackham-
forprofitorcommercialadvantageandthatcopiesbearthisnoticeandthefullcitation
mer”(versus“construction”), (3) it should, in its first iter-
onthefirstpage. Copyrightsforcomponentsofthisworkownedbyothersthanthe
author(s)mustbehonored.Abstractingwithcreditispermitted.Tocopyotherwise,or ation, focus on sounds that are of specific relevance to ur-
republish,topostonserversortoredistributetolists,requirespriorspecificpermission bansoundresearch,suchassoundsthatcontributetourban
and/orafee.Requestpermissionsfrompermissions@acm.org. noisepollution. Toaddress(1),wedecidedtobaseourtax-
MM’14,November3–7,2014,Orlando,Florida,USA. onomy on the subset of [2] dedicated to the urban acoustic
Copyrightisheldbytheowner/author(s).PublicationrightslicensedtoACM.
environment. We define 4 top level groups: human, nature,
ACM978-1-4503-3063-3/14/11...$15.00.
mechanical and music, which are common to most previ-
http://dx.doi.org/10.1145/2647868.2655045.

UErbnavnir oAncmouesnttic
|     |     | Human | Nature |     |     | Mechanical |     |     |     |     | Music |     |     |
| --- | --- | ----- | ------ | --- | --- | ---------- | --- | --- | --- | --- | ----- | --- | --- |
Voice Movement Elements Animals VePglaentattsi/on Construction Ventilation NoTnr-amnostpoorrizted  Social/Signals MTroatnosrpizoerdt  amNpolinfi-ed Amplified
|     | ---------           SLSCCSSICn ap e e c th |     |     |                                     |                      |     |                              |     |     |     |     |     |     |
| --- | ------------------------------------------ | --- | --- | ----------------------------------- | -------------------- | --- | ---------------------------- | --- | --- | --- | --- | --- | --- |
|     | h u o g u h gt i n e                       | g r |     | ------        JHDSEE a arai c mll k | hm a e m r i nm ge r |     | -----       BCAFGil el l lcs |     |     |     |     |     |     |
ro y u i n g h ni n g - Footsteps ---     WWTh iau ntn dedrer ---     DDBi oord gg    { {{t bhwoa rwk el}}t} - Leaves {rustling} i nion ng - Air conditioner Bicycle Skateboard urao r wm k    c/r  hs iimreens Marine Rail Road Air Live Recorded
|     | ni hfn e g e itn z ig | g   | e   | xn pg w li | se g i  o{ rn |                                                     | e n   so h ok ts        |                     |         |                |                              |                                                    |     |
| --- | --------------------- | --- | --- | ---------- | ------------- | --------------------------------------------------- | ----------------------- | ------------------- | ------- | -------------- | ---------------------------- | -------------------------------------------------- | --- |
|     | a i l n d r e n       |     |     |            | u n n ing}    |                                                     |                         |                     |         |                |                              |                                                    |     |
|     |                       |     |     |            |               |                                                     |                         |                     |         |                |                              | -----       HCCIBco olae ur u b cm s e   p a r t y |     |
|     |                       |     |     |            |               | --  SBpelolkes                                      | Boat (oveTrgraroinu nd) | (unSdeurbgwroauynd) | Car     | Motorcycle Bus | Truck --  AHierpliclaonpeter |   rra eb d a iom    /t  rsupcekakers               |     |
|     |                       |     |     |            |               |                                                     |                         |                     |         |                |                              | o o x                                              |     |
|     |                       |     |     |            |               | ----      WRBR h me e l lse e   o n   t ra c k s    |                         |                     |         |                |                              |                                                    |     |
|     |                       |     |     |            |               | ure ec ao kb sd { sd c a r en en co hu inncge}ments | Police                  | Ambulance Taxi      | Private | Police Private | Bus Fire engine              | Private Gatrrubcakge                               |     |
r
------        EEEHBW nnn gggr iii nnn eee     {{{ ipa d al i sn esg }
|     |     |     |     |     |     |     |     |         |     | c c iln e rg a} t in g }                          |                                                     |     |                  |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --- | ------------------------------------------------- | --------------------------------------------------- | --- | ---------------- |
|     |     |     |     |     |     |     |     | - Siren |     | ro ha ekn ee lss    {{ s c r se se cn hg i} n g } | --  PBnaecukimnga tuicps {beeping} - Rattling parts |     | - Hydraulic rams |
p a i
|     |     |     |     |     | Figure | 1: Urban | Sound | Taxonomy. |     |     |     |     |     |
| --- | --- | --- | --- | --- | ------ | -------- | ----- | --------- | --- | --- | --- | --- | --- |
ously proposed taxonomies [12]. To address (2), we specify the dataset should be sufficiently large and varied in terms
that the leaves of the taxonomy should be sufficiently low- of sounds and recording conditions such that it will be use-
level to be unambiguous – e.g. car “brakes”, “engine” or fulfortrainingscalablealgorithmscapableofanalyzingreal
“horn”, instead of simply“car”. Finally to address (3), we data from sensor networks or multimedia repositories. To
examined all the noise complaints filed through New York accomplish these goals, we turned to Freesound3, an on-
City’s 311 service from 2010 to date1 (over 370,000), and linesoundrepositorycontainingover160,000user-uploaded
built the taxonomy around the most frequently complained recordings under a creative commons license. Freesound
aboutsoundcategoriesandsources–construction(e.g.jack- contains a large amount of field recordings, many of which
hammer),trafficnoise(carandtruckhorns,idlingengines), are in urban settings. Using the Freesound API we were
loud music, air conditioners and dog barks to name a few. abletosearchanddownloadasubsetoftherepository,and
The resulting taxonomy is provided in Figure 1. Fur- exploit the user-provided metadata (title, description and
ther information about the principles and process behind tags) to significantly speed up the annotation process.
the construction of the taxonomy, as well as a scalable dig- For each class, we started by downloading all sounds re-
ital version, are available online2. Rounded rectangles rep- turnedbytheFreesoundsearchenginewhenusingtheclass
resent high-level semantic classes (e.g. mechanical sounds). nameasaquery(e.g.“jackhammer”),resultinginover3000
The leaves of the taxonomy (rectangles with sharp edges) recordings summing to just over 60 hours of audio. We
correspond to classes of concrete sound sources (e.g. siren, thenmanuallycheckedeveryrecordingbylisteningtoitand
footsteps). For conciseness, leaves can be shared by sev- inspecting the user-provided metadata, only keeping those
eral high-level classes (indicated by an earmark). Since the that were actual field recordings where the sound class of
numberofpossiblesoundsourcesinanurbansettingisvery interest was present somewhere in the recording. After this
large (potentially infinite), we consider the taxonomy to be first filtering stage we were left with 1302 recordings sum-
a constant work in progress rather than fixed. We plan to ming to just over 27 hours of audio. Next, given all the
recordingsforaspecificsoundclass,weusedAudacity4tola-
| continue | expanding | and | reformulating | the | taxonomy | as  | we  |     |     |     |     |     |     |
| -------- | --------- | --- | ------------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
increasethescopeofsoundscoveredbyourresearch,byen- belthestartandendtimesofeveryoccurrenceofthesound
gagingtheinternationalresearchcommunityandpromoting ineachrecording,withanadditionalsalience descriptionin-
acollaborativeeffortvia(forinstance)dedicatedworkshops. dicating whether the occurrence was subjectively perceived
|     |     |     |     |     |     |     |     | tobeintheforegroundorbackgroundoftherecording. |     |     |     |     | This |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------------------------------------- | --- | --- | --- | --- | ---- |
resultedinatotalof3075labeledoccurrencesamountingto
3. THEURBANSOUNDDATASET
|     |     |     |     |     |     |     |     | 18.5hoursoflabeledaudio. |     |     | Thedistributionoftotaloccur- |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------ | --- | --- | ---------------------------- | --- | --- |
In addition, we have collected a dataset of annotated ur- rence duration per class and per salience is in Fig. 2(a).
bansoundsincluding10low-levelclassesfromthetaxonomy: Theresultingcollectionof1302fulllengthrecordingswith
airconditioner,carhorn,childrenplaying,dogbark,drilling, corresponding sound occurrence and salience annotations,
| engine | idling, | gun shot, | jackhammer, | siren | and | street mu- |     |             |     |                     |        |               |        |
| ------ | ------- | --------- | ----------- | ----- | --- | ---------- | --- | ----------- | --- | ------------------- | ------ | ------------- | ------ |
|        |         |           |             |       |     |            |     | UrbanSound, |     | is freely available | online | (cf. footnote | 2) for |
sic. Withtheexceptionof“childrenplaying”and“gunshot”
|           |          |           |                             |      |        |          |     | researchpurposes.                          |     | Theaudioisprovidedinthesameformat |     |         |               |
| --------- | -------- | --------- | --------------------------- | ---- | ------ | -------- | --- | ------------------------------------------ | --- | --------------------------------- | --- | ------- | ------------- |
| whichwere | addedfor | variety,  | allotherclasseswereselected |      |        |          |     |                                            |     |                                   |     |         |               |
|           |          |           |                             |      |        |          |     | inwhichitwasoriginallyuploadedtoFreesound. |     |                                   |     |         | Notethat      |
| due to    | the high | frequency | in which                    | they | appear | in urban |     |                                            |     |                                   |     |         |               |
|           |          |           |                             |      |        |          |     | the duration                               |     | of source occurrences             | in  | the set | can vary from |
noise complaints, as noted in the previous section. The 1-2s(e.g.gunshotsounds)toover30s(continuoussounds
datasetiscalledUrbanSound. Duetothemanualannotation such as jackhammers or idling engines).
effort required (see below) we limited the number of classes For research on sound source identification, we created
to10,whichweconsideragoodstartingpoint. Weintendto an additional subset of short audio snippets which we call
extend it to more classes in future iterations. For a review the UrbanSound8K subset, also available online. In [5] the
of existing datasets and related literature cf. footnote 2. authorsconductedalisteningtestandfoundthat4seconds
Beforecompilingthedataset,wesetthreemaingoals: (1) weresufficientforsubjectstoidentifyenvironmentalsounds
| it should | contain | sounds | that occur | in  | an urban | environ- |     |     |     |     |     |     |     |
| --------- | ------- | ------ | ---------- | --- | -------- | -------- | --- | --- | --- | --- | --- | --- | --- |
with82%accuracy,andconsequentlyusea4sclipduration
| ment, | (2) all | recordings | must be | real | field-recordings, |     | (3) |                                                |     |     |     |     |           |
| ----- | ------- | ---------- | ------- | ---- | ----------------- | --- | --- | ---------------------------------------------- | --- | --- | --- | --- | --------- |
|       |         |            |         |      |                   |     |     | intheirexperimentswithautomaticclassification. |     |     |     |     | Following |
1https://nycopendata.socrata.com/data 3http://www.freesound.org
2http://serv.cusp.nyu.edu/projects/urbansounddataset/ 4http://audacity.sourceforge.net/

|                              |     |     | (a) |     |     |     |     |                            |     |     | (a) |     |     |                 |     |
| ---------------------------- | --- | --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- | --- | --- | --- | --------------- | --- |
| )setunim( noitarud latoT 400 |     |     |     |     |     |     |     | ycarucca noitacifissalC 80 |     |     |     |     |     |                 |     |
| 350                          |     |     |     |     |     |     |     | 70                         |     |     |     |     |     |                 |     |
| 300                          |     |     |     |     |     |     |     | 60                         |     |     |     |     |     |                 |     |
| 250                          |     |     |     |     |     |     |     |                            |     |     |     |     |     | SVM_rbf         |     |
| 200                          |     |     |     |     |     | FG  |     | 50                         |     |     |     |     |     | RandomForest500 |     |
|                              |     |     |     |     |     | BG  |     | 40                         |     |     |     |     |     | IBk5            |     |
| 150                          |     |     |     |     |     |     |     | 30                         |     |     |     |     |     | J48             |     |
100
| 50  |        |             |             |             |             |     |     | 20  |     |     |     |     |     | ZeroR |     |
| --- | ------ | ----------- | ----------- | ----------- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- |
|     | 0stree |             |             |             |             |     |     | 10  |     |     |     |     |     |       |     |
|     | child  | dog b air c | drill jackh | engin siren | car h gun s |     |     | 0   |     |     |     |     |     |       |     |
|     |        |             | (b)         |             |             |     |     | 10  | 9   | 8 7 | 6 5 | 4 3 | 2   | 1     |     |
(b)
| 1000       |     |     |     |     |     |     |     | ycarucca noitacifissalC 100 |     |     |     |     |     | air conditioner  |     |
| ---------- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- | --- | --- | ---------------- | --- |
|            |     |     |     |     |     |     |     | 90                          |     |     |     |     |     | car horn         |     |
| 800        |     |     |     |     |     |     |     |                             |     |     |     |     |     | children playing |     |
| secilS 600 |     |     |     |     |     | FG  |     | 80                          |     |     |     |     |     | dog bark         |     |
BG
| 400 |     |     |     |     |     |     |     | 70  |     |     |     |     |     | drilling |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- |
engine idling
| 200 |     |     |     |     |     |     |     | 60  |     |     |     |     |     | gun shot |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- |
jackhammer
0stree child dog b air c drill jackh engin siren car h gun s 50 police siren
40
Figure 2: (a) Total occurrence duration per class in 10 9 8 7 6 5 4 3 2 1 street music
Maximum slice duration (s)
| UrbanSound. |     | (b)SlicesperclassinUrbanSound8K. |     |     |     |     |        |     |                   |     |          |     |            |     |       |
| ----------- | --- | -------------------------------- | --- | --- | --- | --- | ------ | --- | ----------------- | --- | -------- | --- | ---------- | --- | ----- |
|             |     |                                  |     |     |     |     | Figure |     | 3: Classification |     | accuracy |     | vs maximum |     | slice |
Breakdownbyforeground(FG)/background(BG).
|     |     |     |     |     |     |     | duration: |     | (a) | by classifier, |     | (b) by | class | for SVM. |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | -------------- | --- | ------ | ----- | -------- | --- |
their findings, we set a maximum occurrence duration limit for training and testing, which can lead to artificially high
of 4 seconds, and segment longer occurrences into 4 s slices classification accuracies. To avoid this, we designed a ran-
usingaslidingwindowwithahopsizeof2s. Toavoidlarge domallocationprocessofslicesintofoldssuchthatallslices
differences in the class distribution, we set a limit of 1000 originating from the same Freesound recording go into the
slicesperclass,resultinginatotalof8732labeledslices(8.75 same fold, whilst trying to balance the number of slices-per
hours). ThedistributionofslicesperclassinUrbanSound8K fold for each sound class. The UrbanSound8K subset avail-
with a breakdown into salience is provided in Figure 2(b). able online provides the audio slices grouped into 10 folds
|     |     |     |     |     |     |     | generated |     | using | this methodology. |     | In  | this way, | researchers |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | ----- | ----------------- | --- | --- | --------- | ----------- | --- |
4. SOUNDCLASSIFICATION interestedincomparingtheirresultstoourbaselineareguar-
|                                    |          |              |                     |                  |                       |     | anteed | unbiased   |     | and comparable |     | results. |      |          |       |
| ---------------------------------- | -------- | ------------ | ------------------- | ---------------- | --------------------- | --- | ------ | ---------- | --- | -------------- | --- | -------- | ---- | -------- | ----- |
| In order                           | to learn | about        | the characteristics |                  | and challenges        |     |        |            |     |                |     |          |      |          |       |
| presented                          | by this  | new dataset, | we                  | run a            | set of classification |     | 4.3    | Results    |     |                |     |          |      |          |       |
| experimentsusingabaselineapproach. |          |              |                     | Notethatwearenot |                       |     |        |            |     |                |     |          |      |          |       |
|                                    |          |              |                     |                  |                       |     |        | In Section | 3   | we motivated   | our | choice   | of 4 | s as the | maxi- |
searching for an optimal combination of feature/classifier mum slice duration for UrbanSound8K. In this first experi-
parameters to maximize accuracy, but rather are interested mentweexaminehowthechoiceofthisthresholdaffectsthe
in learning about the characteristics of the dataset itself. performance of the baseline approach. To this end, we gen-
|     |     |     |     |     |     |     | erated | 10  | copies | of UrbanSound8K, |     | each | time | varying | the |
| --- | --- | --- | --- | --- | --- | --- | ------ | --- | ------ | ---------------- | --- | ---- | ---- | ------- | --- |
4.1 Featureextraction
|     |     |     |     |     |     |     | maximum |     | slice | duration | from | 10 s down | to  | 1 s. To | ensure |
| --- | --- | --- | --- | --- | --- | --- | ------- | --- | ----- | -------- | ---- | --------- | --- | ------- | ------ |
Inallofthefollowingexperiments,weextractMel-Frequency the observed changes in accuracy are not an artifact of a
CepstralCoefficients(MFCC)fromtheaudioslicesusingthe
|          |       |          |              |       |              |     | specific  |     | classification | algorithm, |        | we compare |      | 5 different | al-    |
| -------- | ----- | -------- | ------------ | ----- | ------------ | --- | --------- | --- | -------------- | ---------- | ------ | ---------- | ---- | ----------- | ------ |
| Essentia | audio | analysis | library [1]. | MFCCs | are commonly |     |           |     |                |            |        |            |      |             |        |
|          |       |          |              |       |              |     | gorithms: |     | decision       | tree       | (J48), | k-NN (k    | =5), | random      | forest |
usedinenvironmentalsoundanalysis(includingrecentwork
|     |     |     |     |     |     |     | (500 | trees), | support | vector | machine |     | (radial | basis function |     |
| --- | --- | --- | --- | --- | --- | --- | ---- | ------- | ------- | ------ | ------- | --- | ------- | -------------- | --- |
[4])andfrequentlyusedasacompetitivebaselinetobench- kernel), and a baseline majority vote classifier (ZeroR).
marknoveltechniques[7]. Inallexperimentsweextractthe The results are presented in Figure 3(a). The difference
featuresonaper-framebasisusingawindowsizeof23.2ms in performance between all classifiers is statistically signif-
and50%frameoverlap. Wecompute40Melbandsbetween icant (paired t-test with p < 0.001) except for the top two
0and22050Hzandkeepthefirst25MFCCcoefficients(we (SVM and random forest). More importantly, we observe
donotapplyanypre-emphasisnorliftering). Theper-frame consistent behavior across all classifiers – performance re-
valuesforeachcoefficientaresummarizedacrosstimeusing mainsstablefrom10to6s,afterwhichitstartsdecreasing
thefollowingsummarystatistics: minimum,maximum,me- gradually. However, if we consider the top performing clas-
| dian, mean, | variance, | skewness, | kurtosis |              | and the mean | and  |         |        |                |             |               |               |             |                 |        |
| ----------- | --------- | --------- | -------- | ------------ | ------------ | ---- | ------- | ------ | -------------- | ----------- | ------------- | ------------- | ----------- | --------------- | ------ |
|             |           |           |          |              |              |      | sifier  | (SVM), |                | there is no | statistically |               | significant | difference      |        |
| variance    | of the    | first and | second   | derivatives, | resulting    | in a |         |        |                |             |               |               |             |                 |        |
|             |           |           |          |              |              |      | between |        | performance    | using       | 6s            | slices and    | 4s          | slices (whereas |        |
| feature     | vector of | dimension | 225 per  | slice.       |              |      |         |        |                |             |               |               |             |                 |        |
|             |           |           |          |              |              |      | below   | 4s     | the difference |             | becomes       | significant), |             | in accordance   |        |
|             |           |           |          |              |              |      | with    | [5]    | and supporting |             | the choice    | of            | 4 s slices  | for             | Urban- |
4.2 Experimentalsetup
|     |     |     |     |     |     |     | Sound8K. |     | Further | insight | can | be gained | by  | observing | the |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | ------- | ------- | --- | --------- | --- | --------- | --- |
To experiment with different classification algorithms we per-class accuracies for the SVM, provided in Figure 3(b).
use the Weka data mining software [9]. Every experiment We see that different sound classes are affected differently
is run using 10-fold cross validation. Within each fold we by the slice duration: classes such as gun shot and siren
perform correlation-based attribute selection to avoid over- havefasteventsthatareclearlyidentifiableatshorttempo-
fittingthetrainingdata. Asitisnotourgoaltofindanop- ralscalesandarethusmostlyunaffectedbyduration;while
timal parametrization, all classification algorithms are used classes such as street music and children playing drop al-
with their default parameter settings. For each experiment most monotonically, showing the importance of analyzing
we report the average accuracy across all 10 folds. them at longer temporal scales and suggesting multi-scale
Important care must be taken when creating the folds – analysis could be a relevant path for urban sound research.
sincetherearemultipleslicescomingfromthesameoriginal To understand the relative difference in performance be-
recording, if we generate the folds completely randomly, we tween classes, we examined the confusion matrix for the
may end up with slices from the same recording used both SVM classifier on UrbanSound8K. We found that the clas-

| 100 |     |     |     |     |     |     |     | 6. ACKNOWLEDGMENTS                          |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| 80  |     |     |     |     |     |     |     | ThisworkwassupportedbyaseedgrantfromNewYork |     |     |     |     |     |     |     |
ycarucca noitacifissalC
University’sCenterforUrbanScienceandProgress(CUSP).
60
Both FG
BG
| 40     |             |             |             |       |             |       |     | 7. REFERENCES |           |           |       |            |             |         |     |
| ------ | ----------- | ----------- | ----------- | ----- | ----------- | ----- | --- | ------------- | --------- | --------- | ----- | ---------- | ----------- | ------- | --- |
| 20     |             |             |             |       |             |       |     | [1] D.        | Bogdanov, | N.        | Wack, | E. G´omez, | S.          | Gulati, |     |
|        |             |             |             |       |             |       |     | P. Herrera,   |           | O. Mayor, |       | G. Roma,   | J. Salamon, |         |     |
| 0air c | car h child | dog b drill | engin gun s | jackh | siren stree | All   |     |               |           |           |       |            |             |         |     |
Figure 4: Accuracy as a function of salience. J. Zapata, and X. Serra. ESSENTIA: an open-source
|     |     |     |     |     |     |     |     | library | for | sound | and music | analysis. |     | In 21st ACM |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --- | ----- | --------- | --------- | --- | ----------- | --- |
sifier mostly confuses three pairs of classes: air condition- Int. Conf. on Multimedia, pages 855–858, 2013.
ersandidlingengines,jackhammersanddrills,childrenand [2] A. L. Brown, J. Kang, and T. Gjestland. Towards
streetmusic. Thismakessense,asthetimbreofeachpairis standardization in soundscape preference assessment.
quite similar (for the last pair the presence of complex har- Applied Acoustics, 72(6):387–392, 2011.
monic tones is a possible cause). We see that the baseline [3] L.-H. Cai, L. Lu, A. Hanjalic, H.-J. Zhang, and L.-H.
bag-of-framesapproachbasedonMFCCsfailsespeciallyon Cai. A flexible framework for key audio effects
wide-band noise-like continuous sounds, and we intend to detection and auditory context inference. IEEE
investigate approaches that better model the temporal dy- TASLP, 14(3):1026–1039, 2006.
namics of energy and timbre as part of future work. [4] S. Chaudhuri and B. Raj. Unsupervised hierarchical
However, the relative similarity between sound classes is structure induction for deeper semantic analysis of
only part of the story. As explained in Section 3, every audio. In IEEE ICASSP, pages 833–837, 2013.
| sound occurrence |          | in the   | dataset     | is also | labeled | with       | a (sub- |             |             |                  |      |                |       |                 |     |
| ---------------- | -------- | -------- | ----------- | ------- | ------- | ---------- | ------- | ----------- | ----------- | ---------------- | ---- | -------------- | ----- | --------------- | --- |
|                  |          |          |             |         |         |            |         | [5] S. Chu, | S.          | Narayanan,       |      | and C.-C.      | Kuo.  | Environmental   |     |
| jective)         | salience | label –  | foreground  | (FG)    | and     | background |         |             |             |                  |      |                |       |                 |     |
|                  |          |          |             |         |         |            |         | sound       | recognition |                  | with | time-frequency |       | audio features. |     |
| (BG, also        | used     | to label | occurrences | where   | there   | are        | other   |             |             |                  |      |                |       |                 |     |
|                  |          |          |             |         |         |            |         | IEEE        | TASLP,      | 17(6):1142–1158, |      |                | 2009. |                 |     |
equally-salient sources). Intuitively, one would expect the [6] C. V. Cotton and D. P. W. Ellis. Spectral vs.
baseline algorithm to do better on slices where there is less spectro-temporal features for acoustic event detection.
backgroundinterference,especiallysinceMFCCsareknown In IEEE WASPAA’11, pages 69–72, 2011.
| tobesensitivetonoise[6]. |     |     | Inthisfinalexperiment,wecom- |     |     |     |     |        |       |           |       |     |                  |     |     |
| ------------------------ | --- | --- | ---------------------------- | --- | --- | --- | --- | ------ | ----- | --------- | ----- | --- | ---------------- | --- | --- |
|                          |     |     |                              |     |     |     |     | [7] D. | P. W. | Ellis, X. | Zeng, | and | J. H. McDermott. |     |     |
paretheperformanceoftheSVMclassifierforeachclassasa
Classifyingsoundtrackswithaudiotexturefeatures.In
| function | of salience, | displayed |     | in Figure | 4. As | expected, | we  |      |         |       |            |     |       |     |     |
| -------- | ------------ | --------- | --- | --------- | ----- | --------- | --- | ---- | ------- | ----- | ---------- | --- | ----- | --- | --- |
|          |              |           |     |           |       |           |     | IEEE | ICASSP, | pages | 5880–5883, |     | 2011. |     |     |
seeaconsiderabledifferenceinperformancebetweensounds
|     |     |     |     |     |     |     |     | [8] D. | Giannoulis, | D.  | Stowell, | E.  | Benetos, | M. Rossignol, |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | ----------- | --- | -------- | --- | -------- | ------------- | --- |
labeledFGandBG,theexceptionbeingsirens,possiblybe-
|               |           |          |        |          |         |          |      | M.         | Lagrange, | and          | M. D.    | Plumbley.      | A     | database  | and |
| ------------- | --------- | -------- | ------ | -------- | ------- | -------- | ---- | ---------- | --------- | ------------ | -------- | -------------- | ----- | --------- | --- |
| cause their   | frequency | content  |        | does not | overlap | with     | most |            |           |              |          |                |       |           |     |
|               |           |          |        |          |         |          |      | challenge  |           | for acoustic | scene    | classification |       | and event |     |
| other sources | (by       | design). | Whilst | we       | cannot  | quantify | the  |            |           |              |          |                |       |           |     |
|               |           |          |        |          |         |          |      | detection. |           | In 21st      | EUSIPCO, |                | 2013. |           |     |
effectofinterferencefromthisexperimentduetothesubjec-
|     |     |     |     |     |     |     |     | [9] M. | Hall, E. | Frank, | G.  | Holmes, | B. Pfahringer, |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | -------- | ------ | --- | ------- | -------------- | --- | --- |
tivityofthelabeling,theresultspointtoanimportantchal-
|                 |     |           |            |               |      |         |         | P. Reutemann, |           | and          | I. H.      | Witten. | The    | WEKA         | data |
| --------------- | --- | --------- | ---------- | ------------- | ---- | ------- | ------- | ------------- | --------- | ------------ | ---------- | ------- | ------ | ------------ | ---- |
| lenge presented |     | by the    | dataset    | – identifying |      | sound   | sources |               |           |              |            |         |        |              |      |
|                 |     |           |            |               |      |         |         | mining        | software: |              | an update. |         | SIGKDD | Explorations |      |
| in the presence |     | of (real) | background | noise.        | This | problem | is      |               |           |              |            |         |        |              |      |
|                 |     |           |            |               |      |         |         | Newsletter,   |           | 11(1):10–18, |            | 2009.   |        |              |      |
anactiveareaofresearch(e.g.[6]),andwebelievethisreal-
|     |     |     |     |     |     |     |     | [10] T. | Heittola, | A. Mesaros, |     | A. Eronen, |     | and T. Virtanen. |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --------- | ----------- | --- | ---------- | --- | ---------------- | --- |
worlddatasetwillfurtherempowertheresearchcommunity
|           |         |       |           |         |          |     |     | Audio             | context | recognition |                              | using | audio | event |     |
| --------- | ------- | ----- | --------- | ------- | -------- | --- | --- | ----------------- | ------- | ----------- | ---------------------------- | ----- | ----- | ----- | --- |
| in coming | up with | novel | solutions | to this | problem. |     |     |                   |         |             |                              |       |       |       |     |
|           |         |       |           |         |          |     |     | histograms.In18th |         |             | EUSIPCO,pages1272–1276,2010. |       |       |       |     |
5. SUMMARY [11] T. Heittola, A. Mesaros, A. Eronen, and T. Virtanen.
|     |     |     |     |     |     |     |     | Context-dependent |     |     | sound | event | detection. | EURASIP |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | --- | ----- | ----- | ---------- | ------- | --- |
Automaticurbansoundclassificationcanbenefitavariety
|               |     |               |     |            |     |            |     | JASMP,     | 2013(1), |     | 2013.      |     |       |        |     |
| ------------- | --- | ------------- | --- | ---------- | --- | ---------- | --- | ---------- | -------- | --- | ---------- | --- | ----- | ------ | --- |
| of multimedia |     | applications. | In  | this paper | we  | identified | two |            |          |     |            |     |       |        |     |
|               |     |               |     |            |     |            |     | [12] S. R. | Payne,   | W.  | J. Davies, | and | M. D. | Adams. |     |
mainbarrierstoresearchinthisarea–thelackofacommon
|     |     |     |     |     |     |     |     | Research |     | into the | practical | and | policy | applications | of  |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | -------- | --------- | --- | ------ | ------------ | --- |
taxonomyandthescarcenessoflarge,real-world,annotated soundscape concepts and techniques in urban areas.
data. To address the first issue we presented the Urban DEFRA, HMSO, London, UK, 2009.
| Sound Taxonomy, |     | based | on previous |     | soundscape |     | research |         |                |     |     |            |     |               |     |
| --------------- | --- | ----- | ----------- | --- | ---------- | --- | -------- | ------- | -------------- | --- | --- | ---------- | --- | ------------- | --- |
|                 |     |       |             |     |            |     |          | [13] R. | Radhakrishnan, |     | A.  | Divakaran, | and | P. Smaragdis. |     |
withafocusonsoundclassesfromrealnoise-complaintdata.
|                                   |            |             |        |              |                    |            |          | Audio       | analysis    | for   | surveillance |     | applications. | In      | IEEE |
| --------------------------------- | ---------- | ----------- | ------ | ------------ | ------------------ | ---------- | -------- | ----------- | ----------- | ----- | ------------ | --- | ------------- | ------- | ---- |
| To address                        | the        | second      | issue  | we presented | UrbanSound,        |            | a        |             |             |       |              |     |               |         |      |
|                                   |            |             |        |              |                    |            |          | WASPAA’05,  |             | pages | 158–161,     |     | 2005.         |         |      |
| dataset                           | containing | 27          | hours  | of audio     | with               | 18.5 hours | of       |             |             |       |              |     |               |         |      |
|                                   |            |             |        |              |                    |            |          | [14] R.     | M. Schafer. | The   | Soundscape:  |     | Our           | Sonic   |      |
| manuallylabelledsoundoccurrences. |            |             |        |              | WealsopresentedUr- |            |          |             |             |       |              |     |               |         |      |
|                                   |            |             |        |              |                    |            |          | Environment |             | and   | the Tuning   |     | of the World. | Destiny |      |
| banSound8K,                       | a          | subset      | of the | dataset      | designed           | for        | training |             |             |       |              |     |               |         |      |
|                                   |            |             |        |              |                    |            |          | Books,      | 1993.       |       |              |     |               |         |      |
| sound classification              |            | algorithms. |        | Through      | a                  | series of  | classi-  |             |             |       |              |     |               |         |      |
ficationexperimentswestudiedthechallengespresentedby [15] D. Steele, J. D. Krijnders, and C. Guastavino. The
thedataset,andidentifiedavenuesforfutureresearch: sensi- sensor city initiative: cognitive sensors for soundscape
|     |     |     |     |     |     |     |     | transformations. |     |     | In GIS | Ostrava, | pages | 1–8, 2013. |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | --- | ------ | -------- | ----- | ---------- | --- |
tivitytotemporalscaleintheanalysis,confusionduetotim-
|                 |            |               |                |               |            |            |          | [16] M.  | Xu, C. | Xu, L.     | Duan, | J. S.  | Jin, and | S. Luo.   | Audio |
| --------------- | ---------- | ------------- | -------------- | ------------- | ---------- | ---------- | -------- | -------- | ------ | ---------- | ----- | ------ | -------- | --------- | ----- |
| bre similarity  |            | (especially   | for noise-like |               | continuous |            | sounds), |          |        |            |       |        |          |           |       |
|                 |            |               |                |               |            |            |          | keywords |        | generation | for   | sports | video    | analysis. | ACM   |
| and sensitivity |            | to background |                | interference. |            | We believe | the      |          |        |            |       |        |          |           |       |
|                 |            |               |                |               |            |            |          | TOMCCAP, |        | 4(2):1–23, |       | 2008.  |          |           |       |
| dataset         | will open  | the path      | to             | new an        | exciting   | research   | in       |          |        |            |       |        |          |           |       |
| sound and       | multimedia |               | applications   | with          | a focus    | on         | urban    |          |        |            |       |        |          |           |       |
| environments    | and        | urban         | informatics.   |               |            |            |          |          |        |            |       |        |          |           |       |
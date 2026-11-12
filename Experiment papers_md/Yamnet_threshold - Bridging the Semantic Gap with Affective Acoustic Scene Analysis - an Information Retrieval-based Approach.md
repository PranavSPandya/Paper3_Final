| IberSPEECH     |     | 2022  |          |       |     |     |     |     |     |     |     |     |     |
| -------------- | --- | ----- | -------- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 14-16 November |     | 2022, | Granada, | Spain |     |     |     |     |     |     |     |     |     |
Bridging the Semantic Gap with Affective Acoustic Scene Analysis: an
|     |     |     |     | Information |     | Retrieval-based |     | Approach |     |     |     |     |     |
| --- | --- | --- | --- | ----------- | --- | --------------- | --- | -------- | --- | --- | --- | --- | --- |
ClaraLuis-Mingueza ,EstherRituerto-Gonza´lez ,CarmenPela´ez-Moreno
|     |     |     |     |     | ∗   |     |     | ∗   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
DepartmentofSignalTheoryandCommunications,
UniversityCarlosIIIofMadrid,Spain
clmingueza@tsc.uc3m.es, erituert@ing.uc3m.es, carmen@tsc.uc3m.es
Abstract
|     |     |     |     |     |     |     | and valence–was |     | attributed | to the | co-evolution | of  | speech and |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --- | ---------- | ------ | ------------ | --- | ---------- |
musicfrommultimodalaffectbursts,includingtheintegration
| Human emotions |     | induce | physiological | and | physical | changes |     |     |     |     |     |     |     |
| -------------- | --- | ------ | ------------- | --- | -------- | ------- | --- | --- | --- | --- | --- | --- | --- |
ofnaturesoundsforexpressiveeffects.However,thesefindings
| in the body | and | can ultimately |     | influence | our actions. | Their |       |             |        |       |            |                 |     |
| ----------- | --- | -------------- | --- | --------- | ------------ | ----- | ----- | ----------- | ------ | ----- | ---------- | --------------- | --- |
|             |     |                |     |           |              |       | where | established | on the | basis | of enacted | and spontaneous |     |
studybelongstothefieldofAffectiveComputing,toimprove
|                |     |             |        |          |     |               | emotional  | speech,   | music       | and general | sound | events  | [4] in     |
| -------------- | --- | ----------- | ------ | -------- | --- | ------------- | ---------- | --------- | ----------- | ----------- | ----- | ------- | ---------- |
| human-computer |     | interaction | tasks. | Defining |     | an ’affective |            |           |             |             |       |         |            |
|                |     |             |        |          |     |               | isolation. | Targeting | an holistic | model       | that  | is able | to explain |
acoustic scene’ as an acoustic environment that can induce affect in sound, we aim to characterize the emotions elicited
specificemotions,inthisworkweaimtocharacterizeacoustic by being immersed in a specific acoustic scene, taking into
scenes that elicit affective states regarding the acoustic events accounttheacousticinformationintheenvironmentasawhole.
occurring and the available acoustic information. This is In particular, we adopt a setup based on information retrieval
achieved by generating emotion embeddings to define the classical methods to produce a representation of the affective
’affective acoustic fingerprint’ of such affective acoustic acousticscenebasedonthewell-knowntf-idf(term-frequency
| scenes. | We use | YAMNet, | an  | acoustic | events’ | classifier |           |          |            |     |           |         |          |
| ------- | ------ | ------- | --- | -------- | ------- | ---------- | --------- | -------- | ---------- | --- | --------- | ------- | -------- |
|         |        |         |     |          |         |            | – inverse | document | frequency) |     | algorithm | [5] –an | approach |
trainedinAudiosettoclassifyacousticeventsintheWEMAC
|             |                   |          |      |                 |         |            | based on | information | theory– | [6],      | where we   | build     | the vector |
| ----------- | ----------------- | -------- | ---- | --------------- | ------- | ---------- | -------- | ----------- | ------- | --------- | ---------- | --------- | ---------- |
| Audiovisual | stimuli           | dataset. | Each | video           | in this | dataset is |          |             |         |           |            |           |            |
|             |                   |          |      |                 |         |            | space of | acoustic    | events  | occurring | in a scene | balancing | the        |
| labelled    | by crowd-sourcing |          | with | the categorical |         | emotion it |          |             |         |           |            |           |            |
acousticeventfrequencyandtheinversescenefrequency.
| induces. | Thus   | we determine | the  | relevance | of            | the detected |             |       |              |            |         |              |         |
| -------- | ------ | ------------ | ---- | --------- | ------------- | ------------ | ----------- | ----- | ------------ | ---------- | ------- | ------------ | ------- |
|          |        |              |      |           |               |              | To          | infer | the emotions | embeddings | space,  | we           | use the |
| acoustic | events | that induce  | each | emotion   | by performing | an           |             |       |              |            |         |              |         |
|          |        |              |      |           |               |              | UC3M4Safety |       | audio-visual | stimuli    | dataset | [7] designed | to      |
affective acoustic mapping, creating interpretable acoustic collect the multimodal dataset WEMAC recently released [8]
fingerprints of such emotions, by means of the well-known and specifically designed to portray the emotion of fear. By
information-retrieval-based TF-IDF algorithm. This paper using the cosine similarity function, we find that the tf-idf
intendstoshedlightonthepathtothedefinitionofemotional
|     |     |     |     |     |     |     | representation |     | embeddings | show | the acoustic | similarity | of  |
| --- | --- | --- | --- | --- | --- | --- | -------------- | --- | ---------- | ---- | ------------ | ---------- | --- |
acousticembeddings.
|              |     |          |        |           |            |          | emotionsasexpressedinthedataset. |     |     |     | Notethatthisemotional |     |     |
| ------------ | --- | -------- | ------ | --------- | ---------- | -------- | -------------------------------- | --- | --- | --- | --------------------- | --- | --- |
| Index Terms: |     | acoustic | scene, | affective | computing, | acoustic |                                  |     |     |     |                       |     |     |
categorizationisdifferent(andcouldbecomplementary)tothe
events,emotionembeddings
|     |     |     |     |     |     |     | classical | Acoustic      | Scene   | Classification | and          | Detection | where |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------------- | ------- | -------------- | ------------ | --------- | ----- |
|     |     |     |     |     |     |     | scenes    | are typically | related | to             | the physical | places    | to be |
1. Introduction characterized,e.g.airport,metrostationorurbanpark.
AcousticSceneAnalysisandInterpretationaimstoexplainthe Theremainderofthispaperisorganisedasfollows.Section
acoustic information in the environment often captured by a 2 outlines the state of the art regarding acoustic scenes and
multi-microphone acquisition system [1]. In this paper, we emotions.InSection3,weintroducethedatasetandtechniques
wanttocontributetothefieldbyinvestigatingtherelationship used. Sections 4 and 5 describe the application of the
between acoustic scenes and the emotions they can elicit, in tf-idfmethodtodeterminetheaffectiveacousticfingerprintor
a new task that could be termed as affective acoustic scene emotionembeddingsandtheresults,andSection6containsthe
| analysis. |     |     |     |     |     |     | closingconclusionsandfurtherwork. |     |     |     |     |     |     |
| --------- | --- | --- | --- | --- | --- | --- | --------------------------------- | --- | --- | --- | --- | --- | --- |
Anyreal-lifeenvironmentwherewefindourselvesincan
elicitemotionsinus,e.g.,atrafficjam,aparadisaicalbeach,a 2. RelatedWork
thunderstorm,birdsong,...Somethingsimilarhappenswhenwe
OneofthebarriersforresearchinAffectiveComputingisthe
visualizeandlistentoasituationoccurringinanenvironment.
|     |     |     |     |     |     |     | scarcity | of labeled | datasets | and the | moderate | size | of the few |
| --- | --- | --- | --- | --- | --- | --- | -------- | ---------- | -------- | ------- | -------- | ---- | ---------- |
Elicitingemotionsthatweexperienceinourlivesbymeansof
|     |     |     |     |     |     |     | available, | due | to the difficulty | to  | label emotions. | There | is no |
| --- | --- | --- | --- | --- | --- | --- | ---------- | --- | ----------------- | --- | --------------- | ----- | ----- |
audiovisualstimuliand,inparticular,thosedrawnfrompopular
universalagreementonhowtocategorizeormeasureemotions,
| culture (e.g., | films, | music | videos, | etc.) | is well | established, |     |     |     |     |     |     |     |
| -------------- | ------ | ----- | ------- | ----- | ------- | ------------ | --- | --- | --- | --- | --- | --- | --- |
andself-assessmentannotationsbyaspecificsubjectcandiffer
sinceaccordingtoEllis“therealityeffectofmovingimagesand
fromthoseannotatedbyobserverexternalevaluators.
soundsinvokesmanyoftheemotionsthatweexperienceduring
|     |     |     |     |     |     |     | Specifically |     | for emotional | speech, | there | are a | number of |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ------------- | ------- | ----- | ----- | --------- |
directencountersinourlivedspaces”[2].Thishasbeenusedto
dataresources(forexample,SUSAS[9],UT-Scope[10],VOCE
determinetheacousticsofemotioninaudio[3]inapioneering
|         |         |          |               |                 |       |              | [11], BioSpeech |     | [12], HEU   | Emotion  | [13]) | that even | contain   |
| ------- | ------- | -------- | ------------- | --------------- | ----- | ------------ | --------------- | --- | ----------- | -------- | ----- | --------- | --------- |
| work to | find an | holistic | computational |                 | model | of affect in |                 |     |             |          |       |           |           |
|         |         |          |               |                 |       |              | other types     | of  | biosignals. | However, | there | are not   | annotated |
| sound.  | On it,  | the high | degree        | of cross-domain |       | consistency  |                 |     |             |          |       |           |           |
databases–totheknowledgeoftheauthors–thatincludeacoustic
foundthatencodingthetwomaindimensionsofaffect–arousal
|     |     |     |     |     |     |     | events | and speech | recorded | consequentially. |     | In  | [14], we |
| --- | --- | --- | --- | --- | --- | --- | ------ | ---------- | -------- | ---------------- | --- | --- | -------- |
enrichedBioSpeechwithacousticeventstofillthatgap.
∗Theseauthorscontributedequallytothiswork.
|     |     |     |     |     |     |     | As  | films | are one of | the most                    | effective | ways | to elicit |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | ---------- | --------------------------- | --------- | ---- | --------- |
|     |     |     |     |     |     | 91  |     |       |            | 10.21437/IberSPEECH.2022-19 |           |      |           |

Figure1:WordCloudofacousticlabelsoutputbyYAMNetfor Figure2:WordCloudofacousticlabelsoutputbyYAMNetfor
audiovisualstimuliannotatedas‘Fear’. audiovisualstimuliannotatedas‘Tenderness’.
3. Methodology
emotions [15], our team UC3M4Safety1 recorded a database
3.1. Dataset
forfearrecognitioninthecontextofgender-basedviolencein
theEMPATIA-CM2 project,andthefirstrelease,WEMAC,is In this research, 43 from a total of 79 videos of the
freely available [8]. It includes the set of audiovisual stimuli UC3M4Safety audio-visual stimuli dataset [7] [16] collection
[7, 16] which were displayed to users and we use in this are used to create a standard representation of acoustic
paper.Theywereselectedbyarigorousvalidationprocedureof information and events that induce certain emotions 5. Each
crowd-sourcedannotationsthatrelyonexpertsindiversefields. stimuli lasts between 30 120 seconds, and the collection
−
Thecommonunderlyingrepresentationofemotiontriggers consists of movie clips, ambience scenarios, and video
of sounds, music and speech is discussed in [3], but in spite compilations. In this subset from the first release, each video
of the abundant literature, pointing towards the relevance of isassignedanemotionlabelbycrowd-sourcing,corresponding
theacousticenvironmentandhumanemotionsinthecognitive totheemotionthatitelicitsintheviewers. Ofsuchvideos,19
sciences(e.g. [17]),thereareveryfewstudiesthatinvestigate are categorized as fear and the 24 remaining are labeled with
the relationship between acoustic events and the elicitation categoriesofother9discreteemotions.
of emotions [4] and scarcely any investigate the relationship
betweenfearandsounds[18]. 3.2. AcousticEventsClassifier
Fortunately, the DCASE community3 has been releasing The data we use is the audio component only from the
severaldatasetsforthedetectionandclassificationofacoustic audiovisual stimuli collection. It contains different types of
scenes and events since 2013. This has fostered a wealth of sounds –speech, music, sound effects– that, along with the
research contributions in this field. Moreover, a large-scale visualinformation,induceintheviewersthelabeledemotions.
dataset of manually annotated audio events, AudioSet [19], Toidentifytheacousticeventsoccurringinthedataweemploy
triggered the investigation in deep learning models, several apre-trainedsoundeventclassificationmodel:YAMNet[20].
openedtotheresearchcommunitysuchasYAMNet[20]. This
offersarobustalternativefortherepresentationoftheacoustic
3.3. TermFrequency-InverseDocumentFrequency
environmentthatcanbetransferredtootherdomainsandtasks
suchasaffectiveacousticsceneanalysis,theonewetarget. TF-IDF (term frequency - inverse document frequency) [5] is
a statistical method widely applied in Information Retrieval
In the particular domain of Affective Sound Datasets, a
that evaluates how relevant a word is to a document in a
large-scale dataset called ARAUS [21] allows classification
collectionofdocuments. Thisimportanceisgivenbyascore,
with high-parameter models. However the perceptual labels
result of multiplying two metrics: the number of times such
available do not refer to a specific emotion but rather to the
word appears in a document (TF), and the inverse document
pleasantness,calmnessorvibrancyofthesounds,inagreement
frequencyofthewordacrossasetofdocuments(IDF).
withISO/TS12913-2[22]. Beingabletotrainhigh-parameter
It works by increasing the score proportionally to the
modelswasdesirablebutnotrequiredforourpurposes.
numberoftimesawordappearsinadocument,butdecreasingit
The Emo-Soundscapes dataset [23] consists on 1,213
whenthenumberofdocumentsthatcontainsuchwordarehigh.
syntheticmixesof6sduration. Theaudioeventsareextracted
ThehighertheTF-IDFscoreofaword,themorerelevantitis
from Freesound4 and each mix includes affective annotations
inthatparticularcollectionofdocuments.TheseTF-IDFscores
based on the Self-Assessment Manikin (SAM) [24] (valence
couldbefedtomachinelearningalgorithmsaswordvectorsas
and arousal). However, for the purpose of this work it was
theyareawayofrepresentingthedata.
preferabletoconsideradatasetthatalsoprovideslabelsrelated
InthispaperwemakeuseoftheTF-IDFalgorithm,taking
tothedominanceoftheemotion.
theacousticeventlabelspredictedbyYAMNetaswords, and
To the authors’ knowledge, no prior work focuses on the
the audio stimuli eliciting emotions as documents, where our
intrinsic emotional information of a soundscape and proposes
setofaudiostimuliisequivalenttothecollectionofdocuments.
amethodtofinddirectandunsupervisedrelationsbetweenthe
We obtain a vector of tf-idf scores per clip –with one value
audioeventsofanacousticsceneanditselicitedemotion. peracousticeventlabel–whichrepresentstheaffectiveacoustic
fingerprintofpotentialemotionaltriggersofeachvideo.
1https://www.uc3m.es/instituto-estudios-genero/
UC3 2 M h 4 t S t a p f s e : t / y /www.uc3m.es/instituto-estudios-genero/ 5The UC3M4Safety Audio-visual Stimuli Database is Available in: 1)
Audiovisual Stimuli https://edatos.consorciomadrono.es/
EMPATIA
dataset.xhtml?persistentId=doi:10.21950/LUO1IZ and
3https://dcase.community/
2) Emotional Labels https://edatos.consorciomadrono.es/
4https://freesound.org/ dataset.xhtml?persistentId=doi:10.21950/CXAAHR
92

| 3.4. CosineDistance |     |     |     |     |     |     |     |     | edutilpmA mrofevaW |     |     |     |     |
| ------------------- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------ | --- | --- | --- | --- |
0.5
| With the            | purpose | of computing |                  | the similarity |        | between each |     |     |     |     |     |     |     |
| ------------------- | ------- | ------------ | ---------------- | -------------- | ------ | ------------ | --- | --- | --- | --- | --- | --- | --- |
| pair of TF-IDF      |         | vectors      | of each          | video          | of the | UC3M4Safety  |     |     | 0.0 |     |     |     |     |
| dataset collection, |         | we           | use a similarity |                | metric | based on the |     |     |     |     |     |     |     |
0.5
| cosinedistance(detailedinEq. |     |     |     | 1). Cosinesimilarityiswidely |     |     |     |     |     |     |     |     |     |
| ---------------------------- | --- | --- | --- | ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
used in information retrieval as a simple and effective way of 0 100000200000300000400000500000600000700000
|                                                           |            |      |           |          |     |              |     |     | 60               |     | Time |     |     |
| --------------------------------------------------------- | ---------- | ---- | --------- | -------- | --- | ------------ | --- | --- | ---------------- | --- | ---- | --- | --- |
| providingausefulmeasurementofhowsimilartwodocuments       |            |      |           |          |     |              |     |     | snib margortcepS |     |      |     |     |
| arelikelytobe,independentlyofthelengthofsuchdocuments.    |            |      |           |          |     |              |     |     | 40               |     |      |     |     |
| Thus, as                                                  | our videos | have | different | lengths, | we  | rely on this |     |     |                  |     |      |     |     |
| distancetomeasurethesimilaritybetweentheaffectiveacoustic |            |      |           |          |     |              |     |     | 20               |     |      |     |     |
embeddingsrepresentedbythetf-idfvectors.
0
|     |     |     |     |     |     |     |     |     | 0 1000 |     | 2000 | 3000 | 4000 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | ---- | ---- | ---- |
Speech
|     | 4.  | ExperimentalSetup |     |     |     |     |     |     | Music |     |     |     |     |
| --- | --- | ----------------- | --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- |
Heart sounds, heartbeat
| Inordertoperformtheaffectiveacousticsceneanalysiswefirst |     |     |     |     |     |     |     |     | Throbbing |     |     |     |     |
| -------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
Hum
| extractsoundeventsfromtheaudiowaveformsthatallowusto |     |     |     |     |     |     |     |     | Vehicle |     |     |     |     |
| ---------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | ------- | --- | --- | --- | --- |
Noise
| characterize | the | acoustic | scene | with YAMNet. |     | Our goal here |     |     | Beatboxing |     |     |     |     |
| ------------ | --- | -------- | ----- | ------------ | --- | ------------- | --- | --- | ---------- | --- | --- | --- | --- |
Rattle
Heart murmur
istoobtainacorpusofweightedlabelscoresthatrepresentthe 0 10 20 30 40
| occurring | sound | events | per time | window, | so that | we can later |     |     |     |     |     |     |     |
| --------- | ----- | ------ | -------- | ------- | ------- | ------------ | --- | --- | --- | --- | --- | --- | --- |
establishametricthatmeasureshowclosetheserepresentations Figure 3: YAMNet output of a sample of the UC3M4Safety
are within the gathered video stimulus of the UC3M4Safety audio-visual stimuli datasetwith the temporal representation
audio-visual stimuli dataset. In this paper we are concerned (top),spectrogram(middle,bandsspanning125to7500Hz)
| with the | construction |     | and evaluation | of  | the vector | space of |     |     |     |     |     |     |     |
| -------- | ------------ | --- | -------------- | --- | ---------- | -------- | --- | --- | --- | --- | --- | --- | --- |
andtopeventsfound(bottom).
acousticeventsandthevectorsthatrepresentthedirectionsof
the different emotions. Thus, the following pipeline has been be extremely low, all the scores (probabilities) are log-scaled
appliedandispubliclyavailableonGitHub6. andthenbinarized. Thegoalofthebinarizationistokeepthe
Each of the 43 videos from the collection elicits one events that present a YAMNet output score high enough to
emotion, validated by more than 50 users each7. Both the considerthattheyhaveoccurredandarenotamisinterpretation
acoustic and the visual modality are the ones inducing these of the network. Therefore, the threshold is set to the global
|           |         |     |                 |       |     |              | mean  | value | among all scores | of            | all files, | and     | sound events |
| --------- | ------- | --- | --------------- | ----- | --- | ------------ | ----- | ----- | ---------------- | ------------- | ---------- | ------- | ------------ |
| emotions. | However | it  | is the acoustic | scene | and | context what |       |       |                  |               |            |         |              |
|           |         |     |                 |       |     |              | whose | score | is lower than    | the threshold |            | are not | considered.  |
wewouldliketofurtheranalyze,sinceapartfromspeech,these
Differentoptionsfortheselectionofthisglobalthresholdcould
| audios also | contain | information |     | about | the acoustic | scene that |     |         |                |           |       |          |          |
| ----------- | ------- | ----------- | --- | ----- | ------------ | ---------- | --- | ------- | -------------- | --------- | ----- | -------- | -------- |
|             |         |             |     |       |              |            | be  | further | explored – for | instance, | using | the mean | value of |
causessuchemotions.Thus,wefirstextracttheaudioonlywith
|     |     |     |     |     |     |     | the | output | scores per each | audio-visual | stimuli |     | – in order to |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | --------------- | ------------ | ------- | --- | ------------- |
thecommand-linetoolffmpeg.
Atthepreprocessingstage,theaudiosignalisnormalized, evaluateitseffectsinthefullstudy.
andconvertedto16kHzmono.Thenalog-melspectrogramof Thenextstepinthepipelineistoobtainatext-formcorpus
64binsiscomputedtoextractatime-frequencyrepresentation of the occurring events in the dataset. Thus, each audio file
oftheaudiosignalasanimage.NextweuseYAMNettodetect is treated as a text document composed by terms, which are
andclassifytheacousticeventspresentintheaudiosignalsof thewordsofeachsoundeventreferencedthroughtheinternal
allthevideostimuli. Thetimewindowissetto0.96sandthe identificationcodeprovidedintheAudiosetdatabase(mid).
patch hop is set to 1s. The network outputs one multi-event Finally, we use the TF-IDF 8 algorithm from the sklearn
labelmatrixof521multi-classscoresforeachsecond. PythonlibrarytoobtaintheTF-IDFmatrixforeachofthe43
audiovisualstimuliinthedataset,resultinginascoresmatrixof
| As YAMNet |     | is a | general sound | event | classifier, | it may |     |     |     |     |     |     |     |
| --------- | --- | ---- | ------------- | ----- | ----------- | ------ | --- | --- | --- | --- | --- | --- | --- |
dimensions(43,351).
| produce | very detailed |     | class labels | which | may | not provide |     |     |     |     |     |     |     |
| ------- | ------------- | --- | ------------ | ----- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
useful information to our acoustic characterization given the Weuseasimilaritymetricbasedonthecosinedistancewith
audiovisual stimuli used, but would only make the task and theaimofmeasuringthedistancebetweentheTF-IDFvectors.
descriptions more complex. So considering the Audioset Thiswaywecanunderstandtheunderlyingpatternsthatrelate
Ontology, the children classes of Music and Animal labels the emotions. These affective acoustic embeddings represent
are filtered out, except the classes of Music Mood and Wild eachoftheinstancesinthedataset.
| Animals,whereallsubclassesarekept. |     |     |     |     | Fromthetotalof521 |     |     |                   |     |          |     |     | x y   |
| ---------------------------------- | --- | --- | --- | --- | ----------------- | --- | --- | ----------------- | --- | -------- | --- | --- | ----- |
|                                    |     |     |     |     |                   |     |     | similarity(x,y)=1 |     | cos(θ)=1 |     |     | · (1) |
classesthatYAMNetclassifies,thefilteredonesresultin351. − − x y
|     |     |     |     |     |     |     |     |     |     |     |     | ∥   | ∥∥ ∥ |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---- |
Figs.1and2representthewordcloudofacousticlabelsoutput
whereθistheanglebetweenthetwovectors.
| by YAMNet | for | audiovisual | stimuli | annotated |     | as ’fear’ and |     |     |     |     |     |     |     |
| --------- | --- | ----------- | ------- | --------- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- |
’tenderness’respectively. Asanexampleofavideochosento 5. Results
| elicit‘Fear’asanalysedthroughYAMNet |     |     |     |     | Figure3represents |     |     |     |     |     |     |     |     |
| ----------------------------------- | --- | --- | --- | --- | ----------------- | --- | --- | --- | --- | --- | --- | --- | --- |
InFigure4,asaheatmap,werepresenttheresultofcomputing
| anaudiosignal: |     | atfirstawomanspeakingcanbeheard, |     |     |     | then |     |     |     |     |     |     |     |
| -------------- | --- | -------------------------------- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
Eq.1foreachaudiovisualstimuliwithitslabeledemotionwith
astrongnoisesimilartoasquealfollowedbyanenginesound
respecttotherestofaudiovisualstimuli,withatotalof37,after
| occurs at | second | 18. Heartbeat |     | sounds | are present | during the |                    |     |                                     |     |     |     |     |
| --------- | ------ | ------------- | --- | ------ | ----------- | ---------- | ------------------ | --- | ----------------------------------- | --- | --- | --- | --- |
|           |        |               |     |        |             |            | removalofoutliers. |     | Lightercoloursontheheatmaprepresent |     |     |     |     |
lastpartoftheaudio.
|               |         |            |       |           |       |            | higher                              | similarity, | and darker | colours | show              | lower | similarity, |
| ------------- | ------- | ---------- | ----- | --------- | ----- | ---------- | ----------------------------------- | ----------- | ---------- | ------- | ----------------- | ----- | ----------- |
| For           | correct | comparison |       | purposes, | since | the soft   |                                     |             |            |         |                   |       |             |
|               |         |            |       |           |       |            | betweenaffectiveacousticembeddings. |             |            |         | Aseachvideoaimsto |       |             |
| probabilities | for     | acoustic   | event | labels    | from  | YAMNet can |                                     |             |            |         |                   |       |             |
triggerasingleemotion,inthismannerwecanunderstandhow
6https://github.com/erituert/acoustic_information_
retrieval 8https://scikit-learn.org/stable/modules/generated/
7Thediscreteemotionlabelwaschosenbymajorityvoting. sklearn.feature_\extraction.text.TfidfVectorizer.html
93

| V08 V09 |     |     |     |     |         |                                          |     |     | 1.0 |     |     |     |     |
| ------- | --- | --- | --- | --- | ------- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| V10     |     |     |     |     | ANGER   | 1.000.740.690.790.370.370.270.220.580.69 |     |     |     |     |     |     |     |
| V31 V33 |     |     |     |     |         |                                          |     |     | 0.9 |     |     |     |     |
| V43     |     |     |     |     | DISGUST | 0.741.000.910.930.630.430.400.250.550.71 |     |     |     |     |     |     |     |
V13 V15
| V20 |     |     |     |     | FEAR | 0.690.911.000.870.800.360.380.210.450.64 |     |     | 0.8 |     |     |     |     |
| --- | --- | --- | --- | --- | ---- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
V23 V28
| V11     |     |     |     |     |          |                                          |     |     |     |     |     |     | A N G E R  ( 3 )   |
| ------- | --- | --- | --- | --- | -------- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | ------------------ |
| V12     |     |     |     |     | SURPRISE | 0.790.930.871.000.550.500.380.260.570.71 |     |     | 0.7 |     |     |     |                    |
| V14 V16 |     |     |     |     |          |                                          |     |     |     |     |     |     | D IS G U S T  ( 3) |
V17 TEDIUM 0.370.630.800.551.000.200.330.140.300.42 FEAR (16)
| V18 V21 |     |     |     |     |     |                                          |     |     | 0.6 |     |     |     | SURPRISE (2) |
| ------- | --- | --- | --- | --- | --- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | ------------ |
| V22     |     |     |     |     |     |                                          |     |     |     |     |     |     | TEDIUM (1)   |
| V24 V25 |     |     |     |     | JOY | 0.370.430.360.500.201.000.480.580.570.72 |     |     |     |     |     |     | JOY (3)      |
| V29     |     |     |     |     |     |                                          |     |     | 0.5 |     |     |     | CALM 4)      |
V06 V07 CALM 0.270.400.380.380.330.481.000.880.690.71 TENDERNESS (2)
| V30     |     |     |     |            |      |                                          |     |     | 0.4 |     |     |     | HOPE (1)    |
| ------- | --- | --- | --- | ---------- | ---- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | ----------- |
| V03     |     |     |     |            |      |                                          |     |     |     |     |     |     | SADNESS (2) |
| V01 V02 |     |     |     | TENDERNESS |      | 0.220.250.210.260.140.580.881.000.680.66 |     |     |     |     |     |     |             |
| V40     |     |     |     |            |      |                                          |     |     | 0.3 |     |     |     |             |
| V42 V39 |     |     |     |            | HOPE | 0.580.550.450.570.300.570.690.681.000.79 |     |     |     |     |     |     |             |
V41
| V37 V45 |     |     |     |     | SADNESS | 0.690.710.640.710.420.720.710.660.791.00 |     |     | 0.2 |     |     |     |     |
| ------- | --- | --- | --- | --- | ------- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
V05
V34 V36
| REGNA REGNA REGNA TSUGSID TSUGSID TSUGSID | RAEF RAEF RAEF RAEF RAEF RAEF RAEF RAEF RAEF | RAEF RAEF RAEF RAEF RAEF RAEF RAEF ESIRPRUS ESIRPRUS MUIDET | YOJ YOJ YOJ MLAC MLAC MLAC MLAC SSENREDNET SSENREDNET | EPOH SSENDAS SSENDAS |     | REGNA TSUGSID RAEF | ESIRPRUS MUIDET YOJ MLAC | SSENREDNET EPOH SSENDAS |     |     |     |     |     |
| ----------------------------------------- | -------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------- | -------------------- | --- | ------------------ | ------------------------ | ----------------------- | --- | --- | --- | --- | --- |
Figure4: Heatmapofcosinedistance Figure 5: Heatmap of cosine distance similarity Figure 6: t-sne representation
similarity between affective acoustic betweenemotionembeddings. for tf-idf audiovisual stimuli
| embeddings,sortedbyemotions,after |     |     |     |     |     |     |     |     |     | embeddings. |     |     |     |
| --------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --- | --- | --- |
removingoutliers.
eachvideoisrelatedtothewaytherestofthemrepresenteach feeldifferentemotionstothesamestimulidependingontheir
oftheircorrespondingemotions. gender.Thisdeservesfurtherinvestigation.
| The       | outliers       | detection | and removal | was | performed | after   |     |     |     |     |     |     |     |
| --------- | -------------- | --------- | ----------- | --- | --------- | ------- | --- | --- | --- | --- | --- | --- | --- |
| comparing | each affective | acoustic  | embedding   |     | with the  | rest of |     |     |     |     |     |     |     |
6. Conclusions
| embeddingsofthesameemotioncategory. |     |     |     | Forinstance,V32 |     |     |     |     |     |     |     |     |     |
| ----------------------------------- | --- | --- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
wasidentifiedasanoutlierconsideringthatitsembeddinghada In this paper we try to answer the question of whether it
bigdissimilaritywithrespectoftherestofembeddingslabeled is possible to characterize an acoustic scene with respect
withdisgust. Furtheranalysisrevealsthattheacousticcontext to the emotions it elicits. We draw from the premise that
does not match the visual information, since V32–which is a characterizing the affective acoustic scene involves taking
video compilation–contains mostly classical music, similar to into account the acoustic context. And regarding the results
videoslabeledinthecalmcategory,andthereforeitsembedding presented, we seem to have achieved a favourable emotional
issimilartotheselateremotionembeddings. characterization of the acoustic scene in audiovisual material,
Wecanobservethatsimilaremotionspresentalikecoloured being a first start to affective acoustic scene analysis in
clustersinFigure4,meaningthatvideoslabeledwiththesame real-worldenvironments.
| emotion,haveasimilaracousticcharacterization. |       |        |           |                      | OnFigure4, |     |             |            |                  |     |                    |         |          |
| --------------------------------------------- | ----- | ------ | --------- | -------------------- | ---------- | --- | ----------- | ---------- | ---------------- | --- | ------------------ | ------- | -------- |
|                                               |       |        |           |                      |            |     | Other       | indicators | besides          | the | acoustic           | context | –such as |
| fourclusterscanberoughlyobserved:             |       |        |           | abigclusterincluding |            |     |             |            |                  |     |                    |         |          |
|                                               |       |        |           |                      |            |     | information | from       | other modalities |     | (e.g., bio-signals |         | from the |
| anger, disgust,                               | fear, | tedium | surprise, |                      |            |     |             |            |                  |     |                    |         |          |
and another cluster for subject in which the emotion is induced)– could provide
joy, and another cluster for calm and tenderness, and the last additional insight to differentiate and accurately characterize
one including hope and sadness. These four groupings are to acousticembeddingsofemotionaltriggers.
someextentconsistentwiththesimilarityinthePAD(Pleasure,
|          |            |       |        |             |         |      | Two | factors | may be | influencing | the | robustness | of this |
| -------- | ---------- | ----- | ------ | ----------- | ------- | ---- | --- | ------- | ------ | ----------- | --- | ---------- | ------- |
| Arousal, | Dominance) | space | on the | Valence and | Arousal | axes |     |         |        |             |     |            |         |
analysis,first,theagreementamongtheannotatorsthatlabeled
[25]oftheseemotions.
eachvideoandtheirgender,andsecond,theamountofvideos
| Afterwards, | we  | performed | the | mean of | the tf-idf | matrix |     |     |     |     |     |     |     |
| ----------- | --- | --------- | --- | ------- | ---------- | ------ | --- | --- | --- | --- | --- | --- | --- |
for every audiovisual stimuli labeled with the same emotion per each emotion category. In [16] the determination of
category. Inthatmannerwecanunderstandhoweachacoustic the emotional label per audiovisual stimuli when there was
labelimpactsintheclassificationofeachemotion. InFigure5 a strong disagreement between the annotators, was selected
we present the resulting heatmap, from the acoustic point of to be the one annotated by the majority of women. Thus,
view,ofemotionembeddings. Wecanobservehowtheresults the agreement is influenced by the gender of the annotators.
|     |     |     |     |     |     |     | Thus, as | future work, | a more | insightful | analysis |     | with a more |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------------ | ------ | ---------- | -------- | --- | ----------- |
arepromising,assimilaremotionspresentagreatersimilarity
|                  |            |                     |           |                  |             |           | in-depth study | could        | be       | carried    | out using    | the original | set of       |
| ---------------- | ---------- | ------------------- | --------- | ---------------- | ----------- | --------- | -------------- | ------------ | -------- | ---------- | ------------ | ------------ | ------------ |
| betweenthem(e.g. |            | calmandtenderness), |           | thanemotionsthat |             |           |                |              |          |            |              |              |              |
|                  |            |                     |           |                  |             |           | videos –up     | to 79–       | or other | databases  | of acoustic  |              | scenes with  |
| humans           | categorize | as more             | different | (e.g.            | tedium      | and joy). |                |              |          |            |              |              |              |
|                  |            |                     |           |                  |             |           | emotional      | annotations. | The      | annotators | agreement    |              | per gender   |
| In particular,   | the        | fear category       | lays      | close to         | the disgust | and       |                |              |          |            |              |              |              |
|                  |            |                     |           |                  |             |           | as a variable  | can          | also     | be taken   | into account |              | to study its |
surpriselabels,whichhindersthediscriminationbetweenthem
|     |     |     |     |     |     |     | relevance. | Furthermore, |     | using the | tf-idf | vectors | as features, |
| --- | --- | --- | --- | --- | --- | --- | ---------- | ------------ | --- | --------- | ------ | ------- | ------------ |
ifweonlytakeintoaccounttheacousticcontext.
|           |      |         |               |          |            |     | machine | learning | models | could | be fed with | such | data and |
| --------- | ---- | ------- | ------------- | -------- | ---------- | --- | ------- | -------- | ------ | ----- | ----------- | ---- | -------- |
| In Figure | 6 we | plotted | the affective | acoustic | embeddings |     |         |          |        |       |             |      |          |
predictemotionallabelsinsupervisedlearning.
usingthet-snealgorithm.Wecanobservethatthedistancesand
clusteringbetweenthemaresomehowsimilartothegrouping Weconcludethatusingtf-idfwithacousticevents’labelsis
happeninginFig.4. apromisingmethodwithinterpretableresultsforcharacterizing
The relationship between fear and anger is peculiar, an acoustic scene with respect to the emotional information.
as contrary than what we would expect present a great Robustembeddingsthatacousticallycharacterizeemotionscan
similarity.This could be explained taking in to account the beusedtomeasuretheemotionalloadof–ortheemotiontobe
genderbias[16],thatstatesthatincertainsituations,peoplecan elicitedby–theacousticinformationinotherdatabases.
94

7. Acknowledgements
|     |     |     |     |     |     |     |     | [15] Y. Deng, | M.   | Yang,    | and R. | Zhou, | “A new    | standardized |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | ---- | -------- | ------ | ----- | --------- | ------------ |
|     |     |     |     |     |     |     |     | emotional     | film | database | for    | asian | culture,” | Frontiers in |
This work has been partially supported by the Dept. of Psychology, vol. 8, p. 1941, 2017. [Online]. Available:
Research and Innovation of Madrid Regional Authority, https://www.frontiersin.org/article/10.3389/fpsyg.2017.01941
| in the | EMPATIA-CM |     | research |     | project | (reference |     |                      |     |                      |     |     |                        |     |
| ------ | ---------- | --- | -------- | --- | ------- | ---------- | --- | -------------------- | --- | -------------------- | --- | --- | ---------------------- | --- |
|        |            |     |          |     |         |            |     | [16] M. Blanco-Ruiz, |     | C. Sainz-De-Baranda, |     |     | L. Gutie´rrez-Mart´ın, |     |
Y2018/TCS-5046), Grant PDC2021-121071-I00 funded E. Romero-Perales, and C. Lo´pez-Ongil, “Emotion elicitation
by MCINAEI10.13039/501100011033 and by the underaudiovisualstimulireception:Shouldartificialintelligence
European Union “NextGenerationEU/PRTR” and Grant consider the gender perspective?” International Journal of
PID2021-125780NB-I00 funded by AEI. The authors also EnvironmentalResearchandPublicHealth,vol.17,pp.1–22,11
| thank the | Spanish | Ministry |     | of Science, | Innovation |     | and | 2020. |     |     |     |     |     |     |
| --------- | ------- | -------- | --- | ----------- | ---------- | --- | --- | ----- | --- | --- | --- | --- | --- | --- |
Universities(MCIU)fortheFPUgrantFPU19/00448andthe [17] W.MaandW.F.Thompson,“Humanemotionstrackchangesin
restofthemembersofUC3M4Safetyfortheirsupport. theacousticenvironment,”Proc.Natl.Acad.Sci.U.S.A.,vol.112,
no.47,pp.14563–14568,Nov.2015.
|     |     |     |     |     |     |     |     | [18] T.GarnerandM.Grimshaw,“Aclimateoffear: |     |     |     |     | Considerations |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- | --- | --- | -------------- | --- |
8. References
fordesigningavirtualacousticecologyoffear,”inProceedings
[1] B. T. Szabo´, S. L. Denham, and I. Winkler, “Computational ofthe6thAudioMostlyConference:AConferenceonInteraction
ModelsofAuditorySceneAnalysis:AReview,”Front.Neurosci., with Sound, ser. AM ’11. New York, NY, USA: Association
vol.10,Nov.2016. forComputingMachinery, 2011, p.31–38.[Online].Available:
https://doi.org/10.1145/2095667.2095672
| [2] J.Ellis,“Whatareweexpectedtofeel? |     |     |     |     | Witness,textualityand |     |     |     |     |     |     |     |     |     |
| ------------------------------------- | --- | --- | --- | --- | --------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
theaudiovisual,”Screen,vol.50,no.1,pp.67–76,Mar.2009. [19] J. F. Gemmeke, D. P. W. Ellis, D. Freedman, A. Jansen,
[3] F.Weninger,F.Eyben,B.W.Schuller,M.Mortillaro,andK.R. W.Lawrence,R.C.Moore,M.Plakal,andM.Ritter,“Audioset:
Scherer,“OntheAcousticsofEmotioninAudio: WhatSpeech, Anontologyandhuman-labeleddatasetforaudioevents,”inProc.
|        |           |      |             |     |        |           |         | IEEE                      | Intl. Conf. | on Acoustics, |     | Speech | and Signal | Processing |
| ------ | --------- | ---- | ----------- | --- | ------ | --------- | ------- | ------------------------- | ----------- | ------------- | --- | ------ | ---------- | ---------- |
| Music, | and Sound | have | in Common,” |     | Front. | Psychol., | vol. 4, |                           |             |               |     |        |            |            |
| 2013.  |           |      |             |     |        |           |         | (ICASSP),2017,pp.776–780. |             |               |     |        |            |            |
[4] B. Schuller, S. Hantke, F. Weninger, W. Han, Z. Zhang, and [20] M.PlakalandD.Ellis,“Yamnet,”https://github.com/tensorflow/
S. Narayanan, “Automatic recognition of emotion evoked by models/tree/master/research/audioset/yamnet, Accessed:
| general                                        | sound | events,” | in 2012 | IEEE International |     | Conference |        | 2020-12-30.                                              |     |     |     |     |     |     |
| ---------------------------------------------- | ----- | -------- | ------- | ------------------ | --- | ---------- | ------ | -------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
| onAcoustics,SpeechandSignalProcessing(ICASSP). |       |          |         |                    |     |            | Kyoto, |                                                          |     |     |     |     |     |     |
|                                                |       |          |         |                    |     |            |        | [21] K.Ooi,Z.-T.Ong,K.N.Watcharasupat,B.Lam,J.Y.Hong,and |     |     |     |     |     |     |
Japan:IEEE,Mar.2012,pp.341–344.
|                    |     |                                              |     |     |     |     |     | W.-S. | Gan, “Araus: | A   | large-scale | dataset | and baseline | models |
| ------------------ | --- | -------------------------------------------- | --- | --- | --- | --- | --- | ----- | ------------ | --- | ----------- | ------- | ------------ | ------ |
| [5] K.SparckJones, |     | “Astatisticalinterpretationoftermspecificity |     |     |     |     |     |       |              |     |             |         |              |        |
ofaffectiveresponsestoaugmentedurbansoundscapes,”72022.
and its application in retrieval,” Journal of Documentation, [Online].Available:http://arxiv.org/abs/2207.01078
vol.28,no.1,pp.11–21,Jan.1972.
|                |     |                           |     |     |             |     |        | [22] “Iso/ts12913-3 |     | acoustics | soundscape |     | part 3: Data | analysis |
| -------------- | --- | ------------------------- | --- | --- | ----------- | --- | ------ | ------------------- | --- | --------- | ---------- | --- | ------------ | -------- |
| [6] A. Aizawa, |     | “An information-theoretic |     |     | perspective | of  | tf–idf |                     |     |           |            |     |              |          |
(preview),”2019.[Online].Available:www.iso.org
measures,”InformationProcessing&Management,vol.39,no.1,
|     |     |     |     |     |     |     |     | [23] I. of | Electrical | and E. | Engineers, | 2017 | Seventh | International |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ---------- | ------ | ---------- | ---- | ------- | ------------- |
pp.45–65,Jan.2003.
|               |       |     |            |          |       |         |         | Conference | on  | Affective | Computing | and | Intelligent | Interaction |
| ------------- | ----- | --- | ---------- | -------- | ----- | ------- | ------- | ---------- | --- | --------- | --------- | --- | ----------- | ----------- |
| [7] M. Blanco | Ruiz, | L.  | Gutie´rrez | Mart´ın, | J. A. | Miranda | Calero, |            |     |           |           |     |             |             |
(ACII):23-26Oct.2017.
| M. F. | Canabal | Benito, | E.  | Romero | Perales, | C. Sainz | de  |     |     |     |     |     |     |     |
| ----- | ------- | ------- | --- | ------ | -------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
BarandaAndu´jar,R.SanSegundoManuel,D.LarrabeitiLo´pez, [24] M. M. Bradley and P. J. Lang, “Measuring emotion: The
C.Pela´ezMoreno,andC.Lo´pezOngil,“UC3M4SafetyDatabase self-assessment manikin and the semantic differential,” Journal
-ListofAudiovisualStimuli(Video),”2021.[Online].Available: ofBehaviorTherapyandExperimentalPsychiatry,vol.25,no.1,
https://doi.org/10.21950/LUO1IZ pp.49–59,1994.[Online].Available: https://www.sciencedirect.
[8] J. A. Miranda et al., “WEMAC: Women and Emotion com/science/article/pii/0005791694900639
Multi-modal Affective Computing dataset,” Mar. 2022, [25] A. Mehrabian, Basic Dimensions for a General Psychological
arXiv:2203.00456.[Online].Available: https://doi.org/10.48550/ Theory:ImplicationsforPersonality,Social,Environmental,and
arXiv.2203.00456 Developmental Studies. Cambridge: Oelgeschlager, Gunn &
| [9] J. H. | L. Hansen, | “Speech | under | simulated | and | actual | stress | Hain,1980. |     |     |     |     |     |     |
| --------- | ---------- | ------- | ----- | --------- | --- | ------ | ------ | ---------- | --- | --- | --- | --- | --- | --- |
(susas)database.philadelphia:Linguisticdataconsortium,”1999.
[Online].Available:https://catalog.ldc.upenn.edu/LDC99S78
[10] A.Ikeno,V.Varadarajan,S.Patil,andJ.H.L.Hansen,“Ut-scope:
Speechunderlombardeffectandcognitivestress,”in2007IEEE
AerospaceConference,2007,pp.1–7.
[11] A.Aguiar,M.Kaiseler,M.Cunha,J.Silva,M.H.,andP.Almeida,
| “VOCE            | Corpus:       | Ecologically |               | Collected       | Speech | Annotated     |     |     |     |     |     |     |     |     |
| ---------------- | ------------- | ------------ | ------------- | --------------- | ------ | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| with             | Physiological | and          | Psychological |                 | Stress | Assessments,” |     |     |     |     |     |     |     |     |
| in International |               | Conference   |               | of the Language |        | Resources     | and |     |     |     |     |     |     |     |
EvaluationConference,(LREC’14),052014.
| [12] A. Baird, | S.        | Amiriparian, |     | M. Berschneider, |         | M.   | Schmitt, |     |     |     |     |     |     |     |
| -------------- | --------- | ------------ | --- | ---------------- | ------- | ---- | -------- | --- | --- | --- | --- | --- | --- | --- |
| and B.         | Schuller, | “Predicting  |     | biological       | signals | from | speech:  |     |     |     |     |     |     |     |
Introducinganovelmultimodaldatasetandresults,”in2019IEEE
| 21stIntl.Workshop |     | onMultimediaSignal |     |     | Processing | (MMSP), |     |     |     |     |     |     |     |     |
| ----------------- | --- | ------------------ | --- | --- | ---------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
2019,pp.1–5.
[13] J.Chen,C.Wang,K.Wang,C.Yin,C.Zhao,T.Xu,X.Zhang,
| Z.Huang,M.Liu,andT.Yang,“HEUEmotion: |     |             |         |             |     | ALarge-scale |        |     |     |     |     |     |     |     |
| ------------------------------------ | --- | ----------- | ------- | ----------- | --- | ------------ | ------ | --- | --- | --- | --- | --- | --- | --- |
| Database                             | for | Multi-modal | Emotion | Recognition |     | in the       | Wild,” |     |     |     |     |     |     |     |
2020,arXiv:2007.12519.
[14] E.Rituerto-Gonza´lez,C.LuisMingueza,andC.Pela´ez-Moreno,
“UsingAudioEventstoExtendaMulti-modalPublicSpeaking
| Database | with | Reinterpreted |     | Emotional | Annotations,” |     | in  |     |     |     |     |     |     |     |
| -------- | ---- | ------------- | --- | --------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
IberSPEECH2021,032021,pp.61–65.
95
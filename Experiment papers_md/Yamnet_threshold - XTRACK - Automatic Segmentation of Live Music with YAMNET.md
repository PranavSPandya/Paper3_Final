| XTRACK: |     | AUTOMATIC |     |     | SEGMENTATION |     |     | LIVE | MUSIC |      |     | YAMNET |     |
| ------- | --- | --------- | --- | --- | ------------ | --- | --- | ---- | ----- | ---- | --- | ------ | --- |
|         |     |           |     |     |              |     | OF  |      |       | WITH |     |        |     |
FlorianCOLOMBO(florian.colombo@gmail.com)1,2,AlainDUFAUX 1,andDavidePICCA 2
1LausanneFederalInstituteofTechnology(EPFL),Lausanne,Switzerland
2UniversityofLausanne(UNIL),Lausanne,Switzerland
thegreatestartistsandmusicaltrendsofthelast50years.
ABSTRACT
|     |     |     |     |     |     |     | It was | inscribed | in the | UNESCO’s | Memory | of  | the World |
| --- | --- | --- | --- | --- | --- | --- | ------ | --------- | ------ | -------- | ------ | --- | --------- |
Recorded in UNESCO’s Memory of the World Register, Register in 2013, simultaneously with the creation of the
thecollectionofrecordingsofMontreuxJazzFestivalcon-
|     |     |     |     |     |     |     | Claude | Nobs | Foundation | which | is in charge | of  | its preser- |
| --- | --- | --- | --- | --- | --- | --- | ------ | ---- | ---------- | ----- | ------------ | --- | ----------- |
certs represents an invaluable audiovisual resource. Ex- vation. From2007,andintheframeoftheso-calledMon-
pert annotators have segmented the audio recordings to treuxJazzDigitalProject1,EPFLhasbeenresponsiblefor
| separate | the music | pieces | from | live | concert events | such |     |     |     |     |     |     |     |
| -------- | --------- | ------ | ---- | ---- | -------------- | ---- | --- | --- | --- | --- | --- | --- | --- |
inventory,digitization,cataloging,storage,andenrichment
as applause, speeches, and silences. This task is time- of the collection. The Cultural Heritage and Innovation
| consuming | and | several | rounds | are necessary |     | to homoge- |        |         |       |             |     |            |         |
| --------- | --- | ------- | ------ | ------------- | --- | ---------- | ------ | ------- | ----- | ----------- | --- | ---------- | ------- |
|           |     |         |        |               |     |            | center | of EPFL | (CHC) | was created | for | that goal, | gather- |
nize the subjective decision of music borders. In this pa- ingalldataandmetadatainadedicatedrelationaldatabase
per,wepresentXTRACK,analgorithmforautomatedseg- anddefiningnumerousresearch,education,andinnovation
| mentationofmusicpieces. |     |     | Itintegratesthepredictionsof |     |     |     |     |     |     |     |     |     |     |
| ----------------------- | --- | --- | ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
projectstoenrichthecollection.
| the sound | classifier | network | YAMNET |     | to create | accurate |     |     |     |     |     |     |     |
| --------- | ---------- | ------- | ------ | --- | --------- | -------- | --- | --- | --- | --- | --- | --- | --- |
segments. Thealgorithmisdesignedtoisolateeachtrack 1.2 Dataset: CatalogingandIndexing
| fromliveaudiorecordings. |     |     | Finally, |     | weevaluatethealgo- |     |     |         |            |           |        |       |          |
| ------------------------ | --- | --- | -------- | --- | ------------------ | --- | --- | ------- | ---------- | --------- | ------ | ----- | -------- |
|                          |     |     |          |     |                    |     | The | dataset | represents | more than | 11’000 | hours | of video |
rithm’sperformancesonthehuman-labeledMontreuxJazz
|     |     |     |     |     |     |     | and | 6000 | hours of audio, | digitized | in  | uncompressed | for- |
| --- | --- | --- | --- | --- | --- | --- | --- | ---- | --------------- | --------- | --- | ------------ | ---- |
Festivalarchives.
matsordirectlycapturedtoprofessionalbroadcastfilesin
|     |     |     |     |     |     |     | recentyears. |     | Thesamplerateofthedigitalaudiostreamis |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | -------------------------------------- | --- | --- | --- | --- |
1. INTRODUCTION 96kHz(24bitsprecision)whendigitizedfromanalogsup-
port,butitcanbe96,48,or44.1kHz(16or24bits)when
| Recordings            | of  | live music | are                           | numerous | and their | number |          |          |              |         |           |             |             |
| --------------------- | --- | ---------- | ----------------------------- | -------- | --------- | ------ | -------- | -------- | ------------ | ------- | --------- | ----------- | ----------- |
|                       |     |            |                               |          |           |        | captured | in       | a native way | from    | digital   | tapes.      | The associ- |
| isincreasingeveryday. |     |            | Topublishorarchivesuchrecord- |          |           |        |          |          |              |         |           |             |             |
|                       |     |            |                               |          |           |        | ated     | Metadata | consists     | of both | technical | information | ob-         |
ings,onetypicallyneedstosegmentthemintosinglemu-
|            |                                   |     |     |     |     |         | tained | from | digitization | (including | hash | and | media infor- |
| ---------- | --------------------------------- | --- | --- | --- | --- | ------- | ------ | ---- | ------------ | ---------- | ---- | --- | ------------ |
| sictracks: | audiosegmentscontainingonlymusic. |     |     |     |     | Indeed, |        |      |              |            |      |     |              |
mationexports)andconcerts’information(concertname,
therearemanymomentswithoutmusicfromthemoment
titleofthepieces,hall,date,artists’names,associatedin-
| therecordingstartsuntilitends. |     |     |     | Therefore,segmentation |     |     |     |     |     |     |     |     |     |
| ------------------------------ | --- | --- | --- | ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
struments,authors’rights,originaltapeformat)
ofliverecordingsaimstohaveapleasantlisteningexperi-
|     |     |     |     |     |     |     | Since | 2013, | a large project | has | been | developed | to cata- |
| --- | --- | --- | --- | --- | --- | --- | ----- | ----- | --------------- | --- | ---- | --------- | -------- |
enceofindividualtracks.Todoso,studentannotatorswere
|            |                  |     |     |         |                  |     | log | and index | every concert, |     | identifying | series | of events |
| ---------- | ---------------- | --- | --- | ------- | ---------------- | --- | --- | --------- | -------------- | --- | ----------- | ------ | --------- |
| involvedin | indexingeachlive |     |     | concert | recordingfromthe |     |     |           |                |     |             |        |           |
(introduction,song,speech,interlude,applause,encore,or
MontreuxJazzFestival(MJF).Thisconstitutesavaluable
silence), indexingpreciselytheirrespectivestart/endtime
databaseofaudiosegmentation.
locationsinthemediafiles,andverifyingconcertmetadata
| In this   | paper,     | we present    | XTRACK,       |         | a deep-learning | al-     |                                 |               |                |                          |      |            |            |
| --------- | ---------- | ------------- | ------------- | ------- | --------------- | ------- | ------------------------------- | ------------- | -------------- | ------------------------ | ---- | ---------- | ---------- |
|           |            |               |               |         |                 |         | (titles,artists,hall,year,etc). |               |                | Themotivationforthiswork |      |            |            |
| gorithm   | to assist  | people        | in segmenting |         | live music      | record- |                                 |               |                |                          |      |            |            |
|           |            |               |               |         |                 |         | is to                           | be able       | to navigate    | comfortably              |      | across     | the 50’000 |
| ings into | individual | music         | tracks.       | The     | segmentation    | al-     |                                 |               |                |                          |      |            |            |
|           |            |               |               |         |                 |         | songs                           | of the        | live concerts’ | collection,              |      | being able | to prop-   |
| gorithm   | employs    | the           | pre-trained   | audio   | classifier      | YAM-    |                                 |               |                |                          |      |            |            |
|           |            |               |               |         |                 |         | erly                            | and precisely | playback       | them                     | like | in CDs     | or DVDs.   |
| NET [1].  | Our        | contributions |               | are the | post-processing | of      |                                 |               |                |                          |      |            |            |
Consequently,highprecisionisrequiredinthedetermina-
YAMNETpredictionstosegmentaudiofilesinmusicand
|     |     |     |     |     |     |     | tion | of the | start and end | time | indexes | of every | event. In- |
| --- | --- | --- | --- | --- | --- | --- | ---- | ------ | ------------- | ---- | ------- | -------- | ---------- |
non-musicsegmentsandtheperformanceevaluationonthe
dexingisperformedbyspeciallytrainedpeople,whoneed
MJFindexationdata.
extensiveexperienceofthemultiplescenariosthatcanoc-
|     |     |     |     |     |     |     | curwithinsongtransitions. |     |     | Suchscenariosinclude |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- | -------------------- | --- | --- | --- |
1.1 MontreuxJazzFestivalaudiovisualarchives
• Theendofthesongissudden,a1-2secondssilence
| Recorded | in professional |     | quality | video | and | audio since |     |     |     |     |     |     |     |
| -------- | --------------- | --- | ------- | ----- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
timeoccursbeforethepublicstartsapplauding
| the first | edition | in 1967, | the audiovisual |     | collection | of the |     |     |     |     |     |     |     |
| --------- | ------- | -------- | --------------- | --- | ---------- | ------ | --- | --- | --- | --- | --- | --- | --- |
MJF gathers more than 5,000 concerts, representative of • Theendofthesongcanbeeasilyidentifiedandpre-
|     |     |     |     |     |     |     |     | dicted | by the public, | resulting | in  | a mix | of musical |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | -------------- | --------- | --- | ----- | ---------- |
songfade-outandapplausefade-inperiod,followed
| Copyright: | © 2024. | Thisisanopen-accessarticledistributedundertheterms |     |     |     |     |     |     |     |     |     |     |     |
| ---------- | ------- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
5-10secondslaterbyafewwordsfromamusician,
| of the CreativeCommonsAttribution3.0UnportedLicense, |     |     |     |     | which | permits unre- |     |     |     |     |     |     |     |
| ---------------------------------------------------- | --- | --- | --- | --- | ----- | ------------- | --- | --- | --- | --- | --- | --- | --- |
speakingforawhileabouthislastsong
stricteduse,distribution,andreproductioninanymedium,providedtheoriginal
| authorandsourcearecredited. |     |     |     |     |     |     | 1https://go.epfl.ch/mjdp |     |     |     |     |     |     |
| --------------------------- | --- | --- | --- | --- | --- | --- | ------------------------ | --- | --- | --- | --- | --- | --- |
595

Figure1. Ontop,aplotofthewaveformfromaliveconcertrecordingwithtrackstartlabelsfromtheMJFarchivesshown
asverticalbars. Inthemiddle,thefrequencydecompositionofthewaveformwiththeXTRACKpredictionforthestartsof
musicsegmentsshownasverticalbars. Onthebottom,thenormalizedYAMNETpredictionsforthe5musicclassesand7
non-musicclasses.
• Same situation but with the musician speaking im- a probability distribution over 521 classes (e.g.speech,
mediatelyattheverybeginningoftheapplause,say- happy music,toothbrush,...).
ing Thank You! and possibly presenting the musi- In 2013, [4] proposed to automate part of the MJF in-
cianswhilesomemusicgoeson.Thenthenextsong dexation work by detecting occurrences of applause. Of
ischained course,applausedoesnotcorrespondtosongtransitionsin
allcasesbutthepossibilityofasemi-automatedapproach
• Thenextsongstartsimmediatelyduringthefade-in was considered for the indexing work. New AI solutions
| ofthepublicapplause,whichthenrapidlystops. |     |     | No  |     |     |     |     |     |     |     |
| ------------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
suchasYAMNETarepromising,andthequestionisraised
speechfromtheband.
again. Thistimetofullytryandmimichumanwork,tak-
ingthousandsofhoursofindexedconcertsasabenchmark
| • No transition | between | two songs, | a new one starts |     |     |     |     |     |     |     |
| --------------- | ------- | ---------- | ---------------- | --- | --- | --- | --- | --- | --- | --- |
dataset,anewstudywaslaunched,andthefirstoutcomes
| suddenly | in the previous | one, and | the audience ap- |     |     |     |     |     |     |     |
| -------- | --------------- | -------- | ---------------- | --- | --- | --- | --- | --- | --- | --- |
aredescribedinthispaper.
plaudsforashorttimewhilethenewsongstarts.
• The song gets quiet and applause starts but a solo 3. METHODSANDDATA
| moveson.                                 | Applausefadesoutandstopsrapidly, |     | to  |         |                   |          |            |         |                |         |
| ---------------------------------------- | -------------------------------- | --- | --- | ------- | ----------------- | -------- | ---------- | ------- | -------------- | ------- |
|                                          |                                  |     |     | Whereas | the MJF archives’ |          | indexation | follows |                | a well- |
| startagainoverthemusicattheendofthesolo. |                                  |     | The |         |                   |          |            |         |                |         |
|                                          |                                  |     |     | defined | protocol, many    | boundary | decisions  |         | are subjective |         |
musicgoesonforawhilebeforeitsrealcompletion.
|     |     |     |     | anddonotdirectlycorrespondtoaudioevents. |     |     |     |     | Forexam- |     |
| --- | --- | --- | --- | ---------------------------------------- | --- | --- | --- | --- | -------- | --- |
ple,theendofmusicsegmentsdoesnothappenattheend
| Where to       | place the end | and start time | codes of every     |          |                 |          |       |       |       |        |
| -------------- | ------------- | -------------- | ------------------ | -------- | --------------- | -------- | ----- | ----- | ----- | ------ |
|                |               |                |                    | of music | but rather some | flexible | times | later | (from | 0 to 8 |
| song? Criteria | were defined  | for usual      | situations but the |          |                 |          |       |       |       |        |
secondsdependingonthecontextandthesubjectivedeci-
questionisdifficultanddecisionscanoftenbesubjective.
Theindexingworkrequiresextensivetrainingbeforeitcan sionsofthehumanannotators). Fromadeeplearningper-
spective,theseobservationsdirectedusnottotrainamodel
| beperformedreliably. | Consequently,adetailedworkflow |     |     |          |                     |              |     |       |         |     |
| -------------------- | ------------------------------ | --- | --- | -------- | ------------------- | ------------ | --- | ----- | ------- | --- |
|                      |                                |     |     | directly | on these subjective | (inaccurate) |     | data. | Rather, | we  |
wasintroducedwithtwophases,involvingdifferentdocu-
inquiredhowtheaudioclassifierYAMNET[1]canbeused
mentalists,followedbymixedmanualandautomatedqual-
forsegmentingaudiofilesandtakeadvantageoftheMJF
| itychecks, | andweeklyteamdiscussionsforsolvingdiffi- |     |     |     |     |     |     |     |     |     |
| ---------- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
datatovalidatetheboundarydecisionsofXTRACK.
cultoruncertainsituations.
3.1 FromYAMNETpredictionstoaudiosegments
2. RELATEDWORKS
|     |     |     |     | We start | by processing | the audio | of  | live concert |     | record- |
| --- | --- | --- | --- | -------- | ------------- | --------- | --- | ------------ | --- | ------- |
TrainedonGoogle’sAudioSetdatacomprisingover2mil- ingswith YAMNET. Toadapt YAMNET toourtask, we
lion annotated audio clip [2], YAMNET is a deep con- constrain the probability distributions over the complete
volutionalneuralnetworkbasedontheMobileNetsarchi- set of 521 classes to a smaller set of meaningful classes.
tecture [3]. In particular, YAMNET processes audio files XTRACKfocusesonthe5musicclassesand6non-music
(16kHz sampling rate) and outputs at every 48ms frame classes listed in Table 1. The temporal evolution of the
596

| Description        |     |     |     | Equation |     |     |     |     |     | Value   |     |     |         |     |
| ------------------ | --- | --- | --- | -------- | --- | --- | --- | --- | --- | ------- | --- | --- | ------- | --- |
| YAMNETmusicclasses |     |     |     | C        |     |     |     |     |     | [Music, |     |     | Musical |     |
music
|     |     |     |     |     |     |     |     |     |     | instrument, |     |     | Singing, |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --- | --- | -------- | --- |
Drum,Rapping]
|                        |     |     |     |     |           |     |     |     |     | [Silence, |     |     | Speech, |     |
| ---------------------- | --- | --- | --- | --- | --------- | --- | --- | --- | --- | --------- | --- | --- | ------- | --- |
| YAMNETnon-musicclasses |     |     |     | C   | non music |     |     |     |     |           |     |     |         |     |
−
Narration,
|     |     |     |     |     |     |     |     |     |     | monologue, |     |     | Chatter, |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --- | --- | -------- | --- |
Cheering,Applause]
| Probabilitythresholdtoclas- |     |           |          | if   |     | Pr(x[n]=c)>Θ |     |       |     | Θ   | =0.2  |     |     |     |
| --------------------------- | --- | --------- | -------- | ---- | --- | ------------ | --- | ----- | --- | --- | ----- | --- | --- | --- |
|                             |     |           |          |      | c   | Cmu          |     | music |     |     | music |     |     |     |
|                             |     |           |          |      | n∈  | si c         |     |       |     |     |       |     |     |     |
| sify                        | the | nth frame | of audio | then |     | m u sic      |     |       |     |     |       |     |     |     |
! →
filexasmusic
| Probabilitythresholdtoclas- |     |           |         | if   |     | Pr(x[n]=c)<Θ |     |     |       | Θ   |           | =0.1 |     |     |
| --------------------------- | --- | --------- | ------- | ---- | --- | ------------ | --- | --- | ----- | --- | --------- | ---- | --- | --- |
|                             |     |           |         |      | c   | Cmu          |     | non | music |     | non music |      |     |     |
|                             |     |           |         |      | n∈  | si c         |     | −   |       |     | −         |      |     |     |
| sify                        | the | nth frame | as non- | then |     | n o n-music  |     |     |       |     |           |      |     |     |
! →
music
Consecutivemusicframesto ifm [n L music :n] music L music =20[s]
|                       |     |     |     |       | ∈   | −     | →   |     |     |     |     |     |     |     |
| --------------------- | --- | --- | --- | ----- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
| placeamusicstartindex |     |     |     | thenn |     | start |     |     |     |     |     |     |     |     |
→
Consecutive non-music if m [n L non music : n] L non music =4[s]
|                         |     |     |     |           |     | ∈ −  | −   |     | →   |     | −   |     |     |     |
| ----------------------- | --- | --- | --- | --------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
| framestoplaceastopindex |     |     |     | non-music |     |      |     |     |     |     |     |     |     |     |
|                         |     |     |     | thenn     |     | stop |     |     |     |     |     |     |     |     |
→
| Musicstartoffset |     |     |     | start[i] |     | start[i]+d |       |     |     | d     | =     | 0.1[s] |     |     |
| ---------------- | --- | --- | --- | -------- | --- | ---------- | ----- | --- | --- | ----- | ----- | ------ | --- | --- |
|                  |     |     |     |          |     | →          | start |     |     | start |       | −      |     |     |
| Musicstopoffset  |     |     |     | stop[i]  |     | stop[i]+d  |       |     |     | d     | =4[s] |        |     |     |
|                  |     |     |     |          |     |            | stop  |     |     | stop  |       |        |     |     |
→
|     |     |     | Table1. Hyper-parametersoftheXTRACKaudiosegmentationalgorithm. |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | -------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
probability distributions over these classes (e.g. bottom mentation algorithm. To do so, we randomly select ex-
plotofFigure1)istheinputsignalfromwhich XTRACK ampleswherethe XTRACK predictionsandtheMJFdata
infersmusicsegments. differandreporttheaudiocontextsbeforeandafterthese
| Table   | 1 presents | the      | fundamental |      | operations    | of the  | segmentonsets. |     |     |     |     |     |     |     |
| ------- | ---------- | -------- | ----------- | ---- | ------------- | ------- | -------------- | --- | --- | --- | --- | --- | --- | --- |
| XTRACK  | algorithm. |          | To detect   | when | the music     | starts, |                |     |     |     |     |     |     |     |
| we look | for frames | start[i] | where       | the  | probabilities | as-     |                |     |     |     |     |     |     |     |
4. RESULTSANDDISCUSSION
music
| sociated | with | the | class | are above | Θ   | music =0.2 |     |     |     |     |     |     |     |     |
| -------- | ---- | --- | ----- | --------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
Togeneratethefollowingresults,weappliedoursegmen-
| for L | =20 | consecutive | seconds. | After | a   | music start |     |     |     |     |     |     |     |     |
| ----- | --- | ----------- | -------- | ----- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
music
frame has been identified, we look for the next time tation algorithm to 10 years (from 2008 to 2017) of MJF
|     |     |     |     |     |     |     | live | recordings. | It  | takes | less than | 1 minute | for | XTRACK |
| --- | --- | --- | --- | --- | --- | --- | ---- | ----------- | --- | ----- | --------- | -------- | --- | ------ |
framestop[i]wheretheprobabilitiesassociatedwiththe
music class are below Θ =0.1 for L =4 toprocess1hourofaudioonaMacBookProRetina2013
|                     |     |                                 | non | music |     | music |                                 |     |     |     |     |     |     |     |
| ------------------- | --- | ------------------------------- | --- | ----- | --- | ----- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|                     |     |                                 | −   |       |     |       | (CPU2.6GHzIntelCorei5,16GBRAM). |     |     |     |     |     |     |     |
| consecutiveseconds. |     | Weiteratethisprocessuntiltheend |     |       |     |       |                                 |     |     |     |     |     |     |     |
oftheaudiofile.
We then combine these boundary frames to segment the 4.1 Quantitativeevaluation
originalaudiofileintomusicandnon-musicsegments.Ac- In Figure 2 we reported the statistics of the timing dif-
| cording | to the | value of | the class-constrained |     |     | YAMNET |     |     |     |     |     |     |     |     |
| ------- | ------ | -------- | --------------------- | --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
ferencesbetweentheautomaticsegmentationofXTRACK
predictionswithinthenon-musicsegments,wepredictits and the human-labeled MJF data. These values were
content(speech,applause,orsilence)tolabelthepredicted found by aligning predicted and human-labeled indexes.
segmentsautomatically.
|     |     |     |     |     |     |     | XTRACKrecovered75%oftheindexes. |     |     |     |     |     | Outofeverypre- |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------- | --- | --- | --- | --- | --- | -------------- | --- |
Foramorepleasantplaybackofsegmentedmusictracks, dicted start/stop, 75%/60% fall before the human-labeled
we index the start of a music segment d = 0.1[s] timing and 25%/40% after. When XTRACK finds a mu-
start
−
before the predicted start[i] and d stop = 5[s] after the sicsegment, 50%ofthetimeitplacesitsstart/endwithin
detectedstop[i]. 0.9/2.9 seconds from the human-labeled index. These
|     |     |     |     |     |     |     | larger | differences  |     | for the    | music | stops are | expected    | as the  |
| --- | --- | --- | --- | --- | --- | --- | ------ | ------------ | --- | ---------- | ----- | --------- | ----------- | ------- |
|     |     |     |     |     |     |     | MJF    | stop indexes |     | are placed | with  | some      | flexibility | (i.e. a |
3.2 Evaluation
|     |     |     |     |     |     |     | fewsecondsaftertheendofthemusic). |     |     |     |     |     | Insummary,these |     |
| --- | --- | --- | --- | --- | --- | --- | --------------------------------- | --- | --- | --- | --- | --- | --------------- | --- |
To evaluate the segmentation decisions of XTRACK, we statistical values suggest that the playback of individual
compare the algorithm results with the indexed database musictracks,asdeterminedbyXTRACK,willbepleasant
| oftheMJFarchives. |     | Inparticular,welookathowtheon- |     |     |     |     |     |     |     |     |     |     |     |     |
| ----------------- | --- | ------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
andrespecttheactualmusicboundariesoftheliveconcert.
sets of predicted and human-labeled segments differ. In XTRACK decisions are based on several hyper-
theResultssection,wereportthestatisticsofthesetiming parameters (see Table 1). These values were found with
differences. trialanderrortooptimizethealgorithm’squantitativeand
Because of the subjective nature of the indexation pro- qualitative performances. In case the concert setlist is
cess,wealsoconductedaqualitativeevaluationoftheseg- available (the number of individual tracks is known), an
597

Figure2. Densitiesofthetimingdifferencesbetweenthepredictedandhuman-labeledstartsandstopsofmusicsegments.
The density is computed using Gaussian kernel estimators of the python matplotlib.pyplot.violinplot func-
tion. Tobetterunderstandthevalues,wechosetovisualizeseparatelythetimingdifferenceswhenthepredictedtransition
isbefore(tooearly)orafter(toolate)thehuman-labeledindex. Thewidthofthedensitiesrepresentsthenumberofpredic-
tionsfallingineachcategory(beforeorafter). Theverticalbarsindicatethetwoextremaandthe[0.250.50.75]quartiles.
Thevaluesinsecondsare: beforestart[0.56,0.87,2.65],afterstart[0.36,1.04,3.25],beforestop[1.35,2.71,4.07],and
afterstop[1.51,3.45,5.89].
automatedgridsearchoramanualcorrectionforthehyper- basedonwhenthemusicstartsandstops,thesetransitions
parameters values can be performed to find the correct without interruption in the music cannot be detected. In
number of tracks. For example, the number of consecu- these cases, the playback from XTRACK includes more
tivenon-musicframesrequiredtoaddamusicstopindex than one track. However, as the music does not stop, it
canbeadaptedtofindfewerormoretracks. isstillapleasantcuttolistento. Additionalanalysis(e.g.
|     |     |     |     |     |     | byaddingmoreclassestoC |     |     | music andC | non music | )could |
| --- | --- | --- | --- | --- | --- | ---------------------- | --- | --- | ---------- | --------- | ------ |
−
4.2 Qualitativeevaluation help detect changes in musical contents and find these
music-to-musictransitions.
| In Table | 2 we describe | six | randomly | selected | segments |     |     |     |     |     |     |
| -------- | ------------- | --- | -------- | -------- | -------- | --- | --- | --- | --- | --- | --- |
Tosumup,manydifferencesbetweentheXTRACKseg-
| where there | is a difference | between |     | the MJF | indexes and |                                       |     |     |     |           |     |
| ----------- | --------------- | ------- | --- | ------- | ----------- | ------------------------------------- | --- | --- | --- | --------- | --- |
|             |                 |         |     |         |             | mentationandtheMJFdatacanbeexplained. |     |     |     | Theycanbe |     |
theautomatedsegmentationofXTRACK.
|     |     |     |     |     |     | due to subjective | choices |     | in the manual | indexation | of the |
| --- | --- | --- | --- | --- | --- | ----------------- | ------- | --- | ------------- | ---------- | ------ |
10%ofpredictedmusicstartscannotbealignedwiththe
|           |           |            |       |     |             | Montreux Jazz | Archive.   |        | As a final check, | we   | randomly |
| --------- | --------- | ---------- | ----- | --- | ----------- | ------------- | ---------- | ------ | ----------------- | ---- | -------- |
| MJF data. | These are | boundaries | found | by  | XTRACK that |               |            |        |                   |      |          |
|           |           |            |       |     |             | listened to   | individual | tracks | determined        | with | XTRACK.  |
arenotpresentintheMJFdata.Row4ofTable2describes
Theselisteningsessionswerefluidandamorepleasantex-
| suchanevent. | Inthatcase, |     | thisadditionalindexdoesnot |     |     |     |     |     |     |     |     |
| ------------ | ----------- | --- | -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
periencethanlisteningtothefullconcert.
harmthepleasantnessoftheplaybackofindividualmusic
tracks.
| More | than 75% of | music | segments |     | are found by |     |     |     |     |     |     |
| ---- | ----------- | ----- | -------- | --- | ------------ | --- | --- | --- | --- | --- | --- |
5. CONCLUSIONSANDFUTUREWORK
| XTRACK. | The remaining | includes |     | track changes | without |     |     |     |     |     |     |
| ------- | ------------- | -------- | --- | ------------- | ------- | --- | --- | --- | --- | --- | --- |
interruptioninthemusic. Inparticular,25%ofthemusic Inthisstudy,weintroducedXTRACK,aninnovativealgo-
rithmdesignedtoautomatethesegmentationoflivemusic
| indexesfromMJFdataaremusic-to-musictransitions. |     |     |     |     | To  |     |     |     |     |     |     |
| ----------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
cope with that, XTRACK sometimes adds a stop index recordings. Byleveragingthesoundclassificationcapabil-
betweentwoconsecutivemusicindexesoftheMJFdata. itiesof YAMNET, ourapproachhassignificantlystream-
Indeed, 20% of the predicted stop could not be aligned lined the process of isolating musical segments from live
withtheMJFdataandarethereforesupplementaryindexes concert recordings, addressing a critical need within the
MontreuxJazzFestivalarchivesandpotentiallyothermu-
| where XTRACK            | predicted | an                        | end of | a music | track before |                 |     |     |     |     |     |
| ----------------------- | --------- | ------------------------- | ------ | ------- | ------------ | --------------- | --- | --- | --- | --- | --- |
| thestartofthenexttrack. |           | TheMJFannotatorssometimes |        |         |              | siccollections. |     |     |     |     |     |
decidedtoaddanewstartindexwithoutastopbefore. For automated indexation of digital music (e.g. on
start[i] at 10:00 in Figure 1 and rows 2+6 of Table 2 YouTube)orasatooltoindexmusicsinlargecollections,
illustrate a continuous music-to-music transitions that is XTRACK can suggest a first segmentation. This proposi-
not detected. As XTRACK makes its boundary decisions tioncanbefine-tunedbyahumancheckerorusedasitis.
598

| MJF |     | XTRACK |     | Description |     |     | Comment |     |     |     |     |     |     |
| --- | --- | ------ | --- | ----------- | --- | --- | ------- | --- | --- | --- | --- | --- | --- |
08:12 08:17 music> Ononeside,theMJFindexstartsattheverybeginningof
applause speech 08:12applause the 08:12 applause. On the other side, XTRACK adds 5
09:04 09:03 08:30speech seconds of applause after the end of the music. There is
music music 09:04music a difference in the labeling as well: XTRACK predicts a
|     |     |     |     |     |     |     | speechsegment. |     | TheMJFlabelisapplause. |     |     | Thereis |     |
| --- | --- | --- | --- | --- | --- | --- | -------------- | --- | ---------------------- | --- | --- | ------- | --- |
indeeda34s-longspeechvalidatingthisXTRACKlabeling
decision.
24:39 None music> Asinglehighguitarnoteisheldfrom24:30to24:55. The
music
|     |     |     |     | 24:30cheering |     |     | musicdidnotstopbutthereisatransitiontoanewtrack. |     |     |     |     |     |     |
| --- | --- | --- | --- | ------------- | --- | --- | ------------------------------------------------ | --- | --- | --- | --- | --- | --- |
|     |     |     |     | 24:40singing  |     |     | Notstoppingheredonotdisturbapleasantplaybackbuta |     |     |     |     |     |     |
newtrackbegins.
01:05:30 01:05:41 silence> Thesilencebetweenthesmallintroductionandtherestof
music music 01:05:30music thetrackistoolongfor XTRACK toincludeitinthemu-
|     |     |     |     | 01:05:36silence |     |     | sicsegment.                    | Aplaybackstartingasindexedby |     |     |     | XTRACK |     |
| --- | --- | --- | --- | --------------- | --- | --- | ------------------------------ | ---------------------------- | --- | --- | --- | ------ | --- |
|     |     |     |     | 01:05:41music   |     |     | (01:05:41)isstillverypleasant. |                              |     |     |     |        |     |
None 01:27:28 cheering >01:27:28 The music starting at 01:27:28 is a background music
|     |     | music |     | music |     |     | playedfromtheconcerthallloudspeakersontopofsome |          |     |               |                |        |     |
| --- | --- | ----- | --- | ----- | --- | --- | ----------------------------------------------- | -------- | --- | ------------- | -------------- | ------ | --- |
|     |     |       |     |       |     |     | crowd noises.                                   | Whereas, |     | this is not a | concert        | track, | our |
|     |     |       |     |       |     |     | algorithmpredictedamusicstartindex.             |          |     |               | However,thatis |        |     |
becauseYAMNETdetectedthebackgroundmusic.Adapt-
|     |     |     |     |     |     |     | ingtheΘ | canbemadetobemorestrictandmightbe |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------- | --------------------------------- | --- | --- | --- | --- | --- |
music
|     |     |     |     |     |     |     | a way to | prevent | such mistakes. | However, | listening |     | to a |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------- | -------------- | -------- | --------- | --- | ---- |
fewsecondsofthissegmentissufficienttothrowitaway.
40:10 39:56 music> Thisisapre-recordedelectronicmusicconcert.Themusic
applause speech 40:00cheering isdisplayedthroughloudspeakersinthehall.At39:50,the
43:10 43:10 40:45quiet electronic music outputs recorded applause that confuses
music music 42:30speech our algorithm, which cut earlier than the MJF data. This
|     |     |     |     | 43:10music |     |     | cutisvalidforapleasantplaybackwithasmoothfade-out. |     |     |     |     |     |     |
| --- | --- | --- | --- | ---------- | --- | --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- |
Moreover,thespeechpredictionfitstheaudiocontext.
06:14 None music> Transitiontoanewtrackwithoutinterruptionnotfoundby
| music |     |     |     | 06:14music |     |     | XTRACK. |     |     |     |     |     |     |
| ----- | --- | --- | --- | ---------- | --- | --- | ------- | --- | --- | --- | --- | --- | --- |
Table2. QualitativedescriptionofsixrandomlychosendiscrepanciesbetweenXTRACKdecisionsandthehuman-labeled
MJF archives. The Description column illustrates the analysis of a musician listening to the original audio files. In the
Commentcolumn,weexplaininwordsthecontext.
ItscodeisavailableonGitHub[5]. The XTRACK segmentation algorithm can be used for
|               |     |           |              |     |     |              | other | interesting | audio | segmentation | tasks. | For | example, |
| ------------- | --- | --------- | ------------ | --- | --- | ------------ | ----- | ----------- | ----- | ------------ | ------ | --- | -------- |
| Specifically, | the | algorithm | demonstrated |     | a   | high success |       |             |       |              |        |     |          |
rateinaccuratelyidentifyingandsegmentingmusictracks, we can detect in- and out-of-tune segments by analyzing
themagnitudeofhigh-frequenciesofthespectrogram(fast
| thereby facilitating |     | a more | efficient | archival |     | process. | The |     |     |     |     |     |     |
| -------------------- | --- | ------ | --------- | -------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- |
Fouriertransformfftoftheaudiofiles).
| outstandingperformanceof |     |     | XTRACK |     | inmusicsegmenta- |     |     |     |     |     |     | Byimposinga |     |
| ------------------------ | --- | --- | ------ | --- | ---------------- | --- | --- | --- | --- | --- | --- | ----------- | --- |
tion has inspired us to explore additional applications of thresholdontheamplitudeofahigh-frequencyrange, we
|     |     |     |     |     |     |     | can | find the | longest | segment of | in- or | out-of-tune | music. |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ------- | ---------- | ------ | ----------- | ------ |
thistechnology.
Given the rich emotional labels attached to YAMNET Used as a pedagogical tool, XTRACK segmentation algo-
rithmispromising.
dataset,weproposeextendingtheuseofXTRACKbeyond
| traditionalmusicsegmentation. |     |        |           | Byintegratingtheseemo- |     |          |      |     |     |     |     |     |     |
| ----------------------------- | --- | ------ | --------- | ---------------------- | --- | -------- | ---- | --- | --- | --- | --- | --- | --- |
| tional labels,                | we  | aim to | construct | segments               |     | that not | only |     |     |     |     |     |     |
Acknowledgments
| identify different |     | musical | pieces | but also | classify | the | un- |     |     |     |     |     |     |
| ------------------ | --- | ------- | ------ | -------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
derlying emotions conveyed in each segment. This de- We thank the Cultural Heritage and Innovation Cen-
velopment opens up new avenues for emotional analysis ter (CHC) of École Polytechnique Fédérale de Lausanne
within music, allowing for a deeper understanding of the (EPFL) and the Information and Language Section (SLI)
impact of live music on audiences. In fact, this approach oftheLausanneuniversity(UNIL)forhostingthisproject.
promisestoenhancetheuserexperiencebyprovidingmore ThisprojectwaspossiblethankstotheBNFnationalqual-
nuancedandemotionallyresonantmusiclisteningexperi- ificationprogramofBernuniversity(UNIBE).Finally,we
ences. Moreover, it can serve as a valuable tool for mu- are grateful for the recording work of the Montreux Jazz
sicologists,psychologists,andotherresearchersinterested Festival, for its preservation by the Claude Nobs Founda-
intheinterplaybetweenmusicandemotions. tion,andtoallthemusicianswhocontributedtothisamaz-
599

ingconcertcollection.
6. REFERENCES
[1] M. Plakal and D. Ellis, “Yamnet,” https:
//github.com/tensorflow/models/blob/master/research/
audioset/yamnet,2020.
[2] J. F. Gemmeke, D. P. Ellis, D. Freedman, A. Jansen,
W. Lawrence, R. C. Moore, M. Plakal, and M. Ritter,
“Audioset:Anontologyandhuman-labeleddatasetfor
audio events,” in 2017 IEEE international conference
onacoustics, speechandsignalprocessing(ICASSP).
IEEE,2017,pp.776–780.
[3] A. G. Howard, M. Zhu, B. Chen, D. Kalenichenko,
W. Wang, T. Weyand, M. Andreetto, and H. Adam,
“Mobilenets: Efficient convolutional neural net-
works for mobile vision applications,” arXiv preprint
arXiv:1704.04861,2017.
[4] D. El Badawy, P. Marmaroli, and H. Lissek, “Au-
dionovelty-basedsegmentationofmusicconcerts,”in
Acoustics2013,2013.
[5] Florian Colombo, “Xtrack,” https://github.com/
FlorianColombo/xtrack,2024.
600
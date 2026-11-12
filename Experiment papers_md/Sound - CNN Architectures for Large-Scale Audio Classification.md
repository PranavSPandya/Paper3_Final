CNNARCHITECTURESFORLARGE-SCALEAUDIOCLASSIFICATION
ShawnHershey,SourishChaudhuri,DanielP.W.Ellis,JortF.Gemmeke,ArenJansen,R.ChanningMoore,
ManojPlakal,DevinPlatt,RifA.Saurous,BryanSeybold,MalcolmSlaney,RonJ.Weiss,KevinWilson
Google,Inc.,NewYork,NY,andMountainView,CA,USA
shershey@google.com
|     |     | ABSTRACT |     |     |     | Eghbal-Zadehetal.[19]recentlywontheDCASE2016Acous- |     |     |     |     |     |     |     |
| --- | --- | -------- | --- | --- | --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
7102 naJ 01  ]DS.sc[  2v03490.9061:viXra tic Scene Classification (ASC) task, which, like soundtrack classi-
ConvolutionalNeuralNetworks(CNNs)haveprovenveryeffective fication, involvesassigningasinglelabeltoanaudioclipcontain-
in image classification and show promise for audio. We use var- ingmanyevents. Theirsystemusedspectrogramfeaturesfeedinga
| ious CNN | architectures | to classify | the | soundtracks | of a dataset of |                 |         |     |           |                 |     |           |      |
| -------- | ------------- | ----------- | --- | ----------- | --------------- | --------------- | ------- | --- | --------- | --------------- | --- | --------- | ---- |
|          |               |             |     |             |                 | VGG classifier, | similar |     | to one of | the classifiers | in  | our work. | This |
70Mtrainingvideos(5.24millionhours)with30,871video-levella-
|     |     |     |     |     |     | paper, however, |     | compares | the performance |     | of several | different | ar- |
| --- | --- | --- | --- | --- | --- | --------------- | --- | -------- | --------------- | --- | ---------- | --------- | --- |
bels. WeexaminefullyconnectedDeepNeuralNetworks(DNNs),
|     |     |     |     |     |     | chitectures. | Toourknowledge,wearethefirsttopublishresultsof |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ------------ | ---------------------------------------------- | --- | --- | --- | --- | --- | --- |
AlexNet[1],VGG[2],Inception[3],andResNet[4].Weinvestigate
InceptionandResNetnetworksappliedtoaudio.
varyingthesizeofbothtrainingsetandlabelvocabulary,findingthat
|     |     |     |     |     |     | We aggregate |     | local | classifications | to  | whole-soundtrack |     | deci- |
| --- | --- | --- | --- | --- | --- | ------------ | --- | ----- | --------------- | --- | ---------------- | --- | ----- |
analogsoftheCNNsusedinimageclassificationdowellonourau-
|     |     |     |     |     |     | sions by | imitating | the | visual-based | video | classification |     | of Ng et |
| --- | --- | --- | --- | --- | --- | -------- | --------- | --- | ------------ | ----- | -------------- | --- | -------- |
dioclassificationtask,andlargertrainingandlabelsetshelpuptoa
al.[20]. Afterinvestigatingseveralmorecomplexmodelsforcom-
point. Amodelusingembeddingsfromtheseclassifiersdoesmuch
|     |     |     |     |     |     | bining information |     | across | time, | they found | simple | averaging | of  |
| --- | --- | --- | --- | --- | --- | ------------------ | --- | ------ | ----- | ---------- | ------ | --------- | --- |
betterthanrawfeaturesontheAudioSet[5]AcousticEventDetec-
|     |     |     |     |     |     | single-frame | CNN | classification |     | outputs | performed | nearly | as well. |
| --- | --- | --- | --- | --- | --- | ------------ | --- | -------------- | --- | ------- | --------- | ------ | -------- |
tion(AED)classificationtask. By analogy, we apply a classifier to a series of non-overlapping
segments,thenaverageallthesetsofclassifieroutputs.
| IndexTerms— |     | AcousticEventDetection,AcousticSceneClas- |     |     |     |     |     |     |     |     |     |     |     |
| ----------- | --- | ----------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
sification,ConvolutionalNeuralNetworks,DeepNeuralNetworks, Kumaretal.[21]considerAEDinadatasetwithvideo-levella-
VideoClassification belsasaMultipleInstanceLearning(MIL)problem,butremarkthat
|     |     |     |     |     |     | scalingsuchapproachesremainsanopenproblem. |     |     |     |     |     | Bycontrast,we |     |
| --- | --- | --- | --- | --- | --- | ------------------------------------------ | --- | --- | --- | --- | --- | ------------- | --- |
areinvestigatingthelimitsoftrainingwithweaklabelsforverylarge
|     |     | 1. INTRODUCTION |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
datasets.Whilemanyoftheindividualsegmentswillbeuninforma-
tiveaboutthelabelsinheritedfromtheparentvideo,wehopethat,
Imageclassificationperformancehasimprovedgreatlywiththead-
|               |          |      |             |           |               | givenenoughtraining,thenetcanlearntospotusefulcues. |     |     |     |     |     |     | Weare |
| ------------- | -------- | ---- | ----------- | --------- | ------------- | --------------------------------------------------- | --- | --- | --- | --- | --- | --- | ----- |
| vent of large | datasets | such | as ImageNet | [6] using | Convolutional |                                                     |     |     |     |     |     |     |       |
notabletoquantifyhow“weak”thelabelsare(i.e.,whatproportion
NeuralNetwork(CNN)architecturessuchasAlexNet[1],VGG[2],
ofthesegmentsareuninformative),andforthemajorityofclasses
Inception[3],andResNet[4].Wearecurioustoseeifsimilarlylarge (e.g., “ComputerHardware”, “Boeing757”, “Ollie”), it’snotclear
datasetsandCNNscanyieldgoodperformanceonaudioclassifica- howtodeciderelevance. Notethatforsomeclasses(e.g. “Beach”),
| tionproblems. | Ourdatasetconsistsof70million(henceforth70M) |     |     |     |     |     |     |     |     |     |     |     |     |
| ------------- | -------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
backgroundambianceisitselfinformative.
trainingvideostotalling5.24millionhours,eachtaggedfromasetof
Ourdatasetsizeallowsustoexaminenetworkswithlargemodel
30,871(henceforth30K)labels.WecallthisdatasetYouTube-100M.
|     |     |     |     |     |     | capacity, | fully exploiting |     | ideas | from the | image classification |     | liter- |
| --- | --- | --- | --- | --- | --- | --------- | ---------------- | --- | ----- | -------- | -------------------- | --- | ------ |
Ourprimarytaskistopredictthevideo-levellabelsusingaudioin-
ature. Bycomputinglog-melspectrogramsofmultipleframes,we
| formation | (i.e., soundtrack | classification). |       | Per Lyon    | [7], teaching  |                                                     |          |     |          |           |      |       |           |
| --------- | ----------------- | ---------------- | ----- | ----------- | -------------- | --------------------------------------------------- | -------- | --- | -------- | --------- | ---- | ----- | --------- |
|           |                   |                  |       |             |                | create2Dimage-likepatchestopresenttotheclassifiers. |          |     |          |           |      |       | Although  |
| machines  | to hear and       | understand       | video | can improve | our ability to |                                                     |          |     |          |           |      |       |           |
|           |                   |                  |       |             |                | the distinct                                        | meanings | of  | time and | frequency | axes | might | argue for |
“categorize,organize,andindexthem”.
|     |     |     |     |     |     | audio-specific | architectures, |     | this | work employs |     | minimally-altered |     |
| --- | --- | --- | --- | --- | --- | -------------- | -------------- | --- | ---- | ------------ | --- | ----------------- | --- |
Inthispaper,weusetheYouTube-100Mdatasettoinvestigate:
imageclassificationnetworkssuchasInception-V3andResNet-50.
howpopularDeepNeuralNetwork(DNN)architecturescompareon
|     |     |     |     |     |     | We train | with subsets |     | of YouTube-100M |     | spanning | 23K | to 70M |
| --- | --- | --- | --- | --- | --- | -------- | ------------ | --- | --------------- | --- | -------- | --- | ------ |
videosoundtrackclassification;howperformancevarieswithdiffer- videos to evaluate the impact of training set size on performance,
enttrainingsetandlabelvocabularysizes;andwhetherourtrained
|     |     |     |     |     |     | and we investigate |     | the | effects | of label | set size | on generalization |     |
| --- | --- | --- | --- | --- | --- | ------------------ | --- | --- | ------- | -------- | -------- | ----------------- | --- |
modelscanalsobeusefulforAED.
|                               |             |          |            |                          |                  | by training                                         | models          | with | subsets    | of labels, | spanning | 400             | to 30K, |
| ----------------------------- | ----------- | -------- | ---------- | ------------------------ | ---------------- | --------------------------------------------------- | --------------- | ---- | ---------- | ---------- | -------- | --------------- | ------- |
| Historically,                 | AED         | has been | addressed  | with                     | features such as |                                                     |                 |      |            |            |          |                 |         |
|                               |             |          |            |                          |                  | whicharethenevaluatedonasinglecommonsubsetoflabels. |                 |      |            |            |          |                 | We      |
| MFCCs and                     | classifiers | based    | on GMMs,   | HMMs,                    | NMF, or SVMs     |                                                     |                 |      |            |            |          |                 |         |
|                               |             |          |            |                          |                  | additionally                                        | examine         | the  | usefulness | of our     | networks | for             | AED by  |
| [8, 9, 10,                    | 11]. More   | recent   | approaches | use some                 | form of DNN,     |                                                     |                 |      |            |            |          |                 |         |
|                               |             |          |            |                          |                  | examining                                           | the performance |      | of         | a model    | trained  | with embeddings |         |
| includingCNNs[12]andRNNs[13]. |             |          |            | Priorworkhasbeenreported |                  |                                                     |                 |      |            |            |          |                 |         |
fromoneofournetworksontheAudioSet[5]dataset.
ondatasetssuchasTRECVid[14],ActivityNet[15],Sports1M[16],
| and TUT/DCASE |     | Acoustic | scenes | 2016 [17] | which are much |     |     |     |     |     |     |     |     |
| ------------- | --- | -------- | ------ | --------- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
smaller than YouTube-100M. Our large dataset puts us in a good 2. DATASET
positiontoevaluatemodelswithlargemodelcapacity.
RNNsandCNNshavebeenusedinLargeVocabularyContinu- The YouTube-100M data set consists of 100 million YouTube
ousSpeechRecognition(LVCSR)[18]. Unlikethattask,ourlabels videos: 70M training videos, 10M evaluation videos, and a pool
applytoentirevideoswithoutanychangesintime,sowehaveyet of20Mvideosthatweuseforvalidation. Videosaverage4.6min-
totrysuchrecurrentmodels. utes each for a total of 5.4M training hours. Each of these videos

Table1:Examplelabelsfromthe30Kset.
|     |     |     |     |     |     |     |     | probability | of correctly | classifying |     | a positive | example | (correct | ac- |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ------------ | ----------- | --- | ---------- | ------- | -------- | --- |
ceptrate)asafunctionoftheprobabilityofincorrectlyclassifying
| Labelprior |     | ExampleLabels |     |     |     |     |     |     |     |     |     |     |     |     |     |
| ---------- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
anegativeexampleaspositive(falseacceptrate);perfectclassifica-
| 0.1...0.2 |     | Song,Music,Game,Sports,Performance |     |     |     |     |     |     |     |     |     |     |     |     |     |
| --------- | --- | ---------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
tionachievesAUCof1.0(correspondingtoaninfinited-prime),and
| 0.01...0.1 |     | Singing,Car,Chordophone,Speech |     |     |     |     |     |                                                |     |     |     |     |     |     |       |
| ---------- | --- | ------------------------------ | --- | --- | --- | --- | --- | ---------------------------------------------- | --- | --- | --- | --- | --- | --- | ----- |
|            |     |                                |     |     |     |     |     | randomguessinggivesanAUCof0.5(d-primeofzero).1 |     |     |     |     |     |     | mAPis |
| ∼10−5      |     | CustomMotorcycle,RetainingWall |     |     |     |     |     |                                                |     |     |     |     |     |     |       |
themeanacrossclassesoftheAveragePrecision(AP),whichisthe
| ∼10−6 |     | Cormorant,Lecturer |     |     |     |     |     |     |     |     |     |     |     |     |     |
| ----- | --- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
proportionofpositiveitemsinarankedlistoftrials(i.e.,Precision)
averagedacrosslistsjustlongenoughtoincludeeachindividualpos-
|     |     |     |     |     |     |     |     | itivetrial[28]. | APiswidelyusedasanindicatorofprecisionthat |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | ------------------------------------------ | --- | --- | --- | --- | --- | --- |
islabeledwith1ormoretopicidentifiers(fromKnowledgeGraph
|                  |       |                                          |         |       |        |         |           | does not                                                 | require a | particular | retrieval | list | length, | but, unlike | AUC, |
| ---------------- | ----- | ---------------------------------------- | ------- | ----- | ------ | ------- | --------- | -------------------------------------------------------- | --------- | ---------- | --------- | ---- | ------- | ----------- | ---- |
| [22]) from       | a set | of 30,871                                | labels. | There | are an | average | of around |                                                          |           |            |           |      |         |             |      |
|                  |       |                                          |         |       |        |         |           | itisdirectlycorrelatedwiththepriorprobabilityoftheclass. |           |            |           |      |         |             | Be-  |
| 5labelspervideo. |       | Thelabelsareassignedautomaticallybasedon |         |       |        |         |           |                                                          |           |            |           |      |         |             |      |
causemostofourclasseshaveverylowpriors(<10−4),themAPs
acombinationofmetadata(title,description,comments,etc.),con-
wereportaretypicallysmall,eventhoughthefalsealarmratesare
text,andimagecontentforeachvideo.Thelabelsapplytotheentire
good.
| video and                                            | range | from | very generic        | (e.g. | “Song”) | to very | specific |                    |     |     |     |     |     |     |     |
| ---------------------------------------------------- | ----- | ---- | ------------------- | ----- | ------- | ------- | -------- | ------------------ | --- | --- | --- | --- | --- | --- | --- |
| (e.g.“Cormorant”).Table                              |       |      | 1showsafewexamples. |       |         |         |          |                    |     |     |     |     |     |     |     |
| Beingmachinegenerated,thelabelsarenot100%accurateand |       |      |                     |       |         |         |          | 3.3. Architectures |     |     |     |     |     |     |     |
ofthe30Klabels,someareclearlyacousticallyrelevant(“Trumpet”) OurbaselineisafullyconnectedDNN,whichwecomparedtosev-
andothersarelessso(“WebPage”). Videosoftenbearannotations eralnetworkscloselymodeledonsuccessfulimageclassifiers. For
with multiple degrees of specificity. For example, videos labeled our baseline experiments, we trained and evaluated using only the
with“Trumpet”areoftenlabeled“Entertainment”aswell,although 10%mostfrequentlabelsoftheoriginal30K(i.e, 3Klabels). For
nohierarchyisenforced.
eachexperiment,wecoarselyoptimizednumberofGPUsandlearn-
ingratefortheframelevelclassificationaccuracy.Theoptimalnum-
3. EXPERIMENTALFRAMEWORK ber of GPUs represents a compromise between overall computing
powerandcommunicationoverhead,andvariesbyarchitecture.
3.1. Training
The audio is divided into non-overlapping 960 ms frames. This 3.3.1. FullyConnected
gaveapproximately20billionexamplesfromthe70Mvideos.Each
|                                            |     |     |     |     |                |     |     | Our baseline | network | is      | a fully | connected | model  | with RELU | ac-  |
| ------------------------------------------ | --- | --- | --- | --- | -------------- | --- | --- | ------------ | ------- | ------- | ------- | --------- | ------ | --------- | ---- |
| frameinheritsallthelabelsofitsparentvideo. |     |     |     |     | The960msframes |     |     |              |         |         |         |           |        |           |      |
|                                            |     |     |     |     |                |     |     | tivations    | [29], N | layers, | and M   | units per | layer. | We swept  | over |
aredecomposedwithashort-timeFouriertransformapplying25ms
|                   |     |     |                                         |     |     |     |     | N = [2,3,4,5,6]         |     | and M | = [500,1000,2000,3000,4000]. |           |     |                  | Our |
| ----------------- | --- | --- | --------------------------------------- | --- | --- | --- | --- | ----------------------- | --- | ----- | ---------------------------- | --------- | --- | ---------------- | --- |
| windowsevery10ms. |     |     | Theresultingspectrogramisintegratedinto |     |     |     |     |                         |     |       |                              |           |     |                  |     |
|                   |     |     |                                         |     |     |     |     | bestperformingmodelhadN |     |       | =                            | 3layers,M | =   | 1000units,learn- |     |
64mel-spacedfrequencybins,andthemagnitudeofeachbinislog- ingrateof3×10−5,10GPUsand5parameterservers.Thisnetwork
transformed after adding a small offset to avoid numerical issues. hasapproximately11.2Mweightsand11.2Mmultiplies.
Thisgiveslog-melspectrogrampatchesof96×64binsthatform
| theinputtoallclassifiers. |     |     | Duringtrainingwefetchmini-batchesof |     |     |     |     |                |     |     |     |     |     |     |     |
| ------------------------- | --- | --- | ----------------------------------- | --- | --- | --- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- |
|                           |     |     |                                     |     |     |     |     | 3.3.2. AlexNet |     |     |     |     |     |     |     |
128inputexamplesbyrandomlysamplingfromallpatches.
| All experiments                                    |     | used | TensorFlow | [23] | and were | trained | asyn- |              |            |            |               |               |          |       |        |
| -------------------------------------------------- | --- | ---- | ---------- | ---- | -------- | ------- | ----- | ------------ | ---------- | ---------- | ------------- | ------------- | -------- | ----- | ------ |
|                                                    |     |      |            |      |          |         |       | The original | AlexNet    | [1]        | architectures | was           | designed | for   | a 224× |
| chronouslyonmultipleGPUsusingtheAdam[24]optimizer. |     |      |            |      |          |         | We    |              |            |            |               |               |          |       |        |
|                                                    |     |      |            |      |          |         |       | 224×3        | input with | an initial | 11×11         | convolutional |          | layer | with a |
performedgridsearchesoverlearningrates,batchsizes,numberof
strideof4.Becauseourinputsare96×64,weuseastrideof2×1
GPUs,andparameterservers.Batchnormalization[25]wasapplied
sothatthenumberofactivationsaresimilaraftertheinitiallayer.We
| afterallconvolutionallayers. |     |     | Allmodelsusedafinalsigmoidlayer |     |     |     |     |     |     |     |     |     |     |     |     |
| ---------------------------- | --- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
alsousebatchnormalizationaftereachconvolutionallayerinstead
| rather than           | a softmax | layer | since | each example   |     | can have | multiple  |            |          |               |        |           |              |           |      |
| --------------------- | --------- | ----- | ----- | -------------- | --- | -------- | --------- | ---------- | -------- | ------------- | ------ | --------- | ------------ | --------- | ---- |
|                       |           |       |       |                |     |          |           | of local   | response | normalization |        | (LRN) and | replace      | the final | 1000 |
| labels. Cross-entropy |           | was   | the   | loss function. | In  | view of  | the large |            |          |               |        |           |              |           |      |
|                       |           |       |       |                |     |          |           | unit layer | with a   | 3087 unit     | layer. | While     | the original | AlexNet   | has  |
trainingsetsize,wedidnotusedropout[26],weightdecay,orother approximately62.4Mweightsand1.1Gmultiplies,ourversionhas
common regularization techniques. For the models trained on 7M 37.3Mweightsand767Mmultiplies.Also,forsimplicity,unlikethe
ormoreexamples,wesawnoevidenceofoverfitting. Duringtrain- originalAlexNet,wedonotsplitfiltersacrossmultipledevices.We
ing, wemonitoredprogressvia1-bestaccuracyandmeanAverage trainedwith20GPUsand10parameterservers.
Precision(mAP)overavalidationsubset.
|     |     |     |     |     |     |     |     | 3.3.3. VGG |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
3.2. Evaluation
|     |     |     |     |     |     |     |     | The only | changes | we made | to VGG | (configuration |     | E) [2] | were to |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ------- | ------- | ------ | -------------- | --- | ------ | ------- |
Fromthepoolof10Mevaluationvideoswecreatedthreebalanced
thefinallayer(3087unitswithasigmoid)aswellastheuseofbatch
evaluationsets,eachwithroughly33examplesperclass:1Mvideos
normalizationinsteadofLRN.Whiletheoriginalnetworkhad144M
forthe30Klabels,100Kvideosforthe3087(henceforth3K)most
weightsand20Bmultiplies,theaudiovariantuses62Mweightsand
frequentlabels,and12Kvideosforthe400mostfrequentlabels.We
|     |     |     |     |     |     |     |     | 2.4B multiplies. |     | We tried | another | variant | that reduced | the | initial |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | -------- | ------- | ------- | ------------ | --- | ------- |
passedeach960msframefromeachevaluationvideothroughthe
strides(aswedidwithAlexNet),butfoundthatnotmodifyingthe
| classifier. | We then | averaged | the | classifier | output | scores | across all |                                                      |     |     |     |     |     |     |         |
| ----------- | ------- | -------- | --- | ---------- | ------ | ------ | ---------- | ---------------------------------------------------- | --- | --- | --- | --- | --- | --- | ------- |
|             |         |          |     |            |        |        |            | stridesresultedinfastertrainingandbetterperformance. |     |     |     |     |     |     | Withour |
segmentsinavideo.
|     |     |     |     |     |     |     |     | setup, parallelizing |     | beyond | 10 GPUs | did | not help | significantly, | so  |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------------- | --- | ------ | ------- | --- | -------- | -------------- | --- |
For our metrics, we calculated the balanced average across all wetrainedwith10GPUsand5parameterservers.
classesofAUC(alsoreportedastheequivalentd-primeclasssepa-
√
ration),andmeanAveragePrecision(mAP).AUCistheareaunder 1d(cid:48) = 2F−1(AUC)whereF−1istheinversecumulativedistribution
theReceiverOperatingCharacteristic(ROC)curve[27],thatis,the functionforaunitGaussian.

Table2: ComparisonofperformanceofseveralDNNarchitectures
trainedon70Mvideos,eachtaggedwithlabelsfromasetof3K.The
lastrowcontainsresultsforamodelthatwastrainedmuchlonger
| than the others, | with a reduction | in learning | rate after 13 million |     |     |     |     |
| ---------------- | ---------------- | ----------- | --------------------- | --- | --- | --- | --- |
steps.
| Architectures  | Steps | Time AUC   | d-prime mAP |     |     |     |     |
| -------------- | ----- | ---------- | ----------- | --- | --- | --- | --- |
| FullyConnected | 5M    | 35h 0.851  | 1.471 0.058 |     |     |     |     |
| AlexNet        | 5M    | 82h 0.894  | 1.764 0.115 |     |     |     |     |
| VGG            | 5M    | 184h 0.911 | 1.909 0.161 |     |     |     |     |
| InceptionV3    | 5M    | 137h 0.918 | 1.969 0.181 |     |     |     |     |
| ResNet-50      | 5M    | 119h 0.916 | 1.952 0.182 |     |     |     |     |
| ResNet-50      | 17M   | 356h 0.926 | 2.041 0.212 |     |     |     |     |
3.3.4. InceptionV3
WemodifiedtheinceptionV3[3]networkbyremovingthefirstfour
layersofthestem,uptoandincludingtheMaxPool,aswellasre-
movingtheauxiliarynetwork.WechangedtheAveragePoolsizeto
| 10×6toreflectthechangeinactivations. |     | Wetriedincludingthe |     |     |     |     |     |
| ------------------------------------ | --- | ------------------- | --- | --- | --- | --- | --- |
stemandremovingthefirststrideof2andMaxPoolbutfoundthatit
performedworsethanthevariantwiththetruncatedstem.Theorig- Fig.1:ScatterplotofResNet-50’sper-classd-primeversuslogprior
inalnetworkhas27Mweightswith5.6Bmultiplies, andtheaudio probability.Eachpointisaseparateclassfromarandom20%subset
variant has 28M weights and 4.7B multiplies. We trained with 40 ofthe30Kset.ColorreflectstheclassAP.
GPUsand20parameterservers.
| 3.3.5. ResNet-50 |     |     |     | 4.2. LabelSetSize |                 |                 |                     |
| ---------------- | --- | --- | --- | ----------------- | --------------- | --------------- | ------------------- |
|                  |     |     |     | Using a 400       | label subset of | the 30K labels, | we investigated how |
WemodifiedResNet-50[4]byremovingthestrideof2fromthefirst
trainingwithdifferentsubsetsofclassescanaffectperformance,per-
7×7convolutionsothatthenumberofactivationswasnottoodiffer-
hapsbyencouragingintermediaterepresentationsthatbettergener-
entintheaudioversion.WechangedtheAveragePoolsizeto6×4
toreflectthechangeinactivations. Theoriginalnetworkhas26M alizetounseenexamplesevenfortheevaluationclasses.Inaddition
weightsand3.8Bmultiplies.Theaudiovarianthas30Mweightsand toexaminingthreelabelsetsizes(30K,3K,and400),wecompared
1.9Bmultiplies.Wetrainedwith20GPUsand10parameterservers. modelswithandwithoutabottlenecklayerof128unitsplacedright
|     |     |     |     | beforethefinaloutputlayer.                        |     | Weintroducedthebottlenecklayerto |         |
| --- | --- | --- | --- | ------------------------------------------------- | --- | -------------------------------- | ------- |
|     |     |     |     | speedupthetrainingofthemodeltrainedwith30Klabels. |     |                                  | Without |
4. EXPERIMENTS
abottleneck,thelargeroutputlayerincreasedthenumberofweights
|     |     |     |     | from30Mto80Mandsignificantlyreducedtrainingspeed. |     |     | Wedo |
| --- | --- | --- | --- | ------------------------------------------------- | --- | --- | ---- |
4.1. ArchitectureComparison
|                 |               |                 |                   | not report | metrics on the 30K | label model without | the bottleneck          |
| --------------- | ------------- | --------------- | ----------------- | ---------- | ------------------ | ------------------- | ----------------------- |
|                 |               |                 |                   | because it | would have taken   | several months      | to train. For all label |
| For all network | architectures | we trained with | 3K labels and 70M |            |                    |                     |                         |
setsizeexperiments,weusedtheResNet-50modelandtrainedfor5
videosandcomparedafter5millionmini-batchesof128inputs.Be-
millionmini-batchesof128inputs(about120hours)on70Mvideos.
| cause some | networks trained | faster than others, | comparing after a |     |     |     |     |
| ---------- | ---------------- | ------------------- | ----------------- | --- | --- | --- | --- |
fixedwall-clocktimewouldgiveslightlydifferentresultsbutwould Tables 3showstheresults. Whencomparingmodelswiththe
not change the relative ordering of the architectures’ performance. bottleneck, we see that performance does indeed improve slightly
WeincludenumbersforResNetaftertrainingfor17millionmini- as we increase the number of labels we trained on, although net-
batches(405hours)toshowthatperformancecontinuestoimprove. workswithoutthebottleneckhavehigherperformanceoverall. The
Wereducedthelearningratebyafactorof10after13millionmini- bottlenecklayerisrelativelysmallcomparedtothe2048activations
comingoutofResNet-50’sAveragePoollayerandsoitiseffecting
batches.
|                                                       |          |                          |               | asubstantialreductionininformation. |                          | Theseresultsprovideweak |                   |
| ----------------------------------------------------- | -------- | ------------------------ | ------------- | ----------------------------------- | ------------------------ | ----------------------- | ----------------- |
| Table 2showstheevaluationresultscalculatedoverthe100K |          |                          |               |                                     |                          |                         |                   |
|                                                       |          |                          |               | support to                          | the notion that training | with a broader          | set of categories |
| balanced videos.                                      | All CNNs | beat the fully-connected | baseline. In- |                                     |                          |                         |                   |
canhelptoregularizeeventhe400classsubset.
ceptionandResNetachievethebestperformance;theyprovidehigh
modelcapacityandtheirconvolutionalunitscanefficientlycapture
commonstructuresthatmayoccurindifferentareasoftheinputar-
4.3. TrainingSetSize
rayforbothimages,and,weinfer,ouraudiorepresentation.
Toinvestigatehowthepriorlikelihoodofeachlabelaffectsits Having a very large training set available allows us to investigate
performance,Fig.1showsascatterplotofthe30Kclasseswithlabel howtrainingsetsizeaffectsperformance. With70Mvideosandan
frequencyonthexaxisandResNet-50’sd-primeonthey axis. d- averageof4.6minutespervideo,wehavearound20billion960ms
primeseemstostaycenteredaround2.0acrosslabelprior,although training examples. Given ResNet-50’s training speed of 11 mini-
thevarianceofd-primeincreasesforless-commonclasses. Thisis batches per second with 20 GPUs, it would take 23 weeks for the
contrary to the usual result where classifier performance improves networktoseeeachpatternonce(oneepoch).However,ifallvideos
withincreasedtrainingdata,particularlyoverthe5ordersofmagni- wereequallengthandfullyrandomized,weexpecttoseeatleastone
tudeillustratedintheplot. framefromeachvideoinonly14hours. Wehypothesizethat,even

| Table3: | Resultsofvaryinglabelsetsize, |     |     | evaluatedover400 |     |     |     |     |     |     |
| ------- | ----------------------------- | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- |
Table4:Resultsoftrainingwithdifferentamountsofdata.All
| labels. | All | models are | variants of ResNet-50 | trained | on 70M |      |                         |              |         |           |
| ------- | --- | ---------- | --------------------- | ------- | ------ | ---- | ----------------------- | ------------ | ------- | --------- |
|         |     |            |                       |         |        | rows | used the same ResNet-50 | architecture | trained | on videos |
videos.Thebottleneck,ifpresent,is128dimensions.
taggedwithlabelsfromasetof3K.
|     | Bneck | Labels  | AUC d-prime |     | mAP   |       |                |       |         |       |
| --- | ----- | ------- | ----------- | --- | ----- | ----- | -------------- | ----- | ------- | ----- |
|     |       |         |             |     |       |       | TrainingVideos | AUC   | d-prime | mAP   |
|     | no    | 30K     | — —         |     | —     |       |                |       |         |       |
|     |       |         |             |     |       |       | 70M            | 0.923 | 2.019   | 0.206 |
|     | no    | 3K      | 0.930 2.087 |     | 0.381 |       |                |       |         |       |
|     |       |         |             |     |       |       | 7M             | 0.922 | 2.006   | 0.202 |
|     | no    | 400     | 0.928 2.067 |     | 0.376 |       |                |       |         |       |
|     |       |         |             |     |       |       | 700K           | 0.921 | 1.997   | 0.203 |
|     | yes   | 30K     | 0.925 2.035 |     | 0.369 |       |                |       |         |       |
|     |       |         |             |     |       |       | 70K            | 0.909 | 1.883   | 0.162 |
|     | yes   | 3K      | 0.919 1.982 |     | 0.347 |       |                |       |         |       |
|     |       |         |             |     |       |       | 23K            | 0.868 | 1.581   | 0.118 |
|     | yes   | 400     | 0.924 2.026 |     | 0.365 |       |                |       |         |       |
|     |       | Trumpet |             |     |       | Piano |                |       | Guitar  |       |
Fig.2: ThreeexampleexcerptsfromavideoclassifiedbyResNet-50withinstantaneousmodeloutputsoverlaid. The16classifieroutputs
withthegreatestpeakvaluesacrosstheentirevideowerechosenfromthe30Ksetfordisplay.
ifwecannotgetthroughanentireepoch,70Mvideoswillprovide 5. CONCLUSIONS
| an advantage | over | 7M by | virtue of the greater | diversity | of videos |     |     |     |     |     |
| ------------ | ---- | ----- | --------------------- | --------- | --------- | --- | --- | --- | --- | --- |
underlying the limited number of training patterns consumed. We TheresultsinSection 4.1showthatstate-of-the-artimagenetworks
trainedaResNet-50modelfor16millionmini-batchesof128inputs are capable of excellent results on audio classification when com-
(about380hours)onthe3Klabelsetwith70M,7M,700K,70K,and paredtoasimplefullyconnectednetworkorearlierimageclassifica-
23Kvideos. tionarchitectures.InSection 4.2wesawresultsshowingthattrain-
The video level results are shown in Table 4. The 70K and ingonlargerlabelsetvocabulariescanimproveperformance,albeit
23K models show worse performance but the validation plots (not modestly,whenevaluatingonsmallerlabelsets. InSection 4.3we
included)showedthattheylikelysufferedfromoverfitting. Regu- saw that increasing the number of videos up to 7M improves per-
|     |     |     |     |     |     | formanceforthebest-performingResNet-50architecture. |     |     |     | Wenote |
| --- | --- | --- | --- | --- | --- | --------------------------------------------------- | --- | --- | --- | ------ |
larizationtechniques(ordataaugmentation)mighthaveboostedthe
thatregularizationcouldhavereducedthegapbetweenthemodels
| numbers | on these | smaller | training sets. The | 700K, | 7M, and | 70M |     |     |     |     |
| ------- | -------- | ------- | ------------------ | ----- | ------- | --- | --- | --- | --- | --- |
models are mostly very close in performance although the 700K trainedonsmallerdatasetsandthe7Mand70Mdatasets.InSection
modelisslightlyinferior. 4.4weseeasignificantincreaseoverourbaselinewhentraininga
modelforAEDwithResNetembeddingsontheAudioSetdataset.
4.4. AEDwiththeAudioSetDataset Inadditiontothesequantifiedresults,wecansubjectivelyexam-
inetheperformanceofthemodelonsegmentsofvideo.Fig.2shows
Audio Set [5] is a dataset of over 1 million 10 second excerpts la- theresultsofrunningourbestclassifieroveravideoandoverlaying
beled with a vocabulary of acoustic events (whereas not all of the theframe-by-frameresultsofthe16classifieroutputswiththegreat-
YouTube-100M30Klabelspertaintoacousticevents). Thiscomes estpeakvaluesacrosstheentirevideo. Thedifferentsoundsources
to about 3000 hours – still only ≈ 0.05% of YouTube-100M. We presentatdifferentpointsinthevideoareclearlydistinguished.2
traintwofully-connectedmodelstopredictlabelsforAudioSet.The
firstmodeluses64×20log-melpatchesandthesecondusestheout-
6. ACKNOWLEDGEMENTS
putofthepenultimate“embedding”layerofourbestResNetmodel
asinputs. Thelog-melbaselineachievesabalancedmAPof0.137
TheauthorswouldliketothankGeorgeTodericiandMarvinRitter,
| and AUC | of 0.904 | (equivalent | to d-prime | of 1.846). | The model |     |     |     |     |     |
| ------- | -------- | ----------- | ---------- | ---------- | --------- | --- | --- | --- | --- | --- |
bothwithGoogle,fortheirveryvaluablefeedback.
| trained      | on embeddings | achieves                                     | mAP / AUC | / d-prime | of 0.314 | /   |     |     |     |     |
| ------------ | ------------- | -------------------------------------------- | --------- | --------- | -------- | --- | --- | --- | --- | --- |
| 0.959/2.452. |               | Thisjumpinperformancereflectsthebenefitofthe |           |           |          |     |     |     |     |     |
largerYouTube-100MtrainingsetembodiedintheResNetclassifier
outputs. 2Asimilarvideoisavailableonlineathttps://youtu.be/oAAor7ZT8U.

7. REFERENCES [15] B.G.FabianCabaHeilbron,VictorEscorciaandJ.C.Niebles,
|     |     |     |     | “Activitynet: | Alarge-scalevideobenchmarkforhumanactiv- |     |
| --- | --- | --- | --- | ------------- | ---------------------------------------- | --- |
[1] A.Krizhevsky,I.Sutskever,andG.E.Hinton,“Imagenetclas- ityunderstanding,” inProceedingsoftheIEEEConferenceon
sification with deep convolutional neural networks,” in Ad- ComputerVisionandPatternRecognition,2015,pp.961–970.
vances in neural information processing systems, 2012, pp. [16] A.Karpathy,G.Toderici,S.Shetty,T.Leung,R.Sukthankar,
1097–1105.
andL.Fei-Fei,“Large-scalevideoclassificationwithconvolu-
| [2] K. Simonyan | and A. Zisserman, | “Very | deep convolutional |     |     |     |
| --------------- | ----------------- | ----- | ------------------ | --- | --- | --- |
tionalneuralnetworks,” inCVPR,2014.
| networks | for large-scale | image recognition,” | arXiv preprint |                 |                            |                 |
| -------- | --------------- | ------------------- | -------------- | --------------- | -------------------------- | --------------- |
|          |                 |                     |                | [17] A.Mesaros, | T.Heittola, andT.Virtanen, | “TUTdatabasefor |
arXiv:1409.1556,2014. acoustic scene classification and sound event detection,” in
[3] C.Szegedy, V.Vanhoucke, S.Ioffe, J.Shlens, andZ.Wojna, 24thEuropeanSignalProcessingConference2016(EUSIPCO
“Rethinking the inception architecture for computer vision,” 2016), Budapest, Hungary, 2016, http://www.cs.tut.
| arXivpreprintarXiv:1512.00567,2015. |     |     |     | fi/sgn/arg/dcase2016/. |     |     |
| ----------------------------------- | --- | --- | --- | ---------------------- | --- | --- |
[4] K. He, X. Zhang, S. Ren, and J. Sun, “Deep residual learn- [18] T.N.Sainath, O.Vinyals, A.Senior, andH.Sak, “Convolu-
ingforimagerecognition,” arXivpreprintarXiv:1512.03385, tional, long short-term memory, fully connected deep neural
| 2015. |     |     |     | networks,” | in2015IEEEInternationalConferenceonAcous- |     |
| ----- | --- | --- | --- | ---------- | ----------------------------------------- | --- |
tics,SpeechandSignalProcessing(ICASSP).IEEE,2015,pp.
| [5] J. F. Gemmeke, | D. P.        | W. Ellis, D. Freedman, | A. Jansen,          |            |     |     |
| ------------------ | ------------ | ---------------------- | ------------------- | ---------- | --- | --- |
| W. Lawrence,       | R. C. Moore, | M. Plakal,             | and M. Ritter, “Au- | 4580–4584. |     |     |
dio Set: An ontology and human-labeled dartaset for audio [19] H.Eghbal-Zadeh,B.Lehner,M.Dorfer,andG.Widmer, “Cp-
events,” inIEEEICASSP2017,NewOrleans,2017. jkusubmissionsfordcase-2016:Ahybridapproachusingbin-
[6] J. Deng, W. Dong, R. Socher, L.-J. Li, K. Li, and L. Fei- aurali-vectorsanddeepconvolutionalneuralnetworks,” .
Fei, “Imagenet:Alarge-scalehierarchicalimagedatabase,” in [20] J. Yue-Hei Ng, M. Hausknecht, S. Vijayanarasimhan,
ComputerVisionandPatternRecognition,2009.CVPR2009. O.Vinyals, R.Monga, andG.Toderici, “Beyondshortsnip-
IEEEConferenceon.IEEE,2009,pp.248–255. pets: Deep networks for video classification,” in Proceed-
ingsoftheIEEEConferenceonComputerVisionandPattern
| [7] R.F.Lyon, | “Machinehearing:Anemergingfield[exploratory |     |     |     |     |     |
| ------------- | ------------------------------------------- | --- | --- | --- | --- | --- |
Recognition,2015,pp.4694–4702.
dsp],”Ieeesignalprocessingmagazine,vol.27,no.5,pp.131–
139,2010. [21] A. Kumar and B. Raj, “Audio event detection using weakly
[8] A.Mesaros,T.Heittola,A.Eronen,andT.Virtanen,“Acoustic labeleddata,” arXivpreprintarXiv:1605.02401,2016.
eventdetectioninrealliferecordings,” inSignalProcessing [22] A. Singhal, “Introducing the knowledge graph:
Conference,201018thEuropean.IEEE,2010,pp.1267–1271. things, not strings,” 2012, Official Google blog,
[9] X. Zhuang, X. Zhou, M. A. Hasegawa-Johnson, and T. S. https://googleblog.blogspot.com/2012/05/
Huang, “Real-worldacousticeventdetection,” PatternRecog- introducing-knowledge-graph-things-not.
html.
nitionLetters,vol.31,no.12,pp.1543–1551,2010.
[10] J.F.Gemmeke,L.Vuegen,P.Karsmakers,B.Vanrumste,etal., [23] M.Abadietal., “TensorFlow: Large-scalemachinelearning
“Anexemplar-basednmfapproachtoaudioeventdetection,”in onheterogeneoussystems,”2015,Softwareavailablefromten-
| 2013IEEEWorkshoponApplicationsofSignalProcessingto |     |     |     | sorflow.org. |     |     |
| -------------------------------------------------- | --- | --- | --- | ------------ | --- | --- |
AudioandAcoustics.IEEE,2013,pp.1–4. [24] D.KingmaandJ.Ba, “Adam: Amethodforstochasticopti-
[11] A. Temko, R. Malkin, C. Zieger, D. Macho, C. Nadeu, and mization,” arXivpreprintarXiv:1412.6980,2014.
M. Omologo, “Clear evaluation of acoustic event detection [25] S. Ioffe and C. Szegedy, “Batch normalization: Accelerat-
andclassificationsystems,” inInternationalEvaluationWork- ingdeepnetworktrainingbyreducinginternalcovariateshift,”
shoponClassificationofEvents,ActivitiesandRelationships. arXivpreprintarXiv:1502.03167,2015.
Springer,2006,pp.311–322. [26] N.Srivastava, G.E.Hinton, A.Krizhevsky, I.Sutskever, and
[12] N.Takahashi, M.Gygli, B.Pfister, andL.VanGool, “Deep R.Salakhutdinov, “Dropout: asimplewaytopreventneural
convolutional neural networks and data augmentation for networksfromoverfitting.,” JournalofMachineLearningRe-
acoustic event detection,” arXiv preprint arXiv:1604.07160, search,vol.15,no.1,pp.1929–1958,2014.
2016. [27] T.Fawcett, “Rocgraphs: Notesandpracticalconsiderations
[13] G. Parascandolo, H. Huttunen, and T. Virtanen, “Recurrent forresearchers,” Machinelearning, vol.31, no.1, pp.1–38,
| neural networks | for polyphonic | sound event        | detection in real | 2004. |     |     |
| --------------- | -------------- | ------------------ | ----------------- | ----- | --- | --- |
|                 | 2016           | IEEE International | Conference on     |       |     |     |
life recordings,” in [28] C. Buckley and E. M. Voorhees, “Retrieval evaluation with
Acoustics, Speech and Signal Processing (ICASSP). IEEE, incomplete information,” in Proceedings of the 27th annual
2016,pp.6440–6444. internationalACMSIGIRconferenceonResearchanddevel-
[14] G. Awad, J. Fiscus, M. Michel, D. Joy, W. Kraaij, A. F. opmentininformationretrieval.ACM,2004,pp.25–32.
Smeaton,G.Quenot,M.Eskevich,R.Aly,andR.Ordelman, [29] V.NairandG.E.Hinton, “Rectifiedlinearunitsimprovere-
“Trecvid2016:Evaluatingvideosearch,videoeventdetection, strictedboltzmannmachines,”inProceedingsofthe27thInter-
localization, andhyperlinking,” inProceedingsofTRECVID nationalConferenceonMachineLearning(ICML-10), 2010,
| 2016.NIST,USA,2016. |     |     |     | pp.807–814. |     |     |
| ------------------- | --- | --- | --- | ----------- | --- | --- |
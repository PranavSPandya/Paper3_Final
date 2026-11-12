Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18
https://doi.org/10.1186/s12968-019-0523-x
RESEARCH OpenAccess
Automated quality control in image
segmentation: application to the UK
Biobank cardiovascular magnetic resonance
imaging study
RobertRobinson1* ,VanyaV.Valindria1,WenjiaBai1,OzanOktay1,BernhardKainz1,HideakiSuzuki2,
MihirM.Sanghvi4,5,NayAung4,5,JoséMiguelPaiva4,FilipZemrak4,5,KennethFung4,5,ElenaLukaschuk6,
AaronM.Lee4,5,ValentinaCarapella6,YoungJinKim6,7,StefanK.Piechnik6,StefanNeubauer6,
SteffenE.Petersen4,5,ChrisPage3,PaulM.Matthews2,8,DanielRueckert1andBenGlocker1
Abstract
Background: The trend towards large-scalestudiesincludingpopulationimagingposesnewchallengesinterms
ofqualitycontrol(QC).Thisisaparticularissuewhenautomaticprocessingtoolssuchasimagesegmentation
methodsareemployedtoderivequantitativemeasuresorbiomarkersforfurtheranalyses.Manualinspectionand
visualQCofeachsegmentationresultisnotfeasibleatlargescale.However,itisimportanttobeabletoautomatically
detectwhenasegmentationmethodfailsinordertoavoidinclusionofwrongmeasurementsintosubsequent
analyseswhichcouldotherwiseleadtoincorrectconclusions.
Methods: Toovercomethischallenge,weexploreanapproachforpredictingsegmentationqualitybasedon
ReverseClassificationAccuracy,whichenablesustodiscriminatebetweensuccessfulandfailedsegmentationsona
per-casesbasis.Wevalidatethisapproachonanew,large-scalemanually-annotatedsetof4800cardiovascular
magneticresonance(CMR)scans.Wethenapplyourmethodtoalargecohortof7250CMRonwhichwehave
performedmanualQC.
Results: WereportresultsusedforpredictingsegmentationqualitymetricsincludingDiceSimilarityCoefficient
(DSC)andsurface-distancemeasures.Asinitialvalidation,wepresentdatafor400scansdemonstrating99%accuracy
forclassifyinglowandhighqualitysegmentationsusingthepredictedDSCscores.Asfurthervalidationweshowhigh
correlationbetweenrealandpredictedscoresand95%classificationaccuracyon4800scansforwhichmanual
segmentationswereavailable.Wemimicreal-worldapplicationofthemethodon7250CMRwhereweshowgood
agreementbetweenpredictedqualitymetricsandmanualvisualQCscores.
Conclusions: WeshowthatReverseclassificationaccuracyhasthepotentialforaccurateandfullyautomatic
segmentationQConaper-casebasisinthecontextoflarge-scalepopulationimagingasintheUKBiobankImaging
Study.
Keywords: Automaticqualitycontrol,Populationimaging,Segmentation
*Correspondence:r.robinson16@imperial.ac.uk
1BiomedicalImageAnalysisGroup,DepartmentofComputing,Imperial
CollegeLondon,Queen’sGate,SW72AZLondon,UK
Fulllistofauthorinformationisavailableattheendofthearticle
©TheAuthor(s).2019OpenAccessThisarticleisdistributedunderthetermsoftheCreativeCommonsAttribution4.0
InternationalLicense(http://creativecommons.org/licenses/by/4.0/),whichpermitsunrestricteduse,distribution,and
reproductioninanymedium,providedyougiveappropriatecredittotheoriginalauthor(s)andthesource,providealinktothe
CreativeCommonslicense,andindicateifchangesweremade.TheCreativeCommonsPublicDomainDedicationwaiver
(http://creativecommons.org/publicdomain/zero/1.0/)appliestothedatamadeavailableinthisarticle,unlessotherwisestated.

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page2of14
Background large-scale. Our methodanddatasetsare then described
Biomedical image data are increasingly processed with in detail before we present our results and discuss their
automatedimageanalysispipelineswhichemployavari- implications.
ety of tools to extract clinically useful information. It is
importanttounderstandthelimitationsofsuchpipelines Relatedwork
andassessthequalityoftheresultsbeingreported.Thisis Despite its practical importance, there is relatively little
aparticularissuewhenweconsiderlarge-scalepopulation work on automatically predicting performance of image
imaging databases comprising thousands of images such analysismethods.Muchofthepriorworkonautomated
astheUKBiobank(UKBB)ImagingStudy[1].Thereare qualitycontrolhasfocusedonthequalityofimagesthem-
often many modules in automated pipelines [2] where selves. This focus on image quality assessment (IQA) is
each may contribute to inaccuracies in the final out- also true in the medical-imaging community [7, 8]. In
put and reduce the overall quality of the analysis, e.g. thecontextofimagesegmentation,thereexistonlyafew
intensity normalisation, segmentation, registration and methodsoutlinedhere.
featureextraction.Onalargescale,itisinfeasibletoper- Algorithmsoftenrelyon‘labels’tosupporttheirtrain-
formamanual,visualinspectionofalloutputs,andeven ing. In our case, each label would indicate the quality of
moredifficulttoperformqualitycontrol(QC)withinthe each segmentation, either by categorical label, e.g. 0 for
pipelineitself.Webreakdownthischallengeandfocuson ‘poor’ and 1 for ‘good’, or by continuous value such as
theautomatedQCofimagesegmentation. a Dice Similarity Coefficient (DSC). In cases where such
Image segmentation is the process of partitioning an labelleddataisscarce,ReverseValidation[9]andReverse
image into several parts where each of these parts is a Testing[10]uselabelsgeneratedbyonemodel,trainedon
collectionofpixels(orvoxels)correspondingtoapartic- asubsetofavailabledata,totrainanothermodelwhichis
ular structure. The purpose of segmentation is to derive evaluatedontheremainingdata.Thisiseffectivelycross-
quantitativemeasuresofthesestructures,e.g.calculating validationwheretheamountoflabelleddataislimited.In
ventricular volume or vessel thickness. Automated seg- ReverseTesting,‘somerules’arecreatedtoassesstheper-
mentationisdesiredtoreduceworkloadforthistedious, formanceofandrankthedifferentmodels.Inourcontext,
time-consuminganderrorpronetask.Anumberofthese thiswouldinvolvecreatingasegmentationqualitymodel
methodshavebeendeveloped,rangingfrombasicregion- fromasubsetofCMRscans,andtheircorrespondingseg-
growing techniques and graph cuts to more advanced mentations, which can then be tested on the remaining
algorithms involving machine learning [3] and, more images. Different models would be created and tested in
recently, Deep Learning in the form of Convolutional order to choose the best model. The difficulty in these
NeuralNetworks(CNNs)[4]. methods is that we require all of the scans to be accu-
Segmentationperformanceistraditionallyevaluatedon ratelysegmentedinordertotrain,andtoevaluate,agood
a labelled validation dataset, which is a subset of the model. That is, we need a large, fully-annotated training
datasetthatisthealgorithmdoesnotseeduringtraining. dataset which is often not available in our field. Addi-
Thisevaluationisdoneusingaseriesofmetricstocom- tionally, Reverse Validation and Reverse Testing do not
parethepredictedsegmentationandareference‘ground allowustoidentifyindividualcaseswhereasegmentation
truth’ (GT). Popular metrics include volumetric overlap mayhavefailed;insteadtheyfocusuponthesegmentation
[5],surfacedistancesorotherstatisticalmeasures[6].Due methodasawhole.
to the lack of actual GT, manual expert annotations are In a method proposed by Kohlberger et al., the qual-
used as reference, despite inter- and intra-rater variabil- ityofsegmentationsisassessedonaper-casebasisusing
ity. Once a segmentation method is deployed in clinical machine learning. The group used 42 different hand-
practicenosuchquantitativeevaluationcanbecarriedout crafted statistics about the intensity and appearance of
routinely. multi-organcomputed-tomography(CT)scanstoinform
Evaluatingtheaverageperformanceofanalgorithmon their model. Whilst this method achieved good perfor-
validationdataisarguablylessimportantthanbeingable mancemetricsandanaccuracyofaround85%,itrequires
to assess the quality on a per-case basis, and it is crucial a lot of training data with both good and bad segmenta-
to identify cases where the segmentation has failed. We tionswhichisnon-trivialtoobtain.
show that we can effectively predict the per-case quality Inthiswork,weadopttherecently-proposedapproach
of automated segmentations of 3D cardiovascular mag- of Reverse Classification Accuracy (RCA) [11]. Unlike
netic resonance (CMR) from the UKBB which enables Reverse Validation and Reverse Testing, RCA can accu-
fullyautomatedQCinlarge-scalepopulationstudiesand ratelypredictthequalityofasegmentationonacase-by-
clinicalpractice. casebasisonlyrequiringarelativelysmallsetofaccurately
In this article we will first present related work that segmented reference images. In RCA, the predicted seg-
attempts to address the problem of automated QC at mentationbeingassessedisusedtocreateasmallmodel

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page3of14
to re-segment the reference images for which segmenta- [12]andCNNs.Inthiscontext,andthroughoutthispaper,
tionsareavailable.Ifatleastoneimageinthereferenceset an‘atlas’referstoanimage-segmentationpairwhoseseg-
isre-segmentedwell,thepredictedsegmentation,thatwe mentation has been verified by a manual annotator. In
wishtoassess,musthavebeenofgoodquality.Weemploy Valindria’s paper, a simple single-atlas registration clas-
RCA to perform segmentation quality analysis on a per- sifier outperformed both the AF and CNN approaches
case basis while only requiring a small set of reference in predicting segmentation accuracy. For this reason, we
imagesandsegmentations. chose to use this simple approach for the model in our
work.Registrationistheprocessofaligningtwoormore
Methodsanddata imagesbaseduponsimilarcontentwithinthem,e.g.struc-
Ourpurposeistohaveasystemthatisabletopredictthe turesorintensities.Rigidregistrationrestrictstheimages
per-casequalityofasegmentationproducedbyanyalgo- to move only by linear translations and rotations. More
rithmdeployedinclinicalpractice.Wewantourmethod complexnon-rigidregistrationmethodsexiststhatallow
tonotonlygiveusapredictionofthequalityoftheseg- fordifferencesinscalebetweentheimagesandformore
mentation,buttobeabletoidentifyifthatsegmentation complex distortions. The single-atlas registration classi-
hasfailed.Tothisend,weemployRCAwhichwillgivea fierinRCAworksbyperformingnon-rigidregistrationof
predictionaboutthequalityofindividualsegmentations. thetest-imagetoasetofindividualreference-images.The
resultingtransformationsarethenusedtowarpthetest-
Reverseclassificationaccuracy segmentation. This yields a set of warped segmentations
In RCA the idea is to build a model, also known as an which are quantitatively compared to the reference seg-
‘RCA classifier’, solely using one test image and its pre- mentations. The overlap between the pairs is calculated
dicted segmentation which acts as pseudo ground truth. astheDSCwhilstboundaryagreementiscomputedusing
Thisclassifieristhenevaluatedonareferencedatasetfor surface-distance metrics. The best metric values among
whichsegmentationsareavailable.Therearetwopossible the reference set are taken to be the prediction for the
outcomestothisprocedure: qualityofthetest-segmentation.
We chose to modify the single-atlas registration clas-
•
Case1:assumingthatthepredictedsegmentationis sifier from that used in Valindria et al.’s proposal of the
ofgoodquality,thecreatedmodelshouldbeableto RCA method [11]. Processing and modifying the test-
segmentatleastoneofthereferenceimageswith segmentation is not usually desirable as this may intro-
highaccuracy.Thisislikelytobeareferenceimage duce discretization artefacts adding false-positives into
whichissimilartothetestimage. the binary labelmap. We choose to perform the single-
•
Case2:ifnoneofthereferenceimagesare atlas registration in reverse: we register the reference-
segmentedsuccessfully,thenthepredicted images to the test-image and use this transformation to
segmentationislikelytobeofpoorquality. warpthereferencesegmentations.Thisresultsinasetof
warped segmentations in the test-image space which are
Theseassumptionsarevalidifthereferencedatasetisrep- thencomparedtothetest-segmentation.Figure1givesan
resentative of the test data. This is usually the case in overviewofRCAasappliedinourstudy.Wenowsetout
thecontextofmachinelearningwherethereferencedata ourframeworkmoreformally.
could have beenusedin the first place to train the auto- (cid:2) For the R(cid:3)CA reference images, we use a set R i =
mated method for which we want to predict test perfor- r
i
1,··· ,r
i
N ofN(cid:2) cardiaca(cid:3)tlaseswithreferencesegmen-
mance.Ifthetestdatawereverydifferent,theautomated t(cid:2)ations R s (cid:3) = r s 1,··· ,r s N . We have a test set T i =
method would in any case not perform well, and RCA t
i
1,··· ,t
i
M of M images with(cid:2)automatica(cid:3)lly generated
scores would reflect this. It is a great advantage that the predicted segmentations T = t1,··· ,tM whose qual-
s s s
samereferencedatasetcanbeusedtotrainanautomated ity we w(cid:4)ould like t(cid:5)o assess. If the GT segmentations
segmentation method, and also afterwards serves as the
T = t1,··· ,tM for T exist, one can evaluate the
reference database enabling prediction of performance gt gt gt i
accuracyofthesequalityassessments.UsingRCAweesti-
afterdeploymentofthesegmentationmethod.
mate the quality of those predicted segmentations and
TheperformanceoftheRCAclassifieronthereference
set is measured with any chosen quality metric, e.g., the compare the estimates to the real quality with respect
DSC.Thehighestscoreamongallreferenceimagesdeter- totheGT.
minesthequalityestimateforthepredictedsegmentation Inthecasewherem = k,wetakethekth testimagetk
i
obtainedforatestimage.
anditspredictedsegmentationtk.ToapplyRCA,allref-
s
The original work on RCA [11] explored a variety of erence images R i are first registered to t i k by performing
possible classifiers that could be trained on a single test- arigidregistrationintheformofacentreofmass(CoM)
image and its segmentation including Atlas Forests (AF) alignment.Initialversionsofourwork[13]usedlandmark

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page4of14
Fig.1ReverseClassificationAccuracy-Single-atlasRegistrationClassifier.ReverseClassificationAccuracy(RCA),withsingle-atlasregistration
classifier,asappliedinourstudy.Asetofreferenceimagesarefirstregisteredtothetest-imagebeforetheresultingtransformationsareusedto
warpthecorrespondingreferencesegmentations.DiceSimilarityCoefficient(DSC)iscalculatedbetweenthewarpedsegmentationsandthe
test-segmentationwiththemaximumDSCtakenasaproxyfortheaccuracyofthetest-segmentation.Notethatinpractice,thegroundtruth
test-segmentationisabsent.Imagesandsegmentationannotatedasreferredtointhetext
registration [14] at this stage, but we now opt for CoM Evaluationofpredictedaccuracy
alignmenttoreducecomputationalcost.Wethenperform The segmentation quality metrics predicited with RCA
non-linearregistrationofeachalignedreferenceimagein include the DSC, mean surface distance (MSD), root-
R tothetestimagetogetwarpedreferenceimagesRk . mean-square surface distance (RMSD) and Hausdorff
i iW
ThesametransformationsareusedtowarptheGTrefer- distance (HD). For two segmentations, A and B,
encesegmentationsR s togetthesetRk sW .Foreachwarped DSC is a measure of overlap given by DSC =
segmentation in Rk we compare against the predicted 2|A∩B|/(|A|+|B|). The surface distance between a
sW
segmentation tk by evaluating a set of metrics detailed pointaonthesurfaceofAandthesurfaceofBisgivenby
s
below. The best value for each metric over all warped theminimumoftheeuclideannormmin b∈B ||a−b|| 2 for
reference segmentations is taken to be the prediction of allpointsbinthesurfaceofB.Thetotalsurfacedistance
segmentationaccuracyfortk.Inourvalidationstudies,we isthesumofthesurfacedistancesforallpointsinA.We
s
cancomputetherealmetricsbycomparingthepredicted don’tassumesymmetryinthesecalculations,sothesur-
segmentationtk withitsGTtk. facedistanceisalsocalculatedfromBtoA.Bytakingthe
s gt

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page5of14
meanoverallpointswegettheMSD.RMSDiscalculated is being used i.e. it should be of the same domain (SAX
by taking the square of surface distances, averaging and CMRinthiscase)andlargeenoughtocapturesomevari-
takingthesquareroot.Finally,theHDistakentobethe abilityacrossthedataset.Areferencesetthatistoosmall
maximumsurfacedistance. mayunderestimatetheRCAprediction.Thoughweargue
For each test image, we report the evaluation met- thatthismaybebetterthanoverestimatingthequalityof
rics for each class label: left ventricular (LV) cavity, LV asegmentation.Conversely,toolargeareferencesetwill
myocardium (LVM) and right ventricular (RV) cavity causeasignificantlengtheningofRCAexecutiontime.We
(RVC).Weincorporatethevoxelsofthepapillarymuscles haveexploredtheeffectoftheRCAreferencesetsizeon
intotheLVcavityclass.TheRVmyocardiumisdifficultto thepredictionaccuracyaspartofourevlauationwhichwe
segment because it is thin, therefore it is seldom seen in presentinourDiscussion.
short-axis(SAX)CMRsegmentationsandnotconsidered
inthispaper.Foreachevaluationmetric(DSCandsurface ExperimentA:Initialvalidationstudy,N=400
distances),wecouldreporttwodifferenceaveragevalues: Data:WevalidateRCAonpredictingcardiacimageseg-
eitherawhole-heartaveragebycombiningallclasslabels mentation quality using 100 manually verified image-
intoasingle‘whole-heart’(WH)classor,second,bytaking segmentationpairs(differentfromthereferencedataset).
themeanacrosstheindividualclassscores.TheWH-class EachatlascontainsaSAXED3D(2D-stack)CMRandits
averageisusuallyhigherbecauseavoxelattributedtoan manualsegmentation.Theimageshaveapixel-resolution
incorrectclasswillreducethemeancalculatedacrossthe of 1.25×1.25×2.0 mm and span 256×256×56 vox-
classes,butwillactuallybeconsideredcorrectinthesingle els.Eachmanualsegmentationidentifiesvoxelsbelonging
WH-classcase. totheLVcavity,LVmyocardiumandRVcavityseparating
theheartfromthebackgroundclass.
Experimentalsetup For validation, we generate automatic segmentations
We perform three investigations in this work which are of our atlases with varying quality. We employ Random
summarisedinTable1:A)aninitialsmall-scalevalidation Forests with T = 500 trees and a maximum depth of
studyon400testcontoursof80imagesfromaninternal D = 40 trained on the same set of 100 cardiac atlases
cardiac atlas dataset; B) a large-scale validation study on usedfortestingRCAinthisexperiment.RandomForests
another4805UKBBimageswithmanualgroundtruthand allow us to produce a variety of test segmentations with
C)areal-worldapplicationtoalargesetof7250UKBB3D intentionally degraded segmentation quality by limiting
CMRsegmentations. the depth of the trees during test time. We obtain 4 sets
of100segmentationsbyusingdepthsof5,20,30and40.
Referencedataset,N=100
Thus,atotalof400segmentationsareusedinourinitial
The reference image set is the same in all of our stud- validationstudy.
ies. We use 100 2D-stack SAX end-diastolic (ED) CMR Evaluation:WeperformRCAonall400segmentations
scansthatwereautomaticallysegmentedandvalidatedby to yield predictions of segmentation quality. The man-
expertcliniciansatHammersmithHospital,London.Note ual segmentations allow us to evaluate the real metrics
that the reference set is distinct from all other datasets for each automated segmentation. We compare these to
used. Compared with data from the UKBB, the refer- thequalitypredictedbyRCA.Toidentifyindividualcases
ence set are of higher in-plane resolution at 1.25×1.25 where segmentation has failed, we implement a simple
mm and have a smaller slice thickness of 2 mm. These classification strategy similar to that in Valindria’s work
images are not used for any purpose other than for this [11]. We consider a 2-group binary classification where
referenceset.Whenchoosingareferenceset,oneshould DSC scores in the range [0.0 0.7) are considered ‘poor’
ensurethatitisrepresentativeofthedatasetonwhichit andintherange[0.71.0]are‘good’.Theseboundariesare
somewhatarbitraryandwouldbeadjustedforaparticular
Table1Asummaryoftheexperimentsperformedinthisstudy use-case. Other strategies could be employed on a task-
Experiment Dataset Size GT Seg.Method specific basis, e.g. formulation as outlier detection with
further statistical measures. The thresholding approach
A Hammersmith 100 Yes RF
allowsustocalculatetrue(TPR)andfalse(FPR)positive
B UKBB-2964 4805 Yes RFandCNN
rates for our method as well as an overall accuracy from
C UKBB-18545 7250 No Multi-Atlas
theconfusionmatrix.
ExperimentAusesdatafromaninternaldatasetwhichissegmentedwitha
multi-atlassegmentationapproachandmanuallyvalidatedbyexpertsat
ExperimentB:Large-scalevalidationon
HammersmithHospital,London.Thesemanualvalidationsarecountedas‘ground
truth’(GT)and100ofthemaretakenforthereferencesetusedinallexperiments. manually-segmentedUKBBData,N=4805
UKBBdatasetsareshownwiththeirapplicationnumbers.InexperimentCwe
InthisexperimentwedemonstratethatRCAisrobustfor
segmentwithbothrandomforests(RF)andaconvolutionalneuralnetwork(CNN).
InCtheCNNfromBai[4]isused employment in large-scale studies, and indeed produces

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page6of14
accurate predictions of segmentation quality on an indi- andapicallayers.Foreachlayerascorebetween0and2is
vidual basis. As part of our collaboration under UK assignedbasedonthequalityofonlytheLVmyocardium
Biobank Application 2964 we have access to 4805 CMR segmentation.The total QC score is thus between 0 and
imageswithmanuallydrawncontours. 6,wherea6wouldbeconsideredasahighlyaccurateseg-
Data:InthecontextofUKBBdata,3Dmeansastackof mentation.Scoresforindividuallayerswerenotrecorded.
2Dacquisitionswithslice-thicknessof8.0mmandslice- WheretheUKBBimageshadapoorfield-of-view(FOV),
gapof2mm[15].TheCMRscanshavein-planeresolution thesegmentationswereimmediatelydiscardedforusein
of1.83×1.83mmandspanaround192×208pixelsper theGWASstudy:wehavegiventheseimagesascoreof-1.
slice. The number of slices per scan varies between 4-14 FortheGWASstudy,poorFOVmeantanyimageinwhich
withthemajority(89%)having9-12slices. theentireheartwasnotvisible.Weexpectthatdespitethe
Petersen and colleagues [16, 17] manually segmented poorFOVoftheseimages,thesegmentationsthemselves
all slices of each 3D CMR scan available under the data maystillbeofgoodqualityasthealgorithmscanstillsee
accessapplication.Severalannotatorswereemployedfol- mostoftheheart.Outofthe7250segmentedimages,152
lowingastandardoperatingproceduretogeneratealmost haveabadFOV(QC=−1)and42haveanobviouslypoor
5000high-qualitysegmentations.Withthesemanualseg- segmentation (QC = 0). There are 2, 14, 44, 300, 2866
mentations acting as GT we directly compare predicted and 3830 images having QC scores 1 to 6 respectively.
segmentationscoreswithrealscoresatlargescale. This investigation explored how well RCA-based quality
We use the same Random Forests trained in Experi- predictionscorrelatewiththosemanualQCscores.
ment A to perform automated segmentations at various Evaluation: We perform RCA on all 7250 segmen-
treedepthschosenrandomlyacrossthe4805scansyield- tations to yield predictions of segmentation quality for
ing segmentations of varying quality. In addition to our the LVM. With the absence of GT segmentations, we
Random Forests segmentations, we evaluate RCA with are unable to perform the same evaluation as in Exper-
900 segmentations generated with a recent deep learn- iments A and B. In this case, we determine the cor-
ing based approach. As part of the UKBB Application relation between the predicted scores from RCA (for
2964, Bai et al. [4] have trained a CNN on 3900 man- LV myocardium) and the manual QC scores. A visual
ually segmented images. The remaining 900 were then inspectionofindividualcasesisalsoperformedatquality
automatically segmentedusing the trained network. The categories.
results of Bai et al.’s CNN approach reflect the state-
of-the-art in automated 3D CMR segmentation with an Results
accuracymatchingtheperformancehumanexperts[4]. Herewepresentresultsfromourthreeinvestigations:(A)
Evaluation: We perform RCA on all 4805 Random theinitialsmall-scalevalidationstudy;(B)applicationtoa
Forests segmentations to yield predictions of segmenta- largesetofUKBBCMRwithvisualQCscores;and(C)a
tionquality.WealsoperformRCAseparatelyonthe900 furtherlarge-scalevalidationstudyonUKBBwithmanual
CNNsegmentationsproducedbyastate-of-the-artdeep expertsegmentations.
learningapproach.WiththeavailabilityofGTmanualseg- Quantitative results for the experiments are presented
mentations,wecanevaluatethisexperimentinthesame ineachsection.Figure2demonstratesadditionalqualita-
wayasExperimentA. tiveinspectionthatisperformedonaper-casebasisdur-
ingRCA.ThetoprowofFig.2showsthemid-ventricular
ExperimentC:AutomaticqualitycontrolintheUKBBimaging sliceofanEDCMRscanandaRandomForest-generated
study,N=7250 segmentation which is under test. An overlay of the two
Having evaluated RCA in the previous two experiments, arealsoshownalongsidethemanualreferencesegmenta-
thisexperimentmimicshowourapproachwouldbehave tionwhichisnotavailableinpractice.Belowthis,anarray
in a real-world application where the GT is unavailable. offurtherpanelsisshown.Eachofthesepanelspresents
WeapplyRCAtosegmentationsofCMRimagesfromthe one of the 100 reference images used, its correspond-
UKBB. ing reference segmentation and the result of warping
Data: In total, 7250 CMR images were available to thesegmentation-under-test(top-panel,secondimage)to
us through the UKBB resource. Each image has been this reference image. The calculated DSC between the
automaticallysegmentedusingamulti-atlassegmentation reference image’s GT and the warped segmentation is
approach[18].Aspartofagenome-wideassociationstudy displayed above each panel. The array shows the refer-
(GWAS),eachautomaticsegmentationhasbeenchecked ence image with the highest (top-left) and the lowest
manuallytoconfirmsegmentationquality.Asthereisno (bottom-right) calculated DSC with the remaining pan-
GTsegmentation,werelyonmanualQCscoresforthese elsshowingDSCsthatareuniformlyspacedamongstthe
segmentations assessed by a clinical expert. The manual remaining98referenceimages.Wecanseeinthisexam-
QC is based only on visual inspection of the basal, mid plethatthereisalargerangeofpredictedDSCvalues,but

Robinsonetal.JournalofCardiovascularMagneticResonance           (2019) 21:18  Page7of14
Fig.2ExampleResultsfromRCA.ExamplesofRCAresultsononeproposedsegmentation.Thepanelsinthetoprowshow(lefttoright)theMRI
scan,thepredictedsegmentation,anoverlayandthemanualannotation.Thearraybelowshowsasubsetofthe100referenceimagesorderedby
Dicesimilaritycoefficient(DSC)andequallyspacedfromhighesttolowestDSC.Thearrayshows(left)thereferenceimage,(middle)itsgroundtruth
segmentationand(right)thetest-segmentationfromtheupperrowwhichhasbeenwarpedtothereferenceimage.TherealDSCbetweeneach
referenceimageandwarpedsegmentationisshownforeachpair.RCA-predictedandrealGT-calculatedDSCsareshownforthewhole-heartbinary
classificationcaseatthetopalongsidethemetricsforeachindividualclassinthesegmentation
onlythemaximumprediction,selectedinred,isusedas where individual class labels are merged into one. These
the prediction of segmentation quality. For the example valuesareshownabovethetoppanelalongwiththeDSC
in Fig. 2 we show a ‘good’ quality segmentation-under- calculatedonaper-classbasis.
test for which we are predicting a DSC of 0.904 using Forconsiderationsofspace,wedonotshowmorevisual
RCA.TherealDSCbetweenthesegmentation-under-test examplesbutnotethatavisualisationasinFig.2couldbe
and the GT manual segmentation is 0.944. Note that in producedonaper-casebasisinadeployedsystemaiding
thiscasethesevaluesarecalculatedforthe‘whole-heart’ interpretabilityandvisualmeansformanualvalidationby
humanexperts.
Table2Initialreverseclassificationaccuracyvalidationon400
randomforestsegmentations
(A)Initialvalidationstudy
MAE
AsummaryoftheresultsisshowninTable2.Weobserve
| Class Acc. | TPR FPR | DSC MSD | RMS HD |                                                   |                |                  |            |
| ---------- | ------- | ------- | ------ | ------------------------------------------------- | -------------- | ---------------- | ---------- |
|            |         |         |        | low mean                                          | absolute error | (MAE) across all | evaluation |
|            |         | mm      | mm mm  | metricsandallclasslabels.ThescatterplotsinFig.3on |                |                  |            |
LVC 0.973 0.977 0.036 realandpredictedscoresillustrate theverygoodperfor-
|     |     | 0.020 4.104 | 5.593 14.15 |     |     |     |     |
| --- | --- | ----------- | ----------- | --- | --- | --- | --- |
manceofRCAinpredictingsegmentationqualityscores.
| 0.980     | 0.975 0.019 |     |     |         |                |                             |     |
| --------- | ----------- | --- | --- | ------- | -------------- | --------------------------- | --- |
|           |             |     |     | We also | find that from | the 400 test segmentations, | RCA |
| LVM 0.815 | 0.947 0.215 |     |     |         |                |                             |     |
∈
0.044 3.756 4.741 13.08 is able to classify ‘good’ (DSC [0.71.0]) and ‘poor’
| 0.990 | 0.987 0.008 |     |     |     |     |     |     |
| ----- | ----------- | --- | --- | --- | --- | --- | --- |
(DSC∈[0.10.7))segmentationswithanaccuracyof99%.
| RVC 0.985 | 0.923 0.012 |     |     |     |     |     |     |
| --------- | ----------- | --- | --- | --- | --- | --- | --- |
0.030 4.104 5.022 16.63 From171poorsegmentationsatthisthreshold,166could
0.943 0.914 0.047 becorrectlyidentifiedbyRCA,i.e.97.1%.100%ofgood-
Av. 0.924 0.949 0.089 quality segmentations were correctly labelled. Addition-
|     |     | 0.031 3.988 | 5.119 14.62 |     |     |     |     |
| --- | --- | ----------- | ----------- | --- | --- | --- | --- |
0.971 0.959 0.025 ally, we find binary classification accuracy of 95% when
|          |             |             |             | applying           | a threshold of | 2.0 mm on the MSD.        | From 365 |
| -------- | ----------- | ----------- | ----------- | ------------------ | -------------- | ------------------------- | -------- |
| WH 0.988 | 0.979 0.000 |             |             |                    |                |                           |          |
|          |             | 0.029 4.445 | 5.504 15.11 |                    |                |                           |          |
|          |             |             |             | poor segmentations | at             | this threshold, 348 could | be cor-  |
| 0.948    | 0.886 0.047 |             |             |                    |                |                           |          |
|          |             |             |             | rectly identified  | by RCA,        | i.e. 95.3%. Similarly,    | 31 from  |
ClassesareLVCavity(LVC),LVMyocardium(LVM),RVCavity(RVC),Anaverageover 35 (88.6%) good-quality segmentations were correctly
theclasses(Av.)andabinarysegmentationofthewholeheart(WH).Firstrowfor
eachclassshowsthebinaryclassificationaccuracyfor‘poor’and‘good’ labelled.Forallevaluationmetrics,thereisastrong,pos-
segmentationsintheDiceSimilarityCoefficient(DSC)ranges[0.00.7)and[0.71.0] itivelinearrelationshipbetweenpredictedandrealvalues
respectively.Secondrowforeachclassshowsthebinaryclassificationaccuracyfor r ∈ p <
‘poor’and‘good’segmentationsintheMeanSurfaceDistance(MSD)ranges with [0.950.99] and 0.0001. Further analysis of
[>2.0mm]and[0.0mm2.0mm]respectively.True-positiveandfalse-positiverates ourdatashowsincreasingabsoluteerrorineachmetricas
arealsoshown.Wereportmeanabsoluteerrors(MAE)onthepredictionsofDSC therealscoregetsworse,e.g.theerrorforMSDincreases
andadditionalsurface-distancemetrics:root-mean-squaredsurfacedistance(RMS)
andHausdorffdistance(HD) with increasing surface distance. This correlates larger

Robinsonetal.JournalofCardiovascularMagneticResonance           (2019) 21:18  Page8of14
Fig.3RCAValidationon400cardiacMRI.400cardiacMRIsegmentationsweregeneratedwithaRandomForestclassifier.500treesanddepthsin
therange[5, 40]wereusedtosimulatevariousdegreesofsegmentationquality.RCAwithsingle-atlasclassifierwasusedtopredicttheDice
SimilarityCoefficient(DSC),meansurfacedistance(MSD),rootmean-squaredsurfacedistance(RMS)andHausdorffdistance(HD).Groundtruthfor
thescansisknownsorealmetricsarealsocalculated.Allcalculationsonthewhole-heartbinaryclassificationtask.Wereportlowmeanabsolute
error(MAE)forallmetricsand99%binaryclassificationaccuracy(TPR=0.98,FPR=0.00)withaDSCthresholdof0.70.Highaccuracyforindividual
segmentationclasses.Absoluteerrorforeachimageisshownforeachmetric.Wenoteincreasingerrorwithdecreasingqualityofsegmentation
basedontherealmetricscore
MAEwithlowersegmentationquality.Inaddition,when (B)Large-scalevalidationwithmanualGTonUKBB
weconsideronlythosesegmentationswheretherealmet- Results for the Random Forest segmentations are shown
ricis30orless,theMAEdropsignificantlyto0.65,1.71 in Table 3. We report 95% binary classification accuracy
and6.78mmforMSD,RMSandHDrespectively.Weare with a DSC threshold of 0.7 and low MAE on the DSC.
notconcernedwithgreatererrorsforpoorsegmentations From589poorsegmentationsatthisthreshold,443could
as they are still likely to be identified by RCA as having becorrectlyidentifiedbyRCA,i.e.75.2%.Similarly,4139
| failed. |     |     |     | from4216(98.2%)good-qualitysegmentationswerecor- |               |                      |                |
| ------- | --- | --- | --- | ------------------------------------------------ | ------------- | -------------------- | -------------- |
|         |     |     |     | rectly labelled.                                 | Additionally, | we find binary       | classification |
|         |     |     |     | accuracy                                         | of 98% when   | applying a threshold | of 2.0 mm      |
Table3Analysisof4800RandomForestsegmentationswith
|     |     |     |     | on the | MSD. From 2497 | poor segmentations | at this |
| --- | --- | --- | --- | ------ | -------------- | ------------------ | ------- |
availablegroundtruth
threshold,2429couldbecorrectlyidentifiedbyRCA,i.e.
|            |         | MAE     |        | 97.3%. Similarly, | 2270 | from 2308 (98.3%) | good-quality |
| ---------- | ------- | ------- | ------ | ----------------- | ---- | ----------------- | ------------ |
| Class Acc. | TPR FPR | DSC MSD | RMS HD |                   |      |                   |              |
segmentationswerecorrectlylabelled.TheTPRarehigh
|           |             | mm          | mm mm       | acrosstheclasses,thisshowsRCAisabletocorrectlyand |                 |                        |                |
| --------- | ----------- | ----------- | ----------- | ------------------------------------------------- | --------------- | ---------------------- | -------------- |
|           |             |             |             | consistently                                      | identify ‘good’ | quality segmentations. | MSD-           |
| LVC 0.968 | 0.997 0.330 |             |             |                                                   |                 |                        |                |
|           |             | 0.042 0.906 | 2.514 11.09 |                                                   |                 |                        |                |
|           |             |             |             | based FPR                                         | are shown       | to be lower than       | those based on |
| 0.975     | 0.962 0.011 |             |             |                                                   |                 |                        |                |
DSC,thiswouldindicatethatMSDismorediscriminative
LVM 0.454 0.956 0.571 for‘poor’qualitysegmentationsanddoesnotmisclassify
|       |             | 0.125 0.963 | 2.141 11.83 |         |              |             |                    |
| ----- | ----------- | ----------- | ----------- | ------- | ------------ | ----------- | ------------------ |
| 0.972 | 0.962 0.012 |             |             |         |              |             |                    |
|       |             |             |             | them so | much as DSC. | We identify | only two instances |
RVC 0.868 0.957 0.352 where RCA predictions do not conform to the overall
|     |     | 0.057 1.140 | 2.790 15.23 |     |     |     |     |
| --- | --- | ----------- | ----------- | --- | --- | --- | --- |
0.969 0.977 0.040 trend and predict much higher than the real DSC. On
|           |             |     |     | inspection, | we find that | the GT of these | segmentations |
| --------- | ----------- | --- | --- | ----------- | ------------ | --------------- | ------------- |
| Av. 0.763 | 0.970 0.418 |     |     |             |              |                 |               |
0.075 1.003 2.482 12.72 were missing mid-slices causing the real DSC to drop.
| 0.972    | 0.967 0.032 |     |     |              |             |                        |       |
| -------- | ----------- | --- | --- | ------------ | ----------- | ---------------------- | ----- |
|          |             |     |     | These points | can be seen | in the upper-left-hand | quad- |
| WH 0.954 | 0.966 0.148 |     |     |              |             |                        |       |
rantonFig.4.Thefigurealsoshowsthat,overallmetrics,
|       |             | 0.035 1.156 | 2.762 12.52 |     |     |     |     |
| ----- | ----------- | ----------- | ----------- | --- | --- | --- | --- |
| 0.978 | 0.984 0.027 |             |             |     |     |     |     |
thereishighcorrelationbetweenpredictedandrealqual-
4800RFsegmentationatvariousdepths[540]and500trees.Manualcontours ity metrics. This is very much comparable to the results
wereavailablethroughBiobankApplication2964.ClassesareLVCavity(LVC),LV fromourinitialvalidationstudy(A)inFig.3.Thestrong
Myocardium(LVM),RVCavity(RVC),anaverageovertheclasses(Av.)andabinary
segmentationofthewholeheart(WH).Firstrowforeachclassshowsthebinary relationship between the predicted quality metrics from
classificationaccuracyfor‘poor’and‘good’segmentationsintheDiceSimilarity RCAandtheequivalentscorescalculatedwithrespectto
Coefficient(DSC)ranges[0.00.7)and[0.71.0]respectively.Secondrowforeach
classshowsthebinaryclassificationaccuracyfor‘poor’and‘good’segmentationsin the manual segmentations demonstrates concretely that
theMeanSurfaceDistance(MSD)ranges[>2.0mm]and[0.0mm2.0mm] RCAiscapableofcorrectlyidentifying,onacase-by-case
respectively.True-positiveandfalse-positiveratesarealsoshown.Wereportmean basis,segmentationsofpoorqualityinlarge-scaleimaging
absoluteerrors(MAE)onthepredictionsofDSCandadditionalsurface-distance
| metrics:root-mean-squaredsurfacedistance(RMS)andHausdorffdistance(HD) |     |     |     | studies. |     |     |     |
| --------------------------------------------------------------------- | --- | --- | --- | -------- | --- | --- | --- |

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page9of14
Fig.4Validationon4805RandomForestsegmentationsofUKBBImagingStudywithGroundTruth.4,805cardiacMRIweresegmentedwitha
RandomForestclassifier.500treesanddepthsintherange[540]wereusedtosimulatevariousdegreesofsegmentationquality.Manualcontours
wereavailablethroughBiobankApplication2964.RCAwithsingle-atlasclassifierwasusedtopredicttheDiceSimilarityCoefficient(DSC),mean
surfacedistance(MSD),rootmean-squaredsurfacedistance(RMS)andHausdorffdistance(HD).Allcalculationsonthewhole-heartbinary
classificationtask.Wereportlowmeanabsoluteerror(MAE)forallmetricsand95%binaryclassificationaccuracy(TPR=0.97andFPR=0.15)witha
DSCthresholdof0.70.Highaccuracyforindividualsegmentationclasses
On the CNN segmentations, we report 99.8% accu- havebeencorrectlyidentifiedassuchusingRCA.Table4
racy in binary classification for the whole-heart class. showsthedetailedstatisticsforthisexperiment.
With a DSC threshold set at 0.7, RCA correctly iden- We note that the individual class accuracy for the LV
tified 898 from 900 good-quality segmentations with 2 myocardiumislowerintheCNNcasewhenDSCisused
false-negatives. A visualization of this can be seen in atthequalitymetric.Weshowtheresultsforthisclassin
the top panel of Fig. 5 where the predicted and real thebottompanelofFig.5.Segmentorscanhavedifficulty
DSC can be seen clustered in the high-quality corner of with this class due to its more complex shape. From the
each metric’s plot (upper-right for DSC and lower-left plottedpointsweseeallcasesfallintoasimilarclusterto
forsurface-distancemetrics).Thisreflectsthehighqual- the average WH case, but the RCA score under-predicts
ity segmentations of the deep learning approach which the real DSC. This exemplifies a task-specific setting for
Fig.5ExtensiveReverseClassificationAccuracyValidationon900UKBBSegmentations.Convolutionalneuralnetwork(CNN)segmentationasinBai
etal.[4].ManualcontourswereavailablethroughBiobankApplication2964.RCAwithsingle-atlasclassifierwasusedtopredicttheDiceSimilarity
Coefficient(DSC),meansurfacedistance(MSD),rootmean-squaredsurfacedistance(RMS)andHausdorffdistance(HD).Allcalculationsforthe
binaryqualityclassificationtaskon(top)’WholeHeart’averageand(bottom)LeftVentricularMyocardium.Wereportlowmeanabsoluteerror(MAE)
forallmetricsand99.8%binaryclassificationaccuracy(TPR=1.00andFPR=0.00)withaDSCthresholdof0.70

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page10of14
Table4Analysisof900CNNsegmentationswithavailable
DSC from RCA and the high manual QC score. These
groundtruth
examples demonstrate RCA’s ability to correctly identify
MAE both good and poor quality segmentations when per-
Class Acc. TPR FPR DSC MSD RMS HD forming assessments over an entire 3D segmentation. It
mm mm mm also demonstrates the limitations of manual QC and the
success of RCA in identifying segmentation failure on a
LVC 0.998 1.000 0.000
0.082 0.386 0.442 1.344 per-casebasis.
1.000 1.000 0.000
CreatingasetofmanualQCscoresforover7200images
LVM 0.051 1.000 0.001
0.268 0.510 0.547 2.127 is a laborious task but it has provided worthwhile evi-
1.000 1.000 0.000 dence for the utility of RCA on large-scale studies. It is
RVC 0.901 1.000 0.033 clear,however,thatthe3-layerinspectionapproachwith
0.146 0.588 0.656 2.086
0.997 0.997 0.000 a single-rater has limitations. First, inspecting all layers
would be preferable, but it highly time-consuming and,
Av. 0.650 1.000 0.011
0.165 0.495 0.548 1.852 second,withmultipleraters,averagingormajorityvoting
0.999 0.999 0.000
couldbeemployedtoreducehumanerror.
WH 0.998 1.000 0.000
0.089 0.460 0.509 1.698 WeshouldnotethatRCAisunlikelytomimictheexact
1.000 1.000 0.000 visualmanualQCprocess,anditshouldnot,asitnaturally
CNNsegmentationsasinBaietal.[4].Manualcontourswereavailablethrough provides a different, more comprehensive, assessment of
BiobankApplication2964.ClassesareLVCavity(LVC),LVMyocardium(LVM),RV segmentation quality. The manual QC is a rather crude
Cavity(RVC),anaverageovertheclasses(Av.)andabinarysegmentationofthe
assessment of segmentation quality, as such, we did not
wholeheart(WH).Firstrowforeachclassshowsthebinaryclassificationaccuracy
for‘poor’and‘good’segmentationsintheDiceSimilarityCoefficient(DSC)ranges performadirect,quantitativecomparisonusingthevisual
[0.00.7)and[0.71.0]respectively.Secondrowforeachclassshowsthebinary
QC categories but rather wanted to demonstrate that
classificationaccuracyfor‘poor’and‘good’segmentationsintheMeanSurface
Distance(MSD)ranges[>2.0mm]and[0.0mm2.0mm]respectively.True-positive thereisageneralcorrelationbetweenmanualQCandthe
andfalse-positiveratesarealsoshown.Wereportmeanabsoluteerrors(MAE)on predictedRCAscore.
thepredictionsofDSCandadditionalsurface-distancemetrics:root-mean-squared
surfacedistance(RMS)andHausdorffdistance(HD)
Discussion
Wehaveshownthatitispossibletoassessthequalityof
how RCA would be used in practice. In this case one individual CMR segmentations at large-scale and in the
cannot rely only on DSC to predict the quality of the absence of ground truth. Previous approaches have pri-
segmentation,soMSDcouldprovideamoreappropriate marilyfocusedonevaluatingoverall,averageperformance
qualityprediction. of segmentation methods or required large sets of pre-
annotateddataofgoodandbadqualitysegmentationsfor
(C)Qualitycontrolon7250UKBiobankimages training a classifier. Our method is well suited for use in
Figure 6 shows the relationship between manual QC image-analysispipelinesandclinicalworkflowswherethe
scores and the predicted DSC, MSD, RMS and HD qualityofsegmentationsshouldbeassessedonaper-case
obtained from RCA. Note, these predictions are for the basis.WehavealsoshownthatRCAcanprovidepredic-
LVmyocardiumandnottheoverallsegmentationasthis tionsonaper-classbasis.Notethatourmanuallylabelled
classwasthefocusofthemanualQCprocedure.Manual datasetdidnotincludetheRVmyocardiumasalabeland
QCwasnotperformedfortheotherclasses. thereforehasbeenomittedfromourstudy.
Figure 6 also shows a sample of segmentations with The RCA validation process was carried out on 8-core
manualQCscoresof0,1,5and6fortheLVmyocardium. Intel i7 3.6 GHz machines. The whole process for a sin-
Withascoreof0,‘A’musthavea‘poor’qualitysegmenta- gle test segmentation - including 100 reference image
tionofLVmyocardiumatthebasal,apicalandmidslices. registrations, warping 100 reference segmentations and
Example‘B’showsrelativelylowsurface-distancemetrics metric evaluations - took on average 11 min, making it
and a low DSC, we see this visually as the boundary of suitable for background processing in large-scale stud-
the myocardium is in the expected region, but is incom- ies and clinical practice. However, this is a limitation as
pleteinallslices.Thissegmentationhasbeengivenascore theruntimepercasecurrentlydoesnotallowimmediate
of 1 because the mid-slice is well segmented while the feedback and prohibits applications with real-time con-
restisnot;whichiscorrectlyidentifiedbyRCA.Inexam- straints.Forexample,onecouldenvisionaprocesswhere
ple‘C’,thesegmentationoftheLVmyocardiumisclearly CMRscansareimmediatelysegmentedafteracquisition,
notgoodwithrespecttotheimage,yetithasbeengiven andfeedbackonthequalitywouldberequiredwhilethe
a manual QC score of 5. Again, RCA is able to pick up patient is still in the scanner. For this, the computation
suchoutliersbypredictingalowerDSC.Thefinalexam- timeofRCAwouldneedtobereducedpossiblythrough
ple‘D’displaysanagreementbetweenthehighpredicted an automatic selection of a subset of reference images.

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page11of14
Fig.6RCAApplicationon7250CardiacMRIsegmentationsofUKBBImagingStudy.7,250cardiacMRIsegmentationsgeneratedwithamulti-atlas
segmentationapproach[18].ManualQCscoresgivenintherange[06](i.e.[02]foreachofbasal,midandapicalslices).RCAwithsingle-atlas
classifierwasusedtopredicttheDiceSimilarityCoefficient(DSC),meansurfacedistance(MSD),rootmean-squaredsurfacedistance(RMS)and
Hausdorffdistance(HD).AllcalculationsontheLVMyocardiumbinaryclassificationtask.Weshowcorrelationinallmetrics.Examplesshow:a)and
b)agreementbetweenlowpredictedDSCandlowmanualQCscore,c)successfulautomatedidentificationofpoorsegmentationwithlow
predictedDSCdespitehighmanualQCscoreandd)agreementbetweenhighpredictedDSCandhighmanualQCscore.Insertsintoprowdisplay
extendedrangeofy-axis
We report preliminary results for using a deep learning referencesetsize.Errorbarsindicatethehighestandlow-
approachtospeeduptheprocessin[19].Withareal-time est accuracy achieved across the five runs. Accuracy is
RCA framework, the method could be used to identify computedusingthesameDSCthresholdof0.7asusedin
challenging cases for CNN-based segmentors where the Experiment B. The figure shows that the mean accuracy
RCAfeedbackcouldbeusedtoimprovethesegmentation increases with increasing number of reference images.
algorithm. The error bars in Fig. 7 show a decrease in size with
As noted earlier, using a subset of the reference set increasing size of the reference set. As the reference set
could help to optimize the run-time of RCA predic- growsinsize,agreatervariabilityintheimagesiscaptured
tions.Tobetterunderstandtheeffectofreferencesetsize that allows the RCA process to become more accurate.
on prediction accuracy, we have performed an empirical Noteworthy, even with small reference sets of about 20
evaluation using the data from Experiment B. We took imageshighaccuracyofmorethen90%isobtained.
the4805automatedsegmentationsandtheirmanualGT Although RCA can give a good indication of the real
and performed RCA using randomly selected subsets of DSC score for an individual segmentation, an accurate
the100image-segmentationpairsfromthefullreference one-to-onemappingbetweenthepredictedandrealDSC
set. Five different randomly selected sets of sizes 10, 15, hasnotbeenachieved.However,wehaveshownthatthe
25, 35, 50, 65 and 75 were created and used for obtain- method will confidently differentiate between ‘good’ and
ingRCApredictionsonthe4805images.Figure7shows ‘poor’qualitysegmentationsbasedonanapplicationspe-
the mean accuracy computed across the 5 runs for each cificthreshold.Thethresholdcouldbechosendepending

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page12of14
Fig.7InvestigatingtheEffectofReferenceSetSizeonPredictionAccuracy.4,805automatedsegmentationsfromExperimentBwereprocessed
withReverseClassificationAccuracy(RCA)usingdifferingnumbersofreferenceimages.Randomsubsetsof10,15,35,50,65and75reference
imagesweretakenfromthefullsetof100availablereferenceimages.Fiverandomrunswereperformedtoobtainerrorbarsforeachsetting.
Averagepredictionaccuracyincreaseswithincreasingnumberofreferenceimagesandthevariancebetweenrunsalsodecreases
on the application’s requirements for what qualifies as a Ourcontributionstothefieldarethree-fold:1)athor-
‘good’ segmentation. Failed segmentations could be re- ough validation of RCA for the application of CMR seg-
segmented with different parameters, regenerated with mentation QC. Our results indicate highly accurate pre-
alternative methods, discarded from further analyses or, dictions of segmentation quality across various metrics;
more likely, sent to a user for manual inspection. Addi- 2) a feasibility study of using RCA for automatic QC in
tionally, whilst RCA has been shown to be robust to large-scalestudies.RCApredictionscorrelatewithasetof
cardiovasculartopologyitwouldneedtobere-evaluated manualQCscoresandenableoutlierdetectioninalarge
foruseinotheranatomicalregions. setof7250CMRcases,and3)alarge-scalevalidationon
4800CMRimagesfromtheUKBB.Furthermore,wehave
Conclusion donethiswithouttheneedforalarge,labelleddatasetand
RCA had previously been shown to effectively predict wecanpredictsegmentationqualityonaper-casebasis.
thequalityofwhole-bodymulti-organsegmentations.We
Abbreviations
have successfully validated the RCA framework on 3D 3D:3-dimensional;AF:Atlasforest;CMR:Cardiovascularmagneticresonance;
CMR,demonstratingtherobustnessofthemethodology CNN:Convolutionalneuralnetwork;CoM:Centerofmass;CT:Computed
tomography;DSC:Dicesimilaritycoefficient;ED:End-diastole;FOV:Fieldof
todifferentanatomy.RCAhasbeensuccessfulinidentify-
view;FPR:False-positiverate;GT:Groundtruth;GWAS:Genome-wide
ingpoor-qualityimagesegmentationswithmeasurements associationstudy;HD:Hausdorffdistance;IQA:Imagequalityassessment;LV:
of DSC, MSD, RMS and HD and has shown excellent Leftventricle;LVC:Leftventricularcavity;LVM:Leftventricularmass;MAE:
Meanabsoluteerror;MSD:Meansurfacedistance;QC:Qualitycontrol;RCA:
MAE against all metrics. RCA has also been successful
Reverseclassificationaccuracy;RF:Randomforest;RMS:Root-mean-squared
in producing a comparable outcome to a manual qual- surfacedistance;RMSD:Rootmean-squaredistance;RV:Rightventricle;RVC:
itycontrolprocedureonalargedatabaseof7250images Rightventricularcavity;SAX:Shortaxis;TPR:True-positiverate;UKBB:UK
Biobank;WH:Wholeheart
fromtheUKBB.Wehaveshownfurthersuccessinaccu-
rately predicting quality metrics on 4805 segmentations Acknowledgements
ThisworkwascarriedoutunderUKBBApplications18545and2964.The
fromPetersenetal.,forwhichmanualsegmentationswere
authorswishtothankallUKBBparticipantsandstaff.
availableforevaluation.Predictingsegmentationaccuracy
Funding
in the absence of ground truth is a step towards fully
RRisfundedbyboththeKing’sCollegeLondon&ImperialCollegeLondon
automatedQCinimageanalysispipelines. EPSRCCentreforDoctoralTraininginMedicalImaging(EP/L015226/1)and

Robinsonetal.JournalofCardiovascularMagneticResonance (2019) 21:18 Page13of14
GlaxoSmithKline;VVbyIndonesiaEndowmentforEducation(LPDP) RadcliffeDepartmentofMedicine,UniversityofOxford,OX39DUOxford,UK.
IndonesianPresidentialPhDScholarshipandHSbyResearchFellowshipfrom 7DepartmentofRadiology,SeveranceHospital,YonseiUniversityCollegeof
UeharaMemorialFoundation.Thisworkwasalsosupportedbythefollowing Medicine,Seoul,SouthKorea.8UKDementiaResearchInstitute,Imperial
institutions:KFissupportedbyTheMedicalCollegeofSaintBartholomew’s CollegeLondon,Queen’sDrive,SW72AZLondon,UK.
HospitalTrust,anindependentregisteredcharitythatpromotesandadvances
medicalanddentaleducationandresearchatBartsandTheLondonSchoolof Received:7September2018 Accepted:4February2019
MedicineandDentistry.ALandSEPacknowledgesupportfromtheNIHRBarts
BiomedicalResearchCentreandfromthe“SmartHeart”EPSRCprogramgrant
(EP/P001009/1).SNandSKParesupportedbytheOxfordNIHRBiomedical
References
ResearchCentreandtheOxfordBritishHeartFoundationCentreofResearch
1. SudlowC, GallacherJ, AllenN, BeralV, BurtonP, DaneshJ, DowneyP,
Excellence.ThisprojectwasenabledthroughaccesstotheMRCeMedLab
ElliottP, GreenJ, LandrayM, LiuB, MatthewsP, OngG, PellJ, SilmanA,
MedicalBioinformaticsinfrastructure,supportedbytheMedicalResearch
YoungA, SprosenT, PeakmanT, CollinsR.UKBiobank:AnOpenAccess
Council(grantnumberMR/L016311/1).NAissupportedbyaWellcomeTrust
ResourceforIdentifyingtheCausesofaWideRangeofComplexDiseases
ResearchTrainingFellowship(203553/Z/Z).TheauthorsSEP,SNandSKP
ofMiddleandOldAge.PLoSMed.2015;12(3):1–10.https://doi.org/10.
acknowledgetheBritishHeartFoundation(BHF)forfundingthemanual
1371/journal.pmed.1001779.
analysistocreateacardiovascularmagneticresonanceimagingreference
2. ShariffA, KangasJ, CoelhoLP, QuinnS, MurphyRF.AutomatedImage
standardfortheUKBBimagingresourcein5000CMRscans(PG/14/89/31194).
AnalysisforHigh-ContentScreeningandAnalysis.JBiomolScreen.
PMMgratefullyacknowledgessupportfromtheEdmondJ.SafraFoundation
2010;15(7):726–34.https://doi.org/10.1177/1087057110370894.
andLilySafra,theImperialCollegeHealthcareTrustBiomedicalResearch
3. deBruijneM.Machinelearningapproachesinmedicalimageanalysis:
Centre,theEPSRCCentreforMathematicsinPrecisionHealthcare,theUK
Fromdetectiontodiagnosis.MedImageAnal.2016;33:94–97.https://doi.
DementiaResearchInstituteandtheMRC.BGreceivedfundingfromthe
org/10.1016/j.media.2016.06.032.
EuropeanResearchCouncil(ERC)undertheEuropeanUnion’sHorizon2020
researchandinnovationprogramme(grantagreementNo757173,project 4. BaiW, SinclairM, TarroniG, OktayO, RajchlM, VaillantG, LeeAM,
MIRA,ERC-2017-STG). AungN, LukaschukE, SanghviMM, ZemrakF, FungK, PaivaJM,
CarapellaV, KimYJ, SuzukiH, KainzB, MatthewsPM, PetersenSE,
Availabilityofdataandmaterials PiechnikSK, NeubauerS, GlockerB, RueckertD.Human-levelcmrimage
TheimagingdataandmanualannotationswereprovidedbytheUKBB analysiswithdeepfullyconvolutionalnetworks.1710.09289v3.
ResourceunderApplicationNumber2946.Part(B)wasconductedwithdata 5. CrumWR, CamaraO, HillDLG.Generalizedoverlapmeasuresfor
obtainedthroughApplicationNumber18545.Researcherscanapplytouse evaluationandvalidationinmedicalimageanalysis.IEEETransMed
theUKBBdataresourceforhealth-relatedresearchinthepublicinterest. Imaging.2006;25(11):1451–61.https://doi.org/10.1109/TMI.2006.880587.
PythoncodeforperformingRCAasimplementedinthisworkisinthepublic 6. TahaAA, HanburyA.Metricsforevaluating3Dmedicalimage
repository:https://github.com/mlnotebook/RCA.Examplesetsofreference segmentation:analysis,selection,andtool.BMCMedImaging.2015;15:
andtest-imagesareprovidedaslinksintherepository. 29.https://doi.org/10.1186/s12880-015-0068-x.
7. CarapellaV, Jiménez-RuizE, LukaschukE, AungN, FungK, PaivaJ,
Authors’contributions SanghviM, NeubauerS, PetersenS, HorrocksI, PiechnikS.Towardsthe
RRandBGconceivedanddesignedthestudy;RRperformedimplementations, SemanticEnrichmentofFree-TextAnnotationofImageQuality
dataanalysisandwritethemanuscript.VVdevelopedtheoriginalRCA AssessmentforUKBiobankCardiacCineMRIScans.In:MICCAIWorkshop
framework.WBprovidedtheautomatedsegmentationsthatweregivenQC onLarge-scaleAnnotationofBiomedicalDataandExpertLabelSynthesis
scoresbyHS.OOprovidedlandmarksusedintheoriginalversionofthiswork. (LABELS).Cham:Springer;2016. p.238–48.https://doi.org/10.1007/978-
SN,SKPandSEPareoverallconsortiumleadsforUKBBaccessapplication2964 3-319-46976-8_25.
andresponsiblefortheconceptualisationofcreatingaCMRsegmentation 8. ZhangL, GooyaA, DongB, HuaR, PetersenSE, Medrano-GraciaP,
referencestandard.Datacurationforapplication2964bySEP,NA,AMLandVC FrangiAF.AutomatedQualityAssessmentofCardiacMRImagesUsing
andmanualcontoursof5,000CMRproducedbyMMS,NA,JMP,FZ,KF,EL,VC ConvolutionalNeuralNetworks.In: TsaftarisSA, GooyaA, FrangiAF,
andYJK.PMandDRprovidedadviceinthestageofmodeldevelopmentand PrinceJL,editors.MedicalImageComputingandComputer-Assisted
clinicalapplications.Allauthorsreadandapprovedthefinalmanuscript. Intervention–SASHIMI2016.LectureNotesinComputerScience,vol.
9968.Cham:Springer;2016. p.138–45.https://doi.org/10.1007/978-3-
Ethicsapprovalandconsenttoparticipate 319-46630-9_14.
TheUKBBhasapprovalfromtheNorthWestResearchEthicsCommittee(REC 9. ZhongE, FanW, YangQ, VerscheureO, RenJ.CrossValidation
reference:11/NW/0382).Allparticipantshavegivenwritteninformedconsent. FrameworktoChooseamongstModelsandDatasetsforTransfer
Learning.In:LectureNotesinComputerScience(includingSubseries
Consentforpublication LectureNotesinArtificialIntelligenceandLectureNotesin
Notapplicable. Bioinformatics)vol.6323LNAI.Springer;2010. p.547–62.https://doi.org/
10.1007/978-3-642-15939-8_35.http://link.springer.com/10.1007/978-3-
Competinginterests 642-15939-8_35.
SteffenE.PetersenprovidesconsultancytoCircleCardiovascularImagingInc. 10. FanW, DavidsonI.Reversetesting.In:Proceedingsofthe12thACM
(Calgary,Alberta,Canada).BenGlockerreceivesresearchfundingfrom SIGKDDInternationalConferenceonKnowledgeDiscoveryandData
HeartFlowInc.(RedwoodCity,CA,USA). Mining-KDD’06.NewYork:ACMPress;2006. p.147.https://doi.org/10.
1145/1150402.1150422.
Publisher’sNote 11. ValindriaVV, LavdasI, BaiW, KamnitsasK, AboagyeEO, RockallAG,
SpringerNatureremainsneutralwithregardtojurisdictionalclaimsin RueckertD, GlockerB.ReverseClassificationAccuracy:Predicting
publishedmapsandinstitutionalaffiliations. SegmentationPerformanceintheAbsenceofGroundTruth.TransMed
ImagingIEEE.20171.https://doi.org/10.1109/TMI.2017.2665165.
Authordetails 12. ZikicD, GlockerB, CriminisiA.Encodingatlasesbyrandomized
1BiomedicalImageAnalysisGroup,DepartmentofComputing,Imperial classificationforestsforefficientmulti-atlaslabelpropagation.MedImage
CollegeLondon,Queen’sGate,SW72AZLondon,UK.2DivisionofBrain Anal.2014;18(8):1262–73.https://doi.org/10.1016/j.media.2014.06.010.
Sciences,Dept.ofMedicine,ImperialCollegeLondon,Queen’sGate,SW72AZ 13. RobinsonR, ValindriaVV, BaiW, SuzukiH, MatthewsPM, PageC,
London,UK.3GlaxoSmithKlineResearchandDevelopment,StockleyPark, RueckertD, GlockerB.Automaticqualitycontrolofcardiacmri
UB111BTUxbridge,UK.4WilliamHarveyResearchInstitute,NIHRBarts segmentationinlarge-scalepopulationimaging.In: DescoteauxM,
BiomedicalResearchCentre,QueenMaryUniversityofLondon,Charterhouse Maier-HeinL, FranzA, JanninP, CollinsDL, DuchesneS,editors.Medical
Square,EC1M6BQLondon,UK.5BartsHeartCentre,BartsHealthNHSTrust, ImageComputingandComputerAssistedIntervention-MICCAI2017.
WestSmithfield,EC1A7BELondon,UK.6DivisionofCardiovascularMedicine, Cham:Springer;2017. p.720–7.

Robinsonetal.JournalofCardiovascularMagneticResonance           (2019) 21:18  Page14of14
14. OktayO,BaiW,GuerreroR,RajchlM,deMarvaoA,OR´eganDP,CookSA,
| HeinrichMP, | GlockerB, | RueckertD.Stratifieddecisionforestsforaccurate |     |     |     |
| ----------- | --------- | ---------------------------------------------- | --- | --- | --- |
anatomicallandmarklocalizationincardiacimages.IEEETransMed
Imaging.2017;36(1):332–42.https://doi.org/10.1109/tmi.2016.2597270.
| 15. PetersenSE, | MatthewsPM,                                          | FrancisJM, |         | RobsonMD, ZemrakF, |           |
| --------------- | ---------------------------------------------------- | ---------- | ------- | ------------------ | --------- |
| BoubertakhR,    | YoungAA,                                             | HudsonS,   | WealeP, | GarrattS,          | CollinsR, |
| PiechnikS,      | NeubauerS.Ukbiobank’scardiovascularmagneticresonance |            |         |                    |           |
protocol.JCardiovascMagnReson.2016;18(1):8.https://doi.org/10.1186/
s12968-016-0227-4.
| 16. PetersenSE,AungN,SanghviMM,ZemrakF, |                                                 |        |             | FungK, PaivaJM, | FrancisJM, |
| --------------------------------------- | ----------------------------------------------- | ------ | ----------- | --------------- | ---------- |
| KhanjiMY,                               | LukaschukE,                                     | LeeAM, | CarapellaV, | KimYJ,          | LeesonP,   |
| PiechnikSK,                             | NeubauerS.Referencerangesforcardiacstructureand |        |             |                 |            |
functionusingcardiovascularmagneticresonance(CMR)incaucasians
fromtheUKbiobankpopulationcohort.JCardiovascMagnReson.
2017;19(1):.https://doi.org/10.1186/s12968-017-0327-9.
| 17. PetersenSE,SanghviMM,AungN,CooperJA,PaivaJM, |        |             |        |             | ZemrakF, FungK, |
| ------------------------------------------------ | ------ | ----------- | ------ | ----------- | --------------- |
| LukaschukE,                                      | LeeAM, | CarapellaV, | KimYJ, | PiechnikSK, | NeubauerS.The   |
impactofcardiovascularriskfactorsoncardiacstructureandfunction:
Insightsfromtheukbiobankimagingenhancementstudy.PLoSONE.
2017;12(10):1–14.https://doi.org/10.1371/journal.pone.0185114.
| 18. BaiW, | ShiW, O‘ReganDP, | TongT, | WangH, | Jamil-CopleyS, | PetersNS, |
| --------- | ---------------- | ------ | ------ | -------------- | --------- |
RueckertD.AProbabilisticPatch-BasedLabelFusionModelfor
Multi-AtlasSegmentationWithRegistrationRefinement:Applicationto
CardiacMRImages.IEEETransMedImaging.2013;32(7):1302–15.https://
doi.org/10.1109/TMI.2013.2256922.
| 19. RobinsonR, | OktayO,    | BaiW, ValindriaV, |        | SanghviM, AungN,   | PaivaJ,   |
| -------------- | ---------- | ----------------- | ------ | ------------------ | --------- |
| ZemrakF,       | FungK,     | LukaschukE,       | LeeA,  | CarapellaV, KimYJ, | KainzB,   |
| PiechnikS,     | NeubauerS, | PetersenS,        | PageC, | RueckertD,         | GlockerB. |
Real-timePredictionofSegmentationQuality.2018.ArXive-prints.
1806.06244.
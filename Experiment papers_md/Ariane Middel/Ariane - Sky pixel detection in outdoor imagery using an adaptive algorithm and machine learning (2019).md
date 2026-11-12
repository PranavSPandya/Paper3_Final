Sky pixel detection in outdoor imagery using an adaptive algorithm and machine
learning
KerryA.Nicea,d,e,∗,JasperS.Wijnandsa,ArianeMiddelf,JingchengWangb,YimingQiub,NanZhaob,Jason
Thompsona,GideonD.P.A.Aschwandena,HaifengZhaoa,MarkStevensona,c
aTransport,Health,andUrbanDesignHub,FacultyofArchitecture,Building,andPlanning,UniversityofMelbourne,Australia.
bSchoolofComputingandInformationSystems,UniversityofMelbourne,Australia.
cMelbourneSchoolofEngineering;andMelbourneSchoolofPopulationandGlobalHealth,UniversityofMelbourne,Australia.
dSchoolofEarth,AtmosphereandEnvironment,MonashUniversity,Australia.
eCooperativeResearchCentreforWaterSensitiveCities,Melbourne,Australia.
fSchoolofArts,MediaandEngineering(AME),SchoolofComputing,Informatics,andDecisionSystemsEngineering(CIDSE),ArizonaState
University.
Abstract
Computervisiontechniquesenableautomateddetectionofskypixelsinoutdoorimagery. Inurbanclimate, sky
detectionisanimportantfirststepingatheringinformationabouturbanmorphologyandskyviewfactors. However,
obtaining accurate results remains challenging and becomes even more complex using imagery captured under a
varietyoflightingandweatherconditions.
To address this problem, we present a new sky pixel detection system demonstrated to produce accurate results
using a wide range of outdoor imagery types. Images are processed using a selection of mean-shift segmentation,
K-means clustering, and Sobel filters to mark sky pixels in the scene. The algorithm for a specific image is chosen
by a convolutional neural network, trained with 25,000 images from the Skyfinder data set, reaching 82% accuracy
forthetopthreeclasses. Thisselectionstepallowstheskymarkingtofollowanadaptiveprocessandtousedifferent
techniquesandparameterstobestsuitaparticularimage.Anevaluationoffourteendifferenttechniquesandparameter
setsshowsthatnosingletechniquecanperformwithhighaccuracyacrossvariedSkyfinderandGoogleStreetView
datasets. However,byusingouradaptiveprocess,largeincreasesinaccuracyareobserved. Theresultingsystemis
showntoperformbetterthanotherpublishedtechniques.
Keywords: skyviewfactor,GoogleStreetView,machinelearning,WUDAPT,skypixeldetection,Skyfinder
1. Introduction
Skypixeldetectioninimagesisanongoingcomputervisionchallengewithalargerangeofapplicationssuchas
autonomousvehicleordronenavigation(ShenandWang,2013), real-timeweatherclassification(RoserandMoos-
mann, 2008), image editing (Laffont et al., 2014; Tao et al., 2009), sky replacement (Tsai et al., 2016), and scene
parsing(TigheandLazebnik,2010;Hoiemetal.,2005). Itisalsoanimportanttoolinurbanclimateresearch. The
use of fisheye photography to calculate sky view factors (SVF), the fraction of sky visible to a point, at individual
locationshaslongbeenusedinurbanclimate. Numeroustechniquesexisttoprocessthissortofimagery(Grimmond
etal.,2001;ChapmanandThornes,2004;Ali-ToudertandMayer,2007).
In computer vision research, sky detection techniques have largely followed two main paths, either finding the
pixels associated with the sky on a pixel by pixel basis or by finding a sky/ground boundary and labelling the sky
as everything above that boundary. The first approach focuses on finding individual pixels associated with the sky.
Luo and Etz (2002) employed a physics-based approach using the changes of sky colours from zenith to horizon.
∗Principalcorrespondingauthor
Emailaddress:kerry.nice@unimelb.edu.au(KerryA.Nice)
PreprintsubmittedtoUrbanClimate December11,2019
9102
ceD
9
]VC.sc[
2v28130.0191:viXra

Gallagheretal.(2004)generatedskypixelprobabilitymapsbasedoncolourvaluesandatwo-dimensionalpolyno-
mialforeachcolourchannel. ZafarifaranddeWith(2007)addedtexture, gradients, andverticalpositiontocolour
valuestogeneratetheirprobabilitymap,however,onlyblueskyisdetectedaccuratelywithcloudsmarkedwithlow
probabilities. SchmittandPriese(2009)addedinananalysisofpositionandshapeandwerereportedlyabletoalso
accuratelyperformskydetectionundercloudyconditions.
Otherapproacheshavefocusedonfindingasky/groundboundary.Straightlineswerefirstusedtodefineahorizon
locatedviaanenergyfunction(Ettingeretal.,2003). Usinganimprovedenergyfunctionoptimisationandgradient
informationfromtheimage,ShenandWang(2013)allowedthehorizonlinetofollowtheboundaryinsteadofbeing
restricted to a straight line. Additional variations allowed increasingly difficult sky regions (i.e. regions separated
fromthemainskyregionbybuildings,flags,orotherobstructions)tobedetected(Zhijieetal.,2014,2015). Another
approach, notspecificallydesignedforskypixelidentification, attemptstoclassifyaroundadozenclasses(suchas
sky,buildings,trees,andcars)inoutdoorimagerythroughsemanticsegmentationusingtrainedconvolutionalneural
networks (CNN), such as SegNet (Badrinarayanan et al., 2017), and other variations (Holder et al., 2016; Middel
etal.,2019).
Comparingexistingapproachesisdifficult,asmoststudiesdonotreportaccuracymetrics,andwhentheydo,they
arereportedusingdifferentmetricsandbenchmarkdatasets. LuoandEtz(2002)reports90.4%correctdetectionof
blueskypixelsand13%misclassifications. ChapmanandThornes(2004)reportsaroot-mean-squarederror(RMSE)
of 0.06 in marking SVF in fisheye images. Schmitt and Priese (2009) reports an accuracy of 0.90 for 80% of their
validation images and an accuracy of 0.95 for 75% of the images. Liang et al. (2017), using SegNet, reports an
accuracyof0.96forskypixelidentification. Shenetal.(2018),usinganoff-the-shelfversionofSegNet,reportsan
accuracyof0.83withlateralviews. Finally,Middeletal.(2019)reportsanaccuracyof0.95withlateralviews.
Aneffortisongoingtoprovideworldwidedatabasesofstandardisedurbanmorphologyinformation(Chingetal.,
2018, 2019). Now with the widespread availability of urban imagery, an opportunity exists to expand the range of
researchthatcanbeconductedwithouttherequirementofmanuallycollectingurbanmorphologyparametersandto
accelerate the population of databases such as the World Urban Database and Portal Tool (WUDAPT) (Mills et al.,
2015).
StudieshavestartedtoutiliseautomatedmethodstobuildSVFdatasetsfromGoogleStreetView(GSV)imagery
(Middeletal.,2018;Gongetal.,2018). Theresultsarepromisingbutshowsomeaccuracyproblems. Urbanareas
with large numbers of street trees in particular are cited by Gong et al. (2018) as a key source of inaccuracies in
theirsystem. Inaddition,thesesystemsarehighlydependentonGSVimagery,whichasof2018hasbecomemore
restrictivetolicenseandexpensivetoobtain. Thisnecessitatestheneedtoexpandthetypeofimageryused,imagery
thatunlikeGSV,mightvarymoreinlighting,weatherconditions,cameraangles,andaspectratios.
With these factors in mind, we present a sky pixel detection system that has been tested using various types of
outdoorimagerycollectedunderawiderangeoflightingandweatherconditions, cameraangles, andaspectratios.
Thissystem,builtonartificialintelligence,isadaptiveandusesarangeofalgorithmsandcombinationsofparameters
tolocatetheskypixelstoensurethehighestaccuracyforeachindividualclassofimages. Weevaluateanumberof
existingandnewtechniquesforskypixelclassificationanddemonstratethatthisnewadaptivesystemperformswith
greateraccuracythananyoftheseindividualtechniquesontheirown.
2. Methods
Ourskypixelidentificationsystemuseddatafromtwomainsources,theSkyfinderdataset(Mihailetal.,2016)
andGSV(GoogleMaps,2017). Threecomputervisiontechniquesandanumberofparametervariationswereused
toprocessthedata(seeTable1). Twoweredeveloped/customisedaspartofthisresearch. Oneexistingmethodwas
implemented and also used as a benchmark. The overall process flow is shown in Figure 1. Finally, a previously
publishedfourthtechnique(i.e. Sobel/flood-fill)wasalsousedasabenchmarktestforoursystem.
2.1. Data
2.1.1. GSVdata
Panoramas for 406 locations in a variety of cities (Adelaide, Brisbane, Paris, Sydney, Tokyo, Perth, and Mel-
bourne) were retrieved using the Google Maps API. Images were retrieved as six 640×640 tiles (one each for up,
2

Figure1:Processflowoftrainingandvalidationsteps.
Table1:Techniquesandvariationsofeachalgorithmusedinthisstudyforskypixeldetection.
Sobel ImplementationofWangetal.(2015)’sSobeloperator/hybridprobabilitymodel
| Variations |     |     |     | Probabilitythreshold |     |     |     |
| ---------- | --- | --- | --- | -------------------- | --- | --- | --- |
| Sobel 50   |     |     |     | 0.5                  |     |     |     |
| Sobel 60   |     |     |     | 0.6                  |     |     |     |
| Sobel 70   |     |     |     | 0.7                  |     |     |     |
| Sobel 80   |     |     |     | 0.8                  |     |     |     |
| Sobel 90   |     |     |     | 0.9                  |     |     |     |
| Sobel 95   |     |     |     | 0.95                 |     |     |     |
Meanshift Algorithmdevelopedbytheauthorsbasedonmeanshiftsegmentation
Variations Spatialradius(pixels) Rangeradius(pixels) Min. density(pixels)
| Mean 7 8 | 300 | 7   |     | 8   |     | 300 |     |
| -------- | --- | --- | --- | --- | --- | --- | --- |
| Mean 3 6 | 100 | 3   |     | 6   |     | 100 |     |
| Mean 5 7 | 210 | 5   |     | 7   |     | 210 |     |
| Mean 7 6 | 100 | 7   |     | 6   |     | 100 |     |
K-means AlgorithmdevelopedbytheauthorsbasedonK-meansclusteringandHSLcolourfiltering
| Variations | Clusters | Skyreq | H    | H   | L         | L    | S    |
| ---------- | -------- | ------ | ---- | --- | --------- | ---- | ---- |
|            |          |        | high | low | lightness | grey | grey |
| K-mean 12  | 12       | 0.7    | 0.75 | 0.3 | 0.95      | 0.75 | 0.2  |
| K-mean 6   | 6        | 0.6    | 0.75 | 0.3 | 0.95      | 0.75 | 0.2  |
| K-mean 14  | 14       | 0.4    | 0.75 | 0.3 | 0.95      | 0.65 | 0.2  |
Sobel/flood-fill Middeletal.(2018)’sSobeloperator/flood-fillalgorithmusedasbenchmark
3

Figure2: a)OriginalGSVpanoramaimageandb)hand-markedvalidationimage(skymarkedwithblue, RGB0,0,255). c)Original
Skyfinderimageandd)Skyfindervalidationmask(skymarkedwithwhite,RGB255,255,255).
down,left,right,front,andbackdirections). Thesiximageswerestitchedtogetherintoa1280×960cubicimageus-
ingJava8(Oracle,2018)andOpenCV(Bradski,2000). Validationimageswerecreatedbyhandmarkingskyregions
(withblue,RGB0,0,255)ineachimageusingtheGNUImageManipulationProgram(GIMP,2019). Figure2shows
anexampleofaGSVpanoramaimageandthecorrespondinghand-markedvalidationimage. Thisdatasetwasonly
usedaspartofthevalidationdataset.
2.1.2. Skyfinderdata
This data set was built from 90,000 long-term timelapse images from 53 outdoor webcams over a variety of
lightingandweatherconditions. Imagesareofawiderangeofsizesandaspectratios,including640×489,857×665,
960×600, 1280×720, and 1280×960. For each location, a binary sky mask was created by Mihail et al. (2016) for
validation purposes. An example image and mask (with sky marked with white, RGB 255,255,255) are shown in
Figure2. AlloftheseimagesareavailablefromtheSkyfinderwebsite(Mihail,2015).
Inthisstudy,weselected38,115imagesfrom40locations. Night-timeandimageswithheavyfogwereremoved
astheseareconditionsunlikelytobeencounteredinimageryusedtocalculateSVF.Thedatasetwassplitintotwo
datasets,28,586forneuralnetworktrainingand9,529forvalidation.
2.2. Techniquesandparameters
2.2.1. Wangetal.(2015)Sobeloperator/hybridprobabilitymodel
AnimplementationoftheskydetectionalgorithmpresentedinWangetal.(2015)wasimplementedusingOpenCV
andJava8.Thismethodproceedsbycalculatinggrey-scalegradientimagesusingx-andy-directionalSobeloperators
toestimateskycolour. Anoptimisedobjectivefunctionattemptstofindthebestsky/groundboundaryinthegradient
image using the covariance matrices of a first calculation of sky and ground regions. Using this best sky boundary,
probabilitymodelsarecreatedfromi)thecentreandstandarddeviationsofthecolours,ii)thegradientvalues,andiii)
theverticalpositionofeachpixel(verticallyhigherpixelsaremorelikelytobesky). Anoverallprobabilitymodel,
rankingeachpixel’sprobability(0to1)tobesky,isgeneratedfromthesethreeprobabilitymodels.Wangetal.(2015)
reportsanerroraverageof0.051andstandarddeviationof0.058intheirevaluationusinghuman-labelledimages.
Wang et al. (2015) did not recommend a probability threshold, so a number of thresholds were tested (0.5, 0.6,
0.7,0.8,0.9,and0.95)andgiventhedesignationsofSobel 50,Sobel 60,Sobel 70,Sobel 80,Sobel 90,andSobel 95
4

Figure3: ResultsofSobeloperator/hybridprobabilitymodel,showinga)Sobeloperatorgradientimage,b)resultingprobabilitypredic-
tions,c)Sobel50,d)Sobel60,e)Sobel70,f)Sobel80,g)Sobel90,andh)Sobel95foraGSVimage. Subfiguresi)top)sameasa)toh)
butwithSkyfinderimage.
respectively(Table1). Thealgorithmwasappliedtoeachimageandpixelsthatexceededthechosenthresholdwere
markedasskypixels(usingblue,RGB0,0,255). ResultsfromourimplementationareshowninFigure3. Note,two
ofthebestperformingvariationsarealsousedforabenchmarkcomparisoninSection3.3.1.
2.2.2. Meanshiftsegmentationalgorithm
Mean shift is an algorithm often used for image segmentation (Comaniciu and Meer, 1997, 2002). Image seg-
mentation involves decomposing images into homogeneous contiguous regions of pixels of similar colours or grey
levels. Meanshiftiterativelypickssearchwindows(spatialandrange)ofacertainradiusinaninitiallocationinan
image,computesameanshiftvector,andtranslatesthesearchwindowbythatamountuntilconvergence(Comaniciu
and Meer, 1997). Segmentation results are highly dependent on input parameters for the algorithm, which include
the spatial and colour range radius of the search window and minimum density (the minimum number of pixels to
constitutearegion). ThemeanshiftusedinthisprojectisbasedonaJavaportbyPangburn(2002)oftheC++based
EDISONvisiontoolkit(Christoudiasetal.,2002).
Fourdifferentvariationsoftheinputparameterswereused, determinedexperimentallythroughasensitivitytest
to work across the widest variety of images. A comparison of a GSV and a Skyfinder location with different mean
shiftvariationsandmarkedresultsisshowninFigure4. Thetechniquedesignationsandparametersaredetailedin
Table1. Meanshiftisappliedtoeachimagewiththechosensetofparametersandpixelsofthemostcommoncolour
(inthetophalfofthesegmentedimage)aremarkedassky.
To illustrate the effects of different mean shift variations can have in a variety of images, under varying sky
conditions, results from two additional locations are shown in Figure 5. To shift the entire sky to a single colour,
imageswithpatchymulti-colouredcloudsaremoreaccuratelysegmentedwhentheradiusanddensityparametersare
increased(e.g. incolumnbcomparedtocolumnainFigure5). However,atotherlocations,thiscanhavetheeffectof
creatingfalsepositives,forexample,wherethebuildinginthecentreleftbackgroundisincreasinglysegmentedinto
theskyincolumndinFigure5comparedtocolumnc.
5

Figure4: Comparisonoutputsofintermediatemeanshiftsegmentationalgorithmprocessingstepsusingvaryingparameters, showing
columnsa)Mean36100,b)Mean76100,c)Mean57210,d)Mean78300andintermediatemeanshifted(GSVrow1,Skyfinderrow
3)andthefinalmarkedimages(GSVrow2,Skyfinderrow4).
Figure5: Examplesoffalsenegativesandfalsepositiveswithdifferentmeanshiftvariationsattwoadditionallocationsofmeanshift
segmentationparameters.Intermediatemeanshifted(row1)andthefinalmarkedimages(row2)ofMean76100(columnsaandc)and
Mean57210(columnsbandd).
6

Figure6:ResultsofK-meansclusteringandHSLcolorfiltering(K-mean6),showingGSV(toprow)andSkyfinder(bottom)andK-means
clusteredimage(left),HSLintermediateimage(middle),andfinalmarkedimage(right).
2.2.3. K-meansclusteringandHSLcolorfiltering
A third sky segmentation technique was designed using K-means clustering and hue, saturation, and lightness
(HSL)colourfiltering. K-meansclusteringiterativelysplitsanimageintoK numberofclusters,terminatingwhena
specifiedcriteriaismet(i.e. maximumiterationsand/ordesiredaccuracy). TheK-meansclusteringwasperformed
usingtheK-meansmethodfromtheOpenCVlibrary. Threedifferentinputparametersettingswereused,determined
experimentallythroughasensitivitytesttoworkonawidevarietyofimages. Thetechniquedesignationsandparam-
etersaredetailedinTable1. K-mean 6wasmoreaccuratewithcloudyskies. K-mean 14handlesskyscenesbroken
upbytreecanopies. Thelastvariation,K-mean 12,generallyperformedwithlowaccuracyformostimagesbutina
smallnumberofcases(whentheskyismostlyobscuredbyasolidobject,buildingorbridgebutnottrees)performed
betterthanalltheothertechniquesandvariations.
AfterK-meansclustering,clusterregionswereprocessedbasedonHSLvalues. Thefollowingconditions(forH,
hue,S,saturation,andL,lightness)mustbemettoaddacolourregiontoalistofpossibleskyregions:
H < H < H
low high
∪L> L
lightness
∪L> L ∩S <S
grey grey
Ofthesepossibleskyclusters,onlyclusterswithanumberofpixelsgreaterthantheSkyreqthreshold(percentof
allpixels)intheimagewerefinallymarkedasskyregions. ExampleresultsareshowninFigure6.
2.2.4. Middeletal.(2018)Sobeloperator/flood-fillalgorithm
Forbenchmarkcomparisons, weusedanalgorithmdevelopedbyMiddeletal.(2018). Theprocessisbasedon
a Sobel filter (Sobel and Feldman, 1968) and flood-fill algorithm (Laungrungthip et al., 2008; Middel et al., 2017).
ThemethodwasdesignedtocalculateSVFfromGSVimagecubesthatwereprojectedintoupwardsfacingfisheye
views. Note, thisalgorithmalsorescalestheimageryto512×512. All38,521imagesinthecombinedtrainingand
validationdatasetwereprocessedwiththisalgorithm(skypixelsmarkedwithwhite,RGB255,255,255),compared
to validation images, and results saved for a comparison with our results. The results were kept separate from the
other 13 techniques and were not included in the NN training process (see Section 2.3.2). Also, in our benchmark
comparison,weusedthissystemtoprocessavariedoutdoorimagerydataset,notthefisheyeimagery(croppedbelow
thehorizon)thealgorithmwasoriginallydesignedtoprocess. ExamplesareshowninFigure7.
2.3. Neuralnetwork
2.3.1. Inceptionv3
TheMicrosoftCognitiveToolkit(CNTK)(Yuetal.,2015;Agarwaletal.,2016), withtheInceptionv3network
(Szegedyetal.,2016),wasusedinthisprojecttorouteimagesthroughouradaptivealgorithm. Thisneuralnetwork
(NN) is a widely used model for image classification across a large variety of fields (Xia et al., 2017; Hassannejad
et al., 2016). The original Inception model (Szegedy et al., 2015) is a deep convolutional neural network (CNN)
7

Figure7:ResultsofSobel/flood-fillcombination,showinga)originalGSVimage(rescaledto512x512),b)intermediateSobelimage,andc)
finalmarkedskyimage.Subfiguresd)tof)sameasa)toc)butusingSkyfinderimagery.
Figure8:Inceptionv3architecture(Google,2019).
built using convolutions, average pooling, max pooling, concats, dropouts, and fully connected layers. A reduction
of parameters and increased performance over other competing architectures was achieved by the use of Inception
modules, combining convolution operations with varying filter sizes. Inception v3 deepens the network (i.e., 42
layers, see Figure 8) without a large increase in computational requirements by factorising convolution operations
withlargefiltersizesintosmallerstackedlayers.
2.3.2. Neuralnetworktraining
The Skyfinder data set of 38,115 images was split into two data sets for training (75%) and validation (25%).
All training and validation images (which consisted of images of a wide variety of sizes and aspect ratios) were
preprocessedandrescaledusingImageJ(Ruedenetal.,2017)toInceptionv3’snativeinputsize, 299×299, priorto
trainingandvalidation.
Thenetworkwascalibratedusingsupervisedlearning,trainedwithalistofimagesassignedtocategories,inour
case,whichoneofthe13skydetectiontechniquevariationsperformedmostaccuratelyforeachimage. Thetraining
processwasrununtilthemodelreachedpeakaccuracy(convergence)atrecognisingtheseclassificationsfromimages.
Note,noneoftheGSVimagerywasusedintheNNtrainingprocess.
8

2.3.3. Neuralnetworkinference
Using the trained model, inferences were performed using the images from the validation data set (the 25% of
imagesfromSection2.3.2)aswellasthe406GSVpanoramas. ThetechniquesandparameterspickedbytheNNas
themostappropriateforthatimagewereusedtomarktheskypixels. Themarkedskypixelswerethencomparedto
thegroundtruthtoassessaccuracy.
3. Results
Three sets of results are reported in this section. The first is a comparison of all the techniques and parameters
runindividuallyagainsttheSkyfinderandGSVdatasets(atotalof38,521images). Thesecondpresentstheresults
of9,636validationimagesusingouradaptiveprocessflowwiththetechniquesandparameterschosenbythetrained
NN. The third presents a comparison to two benchmark models: a) the Wang et al. (2015) Sobel operator/hybrid
probability model (from which we chose the two best performing variations) and b) the Middel et al. (2018) Sobel
operator/flood-fillalgorithm.
3.1. Resultsfromalltechniques
All the technique and parameter variations were used to process the two data sets of the 38,115 Skyfinder and
406GSVimages. Figures9aand9bshowsacomparisonofRMSEstatisticsforthetwodatasets. Plotsofanumber
ofthebetterperformingtechniquesarepresentedinFigure10. Note,thestronghorizontallinesinthesefiguresare
duetothenatureoftheSkyfinderdatasetthatcontainslargegroupsofthesamescenes(withthesamepercentageof
sky)underdifferentlightingandweatherconditions,oftenresultinginawiderangeofpredictedresults. Acomplete
summary of Willmott (1981)’s index of agreement, d, R2, and RMSE statistics for evaluations against the two data
setsarepresentedinSupplementaryTable2. F1statisticsforeachtechniqueagainstthe9,636validationimagesare
presentedinFigures9cand9d.Acompletesummaryofprecision,recallandF1statisticsareshowninSupplementary
Table3.
3.2. Resultsfromneuralnetworkclassifiedtechniques
Figure11apresentsatheoreticalbestcase. IftheNNwas100%accurateinpickingthebesttechniquefromthe
13possiblecombinationsbasedonitstraining,aRMSEof0.026and0.020(andd indexofagreementof0.994and
0.988)ispossibleagainstthevalidationdatasetof9,529Skyfinderimagesand406GSVimagesrespectively.Samples
oftheimageryusedintrainingforselectedclassificationsareshowninFigure12. Ascanbeseeninthisfigure,there
arenostrongvisualthemesineachoftheclassifications(i.e. allverycloudy,clearbluesky,ormulti-colouredsky),
howevertheNNisabletopickuponmoresubtlefeaturesnotreadilyvisibletotheeye.
TheNNwastrainedfor250epochsonanNvidiaGeForceGTX1080GPU,requiringabout12hours. TheNN
reached a peak accuracy rate of 52.6% in choosing the optimal algorithm from the 13 options. However, as some
techniques didonly slightly betterthan others, theerror introduced bypicking the secondor third bestalgorithm is
generallylimited. Breakingdowntheaccuracywiththisinmind,theNNpickedthebestmethod52.6%ofthetime,
thesecondbest18.9%,andthethirdbest10.5%(foratotalofthethreeof82.0%)
Figure11bshowstheoverallaccuracyoftheNNchosenpathwayprocessflowagainstthe9,636validationimages,
fortheSkyfinderandGSVimages(respectively)fromthevalidationdatasetwithaRMSEof0.063and0.072,R2of
0.882and0.485,anddof0.967and0.840. TheaccuracyoftheNNhasimpactedtheoverallaccuracyofthesystem
(i.e. notreachingthetheoreticalaccuracyof0.026or0.020RMSE),buttheresultsonout-of-sampleimagesarestill
very good. In addition, precision, recall, and F1-scores for the Skyfinder and GSV validation data sets show good
results(seeSupplementaryTable3). Precisionis0.946and0.933,recallis0.965and0.918,whiletheF1-scoresare
0.952and0.918(allrespectively).
3.3. Benchmarkresults
3.3.1. ResultsfromtheWangetal.(2015)Sobeloperator/hybridprobabilitymodel
To compare the results from our adaptive process (shown in Section 3.2), we picked the Sobel variations that
performedbestwiththetwotypesofimageryinthevalidationdataset. Sobel 70(showninFigure11c)performed
bestwiththeSkyfinderimagery,withaRMSEof0.132,R2 of0.401,andd of0.683. Thebestperformingvariation
9

Figure9: EvaluationofalltechniquesandparametersshowingstatisticsforRMSE(lowervaluesaremoreaccurate)fora)Skyfinderdata
setandb)GSVdataset.EvaluationofalltechniquesandparametersshowingF1statistics(highervaluesaremoreaccurate)forthe9,636
imagevalidationdataset,splitbyc)Skyfinderandd)GSVimages.
with the GSV imagery, Sobel 80 (figure not presented), resulted in a RMSE of 0.07, R2 of 0.433 and d of 0.655.
Precision,recall,andF1-scoresstatistics(seeSupplementaryTable3)showthatSobel 70hasalowerprecisionthan
Sobel 80 with the Skyfinder validation images (at 0.869 vs. 0.920) while Sobel 70 has better recall scores than
Sobel 80(0.914vs. 0.781). SimilarpatternsareseenwiththeGSVimagery. Overall,theF1-scoresareintherange
of0.82to0.87forbothtechniquesanddatasets.
3.3.2. ResultsfromtheMiddeletal.(2018)Sobeloperator/flood-fillalgorithm
In the evaluation of the Sobel/flood-fill algorithm, results from the Skyfinder and GSV 9,636 validation images
areshowninFigure11d. ThisalgorithmyieldsaRMSEof0.205,R2 of0.150andd of0.663againsttheSkyfinder
portion of validation data set and a RMSE of 0.312, R2 of 0.067, and d of 0.304 against with the GSV portion of
thevalidationdataset. TheresultsfromtheevaluationofGSVimageryshowedanumberofimagesmiss-markedas
100%sky,inflatingtheerrorrateforthisdataset. AsimilarproblemwasseenwiththeSkyfinderimages,severalof
themweremiss-markedas0%sky. Thisisalsoreflectedintheprecision,recall,andF1-scores(seeSupplementary
Table 3). Precision scores are 0.840 and 0.761 (for Skyfinder and GSV) are low while the recall scores are much
higher(0.900and0.948),resultinginoverallF1-scoresof0.856and0.813.
4. Discussion
TheresultsfromSection3.1showthatnosingletechniqueandparametercombinationperformsskypixelidenti-
ficationwithhighaccuracyacrossthedatasetsusedbythisproject. Thesedatasetscontainawidevarietyofoutdoor
scenes with various lighting and weather conditions (as can be seen in some of the sample images in Figure 12),
challengingmanyofthetechniques. ItwasexpectedthatalgorithmswouldperformbetterwithGSVimagery,dueto
theirregularity. Theseimageswerecapturedwiththesametypeofequipment,usingthesamecameraangles(horizon
at50%imageheight),underclearskyorpartlycloudyconditions. Theresultsshowthatalmostallofthevariations
10

Figure10:Observedvs.calculatedskypixelsusingthea)Mean76100,b)Mean78300,c)K-mean6,andd)Sobel70techniquesonthe
38,521imagecombineddataset(406GSVand38,115Skyfinderimages).
11

Figure11:a)TheoreticalbestcaseresultsiftheNNis100%accurateforthe9,636validationimages. Othersubfiguresshowresultsofb)
ouradaptiveNNprocess,c)Benchmark1:Sobel70,andd)Benchmark2:Sobel/flood-fillcombination.
Figure12:SelectedimageryusedforNNtrainingforclassificationsa)Mean78300,b)Mean76100,c)K-mean6,andd)Sobel70.
12

performbetterwiththeGSVdatathantheSkyfinderdata. Someofthevariationsevenapproachtheaccuracyofour
systemwiththeGSVdata,forexampleSobel 80.
However,theSkyfinderdatasetchallengedallofthevariationswiththeMeanandSobelbasedmethodsachieving
nobetterthan0.1to0.2RMSE.However, forsomeindividualimages, eventhepoorestperformingtechniques(i.e.
K-means variations) excelled compared to all of the other techniques. Also, some techniques perform poorly for
certainimages. InFigure10d,theresultsfortheSobel 70methodshowwidevariationsinR2 betweentheSkyfinder
andGSVdatasets,whiletheRMSEvaluesareroughlysimilar. InthecaseofSobel 70,skyfractionsforimageswith
lowskyfractions(asmallnumberofimagesinthedataset)aresystematicallyoverestimatedbutthishasasignificant
impact on the GSV R2 value. Both of these cases validate the need for an adaptive process that can respond to the
specificchallengeseachimagepresentstodeliveroverallbetterresultsthananysinglealgorithm. Further,thisallows
certaintechniquestobeavoidedinthecasesthattheywillperformpoorly.
Having a broad range of technique variations was important for the overall accuracy. Experimentation was per-
formed to reduce the number of classifications to possibly increase the accuracy of the NN. However, in removing
someoftheworstperformingmethods(manyoftheK-meansvariations),theoverallaccuracydegraded. Whilesome
ofthevariationshadverylowaccuracyoverall, theywerethebestchoiceforsomeimages. Havingthoseavailable
morethancompensatedfortheNNnotalwayspickingthemostaccuratevariationsforeachimage. Forexample,re-
ducingthechoicestothebestthreeperformingclasses(Mean 7 6 100,K-mean 6,andSobel 70)showedareduction
inRMSEto0.039overthebestaccuracyofthe13approachcombination(RMSEof0.026and0.020forSkyfinder
and GSV respectively). This attempt to increase the accuracy of the NN predictions highlights a limitation of this
study. 53% accuracy in picking between 13 approaches shows that there is room for improvement with this part of
themethod. Withalargertrainingdataset,alowerNNerrorratemightbeachieved,improvingperformancetowards
thetheoreticalRMSEof0.026forskypixelidentification. Newalgorithmsandvariationsofexistingalgorithmscan
be added to the system to handle new imagery with greater accuracy, enabled by our flexible framework, as future
research. Inaddition,aNNcouldbeusedinamoresystematicmannerandexplorepredictingtechniqueparameters
directly.
One difficulty in this study was comparing different sky pixel detection schemes in an objective manner. As
noted in the introduction, most studies either do not provide metrics, or provide different types of metrics. Also,
with our results evaluating the Skyfinder and GSV data sets showing some large differences in performance, a lack
of standardised benchmarks makes comparisons less meaningful. We attempted to overcome these difficulties by
implementingsomeexistingmethodsandincludingtheminourevaluationagainstcommondatasets. Inaddition,the
needsoftheeventualapplicationshouldbekeptinmind. Asprecisionandrecallscoresoftenvariedwidelyforeach
algorithm, the impact of either higher false positives or false negatives should guide algorithm choice or at least be
consideredintheresults. Forexample,analgorithmwithhigherfalsepositiveswilloverestimateskypixels,leading
toahigherSVFestimateandpossiblyhighermaximumtemperaturesinurbancanyonmodelling.
5. Conclusion
In conclusion, we present a system of sky pixel identification that shows high accuracy rates with varied and
challengingoutdoorimagery. Thissystemsitsbetweenalgorithmsthatcanbequicklysetupandrunbutarenotas
accuratewithchallengingdatasets,e.g. Middeletal.(2018),andmorecomplexsystemssuchasGongetal.(2018)
thatrequireamoreextensivedeeplearningalgorithm. Ouradaptivesystemusesthebestelementsofeachinpursuit
ofthemostaccurateresultspossible.
In comparison to published methods, our adaptive process performs well. Our accuracy against the Skyfinder
imagesofRMSEof0.063compareswelltotheRMSEof0.205fortheMiddeletal.(2018)Sobel/flood-fillalgorithm
and the best performing Wang et al. (2015) Sobel variations, Sobel 70 and Sobel 80, achieving an RMSE of 0.132
and0.177. Similarly,ouradaptiveprocessalsoperformswellontheGSVvalidationimageswithaRMSEof0.072
compared to 0.07 and 0.312 for Sobel 80 and Sobel/flood-fill respectively. Finally, our adaptive process performs
withthebestprecision,recall,andF1-scoresfortheSkyfinderdatasetcomparedtoanyoftheevaluatedtechniques.
In the Zenodo data set corresponding to this article (see Section 6), we provide our trained NN model (and
configuration files), which can be used to infer the best algorithm for any type of outdoor imagery, as well as all
the training and validation imagery used in this study. This system can then be used out of the box. Using our
13

system,itwillbepossibletopopulatedatabases(suchasWUDAPT)ofurbanmorphologyinformation. Thisdataset
alsoprovidesastandardiseddatasettoreproduceourresultsandallowbenchmarkcomparisonswithotherskypixel
detectionsystems.
6. Codeavailabilityandlicensing
Code and data are available from the corresponding author on request. Also, data and code are available at
https://doi.org/10.5281/zenodo.2562396 and https://bitbucket.org/politemadness/skypixeldetection (Nice, 2019) and
are distributed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 Generic (CC BY-NC-SA
4.0)license.
Acknowledgements
The support of the Commonwealth of Australia through the Cooperative Research Centre program is acknowl-
edged. AtMonashUniversity,KerryNicewasfundedbytheCooperativeResearchCentreforWaterSensitiveCities,
anAustralianGovernmentinitiative.AttheUniversityofMelbourne,KerryNicewasfundedbytheTransport,Health,
andUrbanDesign(THUD)HubandaGrahamTreloarFellowshipforEarlyCareerResearchers.
References
References
Agarwal,A.,Akchurin,E.,Basoglu,C.,Chen,G.,Cyphers,S.,Droppo,J.,Eversole,A.,Guenter,B.,Hillebrand,M.,Huang,X.,Huang,Z.,Ivanov,
V.,Kamenev,A.,Kranen,P.,Kuchaiev,O.,Manousek,W.,May,A.,Mitra,B.,Nano,O.,Navarro,G.,Orlov,A.,Padmilac,M.,Parthasarathi,
H.,Peng,B.,Reznichenko,A.,Seide,F.,Seltzer,M.L.,Slaney,M.,Stolcke,A.,Wang,H.,Yao,K.,Yu,D.,Zhang,Y.,Zweig,G.,2016.An
IntroductiontoComputationalNetworksandtheComputationalNetworkToolkit,MSR-TR-2014-112,Microsoft.
Ali-Toudert,F.,Mayer,H.,2007.Effectsofasymmetry,galleries,overhangingfac¸adesandvegetationonthermalcomfortinurbanstreetcanyons.
SolarEnergy81(6),742–754.
URLhttp://linkinghub.elsevier.com/retrieve/pii/S0038092X06002623
Badrinarayanan,V.,Kendall,A.,Cipolla,R.,2017.SegNet:ADeepConvolutionalEncoder-DecoderArchitectureforImageSegmentation.IEEE
TransactionsonPatternAnalysisandMachineIntelligence39(12),2481–2495.
Bradski,G.,2000.TheOpenCVLibrary.Dr.Dobb’sJournalofSoftwareTools.
URLhttp://www.drdobbs.com/open-source/the-opencv-library/184404319
Chapman,L.,Thornes,J.E.,2004.Real-TimeSky-ViewFactorCalculationandApproximation.JournalOfAtmosphericAndOceanicTechnology
21,730–741.
Ching,J.,Aliaga,D.,Mills,G.,Masson,V.,See,L.,Neophytou,M.,Middel,A.,Baklanov,A.,Ren,C.,Ng,E.,Fung,J.,Wong,M.,Huang,Y.,
Martilli,A.,Brousse,O.,Stewart,I.,Zhang,X.,Shehata,A.,Miao,S.,Wang,X.,Wang,W.,Yamagata,Y.,Duarte,D.,Li,Y.,Feddema,J.,
Bechtel,B.,Hidalgo,J.,Roustan,Y.,Kim,Y.,Simon,H.,Kropp,T.,Bruse,M.,Lindberg,F.,Grimmond,S.,Demuzure,M.,Chen,F.,Li,C.,
Gonzales-cruz,J.,Bornstein,B.,He,Q.,Hanna,A.,Erell,E.,Tapper,N.,Mall,R.K.,Niyogi,D.,2019.PathwayusingWUDAPT’sDigital
SyntheticCitytooltowardsgeneratingurbancanopyparametersformulti-scaleurbanatmosphericmodeling.UrbanClimate28,100459.
URLhttps://www.sciencedirect.com/science/article/abs/pii/S2212095519300975
Ching,J.,Mills,G.,Bechtel,B.,See,L.,Feddema,J.,Wang,X.,Ren,C.,Brousse,O.,Martilli,A.,Neophytou,M.,Mouzourides,P.,Stewart,
I.,Hanna,A.,Ng,E.,Foley,M.,Alexander,P.,Aliaga,D.,Niyogi,D.,Shreevastava,A.,Bhalachandran,P.,Masson,V.,Hidalgo,J.,Fung,
J.,Andrade,M.,Baklanov,A.,Dai,W.,Milcinski,G.,Demuzere,M.,Brunsell,N.,Pesaresi,M.,Miao,S.,Mu,Q.,Chen,F.,Theeuwes,N.,
2018.WorldUrbanDatabaseandAccessPortalTools(WUDAPT),anurbanweather,climateandenvironmentalmodelinginfrastructureforthe
Anthropocene.BulletinoftheAmericanMeteorologicalSociety.
URLhttps://journals.ametsoc.org/doi/abs/10.1175/BAMS-D-16-0236.1
Christoudias,C.M.,Georgescu,B.,Meer,P.,2002.SynergisminLowLevelVision.In:Proceedingsofthesixteenthinternationalconferenceon
patternrecognition(ICPR2002)heldinQuebecCity,Canada,August11-15,2002.NewYork,NY.No.2.IEEEPress,pp.150–155.
URLhttps://ieeexplore.ieee.org/document/1047421
Comaniciu,D.,Meer,P.,1997.RobustAnalysisofFeatureSpaces:ColorImageSegmentation.In:Proceedingsofthe1997conferenceoncomputer
visionandpatternrecognition(CVPR’97)heldinSanJuan,PuertoRico,June17-19,1997,750-755.IEEEPress,NewYork,pp.750–755.
URLhttps://ieeexplore.ieee.org/document/609410
Comaniciu,D.,Meer,P.,2002.Meanshift:Arobustapproachtowardfeaturespaceanalysis.IEEETransactionsonPatternAnalysisandMachine
Intelligence24(5),603–619.
URLhttps://ieeexplore.ieee.org/document/1000236/
Ettinger,S.M.,Nechyba,M.C.,Waszak,M.,Ifju,P.G.,2003.Vision-GuidedFlightStabilityandControlforMicroAirVehicles.Advanced
Robotics17(7),617–640.
14

Gallagher,A.C.,Luo,J.,Hao,W.,2004.Improvedblueskydetectionusingpolynomialmodelfit.In: 2004InternationalConferenceonImage
Processing,2004.ICIP’04.pp.2367–2370.
GIMP,2019.GNUImageManipulationProgram.
URLhttps://www.gimp.org/
Gong,F.-Y.,Zeng,Z.-C.,Zhang,F.,Li,X.,Ng,E.,Norford,L.K.,2018.Mappingsky,tree,andbuildingviewfactorsofstreetcanyonsina
high-densityurbanenvironment.BuildingandEnvironment134,155–167.
URLhttps://doi.org/10.1016/j.buildenv.2018.02.042
Google,2019.AdvancedGuidetoInceptionv3onCloudTPU.https://cloud.google.com/tpu/docs/inception-v3-advanced.
GoogleMaps,2017.GoogleStreetViewAPI,Availablefromhttps://developers.google.com/maps/documentation/streetview/.(accessed15June
2017).
Grimmond,C.,Potter,S.,Zutter,H.,Souch,C.,2001.Rapidmethodstoestimatesky-viewfactorsappliedtourbanareas.InternationalJournalof
Climatology21(7),903–913.
URLhttp://doi.wiley.com/10.1002/joc.659
Hassannejad, H., Matrella, G., Ciampolini, P., Mordonini, M., Cagnoni, S., 2016. Food Image Recognition Using Very Deep Convolutional
Networks.In:MADiMa’16,October162016,Amsterdam,TheNetherlands.pp.41–49.
Hoiem,D.,Efros,A.A.,Hebert,M.,2005.GeometricContextfromaSingleImage.In:TenthIEEEInternationalConferenceonComputerVision
(ICCV’05)Volume1.
URLhttps://ieeexplore.ieee.org/document/1541316
Holder,C.J.,Breckon,T.P.,Wei,X.,2016.FromOn-RoadtoOff: TransferLearningwithinaDeepConvolutionalNeuralNetworkforSeg-
mentationandClassificationofOff-RoadScenes.In: EuropeanConferenceonComputerVision-ECCV2016: ComputerVision ECCV2016
Workshops.pp.149–162.
Laffont,P.-Y.,Ren,Z.,Tao,X.,Qian,C.,Hays,J.,2014.TransientAttributesforHigh-LevelUnderstandingandEditingofOutdoorScenes.ACM
TransactionsonGraphics33(4).
URLhttps://dl.acm.org/citation.cfm?id=2601101
Laungrungthip,N.,McKinnon,A.E.,Churcher,C.D.,Unsworth,K.,2008.Edge-baseddetectionofskyregionsinimagesforsolarexposure
prediction.In:200823rdInternationalConferenceImageandVisionComputingNewZealand,IVCNZ.
Liang,J.,Gong,J.,Sun,J.,Zhou,J.,Li,W.,Li,Y.,Liu,J.,Shen,S.,2017.AutomaticSkyViewFactorEstimationfromStreetViewPhotographsA
BigDataApproach.RemoteSensing9(5),411.
URLhttp://www.mdpi.com/2072-4292/9/5/411
Luo,J.,Etz,S.P.,2002.APhysicalModel-BasedApproachtoDetectingSkyinPhotographicImages.IEEETransactionsonImageProcessing
11(3),201–212.
Middel,A.,Lukasczyk,J.,Maciejewski,R.,2017.SkyViewFactorsfromSyntheticFisheyePhotosforThermalComfortRoutingACaseStudyin
Phoenix,Arizona.UrbanPlanning2(1),19.
URLhttp://www.cogitatiopress.com/urbanplanning/article/view/855
Middel,A.,Lukasczyk,J.,Maciejewski,R.,Demuzere,M.,Roth,M.,2018.SkyViewFactorFootprintsforUrbanClimateModeling.Urban
Climate25,120–134.
URLhttps://www.sciencedirect.com/science/article/pii/S2212095518301883
Middel,A.,Lukasczyk,J.,Zakrzewski,S.,Arnold,M.,Maciejewski,R.,2019.Urbanformandcompositionofstreetcanyons: Ahuman-centric
bigdataanddeeplearningapproach.LandscapeandUrbanPlanning183,122–132.
URLhttps://doi.org/10.1016/j.landurbplan.2018.12.001
Mihail,R.P.,2015.SkyfinderDataset.
Mihail,R.P.,Workman,S.,Bessinger,Z.,Jacobs,N.,2016.Skysegmentationinthewild:Anempiricalstudy.2016IEEEWinterConferenceon
ApplicationsofComputerVision,WACV2016.
URLhttps://ieeexplore.ieee.org/document/7477637/
Mills,G.,Bechtel,B.,Ching,J.,See,L.,Feddema,J.,Foley,M.,Alexander,P.,Connor,M.O.,2015.AnIntroductiontotheWUDAPTproject.In:
ICUC9-9thInternationalConferenceonUrbanClimatejointlywith12thSymposiumontheUrbanEnvironment.
URLhttp://www.wudapt.org/wp-content/uploads/2015/05/Mills{_}etal{_}ICUC9.pdf
Nice, K. A., 2019. Code repostory for ’Sky pixel detection in outdoor imagery using an adaptive algorithm and machine learning’.
https://bitbucket.org/politemadness/skypixeldetection.
Oracle,2018.JavaPlatformStandardEdition8Documentation.https://docs.oracle.com/javase/8/docs/index.html.
Pangburn,B.E.,2002.EXPERIENCE-BASEDLANGUAGEACQUISITION:ACOMPUTATIONALMODELOFHUMANLANGUAGEAC-
QUISITION.Phd,LouisianaStateUniversity.
Roser,M.,Moosmann,F.,2008.ClassificationofWeatherSituationsonSingleColorImages.In:2008IEEEIntelligentVehiclesSymposium.pp.
798–803.
URLhttps://ieeexplore.ieee.org/abstract/document/4621205
Rueden,C.T.,Schindelin,J.,Hiner,M.C.,Dezonia,B.E.,Walter,A.E.,Arena,E.T.,Eliceiri,K.W.,2017.ImageJ2: ImageJforthenext
generationofscientificimagedata.BMCBioinformatics18(529),1–26.
URLhttps://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-017-1934-z
Schmitt,F.,Priese,L.,2009.SkyDetectionInCSC-SegmentedColorImages.In:VISAPP2009-ProceedingsoftheFourthInternationalConfer-
enceonComputerVisionTheoryandApplications,Lisboa,Portugal,February5-8,2009-Volume2.
Shen,Q.,Zeng,W.,Ye,Y.,Stefan,M.,Schubiger,S.,Burkhard,R.,Qu,H.,2018.StreetVizor:VisualExplorationofHuman-ScaleUrbanForms
BasedonStreetViews.IEEETransactionsonVisualizationandComputerGraphics24(1),1004–1013.
URLhttps://ieeexplore.ieee.org/abstract/document/8017655
Shen,Y.,Wang,Q.,2013.SkyRegionDetectioninaSingleImageforAutonomousGroundRobotNavigation.InternationalJournalofAdvanced
RoboticSystems10,1–13.
15

Sobel,I.,Feldman,G.,1968.A3x3IsotropicGradientOperatorforImageProcessing.In:StanfordArtificialIntelligenceProject(SAIL).
Szegedy,C.,Liu,W.,Jia,Y.,Sermanet,P.,Reed,S.,Anguelov,D.,Erhan,D.,Vanhoucke,V.,Rabinovich,A.,2015.Goingdeeperwithconvolutions.
ProceedingsoftheIEEEComputerSocietyConferenceonComputerVisionandPatternRecognition07-12-June,1–9.
Ioffe,
Szegedy, C., Vanhoucke, V., S., Shlens, J., Wojna, Z., 2016.RethinkingtheInceptionArchitectureforComputerVision.In: TheIEEE
ConferenceonComputerVisionandPatternRecognition(CVPR).
Tao,L.,Yuan,L.,Sun,J.,2009.SkyFinder:Attribute-basedSkyImageSearch.ACMTransactiononGraphics,Siggraph28,68.
Tighe,J.,Lazebnik,S.,2010.SuperParsing: ScalableNonparametricImageParsingwithSuperpixels.In: EuropeanConferenceonComputer
| Vision,ECCV2010:ComputerVision | ECCV2010.pp.352–365. |     |     |
| ------------------------------ | -------------------- | --- | --- |
Tsai,Y.-H.,Shen,X.,Lin,Z.,Sunkavalli,K.,Yang,M.-H.,2016.SkyisNottheLimit:Semantic-AwareSkyReplacement.ACMTransactionson
Graphics35(4),149.
URLhttps://dl.acm.org/citation.cfm?id=2925942
Wang,C.-W.,Ding,J.-J.,Chen,P.-J.,2015.AnEfficientSkyDetectionAlgorithmBasedonHybridProbabilityModel.In:ProceedingsofAPSIPA
AnnualSummitandConference2015.pp.919–922.
Willmott,C.J.,1981.OntheValidationofModels.PhysicalGeography2(2),184–194.
Xia,X.,Xu,C.,Nan,B.,2017.Inception-v3forFlowerClassification.In: 20172ndInternationalConferenceonImage,VisionandComputing
(ICIVC).IEEE,pp.783–787.
Yu,D.,Eversole,A.,Seltzer,M.L.,Yao,K.,Huang,Z.,Guenter,B.,Kuchaiev,O.,Zhang,Y.,Seide,F.,Wang,H.,Droppo,J.,Zweig,G.,Rossbach,
C.,Currey,J.,Gao,J.,May,A.,Peng,B.,Stolcke,A.,Slaney,M.,2015.AnIntroductiontoComputationalNetworksandtheComputational
NetworkToolkit.MicrosoftTechnicalReportMSR-TR-2014–112.Tech.rep.,Microsoft.
Zafarifar,B.,deWith,P.H.N.,2007.BlueSkyDetectionforContent-basedTelevisionPictureQualityEnhancement.2007DigestofTechnical
PapersInternationalConferenceonConsumerElectronics.
Zhijie,Z.,Qian,W.,Huadong,S.,Xuesong,J.,2014.AnEffectiveMethodforSkyRegionDetection.AdvancedScienceandTechnologyLetters
77,96–100.
Zhijie,Z.,Qian,W.,Huadong,S.,Xuesong,J.,Qin,T.,Xiaoying,S.,2015.ANovelSkyRegionDetectionAlgorithmBasedOnBorderPoints.
InternationalJournalofSignalProcessing,ImageProcessingandPatternRecognition8(3),281–290.
7. Appendix
7.1. Additionaldatatables
ThefollowingtablesprovidetheunderlyingdataforFigure9.
Table2:EvaluationofalltechniquesandparametersforthefullSkyfinderandGSVdatasetsshowingstatisticsforR2,RMSE,anddindex
ofagreement.
|                   | Skyfinder   |             | GSV         |
| ----------------- | ----------- | ----------- | ----------- |
| Designation       | R2 RMSE     | d R2        | RMSE d      |
| AdaptiveNNprocess | 0.882 0.063 | 0.967 0.485 | 0.072 0.840 |
Sobel/flood-fill
|              | 0.124 0.211 | 0.651 0.067 | 0.312 0.304 |
| ------------ | ----------- | ----------- | ----------- |
| Sobel 95     | 0 0.421     | 0.372 0.053 | 0.224 0.388 |
| Sobel 90     | 0.041 0.317 | 0.443 0.214 | 0.142 0.516 |
| Sobel 80     | 0.255 0.177 | 0.561 0.433 | 0.070 0.652 |
| Sobel 70     | 0.396 0.134 | 0.678 0.049 | 0.108 0.517 |
| Sobel 60     | 0.288 0.164 | 0.659 0.005 | 0.189 0.387 |
| Sobel 50     | 0.104 0.230 | 0.550 0.026 | 0.302 0.287 |
| K-mean 14    | 0.029 0.328 | 0.439 0.023 | 0.233 0.307 |
| K-mean 12    | 0.028 0.343 | 0.427 0.017 | 0.264 0.299 |
| K-mean 6     | 0.023 0.325 | 0.441 0.002 | 0.160 0.408 |
| Mean 7 8 300 | 0.646 0.143 | 0.859 0.544 | 0.067 0.860 |
| Mean 7 6 100 | 0.748 0.104 | 0.918 0.525 | 0.072 0.842 |
| Mean 5 7 210 | 0.659 0.142 | 0.862 0.526 | 0.069 0.852 |
| Mean 3 6 100 | 0.658 0.148 | 0.854 0.603 | 0.062 0.866 |
16

Table3:Evaluationofalltechniquesandparametersforthe9,636imagevalidationdataset,splitbySkyfinderandGSVimages,showing
statisticsforprecision,recall,andF1scores.
|                   |           | Skyfinder   |           | GSV         |
| ----------------- | --------- | ----------- | --------- | ----------- |
| Designation       | Precision | Recall F1   | Precision | Recall F1   |
| AdaptiveNNprocess | 0.946     | 0.965 0.952 | 0.933     | 0.918 0.918 |
Sobel/flood-fill
|              | 0.840 | 0.900 0.856 | 0.761 | 0.948 0.813 |
| ------------ | ----- | ----------- | ----- | ----------- |
| Sobel 95     | 0.921 | 0.181 0.282 | 0.931 | 0.349 0.495 |
| Sobel 90     | 0.936 | 0.436 0.570 | 0.916 | 0.586 0.706 |
| Sobel 80     | 0.920 | 0.781 0.822 | 0.866 | 0.839 0.845 |
| Sobel 70     | 0.869 | 0.914 0.871 | 0.788 | 0.925 0.839 |
| Sobel 60     | 0.807 | 0.967 0.857 | 0.675 | 0.959 0.777 |
| Sobel 50     | 0.742 | 0.987 0.821 | 0.565 | 0.973 0.697 |
| K-mean 14    | 0.708 | 0.484 0.536 | 0.640 | 0.349 0.406 |
| K-mean 12    | 0.677 | 0.441 0.497 | 0.547 | 0.272 0.328 |
| K-mean 6     | 0.658 | 0.538 0.566 | 0.694 | 0.663 0.639 |
| Mean 7 8 300 | 0.879 | 0.944 0.902 | 0.941 | 0.909 0.918 |
| Mean 7 6 100 | 0.912 | 0.930 0.913 | 0.951 | 0.876 0.903 |
| Mean 5 7 210 | 0.879 | 0.949 0.905 | 0.946 | 0.911 0.921 |
| Mean 3 6 100 | 0.876 | 0.956 0.906 | 0.952 | 0.915 0.927 |
17
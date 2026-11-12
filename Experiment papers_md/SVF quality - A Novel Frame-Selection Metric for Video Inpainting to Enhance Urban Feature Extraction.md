sensors
Article
A Novel Frame-Selection Metric for Video Inpainting to Enhance
Urban Feature Extraction
YuhuFeng1 ,JiahuanZhang1 ,GuangLi2 ,RenTogo3 ,KeisukeMaeda4 ,TakahiroOgawa3
andMikiHaseyama3,*
1 GraduateSchoolofInformationScienceandTechnology,HokkaidoUniversity,Sapporo060-0814,Japan;
feng@lmd.ist.hokudai.ac.jp(Y.F.);zhang@lmd.ist.hokudai.ac.jp(J.Z.)
2 EducationandResearchCenterforMathematicalandDataScience,HokkaidoUniversity,
Sapporo060-0812,Japan;guang@lmd.ist.hokudai.ac.jp
3 FacultyofInformationScienceandTechnology,HokkaidoUniversity,Sapporo060-0814,Japan;
togo@lmd.ist.hokudai.ac.jp(R.T.);ogawa@lmd.ist.hokudai.ac.jp(T.O.)
4 Data-DrivenInterdisciplinaryResearchEmergenceDepartment,HokkaidoUniversity,
Sapporo060-0813,Japan;maeda@lmd.ist.hokudai.ac.jp
* Correspondence:mhaseyama@lmd.ist.hokudai.ac.jp
Abstract: Inourdigitallydrivensociety,advancesinsoftwareandhardwaretocapturevideodata
allowextensivegatheringandanalysisoflargedatasets.Thishasstimulatedinterestinextracting
informationfromvideodata,suchasbuildingsandurbanstreets,toenhanceunderstandingofthe
environment. Urbanbuildingsandstreets,asessentialpartsofcities,carryvaluableinformation
relevanttodailylife.Extractingfeaturesfromtheseelementsandintegratingthemwithtechnologies
suchasVRandARcancontributetomoreintelligentandpersonalizedurbanpublicservices.Despite
itspotentialbenefits,collectingvideosofurbanenvironmentsintroduceschallengesbecauseofthe
presenceofdynamicobjects. Thevaryingshapeofthetargetbuildingineachframenecessitates
carefulselectiontoensuretheextractionofqualityfeatures.Toaddressthisproblem,weproposea
novelevaluationmetricthatconsidersthevideo-inpainting-restorationqualityandtherelevanceof
thetargetobject,consideringminimizingareaswithcars,maximizingareaswiththetargetbuilding,
andminimizingoverlappingareas.Thismetricextendsexistingvideo-inpainting-evaluationmetrics
byconsideringtherelevanceofthetargetobjectandinterconnectivitybetweenobjects.Weconducted
Citation:Feng,Y.;ZhangJ.;Li,G.; experimenttovalidatetheproposedmetricsusingreal-worlddatasetsfromJapanesecitiesSapporo
Togo,R.;Maeda,K.;Ogawa,T.; andYokohama.Theexperimentresultsdemonstratefeasibilityofselectingvideoframesconducive
Haseyama,M.ANovel
tobuildingfeatureextraction.
Frame-SelectionMetricforVideo
InpaintingtoEnhanceUrbanFeature
Keywords:videoframeselection;videoinpainting;qualityevaluation
Extraction.Sensors2024,24,3035.
https://doi.org/10.3390/s24103035
AcademicEditor:StefaniaPerri
1. Introduction
Received:26March2024
Revised:7May2024 Intoday’sincreasinglydigitalizedsociety,softwareandhardwaredevelopmentfor
Accepted:7May2024 capturingvideodatahasmadeitpossibletogatherandanalyzelargeamountofvideodata
Published:10May2024 extensively[1]. Thistrendhassparkedinterestinextractingtheenvironmentandobject
informationfromvideodata,suchasbuildingsandurbanstreets[2]. Thestructureand
featuresofbuildingsarefundamentalcomponentsofurbancitiesandcontainrichinforma-
tionrelevanttopeople’sdailylives. Extractingfeaturesfromvariousurbanbuildingsand
Copyright: © 2024 by the authors. streetsandmodelingandintegratingthemwithtechnologiessuchasVR[3–5]andAR[6,7]
Licensee MDPI, Basel, Switzerland. canleadtomoreintelligentandpersonalizedurbanpublicservices[8,9]. Forexample,city
Thisarticleisanopenaccessarticle
trafficflowcanbebettermanagedtorealizeintelligenttrafficmanagementbyanalyzingthe
distributed under the terms and
locationofbuildingsandtrafficpatternstomodelathree-dimensional(3D)map[10–12].
conditionsoftheCreativeCommons
Thisenablessmarttrafficlightcontrol,optimizedtrafficroutesandimprovedcitytraffic
Attribution(CCBY)license(https://
flow. Therefore,extractingobjectfeaturesfromvideodatahassignificantimplicationsfor
creativecommons.org/licenses/by/
urbanplanning,safetymonitoringandenvironmentalmanagement[13].
4.0/).
Sensors2024,24,3035.https://doi.org/10.3390/s24103035 https://www.mdpi.com/journal/sensors

Sensors2024,24,3035 2of18
However,dynamicobjectssuchaspedestriansorvehiclesinevitablyappearinthe
videoframewhencollectingvideosofurbanstreetsandbuildingsforthepurposesabove,
causinginterferencewiththefeatureextractionofthetargetobjects[14,15]. Toaddress
thisissue,weincorporatedvideo-inpaintingtechnology. Videoinpaintingisanadvanced
video-restorationmethodthatinvolvesmeticulouslyreconstructingmissingordamaged
segmentswithinavideosequencetomeetreal-worlddemandsforenhancedvisualcon-
tent [16,17]. It aims to fill the “corrupted” regions with plausible and coherent content
throughoutvideoclips[18–20]. Withthedevelopmentofcomputervision[19–21],several
video-inpaintingmethodsareconstantlybeingproposed. Toimprovethequalityofinpaint-
ing,spatialstructureandtemporalconsistencyinthevideodataneedtobeconsidered.
However,theoriginalvideodataexhibitunevenqualitylevels,introducingcomplexities
incertainvideoscenariosanddecreasingthequalityofinpaintingresults. Insuchcases,
inpaintingoneachframemaybeperformedindependently. However,thisapproachoften
yields time-inconsistent repair results and may give rise to severe artifacts, as noted in
theliterature[22]. Totackletheaboveproblem,aneffectiveapproachistointroducethe
opticalflow-basedvideo-inpaintingmethod[16,23]thatutilizesopticalflowinformationto
eliminateocclusionsthatmayaffectfeatureextractioninthevideo. Opticalflowrefersto
themotionpatternofpixelsinasceneovertime,whichcanbeusedtodescribethemotion
relationshipbetweenneighboringframesinanimagesequence[24]. Flow-basedvideo-
inpaintingmethodstrytoinferthecontentofmissingframesandrestoretheentirevideo
sequencebyanalyzingthemotioninformationbetweenadjacentframes,thusnaturally
maintainingtemporalconsistency[25]. Therefore,weaimtoemploythisvideo-inpainting
methodtoeliminateobjectsthatmaycauseinterferencefromthevideodata,leavingonly
thetargetobjectforfeatureextraction.
Moreover,theshapeofthetargetbuildingineachvideoframevaries[26]. Toensure
thequalityoftheextractedfeature,carefulselectionofframesforprocessingisessential.
Intuitively,weaimtoidentifyframescharacterizedbyaminimalareaofocclusionsand
a maximal area occupied by the buildings of the feature extraction target. Finding an
evaluationmetricforselectingvideoframesbecomescrucialinthisscenario. Therefore,
itisessentialtoobtainametricthatconsidersthreekeypoints: minimizingtheareaof
occlusions before the inpainting process, maximizing the area with the target building
andminimizingtheoverlappingareabetweentheabovetwoobjects. Remarkably,previous
studies have not proposed tasks or evaluation metrics for this specific purpose. Since
ouraimistointroducethevideo-inpaintingmethodtoprocessthevideoandthenselect
theappropriatevideoframes,weconsidertwofactors: whethernoiseisgeneratedafter
inpaintingprocessing,resultinginlossofimagecontent,andwhetherthetargetbuildingin
theimagehasclearoutlinesandiseasytoextractdetailedfeatures. Basedontheabovetwo
factors,wecanevaluatewhethertheframeissuitableforfeatureextractionofthetarget
object. Forthefirstpoint,therearecurrentlymanyquality-evaluationmetricsforimages
orvideoframes,includingNIQE[27],BRISQUE[28]andPIQE[29]. Sincethegoalofthe
video-inpaintingmethodistomodifytheimagecontentasrequired,thereisnooriginal
referenceobjectthatcanbeusedasabaselinegroundtruth.Therefore,weaimtousetheno-
referenceevaluationmetrics[30,31],suchasNIQE,toassessimagequality. Thesemetrics
calculatestatisticalfeatures,includingmean,standarddeviationandgradient,providinga
quantitativeevaluationofthequalityofthemodifiedimages. However,thesemetricsonly
focusonobjectivelycomparingthespatialstructureinformationandcharacteristicsofthe
processeddatawithoutconsideringtherelevanceofobjectsinimagecontent.
Inthispaper,weproposeanovelevaluationmetricthattakesintoaccountthequality
ofvideoinpaintingandtherelevanceofthetargetobject, suchasbuildings, toidentify
themostsuitableframeforextractingthetargetfeatures.Figure1showstheunderlying
conceptoftheproposedframe-selectionmetric.Beforeusingthisevaluationmetrictoselect
appropriatevideoframes,weinitiallyadoptedthevideo-inpaintingmethodtoeliminate
occlusionsfromvideodata. Specifically,weintroducetheend-to-endframeworkforthe
flow-guidedvideo-inpainting(E2FGVI)[18]method. Bydesigningthreemodulesinthis

Sensors2024,24,3035 3of18
method that operate in close collaboration, the over-reliance on intermediate results of
previouslyindependentsystemsisalleviatedandcanworkmoreefficiently. Furthermore,
weusedtheproposedevaluationmetrictoselectframessuitableforextractingtargetobject
features. Thisvideoframe-selectionmetricextendsexistingvideo-inpainting-evaluation
metrics. The extension involves calculating the relevance of the target object areas in
theimages,consideringtheinterconnectivitybetweenobjects. Weconductexperiments
usingseveralreal-worlddatasetscapturedinspecificscenariostovalidatetheproposed
method. ThesedatasetswerecollectedfromJapanesecitiesinSapporoandYokohama. The
resultsprovideafeasiblemethodforselectingvideoframesthatareconducivetobuilding
featureextraction.
Themaincontributionsofthisstudyaresummarizedasfollows.
• To better extract target objects and features from video data, we propose a novel
evaluationmetricforscreeningsuitablevideoframesbasedonvideoinpainting.
• We explicitly introduce the calculation of the correlation between the target and
surroundingobjects,expandingthepreviousvideo-inpainting-evaluationmetricsto
screensuitablevideoframedatabetter.
Theremainderofthispaperisorganizedasfollows. Section2isabriefoverviewofthe
relatedworks. Section3presentsadetaileddescriptionoftheproposednovelevaluation
metric. TheexperimentalresultsarepresentedinSection4,whereweprovidequalitative
andquantitativeresultsoftheproposedmethod. Section5discussestheimplicationsof
our findings and the limitations associated with our study. Finally, Section 6 presents
theconclusion.
Figure1.Conceptoftheproposedmetricofselectingvideoframesforextractingthefeaturesofthe
targetobject.Theproposedmetrictakesintoaccountthequalityofframesafterinpaintedocclusions
(setas“car”inthispaper)andtherelativeareaofthetargetobjectforfeatureextraction.Basedonthe
conventionalimagequality-evaluationmetric,thecorrelationbetweentargetobjectareasiscalculated
sothattherelevancebetweentargetsintheimageisalsotakenintoconsideration.
2. RelatedWork
2.1. VideoInpainting
Video-inpaintingmethodscanbebroadlydividedintothreeapproaches:3Dconvolution-
based,attention-basedandflow-basedmethods.Eachapproachleveragesdistinctstrategies
toaddressthechallengesofreconstructingmissinginformationinvideosequences.
Three-dimensional convolution-based method. Three-dimensional convolution
exploitsthespatiotemporalcubestructureofvideodata.Itcapturesthecontinuityand
temporalrelationshipswithinthevideobysimultaneouslyconsideringthetemporaland
spatial dimensions [32,33]. Chang et al. [34] proposed a learnable gated temporal shift
moduletoprocessspatialandtemporalrelationshipsinvideosequences. Byintroducing

Sensors2024,24,3035 4of18
agatingmechanism,themodulecanlearnandadjusttime-shiftoperationsadaptivelyto
capturedynamicfeaturesinvideosbetter.However,thisnewmodulemayincreasethe
computationalcomplexityofthenetwork,resultinginpoorperformancewhenrunningin
someresource-constrainedenvironments. Aproposal-basedvideo-inpaintingapproach
was introduced in [35]. This method employs a 3D convolutional network to generate
an initial inpainting result and subsequently refines it by matching and fusing a set of
candidateregions. Thisapproacheffectivelyleveragesthespatialandnonlocalinformation
over time. However, it is worth noting that this method may encounter challenges in
accurately capturing complexities present in scenes characterized by rapid changes or
intricatedynamics. Theinherentlimitationsmayhinderitseffectivenessinsuchdynamic
andintricatevisualcontent.
AttentionMechanismsinVideoInpainting. Attentionmechanismsweightheim-
portance of different regions in video frames, allowing more focused processing of the
inpaintingtask[20,36]. Inthisway,theycanflexiblyfocusoninpaintingregions,reduc-
ingcomputationalcomplexityandmoreeffectivelyhandlingnon-continuousandrapidly
changing objects in complex scenes [37]. Lee et al. [38] trained a deep neural network
(DNN)-basedframeworkthatcopiesthecorrespondingcontentinthereferenceframeand
pastesitintothetargetframe. Theyincludedanalignmentnetworkthatcomputesaffine
matricesbetweenframesforalignment,allowingthenetworktoobtaininformationfrom
moredistantframesforrobustness. However,thismethodoffocusingonlocalfeatures
sometimesleadstooverlookingimportanttiminginformationfortasksthatrequireglobal
context.Zengetal.[17]proposedadeepgenerationmodelthatusesmulti-headandmulti-
layerspace-timetransformerstoperformattentionmatchingonspatialblocksofdifferent
scales, thereby finding relevant content in the space and time dimensions to fill in the
missingareasandcangeneratebothvideo-restorationresultswithperceptualqualityand
spatial-temporalconsistency.However,thismethodmaycausedistortionorblurwhen
restoringdetailedstructures,suchaselongatedorsmallobjects. Thismayaffectthequality
oftherepairresults. Despitesignificantprogressinrecentyears,thedesignofattention
mechanismsmustbecarefullybalancedtoavoidoverlyfocusingoncertainareaswhile
ignoringotherimportantinformation.
OpticalFlowEstimationandPropagation. Somemethodsuseopticalflowestimation
techniques to predict the motion of missing areas for inpainting, which can effectively
handlemotioninvideos[18,39]. Opticalflowreferstothemovementpatternofpixelsina
scenethatchangesovertime[23]. Itcanbeusedtodescribethemovementrelationship
betweenadjacentframesinanimagesequence.Wangetal.[40]introducedanenhanced
deformableconvolutionalnetworkvideo-inpaintingmethodthatincorporatesafeature
alignmentmodulethatincludesthecrucialstepofopticalflowestimation. Thismodule
servesthepurposeofspatiallyandtemporallyaligninginputframefeaturestoenhance
thecaptureofmotionanddeformation. Inasimilarapproach,Chanetal.[41]employed
bidirectionalpropagationandopticalflowalignmentintheirvideosuper-resolution(VSR)
method, BasicVSR. Optical flow is instrumental in spatially transforming and aligning
features from different frames, which are subsequently concatenated and fused [25,42].
The resulting output image is generated through an upsampling module. It is worth
notingthatopticalflowmethodsareamenabletotraininginanunsupervisedorweakly
supervisedmanner[43–45]. Consequently,video-inpaintingmethodsbasedonopticalflow
proveadvantageousincapturingobjectmotioninformationwithinavideothroughoptical
flowestimation.
2.2. EvaluationMetricsofInpaintingVideo
Sincethevideo-inpaintingmethodaimstomodifytheimagecontentasrequired,there
isnooriginalimagethatcanbeusedasabaselinegroundtruth. Therefore,wetendtouse
theno-referenceevaluationmetrics. No-referenceimagequality-evaluationmetricsare
usedtoassessthequalityofanimagewithoutcomparingittoareferenceororiginalimage.
These metrics are particularly useful when a reference image is not available or when

Sensors2024,24,3035 5of18
evaluatingimagesinreal-worldscenarioswheretheoriginalimagemightbeunknown
orinaccessible[46,47]. No-referenceimagequality-evaluationmetricstypicallymakeuse
ofvariouspropertiesofimagestoperformcalculations. Someofthekeypropertiesand
featurescommonlyusedinthesemetricsincludespatialinformation,colorinformation,
structuralinformationandstatisticalmeasures[48–50].
NIQE [27] is a natural image-based quality-assessment method for measuring the
perceivedqualityofimageswithoutreferencetogroundtruth. NIQEprimarilyfocuseson
naturalnessandtheextentofdistortioninimages,withlowerscoresindicatingbetterimage
quality. Inthecontextofvideoinpainting,NIQEcanbeusedtoevaluatetheperceptual
qualityofinpaintedvideoframes,providingresearcherswithaconvenientandreliable
tool. Thecalculationisdefinedasfollows:
(cid:32) (cid:33)
(cid:16)µ(cid:17) 1 ∑ N ∂2µ ∂2µ
NIQE= c ·µ+c ·σ+c · +c · + , (1)
1 2 3 σ 4 N ∂x2 ∂y2
i=1 i i
whereµrepresentsthemeanoftheimage,σrepresentsthestandarddeviationoftheimage,
µ
representstheratioofmeantostandarddeviation,Nrepresentsthetotalnumberofpixels
σ
∂2µ ∂2µ
intheimage, and representthesecondderivativesofthemeaninthehorizontal
∂x2 ∂y2
i i
andverticaldirections,respectively,andc ,c ,c ,c areconstants. Thisequationdescribes
1 2 3 4
thenaturalpropertiesofanimage,evaluatingitsqualitybasedonstatisticalinformation,
suchasmean,standarddeviationandgradients.
BRISQUE[28]isano-referenceimagespatialquality-evaluationmetricthatconcen-
tratesonvisualqualitydefects,suchasdistortion,artifactsandfalsecolorswithinimages.
BRISQUEassessesperceptualqualitybycomputingnaturalfeaturesinimages,makingit
applicableforevaluatingvisualqualityinvideo-inpaintingscenarios. Thecalculationis
definedasfollows:
N
∑
BRISQUE= α · f (·), (2)
i i
i=1
where N representsthenumberofblocksintowhichtheimageisdivided,α represents
i
theweightofthei-thfeatureand f (·)representsthei-thfeaturefunctioncorrespondingto
i
thei-thstatisticalfeature. BRISQUEreliesonalargenumberoflocalimagefeaturesand
statisticalinformationobtainedthroughtheanalysisofimageblocks.
PIQE[29]isaperceptualimagequality-evaluationmetricthatincorporateshuman
visualperceptioncharacteristics,includingbrightness,contrastandcolor. Whenassessing
inpainted video frames, PIQE offers a comprehensive evaluation of perceptual quality,
providingresearcherswithinsightsintotheoverallvisualeffectsoftheinpaintingresults.
Thecalculationisdefinedasfollows:
PIQE= α ·C+α ·M+α ·S, (3)
1 2 3
whereCrepresentscolorfulness,Mrepresentssharpness,Srepresentscontrastandα ,α ,α
1 2 3
are weighting coefficients. Colorfulness, sharpness and contrast are important visual
featuresforimagequality. PIQEcombinesthesefeatures,adjustingtheircontributionswith
weightstoevaluatetheperceivedqualityofanimagecomprehensively.
Theapplicationoftheseno-referenceevaluationmetricsinvideoinpaintingoffers
researchersobjectivemeansofquantifyinginpaintingeffectiveness, contributingtothe
advancementandoptimizationofthisfield.
3. Frame-SelectionMetricforVideoInpainting
Toreducetheimpactofocclusionsonfeatureextraction,weemployvideoinpainting
ontheoriginalvideodataandthenassessframeswhileconsideringsemanticcontent. As
showninFigure2,weemploytheadvancedE2FGVImethodandintegratetheGrounding
DINOobjectdetectorwiththesegmentanythingmodel(SAM)toprovidemaskdatafor
E2FGVI.WeusetheGroundingDINOdetectortoobtainobjectcoordinates,withwhich

Sensors2024,24,3035 6of18
SAMcanpreciselygeneratemaskdatathroughsegmentation. AfterapplyingE2FGVIto
theobtainedmasks,weevaluateframequalityandobjectcorrelationtoselecttheoptimal
frameforfeatureextraction.
Figure2. Overviewofthecalculationoftheproposedmetric. Weextractthepositioncoordinate
ofthe“car”usingtheGroundingDINOmodelandinputitintotheSAMmodelformoreaccurate
segmentationandmaskingresults.Subsequently,theoriginalvideodataandthe“car”maskingdata
arefedintotheE2FGVImodelforvideoinpainting.Intheobtainedvideo,theoutlineofthetarget
object(“building”)becomesclearer.Followingthis,wealsoemploytheGroundingDINOandSAM
modelstoobtainmaskingdataforthe“building”. This,alongwiththepreviouslyobtained“car”
maskingandvideodataafterinpainting,isusedtocalculatetheproposedmetric.
3.1. GenerationofMaskData
GroundingDINOinitiallyidentifiesthecoordinatesofthetargetobjectforelimination
usingadualencoder–singledecoderarchitecture. Itcomprisesimageandtextbackbones
forfeatureextraction,afeatureenhancerforfusingimageandtextfeatures,alanguage-
guidedselectionmoduleforinitializingqueriesandacross-modalitydecoderforrefining
boxcoordinates[51]. Thefeatureenhancermodulefacilitatescross-modalityfeaturefusion,
and the language-guided query-selection module selects queries from image features.
Thesequeriesareinputintoacross-modalitydecoderthatupdatesandprobesdesired
features. The decoder’s output queries predict object boxes and extract corresponding
phrases. Inthisstudy,weusedtheGroundingDINOmodelwith“car”asthekeyword
toderivetheboundaryboxcorrespondingtotheapproximatepositionofobjectsineach
frameimage,beingusedtogeneratemaskdataofthecorrespondingareainthenextstep.
These boundary boxes indicate the target object’s position in the image but lack
detailedtargetoutlineinformation,posingchallengesforaccuratecalculationoftherelative
areainsubsequentscreening. Toovercomethislimitation,weusetheobtainedboundary
boxdatatolocatethetargetpreciselyusingtheSAMmodel. Thespatialattentionmasking
method is then applied to accurately mask the corresponding target in the SAM video
frame.Builtonavisiontransformerwithreal-timeperformanceoptimizations,themasking
method considers sparse and dense prompts. The mask decoder efficiently maps the
embeddingsandanoutputtokentoamask.Aftertwoblocks,theimageembeddingis
upsampledandamultilayerperceptronmapstheoutputtokentoadynamiclinearclassifier.
Throughthisprocess,themaskdataforthe“car”intheframeswereobtainedtoguidethe
video-inpaintingmodelineliminatingthe“car”areaintheframes.
3.2. InpaintingofCertainObjects
Toaddresstheremovalofspecificobjectswithinthemaskedareaofvideoframes,
we introduced the E2FGVI method. For a video sequence Xt that can be defined as
(cid:8) Xt ∈RH×W×3 | t =1,2,...,T (cid:9) withasequencelengthofTandcorrespondingframe-wise
binarymasks,weaimtosynthesizefaithfulcontentthatmaintainsconsistencyinthespatial

Sensors2024,24,3035
7of18
andtemporaldimensionswithinthecorrupted(masked)areas. Themethodologybegins
withacontextencoderforencodingallcorruptedframesintolower-resolutionfeaturesto
enhancecomputationalefficiencyinsubsequentprocessing[18]. Subsequently,weemploy
aflowcompletionmoduletoextractandcompletetheopticalflowbetweenlocalneighbors.
The completed optical flow assists in aligning features extracted from local neighbors,
facilitating bidirectional propagation. Furthermore, content hallucination is performed
usingmulti-layertemporalfocaltransformers,combiningpropagatedlocalneighboring
featureswithnon-localreferencefeatures. Finally,adecoderisusedtoupscalethefilled
(cid:8) ∈RH×W×3 (cid:9)
features,reconstructingthemintoafinalvideosequence Yˆt | t =1,2,...,T .
weemploytheE2FGVImodeltoeliminatethe
Usingthemaskdatafor“car”asinput,
contentrelatedto“car”intheoriginalvideodata.
Itisworthnotingthattheevaluationoftheimagequalityofprocessedframesrequires
acomprehensiveanalysisofimagedatafromdiverseperspectives.Thisevaluationincludes
assessingwhethertheframeisconducivetoextractingtargetobjectfeatures. Thefactors
considered include the relative area size of the target object within the image and the
clarity of its outline. To facilitate this evaluation, it is essential to obtain area data for
the“eliminationtarget”and“featureextractiontarget”. However,apotentialchallenge
arisesinscenarioswherethefeatureextractiontarget(building)mayencounterobstruction
fromcarsintheoriginalvideodata,resultingintheblurringofthebuilding’soutline. To
addressthisissue,weperformmaskingaftervideoinpaintingasshowninAlgorithm1.
Thisstepaimstoclearlydelineatetheoutlineofthebuildingandcalculatetherelativearea
accurately. Followingtheacquisitionofthevideoframeafterinpaintingthe“car”object,
weiteratethroughtheprocessingstepsoutlinedinSection3.1. Inthisiteration,wereplace
thekeywordwith“building”toconductasimilaranalysisforthedesiredfeatureextraction
target. Finally,weobtainedthemaskdataofthe“building”.
Algorithm1Generatemaskdataandperformvideoinpainting
1: procedure
| 2:  | Input: | metavideodatav |     | withNframes |     |     |
| --- | ------ | -------------- | --- | ----------- | --- | --- |
meta
|     | foreachframeF |                             | (i =1toN)inv |     | do   |     |
| --- | ------------- | --------------------------- | ------------ | --- | ---- | --- |
| 3:  |               |                             | i            |     | meta |     |
| 4:  |               | #Generatethemaskdataof“car” |              |     |      |     |
| 5:  |               | m i ←GroundingDINO(F        |              |     | )    |     |
|     |               | c ar                        |              | i   |      |     |
6: endfor
| 7:  | M   | = [m i | ] N  |     |     |     |
| --- | --- | ------ | ---- | --- | --- | --- |
|     | car | c ar   | i =1 |     |     |     |
#Eliminate“car”fromvideodata
8:
←E2FGVI(v
| 9:  | v   |     | meta | ,M  | car ) |     |
| --- | --- | --- | ---- | --- | ----- | --- |
without_car
| 10: | foreachframeF |                                  | (i =1toN)inv     |     |             | do  |
| --- | ------------- | -------------------------------- | ---------------- | --- | ----------- | --- |
|     |               |                                  | i                |     | without_car |     |
| 11: |               | #Generatethemaskdataof“building” |                  |     |             |     |
| 12: |               | m i                              | ←GroundingDINO(F |     | )           |     |
|     |               | b uilding                        |                  |     | i           |     |
13: endfor
| 14: | M        | =           | [m i ] N       |          |     |     |
| --- | -------- | ----------- | -------------- | -------- | --- | --- |
|     | building |             | b uilding i =1 |          |     |     |
| 15: | returnv  |             | , M car , M    |          |     |     |
|     |          | without_car |                | building |     |     |
16: endprocedure
3.3. DerivationofNovelMetricandFrame-SelectionScheme
After the above processing, we can gain the mask data for the object “car” in the
originalvideodataasA,thevideoframeafterinpaintingthe“car”usingE2FGVIdefined
as B andthemaskdatafortheobject“building”in B as C. Wefirstevaluatetheframe
image quality after inpainting from the aspect of image data by calculating traditional
imagequality-evaluationindicators. Specifically,weusethreemetrics: NIQE,BRISQUE
andPIQE.
Wealsoneedtoevaluatewhethertheframeissuitableforfeatureextractionofthe
targetobjectfromthesemanticlevelperspective, i.e.,therelativeareasizeofthetarget
objectintheimageandwhethertheoutlineisclear. Ourstartingpointisthatwehopethat

Sensors2024,24,3035
8of18
theareawherepeopleorvehiclesappearintheselectedframeisassmallaspossibleto
highlightthetargetbuildingasmuchaspossible. Thepartcontainingthebuildingneeds
tobeaslargeaspossible,whereastheoverlappingareaoftheabovetwoareasisminimal.
Therefore, as shown in Algorithm 2, taking this “elimination target” (car) and “feature
extractiontarget”(building)asanexample,wesetthetotalareaoccupiedbythetwointhe
| imagetoArea | anddefinedas |     |     |     |
| ----------- | ------------ | --- | --- | --- |
all
|     | Area | =Area(A)+Area(C)−O(A,C), |     | (4) |
| --- | ---- | ------------------------ | --- | --- |
all
whereArea(·)andO(·)representtheareaandtheoverlappingareaoftwoobjects.
Con-
sequently,wedefinetheratioofthearea ofthe“eliminationtarget”asArea (A),ratioof
r
(C)andtheratioofoverlapofthetwo
| theareaofthe“featureextractiontarget”asArea |                                                 |     | r   |     |
| ------------------------------------------- | ----------------------------------------------- | --- | --- | --- |
| objectsasO                                  | (A,C). Thespecificcalculationmethodisasfollows: |     |     |     |
r
|     |     | Area r (A) =Area(A)/Area | ,   | (5) |
| --- | --- | ------------------------ | --- | --- |
all
|     |     | Area (C) =Area(C)/Area | ,   | (6) |
| --- | --- | ---------------------- | --- | --- |
|     |     | r                      | all |     |
|     |     | O (A,C) =O(A,C)/Area   | .   | (7) |
|     |     | r                      | all |     |
(A,C)thatcomprehensivelyconsiderstherelation-
| Next,wedefinetheparameterR |     | iou |     |     |
| -------------------------- | --- | --- | --- | --- |
shipbetweenthetwoareasasfollows:
1
|     | R iou (A,C) | =                  | +Area r (C), | (8) |
| --- | ----------- | ------------------ | ------------ | --- |
|     |             | Area (A)+O (A,C)+1 |              |     |
|     |             | r r                |              |     |
Specifically, thesmallerthearearatiooftheocclusion(Area (A)), thelessinterfer-
r
encethereisinthefeatureextractionprocess. Similarly,asmalleroverlappingarearatio
(A,C))betweentheocclusionandthetargetobjectindicatesacleareroutlineofthetarget
(O r
objectintheframe. Finally,alargerarearatioofthetargetobject(Area (C))impliesthatit
r
iseasiertocapturedetailedfeaturesintheframe.Therefore,duringthecalculation,weadd
Area (A)andO (A,C)andtakethereciprocal. Area (C)istreatedasaseparatecompo-
| r   | r   |     | r   |     |
| --- | --- | --- | --- | --- |
(A)+O (A,C)
nentandaddedtothefractions. Besides,toavoidthesituationwhereArea r r
equals0,whichoccurswhentheframedoesnotinitiallycontainocclusionandthusthe
calculationoftheparameterR iou cannotproceed,weintroducetheterm+1tothedenomi-
natorensuringthesmoothprogressionofthecalculationprocess. Moreover,thesmaller
thescoreoftheabovethreeconventionalimagequality-evaluationmetrics,thebetterthe
perceivedquality. Thus,wedefinethenewframe-selectionmetricasfollows:
1
|     |     | q=Sigmoid( +R | (A,C)), |     |
| --- | --- | ------------- | ------- | --- |
|     |     |               | iou     | (9) |
metrics
wheremetrics ∈ {NIQE,BRISQUE,PIQE}.SincetheconventionalmetricsNIQE,BRISQUE
andPIQEareallsmallervaluesindicatingbetterimagequality,tomatchwithR ,wetake
iou
theinverseoftheconventionalmetricsforcalculationandmapthesumofthetwotothe
intervalfrom0to1byusingthesigmoidfunctionforeasycomparison. Thedefinitionofq
includesimagequalityevaluationandfeatureextractiontargetrelativearea. Itevaluates
theimagequalityoftheprocessedframefromtheimagedataperspective. Itevaluates
whethertheframeissuitableforthetargetfromthesemanticlevelperspective. Feature
extractionofobjects. Thehigherthevalueofq,themoresuitabletheframeisforextracting
featuresofthesettarget.
Theproposedmetricconsidersbothimagequalityandobjectrelevanceduringthecal-
culation. Framesobtainedthroughtheselectionwithhighervaluesofqcanbeconsidered
tohaveahighercomprehensivelevelinbothaspects. Inthisway,theframeswhoseimage
contentismostsuitableforextractingtargetobjectfeaturesareobtainedfromthevideo,
whichcaneffectivelysupportandassistaseriesofdownstreamtasks. Taking“buildings”
asthetargetinthisstudy,extractingfeaturesfromcitybuildingsandstreetsandsubse-
quentlymodelingandintegratingthemwithtechnologiessuchVRandARholdssignificant

Sensors2024,24,3035
9of18
importance. Thisapproachcontributestomoreintelligentandhumanizedurbanpublic
services,impactingurbanplanning,securitymonitoringandenvironmentalmanagement.
Algorithm2Calculationoftheproposedmetric
1: procedure
| Input:           | v           | ,   | M , M        |             |     |     |     |     |
| ---------------- | ----------- | --- | ------------ | ----------- | --- | --- | --- | --- |
| 2:               | without_car |     | car building |             |     |     |     |     |
| 3: foreachframeF |             | (i  | =1toN)inv    |             | do  |     |     |     |
|                  |             | i   |              | without_car |     |     |     |     |
#Calculatetheratioofthemaskareatotheeachframe
4:
|     | (m      | i ) ←theratioofm |                | i    |             |     |     |     |
| --- | ------- | ---------------- | -------------- | ---- | ----------- | --- | --- | --- |
| 5:  | Area r  | c ar             |                | c ar | inF i       |     |     |     |
| 6:  | Area (m | i                | ) ←theratioofm |      | i inF       |     |     |     |
|     | r       | b uilding        |                |      | b uilding i |     |     |     |
7: O (m i ,m i )←theratiooftheoverlappingareabetweentwomasksinF
|     | r c ar | b uilding |     |     |     |     |     | i   |
| --- | ------ | --------- | --- | --- | --- | --- | --- | --- |
8: #Comprehensivelyconsiderstherelationshipbetweenthetwomasksareas
|     | (m i                                | i         | ) ←   |       | 1                      | +Area | (m         | )   |
| --- | ----------------------------------- | --------- | ----- | ----- | ---------------------- | ----- | ---------- | --- |
| 9:  | R iou c                             | ar ,m     |       |       |                        |       | r building |     |
|     |                                     | b uilding | Arear | (mcar | )+Or ( mcar,m building | )+1   |            |     |
| 10: | #No-referenceimagequalityevaluation |           |       |       |                        |       |            |     |
11: metrics ∈ {NIQE,BRISQUE,PIQE} ←calculatetheimagequalityofF
i
#Theproposedselectionmetric
12:
| 13: | q←Sigmoid( |     | 1 +R     | (m i     | ,m i ))   |     |     |     |
| --- | ---------- | --- | -------- | -------- | --------- | --- | --- | --- |
|     |            |     | met rics | iou c ar | b uilding |     |     |     |
14: endfor
returnq
15:
16: endprocedure
4. Experiments
Inthissection,weexplaintheexperimentsontheproposedframe-selectionmetric.
WealsointroducetherelevantsettingsusedintheexperimentinSection4.1andexplain
theresultsoftheexperimentinSection4.2.
4.1. Condition
Dataset. We conducted experiments on real-world datasets obtained from a style
ofstreetsceneshotalongtheroadbyavehicle-mountedcameraZED2iequippedwith
dual4Mpixelssensorswith2-micronpixels. Thevideooutputresolutionisside-by-side
2×(1920×1080) with30framespersecond. Duringthefilming, thecamera-mounted
vehiclewastravelingataspeedofapproximately20km/h. Specifically,thedatasetsare
sourcedfromJapanesecities,includingSapporo,YokohamaandshinYokohama. Forcon-
venienceofdescription,wecallthevideodatasetsSapporo,YokohamaandshinYokohama,
respectively, for they were shot in the corresponding cities or regions. All these video
datasetswereshotatastreetsceneusingafixed-positioncameralocatedinfrontofthecar.
Intheexperiment,weselectedtwoclipsfromtheabovethreedatasets. Eachclipcontains
50framesofimagesinterceptedfromarandommomentinthemetavideodata.
Inthispaper,wefirstproposeaframe-selectionmetricthatconsidersthequalityofthe
inpaintingvideoandtherelativeareaoccupiedbythetargetobject. Therefore,themodels
weusedintheexperiments,suchasGroundingDINO,SAMandE2FGVI,followedthe
parametersettingsintheoriginalpaperwithoutadditionaltraining. ForGroundingDINO,
weusesixfeatureenhancerlayersinthefeatureenhancermoduleandthecross-modality
decodercomprisessixdecoderlayers[51]. InSAM’stransformerstructure,weusedeight
headsinallattentionlayers[52].
Evaluation. We compared the experimental results from two aspects to verify the
effectivenessoftheproposedselectionmetric. Specifically,forthesamebuildingintheim-
age,wefirstcomparetheresultsoftheconventionalno-referenceimagequality-evaluation
metricwiththatoftheproposedmetricforacertainframetoverifytheeffectivenessof
consideringthecorrelationofobjectsintheimage. Then,wecomparethecontentdifference
offrameswithdifferentcalculationresultsoftheproposedmetric,especiallytheoutlineof
thetargetobjectandtheareaitoccupiesintheimage,whichisusedtodeterminewhether

Sensors2024,24,3035 10of18
the proposed metric can be effectively screened to obtain frames that meet the feature
extractionrequirements.
4.2. ExperimentalResults
Inthissection,weanalyzethecompositionoftheproposedmetricfromtheperspective
of the validity of the introduction of the concept of object relevance, sensitivity to the
nuancesoftheimagecontent,universalityoftheimprovementforthetraditionalimage
quality-evaluationmetricsandnecessityofintroducingtheoverlapareainthecalculation
oftheobjectrelevancetoconfirmthevalidityoftheproposedmetric.
Figure3showsanotabledisparityintherelativeareaofbuildingsbetweenframe
A, surpassing that of frame B. The structural content of frame A is more conducive to
featureextractionintermsofthesuitabilityforextractingbuildingfeaturesfromtheimages.
However,theconventionalimagequality-evaluationmetricsindicatethattheimagequality-
assessment for frame A is subpar compared to frame B. The proposed metric achieves
highervaluesforframeAthanframeBbasedontheexpectedoutcomethatframeAis
moreaptforextractingbuildingfeatures. Thus,theeffectivenessoftheproposedmetricis
substantiated,especiallyinincorporatingobjectrelevance.
Figure 3. The results in the figure demonstrate the limitations of conventional image quality-
evaluationmetricsandtheeffectivenessofintroducingobjectrelevanceintotheproposedmetric.
TherelativeareaofthebuildinginframeAislargerthanthatinframeB.Intuitively,frameAismore
suitableforextractingbuildingfeatures.However,theresultsofconventionalmetricsshowthatthe
imagequality-evaluationresultofframeAisworsethanthatofframeB.Incontrast,theproposed
metricsshowthatframeAisbetter.
Figure 4 shows that frames C, D, E and F exhibit minimal temporal separation in
the video, leading to highly similar visual content. These four frames in Figure 4 are
sequentially increasing in the order of the video timeline. This can be regarded as the
camera-mounted vehicle gradually moving forward and approaching the building. In
this process, the relative area occupied by the buildings has increased slightly in each
frameofD,EandFcomparedwiththepreviousframebycalculatingthenumberofpixels.
TheresultsrevealasequentialincreaseinthevaluesoftheproposedmetricforframesC,
D,EandFastheareaoccupiedbythebuildingsintheimageexpands. Thesefindings

Sensors2024,24,3035 11of18
underscorethatevensubtlevariationsintherelativeareaoccupiedbythetargetobject
within the image content of different frames can be quantitatively expressed using the
proposedmetric. Consequently,thediscernmentofframesmoreconducivetotargetobject
featureextractionbecomesfeasible,therebyvalidatingeffectivenessoftheproposedmetric.
Moreover,Figure4facilitatesacomparativeanalysisoftheresultsfromtheproposedmetric
computedusingthreedistinctno-referenceimagequality-evaluationindices. FramesC,D,
EandFfollowasequentialorderalongthevideotimeline. Notably,withaslightlygreater
relativeareaofthebuilding,thevaluesoftheproposedmetric,calculatedbasedonthe
threeconventionalimagequality-evaluationmetrics,exhibitacorrespondingincrease. This
consistencyconfirmstheapplicabilityoftheproposedmetric’scalculationapproachacross
arangeoftraditionalimagequality-evaluationmetrics.
Figure4.Weaimfortheareaofthebuildingsintheselectedframestobelargerandmoreconduciveto
extractingdetailedfeatures.Thisfigureillustratesthatthearea(inpixels)occupiedbythebuildings
in the four frames steadily increases, alongside a rise in the value of the proposed metric. This
observationunderscoresthatevenminorchangesintheareaoccupiedbythetargetobjectwithinthe
imagecontentofdifferentframescanbequantitativelyexpressedusingtheproposedmetric.
Figure 5 shows that the visual content in frames G and H post-inpainting exhibits
substantial similarity; a similar phenomenon is observed in frames I and J in Figure 6.
InframesGandI,beforeundergoinginpainting,carstraversethefrontofthebuilding,
obstructingthebuilding’soutlineintheimage. Incontrast,intheuntreatedframesHandJ,
thecarshavealmostdepartedfromthebuilding. Thesefiguresillustratethat,althoughthe
“car”contentintheimageismainlyeliminatedandsubstitutedwithbackgroundelements
throughinpainting,theconstrainedperformanceofthecurrentvideo-inpaintingmethod
leads to a discernible degree of background blurring in the processed areas. Utilizing
frames with such characteristics for extracting building features can impact the overall
extractionperformance. Toaddressthisissue,theproposedmetricincorporatesthecom-
putationoftheoverlappingareabetween“car”and“building”toselectframeswherethe
building’soutlineisinfluencedbyblurduringtheselectionofframessuitableforfeature
extraction. Figures5and6showthatthescoreofframesHandJsurpassesthatofframes

Sensors2024,24,3035 12of18
GandI,underscoringtheeffectivenessoftheproposedmetric. Furthermore,toassessthe
universalityoftheproposedmetric,inadditiontotheaforementionedprivatedataset,we
conductedidenticalexperimentsusingapublicdataset,CityScapes. Theresultspresented
inFigure7demonstratethattheproposedmetricsyieldhighervaluesinframeswherethe
buildingsaremoreclearlyvisible,thusvalidatingtheeffectivenessoftheproposedmetrics.
Figure5.Althoughthecontentsofthetwoframesafterinpaintingprocessingarebasicallythesame,
theblurleftinthebackgroundwhentheocclusion(“car”)iseliminatedwillstillaffectthefeature
extractionofthetargetobject(“building”). Theproposedmetricintegratesthecalculationofthe
overlappingareabetweenthe“car”and“building”todiscernandexcludeframesinwhichtheclarity
ofthebuilding’soutlineiscompromisedbyblur. Theresultsinthefigureshowthatframeswith
smalleroverlappingareashavehigherscores.
Inessence,theproposedmetricservesasanextensiontoenhancetheperformance
ofconventionalimagequality-evaluationmetricsforspecifictasks.Figures4–6showthe
results of the proposed metric based on three conventional metrics: NIQE, BRISQUE
andPIQE.Asshowninthesefigures,theproposedmetric,basedondifferentconventional
metrics, accurately identifies frames that are more suitable for feature extraction. This

Sensors2024,24,3035 13of18
observation validates the effectiveness of the calculation model of the proposed metric
acrossarangeoftraditionalimagequality-evaluationindicators.
Figure6.Althoughthecontentsofthetwoframesafterinpaintingarebasicallythesame.Bycom-
paringtheoriginalframes,itcanbefoundthataftereliminatingthe“car”-relatedcontent,blurring
appearedintheprocessedarea,whichmayaffecttherecognitionofthebuilding’soutline.Asshown
inthisfigure,frameKwithblurredareasclosetobuildingshaslowerscores,whereasframeLwith
blurredareasfarawayfrombuildingshashigherscores. Theproposedmetriccanbeeffectivein
differentscenarios,whichfurtherverifiesitseffectiveness.

Sensors2024,24,3035 14of18
Figure7. Inadditiontoconductingexperimentsonprivatedatasets,wealsoverifiedtheproposed
metricsonthepublicdatasetCityScapes.Theresultsinthefigureprovetheeffectivenessofthemetrics.
5. Discussion
We have proposed a viable solution within the research domain that focuses on
selecting frames from videos for a certain purpose. The innovative evaluation metric
introducedforselectingvideoframesbasedonvideoinpaintingenhancestheabilityto
selectframessuitableforextractingspecifictargetobjectfeatures.Inthissection,wediscuss
thelimitationsoftheexistingmodelandpotentialavenuesforfutureresearch.
Limitations.Theproposedmetricisapreliminaryconclusiondrawnfromourcompre-
hensiveconsiderationofthetwoaspectsofthistask: thenecessityofevaluatingthequality
of image inpainting and the relevance between the target objects for feature extraction
andtheirsurroundings. Therefore,extensivedomainsremainawaitingexplorationand
validationtoenhancetheaccuracyofthisnovelmetric. Forinstance,thereisstillpotential
toenhancetheaccuracyofacquiringmaskdatapriortothevideo-inpaintingprocess.
Moreover,thesegmentationandmaskresultsdepictedinthefigurerevealthatthe
currentmethodssometimesstruggletoidentifythespecifiedinputclassaccurately. This
issuemayresultintheincapacitytoeliminateinterferingobjectsduringsubsequentvideo
inpaintingormayaffectthecalculationoftherelativepositionofthetargetobject,leading
tolowerareavalues. Aspreviouslystated,theproposedselectionmetricconsiderstwo

Sensors2024,24,3035 15of18
factorstocomprehensivelyevaluatetheframe’ssuitabilityforextractingtargetfeatures.
However, we directly employed conventional image quality-evaluation metrics at the
specificcalculationleveltoassesstheimagequalityaftervideoinpainting. Itthenevaluates
theobjectrelevanceintheimagebycalculatingtherelativeareaofthetargetobjectand
ultimatelycombinesthesetwoaspects.
Finally,themainpurposeofthisstudyistovalidatetheeffectivenessofthenewlypro-
posedselectionmetrics. Videoinpaintingservesasapreprocessingstepbeforecalculating
theproposedmetricandisnotrestrictedtotheE2FGVImethodutilizedinthispaper. Other
inpaintingmethodswithexceptionalperformancecanalsoservethesamepurpose. There-
fore,wedidnotcomparetheeffectsofadditionalmethodsduringthevideo-inpainting
stageinthispaper. Consequently,toacertainextent,theimpactoftheprocessingresults
ofvariousvideo-inpaintingmethodsonthecalculationoftheproposedmetricswasnot
thoroughlyexamined. Amorein-depthdiscussioniswarranted,exploringaspectssuchas
whetherthereexistsaprioritizationintheimpactofthetwofactorsonfeatureextraction.
Moreover,duringthecalculationoftheproposedframe-selectionmetrictoobtainahigher
value,itremainschallengingtodiscernthepredominantinfluencebetweenthetwofactors
mentionedearlier.
6. Conclusions
Thispaperproposesanovelevaluationmetricthatconsidersvideo-inpainting-restoration
qualityandtherelevanceofthetargetobject, suchasbuildings, toidentifytheoptimal
frameforextractingthetargetfeatures. First,thevideodataundergoesprocessingusing
thevideo-inpaintingmethodcalledE2FGVI.Thismethodemploysthreecloselymodules
that operate in close collaboration to enhance efficiency by mitigating over-reliance on
intermediateresultsofpreviouslyindependentsystems. Theproposedevaluationmetric
isthenappliedtoselectframessuitableforextractingtargetobjectfeatures. Thismetric
extendsexistingvideo-inpainting-evaluationmetricsbycalculatingtherelevanceoftarget
objectareasintheimages,consideringinterconnectivitybetweenobjects. Weconducted
experimentsonreal-worlddatasetsfromJapanesecitiestovalidatetheeffectivenessofthe
proposedapproach. Theresultsdemonstrateapracticalmethodforselectingvideoframes
conducivetobuildingfeatureextraction.
FutureWork. Infuturestudies,weintendtoexploreoptimizationsintheprocessof
obtainingmaskdata. Thisinvolvesemployingmoreaccuratedetectionandsegmentation
methodstogeneratemasks,continuouslyenhancingtheeffectivenessofobjectelimination
insubsequentvideoinpainting. Additionally,consideringthatthisexperimentservesas
anexplorationandpreliminaryverificationofanewresearchtask,thecalculationofthe
relative area of the target object and the clarity of its outline involves only one specific
pair,with“buildings”asthetargetand“cars”astheobstructingobjects. Uponvalidating
theeffectivenessoftheproposedmetricthroughexperiments,ourfutureplansinvolve
expandingthescopeofrelevancecalculationtoincludemoreobjects. Thisextensionmay
encompassentitiessuchas“pedestrians”,“greenbelts”and“streetlights”.
Duringtheanalysisoftheresults,weobservedthatcertainissuespersistwhenthe
video-inpainting model E2FGVI employed in this experiment eliminates the specified
content. Theseissuesincludetheretentionoforiginalcontentortheintroductionofblurred
noise in the background. This phenomenon adversely affects the calculation of image
quality-evaluationindicatorsandthesegmentationoftargetobjects. Thus,wewillcontinue
tooptimizevideo-inpaintingmethodswithenhancedperformance. Simultaneously,we
will pay close attention to the latest developments in the field of video inpainting and
introduce implemented SOTA models for comparison. This ongoing effort is aimed at
improvingtheaccuracyandeffectivenessoftheproposedmetric.
Moreover,weplantoconductextendedexperimentstovalidatethesignificanceofthe
twofactorsinfluencingthechangeintheproposedmetric’svalue. Additionally,weaimto
refinethecalculationmethodoftheproposedmetricusingtechniquessuchasweightingto
ensuremorereasonableandmeaningfulresults. Finally,infurtherexpansioninthefuture,

Sensors2024,24,3035 16of18
thepracticalapplicationoftheproposedmethodisnotlimitedtoselectframesmentioned
inthisarticleforextractingfeatures. Aninterestingapplicationisthatwecaneliminatethe
occlusionofathletesinimagedataaboutsportsrefereestoprovideviewerswithabetter
viewingexperience.
AuthorContributions: Conceptualization,Y.F.,J.Z.,G.L.,R.T.,K.M.andT.O.;methodology,Y.F.,
J.Z.,G.L.,R.T.,K.M.andT.O.; software,Y.F.; validation,Y.F.; datacuration,Y.F.andJ.Z.; writing
and original draft preparation, Y.F.; writing and review and editing, G.L., R.T., K.M. and T.O.;
visualization,Y.F.; fundingacquisition,M.H.Allauthorshavereadandagreedtothepublished
versionofthemanuscript.
Funding: This research was supported in part by JSPS KAKENHI Grant Numbers JP21H03456,
JP23K11211,JP23K11141.ThisisacooperationstudywithJapanRadioCo.,Ltd.
InstitutionalReviewBoardStatement:Notapplicable.
InformedConsentStatement:Notapplicable.
DataAvailabilityStatement:Somenon-publicdatasetsinthisstudywereprovidedbyJapanRadio
Co.,Ltd.
ConflictsofInterest:Theauthorsdeclarenoconflictsofinterest.
References
1. Hu,H.;Wen,Y.;Chua,T.S.;Li,X. Towardscalablesystemsforbigdataanalytics: Atechnologytutorial. IEEEAccess2014,
2,652–687.[CrossRef]
2. Zheng,Y.;Wu,W.;Chen,Y.;Qu,H.;Ni,L.M. Visualanalyticsinurbancomputing: Anoverview. IEEETrans. BigData2016,
2,276–296.[CrossRef]
3. Ma,Y.;Ping,K.;Wu,C.;Chen,L.;Shi,H.;Chong,D. ArtificialIntelligencepoweredInternetofThingsandsmartpublicservice.
Libr.HiTech2020,38,165–179.[CrossRef]
4. Engin,Z.;Treleaven,P. Algorithmicgovernment:Automatingpublicservicesandsupportingcivilservantsinusingdatascience
technologies. Comput.J.2019,62,448–460.[CrossRef]
5. Bertot,J.;Estevez,E.;Janowski,T. Universalandcontextualizedpublicservices:Digitalpublicserviceinnovationframework.
Gov.Inf.Q.2016,33,211–222.[CrossRef]
6. Nam,T.;Pardo,T.A. Smartcityasurbaninnovation: Focusingonmanagement,policy,andcontext. InProceedingsofthe
InternationalConferenceonTheoryandPracticeofElectronicGovernance,Tallinn,Estonia,26–28Septembre2011;pp.185–194.
7. Lee,P.;Hunter,W.C.;Chung,N. Smarttourismcity:Developmentsandtransformations. Sustainability2020,12,3958.[CrossRef]
8. Gan,Y.; Li,G.; Togo,R.; Maeda,K.; Ogawa,T.; Haseyama,M. Zero-shottrafficsignrecognitionbasedonmidlevelfeature
matching. Sensors2023,23,9607.[CrossRef][PubMed]
9. Zheng,Y.;Capra,L.;Wolfson,O.;Yang,H. Urbancomputing:Concepts,methodologies,andapplications. ACMTrans.Intell.
Syst.Technol.2014,5,1–55.[CrossRef]
10. Rezaei,Z.;Vahidnia,M.H.;Aghamohammadi,H.;Azizi,Z.;Behzadi,S. Digitaltwinsand3Dinformationmodelinginasmart
cityfortrafficcontrolling:Areview. J.Geogr.Cartogr.2023,6,1865.[CrossRef]
11. Li,X.;Lv,Z.;Hu,J.;Zhang,B.;Yin,L.;Zhong,C.;Wang,W.;Feng,S. Trafficmanagementandforecastingsystembasedon3dgis.
InProceedingsofthe201515thIEEE/ACMInternationalSymposiumonCluster,CloudandGridComputing,Shenzhen,China,
4–7May2015;pp.991–998.
12. Zhang,H.S.;Zhang,Y.;Li,Z.H.;Hu,D.C. Spatial-temporaltrafficdataanalysisbasedonglobaldatamanagementusingMAS.
IEEETrans.Intell.Transp.Syst.2004,5,267–275.[CrossRef]
13. Sebe,I.O.;Hu,J.;You,S.;Neumann,U. 3dvideosurveillancewithaugmentedvirtualenvironments. InProceedingsoftheFirst
ACMSIGMMinternationalworkshoponVideosurveillance,Berkeley,CA,USA,7November2003;pp.107–112.
14. Chao,Q.;Bi,H.;Li,W.;Mao,T.;Wang,Z.;Lin,M.C.;Deng,Z. Asurveyonvisualtrafficsimulation:Models,evaluations,and
applicationsinautonomousdriving. InComputerGraphicsForum;Wiley:Hoboken,NJ,USA,2020;Volume39,pp.287–308.
15. Gao,G.;Gao,J.;Liu,Q.;Wang,Q.;Wang,Y.Cnn-baseddensityestimationandcrowdcounting:Asurvey. arXiv2020,arXiv:2003.12783.
16. Kim,D.;Woo,S.;Lee,J.Y.;Kweon,I.S. Deepvideoinpainting. InProceedingsoftheIEEEconferenceonComputerVisionand
PatternRecognition,LongBeach,CA,USA,15–20June2019;pp.5792–5801.
17. Zeng,Y.;Fu,J.;Chao,H. Learningjointspatial-temporaltransformationsforvideoinpainting. InProceedingsoftheIEEE/CVF
EuropeanConferenceonComputerVision,Seattle,WA,USA,14–19June2020;pp.528–543.
18. Li, Z.; Lu, C.Z.; Qin, J.; Guo, C.L.; Cheng, M.M. Towardsanend-to-endframeworkforflow-guidedvideoinpainting. In
ProceedingsoftheIEEE/CVFConferenceonComputerVisionandPatternRecognition,NewOrleans,LA,USA,18–24June2022;
pp.17562–17571.

Sensors2024,24,3035 17of18
19. Jam,J.;Kendrick,C.;Walker,K.;Drouard,V.;Hsu,J.G.S.;Yap,M.H.Acomprehensivereviewofpastandpresentimageinpainting
methods. Comput.Vis.ImageUnderst.2021,203,103147.[CrossRef]
20. Qin,Z.;Zeng,Q.;Zong,Y.;Xu,F. Imageinpaintingbasedondeeplearning:Areview. Displays2021,69,102028.[CrossRef]
21. Zhang,H.;Mai,L.;Xu,N.;Wang,Z.;Collomosse,J.;Jin,H. Aninternallearningapproachtovideoinpainting. InProceedingsof
theIEEEInternationalConferenceonComputerVision,Seoul,RepublicofKorea,27October–2November2019;pp.2720–2729.
22. Milani,S.;Fontani,M.;Bestagini,P.;Barni,M.;Piva,A.;Tagliasacchi,M.;Tubaro,S. Anoverviewonvideoforensics. APSIPA
Trans.SignalInf.Process.2012,1,e2.[CrossRef]
23. Xu,R.;Li,X.;Zhou,B.;Loy,C.C. Deepflow-guidedvideoinpainting. InProceedingsoftheIEEEConferenceonComputerVision
andPatternRecognition,LongBeach,CA,USA,15–20June2019;pp.3723–3732.
24. Horn,B.K.;Schunck,B.G. Determiningopticalflow. Artif.Intell.1981,17,185–203.[CrossRef]
25. Beauchemin,S.S.;Barron,J.L. Thecomputationofopticalflow. ACMComput.Surv.1995,27,433–466.[CrossRef]
26. Lee,Y.J.;Kim,J.;Grauman,K. Key-segmentsforvideoobjectsegmentation. InProceedingsoftheIEEE/CVFInternational
ConferenceonComputerVision,Barcelona,Spain,6–13November2011;pp.1995–2002.
27. Mittal,A.;Soundararajan,R.;Bovik,A.C. Makinga“completelyblind”imagequalityanalyzer. IEEESignalProcess.Lett.2012,
20,209–212.[CrossRef]
28. Mittal,A.;Moorthy,A.K.;Bovik,A.C. No-referenceimagequalityassessmentinthespatialdomain. IEEETrans.ImageProcess.
2012,21,4695–4708.[CrossRef]
29. Venkatanath,N.;Praneeth,D.;Bh,M.C.;Channappayya,S.S.;Medasani,S.S. Blindimagequalityevaluationusingperception
basedfeatures. InProceedingsoftheNationalConferenceonCommunications,Mumbai,India,27February–1March2015;
pp.1–6.
30. Hemami,S.S.;Reibman,A.R. No-referenceimageandvideoqualityestimation: Applicationsandhuman-motivateddesign.
SignalProcess.ImageCommun.2010,25,469–481.[CrossRef]
31. Shahid,M.;Rossholm,A.;Lövström,B.;Zepernick,H.J. No-referenceimageandvideoqualityassessment:Aclassificationand
reviewofrecentapproaches. EURASIPJ.ImageVideoProcess.2014,2014,1–32.[CrossRef]
32. Zou,X.;Yang,L.;Liu,D.;Lee,Y.J. Progressivetemporalfeaturealignmentnetworkforvideoinpainting. InProceedingsofthe
IEEEConferenceonComputerVisionandPatternRecognition,Nashville,TN,USA,20–25June2021;pp.16448–16457.
33. Liu,G.;Dundar,A.;Shih,K.J.;Wang,T.C.;Reda,F.A.;Sapra,K.;Yu,Z.;Yang,X.;Tao,A.;Catanzaro,B. Partialconvolutionfor
padding,inpainting,andimagesynthesis. IEEETrans.PatternAnal.Mach.Intell.2022,45,6096–6110.[CrossRef][PubMed]
34. Chang,Y.L.;Liu,Z.Y.;Lee,K.Y.;Hsu,W.Learnablegatedtemporalshiftmodulefordeepvideoinpainting. arXiv2019arXiv:1907.01131.
35. Hu,Y.T.; Wang,H.; Ballas,N.; Grauman,K.; Schwing,A.G. Proposal-basedvideocompletion. InProceedingsoftheIEEE
EuropeanConferenceonComputerVision,Glasgow,UK,23–28August2020;pp.38–54.
36. Shao,M.;Zhang,W.;Zuo,W.;Meng,D. Multi-scalegenerativeadversarialinpaintingnetworkbasedoncross-layerattention
transfermechanism. Knowl.BasedSyst.2020,196,105778.[CrossRef]
37. Yu,B.;Li,W.;Li,X.;Lu,J.;Zhou,J. Frequency-awarespatiotemporaltransformersforvideoinpaintingdetection. InProceedings
oftheIEEEInternationalConferenceonComputerVision,Montreal,BC,Canada,11–17October2021;pp.8188–8197.
38. Lee,S.;Oh,S.W.;Won,D.;Kim,S.J.Copy-and-pastenetworksfordeepvideoinpainting. InProceedingsoftheIEEEInternational
ConferenceonComputerVision,Seoul,RepublicofKorea,27October–2November2019;pp.4413–4421.
39. Zhang,K.;Fu,J.;Liu,D. Flow-guidedtransformerforvideoinpainting. InProceedingsoftheIEEEEuropeanConferenceon
ComputerVision,TelAviv,Israel,23–27October2022;pp.74–90.
40. Wang, X.; Chan, K.C.; Yu, K.; Dong, C.; ChangeLoy, C. Edvr: Videorestorationwithenhanceddeformableconvolutional
networks. InProceedingsoftheIEEEconferenceonComputerVisionandPatternRecognitionWorkshops, LongBeach,CA,USA,
16–17June2019.
41. Chan, K.C.; Wang, X.; Yu, K.; Dong, C.; Loy, C.C. Basicvsr: Thesearchforessentialcomponentsinvideosuper-resolution
and beyond. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition, Nashville, TN, USA,
20–25June2021;pp.4947–4956.
42. Barron,J.L.;Fleet,D.J.;Beauchemin,S.S. Performanceofopticalflowtechniques. Int.J.Comput.Vis.1994,12,43–77.[CrossRef]
43. Dosovitskiy, A.; Fischer, P.; Ilg, E.; Hausser, P.; Hazirbas, C.; Golkov, V.; VanDerSmagt, P.; Cremers, D.; Brox, T. Flownet:
Learningopticalflowwithconvolutionalnetworks. InProceedingsoftheIEEEInternationalConferenceonComputerVision,
Santiago,Chile,7–13December2015;pp.2758–2766.
44. Hui,T.W.;Tang,X.;Loy,C.C.Liteflownet:Alightweightconvolutionalneuralnetworkforopticalflowestimation. InProceedings
oftheIEEEConferenceonComputerVisionandPatternRecognition,SaltLakeCity,UT,USA,18–22June2018;pp.8981–8989.
45. Ranjan,A.;Black,M.J. Opticalflowestimationusingaspatialpyramidnetwork. InProceedingsoftheIEEEconferenceon
ComputerVisionandPatternRecognition,Honolulu,HI,USA,21–26July2017;pp.4161–4170.
46. Bosse,S.;Maniry,D.;Müller,K.R.;Wiegand,T.;Samek,W. Deepneuralnetworksforno-referenceandfull-referenceimage
qualityassessment. IEEETrans.ImageProcess.2017,27,206–219.[CrossRef][PubMed]
47. Ye, P.; Doermann, D. No-reference image quality assessment using visual codebooks. IEEE Trans. Image Process. 2012,
21,3129–3138.[PubMed]
48. Fu,Y.;Wang,S. Anoreferenceimagequalityassessmentmetricbasedonvisualperception. Algorithms2016,9,87.[CrossRef]
49. Wang,Z.;Bovik,A.C. Reduced-andno-referenceimagequalityassessment. IEEESignalProcess.Mag.2011,28,29–40.[CrossRef]

Sensors2024,24,3035 18of18
50. Ma,C.;Yang,C.Y.;Yang,X.;Yang,M.H. Learningano-referencequalitymetricforsingle-imagesuper-resolution. Comput.Vis.
ImageUnderst.2017,158,1–16.[CrossRef]
51. Liu,S.;Zeng,Z.;Ren,T.;Li,F.;Zhang,H.;Yang,J.;Li,C.;Yang,J.;Su,H.;Zhu,J.;etal. Groundingdino:Marryingdinowith
groundedpre-trainingforopen-setobjectdetection. arXiv2023,arXiv:2303.05499.
52. Kirillov,A.;Mintun,E.;Ravi,N.;Mao,H.;Rolland,C.;Gustafson,L.;Xiao,T.;Whitehead,S.;Berg,A.C.;Lo,W.Y.;etal. Segment
anything. arXiv2023,arXiv:2304.02643.
Disclaimer/Publisher’sNote: Thestatements, opinionsanddatacontainedinallpublicationsaresolelythoseoftheindividual
author(s)andcontributor(s)andnotofMDPIand/ortheeditor(s).MDPIand/ortheeditor(s)disclaimresponsibilityforanyinjuryto
peopleorpropertyresultingfromanyideas,methods,instructionsorproductsreferredtointhecontent.
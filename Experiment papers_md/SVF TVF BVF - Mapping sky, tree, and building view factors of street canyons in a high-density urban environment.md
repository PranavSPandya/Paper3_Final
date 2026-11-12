Senseable City Lab :.:: Massachusetts Institute of Technology
This paper might be a pre-copy-editing or a post-print
author-produced .pdf of an article accepted for publication. For
the definitive publisher-authenticated version, please refer
directly to publishing house’s archive system
SENSEABLE CITY LAB

(cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
ContentslistsavailableatScienceDirect
Building and Environment
journal homepage: www.elsevier.com/locate/buildenv
Mapping sky, tree, and building view factors of street canyons in a high-
(cid:55)
density urban environment
Fang-Ying Gonga,b,∗, Zhao-Cheng Zengc, Fan Zhangd, Xiaojiang Lie, Edward Nga,f,g,
Leslie K. Norfordb
aSchoolofArchitecture,TheChineseUniversityofHongKong,ShatinNT,HongKong
bDepartmentofArchitecture,MassachusettsInstituteofTechnology,Cambridge,MA,USA
cDivisionofGeologicalandPlanetarySciences,CaliforniaInstituteofTechnology,Pasadena,CA,USA
dInstituteofSpaceandEarthInformationScience,TheChineseUniversityofHongKong,ShatinNT,HongKong
eSenseableCityLaboratory,MassachusettsInstituteofTechnology,Cambridge,MA,USA
fInstituteofEnvironment,EnergyandSustainability,TheChineseUniversityofHongKong,ShatinNT,HongKong
gInstituteofFutureCities,TheChineseUniversityofHongKong,ShatinNT,HongKong
A R T I C L E I N F O A B S T R A C T
Keywords: Viewfactorsforsky,trees,andbuildingsarethreeimportantparametersoftheurbanoutdoorenvironmentthat
Viewfactor describe the geometrical relationship between different surfaces from the perspective of radiative energy
GoogleStreetView transfer.Thisstudydevelopsanapproachforaccuratelyestimatingskyviewfactor(SVF),treeviewfactor(TVF),
Deeplearning andbuildingviewfactor(BVF)ofstreetcanyonsinthehigh-densityurbanenvironmentofHongKongusing
Streettrees
publicly available Google Street View (GSV) images and a deep-learning algorithm for extraction of street
Streetcanyon
features (sky, trees, and buildings). As a result, SVF, TVF, and BVF maps of street canyons are generated.
Highdensity
Verificationusingreferencedataofhemisphericphotographyfromfieldsurveysincompacthigh-riseandlow-
riseareasshowsthattheGSV-basedVFestimateshaveasatisfyingagreementwiththereferencedata(allwith
R2>0.95),suggestingtheeffectivenessandhighaccuracyofthedevelopedmethod.Thisisthefirstreported
useofhemisphericphotographyfordirectverificationinaGSV-basedstreetscapestudy.Furthermore,acom-
parisonbetweenGSV-basedand3D-GIS-basedSVFsshowsthatthetwoSVFestimatesaresignificantlycorrelated
(R2=0.40,p<0.01)andshowbetteragreementinhigh-densityareas.However,thelatteroverestimatesSVF
by0.11onaverage,andthedifferencesbetweenthemaresignificantlycorrelatedwithstreettrees(R2=0.53):
themorestreettrees,thelargerthedifference.Thissuggeststhatalackofstreettreesina3D-GISmodelofstreet
environmentsisthedominantfactorcontributingtothelargediscrepanciesbetweenthetwodatasets.
1. Introduction subtendedbyahorizontalsurface[4,5].Athoroughquantificationand
understandingofthephysicalstreetscapeusingVFs,includingitsfea-
The urban thermal environment has practical implications for en- tures and dynamics, offers great utility to urban planners and clima-
ergyconsumption,humancomfortandproductivity,airpollutionatthe tologists investigating the urban environment, its physical and social
streetlevel,andurbanecology[1,2].Itisinfluencedbythegeometryof interactions,andimplicationsforhumanwell-being.
street canyons, street trees, building blocks and impervious ground SVF,ageometricquantificationofthedegreeofskyvisibilitywithin
covers[3].Streetviewfactors(VFs)forthesky,trees,andbuildingsare street canyons, is a commonly used indicator for describing urban
three important parameters of urban outdoor environments. They de- geometry. As an effective indicator of nocturnal urban radiation bal-
scribe the geometrical relation between different urban street compo- ance,SVFcharacterizestheratioofreceived(oremitted)radiationby
nentsfromtheperspectiveofradiativeenergytransferthatplaysakey anurbanstreettothetotalradiationemitted(orreceived)bytheentire
role inurbanthermal environments. Skyviewfactor(SVF),treeview hemisphericradiationenvironment[6].Therefore,SVFisanimportant
factor (TVF), and building view factor (BVF) are defined as the geo- geometrical parameter for the studies of urban microclimate [7,8],
metric ratio of the amount of the sky, trees, and buildings seen, re- nocturnalurbanheatisland(UHI)effect[9,10],urbanthermalcomfort
spectively, from a given surface point to the overlying hemisphere [7–11],andurbanairpollution[12].Streettreecanopy,quantifiedby
∗Correspondingauthor.Rm505,AITBuilding,SchoolofArchitecture,TheChineseUniversityofHongKong,ShatinNT,HongKong.
E-mailaddresses:fangying@link.cuhk.edu.hk,gongfy@mit.edu(F.-Y.Gong).
https://doi.org/10.1016/j.buildenv.2018.02.042
Received8December2017;Receivedinrevisedform2February2018;Accepted26February2018
(cid:36)(cid:89)(cid:68)(cid:76)(cid:79)(cid:68)(cid:69)(cid:79)(cid:72)(cid:3)(cid:82)(cid:81)(cid:79)(cid:76)(cid:81)(cid:72)(cid:3)(cid:19)(cid:25)(cid:3)(cid:48)(cid:68)(cid:85)(cid:70)(cid:75)(cid:3)(cid:21)(cid:19)(cid:20)(cid:27)
(cid:19)(cid:22)(cid:25)(cid:19)(cid:16)(cid:20)(cid:22)(cid:21)(cid:22)(cid:18)(cid:3)(cid:139)(cid:3)(cid:21)(cid:19)(cid:20)(cid:27)(cid:3)(cid:40)(cid:79)(cid:86)(cid:72)(cid:89)(cid:76)(cid:72)(cid:85)(cid:3)(cid:47)(cid:87)(cid:71)(cid:17)(cid:3)(cid:36)(cid:79)(cid:79)(cid:3)(cid:85)(cid:76)(cid:74)(cid:75)(cid:87)(cid:86)(cid:3)(cid:85)(cid:72)(cid:86)(cid:72)(cid:85)(cid:89)(cid:72)(cid:71)(cid:17)

F.-Y.Gongetal. (cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
Nomenclature TVF Treeviewfactor
UHI Urbanheatisland
Symbolsandabbreviations URL Uniformresourcelocator
VF Viewfactor
3D-GIS Three-dimensiongeographicinformationsystem xp, y
p
Coordinatesofthecylindricalpanorama
API Applicationprogramminginterface xf, y
f
Coordinatesofthefisheyeimage
BVF Buildingviewfactor Cx, Cy Coordinatesofthecenterpixelonthefisheyeimage
CNN Convolutionalneuralnetwork Hp Heightofthepanoramaimage
DSM Digitalsurfacemodel Wp Widthofthepanoramaimage
FCN Fullyconvolutionalnetwork R2 Coefficientofdetermination
GSV GoogleStreetView αi, x Angularwidthofpixelsoffeaturex(xcanbesky,tree,or
H/W Building-height-to-street-width building)inthei thring
PSPNet Pyramidsceneparsingnetwork Ψx Viewfactorforsky,tree,andbuildingwhenxisspecified
RMSE Root-mean-squareerror r0 Radiusofthefisheyeimage
SVF Skyviewfactor
TVF, has instrumental ecological service functions such as UHI miti- andaccuratemeasurementofSVF[28,29].However,takingon-site
gationduetoitscontributiontoreducingurbantemperature[13–16]. fisheye images usually requires fieldwork that is time- and effort-
The trees' cooling effect comes from tree shading, which reduces the consuming. Therefore, this method is suitable only for small-scale
radiationreachinggroundlevel[17,18],andevaporativecoolingfrom study;
leaf surfaces [19]. In addition, urban street trees have been found to 2) Model simulation. This method can produce spatially continuous
absorbairbornepollutionandthereforedecreaseroadtrafficemissions VFs based on vectored buildings and rasterized digital 3D surface
[20] and improve the walkability of streets [21]. Therefore, the pro- models [30–33]. However, model data are difficult to accurately
portion of street tree cover can be used to evaluate the benefits from generateandarethereforenotalwaysavailable.TheaccuracyofVF
ecosystem service provisions in different areas of a city [22]. Many estimations using model simulations depends heavily on the accu-
urbanmaterialsforbuildingshavearelativelyhighheatcapacityand racy of the model in simulating the street environment. However,
surface thermal admittance, which make them efficiently accept and the street environment can be very complex, such as those in the
retainheatduringdaytimeandreleaseitatnight,leadingtoastrong high-densityurbanareasofHongKong.Inparticular,thestreettree
UHI effect [23,24]. This study uses BVF to quantify the impact of canopy,amajorcomponentofstreetscapes,ishardtoparameterize
buildingsontheurbanradiativebalance.ThesethreeVFsinteractwith inmodels;
eachotherinbalancingurbanradiation.SVFisacombinationfactorof 3) Street-sensing method based on street-view panoramas. This re-
buildingsandtreesthatinfluencestheairtemperature[25].Streettrees cently proposed concept uses publicly and freely accessible street
reduceSVFbyprovidingshadingtotheenvironment,resultinginthe panoramic photographs, e.g. Google Street View (GSV) images, to
reductionofnighttimenetlongwaveloss[26].Buildingsemitagreater deriveVFsofstreetcanyonsbyprojectingthepanoramaintofisheye
amountoflongwaveradiationcomparedtothecoolskyandtrees[27]. images [34–37]. Since GSV images directly capture urban streets-
Therefore, urban street canyons with ahigher BVF will yield a larger capeandareavailableinmanycitiesallovertheworld,thismethod
netlongwaveradiation. providesalowcostandeffectivestreetscapemappingapproachfor
MethodsforestimatingVFsofurbanstreetcanyonscanbegrouped urbanstudies.
intothefollowingthreetypes:
Lietal.[34]showedtwoexamplesdemonstratingtheusageofGSV
1) Photographicmethod.Thismethodusesafish-eyelenstotakeon- images in mapping street tree and openness, while Liang et al. [35]
site photographs that project the hemispheric environment onto a providedaproof-of-conceptstudytoshowthereliabilityofusingstreet
circularplane.Differentstreetfeaturesarethenextractedfromthe panoramaimagesinestimatingSVF.Carrasco-Hernandezetal.(2015)
fisheye image to calculate the VFs. This method provides a direct proposed using the GSV images to calculate the street-level total
Fig.1.AnexampleofthedeepstreetcanyonintheMongKokarea(showninFig.2),oneofthetypicalhigh-densityhigh-riseurbanareasofHongKong.(Source:GSV,2016).
(cid:20)(cid:24)(cid:25)

F.-Y.Gongetal. (cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
shortwave irradiance based on urban canyon geometries estimated 2. Methods
from an open-source panorama generating tool [36]. Middel et al.
(2017) used GSV-estimated SVF to verify the synthetic hemispherical 2.1. Studyarea
fisheye photos at fine spatial resolution generated from a developed
web-basedtoolusingGoogleEarth3Ddataforurbanareas[37]. Hong Kong, situated on the coastline of southeastern China (see
However,thepreviousstudyareasmainlyfocusonthecitieswhere Fig.2),isoneofthemostdensely-populatedandbuilt-upcitiesinthe
streetscape features are relatively simple (compared to high-density world. It has a population of over seven million living in around
urbanareasofHongKonginthispaper)withwell-definedbuildingand 262km2ofdevelopedland[39,40].TheclimateofHongKongissub-
streetstructures.ThefeasibilityanduncertaintyofusingGSVforesti- tropical maritime, which features hot and humid summers and warm
matingSVFinsuchhigh-densitycontext,arestillnotclear.HongKong, winters [41]. Moreover, high-density urban areas of Hong Kong are
located in monsoon Asia, has a high-rise, high-density, and compact characterized by high-rise compact building blocks and deep street
urban morphology with high building-height-to-street-width (H/W) canyons withahighH/Wratio.Intheseareas, tallbuildings ofsome
ratio[38].Atypicalstreetinhigh-densityurbanareasofHongKongis 40-60 stories lining narrow streets of 15–25m width have been the
characterized by high-rise buildings, narrow compacted streets, inter- norm. Serious issues related to human thermal comfort [42], air pol-
ferences of heavy travel volume and pedestrian flow, and complex lution [43] and the UHI effect [44] due to its climate and urban
streetscapes with the amount of colorful overhanging signboards that morphologies have been primary planning concerns. As effective in-
block sunlight and air paths and provide limited openness to the sky dicators for characterizing urban streetscapes, street VFs have been
(seeFig.1).AneffectiveandaccuratemethodformappingtheVFsof widelyincorporated inmodelingtoaddresstheseconcerns.However,
the street canyons in Hong Kong is therefore crucial for studying its an assessment of the accuracy of VF estimations, which is crucial for
urbanclimateandassessingtherelevantoutdoorthermalcomfort. quantifyingtheuncertainty ofmodels,isstilllackingduetoalackof
Thepurposeofthisstudyistodevelopanapproachforestimating measurements.
and mapping SVF, TVF, and BVF of street canyons in complex urban Inthisstudy,high-densityurbanregionsofKowloonandHongKong
living environments, such as the high-density urban areas of Hong Islandarechosenasourstudyarea,asshowninFig.2.Thisareaisone
Kong. The approach is based on GSV images and a deep-learning ofthemostdenselybuiltandpopulatedareasintheworld,withamean
techniqueforstreetfeatureextractionandisverifiedusinghemispheric building height of 27m, a standard deviation of 30.7m, and a popu-
photography measurements as reference data from fieldwork. This lationdensityofaround42,900personsperkm2.AsshowninFig.2(c),
verificationis,toourknowledge,thefirstreporteduseofhemispheric the building heights are grouped into high-rise (>25m), mid-rise
photographyfordirectverificationofGSV-basedstreetscapestudy.The (15–25m) and low-rise (<15m), according to local climate zone
developed approach represents a ground-based perspective of city classificationinHongKongurbanareas[45,46].Mosthigh-risebuild-
streetscapes thatcover complicatedurban contexts,including treeca- ingsaredistributedinsouthernKowloonandnorthernHongKongIs-
nopy cover, building overhangs, and shade structures. A comparison land.
withconventional3DmodelingofSVF,whichhasbeenwidelyusedin
previous studies, is also conducted to assess the uncertainty and ad-
vantagesofthisGSV-basedmappingapproach. 2.2. GSV-basedSVF,TVFandBVFestimates
Inthisstudy,weusepubliclyaccessibleGSVimagestoestimatethe
SVF, TVF, and BVF of street canyons in high-density urban areas of
HongKong.Streetpanoramaimagessampledat30mintervalsarefirst
Fig.2.(a)LocationofHongKong(yellowcircle)insouth-easternChina;(b)High-densityurbanareasinHongKong,asoutlinedinyellow,includingKowloonandnorthernHongKong
Island;(c)Buildingdensitymap,includingdistributionandheight,overlaidwithstreetsingrey.ThebuildingandstreetdataareextractedfromtheB5000mapsseriesbytheHongKong
LandsDepartment.Thedottedredandbluerectanglesoutlinethefieldsurveyregionsforhigh-riseandlow-riseregions,respectively,asdescribedinSection3.3.Theblackstaristhe
locationofthestreetcanyonexampleinMongKokshowninFig.1.(Forinterpretationofthereferencestocolorinthisfigurelegend,thereaderisreferredtotheWebversionofthis
article.)
(cid:20)(cid:24)(cid:26)

F.-Y.Gongetal.
(cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
filteredout.ExamplesofGSVimagesinhigh-riseandlow-riseareasare
| collected using | the GSV API | [47,48] based on the | latitudes and | long- |     |     |     |     |     |     |
| --------------- | ----------- | -------------------- | ------------- | ----- | --- | --- | --- | --- | --- | --- |
itudes of the sampling points. Extraction of features, including sky, showninFig.3(a).
trees,andbuildings,isimplementedusingthesceneparsingmethodin
| a deep-learning | framework | [49,50]. We then project | the panorama |     |     |     |     |     |     |     |
| --------------- | --------- | ------------------------ | ------------ | --- | --- | --- | --- | --- | --- | --- |
imagesfromcylindricaltoazimuthalprojectiontogeneratethefisheye 2.2.2. Extractionsofstreetfeaturesusingdeep-learningtechniques
images. From the fisheye images, VFs are calculated by applying the Weproposetheuseofthesceneparsingmethodinadeep-learning
classical photographic method [4]. Fig. 3 shows the workflow proce- frameworktoextractstreetfeatures,includingsky,trees,andbuildings,
dureforVFcalculationsusingthismethod,andadetaileddescriptionis fromtheGSVimages.Thedeep-learningmodelemployedinthisstudy
isthePyramidSceneParsingNetwork(PSPNet)[49].Inessence,scene
asfollows.
parsingsegmentsandparsesanimageintodifferentimageregionsas-
sociatedwithsemanticcategories,includingsky,trees,andbuildings.
2.2.1. CollectingGSVpanoramaimages Deep learning based on the deep convolutional neural network
Wesampledpointsat30mintervalsalongthestreetlinesshownin (CNN) allows computational models that are composed of multiple
Fig.2(c),usingGISsoftware.Thereisatotalof33,544samplepointsin processinglayerstolearnrepresentationsofnaturaldatawithmultiple
inimageclassification
the study area. We collected the GSV panorama images for all the levels ofabstraction andhasbeenwidelyused
sampledpointsinthefollowingways: and pattern recognition [51]. Enabled by the proliferation of deep-
learningtechniques,anumberofCNN-basedmodelsforsemanticscene
(1) ObtainpanoramaimageIDataspecificlocationusingthefollowing parsing,suchasunderstandingstreetfeatures,havebeenproposedand
URL: haveachievedoutstandingperformance[52–54].Comparedwithpre-
viouswork,thearchitectureofPSPNetpaysmoreattentiontofeature
https://maps.googleapis.com/maps/api/streetview/metadata? ensembling and structure prediction, to integrate global context in-
size=400x400&location=LAT,LON&heading=HEADING&fov=FOV& formationintothepredictionprocess.ThePSPNetmodelemployedin
pitch=PITCH&key=APIKey this study provides a fully convolutional network (FCN)-based pixel
difficult
where LAT and LON are the latitude and longitude, respectively, prediction framework that is superior for processing scenery
field
FOV (90 by default) determines the horizontal of view of the context features. Itisapractical system forstate-of-the-art scenepar-
image, HEADING(0 bydefault)indicates thecompass heading ofthe sing andsemantic segmentation where allcrucial implementation de-
specifies
camera, PITCH (0 by default) the up or down angle of the tailsareincluded[49].PSPNetusesapre-trainedsemanticsegmenta-
camerarelativetothestreetviewvehicle,andAPIkeyisthecredential tionnetworkbasedontheADE20Kdataset.Whenevaluatingprediction
requiredtoauthenticatetherequest. accuraciesonvariousdatasets,itachievesstate-of-the-artperformance
|     |     |     |     | and outperforms | many other | models | in  | the semantic | scene | parsing |
| --- | --- | --- | --- | --------------- | ---------- | ------ | --- | ------------ | ----- | ------- |
(2) DownloadtilesofapanoramaimageusingthefollowingURL: framework.Inparticular,itachievesahighaccuracyof80.2%inpre-
|     |     |     |     | dicting 150 object | classes | of cityscapes, | a   | dataset | for semantic | urban |
| --- | --- | --- | --- | ------------------ | ------- | -------------- | --- | ------- | ------------ | ----- |
http://cbk0.google.com/cbk?output=tile&panoid=PANO_ID& sceneunderstandingcollectedfrom50citiesindifferentseasons.
zoom=5&x=I&y=J Fig.4showstheworkflowofsemanticsceneparsingusingPSPNet.
ThedownloadedandcombinedGSVpanoramaimageisfirstresampled
| wherePANO_IDisobtained |     | fromtheabovestep;andI(from0 |     | to  |     |     |     |     |     |     |
| ---------------------- | --- | --------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
25)andJ(from0to12)aretherowsandcolumnindicesoftheimage into473 946 pixels.Thepanoramaimageisthenseparatedintotwo
tile. We can get a complete panorama image by combining 26×13 images w×ith 473 473 pixels, a size required by the deep-learning
tiles. Invalid GSV images, including those with empty content, are module,beforecon×secutivelyinputtingthetwoimagesintothePSPNet,
|     |     |     |     |     |     | Fig. | 3.Workflow | procedure | for VF | calculations |
| --- | --- | --- | --- | --- | --- | ---- | ---------- | --------- | ------ | ------------ |
usingGSVimages,illustratedbytakingtwoex-
|     |     |     |     |     |     | amples | from | high-rise and | low-rise | areas. (a) |
| --- | --- | --- | --- | --- | --- | ------ | ---- | ------------- | -------- | ---------- |
PanoramaimagesdownloadedfromGoogleser-
versusingcoordinatesofsamplingstreetpointsas
inputs.(b)Extractionofsky(inblue),trees(in
|     |     |     |     |     |     | green), | and buildings | (in | grey) using | the scene |
| --- | --- | --- | --- | --- | --- | ------- | ------------- | --- | ----------- | --------- |
parsingdeep-learningtechnique[49].(c)Fisheye
|     |     |     |     |     |     | images | obtained | by projecting | the | panorama |
| --- | --- | --- | --- | --- | --- | ------ | -------- | ------------- | --- | -------- |
imagesfromcylindricalprojectiontoazimuthal
fisheye
|     |     |     |     |     |     | projection. | Based     | on the    |              | image of ex- |
| --- | --- | --- | --- | --- | --- | ----------- | --------- | --------- | ------------ | ------------ |
|     |     |     |     |     |     | tracted     | features, | SVF, TVF, | and BVF      | are calcu-   |
|     |     |     |     |     |     | lated       | using the | classical | photographic | method       |
developedbyJohnsonandWatson[4].There-
|     |     |     |     |     |     | sulted       | VF estimates | are            | also indicated. | (For in-      |
| --- | --- | --- | --- | --- | --- | ------------ | ------------ | -------------- | --------------- | ------------- |
|     |     |     |     |     |     | terpretation | of           | the references | to              | color in this |
figurelegend,thereaderisreferredtotheWeb
versionofthisarticle.)
(cid:20)(cid:24)(cid:27)

F.-Y.Gongetal.
(cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
Fig.4.WorkflowofsemanticsceneparsingusingPSPNet.Foragiveninputstreetviewimagein(a),thenetworkextractsthefeaturemapin(b),andthenthepyramidparsingmoduleis
appliedtoformthefinalfeaturerepresentationofthestreetscapein(c).Finally,apixel-wiseclassifiedoutputstreetviewimagewithsemanticcategoriesin(d)isproducedbyfeedingthe
featurerepresentationintoaconvolutionlayer.
asshowninFig.4(a).PSPNetusesCNNtogetthefeaturemapofthe untilthefisheyeimageisfullyconstructed.
| last convolutional | layer as | shown in Fig. 4 | (b). A pyramid | parsing |     |     |     |     |     |
| ------------------ | -------- | --------------- | -------------- | ------- | --- | --- | --- | --- | --- |
moduleisappliedtoharvestdifferentsub-regionrepresentationsofthe
|     |     |     |     |     | (2) CalculationsofVFs |     |     |     |     |
| --- | --- | --- | --- | --- | --------------------- | --- | --- | --- | --- |
image,followedbyup-samplingandconcatenationlayerstoformthe
finalfeaturerepresentationofthestreetscape,whichcarriesbothlocal
TocalculateVFswiththefollowingEquation(3)basedonJohnson
fisheye
and global context information, as illustrated in Fig. 4 (c). It fuses and Watson [4], we divide the image into a number of con-
different
features under four pyramid scales with bin sizes of 1 1, centricannuliofequalwidth,andthensumupalltheannularsections
2 2,3 3, and6 6, respectively. Finally, the representation is×fed representingthesky,trees,andbuildingstocalculatetheSVF,TVFand
in×to a co×nvolution l×ayer to get the final per-pixel prediction and pro- BVF,respectively,usingthefollowingformula:
duceapixel-wiseclassifiedstreetviewimagewithsemanticcategories
n
in Fig . 4 ( d ) . T h e s i ze o fo u t p u t im a g e s i sa l s o 4 7 3 4 7 3 pi x el s , i n cl ud e s 1 π πi(2 1)
|     |     |     |     |     | Ψx  | sin sin | αi,x |     |     |
| --- | --- | --- | --- | --- | --- | ------- | ---- | --- | --- |
1 50 c la ss i fi c a t io n s , an d f e a t u re s o f t h e s k y , t r ee×s, a n d b u i ld i n g s a re 2π 2n ⎡ 2n− ⎤ (3)
|     |     |     |     |     | =   | ∑i 1 |     |     |     |
| --- | --- | --- | --- | --- | --- | ---- | --- | --- | --- |
extracted and calculated in this study. Using a workstation with an = ⎣ ⎦
wherexcanbesky,tree,orbuilding;nisthetotalnumberofrings(here
eight-coreCPUandanNVIDIA1080TiGPU(12GRAM),ittookabout weuse100);i(from1to100)istheindexofthering;ai,x istheangular
finish
20h to the 33,544 images, roughly two seconds per panorama widthofpixelsoffeaturex(xcanbesky,tree,orbuilding)inthei th
image.TVFisgeneraldefinitionvegetation,includinggrassandtrees.
ring.ExamplesofthegeneratedfisheyeimagesareshowninFig.3(c).
| Based on | the calculation results | of 33,544 | GSV images using | deep |     |     |     |     |     |
| -------- | ----------------------- | --------- | ---------------- | ---- | --- | --- | --- | --- | --- |
TheSVF,TVF,andBVFquantifythefractionsofsky,trees,andbuild-
learning,valuesofbothSVFandTVFthatarezerowillbefiltered,as
ings,respectively,ofthebuiltenvironmentseenfromaparticularob-
| these points | are distributed | indoors or in tunnels | after checking | the |     |     |     |     |     |
| ------------ | --------------- | --------------------- | -------------- | --- | --- | --- | --- | --- | --- |
servationpointonthegroundwithinthebuiltenvironment.
originalGSVimages.Thestudyusesthefiltered29,264GSVimagesfor
furtheranalysis.ExamplesoftheextractedfeaturesareshowninFig.3
|     |     |     |     |     | 2.2.4. | AccuracyassessmentoffeatureextractionfromGSVimagesbydeep- |     |     |     |
| --- | --- | --- | --- | --- | ------ | --------------------------------------------------------- | --- | --- | --- |
(b).
learningtechnique
Toassesstheaccuracyofthesceneparsingdeep-learningtechnique
2.2.3. ProjectionintofisheyeimagesandcalculationsofVFs inextractingstreetscenes,especiallyfortheVFsofthesky,trees,and
|     |     |     |     |     | buildings, | the focus of this | study, we | randomly select | 100 sampled |
| --- | --- | --- | --- | --- | ---------- | ----------------- | --------- | --------------- | ----------- |
(1) Projectionintofisheyeimages
streetpointsandcollecttheircorrespondingGSVimages.The100se-
|     |     |     |     |     | lected | samples are randomly | distributed | in the study | area and cover |
| --- | --- | --- | --- | --- | ------ | -------------------- | ----------- | ------------ | -------------- |
Weusethephotographicmethod,whichappliesafisheyelenstothe
|     |     |     |     |     | low-to-high | buildingdensities | (see Fig. | A.1), indicating | these samples |
| --- | --- | --- | --- | --- | ----------- | ----------------- | --------- | ---------------- | ------------- |
different
panorama image, in order to project the hemispheric environment represent characteristics of street canyons and street trees.
(cylindricalprojection)ontoacircularplane(azimuthalprojection)and Manualdelineationoftheimagesbyeyeinspectionisimplementedto
generatethefisheyeimageinthefollowingway[34].Thisprojectionis
extracttheskyfeaturetogenerateareferencedataset(astruth).Asa
implementedbyconstructingarelationshipbetweenpixels(xf , y )ona result,Fig.5showsthecomparisonofcalculatedVFsfromGSVimages
f
fisheyeimageand(xp , y )onapanoramaimage,givenby, basedonthedeep-learningtechniqueandthegeneratedreferencedata.
p
Thetwodatasetsnearlyexactlyagreewitheachother,withR2ashigh
1x
( π y/ 2 Ct a n x [ ( f C C π y ) / ( Wf x ) ] ) p / 2 , f x a s 0 . 97 4 an d R M S E o f 0. 0 3 6f o rS V F ,R 2 o f 0 .9 8 6 a n d R M S E o f 0 . 0 2 5 fo r
| xp     | −                               |                    |       |     |     |     |     |     |     |
| ------ | ------------------------------- | ------------------ | ----- | --- | --- | --- | --- | --- | --- |
| ⎧( 3 π | y/ 2 +− Ct a n x 1x [ ( C − C π | ) / ( × Wf < ) ] ) | / 2 , |     |     | 2   |     |     |     |
= f y x p f x (1) T V F , an d R o f 0 .9 8 3 a n d R M S E o f 0 .0 3 7 f o r B V F . T h is a g r e e m e n t
| ⎨   | +− − − | × > |     |     |     |     |     |     |     |
| --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
⎩ suggests that the scene parsing deep-learning technique is able to ac-
curatelyextractthestreet-levelfeaturesinhigh-densityurbanareasof
Cx)2 Cy)2/r0
| y p (xf | (y f | Hp  |     |     | HongKong. |     |     |     |     |
| ------- | ---- | --- | --- | --- | --------- | --- | --- | --- | --- |
| =⎜⎛     |      | ⎟⎞  |     | (2) |           |     |     |     |     |
|         | −+−  | ×   |     |     |           |     |     |     |     |
| ⎝       |      | ⎠   |     |     |           |     |     |     |     |
where and are the width and height of the panorama image, 2.3. 3D-GIS-basedSVFestimates
| Wp              | Hp                                   |     |     |     |     |     |     |     |     |
| --------------- | ------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- |
| respectively;r0 | istheradiusofthefisheyeimage;and(Cx, |     |     |     |     |     |     |     |     |
|                 | Wp/2π                                |     |     | Cy) |     |     |     |     |     |
are the coord=inates of the center pixel on the fisheye image; Thehigh-resolution3D-GIS-based SVFestimateofHongKongwas
Wp/2π.First,anemptyfisheyeimageisinitializedwithco- developedbyChenetal.(2012)[32]tostudyHongKong'surbanmi-
Cx Cy
ord=inate=s(xf , y f ). By using equations (1) and (2), each pixel with co- croclimate.The3D-GISModelisgeneratedinageographicinformation
ordinateof(xf ,y f )isthenuniquelyconnectedtoapixelwithcoordinate system (GIS) by using a 3D building database (with building height
of(xp , y )inthepanoramaimage.Lastly,thepixelvaluein(xf , y )can information)mergedwiththetopographydatabasetocreateadigital
| p   |     |     |     | f   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
beassignedbythatin(xp ,y )andthisprocessisrepeatedforeachpixel elevation layer representing the height of the urban surface in Hong
p
(cid:20)(cid:24)(cid:28)

F.-Y.Gongetal. (cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
verificationmethodsarebothtimeandeffortconsuming[32];(2)the
GSV-based method makes it possible to map the SVF at street level
across the whole city, and therefore, as this study shows, a compre-
hensive verification of the 3D-GIS model can be conducted. The un-
derstandingofthediscrepanciesbetweenGSV-basedand3D-GIS-based
SVF estimates sheds light on future improvement in the model simu-
lationofcomplexurbanenvironments.
3. Results
3.1. MappingSVF,TVF,andBVFofstreetcanyonsusingGSVimages
Fig. 6 shows the spatial distributions of GSV-based SVF, TVF, and
BVFestimatesinhigh-densityurbanareasinKowloonandHongKong
Island, and a comparison of their frequency distributions. The mean
SVF,TVF,andBVFvaluesinhigh-densityareasofHongKongare0.49,
0.14, and 0.33, respectively, and there are small differences between
Kowloonarea(0.53,0.12,and0.41)andHongKongIsland(0.41,0.19,
and 0.36). The SVF value ranges from near 0, indicating little sky
openness,to1.0,indicatingtotalskyopenness.Ingeneral,wefoundthe
Fig.5.AccuracyassessmentoffeatureextractionusingthePSPNetinadeep-learning spatial patterns of VF estimates are similar and consistent with the
frameworktocalculateSVF,TVF,andBVFfromGSVimagesinhigh-densityurbanareas correspondingbuildingheightanddensity(seeFig.2(c)).Areaswith
ofHongKong.TheR2andRMSEbetweenthetwodatasetsofVFsarealsoindicated.
higher density have lower SVF, lower TVF and higher BVF, and vice
versa. The high-density residential areas, located in southern and
Kong.Both3Dbuildingandtopographydatabasesareprovidedbythe western Kowloon andnorthern Hong KongIsland, which cover about
Hong Kong Planning Department. Continuous SVF values at 2 m re- 58% of the study area, are dominated by low and moderate SVF
solution are calculated for an entire urban environment. The SVF is (0.2–0.6), and low TVF (0.0–0.3), because of the high-density con-
calculatedbyfirstconstructingafisheyeimageandthenestimatingthe structionandnarrowstreetsthatblockskyvisibilityandlimitspacefor
SVF value using Equation (3) based on Johnson and Watson [4], the greenery.Thecoastlineregionsandlow-riseareas,whichcoverabout
samemethodusedwithGSVimagesasdescribedinSection2.2. 20%ofthestudyarea,showmuchhigherSVF(0.7–1.0),andlowerBVF
In this study,SVF estimatesfrom the3D-GIS model arecompared (0.0–0.3),becauseoffewerbuildingsandmoreskyopenness.
with those from GSV, as described in Section 3.3, for the purpose of In low-rise regions near country parks in the southern part of the
assessing the accuracy of urban 3D-GIS model in simulating urban study area in Hong Kong Island where BVF is low (e.g., the dotted
street environments under high-density contexts. This comparison is rectangles in Fig. 6), the SVF values, however, are in a much lower
important because: (1) 3D-GIS models have been widely used to esti- range(0.0–0.2;Fig.6(c)).Themuchlowerskyopenness,aswediscuss
matethestreetgeometricstructures,includingSVF,butacomprehen- later,ismainlyduetohightreecoverinthisarea(Fig.6(b)),which
siveverificationinawideregionisnotpossiblebecauseconventional blocksmuchoftheskyvisibility.Furtheranalysisoftheimpactoftree
cover is described in Section 3.4. Fig. 6 (d) shows the frequency
Fig.6.MapsofGSV-basedSVFin(a),TVFin
(b),andBVFin(c)ofstreetcanyonsinhigh-
densityurbanareasofHongKongderivedfrom
29,264 GSV images along streets at 30m in-
tervals; (d) Frequency density of SVF (blue
bar),TVF(greenbar),andBVF(greybar).(For
interpretationofthereferencestocolorinthis
figurelegend,thereaderisreferredtotheWeb
versionofthisarticle.)
(cid:20)(cid:25)(cid:19)

F.-Y.Gongetal. (cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
distribution of the VFs in Hong Kong. The TVF in the high building riseareasthaninlow-risebuildingareas,indicatingthatmodelsimu-
densityareaisdominatedbyvalueslessthan0.1andthemeanvalueis lation performs betterinhigh-rise building areas. Moreover, forGSV-
0.143.ThelowTVFismainlylimitedbythehighbuildingdensityand basedestimates,R2andRMSEforTVF(Fig.8(b))are0.987and0.027,
narrow streets. This mean TVF is smaller compared with Singapore respectively, and for BVF (Fig. 8 (c)) they are 0.986 and 0.036, re-
(0.293), a sub-tropical Asian city with high building and population spectively.TheseresultssuggestthataGSV-basedstreetscapestudyis
densities,andissimilartoNewYork(0.135),atypicalhigh-densitycity effective and accurate in high-density urban areas of Hong Kong,
intheUnitedStates[55].SVF,ontheotherhand,isclosetoaneven characterized by compact high-rise areas with complicated street en-
distribution between 0.2 and 0.9, with a peak between 0.4 and 0.5, vironmentsandbylow-riseareaswithdensetreecanopy.
whileBVFhasadecreasingfrequencywhenitsvalueincreases.
3.3. ComparisonbetweenGSV-basedand3D-GIS-basedSVFestimates
3.2. VerificationofGSV-basedVFestimates
In this section, the collocated SVF estimates at 30m intervals de-
The comparison of VF estimates and direct measurements using rived from GSV and 3D-GIS Model are compared for the purpose of
hemispherical photography is a convincing way to verify the effec- assessingtheaccuracyofurban3D-GISmodelinsimulatingtheurban
tivenessandassesstheuncertaintiesassociatedwithGSV-basedand3D- street environment in high-density contexts. Fig. 9 (a) illustrates the
GIS-based methods for estimating VFs of street canyons. Here we use spatialdistributionof3D-GIS-basedSVFestimatesat30mintervalsin
fisheyelenshemisphericphotographytoverifytheapplicabilityofGSV- high-densityareasofHongKong,correspondingtothesamplingpoints
basedand3D-GIS-basedmethodsinhigh-densityurbanareasofHong inFig.6(a).Themapof3D-GIS-basedSVFshowsasimilarpatternto
Kong.Thisis,toourknowledge,thefirstreporteduseofhemispheric that of GSV-based SVF estimates, in which the lower SVF values are
photographyfordirectverificationofaGSV-basedstreetscapestudy. locatedmainlyinareaswithhigh-risebuildingsandhigherSVFvalues
Forty photographs were taken at 40 selected sample points (20 in located in low-rise or coastal areas. The mean SVF value of 3D-GIS-
thehigh-riseareaofMongKokand20inthelow-riseareaofKowloon based estimates (0.59) is about 0.11 (about 20%) higher than that of
Tong)inKowloon,asshowninFig.2(c).Thephotographsweretaken GSV-based estimates (0.49) but with the similar standard deviation
at1.5mabovegroundlevel,usingadigitalcamera,NikonFM601,with (0.234and0.225,respectively).However,therearelargedifferencesin
an8-mmcircularlens.Fig.7showsfourexamplesofphotographstaken thelow-riseareaswithlargequantitiesofstreettrees.Toinvestigatethe
withafisheyelensinourfieldsurvey(a)andthecollocatedprojected spatial difference, Fig. 9 (b) shows the spatial distribution of the dif-
GSV fisheye images (b). The feature extraction results and the corre- ference between 3D-GIS-based and GSV-based SVF estimates (former
sponding VF estimates are also shown. The field survey results are minus latter). The two datasets have a better agreement in high-rise
consistent with GSV-based estimates, with differences within 0.03, regions(differencelessthan0.1)thantheregionswithlowerbuilding
suggestingtheeffectivenessandhighaccuracyofusingGSVimagesin rise (difference larger than 0.1). This characteristic of difference can
estimatingVFsinhigh-densityurbanareasofHongKong. alsobeseenfromthebivariatehistograminFig.9(c),whichshowsthat
Fig.8illustratesthecomparisonsofsurvey-basedreferenceVFdata (1) GSV-based and 3D-GIS-based SVF estimates have good agreement
andGSV-basedand3D-GIS-basedVFestimates.TheGSV-basedmethod (thehighestdatanumberdensitycanbeseeninthediagonaldirection)
weproposetouseinhigh-densityurbanareasofHongKongperforms inhigh-riseregionswithsmallSVFbetween0.2and0.4.Outofallthe
muchbetterinestimatingSVF(Fig.8(a))thanthecommonlyused3D- samplingpoints,43.85%ofthemhaveadifferencelargerthan0.1;(2)
GIS-based method, with higher R2 (0.954 versus 0.014) and lower some 3D-GIS-based values are higher than GSV-based values, sug-
RMSE(0.033versus0.263).Inparticular,3D-GIShashigherR2inhigh- gesting model simulations overestimate the SVF in some regions.
Fig. 7.Examples of fisheye images from two
high-rise and two low-rise street sample points
fromfieldsurveysin(a),andGSV-basedmethod
in(b).Imagefeaturesareclassifiedintothesky
(inblue),trees(ingreen),andbuildings(ingrey)
usingthesceneparsingdeep-learningtechnique,
asshownin(c).SVF,TVF,andBVFvaluesfrom
field surveys and GSV are shown as indicated.
(Forinterpretationofthereferencestocolorin
thisfigurelegend, thereader isreferredtothe
Webversionofthisarticle.)
(cid:20)(cid:25)(cid:20)

F.-Y.Gongetal.
(cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
Fig.8.(a)ScatterplotofSVFreferencedatafromfieldsurveyandthecorrespondingGSV-based(inblue)and3D-GIS-based(inred)SVFestimates.SamplingSVFdatainclude20samples
inMongKokwithinhigh-risebuildingarea(intriangles),and20samplesinKowloonTongwithinlow-risebuildingarea(incircles);(b)thesameas(a)butforTVF;(c)thesameas(a)
butforBVF.(Forinterpretationofthereferencestocolorinthisfigurelegend,thereaderisreferredtotheWebversionofthisarticle.)
streettreesleadstoalargerdifferencebetweenestimationsofSVFfrom
Accordingtothedescriptivestatisticsofthe29,264samplepointsfrom
thiscomparison,theR2betweenthemis0.40withRMSEof0.22.This GSVimagesand3D-GISsimulation,especiallywhentheTVFislarger
overestimationofSVFbythe3D-GIS-basedmethodcanalsobeseenin than 0.1. The result from linear regression shows that the increase of
the histogram plots in Fig. 9 (d), which shows that the 3D-GIS-based the difference follows the increase of TVF by a factor of 1.17. This
methodhasshiftedthepeakofthefrequencydistributionofSVFfrom strong correlation suggests that TVF, an indicator of the number of
lessthan0.5tolargerthan0.5.Asaresult,themeanSVFsaredifferent streettrees,makesthedominantcontributiontothediscrepanciesbe-
by0.11.Thecontributorstothispatternofdifferenceareinvestigated tween GSV-based and 3D-GIS-based SVF estimates. This is because
inSection3.4. model simulations cannot parameterize street trees well due to their
|     |     |     |     | complexity,      | leading to underrepresentation |            | of model    | simulations      | of  |
| --- | --- | --- | --- | ---------------- | ------------------------------ | ---------- | ----------- | ---------------- | --- |
|     |     |     |     | realistic street | environments.                  | Therefore, | in general, | the 3D-GIS-based |     |
3.4. ImpactsofstreettreecanopyandbuildingdensityonSVFestimates method produces larger sky openness and overestimate the SVF of
|     |     |     |     | street canyons | in high-density | urban areas | in Hong | Kong. This | result |
| --- | --- | --- | --- | -------------- | --------------- | ----------- | ------- | ---------- | ------ |
To gain further understanding of the discrepancies between GSV- differsfromthestudy[35]inthelessdenseCardiff,UK,whichindicates
based and 3D-GIS-based SVF estimates and shed light on future im- no significant correction between thedifference inSVF estimates and
| provementsinthemodelsimulationoftheurbanenvironment,wein- |     |     |     | streettrees. |     |     |     |     |     |
| --------------------------------------------------------- | --- | --- | --- | ------------ | --- | --- | --- | --- | --- |
vestigatetheimpactsofthestreettreecanopy,quantifiedusingtheTVF Fig.10(b)illustratesthebivariatehistogramofGSV-basedBVF,an
estimate, and building density, quantified using the BVF estimate, on indicatorofbuildingdensity,andthedifferencebetweenthetwoSVF
thediscrepanciesshowninFig.9. estimates.Wecanseethat(1)mostdatadifferbetween−0.1and0.1
| The bivariate   | histogram of GSV-based | TVF and       | the difference | be-                                  |               |             |              |                    |     |
| --------------- | ---------------------- | ------------- | -------------- | ------------------------------------ | ------------- | ----------- | ------------ | ------------------ | --- |
|                 |                        |               |                | andcorrespond                        | toa widerange | ofBVFsfrom0 |              | to 0.9,and (2)when |     |
| tween GSV-based | and 3D-GIS-based       | SVF estimates | is presented   | in                                   |               |             |              |                    |     |
|                 |                        |               |                | BVFislarge,thatiswhenbuildingdensity |               |             | isrelatively | large,thedif-      |     |
Fig.10(a).Wecanseethat(1)alargemajorityofthedatahassmall
|     |     |     |     | ference iscentered | at0 | with asmall variation | range, | indicatinggood |     |
| --- | --- | --- | --- | ------------------ | --- | --------------------- | ------ | -------------- | --- |
differences(closeto0)andlowTVF(smallerthan0.2)and(2)thereisa
performancesofmodelsimulationsinhigh-riseareasofHongKong.On
strongpositivecorrelationbetweenTVFandthedifference.WhenTVF theotherhand,whenBVFissmall,thedifferencetendstobepositive,
islargerthan0.1,R2ofthetwodatasetsis0.53(p
< 0.01),indicating indicatingthatthe3D-GIS-basedSVFestimateishigherthantheGSV-
asignificantcorrelation.Thisresultindicatesthatahighernumberof
(cid:20)(cid:25)(cid:21)

F.-Y.Gongetal. (cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
Fig.9.(a)Mapof3D-GIS-basedSVFestimatewiththesamestreetsamplingpointsasFig.6(a);(b)MapofthedifferencebetweenGSV-basedand3D-GIS-basedSVFestimates;(c)
BivariatehistogramofGSV-basedand3D-GIS-basedSVFestimatesofstreetcanyoninhigh-densityurbanareasofHongKongasshowninFigs.6(a)and9(a),respectively.Tomakethe
histogram,theSVFdatafrombothdatasetsaregroupedinto0.01×0.01gridsandthevalueofagridisthetotalnumberofSVFsamplesthatfallinthisgrid;(d)Comparisonoffrequency
densityhistogramfromGSV-basedand3D-GIS-basedSVFestimates.
basedestimateinlowerdensityregions.EspeciallywhenBVFiscloseto ofthegeometryandstructuresofstreetcanyons.
0, that is in the urban areas with very low building density, the dif- This study proposes the use of publicly available GSV panorama
ferencescanbeverylarge,probablymainlyduetotheimpactoftrees, images and a deep-learning technique to estimate the SVF, TVF, and
asshowninFig.10(a).Thisfigureshowsthatthelowerthebuilding BVFofstreetcanyonsinhigh-densityurbanareasofHongKong.From
density, thegreaterthedifference. Combinedwith theeffect ofstreet theverificationresultsagainstreferencedata(astruth),theGSV-based
trees on SVF values in Fig. 10 (a), our study shows that the larger VFsshowasatisfyingagreement(withallR2valueslargerthan0.95)
amounts of street trees are associated with a higher uncertainty of with thereference data. Thisresult indicates thehigh accuracy ofes-
modeledSVF.Ontheotherhand,thehigherthebuildingdensity,the timatingVFsusingGSVimagesandthedeep-learningtechnique.These
smallertheuncertainty. high-accuracyestimateswillimprovethecalculationofurbanthermal
radiationinmodelingthestreetcanyonthermalenvironmentinHong
Kong. Moreover, the GSV-based method developed is capable of pro-
4. Discussion
vidingmoredetailedVFestimatesatvariousscalesfromasmallsiteto
anentirecity.SinceGSVimagesareavailableinmanycitiesalloverthe
4.1. High-accuracyVFestimatesforbettermodelingofurbanthermal
world,thismethodprovidesalow-costandeffectiveapproachtosup-
environment
portglobalstudiesofurbanthermalenvironments.
The climate of Hong Kong during hot and humid summer causes
thermaldiscomfortanddecreasesthequalityofliving,andbotheffects 4.2. Largeuncertaintyinmodel-basedSVFestimatesfromstreettrees
areintensifiedbytheUHIeffectinheavilybuilt-upareas.Seriousissues
relatedtohumanthermalcomfort[56],airpollution[57,58]andthe Withtheavailabilityof3D-GISmodelsforurbanareas,theSVFcan
UHIeffect[59,60]duetoitsclimateandurbanmorphologieshavebeen be continuously estimated at large spatial scales by simulating and
primaryplanningconcernsinHongKong.Theurbanradiationbalance calculating the projection of building blocks from any point on the
and thermal environment are crucially affected by the geometry and ground.However,duetoitscomplexityinshapeandstructure,street
structures of street canyons [61]. There is a pressing need for high- tree canopy information, a major feature of urban settings, is usually
accuracyestimatesofSVF,TVF,andBVF,whichareeffectiveindicators verydifficulttoparameterizeandincorporateinmodels.Asourstudy
(cid:20)(cid:25)(cid:22)

F.-Y.Gongetal. (cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
However,fortemperateclimateregions,theseasonalityofTVFwill
beabigissue,giventhatthestreettreeswillbeinanannualcycleof
greeningduringgrowingseasons,andturningyellowandfallingduring
theautumnandwinterseasons.Thechangeincoloroftreeleavesposes
a challenge for VF studies using conventional tree detection method
based on the traditional spectral (RGB) information. The developed
deep-learningmethodinthisstudy,ontheotherhand,extractsstreet
featuresbasedonlocalandglobalcontextinformationindependentof
spectralinformation.Therefore,ithasanadvantageoverthetraditional
pixel-basedspectralmethod.Thedevelopedmethodinthisstudycanbe
usedtoaddresstheproblemofVFseasonalitybyfirsttrainingthedeep-
learning module with tree image samples from different seasons and
thenapplyingittoGSVimagesgroupedintodifferentseasons(seeFig.
A.2(b)).
4.4. Limitationsandfuturestudies
TheGSV-basedmethodisapplicableonlyinareaswithGSVimages
for mapping streetscape variables, including SVF, BVF, and TVF. In
areaswithoutGSVdata,suchastheareasonHongKongIsland,the3D-
GIS-basedmethodorDSM-basedmethodisstilleffective.Theconclu-
sionsfromstudyingtheimpactofstreettreesandbuildingdensityon
the uncertainty of the 3D-GIS-based method contribute to the future
improvementofmodelingtheurbanstreetenvironment.Inthisstudy,
weusea30mintervalforcalculatingVFs,assumingthatthisresolution
wouldsufficetoresolvethevariationofVFswithinastreet.However,
theGSV-basedmethodisflexibleinusinganyintervalformappingVFs
ofstreetcanyonsforstudyareaswithdifferentspatialscales.
GSV images may have the potential to investigate the symmetric
andasymmetriccharactersofstreetcanyons[63,64]withthefollowing
extra inputs and assumption, including the exact location of the ob-
server,thewidthofthestreetwhichenablesaccuratelycalculatingthe
Fig.10.(a)BivariatehistogramofGSV-basedTVFandthedifferencebetween3D-GIS-
basedandGSV-basedSVFs(formerminuslatter).Asindicated,whenTVF>0.1,theR2is observer position relative to both sides of the street, and assuming
0.53andthebestfitlinearslopeis1.17(indottedblackline);(b)Bivariatehistogramof streettreesdon'tblockbuildingsonbothsides.Inthisway,theheight
GSV-basedBVFandthedifferencebetween3D-GIS-basedandGSV-basedSVFs(former of buildings on both site along the street can be calculated and the
minuslatter).Toderivethehistogram,thedatafrombothdatasetsaregroupedinto0.01 asymmetriccharactersofstreetcanyonsmaybedetermined.
×0.01gridsandthevalueforeachgridisthetotalnumberofSVFsamplesthatfallinthe Inaddition,sunviewfactorwhichisrelevanttodaytimeshortwave
grid.
irradiance can also be estimated by constructing geometries and or-
ientations of street canyons using GSV images [36]. The estimation
shows,the3D-GIS-basedmethodcaptureswellthespatialpatternand involvestheprojectionofthesuntrajectoryontheGSVfisheyeimage
variabilityofSVFinhigh-densityurbanareasofHongKong.However, andthenthecalculationofthefractionofthelengthofsolartrajectory
it overestimates SVF by 0.11 on average. Moreover, our results show withintheskyviewrangewhensunlightcanbeseen.Thequantifica-
thatasTVFincreasesbyoneunit,theresultingSVFerrorfromthe3D- tionofstreetsunviewfactorcomparesthenumberofpointsofasun
GIS-based method decreases by 1.17 unit, suggesting a significant pathnotblockedbyobstacleswiththetotalamountofpointsinthesun
correlation (R2=0.53;p < 0.01)between streettreesandtheerrors pathinGSVimages.Itiscriticalforquantifyingthesun-exposureofthe
inmodelsimulations.Thisresultsuggeststhatalackofstreettreesis solid surfaces, which is needed to resolve the heterogeneity in urban
the dominant factor contributing to the large uncertainties in model areasforestimatingthermalcomfortmoreaccurately.
simulationsofurbanstreetgeometry.Ontheotherhand,basedonthe
linkagebetweenstreettreesandthedifferencebetween3D-GIS-based
5. Conclusions
and GSV-based SVF estimates, the shade provision of street trees in
urbanstreetcanyonscanbeestimatedusingGSVimages[34].Street- This study focuses on (1) developing an approach for accurately
levelimageryallowedustoconsiderobstructionsalongstreetcanyons deriving VFs for thesky, trees, and buildings of street canyons inthe
withoutrelyingonsimplificationsorsimulationsoftheenvironment.
high-densityurbanenvironmentofHongKongusingpubliclyavailable
GSVimagesandadeep-learningfeatureextractionalgorithm;(2)ver-
4.3. Temporalvariationofstreet-levelVFs ifyingtheaccuracyofthedevelopedGSV-basedmethodusingreference
dataofhemisphericphotographyfromfieldsurveys;and(3)comparing
Hong Kong is located in a subtropical monsoon region with little the GSV-based and 3D-GIS-based VF estimates and investigating the
effectofseasonalityonthevariationofthestreettreecanopy.Aspecific impactfactorsforthediscrepanciesbetweenthem.Asaresult,mapsof
assumptionontheseasonalityisthattheleafcoverofstreettreesdoes SVF, TVF, and BVF of street canyons in high-density urban areas of
notchangeduringdifferentseasonseventhoughtheacquisitiontimeof HongKongaregenerated.ThemeanSVF,TVF,andBVFvaluesinhigh-
GSVimagesdiffers(seeFig.A.2).Thisisareasonableassumptionsince densityareasofHongKongare0.49,0.14,and0.33,respectively.The
Hong Kong is located in the subtropical monsoon region where the followingconclusionscanbedrawn:
street trees can be maintained throughout the year [62]. Moreover,
HongKongisahighlydevelopedhigh-densitycitywherethebuilt-up • ThespatialpatternsofVFestimatesaresimilarandconsistentwith
areasarelimitedandthereforeverylittlechangehastakenplaceduring the corresponding building height and density. The TVF is domi-
recentyears[40]thatwillsignificantlyaffectthestreetskylines. natedbyvalueslessthan0.1,whichislimitedbythehighbuilding
(cid:20)(cid:25)(cid:23)

F.-Y.Gongetal.
(cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
densityandnarrowstreetenvironment. thatstreettreesshouldbeconsideredinmodelsimulationsofurban
• Verificationusingreferencedatabyhemisphericphotographyfrom streetenvironments.
| field surveys | shows that | the GSV-based | VF estimates | have a sa- |
| ------------- | ---------- | ------------- | ------------ | ---------- |
tisfying agreement (with all R2 values larger than 0.95) with the ThedevelopedmethodforanalyzingVFsina3Dstreetenvironment
referencedata.Itsuggeststheeffectivenessandhighaccuracyofthe willplayanimportantroleinrelatingscience-basedevidenceforurban
GSV-basedmethod. climatic studies and decision-making in urban planning and design
| • AcomparisonbetweenGSV-basedand3D-GIS-basedSVFsshowthat |     |     |     | processes. |
| -------------------------------------------------------- | --- | --- | --- | ---------- |
thetwoSVFestimatesarecorrelated(withR2of0.40)andhavea
| betteragreementinhigh-building-density          |         |                 | areas. However,the3D- |                |
| ----------------------------------------------- | ------- | --------------- | --------------------- | -------------- |
| GIS-basedmethodoverestimatesSVFby0.11onaverage. |         |                 |                       | Acknowledgment |
| differences                                     |         |                 | significantly         |                |
| • The                                           | between | the two methods | are                   | corre-         |
latedwithstreettrees(R2=0.53).Themorestreettrees,thelarger ThestudyissupportedbythePostgraduateScholarship(PGS)and
thedifference(byafactorof1.17).Thissuggeststhatalackofstreet the Global Scholarship Programme for Research Excellence from The
trees in a 3D-GIS model of a street environment is the dominant ChineseUniversityofHongKong.Theauthorsalsowishtogivespecial
factor contributing to the large discrepancies between the twoda- thanks to the three reviewers for their valuable comments and sug-
tasets.Thisstudydemonstratesaneffectiveandaccurateapproach gestionsthathelptoimproveourresearch.Wealsothanktheeditorsfor
formapping SVFinhigh-density areasofHongKongandsuggests theirpatientandmeticulousworkforourmanuscript.
AppendixA
A.1.Spatialdistributionofthe100randomsamples
Fig.A.1.Spatialdistributionofthe100randomlyselectedsamplesinthestudyareaforverificationdescribedinSection2.2.4.Thesamplingisimplementedbygenerating100random
integersusingapseudorandomintegergeneratorinMATLABtoextractdatafromthetotal29,264streetdatapoints.
A.2.AcquisitiontimeofGSVimages
Fig.A.2showsthespatialdistributionoftheacquisitiontimeofallthe22,729GSVimagescollectedinthehigh-densityurbanareaofHongKong,
includingyearin(a)andseasonin(b).ThetimeinformationcanbeextractedfromtheGSVmetafileasdescribedinSection2.2.1andshowsthat
77.7%oftheGSVimagesusedinthisstudywereupdatedandcollectedduringthewinterseasonfromDecember2016toJanuary2017.SomeGSV
imageshaven'tbeenupdated,whichmaybeduetouncontrolledfactors(weather,roadclosures,etc.)thatpreventGooglecarsfromoperating[65].
(cid:20)(cid:25)(cid:24)

F.-Y.Gongetal. (cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
Fig.A.2.Spatialdistributionoftheacquisitiontime,includingyearin(a)andseasonin(b),oftheGSVimagesthisstudycollectedinthehigh-densityurbanareaofHongKong.
References usingGoogleStreetView,Ecol.Indicat.77(SupplementC)(Jun.2017)31–40.
[23] H.J.Fernando,HandbookofEnvironmentalFluidDynamics,VolumeTwo:Systems,
Pollution,Modeling,andMeasurementsvol.2,CRCpress,2012.
[1] G.S.Brager,R.J.deDear,Thermaladaptationinthebuiltenvironment:aliterature [24] M.Roth,W.T.L.Chow,Ahistoricalreviewandassessmentofurbanheatisland
review,EnergyBuild.27(1)(Feb.1998)83–96. researchinSingapore,SingaporeJ.Trop.Geogr.33(3)(Nov.2012)381–397.
[2] I.Saito,O.Ishihara,T.Katayama,Studyoftheeffectofgreenareasonthethermal [25] WongNyukHienandJusufSteveKardinal,Airtemperaturedistributionandthe
environmentinanurbanarea,EnergyBuild.15(3)(Jan.1990)493–498. influenceofskyviewfactorinaGreenSingaporeestate,J.UrbanPlann.Dev.136
[3] E.Johansson,R.Emmanuel,Theinfluenceofurbandesignonoutdoorthermal (3)(Sep.2010)261–272.
comfortinthehot,humidcityofColombo,SriLanka,Int.J.Biometeorol.51(2) [26] T.R.Oke,Themicrometeorologyoftheurbanforest,Phil.Trans.Roy.Soc.Lond.B
(Nov.2006)119–133. 324(1223)(Aug.1989)335–349.
[4] G.T.Johnson,I.D.Watson,Thedeterminationofview-factorsinurbancanyons,J. [27] A.Henderson-Sellers,FutureClimatesoftheWorld,Elsevier,1995.
Clim.Appl.Meteorol.23(2)(Feb.1984)329–335. [28] M.C.Anderson,Studiesofthewoodlandlightclimate:I.Thephotographiccom-
[5] T.R.Oke,BoundaryLayerClimates,Routledge,1987. putationoflightconditions,J.Ecol.52(1)(1964)27–41.
[6] I.D.Watson,G.T.Johnson,Graphicalestimationofskyview-factorsinurbanen- [29] D.G.Steyn,Thecalculationofviewfactorsfromfisheye-lensphotographs:research
vironments,J.Climatol.7(2)(Mar.1987)193–197. note,Atmos.-Ocean18(3)(Sep.1980)254–258.
[7] E.Johansson,Influenceofurbangeometryonoutdoorthermalcomfortinahotdry [30] C.Ratti,P.Richens,Rasteranalysisofurbanform,Environ.Plann.Plann.Des.31
climate:astudyinFez,Morocco,Build.Environ.41(10)(Oct.2006)1326–1338. (2)(Apr.2004)297–309.
[8] F.Bourbia,F.Boucheriba,Impactofstreetdesignonurbanmicroclimateforsemi [31] T.Gál,F.Lindberg,J.Unger,Computingcontinuousskyviewfactorsusing3D
aridclimate(Constantine),Renew.Energy35(2)(Feb.2010)343–347. urbanrasterandvectordatabases:comparisonandapplicationtourbanclimate,
[9] T.R.Oke,Canyongeometryandthenocturnalurbanheatisland:comparisonof Theor.Appl.Climatol.95(1–2)(Jan.2009)111–123.
scalemodelandfieldobservations,J.Climatol.1(3)(Jul.1981)237–254. [32] L.Chen,etal.,Skyviewfactoranalysisofstreetcanyonsanditsimplicationsfor
[10] J.Unger,Intra-urbanrelationshipbetweensurfacegeometryandurbanheatisland: daytimeintra-urbanairtemperaturedifferentialsinhigh-rise,high-densityurban
reviewandnewapproach,Clim.Res.27(3)(2004)253–264. areasofHongKong:aGIS-basedsimulationapproach,Int.J.Climatol.32(1)(Jan.
[11] E.L.Krüger,F.O.Minella,F.Rasia,Impactofurbangeometryonoutdoorthermal 2012)121–136.
comfortandairqualityfromfieldmeasurementsinCuritiba,Brazil,Build.Environ. [33] J.Liang,J.Gong,J.Sun,J.Liu,Acustomizableframeworkforcomputingskyview
46(3)(Mar.2011)621–634. factorfromlarge-scale3Dcitymodels,EnergyBuild.149(SupplementC)(Aug.
[12] U.W.Tang,Z.S.Wang,Influencesofurbanformsontraffic-inducednoiseandair 2017)38–44.
pollution:resultsfromamodellingsystem,Environ.Model.Software22(12)(Dec. [34] X.Li,C.Ratti,I.Seiferling,Quantifyingtheshadeprovisionofstreettreesinurban
2007)1750–1764. landscape:acasestudyinBoston,USA,usinggooglestreetview,Landsc.Urban
[13] X.-X.Li,L.K.Norford,Evaluationofcoolroofandvegetationsinmitigatingurban Plann.169(SupplementC)(Jan.2018)81–91.
heatislandinatropicalcity,Singapore,UrbanClim.16(SupplementC)(Jun.2016) [35] J.Liang,etal.,Automaticskyviewfactorestimationfromstreetviewphoto-
59–74. graphs—abigdataapproach,Rem.Sens.9(5)(Apr.2017)411.
[14] E.Ng,L.Chen,Y.Wang,C.Yuan,Astudyonthecoolingeffectsofgreeningina [36] R.Carrasco-Hernandez,A.R.D.Smedley,A.R.Webb,Usingurbancanyongeome-
high-densitycity:anexperiencefromHongKong,Build.Environ.47(Supplement triesobtainedfromGoogleStreetViewforatmosphericstudies:potentialapplica-
C)(Jan.2012)256–271. tionsinthecalculationofstreetleveltotalshortwaveirradiances,EnergyBuild.86
[15] S.Oliveira,H.Andrade,T.Vaz,Thecoolingeffectofgreenspacesasacontribution (SupplementC)(Jan.2015)340–348.
tothemitigationofurbanheat:acasestudyinLisbon,Build.Environ.46(11)(Nov. [37] A.Middel,J.Lukasczyk,R.Maciejewski,Skyviewfactorsfromsyntheticfisheye
2011)2186–2194. photosforthermalcomfortrouting—acasestudyinPhoenix,Arizona,UrbanPlan.
[16] L.Shashua-Bar,I.X.Tsiros,M.E.Hoffman,Amodelingstudyforevaluatingpassive 2(1)(Mar.2017)19–30.
coolingscenariosinurbanstreetswithtrees.Casestudy:Athens,Greece,Build. [38] E.Ng,C.Yuan,L.Chen,C.Ren,J.C.H.Fung,Improvingthewindenvironmentin
Environ.45(12)(Dec.2010)2798–2807. high-densitycitiesbyunderstandingurbanmorphologyandsurfaceroughness:a
[17] R.A.Sutherland,J.F.Bartholic,Significanceofvegetationininterpretingthermal studyinHongKong,Landsc.UrbanPlann.101(1)(May2011)59–74.
radiationfromaterrestrialsurface,J.Appl.Meteorol.16(8)(Aug.1977)759–763. [39] CensusandStatisticsDepartment,TheGovernmentofHongKongS.A.R.,
[18] A.V.Parisi,M.G.Kimlin,J.C.F.Wong,M.Wilson,Diffusecomponentofsolarul- “Population-Overview|CensusandStatisticsDepartment”,(2016)[Online].
travioletradiationintreeshade,J.Photochem.Photobiol.B54(2)(Feb.2000) Available:http://www.censtatd.gov.hk/hkstat/sub/so20.jsp,Accesseddate:25
116–120. October2017.
[19] L.Shashua-Bar,M.E.Hoffman,TheGreenCTTCmodelforpredictingtheairtem- [40] PlanningDepartment,TheGovernmentoftheHongKong,S.A.R.,“Planning
peratureinsmallurbanwoodedsites,Build.Environ.37(12)(Dec.2002) Department-LandUtilizationinHongKong,”,(2016)[Online].Available:http://
1279–1288. www.pland.gov.hk/pland_en/info_serv/statistic/landu.html,Accesseddate:26
[20] K.V.Abhijith,S.Gokhale,Passivecontrolpotentialsoftreesandon-streetparked October2017.
carsinreductionofairpollutionexposureinurbanstreetcanyons,Environ.Pollut. [41] HongKongObservatory,TheYear'sWeather-2016,(2016)[Online].Available:
204(SupplementC)(Sep.2015)99–108. http://www.hko.gov.hk/wxinfo/pastwx/2016/ywx2016.htm,Accesseddate:27
[21] W.Klemm,B.G.Heusinkveld,S.Lenzholzer,B.vanHove,Streetgreeneryandits November2017.
physicalandpsychologicalimpactonthermalcomfort,Landsc.UrbanPlann.138 [42] E.Ng,V.Cheng,UrbanhumanthermalcomfortinhotandhumidHongKong,
(SupplementC)(Jun.2015)87–98. EnergyBuild.55(SupplementC)(Dec.2012)51–65.
[22] D.R.Richards,P.J.Edwards,Quantifyingstreettreeregulatingecosystemservices [43] W.-Z.Lu,H.He,A.Y.T.Leung,AssessingairqualityinHongKong:aproposed,
(cid:20)(cid:25)(cid:25)

F.-Y.Gongetal. (cid:37)(cid:88)(cid:76)(cid:79)(cid:71)(cid:76)(cid:81)(cid:74)(cid:3)(cid:68)(cid:81)(cid:71)(cid:3)(cid:40)(cid:81)(cid:89)(cid:76)(cid:85)(cid:82)(cid:81)(cid:80)(cid:72)(cid:81)(cid:87)(cid:3)(cid:20)(cid:22)(cid:23)(cid:3)(cid:11)(cid:21)(cid:19)(cid:20)(cid:27)(cid:12)(cid:3)(cid:20)(cid:24)(cid:24)(cid:178)(cid:20)(cid:25)(cid:26)
revisedairpollutionindex(API),Build.Environ.46(12)(Dec.2011)2562–2569. [56] L.Chen,E.Ng,Quantitativeurbanclimatemappingbasedonageographicalda-
[44] W.Wang,W.Zhou,E.Y.Y.Ng,Y.Xu,UrbanheatislandsinHongKong:statistical tabase:asimulationapproachusingHongKongasacasestudy,Int.J.Appl.Earth
modelingandtrenddetection,Nat.Hazards83(2)(Sep.2016)885–907. Obs.Geoinformation13(4)(Aug.2011)586–594.
[45] I.D.Stewart,T.R.Oke,Localclimatezonesforurbantemperaturestudies,Bull.Am. [57] C.Yuan,E.Ng,L.K.Norford,Improvingairqualityinhigh-densitycitiesbyun-
Meteorol.Soc.93(12)(May2012)1879–1900. derstandingtherelationshipbetweenairpollutantdispersionandurbanmorphol-
[46] Y.Zheng,etal.,GIS-basedmappingofLocalClimateZoneinthehigh-densitycityof ogies,Build.Environ.71(SupplementC)(Jan.2014)245–258.
HongKong,UrbanClim.(Jun.2017),https://doi.org/10.1016/j.uclim.2017.05. [58] Y.Shi,K.K.-L.Lau,E.Ng,Developingstreet-levelPM2.5andPM10landusere-
008. gressionmodelsinhigh-densityHongKongwithurbanmorphologicalfactors,
[47] GoogleMapsAPIs,GoogleStreetViewImageAPI|GoogleStreetViewImageAPI, Environ.Sci.Technol.50(15)(Aug.2016)8178–8187.
GoogleDevelopers,2017[Online].Available:https://developers.google.com/ [59] R.Giridharan,S.S.Y.Lau,S.Ganesan,B.Givoni,Urbandesignfactorsinfluencing
maps/documentation/streetview/intro,Accesseddate:20October2017. heatislandintensityinhigh-risehigh-densityenvironmentsofHongKong,Build.
[48] GoogleMapsAPIs,StreetViewImageMetadata|GoogleStreetViewImageAPI, Environ.42(10)(Oct.2007)3669–3684.
GoogleDevelopers,2017[Online].Available:https://developers.google.com/ [60] C.Yuan,L.Chen,Mitigatingurbanheatislandeffectsinhigh-densitycitiesbasedon
maps/documentation/streetview/metadata,Accesseddate:27November2017. skyviewfactorandurbanmorphologicalunderstanding:astudyofHongKong,
[49] H.Zhao,J.Shi,X.Qi,X.Wang,J.Jia,Pyramidsceneparsingnetwork, Archit.Sci.Rev.54(4)(Nov.2011)305–315.
ArXiv161201105Cs(Dec.2016). [61] R.Ooka,T.Sato,K.Harayama,S.Murakami,Y.Kawamoto,Thermalenergybalance
[50] B.Zhou,H.Zhao,X.Puig,S.Fidler,A.Barriuso,A.Torralba,Semanticunder- analysisofthetokyometropolitanareausingamesoscalemeteorologicalmodel
standingofscenesthroughtheADE20Kdataset,ArXiv160805442Cs(Aug.2016). incorporatinganurbancanopymodel,Bound.-LayerMeteorol.138(1)(Jan.2011)
[51] Y.LeCun,Y.Bengio,G.Hinton,Deeplearning,Nature521(7553)(May2015) 77–97.
nature14539. [62] C.Y.Jim,Tree-canopycharacteristicsandurbandevelopmentinHongKong,Geogr.
[52] V.Badrinarayanan,A.Kendall,R.Cipolla,SegNet:adeepconvolutionalencoder- Rev.79(2)(1989)210–225.
decoderarchitectureforimagesegmentation,ArXiv151100561Cs(Nov.2015). [63] F.Ali-Toudert,H.Mayer,Effectsofasymmetry,galleries,overhangingfaçadesand
[53] J.Long,E.Shelhamer,T.Darrell,Fullyconvolutionalnetworksforsemanticseg- vegetationonthermalcomfortinurbanstreetcanyons,Sol.Energy81(6)(Jun.
mentation,PresentedattheProceedingsoftheIEEEConferenceonComputer 2007)742–754.
VisionandPatternRecognition,2015,pp.3431–3440. [64] J.Rodríguez-Algeciras,A.Tablada,A.Matzarakis,Effectofasymmetricalstreet
[54] T.-Y.Lin,P.Dollár,R.Girshick,K.He,B.Hariharan,S.Belongie,Featurepyramid canyonsonpedestrianthermalcomfortinwarm-humidclimateofCuba,Theor.
networksforobjectdetection,ArXiv161203144Cs(Dec.2016). Appl.Climatol.(Jul.2017)1–17.
[55] MITSenseableCityLab,Treepedia:MITsenseablecitylab,Treepedia(2016) [65] GoogleStreetView,GoogleStreetView–whereWe’veBeen&whereWe’reHeaded
[Online].Available:http://senseable.mit.edu/treepedia,Accesseddate:24 Next,GoogleStreetView,2017[Online].Available:https://www.google.com/
November2017. streetview/understand/,Accesseddate:18January2018.
(cid:20)(cid:25)(cid:26)
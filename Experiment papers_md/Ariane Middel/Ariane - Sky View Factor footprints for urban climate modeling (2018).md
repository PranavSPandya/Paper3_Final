Urban Climate 25 (2018) 120–134
ContentslistsavailableatScienceDirect
Urban Climate
journal homepage: www.elsevier.com/locate/uclim
Sky View Factor footprints for urban climate modeling
T
Ariane Middela,f,⁎ , Jonas Lukasczykb, Ross Maciejewskic, Matthias Demuzered,
Matthias Rothe
aDepartmentofGeographyandUrbanStudies,TempleUniversity,324GladfelterHall,Philadelphia,PA19122,USA
bDepartmentofComputerScience,TechnischeUniversitätKaiserslautern,POBox3049,Kaiserslautern,Germany
cSchoolofComputing,Informatics,andDecisionSystemsEngineering,ArizonaStateUniversity,699SMillAve,Tempe,AZ85281,USA
dLaboratoryofHydrologyandWaterManagement,GhentUniversity,CoupureLinks653,B-9000Ghent,Belgium
eDepartmentofGeography,NationalUniversityofSingapore,1ArtsLink,KentRidge,Singapore117570
fUrbanClimateResearchCenter,ArizonaStateUniversity,975SMyrtleAve,Tempe,AZ85281,USA
ABSTRACT
Urbanmorphologyisanimportantmultidimensionalvariabletoconsiderinclimatemodeling
andobservations,becauseitsignificantlydrivesthelocalandmicro-scaleclimaticvariabilityin
cities.Urbanformcanbedescribedthroughurbancanopyparameters(UCPs)thatresolvethe
spatial heterogeneity of cities by specifying the 3-dimensional geometry, arrangement, and
materialsofurbanfeatures.Theskyviewfactor(SVF)isadimension-reducedUCPcapturing3-
dimensional form through horizon limitation fractions. SVF has become a popular metric to
parameterizeurbanmorphology,butcurrentapproachesaredifficulttoscaleuptoglobalcov-
erage.ThisstudyintroducesaBig-DataapproachtocalculateSVFsforurbanareasfromGoogle
StreetView(GSV).90-degreefield-of-viewGSVphotosareretrievedandconvertedintohemi-
sphericalviewsthroughequiangularprojection.Thefisheyesaresegmentedintoskyandnon-sky
pixelsusingimageprocessing,andtheSVFiscalculatedusinganannulusmethod.Resultsare
comparedtoSVFsretrievedfromGSVimagessegmentedusingdeeplearning.SVFfootprintsare
presentedforurbanareasaroundtheworldtallying15,938,172GSVlocations.Twousecasesare
introduced:(1)anevaluationofaGoogleEarthEngineclassifiedLocalClimateZonemapfor
Singapore;(2)hourlysundurationmapsforNewYorkandSanFrancisco.
1. Introduction
Urbanmorphology,i.e.thephysicalformofcities,isasignificantdriverofurbanclimateatthemicro-andlocalscale(Stewart
andOke,2012;Middeletal.,2014).Resolvingthespatialheterogeneityofcitiesatfinescalesisofparamountinteresttotheweather
andclimatemodelingcommunity,asurbanmorphologyimpactsairtemperature(Oke,1981;Unger,2004;Unger,2009;Chenetal.,
2012),airflow,ventilation,turbulence(GrimmondandOke,1999;Martillietal.,2002;Ngetal.,2011),solarradiation(Johansson,
2006;Lindbergetal.,2008;HofierkaandKaňuk,2009;Middeletal.,2017),landsurfacetemperature(Guoetal.,2016;Lietal.,
2016),andairquality(MarquezandSmith,1999;Stone,2008)intheurbancanopylayer.Citymorphologycanbedescribedthrough
UrbanCanopyParameters(UCPs)thatcapturethe3-dimensionalgeometricform,arrangement,coverage,andmaterialcomposition
ofurbanfeatures.VariousUCPshavebeendefinedtoparameterizetheheterogeneousurbanenvironmentformodelingpurposes,
rangingfromfractionalparameterssuchasplanfractionscoveredbybuildings,impervioussurfaces,water,baresoil,andvegetation
⁎Correspondingauthorat:DepartmentofGeographyandUrbanStudies,TempleUniversity,324GladfelterHall,Philadelphia,PA19122,USA.
E-mailaddresses:ariane.middel@temple.edu(A.Middel),jl@jluk.de(J.Lukasczyk),rmacieje@asu.edu(R.Maciejewski),demuzere@ugent.be(M.Demuzere),
geomr@nus.edu.sg(M.Roth).
https://doi.org/10.1016/j.uclim.2018.05.004
Received21February2018;Receivedinrevisedform25April2018;Accepted26May2018
2212-0955/ © 2018 The Authors. Published by Elsevier B.V. This is an open access article under the CC BY-NC-ND license
(http://creativecommons.org/licenses/BY-NC-ND/4.0/).

A.Middeletal. Urban Climate 25 (2018) 120–134
toparametersthatrelatetobuildingsandstreets,e.g.,averagebuildingheight,buildingvolumedensity,buildingpackingdensity,
height-to-widthratio,andskyviewfactor(SVF).Recentimprovementsinmesoscaleatmosphericmodelingincludeadvancedurban
canopyparameterizationsbasedonUCPstotreatcomplexatmosphericprocessesduetoheterogeneousurbanmorphology(Ching
etal.,2009;Chenetal.,2011;Ching,2013;Brousseetal.,2016;Xuetal.,2017,Hammerbergetal.,2018).Yet,modelsaresensitive
tohowtheurbancanopylayerisparameterized,i.e.thechoiceofUCPs,andunderlyingdatasources(Salamancaetal.,2010;Lietal.,
2017,Demuzereetal.,2017).
TheWorldUrbanDatabaseandAccessPortalTool(WUDAPT)aimstostandardize,collect,anddistributedataontheformand
functionofcitiesinacommonframeworkbybuildingaglobalUCPdatabase(Millsetal.,2015;Chingetal.,2018).WUDAPTLevel0
data - ranges of spatially averaged UCPs characterized by the Local Climate Zone (LCZ) scheme (Stewart and Oke, 2012) - are
gradually being processed using a crowd-sourcing approach (Bechtel et al., 2015) and disseminated through the portal (https://
wudapt.cs.purdue.edu/wudaptTools/). WUDAPT Level 1 and 2 data - detailed 2.5-dimensional urban form information at the
neighborhoodscaleand3-dimensional data attheindividualbuildingscaleincluding buildingtypology andmaterials -aremore
difficulttoretrieveduetoinsufficientdataavailability,quality,orprocessingcapabilities.PreviousstudieshavederivedLevel1UCPs
from stereo and SAR satellite images (Xu et al., 2017), Landsat images (Li et al., 2017), DEMs (Gál et al., 2009; Lindberg and
Grimmond,2010),3-dimensionalcitymodels(Chenetal.,2012;GálandUnger,2014),andLIDARdata(Carteretal.,2011;Anetal.,
2014).
This study presents an image-based methodology to calculate UCPs at fine spatial scales from high resolution ground level
imagery,specificallyfocusingontheSVF.TheSVFisameasureofhowmuchskyisvisibleatagivenlocationandcanbeusedto
easily describe the3-dimensional form of thebuilt environment as a2-dimensional metric. The SVF has been strongly related to
nocturnal Urban Heat Island (UHI) effects, intra-urban air temperature distribution, and thermal comfort (Svensson, 2004; Ali-
ToudertandMayer,2007;Unger,2009;Matzarakisetal.,2010;Chenetal.,2012;Middeletal.,2017).Variousapproacheshavebeen
developed to calculate SVFs from urban morphological information. Early studies used analytical methods based on geometric
propertiesofurbancanyons,suchasanglemeasurementsandheight-to-widthratios(Oke,1981;JohnsonandWatson,1984).With
theavailabilityof3-dimensionalcitymodels,vector-basedmethodshavebeenintroducedthatestimateSVFsfrombuildingenvelopes
inGISdatabases(Compagnon,2004;Gáletal.,2009;Chenetal.,2012;Gál&Unger,2014).Forareaswheredigitalelevationmodels
(DEMs)ordigitalsurfacemodels(DSMs)areavailable,theSVFcanalsobederivedusingarasterimage-basedapproachbyevaluating
pixelheight(Rattietal.,2005;Lindbergetal.,2008;LindbergandGrimmond,2010;Zakšeketal.,2011).Intheabsenceofurban
morphologicalinformation,fisheyephotographyhasfrequentlybeenemployedtocalculatetheSVFfordiscretelocations(Grimmond
et al., 2001; Chapman and Thornes, 2004; Ali-Toudert and Mayer, 2007). While photographic methods yield good results, they
typicallyrequiremanualacquisitionandprocessingoffisheyeimages,whichistimeconsumingandnotfeasibleattheneighborhood
orcity-scale.
TherecentavailabilityofstreetviewphotosfromGoogle,Baidu,andotherprovidersenablesresearcherstoderiveinformation
abouttheform,coverage,material,andfunctionofurbanfeaturesfromastreetcanyonperspectivethatismorehuman-centricthan
planar or bird's eye view approaches. This study presents a methodology to calculate city-wide SVF footprints (histograms) from
GoogleStreetView(GSV)imageryfor15citiesaroundtheworldanddemonstratestheapplicationofGSVphotosforcalculating
UPCsintwousecases:(1)evaluationofaLCZmapforSingaporebycomparingaverageGSV-derivedSVFswithrecommendedurban
zonalranges;and(2)hourlystreet-levelsundurationmapsforNewYorkandSanFrancisco.
2. Methods
Tocalculateacity'sSVFfootprint,allavailableGSVimageryforagivenstudyareaareretrievedthroughtheGSVAPI.Theimages
are then combined into fisheye photographs of the sky hemisphere using an equiangular fisheye projection. Next, to detect the
amountofvisibleskyineachimage,acombinationofamodifiedSobelfilterandaflood-fillalgorithmareused(SobelandFeldman,
1968;Laungrungthipetal.,2008).TheSVFforeachGSVlocationisfinallycalculatedemployinganimplementationbyMiddeletal.
(2017).Totesttheaccuracyoftheskydetectionapproach,resultsarecomparedtoSVFsthatwerederivedfromphotographsusinga
deeplearningapproach.
2.1. GoogleStreetViewimageretrievalandfisheyeprojection
First,anareaofinterestisdefinedbyalatitude-longituderectangle.Currently,theGSVAPIlacksfunctionalitytoretrievealistof
allavailableGSVimagelocationsinsidesuchaboundary.Infact,onlyimagedataforaspecificlatitude-longitudecoordinatecanbe
requested,andtheAPIwillreturnanimagefortheclosestavailablelocationtogetherwithmetadatathatindicatestheexactimage
coordinateandiftheimagewastakenindoorsoroutdoors.Togenerateauniformgridwithintheboundary,aspatialresolutionof
twometersisdefined,andGSVlocationsarerequestedforeachgridcell.Locationtagsareinvestigatedtodiscardallindoorimages,
andredundantcoordinatesareremoved.Afterderivingthegrid,fiveimagesarerequestedperlocationwitha90-degreefieldofview:
fourfacingthecardinaldirectionsandonefacingupwards.Next,thefiveimagesareusedtogenerateafisheyephotograph.
Various types of fisheye lenses exist, and they correspond to different mathematical projections. A common fisheye lens for
consumerusefitstheequisolidangleprojection(equal-areafisheye)thatmaintainssurfacerelations,i.e.eachpixelprojectedontoa
unitspherecoversthesamearea.Incontrast,astereographicprojectionpreservesanglesandthereforedoesnotcompressmarginal
objects in the image, but few lenses are available for this type of projection. Most fisheye lenses manufactured today are of
equiangular (equidistant) type, i.e. angular distances are maintained preserving approximately equal resolution across the whole
121

A.Middeletal. Urban Climate 25 (2018) 120–134
image.Equiangularprojectionisoftenreferredtoas“ideal”fisheyeprojectionandisthemostwidelyusedmathematicaltransfor-
mationforpanoramicstitchingandSVFapplications.
Thisstudycalculatesthepositionofpixelsontheupperhemisphereusinganequiangularprojection(Steyn,1980;Chapmanetal.,
2001;Middeletal.,2017):
⎛sin(θ)u r⎞
υ=⎜sin(θ)v r⎟
⎜ ⎟
⎝ cos(θ) ⎠
withlatitudeθ=rπandnormalizeddirectionvector(u ,v)= ⎧ r
pifr>0
r r ⎨(0,0)otherwise.
⎩
The fisheye image is treated as a unit square with center c=(0, 0) and p=(u, v) where length r=||p||≤0.5 is the corre-
spondingposition of point pon theunit hemisphere. Thisyields a fisheye photograph ofthe upper hemisphereforeach location
withinthestudyarea.
2.2. Skyvs.non-skypixelclassification
Todetecttheskyinfisheyephotographs,analgorithmpresentedbyLaungrungthipetal.(2008)isimplementedthatdividesthe
photographintonon-overlappingareasclassifyingthemasskyornon-sky(Fig.1).Next,aSobeledgedetectionalgorithm(Sobeland
Feldman,1968)identifiestheboundariesbetweenskyandnon-skyareas.Thisfilterassignsavaluebetweenzeroandonetoeach
pixelbyevaluatingthecontrastbetweenpixelcolorsinits8-neighborhood(adjacentpixelsthatshareanedgeornode).Tomakethe
edgedetectionmorerobust,theSobelfilterismodifiedtoemphasizetheedgesbetweendefiniteskyandnon-skypixelcolors,i.e.,if
bothcolorclassesaredetectedwithinthe8-neighborhood,thentheedgevalueforthatpixelissettoone.Next,alledgeswithavalue
belowapredefinedthresholdareremoved,andtheaveragecolorandcolorvarianceiscalculatedforeacharea.Theremainingedges
Fig.1.ThreeexamplesofskydetectioninGSVfisheyephotosusing(a)aSobelfilter,(b)aflood-fillalgorithmand(c)classificationintoskyand
non-skypixels.
122

A.Middeletal. Urban Climate 25 (2018) 120–134
Fig.2.Fisheye photographs generated from Google Street View (top), detectedhorizon limitations (bottom), andrespectiveSky ViewFactors
(boldedtext)forfourlocationsaroundtheglobe.
aresubsequentlyusedtoflood-filltheobstructedareas(e.g.,buildings,bridges,walls,andtrees)toseparatetheimageintoskyand
non-skyregions.
2.3. SkyViewFactorcalculation
AmodifiedSteynmethod(Steynetal.,1986;Chapmanetal.,2001;Middeletal.,2017)isimplementedtocomputetheSVFfora
fisheyephotograph.Eachfisheyeispartitionedintonannularrings(defaultn=36)tocalculatetheSVFbysummingupthecon-
tributionofeachring:
SVF= π ∑n sin⎛ π(2i−1) ⎞⎛ p i⎞
2n i=1 ⎝ 2n ⎠ ⎜ ⎝t i ⎟ ⎠
wherep/t istheratiobetweenthenumberofskypixelstothetotalnumberofpixelsinringi.Anensembleofdifferentfisheyesand
i i
associatedSVFsisshowninFig.2.
3. SkyViewFactorresults
3.1. SkyViewFactorevaluation
TheSVFalgorithmusedinthepresentstudywaspreviouslycomparedtootherSVFimplementations(Middeletal.,2017)and
showedexcellentagreementwiththetraditionalannulusapproachbySteyn(1980).GSV-derivedSVFsalsocomparedwellwithSVFs
fromsyntheticGoogleEarthfisheyes,yieldinganaverageSVFdifferenceof0.022 ± 0.084betweenthetwodatasets.Toassessthe
qualityoftheskydetectionalgorithmandfurtherevaluateSVFsderivedfromGSV,resultsarecomparedtoSVFscalculatedfrom
imagesthatweresegmentedintovariousurbanfractionsusingadeeplearningapproach.Lukasczyketal.(underreview)fine-tuneda
convolutionalneuralnetworkusing90-degreeGSVimagesfrom41citiesaroundtheworldtosegmentimagecubesintofivesurface
typesandsky,respectively.Thestudyachievedaskyclassificationaccuracyof98.5%forlateraland99.6%forupwardfacingimages.
For evaluation purposes, Lukasczyk et al.'s deep learning approach is used to segment GSV image cubes in the Phoenix me-
tropolitanareaintoskyvs.non-skypixels.Thesegmentedimagecubesarethenprojectedontotheupperhemisphereasdescribedin
Section2.1,andtheSVFiscalculatedusingthemodifiedSteynimplementation(Section2.3).SinceGoogleregularlyupdatesStreet
Viewimagery, the locations of the SVFs from the pixel-based classification (2015–2016 image data) and theSVFs from the deep
learningapproach(2017imagedata)donotperfectlyalign.Toassurereasonableproximityforcomparison,a2-mbufferiscalculated
aroundeachlocation topairupSVFsthatfallwithintheintersection oftwobuffers.Thisresultsin1,663,448valid locationsfor
evaluationwithameanSVFdifferenceof0.002,R2=0.880,andaRMSEof0.045(Fig.3).Deviationsthatmanifestasoutliersinthe
scatterplotcanbeattributedtotworeasons.First,baseimagesforbothSVFdatasetswereacquiredintwodifferentyearsleadingto
spatialsamplingvariations.AdditionalassociatedSVFdifferencesareduetoalterationsinthebuiltenvironment,e.g.,newdevel-
opments,andchangesinvegetationcoverduringthe2-yearperiod.Differencesinacquisitionyears,acquisitiontimeofday,andbuilt
123

| A.Middeletal. |     |     |     | Urban Climate 25 (2018) 120–134 |     |
| ------------- | --- | --- | --- | ------------------------------- | --- |
Fig.3.ComparisonofSkyViewFactorscalculatedfromGoogleStreetViewimagesthatwereclassifiedintoskyvs.non-skypixelsusingdeep
learning(2017imagedata,x-axis)vs.pixel-basedSobelfilterandflood-fillapproach(2015–2016imagedata,y-axis)for1,663,448locationsinthe
Phoenixmetropolitanarea.
structureleadtoawiderspreadofpointsalongtheregressionline.Second,theSobelfilter-basedskydetectionalgorithmunder-
performsifthecontrastbetweenthehorizonlimitationandtheskyistoolowandedgedetectionbecomesdifficult,e.g.,forgrey
buildingsinovercastconditionsorglassbuildingsduringclearskyconditions.Insomecases,brightsurfacessuchaswindowsand
whitewallsareincorrectlyclassifiedassky,anddarkcloudsareidentifiedasobstacles.InFig.3,theclusterofoutlierstothebottom
modified flood-fill)
right (high SVF per deep learning, low SVF per Sobel and represents locations where clouds were wrongly
classifiedasobstacles.Ingeneral,outliersthatarenotclusteredaroundtheregressionlinecanbeattributedtothesecondtypeof
error.
Onaverage,however,theapproachyieldsreliableresultswithanRMSEof0.045andprovidesaviablealternativetohardware-
intensive,morecomplexdeeplearningclassifications.Whilesegmenting1000imagesusingthedeeplearningapproachtakesabout
3minonasingleNVIDIATITANXPascalgraphicscard,theSobelfilterandflood-fillapproachrunsinaregularwebbrowserand
takesabout30s,makingthepresentedapproachmuchmoreefficientandaccessible.
3.2. SkyViewFactorfootprints
Complete GSV image coverage is retrieved and SVFs are calculated for 15 urban areas in Asia, North America, and Europe
(Table1,Fig.4).Thestudysitesarelocatedinvariousclimaticzones(KöppenclimateclassificationtypesAf,BSh,BWh,Cfa,Csb,Csc,
Dwa)andexhibitavarietyofurbanforms,vegetation,andbuildingmaterials.Thearealextentrangesfrom59.1km2(NewYork
City'sboroughManhattan)to23,490km2(Phoenixmetropolitanarea),andthenumberofGSVlocationsvariesfrom57,608(Be′er
Sheva) to 3,736,082 (Tokyo) with a total of 15,938,172 GSV locations. All images were retrieved between December 2015 and
September2016,andimageacquisitiondatesrangefromApril2015toJuly2016.
Table1
StatisticsforSkyViewFactorfootprintdatasetsfrom15citiesaroundtheglobe.
Urbanarea Country Population(2016) Landarea[km2] #ofGSVlocations SVF(average) SVF(stdv)
| Manhattan    | US 1,645,000 | 59.1  | 143,183   | 0.545 | 0.243 |
| ------------ | ------------ | ----- | --------- | ----- | ----- |
| Paris        | FR 2,229,600 | 105.4 | 304,823   | 0.586 | 0.219 |
| Singapore    | SG 5,607,000 | 719.1 | 556,150   | 0.595 | 0.241 |
| Seoul        | KR 9,860,000 | 605.2 | 613,971   | 0.680 | 0.166 |
| Tokyo        | JP 9,273,000 | 2190  | 3,736,082 | 0.693 | 0.178 |
| Vancouver    | CA 647,540   | 115   | 307,856   | 0.713 | 0.234 |
| Philadelphia | US 1,568,000 | 367   | 1,148,238 | 0.720 | 0.249 |
| Bonn         | DE 313,958   | 141.1 | 93,188    | 0.746 | 0.213 |
| SanFrancisco | US 864,816   | 121.4 | 248,483   | 0.811 | 0.185 |
| Dublin       | IE 527,612   | 115   | 573,431   | 0.831 | 0.194 |
LosAngelesmetroarea US 13,131,431 12,561 2,871,850 0.837 0.171
| Be'erSheva       | IL 202,495   | 117.5  | 57,608    | 0.898 | 0.112 |
| ---------------- | ------------ | ------ | --------- | ----- | ----- |
| Dubai            | IE 2,789,000 | 4114   | 609,301   | 0.921 | 0.118 |
| LasVegas         | US 632,912   | 352    | 1,073,711 | 0.938 | 0.116 |
| Phoenixmetroarea | US 4,574,531 | 23,490 | 3,600,297 | 0.947 | 0.097 |
124

.noitagitsevnirednusaeranabrufonoitacoL.4.giF
A.Middeletal. Urban Climate 25 (2018) 120–134
125

A.Middeletal. Urban Climate 25 (2018) 120–134
(captiononnextpage)
126

A.Middeletal. Urban Climate 25 (2018) 120–134
Fig. 5.Sky View Factor distribution for 15 cities around the world, sorted by average Sky View Factor from highest (Phoenix) to lowest
(Manhattan).
Fig.5illustratesthespatialdistributionofSVFsineachurbanarea,arrangedbyaverageSVFmagnitude,fromlargesttosmallest
meanSVF.Similarly,Fig.6showshistogramsoftheSVFdistribution(binsize0.025),inthefollowingreferredtoasSVFfootprints.
The four urban areas with the highest average SVF arePhoenix, Las Vegas, Dubai, andBe′er Sheva. Their SVF footprints are ne-
gativelyskewedwithalongtailtotheleftandnovisiblenormaldistribution.PhoenixandLasVegas,whichshowthehighestaverage
SVFs of 0.947 and 0.938, are very similar in urban form. Both metropolitan areas mostly consist of LCZ 6 (open lowrise) with
detachedresidentialsingle-familyhomesandwidearterialroadswithupto7lanes.LosAngelesandDublinexhibitverysimilarSVF
footprintswithmeanSVFvaluesof0.837and0.831,respectively.BonnandPhiladelphiaalsocomparewellintermsofSVFfootprints
(0.746vs.0.720);bothcitiesfeaturecompactmidrise(LCZ2)neighborhoodswithtownhousesnearthecitycenterandresidential
suburbswith increased treecanopy cover. Tokyo's andSeoul's SVFfootprints average just under 0.7,while Singapore, Paris, and
ManhattanhavethelowestSVFswith0.595,0.586,and0.545.ParisistheonlyurbanareatoexhibitabimodalSVFdistribution,with
apeakat0.550andanotherpeakat0.975.Whilethefirstpeakisrepresentativeoftheinnercityurbanform,thesecondpeakmostly
encompasseslocationsonhighwaysandalongtheSeineriver.Singapore'surbanformwillbediscussedinmoredetailinSection4.1.
4. Usecases
SVF footprints can serve a variety of urban climate applications from micro- to mesoscale. In this section, two use cases are
provided.Thefirstexampledemonstratesthepotentialofdetailedcity-wideSVFinformationforevaluatingWUDAPTlevel0data.
ThesecondexampleoutlineshowSVFfootprintscanbeusedtocalculatesolaraccess(sunduration)atstreetlevel.
4.1. Localclimatezoneevaluation
The LCZ scheme, developed by Stewart and Oke (2012), aims to help standardize methods of UHI observations and doc-
umentationbycharacterizingurbanmorphologyandfunctionatthelocalscale.WUDAPTisacrowdsourcingefforttoestablisha
census of cities globally, starting with L0 level information (LCZs) that provides ranges of spatially averaged, generic UCPs. Ag-
gregatedtoLCZspatialunits,higherleveldata(L1andL2)canbeusedtoassessthequalityofaLCZclassification.Here,WUDAPTL0
dataareevaluatedforSingaporeusingSVFsfromGSV.
ThedefaultprotocolforgeneratingWUDAPTL0dataisbasedonasupervisedrandomforestclassification,implementedinSAGA
GIS,usingfreelyavailablecloud-freeLandsat8imagesandtrainingareasdevelopedinGoogleEarth(Bechteletal.,2015,Conrad
etal.,2015).Here,theSingaporeLCZmapisdeveloped usinganalternative approachbasedontheGoogleEarthEngine(EE),a
cloud-basedplatformforplanetary-scalegeospatialanalysis(Gorelicketal.,2017,Demuzereetal.,underreview).Takingadvantage
ofEE'spublicdatacatalogueofwidelyusedgeospatialdatasets,thefollowinginputfeaturesfortheclassifierareused(coveringthe
period2014–2016):
•
twoLandsat8composites(MaytoSeptemberandNovembertoMarch)includingbands2to7,10,and11;
•
fourspectralindicesderivedfromtheLandsat8bands:minimumandmaximumNormalizedDifferenceVegetationIndex(NDVI),
NormalizedDifferenceWaterIndex(NDWI)andtheNormalizedDifferenceBuiltIndex(NDBI);
•
NormalizedDifferenceUrbanIndex(NDUI)afterZhangetal.(2015),whichcombinesthemaximumofthespectralindiceswith
thecoarseresolutionDefenseMeteorologicalSatelliteProgram/OperationalLinescanSystem(DMSP/OLS)nighttimelightima-
gery;
•
Sentinel-1compositebasedonallSentinel-1datafilteredbyVVsingleco-polarization,theInterferometricWideswathacquisition
modeandbothascendinganddescendingorbits.
The274trainingareasdevelopedforSingaporearerandomlysplitintotraining(70%)andtesting(30%)dataandclassifiedinto
LCZcategories;thisactionisperformed25times,andthefinalLCZmapiscomprisedofthemodalcategory(Fig.7).Verdoncketal.
(2017)stressedtheimportanceofaquantitativeaccuracyassessment,andthereforetheindicessuggestedinBechteletal.(2017)are
used:OA(overallaccuracyofallpixels),OA (overallaccuracyofurbanpixelsonly),OA (overallaccuracyofbuiltvs.naturaltypes
u bu
only,ignoringtheirinternaldifferentiation)andOA (weightedaccuracytakingintoaccountsimilaritybetweenclasses).Finally,the
w
F1metricprovidestheclass-wiseaccuracy(Verdoncketal.,2017).
ThemodalLCZmapandthecorrespondingaccuracymeasuresaredepictedinFig.7.Consideringthebuilt-upclassesonly,the
regionofinterestislargelydominatedbyLCZ3(compactlow-rise,9%),4(openhigh-rise,16.9%)and9(sparselybuilt,22.6%).
IndustrialareasoccupyinglargepartsoftheSouthwestofSingaporearealsoclearlyvisible,representedbyLCZs8(largelow-rise),10
(heavyindustry)andE(barerockorpaved,inthiscaseoildepotsorcontainerportinfrastructure).Themedianoverallaccuracyof
the LCZ map is 70.4%, with similar or higher values for OA , OA and OA . The classification therefore meets the accuracy
u bu w
requirements(>50%forallaccuracymetrics)forreviewandsubsequentdisseminationviatheWUDAPTportal(Bechteletal.,under
review).Theclass-wiseF1metric,however,indicatesastrongvariabilityinaccuracy:LCZs1(compacthigh-rise),3,4,8,A(dense
trees), F (bare soil or sand) and G (water) are generally correctly classified. On the other hand, low skill is obtained for LCZs 2
(compactmid-rise),6(openlow-rise)andD(lowplants).
127

A.Middeletal. Urban Climate 25 (2018) 120–134
(captiononnextpage)
128

A.Middeletal. Urban Climate 25 (2018) 120–134
Fig.6.SkyViewFactorfootprints,sortedfromlargest(Phoenix,topleft)tosmallestfootprint(Manhattan,bottomright)fornGoogleStreetView
locationsineachcity;histogramsshowdistributionofSkyViewFactorsineachcity,averageSkyViewFactor(SVF),andstandarddeviation(see
alsoTable1).
Fig.8providesaLCZclass-wisecomparisonofSVFrangesderivedfromthetrainingareas,thefullLCZmap,andthosesuggested
byStewartandOke(2012).ThevaluesderivedfromthefullLCZmapgenerallymatchthosedirectlyderivedfromthetrainingarea
polygonsonly.ThisalreadydemonstratesthepotentialvalueoftheSVFdatasetinevaluatingWUDAPTL0dataacrossalargerregion
ofinterest.Forthisusecase,theclassifierisabletoretaintherelevantinformationfromthetrainingareasandtransferittothe
remainingout-of-samplepixels.
ThemedianSVFvaluesforthe‘compact’LCZclasses1,2,and3areattheupperendoftherangesreportedbyStewartandOke
(2012),whiletheoppositeistrueforthe‘open’LCZclasses4,5,and6.Thisiscounterintuitive,asonewouldexpecthigherSVF
valuesforopenmid-andlow-risecomparedtotheircompactcounterparts.Thelargelow-rise(LCZ8)andespeciallythesparselybuilt
(LCZ9)classeshavevaluesbelowtherangesreportedbyStewartandOke(2012),whilethemedianoftheheavyindustryclass(LCZ
10)doesfallwithinthereportedrange.ExceptforLCZB(scatteredtrees),thenaturalclasseshavelowerSVFvaluesthantheStewart
andOke(2012)referenceranges.ThisisprobablyduetoalackofGSVimagesamplesinsuchareas,whichisfurtherdiscussedbelow.
4.2. Sunduration
Determiningsolaraccessinstreetcanyons,i.e.theabilitytoreceivesunlightwithoutobstruction,isessentialforheatmitigation
in hot urban areas (Middel et al., 2016) and to estimate the potential for solar heating and photovoltaic electricity production
(Compagnon,2004).Solaraccessvariesbygeographiclocation(latitudeandlongitude),diurnally,andbydayofyear,butitalso
dependsonthehorizonlimitationimposedbythebuiltenvironment.Itcanbequantifiedbyoverlayingasunpathpolardiagramover
ahemisphericalviewsuchastheprocessedfisheyephotos.
AnalgorithmbyBlanco-Murieletal.(2001)isimplementedtocalculatethesunpositionintheformofasolarvectorforanytime
ofthedayandanydayoftheyear.Thediurnalsuntrajectoryisapproximatedbycalculatingthesun'spositionevery15minfora
chosendateandlocation.Theresultingsunpath,givenasazimuthandzenithanglepairs,isprojectedontotheblackandwhitesky/
non-skyGSVfisheyegeneratedduringtheSVFcalculationprocess.Finally,fisheyepixelsinthe8-neighborhoodofeachsunposition
alongthepatharetestedforsunocclusion,andtheunobstructedtimeperiods(atleast5pixelsinthe8-neighborhoodareskypixels)
aresummarizedintototaldailysunduration,i.e.thenumberofhoursofdirectincomingsolarradiationforaspecificlocationand
date.BasedonhemisphericalviewsforManhattanandSanFranciscofromtheSVFdataset,streetnetworkmapsofSVFsanddailysun
durationarecreatedforthetwocitiesforJuly21,2015andNovember2,2016,respectively(Fig.9).Thesemapscanbeusedto
estimate the range of solar-powered cars in street canyons; calculate the energy use for air-conditioning in buildings during the
summermonths;predictsnowmeltinginthewinter;andestimatepedestrianexposuretoUVforskincancerprevention.
5. Discussion
5.1. SkyViewFactorfootprints
Our approach to retrieve SVFs from GSV works at fine spatial scales (distance between GSV locations is typically 5–10m),
includesallavailableGSVlocations(notastratifiedsample),andcanbeusedtoachieveclosetoglobalurbancoverage.GSVimages
areusuallyupdatedannually,whichenableslong-termmonitoringofurbanform.Thepresentedapproachhasseverallimitations.
Theimplementedskydetectionalgorithmhasdifficultiesdiscoveringedgesifthecontrastbetweentwofeatures,e.g.buildingand
sky,istoolow.Also,brightsurfacessuchaswindowsandwhitewallsmightbefalselyclassifiedassky,whiledarkcloudscouldbe
identifiedasobstacles.Althoughtreesarereliablydetectedasskyobstructions,theflood-fillalgorithmoverestimatesthedensityof
treecanopycoverofsparsely-leavedtrees(seevegetationinFigs.2and3).ThisisadvantageousforcomparingSVFsindependentof
imageacquisitiondates,asSVFresultsforleaf-offandleaf-onseasonswillbesimilar,butlimitstheabilitytoinvestigateseasonalSVF
differences.
Currentstate-of-the-artapproachesuseconvolutionalneuralnetworkstosegmentimagesmoreaccuratelyintoskyandnon-sky
regions (Gebru et al., 2017; Iannelli and Dell'Acqua, 2017; Lukasczyk et al., under review). Although these methods yield more
accurateresults,theyrequireanelaboratetrainingprocess,specializedhardware,andincreasedcomputationtime.Asdemonstrated
intheevaluationsection,theSobelfilterandflood-fillapproachyieldsreliableresults(RMSE=0.045)andprovidesaviableand
moreaccessiblealternativetohardware-intensivemachinelearningsolutions.ThepresentedskydetectionandSVFcalculationcan
beperformedinaregularweb-browserandwouldthereforebesuitableforcrowdsourcingSVFs.
GSVdoesnotoffercompletecoveragearoundtheworld.AlthoughGSVdataexistforthesouthernhemisphereoftheglobe(e.g.
São Paulo in Brazil and Kampala in Africa), coverage is less dense in those areas (see https://www.google.com/streetview/
understand/#where). GSV is also not available in some Asian countries, although Baidu provides an alternative for China. With
regardstointra-citycoverage,GSVimagesareinherentlybiasedtowardsstreetlocationsandthereforedonotprovidecontinuous
spatialcoverageoftheurbanenvironment.Under-sampledareasincludeparks,golfcourses,backyards,andnaturalareasingeneral.
This sampling bias becomes particularly evident in the WUDAPT L0 evaluation use case were natural classes exhibit consistently
lowerSVFsthantherecommendedLCZranges.GoogleisconstantlyimprovingStreetViewcoverage,withnewadditionsofhiking
129

.senoZetamilClacoLfonoitpircseddeliatedarof)2102(ekOdnatrawetSeeS.)thgir(seicaruccadna)tfel(pamenoZetamilClacoLeropagniS.7.giF
A.Middeletal. Urban Climate 25 (2018) 120–134
130

A.Middeletal. Urban Climate 25 (2018) 120–134
Fig.8.SkyViewFactorcomparisonforSingapore.ThethickgreybarsareSkyViewFactorrangesfromStewart&Oke(2012),coloredfilledcircles
andlinesarethemedian±1standarddeviationderivedfromthetrainingareas(dashedlines)andforthefullLocalClimateZonemap(fulllines),
respectively.ThecolorsrefertotheLocalClimateZoneclass,asinFig.7.
trails and pedestrian areas captured by 360° cameras mounted on backpacks in recent months. More complete coverage is to be
expected,potentiallyincorporatingstereo-photographyasemployedinGoogleEarth.Untilcontinuouscoverageisavailable,theSVF
approachcouldbecomplementedthroughLidardataordigitalsurfacemodels.
5.2. Localclimatezoneevaluation
CareshouldbetakenwhengeneralizingtheLCZresultsfromSingapore(e.g.Fig.8)toothercities.Anumberoflocalfeatures
imposelimitationsonthequalityoftheLCZclassification,therepresentativenessofGSV-derivedSVFresults,andfinallytheuseof
SVFtoinferaspecificLCZ.TheparticularnatureofSingapore'sbuildingregulationsposechallengestotheaccuratedeterminationof
aspecificLCZ.SimilartomanyotherAsiancities,low-andhigh-risedevelopmentsmayoccurside-by-sideduetochangesinzoning
lawsregulatingthedensityofdevelopmentsand/orheightofbuildings.Consequently,thedowntowncoreoftencontainsamixof
verytall(>100m)andshort(10–15m)buildings,andmanyresidentialareasareinatransitionphasewherevarious2-storeyhigh
buildingsareconvertedinto5-storey,smallapartmentblocks.TheresultsinFig.8arepromising,becausethederivedSVFvalues
showtheexpectedincreasewithdecreasingheightofroughnesselements(inparticularforthe‘compact’builtzones),however,the
rangeacrossLCZs1–6isonlyabout0.3withlittledifferencebetweenthe‘compact’and‘open’builtzones.
NotallLCZsareequallywellrepresentedthroughGSVimagery,whichmayresultinerroneousSVFs.Whilemanyofthecom-
mercialandresidentialzonesarecrisscrossedbyseveralroads,otherzonessufferfromunder-samplingornosamplingatall.For
example,noGSVimagesareavailableforLCZE(mostlyoff-limits)inwhichcasetheSVFistakenfromscatteredpixelsintheLCZ
mapthathavebeenconfusedbytheclassifier,orthatareunder-sampledsuchasLCZ10(partlyoff-limits).Formanyofthenatural
areas(e.g.LCZsB-D),GSVimagesareonlyavailablealongroads,whichwilllikelyresultinanunderpredictionoftheLCZ-wideSVF
giventhefrequentpresenceoftreesplantedalongroads(Fig.8).ThesimilarlowbiasobservedforLCZs4–6mayalsobeduetooften
maturestreettrees,sometimesformingclosedcanopiesabovetheroadsurface,whichareabundantalongmanyresidentialroads.In
thecaseofLCZA,avalueofaround0.3isreasonableconsideringthelocaldensetropicalforests.Whilethesemeasurementissues
contributetolessextremeSVFvalues,thesmallrangeobservedinFig.8isalsorealandareflectionofthefactthatthereareveryfew
expansive,reallydenselybuiltortrulyopenspacesinSingapore.
Finally, asshownabove,evaluation ofLCZs usingSVF valuesshould be approachedwith caution given thevariousissues as-
sociatedwithboththeintrinsicdifficultytoaccuratelydetermineaLCZandtheestimationofrepresentativeSVFsfromGSVimagery.
TheSVFisoneofmanyparametersdefiningaLCZandtherangesgiveninStewartandOke(2012)areprobablybestinterpretedas
approximations ofrealvalues basedonpaststudies andexpectationsforacertainroughness element geometry.ASVFof0.6for
example is indicative of six of the ten LCZs of the ‘Built Zone’ series. Yet, the GSV-derived SVFs provide an accessible, widely-
availableresourcetoanalyzeLCZparametersacrossmultiplecities,becausethemethodologydoesnotdependontheavailabilityof
fine-scaleinformation suchas3-dimensional modelsorLIDARdata. Efforts arecurrentlyunderway tocompareGSVSVFs toLCZ
rangesforvariousWUDAPTdatasetsincludingDublin(Bechteletal.,underreview),Phoenix,andLasVegas(Wangetal.,2018).
5.3. Sunduration
The precision of the calculated sun duration mainly depends on the sky detection accuracy but is also sensitive to seasonal
influencesandimageacquisitiondates.GSVimagesarecollectedduringallseasons,butdeciduoustreesprovidemoresolaraccessat
131

A.Middeletal. Urban Climate 25 (2018) 120–134
Fig.9.SkyViewFactor(top)andsunshinehours(bottom)forManhattan(left)andSanFrancisco(right).
streetlevelduringleaf-offmonthsandincreasedshadefortherestoftheyear,generatingdifferentsundurationoutcomesdepending
ontheseason.Yet,theimpactofdeciduoustreesonsundurationislimitedtomorningandafternoon.Itisalsominimizedatthe
centeroftheroadandinurbanareaswherestreetsarelinedbybuildingsthatdominateshadingovertrees.Treepruningfurther
impactsshadepatternsinstreetcanyons,andsodourbaninfrastructurechangessuchastheadditionofnewbuildings.Processingthe
mostrecentGSVdatasettoretrieveSVFsiscrucialtoyieldreliablesundurationresults.
6. Conclusions
UCPs are crucial descriptors of urban form that resolve the spatial heterogeneity for urban climate applications. This study
introducesaninnovativeapproachtocalculateUCPsfromGoogleimagery,specificallyfocusingontheSVFasadimension-reduced
metric representative of 3-dimensional urban form. This methodology enables the retrieval or urban morphology from a human-
centricstreetcanyonperspectiveatlowcomputationalcostswithminimumhardwarerequirements.CalculatingtypicalSVFfoot-
printsfor15citiesaroundtheworld,thisstudydemonstrateshowSVFsfromGSVcanbeusedtoestimatesundurationandtoassess
the quality of WUDAPT L0 data. Scaled up to other geographic locations, the growing SVF dataset can inform various climate
132

A.Middeletal. Urban Climate 25 (2018) 120–134
modelingeffortsaroundtheworld,frommicroscaletomesoscale,andisafirststeptowardsbuildingadatabaseofL1informationfor
theWUDAPTportal,complementarytootherUCPsfromGSVsuchasbuildingandtreefractionsthatarecurrentlybeingprocessed
(Lukasczyketal.,underreview).Fine-scalestandardizedandgloballyavailableUCPsareparamountinobservationandmodeling
effortstodeepentheunderstandingofurbanclimatedynamicsastheyrelatetotheformandfunctionofcities.Big-Dataapproaches
suchastheGSVapplicationpresentedinthisstudyhighlightnewinnovativepathsfortheurbanclimatecommunitytoachievethis
goal.
Acknowledgements
This research was sponsored by Technische Universität Kaiserslautern, grant “Microclimate Data Collection, Analysis, and
Visualization”andsupportedbyNationalScienceFoundation(NSF)AwardNumber1635490,“ASimulationPlatformtoEnhance
InfrastructureandCommunityResiliencetoExtremeHeatEvents.”andNSFAwardNumber1639227,“FlexibleModelCompositions
andVisualRepresentationsforPlanningandPolicyDecisionsfortheFood-Energy-WaterNexus”.Anyopinions,findings,andcon-
clusions or recommendations expressed in this material are those of the authors and do not necessarily reflect the views of the
sponsoringorganizations.
References
Ali-Toudert,F.,Mayer,H.,2007.Effectsofasymmetry,galleries,overhangingfaçadesandvegetationonthermalcomfortinurbanstreetcanyons.Sol.Energy81(6),
742–754.
An,S.M.,Kim,B.S.,Lee,H.Y.,Kim,C.H.,Yi,C.Y.,Eum,J.H.,Woo,J.H.,2014.Three-dimensionalpointcloudbasedskyviewfactoranalysisincomplexurbansettings.
Int.J.Climatol.34(8),2685–2701.
Bechtel,B.,Alexander,P.J.,Böhner,J.,Ching,J.,Conrad,O.,Feddema,J.,Mills,G.,See,L.,Stewart,I.,2015.Mappinglocalclimatezonesforaworldwidedatabaseof
theformandfunctionofcities.ISPRSInt.J.Geo-Inform.4(1),199–219.
Bechtel,Benjamin,Demuzere,Matthias,Sismanidis,Panagiotis,Fenner,Daniel,Brousse,Oscar,Beck,Christoph,VanCoillie,Frieke,etal.,2017.Qualityofcrowd-
sourceddataonurbanmorphology—thehumaninfluenceexperiment(HUMINEX).UrbanSci.1(2).http://dx.doi.org/10.3390/urbansci1020015.
Bechtel,B.,Alexander,P.J.,Beck,C.,Brousse,O.,Ching,J.,Demuzere,M.,Gal,T.,Hidalgo,J.,Hoffman,P.,Middel,A.M.,Mills,G.,Ren,C.,See,L.,Sismanidis,P.,
Verdonck,M.-L.,Xu,G.,Xu,Y.,underreview,GeneratingWUDAPTLevel0data-currentstatusofproductionandevaluation.UrbanClim..
Blanco-Muriel,M.,Alarcón-Padilla,D.C.,López-Moratalla,T.,Lara-Coira,M.,2001.Computingthesolarvector.Sol.Energy70(5),431–441.
Brousse,O.,Martilli,A.,Foley,M.,Mills,G.,Bechtel,B.,2016.WUDAPT,anefficientlanduseproducingdatatoolformesoscalemodels?IntegrationofurbanLCZin
WRFoverMadrid.UrbanClim.17(SupplementC),116–134.
Carter,M.,Shepherd,J.M.,Burian,S.,Jeyachandran,I.,2011.IntegrationofLidardataintoacoupledmesoscale–landsurfacemodel:atheoreticalassessmentof
sensitivityofurban–coastalmesoscalecirculationstourbancanopyparameters.J.Atmos.Ocean.Technol.29(3),328–346.
Chapman,L.,Thornes,J.,2004.Real-timesky-viewfactorcalculationandapproximation.J.Atmos.Ocean.Technol.21(5),730–741.
Chapman,L.,Thornes,J.E.,Bradley,A.V.,2001.Rapiddeterminationofcanyongeometryparametersforuseinsurfaceradiationbudgets.Theor.Appl.Climatol.69
(1–2),81–89.
Chen,F.,Kusaka,H.,Bornstein,R.,Ching,J.,Grimmond,C.S.B.,Grossman-Clarke,S.,Loridan,T.,Manning,K.W.,Martilli,A.,Miao,S.,Sailor,D.,Salamanca,F.P.,
Taha,H.,Tewari,M.,Wang,X.,Wyszogrodzki,A.A.,Zhang,C.,2011.TheintegratedWRF/urbanmodellingsystem:development,evaluation,andapplicationsto
urbanenvironmentalproblems.Int.J.Climatol.31(2),273–288.
Chen,L.,Ng,E.,An,X.,Ren,C.,Lee,M.,Wang,U.,He,Z.,2012.Skyviewfactoranalysisofstreetcanyonsanditsimplicationsfordaytimeintra-urbanairtemperature
differentialsinhigh-rise,high-densityurbanareasofHongKong:aGIS-basedsimulationapproach.Int.J.Climatol.32(1),121–136.
Ching,J.,2013.Aperspectiveonurbancanopylayermodelingforweather,climateandairqualityapplications.UrbanClim.3,13–39.
Ching,J.,Brown,M.,Mcpherson,T.,Burian,S.,Chen,F.,Cionco,R.,Hanna,A.,Hultgren,T.,Sailor,D.,Taha,H.,Williams,D.,2009.Nationalurbandatabaseand
accessportaltool.Bull.Am.Meteorol.Soc.90(8),1157–1168.
Ching,J.,Mills,G.,Bechtel,B.,See,L.,Feddema,J.,Wang,X.,Ren,C.,Brousse,O.,Martilli,A.,Neophytou,M.,Mouzourides,P.,Stewart,I.,Hanna,A.,Ng,E.,Foley,
M.,Alexander,P.,Aliaga,D.,Niyogi,D.,Shreevastava,A.,Bhalachandran,P.,Masson,V.,Hidalgo,J.,Fung,J.,Andrade,M.,Baklanov,A.,Dai,W.,Milcinski,G.,
Demuzere,M.,Brunsell,N.,Pesaresi,M.,Miao,S.,Mu,Q.,Chen,F.,Theeuwes,N.,2018.WorldUrbanDatabaseandAccessPortalTools(WUDAPT),anurban
weather,climateandenvironmentalmodelinginfrastructurefortheAnthropocene.Bull.Am.Meteorol.Soc.http://dx.doi.org/10.1175/BAMS-D-16-0236.1.
Compagnon,R.,2004.Solaranddaylightavailabilityintheurbanfabric.Energ.Build.36(4),321–328.
Conrad,O.,Bechtel,B.,Bock,M.,Dietrich,H.,Fischer,E.,Gerlitz,L.,Wehberg,J.,Wichmann,V.,Böhner,J.,2015.Systemforautomatedgeoscientificanalyses
(SAGA)v.2.1.4.Geosci.ModelDev.8(7),1991–2007.
Demuzere,M.,Harshan,S.,Järvi,L.,Roth,M.,Grimmond,C.S.B.,Masson,V.,Oleson,K.W.,Velasco,E.,Wouters,H.,2017.Impactofurbancanopymodelsand
externalparametersonthemodelledurbanenergybalanceinatropicalcity.Q.J.R.Meteorol.Soc.143(704),1581–1596.http://dx.doi.org/10.1002/qj.3028.
Demuzere,M.,Bechtel,B.,Mills,G.,underreview.Globaltransferabilityoflocalclimatezonemodels.UrbanClim.
Gál,T.,Unger,J.,2014.AnewsoftwaretoolforSVFcalculationsusingbuildingandtree-crowndatabases.UrbanClim.10,594–606.
Gál,T.,Lindberg,F.,Unger,J.,2009.Computingcontinuousskyviewfactorsusing3Durbanrasterandvectordatabases:comparisonandapplicationtourbanclimate.
Theor.Appl.Climatol.95(1–2),111–123.
Gebru,T.,Krause,J.,Wang,Y.,Chen,D.,Deng,J.,Aiden,E.L.,Fei-Fei,L.,2017.UsingdeeplearningandGoogleStreetViewtoestimatethedemographicmakeupof
neighborhoodsacrosstheUnitedStates.Proc.Natl.Acad.Sci.114(50),13108–13113.
Gorelick,N.,Hancher,M.,Dixon,M.,Ilyushchenko,S.,Thau,D.,Moore,R.,2017.Googleearthengine:planetary-scalegeospatialanalysisforeveryone.RemoteSens.
Environ.http://dx.doi.org/10.1016/j.rse.2017.06.031.
Grimmond,C.S.B.,Oke,T.R.,1999.Aerodynamicpropertiesofurbanareasderivedfromanalysisofsurfaceform.J.Appl.Meteorol.38(9),1262–1292.
Grimmond,C.,Potter,S.,Zutter,H.,Souch,C.,2001.Rapidmethodstoestimatesky-viewfactorsappliedtourbanareas.Int.J.Climatol.21(7),903–913.
Guo,G.,Zhou,X.,Wu,Z.,Xiao,R.,Chen,Y.,2016.CharacterizingtheimpactofurbanmorphologyheterogeneityonlandsurfacetemperatureinGuangzhou,China.
Environ.Model.Softw.84(SupplementC),427–439.
Hammerberg,K.,Brousse,O.,Martilli,A.,Mahdavi,A.,2018.Implicationsofemployingdetailedurbancanopyparametersformesoscaleclimatemodelling:a
comparisonbetweenWUDAPTandGISdatabasesoverVienna,Austria.Int.J.Climatol.http://dx.doi.org/10.1002/joc.5447.
Hofierka,J.,Kaňuk,J.,2009.Assessmentofphotovoltaicpotentialinurbanareasusingopen-sourcesolarradiationtools.Renew.Energy34(10),2206–2214.
Iannelli,G.C.,Dell'acqua,F.,2017.Extensiveexposuremappinginurbanareasthroughdeepanalysisofstreet-levelpicturesforfloorcountdetermination.UrbanSci.1
(2),16.
Johansson,E.,2006.Influenceofurbangeometryonoutdoorthermalcomfortinahotdryclimate:astudyinFez,Morocco.Build.Environ.41(10),1326–1338.
Johnson,G.T.,Watson,I.D.,1984.Thedeterminationofview-factorsinurbancanyons.J.Clim.Appl.Meteorol.23(2),329–335.
Laungrungthip,N.,Mckinnon,A.E.,Churcher,C.D.,Unsworth,K.,2008.Edge-baseddetectionofskyregionsinimagesforsolarexposureprediction.In:Paper
Presentedatthe200823rdInternationalConferenceImageandVisionComputingNewZealand.
133

A.Middeletal. Urban Climate 25 (2018) 120–134
Li,X.,Li,W.,Middel,A.,Harlan,S.,Brazel,A.,Turner,B.,2016.RemotesensingofthesurfaceurbanheatislandandlandarchitectureinPhoenix,Arizona:combined
effectsoflandcompositionandconfigurationandcadastral–demographic–economicfactors.RemoteSens.Environ.174,233–243.
Li,Y.,Miao,S.,Chen,F.,Liu,Y.,2017.Introducingandevaluatinganewbuilding-heightcategorizationbasedonthefractaldimensionintothecoupledWRF/urban
model.Int.J.Climatol.37(7),3111–3122.
Lindberg,F.,Grimmond,C.,2010.Continuousskyviewfactormapsfromhighresolutionurbandigitalelevationmodels.Clim.Res.42(3),177–183.
Lindberg,F.,Holmer,B.,Thorsson,S.,2008.SOLWEIG1.0–modellingspatialvariationsof3Dradiantfluxesandmeanradianttemperatureincomplexurbansettings.
Int.J.Biometeorol.52(7),697–713.
Lukasczyk,J.,Middel,A.,Zakrzewski,S.,Arnold,M.,Maciejewski,R.,underreview,Urbanformandcompositionofstreetcanyons:ahuman-centricbigdataanddeep
learningapproach,Landsc.UrbanPlan.
Marquez,L.O.,Smith,N.C.,1999.Aframeworkforlinkingurbanformandairquality.Environ.Model.Softw.14(6),541–548.
Martilli,A.,Clappier,A.,Rotach,M.W.,2002.Anurbansurfaceexchangeparameterisationformesoscalemodels.Bound.-LayerMeteorol.104(2),261–304.
Matzarakis,A.,Rutz,F.,Mayer,H.,2010.Modellingradiationfluxesinsimpleandcomplexenvironments:basicsoftheRayManmodel.Int.J.Biometeorol.54(2),
131–139.
Middel,A.,Häb,K.,Brazel,A.J.,Martin,C.,Guhathakurta,S.,2014.ImpactofurbanformanddesignonmicroclimateinPhoenix,AZ.Landsc.UrbanPlan.122,16–28.
Middel,A.,Selover,N.,Hagen,B.,Chhetri,N.,2016.Impactofshadeonoutdoorthermalcomfort—aseasonalfieldstudyinTempe,Arizona.Int.J.Biometeorol.1–13.
Middel,A.,Lukasczyk,J.,Maciejewski,R.,2017.Skyviewfactorsfromsyntheticfisheyephotosforthermalcomfortrouting—acasestudyinPhoenix,Arizona.Urban
Plan.2(1),19–30.
Mills,G.,Ching,J.,See,L.,Bechtel,B.,Foley,M.,2015.AnintroductiontotheWUDAPTproject.In:9thInternationalConferenceonUrbanClimate,Toulouse.
Ng,E.,Yuan,C.,Chen,L.,Ren,C.,Fung,J.C.,2011.Improvingthewindenvironmentinhigh-densitycitiesbyunderstandingurbanmorphologyandsurface
roughness:astudyinHongKong.Landsc.UrbanPlan.101(1),59–74.
Oke,T.R.,1981.Canyongeometryandthenocturnalurbanheatisland:comparisonofscalemodelandfieldobservations.J.Climatol.1(3),237–254.
Ratti,C.,Baker,N.,Steemers,K.,2005.Energyconsumptionandurbantexture.Energ.Build.37(7),762–776.
Salamanca,F.,Martilli,A.,Tewari,M.,Chen,F.,2010.Astudyoftheurbanboundarylayerusingdifferenturbanparameterizationsandhigh-resolutionurbancanopy
parameterswithWRF.J.Appl.Meteorol.Climatol.50(5),1107–1128.
Sobel,I.,Feldman,G.,1968.A3×3IsotropicGradientOperatorforImageProcessing. presentedattheStanfordArtificialIntelligenceProject(SAIL)in..
Stewart,I.D.,Oke,T.R.,2012.Localclimatezonesforurbantemperaturestudies.Bull.Am.Meteorol.Soc.93(12),1879–1900.
Steyn,D.G.,1980.Thecalculationofviewfactorsfromfisheye-lensphotographs:researchnote.Atmosphere-Ocean18,254–258.
Steyn,D.G.,Hay,J.,Watson,I.D.,Johnson,G.T.,1986.Thedeterminationofskyview-factorsinurbanenvironmentsusingvideoimagery.J.Atmos.Ocean.Technol.3
(4),759–764.
Stone,B.,2008.UrbansprawlandairqualityinlargeUScities.J.Environ.Manag.86(4),688–698.
Svensson,M.K.,2004.Skyviewfactoranalysis–implicationsforurbanairtemperaturedifferences.Meteorol.Appl.11(3),201–211.
Unger,János,2004.Intra-urbanrelationshipbetweensurfacegeometryandurbanheatisland:reviewandnewapproach.Clim.Res.27,253–264.
Unger,J.,2009.Connectionbetweenurbanheatislandandskyviewfactorapproximatedbyasoftwaretoolona3Durbandatabase.Int.J.Environ.Pollut.36(1–3),
59–80.
Verdonck,M.-L.,Okujeni,A.,vanderLinden,S.,Demuzere,M.,DeWulf,R.,VanCoillie,F.,2017.Influenceofneighbourhoodinformationon‘localclimatezone’
mappinginheterogeneouscities.Int.J.Appl.EarthObs.Geoinf.62.http://dx.doi.org/10.1016/j.jag.2017.05.017.
Wang,C.,Middel,A.,Myint,S.W.,Kaplan,S.,Brazel,A.J.,Lukasczyk,J.,2018.Assessinglocalclimatezonesinaridcities:thecaseofPhoenix,ArizonaandLasVegas,
Nevada.ISPRSJ.Photogramm.Remote.Sens.141,59–71.http://dx.doi.org/10.1016/j.isprsjprs.2018.04.009. http://www.sciencedirect.com/science/article/
pii/S0924271618301217(ISSN0924-2716,Keywords:Localclimatezone;Landuselandcover;Skyviewfactor;Landsurfacetemperature;Phoenix;LasVegas).
Xu,Y.,Ren,C.,Ma,P.,Ho,J.,Wang,W.,Lau,K.K.-L.,Lin,H.,Ng,E.,2017.Urbanmorphologydetectionandcomputationforurbanclimateresearch.Landsc.Urban
Plan.167,212–224.
Zakšek,Klemen,Oštir,Kristof,Kokalj,Žiga,2011.Sky-viewfactorasareliefvisualizationtechnique.RemoteSens.3(2),398–415.
Zhang,Q.,Li,B.,Thau,D.,Moore,R.,2015.Buildingabetterurbanpicture:combiningdayandnightremotesensingimagery.RemoteSens.7(9),11887–11913.
134
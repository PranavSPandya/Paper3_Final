UrbanPlanning(ISSN:2183–7635)
2017,Volume2,Issue1,Pages19–30
DOI:10.17645/up.v2i1.855
Article
Sky View Factors from Synthetic Fisheye Photos for Thermal Comfort
Routing—A Case Study in Phoenix, Arizona
ArianeMiddel1,*,JonasLukasczyk2andRossMaciejewski3
1SchoolofGeographicalSciencesandUrbanPlanning,ArizonaStateUniversity,Tempe,AZ85281,USA;
E-Mail:ariane.middel@asu.edu
2DepartmentofComputerScience,UniversityofKaiserslautern,67663Kaiserslautern,Germany;
E-Mail:j_lukasczy09@informatik.uni-kl.de
3SchoolofComputing,Informatics&DecisionSystemsEngineering,ArizonaStateUniversity,Tempe,AZ85281,USA;
E-Mail:rmacieje@asu.edu
*Correspondingauthor
Submitted:15January2017|Accepted:9March2017|Published:27March2017
Abstract
TheSkyViewFactor(SVF)isadimension-reducedrepresentationofurbanformandoneofthemajorvariablesinradiation
modelsthatestimateoutdoorthermalcomfort.CommonwaysofretrievingSVFsinurbanenvironmentsincludecapturing
fisheyephotographsorcreatingadigital3Dcityorelevationmodeloftheenvironment.Suchtechniqueshavepreviously
beenlimitedduetoalackofimageryorlackoffullscaledetailedmodelsofurbanareas.Wedevelopedawebbasedtool
thatautomaticallygeneratessynthetichemisphericalfisheyeviewsfromGoogleEarthatarbitraryspatialresolutionand
calculatesthecorrespondingSVFsthroughequiangularprojection.SVFresultswerevalidatedusingGoogleMapsStreet
ViewandcomparedtoresultsfromotherSVFcalculationtools.Wegenerated5-meterresolutionSVFmapsfortwoneigh-
borhoodsinPhoenix,Arizonatoillustratefine-scalevariationsofintra-urbanhorizonlimitationsduetourbanformand
vegetation.Todemonstratetheutilityofoursyntheticfisheyeapproachforheatstressapplications,weautomatedara-
diationmodeltogenerateoutdoorthermalcomfortmapsforArizonaStateUniversity’sTempecampusforahotsummer
dayusingsyntheticfisheyephotosandon-sitemeteorologicaldata.Modeloutputwastestedagainstmobiletransectmea-
surementsofthesix-directionalradiantfluxdensity.Basedonthethermalcomfortmaps,weimplementedapedestrian
routingalgorithmthatisoptimizedfordistanceandthermalcomfortpreferences.Oursyntheticfisheyeapproachcanhelp
plannersassessurbandesignandtreeplantingstrategiestomaximizethermalcomfortoutcomesandcansupportheat
hazardmitigationinurbanareas.
Keywords
climate-sensitiveurbandesign;desertcity;heat;MRT;outdoorthermalcomfort;PET;skyviewfactor;thermalcomfort
routing;urbanform;walkability
Issue
Thisarticleispartoftheissue“UrbanFormsandFutureCities”,editedbyLucaD’Acci(ErasmusUniversityRotterdam,The
Netherlands),TigranHaas(KTHRoyalInstituteofTechnology,Sweden)andRonitaBardhan(IndianInstituteofTechnology
Bombay,India)
©2017bytheauthors;licenseeCogitatio(Lisbon,Portugal).ThisarticleislicensedunderaCreativeCommonsAttribu-
tion4.0InternationalLicense(CCBY).
1.Introduction lic health (National Oceanic and Atmospheric Adminis-
tration [NOAA], 2015). Exposure to extreme heat is ex-
Heat is the leading cause of weather-related mortal- pected to increase in the future, as rapid urbanization
ity in the U.S and poses a significant threat to pub- continuesandheatwavesareprojectedtobecomemore
UrbanPlanning,2017,Volume2,Issue1,Pages19–30 19

intense,morefrequent,andlongerlasting(Jonesetal., banareas,butrequiresageometricobstaclefile.More
2015). Past research has shown that daytime heat can recently, studies have presented continuous SVF calcu-
be reduced through microclimate-responsive urban de- lations using 3D city models (Chen et al., 2012; Gál et
sign that acknowledges the cooling potential of urban al.,2009;Unger,2009;White,Hu,Langenheim,Ding,&
form and vegetation (Erell, Pearlmutter, & Williamson, Burry, 2016), but these calculations usually do not in-
2012; Lenzholzer & Brown, 2016). Dense urban forms corporatevegetation.Treecanopycoversignificantlyre-
cancreatelocalcoolislandsduringthedayandarepar- duces SVF at the pedestrian level and is an important
ticularly effective at mitigating heat in hot desert envi- shadesourcethatshouldbeincorporatedinviewfactor
ronments where water is scarce (Middel, Häb, Brazel, analysesandoutdoorthermalcomfortassessments.The
Martin, & Guhathakurta, 2014; Pearlmutter, Bitan, & SOLWEIGmodelhasbeensuccessfullyappliedtocalcu-
Berliner,1999). late SVF and MRT for urban areas using digital surface
Heat is most commonly expressed as air temper- models(DSMs)asrepresentationoftheurbanmorphol-
ature, but temperature alone is not a comprehensive ogy (Chen, Yu, Yang, & Mayer, 2016; Lindberg & Grim-
indicator of outdoor thermal comfort or stress. Ther- mond,2011;Lindberg,Holmer,&Thornsson,2008).Al-
mal comfort is influenced by numerous environmental though trees have recently been added into SOLWEIG,
factors,includingtemperature,radiation,humidity,and theuseofDSMsdoesnotallowtomodelcomplexurban
wind speed; and personal factors, such as clothing and forms,suchasbuildingoverhangsandshadestructures.
activity level (Ng & Cheng, 2012; Nikolopoulou & Lyk- We developed a methodology to calculate SVFs for
oudis,2006; Vanos,Warland,Gillespie, & Kenny,2010). large urban areas at high spatial resolution using syn-
In outdoor spaces, radiation is one of the most impor- thetically generated fisheye images from Google Earth.
tantvariablesaffectingthermalcomfort;perceivedther- OurapproachcalculatesSVFsforlargeurbanareasincor-
malcomfortcanvaryseveraldegreesintheshadeand porating the full 3D environment, including vegetation,
sun (Mayer & Höppe, 1987; Middel, Selover, Hagen, & andisindependentofavailable3Dbuildingdatabasesor
Chhetri, 2016). Thermal conditions in urban areas vary DSMs.Asanexample,weproduced5mresolutionSVF
widelyduetocomplexshadingpatternsfrombuildings mapsfortwoneighborhoodsin thePhoenixmetropoli-
andtreesthatdeterminesolaraccessatthepedestrian tanareaoverlaidoverGoogleEarthterrain.Toshowthe
level.Therefore,airtemperaturemapsfailtoaccurately utilityofourapproachforthermalcomfortandwalkabil-
representthesignificantvariationofthermalconditions ityassessments,wegeneratedthermalcomfortmapsof
inbuiltenvironments. ArizonaStateUniversity’sTempecampusforahotsum-
Inurbanclimateresearch,theSkyViewFactor(SVF) merdayinAugust2016usingGoogleEarthhemispheri-
hasbeenwidelyusedasapproximationofthe3Durban calimagesandmeteorologicaldatafromanon-sitefield
geometrytoassesstheurbanheatisland(UHI)andlong- campaign.Wethenutilizedaroutingalgorithmforpedes-
wave radiative heat loss in cities at night (Brandsma & triannavigationthatisoptimizedfordistanceandindivid-
Wolters,2012;Gál,Lindberg,&Unger,2009;Oke,1981; ualoutdoorthermalcomfortpreferences.
Unger,2004).SVFisdefinedasthefractionofvisiblesky
onahemisphereandrangesfromzerotoone,denoting 2.Methods
theratiooftheradiationreceived(emitted)byaplanar
surfacetotheradiationemitted(received)bytheentire To assess intra-urban SVF variations in select neighbor-
hemisphere (Johnson & Watson, 1984). SVF is relevant hoods in the Phoenix metropolitan area, we retrieved
to human thermal comfort, as it affects Mean Radiant datafromGoogleEarthona5mresolutiongridtogen-
Temperature(MRT),asyntheticparameterthatsumma- eratesynthetic180°hemisphericalviewsoftheskyfrom
rizes the direct and reflected short and longwave radi- 3Dbuildings,trees,andterrain.Weremovedtheskypor-
ation fluxes a human body is exposed to. MRT is one tion of the fisheye photos and calculated the SVF for
of the most important meteorological variables in the eachlocationonthegridthroughequiangularprojection.
assessment of thermal comfort and the basis for many Subsequently,wecalculatedMRTandathermalcomfort
human thermal comfort indices (Johansson, Thorsson, index using the synthetic fisheyes as input for an auto-
Emmanuel, & Krüger, 2014; Lee, Holst, & Mayer, 2013; matedradiationmodeltoinformourcasestudy.
Thorsson,Lindberg,Eliasson,&Holmer,2007).
Numerousmodelshavebeendevelopedtocalculate 2.1.RetrievingDatafromGoogleEarth
SVFandMRTinurbansettingsatdifferentspatialscales
and with varying data requirements. Matzarakis, Rutz GoogleEarthversion7allowsuserstorendera3Dmesh
and Mayer (2007, 2010) developed RayMan to model ofthegroundthatincludesbuildings,trees,shrubs,and
SVF and MRT from hemispherical photos and meteoro- otherobstacles.The3Dmeshisgeneratedfromoblique
logicalobservations.Themodelhasbeenshowntoper- imagerycollectedduringGoogleoverflightcampaignsat
form reasonably well in homogeneous urban environ- a 45° angle in each cardinal direction and down. The
ments (Lee & Mayer, 2016), yet it is limited to a single aerialimageryisautomaticallyconvertedintoa3Dcity
pointinspace. TheSkyHeliosmodel(Matzarakis&Ma- model using stereo-photogrammetry and serves as tex-
tuschek, 2011) simulates continuous SVFs for small ur- tureforthe3Dmeshsothatthescenecanberendered.
UrbanPlanning,2017,Volume2,Issue1,Pages19–30 20

AsthecurrentGoogleEarthApplicationProgrammingIn- Watson,1984);vector-basedmethodsthatcalculatethe
terface(API)doesnotprovideafunctiontoexportren- SVFfromprojectedbuildingenvelopesontheskyusing
deredimages,weusedaNodeJSservertoremotelycon- a3Dbuildingdatabase(Chenetal.,2012;Gáletal.2009;
trol a browser that runs the Google Earth plugin and Gál&Unger,2014;Unger,2009);raster-basedmethods
takes screenshots of the browser window through the thatusedigitalelevationmodels(DEMs)orDSMstoesti-
operatingsystemAPI.First,ouralgorithmrequestsmap mateSVFsbasedonpixelheightsorshadowcasting(Gál
tilesfromtheGoogleMapsserviceforanareaofinterest etal.,2009;Lindberg&Grimmond,2011;Lindbergetal.,
definedbyan array of map tile coordinates and a sam- 2008; Ratti, Baker, & Steemers, 2005; Zakšek, Oštir, &
plingresolution,inourcase5m,todeterminesampling Kokalj, 2011), and photographic methods that use fish-
locations.Buildingsandwaterbodiesareexcludedfrom eyeimageryoftheupperhemisphere(Bradley,Thornes,
thesampling.ThealgorithmgeneratesaKeyholeMarkup & Chapman, 2001; Chapman & Thornes, 2004; Grim-
Language(KML)filewiththecoordinatesofthelocations mond, Potter, Zutter, & Souch, 2001; Holmer, Postgård,
to steer the virtual camera in Google Earth. Then, the &Eriksson,2001).Thehemispherichorizonlimitationis
cameratakesatouralongthepredefinedroute,andthe usuallyprojectedona2Dplanetocalculatetheamount
operatingsystemAPItakesascreenshotaftertheGoogle of visible sky in the scene. The most widely used pro-
Earthpluginfinishesloadingthe3Dmeshateachcam- jectiontechniqueistheequiangularprojectionbySteyn
eralocation.Thecameraviewangleissetto90°andthe (1980),wheretheprojectedimageisdividedintoconcen-
height is set to 1.1 m above ground level. 1.1 m is the tric annuli of equal width and then evaluated. We use
recommendedheightforhumanthermalcomfortappli- amodifiedversionofthemanualSteyn-methodfordig-
cations,asitrepresentsthecenterofgravityofthehu- itized fisheye photographs that was proposed by Chap-
manbodyforstandingsubjects(ISO7726,1998).Theal- man,ThornesandBradley(2001).Wepartitionthesyn-
gorithmtakesfivescreenshotsateachlocation—onein theticfisheyepictureintonannularrings(defaultn=36)
eachcardinaldirectionandoneupwards(Figure1a). andcalculatetheSVFbysummingupthecontributionof
eachring:
2.2.FisheyeProjection
n
|     |     |     |     |     |     |     | π    | π(2i−1) | p   |
| --- | --- | --- | --- | --- | --- | --- | ---- | ------- | --- |
|     |     |     |     |     |     |     | SVF= | 􏾜sin􏿶   | i   |
􏿹􏿶 􏿹
After data retrieval, we generate synthetic fisheye im- 2n 2n t
|     |     |     |     |     |     |     |     | i=1 | i   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
agesusinganangularfisheyeprojectionofthesurround-
|         |            |              |         |             |     | wherep/t | istheratiobetweenthenumberofskypixels |     |     |
| ------- | ---------- | ------------ | ------- | ----------- | --- | -------- | ------------------------------------- | --- | --- |
| ings on | a 2D plane | (Figure 1b). | For the | projection, | we  |          | i i                                   |     |     |
tothetotalnumberofpixelsinringi(Figure1d).
treattheimagesasacubemapandperformraycasting
| in WebGL. | Specifically, | we represent | the | fisheye | image |     |     |     |     |
| --------- | ------------- | ------------ | --- | ------- | ----- | --- | --- | --- | --- |
2.4.ThermalComfortModeling
| asaunitsquarewithcenterc |                    |     | = (0,0)andcalculatefor |              |     |     |     |     |     |
| ------------------------ | ------------------ | --- | ---------------------- | ------------ | --- | --- | --- | --- | --- |
| eachpointp               | = (u,v)withlengthr |     | = ‖p‖                  | ≤ 0.5thecor- |     |     |     |     |     |
PhysiologicallyEquivalentTemperature(PET)isawidely-
respondingpositionontheunithemisphere.Pointswith
|     |     |     |     |     |     | used thermal | comfort | index that is | based on MRT, re- |
| --- | --- | --- | --- | --- | --- | ------------ | ------- | ------------- | ----------------- |
r > 0.5arenotpartofthefisheyeandarethereforecol-
|     |     |     |     |     |     | ported | in °C, and expresses | how | people experience |
| --- | --- | --- | --- | --- | --- | ------ | -------------------- | --- | ----------------- |
oredwhite.Forallotherpoints,thepositiononthehemi-
weatherconditions,incorporatingtheradiativeenviron-
sphereisgivenby
mentandpersonalcharacteristics,suchasage,clothing,
|     |     | ⎛   | ⎞   |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
sin(θ)u
|     |     | ⎜ ⎜ | r⎟ ⎟ |     |     | andmetabolicrate(Höppe,1999;Mayer&Höppe,1987). |     |     |     |
| --- | --- | --- | ---- | --- | --- | ---------------------------------------------- | --- | --- | --- |
|     |     | ⎜   | ⎟    |     |     |                                                |     |     |     |
v=⎜ ⎜ sin(θ)v ⎟ ⎟ The1DRayManmodel(Matzarakisetal.,2007,2010)has
|     |     | ⎝   | r ⎠ |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
cos(θ)
|     |     |     |     |     |     | been extensively | employed | to estimate | MRT, PET, and |
| --- | --- | --- | --- | --- | --- | ---------------- | -------- | ----------- | ------------- |
otherthermalcomfortindicesfromfisheyephotographs,
withlatitudeθ=rπandnormalizeddirectionvector
meteorological,andpersonalfactors(Coutts,White,Tap-
|     |     | ⎧ p |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
⎪ ⎪
|     |       | ⎨     | ifr>0     |     |     | per,Beringer,&Livesley,2016;Herrmann&Matzarakis, |     |     |     |
| --- | ----- | ----- | --------- | --- | --- | ------------------------------------------------ | --- | --- | --- |
|     | (u ,v | )=⎪ r |           |     |     |                                                  |     |     |     |
|     | r     | r ⎪⎩  |           |     |     | 2012;Johansson&Emmanuel,2006;Krüger,Minella,&    |     |     |     |
|     |       | (0,0) | otherwise |     |     |                                                  |     |     |     |
Rasia,2011;Lin,2009;Lin,Matzarakis,&Hwang,2010;
Subsequently, the vector v is used to sample the cube Oliveira, Andrade, & Vaz, 2011; Thorsson, Lindqvist, &
Lindqvist,2004),followingequationsoutlinedintheGer-
map,yieldingthefinalfisheyeimage.Thehemispherical
viewisthenconvertedtoblackandwhite(white=sky; manVDIengineeringstandards(VereinDeutscherInge-
black=obstacles)usingadeterministicskycolorgradi- nieure,1994).WeautomatedtheWindowsGUIusinga
scriptthatsimulateskeystrokestoremotelyexecutethe
ent(Figure1c).
|     |     |     |     |     |     | RayMan          | tool and batch | process thousands | of georefer-      |
| --- | --- | --- | --- | --- | --- | --------------- | -------------- | ----------------- | ----------------- |
|     |     |     |     |     |     | enced synthetic | fisheyes       | for a given       | day and time. The |
2.3.SkyViewFactorCalculation
resultsarecollectedinaCSVfileandcansubsequentlybe
SeveralmethodsareavailabletocalculatetheSVFbased importedinArcGISusingthefisheyes’latitude-longitude
|     |     |     |     |     |     | coordinates | to generate | high resolution | MRT and PET |
| --- | --- | --- | --- | --- | --- | ----------- | ----------- | --------------- | ----------- |
onfisheyeimages:TheSVFcanbecalculatedusingana-
lytical methods that derive the horizon limitation from mapsforfurtheranalysis.
| geometric | properties | of the urban | canyon | (Johnson | &   |     |     |     |     |
| --------- | ---------- | ------------ | ------ | -------- | --- | --- | --- | --- | --- |
UrbanPlanning,2017,Volume2,Issue1,Pages19–30 21

screenshots in 5 direc(cid:1)ons hemispheric projec(cid:1)on sky detec(cid:1)on SVF calcula(cid:1)on
(a) (b) (c) (d)
Figure1.SkyViewFactorcalculationpipeline.Startingwithfiveimagesof90°fieldofview(a),weapplyanangularhemi-
sphericfisheyeprojection(b),detectskyregions(c),andcalculatetheSkyViewFactorusing36annularrings(d).
3.SkyViewFactorResults EarthandGoogleStreetViewyieldedanaveragediffer-
enceinSVFof0.022withastandarddeviationof0.084.
WeevaluatedtheaccuracyofourSVFapproachintwo The largest differences in SVF were caused by two rea-
steps.First,wecomparedthesynthetichemisphericalim- sons.First,theGoogleStreetViewpanoramaswereac-
agescreatedfromGoogleEarthtofisheyephotosgener- quiredmorerecentlythantheGoogleEarth3Dmeshfor
ated from Google Street View panoramic images using Phoenix, which was generated several years ago. Thus,
the SVF as accuracy metric. Second, we compared our some buildings exist in Street View, but not in Google
SVF results to outputs from other algorithms using the Earth,andviceversa.Second,GoogleStreetViewoffers
same set of fisheye photos. After validation, we gener- panoramasofbuildinginteriorsthatcannotberendered
ated5mresolutionSVFmapsfortwocontrastingneigh- in Google Earth. Filtering out 2,579 indoor panoramas
borhoodsinPhoenix. andextremecasesoftimediscrepanciesyieldeda0.01
average difference in SVF with a 0.028 standard devia-
3.1.EvaluationofSkyViewFactors tion.Thiserrorisminimalandweconcludethattheren-
deredoutputofGoogleEarthyieldsadequateresults.
To assess the accuracy of the Google Earth fisheye im- We evaluated the accuracy of the SVF calculations
ages compared to real world photos, we generated bycomputingtheSVFsof527randomlyselectedGoogle
18,367fisheyeimagesfromGoogleStreetViewpanora- Earth fisheye images in the Phoenix metropolitan area
masacrossthePhoenixmetropolitanarea(Figure2)us- using our implementation of Chapman et al. (2001),
ingtheGoogleStreetViewAPI.Thefisheyegeneration the RayMan Pro model v2.1 by Matzarakis et al. (2007,
process is similar to Google Earth, but requires a more 2010), the SkyViewFactor-Calculator v1.1 by Holmer et
sophisticatedskydetectionalgorithmduetovaryingsky al.(2001),andtheunweighted,naiveapproachofcount-
andcloudconditions.WeusedamodifiedSobelfilteral- ing pixels. Since the SkyViewFactor-Calculator uses the
gorithmforedgedetectionandaproceduredeveloped well-establishedSteyn-method(Steyn,1980),wechose
by Laungrungthip, McKinnon, Churcher and Unsworth the Holmer et al. SVF implementation as reference. As
(2008). We then generated Google Earth fisheye pho- showninFigure3,ourimplementationofChapmanetal.
tosattheGoogleStreetViewlocations,usingacamera (2001)producesSVFsthatarenotsignificantlydifferent
height of 2.5 m to approximate the height of a Street fromthewell-establishedSteyn-method.Weconfirmthe
Viewcar.AcomparisonofSVFscalculatedfromGoogle findingsofHämmerle,Gál,UngerandMatzarakis(2011),
SVF = 0.82 SVF = 0.82 SVF = 0.44 SVF = 0.38
(1a) (1b) (2a) (2b)
Figure2.ComparisonoffisheyesandSkyViewFactorsgeneratedfromGoogleStreetViewimages(1a,2a)andGoogle
Earth3Dmeshes(1b,2b).
UrbanPlanning,2017,Volume2,Issue1,Pages19–30 22

1.0
Holmer (annulus)
0.9
Holmer (pixel-based)
0.8 Rayman 2.1
pixel count
0.7
our implementa(cid:1)on
0.6
0.5
0.4
0.3
0.2
0.1
0.0
0.0 0.1 0.2 0.3 0.4 0.5
SVF Holmer (annulus)
dohtem
hcae
fo
FVS
0.6 0.7 0.8 0.9 1.0
Figure3.OurSkyViewFactorimplementationcomparedtootheralgorithms.
showingthattheRayManmodelsignificantlyunderesti- 4.CaseStudy:ThermalComfortMapsforPedestrian
matesSVFs,especiallyinthemidrange,whenLambert’s Routing
lawisnotconsideredforthepixelweighting.Lastly,sim-
plycalculatingtheratiobetweenskyandnon-skypixels We demonstrate the utility of our synthetic fisheye ap-
yieldsinaccurateresults,sincethisapproachdoesnotac- proachthroughacasestudythathighlightshowurban
countforangulardistortion. formandvegetationimpactsthermalcomfortandwalk-
ability. As a study area, we chose Arizona State Univer-
3.2.High-ResolutionSkyViewFactorMapsin3D sity’s main campus, located in the City of Tempe, Ari-
zona.Tempeisanidealurbanareaforheatstressstud-
Toillustratethespatialvariabilityofhorizonlimitations ies,becauseitislocatedintheSonoranDesertandhas
in urban areas, we created SVF maps at 5 m resolu- a semi-arid climate with hot and dry summers. Aver-
tionand1.1mheightfromsyntheticGoogleEarthfish- agemaximumairtemperaturepeaksat40.4°Cbetween
eye photos for two contrasting neighborhoods in the JuneandAugust,andmonthlyprecipitationislessthan
Phoenix metropolitan area—a residential area in the 1mminJune(WesternRegionalClimateCenter,2016).
CityofPhoenix(Ahwatukee,Lakewoodcommunity)and MostofArizonaStateUniversity’sTempecampusisdes-
Phoenix Downtown (Figure 4). The residential subdi- ignatedasawalk-onlyzoneduringweekdaysfrom8:00h
vision is a neighborhood with detached single family to16:00h;noonemayride,drive,orparkwheeledvehi-
homes, approximately 2.4 km by 1.8 km, and can be cles.Withover50,000studentsandfacultyoncampus,
classifiedasanOpenLowriseLocalClimateZone(Stew- increasingpedestrianthermalcomfortthroughheatmit-
art&Oke,2012).TheDowntownareais2kmby3km igationmeasuresisespeciallyimportantduringthesum-
andclassifiedOpentoCompactHighrise.TheSVFmaps mermonths.Forthisstudy,weselecteda3×3Google
werecreatedinArcGISandexportedasKMLfordisplay Mapstilearea(ca.750m×750m)thatencompassesthe
inGoogleEarth,clampedtotheground,with3Dterrain north-westcornerofthemaincampusandcorresponds
activated. While the core Downtown area exhibits low to an open low- to midrise Local Climate Zone with a
SVFs (< 0.40) near office buildings, SVFs in the central meanSVFof0.52±0.18(Figure5).
business district are generally high due to wide streets WerantheautomatedversionofRayManfor19,600
(numberoffisheyes:168,266;meanSVF:0.76;standard syntheticfisheyephotosinthestudyareaat1.1mheight
deviation:0.17).TheAhwatukeesuburbischaracterized ona5mgridforAugust7,2016,aweekbeforeclasses
byevenhigherSVFs(numberoffisheyes:97,393;mean started. Weather conditions were hot and clear, with a
SVF:0.86;standarddeviation:0.14),excepttothenorth- dailymaximumtemperatureof43°C,minimumtemper-
west,wherea3-storyapartmentcomplexlowersSVFsto atureof30°C,averagedewpointof14°C,andlightwind
0.50.Theclose-upviewsoftheareasclearlyhighlightthe (< 1.5 ms−1). As meteorological model input, we used
importanceoftreesforSVFcalculations. observationsfromanhourlymicroclimatetransectthat
UrbanPlanning,2017,Volume2,Issue1,Pages19–30 23

| 0 0.25 0.5 | 1 km |     |     |     |     |     |
| ---------- | ---- | --- | --- | --- | --- | --- |
SVF
| 0 0.25 0.5 | 1 km | 0.0 0.1 0.2 | 0.3 0.4 0.5 | 0.6 0.7 0.8 | 0.9 1.0 |     |
| ---------- | ---- | ----------- | ----------- | ----------- | ------- | --- |
Figure4.High-resolutionSkyViewFactormaps(1.1mheight)forPhoenixDowntown,Arizona,USA(top)andaresidential
subdivisioninPhoenix,Arizona,USA(bottom)superimposedonGoogleEarth3Dterrain;bird’seyeviewandtwotilted
close-upviews.
| Arizona State University, Main Campus |     |     |     | Sky View Factor |     |     |
| ------------------------------------- | --- | --- | --- | --------------- | --- | --- |
| 0 125 250 m                           |     | a   |     |                 |     | b   |
SVF
|     |     |     | 0.0 0.1 | 0.2 0.3 0.4 | 0.5 0.6 0.7 0.8 | 0.9 1.0 |
| --- | --- | --- | ------- | ----------- | --------------- | ------- |
Figure5.Aerialphoto(a)andhigh-resolutionSkyViewFactormapat1.1mheight(b)forthenorth-westcornerofArizona
StateUniversity’sTempecampus.
wasconductedoncampusbetween8:00hand19:00hon perature,andassumedawalking35yearsoldmaleina
August7,2016.Airtemperature,relativehumidity,and t-shirtandshorts(Table1).
windspeedwereloggedat1.5mand2sintervalsdur-
ingthetransect,linearlytime-detrendedtothefullhour, 4.1.ThermalComfortModelPerformance
andspatiallyaveragedtoyieldrepresentativemeanval-
uesforthestudyarea.Forthethermalcomfortrouting Thefine-scalemodelingresultsforArizonaStateUniver-
application, we focused on 9:00h in the morning and sity’scampushighlightdirectradiationasanimportant
17:00hinthelateafternoon,shortlyafterpeakairtem- driver of MRT. Shade, i.e. the absence of direct incom-
| UrbanPlanning,2017,Volume2,Issue1,Pages19–30 |     |     |     |     |     | 24  |
| -------------------------------------------- | --- | --- | --- | --- | --- | --- |

Table1.MeteorologicaldataforAugust7,2016,andpersonalcharacteristicsusedasinputforthermalcomfortmodeling.
|        | Air         | Relative | Wind   |     |        |               |          |            |     |
| ------ | ----------- | -------- | ------ | --- | ------ | ------------- | -------- | ---------- | --- |
|        | Temperature | Humidity | Speed  |     |        | Weight Height | Clothing | Metabolic  |     |
|        | [°C]        | [%]      | [ms−1] | Age | Gender | [kg] [m]      | [clo]    | Rate[Wm−2] |     |
| 09:00h | 33.6        | 35.8     | 0.9    |     |        |               |          |            |     |
|        |             |          |        | 35  | Male   | 75 1.75       | 0.5      | 110        |     |
| 17:00h | 41.6        | 23.1     | 0.6    |     |        |               |          |            |     |
ingshortwaveradiation,causesdiscontinuitiesinMRT,il- pus every hour from 8:00h to 19:00h using three Huk-
lustratedbytwoseparatecolor-schemesforshadedand seflux4componentnetradiometersmountedonamo-
unshadedlocationsonthemap(Figure6).Shadedloca- bileinstrumentplatformat1.1mheightaboveground.
tionsrangefrom49.0°Cto50.0°CMRT(49.4°Cto50.1°C Thesamplingsitesweretraversedwithin45minutes,in-
MRT)inthemorning(afternoon),whilesun-exposedar- cludingaoneminutestopateachlocationtoaccountfor
easareupwardsof58.6°CMRT(57.2°CMRT).Themap sensorlag.MRTwascalculatedfromtheobservationsfol-
furthersuggeststhatMRTisslightlyincreasednearverti- lowingISO7726(1998).Thesiteswereselectedtospan
calurbanfeatures.Althoughanincreaseinemittedlong- a wide variety of sun-exposure and surface cover com-
waveradiationisexpectedfromsun-facingwallsthatare binations(Table2).Exposuresettingsincludeopensites,
orhavebeenexposedtodirectradiation,andtherefore shadefromtrees,east-westcanyons,andabuildingover-
becomeasourceofradiantheating,thesamedoesnot hang;surfacecovervariesbetweenconcrete,grass,soil,
| necessarily | apply to permanently | shaded | surfaces | and | andgravel. |     |     |     |     |
| ----------- | -------------------- | ------ | -------- | --- | ---------- | --- | --- | --- | --- |
trees. This is a known limitation of the RayMan model; AcomparisonofmodeledandobservedMRTshows
itassumesthesamethermalpropertiesforallsolidsur- considerabledifferencesformostlocations(Table2).Al-
faces in the fisheye image and the lower hemisphere, though RayManexplains 84.4% of the variance in MRT,
whichcanleadtoanoverestimationoflongwaveradia- themodelconsistentlyoverestimatesshadedandunder-
tionfromsurfaces. estimates sun-exposed sites (RMSE=7.33; MBE=3.69;
To test model performance, we compared the Ray- MAE=6.83;d=0.72).Thisindicatesthatthemodelaccu-
MansimulatedMRTresultstosix-directionalradiantflux ratelycapturesthedifferencesinMRTbetweenshaded
densityobservationsfromanon-campusfieldmeasure- and sun-exposed locations due to incoming shortwave
mentcampaignonAugust7,2016(Figure6).3Dradiant radiation,buthasdifficultiestoresolvetheheterogene-
fluxdensitiesweresampledat20locationsacrosscam- ity of urban form. Our results are in agreement with
|       | August 7, 2016, 09:00 h |     |     |     |     | August 7, 2016, 17:00 h |     |     |     |
| ----- | ----------------------- | --- | --- | --- | --- | ----------------------- | --- | --- | --- |
| 0 125 | 250 m                   |     |     | a   |     |                         |     |     | b   |
MRT
| shaded      |     |     |     | [˚C] |     |     |     |             | shaded |
| ----------- | --- | --- | --- | ---- | --- | --- | --- | ----------- | ------ |
| sun-exposed |     |     |     |      |     |     |     | sun-exposed |        |
Figure6.Simulatedmeanradianttemperature(MRT)mapofthestudysitefor09:00h(a)and17:00h(b)onAugust7,2016,
withon-sitemeanradianttemperatureobservations.
| UrbanPlanning,2017,Volume2,Issue1,Pages19–30 |     |     |     |     |     |     |     |     | 25  |
| -------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Thorsson et al. (2007) who found that RayMan under- A.FultonSchoolsofEngineeringBrickyardnorth-westof
estimates sun-exposed sites under clear conditions in theTempecampusandendingattheMemorialUnionin
Göteborg,Sweden,andwithLeeandMayer(2016)who thecampuscenter.TheBrickyardbuildingcomplexislo-
found that RayMan overestimates low and underesti- catedonMillAvenue,apedestrian-friendlystreetinthe
mateshighMRTobservationsinFreiburg,Germany.Yet, heartofTempewithmanyrestaurants,cafes,bars,and
RayMan performed better in our setting than during shops. The Memorial Union offers student support ser-
a field experiment in Glasgow by Krüger, Minella and vicesandisamajoractivityhubatthecampuscore.We
Matzarakis (2014) who reported RMSE values upwards calculatedtheshortestpath(α=0),amorecomfortable
of10°Cinacomparisonofvariousmethodstoestimate path(α = 2),andthemostcomfortablepath(α → ∞)
MRT. Despite the divergence between observed and fromtheBrickyardtotheMemorialUnionforAugust7,
modeled MRT values, we conclude that RayMan yields 2016,9:00hand17:00h(Figure7).Withincreasingwill-
reasonable estimates to demonstrate the utility of our ingness to walk further, optimal comfort routes divert
thermalcomfortroutingapplication.ImprovingMRTsim- fromtheshortestpathtonavigatepedestriansthrough
ulations is beyond the scope of this paper, but imple- shadefrombuildingsandtreesinsteadofexposingthem
mentingarefinedradiationschemeforoursyntheticfish- tothesun.Routesalsovarybytimeofday,asthesunpo-
eyeapproachispartofongoingwork. sitionchangesshadepatternsfrombuildingsandtrees.
|     |     |     |     | At 9:00h, | shade | is generated |     | to the | west of | urban fea- |
| --- | --- | --- | --- | --------- | ----- | ------------ | --- | ------ | ------- | ---------- |
4.2.PedestrianRouting tures and the most comfortable route leads through a
|     |     |     |     | tree-lined | north-south |     | canyon | between | midrise | build- |
| --- | --- | --- | --- | ---------- | ----------- | --- | ------ | ------- | ------- | ------ |
Based on the RayMan model output for PET, we sug- ings.Atawalkingspeedof1.4ms−1,therouteis65m
gest walking routes across campus that are tailored to and48slongerthantheshortestroute(995m,11min
thermal comfort preferences. We employed the Dijk- and48s),lowerssunexposureby7.5%,andincreasesav-
stra (1959) algorithm to calculate the shortest path be- eragethermalcomfortfrom43.4to42.9°CPET(Table3).
tweentwolocationsinthestudyareaandincorporated At17:00h,whenshadeisgeneratedtotheeastatalow
aweightingthataccountsforPETpreferencesofanindi- sun angle, the most comfortable path leads along the
vidual.The“comfortoverdistance”parameterαcontrols eastsideofagroupofhigh-risebuildingsthroughanal-
the importance of thermal comfort for navigation, i.e. mostcompletelyshadednorth-southcanyon.Theroute
α=0yieldstheshortestpathandα→∞yieldsthemost is97mlongerthantheshortestpath(997m,11minand
comfortablepath,minimizingaveragePETofaroute.For 54s),adding1minand6stothetripbutreducingsun
our case study, we selected a route starting at the Ira exposureby10%.
Table2.Sitedescriptionandcomparisonofsimulatedvs.observedmeanradianttemperaturefor20locationsinthestudy
areaforAugust7,2016at9:00hand17:00h.
|      |     |         |     | 09:00h |     |      |     | 17:00h |      |       |
| ---- | --- | ------- | --- | ------ | --- | ---- | --- | ------ | ---- | ----- |
| Stop |     | Surface | MRT | MRT    | MRT | −    | MRT | MRT    |      | MRT − |
|      |     |         | obs | calc   |     | calc | obs |        | calc | calc  |
ID Exposure Location Cover [°C] [°C] MRT [°C] [°C] [°C] MRT [°C]
|         |              |          |      |      |       | obs |      |      |     | obs   |
| ------- | ------------ | -------- | ---- | ---- | ----- | --- | ---- | ---- | --- | ----- |
| 1 shade | undertree    | concrete | 44.3 | 49.6 | −15.3 |     | 43.8 | 49.9 |     | −16.1 |
| 2 sun   | E-Wwalkway   | concrete | 68.2 | 59.6 | 1−8.6 |     | 68.2 | 57.5 |     | −10.7 |
| 3 shade | undertree    | soil     | 46.4 | 49.8 | −13.4 |     | 38.7 | 49.4 |     | −10.7 |
| 4 shade | undertree    | grass    | 38.6 | 49.8 | −11.3 |     | 41.2 | 49.6 |     | −18.4 |
| 5 shade | undertree    | grass    | 45.1 | 50.0 | −14.9 |     | 42.1 | 49.9 |     | −17.8 |
| 6 shade | undertree    | gravel   | 40.5 | 49.4 | −18.9 |     | 46.3 | 49.7 |     | −13.4 |
| 7 sun   | intersection | concrete | 67.4 | 58.9 | 1−8.5 |     | 66.6 | 57.4 |     | 1−9.2 |
| 8 shade | undertree    | concrete | 40.9 | 49.6 | −18.7 |     | 45.5 | 50.0 |     | −14.5 |
9 shade underpalmtrees concrete 44.2 50.0 −15.8 48.3 50.0 −11.7
| 10 shade | undertree | soil | 39.3 | 49.8 | −10.5 |     | 43.9 | 49.9 |     | −16.0 |
| -------- | --------- | ---- | ---- | ---- | ----- | --- | ---- | ---- | --- | ----- |
11 shade underoverhang concrete 33.6 49.4 −15.8 36.0 49.9 −13.9
| 12 shade                                     | undertree | concrete | 57.0 | 49.2 | 1−7.8 |     | 46.1 | 49.7 |     | −13.6 |
| -------------------------------------------- | --------- | -------- | ---- | ---- | ----- | --- | ---- | ---- | --- | ----- |
| 13 shade                                     | undertree | concrete | 43.0 | 49.4 | −16.4 |     | 44.6 | 49.8 |     | −15.2 |
| 14 shade                                     | undertree | grass    | 40.0 | 49.3 | −19.3 |     | 43.2 | 49.8 |     | −16.6 |
| 15 shade                                     | undertree | concrete | 41.5 | 49.4 | −17.9 |     | 41.7 | 49.9 |     | −18.2 |
| 16 shade                                     | undertree | concrete | 41.6 | 49.5 | −17.9 |     | 43.9 | 49.8 |     | −15.9 |
| 17 shade                                     | undertree | concrete | 43.0 | 49.5 | −16.6 |     | 47.3 | 49.8 |     | −12.5 |
| 18 shade                                     | undertree | concrete | 48.3 | 49.3 | −11.0 |     | 47.2 | 49.8 |     | −12.6 |
| 19 sun                                       | E-Wcanyon | concrete | 64.9 | 59.5 | 1−5.4 |     | 67.2 | 57.7 |     | 1−9.5 |
| 20 shade                                     | undertree | concrete | 41.6 | 49.9 | −18.3 |     | 39.3 | 49.9 |     | −10.6 |
| UrbanPlanning,2017,Volume2,Issue1,Pages19–30 |           |          |      |      |       |     |      |      |     | 26    |

August 7, 2016, 09:00 h August 7, 2016, 17:00 h
| 0 125 250 m |     |     | a   |     |     |     |     | b   |
| ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
PET
| shaded | sun-exposed |     | [˚C] |     | shaded |     | sun-exposed |     |
| ------ | ----------- | --- | ---- | --- | ------ | --- | ----------- | --- |
Figure7.Thermalcomfortmap(PhysiologicallyEquivalentTemperature,PET,in°C)forArizonaStateUniversity’sTempe
campusforAugust7,2016,09:00h(a)and17:00h(b);Shortestpath(dottedline)fromtheIraA.FultonSchoolsofEngineer-
ing(Brickyard)totheMemorialUnion,slightlylonger,butmorecomfortableroute(dashedline),andmostcomfortable
path(solidline).
Table3.Routestatisticsonlength,walkingduration(at1.4ms−1),averagethermalcomfort(PET),andsunexposurefor
threethermalcomfortpreferences(α=0,2,α→∞)attwodifferenttimesofday(9:00hand17:00h)onAugust7,2016.
|                  |      | 09:00h |     |      |      | 17:00h |     |      |
| ---------------- | ---- | ------ | --- | ---- | ---- | ------ | --- | ---- |
|                  | α=0  | α=2    |     | α→∞  | α=0  | α=2    |     | α→∞  |
| Length[m]        | 995  | 1020   |     | 1057 | 997  | 1016   |     | 1094 |
| Duration[min]    | 11.8 | 12.1   |     | 12.6 | 11.9 | 12.1   |     | 13.0 |
| AveragePET[°C]   | 43.4 | 43.2   |     | 42.9 | 48.7 | 48.5   |     | 48.3 |
| SunExposure[%]   | 50.5 | 45.0   |     | 43.0 | 37.1 | 33.3   |     | 27.4 |
| SunExposure[min] | 6.0  | 5.5    |     | 5.4  | 4.4  | 4.0    |     | 3.6  |
Considering the hot dry thermal conditions on Au- agescanbeusedtoderiveurbanformandclimatemet-
gust7,detoursfromtheshortestpathareshortandrea- rics such as SVF, duration of sun exposure, MRT, and
sonable, and at the same time significantly reduce sun the thermal comfort index PET. Our approach is novel
exposure,especiallyinthelateafternoonwhensunan- in that it combines several advantages of existing ap-
gles are low. Thermal comfort differences in the short- proaches. First, urban form and climate metrics can be
estandmostcomfortablepathareexpectedtobemore calculated automatically for large urban areas indepen-
pronouncedforlongerdistancesandinmoreheteroge- dentofavailable3Dbuildingdatabases,DSMs,orDEMs.
neous urban forms. Results will also differ in other cli- Second, trees are included in the 3D urban geometry;
matic conditions where humidity or wind speed might trees are important shade providers at the pedestrian
playamoresignificantroleindeterminingthermalcom- levelthatmustbeconsideredinfine-scaleoutdoorther-
fort and during the winter when deciduous trees have mal comfort applications. Our synthetic fisheye images
losttheirleaves. compared well to real world hemispherical photos re-
trievedfromGoogleStreetView,butarecurrentlymore
5.DiscussionandConclusions difficult to generate, because the most recent Google
EarthAPIdoesnotsupportdirectaccess.
Wedevelopedamethodologytogeneratesyntheticfish- The presented SVF approach integrates well with
eye images based on Google Earth 3D data for urban existing thermal comfort models that use fisheye pho-
areas at fine spatial resolution. The hemispherical im- tographstomodelradiationfluxes.However,refinement
| UrbanPlanning,2017,Volume2,Issue1,Pages19–30 |     |     |     |     |     |     |     | 27  |
| -------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |

ofthephysicalpropertiesandsun-exposureofthesolid References
surfacesinthosefisheye-basedmodelsisneededtore-
solvetheheterogeneityinurbanareasandestimatether- Bradley, A. V., Thornes, J. E., & Chapman, L. (2001). A
malcomfortmoreaccurately. methodtoassess thevariationof urbancanyonge-
Inaheatmappingcasestudy,wedemonstratedthe ometryfromskyviewfactortransects.Atmospheric
utility of our synthesized fisheye images for pedestrian ScienceLetters,2(1-4),155–165.
thermal comfort routing on Arizona State University’s Brandsma, Theo, & Wolters, Dirk. (2012). Measure-
Tempe campus. We introduced the “comfort over dis- ment and statistical modeling of the urban heat is-
tance” parameter α that minimizes average PET expo- land of the city of Utrecht (The Netherlands). Jour-
sure for a route based on a pedestrian’s willingness to nal of Applied Meteorology and Climatology, 51(6),
walk further. Integrating personalized thermal comfort 1046–1060.
preferencesasaweightingfactor,weestimatedapedes- Chapman,L.,&Thornes,J.E.(2004).Real-timesky-view
trian’s exposure time to direct sun given a route, walk- factor calculation and approximation. Journal of At-
ingspeed,andoverallthermalcomfort.Thecurrentrout- mosphericandOceanicTechnology,21(5),730–741.
ing algorithm minimizes average PET with increasing α, Chapman,L.,Thornes,J.E.,&Bradley,A.V.(2001).Rapid
buttheduration,frequency,andmagnitudeofpersonal determination of canyon geometry parameters for
exposuretoheataffectsthermalcomfortaswell(Kuras useinsurfaceradiationbudgets.TheoreticalandAp-
et al., in press). The time spent walking above a cer- pliedClimatology,69(1-2),81–89.
tain PET threshold presents an alternative metric simi- Chen,L.,Ng,E.,An,X.,Ren,C.,Lee,M.,Wang,U.,&He,Z.
lar to the Extreme Degree-Minute approach employed (2012).Skyviewfactoranalysisofstreetcanyonsand
by Karner, Hondula and Vanos (2015) that could be im- itsimplicationsfordaytimeintra-urbanairtempera-
plemented as weighting factor. Our algorithm can fur- turedifferentialsinhigh-rise,high-densityurbanar-
ther be extended to provide more individualized ther- easofHongKong:AGIS-basedsimulationapproach.
malcomfortroutesincorporatingmultipleweightingfac- InternationalJournalofClimatology,32(1),121–136.
tors,e.g.,traffic-relatedairpollutionandaccessibilityto Chen,L.,Yu,B.,Yang,F.,&Mayer,H.(2016).Intra-urban
coolingfacilitiessuchaswaterfountains,shops,andcool- differencesofmeanradianttemperatureindifferent
ingcenters. urbansettingsinShanghaiandimplicationsforheat
Our individualized thermal comfort maps demon- stressunderheatwaves:AGIS-basedapproach.En-
stratehowurbanform,representedherebytheSVF,im- ergyandBuildings,130,829–842.
pacts walkability and pedestrian outdoor thermal com- Coutts, A. M., White, E. C., Tapper, N. J., Beringer, J., &
fort. As navigational aid, these maps have the poten- Livesley, S. J. (2016). Temperature and human ther-
tialtosignificantlyreducethermalstressonpedestrians. malcomforteffectsofstreettreesacrossthreecon-
They can help the public to better prepare for outdoor trastingstreetcanyonenvironments.Theoreticaland
activities by visualizing how thermal conditions “feel” AppliedClimatology,124(1-2),55–68.
andhowtheyvarywithintheurbanarea.Thermalcom- Dijkstra, E. W. (1959). A note on two problems in con-
fortmapscanalsoprovideusefulinformationforurban nexion with graphs. Numerische Mathematik, 1(1),
planners.Theycanbeemployedtoassessneighborhood 269–271.
walkability, determine hotspots, and support heat haz- Erell,E.,Pearlmutter,D.,&Williamson,T.(2012).Urban
ardmitigationefforts,e.g.,informtargetedtreeplanting microclimate: Designing the spaces between build-
incitiestomaximizethermalcomfortoutcomes. ings.London:Earthscan.
Thermal comfort outcomes are significantly influ- Gál,T.,Lindberg,F.,&Unger,J.(2009).Computingcon-
encedbyhowwedesigncities,i.e.thelayoutandtypes tinuous sky view factors using 3D urban raster and
of buildings, streets, and vegetation. Thermal comfort vectordatabases:Comparisonandapplicationtour-
maps from synthetic fisheye photos provide important ban climate. Theoretical and Applied Climatology,
insights that, integrated into urban planning processes, 95(1-2),111–123.
can inform future city design to create more climate- Gál, T., & Unger,J.(2014). A new software tool for SVF
sensitiveoutdoorspaces. calculationsusingbuildingandtree-crowndatabases.
UrbanClimate,10,594–606.
Acknowledgments Grimmond,C.S.B.,Potter,S.K.,Zutter,H.N.,&Souch,C.
(2001). Rapid methods to estimate sky-view factors
This research was sponsored by University of Kaiser- applied to urban areas. International Journal of Cli-
slautern, grant ”Microclimate Data Collection, Analysis, matology,21(7),903–913.
andVisualization”. Hämmerle,M.,Gál,T.,Unger,J.,&Matzarakis,A.(2011).
Comparison of models calculating the sky view fac-
ConflictofInterests torusedforurbanclimateinvestigations.Theoretical
andAppliedClimatology,105(3-4),521–527.
Theauthorsdeclarenoconflictofinterests. Herrmann,J.,&Matzarakis,A.(2012).Meanradianttem-
peratureinidealisedurbancanyons—Examplesfrom
UrbanPlanning,2017,Volume2,Issue1,Pages19–30 28

Freiburg,Germany.InternationalJournalofBiomete- wareinurbanenvironments.InternationalJournalof
orology,56(1),199–203. Biometeorology,60(11),1775–1785.
Holmer,B.,Postgård,U,&Eriksson,M.(2001).Skyview Lenzholzer,S,&Brown,R.D.(2016).Post-positivistmicro-
factorsinforestcanopiescalculatedwithIDRISI.The- climaticurbandesignresearch:Areview.Landscape
oreticalandAppliedClimatology,68(1-2),33–40. andUrbanPlanning,153,111–121.
Höppe,P.(1999).Thephysiologicalequivalenttemperat- Lin,T.P.(2009).Thermalperception,adaptationandat-
ure—Auniversalindexforthebiometeorologicalas- tendanceinapublicsquareinhotandhumidregions.
sessmentofthethermalenvironment.International BuildingandEnvironment,44(10),2017–2026.
JournalofBiometeorology,43(2),71–75. Lin,T.P.,Matzarakis,A.,&Hwang,R.L.(2010).Shading
ISO 7726. (1998). Ergonomics of the thermal environ- effectonlong-termoutdoorthermalcomfort.Build-
ment—Instruments for measuring physical quanti- ingandEnvironment,45(1),213–221.
ties.(InternationalStandard,2nded.).Geneva:Inter- Lindberg,F.,&Grimmond,C.S.B.(2011).Theinfluence
nationalOrganizationforStandardization(ISO). of vegetation and building morphology on shadow
Johansson,E.,&Emmanuel,R.(2006).Theinfluenceof patternsandmeanradianttemperaturesinurbanar-
urbandesignonoutdoorthermalcomfortinthehot, eas:Modeldevelopmentandevaluation.Theoretical
humidcityofColombo,SriLanka.InternationalJour- andAppliedClimatology,105(3-4),311–323.
nalofBiometeorology,51(2),119–133. Lindberg,F.,Holmer,B.,&Thorsson,S.(2008).SOLWEIG
Johansson, E., Thorsson, S., Emmanuel, R., & Krüger, E. 1.0—Modellingspatialvariationsof3Dradiantfluxes
(2014).Instrumentsandmethodsinoutdoorthermal andmeanradianttemperatureincomplexurbanset-
comfort studies—The need for standardization. Ur- tings.InternationalJournalofBiometeorology,52(7),
banClimate,10,346–366. 697–713.
Johnson,G.T,&Watson,I.D.(1984).Thedetermination Matzarakis, A., & Matuschek, O. (2011). Sky View Fac-
ofview-factorsinurbancanyons.JournalofClimate torasaparameterinappliedclimatology—Rapides-
andAppliedMeteorology,23(2),329–335. timation by the SkyHelios Model. Meteorologische
Jones, B., O’Neill, B. C., McDaniel, L., McGinnis, S., Zeitschrift,20(1),39–45.
Mearns, L. O., & Tebaldi, C. (2015). Future popula- Matzarakis,A.,Rutz,F.,&Mayer,H.(2007).Modellingra-
tion exposure to US heat extremes. Nature Climate diationfluxesinsimpleandcomplexenvironments—
Change,5(7),652–655. ApplicationoftheRayManmodel.InternationalJour-
Karner,A.,Hondula,D.M.,&Vanos,J.K.(2015).Heatex- nalofBiometeorology,51(4),323–334.
posureduringnon-motorizedtravel:Implicationsfor Matzarakis,A.,Rutz,F.,&Mayer,H.(2010).Modellingra-
transportationpolicyunderclimatechange.Journal diation fluxes in simple and complex environments:
ofTransport&Health,2(4),451–459. BasicsoftheRayManmodel.InternationalJournalof
Krüger,E.L.,Minella,F.O.,&Rasia,F.(2011).Impactof Biometeorology,54(2),131–139.
urbangeometryonoutdoorthermalcomfortandair Mayer,H.,&Höppe,P.(1987).Thermalcomfortofman
quality from field measurements in Curitiba, Brazil. indifferenturbanenvironments.TheoreticalandAp-
BuildingandEnvironment,46(3),621–634. pliedClimatology,38(1),43–49.
Krüger, E. L., Minella, F. O., & Matzarakis, A. (2014). Middel, A., Häb, K., Brazel, A. J., Martin, C., &
Comparison of different methods of estimating the Guhathakurta, S. (2014). Impact of urban form
meanradianttemperatureinoutdoorthermalcom- and design on microclimate in Phoenix, AZ. Land-
fortstudies.InternationalJournalofBiometeorology, scapeandUrbanPlanning,122,16–28.
58(8),1727–1737. Middel, A., Selover, N., Hagen, B., & Chhetri, N. (2016).
Kuras, E. R., Bernhard, M. C., Calkins, M. M., Ebi, K. Impactofshadeonoutdoorthermalcomfort—Asea-
L., Hess, J. J., Kintziger, K. W., . . . Hondula, D. M. sonal field study in Tempe, Arizona. International
(inpress).Opportunitiesandchallengesforpersonal JournalofBiometeorology,60(12),1849–1861.
heat exposure research. Environmental Health Per- Ng, E., & Cheng, V. (2012). Urban human thermal com-
spectives. fortinhotandhumidHongKong.EnergyandBuild-
Laungrungthip, N., McKinnon, A. E., Churcher, C. D., & ings,55,51–65.
Unsworth,K.(2008).Edge-baseddetectionofskyre- Nikolopoulou, M., & Lykoudis, S. (2006). Thermal com-
gionsinimagesforsolarexposureprediction.Paper fort in outdoor urban spaces: Analysis across differ-
presentedatthe200823rdInternationalConference ent European countries. Building and Environment,
ImageandVisionComputingNewZealand. 41(11),1455–1470.
Lee, H., Holst, J., & Mayer, H. (2013). Modification of National Oceanic and Atmospheric Administration.
human-biometeorologically significant radiant flux (2015, September 29). Natural hazard statistics.
densitiesbyshadingaslocalmethodtomitigateheat Retrieved from http://www.nws.noaa.gov/om/haz
stress in summer within urban street canyons. Ad- stats.shtml
vancesinMeteorology,2013,13. Oke,T.R.(1981).Canyongeometryandthenocturnalur-
Lee, H., & Mayer, H. (2016). Validation of the mean ra- banheatisland:Comparisonofscalemodelandfield
diant temperature simulated by the RayMan soft- observations.JournalofClimatology,1(3),237–254.
UrbanPlanning,2017,Volume2,Issue1,Pages19–30 29

Oliveira,S.,Andrade,H.,&Vaz,T.(2011).Thecoolingef- Unger,J.(2009).Connectionbetweenurbanheatisland
fectofgreenspacesasacontributiontothemitiga- andskyviewfactorapproximatedbyasoftwaretool
tion of urban heat: A case study in Lisbon. Building ona3Durbandatabase.InternationalJournalofEn-
andEnvironment,46(11),2186–2194. vironmentandPollution,36(1-3),59–80.
Pearlmutter,D.,Bitan,A.,&Berliner,P.(1999).Microcli- Vanos, J., Warland, J. S., Gillespie, T. J., & Kenny, N. A.
maticanalysisof“compact”urbancanyonsinanarid (2010).Reviewofthephysiologyofhumanthermal
zone.AtmosphericEnvironment,33(24),4143–4150. comfortwhileexercisinginurbanlandscapesandim-
Ratti, C., Baker, N., & Steemers, K. (2005). Energy con- plications for bioclimatic design. International Jour-
sumption and urban texture. Energy and Buildings, nalofBiometeorology,54(4),319–334.
37(7),762–776. VereinDeutscherIngenieure.(1994).VDI3789part2:En-
Stewart,I.D.,&Oke,T.R.(2012).Localclimatezonesfor vironmental meteorology, interactions between at-
urbantemperaturestudies.BulletinoftheAmerican mosphereandsurfaces;calculationoftheshort-and
MeteorologicalSociety,93(12),1879–1900. longwaveradiationVDIguideline(Vol.3789,pp.52).
Steyn, D. G. (1980). The calculation of view fac- Berlin:Beuth.
tors from fisheye-lens photographs: Research note. Western Regional Climate Center. (2016). NCDC 1981–
Atmosphere-Ocean,18(3),254–258. 2010 normals for Tempe ASU, Arizona (028499).
Thorsson,S.,Lindqvist,M., &Lindqvist,S.(2004).Ther- Retrieved from http://www.wrcc.dri.edu/cgi-bin/cli
malbioclimaticconditionsandpatternsofbehaviour MAIN.pl?az8499
inanurbanparkinGöteborg,Sweden.International White, M., Hu, Y., Langenheim, N., Ding, W., & Burry,
JournalofBiometeorology,48(3),149–156. M.(2016).Coolcitydesign:Integratingreal-timeur-
Thorsson, S., Lindberg, F., Eliasson, I., & Holmer, B. ban canyon assessment into the design process for
(2007).Differentmethodsforestimatingthemeanra- Chinese and Australian cities. Urban Planning, 1(3),
dianttemperatureinanoutdoorurbansetting.Inter- 25–37.
nationalJournalofClimatology,27(14),1983–1993. Zakšek,K.,Oštir,K.,&Kokalj,Ž.(2011).Sky-viewfactoras
Unger, J. (2004). Intra-urban relationship between sur- areliefvisualizationtechnique.RemoteSensing,3(2),
face geometry and urban heat island: Review and 398–415.
newapproach.ClimateResearch,27,253–264.
AbouttheAuthor
ArianeMiddel(PhD,UniversityofKaiserslautern)isanAssistantResearchProfessorintheSchoolof
GeographicalSciencesandUrbanPlanningatArizonaStateUniversity.Herresearchinterestsaredi-
rectedtowardunderstandingthedynamicsofurbanclimatetodevelopclimateadaptationandheat
mitigationstrategies,specificallyaddressingthechallengesofsustainableurbanformanddesignun-
derclimaticuncertaintyinrapidlyurbanizingregions.ShewasrecentlyelectedasaBoardmemberof
theInternationalAssociationforUrbanClimate(IAUC).
Jonas Lukasczyk (M.Sc., Technische Universität Kaiserslautern) is a PhD student in the Visual Infor-
mationAnalysisgroupatTUKaiserslautern.Hisworkfocusesontopologicalvisualanalysisofspatio-
temporaldata.Formoreinformationonhiscurrentworkvisitwww.jluk.de.
RossMaciejewski(PhD,PurdueUniversity)isanAssistantProfessorintheSchoolofComputing,In-
formatics and Decision Systems Engineering at Arizona State University (ASU). His recent work has
explored the extraction and linking of disparate data sources analyzing combinations of structured
geographicdatatounstructuredsocialmediadatafocusingonpublichealth,dietaryanalysis,social
media,andcriminalincidentreports.HeisaFellowoftheGlobalSecurityInitiativeatASUandthe
recipientofanNSFCAREERAward.Formoreinformationvisitvader.lab.asu.edu.
UrbanPlanning,2017,Volume2,Issue1,Pages19–30 30
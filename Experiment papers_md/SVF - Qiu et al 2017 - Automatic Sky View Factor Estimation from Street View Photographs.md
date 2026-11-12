remote sensing
Article
Automatic Sky View Factor Estimation from Street
View Photographs—A Big Data Approach
JianmingLiang1,2,3,*,JianhuaGong1,3,*,JunSun1,3,JiepingZhou1,3,WenhangLi1,3,YiLi1,3,
JinLiu1,4,5andShenShen1,4
1 StateKeyLaboratoryofRemoteSensingScience,InstituteofRemoteSensingandDigitalEarth,
ChineseAcademyofSciences,Beijing100101,China;sjunme@126.com(J.S.);zhoujp@radi.ac.cn(J.Z.);
mylihang@163.com(W.L.);li_yi81@126.com(Y.L.);13512007804@163.com(J.L.);dslwz2002@163.com(S.S.)
2 SchoolofLifeSciences,ArizonaStateUniversity,P.O.Box874501,Tempe,AZ85287,USA
3 Zhejiang-CASApplicationCenterforGeoinformatics,Jiashan314100,China
4 UniversityofChineseAcademyofSciences,Beijing100049,China
5 NationalMarineDataandInformationService,Tianjin300171,China
* Correspondence:ljm355@163.com(J.L.);gongjh@radi.ac.cn(J.G.);Tel.:+86-10-6484-9299(J.L.&J.G.)
AcademicEditors:BailangYu,LeiWang,QiushengWu,JosefKellndorferandPrasadS.Thenkabail
Received:8April2017;Accepted:22April2017;Published:30April2017
Abstract: Hemispherical(fisheye)photographyisawell-establishedapproachforestimatingthesky
viewfactor(SVF).High-resolutionurbanmodelsfromLiDARandobliqueairbornephotogrammetry
canprovidecontinuousSVFestimatesoveralargeurbanarea,butsuchdataarenotalwaysavailable
andaredifficulttoacquire. Streetviewpanoramashavebecomewidelyavailableinurbanareas
worldwide: GoogleStreetView(GSV)maintainsaglobalnetworkofpanoramasexcludingChina
and several other countries; Baidu Street View (BSV) and Tencent Street View (TSV) focus their
panorama acquisition efforts within China, and have covered hundreds of cities therein. In this
paper,weapproachthisissuefromabigdataperspectivebypresentingandvalidatingamethodfor
automaticestimationofSVFfrommassiveamountsofstreetviewphotographs. Comparisonswere
madewithSVFestimatesderivedfromtwoindependentsources: aLiDAR-basedDigitalSurface
Model(DSM)andanobliqueairbornephotogrammetry-based3Dcitymodel(OAP3D),resultingin
acorrelationcoefficientof0.863and0.987,respectively. Thecomparisonsdemonstratedthecapacity
oftheproposedmethodtoprovidereliableSVFestimates. Additionally,wepresentanapplication
oftheproposedmethodwithabout12,000GSVpanoramastocharacterizethespatialdistribution
ofSVFoverManhattanIslandinNewYorkCity. Althoughthisisaproof-of-conceptstudy,ithas
shownthepotentialoftheproposedapproachtoassisturbanclimateandurbanplanningresearch.
However,furtherdevelopmentisneededbeforethisapproachcanbefinallydeliveredtotheurban
climateandurbanplanningcommunitiesforpracticalapplications.
Keywords: sky view factor; Google Street View; panorama; automatic extraction; urban climate;
urbanplanning
1. Introduction
Skyviewfactor(SVF)representsthefractionoftheskythatisvisiblefromapointonasurface[1],
suchastheground. Itisanimportantparameterinurbanclimateresearch[2–5]andurbanplanning
practices[6–8]. AsignificantrelationshipwasfoundbetweenSVFandurbanheatislandsatalocal
scale [9]. Sky obstruction can substantially reduce the amount of solar radiation reaching the
ground [10], and hence SVF serves an important role in solar radiation modeling [11,12]. It was
foundthatSVFwassignificantlycorrelatedwithsurfaceemissivityinurbancanyons[13]. Hence,
theestimationaccuracyofsurfaceemissivity[14]andsurfacetemperature[15]couldbeimprovedby
RemoteSens.2017,9,411;doi:10.3390/rs9050411 www.mdpi.com/journal/remotesensing

RemoteSens.2017,9,411 2of17
accountingfortheSVFeffectsinaradiativetransfermodel. Additionally,ithasalsobeenshownthat
SVFcouldbeusedasareliefvisualizationtechniquetohighlightterrainfeatures[16].
TheSVFinurbanenvironmentscanbeestimatedusingavarietyofmethods. TheArcViewSVF
Extension[17]wasdevelopedtocalculateSVFfrom2.5Dbuildingmodels,whichcanbeextruded
frombuildingfootprintswithadditionalheightinformation. TheSkyHeliostool[18]generatesvirtual
fisheyeimagesfromdatasourcessuchasraster-basedDigitalSurfaceModels(DSMs)andvector-based
3DbuildingmodelsforSVFdetermination. Recently,anattempthasbeenmadetoestimateurbanSVF
fromLandsatdatausingshadowdetectiontechniques[19]. Theuseofhemisphericalphotographyfor
SVFestimationhasbeenstudiedandappliedextensively[20–23]. SpatiallycontinuousSVFestimates
can be obtained by generating virtual fisheye images from high-resolution DSMs [2,24] or 3D city
models[18]. Unfortunately,datasourcessuchas2.5Dbuildingmodels,high-resolutionDSMs,and3D
citymodelsremainpoorlyavailableduetothehighacquisitioncosts.
In the big data era, hundreds of terabytes of data are being generated from various types of
sensorsanddevicesallovertheworld[25]. Traditionaldataprocessingandinformationextraction
methods are falling increasingly short of the expectations for big data mining. Machine learning
combinedwithhigh-performancecomputinghavebecomeaneffectiveapproachtoextractinformation
andknowledgehiddenbehindbigdata[26].
Atypicalformofbigdataisstreetviewphotographswhichhavecoveredafairlylargepartof
theworld'surbanareas. TheGoogleStreetView(GSV)effort[27]waslaunchedin1997,andsince
thenGooglehashirednumerouslocaldriverstocollectpanoramicphotographsalongnearlyevery
navigableroad. AllthesepanoramicphotographsarefreelyaccessibleonGoogleMapsandviathe
Google Street View Application Program Interface (API) (Figure 1). Due to business restrictions,
however,GSV[28]hasnotbeenabletocovermainlandChina. Inthemeantime,twoleadingChinese
ITcompanies,BaiduandTencent,havelaunchedtheirrespectivestreetphotographycampaignsin
China. BaiduStreetView(BSV)[29]andTencentStreetView(TSV)[30]havecoveredafairlylargepart
oftheurbanlandinChina. Carrasco-Hernandezetal.[31]hasshowedthatGSVphotographscould
providereliableSVFestimatesinurbanenvironments. Carrasco-Hernandezetal.[31]retrievedimages
fromGSVandstitchedthemtogetherintopanoramasusingasoftwareformanualskydelineation
andSVFdetermination. Whenfacedwithtensofthousandsofpanoramicimages,however,thetime
andlaborcostsassociatedwithmanualdataprocessingcanbediscouraginglyhigh. Therehasbeen
anumberofstudiesattemptingtoextractinformationfromGSVphotographsusingvariousmachine
learningandimagerecognitiontechniques. YinandWang[32]measuredvisualenclosuresforstreet
walkability using a machine learning algorithm and GSV photographs. Yin et al. [33] presented
amethodtoestimatepedestrianvolumefromGSVphotographs. GSVphotographshavealsobeen
usedtomeasurestreet-levelgreenery[34]andauditneighborhoodenvironments[35]. Mostofthese
studiesusedamachinelearningapproachtoextractdeep-levelinformationfromstreetphotographs.
Inthispaper,weaimtopresentandvalidateaframeworkforautomaticallyestimatingSVFfrom
streetviewpanoramas,andourworkmainlyfocusesontwoparts:(1)Howcanamulti-perspectiveset
ofstreetviewimagesretrievedfromapanoramaproviderbestitchedbackintoafullpanorama? Itis
documented[28]thatontheserverside,eachpanoramaispresentinanequirectangular(PlateCarrée)
projection. Theequirectangularspacecontains360degreesofhorizontalview(afullwrap-around)and
180degreesofverticalview[28]. Ontheclientside,however,onecanonlyretrieveimagesofalimited
fieldofview(fov)viathepublicAPIs. Therefore,toestimatetheSVFatastreetlocation,apanorama
mustfirstbereconstructedfromasetofstreetimagesretrievedviathepublicAPIs;(2)CanSVFbe
accuratelyandefficientlyestimatedfromstreetviewphotographswithastate-of-the-artdeeplearning
framework? Skydelineationisthemostlaborintensivepartinhemisphericalphotography-basedSVF
estimation. Onewaytoautomatethisprocessisbyusingmachinelearningtechniques. Incomparison
totraditionalmachinelearningtechniques,deeplearningcanexploitbothlooselydefinedglobaland
localfeaturescapturedatmultiplelevelstoachievebetterpredictionaccuracy[36]. However,itis
importanttodeterminetowhatextentreliableSVFestimatescanbederivedifadeeplearningmodel

RReemmoottee SSeennss.. 22001177,, 99,, 441111 33 ooff 1177
what extent reliable SVF estimates can be derived if a deep learning model is used for sky
isusedforskydelineation. ThiscanbeachievedthroughcomparisonswithotherSVFestimation
delineation. This can be achieved through comparisons with other SVF estimation approaches. In
approaches. Inadditiontoestimationaccuracy,computationalperformanceisanotherimportantissue
addition to estimation accuracy, computational performance is another important issue to be
tobeconsideredinbigdatautilization.
considered in big data utilization.
Figure 1. Data access and coverage of the Google Street View (GSV) imagery: (a) exploring on Google
Figure1.DataaccessandcoverageoftheGoogleStreetView(GSV)imagery:(a)exploringonGoogle
Maps; (b) requesting through the GSV Application Program Interface (API); (c) GSV coverage map
Maps;(b)requestingthroughtheGSVApplicationProgramInterface(API);(c)GSVcoveragemap
(google.com).
(google.com).
This paper is organized as follows. Section 2 introduces the core methodology, comprising a set
Thispaperisorganizedasfollows. Section2introducesthecoremethodology,comprisingasetof
of data retrieval techniques, a deep learning model, a hemispherical transformation technique, and
dataretrievaltechniques,adeeplearningmodel,ahemisphericaltransformationtechnique,andthe
the algorithm for calculating SVF. Section 3 is focused on accuracy and performance analysis.
algorithmforcalculatingSVF.Section3isfocusedonaccuracyandperformanceanalysis. Section4
Section 4 discusses the uncertainties and future work. In Section 5, we briefly review the conclusions.
discussestheuncertaintiesandfuturework. InSection5,webrieflyreviewtheconclusions.
2. Methods
2. Methods
Here we present the four-step workflow procedure for automatically extracting SVF from street
Herewepresentthefour-stepworkflowprocedureforautomaticallyextractingSVFfromstreet
view images (Figure 2). Step 1 and 2 are introduced together in Section 2.1, which describes how
view images (Figure 2). Step 1 and 2 are introduced together in Section 2.1, which describes how
street view data are retrieved and processed. Section 2.2 introduces the deep learning model, which
streetviewdataareretrievedandprocessed. Section2.2introducesthedeeplearningmodel,which
classifies the street view panoramas prepared using the techniques presented in Section 2.1. In the
classifiesthestreetviewpanoramaspreparedusingthetechniquespresentedinSection2.1. Inthe
final step, the panoramas are transformed into fisheye images for SVF calculation, which is
finalstep,thepanoramasaretransformedintofisheyeimagesforSVFcalculation,whichisdescribed
described in Section 2.3.
inSection2.3.

RemoteSens.2017,9,411 4of17
Remote Sens. 2017, 9, 411 4 of 17
Figure 2. Workflow procedure for extracting SVF from street view images.
Figure2.WorkflowprocedureforextractingSVFfromstreetviewimages.
2.1. Retrieval and Stitching of Street View Images
2.1. RetrievalandStitchingofStreetViewImages
The method described in this section consists of two steps. The first step is to retrieve street
Themethoddescribedinthissectionconsistsoftwosteps. Thefirststepistoretrievestreetview
view images from one of the providers, which can be done using their corresponding API. Static
imsatgreeest fvrioemw iomnaegoefs cthane bper orevqidueesrtse,dw frhoimch GcSaVn [b2e8]d, oBnSVe u[2s9i]n, gantdh eTiSrVco [3rr0e] svpiao nthdeiinr greAspPeIc.tiSvtea tpicubsltirce et
vieAwPiIm. Taog erestcriaenveb eanre iqmuaegsete, dthfer ofomv,G hSeVad[i2n8g],, pBiStcVh,[ 2a9n]d, aloncdatTioSnV o[f3 0th]ev icaamtheeriar rneesepde tcoti vbee psuupbplilcieAd PI.
Towreittrhi ethvee HanTiTmPa rgeeq,utehset. fTohv,e hfoeavd, hinega,dpinitgc,h a,nadn dpitlochca atrioe nalol fexthperecsasmede rina dneegedreetos. bTehseu HpTpTliPed rewquitehstt he
HTfoTrPmraetq, uheoswt.evTehre, fsolivg,hhtleya dvainrige,s aancdropssit cthheasree AaPllIse.x Tpore ssismedpliinfyd ceagmreeeras. pTahreamHeTteTrPizaretiqoune, swtefo arrme at,
howasesvuemr,inslgi gthhatlty avlla irmieasgaecsr oresqsuthesetseedA hPaIvse. Teoqusaiml wpliidftyhc aanmde hraeipgahrta smo etthearti ztahtei ovne,rwticeala rfoeva siss uemquinalg ttoh at
alltihme ahgoersizroenqtuael sftoevd. hTaov pereeqvueanlt wa ifdutlhl paanndohraemigah tfrsoomth baetinthge rveetrriteivcaeldf oinv ais seinqgulael itmoathgee hreoqruizeosnt, ttahlef ov.
Tompraexvimenutma faullllopwaendo vraamluae forfo tmheb feoivn gis rneotrrimevaelldy irnesatrsiicntegdle tiom baeg semraelqleure tsht,atnh e36m0.a Ixni mthuem GSaVllo AwPeId [2v8a]l, ue
oftfhore efoxavmispnleo,r tmhea lmlyarxeimstruimcte adllotowbeeds fmova lilse 1r2t0h.a Uns3a6g0e. eIxnatmheplGesS Vof AeaPcIh[ 2o8f ]t,hfeo rsterxeaetm vpielew, tihmeamgea AxiPmIsu m
alloarwe esdhofwovn iisn 1T2a0b.leU 1s.a Age deexvaemloppeler skoeyf eisa crheqoufirtehde fsotrr eaellt ovfi etwhemim. aAgne iAmPagIse acraen sbheo wrentriienveTda bblye 1.
simply pasting a request URL into a web browser or by sending API requests in batch using any
Adeveloperkeyisrequiredforallofthem. Animagecanberetrievedbysimplypastingarequest
programming languages that support the HTTP transfer protocol.
URLintoawebbrowserorbysendingAPIrequestsinbatchusinganyprogramminglanguagesthat
supporttheHTTPtransferprotocol.
Table 1. Usage examples of the street view image APIs.
Street View API Table1.UsageexamplesofUthseagster eEextavmiepwle i(mHaTgTePA RPeIqsu.est)
https://maps.googleapis.com/maps/api/streetview?size=400x400&location
GSV [28]
StreetViewAPI =52.214, 21.022&fov=U90s&agheeaEdxianmg=p2le35(&HpTiTtcPhR=1e0q&ukeesyt)=YOUR_API_KEY
Baidu SGtrSeVet [V28ie]w (BSV) [29]
htthptst:p/:///mapaip.ms.agpoo.bgaliedaup.icso.cmom/p/amnoarpasm/aa/pvi2/?swtreidettvhi=e5w12?s&izhee=ig4h00t=x245060&&llooccaattiioonn=
52.=211146,2.311.032329&3,f4o0v.0=49707&8h&efaodvi=n1g8=02&3a5k&=pYiOtchU=R1_0A&PkIe_yK=EYYO UR_API_KEY
http://apis.map.qq.com/ws/streetview/v1/image?size=600x480&location=3
Tencent Street View (TSV) [30] http://api.map.baidu.com/panorama/v2?width=512&height=256&location=
BaiduStreetView(BSV)[29] 9.940679,116.344064&pitch=0&heading=0&key=YOUR_API_KEY
116.313393,40.04778&fov=180&ak=YOUR_API_KEY
http://apis.map.qq.com/ws/streetview/v1/image?size=600x480&location=39.
TencentStreetView(TSV)[30]
940679,116.344064&pitch=0&heading=0&key=YOUR_API_KEY

RemoteSens.2017,9,411 5of17
Thenextstepistostitchtheretrievedstreetviewimagesintopanoramas. Thisstepistrickier
andneedstobeself-implemented. Tostitchtogetheramulti-perspectivesetofstreetviewimages
associatedwiththesamepanorama,oneneedstoreconstructtherenderingmodelwithwhichthese
imagesaregeneratedfromthepanorama. Accordingtothedocumentation[28],itisknownthatin
fulfillingastreetviewimagerequestfromaclient,theequirectangularpanoramahostedontheserver
ismappedontoasphericalgeometry,andthena3Drenderingpipelineissetupwiththeparameters
suppliedwiththeHTTPrequest. This3Drenderingpipelineisusedtodrawthetexturedsphereonto
animage,whichisthensenttotheclient. Tomapastreetviewimagebackontoanequirectangular
panorama, each pixel in the street image needs to be linked up to a pixel in the equirectangular
panorama. Ifamulti-perspectivesetofstreetviewimagesretrievedfullycoverthewholefieldofview,
itistheoreticallypossibletostitchthemtogetherintoanequirectangularpanoramicimage. Withthe
GoogleStreetViewAPI,siximagesof90fovfacingleft,right,forward,back,up,anddown,respectively,
canprovideafullpanoramicview. WithTencentStreetView,thefovisfixedatabout60,hencemore
imagerequestsareneededtofullycoverthewholefieldofview. Thetransformationthatisusedto
renderapanoramasphereontoanimagecomprisestheviewandperspectivetransformations[37]:

| MatViewProj | = MatView×MatProj |     |     |     |     |     |
| ----------- | ----------------- | --- | --- | --- | --- | --- |

|         |            |           |       |                 |    |     |
| ------- | ----------- | --------- | ----- | --------------- | --- | --- |
|         | v R i g h   | t v U p   | − v   | F o r w a r d   | 0   |     |
|         |             | x         | x     | x               |     |     |
|         |  v R i g h | t y v U p | y − v | F o r w a r d y | 0  |     |
| MatView | =          |           |       |                 |    |     |
|         |            |           | −     |                 |    |     |
|         |  v R i g h | t z v U p | z v   | F o r w a r d z | 0  |     |
|         | − e y e     | − ey      | e     | − e y e         | 1   |     |
|         |             | x         | y     | z               |     |     |
(1)
|                    |  1 |     |     |     |     |    |
| ------------------ | --- | --- | --- | --- | --- | --- |
|  |     |     | 0   | 0   | 0   |     |
tan(f ov/2)
|     |    |     | 1   |     |     |    |
| --- | --- | --- | --- | --- | --- | --- |
|     |  0 |     |     | 0   | 0   |    |
tan(f ov/2)
| MatProj | =  |     |     | Z + Z     |         |    |
| ------- | --- | --- | --- | --------- | ------- | --- |
|         |  0 |     | 0   | − f a r n | e a r 0 |    |
|         |    |     |     | Z − Z     |         |    |
|         |    |     |     | f a r n   | e a r   |    |
2×Zf ×Znear
|     | 0   |     | 0   | − 1 | − ar |     |
| --- | --- | --- | --- | --- | ---- | --- |
Zfar −Znear
whereMatViewistheviewtransformationwhichdefinesthecamera’slocalcoordinatesystem,and
MatProjistheprojectiontransformation. MatViewisa4-by-4matrixcreatedfromthethreeorthogonal
vectorswhichdefinetheview-spaceaxisandthecameraposition:therightvectorvRight(x,y,z),theup
vectorvUp(x,y,z),theviewdirectionvectorvForward(x,y,z),andcameradirectionvCamPos(x,y,z).
TheprojectionmatrixcanbeconstructedwiththefovandtheclipplanedistancesZfarandZnear.
Assumingthepanoramaspherehasaradiusof1unit,Znear∈[0,1]andZfar∈[1,∞].
Figure 3 shows five images retrieved fromGSV with a fov of 90. Each of the images looks at
adirectionalongoneoftheworldaxes. Tomaptheseimagesbackontoapanorama(Figure3b,c)
in a spherical space, the view matrix and projection matrix associated with each image need to
|     |     |     |     | 180◦, | 0◦) |     |
| --- | --- | --- | --- | ----- | --- | --- |
be reconstructed. We use image No. 3 (Figure 3a, θ = ϕ = as an example to show how
the matrix construction techniques work. The world space is defined so that image No. 3 is
oriented in the negative X direction. Hence vForward(x, y, z) = (0, −1, 0), vUp(x, y, z) = (0, 0, 1),
|     | ×   |     |     | (−1, |     |     |
| --- | --- | --- | --- | ---- | --- | --- |
and vRight(x,y,z) = vForward(x,y,z) vUp(x, y, z) = 0, 0), eye(x, y, z) = (0, 0, 0). These four
parametersareusedtoconstructtheviewmatrixandtheprojectionmatrix(Equation(1))withwhich
imageNo. 3(Figure3a)wasgenerated. Theviewandprojectionmatricesoftheotherimagesare
constructedsimilarly. Foreachpixelinthepanorama(Figure3b),acolorvalueissampledfromthe
imagesetbyperformingthefollowingsteps:
1. TransformthenormalizedimagecoordinatesPpano(u,v)(Ppanou∈[0,1],Ppanov∈[0,1])into
sphericalcoordinatesPspherical(lon,lat). Thiscanbeeasilydonewiththerow/columnindexand
thesphericalextentassociatedwiththepanoramicimage.

| RemoteSens.2017,9,411 |     |     |     |     |     |     |     | 6of17 |
| --------------------- | --- | --- | --- | --- | --- | --- | --- | ----- |
2. TransformthesphericalcoordinatesPspherical(lon,lat)intoworldspacecoordinatesPworld(x,y,z).

|                             |     | Pworld | =cos(Pspherical |     | )×sin(Pspherical | )   |          |     |
| --------------------------- | --- | ------ | --------------- | --- | ---------------- | --- | -------- | --- |
|                             |     |      | x               | lat |                  | lon |          |     |
|                             |     | Pworld | =cos(Pspherical |     | )×cos(Pspherical | )   |          | (2) |
| Remote Sens. 2017, 9, 411   |     |        | y               | lat |                  | lon | 6 of 17  |     |

|     |     | Pworld | y =sin(Pspherical |     | )   |     |     |     |
| --- | --- | ------ | ----------------- | --- | --- | --- | --- | --- |
lat
|     |     | (cid:1842)(cid:1875)(cid:1867)(cid:1870)(cid:1864)(cid:1856) | =cos(cid:4666)(cid:1842)(cid:1871)(cid:1868)ℎ(cid:1857)(cid:1870)(cid:1861)(cid:1855)(cid:1853)(cid:1864) |                                | (cid:4667)×sin(cid:4666)(cid:1842)(cid:1871)(cid:1868)ℎ(cid:1857)(cid:1870)(cid:1861)(cid:1855)(cid:1853)(cid:1864) | (cid:4667)                     |     |     |
| --- | --- | ------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------------- | ------------------------------ | --- | --- |
|     |     |                                                              | (cid:3051)                                                                                                | (cid:3039)(cid:3028)(cid:3047) |                                                                                                                     | (cid:3039)(cid:3042)(cid:3041) |     |     |
3. Loopoverthesetofim(cid:4688)(cid:1842)a(cid:1875)ge(cid:1867)s(cid:1870)(cid:1864)a(cid:1856)n d=tcroasn(cid:4666)(cid:1842)sf(cid:1871)o(cid:1868)rℎm(cid:1857)(cid:1870)(cid:1861)t(cid:1855)h(cid:1853)e(cid:1864) w (cid:4667)o×rlcdoss(cid:4666)p(cid:1842)a(cid:1871)(cid:1868)ceℎ(cid:1857)c(cid:1870)o(cid:1861)(cid:1855)o(cid:1853)r(cid:1864)d i n(cid:4667)a tesPworld(x,y,z(,21) .0)into
|     |     |     | (cid:3052) | (cid:3039)(cid:3028) (cid:3047) |     | (cid:3039)(cid:3042) (cid:3041) |     |     |
| --- | --- | --- | ---------- | ------------------------------- | --- | ------------------------------- | --- | --- |
clip-spacecoordinatesP(cid:1842)c(cid:1875)li(cid:1867)p(cid:1870)((cid:1864)x(cid:1856),(cid:3052) y=,zs,iwn(cid:4666))(cid:1842)b(cid:1871)y(cid:1868)ℎm(cid:1857)(cid:1870)u(cid:1861)(cid:1855)l(cid:1853)ti(cid:1864)p(cid:3039)(cid:3028)l(cid:3047)y(cid:4667)ingPworld(x,y,z,1.0)byMatViewProjforeach
image. 3.  Loop over the set of images and transform the world space coordinates Pworld(x, y, z, 1.0) into  ThefollowingequationisusedtotransformPworld(x,y,z,1)intonormalizedscreenspace
coordcilinpa-stepsacPei cmoaogrde(iuna,tve)s: Pclip(x, y, z, w) by multiplying Pworld(x, y, z, 1.0) by MatViewProj for each
image. The following equation is used to transform Pworld(x, y, z, 1) into normalized screen

|     |     | s PiPmcalgiep(u(,x v,)y: ,z,w) | = Pworld(x,y,z,1)×MatViewProj |     |     |     |     |     |
| --- | --- | ------------------------------ | ----------------------------- | --- | --- | --- | --- | --- |
space coordinate
|     |     | P(cid:1842)i(cid:1855)m(cid:1864)(cid:1861)a(cid:1868)g(cid:4666)(cid:1876)e            | = ( (cid:1875)P(cid:4667)c=lip(cid:1842)x(cid:1875)/(cid:1867)P(cid:1870)(cid:1864)c(cid:1856)l(cid:4666)i(cid:1876)p,w(cid:1877), |                    | + (cid:1878),11(cid:4667) ) × (cid:1839)0(cid:1853).5(cid:1872)(cid:1848)(cid:1861)(cid:1857)(cid:1875)(cid:1842)(cid:1870)(cid:1867)(cid:1862) |     |      | (3) |
| --- | --- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- | --- | ---- | --- |
|     |     |                                                                                         | u,(cid:1877) ,(cid:1878),                                                                                                          |                    | ×                                                                                                                                               |     |      |     |
|     |     |                                                                                       | (cid:0)                                                                                                                            |                    | (cid:1)                                                                                                                                         |     |      |     |
|     |     | (cid:4688)P(cid:1842)i(cid:1861)m(cid:1865)a(cid:1853)g(cid:1859)e(cid:1857)v(cid:3048) | ==(cid:4666) (cid:1842)P(cid:1855)c(cid:1864)l(cid:1861)(cid:1868)ip ⁄ y(cid:1842)/(cid:1855)P(cid:1864)(cid:1861)c(cid:1868)l     | ip+w1+(cid:4667)×1 | 0.×5 0.5                                                                                                                                        |     | (3)  |     |
(cid:3051) (cid:3050)
|              |               | (cid:1842)(cid:1861)(cid:1865)(cid:1853)(cid:1859)(cid:1857) | =(cid:3435)(cid:1842)(cid:1855)(cid:1864)(cid:1861)(cid:1868) ⁄(cid:1842)(cid:1855)(cid:1864)(cid:1861)(cid:1868) | +1(cid:3439)×0.5 |                 |                       |     |     |
| ------------ | ------------- | ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- | ---------------- | --------------- | --------------------- | --- | --- |
|              |               |                                                              | (cid:3049) (cid:3052)                                                                                             | (cid:3050)       |                 |                       |     |     |
|              | ∈[0,1],Pimage |                                                              | ∈[0,1].                                                                                                           |                  | ∈/[0,1]orPimage | ∈/[0,1],theimagebeing |     |     |
| where,Pimage | u             |                                                              | v IfPimage                                                                                                        |                  | u               | v                     |     |     |
where, Pimageu ∈ [0, 1], Pimagev ∈ [0, 1]. If Pimageu ∉ [0, 1] or Pimagev ∉ [0, 1], the image being
consideredisdisregarded. Otherwise,acolorvalueissampledfromthisimageatPimage(u,v)
considered is disregarded. Otherwise, a color value is sampled from this image at Pimage(u, v)
andcopiedtoPpano(u,v).
and copied to Ppano(u, v).

Figure 3. Reconstruction of a panorama from a GSV image set: (a) a multi-perspective set of images
Figure3.ReconstructionofapanoramafromaGSVimageset:(a)amulti-perspectivesetofimages
from GSV; (b) the reconstructed panorama; (c) an illustration of the spherical coordinate system.
fromGSV;(b)thereconstructedpanorama;(c)anillustrationofthesphericalcoordinatesystem.
The panorama stitching algorithm presented above was implemented in C++ and integrated
Tihnetop tahne owroarmkfaloswti ttcoh rienngdaelrg tohrei trhetmriepvreeds estnreteedt vaiebwov iemwagaess iimntop lpeamnoernatmedasi.n InC t+h+eoarny,d ai snetaemgrleastse dinto
panorama can be reconstructed from a multi-perspective set of street view images using the
theworkflowtorendertheretrievedstreetviewimagesintopanoramas.Intheory,aseamlesspanorama
techniques  presented  above.  In  practice,  however,  we  observed  minor  misalignments  in  the
canbereconstructedfromamulti-perspectivesetofstreetviewimagesusingthetechniquespresented
panoramas reconstructed from the GSV images. The misalignments were determined to be in the
above.Inpractice,however,weobservedminormisalignmentsinthepanoramasreconstructedfromthe range of 1–10 pixels in the 1024-by-1024 panoramas. We speculate that GSV may use a slightly
GSVimdiaffgereesn.tT rhenedmeriisnagl imgnomdeel ntots gweneerreatde eimtearmgeisn ferodmto pbaneoirnamthaes.r Nanog meiosafl1ig–n1m0epnitxse wlseirne othbese1rv02ed4 -ibny -1024
panortahme aBsS.VW aneds pGeScVu plaatneorthamataGs. SVmayuseaslightlydifferentrenderingmodeltogenerateimages
fromp anoramas.
Nomisalignment swereobservedintheBSVandGSVpanoramas.

RemoteSens.2017,9,411 7of17
Remote Sens. 2017, 9, 411 7 of 17
2.22..2A. AD DeeepepL eLaeranrnininggM Mooddelelf oforrC Clalassssifiyfyiinngg SSttrreeeett VViieeww IImmaaggeess
CConovnevnetniotinoanlaml macahcihnien-el-elaeranrnininggt etcehchnniqiquuesesw wereerel ilmimitietdedi nint htheierira baibliiltiytyt otop prorcoecsesssn antauturarladl dataatain
thieni rthraewir froarwm f.oDrmee. pDleeeaprn lienagrnailnlogw asllcoowms pcuotmatpiountaatliomnoadl emlsotdhealts ctohnast icsotnosfimst uolft impluelptirpolcee pssrioncgeslsaiynegr s
tolaleyaerrns troe pleraersnen rteaptiroensesnotaftdioantas owfi tdhatma uwltiitph lemluelvtieplsleo lfevabelsst roafc taibosntr[a3c6t]io.nD [e3e6p]. cDoenevpo lcuotniovnoalultnioenuarla l
neural networks (CNNs) have the ability to automatically learn hierarchical feature representations
networks(CNNs)havetheabilitytoautomaticallylearnhierarchicalfeaturerepresentationsandhave
and have been widely used in image classification and pattern recognition [38]. For example, a CNN
beenwidelyusedinimageclassificationandpatternrecognition[38].Forexample,aCNNmayabstract
may abstract raw pixels into edges in the second layer, then abstract edges into simple shapes in the
rawpixelsintoedgesinthesecondlayer,thenabstractedgesintosimpleshapesinthefollowinglayer,
following layer, and then generalize these shapes into high-level features in higher layers. This is
andthengeneralizetheseshapesintohigh-levelfeaturesinhigherlayers. Thisisalsoknownasfeature
also known as feature engineering [39], which is the process of using domain knowledge of the data
engineering[39],whichistheprocessofusingdomainknowledgeofthedatatocreatefeaturesthat
to create features that make machine learning algorithms work. In traditional machine learning,
makemachinelearningalgorithmswork. Intraditionalmachinelearning,featureengineeringrelies
feature engineering relies largely on manual extraction, which is both difficult and expensive [39].
largelyonmanualextraction,whichisbothdifficultandexpensive[39]. Longetal.[40]wasthefirstto
Long et al. [40] was the first to extend traditional CNNs into “fully-convolutional” neural networks
extendtraditionalCNNsinto“fully-convolutional”neuralnetworksforpixel-levelimagesegmentation.
for pixel-level image segmentation.
SegNet is a deep convolutional network architecture built on top of the Caffe deep learning
SegNet is a deep convolutional network architecture built on top of the Caffe deep learning
library(Figure4). Itwasdesignedspecificallyforpixel-levelsematicsegmentation. Comparedto
library (Figure 4). It was designed specifically for pixel-level sematic segmentation. Compared to
traditionalmethods,SegNethasachievedhigherscoresforroadscenesegmentationwithimproved
traditional methods, SegNet has achieved higher scores for road scene segmentation with improved
computational efficiency. When trained on a large dataset of 3433 images, SegNet has reportedly
computational efficiency. When trained on a large dataset of 3433 images, SegNet has reportedly
achievedanaccuracyof96.1%forskypixels[41]. Anonlinedemoisavailableat[42]foruserstoselect
achieved an accuracy of 96.1% for sky pixels [41]. An online demo is available at [42] for users to
andclassifyasingleimageatatime. Tobatchprocessthousandsofimages,however,oneneedsto
select and classify a single image at a time. To batch process thousands of images, however, one
compilethecodeandwriteabatchscriptusingPython. ThesourcecodeofSegNetwasdownloaded
needs to compile the code and write a batch script using Python. The source code of SegNet was
from[43]. Itisfreeforpersonalandresearchuseonly. Thesourcecodewasmodifiedandrecompiled
downloaded from [43]. It is free for personal and research use only. The source code was modified
soanthda rteictocmouplidledru sno othnaWt iitn cdoouwlds roupne orant iWnginsdyoswtesm ospewraitthinfgu lslyssutepmpso rwtiftohr fCulol msuppuptoerUt fnoirfi CedomDpeuvtiec e
AUrcnhiiftieecdt uDreev(iCceU ADrAch)-ibteacsteudrea (cCcUelDerAat)i-obnas.eTd haeccperloergartaiomn.r Teahde spirnogaraJPmE Greaidmsa igne ao JfPaEGsp iemciafigeed osfi zae ,
claspsseicfiifeisedit suizsein, gclathsseifdieese pit luesairnngi nthgei ndfeeerpen lceearenninggin ien,faenredncthe eenngwinriet,e asnodu tthaenni mwraigtees woiutth aan niummagbee r
ofwciltahs sae sn,uemacbhero fowf chliacshseiss, eenaccohd oefd winhaichu nisiq eunecocodleodr. iInn at huisnisqtuued yc,owloer.u Isne dthtihs estpurdey-t,r awine eudseSde gtNhee t
mpordee-tlrtaoinpeedr fSoergmNsekt ymdoedlienl etaot ipoenrfoonrmst rsekeyt vdieelwineimatiaogne so.nT shtereSeet gvNieewt mimodageelsc.l aTshseifi SeesgaNreota dmoscdeenl e
imcalagsesiifnietos a1 2roclaads ssecse.nIen iomuargwe oinrktofl o1w2 ,ctlhasessees1. 2Inc loaussre wsaorrekflluomwp, ethdeisnet o12t hcelassksyesa anrde nluomn-pskedy cinlatsos ethsei n
aspkoys t-apnrdo censosnin-sgksyt ecpl.asWseesa dinju sat edpotshte-pmroocdeseslisnog thsatetpit. cWane acacdojumsmtedo dtahtee 1m02o4d-bely -s1o0 2t4hpata niot racmani c
imaaccgoems.mWoedaaltseo 1c0o2n4fi-bgyu-r1e0d24t hpeasnoofrtwamarice aimndagheasr. dWwea raeleson vcioronnfimguernetds othteh astoSftewgNareet acnand rhuanrdinwbaoreth
GePnUviarnodnmCePnUt smo othdaets SfeogrNpeetr fcoarnm raunnc iene bvoatlhu aGtiPoUn .and CPU modes for performance evaluation.
Figure 4. An illustration of the convolutional SegNet architecture for pixel-wise classification of road
Figure4.AnillustrationoftheconvolutionalSegNetarchitectureforpixel-wiseclassificationofroad
scenes [41].
scenes[41].

RemoteSens.2017,9,411 8of17
| Remote Sens. 2017, 9, 411   |     |     |     |     |     |     |     | 8 of 17  |     |
| --------------------------- | --- | --- | --- | --- | --- | --- | --- | -------- | --- |
2.3. HemisphericalTransformationandCalculationofSVF
2.3. Hemispherical Transformation and Calculation of SVF
Normally,fisheyephotographsarecapturedandstoredinahemisphericalprojection.SVFcalculation
Normally, fisheye photographs are captured and stored in a hemispherical projection. SVF
isalsoconductedinthesamehemisphericalspace[44]. Hence,theequirectangularpanoramasare
calculation is also conducted in the same hemispherical space [44]. Hence, the equirectangular
transformedpainnotoramfisash aerye etraimnsfaogrmesedf oinrtov fiissuheayle aimnaaglyess fiosr avnisduaSl aVnFalycsaisl caundla StVioFn ca(lFcuilgautiorne (5F)ig.ure 5).

Figure 5. Sampling pixels from a panorama into a fisheye image (in this example, the pixel at
Figure 5. Sampling pixels from a panorama into a fisheye image (in this example, the pixel at
U(x = 0.27, y = 0.45) in the fisheye image is sampled from the pixel at Ppano(u = 0.086, v = 0.738) in the
U(x=0.27,yp=an0or.a4m5)a) iwnitthh aell nfiosnh-sekyy eclaismseas gluemipseds ainmto ponlee dclafsrso (bmluet)h. e pixel at Ppano(u = 0.086, v = 0.738)
inthepanorama)withallnon-skyclasseslumpedintooneclass(blue).
An equisoild angle projection is used for representing fisheye images [45]. To transform an
equirectangular panoramic image into a fisheye image, the first step is to create a four-channel image
An equoif seoquiladl waidntgh laendp hreoigjehct.t Tiohen siizse ouf stheids imfoagre rsehopurleds been ctoimnmgefinssuhraetye ewitihm thaeg eeqsui[re4c5ta]n.guTlaor  transform
anequirectapnagnuolraamrpic ainmoargae mtoi cavimoida guendinertsoamapfilisnhg.e yFoer imeacahg pei,xtehl einfi trhsits simteapgei:s itfo itc rlieesa toeuatsifdoeu orf- cthhea nnelimage
inscribed circle, the pixel is marked transparent; otherwise, a pixel value is sampled from the
ofequalwidthandheight. Thesizeofthisimageshouldbecommensuratewiththeequirectangular
equirectangular panoramic image at the following coordinates (Figure 5):
panoramicimagetoavoidundersampling.Foreachpixelinthisimage:ifitliesoutsideoftheinscribed
|     |     | r(cid:1855)e(cid:1867)(cid:1871)n(cid:2879)t(cid:2869);(cid:4678)o |     | → (cid:3270) .→ (cid:3263) (cid:4679)i(cid:3416)se2,(cid:2024)a×p | (cid:3022) i(cid:3299) +el(cid:4672)1va−l | (cid:3022) (cid:3299) | (cid:4673)i⁄s2s,(cid:1847)a(cid:3051)m(cid:3405)p0le			d					f		r	 |     |     |
| --- | --- | ------------------------------------------------------------------ | --- | ----------------------------------------------------------------- | ----------------------------------------- | --------------------- | ------------------------------------------------------------------ | --- | --- |
circle,thepixelismarked (cid:1842)(cid:1868) tr (cid:1853) a (cid:1866)(cid:1867) n s = pa (cid:4688) t h e r w x u e   o   mtheeq ( u 4) i   rectangular
|     |     | (cid:3048) | (cid:4699) → (cid:3270) | (cid:4699) × (cid:4699) → (cid:3263) (cid:4699) | | (cid:3022) (cid:3299) | | | (cid:3022) (cid:3299) | |     |     |     |
| --- | --- | ---------- | ----------------------- | ----------------------------------------------- | ------------------------- | ------------------------- | --- | --- | --- |
panoramicimageatthefollowing0c,o(cid:1847)or=di0n		ates(Figure5):
(cid:3051)
|     |    |       | (cid:18)                  | (cid:19)=                                 |                             |                 |                       |      |     |
| --- | --- | ----- | ------------------------- | ----------------------------------------- | --------------------------- | --------------- | --------------------- | ---- | --- |
|     |     |       | → 	(cid:1842).(cid:1868)→ | (cid:1853)(cid:1866)(cid:1867) (cid:3049) | 1 − (cid:4699) → (cid:4699) | × 0. 5 (cid:16) | (cid:17)              | (5)  |     |
|     |   | cos−1 | U                         | N                                         | / 2 π × (cid:3022)          | U x +           | 1− Ux /2,U (cid:54)=0 |      |     |
|     |     |       | (cid:107) → (cid:107) ×   | (cid:107) → (cid:107)                     |                             | | |             | | | x                 |      |     |
whereP Pppaannoo(uu, =v) is the normali z ed   co o rd inates of a p iUxexl  in the pan oUraxm a image , U(x, y) is the  (4)
|     |     |     | U   | N   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
coordinates of a pixel i0n ,thUe  fis=hey0e image, and N is a unit vector in the positive Y direction on the
x
fisheye image. Ppanou is obtained by normalizing the angle between U and N. The pixels of a fisheye
image are traversed to calculate the SVF value as follows:
|     |     |     | Ppano                                      | v =1−(cid:107)                 | →                                                                | (cid:107) × 0.5                |     |      | (5) |
| --- | --- | --- | ------------------------------------------ | ------------------------------ | ---------------------------------------------------------------- | ------------------------------ | --- | ---- | --- |
|     |     |     | (cid:1845)(cid:1848)(cid:1832)=∑(cid:3041) |                                | (cid:2033)×(cid:1858)U(cid:4666)(cid:1861)(cid:4667)⁄∑(cid:3041) | (cid:2033)                     |     | (6)  |     |
|     |     |     |                                            | (cid:3036)(cid:2880)(cid:2868) |                                                                  | (cid:3036)(cid:2880)(cid:2868) |     |      |     |
where Ppanwo(hue,rev ω) iiss a twheeignhto arsmsocailaitzede dwictho eoarcdh ipnixaetle, asnod ff(ia) isp ai xfuenlcitniont hdeeteprmainnoedr abmy waheimthearg thee, sUky( x, y) is the
is visible at a pixel:
coordinatesofapixelinthefisheyeimage,andNisaunitvectorinthepositiveYdirectiononthe
|     |     |     |     | 1, (cid:1861)(cid:1858) | (cid:1853)(cid:1864)(cid:1868)ℎ(cid:1853)=0(cid:4666)(cid:1868)(cid:1861)(cid:1876)(cid:1857)(cid:1864)(cid:1861)(cid:1871)(cid:1871)(cid:1863)(cid:1877)(cid:4667) |     |     |     |     |
| --- | --- | --- | --- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- | --- | --- | --- |
fisheyeimage. Ppano u isobtained(cid:1858)(cid:4666)b(cid:1861)(cid:4667)y=n(cid:3420)o r m a li z in g th e a n g l e b e t w e e n U  andN.Thepixe(7ls) ofafisheye
|     |     |     | 			 		 			0 | , (cid:1861) (cid:1858) | (cid:1853) (cid:1864)(cid:1868)ℎ (cid:1853) (cid:3408) 0 | (cid:4666) (cid:1868)(cid:1861) (cid:1876) (cid:1857)(cid:1864) (cid:1861) (cid:1871) (cid:1866) | (cid:1867)(cid:1872) (cid:1871) (cid:1863) (cid:1877)(cid:4667) |     |     |
| --- | --- | --- | ----------- | ----------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------------------ | --------------------------------------------------------------- | --- | --- |
imagearetraversedtocalculatetheSVFvalueasfollows:
ω can be resolved into two components, with the latter being optional. The first component
(Equation (8)) approximates the transformation from the fisheye's equisoild angle projection to an
|                               |     |     | SVF = | ∑n  | ω× f(i)/∑n |                      | ω   |     | (6) |
| ----------------------------- | --- | --- | ----- | --- | ---------- | -------------------- | --- | --- | --- |
| equal-areal projection [45]:  |     |     |       | i=0 |            | i=0                  |     |     |     |
|                               |     |     |       |     | (cid:2030) | (cid:2879)(cid:2869) |     |     |     |
whereωisaweightassociatedwitheachpi(cid:2033)xe=l,(cid:1871)a(cid:1861)(cid:1866)n (cid:4666)(cid:2030)d (cid:4667)f×(i(cid:4672))9i0s° (cid:4673)af unctiondeterminedbywhe(t8h) ertheskyis
visibleatapixelT:he second component (Equation (9)) scales the incoming radiation by the Lambert’s cosine
(cid:40)
law, and it is optional depending o1n, howif thea SlVpFh ais =def0ine(dp.i Exqeulaitsiosnk (y9)) shows how to apply the
| Lambert’s cosine fla(wi) [4=5]:  |     |     |     |     |     |     |     |     | (7) |
| -------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
>0(pixelisnotsky)
|     |     |     | 0,  | if  | alpha |     |     |     |     |
| --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- |
ω can be resolved into two components, with the latter being optional. The first component

(Equation (8)) approximates the transformation from the fisheye’s equisoild angle projection to
anequal-arealprojection[45]:
|     |     |     |            |     | (cid:16) | ϕ (cid:17)−1 |     |     |     |
| --- | --- | --- | ---------- | --- | -------- | ------------ | --- | --- | --- |
|     |     |     | ω =sin(ϕ)× |     |          |              |     |     | (8) |
|     |     |     |            |     | 90       | ◦            |     |     |     |
The second component (Equation (9)) scales the incoming radiation by the Lambert’s cosine
law,anditisoptionaldependingonhowtheSVFisdefined. Equation(9)showshowtoapplythe
Lambert’scosinelaw[45]:
|     |     |     |     |     | (cid:16) (cid:17)−1 |     |     |     |     |
| --- | --- | --- | --- | --- | ------------------- | --- | --- | --- | --- |
ϕ
|     |     | ω   | =sin(ϕ)× |     |     | ×cos(ϕ) |     |     | (9) |
| --- | --- | --- | -------- | --- | --- | ------- | --- | --- | --- |
90 ◦

RemoteSens.2017,9,411 9of17
TheLambert’scosinelawisnotconsideredinthisstudytoavoidcomplicatingtheanalysis,butit
canbefactoredinwhenevernecessary.
3. ComparisonsandApplication
In this section, we compare the SVF estimates derived from street view images with those
from two independent sources, first a DSM at 1 m resolution and then an oblique airborne
photogrammetry-based 3D city model (OAP3D) at a sub-meter resolution. The purpose of these
twogroupsofcomparisonsistoprovidearelativelyobjectiveassessmentoftheclassificationand
estimationaccuracy. Additionally, totestwhethertheproposedmethodcanscalewelltobigdata
volumes,anapplicationwithabout12,000GSVpanoramasispresented.
3.1. ComparisonwithSVFEstimatesfromaLiDAR-DerivedDSM
Thehigh-resolutionDSM(Figure6)wasretrievedfromtheNaturalResourcesWalesLiDARdata
service. TheNaturalResourcesWalesdatasetcontainsdigitalelevationdataderivedfromsurveys
carriedoutoverseveralyearsandcoversapproximately70%ofWales. The1mDSMofCardiffis
arepresentationofobjectheightssuchasvehicles,buildings,andvegetation.Furtherinformationabout
thedataisavailableat[46]. Atotalofabout400GSVpanoramaswereobtainedusingtheproposed
dataretrievaltechniquesforautomaticskydelineationandSVFestimation. SVFwascalculatedat
eachsamplelocationintheDSMbyperformingthefollowingsteps:
1. ReadthesurfaceheightatthelocationfromtheDSM.
2. Settheobservationheightat2.4mabovethesurface.WeassumethattheGSVvehiclehasaheight
of1.4mandthecameraismounted1mabovethevehicle.
3. Calculate the horizon angle along each azimuthal direction in increments of 0.1 degree.
Thiscreatesahemisphericalrepresentationoftheskyboundedby3600points,eachofwhichis
givenbyrandθinthepolarcoordinatesystem,whereristhenormalizedhorizonangle[0,1]
andθisthenormalizedazimuthalangle[0,1]respectively.
4. Allocatea1024-by-1024imageforrasterizingtheskyboundary. Intherasterization,thehorizon
pointsareconvertedintoimagecoordinatesandtheareawithintheskyboundaryisfilledwith
acolordifferentthanthenon-skyarea. TheSVFisestimatedusingthesamemethodasdescribed
inSection2.3.
The comparison shows that the DSM-based SVF estimates are consistently greater than the
panorama-basedestimates,althoughthelinearregressionmodelcanexplain74.63%ofthevariance
(Figure7). Wemanuallymarkedtheskypixelsin30randomlypickedpanoramasforclassification
accuracyassessment. Theassessmentshowsanaverageof92%skypixelswerecorrectlyidentified
usingSegNetwiththeaccuracyrangingfrom80%to99%. ThefullstatisticsisgiveninTable2.
Table2.DescriptivestatisticsoftheDSM-GSVcomparison.SVF(DSM)isassumedtobethetruevalue
variableincalculatingtheRMSEandMBE,althoughitremainsunclearwhichvariableisactually
moreaccurate.
Statistics SVF(DSM) SVF(GSV) SVF(GSV)–SVF(DSM)
Mean 0.54 0.47 −0.13
Maximum 0.17 0.21 −0.53
Minimum 0.84 0.83 0.93
Standarddeviation 0.14 0.13 0.13
Rootmeansquareerror(RMSE) 0.1873
Meanbiaserror(MBE) −0.1338
Correlationcoefficient(R) 0.8639

RemoteSens.2017,9,411 10of17
Remote Sens. 2017, 9, 411 10 of 17
Remote Sens. 2017, 9, 411 10 of 17
FFiigguurree 66.. AA LLiiDDAARR--ddeerriivveedd DDSSMM aatt 11 mm rreessoolluuttiioonn iinn CCaarrddiiffff,, UUKK ((tthhee cciirrcclleess oonn tthhee ttoopp lleefftt ppaanneell
rreeppFrrieegssueernnett 6tt.hh Aee GGLSSiDVVA ssRaam-mdpperllieev lleoodcc aaDttiiSooMnns sa))..t 1 m resolution in Cardiff, UK (the circles on the top left panel
represent the GSV sample locations).
FiFgiugurere7 .7.R Reelalatitoionnsshhiipp bbeettwweeeenn tthhee GGSSVV-- aanndd DDSSMM-d-deerirviveded SVSVF Fesetsimtimataeste. s.
Figure 7. Relationship between the GSV- and DSM-derived SVF estimates.
Further visual inspections suggest a number of factors could have contributed to the
Further visual inspections suggest a number of factors could have contributed to the
underestimation. The1mDSMwaspossiblylimitedbyitsspatialresolutiontoaccuratelycapture
Further visual inspections suggest a number of factors could have contributed to the
underestimation. The 1 m DSM was possibly limited by its spatial resolution to accurately capture
tree canopies. We observed that in a number of instances, the tree canopies were present in the
underestimation. The 1 m DSM was possibly limited by its spatial resolution to accurately capture
tree canopies. We observed that in a number of instances, the tree canopies were present in the sky
tree canopies. We observed that in a number of instances, the tree canopies were present in the sky
view panorama but nearly completely missing in the DSM-derived fisheye image (Figure 8).
view panorama but nearly completely missing in the DSM-derived fisheye image (Figure 8).

RemoteSens.2017,9,411 11of17
Remote Sens. 2017, 9, 411 11 of 17
sky view panorama but nearly completely missing in the DSM-derived fisheye image (Figure 8).
HHoowweevveerr,, tthhee mmiissssiinngg ttrreeee ccaannooppiieess iinn tthhee DDSSMM ccoouulldd aallssoo bbee rreellaatteedd ttoo ttrreeee ggrroowwtthh ccyycclleess.. IInn ssoommee
ccaasseess,, mmiissssiinngg bbuuiillddiinnggss oorr ppaarrttss tthheerreeiinn hhaavvee bbeeeenn oobbsseerrvveedd,, wwhhiicchh ccoouulldd bbee rreellaatteedd ttoo ddaattaa qquuaalliittyy
iissssuueess.. FFuurrtthheerrmmoorree,, tthhee oobbsseerrvvaattiioonn hheeiigghhtt iinn tthhee DDSSMM ccoouulldd aallssoo aaffffeecctt tthhee SSVVFF eessttiimmaattiioonn.. AA lloowweerr
oobbsseerrvvaattiioonn hheeiigghhtt wwiillll rreessuulltt iinn ggrreeaatteerr SSVVFF eessttiimmaatteess iinn tthhee DDSSMM.. AAss tthhee DDSSMM ddaattaasseett wwaass ddeerriivveedd
ffrroomm ssuurrvveeyyssc caarrrireieddo ouutto voevrers esveevrearlayl eyaeras,rsb,o bthotuhr buarnbadne vdeelvoeplmopemnteannt danladn dlasncdapsceacphea nchgaesngoevse rotvheer
ptheeri opderoiofdd aotaf adcaqtau iascitqiounisictoiounld choauvlde choanvter ibcountetrdibtouttehde dtoi stchreep dainsccireespianncthiees cionm tphaer icsoomn.pIatrsishoonu. ldIt
aslhsooublde nalostoe dbet hnaotttehde tGhaStV thAeP GISdVoe AsPnIo tdroeetsu nrnott hreetudrante thoef adcaqtue iosift iaocnquainsdititohna tatnhde tihmaat gtheeu ipmdaagtee
furepqduaeten cfryevqaureinescyfr voamripesla fcreomto ppllaaccee .to place.
Figure 8. Examples in which the SVF estimates between the two sources show a difference greater
Figure8.ExamplesinwhichtheSVFestimatesbetweenthetwosourcesshowadifferencegreaterthan
than 0.2 (the DSM fisheye image is overlaid on top of the GSV image in both examples, where the sky
0.2(theDSMfisheyeimageisoverlaidontopoftheGSVimageinbothexamples,wheretheskyand
and non-sky areas in the DSM fisheye image are shaded in green and red, respectively).
non-skyareasintheDSMfisheyeimageareshadedingreenandred,respectively).
To quantitatively assess the influence of vegetation presence on the discrepancies between the
Toquantitativelyassesstheinfluenceofvegetationpresenceonthediscrepanciesbetweenthe
GSV- and DSM-derived SVF estimates, we calculated the vegetation index of each GSV sample used
GSV-andDSM-derivedSVFestimates,wecalculatedthevegetationindexofeachGSVsampleused
in the comparison. The vegetation index here is defined as the fraction of the upper hemisphere
in the comparison. The vegetation index here is defined as the fraction of the upper hemisphere
occupied by pixels that are labeled as tree by SegNet (Figure 4). It is calculated in the same way as
occupiedbypixelsthatarelabeledastreebySegNet(Figure4). Itiscalculatedinthesamewayas
SVF (Equations (6)–(8)), the only difference being that the integral function (Equation (6)) operates
SVF(Equations(6)–(8)),theonlydifferencebeingthattheintegralfunction(Equation(6))operates
on tree pixels instead of sky pixels. The vegetation index also falls in the range of 0 to 1. We plotted
ontreepixelsinsteadofskypixels. Thevegetationindexalsofallsintherangeof0to1. Weplotted
the vegetation index against the absolute difference in SVF (Figure 9a) and found that there was not
thevegetationindexagainsttheabsolutedifferenceinSVF(Figure9a)andfoundthattherewasnot
a significant correlation. However, we observed that the discrepancy tends to increase with the GSV
asignificantcorrelation. However,weobservedthatthediscrepancytendstoincreasewiththeGSV
vegetation index when the GSV vegetation index is in the range of 0.1–0.5. We then sorted the
vegetationindexwhentheGSVvegetationindexisintherangeof0.1–0.5. Wethensortedthesamples
samples in descending order of GSV vegetation index and incrementally filtered out samples with a
in descending order of GSV vegetation index and incrementally filtered out samples with a GSV
GSV vegetation index greater than a cut-off threshold. We found that the correlation coefficient
vegetationindexgreaterthanacut-offthreshold. Wefoundthatthecorrelationcoefficientmaximized
maximized at 0.8931 (Figure 9b) when the cut-off threshold was 0.1. This means the correlation
at0.8931(Figure9b)whenthecut-offthresholdwas0.1.Thismeansthecorrelationcoefficientincreased
coefficient increased from 0.8639 to 0.8931 when the samples with a GSV vegetation index greater
from0.8639to0.8931whenthesampleswithaGSVvegetationindexgreaterthan0.1werefilteredout
than 0.1 were filtered out (Figure 9) and implies that vegetation might affect the difference between
(Figure9)andimpliesthatvegetationmightaffectthedifferencebetweentheGSV-andDSM-derived
the GSV- and DSM-derived SVF estimates.
SVFestimates.

RemoteSens.2017,9,411 12of17
Remote Sens. 2017, 9, 411 12 of 17
FFiigguurree 99.. PPootteennttiiaall iinnfflluueennccee ooff vveeggeettaattiioonn pprreesseennccee oonn tthhee ddiissccrreeppaanncciieess bbeettwweeeenn tthhee GGSSVV-- aanndd
DDSSMM--ddeerriivveedd SSVVFF eessttiimmaatteess:: ((aa)) rreellaattiioonnsshhiipp bbeettwweeeenn tthhee vveeggeettaattiioonn iinnddeexx aanndd tthhee ddiiffffeerreennccee iinn SSVVFF;;
((bb)) rreellaattiioonnsshhiipp bbeettwweeeenn tthhee GGSSVV-- aanndd DDSSMM--ddeerriviveedd SSVVFF eestsitmimaatetse safatfetre rfifiltletreirnign gouotu stasmamplpelse wswithit ha
GaSGVS Vvevgeegteattaiotino ninidnedxe x>0>.10.. 1.
33..22.. CCoommppaarriissoonn wwiitthh SSVVFF EEssttiimmaatteess ffrroomm aa HHiigghh--RReessoolluuttiioonn OOAAPP33DD
HHeerree wwee ccoommppaarree tthhee SSVVFF eesstitmimaatetess frforomm aa seste toof fTTSVSV stsrtereete tpapnaonroarmamasa swwithit hthtohsoes ferofmro ma
haihgihg-hre-rseosluoltuiotnio OnAOPA3PD3.D A.nA OnAOPA3PD3 Dthatht actocvoevrse ras daodwonwtonwtonw anreaar eoaf o4f5 4k5mk2m w2itwhi tah daatdaa vtaolvuomluem oef
6o4f 6G4BG wBaws apsreppreapreadre (dFi(gFuigreu r1e01).0 )T.hTe hoebolibqluiqeu aeirabiorbrnoern pehpohtoogtoragmrammemtreyt rwyaws apseprfeorrfmoremde dusuinsgin ga
qauqaudacdocpotpetre wrwithit hana nimimagaeg ererseosolulutitoionn oof faapppproroxximimaatetelyly 1100––2200 ccmm.. TThhee OOAAPP33DD ddaattaasseett wwaass ggeenneerraatteedd
uussiinngg SSkkyylliinnee PPhhoottoommeesshh..
Remote Sens. 2017, 9, 411 13 of 17
The comparison was made at the 30 street locations where panoramas were available from TSV.
One problem with TSV and BSV is that they provide coordinates in an undefined spatial reference
whose projection and datum information is confidential. To accurately match each panorama from
TSV to their corresponding location in the OAP3D, the position of the panorama in the OAP3D was
manually determined and then adjusted until it became difficult to observe the displacement. SVF
calculation on the OAP3D was performed using a computer graphics-based algorithm [18] by
rendering the OAP3D into an OpenGL cubemap, which was then transformed into a fisheye image.
The 30 street panoramas were reprojected into fisheye images for SVF calculation. Comparison
of the 30 automatically classified panoramas against the manually delineated reference data reveals
a classification accuracy of 98%. Visual inspections also suggest that the sky contours of the
automatically-delineated fisheye images closely match those of the OAP3D-derived virtual fisheye
images. Fitting the two sets of SVF estimates to a linear regression model resulted in an R2 of 0.9746.
This suggests there is a high agreement between the SVF values derived from the TSV panoramas
and those from the OAP3D (Figure 11). The full statistics is given in Table 3.
Table 3. Descriptive statistics of the OAP3D-Tencent Street View (TSV) comparison. SVF (OAP3D) is
assumed to be the true value variable in calculating the RMSE and MBE, although it remains unclear
which variable is actually more accurate.
Statistics SVF (OAP3D) SVF (TSV) SVF (TSV)–SVF (OAP3D)
F F i i g g u u r r e e 1 1 0 0 . . A A h h Mi i g g eh h a- - rn r e e s s o o l l u u t t i i o o n n O O A A P P 3 3 D D c c o o v v e e r r 0s s .5a a 4 d d o o w w n n t t o o w w n n a a r0 r e e .5a a 3 o o f f 4 4 5 5 k k m m 22 i i n n i i n n t t h h e− e 0c c .i0 i t t 8y y o o f f W W e e i i h h a a i i
(
(
3
3
7
7
.
.
5
5
1
1
3
31
1°◦N
N
,
,
1
1
M2
2
2
2
a.
.
x1
1
i2
2
m0
0
4
4
u°◦mE
E
)
)
,
,
C
C
h
h
i
i
n
n
a
a
.
.
0.17 0.30 −0.17
Minimum 0.84 0.72 −0.03
Standard deviation 0.14 0.10 0.03
Root mean square error (RMSE) 0.0878
Mean bias error (MBE) −0.0821
Correlation coefficient (R) 0.9872
Figure 11. Relationship between the TSV- and OAP3D-derived SVF estimates.
3.3. Application in Manhattan
Manhattan is the most densely populated area in New York City. A road map of New York City
was downloaded from http://gis.ny.gov/gisdata/inventories/ [47]. Road segments within the
Manhattan Borough was extracted from the road map. The resulting road map of the Manhattan
Borough has 12,528 segments totaling 1,049,285 m in length. Queries and requests of street view
images were performed at the center point of each road segment. A total of 11,709 panoramas were
reconstructed using 58,545 street view images retrieved from GSV. The sampling spacing is
approximately 100 m along each street. All of these panoramas were classified using Segnet. The
classified panoramas were then reprojected into fisheye images for SVF estimation. A shapefile was
created from the resulting set of SVF estimates for mapping and analysis (Figure 12). Figure 12
shows the spatial pattern of the SVF in Manhattan. The southern tip of Manhattan, which is the

Remote Sens. 2017, 9, 411 13 of 17
RemoteSens.2017,9,411 13of17
Thecomparisonwasmadeatthe30streetlocationswherepanoramaswereavailablefromTSV.
OneproblemwithTSVandBSVisthattheyprovidecoordinatesinanundefinedspatialreference
whoseprojectionanddatuminformationisconfidential. Toaccuratelymatcheachpanoramafrom
TSV to their corresponding location in the OAP3D, the position of the panorama in the OAP3D
wasmanuallydeterminedandthenadjusteduntilitbecamedifficulttoobservethedisplacement.
SVFcalculationontheOAP3Dwasperformedusingacomputergraphics-basedalgorithm[18]by
renderingtheOAP3DintoanOpenGLcubemap,whichwasthentransformedintoafisheyeimage.
The30streetpanoramaswerereprojectedintofisheyeimagesforSVFcalculation. Comparisonof
the 30 automatically classified panoramas against the manually delineated reference data reveals
a classification accuracy of 98%. Visual inspections also suggest that the sky contours of the
automatically-delineatedfisheyeimagescloselymatchthoseoftheOAP3D-derivedvirtualfisheye
images. FittingthetwosetsofSVFestimatestoalinearregressionmodelresultedinanR2of0.9746.
ThisFsuiggugrees t1s0.t hAe rheigish-arehsioglhutaiognr eOemAPe3nDt bceotvweerse na tdhoewSnVtoFwvna laureesa doef r4iv5 ekdmf2r oinm itnh tehTe ScVityp aonf oWraemihaais and
those(3f7r.o5m131th°Ne,O 12A2P.132D04°(EF)i,g Cuhrein1a1. ). ThefullstatisticsisgiveninTable3.
FFiigguurree 1111.. RReellaattiioonnsshhiipp bbeettwweeeenn tthhee TTSSVV-- aanndd OOAAPP33DD--ddeerriivveedd SSVVFF eessttiimmaatteess..
3.3. ATpapbllieca3t.ioDne sincr Miptaivnehasttatatins ticsoftheOAP3D-TencentStreetView(TSV)comparison.SVF(OAP3D)is
assumedtobethetruevaluevariableincalculatingtheRMSEandMBE,althoughitremainsunclear
Manhattan is the most densely populated area in New York City. A road map of New York City
whichvariableisactuallymoreaccurate.
was downloaded from http://gis.ny.gov/gisdata/inventories/ [47]. Road segments within the
Manhattan BorSotuatgihst iwcsas extracted fSrVomF( OthAeP r3oDa)d mapS.V TFh(eT SrVes)ultingS rVoFa(dT SmVa)p–S oVfF t(hOeA MP3aDn)hattan
Borough has 12,528 segments totaling 1,049,285 m in length. Queries and requests of street view
Mean 0.54 0.53 −0.08
images were pMerafxoirmmuemd at the center poin0.t1 o7f each road se0g.3m0ent. A total of 11,7−009. 1p7anoramas were
reconstructed Musininimg um58,545 street view 0.i8m4ages retrieve0d.7 2from GSV. The s−am0.p03ling spacing is
approximaSttealnyd 1a0rd0 dmev aialtoionng each street. 0A.1l4l of these pano0.r1a0mas were classified0 .u03sing Segnet. The
Rootmeansquareerror(RMSE) 0.0878
classified panoramas were then reprojected into fisheye images for SVF estimation. A shapefile was
Meanbiaserror(MBE) −0.0821
created from the resulting set of SVF estimates for mapping and analysis (Figure 12). Figure 12
Correlationcoefficient(R) 0.9872
shows the spatial pattern of the SVF in Manhattan. The southern tip of Manhattan, which is the
3.3. ApplicationinManhattan
ManhattanisthemostdenselypopulatedareainNewYorkCity. AroadmapofNewYorkCity
was downloaded from http://gis.ny.gov/gisdata/inventories/ [47]. Road segments within the

RemoteSens.2017,9,411 14of17
Manhattan Borough was extracted from the road map. The resulting road map of the Manhattan
Borough has 12,528 segments totaling 1,049,285 m in length. Queries and requests of street view
images were performed at the center point of each road segment. A total of 11,709 panoramas
were reconstructed using 58,545 street view images retrieved from GSV. The sampling spacing
is approximately 100 m along each street. All of these panoramas were classified using Segnet.
TheclassifiedpanoramaswerethenreprojectedintofisheyeimagesforSVFestimation. Ashapefile
wascreatedfromtheresultingsetofSVFestimatesformappingandanalysis(Figure12). Figure12
Remote Sens. 2017, 9, 411 14 of 17
showsthespatialpatternoftheSVFinManhattan. ThesoutherntipofManhattan,whichisthecentral
businessdistrict,isdominatedbylowerSVFvaluesintherangeof0–0.17(bluecolor). TheSVFvalues
central business district, is dominated by lower SVF values in the range of 0–0.17 (blue color). The
inthesouthernhalfappearmuchlowerthaninthenorthernhalf,duetothefactthattheformeris
SVF values in the southern half appear much lower than in the northern half, due to the fact that the
packedwithhigh-riseofficebuildingswhilethelatterisdominatedbyamixoflow-riseresidential
former is packed with high-rise office buildings while the latter is dominated by a mix of low-rise
andcommercialbuildings. ThehistogramrevealsthatmorethanfiftypercentoftheSVFvaluesare
residential and commercial buildings. The histogram reveals that more than fifty percent of the SVF
below0.4(Figure12).
values are below 0.4 (Figure 12).
FFiigguurree 1122..S pSaptaiatiladl isdtriisbtruitbiuontioonf thoef StVhFe eSsVtimF aetestsimdeartievse ddferroimve1d1 ,7fr0o9mG S1V1,p7a0n9 orGaSmVa spinanMoraanmhaatst ainn.
Manhattan.
Computational performance is critical for big data analytics. Classification was the most
time-Ccoonmspuumtaintigonpaalr tpienrftohremparnecsee nitse dcrwitiocrakl flfoowr .bTigh edtaetsat sawnaerlyetircusn. oCnlaassmifiaccahtiionne wwiatsh ttwheo mInoteslt
Xtiemoen-cpornoscuemssionrgs (pEa5r-t2 i6n3 0th)ea npdreaseNnVteIdD wIAorQkuflaodwr.o TKh4e2 t0e0stgsr awpehriec srucnar don. Wa emraacnhiSneeg Nweitths etwpaor aItnetleyl
iXnetohne pCrPoUcesasnodrsG (EP5U-2(6C3U0)D aAnd)m a oNdVeItDoIcAla Qssuifaydtrhoe K1412,70009 g1ra0p24h-ibcsy -c1a0r2d4. Wpaen roarna mSeagsN. Uetn sdeepratrhaeteClyP iUn
mthoe dCeP,iUt taonodk aGbPoUu t(3C0UhDtAo)c momodpele tteo tchlaestsaisfyk ,trheep 1o1rt,7in0g9 a10p2r4o-cbeys-s1i0n2g4t ipmaneoorfaambaosu. tU1n0dsepr etrheim CaPgUe.
Umnoddeer, tiht etoGoPk Uabmouodt e3,0i tht otoo kcoomnlpyle3the tthoec otamskp,l erteeptohretisnagm ae pwroocrkeslosiandg, rteimpoer toifn gabaopurto 1c0e sss ipnegr tiimmaegoef.
aUbnoduetr1 thsep GerPiUm magoed.eIn, ita tporoekv oionulys 3st hu dtoy c(oYminpalnetde Wthaen sgam20e1 w6)o,rtkwlooadda, yrsepwoerrteinsgp ae nptroclcaessssiifnygin tgim3e5 9o2f
1a6b6o4u-bt y1 -s8 3p2erG iSmVapgae.n Ionr aam parsevuisoiungs satuSdVyM (Yminac ahninde Wleaanrngi n20g1a6l)g, otwritoh mda,yrse pwoerrtien sgpaenptr occlaessssiifnygintgim 3e59o2f
21066s4t-oby2-m83i2n GpSerVi mpaangoer.aTmhaiss iumspinlige sa SSeVgMNe mtiascahihnieg hlelyarenfifincgie anltgcolraisthsimfie, rreepvoenrtiwngh ean prruonceinsstihneg CtiPmUe
mofo 2d0e ,s atloth 2o mugihn wpeitrh imCUagDeA. Tshuips pimorptliitecs aSnegadNdeitt iiosn aa lhlyigghalyin eaff1ic0i×enitn cclraesassifeieinr esvpeened w. hen run in the
CPU mode, although with CUDA support it can additionally gain a 10x increase in speed.
4. Discussion
4. Discussion
More comparisons are needed to further understand the uncertainties associated with street
viewMpaonroe rcaommap-baarsiseodnSsV aFree sntiemedateido ntoin fduirftfheerer nutnadreearsstaanndd ctohnet euxntsc.erIttawinotuields absesmocoiaretecdo nwviitnhc isntgreteot
dviireewct lpyacnoomrapmaare-btahseedpr SoVpoFs eesdtimmeatthioond iang daiinffsetrhenemt aisrepahse raincdal cpohnotteoxgtsr.a pIth wy.ould be more convincing
to directly compare the proposed method against hemispherical photography.
GPS positioning errors need to be considered in street view panorama-based SVF estimation. In
the comparison with the DSM-based approach, the GSV coordinates were directly used to calculate
the SVF values on the DSM and hence the difference could be susceptible to positional errors. Future
work will be needed to quantitatively evaluate the influence of GPS positional errors on the SVF
estimation accuracy.
A spatially continuous SVF map is a raster in which each cell value represents an area-averaged
SVF. In some places, small alleys and lanes can significantly lower the area-averaged SVF. As small
alleys and lanes may not be well represented in street view imagery, area-averaged SVF calculated
using the approach needs to be treated carefully.

RemoteSens.2017,9,411 15of17
GPS positioning errors need to be considered in street view panorama-based SVF estimation.
InthecomparisonwiththeDSM-basedapproach,theGSVcoordinatesweredirectlyusedtocalculate
theSVFvaluesontheDSMandhencethedifferencecouldbesusceptibletopositionalerrors. Future
work will be needed to quantitatively evaluate the influence of GPS positional errors on the SVF
estimationaccuracy.
AspatiallycontinuousSVFmapisarasterinwhicheachcellvaluerepresentsanarea-averaged
SVF.Insomeplaces,smallalleysandlanescansignificantlylowerthearea-averagedSVF.Assmall
alleysandlanesmaynotbewellrepresentedinstreetviewimagery,area-averagedSVFcalculated
usingtheapproachneedstobetreatedcarefully.
Attention should be paid to the temporal variations in tree canopies. In temperate climates,
deciduoustreeslosealloftheirleavesinwinter,andthustheSVFvaluescouldbesignificantlysmaller
thanthoseinsummer. Urbanforestrycouldalsogreatlychangetreecanopycoverageinstreetsatthe
annualanddecadaltimescale. Streetviewphotographsarebeingupdatedregularlythroughoutthe
fourseasons,andhencethedynamicsoftreecanopiesshouldbeconsideredespeciallyinurbanareas
ofdensetreecover.
ThestreetviewAPIsdonotreturnthedateofacquisition. TheupdatefrequencyofGoogleStreet
Viewimageryvariesfromplacetoplace.TheCardiffDSMdatasetwasderivedfromsurveyscarriedout
overseveralyears. Asbothdatasetsrepresentamixtureoftemporalinformation,urbandevelopment
andlandscapechangesovertheperiodofdataacquisitioncouldhavecontributedtothediscrepancies
inthecomparison.
High-resolutionLiDARandOAP3DdatacanprovidecontinuousSVFestimatesacrossanurban
landscape, but the acquisition and processing costs associated with LiDAR and oblique airborne
photogrammetryaresohighthatsuchdataremainscarcelyavailabletothepublic. Spatiallyresolved
SVF data are traditionally difficult to acquire due to the poor data availability of high-resolution
urbanmodels. Webelievethattheproposedmethodhasgreatpotentialtoimprovetheavailability
of spatially resolved SVF data worldwide. When high-resolution urban models are not available,
theproposedmethodcanserveasalow-costalternativeforSVFestimation. Hence,itwillgreatly
benefiturbanclimateandplanningresearchinthelongrun.
5. Conclusions
ThisstudyhasexploredthepossibilityofautomaticallyextractingSVFinformationfrommassive
amountsofstreetviewphotographs,whicharepubliclyavailablemainlythroughthreeproviders,
Baidu,Tencent,andGoogle. Astate-of-the-artdeeplearningframework,SegNet,wasintegratedinto
theproposedworkflowforclassifyingstreetviewpanoramas. Thecomparisonswiththemanually
delineatedimagesshowedthatSegNetcouldachieveanaverageclassificationaccuracyof92–98%
for sky pixels. The classification accuracy varies from image to image in the range of 80–99%.
ThissuggeststhattherobustnessofSegNetneedsfurtherimprovement, whichcouldbeachieved
withmoreaccuratelylabeledtrainingimages. IthasbeenshownthroughtheManhattanexample
that the proposed method can effectively scale to big data volumes with adequate GPU support.
ThecomparisonsdemonstratedthecapacityofthemethodtoprovidereliableSVFestimates. However,
furtherdevelopmentisneededbeforethisapproachcanbepracticallyappliedtourbanclimateand
urbanplanningresearch.
Acknowledgments: ThisresearchwassupportedandfundedbytheNationalNaturalScienceFoundationof
China(41371387)andtheOpenFundofKeyLaboratoryofUrbanLandResourcesMonitoringandSimulation,
MinistryofLandandResources(KF-2016-02-004).
AuthorContributions:JianmingLiangandJianhuaGongconceivedanddesignedthemethods;JianmingLiang
implementedthemethod;alltheauthorsreviewedandeditedthemanuscript.
ConflictsofInterest:Theauthorsdeclarenoconflictofinterest.

RemoteSens.2017,9,411 16of17
References
1. Oke,T.R.Canyongeometryandthenocturnalurbanheatisland: Comparisonofscalemodelandfield
observations.Int.J.Climatol.1981,1,237–254.[CrossRef]
2. Gal,T.;Lindberg,F.;Unger,J.Computingcontinuousskyviewfactorsusing3Durbanrasterandvector
databases:Comparisonandapplicationtourbanclimate.Theor.Appl.Climatol.2009,95,111–123.[CrossRef]
3. Lindberg,F.Modellingtheurbanclimateusingalocalgovernmentalgeo-database.Meteorol.Appl.2007,14,
263–274.[CrossRef]
4. Krüger,E.L.;Minella,F.O.;Rasia,F.Impactofurbangeometryonoutdoorthermalcomfortandairquality
fromfieldmeasurementsinCuritiba,Brazil.Build.Environ.2011,46,621–634.[CrossRef]
5. Johansson,E.Influenceofurbangeometryonoutdoorthermalcomfortinahotdryclimate:AstudyinFez,
Morocco.Build.Environ.2006,41,1326–1338.[CrossRef]
6. Eliasson,I.Theuseofclimateknowledgeinurbanplanning.Landsc.UrbanPlan.2000,48,31–44.[CrossRef]
7. Wei, R.; Song, D.; Wong, N.H.; Martin, M. Impact of Urban Morphology Parameters on Microclimate.
ProcediaEng.2016,169,142–149.[CrossRef]
8. Bourbia,F.;Boucheriba,F.Impactofstreetdesignonurbanmicroclimateforsemi-aridclimate(Constantine).
Renew.Energy2010,35,343–347.[CrossRef]
9. Unger, J. Intra-urban relationship between surface geometry and urban heat island: Review and new
approach.Clim.Res.2004,27,253–264.[CrossRef]
10. Nguyen,H.T.;Joshua,M.P.Incorporatingshadinglossesinsolarphotovoltaicpotentialassessmentatthe
municipalscale.Sol.Energy2012,86,1245–1260.[CrossRef]
11. Corripio,J.G.VectorialalgebraalgorithmsforcalculatingterrainparametersfromDEMsandsolarradiation
modellinginmountainousterrain.Int.J.Geogr.Inf.Sci.2003,17,1–23.[CrossRef]
12. Li,X.;Zhang,S.;Chen,Y.Errorassessmentofgrid-baseddiffusesolarradiationmodels.Int.J.Geogr.Inf.Sci.
2016,30,2032–2049.[CrossRef]
13. Yang,J.;Wong,M.S.;Menenti,M.;Nichol,J.Modelingtheeffectiveemissivityoftheurbancanopyusingsky
viewfactor.ISPRSJ.Photogramm.RemoteSens.2015,105,211–219.[CrossRef]
14. Yang, J.; Wong, M.S.; Menenti, M.; Nichol, J.; Voogt, J.; Krayenhoff, E.S.; Chan, P.W. Development of
animprovedurbanemissivitymodelbasedonskyviewfactorforretrievingeffectiveemissivityandsurface
temperatureoverurbanareas.ISPRSJ.Photogramm.RemoteSens.2016,122,30–40.[CrossRef]
15. Mandanici,E.; Conte,P.; Girelli,V.A.IntegrationofAerialThermalImagery, LiDARDataandGround
SurveysforSurfaceTemperatureMappinginUrbanEnvironments.RemoteSens.2016,8,880.[CrossRef]
16. Zakšek,K.;Oštir,K.;Kokalj,Ž.Sky-ViewFactorasaReliefVisualizationTechnique.RemoteSens.2011,3,
398–415.[CrossRef]
17. Souza, L.C.L.; Rodrigues, D.S.; Mendes, J.F.G. Sky-view factors estimation using a 3D-GIS extension.
InProceedingsofthe8thInternationalIBPSAConference,Eindhoven,TheNetherlands,11–14August2003.
18. Matzarakis,A.;Matuschek,O.Skyviewfactorasaparameterinappliedclimatology—Rapidestimationby
theSkyHeliosmodel.Meteorol.Z.2011,20,39–45.[CrossRef]
19. Hodul,M.;Knudby,A.;Ho,H.C.EstimationofContinuousUrbanSkyViewFactorfromLandsatDataUsing
ShadowDetection.RemoteSens.2016,8,568.[CrossRef]
20. Holmer,B.Asimpleoperativemethodfordeterminationofskyviewfactorsincomplexurbancanyonsfrom
fisheyephotographs.Meteorol.Z.1992,236–239.
21. Bradley,A.V.;Thornes,J.E.;Chapman,L.Amethodtoassessthevariationofurbancanyongeometryfrom
skyviewfactortransects.Atmos.Sci.Lett.2001,2,155–165.[CrossRef]
22. Moin,U.M.;Tsutsumi,J.I.Rapidestimationofskyviewfactoranditsapplicationtohumanenvironment.
J.Hum.Environ.Syst.2004,7,83–87.[CrossRef]
23. Svensson,M.K.Skyviewfactoranalysis–implicationsforurbanairtemperaturedifferences.Meteorol.Appl.
2004,11,201–211.[CrossRef]
24. Lindberg, F.; Grimmond, C.S.B. Continuous sky view factor maps from high resolution urban digital
elevationmodels.Clim.Res.2010,42,177–183.[CrossRef]
25. McAfee,A.;Brynjolfsson,E.;Davenport,T.H.;Patil,D.J.;Barton,D.Bigdata:Themanagementrevolution.
Harv.Bus.Rev.2012,90,61–67.

RemoteSens.2017,9,411 17of17
26. Al-Jarrah,O.Y.;Yoo,P.D.;Muhaidat,S.;Karagiannidis,G.K.;Taha,K.Efficientmachinelearningforbigdata:
Areview.BigDataRes.2015,2,87–93.[CrossRef]
27. Anguelov,D.;Dulong,C.;Filip,D.;Frueh,C.;Lafon,S.;Lyon,R.;Ogale,A.;Vincent,L.;Weaver,J.Google
StreetView:Capturingtheworldatstreetlevel.Computer2010,43,32–38.[CrossRef]
28. Google Street View (GSV). Available online: https://developers.google.com/maps/documentation/
streetview/(accessedon10February2017).
29. BaiduStreetView(BSV).Availableonline:http://lbsyun.baidu.com/index.php?title=static(accessedon
10February2017).
30. TencentStreetView(TSV).Availableonline:http://lbs.qq.com/panostatic_v1/(accessedon10February2017).
31. Carrasco-Hernandez,R.;Smedley,A.R.D.;Webb,A.R.UsingurbancanyongeometriesobtainedfromGoogle
StreetViewforatmosphericstudies:Potentialapplicationsinthecalculationofstreetleveltotalshortwave
irradiances.EnergyBuild.2015,86,340–348.[CrossRef]
32. Yin,L.;Wang,Z.Measuringvisualenclosureforstreetwalkability:Usingmachinelearningalgorithmsand
GoogleStreetViewimagery.Appl.Geogr.2016,76,147–153.[CrossRef]
33. Yin,L.;Cheng,Q.;Wang,Z.;Shao,Z.‘Bigdata’forpedestrianvolume:ExploringtheuseofGoogleStreet
Viewimagesforpedestriancounts.Appl.Geogr.2015,63,337–345.[CrossRef]
34. Li,X.;Zhang,C.;Li,W.;Ricard,R.;Meng,Q.;Zhang,W.Assessingstreet-levelurbangreeneryusingGoogle
StreetViewandamodifiedgreenviewindex.UrbanFor.UrbanGreen.2015,14,675–685.[CrossRef]
35. Rundle,A.G.;Bader,M.D.;Richards,C.A.;Neckerman,K.M.;Teitler,J.O.UsingGoogleStreetViewtoaudit
neighborhoodenvironments.Am.J.Prev.Med.2011,40,94–100.[CrossRef][PubMed]
36. LeCun,Y.;Bengio,Y.;Hinton,G.Deeplearning.Nature2015,521,436–444.[CrossRef][PubMed]
37. Shirley,P.;Ashikhmin,M.;Marschner,S.FundamentalsofComputerGraphics;CRCPress: BocaRaton,FL,
USA,2009.
38. Krizhevsky, A.; Hinton, G.E.; Sutskever, I. ImageNet Classification with Deep Convolutional Neural
Networks.InProceedingsofthe25thInternationalConferenceonNeuralInformationProcessingSystems,
LakeTahoe,NV,USA,3–6December2012.
39. Seide,F.;Li,G.;Chen,X.;Yu,D.FeatureengineeringinContext-DependentDeepNeuralNetworksfor
conversational speech transcription. In Proceedings of the 2011 IEEE Workshop on Automatic Speech
RecognitionandUnderstanding(ASRU),Waikoloa,HI,USA,11–15December2011.
40. Long,J.;Shelhamer,E.;Darrell,T.Fullyconvolutionalnetworksforsemanticsegmentation.InProceedingsof
the2015IEEEConferenceonComputerVisionandPatternRecognition,Boston,MA,USA,7–12June2015.
41. Badrinarayanan,V.;Kendall,A.;Cipolla,R.Segnet:Adeepconvolutionalencoder-decoderarchitecturefor
imagesegmentation.arXiv2015,arXiv:1511.00561.
42. SegNet Project Website. Available online: http://mi.eng.cam.ac.uk/projects/segnet/ (accessed on
1January2017).
43. SegNetSourceCodeRepository.Availableonline:https://github.com/alexgkendall/caffe-segnet(accessed
on1January2017).
44. Grimmond,C.S.B.;Potter,S.K.;Zutter,H.N.;Souch,C.Rapidmethodstoestimatesky-viewfactorsapplied
tourbanareas.Int.J.Climatol.2001,21,903–913.[CrossRef]
45. Hämmerle,M.;Gál,T.;Unger,J.;Matzarakis,A.Comparisonofmodelscalculatingtheskyviewfactorused
forurbanclimateinvestigations.Theor.Appl.Climatol.2011,105,521–527.[CrossRef]
46. Natural Resources Wales LiDAR Data. Available online: http://lle.gov.wales/Catalogue/Item/
LidarCompositeDataset/?lang=en(accessedon1January2017).
47. NewYorkStateGeographicInformationSystems(GIS)Clearinghouse. Availableonline: http://lle.gov.
wales/Catalogue/Item/LidarCompositeDataset/?lang=en(accessedon1January2017).
©2017bytheauthors. LicenseeMDPI,Basel,Switzerland. Thisarticleisanopenaccess
articledistributedunderthetermsandconditionsoftheCreativeCommonsAttribution
(CCBY)license(http://creativecommons.org/licenses/by/4.0/).